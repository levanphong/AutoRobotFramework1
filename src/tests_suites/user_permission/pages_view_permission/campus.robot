*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/campus_page.robot
Resource            ../../../pages/school_management_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Campus page: Client Setup > Campus > Turn ON Campus toggle

*** Variables ***

*** Test Cases ***
Check the Campus page is displayed for user has full access in case user is Full User - Edit Everything (OL-T17078)
    Check user can go to Campus page    Full User - Edit Everything    ${COMPANY_FRANCHISE_ON}


Check the Campus page is displayed in case user is Company Admin (OL-T17077)
    Check user can go to Campus page    Company Admin    ${COMPANY_FRANCHISE_ON}


Check the Campus page is displayed under Menu in case user is Paradox Admin (OL-T17076)
    Check user can go to Campus page    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}


Verify Full User Edit Everything has full access to view campuses that are assigned to that user (OL-T17080)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${school_name} =     Create a new school     school_user_name=EE Team
    Switch to user old version  EE Team
    Go to Campus page
    Go to School details  ${school_name}
    Check element display on screen  ${CAMPUS_DETAIL_BOARD}
    Capture page screenshot
    Switch to user old version  ${TEAM_USER}
    Delete a school  ${school_name}


Verify Paradox Admin User can view all campuses (OL-T17079)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    ${school_name} =     Create a new school
    logout from system by URL
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Campus page
    Go to School details  ${school_name}
    Check element display on screen  ${CAMPUS_DETAIL_BOARD}
    Capture page screenshot
    Delete a school  ${school_name}

*** Keywords ***
Verify Campus page display in Right Menu and go to this page
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Check element display on screen  ${CEM_PAGE_RIGHT_MENU_CAMPUS}
    Capture page screenshot
    Click at  ${CEM_PAGE_RIGHT_MENU_CAMPUS}

Check user can go to Campus page
    [Arguments]     ${user_role}    ${company}
    Given Setup test
    when Login into system with company    ${user_role}    ${company}
    Verify Campus page display in Right Menu and go to this page
    ${current_url} =    Get Location
    Should Contain      ${current_url}      /campus-page
    Capture page screenshot
