*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    stg

*** Variables ***
${job_short_answer_user_form}       job_short_answer_user_form
${location_name}                    Florida
${job_multi_choice_user_form}       job_multi_choice_user_form
${digital_consent_job}              Digital_Consent_Job
${digital_consent_user_form}        Digital_Consent_User_Form
${text_area_not_displayed}          Text area is not displayed
${text_hide_from_manager}           Text hide from manager
${custom_task_hidden}               Custom_task_hidden

*** Test Cases ***
Check the Next Step when NOT enabling the Send User Form Note: Check the Next Step UI custom for Wendy on STG,Prod (OL-T11279)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    ${candidate_name} =     Add a Candidate     location_name=${location_name}      job_name=${job_short_answer_user_form}      is_spam_email=True
    Check candidate journey status display on screen    ${candidate_name}
    Click at    ${CEM_CANDIDATE_JOURNEY_FORM_STATUS}
    Click on common text last       Send Form
    Check element not display on screen     Confirm Status Update       wait_time=3s
    Check element not display on screen     Are you sure you want to update     wait_time=3s
    Capture page screenshot
    Switch to user      ${CA_TEAM}
    Check candidate journey status display on screen    ${candidate_name}
    Click at    ${CEM_CANDIDATE_JOURNEY_FORM_STATUS}
    Click on common text last       Send Form
    Wait for page load successfully
    Check element display on screen     Confirm Status Update
    Check text display      Are you sure you want to update
    Capture page screenshot


CEM: Check UI for multi-choice, Checkbox, Dropdown (OL-T11282, OL-T11287)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${CA_TEAM}
    ${candidate_name} =     Add a Candidate     None    ${location_name}    ${job_multi_choice_user_form}       is_spam_email=True
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click at    ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
    Click at    ${COMMON_SPAN_TEXT}     Radio button 2
    Click at    ${FORM_EXPERIENCE_NEXT_BUTTON}
    Click at    ${FORM_EXPERIENCE_SAVE_AND_CONFIRM_BUTTON}
    Wait for page load successfully
    Click at    ${CEM_CANDIDATE_FORM}       ${multi_choice_type_form}
    Click at    ${CEM_HIRE_DETAILS_FORM_EDIT_ICON}      Custom_question
    Click at    ${CEM_HIRE_DETAILS_FORM_EDIT_BUTTON}
    Click at    ${CEM_HIRE_DETAILS_FORM_RADIO_OPTION_ICON}      Custom_question
    Click on span text      Radio button 1
    #   [Job/Group/ AF] CEM: Check View & Edit the User Form in Hire Detail tab (OL-T11287)
    Click at    ${CEM_HIRE_DETAILS_FORM_APPLY_BUTTON}
    Click at    ${CEM_CANDIDATE_FORM_SAVE_BUTTON}
    Click at    ${CEM_CANDIDATE_FORM_CONFIRM_BUTTON}
    Click at    ${CEM_CANDIDATE_FORM}       ${multi_choice_type_form}
    Check text display      Edited by ${CA_TEAM}
    Capture page screenshot
    Go to CEM page
    Switch to user      ${TEAM_USER}
    Click at    ${candidate_name}
    Click at    ${CEM_CANDIDATE_FORM}       ${multi_choice_type_form}
    Click at    ${CEM_HIRE_DETAILS_FORM_EDIT_ICON}      Custom_question
    Check element display on screen     ${CEM_HIRE_DETAILS_FORM_COPY_VALUE_BUTTON}
    Check element not display on screen     ${CEM_HIRE_DETAILS_FORM_EDIT_BUTTON}    wait_time=3s
    Capture page screenshot


Check the digital consent (OL-T11283)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${CA_TEAM}
    ${candidate_name} =     Add a Candidate     None    ${location_name}    ${digital_consent_job}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click at    ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
    Check Digital Consent popup is diplayed
    Click by JS     ${FORM_DIGITAL_CONSENT_ICON_CLOSE}
    Check Action Required popup is displayed    ${digital_consent_user_form}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_EXIT_FORM}
    Check element display on screen     ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click at    ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
    Check Digital Consent popup is diplayed
    Click by JS     ${FORM_DIGITAL_CONSENT_ICON_CLOSE}
    Check Action Required popup is displayed    ${digital_consent_user_form}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_REVIEW_CONSENT}
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    Check element display on screen     ${CEM_HIRE_DETAILS_NAME_USER_FORM_LABEL}    ${digital_consent_user_form}


Check the Form select Sensitive & Hide (OL-T11284)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${CA_TEAM}
    ${candidate_name} =     Add a Candidate     None    ${location_name}    ${JOB_FORM_SELECT_SENSITIVE_HIDE}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click at    ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
    Input into      ${FORM_INPUT_TEXT_PARAGRAPH_TEXTAREA}       ${text_area_not_displayed}
    Input into      ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}    ${text_hide_from_manager}
    Click at    ${FORM_EXPERIENCE_NEXT_BUTTON}
    Click at    ${FORM_EXPERIENCE_SAVE_AND_CONFIRM_BUTTON}
    Click at    ${candidate_name}
    Click at    ${CEM_CANDIDATE_FORM}       ${FORM_SELECT_SENSITIVE_HIDE}
    Check element display on screen     ${custom_task_hidden}
    Check element not display on screen     ${custom_question}      wait_time=2s
    Verify attribute should contain     type    password    ${CEM_HIRE_DETAILS_FORM_HIDE_INPUT}     ${custom_task_hidden}
    Capture page screenshot

*** Keywords ***
Check candidate journey status display on screen
    [Arguments]     ${candidate_name}
    Click at    ${candidate_name}
    Click at    ${CEM_CANDIDATE_JOURNEYS_BUTTON}
    Check element display on screen     ${CEM_CANDIDATE_STATUS_DROPDOWN_TEXT}       ${CAPTURE_COMPLETE_STATUS}
    Capture page screenshot
    Click at    ${CEM_CANDIDATE_STATUS_DROPDOWN_TEXT}       More Options
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STEP_BUTTON}    Capture
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STEP_BUTTON}    Scheduling
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STEP_BUTTON}    Rating
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STEP_BUTTON}    Form
    Capture page screenshot
