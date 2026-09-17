<?php

require __DIR__ . '/config.php';
$pdo = new PDO($dsn, $user, $password);

$id = $_POST["id"] ?? "";
$stmt = $pdo->prepare("DELETE FROM tracks WHERE id = ?");
$stmt->execute([$id]);

echo json_encode(["success" => true]);
