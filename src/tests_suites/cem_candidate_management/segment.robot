*** Settings ***
Resource        ../../pages/all_candidates_page.robot
Resource        ../../drivers/driver_chrome.robot
Documentation       Run data test on /src/data_tests/cem_candidate_management/segment.robot file

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup      Open Chrome

Default Tags    test    regression

*** Variables ***
@{status}               Capture Complete    Capture Incomplete
@{OL_R991_Segment}      OL-R991 Segment_1    OL-R991 Segment_2    OL-R991 Segment_3

*** Test Cases ***
Check UI when creating a new Segment & Check if user is able to click on Cancel button - incase login as Paradox Admin, Check if the user can create segments for the admin - Hire ON, Check if the user can create segments for all users - Hire ON, Check if the user can click on [Delete] button - when Assign Segment "You & All User" (OL-T6647, OL-T6648, OL-T6649, OL-T6650, OL-T6661)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Show new Segment Model UI
    Click At    ${FILTER_ICON}
    Click At    ${FILTER_TYPE_STATUS}
    Check The Checkbox      ${FILTER_STATUS_CAPTURE_COMPLETE}
    Click At    ${FILTER_SAVE_SEGMENT_BUTTON}
    # Verify New Segment Model UI
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_POPUP}
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_TITLE}
    Check Element Display On Screen     ${SEGMENT_MODEL_NAME_LABEL}
    Check Element Display On Screen     ${SEGMENT_MODEL_NAME_INPUT}
    Check Element Display On Screen     ${SEGMENT_MODEL_HELP_TEXT}
    Check Element Display On Screen     ${SEGMENT_MODEL_ASSIGN_SEGMENT_LABEL}
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_DROPDOWN}
    Check Element Display On Screen     ${SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_SELF}     ${TEAM_USER}
    Check Element Display On Screen     ${SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_ALL}
    Check Element Display On Screen     ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}    Apply
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}    Cancel
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON}     Cancel
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON}     Save
    Capture Page Screenshot
    # Check user is able to clik on [Cancel] button
    ${segment_name} =       Generate random name only text      Segment
    Input Into      ${SEGMENT_MODEL_NAME_INPUT}     ${segment_name}
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_DROPDOWN}
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_ALL}
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}    Apply
    Click At    ${SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON}     Cancel
    Check Element Not Display On Screen     ${SEGMENT_NEW_MODEL_POPUP}
    Capture Page Screenshot
    # Create segments for the admin
    ${segment_name} =       Add a Candidate Segment     assign_segment_name=${TEAM_USER}    status=${status}    is_admin=True
    Delete a Candidate Segment      ${segment_name}
    # Create segments for all users
    ${segment_name} =       Add a Candidate Segment     status=${status}    is_admin=True
    # Check if the user can click on [Delete] button - when Assign Segment "You & All User"
    Click at    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click at    ${LEFT_MENU_MORE}
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    Verify UI when click ellipsis of segment for all as admin
    Click at    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Segment Setting
    Verify UI when show edit model segment all user as admin
    Click at    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Delete
    Click at    ${SEGMENT_EDIT_MODEL_DELETE_SEGMENT_DELETE_CANCEL}      Delete
    ${is_existed} =     Run Keyword And Return Status       Is Candidate Segment Existence      ${segment_name}
    Should Be Equal As Strings      ${is_existed}       False
    Capture Page Screenshot
    Switch to user      ${EE_TEAM}
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    ${is_existed} =     Run Keyword And Return Status       Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Should Be Equal As Strings      ${is_existed}       False
    Capture Page Screenshot


Check the Menu UI in case the segment was created - Hire ON - Incase login as Paradox Admin (OL-T6651)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    ${segment_name} =       Add a Candidate Segment     assign_segment_name=${TEAM_USER}    status=${status}    is_admin=True
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE ON
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Delete a Candidate Segment      ${segment_name}


Check the Menu UI in case the segment was created - Hire OFF - incase login as Paradox Admin (OL-T6652)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${segment_name} =       Add a Candidate Segment     assign_segment_name=${TEAM_USER}    status=${status}    is_admin=True
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE OFF
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Delete a Candidate Segment      ${segment_name}


Check UI in case user created more than 5 segments - Hire ON - Incase login as Paradox Admin (OL-T6653)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Create more than 5 segments
    @{segments_name} =      Create List
    FOR   ${_}  IN RANGE    6
        ${segment_name} =       Add a Candidate Segment     assign_segment_name=${TEAM_USER}    status=${status}    is_admin=True
        Append To List      ${segments_name}    ${segment_name}
    END
    Click At    ${LEFT_MENU_BUTTON}
    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE ON
    FOR   ${segment_name}   IN      @{segments_name}
        Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    END
    # There are five segments created & ellipses below All Candidates
    ${locator} =    Format String       ${LEFT_MENU_PATTERN_SEGMENT_BELOW_ALL_CANDIDATE}    ${EMPTY}
    ${amount_segment} =     Get Element Count       ${locator}
    Should Be Equal As Integers     ${amount_segment}       5
    Capture Page Screenshot
    # Delete more than 6 segments
    Go To CEM Page
    FOR   ${segment_name}   IN      @{segments_name}
        Delete a Candidate Segment      ${segment_name}
    END


Check UI in case user created more than 5 segments - Hire OFF - Incase login as Paradox Admin (OL-T6654)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    # Create more than 5 segments
    @{segments_name} =      Create List
    FOR   ${_}  IN RANGE    6
        ${segment_name} =       Add a Candidate Segment     assign_segment_name=${TEAM_USER}    status=${status}    is_admin=True
        Append To List      ${segments_name}    ${segment_name}
    END
    Click At    ${LEFT_MENU_BUTTON}
    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE OFF
    FOR   ${segment_name}   IN      @{segments_name}
        Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    END
    # There are five segments created & ellipses below All Candidates
    ${locator} =    Format String       ${LEFT_MENU_PATTERN_SEGMENT_BELOW_ALL_CANDIDATE}    ${EMPTY}
    ${amount_segment} =     Get Element Count       ${locator}
    Should Be Equal As Integers     ${amount_segment}       5
    Capture Page Screenshot
    # Delete more than 6 segments
    Go To CEM Page
    FOR   ${segment_name}   IN      @{segments_name}
        Delete a Candidate Segment      ${segment_name}
    END


Check the UI when clicking on the ellipsis & Check if the user can click on Set as Home option - incase login as Paradox Admin (OL-T6655, OL-T6656)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll To Element       ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Capture Page Screenshot
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Verify UI when click ellipsis of segment for all as admin
    # Set as Home
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Set as Home
    Check Element Display On Screen     ${MESSAGE_SEGMENT_SET_AS_SUCCESS}       ${OL_R991_Segment}[0]
    go to       ${base_url}
    Check Element Display On Screen     ${CEM_SEGMENT_TITLE}    ${OL_R991_Segment}[0]
    Capture Page Screenshot


Check if the user can click on Delete option - in case login as Paradox Admin (OL-T6657)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    ${segment_name} =       Add a Candidate Segment     status=${status}    is_admin=True
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    Verify UI when click ellipsis of segment for all as admin
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Delete
    Verify UI when show model delete segment
    Click At    ${LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON}       Delete
    ${is_existed} =     Run Keyword And Return Status       Is Candidate Segment Existence      ${segment_name}
    Should Be Equal As Strings      ${is_existed}       False
    #  Delete segment for all user
    Switch to user      ${CA_TEAM}
    Delete a Candidate Segment      ${segment_name}     True


Check if user is able to click on Cancel button - Incase login as Paradox Admin (OL-T6658)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll To Element       ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Capture Page Screenshot
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Verify UI when click ellipsis of segment for all as admin
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Delete
    Verify UI When Show Model Delete Segment
    Click At    ${LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON}       Cancel
    Check Element Not Display On Screen     ${LEFT_MENU_DELETE_SEGMENT_POPUP}


Check if the user able rename when click on Segment Setting option (OL-T6659)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll To Element       ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[2]
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[2]
    Capture Page Screenshot
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[2]
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[2]
    Verify UI when click ellipsis of segment for all as admin
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Segment Setting
    Verify UI when show edit model segment all user as admin
    # rename
    ${new_segment_name} =       Generate random name only text      Segment
    Input Into      ${SEGMENT_MODEL_NAME_INPUT}     ${new_segment_name}
    Click At    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Save
    Is Candidate Segment Existence      ${new_segment_name}
    # revert name
    ${locator} =    Format String       ${LEFT_MENU_PATTERN_SEGMENT}    ${new_segment_name}
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${new_segment_name}
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Segment Setting
    Input into      ${SEGMENT_MODEL_NAME_INPUT}     ${OL_R991_Segment}[2]
    Click At    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Save
    Is Candidate Segment Existence      ${OL_R991_Segment}[2]


Check if user rename is not unique (OL-T6660)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Capture Page Screenshot
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Verify UI when click ellipsis of segment for all as admin
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Segment Setting
    Verify UI when show edit model segment all user as admin
    # rename with already segment_name
    Input into      ${SEGMENT_MODEL_NAME_INPUT}     ${OL_R991_Segment}[1]
    Click At    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Save
    Check Element Display On Screen     ${SEGMENT_EDIT_MODEL_ALREADY_EXITS_MESSAGE}
    Capture Page Screenshot


Check UI if the user click on [Layout Segment] option - Incase login as Paradox Admin (OL-T6663)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click at    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click at    ${LEFT_MENU_MORE}
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${OL_R991_Segment}[0]
    Capture Page Screenshot
    Click at    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${OL_R991_Segment}[0]
    Click at    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Layout Setting
    Verify UI when click layout setting of segment as admin


Check UI when creating a new Segment - All User - Incase login as User, Check the Menu UI in case the segment was created - Hire ON - Incase login as User, Check the UI when clicking on the ellipsis - Incase login as User, Check if the user can click on "Set as Home" option incase login as User, Check UI if the user click on "Layout Segment" option - Incase login as User, Check if the user can click on [Delete] option - in case login as User (OL-T6667, OL-T6668, OL-T6672, OL-T6673, OL-T6674, OL-T6676)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${EE_TEAM}
    # Show new Segment Model UI
    Click At    ${FILTER_ICON}
    Click At    ${FILTER_TYPE_STATUS}
    Check The Checkbox      ${FILTER_STATUS_CAPTURE_COMPLETE}
    Click At    ${FILTER_SAVE_SEGMENT_BUTTON}
    # Verify New Segment Model UI
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_POPUP}
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_TITLE}
    Check Element Display On Screen     ${SEGMENT_MODEL_NAME_LABEL}
    Check Element Display On Screen     ${SEGMENT_MODEL_NAME_INPUT}
    Check Element Display On Screen     ${SEGMENT_MODEL_HELP_TEXT}
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON}     Cancel
    Check Element Display On Screen     ${SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON}     Save
    Capture Page Screenshot
    # Check the Menu UI in case the segment was created
    ${segment_name} =       Add a Candidate Segment     status=${status}    is_admin=False
    Is Candidate Segment Existence      ${segment_name}
    Verify UI Left Menu HIRE ON
    # Check the UI when clicking on the ellipsis
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    verify UI when click ellipsis of segment as user
    # Set as Home
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Set as Home
    Check Element Display On Screen     ${MESSAGE_SEGMENT_SET_AS_SUCCESS}       ${segment_name}
    # Go To base_url
    go to       ${base_url}
    Check Element Display On Screen     ${CEM_SEGMENT_TITLE}    ${segment_name}
    Capture Page Screenshot
    # Layout Segment
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Click at    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    Click at    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Layout Setting
    Verify UI when click layout setting of segment as user
    # Delete Segment
    Go To CEM Page
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Scroll to element       ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${segment_name}
    Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}       Delete
    Verify UI when show model delete segment
    Click At    ${LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON}       Delete


Check the Menu UI in case the segment was created - Hire OFF - Incase login as User (OL-T6669)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch to user      ${EE_TEAM}
    ${segment_name} =       Add a Candidate Segment     status=${status}    is_admin=False
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE OFF
    Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    Capture Page Screenshot
    Delete a Candidate Segment      ${segment_name}


Check UI in case user created more than 5 segments - Hire ON - incase login as User (OL-T6670)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${EE_TEAM}
    # Create more than 5 segments
    @{segments_name} =      Create List
    FOR   ${_}  IN RANGE    6
        ${segment_name} =       Add a Candidate Segment     status=${status}    is_admin=False
        Append To List      ${segments_name}    ${segment_name}
    END
    Click At    ${LEFT_MENU_BUTTON}
    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE ON
    FOR   ${segment_name}   IN      @{segments_name}
        Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    END
    # There are five segments created & ellipses below All Candidates
    ${locator} =    Format String       ${LEFT_MENU_PATTERN_SEGMENT_BELOW_ALL_CANDIDATE}    ${EMPTY}
    ${amount_segment} =     Get Element Count       ${locator}
    Should Be Equal As Integers     ${amount_segment}       5
    Capture Page Screenshot
    # Delete more than 6 segments
    Go To CEM Page
    FOR   ${segment_name}   IN      @{segments_name}
        Delete a Candidate Segment      ${segment_name}
    END


Check UI in case user created more than 5 segments - Hire OFF - incase login as User (OL-T6671)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch to user      ${EE_TEAM}
    # Create more than 5 segments
    @{segments_name} =      Create List
    FOR   ${_}  IN RANGE    6
        ${segment_name} =       Add a Candidate Segment     status=${status}    is_admin=False
        Append To List      ${segments_name}    ${segment_name}
    END
    Click At    ${LEFT_MENU_BUTTON}
    Click At    ${LEFT_MENU_MORE}
    Verify UI Left Menu HIRE OFF
    FOR   ${segment_name}   IN      @{segments_name}
        Check Element Display On Screen     ${LEFT_MENU_PATTERN_SEGMENT}    ${segment_name}
    END
    # There are five segments created & ellipses below All Candidates
    ${locator} =    Format String       ${LEFT_MENU_PATTERN_SEGMENT_BELOW_ALL_CANDIDATE}    ${EMPTY}
    ${amount_segment} =     Get Element Count       ${locator}
    Should Be Equal As Integers     ${amount_segment}       5
    Capture Page Screenshot
    # Delete more than 6 segments
    Go To CEM Page
    FOR   ${segment_name}   IN      @{segments_name}
        Delete a Candidate Segment      ${segment_name}
    END

*** Keywords ***
Verify UI Left Menu HIRE ON
    Check Element Display On Screen    ${LEFT_MENU_ALL_CANDIDATE}
    Check Element Display On Screen    ${LEFT_MENU_VIEW_BY_STAGE}
    Check Element Display On Screen    ${LEFT_MENU_VIEW_BY_LOCATION}
    Check Element Display On Screen    ${LEFT_MENU_VIEW_BY_JOB}
    Capture Page Screenshot

Verify UI Left Menu HIRE OFF
    Check Element Display On Screen    ${LEFT_MENU_ALL_CANDIDATE}
    Check Element Display On Screen    ${LEFT_MENU_PATTERN_SEGMENT}    Liked
    Check Element Display On Screen    ${LEFT_MENU_PATTERN_SEGMENT}    Archived
    Check Element Display On Screen    ${LEFT_MENU_INCOMPLETE}
    Capture Page Screenshot

Verify UI when click ellipsis of segment for all as admin
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}     For You
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}     For All
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}    Set as Home
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}    Segment Setting
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}    Layout Setting
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}     Delete
    Capture Page Screenshot

Verify UI when click layout setting of segment as admin
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_TITLE}
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_TAB_FOR_YOU_BUTTON}
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_TAB_FOR_ALL_BUTTON}
    Check element display on screen     Set as home and drag and drop to reorder.
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_PATTERN_ITEM}    Action Needed
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_PATTERN_ITEM}    All Candidates
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_DELETE_SAVE_CANCEL}    Save
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_DELETE_SAVE_CANCEL}    Cancel
    Capture Page Screenshot

Verify UI when click layout setting of segment as user
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_TITLE}
    Check element display on screen     Set as home and drag and drop to reorder.
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_CANDIDATE_SECTION_TITLE}
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_PATTERN_ITEM}    Action Needed
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_PATTERN_ITEM}    All Candidates
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_DELETE_SAVE_CANCEL}    Save
    Check element display on screen    ${SEGMENT_LAYOUT_SETTING_DELETE_SAVE_CANCEL}    Cancel
    Capture Page Screenshot

verify UI when click ellipsis of segment as user
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}    Set as Home
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}    Layout Setting
    Check Element Display On Screen                 ${LEFT_MENU_SEGMENT_TOOL_PATTERN}     Delete
    Capture Page Screenshot

Verify UI when show model delete segment
    Check Element Display On Screen    ${LEFT_MENU_DELETE_SEGMENT_POPUP}
    Check Element Display On Screen    ${LEFT_MENU_DELETE_SEGMENT_POPUP_TITLE}
    Check Element Display On Screen    ${LEFT_MENU_DELETE_SEGMENT_POPUP_MESSAGE}
    Check Element Display On Screen    ${LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON}       Delete
    Check Element Display On Screen    ${LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON}       Cancel
    Capture Page Screenshot

Verify UI when show edit model segment all user as admin
    Check Element Display On Screen    ${SEGMENT_EDIT_MODEL_POPUP}
    Check Element Display On Screen    ${SEGMENT_EDIT_MODEL_POPUP}
    Check Element Display On Screen    ${SEGMENT_EDIT_MODEL_DESCRIPTION}
    Check Element Display On Screen    ${SEGMENT_MODEL_NAME_LABEL}
    Check Element Display On Screen    ${SEGMENT_MODEL_NAME_INPUT}
    Check Element Display On Screen    ${SEGMENT_MODEL_HELP_TEXT}
    Check Element Display On Screen    ${SEGMENT_MODEL_ASSIGN_SEGMENT_LABEL}
    Check Element Display On Screen    ${SEGMENT_MODEL_ASSIGN_SEGMENT_DROPDOWN}
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_DROPDOWN}
    Check Element Display On Screen    ${SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_ALL}
    Check Element Display On Screen    ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}    Apply
    Check Element Display On Screen    ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}    Cancel
    Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}   Cancel
    Check Element Display On Screen    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Delete
    Check Element Display On Screen    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Cancel
    Check Element Display On Screen    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}     Save
