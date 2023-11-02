*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare data
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Add a Candidate Journey     ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
	Add a Journey Stage    ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${JOURNEY_OFFER_STATUS}
    Add a Stage    ${JOURNEY_CONVERSATION_STATUS}
    Add a Stage    ${JOURNEY_FORM_STATUS}
    Click at    ${PUBLISH_STAGE_BUTTON}
