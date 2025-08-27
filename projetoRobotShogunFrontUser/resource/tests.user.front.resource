*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${urlBase}                    https://shogun.qacoders.dev.br/login
${emaiInput}                  id=email
${emailAdmin}                 sysadmin@qacoders.com
${senhaInput}                 id=password
${senhaAdmin}                 1234@Test
${botaoInput}                 id=login
${clicarCadastros}            //span[@class="MuiTypography-root MuiTypography-body1 MuiListItemText-primary css-yb0lig"]    
${ClicarUsuarios}             //*[@id="Usuários"]/span 
${ClicarNovoCadastroUser}     //button[contains(@class,"css-fvzsut") and contains(.,"Novo Cadastro")]
${LOC_NOME_COMPLETO}          xpath=//input[@id="fullName"]
${nomeCompletoUser}           João da Silva Rima
${emailUsuarioInput}          //input[@id='mail' or @name='mail']
${emailUsuario}               joaoRima@gmail.com
${perfilAcessoProfile}        //input[contains(@name, 'accessProfile')]
${perfilAcesso}               ADMIN         
${cpfInput}                   //input[contains(@name, 'cpf')] 
${cpfUser}                    25483901478
${senhaNovoUserInput}         //input[contains(@name, 'password')] 
${senhaNovoUser}              1234%Joao
${confirmSenhaUser}           id=confirmPassword
${butaoSalvaNovo}            //button[@type='submit'][contains(.,'SALVAR NOVO')]        


*** Keywords ***
Abrir o navegador
    Open Browser    browser=Firefox
    Maximize Browser Window

Fechar o navegador
    Close Browser

Passo 1 - Acessa a pagina para login Admin
    Go to    url=${urlBase}

Passo 2 - Digitar e-mail Admin
    Wait Until Element Is Visible    locator=${emaiInput}
    Input Text                       locator=${emaiInput}    text=${emailAdmin}
    #Sleep    5
     
Passo 3 - Digitar a senha Admin
    Wait Until Element Is Visible    locator=${senhaInput}
    Input Password                   locator=${senhaInput}    password=${senhaAdmin}
    #Sleep    5

Passo 4 - Clicar no botao entrar como Admin
    Wait Until Element Is Visible    locator=${botaoInput}
    Click Button                     locator=${botaoInput}    
    #Sleep    5    

Passo 5 - Verificar se realmente entrou no sistema como Admin
    Wait Until Page Contains    text=Logout   
    #Sleep    5

Passo 6 - Clicar em Cadastros
    Wait Until Element Is Visible    locator=${clicarCadastros} 
    Click Element                    locator=${Clicarcadastros}  
    #Sleep    10
    
Passo 7 - Clicar em Usuarios
    Wait Until Element Is Visible    locator=${clicarUsuarios} 
    Click Element                    locator=${ClicarUsuarios}  
    #Sleep    10        

Passo 8 - Clicar para Novo Cadastro de usuario
    Wait Until Element Is Visible    locator=${ClicarNovoCadastroUser}
    Click Button                     locator=${ClicarNovoCadastroUser}  
    #Sleep    10 

Passo 9 - Digitar o Nome Completo do novo usuario
    Wait Until Element Is Visible    ${LOC_NOME_COMPLETO}   
    Input Text                       ${LOC_NOME_COMPLETO}    ${nomeCompletoUser}
    #Sleep    20
    
Passo 10 - Cadastrar Email do novo usuario
    Wait Until Element Is Visible    ${emailUsuarioInput}    
    Input Text                       ${emailUsuarioInput}    ${emailUsuario}
    #Sleep    20

Passo 11 - Perfil de Acesso Profile Admin
    Wait Until Element Is Visible    ${perfilAcessoProfile}    
    Input Text                       ${perfilAcessoProfile}    ${perfilAcesso}
    #Sleep    20    

Passo 12 - Cadastrar CPF do usuario
    Wait Until Element Is Visible    ${cpfInput} 
    Input Text                       ${cpfInput}    ${cpfUser}
    #Sleep    20   

Passo 13 - Digitar a senha do novo usuario
    Wait Until Element Is Visible    ${senhaNovoUserInput}    5s
    Input Password                   ${senhaNovoUserInput}    ${senhaNovoUser}
    #Sleep    20

Passo 14 - Confirmar a senha do novo usuario
    Wait Until Element Is Visible    ${confirmSenhaUser}    5s
    Input Password                  ${confirmSenhaUser}    ${senhaNovoUser}
    Sleep    25

Passo 15 - Clicar em Salvar Novo
    Wait Until Element Is Visible    ${butaoSalvaNovo}    5s
    Click Button                     ${butaoSalvaNovo}    
    Click Element                    ${butaoSalvaNovo}
    Sleep    25