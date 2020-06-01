***Settings***
Documentation           Aqui nós vamos encapsular algumas chamadas de serviços

Library                 RequestsLibrary    
Library                 libs/database.py


***Variables***
${base_url}             http://pixel-api:3333

***Variables***
${user_email}           vanessaredes@yahoo.com.br
${user_pass}            123456

***Keywords***
#### Hooks ####
Set Suite Var Auth Token
    [Arguments]         ${email}         ${senha}
   
    ${resp}          Post Token            ${email}         ${senha}
    ${token}         Convert To String     JWT ${resp.json()['token']}

    Set Suite Variable       ${token}

#### Steps ####

Post Token
    [Arguments]         ${email}         ${senha}

    Create Session      pixel     ${base_url}

    &{headers}=         Create Dictionary     Content-Type=application/json
    &{payload}=         Create Dictionary     email=${email}          password=${senha} 

    ${resp}=            Post Request          pixel       /auth       data=${payload}    headers=${headers}

    [Return]            ${resp}

Post Product
    [Arguments]        ${payload}    ${remove}    

    Run Keyword if      "${remove}" == "before_remove" 
    ...                 Remove Product By Title   ${payload['title']}

    Create Session      pixel                  ${base_url}
    &{headers}=         Create Dictionary       Authorization=${token}    Content-Type=application/json       
    
    ${resp}=            Post Request        pixel       /products         data=${payload}         headers=${headers}  

    [Return]            ${resp}

Get Product
    [Arguments]        ${id}

    Create Session      pixel                  ${base_url}
    &{headers}=         Create Dictionary       Authorization=${token}    Content-Type=application/json  

    ${resp}=            Get Request        pixel       /products/${id}    headers=${headers}  

    [Return]            ${resp}

Get Produtcs
    Create Session      pixel                  ${base_url}
    &{headers}=         Create Dictionary       Authorization=${token}    Content-Type=application/json  

    ${resp}=            Get Request        pixel       /products    headers=${headers}  

    [Return]            ${resp}

Put Product 
    [Arguments]        ${id}        ${payload}      ${remove} 

    Remove Product By Title   ${payload['title']}

    Create Session      pixel                  ${base_url}
    &{headers}=         Create Dictionary       Authorization=${token}    Content-Type=application/json  

    ${resp}=            Put Request        pixel       /products/${id}     data=${payload}     headers=${headers}  
   
    [Return]            ${resp}

Delete Product
    [Arguments]        ${id}

    Create Session      pixel                  ${base_url}
    &{headers}=         Create Dictionary       Authorization=${token}    Content-Type=application/json  

    ${resp}=            Delete Request        pixel       /products/${id}    headers=${headers}  

    [Return]            ${resp}