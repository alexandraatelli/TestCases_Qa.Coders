*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Resource       ../resource/login.user.resource
Resource       ../resource/get.user.count.resource


*** Test Cases ***
CT05-Contar usuarios cadastrados
    Contar usuarios cadastrados



