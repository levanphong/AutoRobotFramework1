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
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${auto_job_name}     auto_job

*** Test Cases ***
Check UI of Jobs tab (OL-T15756)
	Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Click at    ${JOBS_TAB}
	# Verify Header job family
	Check element display on screen     ${JOBS_TAB_CONTENT_TITLE}    Jobs
	Check element display on screen     Create and edit Job Families and Jobs
	# Verify Ellipse icon with 2 options
	Click at    ${JOB_FAMILY_ECLIPSE_ICON}      ${job_family_name}
	Check element display on screen    ${JOB_COUNT_SEARCH}
	Check element display on screen     ${JOB_ECLIPSE_POPUP_EDIT_FAMILY_TEXT}
	Check element display on screen     ${JOB_ECLIPSE_POPUP_DELETE_FAMILY_TEXT}


Check if user can delete job family if there is job added under it (OL-T15761, OL-T15757)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
	wait with large time
	# Verify Couldn’t Delete Job Family
	Delete a job family     ${job_family_name}
	Check element display on screen      Couldn’t Delete Job Family
	Check element display on screen      You must move jobs in this job family to another job family before deleting this job family.
	Reload page
	Delete a Job    ${job_name}     ${job_family_name}


Check each Job Family (OL-T15759)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${name} =      Generate random name       ${auto_job_name}
	Create new job family       ${name}
	${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
	wait with medium time
	Go to Jobs page
	# Verify No down-arrow icon on Job family
	Check element display on screen       ${JOB_FAMILY_NAME_AT_MAIN}      ${name}
	Check element not display on screen    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${name}
	# Verify have down-arrow icon next to the Job family
	Check element display on screen    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}
	# Verify show job added under ${job_family_name} job family
	Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=2s
    Check element display on screen     ${JOBS_NAME}    ${job_name}
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a job family     ${name}


Check if user can edit Job Family (OL-T15760, OL-T15762)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	${name} =      Generate random name       ${auto_job_name}
	${edit_name} =      Generate random name       ${name}
    Create new job family       ${name}
    wait with medium time
    Edit name job family    ${name}     ${edit_name}
    Check element display on screen       ${JOB_FAMILY_NAME_AT_MAIN}      ${edit_name}
	Delete a job family     ${edit_name}
	Check element not display on screen     ${edit_name}


Check Job in job page (OL-T15763, OL-T15764)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
    ${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
    wait with large time
    Go to Jobs page
    Verify Job in Job page is displayed correctly    ${job_name}    ${job_family_name}      Published
    Delete a Job    ${job_name}     ${job_family_name}


Check if user select Edit Job under ellipse icon (OL-T15765)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey      CA Team
    Go to Jobs page
    search job name     ${job_name}      ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    #   Verify open Job page details success
    Check element display on screen    ${JOB_NAME_ON_HEADER}    ${job_name}
    Delete a Job     ${job_name}    ${job_family_name}


Check Archive Job option for Draft job (OL-T15768)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${job_name} =    Create new job      ${job_family_name}      ${auto_job_name}
	wait with medium time
	Go to Jobs page
	Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
	Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=2s
    Click at       ${JOB_ECLIPSE_ICON}  ${job_name}
    Check element not display on screen  ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    Delete a Job    ${job_name}     ${job_family_name}


Check if user select Delete Job under ellipse icon (OL-T15769)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey      CA Team
    Active a job    ${job_name}
    Go to Jobs page
    search job name     ${job_name}      ${job_family_name}
    wait for page load successfully v1
    Click at    ${JOB_ECLIPSE_ICON}  ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    # Verify show popup tells user cannot delete job
    Check element display on screen     Cannot Delete This Job
    Check element display on screen     You must turn off all locations for this job in My Jobs before you can delete it
    Check element display on screen     ${test_location_name}
    Check element display on screen     Go to My Jobs
    Deactivate a job    ${job_name}
    # Verify show popup to confirm if user wants to delete this job
    Delete a Job        ${job_name}    ${job_family_name}


Check if user select Move to another family under ellipse icon (OL-T15770)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${new_job_family_name} =      Generate random name       ${auto_job_name}
    Create new job family       ${new_job_family_name}
	${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
    wait with large time
    Go to Jobs page
    Move job to another job family      ${new_job_family_name}    ${job_name}
    Click at        ${JOB_FAMILY_NAME_AT_MAIN}      ${new_job_family_name}
    Check element display on screen    ${JOBS_NAME}    ${job_name}
    Delete a Job     ${job_name}    ${new_job_family_name}
    Delete a job family     ${new_job_family_name}


Check UI when opening Jobs under Setting menu (OL-T15755, OL-T15771)
	Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Check element display on screen     ${JOBS_TAB}
	Check element display on screen     ${JOB_TEMPLATES_TAB}
	Check element display on screen     ${SEARCH_JOB_TEXT_BOX}
	Click at    ${ICON_ARROW_DOWN}
	Check element display on screen     ${NEW_JOB_BUTTON}
	Check element display on screen     ${NEW_JOB_TEMPLATE_BUTTON}
	Check element display on screen     New Job Family


Check if user select New Job family (OL-T15772)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Click at        ${ICON_ARROW_DOWN}
	Click at     New Job Family
	Check element display on screen   Create Job Family
	Check element display on screen   Job Family Name
    Check element display on screen     ${INPUT_JOB_FAMILY_ON_POPUP}
	Check element display on screen   ${JOB_FAMILY_CANCE_BUTTON_POPUP}
	Reload page
	${job_family_random_name} =      Generate random name       ${auto_job_name}
    Create new job family       ${job_family_random_name}
	Check element display on screen      ${JOB_FAMILY_NAME_AT_MAIN}     ${job_family_random_name}
	Delete a job family     ${job_family_random_name}


Check if user select New Job (OL-T15773)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_BUTTON}
    # Check Show all available job types
    Check element display on screen     ${TYPE_BASIC_MULTI_LOCATION}
    Check element display on screen     ${TYPE_MULTI_LOCATION}
    Check element display on screen     ${TYPE_STANDARD_LOCATION}
    Click at    ${TYPE_BASIC_MULTI_LOCATION}
    Check element display on screen      Easily create the same job at multiple locations. Jobs can be turned on/off per location whenever you need candidates. This job uses basic hiring team assignment.
    Check element display on screen     ${BLANK_JOB}
    Check element display on screen     ${JOBS_TEMPLATE_NAME_ON_MODAL}  ${basic_job_temp}
    Click at    ${TYPE_MULTI_LOCATION}
    Check element display on screen      Easily create the same job at multiple locations. Jobs can be turned on/off per location whenever you need candidates.
    Check element display on screen     ${BLANK_JOB}
    Check element display on screen     ${JOBS_TEMPLATE_NAME_ON_MODAL}  ${multi_job_temp}
    Click at    ${TYPE_STANDARD_LOCATION}
    Check element display on screen      Create a single job that can be turned on/off whenever you need candidates.
    Check element display on screen     ${BLANK_JOB}
    Check element display on screen     ${JOBS_TEMPLATE_NAME_ON_MODAL}   ${standard_job_temp}


Check if user select Archive Job under ellipse icon (OL-T15767, OL-T15774)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
    wait with medium time
    Active a job    ${job_name}
    Go to Jobs page
    search job name     ${job_name}     ${job_family_name}
    wait for page load successfully v1
    Click at  ${JOB_ECLIPSE_ICON}  ${job_name}
    Click at  ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    # Verify show popup tells user cannot Archive job
    Check element display on screen     Cannot Archive This Job
    Check element display on screen     You must turn off all locations for this job in My Jobs before you can archive it
    Check element display on screen     ${test_location_name}
    Check element display on screen     Go to My Jobs
    # Verify show popup to confirm if user wants to Archive this job
    Deactivate a job    ${job_name}
    Archive a job       ${job_name}
    Delete a Job        ${job_name}    ${job_family_name}


Check if user select Duplicate Job under ellipse icon (OL-T15766, OL-T15776)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job without Job template     Basic Multi-Location     Default Candidate Journey
    wait with short time
    Duplicate a job     ${job_name}
    ${copy_job_name} =       Set variable        auto_copy_${job_name}
    Verify Job in Job page is displayed correctly       ${copy_job_name}    ${job_family_name}      Draft
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a Job    ${copy_job_name}     ${job_family_name}


Check if user select New Job Template (OL-T15777)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Veify show Job Template page is correctly   ${TYPE_STANDARD_LOCATION}    New Standard Job Template
	Veify show Job Template page is correctly   ${TYPE_MULTI_LOCATION}       New Multi-Location Job Template
	Veify show Job Template page is correctly   ${TYPE_BASIC_MULTI_LOCATION}       New Basic Multi-Location Job Template


Check UI of Job Templates page (OL-T15778)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	Click at    ${JOB_TEMPLATES_TAB}
    Check element display on screen     ${JOBS_TAB_CONTENT_TITLE}    Job Templates
    Check element display on screen     Create and edit job templates
    Check element display on screen     ${SEARCH_JOB_TEMPLATE_TEXT_BOX}
    Check element display on screen     Basic_template
    Check element display on screen     ${CREATE_NEW_TEMPLATE_BUTTON}


Check Search field (OL-T15780)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
    Click at    ${JOB_TEMPLATES_TAB}
    Input into  ${SEARCH_JOB_TEMPLATE_TEXT_BOX}  ${basic_job_temp}
    Check element display on screen   ${basic_job_temp}

*** Keywords ***
Veify show Job Template page is correctly
    [Arguments]     ${job_type}     ${text}
    Go to Jobs page
	Click at    ${ICON_ARROW_DOWN}
	Click at     ${NEW_JOB_TEMPLATE_BUTTON}
	Click at    ${job_type}
    Click at        ${SAVE_JOB_TEMPLATE_ON_MODAL}
    Check element display on screen      ${text}

Verify Job in Job page is displayed correctly
    [Arguments]     ${job_name}     ${job_family_name}      ${job_status}
    Input into  ${SEARCH_JOB_TEXT_BOX}  ${job_name}
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}   ${job_family_name}    slow_down=2s
    wait for page load successfully v1
    Check element display on screen     ${JOBS_NAME}    ${job_name}
    Check element display on screen     ${test_location_name}
    Check element display on screen     ${job_type_basic_text}
    Click at       ${JOB_ECLIPSE_ICON}  ${job_name}
    Check element display on screen     ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    Check element display on screen     ${JOB_ECLIPSE_POPUP_DUPLICATE_JOB_BUTTON}
    Check element display on screen     ${JOB_ECLIPSE_POPUP_MOVE_JOB_BUTTON}
    Check element display on screen     ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    Check element display on screen     ${JOB_STATUS_ON_JOB_PAGE}    ${job_status}
