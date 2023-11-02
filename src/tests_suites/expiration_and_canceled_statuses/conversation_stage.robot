*** Settings ***
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/group_management_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        test

*** Variables ***
${ASKED_PHONE}      Can you please provide me with your mobile phone number so that a recruiter can contact you?

*** Test Cases ***
Verify Conversation status at Candidate Journey (OL-T24161)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Candidate Journeys page
    Load full Candidate Journeys in page
    Scroll to element       ${JOURNEY_TITLE}    ${JOURNEY_CONVERSATION_STAGE}
    Click at    ${JOURNEY_TITLE}    ${JOURNEY_CONVERSATION_STAGE}
    Click at    ${STAGE_NAME_IN_JOURNEY}    ${JOURNEY_CONVERSATION_STATUS}
    Check element display on screen     ${JOURNEY_STAGE_STATUS_TITLE_BY_NAME}      Send Conversation
    Check element display on screen     ${JOURNEY_STAGE_STATUS_TITLE_BY_NAME}      Conversation In-Progress
    Check element display on screen     ${JOURNEY_STAGE_STATUS_TITLE_BY_NAME}      Conversation Complete
    Check element display on screen     ${JOURNEY_STAGE_STATUS_TITLE_BY_NAME}      Conversation Incomplete
    Check element display on screen     ${JOURNEY_STAGE_STATUS_TITLE_BY_NAME}      Conversation Expired
    Check element display on screen     ${JOURNEY_STAGE_STATUS_TITLE_BY_NAME}      Conversation Canceled


Verify candidate when changing status's candidate from Conversation incomplete to Conversation Expired incase trigger workflow via WEB (OL-T24163)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =      Add Single conversation with group      Single Path
    ${site_name} =      Create landing site/widget site     Landing Site    conversation_name=${conversation_name}
    ${url} =    Assign the conversation to the landing site/widget site     ${conversation_name}    ${site_name}
    Go to       ${url}
    Chat landing site and check status candidate for single convo       ${url}
    Delete a landing site/widget site       ${site_name}
    Delete a Conversation       ${conversation_name}

*** Keywords ***
Create Follow up conversation
    [Arguments]    ${type}   ${journey_name}    ${conversation_name}=None
    IF    '${conversation_name}' == 'None'
        ${conversation_name} =    Generate random name    Auto_conversation_follow
    END
    Go to conversation builder
    Click at    ${ADD_CONVERSATION_BUTTON}
    Click at    ${ADD_NEW_CONVERSATION}
    Input into  ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT}    ${type}
    Click by JS    ${conversation_template}
    wait for page load successfully v1
    Click at    ${CANDIDATE_JOURNEY_DROPDOWN}
    Input into  ${SEARCH_JOURNEY_TEXT_BOX}      ${journey_name}
    Click at    ${SEARCH_JOURNEY_VALUE}     ${journey_name}
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Public the conversation
    [Return]    ${conversation_name}


Add Single conversation with group
    [Arguments]    ${type}      ${conversation_name}=None
    ${conversation_name} =  Create Follow up conversation       Follow Up       ${JOURNEY_CONVERSATION_STAGE}
    ${group_name}=      Add a Group     ${JOURNEY_CONVERSATION_STAGE}       ${conversation_name}
    when Go to conversation builder
    Click add conversation
    IF  '${conversation_name}' == 'None'
        ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${conversation_name} =    Set variable    auto_${type}_${conversation_id}
    END
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT}    ${type}
    Click by JS    ${conversation_template}
    Click at        ${SELECT_GROUP_DROPDOWN}
    Input into      ${SEARCH_GROUP_TEXT_BOX}     ${group_name}
    Click at    ${SEARCH_JOURNEY_VALUE}         ${group_name}
    Check element display on screen    ${QUESTION_BOX}
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_2}  Your like?  ${GLOBAL_SCREENING_QUESTION_2_LABEL}  Like
    Public the conversation
    [Return]    ${conversation_name}

Chat landing site and check status candidate for single convo
    [Arguments]    ${url}
    Wait for Olivia reply
    ${candidate_name} =     Generate candidate name
    Candidate input to landing site   ${candidate_name.full_name}
    Verify Olivia Conversation Message Display         ${ASKED_PHONE}
    ${phone_number} =   Generate Random String      6    [NUMBERS]
    Candidate input to landing site      +12025${phone_number}
    Verify Olivia Conversation Message Display      How old are you?
    Find and check status candidate     ${candidate_name}       Conversation In-Progress
    Go to    ${url}
    Verify Olivia Conversation Message Display     How old are you?
    Candidate input to landing site   22
    Verify Olivia Conversation Message Display     Your like?
    Candidate input to landing site   sing
    Wait for Olivia reply
    Check element display on screen     ${MESSAGE_CONVERSATION_OLIVIA_STATUS}   Conversation Expired
    Find and check status candidate     ${candidate_name}       Conversation Expired

Find and check status candidate
    [Arguments]    ${candidate_name}        ${conversation_type}
    Go to CEM page
    Click at        ${CEM_CANDIDATE_NAME}       ${candidate_name.full_name}
    Check element display on screen   ${STATUS_PROFILE_CANDIDATE}       ${conversation_type}
