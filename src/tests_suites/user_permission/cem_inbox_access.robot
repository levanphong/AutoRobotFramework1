*** Settings ***
Resource            ./user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check if user belong to roles has CEM Inbox Access = ON (OL-T22623)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Add a test user
    Go to Users, Roles, Permissions page
    &{email_info} =    Get email for testing    is_spam_email=False
    ${email_address} =  Set variable    ${email_info.email}
    ${user_fname} =     Add a User  email_address=${email_address}
    # Deactivate User and then re-activate
    Deactivate a User   ${user_fname}
    Click at  ${USERS_NAVIGATION_ROLE}  Inactive Users
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${user_fname}
    Capture page screenshot
    Click at  ${USER_ECLIPSE_ICON}
    Capture page screenshot
    Click at  ${USER_ECLIPSE_MENU_ACTIVATE_BUTTON}
    Capture page screenshot
    Click at  ${ACTIVATE_USER_ACTIVATE_BUTTON}
    # Verify user received Re-activate email
    Verify user has received the email      Your account was reactivated    ${user_fname}


Check the toggle CEM Inbox access for Basic user role (OL-T22619, OL-T22621)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to User Role edit page     ${BASIC}
    Verify element is disabled by checking class    ${CEM_LOGIN_AND_INBOX_ACCESS_TOGGLE}
    Capture page screenshot
    # Change Legacy role to another role, CEM toggle should be enabled
    Click at  ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_DROPDOWN}
    Click at  ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_VALUE}    ${CP_ADMIN}
    Verify element is enabled by checking class    ${CEM_LOGIN_AND_INBOX_ACCESS_TOGGLE}
    Capture page screenshot
    # Change Legacy role back to Basic User, CEM toggle disabled again
    Click at  ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_DROPDOWN}
    Click at  ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_VALUE}    ${BASIC}
    Verify element is disabled by checking class    ${CEM_LOGIN_AND_INBOX_ACCESS_TOGGLE}
    Capture page screenshot


Check the toggle CEM Inbox access for non Basic user role (OL-T22620)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to User Role edit page     ${CP_ADMIN}
    Verify element is enabled by checking class    ${CEM_LOGIN_AND_INBOX_ACCESS_TOGGLE}
    Capture page screenshot


Check if user belong to roles has CEM Inbox Access = OFF and Legacy Role not Basic User (OL-T22622)
    [Tags]  skip
    # User still can login, confirming with Thanh Duong
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Add a User Role with CEM Access toggle OFF
    ${role_name} =      Add a User role     legacy_role=${CP_ADMIN}
    Navigate to User Role edit page     ${role_name}
    Click at  ${CEM_LOGIN_AND_INBOX_ACCESS_TOGGLE}
    Click at  ${USER_ROLE_SAVE_BUTTON}
    Go to Users, Roles, Permissions page
    # Create a User with created Role above
    &{email_info} =    Get email for testing    is_spam_email=False
    ${email_address} =  Set variable    ${email_info.email}
    ${user_name} =  Add a User  role=${role_name}   email_address=${email_address}
    logout from system by URL
    # Check User can't login to system
    Input Email    ${email_address}
    Click Next button
    Input password login page    1345
    Click login button
    Check element display on screen  Unable to log in with provided credentials.
    # Deactivate User
    Login into system   ${PARADOX_ADMIN}
    Go to Users, Roles, Permissions page
    Deactivate a User  ${user_name}
    # Re-activate User and check User not received any email
    Click at  ${USERS_NAVIGATION_ROLE}  Inactive Users
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Hover at  ${user_name}
    Capture page screenshot
    Click at  ${USER_ECLIPSE_ICON}
    Capture page screenshot
    Click at  ${USER_ECLIPSE_MENU_ACTIVATE_BUTTON}
    Capture page screenshot
    Click at  ${ACTIVATE_USER_ACTIVATE_BUTTON}
    ${is_has_email} =   Run keyword and return status   Verify user has received the email      Your account was reactivated    ${user_name}
    Should be equal as strings  ${is_has_email}    False
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}
