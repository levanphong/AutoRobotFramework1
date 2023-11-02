*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***
${job_family_name}           Coffee family job
${job_location}              ${LOCATION_NAME_2}

*** Test Cases ***
Check Paradox admin role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page (OL-T19117)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_PA     ${job_location}


Check Supervisor role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19111)
    Given Setup test
    Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Supervisor     ${job_location}


Check Supervisor role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is OFF (OL-T19112)
    Given Setup test
    Login into system with company    Supervisor    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Supervisor     ${job_location}


Check Franchise Staff role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page (OL-T19099)
    Given Setup test
    Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_FS     ${job_location}


Check Franchise Owner role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page (OL-T19100)
    Given Setup test
    Login into system with company    Franchise Owner    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_FO     ${job_location}


Check Edit Nothing role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19103)
    Given Setup test
    Login into system with company    Full User - Edit Nothing    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_EN     ${job_location}


Check Edit Nothing role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is OFF (OL-T19104)
    Given Setup test
    Login into system with company    Full User - Edit Nothing    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_EN     ${job_location}


Check Edit Everything role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19105)
    Given Setup test
    Login into system with company    Full User - Edit Everything    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_EE     ${job_location}


Check Edit Everything role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is OFF (OL-T19106)
    Given Setup test
    Login into system with company    Full User - Edit Everything    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_EE     ${job_location}



Check Hiring Manager role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19107)
    Given Setup test
    Login into system with company    Hiring Manager    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Hiring     ${job_location}


Check Hiring Manager role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is OFF (OL-T19108)
    Given Setup test
    Login into system with company    Hiring Manager    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Hiring     ${job_location}


Check Recruiter role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19109)
    Given Setup test
    Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Recuiter     ${job_location}


Check Recruiter role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is OFF (OL-T19110)
    Given Setup test
    Login into system with company    Recruiter    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Recuiter     ${job_location}


Check Reporting User role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19101)
    Given Setup test
    Login into system with company    Reporting User    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Reporting     ${job_location}


Check Reporting User role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is OFF (OL-T19102)
    Given Setup test
    Login into system with company    Reporting User    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_Reporting     ${job_location}


Check Company Admin role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise toggle is ON (OL-T19113)
    Given Setup test
    Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_CA_01     ${job_location}


Check Company Admin role has full access by default to view, edit and manage the Jobs that is assigned location on My Jobs page when Franchise Toggle is OFF (OL-T19114)
    Given Setup test
    Login into system with company    Company Admin    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_CA_01     ${job_location}


Check Company Admin role has full access by default to view, edit and manage the Jobs that isn't assigned location on My Jobs page when Franchise toggle is ON (OL-T19115)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=Company Admin
    Go to CEM page
    switch to user  ${user_fname}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_CA_02     ${job_location}
    # Delete user after check
    Go to CEM page
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}


Check Company Admin role has full access by default to view, edit and manage the Jobs that isn't assigned location on My Jobs page when Franchise toggle is OFF (OL-T19116)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User      role=Company Admin
    Go to CEM page
    switch to user  ${user_fname}
    Go to My Jobs page
    check user can view and actions on My Jobs page     Job_Test_Permission_CA_02     ${job_location}
    # Delete user after check
    Go to CEM page
    switch to user  ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User   ${user_fname}

*** Keywords ***
Create job for testing
    Given Setup test
    # Create for Franchise On company
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create a custom New Job and Publish     Job_Test_Permission_PA      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Supervisor      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_FS      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_FO      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_EN      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_EE      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Hiring      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Recuiter      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Reporting      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_CA_01      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_CA_02      ${job_family_name}      ${job_location}
    # Create for Franchise off Job On company
    Switch to Company v1  ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Create a custom New Job and Publish     Job_Test_Permission_PA      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Supervisor      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_FS      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_FO      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_EN      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_EE      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Hiring      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Recuiter      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_Reporting      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_CA_01      ${job_family_name}      ${job_location}
    Create a custom New Job and Publish     Job_Test_Permission_CA_02      ${job_family_name}      ${job_location}

check user can view and actions on My Jobs page
    [Arguments]     ${job_name}    ${location_name}
    Active a job    ${job_name}    ${location_name}
    Deactivate a job    ${job_name}    ${location_name}

cannot see the My Jobs page on the menu
    Click at    ${LEFT_MENU_BUTTON}
    check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      My Jobs
    capture page screenshot

user can not access My Jobs page when has perm is No access
    [Arguments]     ${role_name}
    Given Setup test
    when Login into system with company    ${role_name}    ${COMPANY_FRANCHISE_ON}
    cannot see the My Jobs page on the menu
    # Check navigate by URL
    ${is_correct_page} =    Run keyword and return status       Go to My Jobs page
    IF  '${is_correct_page}' == 'False'
        check element not display on screen      My Jobs
    END
    capture page screenshot
