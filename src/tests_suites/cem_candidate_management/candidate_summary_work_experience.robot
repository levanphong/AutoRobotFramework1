*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_summary_builder_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../commons/actions/get_actions.robot
Resource            ../../pages/forms_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test
Documentation       Run data test src/data_tests/cem_candidate_management/candidate_summary_work_experience_data_test.robot

*** Variables ***
&{work_experience}                  your_job_title=DEV    company_name=Olivia    location=Da Nang    date_started=01/01/2020    date_end=10/15/2021
${job_name}                         OL-T11532_Automation_Test
@{work_experience_fields_value}     DEV    Olivia    Da Nang    2020-01-01    2021-10-15
@{work_experience_fields}           Your Job title    Company name    Location    Date started    Date ended

*** Test Cases ***
Verify show data at work experience section (OL-T11533,OL-T11532)
    Given Setup Test
    When Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Filling form and not submit form
    &{info}=    Apply job and filling form      is_submit=No
    @{window} =     get window handles
    switch window       ${window}[0]
    Go to CEM page
    Search and click candidate on CEM       ${info.candidate_first_name}
    Check text display      Work Experience
    Click on span text      Work Experience
    Check Work Experience field display correctly
    # Verify don't show work experience if candidate hasn't submitted a form
    Check Work Experience field value not display
    # Submit form and check
    switch window       ${window}[1]
    Click at    ${FORM_SUBMIT_BUTTON}
    Check text display      Thank you!
    switch window       ${window}[0]
    reload page
    Search and click candidate on CEM       ${info.candidate_first_name}
    # Check UI for Work Experience section
    Check text display      Work Experience
    capture page screenshot
    Click on span text      Work Experience
    Check Work Experience field display correctly
    Check Work Experience field value display correctly

*** Keywords ***
Apply job and filling form
    [Arguments]     ${is_submit}=None
    ${link_job}=        Search job and get internal job link    ${job_name}
    &{info}=     Start a conversation apply job with internal link job       ${link_job}
    Reply a screening question      ${REPROMPT_AGE_MESSAGE_1}       20
    ${is_display}=      run keyword and return status       Check Message Widget Site Response Correct      ${EVENT_CONTACT_QUESTION}
    IF      '${is_display}'=='True'
        Click on option in conversation    Email Only
        Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    END
    Get link and Filling form       ${info.email}       ${info.candidate_first_name}        ${COMPANY_HIRE_ON}    ${work_experience}     ${is_submit}
    [Return]    &{info}

Check Work Experience field display correctly
    FOR     ${I}    IN     @{work_experience_fields}
        Check element display on screen     ${CEM_CANDIDATE_SUMMARY_WORK_EXPERIENCE_ITEM}      ${I}
    END
    capture page screenshot

Check Work Experience field value display correctly
    FOR     ${I}    IN     @{work_experience_fields_value}
        Check element display on screen     ${CEM_CANDIDATE_SUMMARY_WORK_EXPERIENCE_INFORMATION_FIELD}     ${I}
    END
    capture page screenshot

Check Work Experience field value not display
    FOR     ${I}    IN     @{work_experience_fields_value}
        Check element not display on screen     ${CEM_CANDIDATE_SUMMARY_WORK_EXPERIENCE_INFORMATION_FIELD}     ${I}
    END
    capture page screenshot
