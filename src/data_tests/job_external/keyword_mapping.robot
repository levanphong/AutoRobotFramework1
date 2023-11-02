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
${landing_site_name}    KeywordMappingLandingSite
${widget_name}          KeywordMappingWidget
${convo_name}           Keyword Mapping Single Path

# === SECTION: COMPANY_APPLICANT_FLOW ===
# 1a. Turn on Job Search
# 1b. Enviroment field: select Production
# 1c. Select Company field: select a feed
# 2. Turn on Job Search > Geographic Targeting OFF
# 3a. Create new landing site

# === SECTION: COMPANY_GEOGRAPHIC_TARGETING ===
# 1a. Turn on Job Search
# 1b. Enviroment field: select Production
# 1c. Select Company field: select a feed
# 2. Turn on Job Search > Geographic Targeting ON, then enter United States
# 3a. Create new widget start interaction by Job search (job external)(name: KeywordMappingWidget)domain: prd-automation-team.github.io
# 3b. Create new landing site

# === SECTION: COMPANY_LOCATION_MAPPING_OFF ===
# 1a. Turn on Job Search
# 1b. Enviroment field: select Production
# 1c. Select Company field: select a feed
# 2. Turn on Job Search > Geographic Targeting ON, then enter Viet Nam
# 3a. Create new landing site

*** Test Cases ***
Create data test for Keyword Mapping
    [Tags]   lts_stg
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    #   Set up to 'COMPANY_LOCATION_MAPPING_OFF'
    Add company for testing     ${COMPANY_LOCATION_MAPPING_OFF}
    Turn on Geographic Targeting and select Country   ${VIET_NAM}
    Turn on ATS and select feed
    Turn on Candidate Care
    Add Single conversation with email only   ${convo_name}
    Create job posting page
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    #  Set up COMPANY_GEOGRAPHIC_TARGETING
    Add company for testing     ${COMPANY_GEOGRAPHIC_TARGETING}
    Turn on Job Search toggle   Production  ${AUTOMATION_FEED_PROD}
    Turn on Geographic Targeting and select Country   ${UNITED_STATES}
    Turn on ATS and select feed
    Turn on Candidate Care
    Add Single conversation with email only   ${convo_name}
    Create job posting page
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    Create Geographic Targeting widget   ${widget_name}

*** Keywords ***
Create Geographic Targeting widget
    [Arguments]    ${site_name}
    Go to Web Management
    Click at    ${ADD_NEW_WEB_BUTTON}
    Click at    ${WEB_SITE_TYPE}    Widget Conversation    1s
    Click at    ${NEXT_BUTTON_SELECT_SITE}
    Check element display on screen  ${WEB_MANAGEMENT_WIDGET}
    Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
    Input into    ${DOMAIN_SECURITY_WIDGET}    ${DOMAIN_SECURITY}
    Click on toggle Job search    Widget Conversation
    Turn on Geographic Targeting and select Country on widget   ${UNITED_STATES}
    Select dropdown item  ${CAPTURE_CONVERSATION}  ${WIDGET_JOB_SEARCH_ITEM}  dynamic_locator_item=Job Search
    Press keys  None  ESC
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Run keyword and ignore error    Check element display on screen  ${WEB_MANAGEMENT_PAGE_CENTER_MESSAGE}  wait_time=5s
    Capture page screenshot
    ${is_closed_widget} =    Run keyword and return Status    Check element not display on screen
    ...    ${WEB_MANAGEMENT_WIDGET}
    IF    '${is_closed_widget}' == 'False'
        Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
        Input into    ${DOMAIN_SECURITY_WIDGET}    ${DOMAIN_SECURITY}
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Capture page screenshot
    END

Turn on Geographic Targeting and select Country on widget
    [Arguments]   ${country_name}
    Turn on    ${WIDGET_GEOGRAPHIC_TARGETING_TOGGLE}
    Input into  ${WIDGET_GEOGRAPHIC_TARGETING_SEARCH_TEXTBOX}   ${country_name}
    Click at   ${WIDGET_GEOGRAPHIC_TARGETING_COUNTRY_ITEM}   ${country_name}
