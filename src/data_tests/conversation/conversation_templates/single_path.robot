*** Settings ***
Resource            ../../../tests_suites/conversation/conversation_templates/conversation_templates.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${conversation_name_1}      Single Path Hire On Conversation
${conversation_name_2}      Single Path Franchise On Conversation
${conversation_name_3}      Single Path Hire On Email Conversation
${site_name_1}              LandingSiteHireOnSinglePath
${site_name_2}              LandingSiteFranchiseSinglePath
${site_name_3}              LandingSiteHireOnSinglePathEmail

*** Test Cases ***
Create data test for Hire On Company about landing site related to single path
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add Single conversation     ${SINGLE_PATH_TEMPLETE}     ${conversation_name_1}
    Create landing site/widget site     ${landing_site_type}    ${site_name_1}      ${conversation_name_1}


Create data test for Franchise On Company about landing site related to single path
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Add Single conversation     ${SINGLE_PATH_TEMPLETE}     ${conversation_name_2}
    Create landing site/widget site     ${landing_site_type}    ${site_name_2}      ${conversation_name_2}


Create data test for Hire On Company about landing site with conversation builder has email only
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add new conversation with draft status      ${SINGLE_PATH_TEMPLETE}     ${conversation_name_3}
    Turn on     ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_PHONE_NUMBER_QUESTION}
    Turn off    ${CUSTOM_CONVERSATION_TOGGLE}       ${ECLIPSE_EMAIL_QUESTION}
    Public the conversation
    Create landing site/widget site     ${landing_site_type}    ${site_name_3}      ${conversation_name_3}
