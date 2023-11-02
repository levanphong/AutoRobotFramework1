*** Settings ***
Resource            ../../pages/group_management_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${group_name}      Audience_builder_group

*** Test Cases ***
Create data test for cms audience builder with targeting rule is group (OL-T4843)
    Given Setup Test
    When Login Into System With Company    ${PARADOX_ADMIN}     ${COMPANY_COMMON}
    Add A Group     group_name=${group_name}
    Check Element Display On Screen    ${group_name}
    Capture Page Screenshot
