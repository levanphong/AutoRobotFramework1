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
Check the Candidate Volume Optimizer toggle is added to Client setup when ATS Job Feed Manager is ON (OL-T11738, OL-T11737)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Client setup page
    Click at    ${HIRE_LABEL}
    Check element display on screen  Olivia Hire
    Turn on  ${ATS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE}
    Wait with short time    # Need to wait for a short time here, can't find other way
    Mouse Over  ${ATS_JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_ICON_TOOLTIP}
    Verify text contain  ${ATS_JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_TOOLTIP}  This feature limits the number of candidates in any stage of the hiring process.
    Capture page screenshot
    # Check the Candidate Volume Optimizer toggle is added to Client setup when Job internal is ON (T11737)
    Switch to Company v2  ${COMPANY_FRANCHISE_ON}
    Turn on  ${JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE}
    Wait with short time    # Need to wait for a short time here for loading a tab of Client Setup, can't find other way
    Mouse Over  ${JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_ICON_TOOLTIP}
    Verify text contain  ${JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_TOOLTIP}  This feature limits the number of candidates in any stage of the hiring process.
    Capture page screenshot


Check the Candidate Volume Optimizer page when ATS master feed is ON (OL-T11742)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Check default display of Base page of CVO


Check the Candidate Volume Optimizer page when Job Internal is ON (OL-OL-T11739)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check default display of Base page of CVO


Check the default Candidate Volume Optimize in case ATS master feed (OL-OL-T11744, OL-T11741)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Check Default Segment   ATS Job
    # OL-T11741
    Switch to company v1  ${COMPANY_FRANCHISE_ON}
    Check Default Segment   Jobs

*** Keywords ***
Check Default Segment
    [Arguments]  ${job_type}
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
    Check element display on screen  Job Code
    Check element display on screen  Job Title
    Check element display on screen  Job City
    Check element display on screen  Job State
    Check element display on screen  Job Country
    IF  '${job_type}' == 'ATS Job'
        Check element display on screen  Job Req ID
        Check element display on screen  Internal Job
        Check element display on screen  Job Country Code
        Check element display on screen  Job State Code
        Check element display on screen  Job Employment Type
        Check element display on screen  Job Employment Status
        Check element display on screen  Department Code
        Check element display on screen  Job Category
    END
    Capture page screenshot
    Press Keys    None    ESC

Check default display of Base page of CVO
    Go to Candidate Volume Optimizer page
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  All
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  Active
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  Drafts
    Check element display on screen  ${CVO_NAV_STATUS_TAB}  Inactive
    # Count of each status display
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  All
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  Active
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  Drafts
    Check element display on screen  ${CVO_NAV_STATUS_COUNT_NUMBER}  Inactive
    Capture page screenshot
