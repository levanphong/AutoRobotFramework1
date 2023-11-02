*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/interview_prep_locators.py

*** Keywords ***
Add a new Interview Prep
    [Arguments]     ${audience_type}
    #audience_type : Candidates or Users
    Click at    ${NEW_INTERVIEW_PREP_BUTTON}
    wait with short time
    ${interview_prep_title}=    generate random string      6       [LETTERS][NUMBERS]
    ${interview_prep_name}=     Set variable        Interview_prep_${interview_prep_title}
    Input into      ${INTERVIEW_PREP_TITLE_TEXTBOX}         ${interview_prep_name}
    Click at    ${AUDIENCE_DROPDOWN}
    ${audience} =       Format String    ${NEW_INTERVIEW_PREP_AUDIENCE_TYPE}    ${audience_type}
    Click at    ${audience}
    ${external_id}=     generate random string      5       [NUMBERS]
    Input into      ${EXTERNAL_ID_TEXTBOX}      ${external_id}
    Click at    ${SAVE_NEXT_FINISH_BUTTON}      Next
    Click at    ${SAVE_NEXT_FINISH_BUTTON}      Save
    Check element not display on screen     ${INTERVIEW_PREP_UPLOAD_DOCUMENT_ICON}
    capture page screenshot
    Click at    ${SAVE_NEXT_FINISH_BUTTON}      Next
    Click at    ${SAVE_NEXT_FINISH_BUTTON}     Finish and Publish
    wait for page load successfully
    [Return]    ${interview_prep_name}

User can edit interview prep
    Click at    ${ESCAPE_PREP_BUTTON}
    Click at    ${EDIT_PREP_BUTTON}
    wait with short time
    Clear element text with keys    ${INTERVIEW_PREP_TITLE_TEXTBOX}
    wait with short time
    ${interview_prep_title_changed}=    generate random string      6       [LETTERS][NUMBERS]
    ${interview_prep_name_changed}=     Set variable    Interview_prep_changed_${interview_prep_title_changed}
    Input into    ${INTERVIEW_PREP_TITLE_TEXTBOX}       ${interview_prep_name_changed}
    Click at    ${SAVE_NEXT_FINISH_BUTTON}      Next
    Click at    ${SAVE_NEXT_FINISH_BUTTON}      Next
    Click at    ${SAVE_NEXT_FINISH_BUTTON}     Finish and Publish
    wait for page load successfully
    Input into  ${INTERVIEW_PREP_PAGE_SEARCH_TEXT_BOX}  ${interview_prep_name_changed}
    Check element display on screen      ${interview_prep_name_changed}
    [Return]    ${interview_prep_name_changed}

Delete an Interview Prep
    [Arguments]     ${interview_prep_name}
    go to Interview Prep page
    Input into  ${INTERVIEW_PREP_PAGE_SEARCH_TEXT_BOX}  ${interview_prep_name}
    Click at  ${INTERVIEW_PREP_PAGE_SEARCH_RESULT_ECLIPSE_ICON}
    Click at  ${INTERVIEW_PREP_PAGE_ECLIPSE_MENU_ITEM}  Delete
    Click at  ${INTERVIEW_PREP_DELETE_POPUP_DELETE_BUTTON}
    Input into  ${INTERVIEW_PREP_PAGE_SEARCH_TEXT_BOX}  ${interview_prep_name}
    Check element not display on screen  ${interview_prep_name}
