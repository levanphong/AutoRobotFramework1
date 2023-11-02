*** Settings ***
Resource            ./conversation_templates.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Variables ***
@{convo_names}                  Convo OL-T25767 priority location    Convo OL-T25770 priority location
@{site_names}                   Site OL-T25767 priority location    Site OL-T25770 priority location
@{list_reprompt_msg_eeo}        ${REPROMPT_EEO_MESSAGE_1}    ${REPROMPT_EEO_MESSAGE_2}    ${REPROMPT_EEO_MESSAGE_3}
@{list_repompt_msg_phone}       ${REPROMPT_PHONE_MESSAGE_3}    ${REPROMPT_PHONE_MESSAGE_4}    ${REPROMPT_PHONE_MESSAGE_5}
...                             ${REPROMPT_PHONE_MESSAGE_2}
${ask_phone_msg}                Thank you {}. Can you please provide me with your mobile phone number so that a recruiter can contact you?
${hebrew_conv_site_name}        Single Path (Prioritized Location) Hebrew Conversation Site
${english_conv_site_name}       SinglePathPrioritizedLocationEnglishConversationSite
${care_conv_site_name}          SinglePathPrioritizedLocationCareConversationSite
${conversation_name}            Single Path (Prioritized Location) Conversation Multi Languages
${care_conversation_name}       Single Path (Prioritized Location) Care/ Job Search Conversation
${care_response}                Sport Clips first opened its doors in 1993 in Austin, Texas. Gordon Logan, our CEO and founder had
...                             a great vision, and that was to take the somewhat enjoyable experiences that most men were having in the salons
...                             they were frequenting, and turn it into something that they could feel was a place just for them that would be
...                             convenient and easy to get in and out of with as little hassle as possible, that they would enjoy, look forward to, and would be anxious to come back for.

*** Test Cases ***
# ==================================================================================== PART 1 =======================================================================================================
Verify Validation Prompt is added for 'Introduction' question (OL-T25712, OL-T25713, Ol-T25714, OL-T25715, OL-T25716)
    Login Then Open Edit Reprompt Message Modal     ${ECLIPSE_INTRODUCTION_QUESTION}    ${SINGLE_PATH_PRIORITY_TEMPLETE}
    # OL-T25712
    ${list_msg} =       Create List     ${REPROMPT_NAME_MESSAGE_7}      ${REPROMPT_NAME_MESSAGE_3}      ${REPROMPT_NAME_MESSAGE_5}
    ...     ${REPROMPT_NAME_MESSAGE_1}      ${REPROMPT_NAME_MESSAGE_4}      ${REPROMPT_NAME_MESSAGE_6}
    Check Edit Reprompt Message Modal       6       ${list_msg}
    # OL-T25713
    Check Add Validation Prompt in Introduction question
    # OL-T25716
    Change Validation Prompt Message    6
    # OL-T25715
    Reopen modal Edit Reprompt Message      ${ECLIPSE_INTRODUCTION_QUESTION}
    Check Cancel And Close Option In Edit Reprompt Message Modal    ${ECLIPSE_INTRODUCTION_QUESTION}
    # OL-T25714
    Reopen modal Edit Reprompt Message      ${ECLIPSE_INTRODUCTION_QUESTION}
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    Delete Conversation In Builder


Verify Validation Prompt is added for 'Phone number' question (OL-T25717, OL-T25718, OL-T25719, OL-T25720, OL-T25721)
    Login Then Open Edit Reprompt Message Modal     ${ECLIPSE_PHONE_NUMBER_QUESTION}    ${SINGLE_PATH_PRIORITY_TEMPLETE}
    ${list_msg} =       Create List     ${REPROMPT_PHONE_MESSAGE_3}     ${REPROMPT_PHONE_MESSAGE_4}     ${REPROMPT_PHONE_MESSAGE_5}
    ...     ${REPROMPT_PHONE_MESSAGE_2}
    # OL-T25717
    Check Edit Reprompt Message Modal       4       ${list_msg}
    # OL-T25718
    Check Add Validation Prompt     4
    # OL-T25720
    Reopen modal Edit Reprompt Message      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Change Validation Prompt Message    6
    # OL-T25721
    Reopen modal Edit Reprompt Message      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check Cancel And Close Option In Edit Reprompt Message Modal    ${ECLIPSE_PHONE_NUMBER_QUESTION}
    # OL-T25719
    Reopen modal Edit Reprompt Message      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    Delete Conversation In Builder


Verify show Skip Prompt for the Phone Number question in case 'Email' question is ON (OL-T25722, OL-T25723)
    [Documentation]     Integration Center: Off
    ...                 ATS: Off
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # OL-T25722
    ${list_msg} =       Create List     ${REPROMPT_PHONE_MESSAGE_3}     ${REPROMPT_PHONE_MESSAGE_4}     ${REPROMPT_PHONE_MESSAGE_5}
    ...     ${REPROMPT_PHONE_MESSAGE_2}
    Add New Conversation With Draft Status      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    Turn On     ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Check Edit Reprompt Message Modal       4       ${list_msg}
    # OL-T25723
    Change Validation Prompt Message    4
    Delete Conversation In Builder


Verify don't open 'Edit Reprompt Message' when 'Phone number' or 'Email Address' question is disable (OL-T25724, OL-T25730, OL-T25736)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Add New Conversation With Draft Status      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    # OL-T25730
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${ECLIPSE_EMAIL_QUESTION}
    Check Element Not Display On Screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Capture Page Screenshot
    # OL-T25724
    Turn on/ off toggle to verify disabled element      ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_PHONE_NUMBER_QUESTION}
    # OL-T25736
    Turn on/ off toggle to verify disabled element      ${ECLIPSE_PHONE_NUMBER_QUESTION}    ${ECLIPSE_COMMUNICATION_QUESTION}
    Delete Conversation In Builder


Verify Validation Prompt is added for 'Email' question (OL-T25725, OL-T257226, OL-T25727, OL-T25728, OL-T25729)
    Login Then Turn On Question Toggle And Open Edit Reprompt Message Modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_EMAIL_QUESTION}
    ...     templete_name=${SINGLE_PATH_PRIORITY_TEMPLETE}
    ${list_msg} =       Create List     ${REPROMPT_EMAIL_MESSAGE_4}     ${REPROMPT_EMAIL_MESSAGE_5}     ${REPROMPT_EMAIL_MESSAGE_2}
    ...     ${REPROMPT_EMAIL_MESSAGE_3}
    # OL-T25725
    Check Edit Reprompt Message Modal       4       ${list_msg}
    # OL-T25726
    Check Add Validation Prompt     4
    # OL-T25727
    Reopen modal Edit Reprompt Message      ${ECLIPSE_EMAIL_QUESTION}
    Change Validation Prompt Message    6
    # OL-25728
    Reopen modal Edit Reprompt Message      ${ECLIPSE_EMAIL_QUESTION}
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    # OL-T25729
    Reopen modal Edit Reprompt Message      ${ECLIPSE_EMAIL_QUESTION}
    Check Cancel And Close Option In Edit Reprompt Message Modal    ${ECLIPSE_EMAIL_QUESTION}
    Delete Conversation In Builder


Verify Validation Prompt is added for 'Communication Preference' question (OL-T25731, OL-T23732, OL-T23733, OL-T23734, OL-T23735)
    Login Then Turn On Question Toggle And Open Edit Reprompt Message Modal     ${ECLIPSE_EMAIL_QUESTION}       ${ECLIPSE_COMMUNICATION_QUESTION}
    ...     templete_name=${SINGLE_PATH_PRIORITY_TEMPLETE}
    ${list_msg} =       Create List     ${REPROMPT_COMMUNICATION_MESSAGE_1}     ${REPROMPT_COMMUNICATION_MESSAGE_2}
    ...     ${REPROMPT_COMMUNICATION_MESSAGE_3}
    # OL-T25731
    Check Edit Reprompt Message Modal       3       ${list_msg}
    # OL-T25732
    Check Add Validation Prompt     3
    # OL-T25733
    Reopen modal Edit Reprompt Message      ${ECLIPSE_COMMUNICATION_QUESTION}
    Change Validation Prompt Message    6
    # OL-T25734
    Reopen modal Edit Reprompt Message      ${ECLIPSE_COMMUNICATION_QUESTION}
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    # OL-T25735
    Reopen modal Edit Reprompt Message      ${ECLIPSE_COMMUNICATION_QUESTION}
    Check Cancel And Close Option In Edit Reprompt Message Modal    ${ECLIPSE_COMMUNICATION_QUESTION}


Verify Validation Prompt is added for 'Document Upload' question (OL-T25737, OL-T25738, OL-T25739)
    Login Then Create Question In Global, Open Edit Reprompt Message Modal      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    ${list_msg} =       Create List     ${REPROMPT_GLOBAL_MESSAGE_1}    ${REPROMPT_GLOBAL_MESSAGE_2}    ${REPROMPT_GLOBAL_MESSAGE_3}
    # OL-T25737
    Check Edit Reprompt Message Modal       3       ${list_msg}
    # OL-T25738
    Check Add Validation Prompt     3
    # OL-T25739
    Reopen modal Edit Reprompt Message      None    is_screening_question=True
    Change Validation Prompt Message    6
    Delete Conversation In Builder


Verify delete validation prompt at 'Document Upload' question successfully (OL-T25740, OL-T25741)
    Login Then Create Question In Global, Open Edit Reprompt Message Modal      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    # OL-T25740
    Check Delete Icon Option In Edit Reprompt Message Modal     3
    # OL-T25741
    Check Cancel And Close Option In Edit Reprompt Message Modal Of Global Question
    Delete Conversation In Builder


Verify don't open 'Edit Reprompt Message' when 'Document Upload' question is disable (OL-T25742)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Add New Conversation With Draft Status      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    Check Dont Open Edit Reprompt Message When Question Is Disable      ${DOCUMENT_UPLOAD_QUESTION_TYPE}
    Capture Page Screenshot
    Delete Conversation In Builder


Verify Validation Prompt is added for 'List Select' question (OL-T25743, OL-T25744, OL-T25745, OL-T25746, OL-T25747)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Add New Conversation With Draft Status      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    ${list_msg} =       Create List     ${REPROMPT_LIST_SELECT_MESSAGE_1}       ${REPROMPT_LIST_SELECT_MESSAGE_2}       ${REPROMPT_LIST_SELECT_MESSAGE_3}
    Add New Item In List Select Question
    # OL-T25743
    Reopen Modal Edit Reprompt Message      None    is_screening_question=True
    Check Edit Reprompt Message Modal       3       ${list_msg}
    # OL-T25745
    Change Validation Prompt Message    3
    # OL-T25744
    Reopen Modal Edit Reprompt Message      None    is_screening_question=True
    Check Add Validation Prompt     3
    # OL-T25746
    Reopen Modal Edit Reprompt Message      None    is_screening_question=True
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    # OL-T25747
    Check Cancel And Close Option In Edit Reprompt Message Modal Of Global Question
    # OL-T25748
    Verify Don't Show Edit Reprompt Message After Removing Tool
    Capture Page Screenshot
    Delete Conversation In Builder


Verify Validation Prompt is added for 'Video Response' question (OL-T25749, OL-T25750, OL-T25751, OL-T25752, OL-T25753, OL-T25754)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add New Conversation With Draft Status      ${SINGLE_PATH_PRIORITY_TEMPLETE}
    ${list_msg} =       Create List     ${REPROMPT_VIDEO_RESPONSE_MESSAGE_1}    ${REPROMPT_VIDEO_RESPONSE_MESSAGE_2}    ${REPROMPT_VIDEO_RESPONSE_MESSAGE_3}
    Add New Item In Video Response Question
    # OL-T25749
    Reopen Modal Edit Reprompt Message      None    is_screening_question=True
    Check Edit Reprompt Message Modal       3       ${list_msg}
    # OL-T25751
    Change Validation Prompt Message    3
    # OL-T25750
    Reopen Modal Edit Reprompt Message      None    is_screening_question=True
    Check Add Validation Prompt     3
    # OL-T25752
    Reopen Modal Edit Reprompt Message      None    is_screening_question=True
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    # OL-T25753
    Check Cancel And Close Option In Edit Reprompt Message Modal Of Global Question
    # OL-T25754
    Verify Don't Show Edit Reprompt Message After Removing Tool
    Capture Page Screenshot
    Delete Conversation In Builder


Verify Validation Prompt is added for 'EEO' question (OL-T25755, OL-T25756, OL-T25757, OL-T25758, OL-T25759, OL-T25760)
    Login Then Open Edit Reprompt Message Modal     ${ECLIPSE_EEO_QUESTION}     ${SINGLE_PATH_PRIORITY_TEMPLETE}
    # OL-T25755
    Check Edit Reprompt Message Modal       3       ${list_reprompt_msg_eeo}
    # OL-T25757
    Change Validation Prompt Message    3
    # OL-T25756
    Reopen Modal Edit Reprompt Message      ${ECLIPSE_EEO_QUESTION}
    Check Add Validation Prompt     3
    # OL-T25758
    Reopen Modal Edit Reprompt Message      ${ECLIPSE_EEO_QUESTION}
    Check Delete Icon Option In Edit Reprompt Message Modal     6
    # OL-T25759
    Reopen Modal Edit Reprompt Message      ${ECLIPSE_EEO_QUESTION}
    Check Cancel And Close Option In Edit Reprompt Message Modal    ${ECLIPSE_EEO_QUESTION}
    # OL-T25760
    Turn On/ Off Toggle To Verify Disabled Element      True    ${ECLIPSE_EEO_QUESTION}
    Delete Conversation In Builder


Check validation prompt message of 'Introduction', 'Email', 'Phone', 'Communication Preference', 'List select', 'Document Upload', 'Video response', 'EEO' question types when multi language is supported (OL-T25761)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_PRIORITY_TEMPLETE}
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


Verify show validation prompt message for 'Introduction' question when candidate inputs invalid name in case start conver via WEB (OL-T25762, OL-T25766)
    [Documentation]
    ...     Precondition:
    ...         Conversation name: "Single Path (Prioritized Location) Conversation Multi Languages"
    ...         Assign conversation to Landing site name: "SinglePathPrioritizedLocationEnglishConversationSite"
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${candidate_infor} =    Generate Candidate Name
    ${site_url} =       Get Landing Site Url By String Concatenation    COMPANY_FRANCHISE_ON    ${english_conv_site_name}
    Go To       ${site_url}
    # OL-T25762
    Input Text And Send Message     Invalid message introduction
    Verify AI Message When Asking About Name In     Landing Site
    Input Text And Send Message     Wrong message
    Verify AI Message When Asking About Name In     Landing Site
    Input Text And Send Message     ${candidate_infor.full_name}
    ${ask_phone} =      Format String       ${ask_phone_msg}    ${candidate_infor.first_name}
    Verify Olivia Conversation Message Display      ${ask_phone}
    # OL-T25766
    Input Text And Send Message     123
    Verify AI Reprompt Message When Asking      @{list_repompt_msg_phone}
    Input Text And Send Message     456
    Verify AI Reprompt Message When Asking      @{list_repompt_msg_phone}
    Input Text And Send Message     ${CONST_PHONE_NUMBER}
    Verify Olivia Conversation Message Display      ${QUESTION_EMAIL}
    Capture Page Screenshot


Check Care/Job search at Introduction question (OL-T25765)
    [Documentation]
    ...     Precondition:
    ...         Conversation name: "Single Path (Prioritized Location) Care/ Job Search Conversation"
    ...         Assign conversation to Landing site name: "SinglePathPrioritizedLocationCareConversationSite"
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${candidate_infor} =    Generate Candidate Name
    ${site_url} =       Get Landing Site Url By String Concatenation    COMPANY_FRANCHISE_ON    ${care_conv_site_name}
    Go To       ${site_url}
    Input Text And Send Message     Tell me about your company
    Verify Olivia Conversation Message Display      ${care_response}
    Verify AI Message When Asking About Name In     Landing Site
    Input Text And Send Message     ${candidate_infor.full_name}
    ${ask_phone} =      Format String       ${ask_phone_msg}    ${candidate_infor.first_name}
    Verify Olivia Conversation Message Display      ${ask_phone}
    Capture Page Screenshot

# ==================================================================================== PART 2 =======================================================================================================


Verify show validation prompt message for 'Phone number' question when candidate inputs skip intent for 'Phone number' question in case start conver via WEB. (OL-T25767)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${url} =    Open landing site and get url       ${site_names}[0]
    ${candidate_name} =     Generate candidate name
    Go to       ${url}
    Verify AI latest message using regexp       ${WELCOME_CANDIDATE_MESSAGE_4}
    Input text and send message without wait    ${candidate_name.full_name}
    Verify AI latest message using regexp       ${REPROMPT_PHONE_MESSAGE_1}
    Input text and send message without wait    skip
    Verify AI reprompt message when asking      @{english_reprompt_phone_messages}
    ${phone_number} =       Send random phone number
    Input text and send message without wait    1
    Wait for Olivia reply
    Go to CEM page
    Verify candidate summary item       ${candidate_name.full_name}     phone_number=${phone_number[2:]}
    Capture Page Screenshot


Check message reprompt of question type 'Phone number' when multi language is supported. (OL-T25770)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${url} =    Open landing site and get url       ${site_names}[1]
    ${candidate_name} =     Generate candidate name
    Go to       ${url}
    Verify AI latest message using regexp       ${WELCOME_CANDIDATE_MESSAGE_4}
    Input text and send message without wait    ${candidate_name.full_name}
    Verify AI latest message using regexp       ${REPROMPT_PHONE_MESSAGE_1}
    Input text and send message without wait    Speak to Hebrew
    Wait for Olivia reply
    Input text and send message without wait    ${invalid_phone_number}
    Verify AI reprompt message when asking      @{hebrew_reprompt_phone_messages}
    Input text and send message without wait    Speak to English
    Wait for Olivia reply
    Input text and send message without wait    ${invalid_phone_number}
    Verify AI reprompt message when asking      @{english_reprompt_phone_messages}
    Send random phone number


Verify show validation prompt message for 'Phone number' question when candidate inputs valid email address for 'Phone number' question in case start conver via WEB. (OL-T25771)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${url} =    Open landing site and get url       ${site_names}[0]
    ${candidate_name} =     Generate candidate name
    ${email_info} =     Get email for testing
    Go to       ${url}
    Verify AI latest message using regexp       ${WELCOME_CANDIDATE_MESSAGE_4}
    Input text and send message without wait    ${candidate_name.full_name}
    Verify AI latest message using regexp       ${REPROMPT_PHONE_MESSAGE_1}
    Input text and send message without wait    ${email_info.email}
    Verify AI latest message using regexp       ${REPROMPT_PHONE_MESSAGE_14}
    Input text and send message without wait    ${invalid_phone_number}
    Verify AI reprompt message when asking      @{english_reprompt_phone_messages}
    ${phone_number} =       Send random phone number
    Input text and send message without wait    1
    Wait for Olivia reply
    Go to CEM page
    Verify candidate summary item       ${candidate_name.full_name}     ${email_info.email}     ${phone_number[2:]}
    Capture Page Screenshot

*** Keywords ***
Reopen modal Edit Reprompt Message
    [Arguments]    ${eclipse_question}  ${is_screening_question}=False
    IF  '${is_screening_question}' != 'False'
        Click At    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
        Click At    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}   ${EDIT_REPROMPT_MESSAGE}
    ELSE
        Click At    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${eclipse_question}
        Click At    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    END

Verify don't show Edit Reprompt Message after removing tool
    Click At    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}   ${REMOVE_TOOL}
    Click At    ${REMOVE_TOOL_YES_BUTTON}
    Check Element Display On Screen    Your changes were saved.
    Click At    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check Element Not Display On Screen    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}   ${EDIT_REPROMPT_MESSAGE}

Turn on/ off toggle to verify disabled element
    [Arguments]    ${on_toggle}     ${off_toggle}
    IF  '${on_toggle}' != 'True'  # as a default, some of toggle was on
        Turn On     ${CUSTOM_CONVERSATION_TOGGLE}       ${on_toggle}
    END
    Turn Off    ${CUSTOM_CONVERSATION_TOGGLE}       ${off_toggle}
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}      ${off_toggle}
    Check Element Not Display On Screen     ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}       ${EDIT_REPROMPT_MESSAGE}
    Capture Page Screenshot
