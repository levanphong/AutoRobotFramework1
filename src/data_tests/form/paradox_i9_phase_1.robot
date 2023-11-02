*** Settings ***
Resource            ../../pages/employer_tax_information_page.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Create new company for checking employer tax information
    Given Setup test
    Login into system       ${PARADOX_ADMIN}
    Add company for testing     ${COMPANY_PARADOX_I9}
    Turn on next steps in client setup page
    Turn on tax withholding toggle
    Select Available Job Types
    Save client setup page
    Add a Location      ${COMPANY_PARADOX_I9}       ${LOCATION_CITY_FLORIDA}
    Go to employer tax information
    Add new employer tax information    &{employer_tax_information}
    Add new employer tax information    &{employer_tax_information_2}
    # NOTE
    # Add Company Admin role
    # Create job family Paradox Form Job Family
    # Create CA Team with Company Admin Role
    # Assign CA Team to location Florida


Add new candidate journey for paradox i9 form phase 1
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_PARADOX_I9}
    Go to Candidate Journeys page
    Add a Candidate Journey     ${CJ_PARADOX_I9_PHASE_1_FORM}
    Click a Journey     ${CJ_PARADOX_I9_PHASE_1_FORM}
    Add a stage     Onboarding
    Click at    ${STAGE_NAME_IN_JOURNEY}    Onboarding
    Click at    Onboarding Complete
    Add next step button for a status       Send Onboarding     Send User Form
    Publish a Journey       ${CJ_PARADOX_I9_PHASE_1_FORM}


Prepare data for Paradox I9 Phase 1 form
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_PARADOX_I9}
    Create new user paradox i9 form phase 1
    Create new candidate paradox i9 form phase 1
    Create new job for paradox i9 phase 1 form

*** Keywords ***
Create new job for paradox i9 phase 1 form
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${DROPDOWN_JOB_NEW}
    Click at    ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${JF_PARADOX_FORM_JOBS}
    Click at    ${SAVE_JOB_ON_MODAL}
    Input job name    ${JOB_PARADOX_I9_PHASE_1}
    Add location for job    ${LOCATION_CITY_FLORIDA}
    Add Hiring Team for job     ${CP_ADMIN}
    Set candidate journey and add form in onboading journey     ${CJ_PARADOX_I9_PHASE_1_FORM}   ${FORM_USER_PARADOX_I9_PHASE_1}     ${FORM_CANDIDATE_PARADOX_I9_PHASE_1}
    Add Screening Question for job
    Publish job
    Active a job    ${JOB_PARADOX_I9_PHASE_1}   ${LOCATION_CITY_FLORIDA}

Create new user paradox i9 form phase 1
    Go to form page
    Add new form and input name     ${USER_FORM_TYPE}       ${FORM_USER_PARADOX_I9_PHASE_1}
    Go to a form section detail     ${default_section}
    Add a form task with type and save       ${custom_question}
    Add a form section with valid infor     ${I9_part_II}
    Add a form section with valid infor     ${I9_part_III}
    Click publish form

Create new candidate paradox i9 form phase 1
    Go to form page
    Add new form and input name     ${CANDIDATE_FORM_TYPE}      ${FORM_CANDIDATE_PARADOX_I9_PHASE_1}
    Add a form section with valid infor     ${I_9}
    Click publish form

Set candidate journey and add form in onboading journey
    [Arguments]     ${cj_name}      ${user_form}    ${candidate_form}
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${cj_name}
    Click on span text    ${cj_name}
    Add attendee for interview    ${CP_ADMIN}
    Select candidate form for candidate journey     ${candidate_form}       Onboarding
    Select user form for Candidate journey      ${user_form}
    Click at    ${SAVE_JOB_BUTTON}
