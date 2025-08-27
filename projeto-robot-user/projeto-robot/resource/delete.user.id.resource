*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections 
Resource    ../resource/login.resource
Resource    ../resource/criar.user.resource    
#Resource   ../resource/login.user.resource

*** Keywords ***
Deletar usuario pelo ID
    Realizar Login ADMIN
    Cadastrar Novo Usuario e Salvar ID
    ${headers}=    Create Dictionary    
    ...    Authorization=${TOKEN}  
    ...    Accept=application/json 
    ...    Content-Type=application/json     

    # Executa DELETE usando o ID do usuário
    ${resposta}=    DELETE On Session
    ...    alias=shogun
    ...    url=/user/${USER_ID} 
    ...    headers=${headers}

    Log    ${resposta.json()}

    Dictionary Should Contain Item   ${resposta.json()}    msg    Usuário deletado com sucesso!.

    # Para deletar com sucesso: 
    #     Usar login Admin  
    #    Cadastrar Novo Usuario e Salvar ID
    