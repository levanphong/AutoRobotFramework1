*** Settings ***
Resource            ../../../../drivers/driver_chrome.robot
Resource            ../../../../pages/client_setup_page.robot
Resource            ../../../../pages/my_jobs_page.robot
Resource            ../../../../pages/conversation_page.robot
Resource            ../../../../pages/candidate_volume_optimizer_page.robot
Resource            ../../../../pages/jobs_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Documentation   ${COMPANY_DATA_PACKAGE_OFF} ${COMPANY_APPLICANT_FLOW} ${COMPANY_LOCATION_MAPPING_OFF} Add a Offer: CVO Offer for testing
        ...     ${COMPANY_DATA_PACKAGE_OFF} ${COMPANY_APPLICANT_FLOW} ${COMPANY_LOCATION_MAPPING_OFF} Set up a Candidate Journey with Event, Orientation Event, Offer stage
        ...     ${COMPANY_DATA_PACKAGE_OFF} ${COMPANY_APPLICANT_FLOW} ${COMPANY_LOCATION_MAPPING_OFF} Add a Rating: CVO Rating for testing
        ...     ${COMPANY_DATA_PACKAGE_OFF} ${COMPANY_APPLICANT_FLOW} ${COMPANY_LOCATION_MAPPING_OFF} Add a Workflow: CVO Workflow for testing
        ...     ${COMPANY_DATA_PACKAGE_OFF} ${COMPANY_APPLICANT_FLOW} ${COMPANY_LOCATION_MAPPING_OFF} Set new Applicant Flow for PAT024 with CA Team in Attendee
        ...     ${COMPANY_DATA_PACKAGE_OFF} Create CVO conversation, assign into Job Posting Web management
        ...     ${COMPANY_DATA_PACKAGE_OFF} create CA Team, add user into Team Location
        ...     ${COMPANY_LOCATION_MAPPING_OFF} create CA Team, Turn On `Requisition Based Permissions` in More. Add ATS jobs below
        ...     ${COMPANY_LOCATION_MAPPING_OFF} Add Offer step in Applicant flow
        ...     ${COMPANY_LOCATION_MAPPING_OFF} Client Setup > More > Turn On `Add Candidate: Display Requisition Option`

*** Variables ***
${cvo_limit_job_id}     ${AUTOMATION_TESTER_REQ_ID_029}
${cvo_limit_job_name}     ${AUTOMATION_TESTER_TITLE_029}
${cvo_unlimited_job_id}     ${AUTOMATION_TESTER_REQ_ID_014}
${cvo_unlimited_job_name}     ${AUTOMATION_TESTER_TITLE_014}
${normal_job_id}     ${AUTOMATION_TESTER_REQ_ID_041}
${cvo_limit_number}     ${3}
${cvo_offer_name}     CVO Offer for testing

${job_family_name}           Coffee family job
${job_location}              ${CONST_LOCATION}
${ats_job_location}          ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
${ats_job_state}             ${AREA_NAME_SOUTH_BURLINGTON}

${segment_target_rule}  Job Title
${segment_target_exact_match_rule}  Exactly matches
${threshold_notify_action}  Olivia Will Notify the Hiring Team

# Notify job to Hiring team threshold
${capture_in_progress_job_name}     CVO Conversation In-Progress Job
${capture_in_progress_segment_name}     CVO CIP Segment
${capture_complete_job_name}     CVO Capture Complete Job
${capture_complete_segment_name}     CVO CC Segment
${invite_to_event_interview_job_name}     CVO Invite to Event Interview Job
${invite_to_event_interview_segment_name}     CVO InviteToEInterview Segment
${offer_accepted_job_name}     CVO Offer Accepted Job
${offer_accepted_segment_name}     CVO OA Segment
${interview_scheduled_job_name}     CVO Interview Scheduled Job
${interview_scheduled_segment_name}     CVO IS Segment
${orientation_event_job_name}     CVO No Event Availability Job
${orientation_event_segment_name}     CVO NEA Segment
${change_threshold_value_job_name}     CVO Change Threshold Value Job
${change_threshold_value_segment_name}     CVO ChangeThresholdValue Segment

${capture_in_progress_ats_job_name}     ${AUTOMATION_TESTER_TITLE_035}
${capture_in_progress_ats_segment_name}     CVO CIP ATS Segment
${capture_complete_ats_job_name}     ${AUTOMATION_TESTER_TITLE_036}
${capture_complete_ats_segment_name}     CVO CC ATS Segment
${invite_to_event_interview_ats_job_name}     ${AUTOMATION_TESTER_TITLE_037}
${invite_to_event_interview_ats_segment_name}     CVO InviteToEInterview ATS Segment
${interview_scheduled_ats_job_name}     ${AUTOMATION_TESTER_TITLE_024}
${interview_scheduled_ats_segment_name}     CVO IS ATS Segment
${orientation_event_ats_job_name}     ${AUTOMATION_TESTER_TITLE_026}
${orientation_event_ats_segment_name}     CVO NEA ATS Segment
${offer_accepted_ats_job_name}     ${AUTOMATION_TESTER_TITLE_028}
${offer_accepted_ats_segment_name}     CVO OA ATS Segment

# Turn off job threshold
${capture_in_progress_job_name_2}     CVO Conversation In-Progress Job 2
${capture_in_progress_segment_off_job_name}     CVO CIP Segment Off Job
${capture_complete_job_name_2}     CVO Capture Complete Job 2
${capture_complete_segment_off_job_name}     CVO CC Segment Off Job
${invite_to_event_interview_job_name_2}     CVO Invite to Event Interview Job 2
${invite_to_event_interview_segment_off_job_name}     CVO InviteToEInterview Segment Off Job
${offer_accepted_job_name_2}     CVO Offer Accepted Job 2
${offer_accepted_segment_off_job_name}     CVO OA Segment Off Job
${interview_scheduled_job_name_2}     CVO Interview Scheduled Job 2
${interview_scheduled_segment_off_job_name}     CVO IS Segment Off Job
${orientation_event_job_name_2}     CVO No Event Availability Job 2
${orientation_event_segment_off_job_name}     CVO NEA Segment Off Job

*** Test Cases ***
Turn on setting on Client Setup
    Client Setup things


Create test data 1
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    # Notify job to Hiring Team threshold
    Create Segment for Internal     ${capture_in_progress_segment_name}    Capture     Conversation In-Progress    ${capture_in_progress_job_name}     ${threshold_notify_action}     ${cvo_offer_name}
    Create Segment for Internal     ${change_threshold_value_segment_name}    Capture     Capture Complete    ${change_threshold_value_job_name}     ${threshold_notify_action}     ${cvo_offer_name}
    Create Segment for Internal     ${capture_complete_segment_name}    Capture     Capture Complete    ${capture_complete_job_name}    ${threshold_notify_action}     ${cvo_offer_name}
    Create Segment for Internal     ${invite_to_event_interview_segment_name}    Event     Invite to Event Interview    ${invite_to_event_interview_job_name}    ${threshold_notify_action}     ${cvo_offer_name}
    Create Segment for Internal     ${offer_accepted_segment_name}    Offer     Offer Accepted    ${offer_accepted_job_name}    ${threshold_notify_action}     ${cvo_offer_name}
    Create Segment for Internal     ${interview_scheduled_segment_name}    Scheduling     Interview Scheduled    ${interview_scheduled_job_name}    ${threshold_notify_action}     ${cvo_offer_name}
    Create Segment for Internal     ${orientation_event_segment_name}    Orientation Event     Invite to Orientation    ${orientation_event_job_name}    ${threshold_notify_action}     ${cvo_offer_name}

Create test data 2
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    # Notify job to Hiring Team threshold
    Create Segment for External 1     ${capture_in_progress_ats_segment_name}    Capture     Conversation In-Progress    ${capture_in_progress_ats_job_name}     ${threshold_notify_action}
    Create Segment for External 1     ${capture_complete_ats_segment_name}    Capture     Capture Complete    ${capture_complete_ats_job_name}    ${threshold_notify_action}
    Create Segment for External 1     ${invite_to_event_interview_ats_segment_name}    Event     Invite to Event Interview    ${invite_to_event_interview_ats_job_name}    ${threshold_notify_action}
    Create Segment for External 1     ${interview_scheduled_ats_segment_name}    Scheduling     Interview Scheduled    ${interview_scheduled_ats_job_name}    ${threshold_notify_action}
    Create Segment for External 1     ${orientation_event_ats_segment_name}    Orientation Event     Invite to Orientation    ${orientation_event_ats_job_name}    ${threshold_notify_action}
    Create Segment for External 1     ${offer_accepted_ats_segment_name}    Offer     Offer Accepted    ${offer_accepted_ats_job_name}    ${threshold_notify_action}

Create test data 3
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    # Turn off job threshold
    Create Segment for Internal     ${capture_in_progress_segment_off_job_name}    Capture     Conversation In-Progress    ${capture_in_progress_job_name_2}    offer_name=${cvo_offer_name}
    Create Segment for Internal     ${capture_complete_segment_off_job_name}    Capture     Capture Complete    ${capture_complete_job_name_2}    offer_name=${cvo_offer_name}
    Create Segment for Internal     ${invite_to_event_interview_segment_off_job_name}    Event     Invite to Event Interview    ${invite_to_event_interview_job_name_2}    offer_name=${cvo_offer_name}
    Create Segment for Internal     ${offer_accepted_segment_off_job_name}    Offer     Offer Accepted    ${offer_accepted_job_name_2}    offer_name=${cvo_offer_name}
    Create Segment for Internal     ${interview_scheduled_segment_off_job_name}    Scheduling     Interview Scheduled    ${interview_scheduled_job_name_2}    offer_name=${cvo_offer_name}
    Create Segment for Internal     ${orientation_event_segment_off_job_name}    Orientation Event     Invite to Orientation    ${orientation_event_job_name_2}    offer_name=${cvo_offer_name}

Create test data 4
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    # Turn off job threshold
    Create Segment for External 2     ${capture_in_progress_ats_segment_name}    Capture     Conversation In-Progress    ${capture_in_progress_ats_job_name}
    Create Segment for External 2     ${invite_to_event_interview_ats_segment_name}    Event     Invite to Event Interview    ${invite_to_event_interview_ats_job_name}
    Create Segment for External 2     ${interview_scheduled_ats_segment_name}    Scheduling     Interview Scheduled    ${interview_scheduled_ats_job_name}
    Create Segment for External 2     ${orientation_event_ats_segment_name}    Orientation Event     Invite to Orientation    ${orientation_event_ats_job_name}
    Create Segment for External 2     ${offer_accepted_ats_segment_name}    Offer     Offer Accepted    ${offer_accepted_ats_job_name}

*** Keywords ***
Client Setup things
    Given Setup test
    # Franchise ON company
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Client setup page
    Click at    ${HIRE_LABEL}
    Turn on  ${JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    Check element display on screen    ${CLIENT_SETUP_SAVE_BUTTON}  wait_time=2s
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Capture page screenshot
    # Test Automation Job on Data package off
    Switch to Company v2  ${COMPANY_DATA_PACKAGE_OFF}
    Turn on  ${JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE}
    Capture page screenshot
    ${is_changed} =    Run Keyword And Return Status    Check element display on screen    ${CLIENT_SETUP_SAVE_BUTTON}  wait_time=2s
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    # Applicant flow company
    Switch to Company v2  ${COMPANY_APPLICANT_FLOW}
    Turn on  ${ATS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE}
    Capture page screenshot
    ${is_changed} =    Run Keyword And Return Status    Check element display on screen    ${CLIENT_SETUP_SAVE_BUTTON}  wait_time=2s
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Go to Candidate Volume Optimizer page
    Add a default Job Segment     ${cvo_limit_job_id}     number_of_candidates=${cvo_limit_number}

Create Segment for Internal
    [Arguments]     ${segment_name}     ${threshold_status_parent}     ${threshold_status_children}     ${job_name}=None     ${threshold_action}=Olivia will Turn the Job Off    ${offer_name}=None
    ${segment_info} =  Create Dictionary    segment_name=${segment_name}
                                    ...     targeting_rule=${segment_target_rule}
                                    ...     matches=${segment_target_exact_match_rule}
                                    ...     filter_text=${job_name}
                                    ...     threshold_status_parent=${threshold_status_parent}
                                    ...     threshold_status_children=${threshold_status_children}
                                    ...     threshold_num_of_candidates=1
                                    ...     threshold_action=${threshold_action}
    Switch to Company v1  ${COMPANY_DATA_PACKAGE_OFF}
    Create a custom New Job and Publish     ${job_name}      ${job_family_name}      ${job_location}    ${offer_name}
    Active a job    ${job_name}      ${job_location}
    Go to Candidate Volume Optimizer page
    Add a customize Job Segment    ${segment_info}

# For Applicant flow company
Create Segment for External 1
    [Arguments]     ${segment_name}     ${threshold_status_parent}     ${threshold_status_children}     ${job_name}=None     ${threshold_action}=Olivia will Turn the Job Off
    ${segment_info} =  Create Dictionary    segment_name=${segment_name}
                                ...     targeting_rule=${segment_target_rule}
                                ...     matches=${segment_target_exact_match_rule}
                                ...     filter_text=${job_name}
                                ...     threshold_status_parent=${threshold_status_parent}
                                ...     threshold_status_children=${threshold_status_children}
                                ...     threshold_num_of_candidates=1
                                ...     threshold_action=${threshold_action}
    Switch to Company v1  ${COMPANY_APPLICANT_FLOW}
    Active a job    ${job_name}      ${ats_job_location}
    Go to Candidate Volume Optimizer page
    Add a customize Job Segment    ${segment_info}

# For Location Mapping Off company
Create Segment for External 2
    [Arguments]     ${segment_name}     ${threshold_status_parent}     ${threshold_status_children}     ${job_name}=None     ${threshold_action}=Olivia will Turn the Job Off
    ${segment_info} =  Create Dictionary    segment_name=${segment_name}
                                ...     targeting_rule=${segment_target_rule}
                                ...     matches=${segment_target_exact_match_rule}
                                ...     filter_text=${job_name}
                                ...     threshold_status_parent=${threshold_status_parent}
                                ...     threshold_status_children=${threshold_status_children}
                                ...     threshold_num_of_candidates=1
                                ...     threshold_action=${threshold_action}
    Switch to Company v1  ${COMPANY_LOCATION_MAPPING_OFF}
    Active a job    ${job_name}      ${ats_job_state}
    Go to Candidate Volume Optimizer page
    Add a customize Job Segment    ${segment_info}
