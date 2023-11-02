*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/my_calendar_locators.py

*** Keywords ***
Select time for user
    [Arguments]     ${start_time}       ${end_time}
    go to My Calendar page
    Click at    ${ICON_MOVE_NEXT_WEEK_LOCATOR}
    Click at    ${SELECT_TIME_LOCATOR}
    Click at    ${START_HOUR_DROPDOWN}
    wait with short time
    select from list by label  ${START_HOUR_DROPDOWN}  ${start_time}
    Click at    ${END_HOUR_DROPDOWN}
    wait with short time
    select from list by label  ${END_HOUR_DROPDOWN}  ${end_time}
    wait with short time
    Click at    ${SAVE_CALENDAR_BUTTON}

Delete all times selected
    ${is_existed}=  Run Keyword And Return Status     Check element display on screen     ${ALL_TIME_SELECTED_LOCATOR}
    IF  '${is_existed}' == 'True'
        wait until page contains element   ${ALL_TIME_SELECTED_LOCATOR}  10s
        ${count}=  convert to integer  1
        ${list_time_selected_elements}=   Get WebElements     ${ALL_TIME_SELECTED_LOCATOR}
        FOR     ${element}   IN     @{list_time_selected_elements}
            ${clicked_slot_time}=  run keyword and return status   click element    ${element}
            IF  '${clicked_slot_time}' == 'False'
                click at   ${ALL_TIME_SELECTED_LOCATOR_BY_INDEX}  ${count}
            END
            Click at    ${DELETE_TIME_BUTTON}
            wait with medium time
        END
        Click at    ${SAVE_CALENDAR_BUTTON}
    ELSE
        go to My Calendar page
    END

Clear user calendar
    [Arguments]     ${user_name}
    go to CEM page
    switch to user      ${user_name}
    go to My Calendar page
    Delete all times selected
    Click at    ${ICON_MOVE_NEXT_WEEK_LOCATOR}
    Delete all times selected
