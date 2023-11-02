*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/conversation_builder_page.robot
Variables       ../locators/client_setup_locators.py

*** Variables ***
${webex_user_name}      dong@paradox.ai
${webex_password}       Olivia@545123
${webex_site_name}      meetingsapac17

*** Keywords ***
Check Venue Type has Virtual option is displayed
    Scroll to element    ${VENUE_TYPES_VIRTUAL}
    ${value_attribute} =    Get Element Attribute    ${VENUE_TYPES_VIRTUAL}    value
    should be equal    ${value_attribute}    Virtual Hiring Events

Check Interaction Types has Virtual Chat Booth is displayed
    Scroll to element    ${VIRTUAL_EVENTS_INTERACTION_TYPES}
    Check element display on screen    ${VIRTUAL_EVENTS_INTERACTION_TYPES}
    Check element not display on screen    ${IN_PERSON_EVENTS_INTERACTION_TYPES}

Turned ON only Virtual HIring Event toggle
    log    Virtual HIring Event toggle is ON

Turned ON only General HIring Event toggle
    log    General HIring Event toggle is ON

Turned ON both General Hiring Event and Virtual HIring Event
    log    both General Hiring Event and Virtual HIring Event

Check Venue Type has In Person Hiring Events option is displayed
    ${value_attribute} =    Get Element Attribute    ${VENUE_TYPES_VIRTUAL}    value
    should be equal    ${value_attribute}    In-Person Hiring Events

Check All options of Interaction Types are selected
    Scroll to element    ${VIRTUAL_EVENTS_INTERACTION_TYPES}
    Check element display on screen    ${VIRTUAL_EVENTS_INTERACTION_TYPES}
    Check element display on screen    ${IN_PERSON_EVENTS_INTERACTION_TYPES}

config only Event Session selected for in person interacted type
    go to event client setup and turn on event and hiring type
    when Click at    ${IN_PERSON_EVENTS_INTERACTION_TYPES_DROPDOWN}
    when Check the checkbox    ${EVENT_SESSIONS}
    when Uncheck the checkbox    ${SCHEDULED_INTERVIEWS}
    click on apply and save config on client setup

revert config default for event company
    go to event client setup and turn on event and hiring type
    when Click at    ${IN_PERSON_EVENTS_INTERACTION_TYPES_DROPDOWN}
    when Check the checkbox    ${EVENT_SESSIONS}
    when Check the checkbox    ${SCHEDULED_INTERVIEWS}
    and Click at    ${APPLY_BUTTON_INTERACTED_IN_PERSON_TYPE}
    when Click at    ${VIRTUAL_EVENTS_INTERACTION_TYPES_DROPDOWN}
    when Check the checkbox    ${LIVE_VIDEO_BROADCASTS_CHECKBOX}
    when Check the checkbox    ${VIRTUAL_CHAT_BOOTHS_CHECKBOX}
    when Check the checkbox    ${VIRTUAL_SCHEDULED_INTERVIEWS_CHECKBOX}
    when Click at    ${APPLY_BUTTON_VIRTUAL_VENUE_TYPES}
    run keyword and ignore error    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    run keyword and ignore error    wait for page load successfully v1

click on apply and save config on client setup
    when Click at    ${APPLY_BUTTON_INTERACTED_IN_PERSON_TYPE}
    run keyword and ignore error    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    run keyword and ignore error    wait for page load successfully v1

go to event client setup and turn on event and hiring type
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}

config virtual schedule interview Interviews only selected for virtual interacted type
    go to event client setup and turn on event and hiring type
    when Click at    ${VIRTUAL_EVENTS_INTERACTION_TYPES_DROPDOWN}
    when Uncheck the checkbox    ${LIVE_VIDEO_BROADCASTS_CHECKBOX}
    when Uncheck the checkbox    ${VIRTUAL_CHAT_BOOTHS_CHECKBOX}
    when Check the checkbox    ${VIRTUAL_SCHEDULED_INTERVIEWS_CHECKBOX}
    when Click at    ${APPLY_BUTTON_VIRTUAL_VENUE_TYPES}
    run keyword and ignore error    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    run keyword and ignore error    wait for page load successfully v1

Turn On Job Data Package Toggle
    Click at    ${HIRE_LABEL}
    Turn on    ${OLIVIA_HIRE_TOGGLE}
    Turn on    ${JOB_DATA_PACKAGES_ON}
    Click save config in client setup

Turn Off Job Data Package Toggle
    Click at    ${HIRE_LABEL}
    Turn on    ${OLIVIA_HIRE_TOGGLE}
    Turn off    ${JOB_DATA_PACKAGES_ON}
    Click save config in client setup

Navigate to Hire Option
    Navigate to Option in client setup    Hire
    Check strong text display    Olivia Hire

Navigate to Schedule Option
    Navigate to Option in client setup    Scheduling
    check element display on screen    ${NEW_SCHEDULING_UI_TOGGLE}

Navigate to Care Option
    Navigate to Option in client setup    Care
    Check strong text display    Care

Turn on toggle new UI/UX Scheduling
    Turn on    ${NEW_SCHEDULING_UI_TOGGLE}
    Click save config in client setup

Turn off toggle new UI/UX Scheduling
    Turn off    ${NEW_SCHEDULING_UI_TOGGLE}
    Click save config in client setup

Click save config in client setup
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    Wait with medium time

Navigate to Option in client setup
    [Arguments]    ${option}
    go to Client setup page
    Click on strong text    ${option}
    wait with short time

Toggle on Olivia Assist in Client Setup
    Turn on    ${OLIVIA_ASSIST_TOOGLE}
    Click save config in client setup

Turn off toggle Advanced Setting
    Scroll to element    ${ADVANCED_INTERVIEW_TOGGLE}
    Turn off    ${ADVANCED_SCHEDULING_SETTING}
    Click save config in client setup

Turn on toggle room booking
    Turn off    ${ROOM_BOOKING_TOGGLE}
    Click save config in client setup

Get all location calendar
    @{item_list} =    Create List
    ${item_elements} =    Get WebElements    ${LOCATION_CALENDAR_NAME}
    FOR    ${element}    IN    @{item_elements}
        Append To List    ${item_list}    ${element.get_attribute('innerText')}
    END
    [Return]    @{item_list}

Turn ON Candidate Store Location Available
    Click on strong text    Events
    wait for page load successfully
    Turn on    ${CANDIDATE_STORE_AVAILABLE_LOCATION_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    Wait with medium time
    wait for page load successfully

Turn OFF Candidate Store Location Available
    Click on strong text    Events
    wait for page load successfully
    Turn off    ${CANDIDATE_STORE_AVAILABLE_LOCATION_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    wait for page load successfully

Turn ON Olivia Assist toggle
    Click on strong text    Care
    wait for page load successfully
    Turn on    ${OLIVIA_ASSIST_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    Wait with medium time
    wait for page load successfully

Turn OFF Olivia Assist toggle
    Click on strong text    Care
    wait for page load successfully
    Turn off    ${OLIVIA_ASSIST_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    Wait with medium time
    wait for page load successfully

Select Virtual Technology Prodiver
    [Arguments]     ${provider}
    Click on strong text    Scheduling
    wait for page load successfully
    select from list by label       ${VIRTUAL_TECHNOLOGY_PROVIDER_DROPDOWN}     ${provider}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    Wait with medium time
    wait for page load successfully

Input virtual technology information
    Click on strong text    Scheduling
    wait for page load successfully
    Input into      ${WEBEX_USER_NAME_TEXTBOX}      ${webex_user_name}
    Input into      ${WEBEX_PASSWORD_TEXTBOX}       ${webex_password}
    Input into      ${WEBEX_SITE_NAME_TEXTBOX}      ${webex_site_name}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${SAVE_BUTTON}
    END
    Wait with medium time
    wait for page load successfully

Turn on/off Advanced Setting in Client Setup
    [Arguments]    ${type}=On
    Scroll to element       ${SCHEDULING_LABEL}
    Click on strong text    Scheduling
    Scroll to element    ${ADVANCED_SCHEDULING_SETTING}
    IF  '${type}' == 'On'
        Turn on     ${ADVANCED_SCHEDULING_SETTING}
    ELSE
        Turn off    ${ADVANCED_SCHEDULING_SETTING}
    END
    Click save config in client setup

Turn on/off Allow user choose interview time in Client Setup
    [Arguments]    ${type}=On
    Click on strong text    Scheduling
    Scroll to element    ${ALLOW_USER_CHOOSE_INTERVIEW_TIME_TOOGLE}
    IF  '${type}' == 'On'
        Turn on    ${ALLOW_USER_CHOOSE_INTERVIEW_TIME_TOOGLE}
    ELSE
        Turn off   ${ALLOW_USER_CHOOSE_INTERVIEW_TIME_TOOGLE}
    END
    Click save config in client setup

Turn off New Scheduling UI/UX in Client setup
    Scroll to element    ${SCHEDULING_LABEL}
    Click on strong text    Scheduling
    Turn off    ${NEW_SCHEDULING_UI_TOGGLE}
    Click save config in client setup

Turn on New Scheduling UI/UX in Client setup
    Click on strong text    Scheduling
    Turn on    ${NEW_SCHEDULING_UI_TOGGLE}
    Click save config in client setup

Turn on Olivia Assist in Client Setup
    Click on strong text    Care
    Turn on    ${OLIVIA_ASSIST_TOOGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Select Basic User Access
    [Arguments]     ${basic_user_access_type}
    Click on strong text    Account Overview
    Click at    ${BASIC_USER_ACCESS}
    wait with short time
    Click at    ${BASIC_USER_ACCESS_TYPE_OPTION}     ${basic_user_access_type}
    Capture Page Screenshot
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time
    wait for page load successfully

Turn on Allow for private interview calendar event toogle
    Click on strong text    Scheduling
    Turn on     ${ALLOW_FOR_PRIVATE_INTERVIEW_CALENDER_EVENT_TOOGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Turn on Manage Company-wide Scheduling Timelines
    Click on strong text    Scheduling
    Turn on     ${MANAGE_COMPANY_WIDE_SCHEDULING_TIMLINES_TOOGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Select candidate timezone mothed
    [Arguments]     ${timezone_option}
    Click at strong text    scheduling
    Click at    ${CANDIDATE_TIMEZONE_METHOD_DROPDOWN}
    Click by JS    ${CANDIDATE_TIMEZONE_METHOD_DROPDOWN_OPTIONS}      ${timezone_option}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Turn on Do not update scheduling timezone based on candidate's IP address toggle
    Click on strong text        Scheduling
    Turn on     ${DO_NOT_UPDATE_SCHEDULING_TIMEZONE_BASED_ON_CANDIDATE_TOGGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Turn on Interview Prep
    Click on strong text    Scheduling
    Turn on     ${INTERVIEW_PREP_TOGGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Enable Client Setup for scheduling new ui ux
    [Arguments]    ${item}
    Go to Client setup page
    IF    '${item}' == 'Scheduling'
        Click at    ${SCHEDULING_LABEL}
        Turn on     ${ADVANCED_SCHEDULING_SETTING}
        Turn on     ${ALLOW_FOR_PRIVATE_INTERVIEW_CALENDER_EVENT_TOOGLE}
        Turn on     ${INTERVIEW_PREP_TOGGLE}
        Turn on     ${ALLOW_USER_CHOOSE_INTERVIEW_TIME_TOOGLE}
        Turn on     ${ROOM_BOOKING_TOGGLE}
        Turn on     ${MANAGE_COMPANY_WIDE_SCHEDULING_TIMLINES_TOOGLE}
    ELSE IF     '${item}' == 'Care'
        Click at    ${CARE_LABEL}
        Turn on     ${OLIVIA_ASSIST_TOOGLE}
    ELSE IF     '${item}' == 'Hire'
        Click on strong text    Hire
        Turn on     ${OLIVIA_HIRE_TOGGLE}
        Turn on     ${CANDIDATE_JOURNEYS_TOGGLE}
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

Turn off toggle Interview Prep
    Scroll to element    ${INTERVIEW_PREP_TOGGLE}
    Turn off    ${INTERVIEW_PREP_TOGGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Add new interview type
    [Arguments]     ${type_interview}
    ${interview_type}=      Generate random name only text      test
    ${api_id_number}=       Generate random string      5       [NUMBERS]
    go to Client setup page
    click on strong text    Scheduling
    click at     ${ADD_TYPE_BUTTON}
    ${interview_type_full_name}=      set variable       Interview_type ${interview_type}
    input into      ${INTERVIEW_NAME_TEXTBOX}       ${interview_type_full_name}
    Click at    ${ADD_INTERVIEW_TYPE_DROPDOWN}
    Wait with short time
    Click at    ${INTERVIEW_TYPE_OPTION}      ${type_interview}
    Input into      ${API_ID_TEXTBOX}       ${api_id_number}
    Click at    ${ADD_BUTTON}
    [Return]     ${interview_type_full_name}

Delete a interview type
    [Arguments]     ${name_interview_type}
    click on strong text    Scheduling
    Scroll to element   ${ADD_TYPE_BUTTON}
    Click at    ${ADD_INTERVIEW_TYPE_EDIT_ICON}        ${name_interview_type}
    Click at    ${ADD_INTERVIEW_TYPE_DELETE_BUTTON}
    Click at    ${ADD_INTERVIEW_TYPE_DELETE_CONFIRM_BUTTON}

Turn on Olivia Recorded Interview toggle
    Click on strong text    Scheduling
    Turn on     ${OLIVIA_RECORDED_INTERVIEW_TOGGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Turn off Olivia Recorded Interview toggle
    Click on strong text    Scheduling
    Turn off    ${OLIVIA_RECORDED_INTERVIEW_TOGGLE}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Select having only 1 sequential interview type in Client Setup
    [Arguments]     ${data_name_interview_type}
    Click on strong text    Scheduling
    wait with short time
    Click at    ${INTERVIEW_TYPE_BUTTON}
    Click by JS    ${INTERVIEW_TYPE_SELECT_ALL_LOCATOR}
    Click by JS    ${INTERVIEW_TYPE_SELECT_ALL_LOCATOR}
    Click by JS    ${INTERVIEW_TYPE}       ${data_name_interview_type}
    Click at    ${INTERVIEW_TYPE_BUTTON}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Select multiples sequential interview type in Client Setup
    [Arguments]     @{list_type_interview}
    Go to Client setup page
    Click on strong text    Scheduling
    Click at    ${INTERVIEW_TYPE_BUTTON}
    Click at    ${INTERVIEW_TYPE_SELECT_ALL_LOCATOR}
    Click at    ${INTERVIEW_TYPE_SELECT_ALL_LOCATOR}
    FOR     ${type_interview}   IN      @{list_type_interview}
            Click at    ${INTERVIEW_TYPE}       ${type_interview}
    END
    Click at    ${INTERVIEW_TYPE_BUTTON}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Add more sequential interview type in Client Setup
    ${sequential_name}=     Generate random name only text      test
    ${api_id_number}=   Generate Random String      4    [NUMBERS]
    Go to Client setup page
    Click on strong text    Scheduling
    Click at    ${ADD_TYPE_BUTTON}
    ${sequential_interview}=    set variable        Sequential_interview_${sequential_name}
    Input into      ${INTERVIEW_NAME_TEXTBOX}    ${sequential_interview}
    Click at    ${ADD_INTERVIEW_TYPE_DROPDOWN}
    Wait with short time
    Click at   ${INTERVIEW_TYPE_OPTION}    Sequential Interview
    Input into      ${API_ID_TEXTBOX}       ${api_id_number}
    Click at    ${ADD_BUTTON}
    [Return]      ${sequential_interview}

Turn off CMS toggle
    Navigate to Option in client setup  Care
    Turn off    ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    Save client setup page

Turn on CMS toggle
    Navigate to Option in client setup  Care
    Turn on    ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    Save client setup page

Select interview type in Client Setup
    [Arguments]     ${interview_type_name}
    Go to Client setup page
    Click on strong text    Scheduling
    Click at    ${INTERVIEW_TYPE_BUTTON}
    Check the checkbox      ${INTERVIEW_TYPE}   ${interview_type_name}
    Click at    ${INTERVIEW_TYPE_BUTTON}
    ${is_changed}=   Run Keyword And Return Status    wait until element is visible   ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword If    ${is_changed}    Click at  ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Turn on Job Search toggle
    [Arguments]  ${env_type}=None   ${search_company}=None
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_JOB_SEARCH_TOGGLE}
    IF   '${env_type}' != 'None'
        Click at    ${JS_ENV_SELECTION}
        Click at    ${JS_ENV_VALUE}    ${env_type}
    END
    IF   '${search_company}' != 'None'
        Click at    ${JS_SEARCH_COMPANY_SELECTION}
        Input into   ${JS_SEARCH_COMPANY_SEARCH_TEXTBOX}   ${search_company}
        Check the checkbox   ${JS_SEARCH_COMPANY_CHECKBOX}    ${search_company}
        Click at    ${JS_SEARCH_COMPANY_APPLY_BUTTON}
    END
    # Choose Company after select JS_ENV
    Save client setup page

Set Manage Scheduling Timelines
    [Arguments]     ${min}      ${max}
    Click at    ${EVENT_ORIENTATION_TIMELINE_MIN}     slow_down=1s
    Click at    ${EVENT_ORIENTATION_TIMELINE_MIN_OPTION}     ${min}
    Click at    ${EVENT_ORIENTATION_TIMELINE_MAX}     slow_down=1s
    Click at    ${EVENT_ORIENTATION_TIMELINE_MAX_OPTION}     ${max}
    Save client setup page

Change cancel Limit Canceling and Rescheduling
    [Arguments]     ${event_type}  ${duration}
    IF    '${event_type}' == 'Virtual Chat Booth'
        Click at    ${EVENT_VIRTUAL_EVENT_SCHED_CANCEL}     slow_down=1s
        Click by JS    ${EVENT_VIRTUAL_EVENT_SCHED_CANCEL_OPTION}       ${duration}
    ELSE IF     '${event_type}' == 'Orientation'
        Click at    ${EVENT_ORIENTATION_EVENT_SCHED_CANCEL}     slow_down=1s
        Click by JS    ${EVENT_ORIENTATION_EVENT_SCHED_CANCEL_OPTION}       ${duration}
    ELSE
        Click at    ${EVENT_GENERAL_EVENT_SCHED_CANCEL}     slow_down=1s
        Click by JS    ${EVENT_GENERAL_EVENT_SCHED_CANCEL_OPTION}       ${duration}
    END
    Save client setup page

Change reschedule Limit Canceling and Rescheduling
    [Arguments]     ${event_type}   ${duration}
    IF     '${event_type}' == 'Orientation'
        Click at    ${EVENT_ORIENTATION_EVENT_SCHED_RESCHEDULE}     slow_down=1s
        Click by JS    ${EVENT_ORIENTATION_EVENT_SCHED_RESCHEDULE_OPTION}       ${duration}
    ELSE
        Click at    ${EVENT_GENERAL_EVENT_SCHED_RESCHEDULE}     slow_down=1s
        Click by JS    ${EVENT_GENERAL_EVENT_SCHED_RESCHEDULE_OPTION}       ${duration}
    END
    Save client setup page

Save client setup page
    ${is_changed} =   Run Keyword And Return Status    Check element display on screen   ${CLIENT_SETUP_SAVE_BUTTON}      wait_time=2s
    IF    ${is_changed}
        Click at  ${CLIENT_SETUP_SAVE_BUTTON}
        wait for page load successfully v1
        run keyword and ignore error   Check element display on screen   ${CLIENT_SETUP_YOUR_CHANGE_SAVED}
        Check element not display on screen   ${CLIENT_SETUP_YOUR_CHANGE_SAVED}
    END

Set Rescheduling Candidate Allowances
    [Arguments]     ${option}   ${event_type}=Hiring Event
    Turn on     ${EVENT_SCHED_RESCHEDULE_ALLOWANCE_ON}
    IF      '${event_type}' != 'Hiring Event'
        Click at   ${EVENT_ORIENTATION_SCHED_RESCHEDULE_ALLOWANCE_SELECT}     slow_down=1s
        Click by JS   ${EVENT_ORIENTATION_SCHED_RESCHEDULE_ALLOWANCE_OPTION}      ${option}
    ELSE
        Click at   ${EVENT_GENERAL_SCHED_RESCHEDULE_ALLOWANCE_SELECT}     slow_down=1s
        Click by JS   ${EVENT_GENERAL_SCHED_RESCHEDULE_ALLOWANCE_OPTION}      ${option}
    END
    Save client setup page

Selct Job feed at Job search section
    [Arguments]     @{list_job_feed}
    Click On Strong Text     Job Search
    Click at    ${JS_SEARCH_COMPANY_SELECTION}
    Click at    ${JS_SEARCH_COMPANY_CHECKBOX}       Select all
    Click at    ${JS_SEARCH_COMPANY_CHECKBOX}       Select all
    FOR     ${job_feed_name}    IN      @{list_job_feed}
        Input into      ${JS_SEARCH_AN_ATS_TEXTBOX}     ${job_feed_name}
        Click at    ${JS_SEARCH_COMPANY_CHECKBOX}       ${job_feed_name}
    END
    Click at    ${JS_SEARCH_COMPANY_APPLY_BUTTON}
    Save client setup page

# === SECTION: JOB SEARCH ===

Turn on Include Remote Jobs toggle
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_INCLUDE_REMOTE_JOBS_TOGGLE}
    Save client setup page

Turn on Job Requisition ID Search
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_JOB_REQ_ID_SEARCH_TOGGLE}
    ${regexp_value} =  Get value and format text  ${JOB_REQ_ID_SEARCH_FIRST_VALUE_TEXTBOX}
    ${is_empty} =  Run keyword and return status   should be equal as strings  ${regexp_value}  ${EMPTY}
    IF   ${is_empty} == True
        Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
        Input into  ${JOB_REQ_ID_SEARCH_FIRST_VALUE_TEXTBOX}  ${REGEX_PATTERN}
        CLick at  ${JOB_REQ_ID_SEARCH_LAST_PATTERN_DROPDOWN}
        CLick at  ${ALPHANUMERIC_SEQUENCE}
        Save client setup page
    END
    Capture page screenshot

Select 'Search Parameters' dropdown
    [Arguments]  ${item}
    Navigate to Option in client setup  Job Search
    Click at  ${JS_SEARCH_PARAMETERS_DROPDOWN}
    Check the checkbox  ${JS_SEARCH_PARAMETERS_SELECT_ALL_ITEM}
    IF   '${item}' == 'Unselect All'
        Uncheck the checkbox  ${JS_SEARCH_PARAMETERS_SELECT_ALL_ITEM}
    ELSE IF  '${item}' != 'Select All'
        Uncheck the checkbox  ${JS_SEARCH_PARAMETERS_SELECT_ALL_ITEM}
        Check the checkbox  ${JS_SEARCH_PARAMETERS_ITEM}  ${item}
    END
    Save client setup page
    Capture page screenshot

Turn on Set Default Job Search Parameter and set parameter
    [Arguments]  ${attribute}=${JOB_COUNTRY}    ${value}=${UNITED_STATES}
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_SET_DEFAULT_PARAMETER_TOGGLE}
    ${check_var} =  Run keyword and return status  Check element display on screen  ${DEFAULT_PARAMETER_VALUE_LABEL}    ${value}    wait_time=5s
    IF   ${check_var} == False
        Click at  ${DEFAULT_PARAMETER_ATTRIBUTE_DROPDOWN}
        #   when click at dropdown, it immediately click on item(cause by locator has on root, but UI doesn't show yet)
        Click at  ${DEFAULT_PARAMETER_ATTRIBUTE_ITEM}   ${attribute}    slow_down=1s
        Input into  ${DEFAULT_PARAMETER_VALUE_TEXTBOX}  ${UNITED_STATES}
        Save client setup page
    END
    Capture page screenshot

Turn on Chat to apply and select convo for catch all convo
    [Arguments]   ${convo_name}=single_path_priority_location
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_CHAT_TO_APPLY_TOGGLE}
    Turn on    ${CHAT_TO_APPLY_CATCH_ALL_CONVO_TOGGLE}
    ${convo_exist} =   Run keyword and return status    Check element display on screen  ${CHAT_TO_APPLY_SELECT_CONVERSATION_DROPDOWN}
    IF   ${convo_exist}
        Turn off    ${CHAT_TO_APPLY_CATCH_ALL_CONVO_TOGGLE}
        Save client setup page
        Add Single(priority location) conversation    ${convo_name}    email_needed=True
        Navigate to Option in client setup  Job Search
        Turn on    ${CHAT_TO_APPLY_CATCH_ALL_CONVO_TOGGLE}
        Save client setup page
        Click at   ${CHAT_TO_APPLY_SELECT_CONVERSATION}
        Input into   ${CHAT_TO_APPLY_SEARCH_CONVERSATION_TEXTBOX}   ${convo_name}
        Click at   ${CHAT_TO_APPLY_SEARCH_CONVERSATION_ITEM}    ${convo_name}
    END
    Save client setup page

Turn on Candidate Type(internal/external)
    Navigate to Option in client setup  Job Search
    Turn on  ${JS_CANDIDATE_TYPE_TOGGLE}
    Save client setup page
    Capture page screenshot

Turn on Geographic Targeting and select Country
    [Arguments]   ${country_name}
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_JOB_SEARCH_TOGGLE}
    Turn on    ${JS_GEOGRAPHIC_TARGETING_TOGGLE}
    Input into  ${GEOGRAPHIC_TARGETING_SEARCH_TEXTBOX}   ${country_name}
    Click at   ${GEOGRAPHIC_TARGETING_COUNTRY_ITEM}   ${country_name}
    Save client setup page
    Capture page screenshot

# === SECTION: CARE ===

Turn on Candidate Care
    Navigate to Option in client setup  Care
    Turn on  ${CANDIDATE_CARE_TOGGLE}
    Save client setup page
    Capture page screenshot

# === SECTION: CAPTURE ===

Select Multi Application type in client setup
    [Arguments]   ${days_amount}    ${verified_type}=No verification required
    Navigate to Option in client setup  Capture
    Click at  ${MULTI_APPLICANTION_SELECT_DAYS_DROPDOWN}
    Click at  ${MULTI_APPLICANTION_SELECT_DAYS_ITEM}    ${days_amount}
    Click at  ${MULTI_APPLICANTION_VERIFY_CODE_DROPDOWN}
    Click at  ${MULTI_APPLICANTION_VERIFY_CODE_ITEM}    ${verified_type}
    Save client setup page
    Capture page screenshot

# === SECTION: HIRE ===

Turn on ATS and select feed
    Navigate to Option in client setup  Hire
    Turn on   ${OLIVIA_HIRE_TOGGLE}
    Turn on   ${HIRE_ATS_JOB_FEED_MANAGER_TOGGLE}
    ${is_exist} =  Run keyword and return status   Check element display on screen  ${ATS_EDIT_BUTTON}  wait_time=5s
    IF  not ${is_exist}
    #   Configure feed
        Click at   ${ATS_CONFIGURE_BUTTON}
        Click at   ${CONFIGURE_ATS_SELECT_FEED_DROPDOWN}
        Input into  ${CONFIGURE_ATS_SELECT_FEED_SEARCH_TEXTBOX}  ${AUTOMATION_FEED_PROD}
        Click at   ${CONFIGURE_ATS_SELECT_FEED_ITEM}  ${AUTOMATION_FEED_PROD}
        Click at   ${CONFIGURE_ATS_SELECT_FEED_APPLY_BUTTON}
        #   Set condition
        Click at   ${CONFIGURE_ATS_CONDITION_THEN_DROPDOWN}
        Click at   ${CONFIGURE_ATS_CONDITION_THEN_ITEM}   ON
        Click at   ${CONFIGURE_ATS_CONDITION_SAVE_BUTTON}
        #   Save and confirm
        Click at   ${CONFIGURE_ATS_SAVE_BUTTON}
        Click at   ${ATS_CONFIRM_FEED_CONTINUE_BUTTON}
        #   Wait message added successfully close
        Check element display on screen  ${HIRE_ATS_SAVING_STATUS}  ${MY_JOB_SUCCESSFULLY_ADDED}
    #   Select feed
        Click at   ${ATS_SELECT_FEED_DROPDOWN}
        Input into  ${ATS_SELECT_FEED_SEARCH_TEXTBOX}  ${AUTOMATION_FEED_PROD}
        Click at   ${ATS_SELECT_FEED_ITEM}  ${AUTOMATION_FEED_PROD}
        Click at   ${ATS_SELECT_FEED_APPLY_BUTTON}
        Click at   ${ATS_SELECT_FEED_CONTINUE_BUTTON}
        #   Wait message added successfully close
        Check element display on screen  ${HIRE_ATS_SAVING_STATUS}  ${MASTER_FEED_SUCCESSFULLY_ADDED}
    END
    Save client setup page
    Capture page screenshot

Turn on Candidate Journey and Applicant Flow
    Navigate to Option in client setup  Hire
    Turn on  ${CANDIDATE_JOURNEYS_TOGGLE}
    Turn on  ${HIRE_APPLICANT_FLOW_TOGGLE}
    Save client setup page
    Capture page screenshot

Turn on/off Chat to Apply of Event Job tab
    [Arguments]    ${type}
    IF  '${type}' == 'On'
        Go to Client setup page
        Click at        ${EVENTS_LABEL}
        Turn on     ${EVENT_JOB_TRIGGER_ON}
        Save client setup page
    ELSE
        Go to Client setup page
        Click at        ${EVENTS_LABEL}
        Turn off     ${EVENT_JOB_TRIGGER_ON}
        Save client setup page
    END

Turn on/off Campus Approval of Campus tab
    [Arguments]     ${type}
    Navigate to Option in client setup      Campus
    IF  '${type}' == 'On'
        Turn on     ${CLIENT_SETUP_CAMPUS_APPROVALS_TOGGLE_ON_OFF}
    ELSE
        Turn off     ${CLIENT_SETUP_CAMPUS_APPROVALS_TOGGLE_ON_OFF}
    END
    Save client setup page

# === SECTION: MORE ===

Turn on/off Allow users to manage receiving workflow alerts Toggle
    [Arguments]    ${type}
    Navigate to Option in client setup    More
    Turn on  ${WORKFLOWS_TOGGLE}
    IF  '${type}' == 'On'
        Turn on  ${ALLOW_USERS_MANAGE_RECEIVING_WORKFLOW_ALERTS_TOGGLE}
    ELSE
        Turn off  ${ALLOW_USERS_MANAGE_RECEIVING_WORKFLOW_ALERTS_TOGGLE}
    END
    Save Client Setup Page

Revert to default config on More tag for Candidate Profile Option
    Navigate To Option In Client Setup    More
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN}
    Run Keyword And Ignore Error    Check The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Select all
    Run Keyword And Ignore Error    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON}
    Run Keyword And Ignore Error    Click At    ${CLIENT_SETUP_SAVE_BUTTON}
    Run Keyword And Ignore Error    wait for page load successfully v1
    Capture Page Screenshot

Check the items displayed or disabled in Candidate Profile dropdown in Client setup
    [Arguments]    ${list_candidate_profile_options}    ${list_items_disabled}=${None}
    # Check items are able to check
    FOR     ${option}   IN    @{list_candidate_profile_options}
        Check Element Display On Screen    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}      ${option}
    END
    # Check items is disable
    IF  ${list_items_disabled} != ${None}
        FOR    ${option_disabled}   IN     @{list_items_disabled}
            Verify element is disabled by checking class    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_DISABLED}   ${option_disabled}
        END
    END

Turn on/off multi branding Toggle
    [Arguments]    ${type}
    Go to Client setup page
    Click At    ${ACCOUNT_OVERVIEW_LABEL}
    Scroll to element    ${CLIENT_SETUP_CAMPUS_MULTI_BRANDING_TOGGLE}
    IF  '${type}' == 'On'
        Turn on    ${CLIENT_SETUP_CAMPUS_MULTI_BRANDING_TOGGLE}
    ELSE
        Turn off     ${CLIENT_SETUP_CAMPUS_MULTI_BRANDING_TOGGLE}
    END
    Save client setup page

Turn on AI Resume Matching
    Navigate to Option in client setup    More
    Turn on  ${MORE_AI_RESUME_MATCHING_TOGGLE}
    Save client setup page
    Capture page screenshot

Turn on tax withholding toggle
    Navigate to Option in client setup    Hire
    Turn on     ${OLIVIA_HIRE_TOGGLE}
    Turn on     ${CLIENT_SETUP_FORM_TOGGLE}
    Turn on     ${HIRE_TAX_WITHHOLDING_TOGGLE}
    Save client setup page

Turn on next steps in client setup page
    Navigate to Option in client setup    Candidate Journeys
    Turn on     ${CLIENT_SETUP_CANDIDATE_JOURNEYS_TOGGLE}
    Turn on     ${CLIENT_SETUP_NEXT_STEPS_TOGGLE}
    Save client setup page

Select Available Job Types
    [Arguments]     ${job_type}=All
    Turn on     ${JOBS_TOGGLE}
    Click at    ${AVAILABLE_JOB_TYPES_DROPDOWN}
    IF  '${job_type}' != 'All'
        Click at    ${CLIENT_SETUP_JOB_TYPE}    ${job_type}
    ELSE
        Click at    ${AVAILABLE_JOB_SELECT_ALL_CHECKBOX}
    END
    Click at    ${AVAILABLE_JOB_APPLY_BUTTON}
