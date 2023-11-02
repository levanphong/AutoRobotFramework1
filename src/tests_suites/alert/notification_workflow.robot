*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/alert_management_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/message_customize_page.robot
Documentation       Run data test on src/data_tests/alert/notification_workflow.robot file

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{permision_locations_user_test}    Test_Location_1    Test_Location_2
${subject_text}                     Workflow
${content_text}                     Hi {}, {} Workflow Alert
&{dic_users}                        OL_T5872=OL-T5872 User    OL_T5873=OL-T5873 User    OL_T5874=OL-T5874 User

*** Test Cases ***
Check if the locations list is correct for each user base on the permission (OL-T5872)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Alert Management page
    Navigate to Option in alert management      Workflows
    Select User     ${dic_users.OL_T5872}
    # Verify text Appear when hover Location icon
    ${locator_location_icon} =      Format String       ${WORKFLOWS_PATTERN_RESULT_USER_LOCATION_ICON}      ${dic_users.OL_T5872}
    Mouse Over      ${locator_location_icon}
    Check Element Display On Screen     ${WORKFLOWS_HOVER_LOCATION_ICON_TEXT}
    Capture Page Screenshot
    # Verify Display the location tree and show correct the locations that the user has permision on
    Click At    ${WORKFLOWS_PATTERN_RESULT_USER_LOCATION_ICON}      ${dic_users.OL_T5872}
    ${item_list} =      Create List
    ${item_elements} =      Get WebElements     ${WORKFLOWS_LIST_LOCATION_PERMISSION}
    FOR    ${element}    IN    @{item_elements}
        ${element_text} =       Replace String      ${element.get_attribute('innerHTML')}       ${EMPTY}    ${EMPTY}
        Append To List      ${item_list}    ${element_text}
    END
    Lists Should Be Equal       ${permision_locations_user_test}    ${item_list}
    Capture Page Screenshot
    # Search location and show correct locations that match the search keyword
    Input Into      ${WORKFLOWS_LOCATION_SEARCH_INPUT}      ${permision_locations_user_test}[1]
    Check Text Display      ${permision_locations_user_test}[1]
    Wait With Short Time
    ${item_list} =      Create List
    ${item_elements} =      Get WebElements     ${WORKFLOWS_LIST_LOCATION_PERMISSION_TEXT}
    FOR    ${element}    IN    @{item_elements}
        Element Should Contain      ${element}      ${permision_locations_user_test}[1]
    END
    Capture Page Screenshot
    # Select location
    Check The Checkbox      ${WORKFLOWS_LOCATION_FIRST_CHECKBOX}
    Click At    ${WORKFLOWS_LOCATION_APPLY_BUTTON}
    Save alert management page


Check if the user receives alert in case no location is selected (OL-T5873)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Assign no location for user
    Assign locations alert workflow for user    ${dic_users.OL_T5873}
    # Get link apply Job
    ${url_job} =    Turn on job and get internal job link       ${AUTOMATION_TESTER_TITLE_068}      ${permision_locations_user_test}[0]
    # Conversation
    ${random_mail} =    Generate random name    ${CONFIG.gmail}
    ${random_name} =    Generate Candidate Name
    Candidate starts apply job conversation via job apply link      ${url_job}      ${random_name.full_name}    ${random_mail}
    # Verify has received the email
    ${fname&lname} =    Split String    ${dic_users.OL_T5873}       ${SPACE}
    ${content_workflow_text} =      Format String       ${content_text}     ${fname&lname}[0]       ${random_name.first_name}
    Verify user has received the email      ${subject_text}     ${content_workflow_text}


Check if the user receives alert in case 1 location is selected (OL-T5874)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Assign no location for user
    @{location_name} =      Create List     ${permision_locations_user_test}[0]
    Assign locations alert workflow for user    ${dic_users.OL_T5874}       ${location_name}
    # Get link apply Job
    ${url_job_location_a} =     Turn on job and get internal job link       ${AUTOMATION_TESTER_TITLE_068}      ${permision_locations_user_test}[0]
    ${url_job_location_b} =     Turn on job and get internal job link       ${AUTOMATION_TESTER_TITLE_068}      ${permision_locations_user_test}[1]
    # Conversation  a
    ${random_mail_a} =      Generate random name    ${CONFIG.gmail}
    ${random_name_a} =      Generate Candidate Name
    Candidate starts apply job conversation via job apply link      ${url_job_location_a}       ${random_name_a.full_name}      ${random_mail_a}
    # Conversation b
    Delete All Cookies
    ${random_mail_b} =      Generate random name    ${CONFIG.gmail}
    ${random_name_b} =      Generate Candidate Name
    Candidate starts apply job conversation via job apply link      ${url_job_location_b}       ${random_name_b.full_name}      ${random_mail_b}
    # Verify has received the email
    ${fname&lname} =    Split String    ${dic_users.OL_T5874}       ${SPACE}
    ${content_workflow_text} =      Format String       ${content_text}     ${fname&lname}[0]       ${random_name_a.first_name}
    Verify user has received the email      ${subject_text}     ${content_workflow_text}
    ${content_workflow_text} =      Format String       ${content_text}     ${fname&lname}[0]       ${random_name_b.first_name}
    ${is_received_mail} =       Run Keyword And Return Status       Verify user has received the email      ${subject_text}     ${content_workflow_text}
    Log To Console      ${content_workflow_text}
    Should Be Equal As Strings      ${is_received_mail}     False


Check if user is able to add user into Worklow section (OL-T5867)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Create user with Role Company Admin   and Assign Location Permission
    Go to Users, Roles, Permissions page
    ${fname_user} =     Add A User      role=${CP_ADMIN}
    Go To Location Management Page
    FOR     ${location_name}     IN      @{permision_locations_user_test}
        Assign user to location     ${location_name}    ${fname_user}
    END
    Go To Alert Management Page
    Navigate to Option in alert management      Workflows
    Click At    ${ALERT_MANAGEMENT_USER_INPUT}
    Scroll To Element       ${WORKFLOWS_PATTERN_SUGGESTION_USER}    ${fname_user}
    Click At    ${WORKFLOWS_PATTERN_SUGGESTION_USER}    ${fname_user}
    Check Element Display On Screen     ${WORKFLOWS_PATTERN_RESULT_USER}    ${fname_user}
    Check Element Display On Screen     ${WORKFLOWS_PATTERN_RESULT_USER_LOCATION_ICON}      ${fname_user}
    Check Element Display On Screen     ${WORKFLOWS_PATTERN_RESULT_USER_NOTIFICATION_ICON}      ${fname_user}
    Check Element Display On Screen     ${WORKFLOWS_PATTERN_RESULT_USER_REMOVE_ICON}    ${fname_user}
    Save alert management page
    Capture Page Screenshot
    Go to Users, Roles, Permissions page
    Deactivate a User       ${fname_user}


Check if user is able to remove a user from the Workflow section (OL-T5871)
    Given Setup Test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    # Create user with Role Company Admin   and Assign Location Permission
    Go to Users, Roles, Permissions page
    ${fname_user} =     Add A User      role=${CP_ADMIN}
    Go To Location Management Page
    FOR     ${location_name}     IN      @{permision_locations_user_test}
        Assign user to location     ${location_name}    ${fname_user}
    END
    Go to Alert Management page
    Navigate to Option in alert management      Workflows
    # Add user to workflow
    Select User     ${fname_user}
    Save Alert Management Page
    Check Element Display On Screen     ${WORKFLOWS_PATTERN_RESULT_USER}    ${fname_user}
    # Remove user to workflow
    Click At    ${WORKFLOWS_PATTERN_RESULT_USER_REMOVE_ICON}    ${fname_user}
    Save Alert Management Page
    Check Element Not Display On Screen     ${WORKFLOWS_PATTERN_RESULT_USER}    ${fname_user}
    Capture Page Screenshot
    Go to Users, Roles, Permissions page
    Deactivate a User       ${fname_user}
