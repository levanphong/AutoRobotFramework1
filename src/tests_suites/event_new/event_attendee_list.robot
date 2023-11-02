*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/conversation_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    dev2    stg   olivia  birddoghr   advantage   aramark     lts_stg   test

*** Test Cases ***
Verify UI of the Virtual Event Homepage when it hasn't started (OL-T7607)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Check element display on screen    Candidates
    Capture Page Screenshot
    Click at    Candidates
    Check element not display on screen    Join Chat Booth
    Capture Page Screenshot


Verify dislaying the submenu items for the Candidates menu (OL-T7610)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Check element display on screen    My Candidates
    Check element display on screen    All Candidates
    Check element display on screen    Unassigned Candidates
    Capture Page Screenshot


Verify the user can only search candidates base on the name of candidates (OL-T7611)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Capture Page Screenshot
    Input Search box    ${candidate_name}
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot


Verify the user can filter candidates in Candidates lists same as the filter in the Event Inbox (OL-T7612)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    ${FILTER_BUTTON}
    Check element display on screen    Group
    Check element display on screen    Status
    Check element display on screen    Location
    Check element display on screen    Scheduling status
    Check element display on screen    Attendee Name
    Check element display on screen    Scheduled by
    Check element display on screen    Last contacted date
    Check element display on screen    Contacted by
    Check element display on screen    Recruiter phone number
    Check element display on screen    Source
    Check element display on screen    Start keyword
    Capture Page Screenshot


Verify the Export function at each list of candidates work correctly (OL-T7613)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    ${EXPORT_BUTTON}
    Check element display on screen    Export CSV
    Check element display on screen    Export PDF
    Check element display on screen    Export XLSX
    Capture Page Screenshot
# TODO: Need step to verify export success


Verify the user can add candidates manually from Candidates list in Event Homepage (OL-T7614)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot


Verify the columns dislays in the Candidates table for Virtual Chat Booth Hiring event (OL-T7615)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Check element display on screen    Name
    Check element display on screen    Phone Number
    Check element display on screen    Email
    Check element display on screen    Group
    Check element display on screen    Location
    Check element display on screen    Journey Status
    Check element display on screen    Assigned To
    Check element display on screen    Registered On
    Check element display on screen    Last Active
    Capture Page Screenshot


Verify only managers of the event can view the Unassigned Candidates tab (OL-T7616)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Click at    Candidates
    Check element display on screen    Unassigned Candidates
    Capture Page Screenshot
    Switch to user  EE Team
    Check element not display on screen    Unassigned Candidates
    Capture Page Screenshot


Verify show all candidates that have registered for the event in All Registered Candidates list view (OL-T7617)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot


Verify candidates registered to the event will be added to both the All Registered Candidates and Unassigned Candidates list views (OL-T7618)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot
    Click at    Unassigned Candidates
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot


Verify removing the current Event Candidate Inbox card in the Event Homepage in Hiring Event (OL-T7619)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Click at    Candidates
    Check element not display on screen    Candidates Inbox
    Capture Page Screenshot


Check a candidate will be removed out of the Unassigned Candidates list views once the candidate is assigned to a user (OL-T7620)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Switch to user    Full User Automation
    Choose Going event for user
    Capture Page Screenshot
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Assign a team member to candidate       Full User Automation
    Click at    Unassigned Candidates
    Check element not display on screen    ${candidate_name}
    Capture Page Screenshot


Check a candidate is added to selected user’s My Candidates list once the candidate is assigned to that user (OL-T7621)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step   Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Switch to user    Full User Automation
    Choose Going event for user
    Capture Page Screenshot
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Assign a team member to candidate       Full User Automation
    Switch to user    Full User Automation
    Click at    My Candidates
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot


Verify the mass action is only for Event Managers (OL-T7622)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot
    Switch to user    Full User Automation
    Click at    All Candidates
    Check element not display on screen     ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Check element not display on screen     ${ASSIGN_TEAM_MEMBER_BUTTON}
    Capture Page Screenshot


Verify displaying the name of the selected user in the 'Assigned To' column once the candidates are assigned New Version (OL-T7623)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Switch to user    Full User Automation
    Choose Going event for user
    Capture Page Screenshot
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Assign a team member to candidate   Full User Automation
    Verify assigned member    Full User Automation
    Capture Page Screenshot


Verify 'The Assigned To' column will always remain blank in the Unassigned Candidates list (OL-T7624)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Check element not display on screen    Full User Automation
    Capture Page Screenshot


Verify the mass action only applied for Virtual Chat Booth Hiring Event (OL-T7625)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User Automation
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Check element display on screen    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Click at    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Check element display on screen    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Capture Page Screenshot


Verify show Modal ‘Candidates Already Assigned’ when the candidate has a user already assigned to them at All Candidates list (OL-T7626, OL-T7627, OL-T7628)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Switch to user    Full User
    Choose Going event for user
    Capture Page Screenshot
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Assign a team member to candidate       Full User
    Capture Page Screenshot
    Click at    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Click at    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Candidates Already Assigned pop-up displayed
    Capture Page Screenshot
    Click at    ${CANCEL_BUTTON}
    Check element not display on screen    ${CANDIDATES_ALREADY_ASSIGNED_POPUP}
    Capture Page Screenshot
    Click at    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Click at    ${CONTINUE_BUTTON}
    Check element display on screen    Assign Team Member to Candidates
    Capture Page Screenshot


Verify the candidates ared displayed in the selected user’s My Candidates list after they assigned to selected user (OL-T7629)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Switch to user    Full User
    Choose Going event for user
    Capture Page Screenshot
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    ${candidate_name} =     Input CEM Full name and email
    Assign a team member to candidate       Full User
    Capture Page Screenshot
    Switch to user    Full User
    Click at    My Candidates
    Check element display on screen    ${candidate_name}
    Capture Page Screenshot


Verify UI of the 'Assign Team Member To Candidates' popup (OL-T7630)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Capture Page Screenshot
    Switch to user    Full User
    Choose Going event for user
    Capture Page Screenshot
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Click at    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Check element display on screen    1 Selected Candidate
    Check element display on screen    ${SHOW_MEMBER_BUTTON}
    Capture Page Screenshot
    Click at     ${SHOW_MEMBER_BUTTON}
    Check element display on screen    0 Assigned Candidates
    Capture Page Screenshot


Verify only users added into the 'Event Team Member' and have RSVP status is Going will be showed in the ‘Assign Team Member’ dropdown (OL-T7631)
    #TODO maintain
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Switch to user    Full User
    Choose Going event for user
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Click at    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Click at    ${SHOW_MEMBER_BUTTON}
    Check element display on screen    Full User
    Capture Page Screenshot


Verify only 1 team member is assigned in 'Choose a Team Member' dropdown when assign candidate to member. (OL-T7632)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Switch to user    Full User
    Choose Going event for user
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Click at    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Click at    ${SHOW_MEMBER_BUTTON}
    Click at    ${MEMBER_ASSIGN_TO_CANDIDATE}   Full User
    Verify selected team member    Full User
    Capture Page Screenshot


Verify the candidates are assigned to users those who change their RSVP status from Going to Not Going will be moved to Unassigned Candidates list (OL-T7633)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Switch to user    Full User
    Choose Going event for user
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Assign a team member to candidate       Full User
    Switch to user    Full User
    Click at        ${DASH_BOARD_NAVIGATION}
    Choose Not Going event for user
    Click at    Candidates
    Verify My candidates number    0
    Switch to user    ${TEAM_USER}
    Verify Unassigned candidates number    1


Verify the candidates ared displayed in the selected user’s My Candidates list after they assigned to selected user (OL-T7634)
    #TODO maintain
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Chat Booth
    Set Registration step
    Set Tools step
    when Register the event and back to event page    Candidate Test    ${CONST_PHONE_NUMBER}
    Click at    Candidates
    Click at    All Candidates
    Check element display on screen    Candidate Test


Verify the My Candidates list is the first list view that user sees when clicking on Candidates menu (OL-T7635)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None
    Set Tools step
    Switch to user    Full User
    Choose Going event for user
    Switch to user    ${TEAM_USER}
    Click at    Candidates
    Click at    Unassigned Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Assign a team member to candidate       Full User
    Switch to user    Full User
    Click at    Candidates
    Verify My candidates number    1


Verify there are no mass actions in the My Candidates List view (OL-T7636)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Click at    Candidates
    Click at    My Candidates
    Check element display on screen    ${SEARCH_BOX_DISABLED}
    Check element display on screen    ${EXPORT_BUTTON_DISABLED}


Verify an Ambassador can't assign the candidates to a user in the Virtual Chat Booth Hiring Event (OL-T7637)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Switch to user    Full User
    Click at    Candidates
    Check element not display on screen    Unassigned Candidates
    Click at    All Candidates
    Check element not display on screen    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Check element not display on screen    ${ASSIGN_TEAM_MEMBER_BUTTON}
    Click at    My Candidates
    Check element display on screen     ${SEARCH_BOX_DISABLED}
    Check element display on screen     ${EXPORT_BUTTON_DISABLED}


Check the Candidates list view for the Hiring Event that not Virtual Chat Booth (OL-T7638)
    #TODO maintain
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set tool step and create event
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Check element display on screen    Name
    Check element display on screen    Group
    Check element display on screen    Location
    Check element display on screen    Registered On
    Check element display on screen    Interview Date
    Check element display on screen    Interview Type
    Check element display on screen    Interview Session
    Check element display on screen    Interview Time
    Check element display on screen    Last Active


Verify the assignment logic is not applied for Hiring Event that not Virtual Chat Booth (OL-T7639)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set tool step and create event
    Click at    Candidates
    Check element not display on screen    My Candidates
    Check element not display on screen    Unassigned Candidates
    Click at    All Candidates
    Check element not display on screen    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Check element not display on screen    ${ASSIGN_TEAM_MEMBER_BUTTON}


Verify the Roster Candidates list view for the Orientation Event (OL-T7640)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set tool step and create event
    # TODO: Pending. Need to write request API to add a candidate.


Verify the assignment logic is not applied for Orientation Event (OL-T7641)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step    None
    Set tool step and create event
    Check element display on screen    Roster
    Click at    ${ROSTER_MENU_LABEL}
    Check element not display on screen    ${ASSIGN_TEAM_MEMBER_CHECKBOX}
    Check element not display on screen    ${ASSIGN_TEAM_MEMBER_BUTTON}


Verify the users can view the mini candidate profile when they select a candidate’s record (OL-T7642)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Team step    Full User
    Set Schedule step    Virtual Chat Booth
    Set tool step and create event
    Click at    Candidates
    Click at    All Candidates
    Click at    ${ADD_CANDIDATE_BUTTON}
    Input CEM Full name and email
    Click at    ${CANDIDATE_ROW}
    Check element display on screen    ${CANDIDATE_DETAIL}

*** Keywords ***
Candidates Already Assigned pop-up displayed
    wait with short time
    Check span display      Candidates Already Assigned
    ${message_content}=     Get text and format text        ${CANDIDATES_ALREADY_ASSIGNED_MESSAGE}
    should be equal as strings      ${message_content}      Based on the selection:1 of the selected candidates are already assigned to a user.By choosing to continue, all 1 candidate will be assigned to the selected user.
    Check element display on screen    ${CANCEL_BUTTON}
    Check element display on screen    ${CONTINUE_BUTTON}
