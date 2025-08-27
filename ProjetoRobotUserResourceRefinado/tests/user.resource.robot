[Documentation]     Testes - Funcionalidade User


*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource    ../resource/user.resource


*** Test Cases ***
CT01-Realizar Login ADMIN
    Criar Sessao
    Realizar Login ADMIN
    Validar token Autorizacao
    Criar Sessao autorizada

CT02-Cadastrar novo usuário
    Realizar Login ADMIN
    Cadastrar Novo Usuario e Salvar ID

CT03-Login novo usuario
    Realizar Login usuario

CT04-Listar todos os cadastros
    Realizar Login usuario
    Listar todos os cadastros

CT05-Contar usuarios cadastrados
    Realizar Login usuario
    Contar usuarios cadastrados

CT06-Consultar usuario cadastrado pelo ID
    Consultar usuario cadastrado pelo ID  

CT07-Editar cadastro de usuario
    Realizar Login usuario
    Editar cadastro de usuario    

CT08-Editar password de usuario
    Editar password de usuario 

CT09-Editar status de usuario
    Realizar Login ADMIN   

CT10-Deletar usuario pelo ID
    Deletar usuario pelo ID