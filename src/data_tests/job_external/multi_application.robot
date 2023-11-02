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
${landing_site_name}                MultiApplicationLandingSite
${widget_site_name}                 MultiApplicationWidget
${candidate_joruney_name}           Multi Application Journey
${convo_title}                      Multi Application Convo
${af_title1}                        MP010 PAT040 AF
${af_title2}                        MP010 PAT010 AF
${af_convo_tile}                    Af_custome_builder_default

#   ===SECTION: COMPANY_LOCATION_MAPPING_OFF ===
# 1. Client setup - Job search is turn ON, and at least 1 feed is selected in "Search company"
# 1a. Client setup - Job search > Job Requisition ID search ON > Custom:\bREF+\d{5}[A-Z]+ and add field alpha
# 1b. Client setup - Job search > Chat-to-apply ON
# 2. Knowledge base > Candidate Care: input link: "https://docs.google.com/spreadsheets/d/1qgcA0mDo1emq26YJ0fso_XP469GjATBK4TeVANv9pN0/edit#gid=0"
# 3. Landing site (widget, company site...) start interaction by Job search (job external)(name: MultiApplicationLandingSite)
# 4. Go to Client setup - Capture, At "After how many days can the candidate reapply to the same job?" dropdown, select 30 days
# 4a. At "How would you like to send the verification code to the candidate?", select No Required
# 5. Turn on ATS and configure job
# 6a. Create a Candidate Journey, name: Multi Application Journey, with default journey
# 6b. Create a custom convo, name: Multi Application Convo, with Open-ended, fullname, email, phone and address, assign Multi Application Journey
# 6c. Turn on Applicant Flow, go to Applicant Flow, create a new Applicant Flow, select "Multi Application Convo", condition should contain job req id: PAT010 or MP010
# 6c1. Scheduling set manually

#   ===SECTION: COMPANY_APPLICANT_FLOW ===
# 1. Client setup - Job search is turn ON, and at least 1 feed is selected in "Search company"
# 1a. Client setup - Job search > Job Requisition ID search ON > Custom:\bREF+\d{5}[A-Z]+ and add field alpha
# 1b. Client setup - Job search > Chat-to-apply ON
# 2. Knowledge base > Candidate Care: input link: "https://docs.google.com/spreadsheets/d/1qgcA0mDo1emq26YJ0fso_XP469GjATBK4TeVANv9pN0/edit#gid=0"
# 3. Landing site start interaction by Job search (name: MultiApplicationLandingSite)
# 3a. Widget start interaction by Job search (name: MultiApplicationWidget) (domain:prd-automation-team.github.io)
# 4. Go to Client setup - Capture, At "After how many days can the candidate reapply to the same job?" dropdown, ==> SELECT 0 DAY <==
# 4a. At "How would you like to send the verification code to the candidate?", select No Required
# 5. Turn on ATS and configure job
# 6a. Create a Candidate Journey, name: Multi Application Journey, with default journey
# 6b. Create a custom convo, name: Multi Application Convo, with fullname, email, phone and address, assign Multi Application Journey
# 6c. Turn on Applicant Flow, go to Applicant Flow, create a new Applicant Flow name:Multi Application AF, select "Multi Application Convo", condition should contain job req id: PAT040 or MP010
# 6c1. Scheduling set manually

*** Test Cases ***
#   This scripts only handle step 1,3,4 and 6
Create data test for Multi Application
    [Tags]    birddoghr    lowes    lowes_stg    lts_stg    olivia    stg   pepsi   unilever    dev
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    # Step 1
    Turn on ATS and select feed
    Turn on Job Search toggle   Production  ${MASTER_FEED_APPLICANT_FLOW}
    Turn on Job Requisition ID Search
    Turn on Candidate Type(internal/external)
    # Step 3
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    Create job search landing site/widget    Widget Conversation   ${widget_site_name}   ${DOMAIN_SECURITY}
    # Step 6
    Add a Candidate Journey  ${candidate_joruney_name}
    Create new custom conversation for mutli application    ${convo_title}   ${candidate_joruney_name}
    Create new applicant flows for multi applcation   ${af_title1}    ${AUTOMATION_TESTER_REQ_ID_040}  ${LOCATION_MAPPING_REQ_ID_010}   ${candidate_joruney_name}  ${convo_title}
    Turn on Chat to apply and select convo for catch all convo
    #   Set up to 'COMPANY_LOCATION_MAPPING_OFF'
    Add company for testing    ${COMPANY_LOCATION_MAPPING_OFF}
    # Step 1
    Turn on ATS and select feed
    Turn on Job Search toggle   Production  ${MASTER_FEED_MAPPING_OFF}
    Turn on Job Requisition ID Search
    Turn on Candidate Type(internal/external)
    Turn on Set Default Job Search Parameter and set parameter
    # Step 4
    Select Multi Application type in client setup   30
    # Step 3
    Create job search landing site/widget    Landing Site  ${landing_site_name}
    # Step 2
    Turn on Candidate Care
    # Step 6
    Turn on Candidate Journey and Applicant Flow
    Add a Candidate Journey  ${candidate_joruney_name}
    Create new custom conversation for mutli application    ${convo_title}   ${candidate_joruney_name}
    Create new applicant flows for multi applcation   ${af_title2}    ${AUTOMATION_TESTER_REQ_ID_010}  ${LOCATION_MAPPING_REQ_ID_010}   ${candidate_joruney_name}  ${convo_title}
    Turn on Chat to apply and select convo for catch all convo


*** Keywords ***
Create new custom conversation for mutli application
    [Arguments]  ${convo_name}   ${candidate_joruney_title}
    Go to conversation builder
    Add new custom conversation with name   ${convo_name}
    Add Candidate Journey to Custom Conversation  ${candidate_joruney_title}
    Input question name    welcome
    Add question by type  welcome  Full Name
    Add question by type  Full Name  Email
    Add question by type  Email  Phone Number
    Add question by type  Phone Number  Address
    Add end conversation to Custom Conversation   Address   End Conversation
    Capture page screenshot
    Public custom conversation

Create new custom conversation for default applicant flow
    [Arguments]  ${convo_name}   ${candidate_joruney_title}
    Go to conversation builder
    Add new custom conversation with name   ${convo_name}
    Add Candidate Journey to Custom Conversation  ${candidate_joruney_title}
    Input question name    welcome
    Add question by type  welcome  Full Name
    Add question by type  Full Name  Email
    Add end conversation to Custom Conversation   Email   End Conversation
    Capture page screenshot
    Public custom conversation

Create new applicant flows for multi applcation
    [Arguments]   ${af_name}    ${job_req_id1}  ${job_req_id2}   ${candidate_joruney_title}  ${conversation_title}
    Go to Applicant Flows
    ${is_displayed} =  Run keyword and return status   Check element display on screen  ${APPLICANT_FLOWS_CONFIGURE_DEFAULT_BUTTON}   wait_time=5s
    IF  ${is_displayed}
        #   Create default convo for default AF
        Create new custom conversation for default applicant flow   ${af_convo_tile}   Default Candidate Journey
        #   Go back to AF and add default AF
        Go to Applicant Flows
        Click at  ${APPLICANT_FLOWS_CONFIGURE_DEFAULT_BUTTON}
        Click at  ${APPLICANT_FLOWS_NEXT_STEP_BUTTON}
        Set conversation in applicant flows    ${af_convo_tile}
        Set interview in applicant flows
        Click at  ${APPLICANT_FLOWS_SAVE_FINISH_BUTTON}
    END
    Click at  ${APPLICANT_FLOWS_CREATE_NEW_BUTTON}   wait_time=5s
    Input into  ${APPLICANT_FLOWS_NAME_TEXTBOX}  ${af_name}
    Set condition in applicant flows    1   ${job_req_id1}
    Click at  ${APPLICANT_FLOWS_OR_BUTTON}
    Set condition in applicant flows    2   ${job_req_id2}
    #   Next stage
    Click at  ${APPLICANT_FLOWS_NEXT_STEP_BUTTON}
    Select Candidate Journey in applicant flows     ${candidate_joruney_title}
    Set conversation in applicant flows    ${conversation_title}
    Set interview in applicant flows
    Click at  ${APPLICANT_FLOWS_SAVE_FINISH_BUTTON}
