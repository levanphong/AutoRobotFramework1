*** Settings ***
Resource            ../../../../drivers/driver_chrome.robot
Resource            ../../../../data_tests/conversation/common_features/skip_next_question_data_tests.robot
Resource            ../../../../pages/conversation_builder_page.robot
Resource            ../../../../pages/conversation_page.robot
Resource            ../../../../pages/web_management_page.robot

*** Keywords ***
Run the landing site/widget site
    [Arguments]    ${site_type}    ${conversation_name}
    Run keyword and ignore error    Public the conversation
    ${site_name} =    Create landing site/widget site    ${site_type}    conversation_name=${conversation_name}
    ${url} =    Open landing site and get url    ${site_name}
    Go to    ${url}
    Input common info of candidate for Web Management
    [Return]    ${site_name}

Input common info of candidate for Web Management
    ${employee_name} =    generate candidate name
    Input text and send message     ${employee_name.full_name}
    ${mobile_question_ask} =    Run keyword and return status   Verify Olivia conversation message display  ${REPROMPT_PHONE_MESSAGE_1}
    ${phone_number} =   Generate Random String      6    [NUMBERS]
    Run keyword if  '${mobile_question_ask}' == 'True'    Input text and send message     +12025${phone_number}

Click on option in landing page
    [Arguments]    ${item}
    ${item_locator} =    Format string    ${CONVERSATION_CHOICE_BUTTON}    ${item}
    Click at    ${item_locator}

Input addition question
   ${additional_question} =    run keyword and return status    Check element display on screen
   ...    Please select one of the following areas of interest:
   IF    '${additional_question}'=='True'
       Input text and send message    1
       Wait with medium time
   END

Run the event site
    [Arguments]    ${conversation_name}
    Public the conversation
    ${url} =    Assign the conversation to the Event Landing page site    ${conversation_name}
    Go to    ${url}
    Input common info of candidate for Events

Input common info of candidate for Events
    Click at    Register for Event
    Check element display on screen  ${SHADOW_DOM_EVENT_WIDGET_CONVERSATION_LAYOUT}
    ${candidate_fname} =    Generate random name only text    Candidate
    ${candidate_name} =    Set variable    ${candidate_fname} Test
    Input candidate name twice for Shadow Root    ${candidate_name}
    Input text for widget site    ${CONST_PHONE_NUMBER}
    ${additional_question} =    run keyword and return status    check message widget site response correct    Please select one of the following areas of interest:
    IF    '${additional_question}'=='True'
        Input text for widget site    1
    END

Click on option in landing page for Events
    [Arguments]    ${item}
    ${item_locator} =    Format string    ${SHADOW_DOM_CONVERSATION_CHOICE_BUTTON}    ${item}
    Click at    ${item_locator}

Check Like question not display
    Run keyword and ignore error    Check element display on screen    ${WIDGET_LOADING_MESSAGE}    wait_time=30s
    ${is_final_message} =   Run keyword and return status   Check element not display on screen  ${WIDGET_LOADING_MESSAGE}    wait_time=30s
    # Double-check in case multiple message reply in the end of Conversation
    IF  '${is_final_message}' == 'False'
        Run keyword and ignore error    Check element display on screen    ${WIDGET_LOADING_MESSAGE}    wait_time=30s
        Check element not display on screen  ${WIDGET_LOADING_MESSAGE}    wait_time=30s
    END
    ${is_final_question_correct} =      Run keyword and return status   check message widget site response correct    Your like?
    Run keyword unless  '${is_final_question_correct}' == 'False'   Fail

Input addition question and confirm choice
    [Arguments]   ${choice}
    Input addition question
    Click on option in landing page    ${choice}
    Click by JS    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}

