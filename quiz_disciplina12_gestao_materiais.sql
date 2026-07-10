-- ============================================================
-- QUIZ — Disciplina 12/20 do CHO: Gestão de Materiais e Patrimônio
-- 30 questões — doutrina técnica de Administração de Materiais e Logística Empresarial
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: Administração de Materiais como Sistema Integrado — fatores de
--   produção e sinergia; subsistemas (Classificação, Cadastro, Aquisição/Compra,
--   Inspeção de Recebimento e de Suprimentos, Almoxarifado/Armazenagem, Padronização
--   e Normalização, Controle de Estoque); objetivos da área (giro de estoques, relações
--   favoráveis com fornecedores); terminologia técnica de estoques (ativo/normal,
--   disponível, empenhado, teórico, mínimo, ponto de chamada de emergência, ruptura,
--   tempo de reposição/ressuprimento); documentos do fluxo de compras (requisição,
--   mapa comparativo de preços); estrutura de custos logísticos (custo fixo, custo de
--   posse, custo de aquisição, custo ideal); e funções do estoque (cobertura de risco,
--   amortecimento entre compra/produção/venda)
-- Observação sobre a fonte: disciplina baseada em doutrina técnica de Administração de
--   Materiais e Logística Empresarial (fundamentos de fatores de produção, teoria de
--   estoques e gestão de custos logísticos, correntes que remontam a autores como
--   Michael Porter e a ferramentas de gestão como o ciclo PDCA), sem lei pública
--   numerada correspondente — NÃO há legislação para baixar nesta disciplina.
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Gestão de Materiais e Patrimônio — CHO 12', 'Disciplina 12/20 do CHO — Fatores de produção e sinergia, subsistemas da Administração de Materiais, terminologia de estoques, fluxo de compras e custos logísticos (doutrina técnica de Administração de Materiais e Logística Empresarial)');

SET @cat_gm12 = (SELECT id FROM categorias WHERE nome = 'Gestão de Materiais e Patrimônio — CHO 12' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Fatores de produção — a Empresa como elemento aglutinador
(@cat_gm12,
 'Sob a ótica da integração sistêmica dos recursos produtivos, a teoria econômica clássica postula que a produção é o resultado da conjunção de fatores específicos. Qual desses fatores atua como o elemento aglutinador e coordenador, sendo responsável por gerar o efeito multiplicador conhecido como sinergia?',
 'Natureza.',
 'Capital.',
 'Trabalho.',
 'Empresa.',
 'Mão de obra.',
 'D',
 'A alternativa D está correta: segundo a teoria clássica dos fatores de produção, a Empresa é o elemento aglutinador e coordenador que reúne natureza, capital e trabalho, produzindo o efeito multiplicador denominado sinergia, em que o resultado do conjunto supera a soma das partes isoladas. As alternativas A, C e E descrevem fatores de produção que, isoladamente, apenas fornecem insumos ou força de trabalho, sem exercer papel coordenador. A alternativa B (Capital) tem função instrumental de viabilizar os demais fatores, mas também não é o elemento aglutinador — essa função pertence à Empresa como organização.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário, não legal — teoria clássica dos fatores de produção e da sinergia organizacional, própria da Administração de Materiais e da Logística Empresarial. Trata-se de doutrina técnico-administrativa, sem lei pública numerada correspondente nesta disciplina.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q02: Função instrumental do fator Capital
(@cat_gm12,
 'Na gestão organizacional, o fator de produção "Capital" desempenha um papel instrumental essencial para a viabilização das operações. Segundo o referencial teórico adotado, a função primordial deste fator é:',
 'Atuar diretamente sobre os demais fatores, acionando-os e agilizando-os por meio do esforço físico.',
 'Proporcionar os meios financeiros necessários para a aquisição de insumos, pagamento de pessoal e utilização dos demais fatores.',
 'Fornecer as entradas brutas, como energia e matérias-primas, indispensáveis ao início do ciclo produtivo.',
 'Converter insumos em produtos acabados por meio de operações manuais ou mecânicas.',
 'Definir as características de acondicionamento e a medida física das unidades produzidas.',
 'B',
 'A alternativa B está correta: o fator Capital tem função instrumental, fornecendo os meios financeiros necessários para a aquisição de insumos, o pagamento de pessoal e a utilização dos demais fatores de produção. A alternativa A descreve o fator Trabalho (esforço físico que aciona os demais fatores). A alternativa C descreve o fator Natureza (entradas brutas, matérias-primas). A alternativa D descreve a atuação da Empresa/Trabalho na transformação de insumos em produtos. A alternativa E não corresponde à função de nenhum dos fatores clássicos de produção.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao classificar a função instrumental do fator Capital dentre os fatores de produção. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q03: Classificação moderna dos recursos empresariais
(@cat_gm12,
 'A classificação moderna dos recursos empresariais substitui a nomenclatura clássica por termos mais aderentes à gestão administrativa contemporânea. Assinale a alternativa que apresenta corretamente os cinco principais recursos empresariais:',
 'Recursos Materiais, Patrimoniais, Produtivos, Logísticos e Financeiros.',
 'Recursos Naturais, Capitais, Trabalhistas, Empresariais e Lucrativos.',
 'Recursos Materiais, Financeiros, Humanos, Mercadológicos e Administrativos.',
 'Recursos de Entrada, Processamento, Saída, Retroação e Sinergia.',
 'Recursos de Matéria-prima, Equipamentos, Pessoal, Vendas e Gestão Geral.',
 'C',
 'A alternativa C está correta: a classificação moderna substitui a nomenclatura clássica (natureza, capital, trabalho) pelos cinco recursos empresariais: Materiais, Financeiros, Humanos, Mercadológicos e Administrativos. As demais alternativas misturam essa classificação com termos que não pertencem à nomenclatura consagrada pela doutrina (patrimoniais, logísticos, lucrativos, entrada/processamento/saída, vendas/gestão geral), configurando distratores que aparentam familiaridade mas não reproduzem a classificação correta.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na classificação moderna dos recursos empresariais. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q04: Conceito de sinergia
(@cat_gm12,
 'O conceito de sinergia é fundamental para justificar a existência da organização como entidade produtiva. Em um cenário onde a integração de fatores resulta em um ganho adicional (lucro), afirma-se que:',
 'O resultado do conjunto é exatamente igual à soma aritmética das partes isoladas.',
 'A independência total entre os recursos materiais e administrativos garante a eficiência.',
 'O fator capital é o único responsável pela geração de valor, independentemente da coordenação.',
 'O efeito multiplicador faz com que o resultado do conjunto supere a soma dos fatores se aplicados isoladamente.',
 'A sinergia ocorre apenas quando o fator trabalho substitui integralmente o fator capital.',
 'D',
 'A alternativa D está correta: a sinergia é o efeito multiplicador pelo qual o resultado da integração dos fatores supera a soma aritmética das partes se aplicadas isoladamente — é essa diferença positiva que justifica a existência da organização. A alternativa A nega o próprio conceito de sinergia, ao igualar o conjunto à soma das partes. A alternativa B contraria a ideia de integração sistêmica, que a Administração de Materiais pressupõe. As alternativas C e E atribuem o resultado a um único fator isolado (capital ou trabalho), ignorando a natureza coordenada e multifatorial da sinergia.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre o conceito de sinergia organizacional. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q05: Objetivo do Sistema Integrado de Administração de Materiais
(@cat_gm12,
 'A Administração de Materiais moderna é conceituada como um Sistema Integrado. Nesse contexto, o objetivo fundamental que orienta a interação de seus subsistemas é:',
 'Maximizar o investimento total em estoques para garantir a segurança absoluta contra rupturas.',
 'Suprir a organização com os meios necessários no tempo oportuno, na quantidade necessária, na qualidade requerida e pelo menor custo.',
 'Focar exclusivamente na redução drástica do preço de aquisição, independentemente do custo de armazenagem ou qualidade.',
 'Centralizar as decisões de marketing e vendas para alinhar o escoamento de produtos acabados.',
 'Promover a imobilização de capital em itens de baixo giro para valorização patrimonial a longo prazo.',
 'B',
 'A alternativa B está correta: o objetivo fundamental do Sistema Integrado de Administração de Materiais é suprir a organização com os meios necessários no tempo oportuno, na quantidade necessária, na qualidade requerida e pelo menor custo — as quatro condições básicas do suprimento. A alternativa A foca isoladamente na segurança contra rupturas, ignorando o equilíbrio com o custo. A alternativa C ignora a qualidade e a armazenagem em favor exclusivo do preço. A alternativa D atribui à Administração de Materiais uma função de marketing/vendas que não lhe é própria. A alternativa E contraria o próprio objetivo de giro eficiente, ao propor a imobilização de capital em itens de baixo giro.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao definir o objetivo do Sistema Integrado de suprimento (tempo, quantidade, qualidade e custo). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q06: Subsistema de Classificação de Material
(@cat_gm12,
 'Imagine que uma organização detectou duplicidade em seus registros de estoque, onde o mesmo parafuso estava cadastrado com dois códigos diferentes devido a descrições ambíguas. Qual subsistema típico da Administração de Materiais falhou em sua atribuição de identificação, especificação e codificação?',
 'Controle de Estoque.',
 'Aquisição / Compra.',
 'Almoxarifado.',
 'Classificação de Material.',
 'Movimentação de Material.',
 'D',
 'A alternativa D está correta: a identificação, especificação e codificação dos materiais são atribuições do subsistema de Classificação de Material; a duplicidade de códigos para o mesmo item revela falha nesse subsistema. A alternativa A (Controle de Estoque) cuida do nível de investimento e da movimentação quantitativa, não da codificação. A alternativa B (Aquisição/Compra) trata da negociação com fornecedores. A alternativa C (Almoxarifado) cuida da guarda física dos materiais já codificados. A alternativa E (Movimentação de Material) trata do deslocamento físico dos itens, não de sua especificação.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao atribuir a identificação, especificação e codificação ao subsistema de Classificação de Material. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q07: Subsistema de Aquisição/Compra
(@cat_gm12,
 'Considere uma interrupção na linha de produção devido à falta de matéria-prima. O gestor identifica que o material não estava disponível no prazo desejado, embora o estoque de produtos acabados estivesse alto. A responsabilidade direta pela gestão e negociação junto ao mercado para assegurar que os insumos estejam disponíveis nos prazos e preços favoráveis pertence ao subsistema de:',
 'Cadastro.',
 'Aquisição / Compra.',
 'Inspeção de Recebimento.',
 'Transporte de Material.',
 'Armazenagem.',
 'B',
 'A alternativa B está correta: a gestão e a negociação junto ao mercado para assegurar que os insumos estejam disponíveis nos prazos e preços desejados pertencem ao subsistema de Aquisição/Compra. A alternativa A (Cadastro) apenas subsidia a compra com informações de fornecedores, sem executar a negociação. A alternativa C (Inspeção de Recebimento) atua somente após a entrega do material. A alternativa D (Transporte) cuida do deslocamento físico, não da negociação comercial. A alternativa E (Armazenagem) trata da guarda dos itens já recebidos, e não da falta de matéria-prima relatada no cenário.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao atribuir a negociação de prazos e preços junto ao mercado ao subsistema de Aquisição/Compra. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q08: Subsistema de Almoxarifado/Armazenagem
(@cat_gm12,
 'O subsistema responsável pela gestão física dos estoques, que deve garantir a guarda, a preservação e a embalagem dos materiais (exceto produtos em processo), visando atender à produção e às entregas de fornecedores, é o:',
 'Almoxarifado / Armazenagem.',
 'Controle de Estoque.',
 'Padronização e Normalização.',
 'Cadastro de Fornecedores.',
 'Inspeção de Suprimentos.',
 'A',
 'A alternativa A está correta: o Almoxarifado/Armazenagem é o subsistema responsável pela gestão física dos estoques, garantindo guarda, preservação e embalagem dos materiais (exceto os produtos em processo), para atender à produção e às entregas de fornecedores. A alternativa B (Controle de Estoque) cuida do aspecto quantitativo/financeiro, não da gestão física direta. A alternativa C (Padronização e Normalização) trata da redução de variedades, não da guarda física. A alternativa D (Cadastro de Fornecedores) é atividade de apoio às compras. A alternativa E (Inspeção de Suprimentos) verifica o cumprimento de normas, não a guarda dos materiais.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao definir as atribuições do subsistema de Almoxarifado/Armazenagem. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q09: Subsistema de Cadastro
(@cat_gm12,
 'O subsistema de Cadastro desempenha funções de apoio essenciais ao fluxo de suprimentos. Dentre suas atribuições específicas, destaca-se:',
 'A verificação qualitativa dos atributos físicos dos materiais entregues.',
 'A execução da política de transporte e distribuição da frota de veículos.',
 'A pesquisa de mercado e o cadastramento de fornecedores para subsidiar o processo de compras.',
 'A unificação de variedades de materiais para reduzir o volume total de itens estocados.',
 'O controle econômico do nível de investimento financeiro em estoque.',
 'C',
 'A alternativa C está correta: o subsistema de Cadastro é responsável pela pesquisa de mercado e pelo cadastramento de fornecedores, subsidiando o processo de compras com informações qualificadas. A alternativa A descreve a Inspeção de Recebimento. A alternativa B descreve o Transporte de Material. A alternativa D descreve a Padronização e Normalização. A alternativa E descreve o Controle de Estoque, todas atribuições de subsistemas distintos do Cadastro.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao atribuir a pesquisa de mercado e o cadastramento de fornecedores ao subsistema de Cadastro. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q10: Subsistema de Padronização e Normalização
(@cat_gm12,
 'Visando reduzir a complexidade do inventário, um gestor decide diminuir a variedade de tipos de lâmpadas utilizadas na empresa, unificando as especificações técnicas. Essa medida de redução de estoques por meio da unificação é competência do subsistema de:',
 'Movimentação de Material.',
 'Transporte de Material.',
 'Padronização e Normalização.',
 'Inspeção de Recebimento.',
 'Controle de Estoque.',
 'C',
 'A alternativa C está correta: a redução da variedade de itens estocados por meio da unificação de especificações técnicas é competência do subsistema de Padronização e Normalização. As alternativas A e B tratam de deslocamento físico dos materiais, sem relação com a unificação de especificações. A alternativa D refere-se à verificação de materiais recebidos, e a alternativa E ao controle quantitativo/financeiro do estoque — nenhuma delas trata da unificação de itens.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao atribuir a redução de variedades por unificação ao subsistema de Padronização e Normalização. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q11: Subsistema de Inspeção de Suprimentos
(@cat_gm12,
 'Analise a seguinte situação: Uma auditoria interna verifica se os procedimentos de requisição de materiais estão sendo seguidos por todos os departamentos da empresa, analisando desvios em relação à política de suprimento traçada. Essa atividade de verificação normativa é responsabilidade do subsistema de:',
 'Inspeção de Suprimentos.',
 'Inspeção de Recebimento.',
 'Cadastro de Fornecedores.',
 'Almoxarifado Central.',
 'Classificação de Material.',
 'A',
 'A alternativa A está correta: a verificação do cumprimento dos procedimentos e da política de suprimento em toda a organização é atribuição do subsistema de Inspeção de Suprimentos, de natureza normativa e fiscalizatória. A alternativa B (Inspeção de Recebimento) limita-se à conferência física e documental dos materiais entregues por fornecedores. A alternativa C (Cadastro de Fornecedores) é atividade de apoio às compras. A alternativa D (Almoxarifado Central) cuida da guarda física. A alternativa E (Classificação de Material) trata da identificação e codificação, não da auditoria de procedimentos.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao atribuir a verificação normativa dos procedimentos de suprimento ao subsistema de Inspeção de Suprimentos. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q12: Subsistema de Inspeção de Recebimento
(@cat_gm12,
 'Em um fluxo integrado, após a entrega do material pelo fornecedor, o Almoxarifado recebe os volumes. Para que os itens sejam formalmente aceitos e encaminhados para a guarda, qual subsistema deve ser obrigatoriamente acionado para realizar a verificação física e documental?',
 'Controle de Estoque.',
 'Aquisição.',
 'Inspeção de Recebimento.',
 'Padronização.',
 'Transporte.',
 'C',
 'A alternativa C está correta: após a entrega do material pelo fornecedor, a Inspeção de Recebimento deve ser acionada para realizar a verificação física e documental que autoriza a aceitação formal e o encaminhamento à guarda no Almoxarifado. A alternativa A (Controle de Estoque) atua após a formalização da entrada. A alternativa B (Aquisição) já concluiu sua atuação com a emissão do pedido. As alternativas D e E (Padronização e Transporte) não têm relação com a verificação de aceite do material recebido.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao atribuir a verificação física e documental do material recebido ao subsistema de Inspeção de Recebimento. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q13: Objetivo — Giro de Estoques
(@cat_gm12,
 'Um Diretor Financeiro questiona o Gestor de Materiais sobre a necessidade de aumentar o "Giro de Estoques". O gestor justifica que o alcance deste objetivo é prioritário porque:',
 'Permite que os materiais fiquem mais tempo parados, aumentando seu valor contábil.',
 'Proporciona uma melhor utilização do capital de giro, elevando o retorno sobre os investimentos.',
 'Garante que a empresa compre sempre em grandes lotes, independentemente da demanda.',
 'Elimina a necessidade de manter relações favoráveis com fornecedores externos.',
 'Reduz a frequência de pedidos, diminuindo a carga de trabalho do setor de cadastro.',
 'B',
 'A alternativa B está correta: o aumento do Giro de Estoques proporciona melhor utilização do capital de giro, elevando o retorno sobre os investimentos, pois o capital fica menos tempo imobilizado em materiais parados. A alternativa A contraria o próprio conceito de giro, que busca reduzir, não aumentar, o tempo de permanência dos itens em estoque. A alternativa C confunde giro elevado com compras em grandes lotes, que na verdade tendem a reduzir o giro. As alternativas D e E ignoram que boas relações com fornecedores e a frequência adequada de pedidos são compatíveis com — e não eliminadas por — um giro de estoques saudável.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre o objetivo de maximização do Giro de Estoques e sua relação com o capital de giro. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q14: Objetivo — Relações favoráveis com fornecedores
(@cat_gm12,
 'Durante uma crise de abastecimento global, uma empresa consegue manter sua produção sem interrupções por possuir prioridade de entrega junto aos seus parceiros comerciais. Essa situação exemplifica o alcance de qual objetivo da Administração de Materiais?',
 'Aperfeiçoamento de pessoal técnico.',
 'Relações favoráveis com fornecedores.',
 'Manutenção de estoques mortos para segurança.',
 'Redução de custos administrativos fixos.',
 'Automatização do sistema de classificação.',
 'B',
 'A alternativa B está correta: a manutenção da produção sem interrupções, por meio de prioridade de entrega junto a parceiros comerciais, exemplifica o objetivo de relações favoráveis com fornecedores, um dos objetivos clássicos da Administração de Materiais. As demais alternativas (aperfeiçoamento de pessoal, estoques mortos, redução de custos fixos, automatização de classificação) descrevem outros objetivos ou práticas da área, mas não correspondem ao benefício relatado no cenário, que decorre diretamente do relacionamento privilegiado com fornecedores.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao listar as relações favoráveis com fornecedores entre os objetivos da área. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q15: Terminologia — Estoque Ativo ou Normal
(@cat_gm12,
 'Um almoxarife observa que o item "Papel A4" apresenta constantes entradas e saídas, com o saldo físico variando diariamente conforme o consumo das unidades funcionais. De acordo com a terminologia técnica, esse tipo de estoque é classificado como:',
 'Estoque Morto.',
 'Estoque Inativo.',
 'Estoque Ativo ou Normal.',
 'Estoque de Recuperação.',
 'Estoque de Excedentes.',
 'C',
 'A alternativa C está correta: o estoque que sofre entradas e saídas constantes, com saldo variando conforme o consumo, é tecnicamente classificado como Estoque Ativo ou Normal. A alternativa A (Estoque Morto) refere-se a itens sem movimentação e sem previsão de uso. A alternativa B (Estoque Inativo) refere-se a itens de baixa ou nenhuma movimentação recente. A alternativa D (Estoque de Recuperação) refere-se a materiais recuperáveis para reaproveitamento. A alternativa E (Estoque de Excedentes) refere-se a quantidades além da necessidade normal — nenhuma delas descreve a movimentação regular do papel A4 do cenário.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na terminologia técnica de classificação de estoques (Ativo/Normal, Morto, Inativo, Recuperação, Excedente). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q16: Terminologia — Estoque Disponível x Empenhado
(@cat_gm12,
 'Um relatório de sistema indica que há 100 unidades de um rolamento no armazém. No entanto, 30 unidades já foram reservadas para uma manutenção programada que ocorrerá amanhã. Ao ser consultado sobre a quantidade "Livre para Uso" por outro departamento, o gestor deve informar o valor referente ao:',
 'Estoque Teórico.',
 'Estoque Disponível.',
 'Estoque Empenhado.',
 'Estoque de Segurança.',
 'Estoque Máximo.',
 'B',
 'A alternativa B está correta: o Estoque Disponível é a quantidade efetivamente livre para uso por outros setores, descontadas as reservas já comprometidas — no caso, 70 unidades (100 em saldo menos 30 já reservadas). A alternativa A (Estoque Teórico) somaria também as quantidades já compradas e aguardando entrega, dado inexistente no cenário. A alternativa C (Estoque Empenhado) refere-se justamente à parcela reservada, e não à parcela livre. A alternativa D (Estoque de Segurança) é um parâmetro de planejamento, não o saldo livre para uso imediato. A alternativa E (Estoque Máximo) é o teto de armazenagem definido pela política de estoques, não o saldo disponível no momento.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na distinção entre Estoque Disponível e Estoque Empenhado. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q17: Terminologia — Estoque Teórico (cálculo)
(@cat_gm12,
 'Ao analisar a situação de um item, o gestor observa os seguintes dados: saldo disponível no almoxarifado de 50 unidades e quantidade já comprada, com pedido emitido e aguardando entrega, de 30 unidades. Qual é o valor do "Estoque Teórico" para este item?',
 '20 unidades.',
 '30 unidades.',
 '50 unidades.',
 '80 unidades.',
 '15 unidades.',
 'D',
 'A alternativa D está correta: o Estoque Teórico corresponde à soma do saldo disponível no almoxarifado com a quantidade já comprada e aguardando entrega — no cenário, 50 unidades disponíveis mais 30 unidades já pedidas totalizam 80 unidades. As demais alternativas apresentam valores que consideram apenas uma das duas parcelas (disponível ou pedido) isoladamente, ou somas incorretas, desconsiderando que o Estoque Teórico reflete a disponibilidade projetada, e não apenas o saldo físico presente.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, no cálculo do Estoque Teórico (saldo disponível + quantidade já comprada em trânsito). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'dificil'),

-- Q18: Terminologia — Ponto de Chamada de Emergência
(@cat_gm12,
 'Uma organização define que o "Estoque Mínimo" de um item de segurança é de 100 unidades para prevenir atrasos de entrega. O sistema emite um alerta crítico quando o nível atinge 50 unidades, exigindo medidas especiais para evitar a interrupção total. Esse nível de alerta crítico (metade do estoque mínimo) é tecnicamente chamado de:',
 'Ponto de Pedido.',
 'Limite de Chamada.',
 'Ponto de Chamada de Emergência.',
 'Ruptura de Estoque.',
 'Tempo de Tramitação Interna.',
 'C',
 'A alternativa C está correta: o nível de alerta correspondente à metade do Estoque Mínimo, que exige medidas especiais para evitar a interrupção total do suprimento, é tecnicamente denominado Ponto de Chamada de Emergência. A alternativa A (Ponto de Pedido) refere-se ao nível que dispara a reposição em condições normais, calculado de outra forma. A alternativa B (Limite de Chamada) não corresponde à terminologia técnica adotada. A alternativa D (Ruptura de Estoque) ocorre apenas quando o saldo chega a zero, situação mais grave que o alerta relatado. A alternativa E (Tempo de Tramitação Interna) refere-se a prazo, não a nível de estoque.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na terminologia técnica de níveis de alerta de estoque (Ponto de Chamada de Emergência). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'dificil'),

-- Q19: Terminologia — Tempo de Reposição ou Ressuprimento
(@cat_gm12,
 'O setor de planejamento emitiu uma requisição de compra no dia 01/03. O setor de compras formalizou o pedido com o fornecedor no dia 05/03. O material foi efetivamente entregue no dia 15/03. O intervalo total de 15 dias (do dia 01 ao dia 15) representa o:',
 'Prazo de Entrega.',
 'Tempo de Tramitação Interna.',
 'Tempo de Reposição ou Ressuprimento.',
 'Frequência de Consumo.',
 'Ponto de Ressuprimento.',
 'C',
 'A alternativa C está correta: o intervalo entre a emissão da requisição de compra e a efetiva entrega do material — abrangendo a tramitação interna, a formalização do pedido e o prazo do fornecedor — é denominado Tempo de Reposição ou Ressuprimento. A alternativa A (Prazo de Entrega) refere-se apenas à etapa entre a formalização do pedido e a entrega, sem incluir a tramitação interna. A alternativa B (Tempo de Tramitação Interna) corresponde apenas à primeira etapa do processo. A alternativa D (Frequência de Consumo) refere-se ao ritmo de saída do item, não ao ciclo de reposição. A alternativa E (Ponto de Ressuprimento) é o nível de estoque que dispara o pedido, não o intervalo de tempo.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na definição do Tempo de Reposição ou Ressuprimento e de suas etapas componentes. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q20: Terminologia — Ruptura de Estoque
(@cat_gm12,
 'Considere um cenário onde o estoque de um componente eletrônico essencial chegou a zero (E = 0). Diversas ordens de produção continuam chegando, mas não podem ser atendidas por falta do item. Essa situação caracteriza a:',
 'Ruptura de Estoque.',
 'Maximização de Giro.',
 'Regularização de Estoque Morto.',
 'Estagnação de Estoque Ativo.',
 'Sinergia Operacional.',
 'A',
 'A alternativa A está correta: a situação em que o saldo de estoque chega a zero (E = 0) e a demanda continua sem poder ser atendida caracteriza a Ruptura de Estoque. A alternativa B (Maximização de Giro) refere-se a um objetivo positivo de gestão, incompatível com a falta de material. A alternativa C (Regularização de Estoque Morto) trata de itens parados, não de itens em falta. A alternativa D (Estagnação de Estoque Ativo) descreveria ausência de movimentação, o oposto da demanda contínua relatada. A alternativa E (Sinergia Operacional) refere-se ao efeito multiplicador da integração de fatores, sem relação com a ausência de material.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na definição técnica de Ruptura de Estoque. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q21: Fluxo de compras — Requisição de Compra
(@cat_gm12,
 'O fluxo de compras em uma repartição pública deve ser iniciado formalmente para que o mercado possa ser consultado. Qual é o documento interno que desencadeia obrigatoriamente esse processo de aquisição?',
 'Mapa Comparativo de Preços.',
 'Proposta de Fornecimento.',
 'Requisição ou Pedido de Compra.',
 'Nota Fiscal de Entrada.',
 'Coleta de Preços.',
 'C',
 'A alternativa C está correta: a Requisição ou Pedido de Compra é o documento interno que formaliza a necessidade do material e desencadeia obrigatoriamente o processo de aquisição, permitindo a consulta ao mercado. A alternativa A (Mapa Comparativo de Preços) é elaborado após a coleta de orçamentos, em etapa posterior. A alternativa B (Proposta de Fornecimento) é documento externo, emitido pelo fornecedor. A alternativa D (Nota Fiscal de Entrada) surge apenas no recebimento do material. A alternativa E (Coleta de Preços) é atividade decorrente da requisição, e não o documento que a origina.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao definir a Requisição de Compra como documento interno deflagrador do processo de aquisição. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q22: Fluxo de compras — Mapa Comparativo de Preços
(@cat_gm12,
 'Após receber três orçamentos de diferentes fornecedores, o setor de compras consolida os valores, prazos e condições de pagamento em um único documento para decidir qual proposta é a mais viável para a organização. Esse documento é o:',
 'Contrato Bilateral.',
 'Mapa Comparativo de Preços.',
 'Ordem de Fornecimento.',
 'Dossiê de Cadastro.',
 'Pedido de Compra.',
 'B',
 'A alternativa B está correta: o documento que consolida valores, prazos e condições de pagamento de diferentes fornecedores para subsidiar a decisão de compra é o Mapa Comparativo de Preços. A alternativa A (Contrato Bilateral) só é firmado após a escolha do fornecedor. A alternativa C (Ordem de Fornecimento) formaliza a compra já decidida. A alternativa D (Dossiê de Cadastro) refere-se ao cadastramento do fornecedor, não à comparação de propostas. A alternativa E (Pedido de Compra) é o documento que origina o processo, anterior à comparação de orçamentos.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, ao definir o Mapa Comparativo de Preços como instrumento de decisão de compra. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q23: Custos logísticos — Custos Fixos
(@cat_gm12,
 'Na análise da estrutura de custos de um almoxarifado, as despesas com a folha de pagamento dos funcionários administrativos e os gastos com a manutenção predial, que não se alteram em função do volume de itens estocados ou da quantidade de pedidos, são classificados como:',
 'Custos Variáveis.',
 'Custos de Posse.',
 'Custos Fixos.',
 'Custos de Aquisição.',
 'Custos de Obtenção.',
 'C',
 'A alternativa C está correta: despesas como folha de pagamento administrativa e manutenção predial, que não variam em função do volume de itens estocados ou da quantidade de pedidos, são classificadas como Custos Fixos. A alternativa A (Custos Variáveis) descreve justamente o oposto, custos que se alteram com o volume de operações. As alternativas B, D e E (Custos de Posse, de Aquisição e de Obtenção) referem-se a categorias específicas de custos logísticos que variam conforme o estoque ou o número de pedidos, não correspondendo às despesas fixas relatadas.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na classificação de Custos Fixos na estrutura de custos do almoxarifado. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q24: Custos logísticos — Custo de Posse
(@cat_gm12,
 'O "Custo de Posse" (ou Manutenção de Estoque) é uma variável crítica na gestão financeira. Sobre ele, é correto afirmar que:',
 'Independe totalmente da quantidade de material guardada no almoxarifado.',
 'Refere-se exclusivamente às despesas de processamento de papéis no setor de compras.',
 'Decorre da existência do item em estoque e varia conforme o volume ou a quantidade armazenada.',
 'É um custo que diminui à medida que o tempo de permanência do item no estoque aumenta.',
 'Engloba apenas o preço de fatura pago ao fornecedor pelo material.',
 'C',
 'A alternativa C está correta: o Custo de Posse (ou Manutenção de Estoque) decorre da própria existência do item em estoque e varia conforme o volume ou a quantidade armazenada — quanto mais material parado, maior o custo de posse. A alternativa A contraria essa relação direta com o volume. A alternativa B confunde Custo de Posse com Custo de Aquisição (despesas de processamento de compras). A alternativa D inverte a lógica, pois o custo de posse tende a aumentar, não diminuir, com o tempo de permanência do item em estoque. A alternativa E descreve apenas o preço de fatura, um componente distinto do custo de manutenção.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na caracterização do Custo de Posse (ou Manutenção de Estoque). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q25: Custos logísticos — Custo de Aquisição
(@cat_gm12,
 'O "Custo de Aquisição" (ou de Obtenção) é composto pela somatória de todas as despesas realizadas para o processamento de uma compra. Esse custo possui como característica:',
 'Variar em função da depreciação física do material estocado.',
 'Variar em função do número de pedidos emitidos ou das quantidades compradas.',
 'Ser composto principalmente pelo valor do aluguel do espaço físico do armazém.',
 'Ser um custo fixo que não sofre influência da frequência de reposição.',
 'Representar o valor do capital imobilizado em itens obsoletos.',
 'B',
 'A alternativa B está correta: o Custo de Aquisição (ou de Obtenção) varia em função do número de pedidos emitidos ou das quantidades compradas, pois reúne as despesas de processamento de cada compra. A alternativa A confunde esse custo com a depreciação do material já estocado. A alternativa C atribui a ele um componente típico do Custo de Posse (aluguel do armazém). A alternativa D contraria sua natureza variável, tratando-o incorretamente como fixo. A alternativa E descreve o capital imobilizado em itens obsoletos, tema distinto do custo de processar uma compra.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, na caracterização do Custo de Aquisição (ou de Obtenção). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q26: Custos logísticos — Custo Ideal (interseção de curvas)
(@cat_gm12,
 'O gestor de materiais busca o "Custo Ideal" para a operação de estocagem da empresa. Este ponto de equilíbrio é atingido quando:',
 'O custo de aquisição é reduzido a zero, eliminando os processos de compra.',
 'O custo de posse atinge seu valor máximo para garantir disponibilidade total.',
 'Ocorre a interseção das curvas dos custos de posse e de aquisição, resultando no menor custo total.',
 'A empresa decide comprar todo o suprimento anual em um único lote para eliminar custos variáveis.',
 'O custo fixo é integrado ao preço de venda, ignorando os custos de manutenção.',
 'C',
 'A alternativa C está correta: o Custo Ideal de estocagem é atingido no ponto de interseção das curvas dos custos de posse e de aquisição, que representa o menor custo total para a organização — pois o custo de posse cresce com o volume estocado, enquanto o custo de aquisição decresce com lotes maiores (menos pedidos). A alternativa A elimina um dos dois custos, o que é inviável na prática. A alternativa B maximiza o custo de posse, o oposto do equilíbrio buscado. A alternativa D concentra a compra em um único lote, elevando o custo de posse ao extremo. A alternativa E ignora a necessidade de equilibrar, e não apenas repassar, os custos de manutenção.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre o ponto de equilíbrio (Custo Ideal) entre custo de posse e custo de aquisição. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'dificil'),

-- Q27: Funções do estoque — cobertura de riscos
(@cat_gm12,
 'A gestão de estoque lida com recursos ociosos que possuem valor econômico. Segundo o material didático, o investimento nesses recursos é estrategicamente equivalente a investimentos em máquinas e equipamentos porque:',
 'O capital imobilizado em estoque sempre rende mais que aplicações financeiras.',
 'Os estoques servem para cobrir fatores de risco em circunstâncias imprevisíveis, evitando prejuízos por falta de material ou paralisação de serviços.',
 'A manutenção de altos estoques é a única forma de garantir a liquidez imediata da empresa.',
 'Os estoques não privam a organização de investimentos em outras áreas mais rentáveis.',
 'A gestão de estoque visa manter o nível de investimento o mais distante possível do nível econômico ótimo.',
 'B',
 'A alternativa B está correta: o investimento em estoques é estrategicamente equiparado ao investimento em máquinas e equipamentos porque os estoques cobrem fatores de risco em circunstâncias imprevisíveis, evitando prejuízos decorrentes da falta de material ou da paralisação de serviços e da produção. A alternativa A superestima o retorno do capital imobilizado em estoque, o que não é garantido. A alternativa C exagera o papel do estoque na liquidez, que depende de outros fatores financeiros. A alternativa D ignora o custo de oportunidade real de manter capital imobilizado em estoque. A alternativa E contraria o objetivo da gestão de estoques, que busca aproximar, e não afastar, o investimento do nível econômico ótimo.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre a função do estoque como cobertura de riscos e sua equivalência estratégica a outros investimentos produtivos. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q28: Funções do estoque — função amortecedora
(@cat_gm12,
 'Os estoques são frequentemente descritos como "amortecedores" entre as etapas de compra, produção e venda. Essa função de amortecimento tem como finalidade principal:',
 'Aumentar a interdependência entre as partes da organização, forçando a comunicação constante.',
 'Maximizar os efeitos das oscilações de oferta e procura sobre o processo produtivo.',
 'Minimizar os efeitos de erros de planejamento e oscilações inesperadas de mercado, isolando as partes da organização.',
 'Garantir que a empresa opere sem a necessidade de uma área financeira ou de contabilidade.',
 'Substituir a necessidade de inspeção qualitativa no recebimento de materiais.',
 'C',
 'A alternativa C está correta: a função de amortecimento dos estoques tem como finalidade minimizar os efeitos de erros de planejamento e de oscilações inesperadas de mercado, isolando as etapas de compra, produção e venda entre si. A alternativa A propõe o oposto, aumentar a interdependência, o que contraria a lógica de isolamento amortecedor. A alternativa B maximiza, em vez de minimizar, os efeitos das oscilações, invertendo a finalidade da função. As alternativas D e E atribuem aos estoques funções que não lhe são próprias, como substituir a área financeira ou a inspeção qualitativa.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre a função "amortecedora" dos estoques entre compra, produção e venda. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio'),

-- Q29: Controle de Estoques — decisão de "quanto" comprar
(@cat_gm12,
 'O setor de Controle de Estoques possui funções específicas para garantir o equilíbrio do sistema. Dentre as decisões sob sua responsabilidade, a determinação de "QUANTO" comprar baseia-se em:',
 'Comprar sempre a quantidade mínima possível para manter o almoxarifado vazio.',
 'Definir a quantidade necessária para suprir a organização por um período predeterminado.',
 'Seguir as tendências estéticas de acondicionamento das embalagens.',
 'Adquirir quantidades aleatórias para testar a capacidade de armazenamento.',
 'Atender exclusivamente aos desejos de vendas de fornecedores externos não cadastrados.',
 'B',
 'A alternativa B está correta: a decisão sobre "quanto" comprar, no âmbito do Controle de Estoques, baseia-se na definição da quantidade necessária para suprir a organização por um período predeterminado, conciliando disponibilidade e economicidade. A alternativa A propõe manter o almoxarifado vazio, o que geraria rupturas constantes. A alternativa C confunde critério técnico de quantidade com estética de embalagem. A alternativa D propõe aleatoriedade, incompatível com o planejamento técnico do controle de estoques. A alternativa E subordina a decisão de compra a interesses externos de venda, e não às necessidades reais da organização.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre as decisões técnicas ("quanto", "quando" e "onde" comprar) do subsistema de Controle de Estoques. Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'facil'),

-- Q30: Tempo de Reposição — três etapas componentes
(@cat_gm12,
 'Para que o sistema de estoques seja realista, o "Tempo de Reposição" deve ser calculado considerando três etapas fundamentais. Assinale a alternativa que descreve corretamente esses componentes:',
 'Pesquisa de preços, faturamento bancário e assistência técnica.',
 'Planejamento de vendas, controle de produção e contabilidade fiscal.',
 'Emissão do pedido, preparação do pedido pelo fornecedor e transporte.',
 'Recebimento físico, inspeção qualitativa e baixa contábil.',
 'Catalogação de material, inventário rotativo e alienação de sucatas.',
 'C',
 'A alternativa C está correta: o Tempo de Reposição, para ser calculado de forma realista, deve considerar três etapas fundamentais: a emissão do pedido, a preparação do pedido pelo fornecedor e o transporte até o destino. A alternativa A mistura etapas de pesquisa de preços e assistência técnica, alheias ao cálculo do tempo de reposição. A alternativa B refere-se a atividades de vendas, produção e contabilidade, sem relação direta com o ciclo de ressuprimento. A alternativa D descreve etapas do recebimento do material, posteriores à entrega, e não componentes do tempo de reposição. A alternativa E refere-se a atividades de cadastro, inventário e alienação, distintas do ciclo de reposição.\n\n📜 Fundamento legal vigente: doutrina de Administração de Materiais e Logística Empresarial, sobre os componentes técnicos do Tempo de Reposição (emissão, preparação e transporte do pedido). Não há lei pública numerada correspondente.',
 'Doutrina de Administração de Materiais',
 'medio');

SET foreign_key_checks = 1;
