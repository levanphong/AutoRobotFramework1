*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/ratings_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        regression    test

Documentation       Run data test on src/data_tests/rating/widget_conversation.robot file before run test

*** Variables ***
@{answers_value_star}       Bad    Bad 1    Good    Good 2    Happy
${color_hover_star}         rgba(248, 248, 248, 1)
@{answers_value_text}       Bad    Good
${color_text}               rgba(37, 201, 208, 1)
${rating_request}           RATING_REQUEST
@{answer_values}            Bad    Fine

*** Test Cases ***
User's Email - Check behavior of Star when a candidate hover on it (OL-T26901, OL-T26902, OL-T26903 , OL-T26904)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Account Executive
    Click button in email       Test rating user for stars ${candidate_name}    Hi ${ca_user}       RATING_REQUEST      index_button=10
    # Candidate's Email - Check behavior of Star when a candiate hover on it (OL-T26901)
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    # User's Email - Check behavior of stars when a candidate makes a selection (OL-T26902)
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS}     Submit
    # User's Email - Check behavior of stars when a candidate doesn't make additional feedback (OL-T26904)
    Check page success when submit feedback     Submit Feedback


User's Email - Check behavior of text when a candidate hover on it (OL-T26925, OL-T26926, OL-T26927 )
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Dog Trainer
    Click button in email       Test rating user for text ${candidate_name}     Hi ${ca_user}       RATING_REQUEST      index_button=4
    # Candidate's Email - Check behavior of text when a candidate hover on it (OL-T26925)
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_text}       None
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      ${color_text}
    # User's Email - Check behavior of text when a candidate makes a selection (OL-T26926)
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      Submit Feedback
    # User's Email - Check behavior of text when a candidate makes additional feedback (OL-T26927)
    Check page success when submit feedback     Submit Feedback


User's Email - Check if Additional feedback is require (OL-T26906)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Cloud Architect
    Click button in email       Test rating user for stars add fb ${candidate_name}     Hi ${ca_user}       RATING_REQUEST      index_button=10
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${RATING_EMAIL_PREVIEW_ANSWERS}     Submit
    Check page success when submit feedback     Submit Feedback


User's Email - Check if Additional feedback is not require (OL-T26906)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Cloud Architect
    Click button in email       Test rating user for stars add fb ${candidate_name}     Hi ${ca_user}       RATING_REQUEST      index_button=10
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS}     Submit
    Check page success when submit feedback     Submit Feedback


User's Email - Check behavior of Open-ended answer when a candidate input data (OL-T26897, OL-T26931)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     President of Sales
    Click button in email       Test rating user for open ended ${candidate_name}       Hi ${ca_user}       RATING_REQUEST      index_button=0
    Check page success when submit feedback with overall feedback


User's Email - Check if there are more than 2 questions (OL-T26930)
    ${candidate_name}=      Chat widget for send rating     WidgetForSendRating     Web Designer
    Click button in email       Test rating user for more 2 question ${candidate_name}      Hi ${ca_user}       RATING_REQUEST      index_button=10
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_star}       ${RATING_EMAIL_PREVIEW_ANSWERS_STAR}
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS}     ${color_hover_star}
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS}     Next
    click button    Next
    Check Display theme and label at Preview in email       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT}    @{answers_value_text}       None
    Check background color when hover       ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      ${color_hover_star}
    Check display when select feedback      ${RATING_EMAIL_PREVIEW_ANSWERS_TEXT_HOVER}      Next
    Check page success when submit feedback with overall feedback       Next


User's Email - Check behavior of thumbs when a candidate hover on it (OL-T26913, OL-T26914)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_TAILOR}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for user thumb      Hi ${ca_user}       ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${thumb_theme}      @{answer_values}    ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}


User's Email - Check behavior of thumbs when a candidate makes additional feedback (OL-T26915)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_PROGRAMMER}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for user thumbs with af     Hi ${ca_user}       ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${thumb_theme}      @{answer_values}    ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${thumb_theme_text}     Submit Feedback
    Check Page Success When Submit Feedback     Submit Feedback


User's Email - Check behavior of thumbs with no text when a candidate hover on it (OL-T26921,OL-T26922)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_LAWYER}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for user thumbs no text     Hi ${ca_user}       ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}


User's Email - Check behavior of thumbs with no text when a candidate makes additional feedback (OL-T26923)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_CASHIER}
    ${thumb_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_thumb
    ${thumb_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_thumb
    ${thumb_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_thumb
    Click button in email       Test rating for user thumbs with af no text     Hi ${ca_user}       ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${thumb_theme_icon}
    Check background color when hover       ${thumb_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${thumb_theme_text}     Submit Feedback
    Check Page Success When Submit Feedback     Submit Feedback


User's Email - Check behavior of emoji when a candidate hover on it (OL-T26908, OL-T26910)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_PILOT}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating user emoji 1    Hi ${ca_user}       ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${emoji_theme}      @{answer_values}    ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}


User's Email - Check behavior of emojis when a candidate makes additional feedback (OL-T26911)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_DOCTOR}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating for user emoji af 2     Hi ${ca_user}       ${rating_request}       index_button=4
    Check Display theme and label at Preview in email       ${emoji_theme}      @{answer_values}    ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${emoji_theme_text}     Submit Feedback
    Check Page Success When Submit Feedback     Submit Feedback


User's Email - Check behavior of emojis with no text when a candidate hover on it (OL-T26917,OL-T26918)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_FARMER}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating for user emoji no text 3    Hi ${ca_user}       ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}


User's Email - Check behavior of emojis with no text when a candidate makes additional feedback (OL-T261919)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Chat widget for send rating     WidgetForSendRating     ${JOB_OPTICIAN}
    ${emoji_theme} =    Format String       ${RATING_EMAIL_ANSWERS_THEME}       rating_emoji
    ${emoji_theme_text} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_TEXT}      rating_emoji
    ${emoji_theme_icon} =       Format String       ${RATING_EMAIL_ANSWERS_THEME_ICON}      rating_emoji
    Click button in email       Test rating for user emoji with af no 4     Hi ${ca_user}       ${rating_request}       index_button=2
    Check Display theme when hide label at Preview      ${emoji_theme_icon}
    Check background color when hover       ${emoji_theme_text}     ${color_hover_star}
    Check display when select feedback with Additional feedback     ${emoji_theme_text}     Submit Feedback
    Check Page Success When Submit Feedback     Submit Feedback

