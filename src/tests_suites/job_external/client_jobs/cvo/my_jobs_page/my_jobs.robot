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
${normal_job_id}     ${AUTOMATION_TESTER_REQ_ID_041}
${cvo_limit_number}     ${3}

*** Test Cases ***
Check UI at my in case Only has the default Candidate volume Optimizer (OL-T11769, OL-T11770, OL-T11774, OL-T11775, OL-T11771)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to My Jobs page
    # Turn off and turn on job again to clear Candidate
    # T11775
    Deactivate a job  ${cvo_limit_job_name}  ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
    # T11770, T11771
    Check CVO popup when Turn On job  ${cvo_limit_job_name}
    Capture page screenshot
    # Check job without CVO
    Input into    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${normal_job_id}
    Check element not display on screen  ${JOB_SORT_DESCRIPTION}    wait_time=2s
    Capture page screenshot
    # Apply 3 candidates to job to reach the limit (T11774)
    Input into    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${cvo_limit_job_id}
    Apply a Candidate to job    ${cvo_limit_job_name}
    Input text for widget site  new
    Input common info for candidate to apply job
    Input text for widget site  new
    Input common info for candidate to apply job
    # Check job Turn off after reach limit candidate
    Search job in location  ${cvo_limit_job_id}     ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
    ${toggle_status} =  Get toggle status  ${JOB_FOR_ACTIVE_TOGGLE}    ${cvo_limit_job_name}
    Run keyword if  ${toggle_status}    Fail
    Verify text contain  ${JOB_THRESHOLDS_NOTIFY}  Job closed because ${cvo_limit_number} candidates reached Conversation In-Progress
    Capture page screenshot


Verify Saving the threshold at the Client Success manager popup is success when user leaves threshold value empty then add thresholds value in My Jobs (OL-T11773, OL-T11772)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Candidate Volume Optimizer page
    # Add an unlimited Segment
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${cvo_unlimited_job_id}
    ${is_exist} =   Run keyword and return status   Check element display on screen  ${cvo_unlimited_job_id}  wait_time=2s
    Run keyword if  ${is_exist}     Delete a Job Segment    ${cvo_unlimited_job_id}
    Add a default Job Segment     ${cvo_unlimited_job_id}
    # Apply a candidate to job
    Search job in location  ${cvo_unlimited_job_id}     ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
    Apply a Candidate to job  ${cvo_unlimited_job_name}
    # Verify job description update following number of candidate apply
    Search job in location  ${cvo_unlimited_job_id}     ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
    Click at    ${cvo_unlimited_job_name}
    Input into  ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}   ${cvo_limit_number}
    Click at  ${JOB_THRESHOLDS_SAVE_BUTTON}
    Click at    ${cvo_unlimited_job_name}
    # Limit candidate number is 3, and always show 3 in threshold number
    ${remain_candidates} =    Verify display text with get text value    ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}    3
    Capture page screenshot

*** Keywords ***
Apply a Candidate to job
    [Arguments]     ${job_name}
    ${job_apply_link} =    Get job apply link   ${job_name}
    Go to   ${job_apply_link}
    Capture page screenshot
    Input common info for candidate to apply job

Input common info for candidate to apply job
    # Apply a candidate to job
    ${candidate_info} =      Generate candidate name
    Input candidate name twice for Shadow Root    ${candidate_info.full_name}
    &{email_info} =    Get email for testing
    Input text for widget site    ${email_info.email}

Check CVO popup when Turn On job
    [Arguments]     ${job_name}
    # Check job display, search job if it not display
    ${is_job_display} =     Run keyword and return status   Check element display on screen     ${job_name}     wait_time=5s
    run keyword if  '${is_job_display}' == 'False'  Input into    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${job_name}
    wait_for_loading_icon_disappear
    # Activate job
    ${toggle_status} =   Turn on     ${JOB_FOR_ACTIVE_TOGGLE}    ${job_name}
    # Check CVO popup
    Verify text contain    ${MY_JOB_DETAIL_CAPTURE_COMPLETE_TEXT}    candidates reach Conversation In-Progress.
    # Check max limit of Candidate that user can input
    Clear element text with keys    ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}
    Click at    ${JOB_THRESHOLDS_SAVE_BUTTON}
    Check element display on screen  Hiring Goal is a required field.
    Capture page screenshot
    Input into  ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}   0
    Click at    ${JOB_THRESHOLDS_SAVE_BUTTON}
    Check element display on screen  Required Value Between 1 and 1,000.
    Capture page screenshot
    Input into  ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}   1111
    Click at    ${JOB_THRESHOLDS_SAVE_BUTTON}
    Check element display on screen  Required Value Between 1 and 1,000.
    Capture page screenshot
    Input into  ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}   3
    Click at    ${JOB_THRESHOLDS_SAVE_BUTTON}
    Capture page screenshot
