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
Auth Token
    [Arguments]     ${email}         ${senha}
    Create Session         pixel     ${base_url}


    &{headers}=      Create Dictionary     Content-Type=application/json
    &{payload}=      Create Dictionary     email=${email}          password=${senha} 

    ${resp}=         Post Request          pixel       /auth       data=${payload}    headers=${headers}    

    ${token}         Convert To String     JWT ${resp.json()['token']}
    Set Suite Variable       ${token}

Post Product
    [Arguments]        ${payload}     ${token}      ${remove}    

    Run Keyword if      "${remove}" == "before_remove" 
    ...                 Remove Product By Title   ${payload['title']}

    Create Session      pixel                  ${base_url}
    &{headers}=         Create Dictionary       Authorization=${token}    Content-Type=application/json       
    
    ${resp}=            Post Request        pixel       /products       data=${payload}         headers=${headers}  

    [Return]            ${resp}