*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${completion_tracking_pixel_text}       This is completion tracking pixel text

*** Test Cases ***
Prepare test data for form in multilingual
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Create new form with Add Completion Tracking Pixel
    Create new job with CJ and Form     ${JF_COFFEE_FAMILY_JOB}     ${paragraph_type_form}      ${FORM_ADD_COMPLETION_TRACKING_PIXEL}       None    ${JOB_ADD_COMPLETION_TRACKING_PIXEL}

*** Keyword ***
Create new form with Add Completion Tracking Pixel
    go to form page
    Add new form and input name     ${CANDIDATE_FORM_TYPE}      ${FORM_ADD_COMPLETION_TRACKING_PIXEL}
    Open Completion Tracking Pixel Popup
    Input text into Completion Tracking Pixel popup     ${completion_tracking_pixel_text}
    Click publish form
