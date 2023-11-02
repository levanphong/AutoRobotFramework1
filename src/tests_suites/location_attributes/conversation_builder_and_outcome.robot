*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/custom_conversation_page.robot
Resource            ../conversation/common_features/skip_next_question/skip_next_question.resource
Variables           ../../constants/ConversationConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${la_location_name_single}      Location_LA_single
${la_location_email}            olivia.automation@paradox.ai
${la_location_phone_single}     +12025550159
${la_location_id_single}        123456
${la_address_single}            500 Nguyen Huu Tho Street
${la_address_2_single}          123
${la_city_single}               New York
${la_country}                   US
${la_zipcode_single}            10005
${la_location_name_multi}       Location_LA_multiple
${la_location_phone_multi}      +12516315555
${la_location_id_multi}         56789
${la_address_multi}             460 Nguyen Huu Tho Street
${la_city_multi}                Washington
${la_zipcode_multi}             98093

*** Test Cases ***
Check Location Attribute list shows correctly at Outbound section when 1 location is assigned to single conversation (OL-T13450)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_OUTBOUND_INPUT}    Outbound \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_OUTBOUND_INPUT}    name    false
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate and Screen    Location_LA_single
    Select Screening conversation and send    ${conversation_name}
    Click on candidate name    ${candidate_name}
    ${conversation_text} =    format string    ${CONVERSATION_TEXT}    Location_LA_single
    Check element display on screen    ${conversation_text}
    Capture page screenshot


Check Location Attribute list shows correctly at Global screening section when 1 location is assigned to single conversation (OL-T13451)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Input into    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    How old are you ? \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    phone    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Introduction section when 1 location is assigned to single conversation (OL-T13452)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_INTRODUCTION_INPUT}    address    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Contact Information section when 1 location is assigned to single conversation (OL-T13453)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Contact Information \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    address_2    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at EEO section when 1 location is assigned to single conversation (OL-T13454)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_EEO_INPUT}    EEO \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_EEO_INPUT}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Communication Preference section when 1 location is assigned to single conversation (OL-T13455)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Click at    ${EMAIL_TOGGLE}
    Scroll to element    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}
    Input into    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    Communication Preference \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    id    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Closing section when 1 location is assigned to single conversation (OL-T13456)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CLOSING_INPUT}    country    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Thank you section when 1 location is assigned to single conversation (OL-T13457)
    #TODO maintain
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-location_name
    Click at      ${EMAIL_TOGGLE}
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Contact Information \#la-location_phone
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Add question for Conversation   ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you? \#la-location_email  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Click at    ${SCREENING_QUESTION_1_LABEL}
    Input into    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    Communication Preference \#la-location_id
    Input into    ${CONVERSATION_EEO_INPUT}    EEO \#la-zipcode
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-address
    Input into    ${CONVERSATION_THANKYOU_INPUT}    Thank you \#la-country
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Run the landing site/widget site    Landing Site    ${conversation_name}
    Verify Olivia conversation message display      ${QUESTION_EMAIL}
    ${email} =    Generate random name    ${CONFIG.gmail}
    Candidate input to landing site    ${CONVERSATION_INPUT_TEXTBOX}    ${email}
    Verify Olivia conversation message display    ${la_location_id_single}
    Click on option in landing page    Email Only
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Verify Olivia conversation message display    ${la_zipcode_single}
    Click at    ${CONVERSATION_SKIP_EEO_BUTTON}
    Verify Olivia conversation message display    ${la_address_single}
    Candidate input to landing site     ${CONVERSATION_INPUT_TEXTBOX}     Ok. Nothing today. Thanks
    Click at    ${CONVERSATION_SEND_BUTTON}
    Verify Olivia conversation message display    ${la_country}
    Capture page screenshot


Check Location Attribute list shows correctly at Outbound section when multiple locations are assigned to single conversation (OL-T13458)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_OUTBOUND_INPUT}    Outbound \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_OUTBOUND_INPUT}    name    false
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate and Screen    Location_LA_multiple
    Select Screening conversation and send    ${conversation_name}
    Click on candidate name   ${candidate_name}
    ${conversation_text} =    format string    ${CONVERSATION_TEXT}    Location_LA_multiple
    Check element display on screen    ${conversation_text}
    Capture page screenshot


Check Location Attribute list shows correctly at Introduction section when multiple locations are assigned to single conversation (OL-T13459)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_INTRODUCTION_INPUT}    phone    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Contact Information sectionwhen multiple locations are assigned to single conversation (OL-T13460)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Contact Information \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Global Screening section when multiple locations are assigned to single conversation (OL-T13462)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Input into    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    How old are you ? \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    phone    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Communication Preference section when multiple locations are assigned to single conversation (OL-T13463)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click at   ${EMAIL_TOGGLE}
    Scroll to element    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}
    Input into    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    Communication Preference \#la-location_
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    id    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at EEO section when multiple locations are assigned to single conversation (OL-T13464)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_EEO_INPUT}    EEO \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_EEO_INPUT}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Closing section when multiple locations are assigned to single conversation (OL-T13465)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CLOSING_INPUT}    country    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Thank you section when multiple locations are assigned to single conversation (OL-T13466)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-location_name
    Click at    ${EMAIL_TOGGLE}
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Contact Information \#la-location_phone
    Input into    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    Communication Preference \#la-location_id
    Click by JS     ${COMMUNICATION_PREFERENCE_TOGGLE}
    Input into    ${CONVERSATION_EEO_INPUT}    EEO \#la-zipcode
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-address
    Input into    ${CONVERSATION_THANKYOU_INPUT}    Thank you \#la-country
    Capture page screenshot
    Public the conversation
    Go to edit conversation     ${conversation_name}
    Click by JS     ${COMMUNICATION_PREFERENCE_TOGGLE}
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Add question for Conversation   ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you? \#la-location_email  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Public the conversation
    Capture page screenshot
    Run the landing site/widget site    Landing Site    ${conversation_name}
    &{email_info} =    Get email for testing
    ${email} =      Set variable    ${email_info.email}
    Verify Olivia conversation message display      Contact Information
    ${phone_number} =   Generate Random String      6    [NUMBERS]
    Input text and send message      +12025${phone_number}
    Verify Olivia conversation message display      ${QUESTION_EMAIL}
    Input text and send message     ${email}
    Verify Olivia conversation message display      ${ASK_AGE}
    Input text and send message     30
    Verify Olivia conversation message display      ${LOCATION_DISCOVERY}
    Input text and send message     2
    Click at    ${CONVERSATION_SKIP_EEO_BUTTON}
    Verify Olivia conversation message display     ${la_zipcode_multi}
    Verify Olivia conversation message display    ${la_address_multi}
    Input text and send message     Ok. Nothing today. Thanks
    Verify Olivia conversation message display      ${la_country}
    Capture page screenshot


Check Location Attribute list shows correctly at Schedule in Screening and Action When multiple locations are assigned to single path conversation (OL-T13467)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Schedule
    Input into    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TEXTBOX}    Schedule \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TEXTBOX}    zipcode    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Schedule to event in Screening and Action section When multiple locations are assigned to single path conversation (OL-T13468)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    ${LOCATION_STREET_TRUNG_NU_VUONG}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Schedule to Event
    Input into    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TO_EVENT_TEXTBOX}    Schedule to event \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TO_EVENT_TEXTBOX}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Override Closing Message in Screening and Action section when multiple locations are assigned to single path conversation (OL-T13469)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Override Closing Message
    Input into    ${SCREENING_AND_ACTION_SEND_OVERRIDE_CLOSING_MESSAGE_TEXTBOX}    Override Closing Message \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_OVERRIDE_CLOSING_MESSAGE_TEXTBOX}    city    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Outbound section when a location are assigned to multiple path conversation (OL-T13470)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_OUTBOUND_INPUT}    Outbound \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_OUTBOUND_INPUT}    name    false
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate and Screen    Location_LA_single
    Select Screening conversation and send    ${conversation_name}
    Click on candidate name    ${candidate_name}
    ${conversation_text} =    format string    ${CONVERSATION_TEXT}    Location_LA_single
    Check element display on screen    ${conversation_text}
    Capture page screenshot


Check Location Attribute list shows correctly at Outbound section when multiple location are assigned to multiple path conversation (OL-T13471)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_OUTBOUND_INPUT}    Outbound \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_OUTBOUND_INPUT}    name    false
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Go to CEM page
    Switch to user    ${CA_TEAM}
    ${candidate_name} =    Add a Candidate and Screen    Location_LA_multiple
    Select Screening conversation and send    ${conversation_name}
    Click on candidate name   ${candidate_name}
    ${conversation_text} =    format string    ${CONVERSATION_TEXT}    Location_LA_multiple
    Check element display on screen    ${conversation_text}
    Capture page screenshot


Check Location Attribute list shows correctly at Introduction section when multiple locations are assigned to multiple conversation (OL-T13472)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_INTRODUCTION_INPUT}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Contact Information section when multiple locations are assigned to multiple conversation (OL-T13473)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Introduction \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    id    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Contact Information section when single locations are assigned to multiple conversation (OL-T13474)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select a location at Available locations    Location_LA_single
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Introduction \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    id    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Global screening section when multiple locations are assigned to multiple conversation (OL-T13475)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Input into    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    How old are you ? \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    phone    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Communication Preference section when multiple locations are assigned to multiple conversation (OL-T13476)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click at   ${EMAIL_TOGGLE}
    Scroll to element    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}
    Input into    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    Communication Preference \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    state    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at EEO section when multiple locations are assigned to multiple conversation (OL-T13477)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_EEO_INPUT}    EEO \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_EEO_INPUT}    address    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Closing section when multiple locations are assigned to multiple conversation (OL-T13478)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CLOSING_INPUT}    country    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Thank you section when multiple locations are assigned to multiple conversation (OL-T13479)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-location_name
    Click at    ${EMAIL_TOGGLE}
    Input into    ${CONVERSATION_CONTACT_INFORMATION_INPUT}    Contact Information \#la-location_phone
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Add question for Conversation    ${GROUP_QUESTION_CONTENT}  How old are you? \#la-location_email  ${GROUP_1_QUESTION_1_LABEL}  Age
    Input into    ${CONVERSATION_COMMUNICATION_PREFERENCE_INPUT}    Communication Preference \#la-location_id
    Input into    ${CONVERSATION_EEO_INPUT}    EEO \#la-location_name
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-address
    Input into    ${CONVERSATION_THANKYOU_INPUT}    Thank you \#la-country
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Run the landing site/widget site    Landing Site    ${conversation_name}
    &{email_info} =    Get email for testing
    ${email} =      Set variable    ${email_info.email}
    Verify Olivia conversation message display      Contact Information
    ${phone_number} =   Generate Random String      6    [NUMBERS]
    Input text and send message      +12025${phone_number}
    Verify Olivia conversation message display      ${QUESTION_EMAIL}
    Input text and send message    ${email}
    Wait with medium time
    Input text and send message     1
    Verify Olivia conversation message display      ${ASK_AGE}
    Input text and send message     25
    Verify Olivia conversation message display      ${LOCATION_DISCOVERY}
    Input text and send message     2
    Click at    ${CONVERSATION_SKIP_EEO_BUTTON}
    Verify Olivia conversation message display    ${la_location_name_multi}
    Verify Olivia conversation message display    ${la_address_multi}
    Input text and send message     Ok. Nothing today. Thanks
    Verify Olivia conversation message display    ${la_country}
    Capture page screenshot


Check Location Attribute list shows correctly at Schedule in Screening and Action when multiple locations are assigned to multiple path conversation (OL-T13480)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Scroll to element    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Schedule
    Input into    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TEXTBOX}    Schedule \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TEXTBOX}    address_2    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Schedule to event in Screening and Action section when multiple locations are assigned to multiple path conversation (OL-T13481)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    ${LOCATION_STREET_TRUNG_NU_VUONG}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Scroll to element    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Schedule to Event
    Input into    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TO_EVENT_TEXTBOX}    Schedule to event \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TO_EVENT_TEXTBOX}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Override Closing Message in Screening and Action section when multiple locations are assigned to multiple path conversation (OL-T13482)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Multiple Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Multiple Path
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Override Closing Message
    Input into    ${SCREENING_AND_ACTION_SEND_OVERRIDE_CLOSING_MESSAGE_TEXTBOX}    Override Closing Message \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_OVERRIDE_CLOSING_MESSAGE_TEXTBOX}    city    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Closing section when multiple locations are assigned to candidate journey template conversation (OL-T13483)
    [Tags]    advantage    aramark    birddoghr    fedexstg    lowes_stg    olivia    pepsi    plg    regis    stg    unilever
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Candidate Journey_${random}
    when Add new conversation with name and type    ${conversation_name}    Candidate Journey
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CLOSING_INPUT}    name    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Thank you section when multiple locations are assigned to candidate journey template conversation (OL-T13484)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Candidate Journey_${random}
    when Add new conversation with name and type    ${conversation_name}    Candidate Journey
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Input into    ${CONVERSATION_THANKYOU_INPUT}    Thank you \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_THANKYOU_INPUT}    phone    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Schedule in Screening and Action when multiple locations are assigned to Candidate journey template conversation (OL-T13485)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Candidate Journey_${random}
    when Add new conversation with name and type    ${conversation_name}    Candidate Journey
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Schedule
    Input into    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TEXTBOX}    Schedule \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TEXTBOX}    zipcode    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Schedule to event in Screening and Action section when multiple locations are assigned to Candidate journey template conversation (OL-T13486)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Candidate Journey_${random}
    when Add new conversation with name and type    ${conversation_name}    Candidate Journey
    when Select multiple locations at Available locations    ${LOCATION_STREET_TRUNG_NU_VUONG}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Schedule to Event
    Input into    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TO_EVENT_TEXTBOX}    Schedule to event \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_SCHEDULE_TO_EVENT_TEXTBOX}    email    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Override Closing Message in Screening and Action section when multiple locations are assigned to Candidate journey template conversation (OL-T13487)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Candidate Journey_${random}
    when Add new conversation with name and type    ${conversation_name}    Candidate Journey
    when Select multiple locations at Available locations    Location_LA_single    Location_LA_multiple
    Click by JS    ${ADD_SCREENING_AND_ACTION_BUTTON}
    Select Screening and Action Then option    Override Closing Message
    Input into    ${SCREENING_AND_ACTION_SEND_OVERRIDE_CLOSING_MESSAGE_TEXTBOX}    Override Closing Message \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${SCREENING_AND_ACTION_SEND_OVERRIDE_CLOSING_MESSAGE_TEXTBOX}    city    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Closing section when multiple locations are assigned to Even registration conversation (OL-T13488)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Event Registration (Multiple Path)_${random}
    when Add new conversation with name and type    ${conversation_name}    Event Registration (Multiple Path)
    when Select multiple locations at Available locations    ${LOCATION_STREET_TRUNG_NU_VUONG}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CLOSING_INPUT}    country    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Thank you section when multiple locations are assigned to candidate Event Registration conversation (OL-T13489)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Event Registration (Multiple Path)_${random}
    when Add new conversation with name and type    ${conversation_name}    Event Registration (Multiple Path)
    when Select multiple locations at Available locations    ${LOCATION_STREET_TRUNG_NU_VUONG}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Input into    ${CONVERSATION_THANKYOU_INPUT}    Thank you \#la-
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_THANKYOU_INPUT}    state    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Global screening section for follow up conversation (OL-T13491)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Follow Up_${random}
    when Add new conversation with name and type    ${conversation_name}    Follow Up
    Click by JS    ${ADD_SCREENING_QUESTION_BUTTON}
    Input into    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    How old are you ? \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${GLOBAL_SCREENING_QUESTION_CONTENT_1}    phone    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at Closing section for follow up conversation (OL-T13492)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Follow Up_${random}
    when Add new conversation with name and type    ${conversation_name}    Follow Up
    Input into    ${CONVERSATION_CLOSING_INPUT}    Closing \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${CONVERSATION_CLOSING_INPUT}    id    false
    Capture page screenshot
    Delete conversation in builder
    Capture page screenshot


Check conversation when not select location at Available locations in Conversation builder (OL-T13499)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-location_name
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Run the landing site/widget site    Landing Site    ${conversation_name}
    Check element not display on screen    ${la_location_name_single}
    Capture page screenshot


Check conversation when don't input values of location at Location Management tab (OL-T13500)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Single Path_${random}
    when Add new conversation with name and type    ${conversation_name}    Single Path
    Input into    ${CONVERSATION_INTRODUCTION_INPUT}    Introduction \#la-address_2
    Capture page screenshot
    Public the conversation
    Capture page screenshot
    Run the landing site/widget site    Landing Site    ${conversation_name}
    Check element not display on screen    ${la_address_2_single}
    Capture page screenshot


Check Location Attribute list shows correctly at EEO question at custom conversation (OL-T13495)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Custom_${random}
    when Add new custom conversation with name and welcome question    ${conversation_name}
    Add next question    Welcome
    Input question name    EEO
    ${question_description} =    format string    ${QUESTION_DESCRIPTION_TEXTBOX}    EEO
    Input into    ${question_description}    EEO \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${question_description}    name    false
    Capture page screenshot
    #Click to save
    ${three_dot_icon} =    format string    ${THREE_DOT_ICON_BY_QUESTION_NAME}    EEO
    Click at    ${three_dot_icon}
    wait for page load successfully v1
    Select question type    EEO    Equal Employment Opportunity
    Capture page screenshot
    Delete custom conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at End Conversation question at custom conversation (OL-T13497)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Custom_${random}
    when Add new custom conversation with name and welcome question    ${conversation_name}
    Add question by type    Welcome    Full Name
    Add next question    Full Name
    Input question name    End Conversation
    ${question_description} =    format string    ${QUESTION_DESCRIPTION_TEXTBOX}    End Conversation
    Input into    ${question_description}    End Conversation \#la-location_
    Capture page screenshot
    Wait with short time
    Location attribute list is displayed
    Input text    ${question_description}    name    false
    #Click to save
    ${three_dot_icon} =    format string    ${THREE_DOT_ICON_BY_QUESTION_NAME}    End Conversation
    Click at    ${three_dot_icon}
    wait for page load successfully v1
    Select question type    End Conversation    End Conversation
    Capture page screenshot
    Delete custom conversation in builder
    Capture page screenshot


Check Location Attribute list shows correctly at any question after location question at Custom conversation (OL-T13496)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
    ${conversation_name} =    Set variable    auto_Custom_${random}
    when Add new custom conversation with name and welcome question    ${conversation_name}
    Add question by type    Welcome    Phone Number
    Add question by type    Phone Number    Full Name
    Add location question    Full Name    Location_LA_single
    Add next question    Location
    Input question name    EEO
    Input question content    EEO    EEO \#la-location_phone
    Select question type    EEO    Equal Employment Opportunity
    Add next question    EEO
    Input question name    End Conversation
    Select question type    End Conversation    End Conversation
    Input question content    End Conversation    End conversation \#la-location_name
    Capture page screenshot
    Public custom conversation
    Capture page screenshot
    Run the landing site/widget site    Landing Site    ${conversation_name}
    Input text and send message    An Nguyen
    Click at    ${CONVERSATION_SKIP_EEO_BUTTON}
    Wait for Olivia reply
    Check common text last display    ${la_location_phone_single}
    Check common text last display    ${la_location_name_single}
    Capture page screenshot
