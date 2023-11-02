*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/users_page.robot
Resource            ../../pages/my_calendar_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        regression    dev2    stg   olivia  birddoghr   advantage  aramark     lts_stg   skip    test

*** Variable ***
# TODO  check what is EV role?
${EV_team}                  EV Team
${interview_settings}       Auto-Assign Interviewers
${start_time}               08:00 AM
${end_time}                 05:00 PM
${session_time_slot_1}      09:00am - 09:15am
${session_time}             09:15am - 09:30am

*** Test Cases ***
Verify a pop-up will appear when the user clicks on the Hiring Event-specific ‘Busy Time’ (OL-T20594, OL-T20589, OL-T20595, OL-T22498)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
	${event_name}=      Set Overview step with future time    Virtual    Single Event
	${event_date} =      get_future_day_from_curent_date
	${date_in_string} =        get_future_date_in_string       ${event_date}
	And Set Team step       ${FO_TEAM}
    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FO_TEAM}      Auto-Assign Interviewers
	Click at    ${EVENT_TOOLS_TEXT}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Switch to user    ${FO_TEAM}
    Choose going event for user
    Wait with medium time
    Go to My Calendar page by action
    #   Verify a Hiring Event-specific ‘Busy Time’ will appear on My Calendar when the user is added as an Interviewer for an interview session (OL-T20589)
    #   Verify a pop-up will appear when the user clicks on the Hiring Event-specific ‘Busy Time’ (OL-T20594)
    Verify event popup appear correctly      ${event_name}      ${date_in_string}
    #   Verify the user is directed to the My Event Schedule tab within the event when the user clicks on the ‘View My Event Schedule’ button (OL-T20595)
    Click at    ${VIEW_MY_EVENT_SCHEDULE_BUTTON}
    User is at my event schedule page       ${event_name}
    Go to Events page
    Switch to user    ${TEAM_USER}
    Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
	${event_name_2}=      Set Overview step with future time    Virtual    Single Event
	And Set Team step       ${FO_TEAM}
    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FO_TEAM}      Auto-Assign Interviewers
	Click at    ${EVENT_TOOLS_TEXT}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Switch to user    ${FO_TEAM}
    Choose going event for user
    Wait with medium time
    Go to My Calendar page by action
    Verify event popup appear correctly      ${event_name}          ${date_in_string}
    Check element not display on screen      ${event_name_2}
    #   Verify the displaying of Hiring Event-specific ‘Busy Time’ when the user was added to sessions of different events that overlap session time (OL-T22498)
    Go to Events page
    Switch to user    ${TEAM_USER}
    Search and delete event     ${event_name}
    Search and delete event     ${event_name_2}


Verify the displaying of Hiring Event-specific ‘Busy Time’ when the user was added to multiple interview sessions that overlap for the same event (OL-T20590)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
	${event_name} =      Set Overview step with future time    Virtual    Single Event
	${event_date} =      get_future_day_from_curent_date
	${date_in_string} =        get_future_date_in_string       ${event_date}
	And Set Team step       ${EE_TEAM}
    ${session_name} =       Set session schedule with interviewer   Virtual Scheduled Interviews    ${EE_TEAM}      Auto-Assign Interviewers
    Go to edit session popup    ${session_name}
    Update start time for session    08:00 AM
    Update end time for session     10:00 AM
    Click at    ${SAVE_SESSION_NAME}
    ${session_name_2} =      Set session schedule with interviewer with time    Virtual Scheduled Interviews    ${EE_TEAM}         10:00
    Click at    ${EVENT_TOOLS_TEXT}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Switch to user    ${EE_TEAM}
    Choose going event for user
    Wait with medium time
    Go to My Calendar page by action
    Check element exist on page       ${BUSY_TIME_BLOCK}       ${date_in_string}
    Verify text contain     ${TIME_BLOCK_REMAINING_MORNING}    11:00 – 12:00pm      ${date_in_string}
    Go to Events page
    Switch to user    ${TEAM_USER}
    Search and delete event     ${event_name}


Verify the displaying of Hiring Event-specific ‘Busy Time’ when the user was added to interview session but is assigned to another interview durring event interview session time (OL-T20591, OL-T20592, OL-T20593)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =  Set Overview step with future time    Virtual    Single Event
    ${event_date} =      get_future_day_from_curent_date
	${date_in_string} =        get_future_date_in_string       ${event_date}
    Set Team step   ${EV_team}
    ${session_name} =   Set session schedule with interviewer   Virtual Scheduled Interviews    ${EV_team}      Auto-Assign Interviewers
    Set tool step and create event
    ${candidate_name} =     Add candidate at event homepage     ${session_time}
    Add interviewer for candidate       ${session_time}     ${EV_team}
    Switch to user    ${EV_team}
    Wait with medium time
    Go to My Calendar page by action
    Check element exist on page     ${BUSY_TIME_BLOCK_OVERLAP}    ${date_in_string}    2
    Check element display on screen     ${candidate_name}
    Click at    ${candidate_name}
    wait for page load successfully
    ${handles}=     Get Window Handles
    Switch Window  ${handles}[1]
    #   Verify a scheduled interview block will appear when the user is assigned as the Interviewer for a scheduled candidate during an event OL-T20592
    Verify all candidate page display correctly    ${candidate_name}     ${event_name}
    Switch Window  ${handles}[0]
    #   Verify a user is added to an event interview session as an Interviewer, the user can not be scheduled for a Traditional Interview during the duration of the session OL-T20593
    Go to CEM page
    ${candidate_name} =     Add new candidate and open schedule modal
    Click at    ${INTERVIEW_SCHEDULE_TYPE}
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews     ${EV_team}
    Send interview and click close button
    Check span display      Interview Pending
    Click View more button in email    ${COMPANY_EVENT} would like to schedule    Do any of these times work for you?
    Click at        ${COLLAPSE_SCHEDULE_BUTTON}

*** Keywords ***
Verify event popup appear correctly
    [Arguments]     ${event_name}       ${date_in_string}
    ${locator} =    Format String    ${BUSY_TIME_BLOCK}    ${date_in_string}
    Click Element    ${locator}
    Check span display      This hiring event time block is reserved for your potentially scheduled interviews during
    Check span display      ${event_name}.
    Check element display on screen     ${VIEW_MY_EVENT_SCHEDULE_BUTTON}

Edit event session settings
    [Arguments]     ${session_name}
    Click by JS     ${SESSION_TITLE}    ${session_name}
    Click at    ${EDIT_SESSION_BUTTON}
    Click at    ${SESSION_TAB_SETTING}
    Click at    ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    Click at    Auto-Assign Interviewers
    Click save session button

Go to My Calendar page by action
    Click at    ${MENU_SPAN}
    Given Click on common text last    My Calendar
    wait for page load successfully v1

User is at my event schedule page
    [Arguments]     ${event_name}
    Wait for page load successfully
    ${url} =    get location
    should contain    ${url}    /my-schedule
    Check span display      ${event_name}
    Check element display on screen     ${MENU_ACTIVE}      My Event Schedule

Set session schedule with interviewer with time
    [Arguments]    ${session_type}       ${interviewer}       ${time}
    ${session_name}=    Generate random name  event_session
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_WITH_DATATIME}          ${time}
    Click at    ${VT_INTERVIEW_SCHEDULE}
    Input into    ${SESSION_NAME_TEXTBOX}    ${session_name}
    Set Interview Time Slot Per Duration    1 Interview Time Slot
    Update start time for session    09:00 AM
    Update end time for session     11:00 AM
    Add interviewer for session     ${interviewer}
    click save session button
    [Return]    ${session_name}

Verify all candidate page display correctly
    [Arguments]     ${candidate_name}   ${event_name}
    ${url} =    get location
    Should contain    ${url}    ${base_url}/candidates/all-candidates?selected=
    Check text display      Update Interview
    Check element display on screen     ${UPDATE_INTERVIEW_CANDIDATE_NAME}      ${candidate_name}
    Check element display on screen     ${UPDATE_INTERVIEW_EVENT_NAME}      ${event_name}
