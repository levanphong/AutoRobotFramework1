*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

Documentation       Client Setup > Hire > Forms toggle ON, Jobs toggle ON, Candidate Journey toggle ON
...                 Client Setup > More > Workflow toggle ON
...                 Run data test in src/data_tests/form/candidate_form_status_movement_data_test.robot

*** Variables ***
${location}                     Florida
${status_movement_form_job}     Status Movement Form Job
${form_in_progress}             Form In-Progress
${form_complete}                Form Complete
${hire_stage}                   Hire
${hired_status}                 Hired
${application_stage}            Application
${send_application}             Send Application
${application_in_progress}      Application In-Progress
${application_complete}         Application Complete
${onboarding_stage}             Onboarding
${send_onboarding}              Send Onboarding
${onboarding_in_progress}       Onboarding In-Progress
${onboarding_complete}          Onboarding Complete

*** Test Cases ***
Verify form status is changed to 'Form In-Progress' when candidate clicks on form link (OL-T20283, OL-T20286)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${status_movement_form_job}      is_spam_email=False
    Change status to send form and open form     ${candidate_name}      ${COMPANY_NEXT_STEP}
    Open new tab same browser
    @{window} =    get window handles
    Switch window    ${window}[1]
    Go to CEM page
    Check status of candidate is correct    ${candidate_name}       ${form_in_progress}
    # Verify form status is not updated to "Form Complete" again in case the candidate opens the form link after moving to another status (OL-T20286)
    Switch window    ${window}[0]
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Switch window    ${window}[1]
    Reload page
    Check status of candidate is correct    ${candidate_name}       ${form_complete}
    Change status of candidate with stage and status    ${candidate_name}      ${hire_stage}      ${hired_status}
    Click at    ${SEND_FORM_LINK}
    Switch window    ${window}[1]
    Go to CEM page
    Check status of candidate is correct    ${candidate_name}       ${hired_status}


Verify form status is changed to 'Application In-Progress' when candidate clicks on form link (OL-T20284, OL-T20287)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${status_movement_form_job}      is_spam_email=False
    Change status of candidate and send form     ${candidate_name}      ${application_stage}   ${send_application}       ${COMPANY_NEXT_STEP}
    Open new tab same browser
    @{window} =    get window handles
    Switch window    ${window}[1]
    Go to CEM page
    Check status of candidate is correct    ${candidate_name}       ${application_in_progress}
    # Verify form status is not updated to "Application Complete" again in case the candidate opens the form link after moving to another status (OL-T20287)
    Switch window    ${window}[0]
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Switch window    ${window}[1]
    Reload page
    Check status of candidate is correct    ${candidate_name}       ${application_complete}
    Change status of candidate with stage and status    ${candidate_name}      ${hire_stage}      ${hired_status}
    Click at    ${SEND_FORM_LINK}
    Switch window    ${window}[1]
    Go to CEM page
    Check status of candidate is correct    ${candidate_name}       ${hired_status}


Verify form status is changed to 'Onboarding In-Progress' when candidate clicks on form link (OL-T20285, OL-T20288)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Switch to user      ${CA_TEAM}
    ${candidate_name}=    Add a Candidate   None    ${location}    ${status_movement_form_job}      is_spam_email=False
    Change status of candidate and send form     ${candidate_name}      ${onboarding_stage}     ${send_onboarding}      ${COMPANY_NEXT_STEP}
    Open new tab same browser
    @{window} =    get window handles
    Switch window    ${window}[1]
    Go to CEM page
    Check status of candidate is correct    ${candidate_name}       ${onboarding_in_progress}
    # Verify form status is not updated to "Onboarding Complete" again in case the candidate opens the form link after moving to another status (OL-T20288)
    Switch window    ${window}[0]
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Switch window    ${window}[1]
    Reload page
    Check status of candidate is correct    ${candidate_name}       ${onboarding_complete}
    Change status of candidate with stage and status    ${candidate_name}      ${hire_stage}      ${hired_status}
    Click at    ${SEND_FORM_LINK}
    Switch window    ${window}[1]
    Go to CEM page
    Check status of candidate is correct    ${candidate_name}       ${hired_status}

*** Keywords ***
Check status of candidate is correct
    [Arguments]     ${candidate_name}       ${status}
    Click at        ${candidate_name}
    ${actual_status}=   Get text and format text    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Should be equal as strings      ${status}       ${actual_status}
    Capture page screenshot

Change status of candidate and send form
    [Arguments]     ${candidate_name}   ${stage}    ${status}   ${company_name}
    Change status of candidate with stage and status    ${candidate_name}   ${stage}    ${status}
    Click button in email    Complete your form at ${company_name}      Hi ${candidate_name}!       COMPLETE_ASSESSMENT
    Enter code for verify code step   ${candidate_name}
