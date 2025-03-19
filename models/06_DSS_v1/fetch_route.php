<?php
include_once (__DIR__ . "/config.php");

if (!isset($_GET['route_id'])) {
    echo json_encode(["error" => "No route ID provided"]);
    exit;
}

$route_id = intval($_GET['route_id']);

$query = "SELECT results_json FROM dss_cases WHERE id = ?";
$stmt = $dbh->prepare($query);
$stmt->execute([$route_id]);
$result = $stmt->fetchColumn();

if ($stmt->rowCount() === 0) {
    echo json_encode(["error" => "Route not found"]);
    exit;
}

$route_data = json_decode($result, true);

if (!$route_data) {
    echo json_encode(["error" => "Invalid JSON data"]);
    exit;
}

echo json_encode($route_data);
?>
