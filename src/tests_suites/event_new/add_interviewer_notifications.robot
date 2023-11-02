*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags          regression    dev2    stg   olivia  birddoghr   darden  aramark     lts_stg    test

Documentation       Availability timezone of user must be the same with timezone of Event

*** Variables ***
@{list_users}                       ${FS_TEAM}    ${HM_TEAM}    ${CA_TEAM}

#time slot
${session_time_slot_1}              09:00am - 09:15am
${session_time_slot_2}              09:15am - 09:30am
${session_time_slot_3}              10:00am - 10:15am
${session_time_slot_4}              10:30am - 10:45am
${session_time_slot_reschedule}     04:30pm - 04:45pm
${end_time_edit}                    03:00 PM

# custom message
${custom_message}                   Hi \#interviewer-name! I've scheduled a \#interview-duration \#interview-type for you with \#candidate-name during \#company-name's \#event-name event. The interview will be held at \#interview-location.

*** Test Cases ***
Verify the user will receive the Event Interview Confirm notification when the user is assigned to an event interview slots (OL-T20596)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    # Check email event interview confirm notification sent for virtual interview
	&{event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_1}    ${FS_TEAM}
	Verify user has received the email  Your virtual interview at ${COMPANY_EVENT}      Hi ${event_infor.first_name}!     YOUR_VIRTUAL_INTERVIEW
    Cancel event from event list    ${event_infor.event_name}
	# Check email event interview confirm notification sent for in person interview
    &{event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer    In Person     ${session_time_slot_1}    ${HM_TEAM}
	Verify user has received the email  Your in-person interview at ${COMPANY_EVENT}      Hi ${event_infor.first_name}!     YOUR_IN_PERSON_INTERVIEW
	Cancel event from event list    ${event_infor.event_name}
	# Check mail event interview confirm notification sent for phone interview
	${event_name}   ${session_name}=  Create event, add session and interviewer    Virtual      ${CA_TEAM}
	Go to edit session popup    ${session_name}
	Set session interview type  Phone interview
	click save session button
	Set tool step and create event
	Add candidate at event homepage     ${session_time_slot_4}
	Add interviewer for candidate       ${session_time_slot_4}      ${FS_TEAM}
	Verify user has received the email  Your phone interview at ${COMPANY_EVENT}      Hi Test!     YOUR_PHONE_INTERVIEW
	Cancel event from event list    ${event_name}


Verify If a user initiates a reschedule with a candidate for an event interview, a User Initiates Reschedule notification will be sent to the interviewer. (OL-T20601)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	# Check email event interview confirm notification sent for virtual interview
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_4}    ${HM_TEAM}
	# User reschedule event interview
	Go to CEM page
	Switch to user      ${HM_TEAM}
	Reschedule event interview   ${event_infor.full_name}   ${event_infor.event_name}   ${event_infor.session_name}
	Verify user has received the email   Canceled: Your virtual interview with ${event_infor.full_name}    Hello Hiring! ${HM_TEAM} initiated a reschedule     CANCEL_SCHEDULE
	Switch to user      ${TEAM_USER}
	Cancel event from event list    ${event_infor.event_name}


Verify User Initiates Reschedule notification is sent to interviewers when a user edit interview session that make reschedule to scheduled candidates (OL-T20602)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_reschedule}    ${HM_TEAM}
    Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    #Get available time of user before update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_before_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${HM_TEAM}
    Update end time for session     ${end_time_edit}
    #Get available time of user after update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_after_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${HM_TEAM}
    Should not be equal as strings  ${available_time_before_edit}   ${available_time_after_edit}
    Capture page screenshot
    Click at    ${EVENT_ADD_INTERVIEWER_CANCEL_BUTTON}
    click save session button
    Click on common text last   Continue
    Set tool step and create event
    #Check email send to interviewer to reschedule
    Verify user has received the email      Canceled: Your virtual interview with ${event_infor.full_name}     Hello Hiring! initiated a reschedule for your upcoming interview    CANCEL_SCHEDULE
    Cancel event from event list   ${event_infor.event_name}


Verify the assigned interviewer will be sent a User Inities Cancel notification. if a user initiates a cancellation request interview (OL-T20603)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_1}    ${CA_TEAM}
	# User reschedule event interview
	Go to CEM page
	Switch to user      ${CA_TEAM}
	Cancel event interview   ${event_infor.full_name}
	Verify user has received the email   Canceled: Your virtual interview with ${event_infor.full_name}      Hi CA Team, ${CA_TEAM} canceled your upcoming interview     CANCEL_SCHEDULE
    Switch to user      ${TEAM_USER}
	Cancel event from event list    ${event_infor.event_name}


Verify the assigned interviewer will be sent a User Inities Cancel notification. if a scheduled candidate initiates a cancellation request interview (OL-T20604)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_2}    ${CA_TEAM}
    Capture page screenshot
    # Check mail confirm send to candidate and cancel
    Click button in email       Your virtual interview at ${COMPANY_EVENT}      Hi ${event_infor.first_name}     YOUR_VIRTUAL_INTERVIEW      3
    Click on common text last   Yes
    wait with short time
    Verify Olivia conversation message display      I have canceled your upcoming 15 minute virtual interview with ${COMPANY_EVENT}
    #Check email send to interviewer to cancel
    wait with large time
    Verify user has received the email      Canceled: Your virtual interview with ${event_infor.full_name}     Hi Ca, I wanted to let you know that your candidate ${event_infor.full_name} canceled their upcoming interview with you    CANCEL_SCHEDULE
    Cancel event from event list   ${event_infor.event_name}


Verify new messages will be added to Message Customization page (OL-T20606, OL-T20607)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    ${USER_TAB}
    Verify new tab display correctly
    Click at    Interview Confirmed
    Input into  ${EVENT_CONTENT_EMAIL_TEXTBOX_BY_INTERVIEW_TYPE}    Updated email   Virtual
    Click at    ${SAVE_BUTTON_MESSAGE}
    &{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_3}    ${CA_TEAM}
    # Check confirm mail sent to user
    Verify user has received the email      Your virtual interview with ${event_infor.full_name}      Updated email     YOUR_VIRTUAL_INTERVIEW
    Cancel event from event list   ${event_infor.event_name}
    # Updated message to normal
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    ${USER_TAB}
    Click at    Interview Confirmed
    Clear element text with keys    ${EVENT_CONTENT_EMAIL_TEXTBOX_BY_INTERVIEW_TYPE}    Virtual
    Click at    ${SAVE_BUTTON_MESSAGE}

*** Keywords ***
Verify new tab display correctly
    Check element display on screen     Interview Confirmed
    Check element display on screen     Unresponsive User
    Check element display on screen     User Initiates Reschedule
    Check element display on screen     Candidate Initiates Reschedule
    Check element display on screen     Interviewer Declines Interview
    Check element display on screen     Interview Canceled
    Check element display on screen     User Tentatively Accepted Interview
    Check element display on screen     Miscellaneous Messages
    Capture page screenshot
