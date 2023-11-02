*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Variables           ../../../constants/ConversationConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${offer_name}                       Automation job
${job_family_name}                  Coffee family job
${test_location_name}               ${LOCATION_NAME_2}
${test_location_name_conv}          Vintners
${job_template}                     template_multi_location
${job_type}                         ${TYPE_MULTI_LOCATION}

*** Test Cases ***
Check the job builder page when create a new job (OL-T14688)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type        ${job_family_name}    ${job_type}
    Job builder page is organized with correctly tabs


Check UI of Overview tabs of Multi-location job (OL-T14689)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    wait for page load successfully
    Check element display on screen    ${INPUT_JOB_NAME}
    Check element display on screen    ${INPUT_JOB_DESCRIPTION}
    Check element display on screen    ${INPUT_JOB_CODE}
    Check span display    Locations
    Check element display on screen    ${ADD_LOCATION_BUTTON}
    Check span display    Shifts
    Check element display on screen    ${ADD_SHIFT_BUTTON}
    Check span display    Additional Details
    Check element display on screen    ${ADD_DETAIL_BUTTON}


Check adding for the location to Multi-location job is successful (OL-T14690)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    ${job_name} =    Generate random name    auto_job
    input job name    ${job_name}
    Click at    ${ADD_LOCATION_BUTTON}
    check span display    Remote Position
    check span display    Candidates who are hired for this job are able to work remotely
    Click at    ${TOGGLE_REMOTE_LOCATION}
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    Click at    ${LOCATION_IN_JOB}    ${test_location_name}
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    Check element display on screen    ${test_location_name}
    Check element display on screen    Remote
    Delete a Job    ${job_name}    ${job_family_name}


Check adding for shift to Multi-location job is successful (OL-T14691)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    ${job_name} =    generate random name    auto_job
    Input Job name    ${job_name}
    Click at    ${ADD_SHIFT_BUTTON}
    Check element display on screen    Morning
    Check element display on screen    Lunch
    Check element display on screen    Afternoon
    Check element display on screen    Evening
    Check element display on screen    Overnight
    Click at    ${SHIFT_CHECKBOX_BY_NAME}    Morning
    Click at    ${SAVE_SHIFT_BUTTON}
    ${shift} =    format string    ${SHIFT_IN_USED_BY_NAME}    Morning
    Check element display on screen    ${shift}
    Delete a Job    ${job_name}    ${job_family_name}


Check adding for new shift to Multi-location job is successful (OL-T14692)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    ${job_name} =    generate random name    auto_job
    Input Job name    ${job_name}
    Click at    ${ADD_SHIFT_BUTTON}
    Click at    ${SHIFT_CHECKBOX_BY_NAME}    Morning
    Click at    ${SHIFT_CHECKBOX_BY_NAME}    Evening
    Click at    ${SAVE_SHIFT_BUTTON}
    ${shift_morning} =    format string    ${SHIFT_IN_USED_BY_NAME}    Morning
    Check element display on screen    ${shift_morning}
    ${shift_evening} =    format string    ${SHIFT_IN_USED_BY_NAME}    Evening
    Check element display on screen    ${shift_evening}
    Click at    ${EDIT_SHIFT_BUTTON}
    Delete shift    Evening
    Add more shifts for job    ${job_name}
    Check element display on screen    ${job_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check adding User/user role to Hiring Team tab of Multi-location job (OL-T14693)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    ${job_name} =    generate random name    auto_job
    Input Job name    ${job_name}
    Add location for job    ${test_location_name}
    Click at    Hiring Team
    wait for page load successfully
    check span display    Decide which users can manage the candidate journey for this job
    check span display    Add a Hiring Team Role
    check span display    Add the Hiring Team Roles for this job.
    click on span text    Overview
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Delete a Job    ${job_name}    ${job_family_name}


Check selection CJ of Multi-location job (OL-T14694)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    select candidate journey job    Default Candidate Journey
    Delete a Job    ${job_name}    ${job_family_name}


Check Question is added to Multi-location job (OL-T14695,OL-T14696,OL-T14697,OL-T14698)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${job_type}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    select shift for job    Morning
    select more shift for job    Evening
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Add Candidate Journey for job    Default Candidate Journey
    Click at    ${SAVE_JOB_BUTTON}
    Click at    Screening
    Click at    Add Question
    Click at    ${REPLY_TYPE_QUESTION}
    Check element display on screen    Free Text
    Check element display on screen    Document Upload
    Check element display on screen    List select
    add question free text
    add question document upload
    add question List select
#    Check Outcome is added to Multi-location job (OL-T14696)
    add outcome send interview
#    Check Multi-location job is published (OL-T14697)
    Publish job
    go to my jobs page
    Status of Job toggle at My Job is off    ${job_name}    ${test_location_name}
#    Check Multi-location Job on My jobs (OL-T14698)
    Active a job    ${job_name}    ${test_location_name}
    Status of Job toggle at My Job is on    ${job_name}    ${test_location_name}
#    Check Multi-location Job on My jobs (OL-T14698)
    Input into    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${job_name}
    Click at        Open Shifts
    Check span display    Morning
    Check span display    Evening
#    Try to delete job, display popup ask turn off job before delete
    Go to Jobs page
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    Click at   ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}    slow_down=2s
    wait for page load successfully v1
    Click at    ${JOB_ECLIPSE_ICON}    ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    check span display    Cannot Delete This Job
    when Check element display on screen    You must turn off all locations for this job in My Jobs before you can delete it
    click on span text    Go to My Jobs
    wait for page load successfully v1
#    Turn off job and delete job
    deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Check Editing a Multi-location job (OL-T14699)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    create a job type Multi-Location with default candidate journey    ${job_name}    ${job_family_name}
    ...    ${test_location_name}
    Go to Job detail    ${job_name}    ${job_family_name}
    ${job_description} =    Generate random name    job_description
    ${job_code} =    Generate random name    job_code
    Input into    ${INPUT_JOB_DESCRIPTION}    ${job_description}
    Input into    ${INPUT_JOB_CODE}    ${job_code}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    Check element display on screen    ${STATUS_UNPUBLISHED}
    Publish job
    Delete a Job    ${job_name}    ${job_family_name}


Check candidate flow when candidate search and apply for a Multi-location job (OL-T14701,OL-T14703)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =    Generate random name    auto_job
    create a job type Multi-Location with default candidate journey    ${job_name}    ${job_family_name}
    ...    ${test_location_name}
#    Check candidate flow when candidate apply for a Multi-location job via job posting (OL-T14702)
    ${post_job_link} =    turn on job and get internal job link    ${job_name}    ${test_location_name}
    go to    ${post_job_link}
    wait with short time
    check message widget site response correct    ${I_CAN_HELP_YOU_TO_THE} ${job_name}
    ${candidate_name} =     Generate candidate name
    Input text for widget site    ${candidate_name.full_name}
    check message widget site response correct    ${ASK_EMAIL}
    ${email} =    Generate random name    ${CONFIG.gmail}
    Input text for widget site    ${email}
    check message widget site response correct    ${ASK_AGE}
    Input text for widget site    25
    check message widget site response correct    ${DO_ANY_OF_THESE_TIMES_WORK}
    Input text for widget site    1
#    Apply job via company site
    Go to company site      ${COMPANY_FRANCHISE_ON}
    Verify Olivia conversation message display    ${WHAT_OPPORTUNITY}
    Candidate input to landing site    ${ANY_JOB_IN_US}
    Verify Olivia conversation message display    ${GREAT_TAKE_A_LOOK_AT_THE}
    Click at   See All
    apply job    ${job_name}    ${test_location_name_conv}
    candidate input to landing site    ${candidate_name.full_name}
    deactivate a job    ${job_name}    ${test_location_name}
    Delete a Job    ${job_name}    ${job_family_name}


Create a Multi-location from job template (OL-T14700)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    create a job template multi-location    ${job_template}
    Go to Jobs page
    Create new job with type and template    ${job_family_name}    ${job_type}    ${job_template}
    add location for job    ${test_location_name}
    Click at    Candidate Journey
    wait for page load successfully
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    Hiring Manager
    Click at    ${SAVE_JOB_BUTTON}
    Publish job
    Delete a Job    ${job_template}    ${job_family_name}
