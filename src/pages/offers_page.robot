*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/forms_page.robot
Variables       ../locators/offers_locators.py

*** Keywords ***
Get Offer Quill mention displayed list
    ${item_list} =    Create List
    ${item_elements} =    Get WebElements    ${OFFER_QUILL_MENTION_LIST}
    FOR    ${element}    IN    @{item_elements}
        ${element_text} =    Replace HTML tag with value    ${element.get_attribute('innerHTML')}
        ...    <span class="color-primary">#</span>    ${EMPTY}
        ${element_text} =    Replace HTML tag with value    ${element_text}    <span class="color-primary"></span>    ${EMPTY}
        Append To List    ${item_list}    ${element_text}
    END
    [Return]    ${item_list}

Display the token list that include All Location Attributes that created on System Attributes page
    [Arguments]    ${all_location_attr_keys}
    ${displayed_tokens} =    Get Offer Quill mention displayed list
    FOR    ${key_name}    IN    @{all_location_attr_keys}
        Check element existed in list    la-${key_name}    ${displayed_tokens}
    END

Create a new offer
    [Arguments]    ${custom_attr}=None      ${offer_name}=None
    IF   '${offer_name}' == 'None'
        ${offer_name} =    Generate random name    auto_offer
    END
    Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_NAME_TEXT_BOX}
    Press Keys    None    ${offer_name}
    Input into    ${OFFER_CONTENT_EDITOR}    Sincerely \#la-${custom_attr} ${offer_name}
    Press keys  None    ENTER
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    [Return]    ${offer_name}

Create a new offer not contain start date and pay rate
    [Arguments]    ${custom_attr}=None      ${offer_name}=None
    IF   '${offer_name}' == 'None'
        ${offer_name} =    Generate random name    auto_offer
    END
    Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_NAME_TEXT_BOX}
    Press Keys    None    ${offer_name}
    Input into    ${OFFER_CONTENT_EDITOR}    \#la-${custom_attr} ${offer_name}
    # Remote start date and pay rate component
    Hover at    ${NEW_OFFER_COMPONENT_LABEL}    Start Date
    Click at    ${NEW_OFFER_REMOVE_COMPONENT_ICON}
    Click at    ${NEW_OFFER_REMOVE_COMPONENT_CONFIRM}
    Hover at    ${NEW_OFFER_COMPONENT_LABEL}    Starting Pay Rate
    Click at    ${NEW_OFFER_REMOVE_COMPONENT_ICON}
    Click at    ${NEW_OFFER_REMOVE_COMPONENT_CONFIRM}
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    [Return]    ${offer_name}

Search offer
    [Arguments]    ${offer_name}
    input text    ${SEARCH_OFFER_TEXT_BOX}    ${offer_name}

Check and create a new offer
    [Arguments]    ${offer_name}
    Go to Offers page
    Search offer    ${offer_name}
    ${locator} =    Format String    ${COMMON_TEXT}    ${offer_name}
    ${is_existed_offer} =    Run Keyword And Return Status    Check element display on screen    ${locator}
    IF    '${is_existed_offer}' == 'False'
        Click at    Add offer
        Click at    ${NEW_OFFER_NAME_TEXT_BOX}
        Press Keys    None    ${offer_name}
        Input into    ${OFFER_CONTENT_EDITOR}    ${offer_name}
        Click at    ${NEW_OFFER_CREATE_BUTTON}
        Click at    ${NEW_OFFER_PUBLISH_STATUS}
        Click at    ${NEW_OFFER_PUBLISH_BUTTON}
        Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    END

Create Candidate journey has offer stage
    [Arguments]      ${cj_name}=None
    ${cj_name} =    Add a Candidate Journey     ${cj_name}
    Add a Journey Stage    ${cj_name}    Offer
    Wait with short time
    Click at    ${PUBLISH_STAGE_BUTTON}
    Wait with short time
    [Return]    ${cj_name}

Duplicate an offer
    [Arguments]    ${offer_name}
    Go to Offers page
    Input into    ${SEARCH_OFFER_TEXT_BOX}    ${offer_name}
    Hover at    ${offer_name}
    Click at    ${OFFER_LIST_ECLIPSE_ICON}
    Click at    ${OFFER_ECLIPSE_POPUP_ICON_DUPLICATE_ICON}
    [Return]    Copy - ${offer_name}

Delete a offer
    [Arguments]    ${offer_name}
    Go to Offers page
    Input into    ${SEARCH_OFFER_TEXT_BOX}    ${offer_name}
    Hover at    ${offer_name}
    Click at    ${OFFER_LIST_ECLIPSE_ICON}
    Click at    ${OFFER_ECLIPSE_POPUP_ICON_DELETE_ICON}

Enter verify code in Offer letter
    [Arguments]    ${verify_code}
    ${single_code} =    Get Regexp Matches    ${verify_code}    [0-9]
    Input into    ${OPEN_OFFER_VERIFY_CODE_1}    ${single_code}[0]
    Input into    ${OPEN_OFFER_VERIFY_CODE_2}    ${single_code}[1]
    Input into    ${OPEN_OFFER_VERIFY_CODE_3}    ${single_code}[2]
    Input into    ${OPEN_OFFER_VERIFY_CODE_4}    ${single_code}[3]
    Input into    ${OPEN_OFFER_VERIFY_CODE_5}    ${single_code}[4]
    Input into    ${OPEN_OFFER_VERIFY_CODE_6}    ${single_code}[5]

Setting data for Add Additional Date component
    [Arguments]     ${validation_option}    ${additional_date_name}=None   ${add_field_mapping}=None   ${destination_field}=auto_destination_field
    IF  '${additional_date_name}' == 'None'
        ${additional_date_name} =  Generate random name only text  auto_additional
    END
    Click at    ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${additional_date_name}
    Click at    ${NEW_OFFER_COMPONENT_VALIDATION_DROPDOWN}
    Click at    ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}    ${validation_option}
    IF  '${add_field_mapping}' != 'None'
        Click at    Add Field Mapping
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_VALUE}   ${add_field_mapping}
        Input into  ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}    ${destination_field}
    END
    Click at    ${NEW_OFFER_COMPONENT_ADD_BUTTON}
    [Return]   ${additional_date_name}

Setting data for Add Document component
    [Arguments]     ${upload_file}    ${document_name}=None
    IF  '${document_name}' == 'None'
        ${document_name} =  Generate random name only text  auto_document
    END
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${document_name}
    ${path_image} =    get_path_upload_image_path    ${upload_file}
        ${element} =    Get Webelement    ${NEW_OFFER_INPUT_DOCUMENT}
        EXECUTE JAVASCRIPT
        ...    arguments[0].setAttribute('style', '');
        ...    ARGUMENTS    ${element}
        Input into    ${NEW_OFFER_INPUT_DOCUMENT}    ${path_image}
    Wait with short time
    Check document is added     ${upload_file}
    Click at    ${NEW_OFFER_COMPONENT_ADD_BUTTON}
    [Return]   ${document_name}

Check document is added
    [Arguments]     ${upload_file_name}
    ${actual_file_name} =     Get text and format text    ${NEW_OFFER_DOCUMENT_LABEL}
    should contain     ${actual_file_name}   ${upload_file_name}

Setting data for Add Dropdown component
    [Arguments]     ${number_option}    ${dropdown_name}=None   ${add_field_mapping}=None   ${destination_field}=auto_destination_field
    IF  '${dropdown_name}' == 'None'
        ${dropdown_name} =  Generate random name only text  auto_dropdown
    END
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${dropdown_name}
    ${option_value} =   Generate random name only text  option_test
    Input into  ${NEW_OFFER_DROPDOWN_OPTION_WITH_INDEX}   ${option_value}    1
    ${option_value} =   Generate random name only text  option_test
    Input into  ${NEW_OFFER_DROPDOWN_OPTION_WITH_INDEX}   ${option_value}    2
    IF  ${number_option} != 0
        FOR     ${option}   IN RANGE   ${number_option}
            Click on span text    Add Option
            ${option_value} =   Generate random name only text  option_test
            Check element display on screen     ${NEW_OFFER_DROPDOWN_OPTION_WITH_INDEX}     ${option} + 3
            Input into  ${NEW_OFFER_DROPDOWN_OPTION_WITH_INDEX}   ${option_value}    ${option} + 3
        END
    END
    IF  '${add_field_mapping}' != 'None'
        Click at    Add Field Mapping
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_VALUE}   ${add_field_mapping}
        Input into  ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}    ${destination_field}
    END
    Click at    ${NEW_OFFER_COMPONENT_ADD_BUTTON}
    [Return]   ${dropdown_name}

Setting data for Add Additional Pay Rate component
    [Arguments]     ${currency_option}=United States dollar    ${pay_rate_name}=None   ${add_field_mapping}=None   ${pay_frequency}=per hour    ${destination_field}=auto_destination_field
    IF  '${pay_rate_name}' == 'None'
        ${pay_rate_name} =  Generate random name only text  auto_pay_rate
    END
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${pay_rate_name}
    Click at    ${NEW_OFFER_COMPONENT_CURRENCY_DROPDOWN}
    Input into  ${NEW_OFFER_COMPONENT_CURRENCY_SEARCH}  ${currency_option}
    Click at    ${NEW_OFFER_COMPONENT_CURRENCY_OPTION}  ${currency_option}
    Click at    ${NEW_OFFER_COMPONENT_PAY_FREQUENCY_DROPDOWN}
    ${is_checked} =     Check status selected of pay frequency      ${pay_frequency}
    IF      '${is_checked}' == 'False'
        Click at    ${NEW_OFFER_COMPONENT_PAY_FREQUENCY_OPTION}     ${pay_frequency}
    END
    IF  '${add_field_mapping}' != 'None'
        Click at    Add Field Mapping
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_VALUE}   ${add_field_mapping}
        Input into  ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}    ${destination_field}
    END
    Click at    ${NEW_OFFER_COMPONENT_ADD_BUTTON}
    [Return]   ${pay_rate_name}

Check status selected of pay frequency
    [Arguments]     ${pay_frequency}
    ${class_atrribute} =    Get attribute and format text  class   ${NEW_OFFER_COMPONENT_PAY_FREQUENCY_STATUS}   ${pay_frequency}
    ${is_checked} =     Run keyword and return status   should contain    ${class_atrribute}     is-checked
    [Return]    ${is_checked}

Change conversation status to send offer
    [Arguments]     ${candidate_name}     ${conversation_status}
    Change conversation status  ${candidate_name}    ${conversation_status}    ${JOURNEY_SEND_OFFER_ACTION}
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer

Update content offer and resend offer
    [Arguments]     ${pay_rate_value}=5
    Click at    ${CONFIRM_OFFER_START_DATE}
    ${today_date} =      get_future_day_from_curent_date
    ${next_date}=    get_future_date_in_string      ${today_date}
    Click at    ${CONFIRM_OFFER_START_DATA_NEXT_DATE_VALUE}      ${next_date}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys  None  ${pay_rate_value}
    Click at    Update offer

Send Offer and input verify code
    [Arguments]     ${candidate_name}     ${conversation_status}    ${company_name}=None
    Change conversation status to send offer    ${candidate_name}   ${conversation_status}
    # Go to Offer letter
    Click button in email   Respond to your job offer at ${company_name}     ${candidate_name}   OFFER
    Enter code for verify code step   ${candidate_name}
    Capture page screenshot

Check UI of Publish Offer confirmation modal
    Check span display      Publish Offer
    Check p text display    Are you sure you want to publish this offer?
    Check element display on screen     ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    Check element display on screen     ${PUBLISH_OFFER_POPUP_CANCEL_BUTTON}

Navigate to offer page
    [Arguments]     ${offer_name}
    Go to Offers page
    Search offer    ${offer_name}
    Click at    ${offer_name}

Input offer name
    [Arguments]     ${offer_name}=None
    IF   '${offer_name}' == 'None'
        ${offer_name} =    Generate random name    auto_offer
    END
    Click at    ${NEW_OFFER_NAME_TEXT_BOX}
    Press Keys    None    ${offer_name}
    [Return]    ${offer_name}

Input offer component name
    [Arguments]     ${component_name}=None
    IF   '${component_name}' == 'None'
        ${component_name} =    Generate random name    auto_component
    END
    Click at    ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${component_name}
    [Return]    ${component_name}

Dupplicate Offer
    [Arguments]     ${offer_name}
    Go to Offers page
    Search offer    ${offer_name}
    Click at    ${OFFER_LIST_ITEM_MENU}     ${offer_name}
    Click at    ${OFFER_ECLIPSE_POPUP_ICON_DUPLICATE_ICON}

Preview an Offer
    [Arguments]     ${offer_name}
    Go to Offers page
    Search offer    ${offer_name}
    Click at    ${OFFER_LIST_ITEM_MENU}     ${offer_name}
    Click at    ${OFFER_ECLIPSE_POPUP_ICON_PREVIEW_ICON}

Click offer editor and add component
    [Arguments]     ${component_name}
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Press keys  None    ENTER
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      ${component_name}

Setting data for Add Location Lookup component
    [Arguments]     ${location_lookup_name}=None   ${add_field_mapping}=Offer Created Date   ${destination_field}=auto_destination_field      ${store_att_as_field}=Location Name
    IF  '${location_lookup_name}' == 'None'
        ${location_lookup_name} =  Generate random name only text  auto_location_lookup
    END
    Click at    ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${location_lookup_name}
    Click at    Add Field Mapping
    IF  '${add_field_mapping}' != 'None'
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_VALUE}   ${add_field_mapping}
    END
    IF  '${store_att_as_field}' != 'None'
        Click at    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_VALUE}   ${store_att_as_field}
    END
    IF  '${destination_field}' != 'None'
        Input into  ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}    ${destination_field}
    END
    Click at    ${NEW_OFFER_COMPONENT_ADD_BUTTON}
    [Return]   ${location_lookup_name}

Setting data for Add User Lookup component
    [Arguments]     ${user_lookup_name}=None   ${add_field_mapping}=Offer Created Date   ${destination_field}=auto_destination_field      ${store_att_as_field}=User Name
    IF  '${user_lookup_name}' == 'None'
        ${user_lookup_name} =  Generate random name only text  auto_user_lookup
    END
    Click at    ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Input into  ${NEW_OFFER_COMPONENT_NAME_INPUT}   ${user_lookup_name}
    Click at    Add Field Mapping
    IF  '${add_field_mapping}' != 'None'
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_VALUE}   ${add_field_mapping}
    END
    IF  '${store_att_as_field}' != 'None'
        Click at    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
        Click at    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_VALUE}   ${store_att_as_field}
    END
    IF  '${destination_field}' != 'None'
        Input into  ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}    ${destination_field}
    END
    Click at    ${NEW_OFFER_COMPONENT_ADD_BUTTON}
    [Return]   ${user_lookup_name}

Delete job and offer data after check
    [Arguments]      ${job_name}    ${offer_name}
    Go to CEM page
    Switch to user  ${TEAM_USER}
    Go to My Jobs page
    Deactivate a job    ${job_name}     ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}
    Delete a offer      ${offer_name}

Create new offer with Location lookup compoment
    [Arguments]    ${offer_name}=None   ${add_field_mapping}=None   ${destination_field}=None   ${store_att_as_field}=None
    IF   '${offer_name}' == 'None'
        ${offer_name} =    Generate random name    auto_offer
    END
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name    ${offer_name}
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name}=   Setting data for Add Location Lookup component   add_field_mapping=${add_field_mapping}      destination_field=${destination_field}      store_att_as_field=${store_att_as_field}
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    [Return]    ${offer_name}

Create new offer with User lookup compoment
    [Arguments]    ${offer_name}=None   ${add_field_mapping}=None   ${destination_field}=None   ${store_att_as_field}=None
    IF   '${offer_name}' == 'None'
        ${offer_name} =    Generate random name    auto_offer
    END
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name    ${offer_name}
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name}=   Setting data for Add User Lookup component   add_field_mapping=${add_field_mapping}      destination_field=${destination_field}      store_att_as_field=${store_att_as_field}
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    [Return]    ${offer_name}

Send Offer with Location lookup
    [Arguments]     ${candidate_name}     ${conversation_status}    ${company_name}=None    ${search_keyword}=None   ${location_lookup}=None
    Change conversation status  ${candidate_name}    ${conversation_status}    ${JOURNEY_SEND_OFFER_ACTION}
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    IF  '${location_lookup}' != 'None'
        Input into  ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}   ${search_keyword}
        Click at    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    END
    Click at    Send offer
    capture page screenshot
    # Go to Offer letter
    Click button in email   Respond to your job offer at ${company_name}     ${candidate_name}   OFFER
    Enter code for verify code step   ${candidate_name}
    Capture page screenshot

Send Offer with User lookup
    [Arguments]     ${candidate_name}     ${conversation_status}    ${company_name}=None    ${search_keyword}=None   ${user_lookup}=None
    Change conversation status  ${candidate_name}    ${conversation_status}    ${JOURNEY_SEND_OFFER_ACTION}
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    IF  '${user_lookup}' != 'None'
        Input into  ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}   ${search_keyword}
        Click at    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${user_lookup}
    END
    Click at    Send offer
    capture page screenshot
    # Go to Offer letter
    Click button in email   Respond to your job offer at ${company_name}     ${candidate_name}   OFFER
    Enter code for verify code step   ${candidate_name}
    Capture page screenshot

Delete a component
    [Arguments]     ${component_name}
    Hover at          ${component_name}
    Click at    ${NEW_OFFER_DELETE_COMPONENT_ICON}      ${component_name}
    Click at    ${DELETE_COMPONENT_POPUP_CANCEL_DELETE_BUTTON}     Delete
    Click At    ${NEW_OFFER_CREATE_BUTTON}
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}     Offer is updated successfully!
    Click At    ${NEW_OFFER_PUBLISH_STATUS}
    Click At    ${NEW_OFFER_PUBLISH_BUTTON}
    Click At    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}     Offer is published successfully!
