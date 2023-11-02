*** Settings ***
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
&{widget_dic}               job_search=UploadResumeWidget    hire_on=UploadResumeHireON    capture_convo=UploadResumeCaptureConvo
${convo_builder_name}       Ai Resume Matching convo

*** Test Cases ***
# Company: COMPANY_APPLICANT_FLOW
# More > Turn on AI Resume Matching
# Create a widget name:UploadResumeWidget, turn on job search > turn on AI Resume Matching
# Create a widget name:UploadResumeCaptureConvo, turn on job search, select convo:Multi Applicant Convo(name,email,phone,address) > turn on AI Resume Matching
# Go to WF: select PAT040 MP010 PAT071 and add condition for job req id PAT071
# Company: Hire ON
# More > Turn on AI Resume Matching
# Security and compliance > Turn GDPR: global
# Create a widget name:UploadResumeHireON, turn on job search > turn on AI Resume Matching
Create data test for AI Resume Matching 1
    #   Set up to 'COMPANY_APPLICANT_FLOW'
    Setup test
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Turn on AI Resume Matching
    Add a Location    ${COMPANY_APPLICANT_FLOW}    ${LOCATION_CITY_SAN_JOSE}    15417    ${LOCATION_CITY_SAN_JOSE}    ${LOCATION_STATE_CALIFORNIA}    15417
    Turn on a Job    ${AUTOMATION_TESTER_TITLE_071}    ${LOCATION_CITY_SAN_JOSE}
    Create job search and ai resume matching widget   ${widget_dic.job_search}
    Add Single conversation with email,phone and address    ${convo_builder_name}
    Create job search and ai resume matching widget   ${widget_dic.capture_convo}    ${convo_builder_name}

Create data test for Job Search Parameters 2
    #   Set up to 'COMPANY_HIRE_ON'
    Setup test
    Login into system with company    Paradox admin role    ${COMPANY_HIRE_ON}
    Turn on AI Resume Matching
    Turn on Job Search toggle
    Create job search and ai resume matching widget   ${widget_dic.hire_on}


*** Keywords ***
Create job search and ai resume matching widget
    [Arguments]    ${site_name}    ${convo_builder_name}=None
    Go to Web Management
    Click at    ${ADD_NEW_WEB_BUTTON}
    Click at    ${WEB_SITE_TYPE}    Widget Conversation    1s
    Click at    ${NEXT_BUTTON_SELECT_SITE}
    Check element display on screen  ${WEB_MANAGEMENT_WIDGET}
    Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
    Input into    ${DOMAIN_SECURITY_WIDGET}    ${DOMAIN_SECURITY}
    Click on toggle Job search    Widget Conversation
    Click by JS    ${WIDGET_AI_RESUME_MATCHING_TOGGLE}
    Select dropdown item  ${CAPTURE_CONVERSATION}  ${WIDGET_JOB_SEARCH_ITEM}  dynamic_locator_item=Job Search
    Press keys  None  ESC
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Run keyword and ignore error    Check element display on screen  ${WEB_MANAGEMENT_PAGE_CENTER_MESSAGE}  wait_time=5s
    Capture page screenshot
    ${is_closed_widget} =    Run keyword and return Status    Check element not display on screen
    ...    ${WEB_MANAGEMENT_WIDGET}
    IF    not ${is_closed_widget}
        Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
        Input into    ${DOMAIN_SECURITY_WIDGET}    ${DOMAIN_SECURITY}
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Capture page screenshot
    END
    IF    '${convo_builder_name}' != 'None'
        Assign the conversation to the landing site/widget site     ${convo_builder_name}    ${site_name}
    END
