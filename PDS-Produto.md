# Projeto

Nosso público alvo são gestantes, cuja necessidade é ter seu acompanhamento neonatal, o nosso aplicativo especializado é um serviço de ajuda focado em gestantes, que diferentemente do Sprout oferece uma rede de apoio e de informação verificada, o nosso produto oferece uma plataforma focada no acompanhamento neonatal, onde as gestantes poderão observar sua agenda de consultas de diversas especialidades médicas; participar de fóruns com outras usuárias e profissionais da saúde para troca de informações; acesso a conteúdo neonatal gerado pelos profissionais da plataforma

### Problemas

1) Problema 1  
   Durante o processo de gestação, as grávidas precisam realizar diversas consultas, o que pode ser um processo árduo e complicado. Para uma gestante de primeira viagem, pode ser difícil saber quais consultas são necessárias e quais profissionais devem ser contatados.
2) Problema 2  
   Muitas gestantes enfrentam a falta de comunidades ou grupos de suporte que possam oferecer ajuda e orientação durante o período de gestação.
3) Problema 3  
   Gestantes podem ter dificuldades de encontrar fontes confiáveis sobre saúde e bem-estar durante a gravidez.

### Expectativas

1) Expectativa 1  
   Facilitar o processo de agendamento de consultas e acompanhamento da saúde das gestantes.
2) Expectativa 2  
   Conectar gestantes entre si e com redes de apoio por meio de fóruns.
3) Expectativa 3  
   Fornecer artigos confiáveis que ofereçam conhecimentos sobre cuidados durante a gravidez (estilo medium).

## Personas

### Persona 1: Gestante

Uma gestante de primeira viagem solteira que não tem muito conhecimento sobre o processo de gestação. Ela está preocupada com o processo de gestação e busca informações sobre pela internet, mas tem dificuldade em identificar informações falsas. Ela busca uma forma fácil de se manter informada sobre tudo que deve saber sobre a gestação e receber ajuda durante todo o processo.

### Persona 2: Especialista da Saúde

Um especialista de saúde (médico, psicólogo, nutricionista, fisioterapeuta) que deseja promover seu trabalho e ajudar gestantes de primeira viagem. Seu papel é fornecer informações sobre o processo gestacional, recomendações alimentares, acompanhamento psicológico, entre outros. Ele busca alimentar a plataforma com um perfil próprio, compartilhando informações úteis para as gestantes, de modo a promover seu trabalho.

## Marcos

<!-- Devemos entregar **pequenas versões frequentes**. A equipe deve definir os marcos do projeto (*milestones)*, definindo os prazos de entrega e quais funcionalidades serão implementados até o final de cada marco. No final de cada marco devemos distribuir uma nova versão do produto, pronta para produção.

Podemos pensar nessas pequenas versões como MVPs (do inglês, *minimum viable product*). MVP é a versão mais simples de um produto que pode ser disponibilizada para a validação de um pequeno conjunto de hipóteses sobre o negócio. Após ser **construído,** o MVP é colocado à prova. Com isso, teremos dados que possibilitam **medir** o seu uso e, portanto, gerar o **aprendizado** desejado (Caroli, 2018). -->

### Marco 1 - Iremos solucionar a falta de entendimento de grafema.

<!--Acreditamos que esse `Marco` vai conseguir ``.-->

#### Funcionalidades

- [x] Funcionalidade 1: Reconhecimento de letras pelo grafema
   - Ao longo da história, as crianças devem identificar as letras que faltam em palavras-chave. Cada identificação realizada ganha pontos;
   - Reorganizar as letras nas palavras que precisa ser identificada (palavra correta);
   - Associar as letras com as imagens corretas, reforçando o reconhecimento do grafema;
   - A palavra está dividida em sílabas, e a criança deve selecionar as sílabas corretas para formar a palavra.
   - As sílabas das palavras estarão flutuando na tela, e o usuário deve selecionar os fonemas existentes nas palavras faladas
   - O usuário deve montar um conjunto de palavras que são necessárias para avançar na história ( seria a senhas de acesso a algum lugar na aventura; objetos a obter; nomes de personagens e afins)
   - Ordenação de letras / sílabas
     
- [x] Funcionalidade 2: Reconhecimento de palavras e informações erradas 
   - Um personagem da história auxiliar lendo alguma informação para o usuário, mas ele lê de maneira errada e o usuário tem que identificar qual
  seria a informação certa. 

[Release Notes ](release_notes_1.md)

### Marco 2 - Iremos resolver o falta de entendimento pelo som


<!--Acreditamos que esse `Marco` vai conseguir `-->

#### Funcionalidades 

- [x] Funcionalidade 1. Reconhecimento de letras  e  palavras pelo som
   - Usuário relaciona letras com o som que está sendo falado no momento.
   - A criança ouve o som de algo relacionado a história e deve selecionar a palavra correta que corresponde ao som.
   - O usuário deve ouvir uma palavra e consertar a grafia da mesma, que é apresentada de modo incorreto
     
- [x] Funcionalidade 2: Reconhecimento de voz
   - Reconhecimento de voz pode ser aplicado em Minigames para fazer uma avaliação se o usuário está lendo corretamente. Seja na fala de fonemas, grafemas, sílabas ou palavras

### Marco 3 - Relatórios de desempenho do usuário e Níveis de dificuldade


<!--Acreditamos que esse `Marco` vai conseguir `-->

#### Funcionalidades 

- [x] Funcionalidade 1: Dashboard
   - Gráficos para mostrar o desempenho do usuário ao próprio usuário 
   - Relatório geral para todos os usuários que usa o App
     
- [x] Funcionalidade 2: Desafios ao longo do Minigame
   - Para concluir a história vai ter aplicado o marco 1 e 2 como desafios.
   - Contagem de pontuação ao passar pelos obstáculos ao logo do minigrame 
   - Ranking geral para incetivar aos usuários
     
### Marco 4 - Além dos Minigames de história

<!-- Acreditamos que esse `Marco 1` vai conseguir `resultado esperado`. Saberemos que isso aconteceu com base em `métricas para validar a hipótese do negócio`. -->

#### Funcionalidades 

- [x] Funcionalidade 1: Minigames avulso
   - Parte de história para o usuário treinar dificuldades específicas, como grafema, som e voz. 
   - Aplicar repetição espaçada aos erros mais frequentes cometidos durante o minigame.
[Release Notes ](release_notes_1.md)


## Riscos 

1. **Minigames que não melhoram o desempenho da leitura dos usuários** Os minigames podem não melhorar a leitura dos usuários. *Severidade Alta e Probabilidade Média*.

   Ações para mitigação do risco:

   * Criar minigames que trabalhem as dificuldades dos usuários, com base em estudos previamente publicados.
   * Utilizar a abordagem multissensorial para a aprendizagem da leitura, método que já fora comprovadamente efetivo na resolução do problema.

2. **Minigames que não engajam os usuários** Os minigames podem não ser interessantes ao usuários, fazendo com que os usuários não sintam vontade de usar o aplicativo. *Severidade Alta e Probabilidade Média*.

   Ações para mitigação do risco:

   * Criar minigames com contextos que interessem aos usuários. e.g. Dinossauros, Fábulas, Animais e etc.
   * Criar minigames com "Game Juice". Animações, efeitos sonoros, e feedback ativo durante os minigames, a fim de prender a atenção dos usuários.

3. **Relatórios pouco informativos** As métricas presentes no relatório devem mensurar objetivamente a melhora ou piora do desempenho dos usuários. *Severidade Média e Probabilidade Alta*.

   Ações para mitigação do risco:

   * Pesquisar métricas de avaliação da leitura de crianças disléxicas e mensurar isto dentro do aplicativo.
   * Prover visualizações claras e objetivas, tornando a assimilação do desempenho dos usuários o mais fácil possível.
  
4. **Reconhecimento de voz ser falho** O modelo de reconhecimento de voz pode apresentar problemas na trascrição da fala dos usuários. *Severidade Média e Probabilidade Média*.

   Ações para mitigação do risco:

   * Utilização de modelos mais recentes.
   * Utilizar modelos melhores (treinados com uma base de dados maior e mais diversificada), aplicando a técnica de quantização, buscando um tradeoff entre bons resultados e baixa latência.

## Componentes

### Aplicativo Mobile 
[descrição breve]
https://github.com/edgebr/templates-artefatos

## Stakeholders

Stakeholder 1 <br />
*Key User - Cargo na Empresa X* <br />
*E-mail* <br />
(xx) xxxxx-xxxx

Stakeholder 2 <br />
*Key User - Cargo na Empresa X* <br />
*E-mail* <br />
(xx) xxxxx-xxxx

## Equipe

Membro 1 <br />
*Desenvolvedor Back-End* <br />
*E-mail* <br />
djs@ic.ufal.br  
*Github* <br />
https://github.com/silvadaniell

Membro 2 <br />
*Desenvolvedor Front-End* <br />
*E-mail* <br />
gdo@ic.ufal.br  
*Github* <br />
https://github.com/GustavoDomingosO

Membro 3 <br />
*Analista de Qualidade Pleno* <br />
*E-mail* <br />
jvsa@ic.ufal.br 
*Github* <bt />
https://github.com/jVictorSA

Membro 4 <br />
*Gestor de Projetos* <br />
*E-mail* <br />
pvafs@ic.ufal.br  
*Github* <br />
https://github.com/pedrovictor48

## Status Reports

[Status Report 1 (20/12/2022)](status_report_1.md)
