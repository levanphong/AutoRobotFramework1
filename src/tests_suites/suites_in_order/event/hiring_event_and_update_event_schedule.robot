*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../data_tests/event/hiring_event_and_update_event_schedule.robot
Resource            ../../../pages/event_page.robot
Resource            ../../../pages/message_customize_page.robot
Resource            ../../../pages/ratings_page.robot
Resource            ../../../pages/conversation_page.robot
Variables           ../../../constants/ConversationConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${event_user_rating_test}           event_user_rating_test
${event_candidate_rating_test}      event_candidate_rating_test
${event_rating_conversation}        event_rating_conversation

*** Test Cases ***
Verify candidate/user receives correct notification after updated message text in Message Custom (OL-T8386, OL-T8387)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${email_subject} =   Change Event Canceled message
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=    Set Overview step    Virtual    Single Event
    &{session_info}=    Set Schedule step    Virtual Chat Booth
    Set Registration step
    Set Tools step
    ${candidate_name}=  Manually add a Candidate to Event
    Cancel the Event
    Verify user has received the email       ${email_subject}      ${candidate_name}   CANCEL_SCHEDULE


Verify Event Interview Complete of Event Rating is only available when the user creates Interview Session within the event schedule (OL-T8343)
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
    ${candidate_name} =     Finish register the event
    Verify the Event conversation with Olivia     ${event_name}   ${candidate_name}
    Enable Client Setup for Event Rating    Events

*** Keywords ***
Change Event Canceled message
    ${message}=     Generate random name     Event has been canceled for automation test
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    ${CANDIDATE_TAB_ON_DIALOG}
    Click at    ${EVENT_STATE_ITEM}    Event Canceled
    Click at    ${EMAIL_TAB}
    Clear element text with keys    ${EVENT_CANCELED_MESS_BOX}     Hiring Events - Virtual Chat Booth Only
    Simulate Input  ${EVENT_CANCELED_MESS_BOX}     ${message}     Hiring Events - Virtual Chat Booth Only
    Click at  ${SAVE_BUTTON_MESSAGE}    slow_down=2s
    Wait with short time
    [Return]    ${message}

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

Verify the Event conversation with Olivia
    [Arguments]    ${event_name}    ${candidate_name}
    ${verify_message} =     Format String   ${EVENT_NAME_QUESTION}  company_name=${COMPANY_EVENT}   event_name=${event_name}
    Check message widget site response correct     ${verify_message}
    ${verify_message} =     Format String   ${EVENT_MOBILE_QUESTION}  candidate_name=${candidate_name}
    Check message widget site response correct     ${verify_message}
    ${verify_message} =     Format String   ${EVENT_EMAIL_QUESTION}  candidate_name=${candidate_name}
    Check message widget site response correct     ${verify_message}
    ${verify_message} =     Format String   ${EVENT_CONTACT_QUESTION}
    Check message widget site response correct     ${verify_message}
    ${verify_message} =     Format String   ${EVENT_REGISTER_SUCCESS_MESSAGE}  candidate_name=${candidate_name}   event_name=${event_name}
    Check message widget site response correct     ${verify_message}
    ${verify_message} =     Format String   ${EVENT_PHONE_INTERVIEW_DETAIL_MESSAGE}  company_name=${COMPANY_EVENT}  candidate_name=${candidate_name}   event_name=${event_name}
    Check message widget site response correct     ${verify_message}
    ${verify_message} =     Format String   ${EVENT_FEEDBACK_MESSAGE}  candidate_name=${candidate_name}
    Check message widget site response correct     ${verify_message}    5m
    ${verify_message} =     Format String   ${EVENT_RATING_QUESTION}
    Check message widget site response correct     ${verify_message}    5m
