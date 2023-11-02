*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Variables ***
${widget_brand}    WIDGET_BRAND

*** Test Cases ***
Check adding new Widget in case no select value into Brand Logo Dropdown (OL-T14811, OL-T14812, OL-T14813)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${site_name} =      Generate Random Name    auto_web
    Create landing site/widget site     Widget Conversation     ${site_name}    WIDGET_CONV     None    ${COMPANY_HIRE_ON}
    # Check adding new Widget in case select Brand Name into Brand Logo Dropdown (OL-T14812)
    Verify current branch then Change and Verify Widget Conversation's branch    ${site_name}    ${COMPANY_HIRE_ON}    ${widget_brand}
    # Check adding new Widget in case select Public company name into Brand Logo Dropdown (OL-T14813)
    Verify current branch then Change and Verify Widget Conversation's branch    ${site_name}    ${widget_brand}    ${COMPANY_HIRE_ON}
    Search and delete landing site    ${site_name}

*** Keywords ***
Search site name and check brand value
    [Arguments]    ${site_name}    ${brand_value}
    Search and click landing site    ${site_name}
    Check Element Display On Screen    ${BRANDING_DROPDOWN_SELECTED_VALUE}    ${brand_value}

Verify current branch then Change and Verify Widget Conversation's branch
    [Arguments]    ${site_name}    ${current_brand}    ${new_brand}
    Search site name and check brand value    ${site_name}    ${current_brand}
    Check Element Display On Screen    ${BRANDING_DROPDOWN}
    Click at    ${BRANDING_DROPDOWN}
    Click At    ${BRANDING_DROPDOWN_VALUE}    ${new_brand}
    Click At    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Check Text Display    Your changes have been saved.
    Search site name and check brand value    ${site_name}    ${new_brand}
