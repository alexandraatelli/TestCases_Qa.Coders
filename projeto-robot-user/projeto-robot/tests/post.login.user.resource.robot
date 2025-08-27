*** Settings ***
Resource    ../resource/login.resource
Resource    ../resource/criar.user.resource
Resource    ../resource/login.user.resource

*** Test Cases ***
CT03-Login novo usuario
    Realizar Login usuario