-- ============================================================
-- QUIZ — Disciplina 11/20 do CHO: Ética Profissional e Cidadania
-- 30 questões — dupla justificativa (filosofia moral + doutrina de conduta policial)
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: Caderno de Questões "Ética Profissional e Cidadania" —
--   Academia Coronel Walterler / CHO. Módulo I: Cidadania e Evolução
--   Histórico-Política (Q01-08); Módulo II: Fundamentos Filosóficos da Ética
--   — Sócrates, Aristóteles, Ética Medieval, Rousseau e Kant (Q09-16); Módulo
--   III: Ética Profissional e Códigos de Conduta (Q17-22); Módulo IV: Ética na
--   Aplicação da Lei e premissas ONU/CCEAL — C. de Rover e Código de Conduta
--   da ONU (Q23-30).
-- Observação sobre a fonte: disciplina de fundamentos filosóficos (Sócrates,
--   Aristóteles, Kant) e doutrina de conduta policial (C. de Rover), SEM lei
--   estadual/federal numerada específica, com DUAS exceções pontuais:
--   (1) CF/88, art. 14, §1º e §2º — citada no material de referência a respeito
--   do alistamento eleitoral e da facultatividade do voto (Q06); e
--   (2) o Código de Conduta para os Encarregados da Aplicação da Lei (CCEAL),
--   Resolução 34/169 da Assembleia Geral da ONU (1979), único instrumento
--   normativo com artigos numerados reais citado nesta disciplina (Q26-28).
--   Texto do CCEAL baixado para legislacao/CCEAL_ONU_Resolucao34169_1979.txt.
-- Revisão anti-decoreba: 4 questões da fonte original citavam o número do
--   artigo diretamente no enunciado (Q06 "Art. 14 da CF/88", Q26 "Artigo 3º",
--   Q27 "Artigo 4º", Q28 "Artigo 8º" do CCEAL) — todas foram reescritas em
--   estilo conceitual/cenário, movendo a numeração exclusivamente para o
--   campo referencia_legal, conforme guia_elaboracao_questoes.md.
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Ética Profissional — CHO 11', 'Disciplina 11/20 do CHO — Cidadania e evolução histórico-política, fundamentos filosóficos da ética (Sócrates, Aristóteles, Kant), ética profissional e códigos de conduta, ética na aplicação da lei e Código de Conduta da ONU (CCEAL)');

SET @cat_ep11 = (SELECT id FROM categorias WHERE nome = 'Ética Profissional — CHO 11' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Cidadania — contrapartida de deveres
(@cat_ep11,
 'O conceito de cidadania, em sua gênese etimológica e evolução democrática, estabelece uma relação intrínseca entre o indivíduo e a coletividade política. Em uma democracia consolidada, a garantia dos direitos individuais fundamenta-se em qual premissa?',
 'Na soberania absoluta do Estado, que outorga direitos por ato de benevolência governamental.',
 'Na existência de direitos políticos puros, independentes de contrapartidas cívicas ou sociais.',
 'No pressuposto da contrapartida de deveres, em que o cumprimento das obrigações pela coletividade assegura a fruição do direito individual.',
 'Na primazia do direito natural sobre o direito positivo, dispensando a necessidade de leis escritas.',
 'No exercício da revolta como único mecanismo de intervenção direta na administração pública.',
 'C',
 'A alternativa C está correta: em uma democracia, a garantia do direito individual pressupõe a contrapartida de deveres — os direitos de um indivíduo só se sustentam quando os demais componentes da coletividade cumprem suas respectivas obrigações sociais. A alternativa A inverte essa lógica ao tratar direitos como concessão graciosa do Estado. A alternativa B ignora que direitos políticos sempre vêm acompanhados de contrapartidas cívicas. A alternativa D nega a necessidade do ordenamento positivado. A alternativa E reduz a cidadania a um recurso excepcional (a revolta), quando este é o último, não o principal, instrumento de participação.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico sobre o conceito de cidadania (reciprocidade entre direitos e deveres), sem lei numerada correspondente nesta disciplina.',
 'Doutrina de Ética Profissional — conceito de cidadania',
 'facil'),

-- Q02: Cidadania na Antiguidade e Idade Média
(@cat_ep11,
 'A trajetória histórica da cidadania revela um processo de exclusões sucessivas até a modernidade. Sobre a cidadania na Antiguidade Clássica e na Idade Média, assinale a alternativa correta:',
 'Em Roma, após a conquista da Grécia, a cidadania foi universalizada a todos os habitantes do império, independentemente de gênero ou posse.',
 'Na Idade Média, o surgimento dos feudos promoveu a descentralização política, extinguindo a ideia de cidadania ativa para os servos.',
 'A Grécia clássica permitia que estrangeiros e escravos participassem das decisões políticas, desde que demonstrassem mérito intelectual.',
 'O sistema feudal incentivava a participação dos servos nas decisões administrativas dos feudos como forma de preparar a futura burguesia.',
 'A cidadania na Antiguidade era definida pela simples residência na cidade, sem distinção entre homens livres e proprietários.',
 'B',
 'A alternativa B está correta: na Idade Média, os proprietários dos feudos detinham o poder total, enquanto os servos eram excluídos de qualquer participação decisória, fazendo a cidadania ativa praticamente desaparecer nesse período. A alternativa A é falsa, pois a cidadania romana nunca foi universal a todos os habitantes, sobretudo mulheres e escravos. A alternativa C inverte a realidade grega, que excluía estrangeiros e escravos da vida política. A alternativa D contraria o caráter excludente do feudalismo em relação aos servos. A alternativa E ignora que a cidadania antiga distinguia claramente homens livres e proprietários dos demais habitantes.\n\n📜 Fundamento legal vigente: fundamento doutrinário/histórico-filosófico sobre a evolução da cidadania na Antiguidade e na Idade Média, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — evolução histórica da cidadania',
 'facil'),

-- Q03: Revolução Filosófica (Iluminismo)
(@cat_ep11,
 'A transição do Absolutismo para o Estado de Direito foi viabilizada por um conjunto de revoluções burguesas. Dentre elas, qual é tecnicamente identificada como a "Revolução Filosófica", por fornecer as bases ideológicas para a destituição do poder absoluto do Rei?',
 'Revolução Industrial.',
 'Revolução Francesa.',
 'Independência dos Estados Unidos.',
 'Iluminismo.',
 'Revolução Inglesa.',
 'D',
 'A alternativa D está correta: o Iluminismo é identificado como a "Revolução Filosófica" dentre o conjunto de revoluções burguesas que visavam destituir o poder total do Rei no Absolutismo, fornecendo as bases racionais e ideológicas para as demais transformações políticas. As alternativas A, B, C e E referem-se a outras revoluções do mesmo conjunto (econômica, política e de independência), mas nenhuma delas recebe a classificação específica de "revolução filosófica", categoria reservada ao movimento das ideias iluministas.\n\n📜 Fundamento legal vigente: fundamento doutrinário/histórico-filosófico sobre as revoluções burguesas e a transição do Absolutismo ao Estado de Direito, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — revoluções burguesas e Estado de Direito',
 'facil'),

-- Q04: Cidadania x Capitalismo
(@cat_ep11,
 'Há uma tensão dialética entre Cidadania e Capitalismo. A "grande contradição" desse modelo, segundo a doutrina, reside no fato de que:',
 'O capitalismo exige o pleno exercício da cidadania por todos para que o mercado de consumo se sustente.',
 'A cidadania busca a igualdade e benefícios sociais, enquanto o capitalismo se nutre da desigualdade de posses e da existência de uma massa proletária.',
 'O Estado de Direito impede o acúmulo de capital para garantir que todos os cidadãos sejam empresários.',
 'A função de consumidor é incompatível com a função política do cidadão no Estado Moderno.',
 'A mídia atua como ferramenta de conscientização política, reduzindo o apelo ao consumo desenfreado.',
 'B',
 'A alternativa B está correta: a cidadania persegue a igualdade e o bem-estar social, ao passo que o capitalismo se alimenta estruturalmente da desigualdade de posses e da existência de uma massa de trabalhadores subordinados — se todos fossem grandes empresários, o próprio sistema capitalista colapsaria por falta de mão de obra. A alternativa A inverte a lógica, pois o pleno exercício igualitário da cidadania tenderia a solapar, não sustentar, o modelo capitalista tal como estruturado. A alternativa C é falsa, pois o Estado de Direito não impede o acúmulo de capital. A alternativa D não reflete a doutrina, que reconhece a coexistência, ainda que tensa, das funções de consumidor e cidadão. A alternativa E inverte o papel usualmente atribuído à mídia na fomentação do consumo.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico sobre a tensão entre cidadania e capitalismo, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — cidadania e capitalismo',
 'medio'),

-- Q05: Nacionalidade x Cidadania
(@cat_ep11,
 'No que tange à relação entre Nacionalidade e Cidadania, o entendimento doutrinário-jurídico estabelece que:',
 'A cidadania é o pressuposto biológico da nacionalidade.',
 'Todo nacional é automaticamente um cidadão investido de direitos políticos plenos.',
 'A nacionalidade é condição primordial para o exercício da cidadania, mas nem todo nacional é, necessariamente, um cidadão pleno.',
 'Estrangeiros residentes no Brasil adquirem cidadania imediata pelo princípio da dignidade humana.',
 'A cidadania refere-se ao vínculo sanguíneo, enquanto a nacionalidade refere-se ao vínculo político.',
 'C',
 'A alternativa C está correta: a nacionalidade é pressuposto da cidadania, mas indivíduos que ainda não possuem direitos políticos plenos, como os menores de idade, são nacionais sem, contudo, exercerem plenamente a cidadania no sentido político-ativo. A alternativa A inverte a relação de precedência entre os dois conceitos. A alternativa B generaliza indevidamente, ignorando hipóteses de nacionais sem direitos políticos plenos. A alternativa D não corresponde à regra geral de aquisição de nacionalidade/cidadania por estrangeiros. A alternativa E troca os critérios definidores de cada conceito.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre a distinção entre nacionalidade e cidadania, sem lei numerada específica citada nesta questão.',
 'Doutrina de Ética Profissional — nacionalidade e cidadania',
 'medio'),

-- Q06: Alistamento eleitoral e voto facultativo (reescrita — retirado "Art. 14 da CF/88" do enunciado)
(@cat_ep11,
 'Sobre o alistamento eleitoral e o exercício do voto no ordenamento constitucional brasileiro, assinale a alternativa que descreve corretamente uma hipótese de facultatividade ou de vedação ao voto:',
 'O voto é obrigatório para analfabetos que possuem nacionalidade brasileira nata.',
 'O alistamento eleitoral é permitido aos estrangeiros que residam há mais de dez anos no país.',
 'O voto é facultativo para os jovens entre dezesseis e dezoito anos incompletos, para os maiores de setenta anos e para os analfabetos.',
 'Brasileiros conscritos durante o período do serviço militar obrigatório possuem direito ao voto facultativo.',
 'A nacionalidade brasileira é irrelevante para a condição de elegibilidade.',
 'C',
 'A alternativa C está correta: a Constituição estabelece a facultatividade do voto para os analfabetos, para os maiores de dezesseis e menores de dezoito anos e para os maiores de setenta anos. A alternativa A é falsa, pois o voto do analfabeto é justamente uma hipótese de facultatividade, não de obrigatoriedade. A alternativa B contraria a regra de que apenas brasileiros, natos ou naturalizados, podem se alistar eleitoralmente — estrangeiros não votam nas eleições nacionais. A alternativa D inverte a regra: durante o serviço militar obrigatório, os conscritos ficam vedados de se alistar e votar, e não em situação de facultatividade. A alternativa E ignora que a nacionalidade brasileira é condição de elegibilidade.\n\n📜 Fundamento legal vigente: CF/88, art. 14, §1º, II (voto facultativo) e §2º (vedação ao alistamento de conscritos durante o serviço militar obrigatório) — dispositivo constitucional efetivamente citado no material de referência desta disciplina, exceção pontual à regra geral de fundamento filosófico/doutrinário que caracteriza a matéria de Ética Profissional.',
 'CF/88, art. 14, §1º, II e §2º',
 'medio'),

-- Q07: Pilar do Estado de Direito
(@cat_ep11,
 'A transição para a Idade Contemporânea consolidou o Estado de Direito. Qual é o pilar fundamental desse modelo que altera o conceito de cidadania em relação ao Absolutismo?',
 'A subordinação da Constituição aos decretos reais de emergência.',
 'A premissa de que todos possuem direitos iguais perante a Constituição.',
 'A exclusão definitiva da burguesia das decisões econômicas do Estado.',
 'O fortalecimento dos feudos como unidades de resistência ao poder central.',
 'A substituição do sufrágio universal pelo voto censitário baseado na propriedade de terras.',
 'B',
 'A alternativa B está correta: a principal característica do Estado de Direito é que todos têm direitos iguais perante a Constituição, marcando o fim do privilégio próprio do Absolutismo. A alternativa A descreve justamente o modelo absolutista que o Estado de Direito supera. A alternativa C não corresponde à ascensão burguesa que caracteriza esse período histórico. A alternativa D refere-se ao modelo feudal medieval, anterior ao Estado de Direito. A alternativa E descreve um retrocesso censitário incompatível com a consolidação da igualdade formal do Estado de Direito.\n\n📜 Fundamento legal vigente: fundamento doutrinário/histórico-filosófico sobre o Estado de Direito, sem lei numerada específica citada nesta questão.',
 'Doutrina de Ética Profissional — Estado de Direito',
 'facil'),

-- Q08: Direito à revolta (Juarez Távora)
(@cat_ep11,
 'Segundo uma célebre reflexão sobre a relação do povo com o Estado, citada no material de referência, a revolta é definida como:',
 'Um crime de lesa-pátria em qualquer circunstância democrática.',
 'O último dos direitos de um povo livre e o mais imperioso dos deveres para garantir os interesses coletivos.',
 'Um comportamento irracional que deve ser combatido pela escola e pela mídia.',
 'Uma ferramenta exclusiva da burguesia para manter o controle sobre o Rei.',
 'Uma consequência inevitável da ausência de nacionalidade.',
 'B',
 'A alternativa B está correta: a reflexão citada afirma que a revolta é o último direito de um povo livre e, ao mesmo tempo, o mais imperioso dos deveres para a garantia dos interesses coletivos, quando esgotados os demais mecanismos institucionais. A alternativa A contraria essa perspectiva ao tratar a revolta sempre como crime. A alternativa C reduz indevidamente a revolta a mero comportamento irracional. A alternativa D restringe indevidamente o uso desse direito à burguesia histórica. A alternativa E não guarda relação lógica com o conceito de revolta apresentado.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (citação de pensamento político sobre cidadania e direito de revolta), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — cidadania e direito de revolta',
 'facil'),

-- Q09: Distinção Ética x Moral
(@cat_ep11,
 'Diferenciar Ética de Moral é crucial para a atuação profissional. Com base nas raízes etimológicas e nos conceitos filosóficos, assinale a alternativa correta:',
 'A Moral é a ciência que estuda a Ética, buscando universalizar comportamentos individuais.',
 'Ética deriva de morus, referindo-se aos costumes vigentes em uma sociedade específica.',
 'A Moral é o conjunto de regras e valores aceitos por uma comunidade; a Ética é a reflexão filosófica que problematiza esses valores.',
 'O agir ético limita-se ao cumprimento da moral vigente, independentemente da autonomia do agente.',
 'Não há distinção entre os termos, pois ambos se referem estritamente a hábitos passageiros.',
 'C',
 'A alternativa C está correta: a Moral é o conjunto de regras, costumes e valores aceitos por uma comunidade, enquanto a Ética é a reflexão filosófica — a "ciência da moral" — que problematiza teoricamente esses valores. A alternativa A inverte a relação, atribuindo à Moral o papel científico que é da Ética. A alternativa B troca as raízes etimológicas: é a Moral que deriva do latim morus (costumes), não a Ética. A alternativa D nega a autonomia reflexiva do agir ético, reduzindo-o ao mero cumprimento mecânico da moral vigente. A alternativa E ignora a distinção conceitual clara entre os dois termos.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico sobre a distinção etimológica e conceitual entre Ética e Moral, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — distinção Ética x Moral',
 'medio'),

-- Q10: Peter Singer — o que a ética NÃO é
(@cat_ep11,
 'Peter Singer, em sua obra "Ética Prática", desconstrói mitos sobre o que a Ética NÃO é. Sobre essa perspectiva, é correto afirmar:',
 'A ética é um sistema idealista, belo na teoria, mas inviável para orientar a prática policial cotidiana.',
 'A ética é intrinsecamente religiosa, sendo ininteligível fora do contexto da fé.',
 'A ética é relativa e subjetiva, dependendo exclusivamente da opinião do agente no momento da ação.',
 'A ética não é um conjunto de proibições puramente sexuais, embora envolva considerações sobre respeito e honestidade.',
 'A origem da ética reside no medo da punição estatal, e não em atitudes de benevolência.',
 'D',
 'A alternativa D está correta: Singer desconstrói o mito de que a ética se resumiria a um conjunto de proibições sexuais, deixando claro que ela envolve considerações mais amplas, como respeito e honestidade nas relações humanas. A alternativa A contraria a tese de Singer de que a ética é, sim, aplicável e útil na prática cotidiana. A alternativa B nega a possibilidade de uma ética laica, refutada pelo autor. A alternativa C contraria a crítica de Singer ao relativismo/subjetivismo ético. A alternativa E inverte a origem da ética, associada por Singer também a atitudes de benevolência, e não apenas ao medo da punição.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (Peter Singer, "Ética Prática"), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Peter Singer, "Ética Prática"',
 'medio'),

-- Q11: Intelectualismo Moral de Sócrates
(@cat_ep11,
 'Na perspectiva socrática, o mal é compreendido como um subproduto da ignorância. Sobre o Intelectualismo Moral de Sócrates, assinale a alternativa que reflete corretamente o pensamento do filósofo:',
 'O sujeito ético é aquele que, mesmo conhecendo o bem, escolhe deliberadamente o mal por prazer.',
 'Somente o ignorante é vicioso; quem conhece a essência dos valores morais e o que é o bem não pode deixar de agir virtuosamente.',
 'A virtude é um dom divino concedido apenas aos filósofos, independentemente do uso da razão.',
 'O remorso é uma sensação física que independe da capacidade de escolha do agente.',
 'Agir coagido por pressões externas, como a ordem de um superior, é o auge da virtude socrática.',
 'B',
 'A alternativa B está correta: para Sócrates, apenas o ignorante é vicioso, e o verdadeiro conhecimento do bem conduz inevitavelmente ao agir virtuoso — na fórmula socrática, conhecimento equivale a virtude. A alternativa A contraria diretamente essa tese, pois para Sócrates não é possível conhecer verdadeiramente o bem e, ainda assim, escolher o mal. A alternativa C afasta-se do intelectualismo moral ao introduzir um elemento de dom divino alheio ao uso da razão. A alternativa D ignora a centralidade da razão e da escolha consciente no pensamento socrático. A alternativa E contraria a ideia de virtude como escolha racional autônoma, e não como submissão a pressões externas.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (Intelectualismo Moral de Sócrates), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Intelectualismo Moral de Sócrates',
 'medio'),

-- Q12: Tabela de virtudes de Aristóteles
(@cat_ep11,
 'Aristóteles introduz a ideia de que a virtude é um hábito que exige a vontade racional para alcançar a Eudaimonia, sendo o equilíbrio (justa medida) o alvo do homem prudente. Identifique a correlação correta entre vício e virtude:',
 'A Coragem é o excesso da audácia e a deficiência do medo.',
 'A Temperança é a justa medida entre o excesso (Intemperança/Libertinagem) e a deficiência (Insensibilidade).',
 'A Liberalidade é o excesso no dar dinheiro, desconsiderando a própria subsistência.',
 'A Modéstia é a justa medida entre o excesso da falta de vergonha e a deficiência da timidez.',
 'A virtude reside no extremo da paixão, pois o homem virtuoso deve ser intenso.',
 'B',
 'A alternativa B está correta: no quadro aristotélico das virtudes, a Temperança representa a justa medida (virtude), sendo a Intemperança/Libertinagem o excesso e a Insensibilidade a deficiência relativas ao prazer e ao desejo. A alternativa A inverte os polos da Coragem: o excesso é a Temeridade (audácia insensata) e a deficiência é a Covardia (medo excessivo), e não o contrário. A alternativa C descreve, na verdade, a Prodigalidade (excesso no dar), e não a Liberalidade, que é a própria virtude do equilíbrio. A alternativa D inverte os polos da Modéstia: o excesso é a Timidez/Vergonha excessiva e a deficiência é a falta de vergonha (Desfaçatez), de forma oposta ao afirmado. A alternativa E contraria a essência da doutrina aristotélica, que localiza a virtude no meio-termo, e não no extremo da paixão.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (Ética a Nicômaco, teoria das virtudes de Aristóteles), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Aristóteles, teoria das virtudes',
 'dificil'),

-- Q13: Ética Medieval — heteronomia
(@cat_ep11,
 'A Ética Medieval rompe com o racionalismo grego ao introduzir a heteronomia. Nesse contexto, a fonte do agir ético e a virtude máxima são, respectivamente:',
 'A razão individual e a justiça social.',
 'A natureza (cosmos) e a eudaimonia.',
 'Deus (vontade revelada) e a Caridade/Fé.',
 'O contrato social e a propriedade privada.',
 'O imperativo categórico e a utilidade pública.',
 'C',
 'A alternativa C está correta: na Ética Medieval, a fonte do agir ético passa a ser um elemento externo — Deus e sua vontade revelada —, sendo as virtudes teologais, especialmente a Fé e a Caridade, consideradas a virtude máxima nas relações com o Criador e com o próximo. A alternativa A descreve o racionalismo, superado justamente pela heteronomia medieval. A alternativa B refere-se ao pensamento grego clássico (physis e eudaimonia aristotélica), anterior ao período medieval. A alternativa D remete ao contratualismo moderno, não à Idade Média. A alternativa E refere-se à ética kantiana e ao utilitarismo, ambos posteriores ao período medieval.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (Ética Medieval e virtudes teologais), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Ética Medieval',
 'medio'),

-- Q14: Rousseau e Kant
(@cat_ep11,
 'Jean-Jacques Rousseau e Immanuel Kant são pilares da ética moderna. Sobre suas teorias, assinale a alternativa correta:',
 'Para Rousseau, o homem nasce mau e a sociedade deve usar a força para torná-lo ético.',
 'Kant defende que a ética deve ser baseada na heteronomia religiosa para ter validade universal.',
 'Rousseau acredita que o homem é naturalmente bom, mas a sociedade e a propriedade privada o corrompem.',
 'Para Kant, o agir ético depende das circunstâncias e das consequências favoráveis ao agente.',
 'Ambos concordam que a emoção (dó/compaixão) é a única base segura para a moralidade.',
 'C',
 'A alternativa C está correta: Rousseau concebe o homem como naturalmente bom, sendo corrompido pela sociedade e, especialmente, pela instituição da propriedade privada. A alternativa A contraria diretamente essa premissa rousseauniana do "bom selvagem". A alternativa B é falsa, pois Kant defende justamente a autonomia da razão, e não a heteronomia religiosa, como fundamento da moralidade. A alternativa D contraria o formalismo kantiano, para o qual o valor ético está na intenção (dever), e não nas consequências. A alternativa E generaliza indevidamente, pois Kant rejeita expressamente a emoção/inclinação como base segura da moralidade, diferentemente de Rousseau.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (Rousseau e Kant, ética moderna), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Rousseau e Kant',
 'medio'),

-- Q15: Imperativo Categórico — proposições I, II, III
(@cat_ep11,
 'O Imperativo Categórico de Kant exige que o agente aja de forma universalizável. Analise as proposições abaixo sobre a ética kantiana: I. Agir por dever é o mesmo que agir em conformidade com o dever. II. A intencionalidade é irrelevante para Kant; o que importa é o resultado final da ação. III. O dever é a necessidade de realizar uma ação unicamente por respeito à lei moral. Está(ão) correta(s):',
 'Apenas I.',
 'Apenas III.',
 'Apenas I e II.',
 'Apenas II e III.',
 'I, II e III.',
 'B',
 'A alternativa B está correta: apenas a proposição III reflete corretamente a ética kantiana, segundo a qual o dever é a necessidade de agir unicamente por respeito à lei moral. A proposição I está incorreta porque, para Kant, "agir por dever" não é o mesmo que "agir em conformidade com o dever" — esta última pode ocorrer por inclinação ou interesse, sem valor moral genuíno, enquanto agir por dever exige que a motivação seja exclusivamente o respeito à lei moral. A proposição II também está incorreta, pois a intencionalidade é central na ética kantiana: é a intenção (motivação pelo dever), e não o resultado da ação, que determina seu valor moral.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (Imperativo Categórico e ética do dever de Immanuel Kant), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Kant, ética do dever',
 'dificil'),

-- Q16: Caso prático — Kant, criança salva de afogamento
(@cat_ep11,
 'Situação Hipotética: Um policial salva uma criança de um afogamento. Segundo a ética de Kant, essa ação possui valor ético genuíno apenas se:',
 'O policial agiu motivado pelo desejo de ser promovido ou receber uma medalha.',
 'O policial sentiu profunda pena (dó) da criança e agiu por impulso emocional.',
 'O policial agiu unicamente por respeito ao dever e à lei moral, independentemente de seus sentimentos ou inclinações pessoais.',
 'A mídia publicou o ato heroico, gerando uma imagem positiva para a corporação.',
 'A criança salva for filha de uma autoridade, garantindo o cumprimento da hierarquia.',
 'C',
 'A alternativa C está correta: para Kant, o valor ético genuíno de uma ação decorre exclusivamente da intenção de agir por dever e por respeito à lei moral, independentemente de sentimentos, inclinações ou interesses pessoais do agente. A alternativa A descreve uma motivação por interesse pessoal, que retira o caráter puramente ético da ação segundo Kant. A alternativa B descreve uma ação motivada por inclinação emocional (dó), que, embora louvável, não configura o agir por dever exigido pelo formalismo kantiano. As alternativas D e E introduzem fatores externos irrelevantes para a valoração ética kantiana da conduta.\n\n📜 Fundamento legal vigente: fundamento doutrinário/filosófico (ética do dever de Immanuel Kant aplicada a cenário policial), sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — Kant, ética do dever (aplicação prática)',
 'medio'),

-- Q17: Requisitos de uma profissão
(@cat_ep11,
 'Uma atividade humana só é tecnicamente caracterizada como "profissão" quando reúne requisitos específicos. Qual característica abaixo é indispensável para essa caracterização?',
 'Ser uma atividade baseada exclusivamente em tarefas manuais e repetitivas.',
 'Isenção total de responsabilidade individual sobre os resultados.',
 'Exigência de aprendizagem especial e domínio de técnicas transmissíveis.',
 'Ausência de organização grupal ou fiscalizatória.',
 'Dependência exclusiva de ordens superiores, sem margem para operações intelectuais.',
 'C',
 'A alternativa C está correta: a doutrina elenca, entre os requisitos indispensáveis de uma profissão, a exigência de aprendizagem especial e o domínio de técnicas transmissíveis, ao lado de operações intelectuais com responsabilidade individual e de organização grupal (conselhos/associações). A alternativa A restringe indevidamente a profissão a tarefas manuais e repetitivas, contrariando o elemento intelectual exigido. A alternativa B nega a responsabilidade individual, que é justamente um dos requisitos da profissão. A alternativa D contraria a exigência de organização grupal fiscalizatória. A alternativa E nega a autonomia intelectual do profissional, elemento central da definição.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre os requisitos técnicos da noção de profissão, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — requisitos da profissão',
 'facil'),

-- Q18: Códigos de ética — modelo misto
(@cat_ep11,
 'Quanto à natureza dos Códigos de Ética Profissional, a doutrina afirma que a maioria das profissões atuais utiliza modelos mistos. Isso significa que o código:',
 'Aplica-se tanto a profissionais quanto a criminosos.',
 'É composto por normas explícitas com sanções (normativo) e por valores/princípios orientadores (descritivo).',
 'Pode ser alterado conforme a vontade do cliente no momento do contrato.',
 'Mistura leis religiosas da Idade Média com leis modernas.',
 'É facultativo para os veteranos e obrigatório apenas para os novatos.',
 'B',
 'A alternativa B está correta: a doutrina afirma que a maioria dos códigos é mista, isto é, reúne normas explícitas com sanções (caráter normativo) e valores/princípios orientadores (caráter descritivo). A alternativa A distorce completamente o público-alvo dos códigos de ética profissional. A alternativa C nega a natureza cogente e institucional dos códigos, que não se submetem à vontade individual do cliente. A alternativa D é uma afirmação anacrônica sem correspondência doutrinária. A alternativa E cria uma distinção etária/hierárquica inexistente na aplicação dos códigos de ética.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre a natureza normativa/descritiva dos códigos de ética profissional, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — natureza dos códigos de ética',
 'medio'),

-- Q19: Objetivos dos códigos de ética (Camargo, 2004)
(@cat_ep11,
 'Segundo Camargo (2004), um dos objetivos centrais dos códigos de ética profissionais é:',
 'Garantir a impunidade dos membros da categoria em caso de erro técnico.',
 'Substituir a Constituição Federal no que tange aos direitos civis do profissional.',
 'Estabelecer parâmetros para que a conduta seja considerada regular sob o ângulo ético e amparar os interesses de terceiros/clientes.',
 'Criar um ambiente de competição desleal entre os membros da mesma classe.',
 'Proibir o profissional de exercer qualquer atividade intelectual fora do serviço.',
 'C',
 'A alternativa C está correta: entre os objetivos centrais elencados por Camargo (2004) estão estabelecer parâmetros para que a conduta seja considerada regular sob o ângulo ético e amparar os interesses de terceiros e clientes que se relacionam com o profissional. A alternativa A contraria a própria finalidade disciplinadora e protetiva do código. A alternativa B extrapola indevidamente a função do código de ética, que não substitui a Constituição. A alternativa D contraria o objetivo de harmonização e orientação de conduta dentro da categoria. A alternativa E não corresponde a nenhum objetivo doutrinário identificado para os códigos de ética.\n\n📜 Fundamento legal vigente: fundamento doutrinário (Camargo, 2004) sobre os objetivos dos códigos de ética profissional, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — objetivos dos códigos de ética (Camargo, 2004)',
 'medio'),

-- Q20: Valoração ética do agir profissional
(@cat_ep11,
 'O agir profissional está sujeito à valoração ética principalmente porque:',
 'O profissional possui autoridade divinizada sobre o cliente.',
 'O exercício da profissão inscreve-se no campo da ação e das escolhas que impactam a vida de outros seres humanos.',
 'A ética profissional é uma forma de evitar o pagamento de impostos.',
 'Todo profissional é, por definição, um ser humano sem vícios.',
 'A lei exige que a ética profissional seja baseada na utilidade econômica imediata.',
 'B',
 'A alternativa B está correta: o exercício profissional se inscreve no campo da ação e das escolhas humanas, e, por envolver a confiança pública e o bem-estar de terceiros, esse agir é passível de valoração ética. A alternativa A atribui indevidamente um caráter quase religioso à relação profissional-cliente. A alternativa C não guarda relação alguma com a finalidade da ética profissional. A alternativa D idealiza incorretamente a figura do profissional como isento de falhas morais. A alternativa E reduz indevidamente a ética profissional a uma questão de utilidade econômica.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre a valoração ética do agir profissional, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — valoração ética do agir profissional',
 'facil'),

-- Q21: Conselhos e associações profissionais
(@cat_ep11,
 'Sobre a função dos Conselhos e Associações Profissionais, a doutrina os identifica como:',
 'Organizações meramente decorativas sem poder de sanção.',
 'Elementos da organização grupal que exercem papel normativo, disciplinador e orientador.',
 'Órgãos estatais destinados a substituir o Poder Judiciário.',
 'Grupos subculturais que visam proteger práticas ilícitas.',
 'Instituições que eliminam a necessidade de ética pessoal do agente.',
 'B',
 'A alternativa B está correta: os conselhos e associações profissionais constituem elementos da organização grupal, exercendo papel normativo, disciplinador e orientador sobre os membros da categoria, sendo um dos requisitos que caracterizam uma atividade como profissão. A alternativa A nega o poder sancionatório real desses órgãos. A alternativa C atribui-lhes indevidamente uma função substitutiva do Poder Judiciário. A alternativa D deturpa completamente a finalidade legítima desses órgãos. A alternativa E é falsa, pois a organização grupal complementa, mas não elimina, a necessidade de ética pessoal do agente.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre a função dos conselhos e associações profissionais, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — conselhos e associações profissionais',
 'facil'),

-- Q22: Órgãos supervisores e confiança pública
(@cat_ep11,
 'A existência de um mecanismo ou órgão supervisor (como um conselho diretor com poderes disciplinares) é comum em profissões como Medicina e Direito. Por que esses órgãos são considerados essenciais?',
 'Para garantir que os profissionais recebam salários acima da média.',
 'Porque essas profissões lidam com a confiança pública, e os cidadãos necessitam de proteção contra a má conduta.',
 'Para impedir que a polícia interfira nas atividades desses profissionais.',
 'Porque a ética profissional substitui a necessidade de leis penais.',
 'Para promover a divulgação de informações confidenciais de clientes.',
 'B',
 'A alternativa B está correta: profissões como Medicina e Direito lidam diretamente com a confiança pública, o que exige a existência de órgãos supervisores capazes de garantir aos cidadãos proteção contra eventual má conduta profissional. A alternativa A não corresponde à finalidade institucional desses órgãos. A alternativa C não guarda relação com a razão de ser da supervisão ética. A alternativa D é falsa, pois a ética profissional coexiste com, e não substitui, as leis penais. A alternativa E contraria diretamente o dever de sigilo que esses órgãos normalmente reforçam.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre os órgãos supervisores das profissões que lidam com a confiança pública, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — órgãos supervisores e confiança pública',
 'medio'),

-- Q23: Caso prático — C. de Rover, "arte" da aplicação da lei
(@cat_ep11,
 'Situação Hipotética: Um Oficial de Polícia depara-se com uma ocorrência em que a aplicação literal e fria de um regulamento administrativo pode causar dano irreparável à dignidade de uma pessoa idosa, sem que isso traga benefício algum à ordem pública. De acordo com a doutrina de C. de Rover sobre a aplicação da lei, o policial deve:',
 'Ignorar o espírito da lei e aplicar a forma escrita de modo mecânico, evitando responsabilidades intelectuais.',
 'Agir de forma arbitrária, baseando-se apenas em sua vontade pessoal, acima da legislação nacional.',
 'Exercer a "arte" da aplicação da lei, compreendendo tanto o espírito quanto a forma da norma, distinguindo as "tonalidades de cinza" da situação concreta.',
 'Aguardar uma ordem superior por escrito, para não ter que realizar escolhas morais próprias.',
 'Aplicar a lei apenas se houver pressão da mídia ou da opinião pública local.',
 'C',
 'A alternativa C está correta: C. de Rover sustenta que a aplicação da lei não admite "soluções-padrão" e exige do encarregado a capacidade de exercer a "arte" de aplicar a norma, compreendendo tanto seu espírito quanto sua forma, e distinguindo as "tonalidades de cinza" presentes em cada situação concreta. A alternativa A descreve exatamente a postura mecânica que a doutrina rejeita. A alternativa B extrapola para a arbitrariedade, tão condenável quanto o formalismo cego. A alternativa D evade a responsabilidade intelectual e moral inerente à função policial. A alternativa E subordina indevidamente a aplicação da lei a fatores externos e contingentes, como a pressão midiática.\n\n📜 Fundamento legal vigente: fundamento doutrinário (C. de Rover, ética na aplicação da lei), sem lei numerada correspondente — questão distinta do CCEAL/ONU, tratando de doutrina complementar sobre a "arte" da aplicação da lei.',
 'Doutrina de Ética Profissional — C. de Rover, aplicação da lei',
 'dificil'),

-- Q24: Legalidade como distinção entre policial e infrator
(@cat_ep11,
 'Segundo a doutrina, qual é a essência do que separa os encarregados da aplicação da lei dos infratores (criminosos)?',
 'O poder de fogo superior e o uso de uniformes distintivos.',
 'A capacidade de agir fora da lei para combater o crime de forma mais eficiente.',
 'A plena legalidade de suas ações e a recusa absoluta em recorrer a práticas arbitrárias ou ilegais, mesmo diante da sensação de injustiça.',
 'A imunidade jurídica que permite ao policial não ser julgado por seus atos.',
 'A obediência cega a ordens superiores, ainda que manifestamente ilegais.',
 'C',
 'A alternativa C está correta: a distinção essencial entre o encarregado da aplicação da lei e o infrator reside na plena legalidade de suas ações e na recusa em recorrer a práticas arbitrárias ou ilegais — quando o agente adota práticas ilegais, essa distinção desaparece, e sua autoridade perde legitimidade. A alternativa A reduz a distinção a elementos meramente instrumentais, irrelevantes para a legitimidade da ação. A alternativa B contraria frontalmente a própria essência da legalidade que fundamenta a autoridade policial. A alternativa D não corresponde a nenhuma prerrogativa doutrinária ou legal reconhecida. A alternativa E confunde disciplina com obediência cega, que a doutrina rejeita expressamente diante de ordens manifestamente ilegais.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre a legitimidade da autoridade policial pela legalidade da ação, sem lei numerada específica citada nesta questão (matéria correlata ao CCEAL/ONU, tratado em questões específicas desta disciplina).',
 'Doutrina de Ética Profissional — legalidade da aplicação da lei',
 'medio'),

-- Q25: Ética de Grupo e subculturas policiais
(@cat_ep11,
 'O trabalho policial ocorre frequentemente em grupos isolados, o que pode gerar o fenômeno da "Ética de Grupo". Sobre isso, a doutrina alerta para o perigo de:',
 'Fortalecimento excessivo da ética profissional codificada.',
 'Surgimento de padrões subculturais (rituais, linguagem própria e o binômio "nós contra eles") que podem levar a práticas questionáveis e escândalos.',
 'Melhora automática da autoestima do policial por meio do corporativismo cego.',
 'Dissolução total da ética pessoal, o que é visto pela doutrina como algo positivo para a disciplina.',
 'Eliminação da necessidade de supervisão por oficiais superiores.',
 'B',
 'A alternativa B está correta: a pressão do grupo isolado pode gerar subculturas de confronto, com rituais próprios, linguagem específica e o binômio "nós contra eles", desviando o agente da legalidade e podendo resultar em escândalos de corrupção ou violência. A alternativa A inverte o sinal do alerta doutrinário, que trata do enfraquecimento, não do fortalecimento, da ética codificada diante da ética de grupo informal. A alternativa C descreve como positivo algo que a doutrina trata como risco. A alternativa D trata como "positivo" algo que a doutrina expressamente condena. A alternativa E é falsa, pois a supervisão superior é justamente um dos mecanismos para conter os riscos da ética de grupo.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre o fenômeno da "ética de grupo" no trabalho policial isolado, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — ética de grupo e subculturas policiais',
 'medio'),

-- Q26: CCEAL — uso da força (reescrita — retirado "Artigo 3º" do enunciado)
(@cat_ep11,
 'Diante de uma situação de resistência à ordem legal emanada de sua função, o padrão internacional de conduta consolidado pelo Código de Conduta da ONU para os Encarregados da Aplicação da Lei (CCEAL) orienta que o emprego da força pelo agente deve ser:',
 'A primeira opção do agente, para garantir o respeito imediato à sua autoridade.',
 'Proibido em qualquer situação, devendo o policial recuar diante de qualquer resistência armada.',
 'Utilizado apenas quando estritamente necessário e na medida exigida para o cumprimento do dever, observada a proporcionalidade.',
 'Livre contra suspeitos de crimes hediondos, independentemente de resistência.',
 'Aplicado apenas mediante autorização prévia e expressa do Poder Judiciário em cada abordagem.',
 'C',
 'A alternativa C está correta: o CCEAL limita o emprego da força ao critério da estrita necessidade e da proporcionalidade em relação ao dever a ser cumprido, sendo a força um recurso excepcional, não a primeira opção. A alternativa A contraria justamente a excepcionalidade do uso da força defendida pelo Código. A alternativa B é irrealista e não corresponde ao padrão internacional, que admite o uso proporcional da força quando necessário. A alternativa D descreve uso desproporcional e arbitrário da força, vedado pelo Código. A alternativa E cria uma exigência de autorização judicial prévia inexistente no CCEAL, que trata do momento da ação policial, não de um controle judicial casuístico anterior.\n\n📜 Fundamento legal vigente: Código de Conduta para os Encarregados da Aplicação da Lei (CCEAL), Resolução 34/169 da Assembleia Geral da ONU (1979), art. 3º (uso da força na medida da estrita necessidade e proporcionalidade ao dever).',
 'CCEAL (Res. 34/169-ONU, 1979), art. 3º',
 'medio'),

-- Q27: CCEAL — confidencialidade (reescrita — retirado "Artigo 4º" do enunciado)
(@cat_ep11,
 'Situação Hipotética: Um policial detém um indivíduo e, durante o procedimento, obtém informações sobre a vida privada da esposa do detido, sem relação direta com o crime investigado. Segundo os padrões de conduta consolidados pela ONU (CCEAL) sobre o sigilo de informações obtidas no exercício da função, o policial deve:',
 'Divulgar as informações aos colegas para fins de descontração e fortalecimento do grupo.',
 'Manter o sigilo, pois a divulgação de informações confidenciais que prejudiquem a reputação de terceiros é imprópria, salvo se o cumprimento do dever ou a realização da justiça exigirem estritamente o contrário.',
 'Usar a informação como moeda de troca para obter uma confissão do detido.',
 'Publicar os dados em redes sociais, para alertar a comunidade sobre a índole da família do investigado.',
 'Ignorar a regra de confidencialidade, pois criminosos e seus familiares não possuem direito à privacidade.',
 'B',
 'A alternativa B está correta: o padrão de conduta consolidado pela ONU destaca que os encarregados da aplicação da lei frequentemente obtêm informações íntimas de terceiros e devem abster-se de revelá-las, protegendo a reputação alheia, salvo se o cumprimento do dever ou a realização da justiça exigirem estritamente o contrário. A alternativa A descreve um uso indevido e informal da informação, incompatível com o dever de sigilo. A alternativa C configura desvio de finalidade e possível coação, prática vedada. A alternativa D expõe indevidamente terceiros inocentes, violando o dever de confidencialidade. A alternativa E nega, de forma equivocada, que familiares de investigados também possuam direito à privacidade e à reputação protegida.\n\n📜 Fundamento legal vigente: CCEAL (Res. 34/169-ONU, 1979), art. 4º (dever de confidencialidade sobre informações obtidas no exercício da função, ressalvado o estrito cumprimento do dever ou a exigência da justiça).',
 'CCEAL (Res. 34/169-ONU, 1979), art. 4º',
 'dificil'),

-- Q28: CCEAL — prevenção e comunicação de violações (reescrita — retirado "Artigo 8º" do enunciado)
(@cat_ep11,
 'Situação Hipotética: Um agente presencia um ato de tortura cometido por um colega de farda contra um detido. Segundo os padrões de conduta consolidados pela ONU (CCEAL) sobre a prevenção e a notificação de violações ao próprio Código, a orientação correta é que o agente:',
 'Mantenha o silêncio em nome da lealdade ao grupo e da "ética de grupo".',
 'Comunique o fato apenas se for formalmente interrogado por uma autoridade externa.',
 'Previna a violação e, caso já tenha ocorrido, comunique o fato aos seus superiores e, se necessário, a autoridades com poder de revisão ou reparação.',
 'Tente apenas convencer o colega a não repetir o ato, sem formalizar qualquer denúncia, para evitar conflitos internos.',
 'Aplique uma punição física imediata ao colega, para restaurar a ética no local.',
 'C',
 'A alternativa C está correta: o padrão internacional consolidado pela ONU exorta os encarregados da aplicação da lei a prevenirem violações ao Código e, caso ocorridas, a reportá-las a seus superiores ou a outras instâncias com poder de revisão ou reparação. A alternativa A descreve exatamente o comportamento de encobrimento que o Código busca combater, associado ao fenômeno da "ética de grupo". A alternativa B condiciona indevidamente o dever de comunicação a uma provocação externa, quando o dever de reportar é proativo. A alternativa D é insuficiente, pois a mera conversa informal com o colega não substitui o dever de formalizar a comunicação a instâncias competentes. A alternativa E descreve conduta ilegal (justiça com as próprias mãos), incompatível com a legalidade exigida do agente.\n\n📜 Fundamento legal vigente: CCEAL (Res. 34/169-ONU, 1979), art. 8º (dever de prevenção e comunicação de violações ao Código a superiores ou autoridades com poder de revisão/reparação).',
 'CCEAL (Res. 34/169-ONU, 1979), art. 8º',
 'medio'),

-- Q29: Efeito institucional do comportamento antiético individual
(@cat_ep11,
 'Ao tratar das noções essenciais para a aplicação da lei, a doutrina destaca que o comportamento antiético de um agente isolado:',
 'Não afeta a imagem da corporação, pois a responsabilidade é meramente individual.',
 'É justificado se houver ordens superiores ou circunstâncias excepcionais, como estado de sítio.',
 'Reflete negativamente em toda a corporação, possuindo efeito prejudicial à confiança pública.',
 'Deve ser ignorado pela gestão, para não gerar estatísticas negativas de indisciplina.',
 'É consequência natural da profissão, que não requer investigação alguma.',
 'C',
 'A alternativa C está correta: mesmo sendo a responsabilidade atribuída ao indivíduo, situações antiéticas isoladas possuem efeito prejudicial que reflete negativamente em toda a corporação, abalando a confiança pública na instituição. A alternativa A ignora esse efeito institucional reconhecido pela doutrina. A alternativa B contraria a premissa de que ordens superiores ou circunstâncias excepcionais não justificam ilegalidades ou condutas antiéticas. A alternativa D descreve uma omissão de gestão incompatível com a responsabilidade institucional. A alternativa E nega a necessidade de apuração, que é justamente o mecanismo para preservar a confiança pública.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre o efeito institucional do comportamento antiético individual, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — efeito institucional da conduta antiética individual',
 'facil'),

-- Q30: Superação de paradigmas institucionais autoritários
(@cat_ep11,
 'A conclusão da doutrina estudada aponta para a necessidade de superação de velhos paradigmas institucionais. Para que a polícia seja um personagem central da democracia, ela deve enfrentar quais desafios específicos?',
 'Manter a ideologia militar da Guerra Fria, para garantir a segurança nacional contra inimigos internos.',
 'Fortalecer o corporativismo no acobertamento de práticas incompatíveis com a missão policial.',
 'Superar sequelas do período ditatorial, como o ranço autoritário no exercício do poder e a crença na truculência em vez da técnica.',
 'Priorizar a Segurança Pública em detrimento dos Direitos Humanos, sempre que houver conflito entre ambos.',
 'Ignorar as parcerias com organizações não governamentais, para manter a autonomia institucional.',
 'C',
 'A alternativa C está correta: a doutrina propõe o paradigma de "Segurança Pública com Direitos Humanos", elencando como obstáculos a serem superados os resquícios autoritários do período ditatorial, a ideologia da Guerra Fria e a crença na truculência como substituto da técnica profissional. A alternativa A descreve exatamente um dos paradigmas que devem ser superados, não mantidos. A alternativa B propõe o fortalecimento de uma prática que a doutrina condena. A alternativa D contraria o próprio paradigma proposto, que integra segurança pública e direitos humanos, sem hierarquia automática de um sobre o outro. A alternativa E contraria a abertura institucional para parcerias externas defendida pela doutrina contemporânea de segurança pública.\n\n📜 Fundamento legal vigente: fundamento doutrinário sobre a superação de paradigmas institucionais autoritários na segurança pública democrática, sem lei numerada correspondente.',
 'Doutrina de Ética Profissional — paradigma "Segurança Pública com Direitos Humanos"',
 'medio');

SET foreign_key_checks = 1;
