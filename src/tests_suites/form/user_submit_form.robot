*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

Documentation       Turn ON Form toggle at Client Setup Hire
...                 Turn ON Next Steps toggle at Client Setup Hire
...                 Turn ON Job toggle at Client Setup Hire
...                 Create 'CJ Send Form' candidate journey
...                 Create 'Send form workflow' with 'CJ Send Form' Candidate journey
...                 Run create data test at form_data_test.robot file

*** Variables ***
${job_family}                   Coffee Jobs
${test_location_name}           Florida
${error_message_required}       This Field is Required
${error_message_validate}       Please only use letters, spaces, dashes, and apostrophes
${thank_you_message}            Thank you for completing the form!

*** Test Cases ***
Check the display of Custom Question task on User Form Experience screen in case Required toggle is ON (OL-T14458, OL-T14453)
    [Tags]      skip
    # TODO https://paradoxai.atlassian.net/browse/OL-75339
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate and click send form button
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location_user_form}    ${job_short_answer_user_form}
    # Verify display error mesage
	Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click by JS       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	Click at        ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}
	Input into      ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}    value
	Clear element text with keys    ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}
    Check span display      ${error_message_required}
    Capture page screenshot
    # Verify display [Status Update] screen
    Input into      ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}        Yes
    Capture page screenshot
    Click at        ${FORM_EXPERIENCE_NEXT_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_STATUS_SEND_FORM}
    Check span display    ${thank_you_message}
    Capture page screenshot
    # Verify submit form success
    Verify submit form success and delete data test


Check the display of Custom Question task with Check box type on User Form Experience screen (OL-T14457)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${CA_TEAM}
    # Add candidate and click send form button
    ${candidate_name}=    Add a Candidate   None    ${location_user_form}      ${job_checkbox_user_form}
    Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	# Verify display [Status Update] screen
    Click at       ${FORM_OPTION_CHECK_BOX}    Checkbox 1
    Click at       ${FORM_OPTION_CHECK_BOX}    Checkbox 2
    Capture page screenshot
    Click at       ${FORM_EXPERIENCE_NEXT_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_STATUS_SEND_FORM}
    Check span display    ${thank_you_message}
    Capture page screenshot
    # Verify submit form success
    Verify submit form success and delete data test


Check the display of Custom Question task with Paragraph type on User Form Experience screen (OL-T14454)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate and click send form button
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location_user_form}   ${job_paragraph_user_form}
    Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	# Verify display [Status Update] screen
	Input into      ${FORM_INPUT_TEXT_PARAGRAPH_TEXTAREA}       Input test for Paragraph
	Capture page screenshot
    Click at       ${FORM_EXPERIENCE_NEXT_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_STATUS_SEND_FORM}
    Check span display    ${thank_you_message}
    Capture page screenshot
    # Verify submit form success
    Verify submit form success and delete data test


Check the display of Custom Question task with Drop down type on User Form Experience screen (OL-T14456)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Switch to user      ${CA_TEAM}
    # Add candidate and click send form button
    ${candidate_name}=    Add a Candidate   None    ${location_user_form}   ${job_drop_down_user_form}
    Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	# Verify display [Status Update] screen
	Click at       ${FORM_SHOW_MENU_BUTTON}
    CHECK ELEMENT DISPLAY ON SCREEN       ${FORM_ITEM_TASK_DROP_DOWN}    Drop down 1
    Click at       ${FORM_ITEM_TASK_DROP_DOWN}    Drop down 2
    Capture page screenshot
    Click at       ${FORM_EXPERIENCE_NEXT_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_STATUS_SEND_FORM}
    Check span display    ${thank_you_message}
    Capture page screenshot
    # Verify submit form success
    Verify submit form success and delete data test


Check the display of Custom Question task with Multi Choice type on User Form Experience screen (OL-T14455)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate and click send form button
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${test_location_name}   ${job_multi_choice_user_form}
    Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	# Verify display [Status Update] screen
    Check element display on screen       ${COMMON_SPAN_TEXT}    Radio button 1
    Click at       ${COMMON_SPAN_TEXT}    Radio button 2
    Capture page screenshot
    Click at       ${FORM_EXPERIENCE_NEXT_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_STATUS_SEND_FORM}
    Check span display    ${thank_you_message}
    Capture page screenshot
    # Verify submit form success
    Verify submit form success and delete data test


Check the validation Custom Question task type on User Form Experience screen when Custom Question task type setting validation (OL-T14459)
    [Tags]      skip
    # TODO https://paradoxai.atlassian.net/browse/OL-75339
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    # Add candidate and click send form button
    Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location_user_form}   ${job_short_answer_user_form}
    Click at       ${SET_CANDIDATE_JOURNEYS_BUTTON}
	Click at       ${CEM_CANDIDATE_JOURNEY_SEND_FORM_BUTTON}
	# Verify display [Status Update] screen and check show message validate
	Input value and verify display error message      ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}        12345
	Clear element text with keys        ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}
	Input value and verify display error message      ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}        @@@$$$***
	Clear element text with keys        ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}
    Input into      ${FORM_EXPERIENCE_YOUR_ANSWER_INPUT}        Test validate text
    Capture page screenshot
    Click at       ${FORM_EXPERIENCE_NEXT_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_STATUS_SEND_FORM}
    Check span display    ${thank_you_message}
    Capture page screenshot
    # Verify submit form success
    Verify submit form success and delete data test

*** Keywords ***
Verify submit form success and delete data test
    Click at     ${FORM_EXPERIENCE_SAVE_AND_CONFIRM_BUTTON}
    Check element display on screen     ${CANDIDATE_JOURNEY_STATUS}     Send Form
	Capture page screenshot

Input value and verify display error message
    [Arguments]     ${locator}      ${value}
	Input into      ${locator}        ${value}
	Check span display      ${error_message_validate}
	Capture page screenshot
