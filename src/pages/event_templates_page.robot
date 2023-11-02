*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/event_templates_locators.py

*** Keywords ***
Create event template group
    [Arguments]    ${template_group_name}
    ${is_group_existed} =    Run Keyword And Return Status    Check strong text display    ${template_group_name}
    IF    ${is_group_existed}== 'False'
        Click at    ${CREATE_EVENT_TEMPLATE_GROUP_BUTTON}
        Input into    ${EVENT_TEMPLATE_GROUP_NAME_TEXTBOX}    ${template_group_name}
        Click at    ${SAVE_BUTTON_POPUP}
    END

Go to event template group
    [Arguments]    ${template_group_name}
    Click at    ${EVENT_TEMPLATE_GROUP_NAME_LABEL}    ${template_group_name}
    wait for page load successfully

Set event template type
    [Arguments]    ${event_template_type}
    IF    '${event_template_type}' == 'Hiring Event'
        Click on p text    ${event_template_type}
        Click on span text    Next
    ELSE IF    '${event_template_type}' == 'Orientation'
        Click on p text    ${event_template_type}
    END

Click create event template with type
    [Arguments]    ${event_template_type}    ${event_venue_type}=None
    Click at    ${CREATE_EVENT_TEMPLATE_BUTTON}
    Set event template type    ${event_template_type}
    IF    '${event_venue_type}' != 'None'
        Click on p text    ${event_venue_type}
    END
    Click on span text    Create Event Template
    wait for page load successfully

Set event template venue
    [Arguments]    ${event_venue}
    Click at    ${EVENT_TEMPLATE_VENUE_DROPDOWN}
    select from list by label    ${EVENT_TEMPLATE_VENUE_DROPDOWN}    ${event_venue}

Publish event template
    Click at    ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Check element display on screen    Published
    Go to Event Templates page

Delete event template
    [Arguments]    ${event_template}
    Click at    ${ICON_MENU_BY_TEMPLATE_NAME}    ${event_template}
    Click at    ${DELETE_ICON}
    Click at    ${CONFIRM_POPUP_BUTTON}
    Wait for page load successfully
    Check element not display on screen     ${ICON_MENU_BY_TEMPLATE_NAME}    ${event_template}

Set overview step Hiring Event
    [Arguments]   ${event_template_name}    ${school_name}
    Input into    ${PUBLIC_TEMPLATE_NAME_TEXTBOX}    ${event_template_name}
    wait for page load successfully v1
    Click at    ${INPUT_SELECT_EVENT_TYPE}
    Click at    ${SELECT_EVENT_TYPE}    Hiring Event
    Click at    ${CAMPUS_EVENT_TOGGLE}
    Click at    ${EVENT_TEMPLATE_INPUT_SCHOOL}
    Click at    ${school_name}
    wait for page load successfully v1

Verify event template create successfully
    [Arguments]     ${event_template_group}         ${event_template_name}
    Click at    ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Go to Event Templates page
    Go to event template group    ${event_template_group}
    Check element display on screen     ${PUBLISHED_EVENT_TEMPLATE}     ${event_template_name}

Add team members
    [Arguments]     @{members}
    IF      @{members}
        FOR     ${member}  IN      @{members}
            Add team member   ${member}
        END
    END

Add team member
    [Arguments]     ${member}
    Click at    ${EVENT_TEMPLATE_INPUT_ADD_EVENT_TEAM}
    Input into    ${EVENT_TEMPLATE_INPUT_ADD_EVENT_TEAM}   ${member}
    Click at    ${EVENT_TEMPLATE_TEAM_MEMBERS_DROPDOWN}   ${member}
    Click at    ${EVENT_TEMPLATE_ADD_TEAM_MEMBER_BUTTON}

Click Registration step for event template
    [Arguments]    ${conversation_name}
    Click at      ${EVENT_TEMPLATE_CONVERSATION_SELECT}
    Click at      ${EVENT_TEMPLATE_EVENT_CONVERSATION}        ${conversation_name}
    wait for page load successfully

Duplicate event template
    [Arguments]    ${event_template_name}       ${new_event_template_name}=None
    Click at    ${ICON_MENU_BY_TEMPLATE_NAME}    ${event_template_name}
    Click at    ${EVENT_TEMPLATE_DUPLICATE_ICON}
    wait for page load successfully
    IF      '${new_event_template_name}' == 'None'
            Check span display     Copy - ${event_template_name}
    ELSE
            Input into    ${PUBLIC_TEMPLATE_NAME_TEXTBOX}    ${new_event_template_name}
            wait for page load successfully v1
    END
    Click at    ${PUBLISH_EVENT_TEMPLATE_BUTTON}

Add new session for hiring event template
    [Arguments]     ${session_name}     ${interview_type}     ${interview_per_duration}
    Input into      ${EVENT_TEMPLATE_SESSION_NAME_TEXTBOX}         ${session_name}
    Click at        ${EVENT_TEMPLATE_INTERVIEW_TYPE_SELECT}
    Click at        ${EVENT_TEMPLATE_SELECT_OPTIONS}          ${interview_type}
    Click at        ${EVENT_TEMPLATE_INTERVIEW_PER_DURATION_SELECT}
    Click at        ${EVENT_TEMPLATE_SELECT_OPTIONS}           ${interview_per_duration}

Edit event template
    [Arguments]    ${event_template}
    Click at    ${ICON_MENU_BY_TEMPLATE_NAME}    ${event_template}
    Click at    ${EVENT_TEMPLATE_EDIT_ICON}
    ${event_template_name} =    Generate random name    new_hiring_event
    wait for page load successfully v1
    Input into    ${PUBLIC_TEMPLATE_NAME_TEXTBOX}    ${event_template_name}
    Wait for page load successfully v1
    Check element display on screen     ${EVENT_TEMPLATE_SETTINGS_ICON}
    Click at     ${EVENT_TEMPLATE_TOOLS_TEXT}
    Click at     ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    [Return]     ${event_template_name}

Verify Session was add into Schedule Tab
    [Arguments]     ${session_name}     ${interview_type}
    Check element display on screen         ${EVENT_TEMPLATE_SESSION_ITEM_TITLE}       ${session_name}
    ${type} =    Get text and format text   ${EVENT_TEMPLATE_CATEGORY_INFO}      ${session_name}
    Should Contain    ${type}    ${interview_type}

Delete session in Schedule Tab
    [Arguments]     ${session_name}
    Click at    ${ICON_MENU_BY_SESSION_NAME}        ${session_name}
    Click at    ${EVENT_TEMPLATE_DELETE_ICON}
    Click at    ${EVENT_TEMPLATE_CONFIRM_DELETE_SESSION_BUTTON}
    wait for page load successfully
    Check element not display on screen     ${EVENT_TEMPLATE_SESSION_ITEM_TITLE}       ${session_name}

Edit session in Schedule Tab
    [Arguments]     ${session_name}
    Click at    ${ICON_MENU_BY_SESSION_NAME}        ${session_name}
    Click at    ${EVENT_TEMPLATE_EDIT_ICON}
    Clear element text with keys    ${EVENT_TEMPLATE_SESSION_NAME_TEXTBOX}
    ${new_session_name} =       Generate random name    new_session_name
    Input into       ${EVENT_TEMPLATE_SESSION_NAME_TEXTBOX}        ${new_session_name}
    [Return]    ${new_session_name}

Duplicate a session
    [Arguments]     ${session_name}     ${new_session_name}=None
    Click at        ${ICON_MENU_BY_SESSION_NAME}        ${session_name}
    Click at        ${EVENT_TEMPLATE_DUPLICATE_ICON}
    wait for page load successfully
    IF      '${new_session_name}' == 'None'
            Check span display     Copy of ${session_name}
    ELSE
            Input into    ${EVENT_TEMPLATE_SESSION_NAME_TEXTBOX}    ${new_session_name}
    END
    Click at        ${EVENT_TEMPLATE_CONFIRM_ADD_SESSION_BUTTON}
    wait for page load successfully

Open edit default outcome model
    Click at    ${ICON_MENU_BY_DEFAULT_OUTCOME}
    Click at    ${EVENT_TEMPLATE_EDIT_ICON}

Add registration outcome match any location
    [Arguments]     ${outcome_name}         ${location}     ${action}
    Input into      ${EVENT_TEMPLATE_NAME_OUTCOME_INPUT}        ${outcome_name}
    Click at        ${EVENT_TEMPLATE_STARTING_VALUE_SELECT}
    Click at        ${EVENT_TEMPLATE_ASSIGNED_LOCATION}
    Click at        ${EVENT_TEMPLATE_MATCHES_SELECT}
    Click at        Is Any Of
    Click at        ${EVENT_TEMPLATE_INPUT_DROPDOWN}
    Click at        All Locations
    Click at        ${EVENT_TEMPLATE_INPUT_LOCATION}    ${location}
    Click at        ${EVENT_TEMPLATE_APPLY_BUTTON}
    Click at        ${EVENT_TEMPLATE_OUTCOME_ACTION_SELECT}
    Click at        ${action}

Verify add registration outcome successfully
    [Arguments]     ${outcome_name}         ${action}
    Check element display on screen         ${EVENT_TEMPLATE_OUTCOME_NAME_IN_LIST}      ${outcome_name}
    ${text} =    Get text and format text   ${EVENT_TEMPLATE_OUTCOME_CONDITIONS_IN_LIST}      ${outcome_name}
    Should Contain    ${text}    ${action}

Edit registration outcome
    [Arguments]     ${outcome_name}         ${new_outcome_name}
    Click at    ${ICON_MENU_BY_REGISTRATION_OUTCOME}    ${outcome_name}
    Click at    ${EVENT_TEMPLATE_EDIT_ICON}
    wait for page load successfully
    Input into      ${EVENT_TEMPLATE_NAME_OUTCOME_INPUT}        ${new_outcome_name}

Duplicate registration outcome
    [Arguments]     ${outcome_name}
    Click at    ${ICON_MENU_BY_REGISTRATION_OUTCOME}    ${outcome_name}
    Click at    ${EVENT_TEMPLATE_DUPLICATE_ICON}
    wait for page load successfully
