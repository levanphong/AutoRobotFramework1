*** Settings ***
Resource        ../../drivers/driver_chrome.robot
Resource        ../../pages/my_jobs_page.robot
Resource        ../../pages/all_candidates_schedule_page.robot
Resource        ../../pages/client_setup_page.robot
Resource        ../../pages/interview_prep_page.robot
Resource        ../../pages/my_profile_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup      Open Chrome
Default Tags    test

*** Variables ***
${location_name1}                           Da Nang
${location_name2}                           Location_schedule
${location_name3}                           New York
&{dic_users}                                user1=OL-R1240 User1    user2=OL-R1240 User2    user3=OL-R1240 User3    user4=OL-R1240 User4
@{interview_type_need_choose_location}      In-Person Interview    In-Person Meeting    In-Person Conversation    In-Person Session    Group Interview    Group Session
@{interview_type_response_held_location}    In-Person Interview    In-Person Meeting    In-Person Conversation    In-Person Session
${subject_schedule_interview_mail}          Olivia from Test Automation - Event
${contain_schedule_interview_mail}          Hi {}! I'm Olivia, the virtual scheduling assistant for Test Automation - Event. I'm here to help you schedule your 20 minute phone interview.

*** Test Cases ***
Verify interview request is sent success in case interview type is "Phone Interview | Phone Meeting | Phone Conversation | Phone Session | Virtual Interview | Virtual Meeting | Virtual Conversation | Virtual Session | In-Person Interview | In-Person Meeting | In-Person Conversation | In-Person Session | Group Interview | Group Session" when User clicks on "Schedule" button, (OL-T20910, OL-T20911, OL-T20912, OL-T20913, OL-T20914, OL-T20915, OL-T20916, OL-T20917, OL-T20919, OL-T20920, OL-T20921, OL-T20922, OL-T20923, OL-T20924)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user      ${dic_users.user1}
    ${interview_type_list} =    Create List     Phone Interview     Phone Meeting       Virtual Interview       Virtual Meeting     In-Person Interview     In-Person Meeting       Phone Conversation      Phone Session       Virtual Conversation    Virtual Session     In-Person Conversation      In-Person Session       Group Interview     Group Session

    FOR    ${interview_type}    IN    @{interview_type_list}
        ${candidate_first_name} =       Add a Candidate
        Click on candidate name     ${candidate_first_name}
        Open schedule module
        Click at    ${INTERVIEW_BUTTON}
        Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}     slow_down=1s
        Click at    ${INTERVIEW_TYPE_PATTERN}       ${interview_type}       slow_down=1s
        Choose duration time to schedule    20 min
        Run Keyword If      '${interview_type}' in ${interview_type_need_choose_location}       Choose location     ${location_name1}
        Click at    ${ADD_INTERVIEWERS_BUTTON}
        Select interviewers for sub-interviews      ${dic_users.user1}
        Check element display on screen     ${INTERVIEWER_ADDED_PATTERN}    ${dic_users.user1}
        Capture Page Screenshot
        Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Schedule
        Click at    ${CLOSE_SCHEDULE_BUTTON}
        Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_EVENT}    ${interview_type}
    END


Verify send interview request success with custom interview type when User click button "Schedule" (OL-T20918)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${interview_type_full_name} =       Add new interview type      Phone Interview
    Switch to user      ${dic_users.user1}
    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Click at    ${INTERVIEW_BUTTON}
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}     slow_down=1s
    Click at    ${INTERVIEW_TYPE_PATTERN}       ${interview_type_full_name}     slow_down=1s
    Choose duration time to schedule    20 min
    Click at    ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${dic_users.user1}
    Check element display on screen     ${INTERVIEWER_ADDED_PATTERN}    ${dic_users.user1}
    Capture Page Screenshot
    Click at    ${SCHEDULE_INTERVIEW_SCHEDULE_BUTTON}
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_EVENT}    ${interview_type_full_name}     is_custom=True
    Switch to user      ${TEAM_USER}
    go to Client setup page
    Delete a interview type     ${interview_type_full_name}


Verify send interview request success with type interview is "Sequential" and Determine Scheduling Approach is ("Consecutive In-Order" | "Consecutive Any Order" | "Schedule Over Multiple Days") (OL-T20925, OL-T20927, OL-T20928)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Switch to user      ${dic_users.user1}
    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Select info for 2 sub-interview     20 min      ${dic_users.user1}      ${dic_users.user2}      Phone Interview     Virtual Interview
    Select Determine Scheduling Approach    Consecutive In-Order
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Send In-Order Times
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}    sequential interview    duration=40 minute

    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Select info for 2 sub-interview     20 min      ${dic_users.user1}      ${dic_users.user2}      Phone Interview     Virtual Interview
    Select Determine Scheduling Approach    Consecutive Any Order
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Send Times in Any Order
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}    sequential interview    duration=40 minute

    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Select info for 2 sub-interview     20 min      ${dic_users.user1}      ${dic_users.user2}      Phone Interview     Virtual Interview
    Select Determine Scheduling Approach    Schedule Over Multiple Days
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Send Times Over Multiple Days
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}    sequential interview    duration=40 minute      DSA=Schedule Over Multiple Days


Verify send interview request success with type interview is "Sequential" when Advanced Scheduling Settings toggle OFF (OL-T20926)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch to user      ${dic_users.user1}
    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Select info for 2 sub-interview     20 min      ${dic_users.user1}      ${dic_users.user2}      Phone Interview     Virtual Interview
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Let Olivia Schedule
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_HIRE_OFF}     sequential interview    duration=40 minute


Verify send interview request success when User click button "Schedule" in case add "Prep & Intructions" at CEM (OL-T20929)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user      ${dic_users.user1}
    ${interview_type} =     Set Variable    Phone Interview
    go to Interview Prep page
    ${candidate_prep_name} =    Add a new Interview Prep    Candidates
    go to Interview Prep page
    ${interviewer_prep_name} =      Add a new Interview Prep    Users
    Go to CEM page
    ${candidate_first_name} =       Add a candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Click at    ${INTERVIEW_BUTTON}
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}     slow_down=1s
    Click at    ${INTERVIEW_TYPE_PATTERN}       ${interview_type}       slow_down=1s
    Choose duration time to schedule    20 min
    Click at    ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${dic_users.user1}
    Add interview prep for interview      ${candidate_prep_name}      ${interviewer_prep_name}
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Schedule
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_EVENT}    ${interview_type}       duration=20 minute


Verify send interview request success when User click button "Let Olivia Schedule" (OL-T20931)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch to user      ${dic_users.user1}
    ${interview_type} =     Set Variable    Virtual Interview
    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}     slow_down=1s
    Click at    ${INTERVIEW_TYPE_PATTERN}       ${interview_type}       slow_down=1s
    Choose duration time to schedule    20 min
    Click at    ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${dic_users.user1}
    Check element display on screen     ${INTERVIEWER_ADDED_PATTERN}    ${dic_users.user1}
    Capture Page Screenshot
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Let Olivia Schedule
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_HIRE_OFF}     ${interview_type}


Verify send interview request success when User click "Choose Time" and select at least 2 slot times to send request (OL-T20932)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch to user      ${dic_users.user1}
    ${interview_type} =     Set Variable    Virtual Interview
    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    Open schedule module
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}     slow_down=1s
    Click at    ${INTERVIEW_TYPE_PATTERN}       ${interview_type}       slow_down=1s
    Choose duration time to schedule    20 min
    Click at    ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${dic_users.user1}
    Check element display on screen     ${INTERVIEWER_ADDED_PATTERN}    ${dic_users.user1}
    ${choosed_times_arr} =      Choose time interview       2
    Click at    ${CLOSE_SCHEDULE_BUTTON}
    Verify send interview request successfully      ${candidate_first_name}     ${COMPANY_HIRE_OFF}     ${interview_type}       choosed_times_arr=${choosed_times_arr}


Verify no interview request is sent when user clicks “Cancel” button on “Schedule an Interview” modal, Verify error message is displayed when "Interview Details" is missing required fields., Verify warning message will display when Interviewers have no availability time. (OL-T20933, OL-T20934, OL-T20935)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user      ${dic_users.user1}
    ${interview_type} =     Set Variable    Virtual Interview
    ${candidate_first_name} =       Add a Candidate
    Click on candidate name     ${candidate_first_name}
    # Verify no interview request is sent when user clicks “Cancel” button on “Schedule an Interview” modal
    Open schedule module
    Click at    ${INTERVIEW_BUTTON}
    Choose duration time to schedule    20 min
    Click at    ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${dic_users.user1}
    Click at    ${SCHEDULE_CANCEL_BUTTON}
    Click at    ${SCHEDULE_MODULE_EXIT_BUTTON}
    Check element not display on screen     requested a virtual interview
    Capture Page Screenshot
    # Verify error message is displayed when "Interview Details" is missing required fields
    Open schedule module
    Click at    ${INTERVIEW_BUTTON}
    Choose duration time to schedule    20 min
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Schedule
    Hover at    ${SCHEDULE_AN_INTERVIEW_WARNING_ICON}
    Check element display on screen     ${SCHEDULE_AN_INTERVIEW_MISSING_REQUIRED_INFO}
    Capture Page Screenshot
    # Verify warning message will display when Interviewers have no availability time.
    Click at    ${SCHEDULE_CANCEL_BUTTON}
    Click at    ${SCHEDULE_MODULE_EXIT_BUTTON}
    Open schedule module
    Click at    ${INTERVIEW_BUTTON}
    Choose duration time to schedule    20 min
    Click at    ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${dic_users.user3}
    Click at    ${SCHEDULE_INTERVIEW_PATTERN_SCHEDULE_BUTTON}       Schedule
    Check element display on screen     The interview could not be scheduled.
    Check element display on screen     Add open interview times for OL-R1240.
    Capture Page Screenshot

*** Keywords ***
Verify send interview request successfully
    [Arguments]    ${candidate_first_name}    ${company_name}    ${interview_type}    ${held_at_location}=${EMPTY}    ${site}=${EMPTY}    ${is_custom}=False    ${duration}=20 minute    ${DSA}=Send In-Order Times    ${choosed_times_arr}=None   ${timezone_name}=MST (AZ)
    IF    '${interview_type}' in ${interview_type_response_held_location}
        ${held_at_location} =    Set Variable    ${SPACE}which will be held at 460 Nguyen Huu Tho, Da Nang, Cam Le, 55000
    END
    IF    ${is_custom} == False
        ${interview_type} =    Convert To Lower Case    ${interview_type}
    END
    IF    '${company_name}' != '${COMPANY_EVENT}' and '${company_name}' != '${COMPANY_HIRE_OFF}'
        ${site} =    Set Variable    ${SPACE}Site
    END
    ${expected_message_interview_request} =    Format String    Hi {}! I'm Olivia, the virtual scheduling assistant for {}{}. I'm here to help you schedule your {} {}{}.    ${candidate_first_name}    ${company_name}    ${site}    ${duration}    ${interview_type}    ${held_at_location}
    IF    '${DSA}' == 'Schedule Over Multiple Days'
        ${expected_message_interview_request} =    Format String    Hi {}! I'm Olivia, the virtual scheduling assistant for {}{}. I'm here to help you schedule your interview that will occur in a few sections over a few days.    ${candidate_first_name}    ${company_name}    ${site}
        Check element display on screen    Click on this link to select your interview times:
    ELSE
        Check element display on screen    Do any of these times work?
    END
    Run Keyword If    "${choosed_times_arr}" != "None"    Verify date time schedule option request correctly    ${choosed_times_arr}
    Check element display on screen    ${expected_message_interview_request}
    Check element display on screen    \#calendar-link
    Capture Page Screenshot

Verify date time schedule option request correctly
    [Arguments]    ${choosed_times_arr}=None   ${timezone_name}=MST (AZ)
    ${msg} =    format_date_times_schedule_option_message    ${choosed_times_arr}    ${timezone_name}
    ${showed_msg} =    Get text and format text    ${CONVERSATION_OLIVIA_OPTION_TIME_WORKS_MESSAGE}
    Should Be Equal As Strings    ${msg}    ${showed_msg}
    Capture Page Screenshot
