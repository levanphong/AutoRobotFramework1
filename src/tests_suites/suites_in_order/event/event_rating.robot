*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../data_tests/event/event_rating.robot
Resource            ../../../pages/event_page.robot
Resource            ../../../pages/ratings_page.robot
Resource            ../../../pages/conversation_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${event_user_rating_test}           event_user_rating_test
${event_candidate_rating_test}      event_candidate_rating_test
${event_candidate_rating_test_2}    event_candidate_rating_test_2
${event_rating_conversation}        event_rating_conversation

*** Test Cases ***
Verify not showing the Rating card in Event Homepage if Rating toggle is OFF in Client Setup even after added Rating for the event (OL-T5316)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Users
    Set Tools step
    Turn off Ratings for Event
    Go to Events page
    Input into    ${SEARCHING_INPUT}    ${event_name}
    Click at    ${event_name}
    Check element not display on screen    Ratings
    Enable Client Setup for Event Rating    More


Verify sending the Rating immediately after the Registration Confirmation Message is sent (OL-T5321)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Verify display text    ${LATEST_MESSAGE_FROM_OLIVIA}    auto_rating_question1. No2. Yes
    Enable Client Setup for Event Rating    Events


Verify showing correctly the result of rating in donut chart (OL-T5320)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Verify display text    ${LATEST_MESSAGE_FROM_OLIVIA}    auto_rating_question1. No2. Yes
    Go to    ${current_event_url}
    Check element display on screen    Ratings
    Verify display text    ${EVENT_RATINGS_SENT_TEXT}    1 Sent
    Enable Client Setup for Event Rating    Events


Verify showing the Candidates Rating card in Event Homepage after a rating trigger has been delivered (OL-T5317)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Verify display text    ${LATEST_MESSAGE_FROM_OLIVIA}    auto_rating_question1. No2. Yes
    Input text for widget site    1
    Go to    ${current_event_url}
    Check element display on screen    Overall Response Rate
    Click by JS    ${EVENT_RATINGS_OVERALL_SLIDE_RIGHT_ICON}
    Check element display on screen    Overall Satisfaction Rate
    Enable Client Setup for Event Rating    Events


Verify the Rating is sent to candidates incase their contact method are both Email and SMS (OL-T5336)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    ${candidate_name} =    Finish register the event
    Verify user has received the email    Rating Request    ${candidate_name}
    Enable Client Setup for Event Rating    Events


Verify the Rating is sent to candidates incase their contact method is only Email or SMS (OL-T5335)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    ${candidate_name} =    Finish register the event
    Verify user has received the email    Rating Request    ${candidate_name}
    Enable Client Setup for Event Rating    Events


Verify the user can click through on a carousel at Rating card in Event Homepage (OL-T5319)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Verify display text    ${LATEST_MESSAGE_FROM_OLIVIA}    auto_rating_question1. No2. Yes
    Input text for widget site    1
    Go to    ${current_event_url}
    Check element display on screen    Overall Response Rate
    Click by JS    ${EVENT_RATINGS_OVERALL_SLIDE_RIGHT_ICON}
    Check element display on screen    Overall Satisfaction Rate
    Click by JS    ${EVENT_RATINGS_OVERALL_SLIDE_LEFT_ICON}
    Check element display on screen    Overall Response Rate
    Enable Client Setup for Event Rating    Events


Verify the user can edit the Rating if the Delivery is Immediately and candidates have been sent that rating (OL-T5337)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Verify display text    ${LATEST_MESSAGE_FROM_OLIVIA}    auto_rating_question1. No2. Yes
    Input text for widget site    1
    Go to    ${current_event_url}
    Click at    ${SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_TRIGGER_TITLE}    Event Registration (Conversation Complete)
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${event_candidate_rating_test_2}
    Enable Client Setup for Event Rating    Events


Verify the user can update the Rating Trigger (OL-T5312)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Verify display text    ${LATEST_MESSAGE_FROM_OLIVIA}    auto_rating_question1. No2. Yes
    Input text for widget site    1
    Go to    ${current_event_url}
    Click at    ${SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_TRIGGER_TITLE}    Event Registration (Conversation Complete)
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${event_candidate_rating_test_2}
    Click at    ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_TITLE}    Event Registration (Conversation Complete)
    Verify display text    ${EVENT_RATINGS_TRIGGER_DROPDOWN}    ${event_candidate_rating_test_2}    Rating
    Enable Client Setup for Event Rating    Events


Verify 'Delivery' dropdown after the user selects 'Event Registration ' as Candidate Touchpoint (OL-T5304)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Registration (Conversation Complete)
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen    Immediately
    Enable Client Setup for Event Rating    Events


Verify displaying Candidate Touchpoint on the 'Select Candidate Touchpoint' modal when creating a Hiring Event (OL-T5295)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}
    ...    Event Registration (Conversation Complete)
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Interview Complete
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_CANCEL_BUTTON}
    Enable Client Setup for Event Rating    Events


Verify each touchpoint can only be selected once for per event (OL-T5300)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Turn off Event Job for Event
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Registration (Conversation Complete)
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Interview Complete
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Check element not display on screen  ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}  Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_CANCEL_BUTTON}
    Enable Client Setup for Event Rating    Events

*** Keywords ***
Add an Rating Trigger in Tools step
    [Arguments]    ${audience_tab}    ${touchpoint}=Start Time    ${delivery}=48 Hours
    # ${audience_tab} can be Users/Candidates
    IF    '${audience_tab}' == 'Users'
        ${rating_name} =    Set variable    ${event_user_rating_test}
    ELSE
        ${rating_name} =    Set variable    ${event_candidate_rating_test}
    END
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    ${audience_tab}
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    ${touchpoint}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${delivery}
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${rating_name}
    Click at    ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_SAVE_BUTTON}
