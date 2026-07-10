-- ============================================================
-- QUIZ — Disciplina 15/20 do CHO: Logística Militar
-- 30 questões — doutrina de Logística Militar e Gestão Patrimonial
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: apostila "Logística Militar.pdf" (Academia Coronel Walterler) —
--   evolução histórica da logística (Jomini, Henry Eccles, Thorpe), cadeia de
--   abastecimento (Supply Chain), níveis de planejamento (estratégico/tático/
--   operacional), atividades de recebimento e estocagem, política de estoques,
--   depreciação e situação patrimonial (Bom/Antieconômico/Recuperável/Irrecuperável),
--   nível de serviço logístico, classificação de bens, Layout de almoxarifado,
--   estratégias genéricas de Michael Porter, gestão de pessoas (recrutamento/seleção/
--   treinamento), e-commerce, Just in Time/Kanban, cultura organizacional, ciclo
--   administrativo clássico (PODC), intraempreendedorismo, Ponto de Ressuprimento/
--   Duplo Controle, órgãos da Diretoria de Apoio Logístico (DAL), fluxo de execução
--   da despesa pública (requisição, Termo de Referência, Projeto Básico), zonas
--   térmicas de aprovisionamento, tombamento e baixa patrimonial.
-- Observação sobre a fonte: disciplina majoritariamente de doutrina técnica de
--   administração/logística (Henry Eccles, Jomini, Michael Porter, teoria de
--   estoques), SEM lei numerada correspondente na maior parte das questões — não
--   há legislação nova para baixar nesta disciplina. Apenas as questões 24 e 25,
--   ao tratarem do fluxo de execução da despesa pública (requisição, Termo de
--   Referência e Projeto Básico), tocam a Lei nº 14.133/2021 (Nova Lei de
--   Licitações e Contratos Administrativos), citada de forma genérica por
--   analogia, já que o material de origem não especifica número de artigo exato.
--   A Lei 14.133/2021, se necessária como legislação de apoio, já está sendo
--   baixada pelo agente responsável pela Disciplina 14 — não duplicar o download.
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Logística Militar — CHO 15', 'Disciplina 15/20 do CHO — Doutrina de Logística Militar, cadeia de abastecimento, gestão de estoques, administração patrimonial (tombamento, descarga, depreciação) e fluxo de execução da despesa pública nas Organizações Militares Estaduais (OME)');

SET @cat_lm15 = (SELECT id FROM categorias WHERE nome = 'Logística Militar — CHO 15' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Origem histórica da logística militar
(@cat_lm15,
 'Um instrutor de Logística Militar do CHO explica que a evolução da logística se confunde com a própria evolução da Arte da Guerra, sendo indispensável para viabilizar o combate ao longo da história. Segundo a doutrina, essa aplicação histórica de técnicas logisticamente organizadas refere-se, especificamente, ao planejamento:',
 'Do suporte exclusivo prestado ao quartel-general durante operações de cerco.',
 'Dos processos de auditoria de pedidos de compras governamentais.',
 'Da disposição tática da tropa na linha de frente, exclusivamente.',
 'Do abastecimento e da movimentação de materiais no lugar certo e no tempo certo.',
 'Dos sistemas de armazenagem adotados por centros de distribuição civis.',
 'D',
 'A alternativa D está correta: a doutrina define a essência histórica da logística militar como o planejamento do abastecimento e da movimentação de materiais para que estejam no lugar certo e no tempo certo, viabilizando o combate. A alternativa A restringe indevidamente a logística ao apoio de cercos, quando na verdade ela abrange toda a operação. A alternativa B confunde logística com controle financeiro/auditoria, atividade distinta. A alternativa C descreve apenas a disposição tática, e não o suporte logístico que a viabiliza. A alternativa E generaliza indevidamente para o âmbito civil, quando a questão trata da origem histórico-militar do conceito.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário — apostila de Logística Militar do CHO, sem lei pública numerada correspondente para a origem histórica do conceito.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q02: Integração da cadeia de abastecimento (Supply Chain)
(@cat_lm15,
 'Ao estruturar a cadeia de abastecimento (Supply Chain) de uma Organização Militar Estadual, o Chefe da Seção de Logística precisa integrar diversas atividades para assegurar a eficiência operacional do apoio à tropa. Segundo a doutrina logística, essas atividades compreendem a integração de:',
 'Informações, transporte, estoque, armazenamento, manuseio de materiais e embalagem.',
 'Sistemas disciplinares e regulamentos internos de pessoal.',
 'Planejamento, programação e controle exclusivos da produção fabril.',
 'Orçamentos e cotações de mercado, sem vínculo com a estocagem.',
 'Sistemas operacionais de comunicação social da corporação.',
 'A',
 'A alternativa A está correta: a doutrina define a cadeia de abastecimento (Supply Chain) como a integração de informações, transporte, estoque, armazenamento, manuseio de materiais e embalagem. A alternativa B confunde logística com disciplina de pessoal, tema estranho à cadeia de suprimentos. A alternativa C restringe indevidamente o conceito à produção fabril, quando a logística militar abrange todo o fluxo de suprimento. A alternativa D isola orçamento da estocagem, quando ambos são interdependentes na gestão logística. A alternativa E descreve comunicação institucional, sem relação com a cadeia de abastecimento.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao descrever as atividades integradas da cadeia de abastecimento. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q03: Níveis do planejamento logístico
(@cat_lm15,
 'No planejamento logístico de uma Organização Militar, os objetivos são desdobrados em três níveis distintos, cada um respondendo, em profundidade diferente, às perguntas "o que, como, quando e quanto" suprir. Segundo a doutrina, esses três níveis são classificados como:',
 'Conceitual, Financeiro e Estrutural.',
 'Layout, Armazéns e Codificação.',
 'Estratégico, Tático e Operacional.',
 'Produção, Expedição e Transporte.',
 'Administrativo, Jurídico e Contábil.',
 'C',
 'A alternativa C está correta: o planejamento logístico se desdobra nos níveis Estratégico, Tático e Operacional, cada qual respondendo às perguntas "o que, como, quando e quanto" suprir em diferentes horizontes de tempo e amplitude de decisão. As demais alternativas apresentam classificações estranhas à doutrina de planejamento logístico, misturando termos de outras áreas (financeira, estrutural, jurídica) que não correspondem aos três níveis reconhecidos.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao descrever os níveis de planejamento logístico. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q04: Atividade de Recebimento
(@cat_lm15,
 'Situação Hipotética: ao chegar um lote de material na Unidade, o militar responsável identifica o item, confere o documento fiscal com o pedido originalmente emitido e realiza a inspeção quantitativa e qualitativa antes de aceitar formalmente o material. Essa sequência de atividades é tecnicamente denominada:',
 'Movimentação interna.',
 'Recebimento.',
 'Procurement (Compras).',
 'Distribuição física.',
 'Estocagem de segurança.',
 'B',
 'A alternativa B está correta: o Recebimento compreende justamente a identificação do material, a conferência do documento fiscal com o pedido, a inspeção quantitativa e qualitativa e a aceitação final. A alternativa A refere-se à movimentação de material já internalizado, etapa posterior. A alternativa C (Procurement) diz respeito à fase de aquisição/compra, anterior à chegada física do material. A alternativa D trata da saída de material para os usuários finais, não da entrada. A alternativa E refere-se à manutenção de níveis mínimos de estoque, tema distinto da conferência de recebimento.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao descrever a atividade de Recebimento dentro do fluxo logístico. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q05: Políticas de estoque (mission-dependent)
(@cat_lm15,
 'Situação Hipotética: o Comandante de uma Organização Militar questiona por que a política de estoques de sua Unidade é diferente da adotada por outra Organização Militar da mesma corporação, com a mesma disponibilidade orçamentária. Segundo a doutrina de administração logística, a resposta correta é que as políticas de estoque são estabelecidas:',
 'De forma unificada para todos os órgãos públicos, independentemente da função exercida.',
 'Exclusivamente pelo espaço físico disponível para materiais permanentes.',
 'Pelo resultado de pesquisas de mercado focadas em maximização de lucro líquido.',
 'Pela contratação obrigatória de consultorias internacionais de logística.',
 'De organização para organização, a depender da missão e do objetivo estratégico de cada uma.',
 'E',
 'A alternativa E está correta: a doutrina afirma que as políticas de estoque variam de organização para organização, dependendo da missão e do objetivo estratégico de cada uma — não existe modelo único aplicável a todos os órgãos. A alternativa A contraria essa premissa de individualização. A alternativa B isola um único fator (espaço físico), ignorando os demais critérios estratégicos e operacionais. A alternativa C importa uma lógica de lucro, estranha à natureza pública e não lucrativa da Organização Militar. A alternativa D descreve uma exigência inexistente na doutrina.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao tratar da definição de políticas de estoque conforme a missão de cada organização. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q06: Depreciação patrimonial
(@cat_lm15,
 'No âmbito da contabilidade patrimonial de uma Organização Militar, o Fiscal Administrativo precisa registrar a perda de valor de uma viatura decorrente do tempo de uso e do desgaste natural. Tecnicamente, esse fenômeno contábil é definido como:',
 'A parcela do financiamento bancário utilizado para a aquisição do material.',
 'A perda de valor decorrente exclusivamente do uso inadequado pelo servidor.',
 'A vida útil definida pelo fabricante apenas para fins de garantia comercial.',
 'A diminuição do valor dos bens por desgaste, perda de utilidade, ação da natureza ou obsolescência.',
 'A manutenção corretiva necessária para restaurar a capacidade operacional do bem.',
 'D',
 'A alternativa D está correta: a depreciação é tecnicamente definida como a diminuição do valor dos bens por desgaste, perda de utilidade, ação da natureza ou obsolescência, e não decorre apenas de mau uso. A alternativa A confunde depreciação com financiamento, conceitos financeiros distintos. A alternativa B restringe indevidamente a causa ao uso inadequado, quando a depreciação ocorre mesmo com uso correto e regular. A alternativa C confunde depreciação contábil com garantia comercial do fabricante. A alternativa E descreve manutenção corretiva, atividade de reparo, e não o fenômeno de perda de valor patrimonial.\n\n📜 Fundamento legal vigente: conceito doutrinário de contabilidade patrimonial — apostila de Logística Militar do CHO. Não há lei pública numerada especificada no material de origem para a definição técnica de depreciação.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q07: Nível de serviço logístico
(@cat_lm15,
 'Ao avaliar o desempenho de um fornecedor contratado para o abastecimento contínuo de gêneros alimentícios de uma Organização Militar, o gestor logístico utiliza um indicador que mede especificamente o desempenho oferecido pelo fornecedor no atendimento dos pedidos da Unidade. Esse indicador é denominado, na doutrina, como:',
 'Nível de serviço logístico.',
 'Qualidade da negociação de preços feita pelo pregoeiro.',
 'Eficácia do sistema produtivo adotado pela indústria fornecedora.',
 'Agilidade da comissão de recebimento na conferência de notas fiscais.',
 'Utilização do sistema Kanban no controle de materiais de consumo.',
 'A',
 'A alternativa A está correta: o nível de serviço logístico é o indicador que aponta especificamente o desempenho oferecido pelos fornecedores aos clientes no atendimento dos pedidos. A alternativa B refere-se à negociação de preços, atividade de compras, e não ao desempenho de entrega. A alternativa C foca na eficácia produtiva interna do fornecedor, e não no atendimento ao cliente. A alternativa D descreve uma atividade de conferência interna da Organização Militar, não um indicador do fornecedor. A alternativa E refere-se a uma ferramenta de controle de estoque, e não a um indicador de desempenho do fornecedor.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao definir o indicador de nível de serviço logístico. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q08: Classificação técnica dos produtos
(@cat_lm15,
 'O conhecimento técnico do produto é indispensável para o planejamento das atividades de manutenção e de compras de uma Organização Militar. Segundo a classificação tradicionalmente adotada pela doutrina, os produtos são classificados em:',
 'Bens Tangíveis e Bens Recicláveis.',
 'Bens de Comparação e Bens de Composição.',
 'Bens de Consumo e Bens Industriais.',
 'Bens de Troca e Bens de Reposição.',
 'Bens de Serviço e Bens de Transformação.',
 'C',
 'A alternativa C está correta: a doutrina classifica tradicionalmente os produtos em Bens de Consumo e Bens Industriais, categorias que orientam o planejamento de manutenção e de compras. As demais alternativas apresentam nomenclaturas que não correspondem à classificação técnica reconhecida pela doutrina de administração de materiais, misturando termos estranhos ao referencial adotado.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao classificar tecnicamente os produtos em Bens de Consumo e Bens Industriais. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q09: Estratégias centrais do planejamento logístico
(@cat_lm15,
 'O planejamento logístico de uma Organização Militar fundamenta-se em estratégias centrais que visam agregar valor ao serviço prestado e otimizar toda a rede de suprimentos. Segundo a doutrina, essas estratégias centrais referem-se à:',
 'Informação, transmissão de relatórios e dados.',
 'Localização, estoque e transporte.',
 'Contratação, treinamento e capacitação de pessoal.',
 'Embalagem, movimentação e expedição de material.',
 'Layouts, mobiliário e comunicação interna.',
 'B',
 'A alternativa B está correta: a doutrina define as estratégias centrais do planejamento logístico como Localização, Estoque e Transporte, pilares que sustentam toda a rede de suprimentos. As demais alternativas descrevem atividades ou ferramentas de apoio (relatórios, treinamento, embalagem, layout), mas não correspondem às três estratégias centrais reconhecidas pela doutrina.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao definir as estratégias centrais do planejamento logístico. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q10: Definição técnica de estoques
(@cat_lm15,
 'Um novo Fiscal Administrativo, ao assumir a função em uma Organização Militar, pergunta ao seu antecessor o que tecnicamente configura o "estoque" da Unidade. A resposta doutrinariamente correta é que estoques são definidos como:',
 'Todos os itens cadastrados no Banco de Preços da Fazenda Estadual.',
 'O conjunto de bens já entregues e em uso pelo usuário final.',
 'Materiais indicados pelo Estado-Maior exclusivamente para descarte e alienação.',
 'Todos os bens e materiais mantidos por uma organização para atender demandas futuras.',
 'Itens de luxo ou de reserva especial não previstos em orçamento.',
 'D',
 'A alternativa D está correta: tecnicamente, estoques são definidos como todos os bens e materiais mantidos por uma organização para atender demandas futuras, independentemente da natureza específica do item. A alternativa A confunde estoque com um sistema de referência de preços, ferramenta distinta. A alternativa B descreve bens já consumidos/utilizados, e não o estoque disponível. A alternativa C restringe indevidamente o conceito a materiais destinados ao descarte. A alternativa E descreve uma categoria residual e não representa a definição geral de estoque.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao definir tecnicamente o conceito de estoque. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q11: Conceito de Layout
(@cat_lm15,
 'Ao planejar a reorganização física do almoxarifado de uma Organização Militar, o Fiscal Administrativo solicita à equipe técnica a elaboração de um documento que represente graficamente a disposição do local e de suas partes componentes. Esse documento é tecnicamente denominado:',
 'Sistema informatizado de gerenciamento de armazéns (WMS).',
 'Descrição pormenorizada dos bens permanentes da unidade.',
 'Representação gráfica, esboço ou projeto do local e das partes componentes de uma unidade.',
 'Fluxo eletrônico de transmissão de dados entre a OME e a DAL.',
 'Código alfanumérico utilizado para catalogar materiais.',
 'C',
 'A alternativa C está correta: o Layout é tecnicamente definido como a representação gráfica, o esboço ou o projeto do local e das partes componentes de uma unidade, ferramenta essencial ao planejamento físico de almoxarifados. A alternativa A descreve um sistema informatizado de gestão, ferramenta distinta do conceito gráfico de layout. A alternativa B refere-se ao inventário descritivo de bens, não à representação espacial do local. A alternativa D descreve um fluxo de dados eletrônico, sem relação com a representação gráfica do espaço físico. A alternativa E refere-se à codificação de materiais, atividade de classificação, e não de layout.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao definir o conceito de Layout na estruturação de almoxarifados. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q12: Estratégias genéricas de Michael Porter
(@cat_lm15,
 'Ao elaborar o planejamento estratégico da área de suprimentos, o gestor logístico se vale das estratégias genéricas propostas por Michael Porter para otimizar o desempenho organizacional. Segundo essa teoria, tais estratégias genéricas baseiam-se em:',
 'Liderança em tempo de resposta e publicidade institucional.',
 'Liderança em custos, diferenciação e foco.',
 'Atendimento ao cliente e suporte pós-venda.',
 'Expansão de mercado e redução de efetivo.',
 'Liderança em tecnologia da informação e automação.',
 'B',
 'A alternativa B está correta: as estratégias genéricas de Michael Porter, incorporadas pela doutrina de administração logística, baseiam-se em Liderança em Custos, Diferenciação e Foco. As demais alternativas apresentam combinações de conceitos que não correspondem à formulação clássica de Porter, ainda que alguns termos (tecnologia, atendimento ao cliente) possam estar relacionados a estratégias específicas de negócio, mas não às três estratégias genéricas propriamente ditas.\n\n📜 Fundamento legal vigente: conceito doutrinário de administração/estratégia empresarial — apostila de Logística Militar do CHO, ao incorporar as estratégias genéricas de Michael Porter. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q13: Treinamento como desenvolvimento do capital humano
(@cat_lm15,
 'Uma Organização Militar identifica que seus militares recém-transferidos para a Seção de Suprimento carecem de conhecimento técnico específico sobre os sistemas de controle de estoque. A atividade voltada ao desenvolvimento do capital humano para o alcance de resultados com excelência técnica e administrativa, nesse cenário, é denominada:',
 'Recrutamento.',
 'Seleção.',
 'Treinamento.',
 'Integração.',
 'Avaliação funcional.',
 'C',
 'A alternativa C está correta: o Treinamento é a atividade voltada especificamente ao desenvolvimento do capital humano, capacitando os militares para o alcance de resultados com excelência técnica e administrativa. A alternativa A refere-se à atração de candidatos, etapa anterior à capacitação. A alternativa B refere-se à escolha dos candidatos mais adequados, também anterior ao desenvolvimento técnico. A alternativa D descreve a ambientação inicial do novo integrante, e não a capacitação técnica continuada. A alternativa E refere-se à mensuração de desempenho, não ao desenvolvimento de competências.\n\n📜 Fundamento legal vigente: conceito doutrinário de gestão de pessoas aplicado à logística — apostila de Logística Militar do CHO. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q14: Siglas de comércio eletrônico
(@cat_lm15,
 'No contexto da logística aplicada ao comércio eletrônico, diferentes modalidades de relacionamento comercial são identificadas por siglas específicas, conforme os agentes envolvidos (governo, empresa, consumidor). Assinale a alternativa que reúne corretamente essas siglas segundo a doutrina:',
 'B2P, B2C, C2G, M2B e E-PROCUREMENT.',
 'B2M, B2T, B2C, C2G e C2C.',
 'B2B, B2C, C2B, C2C, G2C e M-COMMERCE.',
 'B2O, B2B, C2B, M2C e B2G.',
 'B2S, B2G, G2B, B2P e E-COMMERCE.',
 'C',
 'A alternativa C está correta: a doutrina reconhece as modalidades B2B (empresa-empresa), B2C (empresa-consumidor), C2B (consumidor-empresa), C2C (consumidor-consumidor), G2C (governo-cidadão) e M-COMMERCE (comércio móvel) como as siglas corretas de comércio eletrônico. As demais alternativas combinam siglas inexistentes ou incorretas na nomenclatura doutrinária padronizada.\n\n📜 Fundamento legal vigente: conceito doutrinário de logística e comércio eletrônico — apostila de Logística Militar do CHO. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q15: Recrutamento e Seleção
(@cat_lm15,
 'O conjunto de práticas empregadas para a escolha dos candidatos mais adequados ao perfil das vagas existentes em uma instituição, etapa anterior à capacitação técnica dos novos integrantes, é conhecido pela doutrina como:',
 'Análise de currículos e capacitação.',
 'Recrutamento e seleção.',
 'Vestibular e entrevista técnica.',
 'Terceirização e análise de perfil.',
 'Descrição de cargos e salários.',
 'B',
 'A alternativa B está correta: o conjunto de práticas para a escolha dos candidatos mais adequados ao perfil das vagas é tecnicamente denominado Recrutamento e Seleção. A alternativa A descreve apenas parte do processo, sem abranger sua totalidade. As alternativas C, D e E descrevem instrumentos ou práticas específicas (vestibular, terceirização, descrição de cargos) que não correspondem à denominação técnica do processo como um todo.\n\n📜 Fundamento legal vigente: conceito doutrinário de gestão de pessoas aplicado à logística — apostila de Logística Militar do CHO. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q16: Just in Time e Kanban
(@cat_lm15,
 'Para agilizar o atendimento das demandas de suprimento e reduzir o volume de estoques parados, uma Organização Militar decide adotar ferramentas originárias da Escola Japonesa de Administração da Produção. As duas principais técnicas dessa escola, segundo a doutrina, são:',
 'SISCOMEX e INCOTERMS.',
 'Just in Time e Marketing.',
 'Just in Time e Kanban.',
 'Kanban e E-Commerce.',
 'Cross-Docking e Follow-up.',
 'C',
 'A alternativa C está correta: as principais técnicas da Escola Japonesa incorporadas pela logística são o Just in Time (produção/suprimento no momento exato da necessidade) e o Kanban (sistema visual de controle de fluxo de materiais). A alternativa A refere-se a instrumentos de comércio exterior, sem relação com a Escola Japonesa de produção. A alternativa B combina o Just in Time com uma técnica de área distinta (marketing). A alternativa D combina o Kanban com uma modalidade de comércio eletrônico, não uma técnica de produção japonesa. A alternativa E descreve técnicas de logística de distribuição, mas não correspondem ao par clássico Just in Time/Kanban.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao incorporar as técnicas da Escola Japonesa de Administração da Produção. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q17: Cultura organizacional
(@cat_lm15,
 'Um oficial recém-promovido percebe que determinadas decisões administrativas de sua Organização Militar seguem um padrão de crenças, costumes e normas de comportamento próprios daquela Unidade, distintos dos de outras corporações. Esse conjunto de elementos que direciona as decisões organizacionais é tecnicamente definido como:',
 'Sistema empresarial integrado.',
 'Fluxograma da organização.',
 'Cultura organizacional.',
 'Pesquisa de clima organizacional.',
 'Critério de planejamento setorial.',
 'C',
 'A alternativa C está correta: a Cultura Organizacional é definida como o conjunto de crenças, costumes, sistemas de valores e normas de comportamento que direcionam as decisões em uma organização. A alternativa A refere-se a um sistema de tecnologia de gestão, e não ao conjunto de valores e costumes. A alternativa B descreve a representação gráfica de processos, ferramenta distinta. A alternativa D refere-se a um instrumento de mensuração da satisfação, e não à própria cultura. A alternativa E descreve critérios técnicos de planejamento, sem relação com valores e costumes organizacionais.\n\n📜 Fundamento legal vigente: conceito doutrinário de administração — apostila de Logística Militar do CHO. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q18: Ciclo administrativo clássico (PODC)
(@cat_lm15,
 'Ao coordenar os recursos humanos, materiais e financeiros de sua Seção, um Oficial de Logística aplica, de forma sequencial e cíclica, quatro funções administrativas clássicas. Segundo a doutrina, essas funções básicas são:',
 'Planejamento, organização, direção e controle.',
 'Compras, recebimento, armazenagem e expedição.',
 'Controle de qualidade, inspeção e correção.',
 'Planejamento estratégico, tático e operacional.',
 'Orçamentos, demonstrativos e balanços.',
 'A',
 'A alternativa A está correta: o ciclo administrativo clássico, aplicável à coordenação de recursos em qualquer organização, é composto por Planejamento, Organização, Direção e Controle (PODC). A alternativa B descreve etapas específicas do fluxo logístico de materiais, e não as funções administrativas gerais. A alternativa C reduz o ciclo a apenas uma de suas etapas (controle), sem abranger as demais. A alternativa D confunde as funções administrativas com os níveis de planejamento logístico (tema de outra questão). A alternativa E restringe indevidamente o ciclo administrativo a instrumentos financeiro-contábeis.\n\n📜 Fundamento legal vigente: conceito doutrinário de administração geral — apostila de Logística Militar do CHO, ao descrever o ciclo administrativo clássico (Planejamento, Organização, Direção e Controle). Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'facil'),

-- Q19: Intraempreendedorismo
(@cat_lm15,
 'Situação Hipotética: um Sargento lotado na Seção de Suprimento, por iniciativa própria, propõe e implementa melhorias no fluxo de requisições internas, contribuindo ativamente para a inovação dos processos administrativos de sua Unidade. Essa postura proativa do colaborador dentro da própria instituição é conhecida, segundo a doutrina, como:',
 'Empreendedorismo de risco.',
 'Empreendedorismo corporativo.',
 'Empreendedorismo reativo.',
 'Empreendedorismo de inovação.',
 'Empreendedorismo proativo.',
 'B',
 'A alternativa B está correta: a postura proativa do colaborador que contribui para inovações e melhorias nos processos internos de sua própria instituição é tecnicamente denominada Empreendedorismo Corporativo (também conhecido como intraempreendedorismo). As demais alternativas apresentam denominações que não correspondem ao termo técnico consagrado pela doutrina para esse fenômeno específico de inovação interna institucional.\n\n📜 Fundamento legal vigente: conceito doutrinário de gestão organizacional — apostila de Logística Militar do CHO. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q20: Funções primordiais da gestão de estoques
(@cat_lm15,
 'Para garantir o abastecimento contínuo de uma Organização Militar e evitar rupturas no fluxo de suprimento, a doutrina de gestão de estoques indica que devem ser consideradas, como funções primordiais, a:',
 'Embalagem e estocagem.',
 'Obtenção e sistema de endereçamento.',
 'Treinamento e auditoria.',
 'Planejamento tático e marketing.',
 'Financiamento e liquidação.',
 'B',
 'A alternativa B está correta: a doutrina indica a Obtenção (garantir a disponibilidade do material) e o Sistema de Endereçamento (localização física organizada dos itens no almoxarifado) como funções primordiais para a gestão eficaz de estoques e o abastecimento contínuo. A alternativa A descreve atividades operacionais de manuseio, mas não as funções primordiais estruturantes da gestão de estoques. As alternativas C, D e E descrevem funções de outras áreas (pessoal, marketing, finanças) que não constituem as funções primordiais específicas da gestão de estoques.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao definir as funções primordiais da gestão de estoques. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q21: Distinções doutrinárias históricas (Jomini x Henry Eccles x Thorpe)
(@cat_lm15,
 'A doutrina de Logística Militar consolidou-se ao longo do tempo por meio de diversos teóricos que elevaram as atividades de suporte ao nível da estratégia militar. Sobre as distinções históricas entre esses teóricos, assinale a alternativa correta:',
 'Clausewitz foi o pioneiro no uso do termo "logística" em sua obra "Da Guerra".',
 'O Almirante Henry Eccles é considerado o "pai da logística moderna", embora o termo tenha sido introduzido na literatura militar por Jomini.',
 'Jomini defendia que a logística era meramente uma "preparação para a guerra", sem caráter científico.',
 'O Tenente-Coronel Thorpe publicou "Logística Pura" no início do século XX, situando-a hierarquicamente acima da tática e da estratégia militar.',
 'A missão militar estrangeira que assessorou o Brasil no início do século XX extinguiu o Serviço de Intendência para concentrar esforços exclusivamente em combate.',
 'B',
 'A alternativa B está correta: a doutrina atribui a Jomini a introdução do termo "logística" na literatura militar, ao passo que o Almirante Henry Eccles é reconhecido como o "pai da logística moderna", por ter sistematizado cientificamente a disciplina no século XX. A alternativa A atribui erroneamente a Clausewitz a autoria do termo, quando essa introdução é associada a Jomini. A alternativa C inverte o pensamento de Jomini, que buscou dar caráter científico à logística, e não reduzi-la a uma "mera preparação". A alternativa D é falsa quanto à hierarquia proposta por Thorpe, que buscou elevar, e não subordinar, o status da logística. A alternativa E é falsa, pois a assessoria estrangeira ao Brasil buscou fortalecer, e não extinguir, os serviços de intendência e suprimento.\n\n📜 Fundamento legal vigente: conceito doutrinário-histórico — apostila de Logística Militar do CHO, ao descrever a evolução do pensamento logístico militar (Jomini, Henry Eccles, Thorpe). Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'dificil'),

-- Q22: Fiscal Administrativo x Almoxarife
(@cat_lm15,
 'No âmbito de uma Unidade Administrativa, as funções de Fiscal Administrativo e de Almoxarife são distintas quanto às respectivas atribuições. De acordo com a doutrina de administração militar, é correto afirmar que:',
 'O Almoxarife é o principal assessor do Comandante para assuntos de administração financeira e patrimonial da Unidade.',
 'Compete ao Fiscal Administrativo gerenciar o sistema de suprimentos e fiscalizar permanentemente os registros contábeis de administração patrimonial.',
 'O Almoxarife detém a competência para designar comissões de inventário e de exame e descarga de materiais.',
 'O Fiscal Administrativo possui responsabilidade individual e exclusiva pela guarda física do estoque do rancho.',
 'Cabe ao Almoxarife a redação dos atos e fatos administrativos para publicação em boletim interno.',
 'B',
 'A alternativa B está correta: o Fiscal Administrativo é o agente executor direto que assessora o Agente Diretor e o Ordenador de Despesas, cabendo-lhe gerenciar o sistema de suprimentos e fiscalizar permanentemente os registros contábeis de administração patrimonial. A alternativa A atribui indevidamente ao Almoxarife a função de assessoramento financeiro-patrimonial, que é do Fiscal Administrativo. A alternativa C atribui ao Almoxarife uma competência de designação de comissões, que cabe à autoridade administrativa (Agente Diretor), e não ao Almoxarife. A alternativa D restringe indevidamente ao Fiscal Administrativo a guarda física do rancho, atribuição do Aprovisionador/Almoxarife de subsistência. A alternativa E atribui ao Almoxarife uma função de redação de atos administrativos, que é própria do Fiscal Administrativo e da Secretaria/Contabilidade.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário — apostila de Logística Militar do CHO. Por analogia, a atribuição de gerenciar o sistema de suprimentos e fiscalizar permanentemente os registros contábeis de administração patrimonial corresponde à figura do Fiscal Administrativo tratada no Regulamento de Administração do Exército (RAE, Decreto federal n. 98.820/1990, arts. 30-31), usado como referência doutrinária de administração militar no CHO da PMRR (ver seção 11 da base de conhecimento de legislação do projeto).',
 'Doutrina de Logística Militar; RAE (Decreto n. 98.820/1990), arts. 30-31 (analogia)',
 'medio'),

-- Q23: Órgãos da Diretoria de Apoio Logístico (DAL)
(@cat_lm15,
 'A Diretoria de Apoio Logístico (DAL) de uma corporação militar estadual possui órgãos de apoio subordinados com competências técnicas específicas. Assinale a alternativa que descreve corretamente a atribuição do Centro de Suprimento e Manutenção de Intendência (CSM/Int):',
 'Executar o suprimento e a manutenção de todo o material de engenho bélico da Corporação.',
 'Controlar a qualidade da execução de obras e reformas de engenharia nas edificações militares.',
 'Executar o suprimento e a manutenção de material de transporte e o apoio de subsistência.',
 'Realizar exclusivamente a coleta de dados para o processamento eletrônico de estatísticas.',
 'Instalar e manter o sistema de comunicações e telefonia de todas as Organizações Militares Estaduais.',
 'C',
 'A alternativa C está correta: o Centro de Suprimento e Manutenção de Intendência (CSM/Int) é responsável por executar o suprimento e a manutenção de material de transporte e o apoio de subsistência das Organizações Militares. A alternativa A descreve atribuição de órgão de material bélico, distinto da intendência. A alternativa B descreve atribuição de órgão de engenharia, estranha à intendência. A alternativa D restringe indevidamente a atuação do CSM/Int a estatística, atividade de outro órgão de apoio. A alternativa E descreve atribuição de órgão de comunicações, também distinta da intendência.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao descrever as atribuições dos órgãos subordinados à Diretoria de Apoio Logístico (DAL). Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'dificil'),

-- Q24: Fluxo de execução da despesa pública — Requisição
(@cat_lm15,
 'No fluxo de execução da despesa pública de uma Organização Militar Estadual, a Requisição (Pedido) constitui a fase inicial que antecede a autorização formal da despesa. Segundo a doutrina, aplicada ao regime das contratações públicas, é requisito obrigatório dessa requisição:',
 'A indicação de marca e modelo preferencial, para garantir a padronização técnica do material.',
 'O registro prévio da existência de dotação orçamentária para fazer face à despesa pretendida.',
 'A dispensa do orçamento estimado sempre que o objeto for considerado urgente pelo requisitante.',
 'A definição do local de entrega apenas no momento da assinatura da nota de empenho.',
 'A apresentação de projeto básico apenas para compras de materiais de consumo de baixo valor.',
 'B',
 'A alternativa B está correta: a requisição, como fase inicial do fluxo de despesa pública, exige o registro prévio da existência de dotação orçamentária que suporte a despesa pretendida — sem essa verificação, a Administração não pode prosseguir com a contratação. A alternativa A descreve uma prática vedada, já que a indicação de marca específica, sem justificativa técnica, fere a impessoalidade e a competitividade exigidas nas contratações públicas. A alternativa C contraria a regra geral de que o orçamento estimado deve, como regra, acompanhar a requisição, mesmo em contratações urgentes. A alternativa D é falsa, pois o local de entrega deve constar desde a fase da requisição/instrumento convocatório, não apenas no empenho. A alternativa E é falsa, pois a exigência de projeto básico (ou instrumento equivalente) não se limita a compras de baixo valor.\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — apostila de Logística Militar do CHO, ao descrever o fluxo de execução da despesa pública. O tema toca, por analogia genérica, a disciplina das contratações públicas da Lei nº 14.133/2021 (Lei de Licitações e Contratos Administrativos), que exige a demonstração da adequação orçamentária da despesa como condição para o prosseguimento da contratação, sem que o material de origem especifique o número exato do dispositivo correspondente.',
 'Doutrina de Logística Militar; Lei nº 14.133/2021 (por analogia)',
 'medio'),

-- Q25: Termo de Referência x Projeto Básico
(@cat_lm15,
 'No processamento das requisições de uma Organização Militar Estadual, são utilizados instrumentos técnicos distintos conforme a modalidade de contratação a ser adotada, entre eles o Termo de Referência (TR) e o Projeto Básico (PB). Sobre a correspondência entre esses instrumentos e o regime de contratações, assinale a alternativa correta:',
 'O Termo de Referência é o instrumento adequado exclusivamente para as modalidades clássicas, como a Concorrência.',
 'As Organizações Militares Estaduais são vedadas de formalizar dispensas de licitação por valor, sendo essa competência exclusiva da DAL.',
 'O Termo de Referência está para o Pregão assim como o Projeto Básico está para as modalidades licitatórias clássicas.',
 'O recebimento provisório é um ato discricionário que pode ser dispensado em qualquer contratação de obra.',
 'O Projeto Básico dispensa a indicação das sanções aplicáveis e das obrigações do contratante.',
 'C',
 'A alternativa C está correta: segundo a doutrina, o Termo de Referência está para o Pregão assim como o Projeto Básico está para as modalidades licitatórias clássicas, refletindo a correspondência tradicional entre instrumento técnico e modalidade de contratação. A alternativa A inverte essa correspondência, atribuindo ao TR uma finalidade que é, na verdade, do Projeto Básico. A alternativa B descreve uma vedação inexistente na doutrina, que não atribui exclusividade absoluta à DAL para dispensas por valor. A alternativa D contraria a exigência doutrinária de formalização do recebimento provisório em contratações de obras, que não é ato meramente discricionário. A alternativa E é falsa, pois tanto o Projeto Básico quanto o Termo de Referência devem indicar sanções e obrigações contratuais.\n\n📜 Fundamento legal vigente: o fundamento primário é doutrinário — apostila de Logística Militar do CHO. O tema toca, por analogia genérica, a disciplina dos instrumentos de contratação (Termo de Referência e Projeto Básico/Estudo Técnico Preliminar) prevista na Lei nº 14.133/2021, que manteve essa distinção funcional entre os instrumentos conforme a modalidade adotada, sem que o material de origem especifique o número exato do dispositivo correspondente.',
 'Doutrina de Logística Militar; Lei nº 14.133/2021 (por analogia)',
 'dificil'),

-- Q26: Ponto de Ressuprimento e Duplo Controle
(@cat_lm15,
 'A administração de almoxarifados emprega métodos de controle para monitorar o fluxo de materiais e evitar rupturas de estoque. Sobre os conceitos de "Ponto de Ressuprimento" e "Duplo Controle", é correto afirmar que:',
 'O Ponto de Ressuprimento é o gatilho que, ao ser atingido pelo estoque em declínio, determina a adoção de medidas para o ressuprimento do item.',
 'O método do "Duplo Controle" baseia-se na exclusividade da Ficha de Controle Geral, dispensando a Ficha de Prateleira.',
 'O Nível Máximo de estoque é a quantidade mínima de segurança que jamais deve ser atingida.',
 'A Ficha de Prateleira deve ser arquivada na seção de finanças, distante do local de estocagem física do material.',
 'O Ponto de Ressuprimento deve ser sempre superior ao Nível Máximo, para evitar a obsolescência do item.',
 'A',
 'A alternativa A está correta: o Ponto de Ressuprimento é o gatilho que, ao ser atingido pelo estoque em declínio, determina a adoção de medidas administrativas para o ressuprimento do item, evitando a ruptura. A alternativa B inverte o conceito de Duplo Controle, que se baseia justamente na utilização conjunta da Ficha de Controle Geral e da Ficha de Prateleira, e não na exclusividade de uma delas. A alternativa C confunde Nível Máximo com Nível Mínimo (ou estoque de segurança), invertendo os conceitos. A alternativa D contraria a lógica do Duplo Controle, que exige que a Ficha de Prateleira permaneça junto ao local físico de estocagem, para conferência imediata. A alternativa E é logicamente incoerente, pois o Ponto de Ressuprimento deve necessariamente ser inferior ao Nível Máximo, e não superior.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao descrever os métodos de Ponto de Ressuprimento e Duplo Controle na administração de almoxarifados. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'dificil'),

-- Q27: Zonas térmicas de aprovisionamento
(@cat_lm15,
 'No setor de Aprovisionamento de uma Organização Militar, o armazenamento de gêneros alimentícios deve obedecer a zonas térmicas rigorosas, de modo a preservar a qualidade dos alimentos destinados ao rancho da tropa. Sobre a preservação de alimentos, assinale a alternativa correta:',
 'A deterioração química é a causa mais comum de perda de alimentos, provocada por ferimentos físicos nos tecidos.',
 'A "Área Fria" é aquela em que se deve manter a temperatura obrigatoriamente abaixo de 20ºC.',
 'Os gêneros alimentícios devem permanecer em contato direto com as paredes, para facilitar a troca térmica.',
 'A "Área de Refrigeração" ou congelamento opera com temperaturas correntes entre 10ºC e 15ºC positivos.',
 'Insetos e roedores são classificados como causas de deterioração biológica por colapso celular.',
 'B',
 'A alternativa B está correta: a "Área Fria" do setor de Aprovisionamento deve ser mantida obrigatoriamente com temperatura abaixo de 20ºC, conforme a doutrina de preservação de gêneros alimentícios. A alternativa A confunde deterioração química com deterioração física (ferimentos nos tecidos), causas distintas. A alternativa C descreve uma prática vedada pelas normas de armazenamento, que exigem afastamento das paredes para ventilação e higiene. A alternativa D atribui à Área de Refrigeração temperaturas incompatíveis com a real faixa de conservação exigida, que deve ser bem mais baixa. A alternativa E confunde a ação de pragas (insetos e roedores), classificada como deterioração biológica por infestação, com "colapso celular", termo tecnicamente inadequado para essa causa.\n\n📜 Fundamento legal vigente: conceito doutrinário de aprovisionamento militar — apostila de Logística Militar do CHO, ao definir as zonas térmicas de armazenamento de gêneros alimentícios. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q28: Situação patrimonial — bem Antieconômico
(@cat_lm15,
 'Situação Hipotética: a comissão de exame e descarga avalia um equipamento cuja manutenção corretiva se mostra excessivamente onerosa, com orçamento de recuperação que ultrapassa metade do valor de mercado do bem. Nesse cenário, o material deve ser tecnicamente classificado, quanto à sua situação patrimonial, como:',
 'Bem em perfeitas condições de uso, mas sem demanda na unidade.',
 'Antieconômico, quando sua manutenção for onerosa ou sua recuperação orçar mais de 50% de seu valor de mercado.',
 'Bem que perdeu totalmente suas características físicas, não podendo mais ser identificado.',
 'Bem adquirido por doação, sem registro de valor histórico.',
 'Bem classificado como "Bom", cujo modelo foi apenas superado por tecnologia mais recente.',
 'B',
 'A alternativa B está correta: um material é tecnicamente classificado como "Antieconômico" quando sua manutenção for onerosa ou sua recuperação orçar mais de 50% de seu valor de mercado, conforme o critério doutrinário de situação patrimonial. A alternativa A descreve situação de ociosidade (bem "Ocioso"), não de antieconomicidade. A alternativa C descreve a classificação de bem "Irrecuperável", por perda total de identidade física, categoria distinta. A alternativa D refere-se à origem de aquisição do bem, sem relação com a situação patrimonial de recuperabilidade. A alternativa E descreve obsolescência tecnológica de um bem ainda "Bom", situação distinta da antieconomicidade decorrente do custo de recuperação.\n\n📜 Fundamento legal vigente: conceito doutrinário de administração patrimonial — apostila de Logística Militar do CHO, ao classificar a situação patrimonial dos bens (Bom, Antieconômico, Recuperável, Irrecuperável, Ocioso). Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q29: Tombamento patrimonial
(@cat_lm15,
 'O tombamento é o ato administrativo que identifica o material permanente com um número único, vinculando-o ao patrimônio da Organização Militar. Sobre as normas de tombamento, assinale a alternativa correta:',
 'O número de patrimônio é provisório e deve ser alterado a cada inventário anual da Unidade.',
 'Em caso de extravio de uma plaqueta, o bem deve ser descarregado imediatamente, mesmo que ainda esteja em uso.',
 'O número de patrimônio será definitivo e imutável durante toda a existência do bem.',
 'Conjuntos computacionais (CPU, monitor, teclado) devem ser obrigatoriamente incorporados sob um único número de patrimônio.',
 'O tombamento provisório é admitido para bens que ainda não foram entregues fisicamente pelo fornecedor.',
 'C',
 'A alternativa C está correta: o número de patrimônio atribuído no tombamento será definitivo e imutável durante toda a existência do bem, servindo de identificação única e permanente. A alternativa A contraria essa regra de imutabilidade, ao propor alteração periódica do número. A alternativa B é falsa, pois o extravio da plaqueta física não implica descarga automática do bem, que pode continuar em uso mediante regularização; a descarga segue hipóteses taxativas próprias. A alternativa D é falsa, pois cada item de um conjunto computacional possui identidade física própria e deve ser tombado individualmente. A alternativa E contraria a lógica do tombamento, que pressupõe a existência física e a entrada efetiva do bem no patrimônio, não sendo cabível tombamento provisório sobre bem ainda não recebido.\n\n📜 Fundamento legal vigente: conceito doutrinário de administração patrimonial — apostila de Logística Militar do CHO, ao descrever as normas de tombamento de material permanente. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'medio'),

-- Q30: Baixa patrimonial e dispensa de investigação
(@cat_lm15,
 'Situação Hipotética: um militar responsável por um bem permanente comunica sua avaria decorrente de manuseio inadequado e, de imediato, se prontifica voluntariamente a indenizar o Estado pelo prejuízo causado. Sobre os procedimentos de irregularidade e baixa patrimonial nesse cenário, é correto afirmar que:',
 'A plaqueta de tombamento deve ser removida e destruída assim que o material entrar no Depósito de Bens Inservíveis.',
 'A baixa por sinistro ocorre apenas em casos de roubo ou incêndio e é autorizada pela Gerência Geral de Patrimônio do Estado.',
 'A instauração de processo investigativo é obrigatória em todos os casos de avaria, mesmo quando decorrente de desgaste natural.',
 'O material descarregado pode ser alienado ou doado diretamente pelo Comandante da OME, sem qualquer autorização da DAL.',
 'A instauração de processo investigativo poderá ser dispensada se o usuário responsável se prontificar a indenizar o Estado.',
 'E',
 'A alternativa E está correta: a doutrina admite que a instauração de processo investigativo seja dispensada quando o próprio usuário responsável se prontifica voluntariamente a indenizar o Estado pelo prejuízo causado, simplificando o procedimento nesses casos. A alternativa A descreve um procedimento de remoção de plaqueta que não corresponde ao momento de entrada no depósito, mas a etapas posteriores da baixa. A alternativa B restringe indevidamente a baixa por sinistro a apenas duas hipóteses (roubo/incêndio) e atribui a autorização a órgão incorreto. A alternativa C contraria justamente a exceção tratada na questão, já que o desgaste natural (força maior sem culpa) não exige, via de regra, processo investigativo equivalente ao de dano culposo. A alternativa D descreve uma competência que, na doutrina de administração patrimonial, depende de formalização e, a depender do valor, de anuência do órgão gestor (DAL), não sendo ato unilateral e irrestrito do Comandante da OME.\n\n📜 Fundamento legal vigente: conceito doutrinário de administração patrimonial — apostila de Logística Militar do CHO, ao descrever os procedimentos de irregularidade e baixa patrimonial. Não há lei pública correspondente.',
 'Doutrina de Logística Militar',
 'dificil');

SET foreign_key_checks = 1;
