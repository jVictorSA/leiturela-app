# Projeto

Para a gestante, cuja necessidade é ter seu acompanhamento neonatal, o nosso aplicativo especializado é um serviço de ajuda focado em gestantes, que diferentemente do Sprout oferece uma rede de apoio e de informação verificada, o nosso produto oferece uma plataforma focada e amigável para a mulher gestante, visando ajudá-la no processo tão dificultoso que é a gestação

### Problemas

1) Problema 1
   Consultas Médicas: Agendamento e tempo de espera reduzidos para gestantes, garantindo que recebam atendimento médico regular e necessário.
2) Problema 2
   Redes de Apoio: Desenvolvimento de redes de apoio comunitárias para gestantes, como grupos de suporte e workshops.
3) Problema 3
   Informações Online: Recursos online confiáveis sobre saúde e bem-estar durante a gravidez.

### Expectativas

1) Expectativa 1  
   Telemedicina, agendamento online e acompanhamento das saúdes das gestantes.  
2) Expectativa 2  
   Redes Sociais e Fóruns. Conectar gestantes a redes de apoio locais e serviços comunitários
3) Expectativa 3  
   Artigos que ofereçam conhecimentos sobre cuidados durante a gravidez (estilo medium)  

## Personas

Uma persona representa um usuário do produto e essa descrição deve falar não só o papel, mas também suas necessidades e seus objetivos. Isso cria uma representação realista dos usuários, auxiliando a equipe a descrever funcionalidades a partir do ponto de vista de quem vai usar o produto (Aguiar, 2021).

### Persona 1: Gestante

Marcar consultas, acompanhar o progresso do processo da gestação, consumir conteúdos disponibilizados pelos profissionais da plataforma...  

Ser ajudada no processo de gestação  

### Persona 2: Especialista da Saúde

Especialista verificado da saúde (Médico, Psicólogo, Nutricionista, Fisioterapeuta). Ele tem o papel de alimentar a plataforma via perfil próprio com informações úteis para a gestante.

Promoção do seu trabalho, assim como apps de medicina e telemedicina (Doctoralia)

## Marcos

<!-- Devemos entregar **pequenas versões frequentes**. A equipe deve definir os marcos do projeto (*milestones)*, definindo os prazos de entrega e quais funcionalidades serão implementados até o final de cada marco. No final de cada marco devemos distribuir uma nova versão do produto, pronta para produção.

Podemos pensar nessas pequenas versões como MVPs (do inglês, *minimum viable product*). MVP é a versão mais simples de um produto que pode ser disponibilizada para a validação de um pequeno conjunto de hipóteses sobre o negócio. Após ser **construído,** o MVP é colocado à prova. Com isso, teremos dados que possibilitam **medir** o seu uso e, portanto, gerar o **aprendizado** desejado (Caroli, 2018). -->

### Marco 1 - Iremos solucionar a falta de entendimento de grafema.

<!-- Acreditamos que esse `Marco 1` vai conseguir `resultado esperado`. Saberemos que isso aconteceu com base em `métricas para validar a hipótese do negócio`. -->

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

<!-- Acreditamos que esse `Marco 1` vai conseguir `resultado esperado`. Saberemos que isso aconteceu com base em `métricas para validar a hipótese do negócio`. -->

#### Funcionalidades 

- [x] Funcionalidade 1. Reconhecimento de letras  e  palavras pelo som
   - Usuário relaciona letras com o som que está sendo falado no momento.
   - A criança ouve o som de algo relacionado a história e deve selecionar a palavra correta que corresponde ao som.
   - O usuário deve ouvir uma palavra e consertar a grafia da mesma, que é apresentada de modo incorreto
     
- [x] Funcionalidade 2: Reconhecimento de voz
   - Reconhecimento de voz pode ser aplicado em Minigames para fazer uma avaliação se o usuário está lendo corretamente. Seja na fala de fonemas, grafemas, sílabas ou palavras

### Marco 3 - Relatórios de desempenho do usuário e Níveis de dificuldade


<!-- Acreditamos que esse `Marco 1` vai conseguir `resultado esperado`. Saberemos que isso aconteceu com base em `métricas para validar a hipótese do negócio`. -->

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

1. **Risco 1** descrição do risco. *Severidade Baixa e Probabilidade Alta*.

   Ações para mitigação do risco:

   * Ação de mitigação 1.1.

2. **Risco 2** descrição do risco. *Severidade Média e Probabilidade Alta*.

   Ações para mitigação do risco:

   * Ação de mitigação 2.1.
   * Ação de mitigação 2.2.

## Componentes

### Aplicativo Web 
[descrição breve]
https://github.com/edgebr/templates-artefatos

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
*Desenvolvedor Sênior* <br />
*E-mail* <br />
https://github.com/edgebr

Membro 3 <br />
*Analista de Qualidade Pleno* <br />
*E-mail* <br />
https://github.com/edgebr

## Status Reports

[Status Report 1 (20/12/2022)](status_report_1.md)
