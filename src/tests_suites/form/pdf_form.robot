*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../data_tests/form/form_data_test.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/all_candidates_page.robot

Suite Setup         Prepare data test for form pdf test suite
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${job_family_name}      Tester_Hunter
${job_name}             Engineer
${location_name}        Test_Location_1
${user_name}            Auto CP
${candidate_joruney}    Form_Trigger_Journey
${message_send_form}    excited to move you forward in our process. Please complete your form for

*** Test Cases ***
Check user can interact with pdf file
    [Tags]   skip
    Given Setup test
    Login into system with schedule company with full user    Auto CP
    ${candidate_name} =    add a candidate   location_name=${location_name}  job_name=${job_name}
    Select candidate by candidate link from canidate name  ${candidate_name}
    Send Form trigger by manually
    ${messa_form}=  format string  ${COMMON_DIV_TEXT}  ${message_send_form}
    wait until element is visible  ${messa_form}
    ${link_form}=  get text  ${SEND_FORM_LINK}
    Go to   ${link_form}
    wait for page load successfully v1
    Enter code for verify code step   ${candidate_name}
    check element display on screen   ${PDF_FILE_NAME}
    click at  ${GET_STARTED_BTN}
    wait for page load successfully v1
    Select Frame  ${FRAME_PDF_FILLABLE}
    Input into  ${INPUT_NAME}  Name Test
    Input into  ${INPUT_SS}  Information Test
    Input into  ${INPUT_DATE}  Date Test
    Input into  ${INPUT_SIGNATURE}  Name signature
    Unselect Frame
    wait with short time
    click at  ${CHECKBOX_AGREEMENT}
    click at  ${SUBMIT_FORM}  slow_down=3s
