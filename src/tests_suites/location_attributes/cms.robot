*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/cms_page.robot
Resource            ../../data_tests/location_attributes/cms_data_tests.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/knowledge_base_page.robot
Resource            ../../pages/users_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/sales_demo_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${audience_sample_name}                     auto_audience
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${candidate_kb_spreadsheet_url}             https://docs.google.com/spreadsheets/d/1MUIsOyI-R3vijnKLbAzUN8fshGAtjrZq7zHmysU0WtQ/edit#gid=918060123
${employee_kb_spreadsheet_url}              https://docs.google.com/spreadsheets/d/1Q3kBwEtUNbWKSt7qvNHIbeqUPo0kP_8w7Xju8EE6R1k/edit?skip_itp2_check=true#gid=1044337716
${candidate_kb_name}                        United States_Arizona
${employee_kb_name}                         United States
${test_location_name}                       ${CONST_LOCATION}

*** Test Cases ***
Verify if shows the structure of the location attributes in the answer in case Global - Web, SMS section (OL-T12927, OL-T12928)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}


Verify if shows the structure of the location attributes token in the answer in case add Audience Builder - Web, SMS section (OL-T12929, OL-T12930)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Check token list displayed    ${all_location_attributes_key_name}
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}


Verify if Paradox Admin is able to add location attribute tokens in answer in case Global - Web, SMS section (OL-T12931, OL-T12932)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot


Verify if Paradox Admin is able to add location attribute tokens in answer in case add Audience Builder - Web, SMS section (OL-T12933, OL-T12934)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Delete added Audience


Verify if Paradox Admin is able to add location attribute tokens in answer in case add Audience Builder - SMS section (OL-T12934)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Delete added Audience


Verify UI of location attribute tokens in answer when click on 'Preview' tab - Web, SMS section (OL-T12935, OL-T12936)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_PREVIEW_TAB}
    Check element display on screen    \#event-name
    Capture page screenshot
    Click at    ${OLIVIA_PREVIEW_TOP_TAB}    SMS
    Check element display on screen    \#event-name
    Capture page screenshot


Verify if Paradox Admin is able to add custom location attribute - Web, SMS section (OL-T12937, OL-T12938)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    auto_custom_location_attr_with_value
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#la-auto_custom_location_attr_with_value
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    auto_custom_location_attr_with_value
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#la-auto_custom_location_attr_with_value
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Delete added Audience


Verify if shows the structure of the location attributes token in the answer in case Global - Web, SMS section (OL-T12939, OL-T12940)
    ${all_location_attributes_key_name}=    Login and Go to Candidate Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}


Verify if Paradox Admin is able to add location attribute tokens in answer in case Global - Web, SMS section (OL-T12943, OL-T12944)
    ${all_location_attributes_key_name}=    Login and Go to Employee Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot


Verify UI of location attribute tokens in answer when click on 'Preview' tab - Web section (OL-T12947, OL-T12948)
    ${all_location_attributes_key_name}=    Login and Go to Employee Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_PREVIEW_TAB}
    Check element display on screen    \#event-name
    Click at    ${OLIVIA_PREVIEW_TOP_TAB}    SMS
    Check element display on screen    \#event-name
    Capture page screenshot


Verify if Paradox Admin is able to add custom location attribute - Web, SMS section (OL-T12949, OL-T12950)
    ${all_location_attributes_key_name}=    Login and Go to Employee Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    auto_custom_location_attr_with_value
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#la-auto_custom_location_attr_with_value
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Select a token    auto_custom_location_attr_with_value
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#la-auto_custom_location_attr_with_value
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot


Verify if shows the structure of the location attributes token in the answer in case has an audience from KB sheet - Country tab - Web, SMS section (OL-T12941, OL-T12942)
    ${all_location_attributes_key_name}=    Login and Go to Employee Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Check element display on screen    ${ADDED_AUDIENCE_NAME}    ${employee_kb_name}
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Check element display on screen    ${ADDED_AUDIENCE_NAME}    ${employee_kb_name}
    Capture page screenshot


Verify if Paradox Admin is able to add location attribute tokens in answer in case has an audience from KB sheet - Country tab - Web section (OL-T12945, OL-T12946)
    ${all_location_attributes_key_name}=    Login and Go to Employee Assistant Responses then click on question
    Check token list displayed    ${all_location_attributes_key_name}
    Check element display on screen    ${ADDED_AUDIENCE_NAME}    ${employee_kb_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot
    Click at    ${OLIVIA_ANSWER_TOP_TAB}    SMS
    Check token list displayed    ${all_location_attributes_key_name}
    Check element display on screen    ${ADDED_AUDIENCE_NAME}    ${employee_kb_name}
    Select a token    event-name
    Verify display text    ${OLIVIA_RESPONSE_HIGHLIGHT_TEXT}    \#event-name
    Capture page screenshot
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Capture page screenshot

*** Keywords ***
Login and Go to Candidate Assistant Responses then click on question
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    @{all_location_attributes_key_name} =    Get All Location Attributes Key Name
    Go to CMS page
    Go to Candidate Assistant Responses
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Benefits
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    What benefits do you offer?     1s
    [Return]    @{all_location_attributes_key_name}

Login and Go to Employee Assistant Responses then click on question
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    @{all_location_attributes_key_name} =    Get All Location Attributes Key Name
    Go to CMS page
    Go to Employee Assistant Responses
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Administration
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    How can I make administrative changes?  1s
    [Return]    @{all_location_attributes_key_name}
