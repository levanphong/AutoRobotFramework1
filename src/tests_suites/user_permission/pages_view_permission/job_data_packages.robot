*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/job_data_packages_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Navigate to Client Setup page > Hire > Turn on Job toggle > Turn on Job Data Packages

*** Variables ***
${job_package_prefix}   auto_job_data_pakages_

*** Test Cases ***
Check Company Admin role has full access by default to view, edit, and manage the Job Data Package page after mirgrating the data when toggle Hire ON (OL-T19096)
    Given Setup test
    Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name} =      Generate random name only text      ${job_package_prefix}
    check user can view and actions on Job Data Packages page       ${job_package_name}


Check Franchise Owner role has full access by default to view, edit, and manage the Job Data Package page after mirgating the data (OL-T19095)
    Given Setup test
    Login into system with company    Franchise Owner    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name} =      Generate random name only text      ${job_package_prefix}
    check user can view and actions on Job Data Packages page       ${job_package_name}


Check Franchise Staff role has full access by default to view, edit, and manage the Job Data Package page after mirgating the data (OL-T19094)
    Given Setup test
    Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name} =      Generate random name only text      ${job_package_prefix}
    check user can view and actions on Job Data Packages page       ${job_package_name}


Check Super Admin/Paradox admin role has full access by default to view, edit. and manage the Job Data Package page after mirgrating the data (OL-T19098)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name} =      Generate random name only text      ${job_package_prefix}
    check user can view and actions on Job Data Packages page       ${job_package_name}


Check Company Admin role has full access by default to view, edit, and manage the Job Data Package page after mirgrating the data when Hire toggle is OFF (OL-T19097)
    Given Setup test
    Login into system with company    Company Admin    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to job data packages page
    ${job_package_name} =      Generate random name only text      ${job_package_prefix}
    check user can view and actions on Job Data Packages page       ${job_package_name}


*** Keywords ***
check user can view and actions on Job Data Packages page
    [Arguments]     ${job_package_name}
    add new job package    ${job_package_name}    Base Pay Maximum
    Job data pakages page is display
    delete job data package by search       ${job_package_name}

cannot see the Job Data Packages page on the menu
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Job Data Packages
    capture page screenshot

user can not access Job Data Packages page when has perm is No access
    [Arguments]     ${role_name}
    Given Setup test
    when Login into system with company    ${role_name}    ${COMPANY_FRANCHISE_ON}
    cannot see the Job Data Packages page on the menu
    # Check navigate by URL
    ${is_correct_page} =    Run keyword and return status       Go to job data packages page
    IF  '${is_correct_page}' == 'False'
        check element not display on screen      Job Data Packages
    END
    capture page screenshot
