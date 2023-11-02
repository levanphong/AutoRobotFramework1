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
Default Tags        advantage    aramark    birddoghr    lts_stg    olivia    regresstion    stg    test

Documentation       Turn on Event -> Hiring Events on Client setup
...                 Turn on Event -> Orientation Events on Client setup

*** Variables ***
@{timeline_min_option}              No Restriction    1 Hour    2 Hours    3 Hours    6 Hours    12 Hours
...                                 1 Day    2 Days    3 Days    4 Days    5 Days    6 Days    7 Days    8 Days
@{timeline_max_option}              No Restriction    1 Day    3 Days    5 Days    1 Week
...                                 2 Weeks    3 Weeks    4 Weeks    6 Weeks    8 Weeks
${wait_until_24_hours_before}       Until 24 hours before
${is_spam_email}                    True
@{sched_expired_request_option}     Never    4 Days    1 Week    2 Weeks    3 Weeks    1 Month
@{cancelling_scheduling_option}     Any time    Until 1 hour before    Until 2 hours before    Until 3 hours before    Until 4 hours before    Until 5 hours before    Until 6 hours before    Until 7 hours before
...                                 Until 8 hours before    Until 9 hours before    Until 10 hours before    Until 11 hours before    Until 12 hours before    Until 13 hours before    Until 14 hours before
...                                 Until 15 hours before    Until 16 hours before    Until 17 hours before    Until 18 hours before    Until 19 hours before    Until 20 hours before    Until 21 hours before
...                                 Until 22 hours before    Until 23 hours before    Until 24 hours before    Until 48 hours before    Never
@{sched_reschedule_allowance}       Never    One time    Two times    Three times    Unlimited
${allowance_never}                  Never

*** Test Cases ***
Check the Manage Scheduling Timelines is added into Event on Client Setup (OL-T4565, OL-T4566, OL-T4575, OL-T4578, OL-T4595)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Turn on     ${CUSTOMIZE_SCHEDULING_TIME_LINE_TOGGLE}
    And Verify timeline MIN MAX options is displayed correctly
    #    Check the Error message displays when the Minium > Maximum setting (OL-T4566)
    Verify Error message displays if Scheduling Timelines Minium > Maximum      4 Days      1 Day
    #   Check the Registration Request Expiration is added on Client Setup when the Orientation Event is selected (OL-T4575)
    Verify Registration Request Expiration option displayed correctly
    #   Check the Limit Canceling and Rescheduling displays in Client Setup when Event is toggled ON (OL-T4578)
    Verify Limit Canceling and Rescheduling displays correctly
    #   Check the Rescheduling Candidate Allowances setting displays when either General Hiring Event or Orientation event toggle ON (OL-T4595)
    Turn on     ${EVENT_SCHED_RESCHEDULE_ALLOWANCE_ON}
    Verify list item displayed correctly   ${EVENT_GENERAL_SCHED_RESCHEDULE_ALLOWANCE_SELECT}     ${EVENT_GENERAL_SCHED_RESCHEDULE_ALLOWANCE_OPTION}    @{sched_reschedule_allowance}
    Verify list item displayed correctly   ${EVENT_ORIENTATION_SCHED_RESCHEDULE_ALLOWANCE_SELECT}     ${EVENT_ORIENTATION_SCHED_RESCHEDULE_ALLOWANCE_OPTION}    @{sched_reschedule_allowance}


Check if the candidate can not Reschedule the Event interview before 24 hours in General Hiring event when setting Until 24 hours in Reschedule Dropdown (OL-T4581, OL-T4584)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling    Event Interview   ${wait_until_24_hours_before}
    Change reschedule Limit Canceling and Rescheduling   Event Interview   ${wait_until_24_hours_before}
    ${event_name} =     Given new hiring event and go to event register page     In Person
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
    #   Check if the candidate can not Cancel the Event interview before 24 hours in Hiring event when setting Until 24 hours in Cancel Dropdown (OL-T4584)
    Input text for widget site    cancel
    ${verify_message} =     Format String   ${EVENT_CANCEL_IN_PERSON_INTERVIEW}   ${COMPANY_COMMON}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_UNABLE_TO_CANCEL_INTERVIEW}
    Capture page screenshot
    Cancel event from event list    ${event_name}


Check if the candidates can not cancel their event registration when Seting Until 24 hours in Cancel Dropdown of Virtual Chat Booth event (OL-T4587)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling   Virtual Chat Booth   ${wait_until_24_hours_before}
    ${event_name} =     Given new hiring event and go to event register page     Virtual
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


Check the Registration Request Expired is added into the Event Stages within Candidate Journeys (OL-T4573)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Candidate Journeys page
    Click a Journey     ${EVENT_SCHEDULING_UPDATES_CANDIDATE_JOURNEY}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Orientation Event
    Click at    Registration Request Expired
    Check span display      The candidate should be moved into this status when a candidate does not select an event within the selected registration expire period
    Capture page screenshot


Check the Rescheduling Candidate Allowances messages are added into the Message Customization (OL-T4596, OL-T4574, OL-T4579)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    #   Check the Rescheduling Candidate Allowances messages are added into the Message Customization (OL-T4596)
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Candidate Initiates Reschedule
    Check element display on screen     ${HIRING_EVENT_NO_AVAILABILITY_TO_SCHEDULE}     ${MES_CUS_EVENT_HIRING_UNABLE_TO_RESCHEDULE}
    Check element display on screen     ${ORIENTATION_NO_AVAILABILITY_TO_SCHEDULE}     ${MES_CUS_EVENT_ORIENTATION_UNABLE_TO_RESCHEDULE}
    Capture page screenshot
    #   Check the Limit canceling and rescheduling message are added into Message customization of Event (OL-T4579)
    Click at    Candidate Initiates Cancellation
    ${locator} =    Format String       ${AI_EVENT_MESSAGING}   Hiring Events   No Availability to Cancel   ${MES_CUS_EVENT_HIRING_UNABLE_TO_CANCEL}
    Check element display on screen     ${locator}
    ${locator} =    Format String       ${AI_EVENT_MESSAGING}   Hiring Events - Virtual Chat Booth Only   No Availability to Cancel   ${MES_CUS_EVENT_UNABLE_TO_CANCEL}
    Check element display on screen     ${locator}
    ${locator} =    Format String       ${AI_EVENT_MESSAGING}   Orientation Events   No Availability to Cancel   ${MES_CUS_EVENT_UNABLE_TO_CANCEL}
    Check element display on screen     ${locator}
    Capture page screenshot
    #   Check the msg for Registration Request Expired is added into the Message Customization (OL-T4574)
    Click at    Scheduling Request Expired
    Check element display on screen     ${PENDING_ORIENTATION_REQUEST_EXPIRED}      ${MES_CUS_EVENT_NO_LONGER_ABLE_TO_SCHEDULE}
    Capture page screenshot


Check if the candidate is not able to reschedule the event interview when setting Never as the Rescheduling Candidate Allowances setting for Hiring event (OL-T4600)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Set Rescheduling Candidate Allowances   ${allowance_never}
    ${event_name} =     Given new hiring event and go to event register page     In Person
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${COMPANY_COMMON}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Candidate can not reschedule hiring event   ${COMPANY_COMMON}
    Cancel event from event list    ${event_name}


Check if the candidate can not Reschedule their event registration when setting Until 24hours in Reschedule dropdown of the Orientation event (OL-T4590, OL-T4593)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Change cancel Limit Canceling and Rescheduling    Orientation   ${wait_until_24_hours_before}
    Change reschedule Limit Canceling and Rescheduling   Orientation   ${wait_until_24_hours_before}
    Set Manage Scheduling Timelines     No Restriction      No Restriction
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${FS_TEAM}
    Go to CEM page
    Switch to user      ${FS_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Schedule orientation event
    Click button in email    Your Orientation at ${COMPANY_COMMON}       Hi ${first_name}!      CONFIRM_ORIENTATION_EVENT       2
    Candidate can not rechedule an orientation event
    #   Check if the candidate can not Cancel their event registration when setting Until 24hours in Cancel dropdown of the Orientation event (OL-T4593)
    Candidate can not cancel orientation event
    # TODO Remove comment to delete event after bug fixed https://paradoxai.atlassian.net/browse/OL-80431
    # Go to Events page
    # Switch to user      ${TEAM_USER}
    # Cancel event from event list    ${event_name}


Check if the candidate is not able to reschedule their orientation registration when setting Never as the Rescheduling Candidate Allowances setting for Orientation event (OL-T4597)
    Given Setup test
    When Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Client setup page
    Click at    ${EVENTS_LABEL}
    Set Rescheduling Candidate Allowances   ${allowance_never}      Orientation
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${FS_TEAM}
    Go to CEM page
    Switch to user      ${FS_TEAM}
    ${candidate_name} =    Add a Candidate     group_name=${EVENT_SCHEDULING_UPDATES_GROUP_NAME}     is_spam_email=False
    ${first_name} =     get_first_name      ${candidate_name}
    CEM schedule interview type     ${candidate_name}       Orientation Event
    Select orientation event    ${event_name}
    Schedule orientation event
    Click button in email    Your Orientation at ${COMPANY_COMMON}       Hi ${first_name}!      CONFIRM_ORIENTATION_EVENT       2
    Candidate can not rechedule an orientation event
    # TODO Remove comment to delete event after bug fixedhttps://paradoxai.atlassian.net/browse/OL-80431
    # Go to Events page
    # Switch to user      ${TEAM_USER}
    # Cancel event from event list    ${event_name}

*** Keywords ***
Verify timeline MIN MAX options is displayed correctly
    Verify list item displayed correctly   ${EVENT_ORIENTATION_TIMELINE_MIN}     ${EVENT_ORIENTATION_TIMELINE_MIN_OPTION}   @{timeline_min_option}
    Verify list item displayed correctly   ${EVENT_ORIENTATION_TIMELINE_MAX}     ${EVENT_ORIENTATION_TIMELINE_MAX_OPTION}   @{timeline_max_option}

Verify Error message displays if Scheduling Timelines Minium > Maximum
    [Arguments]     ${min}  ${max}
    Click at    ${EVENT_ORIENTATION_TIMELINE_MIN}
    Click at    ${EVENT_ORIENTATION_TIMELINE_MIN_OPTION}    ${min}
    Click at    ${EVENT_ORIENTATION_TIMELINE_MAX}
    Click at    ${EVENT_ORIENTATION_TIMELINE_MAX_OPTION}    ${max}
    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    Check text display    Scheduling Timelines Orientation Event Maximum must occur after the Minimum
    Capture page screenshot

Given new hiring event and go to event register page
    [Arguments]     ${event_type}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    ${event_type}
    ${event_name} =    Set Overview step    ${event_type}    Single Event
    IF      '${event_type}' == 'Virtual'
        Set Schedule step    Virtual Chat Booth
    ELSE
        Set Schedule step    Scheduled Interviews
    END
    Set Registration step    None    None       ${EVENT_SCHEDULING_UPDATES_CONVERSATION}
    Set Tools step
    Go to event register page
    [Return]    ${event_name}

Verify Registration Request Expiration option displayed correctly
    Verify list item displayed correctly   ${EVENT_SCHED_EXPIRED_REQUEST}     ${EVENT_SCHED_EXPIRED_REQUEST_OPTION}    @{sched_expired_request_option}

Verify Limit Canceling and Rescheduling displays correctly
    Check element display on screen     ${EVENT_GENERAL_EVENT_SCHED_LABEL}
    Check element display on screen     ${EVENT_VIRTUAL_EVENT_SCHED_LABEL}
    Check element display on screen     ${EVENT_ORIENTATION_EVENT_SCHED_LABEL}
    #   Hiring reschedule
    Verify list item displayed correctly   ${EVENT_GENERAL_EVENT_SCHED_RESCHEDULE}     ${EVENT_GENERAL_EVENT_SCHED_RESCHEDULE_OPTION}     @{cancelling_scheduling_option}
    #   Hiring Cancel
    Verify list item displayed correctly   ${EVENT_GENERAL_EVENT_SCHED_CANCEL}     ${EVENT_GENERAL_EVENT_SCHED_CANCEL_OPTION}     @{cancelling_scheduling_option}
    #   Hiring Virtual
    Verify list item displayed correctly   ${EVENT_VIRTUAL_EVENT_SCHED_CANCEL}     ${EVENT_VIRTUAL_EVENT_SCHED_CANCEL_OPTION}     @{cancelling_scheduling_option}
    #   Orientation Cancel
    Verify list item displayed correctly   ${EVENT_ORIENTATION_EVENT_SCHED_CANCEL}     ${EVENT_ORIENTATION_EVENT_SCHED_CANCEL_OPTION}     @{cancelling_scheduling_option}
    #   Orientation Reschedule
    Verify list item displayed correctly   ${EVENT_ORIENTATION_EVENT_SCHED_RESCHEDULE}     ${EVENT_ORIENTATION_EVENT_SCHED_RESCHEDULE_OPTION}     @{cancelling_scheduling_option}

Verify candidate register hiring event successfully
    [Arguments]     ${candidate_info}       ${event_name}       ${company_name}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${company_name}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Capture page screenshot

Candidate can not reschedule hiring event
    [Arguments]     ${company_name}
    Input text for widget site    reschedule
    ${verify_message} =     Format String   ${EVENT_RESCHEDULE_INTERVIEW}   ${company_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_UNABLE_TO_RESCHEDULE}
    Capture page screenshot

Verify list item displayed correctly
    [Arguments]     ${locator_select}      ${option_item_locator}       @{list_item}
     Click at       ${locator_select}
     FOR    ${item}     IN      @{list_item}
        Check element display on screen     ${option_item_locator}      ${item}
     END
     Capture page screenshot
     Click at       ${locator_select}
