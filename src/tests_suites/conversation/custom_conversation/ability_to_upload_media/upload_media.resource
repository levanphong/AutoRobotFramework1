*** Settings ***
Resource            ../../../../drivers/driver_chrome.robot
Resource            ../../../../pages/conversation_builder_page.robot
Resource            ../../../../pages/custom_conversation_page.robot
Resource            ../../../../pages/cms_page.robot
Resource            ../../../../pages/web_management_page.robot
Resource            ../../../../pages/conversation_page.robot
Resource            ../../../../pages/sales_demo_page.robot
Resource            ../../../../pages/client_setup_page.robot

Documentation       CMS: Client Setup > Care > Turn ON `Content Management System` toggle

*** Variables ***
${custom_conv_question_name}                    auto_question_name
${custom_conv_video_file_name}                  sample-5s
${custom_conv_image_file_name}                  cat-kute
${custom_conv_hyperlink}                        https://www.paradox.ai/
&{file_mapping_object}                          Video=${custom_conv_video_file_name}    Image/GIF=${custom_conv_image_file_name}    Hyperlink=${custom_conv_hyperlink}
${text_with_40_characters}                      some random text more than 40 characters
${text_with_more_than_40_characters}            some random text more than 40 characters and more
${text_with_120_characters}                     some random text more than 120 characters some random text more than 120 characters some random text more than 120 chara
${text_with_more_than_120_characters}           some random text more than 120 characters some random text more than 120 characters some random text more than 120 characters and more
${img_url}                                      https://assets-global.website-files.com/611dc730a416cbf8f5934ebc/613fe26d198190f49c4ebd4c_Home-Onboard-Carousel-poster-00001.jpg
${video_url}                                    https://player.vimeo.com/video/716914830?app_id=122963&h=9bcefaf850&referrer=https%3A%2F%2Fwww.paradox.ai%2F
${custom_conv_video_over_100mb_file_name}       video-over-100mb
${custom_conv_video_webm_file_name}             video-webm
${custom_conv_image_png_file_name}              img-png
${custom_conv_image_webp_file_name}             img-webp
${custom_conv_image_over_5mb_file_name}         img-over-5mb
${custom_conv_gif_file_name}                    gif
${prompt_message_over_320_characters}           some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters
${prompt_message_320_characters}                some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than 320 characters some random text more than
&{upload_media_tab_mapping}                     Video=Video    Image/GIF=Image    Hyperlink=Hyperlinks
${prefix_media_title}                           auto_upload_media_title
${group_name}                                   Group_QA

*** Keywords ***
Add a New media for testing
    [Arguments]     ${media_type}   ${file_name}=None
    IF  '${file_name}' == 'None'
        ${file_name} =      Set variable    ${file_mapping_object}[${media_type}]
    END
    Select option eclipse menu item   ${custom_conv_question_name}   Upload Media
    ${media_content_title} =     Add New Media to a Question     ${media_type}   ${file_name}
    [Return]    ${media_content_title}

Delete created custom conversation and added media
    [Arguments]     ${media_title}
    Delete conversation in builder
    Delete media in media library   ${media_title}

Open Add New Media dialog with Media type
    [Arguments]     ${question_type}    ${media_type}=Video
    # Go to Conversation Builder page and create new Custom conversation
    Go to conversation builder
    Add new custom conversation with name
    IF   '${question_type}' == 'Communication Preference'
        Add question type are phone/email to conversation
    END
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    ${file_name} =      Set variable    ${file_mapping_object}[${media_type}]
    Additional step for each question type   ${question_type}
    # Upload a new Media to question
    Select option eclipse menu item   ${custom_conv_question_name}   Upload Media
    Run keyword and ignore error    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_SEARCH_MEDIA_TEXTBOX}  wait_time=5s
    #   To navigate to 'Add new media'
    ${is_new_media} =   Run keyword and return status   Verify display text     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}   Add New Media
    IF  '${is_new_media}' == 'False'
        Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_NEW_MEDIA_BUTTON}
    END
    #   Video is selected by default
    IF   '${media_type}' != 'Video'
        Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}  ${media_type}
    END
    [Return]    ${file_name}

Close Add New Media dialog
    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_BACK_BUTTON}
    Run keyword and ignore error    Click at    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}

Change Conversation question's Media to expected Media
    [Arguments]     ${question_type}
    Go to conversation builder
    Add new custom conversation with name
    IF  '${question_type}' == "Communication Preference"
        Add question type are phone/email to conversation
    END
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    Additional step for each question type   ${question_type}
    #   Video to hyperlink
    ${video_title} =    Add a New media for testing     Video
    Remove media    ${video_title}
    ${hyperlink_title} =    Add a New media for testing     Hyperlink
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${hyperlink_title}
    Capture page screenshot
    #   Hyperlink to Image/GIF
    Remove media    ${hyperlink_title}
    ${image_title} =    Add a New media for testing     Image/GIF
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${image_title}
    Capture page screenshot
    #   Image/GIF to Video
    Remove media    ${image_title}
    ${video_title_2} =    Add a New media for testing     Video
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${video_title_2}
    Capture page screenshot
    #   Delete test data
    @{delete_test_media} =  Create List     ${video_title}    ${hyperlink_title}    ${image_title}    ${video_title_2}
    Delete created custom conversation and added media  ${delete_test_media}

Additional step for each question type
    [Arguments]     ${question_type}    ${document_required}=None
    ${return_item} =  set variable  ${EMPTY}
    IF  '${question_type}' == 'List Select'
        ${return_item} =   edit list select
    ELSE IF  '${question_type}' == 'Document Upload'
        Edit Document Upload question   ${document_required}
    ELSE IF  '${question_type}' == 'Area of Interest'
        Edit Area Of Interest
    ELSE IF  '${question_type}' == 'Location Selection'
        Edit location select    location=${LOCATION_PHOENIX}
    ELSE IF  '${question_type}' == 'Communication Preference'
        Edit Communication Reference
    END
    [Return]    ${return_item}

Check URL field error message
    [Arguments]     ${media_type}    ${invalid_value}    ${optional_url}=None
    IF  '${invalid_value}' == 'this_is_not_a_link'
        # Error msg in case input URL with invalid value
        ${error_message} =  Set variable    This URL is invalid.
    ELSE
        # Error msg in case leave URL blank
        ${error_message} =  Set variable    This field is required.
    END
    ${media_content_title} =    Generate random name  ${prefix_media_title}
    # Input invalid value
    IF  '${optional_url}' != 'None'
        # Check for Optional URL: `URL Link (optional)` field
        Input common information for each Media Type     Optional URL    ${media_type}    ${media_content_title}
        Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_OPTIONAL_TEXTBOX}  ${invalid_value}
    ELSE
        # Check for Content URL: `By URL` field, `Add Your URL` field
        Input common information for each Media Type     Content URL    ${media_type}    ${media_content_title}
        Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${invalid_value}
    END
    Capture page screenshot
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    # Verify error message display
    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_INVALID_INPUT_MESSAGE}     ${error_message}
    Capture page screenshot

Check Content Name filed input action
    [Arguments]     ${media_type}    ${input_value}
    ${media_content_title} =    Generate random name  ${prefix_media_title}
    Input common information for each Media Type     Content Title     ${media_type}    ${media_content_title}
    # Input value
    Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}  ${input_value}
    IF  '${input_value}' == '${EMPTY}'
        # Verify error message if Content title is empty
        ${error_message} =  Set variable    This field is required.
        Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
        Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_INVALID_INPUT_MESSAGE}     ${error_message}
    ELSE
        # Verify only 40 characters display
        Verify display text with get text value  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}  ${text_with_40_characters}
        Capture page screenshot
    END

Check upload successfully when input valid into all fields
    [Arguments]     ${question_type}    ${media_type}
    ${file_name} =    Open Add New Media dialog with Media type     ${question_type}    ${media_type}
    ${media_content_title} =    Generate random name  ${prefix_media_title}
    # Input to all Fields with valid value
    Add New Media to a Question for each Question Type     ${media_type}    ${file_name}    ${media_content_title}
    Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}  ${custom_conv_hyperlink}
    Capture page screenshot
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    # Verify Media added
    Check element display on screen  ${media_content_title}
    Capture page screenshot
    # Delete test data
    Wait for successfully message toast disappear
    Delete created custom conversation and added media  ${media_content_title}

Check display of Add Alt Text (optional) when input more than 120 characters
    [Arguments]     ${question_type}    ${media_type}
    ${file_name} =    Open Add New Media dialog with Media type     ${question_type}    ${media_type}
    ${media_content_title} =    Generate random name  ${prefix_media_title}
    Input common information for each Media Type     Alt Text   ${media_type}      ${media_content_title}
    # Input more than 120 charaters
    Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}  ${text_with_more_than_120_characters}
    Capture page screenshot
    # Verify only 120 characters display
    Verify display text with get text value  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}  ${text_with_120_characters}
    Capture page screenshot
    # Delete test data
    Close Add New Media dialog
    Delete conversation in builder

Input common information for each Media Type
    [Arguments]     ${skip_field}   ${media_type}    ${media_content_title}=None
    # 4 fields to check: `Content Title`, `Content URL`, `Optional URL`, `Alt Text`
    # Skip field is the field need to verify, so skip input into it
    Run keyword if  '${skip_field}' != 'Content Title'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}  ${media_content_title}
    # Clear Uploaded Media file in form
    Run keyword and ignore error    Clear element text with keys  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}
    Run keyword and ignore error    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_REMOVE_FILE_UPLOADED_BUTTON}
    IF  '${media_type}' == 'Video'
        Run keyword if  '${skip_field}' != 'Content URL'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${video_url}
        Run keyword if  '${skip_field}' != 'Alt Text'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}  ${text_with_120_characters}
    ELSE IF  '${media_type}' == 'Image/GIF'
        Run keyword if  '${skip_field}' != 'Content URL'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${img_url}
        Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}
        # Click confirm thumbnail
        ${is_crop_thumbnail_popup_display} =    Run keyword and return status   Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CROP_THUMBNAIL_CONFIRM_BUTTON}  wait_time=5s
        IF  '${is_crop_thumbnail_popup_display}' == 'True'
            Run keyword if  '${skip_field}' != 'Content URL'  Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CROP_THUMBNAIL_CONFIRM_BUTTON}
        END
        Run keyword if  '${skip_field}' != 'Alt Text'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}  ${text_with_120_characters}
        Run keyword if  '${skip_field}' != 'Optional URL'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_OPTIONAL_TEXTBOX}  ${custom_conv_hyperlink}
    ELSE IF  '${media_type}' == 'Hyperlink'
        Run keyword if  '${skip_field}' != 'Content URL'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${custom_conv_hyperlink}
    END

Check upload media unsuccessfully when input invalid value into required field
    [Arguments]     ${file_name}
    #   Verify error message display
    IF  '${file_name}' == '${custom_conv_video_over_100mb_file_name}'
        check element display on screen     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_WARNING_MESSAGE}    File size exceeds 100MB.
    ELSE IF     '${file_name}' == '${custom_conv_image_over_5mb_file_name}'
        check element display on screen     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_WARNING_MESSAGE}    File size exceeds 5MB.
    ELSE
        check element display on screen     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_WARNING_MESSAGE}    You can't upload files of this type.
    END
    capture page screenshot

Edit media name and then check name is changed
    [Arguments]     ${question_type}      ${media_type}
    #   Create new custom convo, then add new media
    Open Add New Media dialog with Media type   ${question_type}    ${media_type}
    ${file_name} =      Set variable    ${file_mapping_object}[${media_type}]
    ${media_title} =     Add New Media to a Question     ${media_type}   ${file_name}
    # Check Media added
    Check element display on screen      ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}  ${media_title}
    Capture page screenshot
    ${custom_convo_location} =     Get location
    #   Edit media name in Media Library
    Open edit media dialog   ${media_title}
    ${new_media_title} =    Generate random name  ${prefix_media_title}
    Clear element text with keys    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}
    Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}  ${new_media_title}
    Capture page screenshot
    Click At    ${MEDIA_LIBRARY_EDIT_MEDIA_SAVE_BUTTON}
    #   Go to the previous custom convo builder
    Go to   ${custom_convo_location}
    # Verify new name of Media
    Check element display on screen    ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}  ${new_media_title}
    Check element not display on screen    ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}  ${media_title}
    capture page screenshot
    # Cleaning and finish
    Delete created custom conversation and added media    ${new_media_title}

Open edit media dialog
    [Arguments]    ${media_title}
    Go to CMS page
    Click At    Media Library
    Input into    ${SEARCH_MEDIA_SEARCH_BOX}    ${media_title}
    wait for page load successfully v1
    Click at      ${MEDIA_LIBRARY_ITEM_CHECK_BOX}     ${media_title}
    Click At    ${MEDIA_LIBRARY_EDIT_BUTTON}

Check design of 'Add Media' dialog
    #   Open 'Add Media' dialog
    Select option eclipse menu item   ${custom_conv_question_name}   Upload Media
    #   Title: Add Media
    Verify display text     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}   Add Media
    #   Text box: Search media
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_SEARCH_MEDIA_TEXTBOX}
    #   Buttons: Add new, Cancel, Add
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_NEW_MEDIA_BUTTON}
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_BUTTON}
    #   Tabs: Video, Image, Hyperlinks
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    Video
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    Image
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    Hyperlinks
    #   'Video' tab is default selected
    ${class_attribute} =    Get attribute and format text     class     ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    Video
    ${is_active}=  Should contain     ${class_attribute}     is-active
    #   Title of file media
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TITLE}
    Capture page screenshot
    #   Close dialog
    Close Add New Media dialog

Open Add Media dialog
    [Arguments]     ${question_type}    ${media_type}=Video
    # Go to Conversation Builder page and create new Custom conversation
    Go to conversation builder
    Add new custom conversation with name
    IF   '${question_type}' == 'Communication Preference'
        Add question type are phone/email to conversation
    END
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    Additional step for each question type   ${question_type}
    # Open
    Select option eclipse menu item   ${custom_conv_question_name}   Upload Media
    IF  '${media_type}' != 'Video'
        Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    ${upload_media_tab_mapping}[${media_type}]
    END
    wait for page load successfully v1

Create new custom conversation and then add new media
    [Arguments]     ${question_type}      ${media_type}     ${document_required}=None
    Go to conversation builder
    Add new custom conversation with name
    IF   '${question_type}' == 'Communication Preference'
        Add question type are phone/email to conversation
    END
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    Additional step for each question type   ${question_type}   ${document_required}
    ${media_title} =    Add a New media for testing     ${media_type}
    [Return]    ${media_title}

Check design of 'Add New Media' dialog
    [Arguments]     ${media_type}
    #   Title: Add New Media
    Verify display text     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}   Add New Media
    #   Select media type:  Video, Image/GIF, Hyperlink
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Video
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Image/GIF
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}    Hyperlink
    #   Buttons: Cancel, Create
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON}
    Check element display on screen    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    #   Content detail: Your name content, Add your URL
    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}
    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}
    #   'media_type' tab is selected
    ${class_attribute} =    Get attribute and format text     class     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CHECKBOX}    ${media_type}
    ${is_active} =  Should contain     ${class_attribute}     is-checked
    #   Check element based on media_type
    IF  '${media_type}' == 'Video'
        #   Content detail: Your name content, Add your URL
        Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}
        Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DRAG_FILE_BUTTON}
    ELSE IF   '${media_type}' == 'Image/GIF'
        #   Content detail: URL Link (optional), Add Alt Text (optional), Upload Item button
        Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}
        Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_OPTIONAL_TEXTBOX}
        Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DRAG_FILE_BUTTON}
    END

Add an exist media
    [Arguments]     ${media_type}     ${media_title}
    # Open Add Media dialog
    Select option eclipse menu item  ${custom_conv_question_name}  Upload Media
    # Switch to Media type tab
    Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    ${upload_media_tab_mapping}[${media_type}]
    # Add Upload Media
    Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_CARD}  ${media_title}
    Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_BUTTON}
    Wait for successfully message toast disappear
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}   ${media_title}
    Capture page screenshot

Add and Publish Custom conversation with Media
    [Arguments]     ${question_type}      ${media_type}      ${required_media}=None
    Go to conversation builder
    ${conversation_name} =  Add new custom conversation with name
    Input question name    ${custom_conv_question_name}
    Input question content    ${custom_conv_question_name}    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    Additional step for each question type   ${question_type}
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
    [Return]    ${conversation_name}    ${media_content_title}

Check Media is correct in Conversation
    [Arguments]     ${question_type}    ${media_type}    ${site_type}  ${media_content_title}=None    ${required_media}=None    ${conversation_name}=None
    ${landing_site_name} =  Create landing site/widget site     ${site_type}     conversation_name=${conversation_name}
    IF  '${site_type}' == 'Landing Site'
        ${landing_site_url} =    Get Landing Site shortened URL   ${landing_site_name}
        Go to   ${landing_site_url}
        Check Media for Landing Site    ${question_type}    ${media_content_title}   ${media_type}   ${required_media}
    ELSE IF  '${site_type}' == 'Widget Conversation'
        ${landing_site_url} =    Add a Widget to Sales Demo   ${landing_site_name}
        Go to   ${landing_site_url}
        Input into    ${DEMO_SITE_PASSWORD_TEXT_BOX}    1234
        Click at    ${DEMO_SITE_SIGN_IN_BUTTON}
        Wait with medium time
        Check Media for Widget     ${question_type}    ${media_content_title}   ${media_type}   ${required_media}
    END
    [Return]    ${landing_site_name}

Check Media for Landing Site
    [Arguments]     ${question_type}    ${media_content_title}   ${media_type}   ${required_media}
    IF  '${media_type}' == 'Video'
        Click by JS    ${CONVERSATION_ASSIST_BLOCK_VIDEO}
        # Verify Video player is correct
        Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
        Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_SOUND_BUTTON}
        Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_FULL_SCREEN_BUTTON}
        Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}
        Check element display on screen  ${CONVERSATION_VIDEO_PLAYER_DURATION_TIME_TEXT}
        Additional step for each question type in conversation  ${question_type}
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
    ELSE IF  '${media_type}' == 'Image/GIF'
        Click at    ${CONVERSATION_ASSIST_BLOCK}    ${media_content_title}
        # Verify is correct image
        Check element display on screen     ${CONVERSATION_ASSIST_BLOCK_IMG}
        Verify attribute should contain     src     ${custom_conv_image_file_name}     ${CONVERSATION_ASSIST_BLOCK_IMG}
    ELSE IF  '${media_type}' == 'Hyperlink'
        Click at    ${CONVERSATION_ASSIST_BLOCK}    ${media_content_title}
        # Verify Hyperlink go to correct page
        Switch window      Paradox: The AI assistant for recruiting, Olivia
        ${verify_url} =    Get location
        Should be equal as strings  ${verify_url}  ${custom_conv_hyperlink}
    END
    Capture page screenshot

Check Media for Widget
    [Arguments]     ${question_type}    ${media_content_title}   ${media_type}   ${required_media}
    Wait Until Page Contains Element    ${SHADOW_DOM_CHAT_WIDGET}
    IF  '${media_type}' == 'Video'
        Click by JS    ${SHADOW_DOM_ASSIST_BLOCK_VIDEO}
        # Verify Video player is correct
        Check element display on screen  ${SHADOW_DOM_VIDEO_PLAYER_PLAY_BUTTON}
        Check element display on screen  ${SHADOW_DOM_VIDEO_PLAYER_SOUND_BUTTON}
        Check element display on screen  ${SHADOW_DOM_VIDEO_PLAYER_FULL_SCREEN_BUTTON}
        Check element display on screen  ${SHADOW_DOM_VIDEO_PLAYER_CURRENT_TIME_TEXT}
        Check element display on screen  ${SHADOW_DOM_VIDEO_PLAYER_DURATION_TIME_TEXT}
        IF  '${required_media}' == 'None'
            Element Should be Enabled   ${INPUT_WIDGET}
            Element Should be Enabled  ${SHADOW_DOM_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
            # Extra test for combine test cases
            Click at  ${SHADOW_DOM_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
            Check element not display on screen  ${SHADOW_DOM_VIDEO_PLAYER_PLAY_BUTTON}
            Capture page screenshot
        ELSE
            Element Should Be Disabled   ${INPUT_WIDGET}
            Element Should Be Disabled   ${SHADOW_DOM_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
            # Extra test for combine test cases
            # Wait until end of video in 5s
            Click at  ${SHADOW_DOM_VIDEO_PLAYER_PLAY_BUTTON}
            Wait Until Element Is Enabled   ${SHADOW_DOM_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON}
            Verify display text  ${SHADOW_DOM_VIDEO_PLAYER_CURRENT_TIME_TEXT}  00:05
            Capture page screenshot
        END
    ELSE IF  '${media_type}' == 'Image/GIF'
        Click at    ${SHADOW_DOM_ASSIST_BLOCK}
        Capture page screenshot
        # Verify is correct image
        Verify attribute should contain     src     ${custom_conv_image_file_name}     ${SHADOW_DOM_ASSIST_BLOCK_IMG}
    ELSE IF  '${media_type}' == 'Hyperlink'
        Click at    ${SHADOW_DOM_ASSIST_BLOCK}
        # Verify Hyperlink go to correct page
        Switch window      Paradox: The AI assistant for recruiting, Olivia
        ${verify_url} =    Get location
        Should be equal as strings  ${verify_url}  ${custom_conv_hyperlink}
    END
    Capture page screenshot

Add/edit message for Media prompt
    [Arguments]     ${button_name}  ${message_content}  ${should_save}=None
    #   To open 'Edit Prompt Message' dialog if the dialog don't currently open
    ${is_visible} =     Run keyword and return status   Check element display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}     wait_time=5s
    Run keyword if    '${is_visible}' != 'True'     Select option eclipse menu item  ${custom_conv_question_name}  Edit Reprompt Message
    #   To show 'number' of message textbox
    FOR    ${index}    IN RANGE    2    6
        ${is_clicked} =   run keyword and return status   Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  ${button_name}
        Exit For Loop If    '${is_clicked}' == 'True'
        Run keyword if  '${is_clicked}' == 'False'    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}   +
    END
    #   To enter message_content into textbox
    Input into  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  ${message_content}
    Capture page screenshot
    #   To click save button or not
    Run keyword if  '${should_save}' == 'None'  Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}

Add 5 media prompt messages
    Add/edit message for Media prompt   2   message 2   Not Save
    Add/edit message for Media prompt   3   message 3   Not Save
    Add/edit message for Media prompt   4   message 4   Not Save
    Add/edit message for Media prompt   5   message 5   Not Save
    Add/edit message for Media prompt   6   message 6

Edit 6 media prompt messages
    Add/edit message for Media prompt   1   Msg 1   Not Save
    Add/edit message for Media prompt   2   Msg 2   Not Save
    Add/edit message for Media prompt   3   Msg 3   Not Save
    Add/edit message for Media prompt   4   Msg 4   Not Save
    Add/edit message for Media prompt   5   Msg 5   Not Save
    Add/edit message for Media prompt   6   Msg 6

Check content of 5 media prompt messages
    Select option eclipse menu item  ${custom_conv_question_name}  Edit Reprompt Message
    #   Check message 1 exist
    Check element display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}   1
    #   Check message 2
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              2
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  message 2
    Capture page screenshot
    #   Check message 3
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              3
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  message 3
    Capture page screenshot
    #   Check message 4
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              4
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  message 4
    Capture page screenshot
    #   Check message 5
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              5
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  message 5
    Capture page screenshot
    #   Check message 6
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              6
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  message 6
    Capture page screenshot

Check content of 6 media prompt messages
    Select option eclipse menu item  ${custom_conv_question_name}  Edit Reprompt Message
    #   Check message 1
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  Msg 1
    Capture page screenshot
    #   Check message 2
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              2
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  Msg 2
    Capture page screenshot
    #   Check message 3
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              3
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  Msg 3
    Capture page screenshot
    #   Check message 4
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              4
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  Msg 4
    Capture page screenshot
    #   Check message 5
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              5
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  Msg 5
    Capture page screenshot
    #   Check message 6
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}              6
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  Msg 6
    Capture page screenshot

Check display of prompt message when input more than 320 characters
    Add/edit message for Media prompt   2   ${prompt_message_over_320_characters}   Not Save
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  ${prompt_message_320_characters}
    Capture page screenshot

Check clear date when navigate to other tab
    [Arguments]  ${media_type_A}   ${media_type_B}
    ${media_content_title} =    Generate random name  ${prefix_media_title}
    ${file_name_A} =      Set variable    ${file_mapping_object}[${media_type_A}]
    Add New Media to a Question for each Question Type     ${media_type_A}   ${file_name_A}    ${media_content_title}
    #   Navigate to media_type_B and then fill required value
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}  ${media_type_B}
    ${file_name_B} =      Set variable    ${file_mapping_object}[${media_type_B}]
    Add New Media to a Question for each Question Type     ${media_type_B}   ${file_name_B}    ${media_content_title}
    #   Navigate back to media_type_A
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}  ${media_type_A}
    # ${media_type_A} is the need to clear all input after change to another tab
    Verify display text with get text value    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}   ${EMPTY}
    IF  '${media_type_A}' == 'Hyperlink'
        Verify display text with get text value  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${EMPTY}
    ELSE
        Check element display on screen     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DRAG_FILE_BUTTON}
        Verify display text with get text value  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${EMPTY}
        IF  '${media_type_A}' == 'Video'
            Verify display text with get text value  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX}  ${EMPTY}
        ELSE IF  '${media_type_A}' == 'Image/GIF'
            Verify display text with get text value  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_OPTIONAL_TEXTBOX}  ${EMPTY}
        END
    END
    Capture page screenshot

Check Media type not remove when change Question type
    [Arguments]     ${src_question_type}    ${target_question_type}
    ${hyperlink_title} =    Create new custom conversation and then add new media   ${src_question_type}    Hyperlink
    Select question type    ${custom_conv_question_name}    ${target_question_type}
    Additional step for each question type  ${target_question_type}
    #   Check hyperlink not remove when change Question type
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${hyperlink_title}
    Capture page screenshot
    Remove media  ${hyperlink_title}
    Select question type    ${custom_conv_question_name}    ${src_question_type}
    #   Check image type not remove when change Question type
    ${image_title}=    Add a New media for testing    Image/GIF
    Select question type    ${custom_conv_question_name}    ${target_question_type}
    #   To handle if question type is List Select, no need to add item
    Run keyword and ignore error    Click at  ${CUSTOM_CONVERSATION_LIST_SELECT_CANCEL_BUTTON}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${image_title}
    Capture page screenshot
    Remove media  ${image_title}
    Select question type    ${custom_conv_question_name}    ${src_question_type}
    #   Check video type not remove when change Question type
    ${video_title}=    Add a New media for testing    Video
    Select question type    ${custom_conv_question_name}    ${target_question_type}
    #   To handle if question type is List Select, no need to add item
    Run keyword and ignore error    Click at  ${CUSTOM_CONVERSATION_LIST_SELECT_CANCEL_BUTTON}
    Check element display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}    ${video_title}
    Capture page screenshot
    Remove media  ${video_title}
    #   Delete test data
    @{title_list} =     create list   ${hyperlink_title}    ${image_title}   ${video_title}
    Delete created custom conversation and added media  ${title_list}

Search Uploaded Media in Conversation
    [Arguments]     ${media_content_title}    ${media_type}
    # Remove Media from Conversation (But still uploaded in CMS)
    Remove media    ${media_content_title}
    # Open Search Media dialog
    Click at  ${THREE_DOT_ICON_BY_QUESTION_NAME}  ${custom_conv_question_name}
    Click at  ${CUSTOM_CONVERSATION_QUESTION_ECLIPSE_MENU_ITEM}  Upload Media
    Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB}    ${upload_media_tab_mapping}[${media_type}]
    # Search and check Media exist
    Input into  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_SEARCH_MEDIA_TEXTBOX}    ${media_content_title}
    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_CARD}     ${media_content_title}
    Capture page screenshot
    # Close Search dialog
    Close Add New Media dialog

Check Search Media ability of Hyperlink, Image, Video in Conversation
    [Arguments]     ${question_type}
    # Add a Custom conversation with question type
    Go to conversation builder
    Add new custom conversation with name
    IF  '${question_type}' == 'Communication Preference'
        Add question type are phone/email to conversation
    END
    Input question name    ${custom_conv_question_name}
    Select question type    ${custom_conv_question_name}    ${question_type}
    Additional step for each question type   ${question_type}
    # Add Hyperlink media and check Search ability
    ${media_content_title_hyperlink} =    Add a New media for testing    Hyperlink
    Capture page screenshot
    Search Uploaded Media in Conversation   ${media_content_title_hyperlink}      Hyperlink
    # Add Image/GIF media and check Search ability
    ${media_content_title_image} =    Add a New media for testing    Image/GIF
    Capture page screenshot
    Search Uploaded Media in Conversation   ${media_content_title_image}      Image/GIF
    # Add Video media and check Search ability
    ${media_content_title_video} =    Add a New media for testing    Video
    Capture page screenshot
    Search Uploaded Media in Conversation   ${media_content_title_video}      Video
    # Delete test data
    @{delete_test_media} =  Create List     ${media_content_title_hyperlink}    ${media_content_title_image}    ${media_content_title_video}
    Delete created custom conversation and added media  ${delete_test_media}

Delete prompt message
    [Arguments]     ${button_name}
    #   Trash icon displays when hover on prompt message number
    Hover at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  ${button_name}
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TRASH_ICON}  ${button_name}
    Click at  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON}

Verify delete media prompt message successfully
    Delete prompt message   2
    Check element display on screen     Changes saved successfully.
    #   Check prompt message was deleted
    Select option eclipse menu item  ${custom_conv_question_name}  Edit Reprompt Message
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}    2
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}    1
    Capture page screenshot

Check design of 'Edit prompt message' dialog
    # - Drawer Title: Edit Reprompt Message
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE}  Edit Reprompt Message
    # - Drawer Description: The following reprompt messages will be sent to candidates when they provide an invalid response.
    Check element display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION}  The following reprompt messages will be sent to candidates when they provide an invalid response.
    # - Show section ‘Message Prompt’ and include the 3 default responses we use in current state
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  1
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  2
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  3
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  +
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON}  4
    # - Show section ‘Media Prompt’ and include the 1 default response
    Check element display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  1
    Check element not display on screen     ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON}  2
    # - Default Prompt message: It looks like you haven't watched the video yet. Please watch the video to move on to the next question.
    Verify text contain  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX}  It looks like you haven't watched the video yet. Please watch the video to move on to the next question.
    capture page screenshot

Close 'Edit prompt message' dialog
    [Arguments]     ${button_type}=Cancel button
    IF      '${button_type}' == 'Cancel button'
        Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_CANCEL_BUTTON}
    ELSE
        Click at    ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON}
    END
    Check element not display on screen  ${CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_TEXTBOX}
    capture page screenshot

Additional step for each question type in conversation
    [Arguments]     ${questiong_type}
    IF   '${questiong_type}' == 'List Select'
        Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
        Check element not display on screen  ${CONVERSATION_PROCESSING_BUTTON}
    END

Verify test cases related to 'Edit Reprompt Message' dialog
    [Arguments]     ${media_title}
    Select option eclipse menu item  ${custom_conv_question_name}  Edit Reprompt Message
    #   Verify Edit Reprompt Message displays when clicking on Edit Reprompt Message option
    Check design of 'Edit prompt message' dialog
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

Verify 'Play' button is working properly
    #   Open video block
    Click by JS    ${CONVERSATION_ASSIST_BLOCK_VIDEO}
    # Verify 'Play' button is correct
    Play/pause video  Play
    Play/pause video  Pause

Verify 'Sound' button is working properly
    #   Open video block
    Click by JS    ${CONVERSATION_ASSIST_BLOCK_VIDEO}
    # Verify 'Sound' button is correct
    Turn on/off Sound  Off
    Turn on/off Sound  On

Check media library when CMS is toggled ON after upload a media successfully
    [Arguments]     ${question_type}    ${document_required}=None
    #   Precondition: turn off CMS
    Turn off CMS Toggle
    ${hyperlink_title} =    Create new custom conversation and then add new media  ${question_type}    Hyperlink    ${document_required}
    #   Remove hyperlink then add image/gif
    Remove media    ${hyperlink_title}
    ${image_title} =    Add a New media for testing     Image/GIF
    #   Remove hyperlink then add image/gif
    Remove media    ${image_title}
    ${video_title} =    Add a New media for testing     Video
    Delete conversation in builder
    Turn on CMS Toggle
    #   Search, find, then delete
    @{media_list} =  Create list    ${hyperlink_title}   ${image_title}   ${video_title}
    Delete media in media library   ${media_list}
