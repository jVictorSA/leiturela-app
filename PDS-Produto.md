# Projeto

Nosso público alvo são crianças de 6 a 14 anos de idade com dislexia que enfrentam desafios na leitura e escrita, cuja necessidade é ter apoio personalizado na alfabetização, recursos visuais e interativos que facilitem o aprendizado, jogos educativos que incentivem a prática sem frustração, feedback imediato e positivo, além de um ambiente digital que respeite o ritmo individual, [...]

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

### Persona 1: Crianças

São crianças de 6 a 14 anos de idade com dislexia que enfrentam desafios na leitura e escrita. Podem apresentar dificuldade em associar sons às letras, inversão de palavras e letras, e problemas com a memorização de palavras. Elas têm necessidade de apoio personalizado na alfabetização, recursos visuais e interativos que facilitem o aprendizado, jogos educativos que incentivem a prática sem frustração, feedback imediato e positivo, além de um ambiente digital que respeite o ritmo individual. O objetivo é desenvolver habilidades de leitura e escrita de forma lúdica e eficiente, ganhando confiança e autonomia no aprendizado.

### Persona 2: Responsável

Tem acima de 20 anos, são pais ou cuidadores das crianças, preocupados com o desenvolvimento acadêmico e emocional de seus filhos. Podem ter conhecimento limitado sobre dislexia e suas implicações, mas estão dispostos a apoiar e se engajar no processo de aprendizado. Tem necessidade de ferramentas para monitorar o progresso da criança, informações claras e acessíveis sobre dislexia e estratégias de apoio, além de orientações sobre como utilizar o aplicativo para maximizar os benefícios.

### Persona 3: Professor

Tem de 25 a 60 anos de idade, são educadores com experiência no ensino fundamental, que podem ou não ter formação específica em educação especial. Estão comprometidos em ajudar todos os alunos a alcançar o sucesso acadêmico, mas podem enfrentar desafios ao lidar com necessidades individuais como a dislexia. 

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
     
<!--
### Marco 4 - Além dos Minigames de história

#### Funcionalidades 

- [x] Funcionalidade 1: Minigames avulso
   - Parte de história para o usuário treinar dificuldades específicas, como grafema, som e voz. 
   - Aplicar repetição espaçada aos erros mais frequentes cometidos durante o minigame.
   -->
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
