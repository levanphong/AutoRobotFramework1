*** Settings ***
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/candidate_journeys_page.robot
Resource            ../../../pages/event_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/conversation_builder_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

Documentation       Create candidate journey with    'Auto Test Create Job'    name
...                 Run file data test: basic_multi_location_job.robot

*** Variables ***
${cj_create_job}            cj_job_internal
${offer_name}               Automation job
${auto_job}                 auto_job
${type_job_description}     Easily create the same job at multiple locations. Jobs can be turned on/off per location whenever you need candidates. This job uses basic hiring team assignment.

*** Test Cases ***
Check the Create a new job Popup (OL-T14668)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_BUTTON}
    Check element display on screen    ${type_job_description}
    Check element display on screen    ${JOBS_TEMPLATE_NAME_ON_MODAL}    ${basic_job_temp}
    check element display on screen    ${BLANK_JOB}
    check element display on screen    ${NEXT_BUTTON_ON_MODAL}
    check element display on screen    ${CANCEL_BUTTON_ON_MODAL}
    Capture page screenshot


Check the job builder page when create a new job (OL-T14669)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Job builder page is organized with correctly tabs


Check UI of Overview tabs of Basic Multi-Location job (OL-T14670)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_random_name} =    Generate random name    ${auto_job}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Overview tab is displayed with full components      False


Check adding for the location to Legacy Multi-Location job is successful (OL-T14671)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    wait with large time
    # Verify remote loctaion is showed, user can add all location
    Click at    Overview
    Click at    Edit Locations
    Check element display on screen    Candidates who are hired for this job are able to work remotely
    Capture page screenshot
    Click at    ${TOGGLE_REMOTE_POSITION}
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    Click at    ${SELECT_ALL_LOCATION}
    Click at    ${SAVE_BUTTON_LOCATION}
    Delete a Job    ${job_name}    ${job_family_name}


Check adding for shift to Legacy Multi-Location job is successful (OL-T14672)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    generate random name    auto_job
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Input Job name    ${job_name}
    Select shift for job    Morning
    select more shift for job    Afternoon
    Click at    ${EDIT_SHIFT_BUTTON}
    Check element display on screen    Morning
    Check element display on screen    Lunch
    Check element display on screen    Afternoon
    Check element display on screen    Evening
    Check element display on screen    Overnight
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check adding for new shift to Legacy Multi-Location job is successful (OL-T14673)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    generate random name    auto_job
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Input Job name    ${job_name}
    Click at    ${ADD_SHIFT_BUTTON}
    Delete shift    Afternoon
    Click at    ${ADD_SHIFT_BUTTON}
    Delete shift    Morning
    Add more shifts for job    Afternoon
    Add more shifts for job    Morning
    Click at    ${ADD_SHIFT_BUTTON}
    Check element display on screen    Afternoon
    Check element display on screen    Morning
    Capture page screenshot


Check adding User/user role to Hiring Team tab of Legacy Multi-Location job (OL-T14674)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    wait with large time
    Click at    Hiring Team
    Check element display on screen    Decide which users can manage the candidate journey for this job.
    Check element display on screen    Select users or roles who have access to this job
    Capture page screenshot
    # verify can add users to Hiring Team
    Add Hiring Team for job    ${CA_TEAM}
    Delete a Job    ${job_name}    ${job_family_name}


Check selection CJ of Legacy Multi-Location job (OL-T14675)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    ${cj_create_job}    Company Admin
    wait with large time
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Click at    ${INPUT_CANDIDATE_JOURNEY}
    ${cj_name_locator} =    Format String    ${CANDIDATE_JOURNEY_IS_SELECTED}    ${cj_create_job}
    check element display on screen    ${cj_name_locator}
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check Question is added to Legacy Multi-Location job (OL-T14676)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    ...    Company Admin
    wait with large time
    add question document upload
    add question List select
    #    Check display question free text
    check element display on screen    How old are you?
    # Check display question document upload
    check element display on screen    Could you upload your CV?
    # Check display question List select
    check element display on screen    How many years of experience do you have?
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check Outcome is added to Legacy Multi-Location job (OL-T14677)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    wait with large time
    add outcome send interview
    check element display on screen    send_interview
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check Legacy Multi-Location job is published (OL-T14678)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    Go to My Jobs page
    Status of Job toggle at My Job is off    ${job_name}    ${test_location_name}
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check Legacy Multi-Location Job on My jobs (OL-T14679)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    Go to My Jobs page
    Status of Job toggle at My Job is off    ${job_name}    ${test_location_name}
    Active a job    ${job_name}
    Status of Job toggle at My Job is on    ${job_name}    ${test_location_name}
    Capture page screenshot
    Deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check Editing a Legacy Multi-Location job (OL-T14680)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    wait with large time
    add question document upload
    Check element display on screen    ${STATUS_UNPUBLISHED}
    Capture page screenshot
    wait with medium time
    Publish job
    Delete a Job    ${job_name}    ${job_family_name}


Create a Basic Multi-Location from job template (OL-T14681, OL-T15775)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${random_name} =    Generate random name    ${auto_job}
    Go to Jobs page
    ${job_template_name} =    Create job template by name    ${job_description}    ${random_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Go to Jobs page
    Create new job with type and template    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}    ${job_template_name}
    Job builder page is organized with correctly tabs
    Input content to publish job    ${test_location_name}
    Publish job
    # Note: job name and job template are same name
    Status of Job toggle at My Job is off    ${job_template_name}    ${test_location_name}
    Capture page screenshot
    Delete a Job    ${job_template_name}    ${job_family_name}
    Delete a Job template    ${job_template_name}


Check candidate flow when candidate search and apply for a Legacy Multi-Location job (OL-T14682)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey    None   None   Company Admin
    wait with large time
    add outcome send interview
    Publish job
    Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    ${CA_TEAM}
    # Verify candidate has status correclty with outcome action
    Click at    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name}
    Check element display on screen    ${CANDIDATE_JOURNEY_STATUS}    Interview Scheduled
    Capture page screenshot
    Deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check candidate flow when candidate apply for a Legacy Multi-Location job via job posting (OL-T14683)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey     None   None   Company Admin
    wait with large time
    add outcome send interview
    Publish job
    ${job_link} =    Turn on job and get internal job link    ${job_name}    ${test_location_name}
    go to    ${job_link}
    ${candidate_name} =    Candidate finish Job posting
    Check olivia asked phone and candidate input phone
    Go to CEM page
    Switch to user    ${CA_TEAM}
    # Verify candidate has status correclty with outcome action
    Click at    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name.full_name}
    Check element display on screen    ${CANDIDATE_JOURNEY_STATUS}    Interview Scheduled
    Capture page screenshot
    Deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check permission of User when viewing Candidate on CEM is work correctly - Legacy Multi-location job (OL-T14684)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey    None   None   Company Admin
    wait with large time
    add outcome send interview
    Publish job
    ${job_link} =    Turn on job and get internal job link    ${job_name}    ${test_location_name}
    go to    ${job_link}
    ${candidate_name} =    Candidate finish Job posting
    Check olivia asked phone and candidate input phone
    Go to CEM page
    Switch to user    ${CA_TEAM}
    Check element display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name.full_name}
    # Note: EN Team user isn't assigned to ${test_location_name}
    Switch to user    ${EN_TEAM}
    Check element not display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name.full_name}
    Capture page screenshot
    Switch to user    ${TEAM_USER}
    Deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check permission of User when Job in My jobs is work correctly - Legacy Multi-location job (OL-T14685)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey    None   None   Company Admin
    wait with large time
    Switch to user    ${CA_TEAM}
    Go to My Jobs page
    Status of Job toggle at My Job is off    ${job_name}    ${test_location_name}
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check the Create a new template job Popup (OL-T14686)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_TEMPLATE_BUTTON}
    Check element display on screen    ${type_job_description}
    check element display on screen    ${SAVE_JOB_TEMPLATE_ON_MODAL}
    check element display on screen    ${CANCEL_BUTTON_ON_MODAL}
    Capture page screenshot


Check the builder page when create a new job template (OL-T14687)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_TEMPLATE_BUTTON}
    Click at    ${SAVE_JOB_TEMPLATE_ON_MODAL}
    Job builder page is organized with correctly tabs
