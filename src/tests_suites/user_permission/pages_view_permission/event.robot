*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/event_page.robot
Resource            ../../../pages/all_candidates_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check the Event page is displayed for user has full access in case user is Company Admin (OL-17086)
    Verify user can go to Events page with role    Company Admin


Check the Event page is displayed for user has full access in case user is Full User Edit Everything (OL-17087)
    Verify user can go to Events page with role    Full User - Edit Everything


Check the Event page is displayed under Menu in case user is Paradox Admin (OL-17085)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Capture page screenshot
    Click at  ${CEM_PAGE_RIGHT_MENU_EVENTS}
    Wait with medium time
    ${current_event_url} =    Get location
    Should Contain    ${current_event_url}    /events
    Capture page screenshot


Verify Full User - Edit everything has full access to view events that are assigned to that user (OL-17089, OL-17091, OL-17093)
    Given Setup test
    when Login into system with company    Full User - Edit Everything    ${COMPANY_EVENT}
    Create a test Event
    ${current_event_url} =    Get location
    Should Contain    ${current_event_url}    /event
    Should Contain    ${current_event_url}    /dashboard
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Capture page screenshot
    ${new_event_name} =     Generate random name  event
    Input into    ${EVENT_NAME_INPUT}    ${new_event_name}
    Capture page screenshot
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Capture page screenshot
    Click at    ${CONFIRM_SAVE_BUTTON}
    Wait with short time
    Verify text contain  ${DASH_BOARD_EVENT_NAME}  ${new_event_name}
    Capture page screenshot


Verify Full User - Edit everything has full access to view events that are assigned to that user (OL-17090, OL-17092)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create a test Event
    ${current_event_url} =    Get location
    Should Contain    ${current_event_url}    /event
    Should Contain    ${current_event_url}    /dashboard
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Capture page screenshot
    ${new_event_name} =     Generate random name  event
    Input into    ${EVENT_NAME_INPUT}    ${new_event_name}
    Capture page screenshot
    Click at    ${TOOLS_STEP_LABEL}
    Click at    ${SAVE_EVENT_BUTTON}
    Capture page screenshot
    Click at    ${CONFIRM_SAVE_BUTTON}
    Verify text contain  ${DASH_BOARD_EVENT_NAME}  ${new_event_name}
    Capture page screenshot


Verify Paradox Admin user has full access to view events that are assigned to another user (OL-17088)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user  EE Team
    ${event_name} =     Create a test Event
    Switch to user  ${TEAM_USER}
    Verify text contain  ${DASH_BOARD_EVENT_NAME}  ${event_name}

*** Keywords ***
Verify user can go to Events page with role
    [Arguments]     ${user_role}
    Given Setup test
    when Login into system with company    ${user_role}    ${COMPANY_EVENT}
    ${is_redirected} =      Go to Events page
    Run keyword unless      '${is_redirected}' == 'True'   Fail
    Capture page screenshot

Create a test Event
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =     Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set Registration step
    Set Tools step
    Capture page screenshot
    [Return]    ${event_name}
