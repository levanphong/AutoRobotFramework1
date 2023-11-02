*** Settings ***
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/all_candidates_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${job_type}                 ${TYPE_STANDARD_LOCATION}
${test_location_name}       ${CONST_LOCATION}
${job_description}          Job Description
${job_code}                 JOB_CODE_123
${conversation_job}         conv_job_search_create_job
${landing_site_job}         landing_site_create_job

*** Test Cases ***
Check the job builder page when create a new job (OL-T14705)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    Job builder page is organized with correctly tabs


Check UI of Overview tabs of Standard job (OL-T14706)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    Overview tab is displayed with full components


Check adding for the location to Standard job is successful (OL-T14707)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Input into    ${INPUT_JOB_DESCRIPTION}    ${job_description}
    Input into    ${INPUT_JOB_CODE}    ${job_code}
    Select Job Posting Type    Internal
    Add location for job Standard    ${test_location_name}
    ${location} =    format string    ${AVAILABLE_LOCATION_BY_NAME}    ${test_location_name}
    Check element display on screen    ${location}
    Delete a Job    ${job_name}    ${job_family_name}


Check adding for shift to Standard job is successful (OL-T14708)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Select shift for job    Morning
    ${shift} =    format string    ${SHIFT_IN_USED_BY_NAME}    Morning
    Check element display on screen    ${shift}
    Delete a Job    ${job_name}    ${job_family_name}


Check adding for new shift to Standard job is successful (OL-T14709)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Click at    ${ADD_SHIFT_BUTTON}
    Delete shift    Overnight
    Add more shifts for job    Overnight
    ${shift_locator} =    format string    ${SHIFT_CHECKBOX_BY_NAME}    Overnight
    Click at    ${ADD_SHIFT_BUTTON}
    Check element display on screen    ${shift_locator}
    Capture page screenshot


Check adding User/user role to Hiring Team tab of Standard job (OL-T14710)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check selection CJ of Standard job (OL-T14711)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Add Candidate Journey for job       Default Candidate Journey
    Delete a Job    ${job_name}    ${job_family_name}


Check Question is added to Standard job (OL-T14712)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Add Candidate Journey for job       Default Candidate Journey
    Add Screening Question for job
    ${screening_question} =    format string    ${QUESTION_NAME}    Age
    Check element display on screen    ${screening_question}
    Delete a Job    ${job_name}    ${job_family_name}


Check Outcome is added to Standard job (OL-T14713)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${job_type}
    Input Job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Add Candidate Journey for job       Default Candidate Journey
    Add Screening Question for job
    Add outcome send interview
    ${outcomes} =    format string    ${OUTCOMES_NAME}    send_interview
    Check element display on screen    ${outcomes}
    Delete a Job    ${job_name}    ${job_family_name}


Check Standard job is published (OL-T14714)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create a job type Standard with default candidate journey    ${job_name}    ${job_family_name}    ${test_location_name}
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check Standard Job on My jobs (OL-T14715)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create a job type Standard with default candidate journey    ${job_name}    ${job_family_name}    ${test_location_name}
    Go to My Jobs page
    Status of Job toggle at My Job is off    ${job_name}    ${test_location_name}
    Capture page screenshot
    Active a job    ${job_name}    ${test_location_name}
    Status of Job toggle at My Job is on    ${job_name}    ${test_location_name}
    Capture page screenshot
    Deactivate a job     ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check Editing a Standard job (OL-T14716)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_template} =    generate random name    auto_job_template
    Create job template by name     ${job_description}    ${job_template}    ${job_type}
    ${job_name} =    generate random name    auto_job
    Create a job type Standard with default candidate journey    ${job_name}    ${job_family_name}    ${test_location_name}
    Go to Job detail    ${job_name}    ${job_family_name}
    Input into    ${INPUT_JOB_DESCRIPTION}    ${job_description}
    Input into    ${INPUT_JOB_CODE}    ${job_code}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    Check element display on screen    ${STATUS_UNPUBLISHED}
    Capture page screenshot
    Publish job
    Delete a Job    ${job_name}    ${job_family_name}


Create a Standard from job template (OL-T14717)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_template} =    generate random name    auto_job_template
    Create job template by name    ${job_description}    ${job_template}    ${job_type}
    Go to Jobs page
    Create new job with type and template    ${job_family_name}    ${job_type}    ${job_template}
    Add location for job Standard    ${test_location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Add Candidate Journey for job       Default Candidate Journey
    Add Screening Question for job
    Publish job
    Capture page screenshot
    Delete a Job    ${job_template}     ${job_family_name}


Check candidate flow when candidate search and apply for a Standard job (OL-T14718,OL-T14720)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create a job type Standard with default candidate journey    ${job_name}    ${job_family_name}    ${test_location_name}
    Active a job    ${job_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_job}    ${landing_site_job}
    Go to    ${url}
    ${candidate_name} =      Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Click on candidate name   ${candidate_name}
    ${candidate_status} =    format string    ${CANDIDATE_JOURNEY_STATUS}    Interview Scheduled
    Check element display on screen    ${candidate_status}
    Capture page screenshot
    Deactivate a job     ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}     ${job_family_name}


Check candidate flow when candidate apply for a Standard job via job posting (OL-T14719, OL-T14721)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create a job type Standard with default candidate journey    ${job_name}    ${job_family_name}
    ...    ${test_location_name}
    ${url} =    Turn on job and get internal job link    ${job_name}    ${test_location_name}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job posting
    Go to CEM page
    Click on candidate name    ${candidate_name.full_name}
    ${candidate_status} =    format string    ${CANDIDATE_JOURNEY_STATUS}    Interview Scheduled
    Check element display on screen    ${candidate_status}
    Capture page screenshot
    Deactivate a job     ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}     ${job_family_name}

