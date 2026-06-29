<?php
$token = $_GET['token'] ?? '';
if ($token !== 'PMRR2026@prova3') {
    http_response_code(403);
    die('Acesso negado.');
}

require_once __DIR__ . '/config.php';

header('Content-Type: text/html; charset=utf-8');
echo '<pre style="font-family:monospace;background:#111;color:#0f0;padding:24px;">';

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
try {
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::MYSQL_ATTR_MULTI_STATEMENTS => true,
    ]);
    echo "✅ Conectado ao banco\n";
} catch (PDOException $e) {
    die('❌ Erro: ' . $e->getMessage());
}

$sql = file_get_contents(__DIR__ . '/prova3_40_questoes_casos_praticos.sql');
if (!$sql) die('❌ Arquivo SQL não encontrado');

try {
    $pdo->exec($sql);
    echo "✅ SQL executado com sucesso\n";
} catch (PDOException $e) {
    echo "❌ Erro: " . $e->getMessage() . "\n";
}

$total = $pdo->query("SELECT COUNT(*) FROM questoes q JOIN categorias c ON c.id = q.categoria_id WHERE c.nome = '🎯 Prova 3'")->fetchColumn();
echo "\n🎯 Prova 3: {$total} questões importadas\n";
echo '</pre>';
