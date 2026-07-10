-- ============================================================
-- NORMALIZACAO — remocao de remissoes a fonte nos ENUNCIADOS
-- Tira do enunciado frases como "Segundo o material didatico", "Com base no
--   material", "citada no material de referencia", "listados no Caderno
--   Doutrinario" e a tarja "(NIVEL ALTO)". O aluno nao tem esse material a mao;
--   o fato juridico/tecnico se sustenta sozinho (guia_elaboracao_questoes.md).
-- Alvo: 9 questoes ativas nas disciplinas 4, 7, 10, 11, 12 e 19.
-- Patch por ID (preciso). UPDATE idempotente: rerodar nao reencontra o texto antigo.
-- ============================================================
SET NAMES utf8mb4;

-- disc 4 (Abordagem Policial) — irrenunciabilidade dos direitos fundamentais
UPDATE questoes SET enunciado =
 'Durante uma palestra em uma Academia de Polícia, um instrutor explica que o Estado brasileiro, ao assinar tratados internacionais de direitos humanos, assume o compromisso de proteger bens jurídicos que o próprio indivíduo não pode abrir mão. A característica que impede que o Estado deixe de respeitar um direito fundamental, ainda que o titular deseje renunciar ao seu gozo, denomina-se:'
 WHERE id = 785;

-- disc 4 — fundada suspeita
UPDATE questoes SET enunciado =
 'O conceito de "fundada suspeita" é o requisito legal para a realização da busca pessoal sem mandado. Sobre esse conceito, é correto afirmar que:'
 WHERE id = 795;

-- disc 4 — busca domiciliar
UPDATE questoes SET enunciado =
 'Na execução de um mandado de busca domiciliar, o agente público deve observar ritos legais para garantir a validade do ato. Nesse contexto, o procedimento correto envolve:'
 WHERE id = 804;

-- disc 4 — uso abusivo de algemas (tira tarja "(NIVEL ALTO)" e "Segundo o material")
UPDATE questoes SET enunciado =
 'O emprego abusivo ou indevido de algemas, em desacordo com o entendimento consolidado do Supremo Tribunal Federal, acarreta consequências graves. Tal conduta pode gerar:'
 WHERE id = 809;

-- disc 7 (Direito Administrativo) — independencia das instancias
UPDATE questoes SET enunciado =
 'A responsabilidade funcional do servidor público é pautada pela independência das instâncias. A sentença penal absolutória somente impedirá a punição administrativa do servidor quando:'
 WHERE id = 903;

-- disc 10 (LGBTQIAPN+) — enunciado era so "Segundo o material de referencia:"; reconstruido com contexto
UPDATE questoes SET enunciado =
 'Em uma capacitação sobre diversidade, discute-se a diferença técnica entre os conceitos de "sexo" e "gênero". Assinale a alternativa que os distingue corretamente:'
 WHERE id = 975;

-- disc 12 (Gestao de Materiais) — estoque como investimento
UPDATE questoes SET enunciado =
 'A gestão de estoque lida com recursos ociosos que possuem valor econômico. O investimento nesses recursos é estrategicamente equivalente a investimentos em máquinas e equipamentos porque:'
 WHERE id = 1021;

-- disc 11 (Etica Profissional) — revolta como ultimo direito do povo
UPDATE questoes SET enunciado =
 'Segundo uma célebre reflexão sobre a relação do povo com o Estado, a revolta é definida como:'
 WHERE id = 1062;

-- disc 19 (Tecnica Policial) — acessorios da blitz (tira "listados no Caderno Doutrinario")
UPDATE questoes SET enunciado =
 'Um Oficial de Logística prepara o material para uma Blitz Categoria 2. Ele disponibiliza 6 cones de sinalização, 2 lanternas e 1 etilômetro. Quanto aos itens acessórios obrigatórios de sinalização, esta carga logística está:'
 WHERE id = 1452;

-- disc 4 — remocao da tarja "(NIVEL ALTO)" residual do caderno (sem valor para o aluno)
UPDATE questoes SET enunciado = TRIM(REPLACE(enunciado, '(NÍVEL ALTO) ', ''))
 WHERE id IN (793, 800) AND enunciado LIKE '(NÍVEL ALTO)%';

-- 2a rodada: remissoes a fonte com fraseado que a 1a passada nao pegou
-- ("citado no material", "o material destaca", "e o material estudado", "De acordo com o material").

-- disc 4 — busca veicular / entendimento do STF (tira "(RHC ...) citado no material")
UPDATE questoes SET enunciado =
 'Um policial intercepta um veículo e, suspeitando de que há armas no porta-malas, realiza a busca veicular contra a vontade do condutor. De acordo com o entendimento do Supremo Tribunal Federal, é correto afirmar que:'
 WHERE id = 798;

-- disc 4 — correspondencia lacrada em busca domiciliar (tira "orientacoes tecnicas do material")
UPDATE questoes SET enunciado =
 'Durante o cumprimento de uma busca domiciliar legítima, a equipe encontra correspondência (cartas) lacradas. Sobre o procedimento correto, o policial deve:'
 WHERE id = 805;

-- disc 4 — ingresso por mandado (tira "e o material estudado")
UPDATE questoes SET enunciado =
 'Um juiz expede um mandado de busca para a apreensão de armas em uma residência. Conforme a Constituição Federal de 1988, o ingresso forçado com base exclusivamente nesse mandado judicial poderá ocorrer:'
 WHERE id = 806;

-- disc 4 — crime de resistencia (tira "o material destaca que")
UPDATE questoes SET enunciado =
 'O crime de Resistência exige a oposição à execução de ato legal. Sobre o elemento "violência" desse crime, é correto afirmar que:'
 WHERE id = 811;

-- disc 13 — non bis in idem (tira "De acordo com o material")
UPDATE questoes SET enunciado =
 'A Lei 14.230/2021 reforçou o princípio do non bis in idem nas sanções a pessoas jurídicas. No caso das pessoas jurídicas, isso significa que:'
 WHERE id = 1108;

-- disc 9 — DUDH: tira a referencia a faixa de artigos ("Artigos 1o ao 5o") do enunciado,
-- mantendo o contexto (nucleo protetivo da DUDH). O que se responde e conteudo, nao numero.
UPDATE questoes SET enunciado =
 'A Declaração Universal dos Direitos Humanos (DUDH), em seu núcleo inicial, estabelece proteções fundamentais à dignidade da pessoa. Entre as proibições ali expressas, encontra-se:'
 WHERE id = 953;
