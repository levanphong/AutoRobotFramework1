*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/event_page.robot
Resource        ../pages/conversation_page.robot
Resource        ../pages/event_creating_page.robot
Variables       ../locators/message_customize_locators.py
Variables       ../locators/conversation_locator.py

*** Variables ***
${job_search_interested_in}     What opportunity are you most interested in?
${any_job_us}                   any job in us
${first_name_last_name}         can you please provide me with your first and last name?
${ask_email}                    Great! Can you please provide me with your email address as well?

*** Keywords ***
Check attribute list is display
    [Arguments]    ${attribute_name}
    ${message_token_loc} =    format string    ${TOKEN_MESSAGE}    ${attribute_name}
    check element display on screen    ${message_token_loc}

Check Close Confirm modal and update message not saved
    [Arguments]    ${message}
    check element not display on screen    ${CANCEL_BTN_MESS_CUSTOM}
    ${text_current} =    get text    ${MESSAGE_BOX}
    SHOULD NOT BE EQUAL    ${text_current}    ${message}

Check message is remove
    [Arguments]    ${message_order}
    ${minus_number} =    Evaluate    int(${message_order}) - 1
    ${locator_order} =    format string    ${MESS_ACTIVE_MESSAGE_CUS_DYNAMIC_TEXT}    ${minus_number}
    ${locator_removed} =    format string    ${MESS_ACTIVE_MESSAGE_CUS_DYNAMIC_TEXT}    ${message_order}
    check element display on screen    ${locator_order}
    check element not display on screen    ${locator_removed}

Check message is still remain on screen
    [Arguments]    ${message_order}
    ${locator} =    format string    ${MESS_ACTIVE_MESSAGE_CUS_DYNAMIC_TEXT}    ${message_order}
    check element display on screen    ${locator}

start job search conversation via Landing site
    [Arguments]    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    go to    ${url_site}
    Verify Olivia conversation message display    ${job_search_interested_in}
    Candidate input to landing site    1
    Verify Olivia conversation message display    Where are you looking to work?
    Candidate input to landing site    ${ANY_JOB_IN_US}
    Verify Olivia conversation message display    Great! Take a look at the
    Check element display on screen    Recommended Jobs
    ${is_job_displayed}=   Run Keyword And Return Status    Check element display on screen   ${job_name}   wait_time=5s
    IF    '${is_job_displayed}' == 'True'
        Click at  ${job_name}
    ELSE
        Click at    See All
        Click at    ${job_name}
    END
    Click at    ${CONVERSATION_APPLY_NOW_BUTTON}
    Verify Olivia conversation message display    ${first_name_last_name}
    Input candidate name twice    ${candidate_name}
    Verify Olivia conversation message display    ${ask_email}
    Candidate input to landing site    ${email}

Candidate starts job search conversation via Landing site
    [Arguments]    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    start job search conversation via Landing site    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    Verify Olivia conversation message display    How old are you?
    Candidate input to landing site    20
    Verify Olivia conversation message display    We will review your information shortly and reach out to you within three business days.

Candidate starts apply job conversation via job apply link
    [Arguments]    ${url_site}    ${candidate_name}    ${email}     ${age}=18
    Go to job conversation and apply jobs           ${url_site}
    Input Text For Widget Site                      ${candidate_name}
    # Check Message Widget Site Response Correct      ${REPROMPT_EMAIL_MESSAGE_6}                     wait_time=20
    Verify last message content should be    ${REPROMPT_EMAIL_MESSAGE_6}    site_type=Widget
    Input Text For Widget Site                      ${email}
    # Check Message Widget Site Response Correct      ${ASK_AGE}              wait_time=20
    Verify last message content should be    ${ASK_AGE}    site_type=Widget
    Input Text For Widget Site                      ${age}
    Capture Page Screenshot

Start conversation again with input " New" in chatbox
    Candidate input to landing site    new
    Wait with medium time

Provide name,email same as one in our database
    [Arguments]    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    start job search conversation via Landing site    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    Verify Olivia conversation message display
    ...    Before you start your application, I need to verify your identity. I just sent a 6-digit code to

check get code and send to ai
    [Arguments]    ${first_name}
    ${subject} =    set variable    Verification Code
    ${verify_code} =    get verify code in email    ${subject}    ${first_name}     VERIFICATION_CODE
    Candidate input to landing site    ${verify_code}
    Verify Olivia conversation message display    How else may I assist you?custom_location_attribute

check message location attribute show
    [Arguments]    ${message}
    verify text contain    ${SCHEDULE_IN_PERSON_TEXT}    ${message}

input message box
    [Arguments]    ${locator}    ${text_into_input}
    press Keys    ${locator}    ${text_into_input}
    input text    ${locator}    ${text_into_input}

save for editting content
    Click at    ${SAVE_BUTTON_MESSAGE}      slow_down=1s
    Check element display on screen    Your changes were saved

press text for message box
    [Arguments]    ${text_into_input}
    input message box    ${MESSAGE_BOX}    ${text_into_input}

press text for input
    [Arguments]    ${locator}    ${text_into_input}
    set focus to element    ${locator}
    ${current_text} =    get text    ${locator}
    ${current_text} =    strip string    ${current_text}
    ${contains} =    Run Keyword And Return Status    should end with    ${current_text}    ${text_into_input}
    IF    '${contains}' == 'False'
        Input into    ${locator}    ${text_into_input}
        save for editting content
    END

check message and send next message
    [Arguments]    ${message}    ${anwes}
    wait with short time
    Verify Olivia conversation message display    ${message}
    Candidate input to landing site    ${anwes}

click accept button on gdpr dialog
    wait with short time
    Click on span text    Accept

The model confirm " the terms" is opened
    check element display on screen    ${CONVERSATION_ALERT_DIALOG_GDPR}
    check text display
    ...    By agreeing to these terms you allow us to collect personal information like your name, phone number, email, job interests, answers to screening questions and location.

Input location attributes into messege box
    [Arguments]    ${locator}    ${location_attributes}
    ${is_display_attr} =    Run Keyword And Return Status    Check element display on screen    ${location_attributes}      wait_time=5s
    IF    '${is_display_attr}' == 'False'
        input into    ${locator}    ${SPACE}${location_attributes}
        Press Keys    None    RETURN
        Click at    ${SAVE_BUTTON_MESSAGE}
    END

Add location attributtes for email tab
    [Arguments]    ${interview_type}    ${location_attr}
    ${email_messbox_locator} =    Format String    ${EMAIL_MESSAGE_CONTENT}    ${interview_type}
    Click at    ${EMAIL_TAB}
    Input location attributes into messege box    ${email_messbox_locator}    ${location_attr}

Add location attributtes for sms tab
    [Arguments]    ${interview_type}    ${location_attr}
    ${sms_messbox_locator} =    Format String    ${SMS_MESSAGE_CONTENT}    ${interview_type}
    Click at    ${SMS_TAB}
    Input location attributes into messege box    ${sms_messbox_locator}    ${location_attr}

Add location attributtes for web tab
    [Arguments]    ${interview_type}    ${location_attr}
    ${email_messbox_locator} =    Format String    ${EMAIL_MESSAGE_CONTENT}    ${interview_type}
    Click at    ${EMAIL_TAB}
    Input location attributes into messege box    ${email_messbox_locator}    ${location_attr}

Return origin sms message
    [Arguments]    ${interview_type}
    ${sms_messbox_locator} =    Format String    ${SMS_MESSAGE_CONTENT}    ${interview_type}
    Clear element text with keys    ${sms_messbox_locator}
    Click at    ${SAVE_BUTTON_MESSAGE}

Return origin email message
    [Arguments]    ${interview_type}
    ${email_messbox_locator} =    Format String    ${EMAIL_MESSAGE_CONTENT}    ${interview_type}
    Clear element text with keys    ${email_messbox_locator}
    Click at    ${SAVE_BUTTON_MESSAGE}

Update start day and schedule time for event
    [Arguments]    ${event_dynamic_name}
    Go to Events page
    Search event    ${event_dynamic_name}
    Click on ellipses icon on the Event Occurrence row
    Click at    ${EDIT_ICON}
    choose next day for occuracy type
    Click at    ${SCHEDULE_STEP_LABEL}
    Click at    ${UPDATE_SESSIONS_BUTTON}
    wait with short time
    Click on span text    Edit Event Sessions
    Click at    in_person_scheduled_interviews_test
    click save session button
    ${is_required} =    Run keyword and return status       Check element display on screen     Session date must be greater than current day       wait_time=5s
    IF      ${is_required}
        Click at    ${EVENT_SESSION_DATE_SELECT}
        ${next_date} =      get_date_with_month_in_full_string      1
        Click at    ${EVENT_SESSION_DATE_OPTION_SELECT}     ${next_date}
        click save session button
    END
    Click on common text last  Continue
    Set tool step and create event

Select time slot options
    ${is_existed}=      Run keyword and return status       Click by JS     ${SCHEDULE_SELECT_TIME_BUTTON}      wait_time=5s
    IF  '${is_existed}' == 'False'
        Click at    ${SCHEDULE_SELECT_TIME_OPTIONS_LAST}   slow_down=5s
        capture page screenshot
    END
