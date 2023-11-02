*** Settings ***
Resource            ./upload_media.resource
Resource            ../../../../pages/conversation_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    stg_mchire    unilever    test

*** Variables ***
${image_content_title}              Image_content_title
${hyperlink_content_title}          Hyperlink_content_title
${video_content_title}              Video_content_title
${landing_site_hyperlink}           LandingSiteHyperlinkMedia
${landing_site_image}               LandingSiteImageMedia
${landing_site_video}               LandingSiteVideoMedia
${landing_site_url_hyperlink}       /${landing_site_hyperlink}
${landing_site_url_image}           /${landing_site_image}
${landing_site_url_video}           /${landing_site_video}

*** Test Cases ***
Verify display hyperlink for question type is 'Document Upload' when candidate apply custom conversation (OL-T21618, OL-T21416, OL-T21213, OL-T21317, OL-T22024, OL-T22124, OL-T21515, OL-T22226, OL-T21112)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    ${franchise_on_site} =   Get landing site url by string concatenation  COMPANY_FRANCHISE_ON   ${landing_site_hyperlink}
    Go to   ${franchise_on_site}
    Check Media type is Hyperlink for Landing Site      ${hyperlink_content_title}


Verify display image for question type is 'Document Upload' when candidate apply custom conversation (OL-T21617, OL-T21626, OL-T21415, OL-T21423, OL-T21212, OL-T21220, OL-T21316, OL-T21325, OL-T22023, OL-T22031, OL-T22123, OL-T22132, OL-L21718, OL-T21726, OL-T21514, OL-T22225, OL-T21111)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    ${franchise_on_site} =    Get landing site url by string concatenation  COMPANY_FRANCHISE_ON   ${landing_site_image}
    Go to   ${franchise_on_site}
    Check Media type is Image for Landing Site      ${image_content_title}


Verify display video for question type is 'Document Upload' when candidate apply custom conversation via landing site. (OL-T21613, OL-T21614, OL-T21622, OL-T21623, OL-T22020, OL-T22028, OL-T22030, OL-T22018, OL-T22025, OL-T22125, OL-T22120, OL-T22134, OL-T22129, OL-T21409, OL-T21418, OL-T21417, OL-T21412, OL-T21420, OL-T21410, OL-T21209, OL-T21217, OL-T21206, OL-T21214, OL-T21310, OL-T21309, OL-T21319, OL-T21321, OL-T21318, OL-T21715, OL-T21723, OL-T21712, OL-T21720, OL-T22220, OL-T22228, OL-T22222, OL-T22230, OL-T22219, OL-T22223, OL-T21511, OL-T21518, OL-T21509, OL-T21516, OL-T21108, OL-T21116, OL-T21106, OL-T21114, OL-T21105)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    ${franchise_on_site} =    Get landing site url by string concatenation  COMPANY_FRANCHISE_ON   ${landing_site_video}
    Go to   ${franchise_on_site}
    Check Media type is Video for Landing Site      ${video_content_title}

*** Keywords ***
Check Media type is Image for Landing Site
    [Arguments]    ${media_content_title}
    Click at    ${CONVERSATION_ASSIST_BLOCK}    ${media_content_title}
    # Verify is correct image
    Check element display on screen     ${CONVERSATION_ASSIST_BLOCK_IMG}
    Verify attribute should contain     src     ${custom_conv_image_file_name}     ${CONVERSATION_ASSIST_BLOCK_IMG}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_open_ended
    Candidate input to landing site     Full name
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_full_name
    ${candidate_info}=        Generate candidate name
    Candidate input to landing site     ${candidate_info.full_name}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_email
    &{email_info} =    Get email for testing
    Candidate input to landing site     ${email_info.email}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_yes_no
    Candidate input to landing site     Yes
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_list_select
    Click at    ${AGREE_BUTTON}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_document_upload
    Click at    ${UPDATE_LATER_SPAN}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_phone_number
    Candidate input to landing site     ${CONST_PHONE_NUMBER}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_address
    Candidate input to landing site     ${FULL_ADDRESS}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_area_of_interest
    Candidate input to landing site     1
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${image_content_title}_location_select
    Candidate input to landing site     1

Check Media type is Hyperlink for Landing Site
    [Arguments]    ${media_content_title}
    Click at    ${CONVERSATION_ASSIST_BLOCK}    ${media_content_title}
    # Verify Hyperlink go to correct page
    Switch window      Paradox: The AI assistant for recruiting, Olivia
    ${verify_url} =    Get location
    Should be equal as strings  ${verify_url}  ${custom_conv_hyperlink}
    Switch window      Messenger | Test Automation Franchise On
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_open_ended
    Candidate input to landing site     Full name
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_full_name
    ${candidate_info}=        Generate candidate name
    Candidate input to landing site     ${candidate_info.full_name}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_email
    &{email_info} =    Get email for testing
    Candidate input to landing site     ${email_info.email}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_yes_no
    Candidate input to landing site     Yes
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_list_select
    Click at    ${AGREE_BUTTON}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_document_upload
    Click at    ${UPDATE_LATER_SPAN}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_phone_number
    Candidate input to landing site     ${CONST_PHONE_NUMBER}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_address
    Candidate input to landing site     ${FULL_ADDRESS}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_area_of_interest
    Candidate input to landing site     1
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${hyperlink_content_title}_location_select
    Candidate input to landing site     1

Check Media type is Video for Landing Site
    [Arguments]    ${media_content_title}    ${required_media}=None
    Click by JS    ${CONVERSATION_ASSIST_BLOCK_VIDEO}
    # Verify Video player is correct
    Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
    Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_SOUND_BUTTON}
    Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_FULL_SCREEN_BUTTON}
    Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}
    Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_DURATION_TIME_TEXT}
    Additional step for each question type in conversation      Open-Ended
    IF  '${required_media}' == 'None'
            Play/pause video  Pause
            Element Should be Enabled   ${CONVERSATION_INPUT_TEXTBOX}
            Element Should be Enabled  ${CONVERSATION_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
            # Extra test for combine test cases
            Click at  ${CONVERSATION_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
            Check element not display on screen  ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
            Capture page screenshot
    ELSE
        Element Should Be Enabled   ${CONVERSATION_INPUT_TEXTBOX}
        Element Should Be Disabled   ${CONVERSATION_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
        # Extra test for combine test cases
        # Wait until end of video in 5s
        Play/pause video  Play
        Wait Until Element Is Enabled   ${CONVERSATION_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
        Verify display text  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}  00:05
        Capture page screenshot
    END
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_full_name
    ${candidate_info}=        Generate candidate name
    Candidate input to landing site     ${candidate_info.full_name}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_email
    &{email_info} =    Get email for testing
    Candidate input to landing site     ${email_info.email}
    check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_yes_no
    Candidate input to landing site     Yes
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_list_select
    Click at    ${AGREE_BUTTON}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_document_upload
    Click at    ${UPDATE_LATER_SPAN}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_phone_number
    Candidate input to landing site     ${CONST_PHONE_NUMBER}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_address
    Candidate input to landing site     ${FULL_ADDRESS}
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_area_of_interest
    Candidate input to landing site     1
    Check element display on screen     ${QUESTION_TYPE_CONTENT_TITLE}      ${video_content_title}_location_select
    Candidate input to landing site     1

