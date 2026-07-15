<?php
// ============================================================
// QUIZ PMRR v2 — Sistema com autenticação e histórico
// ============================================================
declare(strict_types=1);
date_default_timezone_set('America/Boa_Vista');
ini_set('display_errors', '0');
ini_set('log_errors', '1');
ini_set('error_log', __DIR__ . '/logs/php_errors.log');
error_reporting(E_ALL);
require_once __DIR__ . '/config.php';

// ── Conexão ─────────────────────────────────────────────────
function getDB(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        try {
            $pdo = new PDO($dsn, DB_USER, DB_PASS, [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]);
            $offset = (new \DateTime())->format('P');
            $pdo->exec("SET time_zone = '{$offset}'");
        } catch (PDOException $e) {
            die('<div style="color:red;padding:20px;font-family:monospace">Erro de conexão: ' . htmlspecialchars($e->getMessage()) . '</div>');
        }
    }
    return $pdo;
}

// ── Garantir colunas (migração automática) ─────────────────
function ensureSessionTokenColumn(): void {
    static $done = false;
    if ($done) return;
    $cols = [
        "ALTER TABLE militares ADD COLUMN session_token    VARCHAR(64)  NULL",
        "ALTER TABLE militares ADD COLUMN remember_token   VARCHAR(64)  NULL",
        "ALTER TABLE militares ADD COLUMN remember_expires DATETIME     NULL",
        "ALTER TABLE militares ADD COLUMN reset_token      VARCHAR(64)  NULL",
        "ALTER TABLE militares ADD COLUMN reset_expires    DATETIME     NULL",
    ];
    $db = getDB();
    foreach ($cols as $sql) {
        try { $db->exec($sql); } catch (PDOException $e) { /* já existe */ }
    }
    $done = true;
}

// ── Garantir tabela de atividades (log de eventos) ──────────
function ensureAtividadesTable(): void {
    static $done = false;
    if ($done) return;
    try {
        getDB()->exec(
            "CREATE TABLE IF NOT EXISTS atividades (
                id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                militar_id INT             NOT NULL,
                evento     VARCHAR(40)     NOT NULL,
                detalhe    VARCHAR(255)    NULL,
                pagina     VARCHAR(40)     NULL,
                ip         VARCHAR(45)     NULL,
                criado_em  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
                INDEX idx_militar (militar_id, criado_em),
                INDEX idx_criado (criado_em)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"
        );
    } catch (PDOException $e) { /* já existe / sem permissão */ }
    $done = true;
}

// Dias de retenção do log de atividades (eventos mais antigos são removidos).
if (!defined('ATIVIDADES_RETENCAO_DIAS')) define('ATIVIDADES_RETENCAO_DIAS', 90);

// Remove atividades além do período de retenção. Roda no máximo 1x/hora (via sessão).
function purgarAtividadesAntigas(): void {
    if (isset($_SESSION['ultima_purga_ativ']) && (time() - $_SESSION['ultima_purga_ativ']) < 3600) return;
    $_SESSION['ultima_purga_ativ'] = time();
    try {
        $dias = (int)ATIVIDADES_RETENCAO_DIAS;
        getDB()->exec("DELETE FROM atividades WHERE criado_em < DATE_SUB(NOW(), INTERVAL $dias DAY)");
    } catch (PDOException $e) { /* best-effort */ }
}

// Monta cláusula WHERE + params para filtrar atividades por militar e período.
// Aceita data no formato YYYY-MM-DD (data_fim é inclusiva até o fim do dia).
function filtroAtividades(int $militarId, string $dataIni, string $dataFim): array {
    $cond = []; $params = [];
    if ($militarId > 0) { $cond[] = 'a.militar_id = ?'; $params[] = $militarId; }
    if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $dataIni)) { $cond[] = 'a.criado_em >= ?'; $params[] = $dataIni . ' 00:00:00'; }
    if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $dataFim)) { $cond[] = 'a.criado_em <= ?'; $params[] = $dataFim . ' 23:59:59'; }
    $where = $cond ? ('WHERE ' . implode(' AND ', $cond)) : '';
    return [$where, $params];
}

// Registra uma atividade do militar logado. Nunca lança exceção (best-effort).
function logAtividade(string $evento, ?string $detalhe = null, ?string $pagina = null): void {
    if (!isLogado()) return;
    try {
        getDB()->prepare(
            "INSERT INTO atividades (militar_id, evento, detalhe, pagina, ip) VALUES (?,?,?,?,?)"
        )->execute([
            militar()['id'],
            mb_substr($evento, 0, 40),
            $detalhe !== null ? mb_substr($detalhe, 0, 255) : null,
            $pagina  !== null ? mb_substr($pagina, 0, 40)   : null,
            $_SERVER['REMOTE_ADDR'] ?? null,
        ]);
    } catch (PDOException $e) { /* best-effort, não interrompe a página */ }
}

// ── "Lembrar-me" agora é apenas client-side (localStorage) ───
// Não faz auto-login — só preenche o campo de e-mail.

// ── Sessão ───────────────────────────────────────────────────
session_start();
ensureSessionTokenColumn();
ensureAtividadesTable();

function militar(): ?array {
    return $_SESSION['militar'] ?? null;
}
function isAdmin(): bool {
    return (bool)($_SESSION['militar']['is_admin'] ?? false);
}
function isLogado(): bool {
    return isset($_SESSION['militar']);
}
function isAprovado(): bool {
    return ($_SESSION['militar']['status'] ?? '') === 'aprovado';
}

// ── Verificação de unicidade de sessão ─────────────────────
function verifySessionToken(): void {
    if (!isset($_SESSION['militar'])) return;
    $token    = $_SESSION['militar']['token'] ?? null;
    $loginUrl = strtok($_SERVER['REQUEST_URI'], '?');
    $isPost   = $_SERVER['REQUEST_METHOD'] === 'POST';

    $expirar = function(string $msg, string $param = 'kicked') use ($isPost, $loginUrl): void {
        session_destroy();
        if ($isPost) {
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode(['erro' => $msg, 'session_expired' => true]);
            exit;
        }
        header('Location: ' . $loginUrl . '?p=inicio&' . $param . '=1');
        exit;
    };

    if (!$token) {
        $expirar('Sessão expirada. Faça login novamente.', 'kicked');
    }
    $db   = getDB();
    $stmt = $db->prepare("SELECT session_token, status, last_activity FROM militares WHERE id=? LIMIT 1");
    $stmt->execute([$_SESSION['militar']['id']]);
    $row  = $stmt->fetch();
    // Se registro não existe, token mudou ou usuário não está aprovado, expirar
    if (!$row || $row['session_token'] !== $token) {
        $expirar('Sua conta foi acessada em outro dispositivo. Faça login novamente.', 'kicked');
    }
    if (($row['status'] ?? '') !== 'aprovado') {
        $expirar('Seu cadastro não está aprovado. Contate o administrador.', 'kicked');
    }
    // Verificar inatividade de 10 minutos (server-side)
    if (!empty($row['last_activity'] ?? null)) {
        $lastAct = strtotime($row['last_activity']);
        if ($lastAct && (time() - $lastAct) > 600) {
            $db->prepare("UPDATE militares SET session_token=NULL, current_page=NULL WHERE id=?")->execute([$_SESSION['militar']['id']]);
            $expirar('Sessão expirada por inatividade (10 minutos). Faça login novamente.', 'timeout');
        }
    }
}
verifySessionToken();

// ── CSRF ─────────────────────────────────────────────────────
function csrfToken(): string {
    if (empty($_SESSION['csrf'])) {
        $_SESSION['csrf'] = bin2hex(random_bytes(24));
    }
    return $_SESSION['csrf'];
}

// ── Utilitários ───────────────────────────────────────────────
function e(string $s): string { return htmlspecialchars($s, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); }

function validaMatricula(string $m): bool {
    return (bool) preg_match('/^\d{2}\.\d{3}-\d$/', $m);
}

// ── Buscar sessões abertas do militar ──
function getOpenSessions(): array {
    if (!isLogado() || !isAprovado()) return [];
    $db = getDB();
    $stmt = $db->prepare(
        "SELECT s.id, s.tipo, s.numero_tentativa, s.total_respondidas,
                s.total_acertos, s.total_erros, s.categorias_nomes, s.created_at
         FROM sessoes s
         WHERE s.militar_id = ? AND s.finalizado_em IS NULL
         ORDER BY s.created_at DESC"
    );
    $stmt->execute([militar()['id']]);
    return $stmt->fetchAll();
}

function sendEmail(string $to, string $subject, string $body): bool {
    if (!SMTP_HOST || !SMTP_USER) return false;
    $socket = @stream_socket_client('ssl://' . SMTP_HOST . ':' . SMTP_PORT, $errno, $errstr, 10);
    if (!$socket) { error_log("SMTP connect failed: $errstr ($errno)"); return false; }
    $read = function() use ($socket) { return fgets($socket, 512); };
    $send = function(string $cmd) use ($socket, $read) {
        fwrite($socket, $cmd . "\r\n");
        return $read();
    };
    $read();
    $send('EHLO ' . ($_SERVER['HTTP_HOST'] ?? 'quiz.local'));
    $resp = '';
    while (strpos($resp, '250 ') !== 0) $resp = $read();
    $send('AUTH LOGIN');
    $send(base64_encode(SMTP_USER));
    $resp = $send(base64_encode(SMTP_PASS));
    if (strpos($resp, '235') !== 0) { error_log("SMTP auth failed: $resp"); fclose($socket); return false; }
    $send('MAIL FROM:<' . SMTP_FROM . '>');
    $send('RCPT TO:<' . $to . '>');
    $send('DATA');
    $headers  = "From: " . SMTP_FROM_NAME . " <" . SMTP_FROM . ">\r\n";
    $headers .= "To: <{$to}>\r\n";
    $headers .= "Subject: {$subject}\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/plain; charset=UTF-8\r\n";
    $headers .= "Date: " . date('r') . "\r\n";
    $headers .= "\r\n" . $body . "\r\n.";
    $resp = $send($headers);
    $send('QUIT');
    fclose($socket);
    return strpos($resp, '250') === 0;
}

function restoreSessaoByID(int $sessaoId): void {
    $db = getDB();
    $stmt = $db->prepare(
        "SELECT s.id, s.tipo, s.numero_tentativa, s.total_respondidas, s.categorias_nomes,
                GROUP_CONCAT(DISTINCT r.questao_id) AS respondidas_ids
         FROM sessoes s
         LEFT JOIN respostas_usuario r ON r.sessao_id = s.id
         WHERE s.id = ? AND s.militar_id = ? AND s.finalizado_em IS NULL
         GROUP BY s.id"
    );
    $stmt->execute([$sessaoId, militar()['id']]);
    $sessao = $stmt->fetch();
    if (!$sessao) return;

    // Categorias da sessão = as que foram SELECIONADAS ao criar (guardadas por nome),
    // reconstruídas para IDs. Não derivar só das questões já respondidas: numa sessão
    // recém-criada (0 respondidas) isso caía no fallback de "todas as categorias".
    $cats = [];
    if (!empty($sessao['categorias_nomes'])) {
        $nomes = array_values(array_filter(array_map('trim', explode(', ', $sessao['categorias_nomes'])), 'strlen'));
        if ($nomes) {
            $ph = implode(',', array_fill(0, count($nomes), '?'));
            $catStmt = $db->prepare("SELECT id FROM categorias WHERE nome IN ($ph)");
            $catStmt->execute($nomes);
            $cats = array_column($catStmt->fetchAll(), 'id');
        }
    }
    // Defensivo: inclui categorias de questões já respondidas (caso alguma tenha
    // sido renomeada após o início da sessão) sem duplicar.
    if ($sessao['respondidas_ids']) {
        $ids = explode(',', $sessao['respondidas_ids']);
        $ph = implode(',', array_fill(0, count($ids), '?'));
        $catStmt = $db->prepare("SELECT DISTINCT categoria_id FROM questoes WHERE id IN ($ph)");
        $catStmt->execute($ids);
        $cats = array_values(array_unique(array_merge($cats, array_column($catStmt->fetchAll(), 'categoria_id'))));
    }
    // Último recurso (não deveria ocorrer): sessão sem nomes e sem respostas.
    if (empty($cats)) {
        $cats = array_column($db->query("SELECT id FROM categorias")->fetchAll(), 'id');
    }

    $phCount = implode(',', array_fill(0, count($cats), '?'));
    $totalStmt = $db->prepare("SELECT COUNT(*) FROM questoes WHERE ativa=1 AND categoria_id IN ($phCount)");
    $totalStmt->execute($cats);
    $totalQ = (int)$totalStmt->fetchColumn();

    $_SESSION['sessao_id']      = $sessao['id'];
    $_SESSION['respondidas']    = $sessao['respondidas_ids'] ? array_map('intval', explode(',', $sessao['respondidas_ids'])) : [];
    $_SESSION['categorias']     = array_map('intval', $cats);
    $_SESSION['tipo_sessao']    = $sessao['tipo'];
    $_SESSION['total_questoes'] = $totalQ;
}

// Auto-restaurar apenas se houver exatamente 1 sessão aberta
$openSessions = getOpenSessions();
if (count($openSessions) === 1 && empty($_SESSION['sessao_id'])) {
    restoreSessaoByID((int)$openSessions[0]['id']);
}

// ── Categorias para tela inicial ─────────────────────────────
function getCategorias(): array {
    $db = getDB();
    $cats = $db->query(
        "SELECT c.id, c.nome, c.descricao, COUNT(q.id) AS total
         FROM categorias c
         LEFT JOIN questoes q ON q.categoria_id = c.id AND q.ativa = 1
         GROUP BY c.id"
    )->fetchAll();
    // Ordena para exibicao: categorias legadas (sem "CHO") primeiro, na ordem de
    // criacao; depois as disciplinas do CHO pela numeracao (CHO 01, 02, ... 20),
    // e nao pela ordem de id (que ficou fora de sequencia). Feito em PHP porque o
    // MySQL da hospedagem e anterior ao 8.0 (sem REGEXP_SUBSTR).
    usort($cats, function ($a, $b) {
        $numA = preg_match('/CHO\s*0*(\d+)/u', $a['nome'], $mA) ? (int) $mA[1] : null;
        $numB = preg_match('/CHO\s*0*(\d+)/u', $b['nome'], $mB) ? (int) $mB[1] : null;
        $keyA = [$numA === null ? 0 : 1, $numA ?? (int) $a['id'], (int) $a['id']];
        $keyB = [$numB === null ? 0 : 1, $numB ?? (int) $b['id'], (int) $b['id']];
        return $keyA <=> $keyB;
    });
    return $cats;
}

// ── Próximo número de tentativa ──────────────────────────────
function proximaTentativa(int $militarId, string $tipo): int {
    $db   = getDB();
    $stmt = $db->prepare("SELECT COALESCE(MAX(numero_tentativa),0)+1 FROM sessoes WHERE militar_id=? AND tipo=?");
    $stmt->execute([$militarId, $tipo]);
    return (int) $stmt->fetchColumn();
}

// ============================================================
// POST — API AJAX
// ============================================================
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json; charset=utf-8');
    $acao = $_POST['acao'] ?? '';

    // ── Cadastro ──────────────────────────────────────────
    if ($acao === 'cadastrar') {
        $nome     = trim($_POST['nome']      ?? '');
        $guerra   = trim($_POST['guerra']    ?? '');
        $email    = strtolower(trim($_POST['email'] ?? ''));
        $mat      = trim($_POST['matricula'] ?? '');
        $senha    = $_POST['senha']          ?? '';
        $confirma = $_POST['confirma']       ?? '';

        $erros = [];
        if (strlen($nome) < 3)   $erros[] = 'Nome completo deve ter ao menos 3 caracteres.';
        if (strlen($guerra) < 2) $erros[] = 'Nome de guerra inválido.';
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $erros[] = 'E-mail inválido.';
        if (!validaMatricula($mat)) $erros[] = 'Matrícula no formato XX.XXX-X (ex: 40.123-5).';
        if (strlen($senha) < 8)  $erros[] = 'Senha deve ter no mínimo 8 caracteres.';
        if ($senha !== $confirma) $erros[] = 'As senhas não conferem.';

        if (empty($erros)) {
            $db = getDB();
            $ck = $db->prepare("SELECT COUNT(*) FROM militares WHERE email=? OR matricula=?");
            $ck->execute([$email, $mat]);
            if ($ck->fetchColumn() > 0) {
                echo json_encode(['erro' => 'E-mail ou matrícula já cadastrado.']);
                exit;
            }
            $hash = password_hash($senha, PASSWORD_ARGON2ID);
            $ins  = $db->prepare("INSERT INTO militares (nome_completo,nome_guerra,email,matricula,senha_hash) VALUES (?,?,?,?,?)");
            $ins->execute([$nome, $guerra, $email, $mat, $hash]);
            echo json_encode(['ok' => true, 'msg' => 'Cadastro realizado! Aguarde a aprovação do administrador.']);
        } else {
            echo json_encode(['erro' => implode('<br>', $erros)]);
        }
        exit;
    }

    // ── Login ────────────────────────────────────────────
    if ($acao === 'login') {
        $email = strtolower(trim($_POST['email'] ?? ''));
        $senha = $_POST['senha'] ?? '';

        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($senha) < 1) {
            echo json_encode(['erro' => 'Dados inválidos.']); exit;
        }

        $db   = getDB();
        $stmt = $db->prepare("SELECT * FROM militares WHERE email=? LIMIT 1");
        $stmt->execute([$email]);
        $m    = $stmt->fetch();

        if (!$m || !password_verify($senha, $m['senha_hash'])) {
            echo json_encode(['erro' => 'E-mail ou senha incorretos.']); exit;
        }

        // Permitir login apenas se o cadastro estiver aprovado
        if (($m['status'] ?? '') !== 'aprovado') {
            if (($m['status'] ?? '') === 'pendente') {
                echo json_encode(['erro' => 'Cadastro em análise. Aguarde aprovação do administrador.', 'status' => 'pendente']);
            } else {
                echo json_encode(['erro' => 'Cadastro não autorizado (' . (($m['status'] ?? 'desconhecido')) . '). Entre em contato.', 'status' => $m['status'] ?? '']);
            }
            exit;
        }

        // Gerar token único, invalidar sessões anteriores e registrar atividade
        $token = bin2hex(random_bytes(32));
        $db->prepare("UPDATE militares SET session_token=?, last_activity=NOW(), current_page='inicio' WHERE id=?")->execute([$token, $m['id']]);

        session_regenerate_id(true);
        $_SESSION['militar'] = [
            'id'            => $m['id'],
            'nome_completo' => $m['nome_completo'],
            'nome_guerra'   => $m['nome_guerra'],
            'email'         => $m['email'],
            'matricula'     => $m['matricula'],
            'status'        => $m['status'],
            'is_admin'      => (bool) $m['is_admin'],
            'token'         => $token,
        ];
        echo json_encode(['ok' => true, 'guerra' => $m['nome_guerra'], 'status' => $m['status']]);
        exit;
    }

    // ── Logout ───────────────────────────────────────────
    if ($acao === 'logout') {
        if (isset($_SESSION['militar']['id'])) {
            getDB()->prepare("UPDATE militares SET session_token=NULL WHERE id=?")->execute([$_SESSION['militar']['id']]);
        }
        session_destroy();
        echo json_encode(['ok' => true]); exit;
    }

    // ── Esqueci senha (público) ──────────────────────────
    if ($acao === 'esqueci_senha') {
        $email = strtolower(trim($_POST['email'] ?? ''));
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo json_encode(['erro' => 'E-mail inválido.']); exit;
        }
        $db   = getDB();
        $stmt = $db->prepare("SELECT id, nome_guerra FROM militares WHERE email=? LIMIT 1");
        $stmt->execute([$email]);
        $m    = $stmt->fetch();
        if ($m) {
            $rToken  = bin2hex(random_bytes(32));
            $expires = date('Y-m-d H:i:s', time() + 3600);
            $db->prepare("UPDATE militares SET reset_token=?, reset_expires=? WHERE id=?")->execute([$rToken, $expires, $m['id']]);
            $host = $_SERVER['HTTP_HOST'] ?? 'cacresportes.com.br';
            $path = strtok($_SERVER['REQUEST_URI'], '?');
            $link = 'https://' . $host . $path . '?p=reset&token=' . $rToken;
            $subject = 'Recuperação de Senha — Portal de Cursos PMRR';
            $body    = "Olá, {$m['nome_guerra']}!\n\nClique no link para redefinir sua senha (válido por 1 hora):\n\n{$link}\n\nSe não solicitou, ignore este e-mail.\n\nPortal de Cursos PMRR — Roraima";
            if (!sendEmail($email, $subject, $body)) {
                error_log("Falha ao enviar e-mail de recuperacao para: $email");
            }
        }
        echo json_encode(['ok' => true, 'msg' => 'Se o e-mail estiver cadastrado, você receberá as instruções em breve.']);
        exit;
    }

    // ── Resetar senha (público) ──────────────────────────
    if ($acao === 'resetar_senha') {
        $rToken   = trim($_POST['token']   ?? '');
        $senha    = $_POST['senha']        ?? '';
        $confirma = $_POST['confirma']     ?? '';
        if (strlen($rToken) !== 64)  { echo json_encode(['erro' => 'Token inválido.']); exit; }
        if (strlen($senha) < 8)      { echo json_encode(['erro' => 'Senha deve ter no mínimo 8 caracteres.']); exit; }
        if ($senha !== $confirma)     { echo json_encode(['erro' => 'As senhas não conferem.']); exit; }
        $db   = getDB();
        $stmt = $db->prepare("SELECT id FROM militares WHERE reset_token=? AND reset_expires > NOW() LIMIT 1");
        $stmt->execute([$rToken]);
        $m    = $stmt->fetch();
        if (!$m) { echo json_encode(['erro' => 'Link expirado ou inválido. Solicite um novo.']); exit; }
        $hash = password_hash($senha, PASSWORD_ARGON2ID);
        $db->prepare("UPDATE militares SET senha_hash=?, reset_token=NULL, reset_expires=NULL, session_token=NULL WHERE id=?")->execute([$hash, $m['id']]);
        echo json_encode(['ok' => true, 'msg' => 'Senha redefinida! Faça login com a nova senha.']);
        exit;
    }

    // ─── A partir daqui: militar aprovado necessário ────────
    if (!isLogado() || !isAprovado()) {
        echo json_encode(['erro' => 'Acesso não autorizado.']); exit;
    }

    // ── Escolher sessão aberta para continuar ──────────────
    if ($acao === 'escolher_sessao') {
        $sessaoId = (int)($_POST['sessao_id'] ?? 0);
        if ($sessaoId <= 0) { echo json_encode(['erro' => 'Sessão inválida.']); exit; }
        restoreSessaoByID($sessaoId);
        if (empty($_SESSION['sessao_id'])) { echo json_encode(['erro' => 'Sessão não encontrada ou já finalizada.']); exit; }
        $db = getDB();
        $stmt = $db->prepare("SELECT total_respondidas, total_acertos, total_erros, tipo, numero_tentativa FROM sessoes WHERE id=?");
        $stmt->execute([$sessaoId]);
        $info = $stmt->fetch();
        echo json_encode([
            'ok' => true, 'sessao_id' => $sessaoId,
            'respondidas' => (int)($info['total_respondidas'] ?? 0),
            'total_acertos' => (int)($info['total_acertos'] ?? 0),
            'total_erros' => (int)($info['total_erros'] ?? 0),
            'tipo' => $info['tipo'] ?? 'quiz',
            'tentativa' => (int)($info['numero_tentativa'] ?? 1),
            'total_questoes' => $_SESSION['total_questoes'] ?? 0,
        ]);
        exit;
    }

    // ── Finalizar sessões selecionadas ──────────────────────
    if ($acao === 'finalizar_sessoes') {
        $ids = array_map('intval', (array)($_POST['ids'] ?? []));
        $ids = array_filter($ids, fn($id) => $id > 0);
        if (!empty($ids)) {
            $db = getDB();
            $ph = implode(',', array_fill(0, count($ids), '?'));
            $db->prepare("UPDATE sessoes SET finalizado_em = NOW() WHERE id IN ($ph) AND militar_id = ? AND finalizado_em IS NULL")
               ->execute(array_merge($ids, [militar()['id']]));
        }
        echo json_encode(['ok' => true]);
        exit;
    }

    // ── Iniciar sessão de quiz/prova ──────────────────────
    if ($acao === 'iniciar') {
        $nome  = militar()['nome_guerra'];
        $tipo  = in_array($_POST['tipo'] ?? '', ['quiz', 'prova']) ? $_POST['tipo'] : 'quiz';
        $cats  = array_map('intval', (array)($_POST['categorias'] ?? []));
        $cats  = array_values(array_filter($cats, fn($id) => $id > 0));

        if (empty($cats)) { echo json_encode(['erro' => 'Selecione ao menos uma legislação.']); exit; }

        $db = getDB();
        $ph = implode(',', array_fill(0, count($cats), '?'));
        $stmt = $db->prepare("SELECT id FROM categorias WHERE id IN ($ph)");
        $stmt->execute($cats);
        $cats = array_column($stmt->fetchAll(), 'id');
        if (empty($cats)) { echo json_encode(['erro' => 'Categorias inválidas.']); exit; }

        $militarId = militar()['id'];
        $numTent   = proximaTentativa($militarId, $tipo);

        // Buscar nomes das categorias selecionadas
        $phNomes = implode(',', array_fill(0, count($cats), '?'));
        $stmtNomes = $db->prepare("SELECT GROUP_CONCAT(nome ORDER BY nome SEPARATOR ', ') FROM categorias WHERE id IN ($phNomes)");
        $stmtNomes->execute($cats);
        $catsNomes = $stmtNomes->fetchColumn() ?: '';

        $ins = $db->prepare("INSERT INTO sessoes (nome_usuario, militar_id, tipo, numero_tentativa, categorias_nomes) VALUES (?,?,?,?,?)");
        $ins->execute([$nome, $militarId, $tipo, $numTent, $catsNomes]);
        $sessaoId = $db->lastInsertId();

        // Contar total de questões disponíveis nas categorias selecionadas
        $phCount = implode(',', array_fill(0, count($cats), '?'));
        $stmtCount = $db->prepare("SELECT COUNT(*) FROM questoes WHERE ativa=1 AND categoria_id IN ($phCount)");
        $stmtCount->execute($cats);
        $totalQuestoes = (int) $stmtCount->fetchColumn();

        $_SESSION['sessao_id']    = $sessaoId;
        $_SESSION['nome']         = $nome;
        $_SESSION['respondidas']  = [];
        $_SESSION['categorias']   = $cats;
        $_SESSION['tipo_sessao']  = $tipo;
        $_SESSION['total_questoes'] = $totalQuestoes;

        echo json_encode(['ok' => true, 'sessao_id' => $sessaoId, 'nome' => $nome, 'tentativa' => $numTent, 'total_questoes' => $totalQuestoes]);
        exit;
    }

    // ── Próxima questão ──────────────────────────────────
    if ($acao === 'proxima_questao') {
        if (empty($_SESSION['sessao_id'])) { echo json_encode(['erro' => 'Sessão inválida.']); exit; }

        $db       = getDB();
        $sessaoId = $_SESSION['sessao_id'];

        // Recarregar respondidas do banco para garantir consistência
        $stmtResp = $db->prepare("SELECT DISTINCT questao_id FROM respostas_usuario WHERE sessao_id = ?");
        $stmtResp->execute([$sessaoId]);
        $respondidas = array_column($stmtResp->fetchAll(), 'questao_id');
        $respondidas = array_map('intval', $respondidas);
        $_SESSION['respondidas'] = $respondidas;

        $categorias  = array_values(array_unique((array)($_SESSION['categorias'] ?? [])));

        if (empty($categorias)) { echo json_encode(['erro' => 'Categorias da sessão não definidas.']); exit; }

        // Recalcular total de questões ativas (pode mudar se questões forem ativadas/inativadas)
        $phCat = implode(',', array_fill(0, count($categorias), '?'));
        $stmtTotal = $db->prepare("SELECT COUNT(*) FROM questoes WHERE ativa=1 AND categoria_id IN ($phCat)");
        $stmtTotal->execute($categorias);
        $_SESSION['total_questoes'] = (int)$stmtTotal->fetchColumn();

        // Se já há uma questão em andamento, retorne-a em vez de sortear outra.
        $currentQuestionId = $_SESSION['questao_atual']['id'] ?? null;
        if ($currentQuestionId && !in_array($currentQuestionId, $respondidas, true)) {
            $stmt = $db->prepare(
                "SELECT q.*, c.nome AS categoria_nome FROM questoes q
                 JOIN categorias c ON c.id = q.categoria_id
                 WHERE q.id = ? LIMIT 1"
            );
            $stmt->execute([$currentQuestionId]);
            $questao = $stmt->fetch();
            if ($questao) {
                $respCorreta = $questao['resposta_correta'];
                unset($questao['resposta_correta'], $questao['explicacao'], $questao['referencia_legal']);
                if (($questao['opcao_e'] ?? null) === null) unset($questao['opcao_e']);
                echo json_encode(['questao' => $questao, 'total_questoes' => $_SESSION['total_questoes'] ?? 0, 'respondidas' => count($respondidas)]);
                exit;
            }
            unset($_SESSION['questao_atual']);
        }

        $catPh    = implode(',', array_fill(0, count($categorias), '?'));
        $catWhere = " AND q.categoria_id IN ($catPh)";

        if (empty($respondidas)) {
            $stmt = $db->prepare(
                "SELECT q.*, c.nome AS categoria_nome FROM questoes q
                 JOIN categorias c ON c.id = q.categoria_id
                 WHERE q.ativa=1 $catWhere ORDER BY RAND() LIMIT 1"
            );
            $stmt->execute($categorias);
        } else {
            $notPh = implode(',', array_fill(0, count($respondidas), '?'));
            $stmt  = $db->prepare(
                "SELECT q.*, c.nome AS categoria_nome FROM questoes q
                 JOIN categorias c ON c.id = q.categoria_id
                 WHERE q.ativa=1 AND q.id NOT IN ($notPh) $catWhere ORDER BY RAND() LIMIT 1"
            );
            $stmt->execute(array_merge($respondidas, $categorias));
        }
        $questao = $stmt->fetch();

        if (!$questao) { echo json_encode(['fim' => true]); exit; }

        $respCorreta = $questao['resposta_correta'];
        unset($questao['resposta_correta'], $questao['explicacao'], $questao['referencia_legal']);

        // Remove opcao_e se NULL (questões antigas com 4 opções)
        if (($questao['opcao_e'] ?? null) === null) unset($questao['opcao_e']);

        $_SESSION['questao_atual'] = ['id' => $questao['id'], 'correta' => $respCorreta];

        echo json_encode(['questao' => $questao, 'total_questoes' => $_SESSION['total_questoes'] ?? 0, 'respondidas' => count($respondidas)]);
        exit;
    }

    // ── Responder ────────────────────────────────────────
    if ($acao === 'responder') {
        if (empty($_SESSION['sessao_id']) || empty($_SESSION['questao_atual'])) {
            echo json_encode(['erro' => 'Sessão ou questão inválida.']); exit;
        }
        $resposta = strtoupper(trim($_POST['resposta'] ?? ''));
        if (!in_array($resposta, ['A','B','C','D','E'])) {
            echo json_encode(['erro' => 'Resposta inválida.']); exit;
        }

        $db       = getDB();
        $sessaoId = $_SESSION['sessao_id'];
        $qAtual   = $_SESSION['questao_atual'];

        $stmt = $db->prepare(
            "SELECT enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
                    resposta_correta, explicacao, referencia_legal, nivel,
                    (SELECT nome FROM categorias WHERE id = q.categoria_id) AS categoria
             FROM questoes q WHERE id = ?"
        );
        $stmt->execute([$qAtual['id']]);
        $qCompleta = $stmt->fetch();

        $acertou = ($resposta === $qCompleta['resposta_correta']) ? 1 : 0;

        $ins = $db->prepare("INSERT INTO respostas_usuario (sessao_id,questao_id,resposta_dada,acertou) VALUES (?,?,?,?)");
        $ins->execute([$sessaoId, $qAtual['id'], $resposta, $acertou]);

        if ($acertou) {
            $db->prepare("UPDATE sessoes SET total_acertos=total_acertos+1, total_respondidas=total_respondidas+1 WHERE id=?")->execute([$sessaoId]);
        } else {
            $db->prepare("UPDATE sessoes SET total_erros=total_erros+1, total_respondidas=total_respondidas+1 WHERE id=?")->execute([$sessaoId]);
        }

        $_SESSION['respondidas'][] = $qAtual['id'];
        unset($_SESSION['questao_atual']);

        $opcCorreta = $qCompleta['opcao_' . strtolower($qCompleta['resposta_correta'])] ?? '';
        $opcUsuario = $qCompleta['opcao_' . strtolower($resposta)] ?? '';

        $stmt = $db->prepare("SELECT total_acertos, total_erros, total_respondidas FROM sessoes WHERE id=?");
        $stmt->execute([$sessaoId]);
        $contadores = $stmt->fetch();

        echo json_encode([
            'acertou'             => (bool) $acertou,
            'resposta_correta'    => $qCompleta['resposta_correta'],
            'resposta_usuario'    => $resposta,
            'opcao_correta_texto' => $opcCorreta,
            'opcao_usuario_texto' => $opcUsuario,
            'explicacao'          => $qCompleta['explicacao'],
            'referencia_legal'    => $qCompleta['referencia_legal'],
            'nivel'               => $qCompleta['nivel'],
            'categoria'           => $qCompleta['categoria'],
            'contadores'          => $contadores,
        ]);
        exit;
    }

    // ── Finalizar ────────────────────────────────────────
    if ($acao === 'finalizar') {
        if (!empty($_SESSION['sessao_id'])) {
            $db = getDB();
            $sessaoId = $_SESSION['sessao_id'];
            $db->prepare("UPDATE sessoes SET finalizado_em=NOW() WHERE id=?")->execute([$sessaoId]);
            $stmt = $db->prepare("SELECT * FROM sessoes WHERE id=?");
            $stmt->execute([$sessaoId]);
            $sessao = $stmt->fetch();

            $stmtErros = $db->prepare(
                "SELECT q.enunciado, q.opcao_a, q.opcao_b, q.opcao_c, q.opcao_d, q.opcao_e,
                        r.resposta_dada, q.resposta_correta, q.explicacao, q.referencia_legal,
                        c.nome AS categoria
                 FROM respostas_usuario r
                 JOIN questoes q ON q.id = r.questao_id
                 JOIN categorias c ON c.id = q.categoria_id
                 WHERE r.sessao_id = ? AND r.acertou = 0
                 ORDER BY r.id ASC"
            );
            $stmtErros->execute([$sessaoId]);
            $errosDetalhe = $stmtErros->fetchAll();

            unset($_SESSION['sessao_id'], $_SESSION['respondidas'], $_SESSION['categorias'], $_SESSION['questao_atual'], $_SESSION['tipo_sessao']);
            echo json_encode(['sessao' => $sessao, 'erros_detalhe' => $errosDetalhe]);
        }
        exit;
    }

    // ─── Admin: aprovar / rejeitar ───────────────────────
    if (($acao === 'aprovar' || $acao === 'rejeitar') && isAdmin()) {
        $id    = (int)($_POST['id'] ?? 0);
        $novo  = $acao === 'aprovar' ? 'aprovado' : 'rejeitado';
        $extra = $acao === 'aprovar' ? ', approved_at=NOW()' : '';
        $db    = getDB();
        $db->prepare("UPDATE militares SET status=? $extra WHERE id=?")->execute([$novo, $id]);
        echo json_encode(['ok' => true, 'status' => $novo]);
        exit;
    }

    // ─── Admin: invalidar sessões de não-aprovados (forçar logout) ─────
    if ($acao === 'invalidate_non_approved' && isAdmin()) {
        $db = getDB();
        $affected = $db->exec("UPDATE militares SET session_token=NULL WHERE status<>'aprovado'");
        echo json_encode(['ok' => true, 'invalidated' => (int)$affected]);
        exit;
    }

    // ── Heartbeat: atualiza atividade e verifica timeout ──
    if ($acao === 'heartbeat') {
        $db = getDB();
        $pagina = trim($_POST['pagina'] ?? 'inicio');
        $db->prepare("UPDATE militares SET last_activity=NOW(), current_page=? WHERE id=?")->execute([$pagina, militar()['id']]);
        // Verificar se ultrapassou 10 minutos de inatividade (checagem server-side)
        echo json_encode(['ok' => true]);
        exit;
    }

    // ── Registrar evento de atividade (clique, download, play, etc.) ──
    if ($acao === 'log_evento') {
        if (!isLogado()) { echo json_encode(['erro' => 'não autenticado']); exit; }
        $evento  = trim($_POST['evento'] ?? '');
        $detalhe = trim($_POST['detalhe'] ?? '');
        $pagina  = trim($_POST['pagina'] ?? '');
        if ($evento === '') { echo json_encode(['erro' => 'evento vazio']); exit; }
        logAtividade($evento, $detalhe !== '' ? $detalhe : null, $pagina !== '' ? $pagina : null);
        echo json_encode(['ok' => true]);
        exit;
    }

    // ── Admin: listar atividades (timeline por usuário, tempo real) ──
    if ($acao === 'listar_atividades' && isAdmin()) {
        $db = getDB();
        purgarAtividadesAntigas();   // retenção: remove eventos além do período configurado
        $militarId = isset($_POST['militar_id']) ? (int)$_POST['militar_id'] : 0;
        $limite = min(500, max(10, (int)($_POST['limite'] ?? 60)));
        [$where, $params] = filtroAtividades($militarId, $_POST['data_ini'] ?? '', $_POST['data_fim'] ?? '');
        $stmt = $db->prepare(
            "SELECT a.id, a.militar_id, a.evento, a.detalhe, a.pagina, a.criado_em,
                    m.nome_guerra, m.matricula
               FROM atividades a JOIN militares m ON m.id = a.militar_id
              $where
           ORDER BY a.id DESC LIMIT $limite"
        );
        $stmt->execute($params);
        echo json_encode(['ok' => true, 'atividades' => $stmt->fetchAll()]);
        exit;
    }

    // ── Admin: listar militares online (ativos nos últimos 10 min) ──
    if ($acao === 'listar_online' && isAdmin()) {
        $db = getDB();
        // Limpar sessões inativas há mais de 10 minutos
        $db->exec("UPDATE militares SET session_token=NULL, current_page=NULL WHERE session_token IS NOT NULL AND last_activity IS NOT NULL AND last_activity < DATE_SUB(NOW(), INTERVAL 10 MINUTE)");
        $rows = $db->query(
            "SELECT m.id, m.nome_guerra, m.nome_completo, m.matricula,
                    m.last_activity, m.current_page,
                    TIMESTAMPDIFF(SECOND, m.last_activity, NOW()) AS segundos_inativo,
                    (SELECT CONCAT(UPPER(s2.tipo), ' — ', COALESCE(s2.categorias_nomes,''))
                     FROM sessoes s2 WHERE s2.militar_id = m.id AND s2.finalizado_em IS NULL
                     ORDER BY s2.id DESC LIMIT 1) AS sessao_aberta,
                    (SELECT CONCAT(a2.evento, CASE WHEN a2.detalhe IS NOT NULL AND a2.detalhe<>'' THEN CONCAT(': ', a2.detalhe) ELSE '' END)
                     FROM atividades a2 WHERE a2.militar_id = m.id
                     ORDER BY a2.id DESC LIMIT 1) AS ultimo_evento
             FROM militares m
             WHERE m.session_token IS NOT NULL AND m.status = 'aprovado'
               AND m.last_activity >= DATE_SUB(NOW(), INTERVAL 10 MINUTE)
             ORDER BY m.last_activity DESC"
        )->fetchAll();
        echo json_encode(['ok' => true, 'online' => $rows]);
        exit;
    }

    // ─── Admin: detectar e rejeitar suspeitos (domínios descartáveis e matrícula inválida)
    if ($acao === 'reject_suspects' && isAdmin()) {
        $db = getDB();
        // Lista de domínios descartáveis comuns
        $domains = ['mailinator.com','yopmail.com','10minutemail.com','tempmail.com','guerrillamail.com','dispostable.com','maildrop.cc'];
        $placeholders = implode(',', array_fill(0, count($domains), '?'));
        // Selecionar ids suspeitos (pendentes + domínio descartável OR matrícula inválida/null)
        $sqlSel = "SELECT id FROM militares WHERE status='pendente' AND (LOWER(SUBSTRING_INDEX(email,'@',-1)) IN ($placeholders) OR matricula IS NULL OR matricula = '' OR matricula NOT REGEXP '^[0-9]{2}\\.[0-9]{3}-[0-9]$')";
        $stmt = $db->prepare($sqlSel);
        $stmt->execute($domains);
        $sus = $stmt->fetchAll(PDO::FETCH_COLUMN);
        if (empty($sus)) { echo json_encode(['ok'=>true,'rejected'=>0]); exit; }
        // Marcar como rejeitado e invalidar sessão
        $in = implode(',', array_fill(0, count($sus), '?'));
        $sqlUpd = "UPDATE militares SET status='rejeitado', session_token=NULL WHERE id IN ($in)";
        $upd = $db->prepare($sqlUpd);
        $upd->execute($sus);
        echo json_encode(['ok'=>true,'rejected'=>count($sus),'ids'=>$sus]);
        exit;
    }

    // ── Admin: alterar senha de usuário ────────────────────
    if ($acao === 'admin_alterar_senha' && isAdmin()) {
        $id    = (int)($_POST['id'] ?? 0);
        $nova  = $_POST['nova_senha'] ?? '';
        if ($id <= 0)          { echo json_encode(['erro' => 'ID inválido.']); exit; }
        if (strlen($nova) < 6) { echo json_encode(['erro' => 'Senha deve ter no mínimo 6 caracteres.']); exit; }
        $db   = getDB();
        $hash = password_hash($nova, PASSWORD_ARGON2ID);
        $db->prepare("UPDATE militares SET senha_hash=?, session_token=NULL WHERE id=?")->execute([$hash, $id]);
        echo json_encode(['ok' => true, 'msg' => 'Senha alterada com sucesso.']);
        exit;
    }

    // ── Admin: promover / rebaixar administrador ───────────
    if ($acao === 'admin_toggle_admin' && isAdmin()) {
        $id      = (int)($_POST['id'] ?? 0);
        $tornar  = (int)($_POST['tornar'] ?? 0) === 1;   // 1 = promover, 0 = rebaixar
        if ($id <= 0) { echo json_encode(['erro' => 'ID inválido.']); exit; }
        // Trava de segurança: não permitir rebaixar a si mesmo (evita perder o próprio acesso)
        if (!$tornar && $id === (int)militar()['id']) {
            echo json_encode(['erro' => 'Você não pode remover o seu próprio acesso de administrador.']); exit;
        }
        $db = getDB();
        // Verificar se o alvo existe e está aprovado
        $alvo = $db->prepare("SELECT id, nome_guerra, status, is_admin FROM militares WHERE id=? LIMIT 1");
        $alvo->execute([$id]);
        $u = $alvo->fetch();
        if (!$u)                       { echo json_encode(['erro' => 'Militar não encontrado.']); exit; }
        if ($u['status'] !== 'aprovado') { echo json_encode(['erro' => 'Só é possível promover militares aprovados.']); exit; }
        // Trava: não deixar o sistema ficar sem nenhum admin
        if (!$tornar) {
            $totAdmins = (int)$db->query("SELECT COUNT(*) FROM militares WHERE is_admin=1")->fetchColumn();
            if ($totAdmins <= 1) { echo json_encode(['erro' => 'Não é possível rebaixar o último administrador do sistema.']); exit; }
        }
        // Ao rebaixar, também derruba a sessão do alvo para recarregar as permissões
        if ($tornar) {
            $db->prepare("UPDATE militares SET is_admin=1 WHERE id=?")->execute([$id]);
        } else {
            $db->prepare("UPDATE militares SET is_admin=0, session_token=NULL WHERE id=?")->execute([$id]);
        }
        logAtividade($tornar ? 'promoveu_admin' : 'rebaixou_admin', $u['nome_guerra'] . ' (#' . $id . ')');
        echo json_encode(['ok' => true, 'is_admin' => $tornar ? 1 : 0,
            'msg' => $u['nome_guerra'] . ($tornar ? ' agora é administrador.' : ' deixou de ser administrador.')]);
        exit;
    }

    // ── Reportar questão incorreta ────────────────────────
    if ($acao === 'reportar_questao') {
        $questaoId     = (int)($_POST['questao_id'] ?? 0);
        $justificativa = trim($_POST['justificativa'] ?? '');
        if ($questaoId <= 0) { echo json_encode(['erro' => 'Questão inválida.']); exit; }
        $db = getDB();
        $stmt = $db->prepare("SELECT id FROM questoes WHERE id=? LIMIT 1");
        $stmt->execute([$questaoId]);
        if (!$stmt->fetch()) { echo json_encode(['erro' => 'Questão não encontrada.']); exit; }
        $db->prepare("INSERT INTO questoes_reportadas (questao_id, militar_id, justificativa) VALUES (?,?,?)")
           ->execute([$questaoId, militar()['id'], $justificativa ?: null]);
        $db->prepare("UPDATE questoes SET ativa=0 WHERE id=?")->execute([$questaoId]);
        echo json_encode(['ok' => true, 'msg' => 'Questão reportada e inativada. O administrador irá analisá-la.']);
        exit;
    }

    // ── Admin: listar questões reportadas ────────────────
    if ($acao === 'listar_reportadas' && isAdmin()) {
        $db = getDB();
        $rows = $db->query(
            "SELECT r.id, r.questao_id, r.justificativa, r.created_at, r.resolvida,
                    q.enunciado, q.opcao_a, q.opcao_b, q.opcao_c, q.opcao_d, q.opcao_e,
                    q.resposta_correta, q.explicacao, q.referencia_legal, q.ativa,
                    m.nome_guerra
             FROM questoes_reportadas r
             JOIN questoes q ON q.id = r.questao_id
             JOIN militares m ON m.id = r.militar_id
             ORDER BY r.resolvida ASC, r.created_at DESC
             LIMIT 100"
        )->fetchAll();
        echo json_encode(['ok' => true, 'reportadas' => $rows]);
        exit;
    }

    // ── Admin: buscar questões por texto (para edição) ──────
    if ($acao === 'buscar_questoes' && isAdmin()) {
        $db = getDB();
        $termo   = trim($_POST['termo'] ?? '');
        $filtro  = $_POST['filtro'] ?? 'todas';   // todas | ativas | inativas
        $cond = []; $params = [];
        if ($termo !== '') {
            // busca por ID exato ou por trecho do enunciado
            if (ctype_digit($termo)) { $cond[] = '(q.id = ? OR q.enunciado LIKE ?)'; $params[] = (int)$termo; $params[] = '%' . $termo . '%'; }
            else { $cond[] = 'q.enunciado LIKE ?'; $params[] = '%' . $termo . '%'; }
        }
        if ($filtro === 'ativas')   $cond[] = 'q.ativa = 1';
        if ($filtro === 'inativas') $cond[] = 'q.ativa = 0';
        $where = $cond ? ('WHERE ' . implode(' AND ', $cond)) : '';
        $stmt = $db->prepare(
            "SELECT q.id, q.categoria_id, q.enunciado, q.opcao_a, q.opcao_b, q.opcao_c,
                    q.opcao_d, q.opcao_e, q.resposta_correta, q.explicacao,
                    q.referencia_legal, q.nivel, q.ativa,
                    c.nome AS categoria_nome
               FROM questoes q
          LEFT JOIN categorias c ON c.id = q.categoria_id
              $where
           ORDER BY q.id DESC LIMIT 50"
        );
        $stmt->execute($params);
        echo json_encode(['ok' => true, 'questoes' => $stmt->fetchAll()]);
        exit;
    }

    // ── Admin: salvar edição de questão ─────────────────────
    if ($acao === 'salvar_questao' && isAdmin()) {
        $db = getDB();
        $id        = (int)($_POST['id'] ?? 0);
        $enunciado = trim($_POST['enunciado'] ?? '');
        $opA = trim($_POST['opcao_a'] ?? '');
        $opB = trim($_POST['opcao_b'] ?? '');
        $opC = trim($_POST['opcao_c'] ?? '');
        $opD = trim($_POST['opcao_d'] ?? '');
        $opE = trim($_POST['opcao_e'] ?? '');
        $correta = strtoupper(trim($_POST['resposta_correta'] ?? ''));
        $explic  = trim($_POST['explicacao'] ?? '');
        $refLegal = trim($_POST['referencia_legal'] ?? '');
        $nivel   = $_POST['nivel'] ?? 'medio';

        if ($id <= 0)          { echo json_encode(['erro' => 'ID inválido.']); exit; }
        if ($enunciado === '') { echo json_encode(['erro' => 'O enunciado não pode ficar vazio.']); exit; }
        if (!in_array($correta, ['A','B','C','D','E'], true)) { echo json_encode(['erro' => 'Resposta correta deve ser A, B, C, D ou E.']); exit; }
        // a alternativa marcada como correta precisa ter texto
        $mapa = ['A'=>$opA,'B'=>$opB,'C'=>$opC,'D'=>$opD,'E'=>$opE];
        if (trim($mapa[$correta]) === '') { echo json_encode(['erro' => 'A alternativa marcada como correta ('.$correta.') está vazia.']); exit; }
        if (!in_array($nivel, ['facil','medio','dificil'], true)) $nivel = 'medio';

        $stmt = $db->prepare(
            "UPDATE questoes SET enunciado=?, opcao_a=?, opcao_b=?, opcao_c=?, opcao_d=?,
                    opcao_e=?, resposta_correta=?, explicacao=?, referencia_legal=?, nivel=?
              WHERE id=?"
        );
        $stmt->execute([$enunciado, $opA, $opB, $opC, $opD, $opE ?: null, $correta,
                        $explic, $refLegal ?: null, $nivel, $id]);
        logAtividade('editou_questao', 'Questão #' . $id);
        echo json_encode(['ok' => true, 'msg' => 'Questão #' . $id . ' atualizada com sucesso.']);
        exit;
    }

    // ── Admin: reativar questão reportada ────────────────
    if ($acao === 'reativar_questao' && isAdmin()) {
        $questaoId = (int)($_POST['questao_id'] ?? 0);
        $reportId  = (int)($_POST['report_id'] ?? 0);
        if ($questaoId <= 0) { echo json_encode(['erro' => 'ID inválido.']); exit; }
        $db = getDB();
        $db->prepare("UPDATE questoes SET ativa=1 WHERE id=?")->execute([$questaoId]);
        if ($reportId > 0) {
            $db->prepare("UPDATE questoes_reportadas SET resolvida=1, resolvida_em=NOW() WHERE id=?")->execute([$reportId]);
        }
        echo json_encode(['ok' => true, 'msg' => 'Questão reativada.']);
        exit;
    }

    // ── Admin: descartar questão (manter inativa e marcar resolvida) ──
    if ($acao === 'descartar_questao' && isAdmin()) {
        $reportId = (int)($_POST['report_id'] ?? 0);
        if ($reportId <= 0) { echo json_encode(['erro' => 'ID inválido.']); exit; }
        $db = getDB();
        $db->prepare("UPDATE questoes_reportadas SET resolvida=1, resolvida_em=NOW() WHERE id=?")->execute([$reportId]);
        echo json_encode(['ok' => true, 'msg' => 'Questão mantida inativa e report resolvido.']);
        exit;
    }

    echo json_encode(['erro' => 'Ação desconhecida.']); exit;
}

// ============================================================
// GET — Logout via link (sem depender de JavaScript)
// ============================================================
if (isset($_GET['logout']) && isLogado()) {
    $db = getDB();
    $db->prepare("UPDATE militares SET session_token=NULL WHERE id=?")->execute([militar()['id']]);
    session_destroy();
    header('Location: ?p=inicio');
    exit;
}

// ============================================================
// GET — Determinar página
// ============================================================
$page = $_GET['p'] ?? 'inicio';

// ── Admin: exportar atividades em CSV ────────────────────────
if (($_GET['export'] ?? '') === 'atividades') {
    if (!isLogado() || !isAdmin()) { header('Location: ?p=inicio'); exit; }
    $militarId = isset($_GET['militar_id']) ? (int)$_GET['militar_id'] : 0;
    [$where, $params] = filtroAtividades($militarId, $_GET['data_ini'] ?? '', $_GET['data_fim'] ?? '');
    $stmt = getDB()->prepare(
        "SELECT a.criado_em, m.nome_guerra, m.matricula, a.evento, a.detalhe, a.pagina, a.ip
           FROM atividades a JOIN militares m ON m.id = a.militar_id
          $where
       ORDER BY a.id DESC LIMIT 20000"
    );
    $stmt->execute($params);
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="atividades_' . date('Y-m-d_His') . '.csv"');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF"); // BOM p/ acentos no Excel
    fputcsv($out, ['Data/Hora', 'Nome Guerra', 'Matrícula', 'Evento', 'Detalhe', 'Página', 'IP'], ';');
    while ($r = $stmt->fetch()) {
        fputcsv($out, [$r['criado_em'], $r['nome_guerra'], $r['matricula'], $r['evento'], $r['detalhe'], $r['pagina'], $r['ip']], ';');
    }
    fclose($out);
    exit;
}

// Páginas que exigem conta aprovada
$pagesRequireApproval = ['cursos','quiz','prova','provas','leis','slides','audios','historico','admin'];
if (in_array($page, $pagesRequireApproval, true)) {
    if (!isLogado()) {
        header('Location: ?p=inicio'); exit;
    }
    if (!isAprovado()) {
        // Usuário logado mas não aprovado — redirecionar para aviso de pendência
        header('Location: ?p=inicio'); exit;
    }
}

// Proteger admin
if ($page === 'admin' && (!isLogado() || !isAdmin())) {
    header('Location: ?p=inicio'); exit;
}

// ── Registro server-side de navegação (cada abertura de página) ──
// Captura de forma confiável qual menu/opção o militar acessou, mesmo sem JS.
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isLogado() && isAprovado()) {
    $labelPaginas = [
        'inicio' => 'Tela inicial', 'cursos' => 'Meus Cursos', 'quiz' => 'Quiz',
        'prova' => 'Prova', 'provas' => 'Provas', 'audios' => 'Áudios',
        'leis' => 'Legislações', 'slides' => 'Slides', 'historico' => 'Histórico',
        'admin' => 'Admin',
    ];
    $labelPag = $labelPaginas[$page] ?? $page;
    if (isset($_GET['modo'])) $labelPag .= ' (' . trim($_GET['modo']) . ')';
    logAtividade('navegou', $labelPag, $page);
}

// Dados para página admin
$pendentes = [];
$aprovados = [];
if ($page === 'admin' && isAdmin()) {
    $db = getDB();
    $pendentes = $db->query("SELECT * FROM militares WHERE status='pendente' ORDER BY created_at DESC")->fetchAll();
    $aprovados = $db->query("SELECT id, nome_completo, nome_guerra, email, matricula, created_at, approved_at, is_admin FROM militares WHERE status='aprovado' ORDER BY nome_guerra")->fetchAll();
}

// ============================================================
// PLATAFORMA — catálogo de cursos (fonte única de verdade)
// A plataforma pode hospedar 1+ cursos. Por ora só o CHO concentra todo o
// material (Quiz, Provas, Áudios, Leis, Slides). Para adicionar um novo curso,
// basta acrescentar outra entrada neste array.
// ============================================================
$PLATAFORMA_NOME = 'Portal de Cursos PMRR';
$CURSOS = [
    'cho' => [
        'sigla'      => 'CHO',
        'nome'       => 'Curso de Habilitação de Oficiais',
        'icone'      => '🎓',
        'descricao'  => 'Preparação em legislações militares de Roraima: estude por slides e áudios, consulte as leis e teste-se com quiz e provas.',
        'legislacao' => 'Portaria 1717/2023 · Portaria 685/2024 · LC 194/2012 · Lei 963/2014',
        'modulos'    => ['📚 Quiz', '🎯 Provas', '🎧 Áudios', '📜 Leis', '🖥️ Slides'],
        'entrar'     => '?p=inicio&modo=quiz',
    ],
];
// Curso ativo do contexto atual (único enquanto houver só um curso).
$CURSO_ATIVO = $CURSOS['cho'];
// Páginas que fazem parte da área interna de um curso (para o header/subtítulo).
$paginasDoCurso = ['inicio','quiz','prova','provas','leis','slides','audios','historico'];

// Dados para histórico
$historico = [];
if ($page === 'historico' && isLogado() && isAprovado()) {
    $db = getDB();
    if (isAdmin()) {
        // Admin: histórico de todos os militares — suportando filtros por militar e tentativa
        $militarFilter  = isset($_GET['militar']) ? (int)$_GET['militar'] : 0;
        $tentativaFilter = isset($_GET['tentativa']) ? (int)$_GET['tentativa'] : 0;

        $sql = "SELECT s.id, s.tipo, s.numero_tentativa, s.total_acertos, s.total_erros,
                    s.total_respondidas, s.finalizado_em, s.created_at,
                    s.categorias_nomes,
                    COALESCE(m.nome_guerra, s.nome_usuario) AS nome_guerra, m.matricula
             FROM sessoes s
             LEFT JOIN militares m ON m.id = s.militar_id";

        $conds = [];
        $params = [];
        if ($militarFilter > 0) { $conds[] = 's.militar_id=?'; $params[] = $militarFilter; }
        if ($tentativaFilter > 0) { $conds[] = 's.numero_tentativa=?'; $params[] = $tentativaFilter; }
        if (!empty($conds)) { $sql .= ' WHERE ' . implode(' AND ', $conds); }
        $sql .= ' ORDER BY s.id DESC LIMIT 200';

        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        $historico = $stmt->fetchAll();

        // Lista de militares para o filtro
        $militares_list = $db->query("SELECT id, nome_guerra FROM militares ORDER BY nome_guerra")->fetchAll();
    } else {
        $stmt = $db->prepare(
            "SELECT id, tipo, numero_tentativa, total_acertos, total_erros, total_respondidas, finalizado_em, created_at, categorias_nomes
             FROM sessoes WHERE militar_id=? ORDER BY id DESC LIMIT 50"
        );
        $tentativaFilter = isset($_GET['tentativa']) ? (int)$_GET['tentativa'] : 0;
        if ($tentativaFilter > 0) {
            $stmt = $db->prepare(
                "SELECT id, tipo, numero_tentativa, total_acertos, total_erros, total_respondidas, finalizado_em, created_at, categorias_nomes
                 FROM sessoes WHERE militar_id=? AND numero_tentativa=? ORDER BY id DESC LIMIT 50"
            );
            $stmt->execute([militar()['id'], $tentativaFilter]);
        } else {
            $stmt->execute([militar()['id']]);
        }
        $historico = $stmt->fetchAll();
    }
}

// Categorias para tela de quiz
$categorias = [];
if (isLogado() && isAprovado() && $page === 'inicio') {
    $categorias = getCategorias();
}

// Página de reset de senha
$resetToken = trim($_GET['token'] ?? '');
$resetValido = false;
if ($page === 'reset' && strlen($resetToken) === 64) {
    $db   = getDB();
    $stmt = $db->prepare("SELECT id FROM militares WHERE reset_token=? AND reset_expires > NOW() LIMIT 1");
    $stmt->execute([$resetToken]);
    $resetValido = (bool)$stmt->fetch();
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Portal de Cursos PMRR</title>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  --verde:#1a5c2e;--verde-md:#2e7d47;--verde-lt:#4caf70;
  --amarelo:#f9a825;--vermelho:#c62828;--vermelho-lt:#ef9a9a;
  --cinza-bg:#f4f6f8;--branco:#ffffff;--texto:#1e2b1f;
  --sombra:0 4px 24px rgba(0,0,0,.12);--radius:14px;--tr:.25s ease;
  --hdr-h:56px;
}
body{font-family:'Segoe UI',system-ui,sans-serif;background:var(--cinza-bg);color:var(--texto);min-height:100vh;display:flex;flex-direction:column;}
header{width:100%;background:linear-gradient(135deg,var(--verde) 0%,var(--verde-md) 100%);color:#fff;padding:10px 20px;display:flex;align-items:center;gap:14px;box-shadow:0 3px 16px rgba(0,0,0,.25);position:sticky;top:0;z-index:100;min-height:56px;}
.hdr-toggle{background:none;border:2px solid rgba(255,255,255,.35);color:#fff;border-radius:6px;padding:6px 9px;font-size:1.1rem;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:var(--tr);flex-shrink:0;}
.hdr-toggle:hover{background:rgba(255,255,255,.15);}
header h1{font-size:1.05rem;line-height:1.3;}
header p{font-size:.72rem;opacity:.85;margin-top:1px;}
.hdr-nav{margin-left:auto;display:flex;gap:8px;align-items:center;flex-wrap:nowrap;white-space:nowrap;}
.btn-hdr{background:rgba(255,255,255,.15);color:#fff;border:1px solid rgba(255,255,255,.3);border-radius:6px;padding:6px 14px;font-size:.8rem;font-weight:600;text-decoration:none;cursor:pointer;transition:var(--tr);}
.btn-hdr:hover{background:rgba(255,255,255,.25);}
.btn-hdr.danger{background:rgba(198,40,40,.5);border-color:#ef9a9a;}
#placar-header{display:none;gap:10px;}
.pl-item{background:rgba(255,255,255,.15);border-radius:10px;padding:5px 12px;text-align:center;min-width:58px;}
.pl-item .pl-num{font-size:1.3rem;font-weight:700;}
.pl-item .pl-lbl{font-size:.6rem;opacity:.85;text-transform:uppercase;}
.pl-item.acertos .pl-num{color:#a5f3c2;}
.pl-item.erros .pl-num{color:#ffb4b4;}
main{width:100%;padding:0;margin:0;flex:1;}
.card{background:var(--branco);border-radius:var(--radius);box-shadow:var(--sombra);padding:28px 30px;animation:fadeIn .35s ease;}
@keyframes fadeIn{from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:none}}
/* Form */
.form-group{margin-bottom:16px;text-align:left;}
.form-group label{display:block;font-weight:600;margin-bottom:6px;color:var(--verde);font-size:.88rem;}
.form-group input{width:100%;padding:11px 14px;border:2px solid #c8e6c9;border-radius:8px;font-size:.95rem;transition:var(--tr);}
.form-group input:focus{outline:none;border-color:var(--verde-md);box-shadow:0 0 0 3px rgba(46,125,71,.15);}
.toggle-senha{position:absolute;right:10px;top:50%;transform:translateY(-50%);cursor:pointer;font-size:1.1rem;user-select:none;opacity:.6;transition:opacity .2s;}
.toggle-senha:hover{opacity:1;}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:14px;}
@media(max-width:520px){.form-row{grid-template-columns:1fr;}}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;padding:12px 28px;border:none;border-radius:8px;font-size:.95rem;font-weight:700;cursor:pointer;transition:var(--tr);text-decoration:none;}
.btn-primary{background:linear-gradient(135deg,var(--verde-md),var(--verde));color:#fff;box-shadow:0 4px 14px rgba(46,125,71,.3);}
.btn-primary:hover{transform:translateY(-2px);box-shadow:0 6px 18px rgba(46,125,71,.4);}
.btn-outline{background:transparent;color:var(--verde-md);border:2px solid var(--verde-md);}
.btn-outline:hover{background:#e8f5e9;}
.btn-sm{padding:6px 14px;font-size:.8rem;}
.btn-danger{background:var(--vermelho);color:#fff;}
.btn-danger:hover{background:#b71c1c;}
/* Auth */
.auth-header{text-align:center;margin-bottom:28px;}
.auth-header .shield{font-size:60px;display:block;margin-bottom:10px;}
.auth-header h2{color:var(--verde);font-size:1.6rem;margin-bottom:4px;}
.auth-header p{color:#666;font-size:.9rem;}
.tabs{display:flex;gap:4px;background:#e8f5e9;border-radius:10px;padding:4px;margin-bottom:24px;}
.tab{flex:1;text-align:center;padding:9px;border-radius:7px;cursor:pointer;font-weight:600;font-size:.88rem;color:var(--verde-md);transition:var(--tr);}
.tab.ativa{background:var(--verde-md);color:#fff;}
.msg-ok{background:#e8f5e9;border:1px solid #c8e6c9;color:#1a5c2e;border-radius:8px;padding:12px 16px;font-size:.88rem;margin-bottom:16px;display:none;}
.msg-err{background:#fff5f5;border:1px solid #ffcdd2;color:var(--vermelho);border-radius:8px;padding:12px 16px;font-size:.88rem;margin-bottom:16px;display:none;}
.pendente-aviso{background:#fff3cd;border:1px solid #f9a825;border-radius:10px;padding:20px 24px;text-align:center;}
.pendente-aviso h3{color:#8d5500;margin-bottom:8px;}
/* Layout sidebar colapsável */
.layout{display:flex;min-height:calc(100vh - 56px);}
.sidebar{width:210px;flex-shrink:0;background:var(--branco);border-right:1px solid #e0e0e0;padding:16px 10px;transition:width .25s ease,padding .25s ease;overflow:hidden;position:sticky;top:var(--hdr-h);height:calc(100vh - var(--hdr-h));z-index:50;}
.sidebar.collapsed{width:56px;padding:16px 6px;}
.sidebar .menu{display:flex;flex-direction:column;gap:4px}
.sidebar .menu a{display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:8px;text-decoration:none;color:var(--verde-md);font-weight:700;font-size:.85rem;transition:var(--tr);white-space:nowrap;overflow:hidden;}
.sidebar .menu a .icon{width:24px;min-width:24px;display:inline-flex;justify-content:center;font-size:1.1rem}
.sidebar .menu a .label{transition:opacity .2s ease;}
.sidebar.collapsed .menu a .label{opacity:0;width:0;overflow:hidden;}
.sidebar .menu a:hover{background:#e8f5e9;}
.sidebar .menu a.active{background:var(--verde-md);color:#fff;box-shadow:0 2px 8px rgba(46,125,71,.2)}
.sidebar .menu .menu-curso-label{font-size:.68rem;font-weight:700;text-transform:uppercase;letter-spacing:.03em;color:#8aa;padding:10px 12px 4px;margin-top:4px;border-top:1px solid #eef2ef;white-space:normal;line-height:1.3;}
.sidebar.collapsed .menu .menu-curso-label{opacity:0;height:0;padding:0;overflow:hidden;}
.content{flex:1;min-width:0;padding:24px 28px 60px;}
.cursos-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:18px;}
.curso-card{background:#fff;border:1px solid #e3ece5;border-radius:14px;padding:20px;display:flex;flex-direction:column;box-shadow:0 2px 10px rgba(46,125,71,.06);transition:var(--tr);}
.curso-card:hover{box-shadow:0 6px 20px rgba(46,125,71,.14);transform:translateY(-2px);}
.curso-card-top{display:flex;align-items:center;gap:12px;margin-bottom:12px;}
.curso-icone{font-size:2.2rem;line-height:1;}
.curso-nome{color:var(--verde);font-size:1.05rem;margin:0;line-height:1.25;}
.curso-sigla{display:inline-block;margin-top:4px;background:var(--verde-md);color:#fff;font-size:.7rem;font-weight:700;padding:2px 8px;border-radius:20px;letter-spacing:.04em;}
.curso-desc{color:#555;font-size:.86rem;line-height:1.45;margin:0 0 14px;}
.curso-modulos{display:flex;flex-wrap:wrap;gap:6px;margin-bottom:12px;}
.curso-chip{background:#eef6f0;color:var(--verde-md);font-size:.74rem;font-weight:600;padding:3px 9px;border-radius:20px;white-space:nowrap;}
.curso-legislacao{color:#8a9a8f;font-size:.74rem;line-height:1.4;margin:0 0 16px;}
.curso-entrar{margin-top:auto;text-decoration:none;text-align:center;}
.menu-overlay{display:none;}
@media(max-width:768px){
  .sidebar{position:fixed;top:var(--hdr-h);left:-260px;width:240px;height:calc(100vh - var(--hdr-h));box-shadow:4px 0 24px rgba(0,0,0,.15);transition:left .3s ease;overflow-y:auto;border-right:none;}
  .sidebar.open{left:0}
  .sidebar.collapsed{width:240px;padding:16px 10px;}
  .sidebar.collapsed .menu a .label{opacity:1;width:auto;}
  .menu-overlay.open{display:block;position:fixed;inset:0;top:var(--hdr-h);background:rgba(0,0,0,.4);z-index:49}
  .content{padding:16px 14px 60px;}
}
/* Categorias */
.section-titulo{font-size:.78rem;font-weight:700;color:var(--verde);text-transform:uppercase;letter-spacing:.06em;margin-bottom:10px;}
.cats-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:16px;}
@media(max-width:500px){.cats-grid{grid-template-columns:1fr;}}
.cat-label{display:flex;align-items:flex-start;gap:10px;padding:12px 14px;border:2px solid #c8e6c9;border-radius:10px;cursor:pointer;transition:var(--tr);background:#fff;}
.cat-label:hover,.cat-label.sel{border-color:var(--verde-md);background:#e8f5e9;}
.cat-label input[type=checkbox]{display:none;}
.cat-check{width:22px;height:22px;border:2px solid #b0bec5;border-radius:6px;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:13px;transition:var(--tr);margin-top:2px;}
.cat-label.sel .cat-check{background:var(--verde-md);border-color:var(--verde-md);color:#fff;}
.cat-info{flex:1;}
.cat-nome{font-size:.86rem;font-weight:700;color:var(--texto);line-height:1.3;}
.cat-sub{font-size:.73rem;color:#666;margin-top:2px;}
.cat-total{font-size:.7rem;background:#e8f5e9;color:var(--verde);border-radius:20px;padding:2px 8px;margin-top:5px;display:inline-block;font-weight:600;}
.cat-label.sel .cat-total{background:var(--verde-md);color:#fff;}
.cats-acoes{display:flex;gap:8px;margin-bottom:8px;}
.btn-link{background:none;border:none;padding:0;font-size:.78rem;color:var(--verde-md);cursor:pointer;text-decoration:underline;}
.total-selecionado{font-size:.82rem;color:#555;margin-bottom:16px;}
/* Quiz */
.q-meta{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:14px;align-items:center;}
.q-categoria{background:#e8f5e9;color:var(--verde);border-radius:20px;padding:4px 12px;font-size:.75rem;font-weight:600;}
.q-nivel{border-radius:20px;padding:4px 12px;font-size:.72rem;font-weight:700;}
.nivel-facil{background:#e3f2fd;color:#1565c0;}
.nivel-medio{background:#fff3e0;color:#e65100;}
.nivel-dificil{background:#fce4ec;color:#c62828;}
.q-num{margin-left:auto;font-size:.8rem;color:#999;}
#enunciado{font-size:1.05rem;line-height:1.7;color:var(--texto);margin-bottom:20px;font-weight:500;}
.opcoes{display:flex;flex-direction:column;gap:10px;margin-bottom:20px;}
.opcao{display:flex;align-items:flex-start;gap:12px;padding:14px 16px;border:2px solid #e0e0e0;border-radius:10px;cursor:pointer;transition:var(--tr);}
.opcao:hover:not(.bloqueada){border-color:var(--verde-md);background:#f0faf3;}
.opcao.bloqueada{cursor:default;}
.opcao.correta{border-color:var(--verde-md)!important;background:#e8f5e9!important;}
.opcao.errada{border-color:var(--vermelho)!important;background:#fff5f5!important;}
.opcao-letra{width:32px;height:32px;background:#e8f5e9;border-radius:8px;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.88rem;color:var(--verde);flex-shrink:0;}
.opcao.correta .opcao-letra{background:var(--verde-md);color:#fff;}
.opcao.errada .opcao-letra{background:var(--vermelho);color:#fff;}
.opcao-texto{font-size:.92rem;line-height:1.55;padding-top:5px;}
#feedback{display:none;border-radius:12px;overflow:hidden;margin-top:8px;}
.fb-header{display:flex;align-items:flex-start;gap:14px;padding:16px 20px;}
.fb-header.acertou{background:#e8f5e9;}
.fb-header.errou{background:#fff5f5;}
.fb-icone{font-size:1.6rem;flex-shrink:0;}
.fb-titulo{font-weight:700;font-size:1rem;}
.fb-titulo.acertou{color:var(--verde);}
.fb-titulo.errou{color:var(--vermelho);}
.fb-subtitulo{font-size:.82rem;color:#666;margin-top:2px;}
.fb-body{padding:16px 20px;background:#fff;border:2px solid;}
.fb-body.acertou{border-color:#c8e6c9;border-top:none;}
.fb-body.errou{border-color:#ffcdd2;border-top:none;}
.fb-resp-certa,.fb-resp-errada{border-radius:8px;padding:8px 12px;margin-bottom:10px;font-size:.88rem;}
.fb-resp-certa{background:#e8f5e9;}
.fb-resp-errada{background:#fff5f5;}
.fb-explicacao-titulo{font-size:.82rem;font-weight:700;color:var(--verde);text-transform:uppercase;letter-spacing:.04em;margin:10px 0 6px;}
.fb-explicacao{font-size:.93rem;line-height:1.7;color:#333;}
.fb-referencia{margin-top:10px;background:#f3f4f6;border-radius:8px;padding:7px 12px;font-size:.8rem;color:#666;}
.fb-referencia strong{color:var(--verde);}
.fb-acoes{margin-top:16px;display:flex;gap:10px;flex-wrap:wrap;}
#carregando{display:none;text-align:center;padding:40px;color:#888;}
.spinner{width:38px;height:38px;border:4px solid #e0e0e0;border-top-color:var(--verde-md);border-radius:50%;animation:spin .8s linear infinite;margin:0 auto 12px;}
@keyframes spin{to{transform:rotate(360deg)}}
/* Resultado */
#tela-resultado{display:none;text-align:center;}
.res-trofeu{font-size:72px;margin-bottom:10px;}
.res-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-bottom:24px;}
.res-card{border-radius:12px;padding:16px 8px;font-size:1.8rem;font-weight:800;}
.res-card.acertos{background:#e8f5e9;color:var(--verde-md);}
.res-card.erros{background:#fff5f5;color:var(--vermelho);}
.res-card.total{background:#e3f2fd;color:#1565c0;}
.res-card small{display:block;font-size:.7rem;font-weight:500;color:#666;margin-top:3px;}
.barra-wrap{background:#ecf0f1;border-radius:30px;height:18px;overflow:hidden;margin:0 auto 6px;max-width:380px;}
.barra-fill{height:100%;border-radius:30px;background:linear-gradient(90deg,var(--verde-lt),var(--verde-md));transition:width .8s ease;}
.pct-texto{font-size:.88rem;color:#666;margin-bottom:24px;}
.classificacao{background:var(--cinza-bg);border-radius:12px;padding:14px 22px;margin-bottom:20px;font-size:1rem;}
@media(max-width:600px){.card{padding:20px 16px;}.res-grid{grid-template-columns:1fr;}}
/* Modal customizado */
.modal-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.45);z-index:9999;align-items:center;justify-content:center;}
.modal-overlay.show{display:flex;}
.modal-box{background:#fff;border-radius:14px;padding:28px 32px;max-width:440px;width:90%;box-shadow:0 12px 40px rgba(0,0,0,.25);animation:fadeIn .25s ease;text-align:center;}
.modal-icon{font-size:2.4rem;margin-bottom:10px;}
.modal-msg{font-size:.95rem;color:var(--texto);line-height:1.6;margin-bottom:20px;}
.modal-btns{display:flex;gap:10px;justify-content:center;}
.modal-btn{padding:10px 24px;border:none;border-radius:8px;font-size:.9rem;font-weight:700;cursor:pointer;transition:var(--tr);}
.modal-btn-ok{background:var(--verde-md);color:#fff;}
.modal-btn-ok:hover{background:var(--verde);}
.modal-btn-cancel{background:#f5f5f5;color:#555;border:1px solid #ddd;}
.modal-btn-cancel:hover{background:#eee;}
/* Histórico */
.hist-tabela{width:100%;border-collapse:collapse;font-size:.88rem;}
.hist-tabela th{background:var(--verde);color:#fff;padding:10px 12px;text-align:left;}
.hist-tabela td{padding:9px 12px;border-bottom:1px solid #e0e0e0;}
.hist-tabela tr:hover td{background:#f0faf3;}
.badge-quiz{background:#e3f2fd;color:#1565c0;border-radius:20px;padding:2px 10px;font-size:.75rem;font-weight:700;}
.badge-prova{background:#e8f5e9;color:var(--verde);border-radius:20px;padding:2px 10px;font-size:.75rem;font-weight:700;}
.pct-badge{border-radius:20px;padding:2px 10px;font-size:.75rem;font-weight:700;}
.pct-ex{background:#e8f5e9;color:var(--verde);}
.pct-bom{background:#e3f2fd;color:#1565c0;}
.pct-reg{background:#fff3e0;color:#e65100;}
.pct-ruim{background:#fff5f5;color:var(--vermelho);}
/* Admin */
.admin-tabs{display:flex;gap:4px;margin-bottom:20px;}
.admin-tab{padding:8px 18px;border:none;border-radius:8px;font-weight:600;cursor:pointer;font-size:.88rem;background:#e8f5e9;color:var(--verde-md);transition:var(--tr);}
.admin-tab.ativo{background:var(--verde-md);color:#fff;}
.admin-tabela{width:100%;border-collapse:collapse;font-size:.82rem;}
.admin-tabela th{background:var(--verde);color:#fff;padding:9px 10px;text-align:left;white-space:nowrap;}
.admin-tabela td{padding:8px 10px;border-bottom:1px solid #e0e0e0;vertical-align:middle;}
.admin-tabela tr:hover td{background:#f0faf3;}
.btn-aprovar{background:var(--verde-md);color:#fff;border:none;border-radius:6px;padding:5px 12px;font-size:.78rem;font-weight:700;cursor:pointer;}
.btn-aprovar:hover{background:var(--verde);}
.btn-rejeitar{background:var(--vermelho);color:#fff;border:none;border-radius:6px;padding:5px 12px;font-size:.78rem;font-weight:700;cursor:pointer;}
.btn-rejeitar:hover{background:#b71c1c;}
</style>
</head>
<body>
<script>
window.onerror = function(msg, url, line, col, err) {
    var d = document.createElement('div');
    d.style.cssText = 'position:fixed;top:0;left:0;right:0;z-index:99999;background:#ff0;color:#c00;padding:10px;font-family:monospace;font-size:13px;white-space:pre-wrap;max-height:40vh;overflow:auto;border-bottom:3px solid #c00';
    d.textContent = 'JS ERROR: ' + msg + '\nLinha: ' + line + ' Col: ' + col + '\nArquivo: ' + url + '\n' + (err && err.stack ? err.stack : '');
    document.body.prepend(d);
    return false;
};
window.addEventListener('unhandledrejection', function(e) {
    var d = document.createElement('div');
    d.style.cssText = 'position:fixed;top:0;left:0;right:0;z-index:99999;background:#ff0;color:#c00;padding:10px;font-family:monospace;font-size:13px;white-space:pre-wrap;max-height:40vh;overflow:auto;border-bottom:3px solid #c00';
    d.textContent = 'JS PROMISE ERROR: ' + (e.reason && e.reason.message ? e.reason.message : e.reason) + '\n' + (e.reason && e.reason.stack ? e.reason.stack : '');
    document.body.prepend(d);
});
</script>

<!-- HEADER -->
<header>
    <?php if (isLogado() && isAprovado()): ?>
    <button class="hdr-toggle" onclick="toggleSidebar()" title="Menu">☰</button>
    <?php endif; ?>
    <div style="min-width:0">
        <h1><?= e($PLATAFORMA_NOME) ?></h1>
        <?php
            // Subtítulo: dentro de um curso mostra o curso ativo; na vitrine, um convite.
            if (isLogado() && isAprovado() && in_array($page, $paginasDoCurso, true)) {
                $subheader = $CURSO_ATIVO['nome'] . ' — ' . $CURSO_ATIVO['sigla'];
            } elseif (isLogado() && isAprovado() && $page === 'cursos') {
                $subheader = 'Selecione um curso';
            } else {
                $subheader = 'Cursos de formação e legislação — PMRR';
            }
        ?>
        <p><?= e($subheader) ?></p>
    </div>
    <?php if (isLogado()): ?>
    <div class="hdr-nav">
        <span style="color:rgba(255,255,255,.9);font-size:.85rem">Bem vindo,&nbsp;<strong><?= e(militar()['nome_guerra']) ?></strong></span>
        <a href="?logout=1" class="btn-hdr danger" style="text-decoration:none">Sair</a>
    </div>
    <?php endif; ?>
</header>

<main>
    <div class="layout">
        <?php if (isAprovado()):
            $cur = $page;
            $modoParam = $_GET['modo'] ?? 'quiz';
        ?>
        <div class="menu-overlay" id="menu-overlay" onclick="toggleSidebar()"></div>
        <aside class="sidebar" id="sidebar-nav">
            <nav class="menu">
                <a href="?p=cursos" class="<?= $cur==='cursos' ? 'active':'' ?>"><span class="icon">🎓</span><span class="label">Meus Cursos</span></a>
                <?php if ($cur !== 'cursos'): // módulos aparecem só depois de entrar no curso ?>
                <div class="menu-curso-label label"><?= e($CURSO_ATIVO['sigla']) ?> · <?= e($CURSO_ATIVO['nome']) ?></div>
                <a href="?p=inicio&modo=quiz" class="<?= ($cur==='inicio' && $modoParam==='quiz') ? 'active':'' ?>"><span class="icon">📚</span><span class="label">Quiz</span></a>
                <a href="?p=inicio&modo=prova" class="<?= ($cur==='inicio' && $modoParam==='prova') ? 'active':'' ?>"><span class="icon">🎯</span><span class="label">Provas</span></a>
                <a href="?p=audios" class="<?= $cur==='audios' ? 'active':'' ?>"><span class="icon">🎧</span><span class="label">Áudios</span></a>
                <a href="?p=leis" class="<?= $cur==='leis' ? 'active':'' ?>"><span class="icon">📜</span><span class="label">Leis</span></a>
                <a href="?p=slides" class="<?= $cur==='slides' ? 'active':'' ?>"><span class="icon">🖥️</span><span class="label">Slides</span></a>
                <a href="?p=historico" class="<?= $cur==='historico' ? 'active':'' ?>"><span class="icon">📋</span><span class="label">Histórico</span></a>
                <?php endif; ?>
                <?php if (isAdmin()): ?><a href="?p=admin" class="<?= $cur==='admin' ? 'active':'' ?>"><span class="icon">⚙️</span><span class="label">Admin</span></a><?php endif; ?>
            </nav>
        </aside>
        <?php endif; ?>
        <section class="content">

<?php if ($page === 'reset'): // ── RESET SENHA ──────────────── ?>
<div class="card" style="max-width:440px;margin:0 auto">
    <div class="auth-header">
        <span class="shield">🔐</span>
        <h2>Redefinir Senha</h2>
    </div>
    <?php if (!$resetValido): ?>
    <div class="msg-err" style="display:block">❌ Link inválido ou expirado.<br>Solicite um novo link na tela de <a href="?" style="color:var(--vermelho)">login</a>.</div>
    <?php else: ?>
    <div id="msg-reset-ok" class="msg-ok"></div>
    <div id="msg-reset-err" class="msg-err"></div>
    <div class="form-group">
        <label>Nova Senha (mín. 8 chars)</label>
        <div style="position:relative">
            <input type="password" id="reset-senha" placeholder="••••••••" style="padding-right:40px">
            <span class="toggle-senha" onclick="toggleSenha('reset-senha',this)">👁️</span>
        </div>
    </div>
    <div class="form-group">
        <label>Confirmar Nova Senha</label>
        <div style="position:relative">
            <input type="password" id="reset-confirma" placeholder="••••••••" style="padding-right:40px">
            <span class="toggle-senha" onclick="toggleSenha('reset-confirma',this)">👁️</span>
        </div>
    </div>
    <button class="btn btn-primary" style="width:100%" onclick="resetarSenha('<?= e($resetToken) ?>')">
        🔒 Salvar Nova Senha
    </button>
    <?php endif; ?>
</div>

<?php elseif (!isLogado()): // ── NÃO LOGADO ──────────────────── ?>
<div id="tela-auth" class="card" style="max-width:480px;margin:0 auto">
    <div class="auth-header">
        <span class="shield">🎖️</span>
        <h2>Portal de Cursos PMRR</h2>
        <p>Cursos de formação e legislação — Roraima</p>
    </div>
    <div class="tabs">
        <div class="tab ativa" id="tab-login" onclick="mostraTab('login')">Entrar</div>
        <div class="tab" id="tab-cadastro" onclick="mostraTab('cadastro')">Cadastrar</div>
    </div>
    <div id="msg-auth-ok" class="msg-ok"></div>
    <div id="msg-auth-err" class="msg-err"><?php if (($_GET['kicked'] ?? '') === '1'): ?>⚠️ Sua conta foi acessada em outro dispositivo. Você foi desconectado.<?php elseif (($_GET['timeout'] ?? '') === '1'): ?>⏱️ Sessão expirada por inatividade (10 minutos). Faça login novamente.<?php endif; ?></div>

    <!-- LOGIN -->
    <div id="form-login">
        <div class="form-group">
            <label>E-mail</label>
            <input type="email" id="login-email" placeholder="seu@email.com" autocomplete="email">
        </div>
        <div class="form-group">
            <label>Senha</label>
            <div style="position:relative">
                <input type="password" id="login-senha" placeholder="••••••••" autocomplete="current-password" style="padding-right:40px">
                <span class="toggle-senha" onclick="toggleSenha('login-senha',this)">👁️</span>
            </div>
        </div>
        <div style="display:flex;align-items:center;justify-content:space-between;margin:10px 0 16px">
            <label style="display:flex;align-items:center;gap:6px;cursor:pointer;font-size:.82rem;color:#555;user-select:none">
                <input type="checkbox" id="login-lembrar" style="width:16px;height:16px;accent-color:var(--verde-md)">
                Lembrar meu e-mail
            </label>
            <a href="#" onclick="mostraTab('esqueci');return false" style="color:var(--verde-md);font-size:.82rem">Esqueci minha senha</a>
        </div>
        <button class="btn btn-primary" style="width:100%" onclick="fazerLogin()">🚀 Entrar</button>
        <p style="text-align:center;margin-top:14px;font-size:.82rem;color:#666">
            Não tem conta? <a href="#" onclick="mostraTab('cadastro');return false" style="color:var(--verde-md)">Cadastre-se</a>
        </p>
    </div>

    <!-- ESQUECI SENHA -->
    <div id="form-esqueci" style="display:none">
        <p style="color:#555;font-size:.88rem;margin-bottom:16px">Informe seu e-mail cadastrado. Você receberá um link para redefinir a senha (válido por 1 hora).</p>
        <div class="form-group">
            <label>E-mail</label>
            <input type="email" id="esq-email" placeholder="seu@email.com">
        </div>
        <button class="btn btn-primary" style="width:100%" onclick="esqueceuSenha()">📧 Enviar Link de Recuperação</button>
        <p style="text-align:center;margin-top:14px;font-size:.82rem">
            <a href="#" onclick="mostraTab('login');return false" style="color:var(--verde-md)">← Voltar ao login</a>
        </p>
    </div>

    <!-- CADASTRO -->
    <div id="form-cadastro" style="display:none">
        <div class="form-group">
            <label>Nome Completo</label>
            <input type="text" id="cad-nome" placeholder="Nome e sobrenome completo">
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>Nome de Guerra</label>
                <input type="text" id="cad-guerra" placeholder="Ex: Ramos">
            </div>
            <div class="form-group">
                <label>Matrícula PM</label>
                <input type="text" id="cad-mat" placeholder="40.123-5" maxlength="9">
            </div>
        </div>
        <div class="form-group">
            <label>E-mail</label>
            <input type="email" id="cad-email" placeholder="seu@email.com">
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>Senha (mín. 8 chars)</label>
                <div style="position:relative">
                    <input type="password" id="cad-senha" placeholder="••••••••" style="padding-right:40px">
                    <span class="toggle-senha" onclick="toggleSenha('cad-senha',this)">👁️</span>
                </div>
            </div>
            <div class="form-group">
                <label>Confirmar Senha</label>
                <div style="position:relative">
                    <input type="password" id="cad-confirma" placeholder="••••••••" style="padding-right:40px">
                    <span class="toggle-senha" onclick="toggleSenha('cad-confirma',this)">👁️</span>
                </div>
            </div>
        </div>
        <button class="btn btn-primary" style="width:100%;" onclick="fazerCadastro()">📝 Solicitar Cadastro</button>
        <p style="text-align:center;margin-top:14px;font-size:.82rem;color:#666">
            Já tem conta? <a href="#" onclick="mostraTab('login');return false" style="color:var(--verde-md)">Entre</a>
        </p>
    </div>
</div>

<?php elseif (isLogado() && !isAprovado()): // ── PENDENTE ── ?>
<div class="card" style="max-width:500px;margin:40px auto;text-align:center">
    <div class="pendente-aviso">
        <h3>⏳ Cadastro em análise</h3>
        <p>Olá, <strong><?= e(militar()['nome_guerra']) ?></strong>!</p>
        <p style="margin-top:8px">Seu cadastro está sendo verificado pelo administrador.<br>Você receberá acesso assim que for aprovado.</p>
        <a href="?logout=1" class="btn btn-outline" style="margin-top:20px;display:inline-block;text-decoration:none">Sair</a>
    </div>
</div>

<?php elseif ($page === 'cursos' && isAprovado()): // ── MEUS CURSOS (vitrine da plataforma) ── ?>
<div style="max-width:1100px">
    <h2 style="color:var(--verde);margin-bottom:4px">🎓 Meus Cursos</h2>
    <p style="color:#666;font-size:.9rem;margin-bottom:22px">Escolha um curso para acessar seus materiais.</p>
    <div class="cursos-grid">
        <?php foreach ($CURSOS as $c): ?>
        <div class="curso-card">
            <div class="curso-card-top">
                <span class="curso-icone"><?= e($c['icone']) ?></span>
                <div style="min-width:0">
                    <h3 class="curso-nome"><?= e($c['nome']) ?></h3>
                    <span class="curso-sigla"><?= e($c['sigla']) ?></span>
                </div>
            </div>
            <p class="curso-desc"><?= e($c['descricao']) ?></p>
            <div class="curso-modulos">
                <?php foreach ($c['modulos'] as $m): ?><span class="curso-chip"><?= e($m) ?></span><?php endforeach; ?>
            </div>
            <p class="curso-legislacao"><?= e($c['legislacao']) ?></p>
            <a href="<?= e($c['entrar']) ?>" class="btn btn-primary curso-entrar">Entrar ▸</a>
        </div>
        <?php endforeach; ?>
    </div>
</div>

<?php elseif ($page === 'admin' && isAdmin()): // ── ADMIN ── ?>
<div class="card">
    <h2 style="color:var(--verde);margin-bottom:4px">⚙️ Painel do Administrador</h2>
    <p style="color:#666;font-size:.88rem;margin-bottom:20px">Gerencie os cadastros de militares</p>
    <div style="margin-bottom:12px">
        <button class="btn btn-danger" onclick="invalidateNonApproved()" style="background:#c62828;color:#fff;border:none;padding:8px 12px;border-radius:6px">🚫 Invalidar sessões não aprovadas</button>
        <small style="margin-left:10px;color:#666;font-size:.85rem">Força logout de contas pendentes/rejeitadas.</small>
    </div>
    <div style="margin-bottom:12px">
        <button class="btn btn-warning" onclick="detectAndRejectSuspects()" style="background:#ff9800;color:#222;border:none;padding:8px 12px;border-radius:6px">🕵️ Detectar e rejeitar suspeitos</button>
        <small style="margin-left:10px;color:#666;font-size:.85rem">Detecta e rejeita cadastros com e-mails descartáveis ou matrícula inválida.</small>
    </div>

    <div class="admin-tabs">
        <button class="admin-tab ativo" id="atab-pend" onclick="showAdminTab('pendentes')">
            Pendentes <?php if(count($pendentes) > 0): ?><span style="background:#e65100;color:#fff;border-radius:20px;padding:1px 7px;font-size:.7rem;margin-left:4px"><?= count($pendentes) ?></span><?php endif; ?>
        </button>
        <button class="admin-tab" id="atab-aprov" onclick="showAdminTab('aprovados')">Aprovados (<?= count($aprovados) ?>)</button>
        <button class="admin-tab" id="atab-report" onclick="showAdminTab('reportadas')">⚠️ Reportadas</button>
        <button class="admin-tab" id="atab-online" onclick="showAdminTab('online')">🟢 Online</button>
        <button class="admin-tab" id="atab-ativ" onclick="showAdminTab('atividades')">📜 Atividades</button>
        <button class="admin-tab" id="atab-quest" onclick="showAdminTab('questoes')">✏️ Questões</button>
    </div>

    <div id="admin-pendentes">
    <?php if(empty($pendentes)): ?>
        <p style="color:#888;text-align:center;padding:30px">Nenhum cadastro pendente. ✅</p>
    <?php else: ?>
    <div style="overflow-x:auto">
    <table class="admin-tabela">
        <thead><tr><th>Nome Completo</th><th>Guerra</th><th>E-mail</th><th>Matrícula</th><th>Cadastro</th><th>Ações</th></tr></thead>
        <tbody>
        <?php foreach($pendentes as $m): ?>
        <tr id="row-<?= (int)$m['id'] ?>">
            <td><?= e($m['nome_completo']) ?></td>
            <td><?= e($m['nome_guerra']) ?></td>
            <td><?= e($m['email']) ?></td>
            <td><code><?= e($m['matricula']) ?></code></td>
            <td style="white-space:nowrap"><?= date('d/m/Y H:i', strtotime($m['created_at'])) ?></td>
            <td style="white-space:nowrap">
                <button class="btn-aprovar" onclick="aprovar(<?= (int)$m['id'] ?>)">✅ Aprovar</button>
                <button class="btn-rejeitar" onclick="rejeitar(<?= (int)$m['id'] ?>)" style="margin-left:4px">❌ Rejeitar</button>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
    </div>

    <div id="admin-reportadas" style="display:none">
        <p style="color:#888;text-align:center;padding:20px" id="report-loading">Carregando questões reportadas...</p>
        <div id="report-list"></div>
    </div>

    <div id="admin-online" style="display:none">
        <p style="color:#888;text-align:center;padding:20px" id="online-loading">Carregando...</p>
        <div id="online-list"></div>
    </div>

    <div id="admin-atividades" style="display:none">
        <div style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;margin-bottom:14px">
            <label style="font-size:.85rem;color:#444">Militar:
                <select id="ativ-militar" onchange="carregarAtividades()" style="margin-left:6px;padding:6px;border-radius:6px;border:1px solid #ddd">
                    <option value="0">Todos</option>
                    <?php foreach($aprovados as $m): ?>
                        <option value="<?= (int)$m['id'] ?>"><?= e($m['nome_guerra']) ?> (<?= e($m['matricula']) ?>)</option>
                    <?php endforeach; ?>
                </select>
            </label>
            <label style="font-size:.82rem;color:#444">De:
                <input type="date" id="ativ-ini" onchange="carregarAtividades()" style="margin-left:4px;padding:5px;border-radius:6px;border:1px solid #ddd">
            </label>
            <label style="font-size:.82rem;color:#444">Até:
                <input type="date" id="ativ-fim" onchange="carregarAtividades()" style="margin-left:4px;padding:5px;border-radius:6px;border:1px solid #ddd">
            </label>
            <label style="font-size:.8rem;color:#666;display:flex;align-items:center;gap:4px">
                <input type="checkbox" id="ativ-auto" checked> Tempo real (5s)
            </label>
            <button class="btn-aprovar" onclick="carregarAtividades()" style="font-size:.75rem;padding:5px 10px">🔄 Atualizar</button>
            <button class="btn-aprovar" onclick="exportarAtividades()" style="font-size:.75rem;padding:5px 10px;background:#eef7f0;color:#1a5c2e;border:1px solid #c8e6c9">⬇️ Exportar CSV</button>
            <span id="ativ-status" style="margin-left:auto;font-size:.72rem;color:#aaa"></span>
        </div>
        <div id="ativ-list"><p style="color:#888;text-align:center;padding:20px">Selecione um militar ou veja todos.</p></div>
    </div>

    <div id="admin-questoes" style="display:none">
        <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;margin-bottom:6px">
            <input type="text" id="quest-termo" placeholder="Buscar por texto do enunciado ou nº da questão…" onkeydown="if(event.key==='Enter')buscarQuestoes()" style="flex:1;min-width:240px;padding:8px 12px;border-radius:8px;border:1px solid #ddd;font-size:.9rem">
            <select id="quest-filtro" onchange="buscarQuestoes()" style="padding:8px;border-radius:8px;border:1px solid #ddd">
                <option value="todas">Todas</option>
                <option value="ativas">Só ativas</option>
                <option value="inativas">Só inativas</option>
            </select>
            <button class="btn-aprovar" onclick="buscarQuestoes()" style="font-size:.8rem;padding:8px 14px">🔍 Buscar</button>
        </div>
        <p style="font-size:.76rem;color:#999;margin-bottom:12px">Dica: digite parte do enunciado (ex.: "desobediência") ou o número da questão. Mostra até 50 resultados.</p>
        <div id="quest-list"><p style="color:#888;text-align:center;padding:20px">Faça uma busca para encontrar a questão que deseja editar.</p></div>
    </div>

    <div id="admin-aprovados" style="display:none">
    <?php if(empty($aprovados)): ?>
        <p style="color:#888;text-align:center;padding:30px">Nenhum usuário aprovado ainda.</p>
    <?php else: ?>
    <div style="overflow-x:auto">
    <table class="admin-tabela">
        <thead><tr><th>Nome</th><th>Guerra</th><th>Matrícula</th><th>E-mail</th><th>Aprovado em</th><th>Perfil</th><th>Ações</th></tr></thead>
        <tbody>
        <?php foreach($aprovados as $m): $ehAdmin = (int)$m['is_admin'] === 1; $euMesmo = (int)$m['id'] === (int)militar()['id']; ?>
        <tr id="urow-<?= (int)$m['id'] ?>">
            <td><?= e($m['nome_completo']) ?></td>
            <td><?= e($m['nome_guerra']) ?></td>
            <td><code><?= e($m['matricula']) ?></code></td>
            <td><?= e($m['email']) ?></td>
            <td><?= $m['approved_at'] ? date('d/m/Y', strtotime($m['approved_at'])) : '—' ?></td>
            <td id="perfil-<?= (int)$m['id'] ?>">
                <?php if ($ehAdmin): ?>
                    <span style="background:#e8eaf6;color:#283593;padding:2px 8px;border-radius:8px;font-size:.72rem;font-weight:700">⭐ Admin</span>
                <?php else: ?>
                    <span style="color:#888;font-size:.75rem">Militar</span>
                <?php endif; ?>
            </td>
            <td style="white-space:nowrap">
                <button class="btn-aprovar" onclick="alterarSenhaAdmin(<?= (int)$m['id'] ?>, '<?= e($m['nome_guerra']) ?>')" style="font-size:.75rem;padding:4px 8px">🔑 Senha</button>
                <?php if ($euMesmo): ?>
                    <span style="font-size:.7rem;color:#aaa;margin-left:4px">(você)</span>
                <?php elseif ($ehAdmin): ?>
                    <button class="btn-rejeitar" id="btnadmin-<?= (int)$m['id'] ?>" onclick="toggleAdmin(<?= (int)$m['id'] ?>, 0, '<?= e($m['nome_guerra']) ?>')" style="font-size:.75rem;padding:4px 8px;margin-left:4px">⬇️ Rebaixar</button>
                <?php else: ?>
                    <button class="btn-aprovar" id="btnadmin-<?= (int)$m['id'] ?>" onclick="toggleAdmin(<?= (int)$m['id'] ?>, 1, '<?= e($m['nome_guerra']) ?>')" style="font-size:.75rem;padding:4px 8px;margin-left:4px;background:#e8eaf6;color:#283593;border:1px solid #c5cae9">⭐ Tornar admin</button>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
    </div>
</div>

<?php elseif ($page === 'historico' && isAprovado()): // ── HISTÓRICO ── ?>

<?php if (isAdmin()): ?>
<!-- Painel Online em tempo real -->
<div class="card" style="margin-bottom:20px">
    <div style="display:flex;align-items:center;gap:10px;margin-bottom:14px">
        <span style="font-size:1.3rem">🟢</span>
        <h3 style="color:var(--verde);margin:0">Militares Online</h3>
        <span id="online-count" style="background:var(--verde-md);color:#fff;border-radius:20px;padding:2px 10px;font-size:.78rem;font-weight:700">0</span>
        <span id="online-refresh-indicator" style="margin-left:auto;font-size:.72rem;color:#aaa">Atualiza a cada 15s</span>
    </div>
    <div id="online-realtime-list">
        <p style="color:#aaa;font-size:.85rem;text-align:center;padding:10px">Carregando...</p>
    </div>
</div>
<?php endif; ?>

<div class="card">
    <?php if (isAdmin()): ?>
    <h2 style="color:var(--verde);margin-bottom:4px">📋 Histórico Geral</h2>
    <p style="color:#666;font-size:.88rem;margin-bottom:20px">Todas as sessões de todos os militares</p>
    <?php else: ?>
    <h2 style="color:var(--verde);margin-bottom:4px">📋 Meu Histórico</h2>
    <p style="color:#666;font-size:.88rem;margin-bottom:20px">Suas tentativas — <?= e(militar()['nome_guerra']) ?></p>
    <?php endif; ?>
    <?php if(empty($historico)): ?>
        <p style="color:#888;text-align:center;padding:40px">Nenhuma sessão registrada ainda.<br><a href="?p=inicio" style="color:var(--verde-md)">Iniciar um Quiz agora →</a></p>
    <?php else: ?>
    <!-- Filtros: permitir pesquisa por militar e por tentativa -->
    <form method="get" style="display:flex;gap:8px;align-items:center;margin-bottom:12px;flex-wrap:wrap">
        <input type="hidden" name="p" value="historico">
        <?php if (isAdmin()): ?>
            <label style="font-size:.85rem;color:#444">Militar:
                <select name="militar" style="margin-left:6px;padding:6px;border-radius:6px;border:1px solid #ddd">
                    <option value="">Todos</option>
                    <?php foreach($militares_list as $mm): ?>
                        <option value="<?= (int)$mm['id'] ?>" <?= (isset($_GET['militar']) && (int)$_GET['militar'] === (int)$mm['id']) ? 'selected' : ''?>><?= e($mm['nome_guerra']) ?></option>
                    <?php endforeach; ?>
                </select>
            </label>
        <?php endif; ?>
        <label style="font-size:.85rem;color:#444">Tentativa:
            <input type="number" name="tentativa" min="1" placeholder="#" value="<?= e($_GET['tentativa'] ?? '') ?>" style="width:90px;margin-left:6px;padding:6px;border-radius:6px;border:1px solid #ddd">
        </label>
        <div style="margin-left:auto;display:flex;gap:8px">
            <button class="btn btn-outline" type="submit">🔎 Filtrar</button>
            <a class="btn btn-link" href="?p=historico">Limpar</a>
        </div>
    </form>

    <div style="overflow-x:auto">
    <table class="hist-tabela">
        <thead><tr>
            <th>#</th>
            <?php if (isAdmin()): ?><th>Militar</th><?php endif; ?>
            <th>Modo</th><th>Conteúdo</th><th>Tentativa</th><th>Respondidas</th><th>Status</th>
            <th>Acertos</th><th>Erros</th><th>Aproveitamento</th><th>Data</th>
        </tr></thead>
        <tbody>
        <?php $i = 1; foreach($historico as $h):
            $total  = (int)$h['total_respondidas'];
            $ac     = (int)$h['total_acertos'];
            $pct    = $total > 0 ? round($ac/$total*100) : 0;
            $pctCls = $pct>=90?'pct-ex':($pct>=70?'pct-bom':($pct>=50?'pct-reg':'pct-ruim'));
            $data   = $h['finalizado_em'] ? date('d/m/Y H:i', strtotime($h['finalizado_em'])) : date('d/m/Y H:i', strtotime($h['created_at']));
            // Determinar status da sessão
            if (!empty($h['finalizado_em'])) {
                $sessStatus = 'Finalizada';
                $sessStyle  = 'background:#1a5c2e;color:#fff;padding:4px 8px;border-radius:10px;font-size:.8rem;font-weight:700';
            } else if ((int)$h['total_respondidas'] === 0) {
                $sessStatus = 'Abandonada';
                $sessStyle  = 'background:#ffebee;color:#c62828;padding:4px 8px;border-radius:10px;font-size:.8rem;font-weight:700;border:1px solid #f44336';
            } else {
                $sessStatus = 'Em aberto';
                $sessStyle  = 'background:#fff8e1;color:#ef6c00;padding:4px 8px;border-radius:10px;font-size:.8rem;font-weight:700;border:1px solid #ffb74d';
            }
        ?>
        <tr>
            <td><?= $i++ ?></td>
            <?php if (isAdmin()): ?>
            <td>
                <div style="font-weight:700;font-size:.82rem"><?= e($h['nome_guerra'] ?? '—') ?></div>
                <div style="font-size:.72rem;color:#999"><?= e($h['matricula'] ?? '') ?></div>
            </td>
            <?php endif; ?>
            <td><span class="badge-<?= e($h['tipo']) ?>"><?= strtoupper(e($h['tipo'])) ?></span></td>
            <td style="font-size:.78rem;max-width:200px;color:#555"><?= e($h['categorias_nomes'] ?? '—') ?></td>
            <td style="text-align:center">Tentativa #<?= (int)$h['numero_tentativa'] ?></td>
            <td style="text-align:center"><?= $total ?></td>
            <td style="text-align:center"><span style="<?= $sessStyle ?>"><?= $sessStatus ?></span></td>
            <td style="text-align:center;color:var(--verde-md);font-weight:700"><?= $ac ?></td>
            <td style="text-align:center;color:var(--vermelho);font-weight:700"><?= (int)$h['total_erros'] ?></td>
            <td style="text-align:center"><span class="pct-badge <?= $pctCls ?>"><?= $pct ?>%</span></td>
            <td style="white-space:nowrap"><?= $data ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<?php elseif ($page === 'leis' && isAprovado()): // ── LEIS ──
$leisDir  = __DIR__ . '/legislacao/';
$leisPdfs = [];
if (is_dir($leisDir)) {
    foreach (glob($leisDir . '*.pdf') as $f) {
        $leisPdfs[] = basename($f);
    }
    sort($leisPdfs);
}
?>
<div class="card" style="max-width:860px;margin:0 auto">
    <div style="text-align:center;margin-bottom:28px">
        <span style="font-size:48px;display:block;margin-bottom:8px">📜</span>
        <h2 style="color:var(--verde);font-size:1.5rem">Legislações</h2>
        <p style="color:#666;margin-top:6px;font-size:.9rem">Clique em <strong>Visualizar</strong> para abrir o PDF no navegador ou <strong>Download</strong> para salvar.</p>
    </div>
    <?php if (empty($leisPdfs)): ?>
    <p style="color:#888;text-align:center;padding:40px">Nenhum documento encontrado.</p>
    <?php else: ?>
    <div style="display:flex;flex-direction:column;gap:12px">
    <?php foreach ($leisPdfs as $pdf):
        $nome   = pathinfo($pdf, PATHINFO_FILENAME);
        $nome   = preg_replace('/[-_]+/', ' ', $nome);
        $nome   = preg_replace('/\d{14}$/', '', $nome);
        $nome   = trim($nome);
        $urlPdf = 'legislacao/' . rawurlencode($pdf);
    ?>
    <div style="display:flex;align-items:center;gap:14px;background:#fff;border:2px solid #e8f5e9;border-radius:12px;padding:14px 18px;box-shadow:0 2px 8px rgba(0,0,0,.06)">
        <span style="font-size:2rem;flex-shrink:0">📄</span>
        <div style="flex:1;min-width:0">
            <div style="font-weight:700;font-size:.9rem;color:#222;overflow-wrap:break-word"><?= e($nome) ?></div>
            <div style="font-size:.75rem;color:#888;margin-top:2px"><?= e($pdf) ?></div>
        </div>
        <div style="display:flex;gap:8px;flex-shrink:0">
            <a href="<?= e($urlPdf) ?>" target="_blank" rel="noopener"
               style="display:inline-flex;align-items:center;gap:5px;background:#1a5c2e;color:#fff;border-radius:8px;padding:7px 13px;font-size:.8rem;font-weight:700;text-decoration:none;white-space:nowrap">
                👁️ Visualizar
            </a>
            <a href="<?= e($urlPdf) ?>" download="<?= e($pdf) ?>"
               style="display:inline-flex;align-items:center;gap:5px;background:#e8f5e9;color:#1a5c2e;border:2px solid #1a5c2e;border-radius:8px;padding:7px 13px;font-size:.8rem;font-weight:700;text-decoration:none;white-space:nowrap">
                ⬇️ Download
            </a>
        </div>
    </div>
    <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>

<?php elseif ($page === 'slides' && isAprovado()): // ── SLIDES ──
$slidesDir  = __DIR__ . '/apresentacoes/';
$slidesPdfs = [];
if (is_dir($slidesDir)) {
    foreach (glob($slidesDir . '*.pdf') as $f) {
        $slidesPdfs[] = basename($f);
    }
    usort($slidesPdfs, function($a, $b) {
        $numA = preg_match('/^(\d+)\./', $a, $m) ? (int)$m[1] : PHP_INT_MAX;
        $numB = preg_match('/^(\d+)\./', $b, $m) ? (int)$m[1] : PHP_INT_MAX;
        return $numA <=> $numB ?: strcmp($a, $b);
    });
}
?>
<div class="card" style="max-width:860px;margin:0 auto">
    <div style="text-align:center;margin-bottom:28px">
        <span style="font-size:48px;display:block;margin-bottom:8px">🖥️</span>
        <h2 style="color:var(--verde);font-size:1.5rem">Apresentações / Slides</h2>
        <p style="color:#666;margin-top:6px;font-size:.9rem">Clique em <strong>Visualizar</strong> para abrir o PDF no navegador ou <strong>Download</strong> para salvar.</p>
    </div>
    <?php if (empty($slidesPdfs)): ?>
    <p style="color:#888;text-align:center;padding:40px">Nenhuma apresentação encontrada.</p>
    <?php else: ?>
    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:16px">
    <?php foreach ($slidesPdfs as $pdf):
        $nome   = pathinfo($pdf, PATHINFO_FILENAME);
        $nome   = preg_replace('/^\d+\.\s*/', '', $nome);
        $nome   = preg_replace('/\s*-\s*slide\s*$/i', '', $nome);
        $nome   = str_replace('_', ' ', $nome);
        $nome   = trim($nome);
        $urlPdf = 'apresentacoes/' . rawurlencode($pdf);
    ?>
    <div style="background:#fff;border:2px solid #e3f2fd;border-radius:12px;padding:18px;box-shadow:0 2px 8px rgba(0,0,0,.07);display:flex;flex-direction:column;gap:12px">
        <div style="text-align:center">
            <span style="font-size:3rem;display:block;margin-bottom:6px">📑</span>
            <div style="font-weight:700;font-size:.9rem;color:#222;overflow-wrap:break-word;word-break:break-word"><?= e($nome) ?></div>
        </div>
        <div style="display:flex;flex-direction:column;gap:8px;margin-top:auto">
            <a href="<?= e($urlPdf) ?>" target="_blank" rel="noopener"
               style="display:flex;align-items:center;justify-content:center;gap:6px;background:#1565c0;color:#fff;border-radius:8px;padding:8px 12px;font-size:.82rem;font-weight:700;text-decoration:none">
                👁️ Visualizar
            </a>
            <a href="<?= e($urlPdf) ?>" download="<?= e($pdf) ?>"
               style="display:flex;align-items:center;justify-content:center;gap:6px;background:#e3f2fd;color:#1565c0;border:2px solid #1565c0;border-radius:8px;padding:8px 12px;font-size:.82rem;font-weight:700;text-decoration:none">
                ⬇️ Download
            </a>
        </div>
    </div>
    <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>

<?php elseif ($page === 'audios' && isAprovado()): // ── ÁUDIOS ──
$choDir   = __DIR__ . '/audios/cho parte 2/';
$choItens = [];
if (is_dir($choDir)) {
    foreach (glob($choDir . '*.m4a') as $f) {
        $base = basename($f);
        if (preg_match('/^(\d+)\.\s*(.+)\.m4a$/ui', $base, $mt)) {
            $choItens[] = ['num'=>(int)$mt[1], 'nome'=>trim($mt[2]), 'file'=>$base];
        }
    }
    usort($choItens, fn($a, $b) => $a['num'] <=> $b['num']);
}

$audiosCatalog = [
  ['titulo'=>'Estatuto dos Militares','lei'=>'LC nº 194/2012','emoji'=>'📗','cor'=>'#1a5c2e','cor_lt'=>'#e8f5e9','dir'=>'',
   'itens'=>[
    ['badge'=>'Módulo 1','titulo'=>'Arts. 1 ao 21',   'file'=>'Módulo_1_(1_21)_-_Estatuto_dos_Militares.m4a'],
    ['badge'=>'Módulo 2','titulo'=>'Arts. 22 ao 37',  'file'=>'Módulo_2_(22_37)_-_Estatuto_dos_Militares.m4a'],
    ['badge'=>'Módulo 3','titulo'=>'Arts. 38 ao 58',  'file'=>'Módulo_3_(38_58)_-_Estatuto_dos_Militares.m4a'],
    ['badge'=>'Módulo 4','titulo'=>'Arts. 59 ao 99',  'file'=>'Módulo_4_(59_99)_-_Estatuto_dos_Militares.m4a'],
    ['badge'=>'Módulo 5','titulo'=>'Arts. 100 ao 161','file'=>'Módulo_5_(100_161)_-_Estatuto_dos_Militares.m4a'],
  ]],
  ['titulo'=>'Código de Ética (CEDM/RR)','lei'=>'Lei nº 963/2014','emoji'=>'📘','cor'=>'#1565c0','cor_lt'=>'#e3f2fd','dir'=>'',
   'itens'=>[
    ['badge'=>'Módulo 1','titulo'=>'Arts. 1 ao 25', 'file'=>'Módulo_1_(1_25)_-_Código_de_Ética.m4a'],
    ['badge'=>'Módulo 2','titulo'=>'Arts. 26 ao 40','file'=>'Módulo_2_(26_40)_-_Código_de_Ética.m4a'],
    ['badge'=>'Módulo 3','titulo'=>'Arts. 41 ao 65','file'=>'Módulo_3_(41_65)_-_Código_de_Ética.m4a'],
    ['badge'=>'Módulo 4','titulo'=>'Arts. 66 ao 88','file'=>'Módulo_4_(66_88)_-_Código_de_Ética.m4a'],
    ['badge'=>'Módulo 5','titulo'=>'Arts. 89 ao 102','file'=>'Módulo_5_(89_102)_-_Código_de_Ética.m4a'],
  ]],
  ['titulo'=>'Especial','lei'=>'Atualizações do Estatuto','emoji'=>'🔔','cor'=>'#e65100','cor_lt'=>'#fff3e0','dir'=>'',
   'itens'=>[
    ['badge'=>'🔔 Especial','titulo'=>'Tempo de Promoção','file'=>'Mudanças_no_Estatuto_sobre_tempo_de_promoção.m4a'],
  ]],
  ['titulo'=>'Disciplinas CHO','lei'=>count($choItens).' disciplinas complementares','emoji'=>'📚','cor'=>'#6a1b9a','cor_lt'=>'#f3e5f5','dir'=>'cho parte 2/',
   'itens'=>array_map(fn($it) => [
      'badge'=>str_pad((string)$it['num'], 2, '0', STR_PAD_LEFT),
      'titulo'=>$it['nome'],
      'file'=>$it['file'],
   ], $choItens)],
];
?>
<div class="card" style="max-width:900px;margin:0 auto">
    <div style="text-align:center;margin-bottom:24px">
        <span style="font-size:48px;display:block;margin-bottom:8px">🎧</span>
        <h2 style="color:var(--verde);font-size:1.5rem">Áudios das Legislações PMRR</h2>
        <p style="color:#666;margin-top:6px;font-size:.9rem">Ouça no navegador ou faça download para estudar offline.</p>
    </div>

    <div style="display:flex;flex-wrap:wrap;gap:8px;justify-content:center;margin-bottom:24px">
    <?php foreach ($audiosCatalog as $i => $g): ?>
        <button type="button" class="audios-tab-btn" onclick="audiosTab(<?= $i ?>, this)"
                data-cor="<?= e($g['cor']) ?>"
                style="display:flex;align-items:center;gap:6px;border:2px solid <?= e($g['cor']) ?>;background:<?= $i===0 ? e($g['cor']) : '#fff' ?>;color:<?= $i===0 ? '#fff' : e($g['cor']) ?>;border-radius:999px;padding:8px 16px;font-size:.85rem;font-weight:700;cursor:pointer;transition:var(--tr)">
            <span><?= $g['emoji'] ?></span><?= e($g['titulo']) ?>
            <span style="background:rgba(0,0,0,.15);border-radius:999px;padding:1px 7px;font-size:.72rem"><?= count($g['itens']) ?></span>
        </button>
    <?php endforeach; ?>
    </div>

<?php foreach ($audiosCatalog as $i => $g): ?>
    <div id="audios-painel-<?= $i ?>" class="audios-painel" style="<?= $i===0 ? '' : 'display:none' ?>">
        <div style="display:flex;align-items:center;gap:10px;background:<?= e($g['cor_lt']) ?>;border-left:5px solid <?= e($g['cor']) ?>;border-radius:0 10px 10px 0;padding:12px 18px;margin-bottom:14px">
            <span style="font-size:1.4rem"><?= $g['emoji'] ?></span>
            <div>
                <div style="font-weight:700;color:<?= e($g['cor']) ?>"><?= e($g['titulo']) ?></div>
                <div style="font-size:.78rem;color:#666"><?= e($g['lei']) ?></div>
            </div>
        </div>
        <?php if (count($g['itens']) > 5): ?>
        <input id="audios-busca-<?= $i ?>" type="text" placeholder="🔎 Buscar disciplina..." oninput="audiosFiltrar(<?= $i ?>)"
               style="width:100%;box-sizing:border-box;padding:10px 14px;border:2px solid <?= e($g['cor_lt']) ?>;border-radius:10px;margin-bottom:14px;font-size:.85rem;outline:none">
        <?php endif; ?>
        <?php if (empty($g['itens'])): ?>
        <p style="color:#888;text-align:center;padding:30px">Nenhum áudio encontrado.</p>
        <?php else: ?>
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(270px,1fr));gap:14px">
        <?php foreach ($g['itens'] as $ci => $m): $dirEnc = implode('/', array_map('rawurlencode', explode('/', $g['dir']))); $url = 'audios/'.$dirEnc.rawurlencode($m['file']); ?>
        <div class="audios-card" data-nome="<?= e(mb_strtolower($m['badge'].' '.$m['titulo'], 'UTF-8')) ?>"
             style="<?= $ci >= 5 ? 'display:none;' : '' ?>background:#fff;border:2px solid <?= e($g['cor_lt']) ?>;border-radius:12px;padding:16px;box-shadow:0 2px 8px rgba(0,0,0,.07)">
            <div style="display:flex;align-items:center;gap:8px;margin-bottom:10px">
                <span style="background:<?= e($g['cor']) ?>;color:#fff;border-radius:7px;padding:3px 10px;font-size:.73rem;font-weight:700;white-space:nowrap"><?= e($m['badge']) ?></span>
                <span style="font-size:.82rem;color:#555;font-weight:600;overflow-wrap:break-word"><?= e($m['titulo']) ?></span>
            </div>
            <!-- Lazy-load: o src fica em data-src e so e ativado quando o card entra
                 na pagina visivel (5 por vez), para nao baixar os 20 metadados de uma vez. -->
            <div style="margin-bottom:10px">
                <div class="audios-spin" style="display:none;align-items:center;justify-content:center;gap:8px;height:36px;color:#999;font-size:.78rem">
                    <span class="audios-spinner" style="border-color:<?= e($g['cor_lt']) ?>;border-top-color:<?= e($g['cor']) ?>"></span> carregando áudio…
                </div>
                <audio class="audios-player" controls preload="none" data-src="<?= e($url) ?>" style="width:100%;height:36px;display:none">
                    Navegador não suporta áudio HTML5.
                </audio>
            </div>
            <a href="<?= e($url) ?>" download="<?= e($m['file']) ?>"
               style="display:flex;align-items:center;justify-content:center;gap:6px;background:<?= e($g['cor_lt']) ?>;color:<?= e($g['cor']) ?>;border:2px solid <?= e($g['cor']) ?>;border-radius:8px;padding:7px 10px;font-size:.8rem;font-weight:700;text-decoration:none">
                ⬇️ Download
            </a>
        </div>
        <?php endforeach; ?>
        </div>
        <p id="audios-vazio-<?= $i ?>" style="display:none;color:#888;text-align:center;padding:30px">Nenhum áudio encontrado para a busca.</p>
        <div id="audios-pag-<?= $i ?>" style="display:none;align-items:center;justify-content:center;gap:14px;margin-top:18px">
            <button type="button" data-dir="prev" onclick="audiosPagina(<?= $i ?>,-1)"
                    style="border:2px solid <?= e($g['cor']) ?>;background:#fff;color:<?= e($g['cor']) ?>;border-radius:8px;padding:7px 14px;font-size:.82rem;font-weight:700;cursor:pointer">◀ Anterior</button>
            <span id="audios-pag-ind-<?= $i ?>" style="font-size:.82rem;color:#666;font-weight:600;min-width:110px;text-align:center"></span>
            <button type="button" data-dir="next" onclick="audiosPagina(<?= $i ?>,1)"
                    style="border:2px solid <?= e($g['cor']) ?>;background:#fff;color:<?= e($g['cor']) ?>;border-radius:8px;padding:7px 14px;font-size:.82rem;font-weight:700;cursor:pointer">Próximo ▶</button>
        </div>
        <?php endif; ?>
    </div>
<?php endforeach; ?>
</div>
<style>
.audios-spinner{width:16px;height:16px;border:2px solid #eee;border-top-color:#999;border-radius:50%;display:inline-block;animation:audios-rot .7s linear infinite}
@keyframes audios-rot{to{transform:rotate(360deg)}}
.audios-pag-btn:disabled,#audios-pag-0 button:disabled,#audios-pag-1 button:disabled,#audios-pag-2 button:disabled{opacity:.4;cursor:default}
</style>
<script>
var AUDIOS_PAGE_SIZE = 5;
var audiosPag = {};

// Ativa o carregamento de um card (define o src e mostra o spinner ate os metadados chegarem).
function audiosLazyLoad(card) {
    var a = card.querySelector('audio.audios-player');
    if (!a || a.getAttribute('src') || !a.getAttribute('data-src')) return;
    var spin = card.querySelector('.audios-spin');
    if (spin) spin.style.display = 'flex';
    a.addEventListener('loadedmetadata', function () {
        if (spin) spin.style.display = 'none';
        a.style.display = '';
    }, { once: true });
    a.addEventListener('error', function () {
        if (spin) spin.innerHTML = '⚠️ não foi possível carregar';
    }, { once: true });
    // preload=metadata para o player buscar os cabecalhos AGORA (fica pronto p/ 1
    // clique). So os 5 visiveis chegam aqui; os demais nunca recebem src.
    a.preload = 'metadata';
    a.setAttribute('src', a.getAttribute('data-src'));
    a.load();
}

function audiosCardsVisiveis(idx) {
    var busca = document.getElementById('audios-busca-' + idx);
    var q = busca ? busca.value.toLowerCase().trim() : '';
    var todos = Array.prototype.slice.call(document.querySelectorAll('#audios-painel-' + idx + ' .audios-card'));
    return todos.filter(function (c) { return !q || c.getAttribute('data-nome').indexOf(q) !== -1; });
}

function audiosRender(idx) {
    var visiveis = audiosCardsVisiveis(idx);
    document.querySelectorAll('#audios-painel-' + idx + ' .audios-card').forEach(function (c) { c.style.display = 'none'; });

    var totalPag = Math.max(1, Math.ceil(visiveis.length / AUDIOS_PAGE_SIZE));
    var pag = Math.min(Math.max(1, audiosPag[idx] || 1), totalPag);
    audiosPag[idx] = pag;

    var inicio = (pag - 1) * AUDIOS_PAGE_SIZE;
    visiveis.slice(inicio, inicio + AUDIOS_PAGE_SIZE).forEach(function (c) {
        c.style.display = '';
        audiosLazyLoad(c);
    });

    var vazio = document.getElementById('audios-vazio-' + idx);
    if (vazio) vazio.style.display = visiveis.length === 0 ? '' : 'none';

    var ctrl = document.getElementById('audios-pag-' + idx);
    if (ctrl) {
        ctrl.style.display = visiveis.length > AUDIOS_PAGE_SIZE ? 'flex' : 'none';
        var ind = document.getElementById('audios-pag-ind-' + idx);
        if (ind) ind.textContent = 'Página ' + pag + ' de ' + totalPag;
        var prev = ctrl.querySelector('[data-dir="prev"]'), next = ctrl.querySelector('[data-dir="next"]');
        if (prev) prev.disabled = pag <= 1;
        if (next) next.disabled = pag >= totalPag;
    }
}

function audiosPagina(idx, delta) {
    audiosPag[idx] = (audiosPag[idx] || 1) + delta;
    audiosRender(idx);
    var p = document.getElementById('audios-painel-' + idx);
    if (p) p.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

function audiosFiltrar(idx) {
    audiosPag[idx] = 1;
    audiosRender(idx);
}

function audiosTab(idx, btn) {
    document.querySelectorAll('.audios-painel').forEach(function (p) { p.style.display = 'none'; });
    document.getElementById('audios-painel-' + idx).style.display = '';
    document.querySelectorAll('.audios-tab-btn').forEach(function (b) {
        b.style.background = '#fff';
        b.style.color = b.getAttribute('data-cor');
    });
    btn.style.background = btn.getAttribute('data-cor');
    btn.style.color = '#fff';
    audiosRender(idx); // carrega apenas a pagina 1 deste painel (5 audios)
}

// Ao abrir a pagina, renderiza so o primeiro painel (5 audios), nao os 20 de uma vez.
document.addEventListener('DOMContentLoaded', function () { audiosRender(0); });
</script>

<?php else: // ── QUIZ / INÍCIO ─────────────────────────────── ?>

<!-- TELA RETOMADA (sessões em aberto) -->
<?php if (!empty($openSessions)): ?>
<div class="card" id="tela-retomada" style="display:none;max-width:700px;margin:20px auto;background:#fff8e1;border:2px solid #ffb74d;border-radius:12px;padding:24px;">
    <div style="text-align:center;margin-bottom:16px">
        <div style="font-size:40px;margin-bottom:8px">🔄</div>
        <h3 style="color:#ef6c00;margin-bottom:4px">Sessões em andamento</h3>
        <p style="color:#666;font-size:.85rem">Escolha qual deseja continuar. Marque as que deseja encerrar.</p>
    </div>
    <div style="display:flex;flex-direction:column;gap:10px;margin-bottom:16px">
    <?php foreach ($openSessions as $os): ?>
        <div class="open-session-item" data-id="<?= (int)$os['id'] ?>" style="display:flex;align-items:center;gap:12px;background:#fff;border:2px solid #e0e0e0;border-radius:10px;padding:12px 16px;cursor:pointer;transition:var(--tr)" onclick="selectOpenSession(this, <?= (int)$os['id'] ?>)">
            <input type="radio" name="pick_session" value="<?= (int)$os['id'] ?>" style="width:18px;height:18px;accent-color:var(--verde-md);flex-shrink:0">
            <div style="flex:1;min-width:0">
                <div style="font-weight:700;font-size:.9rem;color:var(--texto)">
                    <?= strtoupper(e($os['tipo'])) ?> — <?= e($os['categorias_nomes'] ?: 'Sem categoria') ?>
                </div>
                <div style="font-size:.78rem;color:#888;margin-top:2px">
                    Tentativa #<?= (int)$os['numero_tentativa'] ?> · <?= (int)$os['total_respondidas'] ?> respondidas · <?= (int)$os['total_acertos'] ?> acertos · <?= date('d/m/Y H:i', strtotime($os['created_at'])) ?>
                </div>
            </div>
            <label style="display:flex;align-items:center;gap:4px;font-size:.75rem;color:#c62828;cursor:pointer;flex-shrink:0" onclick="event.stopPropagation()">
                <input type="checkbox" class="remove-session" value="<?= (int)$os['id'] ?>" style="width:15px;height:15px;accent-color:#c62828"> encerrar
            </label>
        </div>
    <?php endforeach; ?>
    </div>
    <div style="display:flex;gap:10px;justify-content:center;flex-wrap:wrap">
        <button class="btn btn-primary" onclick="confirmarRetomada()">✅ Continuar selecionada</button>
        <button class="btn btn-outline" onclick="novoQuiz()">🆕 Começar nova</button>
    </div>
</div>
<script>
window.openSessionsExist = true;
</script>
<?php endif; ?>

<!-- TELA INICIAL -->
<?php
$modoAtual   = $modoParam === 'prova' ? 'prova' : 'quiz';
$categoriasModo = array_values(array_filter($categorias, function($c) use ($modoAtual) {
    $isProva = stripos($c['nome'], 'prova') !== false;
    return $modoAtual === 'prova' ? $isProva : !$isProva;
}));
?>
<div id="tela-inicio" class="card">
    <div style="text-align:center;margin-bottom:24px">
        <span style="font-size:52px;display:block;margin-bottom:8px"><?= $modoAtual === 'prova' ? '🎯' : '📚' ?></span>
        <h2 style="color:var(--verde);font-size:1.5rem"><?= $modoAtual === 'prova' ? 'Provas da PMRR' : 'Quiz de Legislações da PMRR' ?></h2>
        <p style="color:#666;margin-top:6px"><?= $modoAtual === 'prova'
            ? 'Selecione a prova que deseja realizar. Questões revisadas com gabarito e justificativa.'
            : 'Selecione as legislações que deseja estudar. Perguntas aleatórias com feedback imediato.' ?></p>
    </div>

    <p class="section-titulo"><?= $modoAtual === 'prova' ? '🎯 Provas' : '📚 Legislações' ?></p>
    <?php if ($modoAtual === 'quiz'): ?>
    <div class="cats-acoes">
        <button class="btn-link" onclick="toggleTodas(true)">Marcar todas</button>
        <span style="color:#ccc">|</span>
        <button class="btn-link" onclick="toggleTodas(false)">Desmarcar todas</button>
    </div>
    <?php endif; ?>
    <div class="cats-grid" id="cats-grid">
    <?php foreach($categoriasModo as $c): ?>
        <label class="cat-label <?= $modoAtual === 'quiz' ? 'sel' : '' ?>" id="cat-lbl-<?= (int)$c['id'] ?>" onclick="toggleCat(<?= (int)$c['id'] ?>)">
            <input type="checkbox" id="cat-<?= (int)$c['id'] ?>" value="<?= (int)$c['id'] ?>" <?= $modoAtual === 'quiz' ? 'checked' : '' ?>>
            <div class="cat-check"><?= $modoAtual === 'quiz' ? '✓' : '' ?></div>
            <div class="cat-info">
                <div class="cat-nome"><?= e($c['nome']) ?></div>
                <div class="cat-sub"><?= e($c['descricao'] ?? '') ?></div>
                <span class="cat-total"><?= (int)$c['total'] ?> questões</span>
            </div>
        </label>
    <?php endforeach; ?>
    </div>
    <p class="total-selecionado" id="total-selecionado"></p>
    <button class="btn btn-primary" style="width:100%" onclick="iniciarQuiz()">🚀 Iniciar</button>
</div>
<script>
const MODO_ATUAL = <?= json_encode($modoAtual) ?>;
</script>

<!-- TELA QUIZ -->
<div id="tela-quiz" style="display:none">
    <div id="carregando" class="card" style="display:none">
        <div class="spinner"></div>
        <p>Carregando questão...</p>
    </div>
    <div id="card-questao" class="card" style="display:none">
        <div class="q-meta">
            <span id="q-categoria-badge" class="q-categoria">Categoria</span>
            <span id="q-nivel-badge" class="q-nivel">Nível</span>
            <span id="q-num" class="q-num">#1</span>
            <?php if (isAdmin()): ?>
            <span id="q-id-badge" title="ID da questão no banco (use no painel Admin › Questões)" style="background:#e8eaf6;color:#283593;border:1px solid #c5cae9;border-radius:6px;padding:2px 8px;font-size:.72rem;font-weight:700;cursor:pointer" onclick="copiarIdQuestao()">ID #—</span>
            <button onclick="editarQuestaoAtual()" title="Editar esta questão" style="margin-left:auto;background:#eef2ff;color:#3949ab;border:1px solid #c5cae9;border-radius:6px;padding:3px 10px;font-size:.75rem;cursor:pointer">✏️ Editar</button>
            <?php endif; ?>
        </div>
        <div id="enunciado">Carregando...</div>
        <div class="opcoes" id="opcoes-container"></div>
        <div id="feedback">
            <div class="fb-header" id="fb-header">
                <div class="fb-icone" id="fb-icone"></div>
                <div>
                    <div class="fb-titulo" id="fb-titulo"></div>
                    <div class="fb-subtitulo" id="fb-subtitulo"></div>
                </div>
            </div>
            <div class="fb-body" id="fb-body">
                <div id="fb-resp-errada-div" class="fb-resp-errada" style="display:none">
                    <strong>❌ Sua resposta:</strong> <span id="fb-resp-errada-texto"></span>
                </div>
                <div class="fb-resp-certa">
                    <strong>✅ Resposta correta:</strong> <span id="fb-resp-certa-texto"></span>
                </div>
                <div class="fb-explicacao-titulo">📖 Explicação</div>
                <div class="fb-explicacao" id="fb-explicacao"></div>
                <div class="fb-referencia" id="fb-referencia"></div>
                <div class="fb-acoes">
                    <button class="btn btn-primary" onclick="proximaQuestao()">➡️ Próxima</button>
                    <button class="btn btn-outline" onclick="finalizarQuiz()">🏁 Finalizar</button>
                    <button class="btn btn-sm" style="background:#fff3e0;color:#e65100;border:1px solid #ffb74d;margin-left:auto" onclick="abrirReporte()">⚠️ Reportar erro</button>
                    <?php if (isAdmin()): ?>
                    <button class="btn btn-sm" style="background:#eef2ff;color:#3949ab;border:1px solid #c5cae9" onclick="editarQuestaoAtual()">✏️ Editar questão</button>
                    <?php endif; ?>
                </div>
                <!-- Modal reportar -->
                <div id="modal-reportar" style="display:none;margin-top:14px;background:#fff8e1;border:2px solid #ffb74d;border-radius:10px;padding:16px">
                    <p style="font-weight:700;color:#e65100;margin-bottom:8px">⚠️ Reportar questão incorreta</p>
                    <p style="font-size:.82rem;color:#666;margin-bottom:10px">A questão será inativada automaticamente para análise do administrador.</p>
                    <textarea id="report-justificativa" rows="3" placeholder="Descreva o erro encontrado (opcional)" style="width:100%;padding:10px;border:1px solid #ddd;border-radius:8px;font-size:.88rem;resize:vertical;font-family:inherit"></textarea>
                    <div style="display:flex;gap:8px;margin-top:10px">
                        <button class="btn btn-sm btn-danger" onclick="enviarReporte()">Confirmar reporte</button>
                        <button class="btn btn-sm btn-outline" onclick="fecharReporte()">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- TELA RESULTADO -->
<div id="tela-resultado" class="card" style="display:none;text-align:center">
    <div class="res-trofeu" id="res-trofeu">🏆</div>
    <h2 style="color:var(--verde);font-size:1.6rem">Resultado Final</h2>
    <p id="res-tentativa-label" style="color:#888;font-size:.85rem;margin:4px 0 20px"></p>
    <div class="res-grid">
        <div class="res-card acertos"><span id="res-acertos">0</span><small>Acertos</small></div>
        <div class="res-card erros"><span id="res-erros">0</span><small>Erros</small></div>
        <div class="res-card total"><span id="res-total">0</span><small>Respondidas</small></div>
    </div>
    <div class="barra-wrap"><div class="barra-fill" id="barra-fill" style="width:0%"></div></div>
    <p class="pct-texto" id="pct-texto">0% de aproveitamento</p>
    <div class="classificacao" id="classificacao-texto"></div>
    <div style="display:flex;gap:10px;justify-content:center;flex-wrap:wrap">
        <button class="btn btn-primary" onclick="reiniciar()">🔄 Novo Quiz</button>
        <a href="?p=historico" class="btn btn-outline">📋 Ver Histórico</a>
    </div>
    <div id="res-revisao" style="display:none;margin-top:28px;text-align:left"></div>
</div>

<?php endif; ?>
        </section>
    </div>
</main>

<script>
function toggleSenha(id, btn) {
    const inp = document.getElementById(id);
    if (!inp) return;
    const show = inp.type === 'password';
    inp.type = show ? 'text' : 'password';
    btn.textContent = show ? '🙈' : '👁️';
}

// Estado global
let sessaoId    = <?= !empty($_SESSION['sessao_id']) ? json_encode($_SESSION['sessao_id']) : 'null' ?>;
let nomeUsuario = '';
let numQuestao  = 0;
let totalQuestoes = 0;
let respondendo = false;
let tipoSessao  = 'quiz';
let numTentativa = 1;

// ── MODAL CUSTOMIZADO ────────────────────────────────────────
function modalAlert(msg, icon) {
    return new Promise(resolve => {
        const ov = document.getElementById('modal-overlay');
        document.getElementById('modal-icon').textContent = icon || 'ℹ️';
        document.getElementById('modal-msg').innerHTML = msg;
        document.getElementById('modal-btns').innerHTML = '<button class="modal-btn modal-btn-ok" id="modal-ok-btn">OK</button>';
        ov.classList.add('show');
        document.getElementById('modal-ok-btn').onclick = () => { ov.classList.remove('show'); resolve(); };
    });
}
function modalConfirm(msg, icon) {
    return new Promise(resolve => {
        const ov = document.getElementById('modal-overlay');
        document.getElementById('modal-icon').textContent = icon || '⚠️';
        document.getElementById('modal-msg').innerHTML = msg;
        document.getElementById('modal-btns').innerHTML = '<button class="modal-btn modal-btn-ok" id="modal-yes">Confirmar</button><button class="modal-btn modal-btn-cancel" id="modal-no">Cancelar</button>';
        ov.classList.add('show');
        document.getElementById('modal-yes').onclick = () => { ov.classList.remove('show'); resolve(true); };
        document.getElementById('modal-no').onclick = () => { ov.classList.remove('show'); resolve(false); };
    });
}

// ── AUTH ──────────────────────────────────────────────────────
function mostraTab(tab) {
    document.getElementById('form-login').style.display    = tab === 'login'    ? '' : 'none';
    document.getElementById('form-cadastro').style.display = tab === 'cadastro' ? '' : 'none';
    document.getElementById('form-esqueci').style.display  = tab === 'esqueci'  ? '' : 'none';
    document.getElementById('tab-login').classList.toggle('ativa', tab === 'login');
    document.getElementById('tab-cadastro').classList.toggle('ativa', tab === 'cadastro');
    // 'esqueci' não tem aba, apenas oculta as outras
    if (tab === 'esqueci') {
        document.getElementById('tab-login').classList.remove('ativa');
        document.getElementById('tab-cadastro').classList.remove('ativa');
    }
    limparMsgs();
}

async function fazerLogin() {
    const email   = (document.getElementById('login-email')?.value || '').trim();
    const senha   = document.getElementById('login-senha')?.value || '';
    const lembrar = document.getElementById('login-lembrar')?.checked;
    const resp    = await post({ acao:'login', email, senha });
    if (resp.erro) { mostrarMsg('err', resp.erro); return; }
    if (lembrar) { localStorage.setItem('quiz_email', email); } else { localStorage.removeItem('quiz_email'); }
    window.location.href = resp.status === 'aprovado' ? '?p=cursos' : window.location.pathname;
}

async function esqueceuSenha() {
    const email = (document.getElementById('esq-email')?.value || '').trim();
    const resp  = await post({ acao:'esqueci_senha', email });
    if (resp.erro) { mostrarMsg('err', resp.erro); return; }
    mostrarMsg('ok', '📧 ' + resp.msg);
    if (document.getElementById('esq-email')) document.getElementById('esq-email').value = '';
}

async function resetarSenha(token) {
    const senha   = document.getElementById('reset-senha')?.value    || '';
    const confirma = document.getElementById('reset-confirma')?.value || '';
    const resp    = await post({ acao:'resetar_senha', token, senha, confirma });
    const okEl    = document.getElementById('msg-reset-ok');
    const errEl   = document.getElementById('msg-reset-err');
    if (okEl)  okEl.style.display  = 'none';
    if (errEl) errEl.style.display = 'none';
    if (resp.erro) {
        if (errEl) { errEl.textContent = resp.erro; errEl.style.display = 'block'; }
        return;
    }
    if (okEl) { okEl.textContent = '✅ ' + resp.msg; okEl.style.display = 'block'; }
    setTimeout(() => { window.location.href = window.location.pathname; }, 2500);
}

async function fazerCadastro() {
    const resp = await post({
        acao:      'cadastrar',
        nome:      document.getElementById('cad-nome')?.value || '',
        guerra:    document.getElementById('cad-guerra')?.value || '',
        email:     document.getElementById('cad-email')?.value || '',
        matricula: document.getElementById('cad-mat')?.value || '',
        senha:     document.getElementById('cad-senha')?.value || '',
        confirma:  document.getElementById('cad-confirma')?.value || '',
    });
    if (resp.erro) { mostrarMsg('err', resp.erro); return; }
    mostrarMsg('ok', '✅ ' + resp.msg);
    document.querySelectorAll('#form-cadastro input').forEach(i => i.value = '');
}

async function fazerLogout() {
    localStorage.removeItem('quiz_email');
    try { await fetch(window.location.pathname + '?p=inicio', { method:'POST', body: new URLSearchParams({ acao:'logout' }) }); } catch(e) {}
    window.location.replace(window.location.pathname + '?p=inicio&logout=1');
}

function mostrarMsg(tipo, texto) {
    const ok  = document.getElementById('msg-auth-ok');
    const err = document.getElementById('msg-auth-err');
    if (!ok || !err) return;
    ok.style.display = 'none'; err.style.display = 'none';
    const el = tipo === 'ok' ? ok : err;
    el.innerHTML = texto; el.style.display = 'block';
}
function limparMsgs() {
    const ok = document.getElementById('msg-auth-ok');
    const err = document.getElementById('msg-auth-err');
    if (ok)  { ok.style.display = 'none'; }
    if (err) { err.style.display = 'none'; }
}

// Enter no login
['login-email','login-senha'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.addEventListener('keydown', e => { if(e.key==='Enter') fazerLogin(); });
});

// Exibir aviso de kick se houver mensagem pré-preenchida
const kickEl = document.getElementById('msg-auth-err');
if (kickEl && kickEl.textContent.trim()) kickEl.style.display = 'block';

// Máscara automática para Matrícula PM: ##.###-#
const matEl = document.getElementById('cad-mat');
if (matEl) {
    matEl.addEventListener('input', function() {
        const sel   = this.selectionStart;
        const prev  = this.value;
        let digits  = prev.replace(/\D/g, '').slice(0, 7);
        let masked  = '';
        if (digits.length > 0) masked += digits.slice(0, 2);
        if (digits.length > 2) masked += '.' + digits.slice(2, 5);
        if (digits.length > 5) masked += '-' + digits.slice(5, 7);
        this.value  = masked;
    });
    matEl.addEventListener('keydown', function(e) {
        // Permitir backspace/delete/setas sem bloquear
        if (['Backspace','Delete','ArrowLeft','ArrowRight','Tab'].includes(e.key)) return;
        // Bloquear teclas não-numéricas
        if (!/^\d$/.test(e.key)) e.preventDefault();
    });
}

// ── ADMIN ─────────────────────────────────────────────────────
function showAdminTab(tab) {
    document.getElementById('admin-pendentes').style.display  = tab === 'pendentes'  ? '' : 'none';
    document.getElementById('admin-aprovados').style.display  = tab === 'aprovados'  ? '' : 'none';
    const repDiv = document.getElementById('admin-reportadas');
    if (repDiv) repDiv.style.display = tab === 'reportadas' ? '' : 'none';
    const onlDiv = document.getElementById('admin-online');
    if (onlDiv) onlDiv.style.display = tab === 'online' ? '' : 'none';
    const ativDiv = document.getElementById('admin-atividades');
    if (ativDiv) ativDiv.style.display = tab === 'atividades' ? '' : 'none';
    const questDiv = document.getElementById('admin-questoes');
    if (questDiv) questDiv.style.display = tab === 'questoes' ? '' : 'none';
    document.getElementById('atab-pend').classList.toggle('ativo', tab === 'pendentes');
    document.getElementById('atab-aprov').classList.toggle('ativo', tab === 'aprovados');
    const repTab = document.getElementById('atab-report');
    if (repTab) repTab.classList.toggle('ativo', tab === 'reportadas');
    const onlTab = document.getElementById('atab-online');
    if (onlTab) onlTab.classList.toggle('ativo', tab === 'online');
    const ativTab = document.getElementById('atab-ativ');
    if (ativTab) ativTab.classList.toggle('ativo', tab === 'atividades');
    const questTab = document.getElementById('atab-quest');
    if (questTab) questTab.classList.toggle('ativo', tab === 'questoes');
    if (tab === 'reportadas') carregarReportadas();
    if (tab === 'online') carregarOnline();
    if (tab === 'atividades') carregarAtividades();
}

// ── Edição de questões pelo admin ────────────────────────────
async function buscarQuestoes() {
    const termo  = (document.getElementById('quest-termo')||{}).value || '';
    const filtro = (document.getElementById('quest-filtro')||{}).value || 'todas';
    const list = document.getElementById('quest-list');
    if (!list) return;
    list.innerHTML = '<p style="color:#888;text-align:center;padding:20px">Buscando…</p>';
    const resp = await postRaw({ acao:'buscar_questoes', termo: termo, filtro: filtro });
    if (!resp.ok) { list.innerHTML = '<p style="color:#c62828;text-align:center;padding:20px">Erro na busca.</p>'; return; }
    const qs = resp.questoes || [];
    if (qs.length === 0) { list.innerHTML = '<p style="color:#888;text-align:center;padding:20px">Nenhuma questão encontrada.</p>'; return; }
    QUESTOES_CACHE = {};
    let html = '';
    qs.forEach(q => {
        QUESTOES_CACHE[q.id] = q;
        const resumo = (q.enunciado||'').substring(0,140) + ((q.enunciado||'').length>140?'…':'');
        const ativa = q.ativa == 1
            ? '<span style="color:#1a5c2e;font-size:.72rem">● ativa</span>'
            : '<span style="color:#c62828;font-size:.72rem">● inativa</span>';
        html += '<div id="qedit-wrap-'+q.id+'" style="border:1px solid #e0e0e0;border-radius:10px;padding:14px;margin-bottom:12px;background:#fff">'
            + '<div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap">'
            +   '<code style="background:#f0f0f0;padding:2px 8px;border-radius:6px;font-size:.8rem">#'+q.id+'</code>'
            +   ativa
            +   '<span style="font-size:.72rem;color:#999">'+escHtml(q.categoria_nome||'')+'</span>'
            +   '<span style="font-size:.72rem;color:#bbb">gabarito: <strong>'+escHtml(q.resposta_correta||'')+'</strong></span>'
            +   '<button class="btn-aprovar" onclick="abrirEditorQuestao('+q.id+')" style="margin-left:auto;font-size:.75rem;padding:5px 12px">✏️ Editar</button>'
            + '</div>'
            + '<p style="font-size:.86rem;color:#333;margin-top:8px;line-height:1.5">'+escHtml(resumo)+'</p>'
            + '<div id="qedit-form-'+q.id+'"></div>'
            + '</div>';
    });
    list.innerHTML = html;
}

let QUESTOES_CACHE = {};

// A partir de um card reportado, abre a aba Questões já com o editor da questão aberto.
async function editarQuestaoReportada(qId) {
    showAdminTab('questoes');
    const campo = document.getElementById('quest-termo');
    if (campo) campo.value = String(qId);
    const filtro = document.getElementById('quest-filtro');
    if (filtro) filtro.value = 'todas';
    await buscarQuestoes();
    abrirEditorQuestao(qId);
    const wrap = document.getElementById('qedit-wrap-'+qId);
    if (wrap) wrap.scrollIntoView({behavior:'smooth', block:'center'});
}

function campoOpcao(id, letra, valor, correta) {
    const checked = (letra === correta) ? 'checked' : '';
    return '<div style="display:flex;align-items:flex-start;gap:8px;margin-bottom:6px">'
        + '<label style="display:flex;align-items:center;gap:4px;font-weight:700;color:#1a5c2e;padding-top:8px;white-space:nowrap">'
        +   '<input type="radio" name="qcorreta-'+id+'" value="'+letra+'" '+checked+'> '+letra+')'
        + '</label>'
        + '<textarea id="qop-'+letra+'-'+id+'" rows="2" style="flex:1;padding:7px 9px;border-radius:6px;border:1px solid #ddd;font-size:.85rem;font-family:inherit;resize:vertical">'+escHtml(valor||'')+'</textarea>'
        + '</div>';
}

// Campos do formulário de edição (reutilizado no painel e no modal do quiz).
function htmlCamposQuestao(q) {
    const id = q.id;
    const c = (q.resposta_correta||'').toUpperCase();
    return '<label style="font-size:.78rem;color:#555;font-weight:600">Enunciado</label>'
        + '<textarea id="qenun-'+id+'" rows="4" style="width:100%;padding:8px 10px;border-radius:6px;border:1px solid #ddd;font-size:.88rem;font-family:inherit;resize:vertical;margin-bottom:10px">'+escHtml(q.enunciado||'')+'</textarea>'
        + '<label style="font-size:.78rem;color:#555;font-weight:600">Alternativas <span style="font-weight:400;color:#999">(marque a correta à esquerda; deixe em branco para não usar)</span></label>'
        + '<div style="margin:6px 0 10px">'
        +   campoOpcao(id,'A',q.opcao_a,c) + campoOpcao(id,'B',q.opcao_b,c) + campoOpcao(id,'C',q.opcao_c,c)
        +   campoOpcao(id,'D',q.opcao_d,c) + campoOpcao(id,'E',q.opcao_e,c)
        + '</div>'
        + '<label style="font-size:.78rem;color:#555;font-weight:600">Explicação</label>'
        + '<textarea id="qexp-'+id+'" rows="4" style="width:100%;padding:8px 10px;border-radius:6px;border:1px solid #ddd;font-size:.86rem;font-family:inherit;resize:vertical;margin-bottom:10px">'+escHtml(q.explicacao||'')+'</textarea>'
        + '<div style="display:flex;gap:10px;flex-wrap:wrap;margin-bottom:12px">'
        +   '<div style="flex:1;min-width:200px"><label style="font-size:.78rem;color:#555;font-weight:600">Referência legal</label>'
        +     '<input type="text" id="qref-'+id+'" value="'+escHtml(q.referencia_legal||'')+'" style="width:100%;padding:7px 9px;border-radius:6px;border:1px solid #ddd;font-size:.85rem"></div>'
        +   '<div><label style="font-size:.78rem;color:#555;font-weight:600">Nível</label><br>'
        +     '<select id="qniv-'+id+'" style="padding:7px;border-radius:6px;border:1px solid #ddd">'
        +       '<option value="facil" '+(q.nivel==='facil'?'selected':'')+'>Fácil</option>'
        +       '<option value="medio" '+(q.nivel==='medio'?'selected':'')+'>Médio</option>'
        +       '<option value="dificil" '+(q.nivel==='dificil'?'selected':'')+'>Difícil</option>'
        +     '</select></div>'
        + '</div>';
}

function abrirEditorQuestao(id) {
    const q = QUESTOES_CACHE[id];
    const box = document.getElementById('qedit-form-'+id);
    if (!q || !box) return;
    if (box.innerHTML) { box.innerHTML = ''; return; }   // toggle: fecha se já aberto
    box.innerHTML =
        '<div style="border-top:1px dashed #ddd;margin-top:12px;padding-top:12px">'
        + htmlCamposQuestao(q)
        + '<button class="btn-aprovar" onclick="salvarQuestao('+id+')" style="font-size:.82rem;padding:8px 18px">💾 Salvar alterações</button>'
        + '<button class="btn-rejeitar" onclick="abrirEditorQuestao('+id+')" style="font-size:.82rem;padding:8px 14px;margin-left:8px">Cancelar</button>'
        + '</div>';
}

// ── Editor em modal (usado na tela do quiz, ao responder) ────
async function editarQuestaoAtual() {
    if (!questaoAtualId) { await modalAlert('Nenhuma questão carregada.', '⚠️'); return; }
    const id = questaoAtualId;
    // Busca a questão completa (o quiz não expõe gabarito/explicação ao cliente).
    const resp = await postRaw({ acao:'buscar_questoes', termo: String(id), filtro:'todas' });
    const q = (resp.questoes || []).find(x => String(x.id) === String(id));
    if (!q) { await modalAlert('Não foi possível carregar a questão para edição.', '❌'); return; }
    QUESTOES_CACHE[id] = q;
    let ov = document.getElementById('modal-editor-questao');
    if (!ov) {
        ov = document.createElement('div');
        ov.id = 'modal-editor-questao';
        ov.style.cssText = 'position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;display:flex;align-items:flex-start;justify-content:center;overflow-y:auto;padding:30px 12px';
        document.body.appendChild(ov);
    }
    ov.innerHTML = '<div style="background:#fff;border-radius:12px;max-width:720px;width:100%;padding:22px;box-shadow:0 10px 40px rgba(0,0,0,.3)">'
        + '<div style="display:flex;align-items:center;gap:10px;margin-bottom:14px">'
        +   '<h3 style="color:var(--verde);margin:0">✏️ Editar questão</h3>'
        +   '<code style="background:#f0f0f0;padding:2px 8px;border-radius:6px;font-size:.8rem">#'+id+'</code>'
        +   '<button onclick="fecharEditorQuestao()" style="margin-left:auto;background:none;border:none;font-size:1.4rem;cursor:pointer;color:#999">×</button>'
        + '</div>'
        + htmlCamposQuestao(q)
        + '<div style="display:flex;gap:8px;margin-top:6px">'
        +   '<button class="btn-aprovar" onclick="salvarQuestao('+id+', true)" style="font-size:.85rem;padding:9px 20px">💾 Salvar alterações</button>'
        +   '<button class="btn-rejeitar" onclick="fecharEditorQuestao()" style="font-size:.85rem;padding:9px 16px">Cancelar</button>'
        + '</div></div>';
    ov.style.display = 'flex';
}
function fecharEditorQuestao() {
    const ov = document.getElementById('modal-editor-questao');
    if (ov) ov.style.display = 'none';
}
// Copia o ID da questão atual (para colar no painel Admin › Questões).
async function copiarIdQuestao() {
    if (!questaoAtualId) return;
    try { await navigator.clipboard.writeText(String(questaoAtualId)); } catch(e) {}
    await modalAlert('ID da questão: <strong>#' + questaoAtualId + '</strong><br>Copiado! Cole no painel Admin › Questões para editar.', '📋');
}

async function salvarQuestao(id, fromModal) {
    const val = sel => (document.getElementById(sel)||{}).value || '';
    const correta = (document.querySelector('input[name="qcorreta-'+id+'"]:checked')||{}).value || '';
    if (!correta) { await modalAlert('Marque qual alternativa é a correta.', '⚠️'); return; }
    const dados = {
        acao: 'salvar_questao', id: id,
        enunciado: val('qenun-'+id),
        opcao_a: val('qop-A-'+id), opcao_b: val('qop-B-'+id), opcao_c: val('qop-C-'+id),
        opcao_d: val('qop-D-'+id), opcao_e: val('qop-E-'+id),
        resposta_correta: correta,
        explicacao: val('qexp-'+id),
        referencia_legal: val('qref-'+id),
        nivel: val('qniv-'+id)
    };
    const resp = await postRaw(dados);
    if (resp.ok) {
        if (fromModal) {
            fecharEditorQuestao();
            // Atualiza a explicação/feedback exibido se a questão já foi respondida.
            const fbExp = document.getElementById('fb-explicacao');
            if (fbExp && dados.explicacao) fbExp.textContent = dados.explicacao;
        }
        await modalAlert(resp.msg || 'Salvo!', '✅');
        if (!fromModal && typeof buscarQuestoes === 'function' && document.getElementById('quest-list')) buscarQuestoes();
    } else {
        await modalAlert(resp.erro || 'Falha ao salvar.', '❌');
    }
}

// ── Timeline de atividades (tempo real) ──────────────────────
const EVENTO_ICONES = {
    navegou:'🧭', download:'⬇️', abriu_documento:'📄', ouviu_audio:'🎧',
    iniciou_quiz:'🚀', finalizou_quiz:'🏁', iniciou_prova:'🎯', finalizou_prova:'🏆'
};
function iconeEvento(ev){ return EVENTO_ICONES[ev] || '•'; }
function rotuloEvento(ev){
    const r = {navegou:'Navegou',download:'Baixou',abriu_documento:'Abriu documento',ouviu_audio:'Ouviu áudio',
        iniciou_quiz:'Iniciou quiz',finalizou_quiz:'Finalizou quiz',iniciou_prova:'Iniciou prova',finalizou_prova:'Finalizou prova'};
    return r[ev] || ev;
}
async function carregarAtividades() {
    const sel = document.getElementById('ativ-militar');
    const list = document.getElementById('ativ-list');
    const status = document.getElementById('ativ-status');
    if (!list) return;
    const militarId = sel ? sel.value : 0;
    const dataIni = (document.getElementById('ativ-ini')||{}).value || '';
    const dataFim = (document.getElementById('ativ-fim')||{}).value || '';
    const resp = await postRaw({ acao:'listar_atividades', militar_id: militarId, data_ini: dataIni, data_fim: dataFim, limite: (dataIni||dataFim) ? 500 : 80 });
    if (!resp.ok) { list.innerHTML = '<p style="color:#c62828;text-align:center;padding:20px">Erro ao carregar.</p>'; return; }
    const ats = resp.atividades || [];
    if (status) status.textContent = 'Atualizado agora · ' + ats.length + ' evento(s)';
    if (ats.length === 0) { list.innerHTML = '<p style="color:#888;text-align:center;padding:20px">Nenhuma atividade registrada.</p>'; return; }
    const todos = militarId === '0' || militarId === 0;
    let html = '<div style="overflow-x:auto"><table class="admin-tabela"><thead><tr><th>Quando</th>'+(todos?'<th>Militar</th>':'')+'<th>Evento</th><th>Detalhe</th></tr></thead><tbody>';
    ats.forEach(a => {
        html += '<tr><td style="white-space:nowrap;font-size:.8rem;color:#555">'+escHtml(a.criado_em||'')+'</td>';
        if (todos) html += '<td style="font-weight:600;font-size:.82rem">'+escHtml(a.nome_guerra||'')+'</td>';
        html += '<td style="white-space:nowrap;font-size:.82rem">'+iconeEvento(a.evento)+' '+escHtml(rotuloEvento(a.evento))+'</td>';
        html += '<td style="font-size:.82rem;color:#333">'+(a.detalhe?escHtml(a.detalhe):'<em style="color:#aaa">—</em>')+'</td></tr>';
    });
    html += '</tbody></table></div>';
    list.innerHTML = html;
}
// Exporta as atividades filtradas (militar + período) em CSV.
function exportarAtividades() {
    const sel = document.getElementById('ativ-militar');
    const params = new URLSearchParams({
        export: 'atividades',
        militar_id: sel ? sel.value : '0',
        data_ini: (document.getElementById('ativ-ini')||{}).value || '',
        data_fim: (document.getElementById('ativ-fim')||{}).value || ''
    });
    window.location.href = window.location.pathname + '?' + params.toString();
}
// Auto-refresh a cada 5s enquanto a aba Atividades estiver ativa, o checkbox marcado
// e sem filtro de período aplicado (para não sobrescrever consultas históricas).
setInterval(function(){
    const div = document.getElementById('admin-atividades');
    const auto = document.getElementById('ativ-auto');
    const ini = (document.getElementById('ativ-ini')||{}).value || '';
    const fim = (document.getElementById('ativ-fim')||{}).value || '';
    if (div && div.style.display !== 'none' && auto && auto.checked && !ini && !fim) carregarAtividades();
}, 5000);
async function carregarReportadas() {
    const resp = await postRaw({ acao: 'listar_reportadas' });
    const list = document.getElementById('report-list');
    const load = document.getElementById('report-loading');
    if (!list) return;
    if (load) load.style.display = 'none';
    if (!resp.ok || !resp.reportadas || resp.reportadas.length === 0) {
        list.innerHTML = '<p style="color:#888;text-align:center;padding:30px">Nenhuma questão reportada. ✅</p>';
        return;
    }
    let html = '';
    resp.reportadas.forEach(r => {
        const correta = (r.resposta_correta || '').toUpperCase();
        const resolvida = r.resolvida == 1;
        const status = resolvida
            ? '<span style="background:#e8f5e9;color:#1a5c2e;padding:3px 10px;border-radius:8px;font-size:.75rem">✔ Resolvida</span>'
            : '<span style="background:#fff3e0;color:#e65100;padding:3px 10px;border-radius:8px;font-size:.75rem">⏳ Pendente</span>';
        const ativa = r.ativa == 1
            ? '<span style="color:#1a5c2e;font-size:.72rem">● ativa no quiz</span>'
            : '<span style="color:#c62828;font-size:.72rem">● inativa (fora do quiz)</span>';

        // Alternativas — destaca o gabarito
        let alts = '';
        ['a','b','c','d','e'].forEach(letra => {
            const txt = r['opcao_' + letra];
            if (txt === null || txt === undefined || txt === '') return;
            const isCorreta = letra.toUpperCase() === correta;
            const estilo = isCorreta
                ? 'background:#e8f5e9;border:1px solid #a5d6a7;font-weight:600;color:#1a5c2e'
                : 'background:#fafafa;border:1px solid #eee;color:#444';
            alts += '<div style="'+estilo+';border-radius:6px;padding:7px 10px;margin-bottom:5px;font-size:.85rem">'
                  + '<strong>'+letra.toUpperCase()+')</strong> '+escHtml(txt)
                  + (isCorreta ? ' &nbsp;✅ <em style="font-weight:400">(gabarito)</em>' : '')
                  + '</div>';
        });

        const btnEditar = '<button class="btn-aprovar" onclick="editarQuestaoReportada('+r.questao_id+')" style="font-size:.78rem;margin-left:6px;background:#eef2ff;color:#3949ab;border:1px solid #c5cae9">✏️ Editar questão</button>';
        const acoes = (resolvida ? '' :
            '<button class="btn-aprovar" onclick="reativarQuestao('+r.questao_id+','+r.id+')" style="font-size:.78rem">✅ Reativar</button> ' +
            '<button class="btn-rejeitar" onclick="descartarQuestao('+r.id+')" style="font-size:.78rem;margin-left:6px">🗄️ Manter inativa</button>') + btnEditar;

        html += '<div id="rpt-'+r.id+'" style="border:1px solid #e0e0e0;border-left:4px solid '+(resolvida?'#a5d6a7':'#ffb74d')+';border-radius:10px;padding:16px;margin-bottom:16px;background:#fff">'
            + '<div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;margin-bottom:10px">'
            +   '<code style="background:#f0f0f0;padding:2px 8px;border-radius:6px;font-size:.8rem">Questão #'+r.questao_id+'</code>'
            +   status + ativa
            +   '<span style="margin-left:auto;font-size:.75rem;color:#999;white-space:nowrap">'+escHtml(r.created_at)+'</span>'
            + '</div>'
            + '<p style="font-size:.95rem;line-height:1.6;color:#222;margin-bottom:12px;font-weight:500">'+escHtml(r.enunciado||'')+'</p>'
            + alts
            + (r.explicacao ? '<div style="margin-top:10px;font-size:.82rem;color:#555;background:#f5f9f6;border-radius:6px;padding:8px 10px"><strong>💡 Explicação:</strong> '+escHtml(r.explicacao)+'</div>' : '')
            + (r.referencia_legal ? '<div style="margin-top:6px;font-size:.8rem;color:#00695c"><strong>📖 Base legal:</strong> '+escHtml(r.referencia_legal)+'</div>' : '')
            + '<div style="margin-top:12px;background:#fff8f0;border:1px dashed #ffcc80;border-radius:8px;padding:10px 12px">'
            +   '<div style="font-size:.78rem;color:#e65100;font-weight:700;margin-bottom:3px">⚠️ Reportado por '+escHtml(r.nome_guerra)+'</div>'
            +   '<div style="font-size:.85rem;color:#5d4037">'+(r.justificativa ? escHtml(r.justificativa) : '<em style="color:#aaa">Sem justificativa informada.</em>')+'</div>'
            + '</div>'
            + (acoes ? '<div style="margin-top:12px">'+acoes+'</div>' : '')
            + '</div>';
    });
    list.innerHTML = html;
}
async function reativarQuestao(qId, rId) {
    if (!await modalConfirm('Reativar esta questão?<br>Ela voltará a aparecer no quiz.')) return;
    const resp = await postRaw({ acao: 'reativar_questao', questao_id: qId, report_id: rId });
    if (resp.ok) { await modalAlert(resp.msg, '✅'); carregarReportadas(); } else { await modalAlert(resp.erro || 'Erro', '❌'); }
}
async function descartarQuestao(rId) {
    if (!await modalConfirm('Manter questão inativa e marcar reporte como resolvido?')) return;
    const resp = await postRaw({ acao: 'descartar_questao', report_id: rId });
    if (resp.ok) { await modalAlert(resp.msg, '✅'); carregarReportadas(); } else { await modalAlert(resp.erro || 'Erro', '❌'); }
}
async function aprovar(id) {
    if (!await modalConfirm('Aprovar este cadastro?', '✅')) return;
    const resp = await post({ acao:'aprovar', id });
    if (resp.ok) {
        document.getElementById('row-'+id)?.remove();
        atualizarBadgesAoRemoverAprovacao(true);
    }
}
async function rejeitar(id) {
    if (!await modalConfirm('Rejeitar este cadastro?', '❌')) return;
    const resp = await post({ acao:'rejeitar', id });
    if (resp.ok) {
        document.getElementById('row-'+id)?.remove();
        atualizarBadgesAoRemoverAprovacao(false);
    }
}

// Atualiza badges de pendentes/aprovados no painel admin sem recarregar
function atualizarBadgesAoRemoverAprovacao(isAprovado) {
    // pendentes badge (span dentro do botão atab-pend)
    const pendSpan = document.querySelector('#atab-pend span');
    if (pendSpan) {
        const n = parseInt(pendSpan.textContent || '0', 10);
        if (!isNaN(n)) {
            const novo = Math.max(0, n-1);
            if (novo === 0) pendSpan.remove(); else pendSpan.textContent = novo;
        }
    }
    // aprovados botão tem texto "Aprovados (N)" — atualiza o número
    if (isAprovado) {
        const btn = document.getElementById('atab-aprov');
        if (btn) {
            const m = btn.textContent.match(/\((\d+)\)/);
            const cur = m ? parseInt(m[1],10) : 0;
            const novo = cur + 1;
            btn.innerHTML = 'Aprovados (' + novo + ')';
        }
    }
}

async function postRaw(data) {
    const fd = new FormData();
    for (const k in data) fd.append(k, data[k]);
    const resp = await fetch(window.location.pathname, { method:'POST', body: fd });
    try { return await resp.json(); } catch(e) { return { erro: 'Resposta inválida' }; }
}

async function invalidateNonApproved() {
    if (!await modalConfirm('Invalidar (forçar logout) de todas as sessões de usuários não aprovados?', '🚫')) return;
    const res = await postRaw({ acao: 'invalidate_non_approved' });
    if (res && res.ok) {
        await modalAlert('Sessões invalidadas: ' + (res.invalidated || 0), '✅');
        window.location.reload();
    } else {
        await modalAlert('Erro: ' + (res.erro || 'falha ao invalidar'), '❌');
    }
}

async function carregarOnline() {
    const resp = await postRaw({ acao: 'listar_online' });
    // Atualizar no admin (se existir)
    const adminList = document.getElementById('online-list');
    const adminLoad = document.getElementById('online-loading');
    // Atualizar no histórico (se existir)
    const rtList = document.getElementById('online-realtime-list');
    const rtCount = document.getElementById('online-count');

    if (!resp.ok || !resp.online) return;

    const users = resp.online;
    if (rtCount) rtCount.textContent = users.length;

    if (users.length === 0) {
        const empty = '<p style="color:#aaa;font-size:.85rem;text-align:center;padding:10px">Nenhum militar online no momento.</p>';
        if (adminList) { if (adminLoad) adminLoad.style.display='none'; adminList.innerHTML = empty; }
        if (rtList) rtList.innerHTML = empty;
        return;
    }

    function formatInativo(seg) {
        if (!seg || seg < 30) return '🟢 agora';
        if (seg < 60) return '🟡 há ' + seg + 's';
        const min = Math.floor(seg / 60);
        if (min < 5) return '🟡 há ' + min + 'min';
        return '🟠 há ' + min + 'min';
    }

    // Renderizar cards no painel do histórico
    if (rtList) {
        let html = '<div style="display:flex;flex-wrap:wrap;gap:10px">';
        users.forEach(u => {
            const atividade = u.current_page || 'navegando';
            const sessao = u.sessao_aberta || '';
            const status = formatInativo(u.segundos_inativo);
            html += '<div style="background:#f0faf3;border:1px solid #c8e6c9;border-radius:10px;padding:12px 16px;min-width:220px;flex:1;max-width:320px">';
            html += '<div style="display:flex;align-items:center;gap:8px;margin-bottom:6px">';
            html += '<span style="font-weight:700;color:var(--verde)">'+escHtml(u.nome_guerra)+'</span>';
            html += '<code style="font-size:.72rem;color:#888">'+escHtml(u.matricula)+'</code>';
            html += '</div>';
            html += '<div style="font-size:.8rem;color:#555">📍 '+escHtml(atividade)+'</div>';
            if (u.ultimo_evento) html += '<div style="font-size:.75rem;color:#00695c;margin-top:3px">⚡ '+escHtml(u.ultimo_evento)+'</div>';
            if (sessao) html += '<div style="font-size:.75rem;color:#888;margin-top:3px">📝 '+escHtml(sessao)+'</div>';
            html += '<div style="font-size:.72rem;margin-top:4px">'+status+'</div>';
            html += '</div>';
        });
        html += '</div>';
        rtList.innerHTML = html;
    }

    // Renderizar tabela no admin (se existir)
    if (adminList) {
        if (adminLoad) adminLoad.style.display='none';
        let html = '<div style="overflow-x:auto"><table class="admin-tabela"><thead><tr><th>Status</th><th>Nome Guerra</th><th>Matrícula</th><th>Página</th><th>Último evento</th><th>Sessão</th><th>Inativo</th></tr></thead><tbody>';
        users.forEach(u => {
            const status = formatInativo(u.segundos_inativo);
            html += '<tr><td>'+status+'</td><td style="font-weight:700">'+escHtml(u.nome_guerra)+'</td><td><code>'+escHtml(u.matricula)+'</code></td><td style="font-size:.82rem">'+escHtml(u.current_page||'—')+'</td><td style="font-size:.82rem;color:#00695c">'+(u.ultimo_evento?escHtml(u.ultimo_evento):'—')+'</td><td style="font-size:.82rem">'+(u.sessao_aberta?escHtml(u.sessao_aberta):'—')+'</td><td style="font-size:.82rem;white-space:nowrap">'+(u.last_activity||'—')+'</td></tr>';
        });
        html += '</tbody></table></div>';
        adminList.innerHTML = html;
    }
}

// Auto-refresh do painel online a cada 15 segundos
(function(){
    const rtList = document.getElementById('online-realtime-list');
    if (!rtList) return;
    carregarOnline();
    setInterval(carregarOnline, 15000);
})();

async function alterarSenhaAdmin(id, nome) {
    const nova = prompt('Nova senha para ' + nome + ' (mínimo 6 caracteres):');
    if (!nova || nova.length < 6) { if (nova !== null) await modalAlert('Senha deve ter no mínimo 6 caracteres.', '⚠️'); return; }
    if (!await modalConfirm('Alterar a senha de <strong>' + escHtml(nome) + '</strong>?', '🔑')) return;
    const res = await post({ acao: 'admin_alterar_senha', id, nova_senha: nova });
    if (res && res.ok) {
        await modalAlert(res.msg, '✅');
    } else {
        await modalAlert('Erro: ' + (res.erro || 'falha'), '❌');
    }
}

async function toggleAdmin(id, tornar, nome) {
    const acaoTxt = tornar ? 'tornar <strong>' + escHtml(nome) + '</strong> administrador' : 'remover o acesso de administrador de <strong>' + escHtml(nome) + '</strong>';
    const aviso = tornar ? '<br><small style="color:#666">Ele passará a ver o Painel Admin e poderá gerenciar o sistema.</small>'
                         : '<br><small style="color:#666">A sessão dele será encerrada para aplicar a mudança.</small>';
    if (!await modalConfirm('Deseja ' + acaoTxt + '?' + aviso, tornar ? '⭐' : '⬇️')) return;
    const res = await post({ acao: 'admin_toggle_admin', id, tornar });
    if (res && res.ok) {
        await modalAlert(res.msg, '✅');
        // Atualiza a linha sem recarregar a página inteira
        const perfil = document.getElementById('perfil-' + id);
        const btn = document.getElementById('btnadmin-' + id);
        if (perfil) perfil.innerHTML = res.is_admin
            ? '<span style="background:#e8eaf6;color:#283593;padding:2px 8px;border-radius:8px;font-size:.72rem;font-weight:700">⭐ Admin</span>'
            : '<span style="color:#888;font-size:.75rem">Militar</span>';
        if (btn) {
            if (res.is_admin) {
                btn.textContent = '⬇️ Rebaixar'; btn.className = 'btn-rejeitar';
                btn.setAttribute('style', 'font-size:.75rem;padding:4px 8px;margin-left:4px');
                btn.onclick = () => toggleAdmin(id, 0, nome);
            } else {
                btn.textContent = '⭐ Tornar admin'; btn.className = 'btn-aprovar';
                btn.setAttribute('style', 'font-size:.75rem;padding:4px 8px;margin-left:4px;background:#e8eaf6;color:#283593;border:1px solid #c5cae9');
                btn.onclick = () => toggleAdmin(id, 1, nome);
            }
        }
    } else {
        await modalAlert('Erro: ' + (res.erro || 'falha'), '❌');
    }
}

async function detectAndRejectSuspects() {
    if (!await modalConfirm('Detectar cadastros suspeitos (domínios descartáveis / matrícula inválida) e rejeitá-los?', '🕵️')) return;
    const res = await postRaw({ acao: 'reject_suspects' });
    if (res && res.ok) {
        await modalAlert('Cadastros rejeitados: ' + (res.rejected || 0), '✅');
        window.location.reload();
    } else {
        await modalAlert('Erro: ' + (res.erro || 'falha ao processar'), '❌');
    }
}

// ── SELEÇÃO DE SESSÃO ABERTA ─────────────────────────────
function selectOpenSession(el, id) {
    document.querySelectorAll('.open-session-item').forEach(item => {
        item.style.borderColor = '#e0e0e0';
        item.style.background = '#fff';
    });
    el.style.borderColor = 'var(--verde-md)';
    el.style.background = '#e8f5e9';
    const radio = el.querySelector('input[type=radio]');
    if (radio) radio.checked = true;
}

async function confirmarRetomada() {
    const picked = document.querySelector('input[name=pick_session]:checked');
    if (!picked) { await modalAlert('Selecione uma sessão para continuar.', '⚠️'); return; }
    const pickId = parseInt(picked.value);

    // Finalizar sessões marcadas para encerramento
    const toRemove = [...document.querySelectorAll('.remove-session:checked')].map(cb => parseInt(cb.value)).filter(id => id !== pickId);
    if (toRemove.length > 0) {
        await post({ acao: 'finalizar_sessoes', 'ids': toRemove });
    }

    // Escolher a sessão selecionada
    const resp = await post({ acao: 'escolher_sessao', sessao_id: pickId });
    if (resp.erro) { await modalAlert(resp.erro, '❌'); return; }

    sessaoId      = pickId;
    numQuestao    = resp.respondidas || 0;
    totalQuestoes = resp.total_questoes || 0;
    tipoSessao    = resp.tipo || 'quiz';
    numTentativa  = resp.tentativa || 1;
    const ret = document.getElementById('tela-retomada');
    if (ret) ret.remove();
    document.getElementById('tela-inicio').style.display = 'none';
    document.getElementById('tela-quiz').style.display = 'block';
    const ph = document.getElementById('placar-header');
    if (ph) ph.style.display = 'flex';
    const tqEl = document.getElementById('hdr-total-questoes');
    if (tqEl) tqEl.textContent = totalQuestoes;
    atualizarPlacar({ total_acertos: resp.total_acertos, total_erros: resp.total_erros, total_respondidas: resp.respondidas });
    proximaQuestao();
}

function continuarQuiz() {
    confirmarRetomada();
}

async function novoQuiz() {
    const toRemove = [...document.querySelectorAll('.open-session-item')].map(el => parseInt(el.dataset.id));
    if (toRemove.length > 0 && !await modalConfirm('Encerrar todas as sessões em aberto e começar uma nova?', '🔄')) return;
    await post({ acao: 'finalizar_sessoes', 'ids': toRemove }).then(() => {
        sessaoId = null;
        window.location.href = '?p=inicio';
    });
}

// ── CATEGORIAS (a página já vem fixa em modo quiz ou prova — ver MODO_ATUAL) ──
function toggleCat(id) {
    const cb  = document.getElementById('cat-'+id);
    const lbl = document.getElementById('cat-lbl-'+id);
    if (!cb || !lbl) return;
    if (typeof MODO_ATUAL !== 'undefined' && MODO_ATUAL === 'prova') {
        document.querySelectorAll('#cats-grid .cat-label').forEach(l => {
            const c = l.querySelector('input[type=checkbox]');
            const k = l.querySelector('.cat-check');
            if (c) c.checked = false;
            l.classList.remove('sel');
            if (k) k.textContent = '';
        });
        cb.checked = true;
        lbl.classList.add('sel');
        const chk = lbl.querySelector('.cat-check');
        if (chk) chk.textContent = '✓';
    } else {
        cb.checked = !cb.checked;
        lbl.classList.toggle('sel', cb.checked);
        const chk = lbl.querySelector('.cat-check');
        if (chk) chk.textContent = cb.checked ? '✓' : '';
    }
    atualizarTotalSelecionado();
}

function toggleTodas(marcar) {
    document.querySelectorAll('#cats-grid .cat-label').forEach(lbl => {
        const cb  = lbl.querySelector('input[type=checkbox]');
        const chk = lbl.querySelector('.cat-check');
        if (cb)  cb.checked = marcar;
        lbl.classList.toggle('sel', marcar);
        if (chk) chk.textContent = marcar ? '✓' : '';
    });
    atualizarTotalSelecionado();
}

function getCatsSelecionadas() {
    return [...document.querySelectorAll('#cats-grid .cat-label input[type=checkbox]')]
        .filter(cb => cb.checked)
        .map(cb => cb.value);
}

function atualizarTotalSelecionado() {
    const checkedVisible = [...document.querySelectorAll('#cats-grid .cat-label')].filter(lbl => {
        const cb = lbl.querySelector('input[type=checkbox]');
        return cb && cb.checked;
    });
    let total = 0;
    checkedVisible.forEach(lbl => {
        const span = lbl.querySelector('.cat-total');
        total += parseInt(span?.textContent ?? '0') || 0;
    });
    const el = document.getElementById('total-selecionado');
    if (!el) return;
    const rotulo = (typeof MODO_ATUAL !== 'undefined' && MODO_ATUAL === 'prova') ? 'prova' : 'legislação';
    if (checkedVisible.length === 0) {
        el.innerHTML = `<span style="color:var(--vermelho)">⚠️ Selecione ao menos uma ${rotulo}.</span>`;
    } else {
        el.innerHTML = `<strong>${total}</strong> questão(ões) disponível(is) em <strong>${checkedVisible.length}</strong> ${rotulo}(s)`;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const savedEmail = localStorage.getItem('quiz_email');
    const loginEmail = document.getElementById('login-email');
    const loginLembrar = document.getElementById('login-lembrar');
    if (savedEmail && loginEmail) { loginEmail.value = savedEmail; if (loginLembrar) loginLembrar.checked = true; }
    if (document.getElementById('total-selecionado')) {
        atualizarTotalSelecionado();
    }
    if (window.openSessionsExist) {
        const ret = document.getElementById('tela-retomada');
        const ini = document.getElementById('tela-inicio');
        if (ret) { ret.style.display = ''; }
        if (ini) { ini.style.display = 'none'; }
        // Pre-selecionar a primeira sessão
        const first = document.querySelector('.open-session-item');
        if (first) selectOpenSession(first, parseInt(first.dataset.id));
    }
});

// ── INICIAR ───────────────────────────────────────────────────
async function iniciarQuiz() {
    const cats = getCatsSelecionadas();
    if (cats.length === 0) { await modalAlert('Selecione ao menos uma legislação.', '⚠️'); return; }
    const modo   = typeof MODO_ATUAL !== 'undefined' ? MODO_ATUAL : 'quiz';
    tipoSessao   = modo;

    const resp = await post({ acao:'iniciar', tipo:modo, 'categorias': cats });
    if (resp.erro) { await modalAlert(resp.erro, '❌'); return; }

    sessaoId      = resp.sessao_id;
    nomeUsuario   = resp.nome;
    numTentativa  = resp.tentativa;
    totalQuestoes = resp.total_questoes || 0;

    if (window.logEvento) logEvento('iniciou_' + modo, 'Tentativa #' + numTentativa + ' · ' + cats.length + ' legislação(ões)');

    document.getElementById('tela-inicio').style.display   = 'none';
    document.getElementById('tela-quiz').style.display     = 'block';
    const ph = document.getElementById('placar-header');
    if (ph) ph.style.display = 'flex';
    const tqEl = document.getElementById('hdr-total-questoes');
    if (tqEl) tqEl.textContent = totalQuestoes;

    proximaQuestao();
}

// ── PRÓXIMA QUESTÃO ───────────────────────────────────────────
async function proximaQuestao() {
    if (!sessaoId) return;
    ocultarFeedback();
    mostrarCarregando(true);
    const resp = await post({ acao:'proxima_questao' });
    mostrarCarregando(false);
    if (resp.fim) { await finalizarQuiz(); return; }
    if (resp.erro) { await modalAlert(resp.erro, '❌'); return; }
    // Posicao vem da contagem real do servidor (questoes distintas ja respondidas
    // + a que esta sendo servida agora), para nunca ultrapassar o total mesmo que
    // uma questao seja servida novamente.
    numQuestao = (resp.respondidas != null) ? resp.respondidas + 1 : numQuestao + 1;
    if (resp.total_questoes) totalQuestoes = resp.total_questoes;
    renderizarQuestao(resp.questao);
}

// ── RENDERIZAR ────────────────────────────────────────────────
function renderizarQuestao(q) {
    respondendo = false;
    questaoAtualId = q.id;
    document.getElementById('q-categoria-badge').textContent = q.categoria_nome || '';
    const nivelEl  = document.getElementById('q-nivel-badge');
    const nivelMap = { facil:'Fácil', medio:'Médio', dificil:'Difícil' };
    const nivelCls = { facil:'nivel-facil', medio:'nivel-medio', dificil:'nivel-dificil' };
    nivelEl.textContent = nivelMap[q.nivel] || (q.nivel || '');
    nivelEl.className   = 'q-nivel ' + (nivelCls[q.nivel] || '');
    document.getElementById('q-num').textContent  = totalQuestoes > 0
        ? 'Questão ' + numQuestao + ' de ' + totalQuestoes
        : 'Questão #' + numQuestao;
    document.getElementById('enunciado').textContent = q.enunciado || '';
    const idBadge = document.getElementById('q-id-badge');
    if (idBadge) idBadge.textContent = 'ID #' + q.id;

    const container = document.getElementById('opcoes-container');
    container.innerHTML = '';
    ['a','b','c','d','e'].filter(l => q['opcao_'+l]).forEach(l => {
        const div = document.createElement('div');
        div.className     = 'opcao';
        div.dataset.letra = l.toUpperCase();
        div.onclick       = () => responder(l.toUpperCase(), div);
        div.innerHTML     = `<div class="opcao-letra">${l.toUpperCase()}</div><div class="opcao-texto">${escHtml(q['opcao_'+l])}</div>`;
        container.appendChild(div);
    });

    const cq = document.getElementById('card-questao');
    if (cq) { cq.style.display = 'block'; cq.scrollIntoView({ behavior:'smooth', block:'start' }); }
}

// ── RESPONDER ────────────────────────────────────────────────
async function responder(letra, opcaoEl) {
    if (respondendo) return;
    respondendo = true;
    opcaoEl.style.background  = '#e3f2fd';
    opcaoEl.style.borderColor = '#1565c0';

    const resp = await post({ acao:'responder', resposta:letra });
    if (resp.erro) { await modalAlert(resp.erro, '❌'); respondendo = false; return; }

    atualizarPlacar(resp.contadores);
    bloquearOpcoes();
    marcarResposta(resp.resposta_usuario, resp.resposta_correta, resp.acertou);
    mostrarFeedback(resp);
}

function bloquearOpcoes() {
    document.querySelectorAll('.opcao').forEach(el => el.classList.add('bloqueada'));
}

function marcarResposta(usuario, correta, acertou) {
    document.querySelectorAll('.opcao').forEach(el => {
        el.style.background = ''; el.style.borderColor = '';
        if (el.dataset.letra === correta) el.classList.add('correta');
        if (!acertou && el.dataset.letra === usuario) el.classList.add('errada');
    });
}

// ── FEEDBACK ─────────────────────────────────────────────────
function mostrarFeedback(resp) {
    const fbDiv    = document.getElementById('feedback');
    const fbHeader = document.getElementById('fb-header');
    const fbBody   = document.getElementById('fb-body');

    if (resp.acertou) {
        fbHeader.className = 'fb-header acertou';
        fbBody.className   = 'fb-body acertou';
        document.getElementById('fb-icone').textContent     = '✅';
        document.getElementById('fb-titulo').textContent    = 'Parabéns! Você acertou!';
        document.getElementById('fb-titulo').className      = 'fb-titulo acertou';
        document.getElementById('fb-subtitulo').textContent = 'Ótimo conhecimento desta legislação.';
        document.getElementById('fb-resp-errada-div').style.display = 'none';
    } else {
        fbHeader.className = 'fb-header errou';
        fbBody.className   = 'fb-body errou';
        document.getElementById('fb-icone').textContent     = '❌';
        document.getElementById('fb-titulo').textContent    = 'Resposta incorreta!';
        document.getElementById('fb-titulo').className      = 'fb-titulo errou';
        document.getElementById('fb-subtitulo').textContent = 'Leia a explicação para fixar o conteúdo.';
        const ed = document.getElementById('fb-resp-errada-div');
        ed.style.display = 'block';
        document.getElementById('fb-resp-errada-texto').textContent = resp.resposta_usuario + ') ' + (resp.opcao_usuario_texto || '');
    }

    document.getElementById('fb-resp-certa-texto').textContent = resp.resposta_correta + ') ' + (resp.opcao_correta_texto || '');
    document.getElementById('fb-explicacao').textContent       = resp.explicacao || '';
    document.getElementById('fb-referencia').innerHTML         = '<strong>📌 Referência Legal:</strong> ' + escHtml(resp.referencia_legal || '');

    if (fbDiv) { fbDiv.style.display = 'block'; setTimeout(() => fbDiv.scrollIntoView({ behavior:'smooth', block:'nearest' }), 80); }
}

function ocultarFeedback() {
    const fb = document.getElementById('feedback');
    const cq = document.getElementById('card-questao');
    if (fb) fb.style.display = 'none';
    if (cq) cq.style.display = 'none';
    fecharReporte();
    const btn = document.querySelector('.fb-acoes [onclick="abrirReporte()"]');
    if (btn) { btn.textContent = '⚠️ Reportar erro'; btn.disabled = false; btn.style.opacity = '1'; }
}

// ── FINALIZAR ────────────────────────────────────────────────
async function finalizarQuiz() {
    const resp   = await post({ acao:'finalizar' });
    const sessao = resp.sessao || {};
    const total  = parseInt(sessao.total_respondidas) || 0;
    const acertos = parseInt(sessao.total_acertos) || 0;
    const erros  = parseInt(sessao.total_erros) || 0;
    const pct    = total > 0 ? Math.round(acertos/total*100) : 0;

    document.getElementById('res-trofeu').textContent           = classificarTrofeu(pct);
    document.getElementById('res-tentativa-label').textContent  = tipoSessao.toUpperCase() + ' · Tentativa #' + numTentativa + ' · ' + nomeUsuario;
    document.getElementById('res-acertos').textContent = acertos;
    document.getElementById('res-erros').textContent   = erros;
    document.getElementById('res-total').textContent   = total;
    setTimeout(() => { const bf = document.getElementById('barra-fill'); if(bf) bf.style.width = pct + '%'; }, 300);
    document.getElementById('pct-texto').textContent         = pct + '% de aproveitamento';
    document.getElementById('classificacao-texto').innerHTML = classificacao(pct, nomeUsuario);

    document.getElementById('tela-quiz').style.display      = 'none';
    document.getElementById('tela-resultado').style.display = 'block';
    const ph = document.getElementById('placar-header');
    if (ph) ph.style.display = 'none';
    renderRevisaoErros(resp.erros_detalhe || []);
    window.scrollTo({ top:0, behavior:'smooth' });
    if (window.logEvento) logEvento('finalizou_' + tipoSessao, 'Tentativa #' + numTentativa + ' · ' + acertos + '/' + total + ' (' + pct + '%)');
    sessaoId = null;
}

function renderRevisaoErros(erros) {
    const box = document.getElementById('res-revisao');
    if (!box) return;
    if (!erros.length) { box.style.display = 'none'; box.innerHTML = ''; return; }

    const letras = ['a','b','c','d','e'];
    let html = `<h3 style="color:var(--verde-md,#2e7d32);font-size:1.15rem;margin-bottom:12px">📝 Revise suas questões erradas (${erros.length})</h3>`;

    erros.forEach((q, i) => {
        const correta = (q.resposta_correta || '').toUpperCase();
        const dada    = (q.resposta_dada || '').toUpperCase();
        let alternativas = '';
        letras.forEach(l => {
            const texto = q['opcao_' + l];
            if (texto === null || texto === undefined || texto === '') return;
            const letra = l.toUpperCase();
            let estilo = 'padding:6px 10px;border-radius:6px;margin-bottom:4px;font-size:.85rem';
            let marcador = '';
            if (letra === correta) {
                estilo += ';background:#e8f5e9;color:#2e7d32;font-weight:700';
                marcador = ' ✅';
            } else if (letra === dada) {
                estilo += ';background:#ffebee;color:#c62828;font-weight:700';
                marcador = ' ❌';
            }
            alternativas += `<div style="${estilo}">${letra}) ${escHtml(texto)}${marcador}</div>`;
        });

        html += `
        <div style="background:#fafafa;border:1px solid #e0e0e0;border-radius:10px;padding:16px;margin-bottom:14px">
            <p style="font-size:.75rem;color:#888;margin-bottom:6px">${escHtml(q.categoria || '')}</p>
            <p style="font-weight:700;margin-bottom:10px">${i + 1}. ${escHtml(q.enunciado || '')}</p>
            ${alternativas}
            <p style="margin-top:10px;font-size:.85rem"><strong>❌ Sua resposta:</strong> ${dada}) ${escHtml(q['opcao_' + dada.toLowerCase()] || '')}</p>
            <p style="font-size:.85rem"><strong>✅ Resposta correta:</strong> ${correta}) ${escHtml(q['opcao_' + correta.toLowerCase()] || '')}</p>
            ${q.explicacao ? `<p style="margin-top:10px;font-size:.82rem;color:#555;white-space:pre-line"><strong>📖 Explicação:</strong> ${escHtml(q.explicacao)}</p>` : ''}
            ${q.referencia_legal ? `<p style="margin-top:6px;font-size:.78rem;color:#888"><strong>📌 Referência:</strong> ${escHtml(q.referencia_legal)}</p>` : ''}
        </div>`;
    });

    box.innerHTML = html;
    box.style.display = 'block';
}

function classificarTrofeu(pct) {
    if (pct >= 90) return '🏆'; if (pct >= 70) return '🥇';
    if (pct >= 50) return '🥈'; if (pct >= 30) return '🥉'; return '📚';
}
function classificacao(pct, nome) {
    if (pct >= 90) return `<strong>Excelente, ${escHtml(nome)}!</strong> Domínio extraordinário das legislações da PMRR.`;
    if (pct >= 70) return `<strong>Muito bom, ${escHtml(nome)}!</strong> Bom domínio. Continue para atingir a excelência.`;
    if (pct >= 50) return `<strong>Regular, ${escHtml(nome)}.</strong> Conhecimento razoável. Revise os pontos onde errou.`;
    if (pct >= 30) return `<strong>Precisa melhorar, ${escHtml(nome)}.</strong> Estude com atenção e tente novamente.`;
    return `<strong>Atenção, ${escHtml(nome)}!</strong> Dedique-se ao estudo das legislações da PMRR.`;
}

function reiniciar() {
    sessaoId = null; nomeUsuario = ''; numQuestao = 0; respondendo = false;
    document.getElementById('tela-resultado').style.display = 'none';
    document.getElementById('tela-inicio').style.display    = 'block';
    ['hdr-acertos','hdr-erros','hdr-total'].forEach(id => { const el = document.getElementById(id); if(el) el.textContent = '0'; });
    atualizarTotalSelecionado();
    window.scrollTo({ top:0, behavior:'smooth' });
}

// ── PLACAR ────────────────────────────────────────────────────
function atualizarPlacar(cont) {
    if (!cont) return;
    const a = document.getElementById('hdr-acertos');
    const e = document.getElementById('hdr-erros');
    const t = document.getElementById('hdr-total');
    if(a) a.textContent = cont.total_acertos     || 0;
    if(e) e.textContent = cont.total_erros       || 0;
    if(t) t.textContent = cont.total_respondidas || 0;
}

// ── UTILS ─────────────────────────────────────────────────────
function mostrarCarregando(show) {
    const c = document.getElementById('carregando');
    const q = document.getElementById('card-questao');
    if (c) c.style.display = show ? 'block' : 'none';
    if (q) q.style.display = show ? 'none' : 'block';
}

function escHtml(str) {
    if (!str) return '';
    return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}

// ── REPORTAR QUESTÃO ─────────────────────────────────────────
let questaoAtualId = null;

function abrirReporte() {
    const m = document.getElementById('modal-reportar');
    if (m) { m.style.display = 'block'; m.scrollIntoView({ behavior:'smooth', block:'nearest' }); }
}
function fecharReporte() {
    const m = document.getElementById('modal-reportar');
    if (m) m.style.display = 'none';
    const t = document.getElementById('report-justificativa');
    if (t) t.value = '';
}
async function enviarReporte() {
    if (!questaoAtualId) { await modalAlert('Nenhuma questão para reportar.', '⚠️'); return; }
    const justificativa = (document.getElementById('report-justificativa')?.value || '').trim();
    const resp = await post({ acao:'reportar_questao', questao_id: questaoAtualId, justificativa });
    if (resp.erro) { await modalAlert(resp.erro, '❌'); return; }
    fecharReporte();
    const btn = document.querySelector('.fb-acoes [onclick="abrirReporte()"]');
    if (btn) { btn.textContent = '✅ Reportada'; btn.disabled = true; btn.style.opacity = '0.5'; }
    await modalAlert(resp.msg || 'Questão reportada com sucesso.', '✅');
}

async function post(data) {
    const fd = new FormData();
    Object.entries(data).forEach(([k, v]) => {
        if (Array.isArray(v)) { v.forEach(item => fd.append(k + '[]', item)); }
        else { fd.append(k, v); }
    });
    try {
        const r    = await fetch(window.location.pathname, { method:'POST', body:fd });
        const json = await r.json();
        if (json.session_expired) {
            window.location.href = window.location.pathname + '?kicked=1';
            return json;
        }
        return json;
    } catch(e) {
        console.error('post() error:', e);
        return { erro: 'Erro de comunicação: ' + (e.message || e) };
    }
}
</script>

<!-- Modal customizado -->
<div class="modal-overlay" id="modal-overlay">
    <div class="modal-box">
        <div class="modal-icon" id="modal-icon">ℹ️</div>
        <div class="modal-msg" id="modal-msg"></div>
        <div class="modal-btns" id="modal-btns"></div>
    </div>
</div>

<!-- Heartbeat + Auto-logout por inatividade -->
<script>
(function(){
    if (!<?= isLogado() && isAprovado() ? 'true' : 'false' ?>) return;
    let lastUserAction = Date.now();
    const TIMEOUT_MS = 10 * 60 * 1000; // 10 minutos

    function getCurrentPage() {
        const params = new URLSearchParams(window.location.search);
        const p = params.get('p') || 'inicio';
        const tela = document.getElementById('tela-quiz');
        if (tela && tela.style.display !== 'none') return 'respondendo quiz';
        const resultado = document.getElementById('tela-resultado');
        if (resultado && resultado.style.display !== 'none') return 'resultado';
        const pages = {inicio:'tela inicial',historico:'histórico',admin:'admin',leis:'legislações',audios:'áudios',slides:'slides'};
        return pages[p] || p;
    }

    async function sendHeartbeat() {
        if (Date.now() - lastUserAction > TIMEOUT_MS) {
            await modalAlert('Sessão expirada por inatividade (10 minutos).', '⏱️');
            const fd = new FormData(); fd.append('acao','logout');
            await fetch(window.location.pathname, {method:'POST',body:fd});
            window.location.href = '?p=inicio&timeout=1';
            return;
        }
        const fd = new FormData();
        fd.append('acao','heartbeat');
        fd.append('pagina', getCurrentPage());
        try { await fetch(window.location.pathname, {method:'POST',body:fd}); } catch(e) {}
    }

    ['click','keydown','mousemove','touchstart','scroll'].forEach(evt => {
        document.addEventListener(evt, () => { lastUserAction = Date.now(); }, {passive:true});
    });

    sendHeartbeat();
    setInterval(sendHeartbeat, 30000);
})();
</script>

<!-- Registro de atividades do usuário (cliques, downloads, play de áudio, PDFs) -->
<script>
(function(){
    function paginaAtual() {
        const u = new URLSearchParams(window.location.search);
        return u.get('p') || 'inicio';
    }
    // Envia um evento de atividade para o servidor (best-effort, não bloqueia a UI).
    window.logEvento = function(evento, detalhe) {
        if (!evento) return;
        const fd = new FormData();
        fd.append('acao', 'log_evento');
        fd.append('evento', evento);
        if (detalhe) fd.append('detalhe', detalhe);
        fd.append('pagina', paginaAtual());
        try {
            if (navigator.sendBeacon) navigator.sendBeacon(window.location.pathname, fd);
            else fetch(window.location.pathname, {method:'POST', body:fd, keepalive:true});
        } catch(e){}
    };

    function nomeArquivo(url) {
        try { return decodeURIComponent((url||'').split('/').pop().split('?')[0]) || url; }
        catch(e){ return url; }
    }

    // Captura de cliques: data-log explícito, downloads e abertura de PDFs.
    document.addEventListener('click', function(e){
        const el = e.target.closest('[data-log-evento], a[download], a[target="_blank"]');
        if (!el) return;
        if (el.hasAttribute('data-log-evento')) {
            logEvento(el.getAttribute('data-log-evento'), el.getAttribute('data-log-detalhe') || el.textContent.trim().slice(0,120));
            return;
        }
        const href = el.getAttribute('href') || '';
        if (el.hasAttribute('download')) {
            logEvento('download', el.getAttribute('download') || nomeArquivo(href));
        } else if (/\.pdf(\?|$)/i.test(href)) {
            logEvento('abriu_documento', nomeArquivo(href));
        }
    }, true);

    // Play de áudio (evento de mídia dispara na fase de captura).
    const audiosTocados = new Set();
    document.addEventListener('play', function(e){
        const a = e.target;
        if (!a || a.tagName !== 'AUDIO') return;
        const src = a.getAttribute('data-src') || a.getAttribute('src') || '';
        const nome = nomeArquivo(src);
        if (audiosTocados.has(nome)) return;   // evita spam ao pausar/retomar
        audiosTocados.add(nome);
        logEvento('ouviu_audio', nome);
    }, true);
})();
</script>

<!-- Sidebar toggle -->
<script>
function toggleSidebar() {
    const sb = document.getElementById('sidebar-nav');
    const ov = document.getElementById('menu-overlay');
    if (!sb) return;
    if (window.innerWidth <= 768) {
        sb.classList.toggle('open');
        if (ov) ov.classList.toggle('open', sb.classList.contains('open'));
    } else {
        sb.classList.toggle('collapsed');
        localStorage.setItem('sidebar_collapsed', sb.classList.contains('collapsed') ? '1' : '0');
    }
}
function syncHeaderHeight() {
    const hdr = document.querySelector('header');
    if (!hdr) return;
    document.documentElement.style.setProperty('--hdr-h', hdr.offsetHeight + 'px');
}
window.addEventListener('load', syncHeaderHeight);
window.addEventListener('resize', syncHeaderHeight);
(function(){
    syncHeaderHeight();
    const sb = document.getElementById('sidebar-nav');
    if (!sb) return;
    if (window.innerWidth > 768 && localStorage.getItem('sidebar_collapsed') === '1') {
        sb.classList.add('collapsed');
    }
    document.querySelectorAll('.sidebar .menu a').forEach(a => {
        a.addEventListener('click', () => {
            if (window.innerWidth <= 768) {
                const sb2 = document.getElementById('sidebar-nav');
                const ov2 = document.getElementById('menu-overlay');
                if (sb2) sb2.classList.remove('open');
                if (ov2) ov2.classList.remove('open');
            }
        });
    });
})();
</script>
</body>
</html>
