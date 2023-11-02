*** Settings ***
Resource        ../../pages/base_page.robot
Resource        ../../pages/event_page.robot
Resource        ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        aramark    birddoghr    advantage    dev2    lts_stg    olivia    regression    stg   test

*** Variables ***
@{list_users}               ${EN_TEAM}    ${FO_TEAM}    ${RC_TEAM}
@{list_users1}              ${EN_TEAM}    ${RC_TEAM}
${start_time}               07:00 AM
${end_time}                 05:00 PM
${end_time_edit}            04:00 PM
${empty_value}              -
${start_time_1}             01:00 PM
${start_time_16}            07:00am -

#time slot
${session_time_slot_1}      01:00pm - 01:15pm
${session_time_slot_2}      01:15pm - 01:30pm
${session_time_slot_3}      01:30pm - 01:45pm
${session_time_slot_4}      01:45pm - 02:00pm
${session_time_slot_5}      02:00pm - 02:15pm
${session_time_slot_6}      02:15pm - 02:30pm
${session_time_slot_7}      02:30pm - 02:45pm
${session_time_slot_8}      02:45pm - 03:00pm
${session_time_slot_9}      03:00pm - 03:15pm
${session_time_slot_10}     03:15pm - 03:30pm
${session_time_slot_11}     04:00pm - 04:15pm
${session_time_slot_12}     04:15pm - 04:30pm
${session_time_slot_14}     04:30pm - 04:45pm
${session_time_slot_15}     04:45pm - 05:00pm
${session_time_slot_16}     07:00am - 07:15am
${session_time_slot_17}     07:15am - 07:30am
${session_time_slot_18}     07:30am - 07:45am

*** Test Cases ***
Check direct the user to the Team tab within the event when the Add Team Members button is clicked (OL-T20569, OL-T20559, OL-T20561, OL-T20568)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	# Create event and Verify (OL-T20561) event manager can manually add a candidate
	${event_infor}=     Create new hiring event, scheduled candidate to interview slot      Virtual     ${session_time_slot_16}   None
	${candidate_name} =     Set variable        ${event_infor.full_name}
    Check element display on screen     ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}        ${session_time_slot_16}
    Check span display    ${candidate_name}
    Click at     ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}        ${session_time_slot_16}
    # Verify UI of the Add Interviewer dropdown
    Check p text display    No Interviewers Available
    Check p text display    All team members are currently unavailble
    Capture page screenshot
    # Verify the user is directed to the Team tab
    Click at      ${ADD_INTERVIEWS_ADD_TEAM_MEMBER_BUTTON}
    Check element display on screen     ${MY_EVENT_TEAM_TEXT}
    Capture page screenshot


Verify a snackbar is thrown when an interviewer is manually assigned to a scheduled candidate (OL-T20571, OL-T20558, OL-T20563, OL-T20549, OL-T20553, OL-T20545)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_1}    ${FO_TEAM}
	${candidate_name} =     Set variable        ${event_infor.full_name}
	${event_name} =     Set variable        ${event_infor.event_name}
	# Verify toasted message is shown
	Click at      ${EVENT_SCHEDULE_INTERVIEWER_NAME}     ${FO_TEAM}
	Click at    ${RC_TEAM}
	Check element display on screen     ${TOASTED_MESSAGE_ADD_INTERVIEWS}    ${RC_TEAM}
	Capture page screenshot
	# Check the interviewer is removed when click Undo button
	Click at    ${UNDO_BUTTON_ON_TOASTED_MESSAGE}
	Check element not display on screen     ${EVENT_SCHEDULE_INTERVIEWER_NAME}     ${RC_TEAM}
	Switch to user      ${FO_TEAM}
	# Verify data will appear on the left
	Click at    ${MY_EVENT_SCHEDULE_LABEL}
    Check element display on screen     ${MY_EVENT_SCHEDULE_INTERVIEW_SESSIONS}     ${candidate_name}
    # Verify data will appear on the right
    Check element display on screen     ${MY_EVENT_SCHEDULE_CANDIDATE_NAME_ON_CARD}     ${candidate_name}
    Check element display on screen     ${MY_EVENT_SCHEDULE_SHORT_NAME_ON_CARD}     ${candidate_name}
    Check element display on screen     ${MY_EVENT_SCHEDULE_CHECK_IN_BUTTON_ON_CARD}     ${candidate_name}
	Capture page screenshot
	Switch to user   ${TEAM_USER}
    Cancel event from event list        ${event_name}


Verify Add Candidate slide will be closed when clicking on Cancel button or Close icon (OL-T20562)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step with future time    Virtual    Single Event
    Set Team step with multiple users   @{list_users}
    ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FO_TEAM}
    Set tool step and create event
	Go to event schedule list view
    Click at    ${EVENT_SCHEDULE_ADD_CANDIDATE_BUTTON}      ${session_time_slot_2}
    # Check UI Add Candidate slide popup
    Check span display      Add Candidate to Open Interview Time
    Check element display on screen     ${session_name}
    Check element display on screen     15 minutes virtual interview
    Capture page screenshot
    # Check Add Candidate slide is closed when click close button
    Click at    ${ADD_CANDIDATE_POPUP_CLOSE_BUTTON}
    Check element not display on screen     ${EVENT_CEM_ADD_CANDIDATE_BUTTON}
    Capture page screenshot
    # Check Add Candidate slide is closed when click cancel button
    Click at    ${EVENT_SCHEDULE_ADD_CANDIDATE_BUTTON}      ${session_time_slot_2}
    Click at    ${ADD_CANDIDATE_POPUP_CANCEL_BUTTON}
    Check element not display on screen     ${EVENT_CEM_ADD_CANDIDATE_BUTTON}
    Capture page screenshot


Check empty style state in Interview column (OL-T20541, OL-T20542, OL-T20543)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name} =     Create new hiring event      Virtual     ${FO_TEAM}
	${candidate_interview_scheduled} =     Add candidate at event homepage     ${session_time_slot_3}
    Click at    ${CANDIDATE_LABEL}
    Click at    All Candidates
    # Check show empty style when Candidates picked interview time
    Check element display on screen     Interviewer
    Verify value of column is correctly     ${CANDIDATE_TAB_JOURNEY_STATUS}      ${candidate_interview_scheduled.first_name}       Interview Scheduled
    Verify value of column is correctly     ${CANDIDATE_TAB_INTERVIEWER_COLUMN}    ${candidate_interview_scheduled.first_name}       ${empty_value}
    # Check show empty style when Candidates don't pick interview time
    Click at    Add Candidate
    ${candidate_capture_complete} =   Input CEM Full name and email
    Verify value of column is correctly     ${CANDIDATE_TAB_JOURNEY_STATUS}    ${candidate_capture_complete.first_name}       Capture Complete
    Verify value of column is correctly     ${CANDIDATE_TAB_INTERVIEWER_COLUMN}    ${candidate_capture_complete.first_name}       ${empty_value}
    Capture page screenshot
    # Check the candidate’s assigned Interviewer will be listed in Interview column
    Go to event schedule list view
    Add interviewer for candidate       ${session_time_slot_3}     ${FO_TEAM}
    Click at    ${CANDIDATE_LABEL}
    Click at    All Candidates
    Verify value of column is correctly     ${CANDIDATE_TAB_INTERVIEWER_COLUMN}    ${candidate_interview_scheduled.first_name}       ${FO_TEAM}
    Capture page screenshot
    # Check candidate assigned to the user will be listed on my candidate list view
    Switch to user      ${FO_TEAM}
    Click at    ${MY_CANDIDATES_LIST_VIEW}
    Verify value of column is correctly     ${CANDIDATE_TAB_INTERVIEWER_COLUMN}    ${candidate_interview_scheduled.first_name}       ${FO_TEAM}
    Capture page screenshot
    Switch to user      ${TEAM_USER}
    Cancel event from event list        ${event_name}


Verify all dismissed tasks will reappear within the Tasks widget if the user dismiss Tasks, leaves the event, and then comes back to the event (OL-T20586, OL-T20587, OL-T22496, OL-T20582, OL-T20585)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_infor}=      Create new hiring event, scheduled candidate to interview slot      Virtual     ${session_time_slot_4}      ${RC_TEAM}
    Click at    ${DASH_BOARD_NAVIGATION}
    # Verify OL-T20585
    Verify tasks will appear on event dashboard
    # Verify Tasks widget will only be available to the event managers (FO_TEAM)
    Switch to user      ${FO_TEAM}
    Check element not display on screen     ${DASHBOARD_ASSIGN_INTERVIEWS_BUTTON}
    Capture page screenshot
    # Verify OL-T20587
    Switch to user      ${TEAM_USER}
    Verify tasks will appear on event dashboard
    # Verify OL-T22496
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Add interviewer for candidate       ${session_time_slot_4}      ${RC_TEAM}
    wait for page load successfully
    Click at    ${DASH_BOARD_NAVIGATION}
    Check element not display on screen     ${DASHBOARD_ASSIGN_INTERVIEWS_BUTTON}
    Capture page screenshot
    ${event_name} =      Set variable    ${event_infor.event_name}
    Cancel event from event list        ${event_name}


Verify the event ends, Tasks widget will no appear (OL-T20588, OL-T20583)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_infor}=      Create new hiring event, scheduled candidate to interview slot      Virtual     ${session_time_slot_5}     ${FO_TEAM}
    Click at    ${DASH_BOARD_NAVIGATION}
    # Verify OL-T20583
    Verify Tasks widget will be available
    Switch to user      ${TEAM_USER}
    ${event_name} =      Set variable    ${event_infor.event_name}
    Cancel event from event list        ${event_name}
    # Verify Tasks widget will no appear when event is cancel: OL-T20588
    Go to event dashboard     ${event_name}
    Check element not display on screen     ${DASHBOARD_ASSIGN_INTERVIEWS_BUTTON}
    Capture page screenshot


Verify columns are available in the Event Schedule List view (OL-T20576)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name}=      Create new hiring event      Virtual     ${FO_TEAM}
	${candidate_name} =     Add candidate at event homepage     ${session_time_slot_8}
	Add interviewer for candidate       ${session_time_slot_8}     ${FO_TEAM}
    Check element display on screen     Session Name
    Check element display on screen     Type & Time
    Check element display on screen     Candidate Name
    Check element display on screen     Interviewer
    Check element display on screen     Check-In
    Check span display      ${session_time_slot_8}
    Check span display      ${candidate_name.full_name}
    Capture page screenshot
    Cancel event from event list        ${event_name}
    Given Setup test


Verify display all available interview slots that the use could be scheduled in My Schedule tab even they are the same time (OL-T20547)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =      Set Overview step with future time    Virtual    Single Event
    Set Team step with multiple users   @{list_users}
    ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FO_TEAM}    None      3 Interview Time Slots
    Set tool step and create event
    ${candidate_name}=   Add candidate at event homepage     ${session_time_slot_7}
    Add interviewer for candidate       ${session_time_slot_7}     ${FO_TEAM}
    Switch to user      ${FO_TEAM}
    # Check Event Schedule and slots time will be is displayed
    Check element display on screen     ${EVENT_SCHEDULE_EVENT_SESSION_NAME}        ${session_name}
    Capture page screenshot
    Click at     ${MY_EVENT_SCHEDULE_LABEL}
    Check element display on screen     ${MY_EVENT_SCHEDULE_INTERVIEW_SESSIONS}        ${candidate_name.first_name}
    Capture page screenshot
    Switch to user      ${TEAM_USER}
    Cancel event from event list        ${event_name}


Verify Empty State of My Event Schedule tab (OL-T20550, OL-T20581)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create new hiring event     Virtual     ${FO_TEAM}
    Click at    ${SCHEDULE_LABEL}
    Click at    ${MY_EVENT_SCHEDULE_LABEL}
    # Verify Empty State of My Event Schedule
    Check element display on screen     No Sessions or Interviews Scheduled
    Check element not display on screen     ${MY_EVENT_SCHEDULE_INTERVIEW_SESSIONS}
    Capture page screenshot
    # Check the empty style of Event Schedule at List view
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Verify value of column is correctly        ${EVENT_SCHEDULE_INTERVIEWER_COLUMN}     ${session_time_slot_1}      ${empty_value}
    Verify value of column is correctly        ${EVENT_SCHEDULE_CHECK_IN_COLUMN}     ${session_time_slot_1}      ${empty_value}
    Capture page screenshot


Verify event's manager can check-in candidates by clicking on the Check-In button (OL-T20575, OL-T22497)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_infor}=    Create new hiring event, scheduled candidate to interview slot      Virtual     ${session_time_slot_8}    ${FO_TEAM}
    # Verify Check-in column is display correctly
    Verify value of column is correctly        ${EVENT_SCHEDULE_INTERVIEWER_COLUMN}     ${session_time_slot_9}      ${empty_value}
    Check element display on screen     ${EVENT_SCHEDULE_CHECK_IN_BUTTON}    ${session_time_slot_8}
    # Verify UI Check-in button after Click on it
    Verify check-in button is checked       ${session_time_slot_8}
    Add candidate at event homepage     ${session_time_slot_9}
    Add interviewer for candidate       ${session_time_slot_9}     ${FO_TEAM}
    Verify check-in button is checked       ${session_time_slot_9}
    Capture page screenshot
    ${event_name} =     Set variable    ${event_infor.event_name}
    Cancel event from event list        ${event_name}


Verify event's managers and ambassadors will able to see the interviewers assigned to scheduled candidates in event schedule calendar view (OL-T20551, OL-T20555)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_infor}=    Create new hiring event, scheduled candidate to interview slot      Virtual     ${session_time_slot_17}    ${FO_TEAM}
    ${candidate_name} =     Set variable    ${event_infor.full_name}
    ${session_name} =     Set variable    ${event_infor.session_name}
    ${event_name} =     Set variable    ${event_infor.event_name}
    Check the Interviewers assigned to a candidate      ${candidate_name}      No Interviewer Assigned       ${session_name}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Add interviewer for candidate       ${session_time_slot_17}     ${FO_TEAM}
    Check the Interviewers assigned to a candidate      ${candidate_name}       ${FO_TEAM}       ${session_name}
    Cancel event from event list        ${event_name}


Verify User Permissions is not taken into consideration when auto-assign interviewers to scheduled candidates. (OL-T22494, OL-T20572, OL-T20566)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer     Virtual     ${session_time_slot_16}    ${FO_TEAM}
    Click at     ${EVENT_SCHEDULE_INTERVIEWER_NAME}     ${FO_TEAM}
    Verify UI of the Add Interviewer dropdown
    Click on common text last   ${RC_TEAM}
    Check element display on screen     ${EVENT_SCHEDULE_INTERVIEWER_NAME}     ${RC_TEAM}
    Capture page screenshot
    ${event_name} =   Set variable    ${event_infor.event_name}
    Cancel event from event list        ${event_name}


Verify users will be listed under ‘Available Team Members’ and 'Session Interviewers' when clicking on Add Interviewer button (OL-T20564)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_infor} =    Create new hiring event, scheduled candidate to interview slot     Virtual     ${session_time_slot_9}    ${FO_TEAM}
    Click by JS    ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}    ${session_time_slot_9}
    Check element display on screen     ${FO_TEAM}
    Check element display on screen     ${RC_TEAM}
    Capture page screenshot
    ${event_name} =   Set variable    ${event_infor.event_name}
    Cancel event from event list        ${event_name}


Verify the user is directed to the Event Schedule List View when the ‘Assigned Interviewers’ button is clicked (OL-T20584, OL-T20567)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create new hiring event, scheduled candidate to interview slot     Virtual     ${session_time_slot_2}    ${RC_TEAM}
    # Check the user is directed to Event Schedule List view
    Click at    ${DASH_BOARD_NAVIGATION}
    Click at    ${DASHBOARD_ASSIGN_INTERVIEWS_BUTTON}
    Check element display on screen      ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}    ${session_time_slot_2}
    Capture page screenshot
    # Check show Calendar/List View icon on the right
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Check element display on screen    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Check element display on screen    ${EVENT_SCHEDULE_CALENDAR_VIEW_BUTTON}
    Capture page screenshot
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    # Verify OL-T20567
    Click at    ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}    ${session_time_slot_2}
    Verify UI of the Add Interviewer dropdown
    # Check not show List View icon on the right corner
    Switch to user      ${FO_TEAM}
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Check element not display on screen    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Check element not display on screen    ${EVENT_SCHEDULE_CALENDAR_VIEW_BUTTON}
    Capture page screenshot


Verify My Candidates list view when the hiring event has a Virtual Chat Booth created (OL-T22495)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name} =     Create new hiring event      Virtual     ${FO_TEAM}
	Click at    ${CANDIDATE_MENU_LABEL}
	Click at    ${MY_CANDIDATES}
	Check element display on screen     0 Candidates


Verify the scheduled candidates is able to rescheduled & canceled their interview when interviewer is removed from interview session (OL-T22493)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_2}    ${FO_TEAM}
	Go to edit event page from dashboard
	# Verify The Remove User from Session modal will be shown
	Click at    ${SCHEDULE_TAB}
	Click at    ${SESSION_TITLE_NAME_LABEl}
	Click at    ${ICON_EDIT_SESSION_EVENT_ROW}
    Click at    ${EDIT_INTERVIEW_SESSION_ICON_MENU}    ${FO_TEAM}
    Click on span text    Remove Interviewer
    Capture page screenshot
    # Verify the assigned interviewer is removed out of scheduled candidates
    Click at    ${EVENT_CREATOR_TEAM_ROLE_CONFIRM_REMOVE_BUTTON}
    Click at    ${SAVE_SESSION_NAME}
    wait for page load successfully
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Check element display on screen     ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}    ${session_time_slot_2}
    Add interviewer for candidate       ${session_time_slot_2}    ${FO_TEAM}
    Capture page screenshot
    Cancel event from event list        ${event_infor.event_name}


Verify Interview Type and Interview Time columns within all Candidate List views within a hiring event will be combined to 1 column Type & Time (OL-T20544, OL-T20557)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_3}    ${RC_TEAM}
    Switch to user    ${RC_TEAM}
    Click at    ${CANDIDATE_LABEL}
    Click at    ${MY_CANDIDATES_LIST_VIEW}
    Verify Interview Type and Interview Time columns    ${event_infor.full_name}   ${session_time_slot_3}
    Switch to user     ${TEAM_USER}
    Cancel event from event list        ${event_infor.event_name}


Verify the displaying of candidates in My Schedule tab (OL-T20546)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_6}    ${FO_TEAM}
    Switch to user      ${FO_TEAM}
    Click at    ${MY_EVENT_SCHEDULE_LABEL}
    Check element display on screen     ${MY_EVENT_SCHEDULE_INTERVIEW_SESSIONS}       ${event_infor.full_name}
    Check element display on screen     ${EVENT_NAME_IN_CARD}       ${event_infor.full_name}
    Check element display on screen     ${MY_EVENT_SCHEDULE_INTERVIEWER_OPEN_SLOT}
    Capture page screenshot
    Switch to user     ${TEAM_USER}
    Cancel event from event list        ${event_infor.event_name}


Verify the interview time slot should be deleted from the list view when the user deleted it from the Event Schedule Calendar view (OL-T20580)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_5}    ${RC_TEAM}
    Click at    ${EVENT_SCHEDULE_CALENDAR_VIEW_BUTTON}
    Click at    ${event_infor.session_name}
    Hover at      ${EVENT_SCHEDULE_OPEN_INTERVIEW_TIME_ICON_MENU}     ${start_time_16}
    Click by JS    ${EVENT_SCHEDULE_OPEN_INTERVIEW_TIME_ICON_MENU}     ${start_time_16}
    Click at      ${EVENT_SCHEDULE_OPEN_INTERVIEW_TIME_DELETE_INTERVIEW_BUTTON}
    Click at    ${EVENT_SCHEDULE_OPEN_INTERVIEW_TIME_CONFIRM_DELETE_BUTTON}
    # Verify the interview time slot should be deleted
    Check element not display on screen     ${EVENT_SCHEDULE_OPEN_INTERVIEW_TIME_ICON_MENU}     ${start_time_16}
    Click at     ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    # Verify the interview time slot should be deleted from the list view
    Check element not display on screen     ${session_time_slot_16}
    Capture page screenshot
    Cancel event from event list        ${event_infor.event_name}


Verify Round Robin logic is applied to the Add Interviewer to scheduled candidates by auto assign users (OL-T20565, OL-T20556)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	# Create event that have 2 interviewers to interview session
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =  Set Overview step with future time    Virtual    Single Event
    Set Team step with multiple users       @{list_users}
    ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FO_TEAM}   Auto-Assign Interviewers
    Go to edit session popup    ${session_name}
    Add interviewer for session     ${RC_TEAM}
    click save session button
    Set tool step and create event
    # Verify the added interviewers are auto-assigned to the schedule candidates
    Add candidate at event homepage     ${session_time_slot_10}
    Add candidate to event  ${session_time_slot_11}
    Check element display on screen     ${EVENT_SCHEDULE_INTERVIEWER_NAME}     ${RC_TEAM}
    Capture page screenshot
    Cancel event from event list        ${event_name}


Verify the interviewer's full name will appear in Interviewer column when a scheduled candidate is assinged an interviewer (OL-T20560)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_6}    ${RC_TEAM}
	Go to Events page
	Search and go to event homepage     ${event_infor.event_name}
	Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Check element display on screen     ${EVENT_SCHEDULE_INTERVIEWER_NAME}     ${RC_TEAM}
    Capture page screenshot
    Cancel event from event list        ${event_infor.event_name}


Verify the user can manually add candidates into open interview time slots in My Schedule tab (OL-T20548)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	${event_name}=    Create new hiring event       Virtual     ${FO_TEAM}
	Switch to user      ${FO_TEAM}
	Click at    ${SCHEDULE_LABEL}
    Click at    ${MY_EVENT_SCHEDULE_LABEL}
    Click at    ${MY_EVENT_SCHEDULE_ICON_MENU}      ${start_time_1}
    Click at    ${MY_EVENT_SCHEDULE_ADD_CANDIDATE}
    ${candidate_name}=  Input CEM Full name and email
    Go to Events page
	Search and go to event homepage     ${event_name}
	Click at    ${SCHEDULE_LABEL}
    Click at    ${MY_EVENT_SCHEDULE_LABEL}
    Check element display on screen     ${MY_EVENT_SCHEDULE_SHORT_NAME_ON_CARD}    ${candidate_name.full_name}
    Capture page screenshot
    Switch to user      ${TEAM_USER}
    Cancel event from event list        ${event_name}


Verify total of Interviewers added to the interview session within the Session Pop-up (OL-T20540)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_7}    ${RC_TEAM}
	Go to Events page
	Search and go to event homepage     ${event_infor.event_name}
	Go to edit event page from dashboard
	Click at    ${SCHEDULE_STEP_LABEL}
	Click at    ${SESSION_TITLE}       ${event_infor.session_name}
	Check element display on screen     1 Interviewer
	Check element display on screen     Interview Details
    Capture page screenshot
    Cancel event from event list        ${event_infor.event_name}


Verify the user can search interview slots by Candidate Full Name and Interviewer Full Name (OL-T20577)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
	${event_infor}=    Create new hiring event, scheduled candidate to interview slot and add interviewer      Virtual     ${session_time_slot_8}    ${FO_TEAM}
	${candidate_name} =     Add candidate at event homepage     ${session_time_slot_9}
    Add interviewer for candidate       ${session_time_slot_9}     ${RC_TEAM}
    Input into      ${EVENT_SCHEDULE_SEARCH_INPUT}      ${event_infor.full_name}
    Check span display        ${event_infor.full_name}
    Check element display on screen        ${EVENT_SCHEDULE_INTERVIEWER_NAME}       ${FO_TEAM}
    Check element not display on screen     ${EVENT_SCHEDULE_INTERVIEWER_NAME}    ${RC_TEAM}
    Capture page screenshot
    Cancel event from event list        ${event_infor.event_name}


Verify the ‘Available Team Members’ section is hiden if only users added to the interview session have availability to be added to the interview time slot (OL-T20573)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Switch to user    ${FO_TEAM}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =     Set Overview step with future time    Virtual    Single Event
    Set Team step with multiple users   @{list_users1}
    ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FO_TEAM}
    Set tool step and create event
	Go to edit event page from dashboard
	Go to edit session popup         ${session_name}
	Add interviewer for session     ${EN_TEAM}
	Add interviewer for session     ${RC_TEAM}
    click save session button
    Set tool step and create event
    Go to event schedule list view
    Add candidate to event      ${session_time_slot_10}
	Click at    ${EVENT_SCHEDULE_ADD_INTERVIEWER_BUTTON}    ${session_time_slot_10}
    Check element not display on screen     Available Team Members
    Capture page screenshot
    Cancel event from event list        ${event_name}

*** Keywords ***
Verify value of column is correctly
    [Arguments]     ${locator}    ${dynamic_locator}     ${value}
    ${columns_locator} =    Format String    ${locator}    ${dynamic_locator}   ${value}
    Scroll to element   ${columns_locator}
    Check element display on screen     ${columns_locator}

Verify tasks will appear on event dashboard
    Click on span text      Dismiss
    Check element not display on screen     ${DASHBOARD_ASSIGN_INTERVIEWS_BUTTON}
    Capture page screenshot
    reload page
    Verify Tasks widget will be available
    Capture page screenshot

Verify Tasks widget will be available
    Check span display      Tasks
    Check span display      Candidate Do Not Have an Interviewer Assigned.
    Check span display      Dismiss
    Check element display on screen     ${DASHBOARD_ASSIGN_INTERVIEWS_BUTTON}
    Capture page screenshot

Check the Interviewers assigned to a candidate
    [Arguments]     ${candidate_name}      ${interviewer}      ${session_name}
    Click at    ${EVENT_SCHEDULE_CALENDAR_VIEW_BUTTON}
    Click at    ${session_name}
    ${locator} =    Format string     ${EVENT_SCHEDULE_INTERVIEWER_ON_CARD}      ${candidate_name}      ${interviewer}
    Check element display on screen     ${locator}
    Capture page screenshot
    wait for page load successfully

Verify check-in button is checked
    [Arguments]     ${session_time}
    Click at  ${EVENT_SCHEDULE_CHECK_IN_BUTTON}    ${session_time}
    Check element display on screen     ${EVENT_SCHEDULE_CHECK_IN_IS_CHECKED_BUTTON}    ${session_time}

Go to event schedule list view
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}

Verify UI of the Add Interviewer dropdown
    Check element display on screen     Session Interviewers
    Check element display on screen     Available Team Members
    Check element display on screen     ${FO_TEAM}
    Check element display on screen     ${RC_TEAM}
    Capture page screenshot

Verify Interview Type and Interview Time columns
    [Arguments]     ${candidate_name}       ${session_time}
    Check element display on screen    ${CANDIDATE_TAB_VIRTUAL_INTERVIEW_ICON}     ${candidate_name}
    Hover at    ${CANDIDATE_TAB_VIRTUAL_INTERVIEW_ICON}     ${candidate_name}
    Check element display on screen     virtual interview
    ${interviewer_time} =   Format string       ${CANDIDATE_TAB_INTERVIEW_TIME}     ${candidate_name}       ${session_time}
    Check element display on screen     ${interviewer_time}
    Capture page screenshot
