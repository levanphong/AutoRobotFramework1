*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/knowledge_base_locators.py

*** Keywords ***
Add a Link to company spreadsheet
    [Arguments]    ${kb_type}    ${spreadsheet_url}
    Go to Knowledge Base page
    Click at    ${RIGHT_MENU_TAB}    ${kb_type}
    Input into    ${LINK_COMPANY_SPREADSHEET_TEXT_BOX}    ${spreadsheet_url}
    Click at    ${LINK_COMPANY_SPREADSHEET_PUBLISH_BUTTON}
    Wait with medium time

Save a Link to company spreadsheet
    [Arguments]    ${kb_type}    ${spreadsheet_url}
    Go to Knowledge Base page
    Click at    ${RIGHT_MENU_TAB}    ${kb_type}
    ${current_url}=  Get Value   ${LINK_COMPANY_SPREADSHEET_TEXT_BOX}
    IF  '$current_url' != ''
	    IF  '${current_url}' == '${spreadsheet_url}'
			Input into    ${LINK_COMPANY_SPREADSHEET_TEXT_BOX}    temp_url
			Click at    ${LINK_COMPANY_SPREADSHEET_SAVE_BUTTON}
			Check Text Display    Changes saved successfully.
	    END
        Clear element text with keys    ${LINK_COMPANY_SPREADSHEET_TEXT_BOX}
    END
    Input into    ${LINK_COMPANY_SPREADSHEET_TEXT_BOX}    ${spreadsheet_url}
    Click at    ${LINK_COMPANY_SPREADSHEET_SAVE_BUTTON}
    Check Text Display    Changes saved successfully.
