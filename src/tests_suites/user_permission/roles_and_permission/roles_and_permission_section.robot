*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Variables           ../../../locators/client_setup_locators.py
Resource            ../../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco


*** Test Cases ***
Verify User page isn't displayed when Users, ser, Roles and Permission is displayed under Setting menu (OL-T19062, OL-T19063)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Cannot see Users under Setting menu when Users, Roles and Permissions is ON
    Can see User, Roles and Permission is displayed under Setting menu


Verify user can set Default user role (OL-T19064, OL-T19065, OL-T19066, OL-T19083)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Basic User
    Set as default role for corresponding role      ${role_name}
    Check tooltip is displayed at default user role     ${role_name}
    Go to Roles and Permissions page
    Click at    ${ROLES_ECLIPSE_ICON}    ${role_name}
    check element not display on screen     ${ROLES_ECLIPSE_MENU_DELETE_BUTTON}
    # Set default role for Limited User as default
    Set as default role for corresponding role      Limited User
    Check Set as default role checkbox is disabled       Limited User
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can cancel when setting Default user role (OL-T19067)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to User Role edit page     Basic User
    Cancel when Set as default role
    Check Set as default role checkbox is enable       Basic User


Verify User can create a user role (OL-T19069, OL-T19073)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    Go to Roles and Permissions page
    Scroll to a User role check Role exist    ${role_name}
    capture page screenshot
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify error message is displayed when add User role name duplicate (OL-T19070)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Roles and Permissions page
    Add a User role without step setting permission      legacy_role=${CP_ADMIN}      role_name=${CP_ADMIN}
    Check content error message when add new user roles     User Role Name or External ID is already existed.×


Verify Save button is disabled when until the fields User Role Name and Legacy User Role have values selected (OL-T19071)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Save button is disabled when until the fields User Role Name and Legacy User Role have values selected


Verify the error msg is displayed when adding External ID duplicate (OL-T19072)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${external_id} =    Generate Random String    6    [NUMBERS]
    ${role_name} =      Add a User role     legacy_role=Company Admin      externalID=${external_id}
    Go to Roles and Permissions page
    Scroll to a User role check Role exist    ${role_name}
    Add a User role without step setting permission      legacy_role=Company Admin      externalID=${external_id}
    Check content error message when add new user roles     User Role Name or External ID is already existed.×
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can edit a User role (OL-T19079)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Basic User
    Go to Roles and Permissions page
    ${edited_role_name}     ${legacy_role}      ${externalID} =      Edit a User role    ${role_name}    legacy_role=Company Admin
    Scroll to a User role check Role exist    ${edited_role_name}
    Navigate to User Role edit page     ${edited_role_name}
    Check user roles permission information is displayed correctly      ${edited_role_name}     ${legacy_role}      ${externalID}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can duplicating a User Role (OL-T19080)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role     System Attributes   Full Access
    Go to Roles and Permissions page
    Duplicate a User role   ${role_name}
    Verify display text    ${TOASTED_MESSAGE_SUCCESS}    ${role_name} was duplicated.×
    ${duplicate_role_name} =    Set Variable    Copy of ${role_name}
    Scroll to a User role check Role exist    ${duplicate_role_name}
    Navigate to User Role edit page     ${duplicate_role_name}
    Check duplicate user roles permission information is displayed correctly    ${duplicate_role_name}  Company Admin   System Attributes   Full Access
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can delele a user role (OL-T19081, OL-T19082)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    Go to Roles and Permissions page
    # Cancel when delete user role
    Cancel when Delete user role  ${role_name}
    capture page screenshot
    # Accept when delete user role
    Delete a User role   ${role_name}
    capture page screenshot
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can view a User role (OL-T19078)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${external_id} =    Generate Random String    6    [NUMBERS]
    ${role_name} =      Add a User role     legacy_role=Company Admin        externalID=${external_id}
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role   Users, Roles And Permissions   Full Access
    Go to Roles and Permissions page
    Navigate to User Role view page     ${role_name}
    Check element display on screen     ${VIEW_PAGE_USER_ROLES_TITLE}   ${role_name}
    Verify text contain     ${VIEW_PAGE_USER_ROLES_EXTERNAL_ID_VALUE}    ${external_id}
    capture page screenshot
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can assign permission for each product for user role they are creating - Full Access (OL-T19074)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role      Users, Roles And Permissions    Full Access
    Navigate to User Role edit page     ${role_name}
    Check feature level will be selected permissions by default     Users, Roles And Permissions    Full Access
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can assign permission for each product for user role they are creating - View Access (OL-T19074)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role       Users, Roles And Permissions    View Access
    Navigate to User Role edit page     ${role_name}
    Check feature level will be selected permissions by default     Users, Roles And Permissions    View Access
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify User can assign permission for each product for user role they are creating - No Access (OL-T19074)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role        Users, Roles And Permissions    No Access
    Navigate to User Role edit page     ${role_name}
    Check feature level will be selected permissions by default     Users, Roles And Permissions    No Access
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify the user change a product to permission (OL-T19075, OL-T19076, OL-T19077)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role         Users, Roles And Permissions    Full Access
    Navigate to User Role edit page     ${role_name}
    Check feature level will be selected permissions by default     Users, Roles And Permissions    Full Access
    Check status of list checkbox     Users, Roles And Permissions    View Access   enabled
    Check status of list checkbox     Users, Roles And Permissions    No Access   enabled
    # Update permission from Full Access to No Access
    Set permission for corresponding role      Users, Roles And Permissions    No Access
    # Check update permission from Full Access to No Access sucessfully
    Navigate to User Role edit page     ${role_name}
    Check feature level will be selected permissions by default     Users, Roles And Permissions    No Access
    Check status of list checkbox     Users, Roles And Permissions    Full Access   disabled
    Check status of list checkbox     Users, Roles And Permissions    View Access   disabled
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


Verify the role is assigned to users who had their user role deleted (OL-T19068)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    Go to Roles and Permissions page
    Delete a User role  ${role_name}
    Go to Users, Roles, Permissions page
    Click at   ${USERS_NAVIGATION_ROLE}     Limited User
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Check element display on screen  ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}


*** Keywords ***
Check turn on Users, Roles and Permissions toggle
    Go to Client setup page
    Click at    ${MORE_LABEL}
    Scroll to element   ${USERS_ROLES_AND_PERMISSION_TOGGLE}
    Turn on    ${USERS_ROLES_AND_PERMISSION_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END

Cannot see Users under Setting menu when Users, Roles and Permissions is ON
    Go to CEM page
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Users
    capture page screenshot

Can see User, Roles and Permission is displayed under Setting menu
    Go to CEM page
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element display on screen     ${CEM_PAGE_RIGHT_MENU_ITEM}      Users, Roles and Permissions
    capture page screenshot

Check tooltip is displayed at default user role
    [Arguments]  ${role_name}
    wait for page load successfully
    Scroll to a User role check Role exist   ${role_name}
    Scroll to element    ${role_name}
    Hover at    ${USER_ROLES_DEFAULT_LABEL}
    capture page screenshot
    Check element display on screen    This user role will serve as a catch all for all users who do not have a user role assigned.
    capture page screenshot

Check Set as default role checkbox is disabled
    [Arguments]     ${role_name}
    Navigate to User Role edit page     ${role_name}
    Verify element is disabled by checking class    ${SET_AS_DEFAULT_ROLE_CHECK_BOX}
    capture page screenshot

Check Set as default role checkbox is enable
    [Arguments]     ${role_name}
    Navigate to User Role edit page     ${role_name}
    element should be enabled    ${SET_AS_DEFAULT_ROLE_CHECK_BOX}
    capture page screenshot

Check content error message when add new user roles
    [Arguments]     ${content_err_msg}
    Verify display text    ${TOASTED_MESSAGE_ERROR}    ${content_err_msg}
    capture page screenshot

Check Save button is disabled when until the fields User Role Name and Legacy User Role have values selected
    Go to Roles and Permissions page
    Click at  ${ADD_NEW_USER_ROLE_BUTTON}
    element should be disabled      ${ADD_NEW_USER_ROLE_SAVE_BUTTON}
    capture page screenshot
    Input into  ${ADD_NEW_USER_ROLE_NAME_TEXT_BOX}  Basic User_Test
    Click at  ${ADD_NEW_USER_LEGACY_ROLE_DROPDOWN}
    Click at  ${ADD_NEW_USER_LEGACY_ROLE_VALUE}  Basic User
    element should be enabled      ${ADD_NEW_USER_ROLE_SAVE_BUTTON}
    capture page screenshot

Check user roles permission information is displayed correctly
    [Arguments]     ${role_name}     ${legacy_role}      ${externalID}
    Verify display text with get text value     ${EDIT_USER_ROLE_PERMISSION_NAME_TEXTBOX}     ${role_name}
    Verify display text with get text value     ${EDIT_USER_ROLE_PERMISSION_EXTERNAL_ID_TEXT_BOX}     ${externalID}
    Click at    ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_DROPDOWN}
    check element display on screen     ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_SELECTED_VALUE}     ${legacy_role}
    capture page screenshot

Check duplicate user roles permission information is displayed correctly
    [Arguments]     ${role_name}     ${legacy_role}      ${function_name}     ${permission}
    Verify display text with get text value     ${EDIT_USER_ROLE_PERMISSION_NAME_TEXTBOX}     ${role_name}
    Verify display text with get text value     ${EDIT_USER_ROLE_PERMISSION_EXTERNAL_ID_TEXT_BOX}     ${EMPTY}
    Click at    ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_DROPDOWN}
    check element display on screen     ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_SELECTED_VALUE}     ${legacy_role}
    Click at    ${USER_ROLE_PERMISSION_SELECT}  ${function_name}
    check element display on screen     ${PERMISSION_SELECTED_VALUE}    ${permission}
    capture page screenshot

Check feature level will be selected permissions by default
    [Arguments]     ${feature_name}     ${permission}
    Click at    ${USER_ROLE_PERMISSION_SELECT}  ${feature_name}
    check element display on screen     ${PERMISSION_SELECTED_VALUE}    ${permission}
    Click at        ${ICON_CARET_PARENT_FEATURE}    ${feature_name}
    wait with short time
    ${list_checkbox_elements} =    Create List
    IF    '${permission}' == 'Full Access'
        ${locator} =    format string    ${LIST_FULL_ACCESS_CHECKBOX}     ${feature_name}
        ${list_checkbox_elements} =    Get WebElements    ${locator}
    ELSE IF    '${permission}' == 'View Access'
        ${locator} =    format string    ${LIST_VIEW_ACCESS_CHECKBOX}     ${feature_name}
        ${list_checkbox_elements} =    Get WebElements    ${locator}
    ELSE IF    '${permission}' == 'No Access'
        ${locator} =    format string    ${LIST_NO_ACCESS_CHECKBOX}     ${feature_name}
        ${list_checkbox_elements} =    Get WebElements    ${locator}
    END
    FOR    ${element}    IN    @{list_checkbox_elements}
        checkbox should be selected     ${element}
    END
    capture page screenshot

Check status of list checkbox
    [Arguments]     ${feature_name}     ${permission}   ${status}
    ${list_checkbox_elements} =    Create List
    IF    '${permission}' == 'Full Access'
        ${locator} =    format string    ${LIST_FULL_ACCESS_CHECKBOX}     ${feature_name}
        ${list_checkbox_elements} =    Get WebElements    ${locator}
    ELSE IF    '${permission}' == 'View Access'
        ${locator} =    format string    ${LIST_VIEW_ACCESS_CHECKBOX}     ${feature_name}
        ${list_checkbox_elements} =    Get WebElements    ${locator}
    ELSE IF    '${permission}' == 'No Access'
        ${locator} =    format string    ${LIST_NO_ACCESS_CHECKBOX}     ${feature_name}
        ${list_checkbox_elements} =    Get WebElements    ${locator}
    END
    FOR    ${element}    IN    @{list_checkbox_elements}
        IF  '${status}' == 'disabled'
            Verify element is disable    ${element}
        ELSE IF     '${status}' == 'enabled'
            Verify element is enable    ${element}
        END
    END
    capture page screenshot

Add a User role without step setting permission
    [Arguments]     ${legacy_role}      ${role_name}=None       ${externalID}=None
    IF  '${role_name}' == 'None'
        ${role_name} =      Generate random name only text      ${legacy_role}_
    END
    IF  '${externalID}' == 'None'
        ${externalID} =    Generate Random String      5       [NUMBERS]
    END
    Go to Roles and Permissions page
    Click at  ${ADD_NEW_USER_ROLE_BUTTON}
    Check display of Add new user role modal
    Input into  ${ADD_NEW_USER_ROLE_NAME_TEXT_BOX}  ${role_name}
    Click at  ${ADD_NEW_USER_LEGACY_ROLE_DROPDOWN}
    Click at  ${ADD_NEW_USER_LEGACY_ROLE_VALUE}  ${legacy_role}
    Input into  ${ADD_NEW_USER_ROLE_EXTERNAL_ID_TEXT_BOX}  ${externalID}
    Click at    ${ADD_NEW_USER_ROLE_SAVE_BUTTON}
