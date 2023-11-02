*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/conversation_builder_page.robot
Variables       ../locators/alert_management_locators.py

*** Keywords ***
Navigate to Option in alert management
    [Arguments]    ${option}
    Click on strong text    ${option}
    Wait For Page Load Successfully V1

Select User
    [Arguments]    ${name}
    Input Into    ${ALERT_MANAGEMENT_USER_INPUT}   ${name}
    Wait For Loading Icon Disappear
    ${locator_user} =   Format String    ${WORKFLOWS_PATTERN_SELECT_USER}      ${name}
    Click At    ${locator_user}

Delete User from workflow alert
    [Arguments]    ${name}
    ${is_added} =   Is User added on workflow alert     ${name}
    IF  ${is_added} == True
        Click At    ${WORKFLOWS_PATTERN_RESULT_USER_REMOVE_ICON}    ${name}
        Save Alert Management Page
    END

Is User added on workflow alert
    [Arguments]    ${name}
    Scroll To Element    ${WORKFLOWS_PATTERN_RESULT_USER}   ${name}
    ${is_existed} =     Run Keyword And Return Status    Check element display on screen    ${WORKFLOWS_PATTERN_RESULT_USER}   ${name}
    [Return]    ${is_existed}

Save alert management page
    ${is_changed} =   Run Keyword And Return Status    Check element display on screen   ${ALERT_MANAGEMENT_SAVE_BUTTON}      wait_time=2s
    IF    ${is_changed}
        Click at  ${ALERT_MANAGEMENT_SAVE_BUTTON}
        wait for page load successfully v1
        run keyword and ignore error   Check element display on screen   ${ALERT_MANAGEMENT_SAVE_BUTTON}
        Check element not display on screen   ${ALERT_MANAGEMENT_SAVE_BUTTON}
    END

Turn on/off Candidate rating alerts Toggle
    [Arguments]    ${type}
    Go To Alert Management Page
    IF  '${type}' == 'On'
        Turn on  ${CANDIDATE_RATING_ALERT_TOGGLE}
    ELSE
        Turn off  ${CANDIDATE_RATING_ALERT_TOGGLE}
    END
    Save alert management page

Turn on/off Workflow alerts Toggle
    [Arguments]    ${type}
    Go To Alert Management Page
    IF  '${type}' == 'On'
        Turn On    ${WORKFLOW_ALERT_TOGGLE}
    ELSE
        Turn Off    ${WORKFLOW_ALERT_TOGGLE}
    END
    Save Alert Management Page

Assign locations alert workflow for user
    [Arguments]    ${username}      ${locations}=None
    Go To Alert Management Page
    Navigate To Option In Alert Management    Workflows
    ${is_added} =    Run Keyword And Return Status    Check Element Display On Screen    ${WORKFLOWS_PATTERN_RESULT_USER}     ${username}

    IF  '${is_added}' == 'False'
        Select User     ${username}
    END

    Click At    ${WORKFLOWS_PATTERN_RESULT_USER_LOCATION_ICON}     ${username}
    IF  "${locations}" == "None"
        ${checkboxe_locators} =   Format String    ${WORKFLOWS_PATTERN_LOCATION_CHECKBOX}    ${EMPTY}
        ${count} =  Get Element Count   ${checkboxe_locators}
        FOR     ${index}      IN RANGE      ${count}
            ${index} =  Evaluate    ${index}+1
            Uncheck The Checkbox    ${WORKFLOWS_PATTERN_LOCATION_CHECKBOX_INDEX}      ${index}
        END
    ELSE
        FOR    ${location}    IN    @{locations}
            Check The Checkbox    ${WORKFLOWS_PATTERN_LOCATION_CHECKBOX}      ${location}
        END
    END

    Click At    ${WORKFLOWS_LOCATION_APPLY_BUTTON}
    Save Alert Management Page
