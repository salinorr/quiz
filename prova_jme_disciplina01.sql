-- ============================================================
-- PROVA — Disciplina 1/20 do CHO: Justiça Militar Estadual (JME)
-- 30 questões — dupla justificativa (doutrina da apostila + legislação vigente)
-- Base doutrinária: Castro (2011), Carvalho (2010), Moraes (2013), Lobão (2010),
--   Neves (2020), D''Aquino, Jorge Cesar de Assis, Ronaldo Roth (2020), Rodrigo Foureaux
-- Base legal vigente: CRFB/88 arts. 5º, XXXVII, 92, 102, 105, 122, 125 (EC 45/2004);
--   CPM (Decreto-Lei 1.001/69) arts. 9º e 10; CPPM (Decreto-Lei 1.002/69) arts. 400-403;
--   Lei 8.457/92 (por simetria); Súmulas STJ 53 e 78; Constituição do Estado de Roraima, art. 83
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('🎯 Prova CHO 01 — Justiça Militar Estadual (JME)', 'Disciplina 1/20 do CHO — Estrutura, competência e organização da Justiça Militar Estadual');

SET @cat_jme01 = (SELECT id FROM categorias WHERE nome = '🎯 Prova CHO 01 — Justiça Militar Estadual (JME)' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Etimologia
(@cat_jme01,
 'No que tange à etimologia e às raízes históricas do Direito Militar, a doutrina de Castro (2011) e Carvalho (2010) aponta que:',
 'O termo "castrense" é um neologismo do século XIX, surgido com a ascensão dos Estados-nação europeus.',
 'A expressão deriva do grego kastron, referindo-se exclusivamente às fortificações de defesa das cidades-estado.',
 'O termo possui origem no latim castrensis, significando "relativo ao acampamento militar ou ao exército".',
 'A organização judiciária militar é uma criação moderna, sem precedentes nas civilizações egípcia ou assíria.',
 'O Direito Castrense romano era um ramo do direito civil aplicado apenas a veteranos de guerra em solo itálico.',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C está correta pois, conforme Castro (2011), o termo "castrense" deriva do latim castrensis (relativo ao acampamento), originado no direito aplicado nas legiões romanas. A está incorreta pois a justiça militar remonta à antiguidade; B está incorreta pois a origem é latina, não grega; D está incorreta pois o texto cita indícios em civilizações egípcia e assíria; E está incorreta pois o objetivo era manter a disciplina das tropas em serviço, não apenas veteranos.\n\n📜 Fundamento legal vigente: trata-se de fundamento histórico-doutrinário sobre a origem do Direito Castrense, sem correspondência em dispositivo legal em vigor — a etimologia não é objeto de norma jurídica, apenas de estudo histórico do Direito Militar.',
 'Doutrina (Castro, 2011) — Apostila JME, pág. 2',
 'facil'),

-- Q02: Conselho Supremo Militar e de Justiça (1808)
(@cat_jme01,
 'O marco inaugural da cúpula do Judiciário Militar no Brasil ocorreu em 1808. Sobre esse período, é correto afirmar:',
 'O Conselho Supremo Militar e de Justiça foi criado pela Constituição de 1824.',
 'Dom João VI instituiu o Conselho Supremo Militar e de Justiça via Alvará, sendo o Tribunal Superior mais antigo do país.',
 'O órgão foi criado inicialmente para julgar civis que conspirassem contra a Família Real.',
 'A criação do Conselho extinguiu imediatamente todos os fóruns militares regionais da colônia.',
 'O Superior Tribunal Militar (STM) já nasceu com essa nomenclatura em abril de 1808.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta; o órgão foi criado em abril de 1808 por Dom João VI. A está incorreta pois a criação foi via Alvará, anterior à primeira constituição; C está incorreta pois a finalidade era julgar militares e responder a consultas do Rei; D está incorreta pois o texto foca na criação da cúpula, não na extinção de fóruns; E está incorreta pois o nome inicial era Conselho Supremo Militar e de Justiça.\n\n📜 Fundamento legal vigente: dado histórico anterior à ordem constitucional atual. Hoje o órgão de cúpula da Justiça Militar da União é o Superior Tribunal Militar — STM, previsto no art. 122, I, da CRFB/1988, herdeiro direto daquele Conselho criado em 1808.',
 'CRFB, art. 122, I — Apostila JME, pág. 2',
 'facil'),

-- Q03: Transição Executivo -> Judiciário (JMF 1934 / JME 1946)
(@cat_jme01,
 'A transição da Justiça Militar do Poder Executivo para o Poder Judiciário não ocorreu de forma simultânea nas esferas federal e estadual. Segundo Carvalho (2010), os marcos constitucionais foram:',
 'Constituição de 1891 para a Federal e 1934 para a Estadual.',
 'Constituição de 1934 para a Federal e 1946 para a Estadual.',
 'Constituição de 1946 para a Federal e 1967 para a Estadual.',
 'Constituição de 1937 para a Federal e 1988 para a Estadual.',
 'Ambas foram inseridas no Judiciário apenas com a Emenda Constitucional nº 45/2004.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta conforme Carvalho (2010). A JMF foi consagrada no Judiciário em 1934, enquanto a JME só alcançou tal status em 1946. As demais alternativas apresentam datas divergentes do processo histórico descrito.\n\n📜 Fundamento legal vigente: hoje esse processo histórico está consolidado no art. 92, VI, da CRFB/1988, que lista os Tribunais e Juízes Militares (federais e estaduais) como órgãos integrantes do Poder Judiciário — consequência direta da incorporação iniciada em 1934/1946.',
 'CRFB, art. 92, VI — Apostila JME, págs. 2-3',
 'medio'),

-- Q04: Natureza jurídica — não é tribunal de exceção
(@cat_jme01,
 'Quanto à natureza jurídica da Justiça Militar, Alexandre de Moraes (2013) sustenta que:',
 'Trata-se de um tribunal de exceção, por julgar uma categoria específica de cidadãos.',
 'É uma justiça especializada que não se confunde com tribunais de exceção, pois é constituída e organizada pela CRFB.',
 'Sua existência é tolerada apenas em tempos de guerra externa declarada.',
 'É um órgão administrativo vinculado ao Ministério da Defesa com funções jurisdicionais delegadas.',
 'A proibição de tribunais de exceção na CRFB/88 veda a existência de Justiças Especializadas.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B reflete a lição de Moraes. A e E estão incorretas pois a justiça especializada é uma divisão da atividade jurisdicional do Estado prevista na Constituição, o que a afasta da pecha de "exceção"; C está incorreta pois atua em tempo de paz; D está incorreta pois é órgão autônomo do Judiciário.\n\n📜 Fundamento legal vigente: o art. 5º, XXXVII, da CRFB veda juízo ou tribunal de exceção, mas o art. 92, VI, lista expressamente os Tribunais e Juízes Militares como órgãos do Poder Judiciário — por serem previamente constituídos, permanentes e de competência geral e abstrata (não voltados a julgar um caso ou pessoa específica), não se enquadram na vedação constitucional.',
 'CRFB, art. 5º, XXXVII c/c art. 92, VI — Apostila JME, pág. 3',
 'medio'),

-- Q05: Evolução do nome do órgão de cúpula
(@cat_jme01,
 'Sobre a evolução terminológica do tribunal de cúpula militar federal, a ordem cronológica correta das denominações é:',
 'Conselho Supremo Militar e de Justiça (1808); Superior Tribunal Militar (1934); Supremo Tribunal Militar (1946).',
 'Superior Tribunal Militar (1808); Supremo Tribunal Militar (1934); Conselho Supremo (1946).',
 'Conselho Supremo Militar e de Justiça (1808); Supremo Tribunal Militar (1934); Superior Tribunal Militar (1946).',
 'Supremo Tribunal Militar (1808); Superior Tribunal Militar (1934); Conselho de Justiça (1946).',
 'Tribunal de Guerra (1808); Conselho Supremo (1934); Superior Tribunal Militar (1988).',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C está correta. Criado como Conselho Supremo (1808), mudou para Supremo Tribunal na CF/34 e para Superior Tribunal na CF/46. As demais alternativas invertem ou inventam nomes e datas não condizentes com o texto.\n\n📜 Fundamento legal vigente: a denominação atual, Superior Tribunal Militar — STM, permanece em vigor desde a CF/1946 e foi recepcionada pela CRFB/1988 (art. 122, I), sem alteração de nome desde então.',
 'CRFB, art. 122, I — Apostila JME, pág. 2',
 'facil'),

-- Q06: EC 45/2004 e competência cível
(@cat_jme01,
 'A Emenda Constitucional nº 45/2004 alterou profundamente a fisionomia da Justiça Militar Estadual (JME). Segundo Lobão (2010), uma das principais inovações foi:',
 'A transferência da competência para julgar civis para a Justiça Militar da União.',
 'A inclusão da jurisdição sobre ações judiciais contra atos disciplinares militares, conferindo-lhe competência civil.',
 'A vedação absoluta de julgamentos de crimes militares cometidos fora de quartéis.',
 'A extinção do Tribunal de Justiça Militar em todos os estados da federação.',
 'A criação de Conselhos de Justiça compostos exclusivamente por juízes togados.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B é correta. A EC 45/2004 ampliou a competência da JME para incluir o controle judicial de atos disciplinares. A está incorreta pois o julgamento de civis na JMF já existia; C está incorreta pois a JME julga crimes militares em qualquer lugar; D está incorreta pois os TJMs foram mantidos onde já existiam (SP, RS, MG); E está incorreta pois o sistema de Escabinato (misto) foi preservado.\n\n📜 Fundamento legal vigente: art. 125, §4º, da CRFB, com redação dada pela EC nº 45/2004: "Compete à Justiça Militar estadual processar e julgar os militares dos Estados, nos crimes militares definidos em lei e as ações judiciais contra atos disciplinares militares, ressalvada a competência do júri quando a vítima for civil (...)". A competência cível sobre atos disciplinares é textual e literal a partir dessa redação.',
 'CRFB, art. 125, §4º (EC 45/2004) — Apostila JME, pág. 4',
 'medio'),

-- Q07: Súmula 53/STJ — civis na Justiça Comum
(@cat_jme01,
 'Considere a competência ratione personae e a Súmula nº 53 do STJ. É correto afirmar que:',
 'A JME pode julgar civis desde que o crime ocorra dentro de administração militar.',
 'A JMF possui competência para julgar civis, enquanto na JME somente militares estaduais são processados.',
 'Militares das Forças Armadas que cometam crimes contra instituições estaduais são julgados pela JME.',
 'A Justiça Comum Federal é a responsável por julgar civis que agridam Policiais Militares em serviço.',
 'Civis e militares são julgados pelo mesmo Conselho de Justiça na esfera estadual.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto destaca que a JMF julga civis, mas na JME, civis são julgados na Justiça Comum Estadual (Súmula 53 STJ). A e E estão incorretas pela vedação de julgamento de civis na JME; C está incorreta pois militares federais contra instituições estaduais também vão para a Justiça Comum; D está incorreta pois a Súmula 53 cita a Justiça Comum Estadual, não a Federal.\n\n📜 Fundamento legal vigente: Súmula 53/STJ (24/09/1992): "Compete à Justiça Comum Estadual processar e julgar civil acusado de prática de crime contra instituições militares estaduais." Combinada com o art. 125, §4º, CRFB, que restringe a competência penal da JME aos "militares dos Estados".',
 'Súmula 53/STJ; CRFB, art. 125, §4º — Apostila JME, págs. 4-5',
 'medio'),

-- Q08: Caso hipotético — Sargento mata civil dolosamente
(@cat_jme01,
 '(Caso Hipotético) Um Sargento da Polícia Militar, em serviço e utilizando arma da corporação, mata dolosamente um civil durante uma abordagem. De acordo com o Art. 125, § 4º da CRFB:',
 'O Sargento será julgado pelo Conselho Permanente de Justiça, por ser militar em serviço.',
 'A competência será da Justiça Militar da União, por tratar-se de crime doloso contra a vida.',
 'O crime será julgado pelo Tribunal do Júri (Justiça Comum), devido à ressalva constitucional quando a vítima for civil.',
 'O processo tramitará na JME, cabendo ao Tribunal de Justiça Militar decidir sobre a perda da graduação.',
 'A competência será do Juiz de Direito do Juízo Militar de forma singular.',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C está correta. O §4º do art. 125 ressalva a competência do júri nos crimes dolosos contra a vida de civis. A, D e E estão incorretas pois a JME perde a competência penal para o Tribunal do Júri neste caso específico; B está incorreta pois a JMF só teria competência em contextos específicos do §2º do art. 9º do CPM (militar federal das Forças Armadas).\n\n📜 Fundamento legal vigente: art. 125, §4º, CRFB, parte final: "(...) ressalvada a competência do júri quando a vítima for civil (...)". A investigação corre pela polícia judiciária militar/comum, mas o processo e julgamento do mérito vão a júri popular na Justiça Comum, desde a redação dada pela EC 45/2004 — regra distinta da aplicável a militares federais das Forças Armadas (art. 9º, §2º, CPM, incluído pela Lei 13.491/2017), que preserva a competência da Justiça Militar da União em hipóteses específicas de missão institucional.',
 'CRFB, art. 125, §4º — Apostila JME, pág. 4',
 'dificil'),

-- Q09: Caso hipotético — Súmula 78/STJ
(@cat_jme01,
 '(Caso Hipotético) Um Capitão da Polícia Militar da Paraíba, em gozo de férias no Rio de Janeiro, comete um crime militar previsto no CPM contra o patrimônio da PMERJ. Segundo a Súmula nº 78 do STJ:',
 'A competência é da JME do Rio de Janeiro, local da consumação do delito.',
 'A competência é da JME da Paraíba, estado da corporação a que pertence o oficial.',
 'O caso deve ser julgado pela Justiça Militar da União por envolver dois estados.',
 'O Oficial deve ser julgado pela Justiça Comum do Rio de Janeiro, por estar de férias.',
 'Trata-se de crime comum, pois o oficial não estava em serviço no seu estado de origem.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. A Súmula 78/STJ determina que a competência é do lugar da Corporação do agente, mesmo que o delito ocorra em outra unidade federativa. As alternativas A, C, D e E contrariam o enunciado da súmula citada.\n\n📜 Fundamento legal vigente: Súmula 78/STJ (16/06/1993): "Compete à Justiça Militar processar e julgar policial de corporação estadual, ainda que o delito tenha sido praticado em outra unidade federativa." O critério é institucional (corporação a que pertence o agente), e não territorial (local do fato) nem relativo ao estar ou não em serviço.',
 'Súmula 78/STJ — Apostila JME, pág. 4',
 'dificil'),

-- Q10: Competência civil pós EC 45/2004 — só na JME
(@cat_jme01,
 'Sobre a competência civil (administrativo-disciplinar) da Justiça Militar após a EC 45/2004, assinale a alternativa tecnicamente correta:',
 'A competência foi estendida aos juízes federais da Justiça Militar da União.',
 'Diferente da esfera Estadual, na Justiça Militar Federal não há competência para ações contra atos disciplinares das Forças Armadas.',
 'Tais ações devem ser julgadas pelo Conselho de Justiça, sob presidência de juiz togado.',
 'A JME só pode anular punições de oficiais, sendo as praças julgadas na Justiça Comum.',
 'A competência civil abrange apenas a reintegração de militares demitidos.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta conforme Neves (2020). A competência civil não foi prevista para a JMF. A está incorreta por contradizer Neves; C está incorreta pois o art. 125, §5º atribui ao Juiz de Direito o julgamento singular dessas ações; D e E estão incorretas pois a competência abrange ações contra atos disciplinares em geral para todos os militares estaduais.\n\n📜 Fundamento legal vigente: o art. 125, §4º e §5º, CRFB, deu à JME competência sobre "ações judiciais contra atos disciplinares militares". Não há dispositivo equivalente no art. 122 (JM da União), que trata apenas de competência penal — daí a assimetria entre as duas justiças militares apontada pela doutrina.',
 'CRFB, art. 125, §§4º e 5º — Apostila JME, págs. 4-5',
 'medio'),

-- Q11: Art. 125 §5º — juiz singular
(@cat_jme01,
 'Compete aos Juízes de Direito do Juízo Militar, de forma singular (Art. 125, § 5º, CRFB):',
 'Processar e julgar oficiais em crimes militares definidos em lei.',
 'Processar e julgar praças em crimes de deserção e abandono de posto.',
 'Processar e julgar crimes militares cometidos contra civis e as ações judiciais contra atos disciplinares militares.',
 'Julgar crimes dolosos contra a vida quando o réu for oficial superior.',
 'Decidir sobre a perda do posto e da patente dos oficiais.',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C reflete o texto constitucional do §5º do art. 125. A e B estão incorretas pois o julgamento de oficiais e praças nos "demais crimes" cabe ao Conselho; D está incorreta (competência do Júri); E está incorreta pois cabe ao tribunal competente (2ª instância) decidir sobre perda de posto/patente.\n\n📜 Fundamento legal vigente: art. 125, §5º, CRFB (redação EC 45/2004): "Compete aos juízes de direito do juízo militar processar e julgar, singularmente, os crimes militares cometidos contra civis e as ações judiciais contra atos disciplinares militares, cabendo ao Conselho de Justiça, sob a presidência de juiz de direito, processar e julgar os demais crimes militares." Texto literal, sem margem para outra interpretação.',
 'CRFB, art. 125, §5º — Apostila JME, pág. 4',
 'medio'),

-- Q12: Critério ratione legis
(@cat_jme01,
 'O critério utilizado pelo legislador brasileiro para a definição de crime militar, segundo Ivo D''Aquino e Jorge Cesar de Assis, é:',
 'Ratione loci (pelo lugar do crime).',
 'Ratione personae (pela qualidade do agente).',
 'Ratione legis (é crime o que a lei considera como tal).',
 'Ratione materiae (pelo bem jurídico protegido).',
 'Ratione temporis (pelo momento da prática).',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C está correta. D''Aquino ensina que o legislador "não define: enumera", adotando o critério ratione legis. As demais alternativas citam critérios que, embora contidos no art. 9º, não são o critério mestre de definição adotado pela doutrina citada.\n\n📜 Fundamento legal vigente: o CPM (Decreto-Lei 1.001/1969), art. 9º, não traz um conceito fechado de crime militar — apenas enumera hipóteses taxativas (incisos I a III). É essa técnica legislativa de enumeração casuística, sem definição conceitual abstrata, que caracteriza o critério ratione legis.',
 'CPM, art. 9º — Apostila JME, pág. 5',
 'medio'),

-- Q13: Tripartição pós Lei 13.491/2017
(@cat_jme01,
 'Com a Lei nº 13.491/2017, a classificação dos crimes militares tornou-se tripartida na visão de Roth e Assis. As categorias são:',
 'Crimes militares de guerra, de paz e disciplinares.',
 'Crimes propriamente militares, impropriamente militares e crimes militares por extensão.',
 'Crimes de quartel, crimes de serviço e crimes de folga.',
 'Crimes do CPM, crimes do CP Comum e crimes da Lei de Abuso de Autoridade.',
 'Crimes federais, estaduais e distritais.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. A doutrina moderna (Roth, Assis) incluiu os "por extensão" às categorias clássicas. As demais alternativas utilizam nomenclaturas não técnicas ou divisões estranhas ao texto base.\n\n📜 Fundamento legal vigente: a categoria "por extensão" surgiu com a nova redação do art. 9º, II, do CPM dada pela Lei nº 13.491/2017, que passou a considerar militares crimes previstos exclusivamente na legislação penal comum (fora do CPM), desde que praticados nas condições do inciso II — antes da lei, tais crimes eram sempre da Justiça Comum.',
 'CPM, art. 9º, II (redação da Lei 13.491/2017) — Apostila JME, págs. 6 e 8',
 'medio'),

-- Q14: Caso hipotético — Tortura como crime por extensão
(@cat_jme01,
 '(Caso Hipotético) Um Tenente da PM, em serviço, comete o crime de Tortura (Lei nº 9.455/97) contra um detido. Antes da Lei 13.491/2017, esse crime era comum. Atualmente, ele é classificado como:',
 'Crime propriamente militar, por ser praticado por oficial em serviço.',
 'Crime militar por extensão, pois está previsto apenas na legislação comum, mas atende aos requisitos do art. 9º, II, do CPM.',
 'Crime impropriamente militar, pois possui previsão idêntica no CPM.',
 'Crime de abuso de autoridade qualificado, julgado pela Justiça Comum.',
 'Crime administrativo-disciplinar, sujeito apenas à demissão.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. Crimes previstos exclusivamente na legislação comum (como tortura) praticados nas condições do art. 9º, II, tornaram-se militares por extensão. A e C estão incorretas pois a tortura não está no CPM; D está incorreta pois a competência agora é militar; E está incorreta pela natureza penal do ato.\n\n📜 Fundamento legal vigente: Lei nº 9.455/1997 (crime de tortura, sem tipo correspondente no CPM) c/c CPM, art. 9º, II, "b" (redação da Lei 13.491/2017): crime praticado por militar da ativa, em local sujeito à administração militar, contra civil (o detido sob custódia). Combinação que caracteriza o crime militar por extensão, deslocando a competência para a JME.',
 'Lei 9.455/97 c/c CPM, art. 9º, II, "b" — Apostila JME, pág. 8',
 'dificil'),

-- Q15: Crimes propriamente militares — art. 9º, I
(@cat_jme01,
 'Conforme o art. 9º, inciso I, do CPM, consideram-se crimes propriamente militares:',
 'Aqueles previstos no CPM e na lei penal comum com penas idênticas, como o roubo.',
 'Aqueles previstos exclusivamente no CPM, como motim, deserção e abandono de posto.',
 'Crimes praticados por civis contra a administração militar estadual.',
 'Crimes dolosos contra a vida de civil praticados em serviço.',
 'Quaisquer crimes previstos no Código Penal Comum cometidos por militares da ativa.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto define crimes propriamente militares como os previstos exclusivamente no CPM. A define impropriamente militares; C está incorreto (civis não cometem crime militar estadual); D está incorreto (competência do júri); E define crimes por extensão.\n\n📜 Fundamento legal vigente: CPM, art. 9º, I: "os crimes de que trata este Código, quando definidos de modo diverso na lei penal comum, ou nela não previstos, qualquer que seja o agente, salvo disposição especial." São os tipos exclusivos do CPM, sem correspondente na lei comum (motim, art. 149 CPM; deserção, art. 187 CPM; abandono de posto, art. 195 CPM).',
 'CPM, art. 9º, I — Apostila JME, pág. 8',
 'medio'),

-- Q16: "Cochilo do legislador"
(@cat_jme01,
 'O conceito de "cochilo do legislador", abordado por Ronaldo Roth (2020), refere-se:',
 'À desatenção dos sentinelas que dormem em serviço (Art. 203 CPM).',
 'Ao longo período em que o CPM e o CPPM ficaram sem modernização penal, ficando "a reboque" da legislação comum.',
 'Ao erro técnico na redação da Emenda Constitucional nº 45.',
 'À demora dos Tribunais de Justiça em propor a criação de novos TJMs.',
 'À falta de previsão de crimes cibernéticos no Código Penal Comum.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. Roth utiliza o termo para descrever as décadas de esquecimento e falta de atualização do Direito Penal Castrense. As demais alternativas são distratores que utilizam termos do texto fora de contexto.\n\n📜 Fundamento legal vigente: o CPM (Decreto-Lei nº 1.001) e o CPPM (Decreto-Lei nº 1.002), ambos de 21/10/1969, permaneceram praticamente sem atualização estrutural relevante quanto ao rol de crimes militares até a edição da Lei nº 13.491/2017, quase 48 anos depois — período que a doutrina rotula de "cochilo do legislador".',
 'CPM (DL 1.001/69) e CPPM (DL 1.002/69) — Apostila JME, pág. 8',
 'medio'),

-- Q17: Caso hipotético — art. 9º, II, "a"
(@cat_jme01,
 '(Caso Hipotético) Um Soldado PM fora de serviço, ao ser abordado por uma guarnição da mesma corporação, identifica-se e, em seguida, desrespeita o Sargento comandante da guarnição. Nos termos do Art. 9º, II, alínea "a" do CPM:',
 'O crime é comum, pois o Soldado estava de folga.',
 'Trata-se de crime militar, pois é praticado por militar da ativa contra militar na mesma situação.',
 'A competência é da Justiça Comum, pois não houve uso de arma de fogo.',
 'O Soldado deve ser julgado singularmente pelo Juiz de Direito.',
 'O crime é militar por extensão, previsto na lei de abuso de autoridade.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O art. 9º, II, "a", considera militar o crime de ativa contra ativa, independentemente de estar em serviço. A e C ignoram o requisito ratione personae; D está incorreta (julgamento pelo Conselho); E está incorreta pois o desacato/desrespeito está previsto no CPM (impropriamente militar).\n\n📜 Fundamento legal vigente: CPM, art. 9º, II, "a": crime praticado "por militar em situação de atividade (...) contra militar na mesma situação". A condição de "estar em serviço" não é elemento exigido por essa alínea — basta que ambos sejam militares da ativa. O tipo penal aplicável é o desacato a superior (art. 298, CPM) ou desrespeito (art. 160, CPM), a depender da conduta.',
 'CPM, art. 9º, II, "a" — Apostila JME, pág. 6',
 'medio'),

-- Q18: Dupla tipicidade
(@cat_jme01,
 'Para a tipificação de um crime militar, a doutrina exige a cumulação de duas formas de tipicidade. São elas:',
 'Tipicidade formal e tipicidade material.',
 'Tipicidade direta (previsão no CPM ou lei penal) e tipicidade indireta (enquadramento nos arts. 9º ou 10 do CPM).',
 'Tipicidade subjetiva e tipicidade objetiva.',
 'Tipicidade castrense e tipicidade administrativa.',
 'Tipicidade imediata e tipicidade reflexa.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. Para ser militar, o fato deve estar na lei (direta) e em uma das hipóteses de competência dos arts. 9º ou 10 (indireta). As demais alternativas citam conceitos de teoria geral do crime não destacados como foco pelo texto base para definição de crime militar.\n\n📜 Fundamento legal vigente: CPM, arts. 9º (crimes militares em tempo de paz) e 10 (crimes militares em tempo de guerra) — são os dispositivos que operam a tipicidade indireta, enquadrando o fato (já tipificado em algum diploma penal) como crime militar em razão das circunstâncias e sujeitos envolvidos.',
 'CPM, arts. 9º e 10 — Apostila JME, págs. 5 e 9',
 'dificil'),

-- Q19: TJMs próprios — SP, RS, MG
(@cat_jme01,
 'Atualmente, a segunda instância da Justiça Militar Estadual é exercida por Tribunais de Justiça Militares (TJMs) próprios em quais estados?',
 'São Paulo, Rio de Janeiro e Minas Gerais.',
 'São Paulo, Rio Grande do Sul e Minas Gerais.',
 'Minas Gerais, Bahia e Pernambuco.',
 'São Paulo, Paraná e Ceará.',
 'Em todas as Unidades Federativas com mais de 20 mil militares.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto cita nominalmente apenas SP, RS e MG. A, C e D incluem estados que, apesar de possuírem efetivo para tal, não criaram o TJM. E está incorreta pois a criação depende de iniciativa do TJ local, não sendo automática.\n\n📜 Fundamento legal vigente: art. 125, §3º, CRFB, autoriza (não obriga) a criação de TJM nos estados com efetivo militar superior a 20 mil integrantes, mediante proposta do Tribunal de Justiça. Até o momento, apenas São Paulo, Rio Grande do Sul e Minas Gerais exerceram essa faculdade e mantêm TJM próprio em funcionamento.',
 'CRFB, art. 125, §3º — Apostila JME, pág. 11',
 'medio'),

-- Q20: Requisitos do art. 125 §3
(@cat_jme01,
 'De acordo com o Art. 125, § 3º da CRFB, a criação de um TJM estadual depende de:',
 'Efetivo superior a 10 mil integrantes e autorização do STM.',
 'Efetivo superior a 20 mil integrantes e proposta do Tribunal de Justiça local.',
 'Efetivo superior a 30 mil integrantes e decreto do Governador do Estado.',
 'Iniciativa exclusiva da Assembleia Legislativa após plebiscito na corporação.',
 'Proposta do Comandante-Geral e homologação pelo Conselho Nacional de Justiça.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. Os requisitos constitucionais são o efetivo (>20 mil) e a iniciativa do TJ. As demais alternativas alteram o número de integrantes ou a autoridade proponente de forma divergente da CRFB.\n\n📜 Fundamento legal vigente: art. 125, §3º, CRFB, texto literal: "(...) ou por Tribunal de Justiça Militar nos Estados em que o efetivo militar seja superior a vinte mil integrantes", sempre "mediante proposta do Tribunal de Justiça" — os dois requisitos (efetivo e iniciativa do TJ) são cumulativos.',
 'CRFB, art. 125, §3º — Apostila JME, págs. 4 e 11',
 'medio'),

-- Q21: 2a instância onde não há TJM
(@cat_jme01,
 'Nos estados que não possuem Tribunal de Justiça Militar próprio (ex: Paraíba, Rio de Janeiro), a segunda instância da JME é exercida por:',
 'Superior Tribunal Militar (STM).',
 'Conselho Especial de Justiça do respectivo estado.',
 'Tribunal de Justiça (TJ) comum do respectivo estado.',
 'Tribunal Regional Federal (TRF) da região.',
 'Turma Recursal Militar vinculada ao Governador.',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C está correta. Onde não há TJM, o TJ estadual comum atua como segunda instância. A está incorreta pois o STM só atua na esfera federal; B é órgão de 1ª instância; D atua na Justiça Federal; E é órgão inexistente no sistema brasileiro.\n\n📜 Fundamento legal vigente: art. 125, §3º, CRFB, parte inicial: em segundo grau, a JME é exercida "pelo próprio Tribunal de Justiça" — regra geral aplicável a todos os estados que não tenham criado TJM próprio, caso de Roraima.',
 'CRFB, art. 125, §3º — Apostila JME, pág. 11',
 'medio'),

-- Q22: Presença em todas as 27 UFs
(@cat_jme01,
 'Sobre a presença da Justiça Militar Estadual no território nacional, é correto afirmar:',
 'Está presente apenas nos estados das regiões Sul e Sudeste.',
 'Está presente em todas as 27 Unidades Federativas do Brasil.',
 'Existe apenas onde o efetivo militar ultrapassa 20 mil homens.',
 'É inexistente no Distrito Federal, que utiliza a Justiça Militar da União.',
 'Sua estrutura de primeiro grau é composta apenas por civis nos estados do Norte.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto afirma textualmente que a JME está presente em todas as 27 UFs. As alternativas A, C, D e E apresentam restrições geográficas ou organizacionais que o texto desmente.\n\n📜 Fundamento legal vigente: o art. 125, §§3º e 5º, CRFB, não condiciona a existência da estrutura de 1ª instância (Juiz de Direito do Juízo Militar + Conselhos de Justiça) ao efetivo militar — essa condição (>20 mil) vale apenas para a criação de TJM próprio em 2ª instância. Por isso, mesmo estados com efetivo reduzido mantêm JME de 1º grau plenamente estruturada.',
 'CRFB, art. 125, §§3º e 5º — Apostila JME, pág. 10',
 'medio'),

-- Q23: Instâncias recursais — STJ e STF
(@cat_jme01,
 'As decisões de última instância da Justiça Militar Estadual, após esgotados os recursos no TJM ou no TJ, podem ser revistas pelo:',
 'Superior Tribunal Militar (STM).',
 'Superior Tribunal de Justiça (STJ) e Supremo Tribunal Federal (STF).',
 'Apenas pelo Supremo Tribunal Federal em casos de crime de guerra.',
 'Conselho Nacional de Justiça, em sede de recurso ordinário.',
 'Ministério Público Militar da União.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto aponta o STJ e o STF como instâncias superiores da JME. A está incorreta (STM não revisa decisões estaduais); C, D e E citam órgãos sem competência recursal jurisdicional sobre o mérito das causas militares estaduais.\n\n📜 Fundamento legal vigente: art. 105, III, CRFB (recurso especial ao STJ) e art. 102, III, CRFB (recurso extraordinário ao STF). O STM (art. 122, I, CRFB) tem competência restrita à Justiça Militar da União, não alcançando decisões de TJ/TJM estaduais.',
 'CRFB, arts. 102, III e 105, III — Apostila JME, pág. 11',
 'medio'),

-- Q24: Roraima — CE/RR art. 83
(@cat_jme01,
 'O exemplo do Estado de Roraima (Art. 83 da Constituição Estadual) citado no texto demonstra que:',
 'O Juiz Auditor militar possui menos garantias que o juiz comum.',
 'A 1ª instância é composta por Conselhos e Juízes, e a 2ª instância pelo Tribunal de Justiça.',
 'É proibida a criação de TJM naquele estado por ser região de fronteira.',
 'O Conselho de Justiça de Roraima é o único do país que julga civis.',
 'A JME de Roraima é subordinada administrativamente ao TJ de Minas Gerais.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto transcreve a norma roraimense que confirma essa estrutura. A está incorreta (mesmas garantias); C, D e E são afirmações sem qualquer amparo no texto base.\n\n📜 Fundamento legal vigente: Constituição do Estado de Roraima, art. 83: a Justiça Militar estadual, organizada na forma da lei de organização judiciária, tem como órgão de 1ª instância os Conselhos de Justiça e os Juízes de Direito do Juízo Militar (Juízes Auditores), com as mesmas garantias, prerrogativas, vencimentos e impedimentos dos demais magistrados estaduais de 1ª instância; a 2ª instância, à falta de TJM próprio (efetivo de RR inferior a 20 mil), é exercida pelo TJRR (art. 125, §3º, CRFB).',
 'Constituição do Estado de Roraima, art. 83; CRFB, art. 125, §3º — Apostila JME, pág. 11',
 'medio'),

-- Q25: Escabinato
(@cat_jme01,
 'O sistema de "Escabinato", pilar da Justiça Militar, caracteriza-se pela:',
 'Presidência obrigatória de um Oficial Superior e ausência de juízes togados.',
 'Composição mista que une conhecimentos técnicos da magistratura (Juiz de Direito) às experiências do universo militar (Juízes Militares).',
 'Seleção de jurados civis para julgamento de crimes contra a administração militar.',
 'Nomeação vitalícia de oficiais para o cargo de juiz militar.',
 'Eleição dos membros do Conselho de Justiça pelos seus pares na corporação.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O Escabinato é a forma de composição que une o magistrado togado aos oficiais sorteados. A está incorreta (há juiz togado); C define o Júri Comum; D está incorreta (são temporários); E está incorreta (o processo é por sorteio).\n\n📜 Fundamento legal vigente: o sistema de escabinato decorre diretamente do art. 125, §5º, CRFB, que atribui o julgamento colegiado ao "Conselho de Justiça, sob a presidência de juiz de direito" — presidido pelo togado, mas integrado também por juízes militares (oficiais), caracterizando a composição mista.',
 'CRFB, art. 125, §5º — Apostila JME, pág. 1',
 'medio'),

-- Q26: Caso hipotético — concurso de agentes Major + Cabo
(@cat_jme01,
 '(Caso Hipotético) Um Major PM e um Cabo PM são acusados em concurso de agentes pelo crime de peculato. De acordo com as regras de competência e organização:',
 'O Major será julgado pelo Conselho Especial e o Cabo pelo Conselho Permanente.',
 'Ambos serão julgados pelo Conselho Especial de Justiça (CEJ).',
 'Ambos serão julgados singularmente pelo Juiz de Direito, por ser crime contra a administração.',
 'O caso será cindido, indo o Major para o TJM e o Cabo para a Vara Militar.',
 'O Conselho Permanente de Justiça julgará ambos, prevalecendo a maioria numérica das praças.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O CEJ julga oficiais ou "praças em concurso com oficiais". A, D e E ignoram a regra de atração do CEJ no concurso de agentes; C está incorreta pois o peculato contra a administração militar é julgado pelo Conselho, não singularmente.\n\n📜 Fundamento legal vigente: por simetria com a Lei 8.457/92 (Lei de Organização Judiciária Militar da União, arts. 27 e 28) e o CPPM (arts. 400 a 403): o Conselho Especial de Justiça, formado para o processo de oficiais, atrai o julgamento de praças coautoras no mesmo feito, evitando a cisão processual e decisões contraditórias sobre o mesmo fato.',
 'Lei 8.457/92, arts. 27-28 (por simetria); CPPM, arts. 400-403 — Apostila JME, pág. 14',
 'dificil'),

-- Q27: CPJ trimestral x CEJ ad hoc
(@cat_jme01,
 'Sobre a temporalidade e funcionamento dos Conselhos, assinale a alternativa tecnicamente correta:',
 'O Conselho Permanente de Justiça (CPJ) é ad hoc, sendo criado para cada processo.',
 'O Conselho Especial de Justiça (CEJ) é trimestral, julgando todos os oficiais do período.',
 'O CPJ tem seus juízes renovados a cada trimestre (permanente), enquanto o CEJ é constituído para cada processo e dissolvido após o julgamento (ad hoc).',
 'Ambos os Conselhos são renovados mensalmente para garantir a imparcialidade.',
 'O CPJ nunca é renovado, permanecendo os mesmos juízes por toda a carreira.',
 'C',
 'Justificativa doutrinária (apostila): a alternativa C está correta. O CPJ atua por trimestres, enquanto o CEJ é formado para o caso específico. As alternativas A, B, D e E invertem ou distorcem os conceitos de periodicidade e natureza dos conselhos.\n\n📜 Fundamento legal vigente: por simetria com a Lei 8.457/92 (organização dos Conselhos de Justiça): o CPJ julga praças, com composição de juízes militares sorteada e renovada a cada trimestre, mantendo existência contínua (daí "permanente"); o CEJ julga oficiais, é constituído especificamente para cada processo (ad hoc) e se extingue com o trânsito em julgado do caso.',
 'Lei 8.457/92 (por simetria); CPPM, arts. 400-403 — Apostila JME, págs. 13-14',
 'medio'),

-- Q28: Composição numérica dos Conselhos
(@cat_jme01,
 'A composição numérica padrão dos Conselhos de Justiça na JME, respeitando o princípio hierárquico, é:',
 '1 Juiz de Direito e 2 Oficiais Superiores.',
 '1 Juiz de Direito e 4 Juízes Militares (Oficiais).',
 '3 Juízes de Direito e 2 Oficiais Intermediários.',
 '5 Oficiais de postos variados, sem presença de juiz togado.',
 '1 Juiz de Direito e 4 Praças da reserva.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O Conselho é composto pelo Juiz de Direito e mais quatro oficiais. As alternativas A, C, D e E apresentam quantitativos ou categorias de juízes não previstos na lei ou no texto.\n\n📜 Fundamento legal vigente: por simetria com a Lei 8.457/92, arts. 22 e 27, e o CPPM, arts. 400-403: tanto o CPJ quanto o CEJ são compostos por 1 (um) Juiz de Direito (togado) e 4 (quatro) Juízes Militares (oficiais sorteados dentre a corporação), respeitada a precedência hierárquica entre os oficiais sorteados.',
 'Lei 8.457/92, arts. 22 e 27 (por simetria) — Apostila JME, págs. 13-14',
 'medio'),

-- Q29: Identidade física do juiz
(@cat_jme01,
 'Em relação ao Princípio da Identidade Física do Juiz, o texto apresenta dois entendimentos conflitantes. Assinale a alternativa que sintetiza corretamente essa discussão:',
 'O STM e Rodrigo Foureaux concordam que o princípio deve ser aplicado integralmente aos Conselhos de Justiça.',
 'O STM entende que o princípio não se aplica à Justiça Militar pela sua especialidade; já Foureaux pondera que a rotatividade do CPJ pode ferir o direito de defesa e o contato do juiz com a prova.',
 'O STF já decidiu que apenas o Juiz de Direito está vinculado à instrução, sendo os juízes militares livres para serem trocados.',
 'O princípio aplica-se ao CEJ, mas é expressamente vedado no CPJ por lei complementar.',
 'A identidade física do juiz só existe na Justiça Militar em tempos de guerra.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O texto cita o HC do STM negando a aplicação e a crítica de Foureaux sobre o prejuízo à autodefesa no CPJ. A, C, D e E simplificam ou distorcem o debate técnico-jurídico apresentado.\n\n📜 Fundamento legal vigente: não há dispositivo legal expresso que resolva a controvérsia — trata-se de construção jurisprudencial (precedentes do STM) em tensão com a crítica doutrinária (Foureaux), o que caracteriza uma lacuna normativa sobre o tema, sem posição pacificada em lei ou em súmula vinculante do STF.',
 'Jurisprudência do STM; doutrina (Foureaux) — Apostila JME, pág. 14',
 'dificil'),

-- Q30: Compromisso e dispensa de serviço do oficial-juiz
(@cat_jme01,
 'Sobre o estatuto e os deveres do Oficial que atua como Juiz Militar, é correto afirmar:',
 'Recebe gratificação de 20% sobre o soldo durante o período de atuação no Conselho.',
 'Deve prestar compromisso legal de julgar de acordo com a lei e a prova dos autos, ficando dispensado do serviço na organização militar nos dias de sessão.',
 'Passa a gozar de vitaliciedade no cargo de magistrado após dois anos de atuação no CEJ.',
 'Pode ser substituído livremente pelo Comandante-Geral caso discorde da orientação da corporação.',
 'É subordinado administrativamente ao Juiz de Direito no que tange a punições disciplinares militares.',
 'B',
 'Justificativa doutrinária (apostila): a alternativa B está correta. O compromisso e a dispensa de serviço são regras expressas. A está incorreta (não há remuneração complementar); C está incorreta (continuam no Executivo); D está incorreta (viola o juiz natural); E está incorreta pois permanecem vinculados ao Executivo.\n\n📜 Fundamento legal vigente: CPPM, art. 400 (compromisso do juiz militar de julgar segundo a lei e a prova dos autos, prestado na instalação do Conselho) c/c Lei 8.457/92, art. 26, aplicado por simetria (dispensa do serviço na organização militar de origem nos dias de sessão do Conselho). O oficial-juiz permanece vinculado hierarquicamente ao Poder Executivo (sua corporação) para todos os demais efeitos administrativos e disciplinares, não ao Juiz de Direito.',
 'CPPM, art. 400; Lei 8.457/92, art. 26 (por simetria) — Apostila JME, págs. 14-15',
 'medio');

SET foreign_key_checks = 1;
