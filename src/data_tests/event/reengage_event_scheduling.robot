*** Settings ***
Variables           ../../locators/client_setup_locators.py
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Add event candidate journey
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Go to Candidate Journeys page
    Click at    ${NEW_JOURNEY_BUTTON}
    Input into      ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}    ${RE_ENGAGE_EVENT_JOURNEY_NAME}
    Click at    ${CREATE_NEW_JOURNEY_BUTTON}
    ${is_cj_created} =     Run keyword and Return Status   Check element display on screen     ${CREATE_NEW_JOURNEY_BUTTON}     wait_time=10s
    IF  '${is_cj_created}' == 'False'
        Publish a Journey    ${RE_ENGAGE_EVENT_JOURNEY_NAME}
        Delete a Stage      Rating
    END


Add event group
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Go to Group Management page
    Input into      ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}     ${RE_ENGAGE_EVENT_GROUP_NAME}
    ${is_group_created} =     Run keyword and Return Status   Check element display on screen     ${GROUP_NAME_IN_LIST}     ${RE_ENGAGE_EVENT_GROUP_NAME}   wait_time=10s
    IF  '${is_group_created}' == 'False'
        Click at    ${NEW_GROUP_BUTTON}
        Click at    ${GROUP_NAME_TITLE}
        Simulate Input      ${GROUP_NAME_TITLE}    ${RE_ENGAGE_EVENT_GROUP_NAME}
        Click at    ${EXTERNAL_ID_TEXT_BOX}
        Click at    ${SAVE_GROUP_DETAILS_BUTTON}
        Click at    ${JOURNEY_SELECTION_DROPDOWN}
        ${journey_name_locator} =    Format String    ${JOURNEY_SELECT_VALUE}    ${RE_ENGAGE_EVENT_JOURNEY_NAME}
        Click by JS    ${journey_name_locator}
        Click at    ${GROUP_ADD_ATTENDEE}
        Click by JS     ${GROUP_INPUT_SEARCH_ATTENDEE}
        Input text      ${GROUP_INPUT_SEARCH_ATTENDEE}    ${CA_TEAM}
        ${locator} =    Format String    ${GROUP_ATTENDEE_INTERVIEW}    ${CA_TEAM}
        Click by JS    ${locator}
        Click by JS    ${SAVE_NEW_GROUP_BUTTON}
    END


Add event conversation
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Go to conversation builder
    Simulate Input    ${SEARCH_CONVERSATION_INPUT}    ${RE_ENGAGE_EVENT_CONVERSATION_NAME}
    ${is_displayed} =     Run keyword and return status   Check element display on screen    ${CONVERSATION_NAME_IN_ROW}     ${RE_ENGAGE_EVENT_CONVERSATION_NAME}   wait_time=10s
    IF  '${is_displayed}' == 'False'
        when Add new conversation with name and type    ${RE_ENGAGE_EVENT_CONVERSATION_NAME}    Event Registration (Single Path)
        Click at    ${CANDIDATE_JOURNEY_DROPDOWN}
        Input into    ${SEARCH_GROUP_TEXT_BOX}    ${RE_ENGAGE_EVENT_GROUP_NAME}
        Click at    ${RE_ENGAGE_EVENT_GROUP_NAME}
        Click by JS    ${EMAIL_TOGGLE}
        Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
        Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
        Public the conversation
    END
