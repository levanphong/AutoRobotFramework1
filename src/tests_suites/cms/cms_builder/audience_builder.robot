*** Settings ***
Resource    ../../../drivers/driver_chrome.robot
Resource    ../../../pages/cms_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags    test

*** Variables ***
@{list_of_coversation_states}    Introduction     Email   Phone Number    Location Discovery  Schedule
    ...     Schedule Pending    Schedule Confirmed  Schedule Canceled   Schedule Complete
${audience_sample_name}   auto_audience
${group_name}             Audience_builder_group

*** Keywords ***
Setup to login into system and go to Audience builder page
    [Arguments]    ${company_role}      ${company_name}
    Given Setup Test
    When Login Into System With Company    ${company_role}     ${company_name}
    Check CMS toggle is ON on Client setup page
    Go To CMS Page
    Click At    Audience Builder
    Wait For Page Load Successfully V1

Verify the audience will be removed from Candidate Care if it has been deactivated or deleted from Audience builder page
    [Arguments]    ${audience_name}
    Go To Candidate Assistant Responses
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Benefits
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    Who is eligible for benefits?     1s
    Check Element Not Display On Screen    ${audience_name}

Add an audience to sample question and return to audience builder page
    [Arguments]    ${audience_name}
    Go To Candidate Assistant Responses
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Benefits
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    Who is eligible for benefits?     1s
    Add Audience into Sample Question   ${audience_name}
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click At    ${ARROW_LEFT_BUTTON}
    Click At    Audience Builder

Add an audience with the combination of many targeting rules
    ${audience_name} =   Generate Random Name    auto_audience_
    ${is_existed} =     Run Keyword And Return Status    Check Audience Existed    ${audience_name}
    Click at    ${ADD_AUDIENCE_BUTTON}
    Click at label    Name your audience
    Input into    ${AUDIENCE_NAME_TEXT_BOX}    ${audience_name}
    # First rule
    Select Dropdown Item    ${AUDIENCE_TARGETING_RULES_DROPDOWN}    ${AUDIENCE_RULES_OPTION}   dynamic_locator_item=Assigned Location
    Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}   dynamic_locator_item=Is any of
    Click at    ${AUDIENCE_ASSIGNED_LOCATION_INPUT_DROPDOWN}
    Click at    ${AUDIENCE_ASSIGNED_LOCATION_CHECKBOX}
    Click at    ${AUDIENCE_ASSIGNED_LOCATION_APPLY_BUTTON}
    # Second rule
    Click At    ${AUDIENCE_BUILDER_AND_CONDITION_BUTTON}
    Add new targeting rule      input=${LOCATION_NAME_US}
    Click at    ${AUDIENCE_BUILDER_CREATE_BUTTON}
    [Return]    ${audience_name}

Add new targeting rule
    [Arguments]    ${targeting_rule}=Detected Location      ${match_rule}=Is not    ${input}=None
    Select Dropdown Item    ${AUDIENCE_TARGETING_RULES_DROPDOWN_OPTION}   ${AUDIENCE_RULES_OPTION_2ND}    dynamic_locator_item=${targeting_rule}
    Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN_OPTION}     ${AUDIENCE_RULES_OPTION_2ND}    dynamic_locator_item=${match_rule}
    Set Focus To Element    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}
    IF  '${input}' != 'None'
        Input Into    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}    ${input}
        Click At      ${input}
    END
    Capture Page Screenshot

*** Test Cases ***
Check Create Audience page for all companies except Unilever (OL-T4839)
    Setup to login into system and go to Audience builder page     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    ${list_targeting_rule_options}=    Create List     Assigned Location   Detected Location   Group   Conversation State  Status
    Check Create Audience page      ${list_targeting_rule_options}
    Capture Page Screenshot


Check if user is able to add Targeting Rule is Assigned Location (OL-T4841)
    Setup to login into system and go to Audience builder page     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Check Create Audience Page
    # Check if click at the cancel button in location selection modal
    Select Dropdown Item    ${AUDIENCE_TARGETING_RULES_DROPDOWN}    ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Assigned Location
    Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Is any of
    Click at    ${AUDIENCE_ASSIGNED_LOCATION_INPUT_DROPDOWN}
    Click at    ${AUDIENCE_ASSIGNED_LOCATION_CHECKBOX}
    Click At    ${AUDIENCE_ASSIGNED_LOCATION_CANCEL_BUTTON}
    Click At    ${AUDIENCE_BUILDER_CANCEL_BUTTON}
    # Check if user is able to add Targeting Rule is Assigned Location
    ${audience_name} =  Add an Audience with any Location
    Capture Page Screenshot
    Check audience's status is active   ${audience_name}


Check if user is able to add Targeting Rule is Detected Location (OL-T4842)
    Setup to login into system and go to Audience builder page     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Check Create Audience page
    # Check if user click on [X] button, clear the selected state/ country name and allow user to search location again
    Select Dropdown Item    ${AUDIENCE_TARGETING_RULES_DROPDOWN}    ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Detected Location
    Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Is
    Set Focus To Element    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}
    Input Into    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}    ${LOCATION_NAME_US}
    Click At    ${LOCATION_NAME_US}
    Click At    ${AUDIENCE_COUNTRY_SELECTION_X_ICON}
    Verify Display Text    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}   ${EMPTY}
    Input Into    ${AUDIENCE_COUNTRY_SELECTION_TEXT_BOX}    ${LOCATION_NAME_US}
    Click At    ${LOCATION_NAME_US}
    Click At    ${AUDIENCE_BUILDER_CANCEL_BUTTON}
    # Check if user clicks on [Create] button
    ${audience_name} =  Add an Audience with an optional targeting rule    Detected Location    Is
    Capture Page Screenshot
    Check audience's status is active   ${audience_name}
    Delete added audience name   ${audience_name}


Check if user is able to add Targeting Rule is Group (OL-T4843)
    [Documentation]    Run file: src/data_tests/cms/audience_builder_data_test.robot to create a group if the specific company has no group
    Setup to login into system and go to Audience builder page     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Check Create Audience Page
    Select Dropdown Item    ${AUDIENCE_TARGETING_RULES_DROPDOWN}    ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Group
    Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Is
    Click At    ${AUDIENCE_INPUT_SELECT_DROPDOWN}     Select Group
    Check Element Display On Screen     ${AUDIENCE_SELECT_GROUP_CANCEL_BUTTON}
    Check Element Display On Screen     ${AUDIENCE_SELECT_GROUP_APPLY_BUTTON}
    Click At    ${AUDIENCE_BUILDER_CANCEL_BUTTON}
    ${audience_name} =  Add an Audience with an optional targeting rule     Group   Is    group_name=${group_name}
    Capture Page Screenshot
    Check audience's status is active   ${audience_name}
    Delete added audience name    ${audience_name}


Check if user is able to add Targeting Rule is Conversation State (OL-T4844)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    Check Create Audience Page
    Select Dropdown Item    ${AUDIENCE_TARGETING_RULES_DROPDOWN}    ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Conversation State
    Verify Display Text     ${AUDIENCE_INPUT_SELECT_DROPDOWN}  Select State   dynamic_locator_value=Select State
    Select Dropdown Item    ${AUDIENCE_MATCHES_RULES_DROPDOWN}      ${AUDIENCE_RULES_OPTION}    dynamic_locator_item=Is
    Click At    ${AUDIENCE_INPUT_SELECT_DROPDOWN}    Select State
    FOR     ${conv_state_item}   IN   @{list_of_coversation_states}
        Check Element Display On Screen    ${AUDIENCE_RULES_OPTION}     ${conv_state_item}
    END
    Click At    ${AUDIENCE_BUILDER_CANCEL_BUTTON}
    ${audience_name} =  Add an Audience with an optional targeting rule     Conversation State      Is
    Check audience's status is active   ${audience_name}
    Delete Added Audience Name  ${audience_name}


Check if user is able to add Targeting Rule is Status & select Candidate Journey Status (OL-T4846)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    ${audience_name} =      Add an Audience with an optional targeting rule     Status      Is      candidate_journey_status=Conversation In-Progress
    Delete Added Audience Name    ${audience_name}
    Capture Page Screenshot


Check the Audience Builder page in case many audiences are created (OL-T4849)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    ${audience_name1} =     Add an Audience with an optional targeting rule     Detected Location   Is
    ${audience_name2} =     Add an Audience with an optional targeting rule     Detected Location   Is not
    Check Element Display On Screen    ${audience_name1}
    Check Element Display On Screen    ${audience_name2}
    Delete Added Audience Name    ${audience_name1}
    Delete Added Audience Name    ${audience_name2}


Check if user is able to edit an audience (OL-T4851)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    # create a sample audience builder to check
    ${audience_name} =      Add An Audience With An Optional Targeting Rule   Detected Location   Is
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}   ${audience_name}
    ${edit_option} =        Format String   ${AUDIENCE_BUILDER_ELIPSIS__EDIT_DEACTIVATE_OPTIONS}    ${audience_name}    Edit
    ${deactivate_option} =  Format String   ${AUDIENCE_BUILDER_ELIPSIS__EDIT_DEACTIVATE_OPTIONS}    ${audience_name}    Deactivate
    Check Element Display On Screen     ${edit_option}
    Check Element Display On Screen     ${deactivate_option}
    Check Element Display On Screen     ${AUDIENCE_BUILDER_ELIPSIS_DELETE}  ${audience_name}
    Click At    ${edit_option}
    Element Should Be Disabled     ${AUDIENCE_BUILDER_CREATE_BUTTON}
    Check Element Display On Screen     ${AUDIENCE_BUILDER_CANCEL_BUTTON}
    # If click at cancel button, move back to Audience builder page
    Click At    ${AUDIENCE_BUILDER_CANCEL_BUTTON}
    Capture Page Screenshot
    # Edit name of audience
    ${edited_audience_name} =   Edit the name of an audience builder     ${audience_name}
    Check Element Display On Screen    ${edited_audience_name}
    Delete Added Audience Name         ${edited_audience_name}
    Capture Page Screenshot


Check if user is able to search an audience (OL-T4853)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    # create sample audience builder to search successfully
    # Serch and return result
    ${audience_name} =      Add An Audience With An Optional Targeting Rule   Detected Location   Is
    Input Into    ${SEARCH_AUDIENCE_TEXT_BOX}    ${audience_name}
    Check Element Display On Screen    ${AUDIENCE_NAME_IN_COLUMN}    ${audience_name}
    Delete Added Audience Name      ${audience_name}
    Clear Element Text With Keys    ${SEARCH_AUDIENCE_TEXT_BOX}
    # Search and return empty result
    Input Into    ${SEARCH_AUDIENCE_TEXT_BOX}    ${audience_name}
    Check Element Not Display On Screen    ${audience_name}
    Capture Page Screenshot


Check if user is able to deactivate an audience (OL-T4850)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    ${audience_name} =      Add an Audience with an optional targeting rule     Detected Location   Is
    Add an audience to sample question and return to audience builder page    ${audience_name}
    # check if the audience builder is used in Dynamic Content or Candidate Care
    Hover At    ${AUDIENCE_NAME_IN_COLUMN}      ${audience_name}
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}   ${audience_name}
    ${deactivate_option} =  Format String   ${AUDIENCE_BUILDER_ELIPSIS_EDIT_DEACTIVATE_OPTIONS}    ${audience_name}    Deactivate
    Click At    ${deactivate_option}
    Check Element Display On Screen     ${AUDIENCE_BUILDER_CONFIRM_BUILDER}
    Click At    ${AUDIENCE_BUILDER_MODAL_DELETE_OR_DEACTIVATE_BUTTON}     ${audience_name}
    Check Element Display On Screen    Your change has been saved.
    # If the audience builder is used in Dynamic Content or Candidate Care, it will be removed from those places as well
    Verify the audience will be removed from Candidate Care if it has been deactivated or deleted from Audience builder page    ${audience_name}
    Click At    ${ARROW_LEFT_BUTTON}
    Click At    Audience Builder
    # Check if the audience builder is not used in Dynamic Content or Candidate Care
    ${activate_option} =  Format String   ${AUDIENCE_BUILDER_ELIPSIS_EDIT_DEACTIVATE_OPTIONS}    ${audience_name}    Activate
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}   ${audience_name}
    Click At    ${activate_option}
    Capture Page Screenshot
    # it will not display an confirmation popup and be deactivated normally
    Deactivate an audience name   ${audience_name}
    Delete Added Audience Name    ${audience_name}


Check if user is able to delete an audience (OL-T4852)
    Setup To Login Into System And Go To Audience Builder Page    ${PARADOX_ADMIN}      ${COMPANY_EVENT}
    ${audience_name} =      Add an Audience with any Location
    Add an audience to sample question and return to audience builder page    ${audience_name}
    # check if the audience builder is used in Dynamic Content or Candidate Care
    Hover At    ${AUDIENCE_NAME_IN_COLUMN}      ${audience_name}
    Click At    ${AUDIENCE_BULDER_ELIPSIS_BUTTON}   ${audience_name}
    Click At    ${AUDIENCE_BUILDER_ELIPSIS_DELETE}  ${audience_name}
    Check Element Display On Screen     ${AUDIENCE_BUILDER_CONFIRM_BUILDER}
    Click At    ${AUDIENCE_BUILDER_MODAL_DELETE_OR_DEACTIVATE_BUTTON}     ${audience_name}
    Check Element Display On Screen    Successfully deleted audience builder
    # If the audience builder is used in Dynamic Content or Candidate Care, it will be removed from those places as well
    Verify the audience will be removed from Candidate Care if it has been deactivated or deleted from Audience builder page    ${audience_name}
    Click At    ${ARROW_LEFT_BUTTON}
    Click At    Audience Builder
    # Check if the audience builder is not used in Dynamic Content or Candidate Care
    ${audience_name} =      Add an Audience with any Location
    # it will not display an confirmation popup and be deleted normally
    Delete added audience name  ${audience_name}


Check if user is able to create an audience with the combination of many targeting rules (OL-T4848)
    Setup To Login Into System And Go To Audience Builder Page      ${PARADOX_ADMIN}      ${COMPANY_COMMON}
    ${audience_name} =      Add an audience with the combination of many targeting rules
    Capture Page Screenshot
    Delete Added Audience Name    ${audience_name}
