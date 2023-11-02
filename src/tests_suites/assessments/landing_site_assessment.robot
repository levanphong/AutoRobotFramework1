*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/assessment_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Variables ***
${web_management_name}          wm for assessment
${web_management_form_name}     wm for assessment with form

*** Test Cases ***
Verify message customization when candidate receives Assessment in case Do not share Assessment Results (OL-T18058, OL-T18061, OL-T18065, OL-T18066, OL-T18068, OL-T18063, OL-T18064, OL-T18069, OL-T18067, OL-T18070, OL-T18072, OL-T18073, OL-T18074, OL-T18075, OL-T18076)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Check message in conversation when transfer send assessment in Landing Site
    #   Verify if the candidate clicks on "Let's go" button in case Do not share Assessment Results (OL-T18061)
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify if candidate opens an Assessment and then clicking on "X" icon in case Do not share Assessment Results (OL-T18065, OL-T18066)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Check UI Confirm Modal When Click X Icon in Landing Site
    #   Verify if "Cancel" button is clicked in case Do not share Assessment Results (OL-T18068)
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_CANCEL_BUTTON}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}     ${ASSESSMENT_BUTTON_EXIT}      wait_time=2s
    Check UI Assessment Display in Landing Site
    #   Verify if "Me" button is clicked in case Do not share Assessment Results (OL-T18063)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_ME}
    #   Verify if "Not Me" button is clicked in case Do not share Assessment Results (OL-T18064)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_NOT_ME}
    #   Verify if "X" button in Confirm modal is clicked in case Do not share Assessment Results (OL-T18069)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_BUTTON_EXIT}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}     ${ASSESSMENT_BUTTON_EXIT}         wait_time=2s
    Check UI Assessment Display in Landing Site
    #   Verify if "Exit" button is clicked in case Do not share Assessment Results (OL-T18067)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_EXIT_BUTTON}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_STATUS_CONTINUE}
    Capture page screenshot
    #   Verify if "Continue Assessment" button is clicked in case Do not share Assessment Results (OL-T18070)
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify UI of the Assessment when the Assessment Completed in case Do not share Assessment Results (OL-T18072)
    Click on Me button until finish
    Check UI When Finished Assessment in Landing Site
    #   Verify if the Assessment Completed is closed in case Do not share Assessment Results (OL-T18073)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE}     wait_time=2s
    Capture page screenshot
    #   Verify the Assessment Instructions button will update to "Completed" when the Assessment Completed in case Do not share Assessment Results (OL-T18074)
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Capture page screenshot
    #   Verify Message Customization when the Assessment Completed in case Do not share Assessment Results (OL-T18076)
    Verify Olivia conversation message display      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    Capture page screenshot
    #   Verify if appearance of milestone when the Assessment Completed in case Do not share Assessment Results (OL-T18075)
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED_TEXT}


Verify status updated to Assessment In-Progress when candidate clicks on Let's go button in case Do not share Assessment Results (OL-T18062)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_IN_PROGRESS_TEXT}


Check behavior of Completed button when the assessment is completed and the candidate is moved to another status in case Do not share Assessment Results (OL-T20817)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${first_name}=      Chat landing site to send assessment    ${JOB_FARMER}       ${web_management_form_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Go To CEM Page
    Switch to user      ${CA_TEAM}
    Change conversation status      ${first_name}       Form    ${JOURNEY_SEND_FORM_ACTION}
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Go Back
    Reload Page
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_BUTTON_TEXT}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED}


Verify if X icon of Assessment Complete Modal is clicked in case Share Assessment Results (OL-T18077)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Check Text Display      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED_TEXT}


Verify if the candidate clicks on Let's go button in case Share Assessment Results (OL-T18078, OL-T18082, OL-T18083, OL-T18080, OL-T18081, OL-T18085, OL-T18086, OL-T18084, OL-T18087, OL-T18089, OL-T18090, OL-T18091, OL-T18093, OL-T18095, OL-T18096, OL-T18099, OL-T18100)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Check message in conversation when transfer send assessment in Landing Site
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify if candidate opens an Assessment and then clicking on “X" icon in case Share Assessment Results (OL-T18082,OL-T18083)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Check UI Confirm Modal When Click X Icon in Landing Site
    #   Verify if “Cancel" button is clicked in case Share Assessment Results (OL-T18085)
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_CANCEL_BUTTON}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}     ${ASSESSMENT_BUTTON_EXIT}      wait_time=2s
    Check UI Assessment Display in Landing Site
     #   Verify if "Me" button is clicked in case Share Assessment Results (OL-T18080)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_ME}
    #   Verify if "Not Me" button is clicked in case Share Assessment Results (OL-T18081)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_NOT_ME}
    #   Verify if “X" button in Confirm modal is clicked in case Share Assessment Results (OL-T18086)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_BUTTON_EXIT}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}     ${ASSESSMENT_BUTTON_EXIT}      wait_time=2s
    Check UI Assessment Display in Landing Site
    #   Verify if “Exit" button is clicked in case Share Assessment Results (OL-T18084)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_EXIT_BUTTON}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_STATUS_CONTINUE}
    #   Verify if "Continue Assessment" button is clicked in case Share Assessment Results (OL-T18087)
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify UI of the Assessment when the Assessment Completed in case Share Assessment Results (OL-T18089)
    Click on Me button until finish
    Check UI When Finished Assessment in Landing Site
    #   Verify if the Assessment is closed in case Share Assessment Results (OL-T18090)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE}    wait_time=2s
    #   Verify the Assessment Instructions button will update to "Completed" when the Assessment Completed in case Share Assessment Results (OL-T18091)
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    #   Verify Message Customization when the Assessment Completed in case Share Assessment Results (OL-T18093)
    Check Text Display      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    #   Verify the display of "Traitify Assessment Results" card (OL-T18095)
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_RESULT_CARD_MODAL}
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_VIEW_YOUR_RESULT_BUTTON}
    #   Verify the display of Candidate’s Assessment Results when “View Your Results” button is clicked (OL-T18096)
    Click At    ${LANDING_SITE_ASSESSMENT_VIEW_YOUR_RESULT_BUTTON}
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE_YOUR_ASSESSMENT_RESULT_CARD}
    #   Verify if ‘Your Assessment Results’ is closed when ‘X’ icon is clicked (OL-T18099)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}      Your Assessment Results
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE_YOUR_ASSESSMENT_RESULT_CARD}    wait_time=2s
    #   Check the PDF version of the Candidate’s Assessment Results is downloaded (OL-T18100)
    ${text} =       get_download_path
    ${files_before} =       List Files In Directory     ${text}
    ${numnber_files_before} =       get length      ${files_before}
    Click at    ${LANDING_SITE_ASSESSMENT_VIEW_YOUR_RESULT_BUTTON}
    wait for page load successfully
    Click at    ${LANDING_SITE_ASSESSMENT_DOWNLOAD_ICON}
    Wait with large time
    ${files_after} =    List Files In Directory     ${text}
    ${number_files_after} =     get length      ${files_after}
    Should not be equal as strings      ${numnber_files_before}     ${number_files_after}


Verify status updated to Assessment In-Progress when candidate clicks on Let's go button in case Share Assessment Results (OL-T18079)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_IN_PROGRESS_TEXT}


Verify if appearance of milestone when the Assessment Completed in case Share Assessment Results (OL-T18092)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED_TEXT}


Verify if candidate receives Complete your Assessment Email (OL-T18101)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Verify User Has Received The Email      Complete your assessment for ${COMPANY_TEST_ASSESSMENT}     Hi ${first_name}    COMPLETE_ASSESSMENT


Verify if the candidate receives Your Assessment Results Email (OL-T18102)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_PROGRAMMER}       ${web_management_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Verify User Has Received The Email      Your Assessment Results!    Hello ${first_name}     ASSESSMENT_RESULTS


Check behavior of Completed button when the assessment is completed and the candidate is moved to another status in case Share Assessment Results (OL-T20818)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_FARMER}       ${web_management_form_name}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Go To CEM Page
    Switch to user      ${CA_TEAM}
    Change conversation status      ${first_name}       Form    ${JOURNEY_SEND_FORM_ACTION}
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Go Back
    Reload Page
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_BUTTON_TEXT}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED}

