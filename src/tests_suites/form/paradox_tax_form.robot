*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regresstion    stg

*** Variables ***
@{provider_system}              2020 PDF’s    Paradox Dynamic Forms
${federal_tax_form}             Federal tax forms
${tax_withholding}              Tax Withholding
${personal_information}         Personal Information
${state_tax_form}               State tax forms
&{federal_form_tax_detail}      first_name=John    last_name=Smith    security_number=98-7654321    address=460 Nguyen Huu Tho    city_state_zip_code=DN VN 550000    marial_status=Head of household    extra_holding=1200    date=2020/01/01
${location_in_state}            California

*** Test Cases ***
Verify Tax Withholding toggle is visible (OL-T15903, OL-T15904, OL-T15906,OL-T15907)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Navigate to Option in client setup      Hire
    #   (OL-T15903)
    Check element display on screen     ${HIRE_TAX_WITHHOLDING_TOGGLE}
    Capture page screenshot
    #   (OL-T15904)
    Verify user able to turn ON Tax Withholding toggle
    #   (OL-T15906, OL-T15907)
    Verify user able to add Tax Withholding section to a form in case its toggle is ON


Verify user is NOT able to add Tax Withholding section to a form in case its toggle is OFF (OL-T15905)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Verify user NOT able to add Tax Withholding section to a form in case its toggle is OFF


Check the display of Candidate Experience screen in case Form add Tax Withholding (OL-T15915, OL-T15916, OL-T15918, OL-T15920, OL-T15921, OL-T15923, OL-T15924, OL-T15927, OL-T15928)
    ${candidate_name} =     Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${location_in_state}    ${JOB_FORM_WITH_TAX_WITHHOLDING_IN_CHECK_STATE}
    Check Digital Consent popup is diplayed
    #   (OL-T15915)
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_CANCEL}
    Check Action Required popup is displayed    ${FORM_WITH_TAX_WITHHOLDING}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_REVIEW_CONSENT}
    Check Digital Consent popup is diplayed
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    #   Check the display of Consent to Use Electronic Signatures popup after agree and reload Form (OL-T15916)
    Reload page
    Check Digital Consent popup is not diplayed
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    #   Check the display of Tax Withholding on Candidate Experience when Candidate's location in States (OL-T15918)
    Check element display on screen     ${FORM_FILLABLE_PDF_FILE_NAME}      ${federal_tax_form}
    Check element display on screen     ${FORM_FILLABLE_PDF_FILE_NAME}      ${state_tax_form}
    Capture page screenshot
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_TAX_REQUIRED_FIELD}      ${federal_tax_form}
    Check element display on screen     ${FORM_TAX_REQUIRED_FIELD}      ${state_tax_form}
    Check text display      2 Required Items Below
    Capture page screenshot
    #   Check the validation of Federal tax forms file on Candidate Experien in case Candidate's location in States (OL-T15920)
    Check the validation of tax forms file on Candidate Experien in case Candidate's location in States     ${federal_tax_form}     ${federal_form_tax_detail}
    #   Check that CANNOT submit Form when does not submit data on one of Federal tax forms and State tax forms files (OL-T15924)
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_TAX_REQUIRED_FIELD}      ${state_tax_form}
    Check text display      1 Required Item Below
    Capture page screenshot
    #   (OL-T15920)
    Check the validation of tax forms file on Candidate Experien in case Candidate's location in States     ${state_tax_form}
    #   (OL-T15921, OL-T15923)
    Click view tax form     ${federal_tax_form}
    Click view tax form     ${state_tax_form}
    ${handles}=     Get Window Handles
    ${handles_length} =     Get length      ${handles}
    Should be equal as numbers      ${handles_length}       3.0
    Switch Window       ${handles}[0]
    # TODO Need to check capture page screenshot here
    Capture page screenshot
    #   (OL-T15927)
    Check that CAN submit Form with Federal tax forms and State tax forms files
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Capture page screenshot
    #   (OL-T15928, OL-T15929)
    Check the display of Federal tax forms and State tax forms files on Hire Details screen     ${candidate_name}


Check the display of Tax Withholding on Candidate Experience when Candidate's location NOT in States (OL-T15930, OL-T15932, OL-T15934, OL-T15935, OL-T15936, OL-T15937, OL-T15938)
    ${candidate_name} =     Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${LOCATION_CITY_FLORIDA}    ${JOB_FORM_WITH_TAX_WITHHOLDING_IN_CHECK_STATE}
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    #   Check the display of [Tax Withholding] on [Candidate Experience] when Candidate's location NOT in States (OL-T15930)
    Check element display on screen     Tax Withholding title
    Check element display on screen     Tax Withholding content test form
    Check element display on screen     ${FORM_FILLABLE_PDF_FILE_NAME}      ${federal_tax_form}
    Check element not display on screen     ${FORM_FILLABLE_PDF_FILE_NAME}      ${state_tax_form}
    Capture page screenshot
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_TAX_REQUIRED_FIELD}      ${federal_tax_form}
    Check text display      1 Required Item Below
    Capture page screenshot
    #   Check the validation of [Federal tax forms] file on [Candidate Experien] in case Candidate's location NOT in States (OL-T15932)
    Check the validation of tax forms file on Candidate Experien in case Candidate's location in States     ${federal_tax_form}     ${federal_form_tax_detail}
    #   Check the display [Federal tax forms] file on [Review] screen (OL-T15934)
    Click view tax form     ${federal_tax_form}
    ${handles} =    Get Window Handles
    ${handles_length} =     Get length      ${handles}
    Should be equal as numbers      ${handles_length}       2.0
    Switch Window       ${handles}[0]
    # TODO Need to check capture page screenshot here
    #   (OL-T15935, OL-T15936)
    Check that CAN submit Form with Federal tax forms
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Capture page screenshot
    #   (OL-T15937, OL-T15938)
    Check the display of Federal tax forms on Hire Details screen       ${candidate_name}

*** Keywords ***
Verify user able to turn ON Tax Withholding toggle
    Turn on     ${HIRE_TAX_WITHHOLDING_TOGGLE}
    Check strong text display   Service Providers
    Check label display     Tax Withholding
    Check element display on screen     ${HIRE_TAX_WITHHOLDING_PROVIDER_SYSTEM_SELECT}
    Click at    ${HIRE_TAX_WITHHOLDING_PROVIDER_SYSTEM_SELECT}
    Check list items of select tag     ${HIRE_TAX_WITHHOLDING_PROVIDER_SYSTEM_SELECT}   ${provider_system}
    Capture page screenshot
    Save client setup page

Verify user able to add Tax Withholding section to a form in case its toggle is ON
    Go to form page
    ${form_name} =      Add new form and input name     Candidate
    Add a form section      ${tax_withholding}
    #   Check that CANNOT add Tax Withholding with default value
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Verify text contain     ${TOASTED_MESSAGE_ERROR}     Some fields are required to save
    Capture page screenshot
    Delete a form with type     ${CANDIDATE_FORM_TYPE}    ${form_name}

Verify user NOT able to add Tax Withholding section to a form in case its toggle is OFF
    Go to form page
    ${form_name} =  Add new form and input name     Candidate
    Click at        ${FORM_ADD_SECTION_BUTTON}
    Check element not display on screen     ${FORM_ADD_SECTION_OPTION}   ${tax_withholding}    wait_time=5s
    Capture page screenshot
    Delete a form with type     ${CANDIDATE_FORM_TYPE}    ${form_name}

Input Federal tax forms information
    [Arguments]     &{form_tax_information}
    Select frame    ${FRAME_PDF_FILLABLE}
    Input into      ${FORM_TAX_FIRST_NAME_AND_MIDDLE_INITIAL_INPUT}     ${form_tax_information.first_name}
    Input into      ${FORM_TAX_LAST_NAME_INPUT}     ${form_tax_information.last_name}
    Input into      ${FORM_TAX_SOCIAL_SECURITY_NUMBER_INPUT}     ${form_tax_information.security_number}
    Input into      ${FORM_TAX_ADDRESS_INPUT}     ${form_tax_information.address}
    Input into      ${FORM_TAX_CITY_STATE_ZIP_CODE_INPUT}     ${form_tax_information.city_state_zip_code}
    Click at        ${FORM_TAX_MARITAL_STATUS_HEAD_OF_HOUSEHOLD_RADIO}
    Input into      ${FORM_TAX_DATE_INPUT}    ${form_tax_information.date}
    Input into      ${FORM_TAX_EXTRA_WITHHOLDING_INPUT}    ${form_tax_information.extra_holding}
    Click at        ${FORM_TAX_EMPLOYEE_SIGNATURE_BUTTON}
    Check p text display    Create New Signature
    Click at        ${FORM_TAX_EMPLOYEE_SIGNATURE_INPUT}
    Click at        ${FORM_TAX_SIGNATURE_CREATE_BUTTON}
    Capture page screenshot
    Unselect frame

Check the validation of tax forms file on Candidate Experien in case Candidate's location in States
    [Arguments]     ${tax_form}     ${form_tax_information}=None
    Click at    ${FORM_TAX_GET_START_LINK}      ${tax_form}
    Wait for page load successfully
    Element should be disabled      ${FORM_FILLABLE_PDF_SUBMIT_FORM_BUTTON}
    Capture page screenshot
    Click at    ${FORM_TAX_READY_SUBMIT_CHECKBOX}
    Element should be enabled      ${FORM_FILLABLE_PDF_SUBMIT_FORM_BUTTON}
    Capture page screenshot
    IF      '${tax_form}' == 'Federal tax forms'
        Click at    ${FORM_FILLABLE_PDF_SUBMIT_FORM_BUTTON}
        Verify text contain     ${TOASTED_MESSAGE_ERROR}     Please fill all required fields!
        Capture page screenshot
        Input Federal tax forms information     &{form_tax_information}
    END
    Click at    ${FORM_FILLABLE_PDF_SUBMIT_FORM_BUTTON}
    Wait for page load successfully
    Check element display on screen     ${FORM_TAX_VIEW_LINK}       ${tax_form}
    Check element display on screen     ${FORM_FILLABLE_PDF_ICON_CHECK_BY_FORM_NAME}    ${tax_form}
    Capture page screenshot

Click view tax form
    [Arguments]     ${tax_form}
    Click at    ${FORM_TAX_VIEW_LINK}       ${tax_form}
    Wait for page load successfully
    Capture page screenshot
    ${handles}=     Get Window Handles
    Switch Window       ${handles}[0]

Check that CAN submit Form with Federal tax forms and State tax forms files
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_EDIT_SECTION_BUTTON}      ${personal_information}
    Check element display on screen     ${FORM_EXPERIENCE_EDIT_SECTION_BUTTON}      ${tax_withholding}
    Check element display on screen     ${FORM_VIEW_DOCUMENT_REVIEW_LINK}      ${federal_tax_form}
    Check element display on screen     ${FORM_VIEW_DOCUMENT_REVIEW_LINK}      ${state_tax_form}
    Capture page screenshot

Check the display of Federal tax forms and State tax forms files on Hire Details screen
    [Arguments]     ${candidate_name}
    Go to CEM page
    Click at        ${candidate_name}
    Click at        ${CEM_CANDIDATE_FORM}       ${FORM_WITH_TAX_WITHHOLDING}
    Check text display      ${candidate_name} Lname accepted Consent to use Electronic Signatures
    Check element display on screen     ${CEM_CANDIDATE_FORM_VIEW_TAX_WITHHOLDING}      ${state_tax_form}
    Check element display on screen     ${CEM_CANDIDATE_FORM_VIEW_TAX_WITHHOLDING}      ${federal_tax_form}
    Capture page screenshot

Check that CAN submit Form with Federal tax forms
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_EDIT_SECTION_BUTTON}      ${personal_information}
    Check element display on screen     ${FORM_EXPERIENCE_EDIT_SECTION_BUTTON}      ${tax_withholding}
    Check element display on screen     ${FORM_VIEW_DOCUMENT_REVIEW_LINK}      ${federal_tax_form}
    Capture page screenshot

Check the display of Federal tax forms on Hire Details screen
    [Arguments]     ${candidate_name}
    Go to CEM page
    Click at        ${candidate_name}
    Click at        ${CEM_CANDIDATE_FORM}       ${FORM_WITH_TAX_WITHHOLDING}
    Check text display      ${candidate_name} Lname accepted Consent to use Electronic Signatures
    Check element display on screen     ${CEM_CANDIDATE_FORM_VIEW_TAX_WITHHOLDING}      ${federal_tax_form}
    Capture page screenshot
