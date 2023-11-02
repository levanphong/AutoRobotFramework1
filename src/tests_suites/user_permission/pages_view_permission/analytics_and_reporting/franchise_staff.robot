*** Settings ***
Resource            ./analytics_and_reporting.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check User has Legacy role "Franchise Staff" has full access perm to Dashboard - Dashboard on the Analytics and Reporting page (OL-T19548)
    Given Setup test
    when Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Dashboard


Check User has Legacy role "Franchise Staff" has full access perm to Dashboard - Hire on the Analytics and Reporting page (OL-T19565)
    Given Setup test
    when Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Hire


Check User has Legacy role "Franchise Staff" has full access perm to Rating Dashboard on the Analytics and Reporting page (OL-T19560)
    Given Setup test
    when Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Ratings


Check User has Legacy role "FS" has No access perm to Scheduling Dashboard on the Analytics and Reporting page (OL-T19555)
    Given Setup test
    when Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check element not display on screen  ${LEFT_TAB_NAV_TEXT}  Scheduling
    Capture page screenshot

*** Keywords ***
Check Category and Report in Create new report for Franchise Staff role
    [Arguments]  ${category_type}=Admin
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    IF  '${category_type}' == 'Learning'
        Check Category not display  Learning
    ELSE IF  '${category_type}' == 'Conversations'
        Check Category not display  Conversations
    ELSE IF  '${category_type}' == 'Campaigns'
        Check Category not display  Campaigns
    ELSE
        Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
        Check Report types is correctly for Franchise Staff role  ${category_type}
    END

Check Report types is correctly for Franchise Staff role
    [Arguments]  ${category_type}=Admin
    Click at  ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    IF  '${category_type}' == 'Admin'
        Check Report type title  User Detail
        Check Report type title  Location Detail
        Check Report type title  Keyword Activity Summary
        Check Report type title  Candidate Referring URL Details
        Check Report type title  Job Attributes
        Check Report type title  Location Attributes
        Check Report type title  Deactivated Phone Numbers
        Check Report type title  Job Feed Details
        Capture page screenshot
        Click on span text  Location Detail
        ${report_email_subject} =   Set variable    AdminLocation.Detail
    ELSE IF  '${category_type}' == 'Forms'
        Check Report type title  Candidate Forms Detail Report (Long Format)
        Check Report type title  Candidate Forms Detail Report (Wide Format)
        Check Report type title  User Forms Detail
        Click on span text  Candidate Forms Detail Report (Long Format)
        ${report_email_subject} =   Set variable    FormsCandidate.Forms.Detail.Report.Long.Format
    ELSE IF  '${category_type}' == 'Assessments'
        Check Report type title  Candidate Assessment Details
        Click on span text  Candidate Assessment Details
        ${report_email_subject} =   Set variable    AssessmentsCandidate.Assessment.Details
    ELSE IF  '${category_type}' == 'Candidate Care'
        Check Report type title  Care Summary
        Check Report type title  Experience Story Tracking
        Click on span text  Weekly Conversations
        ${report_email_subject} =   Set variable    Candidate.Care.Summary
    ELSE IF  '${category_type}' == 'Capture'
        Check Report type title  Candidate Specific
        Check Report type title  Paradox Video Meeting Details
        Click on span text  Candidate Specific
        ${report_email_subject} =   Set variable    CaptureCandidate.Specific
    ELSE IF  '${category_type}' == 'Conversational Job Search'
        Check Report type title  Conversational Job Search
        Check Report type title  Capture - Conversational Job Search
        Check Report type title  Care - Conversational Job Search
        Check Report type title  Demographic Job Search Stats
        Check Report type title  Candidate Job Application
        Check Report type title  Job Search Details
        Click on span text  Conversational Job Search
        ${report_email_subject} =   Set variable    Conversational.Job.SearchConversational.Job.Search
    ELSE IF  '${category_type}' == 'Employee Care'
        Check Report type title  Care Summary
        Click on span text  Weekly Conversations
        ${report_email_subject} =   Set variable    Employee.Care.Summary
    ELSE IF  '${category_type}' == 'Hire'
        Check Report type title  Open Jobs
        Check Report type title  Filled Jobs
        Check Report type title  Candidate Journey
        Check Report type title  Hire Trends
        Check Report type title  Diversity Assessment Report
        Check Report type title  Candidate Journey Status History
        Check Report type title  Candidate Journey Details
        Check Report type title  Job Status History
        Check Report type title  Job Hiring Team Details
        Check Report type title  Candidate Offer Details
        Check Report type title  Manual Candidate Volume Changes
        Click on span text  Open Jobs
        ${report_email_subject} =   Set variable    HireOpen.Jobs
    ELSE IF  '${category_type}' == 'Ratings'
        Check Report type title  Candidate Rating Detailed Report
        Check Report type title  Overall Rating Summary
        Check Report type title  User Rating Detailed Report
        Click on span text  Candidate Rating Detailed Report
        ${report_email_subject} =   Set variable    RatingsCandidate.Rating.Detailed.Report
    ELSE IF  '${category_type}' == 'Referrals'
        Check Report type title  Referral Detail
        Click on span text  Referral Detail
        ${report_email_subject} =   Set variable    ReferralsReferral.Detail
    ELSE IF  '${category_type}' == 'Scheduling'
        Check Report type title   Scheduling Overview
        Check Report type title   Candidate Detail Scheduling
        Check Report type title   Upcoming Interviews
        Check Report type title   Interview Attendee Status
        Check Report type title   User Interview Availability
        Check Report type title   User Interview Availability/Scheduled/Total Hours (Long Format)
        Check Report type title   User Interview Availability/Scheduled/Total Hours (Wide Format)
        Check Report type title   Location Calendar Availability
        Check Report type title   Sequential Interview Detail
        Check Report type title   Calendar Permission Details
        Check Report type title   Calendar Audit History
        Click on span text  Scheduling Overview
        ${report_email_subject} =   Set variable    SchedulingScheduling.Overview
    ELSE IF  '${category_type}' == 'Users'
        Check Report type title   Recruiter
        Check Report type title   Company Structure
        Check Report type title   User Feedback Summary
        Check Report type title   User Interview Unavailability
        Check Report type title   User Action Activity
        Click on span text  Recruiter
        ${report_email_subject} =   Set variable    UsersRecruiter
    ELSE IF  '${category_type}' == 'Workflow'
        Check Report type title   Workflow Configuration
        Click on span text  Workflow Communication Activity
        ${report_email_subject} =   Set variable    WorkflowWorkflow.Workflow.Configuration
    ELSE IF  '${category_type}' == 'Event'
        Check Report type title   Event Diversity & Inclusion Summary
        Check Report type title   Hiring Events - Scheduling Overview By Event Name
        Check Report type title   Hiring Events - Scheduling Overview
        Check Report type title   Orientation Events - Scheduling Overview
        Check Report type title   Orientation Events - Scheduling Overview By Event Name
        Click on span text  Event Specific
        ${report_email_subject} =   Set variable    EventEvent.Hiring.Events.Scheduling.Overview
    END
    [Return]    ${report_email_subject}
