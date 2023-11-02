*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

Force Tags          advantage    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test   skip
#   https://paradoxai.atlassian.net/browse/OL-73528

*** Variables ***
${new_date_selection_title}         Select_a_date
${payment_method}                   Payment Method
${bank_name}                        Bank Name
${rounting_number}                  Routing Number
${accounting_number}                Accounting Number
${bank_account_type}                Bank Account Type
${ethnicity}                        Ethnicity
${gender}                           Gender
${marital_status}                   Marital Status
${please_provide_answer_below}      Please provide an answer below
${email_address}                    Email address
${full_name}                        Your full name
${phone_number}                     Phone number
${street_address_line_1}            Street address (Line 1)
${your_full_name}                   full
${your_job_title}                   Your Job title
${company_name}                     Company name
${location}                         Location
${date_started}                     started
${date_ended}                       ended
&{field_mapping_info}               source_field=Free text    sys_attr_menu=Standard Candidate Attributes    sys_attr_value=Candidate First Name    destination_field=auto_destination

*** Test Cases ***
Candidate Form - Check that CAN setting Field mapping for Date selection task at New Form screen (OL-T14352, OL-T14401)
    [Tags]    skip
    # TODO https://paradoxai.atlassian.net/browse/OL-71143
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     Candidate
    Add a form section      ${custom}
	Go to a form section detail     ${custom}
    Add a form task with type       ${date_selection}
    Input task question title       ${new_date_selection_title}
    Add a form task with type and save       ${custom_question}
    Go to a form section detail     ${custom}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${new_date_selection_title}
    Check display of Gear Icon menu
    Click at    ${FIELD_MAPPING_ICON}
    Check user CAN setting Field mapping    ${new_date_selection_title}   ${field_mapping_info}
    Go to a form section detail     ${custom}
    Check displayed of Field mapping after adding       ${new_date_selection_title}       ${field_mapping_info}
    #   [Candidate Form] - Check that CAN setting [Field mapping] for [Custom Question] (OL-T14401)
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${title_custom_question}
    Check display of Gear Icon menu
    Click at    ${FIELD_MAPPING_ICON}
    Check user CAN setting Field mapping    ${title_custom_question}   ${field_mapping_info}
    Go to a form section detail     ${custom}
    Check displayed of Field mapping after adding       ${title_custom_question}       ${field_mapping_info}
    Delete a form with type     ${candidate_form}    ${form_name}


User Form - Check that CAN setting Field mapping for Date selection task at New Form screen (OL-T14424, OL-T14442)
    [Tags]    skip
    # TODO https://paradoxai.atlassian.net/browse/OL-71143
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     User
	Go to a form section detail     ${default_section}
    Add a form task with type       ${date_selection}
    Input task question title       ${new_date_selection_title}
    Add a form task with type and save       ${custom_question}
    Go to a form section detail     ${default_section}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${new_date_selection_title}
    Check display of Gear Icon menu
    Click at    ${FIELD_MAPPING_ICON}
    Check user CAN setting Field mapping    ${new_date_selection_title}   ${field_mapping_info}
    Go to a form section detail     ${default_section}
    Check displayed of Field mapping after adding       ${new_date_selection_title}       ${field_mapping_info}
    #   [User Form] - Check that CAN setting [Field mapping] for [Custom Question] (OL-T14402)
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${title_custom_question}
    Check display of Gear Icon menu
    Click at    ${FIELD_MAPPING_ICON}
    Check user CAN setting Field mapping    ${title_custom_question}   ${field_mapping_info}
    Go to a form section detail     ${default_section}
    Check displayed of Field mapping after adding       ${title_custom_question}       ${field_mapping_info}
    Delete a form with type     ${user_form}    ${form_name}


Check that CAN setting Field mapping for Accounting Number task of Payroll Information section at New Form screen (OL-T14096, OL-T14111, OL-T14066, OL-T14053, OL-T14081)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     Candidate
    Add a form section      ${payroll_information}
    Click save task
	Go to a form section detail     ${payroll_information}
	Add a form task with type and save       ${custom_question}
	#   Check that CAN setting [Field mapping] for [Payment Method] task of [Payroll Information] section at [New Form] screen (OL-T14053)
    Check that CAN setting Field mapping for task of Payroll Information    ${payroll_information}      ${payment_method}     ${field_mapping_info}    payment_method
    #   Check that CAN setting [Field mapping] for [Bank Name] task of [Payroll Information] section at [New Form] screen (OL-T14066)
    Check that CAN setting Field mapping for task of Payroll Information    ${payroll_information}      ${bank_name}     ${field_mapping_info}    bank_name
    #   Check that CAN setting [Field mapping] for [Routing Number] task of [Payroll Information] section at [New Form] screen (OL-T14081)
    Check that CAN setting Field mapping for task of Payroll Information    ${payroll_information}      ${rounting_number}     ${field_mapping_info}    bank_routing_number
    #   Check that CAN setting [Field mapping] for [Accounting Number] task of [Payroll Information] section at [New Form] screen (OL-T14096)
    Check that CAN setting Field mapping for task of Payroll Information    ${payroll_information}      ${accounting_number}     ${field_mapping_info}    bank_account_number
    #   Check that CAN setting [Field mapping] for [Bank Account Type] task of [Payroll Information] section at [New Form] screen (OL-T14111)
    Check that CAN setting Field mapping for task of Payroll Information    ${payroll_information}      ${bank_account_type}     ${field_mapping_info}    bank_account_type
    Go to a form section detail     ${payroll_information}
    #   OL-T14053
    Check displayed of Field mapping after adding   ${payment_method}       ${field_mapping_info}
    #   OL-T14066
    Check displayed of Field mapping after adding   ${bank_name}       ${field_mapping_info}
    #   OL-T14081
    Check displayed of Field mapping after adding   ${rounting_number}       ${field_mapping_info}
    #   OL-T14096
    Check displayed of Field mapping after adding   ${accounting_number}       ${field_mapping_info}
    #   OL-T14111
    Check displayed of Field mapping after adding   ${bank_account_type}       ${field_mapping_info}
    Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN setting Field mapping for Ethnicity task (OL-T13850, OL-T13863, OL-T13876, OL-T13895)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     Candidate
    Add a form section with valid infor     ${diversity_question}
    Go to a form section detail     ${diversity_question}
	Add a form task with type and save       ${custom_question}
    Go to a form section detail     ${diversity_question}
    #   (OL-T13850)
    Check that CAN setting Field mapping diversity question     ${ethnicity}     ${field_mapping_info}
    #   Check that CAN setting [Field mapping] for [Gender] task (OL-T13863)
    Check that CAN setting Field mapping diversity question     ${gender}     ${field_mapping_info}
    #   Check that CAN setting [Field mapping] for [Marital Status] task (OL-T13876)
    Check that CAN setting Field mapping diversity question     ${marital_status}     ${field_mapping_info}
    #   Check that CAN setting [Field mapping] for [Please provide an answer below] task (OL-T13895)
    Check that CAN setting Field mapping diversity question     ${please_provide_answer_below}     ${field_mapping_info}
    Delete a form with type     ${candidate_form}    ${form_name}


Check CAN remove and re-add field mapping on Accounting Number task of Payroll Information section at New Form screen (OL-T14098, OL-T14068, OL-T14083)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     Candidate
    Add a form section      ${payroll_information}
    Click save task
	Go to a form section detail     ${payroll_information}
	Add a form task with type and save       ${custom_question}
    #   OL-T14098
    Check CAN remove and re-add field mapping on task of Payroll Information section    ${accounting_number}
    #   Check CAN remove and re-add field mapping on [Bank Name] task of [Payroll Information] section at [New Form] screen (OL-T14068)
    Check CAN remove and re-add field mapping on task of Payroll Information section    ${bank_name}
    #   Check CAN remove and re-add field mapping on [Routing Number] task of [Payroll Information] section at [New Form] screen (OL-T14083)
    Check CAN remove and re-add field mapping on task of Payroll Information section    ${rounting_number}
    Delete a form with type     ${candidate_form}    ${form_name}


Check CAN remove and re-add field mapping on Email address task (OL-T13589, OL-T13561, OL-T13606, OL-T13571)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     Candidate
    Go to a form section detail     ${personal_information}
    Add a form task with type and save       ${custom_question}
    #    OL-T13589
    Check CAN remove field mapping on task of personal information section    ${email_address}
    #   Check CAN remove field mapping on [Phone number] task (OL-T13571)
    Check CAN remove field mapping on task of personal information section    ${phone_number}
    #   Check CAN remove field mapping on [Your full name] task (OL-T13561)
    Check CAN remove field mapping on task of personal information section    ${your_full_name}
    Go to a form section detail     ${personal_information}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${street_address_line_1}
    Click at    ${FIELD_MAPPING_ICON}
    Enter field mapping information     ${field_mapping_info}
    Click save task
    #   Check CAN remove and re-add field mapping on [Street address (Line 1)] task (OL-T13606)
    Check CAN remove field mapping on task of personal information section    ${street_address_line_1}
    Go to a form section detail     ${personal_information}
    Check can re-add field mapping on task of personal information section    ${email_address}   ${field_mapping_info}
    Check can re-add field mapping on task of personal information section    ${phone_number}   ${field_mapping_info}
    Check can re-add field mapping on task of personal information section    ${your_full_name}   ${field_mapping_info}     True
    Check can re-add field mapping on task of personal information section    ${street_address_line_1}   ${field_mapping_info}
    Delete a form with type     ${candidate_form}    ${form_name}


Check that CAN setting Field mapping for Company name task of Work Experience section at New Form screen (OL-T14282, OL-T14298, OL-T14292, OL-T14287, OL-T14277)
    Given Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    Go to form page
    ${form_name} =   Add new form and input name     Candidate
    Add a form section      ${work_experience}
    Click save task
    Go to a form section detail     ${work_experience}
    Add a form task with type and save       ${custom_question}
    Go to a form section detail     ${work_experience}
    #    OL-T14282
    Check that CAN setting Field mapping for tasks of Work Experience section    ${company_name}   ${field_mapping_info}    2
    #   Check that CAN setting [Field mapping] for [Your Job title] task of [Work Experience] section at [New Form] screen (OL-T14277)
    Check that CAN setting Field mapping for tasks of Work Experience section    ${your_job_title}   ${field_mapping_info}      1
    #   Check that CAN setting [Field mapping] for [Location] task of [Work Experience] section at [New Form] screen (OL-T14287)
    Check that CAN setting Field mapping for tasks of Work Experience section    ${location}   ${field_mapping_info}    3
    #   Check that CAN setting [Field mapping] for [Date started] task of [Work Experience] section at [New Form] screen (OL-T14292)
    Check that CAN setting Field mapping for tasks of Work Experience section    ${date_started}   ${field_mapping_info}    4
    #   Check that CAN setting [Field mapping] for [Date ended] task of [Work Experience] section at [New Form] screen (OL-T14298)
    Check that CAN setting Field mapping for tasks of Work Experience section    ${date_ended}   ${field_mapping_info}      5
    Delete a form with type     ${candidate_form}    ${form_name}

*** Keywords ***
Check user CAN setting Field mapping
    [Arguments]     ${task}          ${field_mapping}       ${information}=None      ${destination}=None
    Check display of Field Mapping
    IF      '${destination}' != 'None'
        Verify attribute should contain     value    ${destination}    ${FORM_MAPPING_MODAL_DESTINATION_FIELD}
    END
    Check display of Source field       ${information}
    Click at    ${FORM_MAPPING_MODAL_SOURCE_FIELD_OPTION}   ${field_mapping.source_field}   # Select Free text option
    Input into      ${FORM_MAPPING_MODAL_DESTINATION_FIELD}     @
    Check element display on screen     Enter a valid field value      wait_time=3s
    Capture page screenshot
    Input into      ${FORM_MAPPING_MODAL_DESTINATION_FIELD}     ${field_mapping.destination_field}
    Check element not display on screen     Enter a valid field value      wait_time=5s
    Capture page screenshot
    Select one system attribute in field mapping    ${field_mapping.sys_attr_menu}    ${field_mapping.sys_attr_value}
    Click at    ${FORM_MAPPING_MODAL_SAVE_BUTTON}
    Check element not display on screen     ${FORM_MAPPING_FIELD_MODAL}     wait_time=5s
    Check element display on screen     ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}       ${task}
    Capture page screenshot
    Click save task

Check displayed of Field mapping after adding
    [Arguments]     ${task}     ${field_mapping}    ${is_full_name}=False
    Click at     ${FORM_MAPPING_ICON_ATS_MAP}       ${task}
    Check display of Gear Icon menu after adding field mapping      ${field_mapping}    ${is_full_name}

Check that CAN setting Field mapping for task of Payroll Information
    [Arguments]      ${section}      ${task}     ${field_mapping}    ${destination}
    Go to a form section detail     ${section}
    Click at    ${FORM_MAPPING_ICON_ATS_MAP}   ${task}
    Check user CAN setting Field mapping    ${bank_account_type}   ${field_mapping}    None   ${destination}

Check that CAN setting Field mapping diversity question
    [Arguments]     ${task}     ${field_mapping}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${task}
    Click at    ${FIELD_MAPPING_ICON}
    Check user CAN setting Field mapping    ${task}   ${field_mapping}
    Go to a form section detail     ${diversity_question}
    Check displayed of Field mapping after adding       ${task}       ${field_mapping}

Check CAN remove and re-add field mapping on task of Payroll Information section
    [Arguments]     ${task}
    Go to a form section detail     ${payroll_information}
    Remove field mapping    ${task}
    Click save task
    Go to a form section detail     ${payroll_information}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${task}
    Click at    ${FIELD_MAPPING_ICON}
    Check default display of Field Mapping
    Click at    ${FORM_MAPPING_MODAL_REMOVE_BUTTON}
    Check element not display on screen     ${FORM_MAPPING_ICON_ATS_MAP}   ${task}      wait_time=5s
    Capture page screenshot
    Click save task

Check CAN remove field mapping on task of personal information section
    [Arguments]     ${task}
    Go to a form section detail     ${personal_information}
    Remove field mapping    ${task}
    Click save task
    Go to a form section detail     ${personal_information}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${task}
    Click at    ${FIELD_MAPPING_ICON}
    Click at    ${FORM_MAPPING_MODAL_REMOVE_BUTTON}
    Check element not display on screen     ${FORM_MAPPING_ICON_ATS_MAP}   ${task}      wait_time=5s
    Capture page screenshot
    Click save task

Check can re-add field mapping on task of personal information section
    [Arguments]     ${task}     ${field_mapping_info}   ${is_full_name}=False
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${task}
    Click at    ${FIELD_MAPPING_ICON}
    Enter field mapping information     ${field_mapping_info}   ${is_full_name}
    Click save task
    Go to a form section detail     ${personal_information}
    Check displayed of Field mapping after adding   ${task}     ${field_mapping_info}   ${is_full_name}

Check that CAN setting Field mapping for tasks of Work Experience section
    [Arguments]     ${task}     ${field_mapping}    ${task_index}
    Click at    ${FORM_MAPPING_ELLIPSES_ICON_BY_QUESTION_NAME}   ${task}
    Click at    ${FIELD_MAPPING_ICON}
    Click by JS    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD_OPTION}     Free text
    Click at    ${FORM_MAPPING_MODAL_ATS_DESTINATION_FIELD}
    Input into      ${FORM_MAPPING_MODAL_ATS_DESTINATION_FIELD}     @$%
    Check element display on screen     Enter a valid field value      wait_time=3s
    Input into      ${FORM_MAPPING_MODAL_ATS_DESTINATION_FIELD}     ${field_mapping.destination_field}
    Check element not display on screen     Enter a valid field value      wait_time=5s
    Select one system attribute in field mapping    ${field_mapping.sys_attr_menu}    ${field_mapping.sys_attr_value}
    Click at    ${FORM_MAPPING_MODAL_ATS_SOURCE_FIELD}
    Click at    ${FORM_MAPPING_FIELD_ATS_MODAL_SAVE_BUTTON}     ${task_index}
    Check element not display on screen     ${FORM_MAPPING_FIELD_MODAL}     wait_time=5s
    Check work experience field mapping after adding    ${task}     ${field_mapping}    ${task_index}
    Capture page screenshot
