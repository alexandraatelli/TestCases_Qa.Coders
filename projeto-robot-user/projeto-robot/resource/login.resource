*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
 
*** Variables ***
${URL}        https://api-shogun.qacoders.dev.br/api
${EMAIL}      sysadmin@qacoders.com
${PASSWORD}   1234@Test
 
*** Keywords ***
 
Criar Sessao
    ${headers}        Create Dictionary        accept=application/json        Content-Type=application/json    
    Create Session        alias=shogun         url=${URL}        headers=${headers}    verify=${True}
 
Realizar Login ADMIN
    Criar Sessao
    ${body}=    Create Dictionary    mail=${EMAIL}    password=${PASSWORD}
    Log    ${body}
    ${resposta}=    POST On Session    alias=shogun    url=/login    json=${body}    expected_status=200
    Log    ${resposta.json()}
    ${TOKEN}=    Set Variable    ${resposta.json()["token"]}
    Set Suite Variable    ${TOKEN}

    ${user_id}=          Set Variable    ${resposta.json()['user']['_id']}
    Set Suite Variable    ${user_id}
 
Validar token Autorizacao
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${resposta}=    GET On Session    alias=shogun    url=/validateToken    headers=${headers}    expected_status=200
    Log    Resposta da solicitacao: ${resposta.content}
    Log    ${TOKEN}
 
Criar Sessao autorizada
    ${headers}=    Create Dictionary    accept=application/json    Content-Type=application/json    Authorization=Bearer ${TOKEN}
    Create Session    alias=shogun_autorizada    url=${URL}    headers=${headers}    verify=${True} 








