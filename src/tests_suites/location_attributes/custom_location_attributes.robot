*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../data_tests/location_attributes/location_attributes.robot
Resource            ../../pages/location_attributes_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Test Cases ***
Verify that Custom Location Attributes's list is correct (OL-T12818)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Then Custom Location Attributes list is displayed
    Capture page screenshot


Verify that Custom Location Attributes's list is correct incase doesn't have any attribute on list (OL-T12819)
    Given Setup test
    Login into system    ${PARADOX_ADMIN}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Then message "You haven’t created any location attributes yet." is displayed
    Capture page screenshot


Verify the user can search location attributes in search box in Custom location attributes list (OL-T12821)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Input keyword in attributes search box    Custom Location Attribute
    Then Location attributes that match the text input are displayed    Custom Location Attribute
    Capture page screenshot


Verify displayed message No Results Found incase no result returns when searching attribute (OL-T12822)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Input keyword in attributes search box    CityAddress
    Then The message "No Results Found" is displayed
    Capture page screenshot


Verify If the Attribute Description extends past the viewable region in the row (OL-T12823)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Verify If the Attribute Description extends past the viewable region in the row    Custom Location Attribute
    Then Display the full description in a hover state component    Custom Location Attribute
    Capture page screenshot


Verify modal Add Custom Location Attribute (OL-T12824)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    Then modal Add Custom Location Attribute is displayed
    Capture page screenshot


Verify show message error incase Attribute Name field is still null (OL-T12825, OL-T12826, OL-T12827)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    Verify element is disable   ${BUTTON_CREATE}
    Input into    ${INPUT_ATTRIBUTE_NAME}    Custom Attributes
    Input into    ${INPUT_ATTRIBUTE_KEY}    Custom Attributes
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    Custom Attributes
    Clear element text with keys    ${INPUT_ATTRIBUTE_NAME}
    Clear element text with keys    ${INPUT_ATTRIBUTE_KEY}
    Clear element text with keys    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Check element display on screen     ${ATTRIBUTE_REQUIRED_FIELD_ERROR}   Attribute Name
    #   Verify show message error incase Key Name field is still null (OL-T12826)
    Check element display on screen     ${ATTRIBUTE_REQUIRED_FIELD_ERROR}   Key Name
    #   Verify show message error incase Attribute Description field is still null (OL-T12827)
    Check element display on screen     ${ATTRIBUTE_REQUIRED_FIELD_ERROR}   Attribute Description
    Verify element is disable   ${BUTTON_CREATE}
    Capture page screenshot


Verify that can not add Custom Location Attribute within exist Key name (OL-T12829)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Input text    ${INPUT_ATTRIBUTE_KEY}    custom_location_attribute
    Click at    ${BUTTON_CREATE}
    Then Displayed message error    Key name already exist
    Capture page screenshot


Verify that can not add Custom Location Attribute within exist Attribute name (OL-T12830)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    Input into    ${INPUT_ATTRIBUTE_NAME}    Custom Location Attribute
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    Custom Location Attribute
    Click at    ${BUTTON_CREATE}
    Then Displayed message error    Attribute name already exist
    Capture page screenshot


Verify can save Location attributes when all fields are filled out (OL-T12831)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    Then new attribute addded successfully and display in Location Attribute list    ${attribute_name_random}
    Capture page screenshot
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify close the modal and can not save Location attributes when user click Cancel button (OL-T12832)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CANCEL}
    Then new attribute does not saved and does not display in Location Attribute list    ${attribute_name_random}
    Capture page screenshot


Verify user can toggle ON/OFF The Add attribute to reports (OL-T12838)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Open Edit Location Attribute modal    Custom Location Attribute
    Then User can ON/OFF toggle Add attribute to report


Verify display when user click on Ellipse shape (OL-T12839)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Click on Ellipse shape    Custom Location Attribute
    Then modal Action of Location Attribute is displayed    Custom Location Attribute
    Capture page screenshot


Verify that can not edit Custom Location Attribute within exist Attribute name (OL-T12840)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Open Edit Location Attribute modal    ${attribute_name_random}
    input text    ${INPUT_ATTRIBUTE_NAME}    Custom Location Attribute
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Attribute name already exist
    Capture page screenshot
    Click at    ${BUTTON_CANCEL}
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify that can not edit Custom Location Attribute within exist Key Name (OL-T12841)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Open Edit Location Attribute modal    ${attribute_name_random}
    input text    ${INPUT_ATTRIBUTE_KEY}    custom_location_attribute
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Key name already exist
    Capture page screenshot
    Click at    ${BUTTON_CANCEL}
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify modal Custom Location Attributes Editing (OL-T12842)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    when Open Edit Location Attribute modal    Custom Location Attribute
    Then modal Edit Custom Location Attribute displayed correctly
    Capture page screenshot


Verify show message error incase Attribute Name field is still null (OL-T12843)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Open Edit Location Attribute modal    ${attribute_name_random}
    clear element text with keys    ${INPUT_ATTRIBUTE_NAME}
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Field required.
    Capture page screenshot
    Click at    ${BUTTON_CANCEL}
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify show message error incase Key Name field is still null (OL-T12844)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Open Edit Location Attribute modal    ${attribute_name_random}
    clear element text with keys    ${INPUT_ATTRIBUTE_KEY}
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Field required.
    Capture page screenshot
    Click at    ${BUTTON_CANCEL}
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify show message error incase Attribute Description field is still null (OL-T12845)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Open Edit Location Attribute modal    ${attribute_name_random}
    clear element text with keys    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Field required.
    Capture page screenshot
    Click at    ${BUTTON_CANCEL}
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify show message error incase all fields is still null (OL-T12846)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    when Open Edit Location Attribute modal    ${attribute_name_random}
    clear element text with keys    ${INPUT_ATTRIBUTE_NAME}
    clear element text with keys    ${INPUT_ATTRIBUTE_KEY}
    clear element text with keys    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Click at    ${BUTTON_SAVE}
    Then Displayed message error    Field required.
    Capture page screenshot
    Click at    ${BUTTON_CANCEL}
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify can save Location attributes when all fields are filled out (OL-T12847)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    Capture page screenshot
    when Open Edit Location Attribute modal    ${attribute_name_random}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    input text    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    input text    ${INPUT_ATTRIBUTE_KEY}    ${attribute_name_random}
    input text    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_SAVE}
    Then attribute edited successfully and display in Location Attribute list    ${attribute_name_random}
    Capture page screenshot
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify close the modal and can not save Location attributes when user click Cancel button (OL-T12848)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    Capture page screenshot
    when Open Edit Location Attribute modal    ${attribute_name_random}
    ${random_edited} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_edited} =    Set variable    Custom_Attributes_${random_edited}
    input text    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_edited}
    input text    ${INPUT_ATTRIBUTE_KEY}    ${attribute_name_edited}
    input text    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_edited}
    Click at    ${BUTTON_CANCEL}
    Then new attribute does not saved and does not display in Location Attribute list    ${attribute_name_edited}
    Capture page screenshot
    Delete location attribute    ${attribute_name_random}
    Capture page screenshot


Verify that can delete Custom location Attribute that not used for any request (OL-T12849)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Go to Location Attributes    Custom Location Attributes
    Click at    ${BUTTON_ADD_ATTRIBUTE}
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${attribute_name_random} =    Set variable    Custom_Attributes_${random}
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_CREATE}
    Capture page screenshot
    when Click on Ellipse shape    ${attribute_name_random}
    when Click Delete button    ${attribute_name_random}
    Then Delete Location Attribute modal is displayed
    Capture page screenshot
    Click at    ${BUTTON_OK_MODAL_DELETE}
    Then Location Attribute successfully deleted    ${attribute_name_random}
    Capture page screenshot
