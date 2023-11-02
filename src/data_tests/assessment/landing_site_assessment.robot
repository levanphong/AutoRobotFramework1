*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/web_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${cj_name}              cj assessment
${conv_name}            conv for assessment
${wf_name}              wf for assessment
${site_name}            wm for assessment

${cj_name_form}         cj assessment with form
${conv_name_form}       conv for assessment with form
${wf_name_form}         wf for assessment with form
${site_name_form}       wm for assessment with form

*** Test Cases ***
Create hire conversation and job family for assessment in landing site
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create hire conversation and job family     ${cj_name}      ${JOB_PROGRAMMER}       ${wf_name}      ${conv_name}    ${site_name}


Create hire conversation and job family for assessment Share Assessment Results in landing site
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Create hire conversation and job family     ${cj_name}      ${JOB_PROGRAMMER}       ${wf_name}      ${conv_name}    ${site_name}


Prepare Data With Stage Assessment And Form when Do not Share Assessment Results in landing site
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create hire conversation and job family     ${cj_name_form}     ${JOB_FARMER}       ${wf_name_form}     ${conv_name_form}       ${site_name_form}       True


Prepare Data With Stage Assessment And Form when Share Assessment Results in landing site
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Create hire conversation and job family     ${cj_name_form}     ${JOB_FARMER}       ${wf_name_form}     ${conv_name_form}       ${site_name_form}       True

*** Keywords ***
Add a workflow for assessment
    [Arguments]     ${workflow_name}    ${journey_name}     ${is_send_form}=False
    Add a Workflow  ${workflow_name}    Custom Workflow     ${journey_name}
    Add a Task into Workflow    ${SEND_ASSESSMENT}
    Click at        ${SAVE_TASK_BUTTON}
    IF  '${is_send_form}' == 'True'
        Add a Task into Workflow    ${SEND_FORM}
    END
    Click at        ${SAVE_TASK_BUTTON}
    Click at      ${PUBLISH_WORKFLOW_BUTTON}

Create hire conversation and job family
    [Arguments]    ${candidate_journey_name}    ${job_name}     ${workflow_name}    ${conversation_name}    ${web_management_name}      ${is_stage_form}=False
    Add a Candidate Journey     ${candidate_journey_name}
    Add a Journey Stage     ${candidate_journey_name}      Assessment
    IF  '${is_stage_form}' == 'True'
        Add a Journey Stage     ${candidate_journey_name}      Form
    END
    Publish a Journey       ${candidate_journey_name}
    Go to Jobs page
    ${check} =      Run Keyword And Return Status       Check Element Display On Screen     ${JOB_FAMILY_NAME_AT_MAIN}      ${JF_FOR_ASSESSMENT}
    IF  '${check}' == 'False'
        Create new job family       ${JF_FOR_ASSESSMENT}
    END
    Create new job, publish and turn on my job      ${JF_FOR_ASSESSMENT}    ${job_name}       ${LOCATION_NAME_2}      ${CP_ADMIN}     ${candidate_journey_name}      ${CP_ADMIN}
    Turn on a Job       ${job_name}
    Go to job outcome section       ${job_name}       ${JF_FOR_ASSESSMENT}
    Add outcome move to status      ${SEND_ASSESSMENT}
    Publish job
    IF  '${is_stage_form}' == 'True'
        Add a workflow for assessment    ${workflow_name}      ${candidate_journey_name}     True
    ELSE
        Add a workflow for assessment    ${workflow_name}      ${candidate_journey_name}
    END
    ${is_existing}=     Check conversation name is existing      ${conversation_name}
    IF  '${is_existing}' == 'False'
        Add Hire conversation       ${conversation_name}
        Public the conversation
    END
    Go to Web Management
    Click at    ${ADD_NEW_WEB_BUTTON}
    Click at    ${WEB_SITE_TYPE}    Landing Site    1s
    Click at    ${NEXT_BUTTON_SELECT_SITE}
    Input into      ${SITE_NAME_WEB_WIDGET}     ${web_management_name}
    Assign the conversation to the landing site/widget site     ${conversation_name}

