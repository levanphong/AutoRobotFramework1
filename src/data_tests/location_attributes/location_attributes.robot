*** Settings ***
Variables       ../../locators/client_setup_locators.py
Resource        ../../drivers/driver_chrome.robot
Resource        ../../pages/location_attributes_page.robot
Resource        ../../commons/common_keywords.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Keywords ***
Prepare Location Attributes Data test for Suite
    Prepare Location Attributes Data Test

Prepare Location Attribute Data test for Location Management Suite
    Prepare Location Attributes / Location Management Data test

Prepare Location Attributes Data Test
    Prepare Location Attributes Data Test with company    ${COMPANY_FRANCHISE_ON}

Prepare Location Attributes Data Test with company
    [Arguments]    ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    ${is_existed_attrbute} =    Run Keyword and Return Status    Attribute is displayed in Location Attribute list
    ...    Custom Location Attribute
    IF    '${is_existed_attrbute}' == 'False'
        Click at    ${BUTTON_ADD_ATTRIBUTE}
        Input into    ${INPUT_ATTRIBUTE_NAME}    Custom Location Attribute
        Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    Location phone in Location Management
        Click at    ${BUTTON_CREATE}
        Then new attribute addded successfully and display in Location Attribute list    Custom Location Attribute
    END

Prepare Location Attributes / Location Management Data test
    Add a Custom Location Attribute    Custom Location Management Attribute

Prepare job template job builder Data test for Suite
    Prepare job template job builder Data test

Prepare job template job builder Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${job_builder_company_name}
    Enable Client Setup for job builder    Hire
    Add a Custom Location Attributes    Location Manager
    Add a Custom Location Attributes    Add custom

Enable Client Setup for job builder
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'Hire'
        Click at    ${HIRE_LABEL}
        Turn on    ${OLIVIA_HIRE_TOGGLE}
        Turn on    ${JOBS_TOGGLE}
        Turn on    ${JOB_DATA_PACKAGES_ON}
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    sleep    5s

*** Test Cases ***
Prepare Location Attributes Data Test
    Prepare Location Attributes Data Test
    Prepare Location Attributes / Location Management Data test
