<?php
$token = $_GET['token'] ?? '';
if ($token !== 'PMRR2026@fix') { http_response_code(403); die('Acesso negado.'); }

require_once __DIR__ . '/config.php';
header('Content-Type: text/html; charset=utf-8');
echo '<pre>';

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
$pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

$catId = $pdo->query("SELECT id FROM categorias WHERE nome = '🎯 Prova 3' LIMIT 1")->fetchColumn();
$qId = $pdo->prepare("SELECT id FROM questoes WHERE categoria_id = ? AND enunciado LIKE '%Subtenente%Joana%CHO%' LIMIT 1");
$qId->execute([$catId]);
$questaoId = $qId->fetchColumn();

if (!$questaoId) { die("❌ Questão não encontrada\n"); }
echo "Questão ID: {$questaoId}\n";

// Buscar todas as respostas desta questão
$respostas = $pdo->prepare("SELECT r.id, r.sessao_id, r.acertou FROM respostas_usuario r WHERE r.questao_id = ?");
$respostas->execute([$questaoId]);
$rows = $respostas->fetchAll(PDO::FETCH_ASSOC);

echo "Respostas encontradas: " . count($rows) . "\n";

foreach ($rows as $r) {
    // Atualizar contadores da sessão
    if ($r['acertou']) {
        $pdo->prepare("UPDATE sessoes SET total_respondidas = GREATEST(total_respondidas-1,0), total_acertos = GREATEST(total_acertos-1,0) WHERE id = ?")->execute([$r['sessao_id']]);
    } else {
        $pdo->prepare("UPDATE sessoes SET total_respondidas = GREATEST(total_respondidas-1,0), total_erros = GREATEST(total_erros-1,0) WHERE id = ?")->execute([$r['sessao_id']]);
    }
    echo "  Sessão {$r['sessao_id']}: contador ajustado (acertou=" . ($r['acertou']?'sim':'não') . ")\n";
}

// Deletar as respostas
$del = $pdo->prepare("DELETE FROM respostas_usuario WHERE questao_id = ?");
$del->execute([$questaoId]);
echo "\n✅ {$del->rowCount()} resposta(s) removida(s). Questão Q8 voltará a aparecer na prova.\n";
echo '</pre>';
