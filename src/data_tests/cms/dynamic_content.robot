*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/dynamic_content_page.robot
Resource            ../../pages/group_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test

*** Variables ***
${group_a}      OL-T17270_groupa
${group_b}      OL-T17270_groupb

*** Test Cases ***
Prepare data test
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    Navigate to Option in client setup              Care
    Turn on                 ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    Save client setup page
    Click on strong text    More
    Turn on                 ${EXPERIENCE_TOGGLE}
    Save client setup page


Prepare test data for test case OL-T17270
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    ${is_existed}=          run keyword and return status                   Search a group          OL-T17270
    IF  '${is_existed}'=='False'
        Add a Group             group_name=${group_a}
        Add a Group             group_name=${group_b}
    END
