<?php
include_once (__DIR__ . "/config.php");

// Fetch available routes from database
/*$query = "SELECT id, created_at FROM dss_route_history ORDER BY created_at DESC";
$result = $dbh->query($query);

$routes = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $routes[] = $row;
    }
}*/

try {
	$stmt = $dbh->prepare('SELECT id, timestamp FROM dss_cases ORDER BY timestamp DESC');
	$stmt->execute(array());

	$stored_route = $stmt->fetchAll(PDO::FETCH_ASSOC);
} 
catch (PDOException $e) {
	echo "fetch_delivery_demands". $e->getMessage();
}

// Load default solution from JSON
$solution_file = 'cvrp/cvrp_solution.json';
$solution_data = file_exists($solution_file) ? json_decode(file_get_contents($solution_file), true) : null;

if (!$solution_data || empty($solution_data['routes'])) {
    die("<h2>No Valid Routes Found</h2><p>The system could not find an optimal route.</p>");
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CVRP Optimized Route Plan</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Leaflet.js for Map -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        #map { 
			height: 500px; 
		}
		.card {
			padding: 0.5rem;	
		}
    </style>
</head>
<body>

<div class="container mt-4">
    <h4 class="text-center">CVRP Optimized Route Plan</h4>
    
    <!-- Route Selection Dropdown -->
    <div class="col-3 mb-3">
        <select id="routeSelector" class="form-select">
            <option value="">-- Select a Route --</option>
            <?php foreach ($stored_route as $route): ?>
                <option value="<?= htmlspecialchars($route['id']) ?>">
                    <?= "Route #" . htmlspecialchars($route['id']) . " - " . $route['timestamp'] ?>
                </option>
            <?php endforeach; ?>
        </select>
    </div>
	
	<hr>
		
    <!-- Route Summary -->
    <div class="col-3 card mb-3">
		<p><strong>Total Distance Covered:</strong> <span id="totalDistance"><?= number_format($solution_data['total_distance'], 2) ?></span> km</p>
		<p><strong>Total Pickup Load:</strong> <span id="totalPickup"><?= number_format($solution_data['total_pickup_load'], 2) ?></span> kg</p>
		<p><strong>Total Delivery Load:</strong> <span id="totalDelivery"><?= number_format($solution_data['total_delivery_load'], 2) ?></span> kg</p>
	</div>
	
    <div class="row justify-content-center mb-3">
        <div class="col-md-5">
            <!-- Route Details Table -->
            <table class="table table-bordered text-center">
                <thead class="thead-light">
                    <tr>
                        <th>Vehicle</th>
                        <th>Route</th>
                        <th>Delivery (kg)</th>
                        <th>Pickup (kg)</th>
                        <th>Distance (km)</th>
                    </tr>
                </thead>
                <tbody id="routeTableBody">
                    <!-- Data will be populated dynamically -->
                </tbody>
            </table>
        </div>

        <div class="col-md-7">
            <!-- Leaflet Map -->
            <div id="map"></div>
        </div>
    </div>
</div>

<script>
    var map = L.map('map').setView([<?= $solution_data['depot_coords'][0] ?>, <?= $solution_data['depot_coords'][1] ?>], 12);

    // Load OSM tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // Define Icons
    var depotIcon = L.icon({
        iconUrl: 'images/base.png',
        iconSize: [32, 32],
        iconAnchor: [16, 32],
        popupAnchor: [0, -32]
    });

    var deliveryIcon = L.icon({
        iconUrl: 'images/destination.png',
        iconSize: [30, 30],
        iconAnchor: [12, 24],
        popupAnchor: [0, -24]
    });

	var routes = <?= json_encode($solution_data['routes']); ?>;
	var depot_coords = <?= json_encode($solution_data['depot_coords']); ?>;
	updateTable(routes);
	updateMap(routes, depot_coords);
	
    // Handle Route Selection
    document.getElementById("routeSelector").addEventListener("change", function() {
        var routeId = this.value;
        if (!routeId) return;

        fetch("fetch_route.php?route_id=" + routeId)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    alert("Error: " + data.error);
                    return;
                }
				console.log(data.routes);
                updateTable(data.routes);
                updateMap(data.routes, data.depot_coords);
                document.getElementById("totalDistance").innerText = data.total_distance.toFixed(2);
                document.getElementById("totalPickup").innerText = data.total_pickup_load.toFixed(2);
                document.getElementById("totalDelivery").innerText = data.total_delivery_load.toFixed(2);
            })
            .catch(error => console.error("Fetch Error:", error));
    });

    function updateTable(routes) {
        var tbody = document.getElementById("routeTableBody");
        tbody.innerHTML = ""; 

        routes.forEach(route => {
            var row = `<tr>
                <td><strong>#${route.vehicle_id}</strong></td>
                <td>${route.route.map(step => `Location ${step.location_index}`).join("<br>")}</td>
                <td>${route.route.map(step => `${step.delivery_load.toFixed(2)} kg`).join("<br>")}</td>
                <td>${route.route.map(step => `${step.pickup_load.toFixed(2)} kg`).join("<br>")}</td>
                <td>${route.distance.toFixed(2)} km</td>
            </tr>`;
            tbody.innerHTML += row;
        });
    }

    function updateMap(routes, depotCoords) {
        map.eachLayer(layer => {
            if (layer instanceof L.Marker || layer instanceof L.Polyline) {
                map.removeLayer(layer);
            }
        });

        var markers = [];
        var colors = ['red', 'blue', 'green', 'purple', 'orange', 'brown', 'black', 'pink'];

        routes.forEach((route, idx) => {
			var latLngs = [];
			var routeColor = colors[idx % colors.length];

			route.route.forEach(step => {
				var lat = step.location_lat;
				var lng = step.location_lng;
				latLngs.push([lat, lng]);

				var markerIcon = step.location_index === 0 ? depotIcon : deliveryIcon; // Use depot icon for depot

				var marker = L.marker([lat, lng], { icon: markerIcon }).addTo(map);
				marker.bindPopup(`<strong>📍 Location ${step.location_index}</strong><br>
								  📦 Delivery: ${step.delivery_load.toFixed(2)} kg<br>
								  📥 Pickup: ${step.pickup_load.toFixed(2)} kg`);

				markers.push(marker);
			});

			// Draw polyline for the route
			L.polyline(latLngs, { color: routeColor, weight: 4, opacity: 0.8 }).addTo(map)
			  .bindPopup(`🚁 Drone ${route.vehicle_id} Route`);
		});

        var depotMarker = L.marker(depotCoords, { icon: depotIcon }).addTo(map).bindPopup("🏠 Depot (Base)");
        markers.push(depotMarker);
        map.fitBounds(L.latLngBounds(markers.map(m => m.getLatLng())));
    }
</script>

</body>
</html>
