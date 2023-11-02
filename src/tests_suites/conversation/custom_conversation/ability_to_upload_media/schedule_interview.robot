*** Settings ***
Resource            ./upload_media.resource

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    dev    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    pepsi    plg    regis    regression    stg    stg_mchire    unilever    darden    test

*** Variables ***

*** Test Cases ***
Verify option 'Upload Media’ when Question type is 'Schedule Interview' in Custom conversation (OL-T22335)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to conversation builder
    ${conversation_name} =    Generate random text only
    when Add new custom conversation with name and welcome question    Auto_${conversation_name}
    Add question by type    Welcome    Schedule Interview
    Click at  ${THREE_DOT_ICON_BY_QUESTION_NAME}    Schedule Interview
    Check element not display on screen     Upload Media
    capture page screenshot
    Delete custom conversation in builder
    capture page screenshot


Verify video uploaded are removed when change to question type is 'Schedule Interview' (OL-T22336)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check uploaded media are removed when change question type to Schedule Interview    Video   ${custom_conv_video_file_name}


Verify image uploaded are removed when change to question type is 'Schedule Interview' (OL-T22337)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check uploaded media are removed when change question type to Schedule Interview    Image/GIF   ${custom_conv_image_file_name}


Verify hyperlink uploaded are removed when change to question type is 'Schedule Interview' (OL-T22338)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Check uploaded media are removed when change question type to Schedule Interview    Hyperlink   ${custom_conv_hyperlink}

*** Keywords ***
Check uploaded media are removed when change question type to Schedule Interview
    [Arguments]     ${media_type}   ${file_name}
    Go to conversation builder
    ${conversation_name} =    Generate random text only
    when Add new custom conversation with name and welcome question    Auto_${conversation_name}
    Add question by type    Welcome    Email
    Click at  ${THREE_DOT_ICON_BY_QUESTION_NAME}    Email
    Click at  ${CUSTOM_CONVERSATION_QUESTION_ECLIPSE_MENU_ITEM}  Upload Media
    ${media_type_title}=     Add New Media to a Question     ${media_type}   ${file_name}
    Select question type       Email     Schedule Interview
    check element not display on screen     ${media_type_title}
    capture page screenshot
    Delete created custom conversation and added media      ${media_type_title}
    capture page screenshot
