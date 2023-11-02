*** Settings ***
Resource            ./upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    stg_mchire    unilever    test

*** Variables ***
${suite_question_type}      Document Upload

*** Test Cases ***
Change hyperlink for question type is 'Document Upload' (OL-T21594, OL-T21593, OL-T21592, OL-T21553, OL-T21543, OL-T21558)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Change Conversation question's Media to expected Media     ${suite_question_type}


Check Upload media successfully when input valid value into all field (OL-T21544)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check upload successfully when input valid into all fields   ${suite_question_type}     Video


Check validate 'Add new content' drawer when in case input incorrect format into 'URL' field (OL-T21557, OL-T21561, OL-T21556, OL-T21560, OL-T21531, OL-T21576, OL-T21533)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check URL error message for Hyperlink type
    Open Add New Media dialog with Media type   ${suite_question_type}   Hyperlink
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


Check validate 'Add new content' drawer when select media type is hyperlink in case input into 'Name your content' field (OL-T21555, OL-T21554, OL-T21545, OL-T21559, OL-T21532, OL-T21535, OL-T21536)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check Content Name filed input for Hyperlink type
    Open Add New Media dialog with Media type   ${suite_question_type}    Hyperlink
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


Check validate 'Add new media' drawer when select media type is video in case input more than 120 character into 'Add Alt Text' filed (OL-T21537)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check display of Add Alt Text (optional) when input more than 120 characters   ${suite_question_type}    Video


Edit hyperlink (OL-T21600)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   ${suite_question_type}    Hyperlink


Edit video (OL-T21598)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   ${suite_question_type}    Video


Edit image (OL-T21599)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   ${suite_question_type}    Image/GIF


Verify media uploaded are not removed when change to question type is 'Document Upload' (OL-T21596, OL-T21597, OL-T21530, OL-T21595)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Check Media type not remove when change Question type   Email     ${suite_question_type}


Verify search hyperlinks,image, video successfully (OL-T21569, OL-T21570, OL-T21571)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Check Search Media ability of Hyperlink, Image, Video in Conversation    ${suite_question_type}


Check upload Media on 'Add new content' drawer when upload invalid Media (OL-T21548, OL-T21549, OL-T21541, OL-T21542)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   ${suite_question_type}    Image/GIF
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


Check Upload image successfully when input valid value into requried field incase upload file .jpg (OL-T21550)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${suite_question_type}
    Additional step for each question type   ${suite_question_type}
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_gif_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    Delete created custom conversation and added media  ${media_content_title_1}


Check Upload image successfully when input valid value into requried field incase upload file .png (OL-T21551)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${suite_question_type}
    Additional step for each question type   ${suite_question_type}
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_image_png_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    Delete created custom conversation and added media  ${media_content_title_1}


Check Upload image successfully when input valid value into requried field incase upload file .gif (OL-T21552, OL-T21568)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${suite_question_type}
    Additional step for each question type   ${suite_question_type}
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_gif_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    #   Check design of 'Add Media' drawer
    Check design of 'Add Media' dialog
    Delete created custom conversation and added media  ${media_content_title_1}


Verify 'Add Media' drawer is closed when clicking on 'Cancel' button (OL-T21572)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Open Add Media dialog   ${suite_question_type}
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}
    Capture page screenshot
    #   Cleaning data
    Delete conversation in builder


Verify 'Add new media' drawer closed when clicking on 'Cancel' button (OL-T21534)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   ${suite_question_type}
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    # Check Create button not display to Verify `Add new media` dialog closed
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    Capture page screenshot
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder


Verify add hyperlink, image, video successfully (OL-T21575, OL-T21584, OL-T21574, OL-T21582, OL-T21573, OL-T21577, OL-T21588, OL-21586, OL-T21590)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    ${suite_question_type}    Hyperlink
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


Verify clear data when moving to another tab (OL-T21562, OL-T21563, OL-T21564, OL-T21565, OL-T21566, OL-T21567)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   ${suite_question_type}
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


Verify delete Media successfully for question type is 'Document Upload' when clicking on 'Remove media' option (OL-T21587, OL-T21589, OL-T21591)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    ${suite_question_type}    Hyperlink
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

*** Keywords ***
