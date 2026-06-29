<?php
// run_migration.php - Executa migration do quiz v2
// REMOVER APÓS USO!
$token = $_GET['token'] ?? '';
if ($token !== 'PMRR2026@migrate') {
    http_response_code(403);
    die('Acesso negado.');
}

require_once __DIR__ . '/config.php';

$dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
try {
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ]);
} catch (PDOException $e) {
    die('Erro de conexão: ' . htmlspecialchars($e->getMessage()));
}

// Verifica se coluna existe em tabela
function columnExists(PDO $pdo, string $table, string $column): bool {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? AND COLUMN_NAME=?");
    $stmt->execute([$table, $column]);
    return (bool)$stmt->fetchColumn();
}

echo '<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8">
<title>Migration v2</title>
<style>body{font-family:monospace;background:#111;color:#0f0;padding:24px;}
pre{white-space:pre-wrap;word-break:break-all;}
.ok{color:#4caf50;} .err{color:#f44336;} .warn{color:#ff9800;}</style>
</head><body>';
echo "<h2 style='color:#fff'>Executando migration_v2</h2><hr><pre>";

$ok = 0; $err = 0; $skip = 0;

// ── Passo 1: opcao_e em questoes ────────────────────────────
if (!columnExists($pdo, 'questoes', 'opcao_e')) {
    try {
        $pdo->exec("ALTER TABLE questoes ADD COLUMN opcao_e TEXT NULL AFTER opcao_d");
        echo "<span class='ok'>OK  ALTER questoes ADD opcao_e</span>\n"; $ok++;
    } catch (PDOException $e) { echo "<span class='err'>ERR ALTER questoes ADD opcao_e: ".htmlspecialchars($e->getMessage())."</span>\n"; $err++; }
} else { echo "<span class='warn'>SKIP opcao_e já existe</span>\n"; $skip++; }

// ── Passo 2: tabela militares ────────────────────────────────
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS militares (
        id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nome_completo VARCHAR(120)  NOT NULL,
        nome_guerra   VARCHAR(60)   NOT NULL,
        email         VARCHAR(120)  NOT NULL,
        matricula     VARCHAR(20)   NOT NULL,
        senha_hash    VARCHAR(255)  NOT NULL,
        status        ENUM('pendente','aprovado','rejeitado') NOT NULL DEFAULT 'pendente',
        is_admin      TINYINT(1)    NOT NULL DEFAULT 0,
        created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
        approved_at   DATETIME      NULL,
        UNIQUE KEY uq_email(email),
        UNIQUE KEY uq_matricula(matricula)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
    echo "<span class='ok'>OK  CREATE TABLE militares</span>\n"; $ok++;
} catch (PDOException $e) { echo "<span class='err'>ERR militares: ".htmlspecialchars($e->getMessage())."</span>\n"; $err++; }

// ── Passo 3: colunas em sessoes ──────────────────────────────
$sessoesCols = [
    'militar_id'      => "ALTER TABLE sessoes ADD COLUMN militar_id INT UNSIGNED NULL AFTER nome_usuario",
    'tipo'            => "ALTER TABLE sessoes ADD COLUMN tipo ENUM('quiz','prova') NOT NULL DEFAULT 'quiz' AFTER militar_id",
    'numero_tentativa'=> "ALTER TABLE sessoes ADD COLUMN numero_tentativa INT NOT NULL DEFAULT 1 AFTER tipo",
    'created_at'      => "ALTER TABLE sessoes ADD COLUMN created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER numero_tentativa",
];
foreach ($sessoesCols as $col => $sql) {
    if (!columnExists($pdo, 'sessoes', $col)) {
        try { $pdo->exec($sql); echo "<span class='ok'>OK  ALTER sessoes ADD $col</span>\n"; $ok++; }
        catch (PDOException $e) { echo "<span class='err'>ERR sessoes.$col: ".htmlspecialchars($e->getMessage())."</span>\n"; $err++; }
    } else { echo "<span class='warn'>SKIP sessoes.$col já existe</span>\n"; $skip++; }
}

// ── Passo 4: categoria Prova ─────────────────────────────────
try {
    $pdo->exec("INSERT IGNORE INTO categorias (nome, descricao) VALUES ('Prova', 'Questões revisadas para simulado de prova PMRR')");
    echo "<span class='ok'>OK  INSERT categoria Prova</span>\n"; $ok++;
} catch (PDOException $e) { echo "<span class='err'>ERR categoria Prova: ".htmlspecialchars($e->getMessage())."</span>\n"; $err++; }

// ── Passo 5: questões da Prova ──────────────────────────────
$catProva = $pdo->query("SELECT id FROM categorias WHERE nome='Prova' LIMIT 1")->fetchColumn();
if (!$catProva) { echo "<span class='err'>ERR: categoria Prova não encontrada</span>\n"; $err++; }
else {
    // Verifica quantas questões já existem nesta categoria
    $qtd = (int)$pdo->prepare("SELECT COUNT(*) FROM questoes WHERE categoria_id=?")->execute([$catProva]) ?
           $pdo->query("SELECT COUNT(*) FROM questoes WHERE categoria_id=$catProva")->fetchColumn() : 0;

    if ($qtd >= 80) {
        echo "<span class='warn'>SKIP questões Prova já inseridas ($qtd)</span>\n"; $skip++;
    } else {
        // Inserir as 80 questões da migração
        $sqlFile = file_get_contents(__DIR__ . '/migration_v2.sql');
        if ($sqlFile === false) {
            echo "<span class='err'>ERR: não foi possível ler migration_v2.sql</span>\n"; $err++;
        } else {
            // Substituir variável MySQL pelo ID real
            $sqlProcessed = str_replace('@cat_prova', (string)$catProva, $sqlFile);
            // Localizar bloco INSERT INTO questoes
            $posInsert = stripos($sqlProcessed, 'INSERT INTO questoes');
            if ($posInsert === false) {
                echo "<span class='err'>ERR: INSERT INTO questoes não encontrado no SQL</span>\n"; $err++;
            } else {
                // Encontrar o ponto-e-vírgula que encerra o statement (fora de strings)
                $len     = strlen($sqlProcessed);
                $inStr   = false;
                $strChar = '';
                $escaped = false;
                $end     = $len;
                for ($i = $posInsert; $i < $len; $i++) {
                    $c = $sqlProcessed[$i];
                    if ($escaped) { $escaped = false; continue; }
                    if ($c === '\\' && $inStr) { $escaped = true; continue; }
                    if (!$inStr && ($c === "'" || $c === '"')) { $inStr = true; $strChar = $c; continue; }
                    if ($inStr && $c === $strChar) { $inStr = false; continue; }
                    if (!$inStr && $c === ';') { $end = $i; break; }
                }
                $insertSql = trim(substr($sqlProcessed, $posInsert, $end - $posInsert));
                $insertedQ = 0;
                try {
                    $pdo->exec($insertSql);
                    $insertedQ = (int)$pdo->query("SELECT COUNT(*) FROM questoes WHERE categoria_id=$catProva")->fetchColumn();
                    echo "<span class='ok'>OK  $insertedQ questões da Prova inseridas</span>\n"; $ok++;
                } catch (PDOException $e) {
                    echo "<span class='err'>ERR INSERT questoes: ".htmlspecialchars(mb_substr($e->getMessage(),0,200))."</span>\n"; $err++;
                    echo "<span class='warn'>SQL preview: ".htmlspecialchars(mb_substr($insertSql,0,300))."</span>\n";
                }
            }
        }
    }
}

echo "\n<hr>\n";
echo "<span class='ok'>✅ OK: $ok</span>  ";
echo "<span class='warn'>⚠️ SKIP: $skip</span>  ";
echo "<span class='err'>❌ ERROS: $err</span>\n\n";

// Verificar tabelas criadas
echo "<h3 style='color:#fff'>📋 Verificação do banco:</h3>\n";
$checks = [
    "SELECT COUNT(*) AS total FROM militares"           => "Tabela militares",
    "SELECT COUNT(*) AS total FROM categorias"          => "Categorias",
    "SELECT COUNT(*) AS total FROM questoes"            => "Questões",
    "SHOW COLUMNS FROM questoes LIKE 'opcao_e'"         => "Coluna opcao_e",
    "SHOW COLUMNS FROM sessoes LIKE 'militar_id'"       => "Coluna sessoes.militar_id",
    "SHOW COLUMNS FROM sessoes LIKE 'tipo'"             => "Coluna sessoes.tipo",
    "SHOW COLUMNS FROM sessoes LIKE 'numero_tentativa'" => "Coluna sessoes.numero_tentativa",
];
foreach ($checks as $q => $label) {
    try {
        $r = $pdo->query($q)->fetch(PDO::FETCH_ASSOC);
        $val = $r ? implode(', ', array_values($r)) : 'vazio';
        echo "<span class='ok'>✅ $label: $val</span>\n";
    } catch (PDOException $e) {
        echo "<span class='err'>❌ $label: " . htmlspecialchars($e->getMessage()) . "</span>\n";
    }
}

echo "</pre><br><p style='color:#888'>⚠️ Remova este arquivo após uso!</p></body></html>";
