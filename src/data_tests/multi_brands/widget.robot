*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/company_information_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare datatest for Widget conversation
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go To Conversation Builder
    when Add new conversation with name and type    WIDGET_CONV     Candidate Journey
    Public The Conversation
    Go to page in setting menu step by step     Company Information
    Click at    ${COMPANY_INFORMATION_PATTERN_NAV_TAB}      Brand Management
    Add a brand     WIDGET_BRAND

*** Keywords ***
Go to page in setting menu step by step
    [Arguments]    ${page_name}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${CEM_PAGE_RIGHT_MENU_SETTING_ICON}
    Click at    ${CEM_PAGE_RIGHT_MENU_ITEM}    ${page_name}
