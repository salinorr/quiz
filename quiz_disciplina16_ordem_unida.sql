-- ============================================================
-- QUIZ — Disciplina 16/20 do CHO: Ordem Unida com Espadas e Honras Fúnebres
-- 30 questões — doutrina de cerimonial militar (manejo de espada e honras póstumas)
-- Modo Quiz Livre (categoria sem a palavra "prova" no nome)
-- Base doutrinária: Manual C 22-5 (Ordem Unida com Espadas) e Vade-Mécum 09 — VM 09
--   (Honras Fúnebres), Exército Brasileiro — posições e movimentos com espada
--   (Sentido, Descansar, Desembainhar/Embainhar-Arma, Ombro-Arma, Apresentar-Arma,
--   Arma Suspensa, Espada em Marcha, Em Funeral-Arma), deslocamentos e comandos de
--   desfile (Sem Cadência, Cobrir), participação de oficiais sem comando, e honras
--   fúnebres (datas de restrição, cobertura do ataúde com a Bandeira Nacional,
--   Comissões de Pêsames, Toque de Silêncio, Guardas e Escoltas Fúnebres por posto,
--   salvas de artilharia, descargas de fuzil, hasteamento em Luto Nacional).
-- Observação sobre a fonte: disciplina baseada em doutrina interna do Exército
--   Brasileiro (manuais de cerimonial militar — C 22-5 e VM 09), sem lei pública
--   numerada correspondente — NÃO há legislação para baixar nesta disciplina.
-- ============================================================
SET NAMES utf8mb4;

-- Cria a categoria so se ainda nao existir. NAO usar INSERT IGNORE: categorias.nome
-- nao tem indice UNIQUE, entao o IGNORE nao dedupe e cria uma categoria duplicada vazia.
INSERT INTO categorias (nome, descricao)
SELECT 'Ordem Unida com Espadas — CHO 16', 'Disciplina 16/20 do CHO — Manejo de espada em cerimonial militar (Manual C 22-5) e Honras Fúnebres (Vade-Mécum 09): posições, movimentos, deslocamentos, guardas, escoltas e salvas'
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categorias WHERE nome = 'Ordem Unida com Espadas — CHO 16');

SET @cat_ou16 = (SELECT id FROM categorias WHERE nome = 'Ordem Unida com Espadas — CHO 16' ORDER BY id LIMIT 1);

-- Aposenta questoes ja carregadas desta categoria (idempotente em recarga; FK RESTRICT).
UPDATE questoes SET ativa = 0 WHERE categoria_id = @cat_ou16;

INSERT INTO questoes
    (categoria_id, enunciado, opcao_a, opcao_b, opcao_c, opcao_d, opcao_e,
     resposta_correta, explicacao, referencia_legal, nivel)
VALUES

-- Q01: Posição de Sentido — espada embainhada
(@cat_ou16,
 'Na posição de "Sentido", com a espada devidamente embainhada e fora do gancho, qual deve ser a postura correta da mão esquerda e da bainha?',
 'Segurar a bainha acima da braçadeira, com o braço estendido e dedos em garra.',
 'Segurar a bainha abaixo da braçadeira, braço ligeiramente curvo, com o polegar entre a bainha e o corpo.',
 'Segurar a bainha pelo bocal, mantendo o polegar distendido sobre o copo da espada.',
 'Manter a mão esquerda colada à coxa, enquanto a bainha permanece presa exclusivamente pelo gancho.',
 'Segurar a bainha abaixo da braçadeira, com as costas da mão voltadas para o corpo e dedos voltados para cima.',
 'B',
 'A alternativa B está correta: o oficial segura a espada abaixo da braçadeira com a mão esquerda, braço ligeiramente curvo, dedos unidos e voltados para baixo, e o polegar posicionado entre a bainha e o corpo. A alternativa A inverte a posição (acima da braçadeira, braço estendido), o que não corresponde à técnica. A alternativa C descreve uma empunhadura pelo bocal, inexistente nesta posição. A alternativa D ignora a exigência de a mão esquerda efetivamente segurar a bainha, e não apenas repousar na coxa. A alternativa E descreve uma orientação incorreta dos dedos e do dorso da mão.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário, não legal — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever a posição de "Sentido" com espada embainhada. Trata-se de doutrina interna de cerimonial militar, sem lei pública numerada correspondente nesta disciplina.',
 'Manual C 22-5, Seção 3-22, alínea "a"',
 'facil'),

-- Q02: Posição de Descansar — espada embainhada
(@cat_ou16,
 'Durante a posição de "Descansar" com a espada embainhada, qual o procedimento correto em relação aos membros superiores do oficial?',
 'A mão direita deve segurar o punho da espada para evitar a oscilação da lâmina.',
 'A mão esquerda sobe para a braçadeira enquanto a direita permanece colada à coxa.',
 'A espada permanece na configuração da posição de "Sentido" e a mão direita fica caída naturalmente, com o dorso para a frente.',
 'Ambas as mãos devem ser posicionadas nas costas, conforme o descanso sem arma.',
 'A mão esquerda solta a bainha, permitindo que esta fique presa apenas pelo fiel no gancho.',
 'C',
 'A alternativa C está correta: na posição de Descansar com espada embainhada, a espada mantém-se na configuração de "Sentido" e a mão direita cai naturalmente ao lado do corpo, apresentando o dorso para a frente. A alternativa A descreve uma empunhadura desnecessária do punho. A alternativa B inverte as funções das mãos esquerda e direita. A alternativa D aplica ao militar armado o procedimento do descanso sem arma, o que é incorreto. A alternativa E abandona a bainha à própria sorte, contrariando a exigência de que a mão esquerda continue a segurá-la.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever a posição de "Descansar" com espada embainhada. Não há lei pública correspondente para esta disciplina.',
 'Manual C 22-5, Seção 3-22, alínea "b"',
 'facil'),

-- Q03: Desembainhar-Arma — função da mão esquerda
(@cat_ou16,
 'No comando de "Desembainhar-Arma", o oficial realiza uma sequência de movimentos enérgicos. Após a retirada da lâmina, qual é o procedimento correto a ser executado pela mão esquerda?',
 'Deve permanecer solta ao lado do corpo até o próximo comando.',
 'A mão direita traz a espada para a posição vertical à frente do rosto em um tempo único, sem participação da esquerda.',
 'Deve prender a bainha no gancho e, em seguida, assumir a posição regulamentar de sentido (desembainhada).',
 'O olhar deve permanecer fixo à frente enquanto a mão direita busca o fiador por tato.',
 'A lâmina deve ser retirada lentamente para evitar o contato com o bocal da bainha.',
 'C',
 'A alternativa C está correta: após retirar a lâmina com energia e enfiar a mão no fiador, a mão esquerda tem a função técnica de prender a bainha no gancho antes de assumir sua posição regulamentar. A alternativa A ignora a tarefa específica atribuída à mão esquerda. A alternativa B descreve outro movimento (Ombro-Arma), não o desembainhar. A alternativa D descreve corretamente o cuidado com o olhar e o fiador, mas omite a etapa da bainha, tornando a resposta incompleta frente à alternativa C. A alternativa E contraria a exigência de energia na execução do movimento.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o movimento de "Desembainhar-Arma". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "c"',
 'medio'),

-- Q04: Sentido desembainhada — ponta e fio da lâmina
(@cat_ou16,
 'Na posição de "Sentido" com a espada desembainhada, onde devem estar, respectivamente, a ponta da arma e o fio da lâmina?',
 'Suspensa a 10 cm do solo e fio voltado para a frente.',
 'No solo, junto ao pé direito, e fio voltado para trás.',
 'No solo, junto ao pé direito, e fio voltado para a esquerda.',
 'No solo, entre os pés, e fio voltado para a direita.',
 'Suspensa a 20 cm do solo e fio voltado para trás.',
 'B',
 'A alternativa B está correta: a posição de sentido desembainhada exige que a espada esteja ao longo do corpo, com a ponta no solo junto ao pé direito e o fio obrigatoriamente voltado para trás. A alternativa A descreve uma posição suspensa, própria de outro movimento (Arma Suspensa), não do Sentido. A alternativa C erra a orientação do fio. A alternativa D erra tanto a posição da ponta (entre os pés) quanto a direção do fio. A alternativa E confunde a distância do solo com a de "Arma Suspensa" (20 cm), incompatível com a posição de Sentido.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever a posição de "Sentido" com espada desembainhada. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "d"',
 'medio'),

-- Q05: Embainhar-Arma — erro procedimental comum
(@cat_ou16,
 'Sobre o movimento de "Embainhar-Arma", assinale a alternativa que aponta um erro procedimental comum cometido por oficiais em treinamento:',
 'A mão esquerda retira a bainha do gancho e a empunha logo abaixo da braçadeira.',
 'O oficial deve olhar para a bainha para introduzir a lâmina com segurança.',
 'A introdução da lâmina na bainha deve ser realizada de forma enérgica.',
 'O oficial mantém o olhar fixo à frente, evitando olhar para a bainha durante a introdução da lâmina.',
 'A mão direita, após o movimento, volta prontamente ao lado direito do corpo.',
 'D',
 'A alternativa D está correta como o erro procedimental: é incorreto não olhar para a bainha durante o embainhamento, pois a doutrina exige que o oficial olhe para a bainha no momento de introduzir a lâmina. As alternativas A, B, C e E descrevem, cada uma, procedimentos corretos do movimento — retirar a bainha do gancho e empunhá-la abaixo da braçadeira, olhar para a bainha, introduzir a lâmina com energia e retornar a mão direita ao corpo —, não configurando, portanto, erros.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o movimento de "Embainhar-Arma". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "p"',
 'medio'),

-- Q06: Sentido desembainhada — configuração dos dedos
(@cat_ou16,
 'Qual a configuração correta dos dedos da mão esquerda na posição de "Sentido" com a espada desembainhada e presa ao gancho?',
 'Polegar dobrado sobre o indicador, segurando o bocal da bainha.',
 'Todos os dedos unidos e distendidos sobre a coxa esquerda, sem tocar na bainha.',
 'Polegar distendido entre o corpo e a bainha, com os demais dedos unidos e distendidos do lado contrário.',
 'Mão fechada em punho sobre a braçadeira da bainha.',
 'Polegar e indicador formando um arco sobre o gancho da bainha.',
 'C',
 'A alternativa C está correta: a mão esquerda sobre a bainha deve ter o polegar distendido entre o corpo e a bainha, enquanto os demais dedos permanecem unidos e distendidos no lado oposto. A alternativa A descreve uma flexão do polegar não prevista. A alternativa B afasta indevidamente a mão da bainha, que deve permanecer em contato. A alternativa D descreve o fechamento da mão em punho, incompatível com a exigência de dedos distendidos. A alternativa E descreve um arco sobre o gancho que não corresponde à técnica regulamentar.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "d"',
 'medio'),

-- Q07: Ombro-Arma — tempos e mão esquerda no 1º tempo
(@cat_ou16,
 'O movimento de "Ombro-Arma", partindo da posição de "Sentido", é decomposto em quantos tempos, e qual a função da mão esquerda no 1º tempo?',
 'Três tempos; a mão esquerda permanece colada à coxa.',
 'Quatro tempos; a mão esquerda segura a lâmina, mantendo-a paralela ao solo.',
 'Dois tempos; a mão esquerda auxilia o equilíbrio do copo.',
 'Quatro tempos; a mão esquerda segura a braçadeira da bainha.',
 'Três tempos; a mão esquerda segura a espada pelo punho.',
 'B',
 'A alternativa B está correta: o movimento é executado em quatro tempos, e no 1º tempo o oficial levanta a espada enquanto a mão esquerda a segura pela lâmina, mantendo-a paralela ao solo. A alternativa A erra tanto o número de tempos quanto a função da mão esquerda. A alternativa C reduz o movimento a apenas dois tempos, o que é incorreto. A alternativa D atribui à mão esquerda uma função (segurar a braçadeira da bainha) que não corresponde ao 1º tempo deste movimento. A alternativa E erra o número de tempos e descreve empunhadura pelo punho, não pela lâmina.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o movimento de "Ombro-Arma". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "f", item (1)',
 'medio'),

-- Q08: Ombro-Arma — 3º tempo, empunhadura
(@cat_ou16,
 'No 3º tempo do movimento de "Ombro-Arma" (partindo de "Sentido"), de que forma o oficial deve empunhar a espada?',
 'Com todos os dedos cerrados fortemente em torno do punho.',
 'Pelos dedos polegar e indicador, mantendo os demais dedos unidos e distendidos.',
 'Com a palma da mão voltada para cima, apoiando a cruzeta.',
 'Apenas pelo fiador, mantendo os dedos distendidos.',
 'Com o polegar sobre o copo e os demais dedos na bainha.',
 'B',
 'A alternativa B está correta: no 3º tempo, a técnica exige que o oficial empunhe a espada pelos dedos polegar e indicador, mantendo os demais dedos unidos e distendidos, com o copo na altura do quadril. A alternativa A descreve um punho cerrado, incompatível com a leveza exigida na empunhadura. A alternativa C descreve uma orientação da palma que não corresponde ao movimento. A alternativa D restringe indevidamente a empunhadura apenas ao fiador. A alternativa E mistura elementos de outra posição (mão sobre a bainha), estranhos a este tempo do Ombro-Arma.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "f", item (3)',
 'dificil'),

-- Q09: Apresentar-Arma — 1º tempo (do Ombro-Arma)
(@cat_ou16,
 'No movimento de "Apresentar-Arma", partindo do "Ombro-Arma", como deve estar posicionada a espada no 1º tempo?',
 'À frente do rosto, braço unido ao corpo, copo à altura do queixo e fio para a esquerda.',
 'À frente do peito, braço distendido, copo à altura da cintura e fio para a frente.',
 'Lateral ao corpo, braço dobrado, copo à altura do ombro e fio para trás.',
 'À frente do rosto, braço afastado do corpo, copo à altura dos olhos e fio para a direita.',
 'Na horizontal à frente dos olhos, com a mão esquerda auxiliando na ponta.',
 'A',
 'A alternativa A está correta: o 1º tempo do "Apresentar-Arma" consiste em trazer a espada à frente do rosto, mantendo o braço unido ao corpo, o copo na altura do queixo e o fio voltado para a esquerda. A alternativa B descreve uma posição com braço distendido e copo na cintura, incompatível com o movimento. A alternativa C posiciona a espada lateralmente, o que não condiz com a trajetória à frente do rosto. A alternativa D erra ao afastar o braço do corpo e inverter a direção do fio. A alternativa E introduz indevidamente a participação da mão esquerda na ponta, estranha a este tempo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o movimento de "Apresentar-Arma". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "h", item (1)',
 'dificil'),

-- Q10: Apresentar-Arma — posição final (3º tempo), ângulo
(@cat_ou16,
 'A posição final do "Apresentar-Arma" (3º tempo) exige precisão angular. Qual o ângulo formado pela lâmina com a linha dos ombros, e para onde aponta a ponta da espada?',
 'Ângulo de 90 graus; ponta na direção do pé esquerdo.',
 'Ângulo de 45 graus; ponta na direção do prolongamento do pé direito.',
 'Ângulo de 30 graus; ponta na direção do solo entre os pés.',
 'Ângulo de 15 graus; ponta na vertical para baixo.',
 'Ângulo de 60 graus; ponta na direção da coxa direita.',
 'B',
 'A alternativa B está correta: na posição final abatida, a lâmina forma um ângulo de 45 graus com a linha dos ombros, com a ponta direcionada para o prolongamento do pé direito. A alternativa A exagera o ângulo para 90 graus e erra o lado de referência. A alternativa C reduz o ângulo e desloca a ponta para o centro, entre os pés. A alternativa D reduz demais o ângulo e orienta a ponta verticalmente, o que não corresponde à posição abatida. A alternativa E aumenta o ângulo e aponta para a coxa, imprecisão incompatível com a técnica.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "h", item (3)',
 'dificil'),

-- Q11: Apresentar-Arma partindo de Sentido — diferença
(@cat_ou16,
 'Ao executar "Apresentar-Arma" partindo da posição de "Sentido", qual a principal diferença desse movimento em relação ao mesmo comando iniciado a partir do "Ombro-Arma"?',
 'É realizado em quatro tempos, em vez de três.',
 'O 1º tempo leva a espada diretamente da posição de Sentido para a frente do rosto, sem passar pela vertical inicial do Ombro-Arma.',
 'A espada deve tocar o solo no 2º tempo.',
 'O fio da lâmina deve ser voltado para a direita no 1º tempo.',
 'Não há diferença técnica; os movimentos são absolutamente idênticos em todos os tempos.',
 'B',
 'A alternativa B está correta: o movimento mantém o mesmo número de tempos (três), mas, no 1º tempo, a espada é trazida diretamente da posição de "Sentido" para a frente do rosto, sem passar pela fase vertical característica do Ombro-Arma. A alternativa A altera indevidamente o número de tempos, que permanece o mesmo. A alternativa C introduz um contato com o solo que não ocorre neste movimento. A alternativa D inverte a orientação correta do fio, que continua para a esquerda. A alternativa E nega a diferença de fato existente no 1º tempo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "i"',
 'dificil'),

-- Q12: Descansar-Arma partindo de Ombro-Arma — 1º tempo
(@cat_ou16,
 'O movimento de "Descansar-Arma", partindo da posição de "Ombro-Arma", possui qual característica no seu 1º tempo?',
 'A espada é abaixada diretamente ao solo.',
 'A mão direita dá um giro para baixo na espada, e a mão esquerda segura a lâmina paralela ao solo.',
 'A mão esquerda solta a bainha e segura o punho junto com a mão direita.',
 'A espada é trazida à frente do peito na vertical.',
 'A ponta da espada deve ser voltada para trás em 45 graus.',
 'B',
 'A alternativa B está correta: no 1º tempo da transição do "Ombro-Arma" para o "Descansar-Arma", a mão direita gira a espada para baixo enquanto a mão esquerda a estabiliza, segurando-a paralela ao solo. A alternativa A antecipa indevidamente o abaixamento direto ao solo, que não ocorre neste tempo inicial. A alternativa C descreve uma dupla empunhadura do punho que não corresponde ao movimento, já que a bainha permanece fora de cena nesta fase. A alternativa D descreve uma posição vertical à frente do peito, própria de outro movimento. A alternativa E atribui um ângulo à ponta que não é característico deste 1º tempo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "g", item (1)',
 'medio'),

-- Q13: Sentido partindo de Apresentar-Arma — 3º tempo
(@cat_ou16,
 'No movimento de retorno à posição de "Sentido", partindo de "Apresentar-Arma", o que o oficial executa no 3º tempo?',
 'Traz a espada para a frente do rosto.',
 'Abaixa a espada para a posição de Sentido desembainhada, movimento idêntico ao 2º tempo do "Descansar-Arma" partindo do "Ombro-Arma".',
 'Embainha a espada em movimento contínuo.',
 'Coloca a espada no ombro direito.',
 'Faz um giro de 180 graus com o copo da espada.',
 'B',
 'A alternativa B está correta: o 3º tempo deste movimento é idêntico ao 2º tempo de "Descansar-Arma" vindo do "Ombro-Arma", resultando na posição de sentido com a ponta da espada no solo. A alternativa A descreve um movimento próprio do "Apresentar-Arma", não do retorno a "Sentido". A alternativa C introduz o embainhamento, ato que não faz parte desta sequência específica. A alternativa D reposiciona a espada no ombro, o que contraria a finalidade do movimento, que é retornar a "Sentido". A alternativa E descreve um giro de 180 graus não previsto neste tempo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "l", item (3)',
 'dificil'),

-- Q14: Passagem do Ombro-Arma para Espada em Marcha
(@cat_ou16,
 'A passagem do "Ombro-Arma" para a posição de "Espada em Marcha", no passo ordinário, é realizada em quantos tempos, e qual é a referência para o início do movimento?',
 'Três tempos; ao tocar o pé direito no solo.',
 'Dois tempos; ao tocar o pé esquerdo no solo.',
 'Três tempos; ao tocar o pé esquerdo no solo.',
 'Um tempo; ao comando de "Marche".',
 'Dois tempos; ao tocar o pé direito no solo.',
 'B',
 'A alternativa B está correta: este movimento específico é realizado em dois tempos, iniciando-se quando o pé esquerdo toca o solo. A alternativa A erra tanto o número de tempos quanto o pé de referência. A alternativa C mantém o pé esquerdo como referência, mas erra o número de tempos. A alternativa D reduz o movimento a um único tempo vinculado ao comando de voz, o que não corresponde à técnica, vinculada ao toque do pé no solo. A alternativa E mantém o número correto de tempos, mas erra o pé de referência.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever a passagem do "Ombro-Arma" para "Espada em Marcha". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-23, alínea "b", item (8)',
 'dificil'),

-- Q15: Arma Suspensa — distância da ponta ao solo
(@cat_ou16,
 'Ao comando de "Arma Suspensa", a espada deve ser levantada energicamente. Qual a distância aproximada correta da ponta da espada em relação ao solo?',
 '10 cm.',
 '15 cm.',
 '20 cm.',
 '30 cm.',
 '45 cm.',
 'C',
 'A alternativa C está correta: ao comando de "Arma Suspensa", o oficial deve levantar a espada de modo que a ponta fique afastada do solo em aproximadamente 20 centímetros. As alternativas A e B reduzem essa distância aquém do previsto. As alternativas D e E aumentam a distância além do parâmetro correto. A precisão dessa medida é o que diferencia tecnicamente esta posição da posição de "Sentido" desembainhada, na qual a ponta toca o solo.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o comando de "Arma Suspensa". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "m"',
 'medio'),

-- Q16: Passo Ordinário — oscilação do braço direito
(@cat_ou16,
 'Durante o deslocamento em "Passo Ordinário" com a espada desembainhada, o braço direito oscila paralelamente ao corpo. Quais são os ângulos aproximados dessa oscilação à frente e atrás, respectivamente?',
 '90 graus à frente e 45 graus atrás.',
 '45 graus à frente e 30 graus atrás.',
 '30 graus à frente e 15 graus atrás.',
 '60 graus à frente e 30 graus atrás.',
 'O braço direito deve permanecer rígido, sem oscilação.',
 'B',
 'A alternativa B está correta: no passo ordinário, com a espada na posição de "Espada em Marcha", o braço direito oscila aproximadamente 45 graus para a frente e 30 graus para trás. A alternativa A exagera ambos os ângulos. A alternativa C reduz ambos os ângulos aquém do previsto. A alternativa D aumenta o ângulo frontal indevidamente. A alternativa E nega a oscilação natural do braço, que é característica do deslocamento em marcha, e não uma rigidez artificial.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o deslocamento em "Passo Ordinário" com espada. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-23, alínea "b", item (3)',
 'medio'),

-- Q17: Sem Cadência — procedimento de embainhamento
(@cat_ou16,
 'Qual o procedimento obrigatório para oficiais com espada desembainhada ao comando de "Sem Cadência!"?',
 'Manter a espada na posição de "Espada em Marcha".',
 'Colocar a espada em "Ombro-Arma" imediatamente.',
 'Embainhar a espada antes de romper a marcha.',
 'Colocar a espada na posição de "Arma Suspensa".',
 'Segurar a lâmina com a mão esquerda para evitar ruídos.',
 'C',
 'A alternativa C está correta: ao comando de "Sem Cadência!", os oficiais devem embainhar a espada antes de romperem a marcha à voz de "Marche!". A alternativa A mantém a espada desembainhada, o que contraria a exigência específica deste comando. A alternativa B propõe outra posição (Ombro-Arma) que não corresponde ao procedimento previsto. A alternativa D também mantém a arma desembainhada, incompatível com o comando. A alternativa E propõe um artifício informal (segurar a lâmina para evitar ruído) que não substitui a obrigação regulamentar de embainhar.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao regular o comando de "Sem Cadência!" para oficiais com espada. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-23, alínea "b", item (4), subitem "a"',
 'medio'),

-- Q18: Comando de Cobrir — posição e procedimento
(@cat_ou16,
 'Ao comando de "Cobrir!", qual posição técnica o oficial deve assumir com a espada, e qual o seu procedimento subsequente?',
 '"Arma Suspensa"; e deve permanecer voltado para a frente.',
 '"Espada Suspensa"; e deve voltar a frente para a tropa, a fim de corrigir a cobertura das colunas.',
 '"Apresentar-Arma"; e deve olhar para a direita.',
 '"Sentido"; e deve caminhar até o guia da tropa.',
 '"Ombro-Arma"; e deve conferir o alinhamento das fileiras sem se voltar para a tropa.',
 'B',
 'A alternativa B está correta: ao comando de "Cobrir!", o oficial assume a posição de "Espada Suspensa" e volta a frente para a tropa, a fim de corrigir a cobertura das colunas. A alternativa A propõe uma posição diferente ("Arma Suspensa") e nega o giro necessário para observar a tropa. A alternativa C descreve outra posição de espada e uma orientação do olhar incompatível com a finalidade do comando. A alternativa D propõe deslocamento até o guia, procedimento distinto do previsto. A alternativa E nega o giro do oficial para a tropa, essencial à correção da cobertura.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao regular o comando de "Cobrir!". Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "n", item (1)',
 'medio'),

-- Q19: Oficiais sem comando em formaturas
(@cat_ou16,
 'Situação Hipotética: Durante um desfile militar, oficiais que não exercem comando de fração participam da formatura sem uma tropa sob suas ordens diretas. Segundo a doutrina, qual é o procedimento correto desses oficiais quanto ao uso da espada?',
 'Devem desembainhar a espada em sincronia com os comandantes de fração.',
 'Não desembainharão as espadas e prestarão continência como se estivessem desarmados.',
 'Devem manter a espada na bainha, mas executar os tempos do "Apresentar-Arma" apenas com as mãos.',
 'Devem desembainhar a espada somente durante o momento do desfile em continência.',
 'Devem portar a espada no gancho, mas segurar o copo com a mão direita durante todo o desfile.',
 'B',
 'A alternativa B está correta: o regulamento estabelece que oficiais sem comando não desembainharão as espadas e prestarão continência como se estivessem desarmados. A alternativa A determina um desembainhamento que não se aplica a quem não exerce comando de fração. A alternativa C propõe uma simulação de movimentos sem a espada, o que não corresponde ao procedimento previsto. A alternativa D permite o desembainhamento em um momento específico, contrariando a regra geral de não desembainhar. A alternativa E propõe uma postura intermediária (segurar o copo) não prevista na doutrina para esses oficiais.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao regular a participação de oficiais sem comando em formaturas e desfiles. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-23, alínea "c"',
 'dificil'),

-- Q20: Espada em Marcha — posição da lâmina
(@cat_ou16,
 'Na posição de "Espada em Marcha" (3º tempo do rompimento de marcha), como a lâmina deve estar posicionada em relação ao corpo do oficial?',
 'Afastada do corpo, para permitir a oscilação livre do braço.',
 'Encostada na parte interna do braço e no ombro direito.',
 'Encostada no peito, na diagonal, cruzando o tronco.',
 'Encostada na parte externa do braço direito.',
 'Na vertical, sem tocar o uniforme.',
 'B',
 'A alternativa B está correta: no 3º tempo da transição para a marcha, o braço direito traz a espada para junto do corpo, com a lâmina encostada na parte interna do braço e no ombro direito. A alternativa A afasta a lâmina do corpo, o que contraria a exigência de proximidade. A alternativa C posiciona a espada cruzando o tronco, o que não corresponde à técnica descrita. A alternativa D erra o lado de contato da lâmina com o braço (externa, e não interna). A alternativa E mantém a espada na vertical sem contato, imprecisão incompatível com a posição de marcha.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-23, alínea "b", item (1), subitem "c"',
 'dificil'),

-- Q21: Honras fúnebres — situações de exclusão
(@cat_ou16,
 'As honras fúnebres, como homenagens póstumas, sofrem restrições quanto a determinadas datas e circunstâncias. Em qual das situações a seguir NÃO haverá prestação de honras fúnebres?',
 'Somente aos domingos e em feriados religiosos nacionais.',
 'Em Grandes Datas nacionais, feriados nacionais específicos, datas festivas, no aniversário da Organização Militar do extinto (a critério do comandante) ou em caso de perturbação da ordem pública.',
 'Apenas quando a família do extinto não possuir recursos para o fardamento.',
 'Somente quando o falecido for praça com menos de 10 anos de serviço.',
 'Em dias de chuva intensa ou quando a banda de música estiver em manutenção.',
 'B',
 'A alternativa B está correta: a doutrina detalha as hipóteses de exclusão da prestação de honras fúnebres, incluindo Grandes Datas nacionais, feriados nacionais específicos, datas festivas, o aniversário da Organização Militar do extinto (a critério do comandante), a perturbação da ordem pública e o estado de prontidão da tropa. A alternativa A restringe indevidamente as exclusões apenas a domingos e feriados religiosos. A alternativa C condiciona a prestação das honras a um critério financeiro da família, inexistente na doutrina. A alternativa D vincula a exclusão ao tempo de serviço do falecido, critério não previsto para esta finalidade. A alternativa E baseia a exclusão em condições meteorológicas ou logísticas pontuais, sem correspondência doutrinária.\n\n📜 Fundamento legal vigente: o fundamento é doutrinário, não legal — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao detalhar as hipóteses de exclusão da prestação de honras fúnebres. Trata-se de doutrina interna de cerimonial militar, sem lei pública numerada correspondente.',
 'VM 09, Cap. 3, Seção 4',
 'medio'),

-- Q22: Cobertura do ataúde com a Bandeira Nacional
(@cat_ou16,
 'Sobre o cerimonial de cobertura do ataúde com a Bandeira Nacional, qual a disposição correta dos elementos do Pavilhão Nacional?',
 'Tralha nos pés e espiga à esquerda.',
 'Tralha na cabeceira e estrela isolada (espiga) à direita.',
 'Tralha à direita e espiga na cabeceira.',
 'Tralha na cabeceira e espiga à esquerda.',
 'A bandeira deve ser colocada de forma que a tralha fique para o lado do sol nascente.',
 'B',
 'A alternativa B está correta: o cerimonial prescreve que o ataúde seja coberto com a tralha no lado da cabeceira e a estrela isolada (espiga) posicionada à direita. A alternativa A inverte a posição da tralha, colocando-a nos pés. A alternativa C troca as posições de tralha e espiga entre si. A alternativa D mantém corretamente a tralha na cabeceira, mas erra o lado da espiga, que deve ser à direita, não à esquerda. A alternativa E propõe um critério de orientação solar estranho ao cerimonial, que se baseia na posição física do ataúde (cabeceira/pés), não em pontos cardeais.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao regular a cobertura do ataúde com a Bandeira Nacional. Não há lei pública correspondente.',
 'VM 09, Cap. 3, Seção 3',
 'medio'),

-- Q23: Comissões de Pêsames
(@cat_ou16,
 'De acordo com a doutrina de Honras Fúnebres, qual a composição mínima e a finalidade das "Comissões de Pêsames"?',
 'Dez militares, com a finalidade de realizar a segurança do féretro.',
 'No mínimo três militares da ativa, com a finalidade de acompanhar os restos mortais e demonstrar publicamente o sentimento de pesar.',
 'Cinco militares da reserva, com a finalidade de realizar o toque de silêncio.',
 'Dois oficiais e dois praças, com a finalidade de entregar a bandeira à família.',
 'Toda a subunidade do extinto, com a finalidade de marchar em passo acelerado.',
 'B',
 'A alternativa B está correta: as comissões de pêsames são integradas por, no mínimo, três militares da ativa, com a finalidade de acompanhar os despojos e demonstrar publicamente o sentimento de pesar da corporação. A alternativa A propõe um efetivo maior e uma finalidade de segurança, estranha à comissão de pêsames. A alternativa C restringe indevidamente a composição a militares da reserva e atribui uma finalidade (toque de silêncio) que não é a da comissão. A alternativa D detalha uma composição específica e uma finalidade (entrega da bandeira) não correspondentes à comissão de pêsames. A alternativa E propõe o emprego de toda a subunidade, efetivo desproporcional ao previsto.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao regular as Comissões de Pêsames. Não há lei pública correspondente.',
 'VM 09, Cap. 2',
 'facil'),

-- Q24: Toque de Silêncio — autoridades com direito
(@cat_ou16,
 'O "Toque de Silêncio" é um momento solene das honras fúnebres. Além de militares da ativa, quais autoridades, tendo o ataúde coberto pela Bandeira Nacional, fazem jus a este toque ao descer o corpo à sepultura?',
 'Apenas Oficiais-Generais em serviço ativo.',
 'Militares que tenham integrado o Alto-Comando do Exército ou exercido cargo de Ministro de Estado.',
 'Todos os militares da reserva não remunerada, sem distinção de cargo.',
 'Apenas o Presidente da República e Governadores de Estado.',
 'Qualquer cidadão que tenha prestado serviço militar obrigatório.',
 'B',
 'A alternativa B está correta: militares que integraram o Alto-Comando do Exército ou exerceram o cargo de Ministro de Estado têm direito à cobertura do ataúde com a Bandeira Nacional e ao toque de silêncio no momento da inumação. A alternativa A restringe indevidamente o direito apenas a Oficiais-Generais na ativa, excluindo os que exerceram cargos de Alto-Comando ou Ministério mesmo já na reserva. A alternativa C amplia demais o direito a todos os militares da reserva, sem qualquer distinção de cargo exercido. A alternativa D restringe o direito a autoridades políticas específicas, não correspondendo ao critério doutrinário, ligado ao histórico militar do falecido. A alternativa E amplia desproporcionalmente o direito a qualquer cidadão.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao regular o direito ao Toque de Silêncio. Não há lei pública correspondente.',
 'VM 09, Cap. 2',
 'dificil'),

-- Q25: Em Funeral-Arma — 1º tempo
(@cat_ou16,
 'No movimento de "Em Funeral-Arma", o oficial executa dois tempos. O que caracteriza o 1º tempo deste movimento?',
 'A espada é cravada no solo à frente do oficial.',
 'A espada é trazida à frente do corpo e gira 180 graus, ficando o copo voltado para a frente.',
 'A espada é colocada sobre o ombro esquerdo com o fio voltado para cima.',
 'A espada é embainhada com o bocal voltado para trás.',
 'A mão esquerda segura o copo enquanto a mão direita segura a ponta da lâmina.',
 'B',
 'A alternativa B está correta: no 1º tempo do "Em Funeral-Arma", a espada é trazida à frente do corpo e girada 180 graus, de modo que o copo fique voltado para a frente. A alternativa A descreve um movimento de cravar a espada no solo, estranho a esta posição. A alternativa C posiciona a espada sobre o ombro esquerdo, o que não corresponde ao movimento. A alternativa D introduz o embainhamento, que não faz parte deste tempo específico. A alternativa E descreve uma inversão de empunhaduras entre as mãos que não corresponde à técnica prevista.\n\n📜 Fundamento legal vigente: conceito doutrinário — Manual C 22-5 (Ordem Unida com Espadas), Exército Brasileiro, ao descrever o movimento de "Em Funeral-Arma", empregado em honras fúnebres. Não há lei pública correspondente.',
 'Manual C 22-5, Seção 3-22, alínea "o", item (1)',
 'dificil'),

-- Q26: Guardas Fúnebres — efetivo para Oficial Superior
(@cat_ou16,
 'As Guardas Fúnebres possuem efetivos proporcionais ao posto da autoridade falecida. Para um Oficial Superior, qual o valor da tropa destinada a esta honra?',
 'Uma unidade.',
 'Duas subunidades.',
 'Uma subunidade.',
 'Um pelotão.',
 'Um grupo de combate.',
 'B',
 'A alternativa B está correta: segundo a tabela de correspondência de efetivos, para Oficiais Superiores a guarda fúnebre deve ter o valor de duas subunidades. A alternativa A propõe um efetivo de unidade, superior ao previsto para este posto. A alternativa C propõe apenas uma subunidade, efetivo inferior ao correto. A alternativa D propõe um pelotão, efetivo bem inferior ao devido. A alternativa E propõe um grupo de combate, efetivo mínimo incompatível com a honra devida a um Oficial Superior.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao estabelecer a tabela de efetivos das Guardas Fúnebres por posto. Não há lei pública correspondente.',
 'VM 09, Cap. 4, Seção 3, alínea "d"',
 'medio'),

-- Q27: Escolta Fúnebre — associação posto/efetivo e exclusões
(@cat_ou16,
 'Sobre a "Escolta Fúnebre", assinale a alternativa que corretamente associa o posto ao efetivo devido e respeita as regras de exclusão previstas na doutrina:',
 'Oficiais Subalternos têm direito a um pelotão; praças têm direito a um Grupo de Combate.',
 'Oficiais Intermediários têm direito a dois Grupos de Combate; praças não têm direito à escolta fúnebre.',
 'Oficiais-Generais têm direito a uma unidade; praças têm direito a uma esquadra.',
 'Oficiais Superiores têm direito a duas subunidades; praças têm direito a um pelotão.',
 'O Presidente da República tem direito a uma subunidade motorizada.',
 'B',
 'A alternativa B está correta: Oficiais Intermediários fazem jus a uma escolta de dois Grupos de Combate, e a doutrina veda expressamente o direito de escolta fúnebre às praças. A alternativa A atribui efetivos incorretos aos Oficiais Subalternos e concede indevidamente escolta às praças. A alternativa C mistura o efetivo de Oficiais-Generais com uma concessão indevida de escolta a praças. A alternativa D confunde o efetivo correto (que é de Escolta, não de Guarda Fúnebre) e também concede indevidamente escolta a praças. A alternativa E propõe um efetivo específico para o Presidente da República não correspondente à tabela doutrinária de escoltas fúnebres militares.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao estabelecer a tabela de efetivos das Escoltas Fúnebres e a vedação às praças. Não há lei pública correspondente.',
 'VM 09, Cap. 5, Seção 3, alíneas "e" e "h"',
 'dificil'),

-- Q28: Salvas de artilharia por posto
(@cat_ou16,
 'Quantos tiros de artilharia compõem a salva fúnebre para um General-de-Exército e para um General-de-Brigada, respectivamente?',
 '21 e 19 tiros.',
 '19 e 17 tiros.',
 '17 e 13 tiros.',
 '15 e 11 tiros.',
 '17 e 15 tiros.',
 'C',
 'A alternativa C está correta: de acordo com a tabela doutrinária de salvas fúnebres, Generais-de-Exército têm direito a 17 tiros e Generais-de-Brigada a 13 tiros. As alternativas A, B, D e E apresentam combinações numéricas que não correspondem à tabela de correspondência entre posto e quantidade de tiros prevista na doutrina.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao estabelecer a tabela de salvas de artilharia por posto. Não há lei pública correspondente.',
 'VM 09, Cap. 6, Seção 2',
 'dificil'),

-- Q29: Descargas de fuzil pela Guarda Fúnebre
(@cat_ou16,
 'Sobre a execução das descargas de fuzil pela Guarda Fúnebre durante um sepultamento, assinale a alternativa tecnicamente correta:',
 'São dadas três descargas quando o féretro alcançar a esquerda da guarda.',
 'São dadas três descargas quando o féretro alcançar a direita da guarda.',
 'As descargas são dadas simultaneamente por toda a unidade, independentemente do efetivo empregado.',
 'São dadas cinco descargas de fuzil especificamente em homenagem ao Presidente da República.',
 'As descargas ocorrem apenas após o sepultamento estar totalmente concluído.',
 'B',
 'A alternativa B está correta: a guarda fúnebre deve dar três descargas de fuzil quando sua direita for alcançada pelo féretro. A alternativa A erra o lado de referência, indicando a esquerda em vez da direita. A alternativa C generaliza indevidamente a execução a toda a unidade, sem relação com o efetivo especificamente destacado para a guarda. A alternativa D propõe um número de descargas (cinco) não previsto na doutrina, tampouco vinculado especificamente ao cargo de Presidente da República neste contexto. A alternativa E desloca o momento da execução para depois de concluído o sepultamento, quando na verdade ocorre no momento em que o féretro alcança a guarda.\n\n📜 Fundamento legal vigente: conceito doutrinário — Vade-Mécum 09 (Honras Fúnebres), Exército Brasileiro, ao regular as descargas de fuzil pela Guarda Fúnebre. Não há lei pública correspondente.',
 'VM 09, Cap. 4, Seção 2',
 'medio'),

-- Q30: Bandeira Nacional em Luto Nacional — hasteamento/arriação
(@cat_ou16,
 'Em dias de Luto Nacional, qual o procedimento ritualístico correto para o hasteamento e a arriação da Bandeira Nacional no mastro da Organização Militar?',
 'Hasteia-se diretamente até o meio-mastro e arria-se diretamente dessa posição.',
 'Hasteia-se até o topo e desce-se até o meio-mastro; na arriação, sobe-se novamente ao topo e depois desce-se para ser guardada.',
 'Hasteia-se até o topo e permanece lá, com um laço de crepe negro amarrado no mastro.',
 'Não se realiza o hasteamento em dias de luto, mantendo-se a bandeira guardada.',
 'Hasteia-se até um terço do mastro, permanecendo ali durante todo o dia.',
 'B',
 'A alternativa B está correta: em dias de Luto Nacional, a Bandeira Nacional deve sempre ser conduzida ao topo do mastro antes de ser posicionada a meio-mastro, e também deve retornar ao topo antes de ser arriada e guardada. A alternativa A propõe um hasteamento direto ao meio-mastro, sem a passagem obrigatória pelo topo. A alternativa C propõe o uso de um laço de crepe negro no mastro, artifício não previsto no cerimonial de luto para o hasteamento em meio-mastro. A alternativa D nega indevidamente a realização do hasteamento em dias de luto. A alternativa E propõe uma posição intermediária (um terço do mastro) não prevista na doutrina, que estabelece o meio-mastro como referência.\n\n📜 Fundamento legal vigente: diferentemente das demais posições e movimentos com espada desta disciplina (doutrina do Manual C 22-5 e do Vade-Mécum 09, sem lei numerada), o hasteamento da Bandeira Nacional em luto TEM lei específica: a Lei nº 5.700/1971, art. 17, dispõe que, quando em funeral, a Bandeira fica a meio-mastro, mas "no hasteamento ou arriamento, deve ser levada inicialmente até o tope". O art. 16 acrescenta que, havendo várias bandeiras, a Nacional é a primeira a atingir o tope e a última a dele descer.',
 'Lei nº 5.700/1971, arts. 16 e 17 (Bandeira Nacional em funeral/luto)',
 'medio');

