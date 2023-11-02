*** Settings ***
Resource            ../user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check Add New User when filling valid value on Active Users dashboard (OL-T16796, OL-T16825)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Click at  ${USERS_NAVIGATION_ROLE}  Active User
    Capture page screenshot
    Deactivate a User   ${user_fname}


Check Add New User when filling valid value on Account Admin dashboard (OL-T16797)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check add new user with role   Account Admin  Account Admin


Check Add New User when filling valid value on Power User dashboard (OL-T16798, OL-T16800)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check add new user with role   Power User  Power User


Check Add New User when filling valid value on Limited User dashboard (OL-T16799, OL-T16826)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Check add new user with role   Limited User  Limited User


Check Add New User when filling valid value on Supervisors dashboard (OL-T16801)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Supervisor  Supervisor


Check Add New User when filling valid value on Recruiters dashboard (OL-T16802)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Recruiter  Recruiter


Check Add New User when filling valid value on Hiring Managers dashboard (OL-T16803)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Hiring Manager  Hiring Manager


Check Add New User when filling valid value on Full User - Edit Everything dashboard (OL-T16804)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Full User - Edit Everything  Full User - Edit Everything


Check Add New User when filling valid value on Full User - Edit Nothing dashboard (OL-T16805)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Full User - Edit Nothing  Full User - Edit Nothing


Check Add New User when filling valid value on Reporting Users dashboard (OL-T16806)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Reporting User  Reporting User


Check Add New User when filling valid value on Basic Users dashboard (OL-T16807)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Basic User  Basic User


Check Add New User with Power Userss role (OL-T16808)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Check add new user with role   Power User


Check Add New User with Superviors role (OL-T16809)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Supervisor


Check Add New User with Recruiters role (OL-T16810)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Recruiter


Check Add New User with Hiring Managers role (OL-T16811)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Hiring Manager


Check Add New User with Limited Users role (OL-T16812)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Limited User


Check Add New User with Full Users - Edit Nothing role (OL-T16813)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Full User - Edit Nothing


Check Add New User with Reporting Users role (OL-T16814)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Reporting User


Check Add New User with Basic Users role (OL-T16815)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check add new user with role   Basic User


Check cannot Add new User when filling blank First Name (OL-T16816)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Input Add new user form with missing value  fname=${EMPTY}
    Check element display on screen  First name is required
    Capture page screenshot


Check cannot Add new User when filling blank Last Name (OL-T16817)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Input Add new user form with missing value  lname=${EMPTY}
    Check element display on screen  Last name is required
    Capture page screenshot


Check cannot Add new User when filling blank Job Title (OL-T16818)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Input Add new user form with missing value  job_title=${EMPTY}
    Check element display on screen  Job title is required
    Capture page screenshot


Check cannot Add new User when filling blank Email (OL-T16819, OL-T16822)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Input Add new user form with missing value  email=${EMPTY}
    Check element display on screen  Email is required
    Capture page screenshot


Check cannot Add new Users when don't fill value to fields (OL-T16820)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at  ${ADD_NEW_USER_BUTTON}
    Click at  ${ADD_NEW_USER_ADD_BUTTON}
    Check element display on screen  First name is required
    Check element display on screen  Last name is required
    Check element display on screen  Email is required
    Capture page screenshot


Check Pre-Number of Phone Number field on add new user phase (OL-T16821)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at  ${ADD_NEW_USER_BUTTON}
    Click at  ${ADD_NEW_USER_PRE_PHONE_CODE_DROPDOWN}
    Check element display on screen  ${ADD_NEW_USER_PRE_PHONE_CODE_DROPDOWN_LIST}
    Capture page screenshot


Check click Cancel button on add new user phase (OL-T16823)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at  ${ADD_NEW_USER_BUTTON}
    Click at  ${ADD_NEW_USER_CANCEL_BUTTON}
    Check element not display on screen  ${ADD_NEW_USER_FNAME_TEXT_BOX}
    Capture page screenshot


Check click X button on add new user phase (OL-T16824)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Click at  ${ADD_NEW_USER_BUTTON}
    Click at  ${ADD_NEW_USER_X_BUTTON}
    Check element not display on screen  ${ADD_NEW_USER_FNAME_TEXT_BOX}
    Capture page screenshot


Check User Name on list view (OL-T16827, OL-T16828, OL-T16829, OL-T16830, OL-T16831, , OL-T16832, , OL-T16833)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Check element display on screen  ${user_fname}
    Check element display on screen  User Role
    Check element display on screen  Job Title
    Check element display on screen  Availability
    Check element display on screen  Locations
    Check element display on screen  Last Active Session
    Capture page screenshot
    Deactivate a User   ${user_fname}
