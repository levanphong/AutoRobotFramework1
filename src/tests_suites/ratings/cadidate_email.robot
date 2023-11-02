*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/ratings_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

Documentation       Run data test on src/data_tests/rating/widget_conversation.robot file before run test

*** Variables ***
@{answers_value_star}       Bad    Bad 1    Good    Good 2    Happy
${color_hover_star}         rgba(248, 248, 248, 1)
@{answers_value_text}       Bad    Fine
${color_text}               rgba(37, 201, 208, 1)
${rating_request}           RATING_REQUEST


*** Test Cases ***
Candidate's Email - Check behavior of Star when a candidate hover on it (OL-T26869, OL-T26870, OL-T26871, OL-T26872, OL-T26873)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Account Executive
    Click button in email       Test rating for star    Hi ${candidate_name}    RATING_REQUEST      index_button=10
    # Candidate's Email - Check behavior of Star when a candiate hover on it (OL-T26869, OL-T26871, OL-T26873)
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    # Candidate's Email - Check behavior of stars when a candidate makes a selection (OL-T26870)
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS}     Submit
    # Candidate's Email - Check behavior of stars when a candidate doesn't make additional feedback (OL-T26872)
    Check page success when submit feedback    Submit Feedback


Candidate's Email - Check behavior of text when a candidate hover on it (OL-T26893, OL-T26894)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Dog Trainer
    Click button in email       Test rating for text    Hi ${candidate_name}    RATING_REQUEST      index_button=4
    # Candidate's Email - Check behavior of text when a candidate hover on it (OL-T26893)
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_text}       None
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      ${color_text}
    # Candidate's Email - Check behavior of text when a candidate makes a selection (OL-T26894)
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      Submit Feedback


Candidate's Email - Check if Additional feedback is require (OL-T26874)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Cloud Architect
    Click button in email       Test rating for star    Hi ${candidate_name}    RATING_REQUEST      index_button=10
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${RATING_EMAIL_PREVIEW_ANSWERS}     Submit
    Check page success when submit feedback    Submit Feedback


Candidate's Email - Check if a candidate makes a selection by clicking on icon (OL-T26877)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Account Executive
    Click button in email       Test rating for star    Hi ${candidate_name}    RATING_REQUEST      index_button=1
    ${thank_you_text}=      format string       ${RATING_EMAIL_PREVIEW_THANK_YOU}       ${MESSAGE_THANK_YOU_FEEDBACK}
    Check element display on screen     ${thank_you_text}
    capture page screenshot


Candidate's Email - Check behavior of Open-ended answer when a candidate input data (OL-T26897, OL-T26899)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     President of Sales
    Click button in email       Test rating for open ended      Hi ${candidate_name}    RATING_REQUEST      index_button=0
    Check page success when submit feedback with overall feedback


Candidate's Email - Check if there are more than 2 questions (OL-T26898)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Web Designer
    Click button in email       Test rating for more 2 question     Hi ${candidate_name}    RATING_REQUEST      index_button=10
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS}     Next
    click button    Next
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_text}       None
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      ${color_hover_star}
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      Next
    Check page success when submit feedback with overall feedback      Next


Candidate's Email - Check behavior of thumbs when a candidate hover on it (OL-T26881, OL-T26882)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_TAILOR}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for thumbs      Hi ${candidate_first_name}      ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${thumb_theme}      @{answers_value_text}    ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}


Candidate's Email - Check behavior of thumbs when a candidate makes additional feedback (OL-T26883, OL-T26895)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_PROGRAMMER}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for thumbs with additional feedback     Hi ${candidate_first_name}      ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${thumb_theme}      @{answers_value_text}    ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${thumb_theme_text}     Submit Feedback
    Check page success when submit feedback     Submit Feedback


Candidate's Email - Check behavior of thumbs with no text when a candidate hover on it (OL-T26889,OL-T26890)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_LAWYER}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for thumbs no text      Hi ${candidate_first_name}      ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}


Candidate's Email - Check behavior of thumbs with no text when a candidate makes additional feedback (OL-T26891)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_CASHIER}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for thumbs with additional feedback no text     Hi ${candidate_first_name}      ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${thumb_theme_text}     Submit Feedback
    Check page success when submit feedback     Submit Feedback


Candidate's Email - Check behavior of emoji when a candidate hover on it (OL-T26876, OL-T26878)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_PILOT}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating emoji for emoji 1       Hi ${candidate_first_name}      ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${emoji_theme}      @{answers_value_text}    ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}


Candidate's Email - Check behavior of emoji when a candidate makes additional feedback (OL-T26879)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_DOCTOR}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating for emoji with additional feedback 2    Hi ${candidate_first_name}      ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${emoji_theme}      @{answers_value_text}    ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${emoji_theme_text}     Submit Feedback
    Check page success when submit feedback     Submit Feedback


Candidate's Email - Check behavior of emoji with no text when a candidate hover on it (OL-T26885,OL-T26886)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_FARMER}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating for emoji no text 3     Hi ${candidate_first_name}      ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}


Candidate's Email - Check behavior of emojis with no text when a candidate makes additional feedback (OL-T26887)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${candidate_first_name}=    Chat widget for send rating     WidgetForSendRating     ${JOB_OPTICIAN}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating for emoji with additional feedback no 4     Hi ${candidate_first_name}      ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${emoji_theme_text}     Submit Feedback
    Check page success when submit feedback     Submit Feedback
