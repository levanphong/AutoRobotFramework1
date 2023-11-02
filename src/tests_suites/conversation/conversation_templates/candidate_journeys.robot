*** Settings ***
Resource            ./conversation_templates.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Test Cases ***
Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Cancel' button at 'Introduction' question (OL-T26290, OL-T26296, OL-T26293)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_INTRODUCTION_QUESTION}    ${CANDIDATE_JOURNEY_TEMPLETE}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_INTRODUCTION_QUESTION}
    Open Edit Reprompt Message modal    ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check Add Validation Prompt     4
    Open Edit Reprompt Message modal    ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Delete conversation in builder


Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'List select' question (OL-T26322, OL-T26319)
    Login and add new conversation
    Add new item in list select question
    Open Edit Reprompt Message modal Global Screening and check Add Validation Prompt       3
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    Delete conversation in builder


Verify 'Edit Reprompt Message' is closed when clicking on 'X' button or 'Video Response' question. (OL-T26328, OL-T26325)
    Login and add new conversation
    Add new item in Video Response question
    Open Edit Reprompt Message modal Global Screening and check Add Validation Prompt       3
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    Delete conversation in builder


Verify can add max 6 Validation prompt messages for at 'EEO' question. (OL-T26331)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_EEO_QUESTION}     ${CANDIDATE_JOURNEY_TEMPLETE}
    Check Add Validation Prompt     3
    Delete conversation in builder


Verify can add max 6 Validation prompt messages for at 'Email' question. (OL-T26301, OL-T26303, OL-T26305)
    Login then turn on question toggle and open Edit Reprompt Message modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_EMAIL_QUESTION}       ${CANDIDATE_JOURNEY_TEMPLETE}
    Check Add Validation Prompt     4
    Open Edit Reprompt Message modal and check delete icon      ${ECLIPSE_EMAIL_QUESTION}       6
# Verify don't open 'Edit Reprompt Message' when 'Email' question is disable. (OL-T26305)
    Turn off toggle and check don't open Edit Reprompt Message when question is disable     ${ECLIPSE_EMAIL_QUESTION}
    Delete conversation in builder


Verify can add max 6 Validation prompt messages for messages for 'Communication Preference' question. (OL-T26307, OL-T26309, OL-T26311)
    Login then turn on question toggle and open Edit Reprompt Message modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_COMMUNICATION_QUESTION}       ${CANDIDATE_JOURNEY_TEMPLETE}
    Check Add Validation Prompt     3
    Open Edit Reprompt Message modal and check delete icon      ${ECLIPSE_COMMUNICATION_QUESTION}       6
# Verify don't open 'Edit Reprompt Message' when 'Communication Preference' question is disable. (OL-T26311)
    Turn off toggle and check don't open Edit Reprompt Message when question is disable     ${ECLIPSE_COMMUNICATION_QUESTION}
    Delete conversation in builder


Verify can add max 6 Validation prompt messages for messages for 'Document Upload' question. (OL-T26313)
    Login and add new conversation
    Add new item in Upload Document question
    Open Edit Reprompt Message modal Global Screening and check Add Validation Prompt       3
    Open Edit Reprompt Message modal Global Screening and check delete icon     6
    Delete conversation in builder


Verify can add max 6 Validation prompt messages for messsages at 'Introduction' question. (OL-T26288, OL-T26289)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_INTRODUCTION_QUESTION}    ${CANDIDATE_JOURNEY_TEMPLETE}
    Check delete icon option in Edit Reprompt Message modal     6
    Open Edit Reprompt Message modal    ${ECLIPSE_INTRODUCTION_QUESTION}
    Check Add Validation Prompt     1
    Delete conversation in builder


Verify delete validation prompt at 'List select' question successfully. (OL-T26321, OL-T26323)
    Login and add new conversation
    Add new item in list select question
    Open Edit Reprompt Message modal Global Screening and check delete icon     3
# Verify don't open 'Edit Reprompt Message' when 'List select' question is disable.  (OL-T26323)
    Hide question Global screening and check don't open Edit Reprompt Message when question is disable
    Delete conversation in builder


Verify delete validation prompt at 'Document Upload' question successfully. (OL-T26315, OL-T26317)
    Login and add new conversation
    Add new item in Upload Document question
    Open Edit Reprompt Message modal Global Screening and check delete icon     3
# Verify don't open 'Edit Reprompt Message' when 'Document Upload' question is disable. (OL-T26317))
    Hide question Global screening and check don't open Edit Reprompt Message when question is disable
    Delete conversation in builder


Verify delete validation prompt at 'EEO' question successfully. (OL-T26333, OL-T26335)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_EEO_QUESTION}     ${CANDIDATE_JOURNEY_TEMPLETE}
    Check delete icon option in Edit Reprompt Message modal     3
# Verify don't open 'Edit Reprompt Message' when 'EEO' question is disable. (OL-T26335)
    Turn off toggle and check don't open Edit Reprompt Message when question is disable     ${ECLIPSE_EEO_QUESTION}
    Delete conversation in builder


Verify delete validation prompt at 'Phone number' question successfully. (OL-T26294, OL-T26299)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_PHONE_NUMBER_QUESTION}    ${CANDIDATE_JOURNEY_TEMPLETE}
    Check delete icon option in Edit Reprompt Message modal     4
# Verify don't open 'Edit Reprompt Message' when 'Phone number' question is disable. (OL-T26299)
    Turn on     ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Turn off toggle and check don't open Edit Reprompt Message when question is disable     ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Delete conversation in builder


Verify delete validation prompt at 'Video Response' question successfully. (OL-T26327, OL-T26329)
    Login and add new conversation
    Add new item in Video Response question
    Open Edit Reprompt Message modal Global Screening and check delete icon     3
# Verify don't open 'Edit Reprompt Message' when 'Video response' question is disable. (OL-T26329)
    Hide question Global screening and check don't open Edit Reprompt Message when question is disable
    Delete conversation in builder


Verify be able to skip phone at phone prompt message when candidate input valid email address at 'Phone number' question then input skip intent for prompt message (OL-T26373)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${url} =    Open landing site and get url     ${LS_SKIP_PHONE}
    Go to       ${url}
    Chat landing site to Verify be able skip phone

*** Keywords ***
Login and add new conversation
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${CANDIDATE_JOURNEY_TEMPLETE}

Open Edit Reprompt Message modal with Global Screening
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}

Open Edit Reprompt Message modal
    [Arguments]     ${name_question}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${name_question}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}


Open Edit Reprompt Message modal Global Screening and check delete icon
    [Arguments]     ${number_question}
    Open Edit Reprompt Message modal with Global Screening
    Check delete icon option in Edit Reprompt Message modal     ${number_question}

Open Edit Reprompt Message modal and check delete icon
    [Arguments]     ${name_question}       ${number_question}
    Open Edit Reprompt Message modal    ${name_question}
    Check delete icon option in Edit Reprompt Message modal     ${number_question}

Open Edit Reprompt Message modal Global Screening and check Add Validation Prompt
    [Arguments]     ${number_question}
    Open Edit Reprompt Message modal with Global Screening
    Check Add Validation Prompt     ${number_question}

Turn off toggle and check don't open Edit Reprompt Message when question is disable
    [Arguments]     ${name_question}
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${name_question}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${name_question}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}

Hide question Global screening and check don't open Edit Reprompt Message when question is disable
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Hide Question
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}

Chat landing site to Verify be able skip phone
    Wait for Olivia reply
    ${candidate_name} =     Generate candidate name
    Candidate input to landing site   ${candidate_name.full_name}
    Verify Olivia Conversation Message Display         Thank you ${candidate_name.first_name}. ${REPROMPT_PHONE_MESSAGE_1}
    ${email} =    random_test_email_characters    email@paradox.ai
    Candidate input to landing site   ${email}
    Verify Olivia Conversation Message Display         ${REPROMPT_PHONE_MESSAGE_14}
    Candidate input to landing site   Skip
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_FRANCHISE_ON}
