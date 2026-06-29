# Quiz PMRR - Legislacoes Militares

## Visao Geral

Sistema de quiz para militares da PMRR (Policia Militar de Roraima) estudarem legislacoes militares. Aplicacao PHP monolitica (single-file: `index.php` ~2500 linhas) com MySQL, deploy automatico via FTP (GitHub Actions).

**URL de producao:** cacresportes.com.br/quiz/

## Stack

- **Backend:** PHP 8+ (PDO/MySQL, sessoes nativas, sem framework)
- **Frontend:** HTML/CSS/JS puro inline no index.php (sem build, sem npm)
- **Banco:** MySQL (hospedagem compartilhada)
- **Deploy:** GitHub Actions → FTP para `/public_html/quiz/`
- **Idioma:** Interface 100% em portugues brasileiro

## Arquitetura

Tudo esta em `index.php`:
- **Linhas 1-130:** Conexao DB, funcoes de sessao (`getDB`, `militar`, `isAdmin`, `verifySessionToken`)
- **Linhas 130-240:** CSRF, migracao automatica de colunas, session start
- **Linhas 240-736:** Handlers POST (todas as acoes AJAX: login, cadastro, heartbeat, listar_online, responder, etc.)
- **Linhas 738-760:** Roteamento GET por `?p=` (inicio, quiz, prova, provas, leis, slides, audios, historico, admin)
- **Linhas 760+:** HTML/CSS/JS das paginas

### Funcionalidades Principais

- Cadastro/login de militares com aprovacao por admin
- Quiz (modo treino) e Prova (modo avaliacao com 80 questoes)
- Sessoes com controle de tentativas
- Heartbeat a cada 30s com timeout de 10min de inatividade
- Painel admin: aprovacao de usuarios, militares online, questoes reportadas
- Historico de tentativas com filtros
- Deploy automatico no push para main

## Arquivos Importantes

- `index.php` — aplicacao inteira (PHP + HTML + CSS + JS)
- `config.php` — credenciais DB (NAO versionado, ver `config.sample.php`)
- `config.sample.php` — template de config
- `.github/workflows/ftp-deploy.yml` — CI/CD
- `quiz_pmrr.sql` — schema inicial do banco
- `migration_v2.sql` — migracao para v2 (sessoes, auth, prova2)
- `*.sql` — arquivos de carga de questoes

## Convencoes

- Commits em portugues
- Funcoes PHP usam snake_case
- JS inline, sem modules
- CSS via custom properties (--verde, --verde-md, etc.)
- Acoes AJAX via POST com campo `acao` (FormData)
- Respostas JSON: `{ ok: true, ... }` ou `{ erro: "mensagem" }`

## Cuidados

- NUNCA commitar `config.php` (credenciais reais)
- Testar queries SQL com cuidado — producao usa hospedagem compartilhada
- O arquivo `index.php` e grande — editar com precisao (usar line numbers)
- Deploy e automatico no push para main — cuidado com commits na main
