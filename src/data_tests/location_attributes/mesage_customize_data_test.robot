*** Settings ***
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/system_attributes_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Keywords ***
Prepare Interview Scheduling Data test
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Enable Client Setup for Interview Scheduling    Scheduling
    Enable Client Setup for Interview Scheduling    Basic User Portal - Tasks
    Add a Custom Location Attributes    Add custom
    Add a Custom Location Attributes    Location Manager

Enable Client Setup for Interview Scheduling
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'Scheduling'
        Click at    ${SCHEDULING_LABEL}
        Turn on    ${ADVANCED_SCHEDULING_SETTING}
    END
    IF    '${item}' == 'Account Overview'
        Click at    ${ACCOUNT_OVERVIEW_LABEL}
        Click at    ${BASIC_USER_ACCESS}
        Click at    Basic User Portal - Tasks
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

*** Test Cases ***
Prepare Interview Scheduling Data test for Suite
    Prepare Interview Scheduling Data test
