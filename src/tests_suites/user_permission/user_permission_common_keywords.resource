*** Settings ***
Resource    ../../drivers/driver_chrome.robot
Resource    ../../pages/users_roles_permissions_page.robot
Resource    ../../pages/all_candidates_page.robot

*** Variables ***
${test_location}        ${CONST_LOCATION}
${test_user_name}       ${EE_TEAM}
${test_user_role}       ${EDIT_EVERYTHING}
${test_user_job}        HR
${test_group_name}      No Group Assigned

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
    Click by JS  ${ADD_NEW_USER_LEGACY_ROLE_FIRST_VALUE}
    Click at  ${ADD_NEW_USER_ADD_BUTTON}

Check add new user with role 
    [Arguments]     ${user_role}    ${user_role_tab}=Active User
    Go to Users, Roles, Permissions page
    Click at  ${USERS_NAVIGATION_ROLE}  ${user_role}
    ${user_fname} =     Add a User  role=${user_role}
    Click at  ${USERS_NAVIGATION_ROLE}  ${user_role}
    Capture page screenshot
    Deactivate a User   ${user_fname}

Open user Availability edit widget
    [Arguments]     ${user_fname}
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${user_fname}
    Click at  ${USER_LIST_EDIT_AVAILABILITY_BUTTON}

Check save success after edited Availability
    Click at  ${AVAILABILITY_TIME_SELECT_SAVE_BUTTON}
    Check element display on screen  Your change has been saved.

Add new availability time and save
    [Arguments]     ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID}
    Capture page screenshot
    Check save success after edited Availability

Edit an availability time and save
    [Arguments]     ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABILITY_TIME_SELECT_EXISTED_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_START_TIME}
    Click at  ${AVAILABLE_TIME_POPUP_TIME_VALUE}    12:00am
    Capture page screenshot
    Check save success after edited Availability

Delete an availability time and save
    [Arguments]     ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABILITY_TIME_SELECT_EXISTED_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_DELETE_TIME_BUTTON}
    Capture page screenshot
    Check save success after edited Availability

Clear all availability time and save
    [Arguments]     ${user_fname}
    Open user Availability edit widget  ${user_fname}
    Click at  ${AVAILABLE_TIME_POPUP_CLEAR_ALL_BUTTON}
    Click at  ${CLEAR_ALL_AVAILABILITY_POPUP_CLEAR_BUTTON}
    Check number of element is correctly    ${AVAILABILITY_TIME_SELECT_EXISTED_TIME_GRID}   0
    Capture page screenshot
    Check save success after edited Availability

Cancel in Clear all availability time and save
    [Arguments]     ${user_fname}
    Open user Availability edit widget  ${user_fname}
    ${availability_time_number} =   Get Element Count    ${AVAILABILITY_TIME_SELECT_EXISTED_TIME_GRID}
    Click at  ${AVAILABLE_TIME_POPUP_CLEAR_ALL_BUTTON}
    Click at  ${CLEAR_ALL_AVAILABILITY_POPUP_CANCEL_BUTTON}
    Check number of element is correctly    ${AVAILABILITY_TIME_SELECT_EXISTED_TIME_GRID}   ${availability_time_number}
    Capture page screenshot
    Click at  ${AVAILABLE_TIME_POPUP_X_BUTTON}
