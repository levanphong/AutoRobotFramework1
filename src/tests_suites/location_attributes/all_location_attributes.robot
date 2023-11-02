*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/location_attributes_page.robot
Resource            ../../data_tests/location_attributes/location_attributes.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Test Cases ***
Verify that All Location Attributes's list is correct (OL-T12851)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    Then All Location Attributes list is displayed
    Capture page screenshot


Verify the user can search location attributes in search box in All location attributes list (OL-T12853)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Input keyword in attributes search box    Country
    Then Location attributes that match the text input are displayed    Country
    Capture page screenshot


Verify displayed message No Results Found incase no result returns when searching attribute (OL-T12854)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Input keyword in attributes search box    CityAddress
    Then The message "No Results Found" is displayed
    Capture page screenshot


Verify If the Attribute Description extends past the viewable region in the row (OL-T12855)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Verify If the Attribute Description extends past the viewable region in the row    Custom Location Attribute
    Capture page screenshot
    Then Display the full description in a hover state component    Custom Location Attribute
    Capture page screenshot


Verify display when user click on Ellipse shape on attribute has type Custom (OL-T12856)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Click on Ellipse shape    Custom Location Attribute
    Then modal Action of Location Attribute is displayed    Custom Location Attribute
    Capture page screenshot


Verify modal All Location Attributes Editing incase attribute has type Standard location attribute (OL-T12857)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Open Edit Location Attribute modal    State
    Then modal Edit Standard Location Attribute displayed correctly
    Capture page screenshot


Verify modal All Location Attributes Editing incase attribute has type Custom location attribute (OL-T12858)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Open Edit Location Attribute modal    Custom Location Attribute
    Then modal Edit Custom Location Attribute displayed correctly
    Capture page screenshot


Verify show message error incase any field is still null (OL-T12859)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Open Edit Location Attribute modal    Location Name
    Clear element text with keys    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Field required.
    Capture page screenshot


Verify can save Location attributes when all fields are filled out (OL-T12860)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    wait for page load successfully v1
    when Open Edit Location Attribute modal    ${attribute_name_random}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_KEY}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_SAVE}
    Then attribute edited successfully and display in Location Attribute list    ${attribute_name_random}
    Capture page screenshot
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify close the modal and can not save Location attributes when user click Cancel button (OL-T12861)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Open Edit Location Attribute modal    Location ID
    Input text    ${INPUT_ATTRIBUTE_DESCRIPTION}    Location ID edited
    Click at    ${BUTTON_CANCEL}
    Then Close the modal and can not save data    Location ID edited
    Capture page screenshot


Verify can delete Location Attribute when user click Delete option (OL-T12862)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Click on Ellipse shape    ${attribute_name_random}
    when Click Delete button    ${attribute_name_random}
    Then Delete Location Attribute modal is displayed
    Capture page screenshot
    Click at    ${BUTTON_OK_MODAL_DELETE}
    Then Location Attribute successfully deleted    ${attribute_name_random}
    Capture page screenshot


Verify user can toggle ON/OFF The Add attribute to reports (OL-T12868)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Open Edit Location Attribute modal    Location Email
    Then User can ON/OFF toggle Add attribute to report


Verify behavior if user clicks outside Location Attributes modal (OL-T12870)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    when Open Edit Location Attribute modal    Location Email
    wait with short time
    Click element   ${OUTSIDE_FRAME}
    Then Location Attributes modal is closed
    Capture page screenshot


Verify button Add Attributes displays on All Attributes sections. (OL-T12871)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    Check element display on screen    ${BUTTON_ADD_ATTRIBUTE}
    Capture page screenshot
