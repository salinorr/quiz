<?php
header('Content-Type: application/json');
ini_set('display_errors', '0');
error_reporting(E_ALL);
ini_set('log_errors', '1');
ini_set('error_log', __DIR__ . '/logs/php_errors.log');

require_once __DIR__ . '/config.php';

$to = $_GET['to'] ?? 'salinorr@gmail.com';
$result = ['to' => $to, 'smtp_host' => SMTP_HOST, 'smtp_port' => SMTP_PORT, 'smtp_user' => SMTP_USER];

$subject = 'Teste SMTP — Quiz PMRR';
$body = "Este é um e-mail de teste do Quiz PMRR.\n\nSe você recebeu, o SMTP está funcionando!\n\nData: " . date('d/m/Y H:i:s');

// SMTP direto com log detalhado
$log = [];
$socket = @stream_socket_client('ssl://' . SMTP_HOST . ':' . SMTP_PORT, $errno, $errstr, 15);
if (!$socket) {
    $result['ok'] = false;
    $result['error'] = "Conexão falhou: $errstr ($errno)";
    echo json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    exit;
}

$read = function() use ($socket, &$log) {
    $r = fgets($socket, 512);
    $log[] = 'S: ' . trim($r);
    return $r;
};
$send = function(string $cmd) use ($socket, $read, &$log) {
    $safe = (strpos($cmd, 'AUTH') !== false || strlen($cmd) < 50) ? $cmd : substr($cmd, 0, 50) . '...';
    $log[] = 'C: ' . trim($safe);
    fwrite($socket, $cmd . "\r\n");
    return $read();
};

$read(); // banner
$send('EHLO cacresportes.com.br');
$resp = '';
while (strpos($resp, '250 ') !== 0) $resp = $read();

$send('AUTH LOGIN');
$send(base64_encode(SMTP_USER));
$resp = $send(base64_encode(SMTP_PASS));
if (strpos($resp, '235') !== 0) {
    $result['ok'] = false;
    $result['error'] = 'Auth falhou';
    $result['log'] = $log;
    fclose($socket);
    echo json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    exit;
}

$send('MAIL FROM:<' . SMTP_FROM . '>');
$send('RCPT TO:<' . $to . '>');
$send('DATA');

$msg  = "From: " . SMTP_FROM_NAME . " <" . SMTP_FROM . ">\r\n";
$msg .= "To: <{$to}>\r\n";
$msg .= "Subject: {$subject}\r\n";
$msg .= "MIME-Version: 1.0\r\n";
$msg .= "Content-Type: text/plain; charset=UTF-8\r\n";
$msg .= "Date: " . date('r') . "\r\n";
$msg .= "\r\n" . $body . "\r\n.";
$resp = $send($msg);
$send('QUIT');
fclose($socket);

$result['ok'] = strpos($resp, '250') === 0;
$result['log'] = $log;
echo json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
