*** Settings ***
Library         ../utils/CommonFunctions.py
Resource        ../pages/base_page.robot
Resource        ../pages/web_management_page.robot
Resource        ../pages/client_setup_page.robot
Resource        ../pages/conversation_page.robot
Variables       ../locators/cms_locators.py
Variables       ../locators/dynamic_content_locators.py

*** Keywords ***
Get Olivia Response Hashtag Text
    ${hashtag_list} =    Create List
    ${hashtag_elements} =    Get WebElements    ${OLIVIA_RESPONSE_HASHTAG_TEXT}
    FOR    ${element}    IN    @{hashtag_elements}
        Append To List    ${hashtag_list}    ${element.get_attribute('innerHTML')}
    END
    [Return]    ${hashtag_list}

Check All Location Attributes displayed in Olivia Response Hashtag
    [Arguments]    ${hashtag_list}    ${all_location_attributes_key_name}
    FOR    ${key_name}    IN    @{all_location_attributes_key_name}
        Check element existed in list    la-${key_name}    ${hashtag_list}
    END

Add an Audience with any Location
    Go to CMS page
    Click at    Audience Builder
    ${audience_name} =    Set Variable    auto_audience
    ${is_existed} =    Run Keyword And Return Status    Check Audience existed    ${audience_name}
    IF    '${is_existed}' == 'False'
        Click at    ${ADD_AUDIENCE_BUTTON}
        Click at label    Name your audience
        # Select rules
        Input into    ${AUDIENCE_NAME_TEXT_BOX}    ${audience_name}
        Click at    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    Assigned Location
        Click at    ${AUDIENCE_MATCHES_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    Is any of
        # Choose Input of rule
        Click at    ${AUDIENCE_ASSIGNED_LOCATION_INPUT_DROPDOWN}
        Check Element Display On Screen    ${AUDIENCE_ASSIGNED_LOCATION_CANCEL_BUTTON}
        Check Element Display On Screen    ${AUDIENCE_ASSIGNED_LOCATION_APPLY_BUTTON}
        Click at    ${AUDIENCE_ASSIGNED_LOCATION_CHECKBOX}
        Click at    ${AUDIENCE_ASSIGNED_LOCATION_APPLY_BUTTON}
        Click at    ${AUDIENCE_BUILDER_CREATE_BUTTON}
    END
    [Return]    ${audience_name}

Add an Audience with an optional targeting rule
    [Arguments]    ${targeting_rule}    ${match_rule}   ${candidate_journey_status}=None    ${group_name}=None
    ${audience_name} =  Generate Random Name    auto_
    ${is_existed} =      Run Keyword And Return Status    Check Audience existed    ${audience_name}
    IF  '${is_existed}' == 'False'
        Click At    ${ADD_AUDIENCE_BUTTON}
        Click At Label    Name your audience
        Input Into      ${AUDIENCE_NAME_TEXT_BOX}   ${audience_name}
        Click At    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
        Choose a targeting rule option    ${targeting_rule}     ${match_rule}   ${candidate_journey_status}     ${group_name}
        Click At    ${AUDIENCE_BUILDER_CREATE_BUTTON}
        Capture Page Screenshot
    END
    [Return]    ${audience_name}

Choose a targeting rule option
    [Arguments]    ${targeting_rule_option}     ${match_rule}   ${candidate_journey_status}=None    ${group_name}=None
    Click At    ${AUDIENCE_RULES_OPTION}    ${targeting_rule_option}
    IF  '${targeting_rule_option}' == 'Detected Location'
        Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Is
        Set Focus To Element    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}
        Input Into    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}    ${LOCATION_NAME_US}
        Click At    ${LOCATION_NAME_US}
        Capture Page Screenshot
    ELSE IF    '${targeting_rule_option}' == 'Group'
        Verify Display Text     ${AUDIENCE_INPUT_SELECT_DROPDOWN}  Select Group   dynamic_locator_value=Select Group
        Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Is
        ${select_group_label} =   Format String       ${AUDIENCE_INPUT_SELECT_DROPDOWN}     Select Group
        ${locator_select_group} =   Convert Text To Locator     ${select_group_label}
        Select Dropdown Item    ${locator_select_group}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=${group_name}
        Click At    ${AUDIENCE_SELECT_GROUP_APPLY_BUTTON}
    ELSE IF    '${targeting_rule_option}' == 'Conversation State'
        Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=${match_rule}
        Click At    ${AUDIENCE_INPUT_SELECT_DROPDOWN}    Select State
        Click At    ${AUDIENCE_RULES_OPTION}    Introduction
        Click At    ${AUDIENCE_SELECT_GROUP_APPLY_BUTTON}
    ELSE IF    '${targeting_rule_option}' == 'Status'
        Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=${match_rule}
        Click At    ${AUDIENCE_INPUT_SELECT_DROPDOWN}    Select Status
        ${is_clicked} =     Run Keyword And Return Status    Click At    ${AUDIENCE_BUILDER_SELECT_DROPDOWN_STATUS}    Candidate Journey
        IF  '${is_clicked}' == 'True'
            Click At    Default Candidate Journey
            Click At    ${AUDIENCE_BUILDER_SELECT_DROPDOWN_STATUS_ITEM}     ${candidate_journey_status}
            Click At    ${AUDIENCE_SELECT_GROUP_APPLY_BUTTON}
        END
    END

Add an Audience with page url
    [Arguments]    ${audience_name}    ${url}    ${team_name}    ${match_type}=Is
    Go to CMS page
    Click at    Audience Builder
    ${is_existed} =    Run Keyword And Return Status    Check Audience existed    ${audience_name}
    IF    '${is_existed}' == 'False'
        Click at    ${ADD_AUDIENCE_BUTTON}
        Click at label    Name your audience
        # Select rules
        Input into    ${AUDIENCE_NAME_TEXT_BOX}    ${audience_name}
        Click at    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    Page URL
        Click at    ${AUDIENCE_MATCHES_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    ${match_type}
        Input into    ${AUDIENCE_BUILDER_TEXT_INPUT}    ${url}
        Click at    ${AUDIENCE_BUILDER_TEAM_DROPDOWN}
        Click at    ${AUDIENCE_BUILDER_TEAM_DROPDOWN_ITEM}    ${team_name}
        Click at    ${AUDIENCE_BUILDER_CREATE_BUTTON}
    END

Edit the name of an audience builder
    [Arguments]    ${audience_name}
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}   ${audience_name}
    ${edit_option} =    Format String   ${AUDIENCE_BUILDER_ELIPSIS__EDIT_DEACTIVATE_OPTIONS}    ${audience_name}    Edit
    Click At    ${edit_option}
    ${edited_audience_name} =      Generate Random Name      auto_audience_
    Click At    ${AUDIENCE_NAME_TEXT_BOX_LABEL}
    Clear Element Text With Keys    ${AUDIENCE_NAME_TEXT_BOX}
    Input Into    ${AUDIENCE_NAME_TEXT_BOX}     ${edited_audience_name}
    Click At    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
    Click At    ${AUDIENCE_BUILDER_CREATE_BUTTON}
    [Return]    ${edited_audience_name}

Check Audience existed
    [Arguments]    ${audience_name}
    Input into    ${SEARCH_AUDIENCE_TEXT_BOX}    ${audience_name}
    Check element display on screen    ${AUDIENCE_NAME_IN_COLUMN}    ${audience_name}

Check audience's status is active
    [Arguments]    ${audience_name}
    Check Audience Existed    ${audience_name}
    Check Element Display On Screen    Active
    Capture Page Screenshot

Add Audience into Sample Question
    [Arguments]    ${audience_name}
    ${is_existed} =    Run keyword and Return Status    Check element display on screen    ${audience_name}
    IF    '${is_existed}' == 'False'
        Click at button    Add Audience
        Input into    ${ADD_AUDIENCE_POPUP_SEARCH_TEXT_BOX}    ${audience_name}
        Click at    ${ADD_AUDIENCE_POPUP_CHECKBOX}    ${audience_name}
        Click at    ${ADD_AUDIENCE_POPUP_APPLY_BUTTON}
    END
    [Return]    ${is_existed}

Check token list displayed
    [Arguments]    ${all_location_attributes_key_name}
    Click at    ${OLIVIA_RESPONSE_HASHTAG_ICON}
    ${hashtag_list} =    Get Olivia Response Hashtag Text
    Check hastag list displayed
    Check element existed in list    event-directions    ${hashtag_list}
    Check element existed in list    event-documentation    ${hashtag_list}
    Check element existed in list    event-dress    ${hashtag_list}
    Check element existed in list    event-duration    ${hashtag_list}
    Check element existed in list    event-parking    ${hashtag_list}
    Check element existed in list    event-positions    ${hashtag_list}
    Check element existed in list    job-title    ${hashtag_list}
    Check element existed in list    location-text    ${hashtag_list}
    Check element existed in list    location-name    ${hashtag_list}
    Check element existed in list    location-phone-number    ${hashtag_list}
    Click at    ${OLIVIA_RESPONSE_HASHTAG_ICON}
    Check All Location Attributes displayed in Olivia Response Hashtag    ${hashtag_list}
    ...    ${all_location_attributes_key_name}
    Capture page screenshot

Check hastag list displayed
    ${hashtag_list} =    Get Olivia Response Hashtag Text
    Check element existed in list    event-name    ${hashtag_list}
    Check element existed in list    event-date    ${hashtag_list}
    Check element existed in list    event-time    ${hashtag_list}
    Check element existed in list    event-location    ${hashtag_list}
    Check element existed in list    ai-name    ${hashtag_list}
    Check element existed in list    company-name    ${hashtag_list}
    Check element existed in list    company-rep    ${hashtag_list}
    Check element existed in list    company-url    ${hashtag_list}
    Check element existed in list    job-url    ${hashtag_list}
    # Check element existed in list    widget-    ${hashtag_list}

Delete added Audience
    Hover at    ${ADDED_AUDIENCE_NAME}    ${audience_sample_name}
    Click at    ${ADDED_AUDIENCE_DELETE_ICON}    ${audience_sample_name}
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot

Delete added audience name
    [Arguments]    ${audience_name}
    Hover At    ${AUDIENCE_NAME_IN_COLUMN}      ${audience_name}
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}    ${audience_name}       wait_time=5s
    Click At    ${AUDIENCE_BUILDER_ELIPSIS_DELETE}   ${audience_name}
    Capture Page Screenshot

Deactivate an audience name
    [Arguments]    ${audience_name}
    ${deactivate_option} =  Format String   ${AUDIENCE_BUILDER_ELIPSIS_EDIT_DEACTIVATE_OPTIONS}    ${audience_name}    Deactivate
    Hover At    ${AUDIENCE_NAME_IN_COLUMN}      ${audience_name}
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}    ${audience_name}       wait_time=5s
    Click At    ${deactivate_option}
    Check Element Display On Screen    Your change has been saved.
    Clear Element Text With Keys    ${SEARCH_AUDIENCE_TEXT_BOX}
    Input Into    ${SEARCH_AUDIENCE_TEXT_BOX}    ${audience_name}
    ${audience_status} =    Format String   ${AUDIENCE_NAME_WITH_ITS_STATUS}    ${audience_name}    Inactive
    Check Element Display On Screen    ${audience_status}
    Capture Page Screenshot

Select a token
    [Arguments]    ${token_name}
    Click at    ${OLIVIA_RESPONSE_TEXT_BOX}
    Set HTML tag content    ${OLIVIA_RESPONSE_TEXT_BOX}    ${EMPTY}
    Click at    ${OLIVIA_RESPONSE_HASHTAG_ICON}
    Click at    ${OLIVIA_RESPONSE_HASHTAG_TEXT_VALUE}    ${token_name}
    ${random_text} =    Generate random name    auto
    Press Keys    None    ${random_text}+ESC

Add a Single Path conversation with Location
    ${conversation_name} =    Add Single conversation    Single Path
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Click at    ${AVAILABLE_LOCATIONS_DROPDOWN}
    Click at    ${AVAILABLE_LOCATIONS_SELECT_LOCATION_OPTION}
    Input into    ${AVAILABLE_LOCATIONS_FIND_LOCATION_TEXT_BOX}    ${test_location_name}
    Click at    ${AVAILABLE_LOCATIONS_SELECT_ALL_CHECK_BOX}
    Public the conversation
    [Return]    ${conversation_name}

Run the Widget Conversation with CMS and Conversation with Location
    [Arguments]    ${kb_type}
    ${conversation_name} =    Add a Single Path conversation with Location
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Assign Conversation and Care to Widget    ${conversation_name}    ${site_name}    ${kb_type}
    [Return]    ${site_name}

Public Assistant Responses Question
    [Arguments]    ${question_type}
    Go to CMS page
    IF    '${question_type}' == 'Candidate'
        Click at    Candidate Assistant Responses
    ELSE IF    '${question_type}' == 'Employee'
        Click at    Employee Assistant Responses
    END
    ${is_published} =    Run keyword and Return Status    Check element display on screen    ${CMS_UNPUBLISHED_BUTTON}
    IF    '${is_published}' == 'True'
        Click at    ${CMS_PUBLISH_STATUS_BUTTON}
        Click at    ${CMS_PUBLISH_BUTTON}
    END

Change Care question to Live
    [Arguments]    ${question}    ${question_type}
    Go to CMS page
    IF    '${question_type}' == 'Candidate'
        Click at    Candidate Assistant Responses
        Click at    ${NAV_SUB_MENU_TEXT}    Candidate Care
    ELSE IF    '${question_type}' == 'Employee'
        Click at    Employee Assistant Responses
        Click at    ${NAV_SUB_MENU_TEXT}    Employee Care
    END
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Benefits
    Hover at    ${CMS_QUESTION_ECLIPSE_ICON}    ${question}
    Click at    ${CMS_QUESTION_ECLIPSE_ICON}    ${question}
    ${is_not_live} =    Run Keyword and Return Status    Check element display on screen
    ...    ${CMS_QUESTION_CHANGE_TO_LIVE_OPTION}    ${question}
    IF    ${is_not_live}
        Click at    ${CMS_QUESTION_CHANGE_TO_LIVE_OPTION}    ${question}
    END

Check the search results match the search keyword
    [Arguments]    ${search_keyword}
    ${key_words} =    Split String    ${search_keyword}    ${SPACE}
    FOR    ${key_word}    IN    @{key_words}
        Verify attribute should contain    innerHTML    ${key_word}    ${EMPLOYEE_CARE_SEARCH_QUESTION_RESULT}    ${key_word}
    END

Run the Widget Conversation with CMS and Conversation without Location
    [Arguments]    ${kb_type}
    ${conversation_name} =    Add Single conversation    Single Path
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Assign Conversation and Care to Widget    ${conversation_name}    ${site_name}    ${kb_type}
    [Return]    ${site_name}

Add an Audience with IP in Vietnam
    Go to CMS page
    Click at    Audience Builder
    ${audience_name} =    Set Variable    auto_audience
    ${is_existed} =    Run Keyword And Return Status    Check Audience existed    ${audience_name}
    IF    '${is_existed}' == 'False'
        Click at    ${ADD_AUDIENCE_BUTTON}
        Click at label    Name your audience
        # Select rules
        Input into    ${AUDIENCE_NAME_TEXT_BOX}    ${audience_name}
        Click at    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    Detected Location
        Click at    ${AUDIENCE_MATCHES_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    Is
        # Choose Input of rule
        Input into    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}    Vietnam
        Click at    Vietnam
        Click at    ${AUDIENCE_BUILDER_CREATE_BUTTON}
    END
    [Return]    ${audience_name}

Go to Candidate Assistant Responses
    Click at    Candidate Assistant Responses
    Click at    ${NAV_SUB_MENU_TEXT}    Candidate Care      slow_down=1s

Go to Employee Assistant Responses
    Click at    Employee Assistant Responses
    Click at    ${NAV_SUB_MENU_TEXT}    Employee Care       slow_down=1s

Delete all medias in media library
    check the checkbox      ${MEDIA_LIBRARY_CHECK_ALL_CHECK_BOX}
    click at    ${MEDIA_LIBRARY_DELETE_BUTTON}
    click at    ${MEDIA_LIBRARY_CONFIRM_DELETE_BUTTON}
    capture page screenshot

Go to Dynamic Content page
    Go to CMS page
    Click at    ${CANDIDATE_ASSISTANT_RESPONSES_DYNAMIC_CONTENT}
    wait for page load successfully v1

Delete media in media library
    [Arguments]     ${media_name_list}
    Go to Media library page
    #   Arg could be a name in string type, or a list of media name if you want to delete many medias at same time
    ${type} =   evaluate    type($media_name_list).__name__
    IF  '${type}' == 'list'
        FOR     ${media}  IN  @{media_name_list}
            Input into    ${SEARCH_MEDIA_SEARCH_BOX}    ${media}
            wait for page load successfully v1
            check the checkbox      ${MEDIA_LIBRARY_ITEM_CHECK_BOX}     ${media}
        END
    ELSE IF     '${type}' == 'str'
        Input into    ${SEARCH_MEDIA_SEARCH_BOX}    ${media_name_list}
        wait for page load successfully v1
        check the checkbox      ${MEDIA_LIBRARY_ITEM_CHECK_BOX}     ${media_name_list}
    END
    click at    ${MEDIA_LIBRARY_DELETE_BUTTON}
    click at    ${MEDIA_LIBRARY_CONFIRM_DELETE_BUTTON}
    capture page screenshot

Go to Media library page
    go to cms page
    Click at   ${NAV_SUB_MENU_TEXT}   Media Library
    wait for page load successfully v1

Check CMS toggle is ON on Client setup page
    Go To Client Setup Page
    Navigate To Option In Client Setup    Care
    Check Element Display On Screen     ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE_IS_ON}   wait_time=5s
    Capture Page Screenshot

Check Create Audience page
    [Arguments]    ${list_rule}=None
    Check Element Display On Screen    ${ADD_AUDIENCE_BUTTON}
    Click At    ${ADD_AUDIENCE_BUTTON}
    Check Element Display On Screen     ${AUDIENCE_NAME_TEXT_BOX_LABEL}
    Element Should Be Disabled      ${AUDIENCE_BUILDER_CREATE_BUTTON}
    IF  ${list_rule} != None
        Click At    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
        FOR     ${rule_option}     IN      @{list_rule}
            Check Element Display On Screen     ${AUDIENCE_RULES_OPTION}        ${rule_option}
        END
        Capture Page Screenshot
        Click At    ${AUDIENCE_MATCHES_RULES_DROPDOWN}
        Check Element Display On Screen    Is
        Check Element Display On Screen    Is not
        Capture Page Screenshot
    END

#   ====SECTION: JOB SEARCH RESULTS BUILDER====

Go to job search results builder page
    go to cms page
    Click at   ${NAV_SUB_MENU_TEXT}   Job Search Results Builder
    wait for page load successfully v1

Add field in Job Search Results
    [Arguments]     ${field_name}   ${section_name}=List View
    #   Go to Sub-section if needed
    ${is_active} =   Run keyword and return status  Check element display on screen  ${JOB_SEARCH_RESULTS_ACTIVE_SUB_SECTION}   ${section_name}  wait_time=1s
    Run keyword if  '${is_active}' == 'False'   CLick at    ${NAV_SUB_MENU_TEXT}    ${section_name}
    #   ${field_name} could be a name in string type, or a list
    ${type} =   evaluate    type($field_name).__name__
    IF  '${type}' == 'list'
        FOR     ${field}  IN  @{field_name}
            #   Check if ${field} is already exist, ignore steps
            ${is_exist} =   Run keyword and return status  Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}   ${field_name}    wait_time=1s
            IF  '${is_exist}' == 'False'
                Click at    ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
                Click at    ${JOB_SEARCH_RESULTS_FIELD_ITEM}    ${field}
                Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}   ${field}
                Click at    ${JOB_SEARCH_RESULTS_SAVE_BUTTON}
                Wait for toast message disappeard
            END
        END
    ELSE IF     '${type}' == 'str'
        #   Check if ${field_name} is already exist, ignore steps
        ${is_exist} =   Run keyword and return status  Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}   ${field_name}    wait_time=1s
        IF  '${is_exist}' == 'False'
            Click at    ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
            Click at    ${JOB_SEARCH_RESULTS_FIELD_ITEM}    ${field_name}
            Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}   ${field_name}
            Click at    ${JOB_SEARCH_RESULTS_SAVE_BUTTON}
            Wait for toast message disappeard
        END
    END
    Capture page screenshot

Open 'Condition Criteria' dialog
    CLick at  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    CLick at  ${JOB_SEARCH_RESULTS_ADD_CONDITION_BUTTON}

Remove field(s)
    [Arguments]  ${field_name}
    #   ${field_name} could be a name in string type, or a list
    ${type} =   evaluate    type($field_name).__name__
    IF  '${type}' == 'list'
        FOR     ${field}  IN  @{field_name}
            Run keyword and ignore error   Click at   ${JOB_SEARCH_RESULTS_TRASH_ICON}    ${field}    wait_time=2s
        END
    ELSE IF     '${type}' == 'str'
        Run keyword and ignore error  Click at   ${JOB_SEARCH_RESULTS_TRASH_ICON}    ${field_name}    wait_time=2s
    END
    ${is_enabled} =  Run keyword and return status   Click at   ${JOB_SEARCH_RESULTS_SAVE_BUTTON}  wait_time=2s
    IF    '${is_enabled}' == 'True'
        Wait for toast message disappeard
    END

Select condition on job search results
    [Arguments]   ${condition_title}
    Click at   ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Input into   ${JOB_SEARCH_RESULTS_CONDITION_SEARCH_BOX}   ${condition_title}
    Click at   ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}    ${condition_title}
    Verify text contain  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}  ${condition_title}

Add new condition then select it
    [Arguments]   ${condition_title}=None    ${target_rules}=Job Title   ${matches}=Contains   ${input}=Auto
    IF   '${condition_title}' == 'None'
        ${condition_title} =    Generate random name    auto_condition
    END
    CLick at  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Input into   ${JOB_SEARCH_RESULTS_CONDITION_SEARCH_BOX}   ${condition_title}
    ${is_exist} =  Run keyword and return status   Check element display on screen  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}  ${condition_title}   wait_time=5s
    IF  ${is_exist}
        Click at    ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
        FOR   ${index}    IN RANGE   10
            Click at    ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
            ${is_clear} =  Run keyword and return status   Check element not display on screen  ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
            Exit For Loop If   ${is_clear}
        END
        Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
        Wait for toast message disappeard
        CLick at  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    END
    Click at   ${JOB_SEARCH_RESULTS_ADD_CONDITION_BUTTON}
    Click at   ${CONDITION_CRITERIA_NAME_TEXTBOX}
    Simulate Input  None  ${condition_title}
    Select dropdown item  ${CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN}  ${CONDITION_CRITERIA_DROPDOWN_ITEM}  dynamic_locator_item=${target_rules}
    Select dropdown item  ${CONDITION_CRITERIA_MATCHES_DROPDOWN}  ${CONDITION_CRITERIA_DROPDOWN_ITEM}  dynamic_locator_item=${matches}
    Input into   ${CONDITION_CRITERIA_INPUT_TEXTBOX}    ${input}
    Click at    ${CONDITION_CRITERIA_SAVE_BUTTON}
    Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
    Wait for toast message disappeard
    Select condition on job search results  ${condition_title}
    [Return]   ${condition_title}

Delete condition(s)
    [Arguments]  ${condition_titles}
    Click at    ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
    #   ${field_name} could be a name in string type, or a list
    ${type} =   evaluate    type($condition_titles).__name__
    IF  '${type}' == 'list'
        FOR     ${condition_title}  IN  @{condition_titles}
            Click at    ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
            Check element not display on screen  ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
        END
    ELSE IF     '${type}' == 'str'
        Click at    ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_titles}
    END
    Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
    Wait for toast message disappeard

Wait for toast message disappeard
    wait for page load successfully v1
    Run keyword and ignore error  Element should be visible   ${JOB_SEARCH_RESULTS_TOAST_MESSAGE}
    Element should not be visible   ${JOB_SEARCH_RESULTS_TOAST_MESSAGE}

Add new multiple condition statements
    [Arguments]   ${condition_title}=None    ${target_rules}=Job Title   ${matches}=Contains   ${input}=Auto
    IF   '${condition_title}' == 'None'
        ${condition_title} =    Generate random name    auto_condition
    END
    CLick at  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Input into   ${JOB_SEARCH_RESULTS_CONDITION_SEARCH_BOX}   ${condition_title}
    ${is_exist} =  Run keyword and return status   Check element display on screen  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}  ${condition_title}   wait_time=5s
    IF  ${is_exist}
        Click at    ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
        Click at    ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
        Check element not display on screen  ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
        Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
        Wait for toast message disappeard
        CLick at  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    END
    Click at   ${JOB_SEARCH_RESULTS_ADD_CONDITION_BUTTON}
    Click at   ${CONDITION_CRITERIA_NAME_TEXTBOX}
    Simulate Input  None  ${condition_title}
    Select dropdown item  ${CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN}  ${CONDITION_CRITERIA_DROPDOWN_ITEM}  dynamic_locator_item=${target_rules}
    Select dropdown item  ${CONDITION_CRITERIA_MATCHES_DROPDOWN}  ${CONDITION_CRITERIA_DROPDOWN_ITEM}  dynamic_locator_item=${matches}
    Input into   ${CONDITION_CRITERIA_INPUT_TEXTBOX}    ${input}
    Click at    ${JOB_SEARCH_RESULTS_OR_CONDITION_BUTTON}
    Add new condition statement
    Click at    ${CONDITION_CRITERIA_SAVE_BUTTON}
    Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
    Wait for toast message disappeard
    Select condition on job search results  ${condition_title}
    [Return]   ${condition_title}

Add new condition statement
    [Arguments]   ${target_rules}=Job City   ${matches}=Exactly matches   ${input}=Auto
    Select dropdown item  ${CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN_OPTION}  ${CONDITION_CRITERIA_DROPDOWN_ITEM_OPTION}  dynamic_locator_item=${target_rules}
    Select dropdown item  ${CONDITION_CRITERIA_MATCHES_DROPDOWN_OPTION }  ${CONDITION_CRITERIA_DROPDOWN_ITEM_OPTION}  dynamic_locator_item=${matches}
    Input into   ${CONDITION_CRITERIA_INPUT_TEXTBOX_OPTION}    ${input}

Edit field in Job Search Results
    [Arguments]     ${field_name1}  ${field_name2}
    Click at    ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}   ${field_name1}
    Click at    ${JOB_SEARCH_RESULTS_FIELD_ITEM}    ${field_name2}
    Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}   ${field_name2}
    Click at    ${JOB_SEARCH_RESULTS_SAVE_BUTTON}
    Wait for toast message disappeard
    Capture page screenshot

Edit condition and select it
    [Arguments]   ${old_condition_title}    ${condition_title}=None    ${target_rules}=Job City   ${matches}=Exactly matches   ${input}=Auto
    Click at    ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
    wait for page load successfully v1
    click at    ${CONDITION_CRITERIA_CONDITION_ITEM_TITLE}      ${old_condition_title}
    Clear Element Text With Keys    ${CONDITION_CRITERIA_NAME_TEXTBOX_VALUE}    ${old_condition_title}
    IF   '${condition_title}' == 'None'
        ${condition_title} =    Generate random name    auto_condition
    END
    Simulate Input  None  ${condition_title}
    Select dropdown item  ${CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN}  ${CONDITION_CRITERIA_DROPDOWN_ITEM}  dynamic_locator_item=${target_rules}
    Select dropdown item  ${CONDITION_CRITERIA_MATCHES_DROPDOWN}  ${CONDITION_CRITERIA_DROPDOWN_ITEM}  dynamic_locator_item=${matches}
    Input into   ${CONDITION_CRITERIA_INPUT_TEXTBOX}    ${input}
    Click at    ${CONDITION_CRITERIA_SAVE_BUTTON}
    Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
    Wait for toast message disappeard
    Select condition on job search results  ${condition_title}
    [Return]   ${condition_title}

#   ====END SECTION: JOB SERACH RESULTS BUILDER====

#   ====SECTION: AUDIENCE BUILDER====

Add an Audience with targeting type
    [Arguments]     ${target_rule}      ${matches_rule}      ${input}    ${audience_name}=None
    IF      '${audience_name}' == 'None'
        ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${audience_name}=    Set variable    auto_collection_${random}
    END
    Go to CMS page
    Click at    Audience Builder
    wait for page load successfully v1
    ${is_existed} =    Run Keyword And Return Status    Check Audience existed    ${audience_name}
    IF    '${is_existed}' == 'False'
        Click at    ${ADD_AUDIENCE_BUTTON}
        Click at label    Name your audience
        Input into    ${AUDIENCE_NAME_TEXT_BOX}    ${audience_name}
        # Select rules
        Click at    ${AUDIENCE_TARGETING_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    ${target_rule}
        Click at    ${AUDIENCE_MATCHES_RULES_DROPDOWN}
        Click at    ${AUDIENCE_RULES_OPTION}    ${matches_rule}
        IF      '${target_rule}'=='Assigned Location'
            Click at    ${AUDIENCE_ASSIGNED_LOCATION_INPUT_DROPDOWN}
            Check Element Display On Screen    ${AUDIENCE_ASSIGNED_LOCATION_CANCEL_BUTTON}
            Check Element Display On Screen    ${AUDIENCE_ASSIGNED_LOCATION_APPLY_BUTTON}
            Click at    ${AUDIENCE_ASSIGNED_LOCATION_SEARCH_BOX}
            input into      ${AUDIENCE_ASSIGNED_LOCATION_SEARCH_BOX}    ${input}
            Click at    ${AUDIENCE_ASSIGNED_LOCATION_ITEM}      2
            Click at    ${AUDIENCE_ASSIGNED_LOCATION_APPLY_BUTTON}
        ELSE IF     '${target_rule}'=='Detected Location'
            Click at    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}
            input into     ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}       ${input}
            Click at    ${AUDIENCE_COUNTRY_SELECTION_DROPDOWN_ITEM}
            wait for page load successfully v1
        ELSE IF        '${target_rule}'=='Group'
            Click at    ${AUDIENCE_RULES_GROUP_SELECT_DROPDOWN}
            Click at    ${AUDIENCE_RULES_GROUP_SEARCH_BOX}
            Input into  ${AUDIENCE_RULES_GROUP_SEARCH_BOX}      ${input}
            Click at    ${AUDIENCE_RULES_GROUP_SEARCH_RESULT}   ${input}
            Check Element Display On Screen    ${AUDIENCE_SELECT_STATE_CANCEL_BUTTON}
            Check Element Display On Screen    ${AUDIENCE_SELECT_STATE_APPLY_BUTTON}
            Click at    ${AUDIENCE_SELECT_STATE_APPLY_BUTTON}
        ELSE IF     '${target_rule}'=='Conversation State'
            Click at    ${AUDIENCE_SELECT_STATE_INPUT_DROPDOWN}
            Click at    ${AUDIENCE_SELECT_STATE_INPUT_ITEM}     ${input}
            Check Element Display On Screen    ${AUDIENCE_SELECT_STATE_CANCEL_BUTTON}
            Check Element Display On Screen    ${AUDIENCE_SELECT_STATE_APPLY_BUTTON}
            Click at    ${AUDIENCE_SELECT_STATE_APPLY_BUTTON}
        ELSE
            Click at    ${AUDIENCE_BUILDER_TEXT_INPUT}
            input into  ${AUDIENCE_BUILDER_TEXT_INPUT}     ${input}
        END
        Click at    ${AUDIENCE_BUILDER_CREATE_BUTTON}
    END
    [Return]    ${audience_name}

Delete an Audience
    [Arguments]     ${audience_name}
    Go to CMS page
    Click on span text      Audience Builder
    wait for page load successfully v1
    input into      ${SEARCH_AUDIENCE_TEXT_BOX}     ${audience_name}
    Check element display on screen     ${AUDIENCE_NAME_IN_COLUMN}      ${audience_name}
    Click at    ${AUDIENCE_BUILDER_SUB_MENU_ICON}
    wait until element is visible         ${AUDIENCE_BUILDER_DELETE_BUTTON}
    Click at    ${AUDIENCE_BUILDER_DELETE_BUTTON}
    wait for page load successfully v1
    Check element not display on screen     ${AUDIENCE_NAME_IN_COLUMN}      ${audience_name}

#   ====END SECTION: AUDIENCE BUILDER====

#    ====SECTION: AI Assistants > Candidate Assistants ====
#   ====SECTION: Candidate Assistant Responses -> Candidate Care ====

Search Care Question and go into
    [Arguments]    ${question}    ${type_response}=Candidate    ${tab}=Candidate Care
    Go to CMS page
    Click at    ${type_response} Assistant Responses
    Click at    ${tab}
    Input into    ${CMS_SEARCH_INPUT}    ${question}
    Click at    ${CMS_SAMPLE_QUESION}    ${question}
    sleep     3s

Enter Response message
    [Arguments]    ${audience_name}    ${message}
    Click at    ${COMMON_SPAN_TEXT}    ${audience_name}
    Clear element text with keys    ${OLIVIA_RESPONSE_TEXT_BOX}
    Input into    ${OLIVIA_RESPONSE_TEXT_BOX}    ${message}

#   ====END SECTION: Candidate Assistant Responses -> Candidate Care ====

#   ====SECTION: Employee Assistant Responses -> Employee Care ====

Verify tab has show the sample question and corresponding answer
    [Arguments]             ${tab_name}    ${answer}    ${sample_question}
    Click at                ${OLIVIA_ANSWER_TOP_TAB}                        ${tab_name}
    Check span display      ${sample_question}
    Verify display text     ${OLIVIA_RESPONSE_TEXT_BOX}                     ${answer}

Go to Employee Assistant Responses then click on question
    [Arguments]             ${question}
    Go to CMS page
    Go to Employee Assistant Responses
    Click at                ${CANDIDATE_CARE_GROUP_TITLE}                   Benefit
    Click at                ${BENEFITS_SAMPLE_QUESTION_TEXT}                ${question}             1s

Input Emoji icon into Response message
    Set focus to element    ${OLIVIA_RESPONSE_TEXT_BOX}
    Click By JS             ${OLIVIA_RESPONSE_EMOJI_ICON_BUTTON}
    Check Element Display On Screen                 ${OLIVIA_RESPONSE_EMOJI_ICON_CONTAIN_BOX}
    Click at                ${OLIVIA_RESPONSE_EMOJI_ICON_VALUE}             Grinning
    Click at                ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}         Save
    Check Text Display      Your changes were saved
    Capture page screenshot

Create second message box then input message into it
    [Arguments]             ${message}
    Click at                ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Check Element Display On Screen                 ${OLIVIA_RESPONSE_INDEX_MESSAGE_ACTIVE}         2
    Input Into              ${OLIVIA_RESPONSE_TEXT_BOX}                     ${message}
    Click at                ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}         Save
    Check Text Display      Your changes were saved
    Capture page screenshot

Add a bubble message
    [Arguments]             ${message}
    Check Element Display On Screen                 ${OLIVIA_RESPONSE_ADD_MESSAGE_BUTTON}
    Click at                ${OLIVIA_RESPONSE_ADD_MESSAGE_BUTTON}
    Input Into              ${OLIVIA_RESPONSE_SECOND_TEXT_BOX}              ${message}
    Click at                ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}         Save
    Check Text Display      Your changes were saved
    Capture page screenshot

Mark bold a message
    [Arguments]             ${message}
    Set focus to element    ${OLIVIA_RESPONSE_TEXT_BOX}
    Press Keys              None                    CTRL+a
    Click At                ${OLIVIA_RESPONSE_BOLD_BUTTON}
    Check Element Display On Screen                 ${OLIVIA_RESPONSE_BOLD_TEXT}                    ${message}
    Click at                ${OLIVIA_ANSWER_TOP_TAB}                        Web
    Click at                ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}         Save
    Check Text Display      Your changes were saved
    Capture page screenshot

Clear message then input new message
    [Arguments]             ${text_box}    ${message}
    Clear element text with keys                    ${OLIVIA_RESPONSE_TEXT_BOX}
    Input into              ${OLIVIA_RESPONSE_TEXT_BOX}                     ${text_box}
    Click at                ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}         Save
    Check Text Display      Your changes were saved

Add New Media into Content Collection
    [Arguments]    ${media_type}    ${link_url}    ${name_content}=None
    IF  "${name_content}" == "None"
        ${name_content} =       Set variable            ${file_mapping_object}[${media_type}]
    END
    Click at                ${COLLECTION_ADD_MEDIA_MODAL_ADD_NEW_BUTTON}
    Check Element Display On Screen                     ${COLLECTION_ADD_NEW_MEDIA_MODAL}
    Click at                ${COLLECTION_ADD_NEW_MEDIA_TYPE}                ${media_type}
    input into              ${COLLECTION_ADD_NEW_MEDIA_MODAL_NAME_CONTENT_TEXTBOX}                  ${name_content}
    IF  "${media_type}" == "Hyperlinks"
        input into              ${COLLECTION_ADD_NEW_MEDIA_MODAL_HYPERLINKS_URL}                        ${link_url}
    ELSE
        input into              ${COLLECTION_ADD_NEW_MEDIA_MODAL_URL}           ${link_url}
        Click at                ${COLLECTION_ADD_NEW_MEDIA_MODAL_CREATE_BUTTON}
    END
    IF  "${media_type}" == "Image/GIF"
        Click at                ${COLLECTION_ADD_NEW_MEDIA_CROP_COMFIRM_BUTTON}
    END
    wait for page load successfully v1
    Click at                ${COLLECTION_ADD_NEW_MEDIA_MODAL_CREATE_BUTTON}
    Check Element Not Display On Screen             ${COLLECTION_ADD_NEW_MEDIA_MODAL_TITLE}

Select an media item then add it into Content Collection
    [Arguments]    ${media_type}    ${media_url}    ${name_content}
    Input Into              ${COLLECTION_ADD_MEDIA_MODAL_SEARCH_BOX}        ${name_content}
    Wait With Short Time
    ${list_media_count}=    Get Element Count       ${COLLECTION_ADD_MEDIA_MODAL_LIST_MEDIA}
    IF  ${list_media_count} != 0
        Click at                ${COLLECTION_ADD_MEDIA_MODAL_LIST_MEDIA}
        Click at                ${COLLECTION_ADD_MEDIA_MODAL_ADD_BUTTON}
        Check Element Not Display On Screen             ${COLLECTION_ADD_MEDIA_MODAL}
    ELSE
        IF      "${media_type}" == "Video"
            Add New Media into Content Collection           ${media_type}           ${name_content}         ${media_url}
        ELSE IF      "${media_type}" == "Image/GIF"
            Add New Media into Content Collection           ${media_type}           ${name_content}         ${media_url}
        ELSE
            Add New Media into Content Collection           ${media_type}           ${name_content}         ${media_url}
        END
        Check Element Not Display On Screen             ${COLLECTION_ADD_MEDIA_MODAL}
    END

Add a sample question
    [Arguments]    ${question}
    Click at    ${EMPLOYEE_CARE_GEAR_SETTING_ICON}
    Click at    ${EMPLOYEE_CARE_GEAR_SETTING_DROPDOWN_ITEM}     Add Custom Topics
    Input Into      ${EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_TEXT_BOX}     Camp    Enter Group
    Input Into      ${EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_TEXT_BOX}     Camp    Enter Category
    Input Into      ${EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_TEXT_BOX}     Benefits    Enter Topic
    Input Into      ${EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_TEXT_BOX}     ${question}     Enter Sample Question
    Click At    ${EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_BUTTON}       Create
    Check Text Display      Topic was successfully created
    Capture page screenshot

Create a answer for the custom question
    [Arguments]    ${question}
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}       Custom
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    ${question}     1s
    ${random_message} =     Generate Random Text Only
    Input Into      ${OLIVIA_RESPONSE_TEXT_BOX}     ${random_message}
    Click At    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}

Delete a sample question
    [Arguments]    ${question}
    Hover at    ${CMS_QUESTION_ECLIPSE_ICON}    ${question}
    Click at    ${CMS_QUESTION_ECLIPSE_ICON}    ${question}
    Click at    ${CMS_QUESTION_DELETE_OPTION}       ${question}
    Check Text Display      Successfully deleted

#   ====END SECTION: Employee Assistant Responses -> Employee Care ====

#   ====SECTION: AI Assistants > Candidate Assistants ====

Go to AI Assistants
    [Arguments]    ${tab}=Candidate Assistants
    Go to CMS page
    Click at    AI Assistants
    Click at    ${NAV_SUB_MENU_TEXT}    ${tab}

Create new Assistant
    [Arguments]    ${assitant_name}=None    ${assistant_type}=Candidate
    Go to AI Assistants    ${assistant_type} Assistants
    Click at    ${COMMON_SPAN_TEXT}    My Assistants
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${MY_ASSISTANTS_ITEM_TILE}    ${assitant_name}
    IF    '${is_existed}' == 'False'
        Click at    ${MY_ASSISTANTS_ADD_NEW_ASSISTANT_BUTTON}
        ${assitant_name}=    Enter all require fields    ${assitant_name}
        Click at    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_SAVE_BUTTON}
    END
    Capture Page Screenshot
    [Return]    ${assitant_name}

Enter all require fields
    [Arguments]    ${assitant_name}=None    ${country}=Viet Nam    ${country_id}=VN
    IF   '${assitant_name}' == 'None'
        ${assitant_name}=    Generate random name    auto_assistant
    END
    Upload Assistant Photo
    Input Text    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_NAME_INPUT}    ${assitant_name}
    Input Text    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_COUNTRY_INPUT}    ${country}
    Click at    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_COUNTRY_ITEM}    ${country_id}
    [Return]    ${assitant_name}

Open Eclipse menu of Assistant
    [Arguments]    ${name}
    Hover at   ${MY_ASSISTANTS_ITEM_TILE}    ${name}
    Click at    ${MY_ASSISTANTS_ITEM_MENU_ICON}    ${name}

Delete Assistant
    [Arguments]    ${name}
    Open Eclipse menu of Assistant    ${name}
    Click at    ${MY_ASSISTANTS_MENU_MODAL_DELETE_BUTTON}    ${name}
    Click at    ${MY_ASSISTANTS_MENU_MODAL_REMOVE_CONFIRM_BUTTON}    ${name}

Upload Assistant Photo
    ${path_image} =    get_path_upload_image_path    cat-kute
    ${element} =    Get Webelement    ${MY_ASSISTANTS_NEW_ASSISTANT_AVATAR_INPUT}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
    ...    ARGUMENTS    ${element}
    Input into    ${MY_ASSISTANTS_NEW_ASSISTANT_AVATAR_INPUT}    ${path_image}
    Click at    ${MY_ASSISTANTS_NEW_ASSISTANT_AVATAR_COMFIRM_BUTTON}
    Wait Until Element Is Not Visible    ${MY_ASSISTANTS_NEW_ASSISTANT_EMPTY_AVATAR}

Go to assistant team
    [Arguments]    ${assistant_type}=Candidate
    Go to CMS page
    Click at    AI Assistants
    Click at    ${NAV_SUB_MENU_TEXT}    ${assistant_type} Assistants
    Click at    Assistant Teams

Create Assistant Team
    [Arguments]    ${team_name}=None    ${assistant_type}=Candidate
    Go to assistant team    ${assistant_type}
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${ASSISTANT_TEAMS_NAME}    ${team_name}
    IF    '${is_existed}' == 'False'
        Click at    ${ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_BUTTON}
        IF   '${team_name}' == 'None'
            ${team_name}=    Generate random name    auto_assistant_team
        END
        Input Text    ${ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_MODAL_TEAM_NAME_INPUT}    ${team_name}
        Click at    ${ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_MODAL_CREATE_BUTTON}
    END
    Capture Page Screenshot
    [Return]    ${team_name}

Add assistant to team
    [Arguments]    ${team}    ${candidate_assistant_name}    ${assistant_type}=Candidate    ${country}=Viet Nam    ${country_id}=VN
    Go to assistant team    ${assistant_type}
    Click at    ${ASSISTANT_TEAMS_NAME}    ${team}
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${ASSISTANT_TEAMS_ITEM_TITLE}    ${candidate_assistant_name}
    IF    '${is_existed}' == 'False'
        Click at    ${ASSISTANT_TEAMS_NEW_ASSISTANT_BUTTON}
        Enter all require fields    ${candidate_assistant_name}    country=${country}    country_id=${country_id}
        Click at    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_SAVE_BUTTON}
    END
    Capture Page Screenshot

Go to landing page with name and Check assistant name and image
    [Arguments]    ${site_name}    ${assistant_name}    ${company_name}=COMPANY_EVENT
    ${url}=    Get landing site url for detect assistant    ${company_name}    ${site_name}
    Go To    ${url}
    Wait for Olivia reply
    Check span display    ${assistant_name}
    Verify attribute value equal    ${CONVERSATION_HEADER_IMAGE}    alt    ${assistant_name}
    Capture Page Screenshot

Get landing site url for detect assistant
    [Arguments]    ${company_name}    ${suffix_name}
    ${suffix_name}=    Convert To Title Case    ${suffix_name}
    ${suffix_name}=    Replace String    ${suffix_name}    ${SPACE}    ${EMPTY}
    ${prefix_url}=    Get Company Site Link    ${company_name}
    [Return]    ${prefix_url}${suffix_name}
