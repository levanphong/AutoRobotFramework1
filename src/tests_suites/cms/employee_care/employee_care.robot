*** Settings ***
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/knowledge_base_page.robot
Resource            ../../../pages/cms_page.robot
Resource            ../../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          dev    test

*** Variables ***
${employee_kb_spreadsheet_url}      https://docs.google.com/spreadsheets/d/1Q3kBwEtUNbWKSt7qvNHIbeqUPo0kP_8w7Xju8EE6R1k/edit?skip_itp2_check=true#gid=1044337716
${question}                         How can I change my accident insurance coverage?
${custom_question}                  What are you doing ?
${video_url}                        https://www.youtube.com/watch?v=5GI2oWXlNt8
${image_url}                        https://img.meta.com.vn/Data/image/2022/01/13/anh-dep-thien-nhien-6.jpg
${hyperlink_url}                    https://google.com
${video_name}                       auto_video
${image_name}                       auto_image
${hyperlink_name}                   auto_hyperlink
@{fields_list}                      Administration    Benefits    Culture    Development    Directory    Payroll    Policies    Retirement    Scheduling    Persona    Custom
@{options}                          View Topics    Manage & Edit Topics    Add Custom Topics    Create Alerts
@{column_titles}                    Sample Question    Topic    Status    Last Edited

*** Test Cases ***
Check the Employee Assistant Responses section is not visible in case Employee Care is OFF (OL-T4613)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    when Go to Client setup page
    Then Navigate to Care Option
    And Check toggle is Off     ${EMPLOYEE_CARE_TOGGLE}
    when Go to CMS page
    Then Check element not display on screen    ${NAV_SUB_MENU_TEXT}    Employee Assistant Responses
    Capture page screenshot


Check the Employee Assistant Responses section is visible in case Employee Care is ON but the Knowledge Base sheet was not published (OL-T4614)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to Client setup page
    Then Navigate to Care Option
    And Check toggle is On      ${EMPLOYEE_CARE_TOGGLE}
    when Save a Link to company spreadsheet     Employee Care       ${employee_kb_spreadsheet_url}
    when Go to CMS page
    Then Check element display on screen    ${NAV_SUB_MENU_TEXT}    Employee Assistant Responses
    Capture page screenshot


Check the Employee Assistant Responses section is visible in case Employee Care is ON but the Knowledge Base sheet was published (OL-T4615)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to Client setup page
    Then Navigate to Care Option
    And Check toggle is On      ${EMPLOYEE_CARE_TOGGLE}
    And Turn Off    ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    And Save client setup page
    when Save a Link to company spreadsheet     Employee Care       ${employee_kb_spreadsheet_url}
    when Click at       ${LINK_COMPANY_SPREADSHEET_PUBLISH_BUTTON}
    Then Check text display     It might take up to few minutes to import data.
    when Go to Client setup page
    Then Navigate to Care Option
    And Turn On     ${CONTENT_MANAGEMENT_SYSTEM_TOGGLE}
    And Save client setup page
    when Go to CMS page
    Then Go to Employee Assistant Responses
    FOR     ${field}    IN      @{fields_list}
        Check Element Display On Screen     ${EMPLOYEE_CARE_GROUP_TITLE}    ${field}
    END
    Capture page screenshot


Verify new Employee Assistant Responses section on CMS (OL-T4617)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to CMS page
    then Check Element Display On Screen    ${NAV_SUB_MENU_TEXT}    Employee Assistant Responses
    Capture page screenshot


Check UI for Employee Assistant Responses section (OL-T4618)
    Login to Common company and Go to Employee Assistant Responses
    FOR     ${field}    IN      @{fields_list}
        Check Element Display On Screen     ${EMPLOYEE_CARE_GROUP_TITLE}    ${field}
    END
    Capture page screenshot


Verify if Paradox Admin is able to click on the gear setting icon (OL-T4620)
    Login to Common company and Go to Employee Assistant Responses
    And Click At    ${EMPLOYEE_CARE_GEAR_SETTING_ICON}
    FOR     ${option}    IN      @{options}
        Check Element Display On Screen     ${EMPLOYEE_CARE_GEAR_SETTING_DROPDOWN_ITEM}     ${option}
    END
    Capture page screenshot


Check if User is able to search on Employee Care tab (OL-T4629)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go To CMS Page
    then Go To Employee Assistant Responses
    ${random_search_keyword}=       Generate random text only
    when Input into     ${EMPLOYEE_CARE_SEARCH_TEXT_BOX}    ${random_search_keyword}
    Then Check p text display       There aren’t any results that match this search
    Capture page screenshot
    when Input into     ${EMPLOYEE_CARE_SEARCH_TEXT_BOX}    How can
    Then Check the search results match the search keyword      How can
    Capture page screenshot


Check if Paradox Admin is able to change the status of a topic to Live, Not Live (OL-T4631, OL-T4632)
    Given Setup test
    Login to Common company and Go to Employee Assistant Responses
    Add a sample question       ${custom_question}
    Create a answer for the custom question     ${custom_question}
    when Click At       ${CANDIDATE_CARE_BACK_BUTTON}
    Then Hover at       ${CMS_QUESTION_ECLIPSE_ICON}    ${custom_question}
    And Click at    ${CMS_QUESTION_ECLIPSE_ICON}    ${custom_question}
    And Click at    ${CMS_QUESTION_CHANGE_TO_LIVE_OPTION}       ${custom_question}
    And Check Element Display On Screen     ${CMS_QUESTION_STATUS_LIVE}     ${custom_question}
    Capture page screenshot
    when Hover at       ${CMS_QUESTION_ECLIPSE_ICON}    ${custom_question}
    Then Click at       ${CMS_QUESTION_ECLIPSE_ICON}    ${custom_question}
    And Click at    ${CMS_QUESTION_CHANGE_TO_NOT_LIVE_OPTION}       ${custom_question}
    And Check Element Display On Screen     ${CMS_QUESTION_STATUS_NOT_LIVE}     ${custom_question}
    Delete a sample question    ${custom_question}
    Capture page screenshot


Verify Answer Edit screen when viewing as Paradox Admin (OL-T4633)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to Employee Assistant Responses then click on question      What benefits are available to employees?
    Then Check Element Display On Screen    ${MENU_ACTIVE}      Global
    And Check Element Display On Screen     ${AUDIENCE_COUNTRY_TAB}     ${UNITED_STATES}
    And Check Element Display On Screen     ${AUDIENCE_COUNTRY_TAB}     Vietnam
    And Check Element Display On Screen     ${EMPLOYEE_CARE_SAMPLE_QUESTION_MENU_ACTIVE_TAB}    Answer
    And Verify tab has show the sample question and corresponding answer    Web     thanh sms       What benefits are available to employees?
    And Verify tab has show the sample question and corresponding answer    SMS     globa sms 22    What benefits are available to employees?
    And Check Element Display On Screen     ${OLIVIA_RESPONSE_HASHTAG_ICON}
    And Check Element Display On Screen     ${OLIVIA_RESPONSE_EMOJI_ICON}
    And Check Element Display On Screen     ${OLIVIA_RESPONSE_BOLD_BUTTON}
    And Check Element Display On Screen     ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}     Cancel
    And Check Element Display On Screen     ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}     Save
    Capture page screenshot


Check if Paradox Admin is able to add token in answer with Default tab (OL-T4636)
    Login to Common company and Go to Edit Answer view of question      ${question}
    And Set focus to element    ${OLIVIA_RESPONSE_TEXT_BOX}
    And Click at    ${OLIVIA_RESPONSE_HASHTAG_ICON}
    And Check hastag list displayed
    And Click at    ${OLIVIA_RESPONSE_HASHTAG_TEXT_VALUE}       event-name
    And Verify display text     ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}       \#event-name
    Capture page screenshot


Check if Paradox Admin is able to add token in answer with Country tab (OL-T4642)
    Login to Common company and Go to Edit Answer view of question      ${question}
    And Click At    ${AUDIENCE_COUNTRY_TAB}     ${UNITED_STATES}
    And Set focus to element    ${OLIVIA_RESPONSE_TEXT_BOX}
    And Click at    ${OLIVIA_RESPONSE_HASHTAG_ICON}
    And Check hastag list displayed
    And Click at    ${OLIVIA_RESPONSE_HASHTAG_TEXT_VALUE}       event-name
    And Verify display text     ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}       \#event-name
    Capture page screenshot


Check the UI of Employee Care tab when viewing as Company Admin users (OL-T4646)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CMS page
    Go to Employee Assistant Responses
    And Check Element Display On Screen     ${EMPLOYEE_CARE_TITLE}
    And Check Element Display On Screen     ${EMPLOYEE_CARE_SEARCH_TEXT_BOX}
    FOR     ${field}    IN      @{fields_list}
        Check Element Display On Screen     ${EMPLOYEE_CARE_GROUP_TITLE}    ${field}
    END
    Capture page screenshot


Check the content of each group when viewing as Company Admin User (OL-T4647)
    Login to Common company and Go to Employee Assistant Responses
    when Click at       ${EMPLOYEE_CARE_GROUP_TITLE}    Benefits
    Then Check UI of Employee Care group section    @{column_titles}
    Capture page screenshot


Check if Paradox Admin is able to add new but not more than 2 bubbles with Default tab (OL-T4649)
    Login to Common company and Go to Edit Answer view of question      How can I make changes to my benefits?
    ${response_messages} =      Get Text And Format Text    ${OLIVIA_RESPONSE_TEXT_BOX}
    ${random_message} =     Generate Random Text Only
    when Input Into     ${OLIVIA_RESPONSE_TEXT_BOX}     ${random_message}
    Then Add a bubble message       ${random_message}
    And Check Element Not Display On Screen     ${OLIVIA_RESPONSE_ADD_MESSAGE_BUTTON}
    And Hover at    ${OLIVIA_RESPONSE_SECOND_TEXT_BOX}
    And Click at    ${OLIVIA_RESPONSE_MESSAGE_TRASH_ICON}
    when Clear message then input new message       ${response_messages}    ${OLIVIA_RESPONSE_TEXT_BOX}
    Capture page screenshot


Check if Paradox Admin is able to add emoji in answer with Default tab (OL-T4650)
    Login to Common company and Go to Edit Answer view of question      What benefits are available to employees?
    ${response_messages} =      Get Text And Format Text    ${OLIVIA_RESPONSE_TEXT_BOX}
    when Input Emoji icon into Response message
    Then Clear message then input new message       ${response_messages}    ${OLIVIA_RESPONSE_TEXT_BOX}
    Capture page screenshot


Check if Paradox Admin is able to mark bold for messages with Default tab (OL-T4651)
    Login to Common company and Go to Edit Answer view of question      What benefits are available to employees?
    ${response_messages} =      Get Text And Format Text    ${OLIVIA_RESPONSE_TEXT_BOX}
    Mark bold a message     ${response_messages}
    Clear message then input new message    ${response_messages}    ${OLIVIA_RESPONSE_TEXT_BOX}
    Capture page screenshot


Check if Paradox Admin is able to add new variable messages with Default tab (OL-T4652)
    Login to Common company and Go to Edit Answer view of question      ${question}
    when Click at       ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Then Check Element Display On Screen    ${OLIVIA_RESPONSE_INDEX_MESSAGE_ACTIVE}     2
    ${random_message} =     Generate Random Text Only
    when Input Into     ${OLIVIA_RESPONSE_TEXT_BOX}     ${random_message}
    when Click at       ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Then Check Element Display On Screen    ${OLIVIA_RESPONSE_INDEX_MESSAGE_ACTIVE}     3
    And Check Element Not Display On Screen     ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Capture page screenshot


Check if Paradox Admin is able to save new variable message with Default tab (OL-T4653)
    Login to Common company and Go to Edit Answer view of question      ${question}
    ${random_message} =     Generate Random Text Only
    when Create second message box then input message into it       ${random_message}
    Then Click at       ${OLIVIA_RESPONSE_INDEX_MESSAGE}    2
    And Click at    ${OLIVIA_RESPONSE_TRASH_ICON}
    And Click at    ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}     Save
    And Check Text Display      Your changes were saved
    Capture page screenshot


Check if Paradox Admin is able to add new but not more than 2 bubbles with Country tab (OL-T4654)
    Login to Common company and Go to Edit Answer view of question      How can I make changes to my benefits?
    Click At    ${AUDIENCE_COUNTRY_TAB}     ${UNITED_STATES}
    ${response_messages} =      Get Text And Format Text    ${OLIVIA_RESPONSE_TEXT_BOX}
    ${random_message} =     Generate Random Text Only
    when Input Into     ${OLIVIA_RESPONSE_TEXT_BOX}     ${random_message}
    Then Add a bubble message       ${random_message}
    And Check Element Not Display On Screen     ${OLIVIA_RESPONSE_ADD_MESSAGE_BUTTON}
    And Hover at    ${OLIVIA_RESPONSE_SECOND_TEXT_BOX}
    And Click at    ${OLIVIA_RESPONSE_MESSAGE_TRASH_ICON}
    when Clear message then input new message       ${response_messages}    ${OLIVIA_RESPONSE_TEXT_BOX}
    Capture page screenshot


Check if Paradox Admin is able to mark bold for messages with Country tab (OL-T4656)
    Login to Common company and Go to Edit Answer view of question      What benefits are available to employees?
    And Click at    ${AUDIENCE_COUNTRY_TAB}     ${UNITED_STATES}
    ${response_messages} =      Get Text And Format Text    ${OLIVIA_RESPONSE_TEXT_BOX}
    Mark bold a message     ${response_messages}
    Clear message then input new message    ${response_messages}    ${OLIVIA_RESPONSE_TEXT_BOX}
    Capture page screenshot


Check if Paradox Admin is able to add new variable messages with Country tab (OL-T4657)
    Login to Common company and Go to Edit Answer view of question      What benefits are available to employees?
    And Click at    ${AUDIENCE_COUNTRY_TAB}     ${UNITED_STATES}
    when Click at       ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Then Check Element Display On Screen    ${OLIVIA_RESPONSE_INDEX_MESSAGE_ACTIVE}     2
    ${random_message} =     Generate Random Text Only
    when Input Into     ${OLIVIA_RESPONSE_TEXT_BOX}     ${random_message}
    when Click at       ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Then Check Element Display On Screen    ${OLIVIA_RESPONSE_INDEX_MESSAGE_ACTIVE}     3
    And Check Element Not Display On Screen     ${OLIVIA_RESPONSE_PLUS_BUTTON}
    Capture page screenshot


Check if Paradox Admin is able to save new variable message with Country tab (OL-T4658)
    Login to Common company and Go to Edit Answer view of question      What benefits are available to employees?
    when Click at       ${AUDIENCE_COUNTRY_TAB}     ${UNITED_STATES}
    ${random_message} =     Generate Random Text Only
    when Create second message box then input message into it       ${random_message}
    Then Click at       ${OLIVIA_RESPONSE_INDEX_MESSAGE}    2
    And Click at    ${OLIVIA_RESPONSE_TRASH_ICON}
    And Click at    ${EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON}     Save
    And Check Text Display      Your changes were saved
    Capture page screenshot


Check if a trash icon active when add new bubbles (OL-T4659)
    Login to Common company and Go to Edit Answer view of question      What benefits are available to employees?
    when Click at       ${OLIVIA_RESPONSE_ADD_MESSAGE_BUTTON}
    Then Verify Display Text    ${OLIVIA_RESPONSE_SECOND_TEXT_BOX}      ${EMPTY}
    And Hover at    ${OLIVIA_RESPONSE_SECOND_TEXT_BOX}
    And Check Element Display On Screen     ${OLIVIA_RESPONSE_MESSAGE_TRASH_ICON}
    And Click at    ${OLIVIA_RESPONSE_MESSAGE_TRASH_ICON}
    And Check Element Not Display On Screen     ${OLIVIA_RESPONSE_SECOND_TEXT_BOX}
    Capture page screenshot


Check if when click on Add Content active (OL-T4661)
    Login to Common company and Go to Edit Collection view of question      ${question}
    when Click at       ${COLLECTION_TAB_ADD_CONTENT_BUTTON}
    Then Check Element Display On Screen    ${COLLECTION_ADD_MEDIA_MODAL_TITLE}
    And Check Element Display On Screen     ${COLLECTION_ADD_MEDIA_MODAL_CLOSE_ICON}
    And Check Element Display On Screen     ${COLLECTION_ADD_MEDIA_MODAL_SEARCH_BOX}
    And Check Element Display On Screen     ${COLLECTION_ADD_MEDIA_MODAL_ADD_NEW_BUTTON}
    And Check Element Display On Screen     ${COLLECTION_ADD_MEDIA_MODAL_VIDEO_TAB}
    And Check Element Display On Screen     ${COLLECTION_ADD_MEDIA_MODAL_IMAGE_TAB}
    And Check Element Display On Screen     ${COLLECTION_ADD_MEDIA_MODAL_HYPERLINKS_TAB}
    Capture page screenshot


Check UI for Add New button (OL-T4663)
    Login to Common company and Go to Edit Collection view of question      ${question}
    when Click at       ${COLLECTION_TAB_ADD_CONTENT_BUTTON}
    Then Click at       ${COLLECTION_ADD_MEDIA_MODAL_ADD_NEW_BUTTON}
    And Check Element Display On Screen     ${COLLECTION_ADD_NEW_MEDIA_MODAL_TITLE}
    And Check Element Display On Screen     ${COLLECTION_ADD_NEW_MEDIA_MODAL_CLOSE_ICON}
    And Check UI Of Display When Select Media Type      Video
    when Click at       ${COLLECTION_ADD_NEW_MEDIA_TYPE}    Image/GIF
    And Check UI Of Display When Select Media Type      Image/GIF
    when Click at       ${COLLECTION_ADD_NEW_MEDIA_TYPE}    Hyperlinks
    And Check UI Of Display When Select Media Type      Hyperlinks
    when Check Element Display On Screen    ${COLLECTION_ADD_NEW_MEDIA_MODAL_CANCEL_BUTTON}
    Then Check Element Display On Screen    ${COLLECTION_ADD_NEW_MEDIA_MODAL_CREATE_BUTTON}
    Capture page screenshot


Check if when Add video (OL-T4664)
    Login to Common company and Go to Edit Collection view of question      ${question}
    when Click at       ${COLLECTION_TAB_ADD_CONTENT_BUTTON}
    when Add New Media into Content Collection      Video       ${video_url}    ${video_name}
    Check UI of Content Collection      ${video_name}


Check if when Add Image (OL-T4665)
    Login to Common company and Go to Edit Collection view of question      ${question}
    when Click at       ${COLLECTION_TAB_ADD_CONTENT_BUTTON}
    when Add New Media into Content Collection      Image/GIF       ${image_url}    ${image_name}
    Check UI of Content Collection      ${image_name}


Check if when Add Hyperlink (OL-T4666)
    Login to Common company and Go to Edit Collection view of question      ${question}
    when Click at       ${COLLECTION_TAB_ADD_CONTENT_BUTTON}
    when Add New Media into Content Collection      Hyperlinks      ${hyperlink_url}    ${hyperlink_name}
    Check UI of Content Collection      ${hyperlink_name}


Check if when click on + button in Collection tab active (OL-T4668)
    Login to Common company and Go to Edit Collection view of question      ${question}
    when Click at       ${COLLECTION_TAB_ADD_CONTENT_BUTTON}
    Select an media item then add it into Content Collection    Video       ${video_url}    ${video_name}
    Check UI of Content Collection      ${video_name}

*** Keywords ***
Login to Common company and Go to Edit Answer view of question
    [Arguments]    ${question}
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    when Go to Employee Assistant Responses then click on question          ${question}
    And Check Element Display On Screen             ${EMPLOYEE_CARE_SAMPLE_QUESTION_MENU_ACTIVE_TAB}                        Answer

Login to Common company and Go to Edit Collection view of question
    [Arguments]    ${question}
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    when Go to Employee Assistant Responses then click on question          ${question}
    Then Click At           ${EMPLOYEE_CARE_SAMPLE_QUESTION_MENU_TAB}       Collection
    And Check Element Display On Screen             ${EMPLOYEE_CARE_SAMPLE_QUESTION_MENU_ACTIVE_TAB}                        Collection

Login to Common company and Go to Employee Assistant Responses
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    when Go to CMS page
    when Go to Employee Assistant Responses

Check UI of display when Select Media Type
    [Arguments]    ${media_type}
    Check Element Display On Screen                 ${COLLECTION_ADD_NEW_MEDIA_MODAL_STEP_ITEM}     Select Media Type
    Check Element Display On Screen                 ${COLLECTION_ADD_NEW_MEDIA_TYPE}                ${media_type}
    Check Element Display On Screen                 ${COLLECTION_ADD_NEW_MEDIA_MODAL_STEP_ITEM}     Content Detail
    IF  "${media_type}" == "Video"
        Check Element Display On Screen                 ${COLLECTION_ADD_NEW_MEDIA_MODAL_STEP_ITEM}     Add Video
    END
    IF  "${media_type}" == "Image/GIF"
        Check Element Display On Screen                 ${COLLECTION_ADD_NEW_MEDIA_MODAL_STEP_ITEM}     Add Image or GIF
    END

Check UI of Content Collection
    [Arguments]    ${content_name}
    Then Check Element Display On Screen            ${COLLECTION_TAB_CONTENT_COLLECTION_TITLE}      ${content_name}
    And Check Element Display On Screen             ${COLLECTION_TAB_CONTENT_COLLECTION}            ${content_name}
    Capture page screenshot

Check UI of Employee Care group section
    [Arguments]    @{column_titles}
    FOR    ${column_title}    IN    @{column_titles}
        Check Element Display On Screen             ${EMPLOYEE_CARE_BENEFITS_GROUP_COLUMN_TITLE}             ${column_title}
    END
    Check Element Display On Screen                 ${CMS_QUESTION_STATUS_LIVE}                     What benefits are available to employees?
    Element should not be visible                   ${CMS_QUESTION_ECLIPSE_ICON}                    What benefits are available to employees?
