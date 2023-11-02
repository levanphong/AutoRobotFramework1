*** Settings ***
Resource            ../../pages/event_templates_page.robot
Resource            ../../pages/users_page.robot
Resource            ../../pages/event_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variable ***
${hiring_event}                     Hiring Event
${orientation}                      Orientation
${in_persion}                       In Person
${virtual}                          Virtual
${event_template_group}             Orientation_template_group
${hiring_event_template_group}      Hiring_event_template_group
${venue_location}                   Venue test location
${venue_name}                       Venue test name
${test_school}                      Automation Test School
${conv_event}                       auto event landing site
${session_name}                     Session Name
${interview_type}                   Phone interview
${interview_per_duration}           1 interview, 30 minutes each
${session_name_copy}                Session Name Copy
${outcome_name}                     Outcome Test
${new_outcome_name}                 New Outcome Test
${duplicate_outcome_name}           Duplicate Outcome Test
${action}                           Do Not Register & Send Closing Message

*** Test Cases ***
Orientation event - Verify Create Event template successfully (OL-T20356, OL-T20364, OL-T20367, OL-T20345, OL-T20370, OL-T20348, OL-T20347)
    [Tags]    regresstion    stg
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${event_template_group}
    Click create event template with type    ${orientation}
    #   Verify UI of Overview tab with In person type (OL-T20345)
    Click at    ${EVENT_TEMPLATE_TEAM_TEXT}
    Check span display      This field is required
    Capture page screenshot
    Set event template venue    In Person
    Verify overview tab display correctly       In Person
    ${event_template_name} =    Generate random name    orientation_template
    Input into      ${PUBLIC_TEMPLATE_NAME_TEXTBOX}    ${event_template_name}
    #   Verify UI of Registration tab (OL-T20356)
    Click at    ${EVENT_TEMPLATE_REGISTRATION_TEXT}
    Verify Registration tab UI of Orientation Event Template
    #   Verify UI of the Tool tab (OL-T20364)
    Click at    ${EVENT_TEMPLATE_TOOLS_TEXT}
    Verify Tools tab UI of Orientation Event Template
    #    Verify UI of Team tab (OL-T20347)
    Click at    ${EVENT_TEMPLATE_TEAM_TEXT}
    Verify Team tab UI of Orientation Event Template
    #   Verify the user can add user on Team tab (OL-T20348)
    Add team members     Full User Automation
    Wait for page load successfully
    Click at    ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    #   Verify Create Event template successfully (OL-T20367)
    Verify event template create successfully      ${event_template_group}      ${event_template_name}
    Check event template status       ${event_template_name}     Published
    #   Delete event template (OL-T20370)
    Go to Event Templates page
    Go to event template group     ${event_template_group}
    Delete event template          ${event_template_name}


Hiring event - Verify UI of Overview tab with In person type (OL-T20344)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}
    Verify hiring event template overview tab display correctly
    Click at    ${EVENT_TEMPLATE_TEAM_TEXT}
    Check span display      This field is required
    Capture page screenshot


Verify Create Event template successfully with status is Draft (OL-T20366, OL-T20355, OL-T20363, OL-T20349, OL-T20359)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}    ${virtual}
    ${event_template_name} =    Generate random name    hiring_event
    Set overview step Hiring Event      ${event_template_name}      ${test_school}
    #   Hiring event - Verify UI of Registration tab (OL-T20355)
    Click at    ${EVENT_TEMPLATE_REGISTRATION_TEXT}
    Verify Registration tab of Hiring Template
    Click Registration step for event template    ${conv_event}
    Verify Registration step UI of event template
    #   Hiring event - Verify UI of the Additional Outcomes with empty styles (OL-T20359)
    Click at    ${EVENT_TEMPLATE_ADD_OUTCOME_BUTTON}
    Check Registration Outcome UI
    Click at    ${EVENT_TEMPLATE_CANCEL_ADD_OUTCOME_BUTTON}
    #    Hiring event - Verify UI of the Tool tab (OL-T20363)
    Click at    ${EVENT_TEMPLATE_TOOLS_TEXT}
    Verify Tools tab UI of Hiring Template
    #    Hiring event - Verify UI of Schedule tab (OL-T20349)
    Click at    ${EVENT_TEMPLATE_SCHEDULE_TEXT}
    Verify Schedule tab UI of Hiring Template
    Go to Event Templates page
    Go to event template group    ${hiring_event_template_group}
    Check element display on screen     ${DRAFT_EVENT_TEMPLATE}         ${event_template_name}
    Check event template status       ${event_template_name}     Draft
    #   Delete event template have created recently
    Go to Event Templates page
    Go to event template group    ${hiring_event_template_group}
    Delete event template         ${event_template_name}


Hiring event - Verify Create Event template successfully (OL-T20365, OL-T20368)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}    ${virtual}
    ${event_template_name} =    Generate random name    hiring_event
    Set overview step Hiring Event      ${event_template_name}      ${test_school}
    Click at        ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Verify event template create successfully       ${hiring_event_template_group}      ${event_template_name}
    #    Verify Duplidate Event template successfully (OL-T20368)
    Duplicate event template        ${event_template_name}      None
    Verify event template create successfully       ${hiring_event_template_group}      Copy - ${event_template_name}
    Check event template status       ${event_template_name}     Published
    Check event template status       Copy - ${event_template_name}     Published
    #   Delete event template have created recently
    Go to Event Templates page
    Go to event template group    ${hiring_event_template_group}
    Delete event template           Copy - ${event_template_name}
    Delete event template           ${event_template_name}


Verify Edit Event template successfully (OL-T20350, OL-T20369, OL-T20353)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}
    #   Verify UI of Overview tab with In person type
    Verify hiring event template overview tab display correctly
    Click at    ${EVENT_TEMPLATE_TEAM_TEXT}
    Check span display      This field is required
    #   Check UI of Add a Session slide when creating Session - In person type (OL-T20350)
    ${event_template_name} =    Generate random name    hiring_event
    Set overview step Hiring Event      ${event_template_name}      ${test_school}
    Click at    ${EVENT_TEMPLATE_SCHEDULE_TEXT}
    Click at    ${EVENT_TEMPLATE_CREATE_NEW_SESSION_BUTTON}
    Verify session slide UI     In Person
    Add new session for hiring event template       ${session_name}     ${interview_type}     ${interview_per_duration}
    Click at    ${EVENT_TEMPLATE_CONFIRM_ADD_SESSION_BUTTON}
    Verify Session was add into Schedule Tab        ${session_name}     ${interview_type}
    #   Verify the user can delete a Session (OL-T20353)
    Delete session in Schedule Tab        ${session_name}
    wait for page load successfully
    Click at    ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Verify event template create successfully       ${hiring_event_template_group}      ${event_template_name}
    #   Verify Edit Event template successfully (OL-T20369)
    ${new_event_template_name} =    Edit event template         ${event_template_name}
    Verify event template create successfully       ${hiring_event_template_group}      ${new_event_template_name}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Delete event template           ${new_event_template_name}


Verify the user can duplicate a Session (OL-T20346, OL-T20351, OL-T20352, OL-T20354)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}        ${virtual}
    #   Verify UI of Overview tab with Virtual type (OL-T20346)
    Verify overview tab of virtual display correctly
    ${event_template_name} =    Generate random name    hiring_event
    Set overview step Hiring Event      ${event_template_name}      ${test_school}
    #   Check UI of Add a Session slide when creating Session - Virtual type (OL-T20351)
    Click at    ${EVENT_TEMPLATE_SCHEDULE_TEXT}
    Verify Schedule tab UI of Hiring Template
    Click at    ${EVENT_TEMPLATE_CREATE_NEW_SESSION_BUTTON}
    Verify session slide UI     Virtual
    Add new session for hiring event template       ${session_name}     ${interview_type}     ${interview_per_duration}
    Click at    ${EVENT_TEMPLATE_CONFIRM_ADD_SESSION_BUTTON}
    Verify Session was add into Schedule Tab        ${session_name}     ${interview_type}
    #   Verify the user can edit a Session (OL-T20352)
    ${new_session_name} =       Edit session in Schedule Tab        ${session_name}
    Click at       ${EVENT_TEMPLATE_UPDATE_SESSION_BUTTON}
    Verify Session was add into Schedule Tab        ${new_session_name}     ${interview_type}
    #   Verify the user can duplicate a Session (OL-T20354)
    Duplicate a session     ${new_session_name}     ${session_name_copy}
    Verify Session was add into Schedule Tab        ${session_name_copy}     ${interview_type}
    Go to Event Templates page
    Go to event template group    ${hiring_event_template_group}
    Delete event template           ${event_template_name}


Hiring event - Verify the user allow edit action on Default Outcome Action (OL-T20358, OL-T20357)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}    ${virtual}
    ${event_template_name} =    Generate random name    hiring_event
    Set overview step Hiring Event      ${event_template_name}      ${test_school}
    Click at    ${EVENT_TEMPLATE_SCHEDULE_TEXT}
    Click at    ${EVENT_TEMPLATE_CREATE_NEW_SESSION_BUTTON}
    Add new session for hiring event template       ${session_name}     ${interview_type}     ${interview_per_duration}
    Click at    ${EVENT_TEMPLATE_CONFIRM_ADD_SESSION_BUTTON}
    Click at    ${EVENT_TEMPLATE_REGISTRATION_TEXT}
    Click Registration step for event template    ${conv_event}
    Open edit default outcome model
    #   Hiring event - Verify the Default Outcome Action will be automatically selected to: Register & Schedule for Interviews (OL-T20357)
    Verify action select of defaul outcome      True
    Click at    ${EVENT_TEMPLATE_OUTCOME_ACTION_SELECT}
    Click at    Do Not Register & Send Closing Message
    Verify closing message displayed correctly
    Go to Event Templates page
    Go to event template group    ${hiring_event_template_group}
    Delete event template           ${event_template_name}


Hiring event - Verify users can add an Additional Outcomes successfully (OL-T20360, OL-T20361, OL-T20362)
    [Tags]    regresstion    stg
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Event Templates page
    Go to event template group      ${hiring_event_template_group}
    Click create event template with type    ${hiring_event}    ${virtual}
    ${event_template_name} =    Generate random name    hiring_event
    Set overview step Hiring Event      ${event_template_name}      ${test_school}
    Click at    ${EVENT_TEMPLATE_REGISTRATION_TEXT}
    Click Registration step for event template    ${conv_event}
    #   Hiring event - Verify users can add an Additional Outcomes successfully (OL-T20360)
    Click at    ${EVENT_TEMPLATE_ADD_OUTCOME_BUTTON}
    wait for page load successfully
    Add registration outcome match any location         ${outcome_name}    ${LOCATION_STREET_TRUNG_NU_VUONG}      ${action}
    Click at     ${EVENT_TEMPLATE_OK_ADD_OUTCOME_BUTTON}
    Verify add registration outcome successfully        ${outcome_name}     ${action}
    #   Hiring event - Verify the user can edit outcome when the user edit outcome (OL-T20362)
    Edit registration outcome       ${outcome_name}         ${new_outcome_name}
    Click at     ${EVENT_TEMPLATE_OK_SAVE_OUTCOME_BUTTON}
    Verify add registration outcome successfully        ${outcome_name}     ${action}
    #   Hiring event - Verify all data Outcomes will be copied correctly when the user dupplicates outcome (OL-T20361)
    Duplicate registration outcome      ${new_outcome_name}
    Verify add registration outcome successfully        Copy of ${new_outcome_name}     ${action}
    Click at     Copy of ${new_outcome_name}
    Verify Registration match any location outcome copied correctly     ${LOCATION_STREET_TRUNG_NU_VUONG}      ${action}
    Go to Event Templates page
    Go to event template group    ${hiring_event_template_group}
    Delete event template           ${event_template_name}

*** Keywords ***
Verify Registration tab UI of Orientation Event Template
    Wait until element is visible      ${EVENT_TEMPLATE_SETTINGS_ICON}
    Check label display     Close Registration
    Check label display     Scheduling Conditions
    Check label display     At Set Time
    Check label display     After Number of Candidates Registered
    Verify display exact text      Candidates can no longer register to the event after one of these requirements are met.
    Verify display exact text      Create scheduling conditions to limit the type of candidate who will be scheduled to your event.
    Check element display on screen     ${SCHEDULING_CONDITION_ADVANCED_SETTINGS}
    Verify event date and time select item display

Verify Tools tab UI of Orientation Event Template
    Wait until element is visible      ${EVENT_TEMPLATE_SETTINGS_ICON}
    Verify display exact text      Tools
    Verify display exact text      Configure all the different ways candidates can communicate with Olivia for your event.
    Check p text display    Event Candidate Care
    Check p text display    Event Ratings
    Check p text display    Add and edit Olivia responses to specific candidate questions.
    Check p text display    Select ratings to send to candidates and users at various event touchpoints.
    Capture page screenshot

Verify Team tab UI of Orientation Event Template
    Wait until element is visible      ${EVENT_TEMPLATE_SETTINGS_ICON}
    Verify display exact text      Team
    Verify display exact text      Invitations to your event team will be sent out after the event is created. If an event manager declines the invitation, they can still edit and manage the event.
    Verify element is enable    ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Check element display on screen         ${EVENT_TEMPLATE_INPUT_ADD_EVENT_TEAM}
    Capture page screenshot

Verify event date and time select item display
    Click at    ${EVENT_TEMPLATE_SET_TIME_TYPE_SELECT}
    Check span display      Event end date & time
    Check span display      12 hours before event
    Check span display      24 hours before event
    Check span display      Set specific date and time
    Check span display      1 hour before event
    Capture page screenshot

Verify overview tab display correctly
    [Arguments]         ${event_venue}
    ${is_checked} =      get value    ${INTERNAL_EVENT_NAME_CHECKBOX}
    Should be true      '${is_checked}' == 'true'
    Verify element is disable      ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Check label display     Public Template Name
    Check label display     Event Venue
    IF      '${event_venue}' == 'In Person'
        Check label display     Venue Location
        Check label display     Venue Name
        Check element display on screen     ${VENUE_LOCATION_TEXTBOX}
        Check element display on screen     ${VENUE_NAME_TEXTBOX}
        Check element display on screen     ${VENUE_NAME_TEXTBOX}
    ELSE IF         '${event_venue}' == 'Virtual'
        Check element not display on screen     ${VENUE_LOCATION_TEXTBOX}
        Check element not display on screen     ${VENUE_NAME_TEXTBOX}
    ELSE
        Verify element is disable      ${VENUE_LOCATION_TEXTBOX}
        Verify element is disable      ${VENUE_NAME_TEXTBOX}
    END
    Capture page screenshot

Verify hiring event template overview tab display correctly
    Wait until element is visible      ${EVENT_TEMPLATE_SETTINGS_ICON}
    ${is_checked} =      get value     ${INTERNAL_EVENT_NAME_CHECKBOX}
    Should be true      '${is_checked}' == 'true'
    Check label display     Public Template Name
    Check label display     Event Reporting Category
    Check label display     Campus
    Check label display     Is this a Campus specific event?
    Verify element is disable      ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Check element display on screen     ${INPUT_SELECT_EVENT_TYPE}
    Check element display on screen     ${VENUE_LOCATION_TEXTBOX}
    Check element display on screen     ${VENUE_NAME_TEXTBOX}
    Check element display on screen     ${CAMPUS_EVENT_TOGGLE}
    Capture page screenshot

Verify Registration tab of Hiring Template
    Wait until element is visible      ${EVENT_TEMPLATE_SETTINGS_ICON}
    Check label display     Event Conversation
    Check text display      Select a conversation for candidates who are interested in registering for your event.
    Check element display on screen         ${EVENT_TEMPLATE_CONVERSATION_SELECT}
    Capture page screenshot

Verify Tools tab UI of Hiring Template
    Wait until element is visible      ${EVENT_TEMPLATE_SETTINGS_ICON}
    Verify display exact text       Configure all the different ways candidates can communicate with Olivia for your event.
    Check p text display            Olivia's Event Phone Numbers
    Check p text display            Add and edit your keywords and longcodes for all of your global events
    Check p text display            Event Candidate Care
    Check p text display            Add and edit Olivia responses to specific candidate questions.
    Check p text display            Event Landing Page
    Check p text display            Create a custom event landing page to advertise your event.
    Check p text display            Event Ratings
    Check p text display            Select ratings to send to candidates and users at various event touchpoints.
    Capture page screenshot

Verify Schedule tab UI of Hiring Template
    Wait until element is visible       ${EVENT_TEMPLATE_SETTINGS_ICON}
    Check element display on screen     ${EVENT_TEMPLATE_CREATE_NEW_SESSION_BUTTON}
    Check text display       Create interview sessions to which candidates can be scheduled.
    Check text display       Event sessions cannot be added to a template and must be added per event. Select 'Create New Session' to start.
    Check text display       You have no interview sessions created.
    Capture page screenshot

Verify Registration step UI of event template
    Check title popup display    Registration Outcomes
    Check p text display         Determine the outcome for a candidate based on their answers to the registration conversation and other candidate attributes.
    Check text display           Default Outcome
    Check span display           Add Registration Outcome
    Check element display on screen     ${EVENT_TEMPLATE_ADD_OUTCOME_BUTTON}
    Capture page screenshot

Check Registration Outcome UI
    Check element display on screen     ${EVENT_TEMPLATE_NAME_OUTCOME_INPUT}
    Check element display on screen     ${EVENT_TEMPLATE_STARTING_VALUE_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_MATCHES_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_AND_STATEMENT}
    Check element display on screen     ${EVENT_TEMPLATE_OR_STATEMENT}
    Check element display on screen     ${EVENT_TEMPLATE_INPUT_DROPDOWN}
    Check element display on screen     ${EVENT_TEMPLATE_CANCEL_ADD_OUTCOME_BUTTON}
    Check element display on screen     ${EVENT_TEMPLATE_OK_ADD_OUTCOME_BUTTON}
    Capture page screenshot

Verify session slide UI
    [Arguments]         ${event_type}
    Check element display on screen     ${EVENT_TEMPLATE_SESSION_NAME_TEXTBOX}
    Check element display on screen     ${EVENT_TEMPLATE_INTERVIEW_SESSION_INPUT}
    Check element display on screen     ${EVENT_TEMPLATE_INTERVIEW_TYPE_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_DURATION_HOURS_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_DURATION_MINUTES_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_INTERVIEW_PER_DURATION_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_ADD_INSTRUCTIONS_BUTTON}
    Check element display on screen     ${EVENT_TEMPLATE_CANCEL_ADD_SESSION_BUTTON}
    Element should be disabled          ${EVENT_TEMPLATE_CONFIRM_ADD_SESSION_BUTTON}
    Click at        ${EVENT_TEMPLATE_INTERVIEW_TYPE_SELECT}
    Check element display on screen     ${EVENT_TEMPLATE_SELECT_OPTIONS}       Phone interview
    Check element display on screen     ${EVENT_TEMPLATE_SELECT_OPTIONS}       Virtual interview
    Check element display on screen     ${EVENT_TEMPLATE_SELECT_OPTIONS}       Phone conversation
    Check element display on screen     ${EVENT_TEMPLATE_SELECT_OPTIONS}       Virtual meeting
    IF      '${event_type}' == 'In Person'
        Check element display on screen     ${EVENT_TEMPLATE_SELECT_OPTIONS}       In-person interview
    ELSE
        Check element not display on screen     ${EVENT_TEMPLATE_SELECT_OPTIONS}       In-person interview
    END
    Capture page screenshot

Verify overview tab of virtual display correctly
    ${is_checked} =      get value    ${INTERNAL_EVENT_NAME_CHECKBOX}
    Should be true      '${is_checked}' == 'true'
    Verify element is disable      ${PUBLISH_EVENT_TEMPLATE_BUTTON}
    Check label display     Public Template Name
    Check label display     Event Reporting Category
    Check label display     Campus
    Check label display     Is this a Campus specific event?
    Check element display on screen     ${INPUT_SELECT_EVENT_TYPE}
    Capture page screenshot

Verify closing message displayed correctly
    Check element not display on screen      ${EVENT_TEMPLATE_MESSAGE_CONTENT_BOX}     Thank you for your interest in
    Check element not display on screen      ${EVENT_TEMPLATE_MESSAGE_CONTENT_BOX}     . We will reach out to you within three business days.
    Check span display      \#company-name
    Click at    ${EVENT_TEMPLATE_OK_SAVE_OUTCOME_BUTTON}
    Capture page screenshot

Verify action select of defaul outcome
    [Arguments]     ${is_session_added}=True
    Check span display      Action
    IF      '${is_session_added}' == 'True'
        Check element display on screen         ${EVENT_TEMPLATE_DEFAULT_OUTCOME_ACTION_SELECT}    Register & Schedule to Event Interview
        Click at    ${EVENT_TEMPLATE_OUTCOME_ACTION_SELECT}
        Check element not display on screen     Register for Event
    ELSE
        Click at    ${EVENT_TEMPLATE_OUTCOME_ACTION_SELECT}
        Check element display on screen         ${EVENT_TEMPLATE_DEFAULT_OUTCOME_ACTION_SELECT}    Register for Event
    END
    Check element display on screen     Do Not Register & Send Closing Message
    Check element display on screen     Register & Schedule to Event Interview
    Click at    ${EVENT_TEMPLATE_OUTCOME_ACTION_SELECT}
    Capture page screenshot

Verify Registration match any location outcome copied correctly
    [Arguments]     ${location}     ${action}
    Check element display on screen     ${EVENT_TEMPLATE_DEFAULT_OUTCOME_ACTION_SELECT}     ${action}
    Click at    ${EVENT_TEMPLATE_CANCEL_ADD_OUTCOME_BUTTON}
