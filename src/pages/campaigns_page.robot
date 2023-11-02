*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/campaigns_locators.py

*** Variables ***
${campaign_active}              Campaign in Active Status
${campaign_active_add_users}    Campaign active status add audience is users

*** Keywords ***
Create new Campaign / Set Title
    [Arguments]    ${campaign_type}=Single Campaign  ${campaign_name}=None
    IF  '${campaign_name}' == 'None'
        ${campaign_name} =      Generate random name  auto_campaign
    END
    Click At    ${CAMPAIGN_PAGE_NEW_CAMPAIGN_BUTTON}
    Click at  ${CHOOSE_CAMPAIGN_TYPE_POPUP_TYPE_TEXT}  ${campaign_type}
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Title & Audience
    ${is_existed}=  Run Keyword And Return Status    Check Element Display On Screen    ${NEW_CAMPAIGN_TITLE}
    IF  '${is_existed}' == 'True'
        Input into  ${NEW_CAMPAIGN_TITLE}  ${campaign_name}
    ELSE
        Input into  ${DRIP_CAMPAIGN_TITLE}  ${campaign_name}
    END
    Capture Page Screenshot
    [Return]    ${campaign_name}

Create new Campaign / Set Audience
    [Arguments]    ${audience_type}  ${audience_filter}=None    ${role}=${CP_ADMIN}     ${file_name}=None
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Title & Audience
    IF  '${audience_type}' == 'Upload List'
        Import CSV file     ${file_name}
        Click At    ${NEW_CAMPAIGN_AUDIENCE_UPLOAD_APPLY_BUTTON}
    ELSE
        Click at  ${NEW_CAMPAIGN_SELECT_AUDIENCE_DROPDOWN}
        Click at  ${NEW_CAMPAIGN_AUDIENCE_TYPE}  ${audience_type}
    END
    IF  '${audience_type}' == 'Candidates'
        ${has_from_dropdown}=  Run Keyword And Return Status    Check Element Display On Screen    ${NEW_CAMPAIGN_CANDIDATE_FROM_DROPDOWN}  wait_time=1s
        IF    ${has_from_dropdown}
            Click at  ${NEW_CAMPAIGN_CANDIDATE_FROM_DROPDOWN}
            Click at  All time
        END
        Click at  ${NEW_CAMPAIGN_AUDIENCE_TYPE}  Add Filter
        IF  '${audience_filter}' != 'None'
            Input into  ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}  ${audience_filter}
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_VALUE_OPTION}      ${audience_filter}
        ELSE
            Input into  ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}  Add Candidates
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_MAIN_VALUE}  Add Candidates
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_CHECKBOX}
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_APPLY_BUTTON}
        END
    ELSE IF  '${audience_type}' == 'Users'
        Click At    ${NEW_CAMPAIGN_USER_FILTER_CHECKBOX}        ${role}
        Click At    ${NEW_CAMPAIGN_USER_APPLY_BUTTON}
        Click At    ${NEW_CAMPAIGN_AUDIENCE_TYPE}  Add Filter
        IF  '${audience_filter}' != 'None'
            Input into  ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}  ${audience_filter}
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_VALUE_OPTION}      ${audience_filter}
            IF  '${audience_filter}' == 'Add Users'
                Click At  ${NEW_CAMPAIGN_AUDIENCE_FILTER_CHECKBOX}
                Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_APPLY_BUTTON}
            END
        ELSE
            Input into  ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}  Add Users
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_MAIN_VALUE}  Add Users
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_CHECKBOX}
            Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_APPLY_BUTTON}
        END
    END

Create new Campaign / Set Compose step
    [Arguments]    ${channel}  ${campaign_type}=Message    ${campaign_type_option}=None  ${event}=None
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Compose
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}  ${campaign_type}
    IF  '${campaign_type_option}' != 'None'
        Click At    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_SECOND_DROPDOWN}
        Input Into    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_SECOND_DROPDOWN_SEARCH_TEXTBOX}    ${campaign_type_option}
        Click At    ${campaign_type_option}
    END
    ${has_multiligual}=  Run Keyword And Return Status    Check Element Display On Screen    ${NEW_CAMPAIGN_MULTILINGUAL_LANGUAGE_UPDATE_CONFIRM_BUTTON}  wait_time=1s
    Run Keyword If    ${has_multiligual}    Click At    ${NEW_CAMPAIGN_MULTILINGUAL_LANGUAGE_UPDATE_CONFIRM_BUTTON}
    ${return_message} =     Generate random name  auto_message
    IF  '${channel}' == 'SMS'
        Check The Checkbox    ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}   ${channel}
        Clear Element Text With Keys    ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
        Simulate Input  None  ${return_message}
    ELSE IF  '${channel}' == 'Email'
        Check The Checkbox    ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}   ${channel}
        Clear Element Text With Keys  ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}
        Simulate Input  None  Title ${return_message}
        Clear Element Text With Keys  ${NEW_CAMPAIGN_EMAIL_CHANNEL_MESSAGE_BOX}
        Simulate Input  None  Message ${return_message}
    END
    IF  '${event}' != 'None'
        Check The Checkbox    ${NEW_CAMPAIGN_COMPOSE_EVENT_CHECKBOX}
        Click At    ${NEW_CAMPAIGN_COMPOSE_EVENT_DROPDOWN}
        Input Into  ${NEW_CAMPAIGN_COMPOSE_EVENT_DROPDOWN_SEARCH_TEXTBOX}   ${event}
        Click At    ${event}
    END
    [Return]    ${return_message}

Create new Campaign / Set Schedule step
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Schedule
    Click at  ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR}
    ${future_date} =    get_future_date
    Click at  ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR_VALUE}  ${future_date}
    Click at  ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Click at  ${NEW_CAMPAIGN_CONFIRM_POPUP_CONFIRM_BUTTON}

Delete a Campaign
    [Arguments]    ${campaign_name}    ${campaign_tab}=Scheduled
    Search a Campaign  ${campaign_name}     ${campaign_tab}
    Click at  ${CAMPAIGN_PAGE_ITEM_ECLIPSE_MENU_BUTTON}
    Click at  ${CAMPAIGN_ITEM_ECLIPSE_MENU_DELETE_BUTTON}
    Click at  ${CAMPAIGN_ITEM_DELETE_POPUP_DELETE_BUTTON}

Search a Campaign
    [Arguments]    ${campaign_name}     ${campaign_status}
    Go To Campaigns Page
    Click at  ${CAMPAIGN_PAGE_TAB_ITEM}  ${campaign_status}
    Input into  ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}  ${campaign_name}
    Check element display on screen  ${campaign_name}
    Capture page screenshot

Create New Campaign
    [Arguments]   ${channel}    ${audience_type}   ${campaign_name}=None  ${campaign_type}=Single Campaign
    ...  ${audience_filter}=None      ${compose_campaign_type}=Message      ${campaign_type_option}=None
    ...  ${role}=Company Admin   ${campaign_status}=Scheduled    ${event}=None
    ${campaign_name}=  Create new Campaign / Set Title  ${campaign_type}    ${campaign_name}
    Create new Campaign / Set Audience  ${audience_type}  ${audience_filter}    ${role}
    Create new Campaign / Set Compose step  ${channel}  ${compose_campaign_type}  ${campaign_type_option}   ${event}
    IF  '${campaign_status}' == 'Scheduled'
        Create new Campaign / Set Schedule step
    ELSE
        Reload Page
        Handle Alert    ACCEPT
    END
    Capture Page Screenshot
    [Return]    ${campaign_name}

Load full Campaign in page
    ${js_script} =    Set variable    function delay(time) { return new Promise(resolve => setTimeout(resolve, time)); } do { defaultHeight = document.getElementById("container").scrollHeight; window.scrollTo(0, document.getElementById("container").scrollHeight); await delay(2000); maxHeight = document.getElementById("container").scrollHeight; } while (defaultHeight < maxHeight)
    Execute Javascript    ${js_script}

Send mail to Audience and verify mail
    [Arguments]    ${subject}      ${content}
    Click At    ${NEW_CAMPAIGN_SEND_A_TEST_BUTTON}
    ${is_changed}=      Run Keyword And Return Status    Check Element Display On Screen    ${NEW_CAMPAIGN_EMAIL_SAVE_CONFIRM_BUTTON}
    IF  '${is_changed}' == 'True'
        Click At    ${NEW_CAMPAIGN_EMAIL_SAVE_CONFIRM_BUTTON}
    END
    &{email_info} =     Get email for testing       False
    Input Into    ${NEW_CAMPAIGN_EMAIL_INPUT_BOX}       ${email_info.email}
    Click At        ${NEW_CAMPAIGN_SEND_MESSAGE_BUTTON}
    Verify user has received the email           ${subject}     ${content}

Go To Campaign Detail Page
    [Arguments]    ${campaign_name}     ${campaign_status}
    Go To Campaigns Page
    Search a Campaign     ${campaign_name}     ${campaign_status}
    Click At  ${campaign_name}

Verify Search Display
    [Arguments]    ${campaign_name}     ${campaign_status}      ${is_display}=True
    Search a Campaign   ${campaign_name}     ${campaign_status}
    IF  '${is_display}' == 'True'
        Check Text Display    ${campaign_name}
    ELSE
        Check Element Not Display On Screen    ${campaign_name}     wait_time=1s
    END
    Capture Page Screenshot

Select compose language
    [Arguments]    @{language_list}
    Click At    ${NEW_CAMPAIGN_MULTILINGUAL_BUTTON}
    FOR  ${language}    IN  @{language_list}
        Input Into  ${NEW_CAMPAIGN_MULTILINGUAL_SEARCH_TEXTBOX}  ${language}
        Check The Checkbox  ${NEW_CAMPAIGN_MULTILINGUAL_ITEM_CHECKBOX}  ${language}
    END
    Click At    ${NEW_CAMPAIGN_MULTILINGUAL_BUTTON}
    Click At    ${NEW_CAMPAIGN_MULTILINGUAL_CONFIRM_BUTTON}
    Wait For Page Load Successfully V1

Import CSV file
    [Arguments]    ${file_name}     ${is_clicked}=None
    IF  '${is_clicked}' == 'None'
        Click At    ${NEW_CAMPAIGN_AUDIENCE_UPLOAD_BUTTON}
    END
    ${element} =    Get Webelement    ${NEW_CAMPAIGN_AUDIENCE_UPLOAD_FORM}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
    ...    ARGUMENTS    ${element}
    ${file_path}=  get_path_upload_csv   ${file_name}
    Choose File   ${element}    ${file_path}
    [Return]    ${file_path}

Duplicate a Campaign
    [Arguments]    ${campaign_name}    ${campaign_tab}=Scheduled
    Click at  ${CAMPAIGN_PAGE_TAB_ITEM}  ${campaign_tab}
    Input into  ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}  ${campaign_name}
    Click at  ${CAMPAIGN_PAGE_ITEM_ECLIPSE_MENU_BUTTON}
    Click at  ${CAMPAIGN_ITEM_ECLIPSE_MENU_OPTION_BUTTON}       Duplicate Campaign
    Create new Campaign / Set Schedule step

Reschedule a Campaign
    [Arguments]    ${campaign_name}    ${campaign_tab}=Scheduled
    Click at  ${CAMPAIGN_PAGE_TAB_ITEM}  ${campaign_tab}
    Input into  ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}  ${campaign_name}
    Click at  ${CAMPAIGN_PAGE_ITEM_ECLIPSE_MENU_BUTTON}
    Click at  ${CAMPAIGN_ITEM_ECLIPSE_MENU_OPTION_BUTTON}       Reschedule

Pause a Campaign
    Click at  ${CAMPAIGN_PAGE_ITEM_ECLIPSE_MENU_BUTTON}
    Click At    ${CAMPAIGN_ITEM_ECLIPSE_MENU_OPTION_BUTTON}     Pause Campaign
    Click At    ${CAMPAIGN_ITEM_ECLIPSE_MENU_PAUSE_CONFIRM_BUTTON}

Get all campaign for filter
    Go to Campaigns page
    click at    ${CAMPAIGN_ACTIVE_TAB}
    ${list_active}=    Get elements and convert to list    ${CAMPAIGN_ALL_CAMPAIGN_NAME}
    click at    ${CAMPAIGN_PAUSED_TAB}
    ${list_paused}=    Get elements and convert to list    ${CAMPAIGN_ALL_CAMPAIGN_NAME}
    ${result}=    Evaluate    ${list_active}+${list_paused}
    [Return]    ${result}

Campaign step in Drip campaign
    [Arguments]     ${campaign_list}    ${campaign_status}=New
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Campaigns
    ${type} =   Evaluate    type($campaign_list).__name__
    IF  '${type}' == 'list'
        FOR   ${campaign_name}  IN   @{campaign_list}
            ${is_existed}=  Run Keyword And Return Status    Check Element Not Display On Screen    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}    Add Campaign    wait_time=1s
            Capture Page Screenshot
            IF  '${is_existed}' == 'False'
                Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}
            ELSE
                Click At    ${DRIP_CAMPAIGN_MORE_CAMPAIGN_BUTTON}
            END
            Add a Campaign in the second step of Drip Campaign      ${campaign_name}
        END
    ELSE
        Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}
        IF  '${campaign_status}' == 'New'
            Click At    ${DRIP_CAMPAIGN_OPTION}     Create a new campaign
            Click At    ${CAMPAIGN_CONFIRM_BUTTON}
        ELSE
            Add a Campaign in the second step of Drip Campaign      ${campaign_list}
        END
    END

Add a Campaign in the second step of Drip Campaign
    [Arguments]    ${campaign_name}
    Click At    ${DRIP_CAMPAIGN_OPTION}     Use an existing campaign template
    Click At    ${DRIP_CAMPAIGN_TEMPLATE_DROPDOWN}
    ${is_existed}=      Run Keyword And Return Status    Check Element Not Display On Screen      ${DRIP_CAMPAIGN_VISIBLE_SEARCH_BUTTON}    wait_time=1s
    Capture Page Screenshot
    IF  '${is_existed}' == 'False'
        Input Into        ${DRIP_CAMPAIGN_VISIBLE_SEARCH_BUTTON}    ${campaign_name}
    ELSE
        Input Into    ${DRIP_CAMPAIGN_SEARCH_BUTTON}    ${campaign_name}
    END
    Click At    ${DRIP_CAMPAIGN_CHOSEN_OPTION}     ${campaign_name}
    Click At    ${CAMPAIGN_CONFIRM_BUTTON}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    Check Element Display On Screen    ${DRIP_CAMPAIGN_NAME_ROW}    ${campaign_name}
    Capture Page Screenshot

Create New Drip Campaign
    [Arguments]   ${campaign_name}=None     ${campaign_status}=Scheduled
    ${campaign_name}=  Create new Campaign / Set Title  campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates
    @{campaign_list}=       Create List     ${campaign_active}      ${campaign_active_add_users}
    Create new Campaign / seccond step Campaigns in Drip Campaign       @{campaign_list}
    IF  '${campaign_status}' == 'Scheduled'
        Create new Campaign / Set Schedule step
    ELSE
        Reload Page
        Handle Alert    ACCEPT
    END
    Capture Page Screenshot
    [Return]    ${campaign_name}

Select Channel in Drip campaign
    [Arguments]    ${channel}=Email     ${is_existed}=None
    IF  '${channel}' == 'Email'
        &{subject} =    Create Dictionary
        Check The Checkbox        ${DRIP_CAMPAIGN_EMAIL_CHANNEL_ICON}
        ${subject.name}=      Generate Random Name    auto_subject
        ${subject.message}=     Generate random name    auto_message
        Clear Element Text With Keys    ${DRIP_CAMPAIGN_ENTER_EMAIL_SUBJECT_TEXT}
        Simulate Input    ${DRIP_CAMPAIGN_ENTER_EMAIL_SUBJECT_TEXT}     ${subject.name}
        Clear Element Text With Keys    ${DRIP_CAMPAIGN_ENTER_EMAIL_MESSAGE_TEXT}
        Simulate Input      ${DRIP_CAMPAIGN_ENTER_EMAIL_MESSAGE_TEXT}     ${subject.message}
        IF  '${is_existed}' == 'None'
            Click At    ${DRIP_CAMPAIGN_SELECT_CAMPAIGN_TYPE_DROPDOWN}
            Click At    ${DRIP_CAMPAIGN_SELECT_CAMPAIGN_TYPE_DROPDOWN_OPTION}
        ELSE
            Click At    ${DRIP_CAMPAIGN_CHANNEL_TEXT}
            Click At    ${DRIP_CAMPAIGN_SELECT_CAMPAIGN_TYPE_DROPDOWN_OPTION}
        END
    END
    [Return]    &{subject}

Select Event in Drip campaign
    [Arguments]    ${event_name}
    Check The Checkbox    ${DRIP_CAMPAIGN_EVENT_TOGGLE_CHECKBOX}
    Click At    ${DRIP_CAMPAIGN_SELECT_AN_EVENT_DROPDOWN}
    Input Into    ${DRIP_CAMPAIGN_SEARCH_EVENT_BUTTON}      ${event_name}
    Click At    ${DRIP_CAMPAIGN_EVENT_DROPDOWN_OPTION}

Verify schedule tab after campaign composing when select time has elapsed
    [Arguments]    ${channel}=None   ${campaign_type}=Message    ${campaign_type_option}=None    ${skip_create}=False
    IF  '${skip_create}' == 'False'
        Create new Campaign / Set Compose step      ${channel}     ${campaign_type}      campaign_type_option=${campaign_type_option}
    END
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Schedule
    Click At    ${NEW_CAMPAIGN_SCHEDULE_TIME_SELECTOR}
    Click At    01:00
    Click At    ${NEW_CAMPAIGN_SCHEDULE_MIDDAY_SELECTOR}
    Click At    AM
    Check Text Display    Sorry, this time is no longer available. Please select a new time.
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TAB_ICON_WARN}   Schedule
    Capture Page Screenshot
