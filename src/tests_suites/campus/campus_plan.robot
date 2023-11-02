*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/school_management_page.robot
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../pages/users_page.robot
Library             ../../utils/StringHandler.py
Library             ../../utils/DateTimeUtils.py
Library             DateTime

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regresstion    test

*** Variables ***
@{filter_modal_tab}     Date    Campus    Event Status    Approval status    Fiscal Year
${planned_price}        19
${actual_price}         30
${approval_14}          approval_verify_user_take_action_to_event
${school_14}            school_verify_user_take_action_to_event

*** Test Cases ***
Verify user can remove an filter or all applied filters pills by clicking on the 'x' from the filter pill (OL-T6510, OL-T6511)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_EVENT}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Go To Events Page
    ${event_campus_name}=       Create campus active event      school_name=${school_name}
    Go to campus plan
    Click At    ${FILTER_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL}
    @{event_status_list}=       Create List     Upcoming
    @{campus_list}=     Create List     ${school_name}
    Select option to filter     Event Status    @{event_status_list}
    Select option to filter     Campus      @{campus_list}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}
    FOR    ${value}     IN      @{event_status_list}
        Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_EVENT}       ${value}
    END
    FOR    ${value}     IN      @{campus_list}
        Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_EVENT}       ${value}
    END
    Capture Page Screenshot
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_PILL}
    Capture Page Screenshot
    ${pill_text}=       Get Text    ${EVENT_CAMPUS_PLAN_FILTER_PILL}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_PILL_CLOSE_BUTTON}
    Check Element Not Display On Screen     ${pill_text}
    ${pill_elements} =      Get WebElements     ${EVENT_CAMPUS_PLAN_FILTER_PILL}
    FOR    ${element}    IN    @{pill_elements}
        ${pill_text}=       Get Text    ${EVENT_CAMPUS_PLAN_FILTER_PILL}
        Click At    ${EVENT_CAMPUS_PLAN_FILTER_PILL_CLOSE_BUTTON}
        Check Element Not Display On Screen     ${pill_text}
    END
    Go To Events Page
    Delete Campus Activity      ${event_campus_name}
    Delete a school     ${school_name}


Verify searching the campus event (OL-T6487)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_flow}=       Add approval flow       ${EE_TEAM}
    ${area_name}=       Create a new area       area_user_name=${EE_TEAM}
    ${school_name}=     Create a school in an area      ${area_name}    ${approval_flow}
    Go to CEM page
    switch to user      ${EE_TEAM}
    Go To Events Page
    Choose Event type       Campus Activity
    ${event_name} =     Generate random name    event_campus
    Set Activity Details step       ${event_name}       ${school_name}
    ${date}=    Get value and format text       ${EVENT_START_DATE_VALUE}
    ${format_date}=     Convert Date    ${date}     result_format=%B %-d, %Y
    Set Activity Planning step      ${planned_price}
    ${interviews}=      Set variable    2
    ${engagements}=     Set variable    2
    Input into      ${SUCCESS_CRITERIA_ENGAGEMENT_GOAL}     ${engagements}
    Input into      ${SUCCESS_CRITERIA_SCHEDULED_INTERVIEW_GOAL}    ${interviews}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_LOCATOR}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Click at    ${CONFIRM_BUDGET_SUBMIT_BUTTON}
    Go to campus plan
    Check campus event with mutiple criterias       ${area_name}    ${school_name}      ${event_name}       Draft       Upcoming    ${format_date}
    Go To Events Page
    Delete Campus Activity      ${event_name}
    Delete a school     ${school_name}
    Delete an area      ${area_name}
    Go to CEM page
    Switch to user      ${TEAM_USER}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_flow}
    Capture page screenshot


Verify layout of filter modal is correct following new UI (OL-T6502)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    Click at    ${FILTER_BUTTON}
    @{criterias}=       Create list     Area 1      Date    Campus      Event Status    Approval status     Fiscal Year
    FOR     ${criteria}     IN  @{criterias}
        Check element display on screen     ${criteria}
    END
    Capture page screenshot


Verify display total number of selected events when user clicks on checkbox (OL-T6485)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_EVENT}
    Go to campus plan
    Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       1
    Verify display text     ${EVENT_CAMPUS_PLAN_SUB_HEADER}     1 Selected
    Check filter and export button not display on screen
    Tick checkbox at row of table by index      ${EVENT_CAMPUS_PLAN_CHECKBOX}       2       11
    Verify display text     ${EVENT_CAMPUS_PLAN_SUB_HEADER}     10 Selected
    Check filter and export button not display on screen
    Click at    ${EVENT_CAMPUS_PLAN_SUB_HEADER_CHECKBOX}
    Click at    ${EVENT_CAMPUS_PLAN_SUB_HEADER_CHECKBOX}
    ${number}=      Get total number of events
    Scroll to bottom    ${EVENT_CAMPUS_PLAN_TABLE}      ${number}
    Click at    ${EVENT_CAMPUS_PLAN_SUB_HEADER_CHECKBOX}
    Verify display text     ${EVENT_CAMPUS_PLAN_SUB_HEADER}     ${number} Selected
    FOR     ${index}    IN RANGE       1       ${number}
        ${attribute_format_text}=       Get attribute and format text       class       ${EVENT_CAMPUS_PLAN_CHECKBOX}       ${index}
        Should contain      ${attribute_format_text}    is-checked
    END
    Capture page screenshot


Verify approval status is not updated when the event/activity was cancelled (OL-T6481)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to User      ${EE_TEAM}
    Go to campus plan
    Search campus event     Cancelled
    ${first_event_approval_status}=     Get text and format text    ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}     1
    should not be equal as strings      ${first_event_approval_status}      Cancelled
    Capture page screenshot


Verify Value of Selected Expenses Card is correct when user check/uncheck on the checkboxes (OL-T6712)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn on/off Campus Approval of Campus tab       On
    Switch to User      ${EE_TEAM}
    Go to campus plan
    Click at    ${EVENT_CAMPUS_PLAN_METRIC_BUTTON}
    ${num_of_events}=       Get total number of events
    ${sum_planned_expenses}=    Set variable    0
    ${sum_actual_expenses}=     Set variable    0
    FOR  ${index}   IN RANGE    1   4
        Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       ${index}
        ${sum_planned_expenses}=    Get total column value of selected row      ${EVENT_CAMPUS_PLAN_PLANNED_EXPENSES_TABLE_DATA_USING_INDEX}    ${index}    ${sum_planned_expenses}
        ${sum_actual_expenses}=     Get total column value of selected row      ${EVENT_CAMPUS_PLAN_ACTUAL_EXPENSES_TABLE_DATA}     ${index}    ${sum_actual_expenses}
    END
    ${over_budget}=     evaluate    ${sum_actual_expenses} - ${sum_planned_expenses}
    ${is_over_budget_less_than_0}=      evaluate    ${over_budget} < 0
    IF  ${is_over_budget_less_than_0}
        ${over_budget}=     evaluate    0 - ${over_budget}
    END
    ${selected_expenses_planned}=       Extract number from locator text    ${EVENT_CAMPUS_PLAN_METRICS_PLANNED_LABEL}
    ${selected_expenses_actual}=    Extract number from locator text    ${EVENT _CAMPUS_PLAN_METRICS_ACTUAL_LABEL}
    ${selected_expenses_under_budget}=      Extract number from locator text    ${EVENT_CAMPUS_PLAN_METRICS_UNDER_BUDGET_LABEL}
    Should Be Equal As Integers     ${sum_planned_expenses}     ${selected_expenses_planned}
    Should Be Equal As Integers     ${sum_actual_expenses}      ${selected_expenses_actual}
    Should Be Equal As Integers     ${over_budget}      ${selected_expenses_under_budget}
    capture page screenshot
    Tick checkbox at row of table by index      ${EVENT_CAMPUS_PLAN_CHECKBOX}       1       4
    Verify display text     ${EVENT_CAMPUS_PLAN_METRICS_PLANNED_LABEL}      $0 Planned
    Verify display text     ${EVENT_CAMPUS_PLAN_METRICS_ACTUAL_LABEL}       $0 Actual
    Verify display text     ${EVENT_CAMPUS_PLAN_METRICS_UNDER_BUDGET_LABEL}     --
    capture page screenshot


Verify user can Approve Event when ONLY select an Event has status is Your review (OL-T6496)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    ${event_campus_name_1}=     Create Campus Event with status Pending by first approver       ${school_name}
    Switch to User      ${EE_TEAM}
    Approve events that have status is Your Preview     ${event_campus_name_1}
    Capture page screenshot
    Switch to user      ${TEAM_USER}
    Change approval status from pending to draft    ${event_campus_name_1}
    Go to Events page
    Delete Campus Activity      ${event_campus_name_1}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify user can Approve Event when selecting some Events have status is Your review (OL-T6497)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    ${event_campus_name_1}=     Create Campus Event with status Pending by first approver       ${school_name}
    ${event_campus_name_2}=     Create Campus Event with status Pending by first approver       ${school_name}
    Switch to User      ${EE_TEAM}
    @{event_list}=      Create List     ${event_campus_name_1}      ${event_campus_name_2}
    Approve events that have status is Your Preview     @{event_list}
    capture page screenshot
    Switch to user      ${TEAM_USER}
    Change approval status from pending to draft    ${event_campus_name_1}
    Change approval status from pending to draft    ${event_campus_name_2}
    Go to Events page
    Delete Campus Activity      ${event_campus_name_1}
    Delete Campus Activity      ${event_campus_name_2}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify count number of filter will display when User select option as current logic (OL-T6508)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    Click At    ${FILTER_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL}
    Check Element Not Display On Screen     Save Segment    wait_time=5s
    Capture Page Screenshot
    FOR     ${tab}  IN  @{filter_modal_tab}
        Hover at    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       ${tab}
        Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CLEAR}     ${tab}      wait_time=5s
    END
    Element should be disabled      ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL_EVENT_MATCH}       wait_time=5s
    Capture Page Screenshot
    @{event_status_list}=       Create List     Upcoming    Past
    Select option to filter     Event Status    @{event_status_list}
    ${number_of_option}=    format string       ${EVENT_CAMPUS_PLAN_FILTER_NUMBER_OF_OPTION}    Event Status
    Element should be visible       ${number_of_option}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL_EVENT_MATCH}
    Check Element Display On Screen     Save Segment
    Capture Page Screenshot
    Hover at    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Event Status
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CLEAR}     Event Status
    Capture Page Screenshot
    Element Should Be Enabled       ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}


Verify the applied filter appear as pills on the campus plan view (OL-T6509)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Go To Events Page
    ${event_campus_name}=       Create campus active event      school_name=${school_name}
    Go to campus plan
    Click At    ${FILTER_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Event Status
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      Upcoming
    ${event_matched_1}=     Get Text And Format Text    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_EVENT_MATCH}
    ${number_1}=    Remove String       ${event_matched_1}      events match
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      Upcoming
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      Past
    ${event_matched_2}=     Get Text And Format Text    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_EVENT_MATCH}
    ${number_2}=    Remove String       ${event_matched_2}      events match
    ${result_number} =      evaluate    int(${number_1}) + int(${number_2})
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      Past
    @{event_status_list}=       Create List     Upcoming    Past
    Select option to filter     Event Status    @{event_status_list}
    Check Element Display On Screen     ${result_number} events match
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Campus
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      ${school_name}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_EVENT}       ${school_name}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_EVENT}       Upcoming
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_PILL}
    Go To Events Page
    Delete Campus Activity      ${event_campus_name}
    Delete a school     ${school_name}


Verify the mass actions appears once user clicks at least on 1 checkbox (OL-T6491)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    ${event_campus_name_1}=     Create Campus Event with status Pending by first approver       ${school_name}
    Go To Campus Plan
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${event_campus_name_1}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_1}
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}       wait_time=5s
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}       wait_time=5s
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}      wait_time=5s
    Capture Page Screenshot
    ${event_campus_name_2}=     Create Campus Event with status Denied by first approver    ${school_name}      ${EE_TEAM}
    Switch To User      ${TEAM_USER}
    Go To Campus Plan
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${event_campus_name_2}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_2}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Capture Page Screenshot
    Switch To User      ${EE_TEAM}
    Search campus event     ${event_campus_name_1}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_1}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Capture Page Screenshot
    Go To Events Page
    ${event_campus_name_3}=     Create campus active event      school_name=${school_name}
    Go To Campus Plan
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${event_campus_name_3}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_3}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Capture Page Screenshot
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${school_name}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_1}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_3}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Capture Page Screenshot
    Go To Events Page
    Delete Campus Activity      ${event_campus_name_3}
    Switch To User      ${TEAM_USER}
    Change approval status from pending to draft    ${event_campus_name_1}
    Go To Events Page
    Delete Campus Activity      ${event_campus_name_1}
    Delete Campus Activity      ${event_campus_name_2}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify Save the filters applied to the campus plan view by clicking the Save Segment within the filter modal (OL-T6513)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    Click At    ${FILTER_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL}
    @{event_status_list}=       Create List     Upcoming    Past    Cancelled
    Select option to filter     Event Status    @{event_status_list}
    Check Element Display On Screen     Save Segment
    Check Element Display On Screen     Clear All Filters
    Capture Page Screenshot
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_SAVE_SEGMENT}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_NEW_SAVE_SEGMENT}
    Textfield Value Should Be       ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_TEXTBOX}    ${EMPTY}
    Element Should Be Disabled      ${EVENT_CAMPUS_PLAN_FILTER_SEGMENT_NAME_SAVE}
    Reload Page
    ${segment_name}=    Create A New Segment With Event Status
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SAVED_SEGMENT}      ${segment_name}
    Capture Page Screenshot
    Delete A Segment    ${segment_name}


Verify user can Deny Event when ONLY select an Event or Events has status is Your review (OL-T6499, OL-T6500)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    ${event_campus_name_1}=     Create Campus Event with status Pending by first approver       ${school_name}
    ${event_campus_name_2}=     Create Campus Event with status Pending by first approver       ${school_name}
    Switch To User      ${EE_TEAM}
    Go to review needed list
    # Select an event
    Search campus event     ${school_name}
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_1}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    # Select events
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_2}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Capture Page Screenshot
    Click At    ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_MODAL}
    Capture Page Screenshot
    Click At    ${EVENT_CAMPUS_PLAN_CLOSE_MODAL_BUTTON}
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_MODAL}       wait_time=5s
    Check Text Display      ${event_campus_name_1}
    Check Text Display      ${event_campus_name_2}
    Capture Page Screenshot
    Click At    ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_CONFIRM_MODAL_BUTTON}
    Click At    ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${school_name}
    Check Element Not Display On Screen     ${event_campus_name_1}      wait_time=5s
    Check Element Not Display On Screen     ${event_campus_name_2}      wait_time=2s
    Capture Page Screenshot
    Switch To User      ${TEAM_USER}
    Delete Campus Activity      ${event_campus_name_1}
    Delete Campus Activity      ${event_campus_name_2}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify user can Approve Event when only some of the selected events/activities can actually be approved (OL-T6498)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to events page
    ${event_name_pending}=      Create Campus Event with status Pending by first approver       ${school_14}
    Switch to User      ${EE_TEAM}
    Go to events page
    ${event_name_draft}=    Create campus active event      school_name=${school_14}
    Get total number of events and traverse the data table      ${school_14}
    Click at    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_name_pending}
    Click at    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_name_draft}
    Check UI for the all campus event list by selecting event
    Click at    ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    ${is_final_approval}=       Run keyword and return status       Check element display on screen     Final Approval
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${CONFIRM_DIALOG_BUTTON}
    Go to campus plan
    Search campus event     ${event_name_pending}
    ${status}=      Get text and format text    ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}     1
    IF  ${is_final_approval}
        should be equal as strings      ${status}       Approved
    ELSE
        should be equal as strings      ${status}       Pending
    END
    capture page screenshot


Verify User can Deny Event when only some of the selected events/activities can actually be approved (OL-T6501)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to events page
    ${event_name_pending}=      Create Campus Event with status Pending by first approver       ${school_14}
    Switch to User      ${EE_TEAM}
    Go to events page
    ${event_name_draft}=    Create campus active event      school_name=${school_14}
    Get total number of events and traverse the data table      ${school_14}
    Click at    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_name_pending}
    Click at    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_name_draft}
    Check UI for the all campus event list by selecting event
    Click at    ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Go to campus plan
    Search campus event     ${event_name_pending}
    ${status}=      Get text and format text    ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}     1
    Should be equal as strings      ${status}       Denied
    capture page screenshot


Verify user can Send for Approval when only some of the selected events/activities can actually be sent for approval. (OL-T6495)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to events page
    ${event_name_pending}=      Create Campus Event with status Pending by first approver       ${school_14}
    Switch to User      ${EE_TEAM}
    Go to events page
    ${event_name_draft}=    Create campus active event      school_name=${school_14}
    Get total number of events and traverse the data table      ${school_14}
    Click at    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_name_pending}
    Click at    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_name_draft}
    Check UI for the all campus event list by selecting event
    Click at    ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    ${is_final_approval}=       Run keyword and return status       Check element display on screen     Final Approval
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_AND_SEND}
    Go to campus plan
    Search campus event     ${event_name_draft}
    ${status}=      Get text and format text    ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}     1
    IF  ${is_final_approval}
        should be equal as strings      ${status}       Approved
    ELSE
        should be equal as strings      ${status}       Pending
    END
    capture page screenshot


Verify user can Send for Approval when select Events has status is Draft/denied by first approval (OL-T6494)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to events page
    ${event_name}=      Create Campus Event with status Denied by first approver    ${school_14}    ${EE_TEAM}
    Switch to user      ${TEAM_USER}
    Go to send for approval
    Search campus event     ${event_name}
    Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       1
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    capture page screenshot
    Click at    ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    capture page screenshot
    Click at    ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_AND_SEND}
    Go to campus plan
    Search campus event     ${event_name}
    ${status}=      Get text and format text    ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}     1
    Should be equal as strings      ${status}       Pending
    capture page screenshot


Verify display data of event in Event Status columns (OL-T6480)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    Look over an event by index and check its property      Event Status    Upcoming    ${EVENT_CAMPUS_PLAN_EVENT_STATUS_TABLE_DATA}    1
    Look over an event by index and check its property      Event Status    Past    ${EVENT_CAMPUS_PLAN_EVENT_STATUS_TABLE_DATA}    1
    Look over an event by index and check its property      Event Status    Cancelled       ${EVENT_CAMPUS_PLAN_EVENT_STATUS_TABLE_DATA}    1
    Go To Events Page
    ${upcoming_event}=      Create campus active event
    Go To Events Page
    Search event    ${upcoming_event}
    Click on ellipses icon on the Event Occurrence row
    Click at    ${EVENT_EDIT_ACTIVITY_BUTTON}
    Choose event start date     1
    Save edited campus activity
    Go to campus plan
    Search campus event     ${upcoming_event}
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_STATUS_TABLE_DATA}    Postponed       1
    capture page screenshot
    Go to Events page
    Search event    ${upcoming_event}
    Delete Campus Activity      ${upcoming_event}


Verify user can Send for Approval when ONLY select an Event has status is Draft/denied by first approval (OL-T6493, OL-T6494)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EN_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Go To Events Page
    Switch To User      ${EE_TEAM}
    ${event_campus_name_1}=     Create Campus Event with status Denied by first approver    ${school_name}      ${EN_TEAM}
    Switch To User      ${EE_TEAM}
    Go To Events Page
    ${event_campus_name_2}=     Create campus active event      school_name=${school_name}
    Go To Send For Approval
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_1}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Capture Page Screenshot
    Click At    ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}     ${event_campus_name_2}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_MODAL}
    Click At    ${EVENT_CAMPUS_PLAN_CLOSE_MODAL_BUTTON}
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_MODAL}    wait_time=5s
    Check Text Display      ${event_campus_name_1}
    Check Text Display      ${event_campus_name_2}
    Capture Page Screenshot
    Click At    ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_CONFIRM_MODAL_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_CONFIRM_AND_SEND_BUTTON}
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${school_name}
    Check Element Not Display On Screen     ${event_campus_name_1}      wait_time=5s
    Check Element Not Display On Screen     ${event_campus_name_2}      wait_time=2s
    Capture Page Screenshot
    Go To Campus Plan
    Input Into      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${school_name}
    Check Text Display      Pending
    Capture Page Screenshot
    Change approval status from pending to draft    ${event_campus_name_1}
    Change approval status from pending to draft    ${event_campus_name_2}
    Go To Events Page
    Delete Campus Activity      ${event_campus_name_1}
    Delete Campus Activity      ${event_campus_name_2}
    Switch To User      ${TEAM_USER}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify the Approval Status filter display locked with Draft and Denied selected when user click Filter from Send for Approval subsection (OL-T6507)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_EVENT}
    Go To Send For Approval
    Click At    ${FILTER_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL}
    ${number_of_option}=    format string       ${EVENT_CAMPUS_PLAN_FILTER_NUMBER_OF_OPTION}    Approval status
    Element should be visible       ${number_of_option}
    ${option_filter}=       Get Text And Format Text    ${number_of_option}
    should be equal as strings      ${option_filter}    2
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Approval status
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_LIST}
    ${draft_checkbox}=      format string       ${EVENT_CAMPUS_PLAN_FILTER_CHECKBOX}    Draft
    ${denied_checkbox}=     format string       ${EVENT_CAMPUS_PLAN_FILTER_CHECKBOX}    Denied
    Element Should Be Disabled      ${draft_checkbox}
    Element Should Be Disabled      ${denied_checkbox}
    Checkbox Should Be Selected     ${draft_checkbox}
    Checkbox Should Be Selected     ${denied_checkbox}
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CLEAR}     Approval status     wait_time=5s
    Capture Page Screenshot


Verify the Approval Status filter display locked with Your Review selected when user click filter from Needs Review subsection (OL-T6506)
    Given Setup test
    when Login into system with company     ${EDIT_EVERYTHING}      ${COMPANY_EVENT}
    Go To Review Needed List
    Click At    ${FILTER_BUTTON}
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL}
    ${number_of_option}=    format string       ${EVENT_CAMPUS_PLAN_FILTER_NUMBER_OF_OPTION}    Approval status
    Element should be visible       ${number_of_option}
    ${option_filter}=       Get Text And Format Text    ${number_of_option}
    should be equal as strings      ${option_filter}    1
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Approval status
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_LIST}
    ${your_review_checkbox}=    format string       ${EVENT_CAMPUS_PLAN_FILTER_CHECKBOX}    Your Review
    Element Should Be Disabled      ${your_review_checkbox}
    Checkbox Should Be Selected     ${your_review_checkbox}
    Check Element Not Display On Screen     ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CLEAR}     Your Review     wait_time=5s
    Capture Page Screenshot


Verify the Total Expenses and Approval Statuses card update based on filters applied to the table (OL-T6523)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Go To Events Page
    Switch To User      ${EE_TEAM}
    ${event_campus_name}=       Create campus active event      school_name=${school_name}
    Go To Campus Plan
    Click At    ${EVENT_CAMPUS_PLAN_METRIC_BUTTON}
    Click At    ${FILTER_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Campus
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      ${school_name}
    ${event_matched}=       Get Text And Format Text    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_EVENT_MATCH}
    ${total_event_matched}=     Remove String       ${event_matched}    events match
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}
    ${total_event_draft_status}=    Get Text And Format Text    ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_METRIC}     Draft
    Should Be Equal As Numbers      ${total_event_matched}      ${total_event_draft_status}
    ${total_planned_price} =    Get Text And Format Text    ${EVENT_CAMPUS_PLAN_METRICS_TOTAL_PLANNED_PRICE_LABEL}
    ${total} =      Remove String       ${total_planned_price}      $       Planned
    ${planned_price_event} =    Get Text And Format Text    ${EVENT_CAMPUS_PLAN_PLANNED_EXPENSES_TABLE_DATA_USING_NAME}     ${event_campus_name}
    ${price} =      Remove String       ${planned_price_event}      $
    Should Be Equal As Numbers      ${price}    ${total}
    Go To Events Page
    Delete Campus Activity      ${event_campus_name}
    Switch To User      ${TEAM_USER}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify display data of event correctly in all columns when Approval is ON in Client Setup (OL-T6482)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn on/off Campus Approval of Campus tab       On
    Verify display data of event correctly in all columns


Verify detail of Approval Statuses Card display correctly (OL-T6527)
    Given setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    Click at    ${EVENT_CAMPUS_PLAN_METRIC_BUTTON}
    Check span display      Approved Events
    Check span display      Pending Events
    Check span display      Denied Events
    Check span display      Draft Events
    Check span display      Your Review Events
    Capture page screenshot


Verify new created events automatically be added to saved segment view within approval status is Draft (OL-T6515)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    ${segment_name}=    Create a new segment with approval status
    Check Element Display On Screen     ${EVENT_CAMPUS_PLAN_SAVED_SEGMENT}      ${segment_name}
    Capture page screenshot
    ${total_event_in_segment}=      Get Text And Format Text    ${EVENT_CAMPUS_TOTAL_SEGMENT_EVENTS}    ${segment_name}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Go To Events Page
    ${event_name}=      Create Campus Active Event      school_name=${school_name}
    Go To Events Page
    ${total_event_in_segment_after_added}=      Evaluate    int(${total_event_in_segment}) + 1
    Verify display text     ${EVENT_CAMPUS_TOTAL_SEGMENT_EVENTS}    ${total_event_in_segment_after_added}       ${segment_name}
    capture page screenshot
    Delete Campus Activity      ${event_name}
    Delete A Segment    ${segment_name}
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify options display correctly when click the ellipsis on a saved segment (OL-T6517)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to campus plan
    ${approval_status_segment}=     Create a new segment with approval status
    Reload page
    ${event_status_segment}=    Create a new segment with event status
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_EXTEND}     ${approval_status_segment}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEGMENT_RENAME_TAG}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEGMENT_DELETE_TAG}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEGMENT_REORDER_TAG}
    Capture page screenshot
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_RENAME_TAG}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEGMENT_POPUP}      Rename Segment
    Capture Page Screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_EXTEND}     ${approval_status_segment}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_DELETE_TAG}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEGMENT_POPUP}      Delete Segment
    Capture Page Screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_EXTEND}     ${approval_status_segment}
    Click At    ${EVENT_CAMPUS_PLAN_SEGMENT_REORDER_TAG}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEGMENT_REORDER_POPUP}
    Capture Page Screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Delete A Segment    ${approval_status_segment}
    Delete A Segment    ${event_status_segment}


Verify Review Needed list display correctly after Approve Event/Deny successfully (OL-T6713)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Events Page
    ${event_name_1}=    Create Campus Event with status Pending by first approver       school_name=${school_14}
    Go To Events Page
    ${event_name_2}=    Create Campus Event with status Pending by first approver       school_name=${school_14}
    Switch to user      ${EE_TEAM}
    Go to review needed list
    ${number_of_review_needed_events}=      Get text and format text    ${EVENT_CAMPUS_PLAN_TOTAL_STATUS_OF_EVENTS}     Review Needed
    Search campus event     ${event_name_1}
    Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       1
    Check element display on screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Capture Page Screenshot
    Click at    ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_CONFIRM_MODAL_BUTTON}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    Search campus event     ${event_name_1}
    Check element display on screen     Nothing to show right now.
    Capture Page Screenshot
    ${number_of_review_needed_events_after_approve}=    Evaluate    ${number_of_review_needed_events} - 1
    Verify display text     ${EVENT_CAMPUS_PLAN_TOTAL_STATUS_OF_EVENTS}     ${number_of_review_needed_events_after_approve}     Review Needed
    Capture Page Screenshot
    Search campus event     ${event_name_2}
    Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       1
    Click at    ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_CONFIRM_MODAL_BUTTON}
    Click at    ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Search campus event     ${event_name_2}
    Check element display on screen     Nothing to show right now.
    Capture Page Screenshot
    ${number_of_review_needed_events_after_denied}=     Evaluate    ${number_of_review_needed_events_after_approve} - 1
    Verify display text     ${EVENT_CAMPUS_PLAN_TOTAL_STATUS_OF_EVENTS}     ${number_of_review_needed_events_after_denied}      Review Needed
    Capture Page Screenshot
    Switch to user      ${TEAM_USER}
    Change approval status from pending to draft    ${event_name_1}
    Go to Events page
    Delete Campus Activity      ${event_name_1}
    Delete Campus Activity      ${event_name_2}


Verify Review Needed tab is NOT shown in left-navigation when login by User is NOT an approver (OL-T6471)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user      ${FULL_USER_AUTOMATION}
    Go to campus plan
    Check element not display on screen     ${EVENT_CAMPUS_PLAN_CAMPUS_PLAN_LABEL}      Review Needed
    Capture page screenshot
    Click At    ${FILTER_BUTTON}
    @{approval_status_list}=    Create List     Approved    Draft       Pending     Denied      Your Review
    Select option to filter     Approval status     @{approval_status_list}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}
    Check element display on screen     Nothing to show right now.
    Capture page screenshot


Verify Review Needed tab is shown in left-navigation when login by User is an approver (OL-T6470)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Switch to user      ${EE_TEAM}
    Go to review needed list
    Check element display on screen     ${EVENT_CAMPUS_PLAN_CAMPUS_PLAN_LABEL}      Review Needed
    Capture page screenshot
    Click At    ${FILTER_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Approval status
    The checkbox should be checked      ${EVENT_CAMPUS_PLAN_YOUR_REVIEW_CHECKBOX}
    Capture page screenshot
    Go to send for approval
    Click At    ${FILTER_BUTTON}
    Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}       Approval status
    The checkbox should be checked      ${EVENT_CAMPUS_PLAN_DENIED_CHECKBOX}
    The checkbox should be checked      ${EVENT_CAMPUS_PLAN_DRAFT_CHECKBOX}
    Capture page screenshot


Verify Send for Approval action does NOT appear when User has not created any event (OL-T6492)
    Given setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to events page
    ${event_1}=     Create campus active event      school_name=${school_14}
    ${event_2}=     Create Campus Event with status Denied by first approver    ${school_14}    ${EE_TEAM}
    Switch to user      ${EE_TEAM}
    Go to campus plan
    Search campus event     ${event_1}
    Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       1
    Check element not display on screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}       wait_time=2s
    capture page screenshot
    Search campus event     ${event_2}
    Click at    ${EVENT_CAMPUS_PLAN_CHECKBOX}       1
    Check element not display on screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}       wait_time=2s
    capture page screenshot
    switch to user      ${TEAM_USER}
    Go to events page
    Delete Campus Activity      ${event_1}
    Delete Campus Activity      ${event_2}

*** Keywords ***
Look over an event by index and check its property
    [Arguments]     ${property}     ${event_status}     ${property_locator}     ${index}
    Click at    ${FILTER_BUTTON}
    Select option to filter     ${property}    ${event_status}
    Click at    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_APPLY_BUTTON}
    Wait for page load successfully
    Verify display text     ${property_locator}      ${event_status}    ${index}
    Click at    ${EVENT_CAMPUS_PLAN_FILTER_PILL_CLOSE_BUTTON}
    Capture page screenshot

Verify display data of event correctly in all columns
    Go To Approvals Builder Page
    ${approval_flow}=       Add approval flow       ${EE_TEAM}
    ${area_name}=       Create a new area       area_user_name=${EE_TEAM}
    ${school_name}=     Create a school in an area      ${area_name}    ${approval_flow}
    Go to CEM page
    switch to user      ${EE_TEAM}
    Go To Events Page
    Choose Event type       Campus Activity
    ${event_name} =     Generate random name    event_campus
    Set Activity Details step       ${event_name}       ${school_name}
    ${date}=    Get value and format text       ${EVENT_START_DATE_VALUE}
    ${format_date}=     Convert Date    ${date}     result_format=%B %-d, %Y
    Set Activity Planning step      ${planned_price}
    ${interviews}=      Set variable    2
    ${engagements}=     Set variable    2
    Input into      ${SUCCESS_CRITERIA_ENGAGEMENT_GOAL}     ${engagements}
    Input into      ${SUCCESS_CRITERIA_SCHEDULED_INTERVIEW_GOAL}    ${interviews}
    Click at    ${CREATE_EVENT_BUTTON_VENUE_TYPE_MODAL}
    Check element display on screen     ${EVENT_ACTIVITY_DASHBOARD_LOCATOR}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price      ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Click at    ${CONFIRM_BUDGET_SUBMIT_BUTTON}
    Go to campus plan
    Search campus event     ${event_name}
    capture page screenshot
    Verify display text     ${EVENT_CAMPUS_PLAN_AREA_NAME_TABLE_DATA}       ${area_name}    1
    Verify display text     ${EVENT_CAMPUS_PLAN_CAMPUS_NAME_TABLE_DATA}     ${school_name}      1
    Verify display text     ${EVENT_CAMPUS_PLAN_APPROVAL_STATUS_TABLE_DATA}     Draft       1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_NAME_TABLE_DATA}      ${event_name}       1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_STATUS_TABLE_DATA}    Upcoming       1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_TYPE_TABLE_DATA}      Activity    1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_DATE_TABLE_DATA}      ${format_date}      1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_MANAGER_TABLE_DATA}       ${EE_TEAM}      1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_ENGAGEMENT_TABLE_DATA}    2       1
    Verify display text     ${EVENT_CAMPUS_PLAN_EVENT_INTERVIEW_TABLE_DATA}     2       1
    Verify text contain     ${EVENT_CAMPUS_PLAN_PLANNED_EXPENSES_TABLE_DATA_USING_INDEX}    ${planned_price}    1
    Verify text contain     ${EVENT_CAMPUS_PLAN_ACTUAL_EXPENSES_TABLE_DATA}     ${actual_price}     1
    capture page screenshot
    Go To Events Page
    Delete Campus Activity      ${event_name}
    Delete a school     ${school_name}
    Delete an area      ${area_name}
    Go to CEM page
    Switch to user  ${TEAM_USER}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_flow}

Edit event to be further in the future
    Search event     event_campus
    ${past_event}=  Get text and format text        ${UPCOMING_EVENT_NAME}
    Click on ellipses icon on the Event Occurrence row
    Click by JS    ${EVENT_EDIT_ACTIVITY_BUTTON}
    ${time}=     Get value and format text       ${EVENT_START_DATE_VALUE}
    ${number_arrays}=       extract numbers        ${time}
    ${day}=     Convert To Integer     ${number_arrays}[2]
    ${tomorrow}=    evaluate    ${day} + 1
    Click at    ${EVENT_START_DATE}
    Click at    ${DATE_FIRST_OCCURRENCE}    ${tomorrow}
    Save edited campus activity
    [Return]    ${past_event}

Select option to filter
    [Arguments]    ${type}      @{list}
    FOR    ${value}     IN      @{list}
        Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_TAB}   ${type}
        Click At    ${EVENT_CAMPUS_PLAN_FILTER_MODAL_CHECKBOX}      ${value}
    END

Check filter and export button not display on screen
    Check element not display on screen     ${FILTER_BUTTON}
    Check element not display on screen     ${EXPORT_BUTTON}
    Capture page screenshot

Get total column value of selected row
    [Arguments]      ${column_name}      ${number}   ${sum_expenses_para}
    ${number}=       Extract number from locator text        ${column_name}        ${number}
    ${sum_expenses}=    evaluate    ${sum_expenses_para} + ${number}
    [Return]        ${sum_expenses}

Approve events that have status is Your Preview
    [Arguments]     @{event_list}
    Go to review needed list
    FOR     ${event_name}    IN  @{event_list}
         Click at        ${EVENT_CAMPUS_PLAN_EVENT_CHECKBOX}    ${event_name}
    END
    Check element display on screen      ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check element display on screen      ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    capture page screenshot
    Click at        ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check element display on screen      ${EVENT_ACTIVITY_DASHBOARD_DIALOG}
    Capture page screenshot
    Click at    ${CANCEL_DIALOG_BUTTON}
    Click at    ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Click at    ${CONFIRM_DIALOG_BUTTON}
    ${is_final_approval}=       Run keyword and return status        Check element display on screen      Final Approval
    Click at        ${CONFIRM_DIALOG_BUTTON}
    Go to campus plan
    FOR     ${event_name}    IN  @{event_list}
         Search campus event           ${event_name}
         ${status}=      Get text and format text  ${EVENT_CAMPUS_PLAN_EVENT_APPROVAL_STATUS}   ${event_name}
         IF  ${is_final_approval}
            should be equal as strings  ${status}   Approved
         ELSE
            should be equal as strings  ${status}   Pending
         END
         capture page screenshot
    END

Tick checkbox at row of table by index
    [Arguments]     ${locator}      ${from}     ${to}
    FOR  ${index}   IN RANGE    ${from}   ${to}
        Click at    ${locator}       ${index}
    END

Change approval status from pending to draft
    [Arguments]    ${event_campus_name}
    Go To Events Page
    Input Into      ${SEARCH_EVENT_INPUT}     ${event_campus_name}
    Click at        ${UPCOMING_EVENT_HAS_NAME}    ${event_campus_name}
    Click At        ${EVENT_ACTIVITY_DASHBOARD_REMOVE_APPROVAL_BUTTON}
    Click At        ${EVENT_APPROVAL_STATUS_CONFIRM_REMOVE_BUTTON}

Check UI for the all campus event list by selecting event
    Check element display on screen     ${EVENT_CAMPUS_PLAN_SEND_APPROVAL_BUTTON}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_APPROVE_EVENT_BUTTON}
    Check element display on screen     ${EVENT_CAMPUS_PLAN_DENY_EVENT_BUTTON}
    Capture page screenshot

Check campus event with mutiple criterias
    [Arguments]     ${area_name}    ${school_name}  ${event_name}   ${approval_status}  ${event_status}     ${date}
    Check campus event with criteria    Area name       ${area_name}
    Check campus event with criteria    Campus name     ${school_name}
    Check campus event with criteria    Event name      ${event_name}
    Check campus event with criteria    Approval Status     ${approval_status}
    Check campus event with criteria    Event Status    ${event_status}
    Check campus event with criteria    Date    ${date}

