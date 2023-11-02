*** Settings ***
Resource            ./cvo_flow.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        lts_stg    regression    stg    olivia    mchire    darden    lowes    lowes_stg    aramark    pepsi    unilever    birddoghr    fedex    fedexstg    test

*** Variables ***
${cvo_limit_job_id}     ${AUTOMATION_TESTER_REQ_ID_029}
${cvo_limit_job_name}     ${AUTOMATION_TESTER_TITLE_029}
${cvo_unlimited_job_id}     ${AUTOMATION_TESTER_REQ_ID_014}
${cvo_unlimited_job_name}     ${AUTOMATION_TESTER_TITLE_014}
${normal_job_id}     ${AUTOMATION_TESTER_REQ_ID_041}
${cvo_limit_number}     ${3}

${segment_target_rule}  Job Title
${segment_target_exact_match_rule}  Exactly matches
${threshold_notify_action}  Olivia Will Notify the Hiring Team

# Notify job to Hiring team threshold
${capture_in_progress_job_name}     CVO Conversation In-Progress Job
${capture_complete_job_name}     CVO Capture Complete Job
${invite_to_event_interview_job_name}     CVO Invite to Event Interview Job
${interview_scheduled_job_name}     CVO Interview Scheduled Job
${orientation_event_job_name}     CVO No Event Availability Job
${offer_accepted_job_name}     CVO Offer Accepted Job
${change_threshold_value_job_name}     CVO Change Threshold Value Job

${capture_in_progress_ats_job_name}     ${AUTOMATION_TESTER_TITLE_035}
${capture_complete_ats_job_name}     ${AUTOMATION_TESTER_TITLE_036}
${invite_to_event_interview_ats_job_name}     ${AUTOMATION_TESTER_TITLE_037}
${invite_to_event_interview_ats_job_id}     ${AUTOMATION_TESTER_REQ_ID_037}
${interview_scheduled_ats_job_name}     ${AUTOMATION_TESTER_TITLE_024}
${interview_scheduled_ats_job_id}     ${AUTOMATION_TESTER_REQ_ID_024}
${orientation_event_ats_job_name}     ${AUTOMATION_TESTER_TITLE_026}
${orientation_event_ats_job_id}     ${AUTOMATION_TESTER_REQ_ID_026}
${offer_accepted_ats_job_name}     ${AUTOMATION_TESTER_TITLE_028}
${offer_accepted_ats_job_id}     ${AUTOMATION_TESTER_REQ_ID_028}

# Turn off job threshold
${capture_in_progress_job_name_2}     CVO Conversation In-Progress Job 2
${capture_complete_job_name_2}     CVO Capture Complete Job 2
${invite_to_event_interview_job_name_2}     CVO Invite to Event Interview Job 2
${offer_accepted_job_name_2}     CVO Offer Accepted Job 2
${interview_scheduled_job_name_2}     CVO Interview Scheduled Job 2
${orientation_event_job_name_2}     CVO No Event Availability Job 2

*** Test Cases ***
Verify Hiring Manager is noticed when matched thresholds status of Capture In-Progress (OL-T11695)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Conversation In-Progress
    ${job_name} =   Set variable    ${capture_in_progress_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    Apply candidate and check Hiring Manager is noticed     ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Capture Complete (T11695)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Capture Complete
    ${job_name} =   Set variable    ${capture_complete_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    Apply a Candidate to job for Widget    ${job_name}
    check message widget site response correct  How old are you?
    Input text for widget site    18
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Capture In-Progress - ATS Job feed (OL-T11709)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${threshold_status} =   Set variable    Conversation In-Progress
    ${job_name} =   Set variable    ${capture_in_progress_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}
    Apply candidate and check Hiring Manager is noticed     ${job_location}    ${job_name}     ${threshold_status}    ${COMPANY_APPLICANT_FLOW}


Verify Hiring Manager is noticed when matched thresholds status of Capture Complete - ATS Job feed (OL-T11709)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${threshold_status} =   Set variable    Capture Complete
    ${job_name} =   Set variable    ${capture_complete_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}
    Apply candidate and check Hiring Manager is noticed     ${job_location}    ${job_name}     ${threshold_status}    ${COMPANY_APPLICANT_FLOW}


Verify Hiring Manager is noticed when matched thresholds status of Event Scheduling Interview (OL-T11686)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Invite to Event Interview
    ${job_name} =   Set variable    ${invite_to_event_interview_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}
    Update conversation status following threshold status  ${candidate_name}   Event   ${threshold_status}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Event Scheduling Interview - ATS Job feed (OL-T11700)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${threshold_status} =   Set variable    Invite to Event Interview
    ${job_name} =   Set variable    ${invite_to_event_interview_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${invite_to_event_interview_ats_job_id}
    Update conversation status following threshold status  ${candidate_name}   Event   ${threshold_status}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Scheduling Interview (OL-T11683)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Interview Scheduled
    ${job_name} =   Set variable    ${interview_scheduled_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    # Add a Candidate and then send an interview invitation
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}     is_spam_email=False
    Update conversation status following threshold status  ${candidate_name}   Scheduling   Invite to Interview     ${COMPANY_DATA_PACKAGE_OFF}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}
    

Verify Hiring Manager is noticed when matched thresholds status of Scheduling Interview - ATS Job feed (OL-T11697)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${threshold_status} =   Set variable    Interview Scheduled
    ${job_name} =   Set variable    ${interview_scheduled_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}
    # Add a Candidate and then send an interview invitation
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${interview_scheduled_ats_job_id}    is_spam_email=False
    Update conversation status following threshold status  ${candidate_name}   Scheduling   Invite to Interview     ${COMPANY_APPLICANT_FLOW}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Orientation Event (OL-T11689)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Invite to Orientation
    ${job_name} =   Set variable    ${orientation_event_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}
    Update conversation status following threshold status  ${candidate_name}   Orientation Event   ${threshold_status}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Orientation Event - ATS Job feed (OL-T11703)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${threshold_status} =   Set variable    Invite to Orientation
    ${job_name} =   Set variable    ${orientation_event_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${orientation_event_ats_job_id}
    Update conversation status following threshold status  ${candidate_name}   Orientation Event   ${threshold_status}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Offer (OL-T11693)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Offer Accepted
    ${job_name} =   Set variable    ${offer_accepted_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}      is_spam_email=False
    Update conversation status following threshold status    ${candidate_name}    Offer    Send Offer    ${COMPANY_DATA_PACKAGE_OFF}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Hiring Manager is noticed when matched thresholds status of Offer - ATS Job feed (OL-T11707)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${threshold_status} =   Set variable    Offer Accepted
    ${job_name} =   Set variable    ${offer_accepted_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${offer_accepted_ats_job_id}      is_spam_email=False
    Update conversation status following threshold status    ${candidate_name}    Offer    Send Offer    ${COMPANY_APPLICANT_FLOW}
    Check Hiring Manager is noticed when matched threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Capture In-Progress (OL-T11694)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Conversation In-Progress
    ${job_name} =   Set variable    ${capture_in_progress_job_name_2}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    Apply a Candidate to job for Widget    ${job_name}
    Check Hiring Manager is turn off when met threshold     ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Capture - ATS Job feed (OL-T11708)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${threshold_status} =   Set variable    Conversation In-Progress
    ${job_name} =   Set variable    ${capture_in_progress_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}    job_state_location=True
    Apply a Candidate to job for Landing site    ${job_name}    ${COMPANY_LOCATION_MAPPING_OFF}
    Check Hiring Manager is turn off when met threshold     ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Event Scheduling Interview (OL-T11684)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Invite to Event Interview
    ${job_name} =   Set variable    ${invite_to_event_interview_job_name_2}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}
    Update conversation status following threshold status  ${candidate_name}   Event   ${threshold_status}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Event Scheduling Interview - ATS Job feed (OL-T11698)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${threshold_status} =   Set variable    Invite to Event Interview
    ${job_name} =   Set variable    ${invite_to_event_interview_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}    job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${invite_to_event_interview_ats_job_id}
    Update conversation status following threshold status  ${candidate_name}   Event   ${threshold_status}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Orientation Event (OL-T11688)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Invite to Orientation
    ${job_name} =   Set variable    ${orientation_event_job_name_2}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}
    Update conversation status following threshold status  ${candidate_name}   Orientation Event   ${threshold_status}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Orientation Event - ATS Job feed (OL-T11702)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${threshold_status} =   Set variable    Invite to Orientation
    ${job_name} =   Set variable    ${orientation_event_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}    job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${orientation_event_ats_job_id}
    Update conversation status following threshold status  ${candidate_name}   Orientation Event   ${threshold_status}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Scheduling Interview (OL-T11682)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Interview Scheduled
    ${job_name} =   Set variable    ${interview_scheduled_job_name_2}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    # Add a Candidate and then send an interview invitation
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}     is_spam_email=False
    Update conversation status following threshold status  ${candidate_name}   Scheduling   Invite to Interview     ${COMPANY_DATA_PACKAGE_OFF}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Scheduling Interview - ATS Job feed (OL-T11696)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${threshold_status} =   Set variable    Interview Scheduled
    ${job_name} =   Set variable    ${interview_scheduled_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}    job_state_location=True
    # Add a Candidate and then send an interview invitation
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${interview_scheduled_ats_job_id}    is_spam_email=False
    Update conversation status following threshold status  ${candidate_name}   Scheduling   Invite to Interview     ${COMPANY_LOCATION_MAPPING_OFF}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Offer (OL-T11692)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Offer Accepted
    ${job_name} =   Set variable    ${offer_accepted_job_name_2}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM  ${job_location}     ${job_name}      is_spam_email=False
    Update conversation status following threshold status    ${candidate_name}    Offer    Send Offer    ${COMPANY_DATA_PACKAGE_OFF}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Job is auto turned off when matched thresholds status of Offer - ATS Job feed (OL-T11706)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${threshold_status} =   Set variable    Offer Accepted
    ${job_name} =   Set variable    ${offer_accepted_ats_job_name}
    ${job_location} =   Prepare job for testing      External    ${job_name}    job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM  job_req_id=${offer_accepted_ats_job_id}      is_spam_email=False
    Update conversation status following threshold status    ${candidate_name}    Offer    Send Offer    ${COMPANY_LOCATION_MAPPING_OFF}
    Check Hiring Manager is turn off when met threshold      ${job_location}    ${job_name}     ${threshold_status}


Verify Olivia works correctly when admin set specific thresholds value in My Jobs in case having set value in Candidate Volume Optimizer (OL-T11678)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${threshold_status} =   Set variable    Capture Complete
    ${job_name} =   Set variable    ${change_threshold_value_job_name}
    ${job_location} =   Prepare job for testing      Internal    ${job_name}
    # Change threshold value from 1 to 2 candidate
    Search job in location  ${job_name}     ${job_location}
    Click at  ${MY_JOB_DETAILS_ESCAPE_ICON}  ${job_name}
    Click at  ${MY_JOB_DETAILS_EDIT_JOB}
    Input into  ${JOB_THRESHOLDS_NUMBER_OF_CANDIDATE_TEXTBOX}   2
    Capture page screenshot
    Click at  ${JOB_THRESHOLDS_SAVE_BUTTON}
    # Add candidate to Job match threshold value
    Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Add a Candidate to job via CEM      ${job_location}     ${job_name}
    # Check Hiring Team will receive notify after 2 candidates apply instead of 1
    search job in location  ${job_name}  ${job_location}
    Check element display on screen  Notification Sent: 2 Candidate(s) Reached ${threshold_status}
    Capture page screenshot
    Check Notification of Hiring Manage when job met threshold    ${job_name}
    Click at    ${NOTIFICATION_CHILD_ITEM}  ${job_name}: Threshold is reached, please turn the job off manually

*** Keywords ***
