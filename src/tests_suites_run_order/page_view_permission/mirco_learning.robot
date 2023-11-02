*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/microlearning_page.robot
Variables           ../../../locators/all_candidates_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test    lts_stg

Documentation       Login by viewonly.prod@paradox.ai. Go to Menu/Setting/Client Setup/ More/ Turn on Mircolearning

*** Variables ***
${test_user}    Test Deactive

*** Test Cases ***
Check User only has viewing access to the Microlearning page if the User role updated to View Access (OL-T17290)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_NEW_ROLE}
    Navigate to User Role edit page     Account Admin
    set permission for corresponding role   Microlearning   View Access
    Navigate to User Role view page     Account Admin
    Check permission for product by role      Microlearning   View Access
    Click at   ${VIEW_PAGE_USER_ROLES_X_BUTTON}
    switch to user  ${test_user}
    Click at    ${LEFT_MENU_BUTTON}
    check element display on screen     ${MENU_SETTINGS_ITEM_LINK}      Microlearning
    go to microlearning page
    check element display on screen     ${COURSES_LIST}
    #   Check create button is not displayed
    Check element not display on screen  ${ADD_NEW_COURSE_BUTTON}
    Switch to user old version      ${TEAM_USER}
    #   Set back to default
    Navigate to User Role view page     Account Admin
    Check permission for product by role      Microlearning   Full Access
    capture page screenshot


Check User has no access to the Microlearning page if the User role updated to No Access (OL-T17291)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_NEW_ROLE}
    Navigate to User Role edit page     Account Admin
    set permission for corresponding role   Microlearning   No Access
    Navigate to User Role view page     Account Admin
    Check permission for product by role      Microlearning   No Access
    Click at   ${VIEW_PAGE_USER_ROLES_X_BUTTON}
    switch to user  ${test_user}
    Click at    ${LEFT_MENU_BUTTON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Microlearning


Check User has Full access to the Microlearning page if the User role updated to Full Access (OL-T17292)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_NEW_ROLE}
    Navigate to User Role edit page     Power User
    set permission for corresponding role   Microlearning   Full Access
    Navigate to User Role edit page     Account Admin
    #   make sure Account Admin have full access
    set permission for corresponding role   Microlearning   Full Access
    Navigate to User Role view page     Power User
    Check permission for product by role      Microlearning   Full Access
    Click at   ${VIEW_PAGE_USER_ROLES_X_BUTTON}
    switch to user  ${test_user}
    Click at    ${LEFT_MENU_BUTTON}
    check element display on screen     ${MENU_SETTINGS_ITEM_LINK}      Microlearning
    go to microlearning page
	${course_name} =  Add A Course     Course
    Check course is added   ${course_name}
    Archive A Course      ${course_name}
