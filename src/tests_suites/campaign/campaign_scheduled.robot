*** Settings ***
Resource            ../../pages/campaigns_page.robot
Resource            ../../drivers/driver_chrome.robot

Library             DateTime

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

Documentation       Company Next Step: Keep no campaign in this company

*** Variables ***
${campaign_active_candidate}            Campaign in Active Status
${campaign_active_user}                 Campaign active status add audience is users
${campaign_rating_active_candidate}     Campaign Rating Active Status
${compose_rating_candidate}             Rating for campaign with candidates

*** Test Cases ***
Audience is Users - Verify Campaign view of Message Campaign (OL-T1618)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaign Detail Page      ${campaign_active_user}     Active
    Click At    ${CAMPAIGN_ACTIVE_SELECT_ALL_CHECKBOX}
    Click At    ${CAMPAIGN_ACTIVE_SEND_MESSAGE_BUTTON}
    Check Element Display On Screen     ${CAMPAIGN_ACTIVE_SEND_MESSAGE_MODAL}
    Check Text Display      3 more
    Capture Page Screenshot
    Click At    ${CAMPAIGN_ACTIVE_SEND_MESSAGE_MODAL_CLOSE_BUTTON}
    Verify view of active campaign      Engaged     Opened      Unsubscribed    Undelivered


Delete Campaign is successfully in case there is more 15 minutes of the scheduled time (OL-T1602)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     SMS     Candidates
    Search a Campaign       ${campaign_name}    Scheduled
    Click at    ${CAMPAIGN_PAGE_ITEM_ECLIPSE_MENU_BUTTON}
    Click at    ${CAMPAIGN_ITEM_ECLIPSE_MENU_DELETE_BUTTON}
    Click At    ${CAMPAIGN_ITEM_DELETE_POPUP_CANCEL_BUTTON}
    Check element display on screen     ${campaign_name}
    Capture Page Screenshot
    Click at    ${CAMPAIGN_PAGE_ITEM_ECLIPSE_MENU_BUTTON}
    Click at    ${CAMPAIGN_ITEM_ECLIPSE_MENU_DELETE_BUTTON}
    Click at    ${CAMPAIGN_ITEM_DELETE_POPUP_DELETE_BUTTON}


Verify Schedule Campaign tab (OL-T1584)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create new Campaign / Set Title
    Create new Campaign / Set Audience      Candidates
    Create new Campaign / Set Compose step      SMS
    Verify campaign schedule tab
    Verify schedule tab after campaign composing when select time has elapsed
    Click At    ${NEW_CAMPAIGN_BACK_TO_CAMPAIGN_BUTTON}     alert_action=ACCEPT
    Delete A Campaign       ${campaign_name}    Draft


Audience is Users - Verify Campaign view of Rating Campaign (OL-T1619)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaign Detail Page      ${campaign_rating_active_candidate}     Active
    Verify view of active campaign      Engaged     Completed       Unsubscribed    Undelivered


Edit Campaign is successfully in case there is more 15 minutes of the scheduled time (OL-T1600)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Campaigns Page
    ${campaign_name}=       Create New Campaign     SMS     Candidates
    Go To Campaign Detail Page      ${campaign_name}    Scheduled
    Verify Edit Scheduled Campaign - Tiltle and Audience    ${campaign_name}_new
    Verify Edit Scheduled Campaign - Compose
    Create new Campaign / Set Schedule step
    Capture Page Screenshot
    Delete A Campaign       ${campaign_name}_new

*** Keywords ***
Verify campaign schedule tab
    Check Element Display On Screen    ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Capture Page Screenshot
    ${date_selected}=  Get Element Attribute    ${NEW_CAMPAIGN_SCHEDULE_TIME_SELECTOR_INPUT}    value
    ${current_date}=    DateTime.Get Current Date  result_format=%Y-%m-%d
    Should Be Equal    ${date_selected}     ${current_date}
    Capture Page Screenshot

Verify view of active campaign
    [Arguments]    @{list_statistics}
    ${sent_messages_number}=   Get Text And Format Text    ${CAMPAIGN_ACTIVE_STATISTICS_SENT_NUMBER}
    Should Be Equal As Integers    ${sent_messages_number}  7
    FOR  ${statistics}  IN  @{list_statistics}
        Check Element Display On Screen    ${CAMPAIGN_ACTIVE_STATISTICS_NUMBER}     ${statistics}
    END
    Capture Page Screenshot

Verify Edit Scheduled Campaign - Tiltle and Audience
    [Arguments]    ${campaign_name}
    Input into  ${NEW_CAMPAIGN_TITLE}   ${campaign_name}
    Check Element Not Display On Screen    ${NEW_CAMPAIGN_AUDIENCE_REMOVE_ICON}     wait_time=1s
    Click At    ${NEW_CAMPAIGN_AUDIENCE_FILTER_REMOVE_ICON}
    Click at  ${NEW_CAMPAIGN_AUDIENCE_TYPE}  Add Filter
    Input into  ${NEW_CAMPAIGN_AUDIENCE_FILTER_SEARCH_TEXT_BOX}  All Candidates
    Click at  ${NEW_CAMPAIGN_AUDIENCE_FILTER_VALUE_OPTION}   All Candidates
    Capture Page Screenshot

Verify Edit Scheduled Campaign - Compose
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Compose
    ${email_checkbox}=     Format String    ${NEW_CAMPAIGN_COMPOSE_SELECT_CHANNEL_INPUT}    Email
    Element Should Be Disabled    ${email_checkbox}
    Check Element Display On Screen        ${NEW_CAMPAIGN_CAMPAIGN_TYPE_DROPDOWN_DISABLED}
    Clear Element Text With Keys    ${NEW_CAMPAIGN_MOBILE_CHANNEL_MESSAGE_BOX}
    Simulate Input  None  xin chao
    Check Text Display    xin chao
    Capture Page Screenshot
