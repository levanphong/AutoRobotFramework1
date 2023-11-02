*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../data_tests/location_attributes/workflows_data_tests.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/users_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever

*** Variables ***
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${test_location_name}                       ${CONST_LOCATION}
${job_family_name}                          ${JF_COFFEE_FAMILY_JOB}

*** Test Cases ***
Verify show location Attributes list correctly at workflows (OL-T12989)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${all_location_attribute_keys} =    Get All Location Attributes Key Name
    ${cj_name} =    Create Candidate journey has offer stage
    ${workflow_name} =    Add a Workflow    None    Custom Workflow    ${cj_name}
    Go to Workflows page
    Click at    ${workflow_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    ${task_random_name} =    Generate random name    auto_task
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_random_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${SEND_COMMUNICATION_ACTION}
    # Test for Email Tab
    Input into    ${EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#
    Display the Mention list item that include All Location Attributes that created on System Attributes page
    ...    ${all_location_attribute_keys}
    Click at    ${QL_MENTION_LIST_ITEM_VALUE}    ${custom_location_attr_with_value}
    Check element display on screen    ${QL_MENTION_HIGHLIGHT_ITEM_VALUE}    ${custom_location_attr_with_value}
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#
    Display the Mention list item that include All Location Attributes that created on System Attributes page
    ...    ${all_location_attribute_keys}
    Click at    ${TEXT_COMPLETE_ITEM_VALUE}    ${custom_location_attr_with_value}
    Check element display on screen    ${TEXT_COMPLETE_HIGHLIGHT_ITEM_VALUE}    ${custom_location_attr_with_value}
    Click at    ${CANCEL_TASK_BUTTON}
    Capture page screenshot
    # Delete data test after run test case
    Delete a Journey    ${cj_name}
    Delete a Workflow    ${workflow_name}


Verify location attribute in workflow trigger in case attribute value is available - Candidate audience (OL-T12990)
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer    ${custom_location_attr_with_value}
    ${cj_name} =    Create Candidate journey has Offer stage
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Active a job    ${job_name}
    Wait with short time
    ${workflow_name} =    Add a Workflow    None    Custom Workflow    ${cj_name}
    Go to Workflows page
    Click at    ${workflow_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    ${task_random_name} =    Generate random name    auto_task
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_random_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${SEND_OFFER_ACTION}
    Input into    ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    auto_mail_subject
    # Test for Email Tab
    Input into    ${EMAIL_OFFER_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_with_value} ${offer_name}
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_with_value} ${offer_name}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Go to CEM page
    Switch to user    Full User Automation
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}
    Change conversation status    ${candidate_name}    Offer    Send Offer
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer
    Wait with medium time
    Click button in email    auto_mail_subject    ${offer_name}
    ${verify_code} =    Get verify code in email    Your ${COMPANY_FRANCHISE_ON} Verification Code      VERIFICATION_CODE
    ...    ${candidate_name}
    Enter verify code in Offer letter    ${verify_code}
    Check element display on screen    auto_attribute_value
    Capture page screenshot
    # Delete data test after run test case
    Delete Workflow data tests after run test case    ${job_name}    ${cj_name}    ${offer_name}    ${workflow_name}


Verify location attribute in workflow trigger in case attribute value is unavailable - Candidate audience (OL-T12991)
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer    ${custom_location_attr_without_value}
    ${cj_name} =    Create Candidate journey has Offer stage
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Active a job    ${job_name}
    ${workflow_name} =    Add a Workflow    None    Custom Workflow    ${cj_name}
    Go to Workflows page
    Click at    ${workflow_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    ${task_random_name} =    Generate random name    auto_task
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_random_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${SEND_OFFER_ACTION}
    Input into    ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    auto_mail_subject
    # Test for Email Tab
    Input into    ${EMAIL_OFFER_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_without_value} ${offer_name}
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_without_value} ${offer_name}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Go to CEM page
    Switch to user    Full User Automation
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}
    Change conversation status    ${candidate_name}    Offer    Send Offer
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer
    Wait with medium time
    Click button in email    auto_mail_subject    ${offer_name}
    ${verify_code} =    Get verify code in email    Your ${COMPANY_FRANCHISE_ON} Verification Code      VERIFICATION_CODE
    ...    ${candidate_name}
    Enter verify code in Offer letter    ${verify_code}
    Check element not display on screen    auto_attribute_value
    Capture page screenshot
    # Delete data test after run test case
    Delete Workflow data tests after run test case    ${job_name}    ${cj_name}    ${offer_name}    ${workflow_name}


Verify location attribute in workflow trigger in case attribute value is available - User audience (OL-T12992)
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer    ${custom_location_attr_with_value}
    ${cj_name} =    Create Candidate journey has Offer stage
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Active a job    ${job_name}
    ${workflow_name} =    Add a Workflow    None    Custom Workflow    ${cj_name}    Full User
    Go to Workflows page
    Click at    ${workflow_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    ${task_random_name} =    Generate random name    auto_task
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_random_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${SEND_COMMUNICATION_ACTION}
    Input into    ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    auto_mail_subject
    # Test for Email Tab
    Input into    ${EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_with_value} ${offer_name}
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_with_value} ${offer_name}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Go to CEM page
    Switch to user    Full User Automation
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}
    Change conversation status    ${candidate_name}    Offer    Send Offer
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer
    Wait with medium time
    Verify user has received the email    auto_mail_subject    ${offer_name}
    Capture page screenshot
    # Delete data test after run test case
    Delete Workflow data tests after run test case    ${job_name}    ${cj_name}    ${offer_name}    ${workflow_name}


Verify location attribute in workflow trigger in case attribute value is unavailable - User audience (OL-T12993)
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer    ${custom_location_attr_without_value}
    ${cj_name} =    Create Candidate journey has Offer stage
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Active a job    ${job_name}
    ${workflow_name} =    Add a Workflow    None    Custom Workflow    ${cj_name}    Full User
    Go to Workflows page
    Click at    ${workflow_name}
    Click by JS    ${WF_ADD_TASK_BUTTON}
    ${task_random_name} =    Generate random name    auto_task
    Input into    ${WF_TASK_NAME_TEXTBOX}    ${task_random_name}
    Click by JS    ${ADD_TASK_TRIGGER_BUTTON}
    Click at    ${CANDIDATE_STATUS_UPDATED_OPTION}
    Click at    ${STATUS_SELECTION}
    Input into    ${STATUS_SEARCH_TEXT_BOX}    Send Offer
    Click at    ${STATUS_VALUE}    Send Offer
    Click at    ${ADD_TRIGGER_BUTTON}
    Click at    ${SEND_COMMUNICATION_ACTION}
    Input into    ${EMAIL_OLIVIA_SUBJECT_TEXT_BOX}    auto_mail_subject
    # Test for Email Tab
    Input into    ${EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_without_value} ${offer_name}
    # Test for SMS Tab
    Click at    ${SMS_OLIVIA_EDITOR_TAB}
    Input into    ${SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA}    \#${custom_location_attr_without_value} ${offer_name}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Go to CEM page
    Switch to user    Full User Automation
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}
    Change conversation status    ${candidate_name}    Offer    Send Offer
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer
    Wait with medium time
    Verify user has received the email    auto_mail_subject    ${offer_name}
    Capture page screenshot
    # Delete data test after run test case
    Delete Workflow data tests after run test case    ${job_name}    ${cj_name}    ${offer_name}    ${workflow_name}

*** Keywords ***
Delete Workflow data tests after run test case
    [Arguments]    ${job_name}    ${cj_name}    ${offer_name}    ${workflow_name}
    Switch to user    ${TEAM_USER}
    Deactivate a job    ${job_name}
    Delete a Job    ${job_name}    ${job_family_name}
    Delete a Journey    ${cj_name}
    Delete a offer    ${offer_name}
    Delete a Workflow    ${workflow_name}
