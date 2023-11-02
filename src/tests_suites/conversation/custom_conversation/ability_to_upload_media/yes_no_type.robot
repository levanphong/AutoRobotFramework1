*** Settings ***
Resource            ./upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    unilever    darden    test

*** Test Cases ***
Change hyperlink for question type is 'Yes/No' (OL-T22101, OL-T22068, OL-T22100, OL-T22063, OL-T22099, OL-T22053)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Change Conversation question's Media to expected Media     Yes/No


Check Upload media successfully when input valid value into all field (OL-T22054)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check upload successfully when input valid into all fields   Yes/No     Video


Check validate 'Add new content' drawer when in case input incorrect format into 'URL' field (OL-T22067, OL-T22066, OL-T22071, OL-T22070, OL-T22043, OL-T22086)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check URL error message for Hyperlink type
    Open Add New Media dialog with Media type   Yes/No   Hyperlink
    # Check design of Hyperlink tab
    Check design of 'Add New Media' dialog   Hyperlink
    Check URL field error message   Hyperlink    this_is_not_a_link
    Clear element text with keys  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}
    Check URL field error message   Hyperlink    ${EMPTY}
    # Check URL error message for Image/GIF type
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Image/GIF
    Check URL field error message   Image/GIF    this_is_not_a_link
    Check URL field error message   Image/GIF    this_is_not_a_link     optional_url=True
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder


Check validate 'Add new content' drawer when select media type is hyperlink in case input into 'Name your content' field (OL-T22065, OL-T22064, OL-T22055, OL-T22045, OL-T22069, OL-T22046, OL-T22041, OL-T22042)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check Content Name filed input for Hyperlink type
    Open Add New Media dialog with Media type   Yes/No    Hyperlink
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


Check validate 'Add new media' drawer when select media type is video in case input more than 120 character into 'Add Alt Text' filed (OL-T22047)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check display of Add Alt Text (optional) when input more than 120 characters   Yes/No    Video


Edit hyperlink (OL-T22107)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   Yes/No    Hyperlink


Edit video (OL-T22105)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   Yes/No    Video


Edit image (OL-T22106)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   Yes/No    Image/GIF


Verify display video for question type is 'Yes/No' when candidate apply custom conversation in case video is marked required (OL-T22121, OL-T22122, OL-T22118, OL-T22131, OL-T22130)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Yes/No     Video
    ${landing_site_name} =   Check Media is correct in Conversation  Yes/No    Video    Landing Site     ${media_content_title}    conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}


Verify media uploaded are not removed when change to question type is 'Yes/No' (OL-T22104, OL-T22040, OL-T22103, OL-T22102)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Media type not remove when change Question type   Email     Yes/No


Verify search hyperlinks,image, video successfully (OL-T22081, OL-T22080, OL-T22079)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Search Media ability of Hyperlink, Image, Video in Conversation    Yes/No


Check upload Media on 'Add new content' drawer when upload invalid Media (OL-T22058, OL-T22059, OL-T22052, OL-T22051)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Yes/No    Image/GIF
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


Check Upload Media successfully when Upload valid Media type (OL-T22062, OL-T22060, OL-T22061, OL-T22078)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    Yes/No
    Additional step for each question type   Yes/No
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
    #   Check design of 'Add Media' drawer
    Check design of 'Add Media' dialog
    @{delete_test_media} =  Create List     ${media_content_title_1}    ${media_content_title_2}    ${media_content_title_3}
    # Delete test data
    Delete created custom conversation and added media  ${delete_test_media}


Verify 'Add Media' drawer is closed when clicking on 'Cancel' button (OL-T22082)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add Media dialog   Yes/No
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}
    Capture page screenshot
    #   Cleaning data
    Delete conversation in builder


Verify 'Add new media' drawer closed when clicking on 'Cancel' button (OL-T22044)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Yes/No
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    # Check Create button not display to Verify `Add new media` dialog closed
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    Capture page screenshot
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder


Verify add hyperlink, image, video successfully (OL-T22085, OL-T22083, OL-T22084, OL-T22092, OL-T22091, OL-T22090, OL-T22097, OL-T22095, OL-T22093)
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


Verify clear data when moving to another tab (OL-T22077, OL-T22076, OL-T22074, OL-T22073, OL-T22075, OL-T22072)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Yes/No
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


Verify delete Media successfully for question type is 'Yes/No' when clicking on 'Remove media' option (OL-T22098, OL-T22096, OL-T22094)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    Yes/No    Hyperlink
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


Verify 'Edit Reprompt Message' dialog (OL-T22111, OL-T22114, OL-T22112, OL-T22110, OL-T22109, OL-T22115, OL-T22113, OL-T22116, OL-T22108)
    # Marked required doesn't need anymore following comment below
    # https://paradoxai.atlassian.net/browse/OL-60795?focusedCommentId=300159
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${media_title} =     Create new custom conversation and then add new media   Yes/No    Video
    Verify test cases related to 'Edit Reprompt Message' dialog    ${media_title}


Verify display hyperlink for question type is 'Yes/No' when candidate apply custom conversation (OL-T22133)
    [Tags]    skip
    #   Need to run widget conversation through Git repo URL instead of Sale demo page
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Yes/No     Hyperlink
    ${landing_site_name} =   Check Media is correct in Conversation    Yes/No    Hyperlink    Widget Conversation    ${media_content_title}     conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}

*** Keywords ***
