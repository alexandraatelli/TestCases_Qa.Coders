*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource       ../resource/login.resource
Resource       ../resource/login.user.resource

*** Keywords ***
Contar usuarios cadastrados
    Realizar Login usuario
    ${headers}    Create Dictionary    
    ...    Authorization=${USER_TOKEN}
    ...    accept=application/json 
    ...    Content-Type=application/json     

    ${resposta}=    GET On Session
    ...    alias=shogun
    ...    url=/user/count
    ...    headers=${headers}
            
    Log    ${resposta.json()}

    # Valida um campo do primeiro usuário retornado
    Dictionary Should Contain Key    ${resposta.json()}    count       

    # Captura a quantidade de usuários e mostra no log
    ${quantidade}=    Get From Dictionary    ${resposta.json()}    count
    Log    Quantidade de usuários cadastrados: ${quantidade}