*** Settings ***
Variables       ../../locators/client_setup_locators.py
Resource        ../../pages/jobs_page.robot
Resource        ../../pages/conversation_builder_page.robot
Resource        ../../pages/web_management_page.robot
Resource        ../../drivers/driver_chrome.robot
Resource        ../../pages/location_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

# Pre-condition: 
# 1. new convo name:Multi Location Job Hire Path(hire path), turn off phonenumber quesiton
# 1a. Create landing site, named: MultiLocationJobLandingSite, assign convo
# 2. Create new location named: Dallas. Add user "Hiring Team", "CA Team", "Supervisor Team" to this location
# 3. Create new job name:"Multi Location Job", type Multi Location, template is template_multi_location, location:Dallas, Phoenix and Scottsdale
# 4a. Create second job name:"Multi Location Job 2", type Multi Location, template is template_multi_location, location:Dallas, Phoenix and Scottsdale
# 4b,Hiring Team tab, add 2 roles, "Company Admin", "Supervisor", uncheck "Can manage job" of "Supervisor Team"
# 5. Go to My job and turn on all location for 2 jobs

*** Variables ***
${landing_site_name}        MultiLocationJobLandingSite
${multi_location_job}       Multi Location Job
${multi_location_job_2}     Multi Location Job 2
${conversation_name}        Multi Location Job Hire Path

*** Test Cases ***
Prepare Multi Location Job step 1
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create new hire conversation for testing
    Create landing site/widget site    Landing Site    ${landing_site_name}    ${conversation_name}
    

Prepare Multi Location Job step 2-5
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add location for data test
    create the first job    ${multi_location_job}
    create the second job    ${multi_location_job_2}
    Turn on a Job    ${multi_location_job}    ${LOCATION_DALLAS}
    Turn on a Job    ${multi_location_job}    ${LOCATION_SCOTTSDALE}
    Turn on a Job    ${multi_location_job}    ${LOCATION_PHOENIX}
    Turn on a Job    ${multi_location_job_2}    ${LOCATION_DALLAS}
    Turn on a Job    ${multi_location_job_2}    ${LOCATION_SCOTTSDALE}
    Turn on a Job    ${multi_location_job_2}    ${LOCATION_PHOENIX}

*** Keywords ***
Add location for data test
    Add a Location    ${COMPANY_FRANCHISE_ON}    ${LOCATION_DALLAS}
    Assign user to location    ${LOCATION_DALLAS}    ${CA_TEAM}
    Click at    ${INPUT_USER_VIEW}
    ${user_locator} =    format string    ${USER_SUGGEST}    ${SV_TEAM}
    Scroll to element by JS    ${user_locator}
    Click at    ${user_locator}
    Click at    ${INPUT_USER_VIEW}
    ${user_locator} =    format string    ${USER_SUGGEST}    ${HM_TEAM}
    Scroll to element by JS    ${user_locator}
    Click at    ${user_locator}
    Click at    ${LOCATION_FORM_SAVE_BUTTON}
Create new hire conversation for testing
    Go to conversation builder
    Click add conversation
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    Click at   ${HIRE_TEMPLETE}
    Turn off   ${SINGLE_PATH_QUESTION_TOGGLE}  Phone Number
    Public the conversation

create the first job
    [Arguments]    ${job_name}
    go to jobs page
    Create new job with type    ${JF_COFFEE_FAMILY_JOB}    ${TYPE_MULTI_LOCATION}    ${MULTI_LOCATION_TEMPLATE}
    Rename Job name    ${job_name}
    ${location_list} =  Create List    ${LOCATION_DALLAS}    ${LOCATION_SCOTTSDALE}    ${LOCATION_PHOENIX}
    Add location for job  ${location_list}
    Click at   Candidate Journey
    select candidate journey job    ${DEFAULT_CANDIDATE_JOURNEY}
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    ${HM}
    Publish job

create the second job
    [Arguments]    ${job_name}
    go to jobs page
    Create new job with type    ${JF_COFFEE_FAMILY_JOB}    ${TYPE_MULTI_LOCATION}    ${MULTI_LOCATION_TEMPLATE}
    Rename Job name    ${job_name}
    ${location_list} =  Create List    ${LOCATION_DALLAS}    ${LOCATION_SCOTTSDALE}    ${LOCATION_PHOENIX}
    Add location for job  ${location_list}
    #    Add hiring team
    Click at   Hiring Team
    Click at    ${JOB_ADD_USER_BUTTON}
    Click at    ${HIRING_TEAM_USER}    ${CP_ADMIN}
    Click at    ${HIRING_TEAM_USER}    ${SUPER_VISOR}
    Click at    ${APPLY_BUTTON}
    wait with short time
    Check the checkbox    ${ADD_HIRING_TEAM_CAN_MANAGE_CHECKBOX}    ${SUPER_VISOR}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully v1
    Click at   Candidate Journey
    select candidate journey job    ${DEFAULT_CANDIDATE_JOURNEY}
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    ${HM}
    Publish job