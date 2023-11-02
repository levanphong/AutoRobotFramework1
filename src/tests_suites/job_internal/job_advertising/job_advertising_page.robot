*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        regression    test

Documentation       Client Setup > Account Overview > Input `Account SalesForce ID`, Hire > Turn ON `Jobs Advertising`

*** Variables ***
${jobs_page_jobs_tab}                   Jobs
${jobs_page_job_templates_tab}          Job Templates
${jobs_page_job_advertising_tab}        Job Advertising

${job_advertising_overview_tab}         Overview
${job_advertising_in_progress_tab}      In Progress
${job_advertising_completed_tab}        Completed

*** Test Cases ***
Verify 'No advertisements currently in progress' text is displayed correctly when no jobs are currently being advertised (OL-T30964, OL-T30962)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    Log    Check Left menu display correctly
    Check element display on screen     ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_jobs_tab}
    Check element display on screen     ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_templates_tab}
    Check element display on screen     ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Capture Page Screenshot
    Log    Monthly Advertising Overview title
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Check element display on screen     ${JOBS_PAGE_MAIN_CONTENT_TITLE}     Monthly Advertising Overview
    Log    Monthly/year filter
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_FILTER_BY_DATE_DROPDOWN}
    Capture Page Screenshot
    Log    T30962: Check items in Overview tab
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_ITEM_TITLE}    Budget Spent
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_ITEM_TITLE}    Budget Remaining
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_ITEM_TITLE}    Cost per Candidate
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_ITEM_TITLE}    New Candidates
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_ITEM_TITLE}    Total Advertisements
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_ITEM_TITLE}    Top Candidate Sources
    Capture Page Screenshot
    Log    Check items in In Progress tab when empty
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_in_progress_tab}
    Check element display on screen     No advertisements currently in progress.
    Capture Page Screenshot


Verify the Advertising tab is displayed correctly on Job page (OL-T30961)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Log    Check child-tab in Job Advertising
    Check element display on screen     ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_overview_tab}
    Check element display on screen     ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_in_progress_tab}
    Check element display on screen     ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_completed_tab}
    Capture Page Screenshot


Verify In-Progress tab is displayed correctly when having job are currently being advertised (OL-T30965, OL-T30966)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_in_progress_tab}
    Log    Check columns of table in In Progress tab
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Job Name
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Job Location
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Candidates
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Date Started
    Capture Page Screenshot
    Log    T30966: Check Eclipse menu of items in table
    ${default_item_eclipse_icon} =      Format String       ${JOBS_PAGE_JOB_ADVERTISING_ITEM_ECLIPSE_ICON}      ${EMPTY}
    Mouse Over      ${default_item_eclipse_icon}
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_ITEM_ECLIPSE_MENU_VIEW_HISTORY_OPTION}
    Capture Page Screenshot

Verify the 'No advertisements completed yet.' text is displayed correctly when no jobs in this account have finished an advertisement yet on Completed tab (OL-T30969)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Log    Check items in Completed tab when empty
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_completed_tab}
    Check element display on screen     No advertisements completed yet.
    Capture Page Screenshot


Verify the Completed page is displayed correctly (OL-T30970, OL-T30971)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_completed_tab}
    Log    Check columns of table in In Progress tab
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Job Name
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Job Location
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Candidates
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_IN_PROGRESS_COLUMN_TITLE}       Date Completed
    Capture Page Screenshot
    Log    T30971: Check Eclipse menu of items in table
    ${default_item_eclipse_icon} =      Format String       ${JOBS_PAGE_JOB_ADVERTISING_ITEM_ECLIPSE_ICON}      ${EMPTY}
    Mouse Over      ${default_item_eclipse_icon}
    Check element display on screen     ${JOBS_PAGE_JOB_ADVERTISING_ITEM_ECLIPSE_MENU_VIEW_HISTORY_OPTION}
    Capture Page Screenshot


Verify the user can filter data by monthly/ year on Overview tab (OL-T30963)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Log    Use can change filter
    Click at    ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_FILTER_BY_DATE_DROPDOWN}
    ${available_month} =    Get text and format text    ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_FILTER_BY_DATE_MONTH_VALUE}    ${EMPTY}
    Capture Page Screenshot
    Click at    ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_FILTER_BY_DATE_MONTH_VALUE}    ${EMPTY}
    Log    Check filter is updated with expected month
    ${selected_month} =    Get text and format text    ${JOBS_PAGE_JOB_ADVERTISING_OVERVIEW_FILTER_BY_DATE_DROPDOWN}
    Should Contain    ${selected_month}    ${available_month}
    Capture Page Screenshot


Verify the user can view history job advertising (OL-T30972, OL-T30967, OL-T30968, OL-T30973)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Log    T30972: Check display of View History widget for Completed tab
    Go to Jobs page
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${jobs_page_job_advertising_tab}
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_completed_tab}
    Check display of View History widget
    Log    T30973: Check View History widget close for Completed tab
    Check View History widget close when click Cancel button
    Log    T30967: Check display of View History widget for In Progress tab
    Click at    ${JOBS_PAGE_LEFT_MENU_NAV_TEXT}     ${job_advertising_in_progress_tab}
    Check display of View History widget
    Log    T30968: Check View History widget close for In Progress tab
    Check View History widget close when click Cancel button


*** Keywords ***
Check display of View History widget
    ${default_item_eclipse_icon} =      Format String       ${JOBS_PAGE_JOB_ADVERTISING_ITEM_ECLIPSE_ICON}      ${EMPTY}
    Mouse Over      ${default_item_eclipse_icon}
    Click at     ${JOBS_PAGE_JOB_ADVERTISING_ITEM_ECLIPSE_MENU_VIEW_HISTORY_OPTION}
    Log    Check display of View History widget
    Check element display on screen    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_STATUS}
    Check element display on screen    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_BUDGET}
    Check element display on screen    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_SPENT}
    Check element display on screen    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_CANDIDATE_APPLIED}
    Check element display on screen    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_STARTED}
    Capture Page Screenshot

Check View History widget close when click Cancel button
    Click at    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_CANCEL_BUTTON}
    Check element not display on screen    ${JOBS_PAGE_JOB_ADVERTISING_VIEW_HISTORY_ADVERTISING_DIALOG}
    Capture Page Screenshot
