*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/event_templates_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/users_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${event_template_group}     Orientation_template_group
${orientation}              Orientation
${internal_event_name}      Internal Event Name is the same as Public Event Name
${user_name}                Full User - SEM only Automation
${timezone}                 (UTC-07:00) US/Pacific - PDT

*** Test Cases ***
Verify users can create an Orientation template (OL-T4676, OL-T4678)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Create event template group    ${event_template_group}
    Go to event template group    ${event_template_group}
    Click create event template with type    Orientation
    ${event_template_name} =    Generate random name    orientation_template
    Input into    ${PUBLIC_TEMPLATE_NAME_TEXTBOX}    ${event_template_name}
    Set event template venue    Virtual
    Publish event template
    Go to event template group    ${event_template_group}
    Check element display on screen    ${event_template_name}
    Go to Events page
    click on Create New Event button
    Set Event type    Event Templates
    Select event templates    ${event_template_name}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Set tool step and create event
    Event created successfully    ${event_name}
    # Delete template after create event
    Go to Event Templates page
    Go to event template group    ${event_template_group}
    Delete event template    ${event_template_group}


Verify users can create an Orientation with a Blank Event (OL-T4677, OL-T4680)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Schedule step    None    In Person
    Set tool step and create event
    Event created successfully    ${event_name}


Check UI of Overview tab in Orientation builder when Candidate Store Location Available toggle is OFF in Client Setup (OL-T4681)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    Orientation overview tab displays
    Click on span text    ${internal_event_name}
    Set Event Venue Type in dropdown    In Person
    Set event occurrence    Single Event
    Orientation overview tab displays with full components


Verify UI of Overview tab when Candidate Store Location is selected as the Event Venue (OL-T4682)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Turn ON Candidate Store Location Available
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    Set Event Venue Type in dropdown    Candidate Store Location
    element should be disabled    ${CANDIDATE_VENUE_LOCATION_TEXTBOX}
    element should be disabled    ${CANDIDATE_VENUE_NAME_TEXTBOX}
    Go to Client setup page
    Turn OFF Candidate Store Location Available


Check showing banner when a user edits Start and End date time of the Orientation Event which is out of the created sessions (OL-T4764)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step
    Set tool step and create event
    Event created successfully    ${event_name}
    Go to edit event    ${event_name}
    Choose next day for start date
    Edit Event warning popup is displayed


Verify the default timezone of the event when a user creates an event (OL-T4783)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Select user timezone    ${user_name}    ${timezone}
    Switch to user    ${user_name}
    Go to Events page
    click on Create New Event button
    Set Event type    ${orientation}
    click on create event button
    Set event occurrence    Single Event
    ${event_timezone} =    get value    ${EVENT_TIMEZONE_DROPDOWN_VALUE}
    Should be equal as strings    ${timezone}    ${event_timezone}

*** Keywords ***
Orientation overview tab displays
    Check element display on screen    Overview
    Check element display on screen    ${EVENT_NAME_INPUT}
    Check span display    Internal Event Name is the same as Public Event Name
    Check element display on screen    ${EVENT_VENUE_DROPDOWN}
    Check element display on screen    ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}

Orientation overview tab displays with full components
    Check element display on screen    ${INTERNAL_EVENT_NAME_INPUT}
    Check element display on screen    ${VENUE_LOCATION_TEXTBOX}
    Check element display on screen    ${VENUE_NAME_TEXTBOX}
    Check span display    A single event happens once and can last multiple days.
    Check element display on screen    ${EVENT_START_DATE}
    Check element display on screen    ${EVENT_START_TIME}
    Check element display on screen    ${EVENT_END_DATE}
    Check element display on screen    ${EVENT_END_TIME}
    Check element display on screen    ${EVENT_TIMEZONE_DROPDOWN}
