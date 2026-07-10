-- ============================================================
-- QUIZ — Disciplina 18/20 do CHO: Sindicancia Disciplinar Militar (SDM)
-- 30 questoes — enunciados no padrao guia_elaboracao_questoes.md (cenario concreto,
--   sem citar artigo no enunciado, distratores plausiveis, dupla justificativa).
-- Base verificada (ver secao 24 de base_conhecimento_legislacao.md):
--   CPPM (Decreto-Lei 1.002/1969), arts. 348 (testemunha civil) e 349 (militar/servidor);
--   Sumula Vinculante n. 5/STF (falta de defesa tecnica por advogado no PAD nao ofende a CF);
--   STF, PET 7612 (natureza inquisitorial do inquerito); regulamentacao interna por portaria.
--   Distincao Conselho de Justificacao (oficiais) x Conselho de Disciplina (Aspirante-a-Oficial
--   e pracas estaveis) — casa com a secao 1 desta base (Estatuto).
-- ============================================================
SET NAMES utf8mb4;

INSERT INTO categorias (nome, descricao)
SELECT 'Sindicância Disciplinar Militar (SDM) — CHO 18', 'Disciplina 18/20 do CHO — Sindicância Disciplinar Militar: natureza, ampla defesa, conversões (PAD, Conselho de Disciplina, Conselho de Justificação, IPM), rito e prazos'
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categorias WHERE nome = 'Sindicância Disciplinar Militar (SDM) — CHO 18');

SET @cat_sdm18 = (SELECT id FROM categorias WHERE nome = 'Sindicância Disciplinar Militar (SDM) — CHO 18' ORDER BY id LIMIT 1);

-- Aposenta questoes ja carregadas desta categoria (idempotente em recarga; FK RESTRICT).
UPDATE questoes SET ativa = 0 WHERE categoria_id = @cat_sdm18;

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: conceito e finalidade da SDM
(@cat_sdm18,
 'O comandante recebe a notícia de uma ocorrência de elevada complexidade, com forte potencial transgressional, que não configura, à primeira vista, crime militar. Para apurar o grau de responsabilidade disciplinar, o instrumento adequado é:',
 'O Inquérito Policial Militar, obrigatoriamente.',
 'A Sindicância Disciplinar Militar, voltada a apurar a responsabilidade disciplinar em ocorrências de maior complexidade.',
 'O Auto de Prisão em Flagrante, para custódia imediata.',
 'O Conselho de Justificação, de forma originária.',
 'A simples averiguação verbal, encerrada no mesmo dia.',
 'B',
 'A alternativa B está correta: a Sindicância Disciplinar Militar (SDM) é o instrumento investigativo destinado a apurar a responsabilidade disciplinar em ocorrências de maior complexidade e potencial transgressional, sem ingressar, de imediato, na esfera penal. A alternativa A pressupõe crime militar, ausente no enunciado. A alternativa C confunde apuração com prisão. A alternativa D salta uma etapa (o Conselho de Justificação é desfecho para oficiais, não instrumento de apuração inicial). A alternativa E subdimensiona a complexidade descrita.\n\n📜 Fundamento legal vigente: a SDM é procedimento disciplinar regulamentado por norma interna da corporação (portaria), com observância obrigatória do contraditório e da ampla defesa (CF/88, art. 5º, LV).',
 'CF/88, art. 5º, LV; regulamentação interna da SDM',
 'facil'),

-- Q02: SDM nao afasta das funcoes
(@cat_sdm18,
 'Um Sargento passa a ser submetido a uma Sindicância Disciplinar Militar. Ele questiona se, por esse fato, será automaticamente afastado de suas funções. A resposta correta é:',
 'Sim, o afastamento é automático até o relatório final.',
 'Não, a submissão à SDM, por si só, não implica o afastamento do militar de suas funções.',
 'Sim, se a portaria previr sanção superior a 20 dias de prisão.',
 'Sim, mas apenas se recomendado pelo Conselho de Disciplina.',
 'Não, mas ele deve ser colocado em disponibilidade remunerada.',
 'B',
 'A alternativa B está correta: a submissão à SDM, por si só, não implica afastamento das funções, preservando-se a presunção de inocência e a continuidade do serviço até a efetiva apuração. As alternativas A, C e D tratam o afastamento como consequência automática ou condicionada, o que não corresponde à natureza da SDM. A alternativa E cria uma "disponibilidade" não decorrente da simples instauração.\n\n📜 Fundamento legal vigente: a instauração de procedimento apuratório não antecipa punição; incide a presunção de inocência (CF/88, art. 5º, LVII), de modo que a SDM não afasta, por si só, o militar de suas funções.',
 'CF/88, art. 5º, LVII (presunção de inocência)',
 'facil'),

-- Q03: ampla defesa literal na SDM
(@cat_sdm18,
 'O oficial que preside uma SDM conduz a instrução sem garantir ao sindicado o contraditório e a ampla defesa. Sobre as consequências dessa condução, é correto afirmar que:',
 'Não há problema, pois a SDM é meramente informativa.',
 'A SDM é nula, e o presidente pode responder por abuso de autoridade, pois na SDM as garantias devem ser observadas na sua literalidade.',
 'O vício é sanável apenas com a assinatura do sindicado no relatório.',
 'A SDM prossegue normalmente, pois defesa só é exigida em processo penal.',
 'O sindicado deve arcar com os custos de eventual anulação.',
 'B',
 'A alternativa B está correta: diferentemente das instruções provisórias, a SDM exige a observância literal do contraditório e da ampla defesa; sua inobservância gera nulidade e pode acarretar representação por abuso de autoridade contra o presidente. As alternativas A e D negam a incidência das garantias. A alternativa C supõe uma convalidação que não sana a nulidade. A alternativa E transfere ao sindicado um ônus indevido.\n\n📜 Fundamento legal vigente: CF/88, art. 5º, LV — asseguram-se o contraditório e a ampla defesa nos processos administrativos. A violação das garantias em procedimento disciplinar gera nulidade e responsabilização do agente.',
 'CF/88, art. 5º, LV; nulidade e abuso de autoridade',
 'medio'),

-- Q04: SDM x IPM (mitigacao no inquerito)
(@cat_sdm18,
 'Compare a exigência do contraditório na Sindicância Disciplinar Militar com a que incide no Inquérito Policial Militar. É correto afirmar que:',
 'Ambos exigem contraditório pleno e idêntico, sob pena de nulidade.',
 'No IPM, por ser procedimento inquisitorial de formação da acusação, admite-se a mitigação das garantias de defesa; na SDM, o contraditório deve ser observado na literalidade.',
 'No IPM, o contraditório é mais rigoroso do que na SDM.',
 'Nenhum dos dois admite a presença de advogado.',
 'A SDM dispensa o contraditório, e o IPM o exige plenamente.',
 'B',
 'A alternativa B está correta: o IPM é instrução provisória de natureza inquisitorial, destinada a formar o convencimento da acusação, admitindo-se a mitigação das garantias de defesa; já a SDM, procedimento disciplinar sancionador, exige o contraditório na sua literalidade. As alternativas A e C invertem ou igualam os regimes. A alternativa D nega a possibilidade de advogado. A alternativa E inverte por completo a lógica dos dois procedimentos.\n\n📜 Fundamento legal vigente: STF, PET 7612 (2ª Turma) — por ser o inquérito procedimento de formação do convencimento da acusação, admite-se a mitigação do contraditório; a assistência da defesa por razões e quesitos não se confunde com direito subjetivo à intimação prévia do calendário de inquirições. Na SDM, incide plenamente o art. 5º, LV, da CF/88.',
 'STF, PET 7612; CF/88, art. 5º, LV',
 'dificil'),

-- Q05: sem advogado -> defensor dativo (SV5)
(@cat_sdm18,
 'Durante uma SDM, o sindicado é citado e opta por não constituir advogado particular. Diante disso, o presidente deve:',
 'Julgar o sindicado à revelia, sem defesa técnica.',
 'Designar um Defensor Dativo para acompanhar o procedimento e garantir o contraditório.',
 'Suspender o feito indefinidamente até que a OAB indique um profissional.',
 'Assumir, ele próprio, o papel de defensor e julgador ao mesmo tempo.',
 'Exigir que o sindicado assine termo de renúncia à defesa.',
 'B',
 'A alternativa B está correta: não constituindo o sindicado advogado, o presidente designa um Defensor Dativo (que pode ser oficial da corporação) para assegurar o contraditório e a ampla defesa. A alternativa A ignora a garantia de defesa. As alternativas C, D e E propõem soluções que violam a imparcialidade ou o direito de defesa.\n\n📜 Fundamento legal vigente: Súmula Vinculante nº 5/STF — "A falta de defesa técnica por advogado no processo administrativo disciplinar não ofende a Constituição"; ainda assim, a boa condução da SDM assegura defesa por Defensor Dativo, quando o sindicado não constitui advogado, em respeito ao art. 5º, LV, da CF/88.',
 'Súmula Vinculante nº 5/STF; CF/88, art. 5º, LV',
 'medio'),

-- Q06: conversao — improcedente -> arquivamento
(@cat_sdm18,
 'Concluída a instrução de uma SDM, o oficial-presidente conclui que as acusações contra o sindicado são improcedentes e desprovidas de prova. O desfecho correto é:',
 'A aplicação de sanção leve, por precaução.',
 'O arquivamento do procedimento.',
 'A conversão automática em Conselho de Disciplina.',
 'A remessa ao Ministério Público para denúncia.',
 'A conversão em Inquérito Policial Militar.',
 'B',
 'A alternativa B está correta: sendo os fatos improcedentes, o desfecho é o arquivamento da SDM. As alternativas A, C, D e E impõem sanção ou conversão sem suporte fático, contrariando a conclusão de improcedência.\n\n📜 Fundamento legal vigente: o relatório da SDM deve refletir a prova dos autos; a improcedência conduz ao arquivamento, em respeito à presunção de inocência (CF/88, art. 5º, LVII) e ao dever de motivação dos atos administrativos.',
 'CF/88, art. 5º, LVII; desfecho da SDM (arquivamento)',
 'facil'),

-- Q07: conversao — praca NAO estavel + etica -> PAD
(@cat_sdm18,
 'Um Soldado com dois anos de serviço (praça sem estabilidade) é sindicado, e a apuração revela conduta que contraria gravemente a ética e a honra pessoal. A SDM deve ser convertida em:',
 'Conselho de Justificação.',
 'Processo Administrativo Disciplinar (PAD).',
 'Conselho de Disciplina.',
 'Inquérito Policial Militar.',
 'Auto de Prisão em Flagrante.',
 'B',
 'A alternativa B está correta: tratando-se de praça não estável cuja conduta contraria a ética e a honra, a conversão adequada é em Processo Administrativo Disciplinar (PAD). A alternativa A é para oficiais; a alternativa C é para Aspirante-a-Oficial e praças estáveis; as alternativas D e E pressupõem crime ou flagrante, não descritos.\n\n📜 Fundamento legal vigente: as conversões da SDM seguem a condição do sindicado — praça não estável com violação ético-funcional conduz ao PAD, procedimento sancionador com contraditório e ampla defesa (CF/88, art. 5º, LV).',
 'CF/88, art. 5º, LV; conversão da SDM (praça não estável → PAD)',
 'medio'),

-- Q08: conversao — praca ESTAVEL -> Conselho de Disciplina
(@cat_sdm18,
 'Um Subtenente, praça com estabilidade assegurada, é sindicado por fato que contraria o pundonor militar. A SDM deve ser convertida em:',
 'Processo Administrativo Disciplinar (PAD).',
 'Conselho de Disciplina.',
 'Conselho de Justificação.',
 'Inquérito Policial comum.',
 'Arquivamento com nota nos assentamentos.',
 'B',
 'A alternativa B está correta: para Aspirante-a-Oficial e praças com estabilidade, a conversão adequada, em caso de violação ao pundonor, é o Conselho de Disciplina. A alternativa A (PAD) destina-se, na sistemática apresentada, à praça não estável; a alternativa C (Conselho de Justificação) é para oficiais; as alternativas D e E não correspondem ao caso.\n\n📜 Fundamento legal vigente: a distinção casa com a sistemática do Estatuto (ver disciplina/legislação correlata): Conselho de Disciplina para Aspirante-a-Oficial e praças estáveis; Conselho de Justificação para oficiais.',
 'Conversão da SDM (praça estável → Conselho de Disciplina)',
 'medio'),

-- Q09: conversao — oficial -> Conselho de Justificacao
(@cat_sdm18,
 'Um Major é sindicado por fato que atinge a honra pessoal e o decoro da classe. A SDM deve ser convertida em:',
 'Processo Administrativo Disciplinar (PAD).',
 'Conselho de Disciplina.',
 'Conselho de Justificação.',
 'Inquérito Policial Militar, obrigatoriamente.',
 'Ação Civil Pública.',
 'C',
 'A alternativa C está correta: sendo o sindicado oficial e atingidos a honra e o decoro da classe, a conversão adequada é o Conselho de Justificação — procedimento próprio dos oficiais. A alternativa A (PAD) e a alternativa B (Conselho de Disciplina) destinam-se a praças. A alternativa D pressupõe crime militar. A alternativa E é instrumento de natureza diversa.\n\n📜 Fundamento legal vigente: o Conselho de Justificação é o procedimento cabível para apurar a conduta de oficiais quando atingidos a honra, o pundonor e o decoro da classe, em simetria com a sistemática do Estatuto dos Militares.',
 'Conversão da SDM (oficial → Conselho de Justificação)',
 'medio'),

-- Q10: conversao — indicio de crime militar -> IPM
(@cat_sdm18,
 'No curso de uma SDM, surgem indícios robustos de que a transgressão também configura, em tese, o crime militar de violência contra inferior. O procedimento correto é:',
 'Aplicar imediatamente 30 dias de prisão e encerrar.',
 'Converter a SDM em Inquérito Policial Militar (IPM).',
 'Manter a SDM até o julgamento pelo Tribunal de Justiça.',
 'Converter em Processo Administrativo Disciplinar.',
 'Arquivar por falta de competência.',
 'B',
 'A alternativa B está correta: havendo indícios de crime militar, a SDM converte-se em Inquérito Policial Militar, instrumento próprio da apuração penal militar. A alternativa A antecipa punição sem processo. A alternativa C mantém indevidamente o procedimento disciplinar. A alternativa D ignora a natureza penal do indício. A alternativa E arquiva sem fundamento.\n\n📜 Fundamento legal vigente: constatados indícios de crime militar, cabe a apuração penal pela via do IPM (CPPM — Decreto-Lei nº 1.002/1969), sem prejuízo da eventual responsabilização disciplinar.',
 'CPPM (Decreto-Lei 1.002/1969); conversão em IPM',
 'medio'),

-- Q11: conversao — crime comum -> IP comum + Corregedoria SSP
(@cat_sdm18,
 'Durante uma SDM, o presidente descobre que o sindicado praticou estelionato contra um civil, fora do ambiente militar e sem relação com a função. Diante de indícios de crime comum, a providência correta é:',
 'Instaurar IPM imediatamente.',
 'Converter em Inquérito Policial comum e encaminhar cópia à Corregedoria Geral da Secretaria de Segurança Pública.',
 'Arquivar por falta de competência militar.',
 'Aplicar sanção administrativa de 30 dias de prisão.',
 'Remeter diretamente ao Tribunal de Justiça Militar.',
 'B',
 'A alternativa B está correta: diante de indícios de crime comum (sem natureza militar), a apuração penal cabe à Justiça Comum, convertendo-se em Inquérito Policial comum, com remessa de cópia à Corregedoria da SSP. A alternativa A pressupõe crime militar, ausente. As alternativas C, D e E arquivam, punem ou remetem de forma incompatível com a natureza comum do delito.\n\n📜 Fundamento legal vigente: crime comum não atrai a competência da Justiça Militar; a apuração penal segue pela via do inquérito policial comum, sem prejuízo da apuração disciplinar interna.',
 'Conversão da SDM (crime comum → IP comum + Corregedoria)',
 'medio'),

-- Q12: rito — sequencia inicial
(@cat_sdm18,
 'Após receber os documentos que narram a ocorrência e publicar a portaria de instauração, quais são, na ordem correta, os atos iniciais do rito da SDM?',
 'Citação, interrogatório, autuação e relatório.',
 'Autuação/Termo de Compromisso, despacho ordinatório e Mandado de Citação do sindicado.',
 'Alegações finais, oitiva de testemunhas e citação.',
 'Relatório, oitiva da vítima e citação.',
 'Interrogatório, alegações finais e autuação.',
 'B',
 'A alternativa B está correta: após a portaria, seguem-se a autuação (com termo de compromisso), o despacho ordinatório inicial e o Mandado de Citação do sindicado. As demais alternativas embaralham a ordem, colocando atos finais (relatório, alegações finais) antes dos atos de abertura.\n\n📜 Fundamento legal vigente: o rito assegura, desde a citação, o conhecimento da imputação e a possibilidade de defesa (CF/88, art. 5º, LV), pressuposto de validade do procedimento disciplinar.',
 'CF/88, art. 5º, LV; rito da SDM (sequência inicial)',
 'medio'),

-- Q13: ordem das oitivas
(@cat_sdm18,
 'Na fase de instrução da SDM, o presidente vai colher os depoimentos. A ordem correta das oitivas é:',
 'Vítima, sindicado, testemunhas de defesa e testemunhas de acusação.',
 'Sindicado, ofendido (vítima), testemunhas de acusação e, por fim, testemunhas de defesa.',
 'Testemunhas de acusação, testemunhas de defesa, vítima e sindicado.',
 'Sindicado, testemunhas de defesa, testemunhas de acusação e vítima.',
 'A ordem é livre, a critério do presidente.',
 'B',
 'A alternativa B está correta: a instrução observa a ordem sindicado → ofendido → testemunhas de acusação → testemunhas de defesa, deixando a defesa por último. As alternativas A, C e D invertem essa sequência; a alternativa E ignora a ordem processual que resguarda a ampla defesa.\n\n📜 Fundamento legal vigente: a colheita ordenada da prova, com a defesa por último, prestigia o contraditório e a ampla defesa (CF/88, art. 5º, LV), aplicando-se subsidiariamente a lógica do processo penal militar (CPPM).',
 'CF/88, art. 5º, LV; CPPM (ordem das oitivas)',
 'medio'),

-- Q14: testemunha civil -> acusado apresenta (CPPM 348)
(@cat_sdm18,
 'O sindicado arrola duas testemunhas civis para deporem em seu favor na SDM. Quanto ao comparecimento dessas testemunhas, é correto afirmar que:',
 'O presidente deve requisitá-las ao Ministério do Trabalho.',
 'Cabe ao próprio sindicado apresentá-las no local e na data designados.',
 'Testemunhas civis não podem ser ouvidas em sindicância militar.',
 'O Defensor Dativo deve conduzi-las coercitivamente.',
 'Devem ser ouvidas apenas por videoconferência.',
 'B',
 'A alternativa B está correta: quando as testemunhas são civis, cabe ao acusado apresentá-las no local designado para a audiência. A alternativa A cria uma requisição inexistente. A alternativa C nega, sem base, a oitiva de civis. As alternativas D e E impõem procedimentos não previstos para esse caso.\n\n📜 Fundamento legal vigente: CPPM (Decreto-Lei nº 1.002/1969), art. 348 — as testemunhas civis arroladas pela defesa são apresentadas pelo próprio acusado, aplicando-se por simetria ao rito da SDM.',
 'CPPM (DL 1.002/1969), art. 348 (testemunha civil)',
 'medio'),

-- Q15: testemunha militar/servidor -> requisicao (CPPM 349)
(@cat_sdm18,
 'A defesa indica, como testemunha, um Policial Militar de outra unidade e um servidor público civil. Quanto ao comparecimento desses depoentes, o presidente deve:',
 'Exigir que o sindicado os apresente por conta própria.',
 'Requisitá-los diretamente ao respectivo chefe imediato.',
 'Dispensar a oitiva para não atrapalhar o serviço público.',
 'Ouvi-los apenas por questionário escrito.',
 'Notificar a Corregedoria para que ela realize a oitiva.',
 'B',
 'A alternativa B está correta: sendo a testemunha militar ou servidor público, o presidente faz a requisição diretamente ao chefe imediato do depoente. A alternativa A trata militar/servidor como testemunha civil (que o acusado apresenta). As alternativas C, D e E suprimem ou desvirtuam a oitiva.\n\n📜 Fundamento legal vigente: CPPM (Decreto-Lei nº 1.002/1969), art. 349 — as testemunhas militares e os servidores públicos são requisitados ao respectivo chefe, aplicando-se por simetria à SDM.',
 'CPPM (DL 1.002/1969), art. 349 (testemunha militar/servidor)',
 'medio'),

-- Q16: pericia -> defesa notificada para quesitos
(@cat_sdm18,
 'Ao final da instrução, o presidente verifica a necessidade de uma perícia grafotécnica. Em relação à defesa, o correto é:',
 'Realizar a perícia em sigilo, sem ciência da defesa.',
 'Notificar a defesa para apresentar quesitos à perícia.',
 'A defesa deve arcar com os custos dos peritos oficiais.',
 'O laudo pericial substitui as alegações finais da defesa.',
 'A perícia só é admitida se o sindicado confessar.',
 'B',
 'A alternativa B está correta: determinada a perícia, a defesa deve ser notificada para apresentar quesitos, em respeito ao contraditório. A alternativa A viola o contraditório ao ocultar a perícia. As alternativas C, D e E criam ônus, substituição ou condição sem previsão.\n\n📜 Fundamento legal vigente: o contraditório (CF/88, art. 5º, LV) assegura à defesa participar da produção da prova pericial, inclusive formulando quesitos, sob pena de nulidade.',
 'CF/88, art. 5º, LV (quesitos da defesa na perícia)',
 'medio'),

-- Q17: alegacoes finais 5 dias
(@cat_sdm18,
 'Encerrada a instrução e juntada a ficha disciplinar, qual é o ato subsequente do rito da SDM e o respectivo prazo?',
 'Publicação imediata da sanção no boletim geral.',
 'Abertura de vista à defesa para alegações finais, pelo prazo de 5 dias.',
 'Remessa imediata ao Comandante-Geral, sem defesa.',
 'Interrogatório complementar do sindicado.',
 'Elaboração do relatório final sem ouvir a defesa.',
 'B',
 'A alternativa B está correta: concluída a instrução, abre-se vista à defesa para alegações finais pelo prazo de 5 dias, antes do relatório. As alternativas A, C e E suprimem a defesa final. A alternativa D reabre indevidamente a instrução.\n\n📜 Fundamento legal vigente: as alegações finais integram a ampla defesa (CF/88, art. 5º, LV); sua supressão vicia o procedimento. O prazo de 5 dias é o previsto no rito da SDM.',
 'CF/88, art. 5º, LV; prazo de alegações finais (5 dias)',
 'medio'),

-- Q18: defesa nao apresentada -> defensor dativo (nao revelia)
(@cat_sdm18,
 'Esgotado o prazo, a defesa não protocola as alegações finais. Diante disso, o presidente deve:',
 'Encerrar o processo e sugerir a punição máxima por desídia.',
 'Designar um Defensor Dativo para apresentar a defesa escrita, garantindo o contraditório.',
 'Prorrogar automaticamente o prazo por mais 5 dias, indefinidamente.',
 'Considerar que o sindicado confessou e arquivar a instrução.',
 'Julgar o sindicado à revelia, sem defesa técnica.',
 'B',
 'A alternativa B está correta: não exercido o direito de defesa no prazo, designa-se Defensor Dativo para formalizar as alegações — não se aplica revelia no procedimento disciplinar militar. A alternativa A pune a ausência de defesa. As alternativas C, D e E prorrogam indefinidamente, presumem confissão ou aplicam revelia, todas incompatíveis com a ampla defesa.\n\n📜 Fundamento legal vigente: Súmula Vinculante nº 5/STF e o art. 5º, LV, da CF/88 asseguram a defesa técnica; a inércia da defesa constituída é suprida por Defensor Dativo, jamais por revelia.',
 'Súmula Vinculante nº 5/STF; CF/88, art. 5º, LV',
 'medio'),

-- Q19: relatorio circunstanciado sugere medida
(@cat_sdm18,
 'O relatório final da SDM deve ser circunstanciado e terminar, obrigatoriamente:',
 'Com a imposição imediata da pena de exclusão.',
 'Sugerindo a adoção de uma das medidas cabíveis (arquivamento, sanção ou conversão em outro procedimento).',
 'Com a remessa dos autos diretamente ao Tribunal de Justiça.',
 'Com o pedido de prisão preventiva do sindicado.',
 'Declarando o sindicado culpado, sem possibilidade de conversão.',
 'B',
 'A alternativa B está correta: o relatório circunstanciado encerra-se sugerindo à autoridade uma das medidas cabíveis — arquivamento, aplicação de sanção ou conversão (PAD, Conselho de Disciplina, Conselho de Justificação ou IPM). As alternativas A e D impõem penas que não competem ao presidente. As alternativas C e E remetem ou concluem de forma incompatível com a fase.\n\n📜 Fundamento legal vigente: o relatório é peça opinativa e motivada; a decisão final cabe à autoridade instauradora, respeitados o contraditório e a ampla defesa (CF/88, art. 5º, LV).',
 'CF/88, art. 5º, LV; relatório da SDM',
 'facil'),

-- Q20: prazo de conclusao 40 dias, prorrogavel
(@cat_sdm18,
 'Uma portaria instaura uma SDM. Quanto ao prazo de conclusão dos trabalhos, é correto afirmar que:',
 'O prazo é indeterminado, até a oitiva da última testemunha.',
 'O prazo é de 40 dias, prorrogável mediante ofício justificado à autoridade instauradora.',
 'O prazo é de 15 dias, improrrogável.',
 'O prazo é de 90 dias, sem possibilidade de prorrogação.',
 'O prazo é definido livremente pela última testemunha ouvida.',
 'B',
 'A alternativa B está correta: o prazo de conclusão da SDM é de 40 dias, prorrogável mediante ofício justificado à autoridade que a instaurou. As alternativas A e E deixam o prazo indefinido; as alternativas C e D trazem prazos e regimes de prorrogação incorretos.\n\n📜 Fundamento legal vigente: o prazo e a prorrogação motivada constam do rito da SDM (norma interna), sem prejuízo dos princípios da eficiência e da razoável duração do procedimento (CF/88, art. 5º, LXXVIII).',
 'CF/88, art. 5º, LXXVIII; prazo da SDM (40 dias)',
 'medio'),

-- Q21: STF PET 7612 — sem direito subjetivo a calendario
(@cat_sdm18,
 'Em um Inquérito Policial Militar, a defesa exige ser previamente intimada de todo o calendário de inquirições de testemunhas. Segundo o entendimento do Supremo Tribunal Federal aplicável às instruções provisórias, essa exigência:',
 'Deve ser atendida, pois há direito subjetivo à intimação prévia do calendário.',
 'Não configura direito subjetivo da defesa, dado o caráter inquisitorial do inquérito, cabendo-lhe apresentar razões e quesitos.',
 'Torna o inquérito nulo se não atendida.',
 'Só se aplica a inquéritos que envolvam oficiais.',
 'Transforma o inquérito em processo contraditório pleno.',
 'B',
 'A alternativa B está correta: o STF assentou que, por ser o inquérito procedimento de formação do convencimento da acusação, a assistência da defesa (razões e quesitos) não se confunde com um direito subjetivo à intimação prévia e tempestiva do calendário de inquirições. As alternativas A e C criam um direito e uma nulidade que o STF afastou. As alternativas D e E restringem ou desnaturam indevidamente o entendimento.\n\n📜 Fundamento legal vigente: STF, PET 7612 (2ª Turma) — mitigação das garantias na fase inquisitorial; a assistência da defesa não gera direito subjetivo à intimação prévia do calendário de oitivas. (Distinto da SDM, em que o contraditório é pleno.)',
 'STF, PET 7612 (natureza inquisitorial do inquérito)',
 'dificil'),

-- Q22: IPM/APFDM/PDM = instrucoes provisorias
(@cat_sdm18,
 'O Inquérito Policial Militar, o Auto de Prisão em Flagrante e o Processo de Deserção são classificados, quanto à sua natureza, como:',
 'Processos administrativos punitivos.',
 'Meras instruções provisórias, de natureza inquisitorial.',
 'Peças judiciais de acusação.',
 'Ritos sumários de exclusão.',
 'Diligências externas de fiscalização.',
 'B',
 'A alternativa B está correta: IPM, APFDM e PDM são instruções provisórias, de natureza inquisitorial, o que justifica a mitigação das garantias de defesa nessa fase — diferentemente da SDM, procedimento disciplinar sancionador. As demais alternativas atribuem-lhes naturezas que não correspondem à sua função.\n\n📜 Fundamento legal vigente: a natureza inquisitorial dessas instruções provisórias fundamenta o entendimento do STF (PET 7612) sobre a mitigação do contraditório na fase pré-processual, sem prejuízo do contraditório pleno na fase processual e na SDM.',
 'STF, PET 7612; natureza das instruções provisórias',
 'medio'),

-- Q23: ficha disciplinar / contumacia
(@cat_sdm18,
 'Antes do relatório final, o presidente da SDM requisita a ficha disciplinar (assentamentos) do sindicado. Essa diligência é essencial para:',
 'Verificar o endereço residencial atualizado do militar.',
 'Avaliar a reincidência e o comportamento funcional, o que influi na dosimetria da sanção ou na conversão do procedimento.',
 'Confirmar o tipo sanguíneo para exames.',
 'Verificar parentesco entre o sindicado e o presidente.',
 'Cumprir mera formalidade, sem efeito no resultado.',
 'B',
 'A alternativa B está correta: os assentamentos permitem verificar se o militar é contumaz na prática de atos de igual natureza, influenciando a dosimetria da sanção e a eventual conversão do procedimento. As alternativas A, C e D atribuem à ficha finalidades alheias. A alternativa E nega, sem razão, o efeito da diligência no resultado.\n\n📜 Fundamento legal vigente: a individualização e a proporcionalidade da sanção disciplinar exigem a análise do histórico funcional do sindicado, motivando adequadamente a decisão (CF/88, art. 5º, LV, e dever de motivação).',
 'CF/88, art. 5º, LV; assentamentos e dosimetria',
 'facil'),

-- Q24: distincao CJ x CD (nivel 3 do guia)
(@cat_sdm18,
 'Em uma mesma unidade, um Tenente e um Subtenente (praça estável) são apurados por infrações graves de mesma natureza, após regular procedimento. Sobre os procedimentos aplicáveis a cada um, assinale a alternativa correta:',
 'Ambos serão submetidos ao Conselho de Disciplina, por ser a infração de mesma natureza.',
 'O Tenente será submetido ao Conselho de Justificação e o Subtenente ao Conselho de Disciplina, por serem categorias hierárquicas distintas.',
 'Ambos serão submetidos ao Conselho de Justificação.',
 'O Tenente ao Conselho de Disciplina e o Subtenente ao Conselho de Justificação.',
 'Apenas o Subtenente será apurado, pois oficiais vão direto ao Tribunal.',
 'B',
 'A alternativa B está correta: o Conselho de Justificação é o procedimento dos oficiais (Tenente), enquanto o Conselho de Disciplina destina-se a Aspirante-a-Oficial e praças com estabilidade (Subtenente). A identidade da infração não unifica o procedimento, que segue a categoria hierárquica. As alternativas A, C e D trocam ou unificam indevidamente os ritos; a alternativa E cria um encaminhamento inexistente.\n\n📜 Fundamento legal vigente: em simetria com o Estatuto dos Militares, oficiais respondem perante o Conselho de Justificação; Aspirante-a-Oficial e praças estáveis, perante o Conselho de Disciplina — distinção que também orienta as conversões da SDM.',
 'Conselho de Justificação (oficial) x Conselho de Disciplina (praça estável)',
 'dificil'),

-- Q25: natureza — apura responsabilidade disciplinar
(@cat_sdm18,
 'Um oficial afirma que a Sindicância Disciplinar Militar serve para condenar penalmente o sindicado. Essa afirmação está:',
 'Correta, pois a SDM aplica pena de reclusão.',
 'Incorreta, pois a SDM apura responsabilidade no campo disciplinar, e não a responsabilidade penal.',
 'Correta, pois a SDM substitui o processo penal militar.',
 'Incorreta, pois a SDM serve apenas para arquivar ocorrências.',
 'Correta, desde que haja confissão do sindicado.',
 'B',
 'A alternativa B está correta: a SDM apura a responsabilidade disciplinar; a responsabilidade penal, quando há indícios de crime, é apurada em via própria (IPM ou inquérito comum). As alternativas A, C e E confundem a esfera disciplinar com a penal. A alternativa D reduz indevidamente a SDM ao arquivamento, ignorando as demais medidas cabíveis.\n\n📜 Fundamento legal vigente: as instâncias disciplinar e penal são independentes; a SDM é procedimento administrativo-disciplinar, sem caráter de condenação penal, remetendo-se à via penal quando surgirem indícios de crime.',
 'Independência das instâncias; natureza disciplinar da SDM',
 'facil'),

-- Q26: prorrogacao via oficio justificado
(@cat_sdm18,
 'O presidente de uma SDM percebe que não conseguirá concluí-la no prazo, pois aguarda a chegada de um exame indispensável. A providência correta é:',
 'Arquivar o procedimento por decurso de prazo.',
 'Encaminhar ofício justificado à autoridade instauradora, solicitando a prorrogação do prazo.',
 'Encerrar a SDM e aplicar sanção sem o exame.',
 'Suspender o militar por invalidez até o exame chegar.',
 'Substituir o escrivão para acelerar o feito.',
 'B',
 'A alternativa B está correta: a impossibilidade de conclusão no prazo por diligência pendente resolve-se com pedido de prorrogação, mediante ofício justificado à autoridade instauradora. As alternativas A e C encerram o feito prematuramente, com prejuízo à apuração ou à defesa. As alternativas D e E adotam medidas impertinentes.\n\n📜 Fundamento legal vigente: o rito da SDM admite a prorrogação motivada do prazo; a diligência pendente justifica a prorrogação, preservando a busca da verdade e a ampla defesa (CF/88, art. 5º, LV).',
 'CF/88, art. 5º, LV; prorrogação motivada do prazo',
 'facil'),

-- Q27: mandado de citacao informa faculdade de advogado (SV5)
(@cat_sdm18,
 'O Mandado de Citação da SDM informa ao sindicado suas opções de defesa. Entre elas, corretamente consta que o sindicado poderá:',
 'Ser obrigado a confessar para agilizar o feito.',
 'Constituir advogado, exercer a autodefesa ou receber Defensor Dativo, caso não constitua advogado.',
 'Apenas aguardar o julgamento, sem qualquer manifestação.',
 'Recusar-se a ser citado, anulando o procedimento.',
 'Exigir a suspensão do feito até que ele contrate advogado no exterior.',
 'B',
 'A alternativa B está correta: o mandado de citação informa a faculdade de constituir advogado, de exercer a autodefesa ou de receber Defensor Dativo (que pode ser oficial da corporação) caso não constitua advogado. As alternativas A, C, D e E descrevem imposições ou consequências que violam a ampla defesa ou o regular andamento do procedimento.\n\n📜 Fundamento legal vigente: Súmula Vinculante nº 5/STF (a ausência de advogado no PAD não ofende a Constituição) e o art. 5º, LV, da CF/88, que asseguram a defesa técnica ou a autodefesa, com Defensor Dativo quando necessário.',
 'Súmula Vinculante nº 5/STF; CF/88, art. 5º, LV',
 'medio'),

-- Q28: violar defesa -> abuso de autoridade contra presidente
(@cat_sdm18,
 'Um oficial-presidente, deliberadamente, impede o sindicado de ter acesso aos autos e de produzir provas ao longo da SDM. Além da nulidade do procedimento, o presidente pode:',
 'Ser elogiado pela celeridade do feito.',
 'Ser responsabilizado por abuso de autoridade, por cercear a defesa.',
 'Ter sua conduta convalidada pelo Comandante-Geral.',
 'Aplicar a sanção mais grave possível ao sindicado.',
 'Encerrar a SDM sem qualquer consequência pessoal.',
 'B',
 'A alternativa B está correta: cercear deliberadamente a defesa gera a nulidade do procedimento e sujeita o presidente à responsabilização por abuso de autoridade. As alternativas A, C, D e E ignoram a gravidade do cerceamento e suas consequências pessoais e processuais.\n\n📜 Fundamento legal vigente: o desrespeito ao contraditório e à ampla defesa (CF/88, art. 5º, LV) vicia o procedimento e pode configurar crime de abuso de autoridade (Lei nº 13.869/2019), conforme a conduta do agente.',
 'CF/88, art. 5º, LV; Lei nº 13.869/2019 (abuso de autoridade)',
 'medio'),

-- Q29: concurso de agentes / conversao por posto
(@cat_sdm18,
 'Uma SDM apura fato imputado, em conjunto, a um Capitão e a um Cabo com estabilidade. Ao final, a conduta atinge a ética e o decoro de ambos. Quanto às conversões, é correto afirmar que:',
 'Ambos irão para o Conselho de Justificação, por terem agido juntos.',
 'O Capitão irá para o Conselho de Justificação e o Cabo estável para o Conselho de Disciplina, pois os procedimentos seguem a categoria hierárquica.',
 'Ambos irão para o Conselho de Disciplina.',
 'Ambos serão punidos diretamente, sem qualquer conversão.',
 'O caso será remetido integralmente ao Tribunal de Justiça Militar.',
 'B',
 'A alternativa B está correta: mesmo em concurso, os procedimentos seguem a categoria de cada sindicado — oficial (Capitão) ao Conselho de Justificação; praça estável (Cabo) ao Conselho de Disciplina. As alternativas A e C unificam indevidamente os ritos; a alternativa D dispensa a conversão cabível; a alternativa E remete o caso a órgão que não conduz essas apurações disciplinares.\n\n📜 Fundamento legal vigente: a distinção Conselho de Justificação (oficiais) x Conselho de Disciplina (Aspirante-a-Oficial e praças estáveis) mantém-se ainda que os fatos sejam comuns a vários sindicados, pois cada um responde conforme sua categoria.',
 'Conselho de Justificação x Conselho de Disciplina (concurso de agentes)',
 'dificil'),

-- Q30: defensor dativo pode ser oficial da corporacao
(@cat_sdm18,
 'Diante da ausência de advogado constituído pelo sindicado, o presidente da SDM designa um oficial da própria corporação como Defensor Dativo. Sobre essa designação, é correto afirmar que:',
 'É nula, pois somente advogado inscrito na OAB pode atuar na defesa.',
 'É válida, pois a defesa técnica por advogado não é imprescindível no procedimento disciplinar, admitindo-se Defensor Dativo, inclusive oficial da corporação.',
 'É válida apenas se o sindicado for oficial.',
 'Só é possível se autorizada pelo Tribunal de Justiça.',
 'Impede o prosseguimento do feito até a manifestação da OAB.',
 'B',
 'A alternativa B está correta: no procedimento administrativo disciplinar, a defesa técnica por advogado não é imprescindível, sendo válida a designação de Defensor Dativo, que pode ser oficial da corporação. A alternativa A contraria o entendimento sumulado. As alternativas C, D e E criam condições e impedimentos inexistentes.\n\n📜 Fundamento legal vigente: Súmula Vinculante nº 5/STF — "A falta de defesa técnica por advogado no processo administrativo disciplinar não ofende a Constituição"; a designação de Defensor Dativo assegura o contraditório e a ampla defesa (CF/88, art. 5º, LV).',
 'Súmula Vinculante nº 5/STF; CF/88, art. 5º, LV',
 'medio');
