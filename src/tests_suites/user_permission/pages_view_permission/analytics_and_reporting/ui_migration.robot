*** Settings ***
Resource            ./analytics_and_reporting.resource
Resource            ../../../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco    skip

*** Test Cases ***
Check Perm of all reports in the drawer list are auto selected to No Access/ Full Access after PA selected option No Access/ Full Access at Analytics And Reporting session (OL-T19494)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    #   Edit Nothing has No Access permission for Analytics And Reporting by default
    ${user_role_name} =   add a user role     Edit Nothing
    navigate to user role view page     ${user_role_name}
    check permission for product by role    Analytics And Reporting    No Access
    Navigate to User Role edit page      ${user_role_name}
    #   Cannot set permission for Analytics And Reporting, this field is disabled
    Set permission for corresponding role     Analytics And Reporting     Full Access
    Navigate to User Role edit page      ${user_role_name}
    Click at    ${USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT}   Analytics And Reporting
    Click at    ${USER_ROLE_FEATURE_TEXT}   Reports
    Check all features should be     No Access
    Click at    ${EDIT_ANALYTICS_AND_REPORTING_X_BUTTON}
    Set permission for corresponding role     Analytics And Reporting     Full Access
    Navigate to User Role edit page      ${user_role_name}
    Click at    ${USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT}   Analytics And Reporting
    Click at    ${USER_ROLE_FEATURE_TEXT}   Reports
    Check all features should be      Full Access
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${user_role_name}


Check UI at the Editing Analytics And Reporting perm sreen when creating a new role (OL-T19493)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${user_role_name} =   add a user role     Edit Nothing
    navigate to user role edit page     ${user_role_name}
    Click at    ${USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT}   Analytics And Reporting
    Wait for the element to fully load  ${USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT}  Reports
    verify text contain     ${USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT}  No Access   Reports
    verify text contain     ${USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT}  No Access   Dashboards
    Click at    ${USER_ROLE_FEATURE_TEXT}   Reports
    Check all features should be   No Access
    Click at    ${EDIT_ANALYTICS_AND_REPORTING_X_BUTTON}
    Click at    ${USER_ROLE_FEATURE_TEXT}   Dashboards
    Check all features should be       No Access
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${user_role_name}


UI Migration: Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page - Company Admin - Edit everything - Franchise Staff (Only check when Franchise ON) - Franchise Owner (Only check when Franchis) (OL-T19510)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page    Company Admin
    Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page    Franchise Owner
    Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page    Edit Everything
    Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page    Franchise Staff
    Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page    Reporting User


UI Migration: Check perm of user role when editing from full access to No access the Analytics and Reporting page- Company Admin - Edit everything - Franchise Staff (Franchise ON)- Franchise Owner (Franchise ON)- Reporting User(OL-T19509)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check perm of user role when editing from full access to No access the Analytics and Reporting page    Company Admin
    Check perm of user role when editing from full access to No access the Analytics and Reporting page    Franchise Owner
    Check perm of user role when editing from full access to No access the Analytics and Reporting page    Edit Everything
    Check perm of user role when editing from full access to No access the Analytics and Reporting page    Franchise Staff
    Check perm of user role when editing from full access to No access the Analytics and Reporting page    Reporting User


UI Migration: Check perm of user role when editing from No access to Full access the Analytics and Reporting page: Edit nothing Hiring manager Recruiter Supervisor (OL-T19508)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check perm of user role when editing from No access to Full access the Analytics and Reporting page     Hiring Manager
    Check perm of user role when editing from No access to Full access the Analytics and Reporting page     Edit Nothing
    Check perm of user role when editing from No access to Full access the Analytics and Reporting page     Recruiter
    Check perm of user role when editing from No access to Full access the Analytics and Reporting page     Supervisor


UI Migration: Check user role has default perm is full access to Analytics and Reporting page - Company Admin (OL-T19499)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Company Admin   Full Access


UI Migration: Check user role has default perm is full access to Analytics and Reporting page - Edit everything (OL-T19500)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Edit everything   Full Access


UI Migration: Check user role has default perm is full access to Analytics and Reporting page - Franchise Staff (Only check when Franchise ON) (OL-T19501)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Franchise Staff   Full Access


UI Migration: Check user role has default perm is full access to Analytics and Reporting page - Franchise Owner (Only check when Franchise ON) (OL-T19502)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Franchise Owner   Full Access


UI Migration: Check user role has default perm is full access to Analytics and Reporting page - Reporting User (OL-T19503)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Reporting User  Full Access


UI Migration: Check user role has default perm is No access to Analytics and Reporting page: Edit nothing (OL-T19504)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Edit nothing  Full Access
    Check user can not access analytics and reporting page with permission is No Access     EN Team


UI Migration: Check user role has default perm is No access to Analytics and Reporting page: Hiring manager (OL-T19505)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Hiring Manager  Full Access
    Check user can not access analytics and reporting page with permission is No Access     Hiring Team


UI Migration: Check user role has default perm is No access to Analytics and Reporting page: Recruiter (OL-T19506)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Recruiter  Full Access
    Check user can not access analytics and reporting page with permission is No Access     Recruiter Team


UI Migration: Check user role has default perm is No access to Analytics and Reporting page: Supervisor (OL-T19507)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    Check default permissions by user role to Analytics and Reporting page      Supervisor  Full Access
    Check user can not access analytics and reporting page with permission is No Access     Supervisor Team


Users, Roles and Permissions: Check search Report is correctly on the Analytics And Reporting session (OL-T19497, OL-T19498)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}     ${COMPANY_FRANCHISE_ON}
    navigate to user role edit page     Company Admin
    Click at    ${USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT}   Analytics And Reporting
    Click at    ${USER_ROLE_FEATURE_TEXT}   Reports
    Input into    ${EDIT_ANALYTICS_AND_REPORTING_SEARCH_REPORT_TEXTBOX}     Admin
    Check element display on screen     ${EDIT_ANALYTICS_AND_REPORTING_REPORT_NAME}     Admin
    capture page screenshot
    Clear element text with keys    ${EDIT_ANALYTICS_AND_REPORTING_SEARCH_REPORT_TEXTBOX}
    Input into    ${EDIT_ANALYTICS_AND_REPORTING_SEARCH_REPORT_TEXTBOX}     Handle
    Check element not display on screen     ${EDIT_ANALYTICS_AND_REPORTING_REPORT_NAME}     Handle
    capture page screenshot


*** Keywords ***
Check all sub-features in edit user role page should be
    Check sub-feature in edit user role page should be    Capture                       Full Access     7
    Check sub-feature in edit user role page should be    Candidate Care                Full Access     10
    Check sub-feature in edit user role page should be    Employee Care                 Full Access     9
    Check sub-feature in edit user role page should be    Scheduling                    Full Access     11
    Check sub-feature in edit user role page should be    Ratings                       Full Access     4
    Check sub-feature in edit user role page should be    Users                         Full Access     6
    Check sub-feature in edit user role page should be    Conversational Job Search     Full Access     6
    Check sub-feature in edit user role page should be    Hire                          Full Access     12
    Check sub-feature in edit user role page should be    Event                         Full Access     9
    Check sub-feature in edit user role page should be    Referrals                     Full Access     1
    Check sub-feature in edit user role page should be    Forms                         Full Access     3
    Check sub-feature in edit user role page should be    Workflow                      Full Access     2
    Check sub-feature in edit user role page should be    Admin                         Full Access     14
    Check sub-feature in edit user role page should be    Campaigns                     Full Access     2
    Check sub-feature in edit user role page should be    Conversations                 Full Access     1
    Check sub-feature in edit user role page should be    Assessments                   Full Access     1
    Check sub-feature in edit user role page should be    Learning                      Full Access     1

Check sub-feature in edit user role page should be
    [Arguments]     ${feature_name}     ${access_type}='Full Access'      ${amount}=0
    Click at    ${EDIT_ANALYTICS_AND_REPORTING_FEATURE_NAME}    ${feature_name}
    ${locator} =    format string   ${EDIT_ANALYTICS_AND_REPORTING_CHECKED_SUB_FEATURES}    ${feature_name}  ${access_type}
    ${total_sub_features} =   get element count   ${locator}
    should be equal as integers     ${total_sub_features}    ${amount}
    capture page screenshot
    Click at    ${EDIT_ANALYTICS_AND_REPORTING_FEATURE_NAME}    ${feature_name}

Check all sub-features in view user role page should be
    Check sub-feature in view user role page should be    Capture                       Full Access     7
    Check sub-feature in view user role page should be    Candidate Care                Full Access     10
    Check sub-feature in view user role page should be    Employee Care                 Full Access     9
    Check sub-feature in view user role page should be    Scheduling                    Full Access     11
    Check sub-feature in view user role page should be    Ratings                       Full Access     4
    Check sub-feature in view user role page should be    Users                         Full Access     6
    Check sub-feature in view user role page should be    Conversational Job Search     Full Access     6
    Check sub-feature in view user role page should be    Hire                          Full Access     12
    Check sub-feature in view user role page should be    Event                         Full Access     9
    Check sub-feature in view user role page should be    Referrals                     Full Access     1
    Check sub-feature in view user role page should be    Forms                         Full Access     3
    Check sub-feature in view user role page should be    Workflow                      Full Access     2
    Check sub-feature in view user role page should be    Admin                         Full Access     14
    Check sub-feature in view user role page should be    Campaigns                     Full Access     2
    Check sub-feature in view user role page should be    Conversations                 Full Access     1
    Check sub-feature in view user role page should be    Assessments                   Full Access     1
    Check sub-feature in view user role page should be    Learning                      Full Access     1

Check sub-feature in view user role page should be
    [Arguments]     ${feature_name}     ${access_type}='Full Access'      ${amount}=0
    Click at    ${VIEW_ANALYTICS_AND_REPORTING_FEATURE_NAME}    ${feature_name}
    IF  '${access_type}' == 'Full Access'
        ${index} =     set variable     2
    ELSE IF     '${access_type}' == 'No Access'
        ${index} =     set variable     3
    END
    ${locator} =    format string   ${VIEW_ANALYTICS_AND_REPORTING_CHECKED_SUB_FEATURES}    ${feature_name}  ${index}
    ${total_sub_features} =   get element count   ${locator}
    should be equal as integers     ${total_sub_features}    ${amount}
    capture page screenshot
    Click at    ${VIEW_ANALYTICS_AND_REPORTING_FEATURE_NAME}    ${feature_name}

Check all features should be
    [Arguments]     ${access_type}
    wait for page load successfully v1
    ${edit_feature_status} =     run keyword and return status    wait until element is visible   ${EDIT_ANALYTICS_AND_REPORTING_FEATURES}
    ${view_feature_status} =     run keyword and return status    wait until element is visible    ${VIEW_ANALYTICS_AND_REPORTING_FEATURES}
    IF  ${edit_feature_status}
        ${total_features} =   get element count   ${EDIT_ANALYTICS_AND_REPORTING_FEATURES}
        ${checked_locators} =  Format String    ${EDIT_ANALYTICS_AND_REPORTING_CHECKED_FEATURES}     ${access_type}
        ${total_checked} =   get element count   ${checked_locators}
        should be equal     ${total_features}     ${total_checked}
    ELSE IF     ${view_feature_status}
        IF  '${access_type}' == 'Full Access'
            ${index} =     set variable     2
        ELSE IF     '${access_type}' == 'No Access'
            ${index} =     set variable     3
        END
        ${total_features} =   get element count   ${VIEW_ANALYTICS_AND_REPORTING_FEATURES}
        ${checked_locators} =  Format String    ${VIEW_ANALYTICS_AND_REPORTING_CHECKED_FEATURES}     ${index}
        ${total_checked} =   get element count   ${checked_locators}
        should be equal     ${total_features}     ${total_checked}
    ELSE
        fail
    END
    capture page screenshot

Check perm of user role when editing from No access to Full access the Analytics and Reporting page
    [Arguments]     ${user_role}
    IF    '${user_role}' == 'Hiring Manager'
        ${user} =    set variable     Hiring Team
    ELSE IF    '${user_role}' == 'Edit Nothing'
        ${user} =    set variable     EN Team
    ELSE IF    '${user_role}' == 'Recruiter'
        ${user} =    set variable     Recruiter Team
    ELSE IF    '${user_role}' == 'Supervisor'
        ${user} =    set variable     Supervisor Team
    END
    ${analytics_reporting} =   set variable    Analytics And Reporting
    navigate to user role edit page     ${user_role}
    Verify role attribute       ${analytics_reporting}    No Access
    switch to user      ${user}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element display on screen     ${MENU_SETTINGS_ITEM_LINK}      ${analytics_reporting}
    Go to Analytics and Reporting page
    check element display on screen     ${LEFT_TAB_NAV_TEXT}     Reports
    capture page screenshot
    switch to user      ${TEAM_USER}

Check perm of user role when editing from full access to No access the Analytics and Reporting page
    [Arguments]     ${user_role}
    IF    '${user_role}' == 'Company Admin'
        ${user} =    set variable     CA Team
    ELSE IF    '${user_role}' == 'Edit Everything'
        ${user} =    set variable     EE Team
    ELSE IF    '${user_role}' == 'Franchise Owner'
        ${user} =    set variable     FO Team
    ELSE IF    '${user_role}' == 'Franchise Staff'
        ${user} =    set variable     FS Team
    ELSE IF    '${user_role}' == 'Reporting User'
        ${user} =    set variable     Reporting Team
    END
    ${analytics_reporting} =   set variable    Analytics And Reporting
    navigate to user role edit page     ${user_role}
    Verify role attribute       ${analytics_reporting}    Full Access
    Set permission for corresponding role     ${analytics_reporting}     No Access
    switch to user      ${user}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      ${analytics_reporting}
    capture page screenshot
    #   Set back to default
    switch to user  ${TEAM_USER}
    navigate to user role edit page     ${user_role}
    Set permission for corresponding role     ${analytics_reporting}     Full Access

Check perm of user role when editing from full access > No access > Full access the Analytics and Reporting page
    [Arguments]     ${user_role}
    IF    '${user_role}' == 'Company Admin'
        ${user} =    set variable     CA Team
    ELSE IF    '${user_role}' == 'Edit Everything'
        ${user} =    set variable     EE Team
    ELSE IF    '${user_role}' == 'Franchise Owner'
        ${user} =    set variable     FO Team
    ELSE IF    '${user_role}' == 'Franchise Staff'
        ${user} =    set variable     FS Team
    ELSE IF    '${user_role}' == 'Reporting User'
        ${user} =    set variable     Reporting Team
    END
    ${analytics_reporting} =   set variable    Analytics And Reporting
    navigate to user role edit page     ${user_role}
    Verify role attribute       ${analytics_reporting}    Full Access
    Set permission for corresponding role     ${analytics_reporting}     No Access
    switch to user      ${user}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      ${analytics_reporting}
    capture page screenshot
    switch to user  ${TEAM_USER}
    navigate to user role edit page     ${user_role}
    Set permission for corresponding role     ${analytics_reporting}     Full Access
    switch to user      ${user}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element display on screen     ${MENU_SETTINGS_ITEM_LINK}      ${analytics_reporting}
    capture page screenshot
    switch to user  ${TEAM_USER}

Check user can not access analytics and reporting page with permission is No Access
    [Arguments]     ${role_name}
    Go to CEM page
    switch to user      ${role_name}
    Click setting icon on menu
    Check element not display on screen     Analytics and Reporting
    capture page screenshot

Check default permissions by user role to Analytics and Reporting page
    [Arguments]     ${role_name}      ${access_option}
    navigate to user role edit page     ${role_name}
    Click at    ${USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT}   Analytics And Reporting
    verify text contain     ${USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT}       ${access_option}   Reports
    verify text contain     ${USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT}       ${access_option}   Dashboards
    #   Check access features on edit user role page
    Click at    ${USER_ROLE_FEATURE_TEXT}   Reports
    Check all features should be       ${access_option}
    Check all sub-features in edit user role page should be
    Click at    ${EDIT_ANALYTICS_AND_REPORTING_X_BUTTON}
    Click at    ${USER_ROLE_FEATURE_TEXT}   Dashboards
    Check all features should be       ${access_option}
    #   Check access features on view user role page
    navigate to user role view page     Company Admin
    click at    ${VIEW_PAGE_USER_ROLES_ATTRIBUTE_NAME}  Analytics And Reporting
    click at    ${VIEW_PAGE_USER_ROLES_ATTRIBUTE_NAME}  Dashboards
    Check all features should be       ${access_option}
    click at    ${VIEW_ANALYTICS_AND_REPORTING_FALLBACK_BUTTON}
    click at    ${VIEW_PAGE_USER_ROLES_ATTRIBUTE_NAME}  Reports
    Check all features should be       ${access_option}
    Check all sub-features in view user role page should be

