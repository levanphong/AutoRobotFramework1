*** Settings ***
Resource            ../../pages/system_attributes_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    stg

Documentation       Create `Can't Delete this Attribute`. Create a WF and add this attribute to WF

*** Variables ***
${long_description}    Lorem Ipsum is simply dummy text of the printing and typesetting industry. It has survived not only
${cant_delete_attr_name}    Can't Delete this Attribute

*** Test Cases ***
Delete attribute with short description (OL-T5584, OL-T5585, OL-T5587, OL-T5581)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Click at  ${NAV_ITEM_TEXT}  All Candidate Attributes
    Open Eclipse menu of Attribute  ${attribute_name}
    # Check Option in eclipse menu display
    Check element display on screen    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Check element display on screen    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Capture Page Screenshot
    # Check behaviors of Delete option
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    # Cancel delete in popup
    Click at  ${SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON}  Cancel
    Capture page screenshot
    Check element display on screen  ${attribute_name}
    Capture page screenshot
    # Delete confirm in popup
    Delete an Attribute  ${attribute_name}
    Capture page screenshot
    Check element not display on screen  Attribute has been deleted.
    Check element not display on screen  ${attribute_name}
    Capture page screenshot


All Attributes> Check behavior if user hover an Standard Attribute of list (OL-T5580)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Standard Candidate Attributes
    Open Eclipse menu of Attribute  Candidate First Name
    Check element not display on screen    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Check element display on screen    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Capture Page Screenshot


Delete attribute with short description (OL-T5579, OL-T5578)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes    ${long_description}
    Click at  ${NAV_ITEM_TEXT}  All Candidate Attributes
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    ${attribute_name}
    wait_for_loading_icon_disappear
    Hover description without waiting
    Delete an Attribute  ${attribute_name}
    Capture page screenshot
    Check element not display on screen  Attribute has been deleted.
    Check element not display on screen  ${attribute_name}
    Capture page screenshot


All Attributes> Check the UI of All Attributes list (OL-T5577)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at  ${NAV_ITEM_TEXT}  All Candidate Attributes
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Attribute Name
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Key Name
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Description
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Attribute Type
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Last Edited


All Attributes> Check whether if user is able to edit Custom Attribute (OL-T5583)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    # Edit to new attribute name
    ${new_attribute_name} =    Generate random name    auto_custom_candidate_attr
    Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${new_attribute_name}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    # Search with new attribute name
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    ${new_attribute_name}
    Check element display on screen    ${new_attribute_name}
    # Delete
    Open Eclipse menu of Attribute  ${new_attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Click at  ${SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON}  Delete


All Attributes> Verify that user permission on [All Attributes] page (OL-T5576, OL-T5575)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at  ${NAV_ITEM_TEXT}  All Candidate Attributes
    Switch to user old version    ${EE_TEAM}
    Check element not display on screen  ${NAV_ITEM_TEXT}  All Candidate Attributes
    Capture Page Screenshot


Custom Attributes > Check behavior when click Encrypt on Privacy Settings (OL-T5552, OL-T5551, OL-T5550, OL-T5549)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Encrypt
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE}    This enforces additional levels of security in our database, prevents attribute value from being searchable in our system, and hides the value to third-parties accessing our system. This should only be used for most sensitive candidate data, such as banking information.
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Mask
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE}    This hide the candidate’s values from being displayed in the CEM.
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    ${EMPTY}
    Check element not display on screen    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE}
    Capture Page Screenshot


Custom Attributes > Check UI of the Custom Attributes Edit modal (OL-T5563)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX_COUNTER}    34/16    # Counter from 50
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX_COUNTER}    34/16    # Counter from 50
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX_COUNTER}    34/66    # Counter from 100
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Check element display on screen    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Encrypt
    Check element display on screen    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Mask
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    # Delete
    Delete an Attribute  ${attribute_name}


Custom Attributes> Check behavior by clicking on [Save] button if Attribute Name is named the same as an existing at Standard/Custom Attribute (OL-T5557)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create Attribute with test data    Candidate First Name
    Check element display on screen    Attribute name already exist.
    Capture Page Screenshot


Custom Attributes> Check behavior by clicking on [Save] button if having required field is not filled. (OL-T5556, OL-T5558)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
     Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Attribute Name
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Key Name
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Attribute Description
    Capture Page Screenshot
    # Only input Key Name
    Input into    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    first_name
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Attribute Name
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Attribute Description
    Check element not display on screen    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Key Name
    Capture Page Screenshot


Custom Attributes> Check behavior if user clicks on Delete option (OL-T5544, OL-T5545, OL-T5547, OL-T5542)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Click at  ${NAV_ITEM_TEXT}  Custom Candidate Attributes
    Open Eclipse menu of Attribute  ${attribute_name}
    # Check Option in eclipse menu display
    Check element display on screen    Are you sure you want to delete this candidate attribute, ${attribute_name}?
    Check element display on screen    This could affect existing candidate data.
    Check element display on screen    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Check element display on screen    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Capture Page Screenshot
    # Check behaviors of Delete option
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    # Cancel delete in popup
    Click at  ${SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON}  Cancel
    Capture page screenshot
    Check element display on screen  ${attribute_name}
    Capture page screenshot
    # Delete confirm in popup
    Delete an Attribute  ${attribute_name}
    Capture page screenshot
    Check element not display on screen  Attribute has been deleted.
    Check element not display on screen  ${attribute_name}
    Capture page screenshot


Custom Attributes> Check behavior if user clicks on [Exit] button of Add Attribute modal (OL-T5554)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Capture Page Screenshot
    Check element display on screen    Add Custom Candidate Attribute
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    Check element not display on screen    Add Custom Candidate Attribute
    Capture Page Screenshot


Custom Attributes> Check behavior if user clicks on [Exit] button of Edit Attribute modal (OL-T5565)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Capture Page Screenshot
    # Verify attribute details is exactly info
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${attribute_name}
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    # Verify attribute details doesn't change after cancel edit popup
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${attribute_name}
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    # Delete
    Delete an Attribute  ${attribute_name}


Delete attribute with long description for Custom Attribute (OL-T5543)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes    ${long_description}
    Click at  ${NAV_ITEM_TEXT}  Custom Candidate Attributes
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    ${attribute_name}
    wait_for_loading_icon_disappear
    Hover description without waiting
    # Delete
    Delete an Attribute  ${attribute_name}
    Capture page screenshot
    Check element not display on screen  Attribute has been deleted.
    Check element not display on screen  ${attribute_name}
    Capture page screenshot


Custom Attributes> Check behavior when add new Custom Attribute having Key Name same Key Name is deleted before (OL-T5562, OL-T5561, OL-T5541)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Click at  ${NAV_ITEM_TEXT}  Custom Candidate Attributes
    # Delete
    Delete an Attribute  ${attribute_name}
    Capture page screenshot
    Check element not display on screen  Attribute has been deleted.
    Check element not display on screen  ${attribute_name}
    Capture page screenshot
    # Add an new Attribute has details with deleted Attribute
    Add a Custom Candidate Attributes    attribute_name=${attribute_name}
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    ${attribute_name}
    Check element display on screen    ${attribute_name}
    Capture page screenshot
    # Delete
    Delete an Attribute  ${attribute_name}
    Capture page screenshot
    Check element not display on screen  Attribute has been deleted.
    Check element not display on screen  ${attribute_name}
    Capture page screenshot


Custom Attributes> Check behavior when user do NOT input Attribute Name (OL-T5567, OL-T5570, OL-T5569)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
     Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Attribute Name
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Key Name
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR}    Field required.    Attribute Description
    Capture Page Screenshot


Custom Attributes> Check behavior when user input Attribute Name is named the same as an existing DB (OL-T5566)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create Attribute with test data    Candidate First Name    key_name=first_name
    Check element display on screen    Attribute name already exist.
    Check element display on screen    Key name already exist
    Capture Page Screenshot


Custom Attributes> Check the UI of Custom Attributes list (OL-T5540)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at  ${NAV_ITEM_TEXT}  Custom Candidate Attributes
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Attribute Name
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Key Name
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Description
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Last Edited


Custom Attributes > Check UI of the Custom Attributes Add modal (OL-T5548)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX_COUNTER}    0/50    # Counter from 50
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX_COUNTER}    0/50    # Counter from 50
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX_COUNTER}    0/100    # Counter from 100
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}    None    # Default privacy is None
    ${to_reports_toggle_status} =    Get toggle status    ${ADD_CUSTOM_ATTRIBUTE_TO_REPORTS_TOGGLE}
    Should Be Equal As Strings    ${to_reports_toggle_status}    True    # Default Toggle is ON
    Capture Page Screenshot


Custom Attributes> Check whether user can click [Cancel] button (OL-T5553, OL-T5555, OL-T5537)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Capture Page Screenshot
    Verify element is disable    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    Check element not display on screen    Add Custom Candidate Attribute
    Capture Page Screenshot


Custom Attributes> Check whether user can click [Cancel] button (OL-T5564, OL-T5572)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${attribute_name} =     Add a Custom Candidate Attributes
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Capture Page Screenshot
    # Verify attribute details is exactly info
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${attribute_name}
    Capture Page Screenshot
    Verify element is enable    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    # Verify attribute details doesn't change after cancel edit popup
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${attribute_name}
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${attribute_name}
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    # Delete
    Delete an Attribute  ${attribute_name}


Custom Attributes> Verify user permission on [Custom Attributes] page (OL-T5539, OL-T5522)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Switch to user old version    ${EE_TEAM}
    ${current_url} =    Get location
    Should not Contain    ${current_url}    /settings/system-attributes
    Capture Page Screenshot


Standard Attributes > Check behavior by clicking on [Save] button if all required field are filled. (OL-T5524, OL-T5536, OL-T5535, OL-T5533, OL-T5525, OL-T5531, OL-T5530, OL-T5529, OL-T5528)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Standard Candidate Attributes
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    Candidate First Name
    Open Eclipse menu of Attribute  Candidate First Name
    # Check Edit is in Eclipse Menu
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    # Check Save button enable by default when Edit
    Verify element is enable    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Capture Page Screenshot
    # Check message of Attribute Privacy
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Encrypt
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE}    This enforces additional levels of security in our database, prevents attribute value from being searchable in our system, and hides the value to third-parties accessing our system. This should only be used for most sensitive candidate data, such as banking information.
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Mask
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE}    This hide the candidate’s values from being displayed in the CEM.
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    ${EMPTY}
    Check element not display on screen    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE}
    Capture Page Screenshot
    # Check Save button disable when missing one of required field
    Clear element text with keys    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}
    Verify element is disable    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    Capture Page Screenshot
    # Check Description doesn't change if click Cancel button
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}
    Open Eclipse menu of Attribute  Candidate First Name
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Verify display text with get text value    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    Candidate first name
    Capture Page Screenshot


Standard Attributes > Check the UI of Standard Attributes (OL-T5523)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at  ${NAV_ITEM_TEXT}  Standard Candidate Attributes
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Attribute Name
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Key Name
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Description
    Check element display on screen    ${ATTRIBUTE_LIST_HEADER_COLUMN}    Last Edited
    Capture Page Screenshot


Standard Attributes > Check UI of the Standard Attributes Edit modal (OL-T5527)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Standard Candidate Attributes
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    Candidate First Name
    Open Eclipse menu of Attribute  Candidate First Name
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    Verify element is disable    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}
    Verify element is disable    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}
    Verify text contain    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX_COUNTER}    20/80    # Counter from 100
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN}
    Check element display on screen    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Encrypt
    Check element display on screen    ${ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE}    Mask
    Capture Page Screenshot
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON}


Standard Attributes tab> Check behavior if user hover the long Description of list (OL-T5526)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Standard Candidate Attributes
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    Company Brand
    wait_for_loading_icon_disappear
    Hover description without waiting    Brand that the candidate's application    Brand that the candidate's application is associated to.


All Attributes> Check behavior if user delete Custom Attribute which using at Conditional Workflows (OL-T5586, OL-T5546)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Check can't delete in-use Attribute
    Click at    ${NAV_ITEM_TEXT}    All Candidate Attributes
    Check can't delete in-use Attribute

*** Keywords ***
Hover description without waiting
    [Arguments]    ${short_expected_description}=None    ${long_expected_description}=None
    ${short_expected_description} =    Evaluate    "Lorem Ipsum is simply dummy text" if "${short_expected_description}" == "None" else "${short_expected_description}"
    ${long_expected_description} =    Evaluate    "${long_description}" if "${long_expected_description}" == "None" else "${long_expected_description}"
    ${desc_locator} =    Format String    ${COMMON_TEXT}    ${short_expected_description}
    Mouse Over    ${desc_locator}
    ${desc_popup} =    Format String    ${ATTRIBUTE_LIST_RECORD_DESCRIPTION_POPUP}    ${long_expected_description}
    Element should be visible    ${desc_popup}
    Capture page screenshot

Create Attribute with test data
    [Arguments]    ${attribute_name}=None    ${attribute_type}=Free-Text Response    ${key_name}=None    ${description}=None
    ${sample_name} =    Generate random name    auto_custom_candidate_attr
    ${test_attribute_name}    Evaluate    """${sample_name}""" if """${attribute_name}""" == "None" else """${attribute_name}"""
    ${description} =    Evaluate    """${sample_name}""" if """${description}""" == "None" else """${description}"""
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    Candidates
    Click at    ${NAV_ITEM_TEXT}    Custom Candidate Attributes
    Click at    Add Attribute
    Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${test_attribute_name}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_DROPDOWN}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_ITEM}    ${attribute_type}
    Run keyword if    '${key_name}' != 'None'    Clear element text with keys    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}
    Run keyword if    '${key_name}' != 'None'    Input into    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${key_name}
    Input into    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${description}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}

Check can't delete in-use Attribute
    Open Eclipse menu of Attribute  ${cant_delete_attr_name}
    Click at    ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Click at  ${SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON}  Delete
    Check element display on screen    Candidate attribute already in use.
    Capture Page Screenshot
