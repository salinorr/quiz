-- ============================================================
-- QUIZ PMRR - Banco de Questões
-- Legislações: EFM (Portaria 1717/2023), Redes Sociais (Portaria 685/2024),
--              Estatuto dos Militares RR (LC 194/2012)
-- ============================================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE DATABASE IF NOT EXISTS quiz_pmrr CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quiz_pmrr;

-- ============================================================
-- TABELA: sessões de usuários
-- ============================================================
CREATE TABLE IF NOT EXISTS sessoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    total_acertos INT DEFAULT 0,
    total_erros INT DEFAULT 0,
    total_respondidas INT DEFAULT 0,
    iniciado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    finalizado_em DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABELA: categorias
-- ============================================================
CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categorias (nome, descricao) VALUES
('Exame de Aptidão Física (EFM)', 'Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, de 13 de novembro de 2023'),
('Redes Sociais e Aplicativos de Mensagens', 'Portaria Nº 685/PMRR/QCG/DCS/DCS, de 26 de abril de 2024'),
('Estatuto dos Militares Estaduais de Roraima', 'Lei Complementar nº 194, de 13 de fevereiro de 2012');

-- ============================================================
-- TABELA: questões
-- ============================================================
CREATE TABLE IF NOT EXISTS questoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT NOT NULL,
    enunciado TEXT NOT NULL,
    opcao_a TEXT NOT NULL,
    opcao_b TEXT NOT NULL,
    opcao_c TEXT NOT NULL,
    opcao_d TEXT NOT NULL,
    resposta_correta CHAR(1) NOT NULL COMMENT 'A, B, C ou D',
    explicacao TEXT NOT NULL,
    referencia_legal VARCHAR(300) DEFAULT NULL,
    nivel ENUM('facil','medio','dificil') DEFAULT 'medio',
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABELA: respostas do usuário
-- ============================================================
CREATE TABLE IF NOT EXISTS respostas_usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sessao_id INT NOT NULL,
    questao_id INT NOT NULL,
    resposta_dada CHAR(1) NOT NULL,
    acertou TINYINT(1) NOT NULL,
    respondido_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sessao_id) REFERENCES sessoes(id),
    FOREIGN KEY (questao_id) REFERENCES questoes(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- INSERÇÃO DAS QUESTÕES
-- ============================================================

-- ============================================================
-- CATEGORIA 1: EXAME DE APTIDÃO FÍSICA (EFM)
-- ============================================================

INSERT INTO questoes (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, resposta_correta, explicacao, referencia_legal, nivel) VALUES

(1, 'De acordo com a Portaria Nº 1717/2023, qual é a nota mínima para aprovação na avaliação de EFM nos cursos de Estágios e Especializações?',
'5,0 (cinco)',
'6,0 (seis)',
'7,0 (sete)',
'8,0 (oito)',
'C',
'O Art. 9º, §1º da Portaria 1717/2023 estabelece que o policial militar avaliado em Estágios e Cursos de Especialização na disciplina de EFM será considerado reprovado quando não atingir a pontuação mínima total geral resultante da média aritmética igual ou superior a 7,00 (sete). Esse critério também se aplica ao Curso de Operações Especiais, conforme §2º do mesmo artigo. Pontuações abaixo de 7,00 resultam em desligamento por insuficiência técnica.',
'Art. 9º, §1º e §2º - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'facil'),

(1, 'Quantas etapas consecutivas em dias distintos compõem o teste de esforço físico na avaliação de EFM?',
'1 (uma) etapa',
'2 (duas) etapas',
'3 (três) etapas',
'4 (quatro) etapas',
'B',
'O Art. 4º da Portaria 1717/2023 determina que a avaliação de Educação Física Militar dar-se-á mediante teste de esforço físico em 02 etapas consecutivas em dias distintos, constituído de exercícios que permitam aferir o condicionamento físico. Essa divisão garante que o policial não seja sobrecarregado em um único dia, permitindo uma avaliação mais justa e completa de suas capacidades físicas.',
'Art. 4º - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'facil'),

(1, 'Quais exercícios compõem o 1º Dia de Avaliação de EFM nos Cursos de Formação, Estágios e Especializações?',
'Flexão de Braço ao Solo e Corrida em 12 min',
'Flexão na Barra Fixa (ou Isometria), Abdominal Remador e Natação 25m',
'Natação 25m, Flexão de Braço e Corrida',
'Abdominal Remador, Corrida em 12 min e Natação',
'B',
'Conforme o Anexo A - Tabela I da Portaria 1717/2023, o 1º Dia de Exercícios é composto por: 1) Flexão de Barra Fixa (masculino) ou Isometria na Barra Fixa (feminino); 2) Flexão Abdominal Remador; e 3) Natação 25m. O 2º Dia é reservado para Flexão de Braço ao Solo e Corrida em 12 minutos. Essa divisão é obrigatória e deve ser seguida rigorosamente pelo instrutor.',
'Anexo A - Tabela I - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'Na avaliação de EFM, o policial militar que não atingir o índice previsto em algum exercício pode continuar realizando os demais?',
'Não, ele é imediatamente reprovado e dispensado da avaliação',
'Sim, pois o critério avaliativo apenas reprova quem não atingir a nota mínima final, podendo realizar os demais exercícios',
'Sim, mas apenas se o instrutor autorizar formalmente',
'Não, exceto se apresentar atestado médico no dia da avaliação',
'B',
'O Art. 9º da Portaria 1717/2023 é claro ao estabelecer que o policial militar que não atingir o índice previsto em qualquer dos exercícios propostos poderá executar o exercício subsequente, pois o critério avaliativo apenas reprova o candidato que não atingir a nota mínima exigida. Além disso, o avaliado ainda poderá ser submetido a exame de recuperação em data posterior, a ser definida pela Coordenação de Ensino Policial.',
'Art. 9º - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'Qual profissional deve obrigatoriamente estar presente durante a realização da avaliação de EFM?',
'Médico do trabalho da PMRR',
'Bombeiros militares ou socorristas do SAMU devidamente habilitados e equipados com viatura',
'Enfermeiro do batalhão de origem do policial',
'Psicólogo responsável pelo curso',
'B',
'O Art. 10 da Portaria 1717/2023 determina que o instrutor de EFM deverá solicitar junto à Coordenação de Ensino Policial a presença de profissionais habilitados (bombeiros militares ou socorristas do SAMU) devidamente habilitados e equipados com emprego de viatura para o pronto atendimento de urgência ou emergência no local da realização da avaliação. Essa medida visa garantir a segurança dos avaliados durante os exercícios de alta intensidade.',
'Art. 10 - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'Qual uniforme deve ser utilizado pelos policiais militares na realização dos exercícios físicos da avaliação de EFM?',
'Uniforme operacional padrão da PMRR',
'Uniforme 5ºA (Educação Física Militar)',
'Uniforme de academia civil de livre escolha',
'Qualquer uniforme esportivo aprovado pelo instrutor',
'B',
'Tanto o Art. 15 quanto o Anexo D da Portaria 1717/2023 determinam que os policiais militares deverão se apresentar utilizando o Uniforme 5ºA para a prática e execução dos exercícios, conforme previsto no Regulamento de Uniformes e Insígnias da Polícia Militar de Roraima. O policial que se apresentar com uniforme em desacordo será impedido de realizar a avaliação e será considerado reprovado.',
'Art. 15 e Anexo D - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'facil'),

(1, 'O policial militar que chegar atrasado para a avaliação de EFM, sem motivo justificável, será como considerado?',
'Aprovado condicionalmente, devendo refazer a prova em outra data',
'Reprovado na avaliação de EFM',
'Advertido disciplinarmente, mas poderá realizar a prova',
'Ausente justificado, podendo participar da próxima turma sem prejuízo',
'B',
'O Art. 16 da Portaria 1717/2023 é taxativo: sem prejuízo das sanções disciplinares cabíveis, será considerado reprovado na avaliação de EFM o policial militar que, sem motivo justificável, deixar de comparecer, chegar atrasado ou não realizar a avaliação na data prevista. Além disso, o Art. 15, inciso II, reforça que o policial que se apresentar após o horário previsto não poderá realizar o exame físico e será reprovado.',
'Art. 15 (II) e Art. 16 - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'facil'),

(1, 'No teste de Flexão de Braço na Barra Fixa (masculino), qual movimento é expressamente proibido?',
'Flexionar os cotovelos completamente',
'Realizar movimentos cíclicos de impulsão corporal como "pedaladas", "kipping" ou barra estilo "butterfly"',
'Manter o corpo na posição vertical',
'Receber ajuda para alcançar a posição inicial',
'B',
'O Anexo D, item 3.1.1, alínea "j", da Portaria 1717/2023 veda expressamente ao avaliado, durante a execução do teste de barra fixa, realizar movimentos cíclicos de impulsão corporal como "pedaladas" com as pernas, "kipping" ou barra estilo "butterfly". Esses movimentos são técnicas que utilizam o impulso do corpo para auxiliar na elevação, o que comprometeria a avaliação genuína da força dos membros superiores. O avaliado também não pode flexionar joelhos, cruzar os pés ou usar luvas.',
'Anexo D, item 3.1.1, alínea j - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'Na natação de 25m, em qual estilo de nado o exercício NÃO pode ser executado?',
'Estilo livre (crawl)',
'Estilo peito',
'Estilo costas',
'Estilo borboleta',
'C',
'O Anexo D, item 3.3.1, alínea "c", da Portaria 1717/2023 estabelece que deverá ser percorrida a distância de 25 metros, no estilo livre, não sendo permitida a execução de exercício no estilo "nado costas". O nado costas é o único estilo expressamente proibido. O avaliado pode optar por partir de dentro da piscina ou saltar de cima do bloco de saída, mas sempre em estilo livre.',
'Anexo D, item 3.3.1, alínea c - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'Quantos metros deve percorrer um policial militar masculino na faixa etária de 18-22 anos para obter nota 10,0 na corrida aeróbica de 12 minutos (Cursos de Formação)?',
'2.900m',
'3.000m',
'3.100m',
'3.200m',
'C',
'Conforme o Anexo B - Tabela V (Corrida Aeróbica Masculino - 12 minutos) da Portaria 1717/2023, para a faixa etária de 18-22 anos, a pontuação máxima de 10,0 é obtida com a distância de 3.100 metros. Para comparação, na mesma faixa etária no Curso de Operações Especiais (Anexo C), a nota 10,0 exige 3.200m, demonstrando que os requisitos para Operações Especiais são mais rigorosos.',
'Anexo B - Tabela V - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'dificil'),

(1, 'No exercício de Isometria na Barra Fixa Feminino (Cursos de Formação), qual o tempo mínimo para a faixa etária 18-22 anos obter nota 7,0?',
'18 segundos',
'19 segundos',
'20 segundos',
'21 segundos',
'd',
'Conforme o Anexo B - Tabela I (Sustentação Estática na Barra Fixa Feminino - Isométrica) da Portaria 1717/2023, para a faixa etária de 18-22 anos, a pontuação 7,0 exige 21 segundos de sustentação. Para nota 10,0 são necessários 24 segundos. Vale lembrar que a isometria é o exercício aplicado exclusivamente às policiais militares do sexo feminino em substituição à flexão de barra fixa masculina.',
'Anexo B - Tabela I - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'dificil'),

(1, 'Quem é responsável pela elaboração da ata de conclusão da avaliação de EFM com a devida tabela de notas?',
'O Coordenador de Ensino Policial exclusivamente',
'O Instrutor, juntamente com o respectivo monitor da disciplina',
'A banca avaliadora composta por três oficiais',
'O Comandante da unidade onde o policial está lotado',
'B',
'O Art. 6º, §1º da Portaria 1717/2023 determina expressamente que é de responsabilidade do Instrutor, juntamente com o respectivo monitor da disciplina, tanto a avaliação de EFM quanto a elaboração da ata de conclusão da avaliação com a devida tabela de notas avaliativas de cada exercício ao qual o policial militar foi submetido e o total geral. O Instrutor também é responsável por solicitar a presença de socorristas e garantir as condições de segurança.',
'Art. 6º, §1º - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'O policial militar pode ausentar-se ou abandonar o local de realização da avaliação de EFM sem autorização?',
'Sim, desde que tenha finalizado todos os exercícios da sua etapa',
'Não, sob pena do cometimento de transgressão disciplinar',
'Sim, em caso de mal-estar comprovado perante o instrutor',
'Não, mas pode solicitar autorização por escrito ao monitor',
'B',
'O Art. 11 da Portaria 1717/2023 é categórico: não será permitido ao policial militar ausentar-se ou abandonar o local de realização da avaliação sem autorização do instrutor, sob pena do cometimento de transgressão disciplinar à luz do código de ética dos militares do Estado de Roraima. A permanência no local é obrigatória, sendo permitida somente ao instrutor e aos policiais militares na condição de discentes (Art. 14, IV).',
'Art. 11 e Art. 14 (IV) - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'facil'),

(1, 'No exercício de Flexão de Braço ao Solo Feminino, qual a diferença em relação ao exercício masculino?',
'O feminino é realizado com limite de tempo de 30 segundos',
'O feminino utiliza 6 apoios (incluindo os joelhos), enquanto o masculino usa 4 apoios (pés)',
'O feminino tem pontuação menor independente do número de repetições',
'Não há diferença, ambos realizam o mesmo exercício',
'B',
'O Anexo D, itens 3.4.1 e 3.4.2, da Portaria 1717/2023 detalha as diferenças: o exercício masculino é realizado em 4 apoios (palmas das mãos + parte anterior dos pés), enquanto o feminino é em 6 apoios (palmas das mãos + joelhos + parte anterior dos pés). As tabelas de pontuação também são distintas, com índices específicos para cada sexo. Ambos os exercícios são realizados sem limite de tempo, permitindo pausa máxima de 5 segundos na posição inicial.',
'Anexo D, itens 3.4.1 e 3.4.2 - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(1, 'No Curso de Operações Especiais, quantas flexões na barra fixa são necessárias para um policial masculino de 28-32 anos obter nota 10,0?',
'10 repetições',
'12 repetições',
'14 repetições',
'16 repetições',
'B',
'Conforme o Anexo C - Tabela I (Flexão na Barra Fixa Masculino - Operações Especiais) da Portaria 1717/2023, para a faixa etária de 28-32 anos, a pontuação máxima de 10,0 é obtida com 12 repetições. Para comparação, nos Cursos de Formação/Estágios (Anexo B), a mesma faixa etária precisa de apenas 10 repetições para nota 10,0, demonstrando o nível mais elevado exigido para Operações Especiais.',
'Anexo C - Tabela I - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'dificil');

-- ============================================================
-- CATEGORIA 2: REDES SOCIAIS E APLICATIVOS DE MENSAGENS
-- ============================================================

INSERT INTO questoes (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, resposta_correta, explicacao, referencia_legal, nivel) VALUES

(2, 'A quais militares se aplica o Regulamento de Uso de Redes Sociais da PMRR (Portaria 685/2024)?',
'Apenas aos policiais militares da ativa',
'Apenas aos policiais militares da ativa e aos da reserva remunerada',
'Aos policiais militares da ativa e, no que couber, aos inativos e servidores públicos civis da instituição',
'Somente aos oficiais da ativa',
'C',
'O Art. 2º da Portaria 685/2024 estabelece que o presente regulamento aplica-se aos policiais militares da ativa e, no que couber, aos policiais militares inativos e servidores públicos civis da instituição. Portanto, o regulamento tem abrangência ampla, alcançando não apenas os militares em serviço ativo, mas também os inativos e o corpo de servidores civis que integram a instituição.',
'Art. 2º - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'facil'),

(2, 'Qual órgão da PMRR é responsável por autorizar a criação de novos Perfis Institucionais Específicos nas redes sociais?',
'Gabinete do Comando Geral',
'Departamento de Comunicação Social (DCS)',
'Coordenadoria de Inteligência',
'Estado-Maior da PMRR',
'B',
'O Art. 6º da Portaria 685/2024 estabelece que é permitida a criação de Perfis Institucionais Específicos das unidades policiais militares, mediante autorização do DCS. Além disso, o Art. 5º, §2º define as competências do DCS, que incluem: autorização para criação de novos Perfis Institucionais Específicos; regulação da linha editorial; produção de conteúdo do Perfil Geral; e elaboração de instruções complementares ao regulamento.',
'Art. 5º §2º e Art. 6º - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'facil'),

(2, 'É permitido ao policial militar criar e manter perfis pessoais em plataformas digitais ou aplicativos de mensagens?',
'Não, policiais militares não podem ter perfis pessoais em redes sociais',
'Sim, apenas em plataformas aprovadas previamente pelo DCS',
'Sim, desde que observada a ética profissional, o decoro da classe, os valores institucionais e os demais dispositivos normativos vigentes',
'Sim, mas apenas perfis privados sem qualquer identificação como policial militar',
'C',
'O Art. 17 da Portaria 685/2024 garante aos membros da PMRR a criação, utilização e manutenção de perfis pessoais em qualquer plataforma digital ou aplicativo de mensagens, desde que observado o que preceitua a ética profissional, o decoro da classe, os valores institucionais e os demais dispositivos normativos vigentes. Importante: o §1º deixa claro que a responsabilidade sobre o conteúdo dos perfis é de competência exclusiva do próprio usuário.',
'Art. 17 - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'facil'),

(2, 'É VEDADO aos membros da PMRR em perfis pessoais: qual das alternativas abaixo descreve uma conduta proibida?',
'Publicar imagens de formaturas e solenidades militares',
'Divulgar campanhas humanitárias e filantrópicas',
'Usar elemento de identidade visual da PMRR com opiniões políticas ou político-partidárias',
'Produzir e divulgar conhecimento acadêmico ou científico',
'C',
'O Art. 20, inciso I, alínea "c" da Portaria 685/2024 veda expressamente conteúdo que faça uso de elemento de identidade visual ou de uniforme da PMRR com opiniões políticas, inclusive político-partidárias ou ideológicas, exceto a divulgação autorizada de ações e projetos governamentais. Em contrapartida, o Art. 19 lista as condutas facultadas, incluindo divulgação de conteúdo institucional, imagens de solenidades, campanhas humanitárias, produção acadêmica e projetos governamentais autorizados.',
'Art. 19 e Art. 20 (I, alínea c) - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'Qual das alternativas abaixo descreve corretamente uma conduta PERMITIDA nos perfis pessoais dos membros da PMRR?',
'Publicar boletins de ocorrência (PPE, ROP) nos grupos de WhatsApp pessoais',
'Mostrar técnicas ou táticas policiais sigilosas para fins educativos',
'Divulgar imagens e vídeos sobre formaturas, casamentos e solenidades militares',
'Fazer críticas ao posicionamento institucional da PMRR usando fardamento',
'C',
'O Art. 19 da Portaria 685/2024 lista as condutas facultadas (permitidas) aos perfis pessoais dos membros da PMRR, incluindo: divulgação de conteúdo publicado nos perfis institucionais, imagens e vídeos sobre formaturas, casamentos e solenidades militares, campanhas humanitárias e filantrópicas, divulgação autorizada de ações governamentais e produção de conhecimento acadêmico. As demais alternativas representam violações expressas ao regulamento.',
'Art. 19 - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'Qual a consequência para o policial militar que publicar conteúdo com fins lucrativos usando a identidade visual da PMRR?',
'Advertência verbal pelo Comandante da Unidade',
'Poderá configurar improbidade administrativa, além de responsabilidades civis, penais e administrativas',
'Apenas suspensão temporária do uso das redes sociais',
'Desconto proporcional no subsídio do mês vigente',
'B',
'O Art. 17, §3º da Portaria 685/2024 estabelece que a publicidade de qualquer conteúdo com fins lucrativos, comerciais e a monetização de conteúdo com o uso da designação de posto, graduação, insígnias, brasões ou qualquer outro símbolo da identidade visual da PMRR poderá configurar improbidade administrativa, na forma da legislação vigente, sem prejuízo das responsabilidades civis, penais e administrativas. O Art. 25 complementa ao determinar as providências junto às plataformas e encaminhamento ao Ministério Público.',
'Art. 17 §3º e Art. 25 - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'Para participar de podcast ou congresso usando fardamento da PMRR ou abordando assuntos institucionais, o policial militar deve:',
'Solicitar autorização diretamente ao DCS, sem necessidade de comunicar a unidade',
'Realizar prévia comunicação ao Comando da sua unidade de lotação, que solicitará autorização ao Comando da PMRR',
'Aguardar convocação formal da Secretaria de Comunicação do Governo do Estado',
'Obter autorização individual de três oficiais superiores da sua unidade',
'B',
'O Art. 22 da Portaria 685/2024 determina que a participação de policial militar em congressos, seminários, podcasts ou similares, com uso de elemento da identidade visual ou fardamento institucional ou que verse sobre assunto relacionado à atividade policial, requer prévia comunicação ao Comando da sua unidade de lotação, e este deverá solicitar autorização do Comando da PMRR. O parágrafo único acrescenta que as entrevistas devem ser solicitadas pelos órgãos de comunicação à SECOM, exceto as espontâneas.',
'Art. 22 - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'Qual dos seguintes conteúdos é VEDADO nos Perfis Institucionais da PMRR?',
'Divulgação de ações de segurança pública de interesse da comunidade',
'Campanhas de conscientização sobre segurança no trânsito',
'Vídeos, fotos ou memes de conduzidos às delegacias, mesmo com imagens distorcidas ou com emojis',
'Informações sobre programas sociais do Governo do Estado',
'C',
'O Art. 11, inciso VII da Portaria 685/2024 veda expressamente nos perfis institucionais da PMRR a publicação de vídeos, fotos, lives, figurinhas e memes de conduzidos às delegacias e hospitais, presos em flagrantes, de pessoas envolvidas em ocorrências policiais, mesmo que as imagens estejam distorcidas, com efeitos, com emojis ou até mesmo de costas. Essa vedação é absoluta e não admite exceções, protegendo os direitos fundamentais das pessoas envolvidas.',
'Art. 11 (VII) - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'Quem pode determinar a suspensão ou bloqueio de um Perfil Institucional Específico da PMRR?',
'O próprio Comandante da unidade responsável pelo perfil',
'O DCS, com prévia aprovação do Comandante-Geral da PMRR',
'O Estado-Maior, por resolução da maioria de seus membros',
'A Secretaria de Segurança Pública do Estado de Roraima',
'B',
'O Art. 15 da Portaria 685/2024 estabelece que o Departamento de Comunicação Social (DCS) poderá determinar, com prévia aprovação do Comandante-Geral da PMRR, a suspensão ou bloqueio de qualquer dos perfis institucionais específicos. Os casos que podem motivar essa medida incluem: descumprimento do regulamento, necessidades estratégicas, períodos especiais previstos em lei, fatos que atentem contra valores institucionais, inobservância da linha editorial e determinação governamental.',
'Art. 15 - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'É vedado ao policial militar dedicar-se à produção de conteúdo pessoal durante o horário de trabalho?',
'Não, desde que o conteúdo não envolva a identidade visual da PMRR',
'Sim, salvo em confraternizações, eventos e situações extraordinárias que acontecem no horário de serviço',
'Sim, sem exceção alguma',
'Não, pois a vida privada do militar é protegida mesmo durante o serviço',
'B',
'O Art. 21, inciso II da Portaria 685/2024 veda ao policial militar dedicar-se à produção ou edição de conteúdo de ordem pessoal durante o seu horário de trabalho, com a ressalva de confraternizações, eventos e situações extraordinárias que acontecem no horário de serviço. O inciso III complementa ao proibir também mostrar-se desatento ao serviço em razão do uso de plataformas digitais, reforçando a prioridade do dever funcional sobre o uso das redes.',
'Art. 21 (II e III) - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'facil'),

(2, 'Qual medida deve ser adotada antes da exclusão de um comentário irregular em um Perfil Institucional da PMRR?',
'Comunicar imediatamente ao DCS para que este tome a providência',
'Notificar formalmente o usuário por e-mail institucional',
'Realizar registro do comentário por meio de "print" ou outro meio fidedigno, constando data, hora e identificação do usuário',
'Aguardar 48 horas para que o próprio usuário remova o comentário',
'C',
'O Art. 14, §1º da Portaria 685/2024 determina que, antes da exclusão, deverá ser realizado o registro dos comentários e das mensagens irregulares, por meio de "print" ou outro meio de registro fidedigno, devendo constar no registro a data, a hora, a identificação do usuário e do responsável pela administração do perfil institucional. Essa medida é essencial para eventual responsabilização judicial ou disciplinar do usuário infrator.',
'Art. 14 §1º - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'A comunicação nos grupos de aplicativos mensageiros institucionais da PMRR deve:',
'Ser livre, sem restrições, desde que trate de assuntos de segurança pública',
'Obedecer aos princípios basilares da vida castrense, resguardando hierarquia e disciplina',
'Ser autorizada previamente pelo Comandante para cada mensagem enviada',
'Ser restrita a informações operacionais, sendo vetada qualquer informalidade',
'B',
'O Art. 16 da Portaria 685/2024 estabelece que a comunicação institucional entre comandantes, pares e subordinados, por meio de grupos de aplicativos mensageiros, deverá obedecer aos princípios basilares da vida castrense. O §1º complementa que a comunicação nos grupos deve ser institucional, resguardando a hierarquia e disciplina, formas cordiais de tratamento entre pares, subordinados e superiores. O §2º veda o envio de informações e discussões de assuntos de natureza diversa à finalidade de cada grupo.',
'Art. 16 - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'medio'),

(2, 'O descumprimento do Regulamento de Uso de Redes Sociais deve ser apurado mediante qual instrumento?',
'Sindicância administrativa simplificada',
'Termo Circunstanciado de Ocorrência',
'Relatório de Investigação Preliminar, procedimento administrativo ou inquérito policial militar (IPM), conforme o caso',
'Processo administrativo disciplinar ordinário exclusivamente',
'C',
'O Art. 24, §1º da Portaria 685/2024 estabelece que o descumprimento do regulamento deverá ser apurado mediante Relatório de Investigação Preliminar, procedimento administrativo ou inquérito policial militar (IPM), conforme o caso. O §2º acrescenta que quando apurada a configuração de crime ou improbidade administrativa, os autos deverão ser encaminhados ao Ministério Público, demonstrando que as consequências do descumprimento podem ultrapassar a esfera disciplinar.',
'Art. 24 §§1º e 2º - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'dificil');

-- ============================================================
-- CATEGORIA 3: ESTATUTO DOS MILITARES ESTADUAIS DE RORAIMA
-- ============================================================

INSERT INTO questoes (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, resposta_correta, explicacao, referencia_legal, nivel) VALUES

(3, 'De acordo com a LC 194/2012, hierarquia e disciplina são os princípios que constituem a base institucional das corporações e devem ser mantidos em que circunstâncias?',
'Apenas durante o horário de serviço',
'Em todas as circunstâncias da vida militar, inclusive no meio digital',
'Somente dentro das dependências das unidades militares',
'Durante o horário de serviço e em eventos oficiais da corporação',
'B',
'O Art. 23, caput e §5º da LC 194/2012 estabelecem que a Hierarquia e a Disciplina são os princípios que constituem a base institucional das corporações e devem ser mantidas em todas as circunstâncias da vida militar. O §5º reforça que a disciplina e o respeito à hierarquia devem ser mantidos em todas as circunstâncias pelos militares em atividade ou na inatividade. A Portaria 685/2024 (redes sociais) reforça essa extensão ao meio digital.',
'Art. 23, caput e §5º - LC nº 194/2012',
'facil'),

(3, 'Qual é a altura mínima exigida para ingresso na carreira militar estadual, conforme a LC 194/2012?',
'1,65m para masculino e 1,60m para feminino',
'1,60m para masculino e 1,55m para feminino',
'1,70m para masculino e 1,60m para feminino',
'1,58m para masculino e 1,53m para feminino',
'B',
'O Art. 17, inciso V da LC 194/2012 (com redação da LC 219/2013) estabelece como requisito de ingresso ter no mínimo 1,60m (um metro e sessenta centímetros) de altura, se masculino, e 1,55m (um metro e cinquenta e cinco centímetros) de altura, se feminino. Esse é um dos requisitos eliminatórios do concurso público para ingresso nas corporações militares estaduais de Roraima.',
'Art. 17 (V) - LC nº 194/2012 (alterado pela LC 219/2013)',
'facil'),

(3, 'Quantas fases compõem o concurso público para ingresso na carreira militar estadual?',
'Duas fases',
'Três fases',
'Quatro fases',
'Cinco fases',
'C',
'O Art. 12 da LC 194/2012 estabelece que as fases do concurso público constituem-se em quatro etapas: I - provas intelectuais (caráter classificatório e eliminatório) e títulos; II - exames médicos, odontológicos, toxicológicos e de aptidão física (eliminatórios); III - Avaliação Psicológica por exame psicotécnico (eliminatório); e IV - investigação social (eliminatório). Todas as etapas têm caráter eliminatório, exceto a parte de títulos na primeira etapa.',
'Art. 12 - LC nº 194/2012',
'facil'),

(3, 'Qual é a idade máxima para ingresso na carreira militar estadual no cargo comum (exceto Quadro de Saúde e Capelão)?',
'30 anos',
'32 anos',
'35 anos',
'40 anos',
'C',
'O Art. 17, inciso IV da LC 194/2012 (com redação da LC 260/2017) estabelece como requisito de ingresso idade mínima de 18 (dezoito) anos e máxima de 35 (trinta e cinco) anos. A lei prevê exceções: para o Quadro de Saúde o máximo é 38 anos, e para o Quadro de Capelão Militar o máximo é 40 anos. Essas faixas etárias são verificadas na data prevista no edital do concurso.',
'Art. 17 (IV) - LC nº 194/2012 (alterado pela LC 260/2017)',
'facil'),

(3, 'O Curso de Formação ou de Habilitação do militar estadual constitui qual fase de sua carreira?',
'A fase de adaptação institucional',
'Uma fase do estágio probatório',
'O período de formação técnica obrigatória',
'A fase de comprovação de aptidão intelectual',
'B',
'O Art. 19 da LC 194/2012 estabelece expressamente que o Curso de Formação ou de Habilitação do militar estadual constitui uma fase do estágio probatório. Isso significa que o período de formação já é computado para fins de aquisição da estabilidade. O §1º complementa que, na hipótese do militar não obter aproveitamento no curso, ele será exonerado, devendo ser assegurado o direito ao contraditório e à ampla defesa em processo administrativo simplificado.',
'Art. 19 - LC nº 194/2012',
'medio'),

(3, 'Após quanto tempo de efetivo exercício o militar estadual adquire estabilidade no serviço público militar?',
'1 (um) ano',
'2 (dois) anos',
'3 (três) anos',
'5 (cinco) anos',
'C',
'O Art. 20 da LC 194/2012 estabelece que o militar do Estado de Roraima, aprovado em concurso público e empossado em cargo de provimento efetivo, adquirirá a estabilidade no serviço público militar estadual ao completar 3 (três) anos de efetivo exercício na instituição a que pertencer, mediante aprovação em avaliação de desempenho técnico profissional e conduta social civil ilibada. Para oficiais, a estabilidade é adquirida no ato da promoção ao primeiro posto.',
'Art. 20 - LC nº 194/2012',
'facil'),

(3, 'Durante o estágio probatório, em quantos períodos distintos o militar estadual é avaliado?',
'Um período, ao final dos 3 anos',
'Dois períodos: aos 18 meses e aos 30 meses de exercício',
'Três períodos: aos 12, 24 e 36 meses',
'Quatro períodos semestrais',
'B',
'O Art. 21, §3º da LC 194/2012 estabelece que durante o estágio probatório o militar estadual será avaliado em dois períodos distintos: I - a primeira avaliação aos dezoito meses de exercício; II - a segunda avaliação aos trinta meses de exercício. O §2º informa que o militar será avaliado por uma comissão constituída de três oficiais, sendo um o comandante da unidade a que pertence. O §4º garante o devido processo legal na fase de avaliação, com possibilidade de exoneração se reprovado.',
'Art. 21, §3º - LC nº 194/2012',
'medio'),

(3, 'Quais são as manifestações essenciais do valor militar previstas na LC 194/2012?',
'Obediência, pontualidade, disciplina e patriotismo',
'Sentimento de servir à comunidade, patriotismo, civismo, fé na missão, espírito de corpo, amor à profissão e aprimoramento técnico',
'Lealdade, honestidade, bravura, disciplina e hierarquia',
'Probidade, moralidade, eficiência e capacidade técnica',
'B',
'O Art. 38 da LC 194/2012 lista as manifestações essenciais do valor militar: I - sentimento de servir à comunidade (vontade inabalável de cumprir o dever); II - patriotismo (lealdade à Pátria e ao Estado, até com o sacrifício da própria vida); III - dedicação na defesa e proteção da sociedade; IV - civismo e culto às tradições históricas; V - fé na missão elevada; VI - espírito de corpo e orgulho pela Instituição; VII - amor à profissão militar; e VIII - aprimoramento técnico-profissional.',
'Art. 38 - LC nº 194/2012',
'medio'),

(3, 'De acordo com os preceitos da ética militar (LC 194/2012), o militar pode usar seu posto ou graduação para obter facilidades pessoais?',
'Sim, desde que seja para fins de interesse do serviço público',
'Não, é vedado usar o posto ou graduação para obter facilidades pessoais ou encaminhar negócios particulares ou de terceiros',
'Sim, quando autorizado pelo Comandante da unidade',
'Não, exceto em emergências comprovadas de interesse da família',
'B',
'O Art. 39, inciso XI da LC 194/2012 estabelece como preceito da ética militar: abster-se de fazer uso do posto ou da graduação para obter facilidades pessoais de qualquer natureza ou para encaminhar negócios particulares ou de terceiros. O inciso XII complementa ao determinar que o militar deve abster-se, mesmo na reserva remunerada, do uso das designações hierárquicas em atividades liberais, comerciais ou industriais, entre outras situações previstas nas alíneas do artigo.',
'Art. 39 (XI e XII) - LC nº 194/2012',
'medio'),

(3, 'Em quais critérios podem ser realizadas as promoções dos militares estaduais, conforme a LC 194/2012?',
'Apenas por antiguidade e merecimento',
'Antiguidade, merecimento, ato de bravura, post-mortem, tempo de contribuição, mérito intelectual, ressarcimento de preterição e tempo de convocação',
'Apenas por merecimento, bravura e tempo de serviço',
'Por antiguidade, merecimento e aprovação em curso de especialização',
'B',
'O Art. 73 da LC 194/2012, com as alterações da LC 260/2017 e LC 322/2022, estabelece os critérios exclusivos para promoções: I - antiguidade; II - merecimento; III - ato de bravura; IV - post-mortem; V - tempo de contribuição; VI - promoção por Tempo de Efetivo Serviço; VII - por mérito intelectual; VIII - ressarcimento de preterição; e IX - por tempo de convocação, designação ou nomeação (acrescentado pela LC 322/2022). Todos os critérios são previstos em lei específica.',
'Art. 73 - LC nº 194/2012 (alterado pelas LCs 260/2017 e 322/2022)',
'dificil'),

(3, 'Qual é a duração máxima da licença especial do militar estadual por quinquênio de serviço?',
'Dois meses',
'Três meses',
'Seis meses',
'Um mês',
'B',
'O Art. 78, §1º da LC 194/2012 determina que a licença especial tem duração de três meses, a ser gozada quando solicitado pelo interessado e julgada conveniente pela autoridade competente. Essa licença é adquirida a cada quinquênio de tempo de efetivo serviço prestado na instituição, computado a partir da data de incorporação. O §3º esclarece que o período de licença especial não interrompe a contagem do tempo de efetivo serviço.',
'Art. 78 e §§1º e 3º - LC nº 194/2012',
'medio'),

(3, 'Qual é a duração da licença maternidade para a militar estadual, conforme a LC 194/2012?',
'90 (noventa) dias',
'120 (cento e vinte) dias',
'150 (cento e cinquenta) dias',
'180 (cento e oitenta) dias',
'D',
'O Art. 83 da LC 194/2012 estabelece que a licença maternidade é a autorização para afastamento total do serviço e/ou instrução concedida à militar, sem prejuízo da remuneração, e terá a duração de cento e oitenta dias. O §1º prevê que a licença poderá ter início no primeiro dia do nono mês de gestação, salvo antecipação por prescrição médica. Além disso, a lei garante uma hora diária de descanso para amamentação até os seis meses de vida do filho.',
'Art. 83 - LC nº 194/2012',
'facil'),

(3, 'A promoção "post-mortem" na LC 194/2012 é efetivada em qual data?',
'Na data do aniversário do militar falecido',
'Na data do falecimento do militar',
'Na data do ato administrativo de reconhecimento',
'Na data da publicação no Diário Oficial',
'B',
'O Art. 73, inciso IV da LC 194/2012 (com redação da LC 308/2022) estabelece que a promoção post-mortem visa expressar o reconhecimento, por parte do Estado, ao militar estadual que falecer no cumprimento do dever ou em consequência dele, e será efetivada na data do falecimento. As situações que ensejam essa promoção incluem: ação de preservação da ordem pública, ferimento recebido nessa ação, acidente em serviço, ou quando o militar preenchia as condições para promoção mas faleceu antes de sua efetivação.',
'Art. 73 (IV) - LC nº 194/2012 (alterado pela LC 308/2022)',
'dificil'),

(3, 'O militar estadual pode ser cedido a outro órgão antes de quando?',
'A qualquer tempo, mediante autorização do Governador',
'Após 1 (um) ano de efetivo serviço',
'Após a conclusão do estágio probatório',
'Após 5 (cinco) anos de efetivo serviço',
'C',
'O Art. 36 da LC 194/2012 é claro ao estabelecer que o militar estadual só poderá ser cedido a outro órgão após a conclusão do estágio probatório. O §1º acrescenta que na hipótese de cessão, o ônus da remuneração será do órgão ou entidade cessionária, e o §2º determina que a cessão far-se-á mediante decreto publicado no Diário Oficial do Estado. Isso protege a instituição de perder militares recém-formados para outros órgãos antes de completarem seu período probatório.',
'Art. 36 - LC nº 194/2012',
'medio'),

(3, 'Qual é a passagem do militar estadual à situação de reformado em decorrência de incapacidade definitiva adquirida em acidente em serviço?',
'Reforma com proventos proporcionais ao tempo de serviço',
'Reforma com proventos integrais',
'Reforma com proventos equivalentes a 50% do subsídio do posto',
'Reforma com proventos do posto imediatamente superior',
'D',
'O Art. 119 da LC 194/2012 (com redação da LC 260/2017) estabelece que, salvo o inciso V (doença sem relação com o serviço), o militar da ativa ou da reserva remunerada, julgado incapaz definitivamente por motivos relacionados ao serviço, fará jus a proventos correspondentes ao grau hierárquico superior. O Art. 120 detalha o enquadramento hierárquico: por exemplo, o Coronel recebe como proventos de reforma o subsídio equivalente ao posto de Coronel (sem superior), e assim progressivamente nos demais postos e graduações.',
'Arts. 119 e 120 - LC nº 194/2012 (alterados pela LC 260/2017)',
'dificil'),

(3, 'Quais são os quadros de Oficiais previstos na LC 194/2012?',
'QOC, QCO, QOS, QOM, QEO e QOCap',
'QOC, QCO, QOS e QEO apenas',
'QPC, QPS, QEP e QPM',
'QOC, QOS, QCO e QPM',
'A',
'O Art. 22, inciso I da LC 194/2012 (com inclusão da LC 260/2017) estabelece os Quadros de Oficiais: a) Quadro de Oficiais Combatentes (QOC); b) Quadro Complementar de Oficiais (QCO); c) Quadro de Oficiais de Saúde (QOS); d) Quadro de Oficiais Músicos (QOM); e) Quadro Especial de Oficiais (QEO); e f) Quadro de Oficiais Capelães (QOCap). O inciso II lista os Quadros de Praças: QPC, QPS, QEP e QPM.',
'Art. 22 - LC nº 194/2012 (com inclusão pela LC 260/2017)',
'medio'),

(3, 'O candidato ao ingresso na carreira militar estadual pode apresentar tatuagem visível no uso do uniforme operacional de verão?',
'Sim, desde que não contenha símbolos ofensivos',
'Sim, se aprovada previamente pela comissão de saúde',
'Não, a tatuagem visível com a manga curta e bermuda é critério de eliminação',
'Não, exceto se o candidato tiver mais de 20 anos de tempo de serviço',
'C',
'O Art. 17, §6º, inciso III da LC 194/2012 (incluído pela LC 260/2017) estabelece que o candidato ao ingresso não poderá apresentar tatuagem que seja visível na hipótese do uso de uniforme que comporte camisa de manga curta e bermuda, correspondente ao uniforme operacional de verão. Além dessa restrição de visibilidade, também são vedadas tatuagens que expressem ideologia terrorista, discriminação, ideias libidinosas, vinculação a organizações criminosas, entre outras, independentemente da localização corporal.',
'Art. 17 §6º (III) - LC nº 194/2012 (incluído pela LC 260/2017)',
'medio'),

(3, 'O militar estadual que, não estando de serviço, realiza o atendimento de uma ocorrência policial, é considerado:',
'Civil, sem proteção da legislação militar no momento do atendimento',
'Em licença não remunerada durante o atendimento',
'Para todos os efeitos legais, como se em serviço estivesse',
'Voluntário, com direito apenas à remuneração de serviço voluntário',
'C',
'O Art. 61 da LC 194/2012 estabelece claramente que o militar estadual que no atendimento de ocorrência, mesmo não estando de serviço, será considerado para todos os efeitos legais como se em serviço estivesse. Esse dispositivo é fundamental pois garante ao militar a cobertura legal e previdenciária (inclusive para reforma por incapacidade em serviço) quando age mesmo fora do horário regular, em cumprimento de sua missão constitucional de preservação da ordem pública.',
'Art. 61 - LC nº 194/2012',
'medio'),

(3, 'Qual é o percentual mínimo de vagas destinadas a candidatas do sexo feminino nos concursos públicos das corporações militares estaduais de Roraima?',
'10% (dez por cento)',
'15% (quinze por cento)',
'20% (vinte por cento)',
'25% (vinte e cinco por cento)',
'B',
'O Art. 17, §4º da LC 194/2012 estabelece que das vagas ofertadas no concurso público, 15% (quinze por cento) serão destinadas às candidatas do sexo feminino. Esse percentual mínimo garante a participação feminina nas corporações militares estaduais. O §5º complementa ao exigir que a candidata comprove por laudo médico não estar grávida na ocasião da inspeção de saúde, do exame de aptidão física e da matrícula.',
'Art. 17 §4º - LC nº 194/2012',
'facil'),

(3, 'De acordo com a LC 194/2012, quando o militar estadual é considerado "ausente"?',
'Quando falta ao serviço por um dia',
'Quando, por mais de 24 horas consecutivas, deixa de comparecer à sua organização ou se ausenta sem licença',
'Quando está em gozo de licença não autorizada',
'Quando não se apresenta após ser convocado para situação de emergência',
'B',
'O Art. 107 da LC 194/2012 estabelece que é considerado ausente o militar estadual que, por mais de vinte e quatro horas consecutivas: I - deixar de comparecer à sua Organização Policial Militar ou Bombeiro Militar, sem comunicar o motivo de impedimento; ou II - ausentar-se, sem licença, da Unidade onde serve ou do local onde deve permanecer. A ausência difere da deserção, que é tratada no Art. 108 e tem consequências mais severas, sendo definida nos termos da legislação penal militar.',
'Art. 107 - LC nº 194/2012',
'medio'),

(3, 'Quais são as datas de promoção da Polícia Militar de Roraima, conforme a LC 194/2012?',
'1º de março, 15 de agosto e 1º de dezembro',
'21 de abril, 21 de agosto e 25 de dezembro',
'7 de setembro, 15 de novembro e 31 de dezembro',
'1º de janeiro, 1º de julho e 1º de outubro',
'B',
'O Art. 71, §2º da LC 194/2012 estabelece que as datas de promoções da Polícia Militar serão efetuadas anualmente, por antiguidade e/ou merecimento, nos dias 21 de abril (Tiradentes), 21 de agosto e 25 de dezembro, para as vagas abertas e publicadas oficialmente, até trinta dias antes das promoções. O §3º prevê datas diferentes para o Corpo de Bombeiros Militar: 22 de março, 02 de julho e 19 de dezembro.',
'Art. 71 §§2º e 3º - LC nº 194/2012',
'dificil'),

(3, 'Qual a licença concedida ao militar para acompanhar cônjuge ou companheiro deslocado para curso de interesse institucional de 6 a 12 meses de duração?',
'10 (dez) dias',
'20 (vinte) dias',
'30 (trinta) dias',
'60 (sessenta) dias',
'C',
'O Art. 88 da LC 194/2012 estabelece os prazos para a licença de acompanhamento de cônjuge em cursos de interesse institucional: I - trinta dias, para cursos com duração de 6 a 12 meses; II - sessenta dias, para cursos com duração superior a 12 meses; e III - noventa dias, para cursos com duração superior a dois anos. Essa licença é concedida sem prejuízo da remuneração. O parágrafo único permite que o servidor goze da licença de forma integral ou parcelada.',
'Art. 88 - LC nº 194/2012',
'dificil'),

(3, 'O militar estadual fardado tem quais obrigações, conforme a LC 194/2012?',
'Apenas as obrigações de representação do cargo que ocupa',
'As obrigações correspondentes ao uniforme que usa e aos distintivos, emblemas e outras insígnias que ostentar',
'Apenas as obrigações previstas no Código de Ética e Disciplina',
'As obrigações determinadas exclusivamente pelo seu Comandante imediato',
'B',
'O Art. 98 da LC 194/2012 estabelece que o militar fardado tem as obrigações correspondentes ao uniforme que usa e aos distintivos, emblemas e outras insígnias que ostentar. Esse dispositivo reforça que o uso do uniforme não é meramente simbólico: ao vestir o fardamento, o militar assume publicamente todas as responsabilidades inerentes à função militar, devendo pautar sua conduta de forma compatível com a autoridade que o uniforme representa perante a sociedade.',
'Art. 98 - LC nº 194/2012',
'medio'),

(3, 'O militar estadual que for diplomado em cargo eletivo terá qual situação na corporação?',
'Será automaticamente licenciado sem remuneração',
'Será considerado agregado a partir da data do registro como candidato até sua diplomação, se tiver 10 ou mais anos de serviço',
'Será imediatamente transferido para a reserva remunerada',
'Será exonerado da corporação por incompatibilidade com o cargo eletivo',
'B',
'O Art. 100, §1º, inciso III, alínea "m" da LC 194/2012 estabelece que o militar que for candidato a cargo eletivo, desde que tenha 10 (dez) ou mais anos de efetivo serviço, ficará agregado sem prejuízo de sua remuneração e das promoções a que fizer jus. O §7º complementa que essa agregação é contada a partir da data do registro como candidato até sua diplomação, ou seu regresso à Corporação, se não houver sido eleito. Militares com menos de 10 anos são licenciados ex-officio.',
'Art. 100 §1º (III, m) e §7º - LC nº 194/2012',
'dificil');

-- ============================================================
-- QUESTÕES MISTAS / COMPARATIVAS
-- ============================================================

INSERT INTO questoes (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, resposta_correta, explicacao, referencia_legal, nivel) VALUES

(1, 'No exercício de Flexão Abdominal Remador, quantas repetições são necessárias para um policial masculino de 23-27 anos obter nota 10,0 (Cursos de Formação)?',
'56 repetições',
'54 repetições',
'52 repetições',
'50 repetições',
'B',
'Conforme o Anexo B - Tabela II (Abdominal Remador Masculino - 01 minuto) da Portaria 1717/2023, para a faixa etária de 23-27 anos, a pontuação máxima de 10,0 exige 54 repetições em 1 minuto. Para comparação: 18-22 anos exige 56, e 28-32 anos exige 52 repetições para nota 10,0. O exercício é realizado em posição de decúbito dorsal, com cotovelos alinhados aos joelhos na posição sentada.',
'Anexo B - Tabela II - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'dificil'),

(2, 'É vedado nos Perfis Institucionais da PMRR a divulgação de conteúdos que utilizem material apreendido para formar siglas ou palavras representativas das unidades. Essa vedação está em qual artigo da Portaria 685/2024?',
'Art. 9º',
'Art. 11',
'Art. 12',
'Art. 14',
'C',
'O Art. 12, inciso I da Portaria 685/2024 veda expressamente a utilização do material apreendido para formar siglas ou palavras que represente as unidades da PMRR, em imagens ou vídeos de divulgação de ações ou apreensões policiais na imprensa ou plataformas digitais. Essa prática, embora visualmente impactante, foi vedada por razões institucionais e de dignidade no trato com o material apreendido.',
'Art. 12 (I) - Portaria Nº 685/PMRR/QCG/DCS/DCS, 26/04/2024',
'dificil'),

(3, 'Qual é a penalidade máxima de sanção disciplinar prevista na LC 194/2012?',
'15 (quinze) dias',
'20 (vinte) dias',
'30 (trinta) dias',
'60 (sessenta) dias',
'C',
'O Art. 54, §2º da LC 194/2012 estabelece expressamente que a sanção disciplinar não poderá ultrapassar o período de 30 (trinta) dias. Esse limite constitucional é uma garantia fundamental ao militar, impedindo que punições administrativas excessivas sejam aplicadas por meio de sanções disciplinares. Para situações mais graves, a lei prevê outros instrumentos como os Conselhos de Justificação (para Oficiais) e Disciplina (para Praças), que podem resultar em reforma ou exclusão.',
'Art. 54, §2º - LC nº 194/2012',
'facil'),

(1, 'Na avaliação de EFM, o critério avaliativo total da disciplina obedece a qual método de cálculo?',
'Média ponderada, com peso maior para os exercícios aeróbicos',
'Média aritmética simples das notas de cada exercício individual',
'Soma direta de todas as notas, sem divisão',
'Nota do exercício mais difícil, multiplicada por um fator de correção',
'B',
'O Art. 6º, §2º da Portaria 1717/2023 determina que o critério avaliativo total da disciplina obedecerá a nota alcançada em cada exercício individual pelo policial militar de acordo com os índices estabelecidos nas Tabelas do Anexo B, extraindo a média aritmética simples. Isso significa que todas as notas têm o mesmo peso, e a aprovação exige que a média das notas de todos os exercícios seja igual ou superior a 7,0 (sete).',
'Art. 6º, §2º - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio'),

(3, 'De acordo com a LC 194/2012, qual é o prazo para o militar estadual interpor recurso contra a nota obtida na avaliação de EFM, conforme a Portaria 1717/2023?',
'12 horas',
'24 horas',
'48 horas',
'72 horas',
'B',
'O Art. 12 da Portaria 1717/2023 estabelece que o policial militar que se sentir prejudicado, da nota obtida após devolutiva do resultado alcançado, poderá recorrer no prazo de 24 horas, observadas as normas da instituição de ensino. Esse prazo curto exige atenção imediata do avaliado. Ressalta-se que o direito ao recurso é uma garantia do contraditório e da ampla defesa, princípios constitucionais que se aplicam também no ambiente militar.',
'Art. 12 - Portaria Nº 1717/PMRR/QCG/DEP/GABDEP, 13/11/2023',
'medio');

-- Índices para performance
CREATE INDEX idx_questoes_categoria ON questoes(categoria_id);
CREATE INDEX idx_questoes_nivel ON questoes(nivel);
CREATE INDEX idx_respostas_sessao ON respostas_usuario(sessao_id);
CREATE INDEX idx_respostas_questao ON respostas_usuario(questao_id);

SELECT CONCAT('Total de questões inseridas: ', COUNT(*)) AS resultado FROM questoes;
