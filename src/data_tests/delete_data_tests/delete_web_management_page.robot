*** Settings ***
Library             ../../utils/StringHandler.py
Variables           ../../locators/client_setup_locators.py
Resource            ../../pages/web_management_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${default_company_name}     ${COMPANY_FRANCHISE_ON}
${loop_count}   100

*** Test Cases ***
Delete site in Web Management page
    Delete unused landing site/widget site

*** Keywords ***
Delete unused landing site/widget site
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${default_company_name}
    Go to Web Management
    Input into  ${SEARCH_WEB_PAGE}  auto_web_
    Wait with medium time
    ${skip_index} =    set variable    ${1}
    FOR    ${index}    IN RANGE    ${loop_count}
        ${icon_locator} =    Catenate    SEPARATOR=    ${ECLIPSE_BUTTON_SITE}    [${skip_index}]
        ${is_end_page} =    Run Keyword And Return Status    Click at    ${icon_locator}
        IF    '${is_end_page}' == 'False'
                Reload page
                Input into  ${SEARCH_WEB_PAGE}  auto_web_
                Wait with medium time
                ${skip_index} =    set variable    ${1}
                ${icon_locator} =    Catenate    SEPARATOR=    ${ECLIPSE_BUTTON_SITE}    [${skip_index}]
                Click at    ${icon_locator}
        END
        ${is_locator_visible} =    Run Keyword And Return Status    Click at    ${DELETE_BUTTON_SITE}
        IF    '${is_locator_visible}' == 'True'
            Click at    ${CONFIRM_DELETE_BUTTON_SITE}
        ELSE
            ${skip_index} =    set variable    ${skip_index+1}
        END
    END
