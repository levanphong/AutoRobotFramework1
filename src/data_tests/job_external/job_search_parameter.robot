*** Settings ***
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/cms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${job_site_name}                JobSearchParameterLandingSite
${job_widget_name}              JobSearchParameterWidget

*** Test Cases ***
# ==== SECTION: COMPANY_APPLICANT_FLOW ====
# 1. Client setup--> Job search:
# +1a Turn on Job search toggle
# +1b At Search company, select company "AUTOMATION_JOB_FEEDS_PROD"
# +1c At Search Parameters, select ALL
# +1d At Include remote jobs in location-based search, turn ON
# 2a. Client setup > Care > Turn On Candidate Care
# 2b. Knowledge base > Candidate Care: input link: "https://docs.google.com/spreadsheets/d/1qgcA0mDo1emq26YJ0fso_XP469GjATBK4TeVANv9pN0/edit#gid=0"
# 3. Web management
# +3a Create new landing site, name: JobSearchParameterLandingSite
# +3b Turn on Job search toggle
# +3c At "How would you like to start the interaction?", select "Job search" option
#  4. Turn on Set Default Job Search Parameter, Attribute = Job Country, Value = United States

# ==== SECTION: COMPANY_EXTERNAL_JOB ====
# 1. Add a company "Test Automation External Job"
# 2. Client setup--> Job search:
# +2a Turn on Job search toggle
# +2b At Search company, select company "AUTOMATION_JOB_FEEDS_PROD"
# 3. Web management
# +3a Create new landing site, name: JobSearchParameterLandingSite
# +3b Turn on Job search toggle
# +3c At "How would you like to start the interaction?", select "Job search" option
# 4a. Client setup > Care > Turn On Candidate Care
# 4b. Knowledge base > Candidate Care: input link: "https://docs.google.com/spreadsheets/d/1qgcA0mDo1emq26YJ0fso_XP469GjATBK4TeVANv9pN0/edit#gid=0"
#  5. Turn on Set Default Job Search Parameter, Attribute= Job Country, Value = United States

# ==== SECTION: COMPANY_LOCATION_MAPPING_OFF ====
# 2. Client setup--> Job search:
# +2a Turn on Job search toggle
# +2b At Search company, select company "AUTOMATION_JOB_FEEDS_PROD"
# 3. Web management
# +3a Create new landing site, name: JobSearchParameterLandingSite
# +3b Create new landing site, name: JobSearchParameterWidget
# +3c Turn on Job search toggle
# +3d At "How would you like to start the interaction?", select "Job search" option

Create data test for Job Search Parameters 1
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Turn on Candidate Care
    Turn on Job Search toggle   Production  ${MASTER_FEED_APPLICANT_FLOW}
    Select 'Search Parameters' dropdown   Select All
    Turn on Include Remote Jobs toggle
    Turn on Job Requisition ID Search
    Turn on Set Default Job Search Parameter and set parameter
    Create job search landing site/widget    Landing Site  ${job_site_name}


Create data test for Job Search Parameters 2
    #   Set up to 'EXTERNAL_JOB'
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Add company for testing   ${COMPANY_EXTERNAL_JOB}
    Turn on Candidate Care
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Select 'Search Parameters' dropdown   Unselect All
    Turn on Job Requisition ID Search
    Create job search landing site/widget      Landing Site    ${job_site_name}


Create data test for Job Search Parameters 3
    #   Set up to 'COMPANY_LOCATION_MAPPING_OFF'
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
     Turn on Job Search toggle   Production  ${MASTER_FEED_MAPPING_OFF}
     Select 'Search Parameters' dropdown   Select All
     Turn on Job Requisition ID Search
    Create job search landing site/widget      Landing Site    ${job_site_name}
    Create job search landing site/widget    Widget Conversation   ${job_widget_name}   ${DOMAIN_SECURITY}
