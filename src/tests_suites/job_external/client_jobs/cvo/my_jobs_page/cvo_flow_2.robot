*** Settings ***
Resource            ./cvo_flow.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        lts_stg    regression    lowes    lowes_stg    test

*** Variables ***
${job_family_name}                              ${JF_COFFEE_FAMILY_JOB}
${job_location}                                 ${CONST_LOCATION}
${ats_job_location}                             ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}
${ats_job_state}                                ${AREA_NAME_SOUTH_BURLINGTON}

${segment_target_rule}                          Job Title
${segment_target_exact_match_rule}              Exactly matches
${threshold_notify_action}                      Olivia Will Notify the Hiring Team

${job_with_deactivate_segment_name}             CVO Deactivate Segment Job
${job_with_draft_segment_name}                  CVO Draft Segment Job
${job_with_default_segment_name}                CVO Default Segment Job
${job_with_empty_threshold_segment_name}        CVO Empty Threshold Segment Job    # Check for notify
${job_with_empty_threshold_segment_name_2}      CVO Empty Threshold Segment Job 2    # Check for off job
${background_check_sent_job_name}               CVO Background Check Sent Job
${send_conversation_job_name}                   CVO Send Conversation Job
${send_application_job_name}                    CVO Send Application Job
${send_form_job_name}                           CVO Send Form Job
${hired_job_name}                               CVO Hired Job
${send_onboarding_job_name}                     CVO Send Onboarding Job
${send_assessment_job_name}                     CVO Send Assessment Job

${background_check_sent_job_name_2}             CVO Background Check Sent Job 2
${send_conversation_job_name_2}                 CVO Send Conversation Job 2
${send_application_job_name_2}                  CVO Send Application Job 2
${send_form_job_name_2}                         CVO Send Form Job 2
${hired_job_name_2}                             CVO Hired Job 2
${send_onboarding_job_name_2}                   CVO Send Onboarding Job 2
${disposition_job_name_2}                       CVO Disposition Job 2
${send_assessment_job_name_2}                   CVO Send Assessment Job 2

${background_check_sent_ats_job_name}           ${AUTOMATION_TESTER_TITLE_051}
${background_check_sent_ats_job_id}             ${AUTOMATION_TESTER_REQ_ID_051}
${send_assessment_ats_job_name}                 ${AUTOMATION_TESTER_TITLE_052}
${send_assessment_ats_job_id}                   ${AUTOMATION_TESTER_REQ_ID__052}
${send_application_ats_job_name}                ${AUTOMATION_TESTER_TITLE_058}
${send_application_ats_job_id}                  ${AUTOMATION_TESTER_REQ_ID__058}
${send_conversation_ats_job_name}               ${AUTOMATION_TESTER_TITLE_054}
${send_conversation_ats_job_id}                 ${AUTOMATION_TESTER_REQ_ID__054}
${send_form_ats_job_name}                       ${AUTOMATION_TESTER_TITLE_055}
${send_form_ats_job_id}                         ${AUTOMATION_TESTER_REQ_ID__055}
${hired_ats_job_name}                           ${AUTOMATION_TESTER_TITLE_056}
${hired_ats_job_id}                             ${AUTOMATION_TESTER_REQ_ID__056}
${send_onboarding_ats_job_name}                 ${AUTOMATION_TESTER_TITLE_057}
${send_onboarding_ats_job_id}                   ${AUTOMATION_TESTER_REQ_ID__057}

${background_check_sent_ats_job_name_2}         ${AUTOMATION_TESTER_TITLE_059}
${background_check_sent_ats_off_job_id}         ${AUTOMATION_TESTER_REQ_ID_059}
${send_assessment_ats_job_name_2}               ${AUTOMATION_TESTER_TITLE_060}
${send_assessment_ats_off_job_id}               ${AUTOMATION_TESTER_REQ_ID__060}
${send_application_ats_job_name_2}              ${AUTOMATION_TESTER_TITLE_061}
${send_application_ats_off_job_id}              ${AUTOMATION_TESTER_REQ_ID__061}
${send_conversation_ats_job_name_2}             ${AUTOMATION_TESTER_TITLE_062}
${send_conversation_ats_off_job_id}             ${AUTOMATION_TESTER_REQ_ID__062}
${send_form_ats_job_name_2}                     ${AUTOMATION_TESTER_TITLE_063}
${send_form_ats_off_job_id}                     ${AUTOMATION_TESTER_REQ_ID__063}
${hired_ats_job_name_2}                         ${AUTOMATION_TESTER_TITLE_064}
${hired_ats_off_job_id}                         ${AUTOMATION_TESTER_REQ_ID__064}
${send_onboarding_ats_job_name_2}               ${AUTOMATION_TESTER_TITLE_065}
${send_onboarding_ats_off_job_id}               ${AUTOMATION_TESTER_REQ_ID__065}

*** Test Cases ***
Verify No action happens in case candiates applied and met with conditions of Candidate volume Optimizer which has Deactive status (OL-T11818)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${job_with_deactivate_segment_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    Apply candidate and check nothing happens       ${job_location}     ${job_name}     ${CIP}


Verify No action happens in case candiates applied and met with conditions of Candidate volume Optimizer which has Draft status (OL-T11817)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${job_with_draft_segment_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    Apply candidate and check nothing happens       ${job_location}     ${job_name}     ${CIP}


Verify No action happens in case only added default threshold (OL-T11814)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${job_with_default_segment_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    Apply candidate and check nothing happens       ${job_location}     ${job_name}     ${CIP}


Verify No action happens in case threshold value empty (OL-T11815)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${job_with_empty_threshold_segment_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    Apply candidate and check nothing happens       ${job_location}     ${job_name}     ${CIP}


Verify no action happens when candidate applies to jobs which is set in Candidate volume Optimize in case No thresholds (OL-T11808)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${job_with_empty_threshold_segment_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    Apply candidate and check nothing happens       ${job_location}     ${job_name}     ${CIP}


Verify Hiring Manager is noticed when matched thresholds status of Status Background Check - Job internal (OL-T11779)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${background_check_sent_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Background Check    ${BGCS}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${BGCS}


Verify Hiring Manager is noticed when matched thresholds status of Status Conversation - Job internal (OL-T11781)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_conversation_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Conversation    ${SEND_CONVERSATION}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_CONVERSATION}


Verify Hiring Manager is noticed when matched thresholds status of Status Applicant - Job internal (OL-T11787)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_application_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Application     ${SEND_APPLICATION}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_APPLICATION}


Verify Hiring Manager is noticed when matched thresholds status of Status Form - Job internal (OL-T11785)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_form_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Form    ${SEND_FORM}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_FORM}


Verify Hiring Manager is noticed when matched thresholds status of Status Hired - Job internal (OL-T11791)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${hired_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Hire    ${HIRED}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${HIRED}


Verify Hiring Manager is noticed when matched thresholds status of Status Onboarding - Job internal (OL-T11789)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_onboarding_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Onboarding      ${SEND_ONBOARDING}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_ONBOARDING}


Verify Hiring Manager is noticed when matched thresholds status of Status Assessment - Job internal (OL-T11783)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_assessment_job_name}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Assessment      ${SEND_ASSESSMENT}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_ASSESSMENT}


Verify Job is auto turned off when matched thresholds with Status Applicant - Job internal (OL-T11786)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_application_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Application     ${SEND_APPLICATION}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_APPLICATION}


Verify Job is auto turned off when matched thresholds with Status Background Check - Job internal (OL-T11778)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${background_check_sent_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Background Check    ${BGCS}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${BGCS}


Verify Job is auto turned off when matched thresholds with Status Conversation- Job internal (OL-T11780)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_conversation_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Conversation    ${SEND_CONVERSATION}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_CONVERSATION}


Verify Job is auto turned off when matched thresholds with Status Form - Job internal (OL-T11784)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_form_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Form    ${SEND_FORM}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_FORM}


Verify Job is auto turned off when matched thresholds with Status Hired - Job internal (OL-T11790)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${hired_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Hire    ${HIRED}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${HIRED}


Verify Job is auto turned off when matched thresholds with Status Onboarding - Job internal (OL-T11788)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_onboarding_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Onboarding      ${SEND_ONBOARDING}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_ONBOARDING}


Verify Job is auto turned off when matched thresholds with Status Assessment - Job internal (OL-T11782)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name} =       Set variable    ${send_assessment_job_name_2}
    ${job_location} =       Prepare job for testing     Internal    ${job_name}
    ${candidate_name} =     Add a Candidate to job via CEM      ${job_location}     ${job_name}
    Update conversation status following threshold status       ${candidate_name}       Assessment      ${SEND_ASSESSMENT}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_ASSESSMENT}


Verify Hiring Manager is noticed when matched thresholds status of Status Background Check - ATS Job feed (OL-T11795)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${background_check_sent_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${background_check_sent_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Background Check    ${BGCS}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${BGCS}


Verify Hiring Manager is noticed when matched thresholds status of Status Applicant - ATS Job feed (OL-T11803)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_application_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_application_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Application     ${SEND_APPLICATION}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_APPLICATION}


Verify Hiring Manager is noticed when matched thresholds status of Status Assessment - ATS Job feed (OL-T11799)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_assessment_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_assessment_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Assessment      ${SEND_ASSESSMENT}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_ASSESSMENT}


Verify Hiring Manager is noticed when matched thresholds status of Status Conversation - ATS Job feed (OL-T11797)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_conversation_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_conversation_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Conversation    ${SEND_CONVERSATION}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_CONVERSATION}


Verify Hiring Manager is noticed when matched thresholds status of Status Form - ATS Job feed (OL-T11801)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_form_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_form_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Form    ${SEND_FORM}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_FORM}


Verify Hiring Manager is noticed when matched thresholds status of Status Hired - ATS Job feed (OL-T11807)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${hired_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${hired_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Hire    ${HIRED}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${HIRED}


Verify Hiring Manager is noticed when matched thresholds status of Status Onboarding - ATS Job feed (OL-T11805)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_onboarding_ats_job_name}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_onboarding_ats_job_id}
    Update conversation status following threshold status       ${candidate_name}       Onboarding      ${SEND_ONBOARDING}
    Check Hiring Manager is noticed when matched threshold      ${job_location}     ${job_name}     ${SEND_ONBOARDING}


Verify Job is auto turned off when matched thresholds with Status Background Check - ATS Job feed (OL-T11794)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${background_check_sent_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${background_check_sent_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Background Check    ${BGCS}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${BGCS}


Verify Job is auto turned off when matched thresholds with Status Applicant - ATS Job feed (OL-T11802)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_application_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_application_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Application     ${SEND_APPLICATION}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_APPLICATION}


Verify Hiring Manager auto turned off when matched thresholds status of Status Assessment - ATS Job feed (OL-T11798)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_assessment_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_assessment_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Assessment      ${SEND_ASSESSMENT}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_ASSESSMENT}


Verify Hiring Manager auto turned off when matched thresholds status of Status Conversation - ATS Job feed (OL-T11796)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_conversation_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_conversation_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Conversation    ${SEND_CONVERSATION}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_CONVERSATION}


Verify Hiring Manager auto turned off when matched thresholds status of Status Form - ATS Job feed (OL-T11800)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_form_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_form_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Form    ${SEND_FORM}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_FORM}


Verify Hiring Manager auto turned off when matched thresholds status of Status Hired - ATS Job feed (OL-T11806)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${hired_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${hired_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Hire    ${HIRED}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${HIRED}


Verify Hiring Manager auto turned off when matched thresholds status of Status Onboarding - ATS Job feed (OL-T11804)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_name} =       Set variable    ${send_onboarding_ats_job_name_2}
    ${job_location} =       Prepare job for testing     External    ${job_name}     job_state_location=True
    ${candidate_name} =     Add a Candidate to job via CEM      job_req_id=${send_onboarding_ats_off_job_id}
    Update conversation status following threshold status       ${candidate_name}       Onboarding      ${SEND_ONBOARDING}
    Check Hiring Manager is turn off when met threshold     ${job_location}     ${job_name}     ${SEND_ONBOARDING}

*** Keywords ***
