*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/recorded_interview_builder_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/message_customize_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    stg_mchire    test    unilever

Documentation       Navigate to Client setup page > turn on Olivia Recorded Interview toggle

*** Variables ***

*** Test Cases ***
Verify Add new field in Client Setup to allow Paradox Admins to customize expiration times for Recorded Interviews (OL-T20289, OL-T20290)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Click on strong text      Scheduling
    Check element display on screen     How long after a recorded interview request is sent should Olivia expire the request?
    Check element display on screen     ${OLIVIA_RECORDED_INTERVIEW_DROPDOWN}
    capture page screenshot
    Scroll to element     ${ENABLE_PARADOX_VIDEO_IN_ALL_INBOXES_TOGGLE}
    Click at    ${OLIVIA_RECORDED_INTERVIEW_DROPDOWN}
    @{list_value_to_recorded}=      Create list    Never    30 Minutes   1 Hour    2 Hours    1 Day    2 Days
    FOR     ${value}    IN      @{list_value_to_recorded}
        check element display on screen     ${OLIVIA_RECORDED_INTERVIEW_DROPDOWN_OPTIONS}      ${value}
    END
    Capture page screenshot


Verify User can schedule recorded interview when candidate has no any interview (OL-T20291)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    ${candidate_name}=      Create a new candidate and select a recorded interview      ${interview_record_name}
    Click View more button in email      Interview Request from      ${candidate_name}
    Upload video for Olivia Recorded Interviews     schedule-recorder
    capture page screenshot
    #Delete recorded interview after check
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}


Verify User can not schedule recorded interview when having normal interview (OL-T20292)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    ${candidate_name}=      Add a Candidate
    Open a candidate Conversation      ${candidate_name}
    Open schedule module
    Click at    ${INTERVIEW_SCHEDULE_TYPE}
    check element display on screen     ${INTERVIEWER_BUTTON}
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews     CA Team
    Send interview and click close button
    check span display      Interview Pending
    capture page screenshot
    Open a candidate Conversation   ${candidate_name}
    Click at    ${MORE_BUTTON}
    Check element not display on screen     ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    capture page screenshot


Verify button Edit interview is enabled when candidate has no answer any question (OL-T20293, OL-T20294)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    ${candidate_name}=      Create a new candidate and select a recorded interview      ${interview_record_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Verify element is enable    ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    Verify element is enable    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    capture page screenshot
    Click View more button in email      Interview Request from      ${candidate_name}
    Upload video for Olivia Recorded Interviews     schedule-recorder
    #Delete recorded interview after check
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}


Verify User can edit interview when candidate has no answer any question (OL-T20295)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    ${candidate_name}=      Create a new candidate and select a recorded interview      recorded edit
    Open a candidate Conversation      ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    Select a Recorded Interview     ${interview_record_name}
    Click View more button in email      Interview Request from      ${candidate_name}
    Upload video for Olivia Recorded Interviews     schedule-recorder
    capture page screenshot
    #Delete recorded interview after check
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}


Verify User can cancel interview when candidate has no answer any question (OL-T20296, OL-T20298)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    ${candidate_name}=      Create a new candidate and select a recorded interview      ${interview_record_name}
    Open a candidate Conversation      ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    Click at    ${CONFIRM_CANCEL_REQUEST}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    check span display      Interview Canceled
    capture page screenshot
    Verify user has received the email      cancel your recorded interview      ${candidate_name}
    capture page screenshot
    #Delete recorded interview after check
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}


Verify button Edit interview is hided when candidate has alread y started the recorded interview (OL-T20297, OL-T20301, OL-T20306, OL-T20307)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    ${candidate_name}=      Create a new candidate and select a recorded interview      ${interview_record_name}
    Click View more button in email      Interview Request from      ${candidate_name}
    Upload video for Olivia Recorded Interviews     schedule-recorder
    capture page screenshot
    go to CEM page
    Open a candidate Conversation      ${candidate_name}
    Click at    ${MORE_BUTTON}
    Check element not display on screen     ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    capture page screenshot
    #Delete recorded interview after check
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}


Verify candidate can not submit a recorded video longer than the limit (OL-T20305)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    ${candidate_name}=      Create a new candidate and select a recorded interview      ${interview_record_name}
    Click View more button in email      Interview Request from      ${candidate_name}
    Upload video for Olivia Recorded Interviews     longer-than-one-minute
    Check element display on screen     Invalid video duration!
    Upload video for Olivia Recorded Interviews     schedule-recorder
    capture page screenshot
    #Delete recorded interview after check
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}


Verify the Edit, Cancel recorded interview message will be added to Message Customization (OL-T20309, OL-T20310)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${INTERVIEW_SCHEDULING_TITLE}
    Click at    ${INTERVIEW_SCHEDULING_OPTIONS}     Olivia Recorded Interviews
    Click at    ${INTERVIEW_SCHEDULING_MEDIA_TAG}       Email
    check element display on screen     Olivia Recorded Interview Reschedule
    check element display on screen     ${INTERVIEW_SCHEDULING_EDIT_RECORDED_INTERVIEW_MESSAGE}
    check element display on screen     Olivia Recorded Interview Canceled
    check element display on screen     ${INTERVIEW_SCHEDULING_CANCEL_RECORDED_INTERVIEW_MESSAGE}
    capture page screenshot

*** Keywords ***
Select a Recorded Interview
    [Arguments]     ${recorded_interview_name}
    Click at    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_DROPDOWN}
    ${is_existed}=      run keyword and return status       check element display on screen    ${SCHEDULE_TO_OLIVIA_RECORDED_SEARCH_INTERVIEW_INPUT}    wait_time=10
    IF   '${is_existed}' == 'True'
        Input into    ${SCHEDULE_TO_OLIVIA_RECORDED_SEARCH_INTERVIEW_INPUT}     ${recorded_interview_name}
        Click at    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_DROPDOWN_OPTION}    ${recorded_interview_name}
    ELSE
        Click by JS    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_DROPDOWN_OPTION}    ${recorded_interview_name}
    END
    Click at    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_SEND_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    [Return]    ${recorded_interview_name}

Create a new candidate and select a recorded interview
    [Arguments]     ${interview_record_name}
    go to CEM page
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    Open a candidate Conversation      ${candidate_name}
    Open schedule module
    Click at    ${OLIVIA_RECORDED_INTERVIEW_BUTTON}
    Select a Recorded Interview     ${interview_record_name}
    check span display     Interview Pending
    capture page screenshot
    [Return]    ${candidate_name}
