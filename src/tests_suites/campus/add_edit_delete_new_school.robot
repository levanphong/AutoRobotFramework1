*** Settings ***
Resource            ../../pages/school_management_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/forms_page.robot
Resource            ../../pages/approvals_builder_page.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regresstion    test

Documentation       TC1: Turn on toggle "Campus"
...                 TC2: Turn on toggle "Campus"
...                 In "Approvals Builder", create approval flow builder
...                 OL-T29915: Approval flow data test named: Approval for school
...                 OL-T5082:    Event Planning Approval toggle is turned OFF
...                 OL-T5084:    Event Planning Approval toggle is turned ON

*** Test Cases ***
Verify creating areas successfully (OL-T29912)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${area_name}=       Create a new area
    Check element display on screen     ${area_name}
    Check element display on screen     ${ADD_NEW_AN_AREA_REMOVE_BUTTON}
    Capture page screenshot
    Delete an area      ${area_name}


Verify edit area successfully (OL-T29919)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${area_name} =      Create a new area       area_user_name=${BS_TEAM}
    ${area_name_changed} =      Edit an area    ${area_name}
    Check element display on screen     ${area_name_changed}
    Check element display on screen     ${ADD_NEW_AN_AREA_REMOVE_BUTTON}
    Capture page screenshot
    Delete an area      ${area_name_changed}


Verify remove user from area (OL-T29918)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to school management page
    Click at    ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at    ${SCHOOL_MANAGEMENT_ADD_AN_AREA_BUTTON}
    ${area_name} =      Generate random name only text      auto_area_name
    Input into      ${ADD_NEW_AN_AREA_NAME_TEXTBOX}     ${area_name}
    Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
    Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_USER}     ${BS_TEAM}
    Check element display on screen     ${ADD_NEW_AN_AREA_USER_TAG}     ${BS_TEAM}
    Click at    ${ADD_NEW_AN_AREA_REMOVE_USER_BUTTON}       ${BS_TEAM}
    Check element not display on screen     ${ADD_NEW_AN_AREA_USER_TAG}     ${BS_TEAM}
    Capture page screenshot


Verify user can delete area (OL-T29921)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${area_name} =      Create a new area
    Delete an area      ${area_name}
    Check element not display on screen     ${SCHOOL_MANAGEMENT_AREA_NAME_LABEL}    ${area_name}
    Capture page screenshot


Verify UI when user creating area and school (OL-T29911)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to school management page
    Open the creating area form
    Element should be enabled       ${ADD_NEW_AN_AREA_NAME_TEXTBOX}
    Click at    ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
    Check element display on screen     ${ADD_NEW_AN_AREA_ENTER_A_NAME_TO_ADD_TEXTBOX}
    Capture page screenshot
    Reload Page
    Open the creating school form
    Check UI for creating school form


Verify edit school successfully (OL-T29920)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${school_name} =    Create a new school
    ${school_name_changed} =    Edit a school       ${school_name}
    Check element display on screen     ${school_name_changed}
    Check element display on screen     ${ADD_NEW_AN_AREA_REMOVE_BUTTON}
    Capture page screenshot
    Delete a school     ${school_name_changed}


Verify creating custom schools successfully (OL-T29914)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to school management page
    Go to add school form
    Click at    ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    check element display on screen     This field is required
    Verify element color    ${ADD_NEW_SCHOOL_WARNING_MESSAGE}       rgba(232,75,75,0.9)     color
    ${school_name}=     Fill in the school information
    check element display on screen     ${school_name}
    Check element exist on page     ${ADD_NEW_SCHOOL_DELETE_SCHOOL_BUTTON}
    capture page screenshot
    Delete a school     ${school_name}


Verify creating custom school successfully in case 'Event Planing Approval' toggle is on (OL-T29915)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go To Approvals Builder Page
    ${approval_name}=       Add approval flow       ${EE_TEAM}
    Go to school management page
    Go to add school form
    Upload logo for the school
    ${school_name}=     Fill in the school information
    check element display on screen     ${school_name}
    Select approval flow    ${approval_name}
    Check element exist on page     ${ADD_NEW_SCHOOL_DELETE_SCHOOL_BUTTON}
    capture page screenshot
    Delete a school     ${school_name}
    Open new tab same browser
    @{window} =     get window handles
    Switch window       ${window}[1]
    Go To Approvals Builder Page
    Delete Approval Flow    ${approval_name}


Verify user can delete school (OL-T29922)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${school_name}=     Create a new school     Add a School
    Delete a school     ${school_name}


Verify user can search for school successfully (OL-T29923)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to school management page
    ${school_name}=     Create a new school     Add a School
    Search a school     ${school_name}
    Delete a school     ${school_name}


Verify removing user from school (OL-T29917)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to school management page
    Open the creating school form
    ${school_name} =    Generate random name only text      auto_area_shcool
    Input into      ${ADD_NEW_SCHOOL_NAME_TEXTBOX}      ${school_name}
    Click at    ${ADD_NEW_SCHOOL_USERS_TEXTBOX}
    Click at    ${ADD_NEW_SCHOOL_USER_SUGGESTION_NAME}      ${BS_TEAM}
    Check element display on screen     ${ADD_NEW_SCHOOL_USER_TAG}      ${BS_TEAM}
    Click at    ${ADD_NEW_SCHOOL_REMOVE_USER_BUTTON}    ${BS_TEAM}
    Check element not display on screen     ${ADD_NEW_SCHOOL_USER_TAG}      ${BS_TEAM}      wait_time=5s
    Capture page screenshot


Verify School Management only shows if Campus toggle is ON (OL-T29924)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_COMMON}
#    Check campus toggle ON, Turn it OFF, and vice versa
    Check if campus is enable and School Managment tab show or not
#    Check campus toggle OFF, Turn it ON, and vice versa
    Check if campus is enable and School Managment tab show or not


Verify user delete a school that is used for an event campus (OL-T29925)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${school_name}=     Create a new school     Add a School
    Go to Events page
    ${team_members}=    Create List     ${FULL_USER_AUTOMATION}
    ${event_campus_name}=       Create campus active event      @{team_members}     school_name=${school_name}
    Go to school management page
    Input into      ${SCHOOL_MANAGEMENT_SEARCH_FOR_A_SCHOOL_TEXTBOX}    ${school_name}
    Check element display on screen     ${SCHOOL_MANAGEMENT_SCHOOL_NAME_LABEL}      ${school_name}
    Click by JS     ${SCHOOL_MANAGEMENT_SCHOOL_NAME_LABEL}      ${school_name}
    Click at    ${SEARCH_SCHOOL_DELETE_SCHOOL_BUTTON}
    Click at    ${ADD_NEW_SCHOOL_YES_BUTTON}
    Check element display on screen     This school is being used by other events or activities. Could not delete it.
    Capture page screenshot
    Go to Events page
    Input into      ${SEARCHING_INPUT}      ${event_campus_name}
    Check element display on screen     ${event_campus_name}
    wait for page load successfully
    Click on ellipses icon on the Event Occurrence row
    Click at    ${UPCOMING_MENU_DELETE_ACTIVITY}
    Click at    ${DELETE_ACTIVITY_POPUP}
    Check element display on screen     There are no events that match your search criteria.
    Capture page screenshot
    Delete a school     ${school_name}

*** Keywords ***
Open the creating area form
    Hover at                ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at                ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at                ${SCHOOL_MANAGEMENT_ADD_AN_AREA_BUTTON}

Open the creating school form
    Hover at                ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at                ${SCHOOL_MANAGEMENT_ADD_NEW_ICON}
    Click at                ${SCHOOL_MANAGEMENT_ADD_A_SCHOOL_BUTTON}        Add a School
    Click at                ${SCHOOL_MANAGEMENT_FIND_A_SCHOOL_TEXTBOX}
    Check element display on screen                 ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}
    Click at                ${SCHOOL_MANAGEMENT_ADD_CUSTOM_SCHOOL_LOCATOR}

Check UI for creating school form
    Check element display on screen                 ${ADD_NEW_SCHOOL_ADD_LOGO_UPLOAD}
    Check label display     School name
    Element should be enabled                       ${ADD_NEW_SCHOOL_NAME_TEXTBOX}
    Check label display     School acronym
    Check label display     School mascot
    Check element display on screen                 ${ADD_NEW_SCHOOL_ACRONYM_INPUT}
    Check element display on screen                 ${ADD_NEW_SCHOOL_MASCOT_INPUT}
    Check element display on screen                 ${ADD_NEW_SCHOOL_CAMPUS_ADDRESS_DROPDOWN}
    Check element display on screen                 ${ADD_NEW_SCHOOL_STATE_DROPDOWN}
    Check element display on screen                 ${ADD_NEW_SCHOOL_USERS_TEXTBOX}
    Check element display on screen                 ${EVENT_PLANING_APPROVAL_TOGGLE}
    Check element display on screen                 ${ADD_NEW_SCHOOL_SAVE_BUTTON}
    Capture page screenshot

Check if campus is enable and School Managment tab show or not
    Navigate to Option in client setup      Campus
    ${campus_status}=       Get toggle status       ${CLIENT_SETUP_CAMPUS_TOGGLE_ON_OFF}
    Turn on/off campus toggle and go to settings
    IF      ${campus_status}
        Check element not display on screen     School Management   wait_time=5s
    ELSE
        Check element display on screen         School Management
    END
    Capture page screenshot

Turn on/off campus toggle and go to settings
    Click at    ${CLIENT_SETUP_CAMPUS_TOGGLE_ON_OFF}
    Click at    ${CLIENT_SETUP_CAMPUS_SAVE_BUTTON}
    Reload page
    Click at    ${CLIENT_SETUP_MENU_SPAN}
    Click at    ${CLIENT_SETUP_SETTING_ICON}
