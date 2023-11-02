*** Settings ***
Library             ../../utils/StringHandler.py
Resource            ../../pages/event_page.robot
Resource            ../../pages/base_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        aramark    birddoghr    advantage    dev2 lts_stg    olivia    regression    stg       test

*** Test Cases ***
Verify Candidate Check-In modal when zero candidates are scheduled to the event (OL-T4735, OL-T4731, OL-T4734, OL-T4732)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name} =     Set Overview step with future time    Virtual    Single Event
    Set Schedule step    None
    Set tool step and create event
    Click at    ${CHECKIN_CANDIDATES_CARD}
    #   Verify Candidate Check-In modal when zero candidates are scheduled to the event (OL-T4735)
    Check element display on screen     Zero candidates are scheduled for this event.
    Click at    ${CHECKIN_CANDIDATE_CLOSE_PANEL_BUTTON}
    Switch to user      ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    Switch to user      ${TEAM_USER}
    Go to Events page
    Search event      ${event_name}
    Click at    ${event_name}
    Click at    ${CHECKIN_CANDIDATES_CARD}
    #   Verify Candidate Check-in slide out when the event is only one day long (OL-T4732)
    Check element not display on screen     Day 1
    Check span display      Attendance
    ${candidate_count} =    get text    ${CHECKIN_CANDIDATE_COUNT}
    should contain      ${candidate_count}             /1
    #   User can search candidates in Candidate Check-In modal (OL-T4734)
    Verify user can search candidate in Candidate Check-In modal    ${candidate_name}
    #   Verify both managers & ambassadors can check-in candidates (OL-T4731)
    Verify managers and ambassadors can checkin candidate   ${candidate_name}
    Cancel event from event list    ${event_name}


Verify Viewing Candidate Mini Profile when clicking on candidate's name on Check-In Candidates (OL-T4736, OL-T4733)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type    Orientation
    ${event_name} =     Set Overview step    Virtual    Single Event
    ${next_date} =    get_date_with_month_in_full_string      2
    Click by JS    ${EVENT_END_DATE}       slow_down=1s
    Click by JS    ${EVENT_CREATE_END_DATE_PICKER}    ${next_date}
    Set Schedule step    None
    Set tool step and create event
    Switch to user      ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    Switch to user      ${TEAM_USER}
    Go to Events page
    Search event      ${event_name}
    Click at     ${event_name}
    Click at     ${CHECKIN_CANDIDATES_CARD}
    #   Verify Candidate Check-in slide out when the event is multiple days long (OL-T4733)
    Verify Candidate Check-in slide out when the event is multiple days long    ${candidate_name}
    #   Verify Viewing Candidate Mini Profile when clicking on candidate's name on Check-In Candidates (OL-T4736)
    Viewing Candidate Mini Profile      ${candidate_name}       ${event_name}
    Cancel event from event list    ${event_name}

*** Keywords ***
Verify managers and ambassadors can checkin candidate
    [Arguments]     ${candidate_name}
    Check element display on screen         ${CHECKIN_CANDIDATE_NAME_LIST}      ${candidate_name}
    Click at    ${CHECKIN_CANDIDATE_BY_USER_BUTTON}     ${candidate_name}
    Check element display on screen         ${CHECKIN_CANDIDATE_DONE_BY_USER_BUTTON}        ${candidate_name}

Verify user can search candidate in Candidate Check-In modal
    [Arguments]     ${candidate_name}
    Input into      ${CHECKIN_CANDIDATE_SEARCH_INPUT}       ${candidate_name}
    Check element display on screen         ${CHECKIN_CANDIDATE_NAME_LIST}      ${candidate_name}
    Input into      ${CHECKIN_CANDIDATE_SEARCH_INPUT}       No Group Assigned
    Check element display on screen         ${CHECKIN_CANDIDATE_NAME_LIST}      ${candidate_name}

Viewing Candidate Mini Profile
    [Arguments]     ${candidate_name}       ${event_name}
    ${short_name} =     get_short_name      ${candidate_name}
    Click at    ${CHECKIN_CANDIDATE_SHORTNAME_IN_LIST}     ${candidate_name}
    Check span display      Back to Candidates
    Check element display on screen     ${CHECKIN_CANDIDATE_SHORTNAME_PROFILE}      ${short_name}
    Check element display on screen     ${TAB_ORIENTATION_EVENT}
    Click at    ${PROFILE_EVENT_TAB}      Orientation
    Click at    ${CEM_EVENT_COLLAPSE_ITEM_BUTTON}     ${event_name}
    Click at    ${CEM_EVENT_CHECKIN_BUTTON}
    Click at    ${BACK_TO_CANDIDATE_BUTTON}
    Click at    Day 2
    Click at    ${CHECKIN_CANDIDATE_SHORTNAME_IN_LIST}     ${candidate_name}
    Check element display on screen     ${CHECKIN_CANDIDATE_SHORTNAME_PROFILE}      ${short_name}
    Check element display on screen     ${TAB_ORIENTATION_EVENT}

Verify Candidate Check-in slide out when the event is multiple days long
    [Arguments]     ${candidate_name}
    Click at     Day 1
    Check element display on screen         Day 1
    Check element display on screen         Day 2
    Check span display      Attendance
    ${candidate_count} =    get text    ${CHECKIN_CANDIDATE_COUNT}
    Should contain      ${candidate_count}             /1
