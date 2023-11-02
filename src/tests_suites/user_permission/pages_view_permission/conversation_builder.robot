*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/conversation_builder_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check user has perm full access to the Conversation Builder page (OL-T16922)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=Company Admin
    switch to user  ${user_fname}
    Go to CEM page
    user can access to the Conversation Builder page when has perm is Full access
    # Deactive user after check
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}


Check user has no perm access to the Conversation Builder page - Add Conversation - Edit Conversation (OL-T16923, OL-T16925, OL-T16927)
    [Tags]  skip
    # Conversation Builder can't not edit permission yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${role_name} =      Add a User role     legacy_role=Company Admin
    navigate to user role edit page     ${role_name}
    Set permission for corresponding role    Conversation Builder   No Access
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=${role_name}
    switch to user  ${user_fname}
    user cannot access to the Conversation Builder page when has perm is No access
    # Deactive user after check
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}
    # Delete user role, ignore error when it related with a CJ
    Run keyword and ignore error    Delete a User role    ${role_name}

Check user has perm full access to Add Conversation/ Edit conversation on the Conversation Builder page (OL-T16924, OL-T16926)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=Company Admin
    switch to user  ${user_fname}
    user can access to the Conversation Builder page when has perm is Full access
    ${conversation_name} =    Generate random name    Conversation_Test_
    user can access to add conversation       ${conversation_name}
    user can access to edit conversation      ${conversation_name}
    Delete conversation in builder
    # Deactive user after check
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}

*** Keywords ***
user can access to the Conversation Builder page when has perm is Full access
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element display on screen     ${MENU_SETTINGS_ITEM_LINK}      Conversation Builder
    capture page screenshot
    Click at    ${MENU_SETTINGS_ITEM_LINK}      Conversation Builder
    check element display on screen     ${CONVERSATION_TITLE}
    capture page screenshot

user cannot access to the Conversation Builder page when has perm is No access
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Conversation Builder
    capture page screenshot

user can access to add conversation
    [Arguments]     ${conversation_name}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    Go to conversation builder
    Check the conversation is added successfully    ${conversation_name}
    capture page screenshot

user can access to edit conversation
    [Arguments]     ${conversation_name}
    Go to conversation builder
    Search Conversation in Conversation Builder    ${conversation_name}
    Hover at    ${conversation_name}
    Click at    ${ECLIPSE_ICON}
    Click at    ${ECLIPSE_EDIT_BUTTON}
    check element display on screen     ${CONVERSATION_NAME_TEXTBOX}
    capture page screenshot
