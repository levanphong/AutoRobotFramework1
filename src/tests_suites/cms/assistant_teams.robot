*** Settings ***
Documentation       Run datatest for first time
...                 robot src/data_tests/cms/cms_assistant_data_test.robot

Resource            ../../pages/cms_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../constants/CMSAssistantConst.py

Suite Teardown      Close All Browsers
Test Setup          Setup for every Test case
Test Teardown       Close Browser

Force Tags          regression    test


*** Variables ***
${prompt_text_message}=     Hi #user-firstname! I can help answer your questions


*** Test Cases ***
Verify Adding Assistant Indentity is success (OL-T4902, OL-T4903)
    [Documentation]
    ...    Precondition:
    ...    - Log in as Paradox Admin
    ...    - Go to Settings > CMS page
    ...    - Click on [AI Assistants] section
    ...    > [Candidate Assistant] tab
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_EVENT}
    Go to AI Assistants     Candidate Assistants
    # Click on [My Assistants] tab
    Click at                My Assistants
    # Click on [+ Add New Assistant] button
    Click at                ${MY_ASSISTANTS_ADD_NEW_ASSISTANT_BUTTON}
    # Enter require fields
    ${assistant_name}=      Enter all require fields    country=Australia    country_id=AU
    Capture Page Screenshot
    # Check Save button should be enable
    Element Should Be Enabled                       ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_SAVE_BUTTON}
    # when Click on [Save] button
    Click at                ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_SAVE_BUTTON}
    # Verify Close slide out and Add “Assistant Priority” as a new section
    Capture Page Screenshot
    Check element not display on screen             ${MY_ASSISTANTS_NEW_ASSISTANT_MODAL}
    Element Should Be Visible                       ${MY_ASSISTANTS_ASSISTANT_PRIORITY_SECTION}
    # when Assistant Identity added
    # Check display Header “Assistant Priority” and helper text “Drag and drop to reorder. Assistants will only show in specified locations.”
    Check text display      Assistant Priority
    Check span display      Drag and drop to reorder. Assistants will only show in specified locations.
    # Check Show the Assistant Identity’s name and the associated locations :
    # + Assistant Name and profile image
    Capture Page Screenshot
    Check element display on screen                 ${MY_ASSISTANTS_ITEM_TILE}                      ${assistant_name}
    Check element display on screen                 ${MY_ASSISTANTS_ITEM_AVATAR}                    ${assistant_name}
	# + Location
    ${location_locator}=    Format String           ${MY_ASSISTANTS_ITEM_CELL}                      ${assistant_name}       Australia
    Check element display on screen                 ${location_locator}
	# + Last Edited
    ${current_day}=         Evaluate                datetime.date.today().strftime("%b %d, %Y")
    ${last_edit_locator}=                           Format String           ${MY_ASSISTANTS_ITEM_CELL}                      ${assistant_name}       ${current_day}
    Check element display on screen                 ${last_edit_locator}
	# + On hover, show the grabber
    Hover at                ${MY_ASSISTANTS_ITEM_TILE}                      ${assistant_name}
    Check element display on screen                 ${MY_ASSISTANTS_ITEM_MENU_ICON_ELLIPSIS}        ${assistant_name}
    Capture Page Screenshot
	# + On hover, show ellipses and when clicked: Edit, Delete, Move Team ( if
	# the client has an Assistant team created )
    Click at                ${MY_ASSISTANTS_ITEM_MENU_ICON}                 ${assistant_name}
    Capture Page Screenshot
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_EDIT_BUTTON}
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_DELETE_BUTTON}
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_MOVE_BUTTON}
    # Delete Assistant
    click at                Assistant Priority
    Delete Assistant        ${assistant_name}
    Check element not display on screen    ${MY_ASSISTANTS_ITEM_TILE}    ${assistant_name}

Check if when Adding Identity in Employee Assistant tab (OL-T4926)
    [Documentation]
    ...    Precondition:
    ...    - Log in as Paradox Admin
    ...    - Go to Settings > CMS page
    ...    - Click on [AI Assistants] section
    ...    [Employee Assistant] tab
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_EVENT}
    Go to AI Assistants    Employee Assistants
    Click at                My Assistants
    # Click on [+ Add New Assistant] button
    Click at                ${MY_ASSISTANTS_ADD_NEW_ASSISTANT_BUTTON}
    # check show slide out: “Assistant Identity”
    Check span display      Assistant Identity
    # Check header "Overview"
    Check element display on screen                 ${MY_ASSISTANTS_NEW_ASSISTANT_OVERVIEW}
    # Check profile picture: empty state with profile icon , Add new 'Upload New Photo'
    Check element display on screen                 ${MY_ASSISTANTS_NEW_ASSISTANT_EMPTY_AVATAR}
    Check text display      Upload New Photo
    Capture Page Screenshot
    # Check Header “Assistant Name”: Prefilled helper text should be “Name”
    Check label display     Assistant Name
    Verify attribute value equal                    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_NAME_INPUT}                     placeholder             Name
    # Check Header “Widget Prompt Text”: Default text “Hi #user-firstname I can help answer your questions.”
    Verify display text     ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_PROMPT_TEXT}                    ${prompt_text_message}
    # Check Header “Where Can This Assistant Be Seen?” Prefilled text should be “Enter a Country, US State or US City”
    Check label display     Where Can This Assistant Be Seen?
    Verify attribute value equal                    ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_WHERE_INPUT}                    placeholder             Enter a Country, US State or US City
    # Check Cancel button: enable
    Element Should Be Enabled                       ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_CANCEL_BUTTON}
    # Check Save button: disabled until all fields are completed
    Click at                ${MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_SAVE_BUTTON}
    Check span display      Assistant Identity
    Capture Page Screenshot


Check if user is able to click on [Delete] button in Employee Assistant tab (OL-T4933, OL-T4947)
    [Documentation]
    ...    Precondition:
    ...    - Log in as Paradox Admin
    ...    - Go to Settings > CMS page
    ...    - Click on [AI Assistants] section
    ...    [Employee Assistant] tab
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_EVENT}
    Go to AI Assistants    Employee Assistants
    ${assistant_name}=      Create new Assistant
    # when Hovering on an Assistant
    Click at                ${MY_ASSISTANTS_ITEM_MENU_ICON}                 ${assistant_name}
    # Check Show an ellipsis menu : Edit, Delete, Move Teams
    Capture Page Screenshot
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_EDIT_BUTTON}
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_DELETE_BUTTON}
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_MOVE_BUTTON}
    # when Click on [Delete] button
    Click at                ${MY_ASSISTANTS_MENU_MODAL_DELETE_BUTTON}
    # Check Show Popup with trash icon and Modal Header “Confirm Removal of Assistant Identity”
    Check title popup display                       Confirm Removal of Assistant Identity
    # Check Message text “Are you sure you want to remove #ai-name?”
    Check text display      Are you sure you want to remove ${assistant_name}?
    # Check Remove & Cancel button
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_REMOVE_CONFIRM_BUTTON}
    Check element display on screen                 ${MY_ASSISTANTS_MENU_MODAL_REMOVE_CANCEL_BUTTON}
    # when User click cancel    Close the modal
    Click at                ${MY_ASSISTANTS_MENU_MODAL_REMOVE_CANCEL_BUTTON}
    Check element not display on screen             Confirm Removal of Assistant Identity
    # Open modal again
    Click at                ${MY_ASSISTANTS_ITEM_MENU_ICON}                 ${assistant_name}
    Click at                ${MY_ASSISTANTS_MENU_MODAL_DELETE_BUTTON}
    #    when User click remove
    Click at                ${MY_ASSISTANTS_MENU_MODAL_REMOVE_CONFIRM_BUTTON}                       ${assistant_name}
    # Check remove it from the Assistant Priority list
    Check element not display on screen             ${MY_ASSISTANTS_ITEM_TILE}                      ${assistant_name}

Check if detecting A.I Assistatnt team correctly base on Audience Builder with Page URL on Olivia_Start Intent and return correct anwser (OL-T4956, OL-T4959, OL-T4970)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate accesses the URL has been created
    # Check Detect IP candidate will show #ai_name & Avatar of AI match with IP
    Go to landing page with name and Check assistant name and image
    ...    ${CANDIDATE_CARE_ONLY_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}
    Candidate input to landing site    Start
    Check span display    ${CANDIDATE_ASSISTANT_NAME}
    Verify attribute value equal    ${CONVERSATION_HEADER_IMAGE}    alt    ${CANDIDATE_ASSISTANT_NAME}
    Verify display text    ${CONVERSATION_LATEST_MESSAGE}    ${RESPONSE_MESSAGE}

Check if detecting Default A.I Assistatnt correctly in case no Audience Builder with Page URL is assigned to Olivia_Start intent (OL-T4957)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate accesses the URL has been created
    # check Use default A.I Assistants for candidate's
    Go to landing page with name and Check assistant name and image
    ...    ${NOT_MATCH_AUDIENCE_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}

Check if detecting Default A.I Assistatnt correctly in case candidate access Page URL which doesn't match any Audience Builder on Olivia_Start intent (OL-T4958)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate accesses the URL has been created Which Doesn't match any Audience Builder on Olivia_Start intent
    # Check Use default A.I Assistants for candidate's
    Go to landing page with name and Check assistant name and image
    ...    ${AUSTRALIA_AUDIENCE_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}

Verify AI Assistant name in Conversation only (OL-T4969)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate chat
    # Check Detect IP candidate will show #ai_name & Avatar of AI match with IP
    Go to landing page with name and Check assistant name and image
    ...    ${CONVERSATION_ONLY_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}

Verify AI Assistant name in Job Search only (OL-T4972)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate accesses the URL has been created
    # when Candidate chat
    # Check Detect IP candidate will show #ai_name & Avatar of AI match with IP
    Go to landing page with name and Check assistant name and image
    ...    ${JOB_SEARCH_ONLY_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}

Verify AI Assistant name in Care AND Job Search (OL-T4973)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate accesses the URL has been created
    # when Candidate chat
    # Check Detect IP candidate will show #ai_name & Avatar of AI match with IP
    Go to landing page with name and Check assistant name and image
    ...    ${CANDIDATE_CARE__AND_JOB_SEARCH_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}

Verify AI Assistant name in Conversation AND Care (OL-T4974)
    [Documentation]
    ...    Precondition:
    ...    Create cadidate assistant success
    ...    Create lading site success
    # when Candidate chat
    # Check Detect IP candidate will show #ai_name & Avatar of AI match with IP
    Go to landing page with name and Check assistant name and image
    ...    ${CANDIDATE_CARE_AND_CONVERSATION_LANDING_SITE}
    ...    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}


*** Keywords ***
Setup for every Test case
    Open Chrome
    Setup test
