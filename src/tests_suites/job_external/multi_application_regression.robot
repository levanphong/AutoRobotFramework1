*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/conversation_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags          birddoghr    lowes    lts_stg    olivia    regression    stg    pepsi   unilever    dev    test    lowes_stg

Documentation   Run and read file to setup pre-condition: src/data_tests/job_external/multi_application.robot

*** Variables ***
${landing_site_title}               MultiApplicationLandingSite
${widget_site_title}                MultiApplicationWidget
${no_group_assigned}                No Group Assigned
${conversation_in_progress}         Conversation In-Progress
${capture_complete}                 Capture Complete

*** Test Cases ***
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

Check candidate finishes conversation then search and applies for another job in case multi application <>0 days (OL-T22393)
    # TODO: https://paradoxai.atlassian.net/browse/OL-80041
    [Tags]    skip
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_011}    ${AUTOMATION_TESTER_REQ_ID_011}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Candidate search for second job and apply
    Candidate input to landing site  ${ANY_JOB_ANY_WHERE}
    Search job and apply job   ${AUTOMATION_TESTER_REQ_ID_012}   ${AUTOMATION_TESTER_TITLE_012}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Go to CEM to check
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    #   Check the last message of system is Job Search Results
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_011}
    Check the last system message is    job-search
    #   Check the second candidate conversation starts with 'Chat to Apply' message
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_012}
    Check the first Olivia message  ${candidate_name}   ${AUTOMATION_TESTER_TITLE_012}


Check candidate returns by starting new conversation with the same information, applies for the another job (CAPTURE COMPLETED) in case multi applications <>0 days (internal type) (OL-T22395, OL-T22400)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_013}    ${AUTOMATION_TESTER_REQ_ID_013}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Candidate search for second job and apply
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_014}  ${AUTOMATION_TESTER_TITLE_014}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email_address}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Go to CEM to check
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_013}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    Internal
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_014}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    Internal


Check candidate does not finish Chat to apply conversation (CAPTURE INPROGRESS) then search for another job in case multi applications <>0 days (OL-T22396)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    #   Search and apply job, input full name but not finish conversation
    Go to landing site  ${landing_site_url}
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_010}  ${AUTOMATION_TESTER_TITLE_010}
    ${candidate_name} =  Generate random name only text  Fname
    Input candidate name twice  ${candidate_name}
    Verify AI message when asking about email in    Landing Site
    #   Search other job in case of unfinish conversation
    Candidate input to landing site  ${AUTOMATION_TESTER_REQ_ID_015}
    Verify AI message when asking about email in    Landing Site


Check candidate finishes conversation and click to Apply again on the job already applied in case number days of reapllies is >0 days (select directly from the previous Job Search Result) (OL-T22398)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_016}    ${AUTOMATION_TESTER_REQ_ID_016}  ${COMPANY_LOCATION_MAPPING_OFF}
    Click at  ${CONVERSATION_LIST_VIEW_ITEM}    ${AUTOMATION_TESTER_TITLE_016}
    Click at  ${CONVERSATION_APPLY_NOW_BUTTON}
    Check element not display on screen  ${CONVERSATION_APPLY_NOW_LOADING_ICON}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    ${cannot_apply_same_job} =  Format String  ${CANDIDATE_CANNOT_APPLY_SAME_JOB}   ${AUTOMATION_TESTER_TITLE_016}
    Should contain  ${olivia_message}   ${cannot_apply_same_job}


Check candidate reapply job in case complete conversation and number days of reapllies is >0 days (OL-T22399)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_017}    ${AUTOMATION_TESTER_REQ_ID_017}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Start new conversation and select previous job, input same information
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_017}  ${AUTOMATION_TESTER_TITLE_017}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email_address}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    ${cannot_apply_same_job} =  Format String  ${CANDIDATE_CANNOT_APPLY_SAME_JOB_1}   ${AUTOMATION_TESTER_TITLE_017}   ${AUTOMATION_TESTER_TITLE_017}
    Should contain  ${olivia_message}   ${cannot_apply_same_job}


Check candidate reapply job when Candidate Type (Internal) is toggled ON in case complete conversation and number days of reapllies is >0 days (select different Job Type) (OL-T22401)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_008}    ${AUTOMATION_TESTER_REQ_ID_008}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Candidate search for second job and apply
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_009}  ${LOCATION_MAPPING_TITLE_009}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email_address}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_LOCATION_MAPPING_OFF}
    #   Go to CEM to check
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_008}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    Internal
    Select candidate profile dropdown button  ${candidate_name}  ${LOCATION_MAPPING_TITLE_009}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External


Check candidate reapply job in case incomplete conversation and number days of reapllies is >0 days when candidate type is Internal(Candidate says Yes to continue the conversatiion) (OL-T22402)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    #   Apply to PAT010, but do not input address and not finish conversation
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_010}  ${AUTOMATION_TESTER_TITLE_010}
    ${candidate_random_name}  ${email} =  Candidate inputs neccessary information  phone=${CONST_PHONE_NUMBER}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    #   Start new convo and input same information
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_010}  ${AUTOMATION_TESTER_TITLE_010}  reset=True
    Candidate inputs neccessary information   name=${candidate_random_name}  email=${email}  phone=${CONST_PHONE_NUMBER}
    #   Olivia asks "It looks like you already have an application started. Do you want to complete this application?"
    ${olivia_message_1} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message_1}  ${CANDIDATE_CANNOT_APPLY_SAME_JOB_2}
    Candidate input to landing site   ${YES}
    #   Verify that Olivia asks again the last question that has been displayed in the previous conversation
    ${olivia_message_2} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message_2}  ${olivia_message}
    Candidate input to landing site   ${AUTOMATION_JOB_FEEDS_PROD_LOCATION_2}
    Candidate input to landing site   ${YES}
    #   Go to CEM and check candidate profile
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    Select candidate profile dropdown button  ${candidate_random_name}  ${no_group_assigned}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${conversation_in_progress}
    Select candidate profile dropdown button  ${candidate_random_name}  ${AUTOMATION_TESTER_TITLE_010}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${capture_complete}


Check candidate reapply job when Candidate Type (External) is toggled ON in case incomplete conversation and number days of reapllies is >0 days (Candidate says Yes to continue the conversatiion) (OL-T22404)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    #   Apply to MP010, but do not input address and not finish conversation
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}
    ${candidate_name_1}  ${email_1} =  Candidate inputs neccessary information  phone=${CONST_PHONE_NUMBER}
    #   Start candidate number 2 and input same phone number, new email
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}  reset=True
    ${candidate_name_2}  ${email_2} =  Candidate inputs neccessary information  phone=${CONST_PHONE_NUMBER}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    #   Go to CEM and check candidate profile
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    Open a candidate Conversation    ${candidate_name_1}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${conversation_in_progress}
    Open a candidate Conversation    ${candidate_name_2}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${conversation_in_progress}
    #   Start candidate number 3 and input same email2, new phone number
    Go to   ${landing_site_url}
    Wait for Olivia reply
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}  reset=True
    ${candidate_name_3}  ${email_2} =  Candidate inputs neccessary information   email=${email_2}   phone=${CONST_PHONE_NUMBER_1}
    #   Olivia asks "It looks like you already have an application started. Do you want to complete this application?"
    ${olivia_message_1} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message_1}  ${CANDIDATE_CANNOT_APPLY_SAME_JOB_2}
    Candidate input to landing site   ${YES}
    #   Verify that Olivia asks again the last question that has been displayed in the previous conversation
    ${olivia_message_2} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message_2}  ${olivia_message}
    Candidate input to landing site   ${AUTOMATION_JOB_FEEDS_PROD_LOCATION_2}
    Candidate input to landing site   ${YES}
    #   Go to CEM and check candidate profile
    Go to CEM page
    Select candidate profile dropdown button  ${candidate_name_3}  ${no_group_assigned}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${conversation_in_progress}
    Select candidate profile dropdown button  ${candidate_name_2}  ${LOCATION_MAPPING_TITLE_010}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${capture_complete}
    #   Start candidate number 4 and input same phone number 2, new email
    Go to   ${landing_site_url}
    Wait for Olivia reply
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}  reset=True
    ${candidate_name_4}  ${email_3} =  Candidate inputs neccessary information   phone=${CONST_PHONE_NUMBER_1}
    #   Go to CEM and check candidate profile
    Go to CEM page
    Open a candidate Conversation    ${candidate_name_4}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${conversation_in_progress}


Job external - Check candidate reapply job when Candidate Type (External) is toggled ON in case incomplete conversation and number days of reapllies is >0 days (Candidate says No to end the conversatiion) (OL-T22407)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    #   Apply to MP010, but do not input address and not finish conversation
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}
    ${candidate_name}  ${email} =  Candidate inputs neccessary information  phone=${CONST_PHONE_NUMBER}
    #   Start candidate number 2 and input same phone number, new email
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email}  phone=${CONST_PHONE_NUMBER}
    Candidate input to landing site   ${NO}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message}  ${HOW_MAY_I_ASSIST_YOU}
    #   Go to Cem to check candidate profile
    Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    Select candidate profile dropdown button  ${candidate_name}  ${LOCATION_MAPPING_TITLE_010}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${LOCATION_MAPPING_REQ_ID_010}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External
    Select candidate profile dropdown button  ${candidate_name}  ${no_group_assigned}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    No Job Assigned


Check manual candidate finishes conversation then search and apply the job already applied in case number days of reapllies is >0 days (OL-T22419)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_019}  ${AUTOMATION_TESTER_TITLE_019}
    ${candidate_name}  ${email} =  Candidate inputs neccessary information
    #   Search and apply again, show message "It looks like you have already applied to {job_title} recently. Please select another job to apply to."
    Click at  ${CONVERSATION_LIST_VIEW_ITEM}    ${AUTOMATION_TESTER_TITLE_019}
    Click at  ${CONVERSATION_APPLY_NOW_BUTTON}
    Check element not display on screen  ${CONVERSATION_APPLY_NOW_LOADING_ICON}
    Verify last message content should be   ${CANDIDATE_ALREADY_APPLIED_JOB}  ${AUTOMATION_TESTER_TITLE_019}

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


Check candidate finishes conversation and click to Apply another job on the old job search in case multi application = 0 days on widget (OL-T22394)
    Given Setup test
    ${widget_site_url} =  Get widget conversation link   ${widget_site_title}
    Go to widget site  ${widget_site_url}
    Search job and apply job on widget  ${AUTOMATION_TESTER_REQ_ID_060}
    ${candidate_name}  ${email} =  Candidate inputs neccessary information on widget
    Search job and apply job on widget  ${LOCATION_MAPPING_REQ_ID_004}  reset=True
    Candidate inputs neccessary information on widget    name=${candidate_name}  email=${email}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}  Widget
    #   Go to CEM to check
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    #   Check the last message of system is Job Search Results
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_060}
    Check the last system message is    move-status
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External
    #   Check the second candidate conversation starts with 'Chat to Apply' message
    Select candidate profile dropdown button  ${candidate_name}  ${LOCATION_MAPPING_TITLE_004}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External


Check candidate finishes conversation and click to Apply again on the job already applied in case number days of reapply is 0 days (OL-T22408)
    # TODO: https://paradoxai.atlassian.net/browse/OL-80041
    [Tags]    skip
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_047}    ${AUTOMATION_TESTER_REQ_ID_047}  ${COMPANY_APPLICANT_FLOW}
    Click details button and apply job  ${AUTOMATION_TESTER_TITLE_047}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    ${tks_for_applied} =  Format String  ${THANKS_MESSAGE}   ${COMPANY_APPLICANT_FLOW}
    Should contain  ${olivia_message}   ${tks_for_applied}


Check candidate reapply same job when candidate is incomplete convo in case number days of reapply is 0 days (Candidate says Yes to continue the conversation) (OL-T22410, OL-T22412)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    #   Apply to PAT010, but do not input address and not finish conversation
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_040}  ${AUTOMATION_TESTER_TITLE_040}
    ${candidate_random_name}  ${email} =  Candidate inputs neccessary information  phone=${CONST_PHONE_NUMBER}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    #   Start new convo and input same information
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_040}  ${AUTOMATION_TESTER_TITLE_040}  reset=True
    Candidate inputs neccessary information   name=${candidate_random_name}  email=${email}  phone=${CONST_PHONE_NUMBER}
    #   Olivia asks "It looks like you already have an application started. Do you want to complete this application?"
    ${olivia_message_1} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message_1}  ${CANDIDATE_CANNOT_APPLY_SAME_JOB_2}
    Candidate input to landing site   ${YES}
    #   Verify that Olivia asks again the last question that has been displayed in the previous conversation
    ${olivia_message_2} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message_2}  ${olivia_message}
    Candidate input to landing site   ${AUTOMATION_JOB_FEEDS_PROD_LOCATION_2}
    Candidate input to landing site   ${YES}
    #   Go to CEM and check candidate profile
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Select candidate profile dropdown button  ${candidate_random_name}  ${no_group_assigned}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${conversation_in_progress}
    Select candidate profile dropdown button  ${candidate_random_name}  ${AUTOMATION_TESTER_TITLE_040}
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${capture_complete}


Check candidate reapply same job when candidate is incomplete convo in case number days of reapply is 0 days (Candidate says No to End the conversation) (OL-T22411, OL-T22413)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    #   Apply to MP010, but do not input address and not finish conversation
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}
    ${candidate_name}  ${email} =  Candidate inputs neccessary information  phone=${CONST_PHONE_NUMBER}
    #   Start candidate number 2 and input same phone number, new email
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_010}  ${LOCATION_MAPPING_TITLE_010}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email}  phone=${CONST_PHONE_NUMBER}
    Candidate input to landing site   ${NO}
    ${olivia_message} =  Get latest message of Olivia in Landing site
    Should contain   ${olivia_message}  ${HOW_MAY_I_ASSIST_YOU}
    #   Go to Cem to check candidate profile
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Select candidate profile dropdown button  ${candidate_name}  ${LOCATION_MAPPING_TITLE_010}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${LOCATION_MAPPING_REQ_ID_010}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External
    Select candidate profile dropdown button  ${candidate_name}  ${no_group_assigned}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    No Job Req ID Assigned


Check candidate reapply same job when candidate is incomplete convo and Candidate Type (Internal/External) is toggled ON in case number days of reapply is 0 days (Candidate selects different types) (OL-T22414)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${LOCATION_MAPPING_TITLE_008}    ${LOCATION_MAPPING_REQ_ID_008}  ${COMPANY_APPLICANT_FLOW}
    #   Candidate search for second job and apply
    Search job and apply job    ${LOCATION_MAPPING_REQ_ID_009}  ${LOCATION_MAPPING_TITLE_009}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email_address}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}
    #   Go to CEM to check
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Select candidate profile dropdown button  ${candidate_name}  ${LOCATION_MAPPING_TITLE_008}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External
    Select candidate profile dropdown button  ${candidate_name}  ${LOCATION_MAPPING_TITLE_009}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    External


Job external - Check candidate reapply same job when candidate is completed convo and Candidate Type (Internal/External) is toggled ON in case number days of reapply is 0 days (OL-T22415, OL-T22416)
    Given Setup test
    ${landing_site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${landing_site_title}
    Go to landing site  ${landing_site_url}
    ${candidate_name}  ${email_address} =  Candidate apply job and input information   ${AUTOMATION_TESTER_TITLE_074}    ${AUTOMATION_TESTER_REQ_ID_074}  ${COMPANY_APPLICANT_FLOW}
    Search job and apply job    ${AUTOMATION_TESTER_REQ_ID_074}  ${AUTOMATION_TESTER_TITLE_074}  reset=True
    Candidate inputs neccessary information  name=${candidate_name}  email=${email_address}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}
    #   Go to CEM to check
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    #   Check the last message of system is Job Search Results
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_074}  index=3
    Check the last system message is    move-status
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    Internal
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${capture_complete}
    #   Check the second candidate conversation starts with 'Chat to Apply' message
    Select candidate profile dropdown button  ${candidate_name}  ${AUTOMATION_TESTER_TITLE_074}  index=2
    Check the last system message is    move-status
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    Internal
    Verify text contain   ${SET_CANDIDATE_JOURNEYS_BUTTON}  ${capture_complete}

*** Keywords ***
Check the last system message is
    [Arguments]   ${system_type}=job-search
    ${attribute} =  Get attribute and format text  class  ${CONVERSATION_LAST_SYSTEM_MESSAGE}
    Should contain  ${attribute}    ${system_type}

Check the first Olivia message
    [Arguments]  ${candidate_name}  ${job_title}
    ${candidate_name} =  Split String    ${candidate_name}    ${SPACE}
    ${olivia_message} =  Format String  ${TKS_AND_HAPPY_TO_HELP}    ${candidate_name}[0]  ${job_title}
    Verify text contain   ${CONVERSATION_FIRST_OLIVIA_MESSAGE}   ${olivia_message}

Candidate inputs neccessary information
    [Arguments]  ${name}=None    ${email}=None    ${phone}=None    ${address}=None
    Wait for Olivia reply
    IF     '${name}' == 'None'
        ${name_info} =    generate candidate name
        ${name} =  Set variable  ${name_info.full_name}
    END
    Input candidate name twice  ${name}
    IF     '${email}' == 'None'
        &{email_info} =    Get email for testing
        ${email} =  Set variable  ${email_info.email}
    END
    Candidate input to landing site  ${email}
    Run keyword if   '${phone}' != 'None'  Candidate input to landing site  ${phone}
    IF   '${address}' != 'None'
        Candidate input to landing site  ${address}
        Candidate input to landing site  ${YES}
    END
    [Return]  ${name}   ${email}

Candidate apply job and input information
    [Arguments]    ${job_title}   ${job_req_id}  ${company_name}
    Candidate input to landing site  ${job_req_id}
    Click details button and apply job  ${job_title}
    Verify AI message when asking about name in   Landing Site
    ${candidate_random_name} =    generate candidate name
    Input candidate name twice  ${candidate_random_name.full_name}
    Verify AI message when asking about email in   Landing Site
    &{email_info} =    Get email for testing
    Candidate input to landing site  ${email_info.email}
    Verify last message content should be  ${THANKS_MESSAGE}  ${company_name}
    [Return]    ${candidate_random_name.full_name}    ${email_info.email}

Search job and apply job
    [Arguments]  ${job_req_id}  ${job_title}   ${reset}=False
    IF   ${reset}
        Candidate input to landing site  ${NEW}
        ${check_message} =  Get latest message of Olivia in Landing site
        Should match regexp  ${check_message}  ${SHOW_JOB_SEARCH_MESSAGE}
    END
    Candidate input to landing site  ${job_req_id}
    Click details button and apply job  ${job_title}

Search job and apply job on widget
    [Arguments]  ${job_req_id}  ${reset}=False
    IF   ${reset}
        Input text for widget site  ${NEW}
        ${first_message} =  Get text and format text  ${MESSAGE_CONVERSATION}
        Should match regexp  ${first_message}   ${SHOW_JOB_SEARCH_MESSAGE}
    END
    Input text for widget site  ${job_req_id}
    Click at  ${SHADOW_DOM_DETAILS_CONTENT}
    Click at  ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    Check element not display on screen  ${SHADOW_DOM_SELECTED_JOB_APPLY_LOADING_ICON}

Candidate inputs neccessary information on widget
    [Arguments]  ${name}=None    ${email}=None    ${phone}=None    ${address}=None
    Wait for Olivia reply on widget
    ${latest_message} =  Get latest message in Shadow Root
    Should match regexp  ${latest_message}  ${WELCOME_APPLIED_JOB_MESSAGE}
    Input text for widget site  ${HI}
    IF     '${name}' == 'None'
        ${name_info} =    generate candidate name
        ${name} =  Set variable  ${name_info.full_name}
    END
    Input candidate name twice for Shadow Root  ${name}
    IF     '${email}' == 'None'
        &{email_info} =    Get email for testing
        ${email} =  Set variable  ${email_info.email}
    END
    Input text for widget site  ${email}
    Run keyword if   '${phone}' != 'None'  Candidate input to landing site  ${phone}
    IF   '${address}' != 'None'
        Input text for widget site  ${address}
        Input text for widget site  ${YES}
    END
    [Return]  ${name}   ${email}

Click details button and apply job
    [Arguments]  ${job_title}
    Click at  ${CONVERSATION_LIST_VIEW_ITEM}    ${job_title}
    Click at  ${CONVERSATION_APPLY_NOW_BUTTON}
    Check element not display on screen  ${CONVERSATION_APPLY_NOW_LOADING_ICON}
    ${latest_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${latest_message}  ${WELCOME_APPLIED_JOB_MESSAGE}
    Candidate input to landing site  ${HI}
