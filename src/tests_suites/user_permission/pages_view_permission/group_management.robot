*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/school_management_page.robot
Resource            ../../../pages/group_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Navigate to Client Setup page > Hire > Turn off Job toggle

*** Variables ***

*** Test Cases ***
Check Company admin role has no access to the Group page after mirgating the data in case Olivia Hire ON (OL-T19160)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Check user can not access group management page with permission is No Access     Company Admin       Company Admin      No Access


Check Power User role is set to Full access by default for Group page after mirgating the data (OL-T19161)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check permission feature page by role   Power User     Group Management        Full Access


Check Francise Staff role has no access to the Group page after mirgating the data (OL-T19162)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check user can not access group management page with permission is No Access    Franchise Staff   Franchise Staff       No Access


Check Edit nothing role has no access to the Group page after mirgating the data (OL-T19164)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Check user can not access group management page with permission is No Access    Full User - Edit Nothing    Full User - Edit Nothing       No Access


Check Edit everything ((when Franchise ON)) role has no access to the Group page after mirgating the data (OL-T19165)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check user can not access group management page with permission is No Access     Full User - Edit Everything    Full User - Edit Everything     No Access


Check Hiring manager role has no access to the Group page after mirgating the data (OL-T19167)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Create a new user by role, check page not display and delete user after created     Hiring Manager      No Access     Hiring Manager


Check Supervisor role has no access to the Group page after mirgating the data (OL-T19169)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create a new user by role, check page not display and delete user after created     Supervisor     No Access     Supervisor


Check Limited user role is set to No access by default for Group page after mirgating the data (OL-T19170)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at    ${USERS_NAVIGATION_ROLE}    Roles and Permissions
    Click at    ${USER_ROLES_NAME_LIMITED_USER_LABEL}
    capture page screenshot
    Check permission for product by role       Group Management    No Access

*** Keywords ***
Check permission feature page by role
    [Arguments]     ${role_name}     ${product_name}    ${access_option}
    Go to Users, Roles, Permissions page
    Click at    ${USERS_NAVIGATION_ROLE}    Roles and Permissions
    check span display      Roles and Permissions
    capture page screenshot
    ${is_role_list_display} =   Run keyword and Return status   Check element display on screen  ${ROLES_AND_PERMISSION_LIST}    wait_time=2s
    Run keyword if  not ${is_role_list_display}     Reload page
    Scroll to a User role check Role exist    ${role_name}
    Click at    ${USER_ROLES_NAME_LABEL}    ${role_name}
    capture page screenshot
    Check permission for product by role       ${product_name}    ${access_option}

Check user can not access group management page with permission is No Access
    [Arguments]     ${role_title}     ${role}       ${access_option}
    Check permission feature page by role   ${role_title}    Group Management     ${access_option}
    ${role_name} =      Add a User role     legacy_role=${role}
    Navigate to User Role edit page     ${role_name}
    Set permission for corresponding role   Group Management    No Access
    Go to Users, Roles, Permissions page
    ${user_fname}=     Add a User      role=${role_name}
    switch to user  ${user_fname}
    capture page screenshot
    Click at    ${MENU_SPAN}
    click at    ${SETTING_ICON}
    capture page screenshot
    check element not display on screen     Group Management
    capture page screenshot
    Delete user role and user after checked     ${user_fname}       ${role_name}

Create a new user by role, check page not display and delete user after created
    [Arguments]     ${role_name_label}    ${access_option}      ${role}
    Check permission feature page by role       ${role_name_label}     Group Management    ${access_option}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role}
    switch to user  ${user_fname}
    capture page screenshot
    Click setting icon on menu
    check element not display on screen     Group Management
    capture page screenshot
    #Delete a user name
    Go to CEM page
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}

Create a new user by role, add a new group and delete group, user after created
    [Arguments]      ${role_name_label}     ${access_option}    ${role}
    Check permission feature page by role       ${role_name_label}    Group Management    ${access_option}
    Go to Users, Roles, Permissions page
    ${user_fname}=     Add a User      role=${role}
    switch to user  ${user_fname}
    ${group_name}=      Add a Group
    check element display on screen     ${group_name}
    capture page screenshot
    Go to Group Management page
    Delete a Group      ${group_name}
    check element not display on screen     ${group_name}
    capture page screenshot
    #Delete a user name
    Go to CEM page
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}

Delete user role and user after checked
    [Arguments]     ${user_fname}    ${role_name}
    go to CEM page
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    # Delete user after check
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}
