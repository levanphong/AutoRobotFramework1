*** Settings ***
Variables           ../../locators/client_setup_locators.py
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/location_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${standard_job_for_workflow}    workflow standard
${basic_job_for_workflow}       workflow basic
${multi_job_for_workflow}       workflow multi
${multi_job_for_workflow_hm}    workflow multi hm
${wf_audience_ca}               WF Audience CA
${wf_audience_hm_roles}         WF Audience HM Roles
${subject_text}                 workflow test send communication \#candidate-fullname
${content_text}                 Hi \#recruiter-name, auto_text_send_communication
${subject_condition}            workflow test send condition    \#candidate-fullname
${content_condition}            Hi \#recruiter-name, auto_text_condition_email
${cj_job_internal}              cj_job_internal

*** Test Cases ***
Prepare Job Internal / Workflow Data test franchise on
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Enable Client Setup for Job Internal / Workflow     More
    Enable Client Setup for Job Internal / Workflow     Hire
    Enable Client Setup for Job Internal / Workflow     Multilingual
    Enable Client Setup for Job Internal / Workflow     Job Search
    Add a Location      ${COMPANY_FRANCHISE_ON}     ${LOCATION_AMSTERDAM}
    Add a Candidate Journey     ${cj_job_internal}
    Create new job without Job template     ${JOB_PAGE_STANDARD}    ${cj_job_internal}      ${CA_ROLE_WORKFLOW}     job_random_name=${standard_job_for_workflow}
    Active a job    ${standard_job_for_workflow}    ${LOCATION_AMSTERDAM}
    Create new job without Job template     ${BASIC_MULTI_LOCATION}     ${cj_job_internal}      ${CA_ROLE_WORKFLOW}     job_random_name=${basic_job_for_workflow}
    Active a job    ${basic_job_for_workflow}       ${LOCATION_AMSTERDAM}
    Create new job without Job template     ${JOB_PAGE_MULTI_LOCATION}      ${cj_job_internal}      ${CA_ROLE_WORKFLOW}     job_random_name=${multi_job_for_workflow}
    Active a job    ${multi_job_for_workflow}       ${LOCATION_AMSTERDAM}
    Create new job without Job template     ${JOB_PAGE_MULTI_LOCATION}      ${cj_job_internal}      ${CA_ROLE_WORKFLOW}     role=${RECRUITER}       job_random_name=${multi_job_for_workflow_hm}
    Active a job    ${multi_job_for_workflow_hm}    ${LOCATION_AMSTERDAM}
    Create a new Rating     User    ${RATING_WORKFLOW}
    Create workflows for job internal       ${CA_ROLE_WORKFLOW}     ${wf_audience_ca}
    Create workflows for job internal       ${HM}       ${wf_audience_hm_roles}


Prepare Job Internal / Workflow Data test franchise off
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Add a Candidate Journey     ${cj_job_internal}
    Create a new Rating     User    ${RATING_WORKFLOW}

*** Keywords ***
Enable Client Setup for Job Internal / Workflow
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'More'
        Click at    ${MORE_LABEL}
        Turn on    ${WORKFLOWS_TOGGLE}
        Turn on    ${RATINGS_TOGGLE}
        Turn on    ${TIMED_TRIGGERS_TOGGLE}
    ELSE IF    '${item}' == 'Hire'
        Click at    ${HIRE_LABEL}
        Turn on    ${OLIVIA_HIRE_TOGGLE}
        Turn on    ${JOBS_TOGGLE}
        Turn on    ${CANDIDATE_JOURNEYS_TOGGLE}
        Click at    ${AVAILABLE_JOB_TYPES_DROPDOWN}
        Click at    ${AVAILABLE_JOB_SELECT_ALL_CHECKBOX}
        Click at    ${AVAILABLE_JOB_APPLY_BUTTON}
    ELSE IF    '${item}' == 'Multilingual'
        Click at    ${MULTILINGUAL_LABEL}
        Turn on    ${PLATFORM_LANGUAGE_TOGGLE}
        Click at    ${LANGUAGES_SUPPORTED_DROPDOWN}
        Click at    ${SPANISH_ES_SUPPORTED_CHECKBOX}
    ELSE IF    '${item}' == 'Job Search'
        Click at    ${JOB_SEARCH_LABEL}
        Turn on    ${JOB_SEARCH_TOGGLE}
        Click at    ${JS_ENV_SELECTION}
        Click at    ${JS_ENV_VALUE}    Staging
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END

Turn off Hire Toggle on Client Setup for Job Internal / Workflow
    Navigate to    Client Setup
    Click at    ${HIRE_LABEL}
    Turn off    ${OLIVIA_HIRE_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END

Turn off Multilingual Toggle on Client Setup for Job Internal / Workflow
    Navigate to    Client Setup
    Click at    ${MULTILINGUAL_LABEL}
    Turn off    ${PLATFORM_LANGUAGE_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END

Create workflows for job internal
    [Arguments]   ${user_role}     ${workflow_name}
    Add a Workflow    ${workflow_name}       Custom Workflow     ${cj_job_internal}      ${user_role}
    wait element visible    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Add a Send communication Action into Workflow      Invite to Interview    ${subject_text}     ${content_text}
    Click at    ${SAVE_TASK_BUTTON}
    Add a Send Condition Action into Workflow    ${subject_condition}     ${content_condition}    Candidate First Name    Contains    ${candidate_fist_name}
    Click at    ${SAVE_TASK_BUTTON}
    Add a Send Rating Action into Workflow    ${RATING_WORKFLOW}      Send Rating      workflow test send rating \#candidate-fullname
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    [Return]    ${workflow_name}
