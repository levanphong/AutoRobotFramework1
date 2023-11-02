*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/jobs_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare Workflow Data test franchise on
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add a Workflow      ${workflow_add_condition}       Custom Workflow     ${CJ_WORKFLOW}      Candidate
    Add condition into Workflow Task    Candidate First Name    Contains    Workflow_Condition
    Click On Span Text      ${edit_condition_criteria_button}
    Add a Send Condition Action into Workflow       ${subject_condition_number}     ${content_condition_number}     Candidate Last Name     Equals      12345
    Click On Span Text      ${edit_condition_criteria_button}
    Add a Send Condition Action into Workflow       ${subject_condition_is_empty}       ${content_condition_is_empty}       Phone Number    Is empty
    Click On Span Text      ${edit_condition_criteria_button}
    Add a Send Condition Action into Workflow       ${subject_condition_number}     ${content_condition_number}     Phone Number    Is not empty
    Click At    ${SAVE_TASK_BUTTON}
    Click At    ${PUBLISH_WORKFLOW_BUTTON}
    Create new job without Job template     job_type=Basic Multi-Location       cj_name=${CJ_WORKFLOW}      hiring_team_name=${CP_ADMIN}    job_random_name=${workflow_add_condition_job}       location=${LOCATION_AMSTERDAM}
    Active a job    ${workflow_add_condition_job}       ${LOCATION_AMSTERDAM}


Prepare Workflow Data test franchise off
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Enable Multilingual in Client Setup
    Add a Candidate Journey     ${CJ_WORKFLOW}
    Add A Group     ${CJ_WORKFLOW}      None    ${group_name}
    Add a Workflow      ${workflow_add_condition}       Custom Workflow     ${CJ_WORKFLOW}      Candidate
    Add a Send Condition Action into Workflow       ${subject_condition_assigned_location}      ${content_condition_assigned_location}      Assigned Location       Is any of       ${LOCATION_HAWAII_ISLAND}
    Click On Span Text      ${edit_condition_criteria_button}
    Add a Send Condition Action into Workflow       ${subject_condition_assigned_group}     ${content_condition_assigned_group}     ${WF_TARGETING_RULE_GROUP}      Is      ${group_name}


Prepare Workflow Data test next step
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Enable Multilingual in Client Setup
    Add a Candidate Journey     ${CJ_WORKFLOW}
    Add a Workflow      ${workflow_add_condition}       Custom Workflow     ${CJ_WORKFLOW}      Candidate
    Add condition into Workflow Task    Candidate First Name    Contains    Workflow_Condition
    Click At    ${SAVE_TASK_BUTTON}
    Click At    ${PUBLISH_WORKFLOW_BUTTON}
    Create new job without Job template     job_type=Basic Multi-Location       cj_name=${CJ_WORKFLOW}      hiring_team_name=${CP_ADMIN}    job_random_name=${workflow_add_condition_job}       location=${LOCATION_NAME_2}
    Active a job    ${workflow_add_condition_job}       ${LOCATION_NAME_2}

*** Keywords ***
Enable Multilingual in Client Setup
    Navigate to    Client Setup
    Click at    ${MULTILINGUAL_LABEL}
    Turn on    ${PLATFORM_LANGUAGE_TOGGLE}
    Click at    ${LANGUAGES_SUPPORTED_DROPDOWN}
    Click at    ${SPANISH_ES_SUPPORTED_CHECKBOX}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with short time
