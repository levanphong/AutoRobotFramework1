*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/all_candidates_page.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/my_calendar_page.robot
Resource            ../../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg     lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${TIME_SLOT_BG_COLOR_CHECKED}       rgba(57, 94, 102, 1)

*** Test Cases ***
Verify UI of Choose a Time with single interview (OL-T15200)
    Given Setup test
    when Login into system with company    ${EDIT_EVERYTHING}     ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add new candidate , select duration time and interviewer    15 min       FS Team
    Check UI of Choose a Time display correctly
    Check it default display OIT by Owner's Timezone    America/Atikokan (EST)


Verify Scheduling Method will show when Choose a Time for sequential Interview (OL-T15201, OL-T15202)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Create new a candidate and open schedule module     EE Team
    Select info for 2 sub-interview     30 min      EN Team     FS Team
    click at    ${CHOOSE_TIME_BUTTON}
    Check the Scheduling Method should be show with 2 options: In-Order and AnyOrder
    Turn on     ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    capture page screenshot
    Check the option Any Order is disabled


Verify User can not turn ON the Schedule over unavailable times when options Any Order is selected at Scheduling Method (OL-T15203)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add a new candidate and select interviewer to schedule      30 min      Inorder1 ChooseTime     Inorder2 ChooseTime
    Select Determine Scheduling Approach      Consecutive In-Order
    click at    ${CHOOSE_TIME_BUTTON}
    Click at    ${CHOOSE_TIME_ANY_ORDER_BUTTON}
    verify element is disable   ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_INPUT}
    capture page screenshot


Verify 'Scheduled over unavailable times' toggle is ON if user chooses 'In- Order' and no available slots were found. (OL-T15204)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add a new candidate and select interviewer to schedule      1 hour      Anyorder1 ChooseTime     Anyorder2 ChooseTime
    Select Determine Scheduling Approach      Consecutive In-Order
    Click at    ${CHOOSE_TIME_BUTTON}
    Check toggle is On      ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    capture page screenshot
    Select a time slot on schedule modal
    capture page screenshot


Verify 'Consecutive In-Order' is selected if interview slot is available in both In-Order and Any-Order. (OL-T15205)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=      Create new a candidate and open schedule module     EE Team
    Select info for 2 sub-interview     30 min      FO Team     EN Team
    Select type of Determine Scheduling Approach    Consecutive Any Order
    Click at    ${CHOOSE_TIME_BUTTON}
    check element display on screen     ${CHOOSE_TIME_IN_ORDER_ICON_CHECKED}    Any Order
    capture page screenshot
    Select a time slot on schedule modal
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Select a candidate and click update link on CEM    ${candidate_name}
    click at    ${ALL_CANDIDATES_SCHEDULE_EDIT_INTERVIEW_BUTTON}
    check span display      Consecutive Any Order
    capture page screenshot
    Click at    ${SCHEDULE_CANCEL_BUTTON}
    Click at    ${SCHEDULE_MODULE_EXIT_BUTTON}
    cancel interview    ${candidate_name}


Verify 'Any Order' button is disabled AND Scheduling method is auto changed to 'In- Order' and 'Scheduled over unavailable times' toggle is ON auto if user chooses 'Any Order' and no slots were found. (OL-T15206)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Go to Users, Roles, Permissions page
    ${first_name_1}=      Add a User       role=Full User - Edit Everything
    ${first_name_2}=      Add a User       role=Full User - Edit Everything
    Delete OIT, set OIT for in oder and set 2 sub-interview     ${first_name_1}    ${first_name_2}     30 min
    click at    ${CHOOSE_TIME_BUTTON}
    Turn on     ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    Check the option Any Order is disabled
    capture page screenshot
    check element display on screen    ${CHOOSE_TIME_IN_ORDER_ICON_CHECKED}     In-Order
    capture page screenshot
    Check toggle is On      ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    capture page screenshot
    Click at    ${CHOOSE_TIME_BACK_BUTTON}
    check span display      Consecutive In-Order
    capture page screenshot
    Deactivate two Users      ${first_name_1}       ${first_name_2}


Verify User can Move date back one day to Choose time by clicking on left arrow (OL-T15210,OL-T15211)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate
    Click on candidate name    ${candidate_name}
    capture page screenshot
    Open schedule module
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      FO Team
    click at    ${CHOOSE_TIME_BUTTON}
    Click at    ${CHOOSE_TIME_CALENDAR_ICON}
    ${selected_date}=     get text and format text    ${CHOOSE_TIME_CALENDAR_DATE_SELECTED}
    ${present_date_convert_to_int}=     Convert To Integer      ${selected_date}
    ${selected_date_plus_one}=    Set variable    ${present_date_convert_to_int+1}
    capture page screenshot
    Click at    ${CHOOSE_TIME_NEXT_DATE_LOCATOR}
    Click at    ${CHOOSE_TIME_CALENDAR_ICON}
    ${next_date_selected}=       get text and format text    ${CHOOSE_TIME_CALENDAR_DATE_SELECTED}
    Should Be Equal As Integers      ${next_date_selected}    ${selected_date_plus_one}
    capture page screenshot
    Click at    ${CHOOSE_TIME_PREVIOUS_DATE_LOCATOR}
    Click at    ${CHOOSE_TIME_CALENDAR_ICON}
    ${previous_date_selected}=   get text and format text    ${CHOOSE_TIME_CALENDAR_DATE_SELECTED}
    Should Be Equal As Integers     ${previous_date_selected}    ${present_date_convert_to_int}
    capture page screenshot


Verify Schedule over unavailable times toggle will auto ON when User has no available OIT same as current logic (OL-T15212)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Go to Users, Roles, Permissions page
    ${first_name_1}=      Add a User       role=${EDIT_EVERYTHING}
    Delete OIT of user      ${first_name_1}
    Create new a candidate and open schedule module     EE Team
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      ${first_name_1}
    Click at    ${CHOOSE_TIME_BUTTON}
    Check toggle is On      ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    Check all time slots that user can schedule interview will be enbale same as current logic


Verify User can choose time not available when the Schedule over unavailable times toggle is ON (OL-T15213)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate
    Click on candidate name    ${candidate_name}
    capture page screenshot
    Open schedule module
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      Hiring Team
    click at    ${CHOOSE_TIME_BUTTON}
    Turn on     ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    capture page screenshot
    check element not display on screen     ${CHOOSE_TIME_SLOT_UNAVAILABLE_LOCATOR}
    capture page screenshot


Verify the user increments of 20 minutes in the choose a time pills when duration is 20mins (OL-T15214)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add new candidate , select duration time and interviewer    20 min       FO Team
    Check UI of choose time modal view correctly    20 min  FO Team
    Check it show the user increments of 20 minutes in the choose a time pills


Verify the user increments of 20 minutes in the choose a time pills when duration is 40mins (OL-T15215)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    ${candidate_name}=    Add a Candidate
    Click on candidate name    ${candidate_name}
    capture page screenshot
    Open schedule module
    when click at    ${DURATION_INPUT}
    when Click by JS     ${DURATION_TIME_OPTION}    Custom
    when input into    ${DURATION_CUSTOM_INPUT_MIN}    40
    click at    ${DURATION_CUSTOM_APPLY_BTN}
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews     FS Team
    click at    ${CHOOSE_TIME_BUTTON}
    Check UI of choose time modal view correctly    40 min     FS Team
    Check it show the user increments of 20 minutes in the choose a time pills


Verify the pill-style design will be navy color when user selected that times (OL-T15216,OL-T15217)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add new candidate , select duration time and interviewer    30 min       EN Team
    Click at    ${CHOOSE_TIME_TIME_SLOT_INDEX}      1
    capture page screenshot
    Check the pill will be displayed in navy color      ${CHOOSE_TIME_TIME_SLOT_FIRST}
    Check the time slots in the past will be disable and strikethrough


Verify user can choose a time options in the timezone of their choosing (OL-T15207, OL-T15208)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add new candidate , select duration time and interviewer    30 min       FO Team
    Hover at    ${CHOOSE_TIME_CALENDAR_ICON}
    Check element display on screen     View calendar to select date.
    capture page screenshot
    Check it default display OIT by Owner's Timezone    America/Atikokan (EST)
    input into      ${CHOOSE_TIME_LIST_TIMEZONE_INPUT}      America/Creston (MST)
    Click at    ${CHOOSE_TIME_LIST_TIMEZONE_OPTIONS}      America/Creston (MST)
    Check it default display OIT by Owner's Timezone    America/Creston (MST)
    Select a time slot on schedule modal
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    capture page screenshot


Verify User can change the date to Choose time by clicking on Calendar (OL-T15209)
    Given Setup test
    When Login into system with company     ${EDIT_EVERYTHING}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Add new candidate , select duration time and interviewer    30 min       FO Team
    ${number_time_slot_today}=   get element count       ${CHOOSE_TIME_TIME_SLOT_LOCATOR}
    Click at    ${CHOOSE_TIME_CALENDAR_ICON}
    Check element display on screen     ${CHOOSE_TIME_CALENDAR_MODAL}
    capture page screenshot
    Click at    ${CHOOSE_TIME_CALENDAR_DATE_OPTIONS}        3
    ${number_time_slot_next_date}=   get element count       ${CHOOSE_TIME_TIME_SLOT_LOCATOR}
    Should Not Be Equal As Strings      ${number_time_slot_today}    ${number_time_slot_next_date}


Verify the pill-style will be strikethrough and disable when the selected start time would overlap an existing interview (OL-T15218)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    Go to Users, Roles, Permissions page
    ${first_name_1}=      Add a User       role=${EDIT_EVERYTHING}
    Create new a candidate and open schedule module     ${first_name_1}
    Select interviewer and click choose a time button       ${first_name_1}
    Click at    ${CHOOSE_TIME_CALENDAR_ICON}
    Click at    ${CHOOSE_TIME_CALENDAR_DATE_OPTIONS}        2
    Click at    ${CHOOSE_TIME_TIME_OPTIONS}     10:00 AM
    Click at    ${CHOOSE_TIME_SCHEDULE_TIME_BUTTON}
    click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    ${candidate_name}=    Add a Candidate
    Click on candidate name    ${candidate_name}
    capture page screenshot
    Open schedule module
    Select interviewer and click choose a time button       ${first_name_1}
    Click at    ${CHOOSE_TIME_CALENDAR_ICON}
    Click at    ${CHOOSE_TIME_CALENDAR_DATE_OPTIONS}        2
    @{list_time_slot}=       Create list     9:45 AM     10:00 AM     10:15 AM
    Check time slot will be disabled and strikethrough      @{list_time_slot}
    Go to CEM page
    Switch to user      ${TEAM_USER}
    Go to Users, Roles, Permissions page
    Deactivate a User       ${first_name_1}

*** Keywords ***
Check UI of Choose a Time display correctly
    check element display on screen     ${CHOOSE_TIME_VIEW_MORE_TIME_TOP_BUTTON}
    check element display on screen     ${CHOOSE_TIME_VIEW_MORE_TIME_BOTTOM_BUTTON}
    check element display on screen     Choose Time(s)
    capture page screenshot

Check it default display OIT by Owner's Timezone
    [Arguments]     ${name_time_zone}
    click at    ${CHOOSE_TIME_LIST_TIMEZONE_DROPDOWN_ICON}
    wait with short time
    check element display on screen     ${CHOOSE_TIME_TIME_ZONE_DEFAULT}      ${name_time_zone}
    capture page screenshot

Check the Scheduling Method should be show with 2 options: In-Order and AnyOrder
    check span display      In-Order
    check element display on screen     ${CHOOSE_TIME_ANY_ORDER_BUTTON}
    capture page screenshot

Check the option Any Order is disabled
    Hover at    ${CHOOSE_TIME_ANY_ORDER_BUTTON}
    wait with short time
    check element display on screen     Any Order is not available when schedule over busy times is enabled
    capture page screenshot

Delete OIT and select time at My Calendar page for user
    [Arguments]     ${user_name_1}      ${time_start}    ${time_end}
    Delete OIT of user      ${user_name_1}
    go to CEM page
    switch to user      ${user_name_1}
    Select time for user     ${time_start}    ${time_start}

Create new a candidate and open schedule module
    [Arguments]     ${user_name}
    go to CEM page
    switch to user      ${user_name}
    ${candidate_name}=    Add a Candidate
    Click on candidate name    ${candidate_name}
    capture page screenshot
    Open schedule module
    [Return]    ${candidate_name}

Delete OIT, set OIT for in oder and set 2 sub-interview
    [Arguments]     ${username_1}   ${username_2}   ${interview_duration}
    Delete OIT and select time at My Calendar page for user     ${user_name_1}      ${TIME_8H_AM}    ${TIME_9H_AM}
    Go to Users, Roles, Permissions page
    Delete OIT and select time at My Calendar page for user     ${user_name_2}      ${TIME_8H30_AM}    ${TIME_9H30_AM}
    Create new a candidate and open schedule module     EE Team
    Select info for 2 sub-interview     ${interview_duration}      ${user_name_1}     ${user_name_2}

Delete OIT, set OIT for any oder and set 2 sub-interview
    [Arguments]     ${username_1}   ${username_2}   ${interview_duration}
    Delete OIT and select time at My Calendar page for user     ${user_name_1}      ${TIME_8H_AM}    ${TIME_9H_AM}
    Go to Users, Roles, Permissions page
    Delete OIT and select time at My Calendar page for user     ${user_name_2}      ${TIME_9H_AM}    ${TIME_10H_AM}
    Create new a candidate and open schedule module     EE Team
    Select info for 2 sub-interview     ${interview_duration}      ${user_name_1}     ${user_name_2}

Select type of Determine Scheduling Approach
    [Arguments]     ${determine_scheduling_approach_type}
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON}
    wait with short time
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON_OPTION}      ${determine_scheduling_approach_type}
    capture page screenshot

Check all time slots that user can schedule interview will be enbale same as current logic
    Click at    ${CHOOSE_TIME_BACK_BUTTON}
    check element display on screen     The interview could not be scheduled. You can select a time for this interview in Choose a Time
    capture page screenshot

Check UI of choose time modal view correctly
    [Arguments]     ${time}     ${interviewer}
    check span display      Phone Interview
    check span display      ${time}
    check span display      ${interviewer}
    verify element is disable       ${CHOOSE_TIME_SCHEDULE_TIME_BUTTON}
    check toggle is off     ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    capture page screenshot

Check it show the user increments of 20 minutes in the choose a time pills
    ${time_slot_1}=     Get text and format text    ${CHOOSE_TIME_TIME_SLOT_INDEX}      1
    ${time_slot_2}=     Get text and format text    ${CHOOSE_TIME_TIME_SLOT_INDEX}      2
    ${result}=    get_diffrent_minutes_from_time_slot   (${time_slot_1}     ${time_slot_2})
    Should Be Equal as Strings      ${result}       20

Check the time slots in the past will be disable and strikethrough
    Click at    ${CHOOSE_TIME_VIEW_MORE_TIME_TOP_BUTTON}
    check element display on screen     ${CHOOSE_TIME_SLOT_UNAVAILABLE_LOCATOR}
    capture page screenshot

Add new candidate , select duration time and interviewer
    [Arguments]     ${itv_time}     ${name_interviewer}
    ${candidate_name}=    Add a Candidate
    Click on candidate name    ${candidate_name}
    capture page screenshot
    Open schedule module
    Choose duration time to schedule    ${itv_time}
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      ${name_interviewer}
    capture page screenshot
    Click at    ${CHOOSE_TIME_BUTTON}
    [Return]    ${candidate_name}

Select interviewer and click choose a time button
    [Arguments]     ${user_name}
    Click at    ${INTERVIEWER_BUTTON}
    Select interviewers for sub-interviews      ${user_name}
    capture page screenshot
    Click at    ${CHOOSE_TIME_BUTTON}

Check time slot will be disabled and strikethrough
    [Arguments]     @{list_time_slot_disabled}
    FOR     ${time_slot}    IN      @{list_time_slot_disabled}
        check element display on screen     ${CHOOSE_TIME_SLOT_UNAVAILABLE_OPTIONS}     ${time_slot}
    END
    capture page screenshot
