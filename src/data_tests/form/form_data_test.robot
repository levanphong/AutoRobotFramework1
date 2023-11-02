*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/candidate_journeys_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare candidate journey, workflow and form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    and go to form page
    and Create new form has pdf file   Authorization_for_Payroll_Deduction
    and Add a Candidate Journey  ${candidate_joruney}
    and Add a Journey Stage  ${candidate_joruney}   Form
    and Publish a Journey  ${candidate_joruney}
    and Create new job, publish and turn on my job  ${job_family_name}    ${job_name}    ${location_name}    ${user_name}   ${candidate_joruney}
    Go to My Jobs page
    Active a job    ${job_name}    ${location_name}


Prepare location for user form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to Location Management page
    ${is_existed} =    Run Keyword and Return Status    Check element display on screen    ${location_name}
    IF    '${is_existed}' == 'False'
        Hover at    ${AREA_NAME_TEXT}    ${COMPANY_NEXT_STEP}
        Click at    ${ADD_AREA_OR_LOCATION_ICON}    ${COMPANY_NEXT_STEP}
        Click at    ${ADD_MORE_ITEM_BUTTON}    Add a Location
        Input into    ${ADD_NEW_LOCATION_NAME_TEXT_BOX}    Florida
        Select state value    Florida
        Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}
    END


Prepare form for user form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create paragraph type form
    Create short answer type form
    Create checkbox type form
    Create drop down type form
    Create multi choice type form


Prepare Candidate Journey
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new candidate journey and publish    ${AUTO_CJ_SEND_FORM}        Form


Prepare create candidate form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Add new form and input name     Candidate   Onboarding
    Click publish form


Prepare job for user form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new job with CJ and Form     ${job_family}      ${paragraph_type_form}      Onboarding     None     ${job_paragraph_user_form}
    Create new job with CJ and Form     ${job_family}      ${short_answer_type_form}     Onboarding     None     ${job_short_answer_user_form}
    Create new job with CJ and Form     ${job_family}      ${checkbox_type_form}     Onboarding     None     ${job_checkbox_user_form}
    Create new job with CJ and Form     ${job_family}      ${drop_down_type_form}     Onboarding     None       ${job_drop_down_user_form}
    Create new job with CJ and Form     ${job_family}      ${multi_choice_type_form}     Onboarding      None        ${job_multi_choice_user_form}
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     ${multi_choice_type_form}      Onboarding      None        ${AUTO_JOB_DELETE_CANDIDATE_FORM}
