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

### Marco 1 - Iremos solucionar a falta de informações para gestantes, incluindo início da gestação, procedimentos necessários e orientações médicas.

Acreditamos que esse `Marco` vai conseguir `facilitar o processo neonatal das gestantes`. Saberemos que isso aconteceu com base no `uso da plataform pelas gestantes para acompanhar sua agenda de consultas`.

#### Funcionalidades

- [x] Funcionalidade 1: Criação de páginas com textos sobre saúde da gestante e informações sobre o processo de gravidez.
- [x] Funcionalidade 2. Desenvolvimento de um recurso visual para que a gestante acompanhe o tamanho do feto em cada período da gestação.
- [x] Funcionalidade 3. Criação de páginas para que os profissionais publiquem artigos e informações, sejam eles gratuitos ou pagos.

### Marco 2 - Finalização do módulo de Comunidade da plataforma 20/01/2023

Acreditamos que esse `Marco` vai conseguir `criar uma rede de apoio para as gestantes da plataforma`. Saberemos que isso aconteceu com base na `interação dos usuários na plataforma`.

#### Funcionalidades 

- [ ] Funcionalidade 1.
- [ ] Funcionalidade 2.
- [ ] Funcionalidade 3.

### Marco 2 - Iremos resolver a carência de informações de especialistas da área da saúde.

Acreditamos que esse `Marco` vai conseguir `trazer informações confiáveis às gestantes da plataforma`. Saberemos que isso aconteceu com base nos `artigos publicados por especialistas dentro da plataforma`.

#### Funcionalidades 

- [x] Funcionalidade 1: Criação de um fórum para que as gestantes que utilizam o aplicativo possam se comunicar com outras gestantes e obter a opinião de especialistas sobre o assunto.
- [x] Funcionalidade 2: Implementação de um sistema de verificação dos especialistas para garantir que apenas profissionais qualificados possam compartilhar informações.
- [ ] Funcionalidade 3: 

### Marco 3 - Iremos abordar o problema da ausência de uma rede de apoio para as gestantes.

Acreditamos que esse `Marco` vai conseguir `criar uma rede de apoio para as gestantes da plataforma`. Saberemos que isso aconteceu com base na `interação dos usuários na plataforma`.

#### Funcionalidades 

- [x] Funcionalidade 1: Implementação de um fórum para as gestantes poderem interagir sobre as dúvidas, vivências e demais aspectos da gestação.
- [x] Funcionalidade 2: Interações nos fóruns serão ranqueadas com base utilidade das informações, tendo informações falsas sendo penalizadas ou passíveis de exclusão.
- [x] Funcionalidade 3: Implementação do selo de verificação nos perfis dos profissionais de saúde, rankeando positivamente suas interações no fórum.


[Release Notes ](release_notes_1.md)

## Riscos

1. **Checar inscrição no Conselho Regional da área de atuação do profissional** Devemos verificar todos especialistas da saúde para saber se são de fato profissionais credenciados. *Severidade Alta e Probabilidade Média*.

   Ações para mitigação do risco:

   * Verificar junto aos Conselhos Regionais se o profissional diz quem é ser, por meio de: APIs dos Conselhos ou via Web Crawling nos sites dos mesmos.

2. **Disseminação de informação falsa dentro dos fóruns** Algumas gestantes podem disseminar informações falsas sobre os mais diversos tópicos de gravidez. *Severidade Média e Probabilidade Alta*.

   Ações para mitigação do risco:

   * Adicionar um selo de verificação (sinal de autoridade nos temas discutidos) dentro do fórum nos usuários profissionais da saúde.
   * Ranquear as interações do fórum com base no selo de verificação (usuários com autoridade podem ser mostrados acima dentro das interações do fórum)
  
3. **Baixa adesão de profissionais da saúde** Profissionais da saúde podem não utilizar a plataforma por não identificar valor na utilização da mesma. *Severidade Média e Probabilidade Média*.

   Ações para mitigação do risco:

   * Facilitar o contato entre as gestantes e os profissionais da saúde
   * Promover a exposição de profissionais na plataforma (para conseguirem agendar suas consultas com as gestantes da plataforma)

## Componentes

### Aplicativo Web 
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
