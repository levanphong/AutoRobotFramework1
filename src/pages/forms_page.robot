*** Settings ***
Library         ../utils/EmailServices.py
Resource        ../pages/base_page.robot
Variables       ../locators/forms_locators.py

*** Variables ***
${user_form}                        User
${candidate_form}                   Candidate
${job_family}                       Coffee Jobs
${location_user_form}               Florida

# menu tasks list
${address}                          Address
${custom_question}                  Custom question
${date_selection}                   Date selection
${display_text}                     Display text
${document_review}                  Document review
${document_upload}                  Document upload
${fillable_pdf}                     Fillable PDF
${resume_upload}                    Resume upload

# type dropdown list
${custom}                           Custom
${short_answer}                     Short Answer
${drop_down}                        Drop Down
${multi_choice}                     Multi Select
${paragraph}                        Paragraph
${checkbox}                         Single Select
${user_lookup}                      User Lookup
${location_lookup}                  Location Lookup

# Title tasks
${title_date_selection}             Select a date
${title_custom_question}            Custom question
${title_document_review}            Document_review_question
${title_document_upload}            Please_upload_your_document
${title_fillable_pdf}               Please_fill_this_form
${title_display_text}               Display_text_question
${title_resume_upload}              Please_upload_your_resume
${title_custom}                     Please_upload_your_document

# Toasted message
${delete_form_success}              Deleted form successfully
${your_change_saved}                Your change has been saved.
${your_change_published}            Your changes were published.

# Section name
${default_section}                  Default Section
${personal_information}             Personal Information
${work_experience}                  Work Experience
${payroll_information}              Payroll Information
${tax_withholding}                  Tax Withholding
${diversity_question}               Diversity Questions
${I9_part_II}                       I9 part II
${I9_part_III}                      I9 part III
${I_9}                              I-9

# form name
${paragraph_type_form}              Paragraph_type
${short_answer_type_form}           Short_answer_type
${checkbox_type_form}               Checkbox_type
${drop_down_type_form}              Drop_down_type
${multi_choice_type_form}           Multi choice type

#job name
${job_paragraph_user_form}          job_paragraph_user_form
${job_short_answer_user_form}       job_short_answer_user_form
${job_checkbox_user_form}           job_checkbox_user_form
${job_drop_down_user_form}          job_drop_down_user_form
${job_multi_choice_user_form}       job_multi_choice_user_form

*** Keywords ***
Select form type
    [Arguments]     ${form_type}
    IF  '${form_type}' == 'Candidate'
        Click at    ${CANDIDATE_FORM_TAB}
        wait until element is visible   ${CANDIDATE_FORM_TITLE}
    ELSE IF     '${form_type}' == 'User'
        Click at    ${USER_FORM_TAB}
        wait until element is visible   ${USER_FORM_TITLE}
    END

Check if form existed
	[Arguments]     ${form_name}
    Input into      ${SEARCH_FORM_TEXTBOX}      ${form_name}
    ${is_existed_form}=     Run Keyword And Return Status   Check element display on screen     ${FORM_BY_NAME}     ${form_name}
    IF  '${is_existed_form}' == 'True'
        Click at    ${form_name}
    END
	[Return]    ${is_existed_form}

Add new form and input name
    [Arguments]     ${form_type}    ${form_name}=None
    Select form type    ${form_type}
    IF  '${form_type}' == 'Candidate'
        Click at    ${NEW_CANDIDATE_FORM_BUTTON}
        wait for page load successfully
        IF  '${form_name}' == 'None'
            ${form_name}=   Generate random name    auto_form_candidate_
        END
    ELSE IF     '${form_type}' == 'User'
        Click at    ${NEW_USER_FORM_BUTTON}
        wait for page load successfully
        IF  '${form_name}' == 'None'
            ${form_name}=   Generate random name    auto_form_user_
        END
    END
    Input form name     ${form_name}
    [Return]    ${form_name}

Input form name
    [Arguments]     ${form_name}
    Click at    ${EDIT_FORM_NAME_ICON}
    Input into  ${FORM_NAME_TEXTBOX}    ${form_name}
    Press keys  None    RETURN
    wait_for_loading_icon_disappear
    Wait until element is visible       ${FORM_ADD_SECTION_BUTTON}
    wait with short time
    [Return]    ${form_name}

Add a form section
    [Arguments]     ${section_type}
    Click at        ${FORM_ADD_SECTION_BUTTON}
    Click at        ${FORM_ADD_SECTION_OPTION}   ${section_type}
    Wait until element is visible       ${FORM_HEADER_SECTION}

Add a form section with valid infor
    [Arguments]     ${task_type}
    Add a form section     ${task_type}
    IF  '${task_type}' == 'WOTC'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   WOTC title
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    WOTC content test form
    ELSE IF  '${task_type}' == 'I-9'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   I-9 title
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    I-9 content test form
    ELSE IF  '${task_type}' == 'Background Check'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   Background Check title
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    Background Check content test form
    ELSE IF  '${task_type}' == 'Tax Withholding'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   Tax Withholding title
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    Tax Withholding content test form
    ELSE IF  '${task_type}' == 'Diversity Questions'
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    EEO Voluntary Self-Identification content test form
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA_2}  EEO content test form
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA_3}  Voluntary Self-Identification of Disability content test form
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA_4}  How do I know if I have a disability? content test form
    ELSE IF  '${task_type}' == '${I9_part_II}'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   Paradox I9 Part II Title
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    Form I9 Part II
    ELSE IF  '${task_type}' == '${I9_part_III}'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   Paradox I9 Part II Title
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    Form I9 Part III
    ELSE IF  '${task_type}' == '${I_9}'
        Click at        ${EDIT_TITLE_NAME_ICON}
        Input into      ${TITLE_NAME_TEXTBOX}   I-9 Candidate
        Input into      ${FORM_CONTENT_SECTION_TEXTAREA}    I-9 Body Employment Eligibility Verification
    END
    Click at    ${FORM_SECTION_SAVE_BUTTON}

Delete a form with type
    [Arguments]     ${form_type}    ${form_name}
    Go to form page
    Search form in form list    ${form_type}    ${form_name}
    Click at    ${MENU_ICON_BY_FORM_NAME}   ${form_name}    1s
    Click at    ${DELETE_FORM_ICON}
    Check delete form confirm dialog is displayed   ${form_type}
    Click at    ${CONFIRM_DELETE_DIALOG_BUTTON}
    Verify text contain     ${TOASTED_MESSAGE_SUCCESS}    ${delete_form_success}
    Check element not display on screen     ${FORM_BY_NAME}     ${form_name}    wait_time=5s
    Capture page screenshot

Check delete form confirm dialog is displayed
    [Arguments]     ${form_type}
    Check span display      Delete ${form_type} Form
    Check p text display    Are you sure you want to do delete
    Check element display on screen     ${CANCEL_DIALOG_BUTTON}
    Check element display on screen     ${CONFIRM_DELETE_DIALOG_BUTTON}
    Capture page screenshot

Search form in form list
    [Arguments]     ${form_type}    ${form_name}
    Select form type    ${form_type}
    Input into      ${SEARCH_FORM_TEXTBOX}      ${form_name}
    Check element display on screen     ${FORM_BY_NAME}     ${form_name}
    Capture page screenshot

Go to a form section detail
    [Arguments]     ${section_name}
    Click at        ${section_name}     slow_down=1s
    Wait until element is visible       ${FORM_HEADER_SECTION}

Add a form task
    [Arguments]     ${task_type}
    Click at        ${FORM_ADD_TASK_BUTTON}
    Click at        ${FORM_ADD_TASK_OPTION}   ${task_type}

Upload a file with type
    [Arguments]     ${file_type}
    IF  '${file_type}' == 'PDF'
        ${path_image} =    get_path_upload_pdf_path    Authorization_for_Payroll_Deduction
    ELSE IF     '${file_type}' == 'Image'
        ${path_image} =    get_path_upload_image_path    cat-kute
    END
    ${element} =    Get Webelement    ${FORM_UPLOAD_FILE}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
    ...    ARGUMENTS    ${element}
    Input into    ${FORM_UPLOAD_FILE}    ${path_image}
    Check element display on screen     ${TOASTED_MESSAGE_SUCCESS}
    Verify text contain     ${TOASTED_MESSAGE_SUCCESS}     Your file was successfully uploaded

Add a form task with type
    [Arguments]     ${task_type}        ${question_name}=None
    Add a form task     ${task_type}
	IF     '${task_type}' == '${custom_question}'
	    IF      '${question_name}' == 'None'
	        Input into      ${LAST_QUESTION_NAME_TEXTBOX}   ${title_custom_question}
	    ELSE
	        Input into      ${LAST_QUESTION_NAME_TEXTBOX}   ${question_name}
	    END
	ELSE IF     '${task_type}' == '${display_text}'
	    Input task question title and content   ${title_display_text}       Display text question content
	ELSE IF     '${task_type}' == '${document_review}'
	    Input task question title   ${title_document_review}
	    Upload a file with type     Image
    ELSE IF     '${task_type}' == '${document_upload}'
        Input task question title and content   ${title_document_upload}      Document upload question content
    ELSE IF     '${task_type}' == '${fillable_pdf}'
        Input task question title   ${title_fillable_pdf}
        Upload a file with type     PDF
    ELSE IF     '${task_type}' == '${resume_upload}'
        Input task question title and content   ${title_resume_upload}       Resume upload question content
    ELSE IF     '${task_type}' == '${date_selection}'
        Input task question title   ${title_date_selection}
    END

Add a form task with type and save
    [Arguments]     ${task_type}
    Add a form task with type   ${task_type}
    Click save task

Click save task
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    Verify text contain     ${TOASTED_MESSAGE_SUCCESS}     ${your_change_saved}
    Capture page screenshot

Input task question title
    [Arguments]     ${question_title}
    Click at        ${EDIT_TITLE_NAME_ICON}
    Clear element text with keys    ${LAST_TITLE_NAME_TEXTBOX}
    Input into      ${LAST_TITLE_NAME_TEXTBOX}   ${question_title}

Input task question title and content
    [Arguments]     ${question_title}   ${question_content}
    Input task question title       ${question_title}
    Input into      ${FORM_CONTENT_SECTION_TEXTAREA_LAST}   ${question_content}

Check task is added successfully to section
    [Arguments]     ${section_name}     ${task_name}
    Go to a form section detail     ${section_name}
    IF  '${task_name}' == '${address}' or '${task_name}' == '${title_custom_question}'
        Check element display on screen     ${task_name}
    ELSE
        Scroll to element   ${LAST_TITLE_NAME_TEXTBOX}
        ${title_question}=  Get value and format text   ${LAST_TITLE_NAME_TEXTBOX}
        Should be equal as strings     ${title_question}    ${task_name}
    END
    Capture page screenshot

Verify UI Custom Question form display correctly
    [Arguments]     ${form_type}    ${question_name}    ${response_type}
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_DROPDOWN_BY_QUESTION_NAME}     ${question_name}
    # Verify dropdown value match with expected condition
    Verify attribute value equal with value   ${response_type}  ${QUESTION_RESPONSE_TYPE_DROPDOWN_BY_QUESTION_NAME}  ${question_name}
    Check element display on screen     ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name}
    # Verify checkbox is uncheck
    Verify attribute should not contain    class   is-checked  ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name}
    Check element display on screen     ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name}
    Verify attribute should not contain     class   is-checked  ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}  ${question_name}
	Check element display on screen     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name}
	Verify attribute should not contain     class   is-checked  ${REQUIRED_TOGGLE_BY_QUESTION_NAME}  ${question_name}
	IF  '${form_type}' == 'Candidate' and '${response_type}' == 'Short Anwser'
	    Check element display on screen     ${CHECKBOX_ADD_CONFIRMATION_FIELD_BY_QUESTION_NAME}     ${question_name}
	    Verify attribute should not contain    class   is-checked  ${CHECKBOX_ADD_CONFIRMATION_FIELD_BY_QUESTION_NAME}  ${question_name}
	ELSE IF     '${form_type}' == 'User'
	    IF    '${response_type}' == 'User Lookup' or '${response_type}' == 'Location Lookup'
            Check element display on screen     ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name}
            Verify attribute should not contain    class   is-checked  ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}  ${question_name}
	    END
	END
	Capture page screenshot

Verify UI Question form Response type dropdown display correctly
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${short_answer}
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${paragraph}
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${multi_choice}
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${checkbox}
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${drop_down}
    Capture page screenshot

Select task question response type
    [Arguments]     ${question_name}    ${response_type}
    Click at    ${QUESTION_RESPONSE_TYPE_DROPDOWN_BY_QUESTION_NAME}    ${question_name}
    Verify UI Question form Response type dropdown display correctly
    Click at    ${QUESTION_RESPONSE_TYPE_OPTION}    ${response_type}

Create new form has pdf file
    [Arguments]    ${form_type}     ${section_name}=Personal Information     ${digital_consent}=False     ${form_name}=None
    ${form_name}=   Add new form and input name     ${form_type}    ${form_name}
    Go to a form section detail     ${section_name}
    Add a form task    Fillable PDF
    Upload a file with type     PDF
    Check span display      Authorization_for_Payroll_Deduction.pdf
    Click at    ${EDIT_TITLE_NAME_ICON}
    Input into  ${FORM_DOCUMENT_NAME}   TAX_DOCUMENT
    IF  '${digital_consent}' == 'True'
        Click by JS    ${ELLIPSES_ICON_BY_QUESTION_NAME}   TAX_DOCUMENT
        Click at    ${FORM_ADD_DIGITAL_CONSENT_ICON}
    END
    Click at    ${FORM_SECTION_SAVE_BUTTON}
    wait for page load successfully
    Click at    ${FORM_STATUS_BAR_BUTTON}
    Click at    ${FORM_PUBLISH_BUTTON}
    [Return]    ${form_name}

Enter code for verify code step
    [Arguments]    ${candidate_name}
    ${content} =    format string    Hi {},    ${candidate_name}
    ${verify_code} =    get verify code in email    Verification Code    ${content}     VERIFICATION_CODE   -
    wait with medium time
    @{code_list}=  conver string to list  ${verify_code}
    FOR  ${Index}  IN RANGE  6
           ${locator_code}=  format string   ${CODE_INPUT}  ${Index+1}
           ${value_code}=  get from list  ${code_list}  ${Index}
           Input into  ${locator_code}  ${value_code}
    END
    wait for page load successfully

Create new user form
    [Arguments]     ${section_name}   ${task_name}      ${title_task}
    Go to form page
    ${form_name} =      Add new form and input name     User
    Go to a form section detail     ${section_name}
    Add a form task with type       ${task_name}
    Click save task
    Check task is added successfully to section     ${section_name}      ${title_task}
    [Return]    ${form_name}

Click publish form
	${is_published}=    Run keyword and Return Status    Check element display on screen    ${FORM_PUBLISHED_STATUS}    wait_time=2s
	IF  '${is_published}' == 'False'
	    Click at    ${FORM_STATUS_BAR_BUTTON}
	    Click at    ${FORM_PUBLISH_BUTTON}
	    Verify text contain     ${TOASTED_MESSAGE_SUCCESS}    ${your_change_published}
	    Check span display     Published
	END

Delete form task of section
    [Arguments]     ${section}   ${title_task}
    Go to a form section detail     ${section}
    Click at  ${ELLIPSES_ICON_BY_QUESTION_NAME}     ${title_task}
    Click at  ${DELETE_CUSTOM_QUESTION_ICON}
    Click save task

Edit a form with type
    [Arguments]     ${form_type}    ${form_name}
    Go to form page
    Search form in form list    ${form_type}    ${form_name}
    Click at    ${MENU_ICON_BY_FORM_NAME}   ${form_name}    1s
    Click at    ${EDIT_FORM_ICON}
    wait for page load successfully

Check cannot delete form confirm dialog is displayed
    Check span display      Form Cannot Be Deleted
    Check element display on screen    This item cannot be deleted
    Check span display      Back
    Capture page screenshot

Create paragraph type form
    Go to form page
    Add new form and input name     ${user_form}     ${paragraph_type_form}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Select task question response type      ${title_custom_question}      ${paragraph}
    Check the checkbox      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${title_custom_question}
    Check the checkbox      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${title_custom_question}
    Turn on     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}        ${title_custom_question}
    Click save task
    Click publish form

Create short answer type form
    Go to form page
    Add new form and input name     ${user_form}    ${short_answer_type_form}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Click at    ${ELLIPSES_ICON_BY_QUESTION_NAME}     ${title_custom_question}
    Click at    ${ADD_VALIDATE_ICON}
    Click at    ${VALIDATION_DROPDOWN_BY_QUESTION_NAME}     ${title_custom_question}
    Click at    ${VALIDATION_DROPDOWN_OPTION}     Text
    Check the checkbox      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${title_custom_question}
    Check the checkbox      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${title_custom_question}
    Turn on     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}        ${title_custom_question}
    Click save task
    Click publish form

Create checkbox type form
    Go to form page
    Add new form and input name     ${user_form}     ${checkbox_type_form}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Select task question response type      ${title_custom_question}      ${checkbox}
    Input your question value and publish form      Checkbox 1      Checkbox 2

Create drop down type form
    Go to form page
    Add new form and input name     ${user_form}       ${drop_down_type_form}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Select task question response type      ${title_custom_question}      ${drop_down}
    Input your question value and publish form      Drop down 1      Drop down 2

Create multi choice type form
    Go to form page
    Add new form and input name     ${user_form}    ${multi_choice_type_form}
    Go to a form section detail     ${default_section}
    Add a form task with type       ${custom_question}
    Select task question response type      ${title_custom_question}      ${multi_choice}
    Input your question value and publish form      Radio button 1      Radio button 2

Input your question value and publish form
    [Arguments]     ${option_1}    ${option_2}
    Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
    Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       ${option_1}     ${title_custom_question}
    Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}   ${option_2}    ${title_custom_question}
    Check the checkbox      ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${title_custom_question}
    Check the checkbox      ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${title_custom_question}
    Turn on     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}        ${title_custom_question}
    Click save task
    Click publish form

Duplicate a Form
    [Arguments]    ${form_name}     ${form_type}=Candidate
    Search form in form list    ${form_type}    ${form_name}
    Click at  ${MENU_ICON_BY_FORM_NAME}  ${form_name}
    Click at  ${DUPLICATE_FORM_ICON}
    Input into  ${SEARCH_FORM_TEXTBOX}  Copy - ${form_name}
    Check element display on screen  Copy - ${form_name}
    wait_for_loading_icon_disappear
    [Return]    Copy - ${form_name}

Change status of candidate to Send Form
    [Arguments]     ${candidate_name}
    Click at        ${candidate_name}
    Click at        ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click on common text last       More Option
    Click at        ${CEM_CANDIDATE_JOURNEY_FORM_STATUS}
    Click on common text last       Send Form
    Click on common text last       Confirm

Go to Candidate Experience page of Form
    [Arguments]     ${candidate_name}   ${form_name}
    Go to CEM page
    Switch to user      ${TEAM_USER}
    Click at        ${candidate_name}
    Click on common text last   ${form_name}

Input all valid information into candidate form
    [Arguments]     ${is_spam_email}=True    ${is_required_phone}=True
    IF      ${is_required_phone}
        Input into      ${FORM_PHONE_NUMBER_TEXTBOX}    ${CONST_PHONE_NUMBER}
    END
    IF      ${is_spam_email}
        &{email_info} =    Get email for testing    ${is_spam_email}
        Input into      ${FORM_EMAIL_ADDRESS_TEXTBOX}    ${email_info.email}
    END
    Input into      ${FORM_STREET_ADDRESS_LINE_1_TEXTBOX}   420 Nguyen Huu Tho
    Input into      ${FORM_CITY_TEXTBOX}    Da Nang
    Input into      ${FORM_STATE_TEXTBOX}   Arizona
    Input into      ${FORM_ZIPCODE_TEXTBOX}     85043

Input all valid information into fillable pdf form
    Select Frame  ${FRAME_PDF_FILLABLE}
    &{candidate_name}=  Generate candidate name
    Input into  ${FORM_FILLABLE_PDF_INPUT_NAME}     ${candidate_name.full_name}
    Input into  ${FORM_FILLABLE_PDF_INPUT_SS}       Information Test
    Input into  ${FORM_FILLABLE_PDF_INPUT_DATE}     Date Test
    Input into  ${FORM_FILLABLE_PDF_INPUT_SIGNATURE}  Name signature
    Unselect Frame
    Click at  ${FORM_FILLABLE_PDF_READY_SUBMIT_CHECKBOX}
    Click at  ${FORM_FILLABLE_PDF_SUBMIT_FORM_BUTTON}

Delete digital consent
    Check element display on screen     ${ELLIPSES_ICON_DIGITAL_CONSENT}
    Click by JS    ${ELLIPSES_ICON_DIGITAL_CONSENT}
    Click at    ${DELETE_CUSTOM_QUESTION_ICON}

Add custom task for candidate form
    [Arguments]     ${task_type}
    Add a form section      ${custom}
    Add a form task with type   ${custom_question}
    Select task question response type      ${title_custom_question}      ${task_type}
    IF  '${task_type}' == '${multi_choice}' or '${task_type}' == '${checkbox}' or '${task_type}' == '${drop_down}'
        Click at    ${FORM_ADD_OPTION_YOUR_QUESTION_BUTTON}
        Input into  ${FORM_TYPE_YOUR_QUESTION_INPUT}       option 1     ${title_custom_question}
        Input into  ${FORM_LAST_TYPE_YOUR_QUESTION_INPUT}  option 2     ${title_custom_question}
    END
    Click save task

Delete a task form
    [Arguments]     ${task_name}
    Click by JS    ${FORM_DELETE_TASK_ICON}    ${task_name}
    Click at    ${CONFIRM_DELETE_DIALOG_BUTTON}
    Wait for page load successfully
    Check element not display on screen     ${FORM_DELETE_TASK_ICON}    ${task_name}

Check error field displayed
    [Arguments]     ${item_locator}      ${error}
    Check element display on screen     ${FORM_ITEM_LABEL_ERROR}      ${item_locator}
    ${text} =    Get text and format text   ${FORM_ITEM_LABEL_ERROR}      ${item_locator}
    Should Contain    ${text}   ${error}
    Capture page screenshot

Select date in candidate experience page
    [Arguments]     ${date}
    Click at    ${FORM_EXPERIENCE_SELECT_DATE}
    Click at    ${FORM_EXPERIENCE_DATE_TO_SELECT}   ${date}

Select date confirmation in candidate experience page
    [Arguments]     ${date}
    Click at    ${FORM_EXPERIENCE_DATE_CONFIRMATION_SELECT}
    Click at    ${FORM_EXPERIENCE_DATE_CONFIRM_TO_SELECT}   ${date}

Change status to send form and open form
    [Arguments]     ${candidate_name}   ${company_name}
    Change status of candidate to Send Form     ${candidate_name}
    Click button in email    Complete your form at ${company_name}      Hi ${candidate_name}!   COMPLETE_ASSESSMENT
    Enter code for verify code step   ${candidate_name}

Check hire details form information display on screeen
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     First Name
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Middle Initial
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Last Name
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Phone number
    Check element display on screen     ${CEM_CANDIDATE_FORM_TITLE}     Email address
    Capture page screenshot

Select required field for Diversity Questions
    Click at    ${FORM_EXPERIENCE_OPTION_SELECT}    Ethnicity
    Click at    ${FORM_DIVERSITY_SECTION_RADIO_ANSWER_BY_NAME}    Native American
    Click at    ${FORM_DIVERSITY_SECTION_APPLY_BUTTON}
    Click by JS    ${FORM_DIVERSITY_SECTION_RADIO_BUTTON_BY_NAME}    Female
    Click at    ${FORM_EXPERIENCE_OPTION_SELECT}    Marital Status
    Click at    ${FORM_DIVERSITY_SECTION_RADIO_ANSWER_BY_NAME}      Single
    Click at    ${FORM_DIVERSITY_SECTION_APPLY_BUTTON}
    Click by JS    ${FORM_DIVERSITY_SECTION_RADIO_BUTTON_BY_NAME}    I do not wish to answer
    Capture page screenshot

Input bank information for form
    [Arguments]     &{bank_info}
    Input into      ${FORM_EXPERIENCE_INPUT}    ${bank_info.bank_name}      Bank Name
    Input into      ${FORM_EXPERIENCE_INPUT}    ${bank_info.routing_number}      Routing Number
    Input into      ${FORM_EXPERIENCE_INPUT}    ${bank_info.accounting_number}      Accounting Number
    Click at    ${FORM_EXPERIENCE_BANK_ACCOUNT_SELECT}
    Click on common text last   ${bank_info.bank_account_type}

Check bank information displayed correctly in review page
    [Arguments]     ${bank_info}
    Check span display      ${bank_info.bank_name}
    Check span display      ${bank_info.routing_number}
    Check span display      ${bank_info.accounting_number}
    Check span display      ${bank_info.bank_account_type}
    Capture page screenshot

Fill work experience for form
    [Arguments]     ${history}   ${work_experience}
    Input into      ${FORM_EXPERIENCE_JOB_TITLE_ANSWER}      ${work_experience.your_job_title}      ${history}
    Input into      ${FORM_EXPERIENCE_COMPANY_NAME_ANSWER}      ${work_experience.company_name}     ${history}
    Input into      ${FORM_EXPERIENCE_JOB_LOCATION_ANSWER}      ${work_experience.location}     ${history}
    ${locator_date_select} =    Format String       ${FORM_EXPERIENCE_JOB_DATE_SELECT}   ${history}     Date started
    ${locator_date_input} =    Format String       ${FORM_EXPERIENCE_JOB_DATE_INPUT}   ${history}   Date started
    Click at    ${locator_date_select}
    Input into      ${locator_date_input}      ${work_experience.date_started}
    Press Keys    ${locator_date_input}    TAB
    ${locator_date_select} =    Format String       ${FORM_EXPERIENCE_JOB_DATE_SELECT}   ${history}     Date ended
    ${locator_date_input} =    Format String       ${FORM_EXPERIENCE_JOB_DATE_INPUT}   ${history}   Date ended
    Click at    ${locator_date_select}
    Input into      ${locator_date_input}      ${work_experience.date_end}
    Press Keys    ${locator_date_input}    TAB

Check display of Gear Icon menu
    Check element display on screen     ${ADD_VALIDATE_ICON}
    Check element display on screen     ${FIELD_MAPPING_ICON}
    Check element display on screen     ${DUPLICATE_CUSTOM_QUESTION_ICON}
    Check element display on screen     ${DELETE_CUSTOM_QUESTION_ICON}
    Capture page screenshot

Check display of Gear Icon menu after adding field mapping
    [Arguments]      ${field_mapping}   ${is_full_name}=False
    Click at     ${FORM_MAPPING_MODAL_SOURCE_FIELD}
    IF  '${is_full_name}' == 'True'
        Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION_SELECTED}   Last name
    ELSE
        Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION_SELECTED}   ${field_mapping.source_field}
    END
    Capture page screenshot
    Click at     ${FORM_MAPPING_MODAL_SOURCE_FIELD}
    Click at    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE}
    Check element display on screen    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE_OPTION_SELECTED}   ${field_mapping.sys_attr_value}
    Capture page screenshot
    Click at    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE}
    Verify attribute should contain     value    ${field_mapping.destination_field}    ${FORM_MAPPING_MODAL_DESTINATION_FIELD}
    Capture page screenshot
    Click at    ${FORM_MAPPING_MODAL_REMOVE_BUTTON}

Check display of Field Mapping
    Check element display on screen     ${FORM_MAPPING_FIELD_MODAL}
    Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD}
    Check element display on screen     ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE}
    Check element display on screen     ${FORM_MAPPING_MODAL_DESTINATION_FIELD}
    Capture page screenshot

Check display of Source field
    [Arguments]     ${information}=None
    Click at     ${FORM_MAPPING_MODAL_SOURCE_FIELD}
    Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Select
    Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Free text
    IF  '${information}' != 'None'
        Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   First name
        Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Last name
        Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Phone number
        Check element display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Email address
    ELSE
        Check element not display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   First name      wait_time=5s
        Check element not display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Last name      wait_time=1s
        Check element not display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Phone number      wait_time=1s
        Check element not display on screen     ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Email address      wait_time=1s
    END
    Capture page screenshot

Select one system attribute in field mapping
    [Arguments]     ${attribute_type}   ${attribute_value}
    Click at    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE}
    Click on common text last    ${attribute_type}
    Click at    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE_OPTION}   ${attribute_value}
    Capture page screenshot

Fill anwser for custom question
    [Arguments]     ${question_name}    ${answer}    ${confirmation}=False
    Input into      ${FORM_ANSWER_TEXTBOX_BY_QUESTION_NAME}     ${answer}       ${question_name}
    IF  '${confirmation}' == 'True'
        Input into      ${FORM_CONFIRMATION_ANSWER_TEXTBOX_BY_QUESTION_NAME}    ${answer}     ${question_name}
    END

Remove field mapping
    [Arguments]     ${task}
    Click at    ${FORM_MAPPING_ICON_ATS_MAP}   ${task}
    Click at    ${FORM_MAPPING_MODAL_REMOVE_BUTTON}
    Check element not display on screen     ${FORM_MAPPING_ICON_ATS_MAP}   ${task}      wait_time=5s
    Capture page screenshot

Check default display of Field Mapping
    Verify attribute should contain     value    ${EMPTY}    ${FORM_MAPPING_MODAL_SOURCE_FIELD_INPUT}
    Verify attribute should contain     value    ${EMPTY}    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE_INPUT}
    Verify attribute should contain     value    ${EMPTY}    ${FORM_MAPPING_MODAL_DESTINATION_FIELD}

Enter field mapping information
    [Arguments]     ${field_mapping}    ${is_full_name}=False
    Click at     ${FORM_MAPPING_MODAL_SOURCE_FIELD}
    IF  '${is_full_name}' == 'True'
        Click at    ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   Last name
    ELSE
        Click at    ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   ${field_mapping.source_field}   # Select Free text option
    END
    Input into      ${FORM_MAPPING_MODAL_DESTINATION_FIELD}     ${field_mapping.destination_field}
    Select one system attribute in field mapping    ${field_mapping.sys_attr_menu}    ${field_mapping.sys_attr_value}
    Click at    ${FORM_MAPPING_MODAL_SAVE_BUTTON}

Check work experience field mapping after adding
    [Arguments]      ${task}    ${field_mapping}    ${task_index}
    Click at    ${FORM_MAPPING_ICON_ATS_MAP}   ${task}
    Click at     ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
    Verify attribute should contain     value    ${field_mapping.source_field}    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_INPUT}
    Capture page screenshot
    Click at     ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
    Click at    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE}
    Verify attribute should contain     placeholder    ${field_mapping.sys_attr_value}    ${FORM_MAPPING_MODAL_SYSTEM_ATTRIBUTE_INPUT}
    Capture page screenshot
    Click at    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
    Verify attribute should contain     value    ${field_mapping.destination_field}    ${FORM_MAPPING_MODAL_ATS_DESTINATION_FIELD}
    Capture page screenshot
    Click at    ${FORM_MAPPING_FIELD_ATS_MODAL_CANCEL_BUTTON}   ${task_index}

Add candidate and open form
    [Arguments]     ${company_name}      ${user}    ${location_name}     ${job_name}
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Switch to user      ${user}
    ${candidate_name} =    Add a Candidate   location_name=${location_name}  job_name=${job_name}   is_spam_email=False
    Change status to send form and open form    ${candidate_name}       ${company_name}
    [Return]    ${candidate_name}

Check Digital Consent popup is diplayed
    Check span display      ${DIGITAL_CONSENT_TITLE}
    Check text display    ${DIGITAL_CONSENT_MESSAGE_1}
    Check text display    ${DIGITAL_CONSENT_MESSAGE_2}
    Check text display    ${DIGITAL_CONSENT_MESSAGE_3}
    Check element display on screen     ${FORM_DIGITAL_CONSENT_BUTTON_CANCEL}
    Check element display on screen     ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}
    Capture page screenshot

Check Action Required popup is displayed
    [Arguments]     ${form_name}
    Check span display      Action Required
    ${action_required_text}=    format string   ${FORM_REQUIRED_ACTION_MESSAGE}     ${form_name}
    Check p text display    ${action_required_text}
    Check element display on screen     ${FORM_DIGITAL_CONSENT_BUTTON_EXIT_FORM}
    Check element display on screen     ${FORM_DIGITAL_CONSENT_BUTTON_REVIEW_CONSENT}
    Capture page screenshot

Check Digital Consent popup is not diplayed
    ${digital_consent_title_locator}=   Format string   ${COMMON_SPAN_TEXT}     ${DIGITAL_CONSENT_TITLE}
    Check element not display on screen     ${digital_consent_title_locator}    wait_time=5s
    ${digital_consent_messsage_1}=  format string   ${COMMON_P_TEXT}    ${DIGITAL_CONSENT_MESSAGE_1}
    Check element not display on screen     ${digital_consent_messsage_1}       wait_time=2s
    ${digital_consent_messsage_2}=  format string   ${COMMON_P_TEXT}    ${DIGITAL_CONSENT_MESSAGE_2}
    Check element not display on screen     ${digital_consent_messsage_2}       wait_time=2s
    ${digital_consent_messsage_3}=  format string   ${COMMON_P_TEXT}    ${DIGITAL_CONSENT_MESSAGE_3}
    Check element not display on screen     ${digital_consent_messsage_3}       wait_time=2s
    Check element not display on screen     ${FORM_DIGITAL_CONSENT_BUTTON_CANCEL}       wait_time=2s
    Check element not display on screen     ${FORM_DIGITAL_CONSENT_BUTTON_AGREE}        wait_time=2s
    Capture page screenshot

Seting mapping for a field
    [Arguments]     ${question_name}    ${sys_attribute_value}      ${source_field}=None      ${sys_attribute_name}=None
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${question_name}
    Click at    ${FIELD_MAPPING_ICON}
    IF     '${source_field}'!='None'
        Click by JS    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_OPTION}     ${source_field}
    ELSE
        Click by JS    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_OPTION}     Free text
    END
    IF     '${sys_attribute_name}'!='None'
        Select one system attribute in field mapping    ${sys_attribute_name}     ${sys_attribute_value}
    ELSE
        Select one system attribute in field mapping    Standard Candidate Attributes     ${sys_attribute_value}
    END
    Click at    ${FORM_MAPPING_MODAL_SAVE_BUTTON}
    Check element not display on screen     ${FORM_MAPPING_FIELD_MODAL}     wait_time=5s
    Check element display on screen     ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}       ${question_name}

Set mapping field at Personal Information in form
    [Arguments]     ${form_type}    ${form_name}
    go to form page
    Search form in form list    ${form_type}    ${form_name}
    Click at    ${FORM_BY_NAME}     ${form_name}
    wait for page load successfully v1
    Go to a form section detail     Personal Information
    Seting mapping for a field      Street address (Line 1)     Street Address
    Seting mapping for a field      City        City
    Seting mapping for a field      State       State
    Seting mapping for a field      ZIP code        Zip Code
    Click save task
    Click publish form

Add languages for form
    [Arguments]     @{languages}
    Click at    ${FORM_MULTILINGUAL_ICON}
    Click at    ${FORM_MULTILINGUAL_CONFIG_LANGUAGES_BUTTON}
    FOR     ${language}    IN    @{languages}
        Click at    ${FORM_MULTILINGUAL_LANGUAGE_CHECKBOX}      ${language}
    END
    Click at    ${FORM_MULTILINGUAL_LANGUAGE_APPLY_BUTTON}
    Click at    ${FORM_MULTILINGUAL_CONFIRM_ADD_LANGUAGE_BUTTON}

Open Completion Tracking Pixel Popup
    Click at    ${FORM_SETTING_ICON}
    Click at    ${FORM_ADD_TRACKING_PIXEL_ICON}

Input text into Completion Tracking Pixel popup
    [Arguments]     ${text}
    Click at    ${FORM_ADD_TRACKING_PIXEL_CONTENT_PRESENTATION}
    Clear element text with keys      None
    Press keys      None    ${text}
    Click at    ${FORM_ADD_TRACKING_PIXEL_SAVE_BUTTON}

Create Custom Question task type with answer type
    [Arguments]      ${answer_type}      ${question_name}=None      ${section}=None
    IF      '${section}' != 'None'
        Go to a form section detail     ${section}
    END
    IF    '${question_name}' == 'None'
        Add a form task with type       ${custom_question}
        Click at    ${QUESTION_RESPONSE_TYPE_DROPDOWN_BY_QUESTION_NAME}     ${custom_question}
    ELSE
        Add a form task with type       ${custom_question}      ${question_name}
        Click at    ${QUESTION_RESPONSE_TYPE_DROPDOWN_BY_QUESTION_NAME}    ${question_name}
    END
    Verify UI Question form Response type dropdown display correctly
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${user_lookup}
    Check element display on screen     ${QUESTION_RESPONSE_TYPE_OPTION}    ${location_lookup}
    Capture Page Screenshot
    Click at    ${QUESTION_RESPONSE_TYPE_OPTION}    ${answer_type}
    Click save task
    [Return]    ${question_name}

Duplicate a Custom Question
    [Arguments]    ${question_name}     ${answer_type}      ${section}
    Go to a form section detail     ${section}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${question_name}
    Check element display on screen     ${DUPLICATE_CUSTOM_QUESTION_ICON}
    Check element display on screen     ${DELETE_CUSTOM_QUESTION_ICON}
    Capture page screenshot
    Click at    ${DUPLICATE_CUSTOM_QUESTION_ICON}
    Input into      ${LAST_QUESTION_NAME_TEXTBOX}  Copy - ${question_name}
    Check element display on screen  Copy - ${question_name}
    wait_for_loading_icon_disappear
    Click save task
    [Return]    Copy - ${question_name}

Verify UI Custom Question task display correctly with element is checked
    [Arguments]     ${form_type}    ${question_name}    ${response_type}
    Verify attribute value equal with value   ${response_type}  ${QUESTION_RESPONSE_TYPE_DROPDOWN_BY_QUESTION_NAME}  ${question_name}
    Check element display on screen     ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name}
    Verify attribute should contain    class   is-checked  ${CHECKBOX_SENSITIVE_BY_QUESTION_NAME}      ${question_name}
    Check element display on screen     ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}      ${question_name}
    Verify attribute should contain     class   is-checked  ${CHECKBOX_HIDE_FROM_MANAGER_BY_QUESTION_NAME}  ${question_name}
    Check element display on screen     ${REQUIRED_TOGGLE_BY_QUESTION_NAME}     ${question_name}
    Verify attribute should contain     class   is-checked  ${REQUIRED_TOGGLE_BY_QUESTION_NAME}  ${question_name}
    IF     '${form_type}' == 'User'
        IF    '${response_type}' == 'User Lookup' or '${response_type}' == 'Location Lookup'
            Check element display on screen     ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}     ${question_name}
            Verify attribute should contain    class   is-checked  ${CHECKBOX_ALLOW_MULTI_SELECT_BY_QUESTION_NAME}  ${question_name}
        END
    END
    Capture Page Screenshot

Delete a Custom Question
    [Arguments]     ${section}   ${title_task}
    Go to a form section detail     ${section}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${title_task}
    Click at    ${DELETE_CUSTOM_QUESTION_ICON}
    Click save task

Fill data for Field Mapping in Task
    [Arguments]     ${question_name}    ${type}     ${answer_type}     ${system_attribute_info}=None    ${default_choose}=None
    IF    '${type}' == 'Source field'
        Click At    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
        Check Text Display    Free text
        Click At    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_OPTION}    Free text
    ELSE IF    '${type}' == 'System Attribute' and "${system_attribute_info}" != 'None'
        Select one system attribute in field mapping    ${system_attribute_info.sys_attr_menu}    ${system_attribute_info.sys_attr_value}
    ELSE IF     '${type}' == 'Store Attribute' and '${answer_type}' == 'Location Lookup'
        Click At    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE}
        Check Text Display    Location ID
        Check Text Display    Location Address
        Check Text Display    Location Name
        Click At    ${default_choose}
    ELSE IF     '${type}' == 'Store Attribute' and '${answer_type}' == 'User Lookup'
        Click At    ${FORM_MAPPING_MODAL_STORE_ATTRIBUTE}
        Check Text Display    User ID
        Check Text Display    User Email
        Check Text Display    User Name
        Click At    ${default_choose}
    ELSE IF     '${type}' == 'Destination Field'
        Input Into    ${FORM_MAPPING_MODAL_ATS_DESTINATION_FIELD}       auto_destination
    END
    Click At    ${FORM_MAPPING_MODAL_SAVE_BUTTON}
    Check Element Not Display On Screen    ${TASK_MAPPING_FIELD_MODAL}  wait_time=5s
    Check Element Display On Screen         ${FORM_MAPPING_ICON_ATS_MAP}    ${question_name}
