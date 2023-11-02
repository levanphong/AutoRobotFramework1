*** Settings ***
Library         ../api/CandidateScheduleByApi.py
Resource        ../pages/event_creating_page.robot
Resource        ../pages/conversation_page.robot
Variables       ../locators/event_locators.py

*** Variables ***
${BLUE_LIGHT_COLOR}         rgba(37, 201, 208, 1)
${job_requisition_id_1}     PAT050

*** Keywords ***
navigate to create hiring events
    wait for page load successfully v1
    Wait with short time
    click on Create New Event button
    click on Hiring Event type
    click on Next Button

Complete creating event
    click on create event button
    wait for page load successfully v1
    ${event_dynamic} =    input event name
    click on occurrence type
    choose next day for occuracy type
    click on next button event modal
    click on next button event modal
    Finish set schedule time and virtual booth session    ${event_dynamic}
    Finish set registration
    Click at    ${LANDING_PAGE}
    Input into    ${DESCRIPTION_LADING_PAGE}    hello Landing page
    ${path_image} =    get_path_upload_image_path    cat-kute
    ${element} =    Get Webelement    ${INPUT_UPLOAD_FILE}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
    ...    ARGUMENTS    ${element}
    Input into    ${INPUT_UPLOAD_FILE}    ${path_image}
    Click at    ${CONFIRM_BUTTON}
    wait until element is visible    ${PREVIEW_BACKGROUND}
    Check element display on screen    ${PREVIEW_BACKGROUND}
    Wait with short time
    Scroll to element    ${SAVE_LANDING_PAGE}
    Wait with short time
    Click at    ${SAVE_LANDING_PAGE}
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    check event created successfully has name    ${event_dynamic}
    [Return]    ${event_dynamic}

check event created successfully has name
    [Arguments]    ${event_name}
    ${event_locator} =    Format String    ${COMMON_SPAN_TEXT}    ${event_name}
    Check element display on screen    ${event_locator}

Go to Schedule step
    click on create event button
    wait for page load successfully v1
    ${event_dynamic} =    input event name
    click on Event type
    click on occurrence type
    choose next day for occuracy type
    click on next button event modal
    Click at    ${SCHEDULE_TAB}

Finish create event by template
    click on occurrence type
    choose next day for occuracy type
    click on next button event modal
    # next for config setting user added for event
    click on next button event modal
    # click available schedule time
    Finish set schedule time and virtual booth session    ${TEMPLATE_EVENT_AUTO}
    click on next button event modal
    Finish landing site config
    check event created successfully has name    ${TEMPLATE_EVENT_AUTO}
    [Return]    ${TEMPLATE_EVENT_AUTO}

Finish set registration
    Click at    ${CONVERSATION_CB_TYPE}
    Click at    ${OPTION_CONVERSATION_TYPE}
    Click at    ${NUMBER_OF_CANDIDATES_DROPDOWN}
    Click at    ${SPECIFIC_NUMBER_OF_CANDIDATES_CHECK}
    Input into    ${SPECIFIC_NUMBER_OF_CANDIDATES_TEXTBOX}    1
    Click at    ${NUMBER_OF_CANDIDATES_APPLY_BTN}
    click on next button event modal

Finish set schedule time and virtual booth session
    [Arguments]    ${event_name}
    Scroll to element    ${SCHEDULE_AVAILABLE_TIME}
    wait until element is visible    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    Input into    ${SESSION_NAME_TEXTBOX}    ${event_name}_booth_test
    Click at    ${SAVE_BOOTH_NAME}
    Click at    ${REGISTRATION_TEXT}

Finish landing site config
    Click at    ${LANDING_PAGE}
    Input into    ${DESCRIPTION_LADING_PAGE}    hello Landing page
    ${path_image} =    get_path_upload_image_path    cat-kute
    ${element} =    Get Webelement    ${INPUT_UPLOAD_FILE}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
    ...    ARGUMENTS    ${element}
    Input into    ${INPUT_UPLOAD_FILE}    ${path_image}
    Click at    ${CONFIRM_BUTTON}
    wait until element is visible    ${PREVIEW_BACKGROUND}
    Check element display on screen    ${PREVIEW_BACKGROUND}
    sleep    4s
    Scroll to element    ${SAVE_LANDING_PAGE}
    Click at    ${SAVE_LANDING_PAGE}
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}

Check Event is created successfully with template
    check event created successfully has name    ${TEMPLATE_EVENT_AUTO}

click on first template event
    Click at    ${EVENT_TEMPLATE_NAME}

Choose Event type and Event venue type
    [Arguments]    ${event_type}    ${event_venue_type}
    click on Create New Event button
    wait for page load successfully v1
    Set Event type    ${event_type}
    click on Next Button
    ${is_event_venue_type_default} =    Set Event Venue Type    ${event_venue_type}
    click on Next Button

Choose Event type
    [Arguments]    ${event_type}
    click on Create New Event button
    Set Event type    ${event_type}
    click on Next Button

Creating the event
    [Arguments]    ${event_type}    ${event_venue_type}    ${event_occurrence}    ${session_type}    ${end_time}    ${number_of_candidates}     ${event_name_fixed}=None
    click on Create New Event button
    wait for page load successfully v1
    Set Event type    ${event_type}
    click on Next Button
    IF    '${event_venue_type}' != 'None'
        Set Event Venue Type    ${event_venue_type}
        click on Next Button
    END
    IF  '${event_name_fixed}' == 'None'
        ${event_name} =    Set Overview step    ${event_venue_type}    ${event_occurrence}
    ELSE
        ${event_name} =    Set Overview step    ${event_venue_type}    ${event_occurrence}      event_name=${event_name_fixed}
    END
    IF    '${event_occurrence}' != 'Single Event'
        Set recurring rule step       Once
    END
    &{session_info} =    Set Schedule step    ${session_type}
    Set Registration step    ${end_time}    ${number_of_candidates}
    IF    '${event_occurrence}' != 'Single Event'
        Set landing page
        Check element display on screen    Configure all the different ways candidates can communicate with Olivia for your event
        Set Summary step and create event
    ELSE
        Set Tools step
        IF    '${session_type}' == 'Scheduled Interviews'
            Verify Event in Event dashboard    &{session_info}
        END
    END
    ${session_info.event_name} =    Set Variable    ${event_name}
    [Return]    &{session_info}

the event creation is the same as the user creating a General Hiring Event with an Event Venue of
    [Arguments]    ${event_type}
    Check element display on screen    ${EVENT_NAME_INPUT}
    Check element display on screen    ${OVERVIEW_LABEL}
    Check element display on screen    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    check left menu header on creating event    Team
    check left menu header on creating event    Registration
    check left menu header on creating event    Schedule
    check left menu header on creating event    Tools

check the event venue as subtext under the Title
    [Arguments]    ${event_type}
    element text should be    ${HEADER_TYPE_BOX}    ${event_type}

check left menu header on creating event
    [Arguments]    ${attribute_name}
    ${locator_attribute} =    Format String    ${COMMON_SPAN_TEXT}    ${attribute_name}
    Check element display on screen    ${locator_attribute}

Verify Event in Event dashboard
    [Arguments]    &{session_info}
    Wait with short time
    ${interview_type} =    Evaluate    "${session_info.interview_type}".lower()
    ${session_name_locator} =    Format String    ${COMMON_TEXT}    ${session_info.session_name}
    ${start_time_locator} =    Format String    ${COMMON_TEXT}    ${session_info.start_time}
    ${end_time_locator} =    Format String    ${COMMON_TEXT}    ${session_info.end_time}
    ${interview_type_locator} =    Format String    ${COMMON_TEXT}    ${interview_type}
    Check element display on screen    ${session_name_locator}
    Check element display on screen    ${start_time_locator}
    Check element display on screen    ${end_time_locator}
    Check element display on screen    ${interview_type_locator}

Create hiring event without create Virtual Chat Booth session
    Creating the event    Hiring Event    Virtual    Single Event    Virtual Scheduled Interviews    None    None

Go to Candidates tab in event homepage
    Click at    ${CANDIDATE_TAB}

Add new candidate to schedule to event and check it works correctly
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_last_name} =    Generate random name    Candidate
    ${event_candidate_email} =    get_auto_email
    Input into    ${INPUT_FIRST_NAME_CANDIDATE}    Test
    Input into    ${INPUT_LAST_NAME_CANDIDATE}    ${candidate_last_name}
    Input into    ${INPUT_EMAIL_CANDIDATE}    ${event_candidate_email}
    Click at    ${ADD_CANDIDATE_BUTTON_DIALOG_ADD}      slow_down=5s
    wait for page load successfully v1
    Wait with short time
    then check element display on screen    ${candidate_last_name}

Add new candidate from recurring tab
    Click at    //tr[contains(@class, 'el-table__row occurrence')]
    Go to Candidates tab in event homepage
    Add new candidate to schedule to event and check it works correctly

Create hiring event has Virtual Chat Booth session
    &{session_info} =    Creating the event    Hiring Event    Virtual    Single Event    Virtual Chat Booth    None
    ...    None
    run keyword and ignore error    wait for page load successfully v1
    [Return]    &{session_info}

Create Virtual Event has Virtual Chat Booth and no add description session
    Creating the event    Hiring Event    Virtual    Single Event    Virtual Chat Booth    None    None
    run keyword and ignore error    wait for page load successfully v1

Go to Schedule tab in event homepage
    Click at    ${SCHEDULE_TAB_DETAILS}

check There is no description showed in session info
    element should contain    ${SESSION_DESCRIPTION_DETAIL_HOME_EVENT}    -

Check session in calendar change to time
    Wait with short time
    ${session_time} =    get text    ${CALENDAR_SESSION}
    should match regexp    ${session_time}    am|pm|AM|PM

Check session in calendar change to text
    [Arguments]    ${expected_session_name}
    Wait with short time
    ${session_name} =    get text    ${CALENDAR_SESSION}
    should be equal as strings    ${session_name}    ${expected_session_name}

Switch to Full user role
    Click at    ${SWITCH_USER_BTN}
    Click at    ${FULL_USER_ROLE}
    Wait with short time

Add candidate to session
    ${candidate_name} =     Generate random name  Candidate
    Click at    ${ADD_CANDIDATE}
    Input into    ${CANDIDATE_FIRST_NAME_TEXTBOX}    ${candidate_name}
    Input into    ${CANDIDATE_LAST_NAME_TEXTBOX}    Test
    Input into    ${CANDIDATE_EMAIL_TEXTBOX}    ${candidate_name}@gmail.com
    Input into    ${CANDIDATE_PHONE_NUMBER_TEXTBOX}    ${CONST_PHONE_NUMBER}
    Click at    ${ADD_CANDIDATE_BTN}

verify session info detail on right hand side
    [Arguments]    &{session_info}
    Wait with short time
    ${session_name_locator} =    Format String    ${COMMON_TEXT}    ${session_info.session_name}
    ${start_time_locator} =    Format String    ${COMMON_TEXT}    ${session_info.start_time}
    ${end_time_locator} =    Format String    ${COMMON_TEXT}    ${session_info.end_time}
    Check element display on screen    ${session_name_locator}
    Check element display on screen    ${RIGHT_HAND_SIDE_SESSION_DATE_TIME}
    element should contain    ${RIGHT_HAND_SIDE_SESSION_DATE_TIME}    ${session_info.start_time}
    element should contain    ${RIGHT_HAND_SIDE_SESSION_DATE_TIME}    ${session_info.end_time}

Click on an event session on calendar
    [Arguments]    &{session_info}
    ${session_name_locator} =    Format String    ${COMMON_TEXT}    ${session_info.session_name}
    Click at    ${session_name_locator}

check The selected calendar block will appear highlighted
    Check element display on screen    ${SESSION_CALENDAR_SELECTED}

check The right hand side will also transition to display more details
    [Arguments]    ${session_name}
    ${locator} =    Format String    ${RIGHT_HAND_SIDE_SESSION_INFO}    ${session_name}
    Check element display on screen    ${locator}

Scroll to last candidate in schedule card
    Scroll to element    ${LAST_CANDIDATE_INTERVIEW}

Set two days event in Overview
    Click at    ${OVERVIEW_STEP_LABEL}
    ${event_dynamic} =    input event name
    Click at    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_SINGLE_TYPE}
    ${next_date} =    get_date_with_month_in_full_string    2
    Click at    ${EVENT_END_DATE}
    Click by JS    ${EVENT_CREATE_END_DATE_PICKER}     ${next_date}

Input CEM Full name and email
    [Arguments]     ${is_spam_email}=True       ${location}=None
    &{email_info} =    Get email for testing    ${is_spam_email}
    &{candidate_name}=  Generate candidate name
    Input into    ${CEM_FIRSTNAME}    ${candidate_name.first_name}
    Input into    ${CEM_LASTNAME}     ${candidate_name.last_name}
    Input into    ${CEM_EMAIL}    ${email_info.email}
    IF      '${location}' != 'None'
        Click at    ${CEM_LOCATION_DROPDOWN}
        Input into    ${CEM_LOCATION_SEARCH_TEXT_BOX}    ${location}
        Click at    ${CEM_LOCATION_VALUE}    ${location}
    END
    Click at    ${EVENT_CEM_ADD_CANDIDATE_BUTTON}
    wait for page load successfully
    [Return]    &{candidate_name}

Input Search box
    [Arguments]    ${search_word}
    Input into    ${SEARCH_INPUT}    ${search_word}

add more than 999 plus candidate for virtual event
    FOR    ${i}    IN RANGE    100
        Add new candidate to schedule to event and check it works correctly
        Log    ${i}
    END

Check navigate to the Event Homepage
    Check element display on screen    Dashboard
    Check element display on screen    Candidates
    Check element display on screen    Schedule
    Check element display on screen    Team
    Check element display on screen    Reporting

Check list show correctly with recurrings
    wait until element is visible    ${AN_RECURRING_EVENT_CARD}    5s
    ${values} =    Get Element Count    ${AN_RECURRING_EVENT_CARD}
    ${not_empty_list} =    evaluate    ${values} > 0
    should be true    ${not_empty_list}

Check list show correct with Event Occurrences
    ${count_occurrence} =    split string    Occurrences
    ${count_int} =    convert to integer    ${count_occurrence}[0]
    ${values} =    Get Element Count    ${LIST_OCCURRENCE_ON_CARD}
    should be equal as integers    ${count_int}    ${values}

Click on the ellipses icon in the Recurring Event card
    Click at    ${MENU_ITEM_OCCURRENCE}

Check Events page is loaded
    Check element display on screen    My Events
    Check element display on screen    Upcoming Events
    Check element display on screen    Recurring Events
    Check element display on screen    Past Events
    check span display    Create New Event

Check My Events tab is opened first
    Check element display on screen    ${MY_EVENT_ACTIVE_ICON}

Check link Upcoming Events is active
    ${url} =    get location
    should be equal as strings    ${url}    ${base_url}/events/upcoming

Check list upcoming events is displayed correctly
    Check element display on screen    Upcoming Events
    Check element display on screen    ${LIST_ITEM_EVENT}

Check navigate to Edit Recurring Event page
    check span display    Edit Event
    check span display    Back to event
    Check element display on screen    Overview

Choose Going event for user
    Click at    ${RSVP_STATUS_BUTTON}
    Click at    ${GOING_STATUS_BUTTON}

Choose Not Going event for user
    Click at    ${RSVP_STATUS_BUTTON}
    Click at    ${NOT_GOING_STATUS_BUTTON}
    Click at    ${DECLINE_INVITE_BUTTON}

Assign a team member to candidate
    [Arguments]     ${team_member}
    Click at    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Click at    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Click at    ${SHOW_MEMBER_BUTTON}
    Click at    ${MEMBER_ASSIGN_TO_CANDIDATE}   ${team_member}
    Click at    ${ASSIGN_BUTTON}

Verify assigned member
    [Arguments]    ${member_name}
    ${locator} =    Format String    ${ASSIGNED_MEMBER_NAME}    "${member_name}"
    Check element not display on screen    ${locator}

Verify selected team member
    [Arguments]    ${member_name}
    ${locator} =    Format String    ${SELECTED_TEAM_MEMBER}    "${member_name}"
    Check element not display on screen    ${locator}

Check displaying Interview tags for all events that have interview sessions created
    Check element display on screen    ${VIRTUAL_TAG}

Check Virtual tag is displayed on Hiring Events has Event Venue is Virtual
    Check element display on screen    ${VIRTUAL_TAG}

Check Chat tag is displayed for all Virtual Chat Booth Events
    Check element display on screen    ${VIRTUAL_BOOT_CHAT_TAG}

Create hiring event has In person type and schedule interview session
    &{session_info} =    Creating the event    Hiring Event    In Person    Single Event    Scheduled Interviews    None
    ...    None
    [Return]    &{session_info}

Create hiring event has In person type and schedule interview session and recurring event
    &{session_info} =    Creating the event    Hiring Event    In Person    Recurring Event    Scheduled Interviews
    ...    None    None
    [Return]    &{session_info}

Search and delete event
    [Arguments]    ${event_name}
    search event    ${event_name}
    delete event    ${event_name}

delete event
    [Arguments]    ${event_name}
    Click on ellipses icon on the Event Occurrence row
    Click at    ${UPCOMING_MENU_DELETE_EVENT}
    Click at    ${DELETE_POPUP}
    Check element display on screen    There are no events that match your search criteria.

Delete Campus Activity
    [Arguments]    ${event_name}
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click At    ${UPCOMING_MENU_ITEM_EVENT}
    Click At    ${EVENT_ACTIVITY_UPCOMING_DELETE_BUTTON}
    Click At    ${EVENT_ACTIVITY_UPCOMING_DELETE_CONFIRM_BUTTON}
    Check element display on screen    There are no events that match your search criteria.
    Capture Page Screenshot

Search event
    [Arguments]    ${event_name}
    Input into    ${SEARCHING_INPUT}    ${event_name}
    Check element display on screen    ${event_name}
    Wait with medium time

Search campus event
    [Arguments]    ${criteria}
    Input into    ${INPUT_SEARCH_CAMPUS_BUTTON}    ${criteria}
    Wait with short time

Check campus event with criteria
    [Arguments]     ${criteria}         ${value}        ${exist}=True
    Search campus event     ${value}
    IF  ${exist}
        IF      '${criteria}' == 'Area name' or '${criteria}' == 'Campus name' or '${criteria}' == 'Event name'
            Check campus event by name      ${criteria}      ${value}
        ELSE IF  '${criteria}' == 'Aprroval Status' or '${criteria}' == 'Event Status'
            Check campus event by status    ${criteria}      ${value}
        ELSE IF   '${criteria}' == 'Date'
            Check campus event by date      ${value}
        END
    ELSE
        Check element display on screen     Nothing to show right now.
        Capture page screenshot
    END

Get total number of events
    ${header}=              Get text and format text                        ${EVENT_CAMPUS_PLAN_SUB_HEADER_TEXT}
    ${number_arr}=              extract numbers         ${header}
    ${number}=      Set variable    ${number_arr}[0]
    [Return]        ${number}

Get total number of events and traverse the data table
    [Arguments]     ${school_name}
    Go to campus plan
    Search campus event     ${school_name}
    ${number}=      Get total number of events
    Scroll to bottom    ${EVENT_CAMPUS_PLAN_TABLE}      ${number}

Save edited campus activity
    # Move to the end step of Campus Activity creating page
    Click at    ${ACTIVITY_PLANNING}
    # Save changes
    Click at    ${NEXT_BUTTON_EVENT}
    # Confirm changes
    Click at    ${CONFIRM_SAVE_BUTTON}
    wait for page load successfully

Check campus event by name
    [Arguments]     ${criteria}     ${name_input}
    IF      '${criteria}' == 'Area name'
        ${EVENT_CAMPUS_PLAN_CRITERIA}=  Set variable        ${EVENT_CAMPUS_PLAN_AREA_NAME_TABLE_DATA}
    ELSE IF  '${criteria}' == 'Campus name'
        ${EVENT_CAMPUS_PLAN_CRITERIA}=  Set variable        ${EVENT_CAMPUS_PLAN_CAMPUS_NAME_TABLE_DATA}
    ELSE IF    '${criteria}' == 'Event name'
        ${EVENT_CAMPUS_PLAN_CRITERIA}=  Set variable        ${EVENT_CAMPUS_PLAN_EVENT_NAME_TABLE_DATA}
    END
    ${number}=              Get total number of events
    IF  '${number}'=='0'
        Check element display on screen     Nothing to show right now.
        Capture page screenshot
    ELSE
        ${bigger_than_20}=      evaluate    ${number} > 20
        IF     ${bigger_than_20}
                ${number}=      Set variable    20
        END
        capture page screenshot
        FOR     ${index}    IN RANGE       1       ${number}
            ${name}=                       Get text and format text                        ${EVENT_CAMPUS_PLAN_CRITERIA}                   ${index}
            Should contain         ${name}        ${name_input}
        END
    END
    capture page screenshot

Check campus event by status
    [Arguments]     ${criteria}     ${status_input}
    IF      '${criteria}' == 'Approval Status'
        ${EVENT_CAMPUS_PLAN_CRITERIA}=  Set variable        ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}
    ELSE IF   '${criteria}' == 'Event Status'
        ${EVENT_CAMPUS_PLAN_CRITERIA}=  Set variable        ${EVENT_CAMPUS_PLAN_EVENT_STATUS_TABLE_DATA}
    END
    ${number}=              Get total number of events
    IF  '${number}'=='0'
        Check element display on screen     Nothing to show right now.
        Capture page screenshot
    ELSE
        ${bigger_than_20}=      evaluate    ${number} > 20
        IF     ${bigger_than_20}
                ${number}=      Set variable    20
        END
        FOR     ${index}    IN RANGE       1       ${number}
            ${status}=                       Get text and format text                        ${EVENT_CAMPUS_PLAN_CRITERIA}                   ${index}
            should be equal as strings         ${status}        ${status_input}
        END
    END
    capture page screenshot

Check campus event by date
    [Arguments]     ${date_input}
    ${number}=              Get total number of events
    IF  '${number}'=='0'
        Check element display on screen     Nothing to show right now.
        Capture page screenshot
    ELSE
        ${bigger_than_20}=      evaluate    ${number} > 20
        IF     ${bigger_than_20}
                ${number}=      Set variable    20
        END
        FOR     ${index}    IN RANGE       1       ${number}
            ${date}=                       Get text and format text                        ${EVENT_CAMPUS_PLAN_EVENT_DATE_TABLE_DATA}                   ${index}
            Should contain          ${date}        ${date_input}
        END
    END
    capture page screenshot

Check the date that the occurrence will take place with the frequency of it and the end date for the entire recurring event is displayed with light grey
    [Arguments]    ${event_name}
    ${locator_event_name} =    FORMAT STRING    ${UPCOMING_EVENT_HAS_NAME}    ${event_name}
    Check element display on screen    ${locator_event_name}
    Check background color code displayed correctly    ${BUTTON_GOING_EVENT_CARD}    ${BLUE_LIGHT_COLOR}

Click on ellipses icon on the Event Occurrence row
    Click by JS    ${UPCOMING_MENU_ITEM_EVENT}

delete occurrence action
    Check element display on screen    ${TITLE_DELETE_OCCURRENCE_POPUP}
    Check element display on screen    ${DESCRIPTION_DELETE_OCCURRENCE_POPUP}
    Click at    ${DELETE_OCCURRENCE_BUTTON}

delete recurring occurrence on card
    Check element display on screen    ${RECURRING_TAB_DELETE_BUTTON_POPUP}
    Check element display on screen    ${RECURRING_TAB_CANCEL_BUTTON_POPUP}
    Check element display on screen    ${RECURRING_TAB_DESCRIPTION_DELETE_OCCURRENCE_POPUP}
    Click at    ${RECURRING_TAB_DELETE_BUTTON_POPUP}

Delete the occurrence and close the modal
    [Arguments]    ${event_name}
    ${locator_event_name} =    FORMAT STRING    ${RECURRING_EVENT_HAS_NAME}    ${event_name}
    Wait with short time
    Check element display on screen    ${locator_event_name}
    Check element display on screen    ${TITLE_DELETE_OCCURRENCE_POPUP}

Click on ellipses icon on the Event Occurrence row on recurring tab
    Click at    ${RECURRING_MENU_ITEM_EVENT}

Click on ellipses icon on row the Event Occurrence row of recurring tab
    Click at    ${RECURRING_MENU_ITEM_EVENT_SUB}

Verify My candidates number
    [Arguments]    ${expected_number}
    Wait with short time
    ${candidates_number} =    get text    ${MY_CANDIDATES_NUMBER}
    should be equal as strings    ${expected_number}    ${candidates_number}

Verify Unassigned candidates number
    [Arguments]    ${expected_number}
    Wait with short time
    ${candidates_number} =    get text    ${UNASSIGNED_CANDIDATES_NUMBER}
    should be equal as strings    ${expected_number}    ${candidates_number}

Register the event and back to event page
    [Arguments]    ${candidate_name}    ${candidate_mobile}
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    ${candidate_name}    ${candidate_mobile}
    close browser
    Open Chrome
    go to    ${current_event_url}
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    go to    ${current_event_url}

Verify Even schedule timezone match the timezone provided in the Event card
    ${event_card_time} =    Get text    ${EVENT_CARD_TIME}
    ${event_schedule_card_time} =    Get text    ${EVENT_SCHEDULE_CARD_TIME}
    ${event_card_timezone} =    Get Regexp Matches    ${event_card_time}    \\((.*?)\\)
    ${event_schedule_card_timezone} =    Get Regexp Matches    ${event_schedule_card_time}    \\((.*?)\\)
    log    ${event_card_timezone}
    log    ${event_schedule_card_timezone}
    should be equal as strings    ${event_card_timezone}    ${event_schedule_card_timezone}

Set Schedule step with Hide URL/Pass is ON
    Click at    ${SCHEDULE_STEP_LABEL}
    Scroll to element    ${SCHEDULE_AVAILABLE_TIME}
    wait until element is visible    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${LIVE_VIDEO_BROADCAST_LABEL}
    Input into    ${SESSION_NAME_TEXTBOX}    virtual_video_broadcast_interviews_test
    Input into    ${SESSION_URL_TEXTBOX}    https://robotframework.org/
    Input into    ${SESSION_URL_PASS_TEXTBOX}    this_is_the_password
    Click at    ${HIDE_URL_PASSWORD}
    click save session button

Add candidate into Interview Session
    [Arguments]    ${session_name}
    &{email_info} =    Get email for testing
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${SESSION_NAME_IN_CARD}     ${session_name}
    Click at    ${OPEN_INTERVIEW_TIME}
    Click at    ${ADD CANDIDATE}
    ${candidate_first_name} =    Generate random name  Candidate
    ${candidate_phone} =    Set Variable    ${CONST_PHONE_NUMBER}
    Input into    ${CANDIDATE_FIRST_NAME_TEXTBOX}    ${candidate_first_name}
    Input into    ${CANDIDATE_LAST_NAME_TEXTBOX}    Test
    Input into    ${CANDIDATE_EMAIL_TEXTBOX}    ${email_info.email}
    Input into    ${CANDIDATE_PHONE_NUMBER_TEXTBOX}    ${candidate_phone}
    Click at    ${ADD_CANDIDATE_BTN}
    ${is_element_visible} =    Run Keyword And Return Status    Check element display on screen    ${MERGE_CANDIDATE_BUTTON}
    IF    ${is_element_visible}
        Click at    ${MERGE_CANDIDATE_BUTTON}
    END
    Wait with medium time
    [Return]    ${candidate_first_name}

Delete Session in the Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SESSION TITLE}
    Click at    ${DELETE_SESSION_BUTTON}
    Click at    ${CONFIRM_DELETE_SESSION_BUTTON}

Save the edited Event
    [Arguments]    ${session_type}
    Set Schedule step    ${session_type}
    Click at    ${REGISTRATION_STEP_LABEL}
    ${outcome_locator} =    Format String    ${OUTCOME_CARD}    Default Outcome
    Click at    ${outcome_locator}
    Click at    ${SESSION_SELECTION}
    Click at    ${FIRST_SESSION}
    Click at    ${APPLY_SESSION_BUTTON}
    Click at    ${SAVE_SESSION_BUTTON}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}

Get conversation message
    [Arguments]    ${conversation_type}
    ${conversation_locator} =    Set Variable    ${CONVERSATION_MESSAGE}
    IF    '${conversation_type}' == 'schedule'
        ${conversation_locator} =    Set Variable    ${CONVERSATION_MESSAGE_2}
    END
    sleep    10s
    ${elements} =    Get Webelements    ${conversation_locator}
    @{message} =    Create List
    FOR    ${element}    IN    @{elements}
        ${text} =    Get Text    ${element}
        Append To List    ${message}    ${text}
    END
    [Return]    @{message}

Verify job conversation is the same conversation in Event landing page
    [Arguments]    @{main_conversation}
    @{new_conversation} =    Get conversation message    job
    Lists Should Be Equal    ${main_conversation}    ${new_conversation}

Verify schedule conversation is the same conversation in Event landing page
    [Arguments]    @{main_conversation}
    @{new_conversation} =    Get conversation message    schedule
    Remove From List    ${new_conversation}    -1
    Lists Should Be Equal    ${main_conversation}    ${new_conversation}

Register candidate to event and back to Event Dashboard page
    [Arguments]    ${candidate_name}    ${candidate_mobile}
    @{window} =    get window handles
    switch window    ${window}[1]
    Finish register the event    ${candidate_name}    ${candidate_mobile}
    sleep    4s
    switch window    ${window}[0]
    sleep    4s

Create candidate for Orientation Event
    ${CONFIG} =    get_config    ${env}
    ${email} =    Set Variable    ${CONFIG.gmail}
    &{candidate_info} =    generate_candidate_info    11114    ${email}
    ${status}=  create_candidate_by_api    ${env}    ${candidate_info}

Add 30 candidates to the Orientation Event
    [Arguments]    ${event_name}
    FOR    ${index}    IN RANGE    29
        Create candidate for Orientation Event
        Click button in email    Schedule your Orientation with ${COMPANY_EVENT}
        ...    Schedule your Orientation with ${COMPANY_EVENT}
        ${locator_event_name} =    FORMAT STRING    ${SELECT_TIME_BUTTON}    ${event_name}
        Click at    ${event_name}
        Click at    ${locator_event_name}
        Wait with medium time
    END

Go back to Orientation Event page
    [Arguments]    ${current_event_url}
    go to    ${current_event_url}

Verify Roster candidate number
    [Arguments]    ${expected_number}
    ${roster_number} =    Get text    ${ROSTER_CANDIDATE_NUMBER}
    should be equal as strings    ${roster_number}    ${expected_number}

Add a candidate to the Orientation Event
    [Arguments]    ${event_name}
    Create candidate for Orientation Event
    Click button in email    Schedule your Orientation with Paradox VN: CVS Health NCO.
    ...    Schedule your Orientation with Paradox VN: CVS Health NCO.
    ${locator_event_name} =    FORMAT STRING    ${SELECT_TIME_BUTTON}    ${event_name}
    Click at    ${event_name}
    Click at    ${locator_event_name}
    Wait with medium time

Change Event end time
    Click at    ${EVENT_END_TIME}
    Click at    ${LAST_EVENT_END_TIME_VALUE}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}

Set multiple Session in event
    Click at    ${SCHEDULE_STEP_LABEL}
    Scroll to element    ${SCHEDULE_AVAILABLE_TIME}
    wait until element is visible    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_1}
    Set Virtual session
    wait with short time
    Click by JS    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    Set Virtual session
    wait with short time
    Click by JS    ${SCHEDULE_AVAILABLE_TIME_BLOCK_3}
    Set Virtual session
    wait with short time

Go to register calendar
    [Arguments]    ${candidate_name}    ${candidate_mobile}
    &{email_info} =    Get email for testing
    Click at    ${EVENT_STATUS}
    Input into    ${INPUT_TEXTBOX}    ${candidate_name}
    Click at    ${USER_SEND_REPLY_BUTTON}
    Wait with medium time
    Input into    ${INPUT_TEXTBOX}    ${candidate_mobile}
    Click at    ${USER_SEND_REPLY_BUTTON}
    Wait with medium time
    Input into    ${INPUT_TEXTBOX}    ${email_info.email}
    Click at    ${USER_SEND_REPLY_BUTTON}
    Wait with medium time
    Click at    ${USER_SEND_REPLY_BUTTON}
    Wait with medium time
    Click at    ${SESSION_CALENDAR_LINK}

Check number of session
    [Arguments]    ${number_of_session}
    ${count} =    Get Element Count    ${SESSION_IN_CALENDAR}
    should be equal as strings    ${count}    ${number_of_session}

Input candidate info
    ${numbers} =    Evaluate    random.randint(0, sys.maxsize)    random
    &{email_info} =    Get email for testing
    Input into    ${CEM_FULLNAME}    Test Candidate_${numbers}
    Input into    ${CEM_EMAIL}    ${email_info.email}
    Click at    ${CONFIRM_ADD_CANDIDATE_BUTTON}

Schedule candidate into Event
    [Arguments]    ${event_name}
    Click at    ${CANDIDATE_MORE_BUTTON}
    Click at    ${CANDIDATE_SCHEDULE_BUTTON}
    Click at    ${EVENT_ASSISTANT_BUTTON}
    Click at    ${EVENT_ID_DROPDOWN}
    Input into    ${EVENT_ID_TEXTBOX}    ${event_name}
    ${event_locator} =    Format String    ${EVENT_NAME_FILTERED}    ${event_name}
    Click at    ${event_locator}
    Click at    ${SESSION_DROPDOWN}
    Click at    ${SESSION_NAME_ITEM}
    Click at    ${SUBMIT_SCHEDULE_BUTTON}

Reschedule the interview
    Click at    ${BOOK_TIME_BUTTON}
    Input into    ${EVENT_CONVERSATION_TEXTAREA}    reschedule
    Click at    ${CONVERSATION_SEND_BUTTON}
    Input into    ${EVENT_CONVERSATION_TEXTAREA}    yes
    Click at    ${CONVERSATION_SEND_BUTTON}
    Click at    ${OPEN_CALENDAR_BUTTON}

Create candidate for Orientation Event with invalid location
    ${CONFIG} =    get_config    ${env}
    ${email} =    Set Variable    ${CONFIG.gmail}
    &{candidate_info} =    generate_candidate_info    ${EMPTY}    ${email}
    create_candidate_by_api    ${env}    ${candidate_info}
    [Return]    ${candidate_info.candidateName}

Verify conversation status changed
    [Arguments]    ${message}
    ${is_history_visible} =    Run Keyword And Return Status    Check element display on screen
    ...    ${CONVERSATION_HISTORY_BUTTON}
    IF    ${is_history_visible}
        Click at    ${CONVERSATION_HISTORY_BUTTON}
    END
    ${status_changed} =    get text    ${CONVERSATION_HISTORY_STATUS}
    ${formatted_message} =    Replace String Using Regexp    ${status_changed}    (\r\n|\r|\n)    ${EMPTY}
    Should Contain    ${formatted_message}    ${message}

Set Registration step with Location is not
    [Arguments]    ${location_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Click at    ${SCHEDULE_CONDITION}
    Click at    ${ADD_SCHEDULE_CONDITION}
    Click at    ${SCHEDULE_RULE_CONDITION}
    Click at    ${ASSIGNED_LOCATION_RULE}
    Click at    ${MATCHES_CONDITION}
    Click at    ${MATCHES_IS_NOT}
    Click at    ${LOCATION_SELECTION}
    ${location_locator} =    Format String    ${LOCATION_CHECKBOX}    ${location_name}
    Scroll to element    ${location_locator}
    Click Element    ${location_locator}
    Click Element    ${APPLY_LOCATION_BUTTON}
    Click at    ${SAVE_SCHEDULE_CONDITION_BUTTON}

Create candidate for Orientation Event with custom location id
    [Arguments]    ${location_id}
    ${CONFIG} =    get_config    ${env}
    ${email} =    Set Variable    ${CONFIG.gmail}
    &{candidate_info} =    generate_candidate_info    ${location_id}    ${email}
    create_candidate_by_api    ${env}    ${candidate_info}

Set Registration step with Location is
    [Arguments]    ${location_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Click at    ${SCHEDULE_CONDITION}
    Click at    ${ADD_SCHEDULE_CONDITION}
    Click at    ${SCHEDULE_RULE_CONDITION}
    Click at    ${ASSIGNED_LOCATION_RULE}
    Click at    ${MATCHES_CONDITION}
    Click at    ${MATCHES_IS}
    Click at    ${LOCATION_SELECTION}
    ${location_locator} =    Format String    ${LOCATION_CHECKBOX}    ${location_name}
    Scroll to element    ${location_locator}
    Click Element    ${location_locator}
    Click Element    ${APPLY_LOCATION_BUTTON}
    Click at    ${SAVE_SCHEDULE_CONDITION_BUTTON}

Set Registration step with custom outcome
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Input into    ${NAME_YOUR_OUTCOME_TEXTBOX}    test_outcome
    Click at    ${STARTING_VALUE_DROPDOWN}
    Click at    ${ASSIGNED_LOCATION_VALUE}
    Click at    ${MATCHES_VALUE_DROPDOWN}
    Click at    ${MATCHES_IS_ANY}
    Click at    ${INPUT_DROPDOWN}
    ${location_locator} =    Format String    ${INPUT_VALUE}    All Locations
    Click Element    ${location_locator}
    ${checkbox_locator} =    Format String    ${LOCATION_CHECKBOX}    Unassigned
    Click Element    ${checkbox_locator}
    Click Element    ${APPLY_INPUT_BUTTON}
    Click at    ${CONFIRM_ADD_OUTCOME_BUTTON}

Change Action in Outcome
    [Arguments]    ${event_page}
    go to    ${event_page}
    Click at    ${SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${REGISTRATION_STEP_LABEL}
    Click at    ${OUTCOME_ORDER_2}
    Click at    ${OUTCOME_ACTION}
    Click at    Register for Event
    Click at    ${SAVE_OUTCOME_BUTTON}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}

Delete an Outcome
    [Arguments]    ${event_page}
    go to    ${event_page}
    Click at    ${SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${REGISTRATION_STEP_LABEL}
    Click at    ${OUTCOME_ACTION_ORDER_2}
    Click at    ${DELETE_OUTCOME_BUTTON}
    Click at    ${CONFIRM_DELETE_OUTCOME_BUTTON}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}

Reschedule the interview with new outcome
    [Arguments]    ${schedule_page}
    go to    ${schedule_page}
    Click at    ${SESSION_IN_CALENDAR}
    Input into    ${EVENT_CONVERSATION_TEXTAREA}    reschedule
    Click at    ${CONVERSATION_SEND_BUTTON}
    Input into    ${EVENT_CONVERSATION_TEXTAREA}    yes
    Click at    ${CONVERSATION_SEND_BUTTON}
    Click at    ${OPEN_CALENDAR_BUTTON}

Create event go to widget site
    [Arguments]    ${conversation_name}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_dynamic_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step       ${job_requisition_id_1}
    Click at    ${TEAM_STEP_LABEL}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None       ${conversation_name}
    Set Tools step
    Go to event register page
    wait with medium time
    [Return]    ${event_dynamic_name}

Input infor candidate on event widget site
    [Arguments]    ${event_name}
    Check element display on screen    ${REGISTER_EVENT_IN_PROGRESS}
    Check message widget site response correct   ${LANDING_SITE_ASK_NAME}
    ${candidate_info} =      Generate candidate name
    Input text for widget site    ${candidate_info.full_name}
    ${verify_message} =     Format String   ${EVENT_EMAIL_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    &{email_info} =    Get email for testing    is_spam_email=False
    Input text for widget site    ${email_info.email}
    Check message widget site response correct    ${LOCATION_DISCOVERY}
    Check message widget site response correct    ${LANDING_SITE_SELECT_LOCATION}
    Input text for widget site    ${LOCATION_STREET_TRUNG_NU_VUONG}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    Check message widget site response correct    ${LANDING_SITE_FAST_TRACK}
    ${candidate_info.email} =   Set variable    ${email_info}
    [Return]    ${candidate_info}

Select an event and cancel event
    [Arguments]    ${event_dynamic_name}
    Go to Events page
    Search event    ${event_dynamic_name}
    Click on ellipses icon on the Event Occurrence row
    Click at    ${EDIT_EVENT}
    Click at    ${OVERVIEW_STEP_LABEL}
    Click at    ${CANCEL_EVENT_BUTTON}
    Click at    ${CONFIRM_CANCEL_EVENT}
    Click at    ${CANCEL_AND_SEND_BUTTON}

Registered a candidate to an event
    [Arguments]    ${event_dynamic_name}
    Go to Events page
    Search event    ${event_dynamic_name}
    Click at    ${event_dynamic_name}
    Click at    ${CANDIDATE_TAB}
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_ICON_PLUS}
    Input CEM Full name and email    is_spam_email=False

Go to edit event
    [Arguments]     ${event_name}
    wait with short time
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click by JS     ${UPCOMING_MENU_ITEM_BY_NAME}    ${event_name}
    Click at        ${EDIT_ICON}
    wait for page load successfully

Go to edit recurring event
    [Arguments]     ${event_name}
    wait with short time
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${RECURRING_MENU_ITEM_BY_NAME}    ${event_name}
    Click at        ${EDIT_ICON}
    wait for page load successfully

Select event templates
    [Arguments]    ${event_template_name}
    Click on p text    ${event_template_name}

Cancel the Event
    Click at    ${DASH_BOARD_NAVIGATION}
    Click at    ${SETTING_ICON}     slow_down=1s
    Click at    ${CANCEL_EVENT_ICON}     slow_down=1s
    Click at    ${CANCEL_EVENT_POPUP_CONFIRM_BUTTON}
    Click at    ${CANCEL_EVENT_POPUP_CANCEL_AND_SEND_BUTTON}

Manually add a Candidate to Event
    [Arguments]     ${is_spam_email}=True   ${location}=None
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name}=  Input CEM Full name and email   ${is_spam_email}       ${location}
    [Return]    ${candidate_name}

Search and go to event homepage
    [Arguments]     ${event_name}
    Input into      ${SEARCH_EVENT_INPUT}       ${event_name}
    wait for page load successfully
    Click at        ${event_name}
    wait for page load successfully

Add candidate at event homepage
    [Arguments]     ${session_time}
    wait for page load successfully
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    wait for page load successfully
    &{candidate_name}=  Add candidate to event      ${session_time}
    [Return]    &{candidate_name}

Add candidate to event
    [Arguments]     ${session_time}
    Click at    ${EVENT_SCHEDULE_ADD_CANDIDATE_BUTTON}      ${session_time}
    Check span display      Add Candidate to Open Interview Time
    &{candidate_name}=  Input CEM Full name and email       is_spam_email=False
    [Return]    &{candidate_name}

Add candidate at event dashboard
    [Arguments]     ${session_name}      ${group_name}=None     ${is_spam_email}=True
    Open event schedule tab with table view
    Click at    ${EVENT_SCHEDULE_ADD_CANDIDATE_BUTTON}      ${session_name}
    &{email_info} =    Get email for testing    ${is_spam_email}
    ${candidate_first_name} =    Generate random text only
    ${candidate_last_name} =    Generate random text only
    Input into    ${CEM_FIRSTNAME}    ${candidate_first_name}
    Input into    ${CEM_LASTNAME}     ${candidate_last_name}
    Input into    ${CEM_EMAIL}    ${email_info.email}
    IF      '${group_name}' != 'None'
        Click at    ${GROUP_SELECTION_DROPDOWN}
        Input into    ${GROUP_SEARCH_TEXT_BOX}    ${group_name}
        Click at    ${CANDIDATE_GROUP_NAME_OPTION}    ${group_name}
    END
    Click at    ${EVENT_CEM_ADD_CANDIDATE_BUTTON}
    wait for page load successfully
    ${candidate_name} =     Set variable    ${candidate_first_name} ${candidate_last_name}
    [Return]    ${candidate_name}

Add interviewer for candidate
    [Arguments]     ${session_time}     ${interviewer}
    Click by JS    ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}    ${session_time}
    Click on common text last   ${interviewer}
    wait for page load successfully

Go to edit event page from dashboard
    Click at    ${DASH_BOARD_NAVIGATION}
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${EDIT_EVENT}
    wait for page load successfully

Cancel event from event list
    [Arguments]     ${event_name}
    Go to Events page
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${UPCOMING_MENU_ITEM_BY_NAME}    ${event_name}
    Click at        ${DELETE_ICON}
    Click at        ${CONFIRM_CANCEL_EVENT}
    Click at        ${CANCEL_AND_SEND_BUTTON}
    wait for page load successfully

Cancel or delete event from event list
    [Arguments]     ${event_name}
    Go to Events page
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${UPCOMING_MENU_ITEM_BY_NAME}    ${event_name}
    Click at        ${DELETE_ICON}
    ${is_deleted}=  Run keyword and return status   Click at        ${CONFIRM_CANCEL_EVENT}     wait_time=2s
    IF  '${is_deleted}' == 'True'
        Click at        ${CANCEL_AND_SEND_BUTTON}
    ELSE
        Click at        ${CONFIRM_DELETE_EVENT_BUTTON}
    END
    wait for page load successfully

Go to event dashboard
    [Arguments]     ${event_name}
    Go to Events page
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${event_name}

Check event template status
    [Arguments]    ${event_template_name}      ${status}
    Go to Events page
    click on Create New Event button
    wait for page load successfully v1
    Click on p text    Event Templates
    Click at        ${EVENT_SELECTION_TEMPLATE_SEARCH}
    Input into      ${EVENT_SELECTION_TEMPLATE_SEARCH}      ${event_template_name}
    IF      '${status}' == 'Published'
            Check element display on screen         ${EVENT_TEMPLATE_NAME_PUBLISHED}        ${event_template_name}
    ELSE
            Check element not display on screen         ${EVENT_TEMPLATE_NAME_PUBLISHED}        ${event_template_name}
    END

Add candidate at All Candidates
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    &{candidate_name} =     Input CEM Full name and email
    [Return]    &{candidate_name}

Cancel event from event list without candidate schedule
    [Arguments]     ${event_name}
    Go to Events page
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${UPCOMING_MENU_ITEM_BY_NAME}    ${event_name}
    Click at        ${DELETE_ICON}
    Click at        ${CONFIRM_DELETE_EVENT_BUTTON}
    wait for page load successfully
    Check element display on screen     ${event_name}

Duplicated event in homepage
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${DUPLICATE_ICON}
    wait for page load successfully

Search and duplicated event in event page
    [Arguments]     ${event_name}
    Input into      ${SEARCH_EVENT_INPUT}       ${event_name}
    wait for page load successfully
    Click at        ${RECURRING_MENU_ITEM_BY_NAME}      ${event_name}
    Click at        ${DUPLICATE_ICON}
    Check element display on screen     Overview

Open event schedule tab with table view
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    wait for page load successfully
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}

Candidate can not rechedule an orientation event
    Click at    Yes
    Check element not display on screen     Action confirmation
    Check element display on screen    ${EVENT_ORIENTATION_RESCHEDULE}
    Input text and send message    yes
    Check element display on screen    ${EVENT_ORIENTATION_UNABLE_TO_RESCHEDULE}
    Capture page screenshot

Candidate can not cancel orientation event
    Input text and send message    cancel
    Check element display on screen    ${EVENT_ORIENTATION_CANCEL}
    Input text and send message    yes
    Check element display on screen    ${EVENT_UNABLE_TO_CANCEL_REGISTRATION}
    Capture page screenshot

Candidate can cancel orientation event
    Input text and send message    cancel
    Check element display on screen    ${EVENT_ORIENTATION_CANCEL}
    Input text and send message    yes
    Check element display on screen    ${EVENT_ORIENTATION_CANCEL_CONFIRM}
    Capture page screenshot

Candidate can not rerechedule an orientation event in landing site
    Input text and send message    reschedule
    Check element display on screen    ${EVENT_ORIENTATION_RESCHEDULE}
    Input text and send message    yes
    Check element display on screen    ${EVENT_ORIENTATION_UNABLE_TO_RESCHEDULE}
    Capture page screenshot

Candidate rechedule an orientation event via email
    [Arguments]    ${first_name}   ${company_name}
    Click at    Yes
    Check element not display on screen     Action confirmation
    Check element display on screen    ${EVENT_ORIENTATION_RESCHEDULE}
    Input text and send message    yes
    Check element display on screen    ${EVENT_ORIENTATION_REGISTRATION_RESCHEDULE}
    Input text and send message    1
    wait for page load successfully
    ${verify_message} =     Format String   ${EVENT_ORIENTATION_RESCHEDULE_CONFIRM}   ${first_name}   ${company_name}
    Check element display on screen    ${verify_message}
    Capture page screenshot

Candidate rechedule an orientation event in landing site
    [Arguments]    ${first_name}   ${company_name}
    Input text and send message    reschedule
    Check element display on screen    ${EVENT_ORIENTATION_RESCHEDULE}
    Input text and send message    yes
    Check element display on screen    ${EVENT_ORIENTATION_REGISTRATION_RESCHEDULE}
    Input text and send message    1
    wait for page load successfully
    ${verify_message} =     Format String   ${EVENT_ORIENTATION_RESCHEDULE_CONFIRM}   ${first_name}   ${company_name}
    Check element display on screen    ${verify_message}
    Capture page screenshot

Set Event Rating Trigger in Tools step
    [Arguments]    ${audience_tab}    ${touchpoint}    ${delivery}      ${rating_name}
    # ${audience_tab} can be Users/Candidates
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    ${audience_tab}
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    ${touchpoint}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${delivery}
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${rating_name}
    Click at    ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_SAVE_BUTTON}

Check approval status and verify history change
    [Arguments]    ${status}    ${team}    ${history_check_text}   ${approver_display}=False   ${history_display}=False
    Check Text Display      ${status}
    Capture Page Screenshot
    Click At                ${EVENT_ACTIVITY_DASHBOARD_VIEW_APPROVAL_FLOW_BUTTON}
    IF   '${approver_display}' == 'False'
        Check Element Not Display On Screen             ${team}   wait_time=4
    ELSE
        Check Text Display      ${team}
    END
    Capture Page Screenshot
    Click At                ${EVENT_ACTIVITY_DASHBOARD_APPROVAL_FLOW_HISTORY_BUTTON}
    IF   '${history_display}' == 'False'
        Check Element Not Display On Screen             ${history_check_text}   wait_time=4
    ELSE
        Check Element Display On Screen                 ${history_check_text}
    END
    Capture Page Screenshot

Check campus event approval status
    [Arguments]    ${event_name}    ${status}
    Go To Event Dashboard                           ${event_name}
    Wait For Page Load Successfully V1
    Check Text Display      ${status}
    Capture Page Screenshot

Create a new segment with event status
    [Arguments]         ${segment_name}=None        @{event_status_list}
    Click At    ${FILTER_BUTTON}
    ${event_status_list_length}=  Get Length    ${event_status_list}
    IF      ${event_status_list_length} == 0
        @{event_status_list}=       Create List     Upcoming    Past
    END
    Select option to filter     Event Status    @{event_status_list}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_SAVE_SEGMENT}
    IF      '${segment_name}' == 'None'
        ${segment_name}=    Generate Random Name Only Text    auto_segment
    END
    Input Into    ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_TEXTBOX}      ${segment_name}
    Element Should Be Enabled    ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_SAVE}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_SAVE}
    [Return]    ${segment_name}

Create a new segment with approval status
    [Arguments]         ${segment_name}=None        @{approval_status_list}
    Click At    ${FILTER_BUTTON}
    ${approval_status_list_length}=  Get Length    ${approval_status_list}
    IF      ${approval_status_list_length} == 0
        @{approval_status_list}=       Create List     Draft
    END
    Select option to filter     Approval status    @{approval_status_list}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_SAVE_SEGMENT}
    IF      '${segment_name}' == 'None'
        ${segment_name}=    Generate Random Name Only Text    auto_segment
    END
    Input Into    ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_TEXTBOX}      ${segment_name}
    Element Should Be Enabled    ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_SAVE}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_SAVE}
    [Return]    ${segment_name}

Delete a segment
    [Arguments]    ${segment_name}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_EXTEND}     ${segment_name}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_DELETE_TAG}
    Check Element Display On Screen    ${EVENT_CAMPUS_PLAN_SEGMENT_DELETE_MODAL}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_DELETE_BUTTON}
