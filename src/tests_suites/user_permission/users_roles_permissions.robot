*** Settings ***
Resource            ./user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
COMBINE TEST CASE: Check permission of Offers when Hire ON / Franchise ON
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Users, Roles, Permissions permission for User Role     ${BASIC}   No Access
    Check Users, Roles, Permissions permission for User Role     ${CP_ADMIN}   Full Access
    Check Users, Roles, Permissions permission for User Role     ${EDIT_EVERYTHING}   No Access
    Check Users, Roles, Permissions permission for User Role     ${EDIT_NOTHING}   No Access
    Check Users, Roles, Permissions permission for User Role     ${FO}   Full Access
    Check Users, Roles, Permissions permission for User Role     ${FS}   Full Access
    Check Users, Roles, Permissions permission for User Role     ${HM}   No Access
    Check Users, Roles, Permissions permission for User Role     ${RECRUITER}   No Access
    Check Users, Roles, Permissions permission for User Role     ${REPORT}   No Access
    Check Users, Roles, Permissions permission for User Role     ${SUPER_VISOR}   No Access


COMBINE TEST CASE: Check permission of Offers when Hire OFF
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Check Users, Roles, Permissions permission for User Role     ${CP_ADMIN}   Full Access
    Check Users, Roles, Permissions permission for User Role     ${EDIT_EVERYTHING}   Full Access
    Check Users, Roles, Permissions permission for User Role     ${EDIT_NOTHING}   No Access


COMBINE TEST CASE: Check permission of Offers when Franchise OFF
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Check Users, Roles, Permissions permission for User Role     ${HM}   No Access
    Check Users, Roles, Permissions permission for User Role     ${REPORT}   No Access
    Check Users, Roles, Permissions permission for User Role     ${RECRUITER}   No Access
    Check Users, Roles, Permissions permission for User Role     ${SUPER_VISOR}   No Access


Check migrate Basic user has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22571)
    Given Setup test
    Login into system    ${BASIC}
    Check element not display on screen  ${CANDIDATE_INBOX}


Check migrate Company Admin(when Olivia Hire ON) has perm full access to the Users, Roles & Permission page (OL-T22569)
    Given Setup test
    when Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check User role with Full Access permission


Check migrate Company Admin has perm full access to the Users, Roles & Permission page (OL-T22568)
    Given Setup test
    when Login into system with company    ${CP_ADMIN}    ${COMPANY_HIRE_OFF}
    Check User role with Full Access permission


Check migrate Edit everything (when Franchise ON) has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22578)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Edit everything has perm full access to the Users, Roles & Permission page (OL-T22570)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_HIRE_OFF}
    Check User role with Full Access permission


Check migrate Edit nothing (when Franchise ON) has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22577)
    Given Setup test
    when Login into system with company    ${EDIT_NOTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Edit nothing has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22576)
    Given Setup test
    when Login into system with company    ${EDIT_NOTHING}    ${COMPANY_HIRE_OFF}
    Check User role with No Access permission


Check migrate Franchise Owner (Only Check migrate when Franchise ON) has perm Full access to edit the Users on the Users, Roles & Permission page (OL-T22573)
    [Tags]  skip
    # User with role Franchise Owner can't add new user anymore
    # Refer to: https://docs.google.com/spreadsheets/d/1HX3ziR42R3jgRJA9TH67B7xZW9b6u8i9KYxTkjf7Pg4/edit#gid=0
    Given Setup test
    when Login into system with company    ${FO}    ${COMPANY_FRANCHISE_ON}
    Check User role with Full Access permission


Check migrate Franchise Staff (Only Check migrate when Franchise ON) has perm Full access to edit the Users on the Users, Roles & Permission page (OL-T22572)
    [Tags]  skip
    # User with role Franchise Staff can't add new user anymore
    # Refer to: https://docs.google.com/spreadsheets/d/1HX3ziR42R3jgRJA9TH67B7xZW9b6u8i9KYxTkjf7Pg4/edit#gid=0
    Given Setup test
    when Login into system with company    ${FS}    ${COMPANY_FRANCHISE_ON}
    Check User role with Full Access permission


Check migrate Hiring manager(when Franchise ON) has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22580)
    Given Setup test
    when Login into system with company    ${HM}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Hiring manager has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22579)
    Given Setup test
    when Login into system with company    ${HM}    ${COMPANY_FRANCHISE_OFF}
    Check User role with No Access permission


Check migrate Recruiter(when Franchise ON) has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22582)
    Given Setup test
    when Login into system with company    ${RECRUITER}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Recruiter has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22581)
    Given Setup test
    when Login into system with company    ${RECRUITER}    ${COMPANY_FRANCHISE_OFF}
    Check User role with No Access permission


Check migrate Reporting User(when Franchise ON) has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22575)
    Given Setup test
    when Login into system with company    ${REPORT}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Reporting User has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22574)
    Given Setup test
    when Login into system with company    ${REPORT}    ${COMPANY_FRANCHISE_OFF}
    Check User role with No Access permission


Check migrate Supervisor(when Franchise ON) has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22584)
    Given Setup test
    when Login into system with company    ${SUPER_VISOR}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check migrate Supervisor has perm no access to edit the Users on the Users, Roles & Permission page (OL-T22583)
    Given Setup test
    when Login into system with company    ${SUPER_VISOR}    ${COMPANY_FRANCHISE_OFF}
    Check User role with No Access permission

*** Keywords ***
Check User role with No Access permission
    ${is_redirected} =  Run keyword and return status    Go to Users, Roles, Permissions page
    Capture page screenshot
    Run keyword if     '${is_redirected}' == 'True'   Fail

Check User role with Full Access permission
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Add new availability time and save  ${user_fname}
    Edit an availability time and save  ${user_fname}
    Delete an availability time and save  ${user_fname}
    Cancel in Clear all availability time and save  ${user_fname}
    Clear all availability time and save  ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
    Click at  ${AVAILABILITY_CONFIRM_CHANGES_POPUP_NO_BUTTON}
    Open user Availability edit widget  ${user_fname}
    Capture page screenshot
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
    Click at  ${AVAILABILITY_CONFIRM_CHANGES_POPUP_YES_BUTTON}
    Capture page screenshot
    Deactivate a User   ${user_fname}

Check Users, Roles, Permissions permission for User Role
    [Arguments]     ${user_role}    ${expected_permission}
    Navigate to User Role view page     ${user_role}
    Check permission for product by role      Users, Roles And Permissions   ${expected_permission}
