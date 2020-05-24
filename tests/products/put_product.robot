***Settings***
Documentation           PUT /products
...                     Testes do Update de Produtos consumindo a API

Resource                ../../resources/services.robot
Resource                ../../resources/fixtures/helpers.robot

Suite Setup             Set Suite Var Auth Token      ${user_email}    ${user_pass}

***Test Cases***
Update a Product
    
    ${payload_before}=            Get Json                updateBefore.json

    ${before}=             Post Product            ${payload_before}       before_remove
    Status Should Be       200     ${before}

    ${id}=                 Convert To String       ${before.json()['id']} 
        
    ${payload}=            Get Json                updateAfter.json        
    ${resp}=               Put Product   ${id}     ${payload}              before_remove
    Status Should Be       204     ${resp}


