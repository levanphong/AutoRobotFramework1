*** Settings ***
Resource            ../../../../tests_suites/conversation/custom_conversation/ability_to_upload_media/upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          dev    lts_stg    regression    stg

*** Test Cases ***
Check media library when CMS is toggled ON after upload media successfully (OL-T21987, OL-T21988, OL-T21989)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Check media library when CMS is toggled ON after upload a media successfully    Open-Ended

*** Keywords ***
