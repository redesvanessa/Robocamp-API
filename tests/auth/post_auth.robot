***Settings***
Documentation           POST /auth
...                     Testes do serviçõ de autorização

Resource                ../../resources/services.robot
Resource                ../../resources/fixtures/helpers.robot



***Test Cases***
Successfuly Login
    
    ${payload}=           ???

    ${resp}=               Post Token     ${payload} 
    Status Should Be       200            ${resp}

Incorrect Password    
    ${payload}=           ???
    
    ${resp}=               Post Product   ${payload}   

    Status Should Be       401            ${resp}

