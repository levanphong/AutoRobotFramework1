*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${test_location_name}                       Amsterdam
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value

*** Keywords ***
Prepare Workflows Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add a Custom Location Attributes    ${custom_location_attr_with_value}
    Add a Custom Location Attributes    ${custom_location_attr_without_value}
    Enable Client Setup for Location Attributes / Workflows    More
    Add a Location    ${COMPANY_FRANCHISE_ON}    ${test_location_name}
    Assign Custom location attribute    ${test_location_name}    ${custom_location_attr_with_value}

Enable Client Setup for Location Attributes / Workflows
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'More'
        Click at    ${MORE_LABEL}
        Turn on    ${WORKFLOWS_TOGGLE}
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

*** Test Cases ***
Prepare Workflows Data test for Suite
    Prepare Workflows Data test
