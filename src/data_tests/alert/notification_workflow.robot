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
${candidate_joruney_name}           Notification Workflow Candidate Journey
${workflow_name}                    Notification Workflow
${subject_text}                     Workflow
${contain_text}                     Hi #user-firstname, #candidate-firstname Workflow Alert
${conversation_hire_name}           Hire-Conversation
&{dic_users}                        OL_T5872=OL-T5872 User    OL_T5873=OL-T5873 User    OL_T5874=OL-T5874 User

*** Test Cases ***
Prepare data test for Notification Workflow
    #  Check if the locations list is correct for each user base on the permission (OL-T5872)
    Given Setup Test
    When Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Create user with Role Company Admin   and Assign Location Permission
    FOR    ${key}    IN    @{dic_users}
        Go to Users, Roles, Permissions page
        ${is_existence} =       Is User Existence On Active     ${dic_users}[${key}]
        IF  ${is_existence} == False
            ${fname&lastname} =     Split String    ${dic_users}[${key}]    ${SPACE}
            Add A User      ${fname&lastname}[0]    ${fname&lastname}[1]    role=${CP_ADMIN}    is_spam_email=False
        END

        Go To Location Management Page
        FOR     ${location_name}     IN      @{permision_locations_user_test}
            Assign user to location     ${location_name}    ${dic_users}[${key}]
        END
    END
    # Create HIRE Conversation
    ${conversation_hire_name} =     Add Hire conversation
    # Create Job posting
    Run Keyword And Return Status       Create job posting page     ${conversation_hire_name}
    # Create Candidate joruney
    Add a Candidate Journey     ${candidate_joruney_name}
    # Create workflows
    Run Keyword And Return Status       Add A Workflow      ${workflow_name}    journey_name=${candidate_joruney_name}      audience_type=${CP_ADMIN}
    Add a Send communication Action into Workflow       status=${CAPTURE_COMPLETE_STATUS}       subject_text=${subject_text}    content_text=${contain_text}
    Click at    ${SAVE_TASK_BUTTON}
    Click at    ${PUBLISH_WORKFLOW_BUTTON}
    # Create job
    Create new job, publish and turn on my job      ${JF_COFFEE_FAMILY_JOB}     ${AUTOMATION_TESTER_TITLE_068}      ${permision_locations_user_test}    ${CP_ADMIN}     ${candidate_joruney_name}       ${CP_ADMIN}
    # toggles on Receive an email alert to when a workflow alert is sent when viewing [Alert Management] page
    FOR   ${key}    IN    @{dic_users}
        Go To CEM Page
        Switch To User      ${dic_users}[${key}]
        Turn on/off Workflow alerts Toggle      On
    END
    Capture Page Screenshot
