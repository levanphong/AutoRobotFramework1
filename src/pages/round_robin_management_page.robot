*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/round_robin_management_locators.py

*** Keywords ***
Add users to round robin
    [Arguments]     ${user_name}
    Click at    ${ADD_USERS_TEXTBOX}
    wait with short time
    Click at    ${ADD_USERS_BUTTON}     ${user_name}

Add a new Round Robin
    [Arguments]   ${round_robin_name}=None   ${list_users}=None
    go to Round Robin Management page
    IF  '${round_robin_name}' == 'None'
        ${round_robin_name} =   Generate random name  auto_round_robin
    END
    Input into    ${ADD_NEW_ROUND_ROBIN_GROUP_TEXTBOX}      ${round_robin_name}
    Click at     ${ADD_NEW_RR_BUTTON}
    ${is_external_id_exist} =   Run keyword and return status   Check element display on screen  ${EXTERNAL_ID_RR_TEXTBOX}
    ${external_id}=       generate random string      5       [NUMBERS]
    Run keyword if     '${is_external_id_exist}' == 'True'  Input into      ${EXTERNAL_ID_RR_TEXTBOX}      ${external_id}
    IF  ${list_users} != None
        FOR     ${value}    IN      @{list_users}
                Add users to round robin        ${value}
        END
        Click at    ${EDIT_ROUND_ROBIN_FORM_ROUND_ROBIN_NAME_TEXT_BOX}
    ELSE
        Click at    ${ADD_USERS_TEXTBOX}
        Click at    ${ADD_USERS_BUTTON}     ${EMPTY}
        Click at    ${EDIT_ROUND_ROBIN_FORM_ROUND_ROBIN_NAME_TEXT_BOX}
    END
    Click at    ${SAVE_RR_BUTTON}
    [Return]    ${round_robin_name}

Delete a Round Robin
    [Arguments]   ${round_robin_name}
    Click at  ${round_robin_name}
    Click at  ${EDIT_ROUND_ROBIN_FORM_REMOVE_BUTTON}
    Click at  ${CONFIRM_DELETE_ROUND_ROBIN_YES_BUTTON}
    Check element not display on screen  ${round_robin_name}
