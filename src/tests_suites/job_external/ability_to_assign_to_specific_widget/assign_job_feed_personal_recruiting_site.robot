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

Documentation       Test Automation Job Search Parameter Off: Create new two users with name are : Personal Recruiting and Personal SeRecruiting
# Personal Recruiting's Recruiting Site: select feed is AUTOMATION_JOB_FEEDS_PROD
# Personal SeRecruiting's Recruiting Site: select feed is AUTOMATION_MP_SECOND_FEEDS_PROD

*** Variables ***

*** Test Cases ***
Check Job Search and Apply Job when Job Search (Personal Recruiting Site) = Master Feed (Job Search Parameter OFF in both Job Search and Personal Recruiting Site) (OL-T25496, OL-T25497)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}
    ${url_landing_site}=    Get Landing Site shortened URL      Personal Recruiting's Recruiting Site
    Go to   ${url_landing_site}
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


Check Job Search and Apply Job when Job Search (Personal Recruiting Site) = Master Feed(Job Search Parameter ON in Job Search and OFF in Personal Recruiting Site) (OL-T25501)
    Check job displays by job feed      Personal Recruiting's Recruiting Site    ${COMPANY_JOB_SEARCH_PARAMETER_ON}


Check Job Search and Apply Job when Job Search (Personal Recruiting Site) = Master Feed, Feed B (Job Search Parameter OFF in Job Search and ON in Personal Recruiting Site)
    Check job displays by job feed      Personal SeRecruiting's Recruiting Site    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}

*** Keywords ***
