*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare data
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Add a Candidate Journey     ${JOURNEY_CJ_NEXT_STEP_BUILDER}
	Add stages for Candidate Journey        ${JOURNEY_CJ_NEXT_STEP_BUILDER}
	Add a Location    ${COMPANY_NEXT_STEP}    ${JOURNEY_LOCATION}
    Create new job without Job template    Basic Multi-Location    ${JOURNEY_CJ_NEXT_STEP_USER_FORM}   ${CP_ADMIN}    None    None    ${JOURNEY_NEXT_STEP_BUILDER_JOB}
    Active a job    ${JOURNEY_NEXT_STEP_BUILDER_JOB}       ${JOURNEY_LOCATION}

*** Keywords ***
Add stages for Candidate Journey
    [Arguments]     ${journey_name}
    Add a Journey Stage    ${journey_name}    ${JOURNEY_OFFER_STATUS}
    Add a stage        ${JOURNEY_FORM_STATUS}
    Add a stage        Application
    Add a stage        Background Check
    Add a stage        Conversation
    Add a stage        Disposition
    Input status name       Disposition     Disposition status      ${journey_name}
    Add a stage        Custom
    Input status name       Custom      Custom status       ${journey_name}
    Add a stage        Hire
    Add a stage        Onboarding
    Add a stage        Scheduling - 2nd Round
    Add a stage        Scheduling - 3rd Round
    Add a stage        Scheduling - 4th Round
    Add a stage        Scheduling - 5th Round
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s
