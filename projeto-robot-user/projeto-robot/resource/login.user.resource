*** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections
Resource       ../resource/login.resource 
Resource       ../resource/criar.user.resource

*** Keywords ***
Criar Sessao
    ${headers}=    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=shogun    url=${URL}    headers=${headers}

Realizar Login usuario
    Criar Sessao
    ${body}=    Create Dictionary    mail=silviao@uol.com.br   password=maura#Si11
    ${resposta}=    POST On Session    alias=shogun    url=/login
    ...    json=${body}    
    Log    ${resposta.json()}    
    
    Set Test Variable    ${USER_EMAIL}    ${resposta.json()["user"]["mail"]}
    Set Test Variable    ${USER_TOKEN}    ${resposta.json()["token"]}
    Set Test Variable    ${USER_ID}    ${resposta.json()["user"]["_id"]}          
    
Criar Sessao autorizada
    ${headers}=    Create Dictionary    accept=application/json    Content-Type=application/json    Authorization=Bearer ${USER_TOKEN}
    Create Session    alias=shogun_autorizada    url=${URL}    headers=${headers}    verify=${True}    