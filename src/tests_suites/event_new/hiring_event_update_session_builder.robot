*** Settings ***
Library             ../../utils/StringHandler.py
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        regression    dev2    stg   olivia  birddoghr   advatange     aramark     lts_stg   test

*** Variables ***
@{list_users}                       ${FS_TEAM}    ${HM_TEAM}    ${CA_TEAM}    ${FO_TEAM}    ${RC_TEAM}
${start_time}                       09:00 AM
${end_time}                         05:00 PM
${start_time_schedule}              11:00 AM
${end_time_schedule}                11:30 AM
${start_time_schedule_edited}       10:00 AM
${end_time_schedule_edited}         10:30 AM
${interview_time_slots}             2 Interview Time Slots
${interview_duration}               30 min
@{list_interview_type_selected}     Phone Meeting   Group Interview

#time slot
${session_time_slot_1}              03:30pm - 03:45pm

*** Test Cases ***
Verify UI of display when the user select Virtual Scheduled Interviews selection - Virtual (OL-T20213, OL-T20214)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${VT_INTERVIEW_SCHEDULE}
    Check UI of display when the user select Virtual Scheduled Interviews session
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Scheduled Interviews
    Check information of Hiring Event Virtual with type Virtual Scheduled Interviews    ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of display when the user select Live Video Broadcast session type - Virtual (OL-T20208, OL-T20209)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${LIVE_VIDEO_BROADCAST}
    Check UI of display when the user select Live Video Broadcast session
    ${session_name} =   Fill valid data into remain fields Interview Session    Live Video Broadcast
    Check information of Hiring Event Virtual with type Live Video Broadcast   ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of display when the user select Virtual Chat Booth session type - Virtual (OL-T20218, OL-T20219)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    Check UI of display when the user select Virtual Chat Booth session
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Chat Booth
    Check information of Hiring Event Virtual with type Virtual Chat Booth     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of Select Session Slide Out when creating a session incase select Event Venue Type: In-person (OL-T20174)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Check UI of Select Session Slide Out when creating a session incase select Event Venue Type     In Person


Verify UI of Select Session Slide Out when create a session incase select Event Venue Type: Virtual (OL-T20175)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Check UI of Select Session Slide Out when creating a session incase select Event Venue Type     Virtual


Verify UI of display when the user select In-person on Session Venue - Hiring in person (OL-T20200, OL-T20201, OL-T20202)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    ${venue_location}    ${venue_name} =    Get venue location and vanue name Set Overview step
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${EVENT_SESSION_CREATED}
    Check UI of display when the user select Session Venue type is In Person of Event Session   ${venue_location}    ${venue_name}
    ${session_name} =   Fill valid data into remain fields Interview Session    Event Session - In Person
    Check information of Hiring Event In Person with type Event Session     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of display when the user select Virtual on Session Venue - Hiring in person (OL-T20203, OL-T20204)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${EVENT_SESSION_CREATED}
    Check UI of display when the user select Session Venue type is Virtual of Event Session
    ${session_name} =   Fill valid data into remain fields Interview Session    Event Session - Virtual
    Check information of Hiring Event In Person with type Event Session     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of display when the user create Orientation session has Event Venue: In person - Orientation (OL-T20245, OL-T20248, OL-T20259)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    ${venue_location}    ${venue_name} =    Get venue location and vanue name Set Overview step
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Check UI of display when the user create Orientation session has Session Venue is In Person     ${venue_location}    ${venue_name}
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - In Person
    Check information Orientation session    ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of display when the user create Orientation session has Session Venue: Virtual - Orientation (OL-T20260, OL-T20261)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Check UI of display when the user create Orientation session has Session Venue is Virtual
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - Virtual
    Check information Orientation session   ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of display when the user create Orientation session has Session Venue: Candidate Store Location - Orientation (OL-T20262, OL-T20263)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    Candidate Store Location    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Check UI of display when the user create Orientation session has Session Venue is Candidate Store Location
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - Candidate Store Location
    Check information Orientation session   ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify display when user fills valid data into remain fields when user selects Interview type: In person Interviews - Hiring in person (OL-T20176, OL-T20177)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    ${venue_location}    ${venue_name} =    Get venue location and vanue name Set Overview step
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Check UI of display when the user select Interview type In person Interviews of Hiring in person session    ${venue_location}    ${venue_name}
    ${session_name} =   Fill valid data into remain fields Interview Session    Scheduled Interviews
    Check information of Hiring Event In Person with type Scheduled Interviews    In-person interviews   ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify UI of when create Group Interview session - Hiring in person (OL-T20178, OL-T20191)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Select interview type in Client Setup     Group Interview
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    ${venue_location}    ${venue_name} =    Get venue location and vanue name Set Overview step
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Check UI of display when the user select Interview type Group Interviews of Hiring in person session    ${venue_location}    ${venue_name}
    ${session_name} =   Fill valid data into remain fields Interview Session    Scheduled Interviews
    Check information of Hiring Event In Person with type Scheduled Interviews    Group interviews      ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify display when user fills valid data into remain fields when user selects Interview type: In-person meeting - Hiring in person (OL-T20179)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Select interview type in Client Setup     In-Person Meeting
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    ${venue_location}    ${venue_name} =    Get venue location and vanue name Set Overview step
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Check UI of display when the user select Interview type In person meeting of Hiring in person session    ${venue_location}    ${venue_name}
    ${session_name} =   Fill valid data into remain fields Interview Session    Scheduled Interviews
    Check information of Hiring Event In Person with type Scheduled Interviews    In-person meetings   ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}


Verify create a Virtual Scheduled Interviews session successfully - Virtual (OL-T20207)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VT_INTERVIEW_SCHEDULE}
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Scheduled Interviews
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}   ${session_name}
    capture page screenshot


Verify create Virtual Chat Booth session successfully - Virtual (OL-T20221)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Chat Booth
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}   ${session_name}
    capture page screenshot


Verify create an Interview Session successfully - Hiring in person (OL-T20199)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    ${session_name} =   Fill valid data into remain fields Interview Session    Scheduled Interviews
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}   ${session_name}
    capture page screenshot


Verify create session for Orientation event successfully - Orientation (OL-T20264)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - In Person
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}   ${session_name}
    capture page screenshot


Verify Session Venue dropdown show data correct incase Select In person on Event Venue dropdown on Overview step - Orientation (OL-T20246)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${EVENT_SESSION_CREATED}
    Check list Session Venue dropdown item of Orientation show data correct


Verify list times on Duration of Each Interview - Hiring in person (OL-T20182)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Check list times on Duration of Each Interview show data correct


Verify when user chooses Custom on Duration of Each Interview dropdown - Hiring in person (OL-T20190, OL-T20183)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click at    ${INTERVIEW_DURATION_DROPDOWN}
    Chooses Custom on Duration of Each Interview dropdown   0   0
    Check span display  Hour is required
    Check span display  Minute is required


Verify function work correctly when the user clicks on Add or Remove Instruction button - Hiring in person (OL-T20192, OL-T20193)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click on span text      Add Instructions
    Input into      ${SESSION_ADD_INSTRUCTIONS_TEXTBOX}     Instructions text sample
    capture page screenshot
    Click at      ${SESSION_REMOVE_INSTRUCTIONS_BUTTON}
    Check element not display on screen     ${SESSION_ADD_INSTRUCTIONS_TEXTBOX}     wait_time=5s
    Check span display  Add Instructions
    capture page screenshot


Verify when the user makes a selection within the updated Interviewer per Duration dropdown - Hiring in person (OL-T20187)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    ${session_name} =   Fill valid data into remain fields Interview Session    Scheduled Interviews
    ${number_interview_time_slots} =     extract_numbers    ${interview_time_slots}
    ${number_interview_duration} =     extract_numbers    ${interview_duration}
    Check span display      ${number_interview_time_slots}[0] interview time slots every ${number_interview_duration}[0] minutes (${number_interview_time_slots}[0] total interviews)


Verify function work correctly incase Hide Video URL & Password from Unregistered Candidates toggle is ON - Hiring in person (OL-T20205)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${EVENT_SESSION_CREATED}
    ${session_name} =   Fill valid data into remain fields Interview Session    Event Session - Virtual
    Click at    ${HIDE_URL_TOGGLE}
    Click at    ${SAVE_SESSION_NAME}
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Check element not display on screen    Join Session
    Check element not display on screen    Password
    capture page screenshot


Verify function work correctly incase Hide Video URL & Password from Unregistered Candidates toggle is ON - Virtual (OL-T20210)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${LIVE_VIDEO_BROADCAST}
    ${session_name} =   Fill valid data into remain fields Interview Session    Live Video Broadcast
    Click at    ${HIDE_URL_TOGGLE}
    Click at    ${SAVE_SESSION_NAME}
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Check element not display on screen    Join Session
    Check element not display on screen    Password
    capture page screenshot


Verify Delete session work correctly incase event doesn't have Candidates Scheduled - Virtual (OL-T20237)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name}   ${session_name}=  Create event, add session and interviewer    In Person      ${CA_TEAM}
	Go to edit session popup    ${session_name}
	# Delete session
	Scroll to element     ${DELETE_SESSION_DETAIL_BUTTON}
    Click by JS    ${DELETE_SESSION_DETAIL_BUTTON}
    Check UI of confirm delete session modal
    Click on common text last      Delete Session
    Check element not display on screen     ${SESSION_TITLE}   ${session_name}
    capture page screenshot


Verify Delete session work correctly incase event doesn't have Candidates Scheduled when the user clicks the trash can icon - Virtual (OL-T20241)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name}   ${session_name}=  Create event, add session and interviewer    In Person      ${CA_TEAM}
	# Delete session
    Click at     ${SESSION_TITLE}    ${session_name}
    Click at    ${DELETE_SESSION_BUTTON}
    Check UI of confirm delete session modal
    Click on common text last      Delete Session
    Check element not display on screen     ${SESSION_TITLE}   ${session_name}
    capture page screenshot


Verify Delete session work correctly when the user clicks the trash can icon delete a Session with Candidates Scheduled - Virtual (OL-T20242, OL-T20243)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot    Virtual     ${session_time_slot_1}    ${CA_TEAM}
	Capture page screenshot
	Go to edit event page from dashboard
	# Delete session
	Click at    ${SCHEDULE_STEP_LABEL}
	Click at     ${SESSION_TITLE}    ${event_infor.session_name}
    Click at    ${DELETE_SESSION_BUTTON}
    Check UI of confirm delete session modal with event have candidate
    Click on common text last      Delete Session
    Check element not display on screen     ${SESSION_TITLE}   ${event_infor.session_name}
    capture page screenshot
    Set Schedule step   Virtual Scheduled Interviews
    Set tool step and create event
    # Cancel event
    Cancel event from event list   ${event_infor.event_name}


Verify Delete session work correctly when the user delete a Session with Candidates Scheduled - Virtual (OL-T20238, OL-T20239)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot    Virtual     ${session_time_slot_1}    ${CA_TEAM}
	Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
	# Delete session
	Scroll to element     ${DELETE_SESSION_DETAIL_BUTTON}
    Click by JS    ${DELETE_SESSION_DETAIL_BUTTON}
    Check UI of confirm delete session modal with event have candidate
    Click on common text last      Delete Session
    Check element not display on screen     ${SESSION_TITLE}   ${event_infor.session_name}
    capture page screenshot
    Set Schedule step   Virtual Scheduled Interviews
    Set tool step and create event
    # Cancel event
    Cancel event from event list   ${event_infor.event_name}


Verify data on interview time slots pulldown - Hiring in person (OL-T20186)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click at    ${INTERVIEW_TIME_SLOT_DROPDOWN}
    Check list interview time slot show data correct


Verify Cannot Add a Virtual Chat Booth to an Event with an Interview Session incase Virtual Scheduled Interviews session created - Virtual (OL-T20188)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VT_INTERVIEW_SCHEDULE}
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Scheduled Interviews
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}   ${session_name}
    Select Event session available time
    ${is_clicked} =     Run keyword and return status   Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    IF  '${is_clicked}' == 'False'
        Check element not display on screen     Create a Virtual Chat Booth
        capture page screenshot
    END


Verify Cannot Add a Virtual Chat Booth to an Event with an Interview Session incase Live Video Broadcast session created - Virtual (OL-T20189)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${LIVE_VIDEO_BROADCAST}
    ${session_name} =   Fill valid data into remain fields Interview Session    Live Video Broadcast
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}   ${session_name}
    Select Event session available time
    ${is_clicked} =     Run keyword and return status   Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    IF  '${is_clicked}' == 'False'
        Check element not display on screen     Create a Virtual Chat Booth
        capture page screenshot
    END


Verify Confirmation modal appears when the user edit a Session with Candidates Scheduled - Virtual (OL-T20234)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot    Virtual     ${session_time_slot_1}    ${CA_TEAM}
	Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    Update start time for session    ${start_time_schedule_edited}
    Update end time for session     ${end_time_schedule_edited}
    Click at    ${SAVE_SESSION_NAME}
    Check UI of confirmation edit modal appears when the user edit a Session
    Click on common text last  Continue
    Set tool step and create event
    # Cancel event
    Cancel event from event list   ${event_infor.event_name}


Verify Edit Virtual Chat Booth session work correctly when the user clicks on Save button incase event doesn't have Candidates Scheduled - Virtual (OL-T20233)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Chat Booth
    Click at    ${SAVE_SESSION_NAME}
    Click by JS     ${SESSION_TITLE}    ${session_name}
    Click at    ${EDIT_SESSION_BUTTON}
    ${session_name_edited}=     Update name for session
    Update start time for session    ${start_time_schedule_edited}
    Update end time for session     ${end_time_schedule_edited}
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}    ${session_name_edited}
    Click by JS     ${SESSION_TITLE}    ${session_name_edited}
    ${date_time_edited}=    get text    ${SESSION_DETAIL_POPUP_DATE}
    should contain     ${date_time_edited}     ${start_time_schedule_edited} - ${end_time_schedule_edited}
    capture page screenshot


Verify Edit Live Video Broadcast session work correctly when the user clicks on Save button with Candidates Scheduled - virtual (OL-T20282)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${LIVE_VIDEO_BROADCAST}
    ${session_name} =   Fill valid data into remain fields Interview Session    Live Video Broadcast
    Click at    ${SAVE_SESSION_NAME}
    Set tool step and create event
    #Add candidate for event
    ${candidate_name}=  Add candidate at All Candidates
    #Update event session infor
    Go to edit event page from dashboard
    Go to edit session popup    ${session_name}
	${session_name_edited}=     Update name for session
    Update start time for session    ${start_time_schedule_edited}
    Update end time for session     ${end_time_schedule_edited}
    Click at    ${SAVE_SESSION_NAME}
    #Check infor event session updated
    Check element display on screen     ${SESSION_TITLE}    ${session_name_edited}
    Click by JS     ${SESSION_TITLE}    ${session_name_edited}
    ${date_time_edited}=    get text    ${SESSION_DETAIL_POPUP_DATE}
    should contain     ${date_time_edited}     ${start_time_schedule_edited} - ${end_time_schedule_edited}
    Set tool step and create event
    # Cancel event
    Cancel event from event list   ${event_name}


Verify edit session work correctly - Orientation (OL-T20266)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - In Person
    Click at    ${SAVE_SESSION_NAME}
    #Update event session infor
    Click by JS     ${SESSION_TITLE}    ${session_name}
    Click at    ${EDIT_SESSION_BUTTON}
    ${session_name_edited}=     Update name for session
    Update start time for session    ${start_time_schedule_edited}
    Update end time for session     ${end_time_schedule_edited}
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen     ${SESSION_TITLE}    ${session_name_edited}
    Click by JS     ${SESSION_TITLE}    ${session_name_edited}
    ${date_time_edited}=    get text    ${SESSION_DETAIL_POPUP_DATE}
    should contain     ${date_time_edited}     ${start_time_schedule_edited} - ${end_time_schedule_edited}
    capture page screenshot


Verify Edit Scheduled Interview session work correctly when the user edit a Session with Candidates Scheduled (OL-T20235)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=    Create new hiring event, scheduled candidate to interview slot      In Person  ${session_time_slot_1}    ${CA_TEAM}
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    #Update event session infor
	${session_name_edited}=     Update name for session
    Update start time for session    ${start_time_schedule_edited}
    Update end time for session     ${end_time_schedule_edited}
    Click at    ${SAVE_SESSION_NAME}
    Click on common text last   Continue
    #Check infor event session updated
    Check element display on screen     ${SESSION_TITLE}    ${session_name_edited}
    Click by JS     ${SESSION_TITLE}    ${session_name_edited}
    ${date_time_edited}=    get text    ${SESSION_DETAIL_POPUP_DATE}
    should contain     ${date_time_edited}     ${start_time_schedule_edited} - ${end_time_schedule_edited}
    Set tool step and create event
    Verify user has received the email    ${COMPANY_EVENT} needs to reschedule your in-person interview
    ...    Hi Test. I was asked to reschedule    NEED_RESCHEDULE_INTERVIEW
    # Cancel event
    Cancel event from event list   ${event_infor.event_name}


Verify Edit virtual scheduled interview session work correctly when the user clicks on Save button with Candidates Scheduled - virtual (OL-T20281)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=    Create new hiring event, scheduled candidate to interview slot      Virtual  ${session_time_slot_1}    ${CA_TEAM}
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    #Update event session infor
	${session_name_edited}=     Update name for session
    Update start time for session    ${start_time_schedule_edited}
    Update end time for session     ${end_time_schedule_edited}
    Click at    ${SAVE_SESSION_NAME}
    Click on common text last   Continue
    #Check infor event session updated
    Check element display on screen     ${SESSION_TITLE}    ${session_name_edited}
    Click by JS     ${SESSION_TITLE}    ${session_name_edited}
    ${date_time_edited}=    get text    ${SESSION_DETAIL_POPUP_DATE}
    should contain     ${date_time_edited}     ${start_time_schedule_edited} - ${end_time_schedule_edited}
    Set tool step and create event
    wait with large time
    Verify user has received the email    ${COMPANY_EVENT} needs to reschedule your virtual interview
    ...    Hi Test. I was asked to reschedule    NEED_RESCHEDULE_INTERVIEW
    # Cancel event
    Cancel event from event list   ${event_infor.event_name}


Verify the user can add user available on Add session staff search bar - Orientation (OL-T20252, OL-T20253)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step with multiple users   @{list_users}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - In Person
    Click at    ${SAVE_SESSION_NAME}
    Set tool step and create event
    # Delete old session
    Go to edit event page from dashboard
	Click at    ${SCHEDULE_STEP_LABEL}
	Click at     ${SESSION_TITLE}    ${session_name}
    Click at    ${DELETE_SESSION_BUTTON}
    Click on common text last      Delete Session
    # Create new session
	Select Event session available time
	${session_name}=     Update name for session
	Update start time for session    ${start_time_schedule}
    Update end time for session     ${end_time_schedule}
    Set session interview type      In Person
    Check user can add user available on Add session staff      ${FS_TEAM}
    Check user can not add user unavailable on Add session staff    ${CA_TEAM}
    Click at    ${SAVE_SESSION_NAME}
    Set tool step and create event
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify show RSVP status and user can change their RSVP status on Event list (OL-T20277, OL-T20278)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot    Virtual     ${session_time_slot_1}    ${CA_TEAM}
	Go to Events page
	Switch to user      ${CA_TEAM}
	search event    ${event_infor.event_name}
	Click at    ${EVENT_RSVP_DROPDOWN}
    Check list item of event RSVP dropdown
    Click on common text last   Going
    Check element display on screen     ${EVENT_RSVP_DROPDOWN_SELECTED_VALUE}   Going
    capture page screenshot
    Click at    ${EVENT_RSVP_DROPDOWN}
    Click on common text last   Not Going
    Click on common text last   Decline Event
    Check element display on screen     ${EVENT_RSVP_DROPDOWN_SELECTED_VALUE}   Not Going
    capture page screenshot
    # Cancel event
    Switch to user      ${TEAM_USER}
    Cancel event from event list    ${event_infor.event_name}


Verify show RSVP status and user can change their RSVP status on Dashboard - Event homepage (OL-T20270, OL-T20271, OL-T20272, OL-T20274, OL-T20275)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot    Virtual     ${session_time_slot_1}    ${CA_TEAM}
	Click at    ${DASH_BOARD_NAVIGATION}
    Click at    ${RSVP_STATUS_BUTTON}
    Check common text last display  Going
	Check common text last display  Not Going
	capture page screenshot
    Switch to user      ${CA_TEAM}
    Click at    ${RSVP_STATUS_BUTTON}
    Check list item of event RSVP dropdown
    Click on common text last   Going
    Check element display on screen     ${GOING_STATUS_BUTTON}
    capture page screenshot
    Click at    ${RSVP_STATUS_BUTTON}
    Click on common text last   Not Going
    Click on common text last   Decline Event
    Check element display on screen     ${NOT_GOING_STATUS_BUTTON}
    capture page screenshot
    # Cancel event
    Switch to user      ${TEAM_USER}
    Cancel event from event list    ${event_infor.event_name}


Verify initial RSVP status after creating orientation event (OL-T20279)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    ${session_name} =   Fill valid data into remain fields Interview Session    Orientation - In Person
    Click at    ${SAVE_SESSION_NAME}
    Set tool step and create event
    Click at    ${RSVP_STATUS_BUTTON}
    Check common text last display  Going
	Check common text last display  Not Going
	capture page screenshot
    Switch to user      ${CA_TEAM}
    Click at    ${RSVP_STATUS_BUTTON}
    Check list item of event RSVP dropdown
    Click on common text last   Going
    Check element display on screen     ${GOING_STATUS_BUTTON}
    capture page screenshot
    Click at    ${RSVP_STATUS_BUTTON}
    Click on common text last   Not Going
    Click on common text last   Decline Event
    Check element display on screen     ${NOT_GOING_STATUS_BUTTON}
    capture page screenshot
    # Cancel event
    Switch to user      ${TEAM_USER}
    Cancel event from event list without candidate schedule     ${event_name}


Verify interview type dropdown display all selected types (from client setup) at Interview Detail - Builder incase create In-person event - Hiring in person (OL-T20180)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Select interview type in Client Setup   In-Person Meeting
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${CA_TEAM}
    ${venue_location}    ${venue_name} =    Get venue location and vanue name Set Overview step
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click at    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Check element display on screen     ${EVENT_INTERVIEW_DROPDOWN_OPTION_SELECTED}     In-person interview
    Check element display on screen      ${EVENT_INTERVIEW_DROPDOWN_OPTION}    In-person meeting


Verify interview type dropdown display all selected types (from client setup) at Interview Detail - Builder incase create Virtual event (OL-T20181)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Select interview type in Client Setup   Virtual Meeting
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    ${schedule_timezone}    ${schedule_datetime} =     Get timezone and schedule date time at Schedule step
    Select Event session available time
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click at    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Check element display on screen     ${EVENT_INTERVIEW_DROPDOWN_OPTION_SELECTED}     Virtual interview
    Check element display on screen      ${EVENT_INTERVIEW_DROPDOWN_OPTION}    Virtual meeting


Verify data shown on Duration of Each Interview dropdown correct when the user change Duration of Each Interview (OL-T19743)
    # Implement to cover bug https://paradoxai.atlassian.net/browse/OL-57187
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=    Create new hiring event, scheduled candidate to interview slot      In Person  ${session_time_slot_1}    ${CA_TEAM}
	Click at    ${DASH_BOARD_NAVIGATION}
    Verify text contain     ${EVENT_SCHEDULE_DURATION_INFO}     15 Minute
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    Set Interview Time Slot Per Duration    interviewer_duration=30 min
    Click at    ${SAVE_SESSION_NAME}
    Click on common text last  Continue
    Set tool step and create event
    Verify text contain     ${EVENT_SCHEDULE_DURATION_INFO}     30 Minute
    capture page screenshot


*** Keywords ***
Get timezone and schedule date time at Schedule step
    ${schedule_timezone} =      Get text and format text    ${SCHEDULED_INTERVIEWS_TIMEZONE_LABEL}
    ${schedule_datetime} =      Get text and format text    ${SCHEDULED_INTERVIEWS_DATETIME_LABEL}
    [Return]    ${schedule_timezone}    ${schedule_datetime}

Check UI of display when the user select Virtual Scheduled Interviews session
    # Check UI of Session Details section
    check span display    Session Details
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    # Check UI of Interview Details section
    check span display     Interview Details
    check span display     Interview Type
    check span display     Duration of Each Interview
    check span display     Per duration, how many interview time slots do you want to create?
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    check element display on screen     ${INTERVIEW_DURATION_DROPDOWN}
    check element display on screen     ${INTERVIEW_TIME_SLOT_DROPDOWN}
    # Check UI of Interviewers section
    check span display     Interviewers
    check span display     Add Interviewers
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    # Check UI of Settings section
    check span display     Settings
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot


Check information of Hiring Event Virtual with type Virtual Scheduled Interviews
    [Arguments]     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}
    Check common text last display     Create an Interview Session
    Check common text last display     ${session_name}
    Check span display      ${schedule_datetime}
    Check span display      ${start_time_schedule} - ${end_time_schedule} (${schedule_timezone})
    Check span display      30 Minute Virtual interviews
    Check span display      2 Interviews Available
    Check common text last display  ${CA_TEAM}
    capture page screenshot

Check UI of display when the user select Live Video Broadcast session
    # Check UI of Session Details section
    check span display    Video Broadcast Name
    check span display    Start Time
    check span display    End Time
    check common text last display    Session Details
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Broadcast Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check span display      Provide a Meeting URL for Candidates and Users to Join
    check span display      Video Broadcast URL
    check element display on screen     ${SESSION_URL_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_URL_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Video URL (ex: MS Teams, Zoom, etc...)
    check span display      Video Broadcast URL Password (Optional)
    check element display on screen     ${SESSION_URL_PASS_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_URL_PASS_TEXTBOX}
    should be equal as strings  ${placeholder_text}    ex: Zoom Meeting Password
    check common text last display      Hide Video URL & Password from unregistered Candidates
    check element display on screen     ${HIDE_URL_TOGGLE}
    check span display      Video Broadcast Description
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    During this live video broadcast, we will be hosting a webinar about careers at Test Automation - Event and how to apply.
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check information of Hiring Event Virtual with type Live Video Broadcast
    [Arguments]     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}
    Check common text last display     Create a Live Video Broadcast
    Check common text last display     ${session_name}
    Check span display      ${schedule_datetime}
    Check span display      ${start_time_schedule} - ${end_time_schedule} (${schedule_timezone})
    capture page screenshot

Check UI of display when the user select Virtual Chat Booth session
    # Check UI of Session Details section
    check span display    Booth Name
    check span display    Start Time
    check span display    End Time
    check common text last display    Session Details
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Booth Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check span display      Booth Description
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    Chat with a recruiter during this booth about our open opportunities and how to apply.
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check information of Hiring Event Virtual with type Virtual Chat Booth
    [Arguments]     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}
    Check common text last display     Create a Virtual Chat Booth
    Check common text last display     ${session_name}
    Check span display      ${schedule_datetime}
    Check span display      ${start_time_schedule} - ${end_time_schedule} (${schedule_timezone})
    capture page screenshot

Check UI of Select Session Slide Out when creating a session incase select Event Venue Type
    [Arguments]     ${session_type}
    IF    '${session_type}' == 'In Person'
        Check text display      Create a Session
        Check span display      Select Session Type
        Check text display      Scheduled Interviews
        Check text display      Event Session
        ${description} =    Get text and format text    ${EVENT_INTERACTION_TYPE_DESCRIPTION}
        should be equal  ${description}  Please select a session interaction type that you would like to create. Once your session is created, the interaction type can not be changed.
        ${description_item_01} =    Get text and format text    ${EVENT_INTERACTION_TYPE_ITEM_DESCRIPTION_01}
        should be equal  ${description_item_01}      Create interview time slots for either in-person or virtual interviews.
        ${description_item_02} =    Get text and format text    ${EVENT_INTERACTION_TYPE_ITEM_DESCRIPTION_02}
        should be equal  ${description_item_02}      Use event sessions as a blank template for webinars, presentations, and more.
    ELSE IF     '${session_type}' == 'Virtual'
        Check text display      Create a Session
        Check span display      Select Session Type
        Check text display      Virtual Scheduled Interviews
        Check text display      Live Video Broadcast
        Check text display      Virtual Chat Booth
        ${description} =    Get text and format text    ${EVENT_INTERACTION_TYPE_DESCRIPTION}
        should be equal  ${description}  Please select a session interaction type that you would like to create. Once your session is created, the interaction type can not be changed.
        ${description_item_01} =    Get text and format text    ${EVENT_INTERACTION_TYPE_ITEM_DESCRIPTION_01}
        should be equal  ${description_item_01}      Create interview time slots for virtual interviews.
        ${description_item_02} =    Get text and format text    ${EVENT_INTERACTION_TYPE_ITEM_DESCRIPTION_02}
        should be equal  ${description_item_02}      Create a video broadcast for live webinars, presentations, and more.
        ${description_item_03} =    Get text and format text    ${EVENT_INTERACTION_TYPE_ITEM_DESCRIPTION_03}
        should be equal  ${description_item_03}      Create virtual chat booths to chat with all candidates within the booth.
    END

Check UI of display when the user select Session Venue type is In Person of Event Session
    [Arguments]     ${venue_location}    ${venue_name}
    # Check UI of Session Details section
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      In Person
    # Check value of VENUE_LOCATION_TEXTBOX and VENUE_NAME_TEXTBOX same as inputed data at Overview step
    check element display on screen     ${VENUE_LOCATION_TEXTBOX}
    ${venue_location_actual} =  Get text and format text   ${VENUE_LOCATION_TEXTBOX}
    should be equal as strings  ${venue_location}   ${venue_location_actual}
    check element display on screen     ${VENUE_NAME_TEXTBOX}
    ${venue_name_actual} =  Get text and format text   ${VENUE_NAME_TEXTBOX}
    should be equal as strings  ${venue_name}   ${venue_name_actual}
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    During this session, we will be hosting an information session about careers at ${COMPANY_EVENT} and how to apply.
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check UI of display when the user select Session Venue type is Virtual of Event Session
    # Check UI of Session Details section
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      Virtual
    check span display      Provide a Meeting URL for Candidates and Users to Join
    check span display      Session URL
    check element display on screen     ${SESSION_URL_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_URL_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session URL (ex: MS Teams, Zoom, etc…)
    check span display      Session URL Password (Optional)
    check element display on screen     ${SESSION_URL_PASS_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_URL_PASS_TEXTBOX}
    should be equal as strings  ${placeholder_text}    ex: Zoom Meeting Password
    check common text last display      Hide Session URL & Password from unregistered Candidates
    check element display on screen     ${HIDE_URL_TOGGLE}
    check span display      Session Description
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    During this session, we will be hosting an information session about careers at ${COMPANY_EVENT} and how to apply.
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Get venue location and vanue name Set Overview step
    Click at    ${OVERVIEW_STEP_LABEL}
    ${venue_location} =      Get text and format text    ${VENUE_LOCATION_TEXTBOX}
    ${venue_name} =      Get text and format text    ${VENUE_NAME_TEXTBOX}
    [Return]    ${venue_location}    ${venue_name}

Check information of Hiring Event In Person with type Event Session
    [Arguments]  ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}
    Check common text last display     Create an Event Session
    Check common text last display     ${session_name}
    Check span display      ${schedule_datetime}
    Check span display      ${start_time_schedule} - ${end_time_schedule} (${schedule_timezone})
    capture page screenshot

Check UI of display when the user create Orientation session has Session Venue is Virtual
    # Check UI of Session Details section
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      Virtual
    check common text last display      Use WebEx Video for Your Session
    check element display on screen     ${USE_WEB_EX_TOGGLE}
    check span display      Provide a Meeting URL for Candidates and Users to Join
    check span display      Session URL
    check element display on screen     ${SESSION_URL_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_URL_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session URL (ex: MS Teams, Zoom, etc…)
    check span display      Session URL Password (Optional)
    check element display on screen     ${SESSION_URL_PASS_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_URL_PASS_TEXTBOX}
    should be equal as strings  ${placeholder_text}    ex: Zoom Meeting Password
    check common text last display      Hide Session URL & Password from unregistered Candidates
    check element display on screen     ${HIDE_URL_TOGGLE}
    check span display      Session Description
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    During this session, we will be hosting an information session about careers at ${COMPANY_EVENT} and how to apply.
    check span display    Session Staff
    check span display    Add Session Staff
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    check span display      No Team Members Have Been Added
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check information Orientation session
    [Arguments]  ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}
    Check common text last display     ${session_name}
    Check span display      ${schedule_datetime}
    Check span display      ${start_time_schedule} - ${end_time_schedule} (${schedule_timezone})
    Check common text last display  ${CA_TEAM}
    capture page screenshot

Check UI of display when the user create Orientation session has Session Venue is In Person
    [Arguments]     ${venue_location}    ${venue_name}
    # Check UI of Session Details section
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      In Person
    # Check value of VENUE_LOCATION_TEXTBOX and VENUE_NAME_TEXTBOX same as inputed data at Overview step
    check element display on screen     ${VENUE_LOCATION_TEXTBOX}
    ${venue_location_actual} =  Get text and format text   ${VENUE_LOCATION_TEXTBOX}
    should be equal as strings  ${venue_location}   ${venue_location_actual}
    check element display on screen     ${VENUE_NAME_TEXTBOX}
    ${venue_name_actual} =  Get text and format text   ${VENUE_NAME_TEXTBOX}
    should be equal as strings  ${venue_name}   ${venue_name_actual}
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    During this session, we will be hosting an information session about careers at ${COMPANY_EVENT} and how to apply.
    check span display    Session Staff
    check span display    Add Session Staff
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    check span display      No Team Members Have Been Added
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check UI of display when the user create Orientation session has Session Venue is Candidate Store Location
    # Check UI of Session Details section
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      Candidate Store Location
    check span display      Address
    check element display on screen     ${SESSION_CANDIDATE_LOCATION_ADDRESS_TEXTBOX}
    Verify element is disable   ${SESSION_CANDIDATE_LOCATION_ADDRESS_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_CANDIDATE_LOCATION_ADDRESS_TEXTBOX}
    should contain  ${placeholder_text}    candidate-location-address
    check span display      Location Name
    check element display on screen     ${SESSION_CANDIDATE_LOCATION_NAME_TEXTBOX}
    Verify element is disable   ${SESSION_CANDIDATE_LOCATION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_CANDIDATE_LOCATION_NAME_TEXTBOX}
    should contain  ${placeholder_text}    candidate-location-name
    check element display on screen     ${DESCRIPTION_EVENT_SESSION}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${DESCRIPTION_EVENT_SESSION}
    should be equal as strings  ${placeholder_text}    During this session, we will be hosting an information session about careers at ${COMPANY_EVENT} and how to apply.
    check span display    Session Staff
    check span display    Add Session Staff
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    check span display      No Team Members Have Been Added
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check UI of display when the user select Interview type In person Interviews of Hiring in person session
    [Arguments]     ${venue_location}    ${venue_name}
    # Check UI of Session Details section
    check span display    Session Details
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    # Check UI of Interview Details section
    check span display     Interview Details
    check span display     Interview Type
    check span display     Duration of Each Interview
    check span display     Per duration, how many interview time slots do you want to create?
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    check element display on screen     ${INTERVIEW_DURATION_DROPDOWN}
    check element display on screen     ${INTERVIEW_TIME_SLOT_DROPDOWN}
   # Check value of VENUE_LOCATION_TEXTBOX and VENUE_NAME_TEXTBOX same as inputed data at Overview step
    check element display on screen     ${VENUE_LOCATION_TEXTBOX}
    ${venue_location_actual} =  Get text and format text   ${VENUE_LOCATION_TEXTBOX}
    should be equal as strings  ${venue_location}   ${venue_location_actual}
    check element display on screen     ${VENUE_NAME_TEXTBOX}
    ${venue_name_actual} =  Get text and format text   ${VENUE_NAME_TEXTBOX}
    should be equal as strings  ${venue_name}   ${venue_name_actual}
    # Check UI of Interviewers section
    check span display     Interviewers
    check span display     Add Interviewers
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    # Check UI of Settings section
    check span display     Settings
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check information of Hiring Event In Person with type Scheduled Interviews
    [Arguments]     ${interview_type}     ${session_name}     ${schedule_datetime}    ${start_time_schedule}  ${end_time_schedule}    ${schedule_timezone}
    Check common text last display     Create an Interview Session
    Check common text last display     ${session_name}
    Check span display      ${schedule_datetime}
    Check span display      ${start_time_schedule} - ${end_time_schedule} (${schedule_timezone})
    Check span display      30 Minute ${interview_type}
    Check span display      2 Interviews Available
    Check common text last display  ${CA_TEAM}
    capture page screenshot

Check UI of display when the user select Interview type Group Interviews of Hiring in person session
    [Arguments]     ${venue_location}    ${venue_name}
    # Check UI of Session Details section
    check span display    Session Details
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    # Check UI of Interview Details section
    check span display     Interview Details
    check span display     Interview Type
    check span display     Duration of Each Interview
    check span display     Per duration, how many interview time slots do you want to create?
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      Group interview
    check element display on screen     ${CANDIDATES_PER_ITV}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${CANDIDATES_PER_ITV}
    should be equal as strings  ${placeholder_text}    ex: 4
    check element display on screen     ${INTERVIEW_DURATION_DROPDOWN}
    check element display on screen     ${INTERVIEW_TIME_SLOT_DROPDOWN}
   # Check value of VENUE_LOCATION_TEXTBOX and VENUE_NAME_TEXTBOX same as inputed data at Overview step
    check element display on screen     ${VENUE_LOCATION_TEXTBOX}
    ${venue_location_actual} =  Get text and format text   ${VENUE_LOCATION_TEXTBOX}
    should be equal as strings  ${venue_location}   ${venue_location_actual}
    check element display on screen     ${VENUE_NAME_TEXTBOX}
    ${venue_name_actual} =  Get text and format text   ${VENUE_NAME_TEXTBOX}
    should be equal as strings  ${venue_name}   ${venue_name_actual}
    # Check UI of Interviewers section
    check span display     Interviewers
    check span display     Add Interviewers
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    # Check UI of Settings section
    check span display     Settings
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check UI of display when the user select Interview type In person meeting of Hiring in person session
    [Arguments]     ${venue_location}    ${venue_name}
    # Check UI of Session Details section
    check span display    Session Details
    check span display    Session Name
    check span display    Start Time
    check span display    End Time
    check element display on screen     ${SESSION_NAME_TEXTBOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${SESSION_NAME_TEXTBOX}
    should be equal as strings  ${placeholder_text}    Enter Session Name
    check element display on screen     ${START_TIME_TXT}
    check element display on screen     ${END_TIME_TXT}
    # Check UI of Interview Details section
    check span display     Interview Details
    check span display     Interview Type
    check span display     Duration of Each Interview
    check span display     Per duration, how many interview time slots do you want to create?
    check element display on screen     ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Set session interview type      In-person meeting
    check element display on screen     ${INTERVIEW_DURATION_DROPDOWN}
    check element display on screen     ${INTERVIEW_TIME_SLOT_DROPDOWN}
   # Check value of VENUE_LOCATION_TEXTBOX and VENUE_NAME_TEXTBOX same as inputed data at Overview step
    check element display on screen     ${VENUE_LOCATION_TEXTBOX}
    ${venue_location_actual} =  Get text and format text   ${VENUE_LOCATION_TEXTBOX}
    should be equal as strings  ${venue_location}   ${venue_location_actual}
    check element display on screen     ${VENUE_NAME_TEXTBOX}
    ${venue_name_actual} =  Get text and format text   ${VENUE_NAME_TEXTBOX}
    should be equal as strings  ${venue_name}   ${venue_name_actual}
    # Check UI of Interviewers section
    check span display     Interviewers
    check span display     Add Interviewers
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    ${placeholder_text}=    Get attribute and format text   placeholder     ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    should be equal as strings  ${placeholder_text}    Search & Add Event Team Members
    # Check UI of Settings section
    check span display     Settings
    check element display on screen     ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    check element display on screen     ${SAVE_SESSION_NAME}
    check element display on screen     ${ADD_SESSION_CANCEL_BUTTON}
    capture page screenshot

Check list Session Venue dropdown item of Orientation show data correct
    Click at    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    check element display on screen    ${EVENT_INTERVIEW_DROPDOWN_OPTION}    In Person
    check element display on screen    ${EVENT_INTERVIEW_DROPDOWN_OPTION}    Virtual
    check element display on screen    ${EVENT_INTERVIEW_DROPDOWN_OPTION}    Candidate Store Location

Check list times on Duration of Each Interview show data correct
    Click at    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Click at    ${INTERVIEW_DURATION_DROPDOWN}
    @{type_list} =    create list    15 min    20 min    30 min    45 min    1 hour    1 hour 30 min    2 hours     Custom
	FOR    ${option}    IN    @{type_list}
		Check element display on screen    ${INTERVIEW_DURATION_DROPDOWN}    ${option}
	END
    Check span display   Apply
    Check common text last display   Cancel

Chooses Custom on Duration of Each Interview dropdown
    [Arguments]     ${hours}    ${minutes}
    Click on span text      Custom
    Check element display on screen     ${INTERVIEW_DURATION_CUSTOM_HOUR_INPUT}
    Check element display on screen     ${INTERVIEW_DURATION_CUSTOM_MINUTE_INPUT}
    Input into      ${INTERVIEW_DURATION_CUSTOM_HOUR_INPUT}     ${hours}
    Input into      ${INTERVIEW_DURATION_CUSTOM_MINUTE_INPUT}     ${minutes}
    Click on span text   Apply

Check UI of confirm delete session modal
    Check p text display    Are you sure you want to delete this session? This action cannot be undone.
    Check common text last display      Delete Session
    capture page screenshot

Check UI of confirm delete session modal with event have candidate
    Check p text display    This change will require Olivia to contact and cancel 1 candidate. Are you sure you want to continue?
    Check common text last display      Delete Session
    capture page screenshot

Check list interview time slot show data correct
    ${count} =  Get Element Count   ${COMMON_SPAN_INTERVIEW_TIME_SLOT}
    Should Be True  ${count} -1     50
    Check span display  50 Interview Time Slots

Check UI of confirmation edit modal appears when the user edit a Session
    Check span display  Update Changes and Send
    Check p text display    This change will require Olivia to contact and potentially reschedule 1 of 1 candidate. Are you sure you want to continue?
    Check common text last display  Continue
    capture page screenshot

Check user can add user available on Add session staff
    [Arguments]     ${team}
    Add interviewer for session     ${team}
    Check element display on screen     ${team}
    capture page screenshot

Check user can not add user unavailable on Add session staff
    [Arguments]     ${team}
    Click at        ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    Check element display on screen     ${EVENT_INTERVIEWER_UNAVAILABLE_CHECKBOX}   ${team}
    capture page screenshot
    Click at    ${EVENT_ADD_INTERVIEWER_CANCEL_BUTTON}

Check list item of event RSVP dropdown
    Check common text last display  RSVP Pending
	Check common text last display  Going
	Check common text last display  Not Going
    capture page screenshot
