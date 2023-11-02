*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/candidate_journeys_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    lts_stg    olivia    regresstion    stg    test

Documentation       Turn on Event -> Hiring Events on Client setup
...                 Turn on Event -> Orientation Events on Client setup

*** Variables ***
${never_option}     Never

*** Test Cases ***
Check if the candidate can not Reschedule to event interview in Hiring event after Scheduled when setting Never in Reschedule dropdown (OL-T4582, OL-T4585)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling   Event Interview   ${never_option}
    Change reschedule Limit Canceling and Rescheduling   Event Interview   ${never_option}
    Go to Events page
    ${event_info} =    Create hiring event has In person type and schedule interview session
    ${event_name} =    Set variable      ${event_info.event_name}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    reschedule
    ${verify_message} =     Format String   ${EVENT_RESCHEDULE_INTERVIEW}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_UNABLE_TO_RESCHEDULE}
    #   Check if the candidate can not Cancel the Event interview in Hiring event when setting Never in Cancel Dropdown (OL-T4585)
    Input text for widget site    cancel
    ${verify_message} =     Format String   ${EVENT_CANCEL_IN_PERSON_INTERVIEW}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_UNABLE_TO_CANCEL_INTERVIEW}
    Capture page screenshot
    Cancel event from event list    ${event_name}


Check if the candidates can not cancel their event registration when Seting Never in Cancel Dropdown of Virtual hiring event (OL-T4588)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling   Virtual Chat Booth   ${never_option}
    Go to Events page
    &{event_info} =    Create hiring event has Virtual Chat Booth session
    ${event_name} =    Set variable      ${event_info.event_name}
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_REGISTER_SUCCESSFULLY}  first_name=${candidate_info.first_name}    company_name=${COMPANY_COMMON}   event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_OUR_TEAM_WAIT_FOR_MEETING_YOU}
    Input text for widget site    cancel
    ${verify_message} =     Format String   ${EVENT_CANCEL_VIRTUAL_SESSION}   ${candidate_info.full_name}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_UNABLE_TO_CANCEL_REGISTRATION}
    Capture page screenshot
    Cancel event from event list    ${event_name}


Check if the candidate can not Reschedule their event registration when setting Never in Reschedule dropdown of the Orientation event (OL-T4591, OL-T4594)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling   Orientation   ${never_option}
    Change reschedule Limit Canceling and Rescheduling   Orientation   ${never_option}
    Go to Events page
    ${event_name} =     Create a future single virtual orientation event   ${FS_TEAM}   1
    Go to CEM page
    Switch to user      ${FS_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Schedule orientation event
    Click button in email    Your Orientation at ${COMPANY_COMMON}       Hi ${first_name}!      CONFIRM_ORIENTATION_EVENT       2
    Candidate can not rechedule an orientation event
    #   Check if the candidate can not Cancel their event registration when setting Never in Cancel dropdown of the Orientation event (OL-T4594)
    Candidate can not cancel orientation event
    # TODO Remove comment to delete event after bug fixed https://paradoxai.atlassian.net/browse/OL-80431
    # Go to Events page
    # Switch to user      ${TEAM_USER}
    # Cancel event from event list    ${event_name}


Check if the candidate receives the event list which has start date is less than 24 hour when user selects 1day as minium (OL-T4568)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Set Manage Scheduling Timelines     1 Day      No Restriction
    ${event_name} =     Create a future single virtual orientation event   ${FS_TEAM}   1
    ${event_name_2} =     Create a future single virtual orientation event   ${FS_TEAM}     1
    Go to CEM page
    Switch to user      ${FS_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Select orientation event    ${event_name_2}
    Schedule orientation event
    Click button in email    Schedule your Orientation with ${COMPANY_COMMON}       Hi ${first_name}!    SCHEDULE_ORIENT_EVENT
    ${orientation_event_url} =    Get location
    Check element display on screen     ${event_name}
    Check element display on screen     ${event_name_2}
    #   Check if the candidate has No Event Availability status when all of events in Event list are nolonger available (OL-T4571)
    # TODO Remove comment to delete event after bug fixed https://paradoxai.atlassian.net/browse/OL-80431
    #    Go to Events page
    #    Switch to user      ${TEAM_USER}
    #    Search and delete event     ${event_name}
    #    Search and delete event     ${event_name_2}
    #    Go to   ${orientation_event_url}
    #    Check element display on screen     I'm sorry, It looks like there is no event to schedule right now
    #    Verify orientation event candidate journey status   ${candidate_name}   No Event Availability


Check if the candidate receives the event list which has the start date is less than 3 days when setting 3 days as the maximum (OL-T4570)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Set Manage Scheduling Timelines     No Restriction    3 Days
    ${event_name} =     Create a future single virtual orientation event   ${EE_TEAM}   1
    ${event_name_2} =     Create a future single virtual orientation event   ${EE_TEAM}     2
    ${event_name_3} =     Create a future single virtual orientation event   ${EE_TEAM}     4
    Go to CEM page
    Switch to user      ${EE_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Select orientation event    ${event_name_2}
    Input into      ${SCHEDULE_ORIENTATION_EVENT_SEARCH_INPUT}        ${event_name_3}
    Check element not display on screen      ${event_name_3}
    Schedule orientation event
    Click button in email    Schedule your Orientation with ${COMPANY_EVENT}       Hi ${first_name}!    SCHEDULE_ORIENT_EVENT
    Check element display on screen     ${event_name}
    Check element display on screen     ${event_name_2}
    Check element not display on screen     ${event_name_3}

*** Keyword ***
Verify orientation event candidate journey status
    [Arguments]     ${candidate_name}       ${status}
    Go to CEM page
    Switch to user      ${FS_TEAM}
    Click on candidate name    ${candidate_name}
    ${candidate_status} =    format string    ${CANDIDATE_JOURNEY_STATUS}    ${status}
    Check element display on screen     ${candidate_status}
    Capture page screenshot
