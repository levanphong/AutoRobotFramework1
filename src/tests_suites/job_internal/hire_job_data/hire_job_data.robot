*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/location_management_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/my_jobs_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${job_family_name}                          Tester_Hunter
${job_family_name_off_package}              auto_job_family
${test_location_name}                       Test_Location_1
${test_location_name_second}                Test_Location_2
${test_location_area_name}                  Area_job_data_1
${test_location_name_off_package}           ${CONST_LOCATION}
${job_name}                                 test_job_package
${job_data_test_age}                        Test_job_data_package_age
${job_data_test_has_4_attributes}           Test_job_data_package_has_4_attributes
${job_data_test_has_5_attributes}           Test_job_data_package_has_more_than_5_attributes
${job_data_test_age_attribute}              Minimum Age
${job_data_test_senior_level}               Test_job_data_package_senior_level_attribute
${job_data_test_senior_level_attribute}     Seniority Level

*** Test Cases ***
Job Data is showed on Job (OL-T6048)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    navigate to data job package section
    Then Job Data section is Showed
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


Job Data is hided on Job (OL-T6049)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to    Client Setup
    When Turn off Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name_off_package}
    ...    ${test_location_name_off_package}
    then Job Data section is Hided
    click back job
    Delete a Job    ${job_name_test}    ${job_family_name}


The UI of Job data Section is same as design(empty state) (OL-T6050)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to    Client Setup
    When Turn on Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    Coffee family job    ${LOCATION_NAME_3}
    navigate to data job package section
    then Job Data show empty state
    click back job
    Delete a Job    ${job_name_test}    ${job_family_name}


The number of locations remain in Job Data equal to the number in Job Detail(empty state) (OL-T6051)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    ${count_location} =    Get number location remain on job package data
    navigate to data job package section
    element should contain    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_HEADER_LOCATION}    ${count_location}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


Job Data section when no locations have been selected in the Available Locations section yet in Job Details (OL-T6052)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}
    click on span text    Add Details
    Check element display on screen    ${NEW_JOB_MESS_ERROR_NOT_ASSIGNED_LOCATION}
    element text should be    ${NEW_JOB_MESS_ERROR_NOT_ASSIGNED_LOCATION}
    ...    You must have locations assigned to this job before adding details.


Check Job Data section when do not select any Job Data Package (OL-T6053)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    Add location for job    Test_Location_2
    navigate to data job package section
    add job package and config location    ${test_location_name}
    Click at    ${NEW_JOB_DATA_PACKAGE_ADD_MORE}
    Then Job Data section is Showed
    Check element display on screen    New Details
    Check element display on screen    Select job data package
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


The list Job Data Package is Updated when adding other Job Data Package (OL-T6054, OL-T6055, OL-T6056)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    and Go to job data packages page
    ${job_data_package} =    Add 1 Job Data Package
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    and Click add job data package and click select package type
    Then The list will show that Job Data Package has just been added    ${job_data_package}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}
    and Go to job data packages page
    delete job data package by search    ${job_data_package}
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    and Click add job data package and click select package type
    ${item_job_data} =    format string    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_LIST_HAS_NAME}    ${job_data_name}
    check element not display on screen    ${item_job_data}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


Check when Selecting just only one option (OL-T6057, OL-T6058)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    and Click add job data package and click select package type
    select job data package and verify attribute    ${job_data_test_age}    ${job_data_test_age_attribute}
    Click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE}
    select job data package and verify attribute    ${job_data_test_senior_level}
    ...    ${job_data_test_senior_level_attribute}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


List Attribute when selecting a Job Data Package (OL-T6059, OL-T6060)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    and Click add job data package and click select package type
    select job data package and verify attribute    ${job_data_test_age}    ${job_data_test_age_attribute}
    Verify display common text    10
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


List of attributes when that Job Job Package has more than 4 attributes (OL-T6061)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    and Click add job data package and click select package type
    select job data package and verify attribute    ${job_data_test_has_4_attributes}    ${job_data_test_age_attribute}
    check attribute is displayed    Job Function
    check attribute is displayed    Employment Type
    check attribute is displayed    Minimum Wage
    add job package and config location    ${test_location_name}
    check element display on screen    ${NEW_JOB_DATA_PACKAGE_VIEW_MORE}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


List of attributes when that Job Data Package has more less 5 attributes (OL-T6062, OL-T6063)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    and Click add job data package and click select package type
    select job data package and verify attribute    ${job_data_test_has_5_attributes}    Employment Type
    check attribute is displayed    Base Pay Maximum
    check attribute is displayed    Base Pay Minimum
    check attribute is displayed    Industry
    Check element display on screen    View More
    Click at    View More
    check attribute is displayed    ${job_data_test_age_attribute}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


List location available in Job Data (OL-T6064)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    ${count_location} =    Get number location remain on job package data
    navigate to data job package section
    and Click add job data package and click select package type
    add job package and config location    ${test_location_name}
    click close job package and back to job page
    Delete a Job    ${job_name_test}    ${job_family_name}


List location when removing one location at Job detail (OL-T6065)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    ${count_location} =    Get number location remain on job package data
    navigate to data job package section
    and Click add job data package and click select package type
    add job package and config location    ${test_location_name}
    click on span text    Edit Locations
    Delete location on overview job tab
    element text should be    ${NEW_JOB_MESS_ERROR_NOT_ASSIGNED_LOCATION}
    ...    You must have locations assigned to this job before adding details


List location when adding one location at Job detail (OL-T6066)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name}
    ${count_location} =    Get number location remain on job package data
    navigate to data job package section
    then check element display on screen    ${ADD_LOCATION_POPUP}


The whole of area is selected in the Job Detail (all locations in that area are selected). then Add more one location in that area in the location Management (OL-T6067)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_area_name}
    navigate to data job package section
    add job package and config location    ${test_location_area_name}
    click on span text    Done
    ${url_job} =    Get Location
    when go to location management page
    ${location_new} =    set variable    Location_date_job_package_new
    and Add a Location    ${test_location_area_name}    ${location_new}
    and go to    ${url_job}
    click on span text    Edit
    Check element display on screen    ${NEW_JOB_DATA_PACKAGE_LOCATION_LIST}    ${location_new}
    when click close job package and back to job page
    and Delete a Job    ${job_name_test}    ${job_family_name}
    then go to location management page
    Delete a Location    ${location_new}


Btn Save when no location is selected (OL-T6068, OL-T6069)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name_second}
    navigate to data job package section
    element should be disabled    ${NEW_JOB_DATA_PACKAGE_SAVE}
    select location for job data package    ${test_location_name_second}
    element should be enabled    ${NEW_JOB_DATA_PACKAGE_SAVE}
    when click close job package and back to job page
    and Delete a Job    ${job_name_test}    ${job_family_name}


Can select multiple locations (OL-T6070)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    ${test_location_name_second}
    Add location for job    ${test_location_name}    ${true}
    navigate to data job package section
    select location for job data package    ${test_location_name_second}
    select location for job data package    ${test_location_name}
    Check element display on screen    ${NEW_JOB_DATA_PACKAGE_LOCATION_ITEM_NAME}    ${test_location_name_second}
    Check element display on screen    ${NEW_JOB_DATA_PACKAGE_LOCATION_ITEM_NAME}    ${test_location_name}
    when click close job package and back to job page
    and Delete a Job    ${job_name_test}    ${job_family_name}


Select all locations case (OL-T6071)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Navigate to    Client Setup
    when Turn On Job Data Package Toggle
    when Go to Jobs page
    ${job_name_test} =    Make a job has config location    ${job_family_name}    Select all
    navigate to data job package section
    select location for job data package    Select all
    ${count_location_item} =    get element count    ${NEW_JOB_DATA_PACKAGE_LOCATION_ITEM}
    should be true    ${count_location_item} >= 4
    when click close job package and back to job page
    and Delete a Job    ${job_name_test}    ${job_family_name}
