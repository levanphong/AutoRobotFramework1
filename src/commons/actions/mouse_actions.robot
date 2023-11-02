*** Keywords ***
Click at
    [Arguments]    ${item}    ${dynamic_locator_value}=None     ${slow_down}=0s     ${wait_time}=None   ${alert_action}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    # ${item} can be locator/raw text
    ${locator} =   Convert text to locator  ${item}
    Sleep   ${slow_down}
    Wait for the element to fully load    ${locator}     wait_time=${wait_time}
    ${is_clicked}=  Run keyword and Return Status    Click Element    ${locator}
    IF  '${is_clicked}' == 'False'
        Wait for the element to fully load    ${locator}     wait_time=${wait_time}
        scroll_by_js    ${locator}
        ${click_status}=  Run keyword and Return Status    Click Element    ${locator}
        Run Keyword If      '${click_status}' == 'False'    Capture page screenshot
        Should be equal as strings      ${click_status}     True
    END
    IF  '${alert_action}' != 'None'
        Handle Alert  action=${alert_action}
    ELSE
        wait_for_loading_icon_disappear
    END

Click by JS
    [Arguments]    ${item}    ${dynamic_locator_value}=None      ${slow_down}=0s
    IF    '${dynamic_locator_value}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    # ${item} can be locator/raw text
    ${locator} =   Convert text to locator  ${item}
    Sleep   ${slow_down}
    wait_for_loading_icon_disappear
    ${is_shadow_root_locator} =     Run keyword and return status   Should Contain  ${locator}  dom:
    IF  ${is_shadow_root_locator}
        # For Shadow Root locator, just click it!
        ${locator} =    Evaluate    """${locator}""".replace("dom:", "")
        Execute Javascript    ${item}.click()
    ELSE
        Scroll to element   ${locator}
        Run keyword and ignore error    Wait until element is visible      ${locator}
        ${ele} =    Get WebElement    ${locator}
        ${is_clicked}=  Run keyword and Return Status    Execute Javascript    arguments[0].click();    ARGUMENTS    ${ele}
        IF  '${is_clicked}' == 'False'
            Scroll to element   ${locator}
            Run keyword and ignore error    wait_element_clickable      ${ele}
            Execute Javascript    arguments[0].click();    ARGUMENTS    ${ele}
        END
        wait_for_loading_icon_disappear
    END

Double click at
    [Arguments]    ${item}    ${dynamic_locator_value}=None     ${slow_down}=0s
    IF    "${dynamic_locator_value}" != "None"
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    # ${item} can be locator/raw text
    ${locator} =   Convert text to locator  ${item}
    Sleep   ${slow_down}
    Wait for the element to fully load    ${locator}
    ${is_clicked}=  Run keyword and Return Status    Double click element    ${locator}
    IF  '${is_clicked}' == 'False'
        Wait for the element to fully load    ${locator}
        ${click_status}=  Run keyword and Return Status     Double click element    ${locator}
        Run Keyword If      '${click_status}' == 'False'    Capture page screenshot
        Should be equal as strings      ${click_status}     True
    END
    wait_for_loading_icon_disappear

Click on span text
    [Arguments]    ${span_text}
    ${locator_attribute} =    Format String    ${COMMON_SPAN_TEXT}    ${span_text}
    Click at    ${locator_attribute}

Click on strong text
    [Arguments]    ${strong_text}
    ${locator_attribute} =    Format String    ${COMMON_STRONG_TEXT}    ${strong_text}
    Click at    ${locator_attribute}

Click on p text
    [Arguments]    ${p_text}
    ${locator_attribute} =    Format String    ${COMMON_P_TEXT}    ${p_text}
    Click at    ${locator_attribute}

Click on common text last
    [Arguments]    ${text}
    ${locator_attribute} =    Format String    ${COMMON_TEXT_LAST}    ${text}
    Click at    ${locator_attribute}

Turn on
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Run Keyword And Return Status    Should Be Equal As Strings    ${bg_color}
    ...    ${BG_COLOR_CHECKED}
    IF    not ${is_active_bg}
        Click at    ${locator}
    END
    [Return]    ${is_active_bg}

Turn off
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Run Keyword And Return Status    Should Be Equal As Strings    ${bg_color}
    ...    ${BG_COLOR_CHECKED}
    IF    ${is_active_bg}
        Click at    ${locator}
    END
    [Return]    ${is_active_bg}

Check the checkbox
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    scroll to element    ${locator}
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Evaluate    '${bg_color}' == '${BG_COLOR_CHECKED}'
    IF    not ${is_active_bg}
        Click at    ${locator}
    END
    [Return]    ${is_active_bg}

Uncheck the checkbox
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    scroll to element    ${locator}
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Evaluate    '${bg_color}' == '${BG_COLOR_CHECKED}'
    IF    ${is_active_bg}
        Click at    ${locator}
    END
    [Return]    ${is_active_bg}

Scroll to element by JS
    [Arguments]    ${item}
    ${locator} =   Convert text to locator  ${item}
    ${element} =    Get Webelement    ${locator}
    run keyword and ignore error    Execute JavaScript    arguments[0].scrollIntoView(true);    ARGUMENTS    ${element}

Scroll to element
    [Arguments]    ${locator}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    run keyword and ignore error    Scroll Element Into View    ${locator}

Scroll to bottom of table
    [Arguments]    ${table_locator}    ${loading_icon}=None    ${interval}=1000
    ${base_script} =    Set Variable    function delay(time) { return new Promise(resolve => setTimeout(resolve, time)); } const table = document.evaluate("${table_locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    # Increase timeout to run script in case table has to much data
    Set Selenium Timeout        90s
    Check element display on screen  ${table_locator}
    IF    "${loading_icon}" == "None"
        ${main_script} =    Set Variable    do {{ defaultHeight = table.scrollHeight; {}; await delay(${interval}); maxHeight = table.scrollHeight; }} while (defaultHeight < maxHeight)
    ELSE
        ${base_script} =    Catenate    ${base_script}    async function waitForLoadingIconDisappear() { do { await delay(1000); loading = document.evaluate("${loading_icon}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; } while (window.getComputedStyle(loading).display !== "none") }
        ${main_script} =    Set Variable    do {{ defaultHeight = table.scrollHeight; {}; await waitForLoadingIconDisappear(); maxHeight = table.scrollHeight; }} while (defaultHeight < maxHeight)
    END
    # For table using separate scroll
    ${scroll_script} =    Evaluate    "${main_script}".format("table.scrollTop = defaultHeight")
    ${run_script} =    Catenate    ${base_script}    ${scroll_script}
    Execute Javascript    ${run_script}
    # For table using browser scroll
    ${scroll_script} =    Evaluate    "${main_script}".format("window.scrollTo(0, defaultHeight)")
    ${run_script} =    Catenate    ${base_script}    ${scroll_script}
    Execute Javascript    ${run_script}
    # Set timeout to 30s default
    Set Selenium Timeout        30s

Hover at
    [Arguments]    ${item}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    # ${item} can be locator/raw text
    ${locator} =   Convert text to locator  ${item}
    Wait for the element to fully load    ${locator}
    Mouse Over    ${locator}

Click at button
    [Arguments]    ${value}
    ${locator} =    Format String    ${COMMON_BUTTON}    ${value}
    Click at    ${locator}

Click at label
    [Arguments]    ${value}
    ${locator} =    Format String    ${COMMON_LABEL_TEXT}    ${value}
    Click at    ${locator}

Click at link
    [Arguments]    ${value}
    ${locator} =    Format String    ${COMMON_LINK_TEXT}    ${value}
    Click at    ${locator}

Scroll to bottom
    [Arguments]     ${target_locator}   ${total_row}
    #   To focus into target tab or page
    Click at    ${target_locator}
    #   Scroll down
    FOR    ${index}    IN RANGE    0    ${total_row}    20
        Press Keys   None  END
        wait for page load successfully v1
    END

The checkbox should be checked
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    scroll to element    ${locator}
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    Should Be Equal As Strings    ${bg_color}    ${BG_COLOR_CHECKED}

The checkbox should not be checked
    [Arguments]    ${locator}    ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${locator} =    Format String    ${locator}    ${dynamic_locator_value}
    END
    scroll to element    ${locator}
    ${elem} =    Get Webelement    ${locator}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    Should Not Be Equal As Strings    ${bg_color}    ${BG_COLOR_CHECKED}
