*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/suggestions_page.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/all_candidates_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever


*** Variables ***
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${test_suggestion_name}                     auto_suggestion
${test_suggestion_message_with_value}       Thanks for applying this position. Your manager #la-${custom_location_attr_with_value} will contact you in 3 business days
${test_suggestion_message_without_value}    Thanks for applying this position. Your manager #la-${custom_location_attr_without_value} will contact you in 3 business days

*** Test Cases ***
Verify if location attributes token in a default suggestion message (OL-T13039)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${all_location_attr_keys} =    Get All Location Attributes Key Name
    Go to Suggestions page
    Click Suggestion Name    apply
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    \#
    Display the token list that include All Location Attributes that created on System Attributes page
    ...    ${all_location_attr_keys}
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    \#la
    Only display location attributes with prefix is "#la-"
    Capture page screenshot


Verify if location attributes token in a new suggestion message (OL-T13040)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${all_location_attr_keys} =    Get All Location Attributes Key Name
    Go to Suggestions page
    Input into    ${NEW_SUGGESTION_NAME_TEXT_BOX}    ${test_suggestion_name}
    Click at    ${NEW_SUGGESTION_ADD_BUTTON}
    Click Suggestion Name    ${test_suggestion_name}
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    \#
    Display the token list that include All Location Attributes that created on System Attributes page
    ...    ${all_location_attr_keys}
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    \#la
    Only display location attributes with prefix is "#la-"
    Capture page screenshot


Verify if location attribute gets correct value in case location is assigned & value is available (OL-T13041)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Suggestions page
    ${suggestion_random_name} =    Generate random name    ${test_suggestion_name}
    Input into    ${NEW_SUGGESTION_NAME_TEXT_BOX}    ${suggestion_random_name}
    Click at    ${NEW_SUGGESTION_ADD_BUTTON}
    Click Suggestion Name    ${suggestion_random_name}
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    ${test_suggestion_message_with_value}
    Click at    ${SUGGESTION_SAVE_BUTTON}
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${CONST_LOCATION}
    Click at    ${candidate_name}
    Click at    ${CEM_HASHTAG_CHAT_ICON}
    Click by JS    ${suggestion_random_name}
    Verify display text    ${CEM_RECRUITER_INPUT_TEXT_BOX}
    ...    Thanks for applying this position. Your manager auto_attribute_value will contact you in 3 business days
    Capture page screenshot
    Delete suggestion after run Test case    ${suggestion_random_name}
    Capture page screenshot


Verify if location attribute is empty in case location is assigned & value is not available (OL-T13042)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Suggestions page
    ${suggestion_random_name} =    Generate random name    ${test_suggestion_name}
    Input into    ${NEW_SUGGESTION_NAME_TEXT_BOX}    ${suggestion_random_name}
    Click at    ${NEW_SUGGESTION_ADD_BUTTON}
    Click Suggestion Name    ${suggestion_random_name}
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    ${test_suggestion_message_without_value}
    Click at    ${SUGGESTION_SAVE_BUTTON}
    Go to CEM page
    ${candidate_name} =    Add a Candidate    None    ${CONST_LOCATION}
    Click at    ${candidate_name}
    Click at    ${CEM_HASHTAG_CHAT_ICON}
    Click by JS    ${suggestion_random_name}
    Verify display text    ${CEM_RECRUITER_INPUT_TEXT_BOX}
    ...    Thanks for applying this position. Your manager ${SPACE}will contact you in 3 business days
    Capture page screenshot
    Delete suggestion after run Test case    ${suggestion_random_name}
    Capture page screenshot


Verify if location attribute is empty in case location is not assigned (OL-T13043)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Suggestions page
    ${suggestion_random_name} =    Generate random name    ${test_suggestion_name}
    Input into    ${NEW_SUGGESTION_NAME_TEXT_BOX}    ${suggestion_random_name}
    Click at    ${NEW_SUGGESTION_ADD_BUTTON}
    Click Suggestion Name    ${suggestion_random_name}
    Input into    ${SUGGESTION_MESSAGE_TEXT_BOX}    ${test_suggestion_message_with_value}
    Click at    ${SUGGESTION_SAVE_BUTTON}
    Go to CEM page
    ${candidate_name} =    Add a Candidate
    Click at    ${candidate_name}
    Click at    ${CEM_HASHTAG_CHAT_ICON}
    Click by JS    ${suggestion_random_name}
    Verify display text    ${CEM_RECRUITER_INPUT_TEXT_BOX}
    ...    Thanks for applying this position. Your manager ${SPACE}will contact you in 3 business days
    Capture page screenshot
    Delete suggestion after run Test case    ${suggestion_random_name}
    Capture page screenshot
