*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${test_location_name}                       ${CONST_LOCATION}
${job_family_name}                          Coffee family job

*** Keywords ***
Prepare Offer Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add a Custom Location Attributes    ${custom_location_attr_with_value}
    Add a Custom Location Attributes    ${custom_location_attr_without_value}
    Enable Client Setup for Location Attributes / Offer    Hire
    Add a Location    ${COMPANY_FRANCHISE_ON}    ${test_location_name}
    Assign Custom location attribute    ${test_location_name}    ${custom_location_attr_with_value}
    Go to Location Management page
    Assign user to location    ${test_location_name}    Full User Automation

Enable Client Setup for Location Attributes / Offer
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'Hire'
        Click at    ${HIRE_LABEL}
        Turn on    ${OLIVIA_HIRE_TOGGLE}
        Turn on    ${CANDIDATE_JOURNEYS_TOGGLE}
        Turn on    ${OFFER_TOGGLE}
        Turn on    ${JOBS_TOGGLE}
        Click at    ${AVAILABLE_JOB_TYPES_DROPDOWN}
        Run keyword and ignore error    Click at    ${AVAILABLE_JOB_SELECT_ALL_CHECKBOX}    wait_time=2s
        Click at    ${AVAILABLE_JOB_APPLY_BUTTON}
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

*** Test Cases ***
Prepare Offer Data test for Suite
    Prepare Offer Data test
