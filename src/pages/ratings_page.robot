*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/conversation_page.robot
Variables       ../locators/ratings_locators.py

*** Variables ***
@{options_theme}            Thumbs    Emoji    Stars    Text    Open-ended answer
&{audiences}                candidates=Candidates    users=Users
@{answers_value}            Bad    Fine
@{answers_star_value}       Bad    Bad 1    Good    Good 2    Happy

*** Keywords ***
Create a new Rating
    [Arguments]    ${audience}=None    ${rating_name}=None      ${theme_name}=Emoji     ${answers_value}=@{answers_value}   ${hide_label}=False     ${feed_back_toggle}=False   ${number_qs}=None   ${overall_feedback}=False
    # ${audience} can be User or Candidate
    IF    '${audience}' == 'None'
        ${audience} =    Set variable    User
    END
    IF    '${rating_name}' == 'None'
        ${rating_name} =    Generate random name    auto_rating
    END
    Go to Ratings Builder page
    Click at    ${RATINGS_PAGE_AUDIENCE_TAB}    ${audience}
    Run keyword and ignore error    Input into    ${SEARCH_FOR_RATINGS_TEXT_BOX}    ${rating_name}
    ${is_existed} =    Run Keyword and Return Status    Click at    ${RATING_IN_ROW_ECLIPSE_ICON}    ${rating_name}     wait_time=5s
    IF  "${is_existed}" == "True"
        Delete a Rating     ${audience}    ${rating_name}
    END
    Add Rating Title and Audience step   ${audience}    ${rating_name}
    # Content step
    IF      '${theme_name}' != 'Stars'
        Add Rating Content step with theme is not Stars     theme_name=${theme_name}    answers_value=${answers_value}    hide_label=${hide_label}
    ELSE
        Add Rating Content step with theme is Stars     answers_value=${answers_value}
    END
    IF    '${feed_back_toggle}' == 'True'
        Turn On    ${RATING_FEEDBACK_TOGGLE}
        ${number_answers}=   Get Length    ${answers_value}
        FOR    ${checkbox}   IN RANGE       ${number_answers}
            Click At    ${RATING_FEEDBACK_ANSWER_CHECKBOX}  ${checkbox}
        END
    END
    IF    '${number_qs}' != 'None'
        Click at    ${RATING_QUESTION_SAVE_BUTTON}
        ${add_question} =   format string    ${RATING_FEEDBACK_ADD_QUESTION}     Add Question
        click at   ${add_question}
        Add Rating Content step with theme is not Stars    theme_name=Emoji   answers_value=${answers_value}    hide_label=${hide_label}
        Click at    ${RATING_QUESTION_SAVE_BUTTON}
        click at    ${add_question}
        Add Rating Content step with theme is not Stars    theme_name=Open-ended answer    answers_value=${answers_value}    hide_label=${hide_label}
    END
    IF  '${overall_feedback}' == 'True'
        Click at    ${RATING_QUESTION_SAVE_BUTTON}
        Turn On    ${RATING_OVERALL_FEEDBACK_TOGGLE}
    END
    Rating Confirmation step
    [Return]    ${rating_name}

Add multilingual language in content step
    [Arguments]    @{language_list}     ${action}=add     ${audience}     ${rating_name}
    Search Rating      ${audience}     ${rating_name}
    Click At    ${rating_name}
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Content
    Click At    ${RATING_MULTILINGUAL_ICON}
    FOR  ${language}  IN  @{language_list}
        Input Into  ${RATING_MULTILINGUAL_SEARCH_BUTTON}    ${language}
        IF  '${action}' == 'add'
            Check The Checkbox    ${RATING_MULTILINGUAL_LANGUAGE_CHECKBOX}    ${language}
        ELSE
            Uncheck The Checkbox    ${RATING_MULTILINGUAL_LANGUAGE_CHECKBOX}    ${language}
        END
    END
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Content
    Check Element Display On Screen     Your changes have been saved.
    Capture Page Screenshot
    Click At    ${RATING_MULTILINGUAL_PLEASE_NOTE_CONFIRM_BUTTON}   Got it
    Click At    ${RATING_CONTENT_STEP_BACK_ICON}

Add Rating Title and Audience step
    [Arguments]    ${audience}=None    ${rating_name}=None
    # ${audience} can be User or Candidate
    IF    '${audience}' == 'None'
        ${audience} =    Set variable    User
    END
    IF    '${rating_name}' == 'None'
        ${rating_name} =    Generate random name    auto_rating
    END
    Click at    ${CREATE_NEW_RATING_BUTTON}
    # Title & Audience step
    Click at    ${EDIT_RATING_TITLE_ICON}
    Press Keys    None    ${rating_name}
    Click at    ${RATING_AUDIENCE_DROPDOWN}
    Click at    ${RATING_AUDIENCE_DROPDOWN_VALUE}    ${audience}
    Click at    ${ADD_RATING_NEXT_STEP_BUTTON}

Add Rating Content step with theme is Stars
    [Arguments]    ${answers_value}=@{answers_star_value}   ${rating_question}=auto_rating_question
    Check element display on screen     Introduction
    Set HTML tag content    ${QUESTION_TEXT_BOX}    ${rating_question}
    Click at    ${QUESTION_TEXT_BOX}
    Click At    ${RATING_THEME_DROPDOWN_TOGGLE}
    Click At    ${RATING_THEME_NAME_SELECT}     Stars
    FOR    ${index}    IN RANGE    5
        ${i}=       Evaluate    ${index} + 1
        Input into    ${RATING_ANSWER_TEXT_BOX}\[${i}\]    ${answers_value}[${index}]
    END
    Click at    ${RATING_QUESTION_SAVE_BUTTON}

Add Rating Content step with theme is not Stars
    [Arguments]    ${theme_name}=Emoji     ${answers_value}=@{answers_value}    ${hide_label}=False  ${rating_question}=auto_rating_question
    @{theme_two_answers}=   Create List       Thumbs    Emoji   Text
    Check element display on screen     Introduction
    Set HTML tag content    ${QUESTION_TEXT_BOX}    ${rating_question}
    Click at    ${QUESTION_TEXT_BOX}
    Click At    ${RATING_THEME_DROPDOWN_TOGGLE}
    Click At    ${RATING_THEME_NAME_SELECT}     ${theme_name}
    ${is_existed} =    Run Keyword and Return Status    Check Element Existed In List      ${theme_name}     ${theme_two_answers}
    IF      '${is_existed}' == 'True'
        Click at    ${RATING_ANSWER_TEXT_BOX}
        IF  '${hide_label}' == 'False'
            Input into    ${RATING_ANSWER_TEXT_BOX}\[1\]   ${answers_value}[0]
            Input into    ${RATING_ANSWER_TEXT_BOX}\[2\]    ${answers_value}[1]
        END
        IF   '${hide_label}' == 'True' and '${theme_name}' != 'Text'
            Click At    ${RATING_QUESTION_SETTING_ICON}
            Click At    ${RATING_QUESTION_SETTING_SELECT}   Hide Labels
        END
    END
    Click at    ${RATING_QUESTION_SAVE_BUTTON}

Turn On Rating feedback toggle
    [Arguments]    ${feedback_toggle}=True      ${answers_value}=${answers_value}
    IF    '${feedback_toggle}' == 'True'
        Turn On    ${RATING_FEEDBACK_TOGGLE}
        ${number_answers}=   Get Length    ${answers_value}
        FOR    ${checkbox}   IN RANGE       ${number_answers}
            Click At    ${RATING_FEEDBACK_ANSWER_CHECKBOX}  ${checkbox}
        END
    END
    Click at    ${RATING_QUESTION_SAVE_BUTTON}

Rating Confirmation step
    Click at    ${ADD_RATING_NEXT_STEP_BUTTON}
    Check span display      Preview
    Click at    ${ADD_RATING_NEXT_STEP_BUTTON}
    Click at    ${ADD_RATING_CONFIRM_YES_BUTTON}

Delete a Rating
    [Arguments]    ${audience}    ${rating_name}
    Go to Ratings Builder page
    Click on span text    ${audience}
    Input into    ${SEARCH_FOR_RATINGS_TEXT_BOX}    ${rating_name}
    Click at    ${RATING_IN_ROW_ECLIPSE_ICON}    ${rating_name}
    Click at    Delete Rating
    Click at    ${DELETE_A_RATING_POPUP_YES_BUTTON}

Search Rating
    [Arguments]    ${audience}      ${rating_name}
    Go to Ratings Builder page
    Click At        ${RATING_TAB}       ${audience}
    Input into    ${SEARCH_FOR_RATINGS_TEXT_BOX}    ${rating_name}
    Check Element Display On Screen    ${RATING_NAME}       ${rating_name}
    Capture Page Screenshot

Check Display theme and label at Preview
    [Arguments]    ${theme_name}     ${answers_value}   ${theme_icon}=None
    @{answers} =    Get WebElements     ${theme_name}

    IF    "${theme_icon}" != "None"
        @{themes} =     Get Webelements     ${theme_icon}
        FOR     ${theme}    IN    @{themes}
            Page Should Contain Element    ${theme}
        END
        ${length_answers}=  Get Element Count    ${theme_name}
        ${count_icon}=    Get Element Count    ${theme_icon}
        Should Be True    ${count_icon} == ${length_answers}
    END
    FOR    ${answer}    IN    @{answers}
        Should Contain Match       ${answers_value}   ${answer.text}
    END

Check Display theme when hide label at Preview
    [Arguments]    ${theme_icon}=None
    IF    "${theme_icon}" != "None"
        @{themes} =     Get Webelements     ${theme_icon}
        FOR     ${theme}    IN    @{themes}
            Page Should Contain Element    ${theme}
        END
        ${count_icon}=    Get Element Count    ${theme_icon}
        Should Be True    ${count_icon} >= 2
        Capture Page Screenshot
    END

Check Display theme and label at Preview in Widget
    [Arguments]    ${element_question}   ${rating_question}=auto_rating_question      ${theme_answer}=${EMPTY}     ${answers_value}=None   ${theme_icon}=${EMPTY}  ${length}=5
    ${success_text}=   Get Webelement    ${element_question}
    Should be equal as strings   ${success_text.text}    ${rating_question}
    ${length_theme_icon}=   Get Length    ${theme_icon}
    IF    '${length_theme_icon}' != '0'
        FOR     ${i}   IN RANGE    ${length}
            Check element display on screen    ${theme_icon}    ${i}
        END
    END
    ${length_theme_answer}=     Get Length    ${theme_answer}
    IF    '${length_theme_answer}' != '0' and ${answers_value} != None
        FOR    ${i}    IN RANGE   ${length}
            ${theme_answer_index}=    Format String   ${theme_answer}   ${i}
            ${element_them_answer}=     Get Webelement     ${theme_answer_index}
            Should Contain Match       ${answers_value}   ${element_them_answer.text}
        END
    END

Check background color when hover
    [Arguments]     ${hover_text}     ${color_hover}
    hover at    ${hover_text}
    Verify css property as strings    background-color     ${color_hover}   ${hover_text}
    capture page screenshot

Check any Theme UI in Ratings builder
    [Arguments]    ${audience}=User      ${option_theme}=Emoji      ${answers_value}=@{answers_value}
    ${rating_name}=     Create a new Rating     audience=${audience}       theme_name=${option_theme}      answers_value=@{answers_value}
    Check Element Display On Screen     ${RATINGS_PAGE_AUDIENCE_TAB}    Users
    Check Element Display On Screen     ${RATINGS_PAGE_AUDIENCE_TAB}    Candidates
    Capture Page Screenshot
    Click on span text      ${audience}s
    Input into      ${SEARCH_FOR_RATINGS_TEXT_BOX}      ${rating_name}
    Click at    ${CHOOSE_RATINGS_NAME}      ${rating_name}
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Content
    Check element exist on page     ${RATING_ANSWER_CHECK}      Answers
    Check element exist on page     ${RATING_ANSWER_CHECK}      Theme: ${option_theme}
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Confirmation
    Check Element Display On Screen     ${RATING_PREVIEW_QUESTION}
    IF     '${option_theme}' == 'Open-ended answer'
        Check element exist on page     ${RATING_PREVIEW_ANSWERS_LABEL}     Open-ended answer will appear here.
    ELSE IF     '${option_theme}' == 'Text'
        Check Display Theme And Label At Preview    theme_name=${RATING_PREVIEW_ANSWERS_LABEL}      answers_value=@{answers_value}
    ELSE
        Check Display Theme And Label At Preview    theme_name=${RATING_PREVIEW_ANSWERS_LABEL}      answers_value=@{answers_value}      theme_icon=${RATING_PREVIEW_ANSWERS_THEME}
    END
    Delete a Rating     audience=${audience}s    rating_name=${rating_name}

Check all Theme UI in Rating builder
    [Arguments]    ${audience}=User     ${option_theme}= @{options_theme}      ${answers_value}=@{answers_value}     ${answers_star_value}=@{answers_star_value}
    FOR  ${option_theme}    IN   @{options_theme}
        IF      '${option_theme}' == 'Stars'
            Check any Theme UI in Ratings builder       audience=${audience}       option_theme=${option_theme}    answers_value=@{answers_star_value}
        ELSE
            Check any Theme UI in Ratings builder       audience=${audience}       option_theme=${option_theme}    answers_value=@{answers_value}
        END
    END

Chat widget for send rating
    [Arguments]     ${widget_name}      ${job_name}
    ${site_url} =   Get widget conversation link     ${widget_name}
    Go To Widget Site    ${site_url}
    Wait with large time
    Click at    ${INPUT_WIDGET}
    Click at    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    Wait Until Element Is Not Visible    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    ${item} =    Format String    ${OLIVIA_JOB_ASSISTANT}     ${COMPANY_HIRE_ON}
    check message widget site response correct     ${item}
    check message widget site response correct    ${WHAT_OPPORTUNITY}
    Input text for widget site   ${job_name}
    check message widget site response correct      ${REPROMPT_LOCATION_MESSAGE_1}
    Input text for widget site    ${ANY_WHERE}
    Click at    ${SHADOW_DOM_SELECTED_SEE_ALL}
    ${check} =      Run Keyword And Return Status   Page Should Not Contain Element     ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    IF  '${check}' == 'True'
         Click at    ${SHADOW_DOM_SELECTED_JOB}
         Click at    ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    ELSE
         Click at     ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    END
    check message widget site response correct      ${I_CAN_HELP_YOU_TO_THE}
    ${candidate_name} =     Generate candidate name
    Input Text For Widget Site   ${candidate_name.full_name}
    check message widget site response correct      ${ASK_PHONE}
    ${phone_number} =   Generate Random String      6    [NUMBERS]
    Input Text For Widget Site      +12025${phone_number}
    check message widget site response correct      Great!
    &{email_info} =     Get email for testing       False
    Input Text For Widget Site   ${email_info.email}
    check message widget site response correct  How old are you?
    Input Text For Widget Site  22
    Click on option in conversation     Email Only
    ${mes_thanks} =     format string       ${THANK_YOU_YOUR_APPLY_JOB}     ${COMPANY_HIRE_ON}
    Check message widget site response correct      ${mes_thanks}
    Wait for Olivia reply on widget
    [Return]    ${candidate_name.first_name}

Check Display answers with any theme
    [Arguments]    ${theme_name}
    Check element exist on page     ${RATING_ANSWER_CHECK}   Answers
    Check element exist on page    ${RATING_ANSWER_CHECK}   Theme: ${theme_name}

Check Display theme and label at Preview in email
    [Arguments]    ${theme_name}    @{answers_value}  ${theme_icon}=None
    @{answers} =    Get WebElements     ${theme_name}
    IF    "${theme_icon}" != 'None'
        @{themes} =     Get Webelements     ${theme_icon}
        FOR     ${theme}    IN    @{themes}
            Page Should Contain Element    ${theme}
        END
    END
    FOR    ${answer}    IN    @{answers}
        Should Contain Match       ${answers_value}   ${answer.text}
    END
    capture page screenshot

Check display when select feedback
    [Arguments]     ${answer_text}      ${button_name}
    verify element is disable   ${RATING_EMAIL_PREVIEW_BUTTON_SUBMIT}   ${button_name}
    click at      ${answer_text}
    Verify element is enable    ${RATING_EMAIL_PREVIEW_BUTTON_SUBMIT}   ${button_name}
    capture page screenshot

Check display when select feedback with Additional feedback
    [Arguments]     ${answer_text}      ${button_name}
    verify element is disable   ${RATING_EMAIL_PREVIEW_BUTTON_SUBMIT}   ${button_name}
    click at      ${answer_text}
    Verify element is enable    ${RATING_EMAIL_PREVIEW_BUTTON_SUBMIT}   ${button_name}
    Check element display on screen     ${RATING_EMAIL_PREVIEW_ADD_FEEDBACK_TEXT}   ${MESSAGE_ADD_FEEDBACK}
    Check element display on screen     ${RATING_EMAIL_PREVIEW_TEXTAREA }   ${MESSAGE_PLEASE_ADD_FEEDBACK}
    ${text_in_textarea}=    format string   ${RATING_EMAIL_PREVIEW_TEXTAREA }   ${MESSAGE_PLEASE_ADD_FEEDBACK}
    ${random_message} =     Generate Random Text Only
    INPUT INTO       ${text_in_textarea}    ${random_message}
    capture page screenshot

Check page success when submit feedback
    [Arguments]       ${button_name}
    click button    ${button_name}
    wait for page load successfully
    Check element display on screen     ${RATING_EMAIL_PREVIEW_THANK_YOU}   ${MESSAGE_THANK_YOU_FEEDBACK}
    capture page screenshot

Check page success when submit feedback with overall feedback
    [Arguments]       ${button_name}=None
    IF  '${button_name}' != 'None'
        click button    ${button_name}
    END
    wait for page load successfully
    ${text_in_textarea} =   format string     ${RATING_EMAIL_PREVIEW_OVERALL_FEEDBACK_TEXTAREA }   Type feedback...
    Check element display on screen     ${text_in_textarea}
    ${random_message} =     Generate Random Text Only
    INPUT INTO       ${text_in_textarea}    ${random_message}
    Check page success when submit feedback    Submit Feedback
    capture page screenshot

Chat widget for send rating with conversation custom
    [Arguments]     ${widget_name}
    ${site_url} =   Get widget conversation link     ${widget_name}
    ${is_displayed} =     Run keyword and return status     Go To Widget Site    ${site_url}
    IF  '${is_displayed}' == 'False'
        ${wait_time} =  Set Variable    30
        FOR    ${index}    IN RANGE   ${wait_time}
            ${is_finished} =  Run Keyword And Return Status    Wait Until Element Is Visible    ${RATING_WIDGET_CHAT_BOX_PROMPT}    timeout=2s
            Run Keyword If    ${index} + 1 == ${wait_time}    Fail    msg=The AI chat box is not displayed
            Exit For Loop If    ${is_finished}
        END
        Click At    ${RATING_WIDGET_CHAT_BOX_PROMPT}
    END
    Click at    ${INPUT_WIDGET}
    Run Keyword And Ignore Error    Click at    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    Wait Until Element Is Not Visible    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    Input Text For Widget Site      new
    Run Keyword And Ignore Error    Click at    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    Wait Until Element Is Not Visible    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    ${item} =    Format String    ${OLIVIA_JOB_ASSISTANT}     ${COMPANY_HIRE_ON}
    check message widget site response correct     Thanks for accepting our Terms of Use. Welcome
    Input text for widget site   start
    ${candidate_name} =     Generate candidate name
    check message widget site response correct      ${REPROMPT_NAME_MESSAGE_8}
    Input text for widget site    ${candidate_name.full_name}
    check message widget site response correct      Thank you ${candidate_name.first_name}
    &{email_info} =    Get email for testing
    ${email}=      Set variable    ${email_info.email}
    Input Text For Widget Site   ${email}
    check message widget site response correct  Hi ${candidate_name.first_name}!
    Wait for Olivia reply on widget
    [Return]    ${candidate_name.first_name}

check star are filled in blue
    [Arguments]    ${index}     ${element_star_icon}
    ${RATING_SITE_STAR_ICON_INDEX}=   Format String       ${element_star_icon}    ${index}
    ${color}=   Get Element Attribute    ${RATING_SITE_STAR_ICON_INDEX}    style
    ${color_format}=   Get Substring   ${color}    -9  -2
    Should Be True       '${color_format}' == '#25c9d0'

Check all previous star selected or hover are filled in blue for widget
    [Arguments]    ${index_star}=5      ${element_star_icon}=${RATING_WIDGET_STAR_ICON}
    hover at    ${element_star_icon}     4
    FOR    ${i}   IN RANGE   ${index_star}
        check star are filled in blue   ${i}    ${element_star_icon}
    END

Change rating in widget
    [Arguments]    ${site_name}     ${rating_name}
    Go to Web Management
    ${is_changed}=  Set Variable    False
    IF    '${site_name}' != 'None'
        search and click landing site    ${site_name}
        Wait with short time
    END
    Scroll To Element    ${WEB_MANAGEMENT_RATING_TOGGLE}
    ${is_on}=    run keyword and return status    Check toggle is On    ${WEB_MANAGEMENT_RATING_TOGGLE}
    IF    '${is_on}'=='False'
        Click by JS    ${WEB_MANAGEMENT_RATING_TOGGLE}
    END
    Scroll To Element       ${WEB_MANAGEMENT_RATING_SELECT}
    Click At    ${WEB_MANAGEMENT_RATING_SELECT}
    ${WEB_MANAGEMENT_RATING_OPTION}=    Format String   ${WEB_MANAGEMENT_RATING_OPTION}     ${rating_name}
    Scroll To Element    ${WEB_MANAGEMENT_RATING_OPTION}
    Click At    ${WEB_MANAGEMENT_RATING_OPTION}
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Capture Page Screenshot
    Check Element Display On Screen    Your changes have been saved.

check Display when Finish ratings and throw confetti
    [Arguments]    ${element_success_text}      ${element_success_img}
    ${success_text}=   Get Webelement    ${element_success_text}
    Should be equal as strings    ${success_text.text}    ${MESSAGE_THANK_YOU_FEEDBACK}
    # throw confetti
    Check element display on screen     ${element_success_img}
    Capture Page Screenshot

Change rating and finish chat with widget for send rating
    [Arguments]    ${widget_name}   ${option_theme}
    Change rating in widget     ${widget_name}     ${option_theme}
    Chat widget for send rating with conversation custom    ${widget_name}
    Wait With Medium Time
    Capture Page Screenshot

Verify UI and check behavior of star theme rating in widget
    [Arguments]    ${answers_value}=@{answers_star_value}    ${add_feedback}=False      ${close_widget}=False
    IF   '${close_widget}' == 'True'
        ${RATING_WIDGET_STAR_LABEL}=    Set Variable    ${RATING_WIDGET_CLOSE_STAR_LABEL}
        ${RATING_WIDGET_STAR_ICON}=     Set Variable    ${RATING_WIDGET_CLOSE_STAR_ICON}
        ${RATING_WIDGET_RATING_QUESTION_TEXT}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_QUESTION_TEXT}
        ${RATING_WIDGET_PREVIEW_STAR_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_STAR_ANSWERS}
        ${RATING_WIDGET_FEEDBACK_TEXTAREA}=  Set Variable    ${RATING_WIDGET_CLOSE_FEEDBACK_TEXTAREA}
        ${RATING_WIDGET_FEEDBACK_BUTTON}=   Set Variable    ${RATING_WIDGET_CLOSE_FEEDBACK_BUTTON}
        ${RATING_WIDGET_RATING_SUCCESS_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_IMG}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_IMG}
        Check Element Not Display On Screen    ${RATING_WIDGET_MODEL}   wait_time=5s
    END
    Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}     theme_answer=${RATING_WIDGET_STAR_LABEL}      answers_value=@{answers_star_value}      theme_icon=${RATING_WIDGET_STAR_ICON}
    ${index_star}=  Set Variable    4
    ${color_hover}=  Set Variable    rgba(248, 248, 248, 1)
    ${RATING_WIDGET_PREVIEW_STAR_ANSWERS}=  Format String   ${RATING_WIDGET_PREVIEW_STAR_ANSWERS}   ${index_star}
    Check background color when hover   ${RATING_WIDGET_PREVIEW_STAR_ANSWERS}       ${color_hover}
    Check All Previous Star Selected Or Hover Are Filled In Blue For Widget    ${index_star}    ${RATING_WIDGET_STAR_ICON}
    Click At    ${RATING_WIDGET_PREVIEW_STAR_ANSWERS}
    Check All Previous Star Selected Or Hover Are Filled In Blue For Widget    ${index_star}    ${RATING_WIDGET_STAR_ICON}
    IF    '${add_feedback}' == 'True'
        ${webelement_text}=   Get Webelement    ${RATING_WIDGET_FEEDBACK_TEXTAREA}
        ${success_text}=    Get Element Attribute     ${webelement_text}     placeholder
        Should be equal as strings    ${success_text}    ${MESSAGE_PLEASE_ADD_FEEDBACK_WIDGET}
        Capture Page Screenshot
        ${random_message} =     Generate Random Text Only
        INPUT INTO       ${RATING_WIDGET_FEEDBACK_TEXTAREA}     ${random_message}
        Check All Previous Star Selected Or Hover Are Filled In Blue For Widget    ${index_star}    ${RATING_WIDGET_STAR_ICON}
        Verify element is enable    ${RATING_WIDGET_FEEDBACK_BUTTON}
        Click At    ${RATING_WIDGET_FEEDBACK_BUTTON}
    END
    Wait With Medium Time
    check Display when Finish ratings and throw confetti    ${RATING_WIDGET_RATING_SUCCESS_TEXT}    ${RATING_WIDGET_RATING_SUCCESS_IMG}

Verify UI and check behavior of theme rating in widget not star
    [Arguments]    ${answers_value}=@{answers_value}    ${add_feedback}=False   ${hide_label}=False     ${close_widget}=False
    IF   '${close_widget}' == 'True'
        ${RATING_WIDGET_ICON}=  Set Variable    ${RATING_WIDGET_CLOSE_ICON}
        ${RATING_WIDGET_TEXT_LABEL}=  Set Variable    ${RATING_WIDGET_CLOSE_TEXT_LABEL}
        ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_NOT_STAR_ANSWERS}
        ${RATING_WIDGET_RATING_QUESTION_TEXT}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_QUESTION_TEXT}
        ${RATING_WIDGET_FEEDBACK_TEXTAREA}=  Set Variable    ${RATING_WIDGET_CLOSE_FEEDBACK_TEXTAREA}
        ${RATING_WIDGET_FEEDBACK_BUTTON}=   Set Variable    ${RATING_WIDGET_CLOSE_FEEDBACK_BUTTON}
        ${RATING_WIDGET_RATING_SUCCESS_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_IMG}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_IMG}
        Check Element Not Display On Screen    ${RATING_WIDGET_MODEL}   wait_time=5s
    END
    IF    '${hide_label}' == 'True'
        Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}    theme_icon=${RATING_WIDGET_ICON}   length=2
    ELSE
        Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}     theme_answer=${RATING_WIDGET_TEXT_LABEL}      answers_value=@{answers_value}    theme_icon=${RATING_WIDGET_ICON}   length=2
    END
    ${index_emoji}=  Set Variable    1
    ${color_hover}=  Set Variable    rgba(248, 248, 248, 1)
    ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS_HOVER}=  Format String   ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}   ${index_emoji}
    Check background color when hover   ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS_HOVER}       ${color_hover}
    Click At    ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS_HOVER}
    IF    '${add_feedback}' == 'True'
        ${webelement_text}=   Get Webelement    ${RATING_WIDGET_FEEDBACK_TEXTAREA}
        ${success_text}=    Get Element Attribute     ${webelement_text}     placeholder
        Should be equal as strings    ${success_text}    ${MESSAGE_PLEASE_ADD_FEEDBACK_WIDGET}
        Capture Page Screenshot
        ${random_message} =     Generate Random Text Only
        INPUT INTO       ${RATING_WIDGET_FEEDBACK_TEXTAREA}     ${random_message}
        Verify element is enable    ${RATING_WIDGET_FEEDBACK_BUTTON}
        Click At    ${RATING_WIDGET_FEEDBACK_BUTTON}
    END
    Wait With Medium Time
    check Display when Finish ratings and throw confetti    ${RATING_WIDGET_RATING_SUCCESS_TEXT}    ${RATING_WIDGET_RATING_SUCCESS_IMG}

check All options are displayed in a bubble with the same height and width
    [Arguments]    ${element_raing_text}
    @{elements} =    Get Webelements    ${element_raing_text}
    &{bubble_const}=     Create Dictionary    width=None      height=None  border_radius=None
    FOR    ${element}   IN    @{elements}
        ${width} =    Call Method    ${element}    value_of_css_property    width
        ${height} =    Call Method    ${element}    value_of_css_property    height
        ${border_radius} =    Call Method    ${element}    value_of_css_property    border-radius
        IF  '${bubble_const.width}' == 'None' and '${bubble_const.height}' == 'None' and '${bubble_const.border_radius}' == 'None'
            ${bubble_const.width}=     Set Variable   ${width}
            ${bubble_const.height}=     Set Variable   ${height}
            ${bubble_const.border_radius}=     Set Variable   ${border_radius}
        ELSE
             Should Be True    '${bubble_const.width}' == '${width}'
             Should Be True    '${bubble_const.height}' == '${height}'
             Should Be True    '${bubble_const.border_radius}' == '${border_radius}'
             Capture Page Screenshot
        END
    END

Verify UI and check behavior of text theme rating in widget
    [Arguments]    ${answers_value}=@{answers_value}    ${add_feedback}=False       ${close_widget}=False
    IF   '${close_widget}' == 'True'
        ${RATING_WIDGET_RATING_THEME_TEXT}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_THEME_TEXT}
        ${RATING_WIDGET_RATING_THEME_TEXT_LABEL}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_THEME_TEXT_LABEL}
        ${RATING_WIDGET_RATING_QUESTION_TEXT}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_QUESTION_TEXT}
        ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_TEXT_ANSWERS}
        ${RATING_WIDGET_FEEDBACK_TEXTAREA}=  Set Variable    ${RATING_WIDGET_CLOSE_FEEDBACK_TEXTAREA}
        ${RATING_WIDGET_FEEDBACK_BUTTON}=   Set Variable    ${RATING_WIDGET_CLOSE_FEEDBACK_BUTTON}
        ${RATING_WIDGET_RATING_SUCCESS_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_IMG}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_IMG}
        Check Element Not Display On Screen    ${RATING_WIDGET_MODEL}   wait_time=5s
    END
    Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}     theme_answer=${RATING_WIDGET_RATING_THEME_TEXT_LABEL}      answers_value=@{answers_value}     length=2
    check All options are displayed in a bubble with the same height and width      ${RATING_WIDGET_RATING_THEME_TEXT}
    ${color_text}=      Set Variable     rgba(37, 201, 208, 1)
    ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}=     Format String   ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}   0
    Check background color when hover       ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}       ${color_text}
    Click At    ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}
    Check background color when hover       ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}       ${color_text}
    IF    '${add_feedback}' == 'True'
        ${webelement_text}=   Get Webelement    ${RATING_WIDGET_FEEDBACK_TEXTAREA}
        ${success_text}=    Get Element Attribute     ${webelement_text}     placeholder
        Should be equal as strings    ${success_text}    ${MESSAGE_PLEASE_ADD_FEEDBACK_WIDGET}
        Capture Page Screenshot
        ${random_message} =     Generate Random Text Only
        INPUT INTO       ${RATING_WIDGET_FEEDBACK_TEXTAREA}     ${random_message}
        Check background color when hover       ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}       ${color_text}
        Verify element is enable    ${RATING_WIDGET_FEEDBACK_BUTTON}
        Click At    ${RATING_WIDGET_FEEDBACK_BUTTON}
    END
    Wait With Medium Time
    check Display when Finish ratings and throw confetti    ${RATING_WIDGET_RATING_SUCCESS_TEXT}    ${RATING_WIDGET_RATING_SUCCESS_IMG}

Verify UI and Check behavior of Open-ended answer when a candidate input data
    [Arguments]    ${rating_question}=auto_rating_question   ${message_text}=None       ${close_widget}=False
    IF   '${close_widget}' == 'True'
        ${RATING_WIDGET_OPEN_ENDED_INPUT}=  Set Variable    ${RATING_WIDGET_CLOSE_OPEN_ENDED_INPUT}
        ${RATING_WIDGET_RATING_QUESTION_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_QUESTION_TEXT}
        ${RATING_WIDGET_OPEN_ENDED_BUTTON}=   Set Variable    ${RATING_WIDGET_CLOSE_OPEN_ENDED_BUTTON}
        ${RATING_WIDGET_RATING_SUCCESS_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_IMG}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_IMG}
        Check Element Not Display On Screen    ${RATING_WIDGET_MODEL}   wait_time=5s
    END
    ${success_text}=   Get Webelement    ${RATING_WIDGET_RATING_QUESTION_TEXT}
    Should be equal as strings   ${success_text.text}    ${rating_question}
    Check Element Display On Screen    ${RATING_WIDGET_OPEN_ENDED_INPUT}
    verify element is disable   ${RATING_WIDGET_OPEN_ENDED_BUTTON}
    IF  '${message_text}' == 'None'
        ${message_text} =     Generate Random Text Only
    END
    Input Into    ${RATING_WIDGET_OPEN_ENDED_INPUT}   ${message_text}
    Verify element is enable    ${RATING_WIDGET_OPEN_ENDED_BUTTON}
    Click At    ${RATING_WIDGET_OPEN_ENDED_BUTTON}
    Wait With Medium Time
    check Display when Finish ratings and throw confetti    ${RATING_WIDGET_RATING_SUCCESS_TEXT}    ${RATING_WIDGET_RATING_SUCCESS_IMG}
    Capture Page Screenshot

Verify UI and Check behavior of icons in case there are more than 2 questions
    [Arguments]    ${rating_question}=auto_rating_question       ${close_widget}=False
    IF   '${close_widget}' == 'True'
        ${RATING_WIDGET_STAR_LABEL}=    Set Variable    ${RATING_WIDGET_CLOSE_STAR_LABEL}
        ${RATING_WIDGET_STAR_ICON}=     Set Variable    ${RATING_WIDGET_CLOSE_STAR_ICON}
        ${RATING_WIDGET_ICON}=  Set Variable    ${RATING_WIDGET_CLOSE_ICON}
        ${RATING_WIDGET_TEXT_LABEL}=  Set Variable    ${RATING_WIDGET_CLOSE_TEXT_LABEL}
        ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_NOT_STAR_ANSWERS}
        ${RATING_WIDGET_RATING_THEME_TEXT}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_THEME_TEXT}
        ${RATING_WIDGET_RATING_THEME_TEXT_LABEL}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_THEME_TEXT_LABEL}
        ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_TEXT_ANSWERS}
        ${RATING_WIDGET_RATING_QUESTION_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_QUESTION_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_IMG}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_IMG}
        Check Element Not Display On Screen    ${RATING_WIDGET_MODEL}
    END
    # rating for star
    Check Display theme and label at Preview in Widget  element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}  rating_question=star question rating    theme_answer=${RATING_WIDGET_STAR_LABEL}      answers_value=@{answers_star_value}      theme_icon=${RATING_WIDGET_STAR_ICON}
	Click At    ${RATING_WIDGET_PREVIEW_STAR_ANSWERS}   4
	Check All Previous Star Selected Or Hover Are Filled In Blue For Widget    4    ${RATING_WIDGET_STAR_ICON}
	# rating for emoji
	Wait With Medium Time
	Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}    rating_question=emoji question rating     theme_answer=${RATING_WIDGET_TEXT_LABEL}      answers_value=@{answers_value}    theme_icon=${RATING_WIDGET_ICON}   length=2
	Click At    ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}   1
	# rating for thumb
	Wait With Medium Time
	Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}    rating_question=thumb question rating     theme_answer=${RATING_WIDGET_TEXT_LABEL}      answers_value=@{answers_value}    theme_icon=${RATING_WIDGET_ICON}   length=2
	Click At    ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}   1
	# rating for text
	Wait With Medium Time
    Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}    rating_question=text question rating     theme_answer=${RATING_WIDGET_RATING_THEME_TEXT_LABEL}      answers_value=@{answers_value}     length=2
    check All options are displayed in a bubble with the same height and width      ${RATING_WIDGET_RATING_THEME_TEXT}
	Click At    ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}   1
	# rating for open-ended
	Wait With Medium Time
    Verify UI and Check behavior of Open-ended answer when a candidate input data   rating_question=open ended question rating      close_widget=${close_widget}
    Capture Page Screenshot

Verify UI and Check behavior of Candidate makes Overall feedback
    [Arguments]    ${rating_question}=auto_rating_question       ${close_widget}=False
    IF   '${close_widget}' == 'True'
        ${RATING_WIDGET_STAR_LABEL}=    Set Variable    ${RATING_WIDGET_CLOSE_STAR_LABEL}
        ${RATING_WIDGET_STAR_ICON}=     Set Variable    ${RATING_WIDGET_CLOSE_STAR_ICON}
        ${RATING_WIDGET_ICON}=  Set Variable    ${RATING_WIDGET_CLOSE_ICON}
        ${RATING_WIDGET_TEXT_LABEL}=  Set Variable    ${RATING_WIDGET_CLOSE_TEXT_LABEL}
        ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_NOT_STAR_ANSWERS}
        ${RATING_WIDGET_RATING_THEME_TEXT}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_THEME_TEXT}
        ${RATING_WIDGET_RATING_THEME_TEXT_LABEL}=  Set Variable    ${RATING_WIDGET_CLOSE_RATING_THEME_TEXT_LABEL}
        ${RATING_WIDGET_PREVIEW_TEXT_ANSWERS}=  Set Variable    ${RATING_WIDGET_CLOSE_PREVIEW_TEXT_ANSWERS}
        ${RATING_WIDGET_RATING_QUESTION_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_QUESTION_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_TEXT}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_TEXT}
        ${RATING_WIDGET_RATING_SUCCESS_IMG}=   Set Variable    ${RATING_WIDGET_CLOSE_RATING_SUCCESS_IMG}
        Check Element Not Display On Screen    ${RATING_WIDGET_MODEL}   wait_time=5s
    END
    Check Display theme and label at Preview in Widget    element_question=${RATING_WIDGET_RATING_QUESTION_TEXT}    theme_answer=${RATING_WIDGET_TEXT_LABEL}      answers_value=@{answers_value}    theme_icon=${RATING_WIDGET_ICON}   length=2
	Click At    ${RATING_WIDGET_PREVIEW_NOT_STAR_ANSWERS}   1
	Check Element Display On Screen    ${RATING_WIDGET_FEEDBACK_MESSAGE_LABEL}
	${feedback_message}=   Get Webelement    ${RATING_WIDGET_FEEDBACK_MESSAGE_LABEL}
    Should be equal as strings   ${feedback_message.text}    Please provide us with any overall feedback.
    Check Element Display On Screen    ${RATING_WIDGET_OPEN_ENDED_INPUT}
    verify element is disable   ${RATING_WIDGET_OPEN_ENDED_BUTTON}
    ${message_text} =     Generate Random Text Only
    Input Into    ${RATING_WIDGET_OPEN_ENDED_INPUT}   ${message_text}
    Verify element is enable    ${RATING_WIDGET_OPEN_ENDED_BUTTON}
    Click At    ${RATING_WIDGET_OPEN_ENDED_BUTTON}
    Wait With Medium Time
    check Display when Finish ratings and throw confetti    ${RATING_WIDGET_RATING_SUCCESS_TEXT}    ${RATING_WIDGET_RATING_SUCCESS_IMG}
    Capture Page Screenshot
