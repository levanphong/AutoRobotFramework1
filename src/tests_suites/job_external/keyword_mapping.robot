*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/my_jobs_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    fedex    lowes   fedexstg    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    unilever

*** Variables ***
${landing_site_name}    KeywordMappingLandingSite
${widget_name}          KeywordMappingWidget

*** Test Cases ***
Verify opening any site when Geographic Targeting is OFF (OL-T28276)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    ${company_site_url} =  get_company_site_link  COMPANY_APPLICANT_FLOW
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_name}
    #   Verify candidate can open these site
    Go to  ${company_site_url}
    Check element display on screen  ${CONVERSATION_INPUT_TEXTBOX}
    Go to  ${landing_site_url}
    Check element display on screen  ${CONVERSATION_INPUT_TEXTBOX}


Verify when opening Posting job page /widget page in locations that selected in Geographic Targeting (OL-T28273, OL-T28272)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    ${job_posting_url} =   Search job and get internal job link  ${AUTOMATION_TESTER_TITLE_053}
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_name}
    #   Verify candidate can open these site
    Go to   ${job_posting_url}
    Check element display on screen  ${CONVERSATION_JOB_POSTING_APPLY_NOW_BUTTON}
    Go to   ${landing_site_url}
    Check element display on screen  ${CONVERSATION_INPUT_TEXTBOX}


Verify when opening Posting job page, widget page in locations that aren't selected in Geographic Targeting (OL-T28274)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_GEOGRAPHIC_TARGETING}
    ${job_posting_url} =   Search job and get internal job link  ${AUTOMATION_TESTER_TITLE_053}
    ${widget_url} =  get widget conversation link   ${widget_name}
    #   Verify candidate can open these site
    Go to   ${job_posting_url}
    Check element not display on screen  ${CONVERSATION_JOB_POSTING_APPLY_NOW_BUTTON}
    Go to   ${widget_url}
    Wait with large time
    Check element not display on screen  ${INPUT_WIDGET}


Verify when opening other site in locations that aren't selected in Geographic Targeting (OL-T28275)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_GEOGRAPHIC_TARGETING}
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_GEOGRAPHIC_TARGETING   ${landing_site_name}
    Go to   ${landing_site_url}
    Check element display on screen  ${CONVERSATION_INPUT_TEXTBOX}

