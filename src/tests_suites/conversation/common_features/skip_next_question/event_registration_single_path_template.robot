*** Settings ***
Resource            ./skip_next_question.resource
Resource            ../../../../pages/event_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags          advantage    aramark    fedex    fedexstg    lowes_stg    lts_stg    olivia    pepsi    plg    regis    stg    unilever    mchire

*** Test Cases ***
Verify that Skip Next Question is not available on Event Registration (Single Path) conversation when ATS Mapping tool is added (Data Processing method is not 'Yes/No') (OL-T13138)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Add ATS Mapping tool to question    Global Screening    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is not available on Event Registration (Single Path) conversation when List Select tool is not added (OL-T13140)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${DOCUMENT_UPLOAD_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${DOCUMENT_UPLOAD_SAVE_BUTTON}      slow_down=2s
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is copied when duplicating Event Registration (Single Path) conversation (OL-T13142)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13144
    Public the conversation
    Go to conversation builder
    Find and Duplicate conversation    ${conversation_name}
    Find and go to conversation detail    ${conversation_name} (Copy)
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${text_input_value}    ABC
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Edit Skip Next Question Condition Builder when List Select tool is added in Event Registration (Single Path) conversation (OL-T13145)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${text_input_value}    more than 20 years
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next question condition builder is not saved when canceling instead of saving for Event Registration (Single Path) conversation (OL-T13149)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13137
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}
    Page should not contain element    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check remove Skip Next Question function in Event Registration (Single Path) conversation (OL-T13150)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13148
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${CONDITION_DELETE_BUTTON}
    Click at    ${SKIP_QUESTION_REMOVE_BUTTON}
    Verify display text    ${CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure you want to remove the Skip Conditions from this question? All conditions applied will be lost.
    Click at    ${CANCEL_CHANGES_BUTTON}
    Click at    ${SKIP_QUESTION_REMOVE_BUTTON}
    Verify display text    ${CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure you want to remove the Skip Conditions from this question? All conditions applied will be lost.
    Click at    ${REMOVE_CHANGES_BUTTON}
    Check element not display on screen    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check validate when adding duplicate condition in Event Registration (Single Path) conversation (OL-T13151)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13146
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
    Click at    ${STARTING_VALUE_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Question: Age
    Click at    ${SCREEN_FOR_DROPDOWN_2}
    Choose value from Skip Next Question tool dropdown    Is Not
    Click at    ${TEXT_INPUT_DROPDOWN_ICON_2}
    Choose value from Skip Next Question tool dropdown    No
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Check element display on screen    ${CONDITION_DUPLICATE_ERROR}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check validate when applying Skip Next Question condition builder without inputting condition for Event Registration (Single Path) conversation (OL-T13152)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13137
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Verify display text    ${TEXT_INPUT_TEXTBOX_EMPTY_ERROR}    Please input value
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that Skip Next Question function is removed when changing Data Processing Method in Event Registration (Single Path) conversation (OL-T13153)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13141
    Add ATS Mapping tool to question    Global Screening    Free text
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CANCEL_CHANGES_BUTTON}
    Click at    ${ATS POPUP_SAVE_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that cannot change tool from list select to another once list select is used in Skip Next Question conditions for Event Registration (Single Path) conversation (OL-T13154)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${DOCUMENT_UPLOAD_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${DOCUMENT_UPLOAD_SAVE_BUTTON}      slow_down=2s
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Skip Next Question function is removed when deleting Data Processing Method in Event Registration (Single Path) conversation (OL-T13155)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13141
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    ATS Mapping
    Click at    ${ATS_POPUP_REMOVE_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CANCEL_CHANGES_BUTTON}
    Click at    ${ATS_POPUP_REMOVE_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that cannot remove list select tool once it is used in Skip Next Question conditions for Event Registration (Single Path) conversation (OL-T13156)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Remove Tool
    Verify display text    ${REMOVE_TOOL_POPUP_MESSAGE}    Are you sure you want to delete this item?
    Click at    ${REMOVE_TOOL_YES_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check hide the next question when the current question has Skip Next question function in Event Registration (Single Path) conversation (OL-T13158)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON_2}
    Click Question tooltip in Eclipse Menu    Hide Question
    Check element display on screen    ${GLOBAL_SCREENING_QUESTION_DISABLED}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check delete the next question when the current question has Skip Next question function in Event Registration (Single Path) conversation (OL-T13159)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON_2}
    Click Question tooltip in Eclipse Menu    Delete Question
    Verify display text    ${DELETE_QUESTION_POPUP_MESSAGE}    Are you sure you want to delete this item?
    Click at    ${DELETE_QUESTION_YES_BUTTON}
    Verify display text    ${CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${CONFIRM_CHANGES_BUTTON}
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify New Skip Next Question flow when starting Event Registration (Single Path) conversation and selecting option matching with setting (OL-T13160)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Run the event site    ${conversation_name}
    Click on option in landing page for Events    20 years
    Click by JS    ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    Check Like question not display
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify New Skip Next Question flow when starting Event Registration (Single Path) conversation and selecting the option not matching with setting (OL-T13161)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13143
    Run the event site    ${conversation_name}
    Click on option in landing page for Events    more than 20 years
    Click by JS    ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    check message widget site response correct    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Event Registration (Single Path) conversation and selecting multiple options matching with setting (OL-T13162)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13147
    Run the event site    ${conversation_name}
    Click on option in landing page for Events    more than 20 years
    Click on option in landing page for Events    20 years
    Click on option in landing page for Events    at least 20 years
    Click by JS    ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    Check Like question not display
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Event Registration (Single Path) conversation and selecting multiple options not matching with setting (OL-T13163)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13147
    Run the event site    ${conversation_name}
    Click by JS    ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    check message widget site response correct    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Event Registration (Single Path) conversation and input text matching with setting (OL-T13164)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13141
    Run the event site    ${conversation_name}
    Input into    ${INPUT_TEXTBOX}    Yes
    Click at    ${SEND_BUTTON_CONV}
    Check Like question not display
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Event Registration (Single Path) conversation and input text not matching with setting (OL-T13165)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13141
    Run the event site    ${conversation_name}
    Input into    ${INPUT_TEXTBOX}    ABC
    Click at    ${SEND_BUTTON_CONV}
    check message widget site response correct    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Event Registration (Single Path) conversation with OR in Skip Next Question builder (OL-T13166)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Event Registration (Single Path)
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13148
    Run the event site    ${conversation_name}
    Click on option in landing page for Events    20 years
    Click by JS    ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    Check Like question not display
    Delete Skip Next Question data tests after run test case    ${conversation_name}

*** Keywords ***
Delete Skip Next Question data tests after run test case
    [Arguments]    ${conversation_name}
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Delete conversation in builder
