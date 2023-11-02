*** Settings ***
Library             ../utils/StringHandler.py
Variables           ../locators/client_setup_locators.py
Resource            ../pages/candidate_journeys_page.robot
Resource            ../pages/conversation_builder_page.robot
Resource            ../pages/school_management_page.robot
Resource            ../pages/campaigns_page.robot
Resource            ../pages/workflows_page.robot
Resource            ../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{list_candidate_name}=     auto_candidate    auto_journey    CANDIDATE_JOURNEY
@{list_workflow_name}=      auto_workflow

*** Test Cases ***
Delete a Workflow
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Workflows page
    FOR    ${workflow_name}    IN    @{list_workflow_name}
        FOR  ${index}  IN RANGE   100
            ${workflows_locators} =     Format String       ${WORKFLOW_ECLIPSE_ICON}    ${workflow_name}
            ${is_has_workflows_locators} =      Run Keyword And Return Status       Check element display on screen     ${workflows_locators}
            IF  ${is_has_workflows_locators} == False
                reload page
                wait for page load successfully v1
                ${is_has_workflows_locators} =      Run Keyword And Return Status       Check element display on screen     ${workflows_locators}
                Exit For Loop If    ${is_has_workflows_locators} == False
            END
            Click by JS     ${workflows_locators}
            Click at    ${WORKFLOW_ECLIPSE_POPUP_DELETE_BUTTON}     ${workflow_name}    1s
            Click at    ${WORKFLOW_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}     slow_down=1s
        END
    END


Delete candidate journey
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Candidate Journeys page
    FOR    ${journey_name}    IN    @{list_candidate_name}
        FOR  ${index}  IN RANGE   100
            ${journey_eclipse_locator} =    Format String       ${JOURNEY_ECLIPSE_ICON}     ${journey_name}
            ${is_has_candidate_journey}=    Run Keyword And Return Status       Check element display on screen     ${journey_eclipse_locator}
            IF  ${is_has_candidate_journey} == False
                reload page
                wait for page load successfully v1
                ${is_has_candidate_journey}=    Run Keyword And Return Status       Check element display on screen     ${journey_eclipse_locator}
                Exit For Loop If    ${is_has_candidate_journey} == False
            END
            scroll to element       ${journey_eclipse_locator}
            Click by JS     ${journey_eclipse_locator}
            ${delete_locator}=      format string       ${JOURNEY_ECLIPSE_POPUP_DELETE_BUTTON}      ${journey_name}
            Click at    ${delete_locator}       slow_down=1s
            Click at    ${JOURNEY_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}      slow_down=1s
            wait for page load successfully v1
        END
    END


Delete School in School Management Page
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Delete schools in School Management Page


Delete Campaign
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    @{status_campaign}=     Create List     Scheduled       Drafts      Paused
    FOR    ${status}    IN      @{status_campaign}
        Click at    ${CAMPAIGN_PAGE_TAB_ITEM}       ${status}
        ${wait_time}=       Set Variable    60s
        Set Selenium Timeout    ${wait_time}
        Load full Campaign in page
        ${list_value} =     Get WebElements     ${CAMPAIGN_ROW_NAME}
        FOR    ${campaign_name}    IN    @{list_value}
            Click at    ${CAMPAIGN_ITEM_ECLIPSE_FIRST_USER_BUTTON}
            Click at    ${CAMPAIGN_ITEM_ECLIPSE_MENU_DELETE_BUTTON}
            Click at    ${CAMPAIGN_ITEM_DELETE_POPUP_DELETE_BUTTON}
        END
    END
