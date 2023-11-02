*** Settings ***
Library             ../../utils/StringHandler.py
Resource            ../../tests_suites/conversation/custom_conversation/ability_to_upload_media/upload_media.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${default_company_name}     ${COMPANY_FRANCHISE_ON}

*** Test Cases ***
Delete unused media in Media Library
    Delete unused Media     ${prefix_media_title}


*** Keywords ***
Delete unused Media
    [Arguments]     ${prefix_title}    ${company_name}=None
    IF  '${company_name}' == 'None'
        ${company_name} =   Set variable    ${default_company_name}
    END
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to Media library page
    Input into  ${SEARCH_MEDIA_SEARCH_BOX}  ${prefix_title}
    ${all_media} =    Get Text and format text   ${MEDIA_LIBRARY_TOTAL_FILES_TEXT}
    ${all_media} =    extract_numbers    ${all_media}
    FOR    ${index}    IN RANGE    0    ${all_media}[0]   20
        Click at    ${MEDIA_LIBRARY_CHECK_ALL_CHECK_BOX}
        Click at    ${MEDIA_LIBRARY_DELETE_BUTTON}
        Click at    ${MEDIA_LIBRARY_CONFIRM_DELETE_BUTTON}
        wait for page load successfully v1
    END
