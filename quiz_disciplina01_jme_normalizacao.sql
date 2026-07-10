-- ============================================================
-- NORMALIZACAO — Disciplina 1/20 do CHO: Justica Militar Estadual (JME)
-- Aplica-se as DUAS categorias espelhadas em producao:
--   cat 12 = "Prova CHO 01 — JME"   (modo Prova)
--   cat 13 = "JME — CHO 01"         (modo Quiz)
-- Os enunciados sao identicos nas duas, entao cada UPDATE abaixo altera 2 linhas.
--
-- O que muda: apenas os enunciados que abriam com "segundo o autor X" (Castro,
--   Carvalho, Moraes, Lobao, D'Aquino/Assis, Roth) ou com "o texto apresenta".
--   O guia_elaboracao_questoes.md desaconselha decorar QUEM disse — o fato juridico
--   se sustenta sozinho. Alternativas, gabaritos, explicacoes e referencia_legal
--   ficam intactos (a autoria permanece registrada em referencia_legal).
--   Nao ha reload nem exclusao de questoes; e um patch de UPDATE idempotente
--   (rerodar nao encontra mais os enunciados antigos e nao faz nada).
-- ============================================================
SET NAMES utf8mb4;

-- Q01 — etimologia/raizes historicas (tira "a doutrina de Castro e Carvalho aponta")
UPDATE questoes
   SET enunciado = 'No que tange à etimologia e às raízes históricas do Direito Militar, é correto afirmar que:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%doutrina de Castro (2011) e Carvalho (2010) aponta%';

-- Q03 — marcos constitucionais da transicao (tira "Segundo Carvalho (2010)")
UPDATE questoes
   SET enunciado = 'A transição da Justiça Militar do Poder Executivo para o Poder Judiciário não ocorreu de forma simultânea nas esferas federal e estadual. Os marcos constitucionais dessa mudança foram, respectivamente:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%Segundo Carvalho (2010), os marcos constitucionais%';

-- Q04 — natureza juridica (tira "Alexandre de Moraes (2013) sustenta")
UPDATE questoes
   SET enunciado = 'Quanto à natureza jurídica da Justiça Militar (gênero que abrange as esferas federal e estadual), é correto afirmar que:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%Alexandre de Moraes (2013) sustenta%';

-- Q06 — inovacoes da EC 45/2004 (tira "Segundo Lobao (2010)")
UPDATE questoes
   SET enunciado = 'A Emenda Constitucional nº 45/2004 alterou profundamente a fisionomia da Justiça Militar Estadual (JME). Uma de suas principais inovações foi:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%Segundo Lobão (2010), uma das principais inovações%';

-- Q12 — criterio de definicao de crime militar (tira "segundo Ivo D'Aquino e Jorge Cesar de Assis")
UPDATE questoes
   SET enunciado = 'Sobre o critério adotado pelo legislador brasileiro para definir o que se considera crime militar, é correto afirmar que se trata do critério:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%segundo Ivo D%Aquino e Jorge Cesar de Assis%';

-- Q13 — classificacao tripartida pos Lei 13.491/2017 (tira "na visao de Roth e Assis")
UPDATE questoes
   SET enunciado = 'Com a Lei nº 13.491/2017, a classificação doutrinária dos crimes militares tornou-se tripartida. As três categorias passaram a ser:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%tripartida na visão de Roth e Assis%';

-- Q16 — "cochilo do legislador" (tira "abordado por Ronaldo Roth (2020)")
UPDATE questoes
   SET enunciado = 'Na doutrina da Justiça Militar, a expressão "cochilo do legislador" refere-se:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%abordado por Ronaldo Roth (2020), refere-se%';

-- Q29 — identidade fisica do juiz (tira "o texto apresenta")
UPDATE questoes
   SET enunciado = 'Em relação à aplicação do Princípio da Identidade Física do Juiz na Justiça Militar, há dois entendimentos conflitantes. Assinale a alternativa que sintetiza corretamente essa divergência:'
 WHERE categoria_id IN (12,13)
   AND enunciado LIKE '%o texto apresenta dois entendimentos conflitantes%';
