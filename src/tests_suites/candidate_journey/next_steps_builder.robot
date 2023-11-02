*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    regression    stg    stg_mchire

Documentation       Run data test on src/data_tests/candidate_journey/next_steps_builder.robot file

*** Variables ***
${status_invite_interview}          Invite to Interview
${send_rating_status}               Send Rating
${status_send_offer}                Send Offer
${status_send_form}                 Send Form
${status_form_expired}              Form Expired
${status_form_canceled}             Form Canceled
${status_conv_in_progress}          Conversation In-Progress
${status_capture_incomplete}        Capture Incomplete
${status_capture_complete}          Capture Complete
${auto_button_title}                auto_button_title
${next_steps_description}           next_steps_description
@{stages_list}=                     Offer    Application    Scheduling    Conversation    Disposition    Custom    Onboarding    Form    Background Check    Hire    Scheduling - 2nd Round    Scheduling - 3rd Round    Scheduling - 4th Round    Scheduling - 5th Round
@{offer_status_list}=               Send Offer    Offer Expired    Offer Canceled
@{form_status_list}=                Send Form    Form Expired    Form Canceled
@{application_status_list}=         Send Application    Application Expired    Application Canceled
@{background_check_status_list}=    Background Check Sent    Background Check In-Progress    Background Check Complete    Background Check Rejection    Background Check Exception
@{conversation_status_list}=        Send Conversation    Conversation Expired    Conversation Canceled
@{hired_status_list}=               Hired    Hire Rejection    Hire Exception
@{onboarding_status_list}=          Send Onboarding    Onboarding Rejection    Onboarding Exception    Onboarding Expired    Onboarding Canceled

*** Test Cases ***
Builder_Check the button adds successfully (OL-T7665, OL-T7670, OL-T7676)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click a Journey       ${JOURNEY_CJ_NEXT_STEP_BUILDER}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}   ${status_capture_incomplete}
    ${status_list} =    Create List      ${status_invite_interview}      ${status_send_offer}        ${status_send_form}
#   Verify the user adds max 5 button (OL-T7670)
    FOR  ${index}  IN RANGE  5
#       Verify the button add successfully (OL-T7665)
        ${button_name} =     Add next step button have many journey status      ${status_list}     ${auto_button_title}_${index+1}
        Check span display      ${button_name}
    END
    capture page screenshot
    #   Verify The [Add button] disable (OL-T7670)
    Verify element is disabled by checking class    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
    capture page screenshot
#   Verify user can delete the button (OL-T7676)
    FOR  ${index}  IN RANGE  5
        Delete next step button of status    ${auto_button_title}_${index+1}
    END


Builder Check next steps add successfully (OL-T7669, OL-T7673)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click a Journey       ${JOURNEY_CJ_NEXT_STEP_BUILDER}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${status_capture_complete}
#   Prepare data for OL-T7669
    ${description_input} =      Format String     ${COMMON_PLACEHOLDER}       Add Next Steps Description
    Input into      ${description_input}        ${next_steps_description}
    Click at        ${COMMON_BUTTON}    Done
#   Verify add next steps description successfully (OL-T7669)
    reload page
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${status_capture_complete}
    Check element display on screen     ${JOURNEY_NEXT_STEP_DESCRIPTION}      ${next_steps_description}
    capture page screenshot
#   Prepare data for OL-T7673
    ${status_list} =    Create List      ${status_send_form}        Form Expired        Form Canceled
    ${button_name} =    Add next step button have many journey status        ${status_list}     ${auto_button_title}
#   Verify the total number of statuses that selected show under the stage (OL-T7673)
    Click on span text      ${button_name}
    ${total_number_statuses} =      Format String     ${JOURNEY_NEXT_STEP_TOTAL_NUMBER_STATUSES}        Form        3 Statuses
    Check element display on screen         ${total_number_statuses}
    capture page screenshot
    Click at    ${JOURNEY_NEXT_STEP_CANCEL_BUTTON}
#   Delete data test after run
    Clear element text with keys      ${description_input}
    Click at        ${COMMON_BUTTON}    Done
    Delete next step button of status    ${button_name}


Builder_Check all statuses that moved manually show in the dropdown when adding the button (OL-T28739)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Click a Journey       ${JOURNEY_CJ_NEXT_STEP_BUILDER}
    Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${status_capture_complete}
    Click at    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
    Verify The all stages that having the status is shown       @{stages_list}
    Verify all statuses show in the dropdown is correctly       ${JOURNEY_OFFER_STATUS}    @{offer_status_list}
    Verify all statuses show in the dropdown is correctly       Form    @{form_status_list}
    Verify all statuses show in the dropdown is correctly       Application     @{application_status_list}
    Verify all statuses show in the dropdown is correctly       Background Check    @{background_check_status_list}
    Verify all statuses show in the dropdown is correctly       Conversation    @{conversation_status_list}
    Verify all statuses show in the dropdown is correctly       Hire    @{hired_status_list}
    Verify all statuses show in the dropdown is correctly       Onboarding      @{onboarding_status_list}
    Verify one status show in the dropdown                      Disposition      Disposition status
    Verify one status show in the dropdown                      Custom      Custom status
    Verify one status show in the dropdown                      Scheduling      ${status_invite_interview}
    Verify one status show in the dropdown                      Scheduling - 2nd Round      ${status_invite_interview}
    Verify one status show in the dropdown                      Scheduling - 3rd Round      ${status_invite_interview}
    Verify one status show in the dropdown                      Scheduling - 4th Round      ${status_invite_interview}
    Verify one status show in the dropdown                      Scheduling - 5th Round      ${status_invite_interview}


Builder_All of the statuses within a stage will automatically check when clicking a checkbox of that stage (OL-T7671)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Click a Journey       ${JOURNEY_CJ_NEXT_STEP_BUILDER}
	Click at    ${STAGE_NAME_IN_JOURNEY}    ${JOURNEY_RATING_STATUS}
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${send_rating_status}
    Click at    ${JOURNEY_ADD_NEXT_STEP_BUTTON}
    Click at    ${JOURNEY_NEXT_STEP_ADD_STATUS_ICON}
#   Verify all of the statuses within a stage will automatically check (OL-T7671)
    Click at        ${JOURNEY_NEXT_STEP_STATUS_SECTION_CHECKBOX}     ${JOURNEY_OFFER_STATUS}
    Click at    ${JOURNEY_NEXT_STEP_MODEL_ALLPY_BUTTON}
    #    Verify the status name shows under the name stage (OL-T7674)
    ${total_number_statuses} =      Format String     ${JOURNEY_NEXT_STEP_TOTAL_NUMBER_STATUSES}        ${JOURNEY_OFFER_STATUS}        3 Statuses
    Check element display on screen         ${total_number_statuses}
    capture page screenshot


Builder User will be able to enter text into Next Step Description (OL-T7664)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Click a Journey       ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
	Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${status_capture_complete}
#   Verify add next steps description support the same #..  successfully (OL-T7669)
	${description_input} =      Format String     ${COMMON_PLACEHOLDER}       Add Next Steps Description
    Input into      ${description_input}        \#candidate-name
    Click at        ${COMMON_BUTTON}    Done
    Go to Candidate Journeys page
    Publish a Journey     ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
    Go to CEM page
#   Verify next steps description on CEM
    ${candidate_name} =    Add a Candidate   location_name=${JOURNEY_LOCATION}   job_name=${JOURNEY_NEXT_STEP_BUILDER_JOB}   is_spam_email=False
    Click at    ${CANDIDATE_JOURNEY_STATUS}     ${status_capture_complete}
    ${description_next_step} =  Format String     ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_DESCRIPTION}        ${status_capture_complete}      ${candidate_name}
    Check element display on screen        ${description_next_step}
    capture page screenshot
#   Clear data test
    Click a Journey       ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
	Click at    ${STAGE_NAME_IN_JOURNEY}    Capture
    Click at    ${JOURNEY_NEXT_STEP_NAME_STATUS_ITEM}       ${status_capture_complete}
    Clear element text with keys     ${description_input}
    Click at        ${COMMON_BUTTON}    Done

*** Keywords ***
Verify all statuses show in the dropdown is correctly
    [Arguments]     ${stage}    @{status_list}
    FOR     ${status}    IN        @{status_list}
        Verify one status show in the dropdown     ${stage}     ${status}
    END

Verify one status show in the dropdown
    [Arguments]     ${stage}   ${status}
    Search a journey status     ${status}
    ${status_in_dropdown} =   Format String        ${JOURNEY_NEXT_STEP_STATUS_SECTION_OF_STAGE_LABEL}     ${stage}     ${status}
    Check element display on screen     ${status_in_dropdown}

Verify The all stages that having the status is shown
    [Arguments]     @{stages_list}
    FOR     ${stage}    IN        @{stages_list}
        Click at    ${JOURNEY_NEXT_STEP_ADD_STATUS_ICON}
        ${status_in_dropdown} =   Format String        ${JOURNEY_NEXT_STEP_STATUS_SECTION}     ${stage}
        Check element display on screen     ${status_in_dropdown}
        capture page screenshot
    END
