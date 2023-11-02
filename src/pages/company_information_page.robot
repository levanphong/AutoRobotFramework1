*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/client_setup_page.robot
Variables       ../locators/company_information_locators.py

*** Keywords ***
Upload a image to brand
    [Arguments]    ${media_type}=Image/GIF   ${file_name}=cat-kute.jpg
    IF  '${media_type}' == 'Image/GIF'
        ${image_path} =    get_path_upload_image_path   ${file_name}
        Choose File    ${BRAND_MANAGEMENT_TAB_UPLOAD_IMAGE_INPUT}   ${image_path}
        Click at    ${BRAND_MANAGEMENT_TAB_CROP_IMAGE_CONFIRM_CANCEL}    Confirm
        wait for page load successfully v1
    END
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_UPLOADED_IMAGE_VISIBLE}

Add a brand
    [Arguments]    ${brand_name}=None    ${external_id}=None
    Click at    ${BRAND_MANAGEMENT_TAB_ADD_BRAND_BUTTON}
    Upload a image to brand
    IF  "${brand_name}" == "None"
        ${brand_name} =    Generate random name only text    brand
    END
    Input into    ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}    ${brand_name}
    IF    ${external_id} != 'None'
        Input into    ${BRAND_MANAGEMENT_TAB_EXTERNAL_ID_INPUT}    $txt_value
    END
    Click at    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}    Save
    [Return]   ${brand_name}

Is brand existed
    [Arguments]    ${brand_name}
    Run Keyword And Ignore Error    Scroll to element    ${BRAND_MANAGEMENT_CREATED_BRAND_NAME}    ${brand_name}
    Check element display on screen    ${BRAND_MANAGEMENT_CREATED_BRAND_NAME}    ${brand_name}
