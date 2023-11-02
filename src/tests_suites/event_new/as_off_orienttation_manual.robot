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
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        aramark    birddoghr    darden    dev2    lts_stg    olivia    regression    stg

Documentation       Turn on Event -> Turn off Manual Scheduling Advanced Settings

*** Variables ***
${orientation}      Orientation

*** Test Cases ***
Verify initialization display when user manual orientation event (OL-T14488)
    Login into company event
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${CA_TEAM}
    Go to CEM page
    ${candidate_first_name_random} =    Add a Candidate
    Scheduling select orient event label
    Verify display infor candidate on scheduling popup      ${candidate_first_name_random}
    Check element display on screen     ${event_name}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_SUBMIT_DISABLED_BUTTON}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_CANCEL_BUTTON}
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify highlight orientation event When the user selected (OL-T14493)
    Login into company event
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${CA_TEAM}
    Go to CEM page
    Add a Candidate
    Scheduling select orient event label
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_CANCEL_BUTTON}
    Check element display on screen     ${SCHEDULING_ORIENT_EVENT_SUBMIT_DISABLED_BUTTON}
    Capture page screenshot
    Search and select orient event on scheduling popup      ${event_name}
    ${locator_border} =     Format String       ${BORDER_ORIENT_EVENT_ON_SCHEDULING_POPUP}      ${event_name}
    ${is_active_bg} =       Get element color       ${locator_border}       border-color
    IF    ${is_active_bg}
        Check element display on screen     ${SCHEDULING_ORIENT_EVENT_SUBMIT_BUTTON}
    END
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify the Cancel function works correctly when user cancel interview (OL-T14505)
    Login into company event
    Go to Events page
    Switch to user      ${EE_TEAM}
    ${event_name} =     Create orient event Virtual Single Event    ${CA_TEAM}
    Go to CEM page
    Add a Candidate
    Set scheduling orient event     ${event_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${SCHEDULING_SUMMARY_CANCEL_BUTTON}
    Check element display on screen     ${ORIENT_EVENT_CONFIRM_CANCEL_BUTTON}
    Capture page screenshot
    Click at    ${CANCEL_INTERVIEW_NEVER_MIND_BUTTON}
    Check element not display on screen     ${ORIENT_EVENT_CONFIRM_CANCEL_BUTTON}       wait_time=3s
    Capture page screenshot
    Click at    ${SCHEDULING_SUMMARY_CANCEL_BUTTON}
    Click at    ${SCHEDULING_CONFIRM_CANCEL_BUTTON}
    Check element not display on screen     ${ORIENT_EVENT_CONFIRM_CANCEL_BUTTON}       wait_time=3s
    Check element display on screen     Orientation Canceled
    Capture page screenshot
    Go to Events page
    Search and delete event     ${event_name}


Verify the Go back function works correctly (OL-T14508)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Switch to user      ${CA_TEAM}
    Add a Candidate
    Scheduling select orient event label
    Click at    ${ORIENT_EVENT_GO_BACK_BUTTON}
    Check element display on screen     ${SCHEDULING_ORIENTATION_EVENT_LABEL}
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
    [Arguments]     ${candidate_name}
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    ${candidate_name}
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    No Group Assigned
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    No Location Assigned
    Check element display on screen     ${ORIENT_EVENT_CANDIDATE_INFOR_SCHEDULING_POPUP}    Capture Complete

Login into company event
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
