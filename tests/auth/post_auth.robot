***Settings***
Documentation           POST /auth
...                     Testes do serviçõ de autorização

Resource                ../../resources/services.robot
Resource                ../../resources/fixtures/helpers.robot

***Test Cases***
Successfuly Login  
    [Tags]      Success

    ${resp}=               Post Token   vanessaredes@yahoo.com.br     123456
    Status Should Be       200            ${resp}

Incorrect Password    
    [Tags]      Not auth   
    ${resp}=               Post Token   vanessaredes@yahoo.com.br     132abc
    Status Should Be       401            ${resp}

