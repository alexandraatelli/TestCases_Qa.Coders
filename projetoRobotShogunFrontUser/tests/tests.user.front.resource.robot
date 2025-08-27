*** Settings ***     
Resource        ../resource/tests.user.front.resource
Test Setup      Abrir o navegador
Test Teardown   Fechar o navegador     


*** Test Cases ***
Cenario de teste: Logar com perfil Admin para criar novo usuario
    Passo 1 - Acessa a pagina para login Admin
    Passo 2 - Digitar e-mail Admin
    Passo 3 - Digitar a senha Admin
    Passo 4 - Clicar no botao entrar como Admin
    Passo 5 - Verificar se realmente entrou no sistema como Admin
    Passo 6 - Clicar em Cadastros
    Passo 7 - Clicar em Usuarios 
    Passo 8 - Clicar para Novo Cadastro de usuario
    Passo 9 - Digitar o Nome Completo do novo usuario
    Passo 10 - Cadastrar Email do novo usuario
    Passo 11 - Perfil de Acesso Profile Admin
    Passo 12 - Cadastrar CPF do usuario
    Passo 13 - Digitar a senha do novo usuario
    Passo 14 - Confirmar a senha do novo usuario
    Passo 15 - Clicar em Salvar Novo

    


    
    
    



    
    




