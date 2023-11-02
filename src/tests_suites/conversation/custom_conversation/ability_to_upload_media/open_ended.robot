*** Settings ***
Resource            ./upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    unilever    darden    test

*** Test Cases ***
Check validate 'Add new content' drawer when select media type is hyperlink in case input into 'Name your content' field (OL-T21946, OL-T21969, OL-T21945, OL-T21964, OL-T21965, OL-T21955, OL-T21941, OL-T21944, OL-T21942, OL-T21940)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check Content Name filed input for Hyperlink type
    Open Add New Media dialog with Media type   Open-Ended    Hyperlink
    Check Content Name filed input action   Hyperlink   ${EMPTY}
    Check Content Name filed input action   Hyperlink   ${text_with_more_than_40_characters}
    # Check Content Name filed input for Image/GIF type
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Image/GIF
    # Check design of Image/GIF tab
    Check design of 'Add New Media' dialog    Image/GIF
    Check Content Name filed input action   Image/GIF    ${EMPTY}
    Check Content Name filed input action   Image/GIF   ${text_with_more_than_40_characters}
    # Check Content Name filed input for Video type
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Video
    # Check design of Video tab
    Check design of 'Add New Media' dialog    Video
    Check Content Name filed input action   Video    ${EMPTY}
    Check Content Name filed input action   Video   ${text_with_more_than_40_characters}
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder


Check validate 'Add new media' drawer when select media type is video in case input more than 120 character into 'Add Alt Text' filed (OL-T21947)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check display of Add Alt Text (optional) when input more than 120 characters    Open-Ended    Video


Check validate 'Add new content' drawer when in case input incorrect format into 'URL' field (OL-T21970, OL-T21971, OL-T21966, OL-T21967, OL-T21943, OL-T21982, OL-T21986)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check URL error message for Hyperlink type
    Open Add New Media dialog with Media type   Open-Ended   Hyperlink
    # Check design of Hyperlink tab
    Check design of 'Add New Media' dialog   Hyperlink
    Check URL field error message   Hyperlink    this_is_not_a_link
    Clear element text with keys  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}
    Check URL field error message   Hyperlink    ${EMPTY}
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_BACK_BUTTON}
    # Check URL error message for Image/GIF type
    Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_NEW_MEDIA_BUTTON}
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Image/GIF
    Check URL field error message   Image/GIF    this_is_not_a_link
    Check URL field error message   Image/GIF    this_is_not_a_link     optional_url=True
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder


Change hyperlink for question type is 'Open-Ended' (OL-T22001, OL-T21968, OL-T22000, OL-T21963, OL-T21999, OL-T21953)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Change Conversation question's Media to expected Media     Open-Ended


Check Upload media successfully when input valid value into all field (OL-T21954)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check upload successfully when input valid into all fields   Open-Ended     Video


Edit video (OL-T22005)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed      Open-Ended     Video


Edit image (OL-T22006)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed      Open-Ended     Image/GIF


Edit hyperlink (OL-T22007)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed      Open-Ended     Hyperlink


Check upload Media on 'Add new content' drawer when upload invalid Media (OL-T21958, OL-T21951, OL-T21959)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Open-Ended    Image/GIF
    # Upload Image not .jpg and .png
    Add New Media to a Question     Image/GIF   ${custom_conv_image_webp_file_name}
    Check upload media unsuccessfully when input invalid value into required field   ${custom_conv_image_webp_file_name}
    # Upload Image more than 5MB
    Add New Media to a Question     Image/GIF   ${custom_conv_image_over_5mb_file_name}
    Check upload media unsuccessfully when input invalid value into required field   ${custom_conv_image_over_5mb_file_name}
    # Upload Video more than 100MB
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Video
    Add New Media to a Question     Video   ${custom_conv_video_over_100mb_file_name}
    Check upload media unsuccessfully when input invalid value into required field   ${custom_conv_video_over_100mb_file_name}
    #   Cleaning and finish
    Close Add New Media dialog
    delete conversation in builder


Check Upload Media successfully when Upload valid Media type (OL-T21962, OL-T21960, OL-T21961, OL-T21952)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    Open-Ended
    Additional step for each question type   Open-Ended
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_gif_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    # Check upload success when upload image with JPG type
    ${media_content_title_2} =    Add a New media for testing     Image/GIF   ${custom_conv_image_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_2}
    Capture page screenshot
    Remove media    ${media_content_title_2}
    # Check upload success when upload image with PNG type
    ${media_content_title_3} =    Add a New media for testing     Image/GIF   ${custom_conv_image_png_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_3}
    Capture page screenshot
    Remove media    ${media_content_title_3}
    # Check upload success when upload Video with MP4 type
    ${media_content_title_4} =    Add a New media for testing     Video   ${custom_conv_video_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_4}
    Capture page screenshot
    Remove media    ${media_content_title_4}
    # Check upload success when upload Hyperlink
    ${media_content_title_5} =    Add a New media for testing     Hyperlink   ${custom_conv_hyperlink}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_5}
    Capture page screenshot
    Remove media    ${media_content_title_5}
    #   Check design of 'Add Media' drawer
    Check design of 'Add Media' dialog
    @{delete_test_media} =  Create List     ${media_content_title_1}    ${media_content_title_2}    ${media_content_title_3}    ${media_content_title_4}    ${media_content_title_5}
    # Delete test data
    Delete created custom conversation and added media  ${delete_test_media}


Verify add hyperlink, image, video successfully (OL-T21985, OL-T21984, OL-T21983, OL-T21997, OL-T21995, OL-T21993, OL-T21991, OL-T21990, OL-T21992)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    Yes/No    Hyperlink
    Remove media    ${hyperlink_media_title}
    Add an exist media     Hyperlink    ${hyperlink_media_title}
    Remove media    ${hyperlink_media_title}
    #   Verify can add uploaded Video Media
    ${video_media_title} =    Add a New media for testing     Video
    Remove media    ${video_media_title}
    Add an exist media         Video    ${video_media_title}
    Remove media    ${video_media_title}
    #   Verify can add uploaded Image Media
    ${image_media_title} =    Add a New media for testing     Image/GIF
    Remove media    ${image_media_title}
    Add an exist media         Image/GIF    ${image_media_title}
    Remove media    ${image_media_title}
    #   Cleaning data
    @{delete_test_media} =  Create List     ${hyperlink_media_title}    ${video_media_title}    ${image_media_title}
    Delete created custom conversation and added media    ${delete_test_media}


Verify display video for question type is 'Open-Ended' when candidate apply custom conversation (OL-T22017, OL-T22029)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Open-Ended     Video
    ${landing_site_name} =   Check Media is correct in Conversation      Open-Ended    Video    Landing Site    ${media_content_title}    conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}


Verify search hyperlinks,image, video successfully (OL-T21981, OL-T21980, OL-T21979)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Search Media ability of Hyperlink, Image, Video in Conversation    Open-Ended


Verify delete Media successfully for question type is 'Open-Ended' when clicking on 'Remove media' option (OL-T21998, OL-T21994, OL-T21996)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    Open-Ended    Hyperlink
    Remove Media in Eclipse menu    ${custom_conv_question_name}
    Add an exist media     Hyperlink    ${hyperlink_media_title}
    Remove Media in Eclipse menu    ${custom_conv_question_name}
    #   Verify can add uploaded Video Media
    ${video_media_title} =    Add a New media for testing     Video
    Remove Media in Eclipse menu    ${custom_conv_question_name}
    Add an exist media         Video    ${video_media_title}
    Remove Media in Eclipse menu    ${custom_conv_question_name}
    #   Verify can add uploaded Image Media
    ${image_media_title} =    Add a New media for testing     Image/GIF
    Remove Media in Eclipse menu    ${custom_conv_question_name}
    Add an exist media         Image/GIF    ${image_media_title}
    Remove Media in Eclipse menu    ${custom_conv_question_name}
    #   Cleaning data
    @{delete_test_media} =  Create List     ${hyperlink_media_title}    ${video_media_title}    ${image_media_title}
    Delete created custom conversation and added media    ${delete_test_media}


Verify clear data when moving to another tab (OL-T21977, OL-T21976, OL-T21974, OL-T21973, OL-T21975, OL-T21972)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Open-Ended
    Check clear date when navigate to other tab     Video   Image/GIF
    Check clear date when navigate to other tab     Video   Hyperlink
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Hyperlink
    Check clear date when navigate to other tab     Hyperlink   Video
    Check clear date when navigate to other tab     Hyperlink   Image/GIF
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Image/GIF
    Check clear date when navigate to other tab     Image/GIF   Video
    Check clear date when navigate to other tab     Image/GIF   Hyperlink
    #   Cleaning data
    Close Add New Media dialog
    Delete conversation in builder


Verify media uploaded are not removed when change to question type is 'Open-Ended' (OL-T22002, OL-T22004, OL-T22003)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Media type not remove when change Question type     Yes/No     Open-Ended


Verify display video for question type is 'Open-Ended' when candidate apply custom conversation in case video is marked required (OL-T22021, OL-T22022, OL-T22018)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Open-Ended     Video      required_media=Yes
    ${landing_site_name} =   Check Media is correct in Conversation  Open-Ended    Video    Landing Site     ${media_content_title}     required_media=True    conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}


Verify display hyperlink for question type is 'Open-Ended' when candidate apply custom conversation (OL-T22032)
    [Tags]    skip
    #   Need to run widget conversation through Git repo URL instead of Sale demo page
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Open-Ended     Hyperlink
    ${landing_site_name} =   Check Media is correct in Conversation    Open-Ended    Hyperlink    Widget Conversation    ${media_content_title}     conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}

*** Keywords ***
