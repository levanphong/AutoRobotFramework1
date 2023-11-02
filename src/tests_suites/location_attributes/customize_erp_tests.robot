*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/system_attributes_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${test_input_token}             olivia #
${test_input_token_la}          olivia #la
${custom_attribute}             custom_location_attribute
${intro_referal_employee}       Let's get you signed up for the Employee Referral Program. What's your first and last name?
${intro_referal_candidate}      Thanks {}, I'm excited to help you refer a friend. What's their first and last name?
${need_to_input_name_again}     I'm sorry, I didn't get that. What's their first and last name?
${intro_referal_reason}         would be a good fit for
${capture_type}                 Capture

*** Test Cases ***
Check Location Attribute list shows correctly in ERP at Referral Engagement Opt-in tab (OL-T13512)
    verify location attribute show correct in ERP by tab    Referral Engagement Opt-in
    Capture page screenshot


Check Location Attribute list shows correctly in ERP at Referral Type tab (OL-T13393)
    verify location attribute show correct in ERP by tab    Referral Type
    Capture page screenshot


Check Location Attribute list shows correctly in ERP at Talent Community Prompt tab (OL-T13394)
    verify location attribute show correct in ERP by tab    Talent Community Prompt
    Capture page screenshot


Employee refers capture to candidate (OL-T13516)
    Given Setup test
    ${url_site} =  Get landing site url by string concatenation  COMPANY_FRANCHISE_ON   ERP
    employee refer candidate by capture    ${capture_type}    ${url_site}    ${COMPANY_FRANCHISE_ON}
    Capture page screenshot


Employee refers job search to candidate (OL-T13515)
    Given Setup test
    ${url_site} =  Get landing site url by string concatenation  COMPANY_HIRE_ON   ERP
    employee refer candidate by capture    Job search    ${url_site}    ${COMPANY_HIRE_ON}
    Capture page screenshot

*** Keywords ***
Setup hire on has config custom attribute
    Run Setup Only Once    Prepare Location Attributes Data Test with company    ${COMPANY_HIRE_ON}

employee refer candidate by capture
    [Arguments]    ${type}    ${url}    ${company}
    ${email} =    Generate random name    ${CONFIG.gmail}
    ${employee_name} =    generate candidate name
    ${candidate_name} =    generate candidate name
    go to    ${url}
    check message and send next message    ${intro_referal_employee}    ${employee_name.full_name}
    ${intro_referal_candidate_formatted} =      format string      ${intro_referal_candidate}     ${employee_name.first_name}
    check message and send next message    ${intro_referal_candidate_formatted}    ${candidate_name.full_name}
    ${is_input_again}=  Run keyword and return status   Check element display on screen     ${need_to_input_name_again}
    IF  '${is_input_again}' == 'True'
        Candidate input to landing site     ${candidate_name.full_name}
    END
    check message and send next message    email address?    ${email}
    IF    '${type}' == '${capture_type}'
        check message and send next message    ${intro_referal_reason}    good candidate
    END
    Verify Olivia conversation message display      Thank you! Please let
    Verify Olivia conversation message display      know I will be reaching out within one minute
    ${subject_referal} =    set variable    Referral from ${company}
    # Need to wait 1m because setting in Client Setup > Employee Referrals > Delay initial candidate text by
    Sleep   1m
    Click button in email    ${subject_referal}     Hi ${candidate_name.first_name}!
    IF    '${type}' == '${capture_type}'
        check message and send next message    How old are you?    25
        Wait with large time
        check message location attribute show    custom_location
        check message location attribute show    address
        check message location attribute show    city
    ELSE
        Verify Olivia conversation message display    thought you would be a strong candidate anywhere in our organization
    END

verify location attribute show correct in ERP by tab
    [Arguments]    ${tab_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    And Go to Message Customization page
    when Click at    Employee Referrals
    Then Check element display on screen    Referral Engagement Opt-in
    Then Check element display on screen    Referral Type
    Then Check element display on screen    Talent Community Prompt
    Click at    ${tab_name}
    IF    '${tab_name}' == 'Referral Engagement Opt-in'
        Then Check element display on screen    Referral Engagement Opt-in
        Then Check element display on screen    Referral Engagement Opt-in Declined
        Then Check element display on screen    Referral Engagement Opt-in Error Message
    ELSE IF    '${tab_name}' == 'Referral Type'
        Then Check element display on screen    General Referral Engagement Message
        Then Check element display on screen    Specific Referral Engagement Message
        Then Check element display on screen    Specific Referral Engagement Chat-to-Apply Message
    ELSE IF    '${tab_name}' == 'Talent Community Prompt'
        Then Check element display on screen    Join Talent Community Prompt
        Then Check element display on screen    Join Talent Community Error Message
    END
    And Check span display    SMS
    And Check span display    Web
    when press text for message box    ${test_input_token}
    Then Check attribute list is display    ca-city
    And Check attribute list is display    job
    And Check attribute list is display    location
    when press text for message box    ${test_input_token_la}
    Then Check attribute list is display    address
    And Check attribute list is display    address_2
    And Check attribute list is display    city
    And Check attribute list is display    state
    And Check attribute list is display    zipcode
    And Check attribute list is display    country
    And Check attribute list is display    province
    And Check attribute list is display    location_id
    And Check attribute list is display    location_email
    And Check attribute list is display    location_phone
    And Check attribute list is display    ${custom_attribute}
    Click at    ${custom_attribute}
    when Click at    ${SAVE_BUTTON_MESSAGE}
    Then Check element display on screen    Your changes were saved
    when Click at    ${MESSAGE_BOX}
    And Clear element text with keys    ${MESSAGE_BOX}
    And Click at    ${SAVE_BUTTON_MESSAGE}
