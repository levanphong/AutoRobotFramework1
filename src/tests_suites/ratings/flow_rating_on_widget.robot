*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/ratings_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regresstion    test
Documentation       step 1: Run data test on src/data_tests/rating/add_rating_in_convesation.robot file
...                 step 2: Create WidgetForSendRatingStar, WidgetForSendRatingEmoji, WidgetForSendRatingThumbs, WidgetForSendRatingText,WidgetForSendRatingOpenEnded
...                 step 3: Choose conversation is "conversation for rating"

*** Test Cases ***
Web - Finish Conversation - Verify UI and check behavior of star theme rating (OL-T26803,OL-T26804,OL-T26805,OL-T26806)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Verify UI and check behavior of star theme rating (OL-T26803,OL-T26804,OL-T26805)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingStar     option_theme=rating for star
    Verify UI and check behavior of star theme rating in widget
    # when a candidate makes additional feedback(OL-T26806)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingStar     option_theme=rating for star add fb
    Verify UI and check behavior of star theme rating in widget     add_feedback=True


Web - Finish Conversation - Verify UI and check behavior of emoji theme rating (OL-T26807,OL-T26808,OL-T26809,OL-T26810,OL-T26816,OL-T26817,OL-T26818)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Verify UI and check behavior of emoji theme rating (OL-T26807,OL-T26808,OL-T26809)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingEmoji    option_theme=rating_for_emoji
    Verify UI and check behavior of theme rating in widget not star
    # when a candidate makes additional feedback (OL-T26810)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingEmoji    option_theme=rating_for_emoji_with_additional_feedback
    Verify UI and check behavior of theme rating in widget not star     add_feedback=True
    # emoji with no text (OL-T26816,OL-T26817)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingEmoji    option_theme=rating_for_emoji_no_text
    Verify UI and check behavior of theme rating in widget not star     hide_label=True
    # emoji with no text when a candidate makes additional feedback (OL-T26818)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingEmoji    option_theme=rating_for_emoji_with_af_no_text
    Verify UI and check behavior of theme rating in widget not star     add_feedback=True       hide_label=True
    Capture Page Screenshot


Web - Finish Conversation - Verify UI and check behavior of thumb theme rating (OL-T268011,OL-T268012,OL-T268013,OL-T26814,OL-T26819,OL-T26820,OL-T26821,OL-T26822)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Verify UI and check behavior of thumb theme rating (OL-T268011,OL-T268012,OL-T268013)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingThumbs       option_theme=rating_for_thumb
    Verify UI and check behavior of theme rating in widget not star
    # when a candidate makes additional feedback (OL-T26814)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingThumbs       option_theme=rating_for_thumb_with_additional_feedback
    Verify UI and check behavior of theme rating in widget not star     add_feedback=True
    # thumb with no text (OL-T26819,OL-T26820,OL-T26821)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingThumbs       option_theme=rating_for_thumb_no_text
    Verify UI and check behavior of theme rating in widget not star     hide_label=True
    # thumb with no text when a candidate makes additional feedback (OL-T26822)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingThumbs       option_theme=rating_for_thumb_with_additional_feedback_no_text
    Verify UI and check behavior of theme rating in widget not star     add_feedback=True       hide_label=True


Web - Finish Conversation - Verify UI and check behavior of text theme rating (OL-T26823,OL-T26824,OL-T26825,OL-T26826)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Verify UI and check behavior of text theme rating (OL-T26823,OL-T26824,OL-T26825)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingText     option_theme=rating for text
    Verify UI and check behavior of text theme rating in widget
    # when a candidate makes additional feedback(OL-T26826)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingText     option_theme=rating for text add fb
    Verify UI and check behavior of text theme rating in widget     add_feedback=True


Web - Finish Conversation - Check behavior of Open-ended answer when a candidate input data (OL-T26828,OL-T26829,OL-T26830)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingOpenEnded    option_theme=rating for open-ended
    Verify UI and Check behavior of Open-ended answer when a candidate input data
    # rating for more than 2 questions (OL-T26829)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingOpenEnded    option_theme=rating for more questions
    Verify UI and Check behavior of icons in case there are more than 2 questions
    # rating for Overall feedback (OL-T26830)
    Change rating and finish chat with widget for send rating       widget_name=WidgetForSendRatingOpenEnded    option_theme=rating for emoji overall feedback
    Verify UI and Check behavior of Candidate makes Overall feedback
    Capture Page Screenshot
