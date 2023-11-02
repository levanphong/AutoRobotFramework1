*** Settings ***
Resource            ../user_permission_common_keywords.resource
Resource            ../../../pages/conversation_builder_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
COMBINE TEST CASE: Check permission of Conversation when Hire ON / Franchise ON
    [Tags]  skip
    # https://paradoxai.atlassian.net/browse/OL-65172
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Conversation Builder permission for User Role     ${BASIC}   No Access
    Check Conversation Builder permission for User Role     ${CP_ADMIN}   Full Access
    Check Conversation Builder permission for User Role     ${EDIT_EVERYTHING}   No Access
    Check Conversation Builder permission for User Role     ${EDIT_NOTHING}   No Access
    Check Conversation Builder permission for User Role     ${FO}   No Access
    Check Conversation Builder permission for User Role     ${FS}   No Access
    Check Conversation Builder permission for User Role     ${HM}   No Access
    Check Conversation Builder permission for User Role     ${RECRUITER}   No Access
    Check Conversation Builder permission for User Role     ${REPORT}   No Access
    Check Conversation Builder permission for User Role     ${SUPER_VISOR}   No Access


COMBINE TEST CASE: Check permission of Conversation when Hire OFF / Franchise OFF
    [Tags]  skip
    # https://paradoxai.atlassian.net/browse/OL-65172
    # https://paradoxai.atlassian.net/browse/OL-65207
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Check Conversation Builder permission for User Role     ${CP_ADMIN}   Full Access
    Check Conversation Builder permission for User Role     ${EDIT_EVERYTHING}   Full Access
    Check Conversation Builder permission for User Role     ${EDIT_NOTHING}   View Access
    Check Conversation Builder permission for User Role     ${HM}   No Access
    Check Conversation Builder permission for User Role     ${RECRUITER}   View Access
    Check Conversation Builder permission for User Role     ${REPORT}   View Access
    Check Conversation Builder permission for User Role     ${SUPER_VISOR}   View Access


Check migrate Basic user has perm no access to the Conversation Builder page (OL-T22592)
    Given Setup test
    Login into system    ${BASIC}
    Check element not display on screen  ${CANDIDATE_INBOX}


Check migrate Company Admin has perm full access to the Conversation Builder page (OL-T22585)
    Given Setup test
    Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Check User role with Full Access permission


Check migrate Company Admin(when Olivia Hire ON) has perm full access to the Conversation Builder page (OL-T22586)
    Given Setup test
    Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check User role with Full Access permission


Check migrate Edit everything (when Franchise ON) has perm no access to the Conversation Builder page (OL-T22597)
    Given Setup test
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Edit everything has perm full access to the Conversation Builder page (OL-T22587)
    Given Setup test
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_FRANCHISE_OFF}
    Check User role with Full Access permission


Check migrate Edit nothing (when Franchise ON) has perm no access to the Conversation Builder page (OL-T22596)
    Given Setup test
    Login into system with company    ${EDIT_NOTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Edit nothing has perm view access to the Conversation Builder page (OL-T22589)
    [Tags]  skip
    #https://paradoxai.atlassian.net/browse/OL-65207
    Given Setup test
    Login into system with company    ${EDIT_NOTHING}    ${COMPANY_FRANCHISE_OFF}
    Check User role with View Access permission


Check migrate Franchise Owner (Only Check migrate when Franchise ON) has perm no access to the Conversation Builder page (OL-T22594)
    Given Setup test
    Login into system with company    ${FO}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Franchise Staff (Only Check migrate when Franchise ON) has perm no access to the Conversation Builder page (OL-T22593)
    Given Setup test
    Login into system with company    ${FS}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Hiring manager has perm no access to the Conversation Builder page (OL-T22598)
    Given Setup test
    Login into system with company    ${HM}    ${COMPANY_FRANCHISE_OFF}
    Check User role with No Access permission


Check migrate Hiring manager(when Franchise ON) has perm no access to the Conversation Builder page (OL-T22599)
    Given Setup test
    Login into system with company    ${HM}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Recruiter has perm view access to the Conversation Builder page (OL-T22590)
    [Tags]  skip
    #https://paradoxai.atlassian.net/browse/OL-65207
    Given Setup test
    Login into system with company    ${RECRUITER}    ${COMPANY_FRANCHISE_OFF}
    Check User role with View Access permission


Check migrate Recruiter(when Franchise ON) has perm no access to the Conversation Builder page (OL-T22600)
    Given Setup test
    Login into system with company    ${RECRUITER}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Reporting User has perm view access to the Conversation Builder page (OL-T22588)
    [Tags]  skip
    # https://paradoxai.atlassian.net/browse/OL-65207
    Given Setup test
    Login into system with company    ${REPORT}    ${COMPANY_FRANCHISE_OFF}
    Check User role with View Access permission


Check migrate Reporting User (when Franchise ON) has perm no access to the Conversation Builder page (OL-T22595)
    Given Setup test
    Login into system with company    ${REPORT}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Supervisor has perm view access to the Conversation Builder page (OL-T22591)
    [Tags]  skip
    # https://paradoxai.atlassian.net/browse/OL-65207
    Given Setup test
    Login into system with company    ${SUPER_VISOR}    ${COMPANY_FRANCHISE_OFF}
    Check User role with View Access permission


Check migrate Suppervior(when Franchise ON) has perm no access to the Conversation Builder page (OL-T22601)
    Given Setup test
    Login into system with company    ${SUPER_VISOR}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


*** Keywords ***
Check User role with View Access permission
    Go to conversation builder
    Capture page screenshot
    Check element not display on screen  Add Conversation
    Capture page screenshot

Check User role with No Access permission
    ${is_redirected} =  Run keyword and return status    Go to conversation builder
    Capture page screenshot
    Run keyword if     '${is_redirected}' == 'True'   Fail

Check User role with Full Access permission
    ${conversation_name} =      Add Single conversation     Single Path
    Go to conversation builder
    Search Conversation in Conversation Builder     ${conversation_name}
    Capture page screenshot

Check Conversation Builder permission for User Role
    [Arguments]     ${user_role}    ${expected_permission}
    Navigate to User Role view page     ${user_role}
    Check permission for product by role      Conversation Builder   ${expected_permission}
