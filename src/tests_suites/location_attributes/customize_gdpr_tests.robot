*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../data_tests/location_attributes/location_attributes.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${hire_on_landing_com_name}     TestAutomationHireOnCompany
${test_input_token}             olivia #
${test_input_token_la}          olivia #la
${custom_attribute}             custom_location_attribute
${custom_attribute_country}     country:#la-country

*** Test Cases ***
Check Location Attribute list shows correctly in GDPR at Care & Job Search tab (OL-T13508)
    verify location attribute show correct in GDPR by tab    Care & Job Search
    Capture page screenshot


Check Location Attribute list shows correctly in GDPR at Capture tab (OL-T13504)
    verify location attribute show correct in GDPR by tab    Capture
    Capture page screenshot


Check Location Attribute list shows correctly in GDPR at Removal Requests Alert tab (OL-T13394)
    verify location attribute show correct in GDPR by tab    Removal Requests Alert
    Capture page screenshot


Check conversation flow with message including location attributes that have been added in GDPR when the candidate accepts terms and starts capture conversation (OL-T13505)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    And Go to Message Customization page
    when Click at    GDPR (Terms & Conditions)
    verify and click on tab    Capture
    ${capture_locator} =    format string    ${CAPTURE_AFTER_START_CAPTURE_CON}    3
    when press text for input    ${capture_locator}    country:#la-country
    ${url_site}=    get landing site url by string concatenation    COMPANY_FRANCHISE_OFF   CompanySiteAutoSinglePathScheduleSettings
    go to    ${url_site}
    open and check custom location attribute message
    Capture page screenshot


Check conversation flow with message including location attributes that have been added in GDPR when the candidate accepts terms and starts Job search conversation (OL-T13509)
    #TODO https://paradoxai.atlassian.net/browse/OL-48448
    [Tags]    skip
    Make conversation job search    3
    Click on common text last    See All
    Click on common text last    Pharmacist
    Click on common text last    Apply Now
    wait for page load successfully
    Check element display on screen    country:
    Capture page screenshot


Check conversation flow with message including location attributes that have been added in GDPR after when TURN ON Display terms in Job search (OL-T13511)
    Make conversation job search    2
    Capture page screenshot


Check conversation flow with message including location attributes that have been added in GDPR after when the candidate accepts terms and before starting Care only (OL-T13510)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    And Go to Message Customization page
    when Click at    GDPR (Terms & Conditions)
    verify and click on tab    Care & Job Search
    ${capture_locator} =    format string    ${CAPTURE_AFTER_START_CAPTURE_CON}    1
    when press text for input    ${capture_locator}    ${custom_attribute_country}
    ${url_site} =    get landing site url by string concatenation    COMPANY_HIRE_ON     CareGDPR
    go to    ${url_site}
    open and check custom location attribute message
    Verify Olivia conversation message display    Thanks for accepting our Terms of Use. How can I help you?
    Capture page screenshot

*** Keywords ***
verify and click on tab
    [Arguments]    ${tab_name}
    IF    '${tab_name}' == 'Capture'
        check element display on screen    ${CAPTURE_TITLE}
        Click at    ${CAPTURE_TITLE}
    ELSE
        Then Check element display on screen    ${tab_name}
        Click at    ${tab_name}
    END

verify content of tab in gdpr
    [Arguments]    ${tab_name}
    IF    '${tab_name}' == 'Care & Job Search'
        check element display on screen    ${MESSAGE_SUB_TITLE}
    ELSE IF    '${tab_name}' == 'Capture'
        Then Check element display on screen    Terms Message when a candidate texts into a standard phone number or shortcode
        Then Check element display on screen    Terms Message when the candidate texts into an event phone number or shortcode
    ELSE IF    '${tab_name}' == 'Removal Requests Alert'
        Then Check element display on screen    Email subject sent to ATS/CRM when a candidate requests to delete their data
    END

verify location attribute show correct in GDPR by tab
    [Arguments]    ${tab_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    And Go to Message Customization page
    when Click at    GDPR (Terms & Conditions)
    verify and click on tab    ${tab_name}
    verify content of tab in gdpr    ${tab_name}
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
    when Click at    ${SAVE_BUTTON_MESSAGE}
    Then Check element display on screen    Your changes were saved
    when Click at    ${MESSAGE_BOX}
    And Clear element text with keys    ${MESSAGE_BOX}
    And Click at    ${SAVE_BUTTON_MESSAGE}

Get company name by env
    [Arguments]    ${company_name}
    IF    '${env}' == 'OLIVIA'
        ${company_name} =    set variable    ${company_name}1
    END
    [Return]    ${company_name}

Make conversation job search
    [Arguments]    ${type}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    And Go to Message Customization page
    when Click at    GDPR (Terms & Conditions)
    verify and click on tab    Care & Job Search
    ${capture_locator} =    format string    ${CAPTURE_AFTER_START_CAPTURE_CON}    ${type}
    when press text for input    ${capture_locator}    ${custom_attribute_country}
    ${url_site}=    get landing site url by string concatenation    COMPANY_HIRE_ON     ${EMPTY}
    go to    ${url_site}
    wait for page load successfully
    then The model confirm " the terms" is opened
    click accept button on gdpr dialog
    check message and send next message
    ...    Thanks for accepting our Terms of Use. What opportunity are you most interested in?    any job in The United States

open and check custom location attribute message
    click accept button on gdpr dialog
    wait with medium time
    Check element display on screen    country:
