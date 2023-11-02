*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare data test candidate journey with workflow
    Given Setup test
	When Login into system with company             ${PARADOX_ADMIN}             ${COMPANY_EVENT}
	Go to Candidate Journeys page
	Add a Candidate Journey     ${JOURNEY_CONVERSATION_STAGE}
	Add a Stage   ${JOURNEY_CONVERSATION_STATUS}
	Click at        ${PUBLISH_STAGE_BUTTON}
	Add a Workflow      ${WF_CONVERSATION }    ${CUSTOM_WORKFLOW_TYPE}     ${JOURNEY_CONVERSATION_STAGE}    Candidate
    Add task to workflow with move to status    conversation_complete      Capture Complete        Conversation: Send Conversation
    Add task to workflow with status   conversation_send    Send Conversation
    Add task to workflow with move to status   conversation_inprogress     Conversation In-Progress       Conversation Expired
    Click at    ${PUBLISH_WORKFLOW_BUTTON}

*** Keywords ***
Add task to workflow with status
    [Arguments]     ${task_name}    ${status}
    Click at    ${WF_ADD_TASK_BUTTON}
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    ${status}
    Click at      ${STATUS_VALUE}       ${status}
    Click at        ${SAVE_TASK_BUTTON}

Add task to workflow with move to status
    [Arguments]     ${task_name}    ${status}       ${conversation_type}
    Click at    ${WF_ADD_TASK_BUTTON}
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    ${status}
    Click at      ${STATUS_VALUE}       ${status}
    Click at        ${ADD_TRIGGER_BUTTON}
    Click at        ${MOVE_TO_STATUS_ACTION}
    Click at        ${WF_MOVE_TO_STATUS_VALUE}         ${conversation_type}
    Click at        ${SAVE_TASK_BUTTON}
