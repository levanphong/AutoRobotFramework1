*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/my_profile_page.robot


Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{multilingual}     Japanese (ja)    French (fr)

*** Test Cases ***
Prepare test data for form in multilingual
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Add company admin and setting language      CA  Japanese    Japanese
    Add company admin and setting language      CA  Vietnamese    Vietnamese
    Switch to user  ${TEAM_USER}
    Add form in multilangual
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     ${FORM_IN_MULTILINGUAL}     Onboarding      None    ${JOB_FORM_IN_MULTILINGUAL}

*** Keyword ***
Add form in multilangual
    Go to form page
    Add new form and input name     ${USER_FORM_TYPE}       ${FORM_IN_MULTILINGUAL}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Select task question response type      ${title_custom_question}    ${paragraph}
    Check the checkbox      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${title_custom_question}
    Check the checkbox      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${title_custom_question}
    Turn on     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${title_custom_question}
    Click save task
    Add languages for form      @{multilingual}
    Click publish form

Add company admin and setting language
    [Arguments]     ${first_name}   ${last_name}    ${language}
    Switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Add a User      ${first_name}   ${last_name}    Company Admin   is_spam_email=False
    Switch to user  ${first_name} ${last_name}
    Go to My Profile page
    Select user flatform language   ${language}

