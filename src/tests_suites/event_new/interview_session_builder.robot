*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags          regression    dev2    stg   olivia  birddoghr   darden  aramark     lts_stg     fedex   fedexstg    test

Documentation       Availability timezone of user must be the same with timezone of Event
...                 Recruiter Team user doesn't have permission for in person interview, phone interview
...                 EN Team has no availability time

*** Variables ***
@{list_users}                       ${FS_TEAM}    ${HM_TEAM}    ${CA_TEAM}    ${RC_TEAM}    ${EN_TEAM}
${end_time_edit}                    03:00 PM

#time slot
${session_time_slot_1}              09:30am - 09:45am
${session_time_slot_2}              09:45am - 10:00am
${session_time_slot_3}              10:00am - 10:15am
${session_time_slot_4}              10:30am - 10:45am
${session_time_slot_reschedule}     04:30pm - 04:45pm

*** Test Cases ***
Verify the ‘Add to Session’ button will be inactive until a user is selected (OL-T20505, OL-T20506, OL-T20507)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name}   ${session_name}=    Create event, add session and interviewer  In Person   ${FS_TEAM}
    Go to edit session popup    ${session_name}
    # Check Add to session button disable when no interviewer is selected
    Click at        ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${FS_TEAM}
    Click by JS     ${EVENT_INTERVIEWER_CHECKBOX}   ${FS_TEAM}
    Verify element is disable   ${ADD_TO_SESSION_BUTTON}
    Capture page screenshot
    # Check Add to session button enable when a interviewer is selected
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${HM_TEAM}
    Click by JS     ${EVENT_INTERVIEWER_CHECKBOX}   ${HM_TEAM}
    Verify element is enable    ${ADD_TO_SESSION_BUTTON}
    Capture page screenshot
    # Check total number of interview time slots is available for user
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${RC_TEAM}
    Check span display      Available for 28 interviews
    Capture page screenshot
    # Check user that have no availability time
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${EN_TEAM}
    Check span display      Not Available for Interviews
    Capture page screenshot


Check the user deletes entire sessions which has scheduled candidates and assigned interviewers (OL-T20508)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Switch to user      ${FULL_USER_AUTOMATION}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_1}    ${FS_TEAM}
	Capture page screenshot
	Go to edit event page from dashboard
	# Delete session
	Click at    ${SCHEDULE_STEP_LABEL}
	Click on common text last    ${event_infor.session_name}
    Click at    ${DELETE_SESSION_BUTTON}
    Click on common text last      Delete Session
    Set Schedule step   Virtual Scheduled Interviews
    Set tool step and create event
    # Check interviewer receive cancel schedule email
    Verify user has received the email      Canceled: Your virtual interview with ${event_infor.full_name}     Hi FS Team, ${FULL_USER_AUTOMATION} canceled your upcoming interview    CANCEL_SCHEDULE
    Cancel event from event list   ${event_infor.event_name}


Check the user edits the start time / end time of the session when it hasn't had scheduled candidates (OL-T20509)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Team step   ${FS_TEAM}
    Set Team step   ${HM_TEAM}
    &{session_info}=    Set Schedule step   Scheduled Interviews
    Set Registration step
    Set Tools step
    Event created successfully  ${event_name}
	Go to edit event     ${event_name}
    Go to edit session popup    ${session_info.session_name}
    #Get available time of user before update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_before_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Update end time for session     ${end_time}
    #Get available time of user after update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_after_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Should not be equal as strings  ${available_time_before_edit}   ${available_time_after_edit}
    Capture page screenshot


Check the user edits the start time / end time of the session when it has scheduled candidates and assigned interviewers (OL-T20510)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_reschedule}    ${FS_TEAM}
    Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    #Get available time of user before update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_before_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Update end time for session     ${end_time_edit}
    #Get available time of user after update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_after_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Should not be equal as strings  ${available_time_before_edit}   ${available_time_after_edit}
    Capture page screenshot
    Click at    ${EVENT_ADD_INTERVIEWER_CANCEL_BUTTON}
    click save session button
    Click on common text last   Continue
    Set tool step and create event
    #Check email send to interviewer to reschedule
    wait with large time
    Verify user has received the email      Canceled: Your virtual interview with ${event_infor.full_name}     Hello Fs! ${TEAM_USER} initiated a reschedule for your upcoming interview    CANCEL_SCHEDULE
    Cancel event from event list   ${event_infor.event_name}


Check the user edits the interview duration of the interview session (OL-T20511)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${FS_TEAM}
    Set Team step   ${HM_TEAM}
    Click at    ${SCHEDULE_STEP_LABEL}
    Set session schedule    Virtual Scheduled Interviews
    #Get available time of user before update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_before_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Update end time for session     ${end_time}
    #Get available time of user after update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_after_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Should not be equal as strings  ${available_time_before_edit}   ${available_time_after_edit}
    Capture page screenshot


Check the user edits the interview duration of the interview session when the interview session has scheduled candidates (OL-T20512)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_3}    ${FS_TEAM}
    Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
    #Get available time of user before update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_before_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    #Update interview duration and slot
    Set Interview Time Slot Per Duration    1 Interview Time Slot       30 min
    #Get available time of user after update session time
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_after_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${FS_TEAM}
    Should not be equal as strings  ${available_time_before_edit}   ${available_time_after_edit}
    Capture page screenshot
    Click at    ${EVENT_ADD_INTERVIEWER_CANCEL_BUTTON}
    click save session button
    Click on common text last   Continue
    Set tool step and create event
    # Check email send to interviewer to reschedule
    wait with large time
    Verify user has received the email      Canceled: Your virtual interview with ${event_infor.full_name}     Hello Fs! ${TEAM_USER} initiated a reschedule for your upcoming interview    CANCEL_SCHEDULE
    Cancel event from event list   ${event_infor.event_name}


Check the user edits the interview type of the interview session (OL-T20513)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    &{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_1}    ${RC_TEAM}
    Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
	Set session interview type  Phone interview
	#Get available time of user after update session interview type
    Click at    ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    wait with short time
    ${available_time_after_edit}=  Get text and format text    ${EVENT_INTERVIEWER_AVAILABLE_TIME_TEXT}    ${HM_TEAM}
    Should not be equal as strings      ${available_time_after_edit}   Not available for interviews
    Capture page screenshot
    Cancel event from event list   ${event_infor.event_name}


Verify the helper icon and text displays under the Add Interviewers input after the user makes an Interview per Duration selection (OL-T20516, OL-T20517)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name}   ${session_name}=    Create event, add session and interviewer  In Person   ${FS_TEAM}
    Go to edit session popup    ${session_name}
    Update end time for session     09:30 AM
    # Check check number of availability
    Click at        ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${HM_TEAM}
    Check span display      Available for 2 interviews
    Capture page screenshot
    # Update Interview per Duration selection and check number of availability again
    Set Interview Time Slot Per Duration    interviewer_duration=30 min
    Click at        ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}
    Input into      ${EVENT_ADD_INTERVIEWER_SEARCH_BOX}     ${HM_TEAM}
    Check span display      Available for 1 interview
    Capture page screenshot


Verify two options are available when clicking on the Interviewer ellipse (OL-T20518, OL-T20519, OL-T20523, OL-T20524)
	Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name}   ${session_name}=    Create event, add session and interviewer  In Person   ${FS_TEAM}
    Go to edit session popup    ${session_name}
    Click at    ${ADD_INTERVIEWER_ELLIPSE_BUTTON}   ${FS_TEAM}
    Check ellipse option of interviewer displays correctly
    # Click at view available and check if View Availability Interview slide is display
    Click at    ${ADD_INTERVIEWER_VIEW_AVAILABLE_ICON}
    Check span display  View Interviewer Availability
    Capture page screenshot
    Click at    ${ADD_INTERVIEWER_BACK_BUTTON}
    # Click at remove interviewer and check snack bar is throw
    Click at    ${ADD_INTERVIEWER_ELLIPSE_BUTTON}   ${FS_TEAM}
    Click at    ${ADD_INTERVIEWER_REMOVE_INTERVIEWER_ICON}
    Check element display on screen     ${FS_TEAM} Removed from Session
    Check element display on screen     ${ADD_INTERVIEWER_UNDO_BUTTON}
    Check span display      No Interviewers Have Been Added
    # Click at undo and check
    Click at    ${ADD_INTERVIEWER_UNDO_BUTTON}
    Check element display on screen     ${ADD_INTERVIEWER_NAME_LABEL}   ${FS_TEAM}
    Capture page screenshot


Verify display of interview time slot that the user is available for during this session (OL-T20520)
	Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${event_name}   ${session_name}=    Create event, add session and interviewer  In Person   ${FS_TEAM}
    Go to edit session popup    ${session_name}
    # Go to View Availability Interview slide and check information
    Click at    ${ADD_INTERVIEWER_ELLIPSE_BUTTON}   ${FS_TEAM}
    Click at    ${ADD_INTERVIEWER_VIEW_AVAILABLE_ICON}
    Check span display      View Interviewer Availability
    Check element display on screen     ${COMMON_TEXT_LAST}     ${FS_TEAM}
    Check the pill will be displayed in navy color      ${ADD_INTERVIEW_AVAILABILITY_PILL_TIME}      09:30AM
    Capture page screenshot


Verify automatically remove the user from all interview sessions If they are removed from the event Team. (OL-T20525)
	Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name}   ${session_name}=    Create event, add session and interviewer  In Person   ${FS_TEAM}
    # Go to team step and remove interviewer
    Click at    ${TEAM_STEP_LABEL}
    Click at    ${EVENT_CREATOR_TEAM_ROLE_REMOVE_ICON}  ${FS_TEAM}
    Capture page screenshot
    # Go back to interview session and check interview auto removed
    Go to edit session popup    ${session_name}
    Check span display      No Interviewers Have Been Added
    Check element not display on screen   ${ADD_INTERVIEWER_NAME_LABEL}   ${FS_TEAM}
    Capture page screenshot


Verify confirmation modal will appear when the user attempt to remove the interviewer from a session and that user is assigned to scheduled candidates (OL-T20526, OL-T20527, OL-T20528, OL-T20529)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_1}    ${HM_TEAM}
	Capture page screenshot
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
	# Click at remove interviewer and check confirmation modal is displayed
    Click at    ${ADD_INTERVIEWER_ELLIPSE_BUTTON}   ${HM_TEAM}
    Click at    ${ADD_INTERVIEWER_REMOVE_INTERVIEWER_ICON}
    Check Remove User from Session dialog is displayed      ${HM_TEAM}
    # Confim remove interviewer and save event
    Click at    ${ADD_INTERVIEWER_CONFIRM_REMOVE_INTERVIEWER_BUTTON}
    click save session button
    Set tool step and create event
    # Check interview removed from session and candidates does not remove
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_MENU_LABEL}
    Check element display on screen     ${INTERVIEWER_COLUMN_EMPTY_STATE}
    ${candidate_status}=    Get text and format text    ${JOURNEY_STATUS_TEXT}
    Should be equal as strings      ${candidate_status}     Interview Scheduled
    Capture page screenshot
    # Check interviewer receive cancel notification email
    Verify user has received the email      You've been removed from     Hi Hiring.
    Cancel event from event list   ${event_infor.event_name}


Verify UI of Setting section in creating interview sessions (OL-T20530, OL-T20531)
	Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
	${event_name}=  Set Overview step with future time    Virtual    Single Event
	Set Team step with multiple users   @{list_users}
	Click at    ${SCHEDULE_STEP_LABEL}
	Select Event session available time
	Click at    ${VT_INTERVIEW_SCHEDULE}
    Check UI of Setting section


Check Interviewers will be automatically assigned to scheduled candidates within this session If ‘Auto-Assign Interviewers’ is selected (OL-T20532, OL-T20533)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	# Create event that have 3 interview slot each session time
	Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step with multiple users   @{list_users}
    ${session_name}=    Set session schedule with interviewer   Virtual Scheduled Interviews    ${FS_TEAM}  Auto-Assign Interviewers    3 Interview Time Slots
    Go to edit session popup    ${session_name}
    Add interviewer for session     ${HM_TEAM}
    Add interviewer for session     ${CA_TEAM}
    click save session button
    Set tool step and create event
    # Add interview to 3 interview slot that have same session time
    Add candidate at event homepage     ${session_time_slot_4}
    Add candidate to event  ${session_time_slot_4}
    Add candidate to event  ${session_time_slot_4}
    # Get text and compare if 3 interviewer are different from each other
    ${interviewer_1}=   Get text and format text    ${EVENT_SCHEDULE_INTERVIEWER_ADDED_1}   ${session_time_slot_4}
    ${interviewer_2}=   Get text and format text    ${EVENT_SCHEDULE_INTERVIEWER_ADDED_2}   ${session_time_slot_4}
    ${interviewer_3}=   Get text and format text    ${EVENT_SCHEDULE_INTERVIEWER_ADDED_3}   ${session_time_slot_4}
    Should not be equal as strings  ${interviewer_1}    ${interviewer_2}
    Should not be equal as strings  ${interviewer_1}    ${interviewer_3}
    Should not be equal as strings  ${interviewer_2}    ${interviewer_3}
    Capture page screenshot
    Cancel event from event list   ${event_name}


Verify candidates can be scheduled to Open Interview Times if the interview session still has Open Interview Time even not enough interviewers (OL-T20534)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    In Person     ${session_time_slot_2}    ${HM_TEAM}
	Go to edit event page from dashboard
	Go to edit session popup    ${event_infor.session_name}
	Update end time for session     10:00 AM
    Set Interview Time Slot Per Duration    2 Interview Time Slots
	click save session button
	Set tool step and create event
	# Add another candidates to interview slot that have only on interviewer
	Add candidate at event homepage     ${session_time_slot_2}
	# Check candidate scheduled success but no interviewer assigned
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_MENU_LABEL}
    Check element display on screen     ${INTERVIEWER_COLUMN_EMPTY_STATE}
    ${candidate_status}=    Get text and format text    ${JOURNEY_STATUS_TEXT}
    Should be equal as strings      ${candidate_status}     Interview Scheduled
    Capture page screenshot
    Cancel event from event list   ${event_infor.event_name}


Verify the candidate can be scheduled again to different interviewer if they initailly reschedule interview (OL-T20535)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	&{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     ${session_time_slot_1}    ${CA_TEAM}
    Capture page screenshot
    # Check mail confirm send to candidate and reschedule
    Click button in email       Your virtual interview at ${COMPANY_EVENT}      Hi ${event_infor.first_name}     YOUR_VIRTUAL_INTERVIEW
    Click on common text last   Yes
    wait with short time
    Verify Olivia conversation message display      Do any of these times work?
    Candidate input to landing site   1
    # Go back to event and check if candidates is reschedule success with another interviewer
    Go to event dashboard   ${event_infor.event_name}
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_MENU_LABEL}
    ${interviewer}=    Get text and format text    ${INTERVIEWER_COLUMN_TEXT}
    Should not be equal as strings      ${interviewer}     ${CA_TEAM}
    Capture page screenshot
    Cancel event from event list   ${event_infor.event_name}


Verify If ‘Manually Assign Interviewers’ is selected, the users have to manually assign interviewer to schedule candidates (OL-T20536)
	Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    &{event_infor}=    Create new hiring event, scheduled candidate to interview slot      In Person  ${session_time_slot_2}    ${CA_TEAM}
    # Check interviewer not auto assigned
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_MENU_LABEL}
    Check element display on screen     ${INTERVIEWER_COLUMN_EMPTY_STATE}
    # Add interviewer by manual success
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    Add interviewer for candidate    ${session_time_slot_2}    ${CA_TEAM}
    ${interviewer}=   Get text and format text    ${EVENT_SCHEDULE_INTERVIEWER_ADDED_1}   ${session_time_slot_2}
    Should be equal as strings      ${interviewer}      ${CA_TEAM}
    Capture page screenshot
    Cancel event from event list   ${event_infor.event_name}


Verify the view of Event Schedule List view when the session has multiple interview slots at the same time (OL-T20578)
	Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${event_name}   ${session_name}=    Create event, add session and interviewer  Virtual   ${FS_TEAM}
    Go to edit session popup    ${session_name}
    Update start time for session   10:00 AM
    Update end time for session     01:00 PM
    click save session button
    ${session_name_2}=    Set session schedule with interviewer   Scheduled Interviews    ${FS_TEAM}
    Set tool step and create event
    # Check the view of Event Schedule List display correct
    Check the view of Event Schedule List display correct when duplicated session time  ${session_name}     ${session_name_2}   ${session_time_slot_3}


*** Keywords ***
Check ellipse option of interviewer displays correctly
    Check element display on screen     ${ADD_INTERVIEWER_VIEW_AVAILABLE_ICON}
    Check span display      View Avaibility
    Check element display on screen     ${ADD_INTERVIEWER_REMOVE_INTERVIEWER_ICON}
    Check span display      Remove Interviewer
    Capture page screenshot

Check UI of Setting section
    Click at    ${SESSION_TAB_SETTING}
    # Check default value of setting dropdown
    ${default_value}=   Get text and format text    ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    Should be equal as strings  ${default_value}  Auto-Assign Interviewers
    # Check UI of setting section
    Check p text display    Determine Scheduling Approach
    Check element display on screen     ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    Check span display      Select How Interviewers are Assigned to Scheduled Candidates
    Click at    ${EVENT_ADD_INTERVIEWER_SETTING_DROPDOWN}
    Check span display    Auto-Assign Interviewers
    Check p text display    Interviewers will automatically be assigned to scheduled candidates.
    Check span display     Manually Assign Interviewers
    Check p text display    Event Managers will need to manually assign interviewers to scheduled candidates.

Check Remove User from Session dialog is displayed
    [Arguments]     ${interviewer}
    Check span display      Remove User from Session
    Check p text display    ${interviewer} is currently assigned to candidates in this session. Are you sure you’d like to remove them from the session?
    Check element display on screen     ${CANCEL_BUTTON}
    Check element display on screen     ${ADD_INTERVIEWER_CONFIRM_REMOVE_INTERVIEWER_BUTTON}
    Capture page screenshot

Check the view of Event Schedule List display correct when duplicated session time
    [Arguments]     ${session_1}        ${session_2}    ${session_time}
    Click at    ${SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_LABEL}
    Click at    ${EVENT_SCHEDULE_TABLE_VIEW_BUTTON}
    ${session_time_1_locator}=  format string   ${SESSION_TIME_BY_SESSION_NAME}     ${session_1}    ${session_time}
    Check element display on screen     ${session_time_1_locator}
    ${session_time_2_locator}=  format string   ${SESSION_TIME_BY_SESSION_NAME}     ${session_2}    ${session_time}
    Check element display on screen     ${session_time_2_locator}
    Capture page screenshot
