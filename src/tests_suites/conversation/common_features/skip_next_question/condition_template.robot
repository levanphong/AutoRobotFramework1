*** Settings ***
Resource            ./skip_next_question.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags          advantage    aramark    fedex    fedexstg    lowes_stg    lts_stg    olivia    pepsi    plg    regis    stg    unilever    mchire

*** Test Cases ***
Verify that Skip Next Question is not available on Condition conversation when ATS Mapping tool is added (Data Processing method is not 'Yes/No') (OL-T13345)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Add ATS Mapping tool to question    Conditional Conversation    Free text
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is not available on Condition conversation when List Select tool is not added (OL-T13347)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Click Question tooltip in Eclipse Menu    Add Tool
    Click at    ${DOCUMENT_UPLOAD_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${DOCUMENT_UPLOAD_SAVE_BUTTON}      slow_down=2s
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is copied when duplicating Condition conversation (OL-T13349)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13351
    Go to conversation builder
    Search Conversation in Conversation Builder    ${conversation_name}
    ${eclipse_icon_locator} =    Format string    ${CONVERSATION_ROW_ECLIPSE_ICON}    ${conversation_name}
    Click at    ${eclipse_icon_locator}
    Click at    ${ECLIPSE_DUPLICATE_BUTTON}
    Click at    ${CONFIRM_DUPLICATE_BUTTON}
    Find and go to conversation detail    ${conversation_name} (Copy)
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${text_input_value}    ABC
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Edit Skip Next Question Condition Builder when List Select tool is added in Condition conversation (OL-T13352)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    more than 20 years
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value and format text    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${text_input_value}    more than 20 years
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next question condition builder is not saved when canceling instead of saving for Condition conversation (OL-T13356)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13344
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}
    Page should not contain element    ${QUESTION_YES_ICON_CONDITION_TOOLTIP_1}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check remove Skip Next Question function in Condition conversation (OL-T13357)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13355
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
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
    Check element not display on screen    ${QUESTION_YES_ICON_CONDITION_TOOLTIP_1}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element display on screen  ${QUESTION_TOOLTIP_MENU}  Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check validate when adding duplicate condition in Condition conversation (OL-T13358)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13353
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
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


Check validate when applying Skip Next Question condition builder without inputting condition for Condition conversation (OL-T13359)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13344
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Verify display text    ${TEXT_INPUT_TEXTBOX_EMPTY_ERROR}    Please input value
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that Skip Next Question function is removed when changing Data Processing Method in Condition conversation (OL-T13360)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13348
    Add ATS Mapping tool to question    Conditional Conversation    Free text
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CANCEL_CHANGES_BUTTON}
    Click at    ${ATS POPUP SAVE BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that Skip Next Question condition is removed when removing list select tool for Condition conversation (OL-T13361)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Edit Tool
    Click at    ${DOCUMENT_UPLOAD_TOOL}
    Click at    ${ADD_TOOL_NEXT_BUTTON}
    Click at    ${DOCUMENT_UPLOAD_SAVE_BUTTON}      slow_down=2s
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Skip Next Question function is removed when deleting Data Processing Method in Condition conversation (OL-T13362)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13348
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    ATS Mapping
    Click at    ${ATS_POPUP_REMOVE_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CANCEL_CHANGES_BUTTON}
    Click at    ${ATS_POPUP_REMOVE_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that Skip Next Question condition is removed when removing list select tool for Condition conversation (OL-T13363)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Remove Tool
    Click at    ${REMOVE_TOOL_YES_BUTTON}
    Verify display text    ${ATS_CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${ATS_CONFIRM_CHANGES_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check hide the next question when the current question has Skip Next question function in Condition conversation (OL-T13365)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Click Question tooltip in Eclipse Menu    Hide Question
    Check element display on screen    ${QUESTION_YES_CONDITION_TOOLTIP}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check delete the next question when the current question has Skip Next question function in Condition conversation (OL-T13366)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON_1}
    Click Question tooltip in Eclipse Menu    Delete Question
    Verify display text    ${DELETE_QUESTION_POPUP_MESSAGE}    Are you sure you want to delete this item?
    Click at    ${DELETE_QUESTION_YES_BUTTON}
    Verify display text    ${CONFIRM_CHANGES_MESSAGE}
    ...    Are you sure that you would like to make this change? Doing so will automatically remove Skip Conditions applied to this question.
    Click at    ${CONFIRM_CHANGES_BUTTON}
    Click at    ${QUESTION_YES_SUBTOOL_BUTTON}      slow_down=2s
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify New Skip Next Question flow when starting Condition conversation and selecting option matching with setting (OL-T13367)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Public the conversation
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Click on option in landing page    20 years
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify New Skip Next Question flow when starting Condition conversation and selecting the option not matching with setting (OL-T13368)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13350
    Public the conversation
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Click on option in landing page    more than 20 years
    Click by JS    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Check element display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Condition conversation and selecting multiple options matching with setting (OL-T13369)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13354
    Public the conversation
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Click on option in landing page    more than 20 years
    Click on option in landing page    20 years
    Click on option in landing page    at least 20 years
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Condition conversation and selecting multiple options not matching with setting (OL-T13370)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13354
    Public the conversation
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Click at    ${SKIP_BUTTON}
    Check element display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Condition conversation and input text matching with setting (OL-T13371)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13348
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Input text and send message    Yes
    Wait with medium time
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Condition conversation and input text not matching with setting (OL-T13372)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13348
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Input text and send message    ABC
    Check element display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Skip Next Question flow when starting Condition conversation with OR in Skip Next Question builder (OL-T13373)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Conditional Conversation    Conditional Conversation
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13355
    Public the conversation
    Switch to user    ${CA_TEAM}
    Go to CEM page
    ${candidate_name} =    Add a Candidate and Screen    is_spam_email=False
    sleep    10s
    Find condition conversation and send screen    ${conversation_name}
    Click button in email    Message from ${COMPANY_EVENT}    Hi ${candidate_name}!     MESSAGE_FROM
    Input text and send message    Yes
    Wait with medium time
    # Verify steps
    Click on option in landing page    20 years
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}

*** Keywords ***
Delete Skip Next Question data tests after run test case
    [Arguments]    ${conversation_name}
    Go to conversation builder
    Switch to user    ${TEAM_USER}
    Find and go to conversation detail    ${conversation_name}
    Delete conversation in builder

Find condition conversation and send screen
    [Arguments]    ${conversation_name}
    Click at    ${LIST_SELECT_CONDITION}
    Input into  ${CONDITION_CONVERSATION_SEARCH_BOX}    ${conversation_name}
    wait for page load successfully
    Click at    ${conversation_name}
    Click at    ${SEND_SCREEN_BUTTON}
