*** Settings ***
Variables       ../../locators/client_setup_locators.py

*** Keywords ***
Prepare Event Rating Data test for Suite
    Run Setup Only Once    Prepare Event Rating Data test

Prepare Event Rating Data test
    Open Chrome
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_EVENT}
    Enable Client Setup for Event Rating    More
    Enable Client Setup for Event Rating    Events
    Create a new Rating    User    rating_name=${event_user_rating_test}
    Create a new Rating    Candidate    rating_name=${event_candidate_rating_test}
    Create a new Rating    Candidate    rating_name=${event_candidate_rating_test_2}
    # Create a Event Registration (Single Path), Turn on Phone&Email

Enable Client Setup for Event Rating
    [Arguments]    ${item}
    Run keyword and ignore error    Click at    ${EVENT_CREATOR_TOOLBAR_BACK_TO_EVENTS}
    Run keyword and ignore error    Click at    ${EVENT_CREATOR_PAGE_DISCARD_BUTTON}
    Navigate to    Client Setup
    IF    '${item}' == 'More'
        Click at    ${MORE_LABEL}
        Turn on    ${RATINGS_TOGGLE}
    ELSE IF    '${item}' == 'Events'
        Click at    ${EVENTS_LABEL}
        Turn on    ${EVENT_JOBS_TOGGLE}
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

Turn off Ratings for Event
    Navigate to    Client Setup
    Click at    ${MORE_LABEL}
    Turn off    ${RATINGS_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

Turn off Event Job for Event
    Navigate to    Client Setup
    Click at    ${EVENTS_LABEL}
    Turn off    ${EVENT_JOBS_TOGGLE}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time
