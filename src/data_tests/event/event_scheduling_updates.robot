*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/group_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Add event candidate journey
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Candidate Journeys page
    Click at    ${NEW_JOURNEY_BUTTON}
    Input into      ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}    ${EVENT_SCHEDULING_UPDATES_CANDIDATE_JOURNEY}
    Click at    ${CREATE_NEW_JOURNEY_BUTTON}
    Publish a Journey    ${EVENT_SCHEDULING_UPDATES_CANDIDATE_JOURNEY}


Add event group
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Group Management page
    Click at    ${NEW_GROUP_BUTTON}
    Click at    ${GROUP_NAME_TITLE}
    Simulate Input      ${GROUP_NAME_TITLE}    ${EVENT_SCHEDULING_UPDATES_GROUP_NAME}
    Click at    ${EXTERNAL_ID_TEXT_BOX}
    Click at    ${SAVE_GROUP_DETAILS_BUTTON}
    Click at    ${JOURNEY_SELECTION_DROPDOWN}
    ${journey_name_locator} =    Format String    ${JOURNEY_SELECT_VALUE}    ${EVENT_SCHEDULING_UPDATES_CANDIDATE_JOURNEY}
    Click by JS    ${journey_name_locator}
    Click at    ${GROUP_ADD_ATTENDEE}
    Click by JS     ${GROUP_INPUT_SEARCH_ATTENDEE}
    Input text      ${GROUP_INPUT_SEARCH_ATTENDEE}    ${CA_TEAM}
    ${locator} =    Format String    ${GROUP_ATTENDEE_INTERVIEW}    ${CA_TEAM}
    Click by JS    ${locator}
    Click by JS    ${SAVE_NEW_GROUP_BUTTON}


Add event conversation for event scheduling updates
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to conversation builder
    when Add new conversation with name and type    ${EVENT_SCHEDULING_UPDATES_CONVERSATION}    Event Registration (Single Path)
    Click at    ${CANDIDATE_JOURNEY_DROPDOWN}
    Click at    ${EVENT_SCHEDULING_UPDATES_GROUP_NAME}
    Click by JS    ${EMAIL_TOGGLE}
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Public the conversation
