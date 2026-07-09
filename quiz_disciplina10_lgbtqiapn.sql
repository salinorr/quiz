-- ============================================================
-- QUIZ — Disciplina 10/20 do CHO: Direitos da Comunidade LGBTQIAPN+
-- 30 questões — dupla justificativa (doutrina/apostila + legislação/jurisprudência vigente)
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: Caderno de Questões — Direitos da Comunidade LGBTQIAPN+
--   (Academia Coronel Walterler) — Bloco I: questões integradas do material original;
--   Bloco II: conceitos e identidade; Bloco III: legislação e tratados;
--   Bloco IV: decretos e resoluções; Bloco V: jurisprudência do STF
-- Base legal vigente: CF/88 art. 3º, IV e art. 227; Lei Maria da Penha (Lei 11.340/2006);
--   Lei 9.029/1995; Decreto 8.727/2016; Resolução CNJ 270/2018; Resolução CNJ 348/2020;
--   Portaria 1.820/2009-CNS; Convenções OIT 111 e 190; DUDH art. 23;
--   Princípios de Yogyakarta (2007); Resolução 12/2015-CNCD/LGBT; Portaria PGR/MPU 104/2014;
--   Regras de Bangkok (ONU, 2010); STF: ADI 4277/ADPF 132; ADO 26/MI 4733;
--   RE 670.422 (Tema 761)/ADI 4275; CNJ Provimento 73/2018; RE 646.721 (Tema 498)
-- ============================================================
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

INSERT IGNORE INTO categorias (nome, descricao)
VALUES ('Direitos da Comunidade LGBTQIAPN+ — CHO 10', 'Disciplina 10/20 do CHO — Conceitos de sexo/gênero, jurisprudência do STF sobre união homoafetiva, criminalização da LGBTfobia e identidade de gênero, nome social e normas administrativas de proteção à população LGBTQIAPN+');

SET @cat_lg10 = (SELECT id FROM categorias WHERE nome = 'Direitos da Comunidade LGBTQIAPN+ — CHO 10' LIMIT 1);

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: ADO 26/MI 4733 — criminalização da homofobia e transfobia
(@cat_lg10,
 'Em 2019, o Supremo Tribunal Federal (STF) tomou uma decisão histórica sobre a homofobia e a transfobia no Brasil. Qual foi o entendimento firmado?',
 'Tornou obrigatória a contratação de pessoas trans em empresas públicas.',
 'Criminalizou a homofobia e a transfobia, equiparando-as ao crime de racismo até que o Congresso edite lei específica.',
 'Instituiu o casamento homoafetivo por lei ordinária.',
 'Proibiu qualquer menção a gênero nas escolas.',
 NULL,
 'B',
 'A alternativa B está correta: em 13/06/2019, no julgamento conjunto da ADO 26 e do MI 4733, o STF reconheceu a omissão inconstitucional do Congresso Nacional em editar lei que criminalizasse a homofobia e a transfobia e determinou, enquanto perdurar essa lacuna legislativa, que tais condutas sejam enquadradas nos tipos penais da Lei do Racismo (Lei nº 7.716/1989). A alternativa A está incorreta porque o STF não impôs cotas ou obrigatoriedade de contratação de pessoas trans no serviço público, tema tratado por normas administrativas específicas (como o Decreto nº 8.727/2016), e não pela decisão de 2019. A alternativa C está incorreta pois o casamento homoafetivo não foi instituído por lei ordinária, mas viabilizado por decisão do STF (ADI 4277/ADPF 132) e por resolução do CNJ. A alternativa D é falsa, pois a decisão trata da criminalização de condutas discriminatórias, sem qualquer determinação sobre currículo escolar.\n\n📜 Fundamento legal vigente: STF, ADO 26/DF e MI 4733/DF, julgamento de 13/06/2019 (rel. Min. Celso de Mello e Min. Edson Fachin) — reconheceu a mora inconstitucional do Congresso Nacional e determinou a aplicação dos tipos penais da Lei nº 7.716/1989 (Lei do Racismo) às condutas homofóbicas e transfóbicas, até que sobrevenha legislação específica.',
 'STF, ADO 26/MI 4733 (2019); Lei 7.716/1989',
 'facil'),

-- Q02: ADI 4277/ADPF 132 — união estável homoafetiva
(@cat_lg10,
 'Sobre o reconhecimento da união estável e do casamento entre pessoas do mesmo sexo no Brasil:',
 'Apenas a união estável é reconhecida, mas não o casamento.',
 'O casamento é reconhecido, mas não dá direito à adoção.',
 'O STF reconheceu a união estável homoafetiva como entidade familiar, garantindo os mesmos direitos dos casais heterossexuais.',
 'O casamento homoafetivo só é permitido em alguns estados.',
 NULL,
 'C',
 'A alternativa C está correta: no julgamento conjunto da ADI 4277 e da ADPF 132 (05/05/2011), o STF, por unanimidade, reconheceu a união estável entre pessoas do mesmo sexo como entidade familiar, aplicando-lhe o mesmo regramento da união estável heteroafetiva, com os mesmos direitos e deveres. A alternativa A está incorreta porque, a partir dessa decisão e da posterior Resolução nº 175/2013 do CNJ, também o casamento civil (e não apenas a união estável) passou a ser garantido aos casais do mesmo sexo em todo o território nacional. A alternativa B é falsa, pois os efeitos da equiparação abrangem também o direito à adoção conjunta. A alternativa D está incorreta porque a decisão do STF e a resolução do CNJ têm eficácia nacional, vinculando todos os cartórios do país, e não apenas alguns estados.\n\n📜 Fundamento legal vigente: STF, ADI 4277 e ADPF 132 (rel. Min. Ayres Britto, j. 05/05/2011) — reconheceu a união homoafetiva como entidade familiar por interpretação conforme a Constituição do art. 1.723 do Código Civil; CNJ, Resolução nº 175/2013, veda às autoridades competentes a recusa de habilitação, celebração de casamento civil ou de conversão de união estável em casamento entre pessoas do mesmo sexo.',
 'STF, ADI 4277/ADPF 132 (2011); CNJ, Resolução 175/2013',
 'facil'),

-- Q03: RE 670.422/ADI 4275 — retificação de registro civil
(@cat_lg10,
 'No que diz respeito ao direito à identidade de gênero, o STF e o CNJ garantem que pessoas transgênero podem:',
 'Alterar o nome e o gênero no registro civil diretamente em cartório, sem necessidade de cirurgia ou autorização judicial.',
 'Alterar o nome apenas se comprovarem cirurgia de redesignação sexual.',
 'Utilizar o nome social apenas na rede privada.',
 'Mudar de nome, mas mantendo o gênero biológico nos documentos.',
 NULL,
 'A',
 'A alternativa A está correta: no julgamento do RE 670.422 (Tema 761 de repercussão geral), em conjunto com a ADI 4275, o STF fixou a tese de que a pessoa transgênero tem direito subjetivo à alteração de prenome e de gênero no registro civil, independentemente de cirurgia de transgenitalização ou de autorização judicial, bastando a manifestação de vontade do indivíduo, podendo o pedido ser formulado diretamente em cartório. A alternativa B contraria frontalmente essa tese, que dispensa expressamente a cirurgia. A alternativa C está incorreta, pois o nome social deve ser reconhecido também no âmbito público (administração federal, saúde, educação, Judiciário). A alternativa D é falsa, pois a alteração abrange tanto o prenome quanto a classificação de gênero no registro civil.\n\n📜 Fundamento legal vigente: STF, RE 670.422 (Tema 761) e ADI 4275 (j. 15/08/2018) — reconheceram o direito de pessoas transgênero à retificação de prenome e gênero no registro civil sem exigência de cirurgia ou de decisão judicial; CNJ, Provimento nº 73/2018, regulamentou o procedimento administrativo de retificação diretamente nos cartórios de registro civil.',
 'STF, RE 670.422 (Tema 761); ADI 4275; CNJ, Provimento 73/2018',
 'medio'),

-- Q04: Lei Maria da Penha e casais homoafetivos
(@cat_lg10,
 'A Lei Maria da Penha (Lei 11.340/2006) protege casais homoafetivos?',
 'Não, a lei é restrita a casais homem-mulher.',
 'Sim, a lei protege casais homoafetivos, especificamente a união entre duas mulheres.',
 'Apenas em casos de violência física grave.',
 'Sim, mas apenas se houver casamento civil formalizado.',
 NULL,
 'B',
 'A alternativa B está correta: a Lei Maria da Penha tem como sujeito passivo a mulher, entendida em sua identidade de gênero, e o art. 5º, parágrafo único, estabelece expressamente que as relações pessoais protegidas pela lei independem de orientação sexual, o que abrange a violência doméstica entre duas mulheres em relação íntima de afeto. A alternativa A contraria a literalidade do parágrafo único do art. 5º. A alternativa C está incorreta, pois a lei protege a mulher também contra violência psicológica, sexual, patrimonial e moral, não apenas a física. A alternativa D é falsa, pois a proteção alcança qualquer relação íntima de afeto, com ou sem coabitação e independentemente de casamento civil.\n\n📜 Fundamento legal vigente: Lei nº 11.340/2006 (Lei Maria da Penha), art. 5º, parágrafo único: "As relações pessoais enunciadas neste artigo independem de orientação sexual." O caput do art. 5º reconhece como violência doméstica qualquer ação ou omissão baseada no gênero praticada no âmbito da unidade doméstica, da família ou em qualquer relação íntima de afeto.',
 'Lei 11.340/2006 (Lei Maria da Penha), art. 5º, parágrafo único',
 'medio'),

-- Q05: Desafios atuais — dados sobre LGBTfobia
(@cat_lg10,
 'Qual das alternativas abaixo representa um desafio atual para a garantia dos direitos LGBTQIA+ no Brasil?',
 'A falta de legislação contra a discriminação em locais públicos.',
 'A igualdade total de representação política.',
 'A necessidade de maior produção de dados desagregados sobre violência motivada por identidade de gênero (LGBTfobia).',
 'A proibição de casamentos homoafetivos em cartórios.',
 NULL,
 'C',
 'A alternativa C está correta: um dos principais desafios apontados pela doutrina e por órgãos de direitos humanos é a subnotificação e a ausência de dados oficiais desagregados por identidade de gênero e orientação sexual sobre a violência LGBTfóbica, o que dificulta o desenho de políticas públicas eficazes. A alternativa A está incorreta, pois já existe proteção legal (por equiparação jurisprudencial à Lei do Racismo, desde a ADO 26). A alternativa B, embora relevante, não é o desafio central apontado pelo material, que enfatiza a produção de dados. A alternativa D é falsa, pois não existe proibição de casamento homoafetivo em cartórios — pelo contrário, a Resolução CNJ 175/2013 obriga a celebração.\n\n📜 Fundamento legal vigente: trata-se de constatação doutrinária/de política pública sobre a subnotificação de crimes de ódio contra a população LGBTQIAPN+, sem correspondência em dispositivo legal específico que imponha a produção de dados — a análise decorre de relatórios de órgãos de direitos humanos e da doutrina que acompanha a aplicação da ADO 26 e da Lei nº 7.716/1989.',
 'Doutrina sobre dados e políticas públicas de enfrentamento à LGBTfobia; ADO 26',
 'medio'),

-- Q06: Reconhecimento da família homoafetiva
(@cat_lg10,
 'Sobre o reconhecimento jurídico da família homoafetiva no Brasil:',
 'Casais do mesmo sexo só podem realizar união estável, sem direito a casamento civil.',
 'O STF reconheceu a união estável homoafetiva e estendeu direitos civis a casais do mesmo sexo, equiparando ao casamento heterossexual.',
 'Adoção por casais LGBTQIA+ ainda é proibida no Brasil.',
 'Constituição de 1988 proíbe expressamente a união entre pessoas do mesmo sexo.',
 NULL,
 'B',
 'A alternativa B está correta e reitera o entendimento fixado na ADI 4277/ADPF 132, posteriormente ampliado pela Resolução CNJ 175/2013 para alcançar também o casamento civil. A alternativa A está incorreta, pois, desde 2013, casais do mesmo sexo podem se casar civilmente em qualquer cartório do país. A alternativa C é falsa, pois a adoção por casais homoafetivos é plenamente admitida, sendo vedada a discriminação do adotante ou pretendente em razão da orientação sexual. A alternativa D é incorreta porque a Constituição de 1988 não contém qualquer vedação expressa à união entre pessoas do mesmo sexo; ao contrário, o STF fundamentou o reconhecimento da união homoafetiva justamente nos princípios constitucionais da dignidade da pessoa humana, da igualdade e da liberdade.\n\n📜 Fundamento legal vigente: STF, ADI 4277 e ADPF 132 (2011); CNJ, Resolução nº 175/2013 (obriga a celebração de casamento civil e a conversão de união estável em casamento entre pessoas do mesmo sexo); jurisprudência consolidada admite a adoção por casais homoafetivos em igualdade de condições com casais heteroafetivos.',
 'STF, ADI 4277/ADPF 132; CNJ, Resolução 175/2013',
 'facil'),

-- Q07: Identidade de gênero — nome social e SUS
(@cat_lg10,
 'A respeito do direito à identidade de gênero:',
 'A alteração de prenome e gênero no registro civil exige cirurgia de redesignação sexual.',
 'O uso do nome social não é reconhecido no Sistema Único de Saúde (SUS).',
 'O STF decidiu que não há mais necessidade de autorização judicial ou cirurgia para a mudança de nome/gênero de pessoas trans, podendo ser feita diretamente no cartório.',
 'A legislação brasileira não permite a mudança de nome para travestis.',
 NULL,
 'C',
 'A alternativa C está correta e reproduz a tese fixada no RE 670.422 (Tema 761) e na ADI 4275: a retificação de prenome e gênero no registro civil de pessoas trans pode ser feita diretamente em cartório, sem necessidade de cirurgia ou de decisão judicial. A alternativa A contraria diretamente essa tese. A alternativa B está incorreta, pois a Portaria nº 1.820/2009 do Conselho Nacional de Saúde assegura o uso do nome social no atendimento do SUS. A alternativa D é falsa, pois tanto travestis quanto pessoas transexuais têm assegurado o direito à retificação do nome, seja pela via administrativa (cartório), seja pela via judicial, se preferirem.\n\n📜 Fundamento legal vigente: STF, RE 670.422 (Tema 761) e ADI 4275 (j. 15/08/2018); CNJ, Provimento nº 73/2018; Portaria nº 1.820/2009 do Conselho Nacional de Saúde, que garante o uso do nome social no atendimento do SUS.',
 'STF, RE 670.422 (Tema 761); ADI 4275; Portaria 1.820/2009-CNS',
 'medio'),

-- Q08: Criminalização da violência LGBTfóbica
(@cat_lg10,
 'Sobre a criminalização da violência contra a população LGBTQIA+:',
 'A homofobia e a transfobia são crimes equiparados ao racismo por decisão do STF.',
 'Não há qualquer proteção criminal específica contra a violência baseada na orientação sexual.',
 'A Lei Maria da Penha não se aplica a relacionamentos lésbicos.',
 'O Brasil ainda não possui jurisprudência sobre crimes de ódio contra LGBTQIA+.',
 NULL,
 'A',
 'A alternativa A está correta, reiterando o entendimento fixado na ADO 26/MI 4733: até que o Congresso Nacional edite lei específica, condutas homofóbicas e transfóbicas são enquadradas nos tipos penais da Lei nº 7.716/1989 (Lei do Racismo), e o homicídio motivado por homofobia ou transfobia passa a ser considerado circunstância que o qualifica, por configurar motivo torpe. A alternativa B contraria diretamente essa decisão. A alternativa C é falsa, conforme visto na questão 4, já que o art. 5º, parágrafo único, da Lei Maria da Penha expressamente independe de orientação sexual. A alternativa D está incorreta, pois a decisão do STF na ADO 26 é precisamente o precedente vinculante sobre o tema.\n\n📜 Fundamento legal vigente: STF, ADO 26/DF e MI 4733/DF (j. 13/06/2019); Lei nº 7.716/1989 (Lei do Racismo), aplicável por extensão às condutas homofóbicas e transfóbicas; CP, art. 121, §2º (qualificadoras do homicídio, aplicável quando o motivo for a LGBTfobia, por analogia ao motivo torpe).',
 'STF, ADO 26/MI 4733 (2019); Lei 7.716/1989',
 'facil'),

-- Q09: Autodeclaração da identidade de gênero
(@cat_lg10,
 'A respeito da identidade de gênero, o STF e as instâncias superiores brasileiras reconhecem que:',
 'O direito à identidade de gênero é garantido apenas após a maioridade penal.',
 'O nome social pode ser usado apenas em ambientes privados.',
 'A identidade de gênero é uma autodeclaração e deve ser respeitada, permitindo a alteração documental mesmo sem tratamentos médicos.',
 'Pessoas transgênero devem usar o nome de registro em provas como o Enem.',
 NULL,
 'C',
 'A alternativa C está correta: a jurisprudência do STF adota o critério da autodeclaração (autopercepção) da identidade de gênero como suficiente para o reconhecimento jurídico, dispensando qualquer comprovação médica, laudo psicológico ou intervenção cirúrgica. A alternativa A é falsa, pois não há vinculação do direito à identidade de gênero à maioridade penal. A alternativa B contraria a diretriz de reconhecimento do nome social também em órgãos e serviços públicos. A alternativa D está incorreta, pois o Inep, seguindo a diretriz de reconhecimento da identidade de gênero autodeclarada, passou a permitir o uso do nome social de candidatos trans e travestis em exames como o Enem.\n\n📜 Fundamento legal vigente: STF, RE 670.422 (Tema 761) e ADI 4275 — consagram o critério da autodeclaração da identidade de gênero, sem exigência de laudos, tratamentos hormonais ou cirurgia; Decreto nº 8.727/2016, art. 1º, parágrafo único, inciso II, no âmbito federal, também define identidade de gênero sem relação necessária com o sexo atribuído no nascimento.',
 'STF, RE 670.422 (Tema 761); ADI 4275; Decreto 8.727/2016',
 'medio'),

-- Q10: Síntese — direitos LGBTQIA+ no Brasil
(@cat_lg10,
 'Sobre os direitos da população LGBTQIA+ no Brasil:',
 'O STF reconheceu a união estável homoafetiva e estendeu direitos civis a casais do mesmo sexo via ADI 4277 e ADPF 132.',
 'A Constituição de 1988 prevê explicitamente direitos específicos para a população LGBTQIA+.',
 'O Brasil não reconhece juridicamente a identidade de gênero, nem o uso do nome social.',
 'A população LGBTQIA+ não enfrenta discriminação ou violência institucional no Brasil.',
 NULL,
 'A',
 'A alternativa A está correta e sintetiza o precedente já analisado nas questões anteriores: no julgamento conjunto da ADI 4277 e da ADPF 132 (2011), o STF reconheceu a união estável homoafetiva como entidade familiar, com os mesmos direitos e deveres da união estável heteroafetiva. A alternativa B é falsa, pois a Constituição de 1988 não contém disposição expressa sobre orientação sexual ou identidade de gênero, sendo tais direitos reconhecidos por construção jurisprudencial a partir de princípios gerais (dignidade da pessoa humana, igualdade, liberdade). A alternativa C contraria o Decreto nº 8.727/2016 e a Resolução CNJ nº 270/2018, que reconhecem expressamente a identidade de gênero e o nome social. A alternativa D é factualmente incorreta e contraria toda a construção jurisprudencial protetiva analisada neste caderno.\n\n📜 Fundamento legal vigente: STF, ADI 4277 e ADPF 132 (rel. Min. Ayres Britto, j. 05/05/2011).',
 'STF, ADI 4277/ADPF 132 (2011)',
 'facil'),

-- Q11: Sexo x Gênero
(@cat_lg10,
 'Segundo o material de referência:',
 'Sexo refere-se a características socialmente construídas, como papéis de masculinidade e feminilidade.',
 'Gênero diz respeito exclusivamente a características biológicas, como cromossomos e glândulas.',
 'Sexo refere-se a características biológicas (órgãos sexuais e reprodutivos), enquanto Gênero refere-se a características socialmente construídas, muitas vezes subordinatórias.',
 'Gênero e Sexo são sinônimos biológicos, diferenciando-se apenas pela orientação sexual do indivíduo.',
 NULL,
 'C',
 'A alternativa C está correta e traz a distinção conceitual básica adotada pela doutrina de direitos humanos: sexo é a categoria biológica (órgãos, cromossomos, hormônios), enquanto gênero é a construção social e cultural dos papéis atribuídos a homens e mulheres, muitas vezes hierarquizada e subordinatória em relação à mulher. As alternativas A e B invertem os conceitos entre si. A alternativa D está incorreta, pois trata sexo e gênero como sinônimos biológicos e ainda confunde ambos com orientação sexual, que é uma terceira categoria distinta (a direção do desejo afetivo-sexual).\n\n📜 Fundamento legal vigente: trata-se de conceito doutrinário consolidado nos estudos de gênero e nos documentos de direitos humanos (a exemplo dos Princípios de Yogyakarta), sem definição em lei federal específica — o Decreto nº 8.727/2016, art. 1º, parágrafo único, inciso II, apenas define "identidade de gênero" para fins administrativos federais, sem definir "sexo" e "gênero" em si.',
 'Doutrina de direitos humanos e estudos de gênero; Decreto 8.727/2016 (referência conceitual)',
 'facil'),

-- Q12: Intersexual e Queer
(@cat_lg10,
 'Sobre as identidades que compõem a sigla LGBTQIAPN+, a definição de pessoa "Intersexual" e pessoa "Queer" corresponde, respectivamente, a:',
 'Pessoas que atraem-se por todos os gêneros; e pessoas que sentem baixa atração sexual.',
 'Pessoas que nascem com características biológicas que não se encaixam nas noções binárias típicas; e pessoas que fogem aos padrões de hetero-cis-normatividade, atuando em resistência a rótulos.',
 'Pessoas que não se identificam com nenhum gênero; e pessoas cujo sexo e gênero se alinham perfeitamente.',
 'Pessoas que transitam entre os gêneros masculino e feminino; e pessoas que se atraem pelo mesmo sexo.',
 NULL,
 'B',
 'A alternativa B está correta: pessoa intersexual é aquela que nasce com características biológicas (genitália, gônadas ou padrão cromossômico) que não se encaixam nas definições típicas de corpo masculino ou feminino; já o termo queer é um conceito guarda-chuva e político, usado para designar pessoas que rejeitam rótulos fixos e se posicionam em resistência à hetero-cis-normatividade. A alternativa A descreve, na verdade, pansexualidade e assexualidade. A alternativa C confunde intersexual com agênero e queer com cisgênero (justamente o oposto do conceito). A alternativa D descreve, equivocadamente, pessoas de gênero fluido e pessoas homossexuais, não intersexuais e queer.\n\n📜 Fundamento legal vigente: trata-se de conceitos doutrinários de estudos de gênero e sexualidade, amplamente utilizados em documentos de direitos humanos (como os Princípios de Yogyakarta), sem definição em lei federal brasileira específica.',
 'Doutrina de direitos humanos e estudos de gênero (sem lei federal específica)',
 'medio'),

-- Q13: Terminologia — pansexualidade, cisgênero, gênero fluido
(@cat_lg10,
 'No que tange à terminologia aplicada à identidade de gênero e orientação sexual:',
 'Cisgênero é a pessoa cujo sexo biológico e gênero divergem.',
 'A orientação sexual é o reconhecimento que a pessoa tem de seu próprio gênero, independentemente do sexo atribuído.',
 'Pansexualidade define-se como a atração por todos os gêneros, em todas as suas manifestações, sem restrição ou preferência.',
 'O gênero fluido é uma forma de orientação sexual em que a pessoa se sente atraída por qualidades, não por gêneros.',
 NULL,
 'C',
 'A alternativa C está correta: pansexualidade é a orientação sexual caracterizada pela atração afetivo-sexual por pessoas independentemente do gênero ou da identidade de gênero delas. A alternativa A está incorreta, pois descreve exatamente o oposto de cisgênero: pessoa cisgênero é aquela cuja identidade de gênero corresponde ao sexo atribuído no nascimento (transgênero é quem diverge). A alternativa B inverte os conceitos: o que é descrito na alternativa é, na verdade, a identidade de gênero, e não a orientação sexual (que se refere à direção do desejo afetivo-sexual, e não à autopercepção). A alternativa D também está incorreta, pois gênero fluido é uma identidade de gênero (a pessoa transita entre masculino, feminino ou outras vivências de gênero ao longo do tempo), e não uma orientação sexual.\n\n📜 Fundamento legal vigente: trata-se de conceitos doutrinários de estudos de gênero e sexualidade, sem definição em lei federal específica — o Decreto nº 8.727/2016 apenas define identidade de gênero (não orientação sexual, pansexualidade ou gênero fluido) para fins administrativos federais.',
 'Doutrina de direitos humanos e estudos de gênero; Decreto 8.727/2016 (referência conceitual parcial)',
 'medio'),

-- Q14: Conceito de Nome Social
(@cat_lg10,
 'O conceito de "Nome Social" é fundamental para a dignidade da população trans. O nome social visa:',
 'Ocultar a identidade civil do indivíduo para evitar persecução penal.',
 'Legitimar a autopercepção de gênero da pessoa até que ocorra a retificação definitiva de seus documentos.',
 'Substituir o nome civil exclusivamente em contratos da rede privada.',
 'Identificar indivíduos que já concluíram a cirurgia de redesignação sexual.',
 NULL,
 'B',
 'A alternativa B está correta: o nome social é a designação pela qual a pessoa travesti ou transexual se identifica e é socialmente reconhecida, servindo de ponte de reconhecimento e respeito enquanto não ocorre (ou mesmo que nunca ocorra) a retificação definitiva do registro civil. A alternativa A é falsa e distorce a finalidade do instituto, que nada tem de relacionado à ocultação de identidade para fins criminais. A alternativa C está incorreta, pois o uso do nome social é garantido tanto na esfera privada quanto na pública (administração federal, saúde, educação, Judiciário). A alternativa D é falsa, pois o uso do nome social independe de qualquer procedimento cirúrgico.\n\n📜 Fundamento legal vigente: Decreto nº 8.727/2016, art. 1º, parágrafo único, inciso I: "nome social — designação pela qual a pessoa travesti ou transexual se identifica e é socialmente reconhecida"; CNJ, Resolução nº 270/2018, no mesmo sentido, para o âmbito do Poder Judiciário.',
 'Decreto 8.727/2016, art. 1º, parágrafo único, I; CNJ, Resolução 270/2018',
 'facil'),

-- Q15: Pessoa não binária
(@cat_lg10,
 'A pessoa que não se percebe como pertencente a um gênero exclusivamente, e cuja expressão de gênero não é limitada ao masculino ou feminino, é classificada como:',
 'Heterossexual.',
 'Não binária.',
 'Transexual.',
 'Bissexual.',
 NULL,
 'B',
 'A alternativa B está correta: pessoa não binária é aquela cuja identidade de gênero não se enquadra exclusivamente nas categorias binárias masculino/feminino, podendo se identificar com ambos, com nenhum, ou transitar entre eles. A alternativa A está incorreta, pois heterossexualidade é uma orientação sexual (atração pelo sexo/gênero oposto), não uma identidade de gênero. A alternativa C é imprecisa, pois pessoa transexual é aquela cuja identidade de gênero diverge do sexo atribuído no nascimento, mas se identifica integralmente com o gênero masculino ou feminino (binário), diferentemente da pessoa não binária. A alternativa D também está incorreta, pois bissexualidade é orientação sexual (atração por mais de um gênero), não identidade de gênero.\n\n📜 Fundamento legal vigente: trata-se de conceito doutrinário de estudos de gênero, sem definição em lei federal específica.',
 'Doutrina de direitos humanos e estudos de gênero (sem lei federal específica)',
 'facil'),

-- Q16: CF/88, art. 3º, IV
(@cat_lg10,
 'A Constituição Federal de 1988, Art. 3º, IV, é objetivo fundamental da República:',
 'Promover o bem de todos, sem preconceitos de origem, raça, sexo, cor, idade e quaisquer outras formas de discriminação.',
 'Garantir a inviolabilidade do direito à vida apenas aos brasileiros natos.',
 'Implementar a distinção de direitos baseada na orientação sexual para proteger a família tradicional.',
 'Punir criminalmente apenas a discriminação baseada na raça, silenciando sobre o sexo.',
 NULL,
 'A',
 'A alternativa A reproduz literalmente o texto constitucional. A alternativa B é falsa, pois o direito à vida é garantido a todos, sem distinção entre brasileiros natos e demais pessoas. A alternativa C contraria frontalmente o próprio objetivo fundamental descrito no inciso IV, que veda expressamente "quaisquer outras formas de discriminação", cláusula aberta que a jurisprudência do STF (ADO 26) utilizou para fundamentar a proteção contra a LGBTfobia. A alternativa D é incorreta, pois o dispositivo constitucional expressamente menciona o sexo entre os critérios vedados de discriminação, e não apenas a raça.\n\n📜 Fundamento legal vigente: CF/88, art. 3º, IV: "Constituem objetivos fundamentais da República Federativa do Brasil: [...] IV - promover o bem de todos, sem preconceitos de origem, raça, sexo, cor, idade e quaisquer outras formas de discriminação." Texto literal e vigente.',
 'CF/88, art. 3º, IV',
 'facil'),

-- Q17: CF/88, art. 227 — proteção de crianças e jovens
(@cat_lg10,
 'Sobre a proteção de crianças e jovens (Art. 227 da CF/88):',
 'A proteção contra a opressão limita-se à esfera doméstica.',
 'É dever do Estado colocá-los a salvo de toda forma de negligência, discriminação, exploração, violência, crueldade e opressão.',
 'A prioridade absoluta de proteção não abrange jovens em situação de vulnerabilidade por identidade de gênero.',
 'O direito à convivência comunitária é restrito a jovens heterossexuais.',
 NULL,
 'B',
 'A alternativa B reproduz o núcleo do caput do art. 227 da CF/88, que impõe à família, à sociedade e ao Estado o dever solidário de proteger crianças, adolescentes e jovens com absoluta prioridade, colocando-os a salvo de toda forma de negligência, discriminação, exploração, violência, crueldade e opressão. A alternativa A restringe indevidamente a proteção à esfera doméstica, quando o dispositivo é amplo e abrange toda forma de opressão, inclusive institucional e social. A alternativa C contraria a cláusula de "absoluta prioridade" e o princípio da não discriminação, que alcançam também jovens LGBTQIAPN+ em situação de vulnerabilidade. A alternativa D é falsa e discriminatória, pois o direito à convivência comunitária é universal, sem qualquer condicionamento à orientação sexual.\n\n📜 Fundamento legal vigente: CF/88, art. 227, caput: "É dever da família, da sociedade e do Estado assegurar à criança, ao adolescente e ao jovem, com absoluta prioridade, o direito à vida, à saúde, à alimentação, à educação, ao lazer, à profissionalização, à cultura, à dignidade, ao respeito, à liberdade e à convivência familiar e comunitária, além de colocá-los a salvo de toda forma de negligência, discriminação, exploração, violência, crueldade e opressão."',
 'CF/88, art. 227, caput',
 'medio'),

-- Q18: Lei Maria da Penha — diversidade de orientação sexual
(@cat_lg10,
 'A Lei Maria da Penha (Lei nº 11.340/2006):',
 'Possui aplicação que abrange a diversidade de orientação sexual, coibindo a violência doméstica e familiar contra a mulher.',
 'É inaplicável a casais de lésbicas por não envolver um agressor do sexo masculino.',
 'Destina-se exclusivamente à proteção da mulher cisgênera em casamentos heterossexuais.',
 'Veda o uso do nome social em medidas protetivas de urgência.',
 NULL,
 'A',
 'A alternativa A está correta e reitera o já analisado na questão 4: por força do art. 5º, parágrafo único, da Lei Maria da Penha, a proteção contra a violência doméstica independe da orientação sexual da vítima ou de seu agressor, abrangendo relações homoafetivas entre mulheres. A alternativa B contraria expressamente essa regra legal. A alternativa C é falsa, pois a lei também protege mulheres transexuais e travestis, na medida em que a jurisprudência majoritária reconhece a mulher trans como sujeito de proteção da Lei Maria da Penha, considerando a identidade de gênero, e não apenas o sexo biológico. A alternativa D é incorreta, pois nada impede — e a boa prática recomenda — o uso do nome social também no registro e na tramitação de medidas protetivas de urgência.\n\n📜 Fundamento legal vigente: Lei nº 11.340/2006, art. 5º, parágrafo único: "As relações pessoais enunciadas neste artigo independem de orientação sexual."',
 'Lei 11.340/2006, art. 5º, parágrafo único',
 'medio'),

-- Q19: Princípios de Yogyakarta — Princípio 11
(@cat_lg10,
 'Os Princípios de Yogyakarta, Princípio 11:',
 'O tráfico de seres humanos não é influenciado por fatores de identidade de gênero.',
 'As medidas para prevenir o tráfico devem enfrentar fatores que aumentam a vulnerabilidade, incluindo a discriminação baseada na orientação sexual ou identidade de gênero.',
 'A proteção contra a exploração sexual só é garantida se houver violência física comprovada.',
 'O direito à proteção contra o tráfico é exclusivo para cidadãos em situação de asilo político.',
 NULL,
 'B',
 'A alternativa B está correta: o Princípio 11 dos Princípios de Yogyakarta (2007) trata do direito à proteção contra o tráfico de pessoas e estabelece que os Estados devem adotar medidas que enfrentem os fatores que aumentam a vulnerabilidade ao tráfico, exploração e escravidão, incluindo diversas formas de desigualdade e discriminação, entre elas a fundada na orientação sexual e na identidade de gênero. A alternativa A contraria diretamente o princípio, que reconhece a identidade de gênero como fator de vulnerabilidade. A alternativa C restringe indevidamente a proteção à comprovação de violência física, quando a exploração pode ocorrer sem lesão corporal. A alternativa D é falsa, pois a proteção contra o tráfico de pessoas prevista nos Princípios de Yogyakarta não se limita a situações de asilo político.\n\n📜 Fundamento legal vigente: Princípios de Yogyakarta (2007), Princípio 11 (Direito à proteção contra o tráfico de pessoas) — documento de soft law elaborado por especialistas em direitos humanos, sem força de tratado vinculante, mas amplamente utilizado como parâmetro interpretativo de obrigações de direitos humanos relacionadas a orientação sexual e identidade de gênero.',
 'Princípios de Yogyakarta (2007), Princípio 11',
 'dificil'),

-- Q20: Convenção 111 da OIT
(@cat_lg10,
 'A Convenção nº 111 da OIT, sobre Discriminação em Matéria de Emprego e Profissão, define que a discriminação compreende:',
 'Toda distinção baseada em sexo ou origem social que tenha por efeito destruir ou alterar a igualdade de oportunidade no trabalho.',
 'A preferência legítima do empregador por funcionários que compartilhem sua orientação sexual.',
 'Apenas a exclusão direta de salários, não abrangendo o acesso à profissão.',
 'Atos de violência física cometidos estritamente no trajeto casa-trabalho.',
 NULL,
 'A',
 'A alternativa A está correta e sintetiza o núcleo do conceito de discriminação do art. 1º da Convenção nº 111 da OIT (1958), que engloba qualquer distinção, exclusão ou preferência fundada em motivos como raça, cor, sexo, religião, opinião política, ascendência nacional ou origem social, capaz de destruir ou alterar a igualdade de oportunidades ou de tratamento em matéria de emprego ou profissão. A alternativa B descreve exatamente uma conduta discriminatória vedada pela Convenção, e não uma preferência legítima. A alternativa C restringe indevidamente o conceito, que abrange tanto o acesso ao emprego quanto a permanência, a remuneração e as condições de trabalho. A alternativa D desvia o foco da convenção, que trata de discriminação estrutural no emprego, e não apenas de atos de violência física em trajeto.\n\n📜 Fundamento legal vigente: Convenção nº 111 da OIT (1958), art. 1º, alínea "a": o termo discriminação compreende "toda distinção, exclusão ou preferência fundada em raça, cor, sexo, religião, opinião política, ascendência nacional ou origem social, que tenha por efeito destruir ou alterar a igualdade de oportunidades ou de tratamento em matéria de emprego ou profissão". Convenção ratificada pelo Brasil e promulgada pelo Decreto nº 62.150/1968.',
 'Convenção 111 da OIT (1958), art. 1º; Decreto 62.150/1968',
 'medio'),

-- Q21: Convenção 190 da OIT
(@cat_lg10,
 'Considerando a Convenção nº 190 da OIT:',
 'O direito ao trabalho livre de violência e assédio é restrito a cargos de gestão.',
 'A norma deve garantir a proteção de grupos vulneráveis que sejam afetados de forma desproporcional pela violência no mundo do trabalho.',
 'A violência psicológica no trabalho não é objeto da convenção.',
 'O assédio sexual só é punível se ocorrer dentro das dependências físicas da empresa.',
 NULL,
 'B',
 'A alternativa B está correta: a Convenção nº 190 da OIT (2019), sobre eliminação da violência e do assédio no mundo do trabalho, reconhece expressamente que trabalhadores e trabalhadoras pertencentes a grupos vulneráveis ou em situações de vulnerabilidade — o que inclui pessoas LGBTQIAPN+ — são desproporcionalmente afetados pela violência e pelo assédio no ambiente laboral, exigindo abordagem inclusiva e sensível a essas diferenças. A alternativa A é falsa, pois a proteção da convenção abrange todos os trabalhadores, independentemente do cargo ocupado. A alternativa C está incorreta, pois a convenção define violência e assédio de forma ampla, incluindo condutas, práticas e ameaças que causem dano físico, psicológico, sexual ou econômico. A alternativa D também é falsa, pois a convenção reconhece a violência e o assédio relacionados ao trabalho mesmo fora das dependências físicas da empresa, como em trajetos, viagens a trabalho e comunicações digitais relacionadas ao emprego.\n\n📜 Fundamento legal vigente: Convenção nº 190 da OIT (2019), arts. 2º e 6º, que exigem dos Estados-membros uma abordagem inclusiva, integrada e sensível à dimensão de gênero, considerando o impacto desproporcional da violência e do assédio sobre trabalhadores e trabalhadoras de grupos vulneráveis.',
 'Convenção 190 da OIT (2019), arts. 2º e 6º',
 'medio'),

-- Q22: DUDH, art. 23
(@cat_lg10,
 'A DUDH, Artigo 23:',
 'A remuneração deve ser diferenciada conforme a orientação sexual para compensar riscos sociais.',
 'Todo ser humano tem direito ao trabalho e a condições justas, sem qualquer distinção, incluindo igual remuneração por igual trabalho.',
 'O direito de organizar sindicatos é vedado a minorias sexuais.',
 'O Estado pode impor a livre escolha de emprego baseada em critérios de gênero biológico.',
 NULL,
 'B',
 'A alternativa B está correta e reproduz o núcleo do art. 23 da Declaração Universal dos Direitos Humanos (1948), que assegura a toda pessoa o direito ao trabalho, à livre escolha de emprego, a condições justas e favoráveis de trabalho e à igual remuneração por igual trabalho, sem qualquer distinção. A alternativa A contraria o princípio da igualdade de remuneração, criando distinção ilegítima baseada em orientação sexual. A alternativa C é falsa e discriminatória, pois o direito de organizar e filiar-se a sindicatos é universal, sem exclusão de minorias sexuais. A alternativa D também é falsa, pois a livre escolha de emprego é justamente um direito da pessoa, e não um poder do Estado de impor critérios baseados em sexo biológico.\n\n📜 Fundamento legal vigente: Declaração Universal dos Direitos Humanos (1948), art. 23, itens 1 e 2: "Toda pessoa tem direito ao trabalho, à livre escolha de emprego, a condições justas e favoráveis de trabalho e à proteção contra o desemprego. [...] Todo ser humano, sem qualquer distinção, tem direito a igual remuneração por igual trabalho."',
 'DUDH (1948), art. 23',
 'facil'),

-- Q23: Decreto 8.727/2016, art. 2º, parágrafo único
(@cat_lg10,
 'O Decreto nº 8.727/2016, Art. 2º, parágrafo único:',
 'É obrigatório o uso do nome civil em todas as comunicações orais com o servidor.',
 'É vedado o uso de expressões pejorativas e discriminatórias para referir-se a pessoas travestis ou transexuais.',
 'O nome social só pode ser utilizado se houver decisão judicial transitada em julgado.',
 'A identidade de gênero é definida pela relação necessária com o sexo atribuído no nascimento.',
 NULL,
 'B',
 'A alternativa B reproduz literalmente o parágrafo único do art. 2º do Decreto nº 8.727/2016. A alternativa A está incorreta, pois o decreto determina exatamente o oposto: a adoção do nome social pelos órgãos e entidades da administração pública federal, de acordo com o requerimento da pessoa interessada. A alternativa C é falsa, pois o uso do nome social não depende de qualquer decisão judicial, bastando o requerimento administrativo da pessoa travesti ou transexual. A alternativa D contraria a própria definição legal de identidade de gênero, que expressamente dispensa relação necessária com o sexo atribuído no nascimento.\n\n📜 Fundamento legal vigente: Decreto nº 8.727/2016, art. 2º: "Os órgãos e as entidades da administração pública federal direta, autárquica e fundacional, em seus atos e procedimentos, deverão adotar o nome social da pessoa travesti ou transexual, de acordo com seu requerimento e com o disposto neste Decreto. Parágrafo único. É vedado o uso de expressões pejorativas e discriminatórias para referir-se a pessoas travestis ou transexuais." Texto literal e vigente (conferido no site do Planalto).',
 'Decreto 8.727/2016, art. 2º, parágrafo único',
 'facil'),

-- Q24: Resolução CNJ 270 — nome social no Judiciário
(@cat_lg10,
 'A Resolução CNJ nº 270 assegura o uso do nome social no Poder Judiciário. Nome social é:',
 'O apelido de família utilizado em ambiente doméstico.',
 'Aquele adotado pela pessoa, por meio do qual se identifica e é reconhecida na sociedade, e por ela declarado.',
 'O prenome constante na certidão de nascimento original.',
 'A identificação numérica atribuída pelo sistema de processo eletrônico.',
 NULL,
 'B',
 'A alternativa B está correta e reproduz o conceito de nome social adotado pela Resolução CNJ nº 270/2018, que assegura seu uso a pessoas travestis e transexuais no âmbito do Poder Judiciário, em todos os atos processuais e administrativos. A alternativa A restringe indevidamente o conceito a um "apelido de família", desvirtuando a finalidade de reconhecimento da identidade de gênero. A alternativa C está incorreta, pois o nome social é justamente uma alternativa (não coincidente) ao prenome constante do registro civil original, até ou independentemente de sua retificação. A alternativa D é uma distorção sem qualquer relação com o conceito de nome social.\n\n📜 Fundamento legal vigente: CNJ, Resolução nº 270/2018, que assegura a pessoas travestis e transexuais o direito à adequação de tratamento nominal em todos os órgãos do Poder Judiciário, definindo nome social como aquele pelo qual a pessoa se identifica e é socialmente reconhecida, por ela declarado — em linha com o conceito também adotado pelo Decreto nº 8.727/2016, art. 1º, parágrafo único, inciso I.',
 'CNJ, Resolução 270/2018; Decreto 8.727/2016, art. 1º, parágrafo único, I',
 'medio'),

-- Q25: Portaria 1.820/2009-CNS
(@cat_lg10,
 'A Portaria nº 1820/2009 do Conselho Nacional de Saúde estabelece que:',
 'O atendimento pode ser negado em razão da orientação sexual se o profissional alegar objeção de consciência.',
 'É direito da pessoa ter atendimento humanizado, livre de qualquer discriminação, garantindo-se o uso do nome social independente do registro civil.',
 'O campo "nome social" no cadastro SUS é facultativo e depende da autorização do diretor da unidade.',
 'Pacientes trans devem ser identificados obrigatoriamente pelo código da patologia.',
 NULL,
 'B',
 'A alternativa B está correta: a Portaria nº 1.820/2009 do Conselho Nacional de Saúde, ao dispor sobre os direitos e deveres dos usuários da saúde, assegura o direito ao atendimento humanizado e acolhedor, livre de qualquer discriminação, e garante à pessoa usuária do SUS a identificação pelo nome social, independentemente do registro civil. A alternativa A contraria o próprio direito ao atendimento não discriminatório, que não admite recusa baseada em orientação sexual. A alternativa C é falsa, pois o uso do nome social é um direito da pessoa usuária, e não uma faculdade discricionária do gestor da unidade de saúde. A alternativa D também é incorreta e desumanizadora, pois fere a garantia de atendimento humanizado e de identificação pelo nome social, e não pelo código de sua condição de saúde.\n\n📜 Fundamento legal vigente: Portaria nº 1.820/2009 do Ministério da Saúde/Conselho Nacional de Saúde, que dispõe sobre os direitos e deveres dos usuários da saúde, assegurando o direito ao atendimento humanizado e acolhedor, realizado por profissionais qualificados, em ambiente limpo, confortável e sem discriminação, garantido o uso do nome social a travestis e transexuais.',
 'Portaria 1.820/2009, Ministério da Saúde/CNS',
 'medio'),

-- Q26: Resolução 12/2015-CNCD/LGBT e Portaria PGR/MPU 104
(@cat_lg10,
 'De acordo com a Resolução nº 12 do CNCD/LGBT e a Portaria PGR/MPU nº 104, o acesso a banheiros e vestiários deve ser garantido:',
 'Com base no sexo biológico constante no RG.',
 'Segundo a identidade de gênero autopercebida de cada sujeito.',
 'Apenas em cabines individuais trancadas por fora.',
 'Mediante a apresentação de laudo médico que comprove a transição.',
 NULL,
 'B',
 'A alternativa B está correta: tanto a Resolução nº 12/2015 do então Conselho Nacional de Combate à Discriminação e Promoção dos Direitos de LGBT (CNCD/LGBT) quanto a Portaria PGR/MPU nº 104/2014 adotam o critério da identidade de gênero autopercebida (e não o sexo biológico ou documental) para o acesso a banheiros, vestiários e demais espaços segregados por gênero. A alternativa A contraria esse critério, pois vincula o acesso ao registro civil, exatamente o que as normas buscam superar. A alternativa C impõe uma solução segregacionista não prevista nessas normas, que buscam a inclusão, e não o isolamento compulsório. A alternativa D também é incorreta, pois nenhuma das normas exige laudo médico comprobatório de transição para o reconhecimento da identidade de gênero.\n\n📜 Fundamento legal vigente: Resolução nº 12/2015 do CNCD/LGBT e Portaria PGR/MPU nº 104/2014 — normas administrativas que adotam o critério da autodeclaração da identidade de gênero para fins de tratamento no serviço público, em consonância com a diretriz geral do Decreto nº 8.727/2016.',
 'Resolução 12/2015-CNCD/LGBT; Portaria PGR/MPU 104/2014',
 'medio'),

-- Q27: Resolução CNJ 348 e Regras de Bangkok
(@cat_lg10,
 'A Resolução CNJ nº 348 e as Regras de Bangkok abordam o tratamento de pessoas custodiadas:',
 'A população LGBTQIAPN+ deve ser privada de acompanhamento de saúde mental para evitar privilégios.',
 'Funcionários da prisão devem ser alertados e sensíveis aos momentos de especial angústia, assegurando apoio adequado e programas sensíveis ao gênero.',
 'O isolamento total é a única medida de segurança permitida para travestis em presídios masculinos.',
 'As necessidades de saúde específicas não devem ser consideradas para manter a isonomia de tratamento.',
 NULL,
 'B',
 'A alternativa B está correta: a Resolução CNJ nº 348/2020 incorpora parâmetros das Regras de Bangkok (Regras das Nações Unidas para o Tratamento de Mulheres Presas e Medidas Não Privativas de Liberdade para Mulheres Infratoras, 2010) e determina que agentes e funcionários do sistema prisional sejam capacitados e sensibilizados para identificar momentos de particular vulnerabilidade emocional de pessoas LGBTI custodiadas, assegurando apoio psicológico e programas que considerem a perspectiva de gênero. A alternativa A é desumana e contraria o dever de assistência à saúde do preso. A alternativa C impõe uma solução de isolamento compulsório não prevista nessas normas, que privilegiam a avaliação individualizada de risco e vulnerabilidade, evitando medidas automaticamente segregacionistas. A alternativa D contraria a própria essência das normas, que exigem justamente a consideração das necessidades específicas de saúde e de proteção da população LGBTQIAPN+ em privação de liberdade.\n\n📜 Fundamento legal vigente: CNJ, Resolução nº 348/2020, que estabelece procedimentos e diretrizes a serem observados pelo Poder Judiciário quanto ao tratamento de pessoas LGBTI presas ou internadas; Regras de Bangkok (Regras das Nações Unidas para o Tratamento de Mulheres Presas e Medidas Não Privativas de Liberdade para Mulheres Infratoras, aprovadas pela Resolução da Assembleia Geral da ONU 65/229, de 2010).',
 'CNJ, Resolução 348/2020; Regras de Bangkok (ONU, 2010)',
 'dificil'),

-- Q28: ADI 4277/ADPF 132 — fundamento central
(@cat_lg10,
 'No julgamento da ADI 4277 e ADPF 132, o STF utilizou a técnica da "interpretação conforme à Constituição" para o art. 1.723 do Código Civil. O fundamento central dessa decisão incluiu:',
 'O reconhecimento do direito à busca da felicidade e do pluralismo como valor sócio-político-cultural, emanados da dignidade da pessoa humana.',
 'A proibição absoluta de que casais homoafetivos adotem crianças, para preservar o conceito ortodóxico de família.',
 'A aplicação da norma geral negativa apenas para uniões entre homens.',
 'A submissão da união homoafetiva à hierarquia inferior em relação ao casamento civil.',
 NULL,
 'A',
 'A alternativa A está correta: no voto condutor do relator Ministro Ayres Britto, o STF fundamentou o reconhecimento da união homoafetiva como entidade familiar em princípios como a dignidade da pessoa humana, o direito à busca da felicidade, a igualdade e o pluralismo (inclusive familiar) como valores sócio-político-culturais protegidos pela Constituição, aplicando a técnica de interpretação conforme a Constituição ao art. 1.723 do Código Civil, para excluir dele qualquer significado que impedisse o reconhecimento da união contínua, pública e duradoura entre pessoas do mesmo sexo como entidade familiar. A alternativa B é falsa, pois a decisão não trata de proibição de adoção, e a jurisprudência posterior consolidou o direito à adoção por casais homoafetivos. A alternativa C está incorreta, pois a decisão abrange uniões entre pessoas do mesmo sexo de forma geral, sem se restringir a uniões apenas entre homens. A alternativa D é falsa, pois o STF expressamente reconheceu a equiparação de direitos e deveres entre a união homoafetiva e a união estável heteroafetiva, sem hierarquia entre elas.\n\n📜 Fundamento legal vigente: STF, ADI 4277 e ADPF 132 (rel. Min. Ayres Britto, j. 05/05/2011) — reconheceu a união contínua, pública e duradoura entre pessoas do mesmo sexo como entidade familiar, por interpretação conforme a Constituição do art. 1.723 do Código Civil, com fundamento na dignidade da pessoa humana, na igualdade, na liberdade e no pluralismo (CF/88, art. 1º, III, e art. 3º, IV).',
 'STF, ADI 4277/ADPF 132 (2011); CF/88, art. 1º, III e art. 3º, IV',
 'dificil'),

-- Q29: Constitucionalismo Fraternal — voto Aires Britto
(@cat_lg10,
 'Ao analisar o "Constitucionalismo Fraternal" e a autonomia da vontade, o Ministro Relator Aires Britto afirmou que o sexo das pessoas:',
 'Deve ser o fator principal de desigualação jurídica para garantir a moralidade pública.',
 'Não se presta como fator de desigualação jurídica, salvo disposição constitucional expressa, sendo o direito à preferência sexual uma emanação da dignidade humana.',
 'É um dado biológico que prevalece sobre o direito subjetivo à intimidade.',
 'Impede a formação de famílias fora da celebração civil cartorial.',
 NULL,
 'B',
 'A alternativa B está correta e reproduz a essência do voto do Ministro Ayres Britto na ADI 4277/ADPF 132: o sexo das pessoas, salvo expressa disposição constitucional em sentido contrário, não pode ser fator de desigualação jurídica, de modo que o reconhecimento da preferência sexual de cada indivíduo (hoje tratada como orientação sexual) decorre diretamente da dignidade da pessoa humana e do direito à intimidade e à vida privada. A alternativa A contraria diretamente esse fundamento, que rejeita o sexo como critério discriminatório. A alternativa C inverte a lógica do voto, que privilegia o direito subjetivo à intimidade e à autodeterminação sobre qualquer dado meramente biológico. A alternativa D é falsa, pois a decisão trata da união estável (que dispensa formalização cartorial), sem qualquer condicionamento à celebração civil.\n\n📜 Fundamento legal vigente: STF, ADI 4277/ADPF 132 (voto do rel. Min. Ayres Britto, j. 05/05/2011), que desenvolveu a tese do "constitucionalismo fraternal", fundada nos objetivos da CF/88, art. 3º (constituição de uma sociedade livre, justa e solidária, promoção do bem de todos sem preconceitos) e no direito à intimidade e à vida privada (CF/88, art. 5º, X).',
 'STF, ADI 4277/ADPF 132 (2011); CF/88, art. 3º e art. 5º, X',
 'dificil'),

-- Q30: RE 646.721 — sucessão em uniões homoafetivas
(@cat_lg10,
 'O STF, no Recurso Extraordinário nº 646.721 (Repercussão Geral), sobre sucessão em uniões homoafetivas, fixou a tese de que:',
 'A diferenciação de regimes sucessórios entre cônjuges e companheiros é legítima para proteger o matrimônio.',
 'É inconstitucional a distinção de regimes sucessórios entre cônjuges e companheiros, aplicando-se em ambos os casos o art. 1.829 do Código Civil de 2002.',
 'O companheiro sobrevivente em união homoafetiva não possui direito à herança se houver descendentes.',
 'A vedação ao retrocesso não se aplica a direitos patrimoniais de casais trans.',
 NULL,
 'B',
 'A alternativa B está correta: no julgamento do RE 646.721 (Tema 498 de repercussão geral, rel. para o acórdão Min. Roberto Barroso, j. 10/05/2017), o STF declarou a inconstitucionalidade do art. 1.790 do Código Civil de 2002 (que tratava de forma diferenciada e mais restritiva a sucessão do companheiro em relação ao cônjuge), fixando a tese de que, no sistema constitucional vigente, é inconstitucional a distinção de regimes sucessórios entre cônjuges e companheiros, devendo ser aplicado, em ambos os casos, o regime do art. 1.829 do Código Civil, tese que se estende também às uniões homoafetivas, já equiparadas à união estável desde a ADI 4277/ADPF 132. A alternativa A contraria diretamente essa tese de inconstitucionalidade da diferenciação. A alternativa C é falsa, pois o companheiro sobrevivente (inclusive em união homoafetiva) concorre com os descendentes na sucessão, nos termos do art. 1.829 do CC. A alternativa D também está incorreta, pois a decisão é exatamente uma aplicação da vedação ao retrocesso em matéria de direitos patrimoniais já conquistados pelos casais homoafetivos.\n\n📜 Fundamento legal vigente: STF, RE 646.721 (Tema 498 de repercussão geral, j. 10/05/2017) — declarou inconstitucional o art. 1.790 do Código Civil de 2002 e fixou a aplicação do art. 1.829 do CC/2002 tanto à sucessão entre cônjuges quanto entre companheiros, inclusive em uniões homoafetivas.',
 'STF, RE 646.721 (Tema 498); CC/2002, art. 1.829',
 'dificil');

SET foreign_key_checks = 1;
