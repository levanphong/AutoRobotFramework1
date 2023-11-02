*** Settings ***
Resource        ./base_page.robot
Variables       ../locators/dynamic_content_locators.py

*** Variables ***
${video_name}               auto_video
${image_name}               auto_image
${hyperlink_name}           auto_hyperlink
${video_url}                https://www.youtube.com/watch?v=EKxTwv682nU
${image_url}                https://img.meta.com.vn/Data/image/2022/01/13/anh-dep-thien-nhien-5.jpg
${link_url}                 https://www.google.com/
&{file_mapping_object}      Video=${video_name}    Image/GIF=${image_name}    Hyperlink=${hyperlink_name}
${name_collection}          auto_collection

*** Keywords ***
Add New Media
    [Arguments]     ${media_type}   ${link_url}     ${name_content}=None
    IF  "${name_content}" == "None"
        ${name_content} =      Set variable    ${file_mapping_object}[${media_type}]
    END
    Click at    ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    wait until element is visible   ${COLLECTION_ADD_MEDIA_MODAL}
    Click at    ${COLLECTION_ADD_MEDIA_MODAL_ADD_NEW_BUTTON}
    Click at    ${COLLECTION_ADD_NEW_MEDIA_TYPE}        ${media_type}
    Click at    ${COLLECTION_ADD_NEW_MEDIA_MODAL_NAME_CONTENT_TEXTBOX}
    input into  ${COLLECTION_ADD_NEW_MEDIA_MODAL_NAME_CONTENT_TEXTBOX}      ${name_content}
    input into  ${COLLECTION_ADD_NEW_MEDIA_MODAL_URL}       ${link_url}
    IF  "${media_type}" == "Image/GIF"
        Click at    ${COLLECTION_ADD_NEW_MEDIA_MODAL_CREATE_BUTTON}
        Click at    ${COLLECTION_ADD_NEW_MEDIA_CROP_COMFIRM_BUTTON}
    END
    Click at    ${COLLECTION_ADD_NEW_MEDIA_MODAL_CREATE_BUTTON}
    wait for page load successfully v1
    Click at    ${COLLECTION_ADD_NEW_MEDIA_MODAL_CREATE_BUTTON}
    wait until element is not visible   ${COLLECTION_ADD_NEW_MEDIA_MODAL_TITLE}

Select an media item
    [Arguments]     ${media_type_tab}     ${item_id}
    Click at        ${COLLECTION_ADD_MEDIA_MODAL_MEDIA_TYPE_TAB}     ${media_type_tab}
    ${items_list_count}=     Get Element Count      ${COLLECTION_ADD_MEDIA_MODAL_LIST_MEDIA}
    IF  ${items_list_count}!=0
        Click at    ${item_id}
        Click at  ${COLLECTION_ADD_MEDIA_MODAL_ADD_BUTTON}
        wait until element is not visible   ${COLLECTION_ADD_MEDIA_MODAL}
    ELSE
        IF      "${media_type_tab}" == "Video"
            Add New Media       Video     ${video_name}        ${video_url}
        ELSE IF      "${media_type_tab}" == "Image/GIF"
            Add New Media       Image/GIF     ${image_name}       ${image_url}
        ELSE
            Add New Media       Hyperlinks     ${hyperlink_name}      ${link_url}
        END
        wait until element is not visible   ${COLLECTION_ADD_MEDIA_MODAL}
    END

Create dynamic content collection
    [Arguments]     ${name_audience}        ${media_type}       ${name_collection}=None
    IF      '${name_collection}' == 'None'
        ${random} =    Generate Random String    5    [LETTERS][NUMBERS]
        ${name_collection}=    Set variable    auto_collection_${random}
    END
    Click at    ${DYNAMIC_CONTENT_ADD_COLLECTION_BUTTON}
    Check element display on screen     ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    Check element display on screen     ${COLLECTION_ADD_AUDIENCE_BUTTON}
    Click at    ${COLLECTION_HEADER}
    input into      ${COLLECTION_HEADER_INPUT_NAME}        ${name_collection}
    Click at    ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    Select an media item    ${media_type}       ${COLLECTION_ADD_MEDIA_MODAL_LIST_MEDIA}
    then Check element not display on screen        ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    Check element display on screen                 ${CONTENT_COLLECTION_LIST}
    Capture page screenshot
    Click at                ${COLLECTION_ADD_AUDIENCE_BUTTON}
    Check element display on screen                 ${COLLECTION_AUDIENCE_LIST}
    Capture page screenshot
    Click at                ${COLLECTION_AUDIENCE_ITEM}        ${name_audience}
    Click at                ${COLLECTION_AUDIENCE_APPLY_BUTTON}
    Check element not display on screen             ${COLLECTION_AUDIENCE_LIST}
    Capture page screenshot
    Click at        ${COLLECTION_CREATE_BUTTON}
    run keyword and ignore error    element should be visible       ${DYNAMIC_CONTENT_SAVE_CHANGE_ALERT}
    capture page screenshot
    [Return]    ${name_collection}

Search Collection name in Dynamic Content
    [Arguments]    ${collection_name}
    input into     ${DYNAMIC_CONTENT_SEARCH_INPUT}     ${collection_name}
    wait for page load successfully v1
    Check element display on screen    ${DYNAMIC_CONTENT_ROW}     ${collection_name}

Delete dynamic content collection
    [Arguments]     ${collection_name}
    Go to Dynamic Content page
    Search Collection name in Dynamic Content   ${collection_name}
    wait for page load successfully v1
    Click at    ${DYNAMIC_CONTENT_SUB_MEMU_ICON}
    Check element display on screen      ${DYNAMIC_CONTENT_SUB_MENU_OPTION}     Delete
    Click at    ${DYNAMIC_CONTENT_SUB_MENU_OPTION}     Delete
    wait until element is visible   ${DYNAMIC_CONTENT_CONFIRM_MODAL_DELETE_BUTTON}
    Click at    ${DYNAMIC_CONTENT_CONFIRM_MODAL_DELETE_BUTTON}
    wait for page load successfully v1
    Check element not display on screen     ${DYNAMIC_CONTENT_ROW}     ${collection_name}
