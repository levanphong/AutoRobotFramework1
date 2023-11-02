*** Settings ***
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/candidate_volume_optimizer_page.robot
Resource            ../../pages/job_data_packages_page.robot
Resource            ../../pages/conversation_builder_page.robot
Variables           ../../constants/MyJobConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Setup for every Test case
Default Tags        lts_stg

*** Variables ***

*** Test Cases ***
Create empty job user
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Users, Roles, Permissions page
    Add a User      fname=${EMPTY_JOB_USER_FN}      lname=${EMPTY_JOB_USER_LN}      role=${EDIT_EVERYTHING}


Create jobs datatest
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    add new area    ${COMPANY_HIRE_ON}      ${MY_JOB_DATA_PACKAGE_AREA}
    add new location to area    ${MY_JOB_DATA_PACKAGE_AREA}     Idle location A
    add new location to area    ${MY_JOB_DATA_PACKAGE_AREA}     Idle location B
    ${locations}=       Create List     Idle location A     Idle location B
    Go to Jobs page
    check and create job Basic Multi-Location       ${MY_JOB_TEST_NAME}     ${JF_COFFEE_FAMILY_JOB}     ${MY_JOB_TEST_LOCATION}     ${MY_JOB_TEST_BRAND}    shift=None
    check and create job Basic Multi-Location       ${MY_JOB_HAS_SHIFT_NAME}    ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_STREET_NGUYEN_HUU_THO}       ${COMPANY_HIRE_ON}      shift=${MY_JOB_HAS_LIST_SHIFT}
    check and create job Basic Multi-Location       ${MY_JOB_HAS_CVO_AND_SHIFT_JOB_NAME}    ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_STREET_NGUYEN_HUU_THO}       ${COMPANY_HIRE_ON}      shift=${MY_JOB_HAS_LIST_SHIFT}
    check and create job Basic Multi-Location       ${MY_JOB_MENU_TEST_JOB_NAME}    ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_STREET_NGUYEN_HUU_THO}       ${COMPANY_HIRE_ON}      shift=${MY_JOB_HAS_LIST_SHIFT}      description=${MY_JOB_DESCRIPTION_TEXT}
    check and create job Basic Multi-Location       ${MY_JOB_HAS_DATA_PACKAGE_JOB_NAME}     ${JF_COFFEE_FAMILY_JOB}     ${locations}    ${COMPANY_HIRE_ON}
    check and create job Basic Multi-Location       ${MY_JOB_APPLY_VIA_LINK}    ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_STREET_NGUYEN_HUU_THO}       ${COMPANY_HIRE_ON}
    check and create job Basic Multi-Location       ${MY_JOB_JOB_SEARCH_JOB_NAME}       ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_STREET_NGUYEN_HUU_THO}       ${COMPANY_HIRE_ON}
    Active a job    ${MY_JOB_JOB_SEARCH_JOB_NAME}
    Go to Location Management page
    Assign user to location     ${LOCATION_STREET_NGUYEN_HUU_THO}       ${CA_TEAM}
    Switch to Company v1    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to Jobs page
    check and create job Basic Multi-Location       ${MY_JOB_TEST_NAME}     ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_NAME_2}


Create job for CVO
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to Jobs page
    check and create job Basic Multi-Location       ${MY_JOB_CVO_JOB_NAME}      ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_NAME_1}      shift=${MY_JOB_HAS_LIST_SHIFT}
    Go to Jobs page
    check and create job Basic Multi-Location       ${MY_JOB_REACH_THRESHOLD_JOB_NAME}      ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_NAME_1}      shift=None
    Go to Jobs page
    check and create job Basic Multi-Location       ${MY_JOB_NOTIFY_JOB_NAME}       ${JF_COFFEE_FAMILY_JOB}     ${LOCATION_NAME_1}      shift=None


Create CVO datatest
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to Candidate Volume Optimizer page
    ${segment_info_cvo} =       Create Dictionary       segment_name=${MY_JOB_CVO_SEGMENT}
    ...     targeting_rule=Job Title
    ...     matches=Exactly matches
    ...     filter_text=${MY_JOB_CVO_JOB_NAME}
    ...     threshold_status_parent=Capture
    ...     threshold_status_children=${CAPTURE_COMPLETE_STATUS}
    ...     threshold_num_of_candidates=None
    ...     threshold_action=None
    Add a customize Job Segment     ${segment_info_cvo}
    Go to Candidate Volume Optimizer page
    ${segment_info_threshold} =     Create Dictionary       segment_name=${MY_JOB_REACH_THRESHOLD_CVO_SEGMENT}
    ...     targeting_rule=Job Title
    ...     matches=Exactly matches
    ...     filter_text=${MY_JOB_REACH_THRESHOLD_JOB_NAME}
    ...     threshold_status_parent=Capture
    ...     threshold_status_children=${CAPTURE_COMPLETE_STATUS}
    ...     threshold_num_of_candidates=None
    ...     threshold_action=None
    Add a customize Job Segment     ${segment_info_threshold}
    Go to Candidate Volume Optimizer page
    ${segment_info_notify} =    Create Dictionary       segment_name=${MY_JOB_NOTIFY_SEGMENT}
    ...     targeting_rule=Job Title
    ...     matches=Exactly matches
    ...     filter_text=${MY_JOB_NOTIFY_JOB_NAME}
    ...     threshold_status_parent=Capture
    ...     threshold_status_children=${CAPTURE_COMPLETE_STATUS}
    ...     threshold_num_of_candidates=None
    ...     threshold_action=Olivia Will Notify the Hiring Team
    Add a customize Job Segment     ${segment_info_notify}
    Switch to Company v1    ${COMPANY_HIRE_ON}
    Go to Candidate Volume Optimizer page
    ${segment_info_cvo_and_shift} =     Create Dictionary       segment_name=${MY_JOB_HAS_CVO_AND_SHIFT_SEGMENT}
    ...     targeting_rule=Job Title
    ...     matches=Exactly matches
    ...     filter_text=${MY_JOB_HAS_CVO_AND_SHIFT_JOB_NAME}
    ...     threshold_status_parent=Capture
    ...     threshold_status_children=${CAPTURE_COMPLETE_STATUS}
    ...     threshold_num_of_candidates=None
    ...     threshold_action=None
    Add a customize Job Segment     ${segment_info_cvo_and_shift}
    Go to My Jobs page
    Apply threshold for a job       ${MY_JOB_HAS_CVO_AND_SHIFT_JOB_NAME}    2
    Go to Candidate Volume Optimizer page
    ${segment_info_menu} =      Create Dictionary       segment_name=${MY_JOB_MENU_TEST_SEGMENT}
    ...     targeting_rule=Job Title
    ...     matches=Exactly matches
    ...     filter_text=${MY_JOB_MENU_TEST_JOB_NAME}
    ...     threshold_status_parent=Capture
    ...     threshold_status_children=${CAPTURE_COMPLETE_STATUS}
    ...     threshold_num_of_candidates=2
    ...     threshold_action=Olivia Will Notify the Hiring Team
    Add a customize Job Segment     ${segment_info_menu}


Create data package datatest
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to job data packages page
    add new job package     ${MY_JOB_DATA_PACKAGE_A}
    add new job package     ${MY_JOB_DATA_PACKAGE_B}


Create conversation datatest
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Add Hire conversation       ${MY_JOB_COVERSATION}
    Check if existed reset else create new Landing site     ${MY_JOB_JOB_SEARCH_SITE}
    Assign the Conversation to the site     ${MY_JOB_JOB_SEARCH_SITE}       ${MY_JOB_COVERSATION}
