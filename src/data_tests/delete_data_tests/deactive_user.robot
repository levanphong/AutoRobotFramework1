*** Settings ***
Library             ../../utils/StringHandler.py
Variables           ../../locators/client_setup_locators.py
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${loop_count}   100

*** Test Cases ***
Start delete 1
    Deactivate user with start point

Start delete 2
    Deactivate user with start point    start_point=last

*** Keywords ***
Deactivate user with start point
    [Arguments]    ${start_point}=first     ${company_name}=${COMPANY_FRANCHISE_ON}
    # Set start point locator
    ${start_locator} =    Evaluate    """${USER_TEST_DELETE_LOCATOR_FIRST}""" if """${start_point}""" == "first" else """${USER_TEST_DELETE_LOCATOR_LAST}"""
    # Deactivate keyword
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to Users, Roles, Permissions page
    Input into  ${SEARCH_USER_TEXT_BOX}  Auto Test
    Wait with short time
    Scroll to bottom of table    ${USERS_LIST_TABLE}
    FOR  ${index}  IN RANGE   ${loop_count}
        Hover at  ${start_locator}
        ${is_clicked} =     Run keyword and return status    Click at  ${USER_ECLIPSE_ICON}
        IF  '${is_clicked}' == 'False'
            Hover at  ${start_locator}
            Click at  ${USER_ECLIPSE_ICON}
        END
        Click at  ${USER_ECLIPSE_MENU_DEACTIVATE_BUTTON}
        Click at  ${DEACTIVATE_USER_DEACTIVATE_BUTTON}
    END
