<?php

require __DIR__ . '/config.php';
$pdo = new PDO($dsn, $user, $password);

$id = $_POST["id"] ?? "";
$sql = "UPDATE tracks SET isFavorite = CASE WHEN isFavorite = 1 THEN 0 ELSE 1 END WHERE id = ?";
$stmt = $pdo->prepare($sql);
$stmt->execute([$id]);

echo json_encode(["success" => true]);
