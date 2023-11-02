*** Settings ***
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    lts_stg

*** Variables ***

*** Test Cases ***
Workflows, Check UI of Conditional Workflows modal (OL-T5602, OL-T5603, OL-T5604)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Go to a workflow
    ${workflow_name} =  Add a workflow for testing
    Add a Task into Workflow    ${CAPTURE_COMPLETE}   ${ADD_CONDITION}
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Check design of Condition Criteria
    #   Check items in targeting rules dropdown
    Input into    ${TASK_CONDITION_NAME_TEXT_BOX}    auto_condition_name
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Check element display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    Assigned Location
    Check element display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    System Attributes
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}    System Attributes
    #   Input invalid value then check "No resutl found" displays
    Input into    ${ADD_CONDITION_TARGETING_SEARCH_TEXTBOX}    spam text
    Check element display on screen    ${ADD_CONDITION_NO_RESULT_FOUND}
    Input into    ${ADD_CONDITION_TARGETING_SEARCH_TEXTBOX}    Candidate
    Check element display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    ${CANDIDATE_FIRST_NAME}
    Check element display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    ${CANDIDATE_LAST_NAME}
    Check element not display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    City
    Delete a Workflow  ${workflow_name}


Workflows> Check data at Candidate Attribute dropdown mapping System Attributes page after user edited an attribue (OL-T5606)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Go to System attribute and add new attribute
    ${attribute_name} =     Add a Custom Candidate Attributes
    #   Go to a workflow
    ${workflow_name} =  Add a workflow for testing
    Open condition Criteria dialog and check candidate attribute    ${attribute_name}
    #   Go to System attribute and edit attribute
    ${new_attribute_name} =  Edit name of candidate attribute    ${attribute_name}
    #   Go to a workflow and check old name was removed and new name displays
    Open an available workflow    ${workflow_name}
    Open condition Criteria dialog and check candidate attribute    ${new_attribute_name}
    Input into    ${ADD_CONDITION_TARGETING_SEARCH_TEXTBOX}    ${attribute_name}
    Check element not display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    ${attribute_name}
    Delete a Workflow  ${workflow_name}
    Delete a candidate attribute    ${new_attribute_name}


Workflows> Check data at Candidate Attribute dropdown mapping System Attributes page after user deleted (OL-T5605)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Go to System attribute and add new attribute
    ${attribute_name} =     Add a Custom Candidate Attributes
    #   Go to a workflow
    ${workflow_name} =  Add a workflow for testing
    Open condition Criteria dialog and check candidate attribute    ${attribute_name}
    #   Go to System attribute and edit attribute
    Delete a candidate attribute    ${attribute_name}
    #   Go to a workflow and check old name was removed and new name displays
    Open an available workflow  ${workflow_name}
    Open condition Criteria dialog
    Input into    ${ADD_CONDITION_TARGETING_SEARCH_TEXTBOX}    ${attribute_name}
    Check element not display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    ${attribute_name}
    Delete a Workflow  ${workflow_name}

*** Keywords ***
Open condition Criteria dialog
    Add a Task into Workflow    ${CAPTURE_COMPLETE}   ${ADD_CONDITION}
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}    System Attributes

Open condition Criteria dialog and check candidate attribute
    [Arguments]  ${attribute_name}
    Open condition Criteria dialog
    Input into    ${ADD_CONDITION_TARGETING_SEARCH_TEXTBOX}    ${attribute_name}
    Check element display on screen    ${TASK_CONDITION_TARGET_RULE_VALUE}    ${attribute_name}
    Capture page screenshot

Add a workflow for testing
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}  slow_down=2s
    #   Set basic information
    ${workflow_name} =    Generate random name    auto_workflow
    Input into    ${WORKFLOW_NAME_TEXT_BOX}    ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}    Candidate
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into    ${JOURNEY_SEARCH_TEXT_BOX}    ${DEFAULT_JOURNEY}
    Click at    ${DEFAULT_JOURNEY}
    Wait with short time
    [Return]    ${workflow_name}

Check design of Condition Criteria
    Check element display on screen  ${TASK_CONDITION_NAME_TEXT_BOX}
    #   Verify "Targeting" column
    Check element display on screen  ${ADD_CONDITION_TITLE_COLUMN_VALUE}    Targeting Rules
    Check element display on screen  ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Verify text contain  ${TASK_CONDITION_TARGET_RULE_DROPDOWN}  Select
    #   Verify "Matches" column
    Check element display on screen  ${ADD_CONDITION_TITLE_COLUMN_VALUE}    Matches
    Check element display on screen  ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
    Verify text contain  ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}  Select
    #   Verify "Input" column
    Check element display on screen  ${ADD_CONDITION_TITLE_COLUMN_VALUE}    Input
    Check element display on screen  ${TASK_CONDITION_DISABLED_INPUT_TEXT_BOX}
    #   Verify buttons
    Check element display on screen  ${TASK_CONDITION_SAVE_BUTTON}
    Check element display on screen  ${TASK_CONDITION_CANCEL_BUTTON}
    Check element display on screen  ${ADD_CONDITION_AND_CONDITION_BUTTON}
    Check element display on screen  ${ADD_CONDITION_OR_CONDITION_BUTTON}
