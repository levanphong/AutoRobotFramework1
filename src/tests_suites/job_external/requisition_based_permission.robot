*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../data_tests/job_external/requisition_based_permission.robot
Resource            ../../pages/users_page.robot
Resource            ../../pages/my_profile_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/all_candidates_page.robot
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
Users page - The option ‘Requisition permissions’ is added on Users page when "Requisition based permissions" toggle ON (OL-T230)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Check element display on screen    Requisition permissions
    Check element display on screen    ${EDIT_REQUISITIONS_BUTTON}


View permissions - Paradox Admin/Company admin view permission of users (OL-T233)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Check element display on screen    ${REQUISITIONS_LIST_JOB}


Search job requisition - Search by all columns for job requisitions successfully (OL-T234)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # For Admin Role
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    ${title} =    Get text and format text    ${JOB_REQUISITION_TITLE_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${title}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    ${category} =    Get text and format text    ${JOB_CATEGORY_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${category}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    ${city} =    Get text and format text    ${JOB_CITY_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${city}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    ${state} =    Get text and format text    ${JOB_STATE_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${state}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    # For Full User Role
    Switch to user    ${user_with_requisition}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    ${title} =    Get text and format text    ${JOB_REQUISITION_TITLE_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${title}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    ${category} =    Get text and format text    ${JOB_CATEGORY_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${category}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    ${city} =    Get text and format text    ${JOB_CITY_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${city}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    ${state} =    Get text and format text    ${JOB_STATE_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    ${state}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    Input into    ${JOB_REQUISITIONS_SEARCH_TEXT_BOX}    Something not exist
    Check element not display on screen    ${JOB_REQUISITION_ID_TEXT}


Add job permissions - Paradox Admin/Company admin add permission for users successfully (OL-T235)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Click at    ${JOB_REQUISITION_UNSELECTED_CHECKBOX}
    Click at    ${REQUISITIONS_SAVE_BUTTON}
    Check element display on screen    Your change has been saved.


Remove job permission - Paradox Admin/Company admin remove permission for users successfully (OL-T236)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_SELECTED_CHECKBOX}
    Click at    ${REQUISITIONS_SAVE_BUTTON}
    Check element display on screen    Your change has been saved.


Requisition base permissions modal - Dropdown to ‘Show all requisitions’ is added when Paradox Admin/Company admin click on "View permission" (OL-T237)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Check element display on screen    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Switch to user    Full User Automation
    Go to Users page
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Check element not display on screen    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}


View all requisition - List alll the jobs available on the feed will show when select "Show all requisitions" (OL-T238)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Check element display on screen    ${JOB_REQUISITION_UNSELECTED_CHECKBOX}
    Check element display on screen    ${JOB_REQUISITION_SELECTED_CHECKBOX}


View all assigned job - Show list all assigned job when Admin/Paradox Admin click on "Show all assigned" (OL-T239)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all assigned
    Check element display on screen    ${JOB_REQUISITION_SELECTED_CHECKBOX}
    Check element not display on screen    ${JOB_REQUISITION_UNSELECTED_CHECKBOX}


Requisition base permissions modal - "Cancel" and "Save" buttons are appeared when any updates are made to the permissions for user (OL-T240)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_SELECTED_CHECKBOX}
    Check element display on screen    ${REQUISITIONS_SAVE_BUTTON}
    Check element display on screen    ${REQUISITIONS_CANCEL_BUTTON}


View permissions - Full user view the user with no requisitions assigned (OL-T242)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_without_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Check element display on screen    ${user_without_requisition} Automation has no viewing permissions yet.


View permissions - Full user view the users that have requisitions assigned (OL-T243)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Switch to user    ${user_with_requisition}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Check element not display on screen    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Check element not display on screen    ${JOB_REQUISITION_UNSELECTED_CHECKBOX}
    Check element not display on screen    ${JOB_REQUISITION_SELECTED_CHECKBOX}


My profile page - The user profile will display all the req’s they are assigned to (OL-T246)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Switch to user    ${user_with_requisition}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    ${assigned_requisitions} =    Get text and format text    ${REQUISITIONS_ASSIGNED_TEXT}
    Go to My Profile page
    Click at    ${VIEW_PERMISSIONS_BUTTON}
    Check element display on screen    ${assigned_requisitions}


Client setup page - New settings will be added on client setup (OL-T229)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Navigate to    Client Setup
    Click at    ${MORE_LABEL}
    Check element display on screen    ${REQUISITION_BASED_PERMISSIONS_TOGGLE}
    Logout from System
    Login into system with company    Full User - Edit Everything    ${COMPANY_COMMON}
    Navigate to    Client Setup
    ${window_title} =    Get title
    Should Be Equal As Strings    ${window_title}    Inbox | Candidate Experience Manager


View permissions - All user will have the permissions on the requisition when the requisition has multiple users assigned (OL-T247)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_1}
    Run Keyword and ignore Error    Click at    ${REQUISITIONS_SAVE_BUTTON}
    # Add a candidate with job req
    Go to CEM page
    ${candidate_name} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${candidate_name}


View permissions - User can view and action on all the candidates submissions when the candidate has applied to multiple jobs with the same recruiter/ hiring manager are assigned (OL-T248)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_1}
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_2}
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_3}
    Run Keyword and ignore Error    Click at    ${REQUISITIONS_SAVE_BUTTON}
    # Add a candidate with job requisition
    Go to CEM page
    ${candidate_name_1} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    ${candidate_name_2} =    Add a Candidate    job_req_id=${job_requisition_id_2}
    ${candidate_name_3} =    Add a Candidate    job_req_id=${job_requisition_id_3}
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name_1}
    Check element display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name_2}
    Check element display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name_3}


View permissions - User can view the candidates and actions only to the req they are assigned when the candidate has applied to multiple jobs with the differrent recruiter/ hiring manager are assigned (OL-T249)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_1}
    Run Keyword and ignore Error    Click at    ${REQUISITIONS_SAVE_BUTTON}
    # Add a candidate with job requisition
    Go to CEM page
    ${candidate_name} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Switch to user    ${user_with_requisition}
    Check element display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name}
    Switch to user    ${user_without_requisition}
    Check element not display on screen    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name}


View permissions - Paradox Admin/Company admin view the user with no requisitions assigned (OL-T241)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Add Job Requisition
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_without_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Click at    Assign job requisitions
    Check element not display on screen    ${JOB_REQUISITION_SELECTED_CHECKBOX}
    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    ${option_clickable} =    Run keyword and Return status    Click at    Show all assigned
    Should be Equal as Strings    '${option_clickable}'    'False'


GUI - All assigned job viewed by Admin/Paradox Admin (OL-T685)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    ${user_name} =    Get text and format text    ${REQUISITION_USER_NAME}
    Should be Equal as Strings    ${user_name}    ${user_with_requisition} Automation
    Check element display on screen    requisitions assigned
    Check element display on screen    ${JOB_REQUISITION_SELECTED_CHECKBOX}
    Check element not display on screen    ${JOB_REQUISITION_UNSELECTED_CHECKBOX}
    Check element display on screen    ${JOB_REQUISITION_ID_TEXT}
    Check element display on screen    ${JOB_REQUISITION_TITLE_TEXT}
    Check element display on screen    ${JOB_CATEGORY_TEXT}
    Check element display on screen    ${JOB_CITY_TEXT}
    Check element display on screen    ${JOB_STATE_TEXT}
    Check element display on screen    ${JOB_EMPLOYMENT_TYPE_TEXT}


View permissions - Candidate applies the job that is not assigned to any user on CEM, but assigned on the job feed (user isn't existing on CEM) (OL-T771)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CEM page
    ${candidate_name} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Check element display on screen    ${candidate_name}
    Switch to user    ${user_without_requisition}
    Check element not display on screen    ${candidate_name}


List attendee - Users that are assigned to the job should be shown in the list of attendee when making a schedule for candidate (OL-T775)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CEM page
    ${candidate_name} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Switch to user    ${user_with_requisition}
    Change conversation status    ${candidate_name}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SELECT}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}
    Check element display on screen    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}    ${user_with_requisition}


View permissions - Users can view and action on all the candidates submissions when candidate has applied to jobs that user was assigned (OL-T851)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CEM page
    ${candidate_name} =    Add a Candidate    job_req_id=${job_requisition_id_1}
    Switch to user    ${user_with_requisition}
    Change conversation status    ${candidate_name}    Scheduling    Invite to Interview
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SELECT}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}
