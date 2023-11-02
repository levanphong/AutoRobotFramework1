*** Settings ***
Resource        ../../../drivers/driver_chrome.robot
Resource        ../../../pages/base_page.robot
Resource        ../../../pages/conversation_builder_page.robot
Resource        ../../../pages/custom_conversation_page.robot
Resource        ../../../pages/conversation_page.robot
Resource        ../../../pages/candidate_journeys_page.robot
Resource        ../../../pages/web_management_page.robot
Variables       ../../../constants/ConvoBuilderConst.py

*** Variables ***
${validation_prompt_message}                    Auto team edited validation prompt message
${english_tab}                                  tab-en
${hebrew_tab}                                   tab-he
${landing_site_type}                            Landing Site
@{eclipse_question_list}                        Introduction    Phone Number    Email    Communication Preference    Equal Employment Opportunity
@{global_question_list}                         Document Upload    List Select    Video Response
@{validation_english_list}                      ${REPROMPT_NAME_MESSAGE_7}    ${REPROMPT_PHONE_MESSAGE_3}    ${REPROMPT_EMAIL_MESSAGE_4}    ${REPROMPT_COMMUNICATION_MESSAGE_1}    ${REPROMPT_EEO_MESSAGE_1}
@{validation_hebrew_list}                       ${REPROMPT_NAME_MESSAGE_12}    ${REPROMPT_PHONE_MESSAGE_6}    ${REPROMPT_EMAIL_MESSAGE_7}    ${REPROMPT_COMMUNICATION_MESSAGE_4}    ${REPROMPT_EEO_MESSAGE_4}
@{global_english_list}                          ${REPROMPT_GLOBAL_MESSAGE_1}    ${REPROMPT_LIST_SELECT_MESSAGE_1}    ${REPROMPT_VIDEO_RESPONSE_MESSAGE_1}
@{global_hebrew_list}                           ${REPROMPT_GLOBAL_MESSAGE_4}    ${REPROMPT_LIST_SELECT_MESSAGE_4}    ${REPROMPT_VIDEO_RESPONSE_MESSAGE_4}
@{english_reprompt_phone_messages}              ${REPROMPT_PHONE_MESSAGE_1}    ${REPROMPT_PHONE_MESSAGE_2}    ${REPROMPT_PHONE_MESSAGE_3}    ${REPROMPT_PHONE_MESSAGE_4}    ${REPROMPT_PHONE_MESSAGE_5}    ${REPROMPT_PHONE_MESSAGE_7}    ${REPROMPT_PHONE_MESSAGE_8}
@{english_reprompt_introduction_messages}       ${REPROMPT_NAME_MESSAGE_1}    ${REPROMPT_NAME_MESSAGE_2}    ${REPROMPT_NAME_MESSAGE_3}    ${REPROMPT_NAME_MESSAGE_4}    ${REPROMPT_NAME_MESSAGE_5}    ${REPROMPT_NAME_MESSAGE_6}    ${REPROMPT_NAME_MESSAGE_7}    ${REPROMPT_NAME_MESSAGE_8}    ${REPROMPT_NAME_MESSAGE_9}    ${REPROMPT_NAME_MESSAGE_10}    ${REPROMPT_NAME_MESSAGE_11}
@{english_reprompt_email_messages}              ${REPROMPT_EMAIL_MESSAGE_1}    ${REPROMPT_EMAIL_MESSAGE_2}    ${REPROMPT_EMAIL_MESSAGE_3}    ${REPROMPT_EMAIL_MESSAGE_4}    ${REPROMPT_EMAIL_MESSAGE_5}    ${REPROMPT_EMAIL_MESSAGE_6}
@{hebrew_reprompt_phone_messages}               ${REPROMPT_PHONE_MESSAGE_9}    ${REPROMPT_PHONE_MESSAGE_10}    ${REPROMPT_PHONE_MESSAGE_11}    ${REPROMPT_PHONE_MESSAGE_12}    ${REPROMPT_PHONE_MESSAGE_13}
@{hebrew_reprompt_introduction_messages}        ${REPROMPT_NAME_MESSAGE_12}    ${REPROMPT_NAME_MESSAGE_13}    ${REPROMPT_NAME_MESSAGE_14}    ${REPROMPT_NAME_MESSAGE_15}    ${REPROMPT_NAME_MESSAGE_16}    ${REPROMPT_NAME_MESSAGE_17}
@{hebrew_reprompt_email_messages}               ${REPROMPT_EMAIL_MESSAGE_7}    ${REPROMPT_EMAIL_MESSAGE_8}    ${REPROMPT_EMAIL_MESSAGE_9}
@{english_reprompt_introduction_messages_1}     ${REPROMPT_NAME_MESSAGE_7}      ${REPROMPT_NAME_MESSAGE_3}      ${REPROMPT_NAME_MESSAGE_5}      ${REPROMPT_NAME_MESSAGE_1}      ${REPROMPT_NAME_MESSAGE_4}      ${REPROMPT_NAME_MESSAGE_6}
@{english_reprompt_email_messages_1}            ${REPROMPT_EMAIL_MESSAGE_4}     ${REPROMPT_EMAIL_MESSAGE_5}     ${REPROMPT_EMAIL_MESSAGE_2}     ${REPROMPT_EMAIL_MESSAGE_3}
@{english_reprompt_phone_messages_1}            ${REPROMPT_PHONE_MESSAGE_1}    ${REPROMPT_PHONE_MESSAGE_2}    ${REPROMPT_PHONE_MESSAGE_3}    ${REPROMPT_PHONE_MESSAGE_4}      ${REPROMPT_PHONE_MESSAGE_5}
${invalid_phone_number}                         0985
${landing_site_single_path}                     LandingSiteHireOnSinglePath
${landing_site_single_path_1}                   LandingSiteFranchiseSinglePath
${landing_site_single_path_2}                   LandingSiteHireOnSinglePathEmail
${next_question}                                Before you start your application, I need to verify your identity. I just sent a 6-digit code to

*** Keywords ***
Check Add Validation Prompt
    [Arguments]      ${question_number}
    Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  1
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}  1
    FOR     ${index}   IN RANGE     2   ${question_number} + 1
        Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  ${index}
        Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}  ${index}
    END
    # add Validation Prompt
    FOR    ${index}     IN RANGE    6 - ${question_number}
        Click at        ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
        Click at        ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
        Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_INVALID_MESSAGE}
        Check enter character into Validation Prompt
    END
    # Check max 6 Validation prompt messages
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
    Capture page screenshot
    # save change
    Click at      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TOAST_MESSAGE}
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}

Check cancel and close option in Edit Reprompt Message modal
    [Arguments]    ${eclipse_question}
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}  ${EDIT_REPROMPT_MESSAGE}
    Click at       ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_CANCEL_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}        ${EDIT_REPROMPT_MESSAGE}
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}  ${EDIT_REPROMPT_MESSAGE}
    Click at       ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}

Check cancel and close option in Edit Reprompt Message modal of Global Question
    # reopen Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Verify text contain     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}      ${EDIT_REPROMPT_MESSAGE}
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_CANCEL_BUTTON}
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}
    # reopen Edit Reprompt Message modal
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Verify text contain     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}      ${EDIT_REPROMPT_MESSAGE}
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON}
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}

Check Edit Reprompt Message Modal
    [Arguments]      ${question_number}     ${title_list}
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}  ${EDIT_REPROMPT_MESSAGE}
    Check element display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}      ${REPROMPT_PHONE_MESSAGE_7}
    Check element display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TITLE}
    FOR     ${index}   IN RANGE     1   ${question_number}+1
        Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  ${index}
    END
    IF  ${question_number} < 6
        Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
    ELSE
        Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
    END
    Check button in Edit Reprompt Message modal
    Capture page screenshot
    ${index}=  evaluate     1
    FOR     ${item}     IN      @{title_list}
        Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}    ${index}
        Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MESSGAE}     ${item}
        ${index}=   evaluate    ${index} + 1
    END

Add new conversation with draft status
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

Check delete icon option in Edit Reprompt Message modal
    [Arguments]      ${question_number}
    FOR     ${index}   IN RANGE     0   ${question_number}-1
        ${value}=   evaluate     ${question_number}-${index}
        Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}       ${value}
        Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}   ${value}
        Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}      ${value}
    END
    Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  1
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}  1
    Click at      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TOAST_MESSAGE}

Check dont open Edit Reprompt Message when question is disable
    [Arguments]      ${content}
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Input into     ${GLOBAL_SCREENING_QUESTION_1_LABEL}            ${content}
    Press Keys     None    RETURN
    wait for page load successfully
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}

Check button in Edit Reprompt Message modal
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_CANCEL_BUTTON}
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON}

Check Add Validation Prompt in Introduction question
    Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  1
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}  1
    FOR     ${index}   IN RANGE     2   7
        Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  ${index}
        Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}  ${index}
    END
    Hover at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  6
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON}  6
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MESSGAE}     ${REPROMPT_NAME_MESSAGE_6}
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_EMPTY_MESSGAE}
    Click at      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_INVALID_MESSAGE}
    # Check max 6 Validation prompt messages
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  +
    Capture page screenshot
    Check enter character into Validation Prompt

Check enter character into Validation Prompt
    Input into      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_EMPTY_MESSGAE}     ${PROMPT_MESSAGE_OVER_320_CHARACTERS}
    ${text}=        get text and format text        ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_EMPTY_MESSGAE}
    ${length_text}=  Get Length    ${text}
    Should Be Equal As Integers  ${length_text}    320
    ${text_counter}=    get text and format text        ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TEXT_COUNTER}
    Should Be Equal As Integers  ${text_counter}    0

Add new item in list select question
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Input into     ${GLOBAL_SCREENING_QUESTION_1_LABEL}            ${LIST_SELECT_QUESTION_TYPE}
    Press Keys    None    RETURN
    wait for page load successfully
    Click at       ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}           ${ADD_TOOL}
    Click at       ${LIST_SELECT_TOOL}
    Click at       ${ADD_TOOL_NEXT_BUTTON}
    Click at       ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into     ${LIST_ITEM_1_NAME}    at least 20 years
    Click at       ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into     ${LIST_ITEM_2_NAME}    20 years
    Click at       ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into     ${LIST_ITEM_3_NAME}    more than 20 years
    Click at       ${LIST_SELECT_SAVE_BUTTON}

Add new item in Video Response question
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Input into     ${GLOBAL_SCREENING_QUESTION_1_LABEL}            ${VIDEO_RESPONSE_QUESTION_TYPE}
    Press Keys    None    RETURN
    wait for page load successfully
    Click at        ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at        ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}           ${ADD_TOOL}
    Click at        ${VIDEO_RESPONSE_TOOL}
    Click at        ${ADD_TOOL_NEXT_BUTTON}
    Click at        ${VIDEO_RESPONSE_SAVE_BUTTON}      slow_down=2s

Add new item in Upload Document question
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Input into     ${GLOBAL_SCREENING_QUESTION_1_LABEL}            ${DOCUMENT_UPLOAD_QUESTION_TYPE}
    Press Keys    None    RETURN
    wait for page load successfully
    Click at       ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}           ${ADD_TOOL}
    Click at       ${DOCUMENT_UPLOAD_TOOL}
    Click at       ${ADD_TOOL_NEXT_BUTTON}
    Click at       ${DOCUMENT_UPLOAD_SAVE_BUTTON}      slow_down=2s

Check language in validation prompt of global screen question
    [Arguments]     ${eclipse_question_list}     ${validation_prompt_message_list}
    ${question_number}=  get length     ${eclipse_question_list}
    FOR     ${index}    IN RANGE    ${question_number}
        IF  ${index} == 0
            Add new item in Upload Document question
        ELSE IF  ${index} == 1
            Add new item in list select question
        ELSE
            Add new item in Video Response question
        END
        # open edit prompt message
        Click at       ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}           ${EDIT_REPROMPT_MESSAGE}
        Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MESSGAE}     ${validation_prompt_message_list}[${index}]
        Click at       ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON}
        # delete global screen question
        Click at       ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}           ${DELETE_QUESTION}
        Click at       ${CONFIRM_DELETE_QUESTION_BUTTON}
    END

Check language in validation prompt of many question
    [Arguments]     ${eclipse_question_list}     ${validation_prompt_message_list}
    ${question_number}=  get length     ${eclipse_question_list}
    FOR     ${index}    IN RANGE    ${question_number}
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question_list}[${index}]
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}          ${EDIT_REPROMPT_MESSAGE}
        Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MESSGAE}     ${validation_prompt_message_list}[${index}]
        Click at       ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON}
    END

Login then create question in global, open Edit Reprompt Message modal
    [Arguments]     ${templete_name}=None
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}      ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status          ${templete_name}
    Add new item in Upload Document question
    Click at       ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}           ${EDIT_REPROMPT_MESSAGE}

Login then turn on question toggle and open Edit Reprompt Message modal
    [Arguments]     ${eclipse_toggle}   ${eclipse_question}     ${templete_name}=None
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}      ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status          ${templete_name}
    Turn on        ${CUSTOM_CONVERSATION_TOGGLE}    ${eclipse_toggle}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}          ${EDIT_REPROMPT_MESSAGE}

Login then open Edit Reprompt Message modal
    [Arguments]     ${eclipse_question}     ${templete_name}=None
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}      ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status          ${templete_name}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}          ${EDIT_REPROMPT_MESSAGE}

Change validation prompt message
    [Arguments]      ${question_number}
    FOR     ${index}   IN RANGE     1   ${question_number} + 1
        Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  ${index}
        Input into      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_EMPTY_MESSGAE}     ${validation_prompt_message}
    END
    Click at      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TOAST_MESSAGE}
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}

Check UI when add validation prompt message
    [Arguments]    ${index}
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}    +
    Check Element display on screen    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TEXTBOX}
    Check Element display on screen    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}    ${index}
    IF  '${index}' == '6'
        Check Element Not Display On Screen    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}    +
    END
    Check enter character into Validation Prompt

Verify can add max 6 Validation prompt messages for at custom question
    [Arguments]    ${eclipse_question}    ${question_toggle_is_off}=False
    IF  '${question_toggle_is_off}' == 'True'
        Turn on     ${CUSTOM_CONVERSATION_TOGGLE}       ${eclipse_question}
    END
    IF  '${eclipse_question}' == 'Global Screening'
        Click At       ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}          ${EDIT_REPROMPT_MESSAGE}
    ELSE
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question}
        Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}          ${EDIT_REPROMPT_MESSAGE}
    END
    IF  '${eclipse_question}' == 'Global Screening' or '${eclipse_question}' == 'Equal Employment Opportunity'
        Check UI when add validation prompt message    4
    END
    IF  '${eclipse_question}' == 'Phone Number'
        Hover At       ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}    2
        Check Element display On Screen    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TRASH_ICON}    2
    END
    Check UI when add validation prompt message    5
    Check UI when add validation prompt message    6
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check Text Display    Changes saved successfully.
    Check Element Not Display On Screen    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL}

Check cancel and close option in Edit Reprompt Message modal in Builder
    [Arguments]    ${eclipse_question}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}     ${eclipse_question}
    Click at       ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}        ${EDIT_REPROMPT_MESSAGE}
    Check cancel and close option in Edit Reprompt Message modal    ${eclipse_question}
