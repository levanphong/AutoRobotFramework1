*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/alert_management_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/my_jobs_page.robot
Documentation       Run data test on src/data_tests/alert/notification_candidate_request.robot file

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${contain_text}                     OL-T1039 Alert
${conversation_hire_name}           OL-T1039 Hire
${OL-T1039_user_cp_name}            OL-T1039 User
${subject_low_rating_pattern}       {} rated their candidate experience as 1
${content_low_rating_pattern}       {} rated their candidate experience as 1. You may want to review their experience and follow up with them.

*** Test Cases ***
Check Web Alerts (OL-T1039)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${random_mail} =    Generate random name    ${CONFIG.gmail}
    ${random_name} =    Generate Candidate Name
    ${url_job} =    Turn on job and get internal job link       ${AUTOMATION_TESTER_TITLE_070}
    Go to job conversation and apply jobs       ${url_job}
    Input Text For Widget Site      ${random_name.full_name}
    Verify last message content should be       ${REPROMPT_EMAIL_MESSAGE_6}     site_type=Widget
    Input Text For Widget Site      ${random_mail}
    Verify last message content should be       ${ASK_AGE}      site_type=Widget
    Input Text For Widget Site      20
    Check Message Widget Site Response Correct      auto_rating_question    wait_time=20
    Input Text For Widget Site      1
    Capture Page Screenshot
    Go To CEM Of Company
    switch to user      ${OL-T1039_user_cp_name}
    # verify user has received alert there is a low rating "#candidate-name rated their experience #rating"
    Click At    ${CEM_NOTIFICATION_ICON}
    Run Keyword And Ignore Error    Click At    ${NOTIFICATIONS_RATED_LOW_TODAY}
    Check Element Display On Screen     ${NOTIFICATION_RATED_LOW_TEMPLATE}      ${random_name.full_name}
    Capture Page Screenshot
    ${subject_low_rating} =     Format String       ${subject_low_rating_pattern}       ${random_name.full_name}
    ${content_low_rating} =     Format String       ${content_low_rating_pattern}       ${random_name.full_name}
    Verify user has received the email      ${subject_low_rating}       ${content_low_rating}


Admin View - Separate Candidate Experience into other sections (OL-T1050)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Alert Management page
    Click At    ${CANDIDATE_EXPERIENCE_BUTON}
	# Candidate Experience is separated into other sections
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_RATINGS_SECTION}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_REQUESTS_SECTION}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_TOPIC_SELECTION_SECTION}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_TITLE}
    # Verify Candidate Rating Section
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_RATINGS_TITLE}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_RATINGS_DESCRIPTION}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_RATINGS_TITLE}
    # Verify Candidate Requests Section
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_REQUESTS_TITLE}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_REQUESTS_DESCRIPTION}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_REQUESTS_INPUT}
    # Verify Candidate Topic Selections Section
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_TOPIC_SELECTION_TITLE}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_TOPIC_SELECTION_DESCRIPTION}
    Check Element Display On Screen     ${CANDIDATE_EXPERIENCE_TOPIC_SELECTION_INPUT}
    Capture Page Screenshot


Full User View - Separate Candidate Alert section into Candidate Rating and Candidate Request (OL-T1054)
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Switch To User      ${CP_TEAM}
    Go To Alert Management Page
    # Two more sections: Candidate Rating and Candidate Request
    Check Element Display On Screen     ${CANDIDATE_REQUEST_ALERT_SECTION}
    Check Element Display On Screen     ${CANDIDATE_RATING_ALERT_SECTION}
    # Verify Candidate Request section		Verify UI match zeplin: <https://zpl.io/a8oXlBX>
    Check Element Display On Screen     ${CANDIDATE_REQUEST_ALERT_TITLE}
    Check Element Display On Screen     ${CANDIDATE_REQUEST_ALERT_DESCRIPTION}
    Check Element Display On Screen     ${CANDIDATE_REQUEST_ALERT_TOGGLE}
    # Verify Candidate Rating section		Verify UI match zeplin: <https://zpl.io/VYglPwk>
    Check Element Display On Screen     ${CANDIDATE_RATING_ALERT_TITLE}
    Check Element Display On Screen     ${CANDIDATE_RATING_ALERT_DESCRIPTION}
    Check Element Display On Screen     ${CANDIDATE_RATING_ALERT_TOGGLE}
    Capture Page Screenshot
