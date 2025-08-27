**** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/login.resource 
Resource       ../resource/criar.user.resource
Resource       ../resource/login.user.resource

*** Keywords ***
Editar cadastro de usuario
    Realizar Login usuario
    ${body}=    Create Dictionary
    ...    fullName=Silvia Mauro
    ...    mail=silviao@uol.com.br
    
    ${headers}    Create Dictionary    
    ...    Authorization=${USER_TOKEN}
    ...    accept=application/json 
    ...    Content-Type=application/json     

    ${resposta}=    PUT On Session
    ...    alias=shogun
    ...    url=/user/${USER_ID}
    ...    headers=${headers}
    ...    json=${body}
        
    Log    ${resposta.json()}

    #Dictionary Should Contain Key    ${resposta.json()}    _id    ${USER_ID}
    Dictionary Should Contain Item    ${resposta.json()}    msg    Dados atualizados com sucesso!


  

