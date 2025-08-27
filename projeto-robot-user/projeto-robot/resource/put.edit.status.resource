**** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/login.resource 
Resource       ../resource/criar.user.resource
Resource       ../resource/login.user.resource
Resource       ../resource//put.edit.user.resource
Resource       ../resource/put.edit.password.resource

*** Keywords ***
Editar status de usuario
    Realizar Login ADMIN
    ${body}=    Create Dictionary
    ...    status=true
    
    ${headers}    Create Dictionary    
    ...    Authorization=${TOKEN}
    ...    accept=application/json 
    ...    Content-Type=application/json     

    ${resposta}=    PUT On Session
    ...    alias=shogun
    ...    url=/user/status/${USER_ID} 
    ...    headers=${headers}
    ...    json=${body}
        
    Log    ${resposta.json()}
    
    Dictionary Should Contain Key    ${resposta.json()}    _id    ${USER_ID}
    Dictionary Should Contain Item    ${resposta.json()}    msg    Status do usuário atualizado com sucesso.