-- ============================================================
-- CORRECOES a partir da reanalise do NotebookLM (verificadas contra a lei).
-- Em vez de DELETAR as 3 questoes com lei revogada (sugestao do NotebookLM),
-- foram ATUALIZADAS para a lei vigente -- mantem 30 questoes/disciplina.
-- ============================================================
SET NAMES utf8mb4;

-- (1) disc 8 Q23 (id=927) — nacionalidade: a EC 131/2023 substituiu "atividade
--     nociva ao interesse nacional" por "fraude/atentado a ordem constitucional".
--     O gabarito C estava com o TEXTO REVOGADO. Atualiza opcao C e explicacao.
UPDATE questoes SET
  opcao_c = 'Cancelamento da naturalização, por sentença judicial, em virtude de fraude relacionada ao processo de naturalização ou de atentado contra a ordem constitucional e o Estado Democrático.',
  explicacao = 'A alternativa C está correta: a perda da nacionalidade do brasileiro naturalizado pode dar-se pelo cancelamento da naturalização, por sentença judicial, em razão de fraude no processo de naturalização ou de atentado contra a ordem constitucional e o Estado Democrático. A alternativa A (viagem ao exterior) e a D (exercício de direito político no exterior) não são hipóteses de perda; a B (condenação por crime comum) também não; a E (aquisição de outra nacionalidade por reconhecimento de nacionalidade originária pela lei estrangeira) é justamente uma EXCEÇÃO que não acarreta a perda.\n\n📜 Fundamento legal vigente: CF/88, art. 12, §4º, I, na redação da Emenda Constitucional nº 131/2023, que substituiu a antiga hipótese de "atividade nociva ao interesse nacional" pela de "fraude relacionada ao processo de naturalização ou de atentado contra a ordem constitucional e o Estado Democrático".'
  WHERE id = 927;

-- (2) disc 4 Q30 (id=814) — abuso de autoridade: enunciado citava a Lei 4.898/65
--     (revogada em 2020). Reformula para a Lei 13.869/2019 vigente.
UPDATE questoes SET
  enunciado = 'A Lei de Abuso de Autoridade em vigor (Lei nº 13.869/2019) protege a liberdade de locomoção contra atos arbitrários. Entre as condutas abaixo, constitui crime de abuso de autoridade relacionado à privação da liberdade:',
  explicacao = 'A alternativa E está correta: ordenar ou executar medida privativa da liberdade individual sem as formalidades legais ou com abuso de poder atenta contra a liberdade de locomoção e configura abuso de autoridade. As alternativas A (abordagem fundada em elementos objetivos), B (exigir a CNH do condutor), C (solicitar identificação de pessoa em atitude suspeita) e D (prender em flagrante no domicílio durante o dia) descrevem atos legais e regulares da atividade policial, não abusivos.\n\n📜 Fundamento legal vigente: Lei nº 13.869/2019, art. 9º — "Decretar medida de privação da liberdade em manifesta desconformidade com as hipóteses legais: Pena - detenção, de 1 a 4 anos, e multa." Esta lei disciplina integralmente o abuso de autoridade desde 2020, tendo revogado a antiga Lei nº 4.898/1965.',
  referencia_legal = 'Lei 13.869/2019, art. 9º'
  WHERE id = 814;

-- (3) disc 7 Q5 (id=879) — improbidade: enunciado cobrava o art. 4º da LIA,
--     revogado pela Lei 14.230/2021. Reformula para a CF/88, art. 37 (LIMPE).
UPDATE questoes SET
  enunciado = 'A Constituição Federal impõe à Administração Pública, de forma expressa, a observância de princípios no trato dos assuntos que lhe são afetos. Analise as assertivas: I. Legalidade e impessoalidade. II. Moralidade e publicidade. III. Probabilidade e eficácia. Quais estão corretas?',
  explicacao = 'A alternativa A está correta: os itens I (legalidade e impessoalidade) e II (moralidade e publicidade) reproduzem princípios constitucionais expressos da Administração Pública. O item III é falso porque "probabilidade" e "eficácia" não são princípios: os termos corretos seriam "probidade" (dever geral) e, entre os expressos, "eficiência" — não "eficácia".\n\n📜 Fundamento legal vigente: CF/88, art. 37, caput, que enuncia expressamente os princípios da Administração Pública — Legalidade, Impessoalidade, Moralidade, Publicidade e Eficiência (LIMPE). A observância desses princípios é exigível diretamente do texto constitucional.',
  referencia_legal = 'CF/88, art. 37, caput (LIMPE)'
  WHERE id = 879;

-- (4) disc 2 Q27 (id=1261) — remove meta-comentario (aviso ao autor) da explicacao.
UPDATE questoes SET
  explicacao = 'A alternativa C está correta — quando a violação da regra de separação de custodiados vem acompanhada de sofrimento físico ou mental do preso, a conduta se desclassifica do abuso de autoridade para o crime de tortura, infração equiparada a hedionda. A mantém indevidamente o enquadramento na Lei de Abuso de Autoridade com mera causa de aumento; B aponta absorção por tipo incompatível (maus-tratos é norma geral menos grave que a tortura); D cria excludente de superlotação sem amparo legal; E nega a tipicidade penal da conduta, quando na verdade há crime — apenas de natureza diversa (tortura, não abuso de autoridade).\n\n📜 Fundamento legal vigente: Lei nº 9.455/1997 (Lei de Tortura), art. 1º, I. A violação à regra de separação de custodiados acompanhada de sofrimento físico ou mental do preso não tipifica o crime de manutenção de presos de ambos os sexos no mesmo espaço, mas o delito de tortura, infração equiparada a hediondo (Lei nº 8.072/1990).'
  WHERE id = 1261;

-- (5) disc 4 Q28 (id=812) — remove meta-comentario (nota sobre precedente) da explicacao.
UPDATE questoes SET
  explicacao = 'A alternativa C está correta: se a lei administrativa já prevê sanção específica (como o Código de Trânsito) e não ressalva a cumulação penal, o crime de desobediência é afastado, por força do caráter subsidiário do tipo. As demais alternativas descrevem situações que não afastam, por si sós, a tipicidade da desobediência.\n\n📜 Fundamento legal vigente: entendimento consolidado do STJ — quando a norma administrativa comina sanção específica ao descumprimento (como o art. 195 do CTB) sem ressalvar a cumulação com sanção penal, o descumprimento não configura o crime de desobediência do art. 330 do Código Penal, em razão dos princípios da subsidiariedade e da intervenção mínima do Direito Penal.'
  WHERE id = 812;

-- (6) disc 2 Q19 (id=1253) — tira o numero do artigo de dentro da alternativa A.
UPDATE questoes SET
  opcao_a = 'Comete crime de abuso de autoridade.'
  WHERE id = 1253 AND opcao_a LIKE '%art. 15%';

-- (7) disc 4 Q18 (id=802) — tira os numeros de artigo das alternativas A, B e C.
UPDATE questoes SET
  opcao_a = 'Crime de Resistência.',
  opcao_b = 'Crime de Desobediência.',
  opcao_c = 'Contravenção penal de recusa de dados à autoridade.'
  WHERE id = 802;

-- (8) disc 19 Q6 (id=1450) — troca o distrator absurdo (E) e ajusta a explicacao.
UPDATE questoes SET
  opcao_e = 'Abordar o veículo normalmente, uma vez que o efetivo mínimo da Categoria 1 autoriza a abordagem de qualquer veículo, independentemente do risco.',
  explicacao = 'A alternativa C está correta: diante de inferioridade numérica e tática detectada, a doutrina prioriza a segurança da equipe, recomendando a liberação do veículo sem abordagem, com o repasse imediato dos dados ao CICOp para uma abordagem posterior por guarnição reforçada. A alternativa A aumenta o risco de incidente com arma de fogo em desvantagem. A alternativa B expõe a equipe ao desembarque simultâneo de cinco ocupantes sem controle tático. A alternativa D mantém a equipe em contato direto e vulnerável enquanto aguarda reforço, o que a doutrina busca evitar. A alternativa E subestima a inferioridade tática, tratando o efetivo mínimo como suficiente para qualquer abordagem, contrariando a análise de risco.\n\n📜 Fundamento legal vigente: procedimento operacional padrão (POP) — doutrina de Técnica Policial Militar, Módulo Blitz Policial, quanto à análise de risco e à priorização da segurança da equipe. Não há lei numerada específica.'
  WHERE id = 1450;

-- (9) disc 7 Q10 (id=884) — troca o distrator absurdo (D) e ajusta a explicacao.
UPDATE questoes SET
  opcao_d = 'Proporcionalidade, pois a recusa no atendimento ao cidadão exigiria prévia ponderação entre o interesse público e o interesse particular.',
  explicacao = 'A alternativa B está correta. A atuação do Cabo movida por "desafeto pessoal" — tratando o cidadão de forma diferenciada e prejudicial em razão de relação estritamente pessoal — é o exemplo clássico de violação da Impessoalidade, princípio que veda tanto o favorecimento quanto o prejuízo de administrados por critérios subjetivos alheios ao interesse público. A alternativa A não é o princípio diretamente violado (não há interrupção do serviço, mas discriminação pessoal). "Competitividade" (alternativa C) não é princípio constitucional expresso da Administração. A alternativa D atribui o caso ao princípio da proporcionalidade, quando o princípio efetivamente violado é a impessoalidade.\n\n📜 Fundamento legal vigente: CF/88, art. 37, caput (princípio da impessoalidade).'
  WHERE id = 884;
