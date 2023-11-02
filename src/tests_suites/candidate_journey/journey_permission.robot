*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/base_page.robot
Variables           ../../constants/CandidateJourneyConst.py
Variables           ../../constants/UserRoles.py
Resource            ../../pages/offers_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    stg    stg_mchire    test

Documentation       Run data test at src/data_tests/candidate_journey, note: review job, workflows created. Create user EE TEAM then add to JOURNEY_LOCATION location ,

*** Variables ***
@{briefcase_user_list}=                     ${RECRUITER}    ${HM}
@{ic_person_user_list}=                     ${CP_ADMIN}    ${FO}    ${FS}    ${SUPER_VISOR}    ${RECRUITER}    ${HM}    ${EDIT_EVERYTHING}    ${EDIT_NOTHING}    ${REPORT}
@{ic_person_user_list_franchise_off}=       ${CP_ADMIN}    ${SUPER_VISOR}    ${RECRUITER}    ${HM}    ${EDIT_EVERYTHING}    ${EDIT_NOTHING}
${rating_message}                           Please rate your experience.
${file_name}                                cat-kute.jpg

*** Test Cases ***
The migrate for the Rating stage is View Only (OL-T798)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Click a Journey      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
	Click on tab in stage      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}       ${JOURNEY_RATING_STATUS}        ${JOURNEY_VIEW_ONLY_TAB}
    Verify Default all user roles are shown     ${briefcase_user_list}      ${ic_person_user_list}


Verify Default all user roles are shown in Manage tabs when Franchise in Client Setup is OFF (OL-T698)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
	Click a Journey      ${JOURNEY_CJ_JOURNEY_PERMISSION}
	Click on tab in stage      ${JOURNEY_CJ_JOURNEY_PERMISSION}       ${JOURNEY_RATING_STATUS}        ${JOURNEY_VIEW_ONLY_TAB}
    Verify Default all user roles are shown      ${briefcase_user_list}       ${ic_person_user_list_franchise_off}


Verify Default all user roles are shown in Manage tabs when Franchise in Client Setup is ON (OL-T699)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
	Click a Journey      ${JOURNEY_CJ_JOURNEY_PERMISSION}
	Click on tab in stage      ${JOURNEY_CJ_JOURNEY_PERMISSION}       ${JOURNEY_OFFER_STATUS}        ${JOURNEY_MANAGER_TAB}
    Verify Default all user roles are shown      ${briefcase_user_list}      ${ic_person_user_list}


Verify default to all user roles for View Only - Not Granted when Adding the custom status (OL-T693, OL-T689)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
#	Verify the setting gear show in the Custom Status (OL-T689)
    Click a Journey      ${JOURNEY_CJ_NEXT_STEP_BUILDER}
    Click on tab in stage      ${JOURNEY_CJ_NEXT_STEP_BUILDER}       ${JOURNEY_CUSTOM_STATUS}        ${JOURNEY_MANAGER_TAB}
#   Verify View Only tab not show when Adding the custom status (OL-T693)
    Verify Default all user roles are shown      ${briefcase_user_list}      ${ic_person_user_list}
    Check element not display on screen    ${PERMISSION_PROVER_POPUP_NAME_TAB}      ${JOURNEY_VIEW_ONLY_TAB}
    Capture page screenshot


Verify default to all user roles for View Only when adding the Rating satge (OL-T799)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Click a Journey      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
	Click on tab in stage      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}       ${JOURNEY_RATING_STATUS}        ${JOURNEY_VIEW_ONLY_TAB}
    Verify Default all user roles are shown      ${briefcase_user_list}      ${ic_person_user_list}
    Check element not display on screen    ${PERMISSION_PROVER_POPUP_NAME_TAB}      ${JOURNEY_MANAGER_TAB}
    Capture page screenshot


Verify default to all user roles selected for Manage permissions when adding the new (Conversation/Form/Offer) stages (OL-T692, OL-T688, OL-T701)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
#	Verify default to all user roles (OL-T692) and Verify the settings gear show at Conversatin - Form - Offers stage (OL-T688)
    Click a Journey      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
    Click on tab in stage      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}       ${JOURNEY_CONVERSATION_STATUS}        ${JOURNEY_MANAGER_TAB}
    Verify Default all user roles are shown      ${briefcase_user_list}      ${ic_person_user_list}
    Click on tab in stage      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}       ${JOURNEY_OFFER_STATUS}        ${JOURNEY_MANAGER_TAB}
    Verify Default all user roles are shown      ${briefcase_user_list}      ${ic_person_user_list}
    Click on tab in stage      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}       ${JOURNEY_FORM_STATUS}        ${JOURNEY_MANAGER_TAB}
    Verify Default all user roles are shown      ${briefcase_user_list}      ${ic_person_user_list}
#   Prepare data for OL-T701
    Remove a user on tab of stage     ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${CP_ADMIN}      ${JOURNEY_CONVERSATION_STATUS}
    Remove a user on tab of stage     ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${CP_ADMIN}      ${JOURNEY_OFFER_STATUS}
    Remove a user on tab of stage     ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${CP_ADMIN}      ${JOURNEY_FORM_STATUS}
    Click on span text      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
    Click at    ${PUBLISH_STAGE_BUTTON}
    Go to CEM page
    Switch to user      ${CA_TEAM}
    ${candidate_name} =    Add a Candidate   location_name=${JOURNEY_LOCATION}   job_name=${JOURNEY_NEXT_STEP_BUILDER_JOB}   is_spam_email=False
#   Verify All statuses (Send Conversation/Send Offer/Send Form) is locked (OL-T701)
    Verify status item is locked      ${JOURNEY_CONVERSATION_STATUS}      ${JOURNEY_SEND_CONVERSATION_ACTION}
    Verify status item is locked      ${JOURNEY_FORM_STATUS}      ${JOURNEY_SEND_FORM_ACTION}
    Verify status item is locked      ${JOURNEY_OFFER_STATUS}      ${JOURNEY_SEND_OFFER_ACTION}
#   Return origin journey after run test
    Click a Journey      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
    Add a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${CP_ADMIN}      ${JOURNEY_CONVERSATION_STATUS}
    Add a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${CP_ADMIN}      ${JOURNEY_OFFER_STATUS}
    Add a user on tab of stage        ${JOURNEY_MANAGER_TAB}   ${JOURNEY_CJ_NEXT_STEP_USER_FORM}    ${CP_ADMIN}      ${JOURNEY_FORM_STATUS}
    Click on span text      ${JOURNEY_CJ_NEXT_STEP_USER_FORM}
    Click at    ${PUBLISH_STAGE_BUTTON}


Verify The user will see the Rating message (OL-T712, OL-T713)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
#	Prepare data: Let check EE Team is removed at rating permission in journey before run
    ${candidate_name} =    Add a Candidate   location_name=${JOURNEY_LOCATION}   job_name=${JOURNEY_PERMISSION_JOB}   is_spam_email=False
#   Workflow will send rating when journey status is Accepted  Offer
    Switch to user     ${CA_TEAM}
    Click at    ${candidate_name}
    Send Offer and input verify code     ${candidate_name}   ${JOURNEY_OFFER_STATUS}    ${COMPANY_NEXT_STEP}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    Capture page screenshot
#   Verify The user will see the Rating message (OL-T712)
    Go to CEM page
    Switch to user      ${CA_TEAM}
    Click at    ${candidate_name}
    Check element display on screen     ${CONVERSATION_TEXT}        ${rating_message}
    Capture page screenshot
#   Verify The user will NOT see the Rating message when user is removed out viewonly tab (OL-T713)
    Switch to user      ${EE_TEAM}
    Click at    ${candidate_name}
    Check element not display on screen     ${CONVERSATION_TEXT}        ${rating_message}
    Capture page screenshot


Verify the user change the status of the candidate when a user or user role is added to managing permissions (OL-T702, OL-T704)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
#	Prepare data: Let check EE Team is removed at offer permission in journey before run
	${candidate_name} =    Add a Candidate   location_name=${JOURNEY_LOCATION}   job_name=${JOURNEY_PERMISSION_JOB}    is_spam_email=False
#   Verify The user will see the offer and be able to open the offer letter (OL-T704)
    Switch to user     ${CA_TEAM}
    Send Offer and input verify code     ${candidate_name}   ${JOURNEY_OFFER_STATUS}    ${COMPANY_NEXT_STEP}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    Capture page screenshot
    Go to CEM page
    Click at    ${candidate_name}
    Click at    ${JOURNEY_OFFER}
    Update content offer and resend offer   pay_rate_value=2
    Capture page screenshot
#   Verify the user change the status of the candidate (OL-T702)
    Change conversation status      ${candidate_name}     ${JOURNEY_FORM_STATUS}    ${JOURNEY_SEND_FORM_ACTION}
    Click at      ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Check element display on screen     ${CANDIDATE_JOURNEY_STATUS}     ${JOURNEY_SEND_FORM_ACTION}
    Capture page screenshot
#   Verify The user will not be able to open the offer letter in Hire Details when user hasn't removed permission (OL-T705)
    Switch to user     ${EE_TEAM}
    Click at    ${candidate_name}
    Verify element contain class non-clickable     ${JOURNEY_OFFER}
    Capture page screenshot


Verify The user will see the Form is completed and be able to open the form to view content in Hire Details (OL-T706, OL-T707)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
#	Prepare data: Let check EE Team is removed at form permission in journey before run
	${candidate_name} =    Add a Candidate   location_name=${JOURNEY_LOCATION}   job_name=${JOURNEY_PERMISSION_JOB}    is_spam_email=False
    # Prepare data  (OL-T708)
    Click on span text      Add Forms
    Upload a file with type in Hire Details       Image
    Click at      ${CEM_HIRE_DETAILS_ADD_FILE_BUTTON}
    Check element display on screen     ${file_name}
    capture page screenshot
#   Verify The user will see the Form is completed and be able to open the form (OL-T706)
    Switch to user     ${CA_TEAM}
    Change status to send form and open form     ${candidate_name}    ${COMPANY_NEXT_STEP}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Verify information of form is correctly     ${candidate_name}       ${JOURNEY_FORM}
#   Verify The user open the Form in Hire Detail that not check permisstion (OL-T708)
    Verify user can open the Form uploaded in Hire Detail not need permisstion     ${file_name}
#   Verify The User will see the Form has been completed, but will NOT be able to open the form (OL-T707)
    Switch to user     ${EE_TEAM}
    Click at    ${candidate_name}
    Verify element contain class non-clickable     ${JOURNEY_FORM}
#   Verify The user open the Form in Hire Detail that not check permisstion (OL-T708)
    Verify user can open the Form uploaded in Hire Detail not need permisstion     ${file_name}
    capture page screenshot


Verify The user will see screening questions and candidates answers in the follow up conversation attached to the candidate journey stage. (OL-T709, OL-T708)
    Given Setup test
	Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
#	Prepare data: Let check EE Team is removed at conversation permission in journey before run
	${candidate_name} =    Add a Candidate   location_name=${JOURNEY_LOCATION}   job_name=${JOURNEY_PERMISSION_JOB}    is_spam_email=False
#   Verify The user will see screening questions and candidates answers in the follow up conversation (OL-T709)
    Switch to user     ${CA_TEAM}
    Updated conversation status     ${candidate_name}    ${JOURNEY_CONVERSATION_STATUS}       ${JOURNEY_SEND_CONVERSATION_ACTION}
    Click button in email       Follow up questions from ${COMPANY_NEXT_STEP}        ${candidate_name}           FOLLOW_UP_FRANCHISE_ON
    wait with short time
    Candidate input to landing site     25
    Candidate input to landing site     Thank you
    Go to CEM page
    Click at    ${candidate_name}
    #  Verify screening questions are shown
    Check element display on screen     ${CONVERSATION_LAST_OLIVIA_MESSAGE}      How old are you?
    Check element display on screen     ${CONVERSATION_LAST_OLIVIA_MESSAGE}      ${EVENT_HOW_ELSE_MAY_I_ASSIST_YOU}
    # Verify candidates answers are shown
    Check element display on screen     ${CONVERSATION_LAST_CANDIDATE_MESSAGE}      25
    Check element display on screen     ${CONVERSATION_LAST_CANDIDATE_MESSAGE}      Thank you
#   Verify The user will NOT see screening questions and candidates answers in the follow up conversation (OL-T708)
#    Todo bug: https://paradoxai.atlassian.net/browse/OL-73530
#    Switch to user     ${EE_TEAM}
#    Click at    ${candidate_name}
#    #  Verify screening questions aren't shown
#    Check element not display on screen     ${CONVERSATION_LAST_OLIVIA_MESSAGE}      How old are you?
#    Check element not display on screen     ${CONVERSATION_LAST_OLIVIA_MESSAGE}      ${EVENT_HOW_ELSE_MAY_I_ASSIST_YOU}
#    # Verify candidates answers aren't shown
#    Check element not display on screen     ${CONVERSATION_LAST_CANDIDATE_MESSAGE}      25
#    Check element not display on screen     ${CONVERSATION_LAST_CANDIDATE_MESSAGE}      Thank you

*** Keywords ***
Verify Default all user roles are shown
    [Arguments]     ${briefcase_user_list}      ${ic_person_user_list}
    FOR  ${briefcase_user}      IN    @{briefcase_user_list}
        Check element display on screen         ${JOURNEY_BRIEFCASE_SETTING_USER_PERMISSION}        ${briefcase_user}
        Capture page screenshot
    END
    FOR  ${ic_person_user}  IN  @{ic_person_user_list}
        Check element display on screen         ${JOURNEY_IC_PERSON_SETTING_USER_PERMISSION}        ${ic_person_user}
        Capture page screenshot
    END
    Click at    ${JOURNEY_PROVER_POPUP_CLOSE_BUTTON}

Click on tab in stage
    [Arguments]     ${cj_name}      ${stage}    ${tab}
    Click edit permission of stage     ${cj_name}       ${stage}
	Click at    ${PERMISSION_PROVER_POPUP_NAME_TAB}      ${tab}
	Capture page screenshot

Verify status item is locked
    [Arguments]    ${status_name}       ${status_item}
    Click at    ${CEM_CANDIDATE_JOURNEYS_BUTTON}
    Click on span text      More Options
    Click at     ${COMMON_DIV_EXACT_TEXT}     ${status_name}
    Check element display on screen     ${CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS}        ${status_item}
    Click at    ${CEM_CANDIDATE_JOURNEYS_BUTTON}
    Capture page screenshot

Verify information of form is correctly
    [Arguments]     ${candidate_name}       ${form_name}
    Go to CEM page
    Click at    ${candidate_name}
    Click at    ${CEM_CANDIDATE_FORM}       ${form_name}
    Check hire details form information display on screeen
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 1)
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 2)
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     City
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     State
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     ZIP code
    Capture page screenshot
    Click at       ${CEM_CANDIDATE_FORM_CLOSE_ICON}

Verify user can open the Form uploaded in Hire Detail not need permisstion
    [Arguments]     ${file_name}
    Click at    ${CEM_CANDIDATE_FORM}       ${file_name}
    Check element display on screen     ${CEM_CANDIDATE_FORM_MODAL}     ${file_name}
    capture page screenshot
    Click at       ${CEM_CANDIDATE_FORM_CLOSE_ICON}

Verify element contain class non-clickable
    [Arguments]     ${value}
    ${elemnt_locator} =  Format string      ${CEM_HIRE_DETAILS_HIRE_ITEM}       ${value}
    ${attribute_value}=  Get attribute and format text     class   ${elemnt_locator}
    Should contain     ${attribute_value}     non-clickable
