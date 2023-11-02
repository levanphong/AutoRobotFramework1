*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          test

*** Test Cases ***
Prepare data for CEM form cancelled
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add a Candidate Journey     ${AUTO_CJ_SEND_FORM}
    Add a stage     ${JOURNEY_FORM_STATUS}
    Publish a Journey       ${AUTO_CJ_SEND_FORM}
    Add a Workflow      ${WF_SEND_FORM}     Custom Workflow     ${AUTO_CJ_SEND_FORM}    Candidate
    Add a Task into Workflow    Send Form       None    Send Form
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Go to form page
    ${form_is_existed} =    Run Keyword And Return Status    Check if form existed    ${FORM_NOT_REQUIRED_PHONE}
    IF  '${form_is_existed}' == 'False'
        Add new form and input name     ${CANDIDATE_FORM_TYPE}      ${FORM_NOT_REQUIRED_PHONE}
    END
    Go to a form section detail     Personal Information
    Click at    ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     Phone number
    Click save task
    Click publish form
    Create new job with Location and CJ and Form    ${JF_COFFEE_FAMILY_JOB}       ${FORM_NOT_REQUIRED_PHONE}      ${JOB_CANDIDATE_SEND_FORM}      ${LOCATION_A}     ${AUTO_CJ_SEND_FORM}    ${JOURNEY_SEND_FORM_ACTION}


Prepare data for CEM Application cancelled
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add a Candidate Journey     ${AUTO_CJ_SEND_APPLICATION}
    Add a stage     ${JOURNEY_APPLICATION_STAGE}
    Publish a Journey       ${AUTO_CJ_SEND_APPLICATION}
    Add a Workflow      ${WF_SEND_APPLICATION}      Custom Workflow     ${AUTO_CJ_SEND_APPLICATION}     Candidate
    Add a Task into Workflow    Send Application    None    Send Application
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Create new job with Location and CJ and Form    ${JF_COFFEE_FAMILY_JOB}       ${FORM_NOT_REQUIRED_PHONE}      ${JOB_CANDIDATE_SEND_APPLICATION}       ${LOCATION_A}     ${AUTO_CJ_SEND_APPLICATION}     ${JOURNEY_SEND_APPLICATION_ACTION}      ${JOURNEY_APPLICATION_STAGE}


Prepare data for CEM OnBoarding cancelled
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add a Candidate Journey     ${AUTO_CJ_SEND_ON_BOARDING}
    Add a stage     ${JOURNEY_ON_BOARDING_STAGE}
    Publish a Journey       ${AUTO_CJ_SEND_ON_BOARDING}
    Add a Workflow      ${WF_SEND_ON_BOARDING}      Custom Workflow     ${AUTO_CJ_SEND_ON_BOARDING}     Candidate
    Add a Task into Workflow    Send Onboarding     None    Send Onboarding
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Create new job with Location and CJ and Form    ${JF_COFFEE_FAMILY_JOB}       ${FORM_NOT_REQUIRED_PHONE}      ${JOB_CANDIDATE_SEND_ON_BOARDING}       ${LOCATION_A}     ${AUTO_CJ_SEND_ON_BOARDING}     ${JOURNEY_SEND_ON_BOARDING_ACTION}      ${JOURNEY_ON_BOARDING_STAGE}


Prepare data for CEM OnBoarding Custom Form
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to form page
    ${form_is_existed} =    Run Keyword And Return Status    Check if form existed    ${FORM_NOT_REQUIRED_PHONE}
    IF  '${form_is_existed}' == 'False'
        Add new form and input name     ${CANDIDATE_FORM_TYPE}      ${FORM_NOT_REQUIRED_PHONE}
    END
    Click publish form
    Create new job with Location and CJ and Form    ${JF_COFFEE_FAMILY_JOB}       ${OL_T23984_CUSTOM_FORM}    ${JOB_CANDIDATE_CUSTOM_FORM}    ${LOCATION_A}     ${AUTO_CJ_SEND_ON_BOARDING}     ${JOURNEY_SEND_ON_BOARDING_ACTION}      ${JOURNEY_ON_BOARDING_STAGE}
