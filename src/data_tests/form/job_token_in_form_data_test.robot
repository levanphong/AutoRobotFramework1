*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/job_data_packages_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression      olivia      stg     lts_stg

*** Variables ***
${location}                         Florida
${job_family}                       Coffee Jobs
${job_system_attribute_form}        Job_System_Attribute_Form
${form_system_attribute_job}        Form_system_attribute_token_job
${form_system_attribute_job_off}    Form_system_attribute_token_job_off
${job_data_packages}                Minimum Age token value
${job_data_packages_2}              Minimum Age token OFF job
${at_least_16}                      At least 16
${custom_job_attribute}             custom_job_attribute_in_form
${mimimum_age}                      Minimum Age
${minimum_age_token}                minimum_age

*** Test Cases ***
Prepare data for Job token in form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Create form
    Add form with job token         ${job_system_attribute_form}
    # Create custom job attribute
    Add a Custom Job Attribute      ${custom_job_attribute}
    # Create job data packages
    Go to job data packages page
    add new job package    ${job_data_packages}        ${mimimum_age}       ${at_least_16}
    add new job package    ${job_data_packages_2}        ${mimimum_age}       ${at_least_16}
    # Create job with data packages and form
    Create new job with CJ and Form     ${job_family}      ${user_form}     ${job_system_attribute_form}      None     ${form_system_attribute_job}
    Create new job with CJ and Form     ${job_family}      ${user_form}     ${job_system_attribute_form}      None     ${form_system_attribute_job_off}
    Edit job and add data packages      ${form_system_attribute_job}        ${job_data_packages}
    Edit job and add data packages      ${form_system_attribute_job_off}    ${job_data_packages_2}

*** Keywords ***
Add form with job token
    [Arguments]     ${form_name}
    go to form page
    ${form_name}=   Add new form and input name     ${candidate_form}    ${form_name}
    Go to a form section detail     ${personal_information}
    Add a form task     ${custom}
    Input into      ${LAST_QUESTION_NAME_TEXTBOX}   \#${minimum_age_token}
    Click save task
    Click publish form

Edit job and add data packages
    [Arguments]     ${job_name}     ${job_package_name}
    Go to Jobs page
    search and click job name       ${job_name}     ${job_family}
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    select job data package on the modal add details    ${job_package_name}
    add location on job data package modal    ${location}
    Click at    ${DONE_BTN_DETAILS}
    Publish job
