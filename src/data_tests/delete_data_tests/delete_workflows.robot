*** Settings ***
Library             ../../utils/StringHandler.py
Variables           ../../locators/client_setup_locators.py
Resource            ../../pages/workflows_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{name_to_delete_list}=     auto_workflow
${loop_count}   100
@{list_company}=        Test Automation - Event        Test Automation Franchise On

*** Test Cases ***
Start delete
    FOR    ${company}    IN    @{list_company}
        Delete keyword      ${company}
    END

*** Keywords ***
Delete keyword
    [Arguments]     ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go to Workflows page
    ${skip_index} =    set variable    ${1}
    FOR    ${item_name}    IN    @{name_to_delete_list}
        FOR  ${index}  IN RANGE   ${loop_count}
            ${icon_locator} =    Catenate    SEPARATOR=    ${WORKFLOW_ECLIPSE_ICON}    [${skip_index}]
            ${is_item_exist} =  Run keyword and return status   Click by JS    ${icon_locator}    ${item_name}
            IF  '${is_item_exist}' == 'False'
                Reload page
                ${is_item_exist} =  Run keyword and return status   Click by JS    ${icon_locator}    ${item_name}
                Exit For Loop If    ${is_item_exist} == False
                Click by JS    ${icon_locator}    ${item_name}
            END
            Click at    ${WORKFLOW_ECLIPSE_POPUP_DELETE_BUTTON}    ${item_name}
            Click at    ${WORKFLOW_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}
        END
    END
    logout from system by URL

Check unpublished Workflow
    [Arguments]     ${icon_locator}     ${item_name}    ${skip_index}
    ${is_unpublished_workflow} =    Run keyword and return status   Check element display on screen  ${WORKFLOW_ECLIPSE_POPUP_UNPUBLISHED}  wait_time=1s
    IF  '${is_unpublished_workflow}' == 'False'
        # Close eclipse menu
        Click by JS    ${icon_locator}    ${item_name}
        ${skip_index} =    set variable    ${skip_index+1}
        ${icon_locator} =    Catenate    SEPARATOR=    ${WORKFLOW_ECLIPSE_ICON}    [${skip_index}]
        # Open with new eclipse index
        Click by JS    ${icon_locator}    ${item_name}
        ${skip_index} =     Check unpublished Workflow     ${icon_locator}     ${item_name}    ${skip_index}
    END
    [Return]    ${skip_index}
