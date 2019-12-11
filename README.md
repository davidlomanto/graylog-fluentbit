# graylog-fluentbit

Passo a passo de como subir o graylog, fluentbit e o mongodb. Depois como configurar toda plataforma do graylog. (Streams, Dashboard e alerta).

# É necessário ter o elasticsearch funcionando! (versão 6.7.2)

**Instruções(passo a passo):**

a. Abrir o arquivo values.yaml;

  Configurar values.yaml:
  
    a1. Alterar campo *rootEmail*;    
    a2. Alterar em elasticsearch o campo hosts para apontar para o elasticsearch instalado;
    a3. Alterar em transportEmail os campos:
      a31. *enable: true*;
      a32. *hostname: "(o host do seu servidor de email), ex: smtp.gmail.com";
      a33. *port: "(porta do servidor de email)";
      a34. *authUsername: "(seu endereço de email)";
      a35. *authPassword: "password digital do seu email".    
            
b. Abrir o terminal; 

c. Entrar como “Root user”; 

d. Executar o bash “start.sh” (comando: ./start.sh);

e. Entrar pelo browser no graylog com o endereço fornecido no terminal;

f. Colocar como usuario: "admin" (isso pode ser alterado no values.yaml);

g. Colocar senha: "adminadmin123456789" (isso pode ser alterado no values.yaml);

h. Pronto! você vai tar logado no Graylog!

**Configurando o Graylog:**

a. INPUTS:

    a1. Ir em *System -> Inputs*;
    a2. Em *"Select Input"*, escolha GELF TCP;
    a3. Clique em *Launch new Input*;
    a3. Em Node, Selecione o nó no graylog;
    a4. Em Port, troque para 12222;
    a5. Desça e clique em *Save*;
    a6. Pronto! O input vai começar sozinho segundo informação na tela. Caso não dê start, clique em *"Start Input"*.
  
b. STREAMS:

    b1. Ir em *Streams*;
    b2. Colocar titulo e descrição;
    b3. Após criado, clicar em *Manage Rules*;
    b4. Em *Select an input*, selecionar o input criado no item a.;
    b5. Clicar em *Add stream rule* e configurar as rules que você deseja para só aparecer log com essa regra;
    b6. Clicar em *"Manage Alert"*.

c. ALERT:

    c1. Clicar em "*Event Definitions*";
    c2. Clicar em *"Create Event Definition";
    c3. Colocar título em descrição;
    c4. Na aba *Condition*, selecionar o Condition Type para *Filter & Aggregation*;
    c5. Em *"Search Query"*, colocar qual o field que será disparado o alerta e o valor. ex: pod_name:reviews* (o field é             pod_name e o valor reviews. O asterisco serve para qualquer concatenação com reviews;
    c6. Em *Streams*, seleciona a determinada em "b";
    c7. Em *Create Events for Definition if...*, selecionar *Aggregation of results reaches a threshold*;
    c8. Em *Create Events for Definition -> If*, escolher *Count()*;
    c9. Em *is*, selecionar o que deseja;
    c10. Em *Threshold*, o valor para disparar o alerta;
    c11. Na aba *Notifications*, Clicar em *Add Notification*;
    c12. Em *Choose Notification*, selecionar *Create New Notification*;
    c13. Colocar título e descrição;
    c14. Em *Notification Type*, Selecionar Email;
    c15. Preencher todos os campos de acordo com o que for pedido. Clicar em Done.
    
 d. VIEWS:
 
    d1. Clicar em *Views-> Create New*;
    d2. Selecionar a stream do item b no campo *Select streams*;
    d3. No lado esquerdo, em *Fields*, clicar em *pod_name* e selecionar *Agregate*;
    d4. No quadro gerado, clicar na "seta pra baixo" no canto superior direito e selecionar *edit*;
    d5. Em *Visualization type*, selecione *Pie Chart*;
    d6. Clique em *"Save"*;
    d7. No lado esquerdo, em *Fields*, clicar em *pod_name* novamente e selecionar *Agregate*;
    d8. No Quadro *Message Count*, clicar na "seta pra baixo" no canto superior direito e selecionar *edit*;
    d9. Em *columns*, selecionar *pod_name*;
    d10. Clique em *"Save"*;
    d11. Por fim, clique na parte de cima no simbolo ">"(play) para carregar as informações.    
  
e. Pronto! estará configurado tudo necessário.


  
  



Caso queira terminar tudo, basta rodar o bash "clean.sh" (comando ./clean.sh).
