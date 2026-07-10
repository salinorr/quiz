-- ============================================================
-- NORMALIZACAO — distratores fracos (descartaveis por leigo)
-- Varredura das disciplinas 3-16, 19 e 20 (a 2, 17 e 18 ja estavam no padrao):
--   quase todas com distratores legitimos. Apenas 2 alternativas genuinamente
--   descartaveis foram encontradas e substituidas por distratores plausiveis.
--   Cada troca ajusta TAMBEM a frase da explicacao que justificava a alternativa
--   antiga, para nao deixar explicacao inconsistente. Patch por ID.
-- ============================================================
SET NAMES utf8mb4;

-- disc 5 (Vulneraveis) id=769: opcB era "A imprensa, para transparencia..." (absurda).
-- Novo distrator: dispensar a comunicacao a familia (erro plausivel frente ao ECA art. 107).
UPDATE questoes SET
  opcao_b = 'Somente ao Ministério Público, dispensada a comunicação à família do apreendido.',
  explicacao = 'A alternativa C é uma garantia fundamental prevista expressamente no ECA. A alternativa A é insuficiente, pois a comunicação à autoridade judiciária é indispensável. A alternativa B está incorreta porque a comunicação à família (ou pessoa por ele indicada) é obrigatória e não pode ser dispensada. A alternativa D viola a regra da imediaticidade, criando um prazo inexistente na lei.\n\n📜 Fundamento legal vigente: ECA, art. 107: "A apreensão de qualquer adolescente e o local onde se encontra recolhido serão incontinenti comunicados à autoridade judiciária competente e à família do apreendido ou à pessoa por ele indicada." O parágrafo único ainda determina o exame imediato da possibilidade de liberação, sob pena de responsabilidade.'
  WHERE id = 769 AND opcao_b LIKE '%imprensa%';

-- disc 15 (Logistica) id=1034: opcE "Itens de luxo..." tinha tom de descarte.
-- Novo distrator: restringir estoque a consumo imediato, excluindo permanentes (erro plausivel).
UPDATE questoes SET
  opcao_e = 'Somente os bens de consumo de uso imediato, excluídos os materiais permanentes.',
  explicacao = 'A alternativa D está correta: tecnicamente, estoques são definidos como todos os bens e materiais mantidos por uma organização para atender demandas futuras, independentemente da natureza específica do item. A alternativa A confunde estoque com um sistema de referência de preços, ferramenta distinta. A alternativa B descreve bens já consumidos/utilizados, e não o estoque disponível. A alternativa C restringe indevidamente o conceito a materiais destinados ao descarte. A alternativa E restringe indevidamente o estoque aos bens de consumo de uso imediato, excluindo os materiais permanentes, quando o conceito abrange todos os bens mantidos para demandas futuras.\n\n📜 Fundamento legal vigente: conceito doutrinário — apostila de Logística Militar do CHO, ao definir tecnicamente o conceito de estoque. Não há lei pública correspondente.'
  WHERE id = 1034 AND opcao_e LIKE '%luxo%';
