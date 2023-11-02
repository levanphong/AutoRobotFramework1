*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/candidate_summary_builder_locators.py

*** Variables ***
${custom_section_insert_section_title}      Insert section title

*** Keywords ***
Add a field
    [Arguments]   ${field_name}  ${data}   ${index}=1
    Click at   ${CANDIDATE_SUMMARY_ADD_FIELD_BUTTON}    ${index}
    Input into   ${ADD_FIELD_NAME_TEXTBOX}  ${field_name}
    Click at   ${ADD_FIELD_DATA_DROPDOWN}
    Input into   ${ADD_FIELD_DATA_SEARCH_TEXTBOX}  ${data}
    Click at   ${ADD_FIELD_DATA_ITEM}   ${data}
    Click at   ${ADD_FIELD_SAVE_BUTTON}

Add a section
    [Arguments]   ${section_name}
    ${is_clicked} =  Run keyword and return status   Click at  ${CANDIDATE_SUMMARY_ADD_SECTION_BUTTON_2}  wait_time=5s
    IF  not ${is_clicked}
        Click at  ${CANDIDATE_SUMMARY_ADD_SECTION_BUTTON}
        Click at  ${CANDIDATE_SUMMARY_ADD_SECTION_ITEM}   ${section_name}
    ELSE
        Click at  ${CANDIDATE_SUMMARY_ADD_SECTION_ITEM_2}   ${section_name}
    END
    wait for page load successfully v1
    Run keyword if  '${section_name}' == 'Custom Section'   Simulate Input    ${CANDIDATE_SUMMARY_TITLE_TEXTBOX}   ${section_name}    ${custom_section_insert_section_title}

Edit a field
    [Arguments]   ${field_name}  ${data}
    Click at   ${CANDIDATE_SUMMARY_FIELD_TITLE}
    Input into   ${ADD_FIELD_NAME_TEXTBOX}  ${field_name}
    Click at   ${ADD_FIELD_DATA_DROPDOWN}
    Input into   ${ADD_FIELD_DATA_SEARCH_TEXTBOX}  ${data}
    Click at   ${ADD_FIELD_DATA_ITEM}   ${data}
    Click at   ${ADD_FIELD_SAVE_BUTTON}

Delete a section
    [Arguments]   ${index}
    Click at   ${CANDIDATE_SUMMARY_DELETE_SECTION_BUTTON}   ${index}
    Click at   ${CANDIDATE_SUMMARY_CONFIRM_DELETE_BUTTON}

Save and confirm save
    Click at   ${CANDIDATE_SUMMARY_SAVE_BUTTON}
    Click at   ${CANDIDATE_SUMMARY_CHANGE_SAVE_BUTTON}
    Check element display on screen  ${CANDIDATE_SUMMARY_SUCCESS_TOASTED}
    Check element not display on screen  ${CANDIDATE_SUMMARY_SUCCESS_TOASTED}

Delete a section with name
    [Arguments]   ${section_name}
    Click at   ${CANDIDATE_SUMMARY_DELETE_SECTION_ICON}     ${section_name}
    Click at   ${CANDIDATE_SUMMARY_CONFIRM_DELETE_SECTION_POPUP_BUTTON}     Delete
    Click at    ${CANDIDATE_SUMMARY_SAVE_BUTTON}
    Click at    ${CANDIDATE_SUMMARY_CHANGE_SAVE_BUTTON}
    Check element display on screen     Changes saved successfully.
