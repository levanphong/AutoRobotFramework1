*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/custom_conversation_page.robot
Resource            ../../../tests_suites/conversation/custom_conversation/ability_to_upload_media/upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg    lmco    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    unilever    test

*** Test Cases ***
Create custom conversation for all question type with media type is hyperlink
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Create custom conversation for all question type with media type    CustomConvMediaTypeIsHyperlink    Hyperlink      Hyperlink_content_title


Create custom conversation for all question type with media type is image
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Create custom conversation for all question type with media type    CustomConvMediaTypeIsImage    Image/GIF     Image_content_title


Create custom conversation for all question type with media type is video
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Create custom conversation for all question type with media type    CustomConvMediaTypeIsVideo    Video       Video_content_title


Create Landing site with custom conversation for question type
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Create landing site/widget site     Landing Site    site_name=LandingSiteHyperlinkMedia     conversation_name=CustomConvMediaTypeIsHyperlink
    Create landing site/widget site     Landing Site    site_name=LandingSiteImageMedia     conversation_name=CustomConvMediaTypeIsImage
    Create landing site/widget site     Landing Site    site_name=LandingSiteVideoMedia     conversation_name=CustomConvMediaTypeIsVideo

*** Keywords ***
