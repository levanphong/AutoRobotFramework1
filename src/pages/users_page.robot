*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/users_locators.py

*** Keywords ***
Add a User
    [Arguments]    ${user_type}    ${user_name}=None    ${user_role}=None    ${product_access}=None
    IF    '${user_name}' == 'None'
        ${user_name} =    Set variable    ${user_type}
    END
    Go to Users page
    ${has_search} =     Run Keyword And Return Status    Check element display on screen     ${USERS_PAGE_SEARCH_USER_TEXT_BOX}
    IF     '${has_search}' == 'True'
        Simulate Input  ${USERS_PAGE_SEARCH_USER_TEXT_BOX}  ${user_name} Automation
        ${search_result}=   Run keyword and return status   Check element display on screen  ${user_name}
    ELSE
        ${search_result}=   Run keyword and return status   Check element display on screen  ${USER_NAME_IN_LIST}   ${user_name}
    END
    IF    '${search_result}' == 'False'
        Click at    ${OFFER_ADD_USER_BUTTON}
        Click at    ${USER_TYPE_VALUE}    ${user_type}
        Click at    ${CONFIRM_USER_TYPE_BUTTON}
        IF    '${user_role}' != 'None'
            Click at    ${USER_ROLE_DROPDOWN}    ${user_role}
        END
        IF    '${product_access}' != 'None'
            Select Product Access option    ${product_access}
        END
        Input into    ${USER_FIRST_NAME_TEXT_BOX}    ${user_name}
        Input into    ${USER_LAST_NAME_TEXT_BOX}    Automation
        Input into    ${USER_JOB_TEXT_BOX}    HR
        &{email_info} =    Get email for testing
        Input into    ${USER_EMAIL_TEXT_BOX}    ${email_info.email}
        Click at    ${SAVE_NEW_USER_BUTTON}
        wait with medium time
    END
    [Return]    ${user_name} Automation

Add View Permissions for User
    [Arguments]    ${user_name}
    Go to Users page
    Click by JS     ${USER_NAME_IN_LIST}    ${user_name}
    Click at    View Permissions
    ${is_new_user} =    Run Keyword And Return Status    Check element display on screen    Add Location
    IF    '${is_new_user}' == 'True'
        Click at    Add Location
        Click at    ${UNASSIGNED_LOCATION_OPTION}
        Click at    ${SELECT_ALL_OPTION}
        Click at    ${SAVE_VIEW_PERMISSIONS_BUTTON}
    ELSE
        Click at    View Locations
        Click at    ${EDIT_GROUP_TO_VIEW_ICON}
        Wait until element is visible    ${SELECT_ALL_OPTION}
        ${is_selected} =    Get value and format text  ${SELECT_ALL_OPTION_VALUE}
        IF  '${is_selected}' == 'false'
            Click At    ${SELECT_ALL_OPTION}
            Double Click at    ${SAVE_VIEW_PERMISSIONS_BUTTON}
            ${is_popup_closed} =      Run keyword and return status   Wait Until Element Is Not Visible  ${SAVE_VIEW_PERMISSIONS_BUTTON}
            IF  '${is_popup_closed}' == 'False'
                Double Click at    ${SAVE_VIEW_PERMISSIONS_BUTTON}
            END
        END
    END

Select Product Access option
    [Arguments]    ${product_access}=None
    Click at    ${PRODUCT_ACCESS_DROPDOWN}
    IF    '${product_access}' == 'All'
        Click at    ${PRODUCT_ACCESS_OPTION}    Student Experience Manager
    ELSE IF    '${product_access}' == 'Student Experience Manager'
        Click at    ${PRODUCT_ACCESS_OPTION}    Student Experience Manager
        Click at    ${PRODUCT_ACCESS_OPTION}    Candidate Experience Manager
    END
    Click at    ${PRODUCT_ACCESS_DROPDOWN}

Delete a user
    [Arguments]    ${user_name}
    Go to Users page
    Click by JS     ${USER_NAME_IN_LIST}    ${user_name}
    Click at    ${DELETE_USER_BUTTON}
    Click at    ${OK_BUTTON_POPUP}
    wait with medium time

Select user timezone
    [Arguments]    ${user_name}    ${timezone}
    Go to Users page
    Click by JS     ${USER_NAME_IN_LIST}    ${user_name}
    select from list by label    ${USER_TIMEZONE_DROPDOWN}    ${timezone}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_NEW_USER_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_NEW_USER_BUTTON}
    END
    wait for page load successfully

Add interview instructions for user
    [Arguments]     ${user_name}    ${type_interview}   ${text}
    Click by JS     ${USER_NAME_IN_LIST}    ${user_name}
    Click at    ${DEFAULT_INTERVIEW_INSTRUCTION_TAB}        ${type_interview}
    Input into    ${TEXT_INTERVIEW_INSTRUCTION_TEXTBOX}     ${text}
     ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_NEW_USER_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_NEW_USER_BUTTON}
    END
    wait for page load successfully

Delete OIT of user
    [Arguments]       ${user_name}
    Go to Users page
    ${has_search} =     Run Keyword And Return Status    Check element display on screen     ${USERS_PAGE_SEARCH_USER_TEXT_BOX}
    IF     '${has_search}' == 'True'
        input into      ${USERS_PAGE_SEARCH_USER_TEXT_BOX}      ${user_name}
        Capture page screenshot
        Click at    ${USER_NAME_STRONG_LOCATOR}
        check element display on screen     ${EDIT_AVAILABILITY_BUTTON}
        capture page screenshot
        Click at    ${EDIT_AVAILABILITY_BUTTON}
        check element display on screen    ${CLEAR_ALL_AVAILABILITY_BUTTON}
        capture page screenshot
        Click at    ${CLEAR_ALL_AVAILABILITY_BUTTON}
        Click at    ${CLEAR_ALL_BUTTON}
        capture page screenshot
    ELSE
        Click by JS     ${USER_NAME_IN_LIST}    ${user_name}
        Click at    ${USER_NAME_STRONG_LOCATOR}
        check element display on screen     ${EDIT_AVAILABILITY_BUTTON}
        capture page screenshot
        Click at    ${EDIT_AVAILABILITY_BUTTON}
        check element display on screen    ${CLEAR_ALL_AVAILABILITY_BUTTON}
        capture page screenshot
        Click at    ${CLEAR_ALL_AVAILABILITY_BUTTON}
        Click at    ${CLEAR_ALL_BUTTON}
        capture page screenshot
    END
    Click at    ${ICON_CLOSE_CLEAR_ALL_OIT_LOCATOR}
    capture page screenshot

Delete two users after created
    [Arguments]     ${user_role}        ${user_1}       ${user_2}
    go to CEM page
    switch to user      ${user_role}
    Delete a user       ${user_1}
    Delete a user       ${user_2}

Delete list users by first name
    [Arguments]     ${first_name}
    go to Users page
    ${list_users_by_first_name}=      format string   ${LIST_USER_NAME_STRONG_LOCATOR}    ${first_name}
    ${list_users_by_name}=      Get WebElements     ${list_users_by_first_name}
    ${length}=    Get length    ${list_users_by_name}
    FOR     ${index}    IN RANGE    ${length}
        Delete a user   ${first_name}
    END
