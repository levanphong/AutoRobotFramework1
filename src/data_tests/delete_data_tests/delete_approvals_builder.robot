*** Settings ***
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${auto_name}    auto_approval

*** Test Cases ***
Delete unused approval flow - Company Event
    Delete approval flows       ${COMPANY_EVENT}


Delete unused approval flow - Company Franchise On
    Delete approval flows       ${COMPANY_FRANCHISE_ON}

*** Keywords ***
Delete approval flows
    [Arguments]   ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go To Approvals Builder Page
    Load full Approval Flows in page
    ${row_name}=    Format String   ${COMMON_TEXT}      ${auto_name}
    @{list_row_name}=   Get Webelements    ${row_name}
    FOR  ${row_name}  IN  @{list_row_name}
        ${approval_name}=   Get Text And Format Text    ${row_name}
        Click At    ${APPROVAL_BUILDER_ROW_ELIPSIS}     ${approval_name}
        Click At    ${APPROVAL_BUILDER_SUBMENU_DELETE}  ${approval_name}
        Click At    ${APPROVAL_BUILDER_BUTTON_CONFIRM_DELETE}
    END
