*** Settings ***
Resource            ./upload_media.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    regression

*** Variables ***
${question_type_equal_communication_preference}       Communication Preference

*** Test Cases ***
Change hyperlink for question type is 'Communication Preference' (OL-T22201, OL-T22202, OL-T22203, OL-T22155, OL-T22165, OL-T22170)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Change Conversation question's Media to expected Media     ${question_type_equal_communication_preference}


Check Upload media successfully when input valid value into all field (OL-T22156)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check upload successfully when input valid into all fields   ${question_type_equal_communication_preference}     Video


Check validate 'Add new content' drawer when in case input incorrect format into 'URL' field (OL-T22168, OL-T22169, OL-T22172, OL-T22173, OL-T22188, OL-T22175)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check URL error message for Hyperlink type
    Open Add New Media dialog with Media type   ${question_type_equal_communication_preference}   Hyperlink
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


Check validate 'Add new content' drawer when select media type is hyperlink in case input into 'Name your content' field (OL-T22143, OL-T22144, OL-T22148, OL-T22147, OL-T22171, OL-T22157, OL-T22166, OL-T22167)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check Content Name filed input for Hyperlink type
    Open Add New Media dialog with Media type   ${question_type_equal_communication_preference}    Hyperlink
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


Check validate 'Add new media' drawer when select media type is video in case input more than 120 character into 'Add Alt Text' filed (OL-T22149)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check display of Add Alt Text (optional) when input more than 120 characters   ${question_type_equal_communication_preference}    Video


Edit hyperlink (OL-T22209)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   ${question_type_equal_communication_preference}    Hyperlink


Edit video (OL-T22207)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   ${question_type_equal_communication_preference}    Video


Edit image (OL-T22208)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Edit media name and then check name is changed   ${question_type_equal_communication_preference}    Image/GIF


Verify search hyperlinks,image, video successfully (OL-T22281, OL-T22282, OL-T22283)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check Search Media ability of Hyperlink, Image, Video in Conversation    ${question_type_equal_communication_preference}


Check upload Media on 'Add new content' drawer when upload invalid Media (OL-T22160, OL-T22161, OL-T22153, OL-T22154)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   ${question_type_equal_communication_preference}    Image/GIF
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


Check Upload image successfully when input valid value into requried field incase upload file .jpg (OL-T22162)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Add question type are phone/email to conversation
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type_equal_communication_preference}
    Additional step for each question type   ${question_type_equal_communication_preference}
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_gif_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    Delete created custom conversation and added media  ${media_content_title_1}


Check Upload image successfully when input valid value into requried field incase upload file .png (OL-T22163)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Add question type are phone/email to conversation
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type_equal_communication_preference}
    Additional step for each question type   ${question_type_equal_communication_preference}
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_image_png_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    Delete created custom conversation and added media  ${media_content_title_1}


Check Upload image successfully when input valid value into requried field incase upload file .gif (OL-T22164, OL-T22180)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    Add new custom conversation with name
    Add question type are phone/email to conversation
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type_equal_communication_preference}
    Additional step for each question type   ${question_type_equal_communication_preference}
    # Check upload success when upload image with GIF type
    ${media_content_title_1} =    Add a New media for testing     Image/GIF   ${custom_conv_gif_file_name}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${media_content_title_1}
    Capture page screenshot
    Remove media    ${media_content_title_1}
    #   Check design of 'Add Media' drawer
    Check design of 'Add Media' dialog
    Delete created custom conversation and added media  ${media_content_title_1}


Verify 'Add Media' drawer is closed when clicking on 'Cancel' button (OL-T22184)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add Media dialog   ${question_type_equal_communication_preference}
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}
    Capture page screenshot
    #   Cleaning data
    Delete conversation in builder


Verify 'Add new media' drawer closed when clicking on 'Cancel' button (OL-T22146)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   ${question_type_equal_communication_preference}
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    # Check Create button not display to Verify `Add new media` dialog closed
    Check element not display on screen      ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    Capture page screenshot
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder


Verify add hyperlink, image, video successfully (OL-T22194, OL-T22185, OL-T22193, OL-T22186, OL-T22192, OL-T22187, OL-T22199, OL-T22197, OL-T22195)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    ${question_type_equal_communication_preference}    Hyperlink
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


Verify clear data when moving to another tab (OL-T22174, OL-T22175, OL-T22176, OL-T22177, OL-T22178, OL-T22179)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Open Add New Media dialog with Media type   ${question_type_equal_communication_preference}
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


Verify delete Media successfully for question type is 'Communication Preference' when clicking on 'Remove media' option (OL-T22000, OL-T22198, OL-T22196)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    #   Verify can add uploaded Hyperlink Media
    ${hyperlink_media_title} =     Create new custom conversation and then add new media    ${question_type_equal_communication_preference}    Hyperlink
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
