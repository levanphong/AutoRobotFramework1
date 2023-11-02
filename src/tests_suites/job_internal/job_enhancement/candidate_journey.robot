*** Settings ***
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/offers_page.robot
Resource            ../../../pages/candidate_journeys_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/conversation_builder_page.robot
Resource            ../../../data_tests/job_internal/job_enhancement/candidate_journey.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${cj_only_view}                             CJ_rec_only_view_offer
${cj_no_permission}                         CJ_rec_no_per_view_offer
${offer_for_job}                            offer for job

*** Test Cases ***
Candidate journey permission_Verify All roles of Hiring Team Roles will be default selected (OL-T14143)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
    ${locator_recruiter} =    format string    ${SETTING_USER_PERMISSION_STAGE}    Recruiter
    ${locator_hiring_manager} =    format string    ${SETTING_USER_PERMISSION_STAGE}    Hiring Manager
    Click edit permitssion      ${cj_name}      Offer
    Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}      Manage
    # Verify All roles of Hiring Team Roles will be default selected at Offer stage
    Check element display on screen    ${locator_recruiter}
    Check element display on screen    ${locator_hiring_manager}
    # Verify All roles of Hiring Team Roles will be default selected at Rating stage
    Click edit permitssion      ${cj_name}      Rating
    Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}      View Only
    Check element display on screen    ${locator_recruiter}
    Check element display on screen    ${locator_hiring_manager}
    Delete a Journey    ${cj_name}


Candidate journey permission_Verify user can remove any hiring team of Hiring Team Roles (OL-T14146, OL-T14145, OL-T14144)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
    Journey remove user on tab of stage       Manage      ${cj_name}      Recruiter     Offer
    Journey remove user on tab of stage       View Only      ${cj_name}      Recruiter     Rating
    Journey add user on tab of of stage       Manage      ${cj_name}      Recruiter     Offer
    Journey add user on tab of of stage       View Only      ${cj_name}      Recruiter     Rating
    Delete a Journey    ${cj_name}


Verify the candate journey UI at Legacy Multi-Location Job (OL-T14148)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	${job_name}=    generate random name    auto_job
	Create new job with type     ${job_family_name}     ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    Click at    ${CANDIDATE_JOURNEY_TAB}
    select candidate journey job    Default Candidate Journey
    Verify Candidate Journey is shown correctly
    Delete a Job    ${job_name}     ${job_family_name}


Verify the candate journey UI at Multi-Location Job (OL-T14149)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	${job_name}=    generate random name    auto_job
	Create new job with type     ${job_family_name}     ${TYPE_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    Click at    ${CANDIDATE_JOURNEY_TAB}
    select candidate journey job    Default Candidate Journey
    Verify Candidate Journey is shown correctly
    Delete a Job    ${job_name}     ${job_family_name}


Verify the candate journey UI at Standard Job (OL-T14150)
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	Go to Jobs page
	${job_name}=    generate random name    auto_job
	Create new job with type     ${job_family_name}     ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Click at    ${CANDIDATE_JOURNEY_TAB}
    select candidate journey job    Default Candidate Journey
    Verify Candidate Journey is shown correctly
    Delete a Job    ${job_name}     ${job_family_name}


Verify Hiring Team Roles don't have permission to manage the stages if it wasn't selected in Candidate journey permission (OL-T14151)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
	Journey remove user on tab of stage       Manage      ${cj_name}      Recruiter     Offer
	Publish a Journey   ${cj_name}
	${job_name_a} =    Create new job without Job template     Multi-Location     ${cj_only_view}    Company Admin       ${offer_for_job}     Recruiter
    wait with large time
    Active a job    ${job_name_a}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name_a}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}     Send Offer
    wait with medium time
    Deactivate a job    ${job_name_a}
    Delete a Job    ${job_name_a}     ${job_family_name}
    Delete a Journey    ${cj_name}


Verify Candidate journey permission when user was added to manage candidate journey permisssion for Legacy Multi-Location Job (OL-T14152)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
    ${job_name} =    Create new job without Job template     Basic Multi-Location     ${cj_only_view}    Company Admin       ${offer_for_job}     Recruiter
    wait with large time
    Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name}
    Check element display on screen      ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS}     Send Offer
    wait with medium time
    Deactivate a job    ${job_name}
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a Journey    ${cj_name}


Candidate journey permission when user/user role was added for Hiring Team Roles of Multi-Location Job (OL-T14153)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
    ${job_name} =    Create new job without Job template     Standard     ${cj_only_view}    Company Admin       ${offer_for_job}     Recruiter
    wait with large time
    Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name}
    Check element display on screen      ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS}     Send Offer
    wait with medium time
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a Journey    ${cj_name}


Candidate journey permission when user/user role was added for Hiring Team Roles of Standard job (OL-T14154)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
    ${job_name} =    Create new job without Job template     Standard     ${cj_name}    Company Admin       ${offer_for_job}     Recruiter
    wait with large time
    Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name_a}
    Check element display on screen      ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS}     Send Offer
    wait with medium time
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a Journey    ${cj_name}


Verify Candidate journey permission when User/role is added into Hiring Team Roles for both Legacy Multi-Location Job and Multi-Location Job (OL-T14155)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
    Journey remove user on tab of stage       Manage      ${cj_name}      Recruiter     Offer
    Journey add user on tab of of stage       View Only      ${cj_name}      Recruiter      Offer
    ${job_name_a} =    Create new job without Job template     Basic Multi-Location     ${cj_name}    Company Admin       ${offer_for_job}
    wait with large time
    ${job_name_b} =    Create new job without Job template     Multi-Location     ${cj_name}    Company Admin       ${offer_for_job}       Recruiter
    wait with large time
    Active a job    ${job_name_a}    ${test_location_name}
    Active a job    ${job_name_b}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name_a}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name_b}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name_a}
    Check element display on screen      ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS}     Send Offer
    Click on status journey on cem      Offer   ${candidate_name_b}
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}     Send Offer
    wait with medium time
    Delete a Job    ${job_name_a}     ${job_family_name}
    Delete a Job    ${job_name_b}     ${job_family_name}
    Delete a Journey    ${cj_name}


Verify Candidate journey permission when User/role is added into Hiring Team Roles for both Multi-Location Job and Standard job (OL-T14156)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${cj_name}=         Create Candidate journey has offer stage
	Journey add user on tab of of stage       Manage      ${cj_name}      Hiring Manager        Offer
	Journey remove user on tab of stage       Manage      ${cj_name}      Recruiter     Offer
	Journey add user on tab of of stage       View Only      ${cj_name}      Recruiter
	Publish a Journey   ${cj_name}
	${job_name_a} =    Create new job without Job template     Multi-Location     ${cj_name}    Company Admin       ${offer_for_job}       Recruiter
    wait with large time
    ${job_name_b} =    Create new job without Job template     Standard     ${cj_name}    Company Admin       ${offer_for_job}     Recruiter
    wait with large time
    Active a job    ${job_name_a}    ${test_location_name}
    Active a job    ${job_name_b}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name_a} =    Candidate finish Job Internal / Workday conversation    ${job_name_a}
    Go to    ${url}
    ${candidate_name_b} =    Candidate finish Job Internal / Workday conversation    ${job_name_b}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name_a}
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}     Send Offer
    Click on status journey on cem      Offer   ${candidate_name_b}
    Check element not display on screen    ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}     Send Offer
    wait with medium time
    Delete a Job    ${job_name_a}     ${job_family_name}
    Delete a Job    ${job_name_b}     ${job_family_name}
    Delete a Journey    ${cj_name}


Verify the hiring role will be prioritize permission in case xxx role added for Hiring team roles and user role at Candidate journey permission (OL-T14157)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${cj_name}=         Create Candidate journey has offer stage
	Journey remove user on tab of stage       Manage      ${cj_name}      Recruiter     Offer
	Journey add user on tab of of stage      View Only       ${cj_name}      Recruiter      Offer
	Publish a Journey   ${cj_name}
	${job_name} =    Create new job without Job template     Multi-Location     ${cj_name}    Company Admin       ${offer_for_job}      Recruiter
    wait with large time
    Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    CA Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name}
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}     Send Offer
    wait with medium time
    Deactivate a job    ${job_name}
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a Journey    ${cj_name}


Verify Candidate journey permission in special case (OL-T14158)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
	${cj_name}=         Create Candidate journey has offer stage
	Journey remove user on tab of stage       Manage      ${cj_name}      Recruiter     Offer
    Journey add user on tab of of stage       View Only      ${cj_name}      Recruiter     Offer
	${job_name} =    Create new job without Job template     Multi-Location     ${cj_only_view}    Full User       ${offer_for_job}     Recruiter
	wait with medium time
	Add Hiring Team for job type Standard/Muti-Location    Full User    Hiring Manager
	Active a job    ${job_name}    ${test_location_name}
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_create_job}    ${landing_site_create_job}
    Go to    ${url}
    ${candidate_name} =    Candidate finish Job Internal / Workday conversation    ${job_name}
    Go to CEM page
    Switch to user    EE Team
    # Verify candidate has status correclty with outcome action
    Click on status journey on cem      Offer   ${candidate_name}
    Check element display on screen      ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}     Send Offer
    wait with medium time
    Deactivate a job    ${job_name}
    Delete a Job    ${job_name}     ${job_family_name}
	Delete a Journey    ${cj_name}


Verify Candidate journey show interview detail correctly when CJ setting two interview stage (OL-57701)
    # Implement to cover bug https://paradoxai.atlassian.net/browse/OL-57701
    Given Setup test
	when Login into system with company		${PARADOX_ADMIN}      	${COMPANY_FRANCHISE_ON}
    ${job_name} =    Create new job with CJ setting two interview stage     Coffee family job
    Go to Jobs page
    search job name     ${job_name}      ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Verify Candidate Journey is shown interview detail with correctly number interview  2
    Delete a Job    ${job_name}      ${job_family_name}


*** Keywords ***
Verify Candidate Journey is shown correctly
    Check element display on screen      Capture
    Check element display on screen      Scheduling
    Check element display on screen      Select Interview Type
    Check element display on screen      Interview Details
    Check element display on screen      ${CANDIDATE_JOURNEY_FORM}

Click on status journey on cem
    [Arguments]     ${status_name}   ${candidate_name}
    Click at    ${CEM_CANDIDATE_NAME_TEXT}    ${candidate_name}
    Click at    ${CANDIDATE_JOURNEY_STATUS}    Capture Complete
    Click at    ${CEM_CANDIDATE_JOURNEY_ITEM_STATUS}     ${status_name}      1s

Click edit permitssion
    [Arguments]     ${cj_name}  ${stage_name}
    Click a Journey    ${cj_name}
    Click at    ${STAGE_NAME_IN_JOURNEY}    ${stage_name}
    wait for page load successfully v1
    Click at    ${ICON_SETTING_STAGE_IN_JOURNEY}
    Click at    Edit Permissions

Journey remove user on tab of stage
    [Arguments]    ${tab_name}   ${cj_name}    ${user}      ${stage_name}
    Click edit permitssion      ${cj_name}      ${stage_name}
    Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}      ${tab_name}
    ${locator_user} =    format string    ${SETTING_USER_PERMISSION_STAGE}    ${user}
    ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${locator_user}
    IF    '${is_visible}' == 'True'
        Click at   ${ECLIPSE_ICON_MENU_IN_STAGE}    ${user}
        Click at        Remove Role
        Click at        Yes
    END
    Click at    ${PERMISSION_PROVER_POPUP_SAVE_BUTTON}

Journey add user on tab of of stage
    [Arguments]   ${tab_name}   ${cj_name}    ${user}       ${stage_name}
    Click edit permitssion      ${cj_name}  ${stage_name}
    Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}     ${tab_name}
    ${locator_user} =    format string    ${SETTING_USER_PERMISSION_STAGE}    ${user}
    ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${locator_user}
    IF    '${is_visible}' == 'False'
        Click at    View Only
        Click at    ${ICON_PLUS_ROUND_IN_STAGE}
        Click at    ${USER_HIRING_TEAM_ROLES_IN_STAGE}      ${user}
    END
    Click at    ${PERMISSION_PROVER_APPLY_BUTTON}
    Click at    ${PERMISSION_PROVER_POPUP_SAVE_BUTTON}

Verify Candidate Journey is shown interview detail with correctly number interview
    [Arguments]   ${limit}
    Check element display on screen      Capture
    Check element display on screen      Scheduling
    Check element display on screen      Select Interview Type
    Check element display on screen      Interview Details
    Page should contain element     ${CANDIDATE_JOURNEY_FORM}      limit=${limit}
    capture page screenshot
