*** Settings ***
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/talent_community_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/location_management_page.robot
Variables           ../../locators/talent_community_locators.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${candidate_first_name}     Candidate
${candidate_last_name_a}    A For Gr_Location_Stt
${location_a}               Location A For talent
${group_a}                  Group A For talent
${candidate_last_name_b}    B For Gr_Location_Stt
${location_b}               Location B For talent
${group_b}                  Group B For talent

*** Test Cases ***
Add a Candidate for group and location and yourney status
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Add a Journey Stage     Default Talent Community Journey    Custom
    Input status name       Custom      Status A    Default Talent Community Journey
    Click at    ${STAGE_NAME_IN_JOURNEY}    Custom
    Click at    ${STAGE_NEW_STATUS_BUTTON }
    ${locator} =    Format String       ${COMMON_INPUT_PLACEHOLDER}     Enter Status Name
    input into      ${locator}      Status B
    Click at    ${COMMON_BUTTON}    Done
    Publish a Journey       Default Talent Community Journey
    # add group
    ${journey_name}=    Set variable    Default Talent Community Journey
    ${group_name_a}=    Set variable    Group A For talent
    Add a Group     ${journey_name}     None    ${group_name_a}
    Set Group Scheduling
    Go to Group Management page
    ${group_name_b}=    Set variable    Group B For talent
    Add a Group     ${journey_name}     None    ${group_name_b}
    Set Group Scheduling
    # add location
    Add a Location      ${COMPANY_FRANCHISE_OFF}    Location A For talent   None    None    ${LOCATION_STATE_ALASKA}    None       ${EE_TEAM}
    wait for page load successfully
    Add a Location      ${COMPANY_FRANCHISE_OFF}    Location B For talent   None    None    ${LOCATION_STATE_ALASKA}    None       ${EE_TEAM}
    # Add candidate for filter group and location and journey status
    Switch To User      ${EE_TEAM}
    Go to Talent Community page
    Add a Candidate has location and group to Talent Community      None    ${candidate_first_name}     ${candidate_last_name_a}    ${location_a}       ${group_a}
    Add a Candidate has location and group to Talent Community      None    ${candidate_first_name}     ${candidate_last_name_b}    ${location_b}       ${group_b}
    wait for page load successfully
    Add talent community journey status     Candidate A For Gr_Location_Stt     Status A
    Add talent community journey status     Candidate B For Gr_Location_Stt     Status B

*** Keywords ***
Add talent community journey status
    [Arguments]     ${candidate_name}   ${status_name}
    Input into      ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX}  ${candidate_name}
    Click at    ${candidate_name}
    Click at    ${TALENT_CANDIDATE_PROFILE_STATUS_BUTTON}
    ${status_stage}=    Format string  ${TALENT_CANDIDATE_PROFILE_STAGE }  Custom
    Click at    ${status_stage}
    ${stage_name}=      Format string    ${TALENT_CANDIDATE_PROFILE_STATUS_NAME}    ${status_name}
    Click at    ${stage_name}
    Click at    ${TALENT_CANDIDATE_CONFIRM_STATUS}
    Click at    ${TALENT_CANDIDATE_PROFILE_REMOVE}
    Click at    ${TALENT_CANDIDATE_PAGE_REMOVE_SEARCH_ICON}
    wait for page load successfully
