*** Settings ***
Resource            ../../pages/campaigns_page.robot
Resource            ../../pages/users_page.robot
Resource            ../../drivers/driver_chrome.robot
Library             Collections
Library             CSVLibrary

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

Documentation       Company Next Step: Keep no campaign in this company
...                 Company Data package off: No create Campaign in this cpmpany
...                 There are a few created companies and an created available campaign with name - Campaign in Active Status
...                 Company Geographic Targeting: Client Setup - Turn on Campaigns toggle
...                 Client Setup - More - Turn on Ratings toggle

*** Variables ***
${compose_conversation}                     campaign_candidate_conversation
${compose_rating_user}                      Rating for campaign with users
${compose_rating_candidate}                 Rating for campaign with candidates
${campaign_active_candidate}                Campaign in Active Status
${campaign_active_user}                     Campaign active status add audience is users
@{candidate_import_info}                    Jenny Ford    Ford    Jenny    nguyennnn+23@paradox.ai    906789456    Rachel Ford    nguyennnn+23@paradox.ai
...                                         906789543    Rachel    Ford    Group A    Florida    7777    8888
${campaign_active_with_different_mails}     Campaign in active status when send different emails
${campaign_active}                          Campaign in Active Status
${campaign_active_add_users}                Campaign active status add audience is users
${campaign_active_add_candidates_part1}     Campaign active status add audience is candidates - Part 1

*** Test Cases ***
Check page in empty state (OL-T1645)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go To Campaigns Page
    Check empty state       Active      You haven't sent any campaigns yet.
    Check empty state       Drafts      You haven't created any drafts yet
    Check empty state       Scheduled       There are no scheduled campaigns.


Audience is Candidate - Create Message Campaign is successfully (OL-T1588)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     audience_type=Candidates    channel=SMS
    Delete a Campaign       ${campaign_name}


Audience is Candidate - Create Conversation Campaign is successfully (OL-T1590)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     audience_type=Candidates    channel=SMS     compose_campaign_type=Conversation      campaign_type_option=${compose_conversation}
    Delete a Campaign       ${campaign_name}


Audience is Candidate - Create Conversation Campaign unsuccessfully in case select time has elapsed (OL-T1591, OL-T1593, OL-T1589)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Candidates
    Verify schedule tab after campaign composing when select time has elapsed       SMS     Conversation    campaign_type_option=${compose_conversation}
    # Audience is Candidate - Create Rating Campaign unsuccessfully in case select time has elapsed (OL-T1593)
    Verify schedule tab after campaign composing when select time has elapsed       SMS     Rating      campaign_type_option=${compose_rating_candidate}
    # Audience is Candidate - Create Message Campaign unsuccessfully in case select time has elapsed (OL-T1589)
    Verify schedule tab after campaign composing when select time has elapsed       SMS
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Wait For Page Load Successfully V1
    Delete a Campaign       ${campaign_name}    Drafts


Verify Full user - Edit Everything only see the campaigns created by themselves (OL-T1642)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Search a Campaign       ${campaign_active_candidate}    Active
    Capture Page Screenshot
    Switch To User Old Version      ${EE_TEAM}
    Click at    ${CAMPAIGN_PAGE_TAB_ITEM}       Active
    Input into      ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}       ${campaign_active_candidate}
    Check Element Not Display On Screen     ${campaign_active_candidate}
    Capture Page Screenshot


Verify Paradox Admin only view all campaigns which is created from another user (OL-T1640)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Switch To User Old Version      ${EE_TEAM}
    ${campaign_name_ee}=    Create New Campaign     audience_type=Candidates    channel=SMS
    Switch To User Old Version      ${CA_TEAM}
    Go To Campaigns Page
    ${campaign_name_ca}=    Create New Campaign     audience_type=Candidates    channel=SMS
    Switch To User Old Version      ${TEAM_USER}
    Search A Campaign       ${campaign_active_candidate}    Active
    Check Text Display      ${campaign_active_candidate}
    Capture Page Screenshot
    Go To Campaign Detail Page      ${campaign_name_ee}     Scheduled
    Input into      ${NEW_CAMPAIGN_TITLE}       ${campaign_name_ee}_edited
    Click At    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Go To Campaign Detail Page      ${campaign_name_ca}     Scheduled
    Input into      ${NEW_CAMPAIGN_TITLE}       ${campaign_name_ca}_edited
    Click At    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Delete A Campaign       ${campaign_name_ee}_edited
    Reload Page
    Delete A Campaign       ${campaign_name_ca}_edited


Audience is Users - Multilingual languages - Message type (OL-T1696, OL-T1697)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Users       Add Users
    Create new Campaign / Set Compose step      SMS     Message
    Select compose language     Spanish     Vietnamese
    Verify introduction language display
    # Audience is Users - Multilingual languages - Rating type (OL-T1697)
    # Set campaign type to Rating
    Create new Campaign / Set Compose step      SMS     Rating      ${compose_rating_user}
    Verify introduction language display
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete A Campaign       ${campaign_name}    Drafts


Verify in case Candidate option is selected at Audience dropdown (OL-T1698, OL-T1767)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Candidates
    Check Text Display      Candidate Match
    Verify Text Contain     ${NEW_CAMPAIGN_LIST_HEADER}     Name
    Verify Text Contain     ${NEW_CAMPAIGN_LIST_HEADER}     Type
    Verify Text Contain     ${NEW_CAMPAIGN_LIST_HEADER}     First contact
    Verify Text Contain     ${NEW_CAMPAIGN_LIST_HEADER}     Last contact
    Capture Page Screenshot
    # Audience is Candidate - Verify Compose tab (OL-T1767)
    Click At    ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Check Element Display On Screen     ${NEW_CAMPAIGN_MULTILINGUAL_BUTTON}
    Verify Text Contain     ${NEW_CAMPAIGN_COMPOSE_SENDER_FORM}     Olivia
    ${sms_is_default}=      Check The Checkbox      ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}     SMS
    Should Not Be True      ${sms_is_default}
    Capture Page Screenshot
    Click at    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Check Element Display On Screen     ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}    Message
    Check Element Display On Screen     ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}    Conversation
    Check Element Display On Screen     ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}    Rating
    Check Element Display On Screen     ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}    Scheduling
    Capture Page Screenshot
    ${event_is_off}=    Uncheck The Checkbox    ${NEW_CAMPAIGN_COMPOSE_EVENT_CHECKBOX}
    Should Not Be True      ${event_is_off}
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete A Campaign       ${campaign_name}    Drafts


Audience is Candidate - Multilingual languages - Message type (OL-T1777, OL-T1778, OL-T1776)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Candidates
    Create new Campaign / Set Compose step      SMS     Message
    Select compose language     Spanish     Vietnamese
    Verify introduction language display
    # Audience is Candidate - Multilingual languages - Rating type (OL-T1778)
    Create new Campaign / Set Compose step      SMS     Rating      ${compose_rating_candidate}
    Verify introduction language display
    # Audience is Candidate - Multilingual languages - Rating type (OL-T1776)
    Create new Campaign / Set Compose step      SMS     Conversation    ${compose_conversation}
    Verify introduction language display
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete A Campaign       ${campaign_name}    Drafts


Audience is Users - Create Message Campaign is successfully (OL-T1594, OL-T1586)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     SMS     Users
    Delete a Campaign       ${campaign_name}


Audience is Candidate - Event checkbox (OL-T1772)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Candidates
    Create new Campaign / Set Compose step      SMS     Message
    ${event_is_off}=    Uncheck The Checkbox    ${NEW_CAMPAIGN_COMPOSE_EVENT_CHECKBOX}
    Should Not Be True      ${event_is_off}
    Capture Page Screenshot
    Check The Checkbox      ${NEW_CAMPAIGN_COMPOSE_EVENT_CHECKBOX}
    Check Element Display On Screen     ${NEW_CAMPAIGN_COMPOSE_EVENT_DROPDOWN}
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete A Campaign       ${campaign_name}    Drafts


Audience is Users - Verify Send Message functional (OL-T1626)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Go To Campaign Detail Page      ${campaign_active_candidate}    Active
    Click At    ${CAMPAIGN_ACTIVE_SELECT_ALL_CHECKBOX}
    Click At    ${CAMPAIGN_ACTIVE_SEND_MESSAGE_BUTTON}
    Input Into      ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}     Test Send Message functional
    ${test_message}=    Generate random name    test_message
    Simulate Input      ${CAMPAIGN_ACTIVE_EMAIL_MESSAGE_INPUT}      ${test_message}
    Click At    ${CAMPAIGN_ACTIVE_EMAIL_SEND_BUTTON}
    Check Text Display      Sent successfully
    Capture Page Screenshot
    Click At    ${CAMPAIGN_ITEM_ECLIPSE_FIRST_USER_BUTTON}
    Click At    ${CAMPAIGN_VIEW_IN_INBOX_FIRST_BUTTON}
    Check Text Display      ${test_message}
    Capture Page Screenshot


Audience is Candidates - Verify Send Message functional (OL-T1627)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Go To Campaign Detail Page      ${campaign_active_user}     Active
    Click At    ${CAMPAIGN_ACTIVE_SELECT_ALL_CHECKBOX}
    Click At    ${CAMPAIGN_ACTIVE_SEND_MESSAGE_BUTTON}
    Input Into      ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}     Test Send Message functional
    ${test_message}=    Generate random name    test_message
    Simulate Input      ${CAMPAIGN_ACTIVE_EMAIL_MESSAGE_INPUT}      ${test_message}
    Click At    ${CAMPAIGN_ACTIVE_EMAIL_SEND_BUTTON}
    Check Text Display      Sent successfully
    Capture Page Screenshot
    Click At    ${CAMPAIGN_ITEM_ECLIPSE_FIRST_USER_BUTTON}
    Click At    ${CAMPAIGN_VIEW_IN_INBOX_FIRST_BUTTON}
    Check Text Display      ${test_message}
    Capture Page Screenshot


Audience is Candidate - Verify 'Send a Test' functional with Message Campaign (OL-T1773, OL-T1774, OL-T1775)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Candidates
    ${return_message}=      Create new Campaign / Set Compose step      Email       Message
    ${title_mail}=      Set Variable    Title ${return_message}
    ${message_mail}=    Set Variable    Message ${return_message}
    Send mail to Audience and verify mail       subject=${title_mail}       content=${message_mail}
    # Audience is Candidate - Verify 'Send a Test' functional with Conversation Campaign (OL-T1774)
    ${return_message}=      Create new Campaign / Set Compose step      Email       Conversation    ${compose_conversation}
    ${title_mail}=      Set Variable    Title ${return_message}
    ${message_mail}=    Set Variable    Message ${return_message}
    Send mail to Audience and verify mail       subject=${title_mail}       content=${message_mail}
    # Audience is Candidate - Verify 'Send a Test' functional with Rating Campaign (OL-T1775)
    ${return_message}=      Create new Campaign / Set Compose step      Email       Rating      ${compose_rating_candidate}
    ${title_mail}=      Set Variable    Title ${return_message}
    ${message_mail}=    Set Variable    Message ${return_message}
    Send mail to Audience and verify mail       subject=${title_mail}       content=${message_mail}
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete a Campaign       ${campaign_name}    Draft


Audience is users - Verify 'Send a Test' functional with Message Campaign (OL-T1692)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Users       Add Users
    ${return_message}=      Create new Campaign / Set Compose step      Email       Message
    ${title_mail}=      Set Variable    Title ${return_message}
    ${message_mail}=    Set Variable    Message ${return_message}
    Send mail to Audience and verify mail       subject=${title_mail}       content=${message_mail}
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete a Campaign       ${campaign_name}    Draft


Audience is Candidate - Verify Chanel option in case Import file with there are no email for candidates (OL-T1770)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Upload List     file_name=campaign_candidates_02
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check Element Not Display On Screen     ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}     Email       wait_time=1s
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Delete A Campaign       ${campaign_name}    Draft


Audience is Candidate - Verify importing is correct info of candidates (OL-T1766)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Import CSV file     file_name=campaign_candidates_03
    FOR  ${item}  IN  @{candidate_import_info}
        Check Text Display      ${item}
    END
    Capture Page Screenshot


Audience is Candidate - Verify Chanel option in case Import file with there are no phone numbers for candidates (OL-T1769)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Upload List     file_name=campaign_candidates_02
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check Element Not Display On Screen     ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}     SMS     wait_time=1s
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Delete A Campaign       ${campaign_name}    Draft


Check Search function in all tabs (OL-T1643, OL-T1644)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go To Campaigns Page
    Check all campaigns after clear searched data       ${campaign_active}      Active
    Go To Campaigns Page
    ${campaign_name_in_scheduled_status}=       Create New Campaign     Email       Users       audience_filter=Add Users
    # Verify check the page when user clears search keyword (OL-T1644)
    Check all campaigns after clear searched data       ${campaign_name_in_scheduled_status}    Scheduled
    Pause a Campaign
    Check all campaigns after clear searched data       ${campaign_name_in_scheduled_status}    Paused
    ${campaign_name_in_drafts_status} =     Create New Campaign     Email       Users       audience_filter=Add Users       campaign_status=Drafts
    Go To Campaigns Page
    Check all campaigns after clear searched data       ${campaign_name_in_drafts_status}       Drafts
    Delete a Campaign       ${campaign_name_in_drafts_status}       Drafts
    Reload Page
    Delete a Campaign       ${campaign_name_in_scheduled_status}    Paused


Verify when click Add New Campaign (OL-T1649, OL-T1689, OL-T1698, OL-T1641, OL-T1646)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_GEOGRAPHIC_TARGETING}
    Go To Campaigns Page
    # Verify check pagination in case the page has many items (OL-T1646)
    Check pagination in case the page has many items
    Check load data successfully when scroll down
    ${campaign_name} =      Create new Campaign / Set Title
    Check UI title and audience tab
    # Audience is Users - Verify Compose tab (OL-T1689)
    Create new Campaign / Set Audience      audience_type=Candidates    audience_filter=All Candidates
    # Verify in case campaign option is selected at Audience dropdown (OL_T1698)
    Check UI title and audience tab when campaign option is selected at Audience dropdown
    Create new Campaign / Set Compose step      Email
    Check UI compose tab
    # Verify Company Admin users only see the campaigns created by themselves (OL-T1641)
    Create new Campaign / Set Schedule step
    Search a Campaign       ${campaign_name}    Scheduled
    Click At    ${campaign_name}
    Input into      ${NEW_CAMPAIGN_TITLE}       New ${campaign_name}
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Schedule
    Click at    ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Click at    ${NEW_CAMPAIGN_CONFIRM_POPUP_CONFIRM_BUTTON}
    Delete a Campaign       New ${campaign_name}


Verify in case Users is selected at Audience dropdown (OL-T1651)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name} =      Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Users     audience_filter=All Users
    Check UI title and audience tab when campaign option is selected at Audience dropdown
    Check Element Display On Screen     ${NEW_CAMPAIGN_USER_MATCH_LIST}     ${CA_TEAM}
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_USER_LAST_CLOSE_BUTTON}      All Users
    Click at    ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Users:
    Check list role displayed at Select Audience
    Click At    ${NEW_CAMPAIGN_USER_CANCEL_BUTTON}
    Check Element Not Display On Screen     ${NEW_CAMPAIGN_USER_LAST_CLOSE_BUTTON}      All Users       wait_time=2s
    Check Element Display On Screen     ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Users:
    Check Element Display On Screen     ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Add Filter
    Capture Page Screenshot


Audience is Users - Duplicate Campaign (OL-T1612)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     SMS     Users       audience_filter=Add Users
    Duplicate a Campaign    ${campaign_name}
    Delete a Campaign       Copy - ${campaign_name}
    Reload Page
    Delete a Campaign       ${campaign_name}    Scheduled


Audience is Candidate - Duplicate Campaign (OL-T1611)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     SMS     Candidates      audience_filter=All Candidates
    Duplicate a Campaign    ${campaign_name}
    Delete a Campaign       Copy - ${campaign_name}     Scheduled
    Reload Page
    Delete a Campaign       ${campaign_name}    Scheduled


Audience is Users - View in Inbox of Campaign (OL-T1624)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Search a Campaign       ${campaign_active_add_users}    Active
    Click At    ${campaign_active_add_users}
    ${user_list_in_campaign}=       Get value list      ${CAMPAIGN_LIST_AUDIENCE_TEXT}
    Click At    ${CAMPAIGN_ITEM_ECLIPSE_FIRST_USER_BUTTON}
    Click At    ${CAMPAIGN_VIEW_IN_INBOX_FIRST_BUTTON}
    ${user_list_in_candidate}=      Get value list      ${CAMPAIGN_LIST_AUDIENCE_IN_CANDIDATE_BOX_TEXT}
    Lists Should Be Equal       ${user_list_in_campaign}    ${user_list_in_candidate}
    Capture page screenshot


Audience is Candidate - View in Inbox of Campaign (OL-T1617)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Search a Campaign       ${campaign_active_add_candidates_part1}     Active
    Click At    ${campaign_active_add_candidates_part1}
    Check Element Display On Screen     ${CAMPAIGN_NAME_TITLE}      ${campaign_active_add_candidates_part1}
    Capture Page Screenshot
    ${user_list_in_campaign}=       Get value list      ${CAMPAIGN_LIST_AUDIENCE_TEXT}
    Click At    ${CAMPAIGN_ITEM_ECLIPSE_FIRST_USER_BUTTON}
    Click At    ${CAMPAIGN_VIEW_IN_INBOX_FIRST_BUTTON}
    ${user_list_in_candidate}=      Get value list      ${CAMPAIGN_LIST_AUDIENCE_IN_CANDIDATE_BOX_TEXT}
    Lists Should Be Equal       ${user_list_in_campaign}    ${user_list_in_candidate}
    Capture page screenshot


Audience is Users - Verify Chanel option (OL-T1690)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name} =      Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Users     role=${CP_ADMIN}    audience_filter=All Users
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check SMS tab is shown after being selected
    Check SMS tab is shown after being selected     action=Do not add
    Check Email tab is shown after being selected
    Check The Checkbox      ${NEW_CAMPAIGN_SMS_CHANNEL_CHECKBOX}
    Check both channels are available after select both SMS and Email
    ${return_message} =     Generate random name    auto_message
    Check SMS tab is shown after being selected     action=Do not add
    Click At    ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}
    ${title_mail}=      Set Variable    Title ${return_message}
    ${message_mail}=    Set Variable    Message ${return_message}
    Simulate Input      None    ${title_mail}
    Click At    ${NEW_CAMPAIGN_EMAIL_CHANNEL_MESSAGE_BOX}
    Simulate Input      None    ${message_mail}
    Click at    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Click at    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}    Message
    Send mail to Audience and verify mail       subject=${title_mail}       content=${message_mail}
    Create new Campaign / Set Schedule step
    Delete a Campaign       ${campaign_name}


Audience is Candidates - Verify Chanel option (OL-T1768)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name} =      Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Candidates    audience_filter=All Candidates
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check SMS tab is shown after being selected
    Check SMS tab is shown after being selected     action=Do not add
    Check Email tab is shown after being selected
    Check The Checkbox      ${NEW_CAMPAIGN_SMS_CHANNEL_CHECKBOX}
    Check both channels are available after select both SMS and Email
    ${return_message} =     Generate random name    auto_message
    Check SMS tab is shown after being selected     action=Do not add
    Click At    ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}
    ${title_mail}=      Set Variable    Title ${return_message}
    ${message_mail}=    Set Variable    Message ${return_message}
    Simulate Input      None    ${title_mail}
    Click At    ${NEW_CAMPAIGN_EMAIL_CHANNEL_MESSAGE_BOX}
    Simulate Input      None    ${message_mail}
    Click at    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Click at    ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}    Message
    Send mail to Audience and verify mail       subject=${title_mail}       content=${message_mail}
    Create new Campaign / Set Schedule step
    Delete a Campaign       ${campaign_name}


Audience is Users - Verify Campaign Type (OL-T1691)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name} =      Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Users     role=${CP_ADMIN}    audience_filter=All Users
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check The Checkbox      ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}     SMS
    Check no secondary dropdown in Campaign Type is Message
    Check secondary dropdown in Campaign Type       Rating      Select rating
    Reload Page
    Handle Alert    ACCEPT
    Go To Campaigns Page
    Delete A Campaign       ${campaign_name}    Drafts


Audience is Candidate - Verify Campaign Type (OL-T1771)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Candidates    audience_filter=All Candidates
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check The Checkbox      ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}     SMS
    Check no secondary dropdown in Campaign Type is Message
    Check secondary dropdown in Campaign Type       Rating      Select rating
    Check secondary dropdown in Campaign Type       Conversation    Select conversation
    Reload Page
    Handle Alert    ACCEPT
    Go To Campaigns Page
    Delete A Campaign       ${campaign_name}    Drafts


Verify Paradox Admin, Company Admin and Full User Edit Everything can create campaign (OL-T1639)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     SMS     Candidates      audience_filter=All Candidates
    Search A Campaign       ${campaign_name}    Scheduled
    Check User can not see campaign     ${EN_TEAM}      ${campaign_name}
    Check User can not see campaign     ${HM_TEAM}      ${campaign_name}
    Check User can not see campaign     ${RC_TEAM}      ${campaign_name}
    Switch To User      ${TEAM_USER}
    Delete A Campaign       ${campaign_name}    Scheduled


Audience is Users - Create Rating Campaign is successfully (OL-T1598, OL-T1585)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Users     role=Select all     audience_filter=All Users
    Create new Campaign / Set Compose step      SMS     Rating      ${compose_rating_user}
    # Verify Create Campaign is successfully with audience is user (OL-T1585)
    Check message when a campaign is created in the schedule stage
    Delete A Campaign       ${campaign_name}    Scheduled


Audience is Candidate - Create Rating Campaign is successfully (OL-T1592)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Candidates    audience_filter=All Candidates
    Create new Campaign / Set Compose step      SMS     Rating      ${compose_rating_candidate}
    Check message when a campaign is created in the schedule stage
    Delete A Campaign       ${campaign_name}    Scheduled


Audience is Users - Create Rating Campaign unsuccessfully in case select time has elapsed (OL-T1599)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Users     role=Select all     audience_filter=All Users
    Verify schedule tab after campaign composing when select time has elapsed       SMS     Rating      campaign_type_option=${compose_rating_user}
    Reload Page
    Handle Alert    ACCEPT
    Go To Campaigns Page
    Delete A Campaign       ${campaign_name}    Drafts


Audience is Users - Create Message Campaign unsuccessfully in case select time has elapsed (OL-T1587, OL-T1595)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      audience_type=Users     role=Select all     audience_filter=All Users
    # Verify Audience is Users - Create Message Campaign unsuccessfully in case select time has elapsed (OL-T1595)
    Verify schedule tab after campaign composing when select time has elapsed       SMS     Message
    Reload Page
    Handle Alert    ACCEPT
    Go To Campaigns Page
    Delete A Campaign       ${campaign_name}    Drafts


Audience is users - Can not Add new users to Sent Campaign (OL-T1610)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Search A Campaign       ${campaign_active_with_different_mails}     Active
    ${email_address_01}=    Check actions after campaign changed active status      campaign_name=New ${campaign_active_with_different_mails}       is_changed_name=True
    Search A Campaign       New ${campaign_active_with_different_mails}     Active
    Check actions after campaign changed active status      campaign_name=New ${campaign_active_with_different_mails}       need_checking=False     different_email_address=${email_address_01}


Audience is Candidate - Check when Upload CSV file (OL-T1765)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Title & Audience
    Check data is detected from the csv file    ${CAMPAIGN_CSV_ROW_NAME}
    Check data is detected from the csv file    ${CAMPAIGN_EXAMPLE_VALUE_ROW_NAME}      index_row=1     is_clicked=False
    Click At    ${NEW_CAMPAIGN_AUDIENCE_UPLOAD_APPLY_BUTTON}
    Check data is detected from the csv file    ${CAMPAIGN_CANDIDATES_NAME_MATCHING_ROW_NAME}       list=List Candidate Name    is_imported=False
    Check Element Display On Screen     ${CAMPAIGN_CANDIDATE_MATCH_TEXT}    3
    Capture Page Screenshot

*** Keywords ***
Check data is detected from the csv file
    [Arguments]     ${locator}       ${index_row}=0       ${list}=List Header       ${is_clicked}=None      ${is_imported}=None
    ${header_list_from_csv}=    Check data from csv file      ${index_row}      ${list}      ${is_clicked}      ${is_imported}
    ${header_list_uploaded}=     Get value list     ${locator}
    Lists Should Be Equal       ${header_list_uploaded}    ${header_list_from_csv}
    Capture page screenshot

Check data from csv file
    [Arguments]    ${index_row}=0         ${list}=List Header     ${is_clicked}=None      ${is_imported}=None
    IF  '${is_imported}' == 'None'
        ${file_path}=   Import CSV file     campaign_candidates_05      ${is_clicked}
    ELSE
        ${file_path}=  get_path_upload_csv   campaign_candidates_05
    END
    @{header_list_from_csv}=  read csv file to list  ${file_path}
    @{new_list}=    Create List
    IF  '${list}' == 'List Header'
        FOR    ${value}    IN    @{header_list_from_csv[${index_row}]}
            Append To List    ${new_list}    ${value.strip()}
        END
    ELSE
        @{index_list}=       Create List    1    2   3
        FOR   ${index}    IN     @{index_list}
            Append To List    ${new_list}    ${header_list_from_csv}[${index}][1] ${header_list_from_csv}[${index}][0]
        END
    END
    [Return]        ${new_list}

Check actions after campaign changed active status
    [Arguments]         ${campaign_name}        ${need_checking}=None       ${different_email_address}=None     ${is_changed_name}=None
    Click At    ${campaign_active_with_different_mails}
    Click At    ${CAMPAIGN_ACTIVE_SETTING_ICON}
    Click At    ${CAMPAIGN_SETTING_EDIT_NAME_BUTTON}
    IF  '${need_checking}' == 'None'
        IF  '${is_changed_name}' != 'None'
            Input into      ${NEW_CAMPAIGN_TITLE}   ${campaign_name}
        END
        Check Element Not Display On Screen    ${NEW_CAMPAIGN_AUDIENCE_TYPE}  Add Filter
        Capture Page Screenshot
    END
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Compose
    IF  '${need_checking}' == 'None'
        Verify Element Is Disable    ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_INPUT}   SMS
        Verify Element Is Disable    ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_INPUT}   Email
        ${class}=      Get Element Attribute        ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}  class
        Should Contain  ${class}      disabled
        Capture Page Screenshot
    END
    ${title_mail}=      Set Variable    Tilte for sending different emails
    ${message_mail}=    Set Variable    Message for sending different emails
    &{email_info} =     Get email for testing       False
    Send mail to Audience and verify mail     subject=${title_mail}       content=${message_mail}
    IF  '${different_email_address}' != 'None'
        ${is_existed_mail}=     Run Keyword And Return Status    Verify user has received the email            subject=${title_mail}       content=${message_mail}
        IF  '${is_existed_mail}' == False
            Should Be Equal As Strings    ${is_existed_mail}    False
        END
    END
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Schedule
    IF  '${need_checking}' == 'None'
        Verify Element Is Disable    ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR}
        Check Element Display On Screen        ${NEW_CAMPAIGN_SCHEDULE_TIME_DISABLE_SELECTOR}
        Check Element Display On Screen        ${NEW_CAMPAIGN_SCHEDULE_MIDDLE_DISABLE_SELECTOR}
        Capture Page Screenshot
    END
    Click at  ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    [Return]    ${email_info.email}

Check empty state
    [Arguments]    ${tab_name}  ${empty_msg}
    Click At    ${CAMPAIGN_PAGE_TAB_ITEM}   ${tab_name}
    Check Text Display    ${empty_msg}
    Check Element Display On Screen    ${CAMPAIGN_PAGE_EMPTY_NEW_CAMPAIGN_BUTTON}
    Capture Page Screenshot

Verify introduction language display
    ${active_tab}=  Get Text And Format Text    ${NEW_CAMPAIGN_MULTILINGUAL_ACTIVE_TAB}
    Should Be Equal As Strings    ${active_tab}     English
    Verify Text Contain    ${NEW_CAMPAIGN_MULTILINGUAL_LANGUAGES_SELECTED}  Spanish
    Verify Text Contain    ${NEW_CAMPAIGN_MULTILINGUAL_LANGUAGES_SELECTED}  Vietnamese
    Capture Page Screenshot

    Click At    ${NEW_CAMPAIGN_MULTILINGUAL_TAB}    Vietnamese
    Click at  ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
    Clear Element Text With Keys      ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
    Simulate Input  None  xin chao
    Check Text Display    xin chao
    Capture Page Screenshot

Check message when a campaign is created in the schedule stage
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Schedule
    Click at  ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR}
    ${future_date} =    get_future_date
    Click at  ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR_VALUE}  ${future_date}
    Click at  ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Check Element Display On Screen    ${CAMPAIGN_SCHEDULE_POPUP}
    Check Element Display On Screen    ${CAMPAIGN_SCHEDULE_MESSAGE}    By clicking confirm, you confirm that you have obtained all appropriate consents from the message recipient(s) as required by applicable law. If you cannot provide such confirmation, you must not move forward with this campaign.
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_EMAIL_CONFIRM_BUTTON}    Confirm

Check User can not see campaign
    [Arguments]    ${user_name}      ${campaign_name}=None
    Go to CEM page
    Switch To User    ${user_name}
    Click at    ${MENU_SPAN}
    ${is_exist}=    Run Keyword And Return Status    Check Element Not Display On Screen    ${MENU_SETTINGS_ITEM_LINK}   Campaigns    wait_time=2s
    IF  '${is_exist}' == 'False'
        Go To Campaigns Page
        Click at    ${CAMPAIGN_PAGE_TAB_ITEM}       Scheduled
        Input into      ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}       ${campaign_name}
        Check Element Not Display On Screen     ${campaign_name}    wait_time=2s
    END
    Capture Page Screenshot

Check no secondary dropdown in Campaign Type is Message
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}      Message
    Check Element Not Display On Screen    ${NEW_CAMPAIGN_SECONDARY_DROPDOWN}   Select message      wait_time=2s
    Check Element Display On Screen    ${NEW_CAMPAIGN_SMS_CHANNEL_TITLE}
    Check Element Display On Screen    ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
    Capture Page Screenshot

Check secondary dropdown in Campaign Type
    [Arguments]    ${campaign_type}     ${secondary_dropdown}
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}      ${campaign_type}
    Check Element Display On Screen    ${NEW_CAMPAIGN_SECONDARY_DROPDOWN}      ${secondary_dropdown}
    Capture Page Screenshot

Check SMS tab is shown after being selected
    [Arguments]    ${action}=add
    IF  '${action}' == 'add'
        Check The Checkbox    ${NEW_CAMPAIGN_SMS_CHANNEL_CHECKBOX}
        Check Element Display On Screen    ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
    ELSE
        Uncheck The Checkbox    ${NEW_CAMPAIGN_SMS_CHANNEL_CHECKBOX}
    END
    Capture Page Screenshot

Check Email tab is shown after being selected
    [Arguments]          ${action}=add
    IF  '${action}' == 'add'
        Check The Checkbox    ${NEW_CAMPAIGN_EMAIL_CHANNEL_CHECKBOX}
        Check Element Display On Screen    ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}
        Check Element Display On Screen    ${NEW_CAMPAIGN_EMAIL_CHANNEL_MESSAGE_BOX}
    ELSE
        Uncheck The Checkbox    ${NEW_CAMPAIGN_EMAIL_CHANNEL_CHECKBOX}
    END
    Capture Page Screenshot

Check both channels are available after select both SMS and Email
    Check Element Display On Screen    ${NEW_CAMPAIGN_SMS_CHANNEL_TAB}
    Check Element Display On Screen    ${NEW_CAMPAIGN_EMAIL_CHANNEL_TAB}
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_SMS_CHANNEL_TAB}
    Check Element Display On Screen    ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_EMAIL_CHANNEL_TAB}
    Check Element Display On Screen    ${NEW_CAMPAIGN_TITLE_EMAIL_BOX}
    Check Element Display On Screen    ${NEW_CAMPAIGN_EMAIL_CHANNEL_MESSAGE_BOX}
    Capture Page Screenshot

Get value list
    [Arguments]    ${locator}
    @{item_list} =    Create List
    @{item_elements} =    Get WebElements    ${locator}
    FOR    ${element}    IN    @{item_elements}
        ${user}=    Get Text And Format Text      ${element}
        IF  "${user}" == '${EMPTY}'
            Continue For Loop
        END
        Append To List    ${item_list}    ${user}
    END
    [Return]    ${item_list}

Check all campaigns after clear searched data
    [Arguments]    ${campaign_name}         ${campaign_tab}=Scheduled
    Click At    ${CAMPAIGN_PAGE_TAB_ITEM}   ${campaign_tab}
    ${user_list_before_searching}=     Get value list     ${CAMPAIGN_TABLE_ROW_NAME}
    Search a Campaign       ${campaign_name}    ${campaign_tab}
    Click At    ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}
    Clear Element Text With Keys      ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}
    Wait For Page Load Successfully V1
    ${user_list_after_searching}=     Get value list     ${CAMPAIGN_TABLE_ROW_NAME}
    Lists Should Be Equal       ${user_list_before_searching}      ${user_list_after_searching}
    Capture page screenshot

Check UI title and audience tab
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TEXT}       Title & Audience
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TEXT}       Compose
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TEXT}       Schedule
    Capture Page Screenshot

Check UI title and audience tab when campaign option is selected at Audience dropdown
    Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     Name
    Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     Type
    Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     First contact
    Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     Last contact
    Capture Page Screenshot

Check UI compose tab
    Check Element Display On Screen    ${NEW_CAMPAIGN_MULTILINGUAL_BUTTON}
    Check Element Display On Screen    ${NEW_CAMPAIGN_AI_DEFAULT_BUTTON}
    Check Element Display On Screen    ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_CHECKBOX}     SMS
    Capture Page Screenshot
    Click at  ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN}
    Check Element Display On Screen      ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}  Message
    Check Element Display On Screen      ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_VALUE}  Rating
    Verify Element Is Enable    ${NEW_CAMPAIGN_SEND_A_TEST_BUTTON}
    Capture Page Screenshot

Check list role displayed at Select Audience
    @{list_role} =  Create list     Basic User  Full User - Edit Everything   Company Admin   Hiring Manager  Recruiter   Supervisor
    FOR  ${role}     IN      @{list_role}
         Check element display on screen     ${NEW_CAMPAIGN_USER_FILTER_CHECKBOX}    ${role}
    END
    Capture page screenshot

Check pagination in case the page has many items
    Check Element Display On Screen    ${CAMPAIGN_PAGE_TAB_ITEM}   Schedule
    Check Element Display On Screen    ${CAMPAIGN_PAGE_TAB_ITEM}   Active
    Check Element Display On Screen    ${CAMPAIGN_PAGE_TAB_ITEM}   Draft
    Capture Page Screenshot

Check load data successfully when scroll down
    @{status_campaign_list}=    Create List    Active    Scheduled      Drafts      Paused
    FOR   ${status_campaign}  IN   @{status_campaign_list}
        Click At    ${CAMPAIGN_PAGE_TAB_ITEM}   ${status_campaign}
        Load full Campaign in page
        ${campaign_list} =      Get WebElements    ${CAMPAIGN_TABLE_ROW_NAME}
        Continue For Loop If    '${campaign_list}' == '${EMPTY}'
        ${campaign_number} =   Get Length  ${campaign_list}
        ${campaign_title}=   Format String       ${CAMPAIGN_PAGE_TAB_ITEM}      ${status_campaign}
        ${campaign_number_title} =  Get Text     ${campaign_title}
        ${campaign_number_test} =    Convert To String   ${campaign_number}
        Should Contain  ${campaign_number_title}    ${campaign_number_test}
        Check Element Display On Screen     ${CAMPAIGN_PAGE_TAB_ITEM}     ${campaign_number}
        Capture Page Screenshot
    END
