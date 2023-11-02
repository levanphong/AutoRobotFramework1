*** Settings ***
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

Force Tags         lts_stg    regression    skip

Documentation   Multi-location is selected at Hire tab, Job ON

*** Variables ***
${auto_job}                 auto_job
${free_text}                Free Text
${list_select}              List select
${landing_site_name}        MultiLocationJobLandingSite
${multi_location_job}       Multi Location Job
${multi_location_job_2}     Multi Location Job 2

*** Test Cases ***
Check the job builder page when create a new job (OL-T14689, OL-T14688)
    Initial and go to overview of job page
    Check UI of overview step for new job page


Check adding for the location to Multi-location job is successful (OL-T14690)
    ${job_name} =  Initial and go to overview of job page
    Add location for job    ${LOCATION_PHOENIX}   remote=True
    Delete a Job    ${job_name}   ${JF_COFFEE_FAMILY_JOB}


Check adding for shift to Multi-location job is successful (OL-T14691, OL-T14692)
    ${job_name} =  Initial and go to overview of job page
    CLick at  ${OVERVIEW_STEP_ADD_SHIFTS_BUTTON}
    Check text display  Add the shifts that are available for this job.
    Check element display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${MORNING}
    Check element display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${LUNCH}
    Check element display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${AFTERNOON}
    Check element display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${EVENING}
    Check element display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${OVERNIGHT}
    Delete a shift   ${MORNING}
    Add a shift   ${MORNING}
    #   Select some shifts
    Click at  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${MORNING}
    Click at  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${LUNCH}
    Click at  ${SAVE_SHIFT_BUTTON}
    Check element display on screen  ${SHIFT_IN_USED_BY_NAME}    ${LUNCH}, ${MORNING}
    Delete a Job    ${job_name}   ${JF_COFFEE_FAMILY_JOB}


Check adding User/user role to Hiring Team tab of Multi-location job (OL-T14693)
    ${job_name} =  Initial and go to overview of job page
    Add location for job    ${LOCATION_PHOENIX}
    Click at  ${OVERVIEW_STEP_HIRING_TEAM_LABEL}
    Check element display on screen  Decide which users can manage the candidate journey for this job. Users will only be able to manage candidates at their assigned locations.
    Check element display on screen  Add the Hiring Team Roles for this job.
    #   Add hirring team
    Click at    ${JOB_ADD_ROLE_BUTTON}
    Click on span text  ${HM}
    Click at    ${APPLY_BUTTON}
    #   After add hiring team, "Add the Hiring Team Roles for this job." disappeared, Add user button displays, then add user
    Check element not display on screen  Add the Hiring Team Roles for this job.
    Click at    ${JOB_ADD_USER_BUTTON}
    input into    ${INPUT_SEARCH_USER}    ${HM}
    Click at    ${HIRING_TEAM_USER}    ${HM}
    input into    ${INPUT_SEARCH_USER}    ${FS}
    Click at    ${HIRING_TEAM_USER}    ${FS}
    Click at    ${APPLY_BUTTON}
    check element display on screen  ${ADD_HIRING_TEAM_USER_LABEL}  ${HM}
    check element display on screen  ${ADD_HIRING_TEAM_USER_LABEL}  ${FS}
    Delete a Job    ${job_name}   ${JF_COFFEE_FAMILY_JOB}


Check Question and outcome are added to Multi-location job when reply type is Free Text (OL-T14695)
    ${job_name} =  Initial and go to overview of job page
    Add location for job    ${LOCATION_PHOENIX}
    Add Hiring Team for job type Standard/Muti-Location    ${HM}
    Select candidate journey
    # add screening question for job
    Click at    ${OVERVIEW_STEP_SCREENING_LABEL}
    Check span display  Create the questions Olivia should ask this candidate   wait_time=5s
    Click at    Add Question
    Check items in reply type dropdown and then select a type   ${free_text}
    ${question_name} =   add question free text
    Check element display on screen  ${ADD_QUESTION_SCREEN_QUESTION_ADDED_LABEL}    1
    Check element display on screen  ${ADD_QUESTION_SCREEN_QUESTION_ADDED_LABEL}    ${question_name}
    # add outcome send interview
    Check UI of Add Outcome dialog and add an outcome   ${question_name}    ${free_text}
    Delete a Job    ${job_name}   ${JF_COFFEE_FAMILY_JOB}


Check Question and outcome are added to Multi-location job when reply type is List Select (OL-T14696)
    ${job_name} =  Initial and go to overview of job page
    Add location for job    ${LOCATION_PHOENIX}
    Add Hiring Team for job type Standard/Muti-Location    ${HM}
    Select candidate journey
    # add screening question for job
    Click at    ${OVERVIEW_STEP_SCREENING_LABEL}
    Check span display  Create the questions Olivia should ask this candidate   wait_time=5s
    ${question_name}  ${list_select_item} =   add question List select
    # add outcome send interview
    Check UI of Add Outcome dialog and add an outcome   ${question_name}    ${list_select}   ${list_select_item}
    Delete a Job    ${job_name}   ${JF_COFFEE_FAMILY_JOB}


Check Multi-location job is published (OL-T14697, OL-T14694, OL-T14698, OL-T14699)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    ${auto_job}
    create a job type Multi-Location with default candidate journey   ${job_name}  ${JF_COFFEE_FAMILY_JOB}  ${LOCATION_PHOENIX}
    Search job by location and job name  ${job_name}    ${LOCATION_PHOENIX}
    The checkbox should not be checked   ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}
    #   Turn on JOB
    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}    ${job_name}
    Check span display       Are you sure you want to post this job?
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Post Job
    Check element display on screen     ${job_name} has been posted!
    #   Edit job and publish again
    ${new_job_name} =    Generate random name    ${auto_job}
    Edit job name then publish   ${job_name}    ${new_job_name}
    Search job by location and job name  ${new_job_name}    ${LOCATION_PHOENIX}
    The checkbox should be checked   ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}
    #    Turn off job
    Turn off     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}    ${new_job_name}
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Close Job
    check element display on screen     ${new_job_name} has been updated!
    Delete a Job  ${new_job_name}  ${JF_COFFEE_FAMILY_JOB}


Create a Multi-location from job template (OL-T14700)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    ${auto_job}
    create a job, type Multi-Location and select a job template   ${job_name}  ${JF_COFFEE_FAMILY_JOB}
    Go to My Jobs page
    Search job by location and job name  ${job_name}
    The checkbox should not be checked   ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}


Check candidate flow when candidate search and apply for a Multi-location job (OL-T14701)
    Setup test
    ${site_url} =  Get landing site url by string concatenation    COMPANY_FRANCHISE_ON    ${landing_site_name}
    Go to   ${site_url}
    Wait for Olivia reply
    #    Search job and apply job
    Candidate input to landing site    1
    Verify AI message when asking about location in    Landing Site
    Candidate input to landing site    ${LOCATION_DALLAS}
    Apply job on landing site    ${multi_location_job}
    #    Input information
    ${candidate_name} =  Candidate input neccessary information    Landing Site
    #    Login and check candidate infor
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Verify information in candidate summary    ${candidate_name}


Check candidate flow when candidate apply for a Multi-location job via job posting (OL-T14702)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${posting_job_url} =  Search job and get internal job link    ${multi_location_job}    ${LOCATION_DALLAS}
    Go to  ${posting_job_url}
    Wait for Olivia reply
    ${candidate_name} =  Candidate input neccessary information    Widget Conversation
    Go to CEM page
    Verify information in candidate summary    ${candidate_name}


Check permission of User when viewing Candidate on CEM is work correctly - Multi-location job (OL-T14703)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${candidate_name} =   Add a Candidate   location_name=${LOCATION_DALLAS}   job_name=${multi_location_job}
    Switch to user    ${HM_TEAM}
    Verify information in candidate summary    ${candidate_name}
    #    Verify users who are not assigned to Dallas, wont see the candidate
    Switch to user    ${EN_TEAM}
    ${is_candidate_displayed} =  Run keyword and return status   Open a candidate Conversation    ${candidate_name}
    Run Keyword If    ${is_candidate_displayed}    Fail
    Switch to user    ${EE_TEAM}
    ${is_candidate_displayed} =  Run keyword and return status   Open a candidate Conversation    ${candidate_name}
    Run Keyword If    ${is_candidate_displayed}    Fail
    Switch to user    ${RP_TEAM}
    ${is_candidate_displayed} =  Run keyword and return status   Open a candidate Conversation    ${candidate_name}
    Run Keyword If    ${is_candidate_displayed}    Fail


Check permission of User when Job in My jobs is work correctly - Multi-location job (OL-T14704)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    Switch to user    ${CA_TEAM}
    Turn off a Job    ${multi_location_job_2}    ${LOCATION_DALLAS}
    Turn on a Job    ${multi_location_job_2}    ${LOCATION_DALLAS}
    Switch to user    ${SV_TEAM}
    ${can_manage_job} =  Run keyword and return status   Turn off a Job    ${multi_location_job_2}    ${LOCATION_DALLAS}
    Run Keyword If    ${can_manage_job}    Fail

*** Keywords ***
Candidate input neccessary information
    [Arguments]    ${site_type}
    ${candidate_info} =      Generate candidate name
    &{email_info} =    Get email for testing
    ${age_number} =  Set Variable   25
    IF    '${site_type}' == 'Landing Site'
        Verify AI message when asking about name in    ${site_type}
        Candidate input to landing site    ${candidate_info.full_name}
        Verify AI message when asking about email in    ${site_type}
        Candidate input to landing site    ${email_info.email}
        ${latest_message} =  Get latest message of Olivia in Shadow Root
        Should Be Equal As Strings    ${latest_message}    ${REPROMPT_AGE_MESSAGE_1}
        Candidate input to landing site    ${age_number}
    ELSE
        Verify AI message when asking about name in    ${site_type}
        Input text for widget site    ${candidate_info.full_name}
        Verify AI message when asking about email in    ${site_type}
        Input text for widget site    ${email_info.email}
        ${latest_message} =  Get latest message of Olivia in Shadow Root
        Should Be Equal As Strings    ${latest_message}    ${REPROMPT_AGE_MESSAGE_1}
        Input text for widget site    ${age_number}
    END
    [Return]   ${candidate_info.full_name}

Verify information in candidate summary
    [Arguments]  ${candidate_name}
    Open a candidate Conversation    ${candidate_name}
    Check status on profile CEM    ${CAPTURE_COMPLETE_STATUS}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${multi_location_job}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${LOCATION_DALLAS}

Check UI of Add Outcome dialog and add an outcome
    [Arguments]   ${question_name}   ${reply_type}   ${list_select_item}=None
    Click at    ${JOB_ADD_OUTCOME_BUTTON}
    Click at    ${JOB_ADD_OUTCOME_BUTTON_ON_MODAL}
    Click at    ${JOB_ADD_OUTCOME_NAME_INPUT_LABEL}
    Input into    ${JOB_ADD_OUTCOME_NAME_INPUT}    send_interview
    Click at    ${SELECT_QUESTION}
    click on span text    ${question_name}
    #   Check "Matches" dropdown
    Click at    ${SELECT_MATCH}
    IF   '${reply_type}' == 'Free Text'
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  Select
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  At most
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  At least
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  Yes
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  No
        Click at    ${OUTCOMES_MATCHES_ITEM}  At least
        Input into    ${INPUT_VALUE}    25
    ELSE IF   '${reply_type}' == '${list_select}'
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  Select
        Check element display on screen    ${OUTCOMES_MATCHES_ITEM}  ${list_select_item}
        Click at    ${OUTCOMES_MATCHES_ITEM}  ${list_select_item}
    END
    Input into    ${TEXT_AREA_MSG}    send interview
    Click at    ${MOVE_TO_STATUS}
    Click at    ${STATUS_INVITE_TO_INTERVIEW}
    Click at    ${SAVE_OUTCOME_BUTTON}
    Click at    ${SAVE_ALL_OUTCOME_BUTTON}
    Click at    ${SAVE_JOB_BUTTON}
    Check element display on screen  ${OUTCOMES_LABEL}  Default Outcome
    Check element display on screen  ${OUTCOMES_LABEL}  send_interview

Check items in reply type dropdown and then select a type
    [Arguments]  ${reply_type}
    Click at  ${REPLY_TYPE_QUESTION}
    Check element display on screen  ${ADD_QUESTION_REPLY_TYPE_ITEM}    ${free_text}
    Check element display on screen  ${ADD_QUESTION_REPLY_TYPE_ITEM}    Document Upload
    Check element display on screen  ${ADD_QUESTION_REPLY_TYPE_ITEM}    ${list_select}
    Check element display on screen  ${ADD_QUESTION_REPLY_TYPE_ITEM}    Video
    Click at  ${ADD_QUESTION_REPLY_TYPE_ITEM}    ${reply_type}

Add a shift
    [Arguments]   ${shift_name}
    Click at  Add More Shifts
    Input into  ${SHIFT_NAME_TEXTBOX}   ${shift_name}
    Click at  ${ADD_SHIFTS_CONFIRM_SHIFT_NAME_BUTTON}
    Check element display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${shift_name}


Delete a shift
    [Arguments]   ${shift_name}
    Click at  ${SHIFT_ECLIPSE_BUTTON}   ${shift_name}
    Click at  ${DELETE_SHIFT_BUTTON}
    Check element not display on screen  ${ADD_SHIFTS_AVAILABLE_SHIFT_LABEL}    ${shift_name}

Initial and go to overview of job page
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    ${job_name} =    Generate random name    ${auto_job}
    Create new job with type    ${JF_COFFEE_FAMILY_JOB}    ${TYPE_MULTI_LOCATION}
    Input into    ${INPUT_ICON_JOB_NAME}    ${job_name}
    [Return]  ${job_name}
   
Check UI of overview step for new job page
    #   Check order of left tabs
    Check element display on screen  ${OVERVIEW_STEP_OVERVIEW_LABEL}
    Check element display on screen  ${OVERVIEW_STEP_HIRING_TEAM_LABEL}
    Check element display on screen  ${OVERVIEW_STEP_CANDIDATE_JOURNEY_LABEL}
    Check element display on screen  ${OVERVIEW_STEP_SCREENING_LABEL}
    #   Check design right side
    Check element display on screen  ${OVERVIEW_STEP_SELECT_LANGUAGE_BUTTON}
    Check element display on screen  ${BUTTON_SAVE_SELECT_DATA_PACKAGE}
    Check element display on screen  ${OVERVIEW_STEP_JOB_DESCRIPTION_TEXTBOX}
    Check element display on screen  ${OVERVIEW_STEP_SELECT_TEXT_FORMAT_DROPDOWN}
    Check element display on screen  ${OVERVIEW_STEP_SELECT_TEXT_FONT_DROPDOWN}
    Check element display on screen  ${OVERVIEW_STEP_BOLD_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_ITALIC_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_UNDERLINE_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_LINK_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_LIST_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_JOB_CODE_TEXTBOX}
    Check element display on screen  ${OVERVIEW_STEP_JOB_POSTING_TYPE_DROPDOWN}
    Check element display on screen  ${OVERVIEW_STEP_ADD_SHIFTS_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_ADD_DETAILS_BUTTON}
    Check element display on screen  ${OVERVIEW_STEP_ADD_DETAILS_BUTTON}
    Check element display on screen  ${ADD_LOCATION_BUTTON}

create a job, type Multi-Location and select a job template
    [Arguments]    ${job_name}    ${job_family_name}    ${job_template}=${MULTI_LOCATION_TEMPLATE}
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_MULTI_LOCATION}    ${job_template}
    Rename Job name    ${job_name}
    Add location for job  ${LOCATION_PHOENIX}
    Click at   Candidate Journey
    select candidate journey job    ${DEFAULT_CANDIDATE_JOURNEY}
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    ${HM}
    Publish job
