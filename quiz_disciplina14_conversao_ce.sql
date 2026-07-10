-- ============================================================
-- CORRECAO CRITICA — Disciplina 14 (Licitacoes): converte 10 questoes
-- Certo/Errado (formato incompativel com o quiz A-E) em 10 questoes A-E.
-- As 10 originais (ids 1115-1124) estavam quebradas: so tinham 2 opcoes
-- (Certo/Errado) e QUATRO delas (1117,1118,1121,1122) tinham gabarito C ou D,
-- apontando para uma alternativa inexistente. Aposentadas com ativa=0.
-- Conceitos e artigos verificados contra Lei_14133_2021 (legislacao/).
-- ============================================================
SET NAMES utf8mb4;

SET @cat_lic14 = (SELECT id FROM categorias WHERE nome = 'Licitações & Contratos — CHO 14' ORDER BY id LIMIT 1);

-- Aposenta as 10 questoes Certo/Errado quebradas
UPDATE questoes SET ativa = 0 WHERE categoria_id = @cat_lic14 AND id BETWEEN 1115 AND 1124;

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Modalidades (art. 28)
(@cat_lic14,
 'A Lei nº 14.133/2021 reorganizou as modalidades de licitação em relação ao regime anterior. Sobre as modalidades atualmente previstas, é correto afirmar que:',
 'O convite e a tomada de preços foram mantidos, acrescentando-se o pregão.',
 'São modalidades o pregão, a concorrência, o concurso, o leilão e o diálogo competitivo, tendo sido extintos o convite e a tomada de preços.',
 'A concorrência foi extinta e substituída pelo diálogo competitivo.',
 'O pregão passou a ser a única modalidade admitida para obras e serviços de engenharia.',
 'O leilão deixou de ser modalidade e tornou-se procedimento auxiliar.',
 'B',
 'A alternativa B está correta: a nova lei prevê cinco modalidades — pregão, concorrência, concurso, leilão e diálogo competitivo —, extinguindo o convite e a tomada de preços da lei anterior. A alternativa A mantém modalidades extintas; C e D inventam substituições inexistentes; E rebaixa o leilão, que segue sendo modalidade.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 28: "São modalidades de licitação: I - pregão; II - concorrência; III - concurso; IV - leilão; V - diálogo competitivo." O convite e a tomada de preços não constam do rol.',
 'Lei 14.133/2021, art. 28',
 'facil'),

-- Dialogo competitivo — quando cabe (art. 32)
(@cat_lic14,
 'Um órgão precisa contratar uma solução que envolve inovação tecnológica e não consegue, sozinho, definir com precisão a solução mais adequada às suas necessidades. A modalidade apropriada, na qual a Administração dialoga com licitantes previamente selecionados por critérios objetivos até que apresentem proposta final, é:',
 'o pregão.',
 'o concurso.',
 'o diálogo competitivo.',
 'o leilão.',
 'a concorrência para bens comuns.',
 'C',
 'A alternativa C está correta: o diálogo competitivo é a modalidade voltada a objetos que envolvam inovação tecnológica ou técnica, em que a Administração não consegue definir sozinha a solução, dialogando com licitantes previamente selecionados até a apresentação da proposta final. A alternativa A (pregão) é para bens e serviços comuns; B (concurso) é para trabalho técnico/artístico; D (leilão) é para alienação de bens; E não corresponde à hipótese.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 32 — a modalidade diálogo competitivo é restrita a contratações que envolvam inovação tecnológica ou técnica e a impossibilidade de a Administração ter sua necessidade satisfeita sem adaptar as soluções disponíveis no mercado.',
 'Lei 14.133/2021, art. 32',
 'medio'),

-- Fases do processo (art. 17)
(@cat_lic14,
 'Sobre a sequência de fases do processo licitatório na Lei nº 14.133/2021, assinale a alternativa correta:',
 'O processo não segue rito padronizado, cabendo ao gestor definir a ordem das fases a cada edital.',
 'O processo observa, em regra, sete fases em sequência, iniciando-se na fase preparatória e encerrando-se na homologação.',
 'O processo inicia-se na divulgação do edital, dispensada a fase preparatória.',
 'O processo encerra-se na fase de julgamento, sendo a homologação facultativa.',
 'O processo possui apenas três fases: edital, julgamento e contrato.',
 'B',
 'A alternativa B está correta: a lei fixa um rito sequencial padronizado de sete fases — preparatória; divulgação do edital; apresentação de propostas e lances; julgamento; habilitação; recursal; e homologação. As alternativas A, C, D e E negam o rito, suprimem fases obrigatórias ou reduzem indevidamente o número de etapas.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 17: "O processo de licitação observará as seguintes fases, em sequência: I - preparatória; II - de divulgação do edital; III - de apresentação de propostas e lances, quando for o caso; IV - de julgamento; V - de habilitação; VI - recursal; VII - de homologação."',
 'Lei 14.133/2021, art. 17',
 'medio'),

-- Inversao de fases (art. 17, V)
(@cat_lic14,
 'Comparada ao regime da Lei nº 8.666/1993, a Lei nº 14.133/2021 alterou a posição da fase de habilitação. Em regra, na nova lei:',
 'a habilitação antecede o julgamento das propostas, analisando-se a documentação de todos os licitantes.',
 'a habilitação é posterior ao julgamento das propostas, analisando-se a documentação apenas do licitante mais bem classificado.',
 'a habilitação foi extinta, bastando a proposta de preço.',
 'a habilitação ocorre depois da homologação do certame.',
 'a ordem das fases é definida livremente pela comissão a cada licitação.',
 'B',
 'A alternativa B está correta: a regra geral passou a ser a inversão de fases — julga-se a proposta primeiro e só depois se examina a documentação de habilitação do licitante mais bem classificado, o que dá celeridade ao certame. A antecipação da habilitação é exceção, dependente de ato motivado. As demais alternativas contrariam a sistemática do art. 17.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 17, que posiciona a habilitação (inciso V) após o julgamento (inciso IV); o §1º admite, excepcionalmente e mediante ato motivado, a inversão do exame para antes do julgamento.',
 'Lei 14.133/2021, art. 17, V e §1º',
 'medio'),

-- Dispensa x inexigibilidade (arts. 74 e 75)
(@cat_lic14,
 'Sobre a distinção entre dispensa e inexigibilidade de licitação na Lei nº 14.133/2021, assinale a alternativa correta:',
 'Ambas pressupõem a inviabilidade fática de competição entre fornecedores.',
 'Na dispensa a competição é viável, mas a lei autoriza a Administração a não licitar em hipóteses de rol taxativo; na inexigibilidade há inviabilidade de competição, com rol meramente exemplificativo.',
 'A inexigibilidade possui rol taxativo, e a dispensa, rol exemplificativo.',
 'A dispensa só é admitida para a contratação de serviços de engenharia.',
 'A inexigibilidade depende sempre de autorização prévia do Tribunal de Contas.',
 'B',
 'A alternativa B está correta: na dispensa, a competição seria possível, mas a lei autoriza a contratação direta em hipóteses expressas e taxativas; na inexigibilidade, a competição é faticamente inviável (ex.: fornecedor exclusivo, artista consagrado), e o rol legal é exemplificativo ("em especial"). A alternativa A iguala os institutos; C inverte a natureza dos róis; D e E criam restrições/condições inexistentes.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 74 (inexigibilidade — "inviável a competição, em especial nos casos de...", rol exemplificativo) e art. 75 (dispensa — hipóteses taxativas).',
 'Lei 14.133/2021, arts. 74 e 75',
 'medio'),

-- Dispensa por valor (art. 75, II)
(@cat_lic14,
 'Uma fundação pública estadual contrata, por dispensa de licitação, serviço de assistência social no valor de R$ 45.000,00. Sobre a regularidade dessa contratação direta, é correto afirmar que:',
 'é irregular, pois toda contratação da Administração exige licitação prévia.',
 'é regular, pois o valor está abaixo do teto legal de dispensa em razão do valor para outros serviços e compras.',
 'é irregular, pois a dispensa em razão do valor só é admitida para obras e serviços de engenharia.',
 'é regular apenas se a contratação for previamente autorizada pelo Governador do Estado.',
 'é irregular, pois entidades sem fins lucrativos não podem ser contratadas pela Administração.',
 'B',
 'A alternativa B está correta: a lei admite a dispensa em razão do valor para "outros serviços e compras" até o teto legal, no qual o valor de R$ 45.000,00 se enquadra. A alternativa A ignora as hipóteses de contratação direta; C confunde com o teto próprio de obras/serviços de engenharia (mais alto); D cria uma autorização inexistente; E veda indevidamente a contratação de entidades sem fins lucrativos.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 75, II (dispensa para outros serviços e compras de valor inferior ao teto legal). O art. 75, I traz teto maior, específico para obras e serviços de engenharia e manutenção de veículos.',
 'Lei 14.133/2021, art. 75, II',
 'medio'),

-- SRP procedimento auxiliar (art. 78, IV)
(@cat_lic14,
 'O sistema de registro de preços (SRP), na sistemática da Lei nº 14.133/2021, é corretamente classificado como:',
 'uma prática vedada, que não pode mais ser utilizada pela Administração.',
 'um procedimento auxiliar das licitações e contratações, previsto expressamente na lei.',
 'uma nova modalidade de licitação, autônoma em relação às demais.',
 'um instrumento restrito a obras de engenharia de grande vulto.',
 'um mecanismo absorvido pela modalidade concurso.',
 'B',
 'A alternativa B está correta: o SRP é um dos procedimentos auxiliares expressamente previstos na lei, e não uma modalidade de licitação. As alternativas A, C, D e E negam sua existência, promovem-no indevidamente a modalidade ou restringem seu uso sem amparo legal.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 78: "São procedimentos auxiliares das licitações e das contratações regidas por esta Lei: I - credenciamento; II - pré-qualificação; III - procedimento de manifestação de interesse; IV - sistema de registro de preços; V - registro cadastral."',
 'Lei 14.133/2021, art. 78, IV',
 'facil'),

-- Cooperativas (isonomia)
(@cat_lic14,
 'Quanto à participação de sociedades cooperativas em licitações regidas pela Lei nº 14.133/2021, é correto afirmar que:',
 'estão impedidas de participar de qualquer licitação pública sob o novo regime.',
 'podem participar, desde que observadas as exigências do edital e da lei.',
 'só podem participar de licitações que tenham por objeto serviços de limpeza e conservação.',
 'participam apenas por meio de dispensa de licitação.',
 'foram substituídas, no novo regime, pelas organizações sociais.',
 'B',
 'A alternativa B está correta: não há vedação à participação de cooperativas; elas concorrem em igualdade de condições, observadas as exigências do edital e da lei, em respeito à isonomia e à competitividade. As alternativas A, C, D e E criam impedimentos, restrições ou substituições inexistentes.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021 — os princípios da isonomia e da competitividade (art. 5º) e as regras de participação asseguram o acesso das sociedades cooperativas às licitações, cumpridos os requisitos legais e editalícios.',
 'Lei 14.133/2021, art. 5º (isonomia e competitividade)',
 'medio'),

-- Agente de contratacao (art. 8)
(@cat_lic14,
 'Sobre a designação dos agentes públicos responsáveis pela condução da licitação, a Lei nº 14.133/2021 estabelece que a designação cabe à autoridade máxima do órgão ou entidade, que deve indicar:',
 'obrigatoriamente profissionais terceirizados, para garantir a imparcialidade do certame.',
 'preferencialmente servidores efetivos ou empregados públicos dos quadros permanentes da Administração.',
 'exclusivamente ocupantes de cargo em comissão de livre nomeação.',
 'qualquer cidadão, ainda que sem qualquer vínculo com a Administração.',
 'um representante indicado pelo Tribunal de Contas competente.',
 'B',
 'A alternativa B está correta: a lei preza pela profissionalização e continuidade, determinando que as funções essenciais sejam exercidas preferencialmente por servidores efetivos ou empregados públicos dos quadros permanentes. As alternativas A, C, D e E contrariam essa diretriz ou atribuem a designação a agentes sem o vínculo exigido.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, arts. 7º e 8º, que atribuem à autoridade competente a designação do agente de contratação, preferencialmente entre servidores efetivos ou empregados públicos dos quadros permanentes.',
 'Lei 14.133/2021, arts. 7º e 8º',
 'medio'),

-- Apoio tecnico externo (art. 8, §4)
(@cat_lic14,
 'Em licitação que envolva bens ou serviços especiais, não rotineiramente contratados pela Administração e de complexidade que exija conhecimento técnico específico, a Lei nº 14.133/2021 admite que a Administração:',
 'contrate, por prazo determinado, empresa ou profissional especializado para assessorar os agentes públicos responsáveis pela condução do certame.',
 'dispense a licitação, independentemente do valor da contratação.',
 'transfira integralmente a condução da licitação a uma empresa privada contratada.',
 'delegue a decisão final do certame ao licitante mais antigo no mercado.',
 'suspenda a exigência de habilitação de todos os licitantes.',
 'A',
 'A alternativa A está correta: para objetos especiais e complexos, a lei permite, como apoio, a contratação por prazo determinado de empresa ou profissional especializado para assessorar os agentes públicos — sem lhes transferir a condução ou a decisão do certame. As alternativas B, C, D e E extrapolam essa autorização (dispensa por complexidade, terceirização integral, delegação da decisão ou supressão da habilitação), sem amparo legal.\n\n📜 Fundamento legal vigente: Lei nº 14.133/2021, art. 8º, §4º, que faculta a contratação de profissional ou empresa especializada para assessorar os agentes na condução de licitações de bens ou serviços especiais.',
 'Lei 14.133/2021, art. 8º, §4º',
 'medio');
