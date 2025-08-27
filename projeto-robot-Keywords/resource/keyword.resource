[Documentation]    Criar novo: User, Company, Board, CostCenter, Department, Client   

*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    SeleniumLibrary


*** Variables ***
${URL}            https://api-shogun.qacoders.dev.br/api
${EMAIL}          sysadmin@qacoders.com
${PASSWORD}       1234@Test
${ACCESSPROFILE}  ADMIN
${TOKEN}          token 


*** Keywords ***

Criar Sessao
    ${headers}        Create Dictionary        accept=application/json        Content-Type=application/json    
    Create Session        alias=shogun         url=${URL}        headers=${headers}    verify=${True}
Realizar Login ADMIN
    Criar Sessao
    ${body}=    Create Dictionary    mail=${EMAIL}   password=${PASSWORD}
    Log    ${body}
    ${resposta}=    POST On Session    alias=shogun    url=/login/    json=${body}    expected_status=200
    Log    ${resposta.json()}
    ${TOKEN}=    Set Variable    ${resposta.json()["token"]}
    Set Suite Variable    ${TOKEN}
    ${user_id}=    Set Variable    ${resposta.json()["user"]["_id"]}
    Set Suite Variable    ${user_id}
    [Return]    ${resposta.json()}
Validar token Autorizacao
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${resposta}=    GET On Session    alias=shogun    url=/validateToken    headers=${headers}    expected_status=200
    Log    Resposta da solicitacao: ${resposta.content}
    Log    ${TOKEN}
Criar Sessao autorizada
    ${headers}=    Create Dictionary    accept=application/json    Content-Type=application/json    Authorization=${TOKEN}
    Create Session    alias=shogun    url=${URL}    headers=${headers}    verify=${True} 
    ${resposta}=    Realizar Login ADMIN
    Dictionary Should Contain Item    ${resposta}    msg    Olá Qa-Coders-SYSADMIN, autenticação autorizada com sucesso!



Cadastrar Novo Usuario e Salvar ID
    Set Variable
    ${FULLNAME}=            Set Variable    Luis Sousa
    ${EMAIL}=               Set Variable    luisSousa@test.com  
    ${ACCESSPROFILE}=       Set Variable    ADMIN
    ${CPF}=                 Set Variable    89269997991  
    ${CONFIRM_PASSWORD}=    Set Variable    luis#Ca30  
    
    ${body}     Create Dictionary
    ...         fullName=${FULLNAME}
    ...         mail=${EMAIL}
    ...         accessProfile=${ACCESSPROFILE}
    ...         cpf=${CPF}
    ...         password=${PASSWORD}
    ...         confirmPassword=${CONFIRM_PASSWORD}
    RETURN    ${body}

    ${headers}=    Create Dictionary    Authorization=${TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}=    POST On Session    alias=shogun    url=/user/    headers=${headers}    expected_status=201
    
    Log    ${resposta.json()}
        # Atualizando variáveis com os dados retornados da API, disponíveis para toda a suite
    Set Suite Variable    ${USER_ID}    ${resposta.json()["user"]["_id"]}
    Set Suite Variable    ${FULLNAME}   ${resposta.json()["user"]["fullName"]}
    Set Suite Variable    ${EMAIL}      ${resposta.json()["user"]["mail"]}
    Set Suite Variable    ${CPF}        ${resposta.json()["user"]["cpf"]}
    Set Suite Variable    ${RESPOSTA}   ${resposta.json()}
    
    Dictionary Should Contain Item    ${RESPOSTA}    msg    Olá ${FULLNAME}, cadastro realizado com sucesso.
    RETURN    ${USER_ID}    


Gerar Massa Empresa
    ${rand_num}=    String.Generate Random String    4    [NUMBERS]
    ${NAME}=                 Set Variable    Empresa Teste ${rand_num}
    ${REGISTER}=             Set Variable    1234567800${rand_num}
    ${EMAIL}=                Set Variable    empresa${rand_num}@teste.com
    ${MATRIZ}=               Set Variable    Matriz ${rand_num}
    ${CONTACT}=              Set Variable    Ana Oliveira
    ${PHONE}=                Set Variable    +5511987654321
    ${DESCRIPTION}=          Set Variable    Serviço de teste automatizado
    ${ADDRESS_ZIP}=          Set Variable    12345678
    ${ADDRESS_CITY}=         Set Variable    São Paulo
    ${ADDRESS_STATE}=        Set Variable    SP
    ${ADDRESS_DISTRICT}=     Set Variable    Bairro Teste
    ${ADDRESS_STREET}=       Set Variable    Rua Teste
    ${ADDRESS_NUMBER}=       Set Variable    1234567890
    ${ADDRESS_COMPLEMENT}=   Set Variable    Complemento Teste
    ${ADDRESS_COUNTRY}=      Set Variable    Brasil

    ${address_item}=    Create Dictionary
    ...    zipCode=${ADDRESS_ZIP}
    ...    city=${ADDRESS_CITY}
    ...    state=${ADDRESS_STATE}
    ...    district=${ADDRESS_DISTRICT}
    ...    street=${ADDRESS_STREET}
    ...    number=${ADDRESS_NUMBER}
    ...    complement=${ADDRESS_COMPLEMENT}
    ...    country=${ADDRESS_COUNTRY}

    ${ADDRESS_LIST}=    Create List    ${address_item}

    ${body}=    Create Dictionary
    ...    corporateName=${NAME}
    ...    registerCompany=${REGISTER}
    ...    mail=${EMAIL}
    ...    matriz=${MATRIZ}
    ...    responsibleContact=${CONTACT} 
    ...    telephone=${PHONE}
    ...    serviceDescription=${DESCRIPTION}
    ...    address=${ADDRESS_LIST}
    RETURN    ${body}
Criar Nova Empresa
    ${body}=    Gerar Massa Empresa
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    accept=application/json
    ...    Content-Type=application/json
    ${resposta}=    POST On Session    alias=shogun    url=/company/    headers=${headers}    json=${body}    expected_status=201
   
    Log    ${resposta.json()}
   
    Should Be Equal As Integers    ${resposta.status_code}    201

    # Atualizando variáveis com os dados retornados da API, disponíveis para toda a suite
    Set Suite Variable    ${NAME}                   ${resposta.json()["newCompany"]["corporateName"]}
    Set Suite Variable    ${EGISTER}                ${resposta.json()["newCompany"]["registerCompany"]}
    Set Suite Variable    ${EMAIL}                  ${resposta.json()["newCompany"]["mail"]}
    Set Suite Variable    ${MATRIZ}                 ${resposta.json()["newCompany"]["matriz"]}
    Set Suite Variable    ${CONTACT}                ${resposta.json()["newCompany"]["responsibleContact"]}
    Set Suite Variable    ${HONE}                   ${resposta.json()["newCompany"]["telephone"]}
    Set Suite Variable    ${DESCRIPTION}            ${resposta.json()["newCompany"]["serviceDescription"]}
    Set Suite Variable    ${ADDRESS_ZIP}            ${resposta.json()["newCompany"]["address"][0]["zipCode"]}
    Set Suite Variable    ${ADDRESS_CITY}           ${resposta.json()["newCompany"]["address"][0]["city"]}
    Set Suite Variable    ${ADDRESS_STATE}          ${resposta.json()["newCompany"]["address"][0]["state"]}
    Set Suite Variable    ${ADDRESS_DISTRICT}       ${resposta.json()["newCompany"]["address"][0]["district"]}
    Set Suite Variable    ${ADDRESS_STREET}         ${resposta.json()["newCompany"]["address"][0]["street"]}
    Set Suite Variable    ${ADDRESS_NUMBER}         ${resposta.json()["newCompany"]["address"][0]["number"]}
    Set Suite Variable    ${ADDRESS_COMPLEMENT}     ${resposta.json()["newCompany"]["address"][0]["complement"]}
    Set Suite Variable    ${ADDRESS_COUNTRY}        ${resposta.json()["newCompany"]["address"][0]["country"]}
    Set Suite Variable    ${COMPANY_ID}             ${resposta.json()["newCompany"]["_id"]}
    Set Suite Variable    ${COMPANY}                ${resposta.json()}


Criar nova Diretoria
    Set Test Variable    ${BOARD_NAME}    Cozinha
    Log    ${BOARD_NAME}
Cadastrar Diretoria
    Criar nova Diretoria
    ${body}=    Create Dictionary    boardName=${BOARD_NAME}
    ${headers}=    Create Dictionary     Authorization=${TOKEN}     accept=application/json
    ...    Content-Type=application/json    
    ${resposta}=   POST On Session    alias=shogun    url=/board/    headers=${headers}    json=${body}
    Log    ${resposta.json()}
    
    Should Be Equal As Integers    ${resposta.status_code}    201

    Set Test Variable    ${BOARD_NAME}    ${resposta.json()["newBoard"]["boardName"]}
    Set Test Variable    ${BOARD_ID}           ${resposta.json()["newBoard"]["_id"]}
   
    Dictionary Should Contain Item    ${resposta.json()}    msg    Cadastro realizado com sucesso!
    Log    ${BOARD_ID}



Criar Centro de Custo
    Set Test Variable    ${COSTCENTER}    Compras
    Log    ${COSTCENTER}
Cadastrar Centro de Custo
    Cadastrar Diretoria
    Criar Centro de Custo
    ${body}=    Create Dictionary
    ...    costCenterName=${COSTCENTER}
    ...    boardId=${BOARD_ID}
 
    ${headers}=    Create Dictionary
    ...    Authorization=${TOKEN}
    ...    accept=application/json
    ...    Content-Type=application/json
 
    ${resposta}=    POST On Session
    ...    alias=shogun
    ...    url=costCenter
    ...    headers=${headers}
    ...    json=${body}
 
    Log    ${resposta.json()}
    Should Be Equal As Integers    ${resposta.status_code}    201
 
    Set Test Variable    ${COSTCENTER_ID}    ${resposta.json()["newCostCenter"]["_id"]}
    Log    ${COSTCENTER_ID}



Criar Departamento
    Set Test Variable    ${DEPARTMENT_NAME}    Tributos
    Log    ${DEPARTMENT_NAME}
Cadastrar Departamento
    Cadastrar Centro de Custo
    Criar Departamento
    ${body}=    Create Dictionary    
    ...    departmentName=${DEPARTMENT_NAME}
    ...    costCenterID=${COSTCENTER_ID}
   
    ${headers}=    Create Dictionary    
    ...    Authorization=${TOKEN}    
    ...    accept=application/json    
    ...    Content-Type=application/json

    ${resposta}=   POST On Session
    ...    alias=shogun    
    ...    url=/department/    
    ...    headers=${headers}    
    ...    son=${body}

    Log    ${resposta.json()}
    Should Be Equal As Integers    ${resposta.status_code}    201

    Set Test Variable    ${DEPARTMENT_NAME}    ${resposta.json()["newDepartment"]["departmentName"]}
    Set Test Variable    ${DEPARTMENT_ID}      ${resposta.json()["newDepartment"]["_id"]}

    Dictionary Should Contain Item    ${resposta.json()}    msg    Cadastro realizado com sucesso.

    [Return]    ${DEPARTMENT_ID}



*** Keywords ***
Gerar Massa Cliente
    ${rand_num4}=       Generate Random String    4    [NUMBERS]
    ${rand_num2}=       Generate Random String    2    [NUMBERS]
    ${rand_num7}=       Generate Random String    7    [NUMBERS]
    ${rand_num11}=      Generate Random String    11    [NUMBERS]
    ${rand_num10}=      Generate Random String    10    [NUMBERS]
    ${rand_name2}=      Generate Random String    2    [LETTERS]
    ${rand_name6}=      Generate Random String    6    [LETTERS]
    ${FULLNAME}=        Catenate    SEPARATOR=    Joao Goncalvez    ${rand_name6}
    ${BIRTH_DATE}=      Set Variable    20250829
    ${EMAIL}=           Catenate    SEPARATOR=    usuario${rand_num4}@gmail.com
    ${PHONE}=           Catenate    SEPARATOR=    5591${rand_num7}
    ${CURRENT_ROLE}=    Set Variable    ADMIN
    ${RG}=              Set Variable    ${rand_num7}
    ${CPF}=             Set Variable    ${rand_num11}
    ${COUNTRY}=         Set Variable    Brasil
    ${ZIP}=             Catenate    SEPARATOR=    0417${rand_num4}
    ${CITY}=            Catenate    SEPARATOR=    Campinas   ${rand_name2}
    ${STATE}=           Set Variable    SP
    ${DISTRICT}=        Set Variable    Industrial
    ${STREET}=          Catenate    SEPARATOR=    Rua Maio${rand_num2}
    ${NUMBER}=          Set Variable    ${rand_num10}
    ${COMPLEMENT}=      Catenate    SEPARATOR=    Coracao${rand_num2}

    ${DOC}=             Create Dictionary
    ...                 rg=${RG}
    ...                 cpf=${CPF}
    ${DOCUMENTS}=       Create List    ${DOC}

    ${ADDR}=            Create Dictionary
    ...                 zipCode=${ZIP}
    ...                 city=${CITY}
    ...                 state=${STATE}
    ...                 district=${DISTRICT}
    ...                 street=${STREET}
    ...                 number=${NUMBER}
    ...                 complement=${COMPLEMENT}
    ...                 country=${COUNTRY}
    ${ADDRESS}=         Create List    ${ADDR}

    ${BODY}=            Create Dictionary
    ...                 fullName=${FULLNAME}
    ...                 birthDate=${BIRTH_DATE}
    ...                 mail=${EMAIL}
    ...                 phone=${PHONE}
    ...                 currentRole=${CURRENT_ROLE}
    ...                 documents=${DOCUMENTS}
    ...                 address=${ADDRESS}

    RETURN    ${BODY}
Criar Cliente
    ${body}=            Gerar Massa Cliente
    ${headers}=         Create Dictionary    Authorization=${TOKEN}    accept=application/json    Content-Type=application/json
    ${resposta}=        POST On Session    alias=shogun    url=/client/    headers=${headers}    json=${body}    expected_status=201

    Log    ${resposta.json()}

    Should Be Equal As Integers    ${resposta.status_code}    201

    Set Test Variable    ${FULLNAME}        ${resposta.json()["newClient"]["fullName"]}
    Set Test Variable    ${BIRTH_DATE}      ${resposta.json()["newClient"]["birthDate"]}
    Set Test Variable    ${EMAIL}           ${resposta.json()["newClient"]["mail"]}
    Set Test Variable    ${PHONE}           ${resposta.json()["newClient"]["phone"]}
    Set Test Variable    ${CURRENT_ROLE}    ${resposta.json()["newClient"]["currentRole"]}
    Set Test Variable    ${RG}              ${resposta.json()["newClient"]["documents"][0]["rg"]}
    Set Test Variable    ${CPF}             ${resposta.json()["newClient"]["documents"][0]["cpf"]}
    Set Test Variable    ${ZIPCODE}         ${resposta.json()["newClient"]["address"][0]["zipCode"]}
    Set Test Variable    ${CITY}            ${resposta.json()["newClient"]["address"][0]["city"]}
    Set Test Variable    ${STATE}           ${resposta.json()["newClient"]["address"][0]["state"]}
    Set Test Variable    ${DISTRICT}        ${resposta.json()["newClient"]["address"][0]["district"]}
    Set Test Variable    ${STREET}          ${resposta.json()["newClient"]["address"][0]["street"]}
    Set Test Variable    ${NUMBER}          ${resposta.json()["newClient"]["address"][0]["number"]}
    Set Test Variable    ${COMPLEMENT}      ${resposta.json()["newClient"]["address"][0]["complement"]}
    Set Test Variable    ${COUNTRY}         ${resposta.json()["newClient"]["address"][0]["country"]}
    Set Test Variable    ${CLIENT_ID}       ${resposta.json()["newClient"]["_id"]}
      
    Dictionary Should Contain Item    ${resposta.json()}    msg    Cliente criado com sucesso.
    Log    ${CLIENT_ID}