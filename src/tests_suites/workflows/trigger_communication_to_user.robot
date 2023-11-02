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
...                 send communication choise age Between 18 and 25

*** Test Cases ***
Legacy Multi-location Job Workflow - Verify communication trigger in case a specific user is added to Hiring Team - Audience is Hiring Team Roles, Audience is User Roles (OL-T14160, OL-T14167, OL-T14174, OL-T14181)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${basic_job_for_workflow}       ${age_send_communication}
    Verify user received send communication email       ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}


Multi-location Job Workflow - Verify communication trigger in case a specific user is added to Hiring Team - Audience is Hiring Team Roles, Audience is User Roles (OL-T14188, OL-T14195, OL-T14202, OL-T14209, OL-T14569)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${multi_job_for_workflow}       ${age_send_communication}
    Verify user received send communication email       ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}
#   Verify communication trigger is NOT sent to user who does not match audience Hiring Team (OL-T14569)
    ${is_received_mail} =       Run Keyword and Return Status       Verify user has received the email
    ...     ${candidate_full_name}      Hi ${RP_TEAM}, auto_text_send_communication     COMMUNICATION
    Should be Equal as Strings      ${is_received_mail}     False


Standard Job Workflow - Verify communication trigger in case a specific user is added to Hiring Team - Audience is Hiring Team Roles, Audience is User Roles (OL-T14230, OL-T14237, OL-T14230, OL-T14237)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${standard_job_for_workflow}    ${age_send_communication}
    Verify user received send communication email       ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}

*** Keywords ***
Verify user received send communication email
    [Arguments]    ${candidate_full_name}       ${user1}      ${user2}
#   Verify communication trigger in case a specific user is added to Hiring Team - Audience is Hiring Team Roles, Audience is User Roles
    Verify user has received the email      ${candidate_full_name}      Hi ${user1}, auto_text_send_communication     COMMUNICATION
#   Verify communication trigger in case a user role is added to Hiring Team - Audience is Hiring Team, Audience is User Roles
    Verify user has received the email      ${candidate_full_name}      Hi ${user2}, auto_text_send_communication     COMMUNICATION
