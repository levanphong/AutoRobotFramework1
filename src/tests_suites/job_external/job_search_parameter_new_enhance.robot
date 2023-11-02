*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    uniliver   test

Documentation       run data test: src/data_tests/job_external/job_search_parameter.robot

*** Variables ***
${job_site_name}        JobSearchParameterLandingSite
${job_widget_name}      JobSearchParameterWidget

*** Test Cases ***
# ==== SECTION: APPLICANT FLOW ====
Check when selecting Job location at Search parameter and candidate give location (OL-T28258 ,OL-T28259)
    Initial and go to url  COMPANY_APPLICANT_FLOW   ${SHOW_JOB_SEARCH_MESSAGE}
    #   Candidate inputs message to show job
    Candidate input to landing site     ${ANY_JOB}
    Verify last message content should be  ${REPROMPT_LOCATION_MESSAGE_1}
    Candidate input to landing site     ${ANY_WHERE}
    #   Check message
    Verify AI latest message using regexp   ${SHOW_JOB_SEARCH_MESSAGE}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_TABLE}   wait_time=5s


Search result when selecting "Employment Type" at "Search parameter" (OL-T28267)
    Initial and go to url  COMPANY_APPLICANT_FLOW   ${SHOW_JOB_SEARCH_MESSAGE}
    #   Candidate inputs message to show job
    Search job and check job display    ${FULL_TIME_JOB} ${ANY_WHERE}     ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${LOCATION_MAPPING_TITLE_020}


Search result when selecting "Employment Status" at "Search parameter" (OL-T28269)
    Initial and go to url  COMPANY_APPLICANT_FLOW   ${SHOW_JOB_SEARCH_MESSAGE}
    #   Candidate inputs message to show job
    Search job and check job display    ${SALARIED_JOB} ${ANY_WHERE}     ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${LOCATION_MAPPING_TITLE_020}


Ignore Job description when select "Job description" at Search parameter (OL-T28271)
    Initial and go to url  COMPANY_APPLICANT_FLOW   ${SHOW_JOB_SEARCH_MESSAGE}
    #   Candidate inputs message to show job
    Search job and check job display    ${DESCRIPTION_FOR_MP020} Job ${ANY_WHERE}     ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${LOCATION_MAPPING_TITLE_020}
    Verify last message content should be    ${DESCRIPTION_FOR_MP020}


Search result when selecting "Remote jobs" at "Search parameter" and turning ON "Include remote job in location-based search" toggle and searching for job category (OL-T28263)
    Initial and go to url  COMPANY_APPLICANT_FLOW   ${SHOW_JOB_SEARCH_MESSAGE}
    #   Candidate inputs message to show job
    Search job and check job display    ${REMOTE_JOB} ${ANY_WHERE}     ${LOOK_AT_POSITION}
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element display on screen  ${CONVERSATION_LIST_VIEW_ITEM}    ${LOCATION_MAPPING_TITLE_020}

# ==== SECTION: EXTERNAL JOB ====
Check when dont select 'Job location' at Search parameter (OL-T28260)
    Initial and go to url  COMPANY_EXTERNAL_JOB   ${WELCOME_CANDIDATE_MESSAGE}
    #   Candidate inputs message to show job
    Search job and check job display    ${ANY_JOB_ANY_WHERE}     ${SHOW_JOB_SEARCH_MESSAGE}


Search with Job description when dont select 'Job description' at Search parameter (OL-T28270)
    Initial and go to url  COMPANY_EXTERNAL_JOB   ${WELCOME_CANDIDATE_MESSAGE}
    #   Candidate inputs Member job(there is no job haiving title or catogory "Member")
    Candidate input to landing site     ${DESCRIPTION_FOR_MP020} Job ${ANY_WHERE}
    Verify AI latest message using regexp   ${NO_POSITION_OPEN}
    Verify last message content should be    ${DESCRIPTION_FOR_MP020}


Search result when don't select "Employment Type" at Search parameter (OL-T28266)
    Initial and go to url  COMPANY_EXTERNAL_JOB   ${WELCOME_CANDIDATE_MESSAGE}
    Search job and check job display    ${FULL_TIME_JOB} ${ANY_WHERE}     ${SHOW_JOB_SEARCH_MESSAGE}
    #   Still show job, but not show Full Time Job
    Check element not display on screen  ${CONVERSATION_LIST_VIEW_ITEM}    ${LOCATION_MAPPING_TITLE_020}


Search result when don't select "Employment Status" at Search parameter (OL-T28268)
    Initial and go to url  COMPANY_EXTERNAL_JOB   ${WELCOME_CANDIDATE_MESSAGE}
    Search job and check job display    ${SALARIED_JOB} ${ANY_WHERE}     ${SHOW_JOB_SEARCH_MESSAGE}
    #   Still show job, but not show Full Time Job
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element not display on screen  ${CONVERSATION_LIST_VIEW_ITEM}    ${LOCATION_MAPPING_TITLE_020}


Search result when don't select "Remote job" at Search parameter (OL-T28261)
    Initial and go to url  COMPANY_EXTERNAL_JOB   ${WELCOME_CANDIDATE_MESSAGE}
    Search job and check job display    ${ANY_JOB_ANY_WHERE}     ${SHOW_JOB_SEARCH_MESSAGE}
    #   Still show job, but not show Remote Job
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element not display on screen  ${CONVERSATION_LIST_VIEW_ITEM}    ${LOCATION_MAPPING_TITLE_020}
    Click at    ${RECOMMENDED_JOB_X_BUTTON}
    #   But if search "Remote Job", still show job
    Candidate input to landing site     ${NEW}
    Candidate input to landing site     ${REMOTE_JOB} ${ANY_WHERE}
    Check element display on screen  ${CONVERSATION_LIST_VIEW_ITEM}  ${LOCATION_MAPPING_TITLE_020}

# ==== SECTION: COMPANY_LOCATION_MAPPING_OFF ====
Search result when selecting "Remote jobs" at "Search parameter" and turning OFF "Include remote job in location-based search" toggle and searching for remote jobs (OL-T28265)
    Initial and go to url  COMPANY_LOCATION_MAPPING_OFF   ${SHOW_JOB_SEARCH_MESSAGE}
    Search job and check job display    ${ANY_JOB_ANY_WHERE}     ${SHOW_JOB_SEARCH_MESSAGE}
    #   Still show job, but not show Remote Job
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element not display on screen  ${CONVERSATION_LIST_VIEW_ITEM}    ${LOCATION_MAPPING_TITLE_020}
    Click at    ${RECOMMENDED_JOB_X_BUTTON}
    #   But if search "Remote Job", still show job
    Candidate input to landing site     ${REMOTE_JOB}
    Check element display on screen  ${CONVERSATION_LIST_VIEW_ITEM}  ${LOCATION_MAPPING_TITLE_020}


Search result when selecting 'Remote jobs' at 'Search parameter' and turning OFF 'Include remote job in location-based search' toggle and searching for remote jobs, Widget site (OL-T28264)
    Given Setup test
    ${site_url} =  Get widget conversation link  ${job_widget_name}
    Go to widget site  ${site_url}
    ${welcome_message} =   Get first message of Olivia in Shadow Root
    Should match regexp  ${welcome_message}  ${SHOW_JOB_SEARCH_MESSAGE}
    Input text for widget site     ${REMOTE_JOB} ${ANY_WHERE}
    Verify text contain   ${SHADOW_DOM_SEARCH_RESULT_JOB_TITLE}  ${LOCATION_MAPPING_TITLE_020}

*** Keywords ***
Search job and check job display
    [Arguments]  ${search_text}  ${show_jobs_message}
    Candidate input to landing site     ${search_text}
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${show_jobs_message}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_TABLE}   wait_time=5s

Initial and go to url
    [Arguments]   ${company}  ${message}
    Given Setup test
    ${site_url} =  Get landing site url by string concatenation  ${company}   ${job_site_name}
    Go to  ${site_url}
    #   Wait AI send message
    Wait for Olivia reply
    ${welcome_message} =  Get latest message of Olivia in Landing site
    IF   '${company}' == 'COMPANY_EXTERNAL_JOB'
        Should match regexp  ${welcome_message}  ${WELCOME_CANDIDATE_MESSAGE}
    ELSE
        Should match regexp  ${welcome_message}  ${SHOW_JOB_SEARCH_MESSAGE}
        Check element display on screen     ${CONVERSATION_LIST_VIEW_TABLE}   wait_time=5s
    END
