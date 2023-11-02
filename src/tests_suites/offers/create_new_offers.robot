*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/offers_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg

*** Variables ***
${list_valid_file_extention}    .csv, .xls, .xlsx, .doc, .docx, .pdf, .ppt, .pptx, .png, .jpeg, .jpg

*** Test Cases ***
Either click on any New Offer button will redirect to a New Offer page (OL-T334)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Check link text display     Settings
    Check link text display     Offers
    Check span display      New Offer
    Check element display on screen     ${NEW_OFFER_NAME_TEXT_BOX}
    ${offer_name_placeholder} =     Get text and format text    ${NEW_OFFER_NAME_TEXT_BOX}
    Should be equal     ${offer_name_placeholder}   Name your offer
    Check element display on screen     ${NEW_OFFER_PUBLISH_STATUS}
    ${current_status} =     Get text and format text    ${NEW_OFFER_PUBLISH_STATUS}
    Should be equal     ${current_status}   Draft
    Check content of offer template


Check add Additional Date component with Date Label (OL-T9055, OL-T9056)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Check all offer component displayed in the left hand toolbar
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Date
    Check UI of Add Additional Date modal
    Check list item of Validation dropdown
    ${additional_date_name}=   Setting data for Add Additional Date component      Future Date (DD/MM/YYYY)
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${additional_date_name}
    capture page screenshot


Check Additional Date component with Date Label and Add Field Mapping add Validation (OL-T9058)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Check all offer component displayed in the left hand toolbar
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Date
    Check UI of Add Additional Date modal
    Check list item of Validation dropdown
    ${additional_date_name}=   Setting data for Add Additional Date component      Date (MM/DD/YYYY)    add_field_mapping=Offer Created Date
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${additional_date_name}
    capture page screenshot


Check add Document component with Document label and upload file (OL-T9062)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Document
    Check UI of Add Document modal
    ${document_name}=   Setting data for Add Document component     cat-kute
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${document_name}
    capture page screenshot


Check add Dropdown component with Dropdown Label and Dropdown options (OL-T9064)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Dropdown
    Check UI of Add Dropdown modal
    ${dropdown_name}=   Setting data for Add Dropdown component     2
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${dropdown_name}
    capture page screenshot


Check add Dropdown component with Dropdown Label, Dropdown options and Add Field Mapping (OL-T9065)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Dropdown
    Check UI of Add Dropdown modal
    ${dropdown_name}=   Setting data for Add Dropdown component     2       add_field_mapping=Offer Created Date
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${dropdown_name}
    capture page screenshot


Check add Additional Pay Rate component with Pay Rate Label (OL-T9069)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Pay Rate
    Check UI of Add Additional Pay Rate modal
    ${pay_rate_name}=   Setting data for Add Additional Pay Rate component      pay_frequency=per month
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${pay_rate_name}
    capture page screenshot


Check add Additional Pay Rate component with Pay Rate Label and Field Mapping (OL-T9070)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    When Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Pay Rate
    Check UI of Add Additional Pay Rate modal
    ${pay_rate_name}=   Setting data for Add Additional Pay Rate component      add_field_mapping=Offer Created Date
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${pay_rate_name}
    capture page screenshot


Check create offer and do not select language (OL-T9079)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Generate random name    auto_offer
    Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_NAME_TEXT_BOX}
    Press Keys    None    ${offer_name}
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Date
    ${additional_date_name}=   Setting data for Add Additional Date component      Date (MM/DD/YYYY)    add_field_mapping=Offer Created Date
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    Go to Offers page
    Check element display on screen     ${offer_name}
    capture page screenshot


Check create offer and slelect Multilingual (OL-T9080)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Generate random name    auto_offer
    Go to Offers page
    Click at    Add offer
    Click at    ${NEW_OFFER_NAME_TEXT_BOX}
    Press Keys    None    ${offer_name}
    Click at    ${NEW_OFFER_TEMPLATE_EDITOR}
    Click at   ${NEW_OFFER_ADD_COMPONENT_BUILDER}      Add Additional Date
    ${additional_date_name}=   Setting data for Add Additional Date component      Date (MM/DD/YYYY)    add_field_mapping=Offer Created Date
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_COMPONENT_LANGUAGE_ICON}
    ${language} =    set variable    Arabic
    Click at    ${NEW_OFFER_COMPONENT_LANGUAGE_OPTION}      ${language}
    Click at    ${NEW_OFFER_COMPONENT_LANGUAGE_ICON}
    Click at    Got it
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LANGUAGE_TAB}     ${language}
    capture page screenshot
    Go to Offers page
    Check element display on screen     ${offer_name}
    capture page screenshot

*** Keywords ***
Check content of offer template
    Check element display on screen     ${NEW_OFFER_ATTRIBUTE}  candidate-firstname
    Check element display on screen     ${NEW_OFFER_ATTRIBUTE}  company-name
    Check element display on screen     ${NEW_OFFER_ATTRIBUTE}  job-name
    Check element display on screen     ${NEW_OFFER_ATTRIBUTE}  job-location
    Check element display on screen     ${NEW_OFFER_ATTRIBUTE}  company-name
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    Start Date
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    Starting Pay Rate
    capture page screenshot

Check all offer component displayed in the left hand toolbar
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add Additional Date
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add Document
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add Dropdown
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add Open Text
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add Additional Pay Rate
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add User Lookup
    Check element display on screen     ${NEW_OFFER_COMPONENT_BUILDER_OPTION}  Add Location Lookup
    capture page screenshot

Check UI of Add Additional Date modal
    Check element display on screen     Additional Date Label
    Check element display on screen     ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Check common text last display  Additional Fields
    Check span display  Add validation and/or field mapping. These fields are optional.
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_DROPDOWN}
    capture page screenshot

Check list item of Validation dropdown
    Click at    ${NEW_OFFER_COMPONENT_VALIDATION_DROPDOWN}
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}  Date (DD/MM/YYYY)
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}  Date (MM/DD/YYYY)
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}  Future Date (DD/MM/YYYY)
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}  Future Date (MM/DD/YYYY)
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}  Past Date (DD/MM/YYYY)
    Check element display on screen     ${NEW_OFFER_COMPONENT_VALIDATION_OPTION}  Past Date (MM/DD/YYYY)
    capture page screenshot

Check UI of Add Document modal
    Check element display on screen     Add Document
    Check element display on screen     ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Check span display      Drag a file here or click to browse
    Check span display      ${list_valid_file_extention}
    capture page screenshot

Check UI of Add Dropdown modal
    Check span display     Please provide the dropdown options that the hiring team will be required to select from before sending the offer to a candidate.
    Check label display     Dropdown Label
    Check element display on screen     ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Check element display on screen     ${NEW_OFFER_DROPDOWN_OPTION_WITH_INDEX}     1
    Check element display on screen     ${NEW_OFFER_DROPDOWN_OPTION_WITH_INDEX}     2
    Check span display      Add Option
    Check common text last display  Additional Fields
    Check span display  Add field mapping. This field is optional.
    Check span display  Add Field Mapping
    capture page screenshot

Check UI of Add Additional Pay Rate modal
    Check span display     Please provide the details for this pay rate field. The hiring team will be required to fill in this pay rate value before sending the offer to a candidate.
    Check label display     Additional Pay Rate Label
    Check element display on screen     ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Check element display on screen     ${NEW_OFFER_COMPONENT_CURRENCY_DROPDOWN}
    Check element display on screen     ${NEW_OFFER_COMPONENT_PAY_FREQUENCY_DROPDOWN}
    Check common text last display  Additional Fields
    Check span display  Add field mapping. This field is optional.
    Check span display  Add Field Mapping
    capture page screenshot
