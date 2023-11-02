*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/cms_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/phone_number_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    regression    test

Documentation       Turn on Job Search in client set up
#Create data test:
#Create a conversation name is job feed single path
#Widget name: WidgetJobFeed
#Landing site name: LandingSiteJobFeed
#Create a new user with name : Personal Recruiting

*** Variables ***
${company_site_name}            Test Automation Job on Data package off Site
${personal_recruiting_name}     Personal Recruiting's Recruiting Site
${landing_site_name}            LandingSiteJobFeed
${widget_site_name}             WidgetJobFeed
${job_feed_single_path}         job feed single path

*** Test Cases ***
Verify Select a Job Feed for this Personal Recruiting Site when turning OFF Job Search toggle in Personal Recruiting Site (OL-T23142, OL-T23143, OL-T23144)
    Check all elements job feed by site type    ${personal_recruiting_name}    Select a Job Feed for this Personal Recruiting Site


Verify Select a Job Feed for this Landing Site when turning OFF Job Search toggle in Landing Site (OL-T23145, OL-T23146, OL-T23147)
    Check all elements job feed by site type    ${landing_site_name}    Select a Job Feed for this Landing Site


Verify 'Select a Job Feed for this Widget' when turning OFF 'Job Search' toggle in Widget (OL-T23148, OL-T23149, OL-T23150, OL-T23151)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to Web Management
    Search and click landing site   ${widget_site_name}
    Check all elements of job feed by site name      Select a Job Feed for this Widget
    capture page screenshot
    Input into      ${ADD_NEW_TARGETING_RULE_INPUT}     Targeting rule widget
    Click at    ${ADD_NEW_TARGETING_RULE_BUTTON}
    Turn on     ${JOB_SEARCH_TOGGLE_ON_MODAL}
    Check element display on screen     ${DEFAULT_JOB_FEED_DROPDOWN}
    Click at    ${DEFAULT_JOB_FEED_DROPDOWN}
    Click at    ${WEB_MANAGEMENT_WIDGET_SELECT_JOB_FEEDS_FOR_TARGETING_RULE}      1
    Click at    ${WEB_MANAGEMENT_WIDGET_TARGETING_RULE_APPLY_BUTTON}
    ${job_feed_name}=       Get value and format text    ${DEFAULT_JOB_FEED_DROPDOWN}
    Should be Equal as Strings      ${job_feed_name}    AUTOMATION_JOB_FEEDS_PROD_LOWE
    capture page screenshot


Verify 'Job Feed' when turning OFF 'Job Search' toggle in A.I Phone number (OL-T23152, OL-T23153, OL-T23154)
    Check UI Phone number by type   A.I. Phone Numbers


Verify 'Job Feed' when turning OFF 'Job Search' toggle in Shortcode Keywords (OL-T23155, OL-T23156, OL-T23157)
    Check UI Phone number by type   Shortcode Keywords


Regression test all elements in Client Setup > Job Search (OL-T23162, OL-T23161)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to Client setup page
    Click on strong text    Job Search
    Check toggle is On      ${JS_JOB_SEARCH_TOGGLE}
    Check strong text display   Job Search
    Check element display on screen     Search company
    capture page screenshot
    Click at    ${JS_SEARCH_COMPANY_SELECTION}
    Check element display on screen     ${JS_SEARCH_COMPANY_APPLY_BUTTON}
    Check element display on screen     ${JS_SEARCH_COMPANY_CANCEL_BUTTON}
    Check element display on screen     ${JS_SEARCH_AN_ATS_TEXTBOX}
    capture page screenshot


Check Feeds in all channels when selecting less than 2 feeds in Client Setup (OL-T25467)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Web Management
    Search and click landing site   ${widget_site_name}
    Check all elements of job feed less than 2 feeds by site name    Select a Job Feed for this Widget
    Search and click landing site   ${landing_site_name}
    Check all elements of job feed less than 2 feeds by site name    Select a Job Feed for this Landing Site
    Search and click landing site   Test Automation Franchise On Site
    Check all elements of job feed less than 2 feeds by site name    Select a Job Feed for this Company Site
    Search and click landing site   ${personal_recruiting_name}
    Check all elements of job feed less than 2 feeds by site name    Select a Job Feed for this Personal Recruiting Site
    Check all elements of job feed less than 2 feeds by phone number type      A.I. Phone Numbers
    Check all elements of job feed less than 2 feeds by phone number type      Shortcode Keywords

*** Keyword ***
Check UI Phone number by type
    [Arguments]     ${phone_number_type}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Select phone number by type name    ${phone_number_type}
    Turn off    ${PHONE_AI_FORM_JOB_SEARCH_TOGGLE}
    check element not display on screen     Job Feed
    Check element display on screen      How would you like to start the interaction?
    Check element display on screen     ${PHONE_AI_CAPTURE_CONVERSATION_DROPDOWN}
    capture page screenshot
    Turn on     ${PHONE_AI_FORM_JOB_SEARCH_TOGGLE}
    check span display     Job Feed
    Check element display on screen     ${PHONE_AI_FORM_ALL_JOB_FEED_DROPDOWN}
    Check element display on screen      How would you like to start the interaction?
    Check element display on screen     ${PHONE_AI_CAPTURE_CONVERSATION_DROPDOWN}
    capture page screenshot
    Click at    ${PHONE_AI_FORM_ALL_JOB_FEED_DROPDOWN}
    Check element display on screen     ${PHONE_AI_FORM_SELECT_ALL_JOB_FEED_CHECKBOX}
    Check element display on screen     ${PHONE_AI_FORM_JOB_FEED_OPTION}     AUTOMATION_JOB_FEEDS_PROD_LOWE
    Check element display on screen     ${PHONE_AI_FORM_JOB_FEED_OPTION}     AUTOMATION_JOB_FEEDS_PROD
    capture page screenshot

Check all elements of job feed by site name
    [Arguments]     ${label_select_job_feed_for_site_name}
    Turn off    ${JOB_SEARCH_TOGGLE}
    check element display on screen      How would you like to start the interaction?
    Check element not display on screen     ${label_select_job_feed_for_site_name}
    Check element display on screen    Which conversation will you use?
    Check element display on screen    ${CAPTURE_CONVERSATION}
    capture page screenshot
    Turn on     ${JOB_SEARCH_TOGGLE}
    Check span display      ${label_select_job_feed_for_site_name}

Check all elements of job feed less than 2 feeds by site name
    [Arguments]     ${label_select_job_feed_for_site_name}
    Turn on     ${JOB_SEARCH_TOGGLE}
    Check element not display on screen     ${label_select_job_feed_for_site_name}
    capture page screenshot
    Click at    ${ICON_CLOSE_MODAL}

Check all elements of job feed less than 2 feeds by phone number type
    [Arguments]     ${phone_number_type}
    Select phone number by type name    ${phone_number_type}
    Turn on     ${PHONE_AI_FORM_JOB_SEARCH_TOGGLE}
    Check element not display on screen     Job Feed
    capture page screenshot

Select phone number by type name
    [Arguments]     ${phone_number_type}
    Go to Phone number page
    IF  '${phone_number_type}' == 'A.I. Phone Numbers'
        Click at    ${PHONE_AI_PHONE_NUMBER_TYPE}     A.I. Phone Numbers
        Click at    ${PHONE_AI_CLICK_PHONE_NUMBER_BY_CONVERSATION}      ${job_feed_single_path}
        # CLick at phone number with conversation name is job feed single path
    ELSE IF    '${phone_number_type}' == 'Shortcode Keywords'
        Click at    ${PHONE_AI_PHONE_NUMBER_TYPE}     Shortcode Keywords
        Click at    ${PHONE_AI_CLICK_PHONE_NUMBER_BY_CONVERSATION}      ${job_feed_single_path}
    END

Check all elements job feed by site type
    [Arguments]     ${site_type_name}       ${label_job_feed_by_site}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to Web Management
    Search and click landing site   ${site_type_name}
    Check all elements of job feed by site name      ${label_job_feed_by_site}
    Click at    ${ALL_JOB_FEEDS_DROPDOWN}
    Check element display on screen     ${SELECT_ALL_JOB_FEEDS_CHECKBOX}
    capture page screenshot
