*** Settings ***
Resource            ../../../pages/workflows_page.robot
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/my_jobs_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/candidate_journeys_page.robot
Resource            ../../../pages/offers_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome     ${2560}    ${1440}

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${offer_name}               Automation job
${job_family_name}          Coffee family job
${test_location_name}       ${LOCATION_NAME_2}

*** Test Cases ***
Check if new field Available job types is added under Job toggle (OL-T15741,OL-T15742)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Hire Option
    Click at    ${AVAILABLE_JOB_TYPES_DROPDOWN}
    Check element display on screen    ${CLIENT_SETUP_JOB_TYPE}    Basic Multi-location Job
    Check element display on screen    ${CLIENT_SETUP_JOB_TYPE}    Multi-location Job
    Check element display on screen    ${CLIENT_SETUP_JOB_TYPE}    Standard Job
    Scroll to element by JS    ${AVAILABLE_JOB_CANCEL_BUTTON}
    Check element display on screen    ${AVAILABLE_JOB_CANCEL_BUTTON}
    Click at    ${AVAILABLE_JOB_CANCEL_BUTTON}
    Click at    ${AVAILABLE_JOB_TYPES_DROPDOWN}
    Click at    ${AVAILABLE_JOB_SELECT_ALL_CHECKBOX}
    Click at    ${AVAILABLE_JOB_APPLY_BUTTON}
    Check element display on screen    ${WARNING_JOB_TYPE}


Check if user can uncheck Job type if having a job in that templated created in the company (OL-T15744,OL-T15745)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Hire Option
    Click at    ${AVAILABLE_JOB_TYPES_DROPDOWN}
    Click at    ${CLIENT_SETUP_JOB_TYPE}    Basic Multi-location Job
    Click at    ${AVAILABLE_JOB_APPLY_BUTTON}
    wait for page load successfully v1
    Check element display on screen    ${WARNING_COULD_NOT_DELETE_JOB_TYPE}


Check if adding new section about Hiring team added under Hire tab (OL-T15746,OL-T15747,OL-T15748,OL-T15749,OL-T15743,OL-T15752,OL-T15782,OL-T15784)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Hire Option
    Scroll to element by JS    Hiring Manager
    Verify display common text    Recruiter
    Verify display common text    Hiring Manager
    Scroll to element by JS    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    element should be enabled    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    Hover at    ${ICON_TOOLTIP}
    ${locator_text} =    Format String    ${POPOVER_CONTENT_TEXT}   Hiring Team roles can be used as audiences when mapped
    Element should be visible    ${locator_text}
    Click at    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    click on span text    Add New Role
    ${role} =    generate random name    auto_role
    ${role_updated} =    generate random name    auto_role
    input text    ${INPUT_HIRING_ROLE_NAME}    ${role}
    Click at    ${BUTTON_SAVE_ADD_HIRING_ROLE}
    Check element display on screen    ${role}
    Scroll to element by JS    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    Click at    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    input text    ${INPUT_HIRING_ROLE_NAME}    ${role_updated}
    Click at    ${BUTTON_SAVE_ADD_HIRING_ROLE}
#    Check if user can delete Hiring team role if there is only 1 role added in the list (OL-T15750)
    Click at    ${ICON_DELETE_HIRING_ROLE}    ${role_updated}


Check if delete Hiring team roles if it is being added in job of the company (OL-T15751)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Hire Option
    Click at    ${ICON_DELETE_HIRING_ROLE}    Hiring Manager
    Check element display on screen    Couldn’t Delete Hiring Team Role
    Click at    ${BUTTON_CANCEL_DELETE_HIRING_TEAM_ROLE}


Add new Hiring Team Roles (OL-T15753)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Hire Option
    Scroll to element by JS    Hiring Manager
    Click at    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    click on span text    Add New Role
    Click at    ${BUTTON_SAVE_ADD_HIRING_ROLE}
    Check element display on screen    Hiring Role name is required


Check if user can add new/edit Hiring team roles same as added role (OL-T15754)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Hire Option
    Scroll to element by JS    Hiring Manager
    Click at    ${CONFIG_HIRING_TEAM_EDIT_BUTTON}
    click on span text    Add New Role
    input text    ${INPUT_HIRING_ROLE_NAME}    Hiring Manager
    Click at    ${BUTTON_SAVE_ADD_HIRING_ROLE}
    Check element display on screen    Hiring Role names must be unique
