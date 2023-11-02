*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../pages/school_management_page.robot
Resource            ../../commons/common_keywords.robot
Resource            ../../pages/base_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
run data test
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Prepare Campus Events Data Test

*** Keywords ***
Prepare Campus Events Data Test
    Go to approvals builder page
    Add approval flow   auto campus event       ${EE_TEAM}
    Go to school management page
    Click at    ${SCHOOL_FETCHED_ON_LIST}
    Select approval flow    auto campus event
