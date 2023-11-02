*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/conversation_builder_page.robot
Resource        ../tests_suites/conversation/custom_conversation/ability_to_upload_media/upload_media.resource
Variables       ../locators/custom_conversation_locators.py

*** Keywords ***
Add new custom conversation with name
    [Arguments]    ${name}=None
    IF  '${name}' == 'None'
        ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${name} =    Set variable    auto_Custom_${conversation_id}
    END
    Click at    ${ADD_CONVERSATION_BUTTON}
    ${is_clicked} =     Run keyword and return status   Click at    ${ADD_CUSTOM_CONVERSATION}
    IF  '${is_clicked}' == 'False'
        Click at    ${ADD_CONVERSATION_BUTTON}
        Click at    ${ADD_CUSTOM_CONVERSATION}
    END
    wait for page load successfully v1
    Input into    ${CUSTOM_CONVERSATION_NAME_TEXTBOX}    ${name}
    Click at    Conversation Name
    wait for page load successfully v1
    [Return]    ${name}

Add new custom conversation with name and welcome question
    [Arguments]    ${conversation_name}
    Add new custom conversation with name    ${conversation_name}
    Input question name    Welcome
    Input question content    Welcome    Welcome
    Select question type    Welcome    Open-Ended

Select question type
    [Arguments]    ${question_name}    ${type}
    ${question_type_dropdown} =    format string    ${QUESTION_TYPE_BY_TITLE_QUESTION_DROPDOWN}    ${question_name}
    Click at    ${question_type_dropdown}
    ${question_type} =    format string    ${QUESTION_TYPE_BY_NAME}    ${type}
    Click by JS    ${question_type}
    Click at    ${APPLY_BUTTON}
    wait for page load successfully v1

Input question name
    [Arguments]    ${question_name}
    Input into    ${FIRST_TITLE_QUESTION_TEXTBOX}    ${question_name}
    #Click to save
    ${question_title} =    format string    ${QUESTION_TITLE}   Name your question
    Click at    ${question_title}
    wait for page load successfully v1
    Expand question    ${question_name}

Expand question
    [Arguments]    ${question_name}
    ${question_title_after_save} =    format string    ${QUESTION_TITLE}    ${question_name}
    Click at    ${question_title_after_save}

Input question content
    [Arguments]    ${question_name}    ${content}
    ${question_description} =    format string    ${QUESTION_DESCRIPTION_TEXTBOX}    ${question_name}
    Input into    ${question_description}    ${content}
    #Click to save
    ${three_dot_icon} =    format string    ${THREE_DOT_ICON_BY_QUESTION_NAME}    ${question_name}
    Click at    ${three_dot_icon}
    wait for page load successfully v1

Select location for question
    [Arguments]    ${location}
    Click at    ${AVAILABLE_LOCATION_DROPDOWN}
    Input into    ${SEARCH_LOCATION_TEXTBOX}    ${location}
    ${location_checkbox} =    format string    ${LOCATION_CHECKBOX_BY_NAME}    ${location}
    Click at    ${location_checkbox}
    Click at    ${AVAILABLE_LOCATION_DROPDOWN}
    Click at    ${SAVE_LOCATION_BUTTON}
    wait for page load successfully v1
    Click at    ${SAVE_LOCATION_BUTTON}
    wait for page load successfully v1

Add next question
    [Arguments]    ${question_name}
    ${button_add} =    format string    ${CUSTOM_CONVERSATION_ADD_BUTTON}    ${question_name}
    Click at    ${button_add}
    Click at    ${NEXT_QUESTION_BUTTON}
    #   To wait for new question block appears
    Check element display on screen  ${QUESTION_TITLE}  Name your question
    capture page screenshot

Add question by type
    [Arguments]    ${question_name}    ${type}
    Add next question    ${question_name}
    Input question name    ${type}
    Select question type    ${type}    ${type}

Add location question
    [Arguments]    ${question_name}    ${location}
    Add next question    ${question_name}
    Input question name    Location
    Select question type    Location    Location Selection
    Select location for question    ${location}

Public custom conversation
    Click at    ${PUBLIC_STATUS_BUTTON}
    Click at    ${PUBLIC_CUSTOM_BUTTON}
    Check element not display on screen  ${PUBLISHING_CUSTOM_LABEL}
    Check element display on screen  ${PUBLIC_STATUS_BUTTON}

Delete custom conversation in builder
    Click at    ${DELETE_CUSTOM_CONVERSATION_BUTTON}
    Click at    ${CONFIRM_DELETE_CUSTOM_CONVERSATION_BUTTON}
    wait for page load successfully v1

Add New Media to a Question
    [Arguments]     ${media_type}   ${file_name}
    # Check dialog is New media or Existed media
    Run keyword and ignore error    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_SEARCH_MEDIA_TEXTBOX}  wait_time=5s
    ${is_new_media} =   Run keyword and return status   Verify display text     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}   Add New Media
    IF  '${is_new_media}' == 'False'
        Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_NEW_MEDIA_BUTTON}
    END
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}  ${media_type}
    ${media_content_title} =    Generate random name  ${prefix_media_title}
    Add New Media to a Question for each Question Type     ${media_type}   ${file_name}    ${media_content_title}
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    Wait for successfully message toast disappear
    [Return]    ${media_content_title}

Add New Media to a Question for each Question Type
    [Arguments]     ${media_type}   ${file_name}    ${media_content_title}=None
    Run keyword if  '${media_content_title}' != 'None'  Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX}  ${media_content_title}
    IF  '${media_type}' == 'Hyperlink'
        Input into  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX}  ${file_name}
    ELSE IF  '${media_type}' == 'Video'
        # Set CSS for Upload button to run script
        ${video_path} =    get_path_upload_video_path    ${file_name}
        Add New Media to a Question - Image/GIF and Video    ${video_path}
    ELSE IF  '${media_type}' == 'Image/GIF'
        # Set CSS for Upload button to run script
        ${image_path} =    get_path_upload_image_path   ${file_name}
        Add New Media to a Question - Image/GIF and Video    ${image_path}
    END
    Capture page screenshot

Add New Media to a Question - Image/GIF and Video
    [Arguments]     ${file_path}
    Choose File    ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_FILE_UPLOAD_BUTTON}    ${file_path}
    # Click confirm thumbnail, if the imported file is invalid, button won't display
    Run keyword and ignore error   Check element display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_UPLOADING_MEDIA_FIELD}   wait_time=2s
    Check element not display on screen  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_UPLOADING_MEDIA_FIELD}
    run keyword and ignore error   Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CROP_THUMBNAIL_CONFIRM_BUTTON}

Remove media
    [Arguments]   ${media_name}
    ${is_new_media} =   Run keyword and return status   Click at  ${CUSTOM_CONVERSATION_QUESTION_DELETE_MEDIA_BUTTON}  ${media_name}
    IF  '${is_new_media}' == 'True'
        click at    ${DELETE_MEDIA_TYPE_BUTTON}
        Wait for successfully message toast disappear
        check element not display on screen  ${CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK}  ${media_name}
    END

Remove Media in Eclipse menu
    [Arguments]   ${question_name}
    Select option eclipse menu item  ${question_name}  Remove Media
    Click at   ${DELETE_MEDIA_TYPE_BUTTON}
    Wait for successfully message toast disappear

Edit list select
    [Arguments]   ${conv_question_name}=None    ${question_required}=None   ${can_multi_choices}=None
    ${is_displayed} =   Run keyword and return status   element should be visible  ${CUSTOM_CONVERSATION_LIST_SELECT_ADD_ITEM_BUTTON}
    IF  '${is_displayed}' != 'True'
        Select option eclipse menu item   ${conv_question_name}   Edit List Select
    END
    #   Add item
    click at    ${CUSTOM_CONVERSATION_LIST_SELECT_ADD_ITEM_BUTTON}
    ${item_name} =   Generate random name   auto_item_
    input into  ${CUSTOM_CONVERSATION_LIST_SELECT_ITEM_NAME_TEXT_BOX}   ${item_name}
    #   Turn on toggles if needed
    Run keyword if   '${question_required}' != 'None'   Click on option toggle in Edit Question Option dialog    Is this question required?
    Run keyword if   '${can_multi_choices}' != 'None'   Click on option toggle in Edit Question Option dialog    Can multiple choices to be selected?
    Click at  ${EDIT_QUESTION_OPTION_DIALOG_SAVE_BUTTON}
    [Return]    ${item_name}

Edit Document Upload question
    [Arguments]   ${conv_question_name}=None    ${document_required}=None
    ${is_displayed} =   Run keyword and return status   Check element display on screen  ${CONVERSATION_QUESTION_OPTION_DOCUMENT_UPLOAD_TOGGLE}     Is this document required?
    IF  '${is_displayed}' != 'True'
        Select option eclipse menu item   ${conv_question_name}   Document Upload
    END
    #   Turn on toggles if needed
    Run keyword if   '${document_required}' != 'None'   Click by JS  ${CONVERSATION_QUESTION_OPTION_DOCUMENT_UPLOAD_TOGGLE}  Is this document required?
    Click at  ${EDIT_QUESTION_OPTION_DIALOG_SAVE_BUTTON}

Edit Area Of Interest
    [Arguments]     ${conv_question_name}=None
    ${is_displayed}=    Run keyword and return status   Check element display on screen   ${CUSTOM_CONVERSATION_AREA_OF_INTEREST_TITLE}
    IF  'is_displayed' == 'True'
        Select option eclipse menu item   ${conv_question_name}   Area of Interest
    END
    Click at    ${CUSTOM_CONVERSATION_AREA_OF_INTEREST_SELECT_GROUP_DROPDOWN_ICON}
    Input into      ${CUSTOM_CONVERSATION_AREA_OF_INTEREST_SEARCH_GROUP_TEXTBOX}    ${group_name}
    Click at    ${CUSTOM_CONVERSATION_AREA_OF_INTEREST_GROUP_OPTIONS_CHECKBOX}      ${group_name}
    Click at    ${CUSTOM_CONVERSATION_AREA_OF_INTEREST_APPLY_BUTTON}
    Click at    ${CUSTOM_CONVERSATION_AREA_OF_INTEREST_SAVE_BUTTON}
    capture page screenshot

Edit location select
    [Arguments]   ${conv_question_name}=None    ${location}=None
    ${is_displayed} =   Run keyword and return status   element should be visible  ${AVAILABLE_LOCATION_DROPDOWN}
    IF  '${is_displayed}' != 'True'
        Select option eclipse menu item   ${conv_question_name}   Edit Location Selection
    END
    #   Add item
    Select location for question    ${location}

Select option eclipse menu item
    [Arguments]     ${question_name}    ${option}
    Wait for successfully message toast disappear
    Click at  ${THREE_DOT_ICON_BY_QUESTION_NAME}  ${question_name}
    Click at  ${CUSTOM_CONVERSATION_QUESTION_ECLIPSE_MENU_ITEM}  ${option}
    wait for page load successfully v1

Wait for successfully message toast disappear
    [Arguments]  ${wait_time}=3s
    wait for page load successfully v1
    run keyword and ignore error    Check element display on screen     ${SUCCESSFULLY_MESSAGE_TOASTED}     wait_time=${wait_time}
    Check element not display on screen     ${SUCCESSFULLY_MESSAGE_TOASTED}
    capture page screenshot

Create custom conversation for all question type with media type
    [Arguments]     ${name_conv}    ${media_type}   ${content_title_name}
    Go to conversation builder
    ${conversation_name} =  Add new custom conversation with name     ${name_conv}
    Input question name    Open-Ended
    Input question content    Open-Ended    Open-Ended
    Select question type    Open-Ended    Open-Ended
    Add a New media by question type     ${media_type}      Open-Ended      content_title=${content_title_name}_open_ended
    Add question by type name    Open-Ended    Full Name
    Add a New media by question type     ${media_type}      Full Name     content_title=${content_title_name}_full_name
    Add question by type name    Full Name    Email
    Add a New media by question type     ${media_type}     Email      content_title=${content_title_name}_email
    Add question by type name    Email    Yes/No
    Add a New media by question type     ${media_type}     Yes/No      content_title=${content_title_name}_yes_no
    Add question by type name       Yes/No      List Select
    Additional step for each question type      List Select
    Add a New media by question type     ${media_type}     List Select      content_title=${content_title_name}_list_select
    Add question by type name       List Select     Document Upload
    Additional step for each question type      Document Upload
    Add a New media by question type     ${media_type}     Document Upload      content_title=${content_title_name}_document_upload
    Add question by type name    Document Upload    Phone Number
    Add a New media by question type     ${media_type}     Phone Number      content_title=${content_title_name}_phone_number
    Add question by type name    Phone Number    Address
    Add a New media by question type     ${media_type}     Address      content_title=${content_title_name}_address
    Add question by type name    Address     End Conversation
    Capture page screenshot
    Public custom conversation

Add question by type name
    [Arguments]    ${question_name}    ${type}
    Add next question    ${question_name}
    Input question name    ${type}
    Input question content    ${type}    ${type}
    Select question type    ${type}    ${type}

Add a New media by question type
    [Arguments]     ${media_type}    ${custom_conv_question_name}   ${content_title}    ${file_name}=None
    IF  '${file_name}' == 'None'
        ${file_name} =      Set variable    ${file_mapping_object}[${media_type}]
    END
    Select option eclipse menu item   ${custom_conv_question_name}   Upload Media
    ${media_content_title} =     Add New Media to a Question type     ${media_type}   ${file_name}      ${content_title}
    [Return]    ${media_content_title}

Add New Media to a Question type
    [Arguments]     ${media_type}   ${file_name}    ${content_title}
    # Check dialog is New media or Existed media
    Run keyword and ignore error    Check element display on screen  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_SEARCH_MEDIA_TEXTBOX}  wait_time=5s
    ${is_new_media} =   Run keyword and return status   Verify display text     ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE}   Add New Media
    IF  '${is_new_media}' == 'False'
        Click at  ${CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_NEW_MEDIA_BUTTON}
    END
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE}  ${media_type}
    ${media_content_title} =    set variable    ${content_title}
    Add New Media to a Question for each Question Type     ${media_type}   ${file_name}    ${media_content_title}
    Click at  ${CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON}
    Wait for successfully message toast disappear
    [Return]    ${media_content_title}

Add Candidate Journey to Custom Conversation
    [Arguments]    ${journey_name}
    Click at    ${CUSTOM_CONVERSATION_CANDIDATE_JOURNEY_DROPDOWN_BUTTON}
    Input into    ${CANDIDATE_JOURNEY_SEARCH_TEXTBOX}    ${journey_name}
    Check the checkbox  ${CANDIDATE_JOURNEY_ITEM_CHECKBOX}  ${journey_name}
    Click at   ${CANDIDATE_JOURNEY_APPLY_BUTTON}

Add end conversation to Custom Conversation
    [Arguments]   ${previous_question_title}    ${end_title}
    CLick at  ${CUSTOM_CONVERSATION_ADD_BUTTON}   ${previous_question_title}
    Click at  ${CUSTOM_CONVO_END_CONVERSATION_BUTTON}
    Input question name    ${end_title}

Add question type are phone/email to conversation
    Input question name    Email
    Input question content    Email    Email
    Select question type    Email    Email
    Add next question   Email
    Input question name    Phone Number
    Input question content    Phone Number    Phone Number
    Select question type    Phone Number    Phone Number
    Add next question   Phone Number

Edit Communication Reference
    [Arguments]     ${conv_question_name}=None
    ${is_displayed}=    Run keyword and return status       Check span display      Communication Preference
    IF  'is_displayed' == 'True'
        Select option eclipse menu item   ${conv_question_name}   Communication Preference
    END
    Click at    ${SAVE_LOCATION_BUTTON}
    capture page screenshot

Add question by type and content
    [Arguments]    ${type}     ${content}
    Input question name    ${type}
    Input question content    ${type}    ${content}
    Select question type    ${type}    ${type}
