*** Settings ***
Resource            ../user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check search user by User Name, User Role, Job Title, invalid user (OL-T16879, OL-T16880, OL-T16881, OL-T16882)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to Users, Roles, Permissions page
    # Search by User Name
    Input into  ${SEARCH_USER_TEXT_BOX}  ${test_user_name}
    Check element display on screen  ${USER_CELL_VALUE}     ${test_user_name}
    Capture page screenshot
    # # Search by User Role
    Input into  ${SEARCH_USER_TEXT_BOX}  ${test_user_role}
    Check element display on screen  ${USER_CELL_VALUE}     ${test_user_role}
    Check element display on screen  ${USER_CELL_VALUE}     ${test_user_name}
    Capture page screenshot
    # Search by Job Title
    Input into  ${SEARCH_USER_TEXT_BOX}  ${test_user_job}
    Check element display on screen  ${USER_CELL_VALUE}     ${test_user_job}
    Check element display on screen  ${USER_CELL_VALUE}     ${test_user_name}
    Capture page screenshot
    # Search with not exist user
    Input into  ${SEARCH_USER_TEXT_BOX}  User not exist
    Check element display on screen  No users found.
    Capture page screenshot

Check default table setting (OL-T16883)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at  ${USER_LIST_EDIT_TABLE_BUTTON}
    Capture page screenshot
    Check number of element is correctly     ${USER_TABLE_SETTINGS_VISIBILITY_ICON}  6
    Click at  ${USER_TABLE_SETTINGS_FOR_ALL_TAB}
    Capture page screenshot
    Check number of element is correctly     ${USER_TABLE_SETTINGS_VISIBILITY_ICON}  6
