*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${form_user_lookup_checked}             User_Lookup_Type_Checked
${form_location_lookup_checked}         Location_Lookup_Type_Checked
${question_name_1}                      Question 1
${form_user_lookup_unchecked}           User_Lookup_Type_Unchecked
${form_location_lookup_unchecked}       Location_Lookup_Type_Unchecked
${question_name_2}                      Question 2

*** Test Cases ***
Prepare test data for form with answer type = user lookup with element is check
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Add new form and input name     ${user_form}    ${form_user_lookup_checked}
    Create Custom Question task type with answer type       ${user_lookup}      ${question_name_1}      ${default_section}
    Go to a form section detail     ${default_section}
    Tick checkbox in Custom Question task       ${question_name_1}
    Click save task


Prepare test data for form with answer type = location lookup with element is check
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Add new form and input name     ${user_form}    ${form_location_lookup_checked}
    Create Custom Question task type with answer type       ${location_lookup}      ${question_name_1}      ${default_section}
    Go to a form section detail     ${default_section}
    Tick checkbox in Custom Question task       ${question_name_1}
    Click save task


Prepare test data for form with answer type = user lookup with element is uncheck
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Add new form and input name     ${user_form}    ${form_user_lookup_unchecked}
    Create Custom Question task type with answer type       ${user_lookup}      ${question_name_2}      ${default_section}


Prepare test data for form with answer type = location lookup with element is uncheck
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Add new form and input name     ${user_form}    ${form_location_lookup_unchecked}
    Create Custom Question task type with answer type       ${location_lookup}      ${question_name_2}      ${default_section}

*** Keywords ***
Tick checkbox in Custom Question task
    [Arguments]    ${question_name}
    Click At    ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name}
    Click At    ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name}
    Click At    ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name}
    Click At    ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name}
