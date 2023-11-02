*** Settings ***
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/system_attributes_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${la_custom_add}                \#la-add_custom
${la_country}                   \#la-country
${event_conversation_name}      Event_Convo_Single_Path
${value_location_attr_a}        230 trung nu vuong
${interview_session}            in_person_scheduled_interviews_test
${reschedule_message}           Here are the details for your upcoming 15 minute in-person interview

*** Test Cases ***
Verify User can add Location Attribute on Events (OL-T12909)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Confirmation
    Add location attributtes for sms tab    Phone    ${la_country}
    Add location attributtes for email tab    Phone    ${la_country}
    Click at    Initial Request
    Add location attributtes for sms tab    Phone    ${la_country}
    Add location attributtes for email tab    Phone    ${la_country}
    Click at    Confirmation
    Return origin sms message    Phone
    Return origin email message    Phone
    Click at    Initial Request
    Return origin sms message    Phone
    Return origin email message    Phone
    Capture page screenshot


Verify candidate receives the interview invitation via SMS, mail has location attribute in case Initial Interview Request: In-person (OL-T12910)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Initial Request
    Add location attributtes for sms tab    In-person    ${la_custom_add}
    Add location attributtes for email tab    In-person    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add Event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    Capture page screenshot
    wait with medium time
    Verify user has received the email    ${COMPANY_EVENT} would like to schedule in-person
    ...    Hi ${candidate_name}, ${value_location_attr_a}       WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV
    Capture page screenshot


Verify candidate receives Trigger Modified Job Search After Registration Confirmed has location attributes (OL-T12913)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Job Search & Chat to Apply
    Add location attributtes for sms tab    Initial Job Search Request    ${la_custom_add}
    Add location attributtes for email tab    Initial Job Search Request    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_name} =     Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =    Input infor candidate on event widget site    ${event_name}
    Capture page screenshot
    Verify user has received the email    Fast-Track your Event Experience & Apply for a Job Now!
    ...    Hi ${candidate_info.first_name}! ${value_location_attr_a}    FAST_TRACK_APPLY_EVENT_JOB


Verify Candidate receives the candidate's reschedule message via SMS, Web correctly (OL-T12915)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Candidate Initiates Reschedule
    Add location attributtes for sms tab    Candidate Initiates Reschedule    ${la_custom_add}
    Add location attributtes for email tab    Validate Reschedule    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add Event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    wait with medium time
    Click button in email    ${COMPANY_EVENT} would like to schedule    Hi ${candidate_name}!       WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}    slow_down=1s
    Capture page screenshot
    Open Chrome
    Click button in email    Your in-person interview at ${COMPANY_EVENT}    Hi ${candidate_name}!
    ...    YOUR_IN_PERSON_INTERVIEW
    Click at    Yes
    wait with medium time
    Capture page screenshot
    Candidate input to landing site     1
    Verify Olivia conversation message display      ${reschedule_message}
    Capture page screenshot


Verify Candidate receives the user's cancelled pending request message via SMS, Email correctly (OL-T12917)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    User Cancels Pending Request
    Add location attributtes for sms tab    User Cancels Pending Request    ${la_custom_add}
    Add location attributtes for email tab    User Cancels Pending Request    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add Event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    Click at    ${ALL_CANDIDATES_SCHEDULE_UPDATE_BUTTON}
    Click at    ${CANCEL_REQUEST}
    Click at    ${CONFIRM_CANCEL_REQUEST}
    Capture page screenshot
    wait with medium time
    Verify user has received the email    Your pending in-person interview with
    ...    Hi ${candidate_name}. ${value_location_attr_a}    CANCEL_SCHEDULE
    Capture page screenshot


Verify Candidate receives the User's reschedule message via SMS, Email correctly (OL-T12919)
    #   TODO maintain
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    User Initiates Reschedule
    Add location attributtes for sms tab    User Initiates Reschedule    ${la_custom_add}
    Add location attributtes for email tab    User Initiates Reschedule    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_name}=  Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =    Input infor candidate on event widget site    ${event_name}
    Go to CEM page
    Reschedule event interview    ${candidate_info.first_name}  ${event_name}  ${interview_session}
    Capture page screenshot
    wait with medium time
    Verify user has received the email    ${COMPANY_EVENT} needs to reschedule your
    ...    Hi ${candidate_info.first_name}. ${value_location_attr_a}    NEED_RESCHEDULE_INTERVIEW
    Capture page screenshot


Verify candidate receives the Cancelled Event Interview msg which has value of candidate's location calendar when user cancels event interview. (OL-T12920)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    User Initiates Cancelation
    Add location attributtes for sms tab    User Initiates Cancel    ${la_custom_add}
    Add location attributtes for email tab    User Initiates Cancel    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add Event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    Capture page screenshot
    Click button in email    ${COMPANY_EVENT} would like to schedule    Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}    slow_down=1s
    Go to CEM page
    Cancel event interview    ${candidate_name}
    Capture page screenshot
    wait with medium time
    Verify user has received the email    ${COMPANY_EVENT} needs to cancel your in-person interview
    ...    ${value_location_attr_a}    CANCEL_SCHEDULE
    Capture page screenshot


Verify candidate receives an email when an event has been cancelled correctly incase Candidate has status Event Interview pending (OL-T12922)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Event Canceled
    Add location attributtes for sms tab    Event is Cancelled    ${la_custom_add}
    Add location attributtes for email tab    Event is Cancelled    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    Select an event and cancel event    ${event_dynamic_name}
    Capture page screenshot
    wait with medium time
    Verify user has received the email
    ...    The ${event_dynamic_name} event with
    ...    Hi ${candidate_name}. ${value_location_attr_a}    CANCEL_SCHEDULE


Verify candidate receives an email when an event has been cancelled correctly incase Candidate has status Event Interview Scheduled (OL-T12923)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Event Canceled
    Add location attributtes for sms tab    Event is Cancelled    ${la_custom_add}
    Add location attributtes for email tab    Event is Cancelled    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    Click button in email    ${COMPANY_EVENT} would like to schedule    Hi ${candidate_name}!   WOULD_LIKE_TO_SCHEDULE_IN_PERSON_ITV
    Click at    ${SCHEDULE_SELECT_TIME_BUTTON}    slow_down=1s
    Select an event and cancel event    ${event_dynamic_name}
    Capture page screenshot
    wait with medium time
    Verify user has received the email
    ...    The ${event_dynamic_name} event with
    ...    Hi ${candidate_name}. ${value_location_attr_a}    CANCEL_SCHEDULE


Verify candidate receives an email when an event has been cancelled correctly incase Candidate has status Registration Confirmed (OL-T12924)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Event Canceled
    Add location attributtes for sms tab    Event is Cancelled    ${la_custom_add}
    Add location attributtes for email tab    Event is Cancelled    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to Events page
    Search event      ${event_dynamic_name}
    Click at    ${event_dynamic_name}
    ${candidate_info} =     Manually add a Candidate to Event   is_spam_email=False     location=${LOCATION_STREET_TRUNG_NU_VUONG}
    Select an event and cancel event    ${event_dynamic_name}
    Capture page screenshot
    Verify user has received the email
    ...    The ${event_dynamic_name} event with ${COMPANY_EVENT}
    ...    Hi ${candidate_info.first_name}. ${value_location_attr_a}    CANCEL_SCHEDULE
    Capture page screenshot


Verify candidate receives an email when an event has been edited correctly (OL-T12925)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Edits to Events
    Add location attributtes for sms tab    who have a scheduled interview    ${la_custom_add}
    Add location attributtes for email tab    who have a scheduled interview    ${la_custom_add}
    Click at        ${CLOSE_MODAL_ICON}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${event_dynamic_name} =    Create event go to widget site    ${event_conversation_name}
    Capture page screenshot
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    location_name=${LOCATION_STREET_TRUNG_NU_VUONG}     is_spam_email=False
    Add event schedule to candidate    ${event_dynamic_name}    ${candidate_name}    ${interview_session}
    Update start day and schedule time for event    ${event_dynamic_name}
    Capture page screenshot
    Verify user has received the email
    ...     ${COMPANY_EVENT} needs to reschedule your in-person interview
    ...     Hi ${candidate_name}. ${value_location_attr_a}    YOUR_IN_PERSON_INTERVIEW
    Capture page screenshot
