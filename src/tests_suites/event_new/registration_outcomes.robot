*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Force Tags          regression    dev2    stg   olivia  birddoghr   darden  aramark     lts_stg     fedex   fedexstg    test

Documentation       Client Setup => Scheduling => setting Virtual Technology support

*** Variables ***
${register_for_event}                       Register for Event
${register_for_event_message}               Candidates will be registered for all sessions created within your event, except for interview sessions.
${schedule_for_interview}                   Register & Schedule to Event Interview
${schedule_for_interview_message}           Candidates will be registered for all sessions created within your event and scheduled for an interview.
${do_not_register}                          Do Not Register & Send Closing Message
${do_not_register_message}                  Candidates will not be registered for your event and will receive the registration closing message.
${action_default_message}                   Congratulations \#candidate-firstname! I have officially registered you for \#company-name's upcoming \#event-name event on \#event-date. Our team is looking forward to meeting you!
${conversation_multi_path}                  Event_Convo_Multiple_Path
${conversation_single_path}                 Event_Convo_Single_Path
${conversation_multi_language}              Event_Convo_Multi_Language
${age_question_label}                       Age
${age_question_content}                     How old are you?
${default_group}                            auto_event_group
${outcome_assigned_group_infor}             Move all candidates whose Assigned Group Is auto_event_group to
${default_outcome_infor}                    Move all candidates who do not meet other criteria to
${default_outcome}                          Default Outcome
${english}                                  English
${french}                                   French
${german}                                   German
${italian}                                  Italian
${japanese}                                 Japanese
${registration_outcome_message_french}      Félicitations \#candidate-firstname ! Je vous ai officiellement inscrit à l'événement \#event-name de \#company-name qui aura lieu le \#event-date. Notre équipe est impatiente de vous rencontrer!
${confirm_change_conversation_message}      Are you sure you want to change the registration conversation to {}?All created registration outcomes will be deleted.
${event_registration_confirmation_text}     Your registration for \#company-name's \#event-name on \#event-date at \#event-time is confirmed! We are looking forward to meeting you! You can view your event schedule below.
${send_my_event_schedule_text}              You can view your event schedule here: \#candidate-landing-page-link
${event_single_path_convo}                  event_single_path
@{list_users}                               ${FS_TEAM}    ${CA_TEAM}
${auto_first_name}                          John
${age_question}                             Age (How old are you?)
${like_question}                            Like (Your like?)

*** Test Cases ***
Verify removing the Screening and Action in the Event onversation builder (OL-T9444)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to conversation builder
	${conversation_name}=   Generate random name    event_convo_
	when Add new conversation with name and type    ${conversation_name}    Event Registration (Single Path)
	${screening_label}=     format string   ${COMMON_SPAN_TEXT}     Screening and Actions
	Check element not display on screen     ${screening_label}
	Check element not display on screen     ${ADD_SCREENING_AND_ACTION_BUTTON}
	Delete conversation in builder
	Capture page screenshot


Verify removing the ‘Advanced Setting’ toggle in Adding Interview session slide of Event Builder (OL-T9445, OL-T9446, OL-T9447, OL-T9448)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VIRTUAL_CHAT_BOOTH_LABEL}
    Check element not display on screen     Advanced Setting
    Click at    ${ADD_SESSION_CANCEL_BUTTON}
    Capture page screenshot
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Check element display on screen     Select a conversation for candidates who are interested in registering for your event.
    ${placeholder_text}=    Get attribute and format text   placeholder     ${CONVERSATION_CB_TYPE}
    should be equal as strings  ${placeholder_text}    Select Conversation
    Capture page screenshot


Verify Registration tab in Event Template is updated as well (OL-T9449, OL-T9450, OL-T9451, OL-T9452, OL-T9453, OL-T9454, OL-T9455, OL-T9456)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person      Single Event
    Set Schedule step    Event Session  In Person
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event
    wait for page load successfully
    Check element display on screen     ${default_outcome}
    Check element display on screen     ${EVENT_ADD_OUTCOME_BUTTON}
    Check default action of Default Outcome     ${register_for_event}
    Check all action are available when add outcome


Verify the Default Outcome Action will be automatically selected to: Register for Event when only Video Live Broadcoast(s) created (OL-T9457, OL-T9458)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Live Video Broadcast
    Click at    ${REGISTRATION_STEP_LABEL}
	Select conversation for Event
	wait for page load successfully
	Check default action of Default Outcome     ${register_for_event}
	Check all action are available when add outcome


Verify the Default Outcome Action will be automatically selected to: Register for Event when only Virtual Chat Booth created (OL-T9459, OL-T9460, OL-T9461)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event
    wait for page load successfully
    Check default action of Default Outcome     ${register_for_event}
    Check all action are available when add outcome
    ${text_message}=    Get text and format text    ${OUTCOME_ACTION_MESSAGE_TEXTAREA}
    Should be equal as strings      ${text_message}     ${action_default_message}


Verify the Default Outcome Action will be automatically selected to: Register & Schedule for Interviews when only Interview session(s) created (OL-T9462, OL-T9463, OL-T9466, OL-T9469)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event
    wait for page load successfully
    Check default action of Default Outcome     ${schedule_for_interview}
    Check all action are available when add outcome     Schedule
    Check label display     Sessions candidate can schedule to:
    Check element display on screen     ${SESSION_CANDIDATE_CAN_SCHEDULE_DROPDOWN}
    Click at    ${SESSION_CANDIDATE_CAN_SCHEDULE_DROPDOWN}
    Verify element is disable   ${SESSION_TO_SCHEDULE_APPLY_BUTTON}
    Click at    ${SESSION_NAME_CHECKBOX}    ${session_info.session_name}
    wait with short time
    Verify element is disable   ${SESSION_TO_SCHEDULE_APPLY_BUTTON}
    Capture page screenshot


Verify the Default Outcome Action will be automatically selected to: Register for Event when both Event Session(s)/Live Video Broadcast(s) and Interview Session(s) created (OL-T9464, OL-T9465, OL-T9467, OL-T9468, OL-T9470)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    In Person
    Set Overview step    In Person    Single Event
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Schedule step    Scheduled Interviews
    Set Schedule step    Event Session      In Person
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event
    wait for page load successfully
    Check default action of Default Outcome     ${register_for_event}
    Check all action are available when add outcome     All
    Click at    ${schedule_for_interview}
    Click at    ${SESSION_CANDIDATE_CAN_SCHEDULE_DROPDOWN}
    Verify element is disable   ${SESSION_TO_SCHEDULE_APPLY_BUTTON}
    Click at    ${SESSION_NAME_CHECKBOX}    ${session_info.session_name}
    Element should be enabled       ${SESSION_TO_SCHEDULE_APPLY_BUTTON}
    Check element display on screen     ${session_info.interview_duration}
    Check element display on screen     ${session_info.interview_type}
    Capture page screenshot


Verify UI of the Additional Outcomes with empty styles (OL-T9471, OL-T9472)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event
    wait for page load successfully
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Check Add Registration outcome slide is displayed
    Capture page screenshot
    Input into      ${NAME_YOUR_OUTCOME_TEXTBOX}    Test_outcome
    Click at        ${CANCEL_DIALOG_BUTTON}
    Check element not display on screen     Test_outcome
    Capture page screenshot


Verify the available Starting Values in Outcomes when the selected event conversation is Multi-path (OL-T9474, OL-T9475, OL-T9476)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_multi_path}
    wait for page load successfully
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN}
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Location
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Group
    Capture page screenshot
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Location
    Click at    ${MATCHES_VALUE_DROPDOWN}
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Any Of
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Not Any Of
    Capture page screenshot
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Any Of
    Click at    ${INPUT_DROPDOWN}
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Conversation Locations
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      All Locations
    Capture page screenshot


Verify the available Matches if users selects Staring Values is Assign Group when creating outcomes (OL-T9477, OL-T9478, OL-T9479, OL-T9480, OL-T9482, OL-T9484)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_multi_path}
    wait for page load successfully
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN}
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Location
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Group
    Capture page screenshot
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Group
    Click at    ${MATCHES_VALUE_DROPDOWN}
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Is
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Not
    Capture page screenshot
    Click at    ${MATCHES_IS}
    Click at    ${INPUT_DROPDOWN}
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      Conversation Groups
    Check element display on screen     ${ADD_OUTCOME_DROPDOWN_OPTION}      All Groups
    Capture page screenshot
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Conversation Groups
    Select group for Input dropdown     group2
    Click at    ${ADD_OUTCOME_AND_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Check element not display on screen     ${age_question_label}
    Check element not display on screen     ${age_question_content}
    Capture page screenshot
    Click at    ${INPUT_DROPDOWN}
    Select group for Input dropdown     group1
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Check element display on screen     ${age_question_label}
    Check element display on screen     ${age_question_content}
    Click at    ${age_question_label}
    Check options of Matches dropdown displayed correct
    Capture page screenshot


Verify pre-fill the group which is selected in the single path event conversation when creating conditions and the user chooses Starting Value is Assigned Group. (OL-T9481, OL-T9483, OL-T9485)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_single_path}
    wait for page load successfully
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Group
    Click at    ${MATCHES_VALUE_DROPDOWN}
    Click at    ${MATCHES_IS}
    Check element display on screen     ${default_group}
    Capture page screenshot
    Check element display on screen     ${ADD_OUTCOME_AND_BUTTON}
    Check element display on screen     ${ADD_OUTCOME_OR_BUTTON}
    Click at    ${ADD_OUTCOME_AND_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Location
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Any Of
    Click at    ${INPUT_DROPDOWN_2}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Conversation Locations
    Select location for Input dropdown      ${LOCATION_STREET_TRUNG_NU_VUONG}
    Click on span text      Apply
    Check element display on screen     ${DELETE_CONDITION_ICON}
    Capture page screenshot
    Click at    ${DELETE_CONDITION_ICON}
    Capture page screenshot
    Click at    ${ADD_OUTCOME_OR_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Assigned Location
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Is Any Of
    Click at    ${INPUT_DROPDOWN_2}
    Click at    ${ADD_OUTCOME_DROPDOWN_OPTION}      Conversation Locations
    Select location for Input dropdown      ${LOCATION_STREET_TRUNG_NU_VUONG}
    Check element display on screen     ${DELETE_CONDITION_ICON}
    Capture page screenshot
    Click at    ${DELETE_CONDITION_ICON}
    Check element not display on screen     ${OR_TEXT_DIVIDER}
    Capture page screenshot


Verify users can add an Additional Outcomes successfully (OL-T9473, OL-T9486, OL-T9487, OL-T9488, OL-T9489, OL-T9491)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_single_path}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Check element display on screen     ${outcome_name}
    Check element display on screen     ${outcome_assigned_group_infor}
    Check element display on screen     ${default_outcome_infor}
    Check span display      ${register_for_event}
    Click at    ${OUTCOME_MENU_BY_NAME}     ${default_outcome}
    Check element display on screen     ${EDIT_OUTCOME_ICON}
    Check element not display on screen     ${DUPLICATE_OUTCOME_ICON}
    Check element not display on screen     ${DELETE_OUTCOME_ICON}
    Capture page screenshot
    Click at    ${OUTCOME_MENU_BY_NAME}     ${outcome_name}
    Check element display on screen     ${EDIT_OUTCOME_ICON}
    Check element display on screen     ${DUPLICATE_OUTCOME_ICON}
    Check element display on screen     ${DELETE_OUTCOME_ICON}
    Capture page screenshot
    Click at    ${DELETE_OUTCOME_ICON}
    Check delete outcome confirmation modal is displayed    ${outcome_name}
    Click at    ${CONFIRM_DELETE_OUTCOME_BUTTON}
    Check element not display on screen     ${outcome_name}
    Capture page screenshot


Verify update UI of the slideout when the user is editing a created registration outcome (OL-T9492, OL-T9493)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_single_path}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Click at    ${OUTCOME_MENU_BY_NAME}     ${outcome_name}
    Click at    ${EDIT_OUTCOME_ICON}
    Check edit outcome slide out is displayed
    Capture page screenshot
    Click at    ${DELETE_OUTCOME_BUTTON}
    Check delete outcome confirmation modal is displayed    ${outcome_name}
    Click at    ${CONFIRM_DELETE_OUTCOME_BUTTON}
    Check element not display on screen     ${outcome_name}
    Capture page screenshot


Verify display the Field Required error state on the field when fields are not filled (OL-T9494)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_single_path}
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Click at    ${SAVE_OUTCOME_BUTTON}
    Check span display      Field Required
    Capture page screenshot


Verify a language dropdown will appear below the Action dropdown in Outcomes slide if multiple languages are added to the selected Registration Conversation (OL-T9495, OL-T9496, OL-T9497)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_multi_language}
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Check element display on screen     ${ACTION_LANGUAGE_DROPDOWN}
    Capture page screenshot
    Click at    ${ACTION_LANGUAGE_DROPDOWN}
    Check options of language dropdown
    Check registration outcomes message when change language


Verify delete all created registration outcomes when the user change selected conversation and confirm to change (OL-T9499, OL-T9498, OL-T9500)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_multi_language}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Check element display on screen     ${outcome_name}
    Capture page screenshot
    Click at    ${CONVERSATION_CB_TYPE}
    Click at    ${DROPDOWN_OPTION}     ${conversation_single_path}
    Check Confirm Conversation Change modal is displayed    ${conversation_single_path}
    Click at    ${CANCEL_DIALOG_BUTTON}
    Check element display on screen     ${outcome_name}
    Click at    ${CONVERSATION_CB_TYPE}
    Click at    ${DROPDOWN_OPTION}     ${conversation_single_path}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    Check element not display on screen     ${outcome_name}
    Capture page screenshot


Verify the user can duplicate the created Registration OutComes (OL-T9501)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_multi_language}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Check element display on screen     ${outcome_name}
    Capture page screenshot
    Duplicate outcome   ${outcome_name}


Verify a ‘Conversation Cannot Be Published’ modal will appear when the user changes a selected Group &/or available Location &/or they remove a screening question and have effect to upcoming events (OL-T9502)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to conversation builder
	${conversation_name}=   Add Single conversation     Event Registration (Single Path)
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_name}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Event created successfully      ${event_name}
    Go to conversation builder
    Find and go to conversation detail      ${conversation_name}
    Delete a global screening question in conversation
    Public the conversation
    Conversation can not be published dialog is displayed   ${event_name}
    Capture page screenshot


Verify the user can publish the conversation which assigned to events and it is only edited the content of questions (OL-T9503)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to conversation builder
	${conversation_name}=   Add Single conversation     Event Registration (Single Path)
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${conversation_name}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Event created successfully      ${event_name}
    Go to conversation builder
    Find and go to conversation detail      ${conversation_name}
    Input into    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    Question edited
    Public the conversation
    Check span display      Published
    Capture page screenshot


Verify candidates will recieved notification when a candidate is registered for an event AND the event has either Event Session(s) or Live Video Broadcast(s) or a Virtual Chat Booth created (OL-T9504, OL-T9505, OL-T9507)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=      Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Manually add a Candidate to Event       is_spam_email=False
    Verify user has received the email      Your registration for ${COMPANY_EVENT}
    ...     ${event_name}       REGISTERED_EVENT


Verify 'View My Schedule' button will be added to all Registration Confirmation email (OL-T9510, OL-T9515, OL-T9516, OL-T9517)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    &{session_info_1}=  Set Schedule step    Virtual Scheduled Interviews
    &{session_info_2}=  Set Schedule step    Live Video Broadcast
    Set tool step and create event
    Manually add a Candidate to Event       is_spam_email=False
    # Verify the candidate receive email and will be directed the candidate to a landing page when clicks on View My Schedule from email (OL-T9515)
    Click button in email      Your registration for ${COMPANY_EVENT}
    ...     ${event_name}      REGISTERED_EVENT
    # Verify all event sessions will be listed in the My Event Schedule and interview session not display in (OL-T9516, OL-T9517)
    Check event landing page display    ${event_name}   ${session_info_1.session_name}      ${session_info_2.session_name}


Veriy display the Join Interview button if the interview is a video interview and the client is using a Video Technology supported for Event Interviews (OL-T9518, OL-T9519)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    &{session_info_1}=  Set Schedule step    Event Session
    Set tool step and create event
    Manually add a Candidate to Event       is_spam_email=False
    Click button in email      Your registration for ${COMPANY_EVENT}
    ...     ${event_name}      REGISTERED_EVENT
    Check element display on screen     ${JOIN_SESSION_BUTTON}
    @{interview_location}=  Create list     Venue test name     Venue test location
    Verify interview location text displayed correctly      @{interview_location}


Verify the candidate will receive the Initial Interview Schedule Request if the event has event session(s) or live video broadcast(s) and interview session(s) created and the candidate’s action is Register and Schedule to Event Interview (OL-T9522, OL-T9523, OL-T9524, OL-T9530)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
	${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${FS_TEAM}
    Set session schedule with interviewer    Virtual Scheduled Interviews       ${FS_TEAM}
    # Set action for outcome is Register and Schedule to Event Interview
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${event_single_path_convo}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Go to event register page
    Capture page screenshot
    # Register event at event landing site
    Click at    ${REGISTER_EVENT}
    wait with medium time
    Check message widget site response correct      To start, what is your first and last name?
    ${candidate_name} =    Generate random name only text   ${auto_first_name}
    Input text for widget site    ${candidate_name}
    Check message widget site response correct      Can you please also provide me with your email so that a recruiter can contact you?
    ${email} =    Generate random name    ${CONFIG.gmail}
    Input text for widget site    ${email}
    Check message widget site response correct      How old are you?
    Input text for widget site    27
    Check message widget site response correct      Your like?
    Input text for widget site   Football
    # Check if user receive email initial schedule request OL-T9522, OL-T9522
    wait with medium time
    Verify user has received the email  ${COMPANY_EVENT} would like to schedule a virtual interview
    ...     ${auto_first_name}    WOULD_LIKE_SCHEDULE_VIRTUAL_ITV
    # Choose time and check mail confirm scheduled interview OL-T9523
    Input text for widget site    1
    wait with short time
    Verify user has received the email    Your virtual interview at ${COMPANY_EVENT}!
    ...    Hi ${auto_first_name}!   YOUR_VIRTUAL_INTERVIEW
    # Go to event homepage and check if user is added to all candidates OL-T9530
    Go to event dashboard    ${event_name}
    Click at    Candidates
    Click at    All Candidates
    Check span display      ${candidate_name}
    Capture page screenshot


Verify add an SMS version of the Registration Confirmation Notification in Message Customization (OL-T9525, OL-T9526, OL-T9527)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Message Customization page
	Click at    ${EVENTS_TAB}
	Click at    Confirmation
	# Check Hiring Events - Event Registration Confirmation is added OL-T9525
	Check element display on screen     Hiring Events
	Check element display on screen     Event Registration Confirmation
	# Check text message of Event Registration Confirmation OL-T9526
	${event_registration_confirmation_message}=     Get attribute and format text   placeholder   ${MESSAGE_CONTENT_BY_TITLE}     Event Registration Confirmation
	Should be equal as strings      ${event_registration_confirmation_message}      ${event_registration_confirmation_text}
	# Check My Event Schedule is added and text displayed OL-T9527
	Check element display on screen     Send My Event Schedule
    ${send_my_event_schedule_message}=     Get attribute and format text   placeholder   ${MESSAGE_CONTENT_BY_TITLE}     Send My Event Schedule
	Should be equal as strings      ${send_my_event_schedule_message}      ${send_my_event_schedule_text}
	Capture page screenshot


Verify update the title of the Upcoming Reminder in Message Customization (OL-T9528)
    Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Message Customization page
	Click at    ${EVENTS_TAB}
	Click at    Scheduled Reminders
	# Check remove 48h upcoming reminder message
	Check element not display on screen     48 Hours Before Start of Event
	# Check edit title Upcoming reminder
	Check element display on screen     Hiring Events
    Check element display on screen     24 Hours Before Start of Event
    Check element display on screen     1 Hours Before Start of Event
    Capture page screenshot


Check registered candidates for an event will received correctly message follow setting in Message Customization (OL-T9529)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Confirmation
    Click on span text      Email
    Input into  ${EVENT_CONTENT_EMAIL_TEXTBOX_BY_INTERVIEW_TYPE}    Updated email   Virtual
    Run keyword and ignore error    Click at    ${SAVE_BUTTON_MESSAGE}
    &{event_infor}=  Create new hiring event, scheduled candidate to interview slot and add interviewer    Virtual     11:30am - 11:45am    ${FS_TEAM}
    # Check confirm mail sent to user
    Verify user has received the email      Your virtual interview at ${COMPANY_EVENT}      Updated email     YOUR_VIRTUAL_INTERVIEW
    Cancel event from event list   ${event_infor.event_name}
    # Updated message to normal
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Confirmation
    Click on span text      Email
    Clear element text with keys    ${EVENT_CONTENT_EMAIL_TEXTBOX_BY_INTERVIEW_TYPE}    Virtual
    Click at    ${SAVE_BUTTON_MESSAGE}


Verify the candidate will recieve the close message when not matching conditions in Outcomes (OL-T9531, OL-T9532)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Choose Event type and Event venue type    Hiring Event    Virtual
	${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${FS_TEAM}
    Set session schedule with interviewer    Virtual Scheduled Interviews       ${FS_TEAM}
    # Set action for outcome is Register and Schedule to Event Interview
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${event_single_path_convo}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    # Edit default outcome to Do not register and Send closing message
    Go to edit outcome      Default Outcome
    Click at    ${ADD_OUTCOME_ACTION_DROPDOWN}
    Click at    ${do_not_register}
    Click at    ${SAVE_OUTCOME_BUTTON}
    # Complete the step to create event
    Set Tools step
    Go to event register page
    Capture page screenshot
    # Register event at event landing site
    Click at    ${REGISTER_EVENT}
    wait with medium time
    Check message widget site response correct      To start, what is your first and last name?
    ${candidate_name} =    Generate random name only text   ${auto_first_name}
    Input text for widget site    ${candidate_name}
    Check message widget site response correct      Can you please also provide me with your email so that a recruiter can contact you?
    ${email} =    Generate random name    ${CONFIG.gmail}
    Input text for widget site    ${email}
    Check message widget site response correct      How old are you?
    Input text for widget site    24
    Check message widget site response correct      Your like?
    Input text for widget site   Football
    Check message widget site response correct      Thank you for your interest in ${COMPANY_EVENT}. We will reach out to you within three business days.   4


Verify all outcomes of occurrences will be not changed if the users does not change Outcomes when editing the recurring (OL-T10804, OL-T10808)
    [Tags]  skip
    #   https://paradoxai.atlassian.net/browse/OL-72853
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    # Set action for outcome
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${event_single_path_convo}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Set Summary step and create event
    Go to edit recurring event   ${event_name}
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    Set end date occurence for recurring event      3
    Set end of recurring event                      10
    Click at    ${SAVE_BUTTON_RECURRING}
    Set Summary step and create event
    # Duplicated recurring event and check outcomes ís not changed OL-T10808
    Search and duplicated event in event page   ${event_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome  ${outcome_name}
    Verify outcomes detail is display correctly     ${age_question}
    # Go to original event and check outcomes is not changed OL-T10804
    Go to Events page
    Click at    Recurring Events
    Go to edit recurring event      ${event_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome  ${outcome_name}
    Verify outcomes detail is display correctly     ${age_question}


Verify all outcomes of occurrences will be updated correctly when the user select to change All Occurrences (OL-T10805)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    # Set action for outcome
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${event_single_path_convo}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Set Summary step and create event
    Go to edit recurring event   ${event_name}
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    Set end date occurence for recurring event      3
    Set end of recurring event                      10
    Click at    ${SAVE_BUTTON_RECURRING}
    # Edit outcomes
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    Your like?
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click on common text last    At least
    Input into  ${NUMERIC_INPUT_TEXTBOX}    25
    Click at    ${SAVE_OUTCOME_BUTTON}
    Set Summary step and create event
    # Go to recurring event again and check outcomes is updated
    Go to edit recurring event   ${event_name}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Verify outcomes detail is display correctly     ${like_question}


Verify update outcomes of only selected occurrence when the user selects to edit Only this Occurrence at Confirm Update Event modal (OL-T10806)
    #TODO Maintain later
    [Tags]  skip
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    # Set action for outcome
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${event_single_path_convo}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Set Summary step and create event
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    # Edit outcomes
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    Your like?
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click on common text last    At least
    Input into  ${NUMERIC_INPUT_TEXTBOX}    25
    Click at    ${SAVE_OUTCOME_BUTTON}
    Set tool step and create event
    # Go to summary step and select only this occurrence
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Verify outcomes detail is display correctly     ${like_question}
    Click on common text last   Cancel
    # Check other occurrence does not update outcome
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_ITEM}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Verify outcomes detail is display correctly     ${age_question}


Verify update outcomes of occurrences which are selected at Confirm Update Event modal (OL-T10807)
    #TODO Maintain later
    [Tags]  skip
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    # Set action for outcome
    Click at    ${REGISTRATION_STEP_LABEL}
    Select conversation for Event       ${event_single_path_convo}
    ${outcome_name}=    Add registration outcome    Assigned Group
    Go to edit outcome      ${outcome_name}
    Set screening question for outcome      Age
    Set Tools step
    Set Summary step and create event
    Go to edit recurring event   ${event_name}
    # Get the selected recurring date
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    Set end date occurence for recurring event      3
    Set end of recurring event                      10
    Click at    ${SAVE_BUTTON_RECURRING}
    ${date}=    Get text and format text    ${SELECTED_EVENT_DAYS_TEXT}
    # Edit outcomes
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    Your like?
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click on common text last    At least
    Input into  ${NUMERIC_INPUT_TEXTBOX}    25
    Click at    ${SAVE_OUTCOME_BUTTON}
    # Select only update for selected occurrence
    Click at    ${SUMMARY_TAB}
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Click at    ${CUSTOM_RADIO}
    Input into  ${SEARCH_OCCURRENCES_TEXTBOX}       ${date}
    Click by JS    ${OCCURRENCES_CHECKBOX}
    Click at    ${CONFIRM_AND_SAVE_BUTTON}
    # Go to summary step and select only this occurrence
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_WITH_TEXT}   ${date}
    Click at    ${REGISTRATION_STEP_LABEL}
    Go to edit outcome      ${outcome_name}
    Verify outcomes detail is display correctly     ${like_question}

*** Keywords ***
Check default action of Default Outcome
    [Arguments]     ${default_option}
    Click at    ${default_outcome}
    Click at    ${ADD_OUTCOME_ACTION_DROPDOWN}
    Check element display on screen     ${CHECK_ICON_BY_DROPDOWN_OPTION}    ${default_option}
    Check element display on screen     ${do_not_register}
    Capture page screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}

Check all action are available when add outcome
    [Arguments]     ${outcome_type}=Default
    Click at    ${EVENT_ADD_OUTCOME_BUTTON}
    Check span display      Name Your Outcome
    Capture page screenshot
    Click at    ${ADD_OUTCOME_ACTION_DROPDOWN}
    IF      '${outcome_type}' == 'Default'
        Check element display on screen     ${register_for_event}
        Check element display on screen     ${register_for_event_message}
        Check element display on screen     ${do_not_register}
        Check element display on screen     ${do_not_register_message}
    ELSE IF     '${outcome_type}' == 'Schedule'
        Check element display on screen     ${schedule_for_interview}
        Check element display on screen     ${schedule_for_interview_message}
        Check element display on screen     ${do_not_register}
        Check element display on screen     ${do_not_register_message}
    ELSE IF     '${outcome_type}' == 'All'
        Check element display on screen     ${register_for_event}
        Check element display on screen     ${register_for_event_message}
        Check element display on screen     ${schedule_for_interview}
        Check element display on screen     ${schedule_for_interview_message}
        Check element display on screen     ${do_not_register}
        Check element display on screen     ${do_not_register_message}
    END
    Capture page screenshot

Check Add Registration outcome slide is displayed
    Check element display on screen     ${ADD_REGISTRATION_OUTCOME_LABEL}
    Check element display on screen     ${EDIT_OUTCOME_NAME_ICON}
    Click at    ${EDIT_OUTCOME_NAME_ICON}
    Check element display on screen     ${NAME_YOUR_OUTCOME_TEXTBOX}
    Check label display     Starting Value
    Check element display on screen     ${STARTING_VALUE_DROPDOWN}
    Check label display     Matches
    Check element display on screen     ${MATCHES_VALUE_DROPDOWN}
    Check label display     Input
    Check element display on screen     ${ADD_OUTCOME_AND_BUTTON}
    Check element display on screen     ${ADD_OUTCOME_OR_BUTTON}
    Check element display on screen     ${CANCEL_DIALOG_BUTTON}
    Check element display on screen     ${SAVE_OUTCOME_BUTTON}

Check options of Matches dropdown displayed correct
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Check element display on screen     At least
    Check element display on screen     At most
    Check element display on screen     Yes
    Check element display on screen     ${MATCHES_NO}
    Check element display on screen     List select
    Capture page screenshot
    Click at    At least
    Check element display on screen     ${NUMERIC_INPUT_TEXTBOX}
    Check element display on screen     ${UNIT_INPUT_DROPDOWN}
    Capture page screenshot
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click at    Yes
    Check element not display on screen     ${NUMERIC_INPUT_TEXTBOX}
    Check element not display on screen     ${UNIT_INPUT_DROPDOWN}
    Capture page screenshot
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click at    At most
    Check element display on screen     ${NUMERIC_INPUT_TEXTBOX}
    Check element display on screen     ${UNIT_INPUT_DROPDOWN}
    Capture page screenshot
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click at    ${MATCHES_NO}
    Check element not display on screen     ${NUMERIC_INPUT_TEXTBOX}
    Check element not display on screen     ${UNIT_INPUT_DROPDOWN}
    Capture page screenshot

Check delete outcome confirmation modal is displayed
    [Arguments]     ${outcome_name}
    Check element display on screen      ${DELETE_OUTCOME_DIALOG_TITLE}
    Check span display      Are you sure you want to delete
    Check strong text display   ${outcome_name}
    Check span display       All future candidates who meet this criteria will follow the
    Check strong text display   Default Condition
    Check element display on screen     ${CANCEL_DIALOG_BUTTON}
    Check element display on screen     ${CONFIRM_DELETE_OUTCOME_BUTTON}
    Capture page screenshot

Check edit outcome slide out is displayed
    Check span display      Edit Registration Outcome
    Check element display on screen     ${SAVE_OUTCOME_BUTTON}
    Check element display on screen     ${CANCEL_DIALOG_BUTTON}
    Check element display on screen     ${DELETE_OUTCOME_BUTTON}
    Capture page screenshot

Check options of language dropdown
    Check element display on screen     ${DROPDOWN_OPTION}      ${english}
    Check element display on screen     ${DROPDOWN_OPTION}      ${french}
    Check element display on screen     ${DROPDOWN_OPTION}      ${german}
    Check element display on screen     ${DROPDOWN_OPTION}      ${italian}
    Check element display on screen     ${DROPDOWN_OPTION}      ${japanese}
    Capture page screenshot

Check registration outcomes message when change language
    Click at    ${DROPDOWN_OPTION}      ${french}
    ${registration_outcome_message}=    Get text and format text    ${OUTCOME_ACTION_MESSAGE_TEXTAREA}
    Should be equal as strings  ${registration_outcome_message}     ${registration_outcome_message_french}

Check Confirm Conversation Change modal is displayed
    [Arguments]     ${conversation_name}
    Check span display      Confirm Conversation Change
    ${dialog_content}=      Get text and format text    ${DIALOG_MESSAGE_CONTENT}
    ${dialog_content_expected}=     Format string   ${confirm_change_conversation_message}  ${conversation_name}
    Should be equal as strings      ${dialog_content}   ${dialog_content_expected}
    Check element display on screen     ${CANCEL_DIALOG_BUTTON}
    Check element display on screen     ${CONFIRM_DIALOG_BUTTON}
    Capture page screenshot

Set screening question for outcome
    [Arguments]     ${screening_question}
    Click at    ${ADD_OUTCOME_AND_BUTTON}
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Click at    ${screening_question}
    Click at    ${MATCHES_VALUE_DROPDOWN_2}
    Click on common text last    At least
    Input into  ${NUMERIC_INPUT_TEXTBOX}    25
    Click at    ${SAVE_OUTCOME_BUTTON}

Conversation can not be published dialog is displayed
    [Arguments]     ${event_name}
    Check span display      Conversation can not be published
    Check element display on screen     Conversation cannot be published because 1 Event is using this conversation.
    Check element display on screen     ${COMMON_TEXT}      ${event_name}
    Capture page screenshot

Check event landing page display
    [Arguments]     ${event_name}   ${session_name_1}   ${session_name_2}
    Check element display on screen     ${event_name}
    Check span display      Registered
    Check element display on screen     My Schedule
    Check element not display on screen    ${session_name_1}
    Check element display on screen     ${session_name_2}
    Capture page screenshot

Verify interview location text displayed correctly
    [Arguments]     @{text_to_verify}
    FOR     ${text}     IN      @{text_to_verify}
        Element should contain      ${LANDING_PAGE_EVENT_LOCATION}      ${text}
    END
    Capture page screenshot

Verify outcomes detail is display correctly
    [Arguments]     ${starting_value}
    wait with short time
    ${starting_value_text}=  Get text and format text    ${STARTING_VALUE_DROPDOWN_2}
    Should be equal as strings      ${starting_value_text}   ${starting_value}
    ${matches_value}=   Get text and format text    ${MATCHES_VALUE_DROPDOWN_2}
    Should be equal as strings      ${matches_value}   At least
    ${input_value}=     Get value and format text    ${NUMERIC_INPUT_TEXTBOX}
    Should be equal as strings      ${input_value}      25
    ${action_value}=    Get text and format text    ${ADD_OUTCOME_ACTION_DROPDOWN}
    Should be equal as strings      ${action_value}     ${register_for_event}
    Capture page screenshot
