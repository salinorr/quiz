<?php
header('Content-Type: application/json');
ini_set('display_errors', '0');
error_reporting(E_ALL);

$result = [];

// 1. Verificar .env
$envFile = __DIR__ . '/.env';
$result['env_exists'] = file_exists($envFile);
if ($result['env_exists']) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    $result['env_lines'] = count($lines);
    foreach ($lines as $l) {
        if (strpos($l, '=') === false) continue;
        [$k] = explode('=', $l, 2);
        $result['env_keys'][] = trim($k);
    }
}

// 2. Testar config.php
try {
    require_once __DIR__ . '/config.php';
    $result['config_ok'] = true;
    $result['db_host'] = DB_HOST;
    $result['db_name'] = DB_NAME;
    $result['db_user'] = DB_USER;
    $result['db_pass_len'] = strlen(DB_PASS);
} catch (Throwable $e) {
    $result['config_ok'] = false;
    $result['config_error'] = $e->getMessage();
}

// 3. Testar conexão DB
try {
    $dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    $pdo->exec("SET time_zone = '-04:00'");
    $result['db_connected'] = true;
    $result['db_time'] = $pdo->query("SELECT NOW() AS t")->fetch(PDO::FETCH_ASSOC)['t'];
    $result['php_time'] = date('Y-m-d H:i:s');
    $result['user_count'] = (int)$pdo->query("SELECT COUNT(*) FROM militares")->fetchColumn();
} catch (Throwable $e) {
    $result['db_connected'] = false;
    $result['db_error'] = $e->getMessage();
}

echo json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
