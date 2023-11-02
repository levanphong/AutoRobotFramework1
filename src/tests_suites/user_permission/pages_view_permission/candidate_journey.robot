*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/candidate_journeys_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco


*** Variables ***


*** Test Cases ***
Check User has Full access to the Candidate journey page if the User role updated to Full Access (OL-19061)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    Verify action in Candidate Journeys page  Full User - Edit Everything


Check User has no access to the Candidate journey page if the User role updated to No Access (OL-19060)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    ${user_role_name} =     Add a User role  Full User - Edit Nothing
    navigate to user role edit page     ${user_role_name}
    # Default is No Access permission, thus need to change to Full Access firstly.
    Set permission for corresponding role     Candidate Journeys    Full Access
    navigate to user role edit page     ${user_role_name}
    Set permission for corresponding role     Candidate Journeys    No Access
    Capture page screenshot
    Go to Users, Roles, Permissions page
    ${user_name} =    Add a User    role=${user_role_name}
    Switch to user  ${user_name}
    Capture page screenshot
    ${is_redirected} =      Go to Candidate Journeys page
    Run keyword unless      '${is_redirected}' == 'False'   Fail
    Capture page screenshot
    Switch to user  ${TEAM_USER}
    Deactivate and delete User role     ${user_name}   ${user_role_name}


Check User only has viewing access to the Candidate journey page if the User role updated to View Access (OL-19059, OL-19053)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    ${user_role_name} =     Add a User role  Full User - Edit Nothing
    navigate to user role edit page     ${user_role_name}
    Set permission for corresponding role      Candidate Journeys    View Access
    Capture page screenshot
    Go to Users, Roles, Permissions page
    ${user_name} =    Add a User    role=${user_role_name}
    Switch to user  ${user_name}
    Capture page screenshot
    ${is_redirected} =      Go to Candidate Journeys page
    Run keyword unless      '${is_redirected}' == 'True'   Fail
    Capture page screenshot
    Switch to user old version   ${TEAM_USER}
    Deactivate and delete User role     ${user_name}   ${user_role_name}


Check Account admin role is set to Full access by default for Candidate journey page after mirgating the data (OL-19048)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Navigate to User Role edit page     Account Admin
    Verify role attribute   Candidate Journeys    Full Access
    Capture page screenshot


Check Company admin role has full access to view, edit, and manage the Candidate journey page after mirgating the data (OL-19049)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    Verify action in Candidate Journeys page  Company Admin


Check Edit everything role has no access to the Candidate journey page after mirgating the data (OL-19054)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    Add a User with role cannot go to Candidate Journeys page  Full User - Edit Everything


Check Franchise Owner role has no access to the Candidate journey page after mirgating the data (OL-19052)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    Add a User with role cannot go to Candidate Journeys page  Franchise Owner


Check Francise Staff role has no access to the Candidate journey page after mirgating the data (OL-19051)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    Add a User with role cannot go to Candidate Journeys page  Franchise Staff


Check Hiring manager role has no access to the Candidate journey page after mirgating the data (OL-T19055)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Candidate Journeys permission is No Access    Hiring Manager
    # Check Candidate Journey page not display
    Go to CEM page
    Switch to user  Hiring Team
    Verify page not display in Right Menu   Candidate Journeys


Check Limited user role is set to No access by default for Candidate journey page after mirgating the data (OL-T19058)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Candidate Journeys permission is No Access    Limited User
    # Check Candidate Journey page not display
    Go to CEM page
    Switch to user  EN Team
    Verify page not display in Right Menu   Candidate Journeys


Check Power User role is set to No access by default for Candidate journey page after mirgating the data (OL-T19050)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check Candidate Journeys permission is No Access    Power User
    # Check Candidate Journey page not display
    Go to Users, Roles, Permissions page
    ${user_name} =    Add a User    role=Power User
    Go To CEM page
    Switch to user  ${user_name}
    Verify page not display in Right Menu   Candidate Journeys
    Capture page screenshot
    Switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_name}


Check Supervisor role has no access to the Candidate journey page after mirgating the data (OL-T19057)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Candidate Journeys permission is No Access    Supervisor
    # Check Candidate Journey page not display
    Go to CEM page
    Switch to user  Supervisor Team
    Verify page not display in Right Menu   Candidate Journeys


Check Recruiter role has no access to the Candidate journey page after mirgating the data (OL-T19056)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Candidate Journeys permission is No Access    Recruiter
    # Check Candidate Journey page not display
    Go to CEM page
    Switch to user  Recruiter Team
    Verify page not display in Right Menu   Candidate Journeys


*** Keywords ***
Verify action in Candidate Journeys page
    [Arguments]    ${legacy_role}
    # Add a Role with No Access in Candidate Journey and then change to Full Access
    ${user_role_name} =     Add a User role  ${legacy_role}
    navigate to user role edit page     ${user_role_name}
    Set permission for corresponding role    Candidate Journeys    Full Access
    Capture page screenshot
    # Add a User and assign to Role above
    Go to Users, Roles, Permissions page
    ${user_name} =    Add a User    role=${user_role_name}
    Switch to user  ${user_name}
    # Check permission with Candidate Journey
    ${cj_name} =    Add a Candidate Journey
    Capture page screenshot
    ${new_cj_name} =    Duplicate a Journey     ${cj_name}
    Capture page screenshot
    # Delete after test
    Switch to user old version  ${TEAM_USER}
    Delete a Journey     ${cj_name}
    Delete a Journey     ${new_cj_name}
    Deactivate and delete User role     ${user_name}    ${user_role_name}

Add a User with role cannot go to Candidate Journeys page
    [Arguments]    ${legacy_role}
    Go to Users, Roles, Permissions page
    ${user_name} =    Add a User    role=${legacy_role}
    Switch to user  ${user_name}
    Capture page screenshot
    ${is_redirected} =      Go to Candidate Journeys page
    Run keyword unless      '${is_redirected}' == 'False'   Fail
    Capture page screenshot
    # Delete test data
    Switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_name}

Verify page not display in Right Menu
    [Arguments]     ${page_name}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_SETTING_ICON}
    Check element not display on screen  ${CEM_PAGE_RIGHT_MENU_ITEM}  ${page_name}
    Capture page screenshot

Check Candidate Journeys permission is No Access
    [Arguments]     ${user_role}
    Navigate to User Role edit page  ${user_role}
    Click at    ${USER_ROLE_PERMISSION_SELECT}  Candidate Journeys
    Verify display text  ${EDIT_USER_ROLE_PERMISSION_ATTR_SELECTED_VALUE}  No Access
    Capture page screenshot

Deactivate and delete User role
    [Arguments]     ${user_fname}   ${user_role_name}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}
    # If new Candidate Journey added, it will automatically add all User Roles. So just ignore Delete user role error. We will delete it after all.
    Run keyword and ignore error    Delete a User role  ${user_role_name}
