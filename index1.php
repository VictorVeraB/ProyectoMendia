<?php
$host = 'db';
$db   = getenv('DB_NAME') ?: 'miapp';
$user = getenv('DB_USER') ?: 'miusuario';
$pass = getenv('DB_PASSWORD') ?: 'miclave';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4",$user,$pass,[
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
    $ok = $pdo->query('SELECT 1')->fetchColumn();
    echo "<h1>PHP + Apache + MariaDB OK</h1>";
    echo "<p>Conexión a MariaDB: <strong>".($ok ? "Exitosa" : "Falló")."</strong></p>";
} catch (Throwable $e) {
    http_response_code(500);
    echo "<h1>Error de conexión</h1><pre>{$e->getMessage()}</pre>";
}
phpinfo(INFO_MODULES);
