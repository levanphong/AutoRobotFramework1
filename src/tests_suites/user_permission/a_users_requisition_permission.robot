*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../data_tests/job_external/requisition_based_permission.robot
Variables           ../../locators/users_roles_permissions_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Switch to Test Automation Applicant Flow company. All pre-conditions are setted up(Job search is ON, Job feed is selected, Requisition Based Permissions and Alerts at More tab is ON). Go to Client setup/Intergrations/Turn on ATS Intergation

*** Test Cases ***
Check Requisition Permissions column isn't added to the Users, Roles and Permissions page (OL-T19397)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    go to users, roles, permissions page
    check element not display on screen     ${USER_CELL_HEADER_VALUE}   Requisition Permissions
