*** Settings ***
Resource        ../../pages/forms_page.robot
Resource        ../../pages/jobs_page.robot
Resource        ../../pages/my_jobs_page.robot
Resource        ../../pages/workflows_page.robot
Resource        ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${digital_consent_job}                              Digital_Consent_Job
${digital_consent_job_2}                            Digital_Consent_Job_2
${no_digital_consent_job}                           No_Digital_Consent_Job
${digital_consent_fillable_pdf_candidate_form}      Digital_Consent_Fillable_PDF_Candidate_Form
${digital_consent_review_doc_candidate_form}        Digital_Consent_Review_Doc_Candidate_Form
${no_digital_consent_form}                          No_Digital_Consent_Form
${digital_consent_user_form}                        Digital_Consent_User_Form
${job_family}                                       Coffee Jobs
${document_review_title_task}                       DOCUMENT_REVIEW
${send_form_work_flow}                              Send form workflow
${send_candidate_form}                              Send Candidate Form
${send_form}                                        Send Form

*** Test Cases ***
Prepare digital consent form
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    go to form page
    Create new form has pdf file    ${candidate_form}       digital_consent=True      form_name=${digital_consent_fillable_pdf_candidate_form}
    go to form page
    Create new form has pdf file    ${user_form}        ${default_section}             digital_consent=True      form_name=${digital_consent_user_form}
    go to form page
    Create new form has pdf file    ${candidate_form}       form_name=${no_digital_consent_form}
    go to form page
    Create new form with document review and digital consent    ${candidate_form}       ${digital_consent_review_doc_candidate_form}


Prepare job for digital consent form flow
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new job with CJ and Form     ${job_family}      ${user_form}     ${digital_consent_fillable_pdf_candidate_form}      None     ${digital_consent_job}
    Create new job with CJ and Form     ${job_family}      ${user_form}     ${digital_consent_review_doc_candidate_form}        None     ${digital_consent_job_2}
    Create new job with CJ and Form     ${job_family}      ${user_form}     ${no_digital_consent_form}                          None     ${no_digital_consent_job}


Prepare workflow stage
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to Workflows page
    Click on common text last       ${send_form_work_flow}
    wait for page load successfully
    # Add new task send form
    Click by JS    ${WF_ADD_TASK_BUTTON}
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${send_candidate_form}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    ${send_form}
    Click at    ${STATUS_VALUE}    ${send_form}
    Click at    ${ADD_TRIGGER_BUTTON}
    Click by JS    ${WF_SEND_FORM_ICON}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}

*** Keywords ***
Create new form with document review and digital consent
    [Arguments]    ${form_type}     ${form_name}=None       ${section_name}=Personal Information
    ${form_name}=   Add new form and input name     ${form_type}    ${form_name}
    Go to a form section detail     ${section_name}
    Add a form task    ${document_review}
    Upload a file with type     PDF
    Check span display      Authorization_for_Payroll_Deduction.pdf
    Click at    ${EDIT_TITLE_NAME_ICON}
    Input into  ${FORM_DOCUMENT_NAME}   ${document_review_title_task}
    Click by JS    ${ELLIPSES_ICON_BY_QUESTION_NAME}   ${document_review_title_task}
    Click at    ${ADD_VALIDATE_ICON}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    wait for page load successfully
    Click at    ${FORM_STATUS_BAR_BUTTON}
    Click at    ${FORM_PUBLISH_BUTTON}
    [Return]    ${form_name}
