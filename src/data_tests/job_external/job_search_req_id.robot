*** Settings ***
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/cms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          ltsstg

*** Variables ***
${landing_site_name}    SearchByReqIDLandingSite
${widget_name}          SearchByReqIDWidget

*** Test Cases ***
Create data test for Job Search Req ID 1
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_NEW_ROLE}
    Navigate to Option in client setup  Job Search
    Turn on    ${JS_JOB_REQ_ID_SEARCH_TOGGLE}
    Save client setup page
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}


Create data test for Job Search Req ID 2
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_GEOGRAPHIC_TARGETING}
    Navigate to Option in client setup  Job Search
    Turn on Job Search toggle
    Setup Job Requisition ID Search
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    # prd-automation-team.github.io
    Create job search landing site/widget    Widget Conversation   ${widget_name}   ${DOMAIN_SECURITY}


Create data test for Job Search Req ID 1
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_COMMON}
    Navigate to Option in client setup  Job Search
    Turn on Candidate Care
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Create job search landing site/widget    Landing Site  ${landing_site_name}

*** Keywords ***
Setup Job Requisition ID Search
    Turn on    ${JS_JOB_REQ_ID_SEARCH_TOGGLE}
    #   First pattern
    Input into  ${JOB_REQ_ID_SEARCH_FIRST_VALUE_TEXTBOX}  (?:PAT|pat)\d{1,3}
    #   Second pattern
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    Input into  ${JOB_REQ_ID_SEARCH_LAST_VALUE_TEXTBOX}  MP[0-9]+
    #   Third pattern
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    CLick at  ${JOB_REQ_ID_SEARCH_LAST_PATTERN_DROPDOWN}
    CLick at  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${SIX_DIGIT_NUMBER}
    #   Fourth pattern
    Click at  ${JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON}
    CLick at  ${JOB_REQ_ID_SEARCH_LAST_PATTERN_DROPDOWN}
    CLick at  ${JOB_REQ_ID_SEARCH_DATA_ITEM}    ${SEVEN_DIGIT_NUMBER}
    Save client setup page
    Capture page screenshot
