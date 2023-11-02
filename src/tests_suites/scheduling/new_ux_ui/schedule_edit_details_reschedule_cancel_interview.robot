*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/all_candidates_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/interview_prep_page.robot
Resource            ../../../pages/round_robin_management_page.robot
Resource            ../../../pages/my_calendar_page.robot
Resource            ../../../pages/conversation_page.robot
Resource            ../../../pages/message_customize_page.robot
Resource            ../../../pages/recorded_interview_builder_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg     lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${full_user}    FullUser Automation

*** Test Cases ***
Verify UI of Update Interview modal within Interview Pending (OL-T15225)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button   EN Team     Phone Interview     Let Olivia Schedule
    Select a candidate and click update link on CEM     ${candidate_name}
    capture page screenshot
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_INTERVIEW_TYPE}   phone interview
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_INTERVIEWER_NAME}     EN Team
    capture page screenshot
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    capture page screenshot
    Cancel a interview


Verify UI of Update Interview modal within Interview Scheduled (OL-T15226)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate   is_spam_email=False
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button    Test Reschedule    Phone Interview     Let Olivia Schedule
    Click button in email       would like to schedule      ${candidate_name}      WOULD_LIKE_SCHEDULE_PHONE_ITV
    Select time slot options
    Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}
    Check element display on screen     You should expect a call on this number.
    capture page screenshot
    Select a candidate and click update link on CEM     ${candidate_name}
    Check the modal display 3 buttons: Edit Interview, Reschedule and Cancel Interview
    Cancel a interview


Verify UI of Update Interview Modal within Sequential Interview In-Order Times (OL-T15227,OL-T15228)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Inorder1 Edit      Inorder2 Edit
    Send interview and click close button
    Click button in email      would like to schedule      ${candidate_name}
    Select time slot options
    check element display on screen      I've informed ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    capture page screenshot
    Select a candidate and click update link on CEM     ${candidate_name}
    Check the modal display 3 buttons: Edit Interview, Reschedule and Cancel Interview
    Cancel a interview


Verify all reschedule functionality will remain the same for single interview (OL-T15229)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate   is_spam_email=False
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button    Hiring Team     Phone Interview     Let Olivia Schedule
    Click button in email      would like to schedule      ${candidate_name}    WOULD_LIKE_SCHEDULE_PHONE_ITV
    Select time slot options
    Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}
    wait with medium time
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    check span display      Phone Interview
    check span display      Hiring Team
    capture page screenshot
    Send interview and click close button
    Click on candidate name      ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Cancel a interview


Verify all reschedule functionality will remain the same for Sequential interview In-order/Any order (OL-T15230)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Inorder1 Edit      Inorder2 Edit
    Select Determine Scheduling Approach    Consecutive In-Order
    Send interview and click close button
    Click button in email      would like to schedule      ${candidate_name}
    Select time slot options
    check element display on screen     I've informed ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    capture page screenshot
    wait with medium time
    Select a candidate and click update link on CEM     ${candidate_name}
    click at    ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    Check the modal should view the same interview builder in new UI
    Send interview and click close button
    Verify user has received the email    Your sequential interview    ${candidate_name}      SEQUENTIAL_UPDATE


Verify all reschedule functionality will remain the same for Sequential interview multiple days (OL-T15231)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Multiple1 Edit      Multiple2 Edit
    Select Determine Scheduling Approach    Schedule Over Multiple Days
    Send interview and click close button
    Click View more button in email       would like to schedule      ${candidate_name}      SEQUENTIAL_INTERVIEW      index_button=1
    Select time for interview with multiple days
    check element display on screen     I've informed all attendees and confirmed your interviews.
    capture page screenshot
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    Verify element is disable       ${FIND_TIMES_BUTTON}
    capture page screenshot
    Edit detail interview
    Send interview and click close button
    Verify user has received the email    Your sequential interview    ${candidate_name}      SEQUENTIAL_UPDATE


Verify the interview has no changed when user cancel reschedule interview (OL-T15232)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate   is_spam_email=False
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button    FS Team     Phone Interview     Let Olivia Schedule
    Click button in email      would like to schedule      ${candidate_name}    WOULD_LIKE_SCHEDULE_PHONE_ITV
    Select time slot options
    Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}
    check element display on screen      I've informed ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    capture page screenshot
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    Click at    ${SCHEDULE_MODULE_CLOSE_MODULE_BUTTON}
    check element display on screen     ${SCHEDULE_MODULE_EXIT_BUTTON}
    capture page screenshot
    Click at    ${SCHEDULE_MODULE_EXIT_BUTTON}
    check element not display on screen     ${SCHEDULE_MODAL}
    capture page screenshot
    Select a candidate and click update link    ${candidate_name}
    Cancel a interview


Verify users should be able to edit interview details from the “Edit Interview” button when status is Interview Pending (OL-T15233)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate      is_spam_email=False
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button    Recruiter Team    Virtual Interview     Let Olivia Schedule
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    Click at    ${ICON_REMOVE_INTERVIEWER_LOCATOR}      1
    when select attendes when for sub interview    EE Team
    click at    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_POS_BTN}       Send New Times
    check span display      Interview Pending
    capture page screenshot
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Click button in email   would like to schedule      ${candidate_name}   WOULD_LIKE_SCHEDULE_VIRTUAL_ITV
    Select time slot options
    wait with large time
    Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}
    wait with large time
    Select a candidate and click update link on CEM     ${candidate_name}
    Cancel a interview


Verify users should be able to edit interview details from the “Edit Interview” button when status is Interview Scheduled (OL-T15234)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate       is_spam_email=False
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button    Supervisor Team     Phone Interview     Let Olivia Schedule
    Click button in email      would like to schedule      ${candidate_name}    WOULD_LIKE_SCHEDULE_PHONE_ITV
    Select time slot options
    Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}
    check element display on screen      You should expect a call on this number.
    capture page screenshot
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    check element display on screen     All interview details can be edited except time based information. These sections are disabled and require a reschedule to be updated.
    Verify element is disable       ${DURATION_INPUT}
    capture page screenshot
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Then Check toogles are disabled at Setting section
    Choose interview type    Virtual Interview
    click at    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_POS_BTN}       Save Changes
    check element display on screen     Interview Changes Saved
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    wait with medium time
    Select a candidate and click update link on CEM     ${candidate_name}
    capture page screenshot
    Cancel a interview


Verify user can cancel interview request from CEM (OL-T15235,OL-T15236)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate   is_spam_email=False
    Click on candidate name      ${candidate_name}
    Open schedule module, select attendes , interview type and click schedule button    FO Team    Phone Interview     Let Olivia Schedule
    Click button in email      would like to schedule      ${candidate_name}    WOULD_LIKE_SCHEDULE_PHONE_ITV
    Select time slot options
    Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    check element display on screen     ${CANCEL_INTERVIEW_MODAL}
    capture page screenshot
    Click at    ${CANCEL_INTERVIEW_NEVER_MIND_BUTTON}
    check element not display on screen     ${CANCEL_INTERVIEW_MODAL}
    capture page screenshot
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    Click at    ${CANCEL_INTERVIEW_CONFIRM_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}


Verify user can cancel sequential interview with in-order/any order when status is interview scheduled (OL-T15237)
    Given Setup test
    When Login into system with company      ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Inorder1 Edit      Inorder2 Edit
    Select Determine Scheduling Approach      Consecutive In-Order
    Send interview and click close button
    Click button in email      would like to schedule      ${candidate_name}
    Select time slot options
    wait with medium time
    check element display on screen      I've informed ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    capture page screenshot
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    check element display on screen     ${CANCEL_INTERVIEW_MODAL}
    capture page screenshot
    Click at    ${CANCEL_INTERVIEW_CONFIRM_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    capture page screenshot


Verify UI of cancel sequential interview modal within multiple days (OL-T15238,OL-T15239)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Multiple1 Edit      Multiple2 Edit
    Select Determine Scheduling Approach    Schedule Over Multiple Days
    Click at    ${FIND_TIMES_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Click View more button in email      would like to schedule      ${candidate_name}      SEQUENTIAL_INTERVIEW      index_button=1
    Select time for interview with multiple days
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    Verify element is disable       ${CANCEL_MULTIPLE_INTERVIEW_BUTTON}
    Check number scheduling interview  2
    capture page screenshot
    Check User can not update detail of sub-interview
    Check Prep & Instructions and Settings will be hidden
    Select 2 sub-interview
    Element Should Be Enabled       ${CANCEL_MULTIPLE_INTERVIEW_BUTTON}
    Click at    ${CANCEL_MULTIPLE_INTERVIEW_BUTTON}
    Click at    ${CANCEL_INTERVIEW_CONFIRM_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    capture page screenshot


Verify User can cancel individual interviews in sequential interview multiple days (OL-T15240,OL-T15241)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Multiple1 Edit      Multiple2 Edit
    Select Determine Scheduling Approach    Schedule Over Multiple Days
    Click at    ${FIND_TIMES_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Click View more button in email       would like to schedule      ${candidate_name}      SEQUENTIAL_INTERVIEW      index_button=1
    Select time for interview with multiple days
    Select a candidate and click update link on CEM     ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    Click at    ${INTERVIEW_DETAILS_EXPAND_ICON}      1
    Check User can not update detail of sub-interview
    Select 2 sub-interview
    Click at    ${CANCEL_MULTIPLE_INTERVIEW_BUTTON}
    Check confirm modal will appear and allow users to customize the cancellation message


Verify the confirm 'Exit scheduling' modal will display when User has changed information and clicks on the X icon (OL-T15242)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate
    Click on candidate name      ${candidate_name}
    open schedule module
    Click at    ${SCHEDULE_MODULE_CLOSE_MODULE_BUTTON}
    check element display on screen     ${SCHEDULE_MODULE_EXIT_SCHEDULING_MODAL}
    capture page screenshot
    Click at    ${SCHEDULE_MODULE_NEVER_MIND_BUTTON}
    check element display on screen     ${SCHEDULE_MODULE_CONFIRM_EXIT_SCHEDULING}
    capture page screenshot
    Click at    ${SCHEDULE_MODULE_CLOSE_MODULE_BUTTON}
    click at    ${SCHEDULE_MODULE_EXIT_BUTTON}
    check element not display on screen     ${SCHEDULE_MODULE_CONFIRM_EXIT_SCHEDULING}
    capture page screenshot


Verify the confirm 'Exit scheduling' modal will display when User has changed information and clicks on outside of the scheduling drawer (OL-T15243)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate
    Click on candidate name      ${candidate_name}
    open schedule module
    check element display on screen     ${SCHEDULE_AN_INTERVIEW_ADD_INTERVIEW}
    capture page screenshot
    Press Keys    None    ESC
    check element display on screen     ${SCHEDULE_MODULE_EXIT_SCHEDULING_MODAL}
    capture page screenshot
    Click at    ${SCHEDULE_MODULE_NEVER_MIND_BUTTON}
    check element display on screen     ${SCHEDULE_MODULE_CONFIRM_EXIT_SCHEDULING}
    capture page screenshot
    Click by JS    ${SCHEDULE_MODULE_CLOSE_MODULE_BUTTON}
    click at    ${SCHEDULE_MODULE_EXIT_BUTTON}
    check element not display on screen     ${SCHEDULE_MODULE_CONFIRM_EXIT_SCHEDULING}
    capture page screenshot


Verify logic for Olivia Recorded Interviews will work correctly (OL-T15244)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    go to CEM page
    Switch to user      EE Team
    Go to Recorded Interview Builder Interviews page
    ${interview_record_name}=   Create a new Recorded Interview
    go to CEM page
    ${candidate_name}=    Add a Candidate   is_spam_email=False
    open schedule module
    Click on candidate name      ${candidate_name}
    Click at    ${OLIVIA_RECORDED_INTERVIEW_BUTTON}
    Click at    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_DROPDOWN}
    Check UI of schedule modal will be updated to match the new UI pattern UI
    click by JS    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_DROPDOWN_OPTION}    ${interview_record_name}
    Click at    ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_SEND_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    Click View more button in email       Interview Request from     ${candidate_name}
    check element display on screen     This is sample question?
    capture page screenshot
    Check logic for Olivia Recorded Interviews work correctly
    Go to Recorded Interview Builder Interviews page
    Delete a Recorded Interview     ${interview_record_name}

*** Keywords ***
Check the modal display 3 buttons: Edit Interview, Reschedule and Cancel Interview
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    check element display on screen     ${ALL_CANDIDATES_SCHEDULE_RESCHEDULE_INTERVIEW_BUTTON}
    capture page screenshot

Cancel a interview
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CONFIRM_BUTTON}
    wait with medium time
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}

Check the modal should view the same interview builder in new UI
    check element display on screen     Interview Summary
    check span display      Interview Details
    check span display      Settings
    check span display      Interview Type
    check label display     Determine Scheduling Approach
    capture page screenshot

Select a candidate and click update link
    [Arguments]     ${candidate_name}
    Go to CEM page
    Click on candidate name      ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    [Return]    ${candidate_name}

Edit detail interview
    Clear element text with keys    ${NAME_INTERVIEWER_INPUT}       1
    ${name_changed}=     Generate random name only text      Name
    Input into     ${NAME_INTERVIEWER_INPUT}     ${name_changed}      1
    capture page screenshot
    check element display on screen     (Edited)
    Click at    ${SELECT_SUB_INTERVIEWER_CHECKBOX}      1
    check element display on screen     ${FIND_TIMES_BUTTON}
    Click at    ${SELECT_SUB_INTERVIEWER_CHECKBOX}      2
    check span display      Reschedule 2 Interviews
    capture page screenshot

Check toogles are disabled at Setting section
    Verify element is disable       ${SCHEDULING_TIMELINES_TOGGLE_INPUT}
    Verify element is disable       ${LIMIT_RESCHEDULING_INTERVIEWS_TOGGLE_INPUT}
    Verify element is disable       ${HAVE_ATTENDEE_SCHEDULE_INTERVIEW_TOGGLE_INPUT}
    capture page screenshot

Check Prep & Instructions and Settings will be hidden
    Verify attribute should contain     class    is-disabled    ${PREP_AND_INSTRUCTIONS_TEXT}
    Verify attribute should contain     class    is-disabled    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    capture page screenshot

Check User can not update detail of sub-interview
    verify element is disable       ${SCHEDULE_AN_INTERVIEW_INV_TYPE}
    verify element is disable       ${DURATION_DROPDOWN_INDEX}
    capture page screenshot

Select 2 sub-interview
    Click at    ${SELECT_SUB_INTERVIEWER_CHECKBOX}      1
    capture page screenshot
    Click at    ${SELECT_SUB_INTERVIEWER_CHECKBOX}      2
    capture page screenshot

Close schedule modal
    Click at    ${FIND_TIMES_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}

Open schedule module, select attendes , interview type and click schedule button
    [Arguments]     ${user_name}    ${interview_type}      ${name_button}
    open schedule module
    when select attendes when for sub interview    ${user_name}
    when Choose interview type    ${interview_type}
    when click on positive button    ${name_button}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}

Check confirm modal will appear and allow users to customize the cancellation message
    Check element display on screen     ${CANCEL_INTERVIEW_MODAL}
    Clear element text with keys      ${CANCEL_INTERVIEW_MODAL_TEXTAREA}
    Input into    ${CANCEL_INTERVIEW_MODAL_TEXTAREA}        Customize message
    Click at    ${CANCEL_INTERVIEW_CONFIRM_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}

Check UI of schedule modal will be updated to match the new UI pattern UI
    check element display on screen     ${SCHEDULE_TO_OLIVIA_RECORDED_INTERVIEW_DROPDOWN}
    check span display      Schedule to Olivia Recorded Interview
    check span display      Interview Types
    capture page screenshot

Check logic for Olivia Recorded Interviews work correctly
    ${path_image} =    get_path_upload_video_path    schedule-recorder
    ${element} =    Get Webelement    ${CONVERSATION_INPUT_VIDEO}
    #delete class name of tagname
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('class', '')
    ...    ARGUMENTS    ${element}
    #delete css style of tagname
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style', '');
    ...    ARGUMENTS    ${element}
    Input into    ${CONVERSATION_INPUT_VIDEO}    ${path_image}
    capture page screenshot
