*** Settings ***
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/conversation_builder_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

Force Tags          advantage    aramark    birddoghr    fedex    fedexstg    ltsstg    olivia    pepsi    regression    stg

Documentation       Run file data test: data_tests/workflow/add_condition_candidate.robot

*** Variables ***
${auto_condition}       auto_condition
@{list_operators}=      Exactly matches    Does not exactly match    Contains    Does not contain    Starts with    Does not start with    Ends with    Does not end with    Is empty    Is not empty    Equals    Does not equal    Greater than    Greater than or equal to    Less than    Less than or equal to

*** Test Cases ***
Check if user is able to add targeting rule is Assigned Location - Less than 4k locations (OL-T9796)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${condition_name} =     Generate random name    ${auto_condition}
    Go to Workflows page
    Click at    ${workflow_add_condition}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_INCOMPLETE}       ${ADD_CONDITION}
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Input into      ${TASK_CONDITION_NAME_TEXT_BOX}     ${condition_name}
#   Verify display Targeting Rule dropdown field with job on
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Check element display on screen     ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_ASSIGNED_LOCATION}
    Check element display on screen     ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_SYSTEM_ATTRIBUTES}
    Capture page screenshot
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_ASSIGNED_LOCATION}
    Click at    ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
#   Verify display Matches field
    Check element display on screen     ${WF_MATCH_CONDITION_IS_ANY_OF}
    Check element display on screen     ${WF_MATCH_CONDITION_IS_NOT_ANY_OF}
    Click at    ${WF_MATCH_CONDITION_IS_ANY_OF}
#   Verify input location
    Input location for targeting rule       ${LOCATION_NAME_1}
    Input location for targeting rule       ${LOCATION_NAME_2}
    Capture page screenshot
    Verify The condition is added successfully      ${condition_name}


Check if user is able to add targeting rule is Group (OL-T9799)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${condition_name} =     Generate random name    ${auto_condition}
    Go to Workflows page
    Click at    ${workflow_add_condition}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_INCOMPLETE}       ${ADD_CONDITION}
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Input into      ${TASK_CONDITION_NAME_TEXT_BOX}     ${condition_name}
#   Verify display Targeting Rule dropdown field with job off
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Check element display on screen     ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_ASSIGNED_LOCATION}
    Check element display on screen     ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_SYSTEM_ATTRIBUTES}
    Check element display on screen     ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_GROUP}
    Capture page screenshot
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_GROUP}
    Click at    ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
#   Verify display Matches field
    Check element display on screen     ${WF_MATCH_CONDITION_IS}
    Check element display on screen     ${WF_MATCH_CONDITION_IS_NOT}
    Click at    ${WF_MATCH_CONDITION_IS}
#   Verify input group
    Input group for targeting rule      ${group_name}
    Capture page screenshot
    Verify The condition is added successfully      ${condition_name}


Check if user is able to add targeting rule is System Attribute - Null (OL-T9803)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${condition_name} =     Generate random name    ${auto_condition}
    Go to Workflows page
    Click at    ${workflow_add_condition}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_INCOMPLETE}       ${ADD_CONDITION}
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Input into      ${TASK_CONDITION_NAME_TEXT_BOX}     ${condition_name}
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_SYSTEM_ATTRIBUTES}
    Click at    Candidate First Name
    Click at    ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
    FOR  ${operators}    IN        @{list_operators}
        Search operators at Matches     ${operators}
    END
    Search operators at Matches     Is empty
    Click at    Is empty
    Verify The condition is added successfully      ${condition_name}


Check if user is able to add targeting rule is System Attribute - Numberic (OL-T9802)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${condition_name} =     Generate random name    ${auto_condition}
    Go to Workflows page
    Click at    ${workflow_add_condition}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_INCOMPLETE}       ${ADD_CONDITION}
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Input into      ${TASK_CONDITION_NAME_TEXT_BOX}     ${condition_name}
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_SYSTEM_ATTRIBUTES}
    Click at    Candidate First Name
    Click at    ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
#   Select [Matches] is a numeric operator
    Search operators at Matches     Equals
    Click at    Equals
#   Verify display error message when input a text into Numeric Input field
    Input into      ${COMMON_INPUT_PLACEHOLDER}     input_text      Numeric Input
    Check Element Display On Screen     ${ADD_CONDITION_ERROR_MESSAGE}      Enter numeric value
    Input into      ${COMMON_INPUT_PLACEHOLDER}     12345       Numeric Input
    Verify The condition is added successfully      ${condition_name}


Check if user is able to add targeting rule is System Attribute - Text Value (OL-T9800, OL-T5113)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${condition_name} =     Generate random name    ${auto_condition}
    Go to Workflows page
    Click at    ${workflow_add_condition}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_INCOMPLETE}       ${ADD_CONDITION}
#   Verify [Add Condition] action is visible on Workflow - Candidate Audience (OL-T5113)
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Input into      ${TASK_CONDITION_NAME_TEXT_BOX}     ${condition_name}
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}     ${WF_TARGETING_RULE_SYSTEM_ATTRIBUTES}
    Click at    Candidate First Name
    Click at    ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
#   Select [Matches] is a text value operator
    Search operators at Matches     Exactly matches
    Click at    Exactly matches
#   Veryfy input text, number, special charactor at [Input] field (OL-T9800)
    Input value add condition       Text Input      input_text
    Click at    ${ADD_CONDITION_ITEM_CONDITION_ON_SLIDE_OUT}    ${condition_name}
    Input value add condition       Text Input      12345
    Click at    ${ADD_CONDITION_ITEM_CONDITION_ON_SLIDE_OUT}    ${condition_name}
    Input value add condition       Text Input      \###@@@@@
    Check element display on screen     ${ADD_CONDITION_ITEM_CONDITION_ON_SLIDE_OUT}    ${condition_name}
    Capture page screenshot


Check if workflow works correctly in Assigned Location condition (OL-T5128, OL-T9801)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Add a Candidate     group_name=${group_name}    location_name=${LOCATION_HAWAII_ISLAND}
#   Verify workflow works correctly in Assigned Location condition (OL-T5128)
    Check Element Display On Screen     ${CONVERSATION_TEXT}    ${content_condition_assigned_location}
    Capture page screenshot
#   Verify workflow works correctly in [Group] condition (OL-T9801)
    Check Element Display On Screen     ${CONVERSATION_TEXT}    ${content_condition_assigned_group}
    Capture page screenshot


Check if workflow works correctly in System Attribute condition - Not Null (OL-T9807, OL-T9804, OL-T9805, OL-T9806, OL-T9808)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
#   Verify workflow works correctly in [System Attribute] condition - Null (OL-T9806)
    Add a Candidate test add condition      location_name=${LOCATION_AMSTERDAM}     job_name=${workflow_add_condition_job}
    Check Element Display On Screen     ${CONVERSATION_TEXT}    ${content_condition_is_empty}
    Capture page screenshot
#   Verify workflow works correctly in [System Attribute] condition - Not Null (OL-T9807)
    Add a Candidate test add condition      location_name=${LOCATION_AMSTERDAM}     job_name=${workflow_add_condition_job}      phone_number=${CONST_PHONE_NUMBER}
    Check Element Display On Screen     ${CONVERSATION_TEXT}    ${content_condition_is_not_empty}
    Capture page screenshot
#   Verify workflow works correctly in [System Attribute] condition - Text Value (OL-T9804)
    Add a Candidate test add condition      location_name=${LOCATION_AMSTERDAM}     job_name=${workflow_add_condition_job}      candidate_first=Workflow_Condition
    Check Element Display On Screen     ${CANDIDATE_JOURNEY_STATUS}     ${SEND_RATING_STATUS}
    Capture page screenshot
#   Verify workflow works correctly in [System Attribute] condition - Numeric (OL-T9805)
    Add a Candidate test add condition      location_name=${LOCATION_AMSTERDAM}     job_name=${workflow_add_condition_job}      candidate_last_name=12345
    Check Element Display On Screen     ${CONVERSATION_TEXT}    ${content_condition_number}
    Capture page screenshot


Check if workflow triggers Default Condition when no condition matched (OL-T9808)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Add a Candidate test add condition      location_name=${LOCATION_NAME_2}    job_name=${workflow_add_condition_job}
    Check Element Display On Screen     ${CONVERSATION_TEXT}    ${DO_ANY_OF_THESE_TIMES_WORK}
    Capture page screenshot

*** Keywords ***
Input location for targeting rule
    [Arguments]     ${location}
    Click at     ${ADD_CONDITION_LOCATION_INPUT}
    Input into      ${WORKFLOW_SEARCH_LOCATION_INPUT}       ${location}
    ${location_name} =    Format String     ${WORKFLOW_LOCATION_NAME_CHECKBOX}      ${location}
    Click by JS    ${location_name}         wait_time=10s
    Click at        ${COMMON_BUTTON}    Apply

Input group for targeting rule
    [Arguments]     ${group}
    Click at     ${ADD_CONDITION_SELECT_GROUP_INPUT}
    Input into      ${COMMON_INPUT_PLACEHOLDER}       ${group}      Search group
    ${group_name} =    Format String     ${ADD_CONDITION_GROUP_CHECKBOX}      ${group}
    Click by JS    ${group_name}         wait_time=10s
    Click at        ${COMMON_BUTTON}    Apply

Search operators at Matches
    [Arguments]  ${operators}
    Input into      ${COMMON_INPUT_PLACEHOLDER}          ${operators}           Search operators
    Check element display on screen    ${COMMON_DIV_TEXT}       ${operators}
    Capture page screenshot

Verify The condition is added successfully
    [Arguments]  ${condition_name}
    Click at       ${TASK_CONDITION_SAVE_BUTTON}
    Check element display on screen      ${ADD_CONDITION_ITEM_CONDITION_ON_SLIDE_OUT}       ${condition_name}
    Capture page screenshot
    Click at        ${TASK_CONDITION_APPLY_BUTTON}

Input value add condition
    [Arguments]    ${place_holder_text}      ${value}
    Input into   ${COMMON_INPUT_PLACEHOLDER}     ${value}       ${place_holder_text}
    Capture page screenshot
    Click at       ${TASK_CONDITION_SAVE_BUTTON}

Add a Candidate test add condition
    [Arguments]    ${location_name}=None    ${group_name}=None    ${candidate_first}=None       ${candidate_last_name}=None        ${job_name}=None      ${phone_number}=None       ${is_spam_email}=True
    run keyword and ignore error    Click at    ${INBOX_ADD_CANDIDATE_BUTTON}
    IF    '${candidate_first}' == 'None'
            ${candidate_first} =    Generate random text only
    END
    IF    '${candidate_last_name}' == 'None'
            ${candidate_last_name} =    Set Variable    Lname
    END
    Input into    ${CEM_INPUT_FIRST_NAME_TEXT_BOX}    ${candidate_first}
    Input into    ${CEM_INPUT_LAST_NAME_TEXT_BOX}    ${candidate_last_name}
    &{email_info} =    Get email for testing    ${is_spam_email}
    Input into    ${CEM_INPUT_EMAIL_TEXT_BOX}    ${email_info.email}
    IF    '${location_name}' != 'None'
        Click at    ${CEM_LOCATION_DROPDOWN}
        Input into    ${CEM_LOCATION_SEARCH_TEXT_BOX}    ${location_name}
        Click at    ${CEM_LOCATION_VALUE}    ${location_name}
    END
    IF    '${group_name}' != 'None'
        Click at    ${GROUP_SELECTION_DROPDOWN}
        Input into    ${GROUP_SEARCH_TEXT_BOX}    ${group_name}
        Click at    ${CANDIDATE_GROUP_NAME_OPTION}    ${group_name}     2s
    END
    IF    '${job_name}' != 'None'
        Click at    ${GROUP_SELECTION_DROPDOWN}
        Input into    ${CEM_JOB_SEARCH_TEXT_BOX}    ${job_name}
        Click at    ${CANDIDATE_GROUP_NAME_OPTION}    ${job_name}
    END
    IF    '${phone_number}' != 'None'
        Input into    ${CEM_INPUT_PHONE_NUMBER_TEXT_BOX}    ${phone_number}
    END
    Click on span text      Add Candidate
    Wait For Page Load Successfully
