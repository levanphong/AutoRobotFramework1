*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/conversation_builder_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${candidate_form}               Candidate
${conversation_follow_up}       Journey_Follow_Up

*** Test Cases ***
Prepare data test on franchise off
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Add a Candidate Journey     ${JOURNEY_CJ_JOURNEY_PERMISSION}
    Click at    ${PUBLISH_STAGE_BUTTON}


Prepare data test franchise on
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Add a Candidate Journey     ${JOURNEY_CJ_JOURNEY_PERMISSION}
    Add a Journey Stage    ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${JOURNEY_OFFER_STATUS}
    Click at    ${PUBLISH_STAGE_BUTTON}


Prepare data test next step company
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Add a Candidate Journey     ${JOURNEY_CJ_JOURNEY_PERMISSION}
	Create new job with Offer    ${job_family_name}    ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${JOURNEY_OFFER}     job_random_name=${JOURNEY_PERMISSION_JOB}
    Active a job    ${JOURNEY_PERMISSION_JOB}       ${JOURNEY_LOCATION}
	Add a Journey Stage    ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${JOURNEY_OFFER_STATUS}
    Add a Stage    ${JOURNEY_CONVERSATION_STATUS}
    Add a Stage    ${JOURNEY_FORM_STATUS}
    Click at    ${PUBLISH_STAGE_BUTTON}
    Create a new offer   None    ${JOURNEY_OFFER}
    Create a new Rating     Candidate    ${JOURNEY_RATING}
    Go to form page
    Add new form and input name     ${candidate_form}       ${JOURNEY_FORM}
    Click publish form
    Go to conversation builder
    when Add new conversation with name and type    ${conversation_follow_up}    Follow Up
    Add a Workflow     ${JOURNEY_PERMISSION_WORKFLOWS}      Custom Workflow     ${JOURNEY_CJ_JOURNEY_PERMISSION}      Candidate
    Remove a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${EE_TEAM}      ${JOURNEY_CONVERSATION_STATUS}
    Remove a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${EE_TEAM}      ${JOURNEY_RATING_STATUS}
    Remove a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${EE_TEAM}      ${JOURNEY_OFFER_STATUS}
    Remove a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_JOURNEY_PERMISSION}    ${EE_TEAM}      ${JOURNEY_FORM_STATUS}

*** Keywords ***
Input status name
    [Arguments]     ${stage}    ${status_name}    ${journey_name}
    Click at    ${STAGE_NAME_IN_JOURNEY}    ${stage}
    ${locator} =    Format String    ${COMMON_INPUT_PLACEHOLDER}    Enter Status Name
    input into    ${locator}       ${status_name}
    Click at        ${COMMON_BUTTON}    Done
    # Return to All stage
    Click on span text      ${journey_name}
