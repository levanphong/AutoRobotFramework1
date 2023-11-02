*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Variables ***
${next_step_talent_candidate_journey}    Next_Steps_Talent_Community_Journey

*** Test Cases ***
Check UI When click on Candidate Journeys page in case Talent Community is OFF (OL-T10901)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Candidate Journeys page
    Check UI Default In Journey     Default Candidate Journey

Check UI When click on Candidate Journeys page in case Talent Community is ON (OL-T10902)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Candidate Journeys page
    Load full Candidate Journeys in page
    Check UI Default In Journey     Default Candidate Journey
    Check UI Default In Journey     Default Talent Community Journey

Check UI when clicking New Journey button - Talent Community is OFF (OL-T10903)
	Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to Candidate Journeys page
    Check UI Default In Journey     Default Candidate Journey
    Click at    ${NEW_JOURNEY_BUTTON}
    Check element display on screen     ${TITLE_JOURNEY_FORM}
    Check label display     Candidate journey name
    Check element display on screen           ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}
    Check element display on screen           ${CREATE_NEW_JOURNEY_BUTTON}
    Capture page screenshot

Check If user clicking New Journey button And Check if user creates Talent Community Journey - Talent Community is ON (OL-T10904, OL-T10906)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Candidate Journeys page
    Click at    ${NEW_JOURNEY_BUTTON}
    Check New Journeys Modal When Talent Community Is On
    Click at    ${NEW_JOURNEY_TYPE_POPUP_REMOVE_ICON}
    Check element not display on screen        ${NEW_JOURNEY_TYPE_POPUP}    wait_time=2s
    Capture page screenshot
    #   Check if user creates Talent Community Journey (OL-T10906)
    Click at  ${NEW_JOURNEY_BUTTON}
    Click at  ${NEW_JOURNEY_TYPE_POPUP_TALENT_COMMUNITY_JOURNEY_TYPE}   slow_down=5s
    Click at  ${NEW_JOURNEY_TYPE_POPUP_NEXT_BUTTON}
    Check label display     Talent Community journey name
    Check element display on screen    ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}
    Check element display on screen    ${CREATE_NEW_JOURNEY_BUTTON}
    ${journey_name} =    Generate random name    auto_journey
    Input into    ${CANDIDATE_JOURNEY_NAME_TEXT_BOX}    ${journey_name}
    Click at    ${CREATE_NEW_JOURNEY_BUTTON}    slow_down=2s
    Check Journey Display On Screen     ${journey_name}
    Capture page screenshot
    Delete a Journey    ${journey_name}

Check if user clicks on newly created Talent Community Journey and Check if user clicks Scheduling Stage- Rating Is ON (OL-T10908, OL-T10909, OL-T10910, OL-T10911)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    ${journey_name} =   Add a Candidate Journey         journey_type=Talent Community Journey
    Go to Candidate Journeys page
    Check Journey Display On Screen     ${journey_name}
    Click a Journey       ${journey_name}
    @{list_stage_name} =    Create List     Capture     Scheduling      Rating
    Check UI Stages      @{list_stage_name}
    #   Check if user clicks Capture Stage (OL-T10909)
    @{capture_statuses} =   Create List     Conversation In-Progress    Capture Complete    Capture Incomplete
    Check UI Status Of Stage Journey     Capture        @{capture_statuses}
    #   Check if user clicks Scheduling Stage (OL -T10910)
    Click on span text      ${journey_name} -
    @{scheduling_statuses} =    Create List     Invite to Interview     No Availability     Interview Pending
    ...     Interview Request Canceled      Interview Request Expired   Interview Scheduled
    ...     Interview Canceled      Interview Complete
    Check UI Status Of Stage Journey     Scheduling        @{scheduling_statuses}
    #   Check if user clicks Rating Stage (OL-T10911 )
    Click on span text      ${journey_name} -
    @{rating_statuses} =    Create List     Send Rating     Rating In-Progress      Rating Complete    Rating Incomplete
    Check UI Status Of Stage Journey     Rating        @{rating_statuses}
    Delete a Journey    ${journey_name}

Check The Next Step information is shown all status of Candidate Journey (OL-T10912, OL-T10914)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Go to Candidate Journeys page
    Click a Journey       ${next_step_talent_candidate_journey}
    Check UI Next Step In All Statuses      ${next_step_talent_candidate_journey}
    #   Check if user clicks Add button button (OL-T10914)
    Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}   Conversation In-Progress
    Click at    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
    Check p text display    Add Next Step Button
    Check label display     Button Title
    Check element display on screen     ${JOURNEY_NEXT_STEP_NAME_BUTTON_INPUT}
    Check label display     Status
    Check element display on screen     ${JOURNEY_NEXT_STEP_ADD_STATUS_ICON}
    Check element display on screen     ${JOURNEY_NEXT_STEP_CANCEL_BUTTON}
    Check element display on screen     ${JOURNEY_NEXT_STEP_SAVE_BUTTON}
    Capture page screenshot
    ${next_step_name} =    Generate random name    auto_next_step
    Input into  ${JOURNEY_NEXT_STEP_NAME_BUTTON_INPUT}      ${next_step_name}
    Search and select a journey status    Invite to Interview
    Click at    ${JOURNEY_NEXT_STEP_MODEL_ALLPY_BUTTON}
    ${locator_status} =    Format String   ${JOURNEY_NEXT_STEP_TOTAL_NUMBER_STATUSES}      Scheduling      Invite to Interview
    Check element display on screen     ${locator_status}
    ${current_url1}=    Get location
    Click at    ${JOURNEY_NEXT_STEP_ADD_STATUS_ICON}
    Click at    ${JOURNEY_NEXT_STEP_MODEL_ALLPY_CANCEL}
    ${current_url2}=    Get location
    Should be equal as strings      ${current_url1}    ${current_url2}
    Click at    ${JOURNEY_NEXT_STEP_SAVE_BUTTON}
    Check element display on screen     ${JOURNEY_NEXT_STEP_STATUS_NAME}   ${next_step_name}
    Capture page screenshot

