<?php
$t = $_GET['token'] ?? '';
if ($t !== 'PMRR2026@cleanup') { http_response_code(403); die('Negado.'); }
require_once __DIR__ . '/config.php';
$pdo = new PDO("mysql:host=".DB_HOST.";port=".DB_PORT.";dbname=".DB_NAME.";charset=utf8mb4", DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

// Mostrar estado atual
$cats = $pdo->query("SELECT id, nome, (SELECT COUNT(*) FROM questoes WHERE categoria_id=c.id) AS qtd FROM categorias c WHERE nome LIKE '%rova%' ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);
echo "<pre>Categorias 'Prova' encontradas:\n";
foreach ($cats as $c) echo "  id={$c['id']} nome='{$c['nome']}' questoes={$c['qtd']}\n";

// Manter apenas a categoria com questões; deletar as demais com 0 questões
$pdo->exec("DELETE FROM categorias WHERE (nome LIKE '%rova%') AND id NOT IN (SELECT DISTINCT categoria_id FROM questoes WHERE categoria_id IS NOT NULL)");
$deleted = $pdo->query("SELECT ROW_COUNT()")->fetchColumn();
echo "\nDeletadas: $deleted categorias vazias.\n";

// Renomear a que sobrou para nome limpo
$keep = $pdo->query("SELECT id FROM categorias WHERE nome LIKE '%rova%' LIMIT 1")->fetchColumn();
if ($keep) {
    $pdo->prepare("UPDATE categorias SET nome='🎯 Prova', descricao='Questões Revisadas — Estatuto (LC 194/2012) e CEDM/RR (Lei 963/2014)' WHERE id=?")->execute([$keep]);
    echo "Categoria id=$keep renomeada para '🎯 Prova'.\n";
}

// Estado final
echo "\nEstado final das categorias:\n";
$final = $pdo->query("SELECT id, nome, (SELECT COUNT(*) FROM questoes WHERE categoria_id=c.id) AS qtd FROM categorias c ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);
foreach ($final as $c) echo "  id={$c['id']} nome='{$c['nome']}' questoes={$c['qtd']}\n";
echo "</pre>OK";
