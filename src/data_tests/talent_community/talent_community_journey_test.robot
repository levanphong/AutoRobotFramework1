*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${next_step_talent_candidate_journey}    Next_Steps_Talent_Community_Journey

*** Test Cases ***
Prepare data
    Given Setup test
   Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
   Add a Candidate Journey     ${next_step_talent_candidate_journey}    Talent Community Journey

