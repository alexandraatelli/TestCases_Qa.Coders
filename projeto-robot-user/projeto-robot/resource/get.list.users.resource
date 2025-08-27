*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource       ../resource/login.resource
Resource       ../resource/login.user.resource

*** Keywords ***
Listar todos os cadastros
    Realizar Login usuario
    ${headers}    Create Dictionary    
    ...    Authorization=${USER_TOKEN}
    ...    accept=application/json 
    ...    Content-Type=application/json     

    ${resposta}=    GET On Session
    ...    alias=shogun
    ...    url=/user/
    ...    headers=${headers}
            
    Log    ${resposta.json()}

    # Valida um campo do primeiro usuário retornado
    Dictionary Should Contain Key    ${resposta.json()[0]}    fullName
        