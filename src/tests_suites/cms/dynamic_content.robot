*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/dynamic_content_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test
Documentation       Run data test src/data_tests/cms/dynamic_content.robot

*** Variables ***
${name}                 taylor swift
${phone}                0855802962
${age}                  30
${like}                 music
${group_a}              OL-T17270_groupa
${group_b}              OL-T17270_groupb
${location_name_1}      New York
${location_name_2}      Maiden Lane
${location_name}        Vietnam

*** Test Cases ***
Check Dynamic Content page in empty state (OL-T4861)
    # Log in as Paradox Admin/Company Admin: CMS toggle is ON :done
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    Go to Dynamic Content page
    Check Element Display On Screen                 ${DYNAMIC_CONTENT_TITLE}
    Check Element Display On Screen                 ${DYNAMIC_CONTENT_SEARCH_ICON}
    Check element display on screen                 ${DYNAMIC_CONTENT_SEARCH_CONTENT}
    Check element display on screen                 ${DYNAMIC_CONTENT_ADD_COLLECTION_BUTTON}
    Check element display on screen                 ${DYNAMIC_CONTENT_DESCRIPTION}
    Check element display on screen                 ${DYNAMIC_CONTENT_COLLECTION_NAME}
    Check element display on screen                 ${DYNAMIC_CONTENT_ASSIGNED_AUDIENCE}
    Check element display on screen                 ${DYNAMIC_CONTENT_COLLECTION_NAME}
    Check element display on screen                 ${DYNAMIC_CONTENT_LAST_EDITED}
    Check element display on screen                 ${DYNAMIC_CONTENT_TABLE_EMPTY}
    Verify Display Text     ${DYNAMIC_CONTENT_TABLE_EMPTY}                  Nothing to show right now.
    Capture page screenshot


Check if user is able to add an Audience Builder to Dynamic Content (OL-T4862)
    # Log in as Paradox Admin/Company Admin: CMS toggle is ON, User is being on CMS > Dynamic Content
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    Go to Dynamic Content page
    Click at                ${DYNAMIC_CONTENT_ADD_COLLECTION_BUTTON}
    wait for page load successfully v1
    # Check Add Collection page in empty state as design
    Check element display on screen                 ${COLLECTION_HEADER}
    Verify Display Text     ${COLLECTION_HEADER}    Name your content collection
    Check element display on screen                 ${COLLECTION_HEADER_EDIT_ICON}
    Check element display on screen                 ${COLLECTION_CANCEL_BUTTON}
    Check element display on screen                 ${COLLECTION_CREATE_BUTTON}
    Check element display on screen                 ${CONTENT_COLLECTION_TITLE}                     Content Collection
    Check element display on screen                 ${CONTENT_COLLECTION_DESCRIPTION}               Build your content collection of up to 3 media.
    Check element display on screen                 ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    Check element display on screen                 ${AUDIENCE_TITLE}       Audience
    Check element display on screen                 ${AUDIENCE_DESCRIPTION}                         Assign audiences to this content collection.
    Check element display on screen                 ${COLLECTION_ADD_AUDIENCE_BUTTON}
    Capture page screenshot
    Click at                ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    # Then Check Add Media modal display as design
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL}
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_TITLE}             Add Media
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_SEARCH_BOX}
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_ADD_NEW_BUTTON}    Add New
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_VIDEO_TAB}         Video
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_IMAGE_TAB}         Image/GIF
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_HYPERLINKS_TAB}    Hyperlinks
    # Check Cancel and Add button should be display
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_CANCEL_BUTTON}
    Check element display on screen                 ${COLLECTION_ADD_MEDIA_MODAL_ADD_BUTTON}
    Capture page screenshot
    Select an media item    Image/GIF               ${COLLECTION_ADD_MEDIA_MODAL_LIST_MEDIA}
    then Check element not display on screen        ${CONTENT_COLLECTION_ADD_MEDIA_BUTTON}
    Check element display on screen                 ${CONTENT_COLLECTION_LIST}
    Capture page screenshot
    Click at                ${COLLECTION_ADD_AUDIENCE_BUTTON}
    Check element display on screen                 ${COLLECTION_AUDIENCE_LIST}
    Capture page screenshot
    Click at                ${COLLECTION_AUDIENCE_LIST_ITEM_LABEL}
    ${audience_name}=       Get text and format text                        ${COLLECTION_AUDIENCE_LIST_ITEM_LABEL}
    Click at                ${COLLECTION_AUDIENCE_APPLY_BUTTON}
    Check element not display on screen             ${COLLECTION_AUDIENCE_LIST}
    Check text display      ${audience_name}
    Capture page screenshot


Check if Media is show when accepting terms when Terms are ON & Dynamic Content at Introduction state (OL-T11419)
    # Client Setup > Compliance and Security > GDPR ON for Global
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_OFF}
    ${conversation_name} =                          Add Single conversation                         Single Path
    ${site_name}=           Create landing site/widget site                 Landing Site
    Assign the conversation to the landing site/widget site                 ${conversation_name}    ${site_name}
    Go to CMS page
    Click on span text      Audience Builder
    wait for page load successfully v1
    ${audience_name}=       Add an Audience with targeting type             Conversation State      Is                      Introduction
    Click at                Candidate Assistant Responses
    wait for page load successfully v1
    Click at                Dynamic Content
    wait for page load successfully v1
    ${collection_name}=     Create Dynamic Content Collection               ${audience_name}        Image/GIF
    # Choose an conversation in order to interaction conversation
    Go to Web Management
    ${url}=                 Get Landing Site shortened URL                  ${site_name}
    Go to                   ${url}
    wait until element is visible                   ${GDPR_MODAL}
    Check element display on screen                 ${GDPR_MODAL}
    capture page screenshot
    Click at                ${GDPR_MODAL_ACCEPT_BUTTON}
    wait until element is not visible               ${GDPR_MODAL_ACCEPT_BUTTON}
    Check element display on screen                 ${MESSAGE_CONVERSATION_IMAGE_MEDIA}
    capture page screenshot
    Delete dynamic content collection               ${collection_name}
    Delete an Audience      ${audience_name}
    Delete a landing site/widget site               ${site_name}
    Delete a Conversation                           ${conversation_name}


Widget - Check if Dynamic content is displayed when it matches the audience builder rule = Conversation State (OL-T17271)
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    ${audience_name}=       Add an Audience with targeting type             Conversation State      Is                      Phone Number
    Click at                Candidate Assistant Responses
    wait for page load successfully v1
    Click at                Dynamic Content
    wait for page load successfully v1
    ${collection_name}=     Create dynamic content collection               ${audience_name}        Image/GIF
    ${conversation_name}=                           Add Single conversation                         Single Path
    ${site_name}=           Create landing site/widget site                 Landing Site
    ${url}=                 Assign the conversation to the landing site/widget site                 ${conversation_name}    ${site_name}
    Go to                   ${url}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${name}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element display on screen                 ${MESSAGE_CONVERSATION_IMAGE_MEDIA}
    capture page screenshot
    Delete dynamic content collection               ${collection_name}
    Delete an Audience      ${audience_name}
    Delete a landing site/widget site               ${site_name}
    Delete a Conversation                           ${conversation_name}


Widget - Check if Dynamic content is displayed right after Group question if it matches the audience builder with rule = Group (OL-T17270)
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    ${audience_name}=       Add an Audience with targeting type             Group                   Is                      ${group_a}
    Click on span text      Candidate Assistant Responses
    wait for page load successfully v1
    Click at                ${CANDIDATE_ASSISTANT_RESPONSES_DYNAMIC_CONTENT}
    ${collection_name}=     Create dynamic content collection               ${audience_name}        Image/GIF
    ${conversation_name}=                           Add Multiple Path conversation                  Multiple Path
    Go to edit conversation                         ${conversation_name}
    Check element display on screen                 ${QUESTION_BOX}
    Click on span text      Edit groups
    wait until element is visible                   ${MULTIPLE_PATH_EDIT_GROUP_DIALOG_TITLE}
    Click at                ${MULTIPLE_PATH_SELECT_GROUP_DROPDOWN}          0
    wait until element is visible                   ${MULTIPLE_PATH_SEARCH_GROUP_BOX}
    input into              ${MULTIPLE_PATH_SEARCH_GROUP_BOX}               ${group_a}
    ${web_locator} =        Format string           ${MULTIPLE_PATH_SEARCH_RESULT}                  0                       ${group_a}
    Click at                ${web_locator}
    Click at                ${MULTIPLE_PATH_SELECT_GROUP_DROPDOWN}          1
    wait until element is visible                   ${MULTIPLE_PATH_SEARCH_GROUP_BOX}
    input into              ${MULTIPLE_PATH_SEARCH_GROUP_BOX}               ${group_b}
    ${web_locator} =        Format string           ${MULTIPLE_PATH_SEARCH_RESULT}                  1                       ${group_b}
    Click at                ${web_locator}
    Click at                ${MULTIPLE_PATH_CANCEL_SAVE_BUTTON}             Save
    Public the conversation
    ${site_name}=           Create landing site/widget site                 Landing Site
    Assign the conversation to the landing site/widget site                 ${conversation_name}    ${site_name}
    Go to Web Management
    ${url}=                 Get Landing Site shortened URL                  ${site_name}
    Go to                   ${url}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${name}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_IMAGE_MEDIA}
    Check element display on screen                 ${MESSAGE_CONVERSATION_OLIVIA_REPLY}            Can you please provide me with your mobile phone number
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${phone}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_IMAGE_MEDIA}
    Check element display on screen                 ${MESSAGE_CONVERSATION_OLIVIA_REPLY}            Please select one of the following areas of interest
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   1
    Click at                ${CONVERSATION_SEND_BUTTON}
    Check element display on screen                 ${MESSAGE_CONVERSATION_IMAGE_MEDIA}
    capture page screenshot
    Delete dynamic content collection               ${collection_name}
    Delete an Audience      ${audience_name}
    Delete a landing site/widget site               ${site_name}
    Delete a Conversation                           ${conversation_name}


Widget - Check if Dynamic content is displayed when it matches audience builder rule = Assigned Location (OL-T17272)
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    ${audience_name}=       Add an Audience with targeting type             Assigned Location       Is any of               ${location_name_1}
    Click on span text      Candidate Assistant Responses
    wait for page load successfully v1
    Click at                ${CANDIDATE_ASSISTANT_RESPONSES_DYNAMIC_CONTENT}
    ${name_collection}=     Create dynamic content collection               ${audience_name}        Video
    ${name_conversation}=                           Add Single conversation                         Single Path
    go to conversation builder
    Search Conversation in Conversation Builder     ${name_conversation}
    Click at                ${ROW_CONVERSATION_NAME}                        ${name_conversation}
    when Select multiple locations at Available locations                   ${location_name_1}      ${location_name_2}
    Public the conversation
    ${site_name}=           Create landing site/widget site                 Landing Site
    ${url}=                 Assign the conversation to the landing site/widget site                 ${name_conversation}    ${site_name}
    Go to                   ${url}
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${name}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${phone}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${age}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${like}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   1
    Click at                ${CONVERSATION_SEND_BUTTON}
    Check element display on screen                 ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    capture page screenshot
    Delete dynamic content collection               ${name_collection}
    Delete an Audience      ${audience_name}
    Delete a landing site/widget site               ${site_name}
    Delete a Conversation                           ${name_conversation}


Widget - Check if Dynamic content is displayed at the the end of conversation in case it matches the audience build at the beginning of conversation (OL-T4865)
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_COMMON}
    ${audience_name}=       Add an Audience with targeting type             Detected Location       Is                      ${location_name}
    Click on span text      Candidate Assistant Responses
    wait for page load successfully v1
    Click at                ${CANDIDATE_ASSISTANT_RESPONSES_DYNAMIC_CONTENT}
    ${name_collection}=     Create dynamic content collection               ${audience_name}        Video
    ${name_conversation}=                           Add Single conversation                         Single Path
    ${site_name}=           Create landing site/widget site                 Landing Site
    ${url}=                 Assign the conversation to the landing site/widget site                 ${name_conversation}    ${site_name}
    Go to                   ${url}
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${name}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${phone}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${age}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element not display on screen             ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    input into              ${CONVERSATION_INPUT_TEXTBOX}                   ${like}
    Click at                ${CONVERSATION_SEND_BUTTON}
    wait for olivia reply
    Check element display on screen                 ${MESSAGE_CONVERSATION_VIDEO_MEDIA}
    capture page screenshot
    Delete dynamic content collection               ${name_collection}
    Delete an Audience      ${audience_name}
    Delete a landing site/widget site               ${site_name}
    Delete a Conversation                           ${name_conversation}
