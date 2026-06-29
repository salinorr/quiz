<?php
// Carrega variáveis do .env
$envFile = __DIR__ . '/.env';
if (!file_exists($envFile)) {
    die('Arquivo .env não encontrado. Copie .env.example para .env e preencha as credenciais.');
}
foreach (file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
    if (str_starts_with(trim($line), '#')) continue;
    if (strpos($line, '=') === false) continue;
    [$key, $value] = explode('=', $line, 2);
    $_ENV[trim($key)] = trim($value);
}

define('DB_HOST',    $_ENV['DB_HOST']);
define('DB_PORT',    $_ENV['DB_PORT']    ?? '3306');
define('DB_USER',    $_ENV['DB_USER']);
define('DB_PASS',    $_ENV['DB_PASS']);
define('DB_NAME',    $_ENV['DB_NAME']);
define('DB_CHARSET', $_ENV['DB_CHARSET'] ?? 'utf8mb4');
