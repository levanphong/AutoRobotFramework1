*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    stg_mchire

Documentation       Run data test on src/data_tests/candidate_journey/next_steps_users_form.robot file

*** Variables ***
${status_invite_interview}      Invite to Interview
${status_conv_in_progress}      Conversation In-Progress
${status_capture_incomplete}    Capture Incomplete
${auto_button_title}            auto_button_title
${send_rating_status}           Send Rating

*** Test Cases ***
Check add max the 5 button for a status (OL-T11262, OL-T11267)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    ${cj_name} =    Add a Candidate Journey
    Click a Journey     ${cj_name}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}   ${status_conv_in_progress}
#   Add prepare data add max the 5 button for a status
    FOR  ${index}  IN RANGE  5
        Add next step button for a status      ${status_invite_interview}     ${auto_button_title}_${index+1}
    END
    capture page screenshot
#   Verify The [Add button] disable (OL-T11262)
    Reload page
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}   ${status_conv_in_progress}
    Verify element is disabled by checking class    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
    capture page screenshot
#   Check delete the button (OL-T11267) and delete status button after run test
    FOR  ${index}  IN RANGE  5
        Delete next step button of status    ${auto_button_title}_${index+1}
    END
    Delete a Journey    ${cj_name}


Check new UI for the status doesn't add the next steps yet (OL-T11261, OL-T11260)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click a Journey       ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${status_capture_incomplete}
#   (OL-T11261)
    Verify UI doesn't add the next steps yet        ${status_capture_incomplete}
#   Verify new UI for the Next Step after add next step button (OL-T11260)
    FOR  ${index}  IN RANGE  2
        ${button_name} =    Add next step button for a status      ${status_invite_interview}     ${auto_button_title}_${index+1}
        Reload page
        Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}   ${status_capture_incomplete}
        Check span display      ${button_name}
    END
    capture page screenshot
#   Delete status button after run test
    FOR  ${index}  IN RANGE  2
        Delete next step button of status    ${auto_button_title}_${index+1}
    END


Check add the button & enable the Send User Form (OL-T11266)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Click a Journey       ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
	Click at    ${STAGE_NAME_IN_JOURNEY}    ${JOURNEY_RATING_STATUS}
	Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${send_rating_status}
	Check element display on screen     ${JOURNEY_NEXT_STEP_STATUS_ICON_ERASE}      ${send_rating_status}
	Click at    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
#	Verify Closing the [Add button] modal If clicking Cancel button
    Click at    ${JOURNEY_NEXT_STEP_CANCEL_BUTTON}
    Check element not display on screen     ${COMMON_P_TEXT}      Add Next Step Button
    capture page screenshot
    ${button_name}=     Add next step button for a status      ${status_invite_interview}     ${auto_button_title}
    Check span display      ${button_name}
#   Verify The Next Step icon color change to icon accepted
    Check element display on screen     ${JOURNEY_NEXT_STEP_STATUS_ICON_ACCEPTED}     ${send_rating_status}
    Capture page screenshot
#   Delete next step button of status after run test
    Delete next step button of status        ${button_name}

*** Keywords ***
Verify UI doesn't add the next steps yet
    [Arguments]     ${status_name}
    Check element display on screen      Next Step
    Check element display on screen      When a candidate reaches this status, set what action(s) a user can take.
    Check element display on screen      ${status_name}
    Check element display on screen      ${COMMON_PLACEHOLDER}      Add Next Steps Description
    Check element display on screen      ${JOURNEY_ADD_NEXT_STEP_BUTTON}
    capture page screenshot
