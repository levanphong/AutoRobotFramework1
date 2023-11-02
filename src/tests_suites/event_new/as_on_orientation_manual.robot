*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../data_tests/event/event_data_tests.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Setup          Open Chrome
Default Tags        aramark    birddoghr    darden    dev2    fedex    fedexstg    lts_stg    olivia    regression    stg

Documentation       Turn on Event -> Turn on Manual Scheduling Advanced Settings

*** Variables ***
${orientation}          Orientation
${user_name}            ${CA_TEAM}
${no_group_assigned}    No Group Assigned

*** Test Cases ***
Verify User manual schedule orientation event successfully incase Multiple Selections Made (OL-T14504)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name_1} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_2} =       Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate     is_spam_email=False
    Scheduling select orient event label
    Search and select orient event on scheduling popup      ${event_name_1}
    Search and select orient event on scheduling popup      ${event_name_2}
    Click at    ${SEND_TIMES_EVENT_SUBMIT_BUTTON}
    Check element display on screen     Orientation Pending
    Check element display on screen     ${ORIENT_SCHEDULING_ICON_COMPLETE}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_CLOSE_BUTTON}
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      ${no_group_assigned}
    Capture page screenshot
    Verify user has received the email      Schedule your Orientation with ${COMPANY_COMMON}    Hi ${candidate_first_name_random}!      SCHEDULE_ORIENT_EVENT
    Go to Events page
    Search and delete event     ${event_name_1}
    Search and delete event     ${event_name_2}


Verify Edit Detail function works correctly from Update banner incase Candidate has been sent multiple orientation times and has not yet selected an orientation. (OL-T14513)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name_1} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_2} =       Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate     is_spam_email=False
    Set scheduling orient event     ${event_name_1}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    Search and select orient event on scheduling popup      ${event_name_1}
    Search and select orient event on scheduling popup      ${event_name_2}
    Click at    ${SEND_TIMES_EVENT_SUBMIT_BUTTON}
    Check element display on screen     Orientation Pending
    Check element display on screen     ${ORIENT_SCHEDULING_ICON_COMPLETE}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_CLOSE_BUTTON}
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      ${no_group_assigned}
    Capture page screenshot
    Verify user has received the email      ${COMPANY_COMMON} needs to reschedule your orientation      Hi ${candidate_first_name_random}!      NEED_RESCHEDULE_INTERVIEW
    Go to Events page
    Search and delete event     ${event_name_1}
    Search and delete event     ${event_name_2}


Verify Orientation Events list displays matches the Scheduling timeliness when candidate asks to reschedule (OL-T14518)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate     is_spam_email=False
    Set scheduling orient event     ${event_name}
    # Click reschedule button in email
    ${shorten_url} =    Set Variable    ${CONFIG.shorten_url}
    Click button in email       Your Orientation at ${COMPANY_COMMON}       Hi ${candidate_first_name_random}!      CONFIRM_ORIENTATION_EVENT       2       ${shorten_url}
    Click at    Yes
    Verify Olivia conversation message display      ${I_UNDERSTAND_YOU_ARE}
    Candidate input to scheduling conversation      Yes
    Verify Olivia conversation message display      ${I_CAN_HELP_YOU_RESCHEDULE}
    Candidate input to scheduling conversation      1
    Verify Olivia conversation message display      Thank you ${candidate_first_name_random}!
    Capture page screenshot


Verify user allow select more than 1 orientation event to send to a candidate (OL-T14494)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name_1} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_2} =       Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at    ${SCHEDULING_ORIENTATION_EVENT_LABEL}
    Search and select orient event on scheduling popup      ${event_name_1}
    Search and select orient event on scheduling popup      ${event_name_2}
    Check span display      Send Times
    Capture page screenshot
    Click on span text      Send Times
    Check element display on screen     Event Registration Sent
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name_1}
    Search and delete event     ${event_name_2}


Verify user can not select more than 3 orientation event to send to a candidate (OL-T14495)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name_1} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_2} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_3} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_4} =       Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Scheduling select orient event label
    Capture page screenshot
    Search and select orient event on scheduling popup      ${event_name_1}
    Check element display on screen     ${CHECKBOX_SELECT_ORIENT_IS_CHECKED}    ${event_name_1}
    Search and select orient event on scheduling popup      ${event_name_2}
    Check element display on screen     ${CHECKBOX_SELECT_ORIENT_IS_CHECKED}    ${event_name_2}
    Search and select orient event on scheduling popup      ${event_name_3}
    Check element display on screen     ${CHECKBOX_SELECT_ORIENT_IS_CHECKED}    ${event_name_3}
    Search and select orient event on scheduling popup      ${event_name_4}
    Check element not display on screen     ${CHECKBOX_SELECT_ORIENT_IS_CHECKED}    ${event_name_4}     wait_time=3s
    Check element display on screen     ${SEND_TIMES_EVENT_CANCEL_BUTTON}
    Check element display on screen     ${SEND_TIMES_EVENT_SUBMIT_BUTTON}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name_1}
    Search and delete event     ${event_name_2}
    Search and delete event     ${event_name_3}
    Search and delete event     ${event_name_4}


Verify initialization display when user manual orientation event (OL-T14490)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Scheduling select orient event label
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      ${no_group_assigned}
    Check element display on screen     ${event_name}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_SUBMIT_DISABLED_BUTTON}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_CANCEL_BUTTON}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify user can search orientation event in Search box when input text matches data (OL-T14491)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name_1} =       Create orient event Virtual Single Event    ${user_name}
    Go to Events page
    ${event_name_2} =       Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Scheduling select orient event label
    Search and select orient event on scheduling popup      ${event_name_1}
    Check element display on screen     ${event_name_1}
    Search and select orient event on scheduling popup      ${event_name_2}
    Check element display on screen     ${event_name_2}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name_1}
    Search and delete event     ${event_name_2}


Verify User manual schedule orientation event successfully (OL-T14497)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Scheduling select orient event label
    Search and select orient event on scheduling popup      ${event_name}
    Click at    ${SCHEDULING_ORIENT_EVENT_SUBMIT_BUTTON}
    Check element display on screen     Orientation Scheduled
    Check element display on screen     ${ORIENT_SCHEDULING_ICON_COMPLETE}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_CLOSE_BUTTON}
    Check span display      ${event_name}
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      ${no_group_assigned}
    Capture page screenshot


Verify Display the 2 advanced settings toggles and allow user to customize the orientation events they are able to see when click Settings button (OL-T14498)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name_1} =       Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Scheduling select orient event label
    Click at    ${ORIENT_EVENT_HEADER_TOGGLE_SETTING_BUTTON}
    Check element display on screen     ${ORIENT_EVENT_REGISTRATION_BREAK_RULE_TOGGLE}
    Check element display on screen     ${ORIENT_EVENT_SCHEDULING_TIME_LINE_TOGGLE}
    Check element display on screen     ${SETTING_ORIENT_EVENT_CANCEL_BUTTON}
    Check element display on screen     ${ORIENT_EVENT_APPLY_SUBMIT_DISABLED_BUTTON}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name_1}


Verify Display when Scheduling Timelines toggle is ON (OL-T14499)
    Login into company common
    Go to CEM page
    Switch to user      ${EE_TEAM}
    Add a Candidate
    Scheduling select orient event label
    Click at    ${ORIENT_EVENT_HEADER_TOGGLE_SETTING_BUTTON}
    Click at    ${ORIENT_EVENT_SCHEDULING_TIME_LINE_TOGGLE}
    Click at    ${ORIENT_EVENT_SCHEDULING_TIME_LINE_MIN}
    Check element display on screen     ${SCHEDULING_TIME_LINE_SELECTED_VALUE}      No Restriction
    Capture page screenshot
    Click at    ${SCHEDULING_TIME_LINE_SELECTED_VALUE}      No Restriction
    Click at    ${ORIENT_EVENT_SCHEDULING_TIME_LINE_MAX}
    Check element display on screen     ${SCHEDULING_TIME_LINE_SELECTED_VALUE}      No Restriction
    Capture page screenshot
    Click at    ${SCHEDULING_TIME_LINE_SELECTED_VALUE}      No Restriction


When setting data for the minimum and maximum selectboxes, make sure the Display event is correctly (OL-T14500)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Set timeline min max    1 day       2 weeks
    Capture page screenshot
    Click at    ${ORIENT_EVENT_APPLY_SUBMIT_BUTTON}
    Check element display on screen     ${ORIENT_EVENT_SCHEDULING_OPENED_PANEL}
    Check element not display on screen     ${ORIENT_EVENT_REGISTRATION_BREAK_RULE_TOGGLE}      wait_time=3s
    Check element not display on screen     ${ORIENT_EVENT_SCHEDULING_TIME_LINE_TOGGLE}     wait_time=3s
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify display event within event has registration is closed (OL-T14501, OL-T14496)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}    12 hours before event
    Go to CEM page
    Add a Candidate
    Orient event turn on break rule toggle
    Click at    ${ORIENT_EVENT_APPLY_SUBMIT_BUTTON}
    Check element display on screen     ${ORIENT_EVENT_REGISTRATION_IS_CLOSED_TEXT}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify take user back to list of Orientation Events when click the back arrow without clicking Apply (OL-T14502)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Orient event turn on break rule toggle
    Click at    ${ORIENT_EVENT_ARROW_BACK_SETTING_ICON}
    Check element display on screen     ${ORIENT_EVENT_SCHEDULING_OPENED_PANEL}
    Check element not display on screen     ${ORIENT_EVENT_REGISTRATION_BREAK_RULE_TOGGLE}      wait_time=3s
    Check element not display on screen     ${ORIENT_EVENT_SCHEDULING_TIME_LINE_TOGGLE}     wait_time=3s
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify take user back to list of Orientation Events when click Cancel button (OL-T14503)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Orient event turn on break rule toggle
    Click at    ${SETTING_ORIENT_EVENT_CANCEL_BUTTON}
    Check element display on screen     ${ORIENT_EVENT_SCHEDULING_OPENED_PANEL}
    Check element not display on screen     ${ORIENT_EVENT_REGISTRATION_BREAK_RULE_TOGGLE}      wait_time=3s
    Check element not display on screen     ${ORIENT_EVENT_SCHEDULING_TIME_LINE_TOGGLE}     wait_time=3s
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify the Orientation event Reschedule request function works correctly when user reschedule successfully from Update banner (OL-T14510)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Set scheduling orient event     ${event_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    Reschedule
    Search and select orient event on scheduling popup      ${event_name}
    Click on span text      Reschedule Orientation
    Click by JS     ${SCHEDULING_ORIENT_EVENT_CLOSE_BUTTON}
    Check element display on screen     ${CANDIDATE_JOURNEY_STATUS}     Capture Complete
    Capture page screenshot
    Check element display on screen     ${event_name}
    Check element display on screen     ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Capture page screenshot


Verify take user back to list of Orientation Events when click Cancel button (OL-T14511, OL-T14512)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Set scheduling orient event     ${event_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    Reschedule
    Search and select orient event on scheduling popup      ${event_name}
    Capture page screenshot
    Click at    ${SCHEDULING_ORIENT_EVENT_CANCEL_BUTTON}
    Check span display      Exit Scheduling
    Click at    ${ORIENT_EVENT_NEVER_MIND_BUTTON}
    Check element not display on screen     Exit Scheduling     wait_time=3s
    Capture page screenshot
    Click at    ${SCHEDULING_ORIENT_EVENT_CANCEL_BUTTON}
    Check span display      Exit Scheduling
    Click at    ${EXIT_SCHEDULING_EXIT_BUTTON}
    Check element not display on screen     ${ORIENT_EVENT_SCHEDULING_OPENED_PANEL}     wait_time=3s
    Check element display on screen     ${CANDIDATE_JOURNEY_STATUS}     Capture Complete
    Capture page screenshot


Verify the Orientation event Cancel function works correctly from Update banner when user cancel interview successfully (OL-T14515)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Set scheduling orient event     ${event_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${SCHEDULING_SUMMARY_CANCEL_BUTTON}
    Check span display      Cancel Interview
    Check text display      Cancellation message that ${candidate_first_name_random} will receive
    Check element display on screen     ${CANCEL_MESSAGE_TEXT_AREA}
    Capture page screenshot
    Click at    ${SCHEDULING_CONFIRM_CANCEL_BUTTON}
    wait with short time
    Check text display      Orientation Canceled
    Check element display on screen     ${SCHEDULING_DETAIL_CLOSE_BUTTON}
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      ${no_group_assigned}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify the Orientation event Cancel function works correctly from Update banner when user cancel interview successfully (OL-T14516)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    Add a Candidate
    Set scheduling orient event     ${event_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${SCHEDULING_SUMMARY_CANCEL_BUTTON}
    Click at    ${ORIENT_EVENT_NEVER_MIND_BUTTON}
    Check element not display on screen     Cancel Interview        wait_time=3s
    Capture page screenshot


Verify Reschedule function work correctly if candidate was sent Orientation event via API before (OL-T14517)
    Login into company common
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${user_name}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Set scheduling orient event     ${event_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click on span text      Reschedule
    Search and select orient event on scheduling popup      ${event_name}
    Click on span text      Reschedule Orientation
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      ${no_group_assigned}
    Check element display on screen     ${ORIENT_SCHEDULING_ICON_COMPLETE}
    Capture page screenshot
    Click at    ${SCHEDULING_ORIENT_EVENT_CLOSE_BUTTON}
    Check element display on screen     I've rescheduled you to the orientation
    Capture page screenshot


Verify the Create Orientation Event button works correctly (OL-T14506, OL-T14507, OL-T14492)
#   Note: check no orientation event availablity before run this TC
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to CEM page
    Switch to user      ${CA_TEAM}
    ${candidate_first_name_random} =    Add a Candidate
    Scheduling select orient event label
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}      No Job Assigned
    Check element display on screen     No Orientation Events Exist
    Check element display on screen     ${ORIENT_EVENT_GO_BACK_BUTTON}
    Capture page screenshot
    Click at    ${CREATE_ORIENT_EVENT_SCHEDULING_BUTTON}
    Switch window       Create Event | Candidate Experience Manager
    ${window_title} =       Get title
    Should Be Equal As Strings      ${window_title}     Create Event | Candidate Experience Manager
    Check element display on screen     Create New Event
    Capture page screenshot

*** Keywords ***
Orient event turn on break rule toggle
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at    ${SCHEDULING_ORIENTATION_EVENT_LABEL}
    Click at    ${ORIENT_EVENT_HEADER_TOGGLE_SETTING_BUTTON}
    Click at    ${ORIENT_EVENT_REGISTRATION_BREAK_RULE_TOGGLE}

Set timeline min max
    [Arguments]    ${time_line_min}     ${time_line_max}
    Click at    ${SCHEDULING_ORIENTATION_EVENT_LABEL}
    Click at    ${ORIENT_EVENT_HEADER_TOGGLE_SETTING_BUTTON}
    Click at    ${ORIENT_EVENT_SCHEDULING_TIME_LINE_TOGGLE}
    Click at    ${ORIENT_EVENT_SCHEDULING_TIME_LINE_MIN}
    Click at    ${SCHEDULING_TIME_LINE_VALUE}    ${time_line_min}
    Click at    ${ORIENT_EVENT_SCHEDULING_TIME_LINE_MAX}
    Click at    ${SCHEDULING_TIME_LINE_VALUE}    ${time_line_max}

Verify display infor candidate on scheduling popup
    [Arguments]     ${candidate_name}       ${no_job_or_group_assigned}
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    ${candidate_name}
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    ${no_job_or_group_assigned}
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    No Location Assigned
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    Capture Complete

Login into company common
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
