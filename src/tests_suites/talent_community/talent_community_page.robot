*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/talent_community_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

*** Variables ***
@{left_panel_titles}    All Candidates    Action Needed    Incomplete

*** Test Cases ***
Talent Community - Check UI When click on Talent Community page (OL-T11125, OL-T11127)
    Given Setup test
    When Login Into System With Company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    # Check the [Talent Community] section is visible in case Talent Community is ON (OL-T11125)
    Click At   ${LEFT_MENU_BUTTON}
    Check Element Display On Screen    ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check Element Display On Screen    ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY_LABEL}
    Capture page screenshot
    # Check UI When click on Talent Community page (OL-T11127)
    then Go to Talent Community page
    Verify Element Display on Left Panel            ${left_panel_titles}
    Capture page screenshot
    @{table_columns}=   Create List     Name    Group    Location    Journey Status    Interview Date    Last Active    First Engaged
    Verify Element Display on Right Panel           @{table_columns}
    Capture page screenshot

Check the Talent Community section is not visible in case Talent Community is OFF (OL-T11126)
    Given Setup test
    When Login Into System With Company    ${PARADOX_ADMIN}    ${COMPANY_EXTERNAL_JOB}
    Click at    ${LEFT_MENU_BUTTON}
    Check Element Not Display On Screen             ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check Element Not Display On Screen             ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY_LABEL}
    Capture page screenshot

Check UI for All Candidates when HIRE, Candidate Journey and Job are OFF and NO data (OL-T11129)
    Given Setup test
    Login into system with company                 ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch To User      ${EN_TEAM}
    when Go to Talent Community page
    @{column_value}=    Create List      Name    Group  Location    Journey Status    Last Active    Interview Date    First Engaged
    Check UI for All Candidates talent community is display   @{column_value}
    Capture page screenshot

Check UI for All Candidates when HIRE is ON, Candidate Journey and Job are OFF and NO data (OL-T11129)
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_GEOGRAPHIC_TARGETING}
    Switch To User      ${EN_TEAM}
    Go to Talent Community page
    @{column_value}=    Create List      Name    Group  Location    Journey Status    Last Active    Interview Date    First Engaged
    Check UI for All Candidates talent community is display   @{column_value}
    Capture page screenshot

Check UI for All Candidates when Candidate Journey ON and Job OFF and NO data (OL-T11130)
    Given setup test
    When Login into system with company   ${PARADOX_ADMIN}      ${COMPANY_APPLICANT_FLOW}
    Switch To User      ${EN_TEAM}
    when Go to Talent Community page
    @{column_value}=    Create List    Name  Group  Location    Journey Status    Journey Status  Interview Date    Last Active  First Engaged
    Check UI for All Candidates talent community is display   @{column_value}
    Capture page screenshot

Check UI for All Candidates when Candidate Journey OFF and Job ON and NO data (OL-T11131)
    Given Setup test
    when Login Into System With Company    ${PARADOX_ADMIN}   ${COMPANY_NEW_ROLE}
    Switch To User    ${EN_TEAM}
    when Go to Talent Community page
    @{column_value}=    Create List    Name   Location   Interview Date  Last Active     First Engaged
    Check UI for All Candidates talent community is display   @{column_value}
    Capture page screenshot

Talent Community - Check UI for All Candidates when Hire Candidate Journey and Job are OFF and has data and Search incase input candidate name (OL-T11133, OL-T11134)
    Given Setup test
    Login into system with company                 ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Switch To User  CA Team
    when Go to Talent Community page
    # Check UI for All Candidates when Hire Candidate Journey and Job are OFF and has data (OL-T11133)
    @{column_value}=    Create List      Name    Group  Location    Journey Status    Last Active    Interview Date    First Engaged
    Check UI for All Candidates talent community is display when has data   @{column_value}
    Capture page screenshot
    # Check if user is able to Search incase input candidate name (OL-T11134)
    ${candidate_name} =     Add a Candidate to Talent Community
    Simulate Input    ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX}         ${candidate_name.first_name}
    wait for page load successfully
    Check span display      ${candidate_name.first_name}
    Capture page screenshot

Check UI for All Candidates when HIRE is ON, Candidate Journey and Job are OFF and has data (OL-T11133)
    Given Setup test
    Login into system with company                  ${PARADOX_ADMIN}        ${COMPANY_GEOGRAPHIC_TARGETING}
    when Go to Talent Community page
    @{column_value}=    Create List      Name    Group  Location    Journey Status    Last Active    Interview Date    First Engaged
    Check UI for All Candidates talent community is display when has data   @{column_value}
    Capture page screenshot

Talent Community - Check if user is able click on a candidate and Check if user load data (OL-T11139, OL-T11151, OL-T11152, OL-T11153, OL-T11154, OL-T11155)
    Given Setup test
    When Login Into System With Company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    when Go to Talent Community page
    # Check if user is able clicks on a candidate and Check if user load data - All Candidates (OL-T11139)
    Click at    All Candidates
    Check show slide out Candidate Profile
    Click at    ${TALENT_COMMUNITY_PAGE_ICON_REMOVE}
    Check load data successfully when scroll down
    # Check if user is able click on a candidate and Check if user load data - Action Needed (OL-T11151)
    Click at    Action Needed
    wait for page load successfully
    Check show slide out Candidate Profile
    Click at    ${TALENT_COMMUNITY_PAGE_ICON_REMOVE}
    Check load data successfully when scroll down
    # Check if user is able clicks on a candidate and Check if user load data - Incomplete (OL-T11152)
    Click at    Incomplete
    wait for page load successfully
    Check show slide out Candidate Profile
    Click at    ${TALENT_COMMUNITY_PAGE_ICON_REMOVE}
    Check load data successfully when scroll down

