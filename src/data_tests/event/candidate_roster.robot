*** Settings ***
Resource        ../../drivers/driver_chrome.robot
Resource        ../../pages/workflows_page.robot
Resource        ../../pages/ratings_page.robot
Resource        ../../pages/candidate_journeys_page.robot
Resource        ../../pages/location_management_page.robot
Resource        ../../pages/workflows_page.robot
Resource        ../../pages/interviews_page.robot
Resource        ../../pages/group_management_page.robot
Resource        ../../pages/base_page.robot
Variables       ../../locators/client_setup_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${location_name}            Event Location
${rating_event}             rating_event
${cj_event_roster}          CJ_Event_Roster
${group_event}              Event_rooster_group
${workflow_send_comuni}     WF Event Send Comuni
${workflow_audience}        WF Event Switch Audience
${workflow_send_rating}     WF Event Send Rating
${location_contact}         Location Contact
${location_name}            Event Location
${subject_text}             Candidate roster send Communication
${content_text}             Send communication to user when \#candidate-name have journey status is Capture Complete

${la_location_id_single}    654321
${la_address_single}        460 Nguyen Huu Tho Street
${la_state_single}          Alabama
${la_city_single}           New York
${la_country}               US
${la_zipcode_single}        10005

*** Test Cases ***
Prepare Candidate Roster Event
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Add location data test Event Roster     ${COMPANY_EVENT}    ${location_name}
    Create a new Rating     Candidate    ${rating_event}
    Add a Candidate Journey     ${cj_event_roster}
    Add a Group   ${cj_event_roster}   None      ${group_event}
    Create workflows for Send communication
#   Create workflow Switch Audience
    Add a Workflow    ${workflow_audience}      Custom Workflow     ${cj_event_roster}      ${location_contact}
    Create workflows Send Rating to Candidate check-in and not Check-in
    Enable Client Setup for Close Check In

*** Keywords ***
Add location data test Event Roster
    [Arguments]     ${location_name}     ${company}
    Add a Location    ${location_name}      ${company}
    &{email_info} =    Get email for testing    is_spam_email=False
    Input contact information for location      ${email_info.email}

Input contact information for location
    [Arguments]     ${email_test}
    Input into    ${LOCATION_ID_TEXTBOX}    ${la_location_id_single}
    Input into    ${ADDRESS_1_TEXTBOX}    ${la_address_single}
    Input into    ${CITY_TEXTBOX}    ${la_city_single}
    Select state value    ${la_state_single}
    Input into    ${ZIPCODE_TEXTBOX}    ${la_zipcode_single}
    Input into    ${LOCATION_EMAIL_TEXTBOX}    ${email_test}
    Input into    ${LOCATION_PHONE_TEXTBOX}    ${CONST_PHONE_NUMBER}
    Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}

Enable Client Setup for Close Check In
    Navigate to    Client Setup
    Click at    ${EVENTS_LABEL}
    Turn on     ${CLIENT_SETUP_EVENT_CLOSE_CHECK_IN_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END

Create workflows for Send communication
    Add a Workflow    ${workflow_send_comuni}       Custom Workflow     ${cj_event_roster}      ${location_contact}
    wait element visible    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Add a Send communication Action into Workflow       Capture Complete    ${subject_text}     ${content_text}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}

Create workflows Send Rating to Candidate check-in and not Check-in
    Add a Workflow     ${workflow_send_rating}      Custom Workflow     ${cj_event_roster}      Candidate
    Reload page
    wait element visible    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Add a Send Rating Action into Workflow    ${rating_event}      Checked In      workflow event \#candidate-fullname
    Click at    ${SAVE_TASK_BUTTON}
    Add a Send Rating Action into Workflow    ${rating_event}      Not Checked In      workflow event \#candidate-fullname
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
