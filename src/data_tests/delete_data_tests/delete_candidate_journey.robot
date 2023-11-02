*** Settings ***
Library             ../../utils/StringHandler.py
Variables           ../../locators/client_setup_locators.py
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***

@{list_candidate_name}=     Auto_journey    auto_journey
@{list_company}=        Test Automation - Event        Test Automation Franchise On
${loop_count}   100

*** Test Cases ***
Delete journey in Candidate journey page
    FOR    ${company}    IN    @{list_company}
        Delete unused candidate journey     ${company}
    END

*** Keywords ***
Delete unused candidate journey
    [Arguments]     ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go to Candidate Journeys page
    FOR    ${journey_name}    IN    @{list_candidate_name}
        FOR  ${index}  IN RANGE   ${loop_count}
            ${is_has_candidate_journey}=  Run Keyword And Return Status    Check element display on screen    ${JOURNEY_ECLIPSE_ICON}    ${journey_name}    wait_time=1s
            IF  ${is_has_candidate_journey} == False
                reload page
                ${is_has_candidate_journey}=  Run Keyword And Return Status    Check element display on screen   ${JOURNEY_ECLIPSE_ICON}    ${journey_name}    wait_time=1s
                Exit For Loop If    ${is_has_candidate_journey} == False
            END
            Click by JS    ${JOURNEY_ECLIPSE_ICON}    ${journey_name}
            ${delete_locator}=  format string  ${JOURNEY_ECLIPSE_POPUP_DELETE_BUTTON}    ${journey_name}
            Click at  ${delete_locator}
            Click at  ${JOURNEY_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}
        END
    END
    logout from system by URL
