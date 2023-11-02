*** Settings ***
Library             ../../utils/StringHandler.py
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/base_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{list_job_template_name}      auto_job     auto_template    Auto_job

*** Test Cases ***
Run delete all spam jobs template
    Delete All Auto Jobs Template      ${COMPANY_FRANCHISE_ON}

*** Keyword ***
Delete All Auto Jobs Template
    [Arguments]     ${company_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to Jobs page
    Click at    ${JOB_TEMPLATES_TAB}
    FOR    ${job_template_name}    IN    @{list_job_template_name}
        Input into    ${SEARCH_JOB_TEMPLATE_TEXT_BOX}    ${job_template_name}
        FOR  ${index}  IN RANGE   100
            ${job_template_locators} =    Format String    ${JOB_TEMPLATE_ECLIPSE_ICON}    ${job_template_name}
            ${is_has_job_template_locators} =  Run Keyword And Return Status    Check element display on screen    ${job_template_locators}     wait_time=10s
            Exit For Loop If    ${is_has_job_template_locators} == False
            Click at    ${job_template_locators}
            Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
            Click at    ${JOB_ECLIPSE_CONFIRM_POPUP_DELETE_BUTTON}
        END
    END
