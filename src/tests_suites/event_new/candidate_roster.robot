*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../commons/common_keywords.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/workflows_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    lts_stg    olivia    regression    stg     test

Documentation       Turn on Interview Prep at Scheduling in Client setup
...                 Go to Interview Prep Page from Menu Setting create prep doc:
...                 Event_Prep_Candidate, Event_Prep2_Candidate, Event_Prep_User, Event_Prep2_User

*** Variables ***
${orientation}                      Orientation
${orientation_event}                Orientation Events
${roster_tab}                       Roster
${candidate_roster_tab}             Candidate Roster
${confirm_tab}                      Confirmation
${year_number}                      2022
${check_in_candidates_button}       Check-in Candidates
${orient_event_closed}              orient_event_roster_is_closed
${view_prep_documents_button}       View Prep Documents
${prep_documents_candidate}         Event_Prep_Candidate
${prep_documents_user}              Event_Prep_User
${new_location}                     auto_location_roster
${test_session}                     test_session_orient
${join_session_button}              Join Session

${group_name}                       Event_rooster_group
${location_name}                    Event Location
${workflow_send_comuni}             WF Event Send Comuni
${workflow_audience}                WF Event Switch Audience
${workflow_send_rating}             WF Event Send Rating
${location_contact}                 Location Contact

${location_name}                    Event Location
${la_location_id_single}            654321
${la_address_single}                460 Nguyen Huu Tho Street
${la_state_single}                  Alabama
${la_city_single}                   New York
${la_country}                       US
${la_zipcode_single}                10005

@{column_name_list}                 Name    Phone Number    Email    Job Name    Location    Attendance    Last Active
@{hour_before_list}                 72 Hours Before    48 Hours Before    24 Hours Before    1 Hour Before    Never
@{link_expired_hour_list}           72 Hours After the Event    48 Hours After the Event    24 Hours After the Event    1 Hour After the Event    Never
@{check_in_expired_hour_list}       72 Hours After the Event    48 Hours After the Event    24 Hours After the Event    1.5 Hours After the Event    1 Hour After the Event    Always
@{user_group_list}                  Event Managers    Event Ambassadors    Location Contact: Email Address    Location Point of Contact
@{text_display_list}                Set default user groups who should always receive the event    Customize when the event roster notification is sent to user    Customize when the event roster link will expire.    Determine when candidate check-in will automatically close.
@{strong_text_display_list}         Candidate Event Rosters     Orientation Event Candidate Check-in

*** Test Cases ***
User can search candidates in Candidate Roster modal (OL-T4739, OL-T4722, OL-T4723)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${FO_TEAM}
#   Verify Engagements Card in Event homepage (OL-T4722,OL-T4723)
    Check element display on screen     Engagements
    Check element display on screen     0 of 5 Configured
    Check element display on screen     Event Care
    Check element display on screen     ${view_prep_documents_button}
    Capture page screenshot
#   Verify User can search candidates (OL-T4739)
    Switch to user      ${FO_TEAM}
    Go to CEM page
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    ${candidate_name_2} =     Add a candidate to an orientation event     ${event_name}
    Go to event dashboard       ${event_name}
    Click at    ${roster_tab}
    wait for page load successfully
    Check element display on screen     ${ROSTER_SEARCH_CANDIDATES_INPUT}
    input into      ${ROSTER_SEARCH_CANDIDATES_INPUT}       ${candidate_name}
    Check element display on screen       ${COMMON_SPAN_TEXT}     ${candidate_name}
    Check element not display on screen       ${COMMON_SPAN_TEXT}     ${candidate_name_2}
    Capture page screenshot
    input into      ${ROSTER_SEARCH_CANDIDATES_INPUT}       test_search
    Check element display on screen         Zero candidates are scheduled for this event.
    Capture page screenshot


Verify Event Care slide out when clicking on Event Care button (OL-T4724, OL-T4726, OL-T4717)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${FO_TEAM}
    #   Verify empty state of Orientation Prep (OL-T4726, OL-T4717)
    Click at    ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_PREP_USER_TAB}
    Check element display on screen     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_USER_BUTTON}
    Check element display on screen     ${EVENT_ORIENT_NO_DOC_TO_REVIEW_USER_TEXT}
    Click at     ${EVENT_ORIENT_PREP_CANDIDATE_TAB}
    Check element display on screen     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_CANDIDATE_BUTTON}
    Check element display on screen     ${EVENT_ORIENT_NO_DOC_TO_REVIEW_CANDIDATE_TEXT}
    Capture page screenshot
    Click at     ${EVENT_ORIENT_DOC_PREP_CLOSE_BUTTON}
#   Verify Event Care slide out (OL-T4724)
    Click at    Event Care
    Check span display      Candidate Question
    Check span display      Olivia's Response
    Click at        ${EVENT_ORIENT_EVENT_CARE_CLOSE_BUTTON}
    Capture page screenshot


Verify Candidate Roster message is added to Message Customization - Users (OL-T4743)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    ${USER_TAB}
    Click at    ${candidate_roster_tab}
#    Verify Candidate Roster message is added
    Check span display      Email
    Check element display on screen      Orientation Events
    Check element display on screen      Candidate Roster Notification to selected individuals
    Check element display on screen      Subject
    Check element display on screen      Access your candidate roster now!
    Capture page screenshot


Verify Candidate Roster message is updated when user updates them (OL-T4744)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Go to tab in user or candidate label     ${USER_TAB}    ${candidate_roster_tab}
    Input text into message box on email tab        ${orientation_event}      Test_change_message_roster
    Click at    ${CLOSE_MODAL_ICON}
#    Verify Candidate Roster message is updated
    Go to tab in user or candidate label      ${USER_TAB}    ${candidate_roster_tab}
    Verify text contain     ${EMAIL_MESSAGE_CONTENT}    Test_change_message_roster      ${orientation_event}
    Capture page screenshot
    Return origin message on sms or email tab       ${orientation_event}        ${EMAIL_MESSAGE_CONTENT}


Verify Candidate Roster - Confirmation message is updated when user updates them (OL-T4754)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Go to tab in user or candidate label     ${CANDIDATE_TAB_ON_DIALOG}     ${confirm_tab}
    Input text into message box on sms tab      ${orientation_event}      Test_change_sms_message_confirm
    Input text into message box on email tab        ${orientation_event}      Test_change_email_message_confirm
    Click at    ${CLOSE_MODAL_ICON}
    Go to tab in user or candidate label     ${CANDIDATE_TAB_ON_DIALOG}     ${confirm_tab}
#    Verify Confirmation message is updated at SMS tab
    Click at    ${SMS_TAB}
    Verify text contain     ${SMS_MESSAGE_CONTENT}    Test_change_sms_message_confirm      ${orientation_event}
    Capture page screenshot
    Return origin message on sms or email tab       ${orientation_event}      ${SMS_MESSAGE_CONTENT}
#    Verify Confirmation message is updated at EMAIL tab
    Click at    ${EMAIL_TAB}
    Verify text contain     ${EMAIL_MESSAGE_CONTENT}    Test_change_email_message_confirm      ${orientation_event}
    Capture page screenshot
    Return origin message on sms or email tab       ${orientation_event}      ${EMAIL_MESSAGE_CONTENT}


Verify Candidate Roster slide out when clicking on Candidate Roster button on event homepage (OL-T4737)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${FO_TEAM}
    Switch to user      ${FO_TEAM}
    Go to CEM page
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    ${candidate_name_2} =     Add a candidate to an orientation event     ${event_name}
    Go to event dashboard       ${event_name}
    Click at    ${roster_tab}
    Check element display on screen       ${COMMON_SPAN_TEXT}     ${candidate_name}
    Check element display on screen       ${COMMON_SPAN_TEXT}     ${candidate_name_2}
    FOR     ${column_name}  IN      @{column_name_list}
        Check element display on screen     ${COMMON_DIV_TEXT}      ${column_name}
        Capture page screenshot
    END
    Check element display on screen     ${EVENT_ORIENT_ROSTER_ICON_CIRCLES}      ${candidate_name}
    Hover at    ${EVENT_ORIENT_ROSTER_ICON_CIRCLES}      ${candidate_name}
    Check element display on screen    ${EVENT_ORIENT_ROSTER_DATE_OF_EVENT}       ${year_number}
    Capture page screenshot


Verify Candidate Event Rosters is added when Orientation toggle is ON (OL-T4714, OL-T5047)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Navigate to    Client Setup
    Click at    ${EVENTS_LABEL}
    Turn off    ${ORIENTATION_ON_TOGGLE}
#   Verify Candidate Event Rosters is not shown (OL-T5047)
    FOR     ${strong_text_display}  IN      @{strong_text_display_list}
        Check element not display on screen     ${COMMON_STRONG_TEXT}      ${strong_text_display}       wait_time=3s
        Capture page screenshot
    END
    FOR     ${text_display}  IN      @{text_display_list}
        Check element not display on screen     ${COMMON_SPAN_TEXT}      ${text_display}        wait_time=3s
        Capture page screenshot
    END
    Turn on    ${ORIENTATION_ON_TOGGLE}
    FOR     ${strong_text_display}  IN      @{strong_text_display_list}
        Check element display on screen     ${COMMON_STRONG_TEXT}      ${strong_text_display}
        Capture page screenshot
    END
    FOR     ${text_display}  IN      @{text_display_list}
        Check Span Display     ${text_display}
        Capture page screenshot
    END
#   Verify Candidate Event Rosters are shown (OL-T4714)
    Click at        ${CLIENT_SETUP_INPUT_DEFAULT_USER_GROUPS}
    FOR     ${user_group}  IN      @{user_group_list}
       Check Span Display      ${user_group}
    END
    Capture page screenshot
    Press Keys    None   RETURN
#   Verify event roster hours is shown
    Check list items of event rosters hour      ${CLIENT_SETUP_EVENT_ROSTER_HOUR_BEFORE_INPUT}     ${hour_before_list}
    Press Keys    None   RETURN
#   Verify event roster hours is shown
    Check list items of event rosters hour      ${CLIENT_SETUP_EVENT_ROSTER_LINK_EXPIRED_HOUR_INPUT}     ${link_expired_hour_list}
    Press Keys    None   RETURN
#   Verify event roster check in expired hours is shown
    Check list items of event rosters hour      ${CLIENT_SETUP_EVENT_ROSTER_CHECK_IN_EXPIRED_HOUR_INPUT}     ${check_in_expired_hour_list}
    Press Keys    None   RETURN
    Capture page screenshot


User is not longer able to check-in candidates for the event when event has passed/canceled or meet setting in Client Setup (OL-T4738)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Add pre data
    ${event_name} =     Create orient event Virtual Single Event   ${FO_TEAM}
    Switch to user      ${FO_TEAM}
    Go to CEM page
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    Switch to user      ${TEAM_USER}
    Go to event dashboard       ${event_name}
    Click at    ${check_in_candidates_button}
    Check element display on screen     ${ORIENT_EVENT_CHECK_IN_INFO_CANDIDATE_NAME}     ${candidate_name}
    Check element display on screen     ${ORIENT_EVENT_CHECK_IN_BUTTON}
    Click at    ${ORIENT_EVENT_CLOSE_CHECK_IN_CANDIDATE_BUTTON}
    Cancel event from event list        ${event_name}
#   Verify User is not longer able to check-in candidates when event has passed/canceled
    Go to event dashboard       ${event_name}
    Click at    ${check_in_candidates_button}
    Check element not display on screen     ${ORIENT_EVENT_CHECK_IN_INFO_CANDIDATE_NAME}     ${candidate_name}
    Check element not display on screen     ${ORIENT_EVENT_CHECK_IN_BUTTON}
    Capture page screenshot
    Click at    ${ORIENT_EVENT_CLOSE_CHECK_IN_CANDIDATE_BUTTON}


Verify Event Registration card on General Event homepage (OL-T4756, OL-T4755)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${FO_TEAM}
    Switch to user      ${FO_TEAM}
    Go to CEM page
#   Add pre data
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    ${candidate_name_2} =     Add a candidate to an orientation event     ${event_name}
#   Verify Event Registration card for upcoming event (OL-T4756)
    Switch to user      ${TEAM_USER}
    Go to event dashboard       ${event_name}
    Verify Event Registration card  2
#   Verify Event Registration card for past event (OL-T4755)
    Go to Events page
    Click at    My Events
    Click at    Past Events
    wait for page load successfully
    Input into      ${SEARCH_EVENT_INPUT}    ${orient_event_closed}
    Click at        ${orient_event_closed}
    Verify Event Registration card  2
    Check element display on screen     Registration has Concluded
    Capture page screenshot


Verify setting icon on event homepage (OL-T4757)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Create orient event Virtual Single Event   ${FO_TEAM}
    Verify UI when click event setting icon
    Go to Events page
    Create hiring event has Virtual Chat Booth session
    Click at    ${DASH_BOARD_NAVIGATION}
    Verify UI when click event setting icon


Verify only Managers can add orientation prep on event homepage (OL-T4728, OL-T4720)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Verify user can create orientation event without Orientation Prep Documents (OL-T4720)
    ${event_name} =     Create orient event Virtual Single Event   ${FO_TEAM}
#   Verify Ambassador / Facilitator user can't add orientation prep
    Switch to user      ${FO_TEAM}
    Click at    ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_PREP_USER_TAB}
    Check element not display on screen     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_USER_BUTTON}
    Click at     ${EVENT_ORIENT_PREP_CANDIDATE_TAB}
    Check element not display on screen     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_CANDIDATE_BUTTON}
    Click at     ${EVENT_ORIENT_DOC_PREP_CLOSE_BUTTON}
    Capture page screenshot
#   Verify Managers can add orientation prep
    Switch to user      ${TEAM_USER}
    Click at     ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_USER_BUTTON}
    Add Prep Documents For Event    ${prep_documents_candidate}     ${prep_documents_user}
    Click at    ${EVENT_CONFIRM_AND_SAVE_BUTTON}
    Verify user add prep documents success      Candidate Documents     User Documents


Verify Candidate notifications email (OL-T4751, OL-T4748, OL-T4718)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    ${event_name} =     Create orient event Virtual Single Event   ${EE_TEAM}
#   Verify Schedule card (OL-T4748)
    Check element display on screen     ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}      Schedule
    Check span display      View Schedule
    Check span display      Next Session
    Check element display on screen     ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}      ${test_session}
    Check element display on screen     ${EVENT_DASHBOARD_SCHEDULE_CARD_CONTENT}      Virtual Event Session
    Click on span text      View Schedule
    Check element display on screen     ${SESSION_NAME_IN_CARD}     ${test_session}
#   Verify user can add Orientation Prep Documents (OL-T4718)
    Click at    Dashboard
    Click at     ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_USER_BUTTON}
    Add Prep Documents For Event    ${prep_documents_candidate}     ${prep_documents_user}
    Click at    ${EVENT_CONFIRM_AND_SAVE_BUTTON}
    Go to CEM page
    Switch to user      ${FO_TEAM}
    #   Verify Candidate receives the confirmed email and check  event agenda view on the event homepage. (OL-T4751)
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}     is_spam_email=False
    ${CONFIG} =    get_config    ${env}
    ${shorten_url} =    Set Variable    ${CONFIG.shorten_url}
    Click button in email    Your Orientation at ${COMPANY_EVENT}    Hi ${candidate_name}!     CONFIRM_ORIENTATION_EVENT   1   ${shorten_url}
    Click at      ${COMMON_LINK_TEXT}    My Event Agenda
    Check element display on screen     ${COMMON_DIV_TEXT}     ${test_session}
    Click at    ${COMMON_LINK_TEXT}     Orientation Prep Documents
    Check element display on screen     Candidate Documents
    Check element display on screen     ${COMMON_LINK_TEXT}   View Document


Verify user can edit candidate/user Orientation Prep Documents on the fly (OL-T4721, OL-T4725, OL-T4727)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Prepare data
    ${event_name} =     Create orient event Virtual Single Event   ${EE_TEAM}
    Click at     ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_ADD_ORIENTATION_PREP_USER_BUTTON}
    Add Prep Documents For Event    ${prep_documents_candidate}     ${prep_documents_user}
    Click at    ${EVENT_CONFIRM_AND_SAVE_BUTTON}
    Verify user add prep documents success      Candidate Documents     User Documents
#   Verify user can edit candidate/user Orientation Prep Documents (OL-T4721)
    Go to edit event page from dashboard
    Click at    ${EVENT_TOOLS_TEXT}
    Click at    ${EVENT_TOOL_CARD_TITLE}     Orientation Prep Documents
    Edit Prep Documents For Event    Event_Prep2_Candidate     Event_Prep2_User
    Click at    ${CONFIRM_SAVE_BUTTON}
    Verify user add prep documents success      Candidate2 Documents     User2 Documents
#   Verify View Prep Documents slide out for ambassador's view (OL-T4727)
    Switch to user      ${EE_TEAM}
    Verify user add prep documents success      Candidate2 Documents     User2 Documents
#   Verify View Prep Documents slide out when click View Documents button (OL-T4725)
    Click at     ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_PREP_CANDIDATE_TAB}
    Click at     ${EVENT_ORIENT_VIEW_DOC_PREP_CANDIDATE_BUTTON}
    Check new window contain expeted value on url    /media/itv-preps/      1


Verify Location Contact information in Location Management (OL-T4715)
    Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to location management page
    search location in location page      ${location_name}
    Click at       ${location_name}
    wait for page load successfully
    ${email_info} =    Get email for testing    is_spam_email=False
    Input into    ${LOCATION_EMAIL_TEXTBOX}    ${email_info.email}
    Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}
    Reload page
    Verify contact information is correctly     ${email_info.email}


Verify the candidate notification is added to Message Customization (OL-T4753)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
#   Verify Section
    Click at    Confirmation
#   Verify Message Header
    Check element display on screen     Orientation Events
#   Verify Message Subtitle
    Check element display on screen     Send Prep Documents & Agenda
#   Verify Message content
    Check element display on screen     You can view your agenda and any prep documents here
    Capture page screenshot


Verify Viewing Candidate Mini Profile when clicking on candidate's name on Candidate Roster (OL-T4740)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Prepare data
    ${event_name} =     Create orient event Virtual Single Event   ${EE_TEAM}
    Switch to user      ${EE_TEAM}
    Go to CEM page
    ${candidate_name} =     Add a candidate to an orientation event     ${event_name}
    Switch to user      ${TEAM_USER}
    Go to event dashboard       ${event_name}
    Click at     ${roster_tab}
    Click on span text     ${candidate_name}
    Verify Candidate Mini Profile     ${candidate_name}     ${EE_TEAM}      ${event_name}


Verify Webex Video when Video Provider toggle is OFF (OL-T4759)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Prepare data OL-T4759
    ${event_name} =     Create orient event Virtual Single Event   ${EE_TEAM}
    Go to edit event page from dashboard
    Go to edit session popup    ${test_session}
    Input into    ${SESSION_URL_TEXTBOX}    https://robotframework.org/
    Input into    ${SESSION_URL_PASS_TEXTBOX}    this_is_the_password
    Confirm and save event
#   Verify Session URL & password display when Video Provider toggle is OFF (OL-T4759)
    Check span display      this_is_the_password
    Click on span text      ${join_session_button}
    Capture page screenshot
    Click on span text      ${join_session_button}
    Check new window contain expeted value on url      robotframework.org      1


Verify Webex Video when creating event session for Orientation (OL-T4758)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Prepare data
    ${event_name} =     Create orient event Virtual Single Event   ${EE_TEAM}
    Go to edit event page from dashboard
    Go to edit session popup    ${test_session}
    Turn on    ${USE_WEB_EX_TOGGLE}
#   Verify the session URL field will appear disabled.
    element should be disabled     ${SESSION_URL_TEXTBOX}
    element should be disabled     ${SESSION_URL_PASS_TEXTBOX}
    Confirm and save event
#   Prepare data
    Go to edit event page from dashboard
    Go to edit session popup    ${test_session}
    ${url} =    Set variable    webex.com
    ${password} =    Get value and format text    ${SESSION_URL_PASS_TEXTBOX}
    Click at    ${EVENT_SESSION_POPUP_CLOSE_BUTTON}
#   Verify Webex video URL & password display
    Go to Events page
    Search and go to event homepage     ${event_name}
    Check span display      ${password}
    Click on span text      ${join_session_button}
    Capture page screenshot
    Click on span text      ${join_session_button}
    Check new window contain expeted value on url      ${url}      1


Work flow - Contact Location user receive communication (OL-T4761)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user    ${EE_TEAM}
    Go to CEM page
    ${candidate_name}=    Add a Candidate     ${group_name}     ${location_name}
    Verify user has received the email    Candidate roster send Communication       Send communication to user when ${candidate_name}       COMMUNICATION


Workflow - Switching audience builder (OL-T4793)
    #TODO https://paradoxai.atlassian.net/browse/OL-78345
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Workflows page
    Click by JS     ${workflow_audience}
    wait for page load successfully
#   Verify do not show confirmation poup when Switch audience from the Location contact to Candidate
    Change audience workflow     Candidate
    Check element not display on screen     ${WORKFLOW_CHANGE_AUDIENCE_CONFIRM_BUTTON}
    Capture page screenshot
#   Verify show confirmation poup when Switch audience from the Candidate to user role
    wait for page load successfully
    Change audience workflow     ${CP_ADMIN}
    Check element display on screen     ${WORKFLOW_CHANGE_AUDIENCE_CONFIRM_BUTTON}
    Capture page screenshot
    Click at     ${WORKFLOW_CHANGE_AUDIENCE_CONFIRM_BUTTON}
    wait for page load successfully
#   Return origin workflow for the next run test
    Change audience workflow     ${location_contact}
    Click at    ${WORKFLOW_LOCATION_CONTACT_INPUT}
    Input into      ${WORKFLOW_SEARCH_LOCATION_INPUT}    ${location_name}
    Click by JS    ${WORKFLOW_LOCATION_NAME_CHECKBOX}   ${location_name}
    Click at        ${COMMON_BUTTON}    Apply
    wait for page load successfully


Workflow - There is only the send communication action is available when audience builder is Location Contact (OL-T4787)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Workflows page
    Click by JS     ${workflow_audience}
    wait element visible    ${WORKFLOW_LANGUAGES_DROPDOWN}
    Click at    ${WF_ADD_TASK_BUTTON}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${ADD_TRIGGER_BUTTON}
#   Verify There is only the send communication action
    ${count} =    Get Element Count    ${WORKFLOW_TRIGGER_ACTION_NAME}
    should be equal as strings    ${count}    1
    Check element display on screen      ${SEND_COMMUNICATION_ACTION}
    Capture page screenshot


Workflow - Trigger actions for two new statuses: Event - Candidate checked in and Event - Candidate not checked in (OL-T4760)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
#   Prepare data
    ${event_name} =     Create orient event Virtual Single Event   ${EE_TEAM}
    Go to CEM page
    Switch to user      ${EE_TEAM}
    ${candidate_checked_in} =   Add a candidate to an orientation event      ${event_name}    ${group_name}   is_spam_email=False
    ${candidate_not_checked_in} =   Add a candidate to an orientation event      ${event_name}    ${group_name}   is_spam_email=False
    Go to Events page
#   Checked-in and not checked-in Cadidate and veriry receive email
    Search and go to event homepage     ${event_name}
    Click at    ${check_in_candidates_button}
    Click at    ${CHECKIN_CANDIDATE_BY_USER_BUTTON}       ${candidate_checked_in}
    Click at    ${CHECKIN_CANDIDATE_CLOSE_BUTTON}
    Click on span text      Close Check-In
    Verify user has received the email    workflow event ${candidate_checked_in}        Hi ${candidate_checked_in}. Please rate your experience.        RATING_REQUEST
    Verify user has received the email    workflow event ${candidate_not_checked_in}        Hi ${candidate_not_checked_in}. Please rate your experience.        RATING_REQUEST

*** Keywords ***
Input text into message box on email tab
    [Arguments]    ${interview_type}    ${text}
    ${email_messbox_locator} =    Format String    ${EMAIL_MESSAGE_CONTENT}    ${interview_type}
    Click at    ${EMAIL_TAB}
    Clear element text with keys     ${EMAIL_MESSAGE_CONTENT}    ${interview_type}
    input into    ${email_messbox_locator}      ${text}
    Press Keys    None    RETURN
    Click at    ${EVENT_SAVE_BUTTON_ON_MODAL}

Input text into message box on sms tab
    [Arguments]    ${interview_type}    ${text}
    ${email_messbox_locator} =    Format String    ${SMS_MESSAGE_CONTENT}    ${interview_type}
    Click at    ${SMS_TAB}
    Clear element text with keys     ${SMS_MESSAGE_CONTENT}    ${interview_type}
    input into    ${email_messbox_locator}      ${text}
    Press Keys    None    RETURN
    Click at    ${EVENT_SAVE_BUTTON_ON_MODAL}

Return origin message on sms or email tab
    [Arguments]    ${interview_type}    ${locator}
    Clear element text with keys    ${locator}    ${interview_type}
    run keyword and ignore error    Click at    ${EVENT_SAVE_BUTTON_ON_MODAL}     wait_time=5s

Go to tab in user or candidate label
    [Arguments]     ${name_label}   ${name_tab}
    Click at    ${EVENTS_TAB}
    Click at    ${name_label}
    Click at    ${name_tab}

Verify Event Registration card
    [Arguments]     ${total_number_candidate}
    Check element display on screen     Event Registration
    Check element display on screen     Registration Ends
    Check element display on screen     Candidates Scheduled
#   Veryfy number candidate can check-in
    Check span display      ${total_number_candidate}
    Check span display      Unlimited
    Capture page screenshot

Verify UI when click event setting icon
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Check span display      Edit Event
    Check span display      Duplicate Event
    Check span display      Last updated
    Check span display      by ${TEAM_USER}
    Capture page screenshot

Verify user add prep documents success
    [Arguments]     ${candidate_doc_content}    ${user_doc_content}
    Click at    ${view_prep_documents_button}
    Click at     ${EVENT_ORIENT_PREP_CANDIDATE_TAB}
    Check element display on screen     ${candidate_doc_content}
    Check element display on screen      ${EVENT_ORIENT_VIEW_DOC_PREP_CANDIDATE_BUTTON}
    Capture page screenshot
    Click at     ${EVENT_ORIENT_PREP_USER_TAB}
    Check element display on screen     ${user_doc_content}
    Check element display on screen      ${EVENT_ORIENT_VIEW_DOC_PREP_USER_BUTTON}
    Click at    ${EVENT_ORIENT_DOC_PREP_CLOSE_BUTTON}
    Capture page screenshot

Check value element is correctly
    [Arguments]     ${locator}   ${value_compare}
    ${text_get} =   get element attribute   ${locator}    value
    Should contain     ${text_get}     ${value_compare}

Verify contact information is correctly
    [Arguments]     ${email_test}
    Check value element is correctly    ${LOCATION_ID_TEXTBOX}      ${la_location_id_single}
    Check value element is correctly    ${ADDRESS_1_TEXTBOX}        ${la_address_single}
    Check value element is correctly    ${CITY_TEXTBOX}             ${la_city_single}
    Check value element is correctly    ${ZIPCODE_TEXTBOX}      ${la_zipcode_single}
    Check value element is correctly    ${LOCATION_EMAIL_TEXTBOX}      ${email_test}
    Check value element is correctly    ${LOCATION_PHONE_TEXTBOX}      ${CONST_PHONE_NUMBER}
    Capture page screenshot

Verify Candidate Mini Profile
    [Arguments]   ${candidate_name}     ${user}     ${event_name}
    Check strong text display       ${candidate_name}
    Check strong text display       ${user}
    Check span display      Conversation
    Check span display      About
    Check span display      Resume
    Check span display      Hire Details
    Check span display      Orientation
    Check element display on screen     ${COMMON_DIV_TEXT}      ${event_name}
    Capture page screenshot

Check new window contain expeted value on url
    [Arguments]     ${value_in_url}     ${index}
    ${window}=     Get Window Handles
    Switch Window   ${window}[${index}]
    ${url} =    Get location
    should contain    ${url}    ${value_in_url}
    Capture page screenshot

Confirm and save event
    click save session button
    Click at    ${EVENT_TOOLS_TEXT}
    Click at    ${SAVE_EVENT_BUTTON}
    Click at    ${CONFIRM_SAVE_BUTTON}

Change audience workflow
    [Arguments]    ${audience}
    Click at    ${AUDIENCE_DROPDOWN}
    Click at    ${AUDIENCE_TYPE_VALUE}     ${audience}
    Click at    ${AUDIENCE_TYPE_POPUP_APPLY_BUTTON}

Check list items of event rosters hour
    [Arguments]     ${locator}    ${list}
    Click at    ${locator}
    FOR   ${item}   IN      ${list}
        Check Element Display On Screen     ${CLIENT_SETUP_EVENT_ROSTER_HOUR_OPTION}      ${item}
    END
    Capture page screenshot
