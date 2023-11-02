*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          test

*** Test Cases ***
Creating a New Stage, Users will be able to edit the stages for their candidate journey (OL-T122, OL-T120)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go To Candidate Journeys Page
    ${journey_name}=    Add a Candidate Journey
    Capture page screenshot
    when Add a stage    ${JOURNEY_CUSTOM_STATUS}
    Then Click At       ${JOURNEY_ICON_EDIT_STAGE}      ${JOURNEY_CUSTOM_STATUS}
    ${random_text}=     Generate Random Name    auto_stage
    press keys          None    CTRL+a+BACKSPACE
    press keys          None    ${random_text}
    press keys          None    ENTER
    And Wait For Loading Icon Disappear
    Delete a Journey    ${journey_name}
    Capture page screenshot
