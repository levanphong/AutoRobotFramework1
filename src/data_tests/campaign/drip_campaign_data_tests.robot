*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${event_name}       Event single path for drip campaign

*** Test Cases ***
Prepare data test for test cases create drip campaigns turn on event toggle
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Events Page
    Creating the event      Hiring Event    Virtual     Single Event    Virtual Scheduled Interviews    None    None    event_name_fixed=${event_name}
