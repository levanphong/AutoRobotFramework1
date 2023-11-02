*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lowes    lowes_stg    lts_stg    olivia    stg   test
Documentation       Create 2 landing site name: "InferLocationIP", turn on Job Search toggle, How would you like to start the interaction?: select Job Search(COMPANY_APPLICANT_FLOW,COMPANY_EXTERNAL_JOB)

*** Variables ***
${landing_site_name}    InferLocationIP
@{address_list}         ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}    ${LOCATION_ADDRESS_LOCATION_MAPPING}    ${LOCATION_ADDRESS_MP020}

*** Test Cases ***
Search result when turning ON "Job Location " at Search Parameter and OFF "Infer location with IP Address" and giving the location (OL-T28285)
    Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_name}
    Go to conversation and show jobs    ${site_url}    ${ANY_JOB} in ${LOCATION_NAME_US}
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element display on screen      ${CONVERSATION_LOCATION_TITLE_TWENTY_JOB}
    Check location(s) display correctly in selected job    ${address_list}


Search result when turning ON "Job Location " at Search Parameter and OFF "Infer location with IP Address" and don't give the location (OL-T28284)
    Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_name}
    Go to conversation and show jobs    ${site_url}    ${ANY_JOB}
    Verify AI message when asking about location in    Landing Site


Search result when turning OFF "Job Location " at Search Parameter and OFF "Infer location with IP Address" and give the location (OL-T28287)
    Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_EXTERNAL_JOB   ${landing_site_name}
    Go to conversation and show jobs    ${site_url}    ${ANY_JOB} in US    ${WELCOME_CANDIDATE_MESSAGE}
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element display on screen      ${CONVERSATION_LOCATION_TITLE_TWENTY_JOB}
    ${address_list} =    Create List    ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}    ${LOCATION_ADDRESS_LOCATION_MAPPING}    ${LOCATION_ADDRESS_MP020}
    Check location(s) display correctly in selected job    ${address_list}


Search result when turning OFF "Job Location " at Search Parameter and OFF "Infer location with IP Address" and don't give the location (OL-T28286)
    Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_EXTERNAL_JOB   ${landing_site_name}
    Go to conversation and show jobs    ${site_url}    ${ANY_JOB}    ${WELCOME_CANDIDATE_MESSAGE}
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element display on screen      ${CONVERSATION_LOCATION_TITLE_TWENTY_JOB}
    Check location(s) display correctly in selected job    ${address_list}

*** Keywords ***
