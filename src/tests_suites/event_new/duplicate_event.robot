*** Settings ***
Resource        ../../pages/event_page.robot
Resource        ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags       regression    dev2    stg   olivia  birddoghr   advantage    aramark     lts_stg    test

*** Variables ***
${planned_price}    19

*** Test Cases ***
Verify the user can duplicate a hiring event (OL-T12642)
    [Tags]    dev    fedexstg    olivia    stg
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Single Event
    Set Schedule step   Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Event created successfully      ${event_name}
    Capture page screenshot
    Search and go to event homepage     ${event_name}
    Duplicated event in homepage
    ${duplicated_name}=     generate random name    Duplicated_event_
    Input into      ${EVENT_NAME_INPUT}     ${duplicated_name}
    Set tool step and create event
    Event created successfully      ${duplicated_name}
    Capture page screenshot


Verify the user can duplicate an orientation event (OL-T12643)
    [Tags]    dev    fedexstg    olivia    stg
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    click on Create New Event button
    Set Event type    Orientation
    click on create event button
    ${event_name}=      Set Overview step      Virtual    Single Event
    Set Schedule step
    Set tool step and create event
    Event created successfully      ${event_name}
    Capture page screenshot
    Search and go to event homepage     ${event_name}
    Duplicated event in homepage
    ${duplicated_name}=     generate random name    Duplicated_event_
    Input into      ${EVENT_NAME_INPUT}     ${duplicated_name}
    Set tool step and create event
    Event created successfully      ${duplicated_name}
    Capture page screenshot


Verify the user can duplicate an activity (OL-T12644)
    [Tags]    dev    fedexstg    olivia    stg
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	${team_members}=    Create List     Full User Automation
    ${event_name}=      Create campus active event      @{team_members}
	Event created successfully      ${event_name}
	Capture page screenshot
	Search and go to event homepage     ${event_name}
	Duplicated event in homepage
	${duplicated_name}=     generate random name    Duplicated_event_
    Input into      ${INPUT_CAMPUS_NAME}     ${duplicated_name}
    Click at    ${ACTIVE_PLANING_LABEL}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Event created successfully      ${duplicated_name}
    Capture page screenshot


Verify the user can duplicate a recurring event (OL-T12645)
    [Tags]    dev    fedexstg    olivia    stg
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Search and duplicated event in event page       ${event_name}
    ${duplicated_name}=     generate random name    Duplicated_event_
    Input into      ${EVENT_NAME_INPUT}     ${duplicated_name}
    Set Summary step and create event
    Input into      ${SEARCH_EVENT_INPUT}       ${duplicated_name}
    wait for page load successfully
    Check element display on screen    ${RECURRING_EVENT_HAS_NAME}      ${duplicated_name}
    Capture page screenshot
