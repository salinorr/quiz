-- ============================================================
-- QUIZ — Disciplina 20/20 do CHO: Trabalho de Comando
-- 30 questões — ÚLTIMA disciplina do mapeamento das 20 disciplinas do CHO
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: "Trabalho de Comando.pdf", Academia Coronel Walterler —
--   correntes e teorias da liderança (Centrada no Líder, nos Seguidores, na
--   Situação, Integradora); distinção Comando x Liderança; pilares Saber/
--   Ser/Fazer; valores militares (Honra, Honestidade, Espírito de Corpo);
--   estilos de comando (autocrático, participativo, delegativo) e sua
--   alternância situacional; níveis de comando (pequenos escalões,
--   organizacional/tático, estratégico); camaradagem e coesão sob risco;
--   orientações práticas do comandante (interesse do serviço x subordinados,
--   contraordens, ponderação, elogio, Auftragstaktik, coragem moral, projeto
--   de comando e formação de novos líderes)
-- Observação sobre a fonte: disciplina de doutrina de liderança militar,
--   mesma natureza da Disciplina 6 (Chefia e Liderança Militar) — sem lei
--   pública numerada correspondente — NÃO há legislação para baixar nesta
--   disciplina. Por analogia, quando o tema é ética/valores militares, as
--   questões remetem ao Estatuto dos Militares de Roraima (LC 194/2012,
--   art. 39) e ao CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia
--   Militar), já documentados nas seções 1 e 2 da base de conhecimento de
--   legislação do projeto.
-- ============================================================
SET NAMES utf8mb4;

-- Cria a categoria so se ainda nao existir. NAO usar INSERT IGNORE: categorias.nome
-- nao tem indice UNIQUE, entao o IGNORE nao dedupe e cria uma categoria duplicada vazia.
INSERT INTO categorias (nome, descricao)
SELECT 'Trabalho de Comando — CHO 20', 'Disciplina 20/20 do CHO — Correntes e teorias da liderança, distinção Comando x Liderança, pilares Saber/Ser/Fazer, valores militares, estilos e níveis de comando, camaradagem e orientações práticas do comandante ("Trabalho de Comando.pdf")'
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categorias WHERE nome = 'Trabalho de Comando — CHO 20');

SET @cat_tc20 = (SELECT id FROM categorias WHERE nome = 'Trabalho de Comando — CHO 20' ORDER BY id LIMIT 1);

-- Aposenta questoes ja carregadas desta categoria (idempotente em recarga; FK RESTRICT).
UPDATE questoes SET ativa = 0 WHERE categoria_id = @cat_tc20;

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Corrente Centrada na Figura do Líder
(@cat_tc20,
 'Um Tenente da Polícia Militar acredita que sua capacidade de comandar advém exclusivamente de sua personalidade forte e de suas qualidades inatas, minimizando as variáveis ambientais e os anseios de seus subordinados. De acordo com a doutrina de Trabalho de Comando, essa postura alinha-se a qual corrente de pensamento sobre liderança?',
 'Corrente Centrada na Situação.',
 'Corrente Centrada nos Seguidores.',
 'Corrente Centrada na Figura do Líder.',
 'Corrente Integradora.',
 'Corrente Contingencial.',
 'C',
 'A alternativa C está correta: a Corrente Centrada na Figura do Líder foca no que o líder "é" e "faz", explicando o comando a partir de traços pessoais e qualidades inatas, com pouca atenção às variáveis do ambiente ou do grupo — exatamente a postura do Tenente. A alternativa A está incorreta porque a corrente situacional valoriza justamente o tempo e o lugar da ação, ao contrário do enunciado. A alternativa B está incorreta porque a corrente centrada nos seguidores explica o líder como produto do grupo, não de traços pessoais isolados. A alternativa D está incorreta porque a corrente integradora soma múltiplos fatores (líder, liderados, situação, interação), o que o Tenente rejeita. A alternativa E descreve nomenclatura não utilizada pela doutrina de referência.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário, não legal — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao classificar a Corrente Centrada na Figura do Líder entre as correntes teóricas da liderança militar. Trata-se de doutrina interna, sem lei pública numerada correspondente nesta disciplina.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q02: Líder Emergente
(@cat_tc20,
 'Durante uma operação de socorro em uma grande calamidade, um Sargento destaca-se não por sua patente, mas por representar fielmente os anseios e o ideal do grupo naquele momento crítico, sendo reconhecido pelos pares como a voz do coletivo. Esse fenômeno descreve o:',
 'Líder Autocrático.',
 'Líder Emergente.',
 'Líder Estratégico.',
 'Líder por Proficiência Técnica.',
 'Líder por Autoridade Legal.',
 'B',
 'A alternativa B está correta: o Líder Emergente desponta como produto do grupo e do meio social, representando os anseios e ideais coletivos em determinado momento, independentemente do posto ou cargo formal ocupado. A alternativa A confunde o fenômeno com um estilo de comando (autocrático), tema distinto. A alternativa C associa erroneamente o fenômeno a um nível de comando (estratégico), que se define pelo escalão hierárquico, não pela emergência espontânea de liderança. A alternativa D restringe o fenômeno à competência técnica, quando o que se destaca no caso é a representatividade social do Sargento perante o grupo. A alternativa E é incorreta porque o Sargento não se destacou por autoridade legal (patente), mas apesar dela.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever o líder emergente no âmbito da Corrente Centrada nos Seguidores. Não há lei pública correspondente para esta disciplina.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q03: Corrente Centrada na Situação
(@cat_tc20,
 'Considere a seguinte afirmação doutrinária: "a liderança é um fenômeno que depende de variáveis contextuais, de modo que não basta possuir certas qualidades sem considerar o lugar ou o tempo da ação". Essa visão é característica da:',
 'Corrente Centrada na Situação.',
 'Corrente Centrada no Líder.',
 'Liderança Direta.',
 'Teoria dos Grandes Homens.',
 'Liderança Indireta.',
 'A',
 'A alternativa A está correta: a Corrente Centrada na Situação relativiza o fenômeno da liderança ao tempo e ao lugar da ação, sustentando que as competências exigidas do líder variam conforme as circunstâncias enfrentadas. A alternativa B está incorreta porque a corrente centrada no líder valoriza justamente as qualidades pessoais isoladas, com pouca atenção ao contexto. As alternativas C e E descrevem formas de exercício da liderança (direta e indireta), não correntes teóricas explicativas do fenômeno. A alternativa D refere-se a uma teoria específica associada à corrente centrada no líder (o "grande homem" que muda o curso dos acontecimentos por vontade própria), o oposto da relatividade contextual descrita no enunciado.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever a Corrente Centrada na Situação. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q04: Corrente Integradora
(@cat_tc20,
 'A Corrente Integradora propõe uma visão sistêmica da liderança. Segundo essa doutrina, o fenômeno manifesta-se por meio de:',
 'Uma hierarquia rígida onde o líder é o único elemento determinante.',
 'Sistemas com múltiplas possibilidades de interação entre líder, liderados, situação e interação.',
 'A negação completa das qualidades individuais do comandante.',
 'A aplicação exclusiva de táticas de persuasão geopolítica.',
 'Um modelo focado apenas nas contingências vividas pelo grupo.',
 'B',
 'A alternativa B está correta: a Corrente Integradora enxerga o fenômeno da liderança como um sistema com múltiplas possibilidades de interação entre os quatro fatores (líder, liderados, situação e interação), e não como um elemento isolado. A alternativa A contraria a própria ideia de sistema integrado, ao concentrar tudo no líder isoladamente. A alternativa C é falsa, pois a corrente não nega as qualidades do comandante, apenas as insere em um sistema mais amplo. A alternativa D restringe indevidamente o conceito a um só instrumento (persuasão geopolítica), típico do nível estratégico, não da corrente integradora como um todo. A alternativa E descreve, de forma incompleta, apenas a corrente situacional, e não a integração sistêmica proposta por esta corrente.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever a Corrente Integradora e sua visão sistêmica da liderança. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q05: Liderança Direta — instrumento fundamental
(@cat_tc20,
 'Na modalidade de Liderança Direta, comum nos pequenos escalões, o instrumento fundamental para a construção de credibilidade e o estabelecimento de laços com os subordinados é:',
 'A emissão de boletins internos e videoconferências.',
 'O fornecimento de exemplos pessoais e a comunicação frequente.',
 'O distanciamento em gabinetes para preservação da imagem do comandante.',
 'A delegação integral de decisões a assessores técnicos.',
 'O uso de intermediários para evitar o desgaste da autoridade.',
 'B',
 'A alternativa B está correta: a liderança direta constrói credibilidade e vínculos por meio do exemplo pessoal constante e da comunicação frequente entre líder e liderados, com contato próximo e recorrente. A alternativa A descreve instrumentos típicos da liderança indireta, usados justamente quando o contato pessoal é inviável. A alternativa C é o oposto do recomendado, pois o isolamento em gabinete rompe o vínculo que a liderança direta pretende construir. A alternativa D descreve delegação típica do estilo delegativo, tema distinto da forma de exercício (direta/indireta). A alternativa E contraria a essência da liderança direta, que dispensa intermediários justamente para fortalecer o contato pessoal.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever a Liderança Direta e seus instrumentos característicos. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q06: Liderança Indireta — cadeia de transmissão fiel
(@cat_tc20,
 'No exercício da Liderança Indireta, para garantir que a intenção do Comandante do topo da pirâmide hierárquica chegue fielmente ao último escalão, é imprescindível que:',
 'O Comandante ignore os escalões intermediários.',
 'Os líderes intermediários aceitem e transmitam as ideias como se fossem suas, evitando distorções.',
 'A comunicação seja feita apenas por documentos formais sigilosos.',
 'Os subordinados ajam por iniciativa própria, sem diretrizes superiores.',
 'O líder se isole para evitar a influência da esfera informal.',
 'B',
 'A alternativa B está correta: na liderança indireta, a fidelidade da mensagem depende de os líderes intermediários incorporarem a intenção do comando superior e a transmitirem como própria, evitando distorções na cadeia de liderança. A alternativa A é incorreta porque ignorar os escalões intermediários é justamente o que rompe a cadeia e compromete a fidelidade da mensagem. A alternativa C restringe indevidamente os meios de comunicação, quando a doutrina admite boletins, diretrizes e tecnologia da informação de modo mais amplo, não apenas documentos sigilosos. A alternativa D contraria o próprio conceito de transmissão fiel de uma intenção superior, substituindo-a por ação desvinculada de diretrizes. A alternativa E é incorreta, pois o isolamento do líder prejudica, e não favorece, a liderança indireta eficaz.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever a Liderança Indireta e a necessidade de fidelidade na cadeia de transmissão da intenção do comando. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q07: Distinção Comando x Liderança
(@cat_tc20,
 'No contexto das instituições militares, é correto diferenciar "Comando" de "Liderança" da seguinte forma:',
 'Comando é a influência informal; Liderança é o poder delegado por leis.',
 'Liderança refere-se apenas à gestão de materiais e finanças da unidade.',
 'Comando é o exercício profissional de um cargo investido de autoridade legal; Liderança emerge do trato humano e do respeito à pessoa.',
 'Todo administrador é automaticamente um líder militar por força do cargo que ocupa.',
 'O Comando opera na esfera informal, enquanto a Liderança opera na esfera estritamente legal.',
 'C',
 'A alternativa C está correta: Comando é o exercício profissional de um cargo investido de autoridade legal (esfera formal), enquanto Liderança é processo que emerge do trato humano e do respeito à pessoa (esfera informal). As alternativas A e E invertem exatamente essas esferas, atribuindo à liderança o caráter legal e ao comando o caráter informal. A alternativa B restringe indevidamente a liderança à gestão de materiais e finanças, que é, na verdade, atribuição da esfera formal do comando/gerência. A alternativa D é falsa, pois o cargo formal (administração) não confere automaticamente a condição de líder, já que a liderança depende do reconhecimento informal dos liderados.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao diferenciar Comando (esfera formal) de Liderança (esfera informal). Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q08: Pilar Proficiência Profissional
(@cat_tc20,
 'O pilar da Liderança Militar que se refere especificamente à capacidade técnica, ao conhecimento e à cultura do militar para o desempenho de sua função é a:',
 'Atitude Adequada.',
 'Proficiência Profissional.',
 'Senso Moral.',
 'Disciplina Intelectual.',
 'Coragem Física.',
 'B',
 'A alternativa B está correta: a Proficiência Profissional (pilar "Saber") corresponde à capacidade técnica, ao conhecimento e à cultura necessários ao desempenho da função militar. A alternativa A (Atitude Adequada/"Fazer") refere-se à forma prática de agir e executar, não ao conhecimento técnico em si. A alternativa C (Senso Moral/"Ser") refere-se à incorporação de valores e caráter, tema distinto da competência técnica. As alternativas D e E não correspondem aos pilares doutrinários da liderança militar (Saber, Ser e Fazer), sendo "Disciplina Intelectual" e "Coragem Física" conceitos correlatos, mas não sinônimos do pilar cobrado.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao definir o pilar Saber (Proficiência Profissional) entre os pilares Saber/Ser/Fazer da liderança militar. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q09: Pilar Senso Moral — uso indevido de recursos
(@cat_tc20,
 'Situação Hipotética: um Comandante de Companhia decide utilizar os recursos da unidade para realizar uma reforma em sua residência particular, negligenciando a manutenção do alojamento da tropa. Segundo a doutrina de Trabalho de Comando, esse oficial falhou no pilar:',
 'Proficiência Profissional (Saber).',
 'Atitude Adequada (Fazer).',
 'Senso Moral (Ser).',
 'Liderança Delegativa.',
 'Persuasão Estratégica.',
 'C',
 'A alternativa C está correta: o desvio de recursos da unidade para benefício pessoal, em detrimento da tropa, é falha do pilar Senso Moral (Ser), que trata da incorporação de valores éticos e do uso do poder do cargo para o bem comum, não para vantagem pessoal. A alternativa A é falsa, pois nada no cenário indica falta de conhecimento técnico do Comandante. A alternativa B está incorreta porque o problema não está na execução técnica de uma tarefa, mas no caráter e na ética da decisão tomada. As alternativas D e E não correspondem a pilares da liderança militar, mas a estilos e competências distintos, sem relação direta com a conduta antiética relatada.\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto ao pilar Senso Moral (Ser). Por analogia, o desvio de recursos públicos em proveito próprio também ofende o dever de conduta idônea do Estatuto dos Militares de Roraima (LC 194/2012, art. 39) e os preceitos éticos do CEDM/RR (Lei 963/2014, arts. 15 a 22), sem que estes dispositivos definam tecnicamente o "pilar Ser", conceito exclusivo da doutrina de liderança.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler; LC 194/2012 (RR), art. 39 (analogia)',
 'medio'),

-- Q10: Pilar Atitude Adequada
(@cat_tc20,
 'O pilar das Atitudes Adequadas (Fazer) na liderança militar manifesta-se quando o militar:',
 'Adquire novos conhecimentos técnicos em cursos de especialização.',
 'Emprega os valores e competências de sua personalidade com as ferramentas que seus conhecimentos oferecem.',
 'Decide utilizar o poder do cargo para obter vantagens financeiras.',
 'Limita-se ao cumprimento burocrático de normas sem interagir com o grupo.',
 'Foca exclusivamente na manutenção de equipamentos e viaturas.',
 'B',
 'A alternativa B está correta: o pilar Fazer (Atitude Adequada) manifesta-se quando o militar emprega, na prática, os valores e competências de seu caráter, combinando-os com as ferramentas que o conhecimento técnico ("Saber") lhe oferece. A alternativa A descreve, na verdade, o próprio desenvolvimento do pilar Saber (aquisição de conhecimento), não sua aplicação prática. A alternativa C descreve conduta antiética, falha do pilar Ser, e não uma atitude adequada. A alternativa D descreve postura burocrática e distante, incompatível com a ideia de "Fazer" como aplicação efetiva de valores e competências junto ao grupo. A alternativa E restringe indevidamente o conceito à gestão material, sem relação com a aplicação prática de valores e competências pessoais.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao definir o pilar Fazer (Atitude Adequada). Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q11: Capacidade de liderança x desenvolvimento da liderança
(@cat_tc20,
 'A doutrina de Trabalho de Comando prefere o termo "desenvolvimento da capacidade de liderança" em vez de "desenvolvimento da liderança" porque:',
 'A liderança é um dom inato e não pode ser aprimorado sob nenhuma circunstância.',
 'O desenvolvimento da capacidade contribui para o fenômeno, mas não garante que o indivíduo se tornará efetivamente um líder.',
 'A capacidade técnica é a única variável relevante no ambiente de combate.',
 'A liderança militar depende apenas do cumprimento rígido de regulamentos disciplinares.',
 'O termo "liderança" é reservado exclusivamente ao nível estratégico de comando.',
 'B',
 'A alternativa B está correta: a doutrina explica que o treinamento e a formação desenvolvem a capacidade de liderar (competências, conhecimentos, atitudes), mas isso não garante, por si só, que o militar será reconhecido como líder pelo grupo — a liderança depende também do reconhecimento e da aceitação dos liderados. A alternativa A contraria a própria premissa do treinamento de capacidades, que pressupõe que a liderança pode ser desenvolvida, ainda que não integralmente garantida. A alternativa C ignora que a doutrina também valoriza fatores morais e afetivos, além da técnica. A alternativa D reduz indevidamente a liderança à disciplina regulamentar, quando ela envolve também vínculos afetivos e reconhecimento do grupo. A alternativa E não corresponde a nenhuma limitação doutrinária de escalão para o uso do termo "liderança".\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao justificar a preferência terminológica por "desenvolvimento da capacidade de liderança". Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'dificil'),

-- Q12: Honra e Honestidade — definições
(@cat_tc20,
 'Os conceitos de "consciência da própria dignidade" e de "senso moral e consciência" definem, respectivamente, quais valores militares?',
 'Justiça e Honestidade.',
 'Honra e Honestidade.',
 'Verdade e Justiça.',
 'Lealdade e Patriotismo.',
 'Espírito de Corpo e Civismo.',
 'B',
 'A alternativa B está correta: a "consciência da própria dignidade" define o valor da Honra, enquanto o "senso moral e consciência" define a Honestidade, ambos elementos que compõem a integridade de caráter do líder militar. A alternativa A troca indevidamente Honra por Justiça, conceito relacionado à equidade no trato com os subordinados, não à dignidade pessoal. A alternativa C associa os conceitos a Verdade e Justiça, valores distintos dos descritos no enunciado. A alternativa D refere-se a Lealdade (fidelidade a valores/pessoas) e Patriotismo (amor à pátria), sem relação direta com as definições apresentadas. A alternativa E refere-se ao orgulho coletivo de grupo (Espírito de Corpo) e ao dever de cidadania (Civismo), conceitos igualmente distintos dos definidos no enunciado.\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto às definições de Honra e Honestidade como valores básicos do líder. Por analogia, esses valores também são exigidos do militar pelo Estatuto dos Militares de Roraima (LC 194/2012, art. 39) e pelo CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia Militar), sem que estes diplomas repitam as definições filosóficas trazidas pela doutrina.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'medio'),

-- Q13: Alternância de estilos — autocrático prolongado
(@cat_tc20,
 'Situação Hipotética: em um combate urbano sob intenso estresse, um Capitão emite ordens diretas e imediatas sem consultar seus subordinados. Meses depois, em tempo de paz, ele mantém exatamente o mesmo comportamento para todas as decisões administrativas da unidade. Sobre a adequação desse estilo de comando, é correto afirmar que:',
 'O estilo é incorreto em ambas as situações, pois o líder deve ser sempre participativo.',
 'O estilo é adequado para a situação de estresse do combate, mas seu uso prolongado em tempo de paz tende a desgastar os vínculos afetivos com a tropa.',
 'O estilo autocrático é o ideal para a gestão administrativa de longo prazo em qualquer unidade.',
 'O uso desse estilo isenta o comandante de qualquer responsabilidade técnica pelas decisões.',
 'O estilo participativo deveria ter sido usado no combate urbano para garantir a democracia interna da fração.',
 'B',
 'A alternativa B está correta: o estilo autocrático é útil e recomendado em situações de estresse e urgência, como o combate imediato, mas seu uso prolongado e indiscriminado — inclusive em tempo de paz, para decisões administrativas — tende a desgastar os vínculos afetivos e a confiança da tropa. A alternativa A é falsa, pois nem sempre o estilo participativo é o mais adequado; em combate, a centralização de decisões pode salvar vidas. A alternativa C contraria a própria doutrina, que recomenda a alternância situacional de estilos, não a rigidez do autocrático em qualquer contexto. A alternativa D está incorreta, pois nenhum estilo de comando isenta o comandante de responsabilidade técnica pelas decisões tomadas. A alternativa E é falsa, pois o estilo participativo seria inadequado e perigoso justamente no combate urbano sob fogo, quando a urgência exige centralização.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto à adequação situacional do estilo autocrático e aos riscos de seu uso prolongado fora do contexto de crise. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'dificil'),

-- Q14: Estilo Participativo
(@cat_tc20,
 'O Comandante que busca o engajamento de todos os subordinados, aproveitando as ideias do grupo para subsidiar a tomada de decisão, sem abrir mão de sua responsabilidade final pelo resultado, adota o estilo:',
 'Autocrático.',
 'Delegativo.',
 'Participativo.',
 'Indireto.',
 'Burocrático.',
 'C',
 'A alternativa C está correta: no estilo Participativo (democrático), o comandante busca o engajamento e aproveita as ideias do grupo antes de decidir, mas mantém para si a responsabilidade final pela decisão. A alternativa A descreve o estilo oposto, em que o comandante centraliza as decisões sem consulta ao grupo. A alternativa B está incorreta porque, no estilo delegativo, a própria tomada de decisão é transferida ao subordinado, e não apenas suas ideias são aproveitadas. A alternativa D refere-se a uma forma de exercício da liderança (indireta), e não a um estilo de tomada de decisão. A alternativa E não corresponde a nenhum dos estilos clássicos de comando descritos pela doutrina.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever o estilo Participativo entre os estilos clássicos de comando. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q15: Estilo Delegativo — equipe técnica
(@cat_tc20,
 'Situação Hipotética: uma seção técnica de informática da corporação é composta por especialistas de alto nível. O Comandante da unidade atribui a esses militares a própria tomada de decisões especializadas sobre a arquitetura da rede corporativa. Esse cenário exemplifica o estilo:',
 'Autocrático, pela centralização de metas.',
 'Delegativo, indicado para grupos que tratam de assuntos de natureza técnica e especializada.',
 'Participativo, pois o líder não tomou a decisão sozinho.',
 'Direto, pelo contato interpessoal próximo com a equipe.',
 'Estratégico, por lidar com tecnologia de ponta.',
 'B',
 'A alternativa B está correta: o estilo Delegativo é indicado para grupos técnicos e especializados, nos quais o comandante transfere a própria tomada de decisão à equipe que detém o conhecimento específico, como no caso da seção de informática. A alternativa A é o oposto do relatado, pois não há centralização de metas pelo comandante. A alternativa C está incorreta porque, no estilo participativo, o comandante mantém a decisão final para si, apenas ouvindo o grupo — o que não ocorre no cenário, em que a decisão é integralmente atribuída à equipe técnica. A alternativa D confunde forma de exercício (direta/indireta) com estilo de tomada de decisão, temas distintos na doutrina. A alternativa E rotula erroneamente o cenário como "nível estratégico" apenas pela menção a tecnologia, quando o que está em jogo é o estilo de decisão adotado, não o escalão hierárquico.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever o estilo Delegativo como adequado a grupos técnicos especializados. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q16: Liderança Direta — Pequenos Escalões
(@cat_tc20,
 'Nos Pequenos Escalões (esquadras, grupos e pelotões), a forma de liderança que predomina, exigindo que o líder seja visto e ouvido frequentemente pelos comandados, é a:',
 'Liderança Indireta.',
 'Liderança Estratégica.',
 'Liderança Direta.',
 'Liderança Organizacional.',
 'Gestão Geopolítica.',
 'C',
 'A alternativa C está correta: nos pequenos escalões, a Liderança Direta é a forma predominante, exigindo que o líder esteja fisicamente presente, seja visto e ouvido com frequência pelos comandados. A alternativa A é o oposto do que ocorre nesse nível, sendo típica de escalões mais distantes, como o estratégico. A alternativa B não é nomenclatura doutrinária de forma de liderança, mas de nível de comando. A alternativa D não corresponde a uma "forma" de liderança na classificação da doutrina, que trata separadamente formas de exercício (direta/indireta) e níveis de comando (pequenos escalões, organizacional/tático, estratégico). A alternativa E é estranha ao vocabulário da doutrina de Trabalho de Comando.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao definir o Nível de Comando de Pequenos Escalões e a predominância da liderança direta. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q17: Nível Organizacional/Tático — interface de relações
(@cat_tc20,
 'No Nível Organizacional/Tático de comando, o distanciamento físico entre o Comandante e as subunidades isoladas é mitigado pela chamada "interface de relações", materializada por:',
 'Exemplos de coragem física demonstrados apenas em tempo de guerra.',
 'Expedição de documentos (boletins, diretrizes, ordens de serviço) e o aporte de tecnologias de informação.',
 'Eliminação da cadeia de comando para agilizar o contato direto.',
 'Foco exclusivo em relacionamentos externos com a sociedade civil.',
 'Suspensão de planos e ordens de operações para evitar burocracia.',
 'B',
 'A alternativa B está correta: no nível organizacional/tático, a interface de relações que mitiga o distanciamento físico é materializada por documentos (boletins, diretrizes, ordens de serviço/operações) e pelo aporte de tecnologias de informação. A alternativa A restringe indevidamente o exemplo de coragem física ao tempo de guerra, quando a interface documental e tecnológica é utilizada de forma contínua, inclusive em tempo de paz. A alternativa C é incorreta, pois eliminar a cadeia de comando comprometeria, e não facilitaria, a comunicação organizada nesse nível. A alternativa D confunde a interface interna de relações com o relacionamento externo, típico do nível estratégico. A alternativa E é falsa, pois suspender planos e ordens de operações prejudicaria justamente a interface que se busca fortalecer.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever o Nível Organizacional/Tático de comando. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q18: Nível Estratégico — competências essenciais
(@cat_tc20,
 'São competências específicas e essenciais do líder que atua no Nível Estratégico, além das capacidades básicas exigidas em qualquer escalão:',
 'Domínio técnico de armamento individual e táticas de patrulha.',
 'Visão prospectiva (de futuro) e persuasão estratégica.',
 'Execução direta de ordens de serviço diárias da tropa.',
 'Foco restrito a problemas financeiros imediatos da unidade.',
 'Exercício exclusivo da liderança direta junto a pequenos grupos.',
 'B',
 'A alternativa B está correta: o nível estratégico exige competências específicas de visão prospectiva (de futuro) e persuasão estratégica, dada a necessidade de negociação e planejamento de longo prazo com agentes internos e externos à instituição. A alternativa A descreve competências típicas dos pequenos escalões, não do nível estratégico. A alternativa C é o oposto do que ocorre nesse nível, em que a execução direta das ordens diárias deve ser delegada aos escalões inferiores. A alternativa D restringe indevidamente o foco estratégico a questões financeiras imediatas, quando a visão prospectiva abrange planejamento institucional mais amplo. A alternativa E contraria a predominância da liderança indireta no nível estratégico, dado o distanciamento estrutural em relação aos pequenos grupos.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever as competências específicas do Nível Estratégico de comando. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q19: Instrução militar como oportunidade de liderança
(@cat_tc20,
 'Em situações de normalidade administrativa, qual atividade militar é apontada pela doutrina como uma oportunidade de excelência para fortalecer os laços de liderança entre comandante e tropa?',
 'A aplicação de punições disciplinares coletivas.',
 'A instrução militar.',
 'O enclausuramento do comandante em gabinete para planejamento.',
 'A redução do diálogo para evitar a quebra da hierarquia.',
 'O foco exclusivo na gestão de recursos materiais.',
 'B',
 'A alternativa B está correta: a instrução militar é apontada pela doutrina como oportunidade privilegiada, em tempo de normalidade, para o comandante fortalecer os laços de liderança com a tropa, por meio do exemplo pessoal e do contato próximo durante o treinamento. A alternativa A descreve medida disciplinar coletiva, que não é, por si só, instrumento de construção de vínculos de liderança. A alternativa C é o oposto do recomendado, pois o isolamento em gabinete afasta o comandante da tropa. A alternativa D contraria a doutrina, que valoriza o diálogo frequente como forma de fortalecer a confiança, sem que isso comprometa a hierarquia. A alternativa E restringe indevidamente a atuação do comandante à esfera material, ignorando a dimensão humana da liderança.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao apontar a instrução militar como oportunidade de fortalecimento dos laços de liderança em tempo de normalidade. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q20: Laços de liderança em crise — prevenção de omissão/deserção
(@cat_tc20,
 'Em tempos de crise, o estabelecimento de sólidos laços de liderança entre comandantes e subordinados visa prevenir, primordialmente:',
 'O excesso de iniciativa dos soldados.',
 'Casos de omissão, deserção e desobediência.',
 'O aumento do espírito de corpo e da camaradagem.',
 'A melhoria da proficiência profissional técnica.',
 'A utilização de tecnologias de informação.',
 'B',
 'A alternativa B está correta: laços sólidos de liderança, construídos em tempo de paz, visam primordialmente prevenir, em situações de crise, casos de omissão, deserção e desobediência, garantindo o cumprimento da missão sob pressão. A alternativa A é falsa, pois a doutrina de Trabalho de Comando valoriza a iniciativa do subordinado (ver, por exemplo, a Auftragstaktik), não busca reprimi-la. A alternativa C descreve um efeito positivo correlato, mas não a finalidade primordial apontada no contexto de crise, que é evitar as falhas comportamentais graves listadas na alternativa B. A alternativa D refere-se ao pilar Saber, tema distinto do propósito dos laços afetivos de liderança em crise. A alternativa E descreve instrumento da liderança indireta, sem relação direta com a prevenção de omissão/deserção em crise.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto à finalidade dos laços de liderança consolidados para o enfrentamento de situações de crise. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q21: Espírito de Corpo
(@cat_tc20,
 'Sobre o Espírito de Corpo, conceito fundamental para a eficácia institucional, é correto afirmar que ele:',
 'Substitui a necessidade de hierarquia no dia a dia da unidade.',
 'Tem como alicerce a camaradagem e o orgulho de pertencer à instituição, à Arma/Serviço e ao grupo.',
 'É um sentimento que tende a dividir a tropa em subgrupos rivais.',
 'Desaparece quando o grupo enfrenta situações de risco iminente.',
 'É irrelevante para o cumprimento da missão em grandes escalões.',
 'B',
 'A alternativa B está correta: o Espírito de Corpo tem como alicerce a camaradagem e o orgulho de pertencer à instituição, à Arma/Serviço e ao grupo específico, constituindo fator de coesão institucional. A alternativa A é falsa, pois o Espírito de Corpo não substitui a hierarquia, mas coexiste com ela, fortalecendo a coesão sem eliminar a estrutura de comando. A alternativa C contraria o próprio conceito, que busca unir, e não dividir, a tropa em subgrupos rivais. A alternativa D é o oposto do observado na doutrina: em situações de risco, a coesão e o desejo de proximidade entre os pares tendem a aumentar, não a desaparecer. A alternativa E ignora a relevância do Espírito de Corpo mesmo em grandes escalões, onde reforça a identidade institucional coletiva.\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao descrever o Espírito de Corpo como valor alicerçado na camaradagem. Por analogia, o CEDM/RR (Lei 963/2014, art. 16, parágrafo único) trata da camaradagem como obrigação de incentivar e manter a harmonia e a solidariedade entre os militares, valor correlato ao descrito na doutrina.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler; CEDM/RR (Lei 963/2014), art. 16 (analogia)',
 'facil'),

-- Q22: Risco, ansiedade e coesão do grupo
(@cat_tc20,
 'Segundo estudos citados pela doutrina de Trabalho de Comando, a relação entre risco, ansiedade e coesão do grupo estabelece que:',
 'Quanto maior o risco, menor o desejo de união entre os pares.',
 'Riscos elevados extinguem o sentimento de amizade e camaradagem no grupo.',
 'Quanto mais ansiosas as pessoas ficam por enfrentarem perigos, mais desejam estar próximas de outras na mesma situação.',
 'A ansiedade impede, de forma absoluta, qualquer forma de liderança eficaz.',
 'O perigo faz com que o subordinado busque sistematicamente o isolamento individual.',
 'C',
 'A alternativa C está correta: os estudos citados pela doutrina demonstram que, quanto mais ansiosas as pessoas ficam ao enfrentar perigos, mais desejam estar próximas de outras pessoas na mesma situação, o que reforça a coesão do grupo diante do risco. A alternativa A é o oposto da conclusão doutrinária, que aponta aumento, e não diminuição, do desejo de união sob risco elevado. A alternativa B contraria a evidência de que o risco compartilhado tende a fortalecer, e não extinguir, os laços de camaradagem. A alternativa D exagera o efeito da ansiedade, ignorando que é justamente nesses momentos que a liderança consolidada se revela mais eficaz. A alternativa E é falsa, pois o comportamento típico observado é de aproximação, e não de isolamento individual, diante do perigo compartilhado.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao citar estudos sobre a relação entre risco, ansiedade e coesão grupal. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'dificil'),

-- Q23: Interesse do serviço x interesse dos subordinados
(@cat_tc20,
 'A doutrina de Trabalho de Comando destaca que o líder militar deve equilibrar dois interesses frequentemente antagônicos no exercício do comando. São eles:',
 'O interesse político e o interesse jurídico.',
 'O interesse do serviço e o interesse dos subordinados.',
 'O interesse da família e o interesse da pátria.',
 'O interesse técnico e o interesse financeiro da unidade.',
 'O interesse do Comandante-Geral e o interesse do Estado-Maior.',
 'B',
 'A alternativa B está correta: a orientação prática da doutrina de Trabalho de Comando destaca que o líder deve administrar, de forma equilibrada, o interesse do serviço (cumprimento da missão) e o interesse dos subordinados (bem-estar do grupo), interesses que podem entrar em conflito, mas que precisam ser conciliados. A alternativa A propõe uma dicotomia (política x jurídica) estranha ao tema da orientação prática. A alternativa C desloca o tema para a esfera pessoal/família, quando o foco da doutrina é a relação entre missão e tropa. A alternativa D restringe indevidamente o antagonismo a aspectos técnico-financeiros, tema diverso do equilíbrio serviço/subordinado. A alternativa E propõe um antagonismo entre elos da própria cadeia de comando, não correspondente à orientação prática descrita.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto à orientação prática de equilíbrio entre o interesse do serviço e o interesse dos subordinados. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q24: Isolamento em gabinete e perda de confiança
(@cat_tc20,
 'A doutrina alerta que o líder que não dialoga, não explica suas ideias e se isola em seu gabinete:',
 'Fortalece sua aura de autoridade perante o grupo.',
 'Caminha na contramão da liderança e verá a confiança do grupo desaparecer.',
 'Otimiza a gestão do tempo para assuntos burocráticos relevantes.',
 'Adota o modelo ideal de liderança indireta recomendado pela doutrina.',
 'Evita distorções de comunicação por não se expor ao grupo.',
 'B',
 'A alternativa B está correta: a doutrina alerta expressamente que o líder que se isola, não dialoga e não explica suas ideias caminha na contramão da liderança, e a confiança do grupo tende a desaparecer nessas circunstâncias. A alternativa A é o oposto do efeito real: o isolamento corrói, e não fortalece, a autoridade percebida pelo grupo, pois rompe o vínculo de confiança. A alternativa C tenta justificar o isolamento por eficiência burocrática, argumento que a doutrina rejeita, ao valorizar o diálogo mesmo em ambientes administrativos. A alternativa D distorce o conceito de liderança indireta, que não implica ausência de diálogo, mas sim o uso de documentos e tecnologia complementares ao contato direto sempre que possível. A alternativa E é falsa, pois é justamente a ausência de comunicação que gera desinformação e distorções na cadeia de liderança, não o contrário.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto aos riscos do isolamento do líder em gabinete para a confiança do grupo. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q25: Contraordens e credibilidade do líder
(@cat_tc20,
 'Situação Hipotética: um Oficial altera o plano de policiamento de sua fração três vezes em uma única manhã, sem qualquer justificativa operacional clara. Segundo a orientação prática da doutrina, essa conduta de contraordem reiterada deve ser evitada porque:',
 'Estimula a criatividade e a capacidade de adaptação da tropa.',
 'Sugere planejamento malfeito e afeta a credibilidade do líder perante o grupo.',
 'É a base técnica da Auftragstaktik alemã de incentivo à iniciativa.',
 'Demonstra que o líder é flexível e está atento às mudanças climáticas.',
 'Fortalece o pilar da proficiência profissional do oficial.',
 'B',
 'A alternativa B está correta: a orientação prática da doutrina alerta que a reiteração injustificada de contraordens sugere planejamento malfeito e afeta diretamente a credibilidade do líder perante o grupo, gerando insegurança na tropa. A alternativa A está incorreta, pois a alteração desmotivada de ordens não estimula criatividade, apenas gera confusão e desconfiança. A alternativa C confunde contraordem injustificada com Auftragstaktik, técnica que trata do incentivo à iniciativa do subordinado dentro de uma intenção clara do comando, não de indecisão do líder. A alternativa D tenta justificar de forma equivocada a instabilidade do oficial como "flexibilidade", quando a doutrina trata isso como falha de planejamento. A alternativa E é falsa, pois a conduta relatada evidencia, ao contrário, fragilidade de planejamento, o que compromete, e não fortalece, a percepção de proficiência profissional do oficial.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto aos efeitos negativos das contraordens reiteradas sobre a credibilidade do comandante. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q26: Ponderação e equilíbrio emocional na decisão
(@cat_tc20,
 'Para decidir de forma ponderada e manter o equilíbrio emocional diante de um problema, o líder militar deve:',
 'Agir por impulso, para demonstrar vivacidade e coragem física diante do grupo.',
 'Refletir por um tempo proporcional à gravidade e à urgência do problema enfrentado.',
 'Delegar todas as decisões complexas, para evitar o desgaste emocional pessoal.',
 'Decidir sempre de forma contrária à opinião do grupo, para reafirmar seu poder.',
 'Ignorar os elementos técnicos disponíveis em favor exclusivo da intuição pessoal.',
 'B',
 'A alternativa B está correta: a orientação prática da doutrina recomenda que o líder reflita por um tempo proporcional à gravidade e à urgência do problema, equilibrando ponderação e tempestividade na tomada de decisão. A alternativa A é incorreta, pois agir por impulso, sem qualquer reflexão, compromete justamente o equilíbrio emocional que se busca preservar. A alternativa C descreve fuga da responsabilidade decisória, o que não corresponde à ponderação recomendada, mas à evasão do papel de líder. A alternativa D descreve decisão arbitrária motivada apenas pelo desejo de reafirmar poder, contrária à racionalidade da ponderação doutrinária. A alternativa E ignora que a doutrina recomenda a combinação de elementos técnicos com julgamento pessoal, não a exclusão de um em favor do outro.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto à orientação prática de ponderação proporcional à gravidade e urgência do problema. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q27: Elogio e reconhecimento oportuno
(@cat_tc20,
 'O reconhecimento e o elogio oportuno ao subordinado são fundamentais na liderança militar porque:',
 'Facilitam a ocultação de erros técnicos graves cometidos pela tropa.',
 'Reforçam a atitude correta praticada e aumentam a autoconfiança necessária ao cumprimento da missão.',
 'Criam um ambiente de pressão constante e produtiva sobre o subordinado.',
 'Devem ser concedidos apenas se o objetivo for 100% atingido, sem qualquer falha.',
 'Servem para substituir as promoções e recompensas previstas em lei.',
 'B',
 'A alternativa B está correta: o elogio e o reconhecimento oportunos reforçam a atitude correta já praticada pelo subordinado e aumentam sua autoconfiança, elemento importante para o cumprimento de missões futuras. A alternativa A distorce a finalidade do elogio, que não deve servir para ocultar falhas técnicas, mas sim para valorizar condutas corretas. A alternativa C confunde reconhecimento positivo com pressão constante, efeitos opostos na dinâmica motivacional do grupo. A alternativa D restringe indevidamente o elogio ao resultado perfeito, quando a doutrina valoriza também o reconhecimento do esforço e da atitude correta, ainda que o resultado final não seja integralmente alcançado. A alternativa E é falsa, pois o elogio informal do comandante não substitui, mas complementa, as recompensas e promoções formalmente previstas em lei e regulamento.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto à função motivacional do reconhecimento e do elogio oportuno na liderança. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'facil'),

-- Q28: Auftragstaktik
(@cat_tc20,
 'A técnica alemã denominada Auftragstaktik, referida pela doutrina de Trabalho de Comando, foca no incentivo:',
 'À obediência cega e sem questionamentos por parte do subordinado.',
 'À iniciativa do subordinado na busca por soluções para o cumprimento da missão do grupo.',
 'À centralização extrema de todas as decisões táticas no comando-geral.',
 'À substituição da hierarquia militar pelos modelos de gestão empresarial.',
 'Ao uso exclusivo da força física em detrimento do planejamento estratégico.',
 'B',
 'A alternativa B está correta: a Auftragstaktik é a técnica alemã que incentiva a iniciativa do subordinado na busca de soluções para o cumprimento da missão, a partir da compreensão clara da intenção do comando, e não da mera execução mecânica de ordens detalhadas. A alternativa A é o oposto do conceito, que valoriza justamente a iniciativa refletida, não a obediência automática e sem questionamento. A alternativa C contraria a essência descentralizadora da técnica, que distribui a capacidade decisória pelos escalões, em vez de concentrá-la no comando-geral. A alternativa D exagera a proposta, que não busca substituir a hierarquia militar, mas aprimorar seu funcionamento por meio da iniciativa dentro da estrutura de comando existente. A alternativa E é estranha ao conceito, que trata de tomada de decisão tática, não de emprego exclusivo de força física.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao incorporar a técnica alemã Auftragstaktik como referência de incentivo à iniciativa do subordinado. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'medio'),

-- Q29: Coragem Moral
(@cat_tc20,
 'Situação Hipotética: um Capitão presencia uma injustiça cometida por um oficial superior contra um subordinado e decide intervir em defesa do que é correto, ciente de que essa atitude pode prejudicar sua própria promoção futura. Essa conduta exemplifica a:',
 'Coragem Física.',
 'Coragem Moral.',
 'Iniciativa Técnica.',
 'Disciplina Burocrática.',
 'Liderança Autocrática.',
 'B',
 'A alternativa B está correta: a Coragem Moral consiste na defesa de princípios e convicções éticas mesmo diante de prejuízo a interesses pessoais, como no caso do Capitão que intervém contra uma injustiça sabendo do risco à própria promoção. A alternativa A refere-se ao enfrentamento de perigo físico ou risco de dano corporal, situação distinta da narrada, que envolve risco à carreira, não ao corpo. A alternativa C não corresponde a um conceito doutrinário específico associado à conduta relatada, que é essencialmente ética, não técnica. A alternativa D sugere submissão às formalidades hierárquicas, o oposto da postura de enfrentamento demonstrada pelo Capitão. A alternativa E rotula erroneamente a conduta como um estilo de comando (autocrático), quando na verdade se trata de um valor/competência afetiva do líder.\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, ao distinguir Coragem Física de Coragem Moral. Por analogia, a defesa de princípios éticos institucionais, mesmo diante de prejuízo pessoal, também é amparada pelos deveres de conduta idônea do Estatuto dos Militares de Roraima (LC 194/2012, art. 39) e do CEDM/RR (Lei 963/2014, arts. 15 a 22).',
 'Trabalho de Comando.pdf — Academia Coronel Walterler; LC 194/2012 (RR), art. 39 (analogia)',
 'dificil'),

-- Q30: Projeto de comando e formação de novos líderes
(@cat_tc20,
 'Sobre as responsabilidades de formação e projeto de comando, a doutrina de Trabalho de Comando orienta que o Comandante deve:',
 'Manter seu projeto de gestão em sigilo absoluto, para evitar críticas da tropa.',
 'Evitar deliberadamente a formação de novos líderes, para não criar competidores internos.',
 'Ter um projeto para a Organização Militar, saber explicá-lo com clareza e empenhar-se em formar novos líderes para a cadeia de liderança.',
 'Priorizar o exemplo pessoal apenas quando houver audiência externa presente.',
 'Realizar mudanças bruscas no comando sem comunicação prévia, para testar a reação da tropa.',
 'C',
 'A alternativa C está correta: a doutrina orienta que o Comandante deve ter um projeto para a Organização Militar, saber explicá-lo com clareza aos seus comandados e empenhar-se ativamente na formação de novos líderes, garantindo a continuidade da cadeia de liderança. A alternativa A contraria a recomendação de transparência e comunicação clara do projeto de gestão. A alternativa B é o oposto do dever doutrinário do comandante, que deve fomentar, e não temer, a formação de novas lideranças dentro da unidade. A alternativa D reduz o exemplo pessoal a uma performance apenas para públicos externos, quando a doutrina exige coerência de conduta em qualquer circunstância, com ou sem audiência. A alternativa E descreve conduta imprevisível e sem comunicação, contrária à orientação de clareza e explicação do projeto de comando à tropa.\n\n📜 Fundamento legal vigente: conceito doutrinário — "Trabalho de Comando.pdf", Academia Coronel Walterler, quanto às responsabilidades de projeto de comando e formação de novos líderes. Não há lei pública correspondente.',
 'Trabalho de Comando.pdf — Academia Coronel Walterler',
 'dificil');

