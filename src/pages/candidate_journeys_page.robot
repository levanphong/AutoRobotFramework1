*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/candidate_journeys_locators.py


*** Keywords ***
Load full Candidate Journeys in page
    ${js_script} =    Set variable    function delay(time) { return new Promise(resolve => setTimeout(resolve, time)); } do { defaultHeight = document.getElementById("container").scrollHeight; window.scrollTo(0, document.getElementById("container").scrollHeight); await delay(2000); maxHeight = document.getElementById("container").scrollHeight; } while (defaultHeight < maxHeight)
    Execute Javascript    ${js_script}

Add a Candidate Journey
    [Arguments]    ${journey_name}=None    ${journey_type}=Candidate Journey
    Go to Candidate Journeys page
    Click at    ${NEW_JOURNEY_BUTTON}   slow_down=2s
    ${is_multiple_journey_type} =   Run keyword and return status   Check element display on screen  ${NEW_JOURNEY_TYPE_POPUP_TALENT_COMMUNITY_JOURNEY_TYPE}  wait_time=10s
    IF  '${is_multiple_journey_type}' == 'True'
        IF  '${journey_type}' == 'Candidate Journey'
            Click at  ${NEW_JOURNEY_TYPE_POPUP_CANDIDATE_JOURNEY_TYPE}
        ELSE IF  '${journey_type}' == 'Talent Community Journey'
            Click at  ${NEW_JOURNEY_TYPE_POPUP_TALENT_COMMUNITY_JOURNEY_TYPE}
        END
        Click at  ${NEW_JOURNEY_TYPE_POPUP_NEXT_BUTTON}
    END
    IF    '${journey_name}' == 'None'
        ${journey_name} =    Generate random name    auto_journey
    END
    Wait with short time
    Input into    ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}    ${journey_name}
    Click at    ${CREATE_NEW_JOURNEY_BUTTON}    slow_down=2s
    Wait with medium time
    Publish a Journey    ${journey_name}
    Wait with medium time
    [Return]    ${journey_name}

Add a Journey Stage
    [Arguments]    ${journey_name}    ${stage_type}
    Go to Candidate Journeys page
    ${journey_name_locator} =    Format String    ${JOURNEY_TITLE}    ${journey_name}
    Load full Candidate Journeys in page
    Click by JS    ${journey_name_locator}
    Click at    ${NEW_STAGE_BUTTON}
    Click at    ${STAGE_TYPE_DROPDOWN}
    Click at    ${STAGE_TYPE_VALUE}    ${stage_type}    2s
    Input into    ${STAGE_NAME_TEXT_BOX}    ${stage_type}
    Click at    ${SAVE_STAGE_BUTTON}
    Wait with medium time

Add a stage
    [Arguments]     ${stage_type}
    Click at    ${NEW_STAGE_BUTTON}     slow_down=2s
    Click at    ${STAGE_TYPE_DROPDOWN}
    Click at    ${STAGE_TYPE_VALUE}    ${stage_type}
    Input into    ${STAGE_NAME_TEXT_BOX}    ${stage_type}
    Click at    ${SAVE_STAGE_BUTTON}

Publish a Journey
    [Arguments]    ${journey_name}
    Click a Journey    ${journey_name}
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s

Click a Journey
    [Arguments]     ${journey_name}
    Go to Candidate Journeys page
    ${journey_name_locator} =    Format String    ${JOURNEY_TITLE}    ${journey_name}
    Load full Candidate Journeys in page
    Click by JS    ${journey_name_locator}

Delete a Journey
    [Arguments]    ${journey_name}
    Go to Candidate Journeys page
    ${journey_eclipse_locator} =    Format String    ${JOURNEY_ECLIPSE_ICON}    ${journey_name}
    Load full Candidate Journeys in page
    Click by JS    ${journey_eclipse_locator}
    ${delete_locator}=  format string  ${JOURNEY_ECLIPSE_POPUP_DELETE_BUTTON}    ${journey_name}
    Click at    ${delete_locator}    ${journey_name}   1s
    Click at    ${JOURNEY_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}      slow_down=1s
    wait for page load successfully v1

Duplicate a Journey
    [Arguments]    ${journey_name}
    Go to Candidate Journeys page
    ${journey_name_locator} =    Format String    ${JOURNEY_TITLE}    ${journey_name}
    Load full Candidate Journeys in page
    Click at  ${JOURNEY_ECLIPSE_ICON}  ${journey_name}
    Click at  ${JOURNEY_ECLIPSE_POPUP_DUPLICATE_BUTTON}  ${journey_name}
    Click at  ${DUPLICATE_JOURNEY_CONFIRM_POPUP_YES_BUTTON}
    ${new_journey_name} =    Set variable   Copy 1 - ${journey_name}
    ${journey_name_locator} =    Format String    ${JOURNEY_TITLE}    ${new_journey_name}
    Load full Candidate Journeys in page
    [Return]    ${new_journey_name}

Delete a Stage
    [Arguments]    ${stage}
    Click by JS    ${JOURNEY_ICON_DELETE_STAGE}    ${stage}
    Click at    ${JOURNEY_DELETE_STAGE_CONFIRM_YES_BUTTON}
    wait for page load successfully
    Click at    ${PUBLISH_STAGE_BUTTON}

Create new candidate journey and publish
    [Arguments]     ${journey_name}     ${stage}=None
    Go to Candidate Journeys page
    Click at    ${NEW_JOURNEY_BUTTON}
    Wait Until Element Contains    ${TITLE_JOURNEY_FORM}    Create New Candidate Journey
    Input into      ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}    ${journey_name}
    Click at    ${CREATE_NEW_JOURNEY_BUTTON}
    ${is_cj_created} =     Run keyword and Return Status   Check element display on screen     ${CREATE_NEW_JOURNEY_BUTTON}     wait_time=10s
    IF  '${is_cj_created}' == 'False'
        Publish a Journey    ${journey_name}
        IF      '${stage}' != 'None'
            Add a stage     ${stage}
        END
        Publish a Journey   ${journey_name}
    END

Search a journey status
    [Arguments]     ${journey_status}
    Click at    ${JOURNEY_NEXT_STEP_ADD_STATUS_ICON}
    Input into  ${JOURNEY_NEXT_STEP_SEARCH_STATUS_INPUT}     ${journey_status}
    ${is_visible} =     Run Keyword And Return Status    Check element display on screen     ${JOURNEY_NEXT_STEP_RESULT_SEARCH_ICON_DROPDOWN}     wait_time=2s
    IF    '${is_visible}' == 'True'
        Click at    ${JOURNEY_NEXT_STEP_RESULT_SEARCH_ICON_DROPDOWN}
    END

Search and select a journey status
    [Arguments]     ${journey_status}
    Search a journey status     ${journey_status}
    Click at    ${JOURNEY_NEXT_STEP_LIST_RESULT_SEARCH_LABEL}     ${journey_status}

Add next step button for a status
    [Arguments]     ${journey_status}   ${button_name}    ${turn_on_form_toogle}=True
    ${is_created} =     Run keyword and Return Status   Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${button_name}
    IF  '${is_created}' == 'False'
        Click at    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
        Input into  ${JOURNEY_NEXT_STEP_NAME_BUTTON_INPUT}      ${button_name}
        Search and select a journey status    ${journey_status}
        Click at    ${JOURNEY_NEXT_STEP_MODEL_ALLPY_BUTTON}
        Run Keyword If    '${turn_on_form_toogle}'=='True'    Turn on     ${JOURNEY_NEXT_STEP_SEND_USER_FORM_TOGGLE}
        Click at    ${JOURNEY_NEXT_STEP_SAVE_BUTTON}
        Check text display    Your changes have been saved.
        Capture Page Screenshot
    END
    [Return]    ${button_name}

Add next step button have many journey status
    [Arguments]     ${status_list}   ${button_name}    ${turn_on_form_toogle}=True
    ${is_created} =     Run keyword and Return Status   Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${button_name}
    IF  '${is_created}' == 'False'
        Click at    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
        Input into  ${JOURNEY_NEXT_STEP_NAME_BUTTON_INPUT}      ${button_name}
        FOR    ${status}    IN    @{status_list}
            Search and select a journey status    ${status}
        END
        Click at    ${JOURNEY_NEXT_STEP_MODEL_ALLPY_BUTTON}
        Run Keyword If    '${turn_on_form_toogle}'=='True'    Turn on     ${JOURNEY_NEXT_STEP_SEND_USER_FORM_TOGGLE}
        Click at    ${JOURNEY_NEXT_STEP_SAVE_BUTTON}
        Check text display    Your changes have been saved.
        Capture Page Screenshot
    END
    [Return]    ${button_name}

Add next step for journey stage and publish
    [Arguments]    ${stage_name}    ${status_name}    ${next_step_des}=None    ${next_step_bt_name}=None    ${next_step_status}=None    ${multi_status}=False
    Click at    ${STAGE_NAME_IN_JOURNEY}    ${stage_name}
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}   ${status_name}
    IF    '${next_step_des}' != 'None'
        Input into    ${JOURNEY_ADD_NEXT_STEP_DES_INPUT}    ${next_step_des}
        Click at    ${JOURNEY_NEXT_STEP_DONE_BUTTON}
    END
    IF    '${next_step_bt_name}' != 'None'
        IF    '${multi_status}' == 'True'
            Add next step button have many journey status    ${next_step_status}    ${next_step_bt_name}    False
        ELSE
            Add next step button for a status    ${next_step_status}    ${next_step_bt_name}    False
        END
    END
    Go Back
    Reload Page
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s

Delete next step button of status
    [Arguments]   ${button_name}
    Click on span text      ${button_name}
    Click at    ${JOURNEY_NEXT_STEP_DELETE_STATUS_BUTTON}
    Click at    ${JOURNEY_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON}
    wait for page load successfully

Check UI Default In Journey
    [Arguments]     ${journey_default_name}
    Check strong text display      ${journey_default_name}
    ${ellipsis_button_locator} =    Format String    ${CANDIDATE_JOURNEY_ELLIPSIS_BUTTON}    ${journey_default_name}
    Check element display on screen     ${ellipsis_button_locator}
    ${text_number_groups} =    Format String    ${CANDIDATE_JOURNEY_TEXT}    ${journey_default_name}
    Check element display on screen     ${text_number_groups}
    Capture page screenshot

Input status name
    [Arguments]     ${stage}    ${status_name}    ${journey_name}
    Click at    ${STAGE_NAME_IN_JOURNEY}    ${stage}
    Click at    ${JOURNEY_STAGE_NEW_STATUS_BUTTON}
    ${locator} =    Format String    ${COMMON_INPUT_PLACEHOLDER}    Enter Status Name
    input into    ${locator}       ${status_name}
    Click at        ${COMMON_BUTTON}    Done
    # Return to All stage
    Click on span text      ${journey_name}

Check New Journeys Modal When Talent Community Is On
    Check element display on screen     ${NEW_JOURNEY_TYPE_POPUP_TALENT_COMMUNITY_JOURNEY_TYPE}  wait_time=10s
    Check element display on screen     ${NEW_JOURNEY_TYPE_POPUP_CANDIDATE_JOURNEY_TYPE}  wait_time=10s
    Check element display on screen     ${NEW_JOURNEY_TYPE_POPUP_NEXT_BUTTON}
    Check element display on screen     ${NEW_JOURNEY_TYPE_POPUP_CANCEL_BUTTON}
    Capture page screenshot

Check UI Stages
    [Arguments]   @{list_stage_name}
    FOR     ${stage_name}   IN      @{list_stage_name}
        Check span display  ${stage_name}
        Check element display on screen     ${JOURNEY_STAGE_NUMBER_STATUSES_TEXT}    ${stage_name}
     END
    Capture page screenshot

Check Journey Display On Screen
    [Arguments]  ${journey_name}
    Load full Candidate Journeys in page
    Check UI Default In Journey     ${journey_name}

Check UI Status Of Stage Journey
    [Arguments]  ${stage_name}  @{list_statuses_name}
    ${number_statuses} =  get length  ${list_statuses_name}
    Click at    ${STAGE_NAME_IN_JOURNEY}   ${stage_name}
    FOR     ${number}   IN RANGE    ${number_statuses}
        ${locator_title} =    Format String   ${JOURNEY_STAGE_STATUS_TITLES}    ${number+1}
        ${text_value} =     Get Text    ${locator_title}
        Should Be Equal As Strings    ${list_statuses_name}[${number}]      ${text_value}
        Check element not display on screen        ${JOURNEY_STAGE_STATUS_MOVE_ICON}    ${list_statuses_name}[${number}]     wait_time=2s
        Check element display on screen        ${JOURNEY_STAGE_STATUS_LOCK_ICON}    ${list_statuses_name}[${number}]
    END
    Check element not display on screen     ${JOURNEY_STAGE_NEW_STATUS_BUTTON}  wait_time=2s
    Capture page screenshot

Check UI Next Step In All Statuses
    [Arguments]     ${journey_name}
    ${count_stages} =  Get Element Count   ${JOURNEY_TOTAL_STAGES}
    FOR     ${index}     IN RANGE    ${count_stages}
        Click at    ${JOURNEY_STAGE_NAME}     ${index+1}
        ${count_statuses} =     Get Element Count  ${JOURNEY_STAGE_TOTAL_STATUSES}
        FOR     ${index_status}     IN RANGE    ${count_statuses}
            ${status_name} =    Get text and format text   ${JOURNEY_STAGE_STATUS_TITLES}    ${index_status+1}
            Click at    ${JOURNEY_STAGE_STATUS_TITLES}    ${index_status+1}
            Check label display     Highlight this step as Action Needed for users
            Check element display on screen      ${JOURNEY_STAGE_STATUS_ACTION_NEEDED_LABEL}
            Check element display on screen      ${JOURNEY_NEXT_STEP_MODEL_TITLE}
            Check element display on screen      When a candidate reaches this status, set what action(s) a user can take.
            Check element display on screen      ${status_name}
            Check element display on screen      ${COMMON_PLACEHOLDER}      Add Next Steps Description
            Check element display on screen      ${JOURNEY_ADD_NEXT_STEP_BUTTON}
            Capture page screenshot
        END
        Click on span text      ${journey_name} -
    END

Remove a user on tab of stage
    [Arguments]    ${tab_name}   ${cj_name}    ${user}      ${stage_name}
    Click edit permission of stage      ${cj_name}      ${stage_name}
    Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}      ${tab_name}
    Click at   ${ECLIPSE_ICON_MENU_IN_STAGE}    ${user}
    Click at        Remove Role
    Click at        Yes
    Click at    ${PERMISSION_PROVER_POPUP_SAVE_BUTTON}
    Capture page screenshot

Add a user on tab of stage
    [Arguments]   ${tab_name}   ${cj_name}    ${user}       ${stage_name}
    Click edit permission of stage      ${cj_name}  ${stage_name}
    Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}     ${tab_name}
    Click at    ${ICON_PLUS_ROUND_IN_STAGE}
    Click at    ${USER_HIRING_TEAM_ROLES_IN_STAGE}      ${user}
    Click at    ${PERMISSION_PROVER_APPLY_BUTTON}
    Click at    ${PERMISSION_PROVER_POPUP_SAVE_BUTTON}
    Capture page screenshot

Click edit permission of stage
    [Arguments]     ${cj_name}  ${stage_name}
    Click on span text    ${cj_name}
    Click at    ${STAGE_NAME_IN_JOURNEY}    ${stage_name}
    wait for page load successfully v1
    Click at    ${ICON_SETTING_STAGE_IN_JOURNEY}
    Click at    Edit Permissions
    Capture page screenshot
