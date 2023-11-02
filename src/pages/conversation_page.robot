*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/conversation_locator.py

*** Keywords ***
#Landing site and company site
go to company site company franchise on
    ${company_name} =    set variable    TestAutomationFranchiseOn
    IF    '${env}' == 'STG' or 'LTS_STG'
        ${company_name} =    set variable    ${company_name}1
    END
    ${url_site} =    format string    {}/co/{}    ${base_url}    ${company_name}
    go to    ${url_site}

Candidate input to landing site
    [Arguments]    ${message}
    Input into    ${CONVERSATION_INPUT_TEXTBOX}    ${message}
    Click at    ${CONVERSATION_SEND_BUTTON}
    Check element display on screen  ${CONVERSATION_LAST_CANDIDATE_MESSAGE}    ${message}
    Capture page screenshot
    Wait for Olivia reply

Candidate input to scheduling conversation
    [Arguments]     ${message}
    input into  ${CONVERSATION_INPUT_TEXTBOX}     ${message}
    Click at    ${CONVERSATION_SEND_BUTTON}     slow_down=2s

Verify Olivia conversation message display
    [Arguments]    ${message}
    Wait for Olivia reply
    Check element display on screen    ${message}

Wait for Olivia reply
    Run keyword and ignore error    Wait Until Element Is Visible   ${CONVERSATION_AI_LOADER_MESSAGE}    15s
    Wait until element is not visible    ${CONVERSATION_AI_LOADER_MESSAGE}
    capture page screenshot

Play/pause video
    [Arguments]    ${type}
    Wait for video full load
    ${status} =   get element attribute   ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}    aria-label
    IF  '${type}' == 'Play'
        Run keyword if   '${status}' == 'Play'   Click at    ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
        #   Check video still running
        ${current_time} =  Get text and format text  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}
        Wait with short time
        ${current_time_after} =  Get text and format text  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}
        should not be equal as strings   ${current_time}     ${current_time_after}
        Capture page screenshot
    ELSE
        Run keyword if   '${status}' == 'Pause'   Click at    ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
        #   Check video is pause
        ${current_time} =  Get text and format text  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}
        Capture page screenshot
        Wait with short time
        ${current_time_after} =  Get text and format text  ${CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT}
        should be equal as strings   ${current_time}     ${current_time_after}
        Capture page screenshot
    END

Turn on/off Sound
    [Arguments]    ${type}
    Wait for video full load
    ${volumn_status} =   get element attribute   ${CONVERSATION_VIDEO_PLAYER_SOUND_VOLUMN_BAR}    aria-valuenow
    ${type_string}=    Evaluate     type($volumn_status).__name__
    IF  '${type}' == 'On'
        Run Keyword iF  int(${volumn_status}) == 0   Click at    ${CONVERSATION_VIDEO_PLAYER_SOUND_BUTTON}
        #   Check video still running
        ${volumn_status_after} =   get element attribute   ${CONVERSATION_VIDEO_PLAYER_SOUND_VOLUMN_BAR}    aria-valuenow
        should not be equal as integers    0     ${volumn_status_after}
        Capture page screenshot
    ELSE
        Run Keyword iF  int(${volumn_status}) > 0   Click at    ${CONVERSATION_VIDEO_PLAYER_SOUND_BUTTON}
        #   Check video still running
        ${volumn_status_after} =   get element attribute   ${CONVERSATION_VIDEO_PLAYER_SOUND_VOLUMN_BAR}    aria-valuenow
        should be equal as strings   0     ${volumn_status_after}
        Capture page screenshot
    END

Wait for video full load
    [Arguments]     ${max_wait_time_amount}=30
    #   wait time will max at ${max_wait_time_amount}
    Wait for the element to fully load  ${CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON}
    ${duration_time} =  Get text and format text  ${CONVERSATION_VIDEO_PLAYER_DURATION_TIME_TEXT}
    IF    '${duration_time}' == '00:00'
        FOR     ${count}    IN RANGE  ${max_wait_time_amount}
            Sleep  1s
            ${duration_time} =  Get text and format text  ${CONVERSATION_VIDEO_PLAYER_DURATION_TIME_TEXT}
            Exit For Loop If   '${duration_time}' != '00:00'
        END
    END

Go to conversation and show jobs
    [Arguments]  ${url}   ${job_req_id}=None    ${expected_welcome_ms}=${SHOW_JOB_SEARCH_MESSAGE}
    Go to   ${url}
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${expected_welcome_ms}
    ${is_match} =   Run keyword and return status    Should match regexp  ${expected_welcome_ms}  ${SHOW_JOB_SEARCH_MESSAGE}
    Run keyword if  ${is_match}    Check element display on screen     ${CONVERSATION_LIST_VIEW_TABLE}   wait_time=5s
    #   Chat by enter job title or location
    IF   '${job_req_id}' == 'None'
        Candidate input to landing site     ${ANY_JOB_ANY_WHERE}
    ELSE
        Candidate input to landing site     ${job_req_id}
    END

Go to job conversation and apply jobs
    [Arguments]  ${url}
    Go to   ${url}
    Wait With Short Time
    Wait for Olivia reply on widget
    Click At    ${POSTING_JOB_URL_REQUIREMENT_ACCEPT_BUTTON}
    Check Message Widget Site Response Correct    ${THANK_YOU_FOR_ACCEPTING}

Select a job on list view
    [Arguments]  ${job_title}=None
    Check element display on screen  ${CONVERSATION_LIST_VIEW_TABLE}
    IF   '${job_title}' == 'None'
        CLick at  ${CONVERSATION_LIST_VIEW_FIRST_FIELD}
    ELSE
        Click at  ${CONVERSATION_LIST_VIEW_ITEM}    ${job_title}
    END
    Check element display on screen  ${CONVERSATION_SELECTED_JOB_APPLY_BUTTON}

Get latest message of Olivia in Landing site
    Wait for Olivia reply
    ${latest_olivia_msg} =   Get text and format text  ${CONVERSATION_LATEST_MESSAGE}
    [Return]    ${latest_olivia_msg}

Verify last message content should be
    [Arguments]  ${message}  ${dynamic_message}=None  ${site_type}=Landing Site
    IF  '${site_type}' == 'Landing Site'
        ${latest_message} =  Get latest message of Olivia in Landing site
    ELSE
        ${latest_message} =  Get latest message of Olivia in Shadow Root
    END
    IF  '${dynamic_message}' != 'None'
        ${message} =     Format String   ${message}  ${dynamic_message}
    END
    Should contain    ${latest_message}    ${message}

Verify AI message when asking about email in
    [Arguments]  ${site_type}
    @{list_meseage} =  Create List  ${REPROMPT_EMAIL_MESSAGE_1}  ${REPROMPT_EMAIL_MESSAGE_2}  ${REPROMPT_EMAIL_MESSAGE_3}
    ...  ${REPROMPT_EMAIL_MESSAGE_4}  ${REPROMPT_EMAIL_MESSAGE_5}  ${REPROMPT_EMAIL_MESSAGE_6}
    IF  '${site_type}' == 'Landing Site'
        ${latest_message} =  Get latest message of Olivia in Landing site
    ELSE
        ${latest_message} =  Get latest message of Olivia in Shadow Root
    END
    ${check} =  Set Variable  False
    FOR   ${message}  IN  @{list_meseage}
        ${is_correctly} =  Run keyword and return status  Should contain   ${latest_message}   ${message}
        IF   ${is_correctly}
            ${check} =  Set variable  True
        END
        Exit for loop if  ${check}
    END
    Run keyword if  ${check} != True  Fail    msg=Won't match ${latest_message}

Verify AI message when asking about phonenumber in
    [Arguments]  ${site_type}
    @{list_meseage} =  Create List  ${REPROMPT_PHONE_MESSAGE_1}  ${REPROMPT_PHONE_MESSAGE_2}
    IF  '${site_type}' == 'Landing Site'
        ${latest_message} =  Get latest message of Olivia in Landing site
    ELSE
        ${latest_message} =  Get latest message of Olivia in Shadow Root
    END
    ${check} =  Set Variable  False
    FOR   ${message}  IN  @{list_meseage}
        ${is_correctly} =  Run keyword and return status  Should contain   ${latest_message}   ${message}
        IF   ${is_correctly}
            ${check} =  Set variable  True
        END
        Exit for loop if  ${check}
    END
    Run keyword if  ${check} != True  Fail    msg=Won't match ${latest_message}

Verify AI message when asking about name in
    [Arguments]  ${site_type}
    @{list_meseage} =  Create List  ${REPROMPT_NAME_MESSAGE_1}  ${REPROMPT_NAME_MESSAGE_2}  ${REPROMPT_NAME_MESSAGE_3}
    ...  ${REPROMPT_NAME_MESSAGE_4}  ${REPROMPT_NAME_MESSAGE_5}  ${REPROMPT_NAME_MESSAGE_6}  ${REPROMPT_NAME_MESSAGE_7}
    ...  ${REPROMPT_NAME_MESSAGE_8}  ${REPROMPT_NAME_MESSAGE_9}  ${REPROMPT_NAME_MESSAGE_10}   ${REPROMPT_NAME_MESSAGE_11}
    IF  '${site_type}' == 'Landing Site'
        ${latest_message} =  Get latest message of Olivia in Landing site
    ELSE
        ${latest_message} =  Get latest message of Olivia in Shadow Root
    END
    ${check} =  Set Variable  False
    FOR   ${message}  IN  @{list_meseage}
        ${is_correctly} =  Run keyword and return status  Should match regexp   ${latest_message}   ${message}
        IF   ${is_correctly}
            ${check} =  Set variable  True
        END
        Exit for loop if  ${check}
    END
    Run keyword if  ${check} != True  Fail    msg=Won't match ${latest_message}

Verify AI message when asking about location in
    [Arguments]  ${site_type}
    @{list_meseage} =  Create List  ${REPROMPT_LOCATION_MESSAGE_1}  ${REPROMPT_LOCATION_MESSAGE_2}    ${REPROMPT_LOCATION_MESSAGE_3}
    IF  '${site_type}' == 'Landing Site'
        ${latest_message} =  Get latest message of Olivia in Landing site
    ELSE
        ${latest_message} =  Get latest message of Olivia in Shadow Root
    END
    ${check} =  Set Variable  False
    FOR   ${message}  IN  @{list_meseage}
        ${is_correctly} =  Run keyword and return status  Should contain   ${latest_message}   ${message}
        IF   ${is_correctly}
            ${check} =  Set variable  True
        END
        Exit for loop if  ${check}
    END
    Run keyword if  ${check} != True  Fail    msg=Won't match ${latest_message}

Verify AI reprompt message when asking
    [Arguments]    @{list_reprompt_messages}    ${site_type}=Landing Site
    IF    '${site_type}' == 'Landing Site'
        ${reprompt} =    Get latest message of Olivia in Landing site
    ELSE
        ${reprompt} =    Get latest message of Olivia in Shadow Root
    END
    ${is_matched} =    Set Variable    False
    FOR    ${expected_reprompt}    IN    @{list_reprompt_messages}
        ${is_contained} =   Run Keyword And Return Status   Should Contain    ${reprompt}  ${expected_reprompt}
        IF  '${is_contained}' == 'True'
            ${is_matched} =    Set Variable    True
            Exit For Loop
        END
    END
    Run keyword if  ${is_matched} != True  Fail    msg=Won't match ${reprompt}

Verify AI latest message using regexp
    [Arguments]  ${message}  ${dynamic_message}=None  ${site_type}=Landing Site    ${index}=0
    IF  '${site_type}' == 'Landing Site'
        ${latest_message} =  Get latest message of Olivia in Landing site
    ELSE
        ${latest_message} =  Get latest message of Olivia in Shadow Root    ${index}
    END
    IF  '${dynamic_message}' != 'None'
        ${message} =     Format String   ${message}  ${dynamic_message}
    END
    Should match regexp    ${latest_message}    ${message}

Apply job on landing site
    [Arguments]  ${job_title}
    Click at  ${CONVERSATION_LIST_VIEW_ITEM}    ${job_title}
    Click at  ${CONVERSATION_APPLY_NOW_BUTTON}
    Check element not display on screen  ${CONVERSATION_APPLY_NOW_LOADING_ICON}

#Apply to job at location

apply job
    [Arguments]    ${job}    ${location}
    ${locator} =    Format String    ${JOB_SECTION}    ${job}    ${location}
    Scroll to element by JS    ${locator}
    Click at    ${locator}
    click by js    ${CONVERSATION_APPLY_NOW_BUTTON}
    Verify Olivia conversation message display    ${I_CAN_HELP_YOU_TO_THE}

#Widget shadow dom

Apply a job on widget
    Click at  ${SHADOW_DOM_LIST_VIEW_TABLE}
    Click at  ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    Check element not display on screen  ${SHADOW_DOM_SELECTED_JOB_APPLY_LOADING_ICON}
    Wait for Olivia reply on widget

Input text for widget site
    [Arguments]    ${message}
    wait_shadow_root_conversation_fully_load
    input into    ${INPUT_WIDGET}    ${message}
    Click at    ${SEND_BUTTON_CONV}
    ${latest_candidate_msg} =   Get latest message in Shadow Root
    IF  """${latest_candidate_msg}""" != """${message}"""
        input into    ${INPUT_WIDGET}    ${message}
        Click at    ${SEND_BUTTON_CONV}
        #   Check message sent correctly
        ${latest_candidate_msg} =   Get latest message in Shadow Root
        Should contain  ${latest_candidate_msg}  ${message}
    END
    Wait for Olivia reply on widget

check message widget site response correct
    [Arguments]    ${expected_message}  ${wait_time}=15s
    Wait Until Element Contains     ${MESSAGE_CONVERSATION}     ${expected_message}     ${wait_time}
    Element Should Contain  ${MESSAGE_CONVERSATION}     ${expected_message}

Click on option in conversation
    [Arguments]    ${item}
    ${item_locator} =    Format string    ${SHADOW_DOM_CONVERSATION_CHOICE_BUTTON}    ${item}
    Click at    ${item_locator}
    Click by JS    ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}

Select time for interview with multiple days
    Check element display on screen      Interview 1
    Check element display on screen      Interview 2
    Click at    Interview 1
    Click at    ${TIME_OPTIONS_LAST}
    Click at    Interview 2
    Click at    ${TIME_OPTIONS_LAST}
    Click at    ${SCHEDULE_CONFIRM_BUTTON}

Input candidate name twice for Shadow Root
    [Arguments]    ${candidate_name}
    Input text for widget site    ${candidate_name}
    ${latest_olivia_msg} =   Get latest message of Olivia in Shadow Root
    ${ask_name_again} =     Evaluate   "last name" in """${latest_olivia_msg}"""
    IF    '${ask_name_again}' == 'True'
        Input text for widget site    ${candidate_name}
    END

Get latest message of Olivia in Shadow Root
    [Arguments]    ${index}=0
    IF    ${index} > 0
        ${latest_olivia_msg} =   Get text and format text  ${MESSAGE_FROM_OLIVIA_BY_INDEX}    ${index}
    ELSE
        Wait Until Element Is Visible    ${LATEST_MESSAGE_FROM_OLIVIA}
        ${latest_olivia_msg} =   Get text and format text  ${LATEST_MESSAGE_FROM_OLIVIA}
    END
    [Return]    ${latest_olivia_msg}

Get first message of Olivia in Shadow Root
    Wait for Olivia reply on widget
    ${first_olivia_msg} =   Get text and format text  ${FIRST_MESSAGE}
    [Return]    ${first_olivia_msg}

Get latest message in Shadow Root
    ${is_reply_message_display} =    Run Keyword And Return Status    Check element display on screen    ${LATEST_MESSAGE}
    Run Keyword Unless    ${is_reply_message_display}    Wait with short time
    ${latest_msg} =   Get text and format text  ${LATEST_MESSAGE}
    [Return]    ${latest_msg}

Input candidate name twice
    [Arguments]    ${candidate_name}
    Check element display on screen  ${CONVERSATION_LATEST_MESSAGE}
    Candidate input to landing site    ${candidate_name}
    Wait for Olivia reply
    ${is_correct_name} =    Get text and format text  ${CONVERSATION_CANDIDATE_NAME_CIRCLE}
    IF     "${is_correct_name}" == "${EMPTY}"
        Candidate input to landing site    ${candidate_name}
    END

Input text and send message
    [Arguments]    ${text}
    Wait for Olivia reply
    Input into    ${CONVERSATION_INPUT_TEXTBOX}    ${text}
    Click at    ${CONVERSATION_SEND_BUTTON}

Input text and send message without wait
    [Arguments]    ${text}
    Input into    ${CONVERSATION_INPUT_TEXTBOX}    ${text}
    Click at    ${CONVERSATION_SEND_BUTTON}

Get status of sending random phone number success
    ${reprompt} =    Get latest message of Olivia in Landing site
    ${status} =    Set Variable    success
    ${invalid} =    Run Keyword And Return Status    Should Match Regexp    ${reprompt}    ${REPROMPT_COMMUNICATION_MESSAGE_5}
    IF    ${invalid}
        ${status} =    Set Variable    invalid
    ELSE
        ${req_verify} =    Run Keyword And Return Status    Should Match Regexp    ${reprompt}    ${REPROMPT_VERIFY_IDENTITY_MESSAGE_1}
        IF    ${req_verify}
            ${status} =    Set Variable    req_verify
        END
    END
    Capture Page Screenshot
    [Return]    ${status}

Send random phone number
    @{messages_theirs} =    Get list text and format list text    ${CONVERSATION_MESSAGES_THEIRS}
    ${phone_number} =    Generate random phone number
    Input text and send message without wait    ${phone_number}
    ${status} =    Get status of sending random phone number success
    FOR    ${_}    IN RANGE    2
        IF  '${status}' == 'success'
            Exit For Loop
        ELSE IF  '${status}' == 'invalid'
            ${phone_number} =    Generate random phone number
            Input text and send message without wait    ${phone_number}
            ${status} =    Get status of sending random phone number success
        ELSE IF  '${status}' == 'req_verify'
            Input text and send message without wait    new
            FOR    ${msg}    IN    @{messages_theirs}
                Input text and send message    ${msg}
            END
            ${phone_number} =    Generate random phone number
            Input text and send message    ${phone_number}
            ${status} =    Get status of sending random phone number success
        END
    END
    [Return]    ${phone_number}

Upload video for Olivia Recorded Interviews
    [Arguments]     ${video_path}
    check element display on screen     This is sample question?
    capture page screenshot
    ${path_image} =    get_path_upload_video_path    ${video_path}
    ${element} =    Get Webelement    ${CONVERSATION_INPUT_VIDEO}
    #delete class name of tagname
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('class', '')
    ...    ARGUMENTS    ${element}
    #delete css style of tagname
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style', '');
    ...    ARGUMENTS    ${element}
    Input into    ${CONVERSATION_INPUT_VIDEO}    ${path_image}
    capture page screenshot

Input information for candidate in event conversation
    [Arguments]    ${company_name}      ${event_name}       ${is_spam_email}=True
    Check element display on screen    ${REGISTER_EVENT_IN_PROGRESS}
    ${verify_message} =     Format String   ${EVENT_NAME_QUESTION}  company_name=${company_name}   event_name=${event_name}
    Check message widget site response correct   ${verify_message}
    ${candidate_info} =      Generate candidate name
    Input text for widget site    ${candidate_info.full_name}
    ${verify_message} =     Format String   ${EVENT_MOBILE_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    Input text for widget site    ${CONST_PHONE_NUMBER}
    ${verify_message} =     Format String   ${EVENT_EMAIL_QUESTION}  candidate_name=${candidate_info.first_name}
    Check message widget site response correct     ${verify_message}
    &{email_info} =    Get email for testing    ${is_spam_email}
    Input text for widget site    ${email_info.email}
    Check message widget site response correct    ${ASK_AGE}
    Input text for widget site    30
    Check message widget site response correct    ${EVENT_CONTACT_QUESTION}
    Click on option in conversation    Email Only
    Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    ${candidate_info.email} =   Set variable    ${email_info.email}
    [Return]    ${candidate_info}

Get widget conversation link
    [Arguments]  ${widget_title}
    ${url} =  Set variable   https://${DOMAIN_SECURITY}/${widget_title}_${env}.html
    [Return]  ${url}

Wait for Olivia reply on widget
    Run keyword and ignore error   Wait Until Element Is Visible    ${WIDGET_LOADING_MESSAGE}    5s
    Wait Until Element Is Not Visible  ${WIDGET_LOADING_MESSAGE}
    Run keyword and ignore error   Wait Until Element Is Visible    ${WIDGET_FIRST_LOADING_MESSAGE}    2s
    Wait Until Element Is Not Visible  ${WIDGET_FIRST_LOADING_MESSAGE}

Check job display correct by job search parameter
    [Arguments]     ${expected_text}
    FOR   ${index}    IN RANGE      1   21
        ${text_reresult}=      Get text and format text     ${CONVERSATION_LOCATION_TWENTY_JOB}    ${index}
        Should be equal as strings    ${text_reresult}      ${expected_text}
    END
    capture page screenshot

Check location(s) display correctly in selected job
    [Arguments]     ${expected_text}
    ${type} =   Evaluate    type($expected_text).__name__
    IF  '${type}' == 'list'
        Check locations display correctly in selected job    @{expected_text}
    ELSE
        Check job display correct by job search parameter    ${expected_text}
    END

Check locations display correctly in selected job
    [Arguments]     @{expected_text_list}
    FOR   ${index}    IN RANGE      1   21
        ${text_reresult} =      Get text and format text     ${CONVERSATION_LOCATION_TWENTY_JOB}    ${index}
        FOR    ${value}    IN    @{expected_text_list}
            ${do_contain} =   Run keyword and return status    Should contain    ${text_reresult}      ${value}
            Exit For Loop If    ${do_contain}
            Run Keyword If    '${value}' == '${expected_text_list}[-1]'    Fail    msg=There are jobs which are not belong to expected locations
        END
    END
    capture page screenshot

Check job displays by job feed
    [Arguments]     ${site_name}    ${company_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    ${url_landing_site}=    Get Landing Site shortened URL      ${site_name}
    Go to   ${url_landing_site}
    Wait for Olivia reply
    Check element display on screen     ${WELCOME_CANDIDATE_MESSAGE_2}      ${company_name}
    capture page screenshot
    Input text and send message     ${ANY_JOBS_ANYWHERE}
    Check element display on screen      ${RECOMMENDED_JOB_POSITION_MESSAGE}
    capture page screenshot
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Check element display on screen      ${CONVERSATION_LOCATION_TITLE_TWENTY_JOB}
    capture page screenshot
    Check job display correct by job search parameter       ${AUTOMATION_JOB_FEEDS_PROD_LOCATION}

Go to landing site
    [Arguments]  ${url}
    Go to   ${url}
    Wait for Olivia reply
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${SHOW_JOB_SEARCH_MESSAGE}
    Check element display on screen     ${CONVERSATION_LIST_VIEW_TABLE}   wait_time=5s

Upload resume on widget
    [Arguments]  ${file_path}    ${file_name}
    Wait with short time
    Choose File    ${SHADOW_DOM_UPLOAD_RESUME_INPUT}    ${file_path}
    Wait for Olivia reply on widget
    Verify text contain    ${SHADOW_DOM_UPLOADED_RESUME_LABEL}    ${file_name}

Go to widget site
    [Arguments]    ${widget_url}
    #    widget will return fail immediately without "Wait Until Element Is Visible"
    #    For loop will handle this case
    #    It wait maximun about 30s
    ${wait_time} =  Set Variable    50
    Go to   ${widget_url}
    FOR    ${index}    IN RANGE   ${wait_time}
        ${is_finished} =  Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_MESSAGE}    timeout=1s
        Run Keyword If    ${index} + 1 == ${wait_time}    Fail    msg=The AI chat box is not displayed
        Exit For Loop If    ${is_finished}
    END

Apply the first job on widget
    [Arguments]    ${total_job_search}=1
    IF    ${total_job_search} == 1
        Click at  ${SHADOW_DOM_JOB_SEARCH_RESULT_DETAILS_BUTTON}
    ELSE
        Click at  ${SHADOW_DOM_FIRST_JOB_ON_LIST_VIEW}
    END
    Click at  ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    Check element not display on screen  ${SHADOW_DOM_SELECTED_JOB_APPLY_LOADING_ICON}
    Wait for Olivia reply on widget

Check term dialog is displayed
    Wait Until Element Contains     ${SHADOW_DOM_TERM_BODY_TEXT}    ${TERM_MESSAGE}     15s
    Element Should Contain  ${SHADOW_DOM_TERM_BODY_TEXT}     ${TERM_MESSAGE}
    Check element display on screen     ${SHADOW_DOM_TERM_ACCEPT_BUTTON}
    Check element display on screen     ${SHADOW_DOM_TERM_DECLINE_BUTTON}

Accept GDPR modal in widget site
    Check element display on screen    ${SHADOW_DOM_GDPR_MODAL_ACCEPT_BUTTON}
    Click at    ${SHADOW_DOM_GDPR_MODAL_ACCEPT_BUTTON}

Accept GDPR modal in landing site
    Check element display on screen    ${GDPR_MODAL_ACCEPT_BUTTON}
    Click at    ${GDPR_MODAL_ACCEPT_BUTTON}
