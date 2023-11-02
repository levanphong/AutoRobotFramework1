*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/client_setup_page.robot
Variables           ../../locators/client_setup_locators.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${additional_user_for_event}                    Full User Automation
${first_schedule_card_in_event_dash_board}      //div[@id='content-header']//following-sibling::div[@class='el-row']/div/div[1]//div[@data-testid='feature_tile_lbl_title' and contains(text(),'Schedule')]
${TEXT_OVER_320}                                Time spent reading that encourages bonding between parent and child we your child like reading book With a rich library, easy-to-use app, and data insights,    for home provides rich benefits to families, producing long lasting Reading to and with children is an intimate experience that gives parents and caregivers the opportunity

*** Test Cases ***
Verify the count of candidates correctly in Roster tab (OL-T11339)
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Set Tools step
    ${current_event_url} =    Get location
    Add 30 candidates to the Orientation Event    ${event_name}
    Go back to Orientation Event page    ${current_event_url}
    Click at    Roster
    Verify Roster candidate number    30


Verify the event upcoming site link is generated correctly (OL-T11338, OL-T8312, OL-T8311)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set Registration step
    Set Tools step
    Check element display on screen    ${EVENT_LANDING_PAGE_URL}
    Go to event register page
    Check element display on screen    ${EVENT_STATUS}
    Capture page screenshot


Verify Candidate List is visible in Schedule tab when candidates were scheduled to Virtual Interviews in Event (OL-T11344)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    &{session_info}=    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step
    Set Tools step
    ${candidate_name}=  Add candidate into Interview Session    ${session_info.session_name}
    Click at    ${candidate_name}
    Check element display on screen    Candidate Profile
    Capture page screenshot


Verify Candidates tab when hiring event has no Virtual Chat Booth created (OL-T8373)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Create hiring event without create Virtual Chat Booth session
    Go to Candidates tab in event homepage
    then Check element display on screen    All Candidates
    then Check element not display on screen    My Candidates
    then Check element not display on screen    Unassigned Candidates
    Capture page screenshot


Verify Candidates tab when hiring event has Virtual Chat Booth created (OL-T8374)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Create hiring event has Virtual Chat Booth session
    Go to Candidates tab in event homepage
    then Check element display on screen    All Candidates
    then Check element display on screen    My Candidates
    then Check element display on screen    Unassigned Candidates
    Capture page screenshot


Verify Schedule page when clicking on Live Video Broadcasts (OL-T8370)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =     Set Overview step    Virtual    Single Event
    &{session_info} =   Set Schedule step    Live Video Broadcast
    Set Registration step
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${session_info.session_name}    slow_down=2s
    Verify text contain    ${SESSION_DURATION_AND_TYPE}    Live Video Broadcast
    Check element display on screen    ${SESSION_DETAIL_TIME}
    Check element display on screen    ${VIRTUAL_SESSION_JOIN_BUTTON}
    Check element display on screen    ${VIRTUAL_SESSION_PASSWORD}
    Capture page screenshot


Verify Schedule page when clicking on Virtual Chat Booth (OL-T8371)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =     Set Overview step    Virtual    Single Event
    &{session_info} =   Set Schedule step    Live Video Broadcast
    Set Registration step
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${session_info.session_name}    slow_down=2s
    Click at    ${VIRTUAL_SESSION_JOIN_BUTTON}
    Capture page screenshot


Verify user can add member as normal to per candidate when hiring event has no Virtual Chat Booth created (OL-T8376)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    ${additional_user_for_event}   Manager
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Switch to user    ${additional_user_for_event}
    Choose Going event for user
    Go to Candidates tab in event homepage
    Click at    All Candidates
    then Add new candidate to schedule to event and check it works correctly
    Assign a team member to candidate       ${additional_user_for_event}
    Capture page screenshot


Verify an Event Session is created within the hiring event (OL-T8364)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Check element display on screen    Virtual Chat Booth
    Click at    ${session_info.session_name}
    Check element display on screen    ${SESSION_DETAIL_TIME}
    Click at    ${SESSION_CARD_BACK_BTN}
    Check session in calendar change to text    ${session_info.session_name}
    Capture page screenshot


Verify an Live Video Broadcasts is created within the hiring event (OL-T8366)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set two days event in Overview
    &{session_info} =    Set Schedule step    Live Video Broadcast
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${SESSION_NAME_IN_CARD}    ${session_info.session_name}
    Check element display on screen    ${session_info.session_name}
    Check element display on screen    ${SESSION_DETAIL_TIME}
    Verify text contain    ${SESSION_DURATION_AND_TYPE}    Live Video Broadcast
    Click at    ${FORWARD_DAY_BUTTON}
    Check element display on screen    ${EMPTY_SESSION}
    Capture page screenshot


Verify Open Interview Times works as Interview Schedule page (OL-T8363)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${SESSION_NAME_IN_CARD}    ${session_info.session_name}
    Click at    ${OPEN_INTERVIEW_TIME}
    Check element display on screen    ${ADD_CANDIDATE}
    Check element display on screen    ${DELETE_CANDIDATE}
    Add candidate to session
    Check element display on screen    ${CHECKIN_BUTTON}
    Capture page screenshot


Verify Schedule page when clicking on event session with in-person type (OL-T8369)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${SESSION_NAME_IN_CARD}    ${session_info.session_name}
    Verify text contain    ${SESSION_DURATION_AND_TYPE}    15 Minute In-Person Interviews
    Check element display on screen    ${SESSION_DETAIL_TIME}
    Capture page screenshot


Verify Schedule page when clicking on event session with virtual type (OL-T8368)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    &{session_info} =    Set Schedule step    Live Video Broadcast
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${SESSION_NAME_IN_CARD}    ${session_info.session_name}
    Verify text contain    ${SESSION_DURATION_AND_TYPE}    Live Video Broadcast
    Check element display on screen    ${SESSION_DETAIL_TIME}
    Check element display on screen    ${VIRTUAL_SESSION_JOIN_BUTTON}
    Check element display on screen    ${VIRTUAL_SESSION_PASSWORD}
    Capture page screenshot


Verify Schedule page when clicking on interview session (OL-T8360, OL-T8358, OL-T8359)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    ${SESSION_NAME_IN_CARD}    ${session_info.session_name}
    Check session in calendar change to time
    Check element display on screen    ${SESSION_DETAIL_TIME}
    Check element display on screen    ${CANDIDATES_SCHEDULED}
    Click at    ${SESSION_CARD_BACK_BTN}
    Check session in calendar change to text    ${session_info.session_name}
    Capture page screenshot


Verify session card per interview type shows on Schedule page (OL-T8361)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to Full user role
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Set session schedule    Scheduled Interviews
    Set session interview type    Virtual meeting
    click save session button
    Set session schedule    Scheduled Interviews
    Set session interview type    Group interview
    click save session button
    Set session schedule    Scheduled Interviews
    Set session interview type    Phone interview
    click save session button
    Set Registration step    None    None
    Set landing page
    Click create event button
    Click at    ${VIEW_SCHEDULE_BTN}
    Check element display on screen    virtual meetings
    Check element display on screen    phone interviews
    Check element display on screen    group interviews
    Click at    phone interviews
    Click at    ${OPEN_INTERVIEW_TIME}
    Add candidate to session
    Check element display on screen    Join the Interview
    Capture page screenshot


Verify 'Join Chat Booth' button only shows on Dashboard of event that has Virtual Chat Booth created (OL-T8357)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Check element not display on screen  Join Chat Booth
    Capture page screenshot


Verify Chat pill shows on virtual Hiring Events that has a Virtual Chat Booth created (OL-T8352)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Check element display on screen    ${VIRTUAL_TAG_PILL}
    Check element display on screen    ${CHAT_TAG_PILL}
    Capture page screenshot


Verify event is created within an event template (OL-T8351)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Check element display on screen  ${first_schedule_card_in_event_dash_board}
    Capture page screenshot


Verify Schedule card shows on Dashboard when Virtual Chat Booth is created (OL-T8353)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step
    Set Tools step
    Check element display on screen  ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}  ${session_info.session_name}
    Check element display on screen  ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}  Virtual Chat Booth
    Capture page screenshot


Verify the ‘At Set Time’ close registration setting still works normally to hiring events (OL-T8341)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Creating the event    Hiring Event    Virtual    Single Event    Virtual Chat Booth    24 hours before event    None
    when go to event register page
    when Verify display text   ${EVENT_STATUS_DISABLED}    Registration Has Concluded
    Capture page screenshot


Verify 'View Interview Schedule' button is removed on Interview card (OL-T8349)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Check element not display on screen    View Interview Schedule
    Capture page screenshot


Verify Interview card on dashboard when there is no Interview session created (OL-T8348)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Set Schedule step    Event Session
    Set Registration step    None    None
    Set Tools step
    Check element not display on screen    ${EVENT_INTERVIEWS_CARD}
    Capture page screenshot


Verify Schedule card shows Event Session on Dashboard - Event homepage (OL-T8346)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Event Session
    Set Registration step
    Set Tools step
    Check element display on screen  ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}  ${session_info.session_name}
    Check element display on screen  ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}  Event Session
    Capture page screenshot


Verify Schedule card shows Interview Session on Dashboard - Event homepage (OL-T8345)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step
    Set Tools step
    Check element display on screen  ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}  ${session_info.session_name}
    Check element display on screen  ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}  Scheduled Interviews
    Capture page screenshot


Verify Schedule card shows Virtual Event Sessions & Live Video Broadcasts on Dashboard - Event homepage (OL-T8347)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    &{session_info} =    Set Schedule step    Live Video Broadcast
    Set Registration step    None    None
    Set Tools step
    Check element display on screen    ${session_info.session_name}
    Check element display on screen    ${session_info.session_type}
    Check element display on screen    ${session_info.start_time}
    Check element display on screen    ${session_info.end_time}
    Check element display on screen    Join Session
    Check element display on screen    Password
    Capture page screenshot


Verify the ‘After Number of Candidates Registered’ setting works correctly to hiring events overall (OL-T8340)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Creating the event    Hiring Event    Virtual    Single Event    Virtual Chat Booth    None    1
    when Complete register the event    None    ${CONST_PHONE_NUMBER}
    when Verify display text   ${EVENT_STATUS_DISABLED}    Registration Has Concluded
    Capture page screenshot


Verify Virtual Chat Booth shows on event landing page (OL-T8342)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Creating the event    Hiring Event    Virtual    Single Event    Virtual Chat Booth    None    None
    when go to event register page
    Then Check element display on screen    ${VIRTUAL_CHAT_BOOTH_LABEL}
    Capture page screenshot


Verify creation of Event Session on Schedule slideout (OL-T8331)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    set session schedule    Event Session
    set event description    ${TEXT_OVER_320}
    click on session created and navigate to session detail
    check description has 320 characters
    Capture page screenshot


Verify creation of Scheduled Interview on Schedule modal (OL-T8333)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    set session schedule    Scheduled Interviews
    Then Check element display on screen    Create Interview Session
    Capture page screenshot


Verify creation of Virtual Interview Session on Schedule modal (OL-T8334)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    set session schedule    Virtual Scheduled Interviews
    Check element display on screen    ${SESSION_NAME_TEXTBOX}
    Check element display on screen    ${EVENT_INTERVIEW_TYPE_DROPDOWN}
    Then Check element display on screen    Create Virtual Interview Session
    Capture page screenshot


Verify the ‘After Number of Candidates Registered’ setting within the Close Registration section shows to hiring events in event builder (OL-T8339)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    set session schedule    Virtual Chat Booth
    click save session button
    and click on next button event modal
    Select conversation for Event
    Check element display on screen    ${NUMBER_OF_CANDIDATES_DROPDOWN}
    and Click at    ${BACK_TO_EVENTS}
    and Click at    ${EVENT_CREATOR_PAGE_DISCARD_BUTTON}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    set session schedule    Event Session
    click save session button
    and click on next button event modal
    Select conversation for Event
    Check element display on screen    ${NUMBER_OF_CANDIDATES_DROPDOWN}
    Capture page screenshot


Verify user edits Virtual Interview Session of old event (OL-T8335)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Set Tools step
    Click at  ${SETTING_ICON}
    Click at  ${EDIT_EVENT}
    Click at    ${SCHEDULE_STEP_LABEL}
    Click on session created and navigate to session detail
    Capture page screenshot


Verify user is not be able to drag and drop on the calendar after already created Virtual Chat Booth session (OL-T8338)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    set session schedule    Virtual Chat Booth
    click save session button
    then check span display    At this time, only one Virtual Chat Booth can be created per event.
    Capture page screenshot


Verify the builder process for that interaction type is auto directed when only one interaction type set for Virtual type (OL-T8330)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    set session schedule    Virtual Scheduled Interviews
    click save session button
    Drag & drop over a time on calendar on second block
    Then check Disable the creation of Virtual Chat Booths
    Capture page screenshot


Verify creating event with In-Person venue type (OL-T8322)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Then Check element display on screen    ${VENUE_LOCATION_TEXTBOX}
    Then Check element display on screen    ${VENUE_NAME_TEXTBOX}
    Then Check element display on screen    Internal Event Name is the same as Public Event Name
    Then Check element display on screen    Hiring Event
    Then Check element display on screen    In-person
    Capture page screenshot


Verify creating event with Virtual venue type (OL-T8323)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Then Check element display on screen    Internal Event Name is the same as Public Event Name
    Then Check element display on screen    Hiring Event
    Then Check element display on screen    Virtual
    Capture page screenshot


Verify event is created within an event template (OL-T8321)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Event Templates
    # Depend on Template, Overview step can be the same as In Person or Virtual
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Schedule step   Event Session
    Set Tools step
    Capture page screenshot


Verify event type when there is no event template (OL-T8320)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to Events page
    click on Create New Event button
    Check element not display on screen  Event Templates
    Capture page screenshot


Verify Interaction Type slideout is not Oliva Assist (OL-T8328)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Drag & drop over a time on calendar block
    Check element display on screen  Please select a session interaction type that you would like to create. Once your session is
    Check element display on screen  created, the interaction type can not be changed.
    Capture page screenshot


Verify step names are updated for all event types (except for Campus Activity) (OL-T8326)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Then the event creation is the same as the user creating a General Hiring Event with an Event Venue of
    ...    Campus Activity
    When Click at    ${BACK_TO_EVENTS}
    And Go to create Event modal
    And Click at    ${CAMPUS_ACTIVITY}
    And Click at    ${CREATE_ACTIVITY}
    Then Check element display on screen    ${ACTIVITY_DETAILS}
    Then Check element display on screen    ${MY_ACTIVITY_TEAM}
    Then Check element display on screen    ${ACTIVITY_PLANNING}
    Then Check element display on screen    ${SCHOOL_DROPDOWN}
    Then Check element display on screen    Start Time
    Then Check element display on screen    End Time
    Then Check element display on screen    Time Zone
    Then Check element display on screen    Start Date
    Then Check element display on screen    End Date
    Capture page screenshot


Verify the builder process for that interaction type is auto directed when only one interaction type set for In-Person type (OL-T8327)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Drag & drop over a time on calendar block
    Then Check element display on screen    ${SCHEDULED_INTERVIEWS_LABEL}
    Capture page screenshot


Verify the builder process for that interaction type is auto directed when only one interaction type set for Virtual type (OL-T8329)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Drag & drop over a time on calendar block
    Then Check element display on screen    ${VT_INTERVIEW_SCHEDULE}
    Capture page screenshot


Verify updating of Step title applies to Orientation Event (OL-T8325)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Then Check element display on screen    ${INTERNAL_EVENT_NAME_FIELDS}
    Then the event creation is the same as the user creating a General Hiring Event with an Event Venue of    Orientation
    Capture page screenshot


Verify Event setting shows when Hiring Events toggle is ON (OL-T8310)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Click at    ${VENUE_TYPES}
    then Check element display on screen    ${IN_PERSON_HIRING_EVENTS}
    and Check element display on screen    ${VIRTUAL_HIRING_EVENTS}
    when Click at    ${APPLY_BUTTON_VENUE_TYPES}
    and Click at    ${IN_PERSON_EVENTS_INTERACTION_TYPES_DROPDOWN}
    Then Check element display on screen    ${EVENT_SESSIONS}
    And Check element display on screen    ${SCHEDULED_INTERVIEWS}
    when Click at    ${APPLY_BUTTON_INTERACTED_IN_PERSON_TYPE}
    and Click at    ${VIRTUAL_EVENTS_INTERACTION_TYPES_DROPDOWN}
    then Check element display on screen    ${LIVE_VIDEO_BROADCASTS_CHECKBOX}
    and Check element display on screen    ${VIRTUAL_CHAT_BOOTHS_CHECKBOX}
    and Check element display on screen    ${VIRTUAL_SCHEDULED_INTERVIEWS_CHECKBOX}
    Capture page screenshot


Verify Event setting when only General Hiring Event toggle is ON (OL-T8314)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Click at    ${VENUE_TYPES}
    when Check the checkbox    ${IN_PERSON_HIRING_EVENTS}
    when Uncheck the checkbox    ${VIRTUAL_HIRING_EVENTS}
    when Click at    ${APPLY_BUTTON_VENUE_TYPES}
    Then Check Venue Type has In Person Hiring Events option is displayed
    when Click at    ${IN_PERSON_EVENTS_INTERACTION_TYPES_DROPDOWN}
    Then Check element display on screen    ${EVENT_SESSIONS}   Venue Type
    And Check element display on screen    ${SCHEDULED_INTERVIEWS}
    Capture page screenshot


Verify Event setting when only Virtual Hiring Event toggle is ON (OL-T8315)
    Turned ON only Virtual HIring Event toggle
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Click at    ${VENUE_TYPES}
    when Check the checkbox    ${VIRTUAL_HIRING_EVENTS}
    when Uncheck the checkbox    ${IN_PERSON_HIRING_EVENTS}
    when Click at    ${APPLY_BUTTON_VENUE_TYPES}
    Then Check Venue Type has Virtual option is displayed
    And Check Interaction Types has Virtual Chat Booth is displayed
    Capture page screenshot


Verify Event Venue modal is added after user selects event type when creating event builder (OL-T8318, OL-T8319, OL-T8317)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    click on Create New Event button
    Then Check element display on screen    ${CHOOSE_YOUR_EVENT_TYPE}
    when Click at    ${HIRING_EVENT_BUTTON_MODAL_CREATE_EVENT}
    Then Check element display on screen    ${CREATE_A_MOBILE_MESSAGE}
    when Click at    ${NEXT_BUTTON}
    Click on p text    In Person
    Check element display on screen  Create time slots for either in-person or virtual interviews and pre-schedule candidates before the event or live at the event.
    Check element display on screen  Create either in-person or virtual event sessions that candidates can be registered for.
    Click on p text    Virtual
    Check element display on screen  Create virtual event sessions that candidates can be registered for.
    Check element display on screen  Create virtual chat booths to chat virtually with all registered candidates at one time.
    Capture page screenshot


Verify old General/Virtual Hiring Event setting when both General Hiring Event and Virtual HIring Event toggles ON on a company (OL-T8313)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Click at    ${VENUE_TYPES}
    when Check the checkbox    ${IN_PERSON_HIRING_EVENTS}
    when Check the checkbox    ${VIRTUAL_HIRING_EVENTS}
    when Click at    ${APPLY_BUTTON_VENUE_TYPES}
    Then Check All options of Interaction Types are selected
    Capture page screenshot


Verify update changes on Event Type modal when creating event builder (OL-T8316)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    click on Create New Event button
    Then Check element display on screen    ${CHOOSE_YOUR_EVENT_TYPE}
    when Hover at    ${EVENT_TYPE_MODAL}    Event Type modal
    Then Check element display on screen    ${HIRING_EVENT_BUTTON_MODAL_CREATE_EVENT}
    when Click at    ${HIRING_EVENT_BUTTON_MODAL_CREATE_EVENT}
    Then Check element display on screen    ${CREATE_A_MOBILE_MESSAGE}
    And Check element display on screen    ${INCLUDES_CREATE_A_CUSTOM_SCHEDULE}
    And Check element display on screen    ${INCLUDE_TIE_A_REGISTRATION}
    Capture page screenshot


Verify only 2 toggles appear when Event toggle is ON (OL-T8309)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    then Check element display on screen    ${HIRING_EVENTS_TOGGLE}
    Capture page screenshot
