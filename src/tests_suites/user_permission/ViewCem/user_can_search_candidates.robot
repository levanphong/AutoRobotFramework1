*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/all_candidates_page.robot
Resource            ../../../pages/base_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Documentation       Impl for bug    https://paradoxai.atlassian.net/browse/OL-56858

*** Variables ***
${test_location_name}       ${LOCATION_NAME_2}

*** Test Cases ***
Check Company Admins can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Company Admin


Check Franchise Owners can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Franchise Owner


Check Franchise Staff can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Franchise Staff


Check Full User - Edit Everything can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Full User - Edit Everything


Check Full User - Edit Nothing can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Full User - Edit Nothing


Check Recruiter can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Recruiter


Check Supervisor can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Supervisor


Check Hiring Manager can search candidates
    [Tags]    advantage    aramark    birddoghr    darden    dev    dev2    fedexstg    mchire    olivia    pepsi    stg    stg_mchire    test    unilever
    user can search candidates      Hiring Manager

*** Keywords ***
user can search candidates
    [Arguments]    ${userRole}
    Given Setup test
    when Login into system with company   ${userRole}   ${COMPANY_FRANCHISE_ON}
    Go to CEM page
    ${candidate_name}=    Add a Candidate   None    ${test_location_name}
    Search and click candidate on CEM      ${candidate_name}
