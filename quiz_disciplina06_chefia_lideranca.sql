-- ============================================================
-- QUIZ — Disciplina 6/20 do CHO: Chefia e Liderança Militar
-- 30 questões — dupla justificativa (doutrina C 20-10 + observação sobre natureza da fonte)
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro —
--   fundamentos e fenômeno da liderança; teorias (Inatista, Estilos/Laissez-faire,
--   Sócio-Histórica, Situacional, Campo Social de Kurt Lewin); formas de exercício e
--   níveis de comando (pequenos escalões, organizacional/tático, estratégico); pilares
--   Saber/Ser/Fazer; ética e valores militares; competências afetivas do líder;
--   inteligência emocional (Goleman) e estilos de comando
-- Observação sobre a fonte: disciplina baseada em doutrina interna do Exército Brasileiro
--   (manual de campanha), sem lei pública numerada correspondente — NÃO há legislação
--   para baixar nesta disciplina. Por analogia, quando o tema é ética/valores militares,
--   as questões remetem ao Estatuto dos Militares de Roraima (LC 194/2012, art. 39) e ao
--   CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia Militar), já documentados nas
--   seções 1 e 2 da base de conhecimento de legislação do projeto.
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Chefia e Liderança Militar — CHO 06', 'Disciplina 6/20 do CHO — Fundamentos, teorias, níveis de comando, pilares (Saber/Ser/Fazer), ética, valores e competências da Liderança Militar (Manual C 20-10)');

SET @cat_ch06 = (SELECT id FROM categorias WHERE nome = 'Chefia e Liderança Militar — CHO 06' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Finalidade e premissas da doutrina de liderança
(@cat_ch06,
 'A doutrina de liderança militar do Exército Brasileiro (EB) é concebida de forma integrada à Doutrina Militar Terrestre (DMT). Acerca de sua finalidade e premissas fundamentais, assinale a alternativa correta:',
 'A doutrina estabelece parâmetros pétreos e imutáveis, visando a padronização absoluta do comportamento do líder em qualquer cenário.',
 'A evolução tecnológica das armas modernas tornou a liderança um fator secundário frente à precisão dos sistemas eletrônicos de combate.',
 'O ser humano é o elemento primordial de qualquer exército, sendo a engrenagem propulsora para a realização dos objetivos institucionais.',
 'A doutrina de liderança militar afasta-se deliberadamente dos aportes da psicologia social para manter a pureza dos regulamentos disciplinares.',
 'O objetivo da doutrina é unicamente fornecer ferramentas de controle administrativo, independentemente do grau hierárquico dos envolvidos.',
 'C',
 'A alternativa C está correta: a doutrina afirma que o ser humano é o "elemento primordial de qualquer exército" e a "engrenagem propulsora" para a realização dos objetivos institucionais. A alternativa A está incorreta porque a doutrina rejeita expressamente parâmetros pétreos e imutáveis de comportamento do líder. A alternativa B está incorreta porque a evolução tecnológica das armas realça, e não diminui, a importância do fator humano. A alternativa D está incorreta porque a doutrina de liderança militar recebe aportes importantes da psicologia social. A alternativa E está incorreta porque a liderança visa ao trato com subordinados e ao autoaperfeiçoamento em todos os graus hierárquicos, não apenas ao controle administrativo.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário, não legal — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, concebido de forma integrada à Doutrina Militar Terrestre (DMT). Trata-se de doutrina interna das Forças Armadas, sem lei pública numerada correspondente nesta disciplina.',
 'Manual C 20-10 — Liderança Militar',
 'facil'),

-- Q02: Fenômeno da liderança — o fator "Interação"
(@cat_ch06,
 'O fenômeno da liderança é composto por quatro fatores fundamentais: o líder, os liderados, a situação e a interação. No que concerne especificamente à "Interação", a doutrina a define como:',
 'O somatório de elementos de origem interna e externa que exercem influência sobre a motivação do grupo para o cumprimento de tarefas.',
 'O processo vital pelo qual informações, ideias, pensamentos, sentimentos e emoções tramitam entre os membros do grupo.',
 'A autoridade legal delegada ao comandante por meio de leis e regulamentos para influenciar o comportamento do grupo.',
 'O conhecimento profundo da natureza humana, das necessidades e motivações que o líder deve possuir sobre seus subordinados.',
 'A capacidade do líder de impor sua vontade sobre os liderados, independentemente do consentimento ou dos vínculos afetivos.',
 'B',
 'A alternativa B reproduz a definição doutrinária literal de Interação: o processo pelo qual informações, ideias, pensamentos, sentimentos e emoções tramitam entre os membros do grupo. A alternativa A descreve, na verdade, o fator "Situação". A alternativa C refere-se à esfera formal da autoridade legal, distinta da liderança. A alternativa D descreve o conhecimento que o líder deve ter dos liderados, não a interação em si. A alternativa E contraria o próprio conceito de influência interpessoal e vínculos afetivos que sustenta a liderança.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever os quatro fatores do fenômeno da liderança (líder, liderados, situação e interação). Não há lei pública correspondente para esta disciplina.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q03: Distinção liderança x chefia x gerência
(@cat_ch06,
 'A correta distinção terminológica entre liderança, chefia e gerência é imperativa para o oficial brasileiro. Segundo as bases teóricas adotadas pelo EB:',
 'Liderança é sinônimo estrito de gerência, visto que ambos focam na administração de recursos para atingir fins organizacionais.',
 'A chefia fundamenta-se exclusivamente no prestígio pessoal aceito pelos subordinados, prescindindo de cargo formal.',
 'O Dicionário Aurélio define liderança como uma forma de dominação baseada na hierarquia e no poder de punição legal.',
 'A liderança não se confunde com gerência ou chefia, sendo um processo de influência interpessoal que transcende a esfera formal do cargo.',
 'A gerência é o único processo que permite o estabelecimento de vínculos afetivos e o comprometimento voluntário da tropa.',
 'D',
 'A alternativa D está correta: a doutrina enfatiza que liderança não é sinônimo de gerência, administração ou chefia, por ser um processo de influência interpessoal que vai além da esfera formal do cargo. A alternativa A afirma exatamente o oposto do que o texto sustenta. A alternativa B inverte os conceitos, pois é a chefia/comando que se apoia na esfera formal, enquanto a liderança é a esfera informal apoiada no prestígio pessoal. A alternativa C deturpa a definição do Aurélio, que associa liderança ao "prestígio pessoal aceito", e não à força física ou punição. A alternativa E está incorreta porque é justamente a liderança, e não a gerência (de natureza administrativa/formal), que foca no comprometimento afetivo voluntário.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro. Não há lei pública correspondente para esta distinção terminológica.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q04: Cumprimento de ordens sob risco de vida
(@cat_ch06,
 'Situação Hipotética: Durante uma operação de pacificação em área urbana, uma fração se vê sob intenso fogo adversário, enfrentando penúrias e risco iminente de vida. Nesse cenário crítico, a conduta dos subordinados em relação às ordens recebidas é explicada pela doutrina da seguinte forma:',
 'A disciplina formal e a hierarquia rígida são, isoladamente, garantidoras do cumprimento voluntário de ordens em situações de risco de morte.',
 'Os indivíduos tenderão a obedecer voluntariamente desde que as ordens estejam afiançadas pela confiança estabelecida anteriormente com o comandante.',
 'Em momentos de crise, o fenômeno da liderança é suspenso, prevalecendo apenas o instinto de sobrevivência individual.',
 'A história militar comprova que o cumprimento de ordens em combate é mecânico e independe da qualidade da liderança exercida na paz.',
 'A obediência voluntária é impossível em situações de penúria, cabendo ao líder o uso exclusivo da autoridade legal e da força para manter a coesão.',
 'B',
 'A alternativa B está correta: em momentos de crise e risco de vida, os subordinados só obedecerão voluntariamente às ordens recebidas se estas estiverem afiançadas pela confiança já construída com o comandante. A alternativa A está incorreta porque a disciplina formal isolada não garante, por si só, o cumprimento de ordens sob risco de morte. A alternativa C é falsa, pois é justamente nesses momentos que a liderança se revela alicerce essencial, e não algo suspenso. As alternativas D e E contrariam a evidência doutrinária de que a solidez da liderança construída em tempo de paz é o que garante o cumprimento da missão sob pressão extrema.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, sobre o papel da confiança e da liderança consolidada previamente para o cumprimento de ordens em combate. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'dificil'),

-- Q05: Corrente Centrada no Líder — Teoria Inatista
(@cat_ch06,
 'A "Corrente Centrada na Figura do Líder" reúne teorias que focam no que o líder é e faz. Sobre a "Teoria Inatista", é correto afirmar que:',
 'Defende que a liderança é uma habilidade técnica que pode ser aprendida e desenvolvida por qualquer indivíduo mediante treino.',
 'Considera que o destaque do líder é fruto exclusivo das contingências vividas pelo grupo e das necessidades sociais do momento.',
 'Prega que o líder é um indivíduo predestinado ou abençoado pela "Providência Divina" para exercer a liderança.',
 'Foca na análise do comportamento dos seguidores como fator determinante para a emergência do comando.',
 'Sustenta que a posse de certos traços de caráter é irrelevante frente ao cargo formal ocupado pelo militar.',
 'C',
 'A alternativa C está correta: a Teoria Inatista prega que o líder é um indivíduo predestinado ou abençoado pela "Providência Divina" para exercer a liderança. A alternativa A descreve a visão moderna de competências desenvolvíveis, não a Teoria Inatista. A alternativa B refere-se à Corrente Centrada nos Seguidores. As alternativas D e E descrevem focos de outras correntes (situacional ou de seguidores), não da Inatista, que valoriza justamente os traços de caráter natos.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever a Corrente Centrada na Figura do Líder e suas teorias (entre elas a Inatista). Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q06: Estilo laissez-faire
(@cat_ch06,
 'A Teoria dos Tipos ou Estilos de Liderança identifica três comportamentos clássicos do líder. Assinale a alternativa que descreve corretamente o estilo laissez-faire:',
 'O líder centraliza as decisões e fixa as normas sem consultar o grupo, exigindo execução imediata.',
 'O líder atua sintonizado com o grupo, incentivando a participação e aproveitando as sugestões antes de decidir.',
 'O líder concede total liberdade ao grupo para tomar decisões, abstendo-se de guiar ou controlar o processo de forma direta.',
 'O líder alterna seu comportamento entre a autocracia e a participação, dependendo exclusivamente da urgência da missão.',
 'O líder foca apenas no bem-estar emocional do grupo, ignorando os objetivos técnicos e táticos da organização.',
 'C',
 'A alternativa C está correta: o estilo laissez-faire ocorre quando o líder concede total liberdade ao grupo, abstendo-se de guiar ou controlar o processo diretamente. A alternativa A descreve o estilo autocrático. A alternativa B descreve o estilo participativo/democrático. A alternativa D descreve a necessidade de alternância situacional entre estilos, e não um estilo específico. A alternativa E descreve uma falha de comando, não o conceito doutrinário de laissez-faire.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao classificar os estilos clássicos de liderança (autocrático, democrático/participativo e laissez-faire). Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'facil'),

-- Q07: Corrente Centrada nos Seguidores — Teoria Sócio-Histórica
(@cat_ch06,
 'Diferentemente das teorias focadas no líder, a "Corrente Centrada nos Seguidores" busca caracterizar o líder emergente. Sobre a "Teoria Sócio-Histórica", assinale a alternativa correta:',
 'Define o líder como um herói messiânico que transforma o curso dos acontecimentos por vontade própria e carisma inato.',
 'Propõe o processo grupal como um processo histórico de formação de vínculos, onde indivíduos experientes orientam os mais novos.',
 'Afirma que a liderança é atribuída apenas àquele que detém o maior posto hierárquico, independentemente da aceitação do grupo.',
 'Nega a influência do meio social e da cultura organizacional no surgimento de novas lideranças dentro da caserna.',
 'Sustenta que o líder emerge apenas quando demonstra capacidade técnica imediata para o manuseio de armamentos complexos.',
 'B',
 'A alternativa B está correta: a Teoria Sócio-Histórica propõe o processo grupal como um processo histórico de formação de vínculos, no qual indivíduos mais experientes orientam os mais novos. A alternativa A descreve a Teoria do Grande Homem, associada à corrente centrada no líder. A alternativa C refere-se apenas ao cargo formal (esfera da chefia/comando), e não à corrente centrada nos seguidores. A alternativa D é o oposto do que a corrente sustenta, já que ela afirma que o líder é produto do grupo e do meio social. A alternativa E foca em competência técnica isolada, ignorando o processo histórico-grupal central à teoria.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever a Corrente Centrada nos Seguidores e a Teoria Sócio-Histórica. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q08: Corrente Centrada na Situação
(@cat_ch06,
 'A "Corrente Centrada na Situação" trouxe a perspectiva da relatividade ao fenômeno da liderança. Sua premissa fundamental estabelece que:',
 'Um líder eficaz em tempo de paz será, necessariamente, um líder eficaz em situações de combate.',
 'As características pessoais do líder são o único fator que garante o sucesso da missão, independentemente do ambiente.',
 'A liderança depende do tempo e do lugar, o que significa que as competências exigidas variam conforme as circunstâncias do momento.',
 'O grupo militar é uma entidade estática, cujas reações ao comando não se alteram frente a pressões externas.',
 'A situação é um fator irrelevante para a doutrina militar brasileira, que privilegia a autoridade legal absoluta do cargo.',
 'C',
 'A alternativa C está correta: a principal conclusão da corrente situacional é que a liderança é dependente da situação, variando conforme o tempo e o lugar. A alternativa A é refutada pelo próprio exemplo doutrinário do comandante eficaz em combate, mas ineficaz na administração de paz (e vice-versa). A alternativa B descreve, na verdade, a Corrente Centrada no Líder. A alternativa D ignora a dinâmica grupal central a esta corrente. A alternativa E nega a própria base da Doutrina Militar Terrestre, que reconhece a relevância da situação.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever a Corrente Centrada na Situação. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q09: Corrente Integradora — Teoria do Campo Social de Kurt Lewin
(@cat_ch06,
 'A "Corrente Integradora", especificamente por meio da Teoria do Campo Social de Kurt Lewin, postula que o comportamento humano é o resultado da totalidade de fatores coexistentes. Nesse contexto:',
 'O grupo e o ambiente formam um todo, e a conduta é explicada pela inter-relação dinâmica entre partes interdependentes.',
 'A liderança é vista como uma força isolada que emana do líder para os liderados, sem retroalimentação do ambiente.',
 'Os quatro fatores da liderança operam de forma estanque, sendo a situação o único elemento que não sofre influência do líder.',
 'O prestígio do líder decorre exclusivamente de coincidências biológicas e traços físicos inatos.',
 'O comportamento é determinado apenas pela história de vida do indivíduo, desconsiderando as expectativas atuais do grupo.',
 'A',
 'A alternativa A está correta: Kurt Lewin propõe que o grupo e o ambiente formam um todo, cuja conduta é explicada pela inter-relação dinâmica entre partes interdependentes (a Teoria do Campo Social/Psicológico). A alternativa B nega justamente a interdependência e a retroalimentação central da teoria de campo. A alternativa C está incorreta porque a situação também influencia e é influenciada pelo líder, não havendo isolamento entre os fatores. A alternativa D refere-se a teorias inatistas ou de traços, e não à corrente integradora. A alternativa E ignora o "campo psicológico" presente, que soma história de vida e expectativas atuais do grupo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao incorporar a Teoria do Campo Social de Kurt Lewin à Corrente Integradora. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'dificil'),

-- Q10: Liderança direta em nível elevado de comando
(@cat_ch06,
 'Situação Hipotética: Um Comandante de Batalhão (nível tático) realiza uma visita programada a uma Companhia isolada na fronteira, onde profere uma palestra para toda a tropa, compartilhando exemplos de sua trajetória. Esta ação exemplifica:',
 'O exercício exclusivo da liderança indireta, pois o Comandante utiliza a palavra para influenciar o grupo.',
 'Uma quebra desnecessária da cadeia de comando, que deveria ocorrer apenas via ordens de serviço escritas.',
 'A busca pela liderança direta, visando fortalecer vínculos e a credibilidade pessoal frente à tropa, mesmo em níveis elevados de comando.',
 'A aplicação da Teoria Inatista, onde o líder busca impor sua vontade por meio da presença física messiânica.',
 'O uso da liderança delegativa, ao permitir que a tropa avalie o desempenho do comandante de batalhão.',
 'C',
 'A alternativa C está correta: no nível organizacional/tático, o líder deve buscar oportunidades de exercer a liderança direta (visitas, palestras) justamente para fortalecer vínculos e a credibilidade pessoal junto à tropa, mesmo estando em nível elevado de comando. A alternativa A está incorreta porque a palestra presencial é, ao contrário, um exercício de liderança direta. A alternativa B está incorreta porque esse tipo de visita é recomendado, exatamente para evitar o isolamento do comandante. A alternativa D confunde o exemplo pessoal do comandante com o messianismo da Teoria Inatista, que não é o caso. A alternativa E inverte o conceito de liderança delegativa, que se relaciona a decisões técnicas, não à avaliação do comandante pela tropa.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, sobre as formas de exercício (direta e indireta) da liderança nos diferentes níveis de comando. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q11: Nível de Comando de Pequenos Escalões
(@cat_ch06,
 'No Nível de Comando de Pequenos Escalões (do cabo ao capitão), a doutrina preconiza que:',
 'A liderança indireta deve ser a única forma de atuação, preservando o distanciamento necessário à autoridade.',
 'A liderança direta é a forma mais exercida, exigindo que o líder esteja junto aos seus comandados, fornecendo exemplos pessoais constantes.',
 'O sargento deve evitar o contato direto com o soldado para que o tenente exerça a influência primária.',
 'A proficiência profissional é secundária, visto que o nível estratégico decide os rumos táticos da fração.',
 'O capitão deve atuar apenas em gabinete, materializando sua influência exclusivamente por intermédio de diretrizes escritas.',
 'B',
 'A alternativa B está correta: nos pequenos escalões, a liderança direta é exercida de forma mais explícita, cabendo ao líder cultivá-la predominantemente, estando junto aos comandados e fornecendo exemplo pessoal constante. A alternativa A contradiz essa recomendação de proximidade. A alternativa C prejudicaria a coesão da fração, ao afastar o sargento do contato direto. A alternativa D é falsa, pois a proficiência profissional é condição essencial (sine qua non) neste nível. A alternativa E descreve o erro doutrinário de quem se enclausura em gabinete, o oposto do recomendado para pequenos escalões.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao definir o Nível de Comando de Pequenos Escalões. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'facil'),

-- Q12: Nível Organizacional/Tático de comando
(@cat_ch06,
 'O Nível Organizacional/Tático de comando (Unidades e Grandes Unidades) lida com o distanciamento imposto pela estrutura. Nesse nível, a interface de liderança é materializada predominantemente por:',
 'Contatos informais diários entre o Comandante da Brigada e todos os soldados das Organizações Militares subordinadas.',
 'Expedição de documentos como boletins, diretrizes, ordens de operações e o aporte de tecnologias de informação.',
 'Uso exclusivo do estilo autocrático, visando compensar a falta de contato direto com a tropa.',
 'Delegação total da liderança para os oficiais subalternos, abstendo-se o comandante de qualquer papel na influência afetiva.',
 'Substituição dos preceitos éticos por normas puramente burocráticas e financeiras.',
 'B',
 'A alternativa B está correta: no nível tático, documentos como boletins, diretrizes, ordens de operações e o aporte de tecnologias de informação materializam a interface de relações entre o comandante e a tropa. A alternativa A é impraticável em razão do efetivo e do distanciamento estrutural típicos deste nível. A alternativa C representa um erro de julgamento situacional, já que o estilo deve variar conforme a circunstância. A alternativa D está incorreta porque abdicar totalmente da influência afetiva solapa a liderança, mesmo em níveis mais distantes. A alternativa E ignora que os valores éticos permanecem o pilar imutável em qualquer nível de comando.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever o Nível Organizacional/Tático de comando. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q13: Nível Estratégico de comando
(@cat_ch06,
 'Situação Hipotética: Um Oficial General no Nível Estratégico precisa coordenar a alocação de recursos federais para a modernização de um Comando Militar de Área, interagindo com agentes externos do poder político. Sobre este nível, é correto afirmar:',
 'A fiscalização direta dos elementos operacionais da ponta é a principal atribuição deste líder.',
 'As competências de negociação, visão de futuro e relacionamento funcional externo assumem papel preponderante.',
 'Valores morais como a lealdade tornam-se "negociáveis" para facilitar a interação com o sistema político.',
 'A liderança direta é a ferramenta mais eficiente para influenciar os milhares de militares sob sua jurisdição estratégica.',
 'Conhecimentos de Geopolítica e História Militar são dispensáveis frente à necessidade de gestão puramente contábil.',
 'B',
 'A alternativa B está correta: o nível estratégico exige competências como negociação, visão de futuro e relacionamento funcional externo, dada a interação constante com agentes políticos e institucionais. A alternativa A está incorreta, pois a fiscalização direta dos elementos da ponta deve ser delegada aos níveis organizacionais. A alternativa C é falsa, pois os valores morais permanecem não negociáveis também no nível estratégico. A alternativa D é ineficaz diante da distância estrutural, prevalecendo neste nível a liderança indireta. A alternativa E é refutada pela doutrina, que exige conhecimentos de Geopolítica e História Militar justamente neste nível.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever o Nível Estratégico de comando. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'dificil'),

-- Q14: Pilares da Liderança Militar — Senso Moral (Ser)
(@cat_ch06,
 'Situação Hipotética: Um Tenente demonstra profundo conhecimento técnico de armamento, mas falha sistematicamente em tomar atitudes justas e não serve de exemplo moral para seus liderados, agindo com desonestidade. Qual pilar da Liderança Militar está sendo negligenciado?',
 'Proficiência Profissional (Saber), pois ele não conhece as normas de conduta.',
 'Senso Moral (Ser), que envolve a incorporação de valores e traços de personalidade ao caráter.',
 'Atitude Adequada (Fazer), pois ele não sabe manusear o equipamento em combate.',
 'Autoridade Legal, pois ele perdeu o cargo por força de lei.',
 'Inteligência Espacial, por não conseguir orientar a tropa no terreno.',
 'B',
 'A alternativa B está correta: o pilar do Senso Moral (Ser) envolve a incorporação de valores e traços de personalidade ao caráter, e é ele que distingue quem age pelo bem da coletividade de quem busca vantagens pessoais mediante desonestidade. A alternativa A é falsa, pois o Tenente demonstra possuir o "Saber" técnico. A alternativa C está incorreta, pois a falha relatada não está na técnica de execução, mas no caráter. As alternativas D e E não correspondem aos pilares doutrinários da liderança militar (Saber, Ser e Fazer).\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, quanto aos pilares Saber/Ser/Fazer. Por analogia, o dever de conduta ética e idônea do militar também encontra eco no Estatuto dos Militares de Roraima (LC 194/2012, art. 39) e no CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia Militar), sem que estes dispositivos definam tecnicamente os "pilares" da liderança, conceito exclusivo do manual doutrinário.',
 'Manual C 20-10 — Liderança Militar; LC 194/2012 (RR), art. 39 (analogia)',
 'medio'),

-- Q15: Distinção Ética x Moral
(@cat_ch06,
 'A distinção entre Ética e Moral é fundamental para a conduta do oficial. Segundo a doutrina, a "Moral" define-se como:',
 'A ciência do comportamento que busca explicar, justificar e criticar os costumes de uma sociedade.',
 'O conjunto de normas, princípios, preceitos e valores que norteiam o comportamento do indivíduo no grupo social.',
 'Um instinto inato com o qual o ser humano já nasce e que não pode ser modificado pelo hábito.',
 'O estudo puramente teórico e filosófico do caráter humano, sem caráter normativo ou prático.',
 'Sinônimo estrito de "Ethos", referindo-se apenas ao modo de ser individual, independente do costume grupal.',
 'B',
 'A alternativa B reproduz a definição doutrinária de Moral: o conjunto de normas, princípios, preceitos e valores que norteiam o comportamento do indivíduo no grupo social. A alternativa A define, na verdade, a "Ética" (a ciência que estuda o comportamento moral). A alternativa C contraria o texto, segundo o qual o homem não nasce com a moral, mas a adquire ou conquista por hábito. As alternativas D e E confundem as distinções filosóficas apresentadas pela doutrina entre ética, moral e "ethos".\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro. Por analogia, a distinção entre condutas éticas exigíveis do militar também é tratada, no âmbito estadual, pelo CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia Militar), que disciplina a Ética Militar, o Decoro e o Pundonor, sem, contudo, repetir a definição filosófica de "moral" trazida pelo manual doutrinário.',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'medio'),

-- Q16: Preceitos da Ética Militar
(@cat_ch06,
 'Os Preceitos da Ética Militar, previstos no Estatuto dos Militares, impõem ao comandante:',
 'O direito de transigir com princípios morais sempre que a missão exigir resultados rápidos.',
 'A responsabilidade finalística pela defesa da Pátria e a garantia dos poderes constitucionais.',
 'O uso do cargo para auferir vantagens pessoais em troca da proteção aos seus subordinados diretos.',
 'A adoção de uma conduta amoral, visando não distinguir o bem do mal para evitar conflitos de consciência.',
 'O cumprimento apenas formal dos regulamentos, independentemente da credibilidade ou confiança da tropa.',
 'B',
 'A alternativa B está correta: a responsabilidade finalística das Forças Armadas (e, por extensão doutrinária, das forças militares estaduais) é a defesa da Pátria e a garantia dos poderes constitucionais. A alternativa A contraria o dever de não transigir com princípios éticos e morais. A alternativa C descreve conduta de corrupção, vedada pelo valor da honestidade. A alternativa D descreve a amoralidade, tratada pela doutrina como postura negativa e incompatível com a liderança. A alternativa E ignora que o cumprimento meramente formal, sem credibilidade e confiança da tropa, não realiza a ética militar.\n\n📜 Fundamento legal vigente: a questão menciona expressamente o "Estatuto dos Militares" — no âmbito estadual de Roraima, o dispositivo correspondente é a LC 194/2012, art. 39 (Deveres do Militar, entre eles a conduta idônea na ativa e na inatividade), complementado pelo CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia Militar e Preceitos Éticos). O conteúdo específico sobre a "responsabilidade finalística" é, todavia, doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro.',
 'LC 194/2012 (RR), art. 39; Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q17: Crenças e Valores e coesão da Unidade
(@cat_ch06,
 'Crenças e Valores influenciam a coesão de uma Unidade. Acerca desse tema, a doutrina do EB afirma que:',
 'Os valores são inatos e imutáveis, não sofrendo influência da cultura, da sociedade ou da época.',
 'O conflito organizacional é eliminado quando o líder impõe suas crenças pessoais sobre os regulamentos.',
 'A compreensão e aceitação de valores comuns reduzem conflitos, diminuem obstáculos na interação e facilitam a ação coletiva.',
 'As atitudes do líder são menos imitadas pelos subordinados do que as ordens verbais e escritas.',
 'A estrutura de valores de um militar é caótica, mudando totalmente a cada nova missão recebida.',
 'C',
 'A alternativa C está correta: a compreensão e aceitação de valores comuns reduzem conflitos, diminuem obstáculos na interação e facilitam a ação coletiva dentro da Unidade. A alternativa A contraria o texto, segundo o qual os valores não são inatos, mas aprendidos ao longo da vida e da carreira. A alternativa B tenderia a causar mais conflito, ao opor crenças pessoais do líder aos valores institucionais compartilhados. A alternativa D é o oposto do afirmado pela doutrina: as atitudes do líder são mais facilmente imitadas do que as ordens meramente verbais ou escritas. A alternativa E contraria a estabilidade do núcleo da estrutura de valores de um militar bem formado.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro. Por analogia, o CEDM/RR (Lei 963/2014, arts. 15 a 22) também trata da formação de valores institucionais comuns (deontologia, camaradagem, cortesia) como fator de coesão da caserna.',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'facil'),

-- Q18: Integridade de caráter
(@cat_ch06,
 'A Integridade de caráter é considerada o valor moral mais importante para o líder militar porque:',
 'Garante que o líder consiga ocultar suas falhas perante os superiores e subordinados.',
 'Condensa todos os demais valores básicos (honra, honestidade, verdade, justiça, respeito e lealdade).',
 'Refere-se unicamente à manutenção da higidez física para o combate.',
 'É um valor opcional, aplicável apenas em situações de normalidade administrativa.',
 'Permite ao líder tomar decisões baseadas apenas em interesses particulares.',
 'B',
 'A alternativa B está correta: a Integridade condensa todos os demais valores básicos (honra, honestidade, verdade, justiça, respeito e lealdade), sugerindo um caráter sem falhas. A alternativa A é o oposto da verdade e da honestidade que a integridade exige. A alternativa C confunde integridade moral com higidez física, conceito distinto. As alternativas D e E negam a própria essência da ética militar, que exige coerência de caráter em qualquer situação e o afastamento de interesses meramente particulares.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro. Por analogia, os valores básicos mencionados (honra, honestidade, justiça, lealdade) encontram eco nos preceitos éticos disciplinados pelo CEDM/RR (Lei 963/2014, arts. 15 a 22), sem que este diploma utilize tecnicamente o termo "integridade" como valor condensador, conceito próprio do manual doutrinário.',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'facil'),

-- Q19: Favoritismo
(@cat_ch06,
 'Situação Hipotética: Um Comandante de Companhia, ao aplicar sanções disciplinares, beneficia sistematicamente os militares que praticam atividades esportivas com ele, em detrimento de outros com desempenho profissional superior. Tal conduta:',
 'Fortalece a coesão da tropa ao criar um grupo de elite fiel ao comandante.',
 'É uma prática de favoritismo, falta moral grave que solapa e destrói a confiança no líder.',
 'Demonstra o uso correto do senso de justiça, priorizando a aptidão física do grupo.',
 'Deve ser ignorada pelos subordinados, pois a autoridade legal do capitão é absoluta.',
 'Caracteriza o "Sereno Rigor" necessário para a administração de pequenas frações.',
 'B',
 'A alternativa B está correta: o favoritismo é uma falta de natureza moral muito grave, que solapa e destrói a confiança dos subordinados no líder. A alternativa A está incorreta, pois esse tipo de conduta destrói o espírito de corpo geral da unidade, em vez de fortalecê-lo. A alternativa C confunde aptidão física/afinidade pessoal com critério legítimo de justiça disciplinar. A alternativa D ignora que a injustiça reiterada provoca ressentimentos e enfraquece a liderança, mesmo diante da autoridade formal do cargo. A alternativa E deturpa o conceito de "Sereno Rigor", que trata de orientação e correção justas, e não de favorecimento pessoal.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, quanto ao valor da justiça e à vedação do favoritismo. Por analogia, condutas de parcialidade no exercício do comando também podem configurar falta ética à luz do CEDM/RR (Lei 963/2014, arts. 15 a 22 — Deontologia Militar), que impõe tratamento isonômico e correção de atitudes aos que exercem chefia.',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'medio'),

-- Q20: Lealdade — proteção indevida a subordinado
(@cat_ch06,
 'Situação Hipotética: Um Sargento protege um subordinado que cometeu uma grave transgressão ética, alegando "lealdade" ao seu comandado. Segundo a doutrina de Liderança Militar:',
 'O Sargento agiu corretamente, pois a lealdade deve ser dedicada à pessoa, independentemente dos valores.',
 'A lealdade militar é unilateral e absoluta, devendo o superior sempre proteger o erro do subordinado.',
 'A lealdade deve ser dedicada às pessoas em função dos valores que elas defendem ou representam.',
 'A lealdade dispensa reciprocidade, sendo um dever apenas do subordinado para com o chefe.',
 'O erro do subordinado deve ser perdoado para evitar o uso de meios coercitivos de persuasão.',
 'C',
 'A alternativa C está correta: a lealdade às pessoas deve existir em função dos demais valores que elas defendem ou representam, e não de forma incondicional. A alternativa A descreve a lealdade cega, que pode acabar acobertando atos ilícitos, o que a doutrina rejeita. As alternativas B e D negam a necessidade de reciprocidade e de fundamento valorativo da lealdade, tratando-a como dever unilateral e absoluto, o que não corresponde ao conceito doutrinário. A alternativa E confunde lealdade com impunidade, ao sugerir que o erro ético grave deva ser simplesmente perdoado.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, quanto ao valor da lealdade condicionada aos valores defendidos. Por analogia, o dever de correção de transgressões éticas, mesmo de subordinados, decorre do CEDM/RR (Lei 963/2014, arts. 15 a 22), que não admite que a camaradagem ou a lealdade pessoal sirvam de justificativa para o encobrimento de faltas graves.',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'dificil'),

-- Q21: Espírito de Corpo
(@cat_ch06,
 'O valor militar que se caracteriza pelo "sentimento de orgulho de pertencer ao Exército, à sua Arma e ao seu grupo", constituindo a alma coletiva da tropa, é o:',
 'Patriotismo.',
 'Civismo.',
 'Espírito de Corpo.',
 'Idealismo.',
 'Pundonor Militar.',
 'C',
 'A alternativa C está correta: o Espírito de Corpo caracteriza-se pelo sentimento de orgulho de pertencer ao Exército, à sua Arma/Serviço e ao seu grupo específico, constituindo a alma coletiva da tropa. As alternativas A e B (Patriotismo e Civismo) são valores voltados à nação e aos deveres de cidadania, mais amplos que o pertencimento a um grupo específico. A alternativa D (Idealismo) refere-se à fé na missão e ao amor à profissão militar. A alternativa E (Pundonor Militar) é sinônimo de honra/dignidade individual, e não de orgulho coletivo de grupo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao listar os valores militares básicos. O CEDM/RR (Lei 963/2014, art. 16, parágrafo único) trata, de forma correlata, da camaradagem como obrigação de incentivar e manter a harmonia e a solidariedade entre os militares, valor próximo, mas distinto, do Espírito de Corpo descrito no manual doutrinário.',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), art. 16 (analogia)',
 'facil'),

-- Q22: Competências Afetivas
(@cat_ch06,
 'As competências do líder militar dividem-se em domínios distintos. Sobre as "Competências Afetivas", é correto afirmar que:',
 'Referem-se ao conjunto de conhecimentos táticos e técnicos obtidos em escolas militares.',
 'Estão ligadas ao domínio afetivo e dividem-se em pessoais e interpessoais.',
 'São habilidades meramente psicomotoras voltadas para o adestramento físico.',
 'Constituem a capacidade lógica de planejar o suporte logístico de uma grande unidade.',
 'São inatas e não podem ser aprimoradas pelo militar ao longo da carreira.',
 'B',
 'A alternativa B está correta: as Competências Afetivas estão ligadas ao domínio afetivo do líder e se dividem em pessoais (autoconhecimento, autocontrole) e interpessoais (empatia, tacto, camaradagem). A alternativa A descreve competências cognitivas, de natureza técnica. As alternativas C e D referem-se, respectivamente, a domínios psicomotor e lógico/cognitivo, distintos do afetivo. A alternativa E contraria a possibilidade doutrinária de incorporação e aprimoramento dessas competências pelo empenho pessoal ao longo da carreira.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao classificar as competências do líder em domínios cognitivo, psicomotor e afetivo. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'facil'),

-- Q23: Coragem Moral
(@cat_ch06,
 'Situação Hipotética: Um oficial defende um princípio ético da instituição em uma reunião de estado-maior, mesmo sabendo que sua posição desagradará o comandante e poderá prejudicar sua indicação para um curso desejado. Este oficial demonstra:',
 'Coragem Física, ao enfrentar o perigo de danos ao seu corpo.',
 'Coragem Moral, que consiste na defesa de princípios e convicções mesmo com prejuízo de interesses pessoais.',
 'Falta de Tacto, por não saber silenciar diante de uma autoridade superior.',
 'Indisciplina, ao questionar indiretamente a visão de seus chefes.',
 'Resiliência, por ser capaz de suportar fadigas físicas extremas no exercício.',
 'B',
 'A alternativa B está correta: a Coragem Moral consiste na defesa dos próprios valores e convicções éticas, mesmo que esse ato possa contrariar interesses pessoais do militar. A alternativa A refere-se a dano físico ou risco de combate, situação distinta da narrada. As alternativas C e D sugerem submissão cega em vez de valorizar a integridade demonstrada pelo oficial, o que contraria a doutrina. A alternativa E confunde resistência física a fadigas com resistência moral a pressões institucionais, temas distintos.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao distinguir Coragem Física de Coragem Moral entre as competências afetivas do líder. Por analogia, a defesa de princípios éticos institucionais também é amparada pelos deveres de conduta idônea do CEDM/RR (Lei 963/2014, arts. 15 a 22).',
 'Manual C 20-10 — Liderança Militar; CEDM/RR (Lei 963/2014), arts. 15-22 (analogia)',
 'medio'),

-- Q24: Resiliência e Adaptabilidade
(@cat_ch06,
 'Situação Hipotética: Após um reverso tático inesperado em um exercício de campo, um Comandante de Pelotão reorganiza rapidamente sua fração, mantém o moral elevado e adapta o planejamento para concluir a missão. Ele demonstrou, respectivamente:',
 'Teimosia e Autocracia.',
 'Resiliência (capacidade de se recuperar de traumas) e Adaptabilidade (ajuste às mudanças).',
 'Empatia e Tacto.',
 'Inteligência Lógica e Coragem Física.',
 'Desprezo pelas normas e Iniciativa equivocada.',
 'B',
 'A alternativa B está correta: a Resiliência é a capacidade de se recuperar rapidamente de traumas e reveses, e a Adaptabilidade é o ajuste apropriado do comportamento e do planejamento às mudanças de situação — exatamente o que o Comandante de Pelotão demonstrou ao reorganizar a fração e adaptar o planejamento após o reverso tático. A alternativa A descreve atributos negativos, incompatíveis com a conduta narrada. A alternativa C refere-se a competências de relacionamento interpessoal, não ao ajuste técnico-tático diante da crise. As alternativas D e E não correspondem às atitudes efetivamente relatadas no cenário (reorganização rápida e manutenção do moral).\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao listar Resiliência e Adaptabilidade entre as competências afetivas pessoais do líder. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q25: Tacto e Sereno Rigor
(@cat_ch06,
 'Situação Hipotética: Um Comandante precisa orientar um subordinado sobre um erro técnico sem ferir suas suscetibilidades, agindo no momento certo e com equilíbrio. Para isso, ele utiliza o "Sereno Rigor". Qual competência interpessoal está em destaque?',
 'Persuasão coercitiva.',
 'Tacto, que permite interagir de forma eficaz sem ferir o subordinado.',
 'Camaradagem, que exige o perdão de todos os erros do subordinado.',
 'Direção técnica unilateral.',
 'Inteligência Musical.',
 'B',
 'A alternativa B está correta: o Tacto é a competência interpessoal que permite ao líder relacionar-se sem ferir as suscetibilidades do subordinado, valendo-se do equilíbrio próprio do "sereno rigor" para corrigir no momento certo. A alternativa A foca em meios coercitivos ou punitivos, o oposto do tacto. A alternativa C confunde camaradagem com o dever de correção, que não pode ser substituído pelo perdão indiscriminado de erros técnicos. A alternativa D ignora a dimensão humana e afetiva presente na cena descrita. A alternativa E é uma das inteligências múltiplas de Gardner, sem relação direta com o tacto interpessoal.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao descrever o Tacto e o "Sereno Rigor" entre as competências interpessoais do líder. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q26: Autoconhecimento e conhecimento da natureza humana
(@cat_ch06,
 'O Autoconhecimento e o Conhecimento da Natureza Humana são fundamentais para o líder. Sobre esses temas:',
 'O autoconhecimento é irrelevante, pois o líder deve focar apenas nos defeitos do grupo.',
 'Conhecer os próprios pontos fortes e fracos permite ao líder reforçar suas capacidades e minimizar deficiências.',
 'A compreensão da natureza humana visa unicamente encontrar formas de punir os liderados com maior eficiência.',
 'O líder emocionalmente inteligente deve ignorar os sentimentos dos subordinados para decidir com frieza.',
 'O conhecimento dos subordinados depende apenas de relatórios formais, dispensando a convivência direta.',
 'B',
 'A alternativa B está correta: o autoconhecimento permite ao líder saber seus próprios pontos fortes e fracos, de modo a reforçar suas capacidades e minimizar suas deficiências. A alternativa A ignora que o autoconhecimento é expressão essencial da inteligência emocional do líder. A alternativa C distorce a finalidade doutrinária do conhecimento da natureza humana, que é motivar e perceber forças, e não apenas punir com maior eficiência. As alternativas D e E negam a empatia e a convivência direta, elementos essenciais ao líder segundo a doutrina.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao tratar do autoconhecimento e do conhecimento da natureza humana entre as competências afetivas pessoais do líder. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'facil'),

-- Q27: Inteligência Emocional — Empatia (Goleman)
(@cat_ch06,
 'A teoria da Inteligência Emocional (IE) ganhou relevância na liderança moderna. Segundo Goleman, uma das quatro habilidades fundamentais da IE é a "Empatia", que consiste em:',
 'Sentir pena ou compaixão sistemática pelos erros cometidos pelos subordinados.',
 'A capacidade de reconhecer as emoções nas demais pessoas ou grupos por meio da observação cuidadosa.',
 'O controle absoluto dos instintos de sobrevivência em situações de perigo físico.',
 'A habilidade de realizar cálculos lógicos sob pressão de tempo.',
 'A capacidade de estar bem consigo mesmo, ignorando a opinião alheia.',
 'B',
 'A alternativa B está correta: segundo Goleman, a Empatia é a capacidade de reconhecer as emoções nas demais pessoas ou nos grupos, por meio da observação cuidadosa. A alternativa A é falsa, pois empatia não é pena ou compaixão sistemática, e sim entender e atender ao que os liderados realmente precisam, não necessariamente ao que desejam. A alternativa C refere-se à coragem física, competência distinta. A alternativa D refere-se à inteligência lógico-matemática, de Gardner, sem relação direta com a empatia de Goleman. A alternativa E descreve arrogância ou isolamento, o oposto do autoconhecimento saudável.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao incorporar a teoria da Inteligência Emocional de Daniel Goleman entre as competências afetivas do líder militar. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q28: Liderança como elemento informal do comando
(@cat_ch06,
 'O exercício do Comando nas Forças Armadas integra elementos distintos. De acordo com a doutrina, a Liderança Militar é considerada:',
 'Um elemento formal do comando, consubstanciado na autoridade legal do cargo.',
 'Um elemento informal, mas desejável, que permite mover homens e mulheres para além da força da lei.',
 'Uma ferramenta meramente administrativa para a gestão de patrimônio e finanças.',
 'O elemento principal que substitui a necessidade de autoridade legal e administração.',
 'Um processo burocrático de preenchimento de fichas de avaliação de desempenho.',
 'B',
 'A alternativa B está correta: a Liderança Militar é caracterizada pela doutrina como elemento informal, mas desejável, do comando, capaz de mover homens e mulheres para além da mera força da lei. A alternativa A define, na verdade, a esfera formal do comando (autoridade legal e administração). A alternativa C reduz a liderança à gerência, equívoco que o próprio manual rejeita. A alternativa D é incorreta, pois a autoridade legal e a administração continuam necessárias, coexistindo com a liderança. A alternativa E descreve burocracia administrativa, e não o fenômeno da liderança.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao distinguir os elementos formais (autoridade legal, administração) e informais (liderança) que compõem o exercício do comando. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q29: Alternância de estilos de comando
(@cat_ch06,
 'Situação Hipotética: Em um cenário de combate imediato, sob fogo inimigo, o comandante utiliza um estilo onde centraliza todas as decisões e espera execução sem questionamentos. Terminada a crise, em tempo de paz, ele passa a ouvir as sugestões de seu estado-maior para planejar o adestramento. Esta alternância de estilos (Autocrático para Participativo) é:',
 'Inadequada, pois o comandante deve escolher um único estilo e mantê-lo por toda a vida.',
 'Recomendada, pois o estilo deve ser alternado conforme a situação, o perfil do grupo e a urgência da missão.',
 'Um sinal de fraqueza, indicando que o líder perdeu sua autoridade após o combate.',
 'Proibida pelos manuais, que exigem o estilo delegativo em todas as situações de conflito.',
 'Desnecessária, visto que a tropa prefere sempre o comando autocrático em qualquer ambiente.',
 'B',
 'A alternativa B está correta: a doutrina recomenda a alternância do uso de mais de um estilo de liderança em função da situação, do perfil do grupo e da urgência da missão. As alternativas A e E sugerem uma rigidez de estilo único, considerada imprópria pela doutrina. A alternativa C confunde flexibilidade de estilo com fraqueza de comando, o que é equivocado. A alternativa D é falsa, pois o estilo autocrático pode ser o mais adequado justamente em situações de combate imediato, como no cenário descrito.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao recomendar a flexibilidade e a alternância situacional dos estilos de comando. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'medio'),

-- Q30: Vínculos afetivos e objetivos da OM (questão analítica)
(@cat_ch06,
 'Questão Analítica: Considere uma Organização Militar que atravessa um período de baixa motivação devido a sucessivas missões administrativas extenuantes. O Comandante busca restabelecer os "vínculos afetivos" para atingir os objetivos da Unidade. Com base no conceito doutrinário de Liderança Militar (p. 12), este processo de influência interpessoal deve focar em:',
 'Aplicar o rigor máximo dos regulamentos disciplinares para erradicar o desânimo pela força.',
 'Estabelecer uma relação de amizade pessoal que ignore a hierarquia, visando o bem-estar imediato.',
 'Favorecer o logro dos objetivos da OM por meio do estabelecimento de vínculos afetivos e credibilidade.',
 'Substituir os objetivos da missão militar pelas aspirações individuais de cada soldado.',
 'Ignorar a situação psicossocial do grupo, focando exclusivamente na gestão de recursos materiais.',
 'C',
 'A alternativa C está correta: o conceito doutrinário de Liderança Militar foca no estabelecimento de vínculos afetivos e de credibilidade de modo a favorecer o logro (alcance) dos objetivos da Organização Militar, conciliando o bem-estar do grupo com a missão institucional. As alternativas A e E focam apenas na esfera formal (rigor disciplinar) ou material (gestão de recursos), ignorando o comprometimento afetivo que a doutrina exige como complemento, não substituto, da disciplina. A alternativa B propõe uma "promiscuidade" que rompe a hierarquia, risco que a própria doutrina alerta ser perigoso para a coesão. A alternativa D inverte a responsabilidade do líder, que deve conciliar os interesses da missão com os do subordinado, e não substituir uns pelos outros.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual de Campanha C 20-10 (Liderança Militar), Exército Brasileiro, ao definir a liderança militar como processo de influência interpessoal voltado ao estabelecimento de vínculos afetivos em prol dos objetivos da Organização Militar. Não há lei pública correspondente.',
 'Manual C 20-10 — Liderança Militar',
 'dificil');

SET foreign_key_checks = 1;
