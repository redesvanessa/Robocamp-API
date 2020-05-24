***Settings***
Documentation           POST /auth
...                     Testes do serviçõ de autorização

Resource                ../../resources/services.robot
Resource                ../../resources/fixtures/helpers.robot

***Test Cases***
Successfuly Login  
    ${resp}=               Post Token   vanessaredes@yahoo.com.br     123456
    Status Should Be       200            ${resp}

Incorrect Password    
   
    ${resp}=               Post Token   vanessaredes@yahoo.com.br     132abc
    Status Should Be       401            ${resp}

