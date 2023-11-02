*** Settings ***
Resource            ./analytics_and_reporting.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***

*** Test Cases ***
Darden Instance: Check User has Legacy role is Recruiter has Full access to HIRE Reports on the Analytics and Reporting page (OL-T19652)
    [Tags]    darden    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter   Hire


Darden Instance: Check User has Legacy role is Recruiter has Full access to SCHEDULING Reports on the Analytics and Reporting page (OL-T19653)
    [Tags]    darden    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter   Scheduling


Darden Instance: Check User has Legacy role is Recruiter has No access to CAPTURE Reports on the Analytics and Reporting page (OL-T19653, OL-T19654, OL-T19655, OL-T19656, OL-T19657, OL-T19658, OL-T19659, OL-T19660, OL-T19661, OL-T19662, OL-T19663, OL-T19664, OL-T19665, OL-T19666, OL-T19667, OL-T19668, OL-T19669)
    [Tags]    darden    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Reports
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
    Check Category not display      Capture
    Check Category not display      Candidate Care
    Check Category not display      Employee Care
    Check Category not display      Ratings
    Check Category not display      Users
    Check Category not display      Conversational Job Search
    Check Category not display      Event
    Check Category not display      Referrals
    Check Category not display      Forms
    Check Category not display      Workflow
    Check Category not display      Admin
    Check Category not display      Campaigns
    Check Category not display      Conversation
    Check Category not display      Assessments
    Check Category not display      Learning

*** Keywords ***
Check Report types is correctly for Recruiter
    [Arguments]  ${category_type}=Hire
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Reports
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
    IF  '${category_type}' != 'Hire'
        Click at    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
        Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
    END
    Click at  ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    IF  '${category_type}' == 'Hire'
        Check Report type title for Recruiter     Open Jobs
        Check Report type title for Recruiter     Filled Jobs
        Check Report type title for Recruiter     Candidate Journey
        Check Report type title for Recruiter     Hire Trends
        Check Report type title for Recruiter     Diversity Assessment Report
        Check Report type title for Recruiter     Candidate Journey Status History
        Check Report type title for Recruiter     Candidate Journey Details
        Check Report type title for Recruiter     Job Status History
        Click on span text      Open Jobs
        ${report_email_subject} =   Set variable    AssessmentsCandidate.Assessment.Details
    ELSE IF  '${category_type}' == 'Scheduling'
        Check Report type title for Recruiter   Scheduling Overview
        Check Report type title for Recruiter   Candidate Detailed Scheduling
        Check Report type title for Recruiter   Upcoming Interviews
        Check Report type title for Recruiter   Interview Attendee Status
        Check Report type title for Recruiter   User Interview Availability
        Check Report type title for Recruiter   User Interview Availability/Scheduled/Total Hours-Wide Format
        Check Report type title for Recruiter   User Interview Availability/Scheduled/Total Hours-Long Format
        Click on span text  Scheduling Overview
        ${report_email_subject} =   Set variable    SchedulingScheduling.Overview
    END

Check Report type title for Recruiter
    [Arguments]  ${expected_title}
    Check element display on screen  ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}  ${expected_title}
