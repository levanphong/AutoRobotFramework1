*** Settings ***
Library             ../../utils/StringHandler.py
Variables           ../../locators/client_setup_locators.py
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../drivers/driver_chrome.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${default_company_name}     ${COMPANY_FRANCHISE_ON}
${conversation_prefix}      auto

*** Test Cases ***
Delete Candidate Journey template
    Delete unused Conversation  Candidate Journey


Delete Conditional Conversation template
    Delete unused Conversation  Conditional


Delete Dynamic ATS conversation template
    Delete unused Conversation  Dynamic ATS conversation


Delete Event Registration (Multiple Path) template
    Delete unused Conversation  Event Registration (Multiple Path)


Delete Follow Up template
    Delete unused Conversation  Follow Up


Delete Job Search template
    Delete unused Conversation  Job Search


Delete Multiple Path template
    Delete unused Conversation  Multiple Path


Delete Multiple Path (Prioritized Location) template
    Delete unused Conversation  Multiple Path (Prioritized Location)


Delete Single Path template
    Delete unused Conversation  Single Path


Delete Single Path (Prioritized Location) template
    Delete unused Conversation  Single Path (Prioritized Location)


Delete Event Registration (Single Path) template
    Delete unused Conversation  Event Registration (Single Path)


Delete Custom conversation template
    Delete unused Conversation  Custom

*** Keywords ***
Delete unused Conversation
    [Arguments]     ${template_type}    ${company_name}=None
    IF  '${company_name}' == 'None'
        ${company_name} =   Set variable    ${default_company_name}
    END
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company_name}
    Go to conversation builder
    ${is_tab_display}=     Run Keyword And Return Status    Check element display on screen  ${CONVERSATION_BUILDER_PAGE_RIGHT_NAV_TEXT}  ${template_type}     wait_time=2s
    IF  '${is_tab_display}' == 'True'
        Click at  ${CONVERSATION_BUILDER_PAGE_RIGHT_NAV_TEXT}  ${template_type}
        Input into  ${CONVERSATION_SEARCH_BOX}  ${conversation_prefix}_${template_type}
        Check element display on screen     ${CONVERSATION_BUILDER_PAGE_TEMPLATE_CONVERSATION_NUMBER}  ${template_type}
        ${all_conversations} =    Get Text and format text   ${CONVERSATION_BUILDER_PAGE_TEMPLATE_CONVERSATION_NUMBER}  ${template_type}
        ${all_conversations} =    extract_numbers    ${all_conversations}
        ${skip_index} =    set variable    ${1}
        FOR    ${index}    IN RANGE    ${all_conversations}[0]
            ${icon_locator} =    Catenate    SEPARATOR=    ${ECLIPSE_ICON}    [${skip_index}]
            ${is_end_page} =    Run Keyword And Return Status    Check element display on screen    ${icon_locator}      wait_time=2s
            IF    '${is_end_page}' == 'False'
                    Reload page
                    Input into  ${CONVERSATION_SEARCH_BOX}  ${conversation_prefix}_${template_type}
                    ${skip_index} =    set variable    ${1}
                    ${icon_locator} =    Catenate    SEPARATOR=    ${ECLIPSE_ICON}    [${skip_index}]
            END
            Click at    ${icon_locator}
            Click at    ${ECLIPSE_DELETE_BUTTON}
            Click at    ${CONFIRM_DELETE_BUTTON}
            ${is_btn_visible} =    Run Keyword And Return Status    Check element display on screen    ${USED_CONVERSATION_ALERT}    wait_time=2s
            IF    '${is_btn_visible}' == 'True'
                Click at    ${USED_CONVERSATION_ALERT}
                ${skip_index} =    set variable    ${skip_index+1}
            END
            Exit For Loop IF    '${index}' == '${all_conversations}[0]'
        END
    END
