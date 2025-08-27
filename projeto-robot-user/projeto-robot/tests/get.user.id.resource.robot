*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource    ../resource/login.resource
Resource    ../resource/login.user.resource
Resource    ../resource/get.list.users.resource
Resource    ../resource/get.user.id.resource
 

*** Test Cases ***
CT06-Consultar usuario cadastrado pelo ID
    Consultar usuario cadastrado pelo ID  