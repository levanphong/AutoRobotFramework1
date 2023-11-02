*** Settings ***
Resource            ./upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    unilever    darden    test

*** Test Cases ***
Check validate 'Add new content' drawer when select media type is hyperlink in case input into 'Name your content' field (OL-T21153, OL-T21152, OL-T21143, OL-T21157, OL-T21133, OL-T21134, OL-T21130, OL-T21129, OL-T21132, OL-T21128)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check Content Name filed input for Hyperlink type
    Open Add New Media dialog with Media type   Email    Hyperlink
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


Verify search hyperlinks,image, video successfully (OL-T21167, OL-T21168, OL-T21169)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Search Media ability of Hyperlink, Image, Video in Conversation    Email


Check validate 'Add new content' drawer when in case input incorrect format into 'URL' field (OL-T21158, OL-T21159, OL-T21154, OL-T21155, OL-T21131, OL-T21170)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check URL error message for Hyperlink type
    Open Add New Media dialog with Media type   Email   Hyperlink
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


Edit hyperlink (OL-T21196)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   Email    Hyperlink


Edit video (OL-T21194)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   Email    Video


Edit image (OL-T21195)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   Email    Image/GIF


Verify clear data when moving to another tab (OL-T21160, OL-T21161, OL-T21162, OL-T21164, OL-T21165)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Email
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


Verify delete Media successfully for question type is 'Email' when clicking on 'Remove media' option (OL-T21187, OL-T21185, OL-T21183)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    Email    Hyperlink
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


Verify add hyperlink, image, video successfully (OL-T21182, OL-T21184, OL-T21186, OL-T21171, OL-T21172, OL-T21173, OL-T21178, OL-T21181)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    Email    Hyperlink
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


Verify 'Edit Reprompt Message' dialog (OL-T21200, OL-T21201, OL-T21203, OL-T21202, OL-T21197, OL-T21205, OL-T21199, OL-T21198, OL-T21204)
    # Marked required doesn't need anymore following comment below
    # https://paradoxai.atlassian.net/browse/OL-60795?focusedCommentId=300159
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${media_title} =     Create new custom conversation and then add new media   Email    Video
    Select option eclipse menu item  ${custom_conv_question_name}  Edit Reprompt Message
    #   Verify Edit Reprompt Message displays when clicking on Edit Reprompt Message option
    # - Drawer Title: Edit Reprompt Message
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}  Edit Reprompt Message
    # - Drawer Description: The following reprompt messages will be sent to candidates when they provide an invalid response.
    Check element display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  The following reprompt messages will be sent to candidates when they provide an invalid response.
    # - Show section ‘Message Prompt’ and include the 6 default responses we use in current state
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  1
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  2
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  3
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  4
    Check element display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  +
    Check element not display on screen      ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  5
    # - Show section ‘Media Prompt’ and include the 1 default response
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  1
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  2
    # - Default Prompt message: It looks like you haven't watched the video yet. Please watch the video to move on to the next question.
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  It looks like you haven't watched the video yet. Please watch the video to move on to the next question.
    capture page screenshot
    #   Verify can input max 320 characters into each media prompt message
    Check display of prompt message when input more than 320 characters
    #   Verify delete media prompt message successfully
    Verify delete media prompt message successfully
    #   Verify show error message with content 'This field is required' when leaving blank question and clicking on 'Save' button at 'Edit Reprompt Message'.
    Add/edit message for Media prompt  2  ${EMPTY}
    Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_INVALID_MESSAGE}  This field is required
    #   Verify there is no 'Trash' icon for the first media prompt message.
    Hover at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  1
    Check element not display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TRASH_ICON}  1
    #   Verify can add max 6 media prompt messages
    Add 5 media prompt messages
    Check content of 5 media prompt messages
    # To make sure prompt max at 6, button `+` disable
    Check element not display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}   +
    #   Verify edit media prompt message successfully
    Edit 6 media prompt messages
    Check content of 6 media prompt messages
    #   Verify Edit Reprompt Message popup is closed when clicking on 'Cancel' button
    Close 'Edit prompt message' dialog
    #   Delete data
    Delete created custom conversation and added media    ${media_title}


Change hyperlink for question type is 'Email' (OL-T21188, OL-T21189, OL-T21190, OL-T21141, OL-T21151, OL-T21156, OL-T21142)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Change Conversation question's Media to expected Media     Email


Check Upload Media successfully when Upload valid Media type (OL-T21150, OL-T21148, OL-T21149, OL-T21166)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    Email
    Additional step for each question type   Email
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


Check upload Media on 'Add new content' drawer when upload invalid Media (OL-T21147, OL-T21146, OL-T21140, OL-T21139, OL-T21174)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   Email    Image/GIF
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


Check validate 'Add new media' drawer when select media type is video in case input more than 120 character into 'Add Alt Text' filed (OL-T21135)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check display of Add Alt Text (optional) when input more than 120 characters   Email    Video


Verify media uploaded are not removed when change to question type is 'Email' (OL-T21191, OL-T21192, OL-T21193)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Media type not remove when change Question type   Address     Email


Verify display video for question type is 'Email' when candidate apply custom conversation in case video is marked required (OL-T21210, OL-T21211, OL-T21207, OL-T21219, OL-T21218, OL-T21207)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Email     Video
    ${landing_site_name} =   Check Media is correct in Conversation  Email    Video    Landing Site     ${media_content_title}    conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}


Verify display hyperlink for question type is 'Email' when candidate apply custom conversation (OL-T21221)
    [Tags]    skip
    #   Need to run widget conversation through Git repo URL instead of Sale demo page
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${conversation_name}  ${media_content_title} =  upload_media.Add and Publish Custom conversation with Media  Email     Hyperlink
    ${landing_site_name} =   Check Media is correct in Conversation    Email    Hyperlink    Widget Conversation    ${media_content_title}     conversation_name=${conversation_name}
    # Delete test data
    Delete a landing site/widget site   ${landing_site_name}
    Delete a Conversation   ${conversation_name}
    Delete media in media library   ${media_content_title}

*** Keywords ***
