*** Settings ***
Documentation     Recorded Interview Builder: Client Setup > Scheduling > Turn ON `Olivia Recorded Interviews` toggle
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/users_roles_permissions_page.robot
Resource            ../../../pages/all_candidates_page.robot
Resource            ../../../pages/round_robin_management_page.robot
Resource            ../../../pages/interview_prep_page.robot
Resource            ../../../pages/recorded_interview_builder_page.robot
Resource            ../../../pages/interviews_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check the Interview page is displayed for user has full access in case user is Company Admin (OL-T17095)
    ${is_redirected} =      Verify go to Interviews page with user role    Company Admin
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Interview page is displayed for user has full access in case user is Full User Edit Nothing (OL-T17096)
    ${is_redirected} =      Verify go to Interviews page with user role    Full User - Edit Nothing
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Interview page is not displayed under Menu in case user is Paradox Admin (OL-T17094)
    Given Setup test
    when Login into system with company    ${ViewOnly}    ${COMPANY_EVENT}
    Verify page not display in Right Menu   Interviews


Check the Interview Prep page is displayed for user has full access in case user is Company Admin (OL-T17099)
    ${is_redirected} =      Verify go to Interview Prep page with user role    Company Admin
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Interview Prep page is not displayed for user has no access in case user is Full User Edit Nothing (OL-T17100)
    Given Setup test
    when Login into system with company    Full User - Edit Nothing    ${COMPANY_EVENT}
    Verify page not display in Right Menu  Interview Prep


Check the Interview Prep page is displayed under Menu in case user is Paradox Admin (OL-T17098)
    ${is_redirected} =      Verify go to Interview Prep page with user role    ${PARADOX_ADMIN}
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Recorded Interview Builder page is displayed for user has full access in case user is Company Admin (OL-T17115)
    ${is_redirected} =      Verify go to Olivia Recorded Interviews with user role    Company Admin
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Recorded Interview Builder page is not displayed for user has no access in case user is Full User Edit Nothing (OL-T17116)
    Given Setup test
    when Login into system with company    Full User - Edit Nothing    ${COMPANY_EVENT}
    Verify page not display in Right Menu  Recorded Interview Builder


Check the Recorded Interview Builder page is displayed under Menu in case user is Paradox Admin (OL-T17114)
    ${is_redirected} =      Verify go to Olivia Recorded Interviews with user role    ${PARADOX_ADMIN}
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Round Robin Manager page is displayed for user has full access in case user is Company Admin (OL-T17107)
    ${is_redirected} =      Verify go to Round Robin Management page with user role    Company Admin
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Check the Round Robin Manager page is displayed for user has view access in case user is Recruiter (OL-T17108)
    Given Setup test
    when Login into system with company    Recruiter   ${COMPANY_FRANCHISE_OFF}
    Verify page display in Right Menu and go to this page  Round Robin Management


Check the Round Robin Manager page is displayed under Menu in case user is Paradox Admin (OL-T17106)
    ${is_redirected} =      Verify go to Round Robin Management page with user role    ${PARADOX_ADMIN}
    Run keyword unless      '${is_redirected}' == 'True'   Fail


Verify Company Admin User has full access to create a Round Robin Manager (OL-T17112)
    Given Setup test
    when Login into system with company    Company Admin   ${COMPANY_EVENT}
    ${round_robin_name} =   Add a new Round Robin
    Capture page screenshot
    Delete a Round Robin    ${round_robin_name}


Verify Company Admin User has full access to create an interview prep (OL-T17103)
    Given Setup test
    when Login into system with company    Company Admin   ${COMPANY_EVENT}
    go to Interview Prep page
    ${interview_prep_name} =    Add a new Interview Prep    Candidates
    Capture page screenshot
    Delete an Interview Prep    ${interview_prep_name}


Verify Company Admin User has full access to view all interviews prep (OL-T17102)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_EVENT}
    go to Interview Prep page
    ${interview_prep_name} =    Add a new Interview Prep    Candidates
    go to Interview Prep page
    Switch to user  CA Team
    Input into  ${INTERVIEW_PREP_PAGE_SEARCH_TEXT_BOX}  ${interview_prep_name}
    Check element display on screen  ${interview_prep_name}
    Capture page screenshot
    Delete an Interview Prep    ${interview_prep_name}


Verify Company Admin User has full access to view all Round Robin (OL-T17110)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_EVENT}
    ${round_robin_name} =   Add a new Round Robin
    Switch to user old version  CA Team
    Check element display on screen  ${round_robin_name}
    Capture page screenshot
    Delete a Round Robin    ${round_robin_name}


Verify Full User Edit Everything has full access to delete an interview prep (OL-T17105)
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_EVENT}
    go to Interview Prep page
    ${interview_prep_name} =    Add a new Interview Prep    Candidates
    Delete an Interview Prep    ${interview_prep_name}
    Capture page screenshot


Verify Full User Edit Everything has full access to edit a Round Robin Manager (OL-T17113)
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_FRANCHISE_OFF}
    ${round_robin_name} =   Add a new Round Robin
    # Edit created Round Robin
    Click at  ${round_robin_name}
    ${new_round_robin_name} =   Generate random name  auto_round_robin
    Input into  ${EDIT_ROUND_ROBIN_FORM_ROUND_ROBIN_NAME_TEXT_BOX}  ${new_round_robin_name}
    Click at    ${SAVE_RR_BUTTON}
    Check element display on screen  ${new_round_robin_name}
    Capture page screenshot
    Delete a Round Robin    ${new_round_robin_name}


Verify Full User Edit Everything has full access to edit an interview prep (OL-T17104)
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_EVENT}
    go to Interview Prep page
    ${interview_prep_name} =    Add a new Interview Prep    Candidates
    # Edit created Interview Prep
    go to Interview Prep page
    Input into  ${INTERVIEW_PREP_PAGE_SEARCH_TEXT_BOX}  ${interview_prep_name}
    ${new_interview_prep_name} =    User can edit interview prep
    Capture page screenshot
    Delete an Interview Prep    ${new_interview_prep_name}


Verify Full User Edit Nothing (Franchse OFF) has view access to view all Round Robin (OL-T17111)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_FRANCHISE_OFF}
    ${round_robin_name} =   Add a new Round Robin
    Switch to user old version  EN Team
    Check element display on screen  ${round_robin_name}
    Capture page screenshot
    Switch to user old version  ${TEAM_USER}
    Delete a Round Robin    ${round_robin_name}


Verify Paradox Admin User has full access to view all interviews prep (OL-T17101)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_EVENT}
    Switch to user  CA Team
    ${round_robin_name} =   Add a new Round Robin
    Switch to user old version  ${TEAM_USER}
    Check element display on screen  ${round_robin_name}
    Capture page screenshot
    Delete a Round Robin    ${round_robin_name}


Verify Paradox Admin User has full access to view all Round Robin (OL-T17109)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_EVENT}
    Switch to user  CA Team
    ${round_robin_name} =   Add a new Round Robin
    Switch to user old version  ${TEAM_USER}
    Check element display on screen  ${round_robin_name}
    Capture page screenshot
    Delete a Round Robin    ${round_robin_name}


Check the Recorded Interview Builder page is not displayed for user is Full User Edit Everything (Franchise ON) (OL-T20171)
    [Tags]  skip
    # Achieved testcase
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_EVENT}
    Verify page not display in Right Menu   Recorded Interview Builder


Check the Round Robin Management page is not displayed for user is Full User Edit Everything (Franchise ON) (OL-T20172)
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_FRANCHISE_ON}
    Verify page not display in Right Menu   Round Robin Management


Check the Round Robin Management page is not displayed for user is Recruiter (Franchise ON) (OL-T20173)
    Given Setup test
    when Login into system with company    Recruiter   ${COMPANY_FRANCHISE_ON}
    Verify page not display in Right Menu   Round Robin Management


Verify Company Admin User has full access to create an Recorded Interview Builder (OL-T17119)
    Given Setup test
    when Login into system with company    Company Admin   ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_name} =   Create a new Recorded Interview
    Capture page screenshot
    Delete a Recorded Interview    ${interview_name}


Verify Company Admin User has full access to view all Recorded interviews (OL-T17118)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    ${interview_name} =   Create a new Recorded Interview
    Switch to user  CA Team
    Input into  ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}  ${interview_name}
    Check element display on screen  ${interview_name}
    Capture page screenshot
    Delete a Recorded Interview    ${interview_name}


Verify Full User Edit Everything (Franchise OFF) has full access to edit an Recorded Interview Builder (OL-T17120, OL-T17121)
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_FRANCHISE_OFF}
    Go to Recorded Interview Builder Interviews page
    ${interview_name} =   Create a new Recorded Interview
    # Edit created Recorded Interview
    Input into  ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}  ${interview_name}
    Click at  ${interview_name}
    ${new_interview_name} =     Generate random name  auto_interview
    Input into  ${NEW_RECORDED_INTERVIEW_NAME_TEXT_BOX}     ${new_interview_name}
    Click at  ${NEW_RECORDED_INTERVIEW_SAVE_BUTTON}
    # Verify new interview name saved
    Input into  ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}  ${new_interview_name}
    Check element display on screen  ${new_interview_name}
    Capture page screenshot
    Delete a Recorded Interview    ${new_interview_name}


Verify Paradox Admin User has full access to view all Recorded interviews (OL-T17117)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_EVENT}
    Go to Recorded Interview Builder Interviews page
    Switch to user  CA Team
    ${interview_name} =   Create a new Recorded Interview
    Switch to user  ${TEAM_USER}
    Input into  ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}  ${interview_name}
    Check element display on screen  ${interview_name}
    Capture page screenshot
    Delete a Recorded Interview    ${interview_name}


Verify Company Admin User has full access to view all interviews that are assigned to that user (OL-T17097)
    Given Setup test
    when Login into system with company    Company Admin   ${COMPANY_EVENT}
    # Create a Candidate and Invite to an Interview 
    ${candidate_name} =   Add a Candidate
    Change conversation status  ${candidate_name}  Scheduling  Invite to Interview
    Click at  ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    Capture page screenshot
    # Choose schedule type
    Check schedule type exist   Interview
    # Click Continue in case popup appear
    Run keyword and ignore error    Click at  Continue Scheduling   wait_time=2s
    # Add Company User as Interviewer
    Click at  ${INTERVIEWER_BUTTON}
    Capture page screenshot
    Input into  ${SCHEDULE_AN_INTERVIEW_ATTENDEES}  CA Team
    Capture page screenshot
    Click at    ${ATTENDEES_NAME}    CA Team
    Capture page screenshot
    Click at    ${SCHEDULE_AN_INTERVIEW_APPLY_BTN}
    Capture page screenshot
    Click at    ${FIND_TIMES_BUTTON}
    # Verify Company Admin has a new Interview
    Go to Interviews page
    Click at  ${INTERVIEWS_PAGE_LEFT_NAV_TEXT}  All Interviews
    Simulate Input  ${INTERVIEWS_PAGE_SEARCH_INTERVIEW_TEXT_BOX}  ${candidate_name}
    Check element display on screen  ${candidate_name}
    Capture page screenshot

*** Keywords ***
Verify go to Interviews page with user role
    [Arguments]     ${user_role}
    Given Setup test
    when Login into system with company    ${user_role}    ${COMPANY_EVENT}
    Verify page display in Right Menu and go to this page   Interviews
    Capture page screenshot
    ${current_event_url} =    Get location
    ${is_redirected} =      Run keyword and return status   Should Contain    ${current_event_url}    /interviews
    [Return]    ${is_redirected}

Verify go to Olivia Recorded Interviews with user role
    [Arguments]     ${user_role}
    Given Setup test
    when Login into system with company    ${user_role}    ${COMPANY_EVENT}
    Verify page display in Right Menu and go to this page   Recorded Interview Builder
    Capture page screenshot
    ${current_event_url} =    Get location
    ${is_redirected} =      Run keyword and return status   Should Contain    ${current_event_url}    /interview-builder
    [Return]    ${is_redirected}

Verify go to Interview Prep page with user role
    [Arguments]     ${user_role}
    Given Setup test
    when Login into system with company    ${user_role}    ${COMPANY_EVENT}
    Verify page display in Right Menu and go to this page   Interview Prep
    Capture page screenshot
    ${current_event_url} =    Get location
    ${is_redirected} =      Run keyword and return status   Should Contain    ${current_event_url}    /interview-preps
    [Return]    ${is_redirected}

Verify go to Round Robin Management page with user role
    [Arguments]     ${user_role}
    Given Setup test
    when Login into system with company    ${user_role}    ${COMPANY_EVENT}
    Verify page display in Right Menu and go to this page   Round Robin Management
    Capture page screenshot
    ${current_event_url} =    Get location
    ${is_redirected} =      Run keyword and return status   Should Contain    ${current_event_url}    /round-robin-management
    [Return]    ${is_redirected}

Verify page not display in Right Menu
    [Arguments]     ${page_name}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    IF  '${page_name}' == 'Interviews'
        Check element not display on screen  ${CEM_PAGE_RIGHT_MENU_INTERVIEWS}
    ELSE
        Click at  ${CEM_PAGE_RIGHT_MENU_SETTING_ICON}
        Check element not display on screen  ${CEM_PAGE_RIGHT_MENU_ITEM}  ${page_name}
    END
    Capture page screenshot

Verify page display in Right Menu and go to this page
    [Arguments]     ${page_name}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    IF  '${page_name}' == 'Interviews'
        Check element display on screen  ${CEM_PAGE_RIGHT_MENU_INTERVIEWS}
        Click at  ${CEM_PAGE_RIGHT_MENU_INTERVIEWS}
        Check element display on screen  ${INTERVIEWS_PAGE_SEARCH_INTERVIEW_TEXT_BOX}
    ELSE
        Click at  ${CEM_PAGE_RIGHT_MENU_SETTING_ICON}
        Check element display on screen  ${CEM_PAGE_RIGHT_MENU_ITEM}  ${page_name}
        Capture page screenshot
        Click at  ${CEM_PAGE_RIGHT_MENU_ITEM}  ${page_name}
    END
    Wait with short time    # Need to wait for a short time to get the page link correctly.
