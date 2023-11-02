*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/jobs_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${test_input_token}                         olivia #
${test_input_token_la}                      olivia #la
${custom_attribute}                         custom_location_attribute
${test_location_name}                       Location_job_search_cus_attribute
${job_family_name}                          Tester_Hunter
${job_template}                             Job_Pharmacist_template
${job_name}                                 Pharmacist
${user_name}                                Auto CP
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value

*** Test Cases ***
Check Location Attribute list shows correctly with Conversational Job Search in Message Customize (OL-T13713,OL-T13714)
    Check input token for job search conversation    Searching


Check Standard Location attribute tokens at Job search message customize work fine with Client Job (OL-T13715,OL-T13716)
    #TODO https://paradoxai.atlassian.net/browse/OL-48448
    [Tags]  skip
    Verify attribute message customize job search    ${custom_location_attr_with_value}
    ...    ${custom_location_attr_with_value}


Check Standard Location attribute tokens at Job search message customize work fine with Client Job (OL-T13717,OL-T13719)
    #TODO https://paradoxai.atlassian.net/browse/OL-48448
    [Tags]  skip
    Verify attribute message customize job search    ${custom_location_attr_without_value}    ${custom_location_attr_without_value}

*** Keywords ***
Check input token for job search conversation
    [Arguments]    ${tab_name}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    And Go to Message Customization page
    wait for page load successfully
    When Click at    ${HEADER_JOB_SEARCH}
    Then Check element display on screen    ${tab_name}
    Click at    ${tab_name}
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
    And Check attribute list is display    ${custom_location_attr_with_value}

Save token message
    when Click at    ${SAVE_BUTTON_MESSAGE}
    Then Check element display on screen    Your changes were saved
    when Click at    ${MESSAGE_BOX}
    And Clear element text with keys    ${MESSAGE_BOX}
    And Click at    ${SAVE_BUTTON_MESSAGE}

Verify attribute message customize job search
    [Arguments]    ${attribute_text}    ${message_value}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    And Go to Message Customization page
    when Click at    Conversational Job Search
    Click at    Chat-to-apply
    Click at    ${WEB_TAB}
    ${value_attribute} =    set variable    \#la-${attribute_text}
    press text for input    ${MESSAGE_BOX}    ${value_attribute}
    ${url_site} =    get landing site url by string concatenation    COMPANY_HIRE_ON     ${EMPTY}
    go to    ${url_site}
    wait for page load successfully
    click accept button on gdpr dialog
    check message and send next message
    ...    Thanks for accepting our Terms of Use. What opportunity are you most interested in?    any job in The United States
    Click on common text last    See All
    Click on common text last    Pharmacist
    Click on common text last    Apply Now
    wait for page load successfully
    Verify Olivia conversation message display    Thank you for your interest! I can help you apply to
    Verify Olivia conversation message display    ${message_value}
