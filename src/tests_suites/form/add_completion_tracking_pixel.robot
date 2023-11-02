*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regresstion    stg

*** Variables ***
${completion_tracking_pixel_text}       This is completion tracking pixel text
${completion_tracking_pixel_text_1}     Text Tracking Pixel 1 !@3 (0)
${completion_tracking_pixel_text_2}     Text Tracking Pixel 2 !@3 (0)
${location}                             Florida

*** Test Cases ***
Check that CAN Add Completion Tracking Pixel for New Candidate Form (OL-T15293)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =      Add new form and input name     ${CANDIDATE_FORM_TYPE}
    Open Completion Tracking Pixel Popup
    Check default display of Completion Tracking Pixel
    Input text into Completion Tracking Pixel popup     ${completion_tracking_pixel_text_1}
    Open Completion Tracking Pixel Popup
    Check default display of Completion Tracking Pixel      ${completion_tracking_pixel_text_1}
    Input text into Completion Tracking Pixel popup     ${completion_tracking_pixel_text_2}
    Open Completion Tracking Pixel Popup
    Check default display of Completion Tracking Pixel      ${completion_tracking_pixel_text_2}
    Delete a form with type     ${CANDIDATE_FORM_TYPE}      ${form_name}


Check that Completion Tracking Pixel is trigged for ONLY Thank You screen after Candidate completed form (OL-T15298)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${location}     ${JOB_ADD_COMPLETION_TRACKING_PIXEL}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Page should contain element     ${FORM_ADD_TRACKING_PIXEL_SCRIPT}       ${completion_tracking_pixel_text}
    Capture page screenshot
    Click at    ${FORM_SUBMIT_BUTTON}
    Page should contain element     ${FORM_ADD_TRACKING_PIXEL_SCRIPT}       ${completion_tracking_pixel_text}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Capture page screenshot

*** Keywords ***
Check default display of Completion Tracking Pixel
    [Arguments]     ${text}=None
    Check text display      Completion Tracking Pixel
    Element should be enabled     ${FORM_ADD_TRACKING_PIXEL_CANCEL_BUTTON}
    Element should be disabled      ${FORM_ADD_TRACKING_PIXEL_SAVE_BUTTON}
    Check element display on screen     ${FORM_ADD_TRACKING_PIXEL_CONTENT_PRESENTATION}
    IF      '${text}' != 'None'
        Check text display      ${text}
    END
    Capture page screenshot
