*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/group_management_locators.py

*** Keywords ***
Add a Group
    [Arguments]    ${journey_name}=None    ${conversation_name}=None    ${group_name}=None
    Go to Group Management page
    Click at    ${NEW_GROUP_BUTTON}
    # Group Details Section
    ${group_name} =    Set Group Details      ${group_name}
    # Candidate Journey Section
    IF  '${journey_name}' != 'None'
        Click at    ${JOURNEY_SELECTION_DROPDOWN}
        ${journey_name_locator} =    Format String    ${JOURNEY_SELECT_VALUE}    ${journey_name}
        Click at    ${journey_name_locator}
        Set Group Scheduling
        Click by JS    ${GROUP_SAVE_CANDIDATE_JOURNEY}
    END
    IF  '${conversation_name}' != 'None'
        Set Group Conversation    ${conversation_name}
        Click by JS    ${SAVE_NEW_GROUP_BUTTON}
    END
    Wait with short time
    [Return]    ${group_name}

Set Group Details
    [Arguments]     ${group_name_random}=None   ${is_edit}=False
    IF    '${group_name_random}' == 'None'
        ${group_name_random} =    Generate random name    auto_group
    END
    Click at    ${GROUP_NAME_TITLE}
    IF  '${is_edit}' == 'False'
        Simulate Input  None  ${group_name_random}
    ELSE
        Simulate Input  ${GROUP_NAME_TITLE}  ${group_name_random}
    END
    Click at    ${EXTERNAL_ID_TEXT_BOX}
    Click at    ${SAVE_GROUP_DETAILS_BUTTON}
    [Return]    ${group_name_random}

Set Group Scheduling
    Click at    ${GROUP_SCHEDULING_INTERVIEW_TYPE_DROPDOWN}
    Click at    ${MANUALLY_SCHEDULE_TYPE}

Set Group Conversation
    [Arguments]    ${conversation_name}
    Click by JS    ${CONVERSATION_SELECTION_DROPDOWN}
    Run keyword and ignore error    Input into    ${CONVERSATION_SELECTION_SEARCH_TEXT_BOX}    ${conversation_name}
    Click at    ${JOURNEY_SELECT_VALUE}    ${conversation_name}

Delete a Group
    [Arguments]    ${group_name}
    Input into  ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}  ${group_name}
    Wait For Page Load Successfully V1
    Click at  ${GROUP_IN_LINE_ELIPSIS}  ${group_name}
    Click at  ${ECLIPSE_DELETE_GROUP_BUTTON}
    Click at  ${ECLIPSE_CONFIRM_DELETE_GROUP_BUTTON}

Search a group
    [Arguments]     ${group_name}
    Go to Group Management page
    Click at    ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}
    input into      ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}     ${group_name}
    Wait For Page Load Successfully V1
    Check element display on screen     ${GROUP_NAME_IN_LIST}       ${group_name}
    Capture Page Screenshot

Add/Remove languages of group
    [Arguments]    @{language_list}     ${action}=add       ${is_confirmed}=True
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Click At    ${GROUP_MULTILINGUAL_CONFIGURE_BUTTON}
    FOR  ${language}  IN  @{language_list}
        Input Into  ${GROUP_MULTILINGUAL_CONFIGURE_INPUT_SEARCH_TEXTBOX}    ${language}
        IF  '${action}' == 'add'
            Check The Checkbox    ${GROUP_MULTILINGUAL_CONFIGURE_LANGUAGE_SELECT_CHECKBOX}    ${language}
        ELSE
            Uncheck The Checkbox    ${GROUP_MULTILINGUAL_CONFIGURE_LANGUAGE_SELECT_CHECKBOX}    ${language}
        END
    END
    Click At    ${GROUP_MULTILINGUAL_CONFIGURE_APPLY_BUTTON}
    IF  '${is_confirmed}' == 'True'
        Click At    ${GROUP_MULTILINGUAL_CONFIRM_BUTTON}
        Check Element Display On Screen     Your change has been saved.
        Capture Page Screenshot
    ELSE
        Click At    ${GROUP_MULTILINGUAL_UPDATE_LANGUAGE_CANCEL_BUTTON}
        Check Element not Display On Screen    ${GROUP_MULTILINGUAL_UPDATE_LANGUAGE_POPUP}      wait_time=1
        Capture Page Screenshot
    END

Select group language
    [Arguments]    ${language}
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Input Into  ${GROUP_MULTILINGUAL_CONFIGURE_INPUT_SEARCH_TEXTBOX}    ${language}
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN_LANGUAGE_SELECT}  ${language}
    Check Element Display On Screen    ${GROUP_MULTILINGUAL_DROPDOWN_SELECTED_LANGUAGE}    ${language}
    Capture Page Screenshot

Check dropdown or configure language list
    [Arguments]    @{language_list}    ${check_configure}=False    ${is_display}=True
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    IF    '${check_configure}' == 'True'
        Click At    ${GROUP_MULTILINGUAL_CONFIGURE_BUTTON}
    END
    IF  '${is_display}' == 'True'
        FOR  ${language}  IN  @{language_list}
            Check Text Display    ${language}
        END
    ELSE
        FOR  ${language}  IN  @{language_list}
            Check Element Not Display On Screen    ${language}      wait_time=1s
        END
    END
    Capture Page Screenshot
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}

Get all group
    Go to Group Management page
    Scroll to bottom of table    ${GROUP_SCROLL_VIEW}    interval=3000
    ${list_group}=    Get elements and convert to list    ${ALL_GROUP_NAME}
    [Return]    ${list_group}
