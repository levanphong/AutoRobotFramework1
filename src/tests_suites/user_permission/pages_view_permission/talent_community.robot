*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/talent_community_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

Documentation        Talent Community: Client Setup > Talent Community > Turn ON `Talent Community` toggle
                #   ...Create a Custom Conversation for Talent Community and Publish
                #   ...Talent Community: Client Setup > Talent Community > Select a Conversation for Talent

*** Variables ***

*** Test Cases ***
Check Company Admin role has full access by default to view, edit and manage on Talent Community when Hire toggle is OFF (OL-T19132)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_HIRE_OFF}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page

Check Company Admin role has full access by default to view, edit and manage on Talent Community when Hire toggle is ON (OL-T19133)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_HIRE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page

Check Edit Everything role has full access by default to view, edit and manage on Talent Community when Franchise Toggle is ON (OL-T19124)
    Given Setup test
    when Login into system with company    Full User - Edit Everything    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Edit Everything role has full access by default to view, edit and manage on Talent Community when Franchise toggle is OFF (OL-T19125)
    Given Setup test
    when Login into system with company    Full User - Edit Everything   ${COMPANY_FRANCHISE_OFF}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Edit Nothing role has full access by default to view, edit and manage on Talent Community when Franchise toggle is ON (OL-T19123)
    Given Setup test
    when Login into system with company    Full User - Edit Nothing    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Edit Nothing role has full access by default to view, edit and manage on Talent Community when Franchise toggle is OFF (OL-T19122)
    Given Setup test
    when Login into system with company    Full User - Edit Nothing   ${COMPANY_FRANCHISE_OFF}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Franchise Owner role has full access by default to view, edit and manage on Talent Community (OL-T19119)
    Given Setup test
    when Login into system with company    Franchise Owner    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Franchise Staff role has full access by default to view, edit and manage on Talent Community (OL-T19118)
    Given Setup test
    when Login into system with company    Franchise Staff    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Hiring Manager role has full access by default to view, edit and manage on Talent Community when Franchise toggle is ON (OL-T19126)
    Given Setup test
    when Login into system with company    Hiring Manager    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Hiring Manager role has full access by default to view, edit and manage on Talent Community when Franchise toggle is OFF (OL-T19127)
    Given Setup test
    when Login into system with company    Hiring Manager   ${COMPANY_FRANCHISE_OFF}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Recruiter role has full access by default to view, edit and manage on Talent Community when Franchise toggle is ON (OL-T19128)
    Given Setup test
    when Login into system with company    Recruiter    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Recruiter role has full access by default to view, edit and manage on Talent Community when Franchise toggle is OFF (OL-T19129)
    Given Setup test
    when Login into system with company    Recruiter   ${COMPANY_FRANCHISE_OFF}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Reporting User role has full access by default to view, edit and manage on Talent Community when Franchise toggle is ON (OL-T19120)
    Given Setup test
    when Login into system with company    Reporting User    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Reporting User role has full access by default to view, edit and manage on Talent Community when Franchise toggle is OFF (OL-T19121)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}   ${COMPANY_FRANCHISE_OFF}
    Switch to user  Reporting Team
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Suppervisor role has full access by default to view, edit and manage on Talent Community when Franchise toggle is ON (OL-T19130)
    Given Setup test
    when Login into system with company    Supervisor    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Suppervisor role has full access by default to view, edit and manage on Talent Community when Franchise toggle is OFF (OL-T19131)
    Given Setup test
    when Login into system with company    Supervisor   ${COMPANY_FRANCHISE_OFF}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page


Check Supper Admin role has full access by default to view, edit and manage on Talent Community (OL-T19134)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON}
    Click at  ${CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY}
    Check user can do action in Talent Community page

*** Keywords ***
Edit Talent Candidate name
    [Arguments]     ${candidate_fname}
    Input into  ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX}  ${candidate_fname}
    Click at  ${candidate_fname}
    Click at  ${TALENT_CANDIDATE_PROFILE_MORE_BUTTON}
    Click at  ${TALENT_CANDIDATE_PROFILE_MORE_MENU_ITEM}  Edit
    ${candidate_first_name_random} =    Generate random name only text    Fname
    Input into    ${TALENT_CANDIDATE_FIRST_NAME_TEXT_BOX}    ${candidate_first_name_random}
    Capture page screenshot
    Click at  ${TALENT_CANDIDATE_ADD_CANDIDATE_BUTTON}
    # Re-input
    ${is_popup_closed} =    Run Keyword And Return Status    Check element not display on screen    Edit Candidate Information    wait_time=2s
    Run Keyword Unless    ${is_popup_closed}    Simulate Input    ${TALENT_CANDIDATE_FIRST_NAME_TEXT_BOX}    ${candidate_first_name_random}
    Run Keyword Unless    ${is_popup_closed}    Click at  ${TALENT_CANDIDATE_ADD_CANDIDATE_BUTTON}
    [Return]    ${candidate_first_name_random}

Check user can do action in Talent Community page
    ${candidate_fname} =    Add a Candidate to Talent Community
    ${new_fname} =      Edit Talent Candidate name  ${candidate_fname.first_name}
    Input into  ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX}  ${new_fname}
    Check element display on screen  ${new_fname}
    Capture page screenshot
