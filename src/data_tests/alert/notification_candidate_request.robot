*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/workflows_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/alert_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{permision_locations_user_test}    Test_Location_1    Test_Location_2
${candidate_joruney_name}           OL-T1039 Candidate Journey
${workflow_name}                    Rating Workflow
${rating_name}                      OL-T1039 Rating
${subject_text}                     OL-T1039
${contain_text}                     OL-T1039 Alert
${OL-T1039_user_cp_name}            OL-T1039 User

*** Test Cases ***
Prepare data test for Check Web Alerts (OL-T1039)
    Given Setup Test
    When Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Create user with Role Company Admin   and Assign Location Permission
    Go to Users, Roles, Permissions page
    ${is_existence} =       Is User Existence On Active     ${OL-T1039_user_cp_name}
    IF  ${is_existence} == False
        ${fname&lastname} =     Split String    ${OL-T1039_user_cp_name}    ${SPACE}
        Add A User      ${fname&lastname}[0]    ${fname&lastname}[1]    role=${CP_ADMIN}    is_spam_email=False
        Wait For Page Load Successfully v1
        # Check if add user is successful
        Input into      ${SEARCH_USER_TEXT_BOX}     ${OL-T1039_user_cp_name}
        Check element display on screen     ${OL-T1039_user_cp_name}
    END
    Go To Location Management Page
    FOR     ${location_name}     IN      @{permision_locations_user_test}
        Assign user to location     ${location_name}    ${OL-T1039_user_cp_name}
    END
    # Create HIRE Conversation
    ${conversation_hire_name} =     Add Hire conversation
    # Create Job posting
    Run Keyword And Return Status       Create job posting page     ${conversation_hire_name}
    # Create Rating
    Run Keyword And Return Status       Create A New Rating     Candidate       ${rating_name}
    # Create Candidate joruney
    Add a Candidate Journey     ${candidate_joruney_name}
    # Create workflows
    Run Keyword And Return Status       Add a Workflow      ${workflow_name}    journey_name=${candidate_joruney_name}
    Add a Send Rating Action into Workflow      ${rating_name}      ${CAPTURE_COMPLETE_STATUS}      ${subject_text}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    Create new job, publish and turn on my job      ${JF_COFFEE_FAMILY_JOB}     ${AUTOMATION_TESTER_TITLE_070}      ${permision_locations_user_test}[1]     ${CP_ADMIN}     ${candidate_joruney_name}       ${CP_ADMIN}
    Switch To User      ${OL-T1039_user_cp_name}
    Turn on/off Candidate rating alerts Toggle      On
    Capture Page Screenshot
