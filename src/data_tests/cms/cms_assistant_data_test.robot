*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../constants/CMSAssistantConst.py

Test Teardown       Close Browser


*** Test Cases ***
Set up data test for cms assistant
    Open Chrome
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}

    # Create cadidate assistant teams
    Create Assistant Team    ${VN_TEAM_NAME}
    Add assistant to team    ${VN_TEAM_NAME}    ${CANDIDATE_ASSISTANT_NAME}

    Create Assistant Team    ${AUSTRALIA_TEAM_NAME}
    Add assistant to team
    ...    ${AUSTRALIA_TEAM_NAME}
    ...    ${AUSTRALIA_CANDIDATE_ASSISTANT_NAME}
    ...    country=Australia
    ...    country_id=AU

    # Create default candidate assistant
    Create new Assistant    ${DEFAULT_CANDIDATE_ASSISTANT_NAME}    assistant_type=Candidate
    # Create employee assistant
    Create new Assistant    ${EMPLOYEE_ASSISTANT_NAME}    assistant_type=Employee

    # Create conversation
    Add Single conversation with email only    ${CONVERSATION_NAME}
    Wait for the element to fully load    ${COMMON_SPAN_TEXT}    Published
    Capture Page Screenshot

    # create 8 site
    Check if existed reset else create new Landing site
    ...    site_name=${AUSTRALIA_AUDIENCE_LANDING_SITE}
    ${australia_audience_landing_site_url}=    Assign the Care to the site
    ...    care_type=Candidate
    ...    site_name=${AUSTRALIA_AUDIENCE_LANDING_SITE}
    Check if existed reset else create new Landing site
    ...    site_name=${NOT_MATCH_AUDIENCE_LANDING_SITE}
    ${not_match_audience_landing_site_url}=    Assign the Care to the site
    ...    care_type=Candidate
    ...    site_name=${NOT_MATCH_AUDIENCE_LANDING_SITE}
    Check if existed reset else create new Landing site    site_name=${CONVERSATION_ONLY_LANDING_SITE}
    ${conversation_only_landing_site_url}=    Assign the Conversation to the site
    ...    site_name=${CONVERSATION_ONLY_LANDING_SITE}
    ...    conversation_name=${CONVERSATION_NAME}
    Check if existed reset else create new Landing site
    ...    site_name=${CANDIDATE_CARE_ONLY_LANDING_SITE}
    ${candidate_care_only_landing_site_url}=    Assign the Care to the site
    ...    care_type=Candidate
    ...    site_name=${CANDIDATE_CARE_ONLY_LANDING_SITE}
    Check if existed reset else create new Landing site    site_name=${EMPLOYEE_CARE_ONLY_LANDING_SITE}
    ${employee_care_only_landing_site_url}=    Assign the Care to the site
    ...    care_type=Employee
    ...    site_name=${EMPLOYEE_CARE_ONLY_LANDING_SITE}
    Check if existed reset else create new Landing site    site_name=${JOB_SEARCH_ONLY_LANDING_SITE}
    ${job_search_only_landing_site_url}=    Assign the Job search to the site
    ...    site_name=${JOB_SEARCH_ONLY_LANDING_SITE}
    Check if existed reset else create new Landing site
    ...    site_name=${CANDIDATE_CARE__AND_JOB_SEARCH_LANDING_SITE}
    ${candidate_care__and_job_search_landing_site_url}=    Assign the Candidate care and Job search to the site
    ...    site_name=${CANDIDATE_CARE__AND_JOB_SEARCH_LANDING_SITE}
    Check if existed reset else create new Landing site
    ...    site_name=${CANDIDATE_CARE__AND_CONVERSATION_LANDING_SITE}
    ${candidate_care__and_conversation_landing_site_url}=    Assign the Candidate care and Conversation to the site
    ...    site_name=${CANDIDATE_CARE__AND_CONVERSATION_LANDING_SITE}
    ...    conversation_name=${CONVERSATION_NAME}

    # Create 3 audience
    Add an Audience with page url
    ...    ${AUSTRALIA_AUDIENCE}
    ...    ${australia_audience_landing_site_url}
    ...    ${AUSTRALIA_TEAM_NAME}
    Add an Audience with page url
    ...    ${VIETNAM_AUDIENCE_NOT_ASSIGN}
    ...    ${not_match_audience_landing_site_url}
    ...    ${VN_TEAM_NAME}
    Add an Audience with page url
    ...    ${VIETNAM_AUDIENCE_CANDIDATE_CARE}
    ...    ${candidate_care_only_landing_site_url}
    ...    ${VN_TEAM_NAME}

    # apply audience to question care
    ${is_changed}=    Set Variable    False
    Search Care Question and go into    Start
    FOR    ${audience}    IN    @{LIST_AUDIENCE}
        ${is_existed}=    Add Audience into Sample Question    ${audience}
        IF    '${is_existed}'=='False'
            Enter Response message    ${audience}    ${response_template}
            ${is_changed}=    Set Variable    True
        END
    END

    IF    '${is_changed}' == 'True'
        Click at    ${CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON}
        Check element display on screen    Your changes were saved
    END
    Capture Page Screenshot
    Click at    ${CANDIDATE_CARE_BACK_BUTTON}
    Public Assistant Responses Question    Candidate
    Capture Page Screenshot
