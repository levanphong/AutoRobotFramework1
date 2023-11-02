*** Settings ***
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/cms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Documentation   COMPANY_APPLICANT_FLOW: Job Search > Job Requisition ID search ON, Custom: \bREF+\d{5}[A-Z]+, add field: Alpha
#   To get link in My Jobs page, should create a Job posting page
#   COMPANY_LOCATION_MAPPING_OFF: Client Setup > Compliance and Security > GDPR on > Select where to display terms: US
#   COMPANY_LOCATION_MAPPING_OFF: Client Setup > Job Search  > Chat to apply ON > Assign a Conversation

*** Variables ***
${job_site_name}                JobSearchSiteForTesting
${job_widget_name}              JobSearchWidgetForTesting
${manual_condition_title}       Manual
${domain_security}              prd-automation-team.github.io

*** Test Cases ***
Create data test for Job Search Results cycle
    Setup test
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    #    Job Search > Job Requisition ID search ON, Custom: \bREF+\d{5}[A-Z]+, add field: Alpha
    Turn on Job Requisition ID Search
    Turn on CMS toggle
    #   Client Setup > Job Search > 1. Select "Production" at "Environment"  2. select Job Feed at "Search Company"
    Turn on Job Search toggle   Production  ${MASTER_FEED_APPLICANT_FLOW}
    #   Create a landing site, turn on Job Search, "How would you like to start the interaction?": select Job Search, "Site name"= JobSearchSiteForTesting
    Create job search landing site/widget    Landing Site  ${job_site_name}
    Create job search landing site/widget    Widget Conversation   ${job_widget_name}   ${DOMAIN_SECURITY}
    #   Create 2 condition
    Go to job search results builder page
    Add new condition then select it    ${manual_condition_title}  input=${manual_condition_title}
    CLick at    ${NAV_SUB_MENU_TEXT}    Selected Job
    Remove field(s)  Company Name
    Add new condition then select it    ${AUTOMATION_TESTER_TITLE_002}  input=${AUTOMATION_TESTER_TITLE_002}
    Add field in Job Search Results  Job Category   Selected Job
    Add field in Job Search Results  Company Name   Job Posting Page


Create data test for Job Search Results cycle 2
    Setup test
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    Turn off CMS toggle
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Create job search landing site/widget      Landing Site    ${job_site_name}
