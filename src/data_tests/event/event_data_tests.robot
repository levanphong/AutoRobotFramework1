*** Settings ***
Library         SeleniumLibrary
Library         ../../utils/NameUtils.py
Variables       ../../locators/client_setup_locators.py
Resource        ../../constants/variables_resource.robot
Resource        ../../commons/common_keywords.robot

*** Keywords ***
Prepare Events Data Test
    Open Chrome
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    when Navigate to    Client Setup
    Enable Client Setup for Events
    Enable Client Setup for Job Search
    Enable Customize Scheduling Timelines And Set Max Time

Enable Client Setup for Events
    when Click at    ${EVENTS_LABEL}
    when Turn on    ${EVENTS_TOGGLE}
    when Turn on    ${HIRING_EVENTS_TOGGLE}
    when Turn on    ${EVENT_JOBS_TOGGLE}
    when Turn on    ${JOBS_TRIGGER_TOGGLE}
    Select Event Phone Number and Keyword association period
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Then Check toggle is On    ${HIRING_EVENTS_TOGGLE}

Select Event Phone Number and Keyword association period
    Click at    ${BEFORE_VALUE_SELECTION}
    ${locator_button} =    Format String    ${BEFORE_VALUE}    1
    Click at    ${locator_button}
    Click at    ${BEFORE_UNIT_SELECTION}
    ${locator_button} =    Format String    ${BEFORE_UNIT}    hours
    Click at    ${locator_button}
    Click at    ${AFTER_VALUE_SELECTION}
    ${locator_button} =    Format String    ${AFTER_VALUE}    1
    Click at    ${locator_button}
    Click at    ${AFTER_UNIT_SELECTION}
    ${locator_button} =    Format String    ${AFTER_UNIT}    hours
    Click at    ${locator_button}

Enable Client Setup for Job Search
    Click at    ${JOB_SEARCH_LABEL}
    Turn on    ${JOB_SEARCH_TOGGLE}
    Click at    ${JS_ENV_SELECTION}
    ${locator_button} =    Format String    ${JS_ENV_VALUE}    Staging
    Click at    ${locator_button}
    # TODO: Choose Company after select JS_ENV
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END

Enable Customize Scheduling Timelines And Set Max Time
    ${elem} =    Get Webelement    ${CUSTOMIZE_SCHEDULING_TIME_TOGGLE}
    ${bg_color} =    Call Method    ${elem}    value_of_css_property    background-color
    ${is_active_bg} =    Run Keyword And Return Status    Should Be Equal As Strings    ${bg_color}
    ...    ${BG_COLOR_CHECKED}
    IF    not ${is_active_bg}
        Click at    ${CUSTOMIZE_SCHEDULING_TIME_LINE_TOGGLE}
        Click at    ${INPUT_EVENT_ORIENT_TIME_LINE_MAX}
        Click at    No Restriction
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
