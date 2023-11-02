*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

*** Variable ***
${auto_offer}       auto_offer
${loop_count}       100

*** Test Cases ***
Run delete all spam offers
    Delete all spam offers

*** Keyword ***
Delete all spam offers
    [Arguments]     ${company_name}=None
    Given Setup test
    IF  '${company_name}' == 'None'
        ${company_name} =   Set variable    ${COMPANY_FRANCHISE_ON}
    END
    When Login into system with company    ${PARADOX_ADMIN}     ${company_name}
    Go to Offers page
    FOR  ${index}  IN RANGE   ${loop_count}
        ${offer_locator} =    Format String    ${MENU_ICON_BY_OFFERS_NAME_TO_DELETE}    ${auto_offer}
        ${is_offer_exist} =  Run Keyword And Return Status    Check element display on screen    ${offer_locator}    wait_time=1s
        IF  '${is_offer_exist}' == 'False'
            Reload page
            wait for page load successfully
            ${is_offer_exist} =  Run Keyword And Return Status    Check element display on screen    ${offer_locator}    wait_time=1s
            Exit For Loop If    '${is_offer_exist}' == 'False'
        END
        Click by JS    ${offer_locator}
        Click at    ${OFFER_ECLIPSE_POPUP_ICON_DELETE_ICON}
    END
