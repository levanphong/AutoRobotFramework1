*** Settings ***
Resource            ./analytics_and_reporting.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***

*** Test Cases ***
Mchire Instance: Check User has Legacy role is CA has full access on the Analytics and Reporting page (OL-T19711, OL-T19709, OL-T19713)
    [Tags]    regression    mchire
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Create a new Report
    Check Hire Report on McHire instance


Mchire Instance: Check User has Legacy role is FO/FS has full access on the Analytics and Reporting page (OL-T19710, OL-T19708, OL-T19712)
    [Tags]    regression    mchire
    Given Setup test
    when Login into system with company    Franchise Owner    ${COMPANY_FRANCHISE_ON}
    Go to Create a new Report
    Check Hire Report on McHire instance
    # Logout and login with Franchise Staff role
    Click at  Analytics & Reporting - 
    Click at  Discard
    Logout from System by URL
    Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to Create a new Report
    Check Hire Report on McHire instance

*** Keywords ***
Check Hire Report on McHire instance
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  Hire
    Click at  ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    Check Report type title  Hire: Payroll Report - 2019 Tax Forms
    Capture page screenshot
    Check Report type title  Hire: Payroll Report - 2020 Tax Forms
    Capture page screenshot
    Check Report type title  Hire: Payroll Report - 2021 Tax Forms
    Capture page screenshot

Go to Create a new Report
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Reports
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
