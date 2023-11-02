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
...                 Note: send rating choise age More than 25

*** Test Cases ***
Legacy Multi-location Job Workflow - Verify rating trigger in case a specific user is added to Hiring Team - Audience is User Roles, Audience is Hiring Team Roles (OL-T14161, OL-T14168, OL-T14175, OL-T14182)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${basic_job_for_workflow}       ${age_send_rating}
    Verify user received send rating email      ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}


Multi-location Job Workflow - Verify rating trigger in case a specific user is added to Hiring Team - Audience is User Roles, Audience is Hiring Team Roles (OL-T14189, OL-T14196, OL-T14203, OL-T14210)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${multi_job_for_workflow}       ${age_send_rating}
    Verify user received send rating email      ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}


Standard Job Workflow - Verify rating trigger in case a specific user is added to Hiring Team - Audience is User Roles, Audience is Hiring Team Roles (OL-T14217, OL-T14321, OL-T14224, OL-T14238)
    Go To URL       ${url_landing_site}
    ${candidate_full_name} =    Candidate finish Job Internal       ${standard_job_for_workflow}    ${age_send_rating}
    Verify user received send rating email      ${candidate_full_name}      ${CA_USER}      ${HM_TEAM}

*** Keywords ***
Verify user received send rating email
    [Arguments]    ${candidate_full_name}       ${user1}      ${user2}
#   Verify rating trigger in case a specific user is added to Hiring Team - Audience is Hiring Team Roles, Audience is User Roles
    Verify user has received the email      ${candidate_full_name}      Hi ${user1}. Please rate your experience.     RATING_REQUEST
#   Verify rating trigger in case in case a user role is added to Hiring Team - Audience is Hiring Team, Audience is User Roles
    Verify user has received the email      ${candidate_full_name}      Hi ${user2}. Please rate your experience.     RATING_REQUEST
