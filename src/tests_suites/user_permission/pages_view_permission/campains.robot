*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/analytics_and_reporting_page.robot
Resource            ../../../pages/campaigns_page.robot
Library             ../../../utils/StringHandler.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check the Campaigns page is displayed for user has full access in case user is Full User - Edit Everything (OL-17065)
    Given Setup test
    ${is_redirected} =      Go to Campaigns with different role    Full User - Edit Everything
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Campaigns page is displayed under Menu in case user is Company Admin (OL-17064)
    Given Setup test
    ${is_redirected} =      Go to Campaigns with different role    Company Admin
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Campaigns page is displayed under Menu in case user is Paradox Admin (OL-17063)
    Given Setup test
    ${is_redirected} =      Go to Campaigns with different role    ${PARADOX_ADMIN}
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Campaigns page is not displayed for user has no access in case user is Hiring Manager (OL-17068)
    Given Setup test
    ${is_redirected} =      Go to Campaigns with different role    Hiring Manager
    Run keyword unless      '${is_redirected}' == 'False'   Fail


Check the Campaigns page is not displayed for user has no access in case user is Recruiter (OL-17067)
    Given Setup test
    ${is_redirected} =      Go to Campaigns with different role    Recruiter
    Run keyword unless      '${is_redirected}' == 'False'   Fail


Check the Campaigns page is not displayed for user has view access in case user is Full User - Edit Nothing (OL-17066)
    Given Setup test
    ${is_redirected} =      Go to Campaigns with different role    Full User - Edit Nothing
    Run keyword unless      '${is_redirected}' == 'False'   Fail


Verify Full User - Edit Everything has full access to create a campaign (OL-17073)
    Given Setup test
    Login into system with company    Full User - Edit Everything    ${COMPANY_FRANCHISE_ON}
    ${campaign_name} =   Create a default Campaign
    Delete a Campaign   ${campaign_name}


Verify Full User - Edit Everything has full access to edit campaigns which is created by himself (OL-17075, OL-17070)
    Given Setup test
    Login into system with company    Full User - Edit Everything    ${COMPANY_FRANCHISE_ON}
    ${campaign_name} =   Create a default Campaign
    Edit Campaign name  ${campaign_name}


Verify Paradox Admin User can edit any campaigns which is created by others (OL-17074, OL-17071, OL-17069)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check edit Campaign with Paradox admin
    ${campaign_name} =   Create a default Campaign
    Edit Campaign name  ${campaign_name}
    # Check edit Campaign of other users
    Go to CEM page
    Switch to user  EE Team
    ${campaign_name} =   Create a default Campaign
    Go to CEM page
    Switch to user  ${TEAM_USER}
    Go to Campaigns page
    Edit Campaign name  ${campaign_name}

*** Keywords ***
Go to Campaigns with different role
    [Arguments]    ${role}
    when Login into system with company    ${role}    ${COMPANY_FRANCHISE_ON}
    ${is_redirected} =      Go to Campaigns page
    Capture page screenshot
    [Return]    ${is_redirected}

Create a default Campaign
    Go to Campaigns page
    ${campaign_name} =   Create new Campaign / Set Title
    Create new Campaign / Set Audience  Candidates
    Create new Campaign / Set Compose step  SMS
    Create new Campaign / Set Schedule step
    Click at  ${CAMPAIGN_PAGE_TAB_ITEM}  Scheduled
    Input into  ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}  ${campaign_name}
    Check element display on screen  ${campaign_name}
    Capture page screenshot
    [Return]    ${campaign_name}

Edit Campaign name
    [Arguments]    ${campaign_name}
    # Edit Campaign name
    Click at  ${CAMPAIGN_PAGE_TAB_ITEM}  Scheduled
    Input into  ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}  ${campaign_name}
    Click at  ${campaign_name}
    ${campaign_name} =      Generate random name  auto_campaign
    Input into  ${NEW_CAMPAIGN_TITLE}  ${campaign_name}
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Compose
    Click at  ${NEW_CAMPAIGN_STEP_TEXT}  Schedule
    Click at  ${NEW_CAMPAIGN_NEXT_STEP_BUTTON}
    Click at  ${NEW_CAMPAIGN_CONFIRM_POPUP_CONFIRM_BUTTON}
    # Search with new Campaign name
    Click at  ${CAMPAIGN_PAGE_TAB_ITEM}  Scheduled
    Input into  ${CAMPAIGN_PAGE_SEARCH_CAMPAIGN_TEXT_BOX}  ${campaign_name}
    Check element display on screen  ${campaign_name}
    Capture page screenshot
    Delete a Campaign   ${campaign_name}
