*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/school_management_locators.py

*** Keywords ***
Select approval flow
    [Arguments]     ${approval_flow}
    ${toggle_status} =    Run Keyword and Return Status    Element should be visible    ${INPUT_SELECT_APPROVAL_FLOW}
    IF    '${toggle_status}' == 'False'
        Click at    ${EVENT_PLANING_APPROVAL_TOGGLE}
    END
    Click at    ${INPUT_SELECT_APPROVAL_FLOW}
    Click at    ${OPTION_APPROVAL_FLOW}    ${approval_flow}

Create a new school
    [Arguments]     ${school_options}=Add a School      ${school_name}=None      ${school_user_name}=None       ${approval_name}=None   ${check_exist}=False
    go to school management page
    IF  '${check_exist}' == 'True'
        Input Into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}    ${school_name}
        ${is_exist}=    Run Keyword And Return Status     Check element display on screen     ${SCHOOL_MANAGEMENT_SCHOOL_NAME_LABEL}  ${school_name}    wait_time=2s
        Capture Page Screenshot
        IF  ${is_exist}
            Click by JS    ${SCHOOL_MANAGEMENT_SCHOOL_NAME_LABEL}  ${school_name}
            Select Approval Flow    ${approval_name}
            Click at        ${ADD_NEW_SCHOOL_SAVE_BUTTON}
        END
        Return From Keyword If  ${is_exist}
        Click At  ${SCHOOL_MANAGEMENT_CLEAR_SEARCH_BUTTON}
    END
    Hover at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    ${school_options}
    Click at    ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_TEXTBOX}
    click at    ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}
    IF    '${school_name}' == 'None'
        ${school_name}=         Generate random name only text      auto_school_name
    END
    input into      ${ADD_NEW_SCHOOL_NAME_TEXTBOX}      ${school_name}
    input into      ${ADD_NEW_SCHOOL_STREET_ADDRESS_TEXTBOX}    Nguyen Huu Tho
    input into      ${ADD_NEW_SCHOOL_CITY_TEXTBOX}      Da Nang
    Click at    ${ADD_NEW_SCHOOL_STATE_DROPDOWN}
    Click at     ${ADD_NEW_SCHOOL_STATE_DROPDOWN_OPTIONS}        Alaska
    IF  '${approval_name}' != 'None'
        Turn On    ${ADD_NEW_SCHOOL_EVENT_PLANNING_APPROVAL_TOGGLE}
        Click At    ${ADD_NEW_SCHOOL_APPROVAL_FLOW_DROPDOWN}
        Click At    ${ADD_NEW_SCHOOL_APPROVAL_FLOW_DROPDOWN_OPTIONS}    ${approval_name}
    END
    IF  '${school_user_name}' != 'None'
        Input into  ${ADD_NEW_SCHOOL_USERS_TEXTBOX}  ${school_user_name}
        Click at    ${ADD_NEW_SCHOOL_USER_SUGGESTION_NAME}  ${school_user_name}
    END
    Click at        ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    check element display on screen    ${school_name}
    capture page screenshot
    [Return]    ${school_name}

Create a school in an area
    [Arguments]     ${area_name}    ${approval_flow}
    input into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}    ${area_name}
    click by js        ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_TO_AN_AREA_BUTTON}      ${area_name}
    click at        ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    Add a School
    Click at        ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_TEXTBOX}
    click at        ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}
    ${school_name}=     Fill in the school information
    Select approval flow        ${approval_flow}
    Click at                ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    [Return]    ${school_name}

Delete a school
    [Arguments]     ${school_name}
    Go to school detail     ${school_name}
    Click at    ${SEARCH_SCHOOL_DELETE_SCHOOL_BUTTON}
    Click at    ${ADD_NEW_SCHOOL_YES_BUTTON}
    Check element not display on screen     ${school_name}
    capture page screenshot

Edit a school
    [Arguments]     ${school_name}      ${school_name_changed}=None      ${school_user_name}=None   ${approval_flow_name}=None
    Go to school detail     ${school_name}
    Clear element text with keys    ${ADD_NEW_SCHOOL_NAME_TEXTBOX}
    IF    '${school_name_changed}' == 'None'
        ${school_name_changed}=         Generate random name only text      auto_school_name_changed
    END
    input into      ${ADD_NEW_SCHOOL_NAME_TEXTBOX}      ${school_name_changed}
    input into      ${ADD_NEW_SCHOOL_STREET_ADDRESS_TEXTBOX}    Phan Chau Trinh
    input into      ${ADD_NEW_SCHOOL_CITY_TEXTBOX}      Ho Chi Minh
    Click at    ${ADD_NEW_SCHOOL_STATE_DROPDOWN}
    Click at     ${ADD_NEW_SCHOOL_STATE_DROPDOWN_OPTIONS}        New York
    IF  '${school_user_name}' != 'None'
        Input into  ${ADD_NEW_SCHOOL_USERS_TEXTBOX}  ${school_user_name}
        Click at  ${ADD_NEW_SCHOOL_USER_SUGGESTION_NAME}  ${school_user_name}
    END
    IF  '${approval_flow_name}' != 'None'
        Select Approval Flow    ${approval_flow_name}
    END
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    [Return]    ${school_name_changed}

Create a new area
    [Arguments]    ${area_name}=None     ${area_user_name}=None
    Go to school management page
    Hover at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_AN_AREA_BUTTON}
    Element should be enabled           ${ADD_NEW_AN_AREA_NAME_TEXTBOX}
    Check element display on screen     ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
    Capture page screenshot
    IF    '${area_name}' == 'None'
        ${area_name} =          Generate random name only text    auto_area_name
    END
    Input into      ${ADD_NEW_AN_AREA_NAME_TEXTBOX}     ${area_name}
    IF    '${area_user_name}' != 'None'
        Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
        Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_USER}     ${area_user_name}
    END
    Click at    ${ADD_NEW_AN_AREA_SAVE_BUTTON}
    [Return]    ${area_name}

Edit an area
    [Arguments]     ${area_name}    ${area_name_changed}=None    ${area_user_name}=None
    Go to school management page
    input into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}    ${area_name}
    Click at        ${SCHOOL_MANAGEMENT_AREA_NAME_LABEL}  ${area_name}
    Clear element text with keys    ${ADD_NEW_AN_AREA_NAME_TEXTBOX }
    IF    '${area_name_changed}' == 'None'
        ${area_name_changed}=         Generate random name only text      auto_area_name_changed
    END
    Input into      ${ADD_NEW_AN_AREA_NAME_TEXTBOX}      ${area_name_changed}
    IF    '${area_user_name}' != 'None'
        Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
        Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_USER}     ${area_user_name}
    END
    Click at    ${ADD_NEW_AN_AREA_SAVE_BUTTON}
    [Return]    ${area_name_changed}

Delete an area
    [Arguments]     ${area_name}
    Go to school management page
    input into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}    ${area_name}
    Click at    ${SCHOOL_MANAGEMENT_AREA_NAME_LABEL}  ${area_name}
    Click at    ${ADD_NEW_AN_AREA_REMOVE_BUTTON}
    Click at    ${ADD_NEW_AN_AREA_YES_BUTTON}

Check UI when click an area
    [Arguments]     ${area_name}
    Click at    ${area_name}
    Check element display on screen     ${ADD_NEW_SCHOOL_AREA_NAME_LABEL}
    Element should be enabled           ${ADD_NEW_AN_AREA_NAME_TEXTBOX}
    Check element display on screen     ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
    Capture page screenshot

Check UI when click a school
    [Arguments]     ${school_name}
    Click at    ${school_name}
    Check element display on screen  ${ADD_NEW_SCHOOL_ADD_LOGO_UPLOAD}
    Check label display  School name
    Element should be enabled  ${ADD_NEW_SCHOOL_NAME_TEXTBOX}
    Check label display  School acronym
    Check label display  School mascot
    Check element display on screen     ${ADD_NEW_SCHOOL_ACRONYM_INPUT}
    Check element display on screen     ${ADD_NEW_SCHOOL_MASCOT_INPUT}
    Check element display on screen     ${ADD_NEW_SCHOOL_CAMPUS_ADDRESS_DROPDOWN}
    Check element display on screen     ${ADD_NEW_SCHOOL_STATE_DROPDOWN}
    Check element display on screen     ${ADD_NEW_SCHOOL_USERS_TEXTBOX}
    Check element display on screen     ${EVENT_PLANING_APPROVAL_TOGGLE}
    Capture page screenshot

Fill in the school information
    [Arguments]     ${school_name}=None
    IF      '${school_name}' == 'None'
        ${school_name}=         Generate random name only text      auto_school_name
    END
    input into      ${ADD_NEW_SCHOOL_NAME_TEXTBOX}      ${school_name}
    input into      ${ADD_NEW_SCHOOL_STREET_ADDRESS_TEXTBOX}    Nguyen Huu Tho
    input into      ${ADD_NEW_SCHOOL_CITY_TEXTBOX}      Da Nang
    Click at    ${ADD_NEW_SCHOOL_STATE_DROPDOWN}
    Click at     ${ADD_NEW_SCHOOL_STATE_DROPDOWN_OPTIONS}        New York
    Click at                ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    capture page screenshot
    [Return]    ${school_name}

Upload logo for the school
    ${path_image} =    get_path_upload_image_path    cat-kute
    ${element} =    Get Webelement    ${FORM_UPLOAD_FILE}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
    ...    ARGUMENTS    ${element}
    Input into    ${FORM_UPLOAD_FILE}    ${path_image}
    Click at      ${ADD_NEW_SCHOOL_CONFIRM_UPLOAD_PHOTO_BUTTON}

Go to add school form
    Click at        ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
	Click at        ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    Add a School
	Click at        ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_DROPDOWN}
	Click at        ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}

Search a school
    [Arguments]     ${school_name}
    Input into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}      ${school_name}
    Press Keys    None    RETURN
    check element display on screen    ${school_name}
    capture page screenshot

Create a new school with the given name
    Click at        ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
	Click at        ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    Add a School
	Click at        ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_DROPDOWN}
	${school_name}=         Generate random name only text      auto_school_name
    Input into      ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_DROPDOWN}     ${school_name}
    Press keys      None        RETURN
    Click at        ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}
    input into      ${ADD_NEW_SCHOOL_STREET_ADDRESS_TEXTBOX}    Nguyen Huu Tho
    input into      ${ADD_NEW_SCHOOL_CITY_TEXTBOX}      Da Nang
    Click at        ${ADD_NEW_SCHOOL_STATE_DROPDOWN}
    Click at        ${ADD_NEW_SCHOOL_STATE_DROPDOWN_OPTIONS}        New York
    [Return]        ${school_name}

Go to school detail
    [Arguments]    ${school_name}
    Go To School Management Page
    Input Into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}    ${school_name}
    Check element display on screen     ${SCHOOL_MANAGEMENT_SCHOOL_NAME_LABEL}  ${school_name}
    Click by JS    ${SCHOOL_MANAGEMENT_SCHOOL_NAME_LABEL}  ${school_name}

Turn Approval Flow OFF
    [Arguments]    ${school_name}
    Go to school detail     ${school_name}
    Click At    ${EVENT_PLANING_APPROVAL_TOGGLE}
    Click At    ${ADD_NEW_AN_AREA_SAVE_BUTTON}

Turn Approval Flow ON
    [Arguments]    ${school_name}   ${approval_name}=None
    Go to school detail     ${school_name}
    IF  '${approval_name}' != 'None'
        Select Approval Flow    ${approval_name}
    ELSE
        Click at    ${EVENT_PLANING_APPROVAL_TOGGLE}
    END
    Click At    ${ADD_NEW_AN_AREA_SAVE_BUTTON}

Delete schools in School Management Page
    Go To School Management Page
    ${school_name_list} =    Create List
    ${school_row_name}=     Format String       ${ADD_NEW_SCHOOL_LIST_NAME_SCHOOL_TEXT}   Auto_school_name
    ${list_value} =    Get WebElements     ${school_row_name}
    FOR    ${value}    IN    @{list_value}
        Scroll To Element    ${value}
        ${text}=     Get text and format text    ${value}
        IF  "${text}" == '${EMPTY}'
            Continue For Loop
        END
        Append To List    ${school_name_list}    ${text}
    END
    IF    ${school_name_list} != 0
        FOR    ${school_name}    IN    @{school_name_list}
            Go to school detail     ${school_name}
            Click at    ${SEARCH_SCHOOL_DELETE_SCHOOL_BUTTON}
            Click at    ${ADD_NEW_SCHOOL_YES_BUTTON}
        END
    END
