**** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/criar.user.resource
Resource       ../resource/login.user.resource
Resource       ../resource/get.user.id.resource         

*** Keywords ***
Editar password de usuario
    Realizar Login usuario
    Consultar usuario cadastrado pelo ID
    ${body}=    Create Dictionary
    ...    password=maura#Si12
    ...    confirmPassword=maura#Si12
    
    ${headers}    Create Dictionary    
    ...    Authorization=${USER_TOKEN}
    ...    accept=application/json 
    ...    Content-Type=application/json     

    ${resposta}=    PUT On Session
    ...    alias=shogun
    ...    url=/user/password/${USER_ID}
    ...    headers=${headers}
    ...    json=${body}
        
    Log    ${resposta.json()}

    #Dictionary Should Contain Key    ${resposta.json()}    _id    ${USER_ID}
    Dictionary Should Contain Item    ${resposta.json()}    msg    Senha atualizada com sucesso!