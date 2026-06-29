<?php
$token = $_GET['token'] ?? '';
if ($token !== 'PMRR2026@fix') { http_response_code(403); die('Acesso negado.'); }

require_once __DIR__ . '/config.php';
header('Content-Type: text/html; charset=utf-8');
echo '<pre>';

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
$pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

// Listar todas as categorias
$cats = $pdo->query("SELECT c.id, c.nome, COUNT(q.id) AS total FROM categorias c LEFT JOIN questoes q ON q.categoria_id = c.id GROUP BY c.id ORDER BY c.id")->fetchAll(PDO::FETCH_ASSOC);
echo "Categorias encontradas:\n";
foreach ($cats as $c) echo "  ID={$c['id']} | {$c['nome']} | {$c['total']} questões\n";

// Remover categorias duplicadas sem questões
$dupes = $pdo->query("SELECT c.id FROM categorias c LEFT JOIN questoes q ON q.categoria_id = c.id WHERE c.nome = '🎯 Prova 3' GROUP BY c.id HAVING COUNT(q.id) = 0")->fetchAll(PDO::FETCH_COLUMN);
if ($dupes) {
    foreach ($dupes as $id) {
        $pdo->prepare("DELETE FROM categorias WHERE id = ?")->execute([$id]);
        echo "\n✅ Categoria vazia ID={$id} removida\n";
    }
} else {
    echo "\nNenhuma duplicata vazia encontrada.\n";
}
echo '</pre>';
