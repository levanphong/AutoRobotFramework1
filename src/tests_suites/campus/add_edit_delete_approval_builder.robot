*** Settings ***
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../pages/school_management_page.robot
Resource            ../../pages/event_creating_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/alert_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Force Tags          regression    stg    test

Documentation       Client Setup > Campus > Campus Planning toggle ON, Approvals toggle ON, Allow users toggle ON

*** Variables ***
${approval_01}      approval_turn_on_event_planning_first
${approval_02}      approval_turn_on_event_planning_second
${approval_03}      approval_event_status_new_approval
${approval_04}      approval_event_edit_delete_approval_flow
${approval_05}      approval_replace_user_at_middle_approval
${school_01}        school_turn_on_event_planning_pre_off
${school_02}        school_event_status_new_approval
${school_03}        school_event_edit_delete_approval_flow
${school_04}        school_replace_user_at_middle_approval
${approval_06}      approval_add_user_for_checking_user_view_school_and_event
${school_06}        school_added_by_event_connection_approval
${approval_07}      approval_delete_user_for_checking_user_can_not_view_school_and_accept_approver
${school_07}        school_delete_users_added_for_checking_user_can_not_view_school_and_accept_approver
${approval_08}      approval_add_user_CA_Team
${school_08}        school_added_by_event_connection_approval_add_CA_Team
${approval_09}      approval_add_user_second_CA_Team
${school_09}        school_added_by_event_connection_approval_add_second_CA_Team
${approval_10}      approval_add_user_when_user_can_view_from_school
${school_10}        school_user_added_when_user_can_view_from_school
${approval_11}      approval_add_user_who_created_and_submited_approval
${school_11}        school_user_added_who_created_and_submited_approval
${approval_12}      approval_only_replace_user_at_first_approver
${school_12}        school_only_replace_user_at_first_approver
${approval_13}      approval_only_replace_user_at_last_approver
${school_13}        school_only_replace_user_at_last_approver

*** Test Cases ***
Check Approval Builder when login user role is different Admin (OL-T5065)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Click Setting Icon On Menu
    Check Element Display On Screen     ${MENU_SETTINGS_ITEM_LINK}      Approvals Builder
    Capture Page Screenshot
    Switch To User      ${EE_TEAM}
    Click Setting Icon On Menu
    Check Element Not Display On Screen     ${MENU_SETTINGS_ITEM_LINK}      Approvals Builder       wait_time=2s
    Capture Page Screenshot


Check the list of Approval Builder when login user role is Admin (OL-T5066)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    Check Element Display On Screen     ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}
    Check Text Display      Name
    Check Text Display      School Assigned
    Check Text Display      Last edited
    Capture Page Screenshot
    Delete Approval Flow    ${approval_name}


Verify Search Approval Flow (OL-T5067)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    # Input data on [Search] Textbox is less than 2 characters
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}      a
    Check Text Display      ${approval_name}
    Capture Page Screenshot
	# Input data on [Search] Textbox is more than 2 characters
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}      aut
    Check Text Display      ${approval_name}
    Capture Page Screenshot
    Delete Approval Flow    ${approval_name}


Verify when have no School assigment in Approval Flow (OL-T5071, OL-T5079)
    # Verify Create Approval Flow success when click Save (same steps as OL-T5071)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}      ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_SCHOOL_EMPTY_ASSIGNED_OF_ROW}    ${approval_name}
    Capture Page Screenshot
    Delete Approval Flow    ${approval_name}


Verify when click on the ellipses (OL-T5072)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    # Verify Sub-Menu When Click on the Elipsis
    Open Sub-Menu       ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_SUBMENU_DUPLICATE}       ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_SUBMENU_DELETE}      ${approval_name}
    Capture Page Screenshot
    # Verify Click Edit on Sub-Menu
    Click At    ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_MODAL}
    Capture Page Screenshot
    Click At    ${APPROVAL_BUILDER_MODAL_CANCEL_BUTTON}
    # Verify Click Duplicate and Delete on Sub-Menu
    Open Sub-Menu       ${approval_name}
    Click At    ${APPROVAL_BUILDER_SUBMENU_DUPLICATE}       ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_MODAL}
    Capture Page Screenshot
    Click At    ${APPROVAL_BUILDER_MODAL_CANCEL_BUTTON}
    Check Text Display      Copy of ${approval_name}
    Capture Page Screenshot
    Delete Approval Flow    Copy of ${approval_name}
    Delete Approval Flow    ${approval_name}


Verify click on Add Approval Flow button (OL-T5073, OL-T5074)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    Click At    ${APPROVAL_BUILDER_ADD_APPROVAL_FLOW_BUTTON}
    Verify Display Text     ${APPROVAL_BUILDER_INPUT_APPROVAL_FLOW_NAME}    ${EMPTY}
    Check Element Not Display On Screen     ${APPROVAL_BUILDER_ADD_APPROVER_ITEM}       wait_time=2s
    Check Element Display On Screen     ${APPROVAL_BUILDER_ADD_APPROVER_BUTTON}
    Verify Element Is Disable       ${APPROVAL_BUILDER_CREATE_APPROVAL_FLOW_BUTTON}
    Capture Page Screenshot
    Click At    ${APPROVAL_BUILDER_MODAL_CANCEL_BUTTON}
    Check Element Not Display On Screen     ${APPROVAL_BUILDER_MODAL}       wait_time=2s
    Capture Page Screenshot
    # Verify click on Save button without entering Approval Flow Name (OL-T5074)
    Click At    ${APPROVAL_BUILDER_ADD_APPROVAL_FLOW_BUTTON}
    Add User Approver       ${EE_TEAM}
    Verify Element Is Disable       ${APPROVAL_BUILDER_CREATE_APPROVAL_FLOW_BUTTON}
    Capture Page Screenshot


Verify list Approver when change position User in list and Verify list Approver when change User Name in list (OL-T5077, T5078)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EN_TEAM}
    Open Sub-Menu       ${approval_name}
    Click At    ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    # Verify delete approver when click button [Trash]
    Click At    ${APPROVAL_BUILDER_DELETE_USER}     ${EN_TEAM}
    Check Element Not Display On Screen     ${EN_TEAM}      wait_time=2s
    Capture Page Screenshot
    Add User Approver       ${EN_TEAM}
    Check Span Display      ${EN_TEAM}
    Capture Page Screenshot
    # Verify approver is changed when using button [Change Approver]
    Change approver     ${EN_TEAM}      ${CA_TEAM}
    Check Span Display      ${CA_TEAM}
    Capture Page Screenshot
    Click At    ${APPROVAL_BUILDER_MODAL_CANCEL_BUTTON}
    Delete Approval Flow    ${approval_name}


Check UI School Management when toggle Approval is ON in Client Setup (OL-T5080)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${area_name} =      Create a new area       None    ${BS_TEAM}
    Check UI when click an area     ${area_name}
    Reload Page
    ${school_name} =    Create a new school
    Check UI when click a school    ${school_name}
    Check UI when turn on event planning approval toggle


Verify turn ON Event Planning Approval toggle and don't select new Approval when it was turned OFF previously (OL-T5082, OL-T5083)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    # Init data test
    ${approval_name}=       Set Variable    ${approval_01}
    ${school_name}=     Set Variable    ${school_01}
    Create Approval Flow With Given Name    ${approval_name}    ${EE_TEAM}
    Create A New School     school_name=${school_name}      approval_name=${approval_name}      check_exist=True
    Go To Events Page
    ${event_campus_1}=      Create campus active event      school_name=${school_name}
    ${event_campus_2}=      Create Campus Event With Status Approved By One Approver    ${school_name}      ${EE_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_3}=      Create Campus Event With Status Pending By First Approver       ${school_name}
    ${event_campus_4}=      Create Campus Event With Status Denied By First Approver    ${school_name}      ${EE_TEAM}
    # Turn off then turn on school aproval flow
    Switch To User      ${TEAM_USER}
    Turn Approval Flow OFF      ${school_name}
    @{list_events}=     Create List     ${event_campus_1}       ${event_campus_2}       ${event_campus_3}       ${event_campus_4}
    FOR     ${event_name}    IN  @{list_events}
        Go To Event Dashboard       ${event_name}
        Check Element Not Display On Screen     ${SUBMIT_APPROVAL_BUTTON}       wait_time=2s
        Capture Page Screenshot
    END
    Turn Approval Flow ON       ${school_name}      ${approval_name}
    # Check school assigned in approval flow record
    Go To Approvals Builder Page
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}      ${approval_name}
    ${approval_row_school_assigned}=    Format String       ${APPROVAL_BUILDER_A_SCHOOL_ASSIGNED_AVAILABLE_OF_ROW}      ${approval_name}    ${school_name}
    Check Element Display On Screen     ${approval_row_school_assigned}
    Capture Page Screenshot
    Check campus event approval status      ${event_campus_1}       Draft
    Check Element Display On Screen     ${SUBMIT_APPROVAL_BUTTON}
    Capture Page Screenshot
    Check campus event approval status      ${event_campus_2}       Approved
    Check campus event approval status      ${event_campus_3}       Pending
    Check campus event approval status      ${event_campus_4}       Denied
    # Verify turn ON Event Planning Approval toggle and select new Approval when it was turned OFF previously (OL-T5083)
    # Turn off then change school aproval flow
    Turn Approval Flow OFF      ${school_name}
    ${approval_name}=       Set Variable    ${approval_02}
    Create Approval Flow With Given Name    ${approval_name}    ${CA_TEAM}
    Turn Approval Flow ON       ${school_name}      ${approval_name}
    Check campus event approval status      ${event_campus_1}       Draft
    Check campus event approval status      ${event_campus_2}       Approved
    Go To Event Dashboard       ${event_campus_3}
    Check approval status and verify history change     Pending     ${CA_TEAM}      Approver: ${CA_TEAM}    True    True
    Go To Event Dashboard       ${event_campus_4}
    Check approval status and verify history change     Denied      ${CA_TEAM}      Approver: ${CA_TEAM}    True
    Go To Events Page
    Delete Campus Activity      ${event_campus_1}
    Delete Campus Activity      ${event_campus_4}
    Turn Approval Flow OFF      ${school_name}


Verify turn ON Event Planning Approval toggle AND a new Approval Flow is selected (OL-T5084)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    # Init data test
    ${approval_name}=       Set Variable    ${approval_03}_old
    ${school_name}=     Set Variable    ${school_02}
    Go To School Detail     ${school_name}
    Select Approval Flow    ${approval_name}
    Click At    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Go To Events Page
    ${event_campus_1}=      Create Campus Active Event      school_name=${school_name}
    ${event_campus_2}=      Create Campus Event With Status Approved By Multi Approver      ${school_name}      ${EE_TEAM}      ${EN_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_3}=      Create Campus Event With Status Pending By First Approver       ${school_name}
    # Create Campus Event with status Pending by second approver
    Switch To User      ${TEAM_USER}
    ${event_campus_4}=      Create Campus Event with status Approved by one approver    ${school_name}      ${EE_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_5}=      Create Campus Event with status Denied by second approver       ${school_name}      ${EE_TEAM}      ${EN_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_6}=      Create Campus Event with status Denied by first approver and resubmitted    ${school_name}      ${EE_TEAM}      ${TEAM_USER}
    # Change school approval flow
    Go To School Detail     ${school_name}
    Select approval flow    ${approval_03}_new
    Click At    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    # Check Event has Status was [Draft] previously
    Go To Event Dashboard       ${event_campus_1}
    Check approval status and verify history change     Draft       ${CA_TEAM}      Draft       True    True
    # Check Event has Status was [Approved] previously
    Go To Event Dashboard       ${event_campus_2}
    Check approval status and verify history change     Approved    ${EN_TEAM}      Approver: ${CA_TEAM}    True
    # Check Event has Status was [Pending by first approver] previously
    Go To Event Dashboard       ${event_campus_3}
    Check approval status and verify history change     Pending     ${CA_TEAM}      Approver: ${CA_TEAM}    True    True
    # Check Event has Status was [Denied or Pending by second approver] previously
    Go To Event Dashboard       ${event_campus_4}
    Check approval status and verify history change     Pending     ${CA_TEAM}      Approver: ${CA_TEAM}    True    True
    Go To Event Dashboard       ${event_campus_5}
    Check approval status and verify history change     Pending     ${CA_TEAM}      Approver: ${CA_TEAM}    True    True
    # Check Event has Status was [Denied and resubmit approval] previously
    Go To Event Dashboard       ${event_campus_6}
    Check approval status and verify history change     Pending     ${CA_TEAM}      Approver: ${CA_TEAM}    True    True
    # Remove test data
    Go To Events Page
    Delete Campus Activity      ${event_campus_1}


Check UI School Management when toggle Approval is OFF in Client Setup (OL-T5086)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to School Management Page
    Check event planning approval undisplay
    Go to CEM page
    Click setting icon on menu
    Check element not display on screen     ${MENU_SETTINGS_ITEM_LINK}      Approval Builder    wait_time=2s
    Capture page screenshot


Verify list user at Approver dropdown when no user has been selected (OL-T5075)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to approvals builder page
    Check list role displayed at Add Approver pulldown
    Check user in role when Add Approver    ${CA_TEAM}      ${CP_ADMIN}
    Click at    ${APPROVAL_BUILDER_USER_NAME}       ${CA_TEAM}
    Check user displays after user is chosen    ${CA_TEAM}      Approver One


Verify list user at Approver dropdown when having user has been selected (OL-T5076)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to approvals builder page
    Click at    ${APPROVAL_BUILDER_ADD_APPROVAL_FLOW_BUTTON}
    Add user approver       ${CA_TEAM}
    Add user approver       ${EE_TEAM}
    ${last_user}=       Format String       ${APPROVAL_BUILDER_LAST_USER}       ${EE_TEAM}      Approver Two
    Check Element Display On Screen     ${last_user}
    Check Element Display On Screen     ${APPROVAL_BUILDER_CHANGE_USER}     ${CA_TEAM}
    Check Element Display On Screen     ${APPROVAL_BUILDER_DELETE_USER}     ${CA_TEAM}
    Check Element Display On Screen     ${APPROVAL_BUILDER_CHANGE_USER}     ${EE_TEAM}
    Check Element Display On Screen     ${APPROVAL_BUILDER_DELETE_USER}     ${EE_TEAM}
    Capture page screenshot


Verify change Approval Flow when Flow was not assign to any school (OL-T5087)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Open Sub-Menu       ${approval_name}
    Click At    ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    Wait Until Page Contains Element    ${APPROVAL_BUILDER_MODAL}
    Verify Element Is Disable       ${APPROVAL_BUILDER_MODAL_SAVE_BUTTON}
    Verify Element Is Enable    ${APPROVAL_BUILDER_MODAL_CANCEL_BUTTON}
    Input into      ${APPROVAL_BUILDER_INPUT_APPROVAL_FLOW_NAME}    ${approval_name}+test
    Add User Approver       ${EN_TEAM}
    Click At    ${APPROVAL_BUILDER_MODAL_SAVE_BUTTON}
    Click At    ${APPROVAL_BUILDER_BUTTON_CONFIRM_EDIT}
    Check Text Display      ${approval_name}+test
    Delete Approval Flow    ${approval_name}+test


Verify delete Approval Flow when Flow was not assign to any school (OL-T5099)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    Open Sub-Menu       ${approval_name}
    Click At    ${APPROVAL_BUILDER_SUBMENU_DELETE}      ${approval_name}
    # Check dialog does not display after clicking button [Cancel]
    Wait Until Page Contains Element    ${APPROVAL_BUILDER_DELETE_DIALOG}
    Click At    ${APPROVAL_BUILDER_BUTTON_CANCEL_DELETE}
    Check Element Not Display On Screen     ${APPROVAL_BUILDER_DELETE_DIALOG}       wait_time=2s
    Capture Page Screenshot
    # Verify delete Approval Flow
    Delete Approval Flow    ${approval_name}


Empty stage in Approval Builder when have no Approval Flow (OL-T5042, OL-T5081)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Check approval builder in setting
    # Verify no approval flow in Approval Builder (OL-T5042)
    Check blank approval flow
    Check event planning approval when no have any flow
    # Verify at least 1 approval flow in Approval Builder (OL-T5081)
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}
    ${school_name}=     Create a new school     approval_name=${approval_name}
    Check event planning approval slide
    Check Element Display On Screen     ${ADD_NEW_SCHOOL_APPROVAL_FLOW_DROPDOWN_OPTIONS}    ${approval_name}
    Go to approvals builder page
    ${information_row}=     Format String       ${APPROVAL_BUILDER_A_SCHOOL_ASSIGNED_AVAILABLE_OF_ROW}      ${approval_name}    ${school_name}
    Check Element Display On Screen     ${information_row}
    Capture Page Screenshot
    Delete Approval Flow    ${approval_name}


Verify display at School Assigned when only specifics Schools are selected (OL-T5069, OL-T5070)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Verify Assigned school in Approval Flows (OL-T5069)
    Go to approvals builder page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    ${first_school_name}=       Create a new school     approval_name=${approval_name}
    Reload Page
    ${second_school_name}=      Create a new school     approval_name=${approval_name}
    Go to approvals builder page
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}      ${approval_name}
    ${combine_school_name}=     Catenate    SEPARATOR=,\ \      ${first_school_name}    ${second_school_name}
    ${school_assigned_number}=      Set Variable    2
    ${school_assigned_name}=    Format string       ${APPROVAL_BUILDER_SCHOOL_ASSIGNED_AVAILABLE_OF_ROW}    ${approval_name}    ${school_assigned_number}       ${combine_school_name}
    Check Element Display On Screen     ${school_assigned_name}
    Capture Page Screenshot
    # Verify the number of Assigned schools (OL-T5070)
    Click At    ${APPROVAL_BUILDER_SCHOOL_ASSIGNED_DROPDOWN}    2
    @{item_list} =      Create List     ${first_school_name}    ${second_school_name}
    ${school_number} =      Get Element Count       ${APPROVAL_BUILDER_SCHOOL_ASSIGNED_OPTIONS_DROPDOWN_ROW}
    Should Be Equal As Integers     ${school_number}    2
    FOR    ${element}   IN    @{item_list}
        Check Element Display On Screen     ${APPROVAL_BUILDER_SCHOOL_ASSIGNED_OPTIONS_DROPDOWN}    ${element}
    END
    Capture Page Screenshot


Verify turn OFF Event Planning Approval toggle when it was turned ON previously (OL-T5085)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to approvals builder page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    ${school_name}=     Create a new school     approval_name=${approval_name}
    Click at    ${school_name}
    Turn Off    ${ADD_NEW_SCHOOL_EVENT_PLANNING_APPROVAL_TOGGLE}
    ${is_changed} =     Run Keyword And Return Status       wait until element is visible       ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Check Element Display On Screen     ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Capture Page Screenshot
    IF    ${is_changed}
        Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    END
    Check Element Not Display On Screen     ${ADD_NEW_SCHOOL_APPROVAL_FLOW_DROPDOWN}    wait_time=2s
    Capture Page Screenshot
    Go To Events Page
    ${event_name}=      Create campus active event      ${EN_TEAM}      school_name=${school_name}
    Check Element Not Display On Screen     ${CAMPUS_VIEW_APPROVAL_FLOW_BUTTON}     wait_time=2s
    Check Element Not Display On Screen     ${CAMPUS_SUBMIT_APPROVAL_BUTTON}    wait_time=2s
    Capture Page Screenshot
    Check event deleted in Campus Approvals     event_name=${event_name}    need_checking_new_status=False
    Go To Approvals Builder Page
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}      ${approval_name}
    Check Element Display On Screen     ${APPROVAL_BUILDER_SCHOOL_EMPTY_ASSIGNED_OF_ROW}    ${approval_name}
    Capture Page Screenshot
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify Add User Approval Flow when User can view from School (OL-T5096)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Check data tests for aprroval       ${EE_TEAM}      ${approval_10}
    Go To Events Page
    ${event_name}=      Create campus active event      ${EN_TEAM}      school_name=${school_10}
    Switch To User      ${EN_TEAM}
    Check approval status when user is just only added in event     ${event_name}
    Switch To User      ${TEAM_USER}
    Add users in approval flow      ${approval_10}
    @{user_name} =      Create List     ${EE_TEAM}      ${EN_TEAM}
    Check approval status when user is added both event and approval flow       ${event_name}       ${user_name}
    Switch To User      ${TEAM_USER}
    Check event deleted in Campus Approvals     ${event_name}


Verify Changed Approval Flow when User can't view from School (OL-T5098)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Check data tests for aprroval       ${EE_TEAM}      ${approval_06}
    Check data tests for aprroval       ${EE_TEAM}      ${approval_07}
    Go To Events Page
    ${event_name}=      Create campus active event      ${EN_TEAM}      school_name=${school_06}
    Go To Events Page
    ${second_event_name}=       Create campus active event      ${EN_TEAM}      school_name=${school_07}
    Switch To User      ${FO_TEAM}
    Check details event and approval status when user is not added in both event and approval flow      ${event_name}
    Switch To User      ${TEAM_USER}
    Add users in approval flow      ${approval_06}      ${FO_TEAM}
    Add users in approval flow      ${approval_07}      ${FO_TEAM}
    @{user_name} =      Create List     ${EE_TEAM}      ${FO_TEAM}
    Check approval status when user is added both event and approval flow       ${event_name}       ${user_name}
    Switch To User      ${TEAM_USER}
    Delete user approver    ${FO_TEAM}      ${approval_06}
    Switch To User      ${FO_TEAM}
    Check details event and approval status when user is not added in both event and approval flow      ${event_name}
    Switch To User      ${TEAM_USER}
    @{user_name} =      Create List     ${EE_TEAM}      ${FO_TEAM}
    Check approval status when user is added both event and approval flow       ${second_event_name}    ${user_name}
    Switch To User      ${TEAM_USER}
    Check event deleted in Campus Approvals     ${second_event_name}
    Check event deleted in Campus Approvals     ${event_name}       True


Verify edit Approval Flow when Approver is user who created and submited approval (OL-T5272) (OL-T5089)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Check data tests for aprroval       ${EE_TEAM}      ${approval_11}
    Go to approvals builder page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    ${school_name}=     Create a new school     approval_name=${approval_name}
    Go To Events Page
    ${event_name}=      Create campus active event      ${EE_TEAM}      school_name=${school_name}
    # Check the number of school and event are affected by the approval builder (OL-T5089)
    ${is_added_event}=      Set Variable    False
    Check the number of event and school    ${approval_name}    is_added_event=${is_added_event}
    Check Element Not Display On Screen     ${APPROVAL_BUILDER_MODAL}       wait_time=2s
    Check Element Display On Screen     ${APPROVAL_BUILDER_HEADER_TEXT}     Approvals Builder
    Capture Page Screenshot
    @{list_user_01} =       Create List     ${EE_TEAM}      ${EN_TEAM}
    @{list_user_02}=    Create List     ${EN_TEAM}      ${EE_TEAM}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Draft    check_history=True
    # Check the order of user in approval flow when event has status [Draft] (OL-T5089) (OL-T5272)
    Check changes user position in approval flow    ${list_user_01}     ${approval_name}    ${list_user_02}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Draft    check_history=True
    # Check the order of user in approval flow when event has status [Denied and re-submit by first approver] (OL-T5089)
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_02}     Deny_by_firstuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Denied       check_history=True      status_history=Declined by EN Team      status_history_approver=Approver: EN Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_name}    ${list_user_01}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Denied       check_history=True      status_history=Declined by EN Team      status_history_approver=Approver: EN Team
    Check Text Display      Resubmit for Approval
    Capture Page Screenshot
    # Check the order of user in approval flow when event has Status [Pending by first approver] (OL-T5089)
    Click At    ${CAMPUS_SUBMIT_APPROVAL_BUTTON}
    Click At    ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_01}     Do_nothing_by_firstuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_01}     ${approval_name}    ${list_user_02}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EN Team
    # Check the order of user in approval flow when event has Status [Pending or denied not by first approver] (OL-T5089)
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_02}     Deny_by_lastuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Denied       check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_name}    ${list_user_01}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EN Team
    Check event deleted in Campus Approvals     ${event_name}       True
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}
    # Check the order of user in approval flow when event has Status [Approved] (OL-T5089)
    Add users in approval flow      ${approval_11}      ${EN_TEAM}
    Go To Events Page
    ${event_name_approve}=      Create campus active event      ${EE_TEAM}      school_name=${school_11}
    Check approval status when user is added both event and approval flow       ${event_name_approve}       ${list_user_01}     Approve
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name_approve}       ${list_user_01}     status=Approved     check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_01}     ${approval_11}      ${list_user_02}
    Check changes the order of approval flow in event       ${event_name_approve}       ${list_user_01}     status=Approved     check_history=True      status_history=Pending      status_history_approver=Approver: EE Team


Verify ONLY replace user at first approver in the approval flow order (OL-T5091)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Check data tests for aprroval       ${EE_TEAM}      ${approval_12}
    Go to approvals builder page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    ${school_name}=     Create a new school     approval_name=${approval_name}
    Go To Events Page
    ${event_name}=      Create campus active event      ${EE_TEAM}      school_name=${school_name}
    ${is_added_event}=      Set Variable    False
    Check the number of event and school    ${approval_name}    is_added_event=${is_added_event}
    Check Element Not Display On Screen     ${APPROVAL_BUILDER_MODAL}       wait_time=2s
    Check Element Display On Screen     ${APPROVAL_BUILDER_HEADER_TEXT}     Approvals Builder
    Capture Page Screenshot
    @{list_user_01} =       Create List     ${EE_TEAM}      ${EN_TEAM}
    @{list_user_02}=    Create List     ${FO_TEAM}      ${EN_TEAM}
    # Event has Status was [Draft] previously
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Draft    check_history=True
    Check changes user position in approval flow    ${list_user_01}     ${approval_name}    ${list_user_02}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Draft    check_history=True
    # Event has Status was [Denied by first approver] previously
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_02}     Deny_by_firstuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Denied       check_history=True      status_history=Declined by FO Team      status_history_approver=Approver: FO Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_name}    ${list_user_01}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Denied       check_history=True      status_history=Declined by FO Team      status_history_approver=Approver: FO Team
    Check Text Display      Resubmit for Approval
    Capture Page Screenshot
    # Event has Status was [Pending by first approver] previously
    Click At    ${CAMPUS_SUBMIT_APPROVAL_BUTTON}
    Click At    ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_01}     Do_nothing_by_firstuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_01}     ${approval_name}    ${list_user_02}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: FO Team
    # Event has Status was [Pending or denied not by first approver] previously
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_02}     Deny_by_lastuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Denied       check_history=True      status_history=Pending      status_history_approver=Approver: FO Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_name}    ${list_user_01}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check event deleted in Campus Approvals     ${event_name}       True
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}
    # Event has Status was [Approved] previously
    Add users in approval flow      ${approval_12}      ${EN_TEAM}
    Go To Events Page
    ${event_name_approve}=      Create campus active event      ${EE_TEAM}      school_name=${school_12}
    Check approval status when user is added both event and approval flow       ${event_name_approve}       ${list_user_01}     Approve
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name_approve}       ${list_user_01}     status=Approved     check_history=True      status_history=Pending      status_history_approver=Approver: EN Team
    Check changes user position in approval flow    ${list_user_01}     ${approval_12}      ${list_user_02}
    Check changes the order of approval flow in event       ${event_name_approve}       ${list_user_01}     status=Approved     check_history=True      status_history=Pending      status_history_approver=Approver: EN Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_12}      ${list_user_01}


Verify ONLY replace user at lasted approver in the approval flow order (OL-T5093)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Check data tests for aprroval       ${EE_TEAM}      ${approval_13}
    Go to approvals builder page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    ${school_name}=     Create a new school     approval_name=${approval_name}
    Go To Events Page
    ${event_name}=      Create campus active event      ${EE_TEAM}      school_name=${school_name}
    ${is_added_event}=      Set Variable    False
    Check the number of event and school    ${approval_name}    is_added_event=${is_added_event}    single_user=${FO_TEAM}
    Check Element Not Display On Screen     ${APPROVAL_BUILDER_MODAL}       wait_time=2s
    Check Element Display On Screen     ${APPROVAL_BUILDER_HEADER_TEXT}     Approvals Builder
    Capture Page Screenshot
    @{list_user_01} =       Create List     ${EE_TEAM}      ${FO_TEAM}
    @{list_user_02}=    Create List     ${EE_TEAM}      ${EN_TEAM}
    # Event has Status was [Draft] previously
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Draft    check_history=True
    Check changes user position in approval flow    ${list_user_01}     ${approval_name}    ${list_user_02}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Draft    check_history=True
    # Event has Status was [Denied by first approver] previously
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_02}     Deny_by_firstuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Denied       check_history=True      status_history=Declined by EE Team      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_name}    ${list_user_01}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Denied       check_history=True      status_history=Declined by EE Team      status_history_approver=Approver: EE Team
    Check Text Display      Resubmit for Approval
    Capture Page Screenshot
    # Event has Status was [Pending by first approver] previously
    Click At    ${CAMPUS_SUBMIT_APPROVAL_BUTTON}
    Click At    ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_01}     Do_nothing_by_firstuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_01}     ${approval_name}    ${list_user_02}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    # Event has Status was [Pending or denied by lasted approver] previously
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name}       ${list_user_02}     Deny_by_lastuser
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_02}     status=Denied       check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_name}    ${list_user_01}
    Check changes the order of approval flow in event       ${event_name}       ${list_user_01}     status=Pending      check_history=True      status_history=Pending      status_history_approver=Approver: EE Team
    Check event deleted in Campus Approvals     ${event_name}       True
    Delete a school     ${school_name}
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}
    # Event has Status was [Approved] previously
    Add users in approval flow      ${approval_13}      ${EN_TEAM}
    Go To Events Page
    ${event_name_approve}=      Create campus active event      ${EE_TEAM}      school_name=${school_13}
    Check approval status when user is added both event and approval flow       ${event_name_approve}       ${list_user_02}     Approve
    Switch To User      ${TEAM_USER}
    Check changes the order of approval flow in event       ${event_name_approve}       ${list_user_02}     status=Approved     check_history=True      status_history=Pending      status_history_approver=Approver: EN Team
    Check changes user position in approval flow    ${list_user_02}     ${approval_13}      ${list_user_01}
    Check changes the order of approval flow in event       ${event_name_approve}       ${list_user_02}     status=Approved     check_history=True      status_history=Pending      status_history_approver=Approver: EN Team


Verify if Event list will be shown when the removed approver has no permission to view Event and clicks on Approval Request ( via his contact) (OL-T5097)
    [Tags]      stg
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go To Events Page
    ${event_name_01}=       Create campus active event      ${EN_TEAM}      school_name=${school_08}
    Click At    ${CAMPUS_TURN_BACK_EVENT_ICON}
    ${event_name_02}=       Create campus active event      ${EN_TEAM}      school_name=${school_09}
    Check user added in Campus Approvals    ${CA_TEAM}
    Check approval status when user is added both event and approval flow       ${event_name_01}    ${CA_TEAM}      user_accept=Do_nothing_by_lastuser      is_checked_rank=False
    Verify user has received the email      subject=New Events are Pending Your Approval!       content=${event_name_01}
    Switch To User      ${TEAM_USER}
    Check changes user position in approval flow    ${CA_TEAM}      ${approval_08}      ${FULL_USER_AUTOMATION}
    Switch To User      ${CA_TEAM}
    Check details event and approval status when user is not added in both event and approval flow      ${event_name_01}
    Switch To User      ${TEAM_USER}
    Check approval status when user is added both event and approval flow       ${event_name_02}    ${CA_TEAM}      user_accept=Do_nothing_by_lastuser      is_checked_rank=False
    Switch To User      ${TEAM_USER}
    Check event deleted in Campus Approvals     ${event_name_02}
    Check event deleted in Campus Approvals     ${event_name_01}    True
    Check changes user position in approval flow    ${FULL_USER_AUTOMATION}     ${approval_08}      ${CA_TEAM}
    Check user deleted in Campus Approvals      ${CA_TEAM}


Verify Changed Approval Flow when User can view and approval Events (OL-T5095)
    [Tags]      stg
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go To Events Page
    ${event_name_01}=       Create campus active event      ${CA_TEAM}      school_name=${school_08}
    Click At    ${CAMPUS_TURN_BACK_EVENT_ICON}
    ${event_name_02}=       Create campus active event      ${CA_TEAM}      school_name=${school_09}
    Check user added in Campus Approvals    ${CA_TEAM}
    Check approval status when user is added both event and approval flow       ${event_name_01}    ${CA_TEAM}      user_accept=Do_nothing_by_lastuser      is_checked_rank=False
    Verify user has received the email      subject=New Events are Pending Your Approval!       content=${event_name_01}
    Switch To User      ${TEAM_USER}
    Check changes user position in approval flow    ${CA_TEAM}      ${approval_08}      ${FULL_USER_AUTOMATION}
    Switch To User      ${CA_TEAM}
    Go To Events Page
    Input Into      ${SEARCH_EVENT_INPUT}       ${event_name_01}
    Click At    ${UPCOMING_EVENT_NAME}      ${event_name_01}
    Check approval status when user is just only added in event     ${event_name_01}    status=Pending
    Switch To User      ${TEAM_USER}
    Check approval status when user is added both event and approval flow       ${event_name_02}    ${CA_TEAM}      user_accept=Do_nothing_by_lastuser      is_checked_rank=False
    Switch To User      ${TEAM_USER}
    Check event deleted in Campus Approvals     ${event_name_02}
    Check event deleted in Campus Approvals     ${event_name_01}    True
    Check changes user position in approval flow    ${FULL_USER_AUTOMATION}     ${approval_08}      ${CA_TEAM}
    Check user deleted in Campus Approvals      ${CA_TEAM}


Verify if the approver receives the Approval Request when ON Campus Approvals toggle in User's Alert management (OL-T5094)
    [Tags]      stg
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go To Events Page
    ${event_name_01}=       Create campus active event      ${EE_TEAM}      school_name=${school_08}
    Check user added in Campus Approvals    ${CA_TEAM}
    Check approval status when user is added both event and approval flow       ${event_name_01}    ${CA_TEAM}      user_accept=Do_nothing_by_lastuser      is_checked_rank=False
    Verify user has received the email      subject=New Events are Pending Your Approval!       content=${event_name_01}
    Switch To User      ${TEAM_USER}
    Check user deleted in Campus Approvals      ${CA_TEAM}
    Go To Events Page
    Input Into      ${SEARCH_EVENT_INPUT}       ${event_name_01}
    Click At    ${UPCOMING_EVENT_NAME}      ${event_name_01}
    Change approval status to draft
    Check approval status when user is added both event and approval flow       ${event_name_01}    ${CA_TEAM}      user_accept=Do_nothing_by_lastuser      is_checked_rank=False
    ${status} =     Run Keyword And Return Status       Verify User Has Received The Email      subject=New Events are Pending Your Approval!       content=${event_name_01}
    Should Be Equal As Strings      ${status}       False
    Switch To User      ${TEAM_USER}
    Check event deleted in Campus Approvals     ${event_name_01}


Verify ONLY replace user at middle approver in the approval flow order (OL-T5092)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    # Init data test
    ${approval_name}=       Set Variable    ${approval_05}
    ${school_name}=     Set Variable    ${school_04}
    Create Approval Flow With Given Name    ${approval_name}    ${EE_TEAM}
    Add Users In Approval Flow      ${approval_name}    ${CA_TEAM}      ${EN_TEAM}
    Create A New School     school_name=${school_name}      approval_name=${approval_name}      check_exist=True
    Go To Events Page
    ${event_campus_1}=      Create Campus Active Event      school_name=${school_name}
    ${event_campus_2}=      Create Campus Event With Status Approved By Multi Approver      ${school_name}      ${EE_TEAM}      ${CA_TEAM}      ${EN_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_3}=      Create Campus Event with status Pending by last approver    ${school_name}      ${EE_TEAM}      ${CA_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_4}=      Create Campus Event with status Denied by last approver     ${school_name}      ${EN_TEAM}      ${EE_TEAM}      ${CA_TEAM}
    # Create Campus Event with status Pending by second approver
    Switch To User      ${TEAM_USER}
    ${event_campus_5}=      Create Campus Event with status Approved by one approver    ${school_name}      ${EE_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_6}=      Create Campus Event with status Denied by second approver       ${school_name}      ${EE_TEAM}      ${CA_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_7}=      Create Campus Event with status Denied by first approver and resubmitted    ${school_name}      ${EE_TEAM}      ${TEAM_USER}
    Go To Edit Approval Flow    ${approval_name}
    Change Approver     ${CA_TEAM}      ${FO_TEAM}
    Click At    ${APPROVAL_BUILDER_MODAL_SAVE_BUTTON}
    Click At    ${APPROVAL_BUILDER_BUTTON_CONFIRM_EDIT}
    # Check Event has Status was [Draft] previously
    Go To Event Dashboard       ${event_campus_1}
    Check approval status and verify history change     Draft       ${FO_TEAM}      Draft       True    True
    # Check Event has Status was [Approved] previously
    Go To Event Dashboard       ${event_campus_2}
    Check approval status and verify history change     Approved    ${CA_TEAM}      Approved    True    True
    # Check Event has Status was [Denied or Pending by last approver] previously
    Go To Event Dashboard       ${event_campus_3}
    Check approval status and verify history change     Pending     ${FO_TEAM}      Approver: ${FO_TEAM}
    Go To Event Dashboard       ${event_campus_4}
    Check approval status and verify history change     Denied      ${FO_TEAM}      Approver: ${FO_TEAM}    True    True
    # Check Event has Status was [Denied or Pending by old approver] previously
    Go To Event Dashboard       ${event_campus_5}
    Check approval status and verify history change     Pending     ${FO_TEAM}      Approver: ${FO_TEAM}    True    True
    Go To Event Dashboard       ${event_campus_6}
    Check approval status and verify history change     Denied      ${FO_TEAM}      Approver: ${FO_TEAM}    True
    # Check Event has Status was [Denied and re-submite by first approver] previously
    Go To Event Dashboard       ${event_campus_7}
    Check approval status and verify history change     Pending     ${FO_TEAM}      Approver: ${FO_TEAM}    True
    # Remove test data
    Go To Events Page
    Delete Campus Activity      ${event_campus_1}
    Delete Campus Activity      ${event_campus_4}
    Delete Campus Activity      ${event_campus_6}


Verify add new users in the approval flow order (OL-T5088, OL-T5090, OL-T5100)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    # Init data test
    ${approval_name}=       Set Variable    ${approval_04}
    ${school_name}=     Set Variable    ${school_03}
    Create Approval Flow With Given Name    ${approval_name}    ${EE_TEAM}
    Create A New School     school_name=${school_name}      approval_name=${approval_name}      check_exist=True
    # Create Campus Event with status [Draft]
    Go To Events Page
    ${event_campus_1}=      Create campus active event      school_name=${school_name}
    ${event_campus_2}=      Create Campus Event with status Approved by one approver    ${school_name}      ${EE_TEAM}
    # Add approver to approval flow
    Switch To User      ${TEAM_USER}
    Go To Approvals Builder Page
    Add Users In Approval Flow      ${approval_name}
    ${event_campus_3}=      Create Campus Event with status Pending by first approver       ${school_name}
    ${event_campus_4}=      Create Campus Event with status Denied by first approver    ${school_name}      ${EE_TEAM}
    # Create Campus Event with status Pending by second approver
    Switch To User      ${TEAM_USER}
    ${event_campus_5}=      Create Campus Event with status Approved by one approver    ${school_name}      ${EE_TEAM}
    # Create Campus Event with status Denied by second approver
    Switch To User      ${TEAM_USER}
    ${event_campus_6}=      Create Campus Event with status Denied by second approver       ${school_name}      ${EE_TEAM}      ${EN_TEAM}
    Switch To User      ${TEAM_USER}
    ${event_campus_7}=      Create Campus Event with status Denied by first approver and resubmitted    ${school_name}      ${EE_TEAM}      ${TEAM_USER}
    # Add approver to approval flow and verify status
    Switch To User      ${TEAM_USER}
    Go To Approvals Builder Page
    Add Users In Approval Flow      ${approval_name}    single_user=${CA_TEAM}
    ${list_events}=     Create List     ${event_campus_1}       ${event_campus_2}       ${event_campus_3}       ${event_campus_4}       ${event_campus_5}       ${event_campus_6}
    Verify Campus Event when add new user to approval flow      @{list_events}
    # Verify delete a user in Approval Flow when assign to schools and events (OL-T5090)
    # Delete approver from approval flow and verify status
    Go To Edit Approval Flow    ${approval_name}
    Click At    ${APPROVAL_BUILDER_DELETE_USER}     ${CA_TEAM}
    Check Element Not Display On Screen     ${EN_TEAM}      wait_time=2s
    Capture Page Screenshot
    Click At    ${APPROVAL_BUILDER_MODAL_SAVE_BUTTON}
    Click At    ${APPROVAL_BUILDER_BUTTON_CONFIRM_EDIT}
    Verify Campus Event when delete approver from approval flow     ${event_campus_7}       @{list_events}
    # Verify delete Approval Flow when Flow was assign schools (OL-T5100)
    # Delete approval flow
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}
    # Verify the events didn't display History and Approval flow
    FOR     ${event_name}    IN  @{list_events}
        Go To Event Dashboard       ${event_name}
        Wait For Page Load Successfully V1
        Check Element Not Display On Screen     ${EVENT_ACTIVITY_DASHBOARD_VIEW_APPROVAL_FLOW_BUTTON}       wait_time=2s
        Capture Page Screenshot
    END
    Append To List      ${list_events}      ${event_campus_7}
    Go To Events Page
    FOR     ${event_name}    IN  @{list_events}
        Run Keyword If      "${event_name}" == "${list_events}[1]"      Continue For Loop
        Delete Campus Activity      ${event_name}
    END

*** Keywords ***
Check data tests for aprroval
    [Arguments]    ${user}          ${approval_name}
    Go To Approvals Builder Page
    Open Sub-Menu                          ${approval_name}
    Click At                               ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    ${user_name_list}=      Create List
    ${list_value} =    Get WebElements    ${APPROVAL_BUILDER_APPROVER_LIST}
    FOR    ${value}    IN    @{list_value}
        ${text}=     Get text and format text    ${value}
        Append To List    ${user_name_list}    ${text}
    END
    ${count_user} =    Get Element Count    ${APPROVAL_BUILDER_APPROVER_LIST}
    IF  '${count_user}' == '1'
        ${is_correct_user}=     Run Keyword And Return Status       Check Element Display On Screen        ${APPROVAL_BUILDER_DELETE_USER}      ${user}
        Capture Page Screenshot
        IF  ('${count_user}' == '1') and ('${is_correct_user}' == 'True')
            Click At        ${APPROVAL_BUILDER_MODAL_CANCEL_BUTTON}
        ELSE
            Click At                               ${APPROVAL_BUILDER_DELETE_USER}     ${user_name_list}
            Add user approver     ${user}
            Click At                               ${APPROVAL_BUILDER_SAVE_BUTTON}
            Click At                               ${APPROVAL_BUILDER_CONFIRM_ADD_APRROVER_BUTTON}
            Check Element Not Display On Screen    ${APPROVAL_BUILDER_MODAL}        wait_time=2s
            Capture page screenshot
        END
    ELSE
        FOR    ${user_deleted}    IN    @{user_name_list}
            IF    '${user_deleted}' != '${user}'
                Click At                               ${APPROVAL_BUILDER_DELETE_USER}     ${user_deleted}
            END
        END
        ${second_count_user} =    Get Element Count    ${APPROVAL_BUILDER_APPROVER_LIST}
        IF  '${second_count_user}' == '0'
            Add user approver     ${user}
        END
        Click At                               ${APPROVAL_BUILDER_SAVE_BUTTON}
        Click At                               ${APPROVAL_BUILDER_CONFIRM_ADD_APRROVER_BUTTON}
        Check Element Not Display On Screen    ${APPROVAL_BUILDER_MODAL}        wait_time=2s
        Capture page screenshot
    END

Check user added in Campus Approvals
    [Arguments]     ${user_name}
    Go To Alert Management Page
    Navigate To Option In Alert Management      Campus Approvals
    ${status}=      Run Keyword And Return Status    Check Element Display On Screen    ${ALERT_MANAGEMENT_USER_TEXT}         ${user_name}  wait_time=1s
    Capture Page Screenshot
    IF  '${status}' == 'False'
        Input into      ${ALERT_MANAGEMENT_INPUT_USERS_BUTTON}       ${user_name}
        Click At        ${ALERT_MANAGEMENT_USER_TEXT}            ${user_name}
        Click At        ${ALERT_MANAGEMENT_SAVE_BUTTON}
        Check Element Display On Screen    Your changes have been saved.
        Capture Page Screenshot
    END

Check user deleted in Campus Approvals
    [Arguments]    ${user_name}
    Go To Alert Management Page
    Navigate To Option In Alert Management      Campus Approvals
    ${status}=      Run Keyword And Return Status    Check Element Not Display On Screen    ${ALERT_MANAGEMENT_USER_TEXT}         ${user_name}       wait_time=2s
    Capture Page Screenshot
    IF  '${status}' == 'False'
        Click At        ${ALERT_MANAGEMENT_CLOSE_USER_BUTTON}        ${user_name}
        Click At        ${ALERT_MANAGEMENT_SAVE_BUTTON}
        Check Element Display On Screen    Your changes have been saved.
        Capture Page Screenshot
    END

Check event deleted in Campus Approvals
    [Arguments]         ${event_name}     ${need_searching}=False       ${need_checking_new_status}=True
    IF    '${need_searching}' != 'False'
        Go To Events Page
        Input Into                                      ${SEARCH_EVENT_INPUT}                   ${event_name}
        Click At                 ${UPCOMING_EVENT_HAS_NAME}              ${event_name}
    END
    IF    '${need_checking_new_status}' == 'True'
        Change approval status to draft
    END
    Click At                ${CAMPUS_SETTING_ICON}
    Click At                ${EVENT_ACTIVITY_UPCOMING_DELETE_BUTTON}
    Click At                ${CAMPUS_DELETE_CONFIRM_ACTIVITY_BUTTON}
    Go To Events Page
    Input Into                                      ${SEARCH_EVENT_INPUT}                   ${event_name}
    Check Element Not Display On Screen                                          ${UPCOMING_EVENT_HAS_NAME}              ${event_name}      wait_time=2s
    Capture Page Screenshot

Change approval status to draft
    Click At                    ${EVENT_ACTIVITY_DASHBOARD_REMOVE_APPROVAL_BUTTON}
    Click At                    ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
    Check Element Display On Screen                 ${CAMPUS_APPROVAL_STATUS}          Draft
    Capture Page Screenshot

Check status when user denied event
    [Arguments]     ${event_name}
    Click At          ${DENY_BUTTON}
    Click At          ${EVENT_ACTIVITY_DASHBOARD_CONFIRM_DENY_BUTTON}
    Check Element Display On Screen                 ${CAMPUS_APPROVAL_STATUS}          Denied
    Capture Page Screenshot

Check status when user approved event
    [Arguments]     ${status}       ${event_name}
    Check status approval and detail event when not accept approve    For your review    ${event_name}
    Click At       ${APPROVAL_BUTTON}
    Click At       ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
    Check status approval and detail event      ${status}    ${event_name}
    Capture Page Screenshot

Check changes the order of approval flow in event
    [Arguments]             ${event_name}           ${user_list}        ${status}       ${check_history}=False      ${status_history}=Draft     ${status_history_approver}=Moved to Draft
    Go To Events Page
    ${type} =   Evaluate    type($user_list).__name__
    Input Into              ${SEARCH_EVENT_INPUT}                           ${event_name}
    Click At                ${UPCOMING_EVENT_NAME}             ${event_name}
    Check Element Display On Screen                 ${CAMPUS_APPROVAL_STATUS}          ${status}
    Capture Page Screenshot
    Click At                ${CAMPUS_VIEW_APPROVAL_FLOW_BUTTON}
    ${first_user}=    Get From List  ${user_list}  0
    ${second_user}=    Get From List  ${user_list}  1
    ${position_first_user}=       Format String       ${CAMPUS_VIEW_APPROVAL_FLOW_USER_POSITION_TEXT}          ${first_user}      One
    Check Element Display On Screen    ${position_first_user}
    ${position_second_user}=       Format String       ${CAMPUS_VIEW_APPROVAL_FLOW_USER_POSITION_TEXT}         ${second_user}     Two
    Check Element Display On Screen    ${position_second_user}
    IF   '${check_history}' != 'False'
        Click At    ${EVENT_ACTIVITY_DASHBOARD_APPROVAL_FLOW_HISTORY_BUTTON}
        ${check_status_history}=    Format String       ${CAMPUS_VIEW_APPROVAL_HISTORY_STATUS_TITLE}        ${status_history}        ${status_history_approver}
        Check Element Display On Screen    ${check_status_history}
        Capture Page Screenshot
    END
    Click At                           ${CAMPUS_VIEW_APPROVAL_FLOW_CLOSE_MODAL_ICON}
    Capture Page Screenshot

Check approval status when user is added both event and approval flow
    [Arguments]             ${event_name}           ${user_list}            ${user_action}=Do_nothing_by_lastuser     ${is_checked_rank}=True
    Go To Events Page
    ${type} =   Evaluate    type($user_list).__name__
    Input Into              ${SEARCH_EVENT_INPUT}                           ${event_name}
    Click At                ${UPCOMING_EVENT_NAME}             ${event_name}
    Click At                ${CAMPUS_SUBMIT_APPROVAL_BUTTON}
    Click At                ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
    IF  '${is_checked_rank}' == 'True'
        Click At                ${CAMPUS_VIEW_APPROVAL_FLOW_BUTTON}
    END
    IF  '${type}' == 'list'
        ${first_user}=    Get From List  ${user_list}  0
        ${last_user}=     Get From List  ${user_list}  -1
        ${position_first_user}=       Format String       ${CAMPUS_VIEW_APPROVAL_FLOW_USER_POSITION_TEXT}         ${first_user}   One
        Check Element Display On Screen    ${position_first_user}
        Capture Page Screenshot
        ${count_user} =    Get length    ${type}
        IF      '${count_user}' != '1'
            ${second_user}=    Get From List  ${user_list}  1
            ${position_second_user}=       Format String       ${CAMPUS_VIEW_APPROVAL_FLOW_USER_POSITION_TEXT}        ${second_user}      Two
            Check Element Display On Screen    ${position_second_user}
            Capture Page Screenshot
        END
        Click At          ${CAMPUS_VIEW_APPROVAL_FLOW_CLOSE_MODAL_ICON}
        FOR     ${user}     IN      @{user_list}
            Switch To User          ${user}
            ${is_first_user} =  Run Keyword And Return Status       Should Be Equal As Strings    ${user}     ${first_user}
            ${is_last_user} =   Run Keyword And Return Status       Should Be Equal As Strings    ${user}     ${last_user}
            IF   '${user_action}' == 'Do_nothing_by_lastuser'
                ${result} =    evaluate    '''${user}''' != '''${last_user}'''
                IF   ${result}
                    Check status when user approved event      Pending    ${event_name}
                END
                Run Keyword If    ${is_last_user}       Check status approval and detail event when not accept approve    For your review    ${event_name}
            ELSE IF     '${user_action}' == 'Do_nothing_by_firstuser'
                Run Keyword If    ${is_first_user}      Check status approval and detail event when not accept approve      For your review    ${event_name}
            ELSE IF     '${user_action}' == 'Deny_by_firstuser'
                IF    ${is_first_user}
                    Check status approval and detail event when not accept approve    For your review    ${event_name}
                    Check status when user denied event          ${event_name}
                END
            ELSE IF     '${user_action}' == 'Deny_by_lastuser'
                IF    ${is_first_user}
                    Check status when user approved event      Pending    ${event_name}
                END
                IF      ${is_last_user}
                    Check status approval and detail event when not accept approve    For your review    ${event_name}
                    Check status when user denied event          ${event_name}
                END
            ELSE IF     '${user_action}' == 'Approve'
                Click At          ${APPROVAL_BUTTON}
                Click At          ${CAMPUS_CONFIRM_SEND_APPROVAL_BUTTON}
                Run Keyword If    ${is_first_user}      Check status approval and detail event      Pending    ${event_name}
                Run Keyword If    ${is_last_user}       Check status approval and detail event      Approved    ${event_name}
            END
        END
        Capture Page Screenshot
    ELSE
        Switch To User          ${user_list}
        IF   '${user_action}' == 'Do_nothing_by_lastuser'
            Check status approval and detail event when not accept approve    For your review    ${event_name}
        ELSE IF    '${user_action}' == 'Approve'
            Check status when user approved event      Approved    ${event_name}
        ELSE IF    '${user_action}' == 'Deny_by_firstuser'
            Check status when user denied event      ${event_name}
        END
    END
    Capture Page screenshot

Check changes user position in approval flow
    [Arguments]                 ${user_list}      ${approval_name}    ${new_user_list}
    Go To Approvals Builder Page
    ${type} =   Evaluate    type($user_list).__name__
    ${new_type} =   Evaluate    type($new_user_list).__name__
    Open Sub-Menu                          ${approval_name}
    Click At                               ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    IF  '${type}' == 'list' and '${new_type}' == 'list'
        FOR    ${user}   IN      @{user_list}
            Click At                               ${APPROVAL_BUILDER_DELETE_USER}     ${user}
        END
        FOR     ${item}     IN      @{new_user_list}
            Add user approver     ${item}
        END
    ELSE
        Click At                               ${APPROVAL_BUILDER_DELETE_USER}     ${user_list}
        Add user approver     ${new_user_list}
    END
    Click At                               ${APPROVAL_BUILDER_SAVE_BUTTON}
    Click At                               ${APPROVAL_BUILDER_CONFIRM_ADD_APRROVER_BUTTON}
    Check Element Not Display On Screen    ${APPROVAL_BUILDER_MODAL}        wait_time=2s
    Capture page screenshot

Check list role displayed at Add Approver pulldown
    Click at    ${APPROVAL_BUILDER_ADD_APPROVAL_FLOW_BUTTON}
    Click at    ${APPROVAL_BUILDER_ADD_APPROVER_BUTTON}
    @{list_role} =  Create list     Company Admin   Franchise Owner     Full User   Supervisor      Recruiter   Franchise Staff     Hiring Manager  Reporting User
    FOR  ${role}     IN      @{list_role}
         Check element display on screen     ${APPROVAL_BUILDER_APPROVER_ROLE}    ${role}
    END
    Check Element not Display On Screen    ${APPROVAL_BUILDER_APPROVER_ROLE}     ${BS_TEAM}     wait_time=2s
    Capture page screenshot

Check user in role when Add Approver
    [Arguments]     ${user}     ${role}
    Input into       ${APPROVAL_BUILDER_INPUT_SEARCH_USER_APPROVER}      ${user}
    Check element display on screen     ${APPROVAL_BUILDER_USER_NAME}     ${user}
    Check element Display On Screen    ${APPROVAL_BUILDER_APPROVER_ROLE}      ${role}
    Capture page screenshot

Check user displays after user is chosen
    [Arguments]    ${user}      ${rank}
    Check Element Display On Screen    ${APPROVAL_BUILDER_SEARCHED_USER_NAME}   ${user}
    Check Element Display On Screen    ${APPROVAL_BUILDER_SEARCHED_USER_NAME}   ${rank}
    Capture page screenshot

Check approval builder in setting
    Click setting icon on menu
    Check element display on screen             ${MENU_SETTINGS_ITEM_LINK}                      Approvals Builder
    Capture page Screenshot

Check event planning approval when no have any flow
    ${school_name} =    Create a new school
    Click at    ${school_name}
    Turn On     ${ADD_NEW_SCHOOL_EVENT_PLANNING_APPROVAL_TOGGLE}
    Click At    ${ADD_NEW_SCHOOL_APPROVAL_FLOW_DROPDOWN}
    ${school_number} =      Get Element Count       ${ADD_NEW_SCHOOL_APPROVAL_FLOW_DROPDOWN_OPTIONS}
    Should Be Equal As Integers                     ${school_number}        0
    Click At                                        ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Element should be disabled                      ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Turn Off    ${ADD_NEW_SCHOOL_EVENT_PLANNING_APPROVAL_TOGGLE}
    Capture Page Screenshot

Check event planning approval slide
    Click At                                        ${ADD_NEW_SCHOOL_APPROVAL_FLOW_VIEW_BUTTON}
    Element text should be                          ${ADD_NEW_SCHOOL_VIEW_APPROVAL_FLOW_TITLE}       Approval Flow
    Check Element Display On Screen                 ${ADD_NEW_SCHOOL_VIEW_APPROVAL_FLOW_USER_NAME}      ${EE_TEAM}
    Click At                                        ${ADD_NEW_SCHOOL_APPROVAL_FLOW_VIEW_CLOSE_BUTTON}
    Check Element Not Display On Screen             ${ADD_NEW_SCHOOL_VIEW_APPROVAL_VIEW_SLIDE}      wait_time=2s
    Capture Page Screenshot

Check blank approval flow
    Go to approvals builder page
    Check Element Display On Screen                 ${APPROVAL_BUILDER_NO_APPROVAL_MESSAGE_TEXT}         You have no approval flows.
    Check Element Display On Screen                 ${APPROVAL_BUILDER_NO_APPROVAL_MESSAGE_TEXT}         Add Approval Flow
    Capture page Screenshot

Verify Campus Event when add new user to approval flow
    [Arguments]    @{list_events}
    FOR     ${event_name}    IN  @{list_events}
        IF   "${event_name}" == "${list_events}[3]"
            Continue For Loop
        END
        Go To Event Dashboard                           ${event_name}
        Wait For Page Load Successfully V1
        IF  "${event_name}" == "${list_events}[0]"
            Check approval status and verify history change     Draft   ${CA_TEAM}  Submitted by    True
        ELSE IF  "${event_name}" == "${list_events}[1]"
            Check approval status and verify history change     Approved   ${CA_TEAM}  ${CA_TEAM}
        ELSE
            Check approval status and verify history change     Pending   ${CA_TEAM}  Approver: ${CA_TEAM}    True
        END
    END

Verify Campus Event when delete approver from approval flow
    [Arguments]    ${event_campus_last}    @{list_events}
    FOR     ${event_name}    IN  @{list_events}
        Run Keyword If          "${event_name}" == "${list_events}[3]" or "${event_name}" == "${list_events}[1]"                Continue For Loop
        Go To Event Dashboard                           ${event_name}
        Wait For Page Load Successfully V1
        IF  "${event_name}" == "${list_events}[0]"
            Check approval status and verify history change     Draft   ${CA_TEAM}  Submitted by
        ELSE
            Check approval status and verify history change     Pending   ${CA_TEAM}  Approver: ${CA_TEAM}
        END
    END
    Go To Event Dashboard                           ${event_campus_last}
    Wait For Page Load Successfully V1
    Check approval status and verify history change     Pending   ${CA_TEAM}  Approver: ${CA_TEAM}

Check approval status when user is just only added in event
    [Arguments]                                     ${event_name}       ${status}=Draft
    Check Element Display On Screen                 ${CAMPUS_EVENT_NAME}             ${event_name}
    Check Element Display On Screen                 ${CAMPUS_APPROVAL_STATUS}          ${status}
    Check Element Not Display On Screen             ${APPROVAL_BUTTON}      wait_time=2s
    Check Element Not Display On Screen             ${DENY_BUTTON}      wait_time=2s
    Capture Page Screenshot

Check details event and approval status when user is not added in both event and approval flow
    [Arguments]                                     ${event_name}
    Go To Events Page
    Input Into                                      ${SEARCH_EVENT_INPUT}                   ${event_name}
    Check Element Not Display On Screen             ${UPCOMING_EVENT_HAS_NAME}              ${event_name}       wait_time=2s
    Capture Page Screenshot

Check status approval and detail event when not accept approve
    [Arguments]         ${status}            ${event_name}
    Check Element Display On Screen                 ${CAMPUS_EVENT_NAME}             ${event_name}
    Check Element Display On Screen                 ${CAMPUS_APPROVAL_STATUS}          ${status}
    Check Element Display On Screen                 ${APPROVAL_BUTTON}
    Check Element Display On Screen                 ${DENY_BUTTON}
    Capture Page Screenshot

Check status approval and detail event
    [Arguments]      ${status}              ${event_name}
    Check Element Display On Screen                 ${CAMPUS_EVENT_NAME}             ${event_name}
    Check Element Display On Screen                 ${CAMPUS_APPROVAL_STATUS}          ${status}
    Check Element Not Display On Screen             ${APPROVAL_BUTTON}      wait_time=2s
    Check Element Not Display On Screen             ${DENY_BUTTON}          wait_time=2s
    Capture Page Screenshot

Check the number of event and school
    [Arguments]     ${approval_name}   @{user_list}    ${single_user}=${EN_TEAM}    ${is_added_event}=True
    Go to approvals builder page
    Open Sub-Menu                             ${approval_name}
    Click At                ${APPROVAL_BUILDER_SUBMENU_EDIT}                ${approval_name}
    Wait Until Element Is Visible                   ${APPROVAL_BUILDER_MODAL}
    IF  ${user_list}
        FOR     ${item}     IN      @{user_list}
            Add user approver     ${item}
        END
    ELSE
        Add user approver   ${single_user}
    END
    Click At                ${APPROVAL_BUILDER_MODAL_SAVE_BUTTON}
    IF   '${is_added_event}' != 'True'
        Check Element Display On Screen     ${APPROVAL_BUILDER_CONFIRM_ADD_APPROVER_POPUP}
        ${count_school_and_event}=      Format String     ${APPROVAL_BUILDER_CONFIRM_ADD_APPROVER_TEXT}  1     1
        Check Element Display On Screen     ${count_school_and_event}
        Capture Page Screenshot
    END
    Click At                ${APPROVAL_BUILDER_BUTTON_CONFIRM_EDIT}
