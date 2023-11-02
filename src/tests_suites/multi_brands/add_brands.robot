*** Settings ***
Resource            ../../pages/company_information_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/web_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        test

*** Variables ***
${OL_R1154_brand_name}      Brand OL-R1154
${site_name}                Site OL-R1154

*** Test Cases ***
Verify Multi-Branding toggle is added into Client Setup, Check UI of Detail tab on Company Information page, Check UI of brand management tab on Company Information page, Verify Save button is disabled when user isn't entered the Logo and Brand Name, Verify Upload Brand Logo is successful, Verify User can create new Brand, Verify Error message is displayed when user add new the brand same name, Verify User can select edit Brand under ellipse icon, Verify User can select Deactive Brand under ellipse icon, Verify Error messgae is displayed correctly when user add the same Brand Name of a Brand that has been deactivated in the past (OL-T15332, OL-T15333, OL-T15334, OL-T15335, OL-T15337, OL-T15338, OL-T15339, OL-T15340, OL-T15341, OL-T15342)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # verify Multi-Branding toggle is added into Client Setup
    Turn on/off multi branding Toggle       On
    Go to page in setting menu step by step     Client Setup
    wait for page load successfully v1
    Turn on     ${CLIENT_SETUP_CAMPUS_MULTI_BRANDING_TOGGLE}
    Save client setup page
    Reload Page
    Check toggle is On      ${CLIENT_SETUP_CAMPUS_MULTI_BRANDING_TOGGLE}
    Go to page in setting menu step by step     Company Information
    Click at    ${COMPANY_INFORMATION_PATTERN_NAV_TAB}      Details
    Verify displayed details tab
    Click at    ${COMPANY_INFORMATION_PATTERN_NAV_TAB}      Brand Management
    Verify UI of brand management tab
    # Check save button is disable
    Check element display on screen     ${BRAND_MANAGEMENT_TAB_SAVE_DISABLE_BUTTON}
    Upload a image to brand
    Capture Page Screenshot
    # Verify user can create brand
    ${brand_name} =     Generate random name only text      brand
    Input into      ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}    ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}      Save
    wait for page load successfully v1
    Is brand existed    ${brand_name}
    Capture Page Screenshot
    # Verify Error message is displayed when user add a same name brand
    Click at    ${BRAND_MANAGEMENT_TAB_ADD_BRAND_BUTTON}
    Upload a image to brand
    Input into      ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}    ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}      Save
    Check element display on screen     This brand name is already in use.
    Capture Page Screenshot
    Click at    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}      Cancel
    # Verify user can select edit brand under ellipse icon
    Scroll to element       ${BRAND_MANAGEMENT_CREATED_BRAND_NAME}      ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_BRAND_TOOL_BUTTON}       ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_BRAND_EDIT_BUTTON}
    Verify UI of edit brand popup       ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}      Cancel
    # Verify user can select deactivate brand under ellipse icon
    Scroll to element       ${BRAND_MANAGEMENT_CREATED_BRAND_NAME}      ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_BRAND_TOOL_BUTTON}       ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_BRAND_DEACTIVATE_BUTTON}
    Verify UI of delete brand popup     ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_DEACTIVATE_CANCEL_BUTTON}       Deactivate
    Reload Page
    ${deactivated_status} =     Run Keyword And Return Status       Is brand existed    ${brand_name}
    Should Be Equal As Strings      ${deactivated_status}       False
    # Verify Error messgae is displayed correctly when user add the same Brand Name of a Brand that has been deactivated in the past
    Click at    ${BRAND_MANAGEMENT_TAB_ADD_BRAND_BUTTON}
    Upload a image to brand
    Input into      ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}    ${brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}      Save
    Check element display on screen     This brand name has been deactivated.
    Capture Page Screenshot


Verify Popup warning is displayed there are active jobs and widgets assigned to the brand (OL-T15343)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to brand management page
    Scroll to element       ${BRAND_MANAGEMENT_CREATED_BRAND_NAME}      ${OL_R1154_brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_BRAND_TOOL_BUTTON}       ${OL_R1154_brand_name}
    Click at    ${BRAND_MANAGEMENT_TAB_BRAND_DEACTIVATE_BUTTON}
    Verify UI Popup warning is displayed there are active jobs and widgets assigned to the brand
    # Verify go to job
    Click at    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_GOTO_JOB_WEB_BUTTON}    Go to Jobs
    @{window} =     get window handles
    switch window       ${window}[1]
    Check element display on screen     ${JOBS_TAB}
    Capture Page Screenshot
    Close Window
    Switch Window       ${window}[0]
    Click at    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_GOTO_JOB_WEB_BUTTON}    Go to Web Management
    @{window} =     get window handles
    switch window       ${window}[1]
    Check element display on screen     ${WEB_MANAGEMENT_PAGE_SEARCH_BOX}
    Capture Page Screenshot

*** Keywords ***
Verify displayed details tab
    Check element display on screen    ${COMPANY_INFORMATION_PATTERN_TITLE_TAB}    Details
    Check element display on screen    ${COMPANY_INFORMATION_PATTERN_DESCRIPTION_TAB}    Configure this company’s profile.
    Check element display on screen    ${DETAIL_TAB_UPLOAD_IMAGE}
    Check element display on screen    ${DETAIL_TAB_PATTERN_LABEL}    Account name
    Check element display on screen    ${DETAIL_TAB_PATTERN_LABEL}    Public company name
    Check element display on screen    ${DETAIL_TAB_PATTERN_LABEL}    Phone number
    Check element display on screen    ${DETAIL_TAB_PATTERN_LABEL}    Address
    Check element display on screen    ${DETAIL_TAB_PATTERN_LABEL}    Business hours
    Check element display on screen    ${DETAIL_TAB_ACCOUNT_NAME_INPUT}
    Check element display on screen    ${DETAIL_TAB_PUBLIC_NAME_INPUT}
    Check element display on screen    ${DETAIL_TAB_PHONE_NUMBER_INPUT}
    Check element display on screen    ${DETAIL_TAB_COUNTRY_DROPDOWN}
    Check element display on screen    ${DETAIL_TAB_STREET_INPUT}
    Check element display on screen    ${DETAIL_TAB_CITY_INPUT}
    Check element display on screen    ${DETAIL_TAB_STATE_INPUT}
    Check element display on screen    ${DETAIL_TAB_CODE_ZIP_INPUT}
    Check element display on screen    ${DETAIL_TAB_DAY_SELECTION}
    Check element display on screen    ${DETAIL_TAB_TIME_INPUT}
    Check element display on screen    ${DETAIL_TAB_SECONDARY_ADDRESS_INPUT}
    Capture Page Screenshot

Verify UI of brand management tab
    Check element display on screen    ${COMPANY_INFORMATION_PATTERN_TITLE_TAB}    Brand Management
    Check element display on screen    ${COMPANY_INFORMATION_PATTERN_DESCRIPTION_TAB}    Manage multiple brands for this company.
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_ADD_BRAND_BUTTON}
    Capture Page Screenshot
    Click at    ${BRAND_MANAGEMENT_TAB_ADD_BRAND_BUTTON}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_ADD_EDIT_BRAND_HEADER}    Add Brand
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_UPLOAD_IMAGE}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_PATTERN_LABEL}    Logo
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_PATTERN_LABEL}    Brand Name
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_PATTERN_LABEL}    External ID (Optional)
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_EXTERNAL_ID_INPUT}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}    Cancel
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}    Save
    Capture Page Screenshot

Verify UI of edit brand popup
    [Arguments]    ${brand_name}    ${external_id}="None"
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_ADD_EDIT_BRAND_HEADER}    Edit Brand
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_UPLOAD_IMAGE}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_PATTERN_LABEL}    Logo
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_PATTERN_LABEL}    Brand Name
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_PATTERN_LABEL}    External ID (Optional)
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_EXTERNAL_ID_INPUT}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}    Cancel
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_SAVE_CANCEL_BUTTON}    Save
    ${brand_name_value} =    Get value and format text    ${BRAND_MANAGEMENT_TAB_BRAND_NAME_INPUT}
    Should Be Equal As Strings    ${brand_name}    ${brand_name_value}
    IF    '${external_id}' == 'None'
        ${external_id_value} =    Get value and format text    ${BRAND_MANAGEMENT_TAB_EXTERNAL_ID_INPUT}
        Should Be Equal As Strings    ${external_id}    ${external_id_value}
    END
    Capture Page Screenshot

Verify UI of delete brand popup
    [Arguments]    ${brand_name}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_HEADER}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_CONTAIN}    ${brand_name}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_DEACTIVATE_CANCEL_BUTTON}    Deactivate
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_DEACTIVATE_CANCEL_BUTTON}    Cancel
    Capture Page Screenshot

Go to page in setting menu step by step
    [Arguments]    ${page_name}
    Click at    ${LEFT_MENU_BUTTON}
    Click at    ${CEM_PAGE_RIGHT_MENU_SETTING_ICON}
    Click at    ${CEM_PAGE_RIGHT_MENU_ITEM}    ${page_name}

Verify UI Popup warning is displayed there are active jobs and widgets assigned to the brand
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_HEADER}
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_HELP_TEXT}
    ${help_text} =    Get text and format text    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_HELP_TEXT}
    ${expected_help_text} =      Set Variable    You must delete or reassign all active jobs and widgets with ${OL_R1154_brand_name} before you can deactivate this brand.
    Should Be Equal As Strings    ${help_text}    ${expected_help_text}
    Check element display on screen    You must delete or reassign all active jobs and widgets with
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_GOTO_JOB_WEB_BUTTON}    Go to Jobs
    Check element display on screen    ${BRAND_MANAGEMENT_TAB_POPUP_DEACTIVATE_WARNING_GOTO_JOB_WEB_BUTTON}    Go to Web Management
    Check element display on screen    ${AUTOMATION_TESTER_TITLE_021}
    Check element display on screen    ${site_name}
    Capture Page Screenshot
