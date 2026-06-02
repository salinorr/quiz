<?php
// ============================================================
// QUIZ PMRR - Sistema Completo em PHP + MySQL
// Legislações: EFM, Redes Sociais e Estatuto dos Militares RR
// ============================================================

// ============================================================
// CONFIGURAÇÃO DO BANCO DE DADOS
// ============================================================
require_once __DIR__ . '/config.php';

// ============================================================
// CONEXÃO COM O BANCO
// ============================================================
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
        } catch (PDOException $e) {
            die('<div style="color:red;padding:20px;font-family:monospace;">Erro de conexão: ' . htmlspecialchars($e->getMessage()) . '</div>');
        }
    }
    return $pdo;
}

// ============================================================
// SESSÃO PHP
// ============================================================
session_start();

// ============================================================
// AÇÕES (AJAX / POST)
// ============================================================
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $acao = $_POST['acao'] ?? '';

    // --- Iniciar sessão de quiz ---
    if ($acao === 'iniciar') {
        $nome = trim($_POST['nome'] ?? '');
        if (strlen($nome) < 2) {
            echo json_encode(['erro' => 'Nome muito curto.']);
            exit;
        }
        $db = getDB();
        $stmt = $db->prepare("INSERT INTO sessoes (nome_usuario) VALUES (?)");
        $stmt->execute([$nome]);
        $sessaoId = $db->lastInsertId();
        $_SESSION['sessao_id']  = $sessaoId;
        $_SESSION['nome']       = htmlspecialchars($nome);
        $_SESSION['respondidas'] = [];
        echo json_encode(['ok' => true, 'sessao_id' => $sessaoId, 'nome' => $_SESSION['nome']]);
        exit;
    }

    // --- Buscar próxima questão ---
    if ($acao === 'proxima_questao') {
        if (empty($_SESSION['sessao_id'])) {
            echo json_encode(['erro' => 'Sessão inválida.']);
            exit;
        }
        $db          = getDB();
        $respondidas = $_SESSION['respondidas'] ?? [];

        $placeholders = count($respondidas) ? implode(',', array_fill(0, count($respondidas), '?')) : '0';
        $sql = "SELECT q.*, c.nome AS categoria_nome
                FROM questoes q
                JOIN categorias c ON c.id = q.categoria_id
                WHERE q.id NOT IN ($placeholders)
                ORDER BY RAND()
                LIMIT 1";
        $stmt = $db->prepare($sql);
        $stmt->execute($respondidas ?: [0]);
        $questao = $stmt->fetch();

        if (!$questao) {
            echo json_encode(['fim' => true]);
            exit;
        }

        // Não enviar resposta correta ao client
        $respCorreta = $questao['resposta_correta'];
        unset($questao['resposta_correta'], $questao['explicacao'], $questao['referencia_legal']);

        // Guardar no servidor
        $_SESSION['questao_atual'] = [
            'id'        => $questao['id'],
            'correta'   => $respCorreta,
        ];

        echo json_encode(['questao' => $questao]);
        exit;
    }

    // --- Responder questão ---
    if ($acao === 'responder') {
        if (empty($_SESSION['sessao_id']) || empty($_SESSION['questao_atual'])) {
            echo json_encode(['erro' => 'Sessão ou questão inválida.']);
            exit;
        }
        $resposta = strtoupper(trim($_POST['resposta'] ?? ''));
        if (!in_array($resposta, ['A','B','C','D'])) {
            echo json_encode(['erro' => 'Resposta inválida.']);
            exit;
        }

        $db         = getDB();
        $sessaoId   = $_SESSION['sessao_id'];
        $qAtual     = $_SESSION['questao_atual'];
        $acertou    = ($resposta === $qAtual['correta']) ? 1 : 0;

        // Buscar explicação completa
        $stmt = $db->prepare("SELECT enunciado, opcao_a, opcao_b, opcao_c, opcao_d,
                                      resposta_correta, explicacao, referencia_legal, nivel,
                                      (SELECT nome FROM categorias WHERE id = q.categoria_id) AS categoria
                              FROM questoes q WHERE id = ?");
        $stmt->execute([$qAtual['id']]);
        $questaoCompleta = $stmt->fetch();

        // Registrar resposta
        $stmt = $db->prepare("INSERT INTO respostas_usuario (sessao_id, questao_id, resposta_dada, acertou) VALUES (?,?,?,?)");
        $stmt->execute([$sessaoId, $qAtual['id'], $resposta, $acertou]);

        // Atualizar contadores
        if ($acertou) {
            $db->prepare("UPDATE sessoes SET total_acertos = total_acertos+1, total_respondidas = total_respondidas+1 WHERE id=?")->execute([$sessaoId]);
        } else {
            $db->prepare("UPDATE sessoes SET total_erros = total_erros+1, total_respondidas = total_respondidas+1 WHERE id=?")->execute([$sessaoId]);
        }

        // Marcar como respondida
        $_SESSION['respondidas'][] = $qAtual['id'];
        unset($_SESSION['questao_atual']);

        // Opção correta por extenso
        $opcaoCorretaTexto = $questaoCompleta['opcao_' . strtolower($questaoCompleta['resposta_correta'])];
        $opcaoUsuarioTexto = $questaoCompleta['opcao_' . strtolower($resposta)];

        // Buscar contadores atualizados
        $stmt = $db->prepare("SELECT total_acertos, total_erros, total_respondidas FROM sessoes WHERE id=?");
        $stmt->execute([$sessaoId]);
        $contadores = $stmt->fetch();

        echo json_encode([
            'acertou'             => (bool)$acertou,
            'resposta_correta'    => $questaoCompleta['resposta_correta'],
            'resposta_usuario'    => $resposta,
            'opcao_correta_texto' => $opcaoCorretaTexto,
            'opcao_usuario_texto' => $opcaoUsuarioTexto,
            'explicacao'          => $questaoCompleta['explicacao'],
            'referencia_legal'    => $questaoCompleta['referencia_legal'],
            'enunciado'           => $questaoCompleta['enunciado'],
            'nivel'               => $questaoCompleta['nivel'],
            'categoria'           => $questaoCompleta['categoria'],
            'contadores'          => $contadores,
        ]);
        exit;
    }

    // --- Finalizar quiz ---
    if ($acao === 'finalizar') {
        if (!empty($_SESSION['sessao_id'])) {
            $db = getDB();
            $db->prepare("UPDATE sessoes SET finalizado_em = NOW() WHERE id=?")->execute([$_SESSION['sessao_id']]);
            $stmt = $db->prepare("SELECT * FROM sessoes WHERE id=?");
            $stmt->execute([$_SESSION['sessao_id']]);
            $sessao = $stmt->fetch();
            echo json_encode(['sessao' => $sessao]);
        }
        exit;
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz PMRR – Legislações Militares</title>
    <style>
        /* ================================================
           RESET & BASE
        ================================================ */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --verde:     #1a5c2e;
            --verde-md:  #2e7d47;
            --verde-lt:  #4caf70;
            --amarelo:   #f9a825;
            --vermelho:  #c62828;
            --vermelho-lt:#ef9a9a;
            --cinza-bg:  #f4f6f8;
            --branco:    #ffffff;
            --texto:     #1e2b1f;
            --sombra:    0 4px 24px rgba(0,0,0,.12);
            --radius:    14px;
            --transition: .25s ease;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: var(--cinza-bg);
            color: var(--texto);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* ================================================
           HEADER
        ================================================ */
        header {
            width: 100%;
            background: linear-gradient(135deg, var(--verde) 0%, var(--verde-md) 100%);
            color: white;
            padding: 18px 24px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 3px 16px rgba(0,0,0,.25);
        }
        .logo-shield {
            width: 52px; height: 62px;
            background: rgba(255,255,255,.15);
            border: 2.5px solid rgba(255,255,255,.4);
            border-radius: 50% 50% 50% 50% / 60% 60% 40% 40%;
            display: flex; align-items: center; justify-content: center;
            font-size: 26px; flex-shrink: 0;
        }
        header h1 { font-size: 1.25rem; line-height: 1.3; }
        header p  { font-size: .8rem; opacity: .85; margin-top: 3px; }

        /* Placar no header */
        #placar-header {
            margin-left: auto;
            display: none;
            gap: 12px;
        }
        .pl-item {
            background: rgba(255,255,255,.15);
            border-radius: 10px;
            padding: 6px 14px;
            text-align: center;
            min-width: 64px;
        }
        .pl-item .pl-num { font-size: 1.4rem; font-weight: 700; }
        .pl-item .pl-lbl { font-size: .65rem; opacity: .85; text-transform: uppercase; letter-spacing: .04em; }
        .pl-item.acertos .pl-num { color: #a5f3c2; }
        .pl-item.erros   .pl-num { color: #ffb4b4; }
        .pl-item.total   .pl-num { color: #fff; }

        /* ================================================
           MAIN CONTENT
        ================================================ */
        main {
            width: 100%;
            max-width: 800px;
            padding: 28px 16px 60px;
        }

        .card {
            background: var(--branco);
            border-radius: var(--radius);
            box-shadow: var(--sombra);
            padding: 32px 36px;
            animation: fadeIn .35s ease;
        }
        @keyframes fadeIn { from { opacity:0; transform:translateY(12px); } to { opacity:1; transform:none; } }

        /* ================================================
           TELA INICIAL
        ================================================ */
        #tela-inicio { text-align: center; }
        .escudo-grande {
            font-size: 72px;
            margin-bottom: 12px;
            display: block;
        }
        #tela-inicio h2 {
            font-size: 1.6rem;
            color: var(--verde);
            margin-bottom: 8px;
        }
        #tela-inicio p {
            color: #555;
            margin-bottom: 24px;
            line-height: 1.6;
        }
        .badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: center;
            margin-bottom: 28px;
        }
        .badge {
            background: #e8f5e9;
            color: var(--verde);
            border: 1px solid #c8e6c9;
            border-radius: 20px;
            padding: 5px 14px;
            font-size: .82rem;
            font-weight: 600;
        }

        .input-group { margin-bottom: 20px; text-align: left; }
        .input-group label { display: block; font-weight: 600; margin-bottom: 7px; color: var(--verde); }
        .input-group input {
            width: 100%;
            padding: 13px 16px;
            border: 2px solid #c8e6c9;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
        }
        .input-group input:focus {
            outline: none;
            border-color: var(--verde-md);
            box-shadow: 0 0 0 3px rgba(46,125,71,.15);
        }

        .btn {
            display: inline-flex; align-items: center; justify-content: center;
            gap: 8px;
            padding: 14px 32px;
            border: none; border-radius: 10px;
            font-size: 1rem; font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--verde-md), var(--verde));
            color: white;
            box-shadow: 0 4px 16px rgba(46,125,71,.35);
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(46,125,71,.45); }
        .btn-secondary {
            background: var(--cinza-bg);
            color: var(--verde);
            border: 2px solid #c8e6c9;
        }
        .btn-secondary:hover { background: #e8f5e9; }
        .btn-danger {
            background: linear-gradient(135deg,#e53935,#b71c1c);
            color: white;
        }
        .btn-danger:hover { transform: translateY(-2px); }

        /* ================================================
           TELA QUIZ
        ================================================ */
        #tela-quiz { display: none; }

        .q-meta {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 16px; flex-wrap: wrap; gap: 8px;
        }
        .q-categoria {
            background: #e8f5e9;
            color: var(--verde);
            border-radius: 20px;
            padding: 4px 14px;
            font-size: .8rem;
            font-weight: 700;
        }
        .q-nivel {
            border-radius: 20px;
            padding: 4px 14px;
            font-size: .75rem;
            font-weight: 700;
        }
        .nivel-facil   { background: #e3f2fd; color: #1565c0; }
        .nivel-medio   { background: #fff3e0; color: #e65100; }
        .nivel-dificil { background: #fce4ec; color: #880e4f; }

        .q-num {
            font-size: .8rem;
            color: #888;
            font-weight: 600;
        }

        #enunciado {
            font-size: 1.12rem;
            line-height: 1.65;
            font-weight: 600;
            color: var(--texto);
            margin-bottom: 28px;
            padding: 16px 20px;
            background: var(--cinza-bg);
            border-left: 5px solid var(--verde-md);
            border-radius: 0 10px 10px 0;
        }

        .opcoes { display: flex; flex-direction: column; gap: 12px; }

        .opcao {
            display: flex; align-items: flex-start; gap: 14px;
            padding: 14px 18px;
            border: 2px solid #d1d8dc;
            border-radius: 10px;
            cursor: pointer;
            transition: var(--transition);
            background: white;
        }
        .opcao:hover:not(.bloqueada) {
            border-color: var(--verde-md);
            background: #f0faf3;
            transform: translateX(4px);
        }
        .opcao-letra {
            min-width: 34px; height: 34px;
            background: #ecf0f1;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; font-size: .95rem;
            flex-shrink: 0;
            transition: var(--transition);
        }
        .opcao-texto { font-size: .97rem; line-height: 1.5; padding-top: 6px; }

        /* Estados das opções */
        .opcao.correta {
            border-color: #2e7d47;
            background: #e8f5e9;
        }
        .opcao.correta .opcao-letra { background: #2e7d47; color: white; }

        .opcao.errada {
            border-color: var(--vermelho);
            background: #fff5f5;
        }
        .opcao.errada .opcao-letra { background: var(--vermelho); color: white; }

        .opcao.bloqueada { cursor: default; }

        /* ================================================
           FEEDBACK
        ================================================ */
        #feedback { display: none; margin-top: 24px; }

        .fb-header {
            display: flex; align-items: center; gap: 14px;
            padding: 16px 20px;
            border-radius: 10px 10px 0 0;
        }
        .fb-header.acertou { background: #e8f5e9; border: 2px solid #2e7d47; border-bottom: none; }
        .fb-header.errou   { background: #fff5f5; border: 2px solid var(--vermelho); border-bottom: none; }

        .fb-icone { font-size: 2rem; }
        .fb-titulo { font-size: 1.1rem; font-weight: 800; }
        .fb-titulo.acertou { color: #2e7d47; }
        .fb-titulo.errou   { color: var(--vermelho); }
        .fb-subtitulo { font-size: .85rem; color: #666; margin-top: 2px; }

        .fb-body {
            border: 2px solid #ddd;
            border-top: none;
            border-radius: 0 0 10px 10px;
            padding: 20px;
            background: white;
        }
        .fb-body.acertou { border-color: #2e7d47; }
        .fb-body.errou   { border-color: var(--vermelho); }

        .fb-resp-errada {
            background: #fff5f5;
            border: 1px solid #ffcdd2;
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 14px;
            font-size: .9rem;
        }
        .fb-resp-certa {
            background: #e8f5e9;
            border: 1px solid #c8e6c9;
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 16px;
            font-size: .9rem;
        }
        .fb-resp-certa strong, .fb-resp-errada strong { display: block; margin-bottom: 4px; font-size: .8rem; text-transform: uppercase; letter-spacing: .04em; }
        .fb-resp-certa strong { color: #2e7d47; }
        .fb-resp-errada strong { color: var(--vermelho); }

        .fb-explicacao-titulo {
            font-weight: 700; font-size: .9rem; color: var(--verde);
            text-transform: uppercase; letter-spacing: .06em;
            margin-bottom: 10px;
        }
        .fb-explicacao {
            font-size: .95rem;
            line-height: 1.7;
            color: #333;
        }
        .fb-referencia {
            margin-top: 12px;
            background: #f3f4f6;
            border-radius: 8px;
            padding: 8px 14px;
            font-size: .82rem;
            color: #666;
        }
        .fb-referencia strong { color: var(--verde); }

        .fb-acoes {
            margin-top: 20px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        /* ================================================
           CARREGANDO
        ================================================ */
        #carregando {
            display: none;
            text-align: center;
            padding: 40px;
            color: #888;
        }
        .spinner {
            width: 40px; height: 40px;
            border: 4px solid #e0e0e0;
            border-top-color: var(--verde-md);
            border-radius: 50%;
            animation: spin .8s linear infinite;
            margin: 0 auto 14px;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* ================================================
           TELA RESULTADO FINAL
        ================================================ */
        #tela-resultado { display: none; text-align: center; }

        .resultado-trofeu { font-size: 80px; margin-bottom: 12px; }
        #tela-resultado h2 {
            font-size: 1.8rem;
            color: var(--verde);
            margin-bottom: 6px;
        }
        .resultado-subtitulo { color: #666; margin-bottom: 28px; font-size: 1rem; }

        .resultado-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-bottom: 28px;
        }
        .res-card {
            border-radius: 12px;
            padding: 18px 10px;
            font-size: 2rem;
            font-weight: 800;
        }
        .res-card.acertos { background: #e8f5e9; color: #2e7d47; }
        .res-card.erros   { background: #fff5f5; color: var(--vermelho); }
        .res-card.total   { background: #e3f2fd; color: #1565c0; }
        .res-card small   { display: block; font-size: .75rem; font-weight: 500; color: #666; margin-top: 4px; }

        .barra-wrap {
            background: #ecf0f1;
            border-radius: 30px;
            height: 20px;
            overflow: hidden;
            margin: 0 auto 8px;
            max-width: 400px;
        }
        .barra-fill {
            height: 100%;
            border-radius: 30px;
            background: linear-gradient(90deg, var(--verde-lt), var(--verde-md));
            transition: width .8s ease;
        }
        .pct-texto { font-size: .9rem; color: #666; margin-bottom: 28px; }

        .classificacao {
            background: var(--cinza-bg);
            border-radius: 12px;
            padding: 16px 24px;
            margin-bottom: 24px;
            font-size: 1.05rem;
        }
        .classificacao strong { color: var(--verde); }

        /* ================================================
           ERRO DB
        ================================================ */
        .erro-db {
            background: #fff5f5;
            border: 2px solid #ffcdd2;
            border-radius: 12px;
            padding: 24px;
            margin: 24px auto;
            max-width: 600px;
            font-family: monospace;
            font-size: .9rem;
        }

        /* ================================================
           RESPONSIVO
        ================================================ */
        @media (max-width: 600px) {
            .card { padding: 22px 18px; }
            #enunciado { font-size: 1rem; }
            .resultado-grid { grid-template-columns: 1fr; }
            header h1 { font-size: 1rem; }
            #placar-header { gap: 8px; }
            .pl-item { padding: 4px 10px; min-width: 52px; }
        }
    </style>
</head>
<body>

<header>
    <div class="logo-shield">🛡️</div>
    <div>
        <h1>Quiz PMRR – Legislações Militares</h1>
        <p>Portaria 1717/2023 · Portaria 685/2024 · LC 194/2012</p>
    </div>
    <div id="placar-header">
        <div class="pl-item acertos">
            <div class="pl-num" id="hdr-acertos">0</div>
            <div class="pl-lbl">Acertos</div>
        </div>
        <div class="pl-item erros">
            <div class="pl-num" id="hdr-erros">0</div>
            <div class="pl-lbl">Erros</div>
        </div>
        <div class="pl-item total">
            <div class="pl-num" id="hdr-total">0</div>
            <div class="pl-lbl">Total</div>
        </div>
    </div>
</header>

<main>

    <!-- ============ TELA INICIAL ============ -->
    <div id="tela-inicio" class="card">
        <span class="escudo-grande">🎖️</span>
        <h2>Quiz de Legislações da PMRR</h2>
        <p>Teste seus conhecimentos nas três legislações da Polícia Militar de Roraima. Responda quantas questões quiser e receba feedback detalhado em cada resposta!</p>

        <div class="badges">
            <span class="badge">📋 Portaria 1717/2023 – EFM</span>
            <span class="badge">📱 Portaria 685/2024 – Redes Sociais</span>
            <span class="badge">⚖️ LC 194/2012 – Estatuto Militar</span>
        </div>

        <div class="input-group">
            <label for="nome-input">👤 Seu nome completo</label>
            <input type="text" id="nome-input" placeholder="Digite seu nome para começar..." maxlength="100" autocomplete="off">
        </div>

        <button class="btn btn-primary" onclick="iniciarQuiz()" style="width:100%;">
            🚀 Iniciar Quiz
        </button>
    </div>

    <!-- ============ TELA QUIZ ============ -->
    <div id="tela-quiz">
        <div id="carregando" class="card">
            <div class="spinner"></div>
            <p>Carregando questão...</p>
        </div>

        <div id="card-questao" class="card" style="display:none;">
            <div class="q-meta">
                <span id="q-categoria-badge" class="q-categoria">Categoria</span>
                <span id="q-nivel-badge" class="q-nivel">Nível</span>
                <span id="q-num" class="q-num">#1</span>
            </div>

            <div id="enunciado">Carregando...</div>

            <div class="opcoes" id="opcoes-container">
                <!-- Opções injetadas via JS -->
            </div>

            <div id="feedback">
                <div class="fb-header" id="fb-header">
                    <div class="fb-icone" id="fb-icone"></div>
                    <div>
                        <div class="fb-titulo" id="fb-titulo"></div>
                        <div class="fb-subtitulo" id="fb-subtitulo"></div>
                    </div>
                </div>
                <div class="fb-body" id="fb-body">
                    <div id="fb-resp-errada-div" class="fb-resp-errada" style="display:none;">
                        <strong>❌ Sua resposta:</strong>
                        <span id="fb-resp-errada-texto"></span>
                    </div>
                    <div id="fb-resp-certa-div" class="fb-resp-certa">
                        <strong>✅ Resposta correta:</strong>
                        <span id="fb-resp-certa-texto"></span>
                    </div>
                    <div class="fb-explicacao-titulo">📖 Explicação Detalhada</div>
                    <div class="fb-explicacao" id="fb-explicacao"></div>
                    <div class="fb-referencia" id="fb-referencia"></div>
                    <div class="fb-acoes">
                        <button class="btn btn-primary" onclick="proximaQuestao()">
                            ➡️ Próxima Questão
                        </button>
                        <button class="btn btn-danger" onclick="finalizarQuiz()">
                            🏁 Finalizar Quiz
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ============ TELA RESULTADO FINAL ============ -->
    <div id="tela-resultado" class="card">
        <div class="resultado-trofeu" id="res-trofeu">🏆</div>
        <h2>Resultado Final</h2>
        <p class="resultado-subtitulo" id="res-nome-label">Parabéns, Fulano!</p>

        <div class="resultado-grid">
            <div class="res-card acertos">
                <span id="res-acertos">0</span>
                <small>Acertos</small>
            </div>
            <div class="res-card erros">
                <span id="res-erros">0</span>
                <small>Erros</small>
            </div>
            <div class="res-card total">
                <span id="res-total">0</span>
                <small>Respondidas</small>
            </div>
        </div>

        <div class="barra-wrap">
            <div class="barra-fill" id="barra-fill" style="width:0%"></div>
        </div>
        <p class="pct-texto" id="pct-texto">0% de aproveitamento</p>

        <div class="classificacao" id="classificacao-texto"></div>

        <button class="btn btn-primary" onclick="reiniciar()" style="width:100%;margin-bottom:12px;">
            🔄 Jogar Novamente
        </button>
    </div>

</main>

<script>
// ============================================================
// ESTADO GLOBAL
// ============================================================
let sessaoId    = null;
let nomeUsuario = '';
let numQuestao  = 0;
let respondendo = false;

// ============================================================
// INICIAR QUIZ
// ============================================================
async function iniciarQuiz() {
    const nome = document.getElementById('nome-input').value.trim();
    if (nome.length < 2) {
        alert('Por favor, informe seu nome (mínimo 2 caracteres).');
        return;
    }

    const resp = await post({ acao: 'iniciar', nome });
    if (resp.erro) { alert(resp.erro); return; }

    sessaoId    = resp.sessao_id;
    nomeUsuario = resp.nome;

    document.getElementById('tela-inicio').style.display   = 'none';
    document.getElementById('tela-quiz').style.display     = 'block';
    document.getElementById('placar-header').style.display = 'flex';

    proximaQuestao();
}

// ============================================================
// CARREGAR PRÓXIMA QUESTÃO
// ============================================================
async function proximaQuestao() {
    if (!sessaoId) return;

    ocultarFeedback();
    mostrarCarregando(true);

    const resp = await post({ acao: 'proxima_questao' });
    mostrarCarregando(false);

    if (resp.fim) {
        await finalizarQuiz();
        return;
    }
    if (resp.erro) { alert(resp.erro); return; }

    numQuestao++;
    renderizarQuestao(resp.questao);
}

// ============================================================
// RENDERIZAR QUESTÃO
// ============================================================
function renderizarQuestao(q) {
    respondendo = false;

    // Meta
    document.getElementById('q-categoria-badge').textContent = q.categoria_nome;
    const nivelEl = document.getElementById('q-nivel-badge');
    const nivelMap = { facil: 'Fácil', medio: 'Médio', dificil: 'Difícil' };
    const nivelClass = { facil: 'nivel-facil', medio: 'nivel-medio', dificil: 'nivel-dificil' };
    nivelEl.textContent  = nivelMap[q.nivel] || q.nivel;
    nivelEl.className    = 'q-nivel ' + (nivelClass[q.nivel] || '');
    document.getElementById('q-num').textContent = 'Questão #' + numQuestao;

    // Enunciado
    document.getElementById('enunciado').textContent = q.enunciado;

    // Opções
    const container = document.getElementById('opcoes-container');
    container.innerHTML = '';
    const letras = ['a','b','c','d'];
    letras.forEach(l => {
        const div = document.createElement('div');
        div.className = 'opcao';
        div.dataset.letra = l.toUpperCase();
        div.onclick = () => responder(l.toUpperCase(), div);
        div.innerHTML = `
            <div class="opcao-letra">${l.toUpperCase()}</div>
            <div class="opcao-texto">${escHtml(q['opcao_' + l])}</div>
        `;
        container.appendChild(div);
    });

    document.getElementById('card-questao').style.display = 'block';

    // Scroll suave ao topo do card
    document.getElementById('card-questao').scrollIntoView({ behavior: 'smooth', block: 'start' });
}

// ============================================================
// RESPONDER
// ============================================================
async function responder(letra, opcaoEl) {
    if (respondendo) return;
    respondendo = true;

    // Visual de seleção
    opcaoEl.style.background = '#e3f2fd';
    opcaoEl.style.borderColor = '#1565c0';

    const resp = await post({ acao: 'responder', resposta: letra });
    if (resp.erro) { alert(resp.erro); respondendo = false; return; }

    // Atualizar placar
    atualizarPlacar(resp.contadores);

    // Marcar opções
    bloquearOpcoes();
    marcarResposta(resp.resposta_usuario, resp.resposta_correta, resp.acertou);

    // Mostrar feedback
    mostrarFeedback(resp);
}

function bloquearOpcoes() {
    document.querySelectorAll('.opcao').forEach(el => el.classList.add('bloqueada'));
}

function marcarResposta(respostaUsuario, respostaCorreta, acertou) {
    document.querySelectorAll('.opcao').forEach(el => {
        el.style.background = '';
        el.style.borderColor = '';
        if (el.dataset.letra === respostaCorreta) {
            el.classList.add('correta');
        }
        if (!acertou && el.dataset.letra === respostaUsuario) {
            el.classList.add('errada');
        }
    });
}

// ============================================================
// FEEDBACK
// ============================================================
function mostrarFeedback(resp) {
    const fbDiv      = document.getElementById('feedback');
    const fbHeader   = document.getElementById('fb-header');
    const fbBody     = document.getElementById('fb-body');
    const fbIcone    = document.getElementById('fb-icone');
    const fbTitulo   = document.getElementById('fb-titulo');
    const fbSubtit   = document.getElementById('fb-subtitulo');

    if (resp.acertou) {
        fbHeader.className = 'fb-header acertou';
        fbBody.className   = 'fb-body acertou';
        fbIcone.textContent  = '✅';
        fbTitulo.textContent = 'Parabéns! Você acertou!';
        fbTitulo.className   = 'fb-titulo acertou';
        fbSubtit.textContent = 'Ótimo conhecimento sobre esta legislação.';
        document.getElementById('fb-resp-errada-div').style.display = 'none';
    } else {
        fbHeader.className = 'fb-header errou';
        fbBody.className   = 'fb-body errou';
        fbIcone.textContent  = '❌';
        fbTitulo.textContent = 'Resposta incorreta!';
        fbTitulo.className   = 'fb-titulo errou';
        fbSubtit.textContent = 'Leia a explicação abaixo para fixar o conteúdo.';

        const erradaDiv = document.getElementById('fb-resp-errada-div');
        erradaDiv.style.display = 'block';
        document.getElementById('fb-resp-errada-texto').textContent =
            resp.resposta_usuario + ') ' + resp.opcao_usuario_texto;
    }

    document.getElementById('fb-resp-certa-div').style.display = 'block';
    document.getElementById('fb-resp-certa-texto').textContent =
        resp.resposta_correta + ') ' + resp.opcao_correta_texto;

    document.getElementById('fb-explicacao').textContent = resp.explicacao;
    document.getElementById('fb-referencia').innerHTML =
        '<strong>📌 Referência Legal:</strong> ' + escHtml(resp.referencia_legal);

    fbDiv.style.display = 'block';

    // Scroll até o feedback
    setTimeout(() => {
        fbDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }, 100);
}

function ocultarFeedback() {
    document.getElementById('feedback').style.display = 'none';
    document.getElementById('card-questao').style.display = 'none';
}

// ============================================================
// FINALIZAR QUIZ
// ============================================================
async function finalizarQuiz() {
    const resp = await post({ acao: 'finalizar' });
    const sessao = resp.sessao || {};

    const total    = parseInt(sessao.total_respondidas) || 0;
    const acertos  = parseInt(sessao.total_acertos) || 0;
    const erros    = parseInt(sessao.total_erros) || 0;
    const pct      = total > 0 ? Math.round((acertos / total) * 100) : 0;

    document.getElementById('res-trofeu').textContent    = classificarTrofeu(pct);
    document.getElementById('res-nome-label').textContent = 'Resultado de ' + nomeUsuario;
    document.getElementById('res-acertos').textContent   = acertos;
    document.getElementById('res-erros').textContent     = erros;
    document.getElementById('res-total').textContent     = total;

    setTimeout(() => {
        document.getElementById('barra-fill').style.width = pct + '%';
    }, 300);
    document.getElementById('pct-texto').textContent = pct + '% de aproveitamento';
    document.getElementById('classificacao-texto').innerHTML = classificacao(pct, nomeUsuario);

    document.getElementById('tela-quiz').style.display     = 'none';
    document.getElementById('tela-resultado').style.display = 'block';
    document.getElementById('placar-header').style.display  = 'none';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function classificarTrofeu(pct) {
    if (pct >= 90) return '🏆';
    if (pct >= 70) return '🥇';
    if (pct >= 50) return '🥈';
    if (pct >= 30) return '🥉';
    return '📚';
}

function classificacao(pct, nome) {
    if (pct >= 90) return `<strong>Excelente, ${nome}!</strong> Desempenho extraordinário! Você domina as legislações da PMRR.`;
    if (pct >= 70) return `<strong>Muito bom, ${nome}!</strong> Bom domínio das legislações. Continue estudando para atingir a excelência.`;
    if (pct >= 50) return `<strong>Regular, ${nome}.</strong> Você tem conhecimento razoável. Revise os pontos em que errou.`;
    if (pct >= 30) return `<strong>Precisa melhorar, ${nome}.</strong> Estude com atenção as legislações e tente novamente.`;
    return `<strong>Atenção, ${nome}!</strong> É necessário dedicação ao estudo das legislações da PMRR. Não desista!`;
}

// ============================================================
// REINICIAR
// ============================================================
function reiniciar() {
    sessaoId    = null;
    nomeUsuario = '';
    numQuestao  = 0;
    respondendo = false;

    document.getElementById('tela-resultado').style.display = 'none';
    document.getElementById('tela-inicio').style.display    = 'block';
    document.getElementById('nome-input').value = '';
    document.getElementById('hdr-acertos').textContent = '0';
    document.getElementById('hdr-erros').textContent   = '0';
    document.getElementById('hdr-total').textContent   = '0';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// ============================================================
// PLACAR NO HEADER
// ============================================================
function atualizarPlacar(cont) {
    if (!cont) return;
    document.getElementById('hdr-acertos').textContent = cont.total_acertos  || 0;
    document.getElementById('hdr-erros').textContent   = cont.total_erros    || 0;
    document.getElementById('hdr-total').textContent   = cont.total_respondidas || 0;
}

// ============================================================
// UTILITÁRIOS
// ============================================================
function mostrarCarregando(show) {
    document.getElementById('carregando').style.display    = show ? 'block' : 'none';
    document.getElementById('card-questao').style.display  = show ? 'none'  : 'block';
}

function escHtml(str) {
    if (!str) return '';
    return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}

async function post(data) {
    const fd = new FormData();
    Object.entries(data).forEach(([k,v]) => fd.append(k, v));
    try {
        const r = await fetch(window.location.href, { method: 'POST', body: fd });
        return await r.json();
    } catch(e) {
        console.error(e);
        return { erro: 'Erro de comunicação com o servidor.' };
    }
}

// Enter para iniciar
document.getElementById('nome-input').addEventListener('keydown', e => {
    if (e.key === 'Enter') iniciarQuiz();
});
</script>
</body>
</html>
