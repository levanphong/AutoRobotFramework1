*** Settings ***
Documentation       Run datatest for first time 'src/data_tests/conversation/conversation_templates/single_path.robot'
Resource            ./conversation_templates.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test

*** Test Cases ***
Verify Validation Prompt is added for Introduction question (OL-T25538, OL-T25539, OL-T25540)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_INTRODUCTION_QUESTION}    ${SINGLE_PATH_TEMPLETE}
    @{title_list} =     create list     ${REPROMPT_NAME_MESSAGE_7}      ${REPROMPT_NAME_MESSAGE_3}      ${REPROMPT_NAME_MESSAGE_5}      ${REPROMPT_NAME_MESSAGE_1}      ${REPROMPT_NAME_MESSAGE_4}      ${REPROMPT_NAME_MESSAGE_6}
    Check Edit Reprompt Message Modal       6       ${title_list}
    Check Add Validation Prompt in Introduction question
    Check delete icon option in Edit Reprompt Message modal     6
    Delete conversation in builder


Verify Edit Reprompt Message is closed when clicking on X button or Cancel button at Introduction question (OL-T25541, OL-T25542)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_INTRODUCTION_QUESTION}    ${SINGLE_PATH_TEMPLETE}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_INTRODUCTION_QUESTION}
    # open Edit Reprompt Message modal
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_INTRODUCTION_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Change validation prompt message    6
    Delete conversation in builder


Verify Validation Prompt is added for Phone number question (OL-T25543, OL-T25544)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_PHONE_NUMBER_QUESTION}    ${SINGLE_PATH_TEMPLETE}
    @{title_list} =     create list     ${REPROMPT_PHONE_MESSAGE_3}     ${REPROMPT_PHONE_MESSAGE_4}     ${REPROMPT_PHONE_MESSAGE_5}     ${REPROMPT_PHONE_MESSAGE_2}
    Check Edit Reprompt Message Modal       4       ${title_list}
    Check Add Validation Prompt     4
    Delete conversation in builder


Verify delete validation prompt at Phone number question successfully (OL-T25545)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_PHONE_NUMBER_QUESTION}    ${SINGLE_PATH_TEMPLETE}
    Check delete icon option in Edit Reprompt Message modal     4
    Delete conversation in builder


Verify edit validation prompt message for Phone number question is successfully (OL-T25546, OL-T25547)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_PHONE_NUMBER_QUESTION}    ${SINGLE_PATH_TEMPLETE}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_PHONE_NUMBER_QUESTION}
    # open Edit Reprompt Message modal
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Change validation prompt message    4
    Delete conversation in builder


Verify show Mark as Optional option for the Phone Number question in case 'Email' question is ON (OL-T25548)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Turn on     ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check element display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${MARK_AS_OPTIONAL}
    Delete conversation in builder


Verify don't open Edit Reprompt Message when Phone number question is disable (OL-T25550, QL-T25556)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EMAIL_QUESTION}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Turn on     ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Delete conversation in builder


Verify Validation Prompt is added for Email question (OL-T25551, OL-T25552)
    Login then turn on question toggle and open Edit Reprompt Message modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_EMAIL_QUESTION}       ${SINGLE_PATH_TEMPLETE}
    @{title_list} =     create list     ${REPROMPT_EMAIL_MESSAGE_4}     ${REPROMPT_EMAIL_MESSAGE_5}     ${REPROMPT_EMAIL_MESSAGE_2}     ${REPROMPT_EMAIL_MESSAGE_3}
    Check Edit Reprompt Message Modal       4       ${title_list}
    Check Add Validation Prompt     4
    Delete conversation in builder


Verify edit validation prompt message for Email question is successfully (OL-T25553, OL-T25554, OL-T25555)
    Login then turn on question toggle and open Edit Reprompt Message modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_EMAIL_QUESTION}       ${SINGLE_PATH_TEMPLETE}
    Change validation prompt message    4
    # open Edit Reprompt Message modal again
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EMAIL_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check delete icon option in Edit Reprompt Message modal     4
    # open Edit Reprompt Message modal again
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EMAIL_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_EMAIL_QUESTION}
    Delete conversation in builder


Verify Validation Prompt is added for Communication Preference question (OL-T25557, OL-T25558, OL-T25559)
    Login then turn on question toggle and open Edit Reprompt Message modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_COMMUNICATION_QUESTION}       ${SINGLE_PATH_TEMPLETE}
    @{title_list} =     create list     ${REPROMPT_COMMUNICATION_MESSAGE_1}     ${REPROMPT_COMMUNICATION_MESSAGE_2}     ${REPROMPT_COMMUNICATION_MESSAGE_3}
    Check Edit Reprompt Message Modal       3       ${title_list}
    Change validation prompt message    3
    # open Edit Reprompt Message Modal again
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_COMMUNICATION_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check Add Validation Prompt     3
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Delete conversation in builder


Verify delete validation prompt message at Communication Preference question successfully (OL-T25560, OL-T25561, OL-T25562)
    Login then turn on question toggle and open Edit Reprompt Message modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_COMMUNICATION_QUESTION}       ${SINGLE_PATH_TEMPLETE}
    # option in Communication Preference ~ option in Phone Number and Email
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_COMMUNICATION_QUESTION}
    # open Edit Reprompt Message Modal again
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_COMMUNICATION_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check delete icon option in Edit Reprompt Message modal     3
    # Check modal when turn off toggle
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_COMMUNICATION_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_COMMUNICATION_QUESTION}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Delete conversation in builder


Verify Validation Prompt is added for Document Upload question (OL-T25563, OL-T25564, OL-T25565)
    Login then create question in global, open Edit Reprompt Message modal      ${SINGLE_PATH_TEMPLETE}
    @{title_list} =     create list     ${REPROMPT_GLOBAL_MESSAGE_1}    ${REPROMPT_GLOBAL_MESSAGE_2}    ${REPROMPT_GLOBAL_MESSAGE_3}
    Check Edit Reprompt Message Modal       3       ${title_list}
    Change validation prompt message    3
    # reopen Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check Add Validation Prompt     3
    Delete conversation in builder


Verify delete validation prompt at Document Upload question successfully (OL-T25566, OL-T25567)
    Login then create question in global, open Edit Reprompt Message modal      ${SINGLE_PATH_TEMPLETE}
    Check delete icon option in Edit Reprompt Message modal     3
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    Delete conversation in builder


Verify don't open 'Edit Reprompt Message' when 'Document Upload' question is disable (OL-T25568)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Check dont open Edit Reprompt Message when question is disable      ${DOCUMENT_UPLOAD_QUESTION_TYPE}
    Delete conversation in builder


Verify Validation Prompt is added for 'List Select' question (OL-T25569, OL-T25570)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Add new item in list select question
    # open Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    @{title_list} =     create list     ${REPROMPT_LIST_SELECT_MESSAGE_1}       ${REPROMPT_LIST_SELECT_MESSAGE_2}       ${REPROMPT_LIST_SELECT_MESSAGE_3}
    Check Edit Reprompt Message Modal       3       ${title_list}
    Check Add Validation Prompt     3
    Delete conversation in builder


Verify edit validation prompt message for 'List select' question is successfully (OL-T25571, OL-T25572, OL-T25573)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Add new item in list select question
    # open Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Change validation prompt message    3
    # reopen Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check delete icon option in Edit Reprompt Message modal     3
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    Delete conversation in builder


Verify don't open 'Edit Reprompt Message' when 'List select' question is disable (OL-T25574)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Check dont open Edit Reprompt Message when question is disable      ${LIST_SELECT_QUESTION_TYPE}
    Delete conversation in builder


Verify can add max 6 Validation prompt messages for at 'Video Response' question (OL-T25575, OL-T25576, OL-T25577)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Add new item in Video Response question
    # open Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    @{title_list} =     create list     ${REPROMPT_VIDEO_RESPONSE_MESSAGE_1}    ${REPROMPT_VIDEO_RESPONSE_MESSAGE_2}    ${REPROMPT_VIDEO_RESPONSE_MESSAGE_3}
    Check Edit Reprompt Message Modal       3       ${title_list}
    Change validation prompt message    3
    # reopen Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check Add Validation Prompt     3
    Delete conversation in builder


Verify delete validation prompt at 'Video Response' question successfully (OL-T25578, OL-T25579)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Add new item in Video Response question
    # open Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Change validation prompt message    3
    Check cancel and close option in Edit Reprompt Message modal of Global Question
    Delete conversation in builder


Verify don't open 'Edit Reprompt Message' when 'Video response' question is disable (OL-T25580)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Check dont open Edit Reprompt Message when question is disable      ${VIDEO_RESPONSE_QUESTION_TYPE}
    Delete conversation in builder


Verify Validation Prompt is added for 'EEO' question (OL-T25581, OL-T25582, OL-T25583)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_EEO_QUESTION}     ${SINGLE_PATH_TEMPLETE}
    @{title_list} =     create list     ${REPROMPT_EEO_MESSAGE_1}       ${REPROMPT_EEO_MESSAGE_2}       ${REPROMPT_EEO_MESSAGE_3}
    Check Edit Reprompt Message Modal       3       ${title_list}
    Change validation prompt message    3
    # reopen Edit Reprompt Message modal
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EEO_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check Add Validation Prompt     3
    Delete conversation in builder


Verify delete validation prompt at 'EEO' question successfully (OL-T25584, OL-T25585)
    Login then open Edit Reprompt Message modal     ${ECLIPSE_EEO_QUESTION}     ${SINGLE_PATH_TEMPLETE}
    Check delete icon option in Edit Reprompt Message modal     3
    # reopen Edit Reprompt Message modal
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EEO_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check cancel and close option in Edit Reprompt Message modal    ${ECLIPSE_EEO_QUESTION}
    Delete conversation in builder


Verify don't open 'Edit Reprompt Message' when 'EEO' question is disable (OL-T25586)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EEO_QUESTION}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EEO_QUESTION}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Delete conversation in builder


Check validation prompt message of 'Introduction', 'Email', 'Phone', 'Communication Preference', 'List select', 'Document Upload', 'Video response', 'EEO' question types when multi language is supported (OL-T25587)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}
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


Verify show validation prompt message for 'Introduction' question when candidate inputs invalid name in case start conver via WEB (OL-T25588)
    [Documentation]
    ...    Precondition:
    ...    - Create Single Path Conversation with "Single Path Conversation" name
    ...    - Create landing site from conversation with "LandingSiteFranchiseSinglePath" name
    ${url} =    Get landing site url by string concatenation    COMPANY_FRANCHISE_ON    ${landing_site_single_path_1}
    Go to       ${url}
    Wait for Olivia reply
    Check random reprompt message of question       Introduction    3       @{english_reprompt_introduction_messages_1}
    ${candidate_name} =     Generate candidate name
    Candidate input to landing site     ${candidate_name.full_name}
    ${verify_message} =     Format String       Thank you {}. ${REPROMPT_PHONE_MESSAGE_1}      ${candidate_name.first_name}
    Check element display on screen     ${MESSAGE_CONVERSATION_OLIVIA_REPLY}    ${verify_message}


Verify show validation prompt message for 'Phone number' question when candidate inputs invalid phone number in case start conver via WEB (OL-T25592, OL-T25593, OL-T25597, OL-T25599, OL-T25601)
    [Documentation]
    ...    Precondition:
    ...    - Create Single Path Conversation with "Single Path Conversation" name
    ...    - Create landing site from conversation with "LandingSiteFranchiseSinglePath" name
    ${url} =    Get landing site url by string concatenation    COMPANY_FRANCHISE_ON    ${landing_site_single_path_1}
    Go to       ${url}
    Handle when GDPR popup display
    Wait for Olivia reply
    ${candidate_name} =     Generate candidate name
    Candidate input to landing site     ${candidate_name.full_name}
    # email answer
    &{email_info} =     Get email for testing
    Candidate input to landing site     ${email_info.email}
    Verify AI reprompt message when asking      ${MESSAGE_CONVERSATION_OLIVIA_REPLY}    ${REPROMPT_PHONE_MESSAGE_14}
    # check random validation prompt message
    Check random reprompt message of question       Phone number    2       @{english_reprompt_phone_messages_1}
    # skip answer
    Candidate input to landing site     skip
    Verify AI reprompt message when asking      @{english_reprompt_phone_messages_1}
    # end answer
    ${verify_message} =     Format String       ${EVENT_THANK_YOU_MESSAGE}      company_name=${COMPANY_HIRE_ON}
    ${phone_number}=    Generate random phone number
    Candidate input to landing site     ${phone_number}
    Verify AI reprompt message when asking      ${MESSAGE_CONVERSATION_OLIVIA_REPLY}    ${Age_question}


Verify show validation prompt message for 'Phone number' question when candidate input 'Phone number' question without Country code (OL-T25602)
    [Documentation]
    ...    Precondition:
    ...    - Create Single Path Conversation with "Single Path Conversation" name
    ...    - Create landing site from conversation with "LandingSiteHireOnSinglePath" name
    ${url} =    Get landing site url by string concatenation    COMPANY_HIRE_ON     ${landing_site_single_path}
    Go to       ${url}
    Handle when GDPR popup display
    Wait for Olivia reply
    ${candidate_name} =     Generate candidate name
    Candidate input to landing site     ${candidate_name.full_name}
    ${verify_message} =     Format String       ${EVENT_THANK_YOU_MESSAGE}      company_name=${COMPANY_HIRE_ON}
    # check invalid phone number
    Candidate input to landing site     ${CONST_PHONE_NUMBER}
    Verify AI reprompt message when asking      ${MESSAGE_CONVERSATION_OLIVIA_REPLY}    ${ANSWER_INVALID_PHONE_MESSAGE_1}
    # check valid phone number
    ${phone_number}=    Generate random phone number
    Candidate input to landing site     ${phone_number}
    Verify AI reprompt message when asking      ${MESSAGE_CONVERSATION_OLIVIA_REPLY}    ${Age_question}

*** Keywords ***
Check random reprompt message of question
    [Arguments]     ${question_content}     ${repeat_number}    @{list_reprompt_messages}
    FOR     ${index}  IN RANGE     ${repeat_number}
        Candidate input to landing site     ${question_content}
        Verify AI reprompt message when asking    @{list_reprompt_messages}
    END

Handle when GDPR popup display
    ${is_display}=      run keyword and return status       Check element display on screen     ${GDPR_MODAL_ACCEPT_BUTTON}
    IF    '${is_display}'=='True'
        Click at    ${GDPR_MODAL_ACCEPT_BUTTON}
        wait with short time
    END
