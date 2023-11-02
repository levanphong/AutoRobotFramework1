*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/location_management_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/job_data_packages_page.robot
Variables           ../../../locators/job_data_packages_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome


*** Test Cases ***
Prepare Basic Multi Location Job Data test
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    check and create job data package    job_data_package_1    Base Pay Maximum
    input job package name and select number of attributes    job_data_package_has_4_attributes    4
    input job package name and select number of attributes    job_data_package_has_3_attributes    3
    input job package name and select number of attributes    job_data_package_has_5_attributes    5
