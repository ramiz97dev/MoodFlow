<?php

$host = getenv('DB_HOST') ?: 'localhost';
$database = getenv('DB_NAME') ?: 'moodflow_db';
$user = getenv('DB_USER') ?: '';
$password = getenv('DB_PASSWORD') ?: '';

$dsn = "mysql:host={$host};dbname={$database};charset=utf8mb4";
