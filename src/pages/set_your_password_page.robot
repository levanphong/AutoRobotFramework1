*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/set_your_password_locators.py

*** Keywords ***
Set password for user
    [Arguments]     ${password}
    Input into      ${SET_PASSWORD_ENTER_PASSWORD_TEXTBOX}      ${password}
    Input into      ${SET_PASSWORD_CONFIRM_PASSWORD_TEXTBOX}    ${password}
    Click at    ${SET_PASSWORD_SUBMIT_BUTTON}
    [Return]    ${password}
