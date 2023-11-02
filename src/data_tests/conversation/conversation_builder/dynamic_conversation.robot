*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/web_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${site_name}    Dynamic Conversation For Contact Information - Street Address

*** Test Cases ***
Create data test for dynamic ATS conversation
    Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create Landing Site/widget Site     Landing Site    site_name=${site_name}
    Capture Page Screenshot
