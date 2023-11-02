*** Settings ***
Resource            ../../pages/campaigns_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test
Library             Collections
Library             CSVLibrary
Documentation       Create all campaigns by manual in variables.
...                 These campaigns are in scheduled status.
...                 These campaigns are waited 15m for tranfering to active status.
...                 The audience is user or candidate depending on campaign name.

*** Variables ***
${campaign_active}                          Campaign in Active Status
${campaign_active_add_users}                Campaign active status add audience is users
${drip_campaign_active_add_candidates}      Drip campaign in active status add candidates
${campaign_active_add_candidates_part4}     Campaign active status add audience is candidates - Part 4
${drip_campaign_paused_status}              Drip campaign in paused status
${drip_campaign_active_add_users}           Drip campaign in active status add users
${conversation_single_path}                 Event_Convo_Single_Path
${event_name}                               Event single path for drip campaign

*** Test Cases ***
Verify Campaign List Options (OL-T2374, OL-T2377, OL-T2376)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates
    @{campaign_list}=       Create List     ${campaign_active}      ${campaign_active_add_users}
    Campaign step in Drip campaign      ${campaign_list}
    Click At    ${DRIP_CAMPAIGN_ECLIPSE_ICON}
    Check option in eclipse is shown
    # Verify Delete campaign at Camapign lists (OL-T2377)
    Click At    ${DRIP_CAMPAIGN_ECLIPSE_OPTION}     Delete
    Check confirm popup when delete a campaign
    Click At    ${DRIP_CAMPAIGN_DELETE_CAMPAIGN_DELETE_BUTTON}
    Check Element Not Display On Screen     ${DRIP_CAMPAIGN_NAME_ROW}       ${campaign_active_add_users}    wait_time=2s
    Capture Page Screenshot
    # Verify Duplicate campaign at Campaign list (OL-T2376)
    Click At    ${DRIP_CAMPAIGN_ECLIPSE_ICON}
    Click At    ${DRIP_CAMPAIGN_ECLIPSE_OPTION}     Duplicate
    Check Element Display On Screen     ${DRIP_CAMPAIGN_DUPLICATE_CAMPAIGN_MODAL}
    ${title} =      Get Value And Format Text       ${DRIP_CAMPAIGN_DETAIL_TITLE}
    Should Be Equal As Strings      ${title}    Copy of - ${campaign_active}
    Capture Page Screenshot
    Check data in compose tab is cloned the same with previous campaign
    Check Element Display On Screen     ${DRIP_CAMPAIGN_NAME_ROW}       Copy of - ${campaign_active}
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Delete A Campaign       ${campaign_name}    Drafts


Check UI in case user created more than 5 segments - Hire ON - incase login as User (OL-T2386)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Search A Campaign       ${drip_campaign_active_add_candidates}      Active
    Click At    ${drip_campaign_active_add_candidates}
    Check default is the first campaign
    ${title} =      Get Value And Format Text       ${DRIP_CAMPAIGN_VALUE_CAMPAIGN_TEXT}
    Should Be Equal As Strings      ${title}    ${campaign_active}
    Capture Page Screenshot
    Check all campaigns of drip campaign in dropdownlist
    Click At    ${DRIP_CAMPAIGN_VALUE_CAMPAIGN_ROW}     ${campaign_active}
    Check metrics from the campaign selected and empty state in the Drip Campaign


Verify Edit campaign at Camapign lists (OL-T2375)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates
    @{campaign_list}=       Create List     ${campaign_active}      ${campaign_active_add_users}
    Campaign step in Drip campaign      ${campaign_list}
    Click At    ${DRIP_CAMPAIGN_ECLIPSE_ICON}
    Click At    ${DRIP_CAMPAIGN_ECLIPSE_OPTION}     Edit
    Check Element Display On Screen     ${DRIP_CAMPAIGN_DRAWER}
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Simulate Input      ${DRIP_CAMPAIGN_MESSAGE_TEXT}       Edit Message
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Save Campaign
    Check Element Display On Screen     ${DRIP_CAMPAIGN_NAME_ROW}       ${campaign_active_add_users}
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Delete A Campaign       ${campaign_name}    Drafts


Campaign tab - Verify Title tab of Add Campaign Builder Drawer (OL-T2367, OL-T2368)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates
    ${campaign_name} =      Generate random name    auto_drip_campaign
    Campaign step in Drip campaign      ${campaign_name}
    Check Element Display On Screen     ${DRIP_CAMPAIGN_ADD_CAMPAIGN_TITLE}
    Simulate Input      ${DRIP_CAMPAIGN_ADD_CAMPAIGN_TITLE}     ${campaign_name}
    Check UI in Title and Audience step
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_NEXT_BUTTON}
    # Campaign tab - Verify Compose tab of Campaign Builder Drawer (OL-T2368)
    Check UI in Compose step
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_CANCEL_BUTTON}
    Reload Page
    Handle Alert    ACCEPT
    Delete A Campaign       ${drip_campaign_name}       Drafts


Candidate - Verify logic Filter is applied for Drip Campaign (OL-T2363)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Click at    ${NEW_CAMPAIGN_SELECT_AUDIENCE_DROPDOWN}
    Click at    ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Candidates
    Check Element Display On Screen     ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Add Filter
    Capture Page Screenshot
    Click at    ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Add Filter
    Input into      ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}     Add Candidates
    Click at    ${NEW_CAMPAIGN_AUDIENCE_FILTER_VALUE_OPTION}    Add Candidates
    Check audience match name will be listed


User - Verify logic Filter is applied for Drip Campaign (OL-T2364)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Click at    ${NEW_CAMPAIGN_SELECT_AUDIENCE_DROPDOWN}
    Click at    ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Users
    Click At    ${NEW_CAMPAIGN_USER_FILTER_CHECKBOX}    ${EDIT_EVERYTHING}
    Click At    ${NEW_CAMPAIGN_USER_APPLY_BUTTON}
    Check Element Display On Screen     ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Add Filter
    Capture Page Screenshot
    Click At    ${NEW_CAMPAIGN_AUDIENCE_TYPE}       Add Filter
    Input into      ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}     Add Users
    Click at    ${NEW_CAMPAIGN_AUDIENCE_FILTER_MAIN_VALUE}      Add Users
    Check audience match name will be listed


Verify 'Use an Existing Campaign' at Campaign tab (OL-T2366)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates
    ${audience_name_match_in_tile_and_audience_step}=       Get Text And Format Text    ${CAMPAIGN_CANDIDATES_NAME_MATCHING_ROW_NAME}
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Campaigns
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}
    Check Element Display On Screen     ${DRIP_CAMPAIGN_SELECT_AN_OPTION_POPUP}
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_OPTION}     Use an existing campaign template
    Check Element Display On Screen     ${DRIP_CAMPAIGN_TEMPLATE_DROPDOWN}
    Capture Page Screenshot
    ${audience_name_match_in_campaign_step}=    Check candidate is sent being cloned
    Should Be Equal     ${audience_name_match_in_tile_and_audience_step}    ${audience_name_match_in_campaign_step}
    ${drip_campaign_is_cloned}=     Get Text And Format Text    ${DRIP_CAMPAIGN_CONTENT_AND_FILTER_TEXT}
    Should Contain      ${drip_campaign_is_cloned}      ${drip_campaign_name}
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    Delete A Campaign       ${drip_campaign_name}       Drafts


Verify Add Campaign Builder Drawer for Candidate audience is successfully (OL-T2369, OL-T2371)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates
    Campaign step in Drip campaign      ${campaign_active}
    Input Into      ${DRIP_CAMPAIGN_ADD_CAMPAIGN_TITLE}     ${campaign_active}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Select Channel in Drip campaign
    Select Event in Drip campaign       ${event_name}
    # Verify Drip Campaign List (OL-T2371)
    Select campaign type    ${campaign_active_add_candidates_part4}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    Check Element Display On Screen     ${DRIP_CAMPAIGN_NAME_ROW}       ${campaign_active}
    ${first_campaign_to_deliver}=       Get Text And Format Text    ${DRIP_CAMPAIGN_FIRST_CAMPAIGN_ADDED_TEXT}
    Should Be Equal     ${first_campaign_to_deliver}    1st Campaign to deliver
    Capture Page Screenshot
    ${child_campaign_with_two_day_default}=     Format string       ${DRIP_CAMPAIGN_SECOND_CHILD_CAMPAIGN_TWO_DAY_APART_TEXT}       ${campaign_active_add_candidates_part4}
    ${two_days_apart}=      Get Value And Format Text       ${child_campaign_with_two_day_default}
    Should Be Equal     ${two_days_apart}       2 days apart
    Capture Page Screenshot
    Delete A Campaign       ${drip_campaign_name}       Drafts


Verify Add Campaign Builder Drawer for Users audience is successfully (OL-T2370)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Users
    Campaign step in Drip campaign      ${campaign_active}
    Input Into      ${DRIP_CAMPAIGN_ADD_CAMPAIGN_TITLE}     ${campaign_active}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Select Channel in Drip campaign
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    Check Element Display On Screen     ${DRIP_CAMPAIGN_NAME_ROW}       ${campaign_active}
    ${first_campaign_to_deliver}=       Get Text And Format Text    ${DRIP_CAMPAIGN_FIRST_CAMPAIGN_ADDED_TEXT}
    Should Be Equal     ${first_campaign_to_deliver}    1st Campaign to deliver
    Capture Page Screenshot
    Delete A Campaign       ${drip_campaign_name}       Drafts


Verify Campaign Modal is added (OL-T2361, OL-T2365)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    Click At    ${CAMPAIGN_PAGE_NEW_CAMPAIGN_BUTTON}
    Check modal to select the campaign type
    # Verify Campaign tab of Drip Campaign Builder (OL-T2365)
    Click at    ${CHOOSE_CAMPAIGN_TYPE_POPUP_TYPE_TEXT}     Drip Campaign
    Click at    ${NEW_CAMPAIGN_STEP_TEXT}       Title & Audience
    ${drip_campaign_name} =     Generate random name    auto_campaign
    Input into      ${DRIP_CAMPAIGN_TITLE}      ${drip_campaign_name}
    Create new Campaign / Set Audience      Candidates
    Click At    ${NEW_CAMPAIGN_STEP_TEXT}       Campaigns
    Check message when campaign tab has new status
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}
    Check campaign type option when add new campaign
    Click At    ${DRIP_CAMPAIGN_SELECT_AN_OPTION_CANCEL_BUTTON}
    Delete A Campaign       ${drip_campaign_name}       Drafts


Verify create drip campaign from the file import is successfully (OL-T2380)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Upload List     file_name=campaign_candidates_05
    # Candidate imported from csv file
    ${candidate_number}=    Get Text And Format Text    ${CAMPAIGN_CANDIDATES_NUMBER_TEXT}
    ${lower_candidate_number}=      Evaluate    "${candidate_number}".lower()
    ${candidate_name_in_imported_file}=     Check candidate name between in the added audience in drip campaign and duplicate candidate in campaign
    ${campaign_name} =      Input campaign name in drip campaign
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    # Subject and Message Email
    ${subject}=     Select Channel in Drip campaign
    Select Event in Drip campaign       ${event_name}
    Select campaign type    ${campaign_name}
    # Compare [Candidate imported from csv file] and [Candidate in child Campaign]
    ${candidate_name_in_template_campaign}=     Get Value List      ${DRIP_CAMPAIGN_ADDED_CAMPAIGN_CANDIDATE_ROW_NAME}
    Should Be Equal     ${candidate_name_in_imported_file}      ${candidate_name_in_template_campaign}
    Capture Page Screenshot
    Check no filter in compose step when create campaign
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    # Compare [Subject and Message Email] and [Subject and Message Email duplicate in child Template Campaign]
    Check data when duplicate campaign with email channel
    ${subject_in_template_campaign}=    Get Text And Format Text    ${DRIP_CAMPAIGN_ENTER_EMAIL_SUBJECT_TEXT}
    Should Be Equal     ${subject.name}     ${subject_in_template_campaign}
    ${title_in_template_campaign}=      Get Text And Format Text    ${DRIP_CAMPAIGN_ENTER_EMAIL_MESSAGE_TEXT}
    Should Be Equal     ${subject.message}      ${title_in_template_campaign}
    Capture Page Screenshot
    # Compare [Campaign type and event in new child drip campaign] and [Campaign type and event in duplicate new campaign]
    Campaign type and event when duplicate template child campaign
    # Schedule step of Drip Campaign
    Get future day for beginning drip campaign
    Get future day for ending drip campaign
    # Compare [Candidate imported from csv file] and [Candidate number in Campaign Confirmation]
    Check message when confirm schedule step
    ${candidate_number_conclusion}=     Get Text And Format Text    ${DRIP_CAMPAIGN_SCHEDULE_CONTAIN_AUDIENCES_MESSAGE}
    Should Contain      ${lower_candidate_number}       ${candidate_number_conclusion}
    Capture Page Screenshot
    Click at    ${NEW_CAMPAIGN_CONFIRM_POPUP_CONFIRM_BUTTON}
    Delete A Campaign       ${drip_campaign_name}       Scheduled


Verify create drip campaign with Candidate audience is successfully (OL-T2379)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Candidates      All Candidates
    ${candidate_number}=    Get Text And Format Text    ${CAMPAIGN_CANDIDATES_NUMBER_TEXT}
    ${lower_candidate_number}=      Evaluate    "${candidate_number}".lower()
    ${candidate_name_in_drip_campaign}=     Get Value List      ${CAMPAIGN_CANDIDATES_NAME_MATCHING_ROW_NAME}
    ${first_candidate_name}=    Get From List       ${candidate_name_in_drip_campaign}      0
    Campaign step in Drip campaign      One Campaign
    ${child_campaign_name}=     Input campaign name in drip campaign
    Select candidates in child campaign     ${first_candidate_name}
    # Compare [Candidate in drip campaign] and [Candidate in child drip campaign]
    ${candidate_name_in_child_campaign}=    Get Text And Format Text    ${DRIP_CAMPAIGN_ADDED_CAMPAIGN_CANDIDATE_ROW_NAME}
    Should Contain      ${candidate_name_in_drip_campaign}      ${candidate_name_in_child_campaign}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    ${subject}=     Select Channel in Drip campaign
    Select Event in Drip campaign       ${event_name}
    Select campaign type    ${child_campaign_name}
    # Compare [Candidate in drip campaign] and [Candidate in child drip campaign duplicate]
    ${candidate_name_in_child_campaign_duplicate}=      Get Text And Format Text    ${DRIP_CAMPAIGN_ADDED_CAMPAIGN_CANDIDATE_ROW_NAME}
    Should Contain      ${candidate_name_in_drip_campaign}      ${candidate_name_in_child_campaign_duplicate}
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    # Compare [Subject and Message Email] and [Subject and Message Email duplicate in child Template Campaign]
    Check data when duplicate campaign with email channel
    ${subject_in_template_campaign}=    Get Text And Format Text    ${DRIP_CAMPAIGN_ENTER_EMAIL_SUBJECT_TEXT}
    Should Be Equal     ${subject.name}     ${subject_in_template_campaign}
    ${title_in_template_campaign}=      Get Text And Format Text    ${DRIP_CAMPAIGN_ENTER_EMAIL_MESSAGE_TEXT}
    Should Be Equal     ${subject.message}      ${title_in_template_campaign}
    Capture Page Screenshot
    # Compare [Campaign type and event in new child drip campaign] and [Campaign type and event in duplicate new campaign]
    Campaign type and event when duplicate template child campaign
    ${subject_duplicate_drip_campaign}=     Select Channel in Drip campaign     is_existed=True
    Select Event in Drip campaign       ${event_name}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    # Schedule step of Drip Campaign
    Get future day for beginning drip campaign
    Get future day for ending drip campaign
    # Compare [Candidate in drip campaign] and [Candidate number in Campaign Confirmation]
    Check message when confirm schedule step
    ${candidate_number_conclusion}=     Get Text And Format Text    ${DRIP_CAMPAIGN_SCHEDULE_CONTAIN_AUDIENCES_MESSAGE}
    Should Contain      ${lower_candidate_number}       ${candidate_number_conclusion}
    Click at    ${NEW_CAMPAIGN_CONFIRM_POPUP_CONFIRM_BUTTON}
    Delete A Campaign       ${drip_campaign_name}       Scheduled


Verify create drip campaign with user audience is successfully (OL-T2381)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Create new Campaign / Set Audience      Users       All Users       role=Select all
    ${user_number}=     Get Text And Format Text    ${CAMPAIGN_CANDIDATES_NUMBER_TEXT}
    ${lower_user_number}=       Evaluate    "${user_number}".lower()
    Scroll To Element       ${CAMPAIGN_AUDIENCE_NAME_LAST_ROW}
    ${user_name_in_drip_campaign}=      Get Value List      ${CAMPAIGN_CANDIDATES_NAME_MATCHING_ROW_NAME}
    Campaign step in Drip campaign      One Campaign
    ${child_campaign_name}=     Input campaign name in drip campaign
    Select users in child campaign
    # Compare [User in drip campaign] and [User in child drip campaign]
    Check data is taken from drip campaign to child drip campaign or duplicate child drip campaign      ${user_name_in_drip_campaign}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    ${subject}=     Select Channel in Drip campaign
    Select campaign type    ${child_campaign_name}
    # Compare [User in drip campaign] and [User in child drip campaign duplicate]
    Check data is taken from drip campaign to child drip campaign or duplicate child drip campaign      ${user_name_in_drip_campaign}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    # Compare [Subject and Message Email] and [Subject and Message Email duplicate in child Template Campaign]
    Check data when duplicate campaign with email channel
    ${subject_in_template_campaign}=    Get Text And Format Text    ${DRIP_CAMPAIGN_ENTER_EMAIL_SUBJECT_TEXT}
    Should Be Equal     ${subject.name}     ${subject_in_template_campaign}
    ${title_in_template_campaign}=      Get Text And Format Text    ${DRIP_CAMPAIGN_ENTER_EMAIL_MESSAGE_TEXT}
    Should Be Equal     ${subject.message}      ${title_in_template_campaign}
    Capture Page Screenshot
    # Compare [Campaign type and event in new child drip campaign] and [Campaign type and event in duplicate new campaign]
    Campaign type and event when duplicate template child campaign      is_checked=False
    ${subject_duplicate_drip_campaign}=     Select Channel in Drip campaign     is_existed=True
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    # Schedule step of Drip Campaign
    Get future day for beginning drip campaign
    Get future day for ending drip campaign
    # Compare [User in drip campaign] and [User number in Campaign Confirmation]
    Check message when confirm schedule step
    ${user_number_conclusion}=      Get Text And Format Text    ${DRIP_CAMPAIGN_SCHEDULE_CONTAIN_AUDIENCES_MESSAGE}
    Should Contain      ${lower_user_number}    ${user_number_conclusion}
    Click at    ${NEW_CAMPAIGN_CONFIRM_POPUP_CONFIRM_BUTTON}
    Delete A Campaign       ${drip_campaign_name}       Scheduled


Verify Title & Audience tab of Drip Campaign Builder (OL-T2362, OL-T2373)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${drip_campaign_name}=      Create new Campaign / Set Title     campaign_type=Drip Campaign
    Check tabs in Drip Campaign
    Check data in Title and Audience tab
    Create new Campaign / Set Audience      Candidates
    Click At    ${NEW_CAMPAIGN_STEP_TEXT}       Campaigns
    # Verify Ui of Delivery Time selection (OL-T2373)
    @{campaign_list}=       Create List     ${campaign_active}      ${campaign_active_add_users}    ${campaign_active_add_candidates_part4}
    Campaign step in Drip campaign      ${campaign_list}
    Check delivery time selection
    Click At    ${DRIP_CAMPAIGN_DELIVERY_TIME_CANCEL_BUTTON}
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Delete A Campaign       ${drip_campaign_name}       Drafts

*** Keywords ***
Check delivery time selection
    Click At    ${DRIP_CAMPAIGN_SECOND_CHILD_CAMPAIGN_TWO_DAY_APART_TEXT}        ${campaign_active_add_users}
    ${active_campaign_days}=    Format string       ${DRIP_CAMPAIGN_DELIVERY_TIME_DROPDOWN_OPTION}       ${campaign_active_add_users}        Days
    ${active_campaign_weeks}=   Format string       ${DRIP_CAMPAIGN_DELIVERY_TIME_DROPDOWN_OPTION}       ${campaign_active_add_users}        Weeks
    ${active campaign_months}=      Format string   ${DRIP_CAMPAIGN_DELIVERY_TIME_DROPDOWN_OPTION}       ${campaign_active_add_users}        Months
    ${active_campaign_as_soons_as_matching}=    Format string       ${DRIP_CAMPAIGN_DELIVERY_TIME_DROPDOWN_OPTION}       ${campaign_active_add_users}        As soon as they match
    Check Element Display On Screen    ${active_campaign_days}
    Check Element Display On Screen     ${active_campaign_weeks}
    Check Element Display On Screen    ${active campaign_months}
    Check Element Display On Screen   ${active_campaign_as_soons_as_matching}
    Capture Page Screenshot
    ${days}=    Format string       ${DRIP_CAMPAIGN_DELIVERY_TIME_DEFAULT_TIME_INPUT}       Days
    ${default_days}=    Get Value And Format Text    ${days}
    Should Be Equal    ${default_days}      2
    Click at        ${active_campaign_weeks}
    ${weeks}=    Format string       ${DRIP_CAMPAIGN_DELIVERY_TIME_DEFAULT_TIME_INPUT}       Weeks
    ${default_weeks}=    Get Value And Format Text    ${weeks}
    Should Be Equal    ${default_weeks}      1
    Click at        ${active campaign_months}
    ${months}=    Format string       ${DRIP_CAMPAIGN_DELIVERY_TIME_DEFAULT_TIME_INPUT}       Months
    ${default_months}=    Get Value And Format Text    ${months}
    Should Be Equal    ${default_months}      1
    Capture Page Screenshot

Check data in Title and Audience tab
    Check Element Display On Screen    ${DRIP_CAMPAIGN_TITLE}
    Check Element Display On Screen    ${NEW_CAMPAIGN_AUDIENCE_UPLOAD_BUTTON}
    Capture Page Screenshot
    Click at  ${NEW_CAMPAIGN_SELECT_AUDIENCE_DROPDOWN}
    Check Element Display On Screen        ${NEW_CAMPAIGN_AUDIENCE_TYPE}  Candidates
    Check Element Display On Screen        ${NEW_CAMPAIGN_AUDIENCE_TYPE}  Users
    Capture Page Screenshot
    Click at  ${NEW_CAMPAIGN_SELECT_AUDIENCE_DROPDOWN}

Check tabs in Drip Campaign
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TEXT}    Title & Audience
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TEXT}        Campaigns
    Check Element Display On Screen    ${NEW_CAMPAIGN_STEP_TEXT}        Schedule
    Capture Page Screenshot

Check data is taken from drip campaign to child drip campaign or duplicate child drip campaign
    [Arguments]    ${user_name}
    ${user_name_in_child_campaign_duplicate}=    Get Value List    ${DRIP_CAMPAIGN_ADDED_CAMPAIGN_USER_ROW_NAME}
    FOR    ${item}  IN    @{user_name_in_child_campaign_duplicate}
        Should Contain         ${user_name}    ${item}
    END

Select users in child campaign
    Click At    ${DRIP_CAMPAIGN_ADD_FILTER_BUTTON}
    Input Into    ${DRIP_CAMPAIGN_SEARCH_FILTER_INPUT}      Campaign
    Click At    ${DRIP_CAMPAIGN_FILTER_OPTION}      Campaign
    Click At    ${DRIP_CAMPAIGN_ADD_FILTER_IS_CAMPAIGN_OPTION}
    Input Into    ${DRIP_CAMPAIGN_ADD_FILTER_IS_CAMPAIGN_SEARCH_BUTTON}     ${campaign_active_add_users}
    Click At    ${DRIP_CAMPAIGN_ADD_FILTER_IS_CAMPAIGN_SELECTED_OPTION}     ${campaign_active_add_users}
    Click At    ${DRIP_CAMPAIGN_ADD_FILTER_IS_CAMPAIGN_APPLY_BUTTON}

Select candidates in child campaign
    [Arguments]    ${audience}
    Click At    ${DRIP_CAMPAIGN_ADD_FILTER_BUTTON}
    Input Into    ${DRIP_CAMPAIGN_SEARCH_FILTER_INPUT}      Add Candidates
    Click At    ${DRIP_CAMPAIGN_FILTER_OPTION}      Add Candidates
    Input Into    ${DRIP_CAMPAIGN_AUDIENCE_SEARCH_INPUT}     ${audience}
    Click At    ${DRIP_CAMPAIGN_FIRST_CANDIDATE_OPTION}      ${audience}
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_APPLY_BUTTON}

Campaign type and event when duplicate template child campaign
    [Arguments]    ${is_checked}=True
    Check Element Display On Screen    ${DRIP_CAMPAIGN_CHANNEL_TEXT}
    IF  '${is_checked}' == 'True'
        ${event}=   Get Value And Format Text    ${DRIP_CAMPAIGN_SELECT_AN_EVENT_DROPDOWN}
        Should Be Equal    ${event}     ${event_name}
    END
    Capture Page Screenshot

Get future day for ending drip campaign
    Turn On    ${DRIP_CAMPAIGN_END_DRIP_CAMPAIGN_TOGGLE}
    Click At    ${DRIP_CAMPAIGN_SCHEDULE_DAY_SELECTOR}
    ${future_date_end_drip_campaign} =     get_future_date      plus_date=3
    Click at  ${DRIP_CAMPAIGN_SCHEDULE_DAY_SELECTOR_VALUE}  ${future_date_end_drip_campaign}
    Click at  ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}

Get future day for beginning drip campaign
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_NEXT_BUTTON}
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Schedule
    Click at  ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR}
    ${future_date} =    get_future_date
    Click at  ${NEW_CAMPAIGN_SCHEDULE_DATE_SELECTOR_VALUE}  ${future_date}

Check no filter in compose step when create campaign
    Check Element Not Display On Screen    ${DRIP_CAMPAIGN_ADD_FILTER_BUTTON}   wait-time=1s
    Capture Page Screenshot

Check message when confirm schedule step
    Check Element Display On Screen     ${DRIP_CAMPAIGN_SCHEDULE_CONFIRM_MESSAGE}    You are about to send this campaign to
    Capture Page Screenshot

Input campaign name in drip campaign
    ${campaign_name} =      Generate random name  auto_campaign
    Input Into    ${DRIP_CAMPAIGN_TITLE}    ${campaign_name}
    [Return]    ${campaign_name}

Check candidate name between in the added audience in drip campaign and duplicate candidate in campaign
    ${candidate_name_in_imported_file}=     Get Value List    ${CAMPAIGN_CANDIDATES_NAME_MATCHING_ROW_NAME}
    ${candidate_name_in_new_campaign}=      Check candidates is re-displayed and no filter appear
    Should Be Equal    ${candidate_name_in_imported_file}       ${candidate_name_in_new_campaign}
    Capture Page Screenshot
    [Return]     ${candidate_name_in_imported_file}

Check data when duplicate campaign with email channel
    ${email_is_chosen}=     Run Keyword And Return Status    Check The Checkbox    ${DRIP_CAMPAIGN_EMAIL_CHANNEL_ICON}
    ${email_string}=    Convert To String    ${email_is_chosen}
    Should Be Equal    ${email_string}   True
    Capture Page Screenshot

Select campaign type
    [Arguments]    ${campaign_name}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_MORE_CAMPAIGN_BUTTON}
    Click At    ${DRIP_CAMPAIGN_OPTION}     Use an existing campaign template
    Click At    ${DRIP_CAMPAIGN_TEMPLATE_DROPDOWN}
    ${is_existed}=      Run Keyword And Return Status    Check Element Not Display On Screen      ${DRIP_CAMPAIGN_VISIBLE_SEARCH_BUTTON}    wait_time=1s
    Capture Page Screenshot
    IF  '${is_existed}' == 'False'
        Input Into        ${DRIP_CAMPAIGN_VISIBLE_SEARCH_BUTTON}    ${campaign_name}
    ELSE
        Input Into    ${DRIP_CAMPAIGN_SEARCH_BUTTON}    ${campaign_name}
    END
    Click At    ${DRIP_CAMPAIGN_CHOSEN_OPTION}     ${campaign_name}
    Click At    ${CAMPAIGN_CONFIRM_BUTTON}

Check candidates is re-displayed and no filter appear
    Click At    ${NEW_CAMPAIGN_STEP_TEXT}  Campaigns
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}
    Click At    ${CAMPAIGN_CONFIRM_BUTTON}
    Wait With Short Time
    ${candidate_name_in_new_campaign}=   Get Value List    ${DRIP_CAMPAIGN_ADDED_CAMPAIGN_CANDIDATE_ROW_NAME}
    Check Element Not Display On Screen    ${DRIP_CAMPAIGN_ADD_FILTER_BUTTON}   wait-time=1s
    Capture Page Screenshot
    [Return]    ${candidate_name_in_new_campaign}

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

Check campaign type option when add new campaign
    Check Element Display On Screen     ${DRIP_CAMPAIGN_SELECT_AN_OPTION_POPUP}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_OPTION}     Create a new campaign
    Check Element Display On Screen    ${DRIP_CAMPAIGN_OPTION}     Use an existing campaign template
    Capture Page Screenshot

Check message when campaign tab has new status
    Check Element Display On Screen    ${DRIP_CAMPAIGN_MESSAGE_HAVE_NOT_CAMPAIGN_TEXT}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_BUTTON}
    Capture Page Screenshot

Check modal to select the campaign type
    Check Element Display On Screen    ${CAMPAIGN_TYPE_POPUP}
    Check Element Display On Screen      ${CHOOSE_CAMPAIGN_TYPE_POPUP_TYPE_TEXT}    Single Campaign
    Check Element Display On Screen    ${CHOOSE_CAMPAIGN_TYPE_POPUP_TYPE_TEXT}      Drip Campaign
    Capture Page Screenshot

Check candidate is sent being cloned
    Click At    ${DRIP_CAMPAIGN_TEMPLATE_DROPDOWN}
    ${is_existed}=      Run Keyword And Return Status    Check Element Not Display On Screen      ${DRIP_CAMPAIGN_VISIBLE_SEARCH_BUTTON}    wait_time=1s
    Capture Page Screenshot
    IF  '${is_existed}' == 'False'
        Input Into        ${DRIP_CAMPAIGN_VISIBLE_SEARCH_BUTTON}    ${campaign_active}
    ELSE
        Input Into    ${DRIP_CAMPAIGN_SEARCH_BUTTON}    ${campaign_active}
    END
    Click At    ${DRIP_CAMPAIGN_CHOSEN_OPTION}     ${campaign_active}
    Click At    ${CAMPAIGN_CONFIRM_BUTTON}
    ${audience_name_match_in_campaign_step}=    Get Text And Format Text    ${DRIP_CAMPAIGN_CANDIDATE_NAME_MATCHING_ROW}
    [Return]    ${audience_name_match_in_campaign_step}

Check audience match name will be listed
    ${audience_name}=      Get Text And Format Text    ${NEW_CAMPAIGN_AUDIENCE_CANDIDATE_NAME}
    Click At  ${NEW_CAMPAIGN_AUDIENCE_FILTER_CHECKBOX}
    Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_APPLY_BUTTON}
    ${audience_name_match}=      Get Text And Format Text    ${CAMPAIGN_CANDIDATES_NAME_MATCHING_ROW_NAME}
    Should Be Equal    ${audience_name}    ${audience_name_match}
    Capture Page Screenshot

Check UI in Title and Audience step
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_ADD_FILTER_BUTTON}     Add Filter
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_ADD_FILTER_BUTTON}      Add Candidates
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_CANDIDATE_OPTION}
    Click At    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_APPLY_BUTTON}
    Check Element Display On Screen     ${DRIP_CAMPAIGN_ADD_CAMPAIGN_NEXT_BUTTON}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_CANCEL_BUTTON}
    Capture Page Screenshot

Check UI in Compose step
    Check Element Display On Screen    ${DRIP_CAMPAIGN_AVATAR_DEFAULT_ICON}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_SMS_CHANNEL_ICON}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_EMAIL_CHANNEL_ICON}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_EVENT_TOGGLE_CHECKBOX}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_CANCEL_BUTTON}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ADD_CAMPAIGN_COMPOSE_BUTTON}
    Capture Page Screenshot

Check all campaigns of drip campaign in dropdownlist
    Click At    ${DRIP_CAMPAIGN_VALUE_CAMPAIGN_TEXT}
    ${value_campaigns}=     Get List Value    ${DRIP_CAMPAIGN_VALUE_CAMPAIGN_LIST}
    @{campaign_list}=       Create List    ${campaign_active}       ${campaign_active_add_candidates_part4}
    Lists Should Be Equal    ${value_campaigns}     ${campaign_list}
    Capture Page Screenshot

Check data candidate when creating a drip campaign
    [Arguments]    ${campaign_name}
    Click At        ${DRIP_CAMPAIGN_NAME_ROW}   ${campaign_name}
    ${candidate_number}=    Get Text And Format Text    ${DRIP_CAMPAIGN_CANDIDATE_NUMBER_TEXT}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Save Campaign
    [Return]    ${candidate_number}

Check metrics from the campaign selected and empty state in the Drip Campaign
    Click At    ${CAMPAIGN_ACTIVE_SETTING_ICON}
    Click At    ${DRIP_CAMPAIGN_SETTING_ICON}
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Campaigns
    ${candidate_number_in_first_campaign}=      Check data candidate when creating a drip campaign       ${campaign_active}
    ${candidate_number_in_second_campaign}=     Check data candidate when creating a drip campaign    ${campaign_active_add_candidates_part4}
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}
    Search A Campaign    ${drip_campaign_active_add_candidates}     Active
    Click At    ${drip_campaign_active_add_candidates}
    ${candidate_name_in_first_campaign}=    Get List Value    ${DRIP_CAMPAIGN_CANDIDATE_NAME_ROW}
    ${candidate_length_in_first_campaign_metrics}=      Get Length    ${candidate_name_in_first_campaign}
    ${candidate_number_in_first_campaign_metrics}=      Convert To String        ${candidate_length_in_first_campaign_metrics}
    Should Contain    ${candidate_number_in_first_campaign}        ${candidate_number_in_first_campaign_metrics}
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_VALUE_CAMPAIGN_TEXT}
    Click At    ${DRIP_CAMPAIGN_VALUE_CAMPAIGN_ROW}        ${campaign_active_add_candidates_part4}
    ${is_existed}=      Run Keyword And Return Status    Check Text Display    This campaign hasn't been sent yet.
    IF  '${is_existed}' == 'True'
        ${candidate_name_in_second_campaign}=    Get List Value    ${DRIP_CAMPAIGN_CANDIDATE_NAME_ROW}
        ${candidate_length_in_second_campaign_metrics}=     Get Length      ${candidate_name_in_second_campaign}
        ${candidate_number_in_second_campaign_metrics}=     Convert To String         ${candidate_number_in_second_campaign_metrics}
        Should Contain     ${candidate_number_in_second_campaign}       ${candidate_number_in_second_campaign_metrics}
    END
    Capture Page Screenshot

Check data in compose tab is cloned the same with previous campaign
    ${audience_in_type_campaign_after}=    Get Text And Format Text    ${DRIP_CAMPAIGN_AUDIENCE_IN_DUPLICATE_CAMPAIGN_TEXT}
    ${candidate_number_after}=    Get Text And Format Text    ${DRIP_CAMPAIGN_CANDIDATE_NUMBER_TEXT}
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Add Campaign
    Click At    ${DRIP_CAMPAIGN_NAME_ROW}      ${campaign_active}
    ${audience_in_type_campaign_previous}=    Get Text And Format Text    ${DRIP_CAMPAIGN_AUDIENCE_IN_DUPLICATE_CAMPAIGN_TEXT}
    ${candidate_number_previous}=    Get Text And Format Text    ${DRIP_CAMPAIGN_CANDIDATE_NUMBER_TEXT}
    Should Be Equal    ${audience_in_type_campaign_after}   ${audience_in_type_campaign_previous}
    Should Be Equal    ${candidate_number_after}    ${candidate_number_previous}
    Capture Page Screenshot
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Next
    Click At    ${DRIP_CAMPAIGN_NEW_BUTTON}     Save Campaign

Check confirm popup when delete a campaign
    Check Element Display On Screen    ${DRIP_CAMPAIGN_DELETE_CAMPAIGN_POPUP}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_DELETE_CAMPAIGN_CANCEL_BUTTON}
    Check Element Display On Screen    ${DRIP_CAMPAIGN_DELETE_CAMPAIGN_DELETE_BUTTON}
    Capture Page Screenshot

Check option in eclipse is shown
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ECLIPSE_OPTION}      Edit
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ECLIPSE_OPTION}      Duplicate Campaign
    Check Element Display On Screen    ${DRIP_CAMPAIGN_ECLIPSE_OPTION}      Delete
    Capture Page Screenshot

Check default is the first campaign
    Check Element Display On Screen    ${CAMPAIGN_DEFAULT_STATUS_BUTTON}    Message
    Check Element Display On Screen    ${CAMPAIGN_DEFAULT_STATUS_BUTTON}    Sent
    Check Element Display On Screen    ${CAMPAIGN_DEFAULT_STATUS_BUTTON}    Engaged
    Check Element Display On Screen    ${CAMPAIGN_DEFAULT_STATUS_BUTTON}    Opened
    Check Element Display On Screen    ${CAMPAIGN_DEFAULT_STATUS_BUTTON}    Unsubscribed
    Check Element Display On Screen    ${CAMPAIGN_DEFAULT_STATUS_BUTTON}    Undelivered
    ${is_existed}=      Run Keyword And Return Status    Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     Name
    IF  '${is_existed}' == 'True'
        Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     Type
        Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     First Contact
        Check Element Display On Screen    ${NEW_CAMPAIGN_LIST_USERS_MATCH_FIELDS_TEXT}     Last Contact
    END
    Capture Page Screenshot
