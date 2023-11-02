*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          test

*** Variables ***
@{candidate_profile_options}    Edit    Attributes    Lookup    Mark Unread    Print    Unsubscribe    Share    Send Rating
...                             Watch    Spam    Like    Archive    Screen

*** Test Cases ***
Candidate More_Verify user CAN uncheck the items in Candidate Profile dropdown incase Hire is ON (OL-T30080, OL-T30081, OL-T30083, OL-T30084, OL-T30086, OL-T30087)
    Setup to login into system and go to Client setup More tag      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Revert to default config on More tag for Candidate Profile Option
    Check Element Display On Screen     Candidate Profile Options
    @{list_items_disabled} =    Create List     Like    Archive
    # OL-T30080, OL-T30081
    Check the items displayed or disabled in Candidate Profile dropdown in Client setup     ${candidate_profile_options}    ${list_items_disabled}
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Select all
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON}
    Click At    ${CLIENT_SETUP_SAVE_BUTTON}
    Check Element Display On Screen     Your changes have been saved.
    Revert to default config on More tag for Candidate Profile Option
    # OL-T30083
    # OL-T30084 (Verify display all the selected items but excluding not selected items (Ex: Attribute,..))
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN}
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Edit
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Attributes
    Check The Checkbox      ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Edit
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON}
    Click At    ${CLIENT_SETUP_SAVE_BUTTON}
    Check user can view the item of Candidate More option on CEM page   ${EE_TEAM}  Edit    Attributes
    Switch To User    ${TEAM_USER}
    Revert To Default Config On More Tag For Candidate Profile Option
    # OL-T30086, OL-T30087
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN}
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Select all
    Check The Checkbox      ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Send Rating
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON}
    Click At    ${CLIENT_SETUP_SAVE_BUTTON}
    Check user can view the item of Candidate More option on CEM page   ${EE_TEAM}  Send Rating     Watch
    Switch To User    ${TEAM_USER}
    Revert To Default Config On More Tag For Candidate Profile Option


Candidate More_Verify display of the items in Candidate Profile dropdown in case Hire ON & Rating is OFF or Watcher Mode is OFF or Outbound is OFF (OL-T30082)
    Setup to login into system and go to Client setup More tag      ${PARADOX_ADMIN}    ${COMPANY_NEW_ROLE}
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN}
    @{list_items_disabled} =    Create List     Send Rating     Watch       Like    Archive     Screen
    Check the items displayed or disabled in Candidate Profile dropdown in Client setup     ${candidate_profile_options}    ${list_items_disabled}
    Capture Page Screenshot


Candidate More_Verify the display items in the More section when user has role excluding Company Admin/Franchise Staff/Franchise Owner in case Hire ON & Rating is OFF or Watcher Mode is OFF or Outbound is OFF (OL-T30085)
    Given Setup Test
    Login Into System With Company      ${EDIT_EVERYTHING}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Click At    ${MORE_BUTTON}
    @{list_items_selected} =    Create List     Edit    Attributes      Lookup      Print       Unsubscribe     Spam    Share
    @{list_items_not_displayed} =       Create List     Send Rating     Watch       Screen
    Check the items displayed or not in Candidate Option on CEM page    ${list_items_selected}      ${list_items_not_displayed}
    Capture Page Screenshot


# Company: Hire Off
# Capture > On Outbound
# More > On Watcher mode
Candidate More_Verify user CAN select the items in Candidate Profile dropdown incase Hire is OFF (OL-T30094, Ol-T30095, OL-T30096, OL-T30098, OL-T30099, OL-T30101, OL-T30102)
    Setup To Login Into System And Go To Client Setup More Tag    ${PARADOX_ADMIN}      ${COMPANY_HIRE_OFF}
    Revert to default config on More tag for Candidate Profile Option
    Check Element Display On Screen    Candidate Profile Options
    # OL-T30096 - displaying the list includes all items of Candidate Profile Options
    Check the items displayed or disabled in Candidate Profile dropdown in Client setup     ${candidate_profile_options}
    # OL-T30095 - user can uncheck the item
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Edit
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Print
    # OL-T30094 - user can check the item
    Check The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}       Edit
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON}
    Click At    ${CLIENT_SETUP_SAVE_BUTTON}
    Check Element Display On Screen    Your changes have been saved.
    # OL-T30098, OL-T30099 - user can see the item selectec or not selected (from client setup more) on CEM page (except select items: Send Rating or Watch or Screen)
    Check user can view the item of Candidate More option on CEM page   ${EE_TEAM}  Edit    Print
    Switch To User    ${TEAM_USER}
    Revert To Default Config On More Tag For Candidate Profile Option
    # OL-T300101, OL-T300102 - user can see the item selectecd or not selected such as: Send Rating or Watch (from client setup more) on CEM page
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN}
    Uncheck The Checkbox    ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Select all
    Check The Checkbox      ${CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT}     Send Rating
    Click At    ${CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON}
    Click At    ${CLIENT_SETUP_SAVE_BUTTON}
    Check user can view the item of Candidate More option on CEM page   ${EE_TEAM}  Send Rating     Watch
    Switch To User    ${TEAM_USER}
    Revert To Default Config On More Tag For Candidate Profile Option


*** Keywords ***
Setup to login into system and go to Client setup More tag
    [Arguments]    ${company_role}      ${company_name}
    Given Setup Test
    When Login Into System With Company    ${company_role}     ${company_name}
    Navigate To Option In Client Setup    More
    Wait For Page Load Successfully V1

Check user can view the item of Candidate More option on CEM page
    [Arguments]    ${user_role}     ${option}   ${option_not_displayed}=None
    Go To CEM Page
    Switch To User    ${user_role}
    Click At    ${MORE_BUTTON}
    Check Element Display On Screen     ${CEM_MORE_OPTION_ITEMS}    ${option}
    IF    '${option_not_displayed}' != 'None'
        Check Element Not Display On Screen    ${option_not_displayed}
    END
