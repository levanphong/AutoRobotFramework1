*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
OL-40155 Verify Event Landing page display in candidate's timezone (OL-T11290)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Verify Even schedule timezone match the timezone provided in the Event card


OL-40155 - Verify Candidate Landing page display candidate's timezone (OL-T11291)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Verify Even schedule timezone match the timezone provided in the Event card


OL-39890 - Verify Event landing page display Join Session button when Event has Virtual session with ‘Hide Meeting URL and Password’ toggle is OFF (OL-T11292)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Live Video Broadcast
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Check element display on screen    ${JOIN_SESSION_BUTTON}
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Check element display on screen    ${JOIN_SESSION_BUTTON}


OL-39890 - Verify Event landing page does not display Join Session button when Event has Virtual session with ‘Hide Meeting URL and Password’ toggle is ON (OL-T11293)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step with Hide URL/Pass is ON
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Check element not display on screen    Join session button
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Check element display on screen    ${JOIN_SESSION_BUTTON}


OL-41553 - Verify sending notify to use when create an event for a Hiring event has Virtual Chat Booth session (OL-T11295)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    FU Team
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Check element display on screen    ${DASH_BOARD_NAVIGATION}
    Verify user has received the email    You're Invited to ${COMPANY_EVENT}'s Upcoming
    ...    Team user Invited You to ${COMPANY_EVENT}


Verify sending a Cancel notification to the registered candidates when the interview associated with that candidate is deleted (OL-T11579)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Add candidate into Interview Session
    Click at    Dashboard
    Click at    Setting icon
    Click at    Edit event
    Delete Session in the Event
    Save the edited Event    Virtual Scheduled Interviews
    Verify user has received the email    ${COMPANY_EVENT} needs to cancel    cancel your interview


OL-40149 - Verify closing check-in candidates after the users manually close check-in in the Event Homepage (OL-T11341)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    Paradox VN: CVS Health NCO
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set Registration step    None    None
    Set Tools step
    sleep    3s
    ${current_event_url} =    Get location
    Add a candidate to the Orientation Event    ${event_name}
    Go back to Orientation Event page    ${current_event_url}
    Click at    CHECKIN CANDIDATES CARD
    Click at    CLOSE CHECKIN BUTTON
    Click at    CONFIRM CLOSE CHECKIN BUTTON
    Check element not display on screen    ${CHECKIN_CANDIDATES_CARD}
    Click at    Roster
    Click at    CANDIDATE ROW
    Click at    BACK TO CANDIDATES BUTTON
    Click at    Dashboard
    Check element not display on screen    ${CHECKIN_CANDIDATES_CARD}


OL-40027 - Verify the candidate received the roster link notifications when the event is edited (OL-T11342)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    Paradox VN: CVS Health NCO
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set Registration step    None    None
    Set Tools step
    sleep    3s
    ${current_event_url} =    Get location
    Add a candidate to the Orientation Event    ${event_name}
    Go back to Orientation Event page    ${current_event_url}
    Click at    Setting icon
    Click at    Edit event
    Change Event end time
    Verify user has received the email    Your registration for Paradox VN    Changes have been made


OL-43630 - Verify the candidate is able click to select Orientation on the calendar only 1 time (OL-T11422)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    Paradox VN: CVS Health NCO
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set Registration step    None    None
    Set Tools step
    Add a candidate to the Orientation Event    ${event_name}
    Check element display on screen    ${ORIENTATION_LANDING_CHAT}


Verify sending all open interview times from the initial session(s) selected within the outcome(rule) applied to the candidate when the candidate reschedule interview (OL-T11573)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set multiple Session in event
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Go to register calendar    Candidate Test    ${CONST_PHONE_NUMBER}
    Check number of session    3


Verify sending all open interview times from the session selected by the User when they were manually scheduling a candidate and the candidate reschedule interview associated with the event (OL-T11576)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Switch to user    FU Team
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Wait with short time
    Go to CEM page
    Click at    ADD NEW CANDIDATE BUTTON
    Input candidate info
    Schedule candidate into Event    ${event_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    Do any of these times work for you?
    Reschedule the interview
    Check number of session    1


Verify sending all open interview times of the session that the user added the candidate in Schedule tab in Event Homepage then the candidate reschedule the interview (OL-T11577)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Switch to user    FU Team
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    Candidate Menu Label
    Click at    All Registered Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    First member
    Schedule candidate into Event    ${event_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    Do any of these times work for you?
    Reschedule the interview
    Check number of session    1


OL-45643 - Verify offering correct event orientations when schedule a candidate who has no Location assigned (OL-T12465)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    Paradox VN: CVS Health NCO
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    Go to CEM page
    Create candidate for Orientation Event with invalid location
    Click at    FIRST CONVERSATION
    Verify conversation status changed    updated status from Invite To Orientation to Registration Pending


OL-43299 - Verify offering correct event orientations when setting the scheduling conditions is not Area (OL-T11420)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    Paradox VN: CVS Health NCO
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set Registration step with Location is not    CVS Location
    Set Tools step
    Create candidate for Orientation Event with custom location id    cvs1
    Click button in email    Schedule your Orientation with Paradox VN: CVS Health NCO.
    ...    Schedule your Orientation with Paradox VN: CVS Health NCO.
    Check element not display on screen    ${event_name}


OL-43299 - Verify offering correct event orientations when setting the scheduling conditions Is Area (OL-T11421)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    Paradox VN: CVS Health NCO
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Choose Event type    Orientation
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set Registration step with Location is    CVS Location
    Set Tools step
    Create candidate for Orientation Event with custom location id    cvs1
    Click button in email    Schedule your Orientation with Paradox VN: CVS Health NCO.
    ...    Schedule your Orientation with Paradox VN: CVS Health NCO.
    Check element display on screen    ${event_name}
    Create candidate for Orientation Event with custom location id    cvs2
    Click button in email    Schedule your Orientation with Paradox VN: CVS Health NCO.
    ...    Schedule your Orientation with Paradox VN: CVS Health NCO.
    Check element not display on screen    ${event_name}


Verify sending all open interview times from the initial session(s) selected within the outcome(rule) applied to the candidate when the action outcome is changed then the candidate reschedule interview (OL-T11574)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Switch to user    FU Team
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step with custom outcome
    Set Schedule step    Live Video Broadcast
    Set Tools step
    sleep    3s
    ${event_page} =    Get location
    Click at    Candidate Menu Label
    Click at    All Registered Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    First member
    Schedule candidate into Event    ${event_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    Do any of these times work for you?
    Click at    BOOK TIME BUTTON
    sleep    3s
    ${schedule_page} =    Get location
    Change Action in Outcome    ${event_page}
    go to    ${schedule_page}
    Reschedule the interview with new outcome    ${schedule_page}
    Check number of session    1


Verify sending all open interview times from the initial session(s) selected within the outcome(rule) applied to the candidate when the outcome is deleted then the candidate reschedule interview (OL-T11575)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}
    when Go to Events page
    Switch to user    FU Team
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step with custom outcome
    Set Schedule step    Live Video Broadcast
    Set Tools step
    sleep    3s
    ${event_page} =    Get location
    Click at    Candidate Menu Label
    Click at    All Registered Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    First member
    Schedule candidate into Event    ${event_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    Do any of these times work for you?
    Click at    BOOK TIME BUTTON
    sleep    3s
    ${schedule_page} =    Get location
    Delete an Outcome    ${event_page}
    go to    ${schedule_page}
    Reschedule the interview with new outcome    ${schedule_page}
    Check number of session    1
