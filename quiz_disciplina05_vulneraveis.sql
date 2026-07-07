-- ============================================================
-- QUIZ — Disciplina 5/20 do CHO: Atuação Policial na Proteção dos Direitos
-- Humanos de Pessoas em Situação de Vulnerabilidade
-- 30 questões — dupla justificativa (doutrina/apostila + legislação vigente)
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: apostila técnica do CHO — Abordagem Policial e Direitos Humanos
--   (Capítulos 1 a 10: Aspectos Gerais, Mulheres, Criança e Adolescente,
--   Racismo, Pessoas com Deficiência, LGBT, Pessoa Idosa, Situação de Rua,
--   Vítimas da Criminalidade, Usuários e Dependentes de Drogas)
-- Base legal vigente: ECA (Lei 8.069/1990); Estatuto do Idoso (Lei 10.741/2003);
--   Lei de Drogas (Lei 11.343/2006); Lei 9.807/1999; Lei 7.716/1989 c/c
--   art. 2º-A (Lei 14.532/2023) e art. 140, §3º, CP; Lei 11.983/2009;
--   Decreto 7.053/2009; Decreto 8.727/2016; CPP arts. 244 e 249; CP art. 27;
--   CRFB art. 228; LCP (Decreto-Lei 3.688/1941) art. 68; Súmula Vinculante 11/STF
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Atuação Policial na Proteção dos Direitos Humanos de Pessoas em Situação de Vulnerabilidade — CHO 05', 'Disciplina 5/20 do CHO — Abordagem a mulheres, crianças/adolescentes, idosos, PcD, LGBTQIAPN+, pessoas em situação de rua e usuários de drogas');

SET @cat_vu05 = (SELECT id FROM categorias WHERE nome = 'Atuação Policial na Proteção dos Direitos Humanos de Pessoas em Situação de Vulnerabilidade — CHO 05' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Conceito de Captura
(@cat_vu05,
 'De acordo com os padrões internacionais de Direitos Humanos e a doutrina técnica de segurança pública, o conceito de Captura é definido como:',
 'O ato jurídico aplicado exclusivamente após sentença penal transitada em julgado.',
 'O cerceamento da liberdade após a confirmação do ilícito para condução à delegacia.',
 'O ato de abordar, parar, aproximar-se e estabelecer contato para confirmar fundada suspeita.',
 'O procedimento de inspeção minuciosa em corpo, vestes e pertences do suspeito.',
 NULL,
 'C',
 'A alternativa C está correta pois a Captura é o elemento precursor da detenção, focado na abordagem inicial ao cidadão. A alternativa A está incorreta porque descreve a Prisão em sentido estrito (pós-sentença). A alternativa B está incorreta por definir a Detenção (condução após ilícito confirmado). A alternativa D está incorreta pois refere-se à Busca Pessoal, ato distinto e posterior à captura.\n\n📜 Fundamento legal vigente: trata-se de conceito doutrinário/protocolo operacional (POP) de segurança pública, sem correspondência em dispositivo legal específico — a distinção entre captura, detenção e prisão é construção de manuais técnicos de abordagem policial, e não objeto de definição em lei em sentido estrito.',
 'Doutrina técnica de abordagem policial (POP)',
 'facil'),

-- Q02: Fundada Suspeita
(@cat_vu05,
 'A Fundada Suspeita é o requisito legal para a quebra da invisibilidade do cidadão pela abordagem. Sobre este tema, assinale a alternativa tecnicamente correta:',
 'Pode ser motivada pelo "tirocínio" baseado na cor da pele ou local de moradia do indivíduo.',
 'Deve basear-se em elementos concretos e sensíveis que indiquem a necessidade da intervenção.',
 'É um conceito puramente subjetivo que autoriza a busca pessoal em qualquer cidadão em via pública.',
 'Justifica-se sempre que o cidadão demonstrar nervosismo ao avistar a viatura policial.',
 NULL,
 'B',
 'A alternativa B é a correta, pois a Fundada Suspeita exige objetividade na abordagem. A alternativa A está incorreta pois descreve discriminação, vedada pelo ordenamento jurídico. A alternativa C é tecnicamente falsa, pois o poder de polícia não é absoluto nem puramente subjetivo. A alternativa D é incorreta porque o nervosismo isolado, sem elementos concretos de crime, não supre a exigência legal de elementos sensíveis e objetivos.\n\n📜 Fundamento legal vigente: CPP, art. 244: a busca pessoal independe de mandado quando houver "fundada suspeita" de que a pessoa esteja na posse de arma proibida ou de objetos que constituam corpo de delito. A jurisprudência do STJ exige indícios objetivos, concretos e prévios à abordagem — meras impressões subjetivas, "tirocínio" baseado em estereótipos, nervosismo isolado ou denúncia anônima genérica não satisfazem a exigência legal.',
 'CPP, art. 244',
 'medio'),

-- Q03: Busca Pessoal
(@cat_vu05,
 'No procedimento de Busca Pessoal, o agente de segurança deve observar que:',
 'A revista deve ser feita apenas no corpo, sendo vedada a abertura de mochilas sem mandado.',
 'A esfera de custódia (bolsas, pastas, malas) está excluída da busca pessoal administrativa.',
 'O ato inclui a inspeção do corpo, das vestes e de toda a esfera de custódia do abordado.',
 'A busca deve preceder a verbalização por questões de segurança tática da guarnição.',
 NULL,
 'C',
 'A alternativa C está correta conforme a definição técnica de busca pessoal. As alternativas A e B estão incorretas pois a esfera de custódia (bolsas, mochilas, malas) faz parte integrante da busca pessoal, dispensando mandado nas hipóteses do art. 244 do CPP. A alternativa D está incorreta porque o procedimento operacional padrão prevê a verbalização ("Parado! Polícia!") como fase anterior ao contato físico da busca, por segurança tática.\n\n📜 Fundamento legal vigente: CPP, art. 244: "A busca pessoal independerá de mandado (...) quando houver fundada suspeita de que a pessoa esteja na posse de arma proibida ou de objetos ou papéis que constituam corpo de delito (...)". A doutrina e a jurisprudência interpretam a expressão "busca pessoal" como abrangendo corpo, vestes e a esfera de custódia direta do abordado.',
 'CPP, art. 244',
 'medio'),

-- Q04: Detenção x Prisão
(@cat_vu05,
 'Diferencie tecnicamente Detenção de Prisão no contexto da atividade policial:',
 'Não há diferença técnica no Brasil, sendo termos sinônimos para qualquer privação de liberdade.',
 'Detenção é a condução à autoridade após flagrante; Prisão é o ato pós-sentença transitada em julgado.',
 'Detenção é aplicada a crimes leves; Prisão é reservada a crimes hediondos e graves.',
 'A detenção exige mandado judicial prévio, enquanto a prisão ocorre apenas em flagrante.',
 NULL,
 'B',
 'A alternativa B traz a distinção técnica adotada pela doutrina. A alternativa A está incorreta porque, embora o uso popular seja similar, a doutrina as diferencia pelo momento processual. A alternativa C é falsa, pois a diferença é temporal/processual, não relacionada à gravidade do crime. A alternativa D inverte os conceitos lógicos do processo penal.\n\n📜 Fundamento legal vigente: CPP, art. 283: "Ninguém poderá ser preso senão em flagrante delito ou por ordem escrita e fundamentada da autoridade judiciária competente, em decorrência de sentença condenatória transitada em julgado ou, no curso da investigação ou do processo, em virtude de prisão temporária ou prisão preventiva." A "detenção" (condução coercitiva após flagrante) é etapa anterior e distinta da prisão em sentido estrito, que depende de ordem judicial ou sentença condenatória.',
 'CPP, art. 283',
 'medio'),

-- Q05: Identificação — LCP art. 68
(@cat_vu05,
 'Sobre a identificação do cidadão durante a abordagem, a Lei das Contravenções Penais (Art. 68) estabelece que:',
 'O cidadão é obrigado a portar documento de identidade original em tempo integral.',
 'O policial pode deter para averiguação quem não portar documento físico, mesmo que se identifique verbalmente.',
 'Constitui infração recusar à autoridade dados sobre a própria identidade quando justificadamente solicitados.',
 'Apenas o Delegado de Polícia pode exigir a identificação do cidadão, sendo vedado ao patrulheiro.',
 NULL,
 'C',
 'A alternativa C reflete a literalidade do art. 68 da LCP. A alternativa A está incorreta pois o porte físico não é obrigatório, mas o dever de se identificar sim. A alternativa B é ilegal, pois a "prisão para averiguação" não existe no ordenamento brasileiro. A alternativa D ignora que o patrulheiro exerce poder de polícia delegado, podendo solicitar identificação no exercício regular de suas funções.\n\n📜 Fundamento legal vigente: LCP (Decreto-Lei nº 3.688/1941), art. 68: constitui contravenção "recusar à autoridade, quando por esta justificadamente solicitado, dados ou indicações concernentes à própria identidade, estado, profissão, domicílio e residência". O dispositivo não exige porte físico do documento, apenas a prestação verbal e verdadeira das informações solicitadas.',
 'LCP (Decreto-Lei 3.688/1941), art. 68',
 'facil'),

-- Q06: Encerramento da abordagem
(@cat_vu05,
 'Ao término de uma abordagem onde não foi constatado ilícito, o policial deve:',
 'Liberar o indivíduo rapidamente para evitar aglomerações, sem necessidade de diálogo.',
 'Orientar o cidadão a procurar a Corregedoria caso se sinta ofendido pela revista.',
 'Esclarecer os motivos da ação, manter a cortesia e desejar bom dia/tarde/noite.',
 'Reter os dados do cidadão para futuras abordagens em sistema de inteligência preventiva.',
 NULL,
 'C',
 'A alternativa C segue a orientação de transparência e educação prevista no manual técnico. A alternativa A é incorreta pois ignora o dever de esclarecimento ao cidadão abordado. A alternativa B é desnecessária se o ato foi legal e conduzido com urbanidade. A alternativa D viola o princípio da intervenção mínima e da dignidade da pessoa se não há suspeita ou ilícito confirmado.\n\n📜 Fundamento legal vigente: trata-se de boa prática doutrinária/protocolo operacional de transparência na atividade policial, alinhada ao princípio da dignidade da pessoa humana (CRFB, art. 1º, III), sem correspondência em dispositivo legal específico que discipline o encerramento verbal da abordagem.',
 'Doutrina técnica de abordagem policial (POP); CRFB, art. 1º, III',
 'medio'),

-- Q07: Art. 249 CPP — regra geral
(@cat_vu05,
 'O Artigo 249 do CPP disciplina a busca pessoal em mulheres. Sobre a sua aplicação prática, assinale a correta:',
 'A busca em mulheres deve ser feita exclusivamente por policiais femininas, sob pena de nulidade absoluta.',
 'Deve ser feita por mulher, salvo se isso importar em retardamento ou prejuízo da diligência.',
 'O policial masculino está proibido de revistar mulheres, devendo liberá-las se não houver efetivo feminino.',
 'A busca pessoal em mulheres dispensa a fundada suspeita por questões de segurança pública.',
 NULL,
 'B',
 'A alternativa B traz a ressalva legal do art. 249 do CPP. A alternativa A está incorreta pois ignora a exceção legal expressa. A alternativa C é falsa, pois em caso de urgência (risco de descarte de arma/droga), o policial masculino pode agir para não prejudicar a diligência. A alternativa D viola a Constituição Federal e o próprio art. 244 do CPP, que exige fundada suspeita para qualquer busca pessoal.\n\n📜 Fundamento legal vigente: CPP, art. 249: "A busca em mulher será feita por outra mulher, salvo se isso importar retardamento ou prejuízo da diligência." A regra é a busca por policial feminina; a exceção (busca por policial masculino) só se justifica diante de urgência real que não comporte espera.',
 'CPP, art. 249',
 'medio'),

-- Q08: Procedimento na ausência de policial feminina
(@cat_vu05,
 'Na ausência de policial feminina na guarnição e havendo necessidade urgente de revista, o procedimento técnico prevê:',
 'Solicitar apoio de uma cidadã civil, orientando-a sobre como realizar a busca.',
 'Proceder à revista com as costas das mãos para evitar contato direto.',
 'Conduzir a suspeita ao hospital para que uma enfermeira realize a busca.',
 'Utilizar o bastão policial (tonfa) para realizar a palpação à distância.',
 NULL,
 'A',
 'A alternativa A é o procedimento operacional descrito pelo manual técnico para a situação de urgência sem policial feminina disponível na guarnição. As alternativas B e D são tecnicamente inadequadas e podem configurar constrangimento ou lesão ao abordado. A alternativa C é ineficiente e desproporcional, não sendo o procedimento previsto para uma busca pessoal administrativa comum.\n\n📜 Fundamento legal vigente: CPP, art. 249, parte final: "salvo se isso importar retardamento ou prejuízo da diligência" — a norma autoriza solução alternativa apenas em caso de urgência real; o meio específico (solicitar apoio de cidadã civil presente no local) é orientação doutrinária/protocolo operacional (POP), sem detalhamento legal expresso sobre esse procedimento.',
 'CPP, art. 249 (exceção); Doutrina técnica de abordagem policial (POP)',
 'medio'),

-- Q09: Custódia e transporte de mulheres
(@cat_vu05,
 'Sobre a custódia e condução de mulheres, é diretriz de Direitos Humanos:',
 'Conduzir mulheres no xadrez com homens, desde que algemadas para trás.',
 'Manter a mulher detida separada de indivíduos do sexo masculino durante o transporte.',
 'Algemar gestantes obrigatoriamente para evitar o risco de queda por desequilíbrio.',
 'Ignorar as limitações de lactantes para não ferir o princípio da igualdade entre os sexos.',
 NULL,
 'B',
 'A alternativa B preserva a dignidade e a integridade física da mulher custodiada. A alternativa A viola normas básicas de segurança e dignidade ao misturar sexos na custódia. A alternativa C é perigosa e desumana, contrariando a excepcionalidade do uso de algemas. A alternativa D ignora a necessidade de tratamento equitativo, que busca minimizar desigualdades materiais, e não apenas formais, entre homens e mulheres.\n\n📜 Fundamento legal vigente: a separação de custodiados por sexo decorre do dever geral de proteção à integridade física e moral do preso (CRFB, art. 5º, XLIX: "é assegurado aos presos o respeito à integridade física e moral") combinado com a excepcionalidade do uso de algemas fixada na Súmula Vinculante nº 11/STF, que veda o uso indiscriminado da algema fora das hipóteses de resistência, fuga ou risco à integridade.',
 'CRFB, art. 5º, XLIX; Súmula Vinculante 11/STF',
 'medio'),

-- Q10: Atendimento a vítima de violência
(@cat_vu05,
 'No atendimento à mulher vítima de violência, a guarnição deve priorizar:',
 'A realização de acareação imediata entre vítima e agressor no local.',
 'A entrevista e orientação da vítima preferencialmente por uma policial feminina.',
 'O convencimento da vítima para que não registre ocorrência se o agressor for réu primário.',
 'A condução apenas em casos de lesão corporal visível e grave.',
 NULL,
 'B',
 'A alternativa B foca no acolhimento da vítima e na redução de danos psicológicos da revitimização. A alternativa A revitimiza a mulher ao expô-la novamente ao agressor sem necessidade processual imediata. A alternativa C configura prevaricação e viola a Lei Maria da Penha. A alternativa D ignora que a violência psicológica, moral e patrimonial também exige intervenção policial, independentemente de lesão corporal visível.\n\n📜 Fundamento legal vigente: Lei nº 11.340/2006 (Lei Maria da Penha), art. 5º, reconhece como violência doméstica não apenas a física, mas também a psicológica, sexual, patrimonial e moral; o art. 11 determina o atendimento prioritário e humanizado da vítima pela autoridade policial, recomendando-se, sempre que possível, o acompanhamento por policial feminina especializada.',
 'Lei 11.340/2006 (Lei Maria da Penha), arts. 5º e 11',
 'medio'),

-- Q11: Busca minuciosa — áreas de atenção
(@cat_vu05,
 'Durante uma busca minuciosa realizada por policial feminina em uma suspeita, quais áreas exigem atenção especial devido à recorrência de ocultação de ilícitos?',
 'Apenas as solas dos sapatos e forros de casacos.',
 'Exclusivamente a bolsa e o interior de carteiras.',
 'Cabelos, seios e órgãos genitais.',
 'Somente as axilas e a cavidade bucal.',
 NULL,
 'C',
 'A alternativa C reflete a técnica descrita para a busca minuciosa em mulheres, áreas historicamente utilizadas para ocultação de armas, drogas e outros ilícitos. As alternativas A, B e D citam áreas relevantes, mas de forma incompleta perante o risco de ocultação nas áreas citadas no gabarito, conforme o procedimento técnico de busca.\n\n📜 Fundamento legal vigente: CPP, art. 249, que assegura a busca por policial feminina justamente para preservar a intimidade da revistada nesse tipo de inspeção mais minuciosa, sem que a lei detalhe tecnicamente as áreas do corpo — a especificação é doutrinária/operacional, decorrente de treinamento policial.',
 'CPP, art. 249',
 'medio'),

-- Q12: Classificação etária — ECA
(@cat_vu05,
 'Segundo o Estatuto da Criança e do Adolescente (ECA), a classificação etária correta é:',
 'Criança até 12 anos completos; Adolescente de 13 a 18 anos.',
 'Criança até 12 anos incompletos; Adolescente entre 12 e 18 anos incompletos.',
 'Criança até 10 anos; Adolescente de 11 a 21 anos incompletos.',
 'Criança e adolescente são sinônimos de menores de 18 anos sem distinção legal.',
 NULL,
 'B',
 'A alternativa B está em estrita conformidade com o ECA. As alternativas A, C e D apresentam faixas etárias juridicamente equivocadas, o que comprometeria a aplicação da medida correta (proteção versus socioeducativa) a depender da idade real do adolescente ou criança.\n\n📜 Fundamento legal vigente: ECA (Lei nº 8.069/1990), art. 2º: "Considera-se criança, para os efeitos desta Lei, a pessoa até doze anos de idade incompletos, e adolescente aquela entre doze e dezoito anos de idade." Texto literal e vigente, sem alteração posterior.',
 'ECA, art. 2º; Lei 8.069/1990',
 'facil'),

-- Q13: Criança e ato infracional
(@cat_vu05,
 'Quando uma criança (até 12 anos incompletos) pratica um fato definido como crime:',
 'Deve ser lavrado Auto de Prisão em Flagrante.',
 'Está sujeita à medida socioeducativa de internação imediata.',
 'Sujeita-se exclusivamente às medidas de proteção previstas no Art. 101 do ECA.',
 'Comete crime comum, mas tem pena reduzida pela metade.',
 NULL,
 'C',
 'A alternativa C está correta: a criança autora de ato infracional recebe apenas medidas de proteção. A alternativa A é falsa, pois criança não é presa em flagrante. A alternativa B está incorreta porque medidas socioeducativas aplicam-se apenas a adolescentes, nunca a crianças. A alternativa D ignora o conceito de ato infracional e a inimputabilidade penal do menor de 18 anos.\n\n📜 Fundamento legal vigente: ECA, art. 103, c/c art. 105: "Ao ato infracional praticado por criança corresponderão as medidas previstas no art. 101." O art. 101 do ECA lista as medidas de proteção (encaminhamento aos pais, orientação, inclusão em programas, tratamento, etc.), aplicáveis exclusivamente a crianças, nunca medidas socioeducativas ou prisionais.',
 'ECA, arts. 101, 103 e 105',
 'medio'),

-- Q14: Inimputabilidade penal
(@cat_vu05,
 'A Inimputabilidade Penal do menor de 18 anos significa, tecnicamente, que:',
 'O menor é impune e não sofre qualquer consequência estatal por seus atos.',
 'O menor possui discernimento completo, mas o Estado renuncia ao direito de punir.',
 'O menor recebe tratamento diferenciado por ser pessoa em desenvolvimento, via legislação especial.',
 'O menor não pode ser objeto de abordagem policial nem de busca pessoal.',
 NULL,
 'C',
 'A alternativa C define corretamente a Doutrina da Proteção Integral adotada pelo ordenamento brasileiro. A alternativa A confunde inimputabilidade com impunidade, já que o adolescente responde por medida socioeducativa. A alternativa B erra ao pressupor discernimento completo como fundamento da inimputabilidade, quando na verdade o fundamento é a condição peculiar de pessoa em desenvolvimento. A alternativa D é falsa, pois a busca pessoal é permitida em caso de fundada suspeita, independentemente da idade do abordado.\n\n📜 Fundamento legal vigente: CRFB, art. 228: "São penalmente inimputáveis os menores de dezoito anos, sujeitos às normas da legislação especial." CP, art. 27, no mesmo sentido. A legislação especial referida é o ECA, que prevê medidas de proteção (crianças) e socioeducativas (adolescentes), e não a ausência de qualquer consequência jurídica.',
 'CRFB, art. 228; CP, art. 27; ECA',
 'medio'),

-- Q15: Comunicação da apreensão
(@cat_vu05,
 'A apreensão de um adolescente e o local onde se encontra recolhido devem ser comunicados imediatamente:',
 'Ao Conselho Tutelar, exclusivamente.',
 'À imprensa, para transparência da ação policial.',
 'À autoridade judiciária e à família do apreendido (ou pessoa indicada).',
 'Apenas após a lavratura do Boletim de Ocorrência, no prazo de 24 horas.',
 NULL,
 'C',
 'A alternativa C é uma garantia fundamental prevista expressamente no ECA. A alternativa A é insuficiente, pois a comunicação à autoridade judiciária é indispensável. A alternativa B viola o direito à imagem e à proteção da identidade do adolescente. A alternativa D viola a regra da imediaticidade, criando um prazo inexistente na lei.\n\n📜 Fundamento legal vigente: ECA, art. 107: "A apreensão de qualquer adolescente e o local onde se encontra recolhido serão incontinenti comunicados à autoridade judiciária competente e à família do apreendido ou à pessoa por ele indicada." O parágrafo único ainda determina o exame imediato da possibilidade de liberação, sob pena de responsabilidade.',
 'ECA, art. 107',
 'medio'),

-- Q16: Algemas em adolescentes
(@cat_vu05,
 'O uso de algemas em adolescentes, segundo a Súmula Vinculante 11 e o manual técnico:',
 'É obrigatório para garantir a segurança da guarnição em qualquer ocorrência.',
 'É proibido em todas as circunstâncias por ferir a dignidade do menor.',
 'É excepcional, devendo ser justificado por escrito em caso de perigo ou risco de fuga.',
 'É permitido apenas se o adolescente confessar a prática do ato infracional.',
 NULL,
 'C',
 'A alternativa C reflete o princípio da razoabilidade e da excepcionalidade que rege o uso de algemas. A alternativa A é ilegal, pois o uso obrigatório e indiscriminado contraria a excepcionalidade fixada pelo STF. A alternativa B ignora a necessidade de segurança do agente em casos concretos de risco. A alternativa D cria um requisito (confissão) inexistente tanto na Súmula quanto no ECA.\n\n📜 Fundamento legal vigente: Súmula Vinculante nº 11/STF: "Só é lícito o uso de algemas em caso de resistência e de fundado receio de fuga ou de perigo à integridade física própria ou alheia, por parte do preso ou de terceiros, justificada a excepcionalidade por escrito, sob pena de responsabilidade disciplinar civil e penal do agente ou da autoridade e de nulidade da prisão ou do ato processual a que se refere". O ECA não traz regra própria sobre algemas, mas a proteção integral do adolescente reforça a aplicação estrita dessa excepcionalidade.',
 'Súmula Vinculante 11/STF',
 'dificil'),

-- Q17: Transporte digno — art. 178 ECA
(@cat_vu05,
 'O Artigo 178 do ECA proíbe expressamente que o adolescente autor de ato infracional seja transportado:',
 'Em viaturas descaracterizadas.',
 'Em compartimento fechado (xadrez) de veículo policial.',
 'Sem a presença de um advogado constituído.',
 'Algemado aos pés e mãos simultaneamente.',
 NULL,
 'B',
 'A alternativa B é a proibição direta do ECA para evitar condições atentatórias à dignidade do adolescente durante o transporte. As alternativas A, C e D, embora tragam questões de segurança ou de direito, não são o foco da proibição específica do art. 178 citada no dispositivo legal.\n\n📜 Fundamento legal vigente: ECA, art. 178: "O adolescente a quem se atribua autoria de ato infracional não poderá ser conduzido ou transportado em compartimento fechado de veículo policial, em condições atentatórias à sua dignidade, ou que impliquem risco à sua integridade física ou mental." Texto literal e vigente.',
 'ECA, art. 178',
 'dificil'),

-- Q18: Racismo x Injúria Racial
(@cat_vu05,
 'Qual a distinção jurídica correta entre Racismo e Injúria Racial?',
 'O racismo é crime afiançável; a injúria racial é imprescritível.',
 'O racismo atinge a honra subjetiva; a injúria racial atinge a coletividade.',
 'O racismo atinge um número indeterminado de pessoas; a injúria atinge pessoa(s) determinada(s).',
 'Ambos possuem a mesma pena e são processados pelo mesmo artigo do Código Penal.',
 NULL,
 'C',
 'A alternativa C está correta conforme a Lei 7.716/89 e o Código Penal. A alternativa A inverte os conceitos, pois o racismo é inafiançável e imprescritível. A alternativa B inverte os objetos jurídicos protegidos por cada figura. A alternativa D ignora que, embora hoje ambos estejam na Lei 7.716/89, mantêm tipificações e penas distintas.\n\n📜 Fundamento legal vigente: Lei nº 7.716/1989 tipifica o racismo como conduta que atinge coletividade indeterminada (discriminação de raça/cor/etnia/religião/procedência nacional); o art. 2º-A da mesma lei (incluído pela Lei nº 14.532/2023) tipifica a injúria racial como ofensa à dignidade/decoro de pessoa determinada em razão de raça, cor, etnia ou procedência nacional, com pena de reclusão de 2 a 5 anos e multa, hoje também imprescritível e inafiançável por equiparação ao racismo.',
 'Lei 7.716/1989, art. 2º-A (redação da Lei 14.532/2023)',
 'medio'),

-- Q19: Linguagem discriminatória em rádio
(@cat_vu05,
 'O termo "elemento suspeito cor padrão", frequentemente ouvido em comunicações de rádio, é:',
 'Um termo técnico aceitável para agilizar a identificação de suspeitos.',
 'Uma expressão discriminatória que reforça preconceitos e deve ser abolida.',
 'Uma ferramenta de estatística criminal autorizada pela SENASP.',
 'Adequado, desde que o policial seja da mesma cor do suspeito.',
 NULL,
 'B',
 'A alternativa B segue a orientação do manual técnico sobre a inadequação total do termo nas comunicações operacionais. A alternativa A é falsa, pois a expressão fere a dignidade da pessoa humana e reforça estereótipos raciais. A alternativa C é mentirosa, não havendo autorização de órgão oficial para tal prática. A alternativa D ignora que o racismo institucional independe da cor do agente que o pratica.\n\n📜 Fundamento legal vigente: CRFB, art. 5º, XLII, considera o racismo crime inafiançável e imprescritível; a Lei nº 7.716/1989 veda condutas discriminatórias em razão de raça ou cor, inclusive as praticadas por agentes públicos no exercício da função, o que alcança comunicações operacionais discriminatórias.',
 'CRFB, art. 5º, XLII; Lei 7.716/1989',
 'medio'),

-- Q20: Efetivo mínimo — abordagem a cadeirante
(@cat_vu05,
 'Na abordagem a um cadeirante, o protocolo de segurança exige um efetivo mínimo de:',
 'Dois policiais: um para busca e outro para segurança.',
 'Três policiais: um para verbalizar, um para segurança e um para revista técnica.',
 'Quatro policiais: dois para segurar a cadeira e dois para a revista.',
 'Apenas um policial, para evitar que o cidadão se sinta intimidado.',
 NULL,
 'B',
 'A alternativa B apresenta o procedimento operacional padrão correto para garantir segurança e técnica na abordagem. As alternativas A e D comprometem a segurança da equipe por subdimensionamento do efetivo. A alternativa C representa uso excessivo e desnecessário de efetivo para o ato.\n\n📜 Fundamento legal vigente: trata-se de conceito doutrinário/protocolo operacional (POP) de abordagem a pessoas com deficiência, sem correspondência em dispositivo legal específico — o efetivo mínimo decorre de treinamento tático-policial, e não de norma jurídica.',
 'Doutrina técnica de abordagem policial (POP)',
 'medio'),

-- Q21: Revista em cadeirante
(@cat_vu05,
 'Durante a revista em cadeirante que não consegue se erguer, o Policial 3 deve:',
 'Inclinar a cadeira para trás até que o suspeito quase caia, facilitando a visão.',
 'Travar a roda com o pé, segurar o abordado pelos pulsos sob as axilas e erguê-lo.',
 'Exigir que o cadeirante se arraste para fora da cadeira por conta própria.',
 'Retirar o cadeirante da cadeira e colocá-lo deitado no solo.',
 NULL,
 'B',
 'A alternativa B descreve o procedimento que preserva a integridade física do abordado e permite que outro policial reviste o assento com segurança. A alternativa A é perigosa e pode causar lesões. A alternativa C é desumana e viola a dignidade da pessoa com deficiência. A alternativa D é desnecessária e traumática na maioria dos casos de abordagem administrativa comum.\n\n📜 Fundamento legal vigente: trata-se de conceito doutrinário/protocolo operacional (POP), sem correspondência em dispositivo legal específico, orientado pelo princípio geral da dignidade da pessoa humana (CRFB, art. 1º, III) e pela Lei Brasileira de Inclusão (Lei nº 13.146/2015), que veda tratamento degradante à pessoa com deficiência, sem detalhar, contudo, a técnica tática de revista.',
 'Doutrina técnica de abordagem policial (POP); CRFB, art. 1º, III',
 'dificil'),

-- Q22: Abordagem a deficiente auditivo
(@cat_vu05,
 'Ao realizar a busca pessoal em um deficiente auditivo (surdo), qual o procedimento tático para evitar uma reação de susto ou interpretação de agressão?',
 'Gritar ordens próximo ao ouvido do abordado para que ele sinta a vibração sonora.',
 'Tocar o ombro do abordado imediatamente, mesmo que ele esteja de costas.',
 'Segurar as mãos do indivíduo enquanto ele ainda está de lado e então virá-lo de costas.',
 'Utilizar a tonfa para manter a distância enquanto gesticula em LIBRAS.',
 NULL,
 'C',
 'A alternativa C é o detalhe técnico crucial para evitar que o surdo se assuste ao perder o contato visual com o agente. A alternativa A é inútil e potencialmente agressiva. A alternativa B pode gerar reação reflexiva de defesa por parte do abordado. A alternativa D é taticamente desnecessária se não houver indício de agressão.\n\n📜 Fundamento legal vigente: trata-se de conceito doutrinário/protocolo operacional (POP) de comunicação e segurança na abordagem a pessoas com deficiência auditiva, sem correspondência em dispositivo legal específico — decorre de treinamento tático, ainda que alinhado aos objetivos de acessibilidade e não discriminação da Lei Brasileira de Inclusão (Lei nº 13.146/2015).',
 'Doutrina técnica de abordagem policial (POP); Lei 13.146/2015',
 'medio'),

-- Q23: Identidade de gênero x orientação sexual
(@cat_vu05,
 'Sobre os conceitos de gênero e sexualidade, é correto afirmar:',
 'Identidade de gênero é o desejo afetivo; Orientação sexual é como a pessoa se sente.',
 'Identidade de gênero é a percepção subjetiva de si; Orientação sexual é a direção do desejo.',
 'Opção sexual é o termo técnico atual recomendado pela SENASP.',
 'Travestis são pessoas que necessariamente passaram por cirurgia de redesignação.',
 NULL,
 'B',
 'A alternativa B traz as definições tecnicamente corretas. A alternativa A inverte os conceitos de identidade de gênero e orientação sexual. A alternativa C está incorreta, pois o termo tecnicamente adequado é "orientação sexual", e não "opção sexual". A alternativa D é falsa, pois a identidade de gênero independe de intervenção cirúrgica.\n\n📜 Fundamento legal vigente: Decreto nº 8.727/2016, parágrafo único do art. 1º, define identidade de gênero como "a dimensão da identidade de uma pessoa que diz respeito à forma como se relaciona com as representações de masculinidade e feminilidade e que não está, necessariamente, determinada pelo sexo atribuído no nascimento". Trata-se de dispositivo federal (aplicável no âmbito da administração pública federal), utilizado por analogia como referência conceitual, já que a distinção com "orientação sexual" é essencialmente doutrinária.',
 'Decreto 8.727/2016, art. 1º, parágrafo único (referência conceitual)',
 'facil'),

-- Q24: Busca em travestis e mulheres transexuais
(@cat_vu05,
 'A busca pessoal em Travestis e Mulheres Transexuais deve ser realizada:',
 'Por policiais masculinos, respeitando o sexo biológico do registro civil.',
 'Prioritariamente por policiais femininas, respeitando a identidade de gênero.',
 'Apenas em delegacias, sendo proibida a revista em via pública.',
 'Por qualquer policial, desde que use luvas e não dialogue com a abordada.',
 NULL,
 'B',
 'A alternativa B respeita a dignidade e a identidade de gênero socialmente afirmada pela pessoa abordada. A alternativa A ignora os direitos humanos e a identidade de gênero em favor do puro dado biológico/registral. A alternativa C inviabilizaria a segurança pública, criando exigência não prevista em lei. A alternativa D é antiprofissional e desumanizada.\n\n📜 Fundamento legal vigente: CPP, art. 249 ("a busca em mulher será feita por outra mulher, salvo se isso importar retardamento ou prejuízo da diligência"), interpretado conforme o Decreto nº 8.727/2016, que reconhece a identidade de gênero autodeclarada de travestis e mulheres transexuais para fins de tratamento pela administração pública, orientando que a busca considere a identidade de gênero, e não apenas o registro civil.',
 'CPP, art. 249; Decreto 8.727/2016',
 'medio'),

-- Q25: Estatuto do Idoso — definição etária
(@cat_vu05,
 'O Estatuto do Idoso define como idosa a pessoa com idade igual ou superior a:',
 '65 anos.',
 '70 anos.',
 '60 anos.',
 '55 anos.',
 NULL,
 'C',
 'A alternativa C reflete a baliza etária legal brasileira vigente. As alternativas A, B e D estão em desacordo com o Estatuto do Idoso, que fixa parâmetro diverso.\n\n📜 Fundamento legal vigente: Lei nº 10.741/2003 (Estatuto do Idoso), art. 1º: "É instituído o Estatuto da Pessoa Idosa, destinado a regular os direitos assegurados às pessoas com idade igual ou superior a 60 (sessenta) anos." O parâmetro de 60 anos está vigente desde 2003, sem alteração legislativa posterior — não há divergência a esclarecer quanto a esse número.',
 'Estatuto do Idoso, art. 1º; Lei 10.741/2003',
 'facil'),

-- Q26: Abordagem a homem transexual
(@cat_vu05,
 'Ao abordar um Homem Transexual (identidade masculina, biológico feminino), o policial deve:',
 'Chamar pelo nome de registro e busca por policial masculino.',
 'Chamar pelo nome social e realizar a busca por policial feminina.',
 'Ignorar o nome social e realizar busca apenas em delegacia.',
 'Utilizar termos neutros e dispensar a busca se não houver fundada suspeita.',
 NULL,
 'B',
 'A alternativa B é a correta, pois o art. 249 do CPP exige policial feminina para a busca (evitando questionamentos quanto à literalidade do dispositivo), respeitando-se, ao mesmo tempo, o nome social do abordado em toda a interação verbal. A alternativa A viola tanto a identidade de gênero quanto a literalidade do CPP. A alternativa C é arbitrária e cria exigência não prevista em lei. A alternativa D descreve o padrão geral de fundada suspeita para qualquer cidadão, mas não resolve o dilema específico de quem deve conduzir a revista.\n\n📜 Fundamento legal vigente: CPP, art. 249 (busca por mulher, salvo urgência) c/c Decreto nº 8.727/2016, art. 1º (uso obrigatório do nome social e reconhecimento da identidade de gênero de pessoas trans e travestis no âmbito federal, usado por analogia como diretriz de tratamento digno na abordagem policial).',
 'CPP, art. 249; Decreto 8.727/2016, art. 1º',
 'dificil'),

-- Q27: Pessoa em situação de rua — mendicância
(@cat_vu05,
 'Durante patrulhamento, a guarnição avista um cidadão dormindo em uma praça pública sobre papelões e com diversos sacos de pertences. Com base no Decreto 7053/09, a conduta correta é:',
 'Remover o indivíduo e descartar os materiais para garantir a limpeza do logradouro.',
 'Abordar apenas se houver crime, tratando os pertences com cautela e sem descartá-los.',
 'Conduzir o indivíduo à delegacia pelo crime de vadiagem e mendicância.',
 'Obrigar o cidadão a entrar na viatura para ser levado a um abrigo municipal.',
 NULL,
 'B',
 'A alternativa B respeita o direito à livre locomoção e a propriedade dos pertences do cidadão em situação de rua. A alternativa A é ilegal e desumana. A alternativa C é incorreta pois a mendicância foi descriminalizada em 2009, deixando de ser contravenção penal. A alternativa D viola o direito de escolha do cidadão quanto ao acolhimento institucional, que deve ser voluntário.\n\n📜 Fundamento legal vigente: Lei nº 11.983/2009 revogou o art. 60 do Decreto-Lei nº 3.688/1941 (LCP), que tipificava a mendicância como contravenção penal — desde 16/07/2009, mendigar não é mais infração penal. O Decreto nº 7.053/2009 (Política Nacional para a População em Situação de Rua) reforça o respeito à dignidade, à propriedade dos pertences e à voluntariedade do acolhimento institucional dessa população.',
 'Lei 11.983/2009 (revoga art. 60 da LCP); Decreto 7.053/2009',
 'medio'),

-- Q28: Lei 9.807/99 — quem NÃO pode ser beneficiário
(@cat_vu05,
 'Sobre a Lei 9.807/99 (Proteção a Vítimas e Testemunhas), assinale quem NÃO pode ser beneficiário do programa:',
 'Familiares que convivam com a testemunha coagida.',
 'Vítimas de crimes expostas a grave ameaça.',
 'Indiciados ou acusados sob prisão cautelar.',
 'Cônjuges ou companheiros da vítima protegida.',
 NULL,
 'C',
 'A alternativa C está correta conforme as vedações legais expressas do programa. As alternativas A, B e D apresentam pessoas que, por lei, podem ser incluídas no programa ou ter a proteção estendida a elas por conviverem habitualmente com a vítima/testemunha.\n\n📜 Fundamento legal vigente: Lei nº 9.807/1999, art. 2º, §1º, estende a proteção a cônjuge/companheiro, ascendentes, descendentes e dependentes que tenham convivência habitual com a vítima/testemunha; o §2º do mesmo artigo exclui do programa "aqueles cuja personalidade ou conduta seja incompatível com as restrições de comportamento exigidas pelo programa, os condenados que estejam cumprindo pena e os indiciados ou acusados sob prisão cautelar em qualquer de suas modalidades".',
 'Lei 9.807/1999, art. 2º, §§1º e 2º',
 'medio'),

-- Q29: Dependência química — conceito clínico
(@cat_vu05,
 'Um indivíduo que apresenta perda de controle sobre o consumo, necessidade de doses maiores (tolerância) e sente mal-estar físico na ausência da droga está em quadro de:',
 'Uso ocasional ou recreativo.',
 'Abuso esporádico de substâncias.',
 'Dependência química.',
 'Uso social moderado.',
 NULL,
 'C',
 'A alternativa C define corretamente os sintomas clínicos característicos da Dependência Química. As alternativas A e D referem-se a padrões de uso sem prejuízo funcional grave associado. A alternativa B foca na quantidade/frequência do consumo, mas a tolerância e a síndrome de abstinência (fissura) são marcos clínicos específicos da dependência, e não do abuso esporádico.\n\n📜 Fundamento legal vigente: trata-se de conceito técnico-clínico (critérios diagnósticos de dependência química, correlatos aos manuais internacionais de saúde como a CID-11/OMS), sem correspondência em dispositivo legal específico — a Lei nº 11.343/2006 trata das consequências jurídicas do porte/uso, mas não define clinicamente o que é dependência.',
 'Conceito técnico-clínico (sem correspondência legal específica); Lei 11.343/2006 (consequências jurídicas)',
 'medio'),

-- Q30: Porte para consumo pessoal — Lei 11.343/06
(@cat_vu05,
 'Policial aborda indivíduo portando 2 gramas de substância análoga à maconha. O indivíduo afirma ser para consumo próprio. Com base na Lei 11.343/06:',
 'O policial deve dar voz de prisão e conduzir ao presídio imediatamente.',
 'O caso deve ser encaminhado ao Juizado Especial; a lei não prevê pena de prisão para o usuário.',
 'A substância deve ser devolvida se o indivíduo provar que é dependente.',
 'O usuário deve ser tratado como traficante se for abordado em local de "pista".',
 NULL,
 'B',
 'A alternativa B reflete a despenalização (não a descriminalização integral) do porte para uso pessoal trazida pela Lei de Drogas. A alternativa A ignora a nova Lei de Drogas, que não prevê prisão para o usuário. A alternativa C é ilegal, pois a droga é sempre apreendida, independentemente de o agente ser ou não dependente. A alternativa D cria um critério geográfico isolado inexistente na lei para a tipificação de tráfico.\n\n📜 Fundamento legal vigente: Lei nº 11.343/2006, art. 28: quem adquire, guarda, tem em depósito, transporta ou traz consigo, para consumo pessoal, drogas sem autorização legal, sujeita-se às penas de "I - advertência sobre os efeitos das drogas; II - prestação de serviços à comunidade; III - medida educativa de comparecimento a programa ou curso educativo" — sem qualquer hipótese de prisão. O art. 28, §2º, estabelece os critérios (natureza/quantidade da substância, local e condições da ação, circunstâncias sociais e pessoais, conduta e antecedentes) para diferenciar uso de tráfico, não havendo critério geográfico isolado.',
 'Lei 11.343/2006, art. 28 e §2º',
 'dificil');

SET foreign_key_checks = 1;
