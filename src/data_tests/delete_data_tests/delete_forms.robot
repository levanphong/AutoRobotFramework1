*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

*** Variable ***
${auto_form}        auto_form
${loop_count}       100

*** Test Cases ***
Run delete spam candidate forms
    Delete all spam forms   Candidate Form


Run delete spam user forms
    Delete all spam forms   User Form

*** Keyword ***
Delete all spam forms
    [Arguments]     ${type_form}    ${company_name}=None
    Given Setup test
    IF  '${company_name}' == 'None'
        ${company_name} =   Set variable    ${COMPANY_FRANCHISE_ON}
    END
    when Login into system with company    ${PARADOX_ADMIN}     ${company_name}
    Go to form page
    IF      '${type_form}' == 'User Form'
        Click at    ${USER_FORM_TAB}
    END
    FOR  ${index}  IN RANGE   ${loop_count}
        ${form_locator} =    Format String    ${MENU_ICON_BY_FORM_NAME_TO_DELETE}    ${auto_form}
        ${is_form_exist} =  Run Keyword And Return Status    Check element display on screen    ${form_locator}    wait_time=1s
        IF  '${is_form_exist}' == 'False'
            Reload page
            wait for page load successfully v1
            ${is_form_exist} =  Run Keyword And Return Status    Check element display on screen    ${form_locator}    wait_time=1s
            Exit For Loop If    '${is_form_exist}' == 'False'
        END
        Click by JS    ${form_locator}
        Click at    ${DELETE_FORM_ICON}
        Click at    ${CONFIRM_DELETE_DIALOG_BUTTON}
    END
