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

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***

*** Test Cases ***
Verify the Scheduling widget display New design when turn ON New Scheduling UI/UX toggle (OL-T13377)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    Then Check the Scheduling modal is displayed in New UI/UX
    capture page screenshot


Verify User can add maximum 6 interviews (OL-T13949)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      3
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      4
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      5
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      6
    Check element not display on screen     ${ADD_INTERVIEW_BUTTON}
    capture page screenshot


Verify Determine Scheduling Approach will display in Advanced Setting when Interview type is Sequential interview (OL-T13950)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when select attendes when for sub interview     ${CP_TEAM}
    when Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Then Check element not display on screen    ${COMMON_LABEL_TEXT}    Determine Scheduling Approach
    capture page screenshot


Verify UI of comfirmation modal when User send interview request (OL-T14348)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when select attendes when for sub interview     ${CP_TEAM}
    when Choose interview type      Virtual Interview
    when click on positive button       Let Olivia Schedule
    Then Check the modal will show a micro animation to close out the scheduling process.
    And Check element display on screen     ${SCHEDULE_AN_INTERVIEW_SCHEDULE_CONFIRM_STATUS}    Interview Pending
    capture page screenshot
    check text display      Interview Summary
    capture page screenshot
    when click at       ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Then Check the scheduling modal will be closed
    And Check status on profile CEM     Interview Pending


Verify Olivia assistant is removed from Scheduling widget (OL-T15122,OL-T15123)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    go to CEM page
    switch to user      ${AUTO_EDIT}
    ${candidate_name} =     add a candidate
    Open schedule module
    then check element not display on screen    ${OLIVIA_ASSIST_TEXT}
    capture page screenshot
    Then Check Candidate's detail is shown in Scheduling widget     ${candidate_name}       No Job Assigned     No Location Assigned
    capture page screenshot


Verify User can see full candidate information when hovering the card (OL-T15124)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    ${candidate_name} =     select candidate has capture complete and open schedule interview module
    Then Check Candidate's detail is shown in Scheduling widget     ${candidate_name}       No Job Assigned
    ...     No Location Assigned
    hover at    ${CANDIDATE_DETAIL_INFO_STATUS_CAPTURE}
    Then Check candidate information will be displayed full information     No Job Assigned
    capture page screenshot
    Then Check candidate information will be displayed full information     No Location Assigned
    capture page screenshot


Verify UI of the scheduling product in simplest version (OL-T15125)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    go to Client setup page
    Turn on/off Advanced Setting in Client Setup    On
    Turn off toggle Advanced Setting
    Turn off toggle Interview Prep
    go to CEM page
    switch to user      CA Team
    ${candidate_name} =     add a candidate
    Open schedule module
    Check schedule type exist       Interview
    Then Check the Scheduling modal is displayed in New UI/UX design with basic info
    Then Check Candidate's detail is shown in Scheduling widget     ${candidate_name}       No Group Assigned
    ...     No Location Assigned
    select attendes when for sub interview      CA Team


Verify interview type dropdown display all selected types (from client setup) at Interview Detail - Builder (OL-T15126)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    click at    ${SCHEDULE_AN_INTERVIEW_INV_TYPE}
    Then Check the interview type dropdown display all selected types (from Client Setup)
    And Check element not display on screen     ${SCHEDULE_MODULE_INV_TYPE}     Sequential interview
    capture page screenshot


Verify the list of “most frequent” times will display once clicking on Duration section (OL-T15127)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when click at       ${DURATION_INPUT}
    Then Check the list times including
    Click by JS     ${DURATION_TIME_OPTION}     20 min
    click at    ${DURATION_CUSTOM_APPLY_BTN}
    wait for page load successfully
    Then Check the Duration section display time    20 min


Verify User can input the amount of hours/minutes for the duration (OL-T15128)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when click at       ${DURATION_INPUT}
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    element should be enabled       ${DURATION_CUSTOM_INPUT_HOUR}
    element should be enabled       ${DURATION_CUSTOM_INPUT_MIN}
    when input into     ${DURATION_CUSTOM_INPUT_MIN}    25
    click at    ${DURATION_CUSTOM_APPLY_BTN}
    wait for page load successfully
    Then Check the Duration section display time    25 min


Verify the minute textbox automatically jumps to the most valid number divisible by 5 when user enter a number not divisible by 5 (OL-T15129)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when click at       ${DURATION_INPUT}
    Then Check the list times including
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    when input into     ${DURATION_CUSTOM_INPUT_MIN}    13
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    Then Check the Min textbox display      15


Verify the hour textbox automatically jumps to the most valid number 0~6 when user enter another number 0~6 (OL-T15131)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when click at       ${DURATION_INPUT}
    Then Check the list times including
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    when input into     ${DURATION_CUSTOM_INPUT_HOUR}       7
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    Then Check the hour textbox display     6


Verify the hour/min textbox automatically jumps to 0 when enter minutes or hour <0 (OL-T15132)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when click at       ${DURATION_INPUT}
    Then Check the list times including
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    when input into     ${DURATION_CUSTOM_INPUT_HOUR}       -1
    when Click by JS    ${DURATION_TIME_OPTION}     Custom
    Then Check the hour textbox display     0


Verify Location Selection work correctly same as current logic (OL-T15133)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    Click on candidate name     ${candidate_name}
    Open schedule module
    When Choose interview type      In-Person Interview
    Then Check element display on screen    ${LOCATION_INPUT}
    Then Choose location    Location_schedule
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Click by JS     ${INTERVIEWER_LOCATOR}      Location schedule       slow_down=2s


Verify Room field will be disabled until user choose the location for in-person interview (OL-T15134)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    Click on candidate name     ${candidate_name}
    Open schedule module
    When Choose interview type      In-Person Interview
    Element Should Be Disabled      ${ROOM_BUTTON}
    capture page screenshot
    Then Choose location    Location_schedule
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Click by JS     ${INTERVIEWER_LOCATOR}      Location schedule       slow_down=2s
    Element Should Be Enabled       ${ROOM_BUTTON}
    capture page screenshot


Verify Room field will be disabled when location has no rooms (OL-T15135)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    Click on candidate name     ${candidate_name}
    Open schedule module
    When Choose interview type      In-Person Interview
    Then Choose location    Location_schedule_no_room
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Click by JS     ${INTERVIEWER_LOCATOR}      Location schedule       slow_down=2s
    Element Should Be Disabled      ${ROOM_BUTTON}
    capture page screenshot


Verify Room booking work correctly same logic as current (OL-T15136)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    Click on candidate name     ${candidate_name}
    Open schedule module
    When Choose interview type      In-Person Interview
    Check element display on screen     ${ROOM_BUTTON}
    check element display on screen     ${LOCATION_INPUT}
    capture page screenshot
    Then Choose location    Location_schedule


Verify “Add Interviewers” dropdown will show available users based on their role (OL-T15137)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    Click on candidate name     ${candidate_name}
    Open schedule module
    When Choose interview type      Phone Interview
    check span display      Interviewers
    Click at    ${INTERVIEWER_BUTTON}
    check text display      Round Robin Groups
    check text display      Users
    When Choose interview type      In-Person Interview
    Check element display on screen     ${ROOM_BUTTON}
    check element display on screen     ${LOCATION_INPUT}
    capture page screenshot
    Then Choose location    Location_schedule
    Click at    ${ADD_INTERVIEWER_BUTTON}
    check text display      Location schedule
    capture page screenshot


Verify User roles in Interviewers dropdown should include Full User and Basic User (OL-T15138)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    go to Client setup page
    Scroll to element       ${SCHEDULING_LABEL}
    Click on strong text    Scheduling
    wait for page load successfully
    @{list_location_calendar} =     Get all location calendar
    logout from system by URL
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_FRANCHISE_ON}
    ${candidate_name} =     add a candidate
    Open schedule module
    Check schedule type exist       Interview
    when Choose interview type      In-Person Interview
    Click at    ${LOCATION_INPUT}       slow_down=2s
    Input into      ${SEARCH_FOR_A_LOCATION_TEXTBOX}    Schedule Location
    Wait with short time
    Click by JS     ${SCHEDULE_LOCATION_PRIVATE_OPTIONS}    Schedule Location
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Then Check Location Calendars role should display all Location Calendars from Client Setup      @{list_location_calendar}


Verify Location Calendars role will not be shown in Interviewers dropdown when company has Location Calendar AND interview does not have location (OL-T15140)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    go to Client setup page
    Scroll to element       ${SCHEDULING_LABEL}
    Click on strong text    Scheduling
    wait for page load successfully
    @{list_location_calendar} =     Get all location calendar
    go to CEM page
    switch to user      ${AUTO_EDIT}
    select candidate has capture complete and open schedule interview module
    when Choose interview type      In-Person Interview
    when Click at       ${SCHEDULE_AN_INTERVIEW_ADD_ATTENDEES}
    length should be    ${list_location_calendar}       0
    Then Check element not display on screen    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}     Gardening
    capture page screenshot


Verify Location Calendar is not shown in Attendee dropdown if interview has location BUT having no location calendar in Client Setup (OL-T15141)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when Choose interview type      Virtual Interview
    when Click at       ${SCHEDULE_AN_INTERVIEW_ADD_ATTENDEES}
    Then Check element not display on screen    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}     Gardening
    capture page screenshot


Verify Round Robin Groups role will be shown in Interviewers dropdown when Company has available RR (OL-T15142)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}
    select candidate has capture complete and open schedule interview module
    when Click at       ${SCHEDULE_AN_INTERVIEW_ADD_ATTENDEES}
    Then check element display on screen    ${ROUND_ROBIN_INTERVIEWER}
    capture page screenshot


Verify RR role will not be shown in Interviewers dropdown when company has no RR (OL-T15143)
    Given Setup test
    Login into system with schedule company with full user      ${EE_TEAM}      Test Automation Flexible Hire Option
    ${candidate_name} =     add a candidate
    Open schedule module
    when Choose interview type      Virtual Interview
    when Click at       ${SCHEDULE_AN_INTERVIEW_ADD_ATTENDEES}
    Then Check element not display on screen    ${ROUND_ROBIN_INTERVIEWER}
    capture page screenshot


Verify Add Interview button should be shown when Company has at least 1 type of sequential interview (OL-T15160)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    when At CEM, select an candidate
    Open schedule module
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check element display on screen    ${ADD_INTERVIEW_BUTTON}
    capture page screenshot


Verify clicking on Add Interview will insert another interview into the list (OL-T15161)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    when At CEM, select an candidate
    Open schedule module
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    Then Check newly added interviews should default their configuration to the same type and duration as the previous interview


Verify Intereview Summary displays name and duration of all sub-interviews (OL-T15163)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Check user can add maximum 6 interviews
    Then Check the interview summary changes to display the titles of all interviews added and their length
    Check text display      3 hours
    capture page screenshot


Verify user can delete sub-interview in Sequential interview (OL-T15164)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Check user can add maximum 6 interviews
    Check the sub-interview will be removed from interview


Verify button Move Interview Above is not shown in the first sub-interview (OL-T15165)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    Then Check button Move Interview Above is not shown     Move Interview Above
    Then Check button Move Interview Above is shown     Move Interview Above


Verify button Move Interview Below is not shown in the last sub-interview (OL-T15166)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    Select ellipses sub_interview       1
    Check span display      Move Interview Below
    Select ellipses sub_interview       1
    Then Check button Move Interview Below is not shown     Move Interview Below


Verify the sub-interview can be moved up one slot in the order of interviews by clicking Move Interview Above (OL-T15167)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      3
    Check position of interview     2       1       Move Interview Above


Verify the sub-interview can be moved down one slot in the order of interviews by clicking Move Interview Below (OL-T15168)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      3
    Check position of interview     2       3       Move Interview Below


Verify More option is not shown when just adding one sub interview (OL-T15169)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Then Check number scheduling interview      1
    Then Check element not display on screen    ${INTERVIEW_DETAILS_ELLIPSES_SUB_LOCATOR}       1
    capture page screenshot


Verify the sub-interview should be expanded once clicking on Expand icon (OL-T15170)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      3
    When CLick at       ${INTERVIEW_DETAILS_EXPAND_ICON}    1
    wait with short time
    Then Check info detail interview builder


Verify the sub-interview should be collapsed once clicking on Collapsed icon (OL-T15171)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    when Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      3
    When CLick at       ${INTERVIEW_DETAILS_EXPAND_ICON}    3
    Then Check the sub-interview will be collapsed


Verify the collapsed sub-interview should show count of interviewers when interviewers names are too long (OL-T15172)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    When CLick at       ${INTERVIEW_DETAILS_EXPAND_ICON}    2
    When CLick at       ${INTERVIEW_DETAILS_EXPAND_ICON}    1
    When Click at       ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     FO Team
    When CLick at       ${INTERVIEW_DETAILS_EXPAND_ICON}    1
    wait with short time
    Then Check the sub-interview will be collapsed


Verify the Interview Type option is not shown when schedule single interview (OL-T15173)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Then Check Interview Type option is not shown on Interview Builder


Verify the Interview Type option is not shown when having only 1 sequential interview type in Client Setup (OL-T15174, OL-T15175)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    When Go to Client setup page
    When Select having only 1 sequential interview type in Client Setup     Sequential Interview
    When Go to CEM page
    When switch to user     EE Team
    Add new candidate and open schedule modal
    Click at    ${INTERVIEW_SCHEDULE_TYPE}
    When Click at       ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     Hiring Team
    Then Check Interview Type option is not shown on Interview Builder
    Send interview and click close button
    capture page screenshot
    logout from system by URL
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    @{list_interview_type}=     Create list     Phone Conversation      Virtual Meeting     Sequential Interview    Sequential Meeting      Sequential Session
    When Select multiples sequential interview type in Client Setup     @{list_interview_type}
    Go to CEM page
    When switch to user     EE Team
    Add new candidate and open schedule modal
    Click at    ${INTERVIEW_SCHEDULE_TYPE}
    When Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    Then Check Interview Type option will appear at the start of the interview builder
    When CLick at       ${INTERVIEW_DETAILS_EXPAND_ICON}    1
    Then Check info detail interview builder


Verify the Interview Type dropdown is shown when having more than 3 sequential interview type in Client Setup (OL-T15176)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${sequential_name}=     Add more sequential interview type in Client Setup
    @{list_interview_type}=     Create list     Phone Conversation      Virtual Meeting     Sequential Interview    Sequential Meeting      Sequential Session      ${sequential_name}
    When Select multiples sequential interview type in Client Setup     @{list_interview_type}
    When Go to CEM page
    When switch to user     EE Team
    Add new candidate and open schedule modal
    Click at    ${INTERVIEW_SCHEDULE_TYPE}
    When Click at       ${ADD_INTERVIEW_BUTTON}
    Then Check number scheduling interview      2
    Then Check Interview Type dropdown will appear at the start of the interview builder


Verify Scheduling Timeline in Advanced Setting work correctly (OL-T15177)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    When Choose interview type      Phone Interview
    When Click at       ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     Hiring Team
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${SCHEDULING_TIMELINES_TOGGLE}
    Then Check User can select Scheduling Timeline same as current logic    1 hour      1 day
    Send interview and click close button
    Then Check send interview request to candidate successfully     would like to schedule      ${candidate_name}


Verify Limit Canceling and Rescheduling Interviews in Advanced Setting works correctly (OL-T15178)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    When Choose interview type      Phone Interview
    Click at    ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     EE Team
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${LIMIT_RESCHEDULING_INTERVIEWS_TOGGLE}
    Then Check Check User can select Limit Canceling and Rescheduling Interviews same as current logic      Until 5 hours before    Two times
    Send interview and click close button
    Then Check send interview request to candidate successfully     would like to schedule      ${candidate_name}


Verify Have Attendee Schedule Interview in Advanced Setting works correctly (OL-T13379)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    When Go to Client setup page
    When Select Basic User Access       Basic User Portal - Tasks
    When Go to CEM page
    When switch to user     EE Team
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    When Choose interview type      Phone Interview
    Click at    ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     Basic User
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${HAVE_ATTENDEE_SCHEDULE_INTERVIEW_TOGGLE}
    When Click at       ${SELECT_INTERVIEWER_INPUT}
    When Click at       ${BASIC_USER_SPAN}      Basic User
    Send interview and click close button
    Verify user has received the email      Schedule Interview with     Basic       NEW_TASK


Verify Travel Required will be added in Advanced Setting (OL-T15183)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    When Choose interview type      In-Person Interview
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Then Check element display on screen    ${COMMON_LABEL_TEXT}    Travel Required
    capture page screenshot
    Check element display on screen     ${TRAVEL_REQUIRED_TOGGLE}
    capture page screenshot


Verify there're 3 options in Determine Scheduling Approach (OL-T15184)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Then Check element display on screen    ${COMMON_LABEL_TEXT}    Determine Scheduling Approach
    capture page screenshot
    Then Check display 3 options: Consecutive In-Order, Consecutive Any Order, Consecutive Over Multiple Days


Verify the main button will be changed base on the selection in Determine Scheduling Approach (OL-T15185)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${ADD_INTERVIEW_BUTTON}
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Then Main button will be changed base on the selection in Determine Scheduling Approach


Verify Olivia send interview request in-order times once clicking on Schedule In-Order Times (OL-T15186)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    Click on candidate name     ${candidate_name}
    Open schedule module
    Select info for 2 sub-interview     30 min      CA Team     Recruiter Team
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Send interview and click close button
    Then Verify user has received the email     would like to schedule      ${candidate_name}


Verify Candidate Timezone functionally should be displayed in Advanced Setting (OL-T15193)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Check toggle is Off     ${CANDIDATE_TIMEZONE}
    When Turn on    ${CANDIDATE_TIMEZONE}
    check span display      Update Timezone
    capture page screenshot


Verify Candidate should receive interview times in the timezone selected by the user (OL-T15194)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    Click on candidate name     ${candidate_name}
    Open schedule module
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      CA Team
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${CANDIDATE_TIMEZONE}
    Select timezone on schedule module      Asia/Ho_Chi_Minh (ICT)
    When Send interview and click close button
    Then Verify user has received the email     would like to schedule      ${candidate_name}   WOULD_LIKE_SCHEDULE_PHONE_ITV


Verify Candidate should receive interview times in the User's timezone according to configuration from client setup when Candidate Timezone toggle is OFF (OL-T15196)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    Click on candidate name     ${candidate_name}
    Open schedule module
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      CA Team
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn off       ${CANDIDATE_TIMEZONE}
    When Send interview and click close button
    Then Verify user has received the email     would like to schedule      ${candidate_name}       WOULD_LIKE_SCHEDULE_PHONE_ITV


Verify interview slot 's timezone when both of 2 toggle ( Client Setup and Advance Setting > Candidate tz) ON (OL-T15198)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    Click on candidate name     ${candidate_name}
    Open schedule module
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      CA Team
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${CANDIDATE_TIMEZONE}
    Select timezone on schedule module      Asia/Ho_Chi_Minh (ICT)
    When Send interview and click close button
    Then Verify user has received the email     would like to schedule      ${candidate_name}   WOULD_LIKE_SCHEDULE_PHONE_ITV


Verify Private Calendar Event in Advanced Setting works correctly (OL-T15180)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    When Choose interview type      Phone Interview
    Click at    ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     FS Team
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${PRIVATE_CALENDAR_EVENT_TOGGLE}
    Send interview and click close button
    Then Check logic of Private Calendar Event work correctly same as current logic     ${candidate_name}
    wait with medium time
    Then Verify user has received the email     Your phone interview    ${candidate_name}       YOUR_PHONE_INTERVIEW


Verify Virtual Interview URL in Advanced Setting works correctly (OL-T15181)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    When Choose interview type      Phone Interview
    When Click at       ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     EN Team
    When Click at       ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    When Turn on    ${VIRTUAL_INTERVIEW_URL_TOGGLE}
    Send interview and click close button
    Then Check logic of Virtual Interview URL work correctly same as current logic      ${candidate_name}
    wait with medium time
    Then Verify user has received the email     Your phone interview    ${candidate_name}       YOUR_PHONE_INTERVIEW


Verify Interview modal works correctly within custom interview type. (OL-T15192)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${interview_type}=      Add new interview type      Phone Interview
    go to CEM page
    switch to user      EE Team
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    click at    ${SCHEDULE_AN_INTERVIEW_INV_TYPE}
    Click at    ${SCHEDULE_AN_INTERVIEW_INV_VIRTUAL_TYPE}       ${interview_type}
    Click at    ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     EE Team
    Send interview and click close button
    Verify user has received the email      would like to schedule      ${candidate_name}
    go to CEM page
    switch to user      ${TEAM_USER}
    go to Client setup page
    Delete a interview type     ${interview_type}


Verify Interview request should be sent in Any Order times when user has no OIT for In-order Times (OL-T15189)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Go to Users, Roles, Permissions page
    ${first_name_1}=    Add a User      role=${EDIT_EVERYTHING}
    ${first_name_2}=    Add a User      role=${EDIT_EVERYTHING}
    ${candidate_name}=      Delete OIT, set OIT for any oder and set 2 sub-interview to schedule    ${first_name_1}     ${first_name_2}     1 hour
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Send interview and click close button
    Click button in email       would like to schedule      ${candidate_name}
    Deactivate two Users    ${first_name_1}     ${first_name_2}


Verify Determine Scheduling Approach should change to Any-Order when the user has no available times for In-Order (OL-T15187)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Go to Users, Roles, Permissions page
    ${first_name_1}=    Add a User      role=${EDIT_EVERYTHING}
    ${first_name_2}=    Add a User      role=${EDIT_EVERYTHING}
    Delete OIT of user      ${first_name_1}
    Delete OIT of user      ${first_name_2}
    go to CEM page
    switch to user      ${first_name_1}
    Select time for user    ${TIME_7H_AM}       ${TIME_8H_AM}
    go to CEM page
    switch to user      ${first_name_2}
    Select time for user    ${TIME_8H_AM}       ${TIME_9H_AM}
    go to CEM page
    When switch to user     EE Team
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    Select info for 2 sub-interview     1 hour      ${first_name_2}     ${first_name_1}
    Select Determine Scheduling Approach    Consecutive In-Order
    Click at    ${FIND_TIMES_BUTTON}
    Check span display      Consecutive Any Order
    capture page screenshot
    Click at    ${FIND_TIMES_BUTTON}
    Click button in email       would like to schedule      ${candidate_name}
    Deactivate two Users    ${first_name_1}     ${first_name_2}


Verify Determine Scheduling Approach should change to Multiple Day when the user has no available times for In Any Order (OL-T15188)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Go to Users, Roles, Permissions page
    ${first_name_1}=    Add a User      role=${EDIT_EVERYTHING}
    ${first_name_2}=    Add a User      role=${EDIT_EVERYTHING}
    ${candidate_name}=      Delete OIT, set OIT for in oder and set 2 sub-interview to schedule     ${first_name_1}     ${first_name_2}     30 min      timezone
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON}
    Click by JS     ${DETERMINE_SCHEDULING_APPROACH_BUTTON_OPTION}      Consecutive In-Order    slow_down=4s
    Click at    ${FIND_TIMES_BUTTON}
    Check info Determine Scheduling Approach    Schedule Over Multiple Days     There are no available times for this interview in any order. You can either schedule over multiple days, or schedule over busy time in Choose a Time.
    Send interview and click close button
    Click View more button in email     would like to schedule      ${candidate_name}       index_button=0
    Then Select time for interview with multiple days
    wait with medium time
    Verify user has received the email      Your sequential interview at    ${candidate_name}       SEQUENTIAL_UPDATE
    Deactivate two Users    ${first_name_1}     ${first_name_2}


Verify Interview request should be sent In-Order times when user has OIT for In-order Times (OL-T15190)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Inorder1 Schedule       Inorder2 Schedule
    Send interview and click close button
    Click button in email       would like to schedule      ${candidate_name}
    Select time slot options
    wait with medium time
    Verify user has received the email      Your sequential interview at    ${candidate_name}       SEQUENTIAL_UPDATE


Verify Interview request should be sent in Multiple Days when user select Consecutive Over Multiple Days (OL-T15191)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Add a new candidate and select interviewer to schedule      30 min      Multiple1 Confirmation      Multiple2 Confirmation
    Select Determine Scheduling Approach    Schedule Over Multiple Days
    capture page screenshot
    Send interview and click close button
    Click View more button in email     would like to schedule      ${candidate_name}       index_button=1
    Then Select time for interview with multiple days
    Wait with medium time
    Verify user has received the email      Your sequential interview at    ${candidate_name}       SEQUENTIAL_UPDATE


Verify Candidate's timezone is not changed after User update Candidate Timezone from Advanced Setting (OL-T15195)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    When Click at       ${INTERVIEWER_BUTTON}
    When Select interviewers for sub-interviews     EE Team
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Turn on     ${CANDIDATE_TIMEZONE}
    Select timezone on schedule module      Asia/Ho_Chi_Minh (ICT)
    When Send interview and click close button
    Then Verify user has received the email     would like to schedule      ${candidate_name}   WOULD_LIKE_SCHEDULE_PHONE_ITV


Verify Location Calendars role will be shown in Interviewers dropdown when Company has Location Calendar AND Interview type has location( In-Person/ Group Itv) (OL-T15139)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Navigate to Option in client setup      Scheduling
    check element display on screen     ${LOCATION_CALENDAR_NAME}
    capture page screenshot
    @{list_location_calendar} =     Get all location calendar
    When Go to CEM page
    When switch to user     EE Team
    Add new candidate and open schedule modal
    when Choose interview type      In-Person Interview
    Capture page screenshot
    When Choose location    Location_schedule
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Click by JS     ${INTERVIEWER_LOCATOR}      Location schedule       slow_down=2s
    Then Check Location Calendars role should display all Location Calendars from Client Setup      @{list_location_calendar}


Check Interview Sumarry should be updated when user update the interview detail builder (OL-T15154)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    when Choose interview type      Virtual Interview
    When Choose duration time to schedule       20 min
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EE Team
    Check element display on screen     ${INTERVIEW_SUMMARY_OPTION}     Virtual Interview
    Check element display on screen     ${INTERVIEW_SUMMARY_OPTION}     20 min
    Check element display on screen     ${INTERVIEW_SUMMARY_OPTION}     EE Team
    capture page screenshot


Verify Interview Prep logic works correctly (OL-T15155)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    go to Interview Prep page
    Add a new Interview Prep    Candidates
    Click at    ${INTERVIEW_PREP_TAB}       Candidate
    User can edit interview prep
    Click at    ${INTERVIEW_PREP_TAB}       Users
    Add a new Interview Prep    Users
    User can edit interview prep
    Go to CEM page
    Add new candidate and open schedule modal
    Then Check UI of Interview Prep


Verify the scroller should not be shown when having 5 interviewer added to interview (OL-T15149, OL-T15150)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      FO Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      FS Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EN Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EE Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      Hiring Team
    Check span display      (5)
    Then Check count interviewer    5
    Check element not display on screen     ${SCROLL_INTERVIEWER_LOCATOR}
    capture page screenshot
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      Recruiter Team
    Then Check count interviewer    6
    Check element display on screen     ${SCROLL_INTERVIEWER_LOCATOR}
    capture page screenshot


Verify User can remove interviewer from the interview by clicking on 'X' (OL-T15153)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      FO Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      FS Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EN Team
    Check span display      (3)
    capture page screenshot
    Then Check count interviewer    3
    Click at    ${ICON_REMOVE_INTERVIEWER_LOCATOR}      3
    Check span display      (2)
    Then Check count interviewer    2
    capture page screenshot


Verify User can multi-select interviewers by selecting a user in Interviewes dropdown (OL-T15145)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Click by JS     ${INTERVIEWER_LOCATOR}      FO Team
    Click by JS     ${INTERVIEWER_LOCATOR}      FS Team
    Click by JS     ${INTERVIEWER_LOCATOR}      EN Team
    Click at    ${APPLY_TIME_BUTTON}
    Check span display      (3)
    capture page screenshot
    Then Check count interviewer    3


Verify User can add more Users/groups after added Users/group for interviewers (OL-T15146)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      FS Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EN Team
    Check span display      (2)
    capture page screenshot
    Then Check count interviewer    2


Verify the main CTAs show error sticky when missing value required (OL-T15157)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    when Choose interview type      In-Person Interview
    Click at    ${FIND_TIMES_BUTTON}
    Check element display on screen     ${WARNING_BUTTON}
    capture page screenshot
    When Hover at       ${WARNING_BUTTON}
    Check text display      is missing required information.
    capture page screenshot


Verify Round Robin Groups should be expandable to see the full list of users added to the group (OL-T15151)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      Round_robin_with_6_users
    Check span display      (1)
    Then Check count interviewer    1
    Click at    ${EXPAND_ICON_RR}       Round_robin_with_6_users
    @{users}=       Create List     FO Team     FS Team     EN Team     EE Team     Hiring Team     Recruiter Team
    Then Check the RR is expandable to see full list of users added to the group    @{users}
    Check element display on screen     ${SCROLL_INTERVIEWER_RR_LOCATOR}
    capture page screenshot


Verify Add Instruction show the section expanded with the default text when instructions are defaulted based on the user’s profile (OL-T15156)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EE Team
    Check span display      This is the interview instructions


Verify Interview Teams should be expandable to see the full list of users added to the group (OL-T15152)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    Add new candidate and open schedule modal
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      Round_robin_with_6_users
    Check span display      (1)
    Then Check count interviewer    1
    Click at    ${EXPAND_ICON_RR}       Round_robin_with_6_users
    @{users}=       Create List     FO Team     FS Team     EN Team     EE Team     Hiring Team     Recruiter Team
    Then Check the RR is expandable to see full list of users added to the group    @{users}
    Check element display on screen     ${SCROLL_INTERVIEWER_RR_LOCATOR}
    capture page screenshot


Verify user's role should be shown on the interviewer list when interviewers is Hiring Manager on Job (OL-T15147, OL-T15148)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_FRANCHISE_ON}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate     None    ${LOCATION_NAME_2}      Firefighter     None
    Click on candidate name     ${candidate_name}
    Open schedule module
    Check schedule type exist       Interview
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      EN Team
    Check span display      (1)
    capture page screenshot
    Then Check count interviewer    1
    Check element display on screen     EN Team


Verify UI of the scheduling product in Complex version (OL-T15159)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    wait for page load successfully
    ${candidate_name}=      Add a Candidate
    Click on candidate name     ${candidate_name}
    capture page screenshot
    Open schedule module
    capture page screenshot
    Then Check UI of Interview detail builder is in Complex Version

*** Keywords ***
select candidate has capture complete and open schedule interview module
    Filter capture complete status for candidate
    wait for page load successfully
    wait for cem display
    ${candidate_name}=    Add a Candidate
    Click on candidate name       ${candidate_name}
    Open schedule module
    wait until element is visible    ${DURATION_INPUT}
    [Return]    ${candidate_name}

Check the Scheduling modal is displayed in New UI/UX
    Check the Scheduling modal is displayed in New UI/UX design with basic info
    Check element display on screen    Prep & Instructions
    Check element display on screen    Settings

Check the Scheduling modal is displayed in New UI/UX design with basic info
    Check element display on screen    Schedule an Interview
    Check element display on screen    Interview Details
    check span display    Phone Interview
    Check element display on screen    Interview Summary
    check label display    Instructions
    check element display on screen    ${SCHEDULE_MODULE_ADD_INSTRUCTION}
    capture page screenshot

Check UI of Interview detail builder is in Complex Version
    check label display     Prep & Instructions
    Check span display      Settings
    check span display      Add Interview Prep
    check element display on screen     ${CHOOSE_TIME_BUTTON}
    check element display on screen     ${SCHEDULE_MODULE_ADD_INSTRUCTION}

Check newly added interviews should default their configuration to the same type and duration as the previous interview
	${type_interview}=     Get text    ${INTERVIEW_DROPDOWN}
	Click at   ${TIME_INTERVIEW_SPAN}
	check element display on screen     ${TIME_INTERVIEW_SPAN_CHECKBOX_VALUE}
	${duration}=    Get text and format text    ${TIME_INTERVIEW_SPAN_CHECKBOX_VALUE}
	Should Be Equal as Strings    Phone Interview    ${type_interview}
	Should Be Equal as Strings    30 min    ${duration}

Check title interview summary
	[Arguments]     ${title_name}
	${title_interview}=     Format String    ${INTERVIEW_SUMMARY_TITLE}     ${title_name}
			Check element display on screen    ${title_interview}

Check the interview summary changes to display the titles of all interviews added and their length
	Check title interview summary   Interview 1
	Check title interview summary   Interview 2
	Check title interview summary   Interview 3
	Check title interview summary   Interview 4
	Check title interview summary   Interview 5
	Check title interview summary   Interview 6
	capture page screenshot

Check the sub-interview will be removed from interview
	Click at    ${INTERVIEW_DETAILS_ELLIPSES_LOCATOR}
	Click at    ${INTERVIEW_DETAILS_DELETE_INTERVIEW_BUTTON}
	Check number scheduling interview   5

Check button Move Interview Above is not shown
	[Arguments]     ${button_move_interview_above}
	Click at    ${INTERVIEW_DETAILS_ELLIPSES_SUB_LOCATOR}   1
	Check element not display on screen    ${button_move_interview_above}
	capture page screenshot
	Click at    ${INTERVIEW_DETAILS_ELLIPSES_SUB_LOCATOR}   1

Check button Move Interview Above is shown
	[Arguments]     ${text_button}
	Click at    ${INTERVIEW_DETAILS_ELLIPSES_SUB_LOCATOR}   2
	Check span display      ${text_button}

Check button Move Interview Below is not shown
	[Arguments]     ${text_button}
	# ELLIPSES_LOCATOR is last sub-interview
	Click at    ${INTERVIEW_DETAILS_ELLIPSES_LOCATOR}
	Check element not display on screen     ${text_button}

Select ellipses sub_interview
	[Arguments]     ${number_sub_interview}
	${sub_interview}=   Format String    ${INTERVIEW_DETAILS_ELLIPSES_SUB_LOCATOR}        ${number_sub_interview}
	Wait with short time
	Click at    ${sub_interview}

Get name of interview
	[Arguments]     ${index}
	${name_text}=   Get value and format text    ${INTERVIEW_DETAILS_NAME_INTERVIEW_INPUT}       ${index}
	[Return]     ${name_text}

Check position of interview
	[Arguments]     ${index_present}    ${index_changed}    ${name_button}
	${name_index_present}=    Get name of interview     ${index_present}
	Select ellipses sub_interview   2
	Click at    ${INTERVIEW_DETAILS_MOVE_INTERVIEW_BUTTON}    ${name_button}
	${name_index_changed}=    Get name of interview        ${index_changed}
	Should be equal as strings    ${name_index_present}       ${name_index_changed}

Check info detail interview builder
    Check span display     Duration
    Check span display     Interviewers
    Check span display     Add Interviewers
    capture page screenshot

Check the sub-interview will be collapsed
    Check element not display on screen    ${ADD_INTERVIEWER_BUTTON}
    Check element not display on screen     ${INTERVIEW_DROPDOWN}
    Check element not display on screen     ${DURATION_DROPDOWN}
    capture page screenshot

Check Interview Type option is not shown on Interview Builder
    Check element not display on screen     Interview Type
    Check element not display on screen     Sequential Interview
    Check element not display on screen     Sequential Meeting
    capture page screenshot

Check Interview Type option will appear at the start of the interview builder
    Check span display    Interview Type
    Check element display on screen   Sequential Interview
    Check element display on screen    Sequential Meeting
    capture page screenshot

Check Interview Type dropdown will appear at the start of the interview builder
    Check element display on screen     ${SEQUENTIAL_INTERVIEW_TYPE_DROPDOWN}
    Check span display      Sequential Interview
    capture page screenshot

Check User can select Scheduling Timeline same as current logic
    [Arguments]     ${time_min}         ${time_max}
    Click at    ${MINIMUM_DROPDOWN}
    Click by JS    ${MINIMUM_MAXIMUM_TIME_OPTION}       4 days      2s
    Click at    ${MAXIMUM_DROPDOWN}
    Click by JS    ${MINIMUM_MAXIMUM_TIME_OPTION}       1 day       2s
    Click at    ${FIND_TIMES_BUTTON}
    Wait with short time
    Check element display on screen     This field is can not larger than maximum
    Click at    ${MINIMUM_DROPDOWN}
    Click by JS    ${MINIMUM_MAXIMUM_TIME_OPTION}       ${time_min}     2s
    Click at    ${MAXIMUM_DROPDOWN}
    Click by JS    ${MINIMUM_MAXIMUM_TIME_OPTION}       ${time_max}     2s

Check Check User can select Limit Canceling and Rescheduling Interviews same as current logic
    [Arguments]     ${time_reschedule}      ${number_reschedule}
    Click at     ${CANDIDATE_CAN_RESCHEDULE_INTERVIEW_DROPDOWN}
    Click by JS     ${MINIMUM_MAXIMUM_TIME_OPTION}      ${time_reschedule}      2s
    Click at    ${LIMIT_NUMBER_OF_TIME_CANDIDATE_CAN_RESCHEDULE_DROPDOWN}
    Click by JS     ${MINIMUM_MAXIMUM_TIME_OPTION}      ${number_reschedule}    2s

Check send interview request to candidate successfully
    [Arguments]     ${subject}      ${first_name}
    Check element display on screen     Interview Request Sent
    wait with short time
    Check span display      Interview Pending
    Verify user has received the email    ${subject}    ${first_name}       WOULD_LIKE_SCHEDULE_PHONE_ITV

Check display 3 options: Consecutive In-Order, Consecutive Any Order, Consecutive Over Multiple Days
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON}
    wait with short time
    @{list_of_options}=     Create list      Consecutive In-Order        Consecutive Any Order       Schedule Over Multiple Days
    FOR    ${value}     IN      @{list_of_options}
        check span display      ${value}
    END
    ${count}=      Get Element Count   ${DETERMINE_SCHEDULING_APPROACH_COUNT}
        Should Be Equal As Strings    ${count}    3

Main button will be changed base on the selection in Determine Scheduling Approach
    check label display    Determine Scheduling Approach
    check span display    Send In-Order Times
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON}
    Click by JS    ${DETERMINE_SCHEDULING_APPROACH_BUTTON_OPTION}       Consecutive Any Order
    check span display      Send Times in Any Order
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON}
    Click by JS    ${DETERMINE_SCHEDULING_APPROACH_BUTTON_OPTION}       Schedule Over Multiple Days
    check span display      Send Times Over Multiple Days

Select timezone on schedule module
    [Arguments]     ${timezone_type}
    Click at    ${UPDATE_TIMEZONE_DROPDOWN}
    Input into    ${UPDATE_TIMEZONE_INPUT}      ${timezone_type}
    Click by JS     ${UPDATE_TIMEZONE_OPTIONS}     ${timezone_type}

Check logic of Private Calendar Event work correctly same as current logic
    [Arguments]     ${candidate_names}
     Click button in email       would like to schedule      ${candidate_names}     WOULD_LIKE_SCHEDULE_PHONE_ITV
     Select time slot options
     Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}

Check logic of Virtual Interview URL work correctly same as current logic
    [Arguments]     ${candidate_names}
     Click button in email       would like to schedule      ${candidate_names}     WOULD_LIKE_SCHEDULE_PHONE_ITV
     Select time slot options
     Candidate input to scheduling conversation     ${CONST_PHONE_NUMBER}

Check info Determine Scheduling Approach
    [Arguments]      ${determine_scheduling_approach_options}      ${message}
    Check span display     ${determine_scheduling_approach_options}
    Check text display     ${message}
    Check element display on screen     ${CTA_WARNING_LOCATOR}
    Hover at    ${CTA_WARNING_LOCATOR}
    wait with short time
    check element display on screen    ${CTA_WARNING_LOCATOR_MESSAGE}

Check UI of Interview Prep
    Check span display      Add Interview Prep
    Click at    ${ADD_INTERVIEW_PREP_BUTTON}        slow_down=2s
    Check label display     Candidate Prep
    Check label display     Interviewer Prep
    capture page screenshot

Check count interviewer
    [Arguments]     ${expected}
    Wait with short time
    ${count_interviewer}=       Get element count       ${EMAIL_INTERVIEWER_LOCATOR}
        Should be equal as strings    ${expected}       ${count_interviewer}

Check the RR is expandable to see full list of users added to the group
    [Arguments]     @{list_users}
    FOR  ${value}   IN      @{list_users}
        Check element display on screen      ${ROUND_ROBIN_INTERVIEWER_NAME_OPTION}    ${value}
    END

Check the modal will show a micro animation to close out the scheduling process.
	check element not display on screen    ${SCHEDULE_AN_INTERVIEW_ADD_INTERVIEW}
	check element not display on screen    ${SCHEDULE_AN_INTERVIEW_ADD_ATTENDEES}
	check element not display on screen    ${SCHEDULE_AN_INTERVIEW_SUB_INTERVIEW_FORM}
	Check element not display on screen    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_POS_BTN}    Let Olivia Schedule
	capture page screenshot

Check the scheduling modal will be closed
	Check element not display on screen    ${COMMON_TEXT}    Interview Summary
	Check element not display on screen    ${COMMON_TEXT}    Schedule an Interview
	capture page screenshot

Check the Scheduling widget is not displayed in New UI/UX design
	Check element not display on screen    ${COMMON_TEXT}    Schedule an Interview
	Check element not display on screen    ${COMMON_TEXT}    Prep & Instructions
	Check element not display on screen    ${COMMON_TEXT}    Settings
	Check element not display on screen    ${COMMON_TEXT}    Interview Summary
	Check element not display on screen    ${COMMON_SPAN_TEXT}    Phone Interview
	capture page screenshot

Check Candidate's detail is shown in Scheduling widget
	[Arguments]    ${candidate_name}    ${location}    ${job_name}
	Check element display on screen    ${CANDIDATE_INFO_CANDIDATE_NAME}    ${candidate_name}
	Check element display on screen    ${CANDIDATE_INFO_SUMMARY}    ${location}
	Check element display on screen    ${CANDIDATE_INFO_SUMMARY}    ${job_name}
	capture page screenshot

Check the interview type dropdown display all selected types (from Client Setup)
	@{type_list} =    create list    Phone Interview    Virtual Interview    In-Person Interview    Group Interview
	...    Phone Meeting    Virtual Meeting    In-Person Meeting
	FOR    ${elem}    IN    @{type_list}
		Check element display on screen    ${SCHEDULE_MODULE_INV_TYPE}    ${elem}
	END

At CEM, select an candidate
	Go to CEM page
	wait for page load successfully
	${candidate_name}=    Add a Candidate
	Click on candidate name       ${candidate_name}
	[Return]     ${candidate_name}

Check candidate information will be displayed full information
	[Arguments]    ${info}
	${candidate_info} =    get text    ${CANDIDATE_INFO_CANDIDATE_HOVER_SHOW_FULL}
	should contain    ${candidate_info}    ${info}

Check Location Calendars role should display all Location Calendars from Client Setup
	[Arguments]    @{list_locations}
	FOR    ${locaion_calendar}    IN    @{list_locations}
		${locator_user_attendees} =    format string    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}    ${locaion_calendar}
		Scroll to element by JS    ${locator_user_attendees}
		Check element display on screen    ${locator_user_attendees}
	END

Check the hour textbox display
	[Arguments]    @{option_duration}
	${option_current} =    get element attribute    ${DURATION_CUSTOM_INPUT_HOUR}    value
	should contain    ${option_current}    @{option_duration}

Check the Min textbox display
	[Arguments]    @{option_duration}
	${option_current} =    get element attribute    ${DURATION_CUSTOM_INPUT_MIN}    value
	should contain    ${option_current}    @{option_duration}

Check user can add maximum 6 interviews
	when Click at   ${ADD_INTERVIEW_BUTTON}
	Then Check number scheduling interview  2
	when Click at   ${ADD_INTERVIEW_BUTTON}
	Then Check number scheduling interview  3
	when Click at   ${ADD_INTERVIEW_BUTTON}
	Then Check number scheduling interview  4
	when Click at   ${ADD_INTERVIEW_BUTTON}
	Then Check number scheduling interview  5
	when Click at   ${ADD_INTERVIEW_BUTTON}
	Then Check number scheduling interview  6
	Check element not display on screen     ${ADD_INTERVIEW_BUTTON}
	capture page screenshot
