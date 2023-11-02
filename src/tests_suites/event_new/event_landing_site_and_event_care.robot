*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/web_management_page.robot
Variables           ../../constants/ConversationConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    dev2    stg   olivia  birddoghr   advantage  aramark     lts_stg     fedex   fedexstg    test

Documentation       Turn on Campus -> Campus Planning on Client setup
...                 Turn on Event -> Hiring Events on Client setup
...                 Create conv Event Registration (Single Path) with name: auto event landing site

*** Variables ***
${job_requisition_id_1}     PAT047
${EVENT_QUESTION}           Hello! I'm Olivia,
${OUTCOME_MESSAGE}          The event will be held at Southern Methodist University
${upcoming_site_name}       Upcoming Event Site
${event_landing_site}       Event Landing Page
${conv_event}               auto event landing site

*** Test Cases ***
Verify updated UI of the Event Landing Site in Tool step (OL-T10794)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${LANDING_PAGE}
    Check element display on screen   ${CANDIDATE_CARE_TOGGLE_STATUS_ON}
    Check element display on screen      Description of your event
    Check element display on screen      Header image
    Check element display on screen      Upload Image
    Check element display on screen   Event Landing Page Schedule
    Capture page screenshot
    Click at   Select Sessions
    Check element display on screen      Select the sessions to display on the event landing page
    Capture page screenshot


Verify the ‘Registeration In Progress’ card will appear within the meta-data card when the candidate starts conversation (OL-T10796, OL-T10795)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Create event for landing site
    Go to event register page
    Click at    ${EVENT_STATUS}     slow_down=2s
    wait element visible   ${SHADOW_DOM_EVENT_WIDGET_CONVERSATION_LAYOUT}
    check message widget site response correct      ${EVENT_QUESTION}
    Capture page screenshot
    Finish register the event    None    ${CONST_PHONE_NUMBER}
    Capture page screenshot


Verify candidates register to event normally when the Candidate Care toggle OFF by chatting on web (OL-T10799)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step       Virtual Chat Booth
    Set Registration step    None    None       ${conv_event}
    Set Team step    ${CA_TEAM}
    Set Tools step have candidate care off
    Go to event register page
    ${candidate_name}=     Finish register the event    None    ${CONST_PHONE_NUMBER}
    Go to CEM page
    Click on candidate name    ${candidate_name}
    Check element display on screen    ${CANDIDATE_JOURNEY_STATUS}    Capture Complete
    Capture page screenshot


Verify candidates register to event normally when the Candidate Care toggle ON by chatting on web (OL-T10798)
    #TODO maintain
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Create event for landing site
    Go to event register page
    ${candidate_fname}=     Finish register the event    None    ${CONST_PHONE_NUMBER}
    Go to CEM page
    Click on candidate name    ${candidate_name}
    ${candidate_status} =    format string    ${CANDIDATE_JOURNEY_STATUS}    Capture Complete
    Check element display on screen    ${candidate_status}
    Capture page screenshot


Verify the candidate can ask Care questions after the conversation ended when the Care toggle is ON in Event Landing site tool (OL-T10797)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Create event for landing site
    Go to event register page
    ${candidate_fname}=     Finish register the event    None    ${CONST_PHONE_NUMBER}
    Input text for widget site    I'm lost. Where do I go?
    check message widget site response correct       ${OUTCOME_MESSAGE}
    Capture page screenshot


Event Landing Page – Alert that recommends user to create a customized landing page is removed from card (OL-T926, OL-T923)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=   Set Overview step    Virtual    Single Event
    Set Schedule step       Virtual Chat Booth
    Set Team step    ${CA_TEAM}
    Set Registration step    None    None     ${conv_event}
    # Check recommends user to create a customized landing page is removed
    Click at    ${TOOLS_STEP_LABEL}
    Check text display      Create a custom event landing page to advertise your event.
    Check element not display on screen     ${ALERT_RECOMMEND_EVENT_LANDING_PAGE}
    # Check Event Landing Page Links section is removed
    Click at    ${LANDING_PAGE}
    Check element not display on screen     ${EVENT_LANDING_PAGE_LINKS_SECTION}
    Capture page screenshot


Event Landing Page – Event Landing Page Links section is removed when opening an created a Hiring event (OL-T927)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Create event for landing site
    # Check Event Landing Page Links section is removed
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${LANDING_PAGE}
    Check element not display on screen     ${EVENT_LANDING_PAGE_LINKS_SECTION}
    Capture page screenshot


Event Landing Page – Event Landing Page card displays in Event Home when a Hiring event created (OL-T931)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Create event for landing site
    # Verify Event Landing Page card displays is correct on Event Dashboard
    Check element display on screen     ${ENGAGEMENT_LANDING_CARD}      ${event_landing_site}
    Check element display on screen     ${ICON_EVENT_SOURCE}        Event Landing Page
    ${is_blue_link} =   Get element color     ${EVENT_LANDING_PAGE_URL}     color
    Should be equal as strings    ${is_blue_link}    True
    Check element display on screen     ${EVENT_COPY_LONG_LINKS_BUTTON}     Event Landing Page
    Capture page screenshot


Event Landing Page – Upcoming Event Site displays in Event Home when an upcoming event site created in Web Management (OL-T932, OL-T933)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Create event for landing site
    # Verify Upcoming Event Site does not display in Dashboard when there is no upcoming event site created in Web Management
    Check element not display on screen     ${ICON_EVENT_SOURCE}        ${upcoming_site_name}
    Check element not display on screen     ${EVENT_COPY_LONG_LINKS_BUTTON}     ${upcoming_site_name}
    Capture page screenshot
    # Verify Upcoming Event Site does is display in Dashboard when upcoming event site created in Web Management
    check and create landing site/widget site   Upcoming Event Site     ${upcoming_site_name}
    Go to Events page
    Search event      ${event_name}
    Click at        ${event_name}
    Check element display on screen     ${ENGAGEMENT_LANDING_CARD}      ${upcoming_site_name}
    Check element display on screen     ${ICON_EVENT_SOURCE}        ${upcoming_site_name}
    ${is_blue_link} =   Get element color     ${EVENT_UPCOMING_SITE_URL}     color
    Should be equal as strings    ${is_blue_link}    True
    Check element display on screen     ${EVENT_COPY_LONG_LINKS_BUTTON}     ${upcoming_site_name}
    Capture page screenshot
    # Check copy button works normally
    Click at    ${EVENT_COPY_LONG_LINKS_BUTTON}     ${upcoming_site_name}
    Check element display on screen     ${TOASTED_MESSAGE_SUCCESS}
    # Check upcoming event site link works normally
    Go to upcoming event site
    Capture page screenshot
    # Delete upcoming event site
    Go to Web Management
    Search and delete landing site      ${upcoming_site_name}

*** Keywords ***
Set Tools step have candidate care off
    Set landing page candidate care off
    Wait with medium time
    Click create event button

Set landing page candidate care off
    Click at    ${TOOLS_STEP_LABEL}
    Wait with short time
    ${is_landing_page_visible} =    Run Keyword And Return Status    Check element display on screen    ${LANDING_PAGE}
    IF    '${is_landing_page_visible}' == 'True'
        Click at    ${LANDING_PAGE}
        Input into    ${DESCRIPTION_LADING_PAGE}    hello Landing page
        ${path_image} =    get_path_upload_image_path    cat-kute
        ${element} =    Get Webelement    ${INPUT_UPLOAD_FILE}
        EXECUTE JAVASCRIPT
        ...    arguments[0].setAttribute('class', '');
        ...    ARGUMENTS    ${element}
        Input into    ${INPUT_UPLOAD_FILE}    ${path_image}
        wait until element is enabled    ${ADD_IMAGE_CONFIRM_BUTTON}
        Click at    ${ADD_IMAGE_CONFIRM_BUTTON}
        Wait with medium time
        Turn off    ${EVENT_CANDIDATE_CARE_TOGGLE}
        Wait with medium time
        Click at    ${SAVE_LANDING_PAGE}
    END

Create event for landing site
    ${event_name}=   Set Overview step    Virtual    Single Event
    Set Schedule step       Virtual Chat Booth
    Set Team step    ${CA_TEAM}
    Set Registration step    None    None       ${conv_event}
    Set Tools step
    [Return]    ${event_name}
