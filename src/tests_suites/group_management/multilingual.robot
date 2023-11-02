*** Settings ***
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test

Documentation       Company Hire Off: Client setup > Hire is OFF
...                 Client setup > Multilingual is ON > Candidate Languages is ON > Select Language (Spanish)
...                 Company Geographic Targeting: Client setup > Hire is ON & Job is OFF
...                 Client setup > Multilingual is ON > Candidate Languages is ON > Select Language (Spanish)

*** Variables ***
@{default_language_list}    English    Spanish (es)    Vietnamese

*** Test Cases ***
Verify if the display of Languages Dropdown in Group Management - In case Hire is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16369)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go To Group Management Page
    Click At    ${NEW_GROUP_BUTTON}
    Check Element Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN}
    Capture Page Screenshot


Verify if the display of Languages Dropdown in Group Management - In case Hire is ON & Job is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16378)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_GEOGRAPHIC_TARGETING}
    Go To Group Management Page
    Click At    ${NEW_GROUP_BUTTON}
    Check Element Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN}
    Capture Page Screenshot


Verify if show Group Name by user language on Group Management page - Hire is ON & Job is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16389, OL-T16380)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_GEOGRAPHIC_TARGETING}
    # Verify if user is able to add Language in Configure Languages - In case Hire is ON & Job is OFF & Multilingual is ON & Candidate Languages is ON
    ${group_name}=      Add A Group
    Click At    ${GROUP_DETAILS_TAB}
    Add/Remove languages of group       Spanish
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Click At    ${GROUP_MULTILINGUAL_CONFIGURE_BUTTON}
    Click At    ${GROUP_MULTILINGUAL_CONFIGURE_CANCEL_BUTTON}
    Check Element Not Display On Screen     Configure Languages     wait_time=1s
    Capture Page Screenshot
    Select Group Language       Spanish
    Set Group Details       Grupo ${group_name}     is_edit=True
    Switch to user old version      ${FULL_USER_SPANISH}
    Check Text Display      Grupo ${group_name}
    Check Text Display      Edite su grupo.
    Capture Page Screenshot
    Switch to user old version      ${TEAM_USER}
    Go To Group Management Page
    Delete A Group      ${group_name}


Verify Languages Dropdown doesn't display in Group Management - In case Hire OFF & Multilingual is OFF (OL-T16367)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EXTERNAL_JOB}
    Go To Group Management Page
    Click At    ${NEW_GROUP_BUTTON}
    Check Element Not Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN}      wait_time=1s
    Capture Page Screenshot


Verify Languages Dropdown doesn't display in Group Management - In case Hire ON & Job OFF & Multilingual is OFF (OL-T16368)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go To Group Management Page
    Click At    ${NEW_GROUP_BUTTON}
    Check Element Not Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN}      wait_time=1s
    Capture Page Screenshot


Verify user can select language other in Languages Dropdown - In case Hire is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16375, OL-T16376, OL-T16371)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    # Verify if user is able to add Language in Configure Languages - In case Hire is OFF & Multilingual is ON & Candidate Languages is ON (T16371)
    ${group_name}=      Add A Group
    Click At    ${GROUP_DETAILS_TAB}
    Check Dropdown Or Configure Language List       @{default_language_list}    check_configure=True
    Add/Remove languages of group       Spanish
    Select Group Language       Spanish
    # Verify user can edit title in group - In case Hire is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16376)
    Set Group Details       Grupo ${group_name}     is_edit=True
    Click At    ${GROUP_DETAILS_TAB}    slow_down=2
    Check Element Not Display On Screen     Grupo ${group_name}     wait_time=1s
    Capture Page Screenshot
    Select Group Language       Spanish
    Check Text Display      Grupo ${group_name}
    Capture Page Screenshot
    Go To Group Management Page
    Delete A Group      ${group_name}


Verify if user is able to remove and add Language in Configure Languages - In case Hire is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16377, OL-T16373)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${group_name}=      Add A Group
    Click At    ${GROUP_DETAILS_TAB}
    Check Dropdown Or Configure Language List       @{default_language_list}    check_configure=True
    Add/Remove languages of group       Spanish     Vietnamese
    Check Dropdown Or Configure Language List       @{default_language_list}
    Add/Remove languages of group       Vietnamese      action=remove
    Check Dropdown Or Configure Language List       Vietnamese      is_display=False
    Go To Group Management Page
    Delete A Group      ${group_name}


Verify user can edit title in group - In case Hire is ON & Candidate Journey is ON & Job is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16385)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_LOCATION_MAPPING_OFF}
    ${group_name}=      Add A Group     Default Candidate Journey
    Click At    ${GROUP_DETAILS_TAB}
    Check Dropdown Or Configure Language List       @{default_language_list}    check_configure=True
    Add/Remove languages of group       Spanish
    Check Dropdown Or Configure Language List       English     Spanish (es)
    Select Group Language       Spanish
    Set Group Details       Grupo ${group_name}     is_edit=True
    Click At    ${GROUP_DETAILS_TAB}    slow_down=2
    Check Element Not Display On Screen     Grupo ${group_name}     wait_time=1s
    Capture Page Screenshot
    Select Group Language       Spanish
    Check Text Display      Grupo ${group_name}
    Go To Group Management Page
    Delete A Group      ${group_name}


Verify if the display of Languages Dropdown in Group Management - In case Hire is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16379, OL-T16370, OL-T16387, OL-T16386)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    ${group_name}=      Add a Group
    # Verify language dropdown is displayed (OL-T16386)
    Click At    ${GROUP_DETAILS_TAB}
    Check Element Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN}
    Capture Page Screenshot
    # Verify all languages are selected in Configure Language (OL-T16386)
    Add/Remove languages of group       Spanish     Vietnamese
    # Verify check box & all available languages on Configure Language (OL-T16386, OL-T16379, OL-T16370)
    Check dropdown or configure language list       @{default_language_list}    check_configure=True
    Check dropdown or configure language list       @{default_language_list}
    # Verify show Group Name by user language (OL-T16387, OL-T16386)
    Check language selected being displayed correctly       Vietnamese
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Check language selected being displayed correctly       Spanish
    Set Group Details       Grupo ${group_name}     is_edit=True
    Check Element Display On Screen     Grupo ${group_name}
    Capture Page Screenshot
    Switch To User old version      ${FULL_USER_SPANISH}
    Check Text Display      Grupo ${group_name}
    Check Element Display On Screen     ${GROUP_MULTILINGUAL_CHOSEN_LANGUAGE_BUTTON}    Español
    Capture Page Screenshot
    Switch To User old version      ${TEAM_USER}
    Go to Group Management page
    Delete a Group      ${group_name}


Verify if the display of the values in Languages Dropdown - In case Hire is ON & Job is OFF & Multilingual is ON & Candidate Languages is ON (OL-T16383, OL-T16374, OL-T16384, OL-T16372, OL-T16381, OL-T16382)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_GEOGRAPHIC_TARGETING}
    ${group_name}=      Add a Group
    # Verify language dropdown is displayed (OL-T16372, OL-T16381, OL-T16382)
    Click At    ${GROUP_DETAILS_TAB}
    Check Element Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN}
    Capture Page Screenshot
    # Verify all languages are selected in Configure Language (OL-T16372, OL-T16381, OL-T16382)
    Add/Remove languages of group       Spanish     is_confirmed=False
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Check Element Not Display On Screen     ${GROUP_MULTILINGUAL_DROPDOWN_LANGUAGE_SELECT}      Spanish     wait_time=1
    Add/Remove languages of group       Spanish     Vietnamese
    # Verify check box & all available languages on Configure Language (OL-T16374, OL-T16383, OL-T16372, OL-T16381)
    Check dropdown or configure language list       @{default_language_list}    check_configure=True
    Check dropdown or configure language list       @{default_language_list}
    # Verify language selected being displayed correctly (OL-T16384, OL-T16382)
    Check language selected being displayed correctly       Vietnamese
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Check language selected being displayed correctly       Spanish
    Set Group Details       Grupo ${group_name}     is_edit=True
    Check Element Display On Screen     Grupo ${group_name}
    Capture Page Screenshot
    Go to Group Management page
    Delete a Group      ${group_name}

*** Keywords ***
Check language selected being displayed correctly
    [Arguments]    ${language}
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN_LANGUAGE_SELECT}     ${language}
    Check Element Display On Screen     ${GROUP_MULTILINGUAL_CHOSEN_LANGUAGE_BUTTON}        ${language}
    Capture Page Screenshot
    Click At    ${GROUP_MULTILINGUAL_DROPDOWN}
    Check Element Display On Screen    ${GROUP_MULTILINGUAL_CHECK_ICON}     ${language}
    Capture Page Screenshot
