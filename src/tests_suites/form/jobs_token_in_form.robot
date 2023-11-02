*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/job_data_packages_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

Documentation       Client Setup > Hire > Forms toggle ON
...                 Client Setup > Hire > Job Data Packages toggle ON

*** Variables ***
${location}                         Florida
${job_system_attribute_form}        Job_System_Attribute_Form
${form_system_attribute_job}        Form_system_attribute_token_job
${form_system_attribute_job_off}    Form_system_attribute_token_job_off
${job_data_packages}                Minimum Age token value
${at_least_16}                      At least 16
${custom_job_attribute}             custom_job_attribute_in_form
@{list_system_attribute}            base_pay_maximum    base_pay_minimum    employment_type    industry    job_function
...                                 minimum_age    minimum_wage    seniority_level    ${custom_job_attribute}

*** Test Cases ***
Verify job tokens are shown when user types '#' in custom question title (OL-T17273)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    go to form page
    ${form_name}=   Add new form and input name     ${candidate_form}
    Go to a form section detail     ${personal_information}
    Add a form task     ${custom}
    Check system attribute displays correctly when create form
    Click save task
    Go to a form section detail     ${personal_information}
    Check element display on screen     \#custom_job_attribute_in_form
    Capture page screenshot
    Delete a form with type     ${candidate_form}   ${form_name}


Verify job token is replace by the value in data package when candidate opening form (OL-T17274, OL-T17276)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate with location and job
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${form_system_attribute_job}
    # Update status of candidate to Send Form and Send Form to candidate
    Change status of candidate to Send Form     ${candidate_name}
    Switch to user      ${TEAM_USER}
    Go to Candidate Experience page of Form     ${candidate_name}       ${job_system_attribute_form}
    # Check Digital Consent pop up display
    @{window} =    get window handles
    Switch window    ${window}[1]
    Input all valid information into candidate form
    Check element display on screen     ${FORM_QUESTION_LABEL}      ${at_least_16}
    Capture page screenshot
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    # Verify job token value that is submitted in form is not changed when the value in job is changed (OL-T17276)
    Switch window    ${window}[0]
    Go to job data packages page
    # Edit job data packages
    Click on span text      ${job_data_packages}
    Input into      ${EDIT_DATA_PACKAGES_VALUE}     At least 18
    Click at        ${BUTTON_CREATE_ON_MODAL}
    # Go to submitted form and check if job data package value is overwritten
    Go to CEM page
    Go to Candidate Experience page of Form     ${candidate_name}       ${job_system_attribute_form}
    Check element display on screen     ${at_least_16}
    Capture page screenshot
    # Edit job data packages to normal
    Go to job data packages page
    Click on span text      ${job_data_packages}
    Input into      ${EDIT_DATA_PACKAGES_VALUE}     ${at_least_16}
    Click at        ${BUTTON_CREATE_ON_MODAL}


Verify job token value is correct when the job is OFF (OL-T17277)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate with location and job
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${form_system_attribute_job_off}     is_spam_email=False
    # Update status of candidate to Send Form and Send Form to candidate
    Change status of candidate to Send Form     ${candidate_name}
    # Turn off job
    Deactivate a job    ${form_system_attribute_job_off}    ${location}
    Go to CEM page
    Go to form link and input verification code     ${candidate_name}
    Input all valid information into candidate form
    Check element display on screen     ${FORM_QUESTION_LABEL}      ${at_least_16}
    Capture page screenshot
    # Turn on job again
    Active a job    ${form_system_attribute_job_off}    ${location}

*** Keywords ***
Check system attribute displays correctly when create form
    FOR     ${system_attribute}    IN    @{list_system_attribute}
        Input into      ${LAST_QUESTION_NAME_TEXTBOX}   \#${system_attribute}
        Check element display on screen     ${FORM_SYSTEM_ATTRIBUTE_BY_NAME}    ${system_attribute}
    END

Go to form link and input verification code
    [Arguments]     ${candidate_name}
    Click at    ${candidate_name}
    ${messa_form}=  format string  ${COMMON_DIV_TEXT}  excited to move you forward in our process. Please complete your form for
    wait until element is visible  ${messa_form}
    ${link_form}=  get text  ${SEND_FORM_LINK}
    Go to   ${link_form}
    wait for page load successfully v1
    Enter code for verify code step   ${candidate_name}
