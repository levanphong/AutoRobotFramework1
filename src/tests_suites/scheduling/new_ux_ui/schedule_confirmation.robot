*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/all_candidates_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/interview_prep_page.robot
Resource            ../../../pages/round_robin_management_page.robot
Resource            ../../../pages/my_calendar_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/message_customize_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg     lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***

*** Test Cases ***
Verify UI of confirmation modal when User scheduled single interview (OL-T15220)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add new candidate and open schedule modal
    when Choose interview type    Virtual Interview
    Choose duration time to schedule      30 min
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EN Team
    Click at    ${CHOOSE_TIME_BUTTON}
    Select a time slot on schedule modal
    capture page screenshot
    Check span display      Virtual Interview
    Check span display      30 min
    Check text display      Interview Confirmed
    capture page screenshot
    Click at   ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    wait for page load successfully
    Check span display      Interview Scheduled
    capture page screenshot
    Cancel interview    ${candidate_name}


Verify UI of confirmation modal when User send sequential interview request within In-Order (OL-T15221,OL-T15223)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}   ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Inorder1 Confirmation      Inorder2 Confirmation
    Select Determine Scheduling Approach     Consecutive In-Order
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Click at    ${FIND_TIMES_BUTTON}
    Check information display on schedule module    Interview 1     Interview 2     Interview Pending
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    check span display      Interview Pending
    capture page screenshot
    Click button in email      would like to schedule      ${candidate_name}    SEQUENTIAL_INTERVIEW    1
    Select time slot options
    wait with medium time
    Verify user has received the email      Your sequential interview at    ${candidate_name}   SEQUENTIAL_UPDATE


Verify UI of confirmation modal when User scheduled sequential interview (OL-T15222)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Inorder1 Confirmation      Inorder2 Confirmation
    capture page screenshot
    Click at    ${CHOOSE_TIME_BUTTON}
    Select a time slot on schedule modal
    Click at   ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    wait for page load successfully
    Check span display      Interview Scheduled
    capture page screenshot


Verify UI of confirmation modal when User rescheduled sequential interview within multiple days (OL-T15224)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Multiple1 Confirmation      Multiple2 Confirmation
    Select Determine Scheduling Approach     Schedule Over Multiple Days
    capture page screenshot
    click on positive button    Send Times Over Multiple Days
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Click View more button in email      would like to schedule      ${candidate_name}       SEQUENTIAL_INTERVIEW      index_button=0
    Then Select time for interview with multiple days
    Check element display on screen     I've informed all attendees and confirmed your interviews.
    capture page screenshot
    Reschedule a interview      ${candidate_name}

*** Keywords ***
Reschedule a interview
    [Arguments]     ${candidate_name}
    Go to CEM page
    Click on candidate name      ${candidate_name}
    wait for page load successfully
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    capture page screenshot

Check information display on schedule module
    [Arguments]     ${name_interview_1}     ${name_interview_2}     ${status_schedule}
    Check text display      ${name_interview_1}
    Check text display      ${name_interview_2}
    Check text display      ${status_schedule}
    capture page screenshot
