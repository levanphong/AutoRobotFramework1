*** Settings ***
Resource            ../../../../tests_suites/conversation/custom_conversation/ability_to_upload_media/upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          dev    lts_stg    regression    stg

*** Test Cases ***
Check media library when CMS is toggled ON after upload media successfully (OL-T21579, OL-T21578, OL-T21581, OL-T21585, OL-T21583)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Check media library when CMS is toggled ON after upload a media successfully    Document Upload     document_required=ON

*** Keywords ***
