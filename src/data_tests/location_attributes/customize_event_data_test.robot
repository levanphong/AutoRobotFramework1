*** Settings ***
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/system_attributes_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${event_conversation_name}      Event_Convo_Single_Path

*** Keywords ***
Prepare Custommize Events Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Add a Custom Location Attributes    Add custom
    Add a Custom Location Attributes    Location Manager
    ${is_exesting} =    Check conversation name is existing    ${event_conversation_name}
    IF    '${is_exesting}' == 'False'
        Add Event Registration Single conversation    Event Registration (Single Path)    ${event_conversation_name}
    END

Add Event Registration Single conversation
    [Arguments]    ${type}    ${event_conversation_name}
    Go to conversation builder
    Click at    Add Conversation
    Click at    Add New Conversation
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${event_conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT}    ${type}
    Click by JS    ${conversation_template}
    Click at    ${AVAILABLE_LOCATIONS_DROPDOWN}
    Click at    ${AVAILABLE_LOCATIONS_SELECT_LOCATION_OPTION}
    input into    ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${LOCATION_STREET_TRUNG_NU_VUONG}
    ${location_name_locator} =    Format String    ${AVAILABLE_LOCATIONS_SELECT_BY_LOCATION_NAME}    ${LOCATION_STREET_TRUNG_NU_VUONG}
    Click at    ${location_name_locator}
    Click at    ${EMAIL_TOGGLE}
    Click at    ${PHONE_NUMBER_TOGGLE}
    Press Keys    None    RETURN
    wait for page load successfully
    Public the conversation
    [Return]    ${event_conversation_name}

*** Test Cases ***
Prepare data test for Location Attributtes - Event
    Prepare Custommize Events Data test
