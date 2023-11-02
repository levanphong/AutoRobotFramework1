*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation       Switch to Test Automation Applicant Flow company. All pre-conditions are setted up(Job search is ON, Job feed is selected, Requisition Based Permissions and Alerts at More tab is ON). Go to Client setup/Intergrations/Turn on ATS Intergation

*** Variables ***
${job_id1}              PAT033
${job_id2}              PAT035
${search_text}          PAT03

*** Test Cases ***
Verify assign Requisition Based Permissions to User is succefful (OL-T19399, OL-T19396)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    go to users, roles, permissions page
    #   To open Requisition Permissions dialog
    Open requisition base permissions dialog   CA Team
    Show all requisitions/assigned
    #   Check the checkbox
    Input into    ${REQ_BASED_PERM_SEARCH_TEXTBOX}    ${search_text}
    Check the checkbox      ${REQ_BASED_PERM_CHECK_BOX}  ${job_id1}
    Check the checkbox      ${REQ_BASED_PERM_CHECK_BOX}  ${job_id2}
    Save changes
    #   To make sure checked
    Input into    ${REQ_BASED_PERM_SEARCH_TEXTBOX}    ${search_text}
    The checkbox should be checked   ${REQ_BASED_PERM_CHECKED_BOX}  ${job_id1}
    The checkbox should be checked   ${REQ_BASED_PERM_CHECKED_BOX}  ${job_id2}
    #Set back to default
    Uncheck the checkbox      ${REQ_BASED_PERM_CHECKED_BOX}  ${job_id1}
    Uncheck the checkbox      ${REQ_BASED_PERM_CHECKED_BOX}  ${job_id2}
    Save changes


Check Permission of User: User can see candidates who have perm (OL-T19400, T19402)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    go to users, roles, permissions page
    ${user_name} =     Add a User      role=Company Admin
    Open requisition base permissions dialog   ${user_name}
    Show all requisitions/assigned
    #   Check the checkbox
    Input into    ${REQ_BASED_PERM_SEARCH_TEXTBOX}    ${search_text}
    Check the checkbox      ${REQ_BASED_PERM_CHECK_BOX}  ${job_id1}
    Save changes
    Input into    ${REQ_BASED_PERM_SEARCH_TEXTBOX}    ${search_text}
    The checkbox should be checked   ${REQ_BASED_PERM_CHECKED_BOX}  ${job_id1}
    Click at    ${REQ_BASED_PERM_X_BUTTON}
    switch to user  ${user_name}
    Check all candidates assined to a job   ${job_id1}


Check Permission of User: User can see candidates who haven't perm (OL-T19401)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${new_candidate_name} =    add a candidate      job_req_id=${job_id1}
    go to users, roles, permissions page
    ${user_name} =     Add a User      role=Company Admin
    switch to user  ${user_name}
    Go to CEM page
    check element not display on screen     ${CANDIDATE_LIST_ITEMS}     ${new_candidate_name}


Verify total jobs in Requisition Based Permissions is correctly (OL-T19398)
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    go to users, roles, permissions page
    Open requisition base permissions dialog   CA Team
    Show all requisitions/assigned
    ${total_amount_job} =   Get total amount of job on the table
    ${total_job_feed} =  Get total job from title
    should be equal as integers     ${total_amount_job}     ${total_job_feed}
    capture page screenshot

*** Keywords ***
Get total amount of job on the table
    ${amount_job} =    Get total job from title
    #   Get total jobs display on table
    Scroll to bottom of table    ${REQ_BASED_PERM_JOBS_TABLE}    ${LOADING_ICON_4}
    ${total_jobs} =   get element count   ${REQ_BASED_PERM_TOTAL_CHECK_BOX}
    should be equal as integers     ${amount_job}     ${total_jobs}
    capture page screenshot
    [Return]  ${total_jobs}

Get total job from title
    ${text} =   Get Text    ${REQ_BASED_PERM_TOTAL_JOB}
    ${amount_job} =   extract_numbers  ${text}
    [Return]    ${amount_job}[0]

Show all requisitions/assigned
    [Arguments]     ${show_all}=Show all requisitions     ${jobsearch_ATSJobs}=Job Search
    capture page screenshot
    Click at    ${REQ_BASED_PERM_ASSIGN_JOB_REQ_BUTTON}    1s
    Click at    ${REQ_BASED_PERM_SHOW_REQ_BUTTON}    1s
    IF      '${jobsearch_ATSJobs}' != 'Job Search'
        Click at    ${REQ_BASED_PERM_ATS_JOBS_MENU_BUTTON}   ${show_all}
    ELSE
        Click at    ${REQ_BASED_PERM_JOB_SEARCH_MENU_BUTTON}   ${show_all}
    END

Check all candidates assined to a job
    [Arguments]     ${job_id}
    #   Get number of candidates who assigned to the job_id
    Scroll to bottom of table    ${CANDIDATE_SCROLLBAR}    ${LOADING_ICON_3}
    # Load more item in page    ${job_id}    ${CEM_OPEN_CANDIDATE_CONV}
    ${total_candidate_locators} =   format string   ${CANDIDATE_LIST_ITEMS}     ${job_id}
    ${total_candidates} =   get element count   ${total_candidate_locators}
    ${number_candidates} =  Get total candidates
    #   Compare if both equals, which means all of candidates who showed in Candidates List are all assigned to the job_id1
    should be equal as integers     ${total_candidates}     ${number_candidates}
    capture page screenshot

Get total candidates
    #   Get total of candidates who showed in the Candidates List
    ${title_get_text} =   get text      ${CANDIDATE_LIST_HEADER_TITLE}
    ${number_candidates} =    extract_numbers    ${title_get_text}
    [Return]  ${number_candidates}[0]

Save changes
    Click at    ${REQ_BASED_PERM_SAVE_BUTTON}
    Check Element Display On Screen     ${USER_CHANGES_SAVE_TOASTED_MESSAGE}
    Check element not display on screen     ${USER_CHANGES_SAVE_TOASTED_MESSAGE}
