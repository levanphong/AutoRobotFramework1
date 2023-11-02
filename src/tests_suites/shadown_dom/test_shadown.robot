*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/event_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${text_welcom}      I am happy to help you get registered for TEST AUTOMATION EVENT's General_Event_Global_Long_Time event. To start, what is your first and last name?
${text_contact}     Can you please also provide me with your email so that a recruiter can contact you?

*** Test Cases ***
Verify show location Attributes list correctly at workflows (OL-T12989)
    go to    https://stg.paradox.ai/co/TESTAUTOMATIONEVENT/Event/GeneralEventGlobalLongTime
    Click at    ${REGISTER_EVENT}
    wait for page load successfully
    check message widget response correct    ${text_welcom}    0
    Input text for widget    Thu Tran
    click element    ${SEND_BUTTON_CONV}
    wait for page load successfully
    check message widget response correct    ${text_contact}    1

*** Keywords ***
check message widget response correct
    [Arguments]    ${message}    ${index}
    ${locator} =    FORMAT STRING    ${MESSAGE_CONVERSATION}    ${index}
    wait until element is visible    ${locator}
    wait until element contains    ${locator}    ${message}
    Check element display on screen    ${locator}
    element should contain    ${locator}    ${message}

Input text for widget
    [Arguments]    ${message}
    input text
    ...    dom:document.querySelector("div.event-widget > apply-widget").shadowRoot.querySelector("div[contenteditable='true'][data-testid='widget_input_text'")
    ...    Thu Tran
