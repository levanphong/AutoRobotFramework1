*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/sales_demo_locators.py

*** Keywords ***
Add a Widget to Sales Demo
    [Arguments]    ${widget_name}
    Go to Sales Demo page
    ${demo_url} =    Get value and format text    ${SALES_DEMO_URL_TEXT_BOX}
    Go to Sales Demo page
    Input into    ${SALE_PAGE_PASSWORD_TEXT_BOX}    1234
    Input into    ${SALE_PAGE_COMPANY_URL_TEXT_BOX}    auto_url
    Click at    ${WIDGET_SELECTION_DROPDOWN}
    Click at    ${widget_name}
    Click at    ${SALES_DEMO_SAVE_BUTTON}
    Check element display on screen  Your changes have been saved.
    [Return]    ${demo_url}

Run Demo site and input common information
    [Arguments]    ${demo_url}    ${question}
    Go to    ${demo_url}
    Input into    ${DEMO_SITE_PASSWORD_TEXT_BOX}    1234
    Click at    ${DEMO_SITE_SIGN_IN_BUTTON}
    ${numbers} =    Evaluate    random.randint(0, sys.maxsize)    random
    Input into    ${INPUT_TEXTBOX}    Test Candidate_${numbers}
    Click at    ${CONVERSATION_SEND_BUTTON}
    Wait with medium time
    Press Keys then Click with delay    ${CONST_PHONE_NUMBER}    ${CONVERSATION_SEND_BUTTON}
    Press Keys then Click with delay    18    ${CONVERSATION_SEND_BUTTON}
    Press Keys then Click with delay    Nothing    ${CONVERSATION_SEND_BUTTON}
    Press Keys then Click with delay    1    ${CONVERSATION_SEND_BUTTON}
    Press Keys then Click with delay    ${question}    ${CONVERSATION_SEND_BUTTON}
