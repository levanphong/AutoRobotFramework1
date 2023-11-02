*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/base_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${custom_task_hidden}       Custom_task_hidden

*** Test Cases ***
Prepare form for user form in hire details
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create form with sensitive and hide from manager task
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     ${FORM_SELECT_SENSITIVE_HIDE}       Onboarding      None    ${JOB_FORM_SELECT_SENSITIVE_HIDE}

*** Keywords ***
Create form with sensitive and hide from manager task
    Go to form page
    Add new form and input name     ${USER_FORM_TYPE}   ${FORM_SELECT_SENSITIVE_HIDE}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Select task question response type      ${title_custom_question}      ${paragraph}
    Check the checkbox      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${title_custom_question}
    Click save task
    Click at    ${FORM_ADD_SECTION_BUTTON}
    Click at    ${FORM_ADD_TASK_BUTTON}
    Click at    ${FORM_ADD_TASK_OPTION}     ${custom_question}
    Input into      ${LAST_QUESTION_NAME_TEXTBOX}       ${custom_task_hidden}
    Select task question response type      ${custom_task_hidden}      ${short_answer}
    Check the checkbox      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${custom_task_hidden}
    Click save task
    Click publish form
