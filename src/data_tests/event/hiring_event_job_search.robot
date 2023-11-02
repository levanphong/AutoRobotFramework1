*** Settings ***
Variables       ../../locators/client_setup_locators.py

*** Keywords ***
Prepare Hiring Event Job Search Data test for Suite
    Run Setup Only Once    Prepare Hiring Event Job Search Data test

Prepare Hiring Event Job Search Data test
    Open Chrome
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Enable Client Setup for Hiring Event Job Search    Events
    Enable Client Setup for Hiring Event Job Search    Scheduling
    # Job Search -> Tunr Chat-to-apply toggle and select a conversation

Enable Client Setup for Hiring Event Job Search
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'Events'
        when Click at    ${EVENTS_LABEL}
        Turn on    ${EVENTS_TOGGLE}
        Turn on    ${HIRING_EVENTS_TOGGLE}
        Turn on    ${EVENT_JOBS_TOGGLE}
        Turn on    ${JOBS_TRIGGER_TOGGLE}
        Select Event Phone Number and Keyword association period
    ELSE IF    '${item}' == 'Scheduling'
        Click at    ${SCHEDULING_LABEL}
        Turn on    ${NEW_SCHEDULING_UI_TOGGLE}
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

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
