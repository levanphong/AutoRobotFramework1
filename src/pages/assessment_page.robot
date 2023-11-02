*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/conversation_page.robot
Resource        ../pages/jobs_page.robot
Resource        ../pages/web_management_page.robot
Resource        ../pages/message_customize_page.robot
Variables       ../locators/all_candidates_locators.py
Variables       ../locators/assessment_locators.py

*** Keywords ***
Check the text content of the header/button
    [Arguments]     ${element_check}    ${text_content}
    ${check_text} =     Get text  ${element_check }
    Should be equal as strings      ${check_text}      ${text_content}
    Capture page screenshot

Chat apply job for send assessment
    Go to My Jobs page
    ${job_apply_link} =    Turn on job and get internal job link   Doctor
    Go to   ${job_apply_link}
    ${candidate_name} =    Generate candidate name
    wait with short time
    check message widget site response correct   ${I_CAN_HELP_YOU_TO_THE}
    Input text for widget site      ${candidate_name.full_name}
    check message widget site response correct       ${ASK_EMAIL}
    &{email_info} =     Get email for testing       False
    Input text for widget site    ${email_info.email}
    check message widget site response correct   ${ASK_AGE}
    Input text for widget site    26
    ${mes_request}=     format string       ${MES_REQUEST_ASSESSMENT}     ${candidate_name.first_name}
    check message widget site response correct   ${mes_request}
    check element display on screen     ${ASSESSMENT_LET_GO_BUTTON}
    Capture page screenshot
    Verify element is enable    ${ASSESSMENT_LET_GO_BUTTON}
    Click at     ${ASSESSMENT_LET_GO_BUTTON}
    wait for page load successfully
    check element display on screen     ${ASSESSMENT_MODAL}
    Capture page screenshot
    Check the text content of the header/button      ${ASSESSMENT_MODAL_HEADER}      ${ASSESSMENT_HEADER_TEXT}
    [Return]    ${candidate_name}

Check display of modal when click button
    [Arguments]   ${button_name}    ${text_content}
    wait for page load successfully
    ${text} =    Get text    ${text_content}
    click at    ${button_name}
    ${check_text} =     Get text  ${text_content }
    Should not be equal as strings  ${check_text}   ${text}
    Capture page screenshot

Check display modal confirm when click icon X
    Click at    ${ASSESSMENT_MODAL_ICON_CLOSE}
    Check element display on screen   ${ASSESSMENT_MODAL_CONFIRM_HEADER}
    Check element display on screen   ${ASSESSMENT_MODAL_CONFIRM_BODY}
    Check element display on screen   ${ASSESSMENT_MODAL_CONFIRM_BUTTON_CANCEL}
    Check element display on screen   ${ASSESSMENT_MODAL_CONFIRM_BUTTON_EXIT}
    Capture page screenshot

Check button continue assessment display when click button exit
    Click at    ${ASSESSMENT_MODAL_CONFIRM_BUTTON_EXIT}
    Check the text content of the header/button       ${ASSESSMENT_LET_GO_BUTTON}    ${ASSESSMENT_STATUS_CONTINUE}

Click button me/notme until finish
    FOR    ${index}    IN RANGE    1    76
        Click at     ${ASSESSMENT_MODAL_BUTTON_ME}
    END
    wait for page load successfully
    Check the text content of the header/button     ${ASSESSMENT_MODAL_SUCCESS_TEXT}     ${ASSESSMENT_SUCCESS_TEXT}
    Check the text content of the header/button       ${ASSESSMENT_MODAL_MES_CLICK_FINISH}     ${ASSESSMENT_MODAL_CLICK_FINISH_TEXT}
    Check element display on screen     ${ASSESSMENT_MODAL_BUTTON_FINISH}

check message widget site response correct when finish assessment
    [Arguments]   ${button_name}
    Click at    ${button_name}
    wait for page load successfully
    check element not display on screen     ${ASSESSMENT_MODAL}     wait_time=1s
    capture page screenshot
    Check the text content of the header/button       ${ASSESSMENT_LET_GO_BUTTON}      ${ASSESSMENT_BUTTON_STATUS_COMPLETED}
    Check the text content of the header/button       ${ASSESSMENT_STATUS_COMPLETE}    ${ASSESSMENT_BUTTON_STATUS_COMPLETED_TEXT}
    check message widget site response correct      ${MES_THANK_FOR_COMPLETE_ASSESSMENT}
    Capture page screenshot

check message widget site response correct when finish assessment with share Assessment Results
    check message widget site response correct when finish assessment    ${ASSESSMENT_MODAL_BUTTON_FINISH}
    check element display on screen     ${ASSESSMENT_VIEW_RESULT}
    Check the text content of the header/button       ${ASSESSMENT_VIEW_RESULT_HEADER}      ${ASSESSMENT_HEADER_TEXT}
    Check the text content of the header/button      ${ASSESSMENT_VIEW_RESULT_BUTTON_VIEW_RESULT}      ${ASSESSMENT_VIEW_RESULT_TEXT}

Check Status Of Candidate In CEM Page
    [Arguments]     ${first_name}   ${status_value}
    Go To CEM Page
    Switch to user      ${CA_TEAM}
    Click at    ${CEM_CANDIDATE_NAME}   ${first_name}
    Check span display      ${status_value}
    capture page screenshot

Check message in conversation when transfer send assessment in Landing Site
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_TITLE_CARD_MODAL}   Assessment Instructions
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_GO_BUTTON}
    Capture page screenshot

Check UI Assessment Display in Landing Site
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_TITLE}
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_BUTTON_ME}
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_BUTTON_NOT_ME}
    Capture page screenshot

Check UI Assessment When Click Me/NotMe Button in Landing Site
    [Arguments]    ${button_type_locator}
    ${caption_previous_value}=   Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_CAPTION}
    Click At    ${button_type_locator}
    ${caption_current_value}=   Get Text And Format Text    ${LANDING_SITE_ASSESSMENT_CAPTION}
    Should Not Be Equal As Strings    ${caption_current_value}  ${caption_previous_value}
    Check UI Assessment Display in Landing Site

Check UI Confirm Modal When Click X Icon in Landing Site
    Check Span Display    Exit Assessment
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_BUTTON_CLOSE}   Exit Assessment
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_CANCEL_BUTTON}
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_EXIT_BUTTON}
    Capture page screenshot

Check UI When Finished Assessment in Landing Site
    Check Element Display On Screen    ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}
    Check P Text Display           ${MES_COMPLETED_ASSESSMENT}
    Check Span Display    ${MES_GUIDE_COMPLETE_ASSESSMENT}
    Capture page screenshot

Click on Me button until finish
     FOR    ${i}    IN RANGE    1000
        ${is_existed} =     Run Keyword and Return Status       Page should not contain element     ${LANDING_SITE_ASSESSMENT_BUTTON_FINISHED}       wait_time=1s
        IF   '${is_existed}' == 'True'
            Click At    ${LANDING_SITE_ASSESSMENT_BUTTON_ME}
        END
        Exit For Loop If    ${is_existed} == False
    END

Chat landing site to send assessment
    [Arguments]    ${job_name}  ${web_management_name}
    ${url}=     Open landing site and get url   ${web_management_name}
    Go to    ${url}
    Input text and send message     ${job_name}
    Verify Olivia Conversation Message Display    ${REPROMPT_LOCATION_MESSAGE_1}
    Input Text And Send Message    any where
    ${check} =      Run Keyword And Return Status   Check Element Display On Screen    ${CONVERSATION_SEE_ALL_BUTTON}
    IF  '${check}' == 'True'
         Click at    ${CONVERSATION_SEE_ALL_BUTTON}
         Click At    ${RECOMMENDED_JOB_ITEM}    ${job_name}
         Click at    ${CONVERSATION_APPLY_NOW_BUTTON}
    ELSE
         Click At    ${CONVERSATION_DETAILS_BUTTON}   ${job_name}
         Click At    ${CONVERSATION_APPLY_NOW_BUTTON}
    END
    Verify Olivia Conversation Message Display     ${I_CAN_HELP_YOU_TO_THE}
    ${candidate_name} =     Generate candidate name
    Input Text And Send Message   ${candidate_name.full_name}
    Verify Olivia Conversation Message Display    ${ASK_PHONE}
    ${phone_number} =   Generate Random String      6    [NUMBERS]
    Input Text And Send Message      +12025${phone_number}
    Verify Olivia Conversation Message Display    Great!
    &{email_info} =     Get email for testing       False
    Input Text And Send Message   ${email_info.email}
    Verify Olivia Conversation Message Display    How old are you?
    Input Text And Send Message  30
    Click At    ${MESSAGE_CONVERSATION_CHOICE_SEND_INFORMATION}     Email Only
    Click At    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    ${text} =   Format String   ${MES_REQUEST_ASSESSMENT}   ${candidate_name.first_name}
    Verify Olivia conversation message display      ${text}
    [Return]     ${candidate_name.first_name}

