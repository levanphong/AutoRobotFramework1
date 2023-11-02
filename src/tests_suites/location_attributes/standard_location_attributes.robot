*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/location_attributes_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Test Cases ***
Verify that Standard Location Attributes's list is correct (OL-T12803)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    Then Standard Location Attributes list is displayed
    Capture page screenshot


Verify the user can search location attributes in search box in Standard location attributes list (OL-T12805)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Input keyword in attributes search box    City
    Then Location attributes that match the text input are displayed    City
    Capture page screenshot


Verify displayed message No Results Found incase no result returns when searching attribute (OL-T12806)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Input keyword in attributes search box    CityAddress
    Then The message "No Results Found" is displayed
    Capture page screenshot


Verify If the Attribute Description extends past the viewable region in the row (OL-T12807)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Verify If the Attribute Description extends past the viewable region in the row    Location Phone
    Then Display the full description in a hover state component    Location Phone
    Capture page screenshot


Verify modal Standard Location Attributes Editing (OL-T12808)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Open Edit Location Attribute modal    Address
    Then modal Edit Standard Location Attribute displayed correctly
    Capture page screenshot


Verify show message error incase not input on field Attribute Description (OL-T12809)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Open Edit Location Attribute modal   Country
    Clear element text with keys    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Field required.
    Capture page screenshot


Verify can save Location attributes when all fields are filled out (OL-T12810)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Open Edit Location Attribute modal    Country
    when Change data on field Attributes Description    Location country edited
    when Click Save button
    Then Close the modal and save all data, show new data on Standard Location Attributes list    Location country edited
    Capture page screenshot


Verify close the modal and can not save Location attributes when user click Cancel button (OL-T12811)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Open Edit Location Attribute modal    Zip Code
    when Change data on field Attributes Description    Zip Code edited
    when Click Cancel button
    Then Close the modal and can not save data    Zip Code edited
    Capture page screenshot


Verify user can toggle ON/OFF The Add attribute to reports (OL-T12817)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Standard Location Attributes
    when Open Edit Location Attribute modal    Province
    Then User can ON/OFF toggle Add attribute to report
    Capture page screenshot
