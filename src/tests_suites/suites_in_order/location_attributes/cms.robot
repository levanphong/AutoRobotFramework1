*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/cms_page.robot
Resource            ../../../data_tests/location_attributes/cms_data_tests.robot
Resource            ../../../pages/system_attributes_page.robot
Resource            ../../../pages/knowledge_base_page.robot
Resource            ../../../pages/users_page.robot
Resource            ../../../pages/location_management_page.robot
Resource            ../../../pages/conversation_builder_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/sales_demo_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

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
Verify if location attribute gets correct value when candidate asks care in case Location is assigned and Attribute value is available - Global answer - Web (OL-T12951)
    ${question} =    Set variable    Who is eligible for benefits?
    Login and Go to Candidate Assistant Responses then click on question    ${question}
    Select a token    auto_custom_location_attr_with_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Candidate
    Public Assistant Responses Question    Candidate
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Candidate Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned but Attribute value is not available - Global answer - Web (OL-T12952)
    ${question} =    Set variable    When can I enroll in benefits?
    Login and Go to Candidate Assistant Responses then click on question    ${question}
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Candidate
    Public Assistant Responses Question    Candidate
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Candidate Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is NOT assigned - Global answer - Web (OL-T12953)
    ${question} =    Set variable    What AD&D coverage is available?
    Login and Go to Candidate Assistant Responses then click on question    ${question}
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Candidate
    Public Assistant Responses Question    Candidate
    ${site_name} =    Run the Widget Conversation with CMS and Conversation without Location    Candidate Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned and Attribute value is available - Audience Builder - Web section (OL-T12954)
    ${question} =    Set variable    What is your dental coverage?
    Login and Go to Candidate Assistant Responses then click on question    ${question}
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Select a token    auto_custom_location_attr_with_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Candidate
    Public Assistant Responses Question    Candidate
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Candidate Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned but Attribute value is not available - Audience Builder - Web (OL-T12955)
    ${question} =    Set variable    What dependent care assistance do you offer?
    Login and Go to Candidate Assistant Responses then click on question    ${question}
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Candidate
    Public Assistant Responses Question    Candidate
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Candidate Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is NOT assigned - Audience Builder - Web (OL-T12956)
    ${question} =    Set variable    What is available through your EAP?
    Login and Go to Candidate Assistant Responses then click on question    ${question}
    Add Audience into Sample Question    ${audience_sample_name}
    Click at    ${audience_sample_name}
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Candidate
    Public Assistant Responses Question    Candidate
    ${site_name} =    Run the Widget Conversation with CMS and Conversation without Location    Candidate Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned and Attribute value is available - Global answer - Web (OL-T12963)
    ${question} =    Set variable    What benefits are available to employees?
    Login and Go to Employee Assistant Responses then click on question     ${question}
    Select a token    auto_custom_location_attr_with_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Employee
    Public Assistant Responses Question    Employee
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Employee Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned but Attribute value is not available - Global answer - Web (OL-T12964)
    ${question} =    Set variable    How can I make changes to my benefits?
    Login and Go to Employee Assistant Responses then click on question     ${question}
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Employee
    Public Assistant Responses Question    Employee
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Employee Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is NOT assigned - Global answer - Web (OL-T12965)
    ${question} =    Set variable    How can I change my accident insurance?
    Login and Go to Employee Assistant Responses then click on question     ${question}
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Employee
    Public Assistant Responses Question    Employee
    ${site_name} =    Run the Widget Conversation with CMS and Conversation without Location    Employee Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned and Attribute value is available - Country tab - Web section (OL-T12966)
    ${question} =    Set variable    How can I change my AD&D insurance coverage?
    Login and Go to Employee Assistant Responses then click on question     ${question}
    Click at    ${ADDED_AUDIENCE_NAME}    Vietnam
    Select a token    auto_custom_location_attr_with_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Employee
    Public Assistant Responses Question    Employee
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Employee Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is assigned but Attribute value is not available - Country tab - Web (OL-T12967)
    ${question} =    Set variable    How can I change my AD&D insurance coverage?
    Login and Go to Employee Assistant Responses then click on question     ${question}
    Click at    ${ADDED_AUDIENCE_NAME}    Vietnam
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Employee
    Public Assistant Responses Question    Employee
    ${site_name} =    Run the Widget Conversation with CMS and Conversation with Location    Employee Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value


Verify if location attribute gets correct value when candidate asks care in case Location is NOT assigned - Country tab - Web (OL-T12968)
    ${question} =    Set variable    How can I change my AD&D insurance coverage?
    Login and Go to Employee Assistant Responses then click on question     ${question}
    Click at    ${ADDED_AUDIENCE_NAME}    Vietnam
    Select a token    auto_custom_location_attr_without_value
    Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
    Check element display on screen    Your changes were saved
    Change Care question to Live    ${question}    Employee
    Public Assistant Responses Question    Employee
    ${site_name} =    Run the Widget Conversation with CMS and Conversation without Location    Employee Care
    ${demo_url} =    Add a Widget to Sales Demo    ${site_name}
    Run Demo site and input common information    ${demo_url}    ${question}
    Check element not display on screen    auto_attribute_value

*** Keywords ***
Login and Go to Candidate Assistant Responses then click on question
    [Arguments]     ${question}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to CMS page
    Go to Candidate Assistant Responses
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Benefits
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    ${question}

Login and Go to Employee Assistant Responses then click on question
    [Arguments]     ${question}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to CMS page
    Go to Employee Assistant Responses
    Click at    ${CANDIDATE_CARE_GROUP_TITLE}    Benefits
    Click at    ${BENEFITS_SAMPLE_QUESTION_TEXT}    ${question}
