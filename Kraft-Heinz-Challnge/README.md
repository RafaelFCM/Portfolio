# Challenge Kraft-Heinz ESG

<br/>
<br/>

## Descrição

Kraft-Heinz Challenge: Desenvolvimento de um sistema de
registro de feedbacks dos consumidores, sobre produtos
e serviços da Kraft-Heinz, com foco em ESG. Foi criado um
site (Java, Html, CSS, JS, Bootstrap) para preenchimento
do formulário/avaliação com informações pessoais e sua
opnião. Depois os dados foram armazenadas em BD
(Oracle SQL). Por fim os dados foram exportados para
softwares de analise de dados (Power BI).

<br/>
<br/>

## Apresentação

Você pode visualizar a apresentação [aqui](https://www.canva.com/design/DAGIH5znPsc/hoauPS35sZmklpAWGejHGw/edit?utm_content=DAGIH5znPsc&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

<br/>
<br/>

## Detalhamento
Componentes da solução tecnológica (desenho da arquitetura em qualquer ferramenta):

Detalhamento inicial de componentes da solução tecnológica (arquitetura), explicando:
linguagens de programação: foi usado o vs code para programar o site, usando html, css e o framework bootstrap para responsividade no site. O site consiste de 3 páginas, a principal onde apresentamos o formulário pra cadastro da colaboração (e quando falamos cadastro é só o envio do formulario, não criamos uma aplicação que faz a validação do cliente tipo um login e senha, decidimos que não havia necessidade tendo em vista que não é algo que uma mesma pessoa faça várias vezes e mesmo que faça é só preencher as informações novamente), outra pagina pra erro na aplicação, e um último para êxito no cadastramento
também usamos o Eclipse para a programação em java, para o backend, sendo util fazer a conexão entre o site e o banco de dados que armazena as informações do formulário
Além disso, para fazer a análise dos dados de forma eficiente necessitasse de uma quantidade relativamente grande de dados, e tais dados são mockados/simulados (instrução da kraft-heinz). Nosso time não foi capaz de achar possíveis dados já prontos na internet, por isso criamos nossos próprios dados com uma aplicação java, um gerador de inserts para o sql. Buscamos informações sobre endereços no país todo, ceps, logradouros, bairros etc.
no banco de dados foi usado o oracle sql developer, poderosa ferramenta de desenvolvimento de banco de dados¸facilitar o gerenciamento, desenvolvimento e manutenção de bancos, sendo sua principal finalidade para nosso projeto a exportação dos dados, linkamos o oracle com o tableau
usamos o software tableau para a visualização de dados e análise que nos permite transformar informações complexas em insights visuais compreensíveis, sendo útil para criar painéis interativos, relatórios e gráficos que auxiliam na tomada de decisões, além de conseguir os dados em tempo real/atualizados
sistema operacional não entendi se é para colocar o windows

Diagrama de atividades que explica os passos de uso do software (diagrama pode ser feito com softwares como BIZAGI Modeler ou ASTAH/Activity diagram para exemplificar o fluxo de tarefas de uso do sistema):

Modelo de banco de dados (diagrama):
Nas etapas anteriores do projeto, nós tínhamos separados as informações dos clientes, das colaborações e dos endereços em 3 classes(no java)/tabelas(no sql) diferentes, além de ter muito mais variáveis por classe/tabela. Porém percebemos que tinha muitas variáveis inúteis, tendo em vista o objetivo final do projeto que é a análise dos dados. Sendo assim mudamos totalmente a arquitetura dos dados/projeto, tendo apenas uma classe/tabela com todas as informações importantes. Por ser uma tabela apenas não tem ligações/relações
 
![image](https://github.com/RafaelFCM/Portfolio/assets/100213402/33ba5adc-5d1a-4f0c-a826-8616aae285e8)

Explicação dos próximos passos do projeto caso não concluído (visão de futuro): interação com o chat gpt para pegar as palavras chaves de cada mensagem/contribuição, como nome de produtos ou serviços para auxiliar na tomada de decisão.


## Rodando

