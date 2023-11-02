*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/campus_locators.py

*** Keywords ***
Search a School in Campus
    [Arguments]    ${school_name}
    ${is_search_display} =    Run Keyword And Return Status    Check element display on screen    ${SEARCH_SCHOOL_TEXT_BOX}    wait_time=2s
    Run keyword if    ${is_search_display}    Input into    ${SEARCH_SCHOOL_TEXT_BOX}    ${school_name}
    Run keyword if    ${is_search_display}    Check element display on screen    ${SEARCH_SCHOOL_RESULT}    ${school_name}
    [Return]    ${is_search_display}

Go to School details
    [Arguments]    ${school_name}
    ${is_search_display} =    Search a School in Campus    ${school_name}
    IF    ${is_search_display}
        Click at    ${SEARCH_SCHOOL_RESULT}  ${school_name}
    ELSE
        Click at    ${school_name}
    END
