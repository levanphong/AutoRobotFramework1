*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Setup          Setup for every Test case
Test Teardown       Close Browser

Force Tags          stg


*** Variables ***
${job_family_name}      Coffee Jobs


*** Test Cases ***
Prepare data for next steps CJ
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new candidate journey and publish    ${CJ_HAS_NO_NEXT_STEP}
    Create new job, publish and turn on my job
    ...    ${job_family_name}
    ...    ${JOB_HAS_NO_NEXT_STEP}
    ...    ${JOB_NEXT_STEP_LOCATION}
    ...    None
    ...    ${CJ_HAS_NO_NEXT_STEP}
    Create new candidate journey and publish    ${CJ_HAS_TWO_NEXT_STEP}    stage=Custom
    Input status name    Custom    ${TO_CUSTOM_TITLE_1}    ${CJ_HAS_TWO_NEXT_STEP}
    Input status name    Custom    ${TO_CUSTOM_TITLE_2}    ${CJ_HAS_TWO_NEXT_STEP}
    Add next step for journey stage and publish
    ...    Capture
    ...    Capture Complete
    ...    next_step_des=${NEXT_STEP_DES}
    ...    next_step_bt_name=${NEXT_BUTTON_TO_INTERVIEW}
    ...    next_step_status=${NEXT_BUTTON_TO_INTERVIEW}
    # Create next step button with one stage
    ${list_next_status_single_stage}=    Create List    ${TO_CUSTOM_TITLE_1}    ${TO_CUSTOM_TITLE_2}
    Add next step for journey stage and publish
    ...    Capture
    ...    Capture Complete
    ...    next_step_des=None
    ...    next_step_bt_name=${NEXT_BUTTON_TO_CUSTOM}
    ...    next_step_status=${list_next_status_single_stage}
    ...    multi_status=True
    # Create next step button with two stage
    ${list_next_status_multi_stage}=    Create List
    ...    ${NEXT_BUTTON_TO_INTERVIEW}
    ...    ${TO_CUSTOM_TITLE_1}
    ...    ${TO_CUSTOM_TITLE_2}
    Add next step for journey stage and publish
    ...    Capture
    ...    Capture Complete
    ...    next_step_des=None
    ...    next_step_bt_name=${NEXT_BUTTON_TO_TWO_STAGE}
    ...    next_step_status=${list_next_status_multi_stage}
    ...    multi_status=True
    Capture Page Screenshot
    Create new job, publish and turn on my job
    ...    ${job_family_name}
    ...    ${JOB_HAS_TWO_NEXT_STEP}
    ...    ${JOB_NEXT_STEP_LOCATION}
    ...    None
    ...    ${CJ_HAS_TWO_NEXT_STEP}
    Active a job    ${JOB_HAS_NO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    Active a job    ${JOB_HAS_TWO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    Switch to user    ${EE_TEAM}
    Active a job    ${JOB_HAS_NO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    Active a job    ${JOB_HAS_TWO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
