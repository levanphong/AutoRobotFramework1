*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/login_locators.py

*** Keywords ***
Input Email
    [Arguments]    ${txt_value}
    Input into    ${EMAIL_INPUT}    ${txt_value}

Input password login page
    [Arguments]    ${txt_pass}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    ${txt_pass}

Click Next button
    Click at    ${BUTTON_NEXT}

Click login button
    Click at    ${BUTTON_SIGN_IN}

Input email user
    [Arguments]    ${locator}    ${txt_value}
    input text    ${locator}    ${txt_value}
    Wait with medium time

login into CEM
    [Arguments]    ${email}    ${pass}=None
    Input Email    ${email}
    Click Next button
    IF  '+bs@' in '${email}'
        # Login with Basic User need to input code from Email Instead of Password
        ${verify_code} =    Get verify code in email  Access Code to the Paradox  Use this code to access your task list
        ${single_code} =    Get Regexp Matches    ${verify_code}    [0-9]
        FOR  ${i}  IN RANGE  6
           ${locator_code}=  format string   ${LOGIN_CODE_INPUT}  ${i+1}
           Input into  ${locator_code}  ${single_code}[${i}]
        END
    ELSE
        Input password login page    ${pass}
        Click login button
    END
    wait for page load successfully
