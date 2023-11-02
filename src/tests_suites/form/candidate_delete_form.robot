*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

Documentation       Turn ON Form toggle at Client Setup Hire
...                 Turn ON Tax Withholding toggle at Client Setup Hire

*** Test Cases ***
Check that CAN delete Draft Candidate Form by clicking on Delete button at Delete Candidate Form popup (OL-T13796)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
    Delete a form with type     ${candidate_form}      ${form_name}


Check that CAN delete Published Candidate Form by clicking on Delete button at Delete Candidate Form popup (OL-T13797)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Go to form page
	${form_name}=   Add new form and input name     ${candidate_form}
    Click publish form
    Delete a form with type     ${candidate_form}      ${form_name}


Check that CANNOT delete Candidate Form which used for any Job on on search results list (OL-T13819)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name}=   Add new form and input name     ${candidate_form}
    Click publish form
    Go to Jobs page
    Search and click job name   ${AUTO_JOB_DELETE_CANDIDATE_FORM}   ${JF_COFFEE_FAMILY_JOB}
    Click on span text      Candidate Journey
    wait for page load successfully
    Select candidate form for candidate journey      ${form_name}
    Click at    ${SAVE_JOB_BUTTON}
    Publish job
    Go to form page
    Search form in form list    ${candidate_form}    ${form_name}
    Click at    ${MENU_ICON_BY_FORM_NAME}   ${form_name}    1s
    Click at    ${DELETE_FORM_ICON}
    Check cannot delete form confirm dialog is displayed
