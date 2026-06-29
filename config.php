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

define('SMTP_HOST',      $_ENV['SMTP_HOST']      ?? '');
define('SMTP_PORT',      (int)($_ENV['SMTP_PORT'] ?? 465));
define('SMTP_USER',      $_ENV['SMTP_USER']      ?? '');
define('SMTP_PASS',      $_ENV['SMTP_PASS']      ?? '');
define('SMTP_FROM',      $_ENV['SMTP_FROM']      ?? '');
define('SMTP_FROM_NAME', $_ENV['SMTP_FROM_NAME'] ?? 'Quiz PMRR');
