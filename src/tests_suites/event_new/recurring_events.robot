*** Settings ***
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    dev2    stg   olivia  birddoghr   advantage     aramark     lts_stg    test

*** Variables ***
${all_occurrence_message}       Make the following edits to all occurrences starting
${custom_message}               Determine which occurrences the following edits will apply to
${single_event_message}         Make the following edits to only

*** Test Cases ***
Verify dislay the 'Edit Past Events' toggle in Client Setup (OL-T5808)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Client setup page
	Click at        ${EVENTS_LABEL}
	Check toggle is off     ${EDIT_PAST_EVENTS_TOGGLE}
	Capture page screenshot


Verify dislay the 'Edit Past Events' toggle is not showed when the Event toggle is Off (OL-T5809)
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Client setup page
	Click at    ${EVENTS_LABEL}
    Turn off     ${EVENTS_TOGGLE}
	Check element not display on screen     ${EDIT_PAST_EVENTS_TOGGLE}
	Capture page screenshot
	Turn on     ${EVENTS_TOGGLE}


Verify the user can't not edit the Past Events when the 'Edit Past Event' toggle OFF (OL-T5810)
    [Tags]  skip
    #   https://paradoxai.atlassian.net/browse/OL-72853
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Switch to user      Full User Automation
	Click at         Past Events
	Hover at            ${FIRST_PAST_EVENT_MENU_ITEM}
	Click at        ${FIRST_PAST_EVENT_MENU_ITEM}
	Check element not display on screen     ${EDIT_ICON}
	Capture page screenshot
	Click at        ${FIRST_PAST_EVENT}
	wait for page load successfully
	Click at        ${ICON_SETTING_EVENT_HOME}
	Check element not display on screen     ${EDIT_ICON}
	Capture page screenshot


Verify Paradox Admin still can edit the Past Events when the 'Edit Past Event' toggle OFF (OL-T5811)
    [Tags]  skip
    #   https://paradoxai.atlassian.net/browse/OL-72853
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
	Click at         Past Events
	Hover at        ${FIRST_PAST_EVENT_MENU_ITEM}
	Click at        ${FIRST_PAST_EVENT_MENU_ITEM}
	Check element display on screen     ${EDIT_ICON}
	Capture page screenshot
	Click at        ${FIRST_PAST_EVENT}
	wait for page load successfully
	Click at        ${ICON_SETTING_EVENT_HOME}
	Check element display on screen     ${EDIT_ICON}
	Capture page screenshot


Check opening the Edit Events slide when clicking on 'Edit Recurring Rule' before the event created (OL-T5812, OL-T5813, OL-T5820)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Click at        ${EDIT_RECURRING_RULES_BUTTON}
    Edit Events slide popup is displayed
    Element should be disabled      ${FREQUENCY_DROPDOWN}
    Capture page screenshot


Check an Occurrence dropdown will appear within the event editor when the user edit the Recurring Event after created (OL-T5814, OL-T5817)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step   Virtual Chat Booth
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event    ${event_name}
    Check element display on screen     ${EVENT_OCCURRENCE_DROPDOWN}
    Element should be disabled      ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    Capture page screenshot


Verify tabs are available to the user in Overview when selecting All Occurrence in Occurrence dropdown (OL-T5815)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set event occurrence    Recurring Event
    Tabs of recurring event are correctly displayed
    Capture page screenshot


Verify showing Event Planing tab in Overview step when the Campus toggle is turned on (OL-T5816)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set event occurrence    Recurring Event
    Turn on     ${CAMPUS_TOGGLE}
    Check span display      Event Planning
    Capture page screenshot


Check editing Recurring Rule after the event created and the user select All Occurrences in Occurrence dropdown and the first occurrence has not started (OL-T5819)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Edit recurring rule step
    Update session step     ${session_info.session_name}
    Click at    ${SUMMARY_TAB}
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Click at    ${CUSTOM_RADIO}
    ${number_of_occurences}=    get element count      ${OCCURRENCES_CHECKBOX}
    Should be equal as numbers      ${number_of_occurences}     1
    Click at    ${CANCEL_UPDATE_EVENT_BUTTON}
    Click at link       Events
    Edit Confirm modal is displayed
    Capture page screenshot


Verify the day displayed in the 'On these day' field when the user update Start Date of First Occurrence that is greater than previously selected day in Recurring Rule (OL-T5821, OL-T5822)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    Set Schedule step   Virtual Chat Booth
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    wait with short time
    ${on_these_days_before_update}=     Get text and format text        ${ON_THESE_DAYS_SELECTED_VALUE}
    Capture page screenshot
    Set first date occurence for recurring event    2
    Set end date occurence for recurring event      2
    Set end of recurring event                      10
    ${on_these_days_after_update}=      Get text and format text        ${ON_THESE_DAYS_SELECTED_VALUE}
    Should be equal as strings      ${on_these_days_before_update}      ${on_these_days_after_update}
    Capture page screenshot
    Click at    ${SAVE_BUTTON_RECURRING}
    wait with short time
    ${selected_event_day_after_update}=     get element count       ${SELECTED_EVENT_DAYS}
    Should be equal as numbers      ${selected_event_day_after_update}      1
    Capture page screenshot


Check all future occurrences are edited when All Occurrences is selected in Occurrences dropdown and the user select All Future Occurrences at Edit Confirm modal (OL-T5825, OL-T5827, OL-T5850)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    Set first date occurence for recurring event    2
    Set end date occurence for recurring event      2
    Click at    ${SAVE_BUTTON_RECURRING}
    wait with short time
    ${selected_event_day_after_update}=     get element count       ${SELECTED_EVENT_DAYS}
    Update session step     ${session_info.session_name}
    Click at    ${SUMMARY_TAB}
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Edit Confirm modal is displayed
    Check span display      ${all_occurrence_message}
    Check span display      ${custom_message}
    ${all_future_occurrences}=      format string    ${COMMON_SPAN_TEXT}     Total Occurences
    Element should contain    ${all_future_occurrences}        ${selected_event_day_after_update}
    Click at    ${CONFIRM_AND_SAVE_BUTTON}
    wait for page load successfully
    Check element display on screen     Recurring Events
    Capture page screenshot


Check selected occurrence are edited when All Occurrences is selected in Occurrences dropdown and the user selects Custom at Edit Confirm modal (OL-T5826, T5828, T5829, T5831)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${RECURRING_RULES_TAB}
    Click at    ${EDIT_RECURRING_RULES_BUTTON}
    Set first date occurence for recurring event    2
    Set end date occurence for recurring event      2
    Click at    ${SAVE_BUTTON_RECURRING}
    wait with short time
    ${selected_event_day_after_update}=     get element count       ${SELECTED_EVENT_DAYS}
    ${date}=    Get text and format text    ${SELECTED_EVENT_DAYS_TEXT}
    Update session step     ${session_info.session_name}
    Click at    ${SUMMARY_TAB}
    Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Edit Confirm modal is displayed
    Click at    ${CUSTOM_RADIO}
    ${custom_radio}=      get element count   ${OCCURRENCES_CHECKBOX}
    Should be equal as numbers      ${custom_radio}     ${selected_event_day_after_update}
    Element should be disabled      ${RECURRING_EVENT_CONFIRM_AND_SAVE_BUTTON}
    Capture page screenshot
    Input into      ${SEARCH_OCCURRENCES_TEXTBOX}       ${date}
    Click by JS        ${OCCURRENCES_CHECKBOX}
    Capture page screenshot
    Element should be enabled       ${RECURRING_EVENT_CONFIRM_AND_SAVE_BUTTON}
    Capture page screenshot
    Click at    ${RECURRING_EVENT_CONFIRM_AND_SAVE_BUTTON}
    wait for page load successfully
    Check element display on screen     Recurring Events
    Capture page screenshot


Verify the user can't edit or delete the single event at Summary step when the recurring is creating (OL-T5832)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step    Virtual Chat Booth
    Click at    ${SUMMARY_TAB}
    Check element not display on screen     ${EVENT_OCCURRENCE_MENU_ITEM}
    Capture page screenshot


Verify the user can edit the single event at Summary step after the recurring is created (OL-T5833)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step    Virtual Chat Booth
    Set Summary step and create event
    Go to edit recurring event      ${event_name}
    Click at    ${SUMMARY_TAB}      slow_down=1s
    Check element display on screen     ${EVENT_OCCURRENCE_MENU_ITEM}
    Click at    ${EVENT_OCCURRENCE_MENU_ITEM}
    Check element display on screen     ${EDIT_EVENT_OCCURRENCE_ICON}
    Check element display on screen     ${DELETE_EVENT_OCCURRENCE_ICON}
    Capture page screenshot
    Click at    ${EDIT_EVENT_OCCURRENCE_ICON}
    ${date_time}=   Edit start date occurence for recurring event   4
    Check element display on screen  ${date_time}
    Capture page screenshot


Verify the user can delete the single event at Summary step after the recurring is created (OL-T5834)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step    Virtual Chat Booth
    Set Summary step and create event
    Go to edit recurring event      ${event_name}
    Click at    ${SUMMARY_TAB}      slow_down=1s
    Check element display on screen     ${EVENT_OCCURRENCE_MENU_ITEM}
    Click at    ${EVENT_OCCURRENCE_MENU_ITEM}
    Check element display on screen     ${EDIT_EVENT_OCCURRENCE_ICON}
    Check element display on screen     ${DELETE_EVENT_OCCURRENCE_ICON}
    Click at    ${DELETE_EVENT_OCCURRENCE_ICON}
    Capture page screenshot
    Click on span text      Delete Occurrence
    Check span display      0 Occurrences
    Capture page screenshot


Verify showing all events when the user clicks on the Occurrence dropdown (OL-T5836, OL-T5837, OL-T5839)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Turn on     ${CAMPUS_TOGGLE}
    Set school name     Automation Test School
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    ${selected_event_day}=      Set recurring rule step       Weekly
    Set Schedule step    Virtual Chat Booth
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event      ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    ${event_occurrence_item}=   Get element count       ${EVENT_OCCURRENCE_ITEM}
    Should be equal as numbers  ${selected_event_day+1}     ${event_occurrence_item}
    Capture page screenshot
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Check span display      Overview
    Check span display      Recurring Rules
    Check span display      Team
    Check span display      Schedule
    Check span display      Registration
    Check span display      Tools
    Check span display      Event Planning
    Capture page screenshot


Verify UI of Event Builders when the user select to edit single event in Recurring Event which is not Campus Event (OL-T5838, OL-T5841, OL-T5842)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step    Virtual Chat Booth
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event      ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
    Element should be disabled      ${EVENT_NAME_INPUT}
    Element should be disabled      ${INTERNAL_EVENT_CHECKBOX}
    Check element not display on screen     ${EVENT_BUILDER_OCCURRENCE_DROPDOWN}
    Check span display      Overview
    Check span display      Team
    Check span display      Schedule
    Check span display      Registration
    Check span display      Tools
    Capture page screenshot


Verify UI of Event Builders when the user select to edit single event in Recurring Event which is a Campus Event (OL-T5840)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Turn on     ${CAMPUS_TOGGLE}
    Set school name     Automation Test School
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    Set Schedule step    Virtual Chat Booth
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event      ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
    Check span display      Overview
    Check span display      Team
    Check span display      Schedule
    Check span display      Registration
    Check span display      Tools
    Check span display      Event Planning
    Capture page screenshot


Verify opening the Event Editor and index to selected event when the user clicks on Edit Event in Event Homepage (OL-T5843)
    [Tags]    skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    Set Schedule step    Virtual Chat Booth
    Set Summary step and create event
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${RECURRING_EVENT_HAS_NAME}     ${event_name}
    wait with short time
    ${event_index_text}=     Get text and format text       ${LAST_RECURRING_EVENT_NAME}    ${event_name}
    Click at        ${LAST_RECURRING_EVENT_NAME}    ${event_name}
    wait for page load successfully
    Capture page screenshot
    Click at        ${ICON_SETTING_EVENT_HOME}
    Click at        ${EDIT_ICON}
    wait for page load successfully
    Check element display on screen     Overview
    Capture page screenshot
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    ${event_buider_text}=   Get text and format text        ${EVENT_OCCURRENCE_LAST_ITEM}
    Should be equal as strings      ${event_index_text}     ${event_buider_text}


Verify the user can edit the day of single event that overlaps another occurrence in Overview step (OL-T5844)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
    Choose next day for start date
    Choose next day for end date
    Click on span text      Update Event
	Update session step     ${session_info.session_name}
	Set tool step and create event
	Capture page screenshot


Verify the user can edit Start Date of an occurrence that overlaps another occurrence in Recurring tab (OL-T5846)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Input into      ${SEARCH_EVENT_INPUT}    ${event_name}
    Click at        ${RECURRING_EVENT_HAS_NAME}     ${event_name}
    wait with short time
    Click at        ${LAST_RECURRING_EVENT_NAME}    ${event_name}
    wait for page load successfully
    Capture page screenshot
    Click at        ${ICON_SETTING_EVENT_HOME}
    Click at        ${EDIT_ICON}
    wait for page load successfully
    Check element display on screen     Overview
    Choose next day for start date
    Choose next day for end date
    Click on span text      Update Event
	Update session step     ${session_info.session_name}
	Set tool step and create event
	Capture page screenshot


Verify the user can edit Start Date of an occurrence that overlaps another occurrence in Summary tab (OL-T5847, OL-T5849)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
    Choose next day for start date
    Choose next day for end date
    Click on span text      Update Event
	Update session step     ${session_info.session_name}
	Set tool step and create event
	Go to edit recurring event   ${event_name}
	Click at    ${SUMMARY_TAB}
    Click at    ${EVENT_OCCURRENCE_LAST_MENU_ITEM}
    Click at    ${EDIT_EVENT_OCCURRENCE_ICON}
    Edit start date occurence for recurring event   1
    Capture page screenshot
	Click create event button
	Capture page screenshot


Check diplaying the Confirm Edit modal when the user selected to edit Single event and clicks on Save Event at the Summary step (OL-T5851, OL-T5852)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Once
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
	Click at    ${TOOLS_STEP_LABEL}      slow_down=1s
	Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Edit Confirm modal of single event is displayed
    Capture page screenshot
    Click at    ${CUSTOM_RADIO}
    wait with short time
    Checkbox should be selected     ${OCCURRENCES_CHECKBOX}
    Capture page screenshot


Verify the Confirm Edit modal will be showed when a single event is selected in the Occurrence dropdown and edits were made (OL-T5853, OL-T5854)
    #TODO Maintain later
    [Tags]  skip
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}    slow_down=1s
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
    ${date}=    Choose next day for start date
    Choose next day for end date
    Click on span text      Update Event
	Update session step     ${session_info.session_name}
	Click at    ${TOOLS_STEP_LABEL}      slow_down=1s
	Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Edit Confirm modal of single event is displayed
    Click at    ${CUSTOM_RADIO}
    Click at    ${CONFIRM_AND_SAVE_BUTTON}
    wait for page load successfully
    Go to edit recurring event   ${event_name}
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}    slow_down=1s
    ${date_locators}=   Format string           ${EVENT_OCCURRENCE_WITH_TEXT}    ${date}
    ${number_of_date}=  Get element count       ${date_locators}
    Should be equal as numbers      ${number_of_date}   2
    Capture page screenshot


Check editing time of the selected single occurrence in the Occurrence dropdown will update all selected occurrences (OL-T5855)
	Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    ${event_name}=      Set Overview step      Virtual    Recurring Event
    Set recurring rule step       Weekly
    &{session_info} =    Set Schedule step    Virtual Chat Booth
    Set Registration step   None    None
    Set landing page
    Set Summary step and create event
    Capture page screenshot
    Go to edit recurring event   ${event_name}
    wait with short time
    Click at    ${EVENT_OCCURRENCE_DROPDOWN}    slow_down=1s
    Click at    ${EVENT_OCCURRENCE_LAST_ITEM}
    wait for page load successfully
    Choose future time for start date
    Click on span text      Update Event
	Update session step     ${session_info.session_name}
	Click at    ${TOOLS_STEP_LABEL}
	Click at    ${CREATE_EVENT_BUTTON_LANDING_PAGE}
    Edit Confirm modal of single event is displayed
    Click at    ${CUSTOM_RADIO}
    Click at    ${CONFIRM_AND_SAVE_BUTTON}
    wait for page load successfully
    Capture page screenshot

*** Keywords ***
Edit Events slide popup is displayed
    Check element display on screen      Edit Event(s)
    Check span display      Event Details
    Check span display      Recurring Event Details
    Check element display on screen       ${START_DATE_FIRST_OCCURRENCE_DROPDOWN}
    Check element display on screen       ${START_TIME_FIRST_OCCURRENCE_DROPDOWN}
    Check element display on screen       ${END_DATE_FIRST_OCCURRENCE_DROPDOWN}
    Check element display on screen       ${END_TIME_FIRST_OCCURRENCE_DROPDOWN}
    Check element display on screen       ${FREQUENCY_DROPDOWN}
    Check element display on screen       ${END_OF_RECURRING_EVENT_DROPDOWN}

Tabs of recurring event are correctly displayed
   Check span display       Overview
   Check span display       Recurring Rules
   Check span display       Team
   Check span display       Schedule
   Check span display       Registration
   Check span display       Tools
   Check span display       Summary

Edit Confirm modal is displayed
    Check span display      Update Event
    Check span display      All Future Occurrences
    Check element display on screen     ${ALL_FUTURE_OCCURRENCES_RADIO}
    Check span display      ${all_occurrence_message}
    Check span display      Custom
    Check element display on screen     ${CUSTOM_RADIO}
    Check span display      ${custom_message}
    Check element display on screen     ${CANCEL_UPDATE_EVENT_BUTTON}
    Check element display on screen     ${CONFIRM_AND_SAVE_BUTTON}

Edit Confirm modal of single event is displayed
    Check span display      Only This Occurrence
    Check element display on screen     ${ONLY_THIS_OCCURRENCE_RADIO}
    Check span display      ${single_event_message}
    Check span display      This Occurrence and All Future Occurrences
    Check element display on screen     ${THIS_OCCURRENCE_AND_FUTURE_RADIO}
    Check span display      ${all_occurrence_message}
    Check span display      Custom
    Check element display on screen     ${CUSTOM_RADIO}
    Check span display      ${custom_message}
    Check element display on screen     ${CANCEL_UPDATE_EVENT_BUTTON}
    Check element display on screen     ${CONFIRM_AND_SAVE_BUTTON}
