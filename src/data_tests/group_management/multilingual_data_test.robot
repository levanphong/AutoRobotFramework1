*** Settings ***
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test

*** Variables ***
@{default_language_list}    Spanish (es)    Vietnamese (vi)

*** Test Cases ***
Prepare data test for pre-condition of test case
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    @{list_company}=    Create List     ${COMPANY_HIRE_OFF}     ${COMPANY_GEOGRAPHIC_TARGETING}     ${COMPANY_LOCATION_MAPPING_OFF}
    FOR   ${company}  IN  @{list_company}
        Switch To Company V1    ${company}
        Select language option in Multilingual      ${default_language_list}
    END

*** Keywords ***
Select language option in Multilingual
    [Arguments]    ${candidate_language_list}
    Navigate to Option in client setup          Multilingual
    Click At    ${MULTILINGUAL_CANDIDATE_DROPDOWN}
    ${type} =   Evaluate    type($candidate_language_list).__name__
    IF  '${type}' == 'list'
        FOR    ${language_value}    IN    @{candidate_language_list}
            Check language option is chosen         language_value=${language_value}
        END
    ELSE
        Check language option is chosen         language_value=${candidate_language_list}
    END
    Click At    ${MULTILINGUAL_CANDIDATE_DROPDOWN}
    ${is_changed}=      Run Keyword And Return Status    Check Element Display On Screen    ${MULTILINGUAL_SAVE_BUTTON}     wait_time=2s
    Capture Page Screenshot
    IF    ${is_changed}
        Click At    ${MULTILINGUAL_SAVE_BUTTON}
        Check Element Display On Screen     Your changes have been saved.
        Capture Page Screenshot
    END

Check language option is chosen
    [Arguments]          ${language_value}       ${action}=add
    Input Into    ${MULTILINGUAL_CANDIDATE_SEARCH_INPUT_BUTTON}           ${language_value}
    IF  '${action}' == 'add'
        Check The Checkbox    ${MULTILINGUAL_SELECT_LANGUAGE_OPTIONS}     ${language_value}
    ELSE
        Uncheck The Checkbox    ${MULTILINGUAL_SELECT_LANGUAGE_OPTIONS}     ${language_value}
    END
