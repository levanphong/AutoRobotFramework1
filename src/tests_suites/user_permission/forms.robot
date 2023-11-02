*** Settings ***
Resource            ./user_permission_common_keywords.resource
Resource            ../../pages/forms_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
COMBINE TEST CASE: Check permission of Offers
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Forms permission of User Role after migrated     ${CP_ADMIN}   Full Access
    Check Forms permission of User Role after migrated     ${EDIT_EVERYTHING}   No Access
    Check Forms permission of User Role after migrated     ${EDIT_NOTHING}   No Access
    Check Forms permission of User Role after migrated     ${HM}   No Access
    Check Forms permission of User Role after migrated     ${RECRUITER}   No Access
    Check Forms permission of User Role after migrated     ${SUPER_VISOR}   No Access


Check User only has viewing access to the offer page if the User role updated to View Access (OL-T22463)
    Given Setup test
    when Login into system with company    ${ViewOnly}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    ${user_role_name} =     Add a User role  ${EDIT_EVERYTHING}
    navigate to user role edit page     ${user_role_name}
    # Change permission of Forms page to View Access
    Set permission for corresponding role     Forms    View Access
    Capture page screenshot
    # Add a User with created role
    Go to Users, Roles, Permissions page
    ${user_name} =    Add a User    role=${user_role_name}
    Switch to user  ${user_name}
    Capture page screenshot
    ${is_redirected} =      Go to form page
    # Check user only view and can't add Form for Candidate
    Select form type    Candidate
    Check element not display on screen  ${NEW_CANDIDATE_FORM_BUTTON}    wait_time=2s
    # Check user only view and can't add Form for User
    Select form type    User
    Check element not display on screen  ${NEW_USER_FORM_BUTTON}    wait_time=2s
    Capture page screenshot
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${user_role_name}


Check Account admin role is set to Full access by default for Forms page after mirgating the data (OL-T22452)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check Forms permission of User Role after migrated     ${ACCOUNT_ADMIN}   Full Access


Check Company admin role has full access to view, edit, and manage the forms page after mirgating the data (OL-T22455)
    Given Setup test
    Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check action in Forms page for Full Access permission


Check Edit everything role has no access to the Forms page after mirgating the data (OL-T22459)
    Given Setup test
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Edit nothing role has no access to the forms page after mirgating the data (OL-T22458)
    Given Setup test
    Login into system with company    ${EDIT_NOTHING}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Hiring manager role has no access to the Forms page after mirgating the data (OL-T22460)
    Given Setup test
    Login into system with company    ${HM}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Limit user role is set to No access by default for Forms page after mirgating the data (OL-T22454)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Forms permission of User Role after migrated     ${LIMITED_USER}   No Access


Check permision of the FS/FO users role in case "Custom onboarding toggle" is OFF and FS/FO has full access permission (OL-T22466)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Switch to user  ${FO_TEAM}
    Check action in Forms page for Full Access permission
    Switch to user  ${FS_TEAM}
    Check action in Forms page for Full Access permission


Check permision of the FS/FO users role in case "Custom onboarding toggle" is ON and FS/FO has full access permission (OL-T22464)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user  ${FO_TEAM}
    Check User role with View Access permission
    Switch to user  ${FS_TEAM}
    Check User role with View Access permission


Check Recruiter role has no access to the Forms page offer mirgating the data (OL-T22461)
    Given Setup test
    Login into system with company    ${RECRUITER}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Supervisor role has no access to the forms page after mirgating the data (OL-T22462)
    Given Setup test
    Login into system with company    ${SUPER_VISOR}    ${COMPANY_FRANCHISE_ON}
    Check User role with No Access permission


Check Power user role is set to No access by default for Forms page after mirgating the data (OL-T22453)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check Forms permission of User Role after migrated     ${POWER_USER}   No Access

*** Keywords ***
Check Forms permission of User Role after migrated
    [Arguments]     ${user_role}    ${expected_permission}
    Navigate to User Role view page     ${user_role}
    Check permission for product by role      Forms   ${expected_permission}

Check action in Forms page for Full Access permission
    # Check create Form
    go to form page
    ${form_name} =  Add new form and input name     Candidate
    go to form page
    Input into  ${SEARCH_FORM_TEXTBOX}  ${form_name}
    Check element display on screen  ${form_name}
    Capture page screenshot
    # Check duplicate Form
    ${form_name_2} =    Duplicate a Form    ${form_name}
    Capture page screenshot
    # Check delete Form
    Delete a form with type   Candidate   ${form_name_2}
    Capture page screenshot
    Delete a form with type   Candidate   ${form_name}
    Capture page screenshot

Check User role with No Access permission
    ${is_redirected} =    Go to form page
    Capture page screenshot
    Run keyword if     '${is_redirected}' == 'True'   Fail

Check User role with View Access permission
    ${is_redirected} =    Go to form page
    Capture page screenshot
    Run keyword if     '${is_redirected}' == 'False'   Fail
    # Can go to Form page but can't add new form
    Select form type    Candidate
    Check element not display on screen  ${NEW_CANDIDATE_FORM_BUTTON}    wait_time=2s
    # Check user only view and can't add Form for User
    Select form type    User
    Check element not display on screen  ${NEW_USER_FORM_BUTTON}    wait_time=2s
    Capture page screenshot
