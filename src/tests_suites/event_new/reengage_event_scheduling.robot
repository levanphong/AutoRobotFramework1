*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/conversation_page.robot
Library             ../../utils/StringHandler.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    lts_stg    olivia    regression    stg      test

*** Variables ***
${is_spam_email}    True

*** Test Cases ***
Verify the text All Registered Candidates is updated to All Candidates with Hiring Events (OL-T16024)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Schedule step    Scheduled Interviews
    Set tool step and create event
    Click at    ${CANDIDATE_MENU_LABEL}
    Check element display on screen     All Candidates
    Check element not display on screen     All Registered Candidates
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Check the 'No Event Interview Availability' status is added to the Event stage in Candidate Journeys (OL-T16023)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Candidate Journeys page
    Click a Journey     ${RE_ENGAGE_EVENT_JOURNEY_NAME}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Event
    Click at    No Event Interview Availability
    Check span display      Any candidate who can not be scheduled because of the lack of interview availability is placed in this status.
    Check span display      This status cannot be removed from an event stage.
    Capture page screenshot


Verify the candidate will received the closing message when they registered & scheduled to event interview which has only interview sessions but no available interview slots (OL-T16029, OL-T16025)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name} =     Given new re engage event with name
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Set Registration step   None   None   ${RE_ENGAGE_EVENT_CONVERSATION_NAME}
    And Set Tools step
    Add candidate at event dashboard      ${session_info.session_name}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input needed information for candidate  ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct  ${verify_message}
    Check message widget site response correct  ${EVENT_HOW_ELSE_MAY_I_ASSIST_YOU}
    Capture page screenshot
    #   Check the icon-cal-upcoming icon will appear on the candidate within the list view and a banner will appear on the candidate’s profile when a candidate’s status is ‘No Event Interview Availability’ (OL-T16025)
    Verify candidate journey status     ${candidate_info.full_name}    No Event Interview Availability
    Check element display on screen     Olivia is waiting for availability within the ${event_name} event
    Check element display on screen     ${CANDIDATE_ICON_CAL_UPCOMING}      ${candidate_info.full_name}
    Cancel event from event list    ${event_name}


Verify the candidate's status is moved to No Event Interview Availability when the candidate’s Registration Outcome is Register & Schedule for Event Interview but all interview slots are booked (OL-T16026)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name} =     Given new re engage event with name
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Set Registration step   None   None   ${RE_ENGAGE_EVENT_CONVERSATION_NAME}
    ${outcome_name} =    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Add screening question age for outcome
    And Set Tools step
    Add candidate at event dashboard      ${session_info.session_name}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input needed information for candidate   ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct  ${verify_message}
    Verify candidate journey status     ${candidate_info.full_name}    No Event Interview Availability
    Check element display on screen     Olivia is waiting for availability within the ${event_name} event
    Check element display on screen     ${CANDIDATE_ICON_CAL_UPCOMING}      ${candidate_info.full_name}
    Cancel event from event list    ${event_name}


Verify the candidate will received the Registration Confirmation message when they registered & scheduled to event interview which has interview sessions and non-interview sessions but no available interview slots (OL-T16030)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name} =     Given new re engage event with name
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Set Schedule step    Event Session
    Set Registration step   None   None   ${RE_ENGAGE_EVENT_CONVERSATION_NAME}
    ${outcome_name} =    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Add screening question age for outcome
    And Set Tools step
    Add candidate at event dashboard      ${session_info.session_name}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input needed information for candidate   ${event_name}
    ${event_date} =      get_future_day_from_curent_date
    Capture page screenshot
    ${verify_message} =     Format String   ${EVENT_REGISTER_SUCCESSFULLY}  first_name=${candidate_info.first_name}    company_name=${COMPANY_EVENT}   event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${event_date}
    Check message widget site response correct    ${EVENT_OUR_TEAM_WAIT_FOR_MEETING_YOU}
    Verify candidate journey status     ${candidate_info.full_name}    Registration Confirmed
    Cancel event from event list    ${event_name}


Verify the candidate's status is moved to No Event Interview Availability when the candidate pick interview slots but they are no longer available (OL-T16031, OL-T16034)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name} =     Given new re engage event with name
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Set Registration step   None   None   ${RE_ENGAGE_EVENT_CONVERSATION_NAME}
    And Set Tools step
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input needed information for candidate   ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Verify candidate journey status     ${candidate_info.full_name}    Event Interview Pending
    Go to Events page
    Search event    ${event_name}
    Click at    ${event_name}
    Add candidate at event dashboard      ${session_info.session_name}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    Input text for widget site    1
    Check message widget site response correct      ${EVENT_NO_INTERVIEW_TO_SCHEDULE}
    Capture page screenshot
    Verify candidate journey status     ${candidate_info.full_name}    No Event Interview Availability
    Go to Events page
    Go to edit event    ${event_name}
    Go to edit session popup    ${session_info.session_name}
    Set Interview Time Slot Per Duration    2 Interview Time Slots
    And click save session button
    Set tool step and create event
    #   Verify re-engage to candidates that are in "No Event Interview Availability" with Auto Event Scheduling (OL-T16034)
    Verify candidate journey status     ${candidate_info.full_name}    Event Interview Pending
    Cancel event from event list    ${event_name}


Verify re-engage selected sessions in Outcomes to candidates that are in No Event Interview Availability when the user adds additional interview sessions (OL-T16028)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name} =     Given new re engage event with name
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Set Registration step   None   None
    ${outcome_name} =    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Add screening question age for outcome
    And Set Tools step
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input needed information for candidate   ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Verify candidate journey status     ${candidate_info.full_name}    Event Interview Pending
    Go to Events page
    Search event    ${event_name}
    Click at    ${event_name}
    Add candidate at event dashboard      ${session_info.session_name}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    Input text for widget site    1
    Check message widget site response correct      ${EVENT_NO_INTERVIEW_TO_SCHEDULE}
    Capture page screenshot
    Verify candidate journey status     ${candidate_info.full_name}    No Event Interview Availability
    Go to Events page
    Go to edit event    ${event_name}
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Edit outcome and save event     ${outcome_name}     ${session_info.session_name}
    Verify candidate journey status     ${candidate_info.full_name}    Event Interview Pending
    Cancel event from event list    ${event_name}


Verify re-engage to candidates that are in No Event Interview Availability with manual scheduling case (OL-T16032)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name} =     Given new re engage event with name
    &{session_info} =   Set Schedule step    Scheduled Interviews
    Set Registration step   None   None   ${RE_ENGAGE_EVENT_CONVERSATION_NAME}
    And Set Tools step
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input needed information for candidate   ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Verify candidate journey status     ${candidate_info.full_name}    Event Interview Pending
    Go to Events page
    Search event    ${event_name}
    Click at    ${event_name}
    Add candidate at event dashboard      ${session_info.session_name}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    Click at    ${DASH_BOARD_NAVIGATION}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    Input text for widget site    1
    Check message widget site response correct      ${EVENT_NO_INTERVIEW_TO_SCHEDULE}
    Capture page screenshot
    Verify candidate journey status     ${candidate_info.full_name}    No Event Interview Availability
    Go to Events page
    Go to edit event    ${event_name}
    Go to edit session popup    ${session_info.session_name}
    Set Interview Time Slot Per Duration    2 Interview Time Slots
    And click save session button
    Set tool step and create event
    Verify candidate journey status     ${candidate_info.full_name}    Event Interview Pending
    Cancel event from event list    ${event_name}

*** Keywords ***
Verify candidate journey status
    [Arguments]     ${candidate_name}       ${status}
    Go to CEM page
    Click on candidate name    ${candidate_name}
    ${candidate_status} =    format string    ${CANDIDATE_JOURNEY_STATUS}    ${status}
    Check element display on screen     ${candidate_status}
    Capture page screenshot

Add screening question age for outcome
    [Arguments]
    Click at    ${ADD_OUTCOME_AND_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    Age
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click on common text last    At least
    Input into  ${NUMERIC_INPUT_TEXTBOX}    20
    Click at    ${SAVE_OUTCOME_BUTTON}

Input needed information for candidate
    [Arguments]     ${event_name}
    Check element display on screen    ${REGISTER_EVENT_IN_PROGRESS}
    ${verify_message} =     Format String   ${EVENT_NAME_QUESTION}  company_name=${COMPANY_EVENT}   event_name=${event_name}
    Check message widget site response correct   ${verify_message}
    ${candidate_info} =      Generate candidate name
    Input text for widget site    ${candidate_info.full_name}
    ${verify_message} =     Format String   ${EVENT_MOBILE_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    Input text for widget site    ${CONST_PHONE_NUMBER}
    ${verify_message} =     Format String   ${EVENT_EMAIL_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    &{email_info} =    Get email for testing
    Input text for widget site    ${email_info.email}
    Check message widget site response correct    ${ASK_AGE}
    Input text for widget site    30
    Check message widget site response correct    ${EVENT_CONTACT_QUESTION}
    Click on option in conversation    Email Only
    Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    [Return]    ${candidate_info}

Given new re engage event with name
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    ${event_name} =    Set Overview step with future time    In Person    Single Event
    [Return]    ${event_name}

Edit outcome and save event
    [Arguments]     ${outcome_name}     ${session_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Click at    ${SESSION_CANDIDATE_CAN_SCHEDULE_DROPDOWN}
    Click at    ${SESSION_NAME_CHECKBOX_LAST}    ${session_name}
    Click at    ${SESSION_TO_SCHEDULE_APPLY_BUTTON}
    Click at    ${SAVE_OUTCOME_BUTTON}
    Set tool step and create event
