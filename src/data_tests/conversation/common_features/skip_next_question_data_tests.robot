*** Settings ***
Library         SeleniumLibrary
Library         ../../../utils/NameUtils.py
Variables       ../../../locators/client_setup_locators.py
Resource        ../../../constants/variables_resource.robot
Resource        ../../../commons/common_keywords.robot
Resource        ../../../pages/users_page.robot

*** Keywords ***
Prepare Skip Next Question Data test for Suite
    Run Setup Only Once    Prepare Skip Next Question Data test

Create Data tests for Follow Up Conversation for Suite
    Run Setup Only Once    Create Data tests for Follow Up Conversation

Prepare Skip Next Question Data test
    Open Chrome
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    # Add a User    Full User
    Wait with medium time
    Enable Client Setup for Skip Next Question    ATS Integration
    Enable Client Setup for Skip Next Question    Capture
    Enable Client Setup for Skip Next Question    Hire
    Enable Client Setup for Skip Next Question    Events
    Enable Client Setup for Skip Next Question    More
    Enable Client Setup for Skip Next Question    Compliance and Security

Enable Client Setup for Skip Next Question
    [Arguments]    ${item}
    Navigate to    Client Setup
    IF    '${item}' == 'ATS Integration'
        Click at    ${INTEGRATIONS_LABEL}
        Turn on    ${ATS_TOGGLE}
        Click at    ${ATS_SYSTEM_SELECTION}
        Set ATS System as SuccessFactors
    ELSE IF    '${item}' == 'Capture'
        Click at    ${CAPTURE_LABEL}
        Turn on    ${FOLLOW_UP_TOGGLE}
        Turn on    ${OUTBOUND_TOGGLE}
        Turn on    ${SCREEN_AND_ACTION}
    ELSE IF    '${item}' == 'Hire'
        Click at    ${HIRE_LABEL}
        Turn on    ${OLIVIA_HIRE_TOGGLE}
        Turn on    ${CANDIDATE_JOURNEYS_TOGGLE}
    ELSE IF    '${item}' == 'Events'
        Click at    ${EVENTS_LABEL}
        Turn on    ${EVENTS_TOGGLE}
        Turn on    ${HIRING_EVENTS_TOGGLE}
        Select Event Phone Number and Keyword association period
    ELSE IF    '${item}' == 'More'
        Click at    ${MORE_LABEL}
        Turn on    ${WORKFLOWS_TOGGLE}
    ELSE IF    '${item}' == 'Compliance and Security'
        Click at    ${COMPLIANCE_AND_SECURITY_LABEL}
        Click at    ${TERMS_DISPLAY_AREA_DROPDOWN}
        ${checkbox_locator} =    Format String    ${TERMS_DISPLAY_AREA_VALUE}    EU
        Check the checkbox    ${checkbox_locator}
        ${checkbox_locator} =    Format String    ${TERMS_DISPLAY_AREA_VALUE}    Global
        Uncheck the checkbox    ${checkbox_locator}
        ${checkbox_locator} =    Format String    ${TERMS_DISPLAY_AREA_VALUE}    CCPA
        Uncheck the checkbox    ${checkbox_locator}
        ${is_changed} =    Run Keyword And Return Status    wait until element is visible
        ...    ${TERMS_DISPLAY_AREA_APPLY_BUTTON}
        IF    ${is_changed}
            Click at    ${TERMS_DISPLAY_AREA_APPLY_BUTTON}
        END
    END
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${CLIENT_SETUP_SAVE_BUTTON}
    IF    ${is_changed}
        Click at    ${CLIENT_SETUP_SAVE_BUTTON}
    END
    Wait with medium time

Set ATS System as SuccessFactors
    ${ats_system} =    Format String    ${ATS_SYSTEM_NAME}    SuccessFactors
    Click at    ${ats_system}
    Input into    ${ATS_HOST}    https://api8preview.sapsf.com
    Input into    ${ATS_COMPANY_ID}    11111
    Input into    ${ATS_USERNAME}    11111
    Input into    ${ATS_PASSWORD}    11111

Select Event Phone Number and Keyword association period
    Click at    ${BEFORE_VALUE_SELECTION}
    ${locator_button} =    Format String    ${BEFORE_VALUE}    1
    Click at    ${locator_button}
    Click at    ${BEFORE_UNIT_SELECTION}
    ${locator_button} =    Format String    ${BEFORE_UNIT}    hours
    Click at    ${locator_button}
    Click at    ${AFTER_VALUE_SELECTION}
    ${locator_button} =    Format String    ${AFTER_VALUE}    1
    Click at    ${locator_button}
    Click at    ${AFTER_UNIT_SELECTION}
    ${locator_button} =    Format String    ${AFTER_UNIT}    hours
    Click at    ${locator_button}

Create Data tests for Follow Up Conversation
    Go to Candidate Journeys page
    ${journey_locator} =    Format String    ${JOURNEY_TITLE}    ${FOLLOW_UP_JOURNEY}
    Load more item in page    ${journey_locator}
    ${is_existed_journey} =    Run Keyword and Return Status    Check element display on screen    ${journey_locator}
    IF    '${is_existed_journey}' == 'False'
        Add new Candidate Journey and add Conversation Stage    ${FOLLOW_UP_JOURNEY}
    END
    Go to Workflows page
    ${workflows_locators} =    Format String    ${WORKFLOW_TITLE}    ${FOLLOW_UP_WORKFLOW}
    Load more item in page    ${workflows_locators}
    ${is_existed_workflow} =    Run Keyword and Return Status    Check element display on screen    ${workflows_locators}
    IF    '${is_existed_workflow}' == 'False'
        Add a Workflow    ${FOLLOW_UP_WORKFLOW}    Custom Workflow    ${FOLLOW_UP_JOURNEY}
        Add a Task into Workflow    ${FOLLOW_UP_WORKFLOW}    Send Conversation    ${SEND_CONVERSATION_ACTION}
        Click at    ${SAVE_TASK_BUTTON}
        Click at    ${PUBLISH_WORKFLOW_BUTTON}
    END
