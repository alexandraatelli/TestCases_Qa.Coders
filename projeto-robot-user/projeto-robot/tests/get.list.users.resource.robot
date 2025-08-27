*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource    ../resource/login.resource
Resource    ../resource/login.user.resource
Resource    ../resource/get.list.users.resource
 
 
*** Test Cases ***
CT04-Listar todos os cadastros
    Listar todos os cadastros   