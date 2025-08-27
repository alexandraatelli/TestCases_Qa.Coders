[Documentation]    Funcionalidade User  

*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Variables ***
${URL}        https://api-shogun.qacoders.dev.br/api
${EMAIL}      sysadmin@qacoders.com
${PASSWORD}   1234@Test
${TOKEN}


*** Keywords ***
#LOGIN ADMIN
Criar Sessao
    ${headers}        Create Dictionary        accept=application/json        Content-Type=application/json    
    Create Session        alias=shogun         url=${URL}        headers=${headers}    verify=${True}
Realizar Login ADMIN
    Criar Sessao
    ${body}=    Create Dictionary    mail=${EMAIL}   password=${PASSWORD}
    Log    ${body}
    ${resposta}=    POST On Session    alias=shogun    url=/login/    json=${body}    expected_status=200
    Log    ${resposta.json()}
    ${TOKEN}=    Set Variable    ${resposta.json()["token"]}
    Set Suite Variable    ${TOKEN}
    ${user_id}=    Set Variable    ${resposta.json()["user"]["_id"]}
    Set Suite Variable    ${user_id}
    [Return]    ${resposta.json()}

Validar token Autorizacao
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${resposta}=    GET On Session    alias=shogun    url=/validateToken    headers=${headers}    expected_status=200
    Log    Resposta da solicitacao: ${resposta.content}
    Log    ${TOKEN}
Criar Sessao autorizada
    ${headers}=    Create Dictionary    accept=application/json    Content-Type=application/json    Authorization=${TOKEN}
    Create Session    alias=shogun    url=${URL}    headers=${headers}    verify=${True} 

    ${resposta}=    Realizar Login ADMIN
    Dictionary Should Contain Item    ${resposta}    msg    Olá Qa-Coders-SYSADMIN, autenticação autorizada com sucesso!



#User
Cadastrar Novo Usuario e Salvar ID
    Realizar Login ADMIN
    # Definindo variáveis iniciais (disponíveis para toda a suite)
    Set Suite Variable    ${USER_FULLNAME}        Paola Janoni
    Set Suite Variable    ${USER_EMAIL}           paola@uol.com.br
    Set Suite Variable    ${ACCESSPROFILE}        ADMIN
    Set Suite Variable    ${USER_CPF}             39069117408
    Set Suite Variable    ${USER_PASSWORD}        paola#Ca10    
    
    # Montando corpo da requisição
    ${body}     Create Dictionary
    ...         fullName=${USER_FULLNAME}
    ...         mail=${USER_EMAIL}
    ...         accessProfile=${ACCESSPROFILE}
    ...         cpf=${USER_CPF}
    ...         password=${USER_PASSWORD}
    ...         confirmPassword=${USER_PASSWORD}

    Log    ${body}
    
    ${headers}        Create Dictionary    Authorization=${TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}    POST On Session    alias=shogun    url=/user/    headers=${headers}    json=${body} 
    Log    ${resposta.json()}

    # Atualizando variáveis com os dados retornados da API, disponíveis para toda a suite
    Set Suite Variable    ${USER_ID}         ${resposta.json()["user"]["_id"]} 
    Set Suite Variable    ${USER_FULLNAME}   ${resposta.json()["user"]["fullName"]}
    Set Suite Variable    ${USER_EMAIL}      ${resposta.json()["user"]["mail"]}
    Set Suite Variable    ${USER_CPF}        ${resposta.json()["user"]["cpf"]}
    Set Suite Variable    ${RESPOSTA}        ${resposta.json()}

    # Validação da resposta
    Dictionary Should Contain Item    ${RESPOSTA}    msg    Olá ${USER_FULLNAME}, cadastro realizado com sucesso.
    # Retornando ID e TOKEN para uso imediato
    [Return]    ${USER_ID}    



*** Keywords ***
Realizar Login usuario
    Criar Sessao
    ${body}=    Create Dictionary    mail=janone@uol.com.br   password=janone#Ca10
    Log    ${body}
    ${resposta}=    POST On Session    alias=shogun    url=/login/    json=${body}    expected_status=200
    Log    ${resposta.json()}

    Set Suite Variable    ${USER_TOKEN}    ${resposta.json()["token"]}
    Set Suite Variable    ${USER_ID}       ${resposta.json()["user"]["_id"]}
    Set Suite Variable    ${USER_EMAIL}    ${resposta.json()["user"]["mail"]}
    Set Suite Variable    ${USER_FULLNAME}   ${resposta.json()["user"]["fullName"]}
    
    Dictionary Should Contain Item    ${resposta.json()}    msg    Olá ${USER_FULLNAME}, autenticação autorizada com sucesso!

    [Return]    ${USER_TOKEN}    ${USER_ID}     


Listar todos os cadastros
    Realizar Login usuario
    ${headers}=    Create Dictionary    Authorization=${USER_TOKEN}    accept=application/json    Content-Type=application/json    
    ${resposta}=    GET On Session    alias=shogun    url=/user/    headers=${headers}    
    Log    ${resposta.json()}
    Dictionary Should Contain Key    ${resposta.json()[0]}    fullName



Contar usuarios cadastrados
    Realizar Login usuario
    ${headers}=    Create Dictionary    Authorization=${USER_TOKEN}    accept=application/json    Content-Type=application/json 
    ${resposta}=    GET On Session    alias=shogun    url=/user/count    headers=${headers}     
    Log    ${resposta.json()}
    Dictionary Should Contain Key    ${resposta.json()}    count       
    ${quantidade}=    Get From Dictionary    ${resposta.json()}    count
    Log    Quantidade de usuários cadastrados: ${quantidade}



Consultar usuario cadastrado pelo ID
    Realizar Login usuario
    ${headers}=    Create Dictionary    Authorization=${USER_TOKEN}    accept=application/json    Content-Type=application/json 
    ${resposta}=    GET On Session    alias=shogun    url=/user/${USER_ID}    headers=${headers} 
    Log    ${resposta.json()}
    Dictionary Should Contain Key    ${resposta.json()}    _id    ${USER_ID}   



Editar cadastro de usuario
    Realizar Login usuario    
    ${body}=    Create Dictionary    fullName=Patricia Jane    mail=janone@uol.com.br
    ${headers}=    Create Dictionary    Authorization=${USER_TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}=    PUT On Session    alias=shogun    url=/user/${USER_ID}    headers=${headers}    json=${body}
    Log    ${resposta.json()}
    Dictionary Should Contain Item    ${resposta.json()}    msg    Dados atualizados com sucesso!



Editar password de usuario
    Realizar Login usuario
    Consultar usuario cadastrado pelo ID
    ${body}=    Create Dictionary    password=paty#Ja01       confirmPassword=paty#Ja01
    ${headers}=    Create Dictionary    Authorization=${USER_TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}=    PUT On Session    alias=shogun    url=/user/password/${USER_ID}    headers=${headers}    json=${body}
    Log    ${resposta.json()}
    Dictionary Should Contain Item    ${resposta.json()}    msg    Senha atualizada com sucesso!



Editar status de usuario
    Realizar Login ADMIN
    ${body}=    Create Dictionary    status=True
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}=    PUT On Session    alias=shogun    url=/user/status/${USER_ID}    json=${body}
    Log    ${resposta.json()}
    Dictionary Should Contain Key    ${resposta.json()}    _id    ${USER_ID}
    Dictionary Should Contain Item    ${resposta.json()}    msg    Status do usuário atualizado com sucesso.



Deletar usuario pelo ID
    Realizar Login ADMIN
    Cadastrar Novo Usuario e Salvar ID
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}=    DELETE On Session    alias=shogun    url=/user/${USER_ID}    headers=${headers}
    Log    ${resposta.json()}
    Dictionary Should Contain Item   ${resposta.json()}    msg    Usuário deletado com sucesso!.

# Para deletar com sucesso: 
#    - Usar login Admin  
#    - Cadastrar Novo Usuario e Salvar ID