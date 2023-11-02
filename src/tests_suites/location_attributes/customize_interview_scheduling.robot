*** Settings ***
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/system_attributes_page.robot
Variables           ../../constants/ConversationConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

Documentation       Turn ON Advanced Scheduling Settings. Schedulling > Advanced Scheduling Settings
...                 Choose Basic User Access = Basic User Portal - Task in Account Overview tab at Client Setup

*** Variables ***
${value_location_attr_b}        Nguyen Huu Tho
${value_location_attr_a}        trung nu vuong
${la_custom_add}                \#la-add_custom
${la_country}                   \#la-country
${text_interview_scheduling}    Interview Scheduling

*** Test Cases ***
Verify User can add Location Attribute on Scheduling Interview (OL-T12886)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    Select a Time
    Add location attributtes for sms tab    Select a Time    ${la_country}
    Add location attributtes for email tab    Select a Time    ${la_country}
    Click at    Select a Time
    Click at    ${SMS_TAB}
    Check element display on screen    ${la_country}
    Click at    ${EMAIL_TAB}
    Check element display on screen    ${la_country}
    Click at    Select a Time
    Click at    ${SMS_TAB}
    Return origin sms message    Select a Time
    Click at    ${EMAIL_TAB}
    Return origin email message    Select a Time


Verify candidate receives the interview invitation via Email has location attribute correctly incase In-Person interview (OL-T12888)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    Initial Interview Request
    Add location attributtes for sms tab    In-Person    ${la_custom_add}
    Add location attributtes for email tab    In-Person    ${la_custom_add}
    Go to CEM page
    Switch to user   ${EE_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${EE_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    Verify user has received the email    ${COMPANY_EVENT} would like to schedule
    ...    ${value_location_attr_b}   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV


Verify Candidate receives the cancelled In-Person Interview via SMS and Email correctly (OL-T12892)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    User Initiates Cancel
    Add location attributtes for sms tab    User Initiates Cancel    ${la_custom_add}
    Add location attributtes for email tab    User Initiates Cancel    ${la_custom_add}
    Go to CEM page
    Switch to user    ${FO_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${FO_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Go to CEM page
    Click at    ${candidate_name_locator}
    Click at    ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    ${CANCEL_INTERVIEW_BUTTON}
    Click at    ${CONFIRM_CANCEL_INTERVIEW_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    Check element display on screen      ${CANCEL_UPCOMING_INTERVIEW_MESSAGE}
    Verify user has received the email    ${COMPANY_EVENT} needs to cancel your in-person interview
    ...    Hi ${candidate_name}. ${value_location_attr_b}    YOUR_IN_PERSON_INTERVIEW


Verify Candidate receives the user cancel pending request via SMS, Email correctly with In-Person interview type (OL-T12893)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    User Cancels Pending Request
    Add location attributtes for sms tab    User Cancels Pending Request    ${la_custom_add}
    Add location attributtes for email tab    User Cancels Pending Request    ${la_custom_add}
    Go to CEM page
    Switch to user    ${FS_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${FS_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    Click at    ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    ${CANCEL_INTERVIEW_BUTTON}
    Click at    ${CONFIRM_CANCEL_INTERVIEW_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    Check element display on screen      ${CANCEL_PENDING_INTERVIEW_MESSAGE}
    Verify user has received the email    Your pending in-person interview with ${COMPANY_EVENT}
    ...    ${value_location_attr_b}    CANCEL_SCHEDULE


Verify Candidate receives the user initiates reschedule message via SMS, Email correctly with In-Person interview type (OL-T12895)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    User Initiates Reschedule
    Add location attributtes for sms tab    User Initiates Reschedule    ${la_custom_add}
    Add location attributtes for email tab    User Initiates Reschedule    ${la_custom_add}
    Go to CEM page
    Switch to user    ${FS_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add interview schedule to candidate    ${EE_TEAM}    ${LOCATION_STREET_TRUNG_NU_VUONG}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!       WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Go to CEM page
    Click on candidate name       ${candidate_name}
    Click at    ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    Reschedule
    Click at    ${RESCHEDULE_BUTTON_IN_MODAL}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Check element display on screen      ${RESCHEDULE_INTERVIEW_MESSAGE}
    Verify user has received the email    ${COMPANY_EVENT} needs to reschedule your
    ...    Hi ${candidate_name}. I was asked to reschedule your    NEED_RESCHEDULE_INTERVIEW


Verify Candidate receives the candidate initiates reschedule message via SMS, Web correctly with In-Person interview type (OL-T12896)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    Candidate Initiates Reschedule
    Add location attributtes for sms tab    Validate Reschedule    ${la_custom_add}
    Add location attributtes for email tab    Validate Reschedule    ${la_custom_add}
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Add interview schedule to candidate    ${CA_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Wait for page load successfully
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!       WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV    index_button=2
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Wait for page load successfully
    Click button in email    Your in-person interview at ${COMPANY_EVENT}    Hi ${candidate_name}!      YOUR_IN_PERSON_INTERVIEW
    Click at    Yes
    Verify Olivia conversation message display  ${SESSION_CALENDAR_LINK}
    Candidate input to landing site     3
    wait with medium time
    Verify user has received the email    Your in-person interview at ${COMPANY_EVENT}
    ...    Hi ${candidate_name}! ${value_location_attr_b}    YOUR_IN_PERSON_INTERVIEW


Verify Candidate receives Miscellaneous Messages via Web (OL-T12898)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    ${USER_TAB}
    Click at    Miscellaneous Messages
    Add location attributtes for sms tab    Email Interview Reminder Closing    ${la_custom_add}
    Add location attributtes for email tab    Email Interview Reminder Closing    ${la_custom_add}
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${CA_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Go to CEM page
    Click at    ${candidate_name_locator}
    Click at    ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    ${CANCEL_INTERVIEW_BUTTON}
    Click at    ${CONFIRM_CANCEL_INTERVIEW_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    Check element display on screen      ${CANCEL_PENDING_INTERVIEW_MESSAGE}
    Verify user has received the email    Your pending in-person interview with ${COMPANY_EVENT}
    ...    Hi ${candidate_name}. ${value_location_attr_b}    CANCEL_SCHEDULE


Verify user receives interview confirmation via SMS, Email correctly with In-Person interview type (OL-T12899)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    ${USER_TAB}
    Click at    Interview Confirmed
    Add location attributtes for sms tab    In-Person    ${la_custom_add}
    Add location attributtes for email tab    In-Person    ${la_custom_add}
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${CA_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV    index_button=1
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Verify user has received the email    Your in-person interview with ${candidate_name}
    ...    Hi ${CA_TEAM}! ${value_location_attr_b}   YOUR_IN_PERSON_INTERVIEW


Verify user receives Interview Canceled via Email correctly with In-Person interview type (OL-T12900)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    ${USER_TAB}
    Click at    Interview Canceled
    Add location attributtes for email tab    Interview Canceled    ${la_custom_add}
    Go to CEM page
    Switch to user    ${FO_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${FO_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV    index_button=2
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Go to CEM page
    Click on candidate name     ${candidate_name}
    Click at       ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    ${CANCEL_INTERVIEW_BUTTON}
    Click at    ${CONFIRM_CANCEL_INTERVIEW_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    Check element display on screen      ${CANCEL_UPCOMING_INTERVIEW_MESSAGE}
    Verify user has received the email    Canceled: Your in-person interview with ${candidate_name}
    ...    Hi ${FO_TEAM}! ${value_location_attr_b}    CANCEL_SCHEDULE


Verify candidate receives the interview reschedule via SMS, Email correctly with In-Person interview type (OL-T12901)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    User Initiates Reschedule
    Add location attributtes for sms tab    User Initiates Reschedule    ${la_custom_add}
    Add location attributtes for email tab    User Initiates Reschedule    ${la_custom_add}
    Go to CEM page
    Switch to user    ${EE_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add interview schedule to candidate    ${EE_TEAM}    ${LOCATION_STREET_TRUNG_NU_VUONG}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV    index_button=2
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Go to CEM page
    Click at    ${candidate_name_locator}
    Click at    ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    Reschedule
    Click at    ${RESCHEDULE_BUTTON_IN_MODAL}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Check element display on screen      ${RESCHEDULE_INTERVIEW_MESSAGE}
    Verify user has received the email    ${COMPANY_EVENT} needs to reschedule your
    ...   Hi ${candidate_name}! ${value_location_attr_a}    NEED_RESCHEDULE_INTERVIEW


Verify the message is sent to user via Email correctly in case Candidate Initiates Reschedule with In-Person interview type (OL-T12902)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    ${USER_TAB}
    Click at    Candidate Initiates Reschedule
    Add location attributtes for sms tab    Candidate Initiates Reschedule    ${la_custom_add}
    Add location attributtes for email tab    Candidate Initiates Reschedule    ${la_custom_add}
    Go to CEM page
    Switch to user    ${FS_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${FS_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV    index_button=1
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Click button in email    Your in-person interview at ${COMPANY_EVENT}    Hi ${candidate_name}!      YOUR_IN_PERSON_INTERVIEW
    Click at    Yes
    Verify user has received the email    Canceled: Your in-person interview with ${candidate_name}
    ...    ${value_location_attr_b}    CANCEL_SCHEDULE


Verify the message is sent to user via Email correctly in case that user is Olivia Coordinate (OL-T12906)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    ${USER_TAB}
    Click at    Olivia Coordinate
    Add location attributtes for sms tab    Attendee Scheduling New Task    ${la_custom_add}
    Add location attributtes for email tab    Attendee Scheduling New Task    ${la_custom_add}
    Go to CEM page
    Switch to user    ${EE_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add Have Attendee Schedule    ${BS_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Wait for page load successfully
    Verify user has received the email    Schedule Interview with ${candidate_name}    ${value_location_attr_b}
    ...    NEW_TASK


Verify the location attributes displays correctly when Updating the Interview Location (OL-T12908)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${text_interview_scheduling}
    Click at    Interview Confirmed
    Add location attributtes for sms tab    In-Person    ${la_custom_add}
    Add location attributtes for email tab    Interview Details Confirmation    ${la_custom_add}
    Go to CEM page
    Switch to user    ${FS_TEAM}
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_NGUYEN_HUU_THO}     is_spam_email=False
    Add interview schedule to candidate    ${FS_TEAM}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen      ${DO_ANY_OF_THESE_TIMES_WORK}
    Click button in email    ${COMPANY_EVENT} would like to schedule    	Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV    index_button=2
    Wait for page load successfully
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}
    Go to CEM page
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click at    ${candidate_name_locator}
    Edit candidate    ${LOCATION_STREET_TRUNG_NU_VUONG}
    Click at    ${CEM_UPDATE_INTERVIEW_REQUEST}
    Click at    Reschedule
    Click at    ${RESCHEDULE_BUTTON_IN_MODAL}
    Click at    ${SCHEDULE_AN_INTERVIEW_CONFIRM_CLOSE_BTN}
    Check element display on screen      ${RESCHEDULE_INTERVIEW_MESSAGE}
    Verify user has received the email    ${COMPANY_EVENT} needs to reschedule your   Hi ${candidate_name}! ${value_location_attr_a}    NEED_RESCHEDULE_INTERVIEW
