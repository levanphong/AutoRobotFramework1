*** Settings ***
Resource            ../../../pages/jobs_page.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/job_data_packages_page.robot
Resource            ../../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        lts_stg     regression

Documentation    Create 2 job data package: job_data_package_location_edit and Job_data_package_location

*** Variables ***
${job_data_employment_type}          Employment Type
${base_pay_minimum_type}             Base Pay Minimum
${base_pay_maximum_type}             Base Pay Maximum
${number_1}                          1
${number_2}                          2
${currency_eur}                      EUR
@{list_time}                         Per Hour     Per Week      Per Month       Per Year
${week_value}                        Week
${canadian_dollar_currency_text}     Canadian dollar
${currency_usd}                      USD
${time_hour}                         Hour
${value_65000}                       65.000
${job_name_location}                 Job_data_package_location
${job_name_location_edit}            job_data_package_location_edit_attribute
${characters_value}                  @sixty

*** Test Cases ***
Check adding unsuccessfully incase no input data to 'Packages Name' textbox (OL-T30292, OL-T30411, OL-T30412)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check element display on screen     ${base_pay_minimum_type}
    Check value attribute is display default    ${base_pay_minimum_type}     ${currency_usd}
    Check value attribute is display default    ${base_pay_maximum_type}     ${currency_usd}
    Check value attribute is display default    ${base_pay_minimum_type}     ${time_hour}
    Check value attribute is display default    ${base_pay_maximum_type}     ${time_hour}
    click at    ${BUTTON_ADD_JOB_DATA}
    search attribute    ${job_data_employment_type}
    Click at    ${ATTRIBUTE_TYPE}    ${job_data_employment_type}
    click on span text    Apply
    Verify element is disable   ${BUTTON_CREATE_ON_MODAL}
    Capture page screenshot


Check adding unsuccessfully incase no add any attribute into Job Data (OL-T30293)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Input into    ${INPUT_PACKAGE_NAME_MODAL}       package name
    Check element display on screen     ${base_pay_minimum_type}
    Verify element is disable   ${BUTTON_CREATE_ON_MODAL}
    Capture page screenshot


Check adding successfully incase input any data to 'Packages Name' textbox and add attribute into Job Data (OL-T30294, OL-T30306, OL-T30307,OL-T30311, OL-T30315)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    Input into      ${INPUT_PACKAGE_NAME_MODAL}     ${job_package_name}
    input value data package    ${base_pay_minimum_type}    ${value_65000}
    input value data package    ${base_pay_maximum_type}    ${value_65000}
    Search select type and input value attribute    ${job_data_employment_type}     ${number_1}
    Click at    ${BUTTON_CREATE_ON_MODAL}
    delete job data package by search       ${job_package_name}


Check adding any value at 'Pay Frequency' dropdown list at 'Base Pay Minimum' field (OL-T30296, OL-T30298, OL-T30300, OL-T30301, OL-T30303, OL-T30305)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Click at Pay Frequency dropdown by type      ${base_pay_minimum_type}    ${number_1}
    Click at    ${JOB_DATA_PACKAGE_SELECT_CURRENCY_AND_HOUR_VALUE}       Euro
    Check value display by currency and time option     ${base_pay_minimum_type}    ${currency_eur}      ${number_1}
    Check value display by currency and time option     ${base_pay_maximum_type}    ${currency_eur}      ${number_1}
    Click at Pay Frequency dropdown by type      ${base_pay_maximum_type}    2
    FOR     ${value}    IN      @{list_time}
        Check element display on screen     ${JOB_DATA_PACKAGE_SELECT_CURRENCY_AND_HOUR_VALUE}     ${value}
    END
    Capture page screenshot
    Click at Pay Frequency dropdown by type      ${base_pay_maximum_type}    1
    Click at    ${JOB_DATA_PACKAGE_SELECT_CURRENCY_AND_HOUR_VALUE}       Canadian dollar
    Check value display by currency and time option     ${base_pay_minimum_type}    CAD      ${number_1}
    Check value display by currency and time option     ${base_pay_maximum_type}    CAD      ${number_1}


Check adding unsuccessfully incase input data is not numerical characters into 'Base Pay Minimum' field (OL-T30308, OL-T30309, OL-T30312, OL-T30314)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    Input into      ${INPUT_PACKAGE_NAME_MODAL}     ${job_package_name}
    input value data package    ${base_pay_minimum_type}    200six
    Check element not display on screen     200six
    input value data package    ${base_pay_minimum_type}    sixMinimum
    Check element not display on screen     sixMinimum
    input value data package    ${base_pay_maximum_type}    six
    Check element not display on screen    six
    capture page screenshot
    ${value}=   Get Value And Format Text    ${JOB_DATA_PACKAGE_CURRENCY_NUMBER_VALUE}      ${base_pay_minimum_type}
    should not be equal as strings      ${value}    200six
    Capture page screenshot
    # T30314: Check Check adding unsuccessfully incase value of [Base Pay Minimum] field is greater than value of [Base Pay Maximum] field
    input value data package    ${base_pay_maximum_type}    100
    Click at    ${BUTTON_CREATE_ON_MODAL}
    Check element display on screen     Pay Exceeds Base Pay Maximum
    capture page screenshot


Check searching any value at 'Currency' dropdown list at 'Base Pay Maximum' field (OL-T30304, OL-T30299)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check element display on screen     ${base_pay_minimum_type}
    Click at Pay Frequency dropdown by type      ${base_pay_maximum_type}    1
    Input into      ${JOB_DATA_PACKAGE_SEARCH_CURRENCY_TEXTBOX}      ${canadian_dollar_currency_text}
    Check element display on screen      ${JOB_DATA_PACKAGE_SEARCH_CURRENCY_RESULT}  ${canadian_dollar_currency_text}
    Input into      ${JOB_DATA_PACKAGE_SEARCH_CURRENCY_TEXTBOX}      Not matching
    Check element not display on screen     ${JOB_DATA_PACKAGE_SEARCH_CURRENCY_RESULT}      Not matching
    capture page screenshot
    Input into      ${JOB_DATA_PACKAGE_SEARCH_CURRENCY_TEXTBOX}      CanaDian DolLaR
    Check element display on screen      ${JOB_DATA_PACKAGE_SEARCH_CURRENCY_RESULT}  ${canadian_dollar_currency_text}


Check adding successfully incase value of 'Base Pay Minimum' field is smaller than value of 'Base Pay Maximum' field (OL-T30316, OL-T30313, OL-T30310)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    Input into      ${INPUT_PACKAGE_NAME_MODAL}     ${job_package_name}
    input value data package    ${base_pay_minimum_type}    ${value_65000}
    Verify element is disable   ${BUTTON_CREATE_ON_MODAL}
    capture page screenshot
    input value data package    ${base_pay_maximum_type}    as75.000
    Click at    ${BUTTON_CREATE_ON_MODAL}
    delete job data package by search       ${job_package_name}


Check adding 'Base Pay Minimum' attribute successfully after removing it from the packages (OL-T30324, OL-T30328, OL-T30327)
    [Tags]      skip
    #Todo : https://paradoxai.atlassian.net/browse/OL-78058
    #Pay Rate is showed incorrectly when searching attribute at [Add Job Data] button
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Base Pay Minimum and Base Pay Maximum are display
    #T30327:Check incase remove [Base Pay Maximum] attribute from the packages
    delete attribute    ${base_pay_minimum_type}
    delete attribute    ${base_pay_maximum_type}
    Check element not display on screen     ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}  ${base_pay_minimum_type}
    Check element not display on screen     ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}  ${base_pay_maximum_type}
    Add a job data      ${base_pay_minimum_type}
    Add a job data      ${base_pay_maximum_type}
    Check Base Pay Minimum and Base Pay Maximum are display


Check editing successfully incase change frequency value at 'Base Pay Maximum' field (OL-T30319, OL-T30317, OL-T30320, OL-T30318)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_package_name}=    Generate random name    job_package_auto
    Input into      ${INPUT_PACKAGE_NAME_MODAL}     ${job_package_name}
    Input value for Base Pay Minimum and Base Pay Maximum and search job data package       10     15   ${job_package_name}
    Input value for Base Pay Minimum and Base Pay Maximum and search job data package       20     25   ${job_package_name}
    #Check Base pay minimum and maximum after edited
    ${value_min}=   Get value and format text    ${JOB_DATA_PACKAGE_CURRENCY_VALUE}     ${base_pay_minimum_type}
    Should be equal as strings    ${value_min}  20
    ${value_max}=   Get value and format text    ${JOB_DATA_PACKAGE_CURRENCY_VALUE}     ${base_pay_maximum_type}
    Should be equal as strings    ${value_max}  25
    capture page screenshot
    Click at    ${BUTTON_CANCEL_ON_MODAL}
    delete job data package by search       ${job_package_name}


Check UI of Base Pay Minimum and Base Pay Maximum attributes in Job Data Packages (OL-T30291, OL-T30295, OL-T30297)
    Login to system and go to job data package page     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Base Pay Minimum and Base Pay Maximum are display
    Click at Pay Frequency dropdown by type      ${base_pay_maximum_type}    2
    FOR     ${value}    IN      @{list_time}
        Check element display on screen     ${JOB_DATA_PACKAGE_SELECT_CURRENCY_AND_HOUR_VALUE}     ${value}
    END
    capture page screenshot


Check editing successfully incase change frequency value at 'Base Pay Maximum' field on the 'Additional Details' (OL-T30352, OL-T30347, OL-T30346, OL-T30348, OL-T30333, OL-T30354, OL-T30349)
    Login to system, go to job page and Click at edit additional details        ${job_name_location}    ${JF_COFFEE_FAMILY_JOB}
    # T30333
    Check value base pay minimum and maximum of job data package display at edit additional details     ${base_pay_minimum_type}     10
    Check value base pay minimum and maximum of job data package display at edit additional details     ${base_pay_maximum_type}     20
    Click at    ${ADDITIONAL_DETAILS_ARROW_MOVE_BUTTON_LOCATION_ICON}
    #Check currency base pay minimum will display correctly by  base pay maximum
    Select frequency option at location      ${base_pay_maximum_type}    1
    Select currency option by attribute type    ${canadian_dollar_currency_text}
    Check value currency and time display after select      ${base_pay_minimum_type}    CAD     1
    #Check currency base pay maximumwill display correctly by  base pay minimum
    Select frequency option at location      ${base_pay_minimum_type}    2
    #T30346
    FOR  ${value}   IN      @{list_time}
        Check element display on screen     ${ADDITIONAL_DETAILS_TIME_OPTION}       ${value}
    END
    capture page screenshot
    Click at    ${ADDITIONAL_DETAILS_TIME_OPTION}   Per Week
    #OL-T30349
    Check value time display by attribute type      ${base_pay_maximum_type}    ${week_value}
    capture page screenshot


Check editing successfully incase input data is only numerical characters and periods into 'Base Pay Minimum' field on the 'Additional Details' (OL-T30335, OL-T30334, OL-T30339, OL-T30341, OL-T30337, OL-T30345, OL-T30344)
    Login to system, go to job page and Click at edit additional details        ${job_name_location_edit}    ${JF_COFFEE_FAMILY_JOB}
    Click at    ${ADDITIONAL_DETAILS_ARROW_MOVE_BUTTON_LOCATION_ICON}
    #T30341,T30345
    Input into      ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}      ${characters_value}      ${base_pay_minimum_type}
    Check element not display on screen     ${characters_value}
    capture page screenshot
    #T30337
    Input into      ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}      ${characters_value}      ${base_pay_maximum_type}
    Check element not display on screen     ${characters_value}
    capture page screenshot
    ${value_min}=   Get value and format text    ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}     ${base_pay_minimum_type}
    Input into      ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}      ${value_min}      ${base_pay_minimum_type}
    Input into      ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}      ${value_min}      ${base_pay_maximum_type}
    capture page screenshot
    Publish job and go to job details       ${job_name_location_edit}    ${JF_COFFEE_FAMILY_JOB}
    # OL-T30344: Check pay min and max after edited
    Check value pay min and max display     ${value_min}    ${value_min}
    #T30335
    ${min_value}=    Get currency value by attribute type and plus one   ${base_pay_minimum_type}   1
    #T30339
    ${max_value}=    Get currency value by attribute type and plus one   ${base_pay_maximum_type}   2
    capture page screenshot
    Publish job and go to job details       ${job_name_location_edit}    ${JF_COFFEE_FAMILY_JOB}
    #Check pay min and max after edited
    Check value pay min and max display     ${min_value}    ${max_value}

*** Keyword ***
Login to system and go to job data package page
    [Arguments]     ${role}     ${company_name}
    Given Setup test
    when Login into system with company    ${role}     ${company_name}
    Go To Job Data Packages Page
    click at    ${BUTTON_CREATE_PACKAGE}

Check value attribute is display default
    [Arguments]     ${attribute_name}   ${value_default}
    ${locator}=     Format String    ${JOB_DATA_PACKAGE_CURRENCY_AND_TIME_VALUE_DEFAULT}    ${attribute_name}   ${value_default}
    Check element display on screen     ${locator}
    capture page screenshot

Check Base Pay Minimum and Base Pay Maximum are display
    Check element display on screen     ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}  ${base_pay_minimum_type}
    Check element display on screen     ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}  ${base_pay_maximum_type}

Input value for Base Pay Minimum and Base Pay Maximum and search job data package
    [Arguments]     ${min}      ${max}      ${job_package_name}
    input value data package    ${base_pay_minimum_type}    ${min}
    input value data package    ${base_pay_maximum_type}    ${max}
    Click at     ${BUTTON_CREATE_ON_MODAL}
    search and click job data package   ${job_package_name}

Login to system, go to job page and Click at edit additional details
    [Arguments]     ${job_name}     ${job_family_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    Go to Job detail    ${job_name}    ${job_family_name}
    Click at    ${OVERVIEW_STEP_ADD_DETAILS_BUTTON}
    Click at    ${ADDITIONAL_DETAILS_ARROW_MOVE_BUTTON_ICON}

Get currency value by attribute type and plus one
    [Arguments]     ${attribute_type}   ${value}
    ${value_min}=   Get value and format text    ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}     ${attribute_type}
    ${present_value_min}=    Convert to Integer     ${value_min}
    ${value_plus_one}=      evaluate    ${present_value_min}+${value}
    ${present_value_min_plus_one}=  Set variable    ${value_plus_one}
    Input into      ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}      ${present_value_min_plus_one}      ${attribute_type}
    [Return]    ${present_value_min_plus_one}

Publish job and go to job details
    [Arguments]     ${job_name}     ${job_family_name}
    Click at    ${ADDITIONAL_DETAILS_SAVE_BUTTON}
    Click at    ${ADDITIONAL_DETAILS_DONE_BUTTON}
    Publish job
    Go to Jobs page
    Go to Job detail    ${job_name}    ${job_family_name}
    Click at    ${OVERVIEW_STEP_ADD_DETAILS_BUTTON}
    Click at    ${ADDITIONAL_DETAILS_ARROW_MOVE_BUTTON_ICON}
    Click at    ${ADDITIONAL_DETAILS_ARROW_MOVE_BUTTON_LOCATION_ICON}

Check value pay min and max display
    [Arguments]     ${min_value}    ${max_value}
    ${value_min_present}=   Get value and format text    ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}     ${base_pay_minimum_type}
    Should be equal as strings    ${min_value}      ${value_min_present}
    ${value_max_present}=   Get value and format text    ${ADDITIONAL_DETAILS_CURRENCY_VALUE_DISPLAY}     ${base_pay_maximum_type}
    Should be equal as strings    ${max_value}      ${value_max_present}
    capture page screenshot
