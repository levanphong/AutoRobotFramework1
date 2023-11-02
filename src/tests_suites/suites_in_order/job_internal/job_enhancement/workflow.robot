*** Settings ***
Resource            ../../../../pages/workflows_page.robot
Resource            ../../../../drivers/driver_chrome.robot
Resource            ../../../../data_tests/job_internal/job_enhancement/workflow.robot
Resource            ../../../../pages/web_management_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***

*** Test Cases ***
Workflow Builder - Don't show [Hiring Team Roles] in Audience list when no Hire toggle OFF on Client Setup - Paradox Platform (OL-T14013)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Turn off Hire Toggle on Client Setup for Job Internal / Workflow
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    Click at    ${AUDIENCE_DROPDOWN}
    Check element not display on screen    Hiring Team Roles
    Enable Client Setup for Job Internal / Workflow    Hire


Workflow Builder - Verify Languages dropdown in case audience is Hiring Team Roles - Platform Language toggle OFF (OL-T14018)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Turn off Multilingual Toggle on Client Setup for Job Internal / Workflow
    Go to Workflows page
    Click at    ${NEW_WORKFLOW_BUTTON}
    Verify Create Workflow page with platform
    ${workflow_name} =    Generate random name    auto_workflow
    Input into    ${WORKFLOW_NAME_TEXT_BOX}    ${workflow_name}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}    Recruiter
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}
    Click at    ${WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN}
    Input into    ${JOURNEY_SEARCH_TEXT_BOX}    Default Candidate Journey
    Click at    Default Candidate Journey
    Check element not display on screen    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Enable Client Setup for Job Internal / Workflow    Multilingual
