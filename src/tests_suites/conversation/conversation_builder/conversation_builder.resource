*** Settings ***
Resource            ../../../pages/conversation_builder_page.robot
Resource            ../../../pages/custom_conversation_page.robot
Resource            ../../../drivers/driver_chrome.robot

*** Variables ***
@{section_titles}       Introduction    Contact Information    Additional Candidates Questions    Communication Preference    Consent to Marketing    Screening    Cover Video    Closing    Thank you
@{contact_methods}      Email Only    Text Message Only    WhatsApp Only    Email & Text Message    Email & WhatsApp

*** Keywords ***
Edit a Section's Default Content then Verify new content
    [Arguments]    ${conversation_name}    ${section}    ${default_content}    ${new_content}
    Verify Text Contain    ${section}    ${default_content}
    Input Into    ${section}    ${new_content}
    Public The Conversation
    Go To Conversation Builder
    Find and go to conversation detail    ${conversation_name}
    Verify Text Contain    ${section}    ${new_content}

Update content's skip prompt message of Communication Preference
    [Arguments]    ${new_content}
    Capture page screenshot
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}    Communication Preference
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}    Edit Reprompt Message
    Input Into    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TEXTBOX}    ${new_content}
    Click At    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Check Text Display    Changes saved successfully

Public conversation then Verify content's skip prompt message of Communication Preference
    [Arguments]    ${conversation_name}    ${new_content}
    Public The Conversation
    Go To Conversation Builder
    Find and go to conversation detail    ${conversation_name}
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION}    Communication Preference
    Click At    ${CUSTOM_CONVERSATION_ECLIPSE_OPTION}    Edit Reprompt Message
    Verify Text Contain    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TEXTBOX}    ${new_content}
    Click At    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_CANCEL_BUTTON}
