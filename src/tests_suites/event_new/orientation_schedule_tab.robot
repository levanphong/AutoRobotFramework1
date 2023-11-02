*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${orientation}                      Orientation
${olivia_assist_message}            You have 1 session that needs to be updated
${olivia_assist_message_help}       How can I help?
${olivia_assist_message_update}     You have 1 session that need to be updated! To start, click on one of the sessions below

*** Test Cases ***
Verify UI of Add a Session slide out in Orientation with Virtual Session Venue and no setting Webex as the Video Technology provider in Client Setup (OL-T4685)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Set session venue type    Virtual
    Add event session form is displayed


Verify Add a Session slide out when Webex is selected as the Video Technology provider within Client Setup (OL-T4686)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Select Virtual Technology Prodiver    Webex
    Input virtual technology information
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Set session venue type    Virtual
    Add event session form is displayed
    Go to Client setup page
    Select Virtual Technology Prodiver    None


Verify adding session staff into sessions (OL-T4687)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click by JS    ${SCHEDULE_AVAILABLE_TIME}
    Run keyword and ignore error    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test session
    Set session staff    ${TEAM_USER}
    click save session button


Verify removing users from the list of added session if their RSVP status change to Not Going (OL-T4688)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Team step    CA Team
    Set Schedule step
    Set tool step and create event
    Switch to user    CA Team
    Choose Not Going event for user
    Switch to user    ${TEAM_USER}
    Go to Events page
    Go to edit event    ${event_name}
    Click at    ${SCHEDULE_STEP_LABEL}
    Click by JS    ${SCHEDULE_AVAILABLE_TIME}
    Click at    ${EDIT_SESSION_BUTTON}
    wait with short time
    Click at    ${SESSION_STAFF_TEXTBOX}
    ${user_locator} =    format string    ${SESSION_STAFF_USER_CHECKBOX}    CA Team
    element should be disabled    ${user_locator}


Verify removing users out of Session Staff (OL-T4689)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test session
    Set session staff    CA Team
    Click at    ${DELETE_SESSION_STAFF_ICON}    CA Team
    click save session button


Verify adding Virtual venue session successfully (OL-T4690)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step


Verify adding In-person venue session in Orientation event successfully (OL-T4691)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Schedule step    None    In Person


Verify showing Event Session popup when users click on the block time of Event Session (OL-T4692)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${SESSION_TITLE}    test_session
    Interview Details Popup is displayed    test_session


Check updating sessions that their time are not within Start and End date time of the Orientation Event (OL-T4707, OL-T4766)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Turn ON Olivia Assist toggle
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Set tool step and create event
    Event created successfully    ${event_name}
    Go to Events page
    Go to edit event    ${event_name}
    choose next day for start date
    Edit Event warning popup is displayed
    Check element display on screen    ${olivia_assist_message}
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${UPDATE_SESSIONS_BUTTON}
    wait with short time
    Check element display on screen    ${olivia_assist_message_help}
    Click on span text    Edit Event Sessions
    Check element display on screen    ${olivia_assist_message_update}
    Click at    test_session
    Input into  ${SESSION_NAME_TEXTBOX}   test_session_edited
    click save session button
    Check element not display on screen   ${COMMON_TEXT}   ${olivia_assist_message}
    Set tool step and create event
    Event created successfully    ${event_name}


Verify a user can be added into session which their time are not overlap each other (OL-T4765)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_1}
    Input into    ${SESSION_NAME_TEXTBOX}    test session 1
    Set session staff   ${TEAM_USER}
    click save session button
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    Input into    ${SESSION_NAME_TEXTBOX}    test session 2
    Set session staff    ${TEAM_USER}
    click save session button
    Set tool step and create event
    Event created successfully    ${event_name}


Verify users will be unavailable in Add Session Staff when they are added to the session has time overlap with other sessions (OL-T4772)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Team step   Full User
    Set Schedule step
    Click at    ${SESSION_TITLE}    test_session
    Click at    ${DUPLICATE_SESSION_BUTTON}
    Input into  ${SESSION_NAME_TEXTBOX}     test_session_duplicated
    click save session button
    Click at    ${SESSION_TITLE}    test_session
    Click at    ${EDIT_SESSION_BUTTON}
    Set session staff   Full User
    click save session button
    Click at    ${SESSION_TITLE}    test_session_duplicated
    Click at    ${EDIT_SESSION_BUTTON}
    Click at    ${SESSION_STAFF_TEXTBOX}
    ${staff_locator} =   format string   ${SESSION_STAFF_USER_CHECKBOX}  Full User
    Element should be disabled      ${staff_locator}


Verify users can edit Event Session when clicking Edit icon on Event Session popup (OL-T4774)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${SESSION_TITLE}    test_session
    Click at    ${EDIT_SESSION_BUTTON}
    Input into  ${SESSION_NAME_TEXTBOX}     test_session_edited
    click save session button
    Check element display on screen     ${SESSION_TITLE}    test_session_edited


Verify users can delete Event Session when users click on Delete icon in Event Session popup (OL-T4775)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${SESSION_TITLE}    test_session
    Click at    ${DELETE_SESSION_BUTTON}
    Click at    ${CONFIRM_DELETE_SESSION_BUTTON}
    Check element not display on screen   ${SESSION_TITLE}    test_session


Verify users can duplicate Event Session when clicking on Duplicate icon in Event Session popup (OL-T4776)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${SESSION_TITLE}    test_session
    Click at    ${DUPLICATE_SESSION_BUTTON}
    Input into  ${SESSION_NAME_TEXTBOX}     test_session_duplicated
    click save session button
    Check element display on screen   ${SESSION_TITLE}    test_session
    Check element display on screen   ${SESSION_TITLE}    test_session_duplicated


Verify users can close the Event Session popup when clicking on X icon (OL-T4778)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${SESSION_TITLE}    test_session
    Click at    ${HIDE_SESSION_BUTTON}
    Check element not display on screen     ${SESSION_DETAIL_POPUP_TITLE}    test_session


Verify UI of Add a Session slide out in Orientation event when users select In-person as Session Venue (OL-T4782, OL-T4784)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Schedule step   None    In Person
    Set tool step and create event
    Event created successfully    ${event_name}


Check the users added into My Event Team step are in the Available session staff for the new event within the first event session. (OL-T4785)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Team step   Full User
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test_session
    Click at                ${SESSION_STAFF_TEXTBOX}
    ${staff_locator} =   format string   ${SESSION_STAFF_USER_CHECKBOX}  ${TEAM_USER}
    element should be enabled      ${staff_locator}
    ${staff_locator} =   format string   ${SESSION_STAFF_USER_CHECKBOX}  Full User
    Element should be enabled      ${staff_locator}


Verify the Venue Location and Venue name are pre-fill and unable to edit when adding session in Orientation Event with Candidate Store Location as Event Venue (OL-T5049)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Turn ON Candidate Store Location Available
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Candidate Store Location    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test_session
    Set session venue type    Candidate Store Location
    Element should be disabled      ${SESSION_CANDIDATE_LOCATION_ADDRESS_TEXTBOX}
    Element should be disabled      ${SESSION_CANDIDATE_LOCATION_NAME_TEXTBOX}
    ${candidate_location_address} =  Get attribute and format text   placeholder     ${SESSION_CANDIDATE_LOCATION_ADDRESS_TEXTBOX}
    should be equal as strings      ${candidate_location_address}   \#candidate-location-address
    ${candidate_location_name} =     Get attribute and format text   placeholder     ${SESSION_CANDIDATE_LOCATION_NAME_TEXTBOX}
    should be equal as strings      ${candidate_location_name}   \#candidate-location-name


Verify the Venue Location and Venue name are pre-fill and able to edit when adding session in Orientation Event with In-person as Event Venue (OL-T5050)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test_session
    Set session venue type    In Person
    Element should be enabled      ${VENUE_LOCATION_TEXTBOX}
    Element should be enabled      ${VENUE_NAME_TEXTBOX}
    ${venue_location} =  Get value and format text    ${VENUE_LOCATION_TEXTBOX}
    should be equal as strings      ${venue_location}   Venue test location
    ${venue_name} =     Get value and format text     ${VENUE_NAME_TEXTBOX}
    should be equal as strings      ${venue_name}    Venue test name
    Input into      ${VENUE_LOCATION_TEXTBOX}   Venue test location edited
    Input into      ${VENUE_NAME_TEXTBOX}       Venue test name edited
    Click save session button


Check the user can be able to add to another event with the same event session time (OL-T5053)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
	click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Team step   Full User
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test_session
    Set session staff   Full User
    Click save session button
    Set tool step and create event
    Event created successfully  ${event_name}
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Team step   Full User
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${SCHEDULE_AVAILABLE_TIME}
    Input into    ${SESSION_NAME_TEXTBOX}    test_session
    Click at                ${SESSION_STAFF_TEXTBOX}
    ${staff_locator} =   format string   ${SESSION_STAFF_USER_CHECKBOX}  Full User
    Element should be enabled       ${staff_locator}
    Click at    ${staff_locator}
    Click save session button
    Set tool step and create event
    Event created successfully      ${event_name}


Verify UI of Event Agenda once sessions have been created (OL-T5102)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
	click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Check element display on screen     ${SESSION_TITLE}    test_session
    Click at    ${SESSION_TITLE}    test_session
    Interview Details Popup is displayed    test_session

*** Keywords ***
Add event session form is displayed
    Check element display on screen    ${SESSION_NAME_TEXTBOX}
    Check element display on screen    ${START_TIME_TXT}
    Check element display on screen    ${END_TIME_TXT}
    Check element display on screen    ${SESSION_VENUE_DROPDOWN}
    Check element display on screen    ${SESSION_URL_TEXTBOX}
    Check element display on screen    ${SESSION_URL_PASS_TEXTBOX}
    Check label display    Hide Session URL & Password from unregistered Candidates
    Check toggle is Off    ${HIDE_URL_TOGGLE}
    Check element display on screen    ${DESCRIPTION_EVENT_SESSION}
    Check element display on screen    ${SESSION_STAFF_TEXTBOX}

Interview Details Popup is displayed
    [Arguments]    ${session_name}
    ${session_title_locator} =    format string    ${SESSION_DETAIL_POPUP_TITLE}    ${session_name}
    Check element display on screen    ${session_title_locator}
    Check element display on screen    ${SESSION_DETAIL_POPUP_START_DATE}
    Check element display on screen    ${SESSION_DETAIL_POPUP_DATE}
    Check element display on screen    ${SESSION_DETAIL_POPUP_STAFF}
    Check element display on screen    ${SESSION_DETAIL_POPUP_ITV_TYPE}
    Check element display on screen    ${EDIT_SESSION_BUTTON}
    Check element display on screen    ${DUPLICATE_SESSION_BUTTON}
    Check element display on screen    ${DELETE_SESSION_BUTTON}
    Check element display on screen    ${HIDE_SESSION_BUTTON}
