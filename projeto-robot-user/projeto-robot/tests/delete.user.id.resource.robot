*** Settings ***
Library        RequestsLibrary
Library        String
Library        Collections 
Resource       ../resource/login.resource 
Resource       ../resource/login.user.resource
Resource       ../resource/delete.user.id.resource


*** Test Cases ***
CT10-Deletar usuario pelo ID
    Deletar usuario pelo ID
