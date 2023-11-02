*** Settings ***
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test
Documentation       Run datatest for first time robot src/data_tests/expiration_and_canceled_statuses/form_stage.robot

*** Variables ***
${location_a}               location A
${form_canceled_content}    Please reach out to your hiring manager for more information
&{candidate_information}    address=420 Nguyen Huu Tho    city=Da Nang    state=Arizona    zip_code=85043
${document_review}          Document review
${title_document_review}    Document_review_question
${personal_information}     Personal Information
${OL_T23984_CUSTOM_FORM}    OL_T23984 Custom Form
${OL_T23985_CUSTOM_FORM}    OL_T23985 Custom Form

*** Test Cases ***
Form stage - CEM - Verify Candidate's status is moved to Form Cancelled when the form is cancelled, (OL-T23944, OL-T23945, OL-T23947)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_FORM}
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_FORM_STATUS}      ${JOURNEY_CANCEL_FORM_ACTION}
    Capture page screenshot
#    Form stage - Form Cancelled - Candidate Experience - Verify UI displays when candidate opens form at Form Cancelled status (in case the contents of Form stage in Settings - Message Customization - Closed Pages are at default) (OL-T23945)
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_CANCEL_FORM_ACTION}       ${form_canceled_content}
    Capture page screenshot
#    Form stage - Form Cancelled - Candidate Experience - Verify UI displays when candidate opens form at Form Cancelled status (in case user CHANGES/EDITS the contents of Form stage in Settings - Message Customization - Closed Pages) (OL-T23947)
    Switch To User      ${TEAM_USER}
    ${random_content} =     Generate Random Text Only
    Go To Message Customize And Change Closed Page Content      ${random_content}       ${JOURNEY_CANCEL_FORM_ACTION}
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_CANCEL_FORM_ACTION}       ${random_content}
    Go To Message Customize And Change Closed Page Content      ${form_canceled_content}    ${JOURNEY_CANCEL_FORM_ACTION}
    Capture page screenshot


Form stage - Re-Send a Form - Candidate Experience - Verify UI displays when user moves candidate’s status from Form Expired back to Send Form status (OL-T23949, OL-T23950)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_FORM}      is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Wait for Olivia reply on widget
    Get link and Filling form       ${info.email}       ${info.candidate_first_name}    ${COMPANY_HIRE_ON}      is_submit=False     is_required_phone=False
    Close Window
    switch window     ${JOB_CANDIDATE_SEND_FORM} | ${COMPANY_HIRE_ON}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_FORM_STATUS}      ${JOURNEY_FORM_EXPIRED}
    Change conversation status to Send Form and Go to Form then Verify information in this Form     ${info}     ${candidate_full_name}      ${JOURNEY_FORM_STATUS}      ${JOURNEY_SEND_FORM_ACTION}
    Capture page screenshot
    #Form stage - Re-Send a Form - Candidate Experience - Verify UI displays when user moves candidate’s status from Form Cancelled back to Send Form status (OL-T23950)
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_FORM_STATUS}      ${JOURNEY_CANCEL_FORM_ACTION}
    Change conversation status to Send Form and Go to Form then Verify information in this Form     ${info}     ${candidate_full_name}      ${JOURNEY_FORM_STATUS}      ${JOURNEY_SEND_FORM_ACTION}
    Capture page screenshot


Candidate Experience_Application - Verify UI displays when candidate opens Application Expired status (OL-T23952, OL-T23954)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_APPLICATION}
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_APPLICATION_STAGE}    ${JOURNEY_APPLICATION_EXPIRED}
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_APPLICATION_EXPIRED}      ${form_canceled_content}
    Capture page screenshot
    # Candidate Experience_Application: Verify UI displays when candidate opens ApplicationExpired & the content of the Application at [Message Customization] edited (OL-T23954)
    Switch To User      ${TEAM_USER}
    ${random_content} =     Generate Random Text Only
    Go To Message Customize And Change Closed Page Content      ${random_content}       ${JOURNEY_APPLICATION_EXPIRED}
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_APPLICATION_EXPIRED}      ${random_content}
    Go To Message Customize And Change Closed Page Content      ${form_canceled_content}    ${JOURNEY_APPLICATION_EXPIRED}
    Capture page screenshot


CEM_Application: Verify Candidate's status is moved to Application Cancelled when the Application is cancelled (OL-T23956, OL-T23957, OL-T23959)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_APPLICATION}
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_APPLICATION_STAGE}    ${JOURNEY_CANCEL_APPLICATION_ACTION}
    Capture page screenshot
    # Candidate Experience_Application: Verify UI displays when candidate opens Application Canceled (OL-T23957)
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_CANCEL_APPLICATION_ACTION}    ${form_canceled_content}
    Capture page screenshot
    # Candidate Experience_Application: Verify UI displays when candidate opens Application Canceled & the content of the Application Canceled in Message Customization edited (OL-T23959)
    Switch To User      ${TEAM_USER}
    ${random_content} =     Generate Random Text Only
    Go To Message Customize And Change Closed Page Content      ${random_content}       ${JOURNEY_CANCEL_APPLICATION_ACTION}
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_CANCEL_APPLICATION_ACTION}    ${random_content}
    Go To Message Customize And Change Closed Page Content      ${form_canceled_content}    ${JOURNEY_CANCEL_APPLICATION_ACTION}
    Capture page screenshot


Application stage - Re-Send a Form - Candidate Experience - Verify UI displays when user moves candidate’s status from Application Expired back to Send Form status (OL-T23961, OL-T23962)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_APPLICATION}       is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Wait for Olivia reply on widget
    Get link and Filling form       ${info.email}       ${info.candidate_first_name}    ${COMPANY_HIRE_ON}      is_submit=False     is_required_phone=False
    Close Window
    switch window     ${JOB_CANDIDATE_SEND_APPLICATION} | ${COMPANY_HIRE_ON}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_APPLICATION_STAGE}    ${JOURNEY_APPLICATION_EXPIRED}
    Change conversation status to Send Form and Go to Form then Verify information in this Form     ${info}     ${candidate_full_name}      ${JOURNEY_APPLICATION_STAGE}    ${JOURNEY_SEND_APPLICATION_ACTION}
    Capture page screenshot
    # Application stage - Re-Send a Form - Candidate Experience - Verify UI displays when user moves candidate’s status from Application Cancelled back to Send Form status (OL-T23962)
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_APPLICATION_STAGE}    ${JOURNEY_CANCEL_APPLICATION_ACTION}
    Change conversation status to Send Form and Go to Form then Verify information in this Form     ${info}     ${candidate_full_name}      ${JOURNEY_APPLICATION_STAGE}    ${JOURNEY_SEND_APPLICATION_ACTION}
    Capture page screenshot


Onboarding stage - CEM - Verify Candidate's status is moved to Onboarding Cancelled when the Onboarding is cancelled (OL-T23968, OL-T23969, OL-T23971)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_ON_BOARDING}
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_CANCEL_ON_BOARDING_ACTION}
    Capture page screenshot
    # Onboarding stage - Onboarding Cancelled - Candidate Experience - Verify UI displays when candidate opens Onboarding at Onboarding Cancelled status
    # (in case the contents of Onboarding stage in Settings - Message Customization - Closed Pages are at default) (OL-T23969)
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_CANCEL_ON_BOARDING_ACTION}    ${form_canceled_content}
    Capture page screenshot
    # Onboarding stage - Onboarding Cancelled - Candidate Experience - Verify UI displays when candidate opens Onboarding at Onboarding Cancelled status
    # (in case user CHANGES/EDITS the contents of Onboarding stage in Settings - Message Customization - Closed Pa (OL-T23971)
    Switch To User      ${TEAM_USER}
    ${random_content} =     Generate Random Text Only
    Go To Message Customize And Change Closed Page Content      ${random_content}       ${JOURNEY_CANCEL_ON_BOARDING_ACTION}
    Go to Form's link and Check UI Form Canceled    ${candidate_full_name}      ${JOURNEY_CANCEL_ON_BOARDING_ACTION}    ${random_content}
    Go To Message Customize And Change Closed Page Content      ${form_canceled_content}    ${JOURNEY_CANCEL_ON_BOARDING_ACTION}
    Capture page screenshot


Onboarding stage - Re-Send a Form - Candidate Experience - Verify UI displays when user moves candidate’s status from Application Expired back to Send Form status (OL-T23973, OL-T23974)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_ON_BOARDING}       is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Wait for Olivia reply on widget
    Get link and Filling form       ${info.email}       ${info.candidate_first_name}    ${COMPANY_HIRE_ON}      is_submit=False     is_required_phone=False
    Close Window
    switch window     ${JOB_CANDIDATE_SEND_ON_BOARDING} | ${COMPANY_HIRE_ON}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_ON_BOARDING_EXPIRED}
    Change conversation status to Send Form and Go to Form then Verify information in this Form     ${info}     ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_SEND_ON_BOARDING_ACTION}
    Capture page screenshot
    # Onboarding stage - Re-Send a Form - Candidate Experience - Verify UI displays when user moves candidate’s status from Application Cancelled back to Send Form status (OL-T23974)
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_CANCEL_ON_BOARDING_ACTION}
    Change conversation status to Send Form and Go to Form then Verify information in this Form     ${info}     ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_SEND_ON_BOARDING_ACTION}
    Capture page screenshot


CEM - Onboarding stage - Verify ONLY when the form had been sent to candidate CAN user move the status to Form Expired - Move to Form Expired manually by user (OL-T23977, OL-T23980)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_ON_BOARDING}
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_ON_BOARDING_EXPIRED}
    Capture page screenshot
    # CEM - Onboarding stage - Verify ONLY when the form had been sent to candidate CAN user move the status to Form Cancelled (OL-T23980)
    Change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_SEND_ON_BOARDING_ACTION}
    Check Span Display      ${JOURNEY_SEND_ON_BOARDING_ACTION}
    Change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_CANCEL_ON_BOARDING_ACTION}
    Check Span Display      ${JOURNEY_CANCEL_ON_BOARDING_ACTION}
    Capture page screenshot


CEM - Onboarding stage - Verify ONLY when the form had been sent to candidate CAN user move the status to Form Expired - In case form had NOT been sent yet (OL-T23978, OL-T23981)
    Given Setup test
    Login Into System With Company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${link_job}=    Search job and get internal job link    ${JOB_CANDIDATE_SEND_ON_BOARDING}
    &{info}=    Start a conversation apply job with internal link job       ${link_job}     None    None    is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page
    Switch To User      ${CA_TEAM}
    Change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_ON_BOARDING_EXPIRED}      is_confirm=False
    Check P Text Display    Onboarding cannot be expired because it has not been sent yet
    Click At    ${OK_BTN_CONFIRM_BOX}
    Capture page screenshot
    # CEM - Onboarding stage - Verify ONLY when the form had been sent to candidate CAN user move the status to Form Cancelled: in case form had NOT been sent yet (OL-T23981)
    Change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_CANCEL_ON_BOARDING_ACTION}    is_confirm=False
    Check P Text Display    Onboarding cannot be canceled because it has not been sent yet
    Capture page screenshot


Onboarding stage - Verify ONLY when the form had been sent to candidate CAN user move the status to Form Expired: -In case candidate had FINISHED the form (OL-T23979, OL-T23982)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_SEND_ON_BOARDING}       is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Wait for Olivia reply on widget
    Get link and Filling form       ${info.email}       ${info.candidate_first_name}    ${COMPANY_HIRE_ON}      is_submit=True      is_required_phone=False
    Close Window
    switch window     ${JOB_CANDIDATE_SEND_ON_BOARDING} | ${COMPANY_HIRE_ON}
    Go to CEM page
    Switch To User      ${CA_TEAM}
    Change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_ON_BOARDING_EXPIRED}      is_confirm=False
    Verify text contain     ${MOVE_STATUS_PROFILE_BOX_VALUE}    ${candidate_full_name}\'s status can\’t be updated to Onboarding Expired because this form is already complete.
    Capture page screenshot
    # CEM - Onboarding stage - Verify ONLY when the form had been sent to candidate CAN user move the status to Form Expired: in case candidate had FINISHED the form (OL-T23982)
    Go To CEM Page
    Change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_CANCEL_ON_BOARDING_ACTION}    is_confirm=False
    Verify text contain     ${MOVE_STATUS_PROFILE_BOX_VALUE}    ${candidate_full_name}\'s status can\’t be updated to Onboarding Canceled because this form is already complete.
    Capture page screenshot


CEM - Onboarding stage - Verify form's version sent to candidate after moving status from Expired/Cancelled back to Send Form - In case a user edits and published a new version of the same form (OL-T23984)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_CUSTOM_FORM}    is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_ON_BOARDING_EXPIRED}
    Go to Form page and select a form       ${CANDIDATE_FORM_TYPE}      ${OL_T23984_CUSTOM_FORM}
    Click at    ${personal_information}
    Add A Form Task With Type And Save      Document review
    Click Publish Form
    Go To CEM Page
    Change conversation status to Send Form and Verify information in this Form after change Job's Form     ${info}     ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_SEND_ON_BOARDING_ACTION}
    Go To Form Page And Select A Form       ${CANDIDATE_FORM_TYPE}      ${OL_T23984_CUSTOM_FORM}
    Delete form task of section     ${personal_information}     ${title_document_review}
    Click Publish Form
    Capture page screenshot


CEM Onboarding stage - Verify form's version sent to candidate after moving status from Expired/Cancelled back to Send Form - In case a user changes a different form on the job builder (OL-T23985)
    ${info} =       Login with Company Hire one and apply job       ${JOB_CANDIDATE_CUSTOM_FORM}    is_spam_email=False
    ${candidate_full_name} =    Catenate    ${info.candidate_first_name.lower().capitalize()}       ${info.candidate_last_name}
    Go to CEM page then change conversation action status       ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_ON_BOARDING_EXPIRED}
    Change Job's Form and create a Form if Form not existed     ${JOB_CANDIDATE_CUSTOM_FORM}    ${JOURNEY_ON_BOARDING_STAGE}    ${CANDIDATE_FORM_TYPE}      ${OL_T23985_CUSTOM_FORM}
    Go To CEM Page
    Change conversation status to Send Form and Verify information in this Form after change Job's Form     ${info}     ${candidate_full_name}      ${JOURNEY_ON_BOARDING_STAGE}    ${JOURNEY_SEND_ON_BOARDING_ACTION}      form_is_changed=True
    Change Job's Form and create a Form if Form not existed     ${JOB_CANDIDATE_CUSTOM_FORM}    ${JOURNEY_ON_BOARDING_STAGE}    ${CANDIDATE_FORM_TYPE}      ${OL_T23984_CUSTOM_FORM}
    Capture page screenshot

*** Keywords ***
Go to Message Customize and change closed page content
    [Arguments]    ${content}    ${closed_page_type}
    Go to Message Customize
    Click At    ${MESSAGE_CUSTOMIZE_TAB_ITEM}    Closed Pages
    Click At    ${CLOSED_PAGES_TAG_ITEM}    ${closed_page_type}
    Clear Element Text With Keys    ${CLOSED_PAGES_FORM_CANCELED_CONTENT}
    Simulate Input    None    ${content}
    Click At    ${CLOSED_PAGES_BUTTON}    Save
    Check Text Display    Your changes were saved

Login with Company Hire one and apply job
    [Arguments]    ${job_name}    ${is_spam_email}=True
    Given Setup test
    Login Into System With Company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${link_job}=    Search job and get internal job link    ${job_name}
    &{info}=    Start a conversation apply job with internal link job    ${link_job}    None    None    ${is_spam_email}
    Input text for widget site    22
    [Return]    ${info}

Go to CEM page then change conversation action status
    [Arguments]    ${candidate_name}    ${conversation_status}    ${conversation_action_status}
    Go to CEM page
    Switch To User    ${CA_TEAM}
    Change conversation action status    ${candidate_name}    ${conversation_status}    ${conversation_action_status}
    Check Span Display    ${conversation_action_status}

Go to Form's link and Check UI Form Canceled
    [Arguments]    ${candidate_name}    ${form_canceled_header}    ${form_canceled_content}
    Go To CEM Page
    Click at    ${candidate_name}
    Click At    ${SEND_FORM_LINK}
    @{window} =    get window handles
    switch window    ${window}[1]
    Check Span Display    ${form_canceled_header}
    Check Span Display    ${form_canceled_content}
    Capture page screenshot
    Close Window
    switch window    ${window}[0]

Verify personal information form displays correctly
    [Arguments]    ${fname}    ${lname}    ${email}
    Verify Display Text With Get Text Value    ${FORM_FIRST_NAME_TEXTBOX}    ${fname.lower().capitalize()}
    Verify Display Text With Get Text Value    ${FORM_LAST_NAME_TEXTBOX}    ${lname}
    Verify Display Text With Get Text Value    ${FORM_EMAIL_ADDRESS_TEXTBOX}    ${email}
    Verify Display Text With Get Text Value    ${FORM_STREET_ADDRESS_LINE_1_TEXTBOX}    ${candidate_information.address}
    Verify Display Text With Get Text Value    ${FORM_CITY_TEXTBOX}    ${candidate_information.city}
    Verify Display Text With Get Text Value    ${FORM_STATE_TEXTBOX}    ${candidate_information.state}
    Verify Display Text With Get Text Value    ${FORM_ZIPCODE_TEXTBOX}    ${candidate_information.zip_code}

Change conversation status to Send Form and Go to Form then Verify information in this Form
    [Arguments]    ${info}    ${candidate_name}    ${state}    ${state_status}
    Change conversation action status    ${candidate_name}    ${state}    ${state_status}
    Check Span Display    ${state_status}
    Sleep    5s
    Click At    ${LAST_SEND_FORM_LINK}
    switch window    title:Complete Your Form for ${COMPANY_HIRE_ON}
    wait until page contains    Enter Verification Code
    Enter code for verify code step    ${info.candidate_first_name}
    Verify personal information form displays correctly    ${info.candidate_first_name}    ${info.candidate_last_name}    ${info.email}
    Close Window
    switch window    title:All Candidates | Candidate Experience Manager

Change conversation status to Send Form and Verify information in this Form after change Job's Form
    [Arguments]    ${info}    ${candidate_name}    ${state}    ${state_status}    ${form_is_changed}=False
    Change conversation action status    ${candidate_name}    ${state}    ${state_status}
    Check Span Display    ${state_status}
    Wait With Medium Time
    Click At    ${LAST_SEND_FORM_LINK}
    switch window    title:Complete Your Form for ${COMPANY_HIRE_ON}
    wait until page contains    Enter Verification Code
    Enter code for verify code step    ${info.candidate_first_name}
    IF    '${form_is_changed}' == 'True'
        Check Element Display On Screen    ${FORM_DOCUMENT_REVIEW_TITLE}    ${title_document_review}
    ELSE
        Check Element Display On Screen    ${FORM_FIRST_NAME_TEXTBOX}
        Check Element Display On Screen    ${FORM_MIDDLE_NAME_TEXTBOX}
        Check Element Display On Screen    ${FORM_LAST_NAME_TEXTBOX}
        Check Element Display On Screen    ${FORM_PHONE_NUMBER_TEXTBOX}
        Check Element Display On Screen    ${FORM_EMAIL_ADDRESS_TEXTBOX}
        Check Element Display On Screen    ${FORM_STREET_ADDRESS_LINE_1_TEXTBOX}
        Check Element Display On Screen    ${FORM_STREET_ADDRESS_LINE_2_TEXTBOX}
        Check Element Display On Screen    ${FORM_CITY_TEXTBOX}
        Check Element Display On Screen    ${FORM_STATE_TEXTBOX}
        Check Element Display On Screen    ${FORM_ZIPCODE_TEXTBOX}
    END
	switch window    title:All Candidates | Candidate Experience Manager

Go to Form page and select a form
    [Arguments]    ${form_type}    ${form_name}
    Go To Form Page
    Wait For Page Load Successfully
    Select form type    ${form_type}
    Input into    ${SEARCH_FORM_TEXTBOX}    ${form_name}
    Click at    ${form_name}

Change Job's Form and create a Form if Form not existed
    [Arguments]    ${job_name}    ${form_stage}    ${form_type}    ${form_name}
    Go to form page
    Wait For Page Load Successfully
    Select form type    ${form_type}
    Input into    ${SEARCH_FORM_TEXTBOX}    ${form_name}
    ${is_existed_form}=    Run Keyword And Return Status    Check element display on screen    ${FORM_BY_NAME}    ${form_name}
    IF    '${is_existed_form}' == 'False'
        Add new form and input name    ${form_type}    ${form_name}
        Go to a form section detail    Personal Information
        Add A Form Task With Type And Save    Document review
        Click Publish Form
    END
    Go To Jobs Page
    Wait For Page Load Successfully
    Click on job name    ${job_name}
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Wait For The Element To Fully Load    ${NEW_JOB_DROPDOWN_ATTENDEE}
    Click at    ${CANDIDATE_JOURNEY_SEND_FORM_STAGE}    ${form_stage}
    Click by JS    ${CANDIDATE_JOURNEY_FORM_NAME_OPTION}    ${form_name}    1s
    Click at    ${SAVE_JOB_BUTTON}
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${NEW_JOB_PUBLISH_BUTTON}
    Wait Element Visible    ${STATUS_PUBLISHED}
