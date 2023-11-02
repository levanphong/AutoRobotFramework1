*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../commons/conversation/common_features/skip_next_question_commons.robot
Variables       ../locators/conversation_builder_locators.py

*** Keywords ***
Search Conversation in Conversation Builder
    [Arguments]    ${conversation_name}
    Simulate Input    ${CONVERSATION_SEARCH_BOX}    ${conversation_name}
    ${is_displayed} =     Run keyword and return status   Check element display on screen    ${ROW_CONVERSATION_NAME}     ${conversation_name}
    IF  '${is_displayed}' == 'False'
        Reload Page
        Check element display on screen  ${CONVERSATION_LIST}   wait_time=30s
        Simulate Input    ${CONVERSATION_SEARCH_BOX}    ${conversation_name}
        Check element display on screen    ${ROW_CONVERSATION_NAME}     ${conversation_name}
    END

Find and go to conversation detail
    [Arguments]    ${conversation_name}
    Search Conversation in Conversation Builder    ${conversation_name}
    Run keyword and ignore error    Click at    ${conversation_name}
    ${is_clicked} =     Run keyword and return status   Check element display on screen    ${QUESTION_BOX}
    IF  '${is_clicked}' == 'False'
        Reload Page
        Check element display on screen  ${CONVERSATION_LIST}   wait_time=30s
        Search Conversation in Conversation Builder    ${conversation_name}
        Click at    ${conversation_name}
    END

Find and Duplicate conversation
    [Arguments]    ${conversation_name}
    Search Conversation in Conversation Builder    ${conversation_name}
    Run keyword and ignore error    Click by JS    ${CONVERSATION_ROW_ECLIPSE_ICON}    ${conversation_name}
    ${is_clicked} =     Run keyword and return status   Check element display on screen    ${ECLIPSE_DUPLICATE_BUTTON}
    IF  '${is_clicked}' == 'False'
        Reload Page
        Check element display on screen  ${CONVERSATION_LIST}   wait_time=30s
        Search Conversation in Conversation Builder    ${conversation_name}
        Click by JS    ${CONVERSATION_ROW_ECLIPSE_ICON}    ${conversation_name}
    END
    Click at    ${ECLIPSE_DUPLICATE_BUTTON}
    Click at    ${CONFIRM_DUPLICATE_BUTTON}

Check number of questions of
    [Arguments]    ${question_group}    ${expected_number}
    ${count} =    Get Element Count    ${question_group}
    should be equal as strings    ${count}    ${expected_number}

Click on option toggle in Edit Question Option dialog
    [Arguments]    ${value}
    Click by JS  ${CONVERSATION_QUESTION_OPTION_TOGGLE}  ${value}

Skip Next Question builder common check
    ${starting_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should match regexp    ${starting_value}    ((Question:)?)Age$
    Check element display on screen    ${SKIP_QUESTION_DISABLED}
    ${skip_question} =    Get value and format text    ${SKIP_QUESTION_DISABLED}
    Should Be Equal As Strings    ${skip_question}    Like
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}

Verify Skip Next Question builder for Dynamic conversation
    Wait with short time
    Check element display on screen    ${STARTING_VALUE_ENABLED}
    Skip Next Question builder common check
    Check element display on screen    ${TEXT_INPUT_TEXTBOX}

Verify Skip Next Question builder for Single/Multiple Path conversation
    Wait with short time
    Check element display on screen    ${STARTING_VALUE_ENABLED}
    Skip Next Question builder common check
    Check element display on screen    ${TEXT_INPUT_DROPDOWN_ICON}

Verify tooltip is display
    [Arguments]    ${tooltip}
    ${tooltip_locator} =    Format String    ${TOOLTIP_MESSAGE}    ${tooltip}
    Check element display on screen    ${tooltip_locator}

Click Question tooltip in Eclipse Menu
    [Arguments]    ${tooltip_name}
    ${tooltip_locator} =    Format string    ${QUESTION_TOOLTIP_MENU}    ${tooltip_name}
    Click by JS    ${tooltip_locator}
    [Return]    ${tooltip_locator}

Add System Attribute to question
    [Arguments]    ${data_type}
    Click Question tooltip in Eclipse Menu    System Attribute
    Click at    ${SYSTEM_ATTR_METHOD}
    ${data_method_locator} =    Format string    ${SYSTEM_ATTR_METHOD_VALUE}    ${data_type}
    Click by JS    ${data_method_locator}
    Click at    ${MAP_TO_SYSTEM_ATTR}
    ${data_method_locator} =    Format string    ${SYSTEM_ATTR_METHOD_VALUE}    City
    Click by JS    ${data_method_locator}
    Click at    ${SYSTEM_ATTR_POPUP_SAVE}

Choose value from Skip Next Question tool dropdown
    [Arguments]    ${value}
    ${is_clickable} =   Run keyword and return status    Click at    ${SKIP_QUESTION_TOOL_DROPDOWN_OPTION}    ${value}       2s
    IF  '${is_clickable}' == 'False'
        Click at    ${SKIP_QUESTION_TOOL_DROPDOWN_CHECKBOX}    ${value}     2s
    END

Public the conversation
    Click at    ${PUBLIC_STATUS_BUTTON}     slow_down=2s
    Click at    ${PUBLIC_BUTTON}
    Check Element Display On Screen    ${CONVERSATION_PUBLIC_STATUS_LABEL}

Check the conversation is added successfully
    [Arguments]    ${conversation_name}
    Search Conversation in Conversation Builder    ${conversation_name}
    wait for page load successfully
    ${conversation_locator} =    Format string    ${ROW_CONVERSATION_NAME}    ${conversation_name}
    Check element display on screen    ${conversation_locator}
    Capture page screenshot

Add new Candidate Journey and add Conversation Stage
    [Arguments]    ${journey_name}
    IF    '${journey_name}' == 'None'
        ${journey_name} =    Add a Candidate Journey
    ELSE
        Add a Candidate Journey    ${journey_name}
    END
    Add a Journey Stage    ${journey_name}    Conversation
    Click at    ${PUBLISH_STAGE_BUTTON}
    sleep    3s
    [Return]    ${journey_name}

Add Candidate Journey to Conversation
    [Arguments]    ${journey_name}
    Click at    ${CANDIDATE_JOURNEY_DROPDOWN}
    Input into    ${SEARCH_JOURNEY_TEXT_BOX}    ${journey_name}
    Click at    ${journey_name}     slow_down=2s
    Public the conversation

Add Group to Conversation
    [Arguments]    ${group_name}
    Click at    ${CANDIDATE_JOURNEY_DROPDOWN}
    Input into    ${SEARCH_GROUP_TEXT_BOX}    ${group_name}
    Click at    ${group_name}

Add language to Conversation
    [Arguments]    @{language}
    Click at    ${CONVERSATION_LANGUAGE_DROPDOWN}
    FOR     ${option}   IN      @{language}
        Input into    ${CONVERSATION_SEARCH_LANGUAGE_TEXTBOX}    ${option}
        Click on common text last    ${option}
    END
    # Click to save
    Click at    ${CONVERSATION_LANGUAGE_DROPDOWN}
    Click on common text last   Got it

when Add new conversation with name and type
    [Arguments]    ${name}    ${type}
    Click at    ${ADD_CONVERSATION_BUTTON}
    Click at    ${ADD_NEW_CONVERSATION}
    wait for page load successfully v1
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${name}
    Click at    ${CONVERSATION_TEMPLATE}
    Click on span text    ${type}
    wait for page load successfully v1

when Select a location at Available locations
    [Arguments]    ${location}
    Click at    ${AVAILABLE_LOCATIONS_DROPDOWN}
    Click at    ${AVAILABLE_LOCATIONS_SELECT_LOCATION_OPTION}
    Input into    ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${location}
    ${location_checkbox} =    format string    ${AVAILABLE_LOCATIONS_SELECT_BY_LOCATION_NAME}    ${location}
    Click at    ${location_checkbox}
    # Click to save
    Click at    ${AVAILABLE_LOCATIONS_DROPDOWN}
    wait for page load successfully v1

when Select multiple locations at Available locations
    [Arguments]    ${location_1}    ${location_2}
    Click at    ${AVAILABLE_LOCATIONS_DROPDOWN}
    Click at    ${AVAILABLE_LOCATIONS_SELECT_LOCATION_OPTION}
    Input into    ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${location_1}
    ${location_checkbox_1} =    format string    ${AVAILABLE_LOCATIONS_SELECT_BY_LOCATION_NAME}    ${location_1}
    Click at    ${location_checkbox_1}
    Input into    ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${location_2}
    ${location_checkbox_2} =    format string    ${AVAILABLE_LOCATIONS_SELECT_BY_LOCATION_NAME}    ${location_2}
    Click at    ${location_checkbox_2}
    # Click to save
    Click at    ${AVAILABLE_LOCATIONS_DROPDOWN}
    wait for page load successfully v1

Location attribute list is displayed
    Check element display on screen    ${LOCATION_ATTRIBUTE_LIST}

Delete conversation in builder
    Click at    ${DELETE_CONVERSATION_BUTTON}
    Click at    ${CONVERSATION_DEACTIVATE_BUTTON}
    wait for page load successfully v1
    Run keyword and ignore error    Check element display on screen     Changes saved successfully.     wait_time=5s
    Run keyword and ignore error    Check element not display on screen     Changes saved successfully.     wait_time=5s

Select Screening and Action Then option
    [Arguments]    ${option}
    Click at    ${SCREENING_AND_ACTION_THEN_DROPDOWN}
    ${then_option_locator} =    format string    ${SCREENING_AND_ACTION_THEN_OPTION_BY_NAME}    ${option}
    Click at    ${then_option_locator}

Delete a Conversation
    [Arguments]    ${conversation_name}
    Go to conversation builder
    Search Conversation in Conversation Builder    ${conversation_name}
    Hover at    ${conversation_name}
    Click by JS    ${ECLIPSE_ICON}
    Click by JS    ${ECLIPSE_DELETE_BUTTON}
    Click at    ${CONFIRM_DELETE_BUTTON}
    Check element not display on screen  ${conversation_name}

Check conversation name is existing
    [Arguments]    ${new_conversation_name}
    Go to conversation builder
    run keyword and ignore error    Find conversation by search name    ${new_conversation_name}
    ${conversation_locator} =    Format string    ${ROW_CONVERSATION_NAME}    ${new_conversation_name}
    ${is_exesting} =    Run Keyword And Return Status    Check element display on screen    ${conversation_locator}
    [Return]    ${is_exesting}

Find conversation by search name
    [Arguments]    ${conversation_name}
    Search Conversation in Conversation Builder    ${conversation_name}
    wait for page load successfully

Add question for Conversation
    [Arguments]    ${question_content_locator}   ${question_content}    ${question_attr_locator}    ${question_attr}
    Click at    ${question_content_locator}
    Input into    ${question_content_locator}    ${question_content}
    Click at    ${question_attr_locator}
    Wait for page load successfully
    Input into    ${question_attr_locator}    ${question_attr}
    Press Keys    None    RETURN
    wait for page load successfully

Add Single conversation
    [Arguments]    ${type}      ${conversation_name}=None
    when Go to conversation builder
    Click add conversation
    IF  '${conversation_name}' == 'None'
        ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${conversation_name} =    Set variable    auto_${type}_${conversation_id}
    END
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT}    ${type}
    Click by JS    ${conversation_template}
    Check element display on screen    ${QUESTION_BOX}
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_2}  Your like?  ${GLOBAL_SCREENING_QUESTION_2_LABEL}  Like
    Public the conversation
    [Return]    ${conversation_name}

Add Multiple Path conversation
    [Arguments]    ${type}
    when Go to conversation builder
    Click add conversation
    ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_dynamic_name} =    Set variable    auto_${type}_${conversation_id}
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_dynamic_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${CONVERSATION_TYPE}    ${type}
    Click by JS    ${conversation_template}
    Check element display on screen    ${QUESTION_BOX}
    Click by JS    ${ADD_GROUP_1_QUESTION}
    Add question for Conversation  ${GROUP_QUESTION_CONTENT}  How old are you?  ${GROUP_1_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_GROUP_1_QUESTION}
    Add question for Conversation  ${GROUP_QUESTION_CONTENT}  Your like?  ${GROUP_1_QUESTION_2_LABEL}  Like
    Click by JS    ${ADD_GROUP_2_QUESTION}
    Add question for Conversation  ${GROUP_QUESTION_CONTENT}  How old are you?  ${GROUP_2_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_GROUP_2_QUESTION}
    Add question for Conversation  ${GROUP_QUESTION_CONTENT}  Your like?  ${GROUP_2_QUESTION_2_LABEL}  Like
    Check number of questions of    ${GROUP_2_QUESTION}    2
    Public the conversation
    [Return]    ${conversation_dynamic_name}

Add Dynamic conversation
    when Go to conversation builder
    Click add conversation
    ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_dynamic_name} =    Set variable    auto_Dynamic ATS conversation_${conversation_id}
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_dynamic_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT}    Dynamic ATS conversation
    Click by JS    ${conversation_template}
    Check element display on screen    ${QUESTION_BOX}
    Click by JS    ${ADD_CANDIDATE_QUESTION_BUTTON}
    Add question for Conversation  ${QUESTION_CONTENT}  How old are you?  ${CANDIDATE_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_CANDIDATE_QUESTION_BUTTON}
    Add question for Conversation  ${QUESTION_CONTENT}  Your like?  ${CANDIDATE_QUESTION_2_LABEL}  Like
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Add question for Conversation  ${QUESTION_CONTENT}  How old are you?  ${SCREENING_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Add question for Conversation  ${QUESTION_CONTENT}  Your like?  ${SCREENING_QUESTION_2_LABEL}  Like
    Check number of questions of    ${SCREENING_QUESTION}    2
    Public the conversation
    [Return]    ${conversation_dynamic_name}

Add Conditional Conversation
    [Arguments]    ${type}
    when Go to conversation builder
    Click add conversation
    ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_dynamic_name} =    Set variable    auto_${type}_${conversation_id}
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_dynamic_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${CONVERSATION_TYPE}    ${type}
    Click by JS    ${conversation_template}
    Check element display on screen    ${QUESTION_BOX}
    Click by JS    ${CONVERSATION_BLOCK_ADD_QUESTION_NO}
    Add question for Conversation  ${QUESTION_CONTENT}  What are your weaknesses?  ${QUESTION_NO_1_LABEL}  Weaknesses
    Click by JS    ${CONVERSATION_BLOCK_ADD_QUESTION_NO}
    Add question for Conversation  ${QUESTION_CONTENT}  What are your short term goals?  ${QUESTION_NO_2_LABEL}  Goals
    Click by JS    ${CONVERSATION_BLOCK_ADD_QUESTION_DEFAULT}
    Add question for Conversation  ${QUESTION_CONTENT}  Are you an organized person?  ${QUESTION_DEFAULT_1_LABEL}  Change
    Click by JS    ${CONVERSATION_BLOCK_ADD_QUESTION_DEFAULT}
    Add question for Conversation  ${QUESTION_CONTENT}  How do you handle change?  ${QUESTION_DEFAULT_2_LABEL}  Change
    Click by JS    ${CONVERSATION_BLOCK_ADD_QUESTION_YES}
    Add question for Conversation  ${QUESTION_CONTENT}  How old are you?  ${QUESTION_YES_1_LABEL}  Age
    Click by JS    ${CONVERSATION_BLOCK_ADD_QUESTION_YES}
    Add question for Conversation  ${QUESTION_CONTENT}  Your like?  ${QUESTION_YES_2_LABEL}  Like
    Public the conversation
    [Return]    ${conversation_dynamic_name}

Add Single(priority location) conversation
    [Arguments]   ${convo_name}=None    ${email_needed}=False    ${EEQ_needed}=False    ${language}=None
    Go to conversation builder
    Click add conversation
    IF   '${convo_name}' == 'None'
        ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${convo_name} =    Set variable    auto_convo_${conversation_id}
    END
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${convo_name}
    Click at    ${CONVERSATION_TEMPLATE}
    Click by JS     ${COMMON_SPAN_TEXT}    ${SINGLE_PATH_PRIORITY_TEMPLETE}
    Run Keyword If    "${language}" != "None"    Add language to Conversation    ${language}
    Check element display on screen    ${QUESTION_BOX}
    #   Select Available location
    Click at   ${AVAILABLE_LOCATIONS_DROPDOWN}
    Click at   ${AVAILABLE_LOCATIONS_SELECT_LOCATION_OPTION}
    Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    Phoenix
    Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    Phoenix
    Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    Tucson
    Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    Tucson
    Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    Scottsdale
    Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    Scottsdale
    Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    Gilbert
    Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    Gilbert
    Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    Glendale
    Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    Glendale
    Click at   Available locations
    Run Keyword If    '${email_needed}' == 'True'    Turn on   ${SINGLE_PATH_QUESTION_TOGGLE}  Email
    Run Keyword If    '${EEQ_needed}' == 'False'    Turn off    ${SINGLE_PATH_QUESTION_TOGGLE}  Equal Employment Opportunity
    Public the conversation
    [Return]    ${convo_name}

Add Hire conversation
    [Arguments]    ${conversation_name}=None
    when Go to conversation builder

    IF  '${conversation_name}' == 'None'
        ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${conversation_name} =    Set variable    auto_${HIRE_TEMPLETE}_${conversation_id}
    END
    Click add conversation
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT_V2}    ${HIRE_TEMPLETE}
    Click by JS    ${conversation_template}
    Public the conversation
    [Return]    ${conversation_name}

Click add conversation
    Click at    Add Conversation
    ${is_clicked} =     Run keyword and return status   Click at    Add New Conversation
    IF  '${is_clicked}' == 'False'
        Click at    Add Conversation
        Click at    Add New Conversation
    END

Delete a global screening question in conversation
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_DELETE_ICON}
    Click at    ${CONFIRM_DELETE_QUESTION_BUTTON}

Edit conversation message
    [Arguments]     ${locator}      ${message}
    Click at    ${locator}
    Wait for page load successfully
    Input into      ${locator}      ${message}

Go to edit conversation
    [Arguments]     ${conversation_name}
    Go to conversation builder
    Search Conversation in Conversation Builder    ${conversation_name}
    Hover at    ${conversation_name}
    Click at    ${ECLIPSE_ICON}
    Click at    ${ECLIPSE_EDIT_BUTTON}

Add Single conversation with email only
    [Arguments]   ${convo_name}
    Go to conversation builder
    ${is_exist} =  Run keyword and return status   Search Conversation in Conversation Builder   ${convo_name}
    IF  not ${is_exist}
        Click add conversation
        Input into    ${CONVERSATION_NAME_TEXTBOX}    ${convo_name}
        Click at    ${CONVERSATION_TEMPLATE}
        Click by JS     ${COMMON_SPAN_TEXT}    ${SINGLE_PATH_TEMPLETE}
        Check element display on screen    ${QUESTION_BOX}
        #   Turn on Email and off Phone number
        Turn on   ${SINGLE_PATH_QUESTION_TOGGLE}  Email
        Turn off   ${SINGLE_PATH_QUESTION_TOGGLE}  Phone Number
        # Turn off   ${SINGLE_PATH_QUESTION_TOGGLE}  Equal Employment Opportunity
        Public the conversation
    END

Add Single conversation with a certain name
    [Arguments]     ${conversation_name}
    Go to conversation builder
    ${is_existed}=     Run keyword and return status   Search Conversation in Conversation Builder     ${conversation_name}
    IF      '${is_existed}' == 'False'
        Click add conversation
        Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
        Click at    ${CONVERSATION_TEMPLATE}
        ${conversation_template} =    Format String    ${COMMON_SPAN_TEXT}    Single Path
        Click by JS    ${conversation_template}
        Check element display on screen    ${QUESTION_BOX}
        Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
        Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
        Public the conversation
    END
    Go to conversation builder
    Check the conversation is added successfully    ${conversation_name}
    [Return]    ${conversation_name}

Add Single conversation with email,phone and address
    [Arguments]   ${convo_name}
    Go to conversation builder
    Simulate Input    ${CONVERSATION_SEARCH_BOX}    ${convo_name}
    ${is_exist} =     Run keyword and return status   Check element display on screen    ${ROW_CONVERSATION_NAME}     ${convo_name}
    IF  not ${is_exist}
        Click add conversation
        Input into    ${CONVERSATION_NAME_TEXTBOX}    ${convo_name}
        Click at    ${CONVERSATION_TEMPLATE}
        Click by JS     ${COMMON_SPAN_TEXT}    ${SINGLE_PATH_TEMPLETE}
        Check element display on screen    ${QUESTION_BOX}
        #   Select Available location
        Click at   ${AVAILABLE_LOCATIONS_DROPDOWN}
        Click at   ${AVAILABLE_LOCATIONS_SELECT_LOCATION_OPTION}
        Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
        Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
        Input into   ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${LOCATION_CITY_SAN_JOSE}
        Check the checkbox   ${AVAILABLE_LOCATIONS_LOCATION_NAME_CHECKBOX}    ${LOCATION_CITY_SAN_JOSE}
        Click at   Available locations
        #   Turn on Email and off Phone number
        Turn on   ${SINGLE_PATH_QUESTION_TOGGLE}  Email
        Turn on   ${SINGLE_PATH_QUESTION_TOGGLE}  Phone Number
        Turn off   ${SINGLE_PATH_QUESTION_TOGGLE}  Equal Employment Opportunity
        Turn off   ${SINGLE_PATH_QUESTION_TOGGLE}  Communication Preference
        Public the conversation
    END
