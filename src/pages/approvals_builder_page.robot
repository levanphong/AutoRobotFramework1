*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/approvals_builder_locators.py
Resource        ../pages/school_management_page.robot
Variables       ../locators/client_setup_locators.py
Variables       ../locators/campus_locators.py

*** Keywords ***
Add approval flow
    [Arguments]     ${user}     ${approval_name}=None
    IF  '${approval_name}' == 'None'
        ${approval_name}=       Generate random name    auto_approval
    END
    Click at    ${APPROVAL_BUILDER_ADD_APPROVAL_FLOW_BUTTON}
    Input into      ${APPROVAL_BUILDER_INPUT_APPROVAL_FLOW_NAME}     ${approval_name}
    Add user approver   ${user}
    Click at    ${APPROVAL_BUILDER_CREATE_APPROVAL_FLOW_BUTTON}
    [Return]    ${approval_name}

Add user approver
    [Arguments]     ${user}
    Click at    ${APPROVAL_BUILDER_ADD_APPROVER_BUTTON}
    Input into  ${APPROVAL_BUILDER_INPUT_SEARCH_USER_APPROVER}      ${user}
    Click at    ${APPROVAL_BUILDER_USER_NAME}    ${user}

Change approver
    [Arguments]     ${current_user}     ${target_user}
    Click at    ${APPROVAL_BUILDER_CHANGE_USER}     ${current_user}
    Simulate input  ${APPROVAL_BUILDER_APPROVER_ITEM_INPUT_SEARCH}      ${target_user}      ${current_user}
    Click at    ${APPROVAL_BUILDER_USER_NAME}   ${target_user}

Delete user approver
    [Arguments]    ${user}          ${approval_name}
    Go To Approvals Builder Page
    Open Sub-Menu                          ${approval_name}
    Click At                               ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    Click At                               ${APPROVAL_BUILDER_DELETE_USER}     ${user}
    Click At                               ${APPROVAL_BUILDER_SAVE_BUTTON}
    Click At                               ${APPROVAL_BUILDER_CONFIRM_ADD_APRROVER_BUTTON}
    Check Element Not Display On Screen    ${APPROVAL_BUILDER_MODAL}        wait_time=2s
    Capture page screenshot

Delete Approval Flow
    [Arguments]     ${approval_name}
    Open Sub-Menu     ${approval_name}
    Click At    ${APPROVAL_BUILDER_SUBMENU_DELETE}  ${approval_name}
    Click At    ${APPROVAL_BUILDER_BUTTON_CONFIRM_DELETE}
    Check Element Not Display On Screen    ${approval_name}     wait_time=2s
    Capture Page Screenshot

Open Sub-Menu
    [Arguments]    ${approval_name}
    Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}    ${approval_name}
    Click At    ${APPROVAL_BUILDER_ROW_ELIPSIS}     ${approval_name}

Check UI when turn on event planning approval toggle
    Turn on     ${EVENT_PLANING_APPROVAL_TOGGLE}
    Check label display  Select an approval flow
    Check element display on screen  ${INPUT_SELECT_APPROVAL_FLOW}
    Check element display on screen  ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Capture page screenshot

Check event planning approval undisplay
    Hover at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}    Add a School
    Click at    ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_TEXTBOX}
    click at    ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}
    Check element not display on screen     ${EVENT_PLANING_APPROVAL_TOGGLE}        wait_time=2s
    Capture page screenshot

Add users in approval flow
    [Arguments]     ${approval_name}   @{user_list}    ${single_user}=${EN_TEAM}
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
    Click At                ${APPROVAL_BUILDER_BUTTON_CONFIRM_EDIT}

Create Approval Flow With Given Name
    [Arguments]    ${approval_name}     ${user}
    Go To Approvals Builder Page
    ${has_search_textbox}=  Run Keyword And Return Status    Check Element Display On Screen    ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}    wait_time=1s
    IF  "${has_search_textbox}" == "True"
        Input Into      ${APPROVAL_BUILDER_INPUT_SEARCH_APPROVAL_FLOW}    ${approval_name}
        ${is_exist}=    Run Keyword And Return Status    Check Element Display On Screen        ${approval_name}    wait_time=1s
        Capture Page Screenshot
        IF  "${is_exist}" == "True"
            Delete Approval Flow    ${approval_name}
        END
    END
    Add Approval Flow   ${user}    ${approval_name}

Go To Edit Approval Flow
    [Arguments]    ${approval_name}
    Go To Approvals Builder Page
    Open Sub-Menu       ${approval_name}
    Click At    ${APPROVAL_BUILDER_SUBMENU_EDIT}    ${approval_name}
    Wait Until Element Is Visible       ${APPROVAL_BUILDER_MODAL}
