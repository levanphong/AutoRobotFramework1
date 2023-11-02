*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/system_attributes_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${test_input_token}             olivia #
${test_input_token_la}          olivia #la
${custom_attribute}             custom_location_attribute
${custom_attribute_sen_key}     c+u+t+o+m+_+m+e+s+s
${fire_fighter}                 Firefighter
${journalist}                   Journalist

*** Test Cases ***
Check Location Attribute list shows correctly in Multi-Application Messaging tab (OL-T13392)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    And Go to Message Customization page
    when Click at    Multi-Application
    Then Check element display on screen    Multi-Application Messaging
    Then Check element display on screen    Already applied
    And Check span display    SMS
    And Check span display    Web
    when Click at    Already applied
    And Click at    ${ADD_MORE_MESSAGE}
    when input into    ${MESSAGE_BOX}    ${test_input_token}
    Then Check attribute list is display    ca-city
    And Check attribute list is display    job
    And Check attribute list is display    location
    Click at link    job-location
    And Click at    ${ADD_MORE_MESSAGE}
    when input into    ${MESSAGE_BOX}    ${test_input_token_la}
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
    Capture page screenshot
    Click at    ${custom_attribute}
    when Click at    ${SAVE_BUTTON_MESSAGE}
    Then Check element display on screen    Your changes were saved
    Capture page screenshot
    when Click at    ${MESSAGE_BOX}
    And Clear element text with keys    ${MESSAGE_BOX}
    And Click at    ${SAVE_BUTTON_MESSAGE}
    Capture page screenshot


Check message with location attribute list shows correctly in Multi-Application web tab when click Closing icon (OL-T13393)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    And Go to Message Customization page
    when Click at    Multi-Application
    Then Check element display on screen    Multi-Application Messaging
    Then Check element display on screen    Already applied
    when Click at    Already applied
    And Click at    ${ADD_MORE_MESSAGE}
    when input into    ${MESSAGE_BOX}    test_auto_update_message_cus
    ${message_box} =    get text    ${MESSAGE_BOX}
    And Click at    ${CANCEL_BTN_MESS_CUSTOM}
    Then Check Close Confirm modal and update message not saved    ${message_box}
    Capture page screenshot


Check message with location attribute list shows correctly when add a new messge in Multi-Application web tab (OL-T13394)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    And Go to Message Customization page
    when Click at    Multi-Application
    Then Check element display on screen    Multi-Application Messaging
    when Click at    Already applied
    And Click at    ${ADD_MORE_MESSAGE}
    press Keys    ${MESSAGE_BOX}    ${custom_attribute_sen_key}
    press Keys    ${MESSAGE_BOX}    RETURN
    And Click at    ${SAVE_BUTTON_MESSAGE}
    when hover at    ${MESS_ACTIVE_MESSAGE_CUS}
    ${order_text} =    get text    ${MESS_ACTIVE_MESSAGE_CUS}
    when Click at    ${REMOVE_BUTTON_MESSAGE_CUS}
    And Click at    ${CANCEL_BTN_MESS_CUSTOM}
    Check message is still remain on screen    ${order_text}
    when hover at    ${MESS_ACTIVE_MESSAGE_CUS}
    when Click at    ${REMOVE_BUTTON_MESSAGE_CUS}
    then check message is remove    ${order_text}
    And Click at    ${SAVE_BUTTON_MESSAGE}
    Then Check element display on screen    Your changes were saved
    Capture page screenshot


Check behavior conversation when candidate start job search and set on Multi Application at capture on Client setup (OL-T13395)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    And Go to Message Customization page
    when Click at    Multi-Application
    Then Check element display on screen    Multi-Application Messaging
    Then Check element display on screen    Already applied
    when Click at    Already applied
    When Click on span text    Web
    And Click at    ${ADD_MORE_MESSAGE}
    when input into    ${MESSAGE_BOX}    ${custom_attribute}
    ${is_displayed} =   Run keyword and return status   Check element display on screen  ${SAVE_BUTTON_MESSAGE}   wait_time=5s
    Run Keyword If    ${is_displayed}    Click at  ${SAVE_BUTTON_MESSAGE}
    conversation apply job search by landing site    ${journalist}


Check behavior conversation when candidate start applying via the (Internal job) at My job page (OL-T13396, OL-T13398)
    Given Setup test
    conversation apply job search by landing site    ${fire_fighter}

*** Keywords ***
conversation apply job search by landing site
    [Arguments]    ${job_name}
    ${url_site} =   get landing site url by string concatenation    COMPANY_FRANCHISE_ON    JobsearchOnlyEmail
    ${email} =    Generate random name    ${CONFIG.gmail}
    ${first_name} =  Generate random text only
    ${candidate_name} =    set variable    ${first_name} John
    Candidate starts job search conversation via Landing site    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    Start conversation again with input " New" in chatbox
    Provide name,email same as one in our database    ${url_site}    ${candidate_name}    ${email}    ${job_name}
    check get code and send to ai    ${first_name}
    Capture page screenshot
