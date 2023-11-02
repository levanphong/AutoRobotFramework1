*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/conversation_builder_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_page.robot

Documentation       Run 'src/data_tests/conversation/conversation_builder/dynamic_conversation.robot'

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        test

*** Variables ***
${editing_content_for_introduction}                 This message is used for editing the content of dynamic ats section for introduction
${editing_content_for_marketing}                    This message is used for editing the content of dynamic ats section for content to marketing
${editing_content_cover_video}                      This message is used for editing the content of dynamic ats section for cover video
${editing_content_for_email_address}                This message is used for editing the content of dynamic ats section for email address
${editing_content_for_closing}                      This message is used for editing the content of dynamic ats section for closing
${editing_content_for_phone_number}                 This message is used for editing the content of dynamic ats section for phone number
${consent_to_marketing_content}                     Great! We would like to keep in touch via email. Is it ok to send emails to the
...                                                 address you provided? You can find our privacy policy at
${cover_video_content}                              Thanks for your responses! Please send us a short video of yourself telling us
...                                                 why you want to work here. You may also 'skip' this.
${email_address_content}                            Thank you. What is your email address?
${closing_content}                                  Thank you for your interest in #company-name. We will reach out to you within three business days.
${phone_number_content}                             Thank you #candidate-firstname. Can you please provide me with your mobile phone number so that a recruiter can contact you?
@{ats_address_fields}                               Street (Line 1)    Street (Line 2)    City    State / Province    Postal Code    Country
@{eeo_list_label}                                   Race    Ethnicity    Gender    Veteran
@{additional_candidate_question_subtool_list}       Add Tool    ATS Mapping    System Attribute    Hide Question    Delete Question
@{ats_conv_sections}                                Introduction    Contact Information    Additional Candidates Questions    Consent to Marketing    Street Address    Screening    Cover Video    Closing    Thank you    Screening and Actions
${eeo_response}                                     Our company values diversity. We invite you to provide voluntary EEO demographic information in a confidential survey. It will not be accessible during the hiring process, and has no effect on your opportunity for employment.
${ats_text_input}                                   Message for ats mapping input text
${site_name}                                        Dynamic Conversation For Contact Information - Street Address
${full_address}                                     1067 S Chateau Point, Inverness, FL 34450, USA

*** Test Cases ***
Check the list of Conversation Template when ATS Intergration toggle is OFF (OL-T2859, OL-T2877)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Check Template "Dynamic ATS Conversation" Not Displayed In Conversation Builder
    Capture Page Screenshot
    # OL-T2877
    # ATS Integration is None
    Logout From System By URL
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Navigate To Option In Client Setup      Integrations
    Check Toggle Is On      ${ATS_TOGGLE}
    Check Element Display On Screen     ${ATS_SYSTEM_SELECTION}
    Check Template "Dynamic ATS Conversation" Not Displayed In Conversation Builder
    Capture Page Screenshot


Contact Information - Introduction (OL-T2920, OL-T2875, OL-T2941, OL-T2876)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    # OL-T2875
    Navigate To Option In Client Setup      Integrations
    Check Toggle Is On      ${ATS_TOGGLE}
    Verify Attribute Should Contain     selected    ${EMPTY}    ${ATS_SYSTEM_NAME}      SuccessFactors
    # OL-T2876
    Add Dynamic Conversation
    # OL-T2920
    Simulate Input      ${CONVERSATION_TEMPLATE_INPUT_SECTION}      ${editing_content_for_introduction}     Introduction
    # OL-T2941
    Click At    (${CANDIDATE_QUESTION_SUBTOOL_BUTTON})[last()]
    FOR     ${item}     IN      @{additional_candidate_question_subtool_list}
        Check Element Display On Screen     ${QUESTION_TOOLTIP_MENU}    ${item}
    END
    Public The Conversation
    Page Should Contain     ${editing_content_for_introduction}
    Delete Conversation In Builder


ATS Mapping for Street Address (OL-T2879, OL-T2922, OL-T2925, OL-T2927, OL-T2928, OL-T2940)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Add Dynamic Conversation
    # OL-T2940
    Click At    ${CONVERSATION_TEMPLATE_INPUT_SECTION}      Email Address
    Check Element Display On Screen     ${email_address_content}
    Simulate Input      ${CONVERSATION_TEMPLATE_INPUT_SECTION}      ${editing_content_for_email_address}    Email Address
    # OL-T2922
    Click At    ${ICON_SUBTOOL_MENU_EACH_SECTION}       Street Address
    Click Question Tooltip In Eclipse Menu      ATS Mapping
    FOR     ${field}    IN   @{ats_address_fields}
        Click At    ${ATS_MAPPING_INPUT_WITH_ADDRESS_DATA_METHOD}       ${field}
        Input Into      ${ATS_MAPPING_INPUT_WITH_ADDRESS_DATA_METHOD}       sample_ats_mapping_street_address       ${field}
    END
    Click At    ${ATS_POPUP_SAVE_BUTTON}
    Check Element Display On Screen     Changes saved successfully
    Check Element Display On Screen     ${ICON_ATS_MAPPING}     Street Address
    Capture Page Screenshot
    # OL-T2925
    Check Element Display On Screen     ${consent_to_marketing_content}
    Simulate Input      ${CONVERSATION_TEMPLATE_INPUT_SECTION}      ${editing_content_for_marketing}    Consent to Marketing
    # OL-T2927
    Turn On     ${SECTION_TOGGLE}       Cover Video
    Check Element Display On Screen     ${cover_video_content}
    Simulate Input      ${CONVERSATION_TEMPLATE_INPUT_SECTION}      ${editing_content_cover_video}      Cover Video
    Public The Conversation
    Check Element Display On Screen     ${editing_content_for_marketing}
    Check Element Display On Screen     ${editing_content_cover_video}
    Check Element Display On Screen     ${editing_content_for_email_address}
     # OL-T2928
    Page Should Contain     Olivia will ask questions from each requisition automatically
    Capture Page Screenshot
    Delete Conversation In Builder


Equal Employment Opportunity (OL-T2929, OL-T2945)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DYNAMIC_CONVERSATION}
    Add Dynamic Conversation
    # OL-T2939
    Click At    ${CONVERSATION_TEMPLATE_INPUT_SECTION}      Phone Number
    Page Should Contain     ${phone_number_content}
    Simulate Input      ${CONVERSATION_TEMPLATE_INPUT_SECTION}      ${editing_content_for_phone_number}     Phone Number
    # OL-T2929
    Click At    ${ICON_SUBTOOL_MENU_EACH_SECTION}       Equal Employment Opportunity
    FOR     ${eeo_infor}    IN      @{eeo_list_label}
        Check Span Display      ${eeo_infor}
    END
    Check Element Display On Screen     ${eeo_response}
    # OL-T2945
    Page Should Contain     ${closing_content}
    Simulate Input      ${CONVERSATION_TEMPLATE_INPUT_SECTION}      ${editing_content_for_closing}      Closing
    Public The Conversation
    Page Should Contain     ${editing_content_for_closing}
    Page Should Contain     ${editing_content_for_phone_number}
    Capture Page Screenshot
    Delete Conversation In Builder


Check adding ATS mapping to questions (OL-T2942)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DYNAMIC_CONVERSATION}
    Add Dynamic Conversation
    Check adding ATS mapping to questions
    Delete Conversation In Builder


Contact Information - Street Address (OL-T2921)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =      Add Dynamic Conversation
    ${candidate_info} =     Generate candidate name
    Click At    ${ICON_SUBTOOL_MENU_EACH_SECTION}       Street Address
    Check Element Display On Screen     ${QUESTION_TOOLTIP_MENU}    ATS Mapping
    Check Element Display On Screen     ${QUESTION_TOOLTIP_MENU}    System Attribute
    ${site_url} =       Assign The Conversation To The Landing Site/widget Site     ${conversation_name}    ${site_name}
    Go To       ${site_url}
    Input text and send message     ${candidate_info.full_name}
    Input Text And Send Message     ${CONST_EMAIL}
    Input Text And Send Message     ${CONST_PHONE_NUMBER}
    Verify Olivia Conversation Message Display      ${ASK_AGE}
    Input Text And Send Message     24
    Verify Olivia Conversation Message Display      Your like?
    Input Text And Send Message     Like
    Verify Olivia Conversation Message Display      ${consent_to_marketing_content}
    Input Text And Send Message     Yes
    Verify Olivia Conversation Message Display      ${STREET_ADDRESS_QUESTION}
    Input Text For Street Address Case
    Verify Olivia Conversation Message Display      Thanks! Just to confirm, is your full address ${full_address}?
    Input Text And Send Message     No
    Verify Olivia Conversation Message Display      ${CONFIRM_ADDRESS_QUESTION}
    Capture Page Screenshot
    Go To Conversation Builder
    Find And Go To Conversation Detail      ${conversation_name}
    Delete Conversation In Builder

*** Keywords ***
Check template "Dynamic ATS conversation" not displayed in Conversation builder
    Go To Conversation Builder
    Click Add Conversation
    Click At    ${CONVERSATION_TEMPLATE}
    Check Element Not Display On Screen     Dynamic ATS conversation    wait_time=5s

Check adding ATS mapping to questions
    ${list_section} =   Create List    Introduction     Email Address   Phone Number
    FOR     ${section}     IN      @{list_section}
        Click At    ${ICON_SUBTOOL_MENU_EACH_SECTION}   ${section}
        Click At    ${QUESTION_TOOLTIP_MENU}    ATS Mapping
        Simulate Input    (${ATS_FIELD_TEXTBOX})[last()]    ${ats_text_input}
        Click At    ${ATS_POPUP_SAVE_BUTTON}
        Wait For Page Load Successfully V1
        Check Element Display On Screen    ${ICON_ATS_MAPPING}  ${section}
    END

Input text for street address case
    Wait For Olivia Reply
    Input Into    ${CONVERSATION_INPUT_TEXTBOX}     1067 S Chateau Pt
    Press Keys    None  SHIFT+RETURN
    Input Text    ${CONVERSATION_INPUT_TEXTBOX}     Inverness, Florida(FL), 34450   clear=False
    Click At    ${CONVERSATION_SEND_BUTTON}
