**** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections 
#Resource    ../resource/login.resource 
Resource    ../resource/criar.user.resource
Resource    ../resource/login.user.resource
#Resource    ../resource/put.edit.user.resource
Resource    ../resource/put.edit.password.resource


*** Test Cases ***
CT08-Editar password de usuario
    Editar password de usuario   
