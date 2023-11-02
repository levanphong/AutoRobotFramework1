*** Settings ***
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_journeys_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/system_attributes_page.robot
Variables           ../../constants/CEMFilterImprovement.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Setup for every Test case
Force Tags          test

*** Variables ***
${intro_referal_employee}       Let's get you signed up for the Employee Referral Program. What's your first and last name?
${intro_referal_candidate}      Thanks {}, I'm excited to help you refer a friend. What's their first and last name?
${need_to_input_name_again}     I'm sorry, I didn't get that. What's their first and last name?
${intro_referal_reason}         would be a good fit for
${capture_type}                 Capture

*** Test Cases ***
Create datatest for cem filter improvement for job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Create new candidate journey and publish    ${CEM_FILTER_JOURNEY_NAME}
    ${list_stage}=      Get elements and convert to list    ${JOURNEY_ALL_STAGE_NAME}
    FOR    ${stage}    IN    @{list_stage}
        IF    '${stage}' not in ${CEM_FILTER_JOURNEY_STAGES}
            Delete a Stage      ${stage}
        END
    END
    Click at    ${PUBLISH_STAGE_BUTTON}     slow_down=2s
    Create new job, publish and turn on my job
    ...     ${CEM_FILTER_JOB_FAMILY}
    ...     ${CEM_FILTER_JOB_NAME}
    ...     ${CEM_FILTER_TEAM_LOCATION}
    ...     None
    ...     ${CEM_FILTER_JOURNEY_NAME}
    Active a job    ${CEM_FILTER_JOB_NAME}
    Switch to user      ${CA_TEAM}
    Go to CEM page
    FOR    ${i}    IN RANGE    ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
        Create a candidate and change status to Interview Pending       ${CEM_FILTER_JOB_NAME}      ${CEM_FILTER_TEAM_LOCATION}     ${CA_TEAM}
    END


Create datatest for cem filter improvement for group
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Add a Group     group_name=${CEM_FILTER_GROUP_NAME}
    Go to CEM page
    FOR    ${i}    IN RANGE    ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
        Add a Candidate     group_name=${CEM_FILTER_GROUP_NAME}
    END


Create datatest for cem filter improvement for location
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Add a Location      ${CEM_FILTER_COMPANY_NAME}      ${CEM_FILTER_LOCATION_NAME}
    Go to CEM page
    FOR    ${i}    IN RANGE    ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
        Add a Candidate     location_name=${CEM_FILTER_LOCATION_NAME}
    END


Create datatest for cem filter improvement for Contacted by
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to Users, Roles, Permissions page
    Add a User      fname=${CONTACTED_BY_FILTER_USER_FN}    lname=${CONTACTED_BY_FILTER_USER_LN}    role=${EDIT_EVERYTHING}
    Go To Location Management Page
    Assign user to location     ${CEM_FILTER_TEAM_LOCATION}     ${CONTACTED_BY_FILTER_USER_NAME}
    Switch to user      ${CONTACTED_BY_FILTER_USER_NAME}
    Go to CEM page
    FOR    ${i}    IN RANGE    ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
        Create a candidate and change status to Interview Pending       None    ${CEM_FILTER_TEAM_LOCATION}     ${CA_TEAM}
    END


Create datatest for cem filter improvement for Employee referrals
    ${url_site} =       Get landing site url by string concatenation    COMPANY_FRANCHISE_ON    ERP
    FOR    ${i}    IN RANGE    ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
        Employee refer a candidate by capture       ${capture_type}     ${url_site}     ${COMPANY_FRANCHISE_ON}
    END

*** Keywords ***
Employee refer a candidate by capture
    [Arguments]    ${type}    ${url}    ${company}
    ${email} =    Generate random name    ${CONFIG.gmail}
    ${candidate_name} =    generate candidate name
    go to    ${url}
    check message and send next message    ${intro_referal_employee}    ${CEM_FILTER_REFERRED_BY_EMPLOYEE_FULLNAME}
    ${intro_referal_candidate_formatted} =      format string      ${intro_referal_candidate}     ${CEM_FILTER_REFERRED_BY_EMPLOYEE_FIRST_NAME}
    check message and send next message    ${intro_referal_candidate_formatted}    ${candidate_name.full_name}
    ${is_input_again}=  Run keyword and return status   Check element display on screen     ${need_to_input_name_again}
    IF  '${is_input_again}' == 'True'
        Candidate input to landing site     ${candidate_name.full_name}
    END
    check message and send next message    email address?    ${email}
    IF    '${type}' == '${capture_type}'
        check message and send next message    ${intro_referal_reason}    good candidate
    END
    Verify Olivia conversation message display      Thank you! Please let
    Verify Olivia conversation message display      know I will be reaching out within one minute
    ${subject_referal} =    set variable    Referral from ${company}
    # Need to wait 1m because setting in Client Setup > Employee Referrals > Delay initial candidate text by
    Sleep   61s
    Click button in email    ${subject_referal}     Hi ${candidate_name.first_name}!
    IF    '${type}' == '${capture_type}'
        check message and send next message    How old are you?    25
        Wait with large time
        check message location attribute show    custom_location
        check message location attribute show    address
        check message location attribute show    city
    ELSE
        Verify Olivia conversation message display    thought you would be a strong candidate anywhere in our organization
    END
