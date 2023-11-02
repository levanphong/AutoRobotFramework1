*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_volume_optimizer_page.robot
Variables           ../../constants/MyJobConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags          dev    fedex    lts_stg    olivia    regression    stg    test   lowes_stg    lowes

#Test Automation Applicant Flow:
# Navigate to Client set up > Hire > Turn on ATS Job Feed Manager toggle,
# Navigate to Client set up > Hire > Turn on Map Locations in My Jobs with Location ID from feed toggle
# Navigate to Client set up > Hire > Turn on Candidate Volume Optimizer toggle
# Navigate to CLient set up > Job search > Turn on Candidate Type (Internal/External) toogle
# Job name: Automation Tester 001, Location mapping MP009, Location mapping MP001, Location mapping MP007
# Automation Tester 024, Automation Tester 044, Automation Tester 057, Automation Tester 045, Automation Tester 048, Automation Tester 058

# Test Automation Location Mapping Off
# Navigate to CLient set up > Job search > Turn on Candidate Type (Internal/External) toogle
# JOb name : Automation Tester 001, Location mapping MP003 (status: off), Automation Tester 021

*** Variables ***
${location_id}      MP_Location05_FAKE

*** Test Cases ***
Client job - Check My jobs page is changed UI (OL-T25410, OL-T25411, OL-T25412, OL-T25413, OL-T25414, OL-T25415,OL-T25418, OL-T25420, OL-T25424, OL-T25425, OL-T25421, OL-T25422, OL-T25423)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    #Search with Job Name
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_001}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${AUTOMATION_TESTER_TITLE_001}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${LOCATION_ADDRESS_HANNAFORD_DRIVE}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${JOB_POSTING_TYPE_INTERNAL}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${AUTOMATION_TESTER_REQ_ID_001}
    capture page screenshot
    #Search with Requisition Id
    Input into      ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${AUTOMATION_TESTER_REQ_ID_001}
    check span display      ${AUTOMATION_TESTER_REQ_ID_001}
    capture page screenshot
    #Search with Job Posting Type
    Input into      ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${JOB_POSTING_TYPE_INTERNAL}
    Check element not display on screen     ${JOB_POSTING_TYPE_EXTERNAL}
    clear element text      ${MY_JOB_SEARCH_JOB_TEXTBOX}
    capture page screenshot
    #Search with Location name and address: T25418, T25422
    Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    Input into      ${MY_JOB_ALL_LOCATION_SEARCH_FOR_LOCATION_TEXTBOX}      ${LOCATION_STATE_VERMON}
    Page Should Contain Element     ${MY_JOB_LIST_LOCATION_BY_NAME}     22
    capture page screenshot
    #T25425: Search by location ID
    Check result after search location      ${LOCATION_MP_10}    ${LOCATION_MAPPING_LOCATION_NAME_10}
    #T25421: Search by Location city
    Check result after search location      ${LOCATION_CITY_NORTH_CAROLINA}    ${LOCATION_MAPPING_LOCATION_NAME_11}
    #T25423: Search by Location State
    Check result after search location      ${LOCATION_STATE_VERMON}       ${LOCATION_STATE_VERMON}


Client job - Check My Jobs List in case the Job ON is selected on Filtering (OL-T25433, OL-T25434, OL-T25435, OL-T25436)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to My Jobs page
    Select job filtering    ON
    Check element not display on screen     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}
    capture page screenshot
    Check element display on screen     ${MY_JOB_JOB_FILTERING_IS_SELECTED_ICON}
    Unslect job filtering   Status is ON
    Select job filtering    OFF
    Check element not display on screen     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}
    capture page screenshot
    Unslect job filtering   Status is OFF


Client job - Check Turning Job ON without CVO (OL-T25437, OL-T25438)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Check status job to turn off     ${LOCATION_MAPPING_TITLE_001}
    Turn on a Job       ${LOCATION_MAPPING_TITLE_001}
    Turn off a Job      ${LOCATION_MAPPING_TITLE_001}


Client Job - Check candidate applied via Copy job posting link (OL-T25458, OL-T25453)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${url_job_link}=     Search job and get internal job link        ${LOCATION_MAPPING_TITLE_007}
    Go to   ${url_job_link}


Client job - Check Copy Apply Link doesn't show on My Jobs in case Job OFF (OL-T25457, OL-T25455)
    Search job and click at eclipse icon   ${LOCATION_MAPPING_TITLE_002}
    Check element not display on screen     ${MY_JOB_DETAILS_COPY_JOB_APPLY_LINK}
    capture page screenshot
    Click at    ${MY_JOB_DETAILS_VIEW_JOB_DESCRIPTION}
    Check element display on screen     ${MY_JOB_DETAILS_VIEW_JOB_DESCRIPTION_MODAL}
    capture page screenshot


Client job - Check View Job Description on My Jobs in case Job ON (OL-T25451)
    Search job and click at eclipse icon  ${AUTOMATION_TESTER_TITLE_001}
    Click at    ${MY_JOB_DETAILS_VIEW_JOB_DESCRIPTION}
    Check element display on screen     ${MY_JOB_DETAILS_VIEW_JOB_DESCRIPTION_MODAL}
    capture page screenshot


Client job - Check search for locations by Area Name in case the Map Locations in My Jobs with Location ID from feed toggle is OFF (OL-T25426, OL-T25427, OL-T25428. OL-T25429, OL-T25430, OL-T25431)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_001}
    #Search with Job Name:
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${AUTOMATION_TESTER_TITLE_001}
    ${text_address}=    Get text and format text    ${MY_JOB_DETAIL_JOB_ITEM}       ${LOCATION_ADDRESS_HANNAFORD_DR}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${text_address}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${JOB_POSTING_TYPE_INTERNAL}
    Check element display on screen     ${MY_JOB_DETAIL_JOB_ITEM}       ${AUTOMATION_TESTER_REQ_ID_001}
    capture page screenshot
    #Search with area name: T25426
    Search job by location type      ${AREA_NAME_SOUTH_BURLINGTON}
    #Search by Location city: T25427
    Search job by location type     ${LOCATION_CITY_NEW_YORK}
    #Search by Location address: T25428
    Search job by location type     ${LOCATION_NAME_US}
    #Search by Location state: T25429
    Search job by location type     ${LOCATION_STATE_NORWICH}
    #Search by Location Name : T25430, T25432
    Search job by location type     ${LOCATION_NAME_US}
    Go to My Jobs page
    Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    Click at    ${MY_JOB_ALL_LOCATION_ITEM}     ${LOCATION_NAME_US}
    wait for page load successfully
    Hover at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN_OPTION}     ${LOCATION_NAME_US}
    check element display on screen     ${MY_JOB_ALL_LOCATION_JOB_SELECTED_PLACEHOLDER}        United States
    capture page screenshot


Client job - Check CVO info is updated when user turn Job ON with CVO (OL-T25439,OL-T25440, OL-T25441, OL-T25442, OL-T25444)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Check status job to turn off     ${AUTOMATION_TESTER_TITLE_044}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_044}
    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}  ${AUTOMATION_TESTER_TITLE_044}
    Click at    ${MY_JOB_DETAIL_CANCEL_BUTTON}
    Check toggle is Off     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${AUTOMATION_TESTER_TITLE_044}
    capture page screenshot
    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${AUTOMATION_TESTER_TITLE_044}
    Check span display      Hiring Goal
    Check span display      Set the number of candidates you need.
    Check span display      Job will close after
    Verify text contain     ${MY_JOB_DETAIL_CAPTURE_COMPLETE_TEXT}      candidates reach Capture Complete.
    capture page screenshot
    Clear element text with keys      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Post Job
    Check span display      ${MY_JOB_CVO_REQUIRE_MESSAGE}
    capture page screenshot
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      1001
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Post Job
    Check span display      ${MY_JOB_CVO_BETWEEN_MESSAGE}
    capture page screenshot
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      2
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Post Job
    Verify message after turn on/off job    ${AUTOMATION_TESTER_TITLE_044}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_044}
    Turn off    ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}   ${AUTOMATION_TESTER_TITLE_044}
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Close Job
    Verify message after turn on/off job    ${AUTOMATION_TESTER_TITLE_044}


Client job - Check Turning Job OFF with CVO (OL-T25443)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    Search job by location and job name     ${LOCATION_MAPPING_TITLE_003}
#    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}
    Click at    ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${LOCATION_MAPPING_TITLE_003}
    Check element display on screen     ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Post Job
    Check element display on screen     ${MY_JOB_DETAIL_CANCEL_BUTTON}
    capture page screenshot
    Click at    ${MY_JOB_DETAIL_CANCEL_BUTTON}
    Check toggle is Off     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${LOCATION_MAPPING_TITLE_003}
    capture page screenshot


Client job - Check My jobs page in case Job has target to a CVO with threshold number = Unlimited (OL-T25448)
    #Todo: The flows changed , Configue button to choose candidates number is removed from 2.1.9 so i delete TCs OL-T25447
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_057}
    Click at    ${MY_JOB_TOTAL_JOB_BY_LOCATION}
    Check span display      Hiring Goal
    Check span display      Set the number of candidates you need.
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      1001
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Update Job Posting
    Check span display      ${MY_JOB_CVO_BETWEEN_MESSAGE}
    capture page screenshot


Client job - Check Job Settings Metadata Display on the My jobs (OL-T25449, OL-T25450, OL-T25461)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_045}
    check element display on screen     ${MY_JOB_DETAIL_THRESHOLD_NUMBER_DEFAULT}    0 / 5 Candidates
    capture page screenshot
    Hover at    ${MY_JOB_DETAIL_CANDIDATE_REACHED_HIRING_GOAL}
    Check element display on screen     Candidates reached Hiring Goal
    capture page screenshot
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}       ${AUTOMATION_TESTER_TITLE_045}
    check span display      View Job Description
    Check span display      Edit Job
    check span display      Copy Internal Posting Link
    capture page screenshot


Client job - Check Editing the Job on My Jobs in case Job ON (OL-T25452)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_048}
    ${status}=      Run keyword and return status       Check toggle is Off     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}
    IF   '${status}' == 'True'
        Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}
        Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      4
        Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
        Edit job information    ${AUTOMATION_TESTER_TITLE_048}      5       4
    ELSE
        Edit job information    ${AUTOMATION_TESTER_TITLE_048}      4       5
    END


Client job - Check Ellipsis Options on My Jobs in case Job OFF (OL-T25454)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_021}
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}   ${AUTOMATION_TESTER_TITLE_021}
    check span display      View Job Description
    Check span display      Edit Job
    check span display      Copy Internal Posting Link
    capture page screenshot


Client job - Check Editing the Job on My Jobs in case Job OFF (OL-T25456, OL-T25462)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_058}
    ${status}=      Run keyword and return status       Check toggle is Off     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}   ${AUTOMATION_TESTER_TITLE_058}
    IF   '${status}' == 'True'
        Turn off    ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}
        Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Close Job
        Edit job information    ${AUTOMATION_TESTER_TITLE_058}      4    5
    ELSE
        Edit job information    ${AUTOMATION_TESTER_TITLE_058}      4     5
    END
    Search job by location and job name     ${AUTOMATION_TESTER_TITLE_058}
    Turn off    ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Close Job
    Verify message after turn on/off job    ${AUTOMATION_TESTER_TITLE_058}


Client job - Check the list jobs on each location in case the Map Locations in My Jobs with Location ID from feed toggle is OFF (OL-T25419, OL-T25417)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    Go to My Jobs page
    Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    Click at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_COUNTRY}   ${LOCATION_NAME_US}
    Click at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_CITY}      ${LOCATION_CITY_TEXAS_TX}
    Check span display      ${LOCATION_MAPPING_TITLE_012}
    ${actual_job}=  Get element count   ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}
    Should be equal as strings    ${actual_job}     1
    capture page screenshot

*** Keywords ***
Check result after search location
    [Arguments]     ${location_name}    ${location_result}
    Reload page
    CLick by JS    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    Check element display on screen     ${MY_JOB_ALL_LOCATION_SEARCH_FOR_LOCATION_TEXTBOX}
    Input into      ${MY_JOB_ALL_LOCATION_SEARCH_FOR_LOCATION_TEXTBOX}      ${location_name}
    Check element display on screen     ${MY_JOB_ALL_LOCATION_SEARCH_RESULT}    ${location_result}
    [Return]    ${location_name}

Check total job show by location name
    [Arguments]     ${expected_job}
    ${actual_job}=      Get element count       ${MY_JOB_TOTAL_JOB_BY_LOCATION}
    Should be equal as strings    ${actual_job}     ${expected_job}

Verify Candidate applied via Job posting site is successfully
    Check element display on screen     ${OLIVIA_JOB_ASSISTANT}     ${COMPANY_APPLICANT_FLOW}
    Candidate input to landing site     ${YES}
    Verify AI message when asking about name in    Landing Site
    ${generate_candidate_name}=     Generate candidate name
    Candidate input to landing site     ${generate_candidate_name.full_name}
    Verify AI message when asking about email in    Landing Site
    &{email_info} =    Get email for testing
    Candidate input to landing site     ${email_info.email}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}
    capture page screenshot

Search job and click at eclipse icon
    [Arguments]     ${job_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to My Jobs page
    Input into    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${job_name}
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}   ${job_name}

Edit job information
    [Arguments]     ${job_name}     ${prev_candidate_number}    ${after_candidate_number}
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}   ${job_name}
    Click at    ${MY_JOB_DETAILS_EDIT_JOB}
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      ${prev_candidate_number}
    ${status_button}=   run keyword and return status   Verify element is disable       ${MY_JOB_DETAIL_EDIT_JOB_DISABLE_BUTTON}
    IF  '${status_button}' == 'True'
        ${prev_number}=     Convert To Integer      ${prev_candidate_number}
        Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      ${prev_number+1}
    END
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Update Job Posting
    Verify message after turn on/off job    ${job_name}
    Search job by location and job name     ${job_name}
    Click at    ${MY_JOB_TOTAL_JOB_BY_LOCATION}
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      ${after_candidate_number}
    ${status_button}=   run keyword and return status   Verify element is disable       ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Update Job Posting
    IF  '${status_button}' == 'True'
        ${after_number}=     Convert To Integer      ${after_candidate_number}
        Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      ${after_number-1}
    END
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Update Job Posting
    Verify message after turn on/off job    ${job_name}

Check status job to turn off
    [Arguments]     ${job_name}
    Search job by location and job name     ${job_name}
    ${status}=      Run keyword and return status       Check toggle is on      ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}
    IF  ${status}
            Turn off    ${MY_JOB_DETAIL_TURN_ON_JOB_ICON}
            Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}     Close Job
            Element Should Be Visible     ${MY_JOB_TOAST_MESSAGE_UPDATE_JOB_MESSAGE}      ${job_name}
            capture page screenshot
    END
