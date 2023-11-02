*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../data_tests/location_attributes/location_attributes.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/conversation_builder_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${job_family_name}      Coffee family job
${job_template}         auto_job_template
${job_type}             Basic Multi-Location

*** Test Cases ***
Check Location Attributes show correctly when creating new job using a template (OL-T13167, OL-T13168, OL-T13169, OL-T13170, OL-T13171)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_name    ${random_name}   ${job_type}
    Go to Jobs page
    ${job_name} =    Generate random name    auto_job
    Create new job    ${job_name}    ${JF_COFFEE_FAMILY_JOB}    ${job_template_name}        is_as_template=True
    Check element display on screen    \#la-location_name
    Add location for job    ${LOCATION_STREET_NGUYEN_HUU_THO}
    #   Check Location Attribute list shows correctly with Job question field in Job builder (OL-T13168)
    Click at    ${SCREENING_TAB}
    Click at    Add Question
    input into    ${INPUT_QUESTION_CONTENT}    \#la-add
    Then suggest Location Attributes list match the key keyword is displayed
    #   Check all Attribute list shows correctly with Job question field in Job builder (OL-T13169)
    Input into    ${INPUT_QUESTION_CONTENT}    \#
    Then All suggest Location Attributes list is displayed
    Click at    ${JOB_CANCEL_SAVE_OUTCOME_BUTTON}
    #   Check Location Attribute list shows correctly with Outcomes field in Job builder (OL-T13170)
    Click at    Default Outcome
    Click at    Add Outcome
    input into    ${INPUT_QUESTION_CONTENT_1}    \#la-add
    Then suggest Location Attributes list match the key keyword is displayed
    #   Check all Attribute list shows correctly with Outcomes field in Job builder (OL-T13171)
    Input into    ${INPUT_QUESTION_CONTENT_1}    \#
    Then All suggest Location Attributes list is displayed
    Capture page screenshot
    Delete job data after run test case    ${job_name}    ${job_template_name}    ${job_family_name}
    Capture page screenshot


Check Location Attribute list shows correctly with Job description field in Job builder (OL-T13172, OL-T13173)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_name    ${random_name}   ${job_type}
    Go to Jobs page
    ${job_name} =    Generate random name    auto_job
    Create new job    ${job_name}    ${JF_COFFEE_FAMILY_JOB}    ${job_template_name}        is_as_template=True
    Add location for job    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Go to Jobs page
    Click at    ${job_family_name}
    Click on job name    ${job_name}
    Clear element text with keys    ${ENTER_DESCRIPTION_QUESTION}
    Input into    ${ENTER_DESCRIPTION_QUESTION}    \#la-add
    Then suggest Location Attributes list match the key keyword is displayed on Decscription Job
    Capture page screenshot
    #   Check all Attribute list shows correctly with Job description field in Job builder (OL-T13173)
    Input into    ${ENTER_DESCRIPTION_QUESTION}    \#
    Then All suggest Location Attributes list is displayed on Decscription Job
    Capture page screenshot
    Delete job data after run test case    ${job_name}    ${job_template_name}    ${job_family_name}
    Capture page screenshot


Check Location Attribute list shows correctly with Job question field in Job Template builder (OL-T13094, OL-T13095)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_name    ${random_name}   ${job_type}
    Go to Jobs page
    Click at    ${JOB_TEMPLATES_TAB}
    Click on job template name    ${job_template_name}
    Click at    ${SCREENING_TAB}
    Click at    Add Question
    input into    ${INPUT_QUESTION_CONTENT}    \#la-add
    Then suggest Location Attributes list match the key keyword is displayed
    Capture page screenshot
    #   Check all Attribute list shows correctly with Job question field in Job Template builder (OL-T13095)
    Input into    ${INPUT_QUESTION_CONTENT}    \#
    Then All suggest Location Attributes list is displayed
    Capture page screenshot
    Delete a Job template    ${job_template_name}
    Capture page screenshot


Check Location Attribute list shows correctly with Outcomes field in Job Template builder (OL-T13096, OL-T13097)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_name    ${random_name}   ${job_type}
    Go to Jobs page
    Click at    ${JOB_TEMPLATES_TAB}
    sleep    10s
    Click on job template name    ${job_template_name}
    Click at    ${SCREENING_TAB}
    Click at    Default Outcome
    Click at    Add Outcome
    Input into    ${INPUT_QUESTION_CONTENT_1}    \#la-add
    Then suggest Location Attributes list match the key keyword is displayed
    #   Check all Attribute list shows correctly with Outcomes field in Job Template builder (OL-T13097)
    Input into    ${INPUT_QUESTION_CONTENT_1}    \#
    Then All suggest Location Attributes list is displayed
    Capture page screenshot
    Capture page screenshot
    Delete a Job template    ${job_template_name}
    Capture page screenshot


Check Location Attribute list shows correctly with Job description field in Job Template builder (OL-T13098, OL-T13099)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_name    ${random_name}       ${job_type}
    Go to Jobs page
    Click at    ${JOB_TEMPLATES_TAB}
    Click on job template name    ${job_template_name}
    Clear element text with keys    ${ENTER_DESCRIPTION_QUESTION}
    input into    ${ENTER_DESCRIPTION_QUESTION}    \#la-add
    Then suggest Location Attributes list match the key keyword is displayed on Decscription Job
    #   Check all Attribute list shows correctly with Job description field in Job Template builder (OL-T13099)
    Input into    ${ENTER_DESCRIPTION_QUESTION}    \#
    Then All suggest Location Attributes list is displayed on Decscription Job
    Capture page screenshot
    Capture page screenshot
    Delete a Job template    ${job_template_name}
    Capture page screenshot


Check when candidate apply to the job that uses the location attribute token but doesn't have a mapping value with that location attribute (OL-T13174)
    # TODO Maintain fix Run the landing site/widget site for Job Search keyword
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_manager    ${random_name}    ${job_type}
    Go to Jobs page
    ${job_name} =    Generate random name    auto_job
    Create new job    ${job_name}    ${JF_COFFEE_FAMILY_JOB}    ${job_template_name}        is_as_template=True
    Input content to publish job    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Publish job
    Go to My Jobs page
    Active a job    ${job_name}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Capture page screenshot
    ${job_search_conversation} =    Add Job Search Conversation    Hire
    Run the landing site/widget site for Job Search    ${job_search_conversation}    ${job_name}    ${job_template}
    Check element not display on screen    \#la-location_manager
    Capture page screenshot
    Delete job data after run test case    ${job_name}    ${job_template_name}    ${job_family_name}
    Capture page screenshot


Check when candidate apply to the job that uses the location attribute token but doesn't have a mapping value with that location attribute (OL-T13175)
    # TODO Maintain fix Run the landing site/widget site for Job Search keyword
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-location_manager    ${random_name}    ${job_type}
    Go to Jobs page
    ${job_name} =    Generate random name    auto_job
    Create new job    ${job_name}    ${JF_COFFEE_FAMILY_JOB}    ${job_template_name}        is_as_template=True
    Input content to publish job    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Publish job
    Go to My Jobs page
    Active a job    ${job_name}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Capture page screenshot
    ${job_search_conversation} =    Add Job Search Conversation    Hire
    Run the landing site/widget site for Job Search    ${job_search_conversation}    ${job_name}
    ...    ${job_template_name}
    Check element display on screen    Ana Tran
    Capture page screenshot
    Delete job data after run test case    ${job_name}    ${job_template_name}    ${job_family_name}
    Capture page screenshot


Check when candidate apply to the job that uses the standard location attribute token and have a mapping value with that location attribute (OL-T13176)
    # TODO Maintain fix Run the landing site/widget site for Job Search keyword
    [Tags]    skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    ${random_name} =    Generate random name    ${job_template}
    ${job_template_name} =    Create new job template    \#la-add_custom    ${random_name}  ${job_type}
    Go to Jobs page
    ${job_name} =    Generate random name    auto_job
    Create new job    ${job_name}    ${JF_COFFEE_FAMILY_JOB}    ${job_template_name}        is_as_template=True
    Input content to publish job    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Publish job
    Go to My Jobs page
    Active a job    ${job_name}    ${LOCATION_STREET_NGUYEN_HUU_THO}
    Capture page screenshot
    ${job_search_conversation} =    Add Job Search Conversation    Hire
    Run the landing site/widget site for Job Search    ${job_search_conversation}    ${job_name}
    ...    ${job_template_name}
    Check element display on screen    460 Nguyen Huu Tho
    Capture page screenshot
    Delete job data after run test case    ${job_name}    ${job_template_name}    ${job_family_name}
    Capture page screenshot
