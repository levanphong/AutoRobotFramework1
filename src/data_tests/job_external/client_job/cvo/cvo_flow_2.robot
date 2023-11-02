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

Documentation       Test Automation Job on Data package off: Add a Conversation with `Follow up` template
...                 Test Automation Job on Data package off: Client Setup > Hire > Turn On `Form` toggle, create `CVO Form`
...                 Test Automation Job on Data package off: Create 3 Forms
...                 Test Automation Job on Data package off: Client Setup > Hire > Turn On `Assessments` toggle, add 2 keys in order `6153c68d43a5480fbba31cfb2e74f09b` and `c8d25f37526c4a5aacd02b4db38d2935`
...                 Test Automation Location Mapping Off: Client Setup > Hire > Turn On `Assessments` toggle, add 2 keys in order `6153c68d43a5480fbba31cfb2e74f09b` and `c8d25f37526c4a5aacd02b4db38d2935`
...                 Test Automation Location Mapping Off: Add Job Requisition from PAT051 to PAT065

*** Variables ***
${cvo_offer_name}                                       CVO Offer for testing
${job_family_name}                                      ${JF_COFFEE_FAMILY_JOB}
${job_location}                                         ${CONST_LOCATION}
${ats_job_location}                                     ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
${ats_job_state}                                        ${AREA_NAME_SOUTH_BURLINGTON}

${segment_target_rule}                                  Job Title
${segment_target_exact_match_rule}                      Exactly matches
${threshold_notify_action}                              Olivia Will Notify the Hiring Team

${job_with_deactivate_segment_name}                     CVO Deactivate Segment Job
${deactivate_segment_name}                              CVO Deactivate Segment
${job_with_draft_segment_name}                          CVO Draft Segment Job
${draft_segment_name}                                   CVO Draft Segment
${job_with_default_segment_name}                        CVO Default Segment Job
${job_with_empty_threshold_segment_name}                CVO Empty Threshold Segment Job    # Check for notify
${empty_threshold_segment_name}                         CVO Empty Threshold Segment Job
${job_with_empty_threshold_segment_name_2}              CVO Empty Threshold Segment Job 2    # Check for off job
${empty_threshold_segment_name_2}                       CVO Empty Threshold Segment Job 2
${background_check_sent_job_name}                       CVO Background Check Sent Job
${background_check_sent_segment_name}                   CVO BGCS Segment
${send_conversation_job_name}                           CVO Send Conversation Job
${send_conversation_segment_name}                       CVO SendConversation Segment
${send_application_job_name}                            CVO Send Application Job
${send_application_segment_name}                        CVO SendApplication Segment
${send_form_job_name}                                   CVO Send Form Job
${send_form_segment_name}                               CVO SendForm Segment
${hired_job_name}                                       CVO Hired Job
${hired_segment_name}                                   CVO HireCandidate Segment
${send_onboarding_job_name}                             CVO Send Onboarding Job
${send_onboarding_segment_name}                         CVO SendOnboarding Segment
${disposition_job_name}                                 CVO Disposition Job
${disposition_segment_name}                             CVO DispositionCandidate Segment
${send_assessment_job_name}                             CVO Send Assessment Job
${send_assessment_segment_name}                         CVO SendAssessment Segment

${background_check_sent_job_name_2}                     CVO Background Check Sent Job 2
${background_check_sent_segment_name_2}                 CVO BGCS Off Job Segment
${send_conversation_job_name_2}                         CVO Send Conversation Job 2
${send_conversation_segment_name_2}                     CVO SendConversation Off Job Segment
${send_application_job_name_2}                          CVO Send Application Job 2
${send_application_segment_name_2}                      CVO SendApplication Off Job Segment
${send_form_job_name_2}                                 CVO Send Form Job 2
${send_form_segment_name_2}                             CVO SendForm Off Job Segment
${hired_job_name_2}                                     CVO Hired Job 2
${hired_segment_name_2}                                 CVO HireCandidate Off Job Segment
${send_onboarding_job_name_2}                           CVO Send Onboarding Job 2
${send_onboarding_segment_name_2}                       CVO SendOnboarding Off Job Segment
${disposition_job_name_2}                               CVO Disposition Job 2
${disposition_segment_name_2}                           CVO DispositionCandidate Off Job Segment
${send_assessment_job_name_2}                           CVO Send Assessment Job 2
${send_assessment_segment_name_2}                       CVO SendAssessment Off Job Segment

${background_check_sent_ats_job_name}                   ${AUTOMATION_TESTER_TITLE_051}
${background_check_sent_ats_segment_name}               CVO BGCS ATS Segment
${send_assessment_ats_job_name}                         ${AUTOMATION_TESTER_TITLE_052}
${send_assessment_ats_segment_name}                     CVO SendAssessment ATS Segment
${send_application_ats_job_name}                        ${AUTOMATION_TESTER_TITLE_058}
${send_application_ats_segment_name}                    CVO SendApplication ATS Segment
${send_conversation_ats_job_name}                       ${AUTOMATION_TESTER_TITLE_054}
${send_conversation_ats_segment_name}                   CVO SendConversation ATS Segment
${send_form_ats_job_name}                               ${AUTOMATION_TESTER_TITLE_055}
${send_form_ats_segment_name}                           CVO SendForm ATS Segment
${hired_ats_job_name}                                   ${AUTOMATION_TESTER_TITLE_056}
${hired_ats_segment_name}                               CVO HireCandidate ATS Segment
${send_onboarding_ats_job_name}                         ${AUTOMATION_TESTER_TITLE_057}
${send_onboarding_ats_segment_name}                     CVO SendOnboarding ATS Segment

${background_check_sent_ats_job_name_2}                 ${AUTOMATION_TESTER_TITLE_059}
${background_check_sent_off_job_ats_segment_name}       CVO BGCS Off Job ATS Segment
${send_assessment_ats_job_name_2}                       ${AUTOMATION_TESTER_TITLE_060}
${send_assessment_off_job_ats_segment_name}             CVO SendAssessment Off Job ATS Segment
${send_application_ats_job_name_2}                      ${AUTOMATION_TESTER_TITLE_061}
${send_application_off_job_ats_segment_name}            CVO SendApplication Off Job ATS Segment
${send_conversation_ats_job_name_2}                     ${AUTOMATION_TESTER_TITLE_062}
${send_conversation_off_job_ats_segment_name}           CVO SendConversation Off Job ATS Segment
${send_form_ats_job_name_2}                             ${AUTOMATION_TESTER_TITLE_063}
${send_form_off_job_ats_segment_name}                   CVO SendForm Off Job ATS Segment
${hired_ats_job_name_2}                                 ${AUTOMATION_TESTER_TITLE_064}
${hired_off_job_ats_segment_name}                       CVO HireCandidate Off Job ATS Segment
${send_onboarding_ats_job_name_2}                       ${AUTOMATION_TESTER_TITLE_065}
${send_onboarding_off_job_ats_segment_name}             CVO SendOnboarding Off Job ATS Segment

*** Test Cases ***
Create test data 1
    # Notify job to Hiring Team threshold
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create Segment for Internal     ${deactivate_segment_name}      Capture     ${CIP}      ${job_with_deactivate_segment_name}     ${threshold_notify_action}      ${cvo_offer_name}
    Create a New job, Publish and Active    ${job_with_draft_segment_name}      ${cvo_offer_name}
    Create a New job, Publish and Active    ${job_with_default_segment_name}    ${cvo_offer_name}
    Create Segment for Internal     ${empty_threshold_segment_name}     Capture     ${CIP}      ${job_with_empty_threshold_segment_name}    ${threshold_notify_action}      ${cvo_offer_name}       None
    Create Segment for Internal     ${empty_threshold_segment_name_2}       Capture     ${CIP}      ${job_with_empty_threshold_segment_name_2}      offer_name=${cvo_offer_name}    threshold_num_of_candidates=None
    Create Segment for Internal     ${background_check_sent_segment_name}       Background Check    ${BGCS}     ${background_check_sent_job_name}       ${threshold_notify_action}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_conversation_segment_name}       Conversation    ${SEND_CONVERSATION}    ${send_conversation_job_name}       ${threshold_notify_action}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_application_segment_name}    Application     ${SEND_APPLICATION}     ${send_application_job_name}    ${threshold_notify_action}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_form_segment_name}       Form    ${SEND_FORM}    ${send_form_job_name}       ${threshold_notify_action}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${hired_segment_name}       Hire    ${HIRED}    ${hired_job_name}       ${threshold_notify_action}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_onboarding_segment_name}     Onboarding      ${SEND_ONBOARDING}      ${send_onboarding_job_name}     ${threshold_notify_action}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_assessment_segment_name}     Assessment      ${SEND_ASSESSMENT}      ${send_assessment_job_name}     ${threshold_notify_action}      offer_name=${cvo_offer_name}


Create test data 2
    # Notify job to Hiring Team threshold
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    Create Segment for External 1       ${background_check_sent_ats_segment_name}       Background Check    ${BGCS}     ${background_check_sent_ats_job_name}       ${threshold_notify_action}
    Create Segment for External 1       ${send_assessment_ats_segment_name}     Assessment      ${SEND_ASSESSMENT}      ${send_assessment_ats_job_name}     ${threshold_notify_action}
    Create Segment for External 1       ${send_application_ats_segment_name}    Application     ${SEND_APPLICATION}     ${send_application_ats_job_name}    ${threshold_notify_action}
    Create Segment for External 1       ${send_conversation_ats_segment_name}       Conversation    ${SEND_CONVERSATION}    ${send_conversation_ats_job_name}       ${threshold_notify_action}
    Create Segment for External 1       ${send_form_ats_segment_name}       Form    ${SEND_FORM}    ${send_form_ats_job_name}       ${threshold_notify_action}
    Create Segment for External 1       ${hired_ats_segment_name}       Hire    ${HIRED}    ${hired_ats_job_name}       ${threshold_notify_action}
    Create Segment for External 1       ${send_onboarding_ats_segment_name}     Onboarding      ${SEND_ONBOARDING}      ${send_onboarding_ats_job_name}     ${threshold_notify_action}


Create test data 3
    # Turn off job when met threshold condition
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create Segment for Internal     ${background_check_sent_segment_name_2}     Background Check    ${BGCS}     ${background_check_sent_job_name_2}     offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_conversation_segment_name_2}     Conversation    ${SEND_CONVERSATION}    ${send_conversation_job_name_2}     offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_application_segment_name_2}      Application     ${SEND_APPLICATION}     ${send_application_job_name_2}      offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_form_segment_name_2}     Form    ${SEND_FORM}    ${send_form_job_name_2}     offer_name=${cvo_offer_name}
    Create Segment for Internal     ${hired_segment_name_2}     Hire    ${HIRED}    ${hired_job_name_2}     offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_onboarding_segment_name_2}       Onboarding      ${SEND_ONBOARDING}      ${send_onboarding_job_name_2}       offer_name=${cvo_offer_name}
    Create Segment for Internal     ${send_assessment_segment_name_2}       Assessment      ${SEND_ASSESSMENT}      ${send_assessment_job_name_2}       offer_name=${cvo_offer_name}


Create test data 4
    # Turn OFF job when met threshold
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    Create Segment for External 1       ${background_check_sent_off_job_ats_segment_name}       Background Check    ${BGCS}     ${background_check_sent_ats_job_name_2}
    Create Segment for External 1       ${send_assessment_off_job_ats_segment_name}     Assessment      ${SEND_ASSESSMENT}      ${send_assessment_ats_job_name_2}
    Create Segment for External 1       ${send_application_off_job_ats_segment_name}    Application     ${SEND_APPLICATION}     ${send_application_ats_job_name_2}
    Create Segment for External 1       ${send_conversation_off_job_ats_segment_name}       Conversation    ${SEND_CONVERSATION}    ${send_conversation_ats_job_name_2}
    Create Segment for External 1       ${send_form_off_job_ats_segment_name}       Form    ${SEND_FORM}    ${send_form_ats_job_name_2}
    Create Segment for External 1       ${hired_off_job_ats_segment_name}       Hire    ${HIRED}    ${hired_ats_job_name_2}
    Create Segment for External 1       ${send_onboarding_off_job_ats_segment_name}     Onboarding      ${SEND_ONBOARDING}      ${send_onboarding_ats_job_name_2}

*** Keywords ***
Create Segment for Internal
    [Arguments]     ${segment_name}     ${threshold_status_parent}     ${threshold_status_children}     ${job_name}=None     ${threshold_action}=Olivia will Turn the Job Off    ${offer_name}=None    ${threshold_num_of_candidates}=1
    ${segment_info} =  Create Dictionary    segment_name=${segment_name}
                                    ...     targeting_rule=${segment_target_rule}
                                    ...     matches=${segment_target_exact_match_rule}
                                    ...     filter_text=${job_name}
                                    ...     threshold_status_parent=${threshold_status_parent}
                                    ...     threshold_status_children=${threshold_status_children}
                                    ...     threshold_num_of_candidates=${threshold_num_of_candidates}
                                    ...     threshold_action=${threshold_action}
    Switch to Company v1  ${COMPANY_DATA_PACKAGE_OFF}
    Create a custom New Job and Publish     ${job_name}      ${job_family_name}      ${job_location}    ${offer_name}
    Active a job    ${job_name}      ${job_location}
    Go to Candidate Volume Optimizer page
    Add a customize Job Segment    ${segment_info}

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
    Switch to Company v1  ${COMPANY_LOCATION_MAPPING_OFF}
    Active a job    ${job_name}      ${ats_job_state}
    Go to Candidate Volume Optimizer page
    Add a customize Job Segment    ${segment_info}

Create a New job, Publish and Active
    [Arguments]    ${job_name}=None    ${offer_name}=None
    Create a custom New Job and Publish     ${job_name}      ${job_family_name}      ${job_location}    ${offer_name}
    Active a job    ${job_name}      ${job_location}
