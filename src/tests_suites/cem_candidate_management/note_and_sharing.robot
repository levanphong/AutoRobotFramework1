*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/users_roles_permissions_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test
Documentation       Create 3 user:    User1 OL-T5926,    User2 OL-T5926,    User3 OL-T5926

*** Variables ***
${user_name_1}      User1 OL-T5926
${user_name_2}      User2 OL-T5926
${user_name_3}      User3 OL-T5926

*** Test Cases ***
Clicking @ button on the Notes modal (OL-T5915)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Click at    ${CEM_NOTE_TAB}
    Check element display on screen     ${CEM_INTERNAL_NOTE_TITLE}      Internals Notes
    Check element display on screen     ${CEM_ADD_A_NOTE_TEXTBOX}
    input into      ${CEM_ADD_A_NOTE_TEXTBOX}       @
    # check '@' is shown on the Notes modal
    Verify text contain     ${CEM_ADD_A_NOTE_TEXTBOX}       @
    # check suggestion user is shown
    Check element display on screen     ${CEM_NOTE_MENTION_USER_LIST}
    capture page screenshot
    ${name_list}=       Get elements and convert to list    ${CEM_NOTE_MENTION_USER_ITEM}
    # Check the user suggestion dropdown in alphabetical order is shows on the Note modal
    ${name_list_origin}=    copy list       ${name_list}
    Sort List       ${name_list}
    Lists Should Be Equal       ${name_list}    ${name_list_origin}
    capture page screenshot
    # Check the user suggestion dropdown is a list of all users in the company with dropdown format is #user-fullname
    Check the user suggestion dropdown is correct format with full username     @{name_list}
    capture page screenshot


Sharing candidate to mutiple users (OL-T5926)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CEM page
    Open Share Candidate box
    # Check users dropdown list is shown when typing email or phone number of user.
    ${phone}=       Set variable    +84
    input into      ${CEM_CANDIDATE_SHARE_MODAL_PEOPLE_BOX}     @${phone}
    Check suggestion user display       email_or_phone= ${phone}
    capture page screenshot
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_SUGGESTION_USER_PHONE_EMAIL}    ${phone}
    ${email}=       set variable    olivia.automation+ca@paradox.ai
    input into      ${CEM_CANDIDATE_SHARE_MODAL_PEOPLE_BOX}     @${email}
    Check suggestion user display       email_or_phone= ${email}
    capture page screenshot
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_SEND_CANCEL_BUTTON}     Cancel
    # only 1 user is added to share
    Open Share Candidate box
    Add a username into People box      ${user_name_1}
    Check UI of Share Candidate box after input username    1       ${user_name_1}
    # 2 user is added to share
    Add a username into People box      ${user_name_2}
    Check UI of Share Candidate box after input username    2       ${user_name_1}      ${user_name_2}
    # 3 user is added to share
    Add a username into People box      ${EE_TEAM}
    Check UI of Share Candidate box after input username    3       ${user_name_1}      ${user_name_2}      ${EE_TEAM}
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_SEND_CANCEL_BUTTON}     Cancel
    Open Share Candidate box
    Input into Share Candidate box      ${EE_TEAM}      Keep message private between you    ${SHARE_CONTENT_MESSAGE_2}
    # Check msg will send to added user via user's email.
    Verify user has received the email      ${SUBJECT_EMAIL}    ${SHARE_CONTENT_MESSAGE_2}
    capture page screenshot


Update Sharing candidate to user (OL-T5925)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CEM page
    ${candidate_name}=      Add a Candidate
    ${candidate_name1}=     Add a Candidate
    ${candidate_name2}=     Add a Candidate
    # Choose an candidate
    Search and click candidate on CEM       ${candidate_name}
    Open Share Candidate box
    Add a username into People box      ${user_name_1}
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_SEND_CANCEL_BUTTON}     Cancel
    Open Share Candidate box
    # Add a user into Share box
    Add a username into People box      ${user_name_2}
    Check UI of Share Candidate box after input username    1       ${user_name_2}
    capture page screenshot
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_SEND_CANCEL_BUTTON}     Cancel
    #case 1: user selects option ‘Include message on internal notes’ and add message in 'Add message' box.
    Open Share Candidate box
    Input into Share Candidate box      ${user_name_2}      Include message on internal notes       ${SHARE_CONTENT_MESSAGE_1}
    Switch user account and check UI Note Internal when selects option 1    ${user_name_2}      ${candidate_name}       ${SHARE_CONTENT_MESSAGE_1}
    #case 2: user selects option ‘Include message on internal notes’ and haven't added message in 'Add message' box.
    Switch to user      ${TEAM_USER}
    Search and click candidate on CEM       ${candidate_name1}
    Open Share Candidate box
    Input into Share Candidate box      ${user_name1}       Include message on internal notes
    Switch user account and check UI Note Internal when selects option 1    ${user_name1}       ${candidate_name1}
    #case 3: user selects option "Keep message private between you and #user-firstname" and add message to the Message box.
    Switch to user      ${TEAM_USER}
    Search and click candidate on CEM       ${candidate_name2}
    Open Share Candidate box
    Input into Share Candidate box      ${EE_TEAM}      Keep message private between you    ${SHARE_CONTENT_MESSAGE_3}
    # Check msg will send to added user via user's email.
    Verify user has received the email      ${SUBJECT_EMAIL}    ${SHARE_CONTENT_MESSAGE_3}
    Switch user account and check UI Note Internal when selects option 2    ${EE_TEAM}      ${candidate_name2}      ${SHARE_CONTENT_MESSAGE_3}


Update add Note for user (OL-T5924, OL-T5914)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to CEM page
    ${candidate_name3}=     Add a Candidate
    Click on candidate name     ${candidate_name3}
    # Mention user A
    Mention a user into note    ${user_name_1}
    Edit a note     ${user_name_1}      ${user_name_3}
    Switch to user      ${user_name_3}
    Check element display on screen     ${CEM_CANDIDATE_NAME}       ${candidate_name3}
    capture page screenshot
    Switch to user      ${user_name_1}
    Check element display on screen     ${CEM_CANDIDATE_NAME}       ${candidate_name3}
    capture page screenshot
    Switch to user      ${TEAM_USER}
    Edit a note     current_user_name=${user_name_3}    note_message=${NOTE_CONTENT}
    Switch to user      ${user_name_3}
    Check element display on screen     ${CEM_CANDIDATE_NAME}       ${candidate_name3}
    capture page screenshot

*** Keywords ***
Switch user account and check UI Note Internal when selects option 1
    [Arguments]     ${user_name}        ${candidate_name}       ${content_message}=None
    IF      '${content_message}'!='None'
        Check element display on screen                 ${CEM_CANDIDATE_INTERNAL_NOTE_CONTENT}          ${content_message}
    ELSE
        Check element not display on screen                 ${CEM_CANDIDATE_INTERNAL_NOTE_CONTENT}          ${content_message}
    END
    capture page screenshot
    Switch to user          ${user_name}
    Load more item in page                          ${candidate_name}        ${CEM_OPEN_CANDIDATE_CONV}
    ${is_clicked} =         Run keyword and return status                   Click at                ${candidate_name}
    should be true          ${is_clicked}
    IF      '${content_message}'!='None'
        Check element display on screen                 ${CEM_CANDIDATE_INTERNAL_NOTE_CONTENT}          ${content_message}
    ELSE
        Check element not display on screen                 ${CEM_CANDIDATE_INTERNAL_NOTE_CONTENT}          ${content_message}
    END
    capture page screenshot

Switch user account and check UI Note Internal when selects option 2
    [Arguments]     ${user_name}        ${candidate_name}       ${content_message}=None
    Switch to user           ${user_name}
    Load more item in page                          ${candidate_name}      ${CEM_OPEN_CANDIDATE_CONV}
    ${is_clicked} =         Run keyword and return status                   Click at                ${candidate_name}
    should be true          ${is_clicked}
    Check element not display on screen             ${CEM_CANDIDATE_INTERNAL_NOTE_CONTENT}          ${content_message}
    Check element display on screen                 ${CEM_CANDIDATE_PRIVATE_SHARE_MESSAGE}          ${user_name}
    capture page screenshot

Check the user suggestion dropdown is correct format with full username
    [Arguments]     @{name_list}
    FOR     ${i}    IN      @{name_list}
        @{split_name}=      split string    ${i}    ${SPACE}
        ${count}=       Get length      ${split_name}
        should be true      ${count}>=2
    END
