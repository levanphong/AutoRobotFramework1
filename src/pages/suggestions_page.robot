*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/suggestions_locators.py

*** Keywords ***
Click Suggestion Name
    [Arguments]    ${suggestion_name}
    Click at    ${SUGGESTION_NAME_IN_LIST}    ${suggestion_name}

Get Message text complete item
    ${item_list} =    Create List
    ${item_elements} =    Get WebElements    ${SUGGESTION_TEXT_COMPLETE_ITEM}
    FOR    ${element}    IN    @{item_elements}
        ${element_text} =    Replace String    ${element.get_attribute('innerHTML')}    <span class="highlight">#</span>
        ...    ${EMPTY}
        Append To List    ${item_list}    ${element_text}
    END
    [Return]    ${item_list}

Display the token list that include All Location Attributes that created on System Attributes page
    [Arguments]    ${all_location_attr_keys}
    ${displayed_tokens} =    Get Message text complete item
    FOR    ${key_name}    IN    @{all_location_attr_keys}
        Check element existed in list    la-${key_name}    ${displayed_tokens}
    END

Only display location attributes with prefix is "#la-"
    ${displayed_tokens} =    Get Message text complete item
    FOR    ${token}    IN    @{displayed_tokens}
        ${prefix} =    Get Regexp Matches    ${token}    <span class="highlight">#la<\/span>
        ${prefix_count} =    Get length    ${prefix}
        should be equal as numbers    ${prefix_count}    1
    END

Delete suggestion after run Test case
    [Arguments]    ${suggestion_random_name}
    Go to Suggestions page
    Click Suggestion Name    ${suggestion_random_name}
    Click at    ${SUGGESTION_REMOVE_BUTTON}
    Click at    ${SUGGESTION_REMOVE_CONFIRM_YES_BUTTON}

Get all suggestions in Suggestions page
    ${item_list} =    Create List
    ${item_elements} =    Get WebElements    ${SUGGESTION_NAME_TEXT}
    FOR    ${element}    IN    @{item_elements}
        Append To List    ${item_list}    ${element.get_attribute('innerHTML')}
    END
    [Return]    ${item_list}
