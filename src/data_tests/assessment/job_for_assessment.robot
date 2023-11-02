*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/base_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${recruiting_site}      CA Team's Recruiting Site

*** Test Cases ***
Create hire conversation and job family for assessment
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Add Hire conversation       conversation for assessment
    Public the conversation
    Go to Jobs page
    ${check} =      Run Keyword And Return Status       Check Element Display On Screen     ${JOB_FAMILY_NAME_AT_MAIN}      ${JF_FOR_ASSESSMENT}
    IF  '${check}' == 'False'
        Create new job family       ${job_familly}
    END
    Go to Web Management
    ${check} =      Run Keyword And Return Status       Check Element Display On Screen     ${SEARCH_WEB_PAGE}     ${recruiting_site}
    IF  '${check}' == 'True'
        Input into      ${SEARCH_WEB_PAGE}     ${recruiting_site}
    END
    Click at    ${recruiting_site}
    Assign the conversation to the landing site/widget site     conversation for assessment


Prepare data test for test assessment
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create job for test assessment      candidate journey for assessment    ${JOB_DOCTOR}       ${JF_FOR_ASSESSMENT}    ${LOCATION_NAME_2}
    Add a workflow for test assessment      wf assessment text      candidate journey for assessment


Create hire conversation and job family for assessment with share Assessment Results
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Add Hire conversation       conversation for assessment
    Public the conversation
    Go to Jobs page
    ${check} =      Run Keyword And Return Status       Check Element Display On Screen     ${JOB_FAMILY_NAME_AT_MAIN}      ${JF_FOR_ASSESSMENT}
    IF  '${check}' == 'False'
        Create new job family       ${job_familly}
    END
    Go to Web Management
    ${check} =      Run Keyword And Return Status       Check Element Display On Screen     ${SEARCH_WEB_PAGE}     ${recruiting_site}
    IF  '${check}' == 'True'
        Input into      ${SEARCH_WEB_PAGE}     ${recruiting_site}
    END
    Click at    ${recruiting_site}
    Assign the conversation to the landing site/widget site     conversation for assessment

Prepare data test for test assessment with share Assessment Results
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Create job for test assessment      candidate journey for assessment    ${JOB_DOCTOR}       ${JF_FOR_ASSESSMENT}    ${LOCATION_NAME_2}
    Add a workflow for test assessment      wf assessment text      candidate journey for assessment

*** Keywords ***
Create job for test assessment
    [Arguments]     ${journey_name}     ${job_name}     ${job_familly}   ${location}
    Add a Candidate Journey    ${journey_name}
    Add stages for Candidate Journey        ${journey_name}
    Create new job, publish and turn on my job      ${job_familly}     ${job_name}     ${location}    Company Admin    ${journey_name}  Company Admin      Send Assessment
    Turn on a Job   ${job_name}

Add stages for Candidate Journey
    [Arguments]     ${journey_name}
    Add a Journey Stage    ${journey_name}    ${JOURNEY_ASSESSMENT}
    Add a Journey Stage    ${journey_name}    ${JOURNEY_FORM_STATUS}
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s

Add a workflow for test assessment
    [Arguments]     ${workflow_name}    ${journey_name}    ${audience}=None
    Add a Workflow  ${workflow_name}    Custom Workflow     ${journey_name}     ${audience}
    Add a Task into Workflow    Send Assessment
    Click at    ${SAVE_TASK_BUTTON}
    Add a Task into Workflow    Send Form
    Click at    ${SAVE_TASK_BUTTON}
    Click at      ${PUBLISH_WORKFLOW_BUTTON}
