*** Settings ***
Resource            ./analytics_and_reporting.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***

*** Test Cases ***
Advantage Instance: Check User has Legacy role is Recruiter has Full access to CAPTURE Reports on the Analytics and Reporting page (OL-T19680)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Capture


Advantage Instance: Check User has Legacy role is Recruiter has Full access to SCHEDULING Reports on the Analytics and Reporting page (OL-T19681)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Scheduling


Advantage Instance: Check User has Legacy role is Recruiter has Full access to RATINGS Reports on the Analytics and Reporting page (OL-T19682)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Ratings


Advantage Instance: Check User has Legacy role is Recruiter has Full access to CONVERSATIONAL JOB SEARCH Reports on the Analytics and Reporting page (OL-T19684)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Conversational Job Search


Advantage Instance: Check User has Legacy role is Recruiter has Full access to HIRE Reports on the Analytics and Reporting page (OL-T19685)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Hire


Advantage Instance: Check User has Legacy role is Recruiter has Full access to FORMS Reports on the Analytics and Reporting page (OL-T19686)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Forms


Advantage Instance: Check User has Legacy role is Recruiter has Full access to WORKFLOW Reports on the Analytics and Reporting page (OL-T19687)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Workflow


Advantage Instance: Check User has Legacy role is Recruiter has Full access to CONVERSATIONS Reports on the Analytics and Reporting page (OL-T19688)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Conversations


Advantage Instance: Check User has Legacy role is Supervisor has Full access to CAPTURE Reports on the Analytics and Reporting page (OL-T19670)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Capture


Advantage Instance: Check User has Legacy role is Supervisor has Full access to SCHEDULING Reports on the Analytics and Reporting page (OL-T19671)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Scheduling


Advantage Instance: Check User has Legacy role is Supervisor has Full access to RATINGS Reports on the Analytics and Reporting page (OL-T19672)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Ratings


Advantage Instance: Check User has Legacy role is Supervisor has Full access to CONVERSATIONAL JOB SEARCH Reports on the Analytics and Reporting page (OL-T19674)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Conversational Job Search


Advantage Instance: Check User has Legacy role is Supervisor has Full access to HIRE Reports on the Analytics and Reporting page (OL-T19675)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Hire


Advantage Instance: Check User has Legacy role is Supervisor has Full access to FORMS Reports on the Analytics and Reporting page (OL-T19676)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Forms


Advantage Instance: Check User has Legacy role is Supervisor has Full access to WORKFLOW Reports on the Analytics and Reporting page (OL-T19677)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Workflow


Advantage Instance: Check User has Legacy role is Supervisor has Full access to CONVERSATIONS Reports on the Analytics and Reporting page (OL-T19678)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Check Report types is correctly for Recruiter and Supervisor   Conversations


Advantage Instance: Check User has Legacy role is Recruiter has No access to CANDIDATE CARE Reports on the Analytics and Reporting page (OL-T19690, OL-T19691, OL-T19692, OL-T19693, OL-T19694, OL-T19695, OL-T19696, OL-T19697, OL-19698)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Reports
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
    Click at    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Check Category not display in report type   Candidate Care
    Check Category not display in report type   Employee Care
    Check Category not display in report type   Users
    Check Category not display in report type   Event
    Check Category not display in report type   Referrals
    Check Category not display in report type   Admin
    Check Category not display in report type   Campaigns
    Check Category not display in report type   Assessments


Advantage Instance: Check User has Legacy role is Supervisor has No access to CANDIDATE CARE Reports on the Analytics and Reporting page (OL-T19699, OL-T19670, OL-T19671, OL-T19672, OL-T19673, OL-T19674, OL-T19675, OL-T19676, OL-T19677)
    [Tags]    advantage    regression
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Reports
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
    Click at    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Check Category not display in report type   Candidate Care
    Check Category not display in report type   Employee Care
    Check Category not display in report type   Users
    Check Category not display in report type   Event
    Check Category not display in report type   Referrals
    Check Category not display in report type   Admin
    Check Category not display in report type   Campaigns
    Check Category not display in report type   Assessments
    Check Category not display in report type   Learning

*** Keywords ***
Check Report types is correctly for Recruiter and Supervisor
    [Arguments]  ${category_type}=Capture
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Reports
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
    IF  '${category_type}' != 'Capture'
        Click at    ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
        Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
    END
    Click at  ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    IF  '${category_type}' == 'Capture'
        Check Report type title for Recruiter and Supervisor  Candidate Specific
        Check Report type title for Recruiter and Supervisor  Company Overview
        Check Report type title for Recruiter and Supervisor  Conversation Drop-off Detail
        Check Report type title for Recruiter and Supervisor  Candidate Note History
        Check Report type title for Recruiter and Supervisor  Paradox Video Meeting Details
        Click on span text  Candidate Specific
        ${report_email_subject} =   Set variable    CaptureCandidate.Specific
    ELSE IF  '${category_type}' == 'Conversations'
        Check Report type title for Recruiter and Supervisor  Conversation Detail
        Click on span text  Conversation Detail
        ${report_email_subject} =   Set variable    FormsCandidate.Forms.Detail.Report.Long.Format
    ELSE IF  '${category_type}' == 'Forms'
        Check Report type title for Recruiter and Supervisor  Candidate Forms Detail Report (Long Format)
        Check Report type title for Recruiter and Supervisor  Candidate Forms Detail Report (Wide Format)
        Check Report type title for Recruiter and Supervisor  User Forms Detail
        Click on span text  Candidate Forms Detail Report (Long Format)
        ${report_email_subject} =   Set variable    FormsCandidate.Forms.Detail.Report.Long.Format
    ELSE IF  '${category_type}' == 'Hire'
        Check Report type title for Recruiter and Supervisor     Open Jobs
        Check Report type title for Recruiter and Supervisor     Filled Jobs
        Check Report type title for Recruiter and Supervisor     Candidate Journey
        Check Report type title for Recruiter and Supervisor     Hire Trends
        Check Report type title for Recruiter and Supervisor     Diversity Assessment Report
        Check Report type title for Recruiter and Supervisor     Candidate Journey Status History
        Check Report type title for Recruiter and Supervisor     Candidate Journey Details
        Check Report type title for Recruiter and Supervisor     Job Status History
        Check Report type title for Recruiter and Supervisor     Job Hiring Team Details
        Check Report type title for Recruiter and Supervisor     Candidate Offer Details
        Check Report type title for Recruiter and Supervisor     Manual Candidate Volume Changes
        Click on span text      Open Jobs
        ${report_email_subject} =   Set variable    AssessmentsCandidate.Assessment.Details
    ELSE IF  '${category_type}' == 'Ratings'
        Check Report type title for Recruiter and Supervisor  Candidate Rating Detailed Report
        Check Report type title for Recruiter and Supervisor  Overall Rating Summary
        Check Report type title for Recruiter and Supervisor  Ratings per Workflow
        Check Report type title for Recruiter and Supervisor  User Rating Detailed Report
        Click on span text  Candidate Rating Detailed Report
        ${report_email_subject} =   Set variable    RatingsCandidate.Rating.Detailed.Report
    ELSE IF  '${category_type}' == 'Scheduling'
        Check Report type title for Recruiter and Supervisor   Scheduling Overview
        Check Report type title for Recruiter and Supervisor   Candidate Detailed Scheduling
        Check Report type title for Recruiter and Supervisor   Upcoming Interviews
        Check Report type title for Recruiter and Supervisor   Interview Attendee Status
        Check Report type title for Recruiter and Supervisor   User Interview Availability
        Check Report type title for Recruiter and Supervisor   User Interview Availability/Scheduled/Total Hours-Wide Format
        Check Report type title for Recruiter and Supervisor   User Interview Availability/Scheduled/Total Hours-Long Format
        Click on span text  Scheduling Overview
        ${report_email_subject} =   Set variable    SchedulingScheduling.Overview
    ELSE IF  '${category_type}' == 'Conversational Job Search'
        Check Report type title  Candidate Job Application
        Click on span text  Candidate Job Application
        ${report_email_subject} =   Set variable    Conversational.Job.SearchConversational.Job.Search
    ELSE IF  '${category_type}' == 'Workflow'
        Check Report type title for Recruiter and Supervisor   Workflow Communication Activity
        Click on span text  Workflow Communication Activity
        ${report_email_subject} =   Set variable    WorkflowWorkflow.Communication.Activity
    END
    [Return]    ${report_email_subject}

Check Report type title for Recruiter and Supervisor
    [Arguments]  ${expected_title}
    Check element display on screen  ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}  ${expected_title}

Check Category not display in report type
    [Arguments]     ${category_type}
    Check element not display on screen  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
    capture page screenshot
