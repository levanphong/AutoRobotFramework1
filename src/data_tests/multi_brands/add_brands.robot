*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/company_information_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/company_information_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{permision_locations_user_test}    Test_Location_1    Test_Location_2
${brand_name}    Brand OL-R1154
${site_name}    Site OL-R1154
*** Test Cases ***
Prepare datatest for company information page (OL-R1154)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to brand management page
    Add a brand    ${brand_name}
    Create new job, publish and turn on my job      ${JF_COFFEE_FAMILY_JOB}     ${AUTOMATION_TESTER_TITLE_021}      ${permision_locations_user_test}    ${CP_ADMIN}      attendee=${CP_ADMIN}    brand_name=${brand_name}
    Create landing site/widget site     site_type=Landing Site    site_name=${site_name}    conversation_name=WIDGET_CONV        brand_name=${brand_name}
