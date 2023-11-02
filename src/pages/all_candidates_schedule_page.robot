*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/all_candidates_scheduling_locators.py

*** Keywords ***
select attendes when for sub interview
	[Arguments]    ${user_name}
	Click at    ${SCHEDULE_AN_INTERVIEW_ADD_ATTENDEES}
	Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES}
	Simulate Input    ${SCHEDULE_AN_INTERVIEW_ATTENDEES}    ${user_name}
	${locator_user_attendees} =    format string    ${ATTENDEES_NAME}    ${user_name}
	Click at    ${locator_user_attendees}
	Click at    ${SCHEDULE_AN_INTERVIEW_APPLY_BTN}

Check count sub interview
	[Arguments]    ${count}
	${count_current} =    Get Element Count    ${SCHEDULE_AN_INTERVIEW_SUB_INTERVIEW_FORM}
	Should Be True    ${count_current} == ${count}

Choose interview type
	[Arguments]    ${type}
	click at    ${SCHEDULE_AN_INTERVIEW_INV_TYPE}
	click at    ${SCHEDULE_AN_INTERVIEW_INV_VIRTUAL_TYPE}    ${type}

click on positive button
	[Arguments]    ${button_name}
	Click at    ${SCHEDULE_AN_INTERVIEW_SCHEDULE_POS_BTN}    ${button_name}
	wait for page load successfully

Check the list times including
	@{type_list} =    create list    15 min    20 min    30 min    45 min    1 hour    1 hour 30 min    2 hours
	FOR    ${option}    IN    @{type_list}
		Check element display on screen    ${DURATION_TIME_OPTION}    ${option}
	END

Check the Duration section display time
	[Arguments]    @{option_duration}
	${option_current} =    get element attribute    ${DURATION_INPUT}    value
	should contain    ${option_current}    @{option_duration}

Check the Scheduling modal is displayed in New UI/UX design
	Wait with medium time
	Check element display on screen    ${CANDIDATE_NAME_SCHEDULING_LOCATOR}
	Wait with short time
	Check element display on screen    ${ADD_INTERVIEW_BUTTON}
	capture page screenshot

Check number scheduling interview
	[Arguments]     ${count_expected}
	Wait with short time
	${count_actual}=   Get Element Count   ${SCHEDULE_AN_INTERVIEW_SUB_INTERVIEW_FORM}
		Should Be Equal as Strings    ${count_actual}    ${count_expected}

Select interviewers for sub-interviews
	[Arguments]     ${name}
	Simulate Input    ${SEARCH_INTERVIEWER_INPUT}       ${name}
	wait with short time
	Click by JS   ${INTERVIEWER_LOCATOR}    ${name}
	Click at    ${APPLY_TIME_BUTTON}

Add new candidate and open schedule modal
	wait for page load successfully
	${candidate_name}=    Add a Candidate
	Click on candidate name       ${candidate_name}
	Click at    ${MORE_BUTTON}
	Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
	[Return]    ${candidate_name}

Send interview and click close button
    Click at    ${FIND_TIMES_BUTTON}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}

Choose duration time to schedule
    [Arguments]     ${time}
    Click at    ${DURATION_LAST_DROPDOWN}
    Click by JS    ${DURATION_TIME_OPTION}      ${time}
    click at    ${DURATION_CUSTOM_APPLY_BTN}
	wait for page load successfully

Select info for 2 sub-interview
    [Arguments]     ${time1}    ${interviewer1}    ${interviewer2}    ${interview_type1}=None    ${interview_type2}=None
    Click at    ${INTERVIEW_DROPDOWN}
    Choose duration time to schedule    ${time1}
    Run Keyword If    '${interview_type1}' != 'None'
    ...    Choose interview type    ${interview_type1}
    Click at   ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${interviewer1}
    Click at    ${ADD_INTERVIEW_BUTTON}
    wait with short time
    Run Keyword If    '${interview_type2}' != 'None'
    ...    Choose interview type    ${interview_type2}
    Click at   ${ADD_INTERVIEWERS_BUTTON}
    Select interviewers for sub-interviews      ${interviewer2}

Choose location
    [Arguments]     ${location_name}
    Click at    ${LOCATION_INPUT}       slow_down=2s
    Input into    ${SEARCH_FOR_A_LOCATION_TEXTBOX}      ${location_name}
    Wait with short time
    Click by JS   ${LOCATION_OPTIONS}    ${location_name}

Select a time slot
    [Arguments]     ${time_slot}
    Click at    ${CHOOSE_TIME_NEXT_DATE_LOCATOR}
    Click at    ${CHOOSE_TIME_TIME_OPTIONS}     ${time_slot}
    capture page screenshot
    Click at    ${CHOOSE_TIME_SCHEDULE_TIME_BUTTON}      slow_down=2s

Cancel interview
    [Arguments]     ${candidate_name}
    Click on candidate name       ${candidate_name}
    wait for page load successfully
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CANCEL_INTERVIEW_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CONFIRM_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}

Select a time slot on schedule modal
    ${is_clicked}=      run keyword and return status      Click by JS    ${CHOOSE_TIME_TIME_SLOT_OPTIONS}    1
    IF    '${is_clicked}'== 'False'
            Click at    ${CHOOSE_TIME_NEXT_DATE_LOCATOR}
            Click by JS    ${CHOOSE_TIME_TIME_SLOT_OPTIONS}    1
    END
    Click at    ${CHOOSE_TIME_SCHEDULE_TIME_BUTTON}

Delete OIT, set OIT for in oder and set 2 sub-interview to schedule
    [Arguments]      ${user_name_1}      ${user_name_2}     ${interview_duration}     ${select_time_zone}=None
    Delete OIT of user      ${user_name_1}
    Delete OIT of user      ${user_name_2}
    IF  '${select_time_zone}'!= 'None'
        Select timezone by user    ${user_name_1}       ${TIME_ZONE_PLUS_7_ICT}
        Select timezone by user    ${user_name_2}      ${TIME_ZONE_SUB_9_HDT}
    END
    go to CEM page
    switch to user      ${user_name_1}
    Select time for user     ${TIME_8H_AM}    ${TIME_10H_AM}
    go to CEM page
    switch to user      ${user_name_2}
    Select time for user     ${TIME_9H_AM}    ${TIME_11H_AM}
    go to CEM page
    When switch to user   EE Team
    ${candidate_name}=    Add a Candidate     is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    Select info for 2 sub-interview     ${interview_duration}      ${user_name_1}      ${user_name_2}
    [Return]    ${candidate_name}

Delete OIT, set OIT for any oder and set 2 sub-interview to schedule
    [Arguments]      ${user_name_1}      ${user_name_2}     ${interview_duration}   ${select_time_zone}=None
    Delete OIT of user      ${user_name_1}
    Delete OIT of user      ${user_name_2}
    # We will set ${select_time_zone}=None when schedule for in order and any order
    # Set ${select_time_zone}'!= 'None when schedule with multiple days. Pre-condition to schedule with multiple days is timezone of two users must be 12 hours apart.
    IF  '${select_time_zone}'!= 'None'
        Select timezone by user    ${user_name_1}       ${TIME_ZONE_PLUS_7_ICT}
        Select timezone by user    ${user_name_2}      ${TIME_ZONE_SUB_9_HDT}
    END
    go to CEM page
    switch to user      ${user_name_1}
    Select time for user     ${TIME_8H_AM}    ${TIME_10H_AM}
    go to CEM page
    switch to user      ${user_name_2}
    Select time for user     ${TIME_10H_AM}    ${TIME_12H_AM}
    go to CEM page
    When switch to user   EE Team
    ${candidate_name}=    Add a Candidate   is_spam_email=False
    When Click on candidate name    ${candidate_name}
    When Open schedule module
    Select info for 2 sub-interview     ${interview_duration}      ${user_name_1}      ${user_name_2}
    [Return]    ${candidate_name}

Select Determine Scheduling Approach
    [Arguments]     ${determine_scheduling_approach_type}
    Click at    ${SCHEDULE_AN_INTERVIEW_SETTING_TAB}
    Click at    ${DETERMINE_SCHEDULING_APPROACH_BUTTON}
    Click by JS    ${DETERMINE_SCHEDULING_APPROACH_BUTTON_OPTION}       ${determine_scheduling_approach_type}

Select a candidate and click update link on CEM
    [Arguments]     ${candidate_name}
    Go to CEM page
    Open a candidate Conversation   ${candidate_name}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}

Add a candidate to an orientation event
    [Arguments]     ${event_name}    ${group_name}=None     ${location_name}=None       ${is_spam_email}=True
    ${candidate_name} =   Add a Candidate     ${group_name}     ${location_name}    is_spam_email=${is_spam_email}
    Click at        ${MORE_BUTTON}
    Click at        ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at        ${ORIENTATION_SCHEDULE_TYPE}
    Input into      ${SCHEDULE_ORIENTATION_EVENT_SEARCH_INPUT}        ${event_name}
    Click at        ${event_name}
    Click at        ${SCHEDULE_ORIENTATION_SUBMIT_BUTTON}
    Check text display      Orientation Scheduled
    Click at        ${SCHEDULE_ORIENTATION_CLOSE_BUTTON}
    [Return]        ${candidate_name}

Check schedule type exist
    [Arguments]     ${schedule_type}
    ${is_existed}=      Run keyword and return status       check span display    Select Scheduling Type
    IF    '${is_existed}' == 'True'
        Click at    ${INTERVIEW_SCHEDULE_TYPE_OPTION}       ${schedule_type}
    END

Add a new candidate and select interviewer to schedule
    [Arguments]     ${duration_time}    ${interview_1}      ${interview_2}
    go to CEM page
    ${candidate_name}=    Add a Candidate     is_spam_email=False
    Open a candidate Conversation       ${candidate_name}
    When Open schedule module
    Select info for 2 sub-interview     ${duration_time}      ${interview_1}      ${interview_2}
    [Return]    ${candidate_name}

CEM schedule interview type
    [Arguments]     ${candidate_name}   ${interview_type}
    Click on candidate name       ${candidate_name}
	Click at    ${MORE_BUTTON}
	Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
	Click at    ${INTERVIEW_SCHEDULE_TYPE_OPTION}       ${interview_type}

Select orientation event
    [Arguments]     ${event_name}
    Input into      ${SCHEDULE_ORIENTATION_EVENT_SEARCH_INPUT}        ${event_name}
    Click at        ${event_name}

Schedule orientation event
    Click at        ${SCHEDULE_ORIENTATION_INTERVIEW_SUBMIT_BUTTON}
    Click at        ${SCHEDULE_ORIENTATION_CLOSE_BUTTON}

Add interview prep for interview
    [Arguments]    ${candidate_prep_name}    ${interviewer_prep_name}
    Click at    ${ADD_INTERVIEW_PREP_BUTTON}
    Click at    ${CANDIDATE_PREP_DROPDOWN}
    Click at    ${CANDIDATE_INTERVIEWER_PREP_DROPDOWN_OPTIONS}    ${candidate_prep_name}
    Click at    ${INTERVIEWER_PREP_DROPDOWN}
    Click at    ${CANDIDATE_INTERVIEWER_PREP_DROPDOWN_OPTIONS}    ${interviewer_prep_name}

Choose candidate timezone
    [Arguments]    ${timezone_name}
    Turn on    ${CANDIDATE_TIMEZONE}
    Click at    ${UPDATE_TIME_ZONE_DROPDOWN_ICON}
    Input into    ${UPDATE_TIMEZONE_INPUT}       ${timezone_name}
    Scroll to element    ${UPDATE_TIMEZONE_OPTIONS}    ${timezone_name}
    Click at    ${UPDATE_TIMEZONE_OPTIONS}    ${timezone_name}

Choose timezone for interview
    [Arguments]    ${timezone_name}
    Click at    ${CHOOSE_TIME_LIST_TIMEZONE_DROPDOWN_ICON}
    Input into    ${CHOOSE_TIME_LIST_TIMEZONE_INPUT}    ${timezone_name}
    Click at    ${CHOOSE_TIME_LIST_TIMEZONE_OPTIONS}    ${timezone_name}

Choose time interview
    [Arguments]    ${number_slot}=1    ${timezone_name}=MST (AZ)
    Click at    ${CHOOSE_TIME_BUTTON}
    Click at    ${CHOOSE_TIME_VIEW_MORE_TIME_BOTTOM_BUTTON}
    Choose timezone for interview     ${timezone_name}
    Turn on    ${CHOOSE_TIME_SCHEDULE_OVER_UNAVAILABLE_TIMES_TOGGLE}
    @{choosed_times_arr} =    Create List
    ${range_slot} =    Evaluate    ${number_slot}+1
    FOR    ${index}    IN RANGE    1    ${range_slot}
        Click at    ${CHOOSE_TIME_TIME_SLOT_INDEX}    ${index}
        ${time} =   Get text and format text    ${CHOOSE_TIME_TIME_SLOT_INDEX}    ${index}
        ${date} =   Get text and format text    ${CHOOSE_TIME_CALENDAR_SHOW_DATE}
        ${date_time} =    Catenate    SEPARATOR=|    ${date}    ${time}
        Append To List    ${choosed_times_arr}    ${date_time}
    END
    Click at    ${CHOOSE_TIME_SCHEDULE_TIME_BUTTON}
    [Return]    ${choosed_times_arr}

Set scheduling timelines
    [Arguments]    ${minimum}=0 hours    ${maximum}=2 weeks
    Turn on    ${SCHEDULING_TIMELINES_TOGGLE}
    Click at    ${MINIMUM_DROPDOWN}
    Scroll to element    ${MINIMUM_MAXIMUM_TIME_OPTION}    ${minimum}
    Click at    ${MINIMUM_MAXIMUM_TIME_OPTION}    ${minimum}
    Click at    ${MAXIMUM_DROPDOWN}
    Scroll to element    ${MINIMUM_MAXIMUM_TIME_OPTION}    ${maximum}
    Click at    ${MINIMUM_MAXIMUM_TIME_OPTION}    ${maximum}
