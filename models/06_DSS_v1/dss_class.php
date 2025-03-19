<?php
include_once(__DIR__ . "/config.php");

class dss_class {
    private $gcs_lat;
    private $gcs_lng;
    private $distance_cache = [];

    public function __construct($dbh) {
        $this->_db = $dbh;
		// Fetch GCS coordinates
        $gcs_coordinates = $this->fetch_gcs_coordinates();
        list($this->gcs_lat, $this->gcs_lng) = explode(",", $gcs_coordinates);
    }

	public function filterOrders() {
		$pending_orders = $this->fetch_delivery_demands();
		$valid_orders = [];

		foreach ($pending_orders as $order) {
			$orderData = json_decode($order['order_data'], true);
			$logistics = $orderData['logistics'];

			$coordinates = "";
			$cargoWeight = 0;
			$cargoWeightPu = 0;
			$cargoWidth = 0;
			$cargoHeight = 0;
			$cargoDepth = 0;

			foreach ($logistics as $item) {
				switch ($item['name']) {
					case 'cargo_weight': 
						$cargoWeight = (float)$item['value']; 
						break;
					case 'cargo_weight_pu': 
						$cargoWeightPu = (float)$item['value']; 
						break;
					case 'cargo_width': 
						$cargoWidth = (float)$item['value']; 
						break;
					case 'cargo_height': 
						$cargoHeight = (float)$item['value']; 
						break;
					case 'cargo_depth': 
						$cargoDepth = (float)$item['value']; 
						break;
					case 'shipping_address_coordinates': 
						$coordinates = $item['value']; 
						break;
				}
			}

			// **Filtering orders with missing coordinates & weight/pickup**
			if (empty($coordinates) || ($cargoWeight == 0 && $cargoWeightPu == 0)) {
				$this->logMessage("Order {$order['id']} rejected: Missing coordinates or both delivery & pickup weight are 0.");
				continue;
			}

			// **Keep standard keys while integrating both delivery & pickup weights**
			$valid_orders[] = [
				'order_id' => $order['id'],
				'coordinates' => $coordinates,
				'cargo_weight' => $cargoWeight,   // Delivery weight
				'cargo_weight_pu' => $cargoWeightPu, // Pickup weight
				'cargo_length' => $cargoWidth,    // Assuming width = length
				'cargo_width' => $cargoDepth,     // Assuming depth = width
				'cargo_height' => $cargoHeight
			];
		}

		return $valid_orders;
	}


    public function filterDrones($filtered_orders) {
        $uav_data = $this->fetch_vehicles();
        $valid_uavs = [];

        foreach ($uav_data as $uav) {
            $uav_id = $uav['vehicle_id'];
            $max_weight = (float)$uav['capacity'];
            $max_distance = (float)$uav['max_distance'];
            $max_length = (float)$uav['max_cargo_length'];
            $max_width = (float)$uav['max_cargo_width'];
            $max_height = (float)$uav['max_cargo_height'];
            $can_handle_order = false;

            foreach ($filtered_orders as $order) {
                list($lat, $lng) = explode(",", $order['coordinates']);
                $distance = $this->getCachedDistance($lat, $lng);
                $rejection_reasons = [];

                if ($order['cargo_weight'] > $max_weight) {
                    $rejection_reasons[] = "Weight exceeded (Order: {$order['cargo_weight']}kg, UAV max: {$max_weight}kg)";
                }
                if (($distance * 2) > $max_distance) {
                    $rejection_reasons[] = "Distance exceeded (Round trip: " . ($distance * 2) . "km, UAV max: {$max_distance}km)";
                }
                if ($order['cargo_length'] > $max_length) {
                    $rejection_reasons[] = "Length exceeded (Order: {$order['cargo_length']}cm, UAV max: {$max_length}cm)";
                }
                if ($order['cargo_width'] > $max_width) {
                    $rejection_reasons[] = "Width exceeded (Order: {$order['cargo_width']}cm, UAV max: {$max_width}cm)";
                }
                if ($order['cargo_height'] > $max_height) {
                    $rejection_reasons[] = "Height exceeded (Order: {$order['cargo_height']}cm, UAV max: {$max_height}cm)";
                }

                if (empty($rejection_reasons)) {
                    // UAV is valid for this order
                    $valid_uavs[$uav_id] = [
                        'vehicle_id' => $uav_id,
                        'capacity' => $max_weight,
                        'max_distance' => $max_distance,
                        'max_cargo_length' => $max_length,
                        'max_cargo_width' => $max_width,
                        'max_cargo_height' => $max_height
                    ];
                    $can_handle_order = true;
                    break;
                } else {
                    $this->logMessage("UAV {$uav_id} rejected for Order {$order['order_id']}: " . implode(", ", $rejection_reasons));
                }
            }

            if (!$can_handle_order) {
                $this->logMessage("UAV {$uav_id} rejected: Cannot handle any remaining orders due to weight, distance, or dimensions.");
            }
        }

        return array_values($valid_uavs);
    }

    private function getCachedDistance($lat, $lng) {
        $key = "{$lat}_{$lng}";
        if (!isset($this->distance_cache[$key])) {
            $this->distance_cache[$key] = $this->haversineDistance($this->gcs_lat, $this->gcs_lng, $lat, $lng);
        }
        return $this->distance_cache[$key];
    }

    private function haversineDistance($lat1, $lon1, $lat2, $lon2) {
        $earthRadius = 6371;
        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);
        $a = sin($dLat / 2) * sin($dLat / 2) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLon / 2) * sin($dLon / 2);
        return 2 * $earthRadius * atan2(sqrt($a), sqrt(1 - $a));
    }

    private function logMessage($message) {
        echo $message . "\n"; // Console log
    }
	
	private function fetch_delivery_demands() {
	   try {
			$stmt = $this->_db->prepare('SELECT orders.* FROM orders WHERE orders.service_id=1 AND orders.order_status_id=2');
			$stmt->execute(array());
	
			return $stmt->fetchAll(PDO::FETCH_ASSOC);
		} 
		catch (PDOException $e) {
			echo "fetch_delivery_demands". $e->getMessage();
		}
	}
	
	public function fetch_gcs_coordinates() {
	   try {
			$stmt = $this->_db->prepare('SELECT coordinates FROM gcs WHERE 1');
			$stmt->execute(array());

			return $stmt->fetchColumn();
		} 
		catch (PDOException $e) {
			echo "fetch_delivery_demands". $e->getMessage();
		}
	}
	
	private function fetch_vehicles() {
		try {
			$stmt = $this->_db->prepare("
				SELECT d.id AS vehicle_id,
					MAX(CASE WHEN dad.attribute_id = (SELECT id FROM devices_attributes WHERE attribute = 'payload') THEN dad.value END) AS capacity,
					MAX(CASE WHEN dad.attribute_id = (SELECT id FROM devices_attributes WHERE attribute = 'autonomy') THEN dad.value END) AS max_distance,
					MAX(CASE WHEN dad.attribute_id = (SELECT id FROM devices_attributes WHERE attribute = 'max_cargo_length') THEN dad.value END) AS max_cargo_length,
					MAX(CASE WHEN dad.attribute_id = (SELECT id FROM devices_attributes WHERE attribute = 'max_cargo_width') THEN dad.value END) AS max_cargo_width,
					MAX(CASE WHEN dad.attribute_id = (SELECT id FROM devices_attributes WHERE attribute = 'max_cargo_height') THEN dad.value END) AS max_cargo_height
				FROM devices d
				LEFT JOIN devices_attributes_devices dad ON d.id = dad.device_id
				WHERE d.active = 1
				GROUP BY d.id;
				");
							
			$stmt->execute(array());

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
		} 
		catch (PDOException $e) {
			echo "fetch_vehicles". $e->getMessage();
		}
	}	
}
?>
