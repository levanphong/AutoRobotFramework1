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

# Test Automation Job Search Parameter Off
# Navigate to Client setup page > Job search > Turn off Set Default Job Search Parameter toggle
# Navigate to Client setup page > Turn on ATS Job Feed Manager toggle > select My Job and Job Feed Conditions is job ON
# Create two Applicant flow and two candidate journey
# Create new a custom conversation: AF_Assign_Job_Feed
# Create new a landing site name : Landing_site_assign_job_feed
# Create new a lading site name : Landing_site_assign_job_feed_second_feed

# Test Automation Job Search Parameter On
# Navigate to Client setup page > Job search > Turn on Set Default Job Search Parameter toggle > Set Job category
# Navigate to Client setup page > Turn on ATS Job Feed Manager toggle > select My Job and Job Feed Conditions is job ON
# Create two Applicant flow and two candidate journey
# Create new a custom conversation: AF_Assign_Job_Feed
# Create new a landing site name : Landing_site_assign_job_feed

*** Variables ***

*** Test Cases ***
Check Job Search and Apply Job when Job Search (Landing Site ) = Master Feed (Job Search Parameter OFF in both Job Search and Landing Site ) (OL-T25503, OL-T25504)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}
    ${url_landing_site}=    Get Landing Site shortened URL      Landing_site_assign_job_feed
    Go to   ${url_landing_site}
    Wait for Olivia reply
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${WELCOME_CANDIDATE_MESSAGE_1}
    capture page screenshot
    Input text and send message     ${ANY_JOBS_ANYWHERE}
    capture page screenshot
    Check element display on screen     ${RECOMMENDED_JOB_POSITION_MESSAGE}
    Check span display      ${TWENTY_RECOMMENDED_JOB_MESSAGE}
    capture page screenshot
    Input text and send message     ${MP_SECOND_FEED_004}
    Check element display on screen     ${SORRY_MESSAGE}    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}
    capture page screenshot
    Input text and send message     ${AUTOMATION_TESTER_REQ_ID_001}
    capture page screenshot
    Check span display       ${AUTOMATION_TESTER_TITLE_001}
    capture page screenshot
    Apply job on landing site   ${AUTOMATION_TESTER_TITLE_001}
    Check element display on screen     ${CHAT_TO_APPLY_INTRODUCTION}     ${AUTOMATION_TESTER_TITLE_001}
    capture page screenshot


Check Job Search and Apply Job when Job Search (Landing Site) = Master Feed(Job Search Parameter ON in Job Search and OFF in Landing Site) (OL-T25508)
    Check job displays by job feed      Landing_site_assign_job_feed    ${COMPANY_JOB_SEARCH_PARAMETER_ON}


Check Job Search and Apply Job when Job Search (Landing Site ) = Master Feed, Feed B (Job Search Parameter OFF in Job Search and ON in Landing Site) (OL-T25509)
    Check job displays by job feed      Landing_site_assign_job_feed_second_feed    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}

*** Keywords ***
