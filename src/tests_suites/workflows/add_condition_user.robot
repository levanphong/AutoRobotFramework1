*** Settings ***
Resource            ../../pages/workflows_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Force Tags          advantage    aramark    birddoghr    darden    dev    dev2    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    test

Documentation       Run file data test: src/data_tests/job_internal/job_enhancement/workflow.robot
...                 Go to Alert Managermnet page -> workflow tab -> Add CA User
...                 Setup outcome change status in job must mapping with workflow tasks
...                 send condidation choise age Uder 18

*** Test Cases ***
Legacy Multi-location Job Workflow - Verify conditional trigger in case a specific user is added to Hiring Team - Audience is User Roles (OL-T14162, OL-T14176)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${basic_job_for_workflow}       ${age_send_condition}       ${candidate_fist_name}
    Verify user received send condition email       ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}


Multi-location Job Workflow - Verify conditional trigger in case a specific user is added to Hiring Team - Audience is User Roles, Audience is Hiring Team Roles (OL-T14190, OL-T14197, OL-T14211, OL-T14204)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${multi_job_for_workflow}       ${age_send_condition}       ${candidate_fist_name}
    Verify user received send condition email       ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}


Standard Job Workflow - Verify conditional trigger in case a specific user is added to Hiring Team - Audience is User Roles, Audience is Hiring Team Roles (OL-T14218, OL-T14225, OL-T14232, OL-T14239)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${standard_job_for_workflow}    ${age_send_condition}       ${candidate_fist_name}
    Verify user received send condition email       ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}

*** Keywords ***
Verify user received send condition email
    [Arguments]    ${candidate_full_name}       ${user1}      ${user2}
#   Verify conditional trigger in case a specific user is added to Hiring Team - Audience is User Roles, Audience is Hiring Team Roles
    Verify user has received the email      ${candidate_full_name}      Hi ${user1}, auto_text_condition_email    CONDITION
#   Verify conditional trigger in case a user role is added to Hiring Team - Audience is Hiring Team, Audience is User Roles
    Verify user has received the email      ${candidate_full_name}      Hi ${user2}, auto_text_condition_email    CONDITION
