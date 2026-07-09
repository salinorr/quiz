-- ============================================================
-- QUIZ — Disciplina 9/20 do CHO: Direitos Humanos e Cidadania
-- 30 questões — dupla justificativa (doutrina/apostila + legislação vigente)
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: apostila técnica do CHO — Direitos Humanos e Cidadania.pdf
--   (Academia Coronel Walterler) — teoria geral, evolução histórica, gerações
--   de direitos, internacionalização e sistema ONU, DUDH e CADH.
-- Base legal vigente: Declaração Universal dos Direitos Humanos (DUDH, ONU,
--   Res. 217 A (III) da Assembleia Geral, 10/12/1948); Convenção Americana
--   sobre Direitos Humanos (CADH / Pacto de São José da Costa Rica),
--   promulgada no Brasil pelo Decreto nº 678/1992; CRFB/1988, art. 5º, §4º
--   (EC 45/2004 — TPI); Carta das Nações Unidas (1945); Res. 60/251 da
--   Assembleia Geral da ONU (2006 — Conselho de Direitos Humanos).
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Direitos Humanos e Cidadania — CHO 09', 'Disciplina 9/20 do CHO — Teoria geral e evolução histórica dos Direitos Humanos, gerações de direitos, sistema ONU, Declaração Universal dos Direitos Humanos (DUDH) e Convenção Americana sobre Direitos Humanos (CADH/Pacto de São José da Costa Rica)');

SET @cat_dh09 = (SELECT id FROM categorias WHERE nome = 'Direitos Humanos e Cidadania — CHO 09' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Titularidade universal dos Direitos Humanos
(@cat_dh09,
 'No contexto do regime democrático e da teoria geral dos Direitos Humanos, o critério de titularidade desses direitos estabelece que:',
 'A proteção da dignidade humana é restrita aos cidadãos que cumprem integralmente seus deveres civis.',
 'A condição econômica e a origem social são fatores que graduam a proteção estatal ao indivíduo.',
 'A titularidade dos Direitos Humanos é universal, bastando ser pessoa humana, independentemente de ser um cidadão condenado por um crime.',
 'Direitos fundamentais como a liberdade e a saúde podem ser objeto de negociação direta entre o indivíduo e o Estado.',
 'A proteção da integridade física é garantida prioritariamente àqueles que professam o credo religioso oficial da nação.',
 'C',
 'A alternativa C está correta: a titularidade dos Direitos Humanos depende exclusivamente da condição de pessoa humana, não importando origem, raça, sexo, credo ou mesmo condenação criminal anterior — a doutrina é enfática ao afirmar que nem o condenado por um crime perde sua titularidade aos direitos humanos fundamentais. A alternativa A está incorreta porque condiciona a proteção ao cumprimento de deveres civis, o que contraria a incondicionalidade da dignidade humana. A alternativa B está incorreta pois riqueza e origem social são exatamente os critérios que a igualdade de titularidade repudia. A alternativa D é falsa, pois direitos como liberdade e saúde não são disponíveis à negociação entre particular e Estado. A alternativa E está incorreta por instituir um critério discriminatório religioso, incompatível com a universalidade dos Direitos Humanos.\n\n📜 Fundamento legal vigente: DUDH, art. 1º: "Todos os seres humanos nascem livres e iguais em dignidade e direitos." c/c art. 2º, §1º: "Todo ser humano tem capacidade para gozar os direitos e as liberdades estabelecidos nesta Declaração, sem distinção de qualquer espécie, seja de raça, cor, sexo, língua, religião, opinião política ou de outra natureza, origem nacional ou social, riqueza, nascimento, ou qualquer outra condição." A Declaração não prevê nenhuma exceção pela condição de condenado.',
 'DUDH, arts. 1º e 2º',
 'facil'),

-- Q02: Natureza jurídica das normas de Direitos Humanos
(@cat_dh09,
 'Sobre a natureza jurídica das normas de Direitos Humanos e a responsabilidade do Estado, assinale a alternativa correta:',
 'Tais normas possuem caráter meramente ético, sem estabelecer obrigações jurídicas vinculantes ao Estado.',
 'As normas de Direitos Humanos estabelecem direitos e deveres correspondentes, obrigando o Estado a garantir seu exercício e a impedir violações por terceiros.',
 'O dever estatal restringe-se a uma abstenção (dever de não fazer), não cabendo ao Estado agir para impedir que particulares violem direitos de outrem.',
 'A positivação dos Direitos Humanos desonera o Estado de prover segurança, transferindo essa responsabilidade à sociedade civil.',
 'O direito à vida gera para o Estado apenas a obrigação de não executar indivíduos, sem abranger o dever de impedir homicídios entre particulares.',
 'B',
 'A alternativa B está correta: as normas de Direitos Humanos não são meros apelos morais, mas geram para o Estado tanto o dever de respeitar (abstenção) quanto o dever de garantir o exercício dos direitos e de impedir que terceiros os violem (proteção ativa). A alternativa A nega o caráter jurídico vinculante das normas, contrariando sua positivação em tratados internacionais ratificados pelo Brasil. A alternativa C reduz indevidamente a obrigação estatal à dimensão negativa, ignorando a dimensão positiva de proteção. A alternativa D inverte a lógica de responsabilidade, pois a positivação reforça, e não desonera, o dever estatal de segurança. A alternativa E restringe o direito à vida à mera abstenção de execução, quando o dever estatal também abrange a proteção contra violações por particulares (ex.: dever de investigar e prevenir homicídios).\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 1º, §1º: "Os Estados-Partes nesta Convenção comprometem-se a respeitar os direitos e liberdades nela reconhecidos e a garantir seu livre e pleno exercício a toda pessoa que esteja sujeita à sua jurisdição, sem discriminação alguma (...)." O dispositivo consagra expressamente a dupla obrigação estatal de respeitar e de garantir os direitos humanos.',
 'CADH (Decreto 678/1992), art. 1º, §1º',
 'medio'),

-- Q03: Definição jurídica e historicidade dos Direitos Humanos
(@cat_dh09,
 'Quanto à definição e historicidade dos Direitos Humanos, é correto afirmar que:',
 'Existe uma definição única e absoluta, imutável através dos séculos.',
 'O termo é desprovido de historicidade, possuindo o mesmo significado jurídico desde a Antiguidade Clássica.',
 'Sob o aspecto jurídico, definem-se como um conjunto de normas que regem as relações entre indivíduos e instituições e entre os próprios indivíduos.',
 'A dignidade da pessoa humana é um conceito secundário perante a soberania absoluta das instituições estatais.',
 'Direitos Humanos referem-se exclusivamente aos direitos políticos de participação direta no governo.',
 'C',
 'A alternativa C está correta: sob o aspecto jurídico, os Direitos Humanos definem-se como o conjunto de normas que regem as relações entre indivíduos e instituições e dos indivíduos entre si, conceito que é historicamente construído e ampliado ao longo do tempo. A alternativa A está incorreta porque nega a historicidade do conceito, desmentida pela evolução das gerações de direitos. A alternativa B ignora que o conteúdo protetivo mudou substancialmente da Antiguidade até hoje. A alternativa D inverte a lógica constitucional contemporânea, que consagra a dignidade da pessoa humana como fundamento, e não elemento secundário, da ordem estatal. A alternativa E restringe indevidamente os Direitos Humanos aos direitos políticos, quando na verdade abrangem também direitos civis, sociais, econômicos, culturais e de solidariedade.\n\n📜 Fundamento legal vigente: trata-se de conceituação doutrinária de teoria geral dos Direitos Humanos, sem correspondência em artigo específico de tratado — a historicidade e a amplitude do conceito são, no entanto, corroboradas pelo preâmbulo da DUDH (1948), que reconhece a dignidade humana como "fundamento da liberdade, da justiça e da paz no mundo".',
 'Doutrina de Teoria Geral dos Direitos Humanos; DUDH, preâmbulo',
 'facil'),

-- Q04: Iluminismo e contratualistas
(@cat_dh09,
 'Durante o Iluminismo, segundo os contratualistas (Hobbes, Locke e Rousseau), firmou-se o entendimento de que:',
 'Os direitos humanos são concessões de soberania que o Estado pode revogar a qualquer tempo.',
 'O homem possui direitos inalienáveis e imprescritíveis, decorrentes de sua natureza e independentes do Estado.',
 'O princípio da igualdade essencial foi rejeitado em favor da manutenção da nobreza.',
 'A natureza humana é irrelevante, sendo o Direito um produto exclusivo da vontade do monarca.',
 'Os direitos inalienáveis surgiram apenas como resposta direta às bombas atômicas de 1945.',
 'B',
 'A alternativa B está correta: o pensamento contratualista do Iluminismo (Hobbes, Locke, Rousseau) consolidou a noção jusnaturalista de que o ser humano possui direitos inalienáveis e imprescritíveis, anteriores e independentes do reconhecimento estatal. A alternativa A inverte a lógica jusnaturalista, tratando os direitos como concessão estatal revogável, o que é próprio do positivismo, não do contratualismo iluminista. A alternativa C contraria o próprio ideário igualitário que fundamentou as revoluções liberais burguesas. A alternativa D nega a base filosófica de todo o movimento, que exatamente valoriza a razão e a natureza humana em detrimento do absolutismo monárquico. A alternativa E é cronologicamente falsa, pois o Iluminismo é do século XVIII, muito anterior a 1945.\n\n📜 Fundamento legal vigente: trata-se de fato histórico-filosófico (jusnaturalismo contratualista dos séculos XVII-XVIII), sem correspondência em dispositivo de tratado internacional — essa herança é reconhecida no preâmbulo da DUDH (1948), que fala em "direitos iguais e inalienáveis" de todos os membros da família humana.',
 'Fato histórico-doutrinário (jusnaturalismo contratualista); DUDH, preâmbulo',
 'facil'),

-- Q05: Magna Carta de 1215
(@cat_dh09,
 'A Magna Carta de 1215 é considerada um marco histórico dos Direitos Humanos. Sua principal contribuição foi:',
 'A instauração imediata do sufrágio universal na Inglaterra.',
 'A submissão do governante a um corpo escrito de normas, limitando o poder monárquico e protegendo direitos de estamentos específicos (clero e nobreza).',
 'A proibição absoluta de qualquer forma de punição física em território britânico.',
 'A garantia de que plebeus e nobres tivessem exatamente os mesmos direitos de propriedade.',
 'O reconhecimento de que o poder do monarca emanava diretamente de uma divindade, acima da lei dos súditos.',
 'B',
 'A alternativa B está correta: a Magna Carta de 1215 é o primeiro documento histórico relevante a submeter o governante (Rei João Sem Terra) a um corpo escrito de normas, limitando seu poder absoluto e protegendo direitos e privilégios inicialmente restritos ao clero e à nobreza. A alternativa A é falsa, pois o sufrágio universal é conquista muito posterior (séculos XIX e XX). A alternativa C não corresponde à realidade histórica do documento, que não trata de proibição de punições físicas. A alternativa D é incorreta porque a proteção da Magna Carta era estamental, não igualitária entre plebeus e nobres. A alternativa E é o oposto do que o documento representa, já que ele justamente relativiza o poder até então tido como absoluto e de origem divina.\n\n📜 Fundamento legal vigente: trata-se de fato histórico (Magna Carta, Inglaterra, 1215), documento sem correspondência em dispositivo da DUDH ou da CADH — é referido pela doutrina como precursor remoto do constitucionalismo e da limitação jurídica do poder, ideia posteriormente incorporada ao Estado de Direito.',
 'Fato histórico (Magna Carta, 1215) — doutrina de Direitos Humanos',
 'facil'),

-- Q06: Documentos constitucionais ingleses (séc. XVII)
(@cat_dh09,
 'Considerando os documentos ingleses Petition of Rights (1628), Habeas Corpus Act (1679) e Bill of Rights (1689), é correto afirmar que:',
 'O Habeas Corpus Act restringiu a liberdade de locomoção apenas aos membros do Parlamento.',
 'A Petition of Rights autorizou o aquartelamento de soldados nas casas de cidadãos sem consentimento.',
 'O Bill of Rights assegurou a supremacia do Parlamento sobre a vontade do Rei.',
 'A Petition of Rights estabeleceu que o Rei poderia impor tributos livremente, sem anuência parlamentar.',
 'O Bill of Rights extinguiu a propriedade privada para fortalecer o tesouro real.',
 'C',
 'A alternativa C está correta: o Bill of Rights de 1689 consolidou a supremacia do Parlamento inglês sobre a vontade do monarca, marco fundamental do constitucionalismo britânico. A alternativa A é falsa, pois o Habeas Corpus Act protege a liberdade de locomoção de qualquer súdito preso arbitrariamente, não apenas parlamentares. A alternativa B inverte o sentido histórico do documento: a Petition of Rights (1628) exatamente vedou o aquartelamento forçado de soldados em casas de particulares sem consentimento. A alternativa D também inverte o conteúdo do documento, que vedou a cobrança de tributos sem aprovação do Parlamento. A alternativa E não corresponde a nenhum efeito histórico do Bill of Rights, que não tratou de extinção da propriedade privada.\n\n📜 Fundamento legal vigente: trata-se de fato histórico (documentos constitucionais ingleses do século XVII), sem correspondência em dispositivo da DUDH ou da CADH — são referidos pela doutrina como marcos da limitação do poder monárquico e da afirmação de garantias processuais (habeas corpus), posteriormente incorporadas a praticamente todos os ordenamentos ocidentais, inclusive o brasileiro (CRFB, art. 5º, LXVIII).',
 'Fato histórico (documentos constitucionais ingleses, séc. XVII); CRFB, art. 5º, LXVIII (por analogia)',
 'medio'),

-- Q07: Declaração de Independência dos EUA e Bill of Rights (1791)
(@cat_dh09,
 'A Declaração de Independência dos EUA (1776) e a Constituição de 1787, com suas primeiras emendas, protegem, entre outros, os seguintes direitos:',
 'O dever de submissão do povo à religião oficial do Estado.',
 'A proibição do porte de armas por civis.',
 'As liberdades de expressão, religião, petição e reunião, além do direito de guardar e usar armas.',
 'A centralização do poder no Executivo como forma de garantir a igualdade.',
 'A primazia dos direitos sociais de segunda geração sobre as liberdades civis.',
 'C',
 'A alternativa C está correta: a Primeira Emenda à Constituição dos EUA protege as liberdades de expressão, religião, imprensa, reunião e petição, e a Segunda Emenda assegura o direito de guardar e usar armas — ambas integrantes do Bill of Rights norte-americano de 1791. A alternativa A é falsa, pois os EUA desde a origem rejeitaram a imposição de uma religião oficial (separação entre Igreja e Estado). A alternativa B inverte o conteúdo da Segunda Emenda, que garante, e não proíbe, o porte de armas. A alternativa D contraria o modelo de separação de poderes (checks and balances) adotado pela Constituição de 1787. A alternativa E é anacrônica, pois os direitos sociais de segunda geração são posteriores (século XX), e o constitucionalismo americano de 1776/1787 é essencialmente de primeira geração (liberdades civis e políticas).\n\n📜 Fundamento legal vigente: trata-se de fato histórico-constitucional norte-americano (Declaração de Independência de 1776; Primeira e Segunda Emendas do Bill of Rights de 1791), sem correspondência em dispositivo da DUDH ou da CADH — a DUDH, de 1948, viria a consagrar de forma similar as liberdades de expressão (art. 19), religião (art. 18) e reunião (art. 20), sem prever, contudo, direito ao porte de armas.',
 'Fato histórico-constitucional dos EUA (Bill of Rights, 1791); DUDH, arts. 18, 19 e 20 (paralelo)',
 'medio'),

-- Q08: Declaração dos Direitos do Homem e do Cidadão (França, 1789)
(@cat_dh09,
 'A Declaração dos Direitos do Homem e do Cidadão (1789), da Revolução Francesa, enfatiza:',
 'O retorno ao absolutismo monárquico como garantia de ordem.',
 'A resistência à opressão e os princípios da legalidade, da igualdade perante a lei e da soberania popular.',
 'A subordinação da soberania popular ao poder do clero.',
 'A revogação do direito de propriedade privada em favor do Estado.',
 'A exclusão dos direitos individuais em prol da segurança nacional absoluta.',
 'B',
 'A alternativa B está correta: a Declaração de 1789 consagrou a resistência à opressão como direito natural (art. 2º), além dos princípios da legalidade, da igualdade perante a lei e da soberania popular (arts. 1º, 3º e 6º), marcos centrais do constitucionalismo liberal moderno. A alternativa A é o oposto do que a Declaração representa, já que ela rompe justamente com o absolutismo monárquico. A alternativa C inverte a lógica do documento, que afirma a soberania residir essencialmente na nação, e não no clero. A alternativa D é falsa, pois a Declaração assegura a propriedade como direito inviolável e sagrado (art. 17). A alternativa E contraria o próprio objetivo do documento, que é justamente afirmar direitos individuais frente ao Estado.\n\n📜 Fundamento legal vigente: trata-se de fato histórico-normativo (Declaração dos Direitos do Homem e do Cidadão, França, 1789), sem correspondência em dispositivo da DUDH ou da CADH, embora seja reconhecida pela doutrina como uma das fontes diretas de inspiração da própria DUDH de 1948, que reproduz em linhas gerais a ideia de liberdade, igualdade e resistência à opressão.',
 'Fato histórico (Declaração dos Direitos do Homem e do Cidadão, França, 1789) — fonte de inspiração da DUDH',
 'medio'),

-- Q09: Direitos de primeira geração
(@cat_dh09,
 'Os direitos de primeira geração caracterizam-se por:',
 'Exigir prestações materiais positivas do Estado, como saúde e previdência.',
 'Serem direitos de solidariedade, focados no meio ambiente e na paz global.',
 'Representarem as chamadas "liberdades negativas", impondo ao Estado um dever de abstenção.',
 'Surgirem após a Segunda Guerra Mundial para combater o desemprego tecnológico.',
 'Terem como titular exclusivo a coletividade, em detrimento do indivíduo.',
 'C',
 'A alternativa C está correta: os direitos de primeira geração são os direitos civis e políticos, chamados "liberdades negativas" por exigirem do Estado um dever de abstenção (não interferir na esfera de liberdade do indivíduo). A alternativa A descreve os direitos de segunda geração (prestações positivas). A alternativa B descreve os direitos de terceira geração (solidariedade/fraternidade). A alternativa D é cronologicamente equivocada e tematicamente incorreta, pois a primeira geração é anterior à Segunda Guerra e não trata de desemprego tecnológico. A alternativa E inverte a titularidade: os direitos de primeira geração têm o indivíduo como titular por excelência, ao contrário dos de terceira geração, de titularidade difusa/coletiva.\n\n📜 Fundamento legal vigente: trata-se de classificação doutrinária (teoria das gerações/dimensões de direitos, atribuída a Karel Vasak), sem artigo específico correspondente — a DUDH materializa amplamente os direitos de primeira geração em seus arts. 3º a 21 (vida, liberdade, igualdade perante a lei, devido processo, liberdade de expressão, religião, reunião e participação política).',
 'Doutrina das gerações de direitos (Karel Vasak); DUDH, arts. 3º a 21 (exemplos de 1ª geração)',
 'facil'),

-- Q10: Direitos de segunda geração
(@cat_dh09,
 'A segunda geração de direitos humanos teve como marcos jurídicos fundamentais:',
 'A Magna Carta de 1215 e o Bill of Rights de 1689.',
 'As Constituições do México (1917) e de Weimar (1919), além da Revolução Industrial.',
 'A criação da Liga das Nações após a Primeira Guerra Mundial.',
 'O surgimento da globalização econômica no final do século XX.',
 'A Declaração de Independência dos Estados Unidos.',
 'B',
 'A alternativa B está correta: a segunda geração de direitos (direitos sociais, econômicos e culturais, exigindo prestações positivas do Estado) tem como marcos as Constituições do México (1917) e de Weimar (1919), diretamente influenciadas pelas mazelas sociais da Revolução Industrial. A alternativa A refere-se a marcos de primeira geração (limitação do poder estatal). A alternativa C, embora contemporânea, não é o marco jurídico da segunda geração, e a Liga das Nações tinha outro escopo (paz e cooperação entre Estados). A alternativa D é anacrônica, pois a globalização econômica é associada à quarta geração, muito mais recente. A alternativa E também é um marco de primeira geração.\n\n📜 Fundamento legal vigente: trata-se de classificação doutrinária (teoria das gerações de direitos), sem correspondência em dispositivo da DUDH ou da CADH — a DUDH viria, décadas depois (1948), a consagrar direitos sociais de segunda geração em seus arts. 22 a 26 (segurança social, trabalho, repouso, educação).',
 'Doutrina das gerações de direitos; DUDH, arts. 22 a 26 (exemplos de 2ª geração)',
 'medio'),

-- Q11: Direitos de terceira geração
(@cat_dh09,
 'Os direitos de terceira geração (solidariedade/fraternidade) abrangem:',
 'O direito de voto e a liberdade de expressão individual.',
 'O direito ao trabalho e à educação básica obrigatória.',
 'O direito à paz, ao meio ambiente sadio e ao patrimônio comum da humanidade.',
 'O direito à democracia e à informação no contexto da rede mundial de computadores.',
 'O direito de propriedade absoluta e livre de impostos.',
 'C',
 'A alternativa C está correta: os direitos de terceira geração, também chamados de direitos de solidariedade ou fraternidade, têm titularidade difusa/coletiva e abrangem o direito à paz, ao desenvolvimento, ao meio ambiente sadio e ao patrimônio comum da humanidade. A alternativa A descreve direitos de primeira geração (civis e políticos). A alternativa B descreve direitos de segunda geração (sociais). A alternativa D refere-se tipicamente à quarta geração, ligada à globalização político-informacional. A alternativa E não corresponde a nenhuma geração reconhecida pela doutrina, já que a propriedade nunca foi tratada como direito absoluto e ilimitado nem mesmo na primeira geração.\n\n📜 Fundamento legal vigente: trata-se de classificação doutrinária (teoria das gerações de direitos), sem correspondência em artigo específico da DUDH (1948), documento anterior à consolidação teórica dos direitos de terceira geração (que ganham força a partir das décadas de 1970-1980, com a pauta ambiental e de desenvolvimento).',
 'Doutrina das gerações de direitos (direitos de solidariedade/fraternidade)',
 'medio'),

-- Q12: Direitos de quarta geração
(@cat_dh09,
 'Sobre a quarta geração de direitos humanos, é correto afirmar que:',
 'Decorre do movimento sindical do século XIX para garantir o direito de greve.',
 'Refere-se à universalização dos direitos, abordando democracia, informação e pluralismo no contexto da globalização política e econômica.',
 'Trata exclusivamente da bioética e da manipulação do código genético humano.',
 'Reafirma as liberdades negativas contra a intervenção do Estado na economia.',
 'É focada na proteção de direitos estamentais da nobreza e do clero.',
 'B',
 'A alternativa B está correta: a quarta geração de direitos, na classificação de Paulo Bonavides, está ligada à globalização político-econômica e trata da universalização dos direitos fundamentais, da democracia, da informação e do pluralismo. A alternativa A descreve um marco de segunda geração (movimento sindical do século XIX). A alternativa C restringe indevidamente a quarta geração à bioética, tema que é apenas um dos debates correlatos, não sua definição central. A alternativa D descreve a primeira geração (liberdades negativas). A alternativa E é anacrônica e contrária à lógica de qualquer geração de direitos humanos, voltadas à ampliação, e não à manutenção de privilégios estamentais.\n\n📜 Fundamento legal vigente: trata-se de classificação doutrinária (Paulo Bonavides), sem correspondência em dispositivo específico da DUDH ou da CADH, ambos anteriores à consolidação teórica dessa geração de direitos, que ganha corpo a partir da globalização das últimas décadas do século XX.',
 'Doutrina das gerações de direitos (Paulo Bonavides — quarta geração)',
 'medio'),

-- Q13: Internacionalização dos Direitos Humanos e a ONU
(@cat_dh09,
 'O impulso decisivo para o processo de internacionalização dos Direitos Humanos resultou na:',
 'Criação da Liga das Nações para regular o trabalho industrial.',
 'Extinção da soberania dos Estados nacionais em favor de um governo global único.',
 'Fundação da Organização das Nações Unidas (ONU) em 1945 e a subsequente limitação do poder político absoluto dos Estados via tratados.',
 'Restrição da proteção dos indivíduos apenas aos seus próprios ordenamentos jurídicos nacionais.',
 'Proibição do uso de qualquer tipo de força militar, mesmo para fins de paz.',
 'C',
 'A alternativa C está correta: a fundação da ONU, em 1945, ao final da Segunda Guerra Mundial, foi o impulso decisivo para a internacionalização dos Direitos Humanos, ao viabilizar tratados internacionais que passaram a limitar o poder político até então tido como absoluto dos Estados sobre seus nacionais. A alternativa A confunde a ONU com a Liga das Nações, organização anterior (1920) e de escopo distinto. A alternativa B é falsa, pois a ONU jamais extinguiu a soberania dos Estados-membros, que permanece como princípio estruturante das relações internacionais. A alternativa D é o oposto do processo de internacionalização, que amplia, e não restringe, a proteção para além das fronteiras nacionais. A alternativa E não corresponde à Carta da ONU, que disciplina o uso da força (inclusive de forma legítima em certas hipóteses), sem proibi-lo de modo absoluto.\n\n📜 Fundamento legal vigente: trata-se de fato histórico-institucional (fundação da Organização das Nações Unidas, Conferência de São Francisco, 26/06/1945), sem correspondência direta em artigo da DUDH ou da CADH — a DUDH (1948) e, posteriormente, a CADH (1969) são, precisamente, produtos desse processo de internacionalização iniciado com a Carta da ONU.',
 'Fato histórico-institucional (Carta das Nações Unidas, 1945) — fundamento da DUDH e da CADH',
 'facil'),

-- Q14: Tribunal de Nuremberg
(@cat_dh09,
 'O Tribunal de Nuremberg (1945-1946) é considerado um marco na proteção internacional dos Direitos Humanos. Sobre ele, é correto afirmar que:',
 'Foi criado pela Declaração Universal de 1948 para julgar crimes comuns de civis.',
 'Foi estabelecido pelo Acordo de Londres e suas condenações basearam-se no costume internacional, servindo de base para o futuro Tribunal Penal Internacional.',
 'Consistiu em uma corte permanente que funcionou até a década de 1990 sob comando da ONU.',
 'Julgou apenas crimes ambientais ocorridos durante a ocupação nazista.',
 'Foi rejeitado pelo Brasil por violar o princípio da soberania absoluta.',
 'B',
 'A alternativa B está correta: o Tribunal Militar Internacional de Nuremberg foi instituído pelo Acordo de Londres (agosto de 1945), e suas condenações por crimes de guerra e contra a humanidade fundamentaram-se, em boa parte, no costume internacional então vigente, tornando-se referência histórica direta para a criação, décadas depois, do Tribunal Penal Internacional. A alternativa A é cronologicamente impossível, pois Nuremberg funcionou entre 1945-1946, antes da DUDH (1948), e julgou hierarcas nazistas, não civis comuns. A alternativa C é falsa, pois Nuremberg foi um tribunal ad hoc e temporário, extinto ao fim dos julgamentos, e não um órgão permanente da ONU. A alternativa D restringe indevidamente o escopo do tribunal, que julgou crimes contra a paz, crimes de guerra e crimes contra a humanidade, não crimes ambientais. A alternativa E não corresponde à posição histórica do Brasil, que integrou os Aliados na Segunda Guerra e não rejeitou a iniciativa.\n\n📜 Fundamento legal vigente: trata-se de fato histórico-institucional (Acordo de Londres, 08/08/1945, e Estatuto do Tribunal Militar Internacional de Nuremberg), sem correspondência em artigo da DUDH ou da CADH — referido pela doutrina como precedente do moderno Direito Penal Internacional, posteriormente institucionalizado no Tribunal Penal Internacional (Estatuto de Roma, 1998).',
 'Fato histórico-institucional (Acordo de Londres, 1945; Tribunal de Nuremberg) — precedente do TPI',
 'medio'),

-- Q15: Estrutura e idiomas oficiais da ONU (Alto Nível)
(@cat_dh09,
 'Sobre a estrutura e os idiomas oficiais da Organização das Nações Unidas (ONU), é correto afirmar que:',
 'O ingresso de novos membros ocorre por decisão exclusiva do Secretário-Geral.',
 'O árabe foi incorporado posteriormente como idioma oficial da Assembleia Geral, somando-se aos idiomas originais da ONU.',
 'A suspensão de um membro ocorre apenas por motivos de dívidas financeiras.',
 'Inglês e Francês são os únicos idiomas permitidos em debates nos órgãos da ONU.',
 'A expulsão de um membro depende da vontade unânime de todos os países da Assembleia Geral.',
 'B',
 'A alternativa B está correta: quando fundada em 1945, a ONU adotava cinco idiomas oficiais (inglês, francês, espanhol, chinês e russo); o árabe foi incorporado posteriormente como idioma oficial adicional da Assembleia Geral pela Resolução 3190 (XXVIII), de 1973, tendo seu uso sido estendido, ao longo do tempo, aos demais órgãos principais da Organização. A alternativa A é falsa, pois a admissão de novos membros depende de recomendação do Conselho de Segurança e decisão da Assembleia Geral, não de decisão exclusiva do Secretário-Geral. A alternativa C é incompleta, pois a suspensão de direitos de um Estado-membro decorre de ação preventiva ou coercitiva do Conselho de Segurança, não apenas de inadimplência financeira. A alternativa D é falsa diante da existência de seis idiomas oficiais reconhecidos pela ONU. A alternativa E não reflete o procedimento real, que também depende de recomendação do Conselho de Segurança, e não de unanimidade simples da Assembleia.\n\n📜 Fundamento legal vigente: trata-se de matéria institucional disciplinada pela Carta das Nações Unidas (1945) e pelas regras de procedimento de seus órgãos, sem correspondência em artigo da DUDH ou da CADH — atualmente a ONU reconhece seis idiomas oficiais (árabe, chinês, espanhol, francês, inglês e russo), o árabe tendo sido incluído junto à Assembleia Geral pela Resolução 3190 (XXVIII), de 1973.',
 'Carta das Nações Unidas (1945); Res. 3190 (XXVIII)/1973 da Assembleia Geral da ONU',
 'dificil'),

-- Q16: CIJ x TPI (Alto Nível)
(@cat_dh09,
 'Sobre a Corte Internacional de Justiça (CIJ) e o Tribunal Penal Internacional (TPI), é correto afirmar que:',
 'A CIJ julga indivíduos acusados de genocídio, enquanto o TPI resolve disputas territoriais entre Estados.',
 'O TPI é um sistema de justiça complementar que processa e julga indivíduos por crimes graves, enquanto a CIJ soluciona disputas legais entre Estados.',
 'O Brasil não reconhece a jurisdição do TPI por conflitar com a Constituição de 1988.',
 'A CIJ é um órgão temporário e o TPI é um órgão integrante do Secretariado da ONU.',
 'O TPI processa apenas Estados-Partes que violaram tratados comerciais.',
 'B',
 'A alternativa B está correta: a CIJ é o órgão judiciário principal da ONU e soluciona controvérsias jurídicas entre Estados; já o TPI, criado pelo Estatuto de Roma (1998), é um tribunal permanente e complementar às jurisdições penais nacionais, competente para processar e julgar indivíduos por genocídio, crimes de guerra, crimes contra a humanidade e agressão. A alternativa A inverte as competências dos dois órgãos. A alternativa C é falsa, pois o Brasil expressamente aderiu à jurisdição do TPI, inclusive com respaldo constitucional expresso. A alternativa D está incorreta em ambos os pontos: a CIJ é órgão permanente da ONU (não temporário) e o TPI não integra a estrutura da ONU, sendo organização internacional autônoma vinculada por acordo de cooperação. A alternativa E é falsa, pois o TPI julga indivíduos por crimes graves de repercussão internacional, não Estados nem questões comerciais.\n\n📜 Fundamento legal vigente: CRFB, art. 5º, §4º (incluído pela EC nº 45/2004): "O Brasil se submete à jurisdição de Tribunal Penal Internacional a cuja criação tenha manifestado adesão." O TPI foi instituído pelo Estatuto de Roma (1998), incorporado ao direito brasileiro pelo Decreto Legislativo nº 112/2002 e promulgado pelo Decreto nº 4.388/2002; a CIJ é regida pela Carta da ONU (1945) e por seu próprio Estatuto, anexo a essa Carta.',
 'CRFB, art. 5º, §4º (EC 45/2004); Estatuto de Roma do TPI (Decreto 4.388/2002); Carta da ONU (CIJ)',
 'dificil'),

-- Q17: Conselho de Direitos Humanos da ONU
(@cat_dh09,
 'Sobre o Conselho de Direitos Humanos da ONU, é correto afirmar que:',
 'Foi criado em 1945 como o principal órgão judiciário das Nações Unidas.',
 'É subordinado diretamente ao Tribunal Penal Internacional.',
 'Criado em março de 2006, é o sucessor da extinta Comissão de Direitos Humanos das Nações Unidas e integra o corpo de apoio da Assembleia Geral.',
 'Sua única atribuição é o julgamento de crimes de guerra em substituição a Nuremberg.',
 'É composto exclusivamente por delegados de polícia de países desenvolvidos.',
 'C',
 'A alternativa C está correta: o Conselho de Direitos Humanos da ONU foi criado em março de 2006 pela Resolução 60/251 da Assembleia Geral, como órgão subsidiário desta, sucedendo a extinta Comissão de Direitos Humanos das Nações Unidas (criada em 1946). A alternativa A confunde o Conselho com a Corte Internacional de Justiça, criada em 1945 pela Carta da ONU, com natureza judiciária. A alternativa B é falsa, pois o Conselho não guarda relação de subordinação com o TPI, organismo autônomo e distinto. A alternativa D restringe indevidamente as funções do Conselho, que monitora a situação de direitos humanos globalmente (não apenas crimes de guerra) por meio de mecanismos como a Revisão Periódica Universal, sem qualquer vínculo direto com Nuremberg. A alternativa E é falsa, pois o Conselho é composto por 47 Estados-membros eleitos pela Assembleia Geral, com representação geográfica equilibrada, e não por delegados policiais.\n\n📜 Fundamento legal vigente: trata-se de matéria institucional disciplinada pela Resolução 60/251 da Assembleia Geral da ONU (15/03/2006), sem correspondência em artigo específico da DUDH ou da CADH — ambos os documentos são, contudo, parâmetros normativos centrais utilizados pelo Conselho no exercício de suas funções de promoção e proteção dos direitos humanos.',
 'Res. 60/251 da Assembleia Geral da ONU (15/03/2006)',
 'medio'),

-- Q18: Adoção e natureza jurídica da DUDH (Alto Nível)
(@cat_dh09,
 'Sobre a Declaração Universal dos Direitos Humanos (DUDH), adotada em 1948, é correto afirmar que:',
 'Foi adotada por maioria simples, com forte oposição do bloco europeu.',
 'É tecnicamente um tratado internacional vinculante, pois passou por ratificação em todos os parlamentos.',
 'Foi adotada com a aprovação de 48 Estados presentes, sem nenhum voto contrário, e tem natureza jurídica de recomendação (embora reflita hoje o costume internacional).',
 'O preâmbulo da DUDH prioriza a segurança nacional em detrimento da dignidade humana.',
 'A DUDH excluiu o direito à propriedade privada para facilitar a adesão de países socialistas.',
 'C',
 'A alternativa C está correta: a DUDH foi adotada em 10 de dezembro de 1948, pela Resolução 217 A (III) da Assembleia Geral da ONU, com 48 votos favoráveis e nenhum voto contrário (8 abstenções, sem oposição formal); tecnicamente, por se tratar de resolução da Assembleia Geral, e não de tratado submetido a ratificação, sua natureza jurídica originária é de recomendação (soft law), muito embora parte expressiva de seu conteúdo seja hoje reconhecida como costume internacional vinculante. A alternativa A é falsa quanto à existência de oposição formal (houve apenas abstenções, nenhum voto contrário). A alternativa B está incorreta, pois a DUDH não é um tratado sujeito a ratificação, ao contrário da CADH, promulgada no Brasil pelo Decreto 678/1992. A alternativa D é o oposto do que dispõe o preâmbulo, que elege a dignidade humana como fundamento da liberdade, da justiça e da paz. A alternativa E é falsa, pois o art. 17 da DUDH expressamente assegura o direito à propriedade.\n\n📜 Fundamento legal vigente: DUDH, adotada pela Resolução 217 A (III) da Assembleia Geral da ONU, em 10/12/1948, por 48 votos a favor e nenhum contrário (8 abstenções); a Declaração não é tratado internacional em sentido formal, mas resolução da Assembleia Geral de natureza declaratória/recomendatória, cujo conteúdo é hoje amplamente reconhecido como refletindo o costume internacional.',
 'DUDH (Res. 217 A (III) da Assembleia Geral da ONU, 10/12/1948)',
 'dificil'),

-- Q19: DUDH — vedação à tortura (art. 5º)
(@cat_dh09,
 'Os Artigos 1º ao 5º da DUDH estabelecem o núcleo protetivo da dignidade humana. Dentre as proibições expressas nesses artigos, encontra-se:',
 'A proibição da livre manifestação do pensamento.',
 'A proibição da tortura e de penas ou tratamentos cruéis, desumanos ou degradantes.',
 'A vedação ao direito de propriedade coletiva.',
 'A proibição de mudar de nacionalidade ou de religião.',
 'A vedação ao casamento entre pessoas de raças diferentes.',
 'B',
 'A alternativa B está correta e reproduz a literalidade do art. 5º da DUDH. A alternativa A é falsa, pois a Declaração protege, e não proíbe, a livre manifestação do pensamento (art. 19). A alternativa C não corresponde a nenhuma vedação da DUDH, que ao contrário assegura o direito de propriedade "só ou em sociedade com outros" (art. 17). A alternativa D é o oposto do texto da Declaração, que assegura o direito de mudar de nacionalidade (art. 15) e de religião (art. 18). A alternativa E também é falsa, pois a DUDH veda exatamente esse tipo de restrição discriminatória ao casamento, assegurando esse direito "sem qualquer restrição de raça, nacionalidade ou religião" (art. 16).\n\n📜 Fundamento legal vigente: DUDH, art. 5º: "Ninguém será submetido à tortura, nem a tratamento ou castigo cruel, desumano ou degradante." Texto literal e integralmente vigente.',
 'DUDH, art. 5º',
 'facil'),

-- Q20: DUDH — presunção de inocência (art. 11)
(@cat_dh09,
 'O Artigo 11 da DUDH prescreve que:',
 'O acusado deve provar sua inocência diante da autoridade policial.',
 'Toda pessoa acusada de ato delituoso tem o direito de ser presumida inocente até que sua culpabilidade tenha sido provada de acordo com a lei, em julgamento público com as garantias necessárias à defesa.',
 'A prisão arbitrária é um instrumento legítimo de investigação do Estado.',
 'O julgamento secreto é o meio preferencial para crimes graves contra a ordem pública.',
 'Não há direito a defesa técnica em tribunais internacionais.',
 'B',
 'A alternativa B está correta e reproduz o núcleo do art. 11, §1º, da DUDH: presunção de inocência até prova legal da culpabilidade, em julgamento público com garantias de defesa. A alternativa A inverte o ônus da prova, contrariando a presunção de inocência. A alternativa C contraria também o art. 9º da DUDH, que veda a prisão arbitrária. A alternativa D é o oposto do texto, que exige julgamento público, não secreto. A alternativa E nega o próprio conteúdo do art. 11, que assegura "todas as garantias necessárias à sua defesa", das quais a defesa técnica é elemento essencial.\n\n📜 Fundamento legal vigente: DUDH, art. 11, §1º: "Todo ser humano acusado de um ato delituoso tem o direito de ser presumido inocente até que a sua culpabilidade tenha sido provada de acordo com a lei, em julgamento público no qual lhe tenham sido asseguradas todas as garantias necessárias à sua defesa." Texto literal e integralmente vigente.',
 'DUDH, art. 11, §1º',
 'facil'),

-- Q21: DUDH — asilo e nacionalidade (arts. 14 e 15)
(@cat_dh09,
 'Sobre a liberdade de locomoção e o direito de asilo na DUDH, é correto afirmar que:',
 'O direito de asilo pode ser invocado por qualquer pessoa, inclusive por crimes de direito comum.',
 'Toda pessoa tem o direito de deixar qualquer país, inclusive o próprio, mas não tem o direito de a este regressar.',
 'O direito de asilo não pode ser invocado em caso de perseguição legitimamente motivada por crimes de direito comum ou por atos contrários aos princípios da ONU.',
 'A nacionalidade é uma concessão discricionária do Estado, podendo ser retirada por motivos políticos.',
 'A DUDH proíbe a mudança de nacionalidade para evitar a evasão de divisas.',
 'C',
 'A alternativa C está correta e reproduz a ressalva do art. 14, §2º, da DUDH quanto ao direito de asilo. A alternativa A ignora exatamente essa ressalva legal. A alternativa B contraria o art. 13, §2º, que assegura também o direito de regressar ao próprio país, não apenas de dele sair. A alternativa D contraria o art. 15, §2º, que veda a privação arbitrária de nacionalidade, inclusive por motivos políticos. A alternativa E não encontra qualquer amparo no texto da Declaração, que trata da nacionalidade sob a ótica da dignidade da pessoa, não de controle cambial.\n\n📜 Fundamento legal vigente: DUDH, art. 14, §2º: "Esse direito [de asilo] não pode ser invocado em caso de perseguição legitimamente motivada por crimes de direito comum ou por atos contrários aos objetivos e princípios das Nações Unidas." c/c art. 15: "1. Todo ser humano tem direito a uma nacionalidade. 2. Ninguém será arbitrariamente privado de sua nacionalidade, nem do direito de mudar de nacionalidade."',
 'DUDH, arts. 14, §2º, e 15',
 'medio'),

-- Q22: DUDH — família e propriedade (arts. 16 e 17)
(@cat_dh09,
 'A DUDH protege a família e a propriedade nos seguintes termos:',
 'A família é o núcleo natural e fundamental da sociedade, e o casamento exige o livre e pleno consentimento dos nubentes.',
 'O direito à propriedade é garantido apenas se houver uso exclusivo e individual.',
 'O Estado pode impor o casamento forçado se houver interesse demográfico.',
 'Homens e mulheres têm direitos desiguais em relação à dissolução do casamento.',
 'A propriedade privada pode ser confiscada arbitrariamente para fins de segurança pública.',
 'A',
 'A alternativa A está correta e reproduz o núcleo dos arts. 16, §§1º e 3º, da DUDH. A alternativa B é falsa, pois o art. 17, §1º, garante a propriedade tanto individual quanto em sociedade com outros, não exigindo uso exclusivo. A alternativa C é o oposto do art. 16, §2º, que exige o livre e pleno consentimento dos nubentes, vedando qualquer forma de casamento forçado. A alternativa D contraria o art. 16, §1º, que assegura "iguais direitos" entre homens e mulheres quanto ao casamento, sua duração e dissolução. A alternativa E contraria o art. 17, §2º, que veda a privação arbitrária da propriedade.\n\n📜 Fundamento legal vigente: DUDH, art. 16, §1º: "Os homens e mulheres de maior idade (...) têm o direito de contrair matrimônio e fundar uma família. Gozam de iguais direitos em relação ao casamento, sua duração e sua dissolução"; §3º: "A família é o núcleo natural e fundamental da sociedade e tem direito à proteção da sociedade e do Estado." Art. 17: "1. Todo ser humano tem direito à propriedade, só ou em sociedade com outros. 2. Ninguém será arbitrariamente privado de sua propriedade."',
 'DUDH, arts. 16 e 17',
 'facil'),

-- Q23: DUDH — direitos sociais (arts. 23, 24, 25 e 26)
(@cat_dh09,
 'No tocante aos Direitos Sociais previstos na DUDH, é correto afirmar que:',
 'A instrução elementar é um direito, mas deve ser paga pelos pais.',
 'Toda pessoa tem direito a repouso e lazer, inclusive a férias periódicas remuneradas.',
 'O direito ao trabalho não inclui a proteção contra o desemprego.',
 'A organização de sindicatos é uma faculdade que o Estado pode proibir livremente.',
 'A maternidade e a infância não possuem assistência especial prevista na Declaração.',
 'B',
 'A alternativa B está correta e reproduz o art. 24 da DUDH. A alternativa A contraria o art. 26, §1º, que determina que a instrução elementar será gratuita e obrigatória. A alternativa C é falsa, pois o art. 23, §1º, inclui expressamente a proteção contra o desemprego no direito ao trabalho. A alternativa D contraria o art. 23, §4º, que assegura o direito de organizar e ingressar em sindicatos. A alternativa E é falsa, pois o art. 25, §2º, assegura expressamente cuidados e assistência especiais à maternidade e à infância.\n\n📜 Fundamento legal vigente: DUDH, art. 24: "Todo ser humano tem direito a repouso e lazer, inclusive a limitação razoável das horas de trabalho e a férias remuneradas periódicas." c/c art. 26, §1º: "Todo ser humano tem direito à instrução. A instrução será gratuita, pelo menos nos graus elementares e fundamentais. A instrução elementar será obrigatória."',
 'DUDH, arts. 24 e 26',
 'medio'),

-- Q24: CADH — ratificação pelo Brasil e proteção de pessoa física (Alto Nível)
(@cat_dh09,
 'A Convenção Americana sobre Direitos Humanos (CADH), o Pacto de São José da Costa Rica, foi incorporada ao ordenamento jurídico brasileiro da seguinte forma:',
 'O Brasil ratificou a CADH em 1988, imediatamente após a promulgação da Constituição.',
 'A CADH protege tanto pessoas físicas quanto pessoas jurídicas que atuam na região.',
 'O Brasil promulgou a CADH por meio do Decreto nº 678/1992, e o tratado estabelece que sua proteção não abrange pessoas jurídicas.',
 'Os Estados-Partes são desobrigados de adotar medidas legislativas internas, valendo apenas o texto internacional.',
 'A CADH veda a proteção da vida antes do nascimento.',
 'C',
 'A alternativa C está correta: o Brasil depositou a Carta de Adesão à CADH em 25 de setembro de 1992, e o tratado foi promulgado internamente pelo Decreto nº 678, de 6 de novembro de 1992; a própria Convenção restringe sua proteção à pessoa humana, excluindo pessoas jurídicas. A alternativa A é falsa quanto à data: a adesão brasileira ocorreu apenas em 1992, e não em 1988. A alternativa B contraria diretamente o art. 1º, §2º, da CADH. A alternativa D é falsa, pois o art. 2º da CADH exige expressamente a adoção de medidas legislativas ou de outra natureza no direito interno quando necessário para tornar efetivos os direitos e liberdades. A alternativa E é o oposto do art. 4º, §1º, que protege a vida "em geral, desde o momento da concepção".\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 1º, §2º: "Para os efeitos desta Convenção, pessoa é todo ser humano" — dispositivo interpretado pela doutrina e jurisprudência como delimitador da proteção convencional às pessoas físicas, excluindo as jurídicas. O Decreto nº 678/1992 promulgou a Convenção no Brasil, após adesão depositada em 25/09/1992.',
 'CADH (Decreto 678/1992), art. 1º, §2º; Decreto 678/1992',
 'dificil'),

-- Q25: CADH — direito à vida e restrições à pena de morte (Alto Nível)
(@cat_dh09,
 'Sobre o Direito à Vida na CADH e as restrições à aplicação da pena de morte, é correto afirmar que:',
 'A pena de morte pode ser aplicada a crimes políticos ou a crimes comuns conexos com crimes políticos.',
 'Estados que já aboliram a pena de morte podem restabelecê-la para crimes hediondos.',
 'Não se deve aplicar a pena de morte a pessoas que, no momento da perpetração do delito, eram menores de 18 anos ou maiores de 70 anos, nem a mulheres grávidas.',
 'O condenado à morte não tem direito de solicitar indulto ou anistia.',
 'A pena de morte pode ser executada mesmo se houver pedido de comutação pendente de decisão.',
 'C',
 'A alternativa C está correta e reproduz literalmente o art. 4º, §5º, da CADH. A alternativa A contraria o art. 4º, §4º, que veda expressamente a pena de morte para delitos políticos ou comuns conexos a delitos políticos. A alternativa B contraria o art. 4º, §3º, que proíbe o restabelecimento da pena de morte em Estados que já a hajam abolido. A alternativa D é falsa, pois o art. 4º, §6º, assegura ao condenado o direito de solicitar anistia, indulto ou comutação da pena. A alternativa E também contraria o art. 4º, §6º, que veda a execução enquanto o pedido de comutação estiver pendente de decisão.\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 4º, §5º: "Não se deve impor a pena de morte a pessoa que, no momento da perpetração do delito, for menor de dezoito anos, ou maior de setenta, nem aplicá-la a mulher em estado de gravidez." Texto literal e integralmente vigente, complementado pelos §§3º, 4º e 6º do mesmo artigo.',
 'CADH (Decreto 678/1992), art. 4º, §§3º a 6º',
 'dificil'),

-- Q26: CADH — integridade pessoal e condições de detenção
(@cat_dh09,
 'Em relação à Integridade Pessoal e às condições de detenção, a CADH estabelece que:',
 'Os processados devem, obrigatoriamente, ser mantidos nas mesmas celas que os condenados.',
 'As penas privativas de liberdade devem ter por finalidade essencial a retribuição punitiva rigorosa.',
 'Os menores processados devem ser separados dos adultos e conduzidos a tribunal especializado com a maior rapidez possível.',
 'A integridade moral não é objeto de proteção da Convenção, apenas a física.',
 'O Estado não tem o dever de tratar pessoas privadas de liberdade com respeito.',
 'C',
 'A alternativa C está correta e reproduz o art. 5º, §5º, da CADH. A alternativa A é o oposto do art. 5º, §4º, que exige a separação entre processados e condenados, salvo circunstâncias excepcionais. A alternativa B contraria o art. 5º, §6º, segundo o qual a finalidade essencial das penas privativas de liberdade é a reforma e a readaptação social dos condenados, não a mera retribuição punitiva. A alternativa D contraria o art. 5º, §1º, que protege expressamente a integridade física, psíquica e moral. A alternativa E é falsa, pois o mesmo artigo assegura que toda pessoa privada de liberdade seja tratada "com o respeito devido à dignidade inerente ao ser humano" (art. 5º, §2º).\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 5º, §5º: "Os menores, quando puderem ser processados, devem ser separados dos adultos e conduzidos a tribunal especializado, com a maior rapidez possível, para seu tratamento." c/c §4º (separação processados/condenados) e §6º (finalidade de reforma e readaptação social da pena).',
 'CADH (Decreto 678/1992), art. 5º, §§4º a 6º',
 'medio'),

-- Q27: CADH — proibição de escravidão e exceções ao trabalho forçado (Alto Nível)
(@cat_dh09,
 'A CADH proíbe a escravidão, o tráfico de mulheres e o trabalho forçado, ressalvando como exceção:',
 'Trabalho exigido de recluso sob controle de autoridade pública, desde que posto à disposição de empresa privada.',
 'Trabalho ou serviço que faça parte das obrigações cívicas normais.',
 'Servidão por dívida civil contraída com o Estado.',
 'Serviço militar obrigatório, independentemente de isenção por consciência prevista em lei.',
 'Trabalho infantil em atividades domésticas perigosas.',
 'B',
 'A alternativa B está correta e reproduz a alínea "d" do art. 6º, §3º, da CADH. A alternativa A é falsa, pois a Convenção exige que o trabalho do recluso seja executado sob vigilância e controle das autoridades públicas, vedando expressamente que os indivíduos sejam postos à disposição de particulares ou empresas privadas. A alternativa C confunde a exceção convencional (que trata de serviço militar, calamidade e obrigações cívicas) com servidão por dívida, instituto vedado, e não excepcionado, pela própria CADH (art. 7º, §7º, proíbe a detenção por dívida, ressalvada apenas a obrigação alimentar). A alternativa D contraria a alínea "b" do art. 6º, §3º, que ressalva expressamente a isenção por motivos de consciência quando prevista em lei. A alternativa E não encontra qualquer amparo na Convenção, que jamais excepciona trabalho infantil perigoso.\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 6º, §3º: não constituem trabalhos forçados ou obrigatórios "a) os trabalhos ou serviços normalmente exigidos de pessoa reclusa em cumprimento de sentença (...), executados sob a vigilância e controle das autoridades públicas (...), sem serem postos à disposição de particulares, companhias ou pessoas jurídicas de caráter privado; b) o serviço militar e, nos países onde se admite a isenção por motivos de consciência, o serviço nacional que a lei estabelecer em lugar daquele; c) o serviço imposto em casos de perigo ou calamidade; e d) o trabalho ou serviço que faça parte das obrigações cívicas normais."',
 'CADH (Decreto 678/1992), art. 6º, §3º',
 'dificil'),

-- Q28: CADH — liberdade pessoal e audiência de custódia (Alto Nível)
(@cat_dh09,
 'Sobre o Direito à Liberdade Pessoal e as garantias do detido (audiência de custódia), a CADH determina que:',
 'Ninguém pode ser detido por dívida, sem qualquer ressalva.',
 'A pessoa detida ou retida deve ser conduzida, sem demora, à presença de um juiz ou outra autoridade autorizada por lei a exercer funções judiciais.',
 'O recurso para decidir sobre a legalidade da prisão só pode ser interposto pela própria pessoa detida.',
 'A prisão por inadimplemento de obrigação alimentar é vedada pelo pacto.',
 'O detido não tem o direito de ser notificado das acusações formuladas contra si na fase policial.',
 'B',
 'A alternativa B está correta e reproduz o art. 7º, §5º, da CADH — dispositivo que fundamenta, no direito interno brasileiro, o instituto da audiência de custódia. A alternativa A é incompleta, pois o próprio art. 7º, §7º, ressalva a hipótese de inadimplemento de obrigação alimentar. A alternativa C contraria o mesmo §6º do art. 7º, que admite que o recurso (habeas corpus) seja interposto pela própria pessoa ou por outra pessoa em seu favor. A alternativa D é o oposto do texto convencional, que expressamente não veda a prisão por dívida alimentar. A alternativa E contraria o art. 7º, §4º, que assegura a notificação sem demora da acusação formulada.\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 7º, §5º: "Toda pessoa detida ou retida deve ser conduzida, sem demora, à presença de um juiz ou outra autoridade autorizada pela lei a exercer funções judiciais e tem direito a ser julgada dentro de um prazo razoável ou a ser posta em liberdade (...)." c/c §6º (habeas corpus, recurso por si ou por outrem) e §7º (proibição de prisão por dívida, salvo obrigação alimentar).',
 'CADH (Decreto 678/1992), art. 7º, §§4º a 7º',
 'dificil'),

-- Q29: CADH — garantias judiciais e princípio da legalidade
(@cat_dh09,
 'As Garantias Judiciais (Art. 8º) e o Princípio da Legalidade (Art. 9º) da CADH preveem que:',
 'O acusado pode ser obrigado a depor contra si mesmo se houver provas materiais.',
 'Ninguém pode ser condenado por ações ou omissões que, no momento em que foram cometidas, não eram delituosas segundo o direito aplicável.',
 'A lei penal pode retroagir para aplicar pena mais grave se houver comoção social.',
 'O direito de ser assistido por tradutor gratuito só existe se o acusado possuir renda mínima.',
 'A indenização por erro judiciário é devida em qualquer fase do processo, mesmo antes do trânsito em julgado.',
 'B',
 'A alternativa B está correta e reproduz o princípio da legalidade e da retroatividade do art. 9º da CADH. A alternativa A contraria o art. 8º, §2º, alínea "g", que assegura o direito de não ser obrigado a depor contra si mesmo nem a se declarar culpado. A alternativa C é o oposto do art. 9º, que veda a retroatividade da lei penal mais gravosa, admitindo apenas a retroatividade benéfica (lei posterior que comine pena mais leve). A alternativa D contraria o art. 8º, §2º, alínea "a", que garante assistência gratuita de tradutor ou intérprete a qualquer acusado que não compreenda o idioma do juízo, sem exigência de comprovação de renda. A alternativa E contraria o art. 10, que condiciona o direito à indenização à existência de sentença condenatória transitada em julgado por erro judiciário.\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 9º: "Ninguém pode ser condenado por ações ou omissões que, no momento em que forem cometidas, não sejam delituosas, de acordo com o direito aplicável. Tampouco se pode impor pena mais grave que a aplicável no momento da perpetração do delito. Se depois da perpetração do delito a lei dispuser a imposição de pena mais leve, o delinquente será por isso beneficiado." c/c art. 8º (garantias judiciais mínimas) e art. 10 (direito a indenização por erro judiciário).',
 'CADH (Decreto 678/1992), arts. 8º, 9º e 10',
 'medio'),

-- Q30: CADH — direitos políticos e situação de estrangeiros (Alto Nível)
(@cat_dh09,
 'Em relação aos Direitos Políticos e à situação de estrangeiros na CADH, é correto afirmar que:',
 'É permitida a expulsão coletiva de estrangeiros em situações de crise econômica.',
 'O direito de reunião é reconhecido, desde que exercido de forma pacífica e sem armas.',
 'O estrangeiro pode ser expulso para qualquer país, mesmo que sua vida corra risco por suas opiniões políticas.',
 'O acesso às funções públicas de um país é restrito aos cidadãos natos, sem exceções.',
 'O direito de associação é limitado exclusivamente a fins políticos.',
 'B',
 'A alternativa B está correta e reproduz o art. 15 da CADH. A alternativa A contraria o art. 22, §9º, que proíbe, de forma absoluta e sem ressalvas, a expulsão coletiva de estrangeiros. A alternativa C contraria o art. 22, §8º, que veda a expulsão ou entrega do estrangeiro a país onde seu direito à vida ou à liberdade pessoal esteja em risco por razão de raça, nacionalidade, religião, condição social ou opiniões políticas (princípio do non-refoulement). A alternativa D contraria o art. 23, §1º, alínea "c", que assegura o acesso às funções públicas em condições gerais de igualdade, podendo a lei regulamentar o exercício apenas por critérios objetivos (idade, nacionalidade, residência, idioma, instrução, capacidade civil/mental ou condenação penal), não por exclusão absoluta de naturalizados. A alternativa E contraria o art. 16 da CADH, que reconhece a liberdade de associação para fins ideológicos, religiosos, políticos, econômicos, trabalhistas, sociais, culturais, desportivos ou de qualquer outra natureza.\n\n📜 Fundamento legal vigente: CADH (Decreto 678/1992), art. 15: "É reconhecido o direito de reunião pacífica e sem armas (...)." c/c art. 22, §§6º a 9º (direito de circulação e de residência, vedação à expulsão coletiva e ao non-refoulement) e art. 23 (direitos políticos).',
 'CADH (Decreto 678/1992), arts. 15, 22 e 23',
 'dificil');

SET foreign_key_checks = 1;
