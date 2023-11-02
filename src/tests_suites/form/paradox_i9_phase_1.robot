*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Default Tags        lts_stg    regression    stg

*** Variables ***
@{i_9_provider_system}          None    Lawlogix    Lawlogixv2    MitraTech - Tracker    Paradox I9    Other
${i9_paradox_provider}          Paradox I9
${employer_tax_name}            Paradox Inice New
${employer_tax_name_2}          Paradox Inice New 2
&{gryphon_name_and_assdress}    first_name=Joe    last_name=Biden    middle_name=R    maiden_name=JB    address=11 Main Streey
...                             apt_number=B43f    city=Scranton    state=Pennsylvania    zip_code=32131

*** Test Cases ***
Check the display of I9 Paradox in Client Setup > Hire (OL-T23265, OL-T23266, OL-T23271, OL-T23272, OL-T23273)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_PARADOX_I9}
    Navigate to Option in client setup      Hire
    Click at    ${HIRE_I_9_PROVIDER_SYSTEM_SELECT}
    #   (OL-T23265)
    Check list items of select tag      ${HIRE_I_9_PROVIDER_SYSTEM_SELECT}      ${i_9_provider_system}
    #   Check the validation of URL code field on Client Setup (OL-T23266)
    Select From List By Label       ${HIRE_I_9_PROVIDER_SYSTEM_SELECT}      ${i9_paradox_provider}
    Input into      ${HIRE_I_9_URL_CODE_INPUT}      !@!@!@!
    Check element display on screen     ${HIRE_I_9_URL_CODE_VALIDATOR_LABEL}    This URL is invalid.
    Capture page screenshot
    Clear element text with keys    ${HIRE_I_9_URL_CODE_INPUT}
    Check element display on screen     ${HIRE_I_9_URL_CODE_VALIDATOR_LABEL}    This field is required
    Capture page screenshot
    #   Check that CAN setting I9 Paradox with unique URL code and all locations are added to Employer Tax Information (OL-T23271)
    ${urlCode} =    Generate Random String      6       [NUMBERS]
    Input into      ${HIRE_I_9_URL_CODE_INPUT}      i9-paradox-${urlCode}
    Save client setup page
    #   Check New Custom on Gryphon system in case setting I9 Paradox successfully (OL-T23272)
    @{company_information} =    Create list     300 main street     85001       ${COMPANY_PARADOX_I9}       Phoenix     i9-paradox-${urlCode}       0000000
    Go to gryphon system
    Search for company      ${COMPANY_PARADOX_I9}
    Verify customer information displayed correctly     @{company_information}
    Click at    ${GRYPHON_CUSTOMERS_SUB_CUSTOMERS_LIST}
    Search for customer     ${employer_tax_name}
    @{employer_information} =       Create list     ${employer_tax_name}    32-1546574      3052 College Park Drive     CONROE      77384-8002      4809292842      110001
    Verify customer information displayed correctly     @{employer_information}
    #   Check Customs on Gryphon system in case setting I9 Paradox successfully and has many Employer on "Employer Tax Information" (OL-T23273)
    Search for company      ${COMPANY_PARADOX_I9}
    Click at    ${GRYPHON_CUSTOMERS_SUB_CUSTOMERS_LIST}
    Search for customer     ${employer_tax_name_2}
    @{employer_information_2} =     Create list     ${employer_tax_name_2}      32-1546574      3052 College Park Drive 2       CONROE      77384-8002      4809292842      110002
    Verify customer information displayed correctly     @{employer_information_2}


Check that CAN add I9 part II section on Form (OL-T23293, OL-T23294, OL-T23295, OL-T23298, OL-T23302)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_PARADOX_I9}
    Go to form page
    ${form_name} =      Add new form and input name     ${USER_FORM_TYPE}
    Go to a form section detail     ${default_section}
    Add a form task with type and save      ${address}
    Go to a form section detail     ${default_section}
    Add a form task with type and save      ${date_selection}
    #   (OL-T23293)
    Add a form section      ${I9_part_II}
    Check the display of I9 part screen     II
    #   Check that CAN add "I9 part III" section on Form (OL-T23294)
    Add a form section      ${I9_part_III}
    Check the display of I9 part screen     III
    #   Check the validation of I9 part II on User Form builder screen (OL-T23295)
    Check the validation of I9 part on User Form builder screen     II      Paradox I9 Part II      Paradox I9 Body Part II
    #   Check the validation of I9 part III on User Form builder screen (OL-T23298)
    Check the validation of I9 part on User Form builder screen     III     Paradox I9 Part III     Paradox I9 Body Part III
    #   Check that CAN Published User Form with I9 part II and I9 part III (OL-T23302)
    Check that CAN Published User Form with I9 part II and I9 part III      Paradox I9 Part II      Paradox I9 Body Part II
    Check that CAN Published User Form with I9 part II and I9 part III      Paradox I9 Part III     Paradox I9 Body Part III
    Delete a form with type     ${USER_FORM_TYPE}       ${form_name}


Check that User CAN open I9 part II on User Experience in case I9 part II is generated link (OL-T23277, OL-T23281, OL-T23283, OL-T23285)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_PARADOX_I9}
    Switch to user      ${CA_TEAM}
    ${candidate_name} =     Add a Candidate     None    ${LOCATION_CITY_FLORIDA}    ${JOB_PARADOX_I9_PHASE_1}       is_spam_email=False
    Get form link and enter information     ${COMPANY_PARADOX_I9}       ${candidate_name}
    Check element display on screen     ${FORM_I9_FORM_NAME_CANDIDATE_EXPERIENCE_FORM}      I-9 Employment Eligibility Verification Form
    Check element display on screen     ${FORM_I9_FORM_NAME_GET_STARTED_BUTTON}
    Capture page screenshot
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check text display      This Field is Required
    Check text display      1 Required Item Below
    Capture page screenshot
    # Check the display spinning loading icon of I9 Paradox I on Candidate Experience when opening I9 Paradox I link (OL-T23281)
    Click at    ${FORM_I9_FORM_NAME_GET_STARTED_BUTTON}
    Check text display      Form I-9 - Section 1
    ${current_url} =    Get location
    Should Contain      ${current_url}      gryphonhr.com
    Capture page screenshot
    # Check that Candidate CAN complete I9 Paradox I form (OL-T23283)
    Input Name and Address in Gryphon system    &{gryphon_name_and_assdress}
    Input SSN and Add'l Info in Gryphon system
    # Check that Candidate CAN submit Candidate Form with I9 Paradox I (OL-T23285)
    Go to CEM page
    Go to Candidate Experience page of Form     ${candidate_name}       ${FORM_CANDIDATE_PARADOX_I9_PHASE_1}
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 1)
    Check element not display on screen     ${CEM_I9_FORM_TITLE}    ${EMPTY}    wait_time=2s
    Capture page screenshot

*** Keywords ***
Go to gryphon system
    Go to   ${FORM_GRYPHON_SYSTEM_LINK}
    Input into   ${GRYPHON_LOGIN_EMAIL_INPUT}      ${FORM_GRYPHON_SYSTEM_USERNAME}
    Input into   ${GRYPHON_LOGIN_PASSWORD_INPUT}      ${FORM_GRYPHON_SYSTEM_PASSWORD}
    Click at    ${GRYPHON_LOGIN_BUTTON}

Search for company
    [Arguments]     ${customer}
    Click at    ${GRYPHON_ADMINISTRATOR_MENU}
    Click at    ${GRYPHON_CUSTOMERS_MENU}
    Search for customer     ${customer}

Search for customer
    [Arguments]     ${customer}
    Input into      ${GRYPHON_CUSTOMERS_SEARCH_INPUT}       ${customer}
    Press keys      None    ENTER
    Double click at     ${GRYPHON_CUSTOMERS_NAME_LABEL}     ${customer}

Verify customer information displayed correctly
    [Arguments]     @{customer_information}
    FOR     ${information}    IN      @{customer_information}
        Check element display on screen     ${GRYPHON_CUSTOMERS_INPUT_VALUE}        ${information}
    END
    Capture page screenshot

Check the display of I9 part screen
    [Arguments]     ${part}
    Check text display      The user will see instructions to complete part ${part} of the candidate's I-9 form. This is automatically generated
    Check element not display on screen     ${FORM_ADD_TASK_BUTTON}     wait_time=2s
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Verify text contain     ${TOASTED_MESSAGE_ERROR}     Some fields are required to save
    Capture page screenshot
    Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    Form I9 Part ${part}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Check element display on screen     ${FORM_ADD_SECTION_BUTTON}
    Check text display     Complete Part ${part} of the candidate's I9
    Capture page screenshot

Check the validation of I9 part on User Form builder screen
    [Arguments]     ${part}     ${new_title_section}    ${new_body_text}
    Click at    Complete Part ${part} of the candidate's I9
    Click at    ${FORM_SECTION_EDIT_NAME_ICON}
    Clear element text with keys    ${FORM_SECTION_NAME_TEXTBOX}
    Check element display on screen     Task title is required
    Capture page screenshot
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Verify text contain     ${TOASTED_MESSAGE_ERROR}    Task title is required to save
    Capture page screenshot
    Click at    ${FORM_SECTION_EDIT_NAME_ICON}
    Input into      ${FORM_SECTION_NAME_TEXTBOX}    ${new_title_section}
    Clear element text with keys    ${FORM_CONTENT_SECTION_TEXTAREA}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Verify text contain     ${TOASTED_MESSAGE_ERROR}     Some fields are required to save
    Capture page screenshot
    Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    ${new_body_text}
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Check element display on screen     ${FORM_ADD_SECTION_BUTTON}
    Capture page screenshot
    Click at    ${new_title_section}
    Check element display on screen     ${new_body_text}
    Capture page screenshot
    Click at    ${FORM_SECTION_CANCEL_BUTTON}

Check that CAN Published User Form with I9 part II and I9 part III
    [Arguments]     ${new_title_section}    ${new_body_text}
    Click publish form
    Click at    ${new_title_section}
    Check element display on screen       ${new_body_text}
    Capture page screenshot
    Click at    ${FORM_SECTION_CANCEL_BUTTON}

Get form link and enter information
    [Arguments]     ${company_name}     ${candidate_name}
    Click button in email    Complete your form at ${company_name}      Hi ${candidate_name}!       COMPLETE_ASSESSMENT
    Enter code for verify code step   ${candidate_name}
    Input all valid information into candidate form     False
    Click at    ${FORM_NEXT_SECTION_BUTTON}

Input Name and Address in Gryphon system
    [Arguments]     &{name_and_address_information}
    Click at    ${GRYPHON_NEXT_BUTTON}
    Input into      ${GRYPHON_SECTION1_LAST_NAME_TEXTBOX}       ${name_and_address_information.first_name}
    Input into      ${GRYPHON_SECTION1_FIRST_NAME_TEXTBOX}       ${name_and_address_information.last_name}
    Input into      ${GRYPHON_SECTION1_MIDDLE_NAME_TEXTBOX}       ${name_and_address_information.middle_name}
    Input into      ${GRYPHON_SECTION1_MAIDEN_NAME_TEXTBOX}       ${name_and_address_information.maiden_name}
    Input into      ${GRYPHON_SECTION1_ADDRESS1_TEXTBOX}       ${name_and_address_information.address}
    Input into      ${GRYPHON_SECTION1_APT_NUMBER_TEXTBOX}       ${name_and_address_information.apt_number}
    Input into      ${GRYPHON_SECTION1_CITY_TEXTBOX}       ${name_and_address_information.city}
    Click at    ${GRYPHON_SECTION1_STATE_CODE_SELECT}
    Select from list by label      ${GRYPHON_SECTION1_STATE_CODE_SELECT}       ${name_and_address_information.state}
    Input into      ${GRYPHON_SECTION1_ZIPCODE_TEXTBOX}       ${name_and_address_information.zip_code}
    Click at    ${GRYPHON_NEXT_BUTTON}

Input SSN and Add'l Info in Gryphon system
    Input into      ${GRYPHON_SECTION1_BIRTHDATE_TEXTBOX}     07/06/1969
    Input into      ${GRYPHON_SECTION1_I9_EMAIL_ADDRESS_TEXTBOX}    ${CONFIG.gmail}
    Input into      ${GRYPHON_SECTION1_I9_PHONE_NUMBER_TEXTBOX}     ${CONST_PHONE_NUMBER}
    Click at    ${GRYPHON_NEXT_BUTTON}
    Click at    ${GRYPHON_SECTION1_I9_CITIZENSHIP_INFO_OF_UNITED_STATES_BUTTON}
    Click at    ${GRYPHON_NEXT_BUTTON}
    Click at    ${GRYPHON_SECTION1_GENERATE_SIGNATURE_BUTTON}       slow_down=2s
    Click at    ${GRYPHON_NEXT_BUTTON}
    Click at    ${GRYPHON_NEXT_BUTTON}
    Click at    ${GRYPHON_FINISH_BUTTON}
    Check Candidate CAN complete I9 Paradox I form

Check Candidate CAN complete I9 Paradox I form
    Check element display on screen     ${FORM_I9_FORM_NAME_CHECK_ICON}
    Verify element is disable       ${FORM_I9_FORM_NAME_BUTTON}
    Capture page screenshot
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check text display      Thank you!
    Capture page screenshot
