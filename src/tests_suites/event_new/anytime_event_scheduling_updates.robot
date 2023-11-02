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
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    lts_stg    olivia    regression    stg     test

Documentation       Turn on Event -> Hiring Events on Client setup
...                 Turn on Event -> Orientation Events on Client setup

*** Variables ***
${any_time_option}          Any time
${allowance_1_time}         One time
${allowance_never}          Never
${allowance_unlimited}      Unlimited

*** Test Cases ***
Check if the candidate can Reschedule the Event interview in Hiring event when setting Any time in Reschedule Dropdown (OL-T4580, OL-T4601, OL-T4583)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling    Event Interview   ${any_time_option}
    Change reschedule Limit Canceling and Rescheduling   Event Interview   ${any_time_option}
    Set Rescheduling Candidate Allowances   ${allowance_1_time}
    ${event_name} =    Create hiring event and go to event register page    In Person   ${FS_TEAM}
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    #   Check if the candidate can Reschedule the Event interview in Hiring event when setting Any time in Reschedule Dropdown (OL-T4580)
    Input text for widget site    reschedule
    ${verify_message} =     Format String   ${EVENT_RESCHEDULE_INTERVIEW}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    ${verify_message} =     Format String   ${EVENT_OLIVIA_RESCHEDULE_TIMES_WORK}   ${candidate_info.first_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    #   Check if the candidate is not able to reschedule their event interview once when setting 1 time as the Rescheduling Candidate Allowances setting for General Hiring event (OL-T4601)
    Input text for widget site    reschedule
    ${verify_message} =     Format String   ${EVENT_RESCHEDULE_INTERVIEW}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_UNABLE_TO_RESCHEDULE}
    #   Check if the candidate can Cancel the Event interview in Hiring event when setting Any time in Cancel Dropdown (OL-T4583)
    Input text for widget site    cancel
    ${verify_message} =     Format String   ${EVENT_CANCEL_IN_PERSON_INTERVIEW}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    ${verify_message} =     Format String   ${EVENT_HIRING_CANCELED_CONFIRM}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Capture page screenshot
    Cancel event from event list    ${event_name}


Check if the candidates can cancel their event registration when Seting Any time in Cancel Dropdown of Virtual hiring event (OL-T4586)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling    Virtual Chat Booth   ${any_time_option}
    ${event_name} =    Create hiring event and go to event register page    Virtual     ${EN_TEAM}
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_REGISTER_SUCCESSFULLY}  first_name=${candidate_info.first_name}    company_name=${COMPANY_COMMON}   event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_OUR_TEAM_WAIT_FOR_MEETING_YOU}
    Input text for widget site    cancel
    ${verify_message} =     Format String   ${EVENT_CANCEL_VIRTUAL_SESSION}   ${candidate_info.full_name}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    ${verify_message} =     Format String   ${EVENT_VIRTUAL_CANCELED_CONFIRM}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Check if the candidate is able to reschedule their event interview with another event no matter how setting on Rescheduling Candidate Allowances for the Hiring Event (OL-T4603)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    ${event_name} =    Create hiring event and go to event register page    In Person   ${FS_TEAM}
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    Confirm register to event     ${candidate_info}    ${event_name}    ${COMPANY_COMMON}
    #   Create another event to schedule
    ${event_name_2} =    Create hiring event and go to event register page    In Person     ${EN_TEAM}
    #   Register with existent information
    Candidate register to another event     ${candidate_info}    ${event_name_2}        ${COMPANY_COMMON}
    Cancel event from event list    ${event_name}
    Cancel event from event list    ${event_name_2}


Check the candidate is able to reschedule their event interview whenever if setting Unlimited as the Rescheduling Candidate Allowances setting for Hiring event (OL-T4602)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Turn on     ${CUSTOMIZE_SCHEDULING_TIME_LINE_TOGGLE}
    Set Rescheduling Candidate Allowances   ${allowance_unlimited}
    ${event_name} =    Create hiring event and go to event register page    In Person   ${FS_TEAM}
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_EVENT}       ${event_name}
    Confirm register to event     ${candidate_info}    ${event_name}    ${COMPANY_EVENT}
    # Reschedule 1 times
    Candidate reschedule event      ${candidate_info}    ${event_name}    ${COMPANY_EVENT}
    # Reschedule 2 times
    Candidate reschedule event      ${candidate_info}    ${event_name}    ${COMPANY_EVENT}
    # Reschedule 3 times
    Candidate reschedule event      ${candidate_info}    ${event_name}    ${COMPANY_EVENT}
    Cancel event from event list    ${event_name}


Check if the candidate can be scheduled to event when user set the No Restriction as minium (OL-T4567, OL-T4589, OL-T4598, OL-T4592)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling    Orientation   ${any_time_option}
    Change reschedule Limit Canceling and Rescheduling   Orientation   ${any_time_option}
    Set Rescheduling Candidate Allowances   ${allowance_1_time}     Orientation
    Set Manage Scheduling Timelines     No Restriction      No Restriction
    ${event_name} =     Create a future single virtual orientation event   ${EE_TEAM}   2
    Go to CEM page
    Switch to user      ${FS_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Schedule orientation event
    #   OL-T4567
    Click button in email    Your Orientation at ${COMPANY_COMMON}       Hi ${first_name}!      CONFIRM_ORIENTATION_EVENT       2
    #   Check if the candidate can Reschedule their event registration when setting Any time in Reschedule dropdown of the Orientation event (OL-T4589)
    Candidate rechedule an orientation event via email    ${first_name}   ${COMPANY_COMMON}
    #   Check if the candidate is not able to reschedule their orientation registration once when setting 1time as the Rescheduling Candidate Allowances setting for Orientation event (OL-T4598)
    Candidate can not rerechedule an orientation event in landing site
    #   Check if the candidate can Cancel their event registration when setting Any time in Cancel dropdown of the Orientation event (OL-T4592)
    Candidate can cancel orientation event


Check if the candidate is able to reschedule their orientation registration anywhen once when setting Unlimited as the Rescheduling Candidate Allowances setting for Orientation event (OL-T4599)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Set Rescheduling Candidate Allowances   ${allowance_unlimited}     Orientation
    ${event_name} =     Create a future single virtual orientation event   ${EE_TEAM}   2
    Go to CEM page
    Switch to user      ${FS_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Schedule orientation event
    Click button in email    Your Orientation at ${COMPANY_EVENT}       Hi ${first_name}!      CONFIRM_ORIENTATION_EVENT       2
    # Reschedule 1 times
    Candidate rechedule an orientation event via email    ${first_name}   ${COMPANY_EVENT}
    # Reschedule 2 times
    Candidate rechedule an orientation event in landing site   ${first_name}   ${COMPANY_EVENT}
    # Reschedule 3 times
    Candidate rechedule an orientation event in landing site   ${first_name}   ${COMPANY_EVENT}


Check if the candidate receives the event list which has start date is between 1 hour and 3 days when setting 1 hour as minium and 3 days as maximum (OL-T4569)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Set Manage Scheduling Timelines     1 Hour      3 Days
    ${event_name} =     Create a future single virtual orientation event   ${EE_TEAM}   2
    ${event_name_2} =     Create a future single virtual orientation event   ${EE_TEAM}     2
    ${event_name_3} =     Create a future single virtual orientation event   ${EE_TEAM}     4
    Go to CEM page
    Switch to user      ${FS_TEAM}
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


Verify the candidate can reschedule orientation via email (OL-T10172)
    [Tags]      olivia    regression    stg     skip
    # Cover bug: https://paradoxai.atlassian.net/browse/OL-67536
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_CVS_EVENT}
    ${event_name} =     Create a future single virtual orientation event   ${CA_TEAM}   2
    # Edit event setting to unlimited candidates to schedule/reschedule
    Go to edit event page from dashboard
    Setting number of candidates can schedule and reschedule per event      Unlimited
    Set tool step and create event
    # Add candidate, schedule then reschedule
    Go to CEM page
    Switch to user      ${CA_TEAM}
    FOR     ${number_of_candidate}  IN RANGE    10
        ${candidate_name} =    Add a Candidate     is_spam_email=False
        ${first_name} =     get_first_name      ${candidate_name}
        CEM schedule interview type     ${candidate_name}       Orientation Event
        Select orientation event    ${event_name}
        Schedule orientation event
        Click button in email    Your Orientation at ${COMPANY_CVS_EVENT}       Hi ${first_name}!      CONFIRM_ORIENTATION_EVENT       2
        Candidate rechedule an orientation event via email for CVS Event company    ${first_name}
        Go to CEM page
    END
    Switch to user      ${TEAM_USER}
    Cancel or delete event from event list    ${event_name}

*** Keywords ***
Create hiring event and go to event register page
    [Arguments]     ${event_type}   ${interviewer}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    ${event_type}
    ${event_name} =    Set Overview step with future time    ${event_type}    Single Event
    IF      '${event_type}' == 'Virtual'
        Set Schedule step    Virtual Chat Booth
    ELSE
        Set Team step        ${interviewer}
        Set session schedule with interviewer   Scheduled Interviews    ${interviewer}  None    3 Interview Time Slots
    END
    Set Registration step    None    None       ${EVENT_SCHEDULING_UPDATES_CONVERSATION}
    Set Tools step
    Go to event register page
    [Return]    ${event_name}

Candidate reschedule event
    [Arguments]     ${candidate_info}      ${event_name}    ${company_name}
    Input text for widget site    reschedule
    ${verify_message} =     Format String   ${EVENT_RESCHEDULE_INTERVIEW}   ${company_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    ${verify_message} =     Format String   ${EVENT_OLIVIA_RESCHEDULE_TIMES_WORK}   ${candidate_info.first_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${company_name}   ${event_name}
    Check message widget site response correct    ${verify_message}

Candidate register to another event
    [Arguments]     ${candidate_info}      ${event_name}    ${company_name}
    Click at    ${REGISTER_EVENT}
    Check element display on screen    ${REGISTER_EVENT_IN_PROGRESS}
    ${verify_message} =     Format String   ${EVENT_NAME_QUESTION}  company_name=${company_name}   event_name=${event_name}
    Check message widget site response correct   ${verify_message}
    Input text for widget site    ${candidate_info.full_name}
    ${verify_message} =     Format String   ${EVENT_MOBILE_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    Input text for widget site    ${CONST_PHONE_NUMBER}
    ${verify_message} =     Format String   ${EVENT_EMAIL_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    Input text for widget site    ${candidate_info.email}
    Check message widget site response correct    ${ASK_AGE}
    Input text for widget site    30
    Click on option in conversation    Email Only
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${company_name}   ${event_name}
    Check message widget site response correct    ${verify_message}

Confirm register to event
    [Arguments]     ${candidate_info}      ${event_name}    ${company_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${company_name}   ${event_name}
    Check message widget site response correct    ${verify_message}

Candidate rechedule an orientation event via email for CVS Event company
    [Arguments]    ${first_name}
    Click at    Yes
    Check element not display on screen     Action confirmation     wait_time=5s
    # Check if reschedule success, if not pick time and reschedule
    ${is_rescheduled}=  Run keyword and return status       Check element display on screen     ${EVENT_ORIENTATION_RESCHEDULED_MESSAGE}    wait_time=2s
    IF  '${is_rescheduled}' == 'False'
        Verify Olivia conversation message display    ${EVENT_ORIENTATION_RESCHEDULE}
        Candidate input to landing site    yes
        Verify Olivia conversation message display    ${EVENT_ORIENTATION_REGISTRATION_RESCHEDULE}
        Candidate input to landing site    1
        wait for page load successfully
        ${verify_message} =     Format String   ${CVS_EVENT_ORIENTATION_RESCHEDULE_CONFIRM}   ${first_name}
        Verify Olivia conversation message display    ${verify_message}
    END
    Capture page screenshot

    