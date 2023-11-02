*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/job_data_packages_page.robot
Variables           ../../../locators/job_data_packages_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lts_stg    mchire    olivia    stg    stg_mchire    dev    dev2     test

*** Variables ***
${offer_name}=                  Automation job
${job_family_name}=             Coffee family job
${test_location_name}=          ${LOCATION_NAME_2}
${attribute_default_1}=         Base Pay Maximum
${job_code}=                    JOB_CODE_123

#Turn on Job Data Packages on Client setup https://nimb.ws/B9Ojg7
#Select All Available Job Types https://nimb.ws/B9Ojg7


*** Test Cases ***
Check list view at Job Data column in Job Data page page will be changed display as all Attribute Names that are in the package (OL-T14722,OL-T6095,OL-T6097)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    and go to client setup page
    Turn On Job Data Package Toggle
    Go to job data packages page
    Job data pakages page is display


Check disabled Save button on Create new Data Package Drawer (OL-T14723)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    click at    ${BUTTON_CREATE_PACKAGE}
    check span display    Create New Data Package
    check element display on screen    ${BUTTON_ADD_JOB_DATA}
    Check element display on screen    Included Job Data
    element should be disabled    ${BUTTON_CREATE_ON_MODAL}
    element should be enabled    ${BUTTON_CANCEL_ON_MODAL}
    ${job_package_name}=    Generate random name    job_package_auto
    click at    ${BUTTON_ADD_JOB_DATA}
    select job data attribute    ${job_package_name}
#    Check the ellipses to the right of each attribute value on Edit Data Package drawer (OL-T14724)
    element should be enabled    ${BUTTON_EDIT_JOB_PACKAGE}
#    Check selected Delete Attribute on the ellipses to the right of each attribute value on Edit Data Package drawer (OL-T14725)
    delete job data package by search    ${job_package_name}


Check seleted Disable editing in Jobs on the ellipses to the right of each attribute value on Edit Data Package drawer (OL-T14726)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
#    click at    ${BUTTON_CREATE_PACKAGE}
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    search and click job package    ${job_package_name}
    click at    ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}    ${attribute_default_1}
    click on common text last    Disable editing in Jobs
    element should be enabled    ${ICON_LOCKED_MODAL}
#    Check seleted Enable editing in Jobs on the ellipses to the right of each attribute value on Edit Data Package drawer (OL-T14727)
    click at    ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}    ${attribute_default_1}
    click on common text last   Enable editing in Jobs
    Check element not display on screen    ${ICON_LOCKED_MODAL}     wait_time=5s
    Click at    ${BUTTON_CANCEL_ON_MODAL}
#    Check Overwite All button doesn't appear on Edit Data Package Drawer if Job Data Package isn't being used in any jobs (OL-T14732)
    delete job data package by search    ${job_package_name}


Check Overwrite All button appear on the bottom left of the drawer IF user is editing a Job Data Package that is being used in at least one job and the user has made at least one change to the Included Job Data section (OL-T14728)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    search and click job package    ${job_package_name}
    click at    ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}    ${attribute_default_1}
    click on common text last    Disable editing in Jobs
    Check element not display on screen    ${BUTTON_OVERWRITE_ALL}
#    Check Overwrite All button doesn't appear on the bottom left of the drawer IF user is editing a Job Data Package that isn't being used in at least one job and the user has made at least one change to the Included Job Data section (OL-T14729)
    ${job_name}=    Generate random name    auto_job
    create a job using job data package    ${job_name}    ${job_package_name}
    Go to job data packages page
    search and click job package    ${job_package_name}
    wait for page load successfully
#    Check Overwrite All button doesn't appear on the bottom left of the drawer IF user is editing the Job Data Package name (OL-T14730)
    ${package_name_update}=    Generate random name    job_package_auto
    clear element text    ${INPUT_PACKAGE_NAME_MODAL}
    input text    ${INPUT_PACKAGE_NAME_MODAL}    ${package_name_update}
    click at    ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}    ${attribute_default_1}
    click on common text last    Disable editing in Jobs
#    Check clicked Overwite All button on Edit Data Package Drawer if Job Data Package is being used in at least one job (OL-T14731)
    click at    ${BUTTON_OVERWRITE_ALL}
    Check element display on screen    Are you sure you want to overwrite all
    Check element display on screen    Overwriting will automatically update all jobs currently using this package
    Check element display on screen    currently using this package
#   Check when click on Cancel button on Overwrite confirmation modal (OL-T14739)
    click at    ${BUTTON_CANCEL_OVERRIDE_ATTRIBUTE}
    and check element not display on screen    currently using this package
#    Check clicked Save buton instead of Overwrite All button on Edit Data Package Drawer (OL-T14733
    click at    ${BUTTON_SAVE_MODAL}
    Check element display on screen    Are you sure you want to save
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Check the Save confirmation modal will not appear for Save if the Overwrite button is not there on Edit Data Package Drawer (OL-T14734)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    disable editing in job    ${job_package_name}       ${attribute_default_1}
    delete job data package by search    ${job_package_name}


Check the error message when the Package Name field is blank. (OL-T14735)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    search and click job package    ${job_package_name}
    and clear element text with keys    ${INPUT_PACKAGE_NAME_MODAL}
    click at    ${BUTTON_SAVE_MODAL}
    check span display    Package name is required to save
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search    ${job_package_name}


Check the error message Check the error message When the same Package Name already exists. (OL-T14736)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    add new job package    ${job_package_name}
    check span display    Package name must be unique
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search    ${job_package_name}


Check the error message When a value field is blank. (OL-T14738,OL-T6115)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    search and click job package    ${job_package_name}
    and clear element text with keys    ${INPUT_ENTER_VALUE_DATA_MODAL}  Base Pay Maximum
    click at    ${BUTTON_SAVE_MODAL}
    Check element display on screen    You must enter a value
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search    ${job_package_name}


Check Overwrite All function with Draft Job (OL-T14740)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    search and click job package    ${job_package_name}
    ${job_name}=    Generate random name    auto_job
#    ADD A JOB USING DATA PACKAGE, STATUS DRAF
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Add detail job data package    ${job_package_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    Add Candidate Journey for job   Default Candidate Journey
    Click at    ${SAVE_JOB_BUTTON}
    add screening question for job
#    GO TO DATA PACKAGE PAGE AND OVERRIRE ATTRIBUTE
    Go to job data package and override disable job package    ${job_package_name}   ${attribute_default_1}
#    OPEN JOB AND CHECK ATTRIBUTE IS DISABLED
    Open job and check attribue is disabled    ${job_name}   ${job_package_name}  ${test_location_name}
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Check Overwrite All function with Unpublish Changes Job (OL-T14741)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
#    CREATE JOB PACKAGE NAME
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
#    CREATE JOB USING JOB PACKAGE, STATUS UNPUBLISH
    ${job_name}=    Generate random name    auto_job
    create a job using job data package    ${job_name}    ${job_package_name}
    go to jobs page
    search and click job name   ${job_name}    ${job_family_name}
    Input into    ${INPUT_JOB_CODE}    ${job_code}
    Click at    ${SAVE_JOB_BUTTON}
#    DISABLE JOB PACKAGE AND OVERWRITE
    Go to job data package and override disable job package    ${job_package_name}      ${attribute_default_1}
#    OPEN JOB AND CHECK ATTRIBUTE IS DISABLED
    Open job and check attribue is disabled    ${job_name}   ${job_package_name}  ${test_location_name}
    delete a job    ${job_name}    ${job_family_name}
#   Verify Delete JDP (OL-T16114)
    delete job data package by search    ${job_package_name}


Check Overwrite All function with Published Job (OL-T14742)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
#    create job data package
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
#    create job using job data package
    ${job_name}=    Generate random name    auto_job
    create a job using job data package    ${job_name}    ${job_package_name}
#   Check Additional Details section appear in Job builder if Job Data Packages is turned ON in Client Setup (OL-T15385)
    go to jobs page
    search and click job name    ${job_name}    ${job_family_name}
    wait for page load successfully
    Check element display on screen    ${BUTTON_EDIT_DETAILS}
#    DISABLE JOB PACKAGE AND OVERWRITE
    Go to job data package and override disable job package    ${job_package_name}      ${attribute_default_1}
#    OPEN JOB AND CHECK ATTRIBUTE IS DISABLED
    Open job and check attribue is disabled    ${job_name}   ${job_package_name}  ${test_location_name}
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


Check Company Admins can view and edit this page (OL-T6098,OL-T6118,OL-T6119)
    user can view and editable job data package  Company Admin


Check Franchise Owners can view and edit this page (OL-T6098)
    user can view and editable job data package  Franchise Owner


Check Franchise Staff can view and edit this page (OL-T6098)
    user can view and editable job data package  Franchise Staff


user Full User - Edit Everything can not view job data package (OL-T6099)
    user can not view job data package  Full User - Edit Everything


user Full User - Edit Nothing can not view job data package (OL-T6099)
    user can not view job data package  Full User - Edit Everything


user Recruiter can not view job data package (OL-T6099)
    user can not view job data package  Recruiter


user Supervisor can not view job data package (OL-T6099)
    user can not view job data package  Supervisor


user Hiring Manager can not view job data package (OL-T6099)
    user can not view job data package  Hiring Manager


Check drawer when click Create Packages btn (OL-T6101,OL-T6102,OL-T6103)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    click at    ${BUTTON_CREATE_PACKAGE}
    check element display on screen  Create New Data Package
    check element display on screen   Included Job Data
    check element display on screen   ${BUTTON_ADD_JOB_DATA}
    Verify element is disable  ${BUTTON_CREATE_ON_MODAL}
    click at  ${BUTTON_ADD_JOB_DATA}
    search attribute     ${attribute_default_1}
    Click at    ${ATTRIBUTE_TYPE}    ${attribute_default_1}
    click at  ${BUTTON_APPLY_ADD_JOB_DATA}
    input value data package    ${attribute_default_1}    22
    Verify element is disable  ${BUTTON_CREATE_ON_MODAL}


Create Btn is disabled when do not add any Data Package (OL-T6104)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    click at    ${BUTTON_CREATE_PACKAGE}
    ${job_package_name}=    Generate random name    job_package_auto
    input text    ${INPUT_PACKAGE_NAME_MODAL}    ${job_package_name}
    wait with short time
    Verify element is disable  ${BUTTON_CREATE_ON_MODAL}


Check when click on Add Job Data btn (OL-T6105,OL-T6107,OL-T6108,OL-T6109,OL-T6165)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    click at    ${BUTTON_CREATE_PACKAGE}
    click at  ${BUTTON_ADD_JOB_DATA}
    search and verify the attribue is display  Base Pay Maximum
    search and verify the attribue is display  Base Pay Minimum
    search and verify the attribue is display  Employment Type
    search and verify the attribue is display  Industry
    search and verify the attribue is display  Job Function
    search and verify the attribue is display  Minimum Age
    search and verify the attribue is display  Minimum Wage
    search and verify the attribue is display  Seniority Level
    ${attribue}=    Generate random name    job_package_auto
    search attribute    ${attribue}
    check element not display on screen    ${ATTRIBUTE_TYPE}    ${attribue}
    search attribute     Base Pay Maximum
    Click at    ${ATTRIBUTE_TYPE}    Base Pay Maximum
    click on span text    Apply
    click at  ${BUTTON_ADD_JOB_DATA}
    search attribute     Base Pay Maximum
    Verify element is disable   ${CHECKBOX_ATTRIBUTE_TYPE}     Base Pay Maximum


Check when select all Job Attribute Name (OL-T6106,OL-T6110,OL-T6111,OL-T6112,OL-T6113)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    click at    ${BUTTON_CREATE_PACKAGE}
    ${attribue} =    Set variable    Base Pay Maximum
    ${job_package_name}=    Generate random name    job_package_auto
    input text    ${INPUT_PACKAGE_NAME_MODAL}    ${job_package_name}
    Search select type and input value attribute   ${attribue}    23
    check element display on screen  ${ATTRIBUTE_NAME_ADDED}  Base Pay Maximum
    Search select type and input value attribute    Base Pay Minimum    22
    check element display on screen  ${ATTRIBUTE_NAME_ADDED}  Base Pay Minimum
    click create data job package on modal
    search and click job package  ${job_package_name}
    click at    ${BUTTON_ADD_JOB_DATA}
    search attribute    ${attribue}
    check element display on screen  ${COMMON_TEXT_LAST}  used in this package
    delete attribute  ${attribue}
    Search select type and input value attribute   ${attribue}    22
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search  ${job_package_name}


Data Package is not saved in case Close or Cancel button is clicked (OL-T6114)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    click at    ${BUTTON_CREATE_PACKAGE}
    ${job_package_name}=    Generate random name    job_package_auto
    click at    ${BUTTON_ADD_JOB_DATA}
    search attribute   ${attribute_default_1}
    Click at    ${ATTRIBUTE_TYPE}    ${attribute_default_1}
    click on span text    Apply
    input value data package    ${attribute_default_1}   22
    click at  ${BUTTON_CANCEL_ON_MODAL}
    check element not display on screen  ${BUTTON_ADD_JOB_DATA}


Create succesfully with Value of Attribute is any character (OL-T6117)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    ${attribute_value}=  set variable  @35642Z!
    add new job package    ${job_package_name}    ${attribute_default_1}  ${attribute_value}
    Go to job data packages page
    delete job data package by search  ${job_package_name}


There is scroll when having a lot of rows (OL-T6120,OL-T6121,OL-T6130,OL-T6132)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    scroll to element  ${JOB_DATA_PACKAGE_NAME}  ${job_package_name}
    search and click job data package   ${job_package_name}
    ${job_package_name_update}=    Generate random name    job_package_auto
    input text  ${INPUT_PACKAGE_NAME_MODAL}      ${job_package_name_update}
    click at  ${BUTTON_CREATE_ON_MODAL}
    delete job data package by search  ${job_package_name_update}


UI of edit page (OL-T6131)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    scroll to element  ${JOB_DATA_PACKAGE_NAME}  ${job_package_name}
    search and click job data package   ${job_package_name}
    check text display  Included Job Data
    check label display     Package Name
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search  ${job_package_name}


Check UI when value of fieds is long (OL-T6122,OL-T6123,OL-T6124,OL-T6125)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    ${data_random}=    Generate Random String    20
    ${attribute_value}=    format string    Test_job_data_package_unit_{}    ${data_random}
    click at    ${BUTTON_CREATE_PACKAGE}
    click at    ${BUTTON_ADD_JOB_DATA}
    select job data attribute    ${job_package_name}     ${attribute_default_1}  ${attribute_value}
    input into    ${JOB_DATA_PACKAGE_INPUT_SEARCH}   ${job_package_name}
    wait for page load successfully
    check element display on screen   ${JOB_DATA_PACKAGE_NAME}  ${job_package_name}
    delete job data package by search  ${job_package_name}


Search Job data package with incorrect value (OL-T6127)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${data_random}=    Generate Random String    20
    ${job_package_name}=    format string    Test_job_data_package_unit_{}    ${data_random}
    search job package    ${job_package_name}
    check text display  No packages found.


Duplicate that package once again (OL-T6128)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    Go to job data packages page
    search job package  ${job_package_name}
    hover at    ${JOB_DATA_PACKAGE_NAME}    ${job_package_name}
    click at    ${JOB_DATA_PACKAGE_ITEM_FOUND}    ${job_package_name}
    click at    ${JOB_DATA_PACKAGE_MENU_DUPLICATE}
    check p text display    Package has been duplicated successfully
    ${job_package_name_copy}=    format string    Copy - {}    ${job_package_name}
    delete job data package by search  ${job_package_name}
    delete job data package by search  ${job_package_name_copy}


Open edit page (OL-T6129)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    input into    ${JOB_DATA_PACKAGE_INPUT_SEARCH}    ${job_package_name}
    ${data_item_job}=    format string    ${JOB_DATA_PACKAGE_ITEM_FOUND}    ${job_package_name}
    click at    ${data_item_job}
    click at    ${JOB_DATA_PACKAGE_MENU_EDIT}
    wait for page load successfully
    check text display  Included Job Data
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search  ${job_package_name}


Search Job data package with correct job name being used (OL-T6126,OL-T6133,OL-T6134,OL-T6135,OL-T6136)
    [Tags]      skip
#   Todo maintain later
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    ${job_name}=    Generate random name    auto_job
    ${location}=    set variable    ${LOCATION_NAME_2}
#    create a job using job data package
    create job data packgage and job basic multi location using job data package    ${job_package_name}    ${job_name}
    Go to job data packages page
#    Can search job data package by input job name
    search job package    ${job_name}
    check element display on screen   ${JOB_DATA_PACKAGE_NAME}  ${job_package_name}
    click at    ${JOB_DATA_PACKAGE_NAME}  ${job_package_name}
    wait for page load successfully
#    Job used is display on job data package modal
    check span display  Jobs and locations using this package - 2 jobs
#    check location of job is display on job data package modal
    click on common text last   ${job_name}
    wait for page load successfully
    check element display on screen     ${LOCATION_USED_ON_MODAL}     ${location}
#    Can not delete job data package when have job using it
    Go to job data packages page
    search job package    ${job_package_name}
    click at    ${JOB_DATA_PACKAGE_ITEM_FOUND}    ${job_package_name}
    click at    ${JOB_DATA_PACKAGE_MENU_DELETE}
    check span display  Cannot Delete Package
    check p text display    Please remove all assignments of this package in the Job Data section of Jobs before you can delete it here.
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete a job    ${job_name}    ${job_family_name}
    delete job data package by search    ${job_package_name}


*** Keywords ***
user can view and editable job data package
    [Arguments]    ${userRole}
    Given Setup test
    when Login into system with company   ${userRole}   ${COMPANY_FRANCHISE_ON}
    Go to job data packages page
    Job data pakages page is display
    ${job_package_name}=    Generate random name    job_package_auto
    add new job package    ${job_package_name}
    delete job data package by search    ${job_package_name}

user can not view job data package
    [Arguments]    ${userRole}
    Given Setup test
    when Login into system with company   ${userRole}   ${COMPANY_FRANCHISE_ON}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${SETTING_ICON}
    check element not display on screen  Job Data Packages

search and verify the attribue is display
    [Arguments]    ${attribue}
    input text    ${INPUT_SEARCH_JOB_DATA_MODAL}    ${attribue}
    wait for page load successfully
    check element display on screen    ${ATTRIBUTE_TYPE}    ${attribue}
