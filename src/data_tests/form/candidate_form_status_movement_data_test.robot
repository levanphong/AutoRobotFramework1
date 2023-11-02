*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${status_movement_form_a}       Status_Movement_Form_A
${status_movement_form_b}       Status_Movement_Form_B
${status_movement_form_c}       Status_Movement_Form_C
${status_movement_form_cj}      Status Movement Form Journey
${status_movement_form_wf}      Status Movement Form Workflow
${send_form}                    Send Form
${send_application}             Send Application
${send_onboarding}              Send Onboarding
${send_application_name}        Send Form from Application
${send_onboarding_name}         Send Form from Onboarding
${status_movement_form_job}     Status Movement Form Job
${job_family}                   Coffee Jobs
${location}                     Florida

*** Test Cases ***
Prepare data for Candidate form - Status Movement
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Create 3 forms
    Add a form         ${status_movement_form_a}
    Add a form         ${status_movement_form_b}
    Add a form         ${status_movement_form_c}
    # Create candidate journey with 4 stages Form, Application, Onboarding, Hire
    Add a Candidate Journey      ${status_movement_form_cj}
    Add a Journey Stage     ${status_movement_form_cj}      Form
    Add a stage             Application
    Add a stage             Onboarding
    Add a stage             Hire
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s
    # Create work flow send form when status is Send Form, Send Application, Send Onboarding
    Add a Workflow      ${status_movement_form_wf}      None        ${status_movement_form_cj}
    Add send form task to workflow with status      ${send_form}    ${send_form}
    Add send form task to workflow with status      ${send_application_name}      ${send_application}
    Add send form task to workflow with status      ${send_onboarding_name}       ${send_onboarding}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    # Create job form status movement form
    Create job for status movement form     ${status_movement_form_job}

*** Keywords ***
Add a form
    [Arguments]     ${form_name}
    go to form page
    ${form_name}=   Add new form and input name     ${candidate_form}    ${form_name}
    Click publish form

Add send form task to workflow with status
    [Arguments]     ${task_name}    ${status}
    Click at    ${WF_ADD_TASK_BUTTON}
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    ${status}
    Click at    ${STATUS_VALUE}    ${status}
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${SAVE_TASK_BUTTON}

Create job for status movement form
    [Arguments]     ${job_name}
    Go to Jobs page
    simulate input    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    wait with short time
    ${is_job_created} =     Run keyword and Return Status   Check element display on screen     ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family}   wait_time=2s
    IF  '${is_job_created}' == 'False'
        Click at    ${ICON_ARROW_DOWN}
        Click at    ${NEW_JOB_BUTTON}
        Click at    Basic Multi-Location
        Click at    ${NEXT_BUTTON_ON_MODAL}
        Click at    ${INPUT_JOB_FAMILY}
        Click at    ${SELECT_JOBS_FAMILY}    ${job_family}
        Click at    ${SAVE_JOB_ON_MODAL}
        # Redirect to Create Job page
        # Overview step
        input into    ${INPUT_JOB_NAME}    ${job_name}
        Click at    ${SAVE_JOB_BUTTON}
        wait for page load successfully v1
        Add location for job    ${location}
        Add Hiring Team for job
        # Add form for candidate journey
        Set candidate journey and add form
        # Screening step
        Add Screening Question for job
        Click at    ${SAVE_JOB_BUTTON}
        # Publish Job
        Click at    ${ICON_CHEVRON_DOWN}
        Click at    ${NEW_JOB_PUBLISH_BUTTON}
        Active a job    ${job_name}       ${location}
    END

Set candidate journey and add form
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${status_movement_form_cj}
    Click on span text    ${status_movement_form_cj}
    wait for page load successfully
    Add attendee for interview    ${HM}
    Select candidate form for candidate journey     ${status_movement_form_a}
    Select candidate form for candidate journey     ${status_movement_form_b}       Application
    Select candidate form for candidate journey     ${status_movement_form_c}       Onboarding
    Click at    ${SAVE_JOB_BUTTON}
