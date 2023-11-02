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

*** Variables ***
@{list_feed_name_3_feed}    AUTOMATION_JOB_FEEDS_PROD    AUTOMATION_JOB_FEEDS_PROD_LOWE    AUTOMATION_MP_SECOND_FEEDS_PROD
@{list_feed_name_2_feed}    AUTOMATION_JOB_FEEDS_PROD    AUTOMATION_JOB_FEEDS_PROD_LOWE
@{list_feed_name_1_feed}    AUTOMATION_JOB_FEEDS_PROD

*** Test Cases ***
Check adding a new feed incase all old feed are selected in channels (OL-T25469, OL-T25470, OL-T25471, OL-T25472)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Check adding job feed to channels   3       @{list_feed_name_2_feed}
    Check adding job feed to channels   4       @{list_feed_name_3_feed}
    ${number_job_feed_after_remove}=    Check remove job feed to channels       LandingSiteJobFeed      2
    Should be equal as strings    ${number_job_feed_after_remove}       4
    Go to Client setup page
    Selct Job feed at Job search section    @{list_feed_name_2_feed}

*** Keyword ***
Check jod feed by channels name
    [Arguments]     ${channel_site_name}    ${expected_job_feed}
    Search and click landing site   ${channel_site_name}
    Turn on     ${JOB_SEARCH_TOGGLE}
    Click at    ${ALL_JOB_FEEDS_DROPDOWN}
    ${count_job_feed}=  Get Element Count       ${WEB_MANAGEMENT_WIDGET_JOB_FEED_CHECKBOX}
    Should be equal as strings    ${count_job_feed}     ${expected_job_feed}
    capture page screenshot
    Click at    ${ICON_CLOSE_MODAL}

Check job feed by phone number type
    [Arguments]     ${phon_number_type}     ${expected_job_feed}
    Click at    ${PHONE_AI_PHONE_NUMBER_TYPE}     ${phon_number_type}
    Click at    ${PHONE_AI_CLICK_PHONE_NUMBER_BY_CONVERSATION}      job feed single path
    Turn on     ${PHONE_AI_FORM_JOB_SEARCH_TOGGLE}
    Click at    ${PHONE_AI_ALL_JOB_FEED_DROPDOWN}
    ${count_job_feed}=  Get Element Count       ${WEB_MANAGEMENT_WIDGET_JOB_FEED_CHECKBOX}
    Should be equal as strings    ${count_job_feed}     ${expected_job_feed}
    capture page screenshot
    Click at    ${PHONE_AI_FORM_CANCEL_BUTTON}

Check adding job feed to channels
    [Arguments]     ${expected_job_feed}     @{list_feed_name}
    Go to Client setup page
    Selct Job feed at Job search section    @{list_feed_name}
    Go to Web Management
    Check jod feed by channels name     WidgetJobFeed      ${expected_job_feed}
    Check jod feed by channels name      LandingSiteJobFeed      ${expected_job_feed}
    Check jod feed by channels name      Personal Recruiting's Recruiting Site      ${expected_job_feed}
    Go to Phone number page
    Check job feed by phone number type      A.I. Phone Numbers     ${expected_job_feed}
    Check job feed by phone number type      Shortcode Keywords     ${expected_job_feed}

Check remove job feed to channels
    [Arguments]     ${channel_site_name}    ${check_box_index}
    Go to Web Management
    Search and click landing site   ${channel_site_name}
    Turn on     ${JOB_SEARCH_TOGGLE}
    Click at    ${ALL_JOB_FEEDS_DROPDOWN}
    Click at    ${WEB_MANAGEMENT_WIDGET_JOB_FEED_CHECKBOX_INDEX}      ${check_box_index}
    capture page screenshot
    ${count_job_feed}=  Get Element Count       ${WEB_MANAGEMENT_WIDGET_JOB_FEED_CHECKBOX}
    Click at    ${WEB_MANAGEMENT_WIDGET_TARGETING_RULE_APPLY_BUTTON}
    Click at    ${ICON_CLOSE_MODAL}
    [Return]    ${count_job_feed}
