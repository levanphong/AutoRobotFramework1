*** Settings ***
Resource            ../../pages/custom_conversation_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/ratings_page.robot
Variables           ../../locators/custom_conversation_locators.py
Variables           ../../locators/ratings_locators.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${conversation_name}        conversation for rating widget

*** Test Cases ***
Create custom conversation with rating for widget
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to conversation builder
    when Add new custom conversation with name and welcome question     ${conversation_name}
    Add question by type    Welcome     Full Name
    Add question by type    Full Name       Email
    Add question by type    Email       End Conversation
    Public custom conversation

*** Keywords ***
Create custom conversation with rating
    [Arguments]    ${rating_name}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Custom_${random}
    when Add new custom conversation with name and welcome question    ${conversation_name}
    Add question by type    Welcome    Full Name
    Add question by type    Full Name    Email
    Add question by type    Email    Send Rating
    Click At    ${CUSTOM_CONVERSATION_QUESTION_MENU_RATING}
    ${CUSTOM_CONVERSATION_QUESTION_RATING_SELECT}=    Format String   ${CUSTOM_CONVERSATION_QUESTION_RATING_SELECT}     ${rating_name}
    Scroll To Element   ${CUSTOM_CONVERSATION_QUESTION_RATING_SELECT}
    Click At    ${CUSTOM_CONVERSATION_QUESTION_RATING_SELECT}
    Public custom conversation
    [Return]    ${conversation_name}
