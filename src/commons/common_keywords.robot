*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn
Library     String
Library     ../configs/LibBuildRobotKeyWord.py
Library     ../utils/EmailServices.py
Library     ../utils/PySelenium.py
Library     ../utils/StringHandler.py
Library     ../utils/FileHandler.py
Resource    ./actions/get_actions.robot
Resource    ./actions/input_actions.robot
Resource    ./actions/mouse_actions.robot

*** Variables ***
${BG_COLOR_CHECKED}                 rgba(37, 201, 208, 1)
${TIME_SLOT_BG_COLOR_CHECKED}       rgba(57, 94, 102, 1)
@{last_name_list}                   James    Robert    John    Michael    David    William    Mary    Patricia    Jennifer    Linda    Elizabeth

*** Keywords ***
Wait for the element to fully load
    [Arguments]    ${locator}   ${dynamic_locator_value}=None     ${wait_time}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    # ${locator} can be locator/raw text
    ${locator} =   Convert text to locator  ${locator}
    wait_for_loading_icon_disappear
    Scroll to element   ${locator}
    Wait until element is visible    ${locator}     ${wait_time}
    ${is_clickable} =   Run keyword and return status   wait_element_clickable      ${locator}
    Run Keyword If      '${is_clickable}' == 'False'    Capture page screenshot

wait for page load successfully
    Run Keyword And ignore error    Wait Until Page Contains Element    ${LOADING_ICON_1}    30s

wait for page load successfully v1
    Run Keyword And ignore error    Wait Until Page Does Not Contain Element    ${LOADING_ICON_2}    30s

Check toggle is On
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    wait with short time
    IF    "${dynamic_locator_value}" != "None"
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${elem} =    Get Webelement    ${locator}
    ${bg color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Evaluate    '${bg_color}' == '${BG_COLOR_CHECKED}'
    should be true    ${is_active_bg}

Check toggle is Off
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    wait with short time
    IF    "${dynamic_locator_value}" != "None"
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${elem} =    Get Webelement    ${locator}
    ${bg color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Evaluate    '${bg_color}' == '${BG_COLOR_CHECKED}'
    should not be true    ${is_active_bg}

Check label display
    [Arguments]    ${label_name}
    ${locator_attribute} =    Format String    ${COMMON_LABEL_TEXT}    ${label_name}
    Check element display on screen    ${locator_attribute}

Check span display
    [Arguments]    ${span_name}     ${wait_time}=None
    Check element display on screen    ${COMMON_SPAN_TEXT}    ${span_name}      ${wait_time}

Check text display
# check div contains text display
    [Arguments]    ${div_text}
    ${locator_text} =    Format String    ${COMMON_TEXT}    ${div_text}
    wait until element is visible    ${locator_text}
    Element should be visible    ${locator_text}

Check p text display
# check p contains text display
    [Arguments]    ${p_text}
    ${locator_attribute} =    Format String    ${COMMON_P_TEXT}    ${p_text}
    Check element display on screen    ${locator_attribute}

Check link text display
# check a contains text display
    [Arguments]    ${link_text}
    ${locator_attribute} =    Format String    ${COMMON_LINK_TEXT}    ${link_text}
    Check element display on screen    ${locator_attribute}

Check common text last display
# check common text last display
    [Arguments]    ${text}
    ${locator_text} =    Format String    ${COMMON_TEXT_LAST}    ${text}
    Element should be visible    ${locator_text}

Check title popup display
# check h4 contains text display
    [Arguments]    ${h4_text}
    ${locator_attribute} =    Format String    ${COMMON_H4_TEXT}    ${h4_text}
    Check element display on screen    ${locator_attribute}

Check strong text display
# check strong contains text display
    [Arguments]    ${strong_text}
    ${locator_attribute} =    Format String    ${COMMON_STRONG_TEXT}    ${strong_text}
    Check element display on screen    ${locator_attribute}

Check Badge display
    [Arguments]    ${number}
    ${locator_attribute} =    Format String    ${COMMON_BADGE}    ${number}
    Check element display on screen    ${locator_attribute}

Check element display on screen
    [Arguments]    ${item}    ${dynamic_locator_value}=None     ${wait_time}=None
    IF    "${dynamic_locator_value}" != "None"
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    ${locator} =   Convert text to locator  ${item}
    wait_for_loading_icon_disappear
    Scroll to element    ${locator}
    wait until element is visible    ${locator}     ${wait_time}
    Element should be visible    ${locator}

Check element not display on screen
    [Arguments]    ${item}    ${dynamic_locator_value}=None     ${wait_time}=None
    IF    "${dynamic_locator_value}" != "None"
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    ${locator} =   Convert text to locator  ${item}
    wait_for_loading_icon_disappear
    Wait Until Element Is Not Visible   ${locator}     ${wait_time}
    element should not be visible    ${locator}

Check element exist on page
    [Arguments]    ${item}    ${dynamic_locator_value}=None     ${limit}=None
    IF    "${dynamic_locator_value}" != "None"
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    ${locator} =    Convert text to locator  ${item}
    wait_for_loading_icon_disappear
    IF     '${limit}' == 'None'
        Page should contain element     ${locator}
    ELSE
        Page should contain element     ${locator}      limit=${limit}
    END

Verify text contain
    [Arguments]    ${locator}    ${expected}    ${dynamic_locator_value}=None
    wait_for_loading_icon_disappear
    Wait with short time
    ${text} =    Get text and format text   ${locator}      ${dynamic_locator_value}
    Should Contain    ${text}    ${expected}

Check background color code displayed correctly
    [Arguments]    ${locator}    ${color_expected}
    ${elem} =    Get Webelement    ${locator}
    ${bg color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${match_color} =    Evaluate    '${bg_color}' == '${color_expected}'
    should be true    ${match_color}

Verify display text
    [Arguments]    ${locator}    ${message}    ${dynamic_locator_value}=None
    ${message_from_popup} =    Get text and format text    ${locator}    ${dynamic_locator_value}
    IF  '${message_from_popup}' == '${EMPTY}'
        Wait with short time
        ${message_from_popup} =    Get text and format text    ${locator}    ${dynamic_locator_value}
    END
    Should Be Equal As Strings    ${message_from_popup}    ${message}

Verify display text with get text value
    [Arguments]    ${locator}    ${message}    ${dynamic_locator}=None
    wait_for_loading_icon_disappear
    IF  '${dynamic_locator}' != 'None'
        ${locator} =    Format String   ${locator}    ${dynamic_locator}
    END
    ${message_from_popup} =    Get value and format text    ${locator}
    Should Be Equal As Strings    ${message_from_popup}    ${message}

Generate random name
    [Arguments]    ${string}
    ${random_id} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${string_parts} =    Split String    ${string}    @
    ${parts_length} =    Get length    ${string_parts}
    ${random_name} =    Set variable    ${string_parts}[0] ${random_id}
    IF    '${parts_length}' == '2'
        ${random_name} =    Set variable    ${string_parts}[0]+${random_id}@${string_parts}[1]
    END
    [Return]    ${random_name}

Generate random name only text
    [Arguments]    ${string}
    ${random_id} =    Generate Random String    7    [LETTERS]
    ${random_name} =    Set variable    ${string.capitalize()} ${random_id.lower().capitalize()}
    [Return]    ${random_name}

Generate random text only
    ${random_string} =    Generate Random String    7    [LETTERS]
    ${formatted_string} =    Set variable    ${random_string.lower().capitalize()}
    [Return]    ${formatted_string}

Generate candidate name
    [Arguments]     ${candidate_fist_name}=None
    ${random_string} =     Generate Random String      7    [LETTERS]
    ${random_index} =   Generate Random String      1    [NUMBERS]
    &{candidate_name} =    Create Dictionary
    IF  '${candidate_fist_name}' != 'None'
        ${candidate_name.first_name} =      Set variable      ${candidate_fist_name}
    ELSE
        ${candidate_name.first_name} =   Set variable    ${random_string.lower().capitalize()}
    END
    ${candidate_name.last_name} =   Set variable    ${last_name_list}[${random_index}]
    ${candidate_name.full_name} =   Set variable    ${candidate_name.first_name} ${candidate_name.last_name}
    [Return]    &{candidate_name}

Generate random phone number
    [Arguments]    ${area_code}=None
    ${area_code} =    get_random_area_code
    ${firt_digit} =    Generate Random String    1    123456789
    ${rest_digit} =    Generate Random String    6    [NUMBERS]
    ${phone_nunber} =    Set Variable    +1(${area_code}) ${firt_digit}${rest_digit[0:2]}-${rest_digit[2:]}
    [Return]    ${phone_nunber}

Switch to user
    [Arguments]    ${user_name}
    Wait with short time
    Click at      ${SWITCH_USER_BUTTON}
    # Check is different user or not
    ${current_user_name} =  Get text and format text  ${CURRENT_USER_NAME_TEXT}
    IF  '${current_user_name}' == '${user_name}'
        # Close change user popup
        Click at    ${SWITCH_USER_BUTTON}
    ELSE
        Input into    ${USERS_FILTER_TEXT_BOX}    ${user_name}
        Click at      ${VIEW_AS_USER_OPTION}      ${user_name}
        wait with medium time
        wait for page load successfully v1
    END

Switch to user old version
    [Arguments]    ${user_name}
    Wait with short time
    Click at    ${SWITCH_USER_BUTTON_OLD_VERSION}
    # Check is different user or not
    ${current_user_name} =  Get text and format text  ${CURRENT_USER_NAME_TEXT_OLD_VERSION}
    IF  '${current_user_name}' == '${user_name}'
        # Close change user popup
        Click at    ${SWITCH_USER_BUTTON_OLD_VERSION}
    ELSE
        Input into    ${USERS_FILTER_TEXT_BOX_OLD_VERSION}    ${user_name}
        ${user_name_locator} =    Format String    ${VIEW_AS_USER_OPTION_OLD_VERSION}    ${user_name}
        Click at    ${user_name_locator}
        wait with medium time
        wait for page load successfully v1
    END

Click button in email
    [Arguments]    ${subject}    ${content}    ${mailbox}=${None}   ${index_button}=0   ${custom_url}=${None}
    ${button_link} =    get_link_in_email    ${subject}    ${content}    ${custom_url}  mailbox=${mailbox}
    Log     ${button_link}
    go to    ${base_url}${button_link}[${index_button}]

#index_button = 1 when schedule with multiple days
#index_button = 0 when schedule with in-order and any-order

Click View more button in email
    [Arguments]    ${subject}    ${content}    ${mailbox}=${None}   ${index_button}=0
    ${CONFIG} =    get_config    ${env}
    ${base_url} =    Set Variable    ${CONFIG.shorten_url}
    IF  "${base_url}" == "${EMPTY}"
        ${base_url} =    Set Variable    ${CONFIG.site_url}
    END
    ${button_link} =    get_link_in_email    ${subject}    ${content}    ${base_url}    ${mailbox}
    go to    ${base_url}${button_link}[${index_button}]

Verify user has received the email
    [Arguments]    ${subject}    ${content}    ${mailbox}=${None}
    ${is_email_exist} =    check_email_exist    ${subject}    ${content}    ${mailbox}
    should be equal as strings    ${is_email_exist}    True

Check element existed in list
    [Arguments]    ${element}    ${list}
    ${is_existed} =    Set Variable    False
    IF    '${element}' in ${list}
        ${is_existed} =    Set Variable    True
    END
    Should Be Equal As Strings    ${is_existed}    True

Wait with short time
    Sleep    2s

Wait with medium time
    Sleep    5s

Wait with large time
    Sleep    10s

Replace HTML tag with value
    [Arguments]    ${string}    ${html_tag}    ${replace_value}
    ${return_string} =    Replace String    ${string}    ${html_tag}    ${replace_value}
    [Return]    ${return_string}

Load more item in page
    [Arguments]    ${item}    ${target}=None    ${dynamic_locator}=None
    IF    '${dynamic_locator}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator}
    END
    ${locator} =   Convert text to locator  ${item}
    FOR    ${index}    IN RANGE    10
        ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${locator}   wait_time=2s
        Exit For Loop If    '${is_visible}' == 'True'
        Run keyword and Ignore Error    Press Keys    ${target}    END
    END

Verify display common text
    [Arguments]    ${message}
    ${common_text} =    format string    ${COMMON_DIV_TEXT}    ${message}
    Check element display on screen    ${common_text}

Verify display exact text
    [Arguments]    ${message}
    ${common_text} =    format string    ${COMMON_DIV_EXACT_TEXT}    ${message}
    Check element display on screen    ${common_text}

Verify element is disable
    [Arguments]    ${locator}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    wait until page contains element    ${locator}
    element should be disabled    ${locator}

Verify element is disabled by checking class
    [Arguments]    ${locator}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${class_attribute} =    Get attribute and format text  class   ${locator}
    capture page screenshot
    Should contain  ${class_attribute}  disable

Verify element is enabled by checking class
    [Arguments]    ${locator}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${class_attribute} =    Get attribute and format text  class   ${locator}
    capture page screenshot
    Should Not Contain  ${class_attribute}  disable

Verify element is enable
    [Arguments]    ${locator}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    wait until page contains element    ${locator}
    element should be enabled    ${locator}

Convert text to locator
    [Arguments]    ${item}
    ${is_locator} =    check_argument_is_locator    ${item}
    IF    '${is_locator}' == 'False'
        ${item} =    Format String    ${COMMON_TEXT}    ${item}
    END
    [Return]    ${item}

Check number of element is correctly
    [Arguments]    ${locator}    ${expected_number}
    ${number_of_element} =    Get Element Count    ${locator}
    Run keyword unless  ${number_of_element} >= ${expected_number}  Fail

Get element color
    [Arguments]     ${locator_element}      ${css_property}
    ${elem} =    Get Webelement    ${locator_element}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    ${css_property}
    ${is_active_bg} =    Run Keyword And Return Status    Should Be Equal As Strings    ${bg_color}     ${BG_COLOR_CHECKED}
    [Return]    ${is_active_bg}

Check the pill will be displayed in navy color
    [Arguments]     ${locator}      ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    Should Be Equal As Strings    ${bg_color}    ${TIME_SLOT_BG_COLOR_CHECKED}

Verify attribute should not contain
    [Arguments]     ${attribute_name}    ${value}   ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${attribute_value}=  Get attribute and format text     ${attribute_name}   ${locator}
    ${is_not_contain}=  Should not contain     ${attribute_value}     ${value}
    [Return]    ${is_not_contain}

Verify attribute should contain
    [Arguments]     ${attribute_name}    ${value}     ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${attribute_value}=  Get attribute and format text     ${attribute_name}   ${locator}
    ${is_contain}=  Should contain     ${attribute_value}     ${value}
    [Return]    ${is_contain}

Verify attribute value equal
    [Arguments]    ${locator}    ${attribute}    ${value}    ${dynamic_locator}=None
        IF  '${dynamic_locator}' != 'None'
        ${locator} =    Format String   ${locator}    ${dynamic_locator}
    END
    ${result}=    Get Element Attribute    ${locator}    ${attribute}
    Should Be Equal As Strings    ${result}    ${value}

Verify attribute value equal with value
    [Arguments]     ${value}     ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${attribute_value}=  Get value and format text     ${locator}
    ${is_equal}=  Should be equal as strings     ${attribute_value}     ${value}
    [Return]    ${is_equal}

Verify attribute value not equal with value
    [Arguments]     ${value}     ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${attribute_value}=  Get value and format text     ${locator}
    ${is_not_equal}=  Should not be equal as strings     ${attribute_value}     ${value}
    [Return]    ${is_not_equal}

Close pendo popup
    IF  '${env}' == 'OLIVIA'
        ${is_displayed}=    Run keyword and return status   Check element display on screen     ${CLOSE_PENDO_POPUP_BUTTON}
        IF  '${is_displayed}' == 'True'
            Click at    ${CLOSE_PENDO_POPUP_BUTTON}     slow_down=1s
        END
    END

Switch to company v2
    [Arguments]     ${company_name}
    Click at  ${HEADER_COMPANY_NAME_V2}
    Input into  ${HEADER_SEARCH_COMPANY_NAME_TEXTBOX_V2}  ${company_name}
    Click at  ${HEADER_COMPANY_NAME_IN_LIST_V2}  ${company_name}

Should be larger/equal as integer
    [Arguments]     ${larger_number}    ${smaller_number}
    ${result_number} =  evaluate     int(${larger_number}) - int(${smaller_number})
    IF  ${result_number} >= 0
        log     '${larger_number}' >= '${smaller_number}'
    ELSE
        fail    msg='${larger_number}' < '${smaller_number}'
    END

Should be larger as integer
    [Arguments]     ${larger_number}    ${smaller_number}
    ${result_number} =  evaluate     int(${larger_number}) - int(${smaller_number})
    IF  ${result_number} > 0
        log     '${larger_number}' > '${smaller_number}'
    ELSE
        fail    msg='${larger_number}' <= '${smaller_number}'
    END

Select dropdown item
    [Arguments]   ${dropdown_button}   ${item}  ${dynamic_locator_button}=None    ${dynamic_locator_item}=None
    IF    '${dynamic_locator_button}' != 'None'
        ${dropdown_button} =    Format String    ${dropdown_button}    ${dynamic_locator_button}
    END
    IF    '${dynamic_locator_item}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_item}
    END
    Click at    ${dropdown_button}
    Click at    ${item}

Get landing site url by string concatenation
    [Arguments]   ${company_code}   ${lading_site_name}
    ${company_site_url} =  get_company_site_link  ${company_code}
    ${landing_site_url} =  Set variable  ${company_site_url}${lading_site_name}
    [Return]    ${landing_site_url}

Check list items of select tag
    [Arguments]     ${locator}    ${list}
    Click at    ${locator}
    ${option_list} =    Get List Items      ${locator}
    Lists Should Be Equal       ${option_list}      ${list}
    Capture page screenshot

Generate random number
    [Arguments]   ${min}=0  ${max}=1000
    ${numbers} =    Evaluate    random.randint(${min}, ${max})
    [Return]  ${numbers}

Add company for testing
    [Arguments]    ${company}
    Go to CEM page
    ${is_existed}=  Run keyword and return status   run search and click company name   ${company}
    IF  '${is_existed}' == 'False'
        Reload page
        Click at    ${HOME_COMPANY_NAME}
        Click at  ${ADD_COMPANY_BUTTON}
        Click at  ${ADD_NEW_COMPANY_OPTION}
        Click at  ${CONFIRM_COMPANY_OPTION_BUTTON}
        Input into  ${ACCOUNT_NAME_TEXT_BOX}  ${company}
        Input into  ${PUBLIC_ACCOUNT_NAME_TEXT_BOX}  ${company}
        Input into  ${PHONE_NUMBER_TEXT_BOX}  ${CONST_PHONE_NUMBER}
        Input into  ${STREET_ADDRESS_TEXT_BOX}  300 main street
        Input into  ${CITY_TEXT_BOX}  Phoenix
        Input into  ${ZIP_CODE_TEXT_BOX}  85001
        Click at  ${STATE_TEXT_BOX}
        Click at  California
        Click at  ${ACCOUNT_STATUS_SELECTION}
        Click at  ${ACCOUNT_STATUS_TEST_OPTION}
        Click at  ${ACCOUNT_STATUS_APPLY_BUTTON}
        Click at  Add company
    END
    Wait with short time

Verify element color
    [Arguments]     ${locator_element}      ${color}    ${css_property}
    ${elem} =    Get Webelement    ${locator_element}
    ${elem_color} =    Call Method    ${elem}    value_of_css_property    ${css_property}
    ${is_same_color} =    Run Keyword And Return Status    Should Be Equal As Strings    ${bg_color}     ${color}
    [Return]    ${is_same_color}

Get css property value
    [Arguments]   ${css_property}   ${locator}   ${dynamic_locator}=None
    IF  '${dynamic_locator}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator}
    END
    ${elem} =    Get Webelement    ${locator}
    ${css_value} =    Call Method    ${elem}    value_of_css_property    ${css_property}
    [Return]   ${css_value}

Verify css property as strings
    [Arguments]   ${css_property}   ${expected_strings}   ${locator}   ${dynamic_locator}=None
    ${css_value} =   Get css property value   ${css_property}    ${locator}   ${dynamic_locator}
    Should be equal as strings   ${css_value}   ${expected_strings}

Extract number from locator text
    [Arguments]      ${locator}     ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${value}=       Get text and format text        ${locator}
    ${number_arrays}=       extract numbers        ${value}
    [Return]    ${number_arrays}[0]

Verify value of element's attribute
    [Arguments]    ${attribute_value}    ${expected_attribute}    ${locator}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${class_attribute} =    Get attribute and format text  ${attribute_value}   ${locator}
    capture page screenshot
    Should Contain  ${class_attribute}  ${expected_attribute}

Get clipboard text
    Click at    ${HOME_COMPANY_NAME}
    Press Keys    ${COMPANY_INPUT}    CTRL+v
    ${clipboard_text}=    Get value and format text    ${COMPANY_INPUT}
    Clear Element Text    ${COMPANY_INPUT}
    Click at    ${HOME_COMPANY_NAME}
    [Return]    ${clipboard_text}
