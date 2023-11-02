*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/assessment_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/all_candidates_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        regression    test

*** Test Cases ***
Verify if the candidate clicks on Let's go button in case Do not share Assessment Results (OL-T18657, OL-T18658, OL-T18660, OL-T18661, OL-T18664)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    # Verify if the candidate clicks on Let's go button in case Do not share Assessment Results (OL-T18660)
    ${candidate_name}=      Chat apply job for send assessment
    # Verify if candidate opens an Assessment and then clicking on “X" icon in case Do not share Assessment Results (OL-T18664)
    Check display modal confirm when click icon X
    # Verify status updated to ‘Assessment In-Progress’ when candidate clicks on "Let's go" button in case Do not share Assessment (OL-T18661)
    Check Status Of Candidate In CEM Page       ${candidate_name.first_name}    Assessment In-Progress


Verify if Not Me button is clicked in case Do not share Assessment Results (OL-T18662, OL-T18663, OL-T18665)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Chat apply job for send assessment
    # Verify if "Me" button is clicked in case Do not share Assessment Results (OL-T18662)
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Capture page screenshot
    # Verify if "Not Me" button is clicked in case Do not share Assessment Results (OL-T18663)
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_NOTME}    ${ASSESSMENT_MODAL_BODY_TEXT }
    Capture page screenshot
    # Verify the display of Confirm modal when candidate clicks on “X" icon in case Do not share Assessment Results (OL-T18665)
    Check display modal confirm when click icon X


Verify if Exit button is clicked in case Do not share Assessment Results (OL-T18666, OL-T18669)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    # Verify if Exit button is clicked in case Do not share Assessment Results (OL-T18666)
    Chat apply job for send assessment
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Check display modal confirm when click icon X
    Check button continue assessment display when click button exit
    # Verify if "Continue Assessment" button is clicked in case Do not share Assessment Results on Mobile (OL-T18669)
    Click at    ${ASSESSMENT_LET_GO_BUTTON}
    check element display on screen     ${ASSESSMENT_MODAL}
    Capture page screenshot


Verify if Cancel button is clicked in case Do not share Assessment Results (OL-T18667)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Chat apply job for send assessment
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Check display modal confirm when click icon X
    Click at    ${ASSESSMENT_MODAL_CONFIRM_BUTTON_CANCEL}
    check element display on screen     ${ASSESSMENT_MODAL}
    capture page screenshot


Verify if X button in Confirm modal is clicked in case Do not share Assessment Results (OL-T18668)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Chat apply job for send assessment
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Check display modal confirm when click icon X
    Click at    ${ASSESSMENT_MODAL_CONFIRM_ICON_CANCEL}
    check element display on screen     ${ASSESSMENT_MODAL}
    capture page screenshot


Verify UI of the Assessment when the Assessment Completed in case Do not share Assessment Results (OL-T18671, OL-T18672, OL-T18673, OL-T18674, OL-T18675)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    # Verify UI of the Assessment when the Assessment Completed in case Do not share Assessment Results (OL-T18671)
    Chat apply job for send assessment
    Click button me/notme until finish
    #  Verify if the Assessment is closed in case Do not share Assessment Results (OL-T18672, OL-T18673, OL-T18674, OL-T18675)
    check message widget site response correct when finish assessment       ${ASSESSMENT_MODAL_BUTTON_FINISH}


Verify if X icon of Assessment Complete Modal is clicked in case Do not Share Assessment Results (OL-T18676, OL-T20827)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name} =     Chat apply job for send assessment
    Click button me/notme until finish
    check message widget site response correct when finish assessment       ${ASSESSMENT_MODAL_ICON_CLOSE}
    # Check behavior of Completed button when the assessment is completed and the candidate is moved to another status in case Do not share Assessment Results (OL-T20827)
    ${current_event_url} =      Get location
    Check Status Of Candidate In CEM Page       ${candidate_name.first_name}    Assessment Complete
    Change conversation status      ${candidate_name.first_name}    Form    Send Form
    Click at    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON_STATUS_UPDATE}    Confirm
    capture page screenshot
    Go to       ${current_event_url}
    wait for page load successfully
    Reload Page
    wait for page load successfully
    Check the text content of the header/button     ${ASSESSMENT_LET_GO_BUTTON}     ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    ${mes_request}=     format string       ${MES_REQUEST_ASSESSMENT}       ${candidate_name.first_name}
    check message widget site response correct      ${mes_request}
    capture page screenshot


Verify if the candidate clicks on Let's go button in case Share Assessment Results (OL-T18677, OL-T18682, OL-T18678)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    # Verify if the candidate clicks on Let's go button in case Share Assessment Results (OL-T18677)
    ${candidate_name}=      Chat apply job for send assessment
    # Verify if candidate opens an Assessment and then clicking on “X" icon in case Share Assessment Results (OL-T18682)
    Check display modal confirm when click icon X
    # Verify status updated to ‘Assessment In-Progress’ when candidate clicks on "Let's go" button in case Share Assessment Results (OL-T18678)
    Check Status Of Candidate In CEM Page       ${candidate_name.first_name}    Assessment In-Progress


Verify if Not Me button is clicked in case Do not share Assessment Results (OOL-T18679, OL-T18680, OL-T18681)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Chat apply job for send assessment
    # Verify if "Me" button is clicked in case Share Assessment Results (OL-T18679)
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Capture page screenshot
    # Verify if "Not Me" button is clicked in case Share Assessment Results (OL-T18680)
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_NOTME}    ${ASSESSMENT_MODAL_BODY_TEXT }
    Capture page screenshot
    # Verify the display of Confirm modal when candidate clicks on “X" icon in case Share Assessment Results (OL-T18681)
    Check display modal confirm when click icon X


Verify if “Exit" button is clicked in case Share Assessment Results (OL-T18683, OL-T18686)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    # Verify if “Exit" button is clicked in case Share Assessment Results (OL-T18683)
    Chat apply job for send assessment
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Check display modal confirm when click icon X
    Check button continue assessment display when click button exit
    # Verify if "Continue Assessment" button is clicked in case Share Assessment Results (OL-T18686)
    Click at    ${ASSESSMENT_LET_GO_BUTTON}
    check element display on screen     ${ASSESSMENT_MODAL}
    Capture page screenshot


Verify if Cancel button is clicked in case Share Assessment Results (OL-T18684)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Chat apply job for send assessment
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Check display modal confirm when click icon X
    Click at    ${ASSESSMENT_MODAL_CONFIRM_BUTTON_CANCEL}
    check element display on screen     ${ASSESSMENT_MODAL}
    capture page screenshot


Verify if X button in Confirm modal is clicked in case Share Assessment Results (OL-T18685)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    Chat apply job for send assessment
    Check display of modal when click button    ${ASSESSMENT_MODAL_BUTTON_ME}   ${ASSESSMENT_MODAL_BODY_TEXT }
    Check display modal confirm when click icon X
    Click at    ${ASSESSMENT_MODAL_CONFIRM_ICON_CANCEL}
    check element display on screen     ${ASSESSMENT_MODAL}
    capture page screenshot


Verify UI of the Assessment when the Assessment Completed in case Share Assessment Results (OL-T18688, OL-T18689, OL-T18690, OL-T18691, OL-T18692)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    # Verify UI of the Assessment when the Assessment Completed in case Share Assessment Results (OL-T18688)
    Chat apply job for send assessment
    Click button me/notme until finish
    #  Verify if the Assessment is closed in case Share Assessment Results (OL-T18689, OL-T18690, OL-T18691, OL-T18692)
    check message widget site response correct when finish assessment       ${ASSESSMENT_MODAL_BUTTON_FINISH}


Verify if X icon of Assessment Complete Modal is clicked in case Share Assessment Results (OL-T18693, OL-T18701)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    # erify if X icon of Assessment Complete Modal is clicked in case Share Assessment Results (OL-T18693)
    ${candidate_name}=      Chat apply job for send assessment
    Click button me/notme until finish
    check message widget site response correct when finish assessment       ${ASSESSMENT_MODAL_ICON_CLOSE}
    # Verify if the candidate receives Your Assessment Results Email (OL-T18701)
    Verify user has received the email       Your Assessment Results!    Hello ${candidate_name.first_name}!     ASSESSMENT_RESULTS


Verify the display of Traitify Assessment Results card (OL-T18694, OL-T18695, OL-T18698, OL-T20828, OL-T18699)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    # Verify the display of Traitify Assessment Results card (OL-T18694)
    ${candidate_name} =     Chat apply job for send assessment
    Click button me/notme until finish
    check message widget site response correct when finish assessment with share Assessment Results
    # Verify the display of Candidate’s Assessment Results when “View Your Results” button is clicked (OL-T18695)
    Click at    ${ASSESSMENT_VIEW_RESULT_BUTTON_VIEW_RESULT}
    wait for page load successfully
    Check the text content of the header/button     ${ASSESSMENT_DIALOG_VIEW_RESULT}    Your Assessment Results
    # Verify if ‘Your Assessment Results’ is closed when ‘X’ icon is clicked (OL-T18698)
    Click at    ${ASSESSMENT_DIALOG_VIEW_ICON_CLOSE}
    check element display on screen     ${ASSESSMENT_VIEW_RESULT}
    Check the text content of the header/button     ${ASSESSMENT_VIEW_RESULT_HEADER}    ${ASSESSMENT_HEADER_TEXT}
    Check the text content of the header/button     ${ASSESSMENT_VIEW_RESULT_BUTTON_VIEW_RESULT}    ${ASSESSMENT_VIEW_RESULT_TEXT}
    # Check behavior of Completed button when the assessment is completed and the candidate is moved to another status in case Share Assessment Results (OL-T20828)
    ${current_event_url} =      Get location
    Check Status Of Candidate In CEM Page       ${candidate_name.first_name}    Assessment Complete
    Change conversation status      ${candidate_name.first_name}    Form    Send Form
    Click at    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON_STATUS_UPDATE}    Confirm
    capture page screenshot
    Go to       ${current_event_url}
    wait for page load successfully
    Reload Page
    wait for page load successfully
    Check the text content of the header/button     ${ASSESSMENT_LET_GO_BUTTON}     ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    capture page screenshot
    # Check the PDF version of the Candidate’s Assessment Results is downloaded (OL-T18699)
    ${text} =       get_download_path
    ${files_before} =       List Files In Directory     ${text}
    ${numnber_files_before} =       get length      ${files_before}
    Click at    ${ASSESSMENT_VIEW_RESULT_BUTTON_VIEW_RESULT}
    wait for page load successfully
    Click at    ${ASSESSMENT_DIALOG_VIEW_ICON_DOWNLOAD}
    Wait with large time
    ${files_after} =    List Files In Directory     ${text}
    ${number_files_after} =     get length      ${files_after}
    Should not be equal as strings      ${numnber_files_before}     ${number_files_after}
    Remove File     ${text}/${candidate_name.first_name}-${candidate_name.last_name}-Traitify-Assessment-Results-9-25-2022.pdf


Verify if candidate receives Complete your Assessment Email(OL-T18700)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${candidate_name}=      Chat apply job for send assessment
    Verify user has received the email       Complete your assessment for ${COMPANY_TEST_ASSESSMENT}     Hi ${candidate_name.first_name}     COMPLETE_ASSESSMENT
