*** Settings ***
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Variables ***
${compose_rating_user}          Rating for campaign with users
${compose_rating_candidate}     Rating for campaign with candidates
@{language_list}                Spanish    Vietnamese
${user}                         User
${candidate}                    Candidate
${default_group}                auto_event_group
${compose_conversation}         campaign_candidate_conversation

*** Test Cases ***
Prepare test data for test case create campaign with type is rating
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create A New Rating     ${user}     ${compose_rating_user}
    Add multilingual language in content step       @{language_list}    audience=${user}    rating_name=${compose_rating_user}
    Create A New Rating     ${candidate}    ${compose_rating_candidate}
    Add multilingual language in content step       @{language_list}    audience=${candidate}       rating_name=${compose_rating_candidate}


Prepare test data for test case create campaign with type is conversation
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Create a conversation

*** Keywords ***
Create a conversation
    ${is_existed}=  Run Keyword And Return Status    Search Conversation in Conversation Builder     ${compose_conversation}
    IF  '${is_existed}' == 'False'
        Go to conversation builder
	    when Add new conversation with name and type    ${compose_conversation}    Event Registration (Single Path)
	    when Select multiple locations at Available locations   ${LOCATION_A}   ${LOCATION_B}
	    Add Group to Conversation       ${default_group}
	    Public the conversation
	END
