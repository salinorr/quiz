-- ============================================================
-- QUIZ — Disciplina 4/20 do CHO: Aspectos Jurídicos da Abordagem Policial
-- 30 questões — dupla justificativa (doutrina da apostila + fundamento legal vigente)
-- Base doutrinária: Módulos I, II e III da apostila do curso (Direitos Fundamentais,
--   Ato Administrativo/Poder de Polícia, Fundada Suspeita/Busca, Algemas, Crimes contra a Adm. Pública)
-- Base legal vigente: CRFB/88 art. 5º, XI e XII; CPP (Decreto-Lei 3.689/1941) arts. 240, 244,
--   249, 474 §3º (Lei 11.689/2008); CP (Decreto-Lei 2.848/1940) arts. 150, 329, 330, 333;
--   LCP (Decreto-Lei 3.688/1941) art. 68; Súmula Vinculante 11/STF; STF RHC 90.376/RJ;
--   STF HC 81.305-4/GO; Lei 13.869/2019 (revogou a Lei 4.898/65)
-- ============================================================
-- (Arquivo regenerado do banco de producao em 2026-07-10: RELOAD FIEL, reflete
--  as normalizacoes ja aplicadas. Padrao seguro: categoria via WHERE NOT EXISTS e
--  aposentar via ativa=0 -- ver project_cho_disciplinas na memoria.)

SET NAMES utf8mb4;

INSERT INTO categorias (nome, descricao)
SELECT 'Aspectos Jurídicos da Abordagem Policial — CHO 04', 'Disciplina 4/20 do CHO — Fundamentos constitucionais, poder de polícia, fundada suspeita e busca pessoal/domiciliar'
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categorias WHERE nome = 'Aspectos Jurídicos da Abordagem Policial — CHO 04');

SET @cat_reg = (SELECT id FROM categorias WHERE nome = 'Aspectos Jurídicos da Abordagem Policial — CHO 04' ORDER BY id LIMIT 1);

UPDATE questoes SET ativa = 0 WHERE categoria_id = @cat_reg;

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01
(@cat_reg, 'Durante uma palestra em uma Academia de Polícia, um instrutor explica que o Estado brasileiro, ao assinar tratados internacionais de direitos humanos, assume o compromisso de proteger bens jurídicos que o próprio indivíduo não pode abrir mão. A característica que impede que o Estado deixe de respeitar um direito fundamental, ainda que o titular deseje renunciar ao seu gozo, denomina-se:', 'Indisponibilidade.', 'Relatividade.', 'Universalidade.', 'Inalienabilidade.', 'Aplicabilidade imediata.',
 'A', 'Justificativa doutrinária (apostila): a Indisponibilidade impede a renúncia do direito fundamental, vinculando o Estado à sua proteção mesmo contra a vontade do titular. A Universalidade refere-se à abrangência a todos; a Relatividade refere-se ao limite entre direitos; a Inalienabilidade refere-se à impossibilidade de venda/transmissão do direito.

📜 Fundamento legal vigente: não há dispositivo constitucional que defina a indisponibilidade nominalmente, mas ela decorre do regime de proteção reforçada dos direitos fundamentais como cláusulas pétreas (CF, art. 60, §4º, IV) e do fundamento da dignidade da pessoa humana (CF, art. 1º, III), que impedem que o próprio titular disponha por completo da proteção estatal sobre o bem jurídico protegido.', 'CF, art. 1º, III c/c art. 60, §4º, IV — Módulo I, Características dos Direitos Fundamentais', 'facil'),

-- Q02
(@cat_reg, 'Considere a atuação de uma patrulha em uma comunidade vulnerável. Para que a intervenção estatal respeite o princípio da dignidade da pessoa humana, conforme definido no eixo central dos direitos fundamentais, o agente deve assegurar que:', 'O interesse da segurança pública prevaleça sobre qualquer garantia individual, dado o caráter absoluto da soberania estatal.', 'Seja garantido ao cidadão um mínimo existencial moral e material, respeitando-se seus valores éticos, sua intimidade e liberdade.', 'A abordagem seja pautada estritamente pelo clamor público local, independentemente de parâmetros legais prévios.', 'O direito de locomoção do indivíduo seja mantido de forma plena e absoluta, impedindo qualquer busca pessoal preventiva.', 'A atuação policial ignore tratados internacionais para priorizar a legislação interna de segurança.',
 'B', 'Justificativa doutrinária (apostila): a dignidade da pessoa humana exige o respeito ao mínimo existencial e aos valores morais do abordado. A segurança pública não é absoluta, e a atuação policial deve respeitar a lei, não apenas o clamor público ou impedir toda e qualquer busca preventiva legítima.

📜 Fundamento legal vigente: CF, art. 1º, III, que erige a dignidade da pessoa humana a fundamento da República Federativa do Brasil, irradiando efeitos sobre toda a atuação estatal, inclusive a abordagem policial, que deve ser pautada pela legalidade e pela proporcionalidade, não pelo mero clamor público.', 'CF, art. 1º, III — Módulo I, Dignidade da Pessoa Humana', 'facil'),

-- Q03
(@cat_reg, 'Um nacional é detido em flagrante por crime comum. À luz da Convenção Americana sobre Direitos Humanos (Pacto de São José da Costa Rica), documento integrante do ordenamento jurídico brasileiro, a autoridade policial deve observar que a pessoa presa seja conduzida, sem demora, à presença de:', 'Um oficial de superior patente da instituição responsável pela custódia.', 'Um representante do Ministério Público, obrigatoriamente.', 'Um juiz ou outra autoridade habilitada por lei a exercer funções judiciais.', 'Uma comissão de Direitos Humanos da Ordem dos Advogados do Brasil.', 'Um conselho de ética da corregedoria de polícia.',
 'C', 'Justificativa doutrinária (apostila): o Pacto de São José da Costa Rica é explícito ao determinar a condução à presença de um juiz ou autoridade judicial. As demais opções não possuem previsão no referido tratado internacional.

📜 Fundamento legal vigente: Convenção Americana sobre Direitos Humanos, art. 7º, item 5: "Toda pessoa presa, detida ou retida deve ser conduzida, sem demora, à presença de um juiz ou outra autoridade autorizada por lei a exercer funções judiciais (...)". Tratado incorporado ao direito brasileiro pelo Decreto 678/1992, sendo o fundamento normativo da audiência de custódia (CPP, art. 310).', 'CADH (Pacto de São José), art. 7º, item 5; Decreto 678/1992 — Módulo I', 'medio'),

-- Q04
(@cat_reg, 'Ao analisar o conflito entre o direito de ir e vir de um indivíduo e o dever do Estado de manter a ordem pública através de uma blitz, aplica-se o conceito de que os direitos fundamentais não são ilimitados. Esse entendimento, que permite a intervenção estatal para o bem comum, fundamenta-se no princípio da:', 'Supremacia absoluta da liberdade individual.', 'Irretroatividade das garantias fundamentais.', 'Imunidade administrativa do agente público.', 'Relatividade ou convivência das liberdades públicas.', 'Universalidade restritiva.',
 'D', 'Justificativa doutrinária (apostila): o princípio da Relatividade ensina que os direitos fundamentais não são absolutos e podem sofrer restrições para a convivência social e o bem comum.

📜 Fundamento legal vigente: não há um dispositivo constitucional único que nomine a "relatividade", mas ela decorre da interpretação sistemática do art. 5º da CF, cujos próprios incisos preveem limitações internas aos direitos que enunciam (ex.: incisos XI e XII), autorizando a atuação estatal de segurança pública dentro dos limites legais.', 'CF, art. 5º (interpretação sistemática) — Módulo I, Relatividade dos Direitos Fundamentais', 'facil'),

-- Q05
(@cat_reg, 'Na estruturação jurídica brasileira, é imperativo distinguir os bens protegidos dos instrumentos que visam assegurar essa proteção. Com base no texto de apoio, assinale a definição correta:', 'Direitos são os meios processuais (como o Habeas Corpus), enquanto garantias são os bens da vida (como a vida).', 'Não existe distinção técnica, sendo termos sinônimos utilizados pela Constituição de 1988 para reforçar o texto.', 'Garantias fundamentais são normas facultativas ao Estado, enquanto direitos fundamentais são impositivos apenas em tempo de guerra.', 'Direitos fundamentais podem ser suprimidos por emendas constitucionais, enquanto as garantias são cláusulas pétreas.', 'Direitos são os bens inseridos no patrimônio do indivíduo (vida, liberdade); garantias são os instrumentos para assegurar tais direitos contra arbítrios.',
 'E', 'Justificativa doutrinária (apostila): direitos são os bens jurídicos em si (vida, honra, liberdade); garantias são as ferramentas processuais e institucionais (como o habeas corpus) para protegê-los contra o arbítrio. A alternativa A inverte os conceitos.

📜 Fundamento legal vigente: a distinção reflete-se na própria estrutura do Título II da CF/1988 ("Dos Direitos e Garantias Fundamentais"), que arrola os bens jurídicos protegidos no art. 5º e, entre seus incisos, prevê remédios constitucionais como o habeas corpus (art. 5º, LXVIII), que é a garantia processual do direito de locomoção.', 'CF, Título II c/c art. 5º, LXVIII — Módulo I, Direitos e Garantias', 'facil'),

-- Q06
(@cat_reg, 'Uma guarnição policial decide realizar uma abordagem a um veículo que trafega em atitude suspeita. A ordem de parada é cumprida imediatamente. O atributo do ato administrativo que permite à Administração Pública fazer cumprir suas decisões pelos seus próprios meios, sem necessidade de autorização prévia do Poder Judiciário, é a:', 'Autoexecutoriedade.', 'Presunção de legitimidade.', 'Imperatividade.', 'Tipicidade subjetiva.', 'Discricionariedade absoluta.',
 'A', 'Justificativa doutrinária (apostila): a Autoexecutoriedade permite a execução do ato pelo Estado sem ordem judicial prévia. A Imperatividade é a imposição da vontade estatal independentemente da concordância do particular, mas é a autoexecutoriedade que trata especificamente da execução física/direta do ato.

📜 Fundamento legal vigente: trata-se de atributo doutrinário do ato administrativo (poder de polícia), reconhecido pela jurisprudência e amparado no poder-dever de atuação da Administração Pública decorrente do art. 144 da CF (segurança pública como dever do Estado e direito e responsabilidade de todos), que autoriza a ação imediata da polícia sem prévia intervenção judicial.', 'CF, art. 144 — Módulo II, Atributos do Ato Administrativo', 'medio'),

-- Q07
(@cat_reg, 'No exercício da abordagem policial, o agente deve estar devidamente investido no cargo para que o ato seja válido. Quando a lei outorga a um servidor uma parcela de atribuições para a prática de atos administrativos, estamos diante do elemento:', 'Objeto.', 'Sujeito (ou Competência).', 'Forma.', 'Motivo.', 'Finalidade.',
 'B', 'Justificativa doutrinária (apostila): o elemento Sujeito ou Competência refere-se à atribuição legal conferida ao agente para praticar o ato administrativo.

📜 Fundamento legal vigente: Lei 4.717/1965 (Lei da Ação Popular), art. 2º, alínea "a", que arrola a incompetência como um dos vícios do ato administrativo passíveis de anulação, confirmando a competência como elemento essencial de validade do ato.', 'Lei 4.717/1965, art. 2º, "a" — Módulo II, Elementos do Ato Administrativo', 'medio'),

-- Q08
(@cat_reg, 'Sobre o exercício do poder de polícia e a margem de escolha conferida ao agente público, assinale a alternativa juridicamente correta segundo a doutrina de Direito Administrativo apresentada:', 'A discricionariedade permite que o policial ignore a lei em nome da eficiência operacional.', 'A arbitrariedade é a liberdade de escolha conferida pela lei ao administrador para decidir sobre a conveniência e oportunidade.', 'A discricionariedade é o exercício da escolha dentro dos limites legais; a arbitrariedade é o abuso que extrapola ou contraria esses limites.', 'O poder de polícia é sempre vinculado, não admitindo qualquer margem de conveniência no momento da abordagem.', 'A conveniência e a oportunidade são elementos que transformam o ato administrativo em um ato privado do policial.',
 'C', 'Justificativa doutrinária (apostila): a discricionariedade é a margem de escolha dentro da lei (conveniência/oportunidade); a arbitrariedade é o ato ilegal ou praticado com abuso, e não uma modalidade de discricionariedade.

📜 Fundamento legal vigente: o princípio da legalidade (CF, art. 37, caput) é o limite jurídico que separa a discricionariedade legítima da arbitrariedade — dentro da lei, há espaço de conveniência e oportunidade; fora dela, há apenas abuso de poder, sujeito a controle judicial e responsabilização do agente.', 'CF, art. 37, caput — Módulo II, Discricionariedade x Arbitrariedade', 'medio'),

-- Q09
(@cat_reg, 'Um policial militar realiza uma busca pessoal em um desafeto pessoal sob o pretexto de "averiguação de rotina", embora não houvesse qualquer indício de ilicitude. O agente possui competência para realizar buscas, mas utilizou o poder legal para satisfazer um anseio de vingança particular. Nesse cenário, o ato administrativo é nulo por vício de:', 'Forma, pois a abordagem deveria ter sido registrada por escrito antes da execução.', 'Objeto, pois a revista pessoal é proibida pelo Código de Processo Penal em locais públicos.', 'Motivo, pois a inexistência de crime impede a realização de qualquer abordagem preventiva.', 'Desvio de finalidade, pois o ato foi praticado fora do interesse público e da finalidade prevista em lei.', 'Excesso de competência, pois apenas oficiais podem determinar buscas em via pública.',
 'D', 'Justificativa doutrinária (apostila): o Desvio de Finalidade ocorre quando o agente tem a competência para o ato, mas o pratica visando fim diverso do interesse público — no caso, a satisfação de vingança pessoal, e não a apuração de ilícito.

📜 Fundamento legal vigente: Lei 4.717/1965 (Lei da Ação Popular), art. 2º, parágrafo único, "e": há desvio de finalidade "quando o agente pratica o ato visando a fim diverso daquele previsto, explícita ou implicitamente, na regra de competência". A busca pessoal só é lícita quando amparada em fundada suspeita objetiva (CPP, art. 244), jamais em motivação pessoal do agente.', 'Lei 4.717/1965, art. 2º, par. único, "e"; CPP, art. 244 — Módulo II, Finalidade do Ato Administrativo', 'dificil'),

-- Q10
(@cat_reg, 'O "Objeto" é o resultado prático do ato administrativo. Para que a abordagem policial (objeto) seja considerada válida perante o ordenamento jurídico, ela deve ser:', 'Genérica e aplicável a qualquer cidadão que transite em área de risco.', 'Precedida, obrigatoriamente, de autorização do Ministério Público em todos os casos.', 'Subjetiva, baseada exclusivamente no "feeling" profissional do agente.', 'Mantida em sigilo absoluto, sem que o abordado saiba o motivo da intervenção.', 'Lícita e determinada quanto ao destinatário, efeitos, tempo e lugar.',
 'E', 'Justificativa doutrinária (apostila): o Objeto deve ser lícito e determinado (quem, onde, quando). Abordagens genéricas ou puramente subjetivas ferem a legalidade do ato administrativo.

📜 Fundamento legal vigente: Lei 4.717/1965, art. 2º, alínea "c" (ilegalidade do objeto). A exigência de determinação também decorre da vedação constitucional a discriminações (CF, art. 5º, caput) e da jurisprudência do STJ, que considera ilegal a busca pessoal fundada em critérios genéricos, sem elementos concretos que individualizem a suspeita.', 'Lei 4.717/1965, art. 2º, "c" — Módulo II, Elementos do Ato Administrativo', 'medio'),

-- Q11
(@cat_reg, 'O conceito de "fundada suspeita" é o requisito legal para a realização da busca pessoal sem mandado. Sobre esse conceito, é correto afirmar que:', 'A suspeita deve basear-se em atitudes do cidadão que, por algum motivo, destoem da realidade daquele momento.', 'A fundada suspeita autoriza a abordagem baseada em raça, cor ou nível socioeconômico para otimizar resultados.', 'A suspeita deve recair sobre a pessoa (pessoa suspeita) e não sobre a conduta.', 'O subjetivismo do agente é o único critério necessário e suficiente para validar a abordagem.', 'A "fundada suspeita" é um conceito definido detalhadamente no Código Tributário Nacional.',
 'A', 'Justificativa doutrinária (apostila): não existe pessoa suspeita, mas atitudes suspeitas que destoam do contexto. A fundada suspeita não autoriza discriminação nem se baseia apenas no subjetivismo do agente.

📜 Fundamento legal vigente: CPP, art. 244, que exige "fundada suspeita" para a busca pessoal sem mandado — expressão interpretada pela jurisprudência do STJ e do STF como exigência de elementos objetivos e concretos, vedando fundamentação em critérios discriminatórios (raça, cor, sexo, classe social) ou em mera intuição do agente.', 'CPP, art. 244 — Módulo II, Conceito de Fundada Suspeita', 'medio'),

-- Q12
(@cat_reg, 'De acordo com o Código de Processo Penal (CPP), a busca pessoal independerá de mandado em situações específicas. Assinale a alternativa que apresenta uma dessas hipóteses legais:', 'Quando a pessoa demonstrar timidez ao avistar a viatura policial.', 'No caso de prisão ou quando houver fundada suspeita de que a pessoa oculte arma proibida ou objetos que constituam corpo de delito.', 'Sempre que a pessoa estiver em local onde ocorreu um crime nas últimas 24 horas.', 'Quando o indivíduo for conhecido por possuir antecedentes criminais, independentemente da atitude atual.', 'Sempre que a medida for solicitada por um morador da localidade, servindo como "denúncia anônima".',
 'B', 'Justificativa doutrinária (apostila): o Art. 244 do CPP autoriza a busca sem mandado na posse de arma proibida ou corpo de delito e no caso de prisão.

📜 Fundamento legal vigente: CPP, art. 244: "A busca pessoal independerá de mandado, no caso de prisão ou quando houver fundada suspeita de que a pessoa esteja na posse de arma proibida ou de objetos ou papéis que constituam corpo de delito, ou quando a medida for determinada no curso de busca domiciliar."', 'CPP, art. 244', 'medio'),

-- Q13
(@cat_reg, 'Durante uma operação, uma equipe policial composta apenas por homens aborda um casal em atitude suspeita. Quanto à busca pessoal na mulher, o Código de Processo Penal estabelece que:', 'Deve ser feita obrigatoriamente por policiais masculinos se o crime for grave.', 'Só pode ocorrer com a presença de uma juíza ou promotora no local.', 'Será feita por outra mulher, se isso não importar em retardamento ou prejuízo da diligência.', 'É absolutamente proibida na ausência de uma policial feminina, sob pena de nulidade.', 'Deve ser realizada apenas de forma mecânica (detectores de metais) por homens.',
 'C', 'Justificativa doutrinária (apostila): a regra do Art. 249 do CPP prioriza a busca por mulher, salvo se o retardamento prejudicar a diligência (ex.: urgência extrema sem policial feminina próxima).

📜 Fundamento legal vigente: CPP, art. 249: "A busca em mulher será feita por outra mulher, se não importar retardamento ou prejuízo da diligência." A regra visa preservar o pudor, a intimidade e a dignidade da mulher revistada, cedendo apenas diante de urgência comprovada.', 'CPP, art. 249', 'medio'),

-- Q14
(@cat_reg, 'Um policial intercepta um veículo e, suspeitando de que há armas no porta-malas, realiza a busca veicular contra a vontade do condutor. De acordo com o entendimento do Supremo Tribunal Federal, é correto afirmar que:', 'A busca é ilegal, pois o veículo é extensão do domicílio e exige mandado judicial.', 'O veículo só pode ser revistado se houver a prisão do condutor em flagrante delito.', 'A busca veicular só é permitida durante o dia, mesmo com fundada suspeita.', 'É lícita a abordagem a veículos se houver fundada suspeita de que em seu interior existam objetos que constituam corpo de delito.', 'O STF proíbe buscas veiculares baseadas em suspeitas, exigindo indícios de crime hediondo.',
 'D', 'Justificativa doutrinária (apostila): o STF entende lícita a busca veicular havendo fundada suspeita de corpo de delito, não sendo o veículo, em regra de trânsito, extensão do domicílio.

📜 Fundamento legal vigente: STF, RHC 90.376/RJ, Rel. Min. Celso de Mello, 2ª Turma, j. 03/04/2007 — precedente que trata da licitude da busca veicular fundada em suspeita objetiva e da distinção entre veículo e domicílio para fins de exigência de mandado, em conjunto com a regra geral do art. 244 do CPP.', 'STF, RHC 90.376/RJ; CPP, art. 244', 'dificil'),

-- Q15
(@cat_reg, 'A proteção constitucional da "casa" é ampla, mas possui limites definidos no Código Penal e na doutrina. Assinale a opção que descreve um local que NÃO se compreende na expressão jurídica de "casa" para fins de proteção de inviolabilidade:', 'Qualquer compartimento habitado, como um quarto de pensão.', 'Aposento ocupado de habitação coletiva, como quartos de hotéis.', 'Cabine de um caminhão, se o proprietário nela se estabelecer com ânimo de moradia.', 'Trailer, enquanto parado e utilizado como residência.', 'Taverna, casa de jogo e outras do mesmo gênero.',
 'E', 'Justificativa doutrinária (apostila): o Art. 150, §5º, do CP exclui tavernas e casas de jogo do conceito de "casa". Trailers e cabines de caminhão podem ser considerados casa se houver ânimo de moradia.

📜 Fundamento legal vigente: CP, art. 150, §5º: "Não se compreendem na expressão ''casa'': I - hospedaria, estalagem ou qualquer outra habitação coletiva, enquanto aberta (...); II - taverna, casa de jogo e outras do mesmo gênero." Já o §4º do mesmo artigo inclui expressamente "qualquer compartimento habitado" (o que abrange trailer e cabine de caminhão com ânimo de moradia) e o aposento de habitação coletiva.', 'CP, art. 150, §§4º e 5º', 'medio'),

-- Q16
(@cat_reg, 'Policiais militares patrulham uma cidade litorânea em um dia de intenso calor. Eles observam um homem caminhando com um "blusão" de frio pesado e decidem abordá-lo e revistá-lo unicamente por esse motivo. À luz do julgamento do STF no HC nº 81.305-4/GO, essa abordagem é:', 'Arbitrária, pois a fundada suspeita exige elementos concretos e sensíveis, não podendo fundar-se em parâmetros unicamente subjetivos.', 'Legal, baseada no poder discricionário que permite a revista em qualquer pessoa em via pública.', 'Legal, pois o uso de roupa inadequada ao clima é elemento objetivo suficiente de fundada suspeita.', 'Nula por vício de competência, pois apenas a Polícia Civil pode realizar revistas em pedestres.', 'Legítima, desde que os policiais encontrem algum objeto ilícito após a revista, o que validaria o ato retroativamente.',
 'A', 'Justificativa doutrinária (apostila): no HC 81.305-4/GO, o STF decidiu que elementos puramente subjetivos (como um "blusão") são insuficientes para a fundada suspeita, exigindo elementos concretos para evitar o arbítrio.

📜 Fundamento legal vigente: STF, HC 81.305-4/GO — caso em que a autoridade policial justificou a busca pessoal unicamente pelo fato de o abordado usar um blusão capaz de ocultar arma; o STF entendeu que a fundada suspeita do art. 244 do CPP "não pode fundar-se em parâmetros unicamente subjetivos, exigindo elementos concretos indicativos da necessidade da busca", sob pena de chancelar abordagem arbitrária.', 'STF, HC 81.305-4/GO; CPP, art. 244', 'dificil'),

-- Q17
(@cat_reg, 'A busca pessoal pode ocorrer de forma ocular, manual ou mecânica. Assinale o exemplo correto de busca mecânica:', 'O policial solicita que o abordado esvazie os próprios bolsos.', 'O uso de aparelhos detectores de metais ou raio-x, comuns em aeroportos.', 'O policial realiza o contato físico para palpar as vestes do suspeito.', 'A observação atenta do comportamento do indivíduo à distância.', 'A requisição de perícia papiloscópica no local da abordagem.',
 'B', 'Justificativa doutrinária (apostila): a busca mecânica utiliza tecnologia (raio-x, detectores). A busca manual envolve contato físico e a ocular apenas visualização solicitada ao abordado.

📜 Fundamento legal vigente: a classificação em ocular, manual e mecânica é doutrinária (processualística penal), decorrente da interpretação do art. 244 do CPP, que não distingue expressamente as técnicas de execução da busca pessoal, deixando à prática policial a escolha do meio mais adequado e proporcional às circunstâncias.', 'CPP, art. 244 (interpretação doutrinária)', 'medio'),

-- Q18
(@cat_reg, 'Um cidadão é abordado legitimamente em razão de fundada suspeita. Ao ser solicitado a apresentar sua identificação, ele se recusa injustificadamente a fornecer seus dados à autoridade. Tal conduta configura:', 'Crime de Resistência.', 'Crime de Desobediência.', 'Contravenção penal de recusa de dados à autoridade.', 'Abuso de Autoridade por parte do cidadão.', 'Crime de Desacato, por ferir o prestígio da função pública.',
 'C', 'Justificativa doutrinária (apostila): a recusa de dados de identidade à autoridade, quando justificadamente solicitados, é contravenção prevista no Art. 68 da LCP. A resistência exigiria violência ou ameaça, o que não ocorre na mera recusa passiva.

📜 Fundamento legal vigente: Decreto-Lei 3.688/1941 (LCP), art. 68: "Recusar à autoridade, quando por esta, justificadamente solicitados ou reclamados, dados ou indicações concernentes à própria identidade, estado, profissão, domicílio e residência: Pena — multa." O parágrafo único ainda agrava a pena para prisão simples caso o cidadão preste declarações inverídicas sobre esses dados.', 'LCP (Decreto-Lei 3.688/1941), art. 68', 'medio'),

-- Q19
(@cat_reg, 'A regra constitucional é a inviolabilidade do domicílio. No entanto, há exceções previstas para o período noturno. Assinale a hipótese em que é permitido ingressar em domicílio à noite SEM o consentimento do morador:', 'Para o cumprimento de mandado de busca e apreensão expedido por juiz.', 'Para realizar a prisão de um condenado com sentença transitada em julgado.', 'Quando houver denúncia anônima de que há drogas no local, independentemente de confirmação visual.', 'Nos casos de flagrante delito, desastre ou para prestar socorro.', 'Para apreender correspondência destinada ao investigado.',
 'D', 'Justificativa doutrinária (apostila): à noite, o domicílio só pode ser violado em flagrante, desastre ou socorro. A determinação judicial só pode ser cumprida durante o dia.

📜 Fundamento legal vigente: CF, art. 5º, XI: "a casa é asilo inviolável do indivíduo, ninguém nela podendo penetrar sem consentimento do morador, salvo em caso de flagrante delito ou desastre, ou para prestar socorro, ou, durante o dia, por determinação judicial."', 'CF, art. 5º, XI', 'medio'),

-- Q20
(@cat_reg, 'Na execução de um mandado de busca domiciliar, o agente público deve observar ritos legais para garantir a validade do ato. Nesse contexto, o procedimento correto envolve:', 'O arrombamento imediato da residência, sem aviso prévio, para evitar a destruição de provas.', 'O cumprimento do mandado obrigatoriamente entre as 18h e as 21h.', 'A realização da busca por apenas um policial, para evitar constrangimento ao morador.', 'A dispensa de testemunhas, caso a guarnição seja composta por mais de três policiais.', 'A leitura do mandado ao morador, intimando-o a abrir a porta; em caso de desobediência, procede-se ao arrombamento.',
 'E', 'Justificativa doutrinária (apostila): o procedimento legal exige a leitura e intimação prévia ao morador; o arrombamento é a ultima ratio, cabível apenas em caso de desobediência ou ausência de moradores.

📜 Fundamento legal vigente: CPP, art. 245, caput e §2º: os executores "mostrarão e lerão o mandado ao morador (...) intimando-o, em seguida, a abrir a porta"; "em caso de desobediência, será arrombada a porta e forçada a entrada."', 'CPP, art. 245', 'medio'),

-- Q21
(@cat_reg, 'Durante o cumprimento de uma busca domiciliar legítima, a equipe encontra correspondência (cartas) lacradas. Sobre o procedimento correto, o policial deve:', 'Apreender os envelopes lacrados e solicitar autorização judicial para a abertura posterior, devido à proteção ao sigilo.', 'Incinerar a correspondência se ela não for o objeto principal do mandado.', 'Abrir a carta imediatamente, baseando-se na alínea "f" do Art. 240 do CPP.', 'Ignorar as cartas, pois o sigilo de correspondência é um direito absoluto que não admite exceções.', 'Ler o conteúdo para o morador e testemunhas antes de realizar a apreensão.',
 'A', 'Justificativa doutrinária (apostila): devido à proteção do sigilo de correspondência, recomenda-se apreender o envelope lacrado para que o juiz autorize a abertura, e não abri-lo unilateralmente no local.

📜 Fundamento legal vigente: CF, art. 5º, XII, que protege o sigilo da correspondência; a alínea "f" do art. 240, §1º, do CPP (que autoriza apreender cartas "quando haja suspeita de que o conhecimento do seu conteúdo possa ser útil à elucidação do fato") deve ser interpretada em conjunto com essa garantia constitucional, recomendando-se a apreensão do envelope lacrado com prévia autorização judicial para a abertura.', 'CF, art. 5º, XII; CPP, art. 240, §1º, "f"', 'medio'),

-- Q22
(@cat_reg, 'Um juiz expede um mandado de busca para a apreensão de armas em uma residência. Conforme a Constituição Federal de 1988, o ingresso forçado com base exclusivamente nesse mandado judicial poderá ocorrer:', 'Durante o dia ou durante a noite.', 'Somente durante o dia.', 'Somente se o morador for reincidente em crimes violentos.', 'A qualquer hora, desde que acompanhado por dois vizinhos.', 'Durante a noite, se houver autorização expressa do Secretário de Segurança.',
 'B', 'Justificativa doutrinária (apostila): a Constituição determina que mandado judicial de busca só pode ser cumprido durante o dia.

📜 Fundamento legal vigente: CF, art. 5º, XI, parte final: a determinação judicial de ingresso na casa alheia, sem consentimento do morador, só é lícita "durante o dia" — à noite, apenas as hipóteses de flagrante, desastre ou socorro autorizam o ingresso sem consentimento.', 'CF, art. 5º, XI', 'medio'),

-- Q23
(@cat_reg, 'O Supremo Tribunal Federal restringiu o uso de algemas a situações excepcionais. Assinale a alternativa que NÃO constitui uma hipótese lícita para o uso do equipamento:', 'Resistência por parte do preso.', 'Fundado receio de fuga do detido.', 'Exposição do preso à mídia para gerar sensação de justiça à sociedade.', 'Perigo à integridade física própria ou alheia.', 'Justificado receio de agressão do preso contra os policiais.',
 'C', 'Justificativa doutrinária (apostila): a SV 11 veda o uso de algemas como punição ou espetáculo. As hipóteses lícitas são resistência, receio de fuga ou perigo à integridade física.

📜 Fundamento legal vigente: Súmula Vinculante 11/STF: "Só é lícito o uso de algemas em casos de resistência e de fundado receio de fuga ou de perigo à integridade física própria ou alheia, por parte do preso ou de terceiros (...)". A exposição midiática do preso não figura entre as hipóteses e configura, ao contrário, hipótese clássica de uso abusivo.', 'Súmula Vinculante 11/STF', 'medio'),

-- Q24
(@cat_reg, 'Para que o uso de algemas seja considerado lícito, além de se enquadrar nas hipóteses excepcionais, a autoridade deve obrigatoriamente:', 'Filmar toda a ação de imobilização.', 'Utilizar algemas de plástico descartáveis, por serem menos degradantes.', 'Obter o consentimento prévio do advogado do preso.', 'Justificar a excepcionalidade da medida por escrito.', 'Realizar o uso apenas em ambientes fechados, longe do público.',
 'D', 'Justificativa doutrinária (apostila): a justificativa por escrito é requisito essencial de validade e controle do ato excepcional de algemar, conforme a SV 11.

📜 Fundamento legal vigente: Súmula Vinculante 11/STF, que exige que a excepcionalidade do uso de algemas seja "justificada por escrito, sob pena de responsabilidade disciplinar, civil e penal do agente ou da autoridade e de nulidade da prisão ou do ato processual a que se refere".', 'Súmula Vinculante 11/STF', 'medio'),

-- Q25
(@cat_reg, 'O emprego abusivo ou indevido de algemas, em desacordo com o entendimento consolidado do Supremo Tribunal Federal, acarreta consequências graves. Tal conduta pode gerar:', 'Apenas advertência verbal interna ao policial.', 'Responsabilidade política do comandante da unidade, sem afetar o executor do ato.', 'Responsabilidade civil do Estado, mas isenta o policial de qualquer punição individual.', 'Apenas a nulidade do ato processual, sem repercussões na esfera administrativa do servidor.', 'Responsabilidade disciplinar, civil e penal do agente, além de nulidade da prisão.',
 'E', 'Justificativa doutrinária (apostila): o uso indevido de algemas gera responsabilidade nas três esferas (administrativa/disciplinar, civil e penal) e anula o ato de prisão ou processual a que se refere.

📜 Fundamento legal vigente: Súmula Vinculante 11/STF, que prevê expressamente "responsabilidade disciplinar, civil e penal do agente ou da autoridade e (...) nulidade da prisão ou do ato processual a que se refere, sem prejuízo da responsabilidade civil do Estado" — as consequências são cumulativas, não alternativas.', 'Súmula Vinculante 11/STF', 'dificil'),

-- Q26
(@cat_reg, 'O Código de Processo Penal contém uma regra específica sobre o uso de algemas durante o plenário do júri. Sobre essa regra, é correto afirmar:', 'Não se permitirá o uso de algemas, salvo se absolutamente necessário à ordem dos trabalhos, segurança das testemunhas ou integridade dos presentes.', 'O réu deve permanecer algemado durante todo o julgamento por questão de protocolo.', 'O uso de algemas fica a critério exclusivo da imprensa que cobre o evento.', 'É permitido o uso apenas se o réu for acusado de crime contra a administração pública.', 'O juiz não pode interferir no uso de algemas, cabendo a decisão apenas à escolta policial.',
 'A', 'Justificativa doutrinária (apostila): o Art. 474, §3º, do CPP veda algemas no júri como regra, permitindo-as apenas em casos de absoluta necessidade de segurança ou ordem dos trabalhos.

📜 Fundamento legal vigente: CPP, art. 474, §3º (Lei 11.689/2008): "Não se permitirá o uso de algemas no acusado durante o período em que permanecer no plenário do júri, salvo se absolutamente necessário à ordem dos trabalhos, à segurança das testemunhas ou à garantia da integridade física dos presentes." Reforça, no ambiente do júri, a lógica protetiva da Súmula Vinculante 11.', 'CPP, art. 474, §3º (Lei 11.689/2008)', 'medio'),

-- Q27
(@cat_reg, 'O crime de Resistência exige a oposição à execução de ato legal. Sobre o elemento "violência" desse crime, é correto afirmar que:', 'Pode ser violência contra objetos, como chutar o pneu da viatura.', 'Deve ser violência física dirigida contra a pessoa do funcionário ou de quem lhe presta auxílio.', 'A "resistência passiva", como deitar no chão para dificultar a condução, configura o crime.', 'Proferir palavras de baixo calão contra o policial é suficiente para a tipificação de resistência.', 'Ocorre mesmo se a ordem dada pelo funcionário for manifestamente ilegal.',
 'B', 'Justificativa doutrinária (apostila): a resistência exige violência contra a pessoa (agente ou auxiliar). Violência contra coisas ou resistência passiva não tipificam o crime do Art. 329.

📜 Fundamento legal vigente: CP, art. 329, caput: "Opor-se à execução de ato legal, mediante violência ou ameaça a funcionário competente para executá-lo ou a quem lhe esteja prestando auxílio: Pena - detenção, de dois meses a dois anos." O tipo exige violência ou ameaça dirigida à pessoa, não bastando violência contra coisas ou resistência meramente passiva.', 'CP, art. 329', 'medio'),

-- Q28
(@cat_reg, 'No crime de Desobediência, a jurisprudência consolidada estabelece que não há tipicidade penal se:', 'O cidadão se recusar a obedecer a uma ordem verbal.', 'O desobediente for um funcionário público em horário de folga.', 'A inexecução da ordem for passível de sanção administrativa prevista em lei que não ressalva a dupla penalidade (como infrações de trânsito).', 'A ordem for emanada por autoridade judiciária e não policial.', 'O cidadão alegar desconhecimento da lei no momento da blitz.',
 'C', 'A alternativa C está correta: se a lei administrativa já prevê sanção específica (como o Código de Trânsito) e não ressalva a cumulação penal, o crime de desobediência é afastado, por força do caráter subsidiário do tipo. As demais alternativas descrevem situações que não afastam, por si sós, a tipicidade da desobediência.

📜 Fundamento legal vigente: entendimento consolidado do STJ — quando a norma administrativa comina sanção específica ao descumprimento (como o art. 195 do CTB) sem ressalvar a cumulação com sanção penal, o descumprimento não configura o crime de desobediência do art. 330 do Código Penal, em razão dos princípios da subsidiariedade e da intervenção mínima do Direito Penal.', 'CP, art. 330; CTB, art. 195 (jurisprudência do STJ sobre subsidiariedade)', 'medio'),

-- Q29
(@cat_reg, 'Um particular oferece dinheiro a um policial para que este deixe de lavrar um auto de infração de trânsito. Sobre o crime de Corrupção Ativa nesse cenário, é correto afirmar:', 'Só se consuma se o policial aceitar o dinheiro oferecido.', 'Não admite a modalidade de "promessa", apenas o "oferecimento" real.', 'Exige que a vantagem seja obrigatoriamente em moeda corrente nacional.', 'É crime formal, consumando-se com o oferecimento ou promessa, ainda que o funcionário recuse a vantagem.', 'O sujeito passivo do crime é o policial individualmente lesado em sua honra.',
 'D', 'Justificativa doutrinária (apostila): a corrupção ativa é crime formal; consuma-se com o oferecer ou prometer, independentemente da aceitação do funcionário ou do recebimento efetivo do valor.

📜 Fundamento legal vigente: CP, art. 333, caput: "Oferecer ou prometer vantagem indevida a funcionário público, para determiná-lo a praticar, omitir ou retardar ato de ofício: Pena – reclusão, de 2 (dois) a 12 (doze) anos, e multa." O parágrafo único ainda aumenta a pena em um terço se o funcionário efetivamente pratica, retarda ou omite o ato em razão da vantagem ou promessa.', 'CP, art. 333', 'medio'),

-- Q30
(@cat_reg, 'A Lei de Abuso de Autoridade em vigor (Lei nº 13.869/2019) protege a liberdade de locomoção contra atos arbitrários. Entre as condutas abaixo, constitui crime de abuso de autoridade relacionado à privação da liberdade:', 'Realizar abordagem preventiva fundamentada em elementos objetivos de suspeita.', 'Exigir que o condutor de veículo apresente a Carteira Nacional de Habilitação.', 'Solicitar a identificação civil de pessoas em atitude suspeita em via pública.', 'Prender criminoso em flagrante delito dentro do domicílio durante o dia.', 'Ordenar ou executar medida privativa da liberdade individual sem as formalidades legais ou com abuso de poder.',
 'E', 'A alternativa E está correta: ordenar ou executar medida privativa da liberdade individual sem as formalidades legais ou com abuso de poder atenta contra a liberdade de locomoção e configura abuso de autoridade. As alternativas A (abordagem fundada em elementos objetivos), B (exigir a CNH do condutor), C (solicitar identificação de pessoa em atitude suspeita) e D (prender em flagrante no domicílio durante o dia) descrevem atos legais e regulares da atividade policial, não abusivos.

📜 Fundamento legal vigente: Lei nº 13.869/2019, art. 9º — "Decretar medida de privação da liberdade em manifesta desconformidade com as hipóteses legais: Pena - detenção, de 1 a 4 anos, e multa." Esta lei disciplina integralmente o abuso de autoridade desde 2020, tendo revogado a antiga Lei nº 4.898/1965.', 'Lei 13.869/2019, art. 9º', 'medio');
