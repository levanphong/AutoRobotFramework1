*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${location_name1}                                           Da Nang
${location_name2}                                           Location_schedule
${location_name3}                                           New York
&{dic_users_company_envent}                                 user1=OL-R1240 User1    user2=OL-R1240 User2    user3=OL-R1240 User3    user4=OL-R1240 User4
&{dic_users_company_schedule_base_candidate_time_zone}      user1=OL-R1240 User1    user2=OL-R1240 User2
&{dic_users_company_hire_off}                               user1=OL-R1240 User1    user2=OL-R1240 User2
# OL-R1240 User4 OF COMPANY EVENT: Set manual availability time is all: from monday to sunday, full hours

*** Test Cases ***
Prepare data test for User sends interview request via CEM
    Given Setup test
    When Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    FOR    ${key}    IN    @{dic_users_company_envent}
        Go to Users, Roles, Permissions page
        ${is_existence} =       Is User Existence On Active     ${dic_users_company_envent}[${key}]
        IF  ${is_existence} == False
            ${fname&lastname} =     Split String    ${dic_users_company_envent}[${key}]     ${SPACE}
            Add A User      ${fname&lastname}[0]    ${fname&lastname}[1]    role=${CP_ADMIN}
            Input into      ${SEARCH_USER_TEXT_BOX}     ${dic_users_company_envent}[${key}]
            Check element display on screen     ${dic_users_company_envent}[${key}]
        END
        Run Keyword If      ('${dic_users_company_hire_off}[${key}]' == 'OL-R1240 User1') or ('${dic_users_company_hire_off}[${key}]' == 'OL-R1240 User2')
        ...     Active one group interview OIT of user      ${dic_users_company_hire_off}[${key}]
        ...     ELSE IF     ${dic_users_company_hire_off}[${key}] == OL-R1240 User3
        ...     Delete OIT of user      ${dic_users_company_hire_off}[${key}]
        ...     ELSE
        ...     Log To Console      Set manual availability time of ${dic_users_company_hire_off}[${key}] is all: from monday to sunday, full hours
        Go To Location Management Page
        Assign user to location     ${location_name1}       ${dic_users_company_envent}[${key}]
    END
    Go to Client setup page
    Turn on/off Allow user choose interview time in Client Setup    Off
    Turn on/off Advanced Setting in Client Setup    On
    Turn on Interview Prep

    Switch to Company v1    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}
    FOR    ${key}    IN    @{dic_users_company_schedule_base_candidate_time_zone}
        Go to Users, Roles, Permissions page
        ${is_existence} =       Is User Existence On Active     ${dic_users_company_schedule_base_candidate_time_zone}[${key}]
        IF  ${is_existence} == False
            ${fname&lastname} =     Split String    ${dic_users_company_schedule_base_candidate_time_zone}[${key}]      ${SPACE}
            Add A User      ${fname&lastname}[0]    ${fname&lastname}[1]    role=${CP_ADMIN}
            Input into      ${SEARCH_USER_TEXT_BOX}     ${dic_users_company_schedule_base_candidate_time_zone}[${key}]
            Check element display on screen     ${dic_users_company_schedule_base_candidate_time_zone}[${key}]
        END
        Active one group interview OIT of user      ${dic_users_company_schedule_base_candidate_time_zone}[${key}]
        Go To Location Management Page
        Assign user to location     ${location_name2}       ${dic_users_company_schedule_base_candidate_time_zone}[${key}]
    END
    Go to Client setup page
    Turn on/off Allow user choose interview time in Client Setup    On
    Turn on/off Advanced Setting in Client Setup    On

    Switch to Company v1    ${COMPANY_HIRE_OFF}
    FOR    ${key}    IN    @{dic_users_company_hire_off}
        Go to Users, Roles, Permissions page
        ${is_existence} =       Is User Existence On Active     ${dic_users_company_hire_off}[${key}]
        IF  ${is_existence} == False
            ${fname&lastname} =     Split String    ${dic_users_company_hire_off}[${key}]       ${SPACE}
            Add A User      ${fname&lastname}[0]    ${fname&lastname}[1]    role=${CP_ADMIN}
            Input into      ${SEARCH_USER_TEXT_BOX}     ${dic_users_company_hire_off}[${key}]
            Check element display on screen     ${dic_users_company_hire_off}[${key}]
        END
        Active one group interview OIT of user      ${dic_users_company_hire_off}[${key}]
        Go To Location Management Page
        Assign user to location     ${location_name3}       ${dic_users_company_hire_off}[${key}]
    END
    Go to Client setup page
    Turn on/off Allow user choose interview time in Client Setup    On
    Turn on/off Advanced Setting in Client Setup    Off
