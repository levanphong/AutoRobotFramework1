*** Settings ***
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/custom_conversation_page.robot
Resource            ../../pages/applicant_flows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${landing_site_name}                ChatToApplyLandingSite
${widget_site_name}                 ChatToApplyWidget
${convo_name}                       Chat To Apply Single Path
${rule_title}                       Chat To Apply Cycle

#   ===SECTION: COMPANY_FRANCHISE_OFF_JOB_ON ===
# 1. Client setup - Job search is turn ON, and at least 1 feed is selected in "Search company"
# 1a. Client setup - Job search > Job Requisition ID search ON > Custom:\bREF+\d{5}[A-Z]+ and add field alpha
# 1b. Client setup - Job search > Chat-to-apply OFF
# 2. Landing site (widget, company site...) start interaction by Job search (job external)(name: ChatToApplyLandingSite)

#   ===SECTION: COMPANY_FRANCHISE_ON ===
# 1. Client setup - Job search is turn ON, and at least 1 feed is selected in "Search company"
# 1a. Client setup - Job search > Job Requisition ID search ON > Custom:\bREF+\d{5}[A-Z]+ and add field alpha
# 1b. Client setup - Job search > Chat-to-apply ON > Catch All Conversation ON and select a conversation
# 2. Landing site (widget, company site...) start interaction by Job search (job external)(name: ChatToApplyLandingSite)

#   ===SECTION: COMPANY_DATA_PACKAGE_OFF ===
# 1. Client setup - Job search is turn ON, and at least 1 feed is selected in "Search company"
# 1a. Client setup - Job search > Job Requisition ID search ON > Custom:\bREF+\d{5}[A-Z]+ and add field alpha
# 1b. Client setup - Job search > Chat-to-apply ON > Catch All Conversation ON and select a conversation
# 2. Landing site (widget, company site...) start interaction by Job search (job external)(name: ChatToApplyLandingSite)domain: prd-automation-team.github.io

*** Test Cases ***
Create data test for Chat To Apply
    [Tags]   lts_stg
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Add Single conversation with email only    ${convo_name}
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Turn on Job Requisition ID Search
    Turn on Chat to apply and select convo for catch all convo
    Add new targeting rule
    Create job search landing site/widget      Landing Site    ${landing_site_name}
    #   Set up to 'COMPANY_FRANCHISE_OFF_JOB_ON'
    Add company for testing     ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Turn on Job Requisition ID Search
    Turn off    ${JS_CHAT_TO_APPLY_TOGGLE}
    Save client setup page
    Turn on Candidate Care
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    #  Set up COMPANY_DATA_PACKAGE_OFF
    Add company for testing     ${COMPANY_DATA_PACKAGE_OFF}
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Turn on Job Requisition ID Search
    Turn on    ${JS_CHAT_TO_APPLY_TOGGLE}
    Turn off  ${CHAT_TO_APPLY_CATCH_ALL_CONVO_TOGGLE}
    Save client setup page
    Turn on Candidate Care
    Add Single conversation with email only   ${convo_name}
    Create job search landing site/widget    Widget Conversation   ${widget_site_name}  ${DOMAIN_SECURITY}

*** Keywords ***
Add new targeting rule
    #   Add title for rule
    Input into   ${CHAT_TO_APPLY_TITLE_TEXTBOX}   ${rule_title}
    CLick at   ${CHAT_TO_APPLY_ADD_BUTTON}
    #   Select conversation
    CLick at   ${CHAT_TO_APPLY_SELECT_CONVERSATION_DROPDOWN}
    Input into   ${CHAT_TO_APPLY_SELECT_CONVERSATION_SEARCH_TEXTBOX}   ${convo_name}
    CLick at   ${CHAT_TO_APPLY_SELECT_CONVERSATION_ITEM}    ${convo_name}
    #   Select channel
    CLick at   ${CHAT_TO_APPLY_SELECT_CHANNEL_DROPDOWN}
    CLick at   ${CHAT_TO_APPLY_SELECT_CHANNEL_ITEM}    Any
    #   Add condition
    CLick at   ${CHAT_TO_APPLY_ADD_CONDTION_BUTTON}
    CLick at   ${CHAT_TO_APPLY_ADD_AND_BUTTON}
    CLick at   ${CHAT_TO_APPLY_ADD_OR_BUTTON}
    #   Setting for condition number 1
    CLick at   ${CHAT_TO_APPLY_TYPE_DROPDOWN}   1
    CLick at   ${CHAT_TO_APPLY_TYPE_ITEM}   Job Req ID
    CLick at   ${CHAT_TO_APPLY_OPERATOR_DROPDOWN}   1
    CLick at   ${CHAT_TO_APPLY_OPERATOR_ITEM}   contains
    #   In order to close dropdown
    CLick at   Determine what jobs this conversation will appear for.
    Simulate Input   ${CHAT_TO_APPLY_MATCH_VALUE_TEXTBOX}   ${AUTOMATION_TESTER_REQ_ID_003}   1
    #   Setting for condition number 2
    CLick at   ${CHAT_TO_APPLY_TYPE_DROPDOWN}   2
    CLick at   ${CHAT_TO_APPLY_TYPE_ITEM}   Job Title
    CLick at   ${CHAT_TO_APPLY_OPERATOR_DROPDOWN}   2
    CLick at   ${CHAT_TO_APPLY_OPERATOR_ITEM}   contains
    #   In order to close dropdown
    CLick at   Determine what jobs this conversation will appear for.
    Simulate Input   ${CHAT_TO_APPLY_MATCH_VALUE_TEXTBOX}   ${AUTOMATION_TESTER_TITLE_003}  2
    #   Setting for condition number 3
    CLick at   ${CHAT_TO_APPLY_TYPE_LAST_DROPDOWN}
    CLick at   ${CHAT_TO_APPLY_TYPE_ITEM}   Job Req ID
    CLick at   ${CHAT_TO_APPLY_OPERATOR_LAST_DROPDOWN}
    CLick at   ${CHAT_TO_APPLY_OPERATOR_ITEM}   contains
    #   In order to close dropdown
    CLick at   Determine what jobs this conversation will appear for.
    Simulate Input   ${CHAT_TO_APPLY_MATCH_LAST_VALUE_TEXTBOX}  ${AUTOMATION_TESTER_REQ_ID_005}  2
    CLick at   ${CHAT_TO_APPLY_SAVE_BUTTON}
    Save client setup page

