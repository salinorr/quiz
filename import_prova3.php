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
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    echo "✅ Conectado ao banco\n";
} catch (PDOException $e) {
    die('❌ Erro: ' . $e->getMessage());
}

$sql = file_get_contents(__DIR__ . '/prova3_40_questoes_casos_praticos.sql');
if (!$sql) die('❌ Arquivo SQL não encontrado');

// Remover comentários e SET commands que PDO não executa bem
$sql = preg_replace('/^--.*$/m', '', $sql);
$sql = preg_replace('/^SET\s+.*$/mi', '', $sql);

// Separar por statements
$statements = array_filter(array_map('trim', explode(';', $sql)));

$count = 0;
foreach ($statements as $stmt) {
    if (empty($stmt)) continue;
    try {
        $pdo->exec($stmt);
        if (stripos($stmt, 'INSERT') === 0) $count++;
        echo "✅ OK\n";
    } catch (PDOException $e) {
        echo "⚠️ " . $e->getMessage() . "\n";
    }
}

$total = $pdo->query("SELECT COUNT(*) FROM questoes q JOIN categorias c ON c.id = q.categoria_id WHERE c.nome = '🎯 Prova 3'")->fetchColumn();
echo "\n🎯 Prova 3 importada! Total de questões na categoria: {$total}\n";
echo '</pre>';
