*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/users_roles_permissions_locators.py
Variables       ../locators/integration_center_locators.py

*** Keywords ***
Add a User
    [Arguments]     ${fname}=None    ${lname}=Test    ${role}=None    ${is_spam_email}=True    ${email_address}=None
    IF  '${fname}' == 'None'
        ${fname} =  Generate random name only text  Auto
    END
    Click at  ${ADD_NEW_USER_BUTTON}
    Add a Image to new User
    Input into  ${ADD_NEW_USER_FNAME_TEXT_BOX}  ${fname}
    Input into  ${ADD_NEW_USER_LNAME_TEXT_BOX}  ${lname}
    Input into  ${ADD_NEW_USER_JOB_TITLE_TEXT_BOX}  HR
    IF  '${email_address}' == 'None'
        &{email_info} =    Get email for testing    ${is_spam_email}
        ${email_address} =    Set variable     ${email_info.email}
    END
    Input into    ${ADD_NEW_USER_EMAIL_TEXT_BOX}    ${email_address}
    Click at  ${ADD_NEW_USER_COUNTRY_DROPDOWN}
    Click by JS  ${ADD_NEW_USER_COUNTRY_DROPDOWN_VALUE}  United States
    Click at  ${ADD_NEW_USER_ROLE_DROPDOWN}
    IF  '${role}' == 'None'
        Click by JS  ${ADD_NEW_USER_LEGACY_ROLE_FIRST_VALUE}
    ELSE
        Click by JS  ${ADD_NEW_USER_ROLE_DROPDOWN_VALUE}  ${role}
    END
    Click at  ${ADD_NEW_USER_ADD_BUTTON}
    [Return]    ${fname}

Deactivate a User
    [Arguments]     ${user_name}
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    ${is_user_display} =    Run Keyword And Return Status    Check element display on screen    ${user_name}
    Run Keyword Unless    ${is_user_display}    Reload Page
    Run Keyword Unless    ${is_user_display}    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Hover at  ${user_name}
    ${is_clicked} =     Run keyword and return status    Click at  ${USER_ECLIPSE_ICON}
    IF  '${is_clicked}' == 'False'
        Hover at  ${user_name}
        Click at  ${USER_ECLIPSE_ICON}
    END
    Click at  ${USER_ECLIPSE_MENU_DEACTIVATE_BUTTON}
    Click at  ${DEACTIVATE_USER_DEACTIVATE_BUTTON}
    Check element not display on screen    ${user_name}
    Click at   ${USERS_NAVIGATION_ROLE}     Inactive User
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Check element display on screen  ${user_name}

Add a Image to new User
    ${path_image} =    get_path_upload_image_path    cat-kute
    ${element} =    Get Webelement    ${ADD_NEW_USER_CROP_AVATAR}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('class', '');
    ...    ARGUMENTS    ${element}
    Input into    ${ADD_NEW_USER_CROP_AVATAR}    ${path_image}
    Click at  ${ADD_NEW_USER_CROP_AVATAR_CONFIRM_BUTTON}

# Common keywords for Roles and Permission

Set permission for corresponding role
    [Arguments]      ${function_name}     ${permission}
    ${locator} =    format string   ${USER_ROLE_PERMISSION_SELECT}    ${function_name}
    ${value} =     Get Element Attribute   ${locator}      disabled
    IF  '${value}' != 'true'
        Click at    ${USER_ROLE_PERMISSION_SELECT}  ${function_name}
        IF    '${permission}' == 'Full Access'
            Click at    ${FULL_ACCESS_OPTION}
        ELSE IF    '${permission}' == 'View Access'
            Click at    ${VIEW_ACCESS_OPTION}
        ELSE IF    '${permission}' == 'No Access'
            Click at    ${NO_ACCESS_OPTION}
        END
        Click at    ${USER_ROLE_SAVE_BUTTON}
    ELSE
        log     Cannot change permission for this one
        scroll element into view       ${locator}
    END
    capture page screenshot

Add a User role
    [Arguments]     ${legacy_role}      ${role_name}=None       ${externalID}=None      ${impersonation_options}=Only this Role
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
    ${is_toggle_on} =    Run Keyword And Return Status      Check toggle is On     ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_TOGGLE}
    IF  '${is_toggle_on}' == 'False'
        Turn on     ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_TOGGLE}
    END
    Click at    ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_DROPDOWN}
    Click at    ${ADD_NEW_USER_ROLE_USER_IMPERSONATION_OPTIONS}     ${impersonation_options}
    IF  '${legacy_role}' == 'Company Admin'
        Set permission for feature base on role Account Admin
    ELSE
        Set permission for feature base on role Limited User
    END
    ${is_changed} =    Run Keyword And Return Status    wait element clickable    ${USER_ROLE_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${USER_ROLE_SAVE_BUTTON}
    END
    [Return]    ${role_name}

Scroll to a User role check Role exist
    [Arguments]     ${role_name}
    Scroll to bottom of table   ${ROLES_AND_PERMISSION_LIST}   ${LOADING_ICON_3}
    ${is_role_display} =    Run keyword and return status   Check element display on screen  ${USER_ROLES_NAME_LABEL}  ${role_name}
    Capture page screenshot
    IF  not ${is_role_display}
        Scroll to bottom of table   ${ROLES_AND_PERMISSION_LIST}   ${LOADING_ICON_3}
    END
    Capture page screenshot

Delete a User role
    [Arguments]     ${role_name}
    Go to Roles and Permissions page
    Scroll to a User role check Role exist  ${role_name}
    # Open Eclipse menu
    Click at    ${ROLES_ECLIPSE_ICON}    ${role_name}
    Click at    ${ROLES_ECLIPSE_MENU_DELETE_BUTTON}
    Check content of Delete user role pop-up    ${role_name}
    Click at    ${ROLES_ECLIPSE_MENU_DELETE_CONFIRM_BUTTON}
    Check element not display on screen    ${USER_ROLES_NAME_LABEL}     ${role_name}

Navigate to User Role edit page
    [Arguments]     ${role_name}
    Go to Roles and Permissions page
    Scroll to a User role check Role exist  ${role_name}
    # Open Eclipse menu
    Click at    ${ROLES_ECLIPSE_ICON}   ${role_name}
    Click at    ${ROLES_ECLIPSE_MENU_EDIT_BUTTON}

Check content of Set as default role pop-up
    [Arguments]     ${role_name}
    Check element display on screen     ${SET_AS_DEFAULT_ROLE_CONFIRM_BUTTON}
    Check element display on screen     ${SET_AS_DEFAULT_ROLE_CANCEL_BUTTON}
    Verify display text    ${SET_AS_DEFAULT_ROLE_CONTENT_TEXT}    Are you sure you want to set ${role_name} as the default role? This role will be a catch all for any user that does not have a role assigned.
    capture page screenshot

Check display of Add new user role modal
    Wait for the element to fully load    ${ADD_NEW_USER_ROLE_NAME_TEXT_BOX}
    check element display on screen     ${ADD_NEW_USER_ROLE_NAME_TEXT_BOX}
    check element display on screen     ${ADD_NEW_USER_LEGACY_ROLE_DROPDOWN}
    check element display on screen     ${ADD_NEW_USER_ROLE_EXTERNAL_ID_TEXT_BOX}
    check element display on screen     ${ADD_NEW_USER_ROLE_SAVE_BUTTON}
    Verify display text    ${ADD_NEW_USER_ROLE_INFO_TEXT}    For products that have not been migrated, the Legacy User Role will be used to inherit permissions for this user role.
    capture page screenshot

Accept when Set as default role
    [Arguments]     ${role_name}
    ${is_defaulted} =    Run Keyword And Return Status    element should be disabled    ${SET_AS_DEFAULT_ROLE_CHECK_BOX}
    IF  '${is_defaulted}' == 'False'
        Click by JS   ${SET_AS_DEFAULT_ROLE_CHECK_BOX}
        Click at   ${USER_ROLE_SAVE_BUTTON}
        Check content of Set as default role pop-up    ${role_name}
        Click at   ${SET_AS_DEFAULT_ROLE_CONFIRM_BUTTON}
    END

Cancel when Set as default role
    ${is_defaulted} =    Run Keyword And Return Status    element should be disabled    ${SET_AS_DEFAULT_ROLE_CHECK_BOX}
    IF  '${is_defaulted}' == 'False'
        Click by JS   ${SET_AS_DEFAULT_ROLE_CHECK_BOX}
        Click at   ${USER_ROLE_SAVE_BUTTON}
        Click at   ${SET_AS_DEFAULT_ROLE_CANCEL_BUTTON}
    END

Set as default role for corresponding role
    [Arguments]     ${role_name}
    Navigate to User Role edit page     ${role_name}
    Accept when Set as default role      ${role_name}

Edit a User role
    [Arguments]     ${role_name}     ${legacy_role}      ${edited_role_name}=None       ${externalID}=None
    IF  '${edited_role_name}' == 'None'
        ${edited_role_name} =      Generate random name only text      ${legacy_role}_
    END
    IF  '${externalID}' == 'None'
        ${externalID} =    Generate Random String      5       [NUMBERS]
    END
    Navigate to User Role edit page     ${role_name}
    Click at   ${EDIT_USER_ROLE_PERMISSION_ICON_EDIT_NAME}
    Input into  ${EDIT_USER_ROLE_PERMISSION_NAME_TEXTBOX}   ${edited_role_name}
    Click at  ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_DROPDOWN}
    Click at  ${EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_VALUE}  ${legacy_role}
    Input into  ${EDIT_USER_ROLE_PERMISSION_EXTERNAL_ID_TEXT_BOX}   ${externalID}
    Click at    ${USER_ROLE_SAVE_BUTTON}
    [Return]    ${edited_role_name}     ${legacy_role}      ${externalID}

Duplicate a User role
    [Arguments]     ${role_name}
    Scroll to a User role check Role exist  ${role_name}
    Click at    ${ROLES_ECLIPSE_ICON}    ${role_name}
    Click at    ${ROLES_ECLIPSE_MENU_DUPLICATE_BUTTON}

Check content of Delete user role pop-up
    [Arguments]     ${role_name}
    Check element display on screen     ${ROLES_ECLIPSE_MENU_DELETE_CONFIRM_BUTTON}
    Check element display on screen     ${ROLES_ECLIPSE_MENU_DELETE_CANCEL_BUTTON}
    ${user_assigned} =      Get text and format text    ${USER_ASSIGNED_LABEL}      ${role_name}
    IF  '${user_assigned}' == '0 users assigned'
        Verify display text    ${DELETE_USER_ROLE_CONTENT_TEXT}    Are you sure you want to delete the user role ${role_name}?
    ELSE
        Verify text contain    ${DELETE_USER_ROLE_CONTENT_TEXT}    Are you sure you want to delete the user role ${role_name}? ${user_assigned} to this role will be assigned the default role
    END

Cancel when Delete user role
    [Arguments]     ${role_name}
    Scroll to a User role check Role exist  ${role_name}
    Click at    ${ROLES_ECLIPSE_ICON}    ${role_name}
    Click at    ${ROLES_ECLIPSE_MENU_DELETE_BUTTON}
    Click at    ${ROLES_ECLIPSE_MENU_DELETE_CANCEL_BUTTON}
    Scroll to a User role check Role exist     ${role_name}

Navigate to User Role view page
    [Arguments]     ${role_name}
    Go to Roles and Permissions page
    Scroll to a User role check Role exist  ${role_name}
    Click at    ${ROLES_ECLIPSE_ICON}    ${role_name}
    Click at    ${ROLES_ECLIPSE_MENU_VIEW_BUTTON}

Verify role attribute
    [Arguments]     ${function_name}    ${expected}
    Click at    ${USER_ROLE_PERMISSION_SELECT}  ${function_name}
    check element display on screen     ${PERMISSION_SELECTED_VALUE}    ${expected}

Set permission for corresponding feature
    [Arguments]     ${function_name}    ${permission}
    ${locator} =    format string   ${USER_ROLE_PERMISSION_SELECT}    ${function_name}
    ${value} =     Get Element Attribute   ${locator}      disabled
    IF  '${value}' != 'true'
        Click at    ${USER_ROLE_PERMISSION_SELECT}  ${function_name}
        IF    '${permission}' == 'Full Access'
            Click at    ${FULL_ACCESS_OPTION}
        ELSE IF    '${permission}' == 'View Access'
            Click at    ${VIEW_ACCESS_OPTION}
        ELSE IF    '${permission}' == 'No Access'
            Click at    ${NO_ACCESS_OPTION}
        END
    END

Set permission for feature base on role Account Admin
# New update for list of permissions can setting
# https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Set permission for corresponding feature    Campaigns   Full Access
    Set permission for corresponding feature    Users, Roles And Permissions   Full Access
    Set permission for corresponding feature    Jobs   Full Access
    Set permission for corresponding feature    Job Data Packages   Full Access
    Set permission for corresponding feature    Group Management   Full Access
    Set permission for corresponding feature    Microlearning   Full Access
    Set permission for corresponding feature    Conversation Builder   Full Access
    Set permission for corresponding feature    Phone Numbers   Full Access
    Set permission for corresponding feature    Alert Management   Full Access
    Set permission for corresponding feature    Assistant Messaging   No Access
    Set permission for corresponding feature    Events   Full Access
    Set permission for corresponding feature    Campus   Full Access
    Set permission for corresponding feature    User Feedback   No Access
    Set permission for corresponding feature    Ratings   Full Access
    Set permission for corresponding feature    Integration Center   Full Access
    Set permission for corresponding feature    My Jobs   Full Access
    Set permission for corresponding feature    Scheduling   Full Access
    Set permission for corresponding feature    Forms   Full Access
    Set permission for corresponding feature    Offers   Full Access
    Set permission for corresponding feature    Candidate Journeys   Full Access
    Set permission for corresponding feature    Candidate Summary Builder   Full Access
    Set permission for corresponding feature    Candidate Management   Full Access
    Set permission for corresponding feature    Content Management System   Full Access
    Set permission for corresponding feature    Experience Management   No Access
    Set permission for corresponding feature    Talent Community   Full Access
    Set permission for corresponding feature    Web Management   Full Access
    Set permission for corresponding feature    Suggestions   Full Access
    Set permission for corresponding feature    System Attributes   No Access
    Set permission for corresponding feature    Analytics And Reporting   Full Access
    Set permission for corresponding feature    Applicant Flows   No Access
    Set permission for corresponding feature    Integration Center   Full Access
    Set permission for corresponding feature    My Profile   Full Access
    Set permission for corresponding feature    Location Management   Full Access

Set permission for feature base on role Limited User
# New update for list of permissions can setting
# https://paradoxai.atlassian.net/wiki/spaces/~349576386/pages/2256011787/List+of+Products+Features+-+Engineering+Review
    Set permission for corresponding feature    Campaigns   No Access
    Set permission for corresponding feature    Users, Roles And Permissions   No Access
    Set permission for corresponding feature    Jobs   No Access
    Set permission for corresponding feature    Job Data Packages   No Access
    Set permission for corresponding feature    Group Management   No Access
    Set permission for corresponding feature    Microlearning   No Access
    Set permission for corresponding feature    Conversation Builder   No Access
    Set permission for corresponding feature    Phone Numbers   No Access
    Set permission for corresponding feature    Alert Management   No Access
    Set permission for corresponding feature    Assistant Messaging   No Access
    Set permission for corresponding feature    Events   No Access
    Set permission for corresponding feature    Campus   No Access
    Set permission for corresponding feature    User Feedback   No Access
    Set permission for corresponding feature    Ratings   No Access
    Set permission for corresponding feature    Integration Center   No Access
    Set permission for corresponding feature    My Jobs   No Access
    Set permission for corresponding feature    Scheduling   No Access
    Set permission for corresponding feature    Forms   No Access
    Set permission for corresponding feature    Offers   No Access
    Set permission for corresponding feature    Candidate Journeys   No Access
    Set permission for corresponding feature    Candidate Summary Builder   No Access
    Set permission for corresponding feature    Candidate Management   No Access
    Set permission for corresponding feature    Content Management System   No Access
    Set permission for corresponding feature    Experience Management   No Access
    Set permission for corresponding feature    Talent Community   No Access
    Set permission for corresponding feature    Web Management   No Access
    Set permission for corresponding feature    Suggestions   No Access
    Set permission for corresponding feature    System Attributes   No Access
    Set permission for corresponding feature    Analytics And Reporting   No Access
    Set permission for corresponding feature    Applicant Flows   No Access
    Set permission for corresponding feature    Integration Center   No Access
    Set permission for corresponding feature    My Profile   No Access
    Set permission for corresponding feature    Location Management   No Access

Check permission for product by role
    [Arguments]     ${product_name}     ${access_option}
    IF      '${access_option}' == 'Full Access'
        ${index} =  set variable    1
    ELSE IF     '${access_option}' == 'View Access'
        ${index} =  set variable    2
    ELSE IF     '${access_option}' == 'No Access'
        ${index} =  set variable    3
    END
    scroll to element   ${VIEW_PAGE_USER_ROLES_ATTRIBUTE_NAME}     ${product_name}
    ${access_icon} =    Get attribute and format text   class   ${VIEW_PAGE_USER_ROLES_ACCESS_ICON}     ${product_name}     ${index}
    Should contain     ${access_icon}   icon-check-circle-outlined      Current access is not ${access_option}
    capture page screenshot

Check permission for feature by role
    [Arguments]     ${feature_name}     ${access_option}
    IF      '${access_option}' == 'Full Access'
        ${index} =  set variable    1
    ELSE IF     '${access_option}' == 'No Access'
        ${index} =  set variable    2
    END
    scroll to element   ${VIEW_PAGE_USER_ROLES_ATTRIBUTE_NAME}     ${feature_name}
    ${access_icon} =    Get attribute and format text   class   ${VIEW_PAGE_USER_ROLES_ACCESS_ICON}     ${feature_name}     ${index}
    Should contain     ${access_icon}   icon-check-circle-outlined      Current access is not ${access_option}
    capture page screenshot

Select timezone by user
    [Arguments]     ${user_name}    ${timezone_option}
    Go to Users, Roles, Permissions page
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Hover at  ${user_name}
    ${is_clicked} =     Run keyword and return status    Click at  ${USER_ECLIPSE_ICON}
    IF  '${is_clicked}' == 'False'
        Hover at  ${user_name}
        Click at  ${USER_ECLIPSE_ICON}
    END
    Click at    ${USER_ECLIPSE_MENU_EDIT_BUTTON}
    Click at    ${USER_DETAIL_EDIT_FORM_TIMEZONE_DROPDOWN}
    Input into      ${USER_DETAIL_EDIT_FORM_TIMEZONE_SEARCH_TIMEZONE_TEXTBOX}     ${timezone_option}
    Click by JS     ${USER_DETAIL_EDIT_FORM_TIMEZONE_DROPDOWN_OPTIONS}      ${timezone_option}
    Click at    ${USER_DETAIL_EDIT_FORM_SAVE_BUTTON}
    Click at    ${UPDATE_USER_DETAILS_POPUP_CONFIRM_BUTTON}

Delete OIT of user
    [Arguments]     ${user_name}
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Hover at  ${EDIT_OIT_USER_BUTTON}
    Click at    ${ICON_EDIT_OIT_USER}   ${user_name}
    Click at    ${CLEAR_ALL_AVAILABILITY_MODAL_CLEAR_BUTTON}
    Click at    ${CLEAR_ALL_AVAILABILITY_POPUP_CLEAR_BUTTON}
    Click at    ${AVAILABILITY_TIME_SELECT_SAVE_BUTTON}

Active one group interview OIT of user
    [Arguments]    ${user_name}
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Click at    ${ICON_EDIT_OIT_USER}   ${user_name}
    Click at    ${EDIT_OIT_PATTERN_BLOCK_OIT}    1
    Click at    ${EDIT_OIT_SCHEDULE_TYPE_BUTTON}
    Click at    ${EDIT_OIT_PATTERN_SCHEDULE_TYPE_RADIO}    Group interviews
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${AVAILABILITY_TIME_SELECT_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${AVAILABILITY_TIME_SELECT_SAVE_BUTTON}

Deactivate two Users
    [Arguments]     ${first_name_1}    ${first_name_2}
    Go to CEM page
    switch to user  ${CA_TEAM}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${first_name_1}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${first_name_2}

Add View Permissions for User
    [Arguments]    ${user_name}
    Go to Users, Roles, Permissions page
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_name}
    Hover at  ${USER_LIST_EDIT_GROUP_REQ_PERM}
    Double click at  ${USER_LIST_EDIT_GROUP_REQ_PERM}
    ${is_widget_displayed} =    Run keyword and return status   Check element display on screen  Location Permission
    Run keyword unless  ${is_widget_displayed}  Double click at  ${USER_LIST_EDIT_GROUP_REQ_PERM}
    ${is_new_user} =    Run Keyword And Return Status    Check element display on screen    Add Location
    IF    '${is_new_user}' == 'True'
        Click at    Add Location
        Click at    ${UNASSIGNED_LOCATION_OPTION}
        Click at    ${SELECT_ALL_OPTION}
        Click at    ${SAVE_VIEW_PERMISSIONS_BUTTON}
    ELSE
        Click at    View Locations
        Click at    ${LOCATION_PERM_GROUPS_EDIT_BUTTON}
        Double click At    ${LOCATION_PERM_GROUPS_SELECT_ALL_CHECKBOX}
        ${is_changed} =   Run keyword and return status   Verify element is enabled by checking class    ${LOCATION_PERM_GROUPS_SAVE_BUTTON}
        Run keyword if  ${is_changed}   Click at    ${LOCATION_PERM_GROUPS_SAVE_BUTTON}
    END

Is User Existence On Active
    [Arguments]    ${user_name}
    Go To Users, Roles, Permissions Page
    Input into    ${SEARCH_USER_TEXT_BOX}   ${user_name}
    ${is_existence} =   Run Keyword And Return Status   Element Should Not Be Visible   ${EMPTY_USER_TITLE}
    [Return]    ${is_existence}

Get all user name with type
    [Arguments]    ${type}=All Active Users
    Go to Users, Roles, Permissions page
    Click at    ${type}
    ${list_user}=    Get elements and convert to list    ${ALL_USER_NAME}
    [Return]    ${list_user}

Open requisition base permissions dialog
    [Arguments]    ${user_name}
    ${locator} =    Format String    ${USER_LIST_EDIT_BUTTON}    ${user_name}     Requisition Permissions
    Input Text     ${SEARCH_USER_TEXT_BOX}    ${user_name}
    wait for page load successfully v1
    hover at    ${locator}
    click at    ${locator}     slow_down=2s
    ${dialog_show} =     Run keyword and return status    Check element display on screen   ${REQ_BASED_PERM_DIALOG}    wait_time=5s
    IF  not ${dialog_show}
        Hover at  ${locator}
        Click at  ${locator}
    END
    wait_for_loading_icon_disappear
