*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/all_candidates_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    stg    test

*** Variables ***
${form_user_lookup_checked}             User_Lookup_Type_Checked
${form_location_lookup_checked}         Location_Lookup_Type_Checked
${question_name_1}                      Question 1
${form_user_lookup_unchecked}           User_Lookup_Type_Unchecked
${form_location_lookup_unchecked}       Location_Lookup_Type_Unchecked
${question_name_2}                      Question 2
&{system_attribute_info}                sys_attr_menu=Standard Candidate Attributes    sys_attr_value=Candidate First Name

*** Test Cases ***
Check that CAN add User Form - Custom Question task type with answer type = Location Lookup and User Lookup for Default Section, Custom Section (OL-T24895, OL-T24874, OL-T24896, OL-T24875)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name}=       Add new form and input name     ${user_form}
    # Location Lookup Default Section
    Create Custom Question task type with answer type       ${location_lookup}      section=${default_section}
    Verify UI Custom Question task type     ${default_section}      ${location_lookup}      ${title_custom_question}
    # User Lookup Default Section
    Create Custom Question task type with answer type       ${user_lookup}      ${question_name_1}
    Verify UI Custom Question task type     ${default_section}      ${user_lookup}      ${question_name_1}
    Click At    ${FORM_SECTION_CANCEL_BUTTON}
    # Location Lookup Custom Section
    Click at    ${FORM_ADD_SECTION_BUTTON}
    Wait until element is visible       ${FORM_HEADER_SECTION}
    Create Custom Question task type with answer type       ${location_lookup}
    Verify UI Custom Question task type     ${custom}       ${location_lookup}      ${title_custom_question}
    # User Lookup Custom Section
    Create Custom Question task type with answer type       ${user_lookup}      ${question_name_1}
    Verify UI Custom Question task type     ${custom}       ${user_lookup}      ${question_name_1}
    Delete a form with type     ${user_form}    ${form_name}


Check that CAN add many Custom Question task type that has answer type = Location Lookup and User Lookup on User Form (OL-T24908, OL-T24887)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    # Location Lookup
    Search form in form list    ${user_form}    ${form_location_lookup_checked}
    Click At    ${form_location_lookup_checked}
    ${question_name_duplicated_1}=      Duplicate a Custom Question     ${question_name_1}      ${location_lookup}      ${default_section}
    Verify UI Custom Question duplication task type     ${question_name_duplicated_1}       ${location_lookup}
    Click At    ${FORM_SECTION_CANCEL_BUTTON}
    Delete a Custom Question    ${default_section}      ${question_name_duplicated_1}
    Delete a Custom Question    ${default_section}      ${title_custom_question}
    # User Lookup
    Go to form page
    Search form in form list    ${user_form}    ${form_user_lookup_checked}
    Click At    ${form_user_lookup_checked}
    ${question_name_duplicated_2}=      Duplicate a Custom Question     ${question_name_1}      ${user_lookup}      ${default_section}
    Verify UI Custom Question duplication task type     ${question_name_duplicated_2}       ${user_lookup}
    Click At    ${FORM_SECTION_CANCEL_BUTTON}
    Delete a Custom Question    ${default_section}      ${question_name_duplicated_2}
    Delete a Custom Question    ${default_section}      ${title_custom_question}


Check that CAN setting Sensitive Information, Hide from Manager, Allow Multi-Select, Required toggle for User Form - Custom Question task type that has answer type = Location Lookup (OL-T24898, OL-T24899, OL-T24900, OL-T24901)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Search form in form list    ${user_form}    ${form_location_lookup_unchecked}
    Click At    ${form_location_lookup_unchecked}
    # Sensitive Information
    Check/Uncheck selected checkbox of Custom Question task type    Sensitive Information       ${default_section}
    Check UI task when tick checkbox    ${location_lookup}      Sensitive Information
    Check/Uncheck selected checkbox of Custom Question task type    Sensitive Information
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${location_lookup}
    # Hide from Manager
    Check/Uncheck selected checkbox of Custom Question task type    Hide Manager
    Check UI task when tick checkbox    ${location_lookup}      Hide Manager
    Check/Uncheck selected checkbox of Custom Question task type    Hide Manager
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${location_lookup}
    # Allow Multi-Select
    Check/Uncheck selected checkbox of Custom Question task type    Multi Select
    Check UI task when tick checkbox    ${location_lookup}      Multi Select
    Check/Uncheck selected checkbox of Custom Question task type    Multi Select
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${location_lookup}
    # Required toggle
    Check/Uncheck selected checkbox of Custom Question task type    Required toggle
    Check UI task when tick checkbox    ${location_lookup}      Required toggle
    Check/Uncheck selected checkbox of Custom Question task type    Required toggle
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${location_lookup}


Check that CAN setting Sensitive Information, Hide from Manager, Allow Multi-Select, Required toggle for User Form - Custom Question task type that has answer type = User Lookup (OL-T24877, OL-T24878, OL-T24879, OL-T24880)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Search form in form list    ${user_form}    ${form_user_lookup_unchecked}
    Click At    ${form_user_lookup_unchecked}
    # Sensitive Information
    Check/Uncheck selected checkbox of Custom Question task type    Sensitive Information       ${default_section}
    Check UI task when tick checkbox    ${user_lookup}      Sensitive Information
    Check/Uncheck selected checkbox of Custom Question task type    Sensitive Information
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${user_lookup}
    # Hide from Manager
    Check/Uncheck selected checkbox of Custom Question task type    Hide Manager
    Check UI task when tick checkbox    ${user_lookup}      Hide Manager
    Check/Uncheck selected checkbox of Custom Question task type    Hide Manager
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${user_lookup}
    # Allow Multi-Select
    Check/Uncheck selected checkbox of Custom Question task type    Multi Select
    Check UI task when tick checkbox    ${user_lookup}      Multi Select
    Check/Uncheck selected checkbox of Custom Question task type    Multi Select
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${user_lookup}
    # Required toggle
    Check/Uncheck selected checkbox of Custom Question task type    Required toggle
    Check UI task when tick checkbox    ${user_lookup}      Required toggle
    Check/Uncheck selected checkbox of Custom Question task type    Required toggle
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name_2}      ${user_lookup}


Check that CAN duplicate, delete Custom Question task type that has answer type = Location Lookup (OL-T24906, OL-T24907)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Search form in form list    ${user_form}    ${form_location_lookup_checked}
    Click At    ${form_location_lookup_checked}
    # Duplicate Custom Question
    ${question_name_duplicated}=    Duplicate a Custom Question     ${question_name_1}      ${location_lookup}      ${default_section}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question task display correctly with element is checked    ${user_form}    ${question_name_duplicated}     ${location_lookup}
    Check that can setting Field Mapping
    Click At    ${FORM_SECTION_CANCEL_BUTTON}
    # Delete Custom Question
    Delete a Custom Question    ${default_section}      ${question_name_duplicated}
    Go to a form section detail     ${default_section}
    Check Element Not Display On Screen     ${question_name_duplicated}     wait_time=5s
    Capture Page Screenshot


Check that CAN duplicate, delete Custom Question task type that has answer type = User Lookup (OL-T24885, OL-T24886)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Search form in form list    ${user_form}    ${form_user_lookup_checked}
    Click At    ${form_user_lookup_checked}
     # Duplicate Custom Question
    ${question_name_duplicated}=    Duplicate a Custom Question     ${question_name_1}      ${user_lookup}      ${default_section}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question task display correctly with element is checked    ${user_form}    ${question_name_duplicated}     ${user_lookup}
    Check that can setting Field Mapping
    Click At    ${FORM_SECTION_CANCEL_BUTTON}
    # Delete Custom Question
    Delete a Custom Question    ${default_section}      ${question_name_duplicated}
    Go to a form section detail     ${default_section}
    Check Element Not Display On Screen     ${question_name_duplicated}     wait_time=5s
    Capture Page Screenshot


Check that CAN duplicate, delete Form that has answer type = Location Lookup and User Lookup on User Form (OL-T24909, OL-T24888, OL-T24912, OL-T24891)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Duplicate with answer type = Location Lookup
    Go to form page
    ${form_duplicated_1}=       Duplicate a Form    ${form_location_lookup_checked}     User
    Check UI duplicate form     ${form_duplicated_1}    ${location_lookup}
    # Duplicate with answer type = User Lookup
    Go to form page
    ${form_duplicated_2}=       Duplicate a Form    ${form_user_lookup_checked}     User
    Check UI duplicate form     ${form_duplicated_2}    ${user_lookup}
    # Delete Form
    Delete a form with type     ${user_form}    ${form_duplicated_1}
    Delete a form with type     ${user_form}    ${form_duplicated_2}


Check that CAN setting only System Attribute for Custom Question task type that has answer type = User Lookup and Location Lookup with (OL-T24881, OL-T24902)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # User Lookup
    Go to form page
    Search form in form list    ${user_form}    ${form_user_lookup_unchecked}
    Click At    ${form_user_lookup_unchecked}
    Create a Field Mapping
    Fill data for Field Mapping in Task     ${question_name_2}      System Attribute    ${user_lookup}      ${system_attribute_info}    User Name
    Click Save Task
    Go to a form section detail     ${default_section}
    Check Field Mapping when changed    System Attribute    ${user_lookup}
    Click at    ${FORM_MAPPING_MODAL_REMOVE_BUTTON}
    Click Save Task
    # Location Lookup
    Go to form page
    Search form in form list    ${user_form}    ${form_location_lookup_unchecked}
    Click At    ${form_location_lookup_unchecked}
    Create a Field Mapping
    Fill data for Field Mapping in Task     ${question_name_2}      System Attribute    ${location_lookup}      ${system_attribute_info}    Location Name
    Click Save Task
    Go to a form section detail     ${default_section}
    Check Field Mapping when changed    System Attribute    ${location_lookup}
    Click at    ${FORM_MAPPING_MODAL_REMOVE_BUTTON}
    Click Save Task

*** Keywords ***
Check UI task when tick checkbox
    [Arguments]     ${response_type}      ${type}
    Go to a form section detail     ${default_section}
    IF    '${type}' == 'Sensitive Information'
        Verify attribute should contain     class       is-checked      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name_2}
    ELSE IF    '${type}' == 'Hide Manager'
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should contain     class       is-checked      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name_2}
    ELSE IF    '${type}' == 'Multi Select'
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should contain     class       is-checked      ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name_2}
    ELSE IF    '${type}' == 'Required toggle'
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name_2}
        Verify attribute should not contain     class       is-checked      ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name_2}
        Verify attribute should contain     class       is-checked      ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name_2}
    END
    IF    '${response_type}' == 'Location Lookup'
        Check Element Display On Screen     ${SEARCH_LOCATION_LOOKUP_INPUT}     ${question_name_2}
    ELSE
        Check Element Display On Screen     ${SEARCH_NAME_LOOKUP_INPUT}     ${question_name_2}
    END
    Capture Page Screenshot

Verify UI Custom Question task type
    [Arguments]    ${section}       ${answer_type}      ${question_name}
    Go to a form section detail     ${section}
    Verify UI Custom Question form display correctly    ${user_form}    ${question_name}    ${answer_type}
    IF    '${answer_type}' == 'Location Lookup'
        Check Element Display On Screen     ${SEARCH_LOCATION_LOOKUP_INPUT}     ${question_name}
    ELSE
        Check Element Display On Screen     ${SEARCH_NAME_LOOKUP_INPUT}     ${question_name}
    END
    Capture Page Screenshot

Verify UI Custom Question duplication task type
    [Arguments]    ${question_name_duplicated}      ${answer_type}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question task display correctly with element is checked    ${user_form}    ${question_name_duplicated}     ${answer_type}
    Create Custom Question task type with answer type       ${answer_type}
    Go to a form section detail     ${default_section}
    Check Text Display      ${question_name_1}
    Check Text Display      ${question_name_duplicated}
    Check Text Display      ${title_custom_question}
    Capture Page Screenshot

Check/Uncheck selected checkbox of Custom Question task type
    [Arguments]    ${type}      ${section}=None
    IF      '${section}' != 'None'
        Go to a form section detail     ${section}
    END
    IF    '${type}' == 'Sensitive Information'
        Click At    ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name_2}
    ELSE IF    '${type}' == 'Hide Manager'
        Click At    ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name_2}
    ELSE IF    '${type}' == 'Multi Select'
        Click At    ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name_2}
    ELSE IF    '${type}' == 'Required toggle'
        Click At    ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name_2}
    END
    Click Save Task

Check that can setting Field Mapping
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${question_name_1}
    Click At    ${FIELD_MAPPING_ICON}
    Check UI Field Mapping in Task
    Click At    ${FORM_MAPPING_MODAL_CANCEL_BUTTON}
    Check Element Not Display On Screen    ${FIELD_MAPPING_ICON}    wait_time=5s
    Capture Page Screenshot

Check UI Field Mapping in Task
    Check Element Display On Screen    ${TASK_MAPPING_FIELD_MODAL}
    Check Text Display    Source field
    Check Text Display    System Attribute
    Check Text Display    Store Attribute as Field Value
    Check Text Display    Destination Field
    Capture Page Screenshot

Check UI duplicate form
    [Arguments]    ${form_duplicated}   ${answer_type}
    Search form in form list    ${user_form}    ${form_duplicated}
    Click At    ${form_duplicated}
    Go to a form section detail     ${default_section}
    Check Text Display    ${question_name_1}
    Verify UI Custom Question task display correctly with element is checked    ${user_form}    ${question_name_1}     ${answer_type}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${question_name_1}
    Click At    ${FIELD_MAPPING_ICON}
    Check UI Field Mapping in Task
    Capture Page Screenshot

Create a Field Mapping
    Go to a form section detail     ${default_section}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${question_name_2}
    Click At    ${FIELD_MAPPING_ICON}
    Check UI Field Mapping in Task
    Click At    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
    Click At    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_SELECT_OPTION}
    Click At    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE}
    Click At    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE_OPTION}    Select

Check Field Mapping when changed
    [Arguments]    ${type}      ${answer_type}
    Click At    ${FIELD_MAPPING_ICON_BY_QUESTION_NAME}      ${question_name_2}
    Click At    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
    Verify attribute should contain    class    selected    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_SELECT_OPTION}
    IF    '${type}' == 'System Attribute'
        Check Element Display On Screen    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE_INPUT}      ${system_attribute_info.sys_attr_value}
    ELSE
        Check Element Display On Screen    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE_INPUT}      Select
    END
    Click At    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE}
    IF    '${type}' == 'Store Attribute' and '${answer_type}' == 'Location Lookup'
        Verify attribute should contain    class    selected    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE_OPTION}    Location Name
    ELSE IF    '${type}' == 'Store Attribute' and '${answer_type}' == 'User Lookup'
        Verify attribute should contain    class    selected    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE_OPTION}    User Name
    ELSE
        Verify attribute should contain    class    selected    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE_OPTION}    Select
    END
    Click At    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE}
    Textfield Value Should Be    ${FORM_MAPPING_MODAL_ATS_DESTINATION_FIELD}    ${EMPTY}
    Capture page screenshot
