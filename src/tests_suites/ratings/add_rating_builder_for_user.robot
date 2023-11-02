*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/custom_conversation_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../locators/custom_conversation_locators.py
Resource            ../conversation/common_features/skip_next_question/skip_next_question.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test
Documentation       Run data test on src/data_tests/rating/widget_conversation.robot file before run test

*** Variables ***
@{options_theme}            Thumbs    Emoji    Stars    Text    Open-ended answer
@{answers_star_value}       Bad    Bad 1    Good    Good 2    Happy
@{answers_value}            Bad    Fine
${color_hover}              rgba(248, 248, 248, 1)

*** Test Cases ***
User - Verify all Theme UI in Ratings builder (OL-T26861,OL-T26862,OL-T26863,OL-T26866,OL-T26867)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to Ratings Builder page
    Check all Theme UI in Rating builder    answers_value=@{answers_value}      answers_star_value=@{answers_star_value}
    Capture Page Screenshot


User - Verify Emoji with no text in Ratings builder (OL-T26864,OL-T26865)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to Ratings Builder page
    ${rating_name}=     Create a new Rating     audience=User       answers_value=@{answers_value}      hide_label=True
    Check Element Display On Screen     ${RATINGS_PAGE_AUDIENCE_TAB}    Users
    Check Element Display On Screen     ${RATINGS_PAGE_AUDIENCE_TAB}    Candidates
    Click on span text      User
    Run keyword and ignore error    Input into      ${SEARCH_FOR_RATINGS_TEXT_BOX}      ${rating_name}
    Click at    ${CHOOSE_RATINGS_NAME}      ${rating_name}
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Content
    Check element exist on page     ${RATING_ANSWER_CHECK}      Answers
    Check element exist on page     ${RATING_ANSWER_CHECK}      Theme: Emoji
    Click At    ${RATING_ITEM_TAB_CHOOSE}       Confirmation
    Check Display Theme When Hide Label At Preview      theme_icon=${RATING_PREVIEW_ANSWERS_THEME}
    Delete a Rating     audience=User       rating_name=${rating_name}
    Capture Page Screenshot
