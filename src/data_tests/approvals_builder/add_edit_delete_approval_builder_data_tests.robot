*** Settings ***
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../pages/school_management_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    stg    test

*** Variables ***
${approval_03}      approval_event_status_new_approval
${school_02}        school_event_status_new_approval
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
${approval_14}      approval_verify_user_take_action_to_event
${school_14}        school_verify_user_take_action_to_event

*** Test Cases ***
Prepare test data for test case OL-T5084
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create Approval Flow With Given Name    ${approval_03}_old      ${EE_TEAM}
    Add Users In Approval Flow      ${approval_03}_old      ${EN_TEAM}
    Create Approval Flow With Given Name    ${approval_03}_new      ${CA_TEAM}
    Create A New School     school_name=${school_02}    approval_name=${approval_03}_new    check_exist=True


Prepare test data for test case check if user can view detail event and accept approval
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create Approval Flow With Given Name    ${approval_06}      ${EE_TEAM}
    Create Approval Flow With Given Name    ${approval_07}      ${EE_TEAM}
    Create Approval Flow With Given Name    ${approval_10}      ${EE_TEAM}
    Create Approval Flow With Given Name    ${approval_11}      ${EE_TEAM}
    Create Approval Flow With Given Name    ${approval_12}      ${EE_TEAM}
    Create Approval Flow With Given Name    ${approval_13}      ${EE_TEAM}
    Create a new school     school_name=${school_06}    approval_name=${approval_06}    check_exist=True
    Reload Page
    Create a new school     school_name=${school_07}    approval_name=${approval_07}    check_exist=True
    Reload Page
    Create a new school     school_name=${school_10}    approval_name=${approval_10}    check_exist=True
    Reload Page
    Create a new school     school_name=${school_11}    approval_name=${approval_11}    check_exist=True
    Reload Page
    Create a new school     school_name=${school_12}    approval_name=${approval_12}    check_exist=True
    Reload Page
    Create a new school     school_name=${school_13}    approval_name=${approval_13}    check_exist=True


Prepare test data for test case check if user can receive email
    [Tags]      stg
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Create Approval Flow With Given Name    ${approval_08}      ${CA_TEAM}
    Create Approval Flow With Given Name    ${approval_09}      ${CA_TEAM}
    Create a new school     school_name=${school_08}    approval_name=${approval_08}    check_exist=True
    Reload Page
    Create a new school     school_name=${school_09}    approval_name=${approval_09}    check_exist=True


Prepare test data for test case verify user can approve/deny/send for approval to some selected events
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Approvals Builder Page
    ${approval_name}=       Add Approval Flow       ${EE_TEAM}      ${approval_14}
    Add users in approval flow      ${approval_name}    single_user=${CA_TEAM}
    ${school_name}=     Create A New School     school_name=${school_14}    school_user_name=${EE_TEAM}
    Select approval flow    ${approval_name}
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
