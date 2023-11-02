*** Settings ***
Resource            ../user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check user view candidate with group permission (OL-T16875)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${candidate_name} =     Add a Candidate    location_name=${test_location}
    Switch to user  ${test_user_name}
    Check element display on screen  ${candidate_name}
    Capture page screenshot


Check user view candidate with no group permission (OL-T16876, OL-T16878)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${candidate_name} =     Add a Candidate
    Switch to user  ${test_user_name}
    Check element not display on screen  ${candidate_name}
    Capture page screenshot


Check user view candidate with location permission (OL-T16877)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to CEM page
    ${candidate_name} =     Add a Candidate  group_name=${test_group_name}    location_name=${test_location}
    Switch to user  ${test_user_name}
    Check element display on screen  ${candidate_name}
    Capture page screenshot
