*** Settings ***
Variables       ../../../locators/client_setup_locators.py
Resource        ../../../pages/jobs_page.robot
Resource        ../../../pages/conversation_builder_page.robot
Resource        ../../../pages/web_management_page.robot
Resource        ../../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${job_template_migration}       job_template_migration

*** Test Cases ***
Prepare Basic Multi Location Job Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job template    ${job_description}    ${basic_job_temp}    ${TYPE_BASIC_MULTI_LOCATION}
    Create new job template    ${job_description}    ${multi_job_temp}    ${TYPE_MULTI_LOCATION}
    Create new job template    ${job_description}    ${standard_job_temp}    ${TYPE_STANDARD_LOCATION}
    Create new job template with full information       ${job_template_migration}

Prepare conversation Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add Job Search Conversation    Job Search       ${conversation_create_job}

Prepare landing site Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Create landing site/widget site     Landing Site     ${landing_site_create_job}

*** Keywords ***
Create new job template with full information
    [Arguments]     ${job_template_name}
    Create new job template    ${job_description}    ${job_template_name}    ${TYPE_BASIC_MULTI_LOCATION}
    # Add Hiring Team
    Add Hiring Team for job
    # Choose candidate journey
    Click at    ${CANDIDATE_JOURNEY_TAB}
    wait for page load successfully
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Click on span text   Default Candidate Journey
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    # Add screening
    Add Screening Question for job
	add question document upload
    add question List select
    # Publish job template
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${PUBLISH_JOB_BUTTON}
