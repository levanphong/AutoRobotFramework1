*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/location_attributes_page.robot
Variables           ../../../locators/system_attributes_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco


*** Test Cases ***
Check user has perm full access to System Attributes page (OL-T16979)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role    System Attributes   Full Access
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    switch to user  ${user_fname}
    check user can view and edit or delete on System Attributes page
    # Deactive user after check
    Go to Users, Roles, Permissions page
    switch to user  ${TEAM_USER}
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Check user has perm is No access to System Attributes page (OL-T17003)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role    System Attributes   No Access
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    switch to user  ${user_fname}
    cannot see the System Attributes page on the menu
    # Deactive user after check
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Check user has perm view access to System Attributes page (OL-T19740)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role     System Attributes   View Access
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    switch to user  ${user_fname}
    check user can view but not add on System Attributes page
    # Deactive user after check
    Go to CEM page
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Check user has perm full access to System Attributes page in case User has Legacy role is: only PA can view SA page (OL-T19714)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    check user can view and edit or delete on System Attributes page


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Edit nothing (when Franchise ON) (OL-T19722)
    user can not access System Attributes page when has perm is No access      Full User - Edit Nothing


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Edit everything (when Franchise ON) (OL-T19726)
    user can not access System Attributes page when has perm is No access       Full User - Edit Everything


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Hiring manager (when Franchise ON) (OL-T19723)
    user can not access System Attributes page when has perm is No access       Hiring Manager


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Recruiter (when Franchise ON) (OL-T19724)
    user can not access System Attributes page when has perm is No access       Recruiter


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Franchise Staff (when Franchise ON) (OL-T19727)
    user can not access System Attributes page when has perm is No access       Franchise Staff


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Franchise Owner (when Franchise ON) (OL-T19728)
    user can not access System Attributes page when has perm is No access       Franchise Owner


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Company Admin (when Franchise ON) (OL-T19721)
    user can not access System Attributes page when has perm is No access       Company Admin


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Supervisor (when Franchise ON) (OL-T19725)
    user can not access System Attributes page when has perm is No access       Supervisor


Check user has perm is No access to System Attributes page in case User has Leagcy role is: - Reporting (when Franchise ON) (OL-T19729)
    user can not access System Attributes page when has perm is No access       Reporting User


*** Keywords ***
cannot see the System Attributes page on the menu
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      System Attributes
    capture page screenshot

check user can view and edit or delete on System Attributes page
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    Then All Location Attributes list is displayed
    Capture page screenshot
    Add a Custom Location Attribute     Custom Attribute Test
    ${attribute_name_after_edited} =    Edit a Custom Location Attribute    Custom Attribute Test
    Capture page screenshot
    Delete location attribute    ${attribute_name_after_edited}
    Capture page screenshot

user can not access System Attributes page when has perm is No access
    [Arguments]     ${role_name}
    Given Setup test
    when Login into system with company    ${role_name}    ${COMPANY_FRANCHISE_ON}
    cannot see the System Attributes page on the menu
    # Check navigate by URL
    ${is_correct_page} =    Run keyword and return status       Go to System Attributes
    IF  '${is_correct_page}' == 'False'
        check element not display on screen      System Attributes
    END
    capture page screenshot

check user can view but not add on System Attributes page
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    Check element display on screen    ${HEADER_ATTRIBUTE_NAME}
    Check element display on screen    ${HEADER_KEY_NAME}
    Check element display on screen    ${HEADER_DESCRIPTION}
    Check element display on screen    ${HEADER_LAST_EDITED}
    Check element display on screen    ${TEXTBOX_SEARCH_ATTRIBUTES}
    Capture page screenshot
    Check element not display on screen    ${BUTTON_ADD_ATTRIBUTE}
    Capture page screenshot
