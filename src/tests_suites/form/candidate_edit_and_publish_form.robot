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

*** Variables ***
${error_task_title_required}            Task title is required
${error_task_title_required_toast}      Task title is required to save.
${unpublished_status}                   Unpublished Changes
${change_to_unpublished_message}        Please switch to unpublished form template to make edits

*** Test Cases ***
Check that CAN published From with default task after input Form name (OL-T13525)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
    Click publish form
    Capture page screenshot
    Delete a form with type     ${candidate_form}      ${form_name}


Check CANNOT update name of Personal Information section with blank value (OL-T13546)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
	Go to a form section detail     ${personal_information}
	Click at    ${FORM_SECTION_EDIT_NAME_ICON}
    Clear element text with keys    ${FORM_SECTION_NAME_TEXTBOX}
    Check element display on screen     ${error_task_title_required}
    Capture page screenshot
    Click at    ${FORM_SECTION_SAVE_BUTTON}
	Verify text contain     ${TOASTED_MESSAGE_ERROR}     ${error_task_title_required_toast}
	Delete a form with type     ${candidate_form}      ${form_name}


Check that CAN published Form with Custom section (OL-T14344)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
	Add a form section with valid infor     ${custom}
	Add a form task with type and save      ${address}
	Check task is added successfully to section     ${custom}       ${address}
    Add a form task with type and save       ${date_selection}
    Click publish form
    Capture page screenshot
    Delete a form with type     ${candidate_form}      ${form_name}


Check that CAN update data of Published Form (OL-T14520, OL-T14521)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
    Click publish form
    # Edit form
    Edit a form with type   ${candidate_form}       ${form_name}
	Add a form section with valid infor     ${custom}
	Add a form task with type and save      ${address}
	# Check status after edit and publish form
	Check span display      ${unpublished_status}
    Click publish form
    Capture page screenshot
    Delete a form with type     ${candidate_form}      ${form_name}


Check that CANNOT update data of Unpublished Form with viewing = Published (OL-T14522)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
    Click publish form
	Edit a form with type   ${candidate_form}       ${form_name}
	Add a form section with valid infor     ${custom}
	Add a form task with type and save      ${address}
	Check span display      ${unpublished_status}
	Click at    ${FORM_STATUS_BAR_BUTTON}
    Click at    ${FROM_STATUS_BAR_PUBLISHED_VIEW_BUTTON}
    # Add a section in published view
    Click at        ${FORM_ADD_SECTION_BUTTON}
    Click at        ${FORM_ADD_SECTION_OPTION}   ${custom}
    # Verify error message display
    Verify text contain     ${TOASTED_MESSAGE_SUCCESS}     ${change_to_unpublished_message}
	Capture page screenshot
