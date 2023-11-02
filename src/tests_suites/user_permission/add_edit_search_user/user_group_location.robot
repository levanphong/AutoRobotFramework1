*** Settings ***
Resource            ../user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check Group/ Location tab display when clicking on Edit button (OL-T16873, OL-T16874)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Click at  ${USERS_NAVIGATION_ROLE}  Active User
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${USER_LIST_EDIT_GROUP_REQ_PERM}
    Double click at  ${USER_LIST_EDIT_GROUP_REQ_PERM}    slow_down=1s
    ${is_widget_displayed} =    Run keyword and return status   Check element display on screen  Location Permission
    Run keyword unless  ${is_widget_displayed}  Double click at  ${USER_LIST_EDIT_GROUP_REQ_PERM}    slow_down=1s
    Check element display on screen  Location Permissions
    Capture page screenshot
    Click at  ${JOB_LOCATION_PERM_X_BUTTON}
    Capture page screenshot
    Deactivate a User   ${user_fname}
