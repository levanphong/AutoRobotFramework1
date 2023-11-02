*** Settings ***
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${prefix_job}      auto_

*** Test Cases ***
Run delete all spam jobs
    Delete All Auto Jobs      ${COMPANY_FRANCHISE_ON}

*** Keyword ***
Delete All Auto Jobs
    [Arguments]     ${company_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to Jobs page
    search job name  ${prefix_job}    ${JF_COFFEE_FAMILY_JOB}
    FOR   ${index}   IN RANGE  1000
        ${is_remained} =  Run keyword and return status   Click at    ${JOBS_FIRST_JOB_ECLIPSE_MENU}
        Exit for loop if   '${is_remained}' == 'False'
        click by js    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
        Click at    ${COMMON_TEXT_LAST}     Delete
    END
