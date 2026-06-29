<?php
$token = $_GET['token'] ?? '';
if ($token !== 'PMRR2026@fix') { http_response_code(403); die('Acesso negado.'); }

require_once __DIR__ . '/config.php';
header('Content-Type: text/html; charset=utf-8');
echo '<pre>';

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
$pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

$catId = $pdo->query("SELECT id FROM categorias WHERE nome = '🎯 Prova 3' LIMIT 1")->fetchColumn();

$enunciado = 'A Subtenente QEP PM Joana atingiu o tempo de serviço e a antiguidade necessários para o ingresso no Curso de Habilitação de Oficiais (CHO). Contudo, ela possui apenas o Ensino Médio completo. Ao publicar a convocação para a Academia, o Comando-Geral da PMRR, por meio de Portaria interna, negou a matrícula regular de Joana, permitindo sua participação apenas na condição administrativa de "ouvinte". À luz do Estatuto dos Militares (LC nº 194/2012), a recusa da matrícula como aluna regular é juridicamente correta?';

$opcao_a = 'Não, pois o requisito de escolaridade para ingresso de Subtenentes no Quadro Especial de Oficiais (QEO) por antiguidade exige apenas o Ensino Médio, sendo ilegal a recusa.';
$opcao_b = 'Sim. O Estatuto exige, de forma expressa, a comprovação de Curso Superior reconhecido pelo MEC no ato da matrícula no CHO. Como Joana não possui o diploma, a recusa de sua matrícula regular (que dá direito à promoção) está amparada na lei.';
$opcao_c = 'Não, pois o Estatuto prevê expressamente a figura do "aluno ouvinte" como uma modalidade de matrícula regular que garante a promoção a 2º Tenente com remuneração proporcional.';
$opcao_d = 'Sim, pois o ingresso no CHO ocorre exclusivamente mediante aprovação em novo concurso público de provas e títulos, não havendo ingresso por antiguidade para Praças.';
$opcao_e = 'Não, pois a lei determina que militares que atingem o tempo para o CHO e não possuem curso superior devem ser compulsoriamente promovidos e transferidos para a reserva remunerada.';

$explicacao = 'A questão exige atenção à diferença entre o texto da lei e os atos administrativos da Corporação. Conforme o Art. 22, §17, da LC nº 194/2012, o ingresso no Curso de Habilitação de Oficiais (CHO) exige obrigatoriamente "no ato da matrícula a comprovação de Curso Superior reconhecido ou autorizado pelo Ministério da Educação". Portanto, o Estatuto blinda a matrícula regular de quem não possui diploma. A condição de "ouvinte" não existe no Estatuto; ela é apenas uma solução administrativa criada pelo Comando-Geral por meio de Portarias (com base no poder de regulamentar o curso conferido pelo inciso I do mesmo parágrafo) para que os militares mais antigos sem nível superior possam assistir às instruções, mas sem adquirirem as prerrogativas legais de aluno oficial ou o direito à promoção.';

$referencia = 'Art. 22, §17, inciso I, da LC nº 194/2012';

$stmt = $pdo->prepare("UPDATE questoes SET enunciado=?, opcao_a=?, opcao_b=?, opcao_c=?, opcao_d=?, opcao_e=?, resposta_correta='B', explicacao=?, referencia_legal=? WHERE categoria_id=? AND enunciado LIKE '%Subtenente%Joana%CHO%'");
$stmt->execute([$enunciado, $opcao_a, $opcao_b, $opcao_c, $opcao_d, $opcao_e, $explicacao, $referencia, $catId]);

echo "✅ Questão atualizada: " . $stmt->rowCount() . " registro(s)\n";
echo '</pre>';
