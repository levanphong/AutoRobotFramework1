*** Settings ***
Variables       ../../locators/client_setup_locators.py
Resource        ../../commons/common_keywords.robot

*** Keywords ***
Prepare Job External / Requisition Based Permission data tests for Suite
    Run Setup Only Once    Prepare Job External / Requisition Based Permission data tests

Prepare Job External / Requisition Based Permission data tests
    Open Chrome
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_COMMON}
    Enable Client Setup for Job External / Requisition Based Permission    More
    Enable Client Setup for Job External / Requisition Based Permission    Hire
    Add job requisition to user

Enable Client Setup for Job External / Requisition Based Permission
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'More'
        Click at    ${MORE_LABEL}
        Turn on    ${REQUISITION_BASED_PERMISSIONS_TOGGLE}
        Turn on    ${ADD_CANDIDATE_REQUISITION_TOGGLE}
    ELSE IF    '${item}' == 'Hire'
        Click at    ${HIRE_LABEL}
        Turn on    ${OLIVIA_HIRE_TOGGLE}
        Turn on    ${CANDIDATE_JOURNEYS_TOGGLE}
    END
    Run Keyword And ignore Error    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Turn off Requisition Based Permissions
    Navigate to    Client Setup
    Click at    ${MORE_LABEL}
    ${is_checked} =    Run Keyword And Return Status    Check element display on screen    ${REQUISITION_BASED_PERMISSIONS_CHECKED_TOGGLE}    wait_time=2s
    Run keyword if    ${is_checked}    Click at    ${REQUISITION_BASED_PERMISSIONS_TOGGLE}
    Run Keyword And ignore Error    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time

Add job requisition to user
    Switch to user    ${TEAM_USER}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Run Keyword and ignore Error    Click at    Assign job requisitions
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    Check the checkbox    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_1}
    Check the checkbox    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_2}
    Check the checkbox    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_3}
    Run Keyword and ignore Error    Click at    ${REQUISITIONS_SAVE_BUTTON}

Remove job requisition from user
    Switch to user    ${TEAM_USER}
    Go to Users page
    Click at    ${USER_NAME_IN_LIST}    ${user_with_requisition}
    Click at    ${EDIT_REQUISITIONS_BUTTON}
    Run Keyword and ignore Error    Click at    Assign job requisitions
    Run Keyword and ignore Error    Click at    ${JOB_REQUISITION_ASSIGNED_DROPDOWN}
    Click at    Show all requisitions
    UnCheck the checkbox    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_1}
    UnCheck the checkbox    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_2}
    UnCheck the checkbox    ${JOB_REQUISITION_CHECKBOX}    ${job_requisition_id_3}
    Run Keyword and ignore Error    Click at    ${REQUISITIONS_SAVE_BUTTON}

Turn on toggle Requisition Based Permission
    Navigate to    Client Setup
    Click at    ${MORE_LABEL}
    Turn on    ${REQUISITION_BASED_PERMISSIONS_TOGGLE}
    Run Keyword And ignore Error    Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    Wait with medium time
