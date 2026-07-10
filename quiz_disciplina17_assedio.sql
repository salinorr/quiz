-- ============================================================
-- QUIZ — Disciplina 17/20 do CHO: Prevencao ao Assedio Sexual e ao Assedio Moral na Caserna
-- 30 questoes — enunciados no padrao guia_elaboracao_questoes.md (cenario concreto,
--   sem citar artigo no enunciado, distratores plausiveis, dupla justificativa).
-- Base legal verificada (ver secao 23 de base_conhecimento_legislacao.md):
--   Codigo Penal, arts. 216-A (assedio sexual) e 215-A (importunacao sexual);
--   Codigo Penal Militar, arts. 174 (rigor excessivo) e 175 (violencia contra inferior);
--   CF/88, art. 1, III (dignidade) e art. 37, §6 (responsabilidade objetiva do Estado);
--   Lei 9.029/1995 (veda discriminacao no trabalho); CEDM/RR (Lei 963/2014, arts. 15 e 17);
--   Decreto 20.910/1932 (prescricao quinquenal).
-- Correcoes aplicadas ao caderno-fonte: rigor excessivo e o art. 174 do CPM (o caderno
--   dizia 322); a instancia externa para militar ESTADUAL e o MP Estadual junto a JME
--   (nao o MPM, que oficia junto a Justica Militar da Uniao).
-- ============================================================
SET NAMES utf8mb4;

INSERT INTO categorias (nome, descricao)
SELECT 'Prevenção ao Assédio Sexual e Moral — CHO 17', 'Disciplina 17/20 do CHO — Prevenção ao assédio sexual (CP 216-A) e moral na caserna, rigor legítimo x abuso, responsabilidade do Estado, canais de denúncia'
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categorias WHERE nome = 'Prevenção ao Assédio Sexual e Moral — CHO 17');

SET @cat_pa17 = (SELECT id FROM categorias WHERE nome = 'Prevenção ao Assédio Sexual e Moral — CHO 17' ORDER BY id LIMIT 1);

-- Aposenta questoes ja carregadas desta categoria (idempotente em recarga; FK RESTRICT).
UPDATE questoes SET ativa = 0 WHERE categoria_id = @cat_pa17;

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: conceito de assedio moral (reiteracao + intencao)
(@cat_pa17,
 'Um Sargento discute com um Soldado certa manhã e, irritado, faz uma cobrança ríspida sobre uma tarefa atrasada, sem voltar ao assunto depois. Um Cabo, por sua vez, durante meses, ridiculariza diariamente outro Cabo diante da tropa, com apelidos e exclusões deliberadas. Qual das situações caracteriza, tecnicamente, assédio moral?',
 'Apenas a do Sargento, por envolver relação de hierarquia.',
 'Apenas a do Cabo, por ser conduta abusiva reiterada e intencional que visa humilhar e isolar a vítima.',
 'Ambas, pois qualquer cobrança ríspida configura assédio moral.',
 'Nenhuma, pois assédio moral exige contato físico.',
 'Apenas a do Sargento, porque a do Cabo ocorre entre pares de mesma graduação.',
 'B',
 'A alternativa B está correta: o assédio moral exige a conjugação de dois elementos — reiteração (conduta repetida e prolongada) e intencionalidade de humilhar, constranger, isolar ou desestabilizar a vítima. A conduta do Cabo reúne os dois; a cobrança isolada e fundamentada do Sargento é exercício legítimo do dever de correção. A alternativa A confunde hierarquia com assédio; C generaliza indevidamente qualquer cobrança; D exige contato físico, que não é elemento do assédio moral; E ignora que o assédio horizontal (entre pares) é justamente uma das modalidades reconhecidas.\n\n📜 Fundamento legal vigente: o assédio moral não tem tipo penal autônomo com esse nome, mas suas condutas ferem a dignidade da pessoa humana (CF/88, art. 1º, III) e o dever de tratar o subordinado e o par com justiça, consideração e urbanidade (CEDM/RR — Lei nº 963/2014, arts. 15 e 17). A caracterização doutrinária exige reiteração e intenção de degradar o ambiente e a pessoa.',
 'CF/88, art. 1º, III; CEDM/RR (Lei 963/2014), arts. 15 e 17',
 'facil'),

-- Q02: ato isolado de altissima gravidade
(@cat_pa17,
 'Em uma única ocasião, diante de toda a tropa formada, um superior humilha gravíssimamente um subordinado, atingindo frontalmente sua dignidade, sem que o fato tenha se repetido antes ou depois. A defesa alega que, por ser ato isolado, não pode haver assédio moral. Essa tese está:',
 'Correta, pois o assédio moral exige, sem exceção, a repetição da conduta.',
 'Incorreta, pois um único ato de altíssima gravidade, que viole frontalmente a dignidade da vítima, pode configurar assédio moral.',
 'Correta, pois ato isolado configura apenas transgressão disciplinar, nunca assédio.',
 'Incorreta, pois todo ato praticado diante da tropa é automaticamente assédio, independentemente da gravidade.',
 'Correta, desde que o superior peça desculpas formalmente depois.',
 'B',
 'A alternativa B está correta: embora a regra seja a reiteração, a doutrina admite que um ato isolado de altíssima gravidade, que viole frontalmente a dignidade da vítima, configure assédio moral. A alternativa A e a C tratam a repetição como requisito absoluto, o que não é exato. A alternativa D generaliza indevidamente (nem todo ato diante da tropa é assédio — depende da gravidade e da intenção). A alternativa E cria excludente inexistente: pedir desculpas não descaracteriza o fato já consumado.\n\n📜 Fundamento legal vigente: a proteção decorre da dignidade da pessoa humana (CF/88, art. 1º, III). A repetição é a regra doutrinária de configuração do assédio moral, mas não requisito absoluto: a gravidade extrema de um único ato pode, conforme as circunstâncias, caracterizá-lo.',
 'CF/88, art. 1º, III (dignidade da pessoa humana)',
 'medio'),

-- Q03: vertical descendente
(@cat_pa17,
 'Um Capitão, comandante de companhia, passa a fazer cobranças humilhantes e exageradas contra um Tenente subordinado, com o objetivo de desestabilizá-lo. Quanto à direção desse assédio moral, trata-se de assédio:',
 'Horizontal, por ocorrer entre oficiais.',
 'Vertical descendente, pois parte do superior hierárquico em direção ao subordinado.',
 'Vertical ascendente, pois envolve dois oficiais.',
 'Misto, por envolver a cadeia de comando.',
 'Institucional, por ocorrer dentro de uma companhia.',
 'B',
 'A alternativa B está correta: o assédio vertical descendente é aquele em que o superior hierárquico agride o subordinado — exatamente o caso do Capitão contra o Tenente. A alternativa A erra porque horizontal é entre pares de mesmo posto/graduação. A alternativa C inverte o sentido (ascendente é do subordinado contra o superior). A alternativa D (misto) exige convergência de agressões verticais e horizontais. A alternativa E usa rótulo inexistente na classificação.\n\n📜 Fundamento legal vigente: a subordinação hierárquica não afeta a dignidade pessoal do subordinado (CEDM/RR — Lei nº 963/2014, art. 15). O uso do poder de comando para humilhar caracteriza o assédio moral vertical descendente e pode, conforme a conduta, configurar rigor excessivo (CPM, art. 174).',
 'CEDM/RR (Lei 963/2014), art. 15; classificação doutrinária do assédio moral',
 'facil'),

-- Q04: vertical ascendente (CORRIGIDO — subordinado contra superior)
(@cat_pa17,
 'Um grupo de Soldados combina boicotar sistematicamente as ordens de um Sargento recém-chegado, desrespeitando-o e tentando deslegitimá-lo perante a tropa para forçá-lo a pedir transferência. Essa conduta caracteriza assédio moral na modalidade:',
 'Vertical descendente, pois envolve a hierarquia militar.',
 'Vertical ascendente, pois parte de subordinados contra o superior hierárquico.',
 'Horizontal, pois os Soldados são todos de mesma graduação entre si.',
 'Paquera hostil, sem repercussão disciplinar.',
 'Não configura assédio, pois superiores não podem ser vítimas.',
 'B',
 'A alternativa B está correta: o assédio vertical ascendente ocorre quando subordinados agem, de forma reiterada, para boicotar, desrespeitar ou deslegitimar o superior — precisamente o caso. A alternativa A inverte o sentido. A alternativa C se fixa na relação entre os Soldados, mas o alvo do assédio é o Sargento (superior), o que define a direção como ascendente. A alternativa D trivializa uma conduta grave. A alternativa E é falsa: o superior também pode ser vítima de assédio moral.\n\n📜 Fundamento legal vigente: a hierarquia e a disciplina são a base da instituição (CF/88, art. 42), e o desrespeito reiterado ao superior fere o dever de subordinação e a dignidade da pessoa (CEDM/RR — Lei nº 963/2014). Atenção: o slide-fonte da disciplina rotula erroneamente esta modalidade — a definição correta de vertical ascendente é a de subordinados contra o superior.',
 'CF/88, art. 42; classificação doutrinária (vertical ascendente)',
 'medio'),

-- Q05: horizontal
(@cat_pa17,
 'Dois Cabos, de mesma graduação e lotados na mesma seção, passam a hostilizar reiteradamente um terceiro Cabo, excluindo-o das atividades e fazendo piadas depreciativas sobre ele. Essa conduta caracteriza assédio moral:',
 'Vertical descendente.',
 'Vertical ascendente.',
 'Horizontal, por ocorrer entre militares de mesma graduação.',
 'Institucional descendente.',
 'Não caracteriza assédio, por inexistir relação de hierarquia entre eles.',
 'C',
 'A alternativa C está correta: o assédio moral horizontal ocorre entre militares de mesmo posto ou graduação, por meio de hostilidade, exclusão e ridicularização — exatamente o caso dos Cabos. As alternativas A e B pressupõem relação de hierarquia entre agressor e vítima, ausente aqui. A alternativa D usa rótulo inexistente. A alternativa E erra ao supor que a ausência de hierarquia afasta o assédio: o horizontal dispensa relação de comando.\n\n📜 Fundamento legal vigente: a conduta fere o dever de camaradagem e o respeito mútuo próprios da vida militar (CEDM/RR — Lei nº 963/2014, art. 17) e a dignidade da pessoa (CF/88, art. 1º, III), independentemente de haver hierarquia entre agressor e vítima.',
 'CF/88, art. 1º, III; CEDM/RR (Lei 963/2014), art. 17',
 'facil'),

-- Q06: misto
(@cat_pa17,
 'Uma Soldado sofre, ao mesmo tempo, cobranças humilhantes do seu comandante direto e exclusão e hostilidade por parte dos colegas de mesma graduação, ficando cercada por todos os lados. Essa convergência de agressões caracteriza assédio moral:',
 'Exclusivamente vertical descendente, pois o comandante é o principal agressor.',
 'Exclusivamente horizontal, pois os colegas são maioria.',
 'Misto, pela convergência de pressões verticais e horizontais que isolam a vítima.',
 'Institucional, por atingir toda a unidade.',
 'Inexistente, pois assédios de direções diferentes se anulam.',
 'C',
 'A alternativa C está correta: o assédio misto é a convergência de agressões verticais (do superior) e horizontais (dos pares), configurando o cenário mais grave para a vítima, que perde suas redes de apoio na unidade. As alternativas A e B isolam apenas uma das direções, ignorando a soma. A alternativa D usa rótulo que não corresponde ao caso. A alternativa E é logicamente falsa: as agressões se somam, não se anulam.\n\n📜 Fundamento legal vigente: a proteção decorre da dignidade da pessoa humana (CF/88, art. 1º, III) e do dever de urbanidade e camaradagem (CEDM/RR — Lei nº 963/2014, arts. 15 e 17). O assédio misto potencializa o dano psíquico e operacional por atingir a vítima simultaneamente na vertical e na horizontal.',
 'CF/88, art. 1º, III; CEDM/RR (Lei 963/2014), arts. 15 e 17',
 'medio'),

-- Q07: rigor legitimo (feedback reservado) NAO e assedio
(@cat_pa17,
 'Um Tenente chama um Sargento a uma sala reservada e, de forma técnica e respeitosa, aponta um erro na execução de uma tarefa e orienta a correção. O Sargento sente-se contrariado e cogita denunciar assédio moral. Nesse caso:',
 'Há assédio moral, pois qualquer crítica ao subordinado configura constrangimento.',
 'Não há assédio moral: trata-se de exercício legítimo do dever de correção, feito com urbanidade e sem exposição vexatória.',
 'Há assédio moral, pois a conversa ocorreu sem a presença de testemunhas.',
 'Não há assédio, mas o Tenente cometeu abuso de autoridade ao corrigir o subordinado.',
 'Há assédio moral vertical descendente, por partir de um superior.',
 'B',
 'A alternativa B está correta: apontar erro de execução em local reservado, de forma técnica e respeitosa, é exercício regular do dever de correção — o oposto do assédio. Falta o elemento abusivo e a intenção de humilhar. As alternativas A e E tratam qualquer correção como assédio, o que esvaziaria o comando. A alternativa C inverte a lógica: a reserva protege o subordinado, não o incrimina. A alternativa D confunde correção legítima com abuso de autoridade.\n\n📜 Fundamento legal vigente: o dever de fiscalizar e corrigir integra o exercício do comando; feito com justiça, consideração e urbanidade (CEDM/RR — Lei nº 963/2014, arts. 15 e 17), não configura assédio. O assédio exige abusividade e intenção de degradar, ausentes no feedback reservado e técnico.',
 'CEDM/RR (Lei 963/2014), arts. 15 e 17 (dever de correção com urbanidade)',
 'medio'),

-- Q08: cobranca de horario NAO e assedio
(@cat_pa17,
 'O comandante de uma OPM edita ordem exigindo o cumprimento rigoroso do horário de expediente por todos os militares da unidade, de forma impessoal. Um militar alega ser vítima de assédio moral. A alegação:',
 'Procede, pois toda exigência de horário é forma de perseguição.',
 'Não procede, pois exigir o cumprimento do dever funcional, de forma geral e impessoal, é gestão legítima, não assédio.',
 'Procede, pois a ordem deveria ter sido individualizada para cada militar.',
 'Não procede, mas apenas se a ordem tiver sido publicada em boletim.',
 'Procede, pois o horário de expediente é matéria de foro íntimo do militar.',
 'B',
 'A alternativa B está correta: exigir o cumprimento do horário de expediente, de forma geral e impessoal, é exercício legítimo da administração — não há abusividade nem intenção de humilhar. As alternativas A e E tratam uma exigência legal ordinária como perseguição. A alternativa C inventa requisito de individualização. A alternativa D condiciona a legitimidade a uma formalidade (boletim) que não é o que define assédio.\n\n📜 Fundamento legal vigente: o cumprimento da jornada e da pontualidade é dever funcional de todo agente público. O assédio ocorreria se a cobrança fosse seletiva, humilhante ou fora dos padrões legais — não na exigência geral e impessoal fundada na norma interna.',
 'Dever funcional; distinção rigor legítimo x assédio (CEDM/RR)',
 'facil'),

-- Q09: servico extra por necessidade NAO e assedio
(@cat_pa17,
 'Diante de uma operação emergencial de segurança pública, o comandante convoca a tropa para serviço extra remunerado, com amparo legal e por necessidade real do serviço. Um militar sustenta que a convocação configura assédio moral por sobrecarga. A tese:',
 'Procede, pois qualquer convocação extra é sobrecarga abusiva.',
 'Não procede, pois a convocação por necessidade real do serviço, amparada em lei, é ato administrativo legítimo.',
 'Procede, pois o serviço militar não admite convocação fora do expediente.',
 'Não procede somente se cada militar tiver assinado aceite individual.',
 'Procede, pois a Constituição garante descanso semanal absoluto ao militar.',
 'B',
 'A alternativa B está correta: a natureza do serviço militar exige disponibilidade, e a convocação fundada em necessidade real, com amparo legal e de forma impessoal, é ato administrativo legítimo — não assédio. As alternativas A e C tratam toda convocação extra como abuso, negando a natureza da atividade. A alternativa D inventa exigência de aceite individual. A alternativa E supõe um descanso absoluto incompatível com a disponibilidade inerente à função.\n\n📜 Fundamento legal vigente: exigências fundadas na missão e na necessidade do serviço, com respaldo legal e impessoalidade, não se confundem com assédio moral, que pressupõe abusividade e intenção de humilhar.',
 'Distinção rigor legítimo x assédio (necessidade do serviço)',
 'facil'),

-- Q10: transferencia por necessidade NAO e assedio
(@cat_pa17,
 'Um militar é transferido de seção, dentro da mesma OM, para preencher vaga aberta em novo Quadro de Organização, por necessidade do serviço. Ele alega assédio moral por perseguição. A alegação:',
 'Procede, pois toda transferência é presumidamente punição disfarçada.',
 'Não procede, pois a movimentação por necessidade do serviço e adequação ao Quadro é gestão de pessoal legítima.',
 'Procede, pois transferências exigem a concordância prévia do militar.',
 'Não procede apenas se a transferência beneficiar o militar financeiramente.',
 'Procede, por violar o direito adquirido do militar à sua seção de origem.',
 'B',
 'A alternativa B está correta: a movimentação de pessoal rege-se pelo interesse da administração e pela conveniência e oportunidade; se motivada por necessidade do serviço, sem intuito de punir ou humilhar, não é assédio. As alternativas A e E presumem perseguição ou inventam um "direito à seção de origem" inexistente. A alternativa C exige concordância que a lei não impõe. A alternativa D condiciona a legitimidade a um benefício irrelevante para a caracterização.\n\n📜 Fundamento legal vigente: a transferência por necessidade do serviço é ato de mérito administrativo (conveniência e oportunidade). Só haveria assédio se fosse punição disfarçada, com intuito de humilhar — o que não se presume.',
 'Distinção rigor legítimo x assédio (movimentação de pessoal)',
 'medio'),

-- Q11: restricao de banheiro E assedio
(@cat_pa17,
 'Um Sargento encarregado restringe o uso do banheiro pela equipe a horários fixos e cronometra o tempo de permanência em dois minutos, sob ameaça de punição. Essa conduta:',
 'É medida legítima de otimização do tempo de serviço.',
 'Configura assédio moral, por restrição abusiva e degradante que atinge a integridade e a dignidade da pessoa.',
 'É permitida desde que publicada previamente em boletim interno.',
 'É indispensável para a segurança orgânica durante o manuseio de material.',
 'Configura mera irregularidade administrativa, sem repercussão ética.',
 'B',
 'A alternativa B está correta: restringir de forma desarrazoada e humilhante o exercício de necessidades fisiológicas básicas atenta contra a integridade física e a dignidade humana, sendo exemplo clássico de assédio moral. As alternativas A, C e D tentam legitimar a conduta por eficiência, formalidade ou segurança, o que não descaracteriza o abuso. A alternativa E subestima a gravidade, reduzindo-a a irregularidade sem repercussão.\n\n📜 Fundamento legal vigente: a conduta viola a dignidade da pessoa humana (CF/88, art. 1º, III) e o dever de tratar o subordinado com consideração (CEDM/RR — Lei nº 963/2014, art. 15). O controle vexatório de necessidades fisiológicas é conduta abusiva típica do assédio moral.',
 'CF/88, art. 1º, III; CEDM/RR (Lei 963/2014), art. 15',
 'facil'),

-- Q12: punicao vexatoria E assedio
(@cat_pa17,
 'Um instrutor determina que os alunos que erraram um exercício executem "dancinhas" ridicularizantes diante de outras turmas, como forma de "punição". Essa prática:',
 'É método pedagógico válido para quebrar a inibição dos alunos.',
 'Configura assédio moral, por impor punição vexatória e degradante sem finalidade educativa legítima.',
 'É tradição militar protegida pelo costume, imune a responsabilização.',
 'Fortalece o espírito de corpo por meio da ludicidade.',
 'É treinamento de resistência psicológica em ambiente controlado.',
 'B',
 'A alternativa B está correta: expor o militar ao ridículo como "punição" fere a dignidade da pessoa e não tem finalidade educativa — é conduta de assédio moral. As alternativas A, D e E tentam revestir a humilhação de pedagogia, ludicidade ou treinamento. A alternativa C invoca "costume" que jamais legitima violação da dignidade.\n\n📜 Fundamento legal vigente: a imposição de punições vexatórias viola a dignidade da pessoa humana (CF/88, art. 1º, III). As punições disciplinares só podem ser as previstas em regulamento (CEDM/RR — Lei nº 963/2014), aplicadas sem exposição ao ridículo.',
 'CF/88, art. 1º, III; CEDM/RR (Lei 963/2014)',
 'facil'),

-- Q13: esvaziamento/ocio forcado E assedio
(@cat_pa17,
 'Um militar é retirado de todas as suas atribuições técnicas e passa a ficar isolado em uma sala, sem qualquer tarefa, em "ócio forçado", enquanto o restante da seção trabalha normalmente. Essa conduta:',
 'É estratégia legítima de gestão para dar tempo de estudo ao militar.',
 'Configura assédio moral, por esvaziamento de função e isolamento que visam anular a utilidade profissional da vítima.',
 'É economia administrativa e otimização de recursos humanos.',
 'É prerrogativa absoluta do comandante, insuscetível de questionamento.',
 'É recompensa institucional por bons serviços prestados.',
 'B',
 'A alternativa B está correta: privar o militar de suas funções e isolá-lo do convívio ("ócio forçado" / esvaziamento de cargo) é tática perversa de assédio moral, que induz sentimentos de inutilidade e adoecimento. As alternativas A, C, D e E tentam justificar a conduta como gestão, economia, prerrogativa ou recompensa, mascarando o abuso.\n\n📜 Fundamento legal vigente: o esvaziamento de função atenta contra a dignidade e a integridade psíquica da pessoa (CF/88, art. 1º, III) e contra a eficiência do serviço público. É conduta abusiva reiterada típica do assédio moral.',
 'CF/88, art. 1º, III (dignidade); esvaziamento de função',
 'medio'),

-- Q14: ciberbullying E assedio
(@cat_pa17,
 'Militares de uma corporação passam a publicar, em grupos de mensagens da própria unidade, comentários jocosos e depreciativos sobre a perícia técnica de um colega, com o intuito de expô-lo e humilhá-lo. Essa conduta:',
 'É protegida pela liberdade de expressão, por ocorrer em ambiente virtual.',
 'Configura assédio moral na forma de ciberbullying, pois usa o meio digital para expor e desestabilizar a vítima.',
 'Só teria relevância se as mensagens fossem enviadas em papel timbrado.',
 'É mero "feedback" horizontal informal, sem repercussão.',
 'Não gera consequência administrativa, apenas eventual ação cível privada.',
 'B',
 'A alternativa B está correta: o assédio moral também se manifesta no ambiente digital (ciberbullying) quando a tecnologia é usada para expor, humilhar e desestabilizar a vítima perante os pares. As alternativas A e E tratam o meio virtual como zona franca de responsabilidade. A alternativa C é irrelevante quanto ao suporte. A alternativa D minimiza a conduta como "feedback".\n\n📜 Fundamento legal vigente: a exposição depreciativa em grupos da corporação fere a honra e a dignidade da pessoa (CF/88, art. 1º, III) e o dever de camaradagem (CEDM/RR — Lei nº 963/2014, art. 17). O ambiente virtual não afasta a responsabilização.',
 'CF/88, art. 1º, III; CEDM/RR (Lei 963/2014), art. 17',
 'facil'),

-- Q15: assedio sexual 216-A conceito
(@cat_pa17,
 'Um Capitão condiciona a concessão de uma dispensa de serviço a um Soldado à aceitação de um encontro íntimo, valendo-se de sua condição de superior. Sobre o enquadramento penal dessa conduta, é correto afirmar que configura:',
 'Importunação sexual, pois houve conotação sexual.',
 'Assédio sexual, por constranger alguém, com o fim de obter vantagem sexual, prevalecendo-se da condição de superior hierárquico.',
 'Mera transgressão disciplinar, sem repercussão penal.',
 'Crime somente se houver contato físico entre o Capitão e o Soldado.',
 'Conduta atípica, por ter ocorrido no ambiente de trabalho.',
 'B',
 'A alternativa B está correta: constranger alguém, com o intuito de obter vantagem ou favorecimento sexual, prevalecendo-se o agente de sua condição de superior hierárquico ou ascendência, é o crime de assédio sexual. A alternativa A troca o tipo (a importunação não exige hierarquia e exige ato libidinoso). A alternativa C nega a repercussão penal. A alternativa D exige contato físico, que o assédio sexual não requer. A alternativa E supõe que o ambiente de trabalho tornaria a conduta atípica, o que é falso.\n\n📜 Fundamento legal vigente: Código Penal, art. 216-A — "constranger alguém com o intuito de obter vantagem ou favorecimento sexual, prevalecendo-se o agente da sua condição de superior hierárquico ou ascendência inerentes ao exercício de emprego, cargo ou função". Pena: detenção, de 1 a 2 anos. Não exige contato físico nem repetição.',
 'Código Penal, art. 216-A (assédio sexual)',
 'medio'),

-- Q16: importunacao sexual 215-A conceito
(@cat_pa17,
 'Durante uma confraternização da corporação, um militar dá um "beijo roubado" e apalpa uma colega de mesma graduação, sem o consentimento dela e sem qualquer relação de hierarquia entre os dois. Sobre o enquadramento penal, é correto afirmar que a conduta configura:',
 'Assédio sexual, pois ocorreu entre militares.',
 'Importunação sexual, por praticar ato libidinoso contra alguém sem sua anuência, para satisfazer a própria lascívia.',
 'Conduta atípica, por ter ocorrido fora do horário de expediente.',
 'Assédio moral, por ferir a camaradagem.',
 'Crime somente se a vítima for hierarquicamente inferior ao agente.',
 'B',
 'A alternativa B está correta: praticar ato libidinoso contra alguém, sem sua anuência, para satisfazer a própria lascívia ou a de terceiro, é o crime de importunação sexual — que não exige relação de hierarquia e se caracteriza pela ausência de consentimento. A alternativa A troca o tipo (o assédio sexual exige prevalecimento hierárquico). A alternativa C supõe atipicidade pelo horário, o que é falso. A alternativa D desvia para o assédio moral. A alternativa E inverte: a importunação independe de hierarquia.\n\n📜 Fundamento legal vigente: Código Penal, art. 215-A — "praticar contra alguém e sem a sua anuência ato libidinoso com o objetivo de satisfazer a própria lascívia ou a de terceiro". Pena: reclusão, de 1 a 5 anos, se o ato não constitui crime mais grave. A palavra-chave é a ausência de consentimento.',
 'Código Penal, art. 215-A (importunação sexual)',
 'medio'),

-- Q17: pena — importunacao mais grave que assedio (contraintuitivo)
(@cat_pa17,
 'Comparando as penas do assédio sexual e da importunação sexual no Código Penal, assinale a alternativa correta:',
 'O assédio sexual é punido mais gravemente, pois envolve abuso de hierarquia.',
 'A importunação sexual é punida mais gravemente (reclusão de 1 a 5 anos) do que o assédio sexual (detenção de 1 a 2 anos), apesar de este envolver abuso de hierarquia.',
 'Ambos têm a mesma pena, por tutelarem o mesmo bem jurídico.',
 'O assédio sexual é contravenção penal, e a importunação, crime.',
 'A importunação sexual é punida apenas com multa.',
 'B',
 'A alternativa B está correta e contraintuitiva: a importunação sexual (art. 215-A) é apenada com reclusão de 1 a 5 anos, enquanto o assédio sexual (art. 216-A) prevê detenção de 1 a 2 anos — ou seja, a importunação é mais grave, embora o assédio envolva o abuso da hierarquia. As alternativas A e C partem da intuição equivocada de igualdade ou de maior gravidade do assédio. As alternativas D e E rebaixam indevidamente a natureza ou a pena dos tipos.\n\n📜 Fundamento legal vigente: CP, art. 216-A (assédio sexual): detenção, de 1 a 2 anos. CP, art. 215-A (importunação sexual): reclusão, de 1 a 5 anos, se o ato não constitui crime mais grave. A comparação das penas é ponto clássico de prova.',
 'Código Penal, arts. 215-A e 216-A (comparação de penas)',
 'dificil'),

-- Q18: matriz paquera x importunacao x assedio
(@cat_pa17,
 'Um Sargento convida educadamente uma colega para um café e, diante da recusa, não insiste nem retruca. Esse comportamento, comparado à importunação sexual e ao assédio sexual, distingue-se essencialmente por:',
 'Envolver contato físico, ao contrário dos crimes sexuais.',
 'Ser recíproco e respeitar o "não", faltando a invasão sem consentimento (importunação) e o uso da autoridade para favorecimento sexual (assédio).',
 'Ser sempre crime, por ocorrer no ambiente da corporação.',
 'Configurar assédio moral, por gerar constrangimento.',
 'Depender exclusivamente da diferença de posto entre os envolvidos.',
 'B',
 'A alternativa B está correta: a paquera é comportamento sadio quando recíproca e respeitosa, aceitando o "não" de imediato. O que a separa da importunação sexual é a ausência do ato libidinoso sem consentimento; o que a separa do assédio sexual é a ausência do uso da autoridade para obter favorecimento sexual. A alternativa A inverte (a paquera do exemplo não tem contato físico). As alternativas C e D criminalizam ou reclassificam indevidamente um convite respeitoso. A alternativa E reduz a distinção à hierarquia, ignorando o consentimento.\n\n📜 Fundamento legal vigente: o divisor entre conduta lícita e importunação sexual (CP, art. 215-A) é o consentimento; o divisor entre conduta lícita e assédio sexual (CP, art. 216-A) é o uso da condição de superior para obter vantagem sexual. Aceitar o "não" afasta ambos os crimes.',
 'Código Penal, arts. 215-A e 216-A (distinção)',
 'medio'),

-- Q19: assedio sexual fora do expediente continua crime
(@cat_pa17,
 'Um superior utiliza sua patente para constranger um subordinado a aceitar propostas íntimas, mas o faz fora do horário de expediente e longe da unidade militar. A defesa sustenta que, por isso, não há crime. Essa tese:',
 'Procede, pois o assédio sexual só se configura dentro do quartel.',
 'Não procede, pois, se o agente se valeu da patente/hierarquia para obter a vantagem sexual, o crime se configura independentemente do local e do horário.',
 'Procede, pois fora do expediente cessa a relação hierárquica.',
 'Não procede, mas o fato constitui apenas infração disciplinar.',
 'Procede, desde que não haja testemunhas do fato.',
 'B',
 'A alternativa B está correta: o que caracteriza o assédio sexual é o prevalecimento da condição de superior para constranger a vítima a favorecimento sexual — e isso não desaparece fora do expediente ou da unidade. As alternativas A, C e E criam excludentes territoriais, temporais ou probatórias inexistentes. A alternativa D rebaixa o crime a mera infração disciplinar.\n\n📜 Fundamento legal vigente: Código Penal, art. 216-A. A relação hierárquica e a ascendência funcional acompanham o agente; o crime configura-se independentemente do local ou do horário, desde que o agente se prevaleça dessa condição.',
 'Código Penal, art. 216-A',
 'medio'),

-- Q20: rigor excessivo CPM art 174 (CORRIGIDO)
(@cat_pa17,
 'Um superior, ao punir um subordinado, excede a sua faculdade de punir, fazendo-o com rigor não permitido e ofendendo o subordinado por palavras. No Código Penal Militar, essa conduta corresponde ao crime de:',
 'Rigor excessivo.',
 'Prevaricação.',
 'Deixar de responsabilizar subordinado.',
 'Desacato a superior.',
 'Insubordinação.',
 'A',
 'A alternativa A está correta: exceder a faculdade de punir o subordinado, fazendo-o com rigor não permitido ou ofendendo-o por palavra, ato ou escrito, é o crime de rigor excessivo. As alternativas B, D e E descrevem tipos diversos. A alternativa C corresponde a outro crime do CPM (deixar de responsabilizar subordinado), frequentemente confundido com o rigor excessivo.\n\n📜 Fundamento legal vigente: Código Penal Militar, art. 174 (rigor excessivo): "Exceder a faculdade de punir o subordinado, fazendo-o com rigor não permitido, ou ofendendo-o por palavra, ato ou escrito". Atenção: o caderno-fonte desta disciplina atribuía o rigor excessivo ao art. 322 do CPM, o que está errado — o art. 322 trata de "deixar de responsabilizar subordinado". Rigor excessivo é o art. 174.',
 'CPM, art. 174 (rigor excessivo)',
 'dificil'),

-- Q21: violencia contra inferior CPM art 175
(@cat_pa17,
 'No contexto do assédio na caserna, um superior agride fisicamente um subordinado (inferior hierárquico) durante o expediente. No Código Penal Militar, essa conduta tipifica o crime de:',
 'Lesão corporal comum, julgada pela Justiça Comum.',
 'Violência contra inferior hierárquico.',
 'Rigor excessivo.',
 'Maus-tratos.',
 'Abuso de autoridade, exclusivamente.',
 'B',
 'A alternativa B está correta: praticar violência contra inferior hierárquico é crime militar específico, previsto no Código Penal Militar. A alternativa A ignora a competência da Justiça Militar e o tipo próprio. A alternativa C confunde com o rigor excessivo (que se refere ao abuso da faculdade de punir, não à violência física direta). A alternativa D usa tipo diverso. A alternativa E reduz a conduta a abuso de autoridade, desconsiderando o tipo militar próprio.\n\n📜 Fundamento legal vigente: Código Penal Militar, art. 175 (violência contra inferior). As condutas de assédio na caserna, conforme a intensidade, podem enquadrar-se nos tipos militares próprios — art. 174 (rigor excessivo) e art. 175 (violência contra inferior).',
 'CPM, art. 175 (violência contra inferior)',
 'medio'),

-- Q22: dano operacional
(@cat_pa17,
 'Além do sofrimento da vítima, o assédio moral e sexual na caserna produz efeitos que comprometem a própria missão. Entre esses efeitos operacionais está:',
 'O aumento da coesão e da confiança na cadeia de comando.',
 'A quebra da coesão do grupo, o aumento do absenteísmo e a perda de confiança na cadeia de comando.',
 'A melhoria da disciplina pela via do temor.',
 'A redução dos custos com saúde da tropa.',
 'A irrelevância para a operacionalidade, por ser questão apenas individual.',
 'B',
 'A alternativa B está correta: o assédio destrói o espírito de corpo, eleva o absenteísmo (faltas por adoecimento) e mina a confiança na cadeia de comando, com dano operacional direto. As alternativas A, C e D descrevem efeitos positivos ou economias que o assédio não produz — ao contrário, ele os degrada. A alternativa E nega o impacto coletivo, quando o assédio afeta toda a tropa.\n\n📜 Fundamento legal vigente: a proteção da dignidade (CF/88, art. 1º, III) e do ambiente de trabalho tem também função operacional: a coesão e a confiança são pressupostos da eficiência da tropa, comprometidos pelo assédio.',
 'CF/88, art. 1º, III; efeitos operacionais do assédio',
 'facil'),

-- Q23: responsabilidade objetiva do Estado + regresso
(@cat_pa17,
 'Um militar é vítima de assédio moral praticado por seu superior no exercício da função e sofre danos comprovados. Sobre a responsabilidade civil do Estado por esses danos, é correto afirmar que:',
 'O Estado só responde se a vítima provar dolo direto do superior.',
 'O Estado responde objetivamente pelos danos causados por seus agentes, cabendo ação de regresso contra o agente que agiu com dolo ou culpa.',
 'O Estado é irresponsável, por se tratar de ato disciplinar interno.',
 'A responsabilidade é exclusiva do agressor, sem qualquer dever do Estado.',
 'O Estado só paga se o agressor for insolvente.',
 'B',
 'A alternativa B está correta: pela Teoria do Risco Administrativo, o Estado responde objetivamente pelos danos que seus agentes causarem, bastando conduta, dano e nexo causal — independentemente de dolo ou culpa. Cabe-lhe, depois, ação de regresso contra o agente que agiu com dolo ou culpa. A alternativa A exige prova de dolo, própria da responsabilidade subjetiva. As alternativas C, D e E negam ou condicionam indevidamente o dever do Estado.\n\n📜 Fundamento legal vigente: CF/88, art. 37, §6º — "as pessoas jurídicas de direito público responderão pelos danos que seus agentes, nessa qualidade, causarem a terceiros, assegurado o direito de regresso contra o responsável nos casos de dolo ou culpa".',
 'CF/88, art. 37, §6º (responsabilidade objetiva do Estado)',
 'medio'),

-- Q24: prescricao quinquenal, ultimo ato
(@cat_pa17,
 'Uma vítima de assédio moral de trato continuado (condutas repetidas ao longo de meses) pretende ajuizar ação de indenização contra a Fazenda Pública. Sobre o prazo prescricional, é correto afirmar que:',
 'A pretensão é imprescritível, por envolver a dignidade humana.',
 'O prazo é de 5 anos, contado, em caso de assédio continuado, a partir do último ato lesivo.',
 'O prazo é de 5 anos, contado do primeiro ato de hostilidade.',
 'O prazo é de 6 meses, sob pena de decadência.',
 'O prazo é de 10 anos, pela regra geral do Código Civil.',
 'B',
 'A alternativa B está correta: as ações contra a Fazenda Pública prescrevem em 5 anos, e, no assédio moral (conduta de trato sucessivo), o marco inicial é o último ato lesivo, protegendo a vítima de condutas continuadas. A alternativa A afasta indevidamente a prescrição. A alternativa C fixa o marco no primeiro ato, o que prejudicaria a vítima. As alternativas D e E trazem prazos incorretos para a Fazenda Pública.\n\n📜 Fundamento legal vigente: Decreto nº 20.910/1932 (prescrição quinquenal das pretensões contra a Fazenda Pública). Sendo o assédio conduta de trato sucessivo, a contagem inicia-se do último ato, conforme entendimento consolidado.',
 'Decreto nº 20.910/1932 (prescrição quinquenal)',
 'medio'),

-- Q25: Lei 9.029/1995 discriminacao
(@cat_pa17,
 'Em uma unidade, uma militar é sistematicamente desqualificada e preterida em razão de ser mulher, sob comentários discriminatórios de gênero. Além de assédio moral, a conduta encontra vedação expressa em lei que proíbe:',
 'A promoção de militares por antiguidade.',
 'Práticas discriminatórias e limitativas para efeito de acesso ou manutenção da relação de trabalho, inclusive por motivo de sexo.',
 'O ingresso de mulheres em atividades operacionais.',
 'A aplicação de sanções disciplinares previstas em regulamento.',
 'O uso de uniformes que diferenciem postos e graduações.',
 'B',
 'A alternativa B está correta: a legislação veda práticas discriminatórias e limitativas para efeito de acesso ou manutenção da relação de trabalho, por motivo de sexo, origem, raça, cor, estado civil, situação familiar, deficiência ou idade. As demais alternativas descrevem atos legítimos (promoção, sanção regulamentar, uniformes) ou restrições que a lei não impõe (vedar mulheres em operações).\n\n📜 Fundamento legal vigente: Lei nº 9.029/1995, que proíbe práticas discriminatórias e limitativas no acesso e na manutenção da relação de trabalho — aplicável, por analogia protetiva, ao ambiente funcional militar, reforçando a vedação à discriminação de gênero.',
 'Lei nº 9.029/1995 (vedação à discriminação no trabalho)',
 'medio'),

-- Q26: CEDM dever de urbanidade
(@cat_pa17,
 'A subordinação hierárquica é pilar da caserna. Um superior sustenta que, por ser comandante, pode tratar o subordinado como quiser, inclusive humilhando-o. Sobre os limites da subordinação, é correto afirmar que:',
 'A subordinação autoriza o superior a atingir a dignidade pessoal do subordinado.',
 'A subordinação não afeta a dignidade pessoal; é dever do superior tratar o subordinado com justiça, consideração e urbanidade.',
 'O subordinado renuncia à sua dignidade ao ingressar na corporação.',
 'A urbanidade é facultativa quando o superior está sob pressão operacional.',
 'A dignidade só é protegida fora do serviço.',
 'B',
 'A alternativa B está correta: a subordinação refere-se estritamente à estrutura hierárquica do serviço e não dá ao superior o direito de violar a honra ou a dignidade do subordinado, sendo dever tratá-lo com justiça, consideração e urbanidade. As alternativas A, C, D e E supõem uma renúncia ou suspensão da dignidade que a ordem jurídica não admite.\n\n📜 Fundamento legal vigente: CEDM/RR (Lei nº 963/2014), arts. 15 e 17 — a subordinação não afeta a dignidade pessoal, e a civilidade e o tratamento respeitoso são deveres éticos, em consonância com a dignidade da pessoa humana (CF/88, art. 1º, III).',
 'CEDM/RR (Lei 963/2014), arts. 15 e 17; CF/88, art. 1º, III',
 'facil'),

-- Q27: POP vitima
(@cat_pa17,
 'Um militar percebe estar sendo vítima de assédio moral reiterado. Segundo o procedimento recomendado de reação, os primeiros passos que ele deve adotar são:',
 'Reagir com agressão física ao assediador para restaurar a honra.',
 'Interromper a conduta com um "não" firme e reunir registros (e-mails, mensagens, áudios) e testemunhas.',
 'Abandonar o serviço e aguardar a exclusão por deserção.',
 'Silenciar para não quebrar a hierarquia.',
 'Divulgar o caso em redes sociais anônimas.',
 'B',
 'A alternativa B está correta: à vítima recomenda-se interromper a conduta de forma firme e, sobretudo, registrar (guardar e-mails, prints, áudios e listar testemunhas), consubstanciando a materialidade da futura denúncia. As alternativas A e C sugerem condutas que agravam a situação do próprio militar. A alternativa D reforça a impunidade pelo silêncio. A alternativa E opta por um canal impróprio e anônimo, em vez dos canais institucionais.\n\n📜 Fundamento legal vigente: a reunião de provas documentais e testemunhais é passo essencial para a apuração; o registro protege a vítima e viabiliza a responsabilização, sem prejuízo do dever institucional de sigilo e de proteção contra retaliações.',
 'Procedimento de reação da vítima (reunião de provas)',
 'facil'),

-- Q28: POP testemunha (omissao reforca impunidade)
(@cat_pa17,
 'Um militar presencia um colega sofrendo assédio, mas pensa em silenciar para "não se envolver". Segundo a orientação sobre a conduta da testemunha, o correto é:',
 'Manter o silêncio, em nome da camaradagem com o assediador.',
 'Intervir se for seguro, apoiar a vítima e reportar o fato à cadeia de comando ou a órgão competente, pois a omissão reforça a impunidade.',
 'Comunicar o fato apenas se for formalmente interrogado.',
 'Aplicar uma punição imediata ao assediador.',
 'Aguardar que a própria vítima resolva sozinha.',
 'B',
 'A alternativa B está correta: a testemunha deve intervir (quando seguro), apoiar a vítima e reportar o fato, porque a omissão e o silêncio reforçam a impunidade e perpetuam o assédio. A alternativa A confunde camaradagem com cumplicidade. A alternativa C condiciona a ação a uma formalidade. A alternativa D atribui à testemunha um poder punitivo que ela não tem. A alternativa E transfere à vítima um ônus que é coletivo.\n\n📜 Fundamento legal vigente: a camaradagem verdadeira baseia-se na honra e no respeito mútuo (CEDM/RR — Lei nº 963/2014) e não justifica acobertar assédio; o dever de reportar contribui para a integridade da instituição.',
 'CEDM/RR (Lei 963/2014); dever de reportar (testemunha)',
 'medio'),

-- Q29: canais de denuncia e sigilo
(@cat_pa17,
 'Uma vítima de assédio deseja formalizar denúncia, temendo retaliações. Sobre os canais disponíveis e as garantias, é correto afirmar que:',
 'O único canal possível é a mídia, pois a corporação sempre acoberta o agressor.',
 'A denúncia pode seguir pela cadeia de comando e pela Corregedoria (canal interno, formal e sigiloso), sendo o sigilo e a proteção contra retaliações deveres da instituição.',
 'A denúncia só é válida se feita verbalmente ao próprio agressor.',
 'O sigilo é uma liberalidade do comandante, não um dever.',
 'A vítima deve custear a apuração para que ela ocorra.',
 'B',
 'A alternativa B está correta: os canais institucionais incluem a cadeia de comando (primeiro nível) e a Corregedoria (canal interno, formal e sigiloso), sendo o sigilo e a proteção contra retaliações deveres da instituição. A alternativa A descarta indevidamente os canais institucionais. As alternativas C, D e E deturpam o procedimento, o dever de sigilo e o custeio da apuração.\n\n📜 Fundamento legal vigente: o dever de apurar com sigilo e de proteger a vítima decorre dos princípios da administração pública e da dignidade da pessoa (CF/88, art. 1º, III); a Corregedoria é o órgão interno próprio para a apuração formal e reservada.',
 'CF/88, art. 1º, III; canais institucionais de denúncia',
 'facil'),

-- Q30: instancia externa = MP Estadual junto a JME (CORRIGIDO)
(@cat_pa17,
 'Uma praça da Polícia Militar constata que o assediador tem grande influência na cadeia de comando e teme parcialidade na apuração interna. Buscando uma instância externa e imparcial, o órgão adequado para militar estadual é:',
 'O Ministério Público Militar (MPM), que oficia junto à Justiça Militar da União.',
 'O Ministério Público do Estado, com atribuição junto à Justiça Militar Estadual.',
 'O Superior Tribunal Militar (STM).',
 'A Ouvidoria do Exército Brasileiro.',
 'O Conselho Nacional de Justiça, em primeira instância.',
 'B',
 'A alternativa B está correta: para o militar estadual (PM/CBM), a instância externa é o Ministério Público do Estado, que oficia junto à Justiça Militar Estadual. A alternativa A confunde as esferas: o Ministério Público Militar (MPM) atua junto à Justiça Militar da União (Forças Armadas), não sobre militares estaduais. As alternativas C, D e E indicam órgãos federais ou sem atribuição para a apuração pretendida.\n\n📜 Fundamento legal vigente: a Justiça Militar Estadual e o respectivo Ministério Público do Estado têm atribuição sobre os militares estaduais (CF/88, art. 125, §§ 3º a 5º). Atenção: o slide-fonte indicava o MPM, o que é impreciso para militar estadual — o correto é o MP Estadual junto à JME.',
 'CF/88, art. 125, §§ 4º e 5º (JME e MP Estadual)',
 'dificil');
