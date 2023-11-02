*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Prepare forms for Paradox Tax Form
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    Add new form and input name     ${CANDIDATE_FORM_TYPE}      ${FORM_WITH_TAX_WITHHOLDING}
    Add a form section with valid infor      ${tax_withholding}
    Click publish form


Prepare jobs for Paradox Tax Form
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     Paragraph_type      ${form_with_taxholding}     None     ${JOB_FORM_WITH_TAX_WITHHOLDING_IN_CHECK_STATE}
