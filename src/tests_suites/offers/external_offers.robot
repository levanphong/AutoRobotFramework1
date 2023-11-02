*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Variables           ../../constants/CandidateJourneyConst.py
Variables           ../../locators/applicant_flows_locators.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg

Documentation       Run data test on /src/data_tests/offers/offer_data_tests.robot

*** Variables ***
${test_location_name}       ${CONST_LOCATION}
${cj_name}                  CJ_Send Offer To Candidate
${wf_name}                  WF_Send Offer To Candidate
${job_name}                 Job for Send Offer To Candidate
${af_name}                  AF_Send Offer To Candidate
${job_requition_id}         PAT047
${job_requition_name}       Automation Tester 047

*** Test Cases ***
Check Configure offer for Applicant Flow if the External Offer toggle is ON (OL-T9788)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Applicant Flows
    Input into      ${APPLICANT_FLOWS_SEARCH_AF}    ${af_name}
    Click at        ${af_name}
    Click at        ${APPLICANT_FLOWS_CJ_TAB}
    Click at        ${APPLICANT_FLOWS_STAGE}    Send Offer
    Click at        ${APPLICANT_FLOWS_ELIPSIS_BUTTON}   Default Offer
    Click at        ${APPLICANT_FLOWS_EDIT_STAGE_BUTTON}
    Check element display on screen     Select Offer Type
    Click at        ${APPLICANT_FLOWS_SELECT_OFFER_TYPE}
    Check element display on screen     ${APPLICANT_FLOWS_MATCHES_ITEM}     Paradox Offers
    Check element display on screen     ${APPLICANT_FLOWS_MATCHES_ITEM}     External Offer Upload
    capture page screenshot
    Click at    ${APPLICANT_FLOWS_MATCHES_ITEM}     Paradox Offers
    Check element display on screen     ${APPLICANT_FLOWS_SELECT_OFFER}
    capture page screenshot
    Click at        ${APPLICANT_FLOWS_SELECT_OFFER_TYPE}
    Click at    ${APPLICANT_FLOWS_MATCHES_ITEM}     External Offer Upload
    ${actual_text} =    Get text and format text    ${APPLICANT_FLOWS_EXTERNAL_OFFER_TEXT}
    should be equal as strings      ${actual_text}     Users will be able to upload the offer from an external source at time of offering.
    capture page screenshot


Check sending offer at the CEM page with external offer upload (OL-T9780)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${candidate_info.first_name}=    Send external offers to candidate
    Go to CEM page
    Switch to user    ${CA_TEAM}
    Search and click candidate on CEM   ${candidate_info.first_name}
    Change conversation status    ${candidate_info.first_name}    Offer    Send Offer
    Click at    Send offer
    Check element display on screen     Must upload an offer
    Upload external offer file    cat-kute
    Check element display on screen     ${CONFIRM_OFFER_FILE_UPLOADED_NAME}     cat-kute
    Click at    Send offer
    Verify user has received the email      Respond to your job offer at ${COMPANY_APPLICANT_FLOW}    ${candidate_info.first_name}   OFFER


Check cadidate accept offer with external offer for applicant flow (OL-T9781, OL-T9789)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${candidate_info.first_name}=    Send external offers to candidate
    Go to CEM page
    Switch to user    ${CA_TEAM}
    Search and click candidate on CEM   ${candidate_info.first_name}
    Change conversation status    ${candidate_info.first_name}    Offer    Send Offer
    Click at    Send offer
    Check element display on screen     Must upload an offer
    Upload external offer file    cat-kute
    Check element display on screen     ${CONFIRM_OFFER_FILE_UPLOADED_NAME}     cat-kute
    Click at    Send offer
    Click button in email   Respond to your job offer at ${COMPANY_APPLICANT_FLOW}     ${candidate_info.first_name}   OFFER
    Enter code for verify code step   ${candidate_info.first_name}
    # Check cadidate accept offer with external offer (OL-T9781)
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    Check p text display    Your offer has been accepted. We will reach out with next steps soon.
    Go to CEM page
    Search and click candidate on CEM   ${candidate_info.first_name}
    Click at    cat-kute.jpg
    Check element display on screen     ${CONFIRM_OFFER_ACCEPT_ICON}
    capture page screenshot


External Offer - Send offer to candidate. Candidate accept & decline offer (OL-T9782, OL-T9790)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${candidate_info.first_name}=    Send external offers to candidate
    Go to CEM page
    Switch to user    ${CA_TEAM}
    Search and click candidate on CEM   ${candidate_info.first_name}
    Change conversation status    ${candidate_info.first_name}    Offer    Send Offer
    Click at    Send offer
    Check element display on screen     Must upload an offer
    Upload external offer file    cat-kute
    Check element display on screen     ${CONFIRM_OFFER_FILE_UPLOADED_NAME}     cat-kute
    Click at    Send offer
    Click button in email   Respond to your job offer at ${COMPANY_APPLICANT_FLOW}     ${candidate_info.first_name}   OFFER
    Enter code for verify code step   ${candidate_info.first_name}
    # Check cadidate do not accept offer with external offer (OL-T9782)
    Click at  ${ACTION_IN_OFFER_DO_NOT_ACCEPT_BUTTON}
    Check p text display    Your response to this offer has been recorded. We will reach out with next steps soon.
    Go to CEM page
    Search and click candidate on CEM   ${candidate_info.first_name}
    Click at    cat-kute.jpg
    Check element display on screen     ${CONFIRM_OFFER_DECLINED_ICON}
    capture page screenshot

*** Keywords ***
Send external offers to candidate
    ${url_site}=    get landing site url by string concatenation    COMPANY_APPLICANT_FLOW     ${EMPTY}
    Go to    ${url_site}
    #    Apply job via company site
    Verify Olivia conversation message display    ${GREAT_TAKE_A_LOOK_AT_THE}
    Input text and send message     ${job_requition_id}
    Click at  ${CONVERSATION_LIST_VIEW_ITEM}    ${job_requition_name}
    Click at  ${CONVERSATION_APPLY_NOW_BUTTON}
    ${verify_message} =     Format String   ${OLIVIA_JOB_ASSISTANT}     ${COMPANY_APPLICANT_FLOW}
    Verify Olivia conversation message display  ${verify_message}
    Input text and send message    Hello
    Verify Olivia conversation message display      ${REPROMPT_NAME_MESSAGE_8}
    ${candidate_info} =      Generate candidate name
    Input text and send message    ${candidate_info.full_name}
    Verify Olivia conversation message display    ${REPROMPT_EMAIL_MESSAGE_1}
    &{email_info} =    Get email for testing    is_spam_email=False
    Input text and send message   ${email_info.email}
    ${verify_message} =     Format String   ${THANKS_MESSAGE}     ${COMPANY_APPLICANT_FLOW}
    Verify Olivia conversation message display  ${verify_message}
    capture page screenshot
    [Return]    ${candidate_info.first_name}

Upload external offer file
    [Arguments]     ${image_file}
    ${path_image} =    get_path_upload_image_path    ${image_file}
    ${element} =    Get Webelement    ${CONFIRM_OFFER_INPUT_FILE}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style', '');
    ...    ARGUMENTS    ${element}
    Input into    ${CONFIRM_OFFER_INPUT_FILE}    ${path_image}
