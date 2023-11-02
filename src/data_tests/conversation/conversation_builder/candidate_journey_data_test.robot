*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_builder_page.robot
Resource            ../../../pages/custom_conversation_page.robot
Resource            ../../../pages/conversation_page.robot
Variables           ../../../constants/ConvoBuilderConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${CONVERSATION_CJ}     Conversation_CJ

*** Test Cases ***
Create data test for Conversation Builder Candidate Journey Verify be able skip phone (OL-T26373)
    Given Setup test
    Login into system with company     ${PARADOX_ADMIN}         ${COMPANY_FRANCHISE_ON}
    Add a conversation builder with Email and Phone      ${CANDIDATE_JOURNEY_TEMPLETE}       ${CONVERSATION_CJ}
    Select Mark as Optional     ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Public the conversation
    Create landing site/widget site     Landing Site    site_name=${LS_SKIP_PHONE}    conversation_name=${CONVERSATION_CJ}


*** Keywords ***
Add a conversation builder with Email and Phone
    [Arguments]    ${type}      ${conversation_name}=None
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
    Turn on  ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EEO_QUESTION}
    Public the conversation
    [Return]    ${conversation_name}

Select Mark as Optional
    [Arguments]     ${name_question}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${name_question}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${MARK_AS_OPTIONAL}
