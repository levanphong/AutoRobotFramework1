*** Settings ***
Resource            ../../../../../drivers/driver_chrome.robot
Resource            ../../../../../pages/client_setup_page.robot
Resource            ../../../../../pages/my_jobs_page.robot
Resource            ../../../../../pages/conversation_page.robot
Resource            ../../../../../pages/candidate_volume_optimizer_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        lts_stg    regression    stg    olivia    birddoghr    lowes    lowes_stg    mchire    darden    advantage

Documentation       Run `src/data_tests/job_external/client_job/cvo/cvo.robot`

*** Variables ***
${cvo_limit_job_id}     ${AUTOMATION_TESTER_REQ_ID_029}
${cvo_limit_job_name}     ${AUTOMATION_TESTER_TITLE_029}
${cvo_unlimited_job_id}     ${AUTOMATION_TESTER_REQ_ID_014}
${cvo_unlimited_job_name}     ${AUTOMATION_TESTER_TITLE_014}
${normal_job_id_1}     ${AUTOMATION_TESTER_REQ_ID_041}
${normal_job_id_2}     ${AUTOMATION_TESTER_REQ_ID_015}
${cvo_limit_number}     ${3}

*** Test Cases ***
Check creating a Candidate volume optimizer has draft status (OL-T11751, OL-T11748, OL-T11752)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    # Input Details & Targeting
    ${segment_name} =   Generate random name  auto_segment
    Click at  ${CVO_NEW_SEGMENT_BUTTON}
    Input into  ${SEGMENT_DETAIL_NAME_TEXTBOX}  ${segment_name}
    Click at  ${SEGMENT_DETAIL_TARGETING_RULES_DROPDOWN}
    Click at  Job Req ID
    Click at  ${SEGMENT_DETAIL_MATCHES_DROPDOWN}
    Click at  Exactly matches
    Input into  ${SEGMENT_DETAIL_TARGETING_INPUT_TEXTBOX}  ${normal_job_id_1}
    # Check can move to Screen Thresholds tab (T11748)
    Click at  ${SEGMENT_DETAIL_NEXT_BUTTON}
    # Check UI of Screen Thresholds tab (T11752)
    Click at  ${SEGMENT_THRESHOLDS_ADD_BUTTON}
    Check element display on screen  Select a Status to Build a Threshold On
    Check element display on screen  Set a Threshold for Number of Candidates to Reach the Selected Status
    Check element display on screen  Determine the Action that Occurs when the Threshold is Met
    Capture page screenshot
    Click at  ${SEGMENT_THRESHOLDS_STATUS_DROPDOWN}
    Click at  Capture
    Click at  Conversation In-Progress
    Input into  ${SEGMENT_THRESHOLDS_NUMBER_TEXTBOX}  0
    Check element display on screen  Please enter a value greater than or equal to 1
    Capture page screenshot
    Input into  ${SEGMENT_THRESHOLDS_NUMBER_TEXTBOX}  10000
    Check element display on screen  Please enter a value less than or equal to 1000
    Capture page screenshot
    Click at  ${SEGMENT_THRESHOLDS_ACTION_DROPDOWN}
    Check element display on screen  Olivia will Turn the Job Off
    Check element display on screen  Olivia Will Notify the Hiring Team
    Capture page screenshot
    # Back to Base page and check new segment is draft
    Go to Candidate Volume Optimizer page
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_name}
    Check element display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  Draft
    Capture page screenshot
    # Delete a Job Segment
    Delete a Job Segment    ${segment_name}


Check cretate a Candidate volume optimizer is success (OL-T11753, OL-T11760, OL-T11759, OL-T11757, OL-T11756, OL-T11754, OL-T11755, OL-T11758)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    # Input Details & Targeting
    ${segment_name} =   Generate random name  auto_segment
    Add a default Job Segment     ${segment_name}     ${normal_job_id_2}
    # Back to Base page and check new segment is Active
    Go to Candidate Volume Optimizer page
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_name}
    Check element display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  Active
    Capture page screenshot
    # Edit Thresholds in Segment (T11756, T11754)
    Click at  ${segment_name}
    # T11758
    Click at  ${SEGMENT_DETAIL_SETTINGS_BUTTON}
    Check element display on screen  ${SEGMENT_DETAIL_SETTINGS_DEACTIVATE_BUTTON}
    Check element display on screen  ${SEGMENT_DETAIL_SETTINGS_DELETE_BUTTON}
    Check element display on screen  ${SEGMENT_DETAIL_SETTINGS_ACTION_INFO}
    Capture page screenshot
    Click at  Status Thresholds
    Click at  Edit Threshold
    Input into  ${SEGMENT_THRESHOLDS_NUMBER_TEXTBOX}  5
    Click at  ${SEGMENT_THRESHOLDS_SAVE_BUTTON}
    Verify text contain  ${SEGMENT_EDIT_THRESHOLDS_POPUP_TEXT}  By choosing to confirm this action, 1 Requisition will have their Conversation In-Progress threshold updated.Jobs currently on will not receive the threshold until they are tunred on again in the future. Are you sure you’d like to continue?
    Capture page screenshot
    Click at  ${SEGMENT_THRESHOLDS_CONFIRM_EDIT_CHANGED_BUTTON}
    # Can edit to a lower number (T11755)
    Click at  Edit Threshold
    Input into  ${SEGMENT_THRESHOLDS_NUMBER_TEXTBOX}  1
    Click at  ${SEGMENT_THRESHOLDS_SAVE_BUTTON}
    Verify text contain  ${SEGMENT_EDIT_THRESHOLDS_POPUP_TEXT}  By choosing to confirm this action, 1 Requisition will have their Conversation In-Progress threshold updated.Jobs currently on will not receive the threshold until they are tunred on again in the future. Are you sure you’d like to continue?
    Capture page screenshot
    Click at  ${SEGMENT_THRESHOLDS_CONFIRM_EDIT_CHANGED_BUTTON}
    # Delete Thresholds in Segment (T11757)
    Click at  ${SEGMENT_THRESHOLDS_DELETE_BUTTON}
    Check element display on screen  No Status Thresholds Have Been Set
    Check element display on screen  ${SEGMENT_THRESHOLDS_ADD_BUTTON}
    Capture page screenshot
    # Deactivate a Job Segment (T11759)
    Go to Candidate Volume Optimizer page
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_name}
    Click at  ${CVO_SEGMENT_ECLIPSE_BUTTON}
    Click at  ${CVO_SEGMENT_ECLIPSE_MENU_DEACTIVATE_BUTTON}
    Check element display on screen  Are you sure you want to deactivate this segment? By choosing to confirm this action,
    Check element display on screen  Job Requisitions will not have threshold values on any status.
    Capture page screenshot
    Click at  ${CVO_SEGMENT_ECLIPSE_MENU_CONFIRM_DEACTIVATE_BUTTON}
    Check element display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  Inactive
    Capture page screenshot
    Hover at  ${CVO_SEGMENT_LIST_CELL_VALUE}  Inactive
    Verify text contain  ${CVO_SEGMENT_INACTIVE_TOOLTIP}    All Requisitions in an 'Inactive' Status will be placed in the 'Default' Segment until made active again.
    Capture page screenshot
    # Delete a Job Segment (T11760)
    Delete a Job Segment    ${segment_name}


Check Targeting rule which has requisition that already config at other CVO (OL-T11765)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    # Input Details & Targeting
    ${segment_name} =   Generate random name  auto_segment
    Click at  ${CVO_NEW_SEGMENT_BUTTON}
    Input into  ${SEGMENT_DETAIL_NAME_TEXTBOX}  ${segment_name}
    Click at  ${SEGMENT_DETAIL_TARGETING_RULES_DROPDOWN}
    Click at  Job Req ID
    Click at  ${SEGMENT_DETAIL_MATCHES_DROPDOWN}
    Click at  Exactly matches
    Input into  ${SEGMENT_DETAIL_TARGETING_INPUT_TEXTBOX}  ${cvo_limit_job_id}
    Check element display on screen  These targeting rules include requisitions that are already targeted.
    Capture page screenshot


Check the Candidate Volume Optimizer page when ATS master feed is ON CVO (OL-T11766, OL-T11745, OL-T11761)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  All
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  Active
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  Drafts
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  Inactive
    # Count of each status display (T11761)
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  All
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  Active
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  Drafts
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  Inactive
    Capture page screenshot


Check the default Candidate Volume Optimize in case ATS master feed (OL-T11768)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    Click at  Default
    # Check 2 default targeting message
    Check element display on screen  The Default Segment will act as a catch-all and apply to all requisitions that do not match targeting from additional segments.
    Check element display on screen  The Default Segment will have no thresholds on any status.
    Capture page screenshot
    # Check disabled items
    Verify element is disabled by checking class  ${SEGMENT_DETAIL_NEXT_BUTTON}
    Capture page screenshot
    # Check job detail columns
    Click at  requisitions targeted
    Check element display on screen  Job Req ID
    Check element display on screen  Job Code
    Check element display on screen  Job Title
    Check element display on screen  Job Category
    Check element display on screen  Department Code
    Check element display on screen  Job Employment Type
    Check element display on screen  Job Employment Status
    Check element display on screen  Job City
    Check element display on screen  Job State
    Check element display on screen  Job State Code
    Check element display on screen  Job Country
    Check element display on screen  Job Country Code
    Check element display on screen  Internal Job
    Capture page screenshot


Check the result targeting rule is correctly (OL-T11750, OL-T11749)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    Click at  ${CVO_NEW_SEGMENT_BUTTON}
    # Check base UI (T11749)
    Check element display on screen  Add Conditions to Target Job Requisitions
    Capture page screenshot
    # Check conditional role
    Check element display on screen  ${SEGMENT_DETAIL_CONDITIONAL_RULE_AND}
    Check element display on screen  ${SEGMENT_DETAIL_CONDITIONAL_RULE_OR}
    Capture page screenshot
    # Check target rules display
    Click at  ${SEGMENT_DETAIL_TARGETING_RULES_DROPDOWN}
    Check element display on screen  Job Req ID
    Check element display on screen  Restaurant Name
    Check element display on screen  Job Code
    Check element display on screen  Job Title
    Check element display on screen  Job Category
    Check element display on screen  Department Code
    Check element display on screen  Job Employment Type
    Check element display on screen  Job Employment Status
    Capture page screenshot
    # Check Matches display
    Click at  ${SEGMENT_DETAIL_MATCHES_DROPDOWN}
    Check element display on screen  Exactly matches
    Check element display on screen  Starts with
    Check element display on screen  Does not start with
    Check element display on screen  Contains
    Check element display on screen  Does not contain
    Check element display on screen  Ends with
    Check element display on screen  Does not end with
    Capture page screenshot

*** Keywords ***
