*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Force Tags          regression    stg    test

*** Variables ***
${form_location}                Florida
${paragraph_type}               Paragraph_type
${custom_question_label}        Custom question
${option_1_text}                option 1
${option_2_text}                option 2
&{candidate_info}               phone_number=${CONST_PHONE_NUMBER}    address1=420 Nguyen Huu Tho    city=Da Nang    state=Arizona    zip_code=85043
&{candidate_info_validate}      phone_number=0123456789    address1=230 Trung Nu Vuong    city=Hanoi    state=Floria    zip_code=10004
&{bank_info}                    bank_name=Ambank Berhad    bank_account_type=Checking    routing_number=044115090    accounting_number=041215032
&{bank_info_2}                  bank_name=Bank of America    bank_account_type=Savings    routing_number=041215016    accounting_number=051903761
&{work_experience_1}            your_job_title=HR    company_name=Olivia    location=Da Nang    date_started=01/08/2020    date_end=21/08/2021
&{work_experience_2}            your_job_title=Tester    company_name=Paradox    location=Da Nang    date_started=01/09/2021    date_end=21/08/2022

*** Test Cases ***
Check the display of Personal Information on Candidate Experience screen (OL-T13701, OL-T13704)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_USER_SEND_FORM}
    Verify personal information form displays correctly
    #   Check the default validation of [Personal Information] on Candidate Experience screen (T13704)
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Verify validate message displays correctly


Candidate Form - Check the display of Custom Question task with Short Answer type on Candidate Experience screen (OL-T14412, OL-T14413, OL-T14414, OL-T14415, OL-T14416, OL-T13924, OL-T14306, OL-T14356, OL-T14362, OL-T14390, OL-T13928)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_GENERAL_FORM_CUSTOM_TASK}
    Input all valid information into candidate form
    #    (OL-T14412)
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_EXPERIENCE_YOUR_ANSWER_SINGLE_LINE_INPUT}
    #   [Candidate Form] - [Candidate Form] - Check the display of [Custom Question] task with [Paragraph] type on [Candidate Experience] screen (OL-T14413)
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_INPUT_TEXT_PARAGRAPH_TEXTAREA}
    #   [Candidate Form] - [Candidate Form] - Check the display of [Custom Question] task with [Multi Choice] type on [Candidate Experience] screen (OL-T14414)
    Check the display of Custom Question task with Multi Choice
    #   [Candidate Form] - [Candidate Form] - Check the display of [Custom Question] task with [Drop down] type on [Candidate Experience] screen (OL-T14415)
    Check the display of Custom Question task with Drop down
    #   [Candidate Form] - [Candidate Form] - Check the display of [Custom Question] task with [Check box] type on [Candidate Experience] screen (OL-T14416)
    Check the display of Custom Question task with Check box
    #   Check the display of [Diversity Questions] section on [Candidate Experience] (OL-T13924)
    #   Check the validation of [Diversity Questions] section on [Candidate Experience] when [Required] toggle = OFF (OL-T13928)
    Check the display of Custom Question task with Diversity Questions
    #   Check the default display of [Work Experience] on [Candidate Experience] screen (OL-T14306)
    Check the display of Custom Question task with Work Experience
    #   [Candidate Form] - Check the display of [Date selection] task on [Candidate Experience] screen (OL-T14356)
    Check the display of Custom Question task with Date selection
    #   [Candidate Form] - Check the display of [Display Text] task type on Candidate Experience screen (OL-T14362)
    Check the display of Custom Question task with Display Text
    #   [Candidate Form] - Check the validation of [Document Review] task on [Candidate Experience] screen (OL-T14390)
    Check the display of Custom Question task with Document Review
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}


Check the display of Personal Information section on Candidate Experience screen when setting Add Confirmation Field = checked on fields (OL-T13707, OL-T14357, OL-T14419, OL-T15249, OL-T15261)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_FORM_WITH_CONFIRMATION_FIELD}
    #   Check the display of Personal Information section on Candidate Experience screen when setting Add Confirmation Field = checked on fields (OL-T13707)
    Input all valid information into candidate form
    Fill not match required information for form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Verify confirmation field error displayed correctly for form
    Fill match information for form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    #   [Candidate Form] - Check the display of [Date selection] task on [Candidate Experience] screen in case [Add confirmation field] = Checked (OL-T14357)
    ${current_date} =    get_date
    ${next_date} =    get_date   1
    Select date in candidate experience page      ${current_date}
    Select date confirmation in candidate experience page      ${next_date}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check error field displayed     Select a date        Values do not match
    #   [Candidate Form] - Check the display of [Custom Question] task on [Candidate Experience] screen in case [Add confirmation field] = Checked ON (OL-T14419)
    Select date confirmation in candidate experience page      ${current_date}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    #   Check the display of field when setting [Add Confirmation field] at [Candidate Experience] (OL-T15249, OL-T15261)
    Input into    ${FORM_EXPERIENCE_YOUR_ANSWER_SINGLE_LINE_INPUT}      value 1
    Input into    ${FORM_EXPERIENCE_YOUR_ANSWER_SINGLE_LINE_CONFIRMATION_INPUT}     value 2
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check error field displayed     Custom question        Values do not match
    Input into    ${FORM_EXPERIENCE_YOUR_ANSWER_SINGLE_LINE_CONFIRMATION_INPUT}     value 1
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Capture page screenshot


Check the display of Personal Information section on Candidate Experience screen when setting Hide from Manager = checked on fields (OL-T13709, OL-T15253, OL-T15265)
    ${candidate_name} =     Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_FORM_SETTING_HIDE_FROM_MANAGER}
    Input all valid information into candidate form
    Input into      ${FORM_STREET_ADDRESS_LINE_2_TEXTBOX}   460 Nguyen Huu Tho
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Input into      ${FORM_EXPERIENCE_YOUR_ANSWER_SINGLE_LINE_INPUT}    Answer Single Line Input
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    #   Check the display of field when setting [Hide from Manager] at [Candidate Experience] (OL-T15253, OL-T15265)
    Check fields hiden from manager     ${candidate_name}   ${FORM_SETTING_HIDE_FROM_MANAGER}
    Check element not display on screen     Answer Single Line Input    wait_time=1s
    Capture page screenshot


Check the display of Personal Information section on Candidate Experience screen when setting Sensitive Information = checked on fields (OL-T13710, OL-T15245, OL-T15257)
    ${candidate_name} =     Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_FORM_SETTING_SENSITIVE_INFORMATION}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    Input into      ${FORM_EXPERIENCE_YOUR_ANSWER_SINGLE_LINE_INPUT}    Answer Single Line Input
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    #   Check the display of field when setting [Sensitive Information] at [Candidate Experience] (OL-T13710, OL-T15245, OL-T15257)
    Check fields sensitive information     ${candidate_name}   ${FORM_SETTING_SENSITIVE_INFORMATION}


Check the display of Diversity Questions section on Candidate Experience when deleting default tasks (OL-T13925, OL-T13926, OL-T13927, OL-T14308, OL-T14417, OL-T14418, OL-T14358, OL-T14381)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_FORM_SETTING_DEFAULT_VALIDATION}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    #   OL-T13925
    Check display Diversity Questions section on Candidate Experience when deleting default tasks
    #   OL-T13926
    Check display of Diversity Questions section on Candidate Experience when adding new tasks
    #   OL-T13927
    Check default validation of Diversity Questions section on Candidate Experience
    Select required field for Diversity Questions
    #   [Candidate Form] - Check the display of [Custom Question] task on [Candidate Experience] screen in case [Required] toggle is ON (OL-T14417)
    Check error field displayed     Custom question     This Field is Required
    #   OL-T14418
    Check validation Custom Question task type on Candidate Experience screen       Custom question
    #   OL-T14358
    Check display of Date selection task on Candidate Experience screen in case Required toggle is ON
    #   OL-T14381
    Check display of Your full name task on Candidate Experience screen
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    #   OL-T14308
    Check the validation of Work Experience task with default setting on Candidate Experience screen
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}


Check the display of Work Experience with Maximum responses allowed more than 1 on Candidate Experience screen (OL-T14307, OL-T14392, OL-T20899, OL-T14311)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_FORM_WORK_EXPERIENCE}
    #   OL-T14392
    Click at    ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    Input all valid information into candidate form
    #   OL-T14307
    Check the display of Custom Question task with Work Experience
    Check display of Work Experience with Maximum responses allowed more than one       2
    Check display of Work Experience with Maximum responses allowed more than one       3
    Check element not display on screen    ${FORM_EXPERIENCE_ADD_ANOTHER_WORKPLACE_BUTTON}
    Click at    ${FORM_EXPERIENCE_REMOVE_WORKPLACE_BUTTON}  Employment history 2
    Click at    ${FORM_EXPERIENCE_REMOVE_RESPONSE_BUTTON}
    Click at    ${FORM_EXPERIENCE_REMOVE_WORKPLACE_BUTTON}  Employment history 2
    Click at    ${FORM_EXPERIENCE_REMOVE_RESPONSE_BUTTON}
    #   Check the validation of [Work Experience] task on [Candidate Experience] screen when adding another workplace (OL-T14311)
    Fill work experience for form       Employment history 1    ${work_experience_1}
    #   OL-T20899
    Check display of Payroll Information on Candidate Experience when Payment Method is deleted     &{bank_info}
    Check the display of Custom Question task with Document Review
    #   OL-T14392
    Click at    ${CANDIDATE_EXPERIENCE_CONSENT_USE_ELECTRONIC_SIGNATURE}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    Check bank information displayed correctly in review page   ${bank_info}
    #   OL-T14311
    Click at    ${FORM_EXPERIENCE_EDIT_SECTION_BUTTON}      Work Experience
    Click at    ${FORM_EXPERIENCE_ADD_ANOTHER_WORKPLACE_BUTTON}
    Click at    ${FORM_EXPERIENCE_ADD_ANOTHER_WORKPLACE_BUTTON}
    Scroll to element    Employment history 3
    Click at    ${FORM_EXPERIENCE_REMOVE_WORKPLACE_BUTTON}  Employment history 3
    Click at    ${FORM_EXPERIENCE_REMOVE_RESPONSE_BUTTON}
    Fill work experience for form       Employment history 2    ${work_experience_2}
    Click at     ${FORM_EXPERIENCE_JOB_TITLE_ANSWER}    Employment history 2
    Click by JS    ${FORM_REVIEW_BUTTON}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Capture page screenshot


Check the default display of Payroll Information on Candidate Experience screen when location of Job NOT in must_show_paper_check_states (OL-T14249, OL-T14250, OL-T14257, OL-T14261, OL-T14263)
    Add candidate and open form     ${COMPANY_NEXT_STEP}    ${CA_TEAM}      ${form_location}    ${JOB_FORM_NOT_IN_CHECK_STATE}
    Input all valid information into candidate form
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    #   Check the default display of [Payroll Information] on [Candidate Experience] screen when location of Job NOT in must_show_paper_check_states (OL-T14249)
    Check the default display when location of Job NOT in must_show_paper_check_states
    #   Check the default display of [Payroll Information] on [Candidate Experience] screen when the location of Job NOT in must_show_paper_check_states and name of [Payment Method] task is updated (OL-T14250)
    #   Check the default display of [Payroll Information] on [Candidate Experience] screen when location of Job NOT in must_show_paper_check_states and [Language] of conversation is not language default (English) (OL-T14257)
    Click on span text  Direct Deposit
    Input bank information for form     &{bank_info}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check bank information displayed correctly in review page   ${bank_info}
    #   (OL-T14261)
    Click at    ${FORM_EXPERIENCE_EDIT_SECTION_BUTTON}      Payment Information
    #   Check the display Bank Information of [Payroll Information] section at Review Candidate Experience screen when changing Payment Method (OL-T14263)
    Check display Bank Information of Payroll Information section at Review Candidate Experience screen when changing Payment Method    ${bank_info_2}
    Check bank information displayed correctly in review page   ${bank_info_2}
    Click at    ${FORM_SUBMIT_BUTTON}
    Check p text display    ${CANDIDATE_EXPERIENCE_FORM_SUBMITTED}
    Capture page screenshot

*** Keywords ***
Verify personal information form displays correctly
    Check element display on screen     ${FORM_ITEM_FIELD}      Your full name
    Check element display on screen     ${FORM_ITEM_FIELD}      Phone number
    Check element display on screen     ${FORM_ITEM_FIELD}      Email address
    Check element display on screen     ${FORM_ITEM_FIELD}      Street address (Line 1)
    Check element display on screen     ${FORM_ITEM_FIELD}      Street address (Line 2)
    Check element display on screen     ${FORM_ITEM_FIELD}      City
    Check element display on screen     ${FORM_ITEM_FIELD}      State
    Check element display on screen     ${FORM_ITEM_FIELD}      ZIP code
    Check element display on screen     ${FORM_FIRST_NAME_TEXTBOX}
    Check element display on screen     ${FORM_MIDDLE_NAME_TEXTBOX}
    Check element display on screen     ${FORM_LAST_NAME_TEXTBOX}
    Check element display on screen     ${FORM_PHONE_NUMBER_TEXTBOX}
    Check element display on screen     ${FORM_EMAIL_ADDRESS_TEXTBOX}
    Check element display on screen     ${FORM_STREET_ADDRESS_LINE_1_TEXTBOX}
    Check element display on screen     ${FORM_STREET_ADDRESS_LINE_2_TEXTBOX}
    Check element display on screen     ${FORM_CITY_TEXTBOX}
    Check element display on screen     ${FORM_STATE_TEXTBOX}
    Check element display on screen     ${FORM_ZIPCODE_TEXTBOX}
    Check element display on screen     ${FORM_NEXT_SECTION_BUTTON}
    Capture page screenshot

Verify validate message displays correctly
    Check error field displayed     Phone number        This Field is Required
    Check error field displayed     Street address (Line 1)        This Field is Required
    Check error field displayed     Street address (Line 2)        This Field is Required
    Check error field displayed     City        This Field is Required
    Check error field displayed     State        This Field is Required
    Check error field displayed     ZIP code        This Field is Required
    Capture page screenshot

Fill not match required information for form
    Input into      ${FORM_PHONE_NUMBER_CONFIRMATION_TEXTBOX}        ${candidate_info_validate.phone_number}
    Input into      ${FORM_STREET_ADDRESS_LINE_1_CONFIRMATION_TEXTBOX}        ${candidate_info_validate.address1}
    Input into      ${FORM_CITY_CONFIRMATION_TEXTBOX}        ${candidate_info_validate.city}
    Input into      ${FORM_STATE_CONFIRMATION_TEXTBOX}       ${candidate_info_validate.state}
    Input into      ${FORM_ZIPCODE_CONFIRMATION_TEXTBOX}       ${candidate_info_validate.zip_code}

Fill match information for form
    Input into      ${FORM_PHONE_NUMBER_CONFIRMATION_TEXTBOX}        ${candidate_info.phone_number}
    Input into      ${FORM_STREET_ADDRESS_LINE_1_CONFIRMATION_TEXTBOX}        ${candidate_info.address1}
    ${email} =    Get value and format text    ${FORM_EMAIL_ADDRESS_TEXTBOX}    value
    Input into      ${FORM_EMAIL_ADDRESS_CONFIRMATION_TEXTBOX}        ${email}
    Input into      ${FORM_CITY_CONFIRMATION_TEXTBOX}        ${candidate_info.city}
    Input into      ${FORM_STATE_CONFIRMATION_TEXTBOX}       ${candidate_info.state}
    Input into      ${FORM_ZIPCODE_CONFIRMATION_TEXTBOX}       ${candidate_info.zip_code}

Verify confirmation field error displayed correctly for form
    Check error field displayed     Phone number        Values do not match
    Check error field displayed     Street address (Line 1)        Values do not match
    Check error field displayed     City        Values do not match
    Check error field displayed     State        Values do not match
    Check error field displayed     ZIP code        Values do not match

Check the display of Custom Question task with Check box
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click at    ${FORM_SHOW_MENU_BUTTON}
    Check element display on screen     ${FORM_ITEM_TASK_DROP_DOWN}      ${option_1_text}
    Check element display on screen     ${FORM_ITEM_TASK_DROP_DOWN}      ${option_2_text}

Check the display of Custom Question task with Drop down
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Click by JS    ${FORM_OPTION_CHECK_BOX}      ${option_1_text}
    Click by JS    ${FORM_OPTION_CHECK_BOX}      ${option_2_text}

Check the display of Custom Question task with Multi Choice
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    ${locator} =    Format String   ${FORM_ITEM_RADIO_MULTI_CHOSE}      ${option_1_text}
    Page should contain element     ${locator}
    ${locator} =    Format String   ${FORM_ITEM_RADIO_MULTI_CHOSE}      ${option_2_text}
    Page should contain element     ${locator}

Check the display of Custom Question task with Display Text
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check p text display    This is display text
    Check element display on screen     ${FORM_ITEM_FIELD}      display_text

Check the display of Custom Question task with Date selection
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_ITEM_FIELD}      Select a date
    Check element display on screen     ${FORM_DATE_PICKER}

Check diversity question section display
    Check element display on screen     ${FORM_ITEM_FIELD}      EEO Voluntary Self-Identification
    Check element display on screen     ${FORM_ITEM_FIELD}      Equal Employment Opportunity
    Check element display on screen     ${FORM_ITEM_FIELD}      Ethnicity
    Check element display on screen     ${FORM_ITEM_FIELD}      Gender
    Check element display on screen     ${FORM_ITEM_FIELD}      Marital Status
    Check element display on screen     ${FORM_ITEM_FIELD}      Please provide an answer below
    Check span display  Male
    Check span display  Female
    Check span display  Yes, I have a disability (or previously had a disability)
    Check span display  No, I do not have a disability
    Check span display  I do not wish to answer
    Check p text display    EEO Voluntary Self-Identification
    Check p text display    Equal Employment Opportunity

Check the display of Custom Question task with Diversity Questions
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check diversity question section display
    Check element display on screen     ${FORM_ITEM_FIELD}      Voluntary Self-Identification of Disability
    Check p text display    How do I know if I have a disability?
    Check p text display    Voluntary Self-Identification of Disability

Check the display of Custom Question task with Work Experience
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_ITEM_FIELD}      Your Job title
    Check element display on screen     ${FORM_ITEM_FIELD}      Company name
    Check element display on screen     ${FORM_ITEM_FIELD}      Location
    Check element display on screen     ${FORM_ITEM_FIELD}      Date started
    Check element display on screen     ${FORM_ITEM_FIELD}      Date ended
    Check span display  I Currently Work Here
    Capture page screenshot

Check the display of Custom Question task with Document Review
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     ${FORM_DOCUMENT_REVIEW_TITLE}      Document_review_question
    Check element display on screen     ${FORM_DOCUMENT_REVIEW_VIEW_LINK}
    Click at    ${FORM_DOCUMENT_REVIEW_VIEW_LINK}
    Capture page screenshot
    @{window} =    get window handles
    Switch window    ${window}[0]

Check fields hiden from manager
    [Arguments]     ${candidate_name}       ${form_name}
    Go to CEM page
    Click at    ${candidate_name}
    Click at    ${CEM_CANDIDATE_FORM}       ${form_name}
    Check hire details form information display on screeen
    Check element not display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 1)   wait_time=5s
    Check element not display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 2)   wait_time=1s
    Check element not display on screen     ${CEM_CANDIDATE_FORM_TITLE}     City   wait_time=1s
    Check element not display on screen     ${CEM_CANDIDATE_FORM_TITLE}     State   wait_time=1s
    Check element not display on screen     ${CEM_CANDIDATE_FORM_TITLE}     ZIP code   wait_time=1s
    Capture page screenshot

Check fields sensitive information
    [Arguments]     ${candidate_name}       ${form_name}
    Go to CEM page
    Click at    ${candidate_name}
    Click at    ${CEM_CANDIDATE_FORM}       ${form_name}
    Check hire details form information display on screeen
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 1)
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Street address (Line 2)
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     City
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     State
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     ZIP code
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE_CUSTOM}     Custom question
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE_SENSITIVE_INFORMATION}     City
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE_SENSITIVE_INFORMATION}     State
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE_SENSITIVE_INFORMATION}     ZIP code
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE_SENSITIVE_INFORMATION}     Custom question
    Capture page screenshot

Check display Diversity Questions section on Candidate Experience when deleting default tasks
    Check diversity question section display
    Check element not display on screen     ${FORM_ITEM_FIELD}      Voluntary Self-Identification of Disability   wait_time=1s
    Check element not display on screen    How do I know if I have a disability?   wait_time=1s
    Check element not display on screen    Voluntary Self-Identification of Disability   wait_time=1s
    Capture page screenshot

Check display of Diversity Questions section on Candidate Experience when adding new tasks
    Check element display on screen     ${FORM_ITEM_FIELD}      Custom question
    Check element display on screen     ${FORM_ITEM_FIELD}      Select a date
    Capture page screenshot

Check default validation of Diversity Questions section on Candidate Experience
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Wait for page load successfully
    Check error field displayed     Ethnicity        This Field is Required
    Check error field displayed     Gender        This Field is Required
    Check error field displayed     Marital Status        This Field is Required
    Check error field displayed     Please provide an answer below        This Field is Required
    Capture page screenshot

Check the validation of Work Experience task with default setting on Candidate Experience screen
    Input into      ${FORM_EXPERIENCE_INPUT}    HR      Your Job title
    Input into      ${FORM_EXPERIENCE_INPUT}    Paradox      Company name
    Input into      ${FORM_EXPERIENCE_INPUT}    Vietnam      Location
    Click at    ${FORM_EXPERIENCE_START_DATE_SELECT}
    Input into      ${FORM_EXPERIENCE_START_DATE_INPUT}    20/08/2022
    Click at    ${FORM_EXPERIENCE_INPUT}    Your Job title
    Click at    ${FORM_EXPERIENCE_END_DATE_SELECT}
    Input into      ${FORM_EXPERIENCE_END_DATE_INPUT}    20/07/2022
    Click at    ${FORM_EXPERIENCE_INPUT}    Your Job title
    Check error field displayed     Date ended         Date ended must be greater than date started
    Click at    ${FORM_EXPERIENCE_END_DATE_SELECT}
    Input into      ${FORM_EXPERIENCE_END_DATE_INPUT}    20/07/2023
    Click at    ${FORM_EXPERIENCE_INPUT}    Your Job title
    Check element not display on screen     Date ended must be greater than date started    wait_time=5s
    Click at    I Currently Work Here
    Check element not display on screen     ${FORM_EXPERIENCE_END_DATE_SELECT}  wait_time=2s
    Capture page screenshot

Check validation Custom Question task type on Candidate Experience screen
    [Arguments]     ${task}
    Input into      ${FORM_EXPERIENCE_INPUT}    11111   ${task}
    Check error field displayed     ${task}     Please only use letters, spaces, dashes, and apostrophes
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Input into      ${FORM_EXPERIENCE_INPUT}    !@$$$%%^    ${task}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check error field displayed     ${task}     Please only use letters, spaces, dashes, and apostrophes
    Input into      ${FORM_EXPERIENCE_INPUT}    abcd123     ${task}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check error field displayed     ${task}     Please only use letters, spaces, dashes, and apostrophes
    Input into      ${FORM_EXPERIENCE_INPUT}    Candidate Experience    ${task}
    Check element not display on screen     Please only use letters, spaces, dashes, and apostrophes    wait_time=5s
    Capture page screenshot

Check display of Date selection task on Candidate Experience screen in case Required toggle is ON
    Check error field displayed     Select a date     This Field is Required
    ${date} =   get_date
    Select date in candidate experience page    ${date}

Check display of Your full name task on Candidate Experience screen
    Check error field displayed     Your full name      First Name is Required
    ${candidate_info} =     Generate candidate name
    Input into      ${FORM_ITEM_ANSWER_FIRST_NAME_TEXTBOX}      ${candidate_info.first_name}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check error field displayed     Your full name      Last Name is Required
    Input into      ${FORM_ITEM_ANSWER_LAST_NAME_TEXTBOX}      ${candidate_info.last_name}
    Check element not display on screen     Last Name is Required       wait_time=5s
    Capture page screenshot

Check display of Work Experience with Maximum responses allowed more than one
    [Arguments]     ${limit}
    Click at    ${FORM_EXPERIENCE_ADD_ANOTHER_WORKPLACE_BUTTON}
    Check element exist on page     ${FORM_ITEM_FIELD}      Your Job title      limit=${limit}
    Check element exist on page     ${FORM_ITEM_FIELD}      Company name      limit=${limit}
    Check element exist on page     ${FORM_ITEM_FIELD}      Location      limit=${limit}
    Check element exist on page     ${FORM_ITEM_FIELD}      Date started      limit=${limit}
    Check element exist on page     ${FORM_ITEM_FIELD}      Date ended      limit=${limit}
    Check element exist on page     I Currently Work Here    limit=${limit}
    Capture page screenshot

Check display of Payroll Information on Candidate Experience when Payment Method is deleted
    [Arguments]    &{bank_info}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    Check element display on screen     Payroll Information
    Check bank title information displayed
    Input bank information for form     &{bank_info}

Check bank title information displayed
    Check element display on screen     ${FORM_QUESTION_LABEL}     Bank Name
    Check element display on screen     ${FORM_QUESTION_LABEL}     Routing Number
    Check element display on screen     ${FORM_QUESTION_LABEL}     Accounting Number
    Check element display on screen     ${FORM_QUESTION_LABEL}     Bank Account Type
    Capture page screenshot

Check bank title information not displayed
    Check element not display on screen    ${FORM_QUESTION_LABEL}     Bank Name     wait_time=5s
    Check element not display on screen    ${FORM_QUESTION_LABEL}     Routing Number     wait_time=1s
    Check element not display on screen    ${FORM_QUESTION_LABEL}     Accounting Number     wait_time=1s
    Check element not display on screen    ${FORM_QUESTION_LABEL}     Bank Account Type     wait_time=1s
    Capture page screenshot

Check the default display when location of Job NOT in must_show_paper_check_states
    Click on span text  Direct Deposit
    Check bank title information displayed
    Click on span text  Paycard
    Check bank title information not displayed
    Click on span text  Paper Check
    Check bank title information not displayed
    Click on span text  COD
    Check bank title information not displayed

Check display Bank Information of Payroll Information section at Review Candidate Experience screen when changing Payment Method
    [Arguments]    ${bank_info}
    Click on span text  Paycard
    Check bank title information not displayed
    Click on span text  Direct Deposit
    Check bank title information displayed
    Input bank information for form     &{bank_info}
    Click at    ${FORM_REVIEW_BUTTON}
