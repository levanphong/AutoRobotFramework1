*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/location_attributes_locators.py

*** Keywords ***
Go to Location Attributes
    [Arguments]    ${location_attributes}
    ${left_menu_locator} =    Format string    ${LEFT_MENU_OPTION_BY_NAME}    Locations
    Click at    ${left_menu_locator}
    wait for page load successfully v1
    ${left_menu_locator} =    Format string    ${LEFT_MENU_OPTION_BY_NAME}    ${location_attributes}
    Click at    ${left_menu_locator}
    wait for page load successfully v1

Then Standard Location Attributes list is displayed
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Address
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Address 2
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    City
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    State
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Zip Code
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Country
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Province
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Location ID
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Location Name
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Location Email
    Check element display on screen    ${location_attribute_locator}
    ${location_attribute_locator} =    Format string    ${ATTRIBUTE_NAME}    Location Phone
    Check element display on screen    ${location_attribute_locator}

when Input keyword in attributes search box
    [Arguments]    ${keyword}
    input text    ${TEXTBOX_SEARCH_ATTRIBUTES}    ${keyword}
    wait for page load successfully v1
    [Return]    ${keyword}

Then Location attributes that match the text input are displayed
    [Arguments]    ${keyword}
    ${result_attributes_locator} =    Format string    ${ATTRIBUTE_NAME}    ${keyword}
    Check element display on screen    ${result_attributes_locator}
    ${count} =    Get Element Count    ${LIST_LOCATION_ATTRIBUTES}
    should be true    ${count}==1

Then The message "No Results Found" is displayed
    Check element display on screen    ${TEXT_NO_RESULT_FOUND}

when Open Edit Location Attribute modal
    [Arguments]    ${location_attribute}
    Input into     ${TEXTBOX_SEARCH_ATTRIBUTES}      ${location_attribute}
    Click at    ${ATTRIBUTE_NAME}       ${location_attribute}

Then modal Edit Standard Location Attribute displayed correctly
    Check span display    Edit Standard Location Attribute
    Check element display on screen    Attribute Details
    Check span display
    ...    Edit a Standard Location Attribute that will act as a point of reference for specific pieces of location data.
    Check element display on screen    ${INPUT_ATTRIBUTE_NAME}
    ELEMENT SHOULD BE DISABLED    ${INPUT_ATTRIBUTE_NAME}
    Check element display on screen    ${INPUT_ATTRIBUTE_KEY}
    ELEMENT SHOULD BE DISABLED    ${INPUT_ATTRIBUTE_KEY}
    Check element display on screen    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Check element display on screen    ${TOGGLE_ATTRIBUTE_REPORT}
    Check toggle is On    ${TOGGLE_ATTRIBUTE_REPORT}
    Check element display on screen    ${BUTTON_SAVE}
    Check element display on screen    ${BUTTON_CANCEL}

Then Displayed message error
    [Arguments]    ${error_message}
    Check span display    ${error_message}

when Change data on field Attributes Description
    [Arguments]    ${value}
    input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${value}

when Click Save button
    Click at    ${BUTTON_SAVE}
    wait for page load successfully v1

Then Close the modal and save all data, show new data on Standard Location Attributes list
    [Arguments]    ${value}
    ${attribute_description_locator} =    Format string    ${ATTRIBUTE_DESCRIPTION}    ${value}
    Check element display on screen    ${attribute_description_locator}
    when Open Edit Location Attribute modal    Country
    when Change data on field Attributes Description    Location country
    when Click Save button

when Click Cancel button
    Click at    ${BUTTON_CANCEL}

Then Close the modal and can not save data
    [Arguments]    ${value}
    ${attribute_description_locator} =    Format string    ${ATTRIBUTE_DESCRIPTION}    ${value}
    Check element not display on screen    ${attribute_description_locator}

when Verify If the Attribute Description extends past the viewable region in the row
    [Arguments]    ${location_attribute}
    when Open Edit Location Attribute modal    ${location_attribute}
    when Change data on field Attributes Description    Location phone in Location Management too long
    when Click Save button

Then Display the full description in a hover state component
    [Arguments]    ${location_attribute}
    ${attribute_description_locator} =    Format string    ${ATTRIBUTE_DESCRIPTION}
    ...    Location phone in Location Management
    Hover at    ${attribute_description_locator}
    ${tooltip} =    Format string    ${LOCATION_ATTRIBUTE_TOOLTIP_MESSAGE}    Location phone in Location Management too long
    ELEMENT SHOULD BE VISIBLE    ${tooltip}
    when Open Edit Location Attribute modal    ${location_attribute}
    when Change data on field Attributes Description    Location phone in Location Management
    when Click Save button

Then User can ON/OFF toggle Add attribute to report
    Turn off    ${TOGGLE_ATTRIBUTE_REPORT}
    Check toggle is Off    ${TOGGLE_ATTRIBUTE_REPORT}
    Capture page screenshot
    Turn on   ${TOGGLE_ATTRIBUTE_REPORT}
    Check toggle is On    ${TOGGLE_ATTRIBUTE_REPORT}
    Capture page screenshot

Then Location Attributes list is displayed
    Check element display on screen    ${HEADER_ATTRIBUTE_NAME}
    Check element display on screen    ${HEADER_KEY_NAME}
    Check element display on screen    ${HEADER_DESCRIPTION}
    Check element display on screen    ${HEADER_LAST_EDITED}
    Check element display on screen    ${TEXTBOX_SEARCH_ATTRIBUTES}
    Check element display on screen    ${BUTTON_ADD_ATTRIBUTE}

Then Custom Location Attributes list is displayed
    ${title} =    format string    ${TITLE_LOCATION_ATTRIBUTE}    Custom Location Attributes
    Check element display on screen    ${title}
    Then Location Attributes list is displayed

Then message "You haven’t created any location attributes yet." is displayed
    Check element display on screen    ${EMPTY_LOCATION_ATTRIBUTE_MESSAGE}

Modal Custom Location Attribute is displayed
    Check element display on screen    Attribute Details
    Check span display
    ...    Add and edit a Custom Location Attribute that will act as a point of reference for specific pieces of location data.
    Check element display on screen    ${INPUT_ATTRIBUTE_NAME}
    element should be enabled    ${INPUT_ATTRIBUTE_NAME}
    Check element display on screen    ${INPUT_ATTRIBUTE_KEY}
    ELEMENT SHOULD BE enabled    ${INPUT_ATTRIBUTE_KEY}
    Check element display on screen    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Check element display on screen    ${TOGGLE_ATTRIBUTE_REPORT}
    Check toggle is On    ${TOGGLE_ATTRIBUTE_REPORT}
    Check element display on screen    ${BUTTON_CANCEL}

Then modal Add Custom Location Attribute is displayed
    Check span display    Add Custom Location Attribute
    Modal Custom Location Attribute is displayed
    Check element display on screen    ${BUTTON_CREATE}

Attribute is displayed in Location Attribute list
    [Arguments]    ${location_attribute}
    Input into      ${TEXTBOX_SEARCH_ATTRIBUTES}        ${location_attribute}
    Check element display on screen    ${ATTRIBUTE_NAME}        ${location_attribute}

Then new attribute addded successfully and display in Location Attribute list
    [Arguments]    ${location_attribute}
    ${create_sucess_alert} =    FORMAT STRING    ${SUCCESS_ALERT}    New attribute successfully created!
    Check element display on screen    ${create_sucess_alert}
    Attribute is displayed in Location Attribute list    ${location_attribute}

Then attribute edited successfully and display in Location Attribute list
    [Arguments]    ${location_attribute}
    ${edit_sucess_alert} =    FORMAT STRING    ${SUCCESS_ALERT}   Attribute successfully updated!
    Check element display on screen    ${edit_sucess_alert}
    Attribute is displayed in Location Attribute list    ${location_attribute}

Then new attribute does not saved and does not display in Location Attribute list
    [Arguments]    ${location_attribute}
    Check element not display on screen     ${ATTRIBUTE_NAME}       ${location_attribute}

when Click on Ellipse shape
    [Arguments]    ${location_attribute}
    Input into      ${TEXTBOX_SEARCH_ATTRIBUTES}        ${location_attribute}
    Hover at        ${ATTRIBUTE_NAME}       ${location_attribute}
    Click at    ${BUTTON_ELLIPSE}       ${location_attribute}

Then modal Action of Location Attribute is displayed
    [Arguments]    ${location_attribute}
    ${edit_button_locator} =    format string    ${BUTTON_EDIT_SUBMENU}    ${location_attribute}
    Check element display on screen    ${edit_button_locator}
    ${delete_button_locator} =    format string    ${BUTTON_DELETE_SUBMENU}    ${location_attribute}
    Check element display on screen    ${delete_button_locator}
    ${submenu_infor_locator} =    format string    ${TEXT_INFOR_SUBMENU}    ${location_attribute}
    Check element display on screen    ${submenu_infor_locator}

Then modal Edit Custom Location Attribute displayed correctly
    Check span display    Edit Custom Location Attribute
    Modal Custom Location Attribute is displayed
    Check element display on screen    ${BUTTON_SAVE}

when Click Delete button
    [Arguments]    ${location_attribute}
    Click at    ${BUTTON_DELETE_SUBMENU}        ${location_attribute}

Then Delete Location Attribute modal is displayed
    Check element display on screen     ${TITLE_MODAL}    Delete Location Attribute
    Check element display on screen     ${CONTENT_MODAL}      Are you sure you want to delete this Location attribute
    Check element display on screen     ${BUTTON_CANCEL_MODAL_DELETE}
    Check element display on screen     ${BUTTON_OK_MODAL_DELETE}

Then Location Attribute successfully deleted
    [Arguments]    ${location_attribute}
    wait for page load successfully v1
    wait with short time
    ${alert_locator}=       Format string       ${SUCCESS_ALERT}    Attribute successfully deleted!
    Page should contain element       ${alert_locator}
    Then new attribute does not saved and does not display in Location Attribute list    ${location_attribute}

Delete location attribute
    [Arguments]     ${location_attribute}
    Input into      ${TEXTBOX_SEARCH_ATTRIBUTES}    ${location_attribute}
    when Click on Ellipse shape    ${location_attribute}
    when Click Delete button    ${location_attribute}
    Click at    ${BUTTON_OK_MODAL_DELETE}
    wait for page load successfully v1
    Then Location Attribute successfully deleted    ${location_attribute}

Then All Location Attributes list is displayed
    ${title} =    format string    ${TITLE_LOCATION_ATTRIBUTE}    All Location Attributes
    Check element display on screen    ${title}
    Then Location Attributes list is displayed

Then Location Attributes modal is closed
    Check element not display on screen    ${INPUT_ATTRIBUTE_NAME}
    Check element not display on screen    ${INPUT_ATTRIBUTE_KEY}
    Check element not display on screen    ${INPUT_ATTRIBUTE_DESCRIPTION}
    Check element not display on screen    ${TOGGLE_ATTRIBUTE_REPORT}
    Check element not display on screen    ${BUTTON_SAVE}
    Check element not display on screen    ${BUTTON_CANCEL}

Add a Custom Location Attribute
    [Arguments]    ${attribute_name}
    Go to System Attributes
    Go to Location Attributes    All Location Attributes
    ${is_existed_attrbute} =    Run Keyword and Return Status    Attribute is displayed in Location Attribute list
    ...    ${attribute_name}
    IF    '${is_existed_attrbute}' == 'False'
        Click at    ${BUTTON_ADD_ATTRIBUTE}
        Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name}
        Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name}
        Click at    ${BUTTON_CREATE}
        Then new attribute addded successfully and display in Location Attribute list    ${attribute_name}
    END

Edit a Custom Location Attribute
    [Arguments]    ${attribute_name}
    when Open Edit Location Attribute modal    ${attribute_name}
    ${attribute_name_random} =    Generate random name    Custom_Attributes_
    Input into    ${INPUT_ATTRIBUTE_NAME}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_KEY}    ${attribute_name_random}
    Input into    ${INPUT_ATTRIBUTE_DESCRIPTION}    ${attribute_name_random}
    Click at    ${BUTTON_SAVE}
    Then attribute edited successfully and display in Location Attribute list    ${attribute_name_random}
    [Return]    ${attribute_name_random}
