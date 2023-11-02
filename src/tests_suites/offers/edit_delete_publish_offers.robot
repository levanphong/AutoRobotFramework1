*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg

*** Variables ***
${published_success_message}    Offer is published successfully!
${updated_success_message}      Offer is updated successfully!
${deleted_error_message}        Offer already in use.
${job_family_name}              Coffee family job
${deleted_success_message}      Deleted offer successfully!×
${cj_name}                      CJ_Send Offer To Candidate

*** Test Cases ***
User is able to publish an offer (OL-T337)
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
    Check UI of Publish Offer confirmation modal
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    ${success_message} =    Get text and format text   ${PUBLISH_OFFER_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${published_success_message}
    Check span display   Published
    Go to Offers page
    Check element display on screen     ${offer_name}
    capture page screenshot
    Delete a offer      ${offer_name}


Check the status when user edits a published offer (OL-T341)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    ${offer_name} =    Create a new offer
    Go to Offers page
    Search offer    ${offer_name}
    Check element display on screen     ${offer_name}
    Click at    ${OFFER_LIST_ITEM_MENU}     ${offer_name}
    Check element display on screen     ${OFFER_ECLIPSE_POPUP_ICON_EDIT_ICON}
    Check element display on screen     ${OFFER_ECLIPSE_POPUP_ICON_PREVIEW_ICON}
    Check element display on screen     ${OFFER_ECLIPSE_POPUP_ICON_DELETE_ICON}
    Check element display on screen     ${OFFER_ECLIPSE_POPUP_ICON_DUPLICATE_ICON}
    capture page screenshot
    Click at    ${OFFER_ECLIPSE_POPUP_ICON_EDIT_ICON}
    Click offer editor and add component    Add Additional Date
    ${additional_date_name}=   Setting data for Add Additional Date component      Date (MM/DD/YYYY)    add_field_mapping=Offer Created Date
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    ${success_message} =    Get text and format text   ${PUBLISH_OFFER_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${updated_success_message}
    Check span display   Unpublished Changes
    capture page screenshot
    Delete a offer      ${offer_name}


Check whether an error message is shown when user tries to delete an offer which is being used for a job (OL-T342, OL-T343)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create a new offer
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to Offers page
    Delete a offer      ${offer_name}
    ${error_message} =    Get text and format text   ${PUBLISH_OFFER_ERROR_TOASTED}
    Should Contain    ${error_message}    ${deleted_error_message}
    capture page screenshot
    Delete a Job    ${job_name}    ${job_family_name}
    Delete a offer      ${offer_name}
    # Check whether user is able to delete an offer if it is not used for any job (OL-T343)
    ${success_message} =    Get text and format text   ${PUBLISH_OFFER_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${deleted_success_message}
    capture page screenshot
