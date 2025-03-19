<?php
include_once(__DIR__ . "/config.php");

$json_solution_path = __DIR__ . "/cvrp/cvrp_solution.json";

if (!file_exists($json_solution_path)) {
    die("Error: Solution file not found.");
}

$solution_json = file_get_contents($json_solution_path);
$solution_data = json_decode($solution_json, true);

if (!$solution_data) {
    die("Error: Could not decode solution JSON.");
}

foreach ($solution_data['routes'] as $route) {
    $query = "INSERT INTO dss_route_history (route_id, vehicle_id, stops, total_distance, total_pickup_load)
              VALUES (:route_id, :vehicle_id, :stops, :total_distance, :total_pickup_load)";

    $stmt = $dbh->prepare($query);
    $stmt->execute([
        ':route_id' => uniqid(),
        ':vehicle_id' => $route['vehicle_id'],
        ':stops' => json_encode($route['route']),
        ':total_distance' => $solution_data['total_distance'],
        ':total_pickup_load' => $solution_data['total_pickup_load']
    ]);
}

echo "Routes stored successfully.";
?>
