*** Settings ***
Resource            ./user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check the Availability section is displayed in Users, Roles and Permission (OL-T17035)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at  ${USER_LIST_EDIT_AVAILABILITY_BUTTON}
    Check element display on screen  Click and drag to create your weekly interview availability.
    Capture page screenshot


Check Paradox Admin user has permission to add new time in the Availability section (OL-T17036, OL-T17038, OL-T17040, OL-T17042, OL-T17044, OL-T17046, OL-T17048)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Add new availability time and save  ${user_fname}
    Edit an availability time and save  ${user_fname}
    Delete an availability time and save  ${user_fname}
    Cancel in Clear all availability time and save  ${user_fname}
    Clear all availability time and save  ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
    Click at  ${AVAILABILITY_CONFIRM_CHANGES_POPUP_NO_BUTTON}
    Open user Availability edit widget  ${user_fname}
    Capture page screenshot
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
    Click at  ${AVAILABILITY_CONFIRM_CHANGES_POPUP_YES_BUTTON}
    Check element display on screen  Your change has been saved.
    Capture page screenshot
    Deactivate a User   ${user_fname}


Check Power user role has permission to add new time in the Availability section (OL-T17037, OL-T17039, OL-T17041, OL-T17043, OL-T17045, OL-T17047, OL-T17049)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_NEW_ROLE}
    Switch to user  Power Team
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Add new availability time and save  ${user_fname}
    Edit an availability time and save  ${user_fname}
    Delete an availability time and save  ${user_fname}
    Cancel in Clear all availability time and save  ${user_fname}
    Clear all availability time and save  ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
    Click at  ${AVAILABILITY_CONFIRM_CHANGES_POPUP_NO_BUTTON}
    Open user Availability edit widget  ${user_fname}
    Capture page screenshot
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
    Click at  ${AVAILABILITY_CONFIRM_CHANGES_POPUP_YES_BUTTON}
    Check element display on screen  Your change has been saved.
    Capture page screenshot
    Deactivate a User   ${user_fname}
