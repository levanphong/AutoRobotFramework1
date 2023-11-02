*** Settings ***
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/location_attributes_page.robot
Resource            ../../data_tests/location_attributes/location_attributes.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Test Cases ***
Verify displayed when haven’t created attributes in Location Management (OL-T12873)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Location Management page
    Choose a location in location management page    Hawaii island
    Then Location Attribute section when haven't created any attributes displayed correctly
    Capture page screenshot


Verify the Location attribute in Location Management when the attribute has a value assigned for the location (OL-T12874)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Location Management page
    Choose a location in location management page    New York
    Then Location Attribute section when some attributes created displayed correctly
    Capture page screenshot


Verify the Location attribute in Location Management when super mega insanely long value text field (OL-T12875)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add a Custom Location Attribute    Super mega insanely long Location Attribute
    Go to Location Management page
    Choose a location in location management page    New York
    ${location_attribute_locator} =    format string    ${LABEL_ATTRIBUTE}    Super mega insanely long Location Attribute
    Input into      ${INPUT_SEARCH_ATTRIBUTE}       Super mega insanely long Location Attribute
    wait for page load successfully v1
    Check element display on screen    ${location_attribute_locator}
    Capture page screenshot


Verify that user can search Location Attribute in Location Management (OL-T12876)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Location Management page
    Choose a location in location management page    New York
    Input into    ${INPUT_SEARCH_ATTRIBUTE}    Custom Location Management Attribute
    wait for page load successfully v1
    Then Displayed custom location attribute matching text user input    Custom Location Management Attribute
    Capture page screenshot


Verify no result returns when have no matched keyword/ name location attributes on Search box. (OL-T12877)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Location Management page
    Choose a location in location management page    New York
    Input into    ${INPUT_SEARCH_ATTRIBUTE}    Abcde12342ew
    wait for page load successfully v1
    Then No data return when User input keyword not match with any attribute name    Abcde12342ew
    Capture page screenshot


Verify user can edit Location attribute in Location Management (OL-T12878, OL-T12880)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Location Management page
    Choose a location in location management page    New York
    when Open Edit Attribute modal    Custom Location Management Attribute
    Edit Attribute modal is displayed
    Capture page screenshot
    ${edited_attribute_name}=   generate random name    attribute_value_
    Input into    ${ATTRIBUTE_VALUE_TEXT_BOX}    ${edited_attribute_name}
    Click at    ${EDIT_LOCATION_ATTRIBUTE_SAVE_BUTTON}
    Then Location Attribute value saved successfully and displayed under attribute    ${edited_attribute_name}
    Capture page screenshot


Verify close the modal and can not save Location attributes when user click Cancel button (OL-T12879)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Location Management page
    Choose a location in location management page    New York
    when Open Edit Attribute modal    Custom Location Management Attribute
    Edit Attribute modal is displayed
    Capture page screenshot
    Input into    ${ATTRIBUTE_VALUE_TEXT_BOX}    attribute_value_edited
    Click at    ${EDIT_LOCATION_ATTRIBUTE_CANCEL_BUTTON}
    Then close modal and Location Attribute value does not save    attribute_value_edited
    Capture page screenshot
