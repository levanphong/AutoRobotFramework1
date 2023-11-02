*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/location_management_locators.py

*** Keywords ***
Add a Location
    [Arguments]    ${company_name}    ${location_name}    ${location_id}=None    ${city}=None    ${state}=${LOCATION_STATE_ALASKA}    ${zip_code}=None           ${user_name}=None
    Go to Location Management page
    ${is_existed} =    Run Keyword and Return Status    Check element display on screen    ${location_name}
    IF    '${is_existed}' == 'False'
        Hover at    ${AREA_NAME_TEXT}    ${company_name}
        Click at    ${ADD_AREA_OR_LOCATION_ICON}    ${company_name}
        Click at    ${ADD_MORE_ITEM_BUTTON}    Add a Location
        Input into    ${ADD_NEW_LOCATION_NAME_TEXT_BOX}    ${location_name}
        Run keyword if   '${location_id}' != 'None'    Input into    ${LOCATION_ID_TEXTBOX}    ${location_id}
        Run keyword if   '${city}' != 'None'    Input into    ${CITY_TEXTBOX}    ${location_name}
        Run keyword if   '${state}' != '${LOCATION_STATE_ALASKA}'    Select state value    ${state}
        ...       ELSE   Select state value    ${LOCATION_STATE_ALASKA}
        Run keyword if   '${zip_code}' != 'None'    Input into    ${ZIPCODE_TEXTBOX}    ${zip_code}
        Select state value    Alaska
        IF      '${user_name}' != 'None'
            Input into  ${LOCATION_ADD_USER_TEXTBOX}     ${user_name}
            ${user_name} =  format string   ${LOCATION_USER_NAME_TEXT}     ${user_name}
            Click at    ${user_name}
        END
        Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}
    END

add new area
    [Arguments]    ${company_name}    ${area}
    Go to Location Management page
#    Check if area is exist or not
    search location in location page     ${area}
       ${is_existed} =    Run Keyword and Return Status    Check element display on screen    ${LOCATION_SUGGEST_AFTER_SEARCH}   ${area}
    IF    '${is_existed}' == 'False'
        Go to Location Management page
        Hover at    ${AREA_NAME_TEXT}    ${company_name}
        Click at    ${ADD_AREA_OR_LOCATION_ICON}    ${company_name}
        Click at    ${ADD_MORE_ITEM_BUTTON}    Add an Area
        Input into    ${ADD_NEW_AREA_NAME_TEXT_BOX}    ${area}
        Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}
    END

add new location to area
    [Arguments]    ${area}    ${location}
    go to location management page
    search location in location page     ${area}
    Add a Location  ${area}    ${location}

search location in location page
    [Arguments]    ${location}
    Input into    ${INPUT_SEARCH_LOCATION}    ${location}
    wait for page load successfully v1

Select state value
    [Arguments]    ${state}
    Click at    ${STATE_SELECT_DROPDOWN}
    ${option_value} =    format string    ${STATE_OPTION_BY_NAME}    ${state}
    Click at    ${option_value}

Assign Custom location attribute
    [Arguments]    ${location_name}    ${attr_name}
    Go to Location Management page
    Input into      ${INPUT_SEARCH_LOCATION}    ${location_name}
    Click at    ${location_name}
    Click at    ${EDIT_LOCATION_ATTRIBUTE_ICON}    ${attr_name}
    ${text_value_attribute} =    Get text and format text    ${ATTRIBUTE_VALUE_TEXT_BOX}
    ${is_contains_value} =    Run Keyword And Return Status    Should Not be equal    ${text_value_attribute}    ${EMPTY}
    IF    '${is_contains_value}' == 'False'
        Input into    ${ATTRIBUTE_VALUE_TEXT_BOX}    auto_attribute_value
        Click at    ${EDIT_LOCATION_ATTRIBUTE_SAVE_BUTTON}
    ELSE
        Click at    ${EDIT_LOCATION_ATTRIBUTE_CANCEL_BUTTON}
    END

Choose a location in location management page
    [Arguments]    ${location}
    Input into    ${INPUT_SEARCH_LOCATION}    ${location}
    sleep    1s
    ${location_locator} =    format string    ${LOCATION_NAME_TAB}    ${location}
    Click at    ${location_locator}
    wait for page load successfully v1

Location Attribute section is displayed
    Check p text display    Location Attributes
    Check p text display    Manage attributes related to this location.

Then Location Attribute section when haven't created any attributes displayed correctly
    Location Attribute section is displayed
    Check p text display    You haven’t created attributes for this account yet

Then Location Attribute section when some attributes created displayed correctly
    Location Attribute section is displayed
    Check element display on screen    ${INPUT_SEARCH_ATTRIBUTE}
    ${count} =    get element count    ${BOX_ATTRIBUTE}
    ${not_empty_list} =    evaluate    ${count} > 0
    should be true    ${not_empty_list}
    ${value_attribute_locator} =    format string    ${VALUE_ATTRIBUTE}    No value added
    Check element display on screen    ${value_attribute_locator}

Then Displayed custom location attribute matching text user input
    [Arguments]    ${location_attribute}
    ${count} =    get element count    ${BOX_ATTRIBUTE}
    should be equal as strings    ${count}    1
    ${location_attribute_locator} =    format string    ${LABEL_ATTRIBUTE}    ${location_attribute}
    Check element display on screen    ${location_attribute_locator}

Then No data return when User input keyword not match with any attribute name
    [Arguments]    ${location_attribute}
    Check element not display on screen    ${BOX_ATTRIBUTE}
    ${location_attribute_locator} =    format string    ${LABEL_ATTRIBUTE}    ${location_attribute}
    Check element not display on screen    ${location_attribute_locator}

when Open Edit Attribute modal
    [Arguments]    ${location_attribute}
    Input into    ${INPUT_SEARCH_ATTRIBUTE}    ${location_attribute}
    wait for page load successfully v1
    ${edit_attribute_locator} =    format string    ${EDIT_LOCATION_ATTRIBUTE_ICON}    ${location_attribute}
    Click at    ${edit_attribute_locator}

Edit Attribute modal is displayed
    Check element display on screen    ${ATTRIBUTE_NAME_TEXT_BOX}
    element should be disabled    ${ATTRIBUTE_NAME_TEXT_BOX}
    Check element display on screen    ${ATTRIBUTE_KEY_TEXT_BOX}
    element should be disabled    ${ATTRIBUTE_KEY_TEXT_BOX}
    Check element display on screen    ${ATTRIBUTE_DESCRIPTION_TEXT_BOX}
    element should be disabled    ${ATTRIBUTE_DESCRIPTION_TEXT_BOX}
    Check element display on screen    ${ATTRIBUTE_VALUE_TEXT_BOX}
    element should be enabled    ${ATTRIBUTE_VALUE_TEXT_BOX}
    Check element display on screen    ${EDIT_LOCATION_ATTRIBUTE_CANCEL_BUTTON}
    Check element display on screen    ${EDIT_LOCATION_ATTRIBUTE_SAVE_BUTTON}

Then Location Attribute value saved successfully and displayed under attribute
    [Arguments]    ${attribute_value}
    ${success_alert} =    format string    ${SUCCESS_ALERT}    Your change has been saved.
    Check element display on screen    ${success_alert}
    ${attribute_value_locator} =    format string    ${VALUE_ATTRIBUTE}    ${attribute_value}
    Check element display on screen    ${attribute_value_locator}

Then close modal and Location Attribute value does not save
    [Arguments]    ${attribute_value}
    ${success_alert} =    format string    ${SUCCESS_ALERT}    Your change has been saved.
    Check element not display on screen    ${success_alert}
    ${attribute_value_locator} =    format string    ${VALUE_ATTRIBUTE}    ${attribute_value}
    Check element not display on screen    ${attribute_value_locator}
    Check element not display on screen    ${ATTRIBUTE_NAME_TEXT_BOX}
    Check element not display on screen    ${ATTRIBUTE_KEY_TEXT_BOX}
    Check element not display on screen    ${ATTRIBUTE_DESCRIPTION_TEXT_BOX}
    Check element not display on screen    ${ATTRIBUTE_VALUE_TEXT_BOX}
    Check element not display on screen    ${EDIT_LOCATION_ATTRIBUTE_CANCEL_BUTTON}
    Check element not display on screen    ${EDIT_LOCATION_ATTRIBUTE_SAVE_BUTTON}

Assign user to location
    [Arguments]    ${location_name}    ${user_name}
    wait for page load successfully v1
    Input into      ${INPUT_SEARCH_LOCATION}    ${location_name}
    Scroll To Element    ${LOCATION_SEARCH_RESULT_BLOCK}
    Click at    ${LOCATION_PATTERN_NAME}    ${location_name}
    wait for page load successfully v1
    Input into    ${INPUT_USER_VIEW}    ${user_name}
    Click by JS    ${USER_SUGGEST}    ${user_name}
    Click at    ${LOCATION_FORM_SAVE_BUTTON}

delete location
    [Arguments]    ${location_name}
    search location in location page    ${location_name}
    Scroll to element by JS    Delete location
    Click at    Delete location
    Click at    Yes

Delete a Location
    [Arguments]    ${location_name}
    Go to Location Management page
    Input into      ${INPUT_SEARCH_LOCATION}    ${location_name}
    Click at    ${location_name}
    wait for page load successfully v1
    Click at    ${LOCATION_PAGE_DELETE_BTN}
    handle alert    ACCEPT

Create a location and get value location SMS keyword
    [Arguments]    ${job_search_external_company}    ${location_name}
    Go to Location Management page
    Add a Location    ${job_search_external_company}    ${location_name}
    choose location    ${location_name}
    reload page
    Check element display on screen    Location SMS Keyword
    ${shortcode} =    get text    ${SHORTCODE_KEYWORD}
    [Return]    ${shortcode}

Add new room for location
    [Arguments]     ${room_name}    ${seat_code}
    wait for page load successfully v1
    Input into    ${ROOM_NAME_TEXTBOX}      ${room_name}
    Input into    ${SEATS_ROOM_TEXTBOX}     ${seat_code}
    Click at    ${ADD_ROOM_BUTTON}
    Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}

Get all location name
    Go to Location Management page
    ${list_location}=    Get elements and convert to list    ${ALL_LOCATION_NAME}
    [Return]    ${list_location}
