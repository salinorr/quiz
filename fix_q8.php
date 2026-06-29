<?php
$token = $_GET['token'] ?? '';
if ($token !== 'PMRR2026@fix') { http_response_code(403); die('Acesso negado.'); }

require_once __DIR__ . '/config.php';
header('Content-Type: text/html; charset=utf-8');
echo '<pre>';

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
$pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

$novaExplicacao = 'Conforme o Art. 22, §17 da LC 194/2012, o ingresso no CHO exige, no ato da matrícula, a comprovação de Curso Superior reconhecido ou autorizado pelo MEC. Como Joana possui apenas o Ensino Médio, ela não atende ao requisito indispensável para matrícula regular.

📌 Justificativa 2 — Debate sobre Portaria vs Lei:
A Portaria que criou a figura do "ouvinte" NÃO contraria a Lei — pelo contrário, ela obedece à Lei. Pelo Princípio da Hierarquia das Normas, uma Portaria jamais pode se sobrepor a uma Lei Complementar. A corporação criou a condição de "ouvinte" justamente para NÃO matricular de forma regular quem não tem diploma superior.

Na prática, a Subtenente Joana como ouvinte: (1) Não está oficialmente matriculada como aluna do CHO; (2) Não adquire as prerrogativas de aluno oficial; (3) Não será promovida a 2º Tenente QEO ao final do curso, pois a promoção exige o preenchimento dos requisitos legais.

A exigência da Lei prevalece: se a banca perguntar se um Subtenente apenas com Ensino Médio preenche os requisitos para ingressar no CHO e ser promovido, a resposta é NÃO. A presença de "ouvintes" nas academias é apenas um fato administrativo que evidencia que a PM foi obrigada a barrar a matrícula oficial dessas praças por força da lei.';

$stmt = $pdo->prepare("UPDATE questoes SET explicacao = ? WHERE categoria_id = (SELECT id FROM categorias WHERE nome = '🎯 Prova 3' LIMIT 1) AND enunciado LIKE '%Subtenente QEP PM Joana%CHO%'");
$stmt->execute([$novaExplicacao]);
$affected = $stmt->rowCount();

echo "✅ Questões atualizadas: {$affected}\n";
echo '</pre>';
