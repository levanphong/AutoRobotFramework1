*** Settings ***
Resource            ../../../../drivers/driver_chrome.robot
Resource            ../../../../pages/analytics_and_reporting_page.robot
Library             ../../../../utils/StringHandler.py

*** Variables ***
${report_email_subject}     default

*** Keywords ***
Check Report types is correctly
    [Arguments]  ${category_type}=Admin
    Click at  ${CREATE_NEW_REPORT_REPORT_DROPDOWN}
    IF  '${category_type}' == 'Admin'
        Check Report type title  User Detail
        Check Report type title  Location Detail
        Check Report type title  Configuration Audit
        Check Report type title  Keyword Activity Summary
        Check Report type title  Candidate Attributes
        Check Report type title  Candidate Referring URL Details
        Check Report type title  External Candidate Status History
        Check Report type title  Login Activity Details
        Check Report type title  EEO Candidate Journey Status History
        Check Report type title  EEO Candidate Capture Details
        Check Report type title  Location Attributes
        Check Report type title  Deactivated Phone Numbers
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
    ELSE IF  '${category_type}' == 'Campaigns'
        Check Report type title  Campaigns Summary
        Check Report type title  Campaign Candidate Detail
        Click on span text  Campaigns Summary
        ${report_email_subject} =   Set variable    CampaignsCampaigns.Summary
    ELSE IF  '${category_type}' == 'Candidate Care'
        Check Report type title  Weekly Conversations
        Check Report type title  Monthly Conversations
        Check Report type title  Top 10 Topics
        Check Report type title  Care Performance Summary
        Check Report type title  Unmatched Questions to Intent
        Check Report type title  Negative Topic Performance
        Check Report type title  Care Details
        Check Report type title  CMS Metrics Summary
        Check Report type title  Care Summary
        Check Report type title  Experience Story Tracking
        Click on span text  Weekly Conversations
        ${report_email_subject} =   Set variable    Candidate.CareWeekly.Conversations
    ELSE IF  '${category_type}' == 'Capture'
        Check Report type title  Candidate Specific
        Check Report type title  Company Overview
        Check Report type title  Group
        Check Report type title  Conversation Drop-off Detail
        Check Report type title  Diversity Assessment
        Check Report type title  Candidate Note History
        Check Report type title  Paradox Video Meeting Details
        Click on span text  Candidate Specific
        ${report_email_subject} =   Set variable    CaptureCandidate.Specific
    ELSE IF  '${category_type}' == 'Conversations'
        Check Report type title  Conversation Detail
        Click on span text  Conversation Detail
        ${report_email_subject} =   Set variable    ConversationsConversation.Detail
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
        Check Report type title  Weekly Conversations
        Check Report type title  Monthly Conversations
        Check Report type title  Top 10 Topics
        Check Report type title  Care Performance Summary
        Check Report type title  Unmatched Questions to Intent
        Check Report type title  Negative Topic Performance
        Check Report type title  Care Details
        Check Report type title  CMS Metrics Summary
        Check Report type title  Care Summary
        Click on span text  Weekly Conversations
        ${report_email_subject} =   Set variable    Employee.CareWeekly.Conversations
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
        Check Report type title  Ratings per Workflow
        Check Report type title  User Rating Detailed Report
        Click on span text  Candidate Rating Detailed Report
        ${report_email_subject} =   Set variable    RatingsCandidate.Rating.Detailed.Report
    ELSE IF  '${category_type}' == 'Referrals'
        Check Report type title  Referral Detail
        Click on span text  Referral Detail
        ${report_email_subject} =   Set variable    ReferralsReferral.Detail
    ELSE IF  '${category_type}' == 'Scheduling'
        Check Report type title   Scheduling Overview
        Check Report type title   Candidate Detailed Scheduling
        Check Report type title   Upcoming Interviews
        Check Report type title   Interview Attendee Status
        Check Report type title   User Interview Availability
        Check Report type title   User Interview Availability/Scheduled/Total Hours-Long Format
        Check Report type title   User Interview Availability/Scheduled/Total Hours-Wide Format
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
        Check Report type title   User School Assignment
        Check Report type title   User Action Activity
        Click on span text  Recruiter
        ${report_email_subject} =   Set variable    UsersRecruiter
    ELSE IF  '${category_type}' == 'Workflow'
        Check Report type title   Workflow Communication Activity
        Check Report type title   Workflow Configuration
        Click on span text  Workflow Communication Activity
        ${report_email_subject} =   Set variable    WorkflowWorkflow.Communication.Activity
    ELSE IF  '${category_type}' == 'Event'
        Check Report type title   Event Specific
        Check Report type title   Event Candidate Detail
        Check Report type title   Event Source
        Check Report type title   Event Budget & Expense
        Check Report type title   Event Diversity & Inclusion Summary
        Check Report type title   Hiring Events - Scheduling Overview By Event Name
        Check Report type title   Hiring Events - Scheduling Overview
        Check Report type title   Orientation Events - Scheduling Overview
        Check Report type title   Orientation Events - Scheduling Overview By Event Name
        Click on span text  Event Specific
        ${report_email_subject} =   Set variable    EventEvent.Specific
    ELSE IF  '${category_type}' == 'Learning'
        Check Report type title   Learning Summary
        Click on span text  Learning Summary
        ${report_email_subject} =   Set variable    LearningLearning.Summary
    END
    [Return]    ${report_email_subject}

Send a Report
    [Arguments]  ${category_type}=Admin
    Go to Analytics and Reporting page
    Click at  ${LEFT_TAB_NAV_TEXT}  Active
    Click at  Create New Report
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Run keyword and ignore error    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
    ${report_email_subject} =   Check Report types is correctly  ${category_type}
    Click at  ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN}
    Click at  ${CREATE_NEW_REPORT_FREQUENCY_DROPDOWN_VALUE}  One-time
    ${date_range_category} =    Create List     Assessments     Campaigns    Referrals    Scheduling    Users    Workflow    Conversational Job Search    Learning
    IF  '${category_type}' in ${date_range_category}
        Click at  ${CREATE_NEW_REPORT_DATE_RANGE_SELECT}
        ${start_date} =     get_past_date   2
        ${end_date} =     get_past_date
        Click at  ${CREATE_NEW_REPORT_DATE_RANGE_VALUE}  ${start_date}
        Click at  ${CREATE_NEW_REPORT_DATE_RANGE_VALUE}  ${end_date}
        Click at  ${CREATE_NEW_REPORT_DATE_RANGE_APPLY_BUTTON}
    END
    Capture page screenshot
    Click at  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next
    Click at  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next
    Click at  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next
    ${filter_step} =    Create List     Candidate Care     Capture    Conversations    Employee Care    Forms    Hire
    ...     Ratings    Event
    IF  '${category_type}' in ${filter_step}
        Click at  ${CREATE_NEW_REPORT_NAV_BUTTON}  Next
    END
    Click at  ${CREATE_NEW_REPORT_NAV_BUTTON}  Finish and Send Now
    Check element display on screen  We are processing your request. You will get report file sent to your email.
    Capture page screenshot
    Click at  ${CREATE_NEW_REPORT_REPORT_SENT_OK_BUTTON}
    Verify user has received the email  ${report_email_subject}    Olivia    ADMIN_REPORT

Get Captured Candidates number
    ${candidate_number} =      Get text and format text  ${DASH_BOARD_CAPTURED_CANDIDATES_NUMBER}
    ${candidate_number} =      extract_numbers     ${candidate_number}
    [Return]    ${candidate_number}[0]

Check Report type title
    [Arguments]  ${expected_title}
    Check element display on screen  ${CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE}  ${expected_title}

Get number of Interview Open
    ${interview_number} =      Get text and format text  ${SCHEDULING_INTERVIEW_OPEN_NUMBER}
    [Return]    ${interview_number}

Check user can update Dashboard / Hire
    Click at  ${LEFT_TAB_NAV_TEXT}  Dashboards
    Click at  ${LEFT_TAB_NAV_TEXT}  Hire
    Capture page screenshot
    Click at  ${HIRE_DATE_RANGE_FILTER_DROPDOWN}
    Click at  Year to date
    Click at  ${HIRE_DATE_RANGE_FILTER_DROPDOWN}
    Verify display text  ${DASH_BOARD_FILTER_DROPDOWN_SELECTED_VALUE}  Year to date
    Capture page screenshot

Check user can update Dashboard / Ratings
    Click at  ${LEFT_TAB_NAV_TEXT}  Dashboards
    Click at  ${LEFT_TAB_NAV_TEXT}  Ratings
    Capture page screenshot
    Click at  ${RATINGS_AUDIENCE_FILTER_DROPDOWN}
    Click at  ${RATINGS_AUDIENCE_FILTER_DROPDOWN_VALUE}  Users
    Click at  ${RATINGS_AUDIENCE_FILTER_DROPDOWN}
    Verify display text  ${DASH_BOARD_FILTER_DROPDOWN_SELECTED_VALUE}  Users
    Capture page screenshot

Check user can update Dashboard / Dashboard
    Click at  ${LEFT_TAB_NAV_TEXT}  Dashboards
    Capture page screenshot
    Click at  ${DASH_BOARD_FILTER_DATE_DROPDOWN}
    Click at  Last 12 months
    Click at  ${DASH_BOARD_FILTER_DATE_DROPDOWN}
    Verify display text  ${DASH_BOARD_FILTER_DROPDOWN_SELECTED_VALUE}  Last 12 months
    Capture page screenshot

Check user can update Dashboard / Scheduling
    Click at  ${LEFT_TAB_NAV_TEXT}  Dashboards
    Click at  ${LEFT_TAB_NAV_TEXT}  Scheduling
    Capture page screenshot
    Click at  Add Filter
    Click at  ${SCHEDULING_ADD_FILTER_VALUE}  User or Round Robin Group
    Click at  Select all
    Click at  ${SCHEDULING_ADD_FILTER_APPLY_BUTTON}
    Check element display on screen  ${SCHEDULING_USER_ROUND_ROBIN_FILTER_ICON}
    Capture page screenshot

Check Category and Report in Create new report
    [Arguments]  ${category_type}=Admin
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
    Check Report types is correctly  ${category_type}

Check Category not display
    [Arguments]  ${category_type}
    Check element not display on screen  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE}  ${category_type}
    # Close dropdown
    Click at  ${CREATE_NEW_REPORT_CATEGORY_DROPDOWN}
