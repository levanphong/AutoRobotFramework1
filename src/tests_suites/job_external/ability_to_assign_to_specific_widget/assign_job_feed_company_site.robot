*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/phone_number_page.robot
Resource            ../../../pages/applicant_flows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    regression

Documentation       Company site : Test Automation Job Search Parameter Off Site
# Apply conversation (AF_Assign_Job_Feed_Single_Path) to company site

*** Variables ***

*** Test Cases ***
Check Job Search and Apply Job when Job Search (Company Site) = Feed B (Job Search Parameter OFF in both Job Search and Company Site) (OL-T23164, OL-T23166)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}
    ${url_company_site}=    Get Landing Site shortened URL      Test Automation Job Search Parameter Off Site
    Go to   ${url_company_site}
    Wait for Olivia reply
    Check element display on screen     ${WELCOME_CANDIDATE_MESSAGE_2}      ${COMPANY_JOB_SEARCH_PARAMETER_OFF}
    capture page screenshot
    Input text and send message     ${ANY_JOBS_ANYWHERE}
    capture page screenshot
    Check element display on screen     ${RECOMMENDED_JOB_POSITION_MESSAGE}
    Check span display      ${TWENTY_RECOMMENDED_JOB_MESSAGE}
    capture page screenshot
    Input text and send message     ${MP_SECOND_FEED_004}
    Input text and send message     ${AUTOMATION_TESTER_REQ_ID_001}
    capture page screenshot
    Check span display       ${AUTOMATION_TESTER_TITLE_001}
    capture page screenshot
    Apply job on landing site   ${AUTOMATION_TESTER_TITLE_001}
    Check element display on screen     ${CHAT_TO_APPLY_INTRODUCTION}     ${AUTOMATION_TESTER_TITLE_001}
    capture page screenshot


Check Job Search and Apply Job when Job Search (Company Site) = Master Feed(Job Search Parameter ON in Job Search and OFF in Company Site) (OL-T23172)
    Check job displays by job feed      Test Automation Job Search Parameter On Site    ${COMPANY_JOB_SEARCH_PARAMETER_ON}


Check Job Search and Apply Job when Job Search (Company Site) = Master Feed, Feed B (Job Search Parameter OFF in Job Search and ON in Company Site) (OL-T23172)
    Check job displays by job feed      Test Automation Job Search Parameter Off Site    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}
