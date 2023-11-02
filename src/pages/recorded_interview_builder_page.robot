*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/recorded_interview_builder_locators.py

*** Keywords ***
Create a new Recorded Interview
    ${interview_name} =     Generate random name  auto_interview
    Click at  ${RECORDED_INTERVIEW_PAGE_NEW_INTERVIEW_BUTTON}
    Simulate Input  ${NEW_RECORDED_INTERVIEW_NAME_TEXT_BOX}     ${interview_name}
    Wait for the element to fully load  ${NEW_RECORDED_INTERVIEW_NAME_TEXT_BOX}
    Click at  ${NEW_RECORDED_INTERVIEW_QUESTION_BUTTON}
    # Add question
    ${question_name} =     Generate random name  auto_question
    Click at  ${NEW_RECORDED_INTERVIEW_QUESTION_NAME_EDIT_BUTTON}
    Simulate Input  None  ${question_name}
    Input into  ${NEW_RECORDED_INTERVIEW_QUESTION_CONTENT_TEXT_BOX}  This is sample question?
    Click at  ${NEW_RECORDED_INTERVIEW_QUESTION_NAME_TEXT_BOX}
    Click at  ${NEW_RECORDED_INTERVIEW_QUESTION_SAVE_BUTTON}
    # Add Closing message
    Input into  ${NEW_RECORDED_INTERVIEW_CLOSING_MESSAGE_TEXT_BOX}  Bye Bye
    Click at  ${NEW_RECORDED_INTERVIEW_SAVE_BUTTON}
    Check element display on screen  ${interview_name}
    [Return]    ${interview_name}

Delete a Recorded Interview
    [Arguments]     ${interview_name}
    Input into  ${RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX}  ${interview_name}
    Check element display on screen     ${interview_name}
    Click at  ${RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ICON}
    Click at  ${RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ACTION}     Delete
    Click at  ${RECORDED_INTERVIEW_PAGE_DELETE_INTERVIEW_CONFIRM_DELETE_BUTTON}
    Check element not display on screen  ${interview_name}
