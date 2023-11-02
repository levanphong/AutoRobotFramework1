*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/microlearning_page.robot
Variables           ../../../locators/all_candidates_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Login by viewonly.prod@paradox.ai. Go to Menu/Setting/Client Setup/ More/ Turn on Mircolearning

*** Test Cases ***
Check Paradox admin role has full access to view, edit, and manage the Microlearning page after mirgating the data (OL-T17278)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Click at    ${LEFT_MENU_BUTTON}
    check element display on screen     ${CEM_PAGE_RIGHT_MENU_ITEM}      Microlearning
    go to microlearning page
    check element display on screen     ${COURSES_LIST}
    element should be enabled   ${ADD_NEW_COURSE_BUTTON}


Check Account admin role is set to Full access by default for Microlearning page after mirgating the data (OL-T17279)
    [Tags]    regression    test
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Navigate to User Role view page     Account Admin
    Check permission for product by role      Microlearning   Full Access


Check Company admin role has full access to view, edit, and manage the Microlearning page after mirgating the data (OL-T17280)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to User Role view page     Company Admin
    Check permission for product by role      Microlearning   Full Access
    Click at   ${VIEW_PAGE_USER_ROLES_X_BUTTON}
    switch to user  CA Team
	go to microlearning page
	${course_name} =  Add A Course     Course
    Check course is added   ${course_name}
    Archive A Course      ${course_name}


Check Power User role is set to No access by default for Microlearning page after mirgating the data (OL-T17281)
    [Tags]    regression    test
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Navigate to User Role view page     Power User
    Check permission for product by role      Microlearning   No Access


Check Franchise Staff role has no access to the Microlearning page after mirgating the data (OL-T17282)
    Check a role has no access to the Microlearning page after mirgating the data   FS Team     Franchise Staff


Check Franchise Owner role has no access to the Microlearning page after mirgating the data (OL-T17283)
    Check a role has no access to the Microlearning page after mirgating the data   FO Team     Franchise Owner


Check Edit nothing role has no access to the Microlearning page after mirgating the data (OL-T17284)
    Check a role has no access to the Microlearning page after mirgating the data   EN Team     Full User - Edit Nothing


Check Edit everything role has no access to the Microlearning page after mirgating the data (OL-T17285)
    [Tags]    regression    test
    Check a role has no access to the Microlearning page after mirgating the data   EE Team     Full User - Edit Everything


Check Hiring manager role has no access to the Microlearning page after mirgating the data (OL-T17286)
    Check a role has no access to the Microlearning page after mirgating the data   Hiring Team     Hiring Manager


Check Recruiter role has no access to the Microlearning page after mirgating the data (OL-T17287)
    Check a role has no access to the Microlearning page after mirgating the data   Recruiter Team     Recruiter


Check Supervisor role has no access to the Microlearning page after mirgating the data (OL-T17288)
    Check a role has no access to the Microlearning page after mirgating the data   Supervisor Team     Supervisor


Check Limited user role is set to No access by default for Microlearning page after mirgating the data (OL-T17289)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to User Role view page     Limited User
    Check permission for product by role     Microlearning   No Access
    Click at   ${VIEW_PAGE_USER_ROLES_X_BUTTON}


*** Keywords ***
Check a role has no access to the Microlearning page after mirgating the data
    [Arguments]     ${user_name}    ${role_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to User Role view page    ${role_name}
    Check permission for product by role      Microlearning   No Access
    Click at   ${VIEW_PAGE_USER_ROLES_X_BUTTON}
    switch to user  ${user_name}
    Click at    ${LEFT_MENU_BUTTON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Microlearning
    capture page screenshot
