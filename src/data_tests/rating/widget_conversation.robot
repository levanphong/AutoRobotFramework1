*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${job_familly}      Job family test rating

*** Test Cases ***
Create hire conversation and job family for rating
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add Hire conversation       conversation for rating
    Public the conversation
    Go to Jobs page
    ${check} =      Run Keyword And Return Status       Check Element Display On Screen     ${JOB_FAMILY_NAME_AT_MAIN}      ${job_familly}
    IF  '${check}' == 'False'
        Create new job family       ${job_familly}
    END


Prepare data for test rating star
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    @{answers_value}=       Create List     Bad     Bad 1       Good    Good 2      Happy
    # data test rating star for check if Additional feedback is not require
    Create a new Rating     Candidate       rating for star     Stars       ${answers_value}    False       False
    Create a new Rating     User    rating user for star    Stars       ${answers_value}    False       False
    Create job for send rating      candidate journey for rating stars      Account Executive       ${job_familly}      Vintners Place
    Add a workflow for rating test      wf rating star      candidate journey for rating stars      rating for star     Test rating for stars
    Add a workflow for rating test      wf rating user star     candidate journey for rating stars      rating user for star    Test rating user for stars \#candidate-name     Company_Admin Workflow
    # data test rating star for check if Additional feedback is require
    Create a new Rating     Candidate       rating for star add fb      Stars       ${answers_value}    False       True
    Create a new Rating     User    rating user for star add fb     Stars       ${answers_value}    False       True
    Create job for send rating      candidate journey for rating stars add fb       Cloud Architect     ${job_familly}      Vintners Place
    Add a workflow for rating test      wf rating star add fb       candidate journey for rating stars add fb       rating for star add fb      Test rating for stars add fb
    Add a workflow for rating test      wf rating user star add fb      candidate journey for rating stars add fb       rating user for star add fb     Test rating user for stars add fb \#candidate-name      Company_Admin Workflow
    # data test rating for more 2 question
    Create a new Rating     Candidate       rating for more 2 qs    Stars       ${answers_value}    False       False       3
    Create a new Rating     User    rating user for more 2 qs       Stars       ${answers_value}    False       False       3
    Create job for send rating      candidate journey for more 2 qs     Web Designer    ${job_familly}      Vintners Place
    Add a workflow for rating test      wf rating more 2 qs     candidate journey for more 2 qs     rating for more 2 qs    Test rating for more 2 question
    Add a workflow for rating test      wf rating user more 2 qs    candidate journey for more 2 qs     rating user for more 2 qs       Test rating user for more 2 question \#candidate-name       Company_Admin Workflow


Prepare data for test rating text
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    @{answers_value}=       Create List     Bad     Fine
    # data test for rating test
    Create a new Rating     Candidate       rating for text     Text    ${answers_value}    False       False
    Create a new Rating     User    rating user for text    Text    ${answers_value}    False       False
    Create job for send rating      candidate journey for rating text       Dog Trainer     ${job_familly}      Vintners Place
    Add a workflow for rating test      wf rating text      candidate journey for rating text       rating for text     Test rating for text
    Add a workflow for rating test      wf rating user text     candidate journey for rating text       rating user for text    Test rating user for text \#candidate-name      Company_Admin Workflow
    # data test for test opend ended
    Create a new Rating     Candidate       rating for open-ended       Open-ended answer       ${answers_value}    False       False
    Create a new Rating     User    rating user for open-ended      Open-ended answer       ${answers_value}    False       False
    Create job for send rating      candidate journey for rating open_ended     President of Sales      ${job_familly}      Vintners Place
    Add a workflow for rating test      wf rating open-ended    candidate journey for rating open_ended     rating for open-ended       Test rating for open ended
    Add a workflow for rating test      wf rating user open-ended       candidate journey for rating open_ended     rating user for open-ended      Test rating user for open ended \#candidate-name    Company_Admin Workflow


Prepare data for test rating thumb
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    @{answers_value}=       Create List     Bad     Fine
    Create a new Rating     Candidate       rating_for_thumb    Thumbs      ${answers_value}
    Create a new Rating     Candidate       rating_for_thumb_with_additional_feedback       Thumbs      ${answers_value}    feed_back_toggle=True
    Create a new Rating     Candidate       rating_for_thumb_no_text    Thumbs      ${answers_value}    True
    Create a new Rating     Candidate       rating_for_thumb_with_additional_feedback_no_text       Thumbs      ${answers_value}    True    True
    Create job for send rating      cj_rating_thumbs    ${JOB_TAILOR}       ${job_familly}      ${LOCATION_NAME_2}
    Create job for send rating      cj_rating_thumbs_with_af    ${JOB_PROGRAMMER}       ${job_familly}      ${LOCATION_NAME_2}
    Create job for send rating      cj_rating_thumbs_no_text    ${JOB_LAWYER}       ${job_familly}      ${LOCATION_NAME_2}
    Create job for send rating      cj_rating_thumbs_with_af_no_text    ${JOB_CASHIER}      ${job_familly}      ${LOCATION_NAME_2}
    Add a workflow for rating test      wf_rating_thumb     cj_rating_thumbs    rating_for_thumb    Test rating for thumbs
    Add a workflow for rating test      wf_rating_thumb_with_additional_feedback    cj_rating_thumbs_with_af    rating_for_thumb_with_additional_feedback       Test rating for thumbs with additional feedback
    Add a workflow for rating test      wf_rating_thumb_no_text     cj_rating_thumbs_no_text    rating_for_thumb_no_text    Test rating for thumbs no text
    Add a workflow for rating test      wf_rating_thumb_with_additional_feedback_no_text    cj_rating_thumbs_with_af_no_text    rating_for_thumb_with_additional_feedback_no_text       Test rating for thumbs with additional feedback no text
    #   Prepare date for test rating thumb for user
    Create a new Rating     rating_name=rating_for_thumb_user       theme_name=Thumbs       answers_value=${answers_value}
    Create a new Rating     rating_name=rating_for_thumb_with_af_user       theme_name=Thumbs       answers_value=${answers_value}      feed_back_toggle=True
    Create a new Rating     rating_name=rating_for_thumb_no_text_user       theme_name=Thumbs       answers_value=${answers_value}      hide_label=True
    Create a new Rating     rating_name=rating_for_thumb_with_af_no_text_user       theme_name=Thumbs       answers_value=${answers_value}      hide_label=True     feed_back_toggle=True
    Add a workflow for rating test      wf_rating_thumb_user    cj_rating_thumbs    rating_for_thumb_user       Test rating for thumbs      Company Admin
    Add a workflow for rating test      wf_rating_thumb_with_af_user    cj_rating_thumbs_with_af    rating_for_thumb_with_af_user       Test rating for thumbs with additional feedback     Company Admin
    Add a workflow for rating test      wf_rating_thumb_no_text_user    cj_rating_thumbs_no_text    rating_for_thumb_no_text_user       Test rating for thumbs no text      Company Admin
    Add a workflow for rating test      wf_rating_thumb_with_af_no_text_user    cj_rating_thumbs_with_af_no_text    rating_for_thumb_with_af_no_text_user       Test rating for thumbs with additional feedback no text     Company Admin


Prepare data for test rating emoji
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    @{answers_value}=       Create List     Bad     Fine
    Create a new Rating     Candidate       rating_for_emoji    Emoji       ${answers_value}
    Create a new Rating     Candidate       rating_for_emoji_with_af    Emoji       ${answers_value}    feed_back_toggle=True
    Create a new Rating     Candidate       rating_for_emoji_no_text    Emoji       ${answers_value}    True
    Create a new Rating     Candidate       rating_for_emoji_with_af_no_text    Emoji       ${answers_value}    True    True
    Create job for send rating      cj_rating_emoji     ${JOB_PILOT}    ${job_familly}      ${LOCATION_NAME_2}
    Create job for send rating      cj_rating_emoji_with_af     ${JOB_DOCTOR}       ${job_familly}      ${LOCATION_NAME_2}
    Create job for send rating      cj_rating_emoji_emoji_no_text       ${JOB_FARMER}       ${job_familly}      ${LOCATION_NAME_2}
    Create job for send rating      cj_rating_emoji_with_af_no_text     ${JOB_OPTICIAN}     ${job_familly}      ${LOCATION_NAME_2}
    Add a workflow for rating test      wf_rating_emoji     cj_rating_emoji     rating_for_emoji    Test rating emoji for emoji 1
    Add a workflow for rating test      wf_rating_emoji_with_additional_feedback    cj_rating_emoji_with_af     rating_for_emoji_with_af    Test rating for emoji with additional feedback 2
    Add a workflow for rating test      wf_rating_emoji_no_text     cj_rating_emoji_emoji_no_text       rating_for_emoji_no_text    Test rating for emoji no text 3
    Add a workflow for rating test      wf_rating_emoji_with_additional_feedback_no_text    cj_rating_emoji_with_af_no_text     rating_for_emoji_with_af_no_text    Test rating for emoji with additional feedback no 4
    #  Prepare date for test rating emoji for user
    Create a new Rating     rating_name=rating_for_emoji_user       theme_name=Emoji    answers_value=${answers_value}
    Create a new Rating     rating_name=rating_for_emoji_with_af_user       theme_name=Emoji    answers_value=${answers_value}      feed_back_toggle=True
    Create a new Rating     rating_name=rating_for_emoji_no_text_user       theme_name=Emoji    answers_value=${answers_value}      hide_label=True
    Create a new Rating     rating_name=rating_for_emoji_with_af_no_text_user       theme_name=Emoji    answers_value=${answers_value}      hide_label=True     feed_back_toggle=True
    Add a workflow for rating test      wf_rating_emoji_user    cj_rating_emoji     rating_for_emoji_user       Test rating emoji for emoji 1       Company Admin
    Add a workflow for rating test      wf_rating_emoji_with_af_user    cj_rating_emoji_with_af     rating_for_emoji_with_af_user       Test rating for emoji with additional feedback 2    Company Admin
    Add a workflow for rating test      wf_rating_emoji_no_text_user    cj_rating_emoji_emoji_no_text       rating_for_emoji_no_text_user       Test rating for emoji no text 3     Company Admin
    Add a workflow for rating test      wf_rating_emoji_with_af_no_text_user    cj_rating_emoji_with_af_no_text     rating_for_emoji_with_af_no_text_user       Test rating for emoji with additional feedback no 4     Company Admin


create a new rating for text with add feedback
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Create a new Rating     Candidate       rating for text add fb      Text    ${answers_value}    False       True


create a new rating for more than 2 questions
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${add_question} =       format string       ${RATING_FEEDBACK_ADD_QUESTION}     Add Question
    Go to Ratings Builder page
    ${rating_name}=     Set Variable    rating for more questions
    Run keyword and ignore error    Input into      ${SEARCH_FOR_RATINGS_TEXT_BOX}      ${rating_name}
    ${is_existed} =     Run Keyword and Return Status       Click at    ${RATING_IN_ROW_ECLIPSE_ICON}       ${rating_name}      wait_time=5s
    IF    '${is_existed}' == 'False'
        Add Rating Title and Audience step      audience=Candidate      rating_name=${rating_name}
        Add Rating Content step with theme is Stars     rating_question=star question rating
        Check Element Display On Screen     Your changes have been saved.
        click at    ${add_question}
        Add Rating Content step with theme is not Stars     rating_question=emoji question rating
        Check Element Display On Screen     Your changes have been saved.
        click at    ${add_question}
        Add Rating Content step with theme is not Stars     theme_name=Thumbs       rating_question=thumb question rating
        Check Element Display On Screen     Your changes have been saved.
        click at    ${add_question}
        Add Rating Content step with theme is not Stars     theme_name=Text     rating_question=text question rating
        Check Element Display On Screen     Your changes have been saved.
        click at    ${add_question}
        Check Element Display On Screen     Your changes have been saved.
        Add Rating Content step with theme is not Stars     theme_name=Open-ended answer    rating_question=open ended question rating
        Rating Confirmation step
    END


create a new rating for emoji and on toggle overall feedback
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Create a new Rating     Candidate       rating for emoji overall feedback       Emoji       ${answers_value}    overall_feedback=True
    Capture Page Screenshot

*** Keywords ***
Add a workflow for rating test
    [Arguments]     ${workflow_name}    ${journey_name}     ${rating}    ${subject}    ${audience}=None
    Add a Workflow  ${workflow_name}    None    ${journey_name}     ${audience}
    Add a Task into Workflow    Capture Complete    Request Rating
    Choose Rating in Workflow Task  ${rating}
    Input into    ${TASK_RATING_EMAIL_SUBJECT}    ${subject}
    Click at    ${SAVE_TASK_BUTTON}
    Click at      ${PUBLISH_WORKFLOW_BUTTON}

Create job for send rating
    [Arguments]     ${journey_name}     ${job_name}     ${job_familly}   ${location}
    Add a Candidate Journey      ${journey_name}
    Create new job, publish and turn on my job      ${job_familly}     ${job_name}     ${location}    Company_Admin Workflow   ${journey_name}  Company_Admin Workflow
    Turn on a Job   ${job_name}
