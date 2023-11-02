*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/candidate_volume_optimizer_locators.py

*** Keywords ***
Add a default Job Segment
    [Arguments]     ${segment_name}     ${job_id}=None     ${number_of_candidates}=None
    ${job_id} =     Evaluate    "${segment_name}" if "${job_id}" == "None" else "${job_id}"
    # Search
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_name}
    ${is_not_exist} =   Run keyword and return status   Check element not display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  ${segment_name}  wait_time=2s
    # Delete if it's Draft
    ${is_draft} =   Run keyword and return status   Check element display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  Draft  wait_time=2s
    IF  ${is_draft}
        Delete a Job Segment    ${segment_name}
        ${is_not_exist} =   Set variable    True
    END
    # Add new if not exist
    IF  ${is_not_exist}
        # Input Details & Targeting
        Click at  ${CVO_NEW_SEGMENT_BUTTON}
        Input into  ${SEGMENT_DETAIL_NAME_TEXTBOX}  ${segment_name}
        Click at  ${SEGMENT_DETAIL_TARGETING_RULES_DROPDOWN}
        Click at  Job Req ID
        Click at  ${SEGMENT_DETAIL_MATCHES_DROPDOWN}
        Click at  Exactly matches
        Input into  ${SEGMENT_DETAIL_TARGETING_INPUT_TEXTBOX}  ${job_id}
        Click at  ${SEGMENT_DETAIL_NEXT_BUTTON}
        # Input Status Thresholds
        Click at  ${SEGMENT_THRESHOLDS_ADD_BUTTON}
        Click at  ${SEGMENT_THRESHOLDS_STATUS_DROPDOWN}
        Click at  Capture
        Click at  Conversation In-Progress
        Run keyword if  '${number_of_candidates}' != 'None'  Input into  ${SEGMENT_THRESHOLDS_NUMBER_TEXTBOX}  ${number_of_candidates}
        Click at  ${SEGMENT_THRESHOLDS_SAVE_BUTTON}
        Click at  Continue
        Click at  Save & Publish
    END

Delete a Job Segment
    [Arguments]     ${segment_name}
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_name}
    Hover at  ${CVO_SEGMENT_ECLIPSE_BUTTON}
    Click at  ${CVO_SEGMENT_ECLIPSE_BUTTON}
    Click at  ${CVO_SEGMENT_ECLIPSE_MENU_DELETE_BUTTON}
    Click at  ${CVO_SEGMENT_ECLIPSE_MENU_CONFIRM_DELETE_BUTTON}
    Check element not display on screen  ${segment_name}

Deactivate a Job Segment
    [Arguments]     ${segment_name}
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_name}
    Click at  ${CVO_SEGMENT_ECLIPSE_BUTTON}
    Click at  ${CVO_SEGMENT_ECLIPSE_MENU_DEACTIVATE_BUTTON}
    Click at  ${CVO_SEGMENT_ECLIPSE_MENU_CONFIRM_DEACTIVATE_BUTTON}

Add a customize Job Segment
    [Arguments]     ${segment_info}
    # Search
    Input into  ${CVO_SEGMENT_SEARCH_TEXTBOX}   ${segment_info.segment_name}
    ${is_not_exist} =   Run keyword and return status   Check element not display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  ${segment_info.segment_name}  wait_time=2s
    # Delete if it's Draft
    ${is_draft} =   Run keyword and return status   Check element display on screen  ${CVO_SEGMENT_LIST_CELL_VALUE}  Draft  wait_time=2s
    IF  ${is_draft}
        Delete a Job Segment    ${segment_info.segment_name}
        ${is_not_exist} =   Set variable    True
    END
    # Add new if not exist
    IF  ${is_not_exist}
        # Input Details & Targeting
        Click at  ${CVO_NEW_SEGMENT_BUTTON}
        Input into  ${SEGMENT_DETAIL_NAME_TEXTBOX}  ${segment_info.segment_name}
        Click at  ${SEGMENT_DETAIL_TARGETING_RULES_DROPDOWN}
        Click at  ${segment_info.targeting_rule}
        Click at  ${SEGMENT_DETAIL_MATCHES_DROPDOWN}
        Click at  ${segment_info.matches}
        Input into  ${SEGMENT_DETAIL_TARGETING_INPUT_TEXTBOX}  ${segment_info.filter_text}
        Click at  ${SEGMENT_DETAIL_NEXT_BUTTON}
        # Input Status Thresholds
        Click at  ${SEGMENT_THRESHOLDS_ADD_BUTTON}
        Click at  ${SEGMENT_THRESHOLDS_STATUS_DROPDOWN}
        Click by JS  ${segment_info.threshold_status_parent}
        Click by JS  ${segment_info.threshold_status_children}
        Run keyword if  '${segment_info.threshold_num_of_candidates}' != 'None'  Input into  ${SEGMENT_THRESHOLDS_NUMBER_TEXTBOX}  ${segment_info.threshold_num_of_candidates}
        Run keyword if  '${segment_info.threshold_action}' != 'None'  Click at  ${SEGMENT_THRESHOLDS_ACTION_DROPDOWN}
        Run keyword if  '${segment_info.threshold_action}' != 'None'  Click at  ${segment_info.threshold_action}
        Click at  ${SEGMENT_THRESHOLDS_SAVE_BUTTON}
        Click at  Continue
        Click at  Save & Publish
    END
