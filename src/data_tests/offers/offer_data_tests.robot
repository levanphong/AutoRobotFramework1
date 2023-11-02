*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/custom_conversation_page.robot
Resource            ../../pages/applicant_flows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${test_location_name}                   ${CONST_LOCATION}
${cj_name}                              CJ_Send Offer To Candidate
${wf_name}                              WF_Send Offer To Candidate
${offer_name}                           OF_Send Offer To Candidate
${offer_name_with_location_lookup}      OF_Offer With Location Lookup
${offer_name_with_user_lookup}          OF_Offer With User Lookup
${job_name}                             Job for Send Offer To Candidate
${job_name_with_location_lookup}        Job With Offer Have Location Lookup
${job_name_with_user_lookup}            Job With Offer Have User Lookup
${convo_name}                           AF_Send Offer To Candidate
${af_name}                              AF_Send Offer To Candidate
${job_requition_id}                     PAT047

*** Test Cases ***
Prepare data test for offer
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create a new offer   None   ${offer_name}
    Create new offer with Location lookup compoment     offer_name=OF_Offer With Location Lookup        add_field_mapping=Offer Created Date
    Create new offer with User lookup compoment     offer_name=OF_Offer With User Lookup        add_field_mapping=Offer Created Date
    Create Candidate journey has offer stage    ${cj_name}
    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}      job_name=${job_name}
    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name_with_location_lookup}      job_name=${job_name_with_location_lookup}
    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name_with_user_lookup}      job_name=${job_name_with_user_lookup}
    Go to My Jobs page
    Active a job    ${job_name}
    Active a job    ${job_name_with_location_lookup}
    Active a job    ${job_name_with_user_lookup}
    Add a Workflow    ${wf_name}    None    ${cj_name}    None
    Add a send offer stage for workflow     ${wf_name}


Prepare data test for external offer
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Create Candidate journey has offer stage    ${cj_name}
    Add a Workflow    ${wf_name}    None    ${cj_name}    None
    Add a send offer stage for workflow     ${wf_name}
    Add a custom conversation for external offer    ${convo_name}   ${cj_name}
    Add new applicant flows for external offer  ${af_name}  ${job_requition_id}     ${cj_name}  ${convo_name}

*** Keywords ***
Add a send offer stage for workflow
    [Arguments]     ${wf_name}
    Go to Workflows page
    Click at    ${wf_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    Input into    ${WF_TASK_NAME_TEXTBOX}    Send Offer for Candidates
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}

Add a custom conversation for external offer
    [Arguments]     ${convo_name}   ${cj_name}
    Go to conversation builder
    Add new custom conversation with name   ${convo_name}
    Add Candidate Journey to Custom Conversation    ${cj_name}
    Input question name    Welcome
    Select question type    Welcome    Open-Ended
    Add next question    Welcome
    Add question by type and content    Full Name       ${REPROMPT_NAME_MESSAGE_8}
    Add next question    Full Name
    Add question by type and content    Email   Thank you \#candidate-firstname. Can you please provide me with your email so that a recruiter can contact you?
    Add end conversation to Custom Conversation     Email   END
    Capture page screenshot
    Public custom conversation

Add new applicant flows for external offer
    [Arguments]     ${af_name}  ${job_requition_id}     ${cj_name}  ${convo_name}
    Go to Applicant Flows
    Click at  ${APPLICANT_FLOWS_CREATE_NEW_BUTTON}   wait_time=5s
    Input into  ${APPLICANT_FLOWS_NAME_TEXTBOX}  ${af_name}
    Input into  ${APPLICANT_FLOWS_EXTERNAL_AF_ID_TEXTBOX}   ${af_name}
    Set condition in applicant flows    1   ${job_requition_id}
    Click at  ${APPLICANT_FLOWS_NEXT_STEP_BUTTON}
    Select Candidate Journey in applicant flows     ${cj_name}
    Set conversation in applicant flows    ${convo_name}
    Set interview in applicant flows
    Select Offer type in applicant flows    External Offer Upload
    Click at  ${APPLICANT_FLOWS_SAVE_FINISH_BUTTON}
