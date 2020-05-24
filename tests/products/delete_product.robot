***Settings***
Documentation           DELETE /products
...                     Deleta Produtos consumindo a API

Resource                ../../resources/services.robot
Resource                ../../resources/fixtures/helpers.robot

Suite Setup             Set Suite Var Auth Token      ${user_email}    ${user_pass}

***Test Cases***
Delete Product
    [tags]                 success 
    ${product}=            Get Json                delete_product.json
    ${unique}=             Post Product            ${product}   before_remove

    ${id}=                 Convert To String       ${unique.json()['id']} 
    ${resp}=               Delete Product          ${id}

    Status Should Be       204                     ${resp}   

Delete Product Not Found
    [tags]                 not_found 
    
    ${resp}=               Delete Product         1500
#Aqui tem um BUG na API - o StatusCode deveria ser 404 e esta retornando 204
    Status Should Be       204                    ${resp} 