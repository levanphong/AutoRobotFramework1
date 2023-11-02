*** Settings ***
Resource            ./user_permission_common_keywords.resource
Resource            ../../pages/offers_page.robot
Resource            ../../pages/client_setup_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
COMBINE TEST CASE: Check permission of Offers
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Offers permission for User Role     ${CP_ADMIN}   Full Access
    Check Offers permission for User Role     ${EDIT_EVERYTHING}   No Access
    Check Offers permission for User Role     ${EDIT_NOTHING}   No Access
    Check Offers permission for User Role     ${HM}   No Access
    Check Offers permission for User Role     ${LIMITED_USER}   No Access
    Check Offers permission for User Role     ${RECRUITER}   No Access
    Check Offers permission for User Role     ${SUPER_VISOR}   No Access


Check "Allow Company Admin, Franchise Owner, and Franchise Staff to edit Offers" is removed from Hire (OL-T22479, OL-T22480)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Client setup page
    Click at  ${HIRE_LABEL}
    Check element not display on screen  Allow Company Admin, Franchise Owner, and Franchise Staff to edit Offers
    Capture page screenshot
    Switch to Company v2  ${COMPANY_NEW_ROLE}
    Check element not display on screen  Allow Company Admin, Franchise Owner, and Franchise Staff to edit Offers
    Capture page screenshot


Check Account admin role is set to No access by default for Offers page after mirgating the data (OL-T22467)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Navigate to User Role view page     ${ACCOUNT_ADMIN}
    Check permission for product by role      Offers   No Access
    Capture page screenshot


Check Company admin role has full access to view, edit, and manage the offer page after mirgating the data (OL-T22470)
    Given Setup test
    when Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check action in Offers page
    ${offer_name} =     Create a new offer
    ${offer_name_2} =     Duplicate an offer    ${offer_name}
    Delete a offer  ${offer_name_2}
    Check element not display on screen  ${offer_name_2}
    Delete a offer  ${offer_name}
    Check element not display on screen  ${offer_name}


Check Edit everything role has no access to the Offers page after mirgating the data (OL-T22474)
    Given Setup test
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Edit nothing role has no access to the offers page after mirgating the data (OL-T22473)
    Given Setup test
    Login into system with company    ${EDIT_NOTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Hiring manager role has no access to the Offers page after mirgating the data (OL-T22475)
    Given Setup test
    Login into system with company    ${HM}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Power user role is set to No access by default for Offers page after mirgating the data (OL-T22468)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Navigate to User Role view page     ${POWER_USER}
    Check permission for product by role      Offers   No Access
    Capture page screenshot


Check Recruiter role has no access to the Offers page offer mirgating the data (OL-T22476)
    Given Setup test
    Login into system with company    ${RECRUITER}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Supervisor role has no access to the offers page after mirgating the data (OL-T22477)
    Given Setup test
    Login into system with company    ${SUPER_VISOR}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission

*** Keywords ***
Check User role with No Access permission
    ${is_redirected} =    Go to Offers page
    Capture page screenshot
    Run keyword if     '${is_redirected}' == 'True'   Fail

Check Offers permission for User Role
    [Arguments]     ${user_role}    ${expected_permission}
    Navigate to User Role view page     ${user_role}
    Check permission for product by role      Offers   ${expected_permission}
