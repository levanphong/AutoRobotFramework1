*** Settings ***
Resource            ./conversation_builder.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression  test

*** Test Cases ***
Verify UI at Dynamic conversation (OL-T29411, OL-T29412, OL-T29413)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DYNAMIC_CONVERSATION}
    Go To Conversation Builder
    ${conversation_name}=       Generate random name    auto_dynamic_convo_
    ${random_content} =     Generate Random Text Only
    when Add new conversation with name and type    ${conversation_name}    Dynamic ATS conversation
    FOR    ${section_title}    IN    @{section_titles}
        Check Element Display On Screen     ${CONVERSATION_SECTION_TITLE}       ${section_title}
    END
    Check Toggle Is Off     ${COMMUNICATION_PREFERENCE_TOGGLE}
    # Verify UI Communication Preference at Dynamic conversation (OL-T29412)
    Click By JS     ${COMMUNICATION_PREFERENCE_TOGGLE}
    Edit a Section's Default Content then Verify new content    ${conversation_name}    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}      ${COMMUNICATION_PREFERENCE_DEFAULT_CONTENT}     ${random_content}
    Click By JS     ${COMMUNICATION_PREFERENCE_TOGGLE}
    Check Element Display On Screen     ${CONVERSATION_DISABLE_SECTION_TITLE}       Communication Preference
    Click By JS     ${CONVERSATION_WHATS_APP}
    Click At    ${CONVERSATION_WHATS_APP_DROPDOWN}      On
    FOR    ${contact_method}    IN    @{contact_methods}
        Check Element Display On Screen     ${CONVERSATION_CONTACT_METHOD_TITLE}    ${contact_method}
        Check Element Display On Screen     ${CONVERSATION_CONTACT_METHOD_CHECKED_CHECKBOX}     ${contact_method}
    END
    Click By JS     ${CONVERSATION_WHATS_APP}
    Click At    ${CONVERSATION_WHATS_APP_DROPDOWN}      Off
    # Verify update content at skip prompt message of Communication Preference (OL-T29413)
    Update content's skip prompt message of Communication Preference    ${random_content}
    Public conversation then Verify content's skip prompt message of Communication Preference       ${conversation_name}    ${random_content}
    Delete conversation in builder
