*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${TEXT_OVER_320}    Time spent reading that encourages bonding between parent and child we your child like reading book With a rich library, easy-to-use app, and data insights,    for home provides rich benefits to families, producing long lasting Reading to and with children is an intimate experience that gives parents and caregivers the opportunity

*** Test Cases ***
Verify creating event with Virtual venue type (OL-T8323)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to create Event modal
    when Click at    ${NEXT_BUTTON}
    when Click at    ${VIRTUAL_VENUE_TYPE}
    click on create event button
    Then Check element display on screen    ${VENUE_LOCATION_FIELDS}
    Then Check element display on screen    ${VENUE_NAME_FIELDS}
    Then Check element display on screen    ${INTERNAL_EVENT_NAME_FIELDS}
    Then the event creation is the same as the user creating a General Hiring Event with an Event Venue of    Virtual
    Then Check element display on screen    ${HIRING_EVENT_TITLE_LEFT_HEADER}
    Then check the event venue as subtext under the Title    Virtual


Verify creating event template with Virtual/In-Person venue type (OL-T8324)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to create Event modal
    when Click at    ${EVENT_TEMPLATE_MODAL_CREATE_EVENT}
    when click on first template event
    And Check element display on screen    ${EVENT_CREATION_TYPE}


Verify creation of Live Video Broadcast on Schedule slideout (OL-T8332,OL-T8335)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to schedule tab with event type    Hiring Event    Virtual    Single Event
    set session schedule    Live Video Broadcast
    check label display    Broadcast Name
    check label display    Video Broadcast URL
    check label display    Video Broadcast URL Password (Optional)
    check label display    Video Broadcast Description
    set event description    ${TEXT_OVER_320}
    click on session created and navigate to session detail
    check description has 320 characters


Verify user backs to the calendar view when clicking Cancel button on Schedule slideout (OL-T8336)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to schedule tab with event type    Hiring Event    Virtual    Single Event
    set session schedule    Virtual Scheduled Interviews
    Click at    ${CANCEL_BUTTON_ON_SESSION_DIALOG}
    Check element display on screen    ${DIALOG_SESSION}
    Check element display on screen    Schedule
    Check element display on screen    ${CALENDAR_HEADER}


Verify multiple upcoming interview sessions that have the same start time show on Schedule card (OL-T8351)
    Given Setup test
    when Login into system    ${PARADOX_ADMIN}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info} =    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Check element display on screen    ${session_info.start_time}


Verify creation of Live Video Broadcast on Schedule slideout (OL-T8337)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to schedule tab with event type    Hiring Event    Virtual    Single Event
    set session schedule    Virtual Chat Booth
    check label display    Booth Name
    check label display    Booth Description
    Check element display on screen    ${START_TIME}
    Check element display on screen    ${END_TIME}
    set event description    ${TEXT_OVER_320}
    click on session created and navigate to session detail
    check description has 320 characters


Verify Schedule page when clicking on Virtual Chat Booth (OL-T8372)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Then Login successfully
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Click at    ${IN_PERSON_EVENTS_INTERACTION_TYPES_DROPDOWN}
    Check the checkbox    ${EVENT_SESSIONS}
    Then Check element display on screen    ${EVENT_SESSIONS} Venue Type
    go to events page
    Create Virtual Event has Virtual Chat Booth and no add description session
    Go to Schedule tab in event homepage
    Click at    ${VIRTUAL_CHAT_BOOTH_RIGHT_HAND_SIDE}
    then check There is no description showed in session info


Verify copy updates 'Virtual Hiring Events' changes to 'Hiring Event: Virtual Chat Booth’ (OL-T8378)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Then Login successfully
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    then Check element display on screen    Hiring Events
    when Click at    ${VIRTUAL_EVENTS_INTERACTION_TYPES_DROPDOWN}
    then Check element display on screen    Virtual Chat Booths checkbox    is displayed


Verify copy updates 'General Hiring Events' changes to 'Hiring Events' (OL-T8377)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Then Login successfully
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    then Check element display on screen    Hiring Events


Verify title of General HIring Event message for Candidate notification updates to 'Hiring Events' (OL-T8381)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    and Go to Message Customize
    and Click at    ${EVENTS_TAB}
    and Click at    ${CANDIDATE_TAB_ON_DIALOG}
    and Click at    Initial Request
    then Check element display on screen    Hiring Events title    is displayed


Verify title of Virtual HIring Event message for Candidate notification updates to 'Hiring Events - Virtual Chat Booth Only' (OL-T8382)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    and Go to Message Customize
    and Click at    ${EVENTS_TAB}
    and Click at    ${CANDIDATE_TAB_ON_DIALOG}
    and Click at    Candidate Initiates Cancellation
    then Check element display on screen    Virtual Chat Booth Only title    is displayed


Verify title of General HIring Event/ Virtual Hiring Event message for User notification updates to 'Hiring Events' (OL-T8383)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    and Go to Message Customize
    and Click at    ${EVENTS_TAB}
    and Click at    ${USER_TAB}
    then Check element display on screen    Hiring Events title    is displayed


Verify user scrolls interview session on Schedule page (OL-T8362)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    in_person_scheduled_interviews_test
    Scroll to last candidate in schedule card
    Verify display text   ${SESSION_CARD_TITLE}    in_person_scheduled_interviews_test


Verify there is no forward/back arrows when event has one day long (OL-T8365)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Check element not display on screen    Forward day button
    Check element not display on screen    Backward day button


Verify Schedule page when clicking on event session (OL-T8367)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    Set Schedule step    Event Session
    Set Registration step    None    None
    Set Tools step
    Click at    ${VIEW_SCHEDULE_BTN}
    Click at    event_session_test
    Check element display on screen    event_session_test
    Verify text contain    ${SESSION_DURATION_AND_TYPE}    Virtual Event Session
    Check element display on screen    Session detail time
    Check element display on screen    Virtual session join button
    Check element display on screen    Virtual session password
