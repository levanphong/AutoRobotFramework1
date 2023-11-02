*** Settings ***
Resource            ../../pages/forms_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg    stg_mchire    test

*** Test Cases ***
Check that CAN published From with Custom section (OL-T17150, OL-T17235)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${form_name} =      Create new user form       ${default_section}     ${custom_question}      ${title_custom_question}
    # Add many tasks type
    Add a form task with type and save    ${address}
    Add more form task with type and save     ${default_section}    ${document_review}
    Add more form task with type and save     ${default_section}    ${document_upload}
    Add more form task with type and save     ${default_section}    ${display_text}
    Add more form task with type and save     ${default_section}    ${fillable_pdf}
    # Verify Publish form success
    wait for page load successfully
    Click publish form
    Capture page screenshot
    # Verify delete Published form success
    Delete a form with type     ${user_form}      ${form_name}


Check that CAN delete Draft User Form by clicking on Delete button at Delete User Form popup (OL-T17234)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${form_name} =      Create new user form       ${default_section}     ${custom_question}      ${title_custom_question}
    # Add many tasks type
    Add a form task with type and save    ${address}
    Add more form task with type and save     ${default_section}    ${document_review}
    Add more form task with type and save     ${default_section}    ${document_upload}
    Add more form task with type and save     ${default_section}    ${display_text}
    Add more form task with type and save     ${default_section}    ${fillable_pdf}
    # Verify delete draft form success and show alert messsage
    Delete a form with type     ${user_form}      ${form_name}
    Capture page screenshot


Check that CAN delete tasks of the Default Section screen after adding (OL-T17149)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${form_name} =      Create new user form       ${default_section}     ${custom_question}      ${title_custom_question}
    # Add many tasks type
    Add a form task with type and save     ${document_review}
    Add more form task with type and save     ${default_section}    ${document_upload}
    Add more form task with type and save     ${default_section}    ${display_text}
    Add more form task with type and save     ${default_section}    ${fillable_pdf}
    # Verify can delete tasks of the Default Section
    Delete form task of section     ${default_section}      ${title_document_review}
    Delete form task of section     ${default_section}      ${title_document_upload}
    Delete form task of section     ${default_section}      ${title_display_text}
    Delete form task of section     ${default_section}      ${title_fillable_pdf}
    Delete a form with type     ${user_form}      ${form_name}
    Capture page screenshot

*** Keywords ***
Add more form task with type and save
    [Arguments]     ${section}      ${task}
    Go to a form section detail     ${section}
    Add a form task with type     ${task}
    Click save task
