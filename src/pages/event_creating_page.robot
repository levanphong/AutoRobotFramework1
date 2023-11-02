*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/event_page.robot
Variables       ../locators/event_locators.py

*** Variables ***
${start_time}       09:00 AM
${end_time}         05:00 PM
${orientation}      Orientation
${planned_price}    19

*** Keywords ***
click on Create New Event button
    Click at    ${MODAL_CREATE_NEW_EVENT}   slow_down=1s

click on Hiring Event type
    Click at    ${MODAL_HIRING_EVENT}

click on Create Activity button
    Click at    ${CREATE_ACTIVITY}
    wait for page load successfully v1

click on Next Button
    Click at    ${MODAL_BUTTON_NEXT}

click on create event button
    Click at    ${MODAL_BUTTON_CREATE_EVENT}
    wait for page load successfully v1

click on occurrence type
    Scroll to element    ${DATE_TIME_TYPE}
    Click at    ${DATE_TIME_TYPE}

click on Event type
    Click at    ${EVENT_REPORTING_CATEGORY_DROPDOWN}

click on Hiring type
    Click at    ${EVENT_HIRING_TYPE}

click on next button event modal
    Scroll to element    ${NEXT_BUTTON_EVENT}
    Click at    ${NEXT_BUTTON_EVENT}

Drag & drop over a time on calendar block
    run keyword and ignore error    mouse over    ${SCHEDULE_AVAILABLE_TIME}
    Scroll to element    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    mouse up    ${SCHEDULE_AVAILABLE_TIME}
    wait for page load successfully v1
    sleep    1s

Fill all infor overview venue
    [Arguments]    ${event_type}    ${event_venue_type}    ${event_occurrence}
    click on Create New Event button
    wait for page load successfully v1
    Set Event type    ${event_type}
    click on Next Button
    ${is_event_venue_type_default} =    Set Event Venue Type    ${event_venue_type}
    click on Next Button
    Set Overview step    ${is_event_venue_type_default}    ${event_occurrence}
    click on next button event modal

Go to schedule tab with event type
    [Arguments]    ${event_type}    ${event_venue_type}    ${event_occurrence}
    Go to Events page
    Fill all infor overview venue    ${event_type}    ${event_venue_type}    ${event_occurrence}
    wait for page load successfully v1

Set event description
    [Arguments]    ${text}
    Input into    ${DESCRIPTION_EVENT_SESSION}    ${text}
    Click at    ${SAVE_SESSION_NAME}

click on session created and navigate to session detail
    sleep    1s
    Click at    ${SESSION_EVENT_ROW}
    Click at    ${ICON_EDIT_SESSION_EVENT_ROW}

check description has 320 characters
    sleep    1s
    Scroll to element    ${DESCRIPTION_EVENT_SESSION}
    ${LENG_DESCRIPTION} =    get value    ${DESCRIPTION_EVENT_SESSION}
    length should be    ${LENG_DESCRIPTION}    320

Check Disable the creation of Virtual Chat Booths
    ${is_disabled} =    Run keyword and return status   Click at  ${VIRTUAL_CHAT_BOOTH_LABEL}
    Should be equal as strings  ${is_disabled}  False

Drag & drop over a time on calendar on second block
    Scroll to element    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    run keyword and ignore error    mouse over    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    mouse up    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    wait for page load successfully v1
    sleep    1s

input event name
    ${event_name} =    Generate random name    auto_event
    Input into    ${EVENT_NAME_INPUT}    ${event_name}
    [Return]    ${event_name}

Set session interview type
    [Arguments]    ${session_interview_type}
    Click at    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Click at    ${EVENT_INTERVIEW_DROPDOWN_OPTION}    ${session_interview_type}

#---------- Create new Event flow -------------

Set Event type
    [Arguments]    ${event_type}
    ${return_status} =    Set Variable
    Click on p text    ${event_type}
    IF    '${event_type}' == 'Hiring Event'
        ${return_status} =    Set Variable    is_default
    ELSE IF     '${event_type}' == 'Event Templates'
        click on first template event
    END
    [Return]    ${return_status}

Set Event Venue Type
    [Arguments]    ${event_venue_type}
    Click on p text    ${event_venue_type}

Set Event Venue Type in dropdown
    [Arguments]    ${event_venue_type}
    Click at    ${EVENT_VENUE_DROPDOWN}
    Click at    ${DROPDOWN_OPTION}    ${event_venue_type}

Set Overview step
    [Arguments]    ${event_venue_type}    ${event_occurrence}       ${event_name}=None
    Click at    ${OVERVIEW_STEP_LABEL}
    IF  '${event_name}' == 'None'
        ${event_dynamic} =    input event name
    ELSE
        ${event_dynamic} =      Set Variable    ${event_name}
        Input into    ${EVENT_NAME_INPUT}    ${event_dynamic}
    END
    # Select Event venue for Orientation Event
    ${is_event_venue_visible} =    Run Keyword And Return Status    Check element display on screen    ${EVENT_VENUE_DROPDOWN}  wait_time=2s
    IF    '${is_event_venue_visible}' == 'True'
        Set Event Venue Type in dropdown    ${event_venue_type}
    END
    # Select common information
    IF    '${event_venue_type}' == 'In Person'
        Input into    ${VENUE_LOCATION_TEXTBOX}    Venue test location
        Press Keys    ${VENUE_LOCATION_TEXTBOX}    TAB
        Wait with short time
        Input into    ${VENUE_NAME_TEXTBOX}    Venue test name
    END
    Set event occurrence    ${event_occurrence}
    [Return]    ${event_dynamic}

Set Overview step with future time
    [Arguments]    ${event_venue_type}    ${event_occurrence}
    ${event_dynamic}=   Set Overview step   ${event_venue_type}    ${event_occurrence}
    Choose next day for start date
    Choose next day for end date
    Choose future time for start date   ${start_time}
    Choose future time for end date     ${end_time}
    [Return]    ${event_dynamic}

Turn on campus and select school
    [Arguments]    ${school_name}
    Click at    ${OVERVIEW_STEP_LABEL}
    Turn on    ${CAMPUS_CARE_TOGGLE}
    Click at    ${INPUT_SELECT_SCHOOL_NAME}
    Click at    ${school_name}

Set Jobs Step
    [Arguments]    ${job_req_id}=None
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${ADD_JOB_BUTTON}
    IF    '${job_req_id}' == 'None'
        Click at    ${FIRST_JOB_CHECKBOX}
    ELSE
        Select job requisitions show type   Show all requisitions
        Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   ${job_req_id}
        Wait for page load successfully
        Click at    ${EVENT_JOB_CHECKBOX}    ${job_req_id}
    END
    Click at    ${CONFIRM_ADD_JOB_BUTTON}

Select job requisitions show type
    [Arguments]    ${show_type}
     ${is_displayed} =    Run Keyword And Return Status    Check element display on screen    ${EVENT_ADD_JOB_REQ_SHOW_TYPE_TEXT_BOX}  wait_time=2s
     IF  '${is_displayed}' == 'True'
        Click at    ${EVENT_ADD_JOB_REQ_SHOW_TYPE_TEXT_BOX}
        Click at    ${EVENT_ADD_JOB_REQ_SHOW_TYPE_OPTION}   ${show_type}
     END

Set Team step
    [Arguments]    ${team_user_name}    ${team_user_role}=None
    Click at    ${TEAM_STEP_LABEL}
    Click at    ${TEAM_EVENT_MEMBER}
    Input into    ${TEAM_EVENT_MEMBER}      ${team_user_name}
    Click by JS    ${TEAM_EVENT_MEMBER_CHECKBOX}    ${team_user_name}
    Click at    ${ADD_TEAM_MEMBER_BUTTON}
    IF  '${team_user_role}' != 'None'
        Click at  ${EVENT_CREATOR_TEAM_ROLE_DROPDOWN}  ${team_user_name}
        Click at  ${EVENT_CREATOR_TEAM_ROLE_DROPDOWN_VALUE}  ${team_user_role}
    END

Set Team step with multiple users
    [Arguments]     @{list_users}
     FOR     ${value}    IN      @{list_users}
        Set Team step        ${value}
     END

Set Schedule step
    [Arguments]    ${session_type}=None    ${session_venue}=None
    &{session_info} =    Create Dictionary
    Click at    ${SCHEDULE_STEP_LABEL}
    IF    '${session_type}' == 'None'
        ${session_name}=    Generate random name  event_session
        Select Event session available time
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        IF    '${session_venue}' != 'None'
            Set session venue type    ${session_venue}
        END
        ${session_info.session_name} =    Set Variable    ${session_name}
    ELSE
        &{session_info} =    Set session schedule    ${session_type}
    END
    click save session button
    [Return]    &{session_info}

Set Registration step
    [Arguments]    ${end_time}=None    ${number_of_candidates}=None    ${conversation_name}=None
    Click at    ${REGISTRATION_STEP_LABEL}
    ${is_cb_type_visible} =    Run Keyword And Return Status    Check element display on screen    ${CONVERSATION_CB_TYPE}  wait_time=2s
    IF  ${is_cb_type_visible}
        Select conversation for Event    ${conversation_name}
    END
    IF    '${end_time}' != 'None'
        Click at    ${CLOSE_REGISTRATION_TYPE_DROPDOWN}
        Click at    ${end_time}
    END
    IF    '${number_of_candidates}' != 'None'
        Click at    ${NUMBER_OF_CANDIDATES_DROPDOWN}
        Click at    Set specific number
        Input into    ${SPECIFIC_NUMBER_OF_CANDIDATES_TEXTBOX}    ${number_of_candidates}
        Click at    ${NUMBER_OF_CANDIDATES_APPLY_BTN}
    END

Set Registration step with custom conversation
    [Arguments]    ${conversation_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Click at    ${CONVERSATION_CB_TYPE}
    Click by JS    ${DROPDOWN_OPTION}    ${conversation_name}

Set Tools step
    Set landing page
    Wait with medium time
    Click create event button

# Register the Event flow

Complete register the event
    [Arguments]    ${candidate_name}    ${candidate_mobile}
    ${event_register_link} =    go to event register page
    Finish register the event    ${candidate_name}    ${candidate_mobile}
    close browser
    Open Chrome
    go to    ${event_register_link}

Finish register the event
    [Arguments]    ${candidate_name}=None    ${candidate_mobile}=${CONST_PHONE_NUMBER}
    IF    '${candidate_name}' == 'None'
        ${candidate_fname} =    Generate random text only
        ${candidate_name} =    Set variable    ${candidate_fname} Auto
    ELSE
        ${candidate_fname} =    Evaluate    "${candidate_name}".split(" ")[0]
    END
    &{email_info} =    Get email for testing
    Click at    ${EVENT_STATUS}
    Wait with large time
    Input candidate name twice for Shadow Root    ${candidate_name}
    Input text for widget site    ${candidate_mobile}
    Input text for widget site    ${email_info.email}
    Run keyword and ignore error    Click on option in conversation    Email Only
    ${calendar_time_visibled} =    Run Keyword And Return Status    wait until element is visible
    ...    ${CHOOSE_INTERVIEW_TIME}    20s
    IF    ${calendar_time_visibled}
        run keyword and ignore error    Click at    ${CALENDAR_TIME_PICKER}
    END
    IF    ${calendar_time_visibled}
        run keyword and ignore error    Input into    ${INPUT_TEXTBOX}    1
    END
    IF    ${calendar_time_visibled}
        run keyword and ignore error    Click at    ${SEND_BUTTON_CONV}
    END
    Click at    ${SEND_BUTTON_CONV}
    Wait with medium time
    wait until element is visible    ${EVENT_STATUS_DISABLED}    10s
    [Return]    ${candidate_fname}

Go to event register page
    wait until element is visible    ${EVENT_LANDING_PAGE_URL}    10s
    ${event_register_link} =    get text    ${EVENT_LANDING_PAGE_URL}
    go to    ${event_register_link}
    Wait with medium time
    [Return]    ${event_register_link}

Go to upcoming event site
    wait until element is visible    ${EVENT_UPCOMING_SITE_URL}    5s
    ${event_upcoming_site_link} =    get text    ${EVENT_UPCOMING_SITE_URL}
    go to    ${event_upcoming_site_link}
    Wait with medium time
    [Return]    ${event_upcoming_site_link}

Set session schedule
    [Arguments]    ${session_type}
    ${session_name}=    Generate random name  event_session
    Run keyword and ignore error    Click at    ${SCHEDULE_STEP_LABEL}
    &{session_info} =    Create Dictionary
    Select Event session available time
    IF    '${session_type}' == 'Virtual Chat Booth'
        Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
        Input into    ${SESSION_NAME_TEXTBOX}    virtual_chat_booth_test
        ${session_info.session_name} =    Set Variable    virtual_chat_booth_test
        ${session_info.start_time} =    Get Text    ${START_TIME_TXT}
        ${session_info.end_time} =    Get Text    ${END_TIME_TXT}
    ELSE IF    '${session_type}' == 'Scheduled Interviews'
        Click at    ${SCHEDULED_INTERVIEWS_LABEL}
        Input into    ${SESSION_NAME_TEXTBOX}    in_person_scheduled_interviews_test
        Set session interview type    In-person interview
        Set Interview Time Slot Per Duration
        ${session_info.session_name} =    Set Variable    in_person_scheduled_interviews_test
        ${session_info.start_time} =    Get Text    ${START_TIME_TXT}
        ${session_info.end_time} =    Get Text    ${END_TIME_TXT}
        ${session_info.interview_duration} =    Get Text    ${INTERVIEW_DURATION_DROPDOWN}
        ${session_info.interview_type} =    Get Text    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    ELSE IF    '${session_type}' == 'Event Session'
        Click at    ${EVENT_SESSION_CREATED}
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Set session interview type    Virtual
        Input into    ${SESSION_URL_TEXTBOX}    https://robotframework.org/
        Input into    ${SESSION_URL_PASS_TEXTBOX}    this_is_the_password
        ${session_info.session_name} =    Set Variable    ${session_name}
        ${session_info.start_time} =    Get Text    ${START_TIME_TXT}
        ${session_info.end_time} =    Get Text    ${END_TIME_TXT}
        ${session_info.description} =    Get Text    ${DESCRIPTION_EVENT_SESSION}
    ELSE IF    '${session_type}' == 'Virtual Scheduled Interviews'
        Click at    ${VT_INTERVIEW_SCHEDULE}
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Set session interview type    Phone interview
        Set Interview Time Slot Per Duration
        ${session_info.session_name} =    Set Variable    ${session_name}
    ELSE IF    '${session_type}' == 'Live Video Broadcast'
        Click at    ${LIVE_VIDEO_BROADCAST_LABEL}
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Input into    ${SESSION_URL_TEXTBOX}    https://robotframework.org/
        Input into    ${SESSION_URL_PASS_TEXTBOX}    this_is_the_password
        ${session_info.session_name} =    Set Variable    ${session_name}
        ${session_info.session_type} =    Set Variable    ${session_type}
        ${session_info.start_time} =    Get Text    ${START_TIME_TXT}
        ${session_info.end_time} =    Get Text    ${END_TIME_TXT}
    END
    [Return]    &{session_info}

Set session schedule with interviewer
    [Arguments]    ${session_type}       ${interviewer}     ${assign_interviewer_type}=None     ${interview_time_slot}=1 Interview Time Slot
    ${session_name}=    Generate random name  event_session
    Run keyword and ignore error    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    IF    '${session_type}' == 'Virtual Scheduled Interviews'
        Click at    ${VT_INTERVIEW_SCHEDULE}
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update end time for session     ${end_time}
        Set Interview Time Slot Per Duration    ${interview_time_slot}
        IF  '${interviewer}' != 'None'
            Add interviewer for session     ${interviewer}
            IF  '${assign_interviewer_type}' == 'None'
                Select setting interviewer      Manually Assign Interviewers
            ELSE
                Select setting interviewer      ${assign_interviewer_type}
            END
        END
    ELSE IF    '${session_type}' == 'Scheduled Interviews'
        Click at    ${SCHEDULED_INTERVIEWS_LABEL}
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update end time for session     ${end_time}
        Set Interview Time Slot Per Duration    ${interview_time_slot}
        IF  '${interviewer}' != 'None'
            Add interviewer for session     ${interviewer}
            IF  '${assign_interviewer_type}' == 'None'
                Select setting interviewer      Manually Assign Interviewers
            ELSE
                Select setting interviewer      ${assign_interviewer_type}
            END
        END
    END
    click save session button
    [Return]    ${session_name}

Add interviewer for session
    [Arguments]     ${interviewer}
    Click at        ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    Check element display on screen     ${EVENT_ADD_INTERVIEWER_CANCEL_BUTTON}
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${interviewer}
    Click by JS     ${EVENT_INTERVIEWER_CHECKBOX}   ${interviewer}
    Click at        ${ADD_TO_SESSION_BUTTON}

Select setting interviewer
    [Arguments]         ${interviewer_setting}
    Scroll to element by JS     ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    Click by JS            ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    Click by JS        ${EVENT_INTERVIEW_DROPDOWN_OPTION}   ${interviewer_setting}

click save session button
    Click at    ${SAVE_SESSION_NAME}

Select conversation for Event
    [Arguments]    ${conversation_name}=None
    Click at    ${CONVERSATION_CB_TYPE}
    IF    '${conversation_name}' == 'None'
        Click at    ${DROPDOWN_FIRST_OPTION}
    ELSE
        Click by JS    ${DROPDOWN_OPTION}     ${conversation_name}
    END

Set landing page
    Click at    ${TOOLS_STEP_LABEL}
    Wait with short time
    ${is_landing_page_visible} =    Run Keyword And Return Status    Check element display on screen    ${LANDING_PAGE}     wait_time=2s
    IF    '${is_landing_page_visible}' == 'True'
        Click at    ${LANDING_PAGE}
        Input into    ${DESCRIPTION_LADING_PAGE}    hello Landing page
        ${path_image} =    get_path_upload_image_path    cat-kute
        ${element} =    Get Webelement    ${INPUT_UPLOAD_FILE}
        EXECUTE JAVASCRIPT
        ...    arguments[0].setAttribute('class', '');
        ...    ARGUMENTS    ${element}
        Input into    ${INPUT_UPLOAD_FILE}    ${path_image}
        wait until element is enabled    ${ADD_IMAGE_CONFIRM_BUTTON}
        Click at    ${ADD_IMAGE_CONFIRM_BUTTON}
        Wait with medium time
        Scroll to element    ${SAVE_LANDING_PAGE}
        Wait with medium time
        Click at    ${SAVE_LANDING_PAGE}    slow_down=2s
    END

Click create event button
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    ${is_confirm}=  Run keyword and return status       Check element display on screen    ${CONFIRM_AND_SAVE_BUTTON}   wait_time=2s
    IF      '${is_confirm}' == 'True'
        Click at        ${CONFIRM_AND_SAVE_BUTTON}
    END
    wait for page load successfully

Set recurring rule step
    [Arguments]     ${frequency}
    ${date}=    get_future_day_from_curent_date
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${DATE_RECURRING_RULE}    ${date}
    Set frequency for recurring event       ${frequency}
    Click at    ${SAVE_BUTTON_RECURRING}
    wait with short time
    ${selected_event_day}=     get element count       ${SELECTED_EVENT_DAYS}
    [Return]    ${selected_event_day}

Set tool step and create event
    Click at    ${TOOLS_STEP_LABEL}
    Click create event button

Set Summary step and create event
    Click at    ${SUMMARY_TAB}
    Click create event button

#---------- END Create new Event flow -------------

Set event occurrence
    [Arguments]    ${occurrence_type}
    Click at    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    Click at    ${DROPDOWN_OPTION}    ${occurrence_type}    0.5s

choose next day for occuracy type
    Choose next day for start date
    run keyword and ignore error    Click at    ${UPDATE_EVENT_BUTTON}
    Click at    ${OVERVIEW_LABEL}

Choose event start date
    [Arguments]    ${date}
    ${start_date} =    get_date_with_month_in_full_string    ${date}
    Click by JS    ${EVENT_START_DATE}
    Click by JS    ${EVENT_CREATE_START_DATE_PICKER}    ${start_date}
    [Return]    ${start_date}

Choose next day for start date
    ${next_date} =    get_date_with_month_in_full_string    1
    Click by JS    ${EVENT_START_DATE}     slow_down=1s
    Click by JS    ${EVENT_CREATE_START_DATE_PICKER}    ${next_date}
    [Return]    ${next_date}

Choose next day for end date
    ${next_date} =    get_date_with_month_in_full_string    1
    Click by JS    ${EVENT_END_DATE}       slow_down=1s
    Click by JS    ${EVENT_CREATE_END_DATE_PICKER}     ${next_date}
    [Return]    ${next_date}

Set session venue type
    [Arguments]    ${session_venue}
    Click at    ${SESSION_VENUE_DROPDOWN}
    Click at    ${DROPDOWN_OPTION}    ${session_venue}

Event created successfully
    [Arguments]    ${event_name}
    Check element display on screen    Dashboard
    Check span display    ${event_name}
    Go to Events page
    Input into  ${SEARCHING_INPUT}  ${event_name}
    Check element display on screen    ${event_name}

Edit Event warning popup is displayed
    Check span display    Edit Event
    Check p text display  There are sessions outside of your selected event start and end times. This update will delete any sessions outside of your start and end times. Are you sure you want to make this update?
    Check element display on screen    ${CANCEL_DIALOG_BUTTON}
    Check element display on screen    ${UPDATE_EVENT_BUTTON}
    Click at    ${UPDATE_EVENT_BUTTON}
    Check span display    Changes made affect pre-existing sessions.

Set Interview Time Slot Per Duration
    [Arguments]    ${interview_time_slot}=1 Interview Time Slot  ${interviewer_duration}=None
    IF  '${interviewer_duration}' != 'None'
        Click at    ${INTERVIEW_DURATION_DROPDOWN}
        Click on span text  ${interviewer_duration}
        Click on common text last   Apply
    END
    Click by JS    ${INTERVIEW_TIME_SLOT_DROPDOWN}
    Click on span text  ${interview_time_slot}

Set Virtual session
    Click at    ${VT_INTERVIEW_SCHEDULE}
    Input into    ${SESSION_NAME_TEXTBOX}    vt_schedule_session_test
    Set session interview type    Phone interview
    Set Interview Time Slot Per Duration
    click save session button

Set session staff
    [Arguments]             ${user}
    Check element display on screen    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    Click by JS        ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    input into              ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${user}
    Click at                ${EVENT_INTERVIEWER_CHECKBOX}  ${user}
    Click at                ${ADD_TO_SESSION_BUTTON}

Select Event session available time
    ${is_selected} =    Run keyword and return status   Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_1}
    IF  '${is_selected}' == 'False'
        ${is_selected} =    Run keyword and return status   Click at  ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
        Run Keyword If      '${is_selected}' == 'False'    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_3}
    END

Set frequency for recurring event
    [Arguments]     ${frequency}
    Click at        ${FREQUENCY_DROPDOWN}
    Click at        ${DROPDOWN_OPTION}      ${frequency}

Set first date occurence for recurring event
    [Arguments]     ${date_from_current_date}
    wait with short time
    Click at        ${START_DATE_FIRST_OCCURRENCE_DROPDOWN}
    ${date}=        get_future_day_from_curent_date     ${date_from_current_date}
    Click at     ${DATE_FIRST_OCCURRENCE}     ${date}    1s
    #Click to save
    Click at    Edit Event(s)    slow_down=1s
    [Return]        ${date}

Set end date occurence for recurring event
    [Arguments]     ${date_from_current_date}
    wait with short time
    Click at        ${END_DATE_FIRST_OCCURRENCE_DROPDOWN}
    ${date}=        get_future_day_from_curent_date     ${date_from_current_date}
    Click at     ${END_DATE_FIRST_OCCURRENCE}     ${date}    1s
    #Click to save
    Click at    Edit Event(s)   slow_down=1s
    [Return]        ${date}

Set end of recurring event
    [Arguments]     ${date_from_current_date}
    wait with short time
    Click at        ${END_OF_RECURRING_EVENT_DROPDOWN}
    ${date}=        get_future_day_from_curent_date     ${date_from_current_date}
    Click at       ${END_OF_RECURRING_EVENT}    ${date}     1s
    #Click to save
    Click at    Edit Event(s)   slow_down=1s
    [Return]        ${date}

Edit start date occurence for recurring event
    [Arguments]     ${date_from_current_date}
    wait with short time
    Click at        ${START_DATE_OCCURRENCE_DROPDOWN}
    ${date}=        get_future_day_from_curent_date     ${date_from_current_date}
    Click at        ${DATE_FIRST_OCCURRENCE}     ${date}    1s
    ${date_time}=   Get attribute and format text     aria-label    ${DATE_FIRST_OCCURRENCE}     ${date}
    #Click to save
    Click at    Event Details    slow_down=1s
    Click at    ${SAVE_BUTTON_EDIT_OCCURRENCE}
    [Return]        ${date_time}

Edit recurring rule step
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    Set first date occurence for recurring event    2
    Set end date occurence for recurring event      2
    Set end of recurring event                      10
    Click at    ${SAVE_BUTTON_RECURRING}

Update session step
    [Arguments]     ${session_name}=test_session    ${start_time}=None
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${UPDATE_SESSIONS_BUTTON}
    wait with short time
    Click on span text    Edit Event Sessions
    Click at    ${SESSION_NAME_IN_WARNING_POPUP}    ${session_name}
    Input into  ${SESSION_NAME_TEXTBOX}   test_session_edited
    ${is_update_time}=  Run keyword and return status   Check span display   Start time must be after event start time
    IF  '${is_update_time}' == 'True'
        Update start time for session
        Update end time for session
    END
    click save session button

Set school name
    [Arguments]     ${school_name}
    Click at        ${SCHOOL_NAME_DROPDOWN}
    Click at        ${DROPDOWN_OPTION}      ${school_name}

Choose future time for start date
    [Arguments]     ${time}=None
    IF  '${time}' == 'None'
        ${time}=    get_future_time_from_current_date
    END
    Click at    ${EVENT_START_TIME}     slow_down=1s
    Click by JS    ${EVENT_START_TIME_OPTION}    ${time}
    [Return]    ${time}

Choose future time for end date
    [Arguments]     ${time}=None
    IF  '${time}' == 'None'
        ${time} =   get_future_time_from_current_date      2
    END
    Click at    ${EVENT_END_TIME}       slow_down=1s
    Click by JS    ${EVENT_END_TIME_OPTION}    ${time}
    [Return]    ${time}

Update start date for session
    [Arguments]     ${time}=None
    IF  '${time}' == 'None'
        ${time} =   get_future_time_from_current_date
    END
    Click at    ${EVENT_ADD_SETTING_DROPDOWN}       slow_down=1s
    Click by JS    ${DROPDOWN_OPTION}    ${time}
    [Return]    ${time}

Update start time for session
    [Arguments]     ${time}=None
    IF  '${time}' == 'None'
        ${time} =   get_future_time_from_current_date
    END
    Click at    ${START_TIME_TXT}       slow_down=1s
    Click by JS    ${EVENT_START_TIME_OPTION}    ${time}
    [Return]    ${time}

Update end time for session
    [Arguments]     ${time}=None
    IF  '${time}' == 'None'
        ${time} =   get_future_time_from_current_date      2
    END
    Click at    ${END_TIME_TXT}     slow_down=1s
    Click by JS    ${EVENT_END_TIME_OPTION}    ${time}
    [Return]    ${time}

Update name for session
     ${session_name}=    Generate random name  event_session
     Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
     [Return]   ${session_name}

Set Activity Details step
    [Arguments]     ${event_campus_name}    ${school_name}
    Input into    ${INPUT_CAMPUS_NAME}    ${event_campus_name}
    Set school name    ${school_name}
    [Return]    ${event_campus_name}

Set event planing
     [Arguments]   ${planned_price}     ${actual_price}
     Click at    Add Item
     Click at    Advertising
     Input price    ${INPUT_PLANNED_PRICE}  ${planned_price}
     Input price     ${INPUT_ACTUAL_PRICE_1}    ${actual_price}

Set Activity Planning step
    [Arguments]     ${planned_price}
    Click at    ${ACTIVE_PLANING_LABEL}
    Click at    Add Item
    Click at    ${BUDGET_TYPE_DROPDOWN_ADVERTISING}
    Input price      ${INPUT_PLANNED_PRICE}   ${planned_price}

Set My Activity Team
    [Arguments]     ${user}
    Click at    ${MY_ACTIVE_LABEL}
    Click at    ${INPUT_ADD_EVENT_TEAM}
    input into    ${INPUT_ADD_EVENT_TEAM}   ${user}
    Click at    ${ATTENDEE_ON_DROPDOWN}   ${user}
    Click at    ${ADD_TEAM_MEMBER_BUTTON}

Input price
    [Arguments]    ${locator}     ${price}
    Click at    ${locator}
    Simulate Input      ${locator}      ${price}

Create campus active event
    [Arguments]     @{team_members}     ${school_name}=Automation Test School
    ${event_campus_name} =    Generate random name    event_campus
    Choose Event type    Campus Activity
    Set Activity Details step       ${event_campus_name}    ${school_name}
    IF      @{team_members}
        FOR     ${team_member}  IN      @{team_members}
            Set My Activity Team    ${team_member}
        END
    END
    Set Activity Planning step      ${planned_price}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_LOCATOR}
    Capture page screenshot
    [Return]    ${event_campus_name}

Create campus event planing
    [Arguments]     ${planned_locator}      ${planned_price}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step      Virtual     Single Event
    Turn On Campus And Select School     ${school_name}
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Set event planning step

Set event planning step
    Click at    ${EVENT_PLANING_LABEL}
    Input planned price     ${INPUT_PLANNED_PRICE}     ${planned_price}
    Click create event button

Input planned price
    [Arguments]     ${planned_locator}      ${planned_price}
    Click at    Add Item
    input into      ${INPUT_SEARCH_BUDGET_TYPE}     Advertising
    Click at     ${BUDGET_TYPE_DROPDOWN_ADVERTISING}
    ${item_name} =  Generate random name    Advertising
    Input into      ${INPUT_LINE_ITEM_NAME}     ${item_name}
    Input price    ${planned_locator}     ${planned_price}

Delete budget item
    Click at    ${DELETE_ITEM_EXPENSES_VALUE}
    Click at    ${CONFIRM_DELETE_EXPENSES_VALUE}

Select group for Input dropdown
    [Arguments]     ${group_name}
    Input into      ${SEARCH_GROUP_TEXTBOX}     ${group_name}
    Click on span text      ${group_name}

Select location for Input dropdown
    [Arguments]     ${location_name}
    Input into      ${SEARCH_LOCATION_TEXTBOX}     ${location_name}
    Click at        ${INPUT_LOCATION_CHECKBOX_BY_NAME}   ${location_name}   1s

Add registration outcome
    [Arguments]     ${starting_value}   ${location_name}=None   ${group_name}=None  ${then_action}=None
    Click at        ${EVENT_ADD_OUTCOME_BUTTON}
    Check span display  Name Your Outcome
    Click at    ${EDIT_OUTCOME_NAME_ICON}
    ${outcome_name}=    Generate random name    outcome_test_
    Input into      ${NAME_YOUR_OUTCOME_TEXTBOX}    ${outcome_name}
    IF  '${starting_value}' == 'Assigned Location'
        Click at    ${STARTING_VALUE_DROPDOWN}
        Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Location
        Click at    ${MATCHES_VALUE_DROPDOWN}
        Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Any Of
        Click at    ${INPUT_DROPDOWN}
        Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Conversation Locations
        Select location for Input dropdown      ${location_name}
        Click on span text      Apply
    ELSE IF     '${starting_value}' == 'Assigned Group'
        Click at    ${STARTING_VALUE_DROPDOWN}
        Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Group
        Click at    ${MATCHES_VALUE_DROPDOWN}
        Click at    ${MATCHES_IS}
        IF  '${group_name}' != 'None'
            Click at    ${INPUT_DROPDOWN}
            Select group for Input dropdown     ${group_name}
        END
    END
    IF  '${then_action}' != 'None'
        Click at    ${ADD_OUTCOME_ACTION_DROPDOWN}
        Click at    ${then_action}
    END
    Capture page screenshot
    Click at    ${SAVE_OUTCOME_BUTTON}
    [Return]    ${outcome_name}

Search and select orient event on scheduling popup
    [Arguments]     ${event_name}
    Clear element text with keys    ${INPUT_SEARCH_ORIENT_EVENT}
    Simulate Input   ${INPUT_SEARCH_ORIENT_EVENT}      ${event_name}
    Click at    ${CHECKBOX_SELECT_ORIENT_EVENT_ON_SCHEDULING_POPUP}     ${event_name}

Set scheduling orient event
    [Arguments]    ${event_name}
    Scheduling select orient event label
    Click at    ${event_name}
    Click by JS    ${SCHEDULING_ORIENT_EVENT_SUBMIT_BUTTON}
    Click at    ${SCHEDULING_ORIENT_EVENT_CLOSE_BUTTON}

Scheduling select orient event label
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at    ${SCHEDULING_ORIENTATION_EVENT_LABEL}

Create orient event Virtual Single Event
    [Arguments]    ${user_name}     ${end_time}=None
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Team step    ${user_name}
#   Set schedule step
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test_session_orient
    Set session staff   ${user_name}
    Click save session button
    IF    '${end_time}' != 'None'
        Set Registration step   ${end_time}
    END
    Set tool step and create event
    [Return]    ${event_name}

Duplicate outcome
    [Arguments]     ${outcome_name}
    Click at        ${OUTCOME_MENU_BY_NAME}     ${outcome_name}
    Click at        ${DUPLICATE_OUTCOME_ICON}
    Check element display on screen     Copy of ${outcome_name}
    Capture page screenshot

Go to edit outcome
    [Arguments]     ${outcome_name}
    Click at        ${OUTCOME_MENU_BY_NAME}     ${outcome_name}
    Click at        ${EDIT_OUTCOME_ICON}

Go to edit session popup
    [Arguments]     ${session_name}
    Click at    ${SCHEDULE_STEP_LABEL}
    Click by JS     ${SESSION_TITLE}    ${session_name}
    Click at    ${EDIT_SESSION_BUTTON}

Create new hiring event, scheduled candidate to interview slot
    [Arguments]     ${hiring_event_type}   ${session_time}      ${interviewer}      ${assign_interviewer_type}=None     ${interview_slot}=1 Interview Time Slot
    #Create event
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    ${hiring_event_type}
    ${event_name}=  Set Overview step with future time    ${hiring_event_type}    Single Event
    IF  '${interviewer}' != 'None'
        Set Team step with multiple users   @{list_users}
    END
    IF  '${hiring_event_type}' == 'In Person'
        ${session_name}=    Set session schedule with interviewer   Scheduled Interviews    ${interviewer}      ${assign_interviewer_type}
    ELSE
        ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${interviewer}      ${assign_interviewer_type}
    END
    Set tool step and create event
    #Add candidate for event
    &{event_infor}=  Add candidate at event homepage     ${session_time}
    ${event_infor.event_name}=      Set variable    ${event_name}
    ${event_infor.session_name}=      Set variable    ${session_name}
    [Return]    &{event_infor}

Create new hiring event, scheduled candidate to interview slot and add interviewer
    [Arguments]     ${hiring_event_type}   ${session_time}      ${interviewer}      ${assign_interviewer_type}=None     ${interview_slot}=1 Interview Time Slot
    &{event_infor}=  Create new hiring event, scheduled candidate to interview slot  ${hiring_event_type}    ${session_time}     ${interviewer}     ${assign_interviewer_type}    ${interview_slot}
    #Add interviewer for candidates
    Add interviewer for candidate       ${session_time}     ${interviewer}
    [Return]    &{event_infor}

Create event, add session and interviewer
    [Arguments]     ${hiring_event_type}    ${interviewer}
    Go to Events page
	Choose Event type and Event venue type    Hiring Event    ${hiring_event_type}
	${event_name}=  Set Overview step with future time    ${hiring_event_type}    Single Event
	Set Team step with multiple users   @{list_users}
    IF  '${hiring_event_type}' == 'In Person'
        ${session_name}=    Set session schedule with interviewer   Scheduled Interviews    ${interviewer}
    ELSE
        ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${interviewer}
    END
    [Return]    ${event_name}   ${session_name}

Event Type modal should be shown
    element should contain      ${EVENT_TYPE_MODAL}     Choose Your Event Type
    Check element display on screen      ${HIRING_EVENT_BUTTON_MODAL_CREATE_EVENT}
    Check element display on screen      ${CAMPUS_ACTIVITY_BUTTON_MODAL_CREATE_CAMPUS}
    Check element display on screen      ${ORIENT_BUTTON_MODAL_CREATE_ORIENT}
    Capture page screenshot

Verify main text displayed correctly
    [Arguments]     @{text_to_verify}
    FOR     ${text}     IN      @{text_to_verify}
        Check element display on screen      ${MAIN_CONTENT_EVENT_TEXT}      ${text}
    END
    Capture page screenshot

verify Campus Activity detail shown correctly
    Check element display on screen   ${ACTIVITY_DETAILS}
    Check element display on screen   ${INTERNAL_EVENT_NAME_INPUT}
    Check element display on screen   ${SCHOOL_NAME_DROPDOWN}
    Check date and time element display on screen

check Date and Time element display on screen
    Check element display on screen   ${EVENT_START_DATE}
    Check element display on screen   ${EVENT_START_TIME}
    Check element display on screen   ${EVENT_END_DATE}
    Check element display on screen   ${EVENT_END_TIME}
    Check element display on screen   ${EVENT_TIMEZONE_DROPDOWN}
    Capture page screenshot

Verify Hiring Event Overview shown correctly
    Check element display on screen    ${OVERVIEW_LABEL}
    Check element display on screen    ${EVENT_NAME_INPUT}
    Check element display on screen    ${INTERNAL_EVENT_NAME_INPUT}
    Check element display on screen    ${EVENT_REPORTING_CATEGORY_DROPDOWN}
    Check element display on screen    ${VENUE_LOCATION_TEXTBOX}
    Check element display on screen    ${VENUE_NAME_TEXTBOX}
    Check element display on screen    ${CAMPUS_TOGGLE}
    Check element display on screen    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    Select single event type
    Check Date and Time element display on screen

Select single event type
    Click at    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_SINGLE_TYPE}

Single Event components display
    Check span display    A single event happens once and can last multiple days.
    Check Date and Time element display on screen

Check number of session displays correctly
    ${session_locator} =    format string    ${SESSION_TITLE}    vt_schedule_session_test
    ${number_of_session} =    get element count    ${session_locator}
    should be equal as numbers    ${number_of_session}    3

Interview Details displays correctly
    Check span display    15 Minutes Each
    Check element display on screen    Phone Interviews
    Check element display on screen    Candidates Scheduled

Overview tab of Student Experience Manager role only
    Check element display on screen    Overview
    Check element display on screen    ${EVENT_NAME_INPUT}
    Check span display    Internal Event Name is the same as Public Event Name
    Check element display on screen    ${EVENT_REPORTING_CATEGORY_DROPDOWN}
    Check element display on screen    ${VENUE_LOCATION_TEXTBOX}
    Check element display on screen    ${VENUE_NAME_TEXTBOX}
    Check span display    Campus
    Check element not display on screen    ${CAMPUS_TOGGLE}
    Check element display on screen    ${SCHOOL_NAME_DROPDOWN}
    capture page screenshot

Discard create event
    Click at    ${BACK_TO_EVENTS}
    Click at    ${EVENT_CREATOR_PAGE_DISCARD_BUTTON}

Create new hiring event
    [Arguments]     ${hiring_event_type}   ${inteviewer}   ${interview_slot}=1 Interview Time Slot
    #Create event
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    ${hiring_event_type}
    ${event_name}=  Set Overview step with future time    ${hiring_event_type}    Single Event
    IF  '${inteviewer}' != 'None'
        Set Team step with multiple users   @{list_users}
    END
    IF  '${hiring_event_type}' == 'In Person'
        ${session_name}=    Set session schedule with interviewer   Scheduled Interviews    ${inteviewer}
    ELSE
        ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${inteviewer}
    END
    Set tool step and create event
    [Return]    ${event_name}

Event Session Details popup is displayed
    [Arguments]    ${session}   ${description}=None
    Click by JS     ${SESSION_TITLE}    ${session.session_name}
    ${session_title_locator} =    format string    ${SESSION_DETAIL_POPUP_TITLE}    ${session.session_name}
    Check element display on screen    ${session_title_locator}
    Check element display on screen    ${SESSION_DETAIL_POPUP_START_DATE}
    IF  '${description}' != 'None'
        Check element display on screen    ${SESSION_DETAIL_POPUP_DESCRIPTION}
    END
    Click at    ${HIDE_SESSION_BUTTON}

Verify session slide out when In-person is selected
    Element should be enabled      ${VENUE_LOCATION_TEXTBOX}
    Element should be enabled      ${VENUE_NAME_TEXTBOX}
    Check element display on screen    ${DESCRIPTION_EVENT_SESSION}
    Check span display      320
    Capture page screenshot

Verify overview event builder after selecting event templates
    Check element display on screen    Overview
    Check element display on screen    ${EVENT_NAME_INPUT}
    Check span display    Internal Event Name is the same as Public Event Name
    Check element display on screen    ${EVENT_VENUE_DROPDOWN}
    Check element display on screen    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}

Delete session of the event
    [Arguments]     ${session_name}     ${is_delete}=False
    Click by JS     ${SESSION_TITLE}    ${session_name}
    Click at    ${DELETE_SESSION_BUTTON}
    IF      '${is_delete}' == 'False'
        Click at    ${CANCEL_DELETE_SESSION_BUTTON}
        Check element display on screen   ${SESSION_TITLE}    ${session_name}
    ELSE
        Click at    ${CONFIRM_DELETE_SESSION_BUTTON}
        Check element not display on screen   ${SESSION_TITLE}    ${session_name}
    END

Edit session name from calendar view
    [Arguments]     ${session_name}     ${new_session_name}     ${is_save}=False
    Click by JS     ${SESSION_TITLE}    ${session_name}
    Click at    ${EDIT_SESSION_BUTTON}
    Input into    ${SESSION_NAME_TEXTBOX}    ${new_session_name}
    IF      '${is_save}' == 'False'
        Click at        ${ADD_SESSION_CANCEL_BUTTON}
        Check element display on screen   ${SESSION_TITLE}    ${session_name}
        Check element not display on screen   ${SESSION_TITLE}    ${new_session_name}
    ELSE
        Click at    ${SAVE_SESSION_NAME}
        Check element not display on screen   ${SESSION_TITLE}    ${session_name}
        Check element display on screen   ${SESSION_TITLE}    ${new_session_name}
    END

Search location in Venue Location
    [Arguments]     ${search_location}
    ${location_lowercase}=	        Convert To Lower Case	    ${search_location}
    Input into    ${VENUE_LOCATION_TEXTBOX}    ${search_location}
    Check element display on screen         ${VENUE_LOCATION_SEARCH_RESULTS}
    @{location_results_element}=        Get webelements     ${VENUE_LOCATION_SEARCH_RESULTS}
    FOR     ${element}      IN      @{location_results_element}
        ${element_text}=       Get text        ${element}
        ${element_text_lowercase}=      Convert To Lower Case	    ${element_text}
        Should contain      ${element_text_lowercase}       ${location_lowercase}
    END
    Capture page screenshot

Input location into the Venue Builder Location textbox
    [Arguments]      ${location}        ${name}
    Input into      ${VENUE_LOCATION_TEXTBOX}       ${location}
    Input into      ${VENUE_NAME_TEXTBOX}       ${name}

Choose event template
    [Arguments]     ${template}
    when Go to Events page
    click on Create New Event button
    wait for page load successfully v1
    Click on p text        Event Templates
    Select event templates      ${template}
    click on create event button

Add default session
    [Arguments]     ${session}
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click at    ${SESSION_TEMPLATE_SELECT}
    Click at    ${EVENT_TEMPLATE_CREATED}        ${session}
    ${default_session_name} =   Get value   ${SESSION_NAME_TEXTBOX}
    should be equal         ${default_session_name}     ${session}

Create a future single virtual orientation event
    [Arguments]    ${user_name}     ${day}
    Go to Events page
    Click on Create New Event button
    Set Event type    ${orientation}
    Click on create event button
    ${next_date} =    get_date_with_month_in_full_string        ${day}
    ${event_name} =     input event name
    Set Event Venue Type in dropdown    Virtual
    Set event occurrence    Single Event
    Click by JS    ${EVENT_START_DATE}     slow_down=1s
    Click by JS    ${EVENT_CREATE_START_DATE_PICKER}    ${next_date}
    Set Team step    ${user_name}
    Set Schedule step   None
    Set tool step and create event
    [Return]    ${event_name}

Set timezone for event
    [Arguments]     ${timezone}
    Click at    ${EVENT_TIMEZONE_DROPDOWN}
    Input into  ${EVENT_SEARCH_TIMEZONE_TEXTBOX}    ${timezone}
    Click at    ${EVENT_TIMEZONE_DROPDOWN_OPTION}    ${timezone}

Add Prep Documents For Event
    [Arguments]     ${prep_candidate}     ${prep_user}
    Click at     ${EVENT_ORIENTATION_PREP_DOC}      Candidate Prep Documents
    Click at     ${COMMON_SPAN_TEXT}    ${prep_candidate}
    Click at     ${EVENT_ORIENTATION_PREP_DOC}      User Prep Documents
    Click at     ${COMMON_SPAN_TEXT}    ${prep_user}
    Click at     ${EVENT_ORIENTATION_PREP_DOC_SAVE_BUTTON}
    Click at     ${EVENT_SAVE_EVENT_BUTTON}

Edit Prep Documents For Event
    [Arguments]     ${prep_candidate}     ${prep_user}
    Click at     ${EVENT_ORIENTATION_PREP_DOC_CANDIDATE_INPUT}
    Click at     ${COMMON_TEXT}    ${prep_candidate}
    Click at     ${EVENT_ORIENTATION_PREP_DOC_USER_INPUT}
    Click at     ${COMMON_TEXT}    ${prep_user}
    Click on span text      Save
    Click at     ${SAVE_EVENT_BUTTON}

Setting number of candidates can schedule and reschedule per event
    [Arguments]     ${number_of_candidates}
    Click at        ${REGISTRATION_STEP_LABEL}
    Click at        ${SCHEDULE_CONDITION_ADVANCED_SETTING_BUTTON}
    Check span display      Add a Scheduling Condition
    Click on common text last       Advanced Settings
    Click at        ${SCHEDULE_MAXIMUM_CANDIDATE_DROPDOWN}
    Click on common text last       ${number_of_candidates}
    Click at        ${SCHEDULE_ADVANCED_SETTING_BUTTON_SAVE}

Fill valid data into remain fields Interview Session
    [Arguments]    ${session_type}
    IF    '${session_type}' == 'Virtual Scheduled Interviews'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Set Interview Time Slot Per Duration    ${interview_time_slots}     ${interview_duration}
        Add interviewer for session     ${CA_TEAM}
        Select setting interviewer      Manually Assign Interviewers
    ELSE IF     '${session_type}' == 'Live Video Broadcast'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Input into      ${SESSION_URL_TEXTBOX}      https://google.com
        Input into      ${SESSION_URL_PASS_TEXTBOX}     1345
        Input into      ${DESCRIPTION_EVENT_SESSION}    Decription text
    ELSE IF     '${session_type}' == 'Virtual Chat Booth'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Input into      ${DESCRIPTION_EVENT_SESSION}      Decription text
    ELSE IF     '${session_type}' == 'Event Session - In Person'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Set session interview type      In Person
        Input into      ${DESCRIPTION_EVENT_SESSION}      Decription text
    ELSE IF     '${session_type}' == 'Event Session - Virtual'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Set session interview type      Virtual
        Input into      ${SESSION_URL_TEXTBOX}      https://google.com
        Input into      ${SESSION_URL_PASS_TEXTBOX}     1345
        Input into      ${DESCRIPTION_EVENT_SESSION}    Decription text
    ELSE IF     '${session_type}' == 'Orientation - Virtual'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Set session interview type      Virtual
        Input into      ${SESSION_URL_TEXTBOX}      https://google.com
        Input into      ${SESSION_URL_PASS_TEXTBOX}     1345
        Input into      ${DESCRIPTION_EVENT_SESSION}    Decription text
        Add interviewer for session     ${CA_team}
    ELSE IF     '${session_type}' == 'Orientation - In Person'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Set session interview type      In Person
        Input into      ${DESCRIPTION_EVENT_SESSION}      Decription text
        Add interviewer for session     ${CA_TEAM}
    ELSE IF     '${session_type}' == 'Orientation - Candidate Store Location'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        Input into      ${DESCRIPTION_EVENT_SESSION}      Decription text
        Add interviewer for session     ${CA_TEAM}
    ELSE IF     '${session_type}' == 'Scheduled Interviews'
        ${session_name}=    Generate random name  event_session
        Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
        Update start time for session    ${start_time_schedule}
        Update end time for session     ${end_time_schedule}
        ${is_displayed} =     Run keyword and return status   Check element display on screen    ${CANDIDATES_PER_ITV}
        IF  '${is_displayed}' == 'True'
            Input into    ${CANDIDATES_PER_ITV}     1
        END
        Add interviewer for session     ${CA_TEAM}
        Set Interview Time Slot Per Duration    ${interview_time_slots}     ${interview_duration}
        Select setting interviewer      Manually Assign Interviewers
    END
    [Return]   ${session_name}

Create Campus Event with status Pending by first approver
    [Arguments]    ${school_name}
    Go To Events Page
    ${event_campus_name}=         Create campus active event           school_name=${school_name}
    Click At                ${SUBMIT_APPROVAL_BUTTON}
    Click At                ${CONFIRM_APPROVAL_BUTTON}
    Check Text Display      Pending
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Approved by one approver
    [Arguments]    ${school_name}   ${approver_name}
    ${event_campus_name}=   Create Campus Event with status Pending by first approver  ${school_name}
    Capture Page Screenshot
    Switch To User          ${approver_name}
    Click At                ${APPROVAL_BUTTON}
    Click At                ${CONFIRM_APPROVAL_BUTTON}
    Check Text Display      Approved
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Denied by first approver
    [Arguments]    ${school_name}   ${approver_name}
    ${event_campus_name}=   Create Campus Event with status Pending by first approver  ${school_name}
    Switch To User    ${approver_name}
    Click At                ${DENY_BUTTON}
    Click At                ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Check Text Display      Denied
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Denied by first approver and resubmitted
    [Arguments]    ${school_name}   ${approver_name}    ${creator_name}
    ${event_campus_name}=   Create Campus Event with status Denied by first approver  ${school_name}  ${approver_name}
    Switch To User    ${creator_name}
    Click At                ${SUBMIT_APPROVAL_BUTTON}
    Click At                ${CONFIRM_APPROVAL_BUTTON}
    Check Text Display      Pending
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Denied by second approver
    [Arguments]    ${school_name}   ${approver_name_1}    ${approver_name_2}
    ${event_campus_name}=   Create Campus Event with status Approved by one approver  ${school_name}   ${approver_name_1}
    Switch To User    ${approver_name_2}
    Click At                ${DENY_BUTTON}
    Click At                ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Check Text Display      Denied
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Approved by multi approver
    [Arguments]    ${school_name}   @{approvers}
    ${event_campus_name}=   Create Campus Event with status Pending by first approver  ${school_name}
    FOR  ${approver}  IN  @{approvers}
        Switch To User          ${approver}
        Click At                ${APPROVAL_BUTTON}
        Click At                ${CONFIRM_APPROVAL_BUTTON}
    END
    Check Text Display      Approved
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Pending by last approver
    [Arguments]    ${school_name}   @{approvers_to_previous_last}
    ${event_campus_name}=   Create Campus Event with status Pending by first approver  ${school_name}
    FOR  ${approver}  IN  @{approvers_to_previous_last}
        Switch To User          ${approver}
        Click At                ${APPROVAL_BUTTON}
        Click At                ${CONFIRM_APPROVAL_BUTTON}
    END
    Check Text Display      Pending
    Capture Page Screenshot
    [Return]    ${event_campus_name}

Create Campus Event with status Denied by last approver
    [Arguments]    ${school_name}   ${last_approver}   @{approvers_to_previous_last}
    ${event_campus_name}=   Create Campus Event with status Pending by last approver  ${school_name}    @{approvers_to_previous_last}
    Switch To User    ${last_approver}
    Click At                ${DENY_BUTTON}
    Click At                ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Check Text Display      Denied
    Capture Page Screenshot
    [Return]    ${event_campus_name}
