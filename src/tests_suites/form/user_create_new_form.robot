*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

*** Variables ***
${error_value_required}             Value is required

${text_at_country}                  Candidate can provide country or autofilled by Google Places
${text_at_address}                  Candidate can provide a street address
${text_at_apt_floor_suite}          Candidate can provide an apt, floor or suite. This field is not required
${text_at_city}                     City is autofilled by Google Places
${text_state}                       State is autofilled by Google Places
${text_zip}                         ZIP Code is autofilled by Google Places

*** Test Cases ***
Check that can add Custom Question task type with answer type is Drop down (OL-T14440)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Create user form then verify display Custom Question form
    Go to form page
    ${form_name}=   Add new form and input name     ${user_form}
    Go to a form section detail     ${default_section}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${short_answer}
    # Verify can add, input value and delete option your question
    Select task question response type      ${title_custom_question}      ${drop_down}
    Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Check text display      ${error_value_required}
    Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       option 1     ${title_custom_question}
    Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}   option 2     ${title_custom_question}
    Click at    ${FORM_REMOVE_TYPE_YOUR_QUESTION_ICON}
    Click save task
    # Verify UI Custom Question form after create form task success
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${drop_down}
    Delete a form with type     ${user_form}       ${form_name}


Check that can add Custom Question task type with answer type is Multi Choice (OL-T14438)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Create user form then verify display Custom Question form
    Go to form page
    ${form_name}=   Add new form and input name     ${user_form}
    Go to a form section detail     ${default_section}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${short_answer}
    # Verify can add, input value and delete option your question
    Select task question response type      ${title_custom_question}      ${multi_choice}
    Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Check text display      ${error_value_required}
    Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       option 1     ${title_custom_question}
    Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}   option 2     ${title_custom_question}
    Click at    ${FORM_REMOVE_TYPE_YOUR_QUESTION_ICON}
    Click save task
    # Verify UI Custom Question form after create form task success
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${multi_choice}
    Delete a form with type     ${user_form}       ${form_name}


Check that can add Custom Question task type with answer type is Paragraph (OL-T14437)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	# Create user form then verify display Custom Question form
    Go to form page
    ${form_name} =   Add new form and input name     ${user_form}
    Go to a form section detail     ${default_section}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${short_answer}
    # Verify can add paragraph response type
    Select task question response type      ${title_custom_question}      ${paragraph}
    Click save task
    # Verify UI Custom Question form after create form task success
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${paragraph}
	Delete a form with type     ${user_form}      ${form_name}


Check that can add Custom Question task type with answer type is Short Answer (OL-T14436, OL-T17140)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	# Create user form
    Go to form page
    ${form_name}=   Add new form and input name     ${user_form}
    # Verify can add Short Answer response type
    Go to a form section detail     ${default_section}
    Add a form task with type and save     ${custom_question}
    # Verify UI Custom Question form after create form task success
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${short_answer}
	Delete a form with type     ${user_form}      ${form_name}


Check that can add Custom Question task type with answer type is User Form Check box (OL-T14439)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to form page
    ${form_name}=   Add new form and input name     ${user_form}
    # Verify can add Check box response type
    Go to a form section detail     ${default_section}
    Add a form task with type and save     ${custom_question}
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}  ${short_answer}
    # Verify can add, input value and delete option your question
    Select task question response type      ${title_custom_question}      ${checkbox}
    Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Check text display      ${error_value_required}
    Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       option 1     ${title_custom_question}
    Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}   option 2     ${title_custom_question}
    Click at    ${FORM_REMOVE_TYPE_YOUR_QUESTION_ICON}
    Click save task
    # Verify UI Custom Question form after create form task success
    Go to a form section detail     ${default_section}
    Verify UI Custom Question form display correctly    ${user_form}   ${title_custom_question}   ${checkbox}
	Delete a form with type     ${user_form}      ${form_name}


Check that can Add task with Address task type for User Form (OL-T17139)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
    ${form_name}=   Add new form and input name     ${user_form}
    Go to a form section detail     ${default_section}
	# Verify display correctly menu tasks data
	Click at        ${FORM_ADD_TASK_BUTTON}
    Verify UI Menu tasks display correctly
    # Add address task
	Click at        ${FORM_ADD_TASK_OPTION}   ${address}
	Click at    ${FORM_SECTION_SAVE_BUTTON}
    Go to a form section detail     ${default_section}
    # Verify display correctly data of Address task
    Verify checkbox Sensitive, hide from manager, text, icon is display      Country     ${text_at_country}
    Verify checkbox Sensitive, hide from manager, text, icon is display      Address     ${text_at_address}
    Verify checkbox Sensitive, hide from manager, text, icon is display      Apt, Floor Suite     ${text_at_apt_floor_suite}
    Verify checkbox Sensitive, hide from manager, text, icon is display      City     ${text_at_city}
    Verify checkbox Sensitive, hide from manager, text, icon is display      State     ${text_state}
    Verify checkbox Sensitive, hide from manager, text, icon is display      ZIP     ${text_zip}
    Check element display on screen     ${ADDRESS_TASK_ICON_ATS_MAP}     ${address}
    Check element display on screen     ${ADDRESS_TASK_ICON_DELETE}      ${address}
    Check element display on screen     ${FORM_ADD_TASK_BUTTON}
    Capture page screenshot
    Delete a form with type     ${user_form}      ${form_name}


Check that can Add task with Date selection task type for User Form (OL-T17141)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name} =      Add new form and input name     User
	# Verify User can add Date selection task
	Go to a form section detail     ${default_section}
	Add a form task      ${date_selection}
	Click save task
	# Verify UI Date selection task after create task success
	Go to a form section detail     ${default_section}
	Check element display on screen       ${REQUIRED_TOGGLE_BY_DATA_TEST_ID}
    Check element display on screen     User can select a month, day, and year.
    Check element display on screen     ${FORM_ADD_TASK_BUTTON}
    Capture page screenshot
    Delete a form with type     ${user_form}      ${form_name}


Check that can Add task with Display text task type for User Form (OL-T17142)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	${form_name} =      Create new user form       ${default_section}     ${display_text}       ${title_display_text}
	# Verify display correctly data of Display text task
	Check p text display        Display text question content
    Check element display on screen     ${FORM_ADD_TASK_BUTTON}
	Capture page screenshot
	Delete a form with type     ${user_form}      ${form_name}


Check that can Add task with Document review task type for User Form (OL-T17143)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	${form_name} =      Create new user form       ${default_section}     ${document_review}       ${title_document_review}
	#  Verify display correctly data of Document review task
	Check span display        cat-kute.jpg
	Check element display on screen        ${FORM_UPLOAD_REMOVE_BUTTON}
    Check element display on screen     ${FORM_ADD_TASK_BUTTON}
	Capture page screenshot
	Delete a form with type     ${user_form}      ${form_name}


Check that can Add task with Document upload task type for User Form (OL-T17144)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	${form_name} =      Create new user form       ${default_section}     ${document_upload}       ${title_document_upload}
	#  Verify display correctly data of Document upload task
	Check element display on screen       ${REQUIRED_TOGGLE_BY_DATA_TEST_ID}
    Check span display     The user will receive instructions to upload a document.
    Check element display on screen     ${FORM_ADD_TASK_BUTTON}
	Capture page screenshot
	Delete a form with type     ${user_form}      ${form_name}


Check that can Add task with Fillable PDF task type for User Form (OL-T17145)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	${form_name} =      Create new user form       ${default_section}     ${fillable_pdf}       ${title_fillable_pdf}
	#  Verify display correctly data of Fillable PDF task
	Check span display        Authorization_for_Payroll_Deduction.pdf
	Check element display on screen        ${FORM_UPLOAD_REMOVE_BUTTON}
    Check element display on screen     ${FORM_ADD_TASK_BUTTON}
	Capture page screenshot
	Delete a form with type     ${user_form}      ${form_name}

*** Keywords ***
Verify checkbox Sensitive, hide from manager, text, icon is display
    [Arguments]     ${question_name}    ${text}
    Check element display on screen     ${CHECKBOX_SENSITIVE_ADDRESS_TASK_QUESTION}     ${question_name}
    Check element display on screen     ${CHECKBOX_HIDE_FROM_MANAGER_ADDRESS_TASK_QUESTION}     ${question_name}
    Check element display on screen     ${text}
    Check element display on screen     ${ADDRESS_TASK_ICON_LOCK}     ${question_name}

Verify UI Menu tasks display correctly
    Check span display      ${address}
    Check span display      ${custom_question}
    Check span display      ${date_selection}
    Check span display      ${display_text}
    Check span display      ${document_review}
    Check span display      ${fillable_pdf}
