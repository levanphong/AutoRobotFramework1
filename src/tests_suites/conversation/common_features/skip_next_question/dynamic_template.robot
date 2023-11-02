*** Settings ***
Resource            ./skip_next_question.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Force Tags          advantage    aramark    fedex    fedexstg    lowes_stg    lts_stg    olivia    pepsi    plg    regis    stg    unilever    mchire

*** Test Cases ***
Verify that Skip Next Question is not available on Dynamic Conversation when ATS Mapping tool is added (Data Processing method is not 'Pick List') (OL-T12579)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Candidate    Free text
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element not display on screen    Skip Next Question
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Screening    Free text
	Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
	Check element not display on screen    Skip Next Question
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is copied when duplicating dynamic conversation (OL-T12673)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Candidate    PickList
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Skip Next Question
	Input into    ${TEXT_INPUT_TEXTBOX}    Yes
	Click at    ${SKIP_QUESTION_APPLY_BUTTON}
	Public the conversation
	Go to conversation builder
	Search Conversation in Conversation Builder    ${conversation_name}
	${eclipse_icon_locator} =    Format string    ${CONVERSATION_ROW_ECLIPSE_ICON}    ${conversation_name}
	Click by JS    ${eclipse_icon_locator}
	Click at    ${ECLIPSE_DUPLICATE_BUTTON}
	Click at    ${CONFIRM_DUPLICATE_BUTTON}
	Find and go to conversation detail    ${conversation_name} (Copy)
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Edit Condition Criteria
	Verify Skip Next Question builder for Dynamic conversation
	${text_input_value} =    Get value    ${TEXT_INPUT_TEXTBOX}
	should be equal as strings    ${text_input_value}    Yes
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Skip Next Question function is removed when deleting Data Processing Method in Dynamic conversation (OL-T12654)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12587
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    ATS Mapping
	Click at    ${ATS_POPUP_REMOVE_BUTTON}
	Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
	...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
	Click at    ${ATS_CANCEL_CHANGES_BUTTON}
	Click at    ${ATS_POPUP_REMOVE_BUTTON}
	Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
	...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
	Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element not display on screen    Skip Next Question
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Check hide the next question when the current question has Skip Next question function in dynamic conversation (OL-T12659)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Candidate    PickList
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Skip Next Question
	Input into    ${TEXT_INPUT_TEXTBOX}    Yes
	Click at    ${SKIP_QUESTION_APPLY_BUTTON}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON_2}
	Click Question tooltip in Eclipse Menu    Hide Question
	Check element display on screen    ${CANDIDATE_QUESTION_DISABLED}
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Check delete the next question when the current question has Skip Next question function in dynamic conversation (OL-T12660)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Candidate    PickList
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Skip Next Question
	Input into    ${TEXT_INPUT_TEXTBOX}    Yes
	Click at    ${SKIP_QUESTION_APPLY_BUTTON}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON_2}
	Click Question tooltip in Eclipse Menu    Delete Question
	Verify display text    ${DELETE_QUESTION_POPUP_MESSAGE}    Are you sure you want to delete this item?
	Click at    ${DELETE_QUESTION_YES_BUTTON}
	Verify display text    ${CONFIRM_CHANGES_MESSAGE}
	...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
	Click at    ${CONFIRM_CHANGES_BUTTON}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element not display on screen    Skip Next Question
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Edit Skip Next Question Condition Builder when ATS Mapping is added in Dynamic conversation (OL-T12617)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12616
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Edit Condition Criteria
	Click at    ${STARTING_VALUE_DROPDOWN}
	Input into    ${TEXT_INPUT_TEXTBOX}    BCD
	Click at    ${SKIP_QUESTION_APPLY_BUTTON}
	Scroll to element    ${CANDIDATE_QUESTION_2_LABEL}
	Hover at    ${CANDIDATE_QUESTION_CONDITION_TOOLTIP}
	Verify tooltip is display    Edit Condition Criteria
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next question condition builder is not saved when canceling instead of saving for dynamic conversation (OL-T12623)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12578    ${conversation_name}
	Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Skip Next Question
	Click at    ${STARTING_VALUE_DROPDOWN}
	Choose value from Skip Next Question tool dropdown    City
	Click at    ${SCREEN_FOR_DROPDOWN}      slow_down=2s
	Check element display on screen    ${SCREEN_FOR_IS_OPTION}
	Check element display on screen    ${SCREEN_FOR_IS_NOT_OPTION}
	Input into    ${TEXT_INPUT_TEXTBOX}    ABC
	Click at    ${SKIP_QUESTION_CANCEL_BUTTON}
	Check element not display on screen    ${SCREENING_QUESTION_CONDITION_TOOLTIP}
	Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
	Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Check remove Skip Next Question function in Dynamic conversation (OL-T12624)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12580
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
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
	Check element not display on screen    ${CANDIDATE_QUESTION_CONDITION_TOOLTIP}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Check validate when adding duplicate condition in Dynamic conversation (OL-T12647)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12616
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Click Question tooltip in Eclipse Menu    Edit Condition Criteria
	Click at    ${SKIP_QUESTION_OR_BUTTON}      slow_down=2s
	Click at    ${STARTING_VALUE_DROPDOWN_2}
	Choose value from Skip Next Question tool dropdown    City
	Input into    ${TEXT_INPUT_TEXTBOX_2}    ABC
	Click at    ${SKIP_QUESTION_APPLY_BUTTON}
	Check element display on screen    ${CONDITION_DUPLICATE_ERROR}
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Check validate when applying Skip Next Question condition builder without inputting condition for Dynamic conversation (OL-T12648)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12578    ${conversation_name}
	Click by JS    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}    slow_down=2s
	Click Question tooltip in Eclipse Menu    Skip Next Question
	Verify Skip Next Question builder for Dynamic conversation
	Click at    ${SKIP_QUESTION_APPLY_BUTTON}
	Verify display text    ${TEXT_INPUT_TEXTBOX_EMPTY_ERROR}    Please input value
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that Skip Next Question function is removed when changing Data Processing Method in Dynamic conversation (OL-T12650)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12587
	Add ATS Mapping tool to question    Candidate    Free text
	Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
	...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
	Click at    ${ATS_CANCEL_CHANGES_BUTTON}
	Click at    ${ATS POPUP_SAVE_BUTTON}
	Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
	...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
	Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element not display on screen    Skip Next Question
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Dynamic conversation with OR in Skip Next Question builder (OL-T12672)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	OL-T12580
	${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question
	Input text and send message    New
	Check element not display on screen    Your like?
	Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify that Skip Next Question is available on Dynamic Conversation when List Select tool is added (OL-T13020)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
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
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is available on Dynamic Conversation when ATS Mapping tool is added (Data Processing method is 'Yes/No') (OL-T13021)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	${conversation_name} =    Add Dynamic conversation
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Candidate    Yes / No
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
	Click at    ${CANDIDATE_QUESTION_SUBTOOL_BUTTON}
	Go to conversation builder
	Find and go to conversation detail    ${conversation_name}
	Add ATS Mapping tool to question    Screening    Yes / No
	Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
	Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
	Click at    ${SCREENING_QUESTION_SUBTOOL_BUTTON}
	Delete Skip Next Question data tests after run test case    ${conversation_name}

*** Keywords ***
Delete Skip Next Question data tests after run test case
	[Arguments]    ${conversation_name}=None    ${site_name}=None
	IF    '${conversation_name}' != 'None'
		Go to conversation builder
		Find and go to conversation detail    ${conversation_name}
		Delete conversation in builder
	END
	IF    '${site_name}' != 'None'
		Delete a landing site/widget site    ${site_name}
	END
