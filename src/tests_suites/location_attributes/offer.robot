*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/offers_page.robot
Resource            ../../data_tests/location_attributes/offer_data_tests.robot
Resource            ../../pages/system_attributes_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/users_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    test    unilever


*** Variables ***
${custom_location_attr_with_value}          auto_custom_location_attr_with_value
${custom_location_attr_without_value}       auto_custom_location_attr_without_value
${test_location_name}                       ${CONST_LOCATION}
${job_family_name}                          Coffee family job

*** Test Cases ***
Verify show the location attributes list correctly at the offer builder when inputting # (OL-T12975)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${all_location_attribute_keys} =    Get All Location Attributes Key Name
    Go to Offers page
    Click at    Add offer
    Input into    ${OFFER_CONTENT_EDITOR}    \#
    Display the token list that include All Location Attributes that created on System Attributes page
    ...    ${all_location_attribute_keys}
    Input into    ${OFFER_CONTENT_EDITOR}    \#la
    Click at    ${OFFER_QUILL_MENTION_VALUE}    -address
    Check element display on screen    ${OFFER_QUILL_MENTION_HIGHLIGHT_VALUE}    la-address
    Capture page screenshot


Verify show the custom location value at the component when adding a custom location at the System attributes page (OL-T12976)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    Input into    ${OFFER_CONTENT_EDITOR}    \#la-${custom_location_attr_with_value}
    Check element display on screen    ${OFFER_QUILL_MENTION_HIGHLIGHT_VALUE}    la-${custom_location_attr_with_value}
    Capture page screenshot


Verify sending an offer that uses the location attribute token but doesn't have a mapping value with that location attribute (OL-T12977)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer    ${custom_location_attr_without_value}
    Capture page screenshot
    ${cj_name} =    Create Candidate journey has Offer stage
    Capture page screenshot
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Capture page screenshot
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}
    Change conversation status    ${candidate_name}    Offer    Send Offer
    Check element not display on screen    ${custom_location_attr_without_value}
    Capture page screenshot


Verify sending an offer that have use the location attribute token and have a mapping value with that location attribute (OL-T12978)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer    ${custom_location_attr_with_value}
    Capture page screenshot
    ${cj_name} =    Create Candidate journey has Offer stage
    Capture page screenshot
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Capture page screenshot
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}
    Change conversation status    ${candidate_name}    Offer    Send Offer
    Check element display on screen    auto_attribute_value
    Capture page screenshot

*** Keywords ***
Delete Offer data tests after run test case
    [Arguments]    ${job_name}    ${cj_name}    ${offer_name}
    Switch to user    ${TEAM_USER}
    Deactivate a job    ${job_name}
    Delete a Job    ${job_name}    ${job_family_name}
    Delete a Journey    ${cj_name}
    Delete a offer    ${offer_name}
