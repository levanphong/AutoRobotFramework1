*** Settings ***
Resource            ../../../user_permission/user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${test_location}        auto_test_location
${test_user_job}        HR
${test_group_name}      No Group Assigned

*** Test Cases ***
Check Disable column User Name on For You of Table setting (OL-T16884)
    [Tags]    test
    Disable a column in For You tab    User Name


Check Disable column User Role on For You of Table setting (OL-T16885)
    [Tags]    test
    Disable a column in For You tab    User Role


Check Disable column Job title on For You of Table setting (OL-T16886)
    [Tags]    test
    Disable a column in For You tab    Job Title


Check Disable column Availability on For You of Table setting (OL-T16887)
    [Tags]    test
    Disable a column in For You tab    Availability


Check Disable column Group/Locations on For You of Table setting (OL-T16888)
    [Tags]    test
    Disable a column in For You tab    Group / Locations


Check Disable column Requisition Permissions on For You of Table setting (OL-T16889)
    [Tags]    test
    Disable a column in For You tab    Requisition Permissions


Check Disable column User Name on For All of Table setting (OL-T16890)
    [Tags]    test
    Disable a column in For All tab    User Name


Check Disable column User Role on For All of Table setting (OL-T16891)
    [Tags]    test
    Disable a column in For All tab    User Role


Check Disable column Job Title on For All of Table setting (OL-T16892)
    [Tags]    test
    Disable a column in For All tab    Job Title


Check Disable column Availability on For All of Table setting (OL-T16893)
    [Tags]    test
    Disable a column in For All tab    Availability


Check Disable column Group/Locations on For All of Table setting (OL-T16894)
    [Tags]    test
    Disable a column in For All tab    Group / Locations


Check Disable column Requisition Permissions on For All of Table setting (OL-T16895)
    [Tags]    test
    Disable a column in For All tab    Requisition Permissions

*** Keywords ***
Input Add new user form with missing value
    [Arguments]     ${fname}=Test   ${lname}=Test   ${job_title}=Test   ${email}=test@paradox.ai
    Click at  ${ADD_NEW_USER_BUTTON}
    Input into  ${ADD_NEW_USER_FNAME_TEXT_BOX}  ${fname}
    Input into  ${ADD_NEW_USER_LNAME_TEXT_BOX}  ${lname}
    Input into  ${ADD_NEW_USER_JOB_TITLE_TEXT_BOX}  ${job_title}
    Input into    ${ADD_NEW_USER_EMAIL_TEXT_BOX}    ${email}
    Click at  ${ADD_NEW_USER_COUNTRY_DROPDOWN}
    Click by JS  ${ADD_NEW_USER_COUNTRY_DROPDOWN_VALUE}  United States
    Click at  ${ADD_NEW_USER_ROLE_DROPDOWN}
    Click by JS  ${ADD_NEW_USER_ROLE_DROPDOWN_VALUE}  ${EDIT_EVERYTHING}
    Click at  ${ADD_NEW_USER_ADD_BUTTON}

Click on eye icon in Table Settings / For You tab
    [Arguments]     ${colum_name}
    Click at  ${USER_LIST_EDIT_TABLE_BUTTON}
    Click at  ${USER_TABLE_SETTINGS_VISIBILITY_ICON_ACTION}     ${colum_name}
    Capture page screenshot
    Click at  ${USER_TABLE_SETTINGS_SAVE_BUTTON}

Click on eye icon in Table Settings / For All tab
    [Arguments]     ${colum_name}
    Click at  ${USER_LIST_EDIT_TABLE_BUTTON}
    Click at  ${USER_TABLE_SETTINGS_FOR_ALL_TAB}
    Click at  ${USER_TABLE_SETTINGS_VISIBILITY_ICON_ACTION}     ${colum_name}
    Capture page screenshot
    Click at  ${USER_TABLE_SETTINGS_SAVE_BUTTON}
    Click at  ${USER_TABLE_SETTINGS_CONFIRM_CHANGES_BUTTON}

Disable a column in For You tab
    [Arguments]     ${colum_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click on eye icon in Table Settings / For You tab    ${colum_name}
    Check element not display on screen  ${USER_CELL_HEADER_VALUE}  ${colum_name}
    Capture page screenshot
    # Turn on column to previous status
    Click on eye icon in Table Settings / For You tab    ${colum_name}

Disable a column in For All tab
    [Arguments]     ${colum_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click on eye icon in Table Settings / For All tab    ${colum_name}
    Switch to user  ${EE_TEAM}
    Check element not display on screen  ${USER_CELL_HEADER_VALUE}  ${colum_name}
    Capture page screenshot
    # Turn on column to previous status
    Switch to user  ${TEAM_USER}
    Click on eye icon in Table Settings / For All tab    ${colum_name}
