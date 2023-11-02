*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/applicant_flows_page.robot
Resource            ../job_external/client_jobs/cvo/my_jobs_page/cvo_flow.resource
Variables           ../../constants/CandidateJourneyConst.py
Variables           ../../constants/ConversationConst.py

Documentation       'Run src/data_tests/offers/offer_stage_data_test.robot'

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        test

*** Variables ***
${cj_name}                          Candidate Journey for Offer Stage
${stage_type}                       Offer
${job_location}                     ${CONST_LOCATION}
${job_name}                         Job For Offer Stage
${offer_name}                       Offer for Expiration and Canceled Statuses
${editable_msg}                     Sorry, your offer has been canceled
${editing_offer_content}            Text is used for editing offer content but no displaying on old version offer
${offer_name_1}                     OFFER_STAGE_AF
${offer_name_2}                     Offer_for_edit_content
${AF_change_offer_1}                Offer_for_AF_change_offer_1
${AF_change_offer_2}                Offer_for_AF_change_offer_2
${AF_change_offer}                  AF_change_offer
${confirm_cancel_offer_message}     Hi {}, unfortunately your offer at {} has been canceled. We will contact you as soon as possible.
${status_offer_canceled}            Canceled
${af_conversation_name}             AF_Custom_Builder_Offer_Stage
${af_candidate_journey_name}        AF_JOURNEY_SEND_OFFER_STAGE

*** Test Cases ***
Candidate applied the Internal Job: Verify two new statuses (Offer Expired & Offer Canceled) added the offer stage that used (OL-T23404, OL-T23405)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Click A Journey     ${cj_name}
    Click At    ${STAGE_NAME_IN_JOURNEY}    Offer
    Check Element Display On Screen     Offer Expired
    Check Element Display On Screen     Offer Canceled


Candidate applied the Internal Job: Verify two new statuses (Offer Expired & Offer Canceled) added the offer stage that will add in the new CJ (OL-T23406)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${journey_name} =       Add a Candidate Journey
    Click A Journey     ${journey_name}
    Add a stage     ${stage_type}
    Click At    ${STAGE_NAME_IN_JOURNEY}    Offer
    Check Element Display On Screen     Offer Expired
    Check Element Display On Screen     Offer Canceled
    Delete a Journey    ${journey_name}


Candidate applied the Internal Job: Verify new 2 statuses appear & unlock in the Offer stage on CEM when clicking on the status dropdown (OL-T23421)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name} =     Add A Candidate To Job Via CEM      ${job_location}     ${job_name}
    Click On Candidate Name     ${candidate_name}
    Click At    ${CEM_CANDIDATE_JOURNEYS_BUTTON}
    Click At    ${JOURNEY_TASK_OPTION}      Offer
    Check Element Display On Screen     ${JOURNEY_TASK_STATUS_OPTION}       Send Offer
    Verify Element Is Enabled By Checking Class     ${JOURNEY_TASK_STATUS_OPTION}       Offer Expired
    Verify Element Is Enabled By Checking Class     ${JOURNEY_TASK_STATUS_OPTION}       Offer Canceled


Verify new 2 statuses appear & unlock in the Offer stage on CEM when clicking on the status dropdown (OL-T23734)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    &{info}=    Apply job       ${AUTOMATION_TESTER_TITLE_066}
    Go to CEM page
    Search and click candidate on CEM       ${info.candidate_name}
    Click at    ${CEM_CANDIDATE_JOURNEYS_BUTTON}
    ${is_more_option} =     Run keyword and return status       Check element display on screen     More Options    wait_time=2s
    Run keyword if      ${is_more_option}       Click on span text      More Options
    Click at    ${JOURNEY_TASK_OPTION}      Offer
    # check new 2 statuses appear & unlock
    Check 2 new statuses appear & unlock


Verify the message Offer cannot be canceled because it has not been sent yet show when the candidate's status is Offer Expired after then clicking on the Offer Canceled status (OL-T23791)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    Updated conversation status     ${info.candidate_name}      Offer       Offer Expired
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Offer Expired
    capture page screenshot
    Updated conversation status     ${info.candidate_name}      Offer       Offer Canceled
    Check element display on screen     Offer cannot be canceled because it has not been sent yet
    capture page screenshot


Verify the Offer cannot be canceled because it has already been completed (OL-T23789)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    Click at    ${CONVERSATION_LINK_OFFER}
    @{window} =     get window handles
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Offer In-Progress
    capture page screenshot
    Switch window       ${window}[1]
    Enter code for verify code step     ${info.candidate_name}
    Click at    ${YOUR_OFFER_ACCEPT_BUTTON}
    Switch window       ${window}[0]
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Offer Accepted
    capture page screenshot
    Updated conversation status     ${info.candidate_name}      Offer       Offer Canceled
    Check element display on screen     Offer cannot be canceled because it has already been completed
    capture page screenshot


Verify all fields are blank & Send Offer show at the bottom of the Offer detail when the candidate's status is Offer Canceled (OL-T23764, OL-T23765, OL-T23757)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    reload page
    Click on span text      Hire Details
    Click at    ${CEM_HIRE_DETAILS_OFFER_NAME}      ${offer_name_1}
    wait for page load successfully v1
    Click at    Cancel Offer
    # check comfirm popup display and can edit content message in popup
    Verify can edit content message in Cancel Offer popup       ${info.candidate_name}
    Click at    Confirm
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been canceled
    #check the candidate gets the content
    Check element display on screen     ${CONVERSATION_OLIVIA_MESSAGE_CONTENT}      ${confirm_cancel_offer_message}
    capture page screenshot
    Click on span text      Hire Details
    Click at    ${CEM_HIRE_DETAILS_OFFER_NAME}      ${offer_name_1}
    # Check all fields blank and Send offer display
    Check UI an offer after click Cancel Offer button
    # OL-T23765: Verify the Canceled Offer be recorded in the [Offer History]
    Verify the Canceled Offer be recorded in the Offer History
    # OL-T23757: Verify the candidate gets the content that the User edit the Confirmation popup
    ${content_message}=     format string       ${confirm_cancel_offer_message}     ${info.candidate_name}      ${COMPANY_LOCATION_MAPPING_OFF}
    Verify user has received the email      Your pending offer with ${COMPANY_LOCATION_MAPPING_OFF} has been canceled.      ${content_message}      CANCEL_SCHEDULE


Verify the Cancel button shows at the bottom of the Offer Detail when opening the Offer that has the status is In-progress (OL-T23744, OL-T23743)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Send Offer
    reload page
    Click on span text      Hire Details
    Click at    ${offer_name_1}
    # OL-T23743: Verify the [Cancel] button shows at the bottom of the Offer Detail when opening the Offer that has the status is Sent
    Check element display on screen     ${CONFIRM_OFFER_CANCEL_BUTTON}
    capture page screenshot
    reload page
    Search and click candidate on CEM       ${info.candidate_name}
    Click at    ${CONVERSATION_LINK_OFFER}
    @{window} =     get window handles
    Switch window       ${window}[0]
    reload page
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Offer In-Progress
    capture page screenshot
    Cancel offer via Hire Details       ${offer_name_1}


Candidate applied the Internal Job: Verify the Offer file & Send Offer show at the bottom of the Offer detail when the candidate's status is Offer Canceled (OL-T23469, OL-T23470)
    [Documentation]     create AF with internal job PAT001, using external offer.
    # apply internal job, external offer upload
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_001}      is_spam_email=False
    ${file_offer_name}=     Send external offer     ${info.candidate_name}
    reload page
    Click on span text      Hire Details
    Click at    ${CEM_HIRE_DETAILS_OFFER_NAME}      ${file_offer_name}
    wait for page load successfully v1
    Click at    Cancel Offer
    Click at    Confirm
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been canceled
    capture page screenshot
    Click on span text      Hire Details
    Click at    ${CEM_HIRE_DETAILS_OFFER_NAME}      ${file_offer_name}
    # check offer blank and Send Offer button display
    Check text display      Drag a file here or click to browse
    Check element display on screen     ${CONFIRM_OFFER_SEND_BUTTON}
    capture page screenshot
    # re-upload the file offer
    Upload an offer
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    # OL-T23470: [Candidate applied the Internal Job]: Verify the offer re-send successfully when the candidate's status is [Offer Canceled]
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been sent
    capture page screenshot


Verify the candidate's status is Offer Canceled when clicking on the Cancel button on the Offer detail (OL-T23760, OL-T23745, OL-T23768, OL-T23790)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Send Offer
    capture page screenshot
    reload page
    Click on span text      Hire Details
    Click at    ${CEM_HIRE_DETAILS_OFFER_NAME}      ${offer_name_1}
    wait for page load successfully v1
    Click at    Cancel Offer
    # OL-T23745: Verify the confirmation popup shows when clicking on [Cancel] button at the bottom of the Offer detail
    # Check UI of Confirm Cancel popup
    Check UI of Confirm Cancel popup    ${info.candidate_name}      ${COMPANY_LOCATION_MAPPING_OFF}
    Click at    Confirm
    wait for page load successfully v1
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Offer Canceled
    Click on span text      Hire Details
    Check element display on screen     ${CEM_OFFER_STATUS_CANCELED}    ${offer_name_1}
    capture page screenshot
    Click at    ${CEM_CANDIDATE_JOURNEYS_BUTTON}
    ${is_more_option} =     Run keyword and return status       Check element display on screen     More Options    wait_time=2s
    Run keyword if      ${is_more_option}       Click on span text      More Options
    # OL-T23790: Verify the message: "Offer cannot be expired because it has not been sent yet" show when the candidate's status is [Offer canceled] after then clicking on the [Offer Expired] status
    Click at    ${JOURNEY_TASK_STATUS_OPTION}       Offer Expired
    # OL-T23768: Verify the error message show when moving [Offer Canceled] status to [Offer Expired] status
    Check text display      Offer cannot be expired because it has not been sent yet


Verify the candidate's status is Offer Canceled when clicking on the Offer Canceled status on the status dropdown (OL-T23761)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Send Offer
    Updated conversation status     ${info.candidate_name}      Offer       Offer Canceled
    # Change status from Send Offer to Offer Canceled
    Click at    ${CONFIRM_OFFER_CANCEL_BUTTON}
    Click at    Confirm
    # Check the Confirmation popup closed
    Check element not display on screen     Confirm
    capture page screenshot
    reload page
    # The candidate's status move [Send Offer] to [Offer Canceled]
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Offer Canceled
    capture page screenshot
    Click on span text      Hire Details
    # Check The Offer's status is Canceled on the [Hire Detail] tab
    Check element display on screen     ${CEM_OFFER_STATUS_CANCELED}    ${offer_name_1}
    capture page screenshot
    # Milestone update
    ${milestone_update}=    format string       ${CONVERSATION_MILESTONE_STATUS_UPDATE}     Send Offer      Offer Canceled
    Check element display on screen     ${milestone_update}
    # check message sent to candidate'chanel
    ${content_message}=     set variable    Hi ${info.candidate_name}
    Verify user has received the email      Your pending offer with ${COMPANY_LOCATION_MAPPING_OFF} has been canceled.      ${content_message}      CANCEL_SCHEDULE


Candidate applied the Internal Job: Verify the Cancel button shows at the bottom of the Offer Detail when opening the Offer that has the status is Sent (OL-T23430, OL-T23431, OL-T23432, OL-T23434, OL-T23438)
    Given Setup Test
    Login Into System With Company      ${CP_ADMIN}     ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name} =     Add A Candidate To Job Via CEM      ${job_location}     ${job_name}
    Change Conversation Status To Send Offer    ${candidate_name}       ${JOURNEY_OFFER_STATUS}
    # OL-T23430
    Reload Page
    Check Candidate Journey status      ${candidate_name}       Send Offer
    Click At    ${CEM_OFFERS_ITEM}      ${offer_name}
    Check Element Display On Screen     Cancel Offer
    Capture Page Screenshot
    Reload Page
    # OL-T23431
    Click At    ${OFFER_LINK}
    @{window} =     Get Window Handles
    Switch Window       ${window}[0]
    Wait With Medium Time  # wait for the status [Send Offer] changes to [Offer In-Progress]
    Check Candidate Journey Status      ${candidate_name}       Offer In-Progress
    Click At    ${CEM_OFFERS_ITEM}      ${offer_name}
    Check Element Display On Screen     Cancel Offer
    Capture Page Screenshot
    # OL-T23432
    Click At    Cancel Offer
    Check Element Display On Screen     ${CANCEL_OFFER_MODAL_HEADER}
    Check Element Display On Screen     ${CANCEL_OFFER_MODAL_TITLE}     ${candidate_name}
    Check Element Display On Screen     ${CANCEL_OFFER_MODAL_CONTENT}       ${candidate_name}
    Check Element Display On Screen     ${CANCEL_OFFER_NEVERMIND_BUTTON}
    # OL-T23434, OL-T23438
    Click At    ${CANCEL_OFFER_CONFIRM_BUTTON}
    Wait With Short Time  # wait for the message should be appeared
    ${canceled_offer_msg} =     Format String       ${CANCELED_OFFER_MESSAGE}       ${candidate_name}       ${COMPANY_DATA_PACKAGE_OFF}
    Check Element Display On Screen     ${canceled_offer_msg}
    # OL-T23455 - Verify error message when moving [Offer canceled] to [Offer Expired]
    Click At    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click At    ${JOURNEY_TASK_STATUS_OPTION}       Offer Expired
    Check Element Display On Screen     Offer cannot be expired because it has not been sent yet
    Capture Page Screenshot


Candidate applied the Internal Job: Verify the candidate gets the content that the User edit the Confirmation popup (OL-T23444, OL-T23447, OL-T23450, OL-T23451, OL-T23452, OL-T23453)
    Given Setup Test
    Login Into System With Company      ${CP_ADMIN}     ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name} =     Add A Candidate To Job Via CEM      ${job_location}     ${job_name}
    Change Conversation Status To Send Offer    ${candidate_name}       ${JOURNEY_OFFER_STATUS}
    Reload Page
    Click At    ${CEM_OFFERS_ITEM}      ${offer_name}
    Click At    Cancel Offer
    # OL-T23444
    Simulate Input      ${CANCEL_OFFER_INPUT}       ${editable_msg}
    Click At    ${CANCEL_OFFER_CONFIRM_BUTTON}  # cancel offer via Hire Details on CEM
    Wait With Short Time  # wait for the message should be appeared
    Check Element Display On Screen     ${editable_msg}
    Check Candidate Journey status      ${candidate_name}       Offer Canceled
    # OL-T23451 - check all fields of the offer are blank after canceled
    Check Element Display On Screen     Send Offer
    Click At    ${CEM_OFFERS_ITEM}      ${offer_name}
    Textfield Value Should Be       ${CONFIRM_OFFER_START_DATE}     ${EMPTY}
    Textfield Value Should Be       ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}    ${EMPTY}
    # OL-T23452 - check Canceled Offer be recorded in [Offer History]
    Check Element Display On Screen     ${ICON_CANCEL_OFFER_HISTORY}
    Check Element Display On Screen     Olivia Canceled
    Check Element Display On Screen     ${DATE_TIMESTAMP_CANCELED_OFFER_HISTORY}  # Check timestamp of the canceled offer be recorded in [Offer History]
    Reload Page
    # OL-T23447
    Check status of offer displayed on Hire Details     Canceled
    # OL-T23450
    Click At    ${OFFER_LINK}
    Check Element Display On Screen     ${ICON_ERROR_OFFER_PAGE}
    Check Element Display On Screen     ${TITLE_ERROR_OFFER_PAGE}
    # OL-T23453 - re-send offer successfully via Hire Details
    @{window} =     Get Window Handles
    Switch Window       ${window}[0]
    Re-send Offer Via Hire Details      ${offer_name}
    Reload Page
    Check Element Display On Screen     ${OFFER_LINK}
    Check Candidate Journey status      ${candidate_name}       Send Offer
    Check status of offer displayed on Hire Details     Updated


Candidate applied the Internal Job: Verify the candidate's status is Offer Canceled when clicking on the Offer Canceled status on the status dropdown (OL-T23448, OL-T23454)
    Given Setup Test
    Login Into System With Company      ${CP_ADMIN}     ${COMPANY_DATA_PACKAGE_OFF}
    ${candidate_name} =     Add A Candidate To Job Via CEM      ${job_location}     ${job_name}
    Change Conversation Status To Send Offer    ${candidate_name}       ${JOURNEY_OFFER_STATUS}
    Wait With Medium Time  # wait for the status changes to [Send Offer]
    # OL-T23448 - cancel offer via Candidate status dropdown
    Click At    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click At    ${JOURNEY_TASK_STATUS_OPTION}       Offer Canceled
    Click At    Cancel Offer
    Click At    ${CANCEL_OFFER_CONFIRM_BUTTON}
    Check status of offer displayed on Hire Details     Canceled
    # OL-T23454 - re-send offer via Candidate status dropdown
    Re-send Offer via Candidate status dropdown     ${candidate_name}
    Check Element Display On Screen     ${OFFER_LINK}       wait_time=3s
    Reload Page
    Check Candidate Journey Status      ${candidate_name}       Send Offer
    Check Status Of Offer Displayed On Hire Details     Updated


Candidate applied the Internal Job: Verify the Offer version resends when the user edits and published the same offer after then resending the Offer (OL-T23456)
    Given Setup Test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${candidate_name} =     Add A Candidate To Job Via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_001}
    Switch To User      ${CA_TEAM}
    Change conversation status to send offer    ${candidate_name}       ${JOURNEY_OFFER_STATUS}
    Reload Page
    Click At    ${CEM_OFFERS_ITEM}      ${offer_name}
    Click At    Cancel Offer
    Click At    ${CANCEL_OFFER_CONFIRM_BUTTON}
    Navigate to offer page      ${offer_name}
    Updating An Offer By Editing Content    ${editing_offer_content}
    Go To CEM Page
    Click On Candidate Name     ${candidate_name}
    Change Conversation Action Status       ${candidate_name}       ${JOURNEY_OFFER_STATUS}     ${JOURNEY_SEND_OFFER_ACTION}    is_confirm=False
    Check Element Not Display On Screen     ${editing_offer_content} # check offer's content would not be changed after editing and still display ole version
    Capture Page Screenshot


Candidate applied the Internal Job: Verify the message: Offer cannot be expired because it has already been completed show when the candidate's status is Offer Accepted status after then clicking on the Offer Expired (OL-T23463, OL-T23464)
    Given Setup Test
    Login Into System With Company      ${CP_ADMIN}     ${COMPANY_NEXT_STEP}
    ${candidate_name} =     Add A Candidate To Job Via CEM      ${job_location}     ${job_name}     is_spam_email=False
    Send Offer And Input Verify Code    ${candidate_name}       ${JOURNEY_OFFER_STATUS}     ${COMPANY_NEXT_STEP}
    Click At    ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    Capture Page Screenshot
    # OL-T23463
    Go To CEM Page
    Click On Candidate Name     ${candidate_name}
    Click At    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click At    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}       ${next_steps_button}
    Click At    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}       ${JOURNEY_EXPIRED_OFFER_ACTION}
    Check Span Display      Offer cannot be expired because it has already been completed
    Capture Page Screenshot
    # OL-T23464
    Click At    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON_STATUS_UPDATE}     Cancel
    Click At    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}       ${JOURNEY_CANCEL_OFFER_ACTION}
    Check Span Display      Offer cannot be canceled because it has already been completed
    Capture Page Screenshot


Candidate applied the Internal Job: Verify the message: Offer cannot be expired because it has not been sent yet show when the candidate's status is Offer canceled after then clicking on the Offer Expired status (OL-T23465, OL-T23466)
    Given Setup Test
    Login Into System With Company      ${CP_ADMIN}     ${COMPANY_NEXT_STEP}
    ${candidate_name} =     Add A Candidate To Job Via CEM      ${job_location}     ${job_name}
    Change Conversation Status To Send Offer    ${candidate_name}       ${JOURNEY_OFFER_STATUS}
    Reload Page
    Click At    ${CEM_OFFERS_ITEM}      ${offer_name}
    Click At    Cancel Offer
    Click At    ${CANCEL_OFFER_CONFIRM_BUTTON}
    Wait With Short Time  # wait for that the status changes to [Offer Canceled]
    # OL-T23465
    Change Conversation Action Status       ${candidate_name}       ${JOURNEY_OFFER_STATUS}     ${JOURNEY_EXPIRED_OFFER_ACTION}     is_confirm=False
    Check Span Display      Offer cannot be expired because it has not been sent yet
    Capture Page Screenshot
    # OL-T23466
    Re-send Offer Via Candidate Status Dropdown     ${candidate_name}
    Wait With Short Time  # wait for that the status changes to [Send Offer]
    Change Conversation Action Status       ${candidate_name}       ${JOURNEY_OFFER_STATUS}     ${JOURNEY_EXPIRED_OFFER_ACTION}
    Wait With Short Time  # wait for that the status changes to [Offer Expired]
    Change Conversation Action Status       ${candidate_name}       ${JOURNEY_OFFER_STATUS}     ${JOURNEY_CANCEL_OFFER_ACTION}      is_confirm=False
    Check Span Display      Offer cannot be canceled because it has not been sent yet
    Capture Page Screenshot


Verify the Offer file & Send Offer show at the bottom of the Offer detail when the candidate's status is Offer Canceled (OL-T23794)
    [Documentation]     create AF with external job PAT069, using Offer external.
    # Apply external job, External offer upload
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_069}      is_spam_email=False
    ${offer_file_name}=     Send external offer     ${info.candidate_name}
    reload page
    Cancel offer via Hire Details       ${offer_file_name}
    capture page screenshot
    Click on span text      Hire Details
    Click at    ${CEM_HIRE_DETAILS_OFFER_NAME}      ${offer_file_name}
    # check the Offer file clears & [Send Offer] show the bottom
    Check text display      Drag a file here or click to browse
    Check element display on screen     ${CONFIRM_OFFER_SEND_BUTTON}
    capture page screenshot


Verify the Offer page is an error page show when the candidate's status is Offer Canceled (OL-T23763, OL-T23766)
    [Documentation]     create AF with external job PAT066
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    reload page
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Send Offer
    capture page screenshot
    Cancel offer via Hire Details       ${offer_name_1}
    # OL-T23763: Verify the Offer page is an error page show when the candidate's status is Offer Canceled
    Click at    ${CONVERSATION_LINK_OFFER}
    @{window} =     get window handles
    Switch window       ${window}[1]
    Check UI Error page show when the candidate's status is Offer Canceled
    # OL-T23766: Verify the Offer resends successfully when clicking on [Send Offer] button on the Offer detail
    Switch window       ${window}[0]
    # re-send offer from Hire Detail tab
    Click on span text      Hire Details
    Click at    ${offer_name_1}
    Fill all required fields in offer       50      per hour    ${offer_name_1}
    capture page screenshot
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    # check the Offer resends successfully
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been sent
    capture page screenshot
    reload page
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Send Offer
    capture page screenshot
    # The Offer's status in [Hire Detail] tab is updated
    Check element display on screen     ${CEM_OFFER_STATUS_UPDATED}     ${offer_name_1}
    capture page screenshot
    # Check the candidate gets the Offer link
    Check element display on screen     ${CONVERSATION_LINK_OFFER}


Verify the offer re-send successfully when the candidate's status is Offer Canceled (OL-T23795)
    [Documentation]     create AF with external job PAT069, using Offer external.
    # apply external job, external offer upload
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_069}      is_spam_email=False
    ${offer_file_name}=     Send external offer     ${info.candidate_name}
    reload page
    Cancel offer via Hire Details       ${offer_file_name}
    reload page
    Click on span text      Hire Details
    Check element display on screen     ${CEM_OFFER_STATUS_CANCELED}    ${offer_file_name}
    Click at    ${offer_file_name}
    Check text display      Drag a file here or click to browse
    # re-upload offer.
    Upload an offer
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    # check re-sent external offer successful
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been sent


Verify the candidate gets the message via Email when the Offer is Canceled (OL-T23749)
    [Documentation]     create AF with external job PAT066
     # apply external job, Offer paradox.
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    reload page
    Cancel offer via Hire Details       ${offer_name_1}
    reload page
    ${content_message}=     set variable    Hi ${info.candidate_name}
    Verify user has received the email      Your pending offer with ${COMPANY_LOCATION_MAPPING_OFF} has been canceled.      ${content_message}      CANCEL_SCHEDULE


Verify the Offer resends successfully when clicking on Send Offer status on the status dropdown (OL-T23767)
    [Documentation]     create AF with external job PAT066
    # apply external job, Offer paradox.
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_066}      is_spam_email=False
    # Send offer
    Send offer      ${info.candidate_name}      50      ${offer_name_1}
    reload page
    # cancel offer
    Cancel offer via Hire Details       ${offer_name_1}
    reload page
    # re-send offer by update candidate status -->Send Offer
    Updated conversation status     ${info.candidate_name}      Offer       Send Offer
    Fill all required fields in offer       60      per hour    ${offer_name_1}
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    # The Offer resends successfully
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been sent
    capture page screenshot
    reload page
    # The candidate gets the Offer link
    Check element display on screen     ${CONVERSATION_LINK_OFFER}
    # The candidate's status is [Send Offer]
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_STATUS_BUTTON}      Send Offer
    # The Offer's status in [Hire Detail] tab is updated
    Check element display on screen     ${CEM_OFFER_STATUS_UPDATED}     ${offer_name_1}


Verify the Offer version resends when the user edits and published the same offer after then resending the Offer (OL-T23769)
    [Documentation]     create AF with external job PAT068, using an offer can edit content
     # apply external job, Offer paradox, PAT068, offer edit content
    Given Setup test
    Login into system with company      ${CP_ADMIN}     ${COMPANY_LOCATION_MAPPING_OFF}
    ${candidate_name}=      Add a Candidate to job via CEM      job_req_id=${AUTOMATION_TESTER_REQ_ID_068}      is_spam_email=False
    # Send offer
    Send offer      ${candidate_name}       50      ${offer_name_2}
    reload page
    # cancel offer
    Cancel offer via Hire Details       ${offer_name_2}
    reload page
    # edit offer
    ${additional_date_name}=    Edit an offer by add a component    ${offer_name_2}
    # change candidate status ---> send offer
    Go to CEM page
    Search and click candidate on CEM       ${candidate_name}
    Updated conversation status     ${candidate_name}       Offer       Send Offer
    # The Offer detail shows with new version
    Check element display on screen     ${CONFIRM_OFFER_START_DATE}
    Check element display on screen     ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Check element display on screen     ${CONFIRM_OFFER_SELECT_PAY_RATE_DROPDOWN}
    Check text display      ${additional_date_name}
    Check element display on screen     ${CONFIRM_OFFER_SEND_BUTTON}
    capture page screenshot
    # delete component in offer
    reload page
    Navigate to offer page      ${offer_name_2}
    Click at    ${OFFER_QUILL_MENTION_HIGHLIGHT_VALUE}      job-name
    Delete a component      ${additional_date_name}


Verify the last version Offer the user changes the offer in a job after then resending the Offer (OL-T23770)
    [Documentation]     create AF with external job PAT067
    # pre-con: create 2 offer with name: Offer_for_AF_change_offer_1, Offer_for_AF_change_offer_2, create AF with name: AF_change_offer and using offer Offer_for_AF_change_offer_1
    # apply external job, Offer paradox.
    # Login with PARADOX_ADMIN role to edit Application Flow
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${candidate_name}=      Add candidate to job and switch user to Company Admin       ${AUTOMATION_TESTER_REQ_ID_067}
    # Send offer
    Send offer      ${candidate_name}       50      ${AF_change_offer_1}
    reload page
    Cancel offer via Hire Details       ${AF_change_offer_1}
    reload page
    Switch to user      ${TEAM_USER}
    # change offer Offer_OL-T23770_1 --> Offer_OL-T23770_2
    Go to Applicant Flows
    Search and click application flows      ${AF_change_offer}      Job Requisition Attributes      Job Req ID      Exactly matches     ${af_candidate_journey_name}    ${AUTOMATION_TESTER_REQ_ID_059}     ${af_conversation_name}     Paradox Offers      ${AF_change_offer_1}
    Change Offer in applicant flow      ${AF_change_offer_2}
    Go to CEM page
    Switch to user      ${CA_Team}
    Search and click candidate on CEM       ${candidate_name}
    # re-send offer 1.
    Updated conversation status     ${candidate_name}       Offer       Send Offer
    Fill all required fields in offer       50      per hour    ${AF_change_offer_1}
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    Check element display on screen     ${CONFIRM_OFFER_ERROR_TOASTED_MESSAGE}      This offer has been removed from the job . Please select another offer to resend.
    Click at    ${CONFIRM_OFFER_CLOSE_ICON}
    Click on span text      Discard
    # re-send offer 2.
    Send offer      ${candidate_name}       50      ${AF_change_offer_2}
    reload page
    Click on span text      Hire Details
    # check re-send offer successfully after change offer.
    Check element display on screen     ${CEM_OFFER_STATUS_CANCELED}    ${AF_change_offer_1}
    Check element display on screen     ${CEM_OFFER_STATUS_SENT}    ${AF_change_offer_2}
    # change offer Offer_for_AF_change_offer_2 --> Offer_for_AF_change_offer_1
    Switch to user      ${TEAM_USER}
    Go to Applicant Flows
    Search and click application flows      ${AF_change_offer}      Job Requisition Attributes      Job Req ID      Exactly matches     ${af_candidate_journey_name}    ${AUTOMATION_TESTER_REQ_ID_059}     ${af_conversation_name}     Paradox Offers      ${AF_change_offer_1}
    Change Offer in applicant flow      ${AF_change_offer_1}

*** Keywords ***
Apply job
    [Arguments]     ${job_name}     ${name}=None
    IF      '${name}'=='None'
        &{candidate_name}=    Generate candidate name
    END
    &{info}=    create dictionary
    ${link_job}=        Search job and get internal job link    ${job_name}
    &{email_info} =      Get email for testing     is_spam_email=False
    Go to    ${link_job}
    Input text for widget site      Hi
    Wait for Olivia reply on widget
    Check Message Widget Site Response Correct      ${REPROMPT_NAME_MESSAGE_8}
    Input text for widget site      ${candidate_name.full_name}
    Check Message Widget Site Response Correct      ${REPROMPT_EMAIL_MESSAGE_1}
    Input text for widget site      ${email_info.email}
    ${is_display}=      run keyword and return status       Check Message Widget Site Response Correct      ${REPROMPT_PHONE_MESSAGE_1}
    IF       '${is_display}'=='True'
        Input text for widget site      ${CONST_PHONE_NUMBER}
    END
    ${is_display}=      run keyword and return status       Check Message Widget Site Response Correct      ${EVENT_CONTACT_QUESTION}
    IF       '${is_display}'=='True'
        Click on option in conversation     Email
    END
    ${end_message}=     format string       ${THANKS_MESSAGE}       ${COMPANY_LOCATION_MAPPING_OFF}
    Check Message Widget Site Response Correct      ${end_message}
    ${info.link_job}=   set variable        ${link_job}
    ${info.candidate_name}=   set variable        ${candidate_name.full_name}
    ${info.candidate_first_name}=   set variable        ${candidate_name.first_name}
    [Return]       &{info}

Add candidate to job and switch user to Company Admin
    [Arguments]     ${job_id}
    ${info.candidate_name}=     Add a Candidate to job via CEM      job_req_id=${job_id}       is_spam_email=False
    Go to CEM page
    Switch to user      ${CA_Team}
    Search and click candidate on CEM       ${info.candidate_name}
    [Return]    ${info.candidate_name}

Check 2 new statuses appear & unlock
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS}       Offer Expired
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS}       Offer Canceled
    capture page screenshot

Verify can edit content message in Cancel Offer popup
    [Arguments]     ${candidate_first_name}
    check element display on screen     ${CEM_CANCEL_OFFER_POPUP_CONTENT_INPUT}
    capture page screenshot
    ${content_message}=     format string       ${confirm_cancel_offer_message}      ${candidate_first_name}        ${COMPANY_APPLICANT_FLOW}
    ${is_success}=      run keyword and return status       Input into      ${CEM_CANCEL_OFFER_POPUP_CONTENT_INPUT}     ${content_message}
    should be equal       '${is_success}'   'True'

Verify the Canceled Offer be recorded in the Offer History
    Check element display on screen     ${REVIEW_OFFER_HISTORY_OFFER_ICON}
    Check text display     Offer History
    Check element display on screen     ${REVIEW_OFFER_STATUS_CANCELED_ICON}
    Check text display      ${status_offer_canceled}
    Check element display on screen     ${REVIEW_OFFER_CANCEL_DATE_TIMESTAMP}
    capture page screenshot

Check UI an offer after click Cancel Offer button
    Textfield Value Should Be    ${CONFIRM_OFFER_START_DATE}    ${EMPTY}
    Textfield Value Should Be       ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}    ${EMPTY}
    Check element display on screen     ${CONFIRM_OFFER_SEND_BUTTON}
    capture page screenshot

Check UI of Confirm Cancel popup
    [Arguments]     ${candidate_fname}      ${company_name}
    Check text display      Cancellation message that ${candidate_fname} will recieve
    Check text display      Hi ${candidate_fname}, unfortunately your offer at ${company_name} has been canceled. We will reach out shortly with next steps.
    Check element display on screen     Confirm
    Check element display on screen     ${CEM_CONFIRM_CANCEL_OFFER_POPUP_BUTTON}     Confirm
    Check element display on screen     ${CEM_CONFIRM_CANCEL_OFFER_POPUP_BUTTON}        Nevermind
    Check element display on screen     ${CEM_CONFIRM_CANCEL_OFFER_POPUP_CLOSE_ICON}
    capture page screenshot

Check Candidate Journey status
    [Arguments]    ${candidate_name}    ${status}
    Click At    ${candidate_name}
    ${current_status} =     Get Text And Format Text    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Should Be Equal As Strings    ${status}     ${current_status}
    Capture Page Screenshot

Check UI Error page show when the candidate's status is Offer Canceled
    Check element display on screen     ${OFFER_ERROR_PAGE_HEADER_LOGO}
    Check element display on screen     ${OFFER_ERROR_PAGE_FILE_ICON}
    Check text display      Offer Canceled
    Check text display      Please reach out to your hiring manager for more information.

Re-send Offer via Hire Details
    [Arguments]    ${offer_name}
    Click At    ${CEM_OFFERS_ITEM}  ${offer_name}
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer

Re-send Offer via Candidate status dropdown
    [Arguments]    ${candidate_name}
    Change Conversation Action Status    ${candidate_name}  ${JOURNEY_OFFER_STATUS}     ${JOURNEY_SEND_OFFER_ACTION}    is_confirm=False
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer

Check status of offer displayed on Hire Details
    [Arguments]    ${offer_status}
    ${actual_status} =    Get Text And Format Text    ${HIRE_DETAILS_OFFER_STATUS}
    Should Be Equal As Strings    ${offer_status}    ${actual_status}
    Capture Page Screenshot

Updating an offer by editing content
    [Arguments]    ${content}
    Click At    ${OFFER_CONTENT_EDITOR}
    Press Keys    None  RETURN
    Input Text    ${OFFER_CONTENT_EDITOR}   ${content}      clear=False
    Click At    ${NEW_OFFER_CREATE_BUTTON}
    Click At    ${NEW_OFFER_PUBLISH_STATUS}
    Click At    ${NEW_OFFER_PUBLISH_BUTTON}
    Click At    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}

Edit an offer by add a component
    [Arguments]     ${offer_name}
    Navigate to offer page      ${offer_name}
    wait for page load successfully v1
    Click at    ${OFFER_CONTENT_EDITOR}
    Click at    ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Date
    ${additional_date_name}=    Setting data for Add Additional Date component      Date (MM/DD/YYYY)    add_field_mapping=Offer Created Date
    Click At    ${NEW_OFFER_CREATE_BUTTON}
    Click At    ${NEW_OFFER_PUBLISH_STATUS}
    Click At    ${NEW_OFFER_PUBLISH_BUTTON}
    Click At    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    Check element display on screen         ${NEW_OFFER_COMPONENT_LABEL}     ${additional_date_name}
    capture page screenshot
    [Return]    ${additional_date_name}

Cancel offer via Hire Details
    [Arguments]         ${offer_name}
    Click on span text      Hire Details
    Click at        ${CEM_OFFERS_ITEM}      ${offer_name}
    Click at    ${CONFIRM_OFFER_CANCEL_BUTTON}
    Click at    ${CEM_CONFIRM_CANCEL_OFFER_POPUP_BUTTON}     Confirm
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}      Your offer has been canceled
    capture page screenshot
