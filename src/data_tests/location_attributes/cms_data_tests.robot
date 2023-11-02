*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/location_management_page.robot


Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${test_location_name}                       ${CONST_LOCATION}

*** Keywords ***
Prepare CMS Data test
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Add a Custom Location Attributes    ${custom_location_attr_with_value}
    Add a Custom Location Attributes    ${custom_location_attr_without_value}
    Enable Client Setup for CMS    Care 1
    Enable Client Setup for CMS    Compliance and Security
    # CMS Toggle must be off to Add and Publish KB Spreadsheet URL
    # Turn off CMS Toggle
    # NEED TO ADD KB_URL MANUALLY - Knowledge Base pages
    # Add a Link to company spreadsheet    Candidate Care    ${candidate_kb_spreadsheet_url}
    # Add a Link to company spreadsheet    Employee Care    ${employee_kb_spreadsheet_url}
    Enable Client Setup for CMS    Care 2
    Add an Audience with IP in Vietnam
    Add a Location    ${COMPANY_EVENT}    ${test_location_name}
    Assign Custom location attribute    ${test_location_name}    ${custom_location_attr_with_value}

Enable Client Setup for CMS
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'Care 1'
        Click at    ${CARE_LABEL}
        Turn on    ${CANDIDATE_CARE_TOGGLE}
        Turn on    ${EMPLOYEE_CARE_TOGGLE}
    ELSE IF    '${item}' == 'Care 2'
        Click at    ${CARE_LABEL}
        Turn on    ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    ELSE IF    '${item}' == 'Compliance and Security'
        Click at    ${COMPLIANCE_AND_SECURITY_LABEL}
        Click at    ${TERMS_DISPLAY_AREA_DROPDOWN}
        ${checkbox_locator} =    Format String    ${TERMS_DISPLAY_AREA_VALUE}    EU
        Check the checkbox    ${checkbox_locator}
        ${checkbox_locator} =    Format String    ${TERMS_DISPLAY_AREA_VALUE}    Global
        Uncheck the checkbox    ${checkbox_locator}
        ${checkbox_locator} =    Format String    ${TERMS_DISPLAY_AREA_VALUE}    CCPA
        Uncheck the checkbox    ${checkbox_locator}
        ${is_changed} =    Run Keyword And Return Status    wait until element is visible
        ...    ${TERMS_DISPLAY_AREA_APPLY_BUTTON}
        IF    ${is_changed}
            Click at    ${TERMS_DISPLAY_AREA_APPLY_BUTTON}
        END
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

Turn off CMS Toggle
    Navigate to    Client Setup
    Click at    ${CARE_LABEL}
    Turn off    ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

*** Test Cases ***
Prepare CMS data test for suite
    Prepare CMS Data test
