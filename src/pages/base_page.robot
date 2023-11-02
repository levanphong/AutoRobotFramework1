*** Settings ***
Library         SeleniumLibrary
Library         String
Library         Collections
Library         OperatingSystem
Library         pabot.PabotLib
Library         ../utils/NameUtils.py
Library         ../utils/DateTimeUtils.py
Library         ../utils/CommonFunctions.py
Library         ../utils/ListHandler.py
Library         ../utils/FileHandler.py
Library         ../utils/StringHandler.py
Library         ../data_tests/CandidateTest.py
Resource        ../commons/common_keywords.robot
Resource        ../constants/variables_resource.robot
Resource        ./login_page.robot
Resource        ./all_candidates_page.robot
Resource        ./web_management_page.robot
Variables       ../locators/common_locators.py
Variables       ../locators/school_management_locators.py
Variables       ../locators/gryphon_system.py
Variables       ../locators/conversation_builder_locators.py
Variables       ../constants/TestVariables.py
Variables       ../constants/UserRoles.py
Variables       ../constants/UserName.py
Variables       ../constants/JobsConst.py
Variables       ../constants/FormConst.py
Variables       ../constants/EventVariables.py
Variables       ../constants/MessageCustomizationConst.py
Variables       ../constants/LocationsConst.py
Variables       ../constants/ConversationConst.py
Variables       ../constants/FeedConst.py
Variables       ../constants/WebManagementConst.py
Variables       ../constants/ClientSetupConst.py
Variables       ../constants/ConvoBuilderConst.py
Variables       ../constants/WorkFlowConst.py
Variables       ../constants/CandidateStatusConst.py
Variables       ../constants/CvoThresholdStatus.py
Variables       ../constants/SendRatingMsgConst.py
Variables       ../constants/CandidateJourneyConst.py
Variables       ../constants/AssessmentConst.py

*** Keywords ***
Setup test
    ${CONFIG} =    get_config    ${env}
    Set Global Variable    ${CONFIG}
    Set Suite Variable    ${CONFIG}
    Log    ${CONFIG.gmail}
    ${base_url} =    Set Variable    ${CONFIG.site_url}
    Set Global Variable    ${base_url}
    Log    ${base_url}

Setup for every Test case
    Open Chrome
    Setup test

Go to URL
    [Arguments]    ${url}
    ${redirect_url} =   Set variable    ${base_url}/${url}
    wait_for_loading_icon_disappear
    # Get current url to check it's already in expected page or not
    ${current_url} =    Get location
    ${is_redirected} =      Run keyword and return status   Should Be Equal As Strings    ${current_url}    ${redirect_url}
    # Only redirect to URL if not in expected page
    IF  '${is_redirected}' == 'False'
        ${is_redirected} =      Go to URL and Get redirect to URL status    ${redirect_url}
        # Try one more time if page is not redirected
        IF  '${is_redirected}' == 'False' and '${redirect_url}' != '${base_url}/logout'
            ${is_redirected} =      Go to URL and Get redirect to URL status    ${redirect_url}
        END
    END
    [Return]    ${is_redirected}

Go to URL and Get redirect to URL status
    [Arguments]    ${redirect_url}
    Go to    ${redirect_url}
    wait_for_loading_icon_disappear
    ${current_url} =    Get location
    ${is_redirected} =      Run keyword and return status   Should Contain    ${current_url}    ${redirect_url}
    [Return]    ${is_redirected}

Get email by username
    [Arguments]    ${role}    ${mail_account}
    ${email} =    Set Variable    empty
    @{user_name} =    split string    ${mail_account}    @
    ${user} =    get from list    ${user_name}    0
    ${domain} =    get from list    ${user_name}    1
    IF    '${role}' == '${CP_ADMIN}'
        ${user} =    format string    {}{}    ${user}    +ca
    ELSE IF    '${role}' == '${EDIT_EVERYTHING}'
        ${user} =    format string    {}{}    ${user}    +ee
    ELSE IF    '${role}' == '${EDIT_NOTHING}'
        ${user} =    format string    {}{}    ${user}    +en
    ELSE IF    '${role}' == '${BASIC}'
        ${user} =    format string    {}{}    ${user}    +bs
    ELSE IF    '${role}' == '${RECRUITER}'
        ${user} =    format string    {}{}    ${user}    +rc
    ELSE IF    '${role}' == '${SUPER_VISOR}'
        ${user} =    format string    {}{}    ${user}    +sp
    ELSE IF    '${role}' == '${FO}'
        ${user} =    format string    {}{}    ${user}    +fo
    ELSE IF    '${role}' == '${FS}'
        ${user} =    format string    {}{}    ${user}    +fs
    ELSE IF    '${role}' == '${HM}'
        ${user} =    format string    {}{}    ${user}    +hm
    ELSE IF    '${role}' == '${REPORT}'
        ${user} =    format string    {}{}    ${user}    +rp
    ELSE IF    '${role}' == '${PARADOX_ADMIN}'
        ${email} =    Set Variable    olivia.automation@paradox.ai
        IF    '${env}' == 'BIRDDOGHR'
            ${email} =    Set Variable    viewonly.prod@paradox.ai
            Set Global Variable    ${TEAM_USER}    ${VIEW_ONLY_USER}
        END
    ELSE IF    '${role}' == '${ViewOnly}'
        ${email} =    Set Variable    viewonly.prod@paradox.ai
    END
    IF    '${email}' == 'empty'
        ${email} =    format string    {}@paradox.ai    ${user}
    END
    log    ${email}
    [Return]    ${email.strip()}

Get email by username with schedule info
    [Arguments]    ${user_name}    ${mail_account}    ${company}
    ${email} =    Set Variable    empty
    @{email_role} =    split string    ${mail_account}    @
    ${user} =    get from list    ${email_role}    0
    ${domain} =    get from list    ${email_role}    1
    IF    '${user_name}' == '${EE_TEAM}'
        ${user} =    format string    {}{}    ${user}    +edit
    ELSE IF    '${user_name}' == '${EN_TEAM}'
        ${user} =    format string    {}{}    ${user}    +nothing
    ELSE IF    '${user_name}' == '${CP_TEAM}'
        ${user} =    format string    {}{}    ${user}    +cp
    ELSE IF    '${user_name}' == '${HM_TEAM}'
        ${user} =    format string    {}{}    ${user}    +hm
    ELSE IF    '${user_name}' == '${RC_TEAM}'
        ${user} =    format string    {}{}    ${user}    +rc
    ELSE IF    '${user_name}' == '${SV_TEAM}'
        ${user} =    format string    {}{}    ${user}    +sv
    ELSE IF    '${user_name}' == '${FS_TEAM}'
        ${user} =    format string    {}{}    ${user}    +fs
    ELSE IF    '${user_name}' == '${FO_TEAM}'
        ${user} =    format string    {}{}    ${user}    +fo
    END
    IF    '${company}' == '${COMPANY_HIRE_ON}'
        ${user} =    format string    {}{}    ${user}    _on
    ELSE
        ${user} =    format string    {}{}    ${user}    _flex
    END
    ${email} =    format string    {}@paradox.ai    ${user}
    [Return]    ${email.strip()}

Get login email and password
    [Arguments]    ${ROLE}
    ${email} =    Get email by username    ${ROLE}    ${CONFIG.gmail}
    IF  'viewonly' in '${email}'
        ${password} =   Set variable    1246
    ELSE
        ${password} =   Set variable    1345
    END
    [Return]    ${email}    ${password}

Click setting icon on menu
    Click at    ${MENU_SPAN}
    click at    ${SETTING_ICON}

Go to CEM of company
    [Arguments]     ${company_name}=None
    ${base_url} =    Set Variable    ${CONFIG.site_url}
    IF  '${company_name}' == 'None'
        Go to    ${base_url}/login
    ELSE
        ${redirect_url} =   get_company_redirect_url   ${company_name}
        Go to    ${base_url}${redirect_url}
    END

Login into system with schedule company with full user
    [Arguments]    ${user_name}    ${company}=${COMPANY_HIRE_ON}
    ${email} =    Get email by username with schedule info    ${user_name}    ${CONFIG.gmail}    ${company}
    Go to CEM of company    ${company}
    login into CEM    ${email}    1345
    wait for cem display
    Switch to Company v1    ${company}

Login into system
    [Arguments]    ${ROLE}
    ${email}    ${password} =    Get login email and password    ${ROLE}
    Go to CEM of company
    login into CEM    ${email}    ${password}

Login into system with company
    [Arguments]    ${ROLE}    ${company}
    ${email}    ${password} =    Get login email and password    ${ROLE}
    Go to CEM of company    ${company}
    login into CEM    ${email}    ${password}
    wait for cem display
    Switch to Company v1    ${company}

Logout and Login with user role
    [Arguments]    ${user_role}
    logout from system by URL
    Login into system    ${user_role}

Get email for testing
    [Arguments]     ${is_spam_email}=True
    &{email_info} =    Create Dictionary
    IF  '${is_spam_email}' == 'False'
        ${CONFIG} =    get_config    ${env}
        Set Suite Variable    ${CONFIG}
        ${email_info.email} =    random_test_email_characters    ${CONFIG.gmail}
        ${email_info.app_key} =    Set Variable    ${CONFIG.app_password}
    ELSE
        ${email_info.email} =    random_test_email_characters    email.auto@paradox.ai
    END
    [Return]    &{email_info}

Navigate to
    [Arguments]    ${key_page}
    ${link} =    get_page_link    ${base_url}    ${key_page}
    LOG    ${link}
    go to    ${link}
    wait for page load successfully v1

go to create Hiring Event
    Go to URL   events
    navigate to create hiring events

Go to create Event modal
    Go to URL   events
    wait for page load successfully v1
    Wait with short time
    click on Create New Event button

Go to Events page
    ${is_correct_page} =      Go to URL   events
    wait for page load successfully
    [Return]    ${is_correct_page}

Go to Message Customize
    Go to URL   settings/assistant-messaging
    wait for page load successfully v1

Go to event detail by id
    [Arguments]    ${id}
    ${link_event} =    Format String    ${base_url}/event/{}/dashboard    ${id}
    Go to    ${link_event}
    wait for page load successfully v1

Go to conversation builder
    Go to URL   settings/conversations
    wait until page contains element    ${CONVERSATION_LIST}
    wait for page load successfully v1

Go to Web Management
    Go to URL   settings/web-management
    Check element display on screen  ${WEB_PAGES_LIST}

Go to CEM page
    Go to URL   candidates

Go to System Attributes
    Go to URL   settings/system-attributes
    wait for page load successfully v1

Go to Candidate Journeys page
    ${is_correct_page} =      Go to URL   settings/journeys
    wait for page load successfully v1
    [Return]    ${is_correct_page}

Go to Group Management page
    Go to URL   settings/group-management
    wait for page load successfully v1

Go to Workflows page
    Go to URL   settings/workflows
    wait for page load successfully v1

Go to Users page
    Go to URL   settings/users
    Check element display on screen     ${USER_INFO_LOCATOR}

Go to CMS page
    Go to URL   settings/cms
    wait for page load successfully v1

Go to Knowledge Base page
    Go to URL   settings/knowledge-base
    wait for page load successfully v1

Go to Location Management page
    Go to URL   settings/location-management
    wait for page load successfully v1

Go to Sales Demo page
    Go to URL   settings/sales-demo
    wait for page load successfully v1

Go to Jobs page
    Go to URL   settings/job-builder?type=job
    wait for page load successfully

Go to My Jobs page
    Go to URL   jobs
    wait for page load successfully v1
    Wait with short time

Go to Suggestions page
    Go to URL   settings/suggestions
    wait for page load successfully v1

Go to Message Customization page
    Go to URL   settings/assistant-messaging
    wait for page load successfully v1

Go to Offers page
    ${is_redirected} =  Go to URL   settings/offers
    wait for page load successfully v1
    [Return]    ${is_redirected}

Go to Phone number page
    Go to URL   settings/phone-numbers
    wait for page load successfully v1

Go to Client setup page
    Go to URL   settings/client-setup
    wait for page load successfully v1

Go to job data packages page
    Go to URL   settings/job-data-packages/created-packages
    check span display  Job Data Packages

Go to Ratings Builder page
    Go to URL   ratings
    wait for page load successfully v1

Go to My Profile page
    Go to URL   settings/my-profile
    wait for page load successfully v1

Logout from System
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${LOGOUT_ICON}

Go to Event Templates page
    Go to URL   settings/event-templates

go to form page
    ${is_correct_page} =      Go to URL   settings/forms/all?type=1
    wait for page load successfully v1
    [Return]    ${is_correct_page}

go to Interview Prep page
    ${is_correct_page} =      Go to URL   settings/interview-preps
    wait for page load successfully v1
    [Return]    ${is_correct_page}

go to Round Robin Management page
    ${is_correct_page} =      Go to URL   settings/round-robin-management
    wait for page load successfully v1
    [Return]    ${is_correct_page}

go to My Calendar page
    Go to URL   interview/calendar
    wait for page load successfully v1

Go to Users, Roles, Permissions page
    Go to URL   settings/users-roles/all-active-users
    Check element display on screen     ${USER_LIST}

Go to approvals builder page
    Go to URL   settings/approvals-builder

Go to school management page
    Go to URL   settings/school-management
    ${is_loaded}=   Run Keyword And Return Status    Check Element Display On Screen        ${ADD_NEW_SCHOOL_HEADER}
    Capture Page Screenshot
    IF  '${is_loaded}' == 'False'
        Reload Page
    END

Go to Analytics and Reporting page
    Go to URL   settings/analytics

Go to Integration Center page
    Go to URL   settings/integration-center

logout from system by URL
    Go to URL   logout

Go to Roles and Permissions page
    Go to Users, Roles, Permissions page
    Click at  ${USERS_NAVIGATION_ROLE}  Roles and Permissions
    ${is_redirected} =   Run keyword and return status  Check element display on screen  ${ROLES_ECLIPSE_ICON}  ${EMPTY}
    Run keyword if  '${is_redirected}' == 'False'   Reload page

Go to Campaigns page
    ${is_correct_page} =      Go to URL   campaigns
    [Return]    ${is_correct_page}

Go to Interviews page
    ${is_correct_page} =      Go to URL   interviews
    [Return]    ${is_correct_page}

Go to Recorded Interview Builder Interviews page
    ${is_correct_page} =      Go to URL   settings/interview-builder
    [Return]    ${is_correct_page}

Verify alert success is display and close alert
    check element display on screen  ${TOASTED_MESSAGE_SUCCESS}
    Click at  ${ICON_CLOSE_TOASTED_MESSAGE_SUCCESS}

go to microlearning page
    Go to URL   microlearning
    wait for page load successfully v1

Go to Campus page
    ${is_correct_page} =      Go to URL   campus-page
    [Return]    ${is_correct_page}

Go to Candidate Volume Optimizer page
    ${is_correct_page} =      Go to URL   settings/candidate-volume-optimizer
    [Return]    ${is_correct_page}

Go to Talent Community page
    Go to URL    talent-community
    wait for page load successfully

Go to Applicant Flows
    Go to URL   settings/applicant-flows/all
    wait for page load successfully v1

Open new tab same browser
    Execute Javascript    window.open('')

Go to Candidate Summary Builder
    Go to URL   settings/candidate-summary-builder
    wait for page load successfully v1

Go to Candidate Summary
    Go to Candidate Summary Builder
    Click at   ${CANDIDATE_SUMMARY_TAB}
    wait for page load successfully v1

Go To User Feedback Page
    Go to URL   settings/user-feedback
    wait for page load successfully v1

Go to Alert Management page
    Go to URL   settings/alert-management
    Wait For Page Load Successfully V1

Go to campus plan
    Go To URL    events/all-campus
    Wait For Page Load Successfully V1

Go to review needed list
    Go To URL    events/review-needed
    Wait For Page Load Successfully V1

Go to send for approval
    Go To URL    events/send-for-approval
    Wait For Page Load Successfully V1

Go to past events
    Go To URL    events/past
    Wait For Page Load Successfully V1

Go to employer tax information
    ${is_correct_page} =      Go to URL   employer-tax-info
    Wait For Page Load Successfully V1
    [Return]    ${is_correct_page}

Go to referred-by page
    Go To URL    referred-by
    Wait For Page Load Successfully V1

Go to company information page
    Go to URL    settings/company-information/details
    wait for page load successfully v1

Go to brand management page
    Go to URL    settings/company-information/brand-management
    wait for page load successfully v1
