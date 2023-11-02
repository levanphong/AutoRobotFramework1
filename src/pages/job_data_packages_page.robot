*** Settings ***
Variables       ../locators/job_data_packages_locators.py
Resource        ../pages/base_page.robot


*** Keywords ***
Job data pakages page is display
    Check element display on screen    ${MENU_JOB_DATA_PACKAGES}
    Check element display on screen    ${INPUT_SEARCH_JOB_DATA}
    Check element display on screen    Created Packages
    element should be enabled    ${JOB_DATA_PACKAGE_CREATE_PACKAGE}
    Check element display on screen    Last Edited
    Check element display on screen    ${JOB_DATA_PACKAGE_JOB_DATA_LABEL}

Input default job data attribute
    [Arguments]     ${attribute_value_1}=None        ${attribute_value_2}=None
    IF  '${attribute_value_1}' == 'None'
        ${attribute_value_1}=    set variable  22
    END
    IF  '${attribute_value_2}' == 'None'
        ${attribute_value_2}=    set variable  22
    END
    input value data package    Base Pay Minimum    ${attribute_value_1}
    input value data package    Base Pay Maximum    ${attribute_value_2}

select job data attribute
#SELECT JOB DATA ATTRIBUTE AND INPUT THE VALUE DATA
    [Arguments]    ${package_name}    ${attribute}=None  ${attribute_value}=None
    input text    ${INPUT_PACKAGE_NAME_MODAL}    ${package_name}
    Input default job data attribute
    IF    '${attribute_value}' == 'None'
        ${attribute_value}=    set variable  22
    END
    IF  '${attribute}' != 'None'
        search attribute   ${attribute}
        Click at    ${ATTRIBUTE_TYPE}    ${attribute}
        click on span text    Apply
        input value data package    ${attribute}    ${attribute_value}
    END
    click create data job package on modal

click create data job package on modal
  click at    ${BUTTON_CREATE_ON_MODAL}
  wait for page load successfully

input value data package
#INPUT VALUE DATA ON MODAL BY INDEX
    [Arguments]    ${type}    ${value}
    ${data_locator}=    Format String    ${INPUT_ENTER_VALUE_DATA_MODAL}    ${type}
    input text    ${data_locator}    ${value}

search job package
    [Arguments]    ${job_package_name}
    ${is_exist} =    Run Keyword And Return Status    wait until element is visible    ${JOB_DATA_PACKAGE_INPUT_SEARCH}
    IF    ${is_exist}
        input into    ${JOB_DATA_PACKAGE_INPUT_SEARCH}    ${job_package_name}
    END
    wait for page load successfully

search and click job package
    [Arguments]    ${job_package_name}
    search job package    ${job_package_name}
    wait with short time
    click at    ${job_package_name}

add new job package
    [Arguments]    ${job_package_name}    ${attribute}=None  ${attribute_value}=None
    click at    ${BUTTON_CREATE_PACKAGE}
    click at    ${BUTTON_ADD_JOB_DATA}
    select job data attribute    ${job_package_name}    ${attribute}    ${attribute_value}

input job package name and select number of attributes
    # CHECK IF JOB DATA PACKAGE IS EXIST AND INPUT NUMBER OF ATTRIBUTES
    [Arguments]    ${job_package_name}    ${number}
    search job package    ${job_package_name}
    ${data_locator}=    Format String    ${COMMON_TEXT}    ${job_package_name}
    ${is_existed}=    Run Keyword And Return Status    Check element display on screen    ${data_locator}
    IF    '${is_existed}' == 'False'
        click at    ${BUTTON_CREATE_PACKAGE}
        input text    ${INPUT_PACKAGE_NAME_MODAL}    ${job_package_name}
        # SELECT 3 ATTRIBUTES
        Search select type and input value attribute    Base Pay Maximum    22
        Search select type and input value attribute    Base Pay Minimum    23
        Search select type and input value attribute    Employment Type    22
        IF    '${number}' == '4'
            Search select type and input value attribute    Minimum Age    18
        END
        IF    '${number}' == '5'
            Search select type and input value attribute    Industry    18
            Search select type and input value attribute    Job Function    18
        END
        click at    ${BUTTON_CREATE_ON_MODAL}
    END

Search select type and input value attribute
#SELECT TYPE AND INPUT VALUE ATTRIBUTE
    [Arguments]    ${type}    ${value}
    click at    ${BUTTON_ADD_JOB_DATA}
    search attribute    ${type}
    Click at    ${ATTRIBUTE_TYPE}    ${type}
    click on span text    Apply
    input value data package    ${type}    ${value}

check and create job data package
#    CHECK IF JOB DATA PACKAGE IS EXISTING BEFORE CREATE JOB DATA PACKAGE HAS 1 ATTRIBUTE
    [Arguments]    ${job_package_name}    ${attribute_auto}
    search job package    ${job_package_name}
    ${data_locator}=    Format String    ${COMMON_TEXT}    ${job_package_name}
    ${is_existed}=    Run Keyword And Return Status    Check element display on screen    ${data_locator}
    IF    '${is_existed}' == 'False'
        add new job package    ${job_package_name}    ${attribute_auto}
    END

Make a job has config location
    [Arguments]    ${job_family_name_var}    ${location_name}=${None}
    ${job_random}=    Generate Random String    4
    ${job_name_random}=    format string    ${job_name}{}    ${job_random}
    Create new job    ${job_family_name_var}    ${job_name_random}    False
    Input Job name    ${job_name_random}
    IF    '${location_name}' != '${None}'
        Add location for job    ${location_name}
    END
    [Return]    ${job_name_random}

Get number location remain on job package data
    ${count}=    Get Element Count    ${NEW_JOB_LOCATION_ADDED}
    [Return]    ${count}

Job Data section is Showed
    ${attribute_age}=    format string    ${COMMON_DIV_TEXT}    Minimum Age
    check element display on screen    ${attribute_age}
    check element display on screen    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_CLOSE_ICON}
    check element display on screen    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_HEADER_LOCATION}
    Check element display on screen    Select job data package

Job Data section is Hided
    ${add_detail_job_package}=    format string    ${COMMON_SPAN_TEXT}    Add Details
    check element not display on screen    ${add_detail_job_package}

Job Data show empty state
    click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE}
    check element not display on screen    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_ITEM}

Add 1 Job Data Package
    ${data_random}=    Generate Random String    4
    ${job_datan_pk_random}=    format string    Test_job_data_package_unit_{}    ${data_random}
    click at    ${}
    input into    ${NEW_JOB_DATA_PACKAGE_INPUT_SEARCH}    ${job_datan_pk_random}
    click at    ${BUTTON_ADD_JOB_DATA}
    click at    ${NEW_JOB_DATA_PACKAGE_ATTRIBUTE_AGE}
    click at    ${NEW_JOB_DATA_PACKAGE_BTN_APPLY}
    input into    ${NEW_JOB_DATA_PACKAGE_INPUT_ATTRIBUTE_DEAFUT_VALUE}    10
    click at    ${NEW_JOB_DATA_PACKAGE_BTN_CREATE}
    [Return]    ${job_datan_pk_random}

The list will show that Job Data Package has just been added
    [Arguments]    ${job_data_name}
    ${item_job_data}=    format string    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_LIST_HAS_NAME}    ${job_data_name}
    check element display on screen    ${item_job_data}

select job data package and verify attribute
    [Arguments]    ${job_data_name}    ${attribute_name}
    Click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_LIST_HAS_NAME}    ${job_data_name}
    Verify display common text    ${attribute_name}

check attribute is displayed
    [Arguments]    ${attribute_name}
    Verify display common text    ${attribute_name}

Click ${BUTTON_ADD_JOB_DATA} package and click select package type
    click on span text    Add Details
    click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE}

search and click job data package
    [Arguments]    ${data_package_name}
    Go to job data packages page
    search job package  ${data_package_name}
    click at    ${JOB_DATA_PACKAGE_NAME}  ${data_package_name}
    wait for page load successfully

delete job data package by search
    [Arguments]    ${data_package_name}
    Go to job data packages page
    search job package    ${data_package_name}
    ${data_item_job}=    format string    ${JOB_DATA_PACKAGE_ITEM_FOUND}    ${data_package_name}
    hover at    ${data_package_name}
    click at    ${data_item_job}
    click at    ${JOB_DATA_PACKAGE_MENU_DELETE}
    click at    ${JOB_DATA_PACKAGE_DELETE_CONFIRM}

add job package and config location
    [Arguments]    ${location}
    click at    ${NEW_JOB_DATA_PACKAGE_ADD_LOCATION}
    ${location_checkbo}=    format string    ${NEW_JOB_DATA_PACKAGE_LOCATION_CHECKBOX}    ${location}
    click at    ${location_checkbo}
    click at    ${NEW_JOB_DATA_PACKAGE_LOCATION_APPLY}
    click at    ${NEW_JOB_DATA_PACKAGE_SAVE}

disable editing in job
    [Arguments]    ${job_package_name}      ${jdp_attribute}
    search and click job package    ${job_package_name}
    element should be disabled    ${BUTTON_SAVE_MODAL}
    click at    ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}        ${jdp_attribute}
    click on common text last    Disable editing in Jobs
    click at    ${BUTTON_SAVE_MODAL}

Go to job data package and override disable job package
    [Arguments]    ${job_package_name}      ${jdp_attribute}
    Go to job data packages page
    search and click job package    ${job_package_name}
    wait for page load successfully
    click at    ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}    ${jdp_attribute}
    click on common text last    Disable editing in Jobs
    click at    ${BUTTON_OVERWRITE_ALL}
    click at    ${BUTTON_CONFIRM_OVERRIDE_ATTRIBUTE}

delete attribute
    [Arguments]    ${attribue}
    click at  ${ECLIPSE_BUTTON_EDIT_JOB_PACKAGE_MODAL}  ${attribue}
    Click on common text last   Delete Attribute

search attribute
  [Arguments]    ${attribue}
  input text    ${INPUT_SEARCH_JOB_DATA_MODAL}     ${attribue}
  wait for page load successfully

Click at Pay Frequency dropdown by type
    [Arguments]     ${attribute_type}       ${type_number}
    ${attribute_type_locators}=     Format String    ${JOB_DATA_PACKAGE_SELECT_CURRENCY_AND_TIME_FOR_ATTRIBUTE_OPTION}       ${attribute_type}       ${type_number}
    Click at    ${attribute_type_locators}

Check value display by currency and time option
    [Arguments]     ${attribute_type}     ${value}      ${type_number}
    ${locator}=     Format String    ${JOB_DATA_PACKAGE_VALUE_DISPLAY_BY_CURRENCY_AND_TIME_OPTION}       ${attribute_type}       ${value}       ${type_number}
    Check element display on screen     ${locator}

Add a job data
    [Arguments]     ${attribute_type}
    click at    ${BUTTON_ADD_JOB_DATA}
    search attribute    ${attribute_type}
    Click at  ${ATTRIBUTE_TYPE}    ${attribute_type}    wait_time=5s
    click on span text    Apply
    wait for page load successfully
