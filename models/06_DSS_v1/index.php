<?php
include_once(__DIR__ . "/config.php");
include_once("dss_class.php");

$dss_class = new dss_class($dbh);

// Step 1: Filter Orders
$orders = $dss_class->filterOrders();
if (empty($orders)) {
    echo "No valid orders available.";
    exit;
}

// Step 2: Filter UAVs based on valid orders
$uavs = $dss_class->filterDrones($orders);
 
if (empty($uavs)) {
    echo "No UAVs available for the current orders.";
    exit;
}

// Fetch GCS coordinates
$gcs_coordinates = $dss_class->fetch_gcs_coordinates();
list($gcs_lat, $gcs_lng) = explode(",", $gcs_coordinates);

// Re-index the array
$pending_orders = array_values($orders);

if(is_array($pending_orders) && !empty($pending_orders)) {
	$nodes = array();
	$demands = array();
	$demands[] = array(
		"location_index" => 0,
		"delivery_request" => 0,
		"pickup_request" => 0
	);
	
	$nodes[0]['lat'] = $gcs_lat;
	$nodes[0]['lng'] = $gcs_lng;

	foreach($pending_orders AS $key=>$value) {
		//$order_data = json_decode($pending_orders[$key]['order_data'], true);
		
		//start distances matrix creation
		list($lat, $lng) = explode(",", $pending_orders[$key]['coordinates']);
		$nodes[$key+1]['lat'] = $lat;
		$nodes[$key+1]['lng'] = $lng;
		
		// start demands array
		$demands[] = getDemandsWeight($pending_orders[$key], $key+1);
	}
}	

// Step 3: Generate Distance Matrix
$distances = generateDistanceMatrix($nodes);

// Ensure required demand keys are always set
$requiredKeys = ["delivery_request", "pickup_request"];
foreach ($demands as &$item) {
    foreach ($requiredKeys as $key) {
        if (!isset($item[$key]) || $item[$key] === null || $item[$key] === '') {
            $item[$key] = 0;
        }
    }
}

// Step 4: Generate CVRP JSON data

$uavs = array_values($uavs);

$cvrp_data = [
    'vehicles' => $uavs,
    'demands' => $demands, 
    'distances' => $distances,
    'depot' => 0,  // Depot is always location_index 0
    'coordinates' => []  //New field to store coordinates
];

// Add depot coordinates
$cvrp_data['coordinates'][0] = [(float)$gcs_lat, (float)$gcs_lng];

// Add coordinates for all orders
foreach ($pending_orders as $key => $order) {
    list($lat, $lng) = explode(",", $order['coordinates']);
    $cvrp_data['coordinates'][$key + 1] = [(float)$lat, (float)$lng];
}

// Save JSON data to `cvrp/cvrp.json`
$json_path = __DIR__ . "/cvrp/cvrp.json";
file_put_contents($json_path, json_encode($cvrp_data, JSON_PRETTY_PRINT));

echo "CVRP data saved to $json_path\n";

// Step 5: Execute Python script
/*$python_script = "model.py";
$command = "python $python_script 2>&1";
exec($command, $output, $return_var);
if ($return_var !== 0) {
    echo "Python script execution failed:\n";
    print_r($output);
    exit;
}*/

$exe_path = "C:\\xampp\\htdocs\\DSS\\model.exe"; // Adjust path if needed
$command = escapeshellcmd($exe_path . " 2>&1");

//exec($command, $output, $return_var);
exec($exe_path . " 2>&1", $output, $return_var);

if ($return_var === 0) {
    echo "Route optimization completed successfully!";
} else {
    echo "Error running model.exe: " . implode("\n", $output);
}

// Step 6: Save routes to the database
$solution_file = 'cvrp/cvrp_solution.json';
		
if (file_exists($solution_file)) {
    $solution_data = json_decode(file_get_contents($solution_file), true);
	
	$query = "INSERT INTO dss_cases (uuid, results_json) VALUES (:case_uuid, :results_json)";

	$stmt = $dbh->prepare($query);
	$stmt->execute([
		':case_uuid' => uniqid(),
		':results_json' => json_encode($solution_data)
	]);
	
	$dss_case_id = $dbh->lastInsertId();

	foreach ($solution_data['routes'] as $route) {
		$query = "INSERT INTO dss_route_history (route_id, dss_case_id, vehicle_id, stops, total_distance, total_pickup_load)
				  VALUES (:route_id, :dss_case_id, :vehicle_id, :stops, :total_distance, :total_pickup_load)";

		$stmt = $dbh->prepare($query);
		$stmt->execute([
			':route_id' => uniqid(),
			':dss_case_id' => $dss_case_id,
			':vehicle_id' => $route['vehicle_id'],
			':stops' => json_encode($route['route']),
			':total_distance' => $solution_data['total_distance'],
			':total_pickup_load' => $solution_data['total_pickup_load']
		]);
	}
}

header('Location: dss_results.php'); 
exit;

/**
 * Generates a distance matrix using Haversine distance.
 */
function generateDistanceMatrix($nodes) {
    $distances = [];
    $numNodes = count($nodes);

    for ($i = 0; $i < $numNodes; $i++) {
        for ($j = 0; $j < $numNodes; $j++) {
            if ($i != $j) {
                $distance = haversineDistance(
                    $nodes[$i]['lat'], $nodes[$i]['lng'],
                    $nodes[$j]['lat'], $nodes[$j]['lng']
                );
                $distances[] = [
                    'from_node' => $i,
                    'to_node' => $j,
                    'distance' => $distance
                ];
            }
        }
    }

    return $distances;
}

/**
 * Haversine formula to calculate distance between two coordinates.
 */
function haversineDistance($lat1, $lon1, $lat2, $lon2) {
    $earthRadius = 6371; // Radius of the Earth in km
    $dLat = deg2rad($lat2 - $lat1);
    $dLon = deg2rad($lon2 - $lon1);

    $a = sin($dLat / 2) * sin($dLat / 2) +
         cos(deg2rad($lat1)) * cos(deg2rad($lat2)) *
         sin($dLon / 2) * sin($dLon / 2);

    return 2 * $earthRadius * atan2(sqrt($a), sqrt(1 - $a));
}

/**
 * Retrieves shipping address coordinates.
 */
function getShippingAddressCoordinates($data) {
	if (isset($data['logistics'])) {
        foreach ($data['logistics'] as $logistic) {
            if ($logistic['name'] === 'shipping_address_coordinates') {
                return $logistic['value'];
            }
        }
    }
    return null;
}

/**
 * Extracts delivery and pickup demands from order data.
 */
function getDemandsWeight($data, $node) {
	$return_array = [];
	$return_array['location_index'] = $node;
	
	$delivery_order = 0;
	$pickup_order = 0;
	$return_array['delivery_request'] = (float)$data['cargo_weight'];
	$return_array['pickup_request'] = (float)$data['cargo_weight_pu'];

    return($return_array);
}
?>
