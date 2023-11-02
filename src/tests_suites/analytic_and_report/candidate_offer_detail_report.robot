*** Settings ***
Resource            ../../pages/analytics_and_reporting_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          test

*** Variables ***
@{users}                                ${FO_TEAM}    ${CA_TEAM}    ${TEAM_USER}    ${FS_TEAM}    ${EE_TEAM}    ${RP_TEAM}
${category}                             Hire
${report}                               Candidate Offer Details
&{frequency}                            type_frequency=One-time
@{static_fields}                        Offer Type    Offer Template Name    Offer Version    Job Title    Job Req ID    Location Name    Location ID    Current Candidate Journey Status    Candidate ID    Profile ID    Candidate Name    Candidate Email    Candidate Phone Number    Current Offer Status    Offer Sent Date    Offer Viewed Date    Offer Accepted Date    Offer Declined Date    Starting Pay Rate    Start Date    Offer Expired On    Offer Canceled On    Offer ID
@{allowed_deleted_static_fields}        Offer Version    Job Title    Job Req ID    Location Name    Location ID    Current Candidate Journey Status    Profile ID    Candidate Name    Candidate Phone Number    Offer Viewed Date    Offer Accepted Date    Offer Declined Date    Starting Pay Rate    Start Date    Offer Expired On    Offer Canceled On    Offer ID
@{disalowed_deleted_static_fields}      Offer Type    Offer Template Name    Candidate ID    Current Offer Status    Offer Sent Date
@{dynamic_fields}                       Brand Name    Brand External ID

*** Test Cases ***
Verify that Candidate Offer Details report is visibility and report name is correctly on Analytics & Reporting page, Verify that desciption of Candidate Offer Details report is display correctly(OL-T11716, OL-T11717)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go To Analytics And Reporting Page
    Click At    Create New Report
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}    ${category}
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    # Verify that candidate offer details report is visibility
    Check Element Display On Screen     ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}      ${report}
    Capture Page Screenshot
    # Verify that description of candidate offer details report is display correctly
    ${locator} =    Format String       ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE_DESCRIPTION}      Candidate Offer Details     Detailed report showing all offer details per offer per candidate.
    Check Element Display On Screen     ${locator}
    Capture Page Screenshot
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}      ${report}
    Click At    ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN_VALUE}       ${frequency.type_frequency}
    Click At    ${CREATE_NEW_REPORT_NAV_BUTTON}     Next
    Click At    ${CREATE_NEW_REPORT_NAV_BUTTON}     Next
    Click At    ${CREATE_NEW_REPORT_NAV_BUTTON}     Next
    Click At    ${CREATE_NEW_REPORT_NAV_BUTTON}     Next
    # Verify report name is Candidate Offer Details
    Element Should Contain      ${CREATE_NEW_REPORT_FILE_NAME}      Candidate Offer Details
    Capture Page Screenshot


Verify that report visibility following these permision: - Paradox Admin - Company Admin - Franchise Owner - Franchise Staff - Edit Everything - Reporting User (OL-T11718)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Analytics And Reporting Page
    FOR  ${user}    IN      @{users}
        Switch To User      ${user}
        Click At    Create New Report
        Verify Candidate Offer Detail Report Visibility
        Click At    ${CREATE_NEW_REPORT_BACK_TO_BUTTON}
        Click At    ${CREATE_NEW_REPORT_DISCARD_BUTTON}
    END


Verify that header title of report file is display correctly, Verify that export file sucessfully and display blank when no exist data in database, Verify that name of report file is display correctly (OL-T11719, OL-T11720, OL-T11724)
    Given Setup Test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${header_report_default} =      Create List     Offer Type      Offer Template Name     Offer Version       Job Title       Job Req ID      Location Name       Location ID     Current Candidate Journey Status    Candidate ID    Profile ID      Candidate Name      Candidate Email     Candidate Phone Number      Current Offer Status    Offer Sent Date     Offer Viewed Date       Offer Accepted Date     Offer Declined Date     Starting Pay Rate       Start Date      Offer Expired On    Offer Canceled On       Offer ID
    ${header_report_dynamic} =      Create List     Offer Type      Offer Template Name     Offer Version       Job Title       Job Req ID      Location Name       Location ID     Current Candidate Journey Status    Candidate ID    Profile ID      Candidate Name      Candidate Email     Candidate Phone Number      Current Offer Status    Offer Sent Date     Offer Viewed Date       Offer Accepted Date     Offer Declined Date     Starting Pay Rate       Start Date      Offer Expired On    Offer Canceled On       Offer ID    Brand Name
    &{frequency} =      Create Dictionary       type_frequency=One-time
    &{filter} =     Create Dictionary       type=Location ID    condition=is    value=ooo
    ${availabel_field} =    Create List     Brand Name
    # create reports
    ${report_name_1} =      Create a report     ${category}     ${report}       ${frequency}    custom_name=OL-T11719
    ${report_name_2} =      Create a report     ${category}     ${report}       ${frequency}    available_field=${availabel_field}      custom_name=OL-T11719
    ${report_name_3} =      Create a report     ${category}     ${report}       ${frequency}    custom_name=OL-T11719       filter=${filter}
    # download reports
    Click At    ${REPORT_TAB_NAV_BUTTON}    One-time
    Click At    ${REPORT_ONE_TIME_PATTERN_DOWNLOAD_BUTTON}      ${report_name_1}
    Wait with medium time
    Click At    ${REPORT_ONE_TIME_PATTERN_DOWNLOAD_BUTTON}      ${report_name_2}
    Wait with medium time
    # Verify that header title of report file is display correct
    ${file_name_report_1} =     Get Text And Format Text    ${REPORT_ONE_TIME_PATTERN_FILENAME}     ${report_name_1}
    ${file_name_report_2} =     Get Text And Format Text    ${REPORT_ONE_TIME_PATTERN_FILENAME}     ${report_name_2}
    ${file_downloads_name_report_1} =       get_download_path       ${file_name_report_1}
    ${file_downloads_name_report_2} =       get_download_path       ${file_name_report_2}
    ${header_default} =     read_header_title_csv       ${file_downloads_name_report_1}
    ${header_dynamic} =     read_header_title_csv       ${file_downloads_name_report_2}
    Lists Should Be Equal       ${header_default}       ${header_report_default}
    Lists Should Be Equal       ${header_dynamic}       ${header_report_dynamic}
    # Verify that report display blank
    is_empty_csv    ${file_downloads_name_report_1}
    # Verify that name of report file is display correctly
    Check Element Display On Screen     ${REPORT_ONE_TIME_PATTERN_REPORT_NAME}      ${report_name_3}
    Capture Page Screenshot
    # Delete reports
    @{report_names} =       Create List     ${report_name_1}    ${report_name_2}    ${report_name_3}
    Delete reports      ${report_names}


Verify that display all static fields at Field Tab, Verify that dynamic field isn't display at Field Tab, Verify that alow delete some field at Field Tab, Verify that disalow delete some field at Field Tab (OL-T11726, OL-T11727, OL-T11728, OL-T11729)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go To Analytics And Reporting Page
    Click At    Create New Report
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}    ${category}
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}      ${report}
    Click At    ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN_VALUE}       ${frequency.type_frequency}
    Click At    ${CREATE_NEW_REPORT_NAV_BUTTON}     Next
    Verify all static fields at Field Tab are displayed     ${static_fields}
    Verify all dynamic_fields at Field Tab aren't displayed     ${dynamic_fields}
    Verify delete fields that are allowed to be deleted     ${allowed_deleted_static_fields}    ${disalowed_deleted_static_fields}
    Verify delete fields that aren't allowed to be deleted      ${disalowed_deleted_static_fields}

*** Keywords ***
Verify Candidate Offer Detail Report Visibility
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Click At    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}    ${category}
    Click At    ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    # Verify that candidate offer details report is visibility
    Scroll To Element    ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}   ${report}
    Check Element Display On Screen    ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}   ${report}
    # Verify that description of candidate offer details report is display correctly
    ${locator} =    Format String    ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE_DESCRIPTION}    ${report}      Detailed report showing all offer details per offer per candidate.
    Capture Page Screenshot

Verify all static fields at Field Tab are displayed
    [Arguments]    ${static_fields}
    FOR    ${field}    IN    @{static_fields}
        Check element display on screen     ${CREATE_NEW_REPORT_PATTERN_FIELD}      ${field}
    END
    Capture Page Screenshot

Verify all dynamic_fields at Field Tab aren't displayed
    [Arguments]    ${dynamic_fields}
    FOR    ${field}    IN    @{dynamic_fields}
        Check element not display on screen     ${CREATE_NEW_REPORT_PATTERN_FIELD}      ${field}
    END
    Capture Page Screenshot

Verify delete fields that are allowed to be deleted
    [Arguments]    ${allowed_deleted_static_fields}    ${disalowed_deleted_static_fields}
    FOR    ${field}    IN    @{allowed_deleted_static_fields}
        Click at    ${CREATE_NEW_REPORT_PATTERN_DELETE_FIELD_BUTTON}    ${field}
        Check element not display on screen     ${CREATE_NEW_REPORT_PATTERN_FIELD}      ${field}
    END
    FOR    ${field}    IN    @{disalowed_deleted_static_fields}
        Check element not display on screen     ${CREATE_NEW_REPORT_PATTERN_DELETE_FIELD_BUTTON}    ${field}
    END
    Capture Page Screenshot

Verify delete fields that aren't allowed to be deleted
    [Arguments]    ${disalowed_deleted_static_fields}
    FOR    ${field}    IN    @{disalowed_deleted_static_fields}
        Check element not display on screen     ${CREATE_NEW_REPORT_PATTERN_DELETE_FIELD_BUTTON}    ${field}
    END
    Capture Page Screenshot
