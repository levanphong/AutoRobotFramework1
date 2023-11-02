*** Settings ***
Resource            ./upload_media.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    unilever    darden    test

*** Test Cases ***
Change hyperlink for question type is 'List Select' (OL-T21293, OL-T21292, OL-T21291)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Change Conversation question's Media to expected Media    List Select


Check upload Media on 'Add new content' drawer when upload invalid Media (OL-T21247, OL-T21248, OL-T21240)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   List Select    Image/GIF
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


Check Upload Media successfully when Upload valid Media type (OL-T21241, OL-T21257, OL-T21283, OL-T21251, OL-T21249, OL-T21250, OL-T21242, OL-T21267, OL-T21281, OL-T21279)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    List Select
    Additional step for each question type   List Select
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


Check Upload image successfully when input valid value into all field (OL-T21252)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check upload successfully when input valid into all fields      List Select     Image/GIF


Check Upload video successfully when input valid value into all field (OL-T21243)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check upload successfully when input valid into all fields      List Select     Video


Check validate 'Add new content' drawer when in case input incorrect format into 'URL' field (OL-T21256, OL-T21255, OL-T21260, OL-T21259, OL-T21232, OL-T21275)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check URL error message for Hyperlink type
    Open Add New Media dialog with Media type   List Select   Hyperlink
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


Check validate 'Add new content' drawer when select media type is hyperlink in case input into 'Name your content' field (OL-T21253, OL-T21244, OL-T21234, OL-T21254, OL-T21258, OL-T21235, OL-T21231, OL-T21230)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check Content Name filed input for Hyperlink type
    Open Add New Media dialog with Media type   List Select    Hyperlink
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


Edit hyperlink (OL-T21299)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed      List Select     Hyperlink


Edit image (OL-T21298)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed      List Select     Image/GIF


Edit video (OL-T21297)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed      List Select     Video


Check validate 'Add new media' drawer when select media type is video in case input more than 120 character into 'Add Alt Text' filed (OL-T21236)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check display of Add Alt Text (optional) when input more than 120 characters    List Select     Video


Verify add hyperlink, image, video successfully (OL-T21274, OL-T21273, OL-T21272, OL-T21289, OL-T21285, OL-T21287)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    List Select    Hyperlink
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
    #   Cleaning data
    @{delete_test_media} =  Create List     ${hyperlink_media_title}    ${video_media_title}    ${image_media_title}
    Delete created custom conversation and added media    ${delete_test_media}


Verify clear data when moving to another tab (OL-T21266, OL-T21265, OL-T21264, OL-T21263, OL-T21262, OL-T21261)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   List Select
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


Verify delete Media successfully for question type is 'List Select' when clicking on 'Remove media' option (OL-T21290, OL-T21286, OL-T21288)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    List Select    Hyperlink
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


Verify display video for question type is 'List Select' when candidate apply custom conversation in case video is marked required via landing site. (OL-T21313, OL-T21314, OL-T21323, OL-T21322)
    [Tags]    skip
    # Marked required doesn't need anymore following comment below 
    # https://paradoxai.atlassian.net/browse/OL-60795?focusedCommentId=300159
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}    ${media_content_title}   ${item_name} =  Add and Publish Custom conversation with Media   List Select    Video
    ${landing_site_name} =   Check Media is correct in Conversation  List Select    Video    Landing Site     ${media_content_title}  conversation_name=${conversation_name}
    Check element display on screen  ${CONVERSATION_CHOICE_BUTTON}  ${item_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}


Verify media uploaded are not removed when change to question type is 'List Select' (OL-T21295, OL-T21296, OL-T21294)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Media type not remove when change Question type    Yes/No     List Select


Verify drawer closed when clicking on 'Cancel' button (OL-T21233, OL-T21271)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   List Select
    #   Verify 'Add New Media' drawer is closed when clicking on 'Cancel' button
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    Capture page screenshot
    #   Verify 'Add Media' drawer is closed when clicking on 'Cancel' button
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}
    Capture page screenshot
    #   Cleaning data
    Delete conversation in builder


Verify reprompt message when candidate skip select items and don't watch view full video. (OL-T21315)
    [Tags]    skip
    # Marked required doesn't need anymore following comment below 
    # https://paradoxai.atlassian.net/browse/OL-60795?focusedCommentId=300159
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}   ${media_content_title}   ${item_name} =   Add and Publish Custom conversation with Media  List Select     Video   Require Video
    ${landing_site_name} =  Create landing site/widget site     Landing Site     conversation_name=${conversation_name}
    ${landing_site_url} =    Get Landing Site shortened URL   ${landing_site_name}
    Go to   ${landing_site_url}
    Click by JS    ${CONVERSATION_ASSIST_BLOCK_VIDEO}
    #   Play then Pause video, and skip select list item in order to show prompt message
    Click at     ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
    Click at     ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
    Click at    ${CONVERSATION_CHOICE_BUTTON}    ${item_name}
    Click at    ${CONVERSATION_SKIP_EEO_BUTTON}
    #   Check message
    Check element display on screen    It looks like you haven't watched the video yet. Please watch the video to move on to the next question.
    capture page screenshot
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}


Verify search hyperlinks,image, video successfully (OL-T21268, OL-T21269, OL-T21270)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Search Media ability of Hyperlink, Image, Video in Conversation    List Select


Verify 'Edit Reprompt Message' dialog (OL-T21300, OL-T21303, OL-T21306, OL-T21302, OL-T21307, OL-T21304, OL-T21305, OL-T21308, OL-T21229, OL-T21301)
    [Tags]  skip
    #   CUSTOM_CONVERSATION_QUESTION_REQUIRED_CHECKBOX is hidden, related-TCs should be skipped
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${media_title} =     Create new custom conversation and then add new media   List Select    Video
    Verify test cases related to 'Edit Reprompt Message' dialog     ${media_title}


Verify add media successfully for question type is 'List select' in case Toogle 'Is this question required?' is turn ON (OL-T21280, OL-T21282, OL-T21284)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    #   Input required info
    Input question name    ${custom_conv_question_name}
    Input question content    ${custom_conv_question_name}    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    List Select
    Edit list select    question_required=Yes
    #   Add Media to testing
    ${hyperlink_title} =    Add a New media for testing     Hyperlink
    Remove media  ${hyperlink_title}
    ${image_title} =        Add a New media for testing     Image/GIF
    Remove media  ${image_title}
    ${video_title} =        Add a New media for testing     Video
    Remove media  ${video_title}
    #   Add exist media
    Add an exist media  Hyperlink  ${hyperlink_title}
    Remove media  ${hyperlink_title}
    Add an exist media  Image/GIF  ${image_title}
    Remove media  ${image_title}
    Add an exist media  Video  ${video_title}
    Remove media  ${video_title}
    #   Clear data
    @{media_list} =     Create List     ${hyperlink_title}  ${image_title}  ${video_title}
    Delete created custom conversation and added media  ${media_list}


Verify display hyperlink for question type is 'List select' when candidate apply custom conversation on Widget (OL-T21326)
    [Tags]    skip
    #   Need to run widget conversation through Git repo URL instead of Sale demo page
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  List Select     Hyperlink
    ${landing_site_name} =   Check Media is correct in Conversation    List Select    Hyperlink    Widget Conversation    ${media_content_title}     conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}

*** Keywords ***
Add and Publish Custom conversation with Media
    [Arguments]     ${question_type}      ${media_type}      ${required_media}=None
    Go to conversation builder
    ${conversation_name} =  Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Input question content    ${custom_conv_question_name}    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    ${item_name} =  Additional step for each question type   ${question_type}
    # Add Media to testing
    ${media_content_title} =    Add a New media for testing     ${media_type}
    # Turn on required Media if test cases needed
    IF  '${required_media}' != 'None'
        IF  '${media_type}' == 'Video'
            Click at   Required to view full video
            Wait for successfully message toast disappear
        END
    END
    # Add common question to Publish conversation
    Add question by type    auto_question_name    Phone Number
    Add question by type    Phone Number    Full Name
    Add next question    Full Name
    Input question name    End Conversation
    Select question type    End Conversation    End Conversation
    Input question content    End Conversation    End conversation \#la-location_name
    Capture page screenshot
    Public custom conversation
    [Return]    ${conversation_name}    ${media_content_title}   ${item_name}
