*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          ltsstg    regression


*** Variables ***
${landing_site_name}    SearchByReqIDLandingSite
${widget_name}          SearchByReqIDWidget

*** Test Cases ***
# COMPANY_NEW_ROLE => turn on job search
Check UI and check adds Regex patterns (OL-T28291, OL-T28290)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_NEW_ROLE}
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_JOB_REQ_ID_SEARCH_TOGGLE}
    Click at   ${JOB_REQ_ID_SEARCH_FIRST_PATTERN_DROPDOWN}
    Check Regexp Pattern dropdown
    #   Select 6 digit number, then check value and the item wil be disabled on dropdown
    Click at   ${SIX_DIGIT_NUMBER}
    Check value of selected item and item is not clickable
    Check "Add Field" button will disappear when there are already 5 fields

# COMPANY_GEOGRAPHIC_TARGETING
Check when User adds a Regex pattern and Candidate Search jobs by correct Requisition ID (OL-T28292)
    Initial and go to landing site   COMPANY_GEOGRAPHIC_TARGETING   ${landing_site_name}
    #   Search 123456
    Search job and check job display    ${SIX_DIGIT_NUMBER_REQ_ID}   ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${SIX_DIGIT_NUMBER_TITLE_JOB}
    #   Search 1234567
    Search job and check job display    ${SEVEN_DIGIT_NUMBER_REQ_ID}   ${AWESOME_JOB_HERE}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${SEVEN_DIGIT_NUMBER_TITLE_JOB}


Check when User adds Regex pattern and Candidate Search jobs by req_id for uppercase/lowercase character (OL-T28299, OL-T28300)
    Initial and go to landing site   COMPANY_GEOGRAPHIC_TARGETING   ${landing_site_name}
    #   Search PAT002 (UPPERCASE)
    Search job and check job display    ${AUTOMATION_TESTER_REQ_ID_002}   ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${AUTOMATION_TESTER_TITLE_002}
    #   Search pat002 (LOWERCASE)
    Search job and check job display    pat002   ${AWESOME_JOB_HERE}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${AUTOMATION_TESTER_TITLE_002}


Check when User adds Custom Regex patterns and Candidate Search jobs by correct Requisition ID (OL-T28293)
    Initial and go to landing site   COMPANY_GEOGRAPHIC_TARGETING   ${landing_site_name}
    #   Search MP009
    Search job and check job display    ${LOCATION_MAPPING_REQ_ID_009}   ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${LOCATION_MAPPING_TITLE_009}


Check when User adds some Regex patterns and Candidate Search jobs by correct Requisition ID (OL-T28294)
    Initial and go to landing site   COMPANY_GEOGRAPHIC_TARGETING   ${landing_site_name}
    #   Search MP009
    Search job and check job display    ${LOCATION_MAPPING_REQ_ID_009}   ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${LOCATION_MAPPING_TITLE_009}
    #   Search 123456
    Search job and check job display    ${SIX_DIGIT_NUMBER_REQ_ID}   ${AWESOME_JOB_HERE}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${SIX_DIGIT_NUMBER_TITLE_JOB}


Check when User adds Regex pattern and Candidate Search jobs by incorrect Requisition ID (OL-T28295)
    Given Setup test
    ${site_url} =  Get widget conversation link  ${widget_name}
    Go to  ${site_url}
    Wait with large time
    #   Search 12345, no job displays
    Input text for widget site  12345
    Check element not display on screen  ${CONVERSATION_LIST_VIEW_TABLE}
    #   Search 12345678, no job displays
    Input text for widget site     ${NEW}
    Input text for widget site     12345678
    Check element not display on screen  ${CONVERSATION_LIST_VIEW_TABLE}


Check when User adds Regex pattern and Candidate Search jobs by Job Category (OL-T28296)
    Initial and go to landing site   COMPANY_GEOGRAPHIC_TARGETING   ${landing_site_name}
    #   Search Maintenance
    Search job and check job display    ${CATEGORIES_FOR_123456} ${ANY_WHERE}   ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${SIX_DIGIT_NUMBER_TITLE_JOB}

# COMPANY_COMMON
Check when Turning OFF "Job Requisition ID search" toggle and Candidate Search jobs by correct Requisition ID (OL-T28297)
    Initial and go to landing site   COMPANY_COMMON   ${landing_site_name}
    #   Search 123456
    Candidate input to landing site     ${AUTOMATION_TESTER_REQ_ID_001}
    Verify AI message when asking about location in   Landing Site


Check when Turning OFF Job Requisition ID search toggle and Candidate Search jobs by correct Job category (OL-T28298)
    Initial and go to landing site   COMPANY_COMMON   ${landing_site_name}
    #   Search Maintenance
    Search job and check job display    ${CATEGORIES_FOR_123456} ${ANY_WHERE}   ${LOOK_AT_POSITION}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_ITEM}   ${SIX_DIGIT_NUMBER_TITLE_JOB}

*** Keywords ***
Initial and go to landing site
    [Arguments]    ${company_variable}   ${landing_site}
    Given Setup test
    ${site_url} =  Get landing site url by string concatenation  ${company_variable}   ${landing_site}
    Go to  ${site_url}
    Wait for Olivia reply

Check Regexp Pattern dropdown
    Check element display on screen  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${SIX_DIGIT_NUMBER}
    Check element display on screen  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${SEVEN_DIGIT_NUMBER}
    Check element display on screen  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${EIGHT_DIGIT_NUMBER}
    Check element display on screen  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${ALPHANUMERIC_SEQUENCE}
    Check element display on screen  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${CUSTOM}

Check value of selected item and item is not clickable
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_LAST_PATTERN_DROPDOWN}
    Verify css property as strings    cursor    not-allowed    ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${SIX_DIGIT_NUMBER}
    ${pattern_value} =  Get text and format text  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${SIX_DIGIT_NUMBER}
    Should Contain   ${pattern_value}   ${SIX_DIGIT_NUMBER_REGEXP}
    Click at   Regex Pattern

Check "Add Field" button will disappear when there are already 5 fields
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Check element not display on screen  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_REMOVE_LAST_PATTERN_BUTTON}
    Check element display on screen  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_REMOVE_LAST_PATTERN_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_REMOVE_LAST_PATTERN_BUTTON}
    Click at  ${JOB_REQ_ID_SEARCH_REMOVE_LAST_PATTERN_BUTTON}

Search job and check job display
    [Arguments]  ${search_text}  ${show_jobs_message}
    Candidate input to landing site     ${search_text}
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${show_jobs_message}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_TABLE}   wait_time=5s
