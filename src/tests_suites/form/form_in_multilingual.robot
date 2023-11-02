*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

*** Variables ***
${default_language}             English (en)
@{list_languages}               French (fr)    Japanese (ja)    Thai (th)    Vietnamese (vi)
${vn_language}                  Vietnamese (vi)
${jp_language}                  日本語 (ja)
${default_en_language_in_vn}    Tiếng Anh (mặc định)
&{jp_language_option}           language=Japanese (ja)    default_section_text=デフォルト セクション    final_submission_text=最終提出
&{default_language_option}      language=English (en)    default_section_text=Default Section    final_submission_text=Final Submission
${location}                     Florida
${required_message_in_jp}       このフィールドは必須事項です
${confirm_message_in_jp}        フォームをご記入いただきありがとうございました！ {} Lnameさんのステータスを以下に更新しますか？

*** Test Cases ***
User Form - Check the display of Multilingual icon in case Multilingual toggle is OFF (OL-T16429)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to form page
    ${form_name} =      Add new form and input name     ${USER_FORM_TYPE}
    Check element not display on screen     ${FORM_MULTILINGUAL_ICON}       wait_time=5s
    Capture page screenshot
    Delete a form with type     ${USER_FORM_TYPE}       ${form_name}


User Form - Check the display of Multilingual icon in case Multilingual toggle is ON (OL-T16430, OL-T16431, OL-T16432, OL-T16436, OL-T16438, OL-T16439, OL-T16440, OL-T16442, OL-T16447, OL-T16448)
    [Tags]  skip
    #TODO https://paradoxai.atlassian.net/browse/OL-79916
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =      Add new form and input name     ${USER_FORM_TYPE}
    #   (OL-T16430)
    Check element display on screen     ${FORM_MULTILINGUAL_ICON}
    #   User Form - Check the display of [Multilingual] Dropdown (T16431)
    Click at    ${FORM_MULTILINGUAL_ICON}
    Check element display on screen     ${FORM_MULTILINGUAL_SEARCH_LANGUAGES_INPUT}
    Check element display on screen     ${FORM_MULTILINGUAL_DEFAULT_LANGUAGE}       ${default_language}
    Capture page screenshot
    #   User Form - Check the display of Form after selecting language and submitting [Confirm] on [Update Language Templates] (OL-T16440)
    #   OL-T16440 included in these test case below
    #   (OL-T16432)
    User Form - Check the display of Configure Languages
    #   (OL-T16436)
    User Form - Check the display on Update Language Templates popup after selecting languages on Configure Languages       @{list_languages}
    #   (OL-T16438)
    User Form - Check the display on Update Language Templates popup after unselecting languages on Configure Languages     @{list_languages}
    #   (OL-T16439)
    User Form - Check the display on Update Language Templates popup after selecting and unselecting any languages on Configure Languages       ${vn_language}
    #   (OL-T16442)
    User Form - Check the display of Form when selecting any language on Multilingual dropdown      &{jp_language_option}
    #   (OL-T16447)
    User Form - Check the display of Form on Form list      ${CA_JAPANESE}      ${jp_language_option}
    Check element display on screen     ${FORM_MULTILINGUAL_LANGUAGE}       ${jp_language}
    Capture page screenshot
    #   (OL-T16448)
    User Form - Check the display of Form on Form list      ${CA_VIETNAMESE}    ${default_language_option}
    Check element display on screen     ${FORM_MULTILINGUAL_LANGUAGE}       ${default_en_language_in_vn}
    Capture page screenshot
    Switch to user      ${TEAM_USER}
    Delete a form with type     ${USER_FORM_TYPE}       ${form_name}


User Form - Check the display of Form on User Experience screen in case User's language existed on configure of Form (OL-T16449)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${CA_TEAM}
    ${candidate_name}=      Add a Candidate     None    ${location}     ${JOB_FORM_IN_MULTILINGUAL}     is_spam_email=True
    #   (OL-T16449)
    Switch to user      ${CA_JAPANESE}
    User Form - Check the display of Form on User Experience screen in case User's language existed on configure of Form    ${candidate_name}

*** Keywords ***
User Form - Check the display of Configure Languages
    Click at    ${FORM_MULTILINGUAL_CONFIG_LANGUAGES_BUTTON}
    Check element display on screen     ${FORM_MULTILINGUAL_SEARCH_LANGUAGES_INPUT}
    Check element display on screen     ${FORM_MULTILINGUAL_SELECT_ALL_LANGUAGES_BUTTON}
    Check element display on screen     ${FORM_MULTILINGUAL_LANGUAGE_CANCEL_BUTTON}
    Check element display on screen     ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    FOR     ${language}    IN    @{list_languages}
        Check element display on screen     ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language}
    END
    Capture page screenshot

User Form - Check the display on Update Language Templates popup after selecting languages on Configure Languages
    [Arguments]     @{languages}
    FOR     ${language}    IN    @{languages}
        Click at    ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language}
    END
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    Check text display      Update Language Templates
    ${number_of_list_languages} =   Get length   ${languages}
    IF      ${number_of_list_languages} == 1
        ${number_language} =   format string       ${FORM_MULTILINGUAL_ADDING_LANGUAGE_NUMBER}      1        ${EMPTY}
    ELSE
        ${number_language} =   format string       ${FORM_MULTILINGUAL_ADDING_LANGUAGE_NUMBER}      ${number_of_list_languages}       s
    END
    Check element display on screen     ${number_language}
    FOR     ${language}    IN    @{languages}
        Check element display on screen    ${FORM_MULTILINGUAL_ADDED_LANGUAGES_TEXT}      ${language}
    END
    Capture page screenshot
    Click at    ${FORM_MULTILINGUAL_CONFIRM_ADD_LANGUAGE_BUTTON}
    FOR     ${language}    IN    @{languages}
        Check element display on screen    ${FORM_MULTILINGUAL_LANGUAGE_LIST}      ${language}
    END
    Check element display on screen     ${FORM_MULTILINGUAL_DEFAULT_LANGUAGE}   ${default_language}
    Capture page screenshot

User Form - Check the display on Update Language Templates popup after unselecting languages on Configure Languages
    [Arguments]     @{languages}
    Click at    ${FORM_MULTILINGUAL_CONFIG_LANGUAGES_BUTTON}
    FOR     ${language}    IN    @{languages}
        Click at    ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language}
    END
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    Check text display      Update Language Templates
    ${number_of_list_languages} =   Get length   ${languages}
    IF      ${number_of_list_languages} == 1
        ${number_language} =   format string       ${FORM_MULTILINGUAL_REMOVING_LANGUAGE_NUMBER}      1        ${EMPTY}
    ELSE
        ${number_language} =   format string       ${FORM_MULTILINGUAL_REMOVING_LANGUAGE_NUMBER}      ${number_of_list_languages}       s
    END
    Check element display on screen     ${number_language}
    FOR     ${language}    IN    @{languages}
        Check element display on screen    ${FORM_MULTILINGUAL_ADDED_LANGUAGES_TEXT}      ${language}
    END
    Capture page screenshot
    Click at    ${FORM_MULTILINGUAL_CONFIRM_ADD_LANGUAGE_BUTTON}
    FOR     ${language}    IN    @{languages}
        Check element not display on screen    ${FORM_MULTILINGUAL_LANGUAGE_LIST}      ${language}      wait_time=2s
    END
    Check element display on screen     ${FORM_MULTILINGUAL_DEFAULT_LANGUAGE}   ${default_language}
    Capture page screenshot

User Form - Check the display on Update Language Templates popup after selecting and unselecting any languages on Configure Languages
    [Arguments]     ${language}
    #   Add 1 language
    Click at    ${FORM_MULTILINGUAL_CONFIG_LANGUAGES_BUTTON}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    Check text display      Update Language Templates
    ${number_language} =   format string       ${FORM_MULTILINGUAL_ADDING_LANGUAGE_NUMBER}      1        ${EMPTY}
    Check element display on screen     ${number_language}
    Check element display on screen    ${FORM_MULTILINGUAL_ADDED_LANGUAGES_TEXT}      ${language}
    Capture page screenshot
    Click at    ${FORM_MULTILINGUAL_CONFIRM_ADD_LANGUAGE_BUTTON}
    Check element display on screen    ${FORM_MULTILINGUAL_LANGUAGE_LIST}      ${language}
    Check element display on screen     ${FORM_MULTILINGUAL_DEFAULT_LANGUAGE}   ${default_language}
    Capture page screenshot
    #   Remove 1 language
    Click at    ${FORM_MULTILINGUAL_CONFIG_LANGUAGES_BUTTON}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    Check text display      Update Language Templates
    ${number_language} =   format string       ${FORM_MULTILINGUAL_REMOVING_LANGUAGE_NUMBER}      1        ${EMPTY}
    Check element display on screen     ${number_language}
    Check element display on screen    ${FORM_MULTILINGUAL_ADDED_LANGUAGES_TEXT}      ${language}
    Capture page screenshot
    Click at    ${FORM_MULTILINGUAL_CONFIRM_ADD_LANGUAGE_BUTTON}
    Check element not display on screen    ${FORM_MULTILINGUAL_LANGUAGE_LIST}      ${language}      wait_time=3s
    Check element display on screen     ${FORM_MULTILINGUAL_DEFAULT_LANGUAGE}       ${default_language}
    Capture page screenshot

User Form - Check the display of Form when selecting any language on Multilingual dropdown
    [Arguments]     &{language_option}
    Click at    ${FORM_MULTILINGUAL_CONFIG_LANGUAGES_BUTTON}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language_option.language}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    Click at    ${FORM_MULTILINGUAL_CONFIRM_ADD_LANGUAGE_BUTTON}
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_LIST}      ${language_option.language}
    Wait for page load successfully
    Check text display      ${language_option.default_section_text}
    Check text display      ${language_option.final_submission_text}
    Capture page screenshot

User Form - Check the display of Form on Form list
    [Arguments]     ${user}     ${language_option}
    Switch to user      ${user}
    Check text display      ${language_option.default_section_text}
    Check text display      ${language_option.final_submission_text}
    Capture page screenshot

User Form - Check the display of Form on User Experience screen in case User's language existed on configure of Form
    [Arguments]     ${candidate_name}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at    ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	# Input number into text box
    Input into    ${FORM_INPUT_TEXT_PARAGRAPH_TEXTAREA}    1
    Check element display on screen     ${FORM_VALIDATE_MESSAGE}     1 文字のみ入力してください
    Capture page screenshot
    Clear element text with keys    ${FORM_INPUT_TEXT_PARAGRAPH_TEXTAREA}
    Check element display on screen     ${FORM_VALIDATE_MESSAGE}    ${required_message_in_jp}
    Capture page screenshot
    # Input 1 letter into text box
    Input into    ${FORM_INPUT_TEXT_PARAGRAPH_TEXTAREA}    A
    Check element not display on screen     ${FORM_VALIDATE_MESSAGE}     1 文字のみ入力してください      wait_time=3s
    Capture page screenshot
    Click at    ${FORM_CEM_EXPERIENCE_NEXT_BUTTON}
    ${message} =     Format String    ${confirm_message_in_jp}    ${candidate_name}
    Check text display    ${message}
    Capture page screenshot
    Click at    ${FORM_EXPERIENCE_DRAWER_FORM_CEM_SAVE_BUTTON}
