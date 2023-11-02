*** Settings ***
Library             ../../utils/StringHandler.py
Resource            ../../pages/group_management_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          ltsstg    olivia    stg

*** Test Cases ***
Delete unused Group event company
    Delete group    ${COMPANY_EVENT}


Delete unused Group hire off company
    Delete group    ${COMPANY_HIRE_OFF}


Delete unused Group franchise off company
    Delete group    ${COMPANY_FRANCHISE_OFF}

*** Keywords ***
Delete group
    [Arguments]   ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go to Group Management page
    input into   ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}  auto_group
    FOR    ${index}    IN RANGE    1000
        ${is_finished} =    Run Keyword And Return Status    element should be visible    ${GROUP_IN_LIST_ECLIPSE_ICON}
        IF    '${is_finished}' == 'False'
            # To reload Group List
            input into   ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}  0
            input into   ${GROUP_MANAGEMENT_SEARCH_TEXT_BOX}  auto_group
            ${is_finished} =    Run Keyword And Return Status    element should be visible    ${GROUP_IN_LIST_ECLIPSE_ICON}
        END
        Exit For Loop If    ${is_finished} == False
        Click at    ${GROUP_IN_LIST_ECLIPSE_ICON}
        ${is_displayed} =  Run keyword and return status   Click at    ${ECLIPSE_DELETE_GROUP_BUTTON}
        IF   not ${is_displayed}
            Click at    ${GROUP_IN_LIST_ECLIPSE_ICON}
            Click at    ${ECLIPSE_DELETE_GROUP_BUTTON}
        END
        Click at    ${ECLIPSE_CONFIRM_DELETE_GROUP_BUTTON}
    END
    Capture page screenshot
