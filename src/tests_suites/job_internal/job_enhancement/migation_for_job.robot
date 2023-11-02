*** Settings ***
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/candidate_journeys_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/conversation_builder_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

Documentation       Create candidate journey with    'Auto Test Create Job'    name
...                 Run file data test: basic_multi_location_job.robot

*** Variables ***
${job_template_migration}       job_template_migration

*** Test Cases ***
Check Job's information at Overview tab is correctly after migration (OL-T14657, OL-T14656)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${job_name} =    Create new job without Job template     ${job_type_basic_text}     Default Candidate Journey
    wait with short time
	Go to Jobs page
	search job name     ${job_name}     ${job_family_name}
	Click at    ${JOBS_NAME}    ${job_name}
    Overview tab is displayed with full components      True    ${job_name}     Edit Locations
    Delete a Job    ${job_name}     ${job_family_name}


Check Job's information at Hiring Team tab is correctly after migration (OL-T14658)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
	Go to Jobs page
	search and click job name     ${job_name}     ${job_family_name}
	# Verify Roles/User who is selected before is keep
    Click at    Hiring Team
    Verify display exact text    Company Admin
    Verify display exact text    Supervisor
    Verify display exact text    Recruiter
    Verify display exact text    Hiring Manager
    Check element display on screen    Full User
    Capture page screenshot
    Delete a Job    ${job_name}     ${job_family_name}


Check Job's information at Candidate Journey tab is correctly after migration (OL-T14659)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
	# Verify CJ are keep correctly
    Go to Jobs page
	search and click job name     ${job_name}     ${job_family_name}
	Click at    ${CANDIDATE_JOURNEY_TAB}
	Click at    ${INPUT_CANDIDATE_JOURNEY}
	Check element display on screen     ${CANDIDATE_JOURNEY_IS_SELECTED}    Default Candidate Journey
	Capture page screenshot
	Delete a Job    ${job_name}     ${job_family_name}


Check Job's information at Screening tab is correctly after migration (OL-T14660)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
	Go to Jobs page
	search and click job name     ${job_name}     ${job_family_name}
	Click at    ${SCREENING_TAB}
    wait with medium time
    add question document upload
    add question List select
    add outcome send interview
    Go to Jobs page
	search job name     ${job_name}     ${job_family_name}
	Click at    ${JOBS_NAME}    ${job_name}
	Click at    Screening
	# Check display Outcomes are keep correctly
	check element display on screen    send_interview
    # Check display question free text
    check element display on screen    How old are you?
    # Check display question document upload
    check element display on screen    Could you upload your CV?
    # Check display question List select
    check element display on screen    How many years of experience do you have?
    Capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}


Check old Template at Job Template in case the existing company using Job internal after migration (OL-T14661)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${job_template_name} =   generate random name    auto_job
    Create new job template    ${job_description}    ${job_template_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Go to Jobs page
    # Check job template is shown after create
    Search a job template   ${job_template_name}
	Check element display on screen    ${JOB_TEMPLATES_NAME}    ${job_template_name}
	Capture page screenshot
	Delete a Job template   ${job_template_name}


Check Template information at Overview tab is correctly after migration (OL-T14662)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Click at    ${JOB_TEMPLATES_TAB}
	Input into      ${SEARCH_JOB_TEMPLATE_TEXT_BOX}  ${basic_job_temp}
	Click at    ${JOB_TEMPLATES_NAME}    ${basic_job_temp}
	Overview tab is displayed with full components      False    ${basic_job_temp}


Check Job template information at Hiring Team tab is correctly after migration (OL-T14663, OL-T14664, OL-T14665)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Search and click a job template     ${job_template_migration}
	Click at    Hiring Team
    Verify display exact text    Company Admin
    Verify display exact text    Supervisor
    Verify display exact text    Recruiter
    Verify display exact text    Hiring Manager
    Check element display on screen    Full User
    Capture page screenshot
    # Check Job template information at Candidate Journey tab is correctly after migration (OL-T14664)
	Click at    ${CANDIDATE_JOURNEY_TAB}
	Click at    ${INPUT_CANDIDATE_JOURNEY}
	Check element display on screen     ${CANDIDATE_JOURNEY_IS_SELECTED}    Default Candidate Journey
	Capture page screenshot
	# Check Job template information at Screening tab is correctly after migration (OL-T14665)
    Click at    Screening
    # Check display question free text
    check element display on screen    How old are you?
    # Check display question document upload
    check element display on screen    Could you upload your CV?
    # Check display question List select
    check element display on screen    How many years of experience do you have?
    Capture page screenshot


Check candidate flow when candidate search and apply for a Old job (OL-T14666)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    ...    CA Team
    wait with large time
    add outcome send interview
    Publish job
    Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click at    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name}
    Check element display on screen    ${CANDIDATE_JOURNEY_STATUS}    Interview Scheduled
    Capture page screenshot
    Deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check candidate flow when candidate apply for a Old job via job posting (OL-T14667)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template    Basic Multi-Location    Default Candidate Journey
    ...    EE Team
    wait with large time
    add outcome send interview
    Publish job
    ${job_link} =    Turn on job and get internal job link    ${job_name}    ${test_location_name}
    go to    ${job_link}
    ${candidate_name} =    Candidate finish Job posting
    Check olivia asked phone and candidate input phone
    Go to CEM page
    Switch to user    EE Team
    # Verify candidate has status correclty with outcome action
    Click at    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name.full_name}
    Check element display on screen    ${CANDIDATE_JOURNEY_STATUS}    Interview Scheduled
    Capture page screenshot
    Switch to user    ${TEAM_USER}
    Deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}
