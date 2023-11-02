*** Settings ***
Resource            ../../pages/workflows_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

Default Tags        advantage    aramark    birddoghr    darden    dev    dev2    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    test

*** Variables ***
@{audience_list}                            ${BASIC}    ${CP_ADMIN}    ${FO}    ${FS}    ${EDIT_EVERYTHING}    ${EDIT_NOTHING}    ${HM}    ${RECRUITER}    ${REPORT}    ${SUPER_VISOR}
@{audience_list_not_have_recruiter_user}    ${BASIC}    ${CP_ADMIN}    ${FO}    ${FS}    ${EDIT_EVERYTHING}    ${EDIT_NOTHING}    ${HM}    ${REPORT}    ${SUPER_VISOR}
@{start_point_time_list}                    Minutes    Hours    Days    Weeks    Months

*** Test Cases ***
Workflow Builder - Show Hiring Team Roles in Audience list when at least one hiring team is created in Client Setup (OL-T14014)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    Click at    ${AUDIENCE_DROPDOWN}
    Capture Page Screenshot
    FOR    ${user}    IN    @{audience_list}
        Check element display on screen     ${WF_AUDIENCE_USER_ROLES}       ${user}
        Capture Page Screenshot
    END
    Check element display on screen     ${WF_AUDIENCE_HIRING_TEAM_ROLES}    ${RECRUITER}
    Capture Page Screenshot


Workflow Builder - Verify user can search user or role (OL-T14015)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    Click at    ${AUDIENCE_DROPDOWN}
    Input into      ${AUDIENCE_TYPE_SEARCH_TEXT_BOX}    ${RECRUITER}
    Check element display on screen     Hiring Team Roles
    Check element display on screen     User Roles
#   Verify there is matching result search
    Check element display on screen     ${WF_AUDIENCE_HIRING_TEAM_ROLES}    ${RECRUITER}
    Check element display on screen     ${WF_AUDIENCE_USER_ROLES}       ${RECRUITER}
#   Verify there is not matching result will be hidden.
    Check element not display on screen     ${AUDIENCE_TYPE_VALUE}      Candidate
    Capture Page Screenshot
    FOR    ${user}    IN    @{audience_list_not_have_recruiter_user}
        Check element not display on screen     ${WF_AUDIENCE_USER_ROLES}       ${user}
        Capture Page Screenshot
    END


Workflow Builder - Verify Languages dropdown in case audience is Hiring Team Roles - Platform Language toggle ON (OL-T14019, OL-T14016, OL-T14017)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Generate random name    auto_workflow
    Input into      ${WORKFLOW_NAME_TEXT_BOX}       ${workflow_name}
#   Verify Cancel button when user selects a user role or hiring team role (OL-T14017)
    Click at    ${AUDIENCE_DROPDOWN}
    Check element display on screen     ${AUDIENCE_TYPE_VALUE}      Candidate
    Click at    ${AUDIENCE_TYPE_POPUP_CANCEL_BUTTON}
    Check element not display on screen     ${AUDIENCE_TYPE_POPUP}
    Capture Page Screenshot
#    Verify Apply button when user selects a user role or hiring team role (OL-T14016)
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}      ${RECRUITER}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Check element not display on screen     ${AUDIENCE_TYPE_POPUP}
    Capture Page Screenshot
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into      ${JOURNEY_SEARCH_TEXT_BOX}      Default Candidate Journey
    Click at    Default Candidate Journey
    Click at    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Check element display on screen     English (en)
    Check element display on screen     Spanish (es)
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify available actions in case audience is Hiring Team Roles (OL-T14020)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${RECRUITER}
    ${task_random_name} =       Generate random name    auto_task
    Click at    ${WF_ADD_TASK_BUTTON}
    Input into      ${WF_TASK_NAME_TEXTBOX}     ${task_random_name}
    Click by JS     ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into      ${STATUS_SEARCH_TEXT_BOX}       Capture Complete
    Click at    ${STATUS_VALUE}     Capture Complete
    Click at    ${ADD_TRIGGER_BUTTON}
    Check element display on screen     ${SEND_COMMUNICATION_ACTION}
    Check element display on screen     ${ADD_CONDITION_ACTION}
    Check element display on screen     ${REQUEST_RATING_ACTION}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Send Communication action with audience is Hiring Team Role (OL-T14021)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${RECRUITER}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${WF_SEND_COMMUNICATION}
    Input subject and content for trigger send communication
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Send Communication action with Timed Trigger + audience is Hiring Team Role (OL-T14022)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${RECRUITER}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${WF_SEND_COMMUNICATION}
    Input subject and content for trigger send communication
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${task_random_name}
    Turn off    ${START_POINT_TIMED_TOGGLE}
    Input into      ${START_POINT_TIME_TEXT_BOX}    1
    Click at    ${START_POINT_TIME_UNIT_DROPDOWN}
    Verify all start point time is displayed    @{start_point_time_list}
    Click at    ${START_POINT_TIME_UNIT_VALUE}      Days
    Verify that display "AT" section with "Time" field default 8AM and text "Sent in user’s time zone"
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Send Communication action with Timed Trigger + audience is User Role (OL-T14023, OL-T14024)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${CP_ADMIN}
#   Verify user can add Send Communication action with audience is User Role (OL-T14024)
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${WF_SEND_COMMUNICATION}
    Input subject and content for trigger send communication
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${task_random_name}
    Turn off    ${START_POINT_TIMED_TOGGLE}
    Input into      ${START_POINT_TIME_TEXT_BOX}    1
    Click at    ${START_POINT_TIME_UNIT_DROPDOWN}
    Verify all start point time is displayed    @{start_point_time_list}
    Click at    ${START_POINT_TIME_UNIT_VALUE}      Days
    Verify that display "AT" section with "Time" field default 8AM and text "Sent in user’s time zone"
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Add Condition action with audience is Hiring Team Role (OL-T14027)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${RECRUITER}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${ADD_CONDITION}
    Add condition into Workflow Task    Candidate First Name    Contains    auto_test_condition
    Add condition action send communication     Default Condition       1
    Add condition action send communication     auto_condition_name     2
    # ADD SEND COMMUNICATION ACTION
    Add trigger when task have many send communication      3
    # ADD SEND RATING ACTION
    Click at    ${ADD_TRIGGER_BUTTON}\[3\]
    Click at    ${REQUEST_RATING_ACTION}
    Choose Rating in Workflow Task      ${rating_name}
    Input into      ${TASK_RATING_EMAIL_SUBJECT}\[4\]       auto_mail_subject
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Add Condition action with audience is User Role (OL-T14028)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${CP_ADMIN}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${ADD_CONDITION}
    Add condition into Workflow Task    Candidate First Name    Contains    auto_test_condition
    Add condition action send communication     Default Condition       1
    Add condition action send communication     auto_condition_name     2
    # ADD SEND COMMUNICATION ACTION
    Add trigger when task have many send communication      3
    # ADD SEND RATING ACTION
    Click at    ${ADD_TRIGGER_BUTTON}\[3\]
    Click at    ${REQUEST_RATING_ACTION}
    Choose Rating in Workflow Task      ${rating_name}
    Input into      ${TASK_RATING_EMAIL_SUBJECT}\[4\]       auto_mail_subject
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify behavior when user changes audience (OL-T14031)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${workflow_name} =      Create WF has capture complete task     Candidate
    # CLICK CANCEL WHEN CHANGE AUDIENCE
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}      ${RECRUITER}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Check element display on screen     ${WORKFLOW_CHANGE_AUDIENCE_POPUP_MESSAGE}
    Check text display      This change will update the audience receiving communications for this workflow.
    Check text display      Are you sure you want to change the audience?
    Capture Page Screenshot
    Click at    ${WORKFLOW_CHANGE_AUDIENCE_CANCEL_BUTTON}
    ${audience} =       Get value and format text       ${AUDIENCE_DROPDOWN}
    Should Be Equal As Strings      ${audience}     Candidate
    # CLICK CONFIRM WHEN CHANGE AUDIENCE
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}      ${RECRUITER}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Check element display on screen     ${WORKFLOW_CHANGE_AUDIENCE_POPUP_MESSAGE}
    Check text display      This change will update the audience receiving communications for this workflow.
    Check text display      Are you sure you want to change the audience?
    Capture Page Screenshot
    Click at    ${WORKFLOW_CHANGE_AUDIENCE_CONFIRM_BUTTON}
    ${audience} =       Get value and format text       ${AUDIENCE_DROPDOWN}
    Should Be Equal As Strings      ${audience}     ${RECRUITER}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify behavior when user changes audience in case the WF has multilingual (OL-T14032)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${workflow_name} =      Create WF has capture complete task     ${RECRUITER}
    # ADD SPANISH LANGUAGE
    Click at    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Click at    Spanish (es)
    Click at    ${AUDIENCE_DROPDOWN}
    Verify display text     ${LANGUAGE_PLEASE_NOTE_MESSAGE}
    ...     Please note that translations will be automatically made to the 1 language you have selected. You will be able to edit them in draft mode before you publish your content.
    Click at    ${LANGUAGE_PLEASE_NOTE_GOT_IT_BUTTON}
    Check element display on screen     ${WORKFLOW_MULTILINGUAL_LANGUAGE_TAB}       Spanish
    Click at    ${AUDIENCE_DROPDOWN}
    Check element display on screen     ${WORKFLOW_UPDATE_AUDIENCE_WARING_MESSAGE}
    ...     Please clean selected language before update Audience
    # CHECK ELEMENTS IN AUDIENCE IS DISABLE
    ${is_disabled} =    Run Keyword And Return Status       Click at    Candidate
    Should Be Equal As Strings      ${is_disabled}      False
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can Activate WF with audience is Hiring Team Roles (OL-T14034, OL-T14033)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${workflow_name} =      Create WF has capture complete task     ${RECRUITER}
    Active a Workflow       ${workflow_name}
    Click at    ${workflow_name}
    Check toggle is On      ${WORKFLOW_ACTIVE_TOGGLE}
    Check element display on screen     ${WORKFLOW_PUBLISHED_STATUS}
#   Verify user can delete WF with audience is Hiring Team Roles (OL-T14033)
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can Duplicate WF with audience is Hiring Team Roles (OL-T14035)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${workflow_name} =      Create WF has capture complete task     ${RECRUITER}
    Duplicate a Workflow    ${workflow_name}
    Verify display text with get text value     ${WORKFLOW_NAME_TEXT_BOX}       Copy of ${workflow_name}
    ${audience} =       Get value and format text       ${AUDIENCE_DROPDOWN}
    Should Be Equal As Strings      ${audience}     ${RECRUITER}
    Delete Workflow data tests after run test case      Copy of ${workflow_name}
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can publish WF with audience is Hiring Team Roles (OL-T14036)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    ${workflow_name} =      Create WF has capture complete task     ${RECRUITER}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Check toggle is On      ${WORKFLOW_ACTIVE_TOGGLE}
    Check element display on screen     ${WORKFLOW_PUBLISHED_STATUS}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Send Communication action with Immediately trigger off + audience is User Role (OL-T14123)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${CP_ADMIN}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${WF_SEND_COMMUNICATION}
    Input subject and content for trigger send communication
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${task_random_name}
    Turn off    ${START_POINT_TIMED_TOGGLE}
    Input into      ${START_POINT_TIME_TEXT_BOX}    10
    Click at    ${START_POINT_TIME_UNIT_DROPDOWN}
    Verify all start point time is displayed    @{start_point_time_list}
    Capture Page Screenshot
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Send Communication action with Immediately trigger off + audience is Hiring Team Role (OL-T14124)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${RECRUITER}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${WF_SEND_COMMUNICATION}
    Input subject and content for trigger send communication
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${task_random_name}
    Turn off    ${START_POINT_TIMED_TOGGLE}
    Input into      ${START_POINT_TIME_TEXT_BOX}    10
    Click at    ${START_POINT_TIME_UNIT_DROPDOWN}
    Verify all start point time is displayed    @{start_point_time_list}
    Capture Page Screenshot
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Capture Page Screenshot
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Delay action + audience is Hiring Team Role (OL-T14125)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Generate random name    auto_workflow
    Input into      ${WORKFLOW_NAME_TEXT_BOX}       ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}      Recruiter
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into      ${JOURNEY_SEARCH_TEXT_BOX}      Default Candidate Journey
    Click at    Default Candidate Journey
    # ADD SEND COMMUNICATION
    ${task_random_name} =       Add a Send communication Action into Workflow       Capture Complete
    Add trigger send communication      ${WF_SEND_COMMUNICATION}
    Click at    ${ADD_TRIGGER_BUTTON}\[2\]
    Click at    ${DELAY_ACTION}
    Input into      ${TASK_DELAY_TEXT_BOX}      10
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Delete Workflow data tests after run test case      ${workflow_name}


Workflow Builder - Verify user can add Delay action + audience is User Role (OL-T14126)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Generate random name    auto_workflow
    Input into      ${WORKFLOW_NAME_TEXT_BOX}       ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}      ${CP_ADMIN}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into      ${JOURNEY_SEARCH_TEXT_BOX}      Default Candidate Journey
    Click at    Default Candidate Journey
    # ADD SEND COMMUNICATION
    ${task_random_name} =       Add a Send communication Action into Workflow       Capture Complete
    Add trigger send communication      ${WF_SEND_COMMUNICATION}
    Click at    ${ADD_TRIGGER_BUTTON}\[2\]
    Click at    ${DELAY_ACTION}
    Input into      ${TASK_DELAY_TEXT_BOX}      10
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Delete Workflow data tests after run test case      ${workflow_name}

*** Keywords ***
Add name and add audience for workflow
    [Arguments]     ${audience}
    ${workflow_name} =      Generate random name    auto_workflow
    Input into      ${WORKFLOW_NAME_TEXT_BOX}       ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}      ${audience}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into      ${JOURNEY_SEARCH_TEXT_BOX}      ${CJ_WORKFLOW}
    Click at    ${CJ_WORKFLOW}
    wait element visible    ${WORKFLOW_LANGUAGES_DROPDOWN}
    [Return]       ${workflow_name}

Create WF has capture complete task
    [Arguments]    ${user_role}
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =      Add name and add audience for workflow      ${user_role}
    ${task_random_name} =       Add a Task into Workflow    ${CAPTURE_COMPLETE}     ${WF_SEND_COMMUNICATION}
    Input subject and content for trigger send communication
    Click at    ${SAVE_TASK_BUTTON}
    Check element display on screen     ${task_random_name}
    Capture Page Screenshot
    [Return]    ${workflow_name}

Verify all start point time is displayed
    [Arguments]    @{start_point_time_list}
    FOR    ${start_point_time}    IN    @{start_point_time_list}
        Check element display on screen     ${START_POINT_TIME_UNIT_VALUE}      ${start_point_time}
    END

Add trigger send communication
    [Arguments]    ${trigger_item_text}
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${WF_ADD_TASK_TRIGGER_ITEM}   ${trigger_item_text}
    Input subject and content for trigger send communication

Input subject and content for trigger send communication
    Input into      ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    auto_mail_subject
    # Test for Email Tab
    Input into      ${EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    auto_text_email
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into      ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}      auto_text_sms

Add condition action send communication
    [Arguments]    ${condition_name}     ${index}
    Click at    ${ADD_CONDITION_ADD_ITEM_ACTION_BUTTON}     ${condition_name}
    Click at    ${ADD_CONDITION_ACTION_VALUE}       ${WF_SEND_COMMUNICATION}
    Input subject and content when task have many send communication       ${index}

Input subject and content when task have many send communication
    [Arguments]    ${index}
    # Test for Email Tab
    Input into      ${WF_EMAIL_OLIVIA_SUBJECT_TEXT_BOX_BY_INDEX}    auto_mail_subject      ${index}
    Input into      ${WF_EMAIL_OLIVIA_CONTENT_TEXT_BOX_BY_INDEX}    auto_text_email     ${index}
    # Test for SMS Tab
    Click at    ${WF_SMS_OLIVIA_EDITOR_TAB_BY_INDEX}     ${index}
    Input into      ${WF_SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA_BY_INDEX}      auto_text_sms     ${index}

Add trigger when task have many send communication
    [Arguments]    ${index}
    Click at    ${ADD_TRIGGER_BUTTON}\[2\]
    Click at    ${WF_ADD_TASK_TRIGGER_ITEM}\[2\]   ${WF_SEND_COMMUNICATION}
    Input subject and content when task have many send communication    ${index}
