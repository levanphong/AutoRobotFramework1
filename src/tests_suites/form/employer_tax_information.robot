*** Settings ***
Resource    ../../pages/forms_page.robot
Resource    ../../pages/employer_tax_information_page.robot
Resource    ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Check if Employer Tax Information is visible on Menu when Tax Withholding toggle is ON (OL-T3553, OL-T3554, OL-T3555)
	Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Click setting icon on menu
    Check element display on screen     Employer Tax Information
    Go to employer tax information
    Capture page screenshot
    # Check if Company Admins, Franchise Owners, Franchise Staffs are able to access [Employer Tax Information] page (OL-T3554)
    Check user can access Employer Tax Information      ${CA_TEAM}
    Check user can access Employer Tax Information      ${FO_TEAM}
    Check user can access Employer Tax Information      ${FS_TEAM}
    # Check if other user roles are not able to access [Employer Tax Information] page (OL-T3555)
    Check user can not access Employer Tax Information      ${EE_TEAM}
    Check user can not access Employer Tax Information      ${EN_TEAM}
    Check user can not access Employer Tax Information      ${RC_TEAM}
    Check user can not access Employer Tax Information      ${SV_TEAM}
    Check user can not access Employer Tax Information      ${HM_TEAM}


Check if user is able to click on Add New an Employer (OL-T3966, OL-T3967, OL-T3972)
    Given Setup test
	when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
	Go to employer tax information
	Click at        Add New Employer
	Check Add new employer modal displayed
	# Check if user is able to create Employer without selecting location (OL-T3967)
    ${employer_name}=       Input valid information for Employer Information tab
    Click at        ${ADD_EMPLOYER_MODAL_SAVE_BUTTON}
    Check element display on screen     ${employer_name}
    Check span display      Unpublished Changes
    Capture page screenshot
    # Check if user is not able to publish Employer Tax Information in case at least one location is not assigned (OL-T3972)
    Click at        ${EMPLOYER_TAX_INFO_PUBLISH_BUTTON}
    Check Cannot Publish modal is displayed
    Delete employer tax information     ${employer_name}

*** Keywords ***
Check user can access Employer Tax Information
    [Arguments]     ${user}
    Go to CEM page
    Switch to user    ${user}
    Click setting icon on menu
    Check element display on screen     Employer Tax Information
    Go to employer tax information
    Capture page screenshot

Check user can not access Employer Tax Information
    [Arguments]     ${user}
    Go to CEM page
    Switch to user     ${user}
    Click setting icon on menu
    Check element not display on screen     Employer Tax Information    wait_time=2s
    Capture page screenshot

Check Add new employer modal displayed
    Check element display on screen     Employer Information
    Check element display on screen     Assigned Location
    Check element display on screen     ${EMPLOYER_TAX_INFO_EMPLOYER_NAME_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_FULL_NAME_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_PHONE_NUMBER_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_FEI_NUMBER_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_STATE_TAX_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_STREET_ADDRESS_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_SUITE_ROOM_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_CITY_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_ZIPCODE_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_STATE_DROPDOWN}
    Check element display on screen     ${ADD_EMPLOYER_MODAL_CANCEL_BUTTON}
    Check element display on screen     ${ADD_EMPLOYER_MODAL_SAVE_BUTTON}
    Capture page screenshot
    Click at        Assigned Location
    Check element display on screen     ${EMPLOYER_TAX_INFO_SEARCH_LOCATION_TEXTBOX}
    Check element display on screen     ${EMPLOYER_TAX_INFO_ADD_LOCATION_BUTTON}
    Check element display on screen     ${ADD_EMPLOYER_MODAL_CANCEL_BUTTON}
    Check element display on screen     ${ADD_EMPLOYER_MODAL_SAVE_BUTTON}
    Capture page screenshot

Check Cannot Publish modal is displayed
    Check element display on screen     Cannot Publish
    Check element display on screen     Employer Tax Information cannot be published.
    Check element display on screen     unassigned location(s).
    Capture page screenshot
    Click at    ${EMPLOYER_TAX_INFO_CLOSE_MODAL_ICON}
    Check span display      Unpublished Changes
    Capture page screenshot
