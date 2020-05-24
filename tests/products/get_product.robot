***Settings***
Documentation           POST /products
...                     Consulta de Produtos consumindo a API

Resource                ../../resources/services.robot
Resource                ../../resources/fixtures/helpers.robot

Suite Setup             Set Suite Var Auth Token      ${user_email}    ${user_pass}

***Test Cases***
Get Unique Product
    [tags]                 success 
    ${product}=            Get Json                get_unique.json
    ${unique}=             Post Product            ${product}   before_remove

    ${id}=                 Convert To String       ${unique.json()['id']} 
    ${resp}=               Get Product             ${id}

    Status Should Be       200                    ${resp}  
    Should Be Equal        ${resp.json()['title']}      ${product['title']}

Product Not Found
    [tags]                 not_found 
    
    ${resp}=               Get Product             1500

    Status Should Be       404                    ${resp} 

Get Products List
    [tags]                success 

    ${list}=              Get Json                list.json
    ${items}=             Set Variable            ${list['data']}

    FOR       ${item}     IN                      @{items}
                          Post Product            ${item}  before_remove  
    END 

    ${resp}=               Get Produtcs

    Status Should Be       200                    ${resp}
    Should Not Be Empty                           ${resp.json()['data']}  