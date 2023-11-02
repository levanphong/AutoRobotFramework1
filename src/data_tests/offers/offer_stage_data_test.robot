*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${test_location_name}       ${CONST_LOCATION}
${offer_name}               Offer for Expiration and Canceled Statuses
${cj_name}                  Candidate Journey for Offer Stage
${job_name}                 Job For Offer Stage
${wf_name}                  Workflow for Offer Stage
${next_steps_button}        Two new statuses of Offer

*** Test Cases ***
Create data test for Offer stage 1
    # Setup for "COMPANY_DATA_PACKAGE_OFF"
    Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create Candidate Journey Has Offer Stage    ${cj_name}
    Create A New Offer      None    ${offer_name}
    Create New Job With Offer       ${JF_COFFEE_FAMILY_JOB}     ${cj_name}      ${offer_name}       job_name=${job_name}
    Go To My Jobs Page
    Active A Job    ${job_name}
    Add A Workflow      ${wf_name}      Custom Workflow     ${cj_name}      None
    Add A Send Offer Stage For Workflow     ${wf_name}


Create data test for Offer stage 2
    # Setup for "COMPANY_APPLICANT_FLOW"
    Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Create Candidate Journey Has Offer Stage    ${cj_name}
    Create A New Offer      None    ${offer_name}
    Add A Workflow      ${wf_name}      Custom Workflow     ${cj_name}      None
    Add A Send Offer Stage For Workflow     ${wf_name}


Create data test for Offer stage 3
    # Setup for "COMPANY_NEXT_STEP"
    Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    ${list_next_step_stage} =       Create List     ${JOURNEY_EXPIRED_OFFER_ACTION}     ${JOURNEY_CANCEL_OFFER_ACTION}
    Create Candidate Journey Has Offer Stage    ${cj_name}
    Add Next Step For Journey Stage And Publish
    ...     Offer
    ...     Offer Accepted
    ...     next_step_bt_name=${next_steps_button}
    ...     next_step_status=${list_next_step_stage}
    ...     multi_status=True
    Create A New Offer      None    ${offer_name}
    Create New Job With Offer       ${JF_COFFEE_FAMILY_JOB}     ${cj_name}      ${offer_name}       job_name=${job_name}
    Go To My Jobs Page
    Active A Job    ${job_name}
    Add A Workflow      ${wf_name}      None    ${cj_name}      None
    Add A Send Offer Stage For Workflow     ${wf_name}

*** Keywords ***
Add a send offer stage for workflow
    [Arguments]     ${wf_name}
    Go to Workflows page
    Click at    ${wf_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    Input into    ${WF_TASK_NAME_TEXTBOX}    Send Offer for Candidates
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
