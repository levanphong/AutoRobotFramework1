*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${personal_information}     Personal Information
${street_address_line_2}    Street address (Line 2)

*** Test Cases ***
Prepare form has one personal information part
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Select form type    ${CANDIDATE_FORM_TYPE}
    Input into      ${SEARCH_FORM_TEXTBOX}      ${FORM_HAS_1_PERSONAL_INFORMATION}
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${FORM_HAS_1_PERSONAL_INFORMATION}   wait_time=5s
    IF    '${is_existed}' == 'False'
        Add new form and input name     ${CANDIDATE_FORM_TYPE}       ${FORM_HAS_1_PERSONAL_INFORMATION}
        Wait for page load successfully
        Click at    ${FORM_GO_TO_SECTION_DETAIL_ICON}   ${personal_information}
        Wait for page load successfully
        Click by JS     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}         ${street_address_line_2}
        Click at    ${FORM_SECTION_SAVE_BUTTON}
        Click publish form
    END


Create general form with custom question
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Select form type    ${CANDIDATE_FORM_TYPE}
    Input into      ${SEARCH_FORM_TEXTBOX}      ${FORM_CUSTOM_TASK_SECTION}
    ${is_created} =    Run Keyword and Return Status    Check element display on screen    ${FORM_BY_NAME}  ${FORM_CUSTOM_TASK_SECTION}      wait_time=1s
    IF    '${is_created}' == 'False'
        Add new form and input name     ${CANDIDATE_FORM_TYPE}     ${FORM_CUSTOM_TASK_SECTION}
        Add custom task for candidate form      ${short_answer}
        Add custom task for candidate form      ${paragraph}
        Add custom task for candidate form      ${multi_choice}
        Add custom task for candidate form      ${checkbox}
        Add custom task for candidate form      ${drop_down}
        Delete a task form       ${personal_information}
        Click publish form
    END


Prepare job for user send form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     Paragraph_type      ${FORM_HAS_1_PERSONAL_INFORMATION}     None     ${JOB_USER_SEND_FORM}
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     Paragraph_type      ${FORM_CUSTOM_TASK_SECTION}     None     ${JOB_GENERAL_FORM_CUSTOM_TASK}
