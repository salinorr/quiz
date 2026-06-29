<?php
// ============================================================
// SETUP ADMIN — Executar UMA VEZ e apagar em seguida
// Acesso: https://cacresportes.com.br/quiz/setup_admin.php
// ============================================================
require_once __DIR__ . '/config.php';

$token = $_GET['token'] ?? '';
// Troque o token abaixo antes de fazer upload
define('SETUP_TOKEN', 'PMRR2026@setup');

if ($token !== SETUP_TOKEN) {
    http_response_code(403);
    die('<h2>Acesso negado. Informe ?token=PMRR2026@setup na URL.</h2>');
}

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
$pdo = new PDO($dsn, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

$action = $_POST['action'] ?? '';

if ($action === 'criar_admin') {
    $nome     = trim($_POST['nome']     ?? '');
    $guerra   = trim($_POST['guerra']   ?? '');
    $email    = trim($_POST['email']    ?? '');
    $matricula = trim($_POST['matricula'] ?? '');
    $senha    = $_POST['senha']         ?? '';
    $confirma = $_POST['confirma']      ?? '';

    $erros = [];
    if (strlen($nome) < 3)      $erros[] = 'Nome completo inválido.';
    if (strlen($guerra) < 2)    $erros[] = 'Nome de guerra inválido.';
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $erros[] = 'E-mail inválido.';
    if (!preg_match('/^\d{2}\.\d{3}-\d$/', $matricula)) $erros[] = 'Matrícula deve estar no formato XX.XXX-X.';
    if (strlen($senha) < 8)     $erros[] = 'Senha deve ter no mínimo 8 caracteres.';
    if ($senha !== $confirma)   $erros[] = 'Senhas não conferem.';

    if (empty($erros)) {
        $hash = password_hash($senha, PASSWORD_ARGON2ID);
        $stmt = $pdo->prepare("
            INSERT INTO militares (nome_completo, nome_guerra, email, matricula, senha_hash, status, is_admin)
            VALUES (?, ?, ?, ?, ?, 'aprovado', 1)
        ");
        try {
            $stmt->execute([$nome, $guerra, $email, $matricula, $hash]);
            echo '<div style="font-family:sans-serif;max-width:500px;margin:60px auto;background:#e8f5e9;border:2px solid #2e7d47;border-radius:12px;padding:28px">';
            echo '<h2 style="color:#1a5c2e">✅ Administrador criado!</h2>';
            echo "<p><strong>Nome de guerra:</strong> $guerra</p>";
            echo "<p><strong>E-mail:</strong> $email</p>";
            echo "<p><strong>Matrícula:</strong> $matricula</p>";
            echo '<p style="color:#c62828;font-weight:700">⚠️ APAGUE este arquivo do servidor imediatamente após criar o admin!</p>';
            echo '<p><a href="/quiz/">Ir para o Quiz</a></p></div>';
        } catch (PDOException $e) {
            $erros[] = 'Erro ao criar: ' . $e->getMessage();
        }
    }

    if (!empty($erros)) {
        echo '<div style="font-family:sans-serif;max-width:500px;margin:60px auto;background:#fff5f5;border:2px solid #c62828;border-radius:12px;padding:28px">';
        echo '<h2 style="color:#c62828">❌ Erros</h2><ul>';
        foreach ($erros as $e) echo "<li>$e</li>";
        echo '</ul></div>';
    }
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<title>Setup Admin — Quiz PMRR</title>
<style>
body { font-family: 'Segoe UI', sans-serif; background: #f4f6f8; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
.card { background: #fff; border-radius: 14px; padding: 36px; width: 440px; box-shadow: 0 4px 24px rgba(0,0,0,.12); }
h2 { color: #1a5c2e; margin-bottom: 8px; }
.alerta { background: #fff3cd; border: 1px solid #f9a825; border-radius: 8px; padding: 12px 16px; margin-bottom: 20px; font-size: .88rem; }
label { display: block; font-weight: 600; margin: 14px 0 5px; color: #1a5c2e; font-size: .9rem; }
input { width: 100%; padding: 11px 14px; border: 2px solid #c8e6c9; border-radius: 8px; font-size: .95rem; box-sizing: border-box; }
input:focus { outline: none; border-color: #2e7d47; }
button { margin-top: 20px; width: 100%; background: #2e7d47; color: #fff; border: none; border-radius: 10px; padding: 14px; font-size: 1rem; font-weight: 700; cursor: pointer; }
button:hover { background: #1a5c2e; }
</style>
</head>
<body>
<div class="card">
    <h2>🛡️ Criar Administrador</h2>
    <p style="color:#666;margin-bottom:16px;font-size:.88rem">Quiz PMRR — configuração inicial</p>
    <div class="alerta">⚠️ Execute este arquivo apenas uma vez e <strong>apague-o do servidor</strong> em seguida.</div>
    <form method="POST" action="?token=<?= htmlspecialchars($token) ?>">
        <input type="hidden" name="action" value="criar_admin">
        <label>Nome Completo</label>
        <input type="text" name="nome" required placeholder="Ex: Carlos Alberto da Costa Ramos">
        <label>Nome de Guerra</label>
        <input type="text" name="guerra" required placeholder="Ex: Ramos">
        <label>E-mail</label>
        <input type="email" name="email" required placeholder="admin@email.com">
        <label>Matrícula PM (formato: 40.xxx-x)</label>
        <input type="text" name="matricula" required placeholder="40.000-0" pattern="\d{2}\.\d{3}-\d">
        <label>Senha (mínimo 8 caracteres)</label>
        <input type="password" name="senha" required minlength="8">
        <label>Confirmar Senha</label>
        <input type="password" name="confirma" required>
        <button type="submit">Criar Administrador</button>
    </form>
</div>
</body>
</html>
