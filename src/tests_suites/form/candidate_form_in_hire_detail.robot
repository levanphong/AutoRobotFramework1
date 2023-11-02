*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${location}                 Florida
${hire_detail_form_job}     Form in Hire Detail Job
${diversity_pdf_job}        Diversity PDF Form Job
${hire_detail_form}         Hire_Detail_Candidate_Form
${diversity_PDF_form}       Candidate_Form_Diversity_Fillable_PDF
${confirmation_question}    Confirmation_question
${sensitive_question}       Sensitive_question
${address_1_edit}           470 Nguyen Huu Tho
${address_2_edit}           Thanh Khe
${city_edit}                Ha Noi
${state_edit}               New York
${zipcode_edit}             00501
${ethnicity}                Ethnicity
${gender}                   Gender
${marital_status}           Marital Status
${disable_question}         Please provide an answer below

*** Test Cases ***
Check that CAN edit data of Personal Information on Hire details (OL-T13711, OL-T13930, OL-T15246, OL-T15250)
    Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${hire_detail_form_job}      is_spam_email=False
    Change status to send form and open form     ${candidate_name}      ${COMPANY_NEXT_STEP}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Select required field for Diversity Questions
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Fill anwser for custom question     ${confirmation_question}        confirmation      confirmation=True
    Fill anwser for custom question     ${sensitive_question}       sensitive
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Go to CEM page
    Click at        ${candidate_name}
    Click on common text last   ${hire_detail_form}
    Check copy field value and edit field display for each field
    Edit candidate form answer      ${candidate_name}     ${hire_detail_form}     Street address (Line 1)     ${address_1_edit}
    Edit candidate form answer      ${candidate_name}     ${hire_detail_form}     Street address (Line 2)     ${address_2_edit}
    Edit candidate form answer      ${candidate_name}     ${hire_detail_form}     City        ${city_edit}
    Edit candidate form answer      ${candidate_name}     ${hire_detail_form}     State       ${state_edit}
    Edit candidate form answer      ${candidate_name}     ${hire_detail_form}     ZIP code        ${zipcode_edit}
    # Check the display of [Diversity Question] on [Hire Details] screen (OL-T13930)
    Click at    ${candidate_name}
    Click at    ${hire_detail_form}
    Check Diversity Question does not display in Hire Detail
    # Check the display of field when setting [Sensitive Information] at [Hire Details] (OL-T15246, OL-T15250)
    Check input type of a question is password      ${sensitive_question}


Check the display of Diversity Questions section on Hire Details screen when setting Sensitive information for any fields (OL-T13931, OL-T15809)
    Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${diversity_PDF_job}      is_spam_email=False
    Change status to send form and open form     ${candidate_name}      ${COMPANY_NEXT_STEP}
    # Agree Digital Consent and fill all valid information to form
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    Input all valid information into candidate form
    Click at    ${FORM_GET_STARTED_LINK}
    Input all valid information into fillable pdf form
    Click by JS    ${FORM_FILLABLE_PDF_DIGITAL_CONSENT_CHECKBOX}
    Click at    ${FORM_GET_STARTED_LINK}
    Input all valid information into fillable pdf form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Select required field for Diversity Questions
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Go to CEM page
    Click at        ${candidate_name}
    Click on common text last        ${diversity_PDF_form}
    Check Diversity Question display in Hire Detail
    Check input type of a question is password      ${ethnicity}
    Check input type of a question is password      ${gender}
    Check input type of a question is password      ${marital_status}
    Check input type of a question is password      ${disable_question}
    # [Candidate Form] - Check the display on Hire Details when Form have many [Fillable PDF] tasks (OL-T15809)
    Check element display on screen         ${FORM_ICON_CHECK_BY_TASK_NAME}     Fillable_PDF_1
    Check element not display on screen     ${FORM_ICON_CHECK_BY_TASK_NAME}     Fillable_PDF_2      wait_time=2s

*** Keywords ***
Check copy field value and edit field display for each field
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      First Name
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element not display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}       wait_time=2s
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      First Name
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Middle Initial
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element not display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}       wait_time=2s
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Middle Initial
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Last Name
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element not display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}       wait_time=2s
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Last Name
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Phone number
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element not display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}       wait_time=2s
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Phone number
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Email address
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element not display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}       wait_time=2s
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Email address
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Street address (Line 1)
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Street address (Line 1)
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Street address (Line 2)
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      Street address (Line 2)
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      City
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      City
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      State
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      State
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      ZIP code
    Check element display on screen     ${CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON}
    Check element display on screen     ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}
    Capture page screenshot
    Click by JS    ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      ZIP code
    Click at        ${CEM_CANDIDATE_FORM_CLOSE_ICON}

Check Diversity Question does not display in Hire Detail
    Check element not display on screen      ${ethnicity}      wait_time=2s
    Check element not display on screen      ${gender}          wait_time=1s
    Check element not display on screen      ${marital_status}      wait_time=1s
    Check element not display on screen      ${disable_question}      wait_time=1s
    Capture page screenshot

Check Diversity Question display in Hire Detail
    Check element display on screen      ${ethnicity}
    Check element display on screen      ${gender}
    Check element display on screen      ${marital_status}
    Check element display on screen      ${disable_question}
    Capture page screenshot

Check input type of a question is password
    [Arguments]     ${question_name}
    ${input_type}=  Get attribute and format text   type    ${CEM_CANDIDATE_FORM_ANSWER_TEXTBOX_BY_QUESTION_NAME}       ${question_name}
    Should be equal as strings      ${input_type}       password
    Capture page screenshot
