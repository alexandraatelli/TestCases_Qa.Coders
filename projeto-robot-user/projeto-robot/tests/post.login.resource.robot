*** Settings ***
Resource        ../resource/login.resource

*** Test Cases ***
CT01-Criar novo usuario
    Criar Sessao
    Realizar Login ADMIN
    Validar token Autorizacao
    Criar Sessao autorizada
   
    
   
  