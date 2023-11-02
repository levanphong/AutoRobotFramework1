*** Settings ***
Variables       ../../locators/client_setup_locators.py
Resource        ../../drivers/driver_chrome.robot
Resource        ../../pages/base_page.robot
Resource        ../../pages/users_page.robot
Resource        ../../pages/round_robin_management_page.robot
Resource        ../../pages/jobs_page.robot
Resource        ../../pages/my_jobs_page.robot
Resource        ../../pages/client_setup_page.robot
Resource        ../../pages/location_management_page.robot
Test Setup      Open Chrome

*** Test Cases ***
Create data test for scheduling new ui ux
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_TEST_AUTOMATION_SCHEDULE_CANDIDATES}
    Go to CEM page
    @{list_5_users}=    Create List     ${FO_TEAM}     ${FS_TEAM}     ${EN_TEAM}     ${EE_TEAM}     ${HM_TEAM}
    Add a new Round Robin     Round_robin_with_5_users       ${list_5_users}
    @{list_6_users}=    Create List     ${FO_TEAM}     ${FS_TEAM}     ${EN_TEAM}     ${EE_TEAM}     ${HM_TEAM}     ${RC_TEAM}
    Add a new Round Robin     Round_robin_with_6_users      ${list_6_users}
    Creare data test for scheduling new ui ux
    go to location management page
    @{list_location}=       create list     Location_schedule      Location_schedule_no_room
    FOR     ${location}     IN      @{list_location}
        ${is_existed}=      Run Keyword and return Status       Check element display on screen     ${location}
        IF      '${is_existed}'== 'False'
            Add a Location      ${COMPANY_TEST_AUTOMATION_SCHEDULE_CANDIDATES}      ${location}
        END
    END
    ${is_existed}=      run keyword and return status     check element display on screen       Location_schedule
    IF      '${is_existed}'== 'False'
        Add a Location      ${COMPANY_TEST_AUTOMATION_SCHEDULE_CANDIDATES}      Location_schedule
    END
    go to location management page
    Choose location     Location_schedule
    Add new room for location       Room schedule       1345


Create new job for scheduling new ui ux
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${DROPDOWN_JOB_NEW}
    wait until element is visible  ${NEXT_BUTTON_ON_MODAL}
    wait with short time
    Click at    ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    Schedule job
    Click at    ${SAVE_JOB_ON_MODAL}
    wait with short time
    input job name    Job_scheduling
    Add location for job    New York
    Add Hiring Team for job  EN Team
    wait for page load successfully
    Add Candidate Journey for job      Default Candidate Journey
    wait for page load successfully
    Add Screening Question for job
    Publish job
    Go to My Jobs page
    Active a job    Job_scheduling      New York

*** Keywords ***
Creare data test for scheduling new ui ux
    Enable Client Setup for scheduling new ui ux   Scheduling
    Enable Client Setup for scheduling new ui ux   Care
    Enable Client Setup for scheduling new ui ux   Hire
