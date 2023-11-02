*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../pages/school_management_page.robot
Resource            ../../commons/common_keywords.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
run data test on event company
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Manual Scheduling Advanced Settings toggle


run data test on common company
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Turn on Manual Scheduling Advanced Settings toggle


run data test on franchise off job on company
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Turn on Manual Scheduling Advanced Settings toggle

*** Keywords ***
Turn off Manual Scheduling Advanced Settings toggle
    Navigate to Option in client setup      Events
    ${is_changed} =     Turn off     ${MANUAL_SCHEDULING_ADVANCED_SETTING_TOGGLE}
    Save client setup page

Turn on Manual Scheduling Advanced Settings toggle
    Navigate to Option in client setup      Events
    ${is_changed} =     Turn on     ${MANUAL_SCHEDULING_ADVANCED_SETTING_TOGGLE}
    Save client setup page
