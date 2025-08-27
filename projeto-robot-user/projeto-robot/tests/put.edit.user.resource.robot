**** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/login.resource
Resource       ../resource/login.user.resource 
Resource       ../resource/criar.user.resource
Resource       ../resource/put.edit.user.resource

*** Test Cases ***
CT07-Editar cadastro de usuario
    Editar cadastro de usuario    

