*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/job_data_packages_page.robot
Resource            ../../../pages/location_management_page.robot
Resource            ../../../pages/my_jobs_page.robot
Variables           ../../../locators/job_data_packages_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${job_family_name}                      Coffee family job
${test_location_name}                   ${CONST_LOCATION}
${job_template}                         template_multi_location
${attribute_auto}                       Base Pay Maximum
${job_data_package_has_4_attributes}    job_data_package_has_4_attributes

*** Test Cases ***
Check Additional Details section appear in Job template builder if Job Data Packages is turned ON in Client Setup (OL-T15386)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_template}=    Generate random name    job_template
    create a job template multi-location    ${job_template}
    go to jobs page
    Click at    Job Template
    click at    ${job_template}
    wait for page load successfully
    Check element not display on screen    ${BUTTON_EDIT_DETAILS}
    delete a job template    ${job_template}


Check Additional Details section does not show in Job builder if Job Data Packages is turned OFF in Client Setup (OL-T15387)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_name}=    Set variable    basic_multi_location_data_package
    go to jobs page
    check and create job Basic Multi-Location    ${job_name}    ${job_family_name}    ${test_location_name}
    go to jobs page
    search and click job name    ${job_name}    ${job_family_name}
    wait for page load successfully
    Check element not display on screen    ${BUTTON_EDIT_DETAILS}   wait_time=5s


Check Additional Details section doesn't show in Job template builder if Job Data Packages is turned OFF in Client Setup (OL-T15388)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${job_template}=    set variable    job_template_data_package
    create a job template multi-location    ${job_template}
    go to jobs page
    Click at    Job Template
    click at    ${job_template}
    wait for page load successfully
    Check element not display on screen    ${BUTTON_EDIT_DETAILS}


Check the error message under Additional Details section when user tries to click on the Add Details button if no Location is available in the Job (OL-T15389)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Create new job with type    ${job_family_name}    ${TYPE_MULTI_LOCATION}
    ${job_name}=    generate random name    auto_job
    Input Job name    ${job_name}
    click at    ${BUTTON_EDIT_DETAILS}
    check span display    You must have locations assigned to this job before adding


Check new UI of Add Additional details drawer for Legacy Multi-Location Job (OL-T15390)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #    check and create job data package
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    Add job data package to details
    click at    Add Details
    Check element display on screen    ${LOCATION_REMAINING_DETAILS}
    Check element display on screen    ${SEARCH_ADDITIONAL_DETAILS}
    select job data package on the modal add details    ${job_package_name}
    Check element display on screen    ${BASE_PAY_MAXIMUM_DETAILS}
    Check element display on screen    Assign the above data to the desired locations
    click at    ${ADD_LOCATION_BTN_DETAILS}
    Click at    ${LOCATION_SELECT_ALL_CHECKBOX}
    Click at    ${APPLY_BTN_DETAILS}
    wait with large time
    Click at    ${NEW_JOB_DATA_PACKAGE_SAVE}
    wait with short time
    Check element display on screen    ${job_package_name}
    Click at    ${DONE_BTN_DETAILS}
    ${locator}=    format string    ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
    Check element display on screen    ${locator}
    delete a job    ${job_name}    ${job_family_name}


Check Job data Package card on Additional Details drawer when adding JDP that has more than 4 attribute (OL-T15391)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_has_5_attributes
    #    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    Add job data package to details
    click at    Add Details
    click at    ${DROPDOWN_SELECT_JOB_DATA_PACKAGE_DETAILS}
    input text    ${SEARCH_DATA_PACKAGE_DETAILS}    ${job_package_name}
    wait for page load successfully
    click at    ${job_package_name}
    click on span text    View More
    Check element display on screen    Job Function
    click on span text    View Less
    check element not display on screen    Job Function
    delete a job    ${job_name}    ${job_family_name}


Check Job data Package card on Additional Details drawer when adding JDP that has 4 attribute (OL-T15392)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_has_4_attributes
    #    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    Add job data package to details
    click at    Add Details
    click at    ${DROPDOWN_SELECT_JOB_DATA_PACKAGE_DETAILS}
    input text    ${SEARCH_DATA_PACKAGE_DETAILS}    ${job_package_name}
    wait for page load successfully
    click at    ${job_package_name}
    check element not display on screen    View More
    delete a job    ${job_name}    ${job_family_name}


Check Job data Package card on Additional Details drawer when adding JDP that has less than 4 attributes (OL-T15393)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_has_3_attributes
    #    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    Add job data package to details
    click at    Add Details
    click at    ${DROPDOWN_SELECT_JOB_DATA_PACKAGE_DETAILS}
    input text    ${SEARCH_DATA_PACKAGE_DETAILS}    ${job_package_name}
    wait for page load successfully
    click at    ${job_package_name}
    Check element display on screen    Base Pay Maximum
    Check element display on screen    Base Pay Minimum
    Check element display on screen    Employment Type
    delete a job    ${job_name}    ${job_family_name}


Check when saving Additional Details with a Job data Package (OL-T15394)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    Add job data package to details
    Add detail job data package    ${job_package_name}
#    select all locations
    click at    ${ADD_LOCATION_BTN_DETAILS}
    Click at    ${LOCATION_SELECT_ALL_CHECKBOX}
    Click at    ${APPLY_BTN_DETAILS}
    wait with short time
    Click at    ${NEW_JOB_DATA_PACKAGE_SAVE}
    wait with short time
    Check element display on screen    0 Locations Remaining
    Click at    ${DONE_BTN_DETAILS}
    ${locator}=    format string    ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
    Check element display on screen    ${locator}
    delete a job    ${job_name}    ${job_family_name}


Check when Saving Additional Details with multiple Job data Packages (OL-T15395)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Add Hiring Team for job
    setup candidate journey and add screen question
#    add 1 job data package with 1 location
    click at    Overview
    Add detail job data package    ${job_package_name}
    add location on job data package modal    ${LOCATION_NAME_2}
#    add more data package
    click at    Add More Details
    select job data package on the modal add details    job_data_package_has_4_attributes
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
    ${locator}=    format string    ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
#   Verify can save Additional details section if user has made a save at a JDP detail card and the close the additional details drawer (OL-T16254)
    Check element display on screen    ${locator}
#    Basic multiple-location type:Verify publish job when assign all location to additional details section (OL-T16104)
    PUBLISH JOB
    delete a job    ${job_name}    ${job_family_name}


Verify Search function at Additional Details drawer(JDP name/location name) (OL-T16257)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name_1}=    Set variable    job_data_package_1
    ${job_package_name_2}=    Set variable    job_data_package_has_4_attributes
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    add 1 job data package with 1 location
    click at    Add Details
#   Verify search function at add JDP dropdown (OL-T16256)
    select job data package on the modal add details    ${job_package_name_1}
    add location on job data package modal    ${LOCATION_NAME_2}
        #    add more data package
    click at    Add More Details
    select job data package on the modal add details    ${job_package_name_2}
    add location on job data package modal    Select all
    check element display on screen    ${JOB_DATA_PACKAGE_NAME_DETAILS}    ${job_package_name_2}
#    List location already assigned in job data (OL-T6077)
    check location assigned to correct job data package  ${job_package_name_1}  ${LOCATION_NAME_2}
    check location assigned to correct job data package  ${job_package_name_2}  ${LOCATION_NAME_3}
    element should be disabled  ${SEARCH_ADDITIONAL_DETAILS}
     Click at    ${DONE_BTN_DETAILS}
    click at    ${BUTTON_EDIT_DETAILS}
#    verify search job data package on modal
    click at    ${SEARCH_ADDITIONAL_DETAILS}
    input text    ${SEARCH_ADDITIONAL_DETAILS}    ${job_package_name_1}
    check element display on screen    ${JOB_DATA_PACKAGE_NAME_DETAILS}    ${job_package_name_1}
    delete a job    ${job_name}    ${job_family_name}


Job Data Packages can only be assigned once. (OL-T6078)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #    check and create job data package
    ${job_package_name_1}=    Set variable    job_data_package_1
    ${job_package_name_2}=    Set variable    job_data_package_has_4_attributes
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    add 1 job data package with 1 location
    click at    Add Details
    select job data package on the modal add details    ${job_package_name_1}
    add location on job data package modal    ${LOCATION_NAME_2}
    click at    Add More Details
    click at    ${DROPDOWN_SELECT_JOB_DATA_PACKAGE_DETAILS}
    input text    ${SEARCH_DATA_PACKAGE_DETAILS}    ${job_package_name_1}
    Click by JS   ${COMMON_TEXT_LAST}   ${job_package_name_1}
    Check element not display on screen     Base Pay Maximum    wait_time=5s
    delete a job    ${job_name}    ${job_family_name}


Get Error message when publish job if There are still more locations aren't assigned to JDP on the job (OL-T15396)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
    Add Hiring Team for job
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    Hiring Manager
    add screening question for job
#    add 1 job data package with 1 location
    click at    Overview
    Add detail job data package    ${job_package_name}
#Check when Searching location name (OL-T6072)
    add location on job data package modal    ${LOCATION_NAME_2}
    Click at    ${DONE_BTN_DETAILS}
#    Check when Saving a Job data (OL-T6073)
    check element display on screen  ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
    wait with short time
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${PUBLISH_JOB_BUTTON}
#    If user add at least one assignment in the Job Data section and do not add all locations (OL-T6084)
    check span display  You must assign details to all locations
    delete a job    ${job_name}    ${job_family_name}


Verify Get Error message when publish multiple-location type job if There are still more locations aren't assigned to JDP on the job (OL-T16105)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#   create a job multi - location using job data package has 3 locations
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_MULTI_LOCATION}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    setup candidate journey and add screen question
#   add 1 job data package with 1 location
    click at    Overview
#   Check scroll when have many Job Data (OL-T6074)
    Add detail job data package    ${job_package_name}
    add location on job data package modal    ${LOCATION_NAME_2}
    Click at    ${DONE_BTN_DETAILS}
    ${locator}=    format string    ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
    Check element display on screen    ${locator}
    wait with short time
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${PUBLISH_JOB_BUTTON}
    check span display  You must assign details to all locations
    delete a job    ${job_name}    ${job_family_name}


multiple-location type:Verify publish job when assign all location to additional details section (OL-T16106)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_MULTI_LOCATION}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    setup candidate journey and add screen question
#    add 1 job data package with 1 location
    click at    Overview
    Add detail job data package    ${job_package_name}
    add location on job data package modal    ${LOCATION_NAME_2}
#    add more data package
    click at    Add More Details
    select job data package on the modal add details    job_data_package_has_4_attributes
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
    ${locator}=    format string    ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
    Check element display on screen    ${locator}
#    If user add at least one assignment in the Job Data section and 0 location remain (OL-T6083)
    publish job
#    Verify removing 1 loction of a JDP card (OL-T16111)
#Check when user remove 1 location for a job data (OL-T6093)
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    click at    ${JOB_DATA_PACKAGE_ON_MODAL_EDIT}    job_data_package_has_4_attributes
    click at    ${ICON_DELETE_LOCATION_ON_MODAL_EDIT}    ${LOCATION_NAME_3}
    Click at    ${NEW_JOB_DATA_PACKAGE_SAVE}
#List location available in job data (OL-T6076)
    check element display on screen    ${NUMBER_OF_LOCATION_REMAINING_DETAILS}    1 Location Remaining
    delete a job    ${job_name}    ${job_family_name}


Standard type:Verify publish job when add JDP (OL-T16108)
    #TODO https://paradoxai.atlassian.net/browse/OL-79875
    [Tags]      skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    ${test_location_name_1}=    Set variable    ${LOCATION_NAME_2}
    add location for job standard    ${test_location_name_1}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    setup candidate journey and add screen question
#    add 1 job data package with 1 location
    click at    Overview
    wait for page load successfully
    click at    Add Details
    select job data package on the modal add details    ${job_package_name}
    publish job
#    Verify update additional detail to other JDP (OL-T16110)
    click at    Overview
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    select job data package on the modal add details    job_data_package_has_4_attributes
    delete a job    ${job_name}    ${job_family_name}


Verify can't save JDP card when removing all loction of a JDP card (OL-T16112)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a multi-location job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_MULTI_LOCATION}
#    add 1 job data package with all location
    Add detail job data package    ${job_package_name}
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    click at    ${JOB_DATA_PACKAGE_ON_MODAL_EDIT}    ${job_package_name}
    click at    ${ICON_DELETE_LOCATION_ON_MODAL_EDIT}    ${LOCATION_NAME_3}
    click at    ${ICON_DELETE_LOCATION_ON_MODAL_EDIT}    ${LOCATION_NAME_2}
    click at    ${ICON_DELETE_LOCATION_ON_MODAL_EDIT}    Amsterdam
    element should be disabled    ${NEW_JOB_DATA_PACKAGE_SAVE}
    delete a job    ${job_name}    ${job_family_name}


Verify add more location to JDP card (OL-T16113)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a multi-location job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_MULTI_LOCATION}
#    add 1 job data package with all location
    Add detail job data package    ${job_package_name}
    add location on job data package modal    ${LOCATION_NAME_2}
    Click at    ${DONE_BTN_DETAILS}
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    click at    ${JOB_DATA_PACKAGE_ON_MODAL_EDIT}    ${job_package_name}
    add location on job data package modal    ${LOCATION_NAME_3}
    wait with short time
    Click at    ${DONE_BTN_DETAILS}
    delete a job    ${job_name}    ${job_family_name}


Verify search for location at location tree (OL-T16255)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    ${test_location_name_1}=    Set variable    ${LOCATION_NAME_2}
    add location for job    ${test_location_name_1}
    delete a job    ${job_name}    ${job_family_name}


Verify add JDP that has attributes selecting Disable editing in Jobs (OL-T16258)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
#    create job data package disable editing in job
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    disable editing in job    ${job_package_name}       ${attribute_auto}
#    add job using job data package disable editing in job
    ${job_name}=    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    ${location}=    set variable    ${LOCATION_NAME_2}
    Add location for job    ${location}
    Add detail job data package    ${job_package_name}
    add location on job data package modal    ${location}
    click at    ${ICON_ARROW_DOWN_JOB_DATA_DETAILS}    ${job_package_name}
    click at    ${ICON_ARROW_DOWN_LOCATION_DETAILS}    ${location}
    hover at    ${ICON_LOCKED_DETAILS}    ${location}
#    Verify text Unable to edit value
    Check element display on screen    Unable to edit value
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Verify add JDP that has attributes not selecting Disable editing in Jobs (OL-T16259)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
#    create job data package and not select disable editing in job
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
#    add job using job data package disable editing in job
    ${job_name}=    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    ${location}=    set variable    ${LOCATION_NAME_2}
    Add location for job    ${location}
    Add detail job data package    ${job_package_name}
    add location on job data package modal    ${location}
    click at    ${ICON_ARROW_DOWN_JOB_DATA_DETAILS}    ${job_package_name}
    click at    ${ICON_ARROW_DOWN_LOCATION_DETAILS}    ${location}
    click at    ${INPUT_VALUE_ATTRIBUTE_DETAILS}
#    Verify when saving package detail card with the value of attribute is null (OL-T16260)
    clear element text with keys    ${INPUT_VALUE_ATTRIBUTE_DETAILS}
    click at    ${BUTTON_SAVE_SELECT_DATA_PACKAGE}
    check span display    You must enter a value
    #    Edit value attribute
    input text    ${INPUT_VALUE_ATTRIBUTE_DETAILS}    ${job_package_name}
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Verify JDP details in job if user makes overwrite all at Job data package page (OL-T16261)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    ${job_name}=    Generate random name    auto_job
       ${location}=    set variable    ${LOCATION_NAME_2}
    create job data packgage and job basic multi location using job data package    ${job_package_name}    ${job_name}
#    disable edit in job and override all
    Go to job data package and override disable job package    ${job_package_name}      ${attribute_auto}
#    Open job and check status job is Published
    check status job    ${job_name}    ${job_family_name}
#    Open job and check attribute is disabled
    Open job and check attribue is disabled    ${job_name}     ${job_package_name}  ${location}
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Verify JDP details in job if user makes save without overwrite all at Job data package page (OL-T16262)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    ${job_name}=    Generate random name    auto_job
    create job data packgage and job basic multi location using job data package    ${job_package_name}    ${job_name}
#    edit attribute in job data package
    Go to job data packages page
    search and click job package    ${job_package_name}
    wait for page load successfully
    input value data package    ${attribute_auto}    33
    click at    ${BUTTON_OVERWRITE_ALL}
    click at    ${BUTTON_CONFIRM_OVERRIDE_ATTRIBUTE}
#    Open job and check status job is Published
    check status job    ${job_name}    ${job_family_name}
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Verify that the entire location of a area are assigned to a JDP and then add more location to location available (OL-T16263)
    #TODO https://paradoxai.atlassian.net/browse/OL-79913
    [Tags]      skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#   create a job using job data package
    ${job_name}=    generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    ${test_location_name_1}=    Set variable    ${LOCATION_NAME_2}
    ${test_location_name_2}=    Set variable    ${LOCATION_NAME_3}
    ${test_location_name_3}=    Set variable    Amsterdam
    add location for job    ${test_location_name_1}
    Click edit and add location for job    ${test_location_name_2}
#   Add job data package to details,select all locations
    Add detail job data package    ${job_package_name}
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
    wait for page load successfully
#   Back to add location, add more location
    Click edit and add location for job    ${test_location_name_3}
#   open additional detail and check location is available
    click at    ${BUTTON_EDIT_DETAILS}
#   Location remain when adding more location in job Data (OL-T6075)
#   Check when user add a location for job data (OL-T6092)
    check element display on screen    ${NUMBER_OF_LOCATION_REMAINING_DETAILS}    1 Location Remaining
    delete a job    ${job_name}    ${job_family_name}


The Job Data Package will be enabled again if you delete the Job Data contains this Job Data Package (OL-T6079)
    # TODO  https://paradoxai.atlassian.net/browse/OL-77743
    [Tags]      skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name_1}=    Set variable    job_data_package_1
    ${job_package_name_2}=    Set variable    job_data_package_has_4_attributes
#    create a job using job data package
    ${job_name}=    generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_BASIC_MULTI_LOCATION}
#    add 1 job data package with 1 location
    click at    Add Details
    select job data package on the modal add details    ${job_package_name_1}
    add location on job data package modal    ${LOCATION_NAME_2}
#    add other job data
    click at    Add More Details
    select job data package on the modal add details    ${job_package_name_2}
    add location on job data package modal    Select all
     Click at    ${DONE_BTN_DETAILS}
#     delete the first job data
    click at    ${BUTTON_EDIT_DETAILS}
    click at    ${ICON_DELETE_JOB_DATA_ON_MODAL_EDIT}  ${job_package_name_1}
    click at    ${BUTTON_DELETE_JOB_PACKAGE_CONFIRM_MODAL}
#    verify can add more job data which has been deleted
    click at    Add More Details
    select job data package on the modal add details    ${job_package_name_1}
    delete a job    ${job_name}    ${job_family_name}


Remove location under folder to the job in Job Details (OL-T6080)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
#    check and create job data package    ${job_package_name}    Base Pay Maximum
    ${job_name}=    Generate random name    auto_job
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_MULTI_LOCATION}
    input job name    ${job_name}
    ${location}=    set variable    ${LOCATION_NAME_2}
    Add location for job    ${location}
    Add detail job data package    ${job_package_name}
    click at    ${ADD_LOCATION_BTN_DETAILS}
    check element display on screen  ${SELECT_LOCATION_BY_NAME_DETAILS}    ${location}
    click at    ${COMMON_TEXT_LAST}  Cancel
    wait with short time
    click at    ${COMMON_TEXT_LAST}  Cancel
    click at    ${EDIT_LOCATION_BUTTON}
    click at    ${ICON_DELETE_LOCATION}  ${location}
    click at    ${COMMON_TEXT_LAST}  Delete
    click at    ${COMMON_TEXT_LAST}  Save
    click at    Add Details
    check span display   You must have locations assigned to this job before adding detail
    delete a job    ${job_name}    ${job_family_name}


Remove all locations that assigned to the package in the job data (OL-T6081)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
    ${job_name}=    Generate random name    auto_job
    create new job and select 3 locations  ${job_name}  ${TYPE_MULTI_LOCATION}
    click at    Add Details
#    add job data package , assign to all locations
    select job data package on the modal add details    ${job_package_name}
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
#    back to list location,delete all locations
    click at    ${EDIT_LOCATION_BUTTON}
    delete a location on job overview which already used in job data package  ${LOCATION_NAME_2}
    delete a location on job overview which already used in job data package  ${LOCATION_NAME_3}
    delete a location on job overview which already used in job data package  Amsterdam
    click at    ${COMMON_TEXT_LAST}  Save
#    check job data package not display anymore
    and check element not display on screen   ${ADDITIONAL_DETAILS_USE_IN}    ${job_package_name}
    delete a job    ${job_name}    ${job_family_name}


Create new job data after Removing locations that assigned to the package in the job data (OL-T6082)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
    ${job_name}=    Generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_MULTI_LOCATION}
    click at    Add Details
#    add job data package , assign to all locations
    select job data package on the modal add details    ${job_package_name}
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
#    back to list location,delete all locations
        click at    ${EDIT_LOCATION_BUTTON}
    click at    ${ICON_DELETE_LOCATION}  ${LOCATION_NAME_2}
    click at    ${COMMON_TEXT_LAST}  Delete
    click at    ${COMMON_TEXT_LAST}  Save
#    check job data package not display the deleted location anymore
    click at  Overview
    click at    ${BUTTON_EDIT_DETAILS}
    ${locator} =  format string  ${LOCATION_ASSIGNED_ON_JOB_DATA_PACKAGE}  ${job_package_name}
    element should not contain   ${locator}   ${LOCATION_NAME_2}
    delete a job    ${job_name}    ${job_family_name}


Publish job has Location is added to Job after job is published (OL-T6085)
    #TODO https://paradoxai.atlassian.net/browse/OL-79919
    [Tags]      skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    set variable    job_package_auto
    ${job_name}=    Generate random name    auto_job
#    Create job data, create job using job data and publish
#    Publish job has 1 Job Data when a Location is added to area folder, and this area folder has been assigned to Job before (OL-T6086)
    create job data packgage and job basic multi location using job data package    ${job_package_name}    ${job_name}
#    Add one more location
     click at    Overview
    click edit and add location for job  ${LOCATION_NAME_3}
    wait with short time
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${PUBLISH_JOB_BUTTON}
    wait with large time
#    Check error need to assigns details to all locations before publish
    check span display  You must assign details to all locations
    delete a job    ${job_name}    ${job_family_name}


Check when user edit Job data package for a job data (OL-T6094)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
    ${job_name}=    Generate random name    auto_job
    create new job and select 3 locations    ${job_name}    ${TYPE_MULTI_LOCATION}
    click at    Add Details
#    add job data package , assign to all locations
    select job data package on the modal add details    ${job_package_name}
    add location on job data package modal    Select all
    Click at    ${DONE_BTN_DETAILS}
    click at    ${BUTTON_EDIT_DETAILS}
    click at    ${COMMON_TEXT_LAST}  ${job_package_name}
    select job data package on the modal add details    ${job_data_package_has_4_attributes}
    delete a job    ${job_name}    ${job_family_name}


Check this toggle will be default to be OFF (OL-T6096)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    and go to client setup page
    Click at    ${HIRE_LABEL}
    check element not display on screen  ${JOBS_TOGGLE}
    check element not display on screen  ${JOB_DATA_PACKAGES_ON}


If a user tries to toggle on Location for Job in My Jobs, but that Location does not have a Job Data Package assigned to it (OL-T6088)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Set variable    job_data_package_1
    ${area}=    generate random name    auto_area_
    ${test_location_name_1}=    generate random name    ${CONST_LOCATION}_
    ${test_location_name_2}=    generate random name    ${CONST_LOCATION}_
    ${job_name}=    generate random name    auto_job
#    Go to location page, create area folder have 2 locations
    go to location management page
    add new area     ${COMPANY_FRANCHISE_ON}	${area}
    add new location to area    ${area}     ${test_location_name_1}
    add new location to area    ${area}     ${test_location_name_2}
    go to jobs page
#    Over view section,select 2 locarions
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    Add area folder location for job   ${area}
#    add 2 job data package assign to 2 location
    click at    Overview
    Add detail job data package    ${job_package_name}
    Add location on job data package modal    ${test_location_name_1}   ${area}
    click at    ${NEW_JOB_DATA_PACKAGE_ADD_MORE}
    select job data package on the modal add details    ${job_data_package_has_4_attributes}
    Add location on job data package modal    ${test_location_name_2}   ${area}
    Click at    ${DONE_BTN_DETAILS}
    wait for page load successfully
    Add Hiring Team for job
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    Hiring Manager
    add screening question for job
    publish job
#    Go to location management page, added 1 location to area folder Washinton
    go to location management page
    ${test_location_name_3}=     generate random name    ${CONST_LOCATION}_
    add new location to area  ${area}   ${test_location_name_3}
#    Go to my job page, try to turn on my job
    go to my jobs page
    search job in location    ${job_name}    ${test_location_name_3}
    click at    ${JOB_FOR_ACTIVE_TOGGLE}    ${job_name}
    Check span display  Missing Job Data
    Check element display on screen  ${ASSIGN_JOB_DATA_BUTTON_MODAL_MY_JOB}
    Capture page screenshot
    click at  ${CANCEL_BUTTON_MODAL_MY_JOB}
    wait for page load successfully v1
#    Delete job and locations after TC
    go to jobs page
    delete a job  ${job_name}       ${job_family_name}
    go to location management page
    delete location   ${test_location_name_1}
    delete location   ${test_location_name_2}
    delete location   ${test_location_name_3}
    delete location   ${area}

*** Keywords ***
create new job and select 3 locations
    [Arguments]    ${job_name}    ${type}
    go to jobs page
    Create new job with type    ${job_family_name}    ${type}
    input job name    ${job_name}
    ${test_location_name_1}=    Set variable    ${LOCATION_NAME_2}
    ${test_location_name_2}=    Set variable    ${LOCATION_NAME_3}
    ${test_location_name_3}=    Set variable    Amsterdam
    Click at    ${ADD_LOCATION_BUTTON}
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    Click at    ${LOCATION_IN_JOB}    ${test_location_name_1}
    Click at    ${LOCATION_IN_JOB}    ${test_location_name_2}
    Click at    ${LOCATION_IN_JOB}    ${test_location_name_3}
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait with short time
    Check element display on screen    ${test_location_name_1}
    Check element display on screen    ${test_location_name_2}
    Check element display on screen    ${test_location_name_3}

check location assigned to correct job data package
    [Arguments]    ${job_package_name}  ${location}
    ${locator} =  format string  ${LOCATION_ASSIGNED_ON_JOB_DATA_PACKAGE}  ${job_package_name}
    element should contain   ${locator}  ${location}

delete a location on job overview which already used in job data package
  [Arguments]    ${location}
    click at    ${ICON_DELETE_LOCATION}  ${location}
    click at    ${COMMON_TEXT_LAST}  Delete
