*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/my_profile_locators.py

*** Keywords ***
Select user flatform language
    [Arguments]     ${language}
    Click at    ${MY_PROFILE_PLATFORM_LANGUAGE_SELECT}
    Select from list by label   ${MY_PROFILE_PLATFORM_LANGUAGE_SELECT}      ${language}
    Save my profile page

Save my profile page
    ${is_changed} =    Run Keyword And Return Status    Check element display on screen    ${MY_PROFILE_SAVE_BUTTON}      wait_time=5s
    IF    ${is_changed}
        Click at    ${MY_PROFILE_SAVE_BUTTON}
    END

Choose time zone in My profile page
    [Arguments]    ${timezone_name}
    Click at    ${MY_PROFILE_LIST_TIME_ZONE_DROPDOWN}
    Input into    ${MY_PROFILE_INPUT_TIME_ZONE}    ${timezone_name}
    Click at    ${MY_PROFILE_LIST_TIME_ZONE_OPTIONS}    ${timezone_name}
    Save my profile page
