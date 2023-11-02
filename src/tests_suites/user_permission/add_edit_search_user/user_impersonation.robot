*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/set_your_password_page.robot
Resource            ../../../pages/event_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check the User Impersonation toggle is added to System access Parametter - Users page (OL-T17032)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Roles and Permissions page
    ${role_name} =      Generate random name only text      Company Admin_
    Click at  ${ADD_NEW_USER_ROLE_BUTTON}
    Check display of Add new user role modal
    Input into  ${ADD_NEW_USER_ROLE_NAME_TEXT_BOX}  ${role_name}
    Click at  ${ADD_NEW_USER_LEGACY_ROLE_DROPDOWN}
    Click at  ${ADD_NEW_USER_LEGACY_ROLE_VALUE}  Company Admin
    Click at    ${ADD_NEW_USER_ROLE_SAVE_BUTTON}
    check label display     User Impersonation
    check element display on screen     ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_TOGGLE}
    capture page screenshot
    Turn on     ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_TOGGLE}
    Click at    ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_DROPDOWN}
    check span display      Only this Role
    check span display      All Roles
    capture page screenshot
    Click at    ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_OPTIONS}     Only this Role
    Set permission for feature base on role Account Admin
    Click at    ${USER_ROLE_SAVE_BUTTON}
    Navigate to User Role edit page     ${role_name}
    ${impersonation_selected}=      get value and format text    ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_INPUT}
    Should be equal as strings    ${impersonation_selected}   Only this Role
    capture page screenshot
    Click at    ${USER_ROLE_CANCEL_BUTTON}


Check User Permission in case the All roles option is selected at the User Impersonation toggle (OL-T17033)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check user permission with User Impersonation type      All Roles


Check User Permission in case the Only this role option is selected at the User Impersonation toggle (OL-T17034)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check user permission with User Impersonation type      Only this Role


*** Keywords ***
Check user permission with User Impersonation type
    [Arguments]     ${impersonation_options}
    ${role_name}=   Add a User role     ${CP_ADMIN}   impersonation_options=${impersonation_options}
    Go to Users, Roles, Permissions page
    ${user_fname}=     Add a User      role=${role_name}    is_spam_email=False
    Input into      ${SEARCH_USER_TEXT_BOX}       ${user_fname}
    ${text_email}=      get text and format text    ${EMAIL_USER_NAME}      ${user_fname}
    Click button in email    Welcome to Olivia      ${user_fname}     CREATE_USER_ROLE
    ${password}=    Set password for user   1345
    Input into      ${EMAIL_INPUT}      ${text_email}
    Click at    ${BUTTON_NEXT}
    Input into      ${PASSWORD_INPUT}       ${password}
    Click at    ${BUTTON_SIGN_IN}
    wait for cem display
    Click at    ${SWITCH_USER_BTN}
    IF  '${impersonation_options}' == 'Only this Role'
        Check element display on screen     ${role_name}
        Check element display on screen     ${SWITCH_USER_LIST_VIEW_AS_USER_EMPTY}
        capture page screenshot
    ELSE IF     '${impersonation_options}' == 'All Roles'
        @{list_user}=     Create List     CA Team     FS Team    Supervisor Team   EE Team    EN Team     Hiring Team     Reporting Team
        FOR   ${user_name_by_role}      IN      @{list_user}
            Input into      ${USERS_FILTER_TEXT_BOX}    ${user_name_by_role}
            check element display on screen     ${user_name_by_role}
            capture page screenshot
        END
    END
    logout from system by URL
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    #Delete user after check
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}
