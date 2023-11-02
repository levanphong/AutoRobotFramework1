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
Delete Edit nothing role
    Delete keyword  Full user - edit nothing


Delete Edit everything role
    Delete keyword  Full user - edit everything


Delete Company admin role
    Delete keyword  Company admin


Delete Franchise owner role
    Delete keyword  Franchise owner


Delete Franchise staff role
    Delete keyword  Franchise staff


Delete Basic user role
    Delete keyword  Basic user

*** Keywords ***
Delete keyword
    [Arguments]     ${role_name}    ${company_name}=${COMPANY_FRANCHISE_ON}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to Roles and Permissions page
    ${role_name} =  Set variable    ${role_name}_
    FOR  ${index}  IN RANGE   ${loop_count}
        Scroll to bottom of table   ${ROLES_AND_PERMISSION_LIST}   ${LOADING_ICON_3}
        Click by JS    ${ROLES_ECLIPSE_ICON}    ${role_name}
        Click at    ${ROLES_ECLIPSE_MENU_DELETE_BUTTON}
        Click at    ${ROLES_ECLIPSE_MENU_DELETE_CONFIRM_BUTTON}
    END

