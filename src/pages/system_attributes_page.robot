*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/system_attributes_locators.py

*** Variables ***
${candidates}                       Candidates
${locations}                        Locations
${jobs}                             Jobs
${all_location_attributes}          All Location Attributes
${custom_candidate_attributes}      Custom Candidate Attributes
${custom_job_attributes}            Custom Job Attributes
${custom_location_attributes}       Custom Location Attributes

*** Keywords ***
Get All Location Attributes Key Name
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    ${locations}
    Click at    ${NAV_ITEM_TEXT}    ${all_location_attributes}
    ${key_name_list} =    Create List
    ${key_name_elements} =    Get WebElements    ${LOCATION_ATTRIBUTE_KEY_NAME_TEXT}
    FOR    ${element}    IN    @{key_name_elements}
        Append To List    ${key_name_list}    ${element.get_attribute('innerHTML')}
    END
    [Return]    ${key_name_list}

Add a Custom Candidate Attributes
    [Arguments]    ${description}=None    ${attribute_name}=None    ${attribute_type}=Free-Text Response
    ${sample_name} =    Generate random name    auto_custom_candidate_attr
    ${test_attribute_name}    Evaluate    """${sample_name}""" if """${attribute_name}""" == "None" else """${attribute_name}"""
    ${description} =    Evaluate    """${sample_name}""" if """${description}""" == "None" else """${description}"""
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    ${candidates}
    Click at    ${NAV_ITEM_TEXT}    ${custom_candidate_attributes}
    ${is_existed} =    Run Keyword And Return Status    Check Attribute existed    ${test_attribute_name}
    IF    '${is_existed}' == 'False'
        Click at    ${REMOVE_SEARCH_CONTENT_ICON}
        Click at    Add Attribute
        Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${test_attribute_name}
        Click at    ${ADD_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_DROPDOWN}
        Click at    ${ADD_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_ITEM}    ${attribute_type}
        Clear element text with keys    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}
        Input into    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${test_attribute_name}
        Input into    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${description}
        Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    END
    [Return]    ${sample_name}

Add a Custom Location Attributes
    [Arguments]    ${sample_name}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    ${locations}
    Click at    ${NAV_ITEM_TEXT}    Custom Location Attributes
    ${is_empty_attr_list} =    Run Keyword And Return Status    Click at    New Attribute
    IF    '${is_empty_attr_list}' == 'True'
        Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${sample_name}
        # Input into    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${sample_name}
        Input into    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${sample_name}
        Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    ELSE
        ${is_existed} =    Run Keyword And Return Status    Check Attribute existed    ${sample_name}
        IF    '${is_existed}' == 'False'
            Click at    Add Attribute
            Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${sample_name}
            # Input into    ${ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX}    ${sample_name}
            Input into    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${sample_name}
            Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
        END
    END

Check Attribute existed
    [Arguments]    ${attr_name}
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    ${attr_name}
    Check element display on screen    ${ATTRIBUTE_NAME_IN_COLUMN}    ${attr_name}      wait_time=5s

Add a Custom Job Attribute
    [Arguments]     ${attribute_name}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    ${jobs}
    Click at    ${NAV_ITEM_TEXT}    ${custom_job_attributes}
    ${is_empty_attr_list} =    Run Keyword And Return Status    Click at    New Attribute   wait_time=5s
    IF    '${is_empty_attr_list}' == 'True'
        Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${attribute_name}
        Input into    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${attribute_name}
        Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    ELSE
        ${is_existed} =    Run Keyword And Return Status    Check Attribute existed    ${attribute_name}
        IF    '${is_existed}' == 'False'
            Click at    Add Attribute
            Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${attribute_name}
            Input into    ${ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX}    ${attribute_name}
            Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
        END
    END

Open Eclipse menu of Attribute
    [Arguments]     ${attribute_name}
    Input into    ${SEARCH_ATTRIBUTE_TEXT_BOX}    ${attribute_name}
    Hover at  ${attribute_name}
    Click at  ${ATTRIBUTE_LIST_RECORD_ECLIPSE_MENU}

Delete an Attribute
    [Arguments]    ${attribute_name}
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Click at  ${SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON}  Delete

Edit name of candidate attribute
    [Arguments]     ${attribute_name}   ${new_attribute_name}=None
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    ${candidates}
    Click at    ${NAV_ITEM_TEXT}    ${custom_candidate_attributes}
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Edit
    IF  '${new_attribute_name}' == 'None'
        ${new_attribute_name} =    Generate random name    auto_custom_candidate_attr
    END
    Input into    ${ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX}    ${new_attribute_name}
    Click at    ${ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON}
    wait for page load successfully v1
    Capture page screenshot
    [Return]    ${new_attribute_name}

Delete a candidate attribute
    [Arguments]  ${attribute_name}
    Go to System Attributes
    Click at    ${NAV_ITEM_TEXT}    ${candidates}
    Click at    ${NAV_ITEM_TEXT}    ${custom_candidate_attributes}
    Open Eclipse menu of Attribute  ${attribute_name}
    Click at  ${SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION}  Delete
    Click at  ${SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON}  Delete
    wait for page load successfully v1
