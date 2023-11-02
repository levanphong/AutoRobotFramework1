*** Settings ***
Resource        ../../pages/forms_page.robot
Resource        ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

Documentation       Turn ON Form toggle on Client Setup - Hire
...                 Run data test on src/data_tests/form/digital_consent_flow_data_test.robot file

*** Variables ***
${location}                                         Florida
${digital_consent_job}                              Digital_Consent_Job
${digital_consent_job_2}                            Digital_Consent_Job_2
${no_digital_consent_job}                           No_Digital_Consent_Job
${digital_consent_fillable_pdf_candidate_form}      Digital_Consent_Fillable_PDF_Candidate_Form
${digital_consent_review_doc_candidate_form}        Digital_Consent_Review_Doc_Candidate_Form
${no_digital_consent_form}                          No_Digital_Consent_Form
${digital_consent_user_form}                        Digital_Consent_User_Form
${digital_consent_checkbox_text}                    By checking this box, I confirm that I have read, agree, and consent to the information, terms & conditions contained in the
${required_field_error_message}                     This Field is Required
${digital_consent_message}                          By checking this box, I confirm that I have read, agree, and consent to the information, terms & conditions contained
${digital_consent_title_added}                      Digital Consent
${fillable_pdf_title_task}                          TAX_DOCUMENT
${document_review_title_task}                       DOCUMENT_REVIEW
${accepted_digital_consent_text}                    accepted Consent to use Electronic Signatures
${pdf_file_name}                                    Authorization_for_Payroll_Deduction.pdf

*** Test Cases ***
Candidate Form - Check that CAN Add digital consent and re-upload file on Fillable PDF task (OL-T14388)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    go to form page
    ${form_name}=   Create new form has pdf file    ${candidate_form}     digital_consent=True
    # Go to edit form and delete fillable PDF task
    Go to a form section detail    ${personal_information}
    Delete digital consent
    Check digital consent is deleted
    # Delete fillable pdf
    Click by JS  ${ELLIPSES_ICON_BY_QUESTION_NAME}     ${fillable_pdf_title_task}
    Click at  ${DELETE_CUSTOM_QUESTION_ICON}
    # Add fillable PDF again with digital consent
    Add a form task    ${fillable_pdf}
    Upload a file with type     PDF
    Check span display      ${pdf_file_name}
    Click at    ${EDIT_TITLE_NAME_ICON}
    Input into  ${FORM_DOCUMENT_NAME}   ${fillable_pdf_title_task}
    Click by JS    ${ELLIPSES_ICON_BY_QUESTION_NAME}   ${fillable_pdf_title_task}
    Click at    ${FORM_ADD_DIGITAL_CONSENT_ICON}
    # Check digital consent is added
    Check digital consent is added
    Delete a form with type     ${candidate_form}   ${form_name}


Candidate Form - Check the display of Fillable PDF task on Candidate Experience screen when adding Add Digital consent (OL-T15369, OL-T15372, OL-T15916, OL-T15807)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate with location and job
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${digital_consent_job}
    # Update status of candidate to Send Form and Send Form to candidate
    Change status of candidate to Send Form     ${candidate_name}
    Go to Candidate Experience page of Form     ${candidate_name}       ${digital_consent_fillable_pdf_candidate_form}
    # Check Digital Consent pop up display
    @{window} =    get window handles
    Switch window    ${window}[1]
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_CANCEL}
    Check Action Required popup is displayed        ${digital_consent_fillable_pdf_candidate_form}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_REVIEW_CONSENT}
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    # Check display fillable PDF form
    Check Fillable PDF task is displayed
    # Check the display of [Consent to Use Electronic Signatures] popup after agree and reload Form (OL-T15916)
    Reload page
    Check Digital Consent popup is not diplayed
    # Input all valid information into Candidate form
    Input all valid information into candidate form
    # Go to fillable PDF form and fill all valid information
    Click at    ${FORM_GET_STARTED_LINK}
    Input all valid information into fillable pdf form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    # Check the validation of [Fillable PDF] task on [Candidate Experience] screen when adding [Add Digital consent] OL-T15372
    Check element display on screen     ${FORM_VALIDATE_MESSAGE}    ${required_field_error_message}
    Check element display on screen     ${FORM_FILLABLE_PDF_ICON_CHECK}
    Capture page screenshot
    # Complete form
    Click by JS    ${FORM_FILLABLE_PDF_DIGITAL_CONSENT_CHECKBOX}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    # [Candidate Form] - Check the display of [Fillable PDF] file that setting Consent Digital on Hire Details (OL-T15807)
    Switch window    ${window}[0]
    Reload page
    Go to Candidate Experience page of Form     ${candidate_name}       ${digital_consent_fillable_pdf_candidate_form}
    Check element display on screen     ${accepted_digital_consent_text}
    Check element display on screen     ${FORM_ICON_CHECK_BY_TASK_NAME}     ${fillable_pdf_title_task}
    Capture page screenshot


User Form - Check that CAN Add digital consent and re-upload file on Fillable PDF task (OL-T15378)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    go to form page
    ${form_name}=   Create new form has pdf file    ${user_form}    ${default_section}     True
    # Go to edit form and delete fillable PDF task
    Go to a form section detail    ${default_section}
    Delete digital consent
    Check digital consent is deleted
    # Delete fillable pdf
    Click at  ${ELLIPSES_ICON_BY_QUESTION_NAME}     ${fillable_pdf_title_task}
    Click at  ${DELETE_CUSTOM_QUESTION_ICON}
    # Add fillable PDF again with digital consent
    Add a form task    ${fillable_pdf}
    Upload a file with type     PDF
    Check span display      ${pdf_file_name}
    Click at    ${EDIT_TITLE_NAME_ICON}
    Input into  ${FORM_DOCUMENT_NAME}   ${fillable_pdf_title_task}
    Click at    ${ELLIPSES_ICON_BY_QUESTION_NAME}   ${fillable_pdf_title_task}
    Click at    ${FORM_ADD_DIGITAL_CONSENT_ICON}
    # Check digital consent is added
    Check digital consent is added
    Delete a form with type     ${user_form}    ${form_name}


User Form - Check the display of Fillable PDF task on User Experience screen when adding Add Digital consent (OL-T15380, OL-T15383)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate with location and job
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${digital_consent_job}
    # Send Form to User
    Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
    # Check Digital Consent pop up display
    Check Digital Consent popup is diplayed
    Click by JS    ${FORM_DIGITAL_CONSENT_ICON_CLOSE}
    Check Action Required popup is displayed        ${digital_consent_user_form}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_REVIEW_CONSENT}
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    # Check display fillable PDF form
    Check Fillable PDF task is displayed
    # Go to fillable PDF form and fill all valid information
    Click at    ${FORM_GET_STARTED_LINK}
    Input all valid information into fillable pdf form
    Click by JS    ${FORM_FILLABLE_PDF_DIGITAL_CONSENT_CHECKBOX}
    # Click again to validate
    Click by JS   ${FORM_FILLABLE_PDF_DIGITAL_CONSENT_CHECKBOX}
    # Check the validation of [Fillable PDF] task on [User Experience] screen when adding [Add Digital consent] (OL-T15383)
    Check element display on screen     ${FORM_VALIDATE_MESSAGE}    ${required_field_error_message}
    Capture page screenshot


Candidate Form - Check the display of Fillable PDF file that NOT setting Consent Digital on Hire Details (OL-T15808)
    Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate with location and job
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${no_digital_consent_job}
    # Update status of candidate to Send Form and Send Form to candidate
    Change status of candidate to Send Form     ${candidate_name}
    Go to Candidate Experience page of Form     ${candidate_name}       ${no_digital_consent_form}
    # Check Digital Consent pop up display
    @{window} =    get window handles
    Switch window    ${window}[1]
    Check Digital Consent popup is not diplayed
    # Input all valid information into Candidate form
    Input all valid information into candidate form
    # Go to fillable PDF form and fill all valid information
    Click at    ${FORM_GET_STARTED_LINK}
    Input all valid information into fillable pdf form
    Check element not display on screen   ${FORM_FILLABLE_PDF_DIGITAL_CONSENT_CHECKBOX}     wait_time=5s
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    # Switch to old window
    Switch window    ${window}[0]
    Reload page
    Go to Candidate Experience page of Form     ${candidate_name}       ${no_digital_consent_form}
    Check element not display on screen     ${accepted_digital_consent_text}     wait_time=5s
    Check element not display on screen     ${FORM_ICON_CHECK_BY_TASK_NAME}     ${fillable_pdf_title_task}    wait_time=5s
    Capture page screenshot


Candidate Form - Check the display of Document Review task on Candidate Experience screen when adding Add Digital consent (OL-T14391, OL-T14393)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate with location and job
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${digital_consent_job_2}
    # Update status of candidate to Send Form and Send Form to candidate
    Change status of candidate to Send Form     ${candidate_name}
    Go to Candidate Experience page of Form     ${candidate_name}       ${digital_consent_review_doc_candidate_form}
    # Check Digital Consent pop up display
    @{window} =    get window handles
    Switch window    ${window}[1]
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_CANCEL}
    Check Action Required popup is displayed        ${digital_consent_review_doc_candidate_form}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_REVIEW_CONSENT}
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    # Check display review document task (OL-T14391)
    Check Review Document task is displayed
    # Input all valid information into Candidate form
    Input all valid information into candidate form
    Click at    ${FORM_DOCUMENT_REVIEW_VIEW_LINK}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    # [Candidate Form] - Check the validation of [Document Review] task on [Candidate Experience] screen when adding [Add Digital consent] (OL-T14393)
    Check element display on screen     ${FORM_VALIDATE_MESSAGE}    ${required_field_error_message}
    Capture page screenshot

*** Keywords ***
Check Fillable PDF task is displayed
    Check element display on screen     ${FORM_QUESTION_LABEL}      ${fillable_pdf_title_task}
    Check element display on screen     ${FORM_FILLABLE_PDF_FILE_NAME}      ${pdf_file_name}
    Check element display on screen     ${FORM_GET_STARTED_LINK}
    Check span display      ${digital_consent_checkbox_text}
    Element should be disabled      ${FORM_FILLABLE_PDF_DIGITAL_CONSENT_CHECKBOX}
    Capture page screenshot

Check digital consent is deleted
    ${digital_consent_title_added_locator}=   format string   ${COMMON_TEXT}      ${digital_consent_title_added}
    Check element not display on screen     ${digital_consent_title_added_locator}    wait_time=5s
    ${digital_consent_message_locator}=   format string   ${COMMON_SPAN_TEXT}      ${digital_consent_message}
    Check element not display on screen     ${digital_consent_message_locator}    wait_time=5s
    Capture page screenshot

Check digital consent is added
    ${digital_consent_title_added_locator}=   format string   ${COMMON_TEXT}      ${digital_consent_title_added}
    Check element display on screen     ${digital_consent_title_added_locator}
    ${digital_consent_message_locator}=   format string   ${COMMON_SPAN_TEXT}      ${digital_consent_message}
    Check element display on screen     ${digital_consent_message_locator}
    Capture page screenshot

Check Review Document task is displayed
    Check element display on screen     ${FORM_ITEM_LABEL}      ${document_review_title_task}
    Check element display on screen     ${FORM_DOCUMENT_REVIEW_FILE_NAME}      ${pdf_file_name}
    Check element display on screen     ${FORM_DOCUMENT_REVIEW_VIEW_LINK}
    Check span display      ${digital_consent_checkbox_text}
    Element should be disabled      ${FORM_DOCUMENT_REVIEW_DIGITAL_CONSENT_CHECKBOX}
    Capture page screenshot
