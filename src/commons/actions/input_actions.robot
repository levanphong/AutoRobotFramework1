*** Keywords ***
Input into
    [Arguments]    ${item}    ${txt_value}   ${dynamic_locator_value}=None
    # ${item} can be locator/raw text
    IF    '${dynamic_locator_value}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    wait_for_loading_icon_disappear
    Scroll to element   ${item}
    Wait until element is visible    ${item}
    Run keyword and ignore error    Clear Element Text     ${item}
    Input Text    ${item}    ${txt_value}
    wait_for_loading_icon_disappear

Simulate Input
    [Arguments]    ${item}    ${txt_value}   ${dynamic_locator_value}=None
    # ${item} can be locator/raw text
    IF    '${dynamic_locator_value}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    wait_for_loading_icon_disappear
    Scroll to element   ${item}
    IF    "${item}" != "None"
        Wait until element is visible        ${item}
        Run keyword and ignore error    Clear Element Text     ${item}
    END
    Press Keys    ${item}    ${txt_value}
    wait_for_loading_icon_disappear

Set HTML tag content
    [Arguments]    ${locator}    ${txt_value}
    ${get_tag_js} =    Set variable
    ...    document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ${html_tag} =    Execute Javascript    return ${get_tag_js}
    ${append_content_js} =    Set variable
    ...    while( arguments[0].firstChild ) { arguments[0].removeChild( arguments[0].firstChild ); } arguments[0].appendChild( document.createTextNode("${txt_value}") );
    Execute Javascript    ${append_content_js}    ARGUMENTS    ${html_tag}

Press Keys then Click with delay
    [Arguments]    ${keys}    ${button_locator}
    Press Keys    None    ${keys}
    Wait with short time
    Click at    ${button_locator}
    Wait with medium time

Clear element text with keys
    [Arguments]    ${item}   ${dynamic_locator_value}=None
    IF    '${dynamic_locator_value}' != 'None'
        ${item} =    Format String    ${item}    ${dynamic_locator_value}
    END
    Wait until element is visible    ${item}
    press keys      ${item}    CTRL+a+BACKSPACE
