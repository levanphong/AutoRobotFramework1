*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/users_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        aramark    birddoghr    advantage    dev2   lts_stg    olivia    regression    stg       test

*** Variable ***
${hiring_event}                 Hiring Events
${campus_activity}              Campus Activity
${orientation}                  Orientation
@{hiring_event_main_text}       Create a mobile-first experience for virtual and in-person hiring events with Olivia
...                             handling registration and reminders
...                             Includes
...                             Create a custom schedule that your event team and scheduled candidates will
...                             participate in
...                             Use branded keywords and phone numbers or create an event landing page that can be
...                             used for advertising your event
...                             Tie a registration conversation to your event that allows for candidates to be
...                             pre-scheduled to your event
@{campus_activity_main_text}    This activity type creates on-campus activities tied to your annual campus plan.
...                             They are mainly used for pre- and post-event planning tasks. These include ordering
...                             collateral, posting jobs, or creating a pre-event marketing strategy
@{orientation_main_text}        This event type is for events where you want to create and schedule candidates to
...                             orientation events
...                             Includes
...                             Create a custom event agenda for your facilitators and candidates
...                             Pre-schedule candidates to the orientation event
...                             Ensure that candidates are prepared for their orientation with orientation prep
...                             documents
${planned_price}                19
${schedule_tab_messsage}        Create a schedule for your event by adding sessions during the event’s dates and times. To add a new session, click and drag over the calendar.
${new_session_name}             New session name
${venue_location}               TestLocation
${venue_test_location}          Venue test location
${virtual}                      Virtual
${venue_name}                   TestName
${hiring_event_template}        hiring_event_template_automation
${form_session}                 Form
${interview_session}            Interview
${event_templates}              Event Templates
${interviewer_duration}         15 min

*** Test Cases ***
Check UI changes when selecting options in Event Types Selection modal (OL-T4160, OL-T4161)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	And click on create new event button
	Then Event Type modal should be shown
	Click at    ${MODAL_HIRING_EVENT}
	Then Verify main text displayed correctly    @{hiring_event_main_text}
	Click at    ${CAMPUS_ACTIVITY}
	Then Verify main text displayed correctly    @{campus_activity_main_text}
	Click at    ${ORIENT_EVENT_TYPE}
	Then Verify main text displayed correctly    @{orientation_main_text}


Check UI changes in Activity step when creating a Campus Activity (OL-T4194)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	And click on create new event button
	Click at    ${CAMPUS_ACTIVITY}
	Click on create activity button
	Then Verify Campus Activity detail shown correctly


Check UI of Overview tab when Virtual Hiring Event is selected in the event type modal (OL-T4186)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	And click on create new event button
	Click on Hiring Event type
	Click on next button
	Click on create event button
	Verify Hiring Event Overview shown correctly


Verify Campus's Event homepage correctly when campus event is created (OL-T4247)
    ${team_members}=    Create List
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	${event_name}=      Create campus active event      @{team_members}
	Event created successfully      ${event_name}
	Capture page screenshot


Hiring Event - Check UI of Schedule tab for Multiple Sessions (OL-T4183)
    Given Setup test
    Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    ${session_1}=       Set session schedule    Event Session
    Set event description    Description 1
    Event Session Details popup is displayed         ${session_1}       Description 1
    ${session_2}=       Set session schedule    Event Session
    Click at    ${SAVE_SESSION_NAME}
    Check element display on screen    ${SESSION_TITLE}        ${session_2.session_name}
    Capture page screenshot


Hiring Event - Check UI of Schedule tab when the event has multiple days (OL-T4171)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    Set Overview step    In Person    Single Event
    Choose event start date     0
    Choose next day for end date
    Click at    ${SCHEDULE_TAB}
    Check element display on screen    Day 1 of 2
    Capture page screenshot
    Click at    ${ICON_NEXT_DAY}
    Check element display on screen    Day 2 of 2
    Capture page screenshot


Hiring Event - Check UI of Schedule tab with Single Event (OL-T4170)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    Check element display on screen    ${schedule_tab_messsage}
    Capture page screenshot


Hiring Event - When ‘Single Event’ is selected at Date & Time section in Overview step (OL-T4169)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    navigate to create hiring events
    Click on create event button
    Set event occurrence    Single Event
    Single Event components display


Show the warning modal during creating event and users edit Event Start and End Dates/Times that there are session outside the start and date time (OL-T4184)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Schedule step    Scheduled Interviews
    Set tool step and create event
    Event created successfully    ${event_name}
    Go to edit event    ${event_name}
    Choose next day for start date
    Edit Event warning popup is displayed
    Capture page screenshot


Verify not showing Campus toggle in Overview step when the user has only Student Experience Manager (OL-T5045)
    #TODO maintain
    [Tags]    skip
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${user_name} =    Add a User    Full User    SEM only Full User    product_access=Student Experience Manager
    Go to CEM page
    Switch to user    ${user_name}
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    Overview tab of Student Experience Manager role only
    Discard create event
    Go to CEM page
    Switch to user    ${TEAM_USER}
    Delete a user    ${user_name}
    Capture page screenshot


Verify directing into the event builder after selecting Event Type incase the user has not created any event templates (OL-T4163)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Navigate to create hiring events
    Click on create event button
    Verify Hiring Event Overview shown correctly


Check UI of Adding session slide out when In-person is selected as Event Venue in Event Detail step (OL-T4172)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    Set session schedule    Event Session
    Set session venue type    In Person
    Verify session slide out when In-person is selected


Check UI of Event Builder when user create an event from Event Templates (OL-T4192)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Choose event template       orientation_template
    Verify overview event builder after selecting event templates


Check user can delete an Interview/Event session (OL-T4179, OL-T4178)
    Given Setup test
    Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    ${session_1}=       Set session schedule    Event Session
    click save session button
    Delete session of the event     ${session_1.session_name}       False   # Delete without confirming
    # Check user can edit a session by clicking on the session block in the calendar view
    Edit session name from calendar view     ${session_1.session_name}     ${new_session_name}     False    # Edit session name without saving
    Delete session of the event     ${session_1.session_name}       True    # Confirm delete session


General Hiring Event - Check the displaying of Venue Location incase users select In-person in Event Venue dropdown (OL-T4164, OL-T12247, OL-T4175)
    Given Setup test
    Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Search location in Venue Location       Alaska
    #    Inperson Hiring Event - Verify user can add a Inperson session venue for Event Session (OL-T12247)
    #    Inperson Hiring Event - Verify user can add a Virtual session venue for Event Session (OL-T4175)
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    ${session}=     Set session schedule    Event Session
    Set session venue type    In Person
    Input location into the Venue Builder Location textbox     ${venue_location}        ${venue_name}
    Click save session button
    Check element display on screen    ${SESSION_TITLE}        ${session.session_name}


Inperson Hiring Event - Check UI of Overview step (OL-T4166)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Navigate to create hiring events
    click on create event button
    Click at    ${CAMPUS_TOGGLE}
    Overview tab displays with full component


Verify the user can edit the Event Occurrence at Event List page (OL-T5044)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has Virtual Chat Booth session
    Go to Events page
    Search event    ${session_info_vt.event_name}
    And Edit event occurrence       ${session_info_vt.event_name}
    Then Verify edit event occurrence successfully       ${session_info_vt.event_name}


Verify the default value of Start and End Time in the Add a Session slide out when creating a session (OL-T5043)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_1}
    Click at    ${EVENT_SESSION_CREATED}
    Verify default value of Start and End Time in the Add a Session


Verify Dates, Times, Locations show on Event homepage when creating Hiring Inperson event (OL-T4237)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=      Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_TAB}
    Set session schedule    Event Session
    ${session_time}=    Verify default value of Start and End Time in the Add a Session
    Click at    ${SAVE_SESSION_NAME}
    Set tool step and create event
    Go to Events page
    Search event    ${event_name}
    Verify Dates Times Locations when having multiple dates times locations     ${event_name}   ${venue_test_location}      ${session_time}


Verify Dates, Times, Locations show on Event homepage in case Virtual event session is created (OL-T4238)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual     Single Event
    Set Schedule step    Live Video Broadcast
    Set tool step and create event
    Go to Events page
    Search event    ${event_name}
    Verify Dates Times Locations when having multiple dates times locations     ${event_name}   ${virtual}      None


Event Template - Check UI of Add a Session slide when creating Session (OL-T4193)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Choose event template       ${hiring_event_template}
    ${event_name} =     Set Overview step    Virtual    Single Event
    Click at    ${SCHEDULE_TAB}
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_1}
    Add default session        ${form_session}
    Click at    ${SESSION_TEMPLATE_SELECT}
    Verify display common text      ${interview_session}
    click save session button
    Click at    ${SCHEDULE_AVAILABLE_TIME_BLOCK_2}
    Click at    ${SCHEDULED_INTERVIEWS_LABEL}
    Click at    ${SESSION_TEMPLATE_SELECT}
    Click at    ${EVENT_TEMPLATE_CREATED}        ${form_session}
    click save session button
    Verify user can use the same Session Template multiple times    2

*** Keywords ***
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

Overview tab displays with full component
    Check element display on screen    Overview
    Check element display on screen    ${EVENT_NAME_INPUT}
    Check span display    Internal Event Name is the same as Public Event Name
    Check element display on screen    ${EVENT_REPORTING_CATEGORY_DROPDOWN}
    Check element display on screen    ${VENUE_LOCATION_TEXTBOX}
    Check element display on screen    ${VENUE_NAME_TEXTBOX}
    Check span display    Campus
    Check element display on screen    ${CAMPUS_TOGGLE}
    Check element display on screen    ${SCHOOL_NAME_DROPDOWN}

Verify user can use the same Session Template multiple times
    [Arguments]    ${length}
    Page Should Contain Element     ${SESSION_TITLE_NAME_LABEL}     limit=${length}

Edit event occurrence
    [Arguments]     ${event_name}
    Go to edit event    ${event_name}
    Then Check element display on screen       ${event_name}
    Click at    ${EVENT_START_DATE}
    Click at    ${START_DATE_NEXT_MONTH_OPTION}
    Click at    ${UPDATE_EVENT_BUTTON}
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${UPDATE_SESSIONS_BUTTON}
    wait with short time
    Click on span text    Edit Event Sessions
    Click at    virtual_chat_booth_test
    Click at    ${SAVE_SESSION_NAME}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}

Verify edit event occurrence successfully
    [Arguments]     ${event_name}
    ${start_date}=    get_start_date_event_session
    Go to Events page
    Search event    ${event_name}
    Verify text contain     ${UPCOMING_EVENT_NAME}      ${event_name}
    Verify text contain     ${UPCOMING_EVENT_DATE}      ${start_date}

Verify default value of Start and End Time in the Add a Session
    ${start_time} =    Get text    ${START_TIME_INPUT}
    ${end_time} =    Get text    ${END_TIME_TXT}
    Then Verify text contain    ${SESSION_TIME_PREVIEW}     ${start_time} - ${end_time}
    ${start_time}=      Replace String       ${start_time}       ${space}       ${empty}
    [Return]       ${start_time}

Verify Dates Times Locations when having multiple dates times locations
    [Arguments]     ${event_name}      ${location}     ${session_time}=None
    ${current_date}=    get_date_with_month_in_full_string
    Verify text contain     ${UPCOMING_EVENT_NAME}      ${event_name}
    Verify text contain     ${UPCOMING_EVENT_DATE}      ${current_date}
    Verify text contain     ${UPCOMING_EVENT_LOCATION}      ${location}
    IF      '${session_time}' != 'None'
        Verify text contain     ${UPCOMING_EVENT_TIME}       ${session_time}
    END
