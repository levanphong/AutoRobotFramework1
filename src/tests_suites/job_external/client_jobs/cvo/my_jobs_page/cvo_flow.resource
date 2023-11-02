*** Settings ***
Resource            ../../../../../drivers/driver_chrome.robot
Resource            ../../../../../pages/my_jobs_page.robot
Resource            ../../../../../pages/conversation_page.robot
Resource            ../../../../../pages/candidate_volume_optimizer_page.robot
Resource            ../../../../../pages/all_candidates_page.robot
Resource            ../../../../../pages/offers_page.robot

Documentation       Run `src/data_tests/job_external/client_job/cvo/cvo_flow.robot`

*** Variables ***
${job_family_name}           ${JF_COFFEE_FAMILY_JOB}
${job_location}              ${CONST_LOCATION}
${ats_job_location}          ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
${ats_job_state}             ${AREA_NAME_SOUTH_BURLINGTON}

*** Keywords ***
Clear Candidates in job
    [Arguments]     ${job_name}     ${job_type}=Internal     ${job_state_location}=False
    ${test_location} =  Set variable    ${job_location}
    IF  '${job_type}' == 'External'
        ${test_location} =  Set variable    ${ats_job_location}
        IF  '${job_state_location}' != 'False'
            ${test_location} =  Set variable    ${ats_job_state}
        END
    END
    IF    "Empty Threshold" not in "${job_name}"
        Deactivate a job  ${job_name}  ${test_location}
        Capture page screenshot
        Active a job  ${job_name}  ${test_location}
        Capture page screenshot
    ELSE
        Search job by location and job name     ${job_name}      ${test_location}
    END
    [Return]    ${test_location}

Apply a Candidate to job for Landing site
    [Arguments]    ${job_name}    ${company_name}
    ${company_name} =    Evaluate    "${company_name}".replace(" ","")
    ${job_number} =    extract_numbers    ${job_name}
    Go to conversation and show jobs    ${CONFIG.site_url}/co/${company_name}    PAT${job_number}[0]
    Apply job on landing site    ${job_name}
    Candidate input to landing site     hello
    ${candidate_info} =      Generate candidate name
    &{email_info} =    Get email for testing
    Input candidate name twice    ${candidate_info.full_name}
    Candidate input to landing site    ${email_info.email}

Apply a Candidate to job for Widget
    [Arguments]     ${job_name}
    ${job_apply_link} =    Get job apply link   ${job_name}
    Go to   ${job_apply_link}
    Capture page screenshot
    Input common info for candidate to apply job

Add a Candidate to job via CEM
    [Arguments]     ${location}=None     ${job_name}=None    ${job_req_id}=None     ${is_spam_email}=True
    Go to CEM page
    ${candidate_name} =     Add a Candidate    location_name=${location}    job_name=${job_name}    job_req_id=${job_req_id}    is_spam_email=${is_spam_email}
    [Return]    ${candidate_name}

Input common info for candidate to apply job
    # Apply a Candidate to job for Widget
    ${candidate_info} =      Generate candidate name
    &{email_info} =    Get email for testing
    Input candidate name twice for Shadow Root    ${candidate_info.full_name}
    Input text for widget site    ${email_info.email}

Prepare job for testing
    [Arguments]     ${job_type}     ${job_name}     ${job_state_location}=False
    # Reset Job to default
    ${test_location} =  Clear Candidates in job     ${job_name}     ${job_type}     ${job_state_location}
    [Return]    ${test_location}

Apply candidate and check Hiring Manager is noticed
    [Arguments]     ${job_location}    ${job_name}     ${threshold_status}    ${company_name}=None
    IF    '${env}' in ['LOWES', 'LOWES_STG'] and '${company_name}' != 'None'
        Apply a Candidate to job for Landing site    ${job_name}    ${company_name}
    ELSE
        Apply a Candidate to job for Widget    ${job_name}
    END
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}

Update conversation status following threshold status
    [Arguments]     ${candidate_name}     ${conversation_status}    ${threshold_status}    ${company_name}=None
    Logout and Login with user role    ${CP_ADMIN}
    IF  '${conversation_status}' == 'Offer'
        Change conversation status  ${candidate_name}    ${conversation_status}    ${threshold_status}
        Click at    ${CONFIRM_OFFER_START_DATE}
        Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
        Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
        Press Keys    None    1
        Click at    Send offer
        # Accept Offer
        Click button in email  Respond to your job offer at ${company_name}  ${candidate_name}  OFFER
        ${verify_code} =    Get verify code in email  Your ${company_name} Verification Code  ${candidate_name}  VERIFICATION_CODE
        ${single_code} =    Get Regexp Matches    ${verify_code}    [0-9]
        FOR  ${i}  IN RANGE  6
            ${locator_code}=  format string   ${LOGIN_CODE_INPUT}  ${i+1}
            Input into  ${locator_code}  ${single_code}[${i}]
        END
        Capture page screenshot
        Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
        Check element display on screen  Your offer has been accepted. We will reach out with next steps soon
        Capture page screenshot
    ELSE
        Updated conversation status  ${candidate_name}   ${conversation_status}   ${threshold_status}
        IF  '${conversation_status}' == 'Scheduling'
            # In manual schedule case
            ${manual_interview} =   Run keyword and return status   Check element display on screen  ${INTERVIEW_SCHEDULE_TYPE}    wait_time=2s
            IF  ${manual_interview}
                Click at    ${INTERVIEW_SCHEDULE_TYPE}
                check element display on screen     ${INTERVIEWER_BUTTON}
                Click at    ${INTERVIEWER_BUTTON}
                Select interviewers for sub-interviews     ${CA_TEAM}
                Send interview and click close button
            END
            # Candidate accept
            Click button in email   ${company_name} would like to schedule a phone interview   ${candidate_name}    WOULD_LIKE_SCHEDULE_PHONE_ITV
            Click at    Select
            Input into    ${CONVERSATION_INPUT_TEXTBOX}    ${CONST_PHONE_NUMBER}
            Click at    ${CONVERSATION_SEND_BUTTON}
        END
    END
    Capture page screenshot

Check Notification of Hiring Manage when job met threshold
    [Arguments]    ${job_name}
    # Check Hiring team has notify about assigned job
    Click at  ${NOTIFICATION_ICON}
    # Notification can be combine, firstly check the notify is in Group or not
    ${is_combine_notify} =    Run keyword and return status    Check element display on screen     ${NOTIFICATION_CHILD_ITEM}  ${job_name}: Threshold is reached, please turn the job off manually    wait_time=2s
    Run keyword unless    ${is_combine_notify}    Click at  ${JOB_REQUISITIONS_NOTIFICATION_ITEM}
    Capture page screenshot

# --- Combine test cases keywords ---
Check Hiring Manager is noticed when matched threshold
    [Arguments]     ${test_location}     ${job_name}     ${threshold_status}    ${candidate_number}=1
    # Check banner of job when Threshold is reached
    search job in location  ${job_name}  ${test_location}
    Check element display on screen  Notification Sent: ${candidate_number} Candidate(s) Reached ${threshold_status}
    Capture page screenshot
    Logout and Login with user role    ${CP_ADMIN}
    Check Notification of Hiring Manage when job met threshold    ${job_name}
    Click at    ${NOTIFICATION_CHILD_ITEM}  ${job_name}: Threshold is reached, please turn the job off manually
    Check element not display on screen    ${NOTIFICATION_CHILD_ITEM}  ${job_name}: Threshold is reached, please turn the job off manually

Check Hiring Manager is turn off when met threshold
    [Arguments]     ${test_location}     ${job_name}     ${threshold_status}    ${candidate_number}=1
    # Check banner of job when Threshold is reached
    search job in location  ${job_name}  ${test_location}
    Verify text contain  ${JOB_THRESHOLDS_NOTIFY}  Job closed because ${candidate_number} candidates reached ${threshold_status}
    Capture page screenshot
    Logout and Login with user role    ${CP_ADMIN}
    Check Notification of Hiring Manage when job met threshold    ${job_name}
    Click at    ${NOTIFICATION_CHILD_ITEM}  ${job_name}: Threshold Met, Job Turned Off
    Check element not display on screen    ${NOTIFICATION_CHILD_ITEM}  ${job_name}: Threshold Met, Job Turned Off

Check Hiring Manager not receive notify and job doesn't has any limited
    [Arguments]     ${test_location}    ${job_name}     ${threshold_status}
    search job in location  ${job_name}  ${test_location}
    # Check job still ON
    ${status_job}=    run keyword and return status     Check toggle is On     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}    ${job_name}
    Run Keyword Unless    ${status_job}    Fail
    Capture page screenshot
    # Check the Job does has status related to Segment
    Check element not display on screen  Notification Sent: 1 Candidate(s) Reached ${threshold_status}
    Capture page screenshot
    # Check Hiring team doesn't has notify about assigned job
    Click at  ${NOTIFICATION_ICON}
    Check element not display on screen  ${job_name}: Threshold
    Capture page screenshot

Apply candidate and check nothing happens
    [Arguments]     ${job_location}    ${job_name}     ${threshold_status}
    Apply a Candidate to job for Widget    ${job_name}
    Check Hiring Manager not receive notify and job doesn't has any limited      ${job_location}    ${job_name}     ${threshold_status}

