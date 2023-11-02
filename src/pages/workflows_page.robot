*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/workflows_locators.py
Resource        ../pages/web_management_page.robot
Resource        ../pages/ratings_page.robot
Resource        ../pages/users_page.robot
Resource        ../pages/jobs_page.robot
Resource        ../pages/my_jobs_page.robot
Resource        ../pages/location_management_page.robot
Resource        ../pages/conversation_page.robot
Resource        ../pages/conversation_builder_page.robot
Resource        ../pages/candidate_journeys_page.robot


*** Variables ***
${workflow_add_condition}                   WF Add Condition
${workflow_add_condition_job}               WF_Add_Condition_Job
${group_name}                               WF_Group
${subject_condition_number}                 Subject send communication when input number
${content_condition_number}                 Workflow add condition test send communication when input number
${subject_condition_is_empty}               Workflow test is empty phone number
${content_condition_is_empty}               Workflow add condition test send communication is empty phone number
${subject_condition_is_not_empty}           Workflow test is not empty phone number
${content_condition_is_not_empty}           Workflow add condition test send communication is not empty phone
${subject_condition_assigned_location}      Workflow test assigned location
${content_condition_assigned_location}      Workflow add condition test send communication assigned location
${subject_condition_assigned_group}         Workflow test assigned group
${content_condition_assigned_group}         Workflow add condition test send communication assigned group
${edit_condition_criteria_button}           Edit Condition Criteria
${candidate_fist_name}          Amelinda
${standard_job_for_workflow}    workflow standard
${standard_job_workflow_hm}     workflow standard hm
${basic_job_for_workflow}       workflow basic
${multi_job_for_workflow}       workflow multi
${multi_job_workflow_rec}       workflow multi hm
${rating_name}                  rating_for_workflow
${age_send_rating}              More than 25
${age_send_communication}       Between 18 and 25
${age_send_condition}           Under 18
${url_landing_site}             co/TestAutomationFranchiseOn/LandingSiteCreateJob

*** Keywords ***
Add a Workflow
    [Arguments]    ${workflow_name}=None    ${workflow_type}=None    ${journey_name}=None    ${audience_type}=None
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}  slow_down=2s
    ${workflow_type_locator} =    Format String    ${WORKFLOW_TYPE_VALUE}    ${workflow_type}
    Run Keyword and Ignore Error    Click at    ${workflow_type_locator}    wait_time=5s
    IF    '${workflow_name}' == 'None'
        ${workflow_name} =    Generate random name    auto_workflow
    END
    IF    '${audience_type}' == 'None'
        ${audience_type} =    Set variable    Candidate
    END
    Input into    ${WORKFLOW_NAME_TEXT_BOX}    ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}    ${audience_type}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into    ${JOURNEY_SEARCH_TEXT_BOX}    ${journey_name}
    Click at    ${journey_name}
    IF    '${audience_type}' == 'Location Contact'
        Click at    ${WORKFLOW_LOCATION_CONTACT_INPUT}
        Input into      ${WORKFLOW_SEARCH_LOCATION_INPUT}    ${location_name}
        Click by JS    ${WORKFLOW_LOCATION_NAME_CHECKBOX}   ${location_name}
        Click at        ${COMMON_BUTTON}    Apply
    END
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Wait with short time
    [Return]    ${workflow_name}

Add a Task into Workflow
    [Arguments]    ${status}    ${action}=None   ${task_name}=None
    Wait For Page Load Successfully
    Click at    ${WF_ADD_TASK_BUTTON}
    IF  '${task_name}' == 'None'
        ${task_name} =    Generate random name    auto_task
    END
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    ${status}
    Click at    ${STATUS_VALUE}    ${status}
    IF  '${action}' != 'None'
        Click at    ${ADD_TRIGGER_BUTTON}
        Click at    ${WF_ADD_TASK_TRIGGER_ITEM}   ${action}
    END
    [Return]    ${task_name}

Get Mention list item
    ${item_list} =    Create List
    ${item_elements} =    Get WebElements    ${QL_MENTION_LIST_ITEM}
    FOR    ${element}    IN    @{item_elements}
        ${element_text} =    Replace String    ${element.get_attribute('innerHTML')}
        ...    <mark data-markjs="true">#</mark>    ${EMPTY}
        Append To List    ${item_list}    ${element_text}
    END
    [Return]    ${item_list}

Display the Mention list item that include All Location Attributes that created on System Attributes page
    [Arguments]    ${all_location_attr_keys}
    ${displayed_tokens} =    Get Mention list item
    FOR    ${key_name}    IN    @{all_location_attr_keys}
        Check element existed in list    la-${key_name}    ${displayed_tokens}
    END

Delete a Workflow
    [Arguments]    ${workflow_name}
    Go to Workflows page
    ${workflows_locators} =    Format String    ${WORKFLOW_ECLIPSE_ICON}    ${workflow_name}
    Load more item in page    ${workflows_locators}
    Click by JS    ${workflows_locators}
    Click by JS    ${WORKFLOW_ECLIPSE_POPUP_DELETE_BUTTON}    ${workflow_name}     2s
    Click at    ${WORKFLOW_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}     slow_down=2s
    Check element not display on screen    ${workflow_name}

Verify Create Workflow page with platform
    [Arguments]    ${expected_platform}=None
    IF    '${expected_platform}' == 'None'
        IF    '${env}' == 'UNILEVER'
            ${expected_platform} =    Set variable    Workday
        ELSE
            ${expected_platform} =    Set variable    Paradox
        END
    END
    Verify display text    ${WORKFLOW_PLATFORM_SELECTED_TEXT}    ${expected_platform}

Verify that display "AT" section with "Time" field default 8AM and text "Sent in user’s time zone"
    Verify display text with get text value    ${START_POINT_TIME_OF_DAY_HOUR_TEXT_BOX}    8
    Check element display on screen    Sent in user’s time zone

Choose Rating in Workflow Task
    [Arguments]    ${rating_name}
    Click at    ${TASK_RATING_DROPDOWN}
    Input into    ${TASK_RATING_SEARCH_TEXT_BOX}    ${rating_name}
    Click at    ${rating_name}

Add condition into Workflow Task
    [Arguments]    ${target_rule}=None    ${matches_rule}=None    ${input_value}=None
    Click at    ${TASK_ADD_CONDITION_BUTTON}
    Input into    ${TASK_CONDITION_NAME_TEXT_BOX}    auto_condition_name
    Click at    ${TASK_CONDITION_TARGET_RULE_DROPDOWN}
    Click at    ${TASK_CONDITION_TARGET_RULE_VALUE}    System Attributes
    Click at    ${target_rule}
    Click at    ${TASK_CONDITION_MATCHES_RULE_DROPDOWN}
    Click at    ${matches_rule}
    Input into    ${TASK_CONDITION_INPUT_TEXT_BOX}    ${input_value}
    Click at    ${TASK_CONDITION_SAVE_BUTTON}
    Click at    ${TASK_CONDITION_APPLY_BUTTON}

Active a Workflow
    [Arguments]    ${workflow_name}
    Go to Workflows page
    ${workflows_locators} =    Format String    ${WORKFLOW_ECLIPSE_ICON}    ${workflow_name}
    Load more item in page    ${workflows_locators}
    Click by JS    ${workflows_locators}
    Click at    ${WORKFLOW_ECLIPSE_POPUP_ACTIVATE_BUTTON}    ${workflow_name}

Duplicate a Workflow
    [Arguments]    ${workflow_name}
    Go to Workflows page
    ${workflows_locators} =    Format String    ${WORKFLOW_ECLIPSE_ICON}    ${workflow_name}
    Load more item in page    ${workflows_locators}
    Click at    ${workflows_locators}
    Click at    ${WORKFLOW_ECLIPSE_POPUP_DUPLICATE_BUTTON}    ${workflow_name}

Add a Send communication Action into Workflow
    [Arguments]    ${status}    ${subject_text}=None     ${content_text}=None
    ${task_random_name} =    Add a Task into Workflow    ${status}    ${WF_SEND_COMMUNICATION}
    IF    '${subject_text}' == 'None'
        ${subject_text} =    Set variable    auto_mail_subject
    END
    IF    '${content_text}' == 'None'
        ${content_text} =    Set variable    auto_text
    END
    Input into    ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    ${subject_text}
    # Test for Email Tab
    Input into    ${EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    ${content_text}
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    ${content_text}
    [Return]    ${task_random_name}

Add a Send Rating Action into Workflow
    [Arguments]    ${rating_name}   ${status}    ${subject_text}
    ${task_random_name} =    Add a Task into Workflow      ${status}      ${WF_REQUEST_RATING}
    Choose Rating in Workflow Task    ${rating_name}
    Input into    ${TASK_RATING_EMAIL_SUBJECT}    ${subject_text}
    [Return]    ${task_random_name}

Add a Send Condition Action into Workflow
    [Arguments]     ${subject_text}     ${content_text}      ${target_rule}=None    ${matches_rule}=None    ${input_value}=None
    ${task_random_name} =    Add a Task into Workflow    Capture Complete    ${ADD_CONDITION}
    Add condition into Workflow Task      ${target_rule}    ${matches_rule}    ${input_value}
    Click at    ${ADD_CONDITION_ACTIONS_ICON}\[2\]
    Click at    ${ADD_CONDITION_ACTION_VALUE}    Send Communication
    Input into    ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    ${subject_text}
    # Test for Email Tab
    Input into    ${EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    ${content_text}
    Click at    ${SAVE_TASK_BUTTON}
    # Test for SMS Tab
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    ${content_text}
    [Return]    ${task_random_name}

Open an available workflow
    [Arguments]   ${workflow_name}
    Go to Workflows page
    ${workflow_url} =  Get attribute and format text  data-url  ${WORKFLOW_URL}  ${workflow_name}
    Go to  ${BASE_URL}/${workflow_url}
    wait for page load successfully v1

Add new Task into Workflow
    [Arguments]      ${status}    ${action}     ${rating_name}=None    ${task_name}=None
    Click at    ${WF_ADD_TASK_BUTTON}
    IF  '${task_name}' == 'None'
        ${task_name} =    Generate random name    auto_task
    END
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    ${status}
    Click at    ${STATUS_VALUE}    ${status}
    Run Keyword If     ('${status}'!= 'Send Form') and ('${status}'!= 'Send Offer') and ('${status}'!= 'Send Rating')     Click at    ${ADD_TRIGGER_BUTTON}
    Run Keyword If     ('${status}'!= 'Send Form') and ('${status}'!= 'Send Offer') and ('${status}'!= 'Send Rating')     Click at    ${WF_ADD_TASK_TRIGGER_ITEM}   ${action}
    Run Keyword If     ('${status}'== 'Send Rating') and ('${rating_name}'!='None')     Choose Rating in Workflow Task      ${rating_name}
    [Return]    ${task_name}

Create new workflow and add a task and publish workflow
    [Arguments]   ${journey_name}     ${status}       ${action}   ${task_name}=None      ${workflow_name}=None      ${audience_type}=None
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}  slow_down=2s
    IF    '${workflow_name}' == 'None'
        ${workflow_name} =    Generate random name    auto_workflow
    END
    IF    '${audience_type}' == 'None'
        ${audience_type} =    Set variable    Candidate
    END
    Input into    ${WORKFLOW_NAME_TEXT_BOX}    ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}    ${audience_type}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into    ${JOURNEY_SEARCH_TEXT_BOX}    ${journey_name}
    Click at    ${journey_name}
    IF    '${audience_type}' == 'Location Contact'
        Click at    ${WORKFLOW_LOCATION_CONTACT_INPUT}
        Input into      ${WORKFLOW_SEARCH_LOCATION_INPUT}    ${location_name}
        Click by JS    ${WORKFLOW_LOCATION_NAME_CHECKBOX}   ${location_name}
        Click at        ${COMMON_BUTTON}    Apply
    END
    wait for page load successfully
    Add new Task into Workflow    status=${status}    action=${action}   task_name=${task_name}
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_name}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Check element display on screen     Changes saved successfully.
    [Return]     ${workflow_name}

Delete Workflow data tests after run test case
    [Arguments]    ${workflow_name}=None    ${rating_name}=None    ${job_name}=None    ${cj_name}=None    ${site_name}=None    ${conversation_name}=None
    IF    '${rating_name}' != 'None'
        Delete a Rating    Users    ${rating_name}
    END
    IF    '${job_name}' != 'None'
        Deactivate a job    ${job_name}
        Delete a Job    ${job_name}    ${JF_COFFEE_FAMILY_JOB}
    END
    IF    '${cj_name}' != 'None'
        Delete a Journey    ${cj_name}
    END
    IF    '${workflow_name}' != 'None'
        Delete a Workflow    ${workflow_name}
    END
    IF    '${site_name}' != 'None'
        Delete a landing site/widget site    ${site_name}
    END
    IF    '${conversation_name}' != 'None'
        Delete a Conversation    ${conversation_name}
    END

Candidate finish Job Internal
    [Arguments]    ${job_name}     ${Age}       ${candidate_fist_name}=None
    ${candidate_name} =    Generate candidate name      candidate_fist_name=${candidate_fist_name}
    &{email_info} =    Get email for testing    is_spam_email=False
    Verify Olivia conversation message display     ${WHAT_OPPORTUNITY}
    Candidate input to landing site    ${ANY_JOB_IN_US}
    Verify Olivia conversation message display     ${GREAT_TAKE_A_LOOK_AT_THE}
    Candidate input to landing site    ${job_name}
    ${is_many_job} =    Run Keyword And Return Status    Check span display      See All          wait_time=5s
    IF  ${is_many_job} == True
        Click on span text    See All
        Click at    ${JOB_ON_MODEL}    ${job_name}
    END
    ${is_one_job} =     Run Keyword And Return Status    Check Element Display On Screen      Details      wait_time=5s
    IF  ${is_one_job} == True
        Click on span text    See All
        Click at    Details
    END
    Click at    ${CONVERSATION_APPLY_NOW_BUTTON}
    Verify Olivia conversation message display      ${ASK_FIRST_AND_LAST_NAME}
    Candidate input to landing site     ${candidate_name.full_name}
    Verify Olivia conversation message display      ${ASK_PHONE}
    Candidate input to landing site     ${CONST_PHONE_NUMBER}
    Verify Olivia conversation message display      ${ASK_EMAIL}
    Candidate input to landing site     ${email_info.email}
    Verify Olivia conversation message display      ${ASK_AGE}
    Click at    ${CONVERSATION_CHOICE_BUTTON}       ${Age}
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Verify Olivia conversation message display     Please select one
    Click at    ${CONVERSATION_CHOICE_BUTTON}       Email Only
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    [Return]    ${candidate_name.first_name}
