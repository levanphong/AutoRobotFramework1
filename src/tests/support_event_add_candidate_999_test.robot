*** Settings ***
Library             SeleniumLibrary
Library             ../configs/LibBuildRobotKeyWord.py
Resource            ../drivers/driver_chrome.robot
Resource            ../pages/login_page.robot
Resource            ../pages/base_page.robot
Resource            ../pages/event_page.robot
Resource            ../pages/client_setup_page.robot
Resource            ../pages/all_candidates_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${company_test}     P Test

*** Test Cases ***
Verify user can add member as normal to per candidate when hiring event has no Virtual Chat Booth created
    Given Setup test
    when Login into system with company    ${ViewOnly}    ${company_test}
    Go to Events page
    Create hiring event without create Virtual Chat Booth session
    Go to Candidates tab in event homepage
    then Check element display on screen    All Registered Candidates
    then add more than 999 plus candidate for virtual event


Verify user can add member as normal to per candidate when hiring event has In Person created
    Given Setup test
    when Login into system with company    ${ViewOnly}    ${company_test}
    and Go to Events page
    and Creating the event    Hiring Event    In Person    Single Event    Scheduled Interviews    None    None
    and Go to Candidates tab in event homepage
    then Check element display on screen    All Registered Candidatesink
    when Click at    ${ALL_REGISTERED_CANDIDATES_LIST_VIEW}
    then add more than 999 plus candidate for virtual event


Verify user can add member as normal to per candidate when hiring event has in person created by existing event created
    Given Setup test
    when Login into system with company    ${ViewOnly}    ${company_test}
    and Go to Events page
    Go to event detail by id    1745
    and Go to Candidates tab in event homepage
    then Check element display on screen    All Registered Candidates
    when Click at    ${ALL_REGISTERED_CANDIDATES_LIST_VIEW}
    then add more than 999 plus candidate for virtual event


Verify user can add member as normal to per candidate when hiring event has virtual chat booth created by existing event created
    Given Setup test
    when Login into system with company    ${ViewOnly}    ${company_test}
    and Go to Events page
    Go to event detail by id    1744
    and Go to Candidates tab in event homepage
    then Check element display on screen    All Registered Candidates
    when Click at    ${ALL_REGISTERED_CANDIDATES_LIST_VIEW}
    then add more than 999 plus candidate for virtual event
