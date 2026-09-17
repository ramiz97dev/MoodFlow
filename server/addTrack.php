<?php

require __DIR__ . '/config.php';
$pdo = new PDO($dsn, $user, $password);

$title = $_POST["title"] ?? "";
$mood = $_POST["mood"] ?? "";
$artist = $_POST["artist"] ?? "";
$track = $_POST["track"] ?? "";
$notes = $_POST["notes"] ?? "";
$imageUrl = null;

if (isset($_FILES["image"])) {
    $fileName = time() . "_" . basename($_FILES["image"]["name"]);
    $targetFile = "uploads/" . $fileName;

    if (move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) {
        $imageUrl = $targetFile;
    }
}

$sql = "INSERT INTO tracks (title, mood, artist, track, notes, date, imageUrl)
        VALUES (:title, :mood, :artist, :track, :notes, :date, :imageUrl)";
$stmt = $pdo->prepare($sql);
$stmt->execute([
    ":title" => $title,
    ":mood" => $mood,
    ":artist" => $artist,
    ":track" => $track,
    ":notes" => $notes,
    ":date" => date("Y-m-d H:i:s"),
    ":imageUrl" => $imageUrl
]);

echo json_encode(["success" => true]);
