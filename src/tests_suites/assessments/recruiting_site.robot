*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/assessment_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/all_candidates_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        regression    test

*** Variables ***
${recruiting_site}      CA Team's Recruiting Site

*** Test Cases ***
Verify message customization when candidate receives Assessment in case Do not share Assessment Results (OL-T18852, OL-T18853, OL-T18855, OL-T18857, OL-T18858, OL-T18859, OL-T18860, OL-T18862, OL-T18863, OL-T18861, OL-T18864, OL-T18866, OL-T18867, OL-T18868, OL-T18869, OL-T18870)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Check message in conversation when transfer send assessment in Landing Site
    #   Verify if the candidate clicks on "Let's go" button in case Do not share Assessment Results (OL-T18855)
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify if candidate opens an Assessment and then clicking on “X" icon in case Do not share Assessment Results (OL-T18859, OL-T18860)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Check UI Confirm Modal When Click X Icon in Landing Site
    #   Verify if “Cancel" button is clicked in case Do not share Assessment Results (OL-T18862)
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_CANCEL_BUTTON}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}    ${ASSESSMENT_BUTTON_EXIT}       wait_time=2s
    Check UI Assessment Display in Landing Site
    #   Verify if "Me" button is clicked in case Do not share Assessment Results (OL-T18857)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_ME}
    #   Verify if "Not Me" button is clicked in case Do not share Assessment Results (OL-T18858)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_NOT_ME}
    #   Verify if “X" button in Confirm modal is clicked in case Do not share Assessment Results (OL-T18863)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_BUTTON_EXIT}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}    ${ASSESSMENT_BUTTON_EXIT}       wait_time=2s
    Check UI Assessment Display in Landing Site
    #   Verify if “Exit" button is clicked in case Do not share Assessment Results (OL-T18861)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_EXIT_BUTTON}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_STATUS_CONTINUE}
    Capture page screenshot
    #   Verify if "Continue Assessment" button is clicked in case Do not share Assessment Results (OL-T18864)
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify UI of the Assessment when the Assessment Completed in case Do not share Assessment Results (OL-T18866)
    Click on Me button until finish
    Check UI When Finished Assessment In Landing Site
    #   Verify if the Assessment is closed in case Do not share Assessment Results (OL-T18867)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE}    wait_time=2s
    Capture page screenshot
    #   Verify the Assessment Instructions button will update to "Completed" when the Assessment Completed in case Do not share Assessment Results (OL-T18868)
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Capture page screenshot
    #   Verify Message Customization when the Assessment Completed in case Do not share Assessment Results (OL-T18870)
    Verify Olivia conversation message display      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    Capture page screenshot
    #   Verify if appearance of milestone when the Assessment Completed in case Do not share Assessment Results (OL-T18869)
    Check Status Of Candidate In CEM Page       ${candidate_name}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED_TEXT}


Verify status updated to Assessment In-Progress when candidate clicks on Let's go button in case Do not share Assessment Results (OL-T18856)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check Status Of Candidate In CEM Page       ${candidate_name}       ${ASSESSMENT_BUTTON_STATUS_IN_PROGRESS_TEXT}


Verify if X icon of Assessment Complete Modal is clicked in case Do not Share Assessment Results (OL-T18871)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Check Text Display      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}


Check behavior of Completed button when the assessment is completed and the candidate is moved to another status in case Do not share Assessment Results (OL-T20825)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Go To CEM Page
    Switch to user      ${CA_TEAM}
    Change conversation status      ${candidate_name}       Form    ${JOURNEY_SEND_FORM_ACTION}
    Click at    ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Go Back
    Reload Page
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_BUTTON_TEXT}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}


Verify if the candidate clicks on Let's go button in case Share Assessment Results (OL-T18872, OL-T18876, OL-T18877, OL-T18879, OL-T18874, OL-T18875, OL-T18880, OL-T18878, OL-T18881, OL-T18883, OL-T18884, OL-T18885, OL-T18887, OL-T18889, OL-T18890, OL-T18893, OL-T18894)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Check message in conversation when transfer send assessment in Landing Site
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify if candidate opens an Assessment and then clicking on "X" icon in case Share Assessment Results (OL-T18876,OL-T18877)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Check UI Confirm Modal When Click X Icon in Landing Site
    #   Verify if "Cancel" button is clicked in case Share Assessment Results (OL-T18879)
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_CANCEL_BUTTON}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}    ${ASSESSMENT_BUTTON_EXIT}       wait_time=2s
    Check UI Assessment Display in Landing Site
     #   Verify if "Me" button is clicked in case Share Assessment Results (OL-T18874)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_ME}
    #   Verify if "Not Me" button is clicked in case Share Assessment Results (OL-T18875)
    Check UI Assessment When Click Me/NotMe Button in Landing Site      ${LANDING_SITE_ASSESSMENT_BUTTON_NOT_ME}
    #   Verify if "X" button in Confirm modal is clicked in case Share Assessment Results (OL-T18880)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_BUTTON_EXIT}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL}    ${ASSESSMENT_BUTTON_EXIT}   wait_time=2s
    Check UI Assessment Display in Landing Site
    #   Verify if "Exit" button is clicked in case Share Assessment Results (OL-T18878)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     ${ASSESSMENT_HEADER_TEXT}
    Click At    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_EXIT_BUTTON}
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_STATUS_CONTINUE}
    #   Verify if "Continue Assessment" button is clicked in case Share Assessment Results (OL-T18881)
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check UI Assessment Display in Landing Site
    #   Verify UI of the Assessment when the Assessment Completed in case Share Assessment Results (OL-T18883)
    Click on Me button until finish
    Check UI When Finished Assessment in Landing Site
    #   Verify if the Assessment is closed in case Share Assessment Results (OL-T18884)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE}    wait_time=2s
    #   Verify the Assessment Instructions button will update to "Completed" when the Assessment Completed in case Share Assessment Results (OL-T18885)
    ${text_button}=     Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Should Be Equal As Strings      ${text_button}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    #   Verify Message Customization when the Assessment Completed in case Share Assessment Results (OL-T18887)
    Check Text Display      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    #   Verify the display of "Traitify Assessment Results" card (OL-T18889)
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_RESULT_CARD_MODAL}
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_VIEW_YOUR_RESULT_BUTTON}
    #   Verify the display of Candidate's Assessment Results when "View Your Results" button is clicked (OL-T18890)
    Click At    ${LANDING_SITE_ASSESSMENT_VIEW_YOUR_RESULT_BUTTON}
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE_YOUR_ASSESSMENT_RESULT_CARD}
    #   Verify if 'Your Assessment Results' is closed when 'X' icon is clicked (OL-T18893)
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}     Your Assessment Results
    Check Element Not Display On Screen     ${LANDING_SITE_ASSESSMENT_TITLE_YOUR_ASSESSMENT_RESULT_CARD}    wait_time=2s
    #   Check the PDF version of the Candidate's Assessment Results is downloaded (OL-T18894)
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


Verify status updated to Assessment In-Progress when candidate clicks on Let's go button in case Share Assessment Results (OL-T18873)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_IN_PROGRESS_TEXT}


Verify if appearance of milestone when the Assessment Completed in case Share Assessment Results (OL-T18886)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check Status Of Candidate In CEM Page       ${first_name}       ${ASSESSMENT_BUTTON_STATUS_COMPLETED_TEXT}


Verify if candidate receives Complete your Assessment Email (OL-T18895)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Verify User Has Received The Email      Complete your assessment for ${COMPANY_TEST_ASSESSMENT}     Hi ${first_name}    COMPLETE_ASSESSMENT


Verify if the candidate receives Your Assessment Results Email (OL-T18896)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
    Click At    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Click on Me button until finish
    Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Verify User Has Received The Email      Your Assessment Results!    Hello ${first_name}     ASSESSMENT_RESULTS


Check behavior of Completed button when the assessment is completed and the candidate is moved to another status in case Share Assessment Results (OL-T20826)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_TEST_ASSESSMENT}
    ${first_name}=      Chat landing site to send assessment    ${JOB_DOCTOR}       ${recruiting_site}
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
    Check Element Display On Screen     ${LANDING_SITE_ASSESSMENT_BUTTON_TEXT}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
