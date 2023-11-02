*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/school_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Navigate to Client setup page > Campus > Turn on Campus toggle

*** Variables ***

*** Test Cases ***
Check the School Management page is displayed under Settings - Campus in case user is Paradox Admin (OL-T17050, OL-T17051, OL-T17052)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check school management page is opened
    logout from system by URL
    Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Check school management page is opened
    logout from system by URL
    Login into system with company    Full User - Edit Everything    ${COMPANY_FRANCHISE_OFF}
    Check school management page is opened


Verify Paradox Admin User has full access to add new, edit a School (OL-T17054, OL-T17055, OL-T17058, OL-T17059, OL-T17056, OL-T17057)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check school management page is opened
    ${school_name_pa_role}=     Create a new school     Add a School
    ${school_name_pa_role_changed}=    Edit a school   ${school_name_pa_role}
    #delete a school after created
    Delete a school     ${school_name_pa_role_changed}
    go to CEM page
    Switch to user      Team Busy
    Check school management page is opened
    ${school_name_ca_role}=     Create a new school     Add a School
    ${school_name_ca_role_changed}=    Edit a school   ${school_name_ca_role}
    #delete a school after created
    Delete a school     ${school_name_ca_role_changed}


Verify Paradox Admin User has permission to add users that have access to Student Experience Management for All Schools (OL-T17060, OL-T17061, OL-T17062)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Student Experience Management toggle turn on by role      Company Admin
    Click at    ${MENU_SPAN}
    click at    ${SETTING_ICON}
    check element display on screen     School Management
    capture page screenshot
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=Company Admin
    Go to school management page
    Hover at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    Add a School
    Click at    ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_TEXTBOX}
    click at    ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}
    Input into    ${ADD_NEW_SCHOOL_ENTER_A_NAME_TO_ADD_TEXTBOX}     ${user_fname} Test
    check element display on screen     ${ADD_NEW_SCHOOL_USER_SUGGESTION_NAME}    ${user_fname} Test
    capture page screenshot
    Reload Page
    Hover at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    Add an Area
    Input into      ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}      ${user_fname} Test
    ${suggest_user_name} =    Format String     ${ADD_NEW_AN_AREA_ADD_USER_SUGGESTION}    ${user_fname} Test
    Element Should Be Visible    ${suggest_user_name}
    capture page screenshot
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}

*** Keywords ***
Check school management page is opened
    Go to school management page
    wait for page load successfully
    check span display  All Schools
    check span display  School Management
    capture page screenshot

Check Student Experience Management toggle turn on by role
    [Arguments]     ${role_name}
    Go to Users, Roles, Permissions page
    Click at    ${USERS_NAVIGATION_ROLE}    Roles and Permissions
    Navigate to User Role edit page     ${role_name}
    Check toggle is On      ${EDIT_USER_ROLE_PERMISSION_STUDENT_EXPERIENCE_MANAGER_TOGGLE}
    Click at    ${USER_ROLE_CANCEL_BUTTON}
