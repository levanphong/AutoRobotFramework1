*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg

Documentation       Run data test on /src/data_tests/offers/offer_data_tests.robot

*** Variables ***
${test_location_name}           ${CONST_LOCATION}
${cj_name}                      CJ_Send Offer To Candidate
${wf_name}                      WF_Send Offer To Candidate
${offer_name}                   OF_Send Offer To Candidate
${job_name}                     Job for Send Offer To Candidate
${download_success_message}     Offer downloaded

*** Test Cases ***
Check candidate can download the offer when the offer hasn't accepted/declined (OL-T28933, OL-T28894, OL-T9777)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    # Check sending offer at the CEM page if only one offer seleted at Candiate journey section of the jobs page (OL-T9777)
    Change conversation status to send offer    ${candidate_name}   ${JOURNEY_OFFER_STATUS}
    Verify user has received the email      Respond to your job offer at ${COMPANY_FRANCHISE_ON}    ${candidate_name}   OFFER
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name}
    # Check can download the offer (OL-T28894)
    Check element display on screen     ${OFFER_DOWNLOAD_ICON}
    Click at    ${OFFER_DOWNLOAD_ICON}
    wait with short time
    ${success_message} =    Get text and format text   ${OFFER_DOWNLOAD_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${download_success_message}
    capture page screenshot


Check Candidate can download the offer when the offer has been accepted (OL-T28934, OL-T9114)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create new offer with Document compoment
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    # Check if candidate accept the offer (OL-T9114)
    Send Offer and input verify code    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}
    Capture page screenshot
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    Check required view document displayed      cat-kute
    View document required      cat-kute
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name}
    Check element display on screen     ${OFFER_DOWNLOAD_ICON}
    Click at    ${OFFER_DOWNLOAD_ICON}
    wait with short time
    ${success_message} =    Get text and format text   ${OFFER_DOWNLOAD_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${download_success_message}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}


Check Candidate can download the offer when the offer has been declined (OL-T28936, OL-T9113)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    # Check if user do not accept the offer (OL-T9113)
    Send Offer and input verify code    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}
    Capture page screenshot
    Click at  ${ACTION_IN_OFFER_DO_NOT_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name}
    Check element display on screen     ${OFFER_DOWNLOAD_ICON}
    Click at    ${OFFER_DOWNLOAD_ICON}
    wait with short time
    ${success_message} =    Get text and format text   ${OFFER_DOWNLOAD_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${download_success_message}
    capture page screenshot


Paradox offer_Check resend offer from Hire details (OL-T20613)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Send Offer and input verify code    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}
    capture page screenshot
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    # Check resend offers
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name}
    Update content offer and resend offer
    # Check receive offer mail
    Verify user has received the email      Respond to your job offer at ${COMPANY_FRANCHISE_ON}    ${candidate_name}   OFFER


Check sending offer at the CEM page if the more than one offer seleted at Candiate journey section of the jobs page (OL-T9778, OL-T12528)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name_1} =    Create a new offer not contain start date and pay rate
    ${offer_name_2} =    Create a new offer
    # Set up 2 offer in CJ
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name_1}
    Add more offer for job  ${offer_name_2}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Change conversation status    ${candidate_name}    ${JOURNEY_OFFER_STATUS}    ${JOURNEY_SEND_OFFER_ACTION}
    Check element display on screen     ${CONFIRM_OFFER_SELECT_OFFER_DROPDOWN}
    Click at     ${CONFIRM_OFFER_SELECT_OFFER_DROPDOWN}
    Check element display on screen     ${CONFIRM_OFFER_SELECT_OFFER_OPTION}    ${offer_name_1}
    Check element display on screen     ${CONFIRM_OFFER_SELECT_OFFER_OPTION}    ${offer_name_2}
    # Check user can send an offer without start date and pay rate values (OL-T12528)
    Click at     ${CONFIRM_OFFER_SELECT_OFFER_OPTION}    ${offer_name_1}
    Click at    Send offer
    Verify user has received the email      Respond to your job offer at ${COMPANY_FRANCHISE_ON}    ${candidate_name}   OFFER
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name_1}
    Delete a offer  ${offer_name_2}

*** Keywords ***
Create new offer with Document compoment
    ${offer_name} =    Generate random name    auto_offer
    Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_NAME_TEXT_BOX}
    Press Keys    None    ${offer_name}
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Document
    ${document_name}=   Setting data for Add Document component     cat-kute
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Check UI of Publish Offer confirmation modal
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    [Return]    ${offer_name}

Check required view document displayed
    [Arguments]     ${document_item}
    Check common text last display      Please review all required document!
    Check element display on screen      ${OFFER_VIEW_ICON}      ${document_item}
    Check span display      1 required item above
    capture page screenshot

View document required
    [Arguments]     ${document_item}
    Click at      ${OFFER_VIEW_ICON}      ${document_item}
    @{window} =    get window handles
    switch window    ${window}[0]
    Check element display on screen     ${OFFER_CHECK_ICON}     ${document_item}
    capture page screenshot
