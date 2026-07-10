-- ============================================================
-- QUIZ — Disciplina 13/20 do CHO: Improbidade Administrativa
-- 30 questões — Lei nº 8.429/1992 (LIA), com as profundas alterações da Lei nº 14.230/2021
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Eixos centrais: extinção da modalidade culposa em todas as categorias de atos de
--   improbidade; exigência de dolo específico (arts. 9º, 10 e 11); taxatividade do rol
--   de violação a princípios (art. 11) e supressão do dever de "lealdade às instituições";
--   extinção da suspensão de direitos políticos para a categoria de princípios (art. 12,
--   III); novos prazos máximos de suspensão de direitos políticos (até 14 anos no
--   enriquecimento ilícito e até 12 anos no prejuízo ao erário); sujeitos ativos e
--   passivos (agente público, terceiro, entidades privadas beneficiárias); sucessão
--   empresarial (fusão/incorporação); responsabilização de pessoas jurídicas e vedação
--   ao bis in idem com a Lei Anticorrupção (Lei 12.846/2013); medida cautelar de
--   indisponibilidade de bens (proteção de até 40 salários mínimos e do bem de família).
-- Fonte: Improbidade Administrativa.pdf — Academia Coronel Walterler (30 questões com
--   gabarito e justificativa de professor), reformatadas para o padrão do Quiz PMRR e
--   enriquecidas com fundamentação legal vigente pesquisada diretamente no texto
--   compilado da Lei 8.429/1992 no Portal da Legislação (Planalto).
-- Legislação de referência baixada em:
--   legislacao/Lei_8429_1992_ImprobidadeAdministrativa_atualizada.html
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Improbidade Administrativa — CHO 13', 'Disciplina 13/20 do CHO — Lei 8.429/1992 (LIA) com as alterações da Lei 14.230/2021: dolo específico, categorias de atos de improbidade (enriquecimento ilícito, prejuízo ao erário e violação a princípios), sujeitos, sanções, prazos e responsabilização de pessoas jurídicas');

SET @cat_ia13 = (SELECT id FROM categorias WHERE nome = 'Improbidade Administrativa — CHO 13' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Conceito atual de dolo na LIA
(@cat_ia13,
 'Conforme a atual redação da Lei de Improbidade Administrativa, o elemento subjetivo dolo é definido como a vontade livre e consciente de alcançar o resultado ilícito. Sobre sua configuração, assinale a alternativa correta:',
 'Para a tipificação, basta a demonstração da voluntariedade do agente na prática da conduta.',
 'O dolo exige a finalidade específica de obter proveito indevido, não sendo suficiente a mera voluntariedade.',
 'O dolo genérico permanece como requisito suficiente para os atos de prejuízo ao erário.',
 'Admite-se a modalidade culposa quando o erro for derivado de negligência grave na gestão pública.',
 NULL,
 'B',
 'A alternativa B está correta: a Lei 14.230/2021 redefiniu o dolo como a vontade livre e consciente de alcançar o resultado ilícito, exigindo mais do que a simples voluntariedade da conduta — é necessário o propósito de alcançar o resultado ilícito tipificado, o chamado dolo específico, hoje exigido em todas as modalidades de improbidade. A alternativa A está incorreta porque a mera voluntariedade do agente, sem a vontade dirigida ao resultado ilícito, não basta para a tipificação — foi exatamente esse ponto que a reforma de 2021 alterou. A alternativa C está incorreta porque o "dolo genérico" (vontade de praticar a conduta, independentemente do resultado) não é mais suficiente para nenhuma categoria de improbidade, inclusive o prejuízo ao erário, que também passou a exigir dolo. A alternativa D está incorreta porque a modalidade culposa foi expressamente extinta pela Lei 14.230/2021 para todas as categorias de atos de improbidade, inclusive as que antes a admitiam.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 1º, §2º (incluído pela Lei nº 14.230/2021): "Considera-se dolo a vontade livre e consciente de alcançar o resultado ilícito tipificado nos arts. 9º, 10 e 11 desta Lei, não bastando a voluntariedade do agente."',
 'Lei 8.429/1992, art. 1º, §2º, na redação da Lei 14.230/2021',
 'medio'),

-- Q02: Excludente de responsabilidade — mero exercício da função
(@cat_ia13,
 'No exercício da função pública, o agente pode deparar-se com situações de responsabilidade administrativa. Segundo a Lei de Improbidade Administrativa, o afastamento da responsabilidade ocorre quando:',
 'O agente atua culposamente, sem a intenção de lesar o erário, mas com evidente erro de julgamento.',
 'Houver mero exercício da função ou desempenho de competências, sem prova de ato doloso com fim ilícito.',
 'A conduta violar princípios, mas não gerar enriquecimento ilícito ao agente ou a terceiros.',
 'O agente comprovar que seguiu ordens verbais de superior hierárquico, independentemente da legalidade do ato.',
 NULL,
 'B',
 'A alternativa B está correta: o mero exercício da função ou desempenho de competências públicas, sem a comprovação de ato doloso com fim ilícito, afasta a responsabilidade por improbidade administrativa. A alternativa A está incorreta porque, embora a culpa não gere mais responsabilidade por improbidade, a excludente legal não se limita à ausência de "intenção de lesar o erário": ela exige, positivamente, que não haja prova de dolo com fim ilícito. A alternativa C está incorreta porque a violação a princípios é categoria autônoma de improbidade e, se dolosa, configura o ilícito independentemente de haver enriquecimento do agente ou de terceiros. A alternativa D está incorreta porque a lei não prevê a obediência a ordens verbais como excludente de responsabilidade — a legalidade do ato praticado continua sendo o critério determinante.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 1º, §3º (incluído pela Lei nº 14.230/2021): "O mero exercício da função ou desempenho de competências públicas, sem comprovação de ato doloso com fim ilícito, afasta a responsabilidade por ato de improbidade administrativa."',
 'Lei 8.429/1992, art. 1º, §3º, na redação da Lei 14.230/2021',
 'medio'),

-- Q03: Sujeitos passivos — entidades privadas beneficiárias
(@cat_ia13,
 'Sobre os sujeitos passivos e a abrangência da Lei de Improbidade Administrativa, assinale a alternativa correta:',
 'A lei aplica-se exclusivamente aos atos contra o patrimônio da administração pública direta.',
 'Estão excluídos da proteção da LIA os atos praticados contra entidades privadas que recebam benefícios fiscais.',
 'A lei abrange atos contra o patrimônio de entidade privada que receba subvenção ou incentivo fiscal de entes públicos.',
 'O ressarcimento ao erário é ilimitado em casos de entidades para cuja criação o Estado concorreu com menos de 50% do patrimônio.',
 NULL,
 'C',
 'A alternativa C está correta: a lei estende sua proteção às entidades privadas que recebam subvenção, benefício ou incentivo, fiscal ou creditício, de órgão público. A alternativa A está incorreta porque a LIA abrange também a administração indireta, a administração fundacional e as entidades privadas beneficiárias de recursos públicos, e não apenas a administração direta. A alternativa B inverte o sentido da regra: tais entidades não estão excluídas, mas sim expressamente incluídas na proteção legal. A alternativa D está incorreta porque, nas hipóteses em que o erário concorreu com menos de 50% do patrimônio ou da receita anual da entidade, a própria lei limita a sanção patrimonial à repercussão do ilícito sobre a contribuição dos cofres públicos — não se trata de ressarcimento ilimitado.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 1º, §6º (incluído pela Lei nº 14.230/2021): "Estão sujeitos às sanções desta Lei os atos de improbidade praticados contra o patrimônio de entidade privada que receba subvenção, benefício ou incentivo, fiscal ou creditício, de entes públicos ou governamentais [...]". O art. 1º, parágrafo único (redação original), já limitava a sanção patrimonial, nesses casos, "à repercussão do ilícito sobre a contribuição dos cofres públicos".',
 'Lei 8.429/1992, art. 1º, §6º, na redação da Lei 14.230/2021',
 'medio'),

-- Q04: Extensão da LIA a terceiros
(@cat_ia13,
 'Quanto à aplicação das disposições da Lei de Improbidade Administrativa a terceiros (particulares), assinale a alternativa que reflete a regra atualizada:',
 'Aplicam-se ao terceiro que, mesmo não sendo agente público, induza ou concorra dolosamente para o ato.',
 'O terceiro responde solidariamente mesmo em casos de conduta culposa que gere dano ao erário.',
 'A responsabilidade do terceiro é objetiva quando houver benefício patrimonial direto.',
 'O particular só responde se o ato de improbidade importar obrigatoriamente em enriquecimento ilícito.',
 NULL,
 'A',
 'A alternativa A está correta: a lei estende-se ao terceiro, mesmo não sendo agente público, que induza ou concorra dolosamente para a prática do ato de improbidade. A alternativa B está incorreta porque a Lei 14.230/2021 extinguiu a modalidade culposa também para terceiros, exigindo dolo para sua responsabilização. A alternativa C está incorreta porque a responsabilidade do terceiro não é objetiva: exige-se a demonstração de que ele induziu ou concorreu dolosamente para o ato. A alternativa D está incorreta porque a extensão da lei ao terceiro não se limita à categoria de enriquecimento ilícito, podendo alcançar qualquer das categorias de improbidade, desde que presente o induzimento ou concurso doloso.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 3º, caput (redação dada pela Lei nº 14.230/2021): "As disposições desta Lei são aplicáveis, no que couber, àquele que, mesmo não sendo agente público, induza ou concorra dolosamente para a prática do ato de improbidade."',
 'Lei 8.429/1992, art. 3º, caput, na redação da Lei 14.230/2021',
 'facil'),

-- Q05: Responsabilização de sócios, diretores e colaboradores de PJ
(@cat_ia13,
 'Sobre a responsabilização de pessoas jurídicas de direito privado e seus integrantes, assinale a alternativa correta:',
 'Sócios e diretores respondem objetivamente por qualquer ato de improbidade imputado à pessoa jurídica.',
 'Sócios e colaboradores não respondem pelo ato imputado à PJ, salvo se houver participação e benefícios diretos.',
 'A responsabilidade dos dirigentes é solidária e ilimitada, independentemente da prova de proveito pessoal.',
 'A sanção de proibição de contratar atinge automaticamente todos os sócios cotistas da empresa sancionada.',
 NULL,
 'B',
 'A alternativa B está correta: sócios, cotistas, diretores e colaboradores de pessoa jurídica de direito privado não respondem, em regra, pelo ato de improbidade imputado à pessoa jurídica, salvo se comprovadamente houver participação e benefícios diretos, hipótese em que responderão nos limites de sua participação. A alternativa A está incorreta porque não há responsabilidade objetiva desses integrantes: a lei exige a comprovação de participação e benefício direto no ato. A alternativa C está incorreta pelo mesmo motivo — a responsabilidade não é solidária e ilimitada, mas limitada à participação de cada integrante, mediante prova de benefício direto. A alternativa D está incorreta porque a sanção não atinge automaticamente todos os cotistas, sendo necessária a individualização da participação e do proveito de cada um.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 3º, §1º (incluído pela Lei nº 14.230/2021): "Os sócios, os cotistas, os diretores e os colaboradores de pessoa jurídica de direito privado não respondem pelo ato de improbidade que venha a ser imputado à pessoa jurídica, salvo se, comprovadamente, houver participação e benefícios diretos, caso em que responderão nos limites da sua participação."',
 'Lei 8.429/1992, art. 3º, §1º, na redação da Lei 14.230/2021',
 'medio'),

-- Q06: Vedação ao bis in idem com a Lei Anticorrupção
(@cat_ia13,
 'Buscando evitar o bis in idem, a Lei 14.230/2021 estabeleceu uma regra de exclusão para sanções de pessoas jurídicas. Assinale-a:',
 'As sanções da LIA aplicam-se cumulativamente às da Lei Anticorrupção (Lei 12.846/2013) em todos os casos.',
 'A PJ não será sancionada pela LIA se o ato for também sancionado como ato lesivo pela Lei Anticorrupção.',
 'A multa civil da LIA deve ser descontada do valor do ressarcimento ao erário fixado na esfera penal.',
 'O acordo de leniência na Lei Anticorrupção impede qualquer investigação por improbidade administrativa.',
 NULL,
 'B',
 'A alternativa B está correta: as sanções da LIA não se aplicarão à pessoa jurídica caso o mesmo ato já tenha sido sancionado como ato lesivo à administração pública pela Lei Anticorrupção (Lei 12.846/2013), evitando-se a dupla punição pelo mesmo fato. A alternativa A está incorreta porque descreve exatamente o oposto da regra: a lei veda a cumulação, não a autoriza. A alternativa C está incorreta porque a regra de dedução prevista na lei refere-se ao ressarcimento do dano ao patrimônio público apurado nas instâncias criminal, civil e administrativa sobre os mesmos fatos, e não a um desconto automático da multa civil a partir de valor fixado na esfera penal. A alternativa D está incorreta porque o acordo de leniência não impede a investigação por improbidade — ele pode repercutir nas sanções aplicáveis, mas não paralisa a apuração dos fatos.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 3º, §2º (incluído pela Lei nº 14.230/2021): "As sanções desta Lei não se aplicarão à pessoa jurídica, caso o ato de improbidade administrativa seja também sancionado como ato lesivo à administração pública de que trata a Lei nº 12.846, de 1º de agosto de 2013."',
 'Lei 8.429/1992, art. 3º, §2º, na redação da Lei 14.230/2021',
 'medio'),

-- Q07: Divergência interpretativa não configura improbidade
(@cat_ia13,
 'Considere a situação em que um Oficial da Polícia Militar toma uma decisão baseada em interpretação da lei fundamentada em jurisprudência não pacificada. Segundo a Lei de Improbidade Administrativa:',
 'Configura-se ato de improbidade, pois o agente deve aguardar a pacificação dos tribunais superiores.',
 'Não configura improbidade a ação decorrente de divergência interpretativa baseada em jurisprudência, ainda que não pacificada.',
 'A divergência interpretativa só afasta a responsabilidade se for confirmada por parecer do Ministério Público.',
 'Trata-se de dolo genérico, passível de punição apenas na modalidade de violação aos princípios.',
 NULL,
 'B',
 'A alternativa B está correta: a lei protege expressamente o agente público em casos de divergência interpretativa baseada em jurisprudência, ainda que não pacificada, mesmo que essa interpretação não venha a prevalecer posteriormente nas decisões dos órgãos de controle ou dos tribunais. A alternativa A está incorreta porque contraria frontalmente essa excludente legal, que dispensa a espera pela pacificação jurisprudencial. A alternativa C está incorreta porque a lei não condiciona o afastamento da responsabilidade a parecer do Ministério Público — a excludente decorre diretamente do texto legal. A alternativa D está incorreta porque a hipótese sequer chega a configurar dolo, genérico ou específico, já que a lei afasta a própria caracterização da improbidade nesse cenário.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 1º, §8º (incluído pela Lei nº 14.230/2021): "Não configura improbidade a ação ou omissão decorrente de divergência interpretativa da lei, baseada em jurisprudência, ainda que não pacificada, mesmo que não venha a ser posteriormente prevalecente nas decisões dos órgãos de controle ou dos tribunais do Poder Judiciário."',
 'Lei 8.429/1992, art. 1º, §8º, na redação da Lei 14.230/2021',
 'facil'),

-- Q08: Sucessão empresarial — fusão e incorporação
(@cat_ia13,
 'A respeito da sucessão por atos de improbidade, em casos de fusão e incorporação, a responsabilidade da sucessora:',
 'É integral e abrange todas as sanções previstas na Lei de Improbidade.',
 'É restrita à reparação integral do dano, até o limite do patrimônio transferido, salvo em caso de fraude.',
 'Não se aplica quando a sucessora for pessoa jurídica de direito privado sem fins lucrativos.',
 'Extingue-se automaticamente após transcorridos 2 anos da data da fusão ou incorporação.',
 NULL,
 'B',
 'A alternativa B está correta: nas hipóteses de fusão e incorporação, a responsabilidade da sucessora restringe-se à obrigação de reparação integral do dano causado, até o limite do patrimônio transferido, não lhe sendo aplicáveis as demais sanções da lei relativas a atos e fatos anteriores à fusão ou incorporação, exceto em caso de simulação ou evidente intuito de fraude devidamente comprovados. A alternativa A está incorreta porque contraria essa limitação legal expressa, que afasta a aplicação das demais sanções (como perda de função pública ou suspensão de direitos políticos) à sucessora. A alternativa C está incorreta porque a lei não prevê essa exceção em razão da natureza da pessoa jurídica sucessora. A alternativa D está incorreta porque não há previsão de extinção automática da responsabilidade sucessória por decurso de prazo de dois anos.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 8º-A, parágrafo único (incluído pela Lei nº 14.230/2021): "Nas hipóteses de fusão e de incorporação, a responsabilidade da sucessora será restrita à obrigação de reparação integral do dano causado, até o limite do patrimônio transferido, não lhe sendo aplicáveis as demais sanções previstas nesta Lei decorrentes de atos e de fatos ocorridos antes da data da fusão ou da incorporação, exceto no caso de simulação ou de evidente intuito de fraude, devidamente comprovados."',
 'Lei 8.429/1992, art. 8º-A, parágrafo único, na redação da Lei 14.230/2021',
 'dificil'),

-- Q09: Enriquecimento ilícito — declaração falsa sobre dado técnico
(@cat_ia13,
 'Constitui ato de improbidade administrativa que importa enriquecimento ilícito:',
 'Facilitar a incorporação de bem público ao patrimônio de outrem por imprudência ou negligência.',
 'Receber vantagem econômica para fazer declaração falsa sobre dado técnico que envolva obras públicas.',
 'Deixar de prestar contas dolosamente para ocultar o uso indevido de verbas de convênio.',
 'Frustrar a licitude de processo licitatório, acarretando perda patrimonial efetiva ao ente federado.',
 NULL,
 'B',
 'A alternativa B está correta: a lei tipifica expressamente, como enriquecimento ilícito, receber vantagem econômica de qualquer natureza, direta ou indireta, para fazer declaração falsa sobre qualquer dado técnico que envolva obras públicas ou outro serviço, ou sobre quantidade, peso, medida, qualidade ou característica de mercadorias ou bens fornecidos à administração. A alternativa A está incorreta porque descreve uma conduta culposa ("imprudência ou negligência"), modalidade extinta pela reforma de 2021 para todas as categorias de improbidade. A alternativa C está incorreta porque deixar de prestar contas dolosamente é conduta tipificada como violação aos princípios da administração pública, e não como enriquecimento ilícito. A alternativa D está incorreta porque frustrar licitação com perda patrimonial efetiva é hipótese de prejuízo ao erário, categoria distinta do enriquecimento ilícito.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 9º, VI (redação dada pela Lei nº 14.230/2021): "receber vantagem econômica de qualquer natureza, direta ou indireta, para fazer declaração falsa sobre qualquer dado técnico que envolva obras públicas ou qualquer outro serviço ou sobre quantidade, peso, medida, qualidade ou característica de mercadorias ou bens fornecidos a qualquer das entidades referidas no art. 1º desta Lei."',
 'Lei 8.429/1992, art. 9º, VI, na redação da Lei 14.230/2021',
 'medio'),

-- Q10: Prejuízo ao erário — requisito fundamental pós-reforma
(@cat_ia13,
 'Sobre a tipificação do prejuízo ao erário, assinale a alternativa que apresenta o requisito fundamental introduzido pela reforma de 2021:',
 'A conduta pode ser dolosa ou culposa, bastando que haja o desvio de finalidade.',
 'Exige-se ação ou omissão dolosa que enseje perda patrimonial efetiva e comprovada.',
 'O dano pode ser presumido (in re ipsa), dispensando a prova do prejuízo material.',
 'A mera inobservância de formalidades legais configura o tipo, independentemente de perda financeira.',
 NULL,
 'B',
 'A alternativa B está correta: o prejuízo ao erário passou a exigir ação ou omissão dolosa que enseje, efetiva e comprovadamente, perda patrimonial, desvio, apropriação, malbaratamento ou dilapidação dos bens ou haveres da administração. A alternativa A está incorreta porque a modalidade culposa foi extinta também para essa categoria de improbidade. A alternativa C está incorreta porque o dano presumido (in re ipsa) foi superado pela exigência de comprovação efetiva do prejuízo patrimonial. A alternativa D está incorreta porque a própria lei ressalva que, quando a inobservância de formalidades legais ou regulamentares não implicar perda patrimonial efetiva, não haverá imposição de ressarcimento, o que afasta a configuração automática do tipo.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 10, caput (redação dada pela Lei nº 14.230/2021): "Constitui ato de improbidade administrativa que causa lesão ao erário qualquer ação ou omissão dolosa, que enseje, efetiva e comprovadamente, perda patrimonial, desvio, apropriação, malbaratamento ou dilapidação dos bens ou haveres das entidades referidas no art. 1º desta Lei [...]". O §1º do mesmo artigo complementa: "Nos casos em que a inobservância de formalidades legais ou regulamentares não implicar perda patrimonial efetiva, não ocorrerá imposição de ressarcimento [...]".',
 'Lei 8.429/1992, art. 10, caput e §1º, na redação da Lei 14.230/2021',
 'medio'),

-- Q11: Fraude em licitação — exigência de perda patrimonial efetiva
(@cat_ia13,
 'A respeito da fraude em processos licitatórios ou seletivos, é correto afirmar:',
 'Configura ato contra princípios, independentemente da ocorrência de dano material.',
 'Configura lesão ao erário apenas se a conduta acarretar perda patrimonial efetiva.',
 'O dolo é dispensável se ficar provado que o agente beneficiou empresa de fachada.',
 'A sanção aplicável é a multa civil de até 100 vezes o valor da remuneração do agente.',
 NULL,
 'B',
 'A alternativa B está correta: a fraude à licitude de processo licitatório ou de processo seletivo para celebração de parcerias com entidades sem fins lucrativos, ou sua indevida dispensa, somente configura lesão ao erário se acarretar perda patrimonial efetiva — exigência incluída pela reforma de 2021. A alternativa A está incorreta porque, tipificada nesses termos no art. 10, a conduta exige, sim, a ocorrência de dano material efetivo; sem ele, a fraude licitatória pode eventualmente ser reconduzida à categoria de violação a princípios, mas não se confunde automaticamente com ela. A alternativa C está incorreta porque o dolo é elemento indispensável em todas as categorias de improbidade, inclusive quando há benefício a empresa de fachada. A alternativa D está incorreta porque a multa civil de até 100 vezes a remuneração era a sanção prevista na redação anterior para a violação a princípios (art. 11), hoje reduzida a até 24 vezes — e não se aplica à hipótese de prejuízo ao erário por fraude licitatória.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 10, VIII (redação dada pela Lei nº 14.230/2021): "frustrar a licitude de processo licitatório ou de processo seletivo para celebração de parcerias com entidades sem fins lucrativos, ou dispensá-los indevidamente, acarretando perda patrimonial efetiva."',
 'Lei 8.429/1992, art. 10, VIII, na redação da Lei 14.230/2021',
 'dificil'),

-- Q12: Perda patrimonial decorrente da atividade econômica
(@cat_ia13,
 'De acordo com a Lei de Improbidade Administrativa, a perda patrimonial decorrente da atividade econômica:',
 'Caracteriza sempre ato de improbidade, pela falta do dever de eficiência do gestor.',
 'Não acarretará improbidade administrativa, salvo se comprovado ato doloso praticado com essa finalidade.',
 'Só afasta a responsabilidade se o agente público possuir autorização expressa do Conselho de Ética.',
 'É punida exclusivamente com a perda dos bens e valores acrescidos ilicitamente.',
 NULL,
 'B',
 'A alternativa B está correta: a mera perda patrimonial decorrente do risco inerente à atividade econômica não acarreta improbidade administrativa, salvo se restar comprovado ato doloso praticado com essa finalidade específica de causar o dano. A alternativa A está incorreta porque a lei afasta expressamente a responsabilização automática, reconhecendo que a atividade econômica envolve risco legítimo de perdas. A alternativa C está incorreta porque a excludente não depende de qualquer autorização de órgão de ética, decorrendo diretamente da ausência de dolo. A alternativa D está incorreta porque, não havendo dolo, sequer há improbidade a ser sancionada — a perda dos bens acrescidos é sanção do art. 9º, aplicável a outra hipótese (enriquecimento ilícito).\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 10, §2º (incluído pela Lei nº 14.230/2021): "A mera perda patrimonial decorrente da atividade econômica não acarretará improbidade administrativa, salvo se comprovado ato doloso praticado com essa finalidade."',
 'Lei 8.429/1992, art. 10, §2º, na redação da Lei 14.230/2021',
 'facil'),

-- Q13: Taxatividade do rol de violação a princípios
(@cat_ia13,
 'Com a redação da Lei 14.230/2021, o rol de condutas que atentam contra os princípios da administração pública sofreu alterações estruturais profundas. Assinale a alternativa correta:',
 'O rol de condutas permaneceu exemplificativo, mantendo-se aberto a novas hipóteses por analogia.',
 'O dever de "lealdade às instituições" permanece como hipótese autônoma de improbidade.',
 'O rol de condutas passou a ser taxativo, e o dever de "lealdade às instituições" foi suprimido do texto.',
 'Admite-se a punição por violação a princípios mediante a demonstração de dolo genérico.',
 NULL,
 'C',
 'A alternativa C está correta: a reforma de 2021 tornou taxativo o rol de condutas que atentam contra os princípios da administração pública, caracterizando-o por "uma das seguintes condutas" (fechando a lista), e suprimiu do caput do dispositivo o dever de "lealdade às instituições", mantendo apenas os deveres de honestidade, imparcialidade e legalidade. A alternativa A está incorreta porque descreve a sistemática anterior à reforma, quando o advérbio "notadamente" indicava rol meramente exemplificativo. A alternativa B está incorreta porque a "lealdade às instituições" foi expressamente retirada do texto do caput. A alternativa D está incorreta porque essa categoria de improbidade exige dolo específico — o fim de obter proveito ou benefício indevido para si ou para outrem —, e não mero dolo genérico.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, caput (redação dada pela Lei nº 14.230/2021): "Constitui ato de improbidade administrativa que atenta contra os princípios da administração pública a ação ou omissão dolosa que viole os deveres de honestidade, de imparcialidade e de legalidade, caracterizada por uma das seguintes condutas [...]" — em contraste com a redação original, que continha a expressão "notadamente" e mencionava também a "lealdade às instituições".',
 'Lei 8.429/1992, art. 11, caput, na redação da Lei 14.230/2021',
 'dificil'),

-- Q14: Negar publicidade aos atos oficiais
(@cat_ia13,
 'No que concerne ao ato de negar publicidade aos atos oficiais:',
 'É ato de improbidade absoluto, não admitindo exceções baseadas na segurança da sociedade.',
 'Constitui ato de improbidade, exceto se houver imprescindibilidade para a segurança da sociedade e do Estado.',
 'Trata-se de conduta tipificada como enriquecimento ilícito, devido ao ganho político do agente.',
 'Só é punível se houver prova de enriquecimento ilícito do agente que ocultou a informação.',
 NULL,
 'B',
 'A alternativa B está correta: negar publicidade aos atos oficiais constitui, em regra, ato de improbidade que atenta contra os princípios da administração pública, mas a própria lei ressalva as hipóteses em que essa negativa é imprescindível para a segurança da sociedade e do Estado, ou outras hipóteses instituídas em lei. A alternativa A está incorreta por ignorar essa ressalva expressa. A alternativa C está incorreta porque a conduta está tipificada na categoria de violação a princípios, e não na de enriquecimento ilícito. A alternativa D está incorreta porque essa categoria de improbidade independe da comprovação de enriquecimento ilícito do agente, bastando a violação dolosa dos deveres de honestidade, imparcialidade e legalidade com o fim de obter proveito indevido.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, IV (redação dada pela Lei nº 14.230/2021): "negar publicidade aos atos oficiais, exceto em razão de sua imprescindibilidade para a segurança da sociedade e do Estado ou de outras hipóteses instituídas em lei."',
 'Lei 8.429/1992, art. 11, IV, na redação da Lei 14.230/2021',
 'medio'),

-- Q15: Nepotismo — grau de parentesco e nepotismo cruzado
(@cat_ia13,
 'Sobre a configuração do nepotismo como ato de improbidade, assinale a alternativa correta:',
 'A vedação alcança a nomeação de parentes em linha reta, colateral ou por afinidade, até o quarto grau.',
 'O ajuste mediante designações recíprocas (nepotismo cruzado) não é abrangido pela tipificação da LIA.',
 'É ato de improbidade a nomeação de parente até o terceiro grau, inclusive para cargos em comissão ou funções gratificadas.',
 'A mera nomeação política por detentores de mandato eletivo configura improbidade, independentemente de dolo.',
 NULL,
 'C',
 'A alternativa C está correta: a lei tipifica como ato de improbidade nomear cônjuge, companheiro ou parente em linha reta, colateral ou por afinidade, até o terceiro grau, inclusive, da autoridade nomeante ou de servidor investido em cargo de direção, chefia ou assessoramento, para cargo em comissão, função de confiança ou função gratificada. A alternativa A está incorreta porque o limite legal é o terceiro grau, e não o quarto — distrator clássico baseado em outras legislações que adotam parâmetro diverso. A alternativa B está incorreta porque a própria lei abrange expressamente "o ajuste mediante designações recíprocas", ou seja, o nepotismo cruzado. A alternativa D está incorreta porque a lei prevê justamente o contrário: não se configura improbidade na mera nomeação ou indicação política de detentores de mandato eletivo, sendo necessária a aferição de dolo com finalidade ilícita.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, XI (incluído pela Lei nº 14.230/2021): "nomear cônjuge, companheiro ou parente em linha reta, colateral ou por afinidade, até o terceiro grau, inclusive, da autoridade nomeante ou de servidor da mesma pessoa jurídica investido em cargo de direção, chefia ou assessoramento, para o exercício de cargo em comissão ou de confiança ou, ainda, de função gratificada [...], compreendido o ajuste mediante designações recíprocas."',
 'Lei 8.429/1992, art. 11, XI, na redação da Lei 14.230/2021',
 'medio'),

-- Q16: Dolo específico exigido na violação a princípios (Convenção da ONU)
(@cat_ia13,
 'Para a caracterização de atos que atentam contra os princípios da administração, a lei exige que seja comprovado na conduta funcional do agente o fim de:',
 'Obter proveito ou benefício indevido para si ou para outra pessoa ou entidade.',
 'Apenas violar a norma legal, sendo o dolo de aproveitamento irrelevante para a tipificação.',
 'Gerar economia para os cofres públicos, ainda que por meios transversos à legalidade.',
 'Demonstrar a ineficiência do órgão público para justificar futuras privatizações.',
 NULL,
 'A',
 'A alternativa A está correta: inspirada na Convenção das Nações Unidas contra a Corrupção, a lei exige, para a configuração dessa categoria de improbidade, que seja comprovado, na conduta funcional do agente público, o fim de obter proveito ou benefício indevido para si ou para outra pessoa ou entidade. A alternativa B está incorreta porque contraria diretamente essa exigência de dolo específico — a mera violação da norma, sem o fim de proveito indevido, não basta. As alternativas C e D descrevem finalidades estranhas à tipificação legal, sem qualquer correspondência com o texto da lei.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, §1º (incluído pela Lei nº 14.230/2021): "Nos termos da Convenção das Nações Unidas contra a Corrupção, promulgada pelo Decreto nº 5.687, de 31 de janeiro de 2006, somente haverá improbidade administrativa, na aplicação deste artigo, quando for comprovado na conduta funcional do agente público o fim de obter proveito ou benefício indevido para si ou para outra pessoa ou entidade."',
 'Lei 8.429/1992, art. 11, §1º, na redação da Lei 14.230/2021',
 'facil'),

-- Q17: Demonstração objetiva da ilegalidade
(@cat_ia13,
 'O enquadramento de uma conduta como violação aos princípios da administração pressupõe:',
 'A demonstração subjetiva da intenção, dispensando-se a indicação da norma violada.',
 'A demonstração objetiva da prática de ilegalidade, com indicação das normas constitucionais, legais ou infralegais violadas.',
 'O prévio reconhecimento da irregularidade pelo Tribunal de Contas respectivo.',
 'A existência de prejuízo ao erário superior a 10 salários mínimos.',
 NULL,
 'B',
 'A alternativa B está correta: o enquadramento nessa categoria pressupõe a demonstração objetiva da prática de ilegalidade no exercício da função pública, com a indicação expressa das normas constitucionais, legais ou infralegais violadas — não bastando alegações genéricas de "má gestão". A alternativa A está incorreta porque inverte a exigência legal: além do elemento subjetivo (dolo específico), é indispensável a indicação objetiva da norma violada. A alternativa C está incorreta porque a lei não condiciona a caracterização da improbidade a prévio reconhecimento pelo Tribunal de Contas. A alternativa D está incorreta porque essa categoria de improbidade independe de qualquer valor mínimo de prejuízo, e o parâmetro de salários mínimos citado não corresponde a este dispositivo.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, §3º (incluído pela Lei nº 14.230/2021): "O enquadramento de conduta funcional na categoria de que trata este artigo pressupõe a demonstração objetiva da prática de ilegalidade no exercício da função pública, com a indicação das normas constitucionais, legais ou infralegais violadas."',
 'Lei 8.429/1992, art. 11, §3º, na redação da Lei 14.230/2021',
 'medio'),

-- Q18: Lesividade relevante
(@cat_ia13,
 'Os atos de improbidade que violam princípios exigem, para serem passíveis de sancionamento:',
 'Lesividade relevante ao bem jurídico tutelado.',
 'Produção obrigatória de danos ao erário.',
 'Comprovação de enriquecimento ilícito do agente público.',
 'Que a conduta tenha sido praticada por pelo menos dois agentes em conluio.',
 NULL,
 'A',
 'A alternativa A está correta: a reforma de 2021 introduziu o requisito da lesividade relevante ao bem jurídico tutelado para que os atos de violação a princípios sejam passíveis de sancionamento, de modo que condutas insignificantes, embora tecnicamente ilegais, podem não ensejar a aplicação das sanções da lei. A alternativa B está incorreta porque essa categoria de improbidade independe, por definição, do reconhecimento de danos ao erário. A alternativa C está incorreta porque também independe da comprovação de enriquecimento ilícito do agente — é categoria autônoma. A alternativa D está incorreta porque a lei não exige pluralidade de agentes ou conluio para a configuração desse ato de improbidade.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, §4º (incluído pela Lei nº 14.230/2021): "Os atos de improbidade de que trata este artigo exigem lesividade relevante ao bem jurídico tutelado para serem passíveis de sancionamento e independem do reconhecimento da produção de danos ao erário e de enriquecimento ilícito dos agentes públicos."',
 'Lei 8.429/1992, art. 11, §4º, na redação da Lei 14.230/2021',
 'dificil'),

-- Q19: Categorias vigentes de atos de improbidade
(@cat_ia13,
 'O sistema da Lei de Improbidade Administrativa estrutura-se em categorias específicas de atos. Assinale a alternativa que apresenta apenas categorias vigentes:',
 'Enriquecimento Ilícito, Prejuízo ao Erário e Violação aos Princípios da Administração.',
 'Enriquecimento Ilícito, Prejuízo ao Erário e Concessão Indevida de Benefício Financeiro.',
 'Enriquecimento Ilícito, Erro Administrativo Grave e Violação à Lealdade Institucional.',
 'Prejuízo ao Erário, Dolo Genérico e Atentado ao Decoro Parlamentar.',
 NULL,
 'A',
 'A alternativa A está correta: após a reforma de 2021, as três categorias vigentes de atos de improbidade administrativa são o Enriquecimento Ilícito (art. 9º), o Prejuízo ao Erário (art. 10) e a Violação aos Princípios da Administração Pública (art. 11), todas exigindo dolo. A alternativa B está incorreta porque a "Concessão Indevida de Benefício Financeiro ou Tributário" (antigo art. 10-A) foi expressamente revogada pela Lei 14.230/2021, tendo sua matéria absorvida pelo art. 10. As alternativas C e D descrevem categorias inexistentes na lei, criadas apenas como distratores.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 1º, §1º (incluído pela Lei nº 14.230/2021): "Consideram-se atos de improbidade administrativa as condutas dolosas tipificadas nos arts. 9º, 10 e 11 desta Lei, ressalvados tipos previstos em leis especiais." O art. 10-A, que prevía a categoria de concessão indevida de benefício financeiro ou tributário, foi revogado pela Lei nº 14.230/2021.',
 'Lei 8.429/1992, art. 1º, §1º c/c arts. 9º, 10 e 11, na redação da Lei 14.230/2021',
 'facil'),

-- Q20: Responsabilização de PJ — efeitos econômicos e sociais
(@cat_ia13,
 'Na responsabilização da pessoa jurídica por atos de improbidade, o juiz deve considerar, obrigatoriamente:',
 'A exclusão de qualquer sanção que possa afetar o lucro dos sócios minoritários.',
 'Os efeitos econômicos e sociais das sanções, de modo a viabilizar a manutenção de suas atividades.',
 'A desconsideração imediata da personalidade jurídica para atingir o patrimônio pessoal dos colaboradores.',
 'A aplicação da multa civil no valor máximo de 100 vezes o faturamento bruto anual.',
 NULL,
 'B',
 'A alternativa B está correta: a lei determina que, na responsabilização da pessoa jurídica, sejam considerados os efeitos econômicos e sociais das sanções, de modo a viabilizar a manutenção de suas atividades — proteção à função social da empresa. A alternativa A está incorreta porque a lei não prevê exclusão automática de sanções em razão do impacto sobre sócios minoritários, mas sim uma ponderação sobre a viabilidade da própria pessoa jurídica. A alternativa C está incorreta porque a desconsideração da personalidade jurídica não é medida automática, dependendo de instauração de incidente próprio, conforme a lei processual, quando houver indícios de confusão patrimonial ou fraude. A alternativa D está incorreta porque não existe esse parâmetro de multa vinculado ao faturamento bruto anual na lei.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 12, §3º (incluído pela Lei nº 14.230/2021): "Na responsabilização da pessoa jurídica, deverão ser considerados os efeitos econômicos e sociais das sanções, de modo a viabilizar a manutenção de suas atividades."',
 'Lei 8.429/1992, art. 12, §3º, na redação da Lei 14.230/2021',
 'medio'),

-- Q21: Prazos de suspensão de direitos políticos
(@cat_ia13,
 'A sanção de suspensão dos direitos políticos sofreu alterações de prazos e regras de cômputo. Assinale a alternativa que reflete a regra atual:',
 'No enriquecimento ilícito, o prazo é de 8 a 10 anos; no prejuízo ao erário, é de 5 a 8 anos.',
 'No enriquecimento ilícito, o prazo é de até 14 anos; no prejuízo ao erário, é de até 12 anos.',
 'O prazo para suspensão no caso de violação de princípios é de 3 a 5 anos.',
 'A contagem do prazo inicia-se retroativamente entre a decisão colegiada e o trânsito em julgado.',
 NULL,
 'B',
 'A alternativa B está correta: os novos prazos máximos de suspensão dos direitos políticos são de até 14 anos para o enriquecimento ilícito (art. 9º) e de até 12 anos para o prejuízo ao erário (art. 10). A alternativa A está incorreta porque descreve a faixa de prazos (mínimo e máximo) da redação original da lei, anterior à reforma de 2021, hoje superada pelos novos limites máximos. A alternativa C está incorreta porque, para a categoria de violação a princípios (art. 11), a sanção de suspensão de direitos políticos foi extinta pela Lei 14.230/2021, restando apenas multa civil e proibição de contratar com o poder público. A alternativa D descreve, de forma incompleta e fora de contexto, uma regra processual distinta — o cômputo retroativo do tempo decorrido entre a decisão colegiada e o trânsito em julgado na contagem do prazo já fixado —, e não a atualização das faixas de anos que a pergunta busca identificar.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 12, I e II (redação dada pela Lei nº 14.230/2021): suspensão dos direitos políticos "até 14 (catorze) anos" na hipótese do art. 9º e "até 12 (doze) anos" na hipótese do art. 10. O art. 12, §10, trata separadamente do cômputo retroativo do prazo entre a decisão colegiada e o trânsito em julgado.',
 'Lei 8.429/1992, art. 12, I e II, na redação da Lei 14.230/2021',
 'dificil'),

-- Q22: Indisponibilidade de bens — proteção de valor mínimo
(@cat_ia13,
 'Sobre a medida cautelar de indisponibilidade de bens, assinale a alternativa correta:',
 'É vedada a decretação de indisponibilidade da quantia de até 50 salários mínimos em conta-corrente.',
 'É vedada a decretação de indisponibilidade da quantia de até 40 salários mínimos depositados em caderneta de poupança ou conta-corrente.',
 'A indisponibilidade deve recair preferencialmente sobre o bem de família do réu.',
 'O perigo da demora (periculum in mora) é presumido, dispensando prova de risco ao resultado útil do processo.',
 NULL,
 'B',
 'A alternativa B está correta: a lei veda a decretação de indisponibilidade da quantia de até 40 salários mínimos depositados em caderneta de poupança, em outras aplicações financeiras ou em conta-corrente, resguardando um patamar mínimo de subsistência ao réu. A alternativa A está incorreta porque o valor protegido é de 40, e não de 50, salários mínimos — distrator por aproximação numérica. A alternativa C está incorreta porque a lei veda, e não recomenda, a indisponibilidade do bem de família do réu, salvo se comprovado que o imóvel é fruto de vantagem patrimonial indevida. A alternativa D está incorreta porque a lei exige a demonstração, no caso concreto, de perigo de dano irreparável ou de risco ao resultado útil do processo, não podendo a urgência ser presumida.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 16, §13 (incluído pela Lei nº 14.230/2021): "É vedada a decretação de indisponibilidade da quantia de até 40 (quarenta) salários mínimos depositados em caderneta de poupança, em outras aplicações financeiras ou em conta-corrente." O §14 do mesmo artigo veda a indisponibilidade do bem de família, salvo fruto de vantagem indevida, e o §3º exige demonstração concreta do periculum in mora.',
 'Lei 8.429/1992, art. 16, §13, na redação da Lei 14.230/2021',
 'dificil'),

-- Q23: Aplicabilidade da LIA a entes privados beneficiários
(@cat_ia13,
 'No que tange à aplicabilidade da Lei de Improbidade Administrativa a entes privados, assinale a alternativa correta:',
 'A lei não se aplica a eventos ocorridos em entidades privadas que recebam benefícios fiscais.',
 'O regramento da LIA aplica-se aos eventos ocorridos no âmbito de ente privado que receba benefício fiscal ou creditício da administração pública.',
 'Apenas empresas públicas e sociedades de economia mista são sujeitos passivos de atos de improbidade.',
 'Entidades privadas de ensino estão imunes à LIA, mesmo se receberem verbas de convênios federais.',
 NULL,
 'B',
 'A alternativa B está correta: entidades privadas que recebem benefício fiscal ou creditício de entes públicos são expressamente incluídas como sujeitos passivos de atos de improbidade administrativa. A alternativa A está incorreta porque inverte a regra legal, que inclui — e não exclui — essas entidades da proteção da lei. A alternativa C está incorreta porque restringe indevidamente o rol de sujeitos passivos, que também abrange a administração direta, indireta, fundacional e entidades privadas beneficiárias, além de empresas públicas e sociedades de economia mista. A alternativa D está incorreta porque não há essa imunidade: instituições de ensino que recebam verbas públicas de convênio também se sujeitam à lei.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 1º, §6º (incluído pela Lei nº 14.230/2021): "Estão sujeitos às sanções desta Lei os atos de improbidade praticados contra o patrimônio de entidade privada que receba subvenção, benefício ou incentivo, fiscal ou creditício, de entes públicos ou governamentais [...]".',
 'Lei 8.429/1992, art. 1º, §6º, na redação da Lei 14.230/2021',
 'facil'),

-- Q24: Non bis in idem reforçado para pessoas jurídicas
(@cat_ia13,
 'A Lei 14.230/2021 reforçou o princípio do non bis in idem nas sanções a pessoas jurídicas. De acordo com o material, isso significa que:',
 'A pessoa jurídica pode ser condenada cumulativamente pelas mesmas condutas em todas as instâncias sem compensação.',
 'Proíbe-se a condenação da PJ por ato de improbidade e por corrupção (Lei Anticorrupção) em razão da prática do mesmo ato.',
 'A absolvição na esfera administrativa não gera reflexos na ação de improbidade.',
 'A multa civil deve ser aplicada sempre em dobro quando houver condenação criminal concomitante.',
 NULL,
 'B',
 'A alternativa B está correta: o princípio do non bis in idem foi reforçado para impedir a dupla condenação da pessoa jurídica pela Lei de Improbidade e pela Lei Anticorrupção (Lei 12.846/2013) em razão do mesmo fato, além de determinar que as sanções aplicadas com base em ambas as leis observem esse princípio constitucional. A alternativa A está incorreta porque descreve exatamente o cenário que a reforma buscou evitar. A alternativa C não corresponde ao conteúdo do reforço do non bis in idem tratado nesse contexto, que trata da relação entre LIA e Lei Anticorrupção, e não de reflexos entre esferas administrativa e judicial de improbidade. A alternativa D está incorreta porque não há previsão de dobra automática da multa civil por condenação criminal concomitante — ao contrário, a lei determina que o ressarcimento do dano deduza valores já recompostos em outras instâncias.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 12, §7º (incluído pela Lei nº 14.230/2021): "As sanções aplicadas a pessoas jurídicas com base nesta Lei e na Lei nº 12.846, de 1º de agosto de 2013, deverão observar o princípio constitucional do non bis in idem." Combina-se com o art. 3º, §2º, que veda a aplicação das sanções da LIA à PJ já sancionada pela Lei Anticorrupção pelo mesmo ato.',
 'Lei 8.429/1992, art. 12, §7º c/c art. 3º, §2º, na redação da Lei 14.230/2021',
 'medio'),

-- Q25: Enriquecimento ilícito — independe de lesão ao erário
(@cat_ia13,
 'Para a configuração dos atos de improbidade que importam enriquecimento ilícito, é correto afirmar:',
 'É indispensável a prova do dolo específico do agente e a ocorrência de lesão efetiva ao erário.',
 'É indispensável a prova do dolo do agente, mas a caracterização independe de lesão ao erário.',
 'A conduta pode ser culposa, desde que o agente tenha obtido vantagem patrimonial superior a 100 salários mínimos.',
 'O dolo genérico é suficiente, desde que o agente não consiga provar a origem lícita de seus bens.',
 NULL,
 'B',
 'A alternativa B está correta: no enriquecimento ilícito, o foco da tipificação é a vantagem patrimonial indevida auferida pelo agente em razão do cargo, mandato, função ou atividade; exige-se dolo, mas a caracterização do ato independe de ter havido, concomitantemente, prejuízo efetivo aos cofres públicos. A alternativa A está incorreta porque exige, além do dolo, a lesão efetiva ao erário como requisito cumulativo, o que não corresponde à estrutura autônoma dessa categoria de improbidade. A alternativa C está incorreta porque a modalidade culposa foi extinta para todas as categorias, inclusive o enriquecimento ilícito. A alternativa D está incorreta porque a lei exige dolo específico, e não mero dolo genérico, ainda que, em determinadas hipóteses (como a evolução patrimonial desproporcional), caiba ao agente demonstrar a licitude da origem dos bens.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 9º, caput (redação dada pela Lei nº 14.230/2021): "Constitui ato de improbidade administrativa importando em enriquecimento ilícito auferir, mediante a prática de ato doloso, qualquer tipo de vantagem patrimonial indevida em razão do exercício de cargo, de mandato, de função, de emprego ou de atividade nas entidades referidas no art. 1º desta Lei [...]" — sem exigência de lesão ao erário como elemento do tipo, diferentemente do art. 10.',
 'Lei 8.429/1992, art. 9º, caput, na redação da Lei 14.230/2021',
 'medio'),

-- Q26: Violação a princípios — independência de dano e enriquecimento
(@cat_ia13,
 'Em relação aos atos de improbidade caracterizados por violação dos princípios da administração pública, assinale a alternativa correta:',
 'Exigem a demonstração de dano material para a Administração Pública como condição de procedibilidade.',
 'Dispensam a demonstração da ocorrência de dano para a Administração Pública ou do enriquecimento ilícito do agente.',
 'A sanção de perda da função pública é obrigatória e deve ser aplicada em todos os casos.',
 'O prazo de suspensão de direitos políticos para esta categoria foi ampliado para 10 anos.',
 NULL,
 'B',
 'A alternativa B está correta: a categoria de violação a princípios é autônoma e dispensa, para sua configuração, a demonstração de dano ao erário ou de enriquecimento ilícito do agente, bastando a violação dolosa dos deveres de honestidade, imparcialidade e legalidade com o fim de obter proveito indevido. A alternativa A está incorreta porque contraria diretamente essa autonomia — não há exigência de dano material. A alternativa C está incorreta porque, na redação atual do art. 12, III, as sanções previstas para essa categoria limitam-se a multa civil de até 24 vezes a remuneração do agente e proibição de contratar com o poder público por até 4 anos, não constando mais, de forma obrigatória, a perda da função pública. A alternativa D está incorreta porque a suspensão de direitos políticos foi extinta, e não ampliada, para essa categoria de improbidade.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 11, §4º (incluído pela Lei nº 14.230/2021): os atos "independem do reconhecimento da produção de danos ao erário e de enriquecimento ilícito dos agentes públicos". O art. 12, III, na redação atual, comina, para essa hipótese, apenas "multa civil de até 24 (vinte e quatro) vezes o valor da remuneração percebida pelo agente e proibição de contratar com o poder público [...] pelo prazo não superior a 4 (quatro) anos".',
 'Lei 8.429/1992, art. 11, §4º c/c art. 12, III, na redação da Lei 14.230/2021',
 'medio'),

-- Q27: Uso de bem público em obra particular de terceiro
(@cat_ia13,
 'Considere a conduta de permitir a utilização, em obra particular, de material de propriedade de pessoa jurídica da administração pública. Segundo a tipificação da Lei de Improbidade Administrativa:',
 'Importa em enriquecimento ilícito do agente público que permitiu o uso.',
 'Constitui ato de improbidade que causa prejuízo ao erário.',
 'É conduta atípica se o material for considerado "sobra de obra" ou entulho.',
 'Trata-se de infração meramente administrativa, não alcançada pela Lei de Improbidade.',
 NULL,
 'B',
 'A alternativa B está correta: a lei tipifica como prejuízo ao erário permitir que terceiro utilize, em obra ou serviço particular, veículo, máquina, equipamento ou material de propriedade ou à disposição da administração, bem como o trabalho de servidores ou terceiros contratados. A alternativa A está incorreta porque o enriquecimento ilícito do próprio agente público ocorreria se ele mesmo utilizasse o bem em proveito próprio — situação distinta de permitir que terceiro o utilize, hipótese enquadrada no prejuízo ao erário. A alternativa C está incorreta porque a lei não prevê essa exceção quanto à natureza ou origem do material utilizado. A alternativa D está incorreta porque a conduta está expressamente tipificada como ato de improbidade, e não como mera infração administrativa.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 10, XIII: "permitir que se utilize, em obra ou serviço particular, veículos, máquinas, equipamentos ou material de qualquer natureza, de propriedade ou à disposição de qualquer das entidades mencionadas no art. 1º desta lei, bem como o trabalho de servidor público, empregados ou terceiros contratados por essas entidades."',
 'Lei 8.429/1992, art. 10, XIII',
 'medio'),

-- Q28: Consultoria/assessoramento a interessado nas atribuições do agente
(@cat_ia13,
 'Assinale a alternativa que descreve corretamente uma hipótese de enriquecimento ilícito prevista na Lei de Improbidade Administrativa:',
 'Ordenar despesas não autorizadas em lei ou regulamento orçamentário.',
 'Exercer atividade de consultoria para pessoa jurídica que tenha interesse suscetível de ser atingido por ação decorrente das atribuições do agente, durante a atividade.',
 'Celebrar parcerias com entidades privadas sem observar as formalidades legais.',
 'Revelar teor de medida econômica capaz de afetar o preço de mercadoria antes da divulgação oficial.',
 NULL,
 'B',
 'A alternativa B está correta: a lei tipifica como enriquecimento ilícito aceitar emprego, comissão ou exercer atividade de consultoria ou assessoramento para pessoa física ou jurídica que tenha interesse suscetível de ser atingido ou amparado por ação ou omissão decorrente das atribuições do agente público, durante a atividade. A alternativa A está incorreta porque ordenar despesas não autorizadas é conduta tipificada como prejuízo ao erário, e não enriquecimento ilícito. A alternativa C está incorreta porque celebrar parcerias sem formalidades legais também se enquadra na categoria de prejuízo ao erário. A alternativa D está incorreta porque revelar antecipadamente teor de medida capaz de afetar preços de mercado é conduta relacionada à violação de princípios da administração pública (sigilo funcional), e não ao enriquecimento ilícito.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 9º, VIII: "aceitar emprego, comissão ou exercer atividade de consultoria ou assessoramento para pessoa física ou jurídica que tenha interesse suscetível de ser atingido ou amparado por ação ou omissão decorrente das atribuições do agente público, durante a atividade."',
 'Lei 8.429/1992, art. 9º, VIII',
 'medio'),

-- Q29: Evolução patrimonial desproporcional — inversão do ônus da prova
(@cat_ia13,
 'Um Oficial da Polícia Militar que adquire bens cujo valor seja desproporcional à evolução do seu patrimônio ou à sua renda, no exercício da função:',
 'Pratica ato que atenta contra os princípios, desde que não haja prova de recebimento de propina.',
 'Pratica ato de improbidade que importa enriquecimento ilícito, assegurada a demonstração da licitude da origem.',
 'Está isento de responsabilidade se os bens estiverem em nome de terceiros (laranjas).',
 'Deve ser punido apenas com multa civil de até 24 vezes o valor da sua remuneração.',
 NULL,
 'B',
 'A alternativa B está correta: a evolução patrimonial desproporcional à renda do agente público, decorrente do exercício de mandato, cargo, emprego ou função, tipifica ato de improbidade por enriquecimento ilícito, assegurada, contudo, ao agente a demonstração da licitude da origem dessa evolução patrimonial. A alternativa A está incorreta porque a hipótese está tipificada como enriquecimento ilícito (art. 9º), categoria distinta da violação a princípios, e não depende de prova de propina especificamente. A alternativa C está incorreta porque a interposição de terceiros para ocultar a titularidade dos bens não afasta a responsabilidade do agente — ao contrário, é indício de dissimulação. A alternativa D está incorreta porque a sanção de multa civil de até 24 vezes a remuneração corresponde à categoria de violação a princípios (art. 11), e não ao enriquecimento ilícito, cuja sanção de multa é equivalente ao valor do próprio acréscimo patrimonial, além de perda de bens e suspensão de direitos políticos de até 14 anos.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 9º, VII (redação dada pela Lei nº 14.230/2021): "adquirir, para si ou para outrem, no exercício de mandato, de cargo, de emprego ou de função pública, e em razão deles, bens de qualquer natureza [...] cujo valor seja desproporcional à evolução do patrimônio ou à renda do agente público, assegurada a demonstração pelo agente da licitude da origem dessa evolução."',
 'Lei 8.429/1992, art. 9º, VII, na redação da Lei 14.230/2021',
 'medio'),

-- Q30: Conceito amplo de agente público — estagiários
(@cat_ia13,
 'Sobre a sujeição de estagiários de órgãos públicos à Lei de Improbidade Administrativa:',
 'Estão imunes à responsabilização por inexistir vínculo empregatício efetivo ou estatutário.',
 'Estão sujeitos à responsabilização, pois o conceito de agente público abrange quem exerce função, ainda que transitoriamente ou sem remuneração.',
 'Só respondem se o estágio for remunerado e o ato causar prejuízo superior ao valor da bolsa-estágio.',
 'Respondem apenas por atos de violação a princípios, sendo-lhes vedada a aplicação de penas de perda de bens.',
 NULL,
 'B',
 'A alternativa B está correta: o conceito legal de agente público é amplíssimo, abrangendo todo aquele que exerce, ainda que transitoriamente ou sem remuneração, por eleição, nomeação, designação, contratação ou qualquer outra forma de investidura ou vínculo, mandato, cargo, emprego ou função nas entidades sujeitas à lei — o que inclui os estagiários. A alternativa A está incorreta porque a ausência de vínculo empregatício efetivo não afasta a qualidade de agente público para os fins da lei. A alternativa C está incorreta porque a sujeição à lei não depende da remuneração do estágio nem de um patamar mínimo de prejuízo vinculado ao valor da bolsa. A alternativa D está incorreta porque não há essa limitação de categorias ou de sanções aplicáveis a estagiários — eles se sujeitam, em tese, a todas as categorias e sanções da lei, conforme a conduta praticada.\n\n📜 Fundamento legal vigente: Lei nº 8.429/1992, art. 2º, caput (redação dada pela Lei nº 14.230/2021): "Para os efeitos desta Lei, consideram-se agente público o agente político, o servidor público e todo aquele que exerce, ainda que transitoriamente ou sem remuneração, por eleição, nomeação, designação, contratação ou qualquer outra forma de investidura ou vínculo, mandato, cargo, emprego ou função nas entidades referidas no art. 1º desta Lei."',
 'Lei 8.429/1992, art. 2º, caput, na redação da Lei 14.230/2021',
 'facil');

SET foreign_key_checks = 1;
