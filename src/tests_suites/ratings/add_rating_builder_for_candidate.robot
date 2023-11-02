*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/ratings_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test
Documentation       Run data test on src/data_tests/rating/widget_conversation.robot file before run test

*** Variables ***
@{options_theme}            Thumbs    Emoji    Stars    Text    Open-ended answer
@{answers_star_value}       1    2    3    4    5
@{answers_value}            Bad    Fine

*** Test Cases ***
Candidate - Verify all Theme UI in Ratings builder (OL-T26854,OL-T26855,OL-T26856,OL-T26859,OL-T26860)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to Ratings Builder page
    Check all Theme UI in Rating builder    audience=Candidate      answers_value=@{answers_value}      answers_star_value=@{answers_star_value}
    Capture Page Screenshot


Candidate - Verify Emoji with no text in Ratings builder (OL-T26857,OL-T26857)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to Ratings Builder page
    ${rating_name}=     Create a new Rating     audience=Candidate      answers_value=@{answers_value}      hide_label=True
    Check Element Display On Screen     ${RATINGS_PAGE_AUDIENCE_TAB}    Users
    Check Element Display On Screen     ${RATINGS_PAGE_AUDIENCE_TAB}    Candidates
    Run keyword and ignore error    Input into      ${SEARCH_FOR_RATINGS_TEXT_BOX}      ${rating_name}
    Click at    ${CHOOSE_RATINGS_NAME}      ${rating_name}
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Content
    Check element exist on page     ${RATING_ANSWER_CHECK}      Answers
    Check element exist on page     ${RATING_ANSWER_CHECK}      Theme: Emoji
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Confirmation
    Check Display Theme When Hide Label At Preview      theme_icon=${RATING_PREVIEW_ANSWERS_THEME}
    Delete a Rating     audience=Candidates     rating_name=${rating_name}
    Capture Page Screenshot
