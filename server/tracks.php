<?php

header("Content-Type: application/json");
require __DIR__ . '/config.php';

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(["error" => "Connection failed"]));
}

$sql = "SELECT * FROM tracks";
$result = $conn->query($sql);
$tracks = [];

while ($row = $result->fetch_assoc()) {
    $tracks[] = $row;
}

echo json_encode($tracks, JSON_PRETTY_PRINT);
$conn->close();
