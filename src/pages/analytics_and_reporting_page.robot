*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/analytics_and_reporting_locators.py

*** Keywords ***
Create a report
    [Arguments]    ${category}=Admin      ${report}=Location Detail     ${frequency}=One-time    ${sort}=None    ${available_field}=None    ${exclude_field}=None    ${filter}=None   ${custom_name}=None
    Go To Analytics And Reporting Page
    Click At    Create New Report
    # Set type report
    Set Type Report    ${category}  ${report}   ${frequency}
    # Set fields report
    Set Fields Report    ${sort}    ${available_field}     ${exclude_field}
    # Set Filter Report
    Set filter report   ${filter}
    # set delivery report
    ${report_name} =    Set Delivery Report    ${custom_name}
    IF  '${report_name}' == 'None'
        ${report_name} =    Set Variable    ${category}:${report}
    END
    # Set Summary report
    Click At  ${CREATE_NEW_REPORT_NAV_BUTTON}  Finish and Send Now
    Check Element Display On Screen    ${CREATE_NEW_REPORT_SUCCESS_MESSAGE}
    Click At    ${CREATE_NEW_REPORT_SUCCESS_MESSAGE_OK_BUTTON}
    [Return]    ${report_name}

Set type report
    [Arguments]    ${category}      ${report}      ${frequency}
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}    ${category}
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}      ${report}
    Click At    ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN_VALUE}   ${frequency.type_frequency}
    Click At    ${CREATE_NEW_REPORT_NAV_BUTTON}  Next

Set fields report
    [Arguments]    ${sort}=None    ${available_field}=None   ${exclude_field}=None
    IF  "${sort}" != "None"
        Click At    ${CREATE_NEW_REPORT_FIELDS_NAV_BUTTON}      Sorting
        Click At    Add Sorting
        Click At    ${CREATE_NEW_REPORT_SORT_DROPDOWN}
        Input Into    ${CREATE_NEW_REPORT_SORT_INPUT}   ${sort}
        Click At    ${CREATE_NEW_REPORT_SORT_DROPDOWN_VALUE}    ${sort}
    END
    IF  "${available_field}" != "None"
        Click At    ${CREATE_NEW_REPORT_FIELDS_NAV_BUTTON}    Field Selection
        Click At    ${CREATE_NEW_REPORT_SEARCH_AVAILABLE_INPUT}
        FOR    ${field}    IN    @{available_field}
            Input into     ${CREATE_NEW_REPORT_SEARCH_AVAILABLE_INPUT}    ${field}
            Click at       ${CREATE_NEW_REPORT_PATTERN_AVAILABLE_RESULT}    ${field}
        END
    END
    IF  "${exclude_field}" != "None"
        Click At    ${CREATE_NEW_REPORT_FIELDS_NAV_BUTTON}    Field Selection
        FOR  ${field}    IN    @{exclude_field}
            Click At    ${CREATE_NEW_REPORT_PATTERN_DELETE_FIELD_BUTTON}    ${field}
        END
    END
    Click At  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next

Set filter report
    [Arguments]    ${filter}=None
    IF  "${filter}" != "None"
        Click At    ${CREATE_NEW_REPORT_ADD_FILTER_BUTTON}
        Click At    ${CREATE_NEW_REPORT_PATTERN_FILTER_TYPE_RESULT}     ${filter.type}
        Click At    ${CREATE_NEW_REPORT_PATTERN_FILTER_CONDITION}   ${filter.condition}
        Input Into    ${CREATE_NEW_REPORT_PATTERN_FILTER_CONDITION_INPUT}       ${filter.value}       ${filter.condition}
        Click At    ${CREATE_NEW_REPORT_PATTERN_FILTER_APPLY_BUTTON}
    END
    Click At  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next

Set delivery report
    [Arguments]    ${custom_name}=None
    IF  '${custom_name}' != 'None'
        ${report_name} =   Generate Random Name Only Text    ${custom_name}
        Click at    ${CREATE_NEW_REPORT_INPUT_NAME_REPORT}
        Press Keys    ${CREATE_NEW_REPORT_INPUT_NAME_REPORT}    CTRL+a+BACKSPACE   ${report_name}
    ELSE
        ${report_name} =  Set Variable    None
    END
    Click At  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next
    [Return]    ${report_name}

Delete reports
    [Arguments]    ${name_list}    ${type}=One-time
    Click at    ${REPORT_TAB_NAV_BUTTON}    ${type}
    FOR    ${name}    IN    @{name_list}
        Scroll to element    ${REPORT_ONE_TIME_PATTERN_FILENAME}    ${name}
        Click by JS    ${REPORT_ONE_TIME_PATTERN_ACTION_BUTTON}    ${name}
        Click at    ${REPORT_ONE_TIME_DELETE_BUTTON}
        Click at    ${REPORT_ONE_TIME_DELETE_CONFIRM_YES_NO}    Yes
        wait for page load successfully v1
    END
