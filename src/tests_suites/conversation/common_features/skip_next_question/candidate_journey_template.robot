*** Settings ***
Resource            ./skip_next_question.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags          advantage    aramark    fedex    fedexstg    lowes_stg    lts_stg    olivia    pepsi    plg    regis    stg    unilever    mchire

*** Test Cases ***
Verify that Skip Next Question is not available on Candidate Journey Conversation when ATS Mapping tool is added (Data Processing method is not 'Yes/No') (OL-T13108)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    Add ATS Mapping tool to question    Global Screening    Free text
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Check element not display on screen    Skip Next Question
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify that Skip Next Question is not available on Candidate Journey Conversation when List Select tool is not added (OL-T13110)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
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


Verify that Skip Next Question is copied when duplicating Candidate Journey (OL-T13112)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13114
    Public the conversation
    Go to conversation builder
    Find and Duplicate conversation    ${conversation_name}
    Find and go to conversation detail    ${conversation_name} (Copy)
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Edit Condition Criteria
    ${text_input_value} =    Get value    ${TEXT_INPUT_TEXTBOX}
    should be equal as strings    ${text_input_value}    ABC
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Verify Edit Skip Next Question Condition Builder when List Select tool is added in Candidate Journey (OL-T13115)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
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


Verify that Skip Next question condition builder is not saved when canceling instead of saving for Candidate Journey (OL-T13119)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13107
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Click at    ${TEXT_INPUT_DROPDOWN_ICON}
    Choose value from Skip Next Question tool dropdown    Yes
    Click at    ${SKIP_QUESTION_CANCEL_BUTTON}
    Page should not contain element    ${GLOBAL_SCREENING_QUESTION_CONDITION_TOOLTIP}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check remove Skip Next Question function in Candidate Journey (OL-T13120)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13118
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


Check validate when adding duplicate condition in Candidate Journey (OL-T13121)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13116
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


Check validate when applying Skip Next Question condition builder without inputting condition for Candidate Journey (OL-T13122)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13107
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON}
    Click Question tooltip in Eclipse Menu    Skip Next Question
    Verify Skip Next Question builder for Single/Multiple Path conversation
    Click at    ${SKIP_QUESTION_APPLY_BUTTON}
    Verify display text    ${TEXT_INPUT_TEXTBOX_EMPTY_ERROR}    Please input value
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check that Skip Next Question function is removed when changing Data Processing Method in Candidate Journey (OL-T13123)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13111
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


Check that cannot change tool from list select to another once list select is used in Skip Next Question conditions for Candidate Journey (OL-T13124)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
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


Skip Next Question function is removed when deleting Data Processing Method in Candidate Journey (OL-T13125)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13111
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


Check that cannot remove list select tool once it is used in Skip Next Question conditions for Candidate Journey (OL-T13126)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
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


Check hide the next question when the current question has Skip Next question function in Candidate Journey (OL-T13128)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
    Click at    ${GLOBAL_SCREENING_QUESTION_SUBTOOL_BUTTON_2}
    Click Question tooltip in Eclipse Menu    Hide Question
    Check element display on screen    ${GLOBAL_SCREENING_QUESTION_DISABLED}
    Delete Skip Next Question data tests after run test case    ${conversation_name}


Check delete the next question when the current question has Skip Next question function in Candidate Journey (OL-T13129)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
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


Verify New Skip Next Question flow when starting Candidate Journey conversation and selecting option matching with setting (OL-T13130)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question and confirm choice    20 years
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify New Skip Next Question flow when starting Candidate Journey conversation and selecting the option not matching with setting (OL-T13131)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13113
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question and confirm choice    more than 20 years
    Check element display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify Skip Next Question flow when starting Candidate Journey conversation and selecting multiple options matching with setting (OL-T13132)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13117
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question
    Click on option in landing page    more than 20 years
    Click on option in landing page    20 years
    Click on option in landing page    at least 20 years
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify Skip Next Question flow when starting Candidate Journey conversation and selecting multiple options not matching with setting (OL-T13133)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13117
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Check element display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify Skip Next Question flow when starting Candidate Journey conversation and input text matching with setting (OL-T13134)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13111
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question
    Input text and send message    Yes
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify Skip Next Question flow when starting Candidate Journey conversation and input text not matching with setting (OL-T13135)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13111
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question
    Input text and send message    ABC
    Check element display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}


Verify Skip Next Question flow when starting Candidate Journey with OR in Skip Next Question builder (OL-T13136)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${conversation_name} =    Add Single conversation    Candidate Journey
    Go to conversation builder
    Find and go to conversation detail    ${conversation_name}
    OL-T13118
    ${site_name} =    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input addition question and confirm choice    20 years
    Check element not display on screen    Your like?
    Delete Skip Next Question data tests after run test case    ${conversation_name}    ${site_name}

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
