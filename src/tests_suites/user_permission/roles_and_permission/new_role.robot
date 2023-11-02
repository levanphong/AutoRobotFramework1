*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Job Boards: Client Setup > Hire > Jobs > Select Job Boards

*** Variables ***

*** Test Cases ***
Check Account Admin Role is set to Full access by default for Job Data Package page after mirgating the data (OL-T19136)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    Job Data Packages    Full Access


Check Account Admin Role is set to Full access by default for Job Template page after mirgating the data (OL-T19141)
    [Tags]  skip
    # Remove following Alec Webber's request
    # https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    Job Templates    Full Access


Check Account Admin Role is set to Full access by default for Jobs page after mirgating the data (OL-T19135)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    Jobs    Full Access


Check Account Admin Role is set to Full access by default for My Jobs page after mirgating the data (OL-T19140)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    My Jobs    Full Access


Check Account Admin Role is set to Full access by default for Talent Community page after mirgating the data (OL-T19142)
    [Tags]  skip
    # Talent Community not migrate yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    Talent Community    Full Access


Check Account Admin Role is set to No access by default for Candidate Volume Optimizer page after mirgating the data (OL-T19137)
    [Tags]  skip
    # Candidate Volume Optimizer not migrate yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    Candidate Volume Optimizer    No Access


Check Account Admin Role is set to No access by default for Job Boards page after mirgating the data (OL-T19139)
    [Tags]  skip
    # Remove following Alec Webber's request
    # https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Account Admin    Job Boards    No Access


Check All old User role is displayed after migrated the data (OL-T19157)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Click at  ${USERS_NAVIGATION_ROLE}  Roles and Permissions
    Scroll to a User role check Role exist  Recruiter
    Scroll to a User role check Role exist  Limited User
    Scroll to a User role check Role exist  Hiring Manager
    Scroll to a User role check Role exist  Franchise Staff
    Scroll to a User role check Role exist  Franchise Owners
    Scroll to a User role check Role exist  Full User - Edit Nothing
    Scroll to a User role check Role exist  Full User - Edit Everything
    Scroll to a User role check Role exist  Company Admin
    Capture page screenshot


Check Limited User role is set to No Access by default for Candidate Volume Optimizer page after mirgrating the data (OL-T19152)
    [Tags]  skip
    # Candidate Volume Optimizer not migrate yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    Candidate Volume Optimizer    No Access


Check Limited User role is set to No Access by default for Job Boards page after mirgrating the data (OL-T19153)
    [Tags]  skip
    # Remove following Alec Webber's request
    # https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    Job Boards    No Access


Check Limited User role is set to No Access by default for Job Data Package page after mirgrating the data (OL-T19151)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    Job Data Packages    No Access


Check Limited User role is set to No Access by default for Job Templates page after mirgrating the data (OL-T19155)
    [Tags]  skip
    # Remove following Alec Webber's request
    # https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    Job Templates    No Access


Check Limited User role is set to No Access by default for Jobs page after mirgrating the data (OL-T19150)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    Jobs    No Access


Check Limited User role is set to No Access by default for My Jobs page after mirgrating the data (OL-T19154)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    My Jobs    No Access


Check Limited User role is set to No Access by default for Talent Community page after mirgrating the data (OL-T19156)
    [Tags]  skip
    # Talent Community not migrate yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Limited User    Talent Community    No Access


Check Power User role is set to No Access by default for Candidate Volume Optimizer page after mirgating the data (OL-T19145)
    [Tags]  skip
    # Candidate Volume Optimizer not migrate yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    Candidate Volume Optimizer    No Access


Check Power User role is set to No Access by default for Job Boards page after mirgating the data (OL-T19146)
    [Tags]  skip
    # Remove following Alec Webber's request
    # https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    Job Boards    No Access


Check Power User role is set to No Access by default for Job Data Package page after mirgating the data (OL-T19144)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    Job Data Packages    No Access


Check Power User role is set to Full Access by default for Job Template page after mirgating the data (OL-T19148)
    [Tags]  skip
    # Remove following Alec Webber's request
    # https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    Job Templates    Full Access


Check Power User role is set to No Access by default for Jobs page after mirgating the data (OL-T19143)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    Jobs    No Access


Check Power User role is set to Full Access by default for My Jobs page after mirgating the data (OL-T19147)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    My Jobs    Full Access


Check Power User role is set to Full Access by default for Talent Community page after mirgating the data (OL-T19149)
    [Tags]  skip
    # Talent Community not migrate yet
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Verify page display in Right Menu and go to this page   Users, Roles and Permissions
    Check Parent Attribute with selected permission     Power User    Talent Community    Full Access

*** Keywords ***
Verify page display in Right Menu and go to this page
    [Arguments]     ${page_name}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_SETTING_ICON}
    Check element display on screen  ${CEM_PAGE_RIGHT_MENU_ITEM}  ${page_name}
    Capture page screenshot
    Click at  ${CEM_PAGE_RIGHT_MENU_ITEM}  ${page_name}

Check Children Attribute with selected permission
    [Arguments]     ${user_role}    ${parent_attr}     ${child_attr}     ${expected_permission}
    Navigate to User Role edit page  ${user_role}
    Click at    ${USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT}  ${parent_attr}
    Verify display text  ${USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT}  ${expected_permission}    ${child_attr}
    Capture page screenshot

Check Parent Attribute with selected permission
    [Arguments]     ${user_role}    ${parent_attr}     ${expected_permission}
    Navigate to User Role edit page  ${user_role}
    Click at    ${USER_ROLE_PERMISSION_SELECT}  ${parent_attr}
    Verify display text  ${EDIT_USER_ROLE_PERMISSION_ATTR_SELECTED_VALUE}  ${expected_permission}
    Capture page screenshot
