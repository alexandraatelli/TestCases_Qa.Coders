**** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/login.resource 
Resource       ../resource/criar.user.resource
Resource       ../resource/login.user.resource
Resource       ../resource/put.edit.user.resource
Resource    ../resource/put.edit.password.resource
Resource    ../resource/put.edit.status.resource

*** Test Cases ***
CT09-Editar status de usuario
    Realizar Login ADMIN   
