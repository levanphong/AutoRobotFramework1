*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../data_tests/job_external/requisition_based_permission.robot
Resource            ../../../pages/users_page.robot
Resource            ../../../pages/all_candidates_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${user_without_requisition}     user_without_requisition
${user_with_requisition}        user_with_requisition
${job_requisition_id_1}         PAT047
${job_requisition_id_2}         PAT049
${job_requisition_id_3}         PAT050

*** Test Cases ***
Users page - There is no option ‘Requisition permissions’ on Users page when "Requisition based permissions" toggle OFF (OL-T231)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Turn off Requisition Based Permissions
    Go to Users page
    Check element not display on screen    Requisition permissions
    Check element not display on screen    ${EDIT_REQUISITIONS_BUTTON}
    Enable Client Setup for Job External / Requisition Based Permission    More


View permissions - User was assigned to requisitions, then being un-assigned on job requisitions will have permission to view and action on Invite to Interview, Interview Pending, Interview scheduled, and Interview complete candidates (OL-T250)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Add job requisition to user
    # Add a candidate with job requisition
    Go to CEM page
    ${candidate_name_1} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    ${candidate_name_2} =    Add a Candidate    job_req_id=${job_requisition_id_2}
    Switch to user    ${user_with_requisition}
    # Change conversation to `Invite to Interview` status
    Change conversation status    ${candidate_name_1}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Wait with short time
    Click at    ${SCHEDULE_AN_INTERVIEW_CLOSE_BUTTON}
    # Change conversation to `Interview Pending` status
    Change conversation status    ${candidate_name_2}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SELECT}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}    user
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}    ${user_with_requisition}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}    To Close Choose Box
    Click at    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_BUTTON}
    # Remove job requisition from user
    Remove job requisition from user
    Go to CEM page
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${candidate_name_1}
    Check element display on screen    ${candidate_name_2}
    Add job requisition to user


View permissions - New user being assigned to requisitions will have permission to view the candidates of assigned requisition (old + new) (OL-T254)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Remove job requisition from user
    Go to CEM page
    ${candidate_name_1} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Add job requisition to user
    Go to CEM page
    ${candidate_name_2} =    Add a Candidate    job_req_id=${job_requisition_id_2}
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${candidate_name_1}
    Check element display on screen    ${candidate_name_2}


View permissions - New user being assigned to requisitions will have permission to action on the old + new candidates (OL-T256)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Remove job requisition from user
    Go to CEM page
    ${candidate_name_1} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Add job requisition to user
    Go to CEM page
    ${candidate_name_2} =    Add a Candidate    job_req_id=${job_requisition_id_2}
    Switch to user    ${user_with_requisition}
    Change conversation status    ${candidate_name_1}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Wait with short time
    Click at    ${SCHEDULE_AN_INTERVIEW_CLOSE_BUTTON}
    Change conversation status    ${candidate_name_2}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Wait with short time
    Click at    ${SCHEDULE_AN_INTERVIEW_CLOSE_BUTTON}


View permissions -User was assigned, then being un-assigned on job requisitions will have not permission to view and action on all new candidates applied job (OL-T909)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Add job requisition to user
    # Add a candidate with job requisition
    Go to CEM page
    ${candidate_name_1} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    ${candidate_name_2} =    Add a Candidate    job_req_id=${job_requisition_id_2}
    Switch to user    ${user_with_requisition}
    # Change conversation to `Invite to Interview` status
    Change conversation status    ${candidate_name_1}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Wait with short time
    Click at    ${SCHEDULE_AN_INTERVIEW_CLOSE_BUTTON}
    # Change conversation to `Interview Pending` status
    Change conversation status    ${candidate_name_2}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SELECT}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}    user
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}    ${user_with_requisition}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}    To Close Choose Box
    Click at    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_BUTTON}
    # Remove job requisition from user
    Remove job requisition from user
    Go to CEM page
    ${candidate_name_3} =    Add a Candidate    job_req_id=${job_requisition_id_3}
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${candidate_name_1}
    Check element display on screen    ${candidate_name_2}
    Check element not display on screen    ${candidate_name_3}
    Add job requisition to user


View permissions -User was assigned, then being un-assigned on job requisitions will have not permission to view and action on old candidates wasnt scheduled with them (Invite to Interview, Interview Pending, Interview scheduled, Interview completed) (OL-T251)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Add job requisition to user
    # Add a candidate with job requisition
    Go to CEM page
    ${candidate_name_1} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    ${candidate_name_2} =    Add a Candidate    job_req_id=${job_requisition_id_2}
    Switch to user    ${user_with_requisition}
    # Change conversation to `Invite to Interview` status
    Change conversation status    ${candidate_name_1}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Wait with short time
    Click at    ${SCHEDULE_AN_INTERVIEW_CLOSE_BUTTON}
    # Change conversation to `Interview Pending` status
    Change conversation status    ${candidate_name_2}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SELECT}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}    user
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}    ${user_with_requisition}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}    To Close Choose Box
    Click at    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_BUTTON}
    # Remove job requisition from user
    Remove job requisition from user
    Go to CEM page
    ${candidate_name_3} =    Add a Candidate    job_req_id=${job_requisition_id_3}
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${candidate_name_1}
    Check element display on screen    ${candidate_name_2}
    Check element not display on screen    ${candidate_name_3}
    Add job requisition to user
