*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

Documentation       Turn ON Form toggle at Client Setup Hire
...                 Turn ON Tax Withholding toggle at Client Setup Hire

*** Test Cases ***
Check that CAN Duplicate Form with default task after input Form name (OL-T13526)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
	Click at    ${FORM_SETTING_ICON}
	Check setting options are displayed correctly
	Click at    ${FORM_DUPLICATE_ICON}
	${duplicated_form_name}=    Form is duplicated successfully     ${form_name}
	Delete a form with type     ${candidate_form}    ${form_name}
	Delete a form with type     ${candidate_form}    ${duplicated_form_name}


Check that CAN create Form with default section - Personal Information and any section (OL-T13532)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
    Add a form section with valid infor     ${work_experience}
    Check element display on screen     ${personal_information}
    Check element display on screen     ${work_experience}
	Add a form section with valid infor      ${tax_withholding}
    Check element display on screen     ${personal_information}
    Check element display on screen     ${work_experience}
    Check element display on screen     ${tax_withholding}
	Reload page
    Check element display on screen     ${personal_information}
    Check element display on screen     ${work_experience}
    Check element display on screen     ${tax_withholding}
    Capture page screenshot
    Delete a form with type   ${candidate_form}   ${form_name}


Check that CAN Add task with Address task type at Personal Information section (OL-T13678)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${address}
	Check task is added successfully to section     ${personal_information}     ${address}
	Delete a form with type     ${candidate_form}   ${form_name}


Check that CAN Add task with Custom question task type at Personal Information section (OL-T13679)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save       ${custom_question}
    Check task is added successfully to section     ${personal_information}     ${title_custom_question}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Date selection task type at Personal Information section (OL-T13680)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${date_selection}
    Check task is added successfully to section   ${personal_information}   ${title_date_selection}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Display text task type at Personal Information section (OL-T13681)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${display_text}
    Check task is added successfully to section   ${personal_information}    ${title_display_text}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Document review task type at Personal Information section (OL-T13682)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${document_review}
    Check task is added successfully to section   ${personal_information}    ${title_document_review}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Document upload task type at Personal Information section (OL-T13683)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${document_upload}
    Check task is added successfully to section   ${personal_information}   ${title_document_upload}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Fillable PDF task type at Personal Information section (OL-T13684)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${fillable_pdf}
    Check task is added successfully to section   ${personal_information}   ${title_fillable_pdf}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Resume upload task type at Personal Information section (OL-T13685)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Go to a form section detail     ${personal_information}
	Add a form task with type and save     ${resume_upload}
    Check task is added successfully to section   ${personal_information}    ${title_resume_upload}
	Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN Add task with Address task type at Diversity Questions section (OL-T13906)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Click at        ${FORM_ADD_TASK_BUTTON}
    Check task options are displayed correctly with full options
    Click at        ${FORM_ADD_TASK_OPTION}      ${address}
    Click save task
    Check task is added successfully to section     ${diversity_question}       ${address}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Custom question task type at Diversity Questions section (OL-T13907)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${custom_question}
    Check task is added successfully to section     ${diversity_question}       ${title_custom_question}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Date selection task type at Diversity Questions section (OL-T13908)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${date_selection}
    Check task is added successfully to section     ${diversity_question}       ${title_date_selection}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Display text task type at Diversity Questions section (OL-T13909)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${display_text}
    Check task is added successfully to section     ${diversity_question}       ${title_display_text}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Document review task type at Diversity Questions section (OL-T13910)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${document_review}
    Check task is added successfully to section     ${diversity_question}       ${title_document_review}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Document upload task type at Diversity Questions section (OL-T13911)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${document_upload}
    Check task is added successfully to section     ${diversity_question}       ${title_document_upload}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Fillable PDF task type at Diversity Questions section (OL-T13912)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${fillable_pdf}
    Check task is added successfully to section     ${diversity_question}       ${title_fillable_pdf}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Resume upload task type at Diversity Questions section (OL-T13913)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
    Add a form task with type and save       ${resume_upload}
    Check task is added successfully to section     ${diversity_question}       ${title_resume_upload}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Custom question task type at Work Experience section (OL-T14302)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${work_experience}
    Go to a form section detail     ${work_experience}
    Add a form task with type and save       ${custom_question}
    Check task is added successfully to section     ${work_experience}       ${title_custom_question}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Date selection task type at Work Experience section (OL-T14303)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${work_experience}
    Go to a form section detail     ${work_experience}
    Click at        ${FORM_ADD_TASK_BUTTON}
    Check task options are displayed correctly for Work Experience section
    Click at        ${FORM_ADD_TASK_OPTION}      ${date_selection}
    Click save task
    Check task is added successfully to section     ${work_experience}       ${title_date_selection}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Display text task type at Work Experience section (OL-T14304)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section with valid infor     ${work_experience}
    Go to a form section detail     ${work_experience}
    Add a form task with type and save       ${display_text}
    Check task is added successfully to section     ${work_experience}       ${title_display_text}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Address task type at Customs section (OL-T14334)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section     ${custom}
    Click at        ${FORM_ADD_TASK_BUTTON}
    Check task options are displayed correctly with full options
    Click at        ${FORM_ADD_TASK_OPTION}      ${address}
    Click save task
    Check task is added successfully to section     ${custom}       ${address}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Custom question task type at Customs section (OL-T14335, OL-T14336)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section     ${custom}
    Add a form task with type and save       ${custom_question}
    Check task is added successfully to section     ${custom}       ${title_custom_question}
    Add a form task with type and save       ${date_selection}
    Check task is added successfully to section     ${custom}       ${title_date_selection}
    Delete a form with type     ${candidate_form}       ${form_name}


Check that CAN Add task with Display text task type at Customs section (OL-T14337, OL-T14338, OL-T14339, OL-T14340, OL-T14341)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
    Add a form section     ${custom}
    Add a form task with type and save       ${display_text}
    Check task is added successfully to section     ${custom}       ${title_display_text}
    Add a form task with type and save       ${document_review}
    Check task is added successfully to section     ${custom}       ${title_document_review}
    Add a form task with type and save       ${document_upload}
    Check task is added successfully to section     ${custom}       ${title_custom}
    Add a form task with type and save       ${fillable_pdf}
    Check task is added successfully to section     ${custom}       ${title_fillable_pdf}
    Add a form task with type and save       ${resume_upload}
    Check task is added successfully to section     ${custom}       ${title_resume_upload}
    Delete a form with type     ${candidate_form}       ${form_name}


Candidate Form - Check that can add Custom Question task type with answer type is Short Answer (OL-T14395)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Add a form section      ${custom}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${short_answer}
    Delete a form with type     ${candidate_form}       ${form_name}


Candidate Form - Check that can add Custom Question task type with answer type is Paragraph (OL-T14396)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Add a form section      ${custom}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${short_answer}
	Select task question response type  ${custom_question}      ${paragraph}
	Click save task
	Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${paragraph}
    Delete a form with type     ${candidate_form}       ${form_name}


Candidate Form - Check that can add Custom Question task type with answer type is Multi Choice (OL-T14397)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Add a form section      ${custom}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${short_answer}
	Select task question response type  ${custom_question}      ${multi_choice}
	Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
	Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       option 1     ${title_custom_question}
    Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}  option 2     ${title_custom_question}
    Click at    ${FORM_REMOVE_TYPE_YOUR_QUESTION_ICON}
	Click save task
	Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${multi_choice}
    Delete a form with type     ${candidate_form}       ${form_name}


Candidate Form - Check that can add Custom Question task type with answer type is Drop down (OL-T14399)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     Candidate
	Add a form section      ${custom}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${short_answer}
	Select task question response type  ${custom_question}      ${drop_down}
	Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
	Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       option 1     ${title_custom_question}
    Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}  option 2     ${title_custom_question}
    Click at    ${FORM_REMOVE_TYPE_YOUR_QUESTION_ICON}
	Click save task
	Go to a form section detail     ${custom}
	Verify UI Custom Question form display correctly    ${candidate_form}   ${title_custom_question}  ${drop_down}
    Delete a form with type     ${candidate_form}       ${form_name}

*** Keywords ***
Check setting options are displayed correctly
    Check element display on screen     ${FORM_DUPLICATE_ICON}
    Check element display on screen     ${FORM_PREVIEW_ICON}
    Check element display on screen     ${FORM_ADD_TRACKING_PIXEL_ICON}
    Check element display on screen     ${FORM_ADD_WIDGET_ON_FORM_TOGGLE}
    Check span display      Not published
    Capture page screenshot

Form is duplicated successfully
    [Arguments]     ${form_name}
    Verify text contain    ${TOASTED_MESSAGE_SUCCESS}    ${your_change_saved}
    Wait until page does not contain element    ${TOASTED_MESSAGE_SUCCESS}
    ${duplicated_form_name}=    Get value and format text    ${FORM_NAME_TEXTBOX}
    Should be equal as strings      ${duplicated_form_name}     Copy - ${form_name}
    Capture page screenshot
    [Return]    ${duplicated_form_name}

Check task options are displayed correctly with full options
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${address}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${custom_question}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${date_selection}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${display_text}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${document_review}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${document_upload}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${fillable_pdf}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${resume_upload}
    Capture page screenshot

Check task options are displayed correctly for Work Experience section
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${custom_question}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${date_selection}
    Check element display on screen     ${FORM_ADD_SECTION_OPTION}       ${display_text}
    Capture page screenshot
