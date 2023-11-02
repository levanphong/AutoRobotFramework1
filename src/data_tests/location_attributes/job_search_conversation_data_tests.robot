*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${custom_attribute}                         custom_location_attribute
${test_location_name}                       Location_job_search_cus_attribute
${job_template}                             Job_Pharmacist_template
${job_name}                                 Pharmacist
${user_name}                                Auto CP
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${job_family_name}                          Coffee family job

*** Keywords ***
Prepare Add data test for verify job search has location assign location attribute
    [Arguments]    ${user_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add a Custom Location Attributes    ${custom_location_attr_with_value}
    Add a Custom Location Attributes    ${custom_location_attr_without_value}
    Add a Location    ${COMPANY_HIRE_ON}    ${test_location_name}
    Assign Custom location attribute    ${test_location_name}    ${custom_location_attr_with_value}
    Assign user to location    ${test_location_name}    ${user_name}
    Create job template and job data test    ${job_template}    ${job_name}

Create job template and job data test
    [Arguments]    ${job_template}    ${job_name}
    Go to Jobs page
    ${job_description} =    set variable    ${job_name} description
    Create new job, publish and turn on my job    ${job_family_name}    ${job_name}    ${test_location_name}        ${CP_TEAM}      attendee=${CP_TEAM}
    Active a job    ${job_name}     ${test_location_name}

*** Test Cases ***
Prepare job search conversation custom message data test
    Prepare Add data test for verify job search has location assign location attribute      ${user_name}
