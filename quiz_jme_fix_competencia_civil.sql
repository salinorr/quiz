-- ============================================================
-- CORRECAO — Disciplina 1 (JME): questao "competencia civil da JME apos EC 45"
-- Problema: o enunciado perguntava sobre a competencia da JME, mas a unica
-- alternativa correta (E) falava da JMF (o que a Justica Militar da Uniao NAO
-- tem). Confuso. Reescrita para o gabarito responder diretamente sobre a JME
-- (competencia + juiz de direito singular), virando a JMF um distrator.
-- Aplicada nas DUAS categorias espelhadas: cat 12 (Prova) e cat 13 (Quiz).
-- Verificado contra CF/88, art. 125, §§4o e 5o (EC 45/2004).
-- ============================================================
SET NAMES utf8mb4;

UPDATE questoes SET
  enunciado = 'Após a EC 45/2004, a Justiça Militar Estadual (JME) passou a ter, além da competência penal, competência civil (administrativo-disciplinar). Sobre essa competência e sobre quem exerce o julgamento, assinale a alternativa correta:',
  opcao_a = 'A JME passou a julgar as ações judiciais contra atos disciplinares militares, cabendo esse julgamento, de forma singular, ao Juiz de Direito do juízo militar.',
  opcao_b = 'Essas ações são julgadas pelo Conselho de Justiça, sob a presidência de um oficial superior.',
  opcao_c = 'A competência civil abrange apenas a reintegração de militares demitidos.',
  opcao_d = 'A JME só pode rever as punições aplicadas a oficiais, cabendo as das praças à Justiça Comum.',
  opcao_e = 'A mesma competência civil foi atribuída à Justiça Militar da União sobre os atos disciplinares das Forças Armadas.',
  resposta_correta = 'A',
  explicacao = 'A alternativa A está correta: a EC 45/2004 ampliou a competência da JME para além dos crimes militares, incluindo o julgamento das ações judiciais contra atos disciplinares militares; e a Constituição atribuiu esse julgamento, de forma singular, ao Juiz de Direito do juízo militar. A alternativa B erra duplamente — não é o Conselho de Justiça que julga essas ações, e o Conselho, quando atua, é presidido por juiz de direito, não por oficial. A alternativa C restringe indevidamente a competência à reintegração; a D restringe indevidamente aos oficiais. A alternativa E é falsa e representa a "pegadinha": a Justiça Militar da União tem competência apenas penal e NÃO recebeu essa competência civil/administrativa — é justamente aí que está a assimetria entre as duas justiças militares.\n\n📜 Fundamento legal vigente: CF/88, art. 125, §4º (a JME processa e julga "as ações judiciais contra atos disciplinares militares") e §5º ("Compete aos juízes de direito do juízo militar processar e julgar, singularmente, os crimes militares cometidos contra civis e as ações judiciais contra atos disciplinares militares"), ambos na redação da EC 45/2004. A Justiça Militar da União (art. 122) tem competência apenas penal.',
  referencia_legal = 'CF/88, art. 125, §§4º e 5º (EC 45/2004)'
  WHERE id IN (673, 703);
