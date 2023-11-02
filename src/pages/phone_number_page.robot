*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/phone_number_locators.py

*** Keywords ***
Generate a new AI phone number
    [Arguments]    ${area_code}
    Click at    ${ICON_ADD_AI_PHONE}
    Click at    ${US_INTERNATIONAL_OPTION}
    Click at    ${BUTTON_CONTINUE_MODAL_PHONE_AI}
    Input into    ${INPUT_AREA_CODE}    ${area_code}
    wait for page load successfully
    Click at    ${BUTTON_GENERATE}
    wait for page load successfully

Generate a new short code
    [Arguments]    ${keyword}
    Click at    ${ICON_ADD_AI_PHONE}
    Click at    ${SHORT_CODE_MODAL}
    Click at    ${BUTTON_CONTINUE_MODAL_SHORT_CODE}
    Input into    ${INPUT_SHORT_CODE_KEYWORD}    ${keyword}
    wait for page load successfully
    Click at    ${BUTTON_GENERATE_SHORTCODE}
    wait for page load successfully
    wait with medium time
    [Return]    ${keyword}

check and generate new phone number
    [Arguments]    ${area_code}
    Click at    A.I. Phone Numbers
    ${is_existed_phone} =    Run Keyword And Return Status    Check element display on screen    ${CURRENTLY_UNUSED}
    IF    '${is_existed_phone}' == 'False'
        Generate a new AI phone number    ${area_code}
    END

turn on job search toogle on modal phone AI
    wait with short time
    Click by JS    ${JOB_SEARCH_TOGGLE_PHONE_AI}

attribute session is display
    Check element display on screen    ${ADD_ATTRIBUTE_PHONE_AI}

Check Location SMS keyword is display
    [Arguments]    ${shortcode}
    Check element display on screen    ${shortcode}

turn on job search toogle shortcode
    click by js    ${JOB_SEARCH_TOGGLE_SHORTCODE}
