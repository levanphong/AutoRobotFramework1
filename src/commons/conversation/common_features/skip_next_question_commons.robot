*** Variables ***
${list_select_multiple_choices_question}    Can Multiple Choices be selected?

*** Keywords ***
Add ATS Mapping tool to question
    [Arguments]    ${conversation_type}    ${data_type}
    IF    '${conversation_type}' == 'Candidate'
        ${subtool_btn} =    Set variable    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
    ELSE IF    '${conversation_type}' == 'Screening'
        ${subtool_btn} =    Set variable    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
    ELSE IF    '${conversation_type}' == 'Global Screening'
        ${subtool_btn} =    Set variable    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    ELSE IF    '${conversation_type}' == 'Group Screening'
        ${subtool_btn} =    Set variable    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    ELSE IF    '${conversation_type}' == 'Conditional Conversation'
        ${subtool_btn} =    Set variable    ${QUESTION_YES_SUBTOOL_BUTTON}
    END
    Click at    ${subtool_btn}
    Click Question tooltip in Eclipse Menu    ATS Mapping
    Click by JS    ${ATS_DATA_METHOD_DROPDOWN}
    ${data_method_locator} =    Format string    ${ATS_DATA_METHOD_VALUE}    ${data_type}
    Click by JS    ${data_method_locator}
    IF    '${data_type}' == 'PickList'
        Input into    ${ATS_PICK_LIST_ID_TEXTBOX}    1
    END
    Input into    ${ATS_FIELD_TEXTBOX}    ATS Field Test
    Click at    ${ATS POPUP_SAVE_BUTTON}

OL-T12616
    Add ATS Mapping tool to question    Candidate    PickList
    Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Dynamic conversation
    Input into    ${TEXT_INPUT_TEXTBOX}    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${CANDIDATE_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T12589
    OL-T12581
    OL-T12583
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T12581
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T12583
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T12588
    OL-T12583
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T12619
    OL-T12589
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T12578
    [Arguments]    ${conversation_name}
    ${verify_tooltip_locator} =    Format string    ${QUESTION_TOOLTIP_MENU}    Skip Next Question
    Add ATS Mapping tool to question    Candidate    PickList
    Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen    ${verify_tooltip_locator}
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Add ATS Mapping tool to question    Screening    PickList
    Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen    ${verify_tooltip_locator}
    Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T12580
    OL-T12616
    Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    ${count} =    Get Element Count    ${STARTING_VALUE_ENABLED}
    should be equal as strings    ${count}    2
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    New
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}

OL-T12621
    OL-T12619
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T12587
    Add ATS Mapping tool to question    Candidate    PickList
    Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Dynamic conversation
    Input into    ${TEXT_INPUT_TEXTBOX}    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${CANDIDATE_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T12585
    OL-T12581
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T12620
    OL-T12583
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13064
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13066
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13071
    OL-T13064
    OL-T13066
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13070
    OL-T13066
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13073
    OL-T13071
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13075
    OL-T13073
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13067
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${DOCUMENT_UPLOAD_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${DOCUMENT_UPLOAD_SAVE_BUTTON}      slow_down=2s
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13068
    OL-T13064
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13074
    OL-T13066
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13107
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13109
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13114
    OL-T13107
    OL-T13109
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13113
    OL-T13109
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13116
    OL-T13114
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13118
    OL-T13116
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13111
    OL-T13107
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13117
    OL-T13109
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13137
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13139
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13144
    OL-T13137
    OL-T13139
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13143
    OL-T13139
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13146
    OL-T13144
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13148
    OL-T13146
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13141
    OL-T13137
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13147
    OL-T13139
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13204
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13206
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}

OL-T13211
    OL-T13204
    OL-T13206
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13210
    OL-T13206
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13213
    OL-T13211
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13215
    OL-T13213
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13208
    OL-T13204
    Add ATS Mapping tool to question    Global Screening    Yes / No
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13234
    Add ATS Mapping tool to question    Group Screening    Yes / No
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}

OL-T13236
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}

OL-T13241
    OL-T13234
    OL-T13236
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13240
    OL-T13236
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13243
    OL-T13241
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13245
    OL-T13243
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13238
    OL-T13234
    Add ATS Mapping tool to question    Group Screening    Yes / No
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13244
    OL-T13236
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13264
    Add ATS Mapping tool to question    Group Screening    Yes / No
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}

OL-T13266
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}

OL-T13271
    OL-T13264
    OL-T13266
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13270
    OL-T13266
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13273
    OL-T13271
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13275
    OL-T13273
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13268
    OL-T13264
    Add ATS Mapping tool to question    Group Screening    Yes / No
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13274
    OL-T13266
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13294
    Add ATS Mapping tool to question    Group Screening    Yes / No
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}

OL-T13296
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}

OL-T13301
    OL-T13294
    OL-T13296
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Add System Attribute to question    Free text
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13300
    OL-T13296
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13303
    OL-T13301
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13305
    OL-T13303
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13298
    OL-T13294
    Add ATS Mapping tool to question    Group Screening    Yes / No
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${GROUP_1_QUESTION_1_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria

OL-T13304
    OL-T13296
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GROUP_1_QUESTION_1_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13344
    Add ATS Mapping tool to question    Conditional Conversation    Yes / No
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s

OL-T13346
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_1_NAME}    at least 20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_2_NAME}    20 years
    Click at    ${LIST_SELECT_TOOL_ADD_ITEM_BUTTON}
    Input into    ${LIST_ITEM_3_NAME}    more than 20 years
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s

OL-T13351
    OL-T13344
    OL-T13346
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Add System Attribute to question    Free text
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    City
    Input into    ${TEXT_INPUT_TEXTBOX}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${QUESTION_YES_CONDITION_TOOLTIP}
    Verify tooltip is display    Edit Condition Criteria
    Public the conversation

OL-T13350
    OL-T13346
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${QUESTION_YES_ICON_CONDITION_TOOLTIP_1}
    Verify tooltip is display    Edit Condition Criteria

OL-T13353
    OL-T13351
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${STARTING_VALUE_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${verify_value} =    Get value and format text    ${STARTING_VALUE_TEXT}
    should be equal as strings    ${verify_value}    Question: Age
    ${verify_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${verify_value}    No
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13355
    OL-T13353
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Company Brand
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Check element display on screen    ${SCREEN_FOR_IS_OPTION}
    Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
    Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX_2}
    should be equal as strings    ${text_input_value}    ABC
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13354
    OL-T13346
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}

OL-T13348
    OL-T13344
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Hover at    ${QUESTION_YES_ICON_CONDITION_TOOLTIP_1}
    Verify tooltip is display    Edit Condition Criteria
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    public the conversation

OL-T13214
    OL-T13206
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${LIST_SELECT_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click on option toggle in Edit Question Option dialog    ${list_select_multiple_choices_question}
    Click at    ${LIST_SELECT_SAVE_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${TEXT_INPUT_DROPDOWN}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Choose value from Skip Next Question tool dropdown    20 years
    Choose value from Skip Next Question tool dropdown    at least 20 years
    Click at    ${TEXT_INPUT_POPUP_APPLY_BUTTON}
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_DROPDOWN_INPUT}
    should be equal as strings    ${text_input_value}    at least 20 years, 20 years, more than 20 years
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}
