*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${company_test}     P Test
${report_name}      list_page_1

*** Test Cases ***
Check UI of Recurring tab in Event List (OL-T4216)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Click at    ${RECURRING_EVENTS_TAB}
    then Check list show correctly with recurrings
    and Check element display on screen    ${NAME_LIST}
    and Check element display on screen    ${SEARCHING_INPUT}
    and Check element display on screen    ${THE_NUMBER_OF_OCCURRENCES}
    Click at    ${AN_RECURRING_EVENT_CARD}
    and Check list show correct with Event Occurrences
    [Teardown]    Close Browser


Verify directing to Edit Recurring Event page when clicking on Edit Recurring Event in ellipses (OL-T4217)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Click at    ${RECURRING_EVENTS_TAB}
    Click at    ${AN_RECURRING_EVENT_CARD}
    Click on the ellipses icon in the Recurring Event card
    Click at    ${EDIT_RECURRING_EVENT}
    then Check navigate to Edit Recurring Event page
    [Teardown]    Close Browser


Verify directing to Event Homepage when users click on each Occurrence line (OL-T4221)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Click at    ${RECURRING_EVENTS_TAB}
    Click at    ${AN_RECURRING_EVENT_CARD}
    Click at    ${OCCURRENCE_WITHIN_RECURRING_EVENT}
    then Check navigate to the Event Homepage
    [Teardown]    Close Browser


Verify Login into Events page successfully (OL-T4246)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Check Events page is loaded
    [Teardown]    Close Browser


Check loading the Upcoming Events tab first when the user login to the Events page (OL-T4249)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Check Events page is loaded
    Check My Events tab is opened first
    Check link Upcoming Events is active
    Check list upcoming events is displayed correctly
    [Teardown]    Close Browser


Verify the displaying of tag on event cards in Upcoming tab (OL-T4230)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has Virtual Chat Booth session
    Go to Events page
    search event    ${session_info_vt.event_name}
    Check Events page is loaded
    Check Virtual tag is displayed on Hiring Events has Event Venue is Virtual
    Check Chat tag is displayed for all Virtual Chat Booth Events
    delete event    ${session_info_vt.event_name}
    &{session_info_ip} =    Create hiring event has In person type and schedule interview session
    Go to Events page
    search event    ${session_info_ip.event_name}
    Check displaying Interview tags for all events that have interview sessions created
    delete event    ${session_info_ip.event_name}
    [Teardown]    Close Browser


Check the displaying of event occurrences by grid view in Upcoming tab (OL-T4228)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has Virtual Chat Booth session
    Go to Events page
    Click at    ${GRID_VIEW_BUTTON}
    search event    ${session_info_vt.event_name}
    Check the date that the occurrence will take place with the frequency of it and the end date for the entire recurring event is displayed with light grey
    ...    ${session_info_vt.event_name}
    delete event    ${session_info_ip.event_name}
    [Teardown]    Close Browser


Check the displaying of Recurring Events by list view in Upcoming tab (OL-T4228, OL-T4218)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has In person type and schedule interview session and recurring event
    Go to Events page
    Click at    ${LIST_VIEW_BUTTON}
    search event    ${session_info_vt.event_name}
    Check the date that the occurrence will take place with the frequency of it and the end date for the entire recurring event is displayed with light grey
    ...    ${session_info_vt.event_name}
    Click on ellipses icon on the Event Occurrence row
    Check element display on screen    ${EDIT_ICON}
    Check element display on screen    ${DELETE_ICON}
    Check element display on screen    ${DUPLICATE_ICON}
    Click at    ${EDIT_ICON}
    Check element display on screen    ${EDIT_OCCURRENCE_SLIDE}
    go to events page
    search event    ${session_info_vt.event_name}
    Click on ellipses icon on the Event Occurrence row
    Click at    ${DELETE_ICON}
    delete occurrence action
    [Teardown]    Close Browser


Check Deleting the Event Occurrence in Recurring tab (OL-T4226)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has In person type and schedule interview session and recurring event
    Go to Events page
    Click at    ${RECURRING_EVENTS_TAB}
    search event    ${session_info_vt.event_name}
    Click at    ${AN_RECURRING_EVENT_CARD}
    Click on ellipses icon on the Event Occurrence row on recurring tab
    Click at    ${DELETE_ICON_RECURRING}
    delete recurring occurrence on card
    Delete the occurrence and close the modal    ${session_info_vt.event_name}
    [Teardown]    Close Browser


Check showing the list of occurences when users click on Recurring event in Recurring tab (OL-T4219)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has In person type and schedule interview session and recurring event
    Go to Events page
    Click at    ${RECURRING_EVENTS_TAB}
    search event    ${session_info_vt.event_name}
    Click at    ${AN_RECURRING_EVENT_CARD}
    then Check element display on screen    ${DATE_OF_OCCURRENCE}
    and Check element display on screen    ${LOCATION_OCCURRENCE}
    and Check element display on screen    ${FREQUENCY_OCCURRENCE}
    when Click on ellipses icon on row the Event Occurrence row of recurring tab
    and Check element display on screen    ${EDIT_RECURRING_EVENT}
    and Check element display on screen    ${DELETE_RECURRING_EVENT}
    [Teardown]    close browser


Check the displaying of Canceled Occurrences in Recurring tab (OL-T4224)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    &{session_info_vt} =    Create hiring event has In person type and schedule interview session and recurring event
    Click at    ${RECURRING_EVENTS_TAB}
    search event    ${session_info_vt.event_name}
    Click at    ${AN_RECURRING_EVENT_CARD}
    add new candidate from recurring tab
    Go to Events page
    Click at    ${RECURRING_EVENTS_TAB}
    search event    ${session_info_vt.event_name}
    Click at    ${AN_RECURRING_EVENT_CARD}
    Click on ellipses icon on row the Event Occurrence row of recurring tab
    then Check element display on screen    ${CANCEL_ICON_RECURRING}
    Check element display on screen    ${REMOVE_ELLIPSES_ICON}
    when Click at    ${CANCEL_ICON_RECURRING}
    and click on span text    Confirm
    and click on span text    Cancel and Send
    [Teardown]    Close Browser
