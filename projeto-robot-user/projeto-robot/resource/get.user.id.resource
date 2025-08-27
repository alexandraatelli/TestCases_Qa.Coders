*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource    ../resource/login.resource
Resource    ../resource/criar.user.resource
Resource    ../resource/login.user.resource

*** Keywords ***
Consultar usuario cadastrado pelo ID
    Realizar Login usuario
    ${headers}    Create Dictionary    
    ...    Authorization=${USER_TOKEN}
    ...    accept=application/json 
    ...    Content-Type=application/json     

    ${resposta}=    GET On Session
    ...    alias=shogun
    ...    url=/user/${USER_ID}  
    ...    headers=${headers}
            
    Log    ${resposta.json()}

    # Valida um campo do primeiro usuário retornado
    Dictionary Should Contain Key    ${resposta.json()}    _id    ${USER_ID}    