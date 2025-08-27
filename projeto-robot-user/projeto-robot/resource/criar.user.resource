*** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/login.resource 


*** Keywords ***
Cadastrar Novo Usuario e Salvar ID
    Realizar Login ADMIN
    ${body}     Create Dictionary
    ...         fullName=Silvana Merlin
    ...         mail=merlin@uol.com.br
    ...         accessProfile=ADMIN
    ...         cpf=59020404980
    ...         password=merlin#Si12
    ...         confirmPassword=merlin#Si12
    Log    ${body}
    ${headers}    Create Dictionary    Authorization=${TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}    POST On Session    alias=shogun    url=/user    headers=${headers}    json=${body}    
    Log    ${resposta.json()}

    Set Test Variable    ${USER_ID}         ${resposta.json()["user"]["_id"]} 
    Set Test Variable    ${USER_FULLNAME}   ${resposta.json()["user"]["fullName"]}
    Set Test Variable    ${USER_EMAIL}    ${resposta.json()["user"]["mail"]} 
    Set Test Variable    ${RESPOSTA}        ${resposta.json()}

    Dictionary Should Contain Item    ${RESPOSTA}    msg    Olá ${USER_FULLNAME}, cadastro realizado com sucesso. 
   


