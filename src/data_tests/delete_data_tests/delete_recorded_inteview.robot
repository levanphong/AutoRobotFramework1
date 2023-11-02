*** Settings ***
Library             ../../utils/StringHandler.py
Variables           ../../locators/client_setup_locators.py
Resource            ../../pages/recorded_interview_builder_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${loop_count}       200

*** Test Cases ***
delete recorded interviews
    Delete recorded interview

*** Keyword ***
Delete recorded interview
    [Arguments]     ${company_name}=${COMPANY_EVENT}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to Recorded Interview Builder Interviews page
    Input into      ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}    auto_interview
    FOR  ${index}  IN RANGE     1   ${loop_count}
            Click at    ${RECORDED_INTERVIEW_PAGE_LIST_ITEMS_ECLIPSE}
            Check element display on screen    ${RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ACTION}   Delete
            Click at    ${RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ACTION}   Delete
            Click at    ${RECORDED_INTERVIEW_PAGE_DELETE_INTERVIEW_CONFIRM_DELETE_BUTTON}
            ${is_exist}=    Run Keyword And Return Status    Check element display on screen    ${RECORDED_INTERVIEW_PAGE_LIST_ITEMS_ECLIPSE_INDEX}     1
            IF  'is_exist' == 'False'
                Reload page
                Input into      ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}    auto_interview
                Delete list recored interview   ${loop_count}
            END
    END

Delete list recored interview
    [Arguments]     ${number}
    FOR  ${index}  IN RANGE     1   ${number}
            Click at    ${RECORDED_INTERVIEW_PAGE_LIST_ITEMS_ECLIPSE}
            Check element display on screen    ${RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ACTION}   Delete
            Click at    ${RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ACTION}   Delete
            Click at    ${RECORDED_INTERVIEW_PAGE_DELETE_INTERVIEW_CONFIRM_DELETE_BUTTON}
    END
