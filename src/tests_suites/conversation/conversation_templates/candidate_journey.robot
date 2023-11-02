*** Settings ***
Resource            ./conversation_templates.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression   test

*** Test Cases ***
Verify Edit Reprompt Message is closed when clicking on X button or Cancel button at Introduction question (OL-T26290, OL-T26296, OL-T26301, OL-T26304, OL-T26310)
    Login then open Edit Reprompt Message modal     ${eclipse_introduction_question}    ${CANDIDATE_JOURNEY_TEMPLETE}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_INTRODUCTION_QUESTION}
    # Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Cancel' button at 'Phone number' question (OL-T26296)
    Check cancel and close option in Edit Reprompt Message modal in Builder    ${ECLIPSE_PHONE_NUMBER_QUESTION}
    # Verify can add max 6 Validation prompt messages for at 'Email' question (OL-T26301)
    Verify can add max 6 Validation prompt messages for at custom question    ${ECLIPSE_EMAIL_QUESTION}    question_toggle_is_off=True
    # Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Cancel' button at 'Email' question (OL-T26304)
    Check cancel and close option in Edit Reprompt Message modal in Builder    ${ECLIPSE_EMAIL_QUESTION}
    # Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Cancel' button at 'Communication preference' question (OL-T26310)
    Check cancel and close option in Edit Reprompt Message modal in Builder    ${ECLIPSE_COMMUNICATION_QUESTION}
    Delete conversation in builder


Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Cancel' button at 'Document Upload' question (OL-T26316, OL-T26319, OL-T26322, OL-T26325, OL-T26328, OL-T26331, OL-T26334)
    Login then create question in global
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    # Verify can add max 6 Validation prompt messages for at 'List select' question (OL-T26319)
    Delete a global screening question in conversation
    Add new item in list select question
    Verify can add max 6 Validation prompt messages for at custom question    ${ECLIPSE_GLOBAL_SCREENING}
    # Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'List select' question (OL-T26322)
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    # Verify can add max 6 Validation prompt messages for at 'Video Response' question. (OL-T26325)
    Delete a global screening question in conversation
    Add new item in Video Response question
    Verify can add max 6 Validation prompt messages for at custom question    ${ECLIPSE_GLOBAL_SCREENING}
    #Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Video Response' question (OL-T26328)
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    #Verify can add max 6 Validation prompt messages for at 'EEO' question (OL-T26331)
    Verify can add max 6 Validation prompt messages for at custom question    ${ECLIPSE_EEO_QUESTION}
    # Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Cancel' button at 'EEO' question. (OL-T26334)
    Check cancel and close option in Edit Reprompt Message modal in Builder    ${ECLIPSE_EEO_QUESTION}
    Delete conversation in builder

Check validation prompt message of 'Introduction', 'Email', 'Phone', 'Communication Preference', 'List select', 'Document Upload', 'Video response', 'EEO' question types when multi language is supported (OL-T26336)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${CANDIDATE_JOURNEY_TEMPLETE}
    Add language to Conversation    ${HEBREW}
    Turn on     ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Click at    ${CONVERSATION_LANGUAGE_TAB}    ${english_tab}
    Check language in validation prompt of many question    ${eclipse_question_list}    ${validation_english_list}
    Check language in validation prompt of global screen question       ${global_question_list}     ${global_english_list}
    Click by JS     ${CONVERSATION_LANGUAGE_TAB}    ${hebrew_tab}
    wait for page load successfully v1
    Check language in validation prompt of many question    ${eclipse_question_list}    ${validation_hebrew_list}
    Check language in validation prompt of global screen question       ${global_question_list}     ${global_hebrew_list}
    Delete conversation in builder

*** Keywords ***
Login then create question in global
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}      ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status          ${SINGLE_PATH_TEMPLETE}
    Add new item in Upload Document question

Login then open Edit Reprompt Message modal
    [Arguments]     ${eclipse_question}    ${conversation_type}=None
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}      ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status          ${conversation_type}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}          ${EDIT_REPROMPT_MESSAGE}
