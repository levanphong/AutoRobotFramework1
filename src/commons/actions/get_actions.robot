*** Keywords ***
Get value and format text
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    wait_for_loading_icon_disappear
    ${text} =    Get value    ${locator}
    ${formatted_text} =    Replace String Using Regexp    ${text}    (\r\n|\r|\n)    ${EMPTY}
    [Return]    ${formatted_text}
    Capture page screenshot

Get text and format text
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    wait_for_loading_icon_disappear
    ${text} =    Get text    ${locator}
    ${formatted_text} =    Replace String Using Regexp    ${text}    (\r\n|\r|\n)    ${EMPTY}
    [Return]    ${formatted_text}
    Capture page screenshot

Get list text and format list text
    [Arguments]     ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${eles}=       get webelements     ${locator}
    @{formatted_texts}=    Create List
    FOR     ${ele}       IN      @{eles}
        ${text} =       Get text    ${ele}
        ${formatted_text} =    Replace String Using Regexp    ${text}    (\r\n|\r|\n)    ${EMPTY}
        append to list      ${formatted_texts}     ${formatted_text}
    END
    [Return]    @{formatted_texts}

Get verify code in email
    [Arguments]    ${subject}    ${content}    ${mailbox}=${None}    ${separator}=${None}
    ${code} =    get_verify_code    ${subject}    ${content}    ${separator}    ${mailbox}
    [Return]    ${code}

Get list value
    [Arguments]    ${list_locator}    ${remove_text}=None
    ${item_list} =    Create List
    ${item_elements} =    Get WebElements    ${list_locator}
    FOR    ${element}    IN    @{item_elements}
        ${element_text} =    Replace String    ${element.get_attribute('innerHTML')}    ${remove_text}    ${EMPTY}
        Append To List    ${item_list}    ${element_text}
    END
    [Return]    ${item_list}

Get toggle status
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Run Keyword And Return Status    Should Be Equal As Strings    ${bg_color}    ${BG_COLOR_CHECKED}
    [Return]    ${is_active_bg}

Get attribute and format text
    [Arguments]    ${attribute_name}    ${locator}    ${dynamic_locator_value1}=None     ${dynamic_locator_value2}=None
    IF    '${dynamic_locator_value1}' != 'None'
        IF     '${dynamic_locator_value2}' != 'None'
            ${locator} =    Format String    ${locator}    ${dynamic_locator_value1}    ${dynamic_locator_value2}
        ELSE
            ${locator} =    Format String    ${locator}    ${dynamic_locator_value1}
        END
    END
    ${text} =    Get Element Attribute    ${locator}    ${attribute_name}
    ${formatted_text} =    Replace String Using Regexp    ${text}    (\r\n|\r|\n)    ${EMPTY}
    [Return]    ${formatted_text}

