*** Settings ***
Resource            ./user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check export option (OL-T16869)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Open Export option
    Check element display on screen  Export CSV
    Check element display on screen  Export PDF
    Check element display on screen  Export XLSX
    Capture page screenshot


Check export by CSV (OL-T16870)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Open Export option
    Click by JS  Export CSV
    Click at  ${EXPORT_USER_LIST_EXPORT_BUTTON}
    Capture page screenshot


Check export by PDF (OL-T16871)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Open Export option
    Click by JS  Export PDF
    Click at  ${EXPORT_USER_LIST_EXPORT_BUTTON}
    Capture page screenshot


Check export by XLSX (OL-T16872)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Open Export option
    Click by JS  Export XLSX
    Click at  ${EXPORT_USER_LIST_EXPORT_BUTTON}
    Capture page screenshot

*** Keywords ***
Open Export option
    Click at  ${USER_LIST_EXPORT_BUTTON}
    ${is_export_option_displayed} =    Run keyword and return status   Check element display on screen  Export CSV
    Capture Page Screenshot
    Run keyword unless  ${is_export_option_displayed}   Click by JS  ${USER_LIST_EXPORT_BUTTON}
    Capture Page Screenshot
