*** Settings ***
Resource            ../../../../tests_suites/conversation/custom_conversation/ability_to_upload_media/upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          dev    regression    stg    lts_stg

*** Test Cases ***
Check media library when CMS is toggled ON after upload media successfully (OL-T21383, OL-T21381, OL-T21382)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Check media library when CMS is toggled ON after upload a media successfully    Address

*** Keywords ***