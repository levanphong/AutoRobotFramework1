*** Settings ***
Library             ../../utils/StringHandler.py
Resource            ../../pages/cms_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${condition_title}   auto_condition

*** Test Cases ***
Delete unused condtions
    #   COMPANY_APPLICANT_FLOW
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    Click at    ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
    FOR     ${index}  IN RANGE  100
        Click at    ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
        ${still_remain} =  Run keyword and return status  Check element display on screen   ${CONDITION_CRITERIA_TRASH_ICON}    ${condition_title}
        Exit For Loop If    ${still_remain} == False
    END
    Click at    ${CONDITION_CRITERIA_APPLY_BUTTON}
    Wait for toast message disappeard
    #   To check again
    Click at    ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
    Capture page screenshot
