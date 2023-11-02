*** Settings ***
Resource            ../../pages/candidate_summary_builder_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../commons/actions/get_actions.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${section_name}         Work Experience
${form_name}            OL-T11532_work_experience_form
${form_type}            Candidate
${journey_name}         OL-T11532_candidate_journey
${journey_type}         Candidate Journey
${job_family_name}      OL-T11532_job_family
${job_name}             OL-T11532_Automation_Test
${location_name}        Test_Location_1
${workflow_name}        OL-T11532_workflow
${stage_type}           Form
${status}               Send Form
${action}               Send Form
${task_name}            Send form
${age}                  20
${subject_mail}         Your Test Automation Hire On Company Verification Code
&{work_experience}      your_job_title=DEV    company_name=Olivia    location=Da Nang    date_started=01/01/2020    date_end=21/10/2021

*** Test Cases ***
Create data test for testcase OL-T11533, OL-T11532
    Given Setup Test
    When Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # config candidate summary work experience
    Go to Candidate Summary
    ${is_exist}=    run keyword and return status       Check element display on screen     Work Experience
    IF     '${is_exist}'== 'False'
        Add a section       ${section_name}
        Click at    ${CANDIDATE_SUMMARY_SAVE_BUTTON}
        Click at    ${CANDIDATE_SUMMARY_CHANGE_SAVE_BUTTON}
        Check element display on screen     Changes saved successfully.
        capture page screenshot
    END
    Go to form page
    ${is_exist}=    run keyword and return status       Search form in form list    ${form_type}    ${form_name}
    IF      '${is_exist}'== 'False'
        Prepare form for testcase OL-T11532
    END
    ${is_exist}=    run keyword and return status       Click a Journey     ${journey_name}
    IF      '${is_exist}'== 'False'
        Prepare candidate journey for testcase OL-T11532
    END
    ${is_exist}=    run keyword and return status       Open an available workflow      ${workflow_name}
    IF      '${is_exist}'== 'False'
        Prepare workflow for testcase OL-T11532
    END
    # create job family
    ${is_exist}=    run keyword and return status       search job family name      ${job_family_name}
    IF      '${is_exist}'== 'False'
        Create new job family       ${job_family_name}
    END
    # Create job
    Go to Jobs page
    ${is_exist}=    run keyword and return status       search job name     ${job_name}     ${job_family_name}
    IF      '${is_exist}'== 'False'
        ${link_job}=    Prepare job for testcase OL-T11532
    END

*** Keywords ***
Prepare form for testcase OL-T11532
    Go to form page
    Add new form and input name     Candidate       ${form_name}
    Add a form section      ${section_name}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Click publish form

Prepare candidate journey for testcase OL-T11532
    Add a Candidate Journey     ${journey_name}    ${journey_type}
    Click a Journey     ${journey_name}
    Delete a Stage      Rating
    Delete a Stage      Scheduling
    Add a stage     ${stage_type}
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s

Prepare job for testcase OL-T11532
    Create new job with CJ setting send form stage      ${journey_name}      ${job_family_name}    ${form_name}    ${location_name}      job_name=${job_name}
    Go to job outcome section       ${job_name}       ${job_family_name}
    Add new Outcome for job     Send form      Age    At least      Send form     Form: Send Form    20
    Publish job
    Active a job    ${job_name}
    [Return]     ${job_name}

Prepare workflow for testcase OL-T11532
  # create workflow and  add Send form task into Workflow
    Create new workflow and add a task and publish workflow    workflow_name=${workflow_name}    journey_name=${journey_name}     status=${status}       action=${action}   task_name=${task_name}
