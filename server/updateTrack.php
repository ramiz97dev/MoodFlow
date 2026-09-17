<?php

require __DIR__ . '/config.php';
$pdo = new PDO($dsn, $user, $password);

$id = $_POST["id"] ?? "";
$title = $_POST["title"] ?? "";
$mood = $_POST["mood"] ?? "";
$artist = $_POST["artist"] ?? "";
$track = $_POST["track"] ?? "";
$notes = $_POST["notes"] ?? "";

$sql = "UPDATE tracks SET title = ?, mood = ?, artist = ?, track = ?, notes = ? WHERE id = ?";
$stmt = $pdo->prepare($sql);
$stmt->execute([$title, $mood, $artist, $track, $notes, $id]);

echo json_encode(["success" => true]);
