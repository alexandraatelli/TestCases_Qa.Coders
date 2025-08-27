[Documentation]    Testes: Criar novo: User, Company, CostCenter, Department, Client

*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    OperatingSystem
Resource    ../resource/keyword.resource


*** Test Cases ***
CT01-Realizar Login ADMIN
    Criar Sessao
    Realizar Login ADMIN
    Validar token Autorizacao
    Criar Sessao autorizada

CT02-Cadastrar novo usuário
    Criar Sessao autorizada
    Cadastrar Novo Usuario e Salvar ID
    
CT04-Cadastrar nova Empresa
    Criar Sessao autorizada
    Gerar Massa Empresa
    Criar Nova Empresa
    
CT05-Criar nova Diretoria
    Criar Sessao autorizada
    Cadastrar Diretoria

CT05-Criar Centro de Custo
    Criar Sessao autorizada
    Cadastrar Centro de Custo
    
CT06-Criar novo Departamento
    Criar Sessao autorizada
    Criar Departamento


CT07-Criar novo Cliente
    Criar Sessao autorizada
    Gerar Massa Cliente
    Criar Cliente

    