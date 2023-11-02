*** Settings ***
Resource            ../../../pages/workflows_page.robot
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/candidate_journeys_page.robot
Resource            ../../../pages/offers_page.robot
Resource            ../../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${offer_name}               Automation job
${job_family_name}          Coffee family job
${test_location_name}       ${LOCATION_NAME_2}

*** Test Cases ***
Verify candidate is scheduled an interview with hiring team of job which is legacy multi-location (OL-T14038)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
#    Basic multiple-location type:Verify Publish job but don't add Additional Detail section (OL-T16103)
    create a job type Basic Multi-Location with default candidate journey    ${job_name}    ${job_family_name}
    ...    ${test_location_name}
#    Open internal job link and check the welcome message
    open job link check welcome message then delete job     ${job_name}


Verify candidate is scheduled an interview with hiring team of job which is multi-location (OL-T14039)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
#    multiple-location type:Verify Publish job but don't add Additional Detail section (OL-T16107)
    create a job type Multi-Location with default candidate journey    ${job_name}    ${job_family_name}    ${test_location_name}
    open job link check welcome message then delete job     ${job_name}


Verify candidate is scheduled an interview with hiring team of job which is standard (OL-T14040,OL-T14045)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
#   Standard type:Verify Publish job but don't add AD section (OL-T16109)
#   If user tries to publish, but the Job Data page is at an empty state (OL-T6087)
    create a job type Standard with default candidate journey    ${job_name}    ${job_family_name}  ${test_location_name}
    open job link check welcome message then delete job     ${job_name}


Verify Hiring team shows on users modal of attendee in case Hiring team has only one user - Standard (OL-T14041)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    ${user} =    set variable    CA Team
    Add Hiring Team for job type Standard/Muti-Location    ${user}
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    Scroll to element by JS    Add Instructions
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE}
    wait with medium time
    search and select attendee    ${user}
    ${locator} =    Format String    ${ATTENDEE_INTERVIEW}    Company Admin
    Check element not display on screen    ${locator}
    delete a job    ${job_name}    ${job_family_name}


Verify Hiring team shows on users modal of attendee in case Hiring team has only one user - Multi-location (OL-T14042)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    ${user} =    set variable    CA Team
    Add Hiring Team for job type Standard/Muti-Location    ${user}
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    Scroll to element by JS    Add Instructions
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE}
    wait with medium time
    search and select attendee    ${user}
    ${locator} =    Format String    ${ATTENDEE_INTERVIEW}    Company Admin
    Check element not display on screen    ${locator}
    delete a job    ${job_name}    ${job_family_name}


Verify Hiring team shows on users modal of attendee in case Hiring team has only one user - Legacy Multi location (OL-T14043)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    ${user} =    set variable    CA Team
    Add Hiring Team for job    ${user}
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    Scroll to element by JS    Add Instructions
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE}
    wait with medium time
    search and select attendee    ${user}
    ${locator} =    Format String    ${ATTENDEE_INTERVIEW}    Company Admin
    Check element not display on screen    ${locator}
    delete a job    ${job_name}    ${job_family_name}


Verify Hiring team shows on users modal of attendee in case Hiring team has multiple users (OL-T14044)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    ${user1} =    set variable    CA Team
    ${user2} =    set variable    EE Team
   Add Hiring Team for job    ${user1}
   Add Hiring Team for job    ${user2}
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    Scroll to element by JS    Add Instructions
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE}
    wait with medium time
    search and select attendee    ${user1}
    search and select attendee    ${user2}
    ${locator} =    Format String    ${ATTENDEE_INTERVIEW}    Company Admin
    Check element not display on screen    ${locator}
    delete a job    ${job_name}    ${job_family_name}


Verify Hiring Team works correctly with Hiring Team & another user as attendee (OL-T14046,OL-T14047)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    ${user} =    set variable    CA Team
    Click at    Hiring Team
    Click at    ${JOB_ADD_ROLE_BUTTON}
    CLICK ON SPAN TEXT    Hiring Manager
    Click at    ${APPLY_BUTTON}
    Click at    ${JOB_ADD_USER_BUTTON}
    Click at    ${HIRING_TEAM_ROLE_USER}    Hiring Manager
    Click at    ${INPUT_SEARCH_USER}
    input text    ${INPUT_SEARCH_USER}    ${user}
    Scroll to element by JS    ${user}
    Click at    ${HIRING_TEAM_USER}    ${user}
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_JOB_BUTTON}
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    Scroll to element by JS    Add Instructions
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE}
    wait with medium time
    search and select attendee    ${user}
    search and select attendee    Hiring Manager
    Click at    ${SAVE_JOB_BUTTON}
    Add Screening Question for job
    add outcome send interview
    publish job
    ${job_link} =    Turn on job and get internal job link    ${job_name}    ${test_location_name}
    go to    ${job_link}
    Go to My Jobs page
    deactivate a job    ${job_name}    ${test_location_name}
    delete a job    ${job_name}    ${job_family_name}

*** Keywords ***
open job link check welcome message then delete job
    [Arguments]    ${job_name}
    ${job_link} =    Turn on job and get internal job link    ${job_name}    ${test_location_name}
    go to    ${job_link}
    wait with short time
    check message widget site response correct    ${I_CAN_HELP_YOU_TO_THE} ${job_name}
    check message widget site response correct    ${ASK_FIRST_AND_LAST_NAME}
    Go to My Jobs page
    Deactivate a job    ${job_name}    ${test_location_name}
    delete a job    ${job_name}    ${job_family_name}
