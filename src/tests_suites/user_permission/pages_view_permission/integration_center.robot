*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Turn ON Integration Center toggle at Client Setup Integrations


*** Test Cases ***
Check user has perm full access to Integration Center page (OL-T16980)
	Given Setup test
    when Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Integration Center page
    check user can view and action only Audit Logs at Integration Center page
    Go to CEM page


Check user has perm no access to Integration Center page (OL-T17004)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=${EDIT_EVERYTHING}
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role     Integration Center   No Access
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    switch to user  ${user_fname}
	cannot see the Integration Center page on the right menu
	Go to CEM page
	switch to user  ${TEAM_USER}
    # Deactive user after check
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Check user has perm full access to Integration Center page in case User has Legacy role is: - PA (OL-T19715)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Integration Center page
	check user can view and action all tab on Integration Center page
    capture page screenshot


Check user has perm view access to Integration Center page in case User has Legacy role is: - Company Admin (OL-T19716)
	Given Setup test
    Login into system with company    ${CP_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Integration Center page
    check user can view and action only Audit Logs at Integration Center page


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Edit nothing (OL-T19730)
    user can not access Integration Center page when has perm is No access      Full User - Edit Nothing


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Edit everything (OL-T19734)
    user can not access Integration Center page when has perm is No access       Full User - Edit Everything


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Hiring manager (OL-T19731)
    user can not access Integration Center page when has perm is No access       Hiring Manager


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Recruiter (OL-T19732)
    user can not access Integration Center page when has perm is No access       Recruiter


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Franchise Staff (OL-T19735)
    user can not access Integration Center page when has perm is No access       Franchise Staff


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Franchise Owner (OL-T19736)
    user can not access Integration Center page when has perm is No access       Franchise Owner


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Supervisor (OL-T19733)
    user can not access Integration Center page when has perm is No access       Supervisor


Check user has perm is No access to Integration Center page in case User has Leagcy role is: - Reporting User (OL-T19737)
    user can not access Integration Center page when has perm is No access       Reporting User


*** Keywords ***
cannot see the Integration Center page on the right menu
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Integration Center
    capture page screenshot

check user can view and action all tab on Integration Center page
    check span display      Integration Center
    check span display      Outbound Requests
    check span display      Inbound Requests
    check span display      Authentication Requests
    check span display      Global Values
    check span display      Audit Logs
    check span display      Mapped Values
    check span display      Authentications
    # Check user can Add new Filter at Audit Logs
    Click at    ${INTEGRATION_LEFT_TAB_NAV_TEXT}    Audit Logs
    Click at    ${AUDIT_TAB}    InBound
    Click at    ${AUDIT_ADD_FILTER_BUTTON}
    Click at    ${AUDIT_FILTER_NAME_SELECT}
    Click at    ${AUDIT_FILTER_NAME_OPTION}     Date and Time
    Click at    ${AUDIT_FILTER_SAVE_BUTTON}
    Verify text contain    ${AUDIT_FILTER_ITEM_LABEL}     Date and Time
    capture page screenshot
    Click at    ${AUDIT_FILTER_ITEM_DELETE_ICON}

check user can view and action only Audit Logs at Integration Center page
    check span display      Integration Center
    check span display      Audit Logs
    check element not display on screen      Outbound Requests
    check element not display on screen      Inbound Requests
    check element not display on screen      Authentication Requests
    check element not display on screen      Global Values
    check element not display on screen      Mapped Values
    check element not display on screen      Authentications
    # Check user can Add new Filter at Audit Logs
    Click at    ${INTEGRATION_LEFT_TAB_NAV_TEXT}    Audit Logs
    Click at    ${AUDIT_TAB}    InBound
    Click at    ${AUDIT_ADD_FILTER_BUTTON}
    Click at    ${AUDIT_FILTER_NAME_SELECT}
    Click at    ${AUDIT_FILTER_NAME_OPTION}     Date and Time
    Click at    ${AUDIT_FILTER_SAVE_BUTTON}
    Verify text contain    ${AUDIT_FILTER_ITEM_LABEL}     Date and Time
    capture page screenshot
    Click at    ${AUDIT_FILTER_ITEM_DELETE_ICON}

user can not access Integration Center page when has perm is No access
    [Arguments]     ${role_name}
    Given Setup test
    when Login into system with company    ${role_name}    ${COMPANY_FRANCHISE_ON}
    cannot see the Integration Center page on the right menu
    # Check navigate by URL
    ${is_correct_page} =    Run keyword and return status       Go to Integration Center page
    IF  '${is_correct_page}' == 'False'
        check element not display on screen      Integration Center
    END
    capture page screenshot
