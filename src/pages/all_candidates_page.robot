*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/all_candidates_schedule_page.robot
Variables       ../locators/all_candidates_locators.py

*** Keywords ***
Login successfully
    Check element display on screen    ${HOME_COMPANY_NAME}

search company name
    [Arguments]    ${company}
    Simulate Input    ${COMPANY_INPUT}    ${company}
    wait until page does not contain element    ${SEARCH_COMPANY_LOADING_ICON}    5s

click on expected company name
    [Arguments]    ${company}
    Click at    ${LIST_COMPANY_AVAILABLE}    ${company}
    wait for page load successfully v1
    wait until element is enabled    ${HOME_COMPANY_NAME}    20s

run search and click company name
    [Arguments]    ${company}
    Click at    ${HOME_COMPANY_NAME}
    search company name    ${company}
    click on expected company name    ${company}

Switch to Company v1
    [Arguments]    ${company}
    ${company_get_text} =    Get Text    ${HOME_COMPANY_NAME}
    ${result} =    evaluate    '''${company_get_text}''' != '''${company}'''
    IF    ${result}
        run search and click company name    ${company}
    ELSE
        Log    ${company} is already selected
    END

wait for cem display
    ${is_has_candidate} =     Run keyword and return status   wait until element is visible    ${CANDIDATE_INBOX}
    IF    '${is_has_candidate}' == 'False'
        # In case Company doesn't have Candidate yet
        wait until element is visible  ${CEM_CANDIDATE_EMPTY_ICON}
    END

Add a Candidate
    [Arguments]    ${group_name}=None    ${location_name}=None    ${job_name}=None    ${job_req_id}=None    ${is_spam_email}=True
    run keyword and ignore error    Click at    ${INBOX_ADD_CANDIDATE_BUTTON}
    ${candidate_first_name_random} =    Generate random text only
    ${candidate_last_name_random} =    Set Variable    Lname
    Input into    ${CEM_INPUT_FIRST_NAME_TEXT_BOX}    ${candidate_first_name_random}
    Input into    ${CEM_INPUT_LAST_NAME_TEXT_BOX}    ${candidate_last_name_random}
    &{email_info} =    Get email for testing    ${is_spam_email}
    Input into    ${CEM_INPUT_EMAIL_TEXT_BOX}    ${email_info.email}
    IF    '${location_name}' != 'None'
        Click at    ${CEM_LOCATION_DROPDOWN}
        Input into    ${CEM_LOCATION_SEARCH_TEXT_BOX}    ${location_name}
        Click at    ${CEM_LOCATION_VALUE}    ${location_name}
    END
    IF    '${group_name}' != 'None'
        Click at    ${GROUP_SELECTION_DROPDOWN}
        Input into    ${GROUP_SEARCH_TEXT_BOX}    ${group_name}
        Click at    ${CANDIDATE_GROUP_NAME_OPTION}    ${group_name}     2s
    END
    IF    '${job_name}' != 'None'
        Click at    ${GROUP_SELECTION_DROPDOWN}
        Input into    ${CEM_JOB_SEARCH_TEXT_BOX}    ${job_name}
        Click at    ${CANDIDATE_GROUP_NAME_OPTION}    ${job_name}
    END
    IF    '${job_req_id}' != 'None'
        Input into    ${CEM_JOB_REQ_ID_TEXT_BOX}    ${job_req_id}
        Click at    ${CEM_INPUT_LAST_NAME_TEXT_BOX}
    END
    Click on span text      Add Candidate
    Wait For Page Load Successfully
    [Return]    ${candidate_first_name_random}

Add a Candidate and Screen
    [Arguments]    ${location_name}=None    ${is_spam_email}=True
    Click at    ${INBOX_ADD_CANDIDATE_BUTTON}
    ${candidate_info} =      Generate candidate name
    Input into    ${CEM_INPUT_FIRST_NAME_TEXT_BOX}    ${candidate_info.first_name}
    Input into    ${CEM_INPUT_LAST_NAME_TEXT_BOX}    ${candidate_info.last_name}
    &{email_info} =    Get email for testing    is_spam_email=${is_spam_email}
    Input into    ${CEM_INPUT_EMAIL_TEXT_BOX}    ${email_info.email}
    IF    '${location_name}' != 'None'
        Click at    ${CEM_LOCATION_DROPDOWN}
        Input into    ${CEM_LOCATION_SEARCH_TEXT_BOX}    ${location_name}
        Click at    ${CEM_LOCATION_VALUE}    ${location_name}
    END
    Click at    ${DROPDOWN_CARET_BUTTON}
    Click at    ${ADD_AND_SCREEN}
    wait for page load successfully v1
    [Return]    ${candidate_info.first_name}

Change conversation status
    [Arguments]    ${candidate_name}    ${task}    ${task_status}
    Click at    ${candidate_name}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    ${is_more_option} =     Run keyword and return status   Check element display on screen  More Option  wait_time=2s
    Run keyword if  ${is_more_option}   Click at    More Option
    Click by JS     ${JOURNEY_TASK_OPTION}    ${task}
    Click at    ${JOURNEY_TASK_STATUS_OPTION}    ${task_status}

Change conversation action status
    [Arguments]    ${candidate_name}    ${task}    ${task_status}    ${is_confirm}=True
    Click at    ${candidate_name}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    ${is_more_option} =     Run keyword and return status    Check element display on screen    More Option    wait_time=2s
    Run keyword if    ${is_more_option}    Click at    More Option
    ${is_not_active_task} =     Run keyword and return status    Check element not display on screen    ${JOURNEY_TASK_OPTION_ACTIVE}    ${task}    wait_time=2s
    Run Keyword if    ${is_not_active_task}    Click by JS    ${JOURNEY_TASK_OPTION}    ${task}
    Click at    ${JOURNEY_TASK_STATUS_OPTION}    ${task_status}
    IF  '${is_confirm}' == 'True'
        Click at    ${CEM_CANDIDATE_FORM_CONFIRM_BUTTON}
    END

Select Screening conversation and send
    [Arguments]    ${conversation_name}
    Click at    ${SCREENING_CONVERSATION_DROPDOWN}
    Input into    ${SCREENING_SEARCH_CONVERSATION_TEXTBOX}    ${conversation_name}
    ${conversation_locator} =    Format String    ${SCREENING_CONVERSATION_OPTION_BY_NAME}    ${conversation_name}
    Click at    ${conversation_locator}
    Click at    ${SCREENING_SEND_BUTTON}
    wait for page load successfully v1

Click on candidate name
    [Arguments]    ${candidate_name}
    ${candidate} =    format string    ${CEM_CANDIDATE_NAME}    ${candidate_name}
    Click by JS    ${candidate}

Updated conversation status
    [Arguments]    ${candidate_name}    ${task}    ${task_status}
    Click at    ${candidate_name}
    Click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    ${is_more_option} =     Run keyword and return status   Check element display on screen  More Options  wait_time=2s
    Run keyword if  ${is_more_option}   Click at    More Options
    ${is_display}=      run keyword and return status       Check element display on screen     ${JOURNEY_TASK_OPTION_OPENED}       ${task}
    IF      '${is_display}'=='False'
        Click by JS       ${JOURNEY_TASK_OPTION}       ${task}
    END
    Click at    ${JOURNEY_TASK_STATUS_OPTION}    ${task_status}
    ${is_display}=    run keyword and return status     Check element display on screen      ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    IF      '${is_display}'=='True'
        Click at      ${CONFIRM_STATUS_UPDATE_OK_BUTTON}
    END
    wait for page load successfully v1

Add interview schedule to candidate
    [Arguments]    ${user_name}    ${location_name}
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at    ${INTERVIEW_BUTTON}
    Close pendo popup
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}      slow_down=1s
    Click at    ${IN_PERSON_TYPE}       slow_down=1s
    Input location when add/update interview    ${location_name}
    Input attendes when add/update interview    ${user_name}
    Click at    ${SCHEDULING_SCHEDULE_BUTTON}
    Click at    ${CLOSE_SCHEDULE_BUTTON}

Add Have Attendee Schedule
    [Arguments]    ${user_name}    ${location_name}
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at    ${INTERVIEW_BUTTON}
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}      slow_down=1s
    Click at    ${IN_PERSON_TYPE}       slow_down=1s
    Input location when add/update interview    ${location_name}
    Input attendes when add/update interview    ${user_name}
    Click at    ${HAVE_ATTENDEE_SCHEDULE_TURN_ON}
    Click at    ${INPUT_SELECT_ATTENDEE}
    Click at    ${ATTENDEE_NAME}    ${user_name}
    Click on common text last    Have Attendee Schedule

Edit candidate
    [Arguments]    ${location}
    Click at    ${MORE_BUTTON}
    Click at    ${EDIT_CANDIDATE_BUTTON}
    Input location when add/ edit candidate    ${location}
    Click at    ${EDIT_CANDIDATE_SAVE_BUTTON}

Input location when add/update interview
    [Arguments]    ${location}
    Click at    ${INPUT_INTERVIEW_LOCATION}
    ${locator_location_name} =    Format String    ${NAME_LOCATION}    ${location}
    Click at    ${locator_location_name}

Input attendes when add/update interview
    [Arguments]    ${user_name}
    Click at    ${ADD_INTERVIEWER_BUTTON}
    Input into    ${INPUT_SEARCH_ATTENDEES}    ${user_name}
    Click at    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}     ${user_name}     slow_down=1s
    Click at    ${SAVE_INTERVIEWER_BUTTON}

Input location when add/ edit candidate
    [Arguments]    ${location}
    Click at    ${CEM_LOCATION_DROPDOWN}
    Input into    ${CEM_LOCATION_SEARCH_TEXT_BOX}    ${location}
    Click at    ${CEM_LOCATION_VALUE}    ${location}

Add event schedule to candidate
    [Arguments]    ${event_name}    ${first_name}    ${interview_session}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${first_name}
    Click at    ${candidate_name_locator}
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}
    Click at    ${SCHEDULE_EVENT_BUTTON}
    Close pendo popup
    Click at    ${EVENT_ID_DROPDOWN}
    Click at    ${event_name}
    Click at    ${interview_session}
    Click at    ${SUBMIT_SCHEDULE_BUTTON}   slow_down=1s
    Click at    ${ALL_CANDIDATES_SCHEDULE_EVENT_CLOSE_BUTTON}

Reschedule event interview
    [Arguments]    ${candidate_name}    ${event_name}   ${interview_session}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click at    ${candidate_name_locator}
    Click at    ${UPDATE_INTERVIEW}
    Click at    Reschedule
    Close pendo popup
    Click at    ${EVENT_ID_DROPDOWN}
    Click on common text last    ${event_name}
    Click at    ${interview_session}
    Click at    ${RESCHEDULE_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_EVENT_CLOSE_BUTTON}
    wait with medium time

Cancel event interview
    [Arguments]    ${candidate_name}
    ${candidate_name_locator} =    Format String    ${CANDIDATE_NAME_LOCATOR}    ${candidate_name}
    Click at    ${candidate_name_locator}
    Click at    ${UPDATE_INTERVIEW}
    Click at    ${SCHEDULING_SUMMARY_CANCEL_BUTTON}
    Click at    ${CANCEL_INTERVIEW_CONFIRM_BUTTON}
    Click at    ${ALL_CANDIDATES_SCHEDULE_CLOSE_BUTTON}
    wait with medium time

Open a candidate Conversation
    [Arguments]    ${candidate_name}
    Load more item in page    ${candidate_name}    ${CEM_OPEN_CANDIDATE_CONV}
    ${is_clicked} =  Run keyword and return status  Click at    ${candidate_name}
    IF   '${is_clicked}' == 'False'
        Search and click candidate on CEM   ${candidate_name}
    END

Open schedule module
    Click at    ${MORE_BUTTON}
    Click at    ${CANDIDATE_MENU_SCHEDULE_BUTTON}

Filter capture complete status for candidate
    click at    ${FILTER_ICON}
    click at    ${FILTER_TYPE_STATUS}
    click at    ${FILTER_STATUS_CAPTURE_COMPLETE}
    Wait with short time
    click at    ${FILTER_APPLY_BUTTON}

Check status on profile CEM
    [Arguments]    ${status}
    Check element display on screen    ${STATUS_PROFILE_CANDIDATE}    ${status}

Send Form trigger by manually
    wait with short time
    click at    ${SET_CANDIDATE_JOURNEYS_BUTTON}
    click at    ${FORM_BTN}  slow_down=5s
    wait with medium time
    click at    ${SEND_FORM_BTN}  slow_down=5s
    click at    ${OK_BTN_CONFIRM_BOX}
    wait for page load successfully

Select candidate by candidate link from canidate name
    [Arguments]    ${candidate_name}
    ${locator_can}=  format string   ${CANIDATE_LINK}  ${candidate_name}
    ${candidate_link}=  get element attribute  ${locator_can}   href
    Go to  ${candidate_link}
    wait for cem display

Search and click candidate on CEM
    [Arguments]     ${candidate_name}
    Click at    ${SEARCH_ICON_CEM}
    Check element display on screen     ${CEM_SEARCH_CANDIDATE_TEXT_ON_BODY_MODEL}      stage
    Check element display on screen     ${CEM_SEARCH_CANDIDATE_TEXT_ON_BODY_MODEL}      location
    Simulate Input      ${INPUT_SEARCH_CANDIDATE_CEM}     ${candidate_name}
    wait for page load successfully
    Capture page screenshot
    Click at    ${NAME_ON_SEARCH_CANDIDATE_CEM}     ${candidate_name}

Select candidate profile dropdown button
    [Arguments]  ${candidate_name}   ${job_title}   ${index}=None
    Open a candidate Conversation    ${candidate_name}
    Click at    ${CEM_CANDIDATE_PROFILE_BUTTON}
    #   Using index in case of 2 or more profiles have same information(job title, type, job req id)
    IF  '${index}' != 'None'
        ${locator} =  Format String  ${CEM_CANDIDATE_PROFILE_NAME_AND_INDEX}  ${index}  ${job_title}
        Click at    ${locator}
    ELSE
        Click at    ${CEM_CANDIDATE_PROFILE_NAME_TEXT}    ${job_title}
    END
    #   Check job is selected correctly
    IF   '${job_title}' == 'No Group Assigned'
        ${selected_title} =  Get text and format text  ${CEM_CANDIDATE_PROFILE_BUTTON}  ${job_title}
        should match regexp   ${selected_title}    No .* Assigned
    ELSE
        Verify text contain  ${CEM_CANDIDATE_PROFILE_BUTTON}  ${job_title}
    END

Change status of candidate with stage and status
    [Arguments]     ${candidate_name}   ${stage}    ${status}
    Click at        ${candidate_name}
    Click at        ${SET_CANDIDATE_JOURNEYS_BUTTON}
    Click on common text last       More Option
    IF  '${stage}' == 'Application'
        Click at        ${CEM_CANDIDATE_JOURNEY_APPLICATION_STATUS}
    ELSE IF     '${stage}' == 'Onboarding'
        Click at        ${CEM_CANDIDATE_JOURNEY_ONBOARDING_STATUS}
    ELSE IF     '${stage}' == 'Hire'
        Click at        ${CEM_CANDIDATE_JOURNEY_HIRE_STATUS}
    ELSE IF     '${stage}' == 'Conversation'
        Click at        ${CEM_CANDIDATE_JOURNEY_CONVERSATION_STATUS}
    END
    Check element display on screen     ${status}
    Click on common text last       ${status}
    Click on common text last       Confirm

Edit candidate form answer
    [Arguments]     ${candidate_name}   ${form_name}    ${title_question}       ${answer}
    Click at        ${candidate_name}
    Click at        ${form_name}
    Click by JS        ${CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME}      ${title_question}
    Click at        ${CEM_CANDIDATE_FORM_EDIT_FIELD_ICON}
    Input into      ${CEM_CANDIDATE_FORM_ANSWER_TEXTBOX_BY_QUESTION_NAME}       ${answer}       ${title_question}
    Click at        ${CEM_CANDIDATE_FORM_SAVE_BUTTON}
    Click at        ${CEM_CANDIDATE_FORM_CONFIRM_BUTTON}

# ====SECTION: NOTE AND SHARING ====

Open Share Candidate box
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Share
    Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_TITLE}
    Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_PEOPLE_BOX}
    capture page screenshot

Check suggestion user display
    [Arguments]     ${user_name}=None      ${email_or_phone}=None
    IF  '${user_name}'!= 'None'
        Check element display on screen     ${CEM_CANDIDATE_SHARE_MODAL_SUGGESTION_USER}    ${user_name}
    END
    IF   '${email_or_phone}' != 'None'
        Check element display on screen     ${CEM_CANDIDATE_SHARE_MODAL_SUGGESTION_USER_PHONE_EMAIL}    ${email_or_phone}
    END

Check UI of Share Candidate box after input username
    [Arguments]     ${number_user}      ${user_name_1}      ${user_name_2}=None        ${user_name_3}=None
    Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_MESSAGE_BOX}
    Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_OPTION}             Include message on internal notes
    IF      ${number_user}==1
        ${option_content}=    set variable      Keep message private between you and ${user_name_1}
        Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_OPTION}     ${option_content}
        Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_RADIO_OPTION_CHECKED}                       ${option_content}
    END
    IF         ${number_user}==2
        ${option_content}=   set variable      Keep message private between you, ${user_name_1}, and ${user_name_2}
        Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_OPTION}     ${option_content}
        Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_RADIO_OPTION_CHECKED}                       ${option_content}
    END
    IF         ${number_user}> 2
        ${number}=              evaluate                ${number_user} - 2
        ${option_content}=   set variable   Keep message private between you, ${user_name_1}, ${user_name_2}, and +${number} more
        Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_OPTION}     ${option_content}
        Check element display on screen                 ${CEM_CANDIDATE_SHARE_MODAL_RADIO_OPTION_CHECKED}                       ${option_content}
    END

Add a username into People box
    [Arguments]     ${user_name}
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_PEOPLE_BOX}
    Input into      ${CEM_CANDIDATE_SHARE_MODAL_PEOPLE_BOX}         @${user_name}
    Check suggestion user display     ${user_name}
    capture page screenshot
    Click at        ${CEM_CANDIDATE_SHARE_MODAL_SUGGESTION_USER}    ${user_name}

Input into Share Candidate box
    [Arguments]     ${user_name}      ${share_option}    ${content_message}=None
    Add a username into People box         ${user_name}
    IF      '${content_message}' != 'None'
        Input into      ${CEM_CANDIDATE_SHARE_MODAL_MESSAGE_BOX}        ${content_message}
    END
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_OPTION}       ${share_option}
    Click at    ${CEM_CANDIDATE_SHARE_MODAL_SEND_CANCEL_BUTTON}     Send
    Check element display on screen     ${CEM_ADD_NOTE_SUCCESS_MESSAGE}     This candidate has been shared

Mention a user into note
    [Arguments]     ${user_name}        ${note_content}=None
    input into          ${CEM_ADD_A_NOTE_TEXTBOX}   @
    Verify text contain     ${CEM_ADD_A_NOTE_TEXTBOX}       @
    Click at    ${CEM_NOTE_MENTION_USER_NAME}       ${user_name}
    IF  ${note_content}!=None
        input into          ${CEM_ADD_A_NOTE_TEXTBOX}   ${note_content}
    END
    Click at    ${CEM_ADD_NOTE_BUTTON}
    Check element display on screen     Note added successfully!

Delete a note
    [Arguments]     ${content_note}
    Click at    ${CEM_CANDIDATE_INTERNAL_NOTE_MENU_ITEM}    ${content_note}
    Click at    ${CEM_CANDIDATE_NOTE_MODAL_ICON}     delete
    Check element display on screen     ${CEM_CANDIDATE_DELETE_CONFIRM_MODAL_TITLE}
    Click at    ${CEM_CANDIDATE_DELETE_CONFIRM_MODAL_BUTTON}    Delete
    Check element not display on screen     ${CEM_CANDIDATE_INTERNAL_NOTE_CONTENT}      ${content_note}

Edit a note
    [Arguments]     ${current_user_name}        ${new_user_name}=None       ${note_message}=None
    Click at                ${CEM_CANDIDATE_INTERNAL_NOTE_MENU_MENTION_USER_ITEM}                    ${current_user_name}
    Click at                ${CEM_CANDIDATE_NOTE_MODAL_ICON}                edit
    Check element display on screen                 ${CEM_ADD_NOTE_MODAL_MENTION_ICON}
    capture page screenshot
    Click at                ${CEM_CANDIDATE_NOTE_MODAL_CONTENT}
    Press Keys              ${CEM_CANDIDATE_NOTE_MODAL_CONTENT}             \DELETE
    IF      '${new_user_name}'!='None'
        Input into              ${CEM_CANDIDATE_NOTE_MODAL_CONTENT}             @
        Click at                ${CEM_CANDIDATE_NOTE_MODAL_MENTION_ITEM}        ${new_user_name}
    END
    IF      '${note_message}'!='None'
        Input into              ${CEM_CANDIDATE_NOTE_MODAL_CONTENT}         ${note_message}
    END
    Click at                ${CEM_CANDIDATE_NOTE_MODAL_SAVE_CANCEL_BUTTON}      Save

Get elements and convert to list
    [Arguments]     ${locator}
    ${elements_list}=       get webelements     ${locator}
    @{name_list}=    Create List
    FOR     ${i}       IN      @{elements_list}
        ${text} =       Get text    ${i}
        append to list      ${name_list}     ${text}
    END
    [Return]    @{name_list}

#   ====END SECTION: NOTE AND SHARING ====

Upload a file with type in Hire Details
    [Arguments]     ${file_type}    ${element_locator}=None
    IF  '${element_locator}' == 'None'
        ${element_locator} =    Set variable     ${CEM_HIRE_DETAILS_UPLOAD_FILE}
    END
    IF  '${file_type}' == 'PDF'
        ${path_image} =    get_path_upload_pdf_path    Authorization_for_Payroll_Deduction
    ELSE IF     '${file_type}' == 'Image'
        ${path_image} =    get_path_upload_image_path    cat-kute
    END
    ${element} =    Get Webelement    ${element_locator}
    EXECUTE JAVASCRIPT
    ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px;');
    ...    ARGUMENTS    ${element}
    Input into    ${element_locator}    ${path_image}
    Verify text contain     ${TOASTED_MESSAGE_SUCCESS}     Your file was successfully uploaded

Add a Candidate Segment
    [Arguments]     ${name}=None  ${assign_segment_name}=None  ${status}=None   ${location}=None    ${is_admin}=Fasle
    Go To CEM Page
    Click At    ${FILTER_ICON}
    IF  "${status}" != "None"
        Click At    ${FILTER_TYPE_STATUS}
        ${type} =   Evaluate    type($status).__name__
        IF  '${type}' == 'list'
            FOR   ${item}   IN    @{status}
                Check The Checkbox    ${FILTER_PATTERN_STATUS_CHECKBOX}     ${item}
            END
        ELSE
            Check The Checkbox    ${FILTER_PATTERN_STATUS_CHECKBOX}     ${status}
        END
    END
    IF  "${location}" != "None"
        Click At    ${FILTER_TYPE_LOCATION}
        ${type} =   Evaluate    type($location).__name__
        IF  '${type}' == 'list'
            FOR   ${item}   IN    @{location}
                Check The Checkbox    ${FILTER_PATTERN_LOCATION_CHECKBOX}     ${item}
            END
        ELSE
            Check The Checkbox    ${FILTER_PATTERN_LOCATION_CHECKBOX}     ${location}
        END
    END
    Click At    ${FILTER_SAVE_SEGMENT_BUTTON}
    # Input name segments
    IF  '${name}' == 'None'
        ${name} =   Generate random name only text  Segment
    END
    Input Into    ${SEGMENT_MODEL_NAME_INPUT}    ${name}
    # Select assign_segment
    IF     '${is_admin}' == 'True'
        Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_DROPDOWN}
        IF  '${assign_segment_name}' == 'None'
            Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_ALL}
        ELSE
            Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_SELF}     ${assign_segment_name}
        END
        Click At    ${SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL}       Apply
    END
    Click At    ${SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON}    Save
    Wait For Page Load Successfully V1
    Check Element Display On Screen    ${CEM_SEGMENT_TITLE}     ${name}
    Capture Page Screenshot
    [Return]    ${name}

Delete a Candidate Segment
    [Arguments]    ${name}    ${all}=False
    Go To CEM Page
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Capture Page Screenshot
    Scroll to element    ${LEFT_MENU_PATTERN_SEGMENT}    ${name}
    Capture Page Screenshot
    Run Keyword And Ignore Error    Hover at    ${LEFT_MENU_PATTERN_SEGMENT}    ${name}
    Capture Page Screenshot
    Click At    ${LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON}    ${name}
    IF    '${all}' == 'True'
        Click at    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}    Segment Setting
        Click at    ${SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON}    Delete
        Click at    ${SEGMENT_EDIT_MODEL_DELETE_SEGMENT_DELETE_CANCEL}    Delete
    ELSE
        Click At    ${LEFT_MENU_SEGMENT_TOOL_PATTERN}     Delete
        Click At    ${LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON}      Delete
    END
    Wait For Page Load Successfully V1

Is Candidate Segment Existence
    [Arguments]    ${name}
    Go To CEM Page
    Click At    ${LEFT_MENU_BUTTON}
    Run Keyword And Ignore Error    Click At    ${LEFT_MENU_MORE}
    Check Element Display On Screen    ${LEFT_MENU_PATTERN_SEGMENT}     ${name}
    Capture Page Screenshot

Create Candidate with next steps and click status dropdown
    [Arguments]    ${job_name}    ${location}    ${status_name}=Capture Complete
    Go to CEM page
    ${candidate_name}=    Add a Candidate    job_name=${job_name}    location_name=${location}
    Click on candidate name    ${candidate_name}
    #Click on the status dropdown
    Click at    ${STATUS_PROFILE_CANDIDATE}    ${status_name}

Check the items displayed or not in Candidate Option on CEM page
    [Arguments]    ${list_options_displayed}    ${list_options_excluded}
    # Check the items displayed in More option
    FOR    ${item}    IN      @{list_options_displayed}
        Check Element Display On Screen     ${CEM_MORE_OPTION_ITEMS}    ${item}
    END
    # Check the items not displayed in More option
    FOR     ${item_not_displayed}   IN      @{list_options_excluded}
        Check Element Not Display On Screen    ${item_not_displayed}
    END

Open filter modal
    Go to CEM page
    Click at    ${FILTER_ICON}

Get all candidate's attribute
    [Arguments]    ${pattern}    ${row}
    ${locator}=    Format String    ${pattern}    ${row}
    Scroll to bottom of table    ${CANDIDATE_SCROLLBAR}    ${LOADING_ICON_3}
    ${list_attribute}=    Get elements and convert to list    ${locator}
    [Return]    ${list_attribute}

Wait for fully load filter item
    wait for page load successfully v1
    Scroll to bottom of table    ${FILTER_SCROLL_VIEW}

# ==== SECTION: REVIEW OFFER ====

Select offer to send
    [Arguments]     ${offer_name}
    Click at    ${CONFIRM_OFFER_SELECT_OFFER_DROPDOWN}
    Click at    ${CONFIRM_OFFER_SELECT_OFFER_OPTION}    ${offer_name}

Fill all required fields in offer
    [Arguments]     ${starting_pay_rate}       ${unit}       ${offer_name}
    &{offer_data}=      create dictionary
    ${is_display}=    run keyword and return status     Check element display on screen     ${CONFIRM_OFFER_SELECT_OFFER_DROPDOWN}
    IF      '${is_display}'=='True'
        Select offer to send        ${offer_name}
    END
    capture page screenshot
    # get valid start date value
    ${date} = 	Get Current Date
    ${current_year}=       Get Substring       ${date}     -5
    ${year_input_value}=   evaluate    ${current_year}+1
    ${start_date}=    set variable        01/01/${year_input_value}
    # fill in offer
    Input into      ${CONFIRM_OFFER_START_DATE}     ${start_date}
    Press Keys      ${CONFIRM_OFFER_START_DATE}     TAB
    Input into      ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}    ${starting_pay_rate}
    IF      '${unit}'!='per hour'
        Click at    ${CONFIRM_OFFER_SELECT_PAY_RATE_DROPDOWN}
        Click at    ${CONFIRM_OFFER_SELECT_PAY_RATE_VALUE}      ${starting_pay_rate}
    END
    ${offer_data.start_date}=      set variable    ${start_date}
    ${offer_data.starting_pay_rate}=      set variable    ${starting_pay_rate}
    ${offer_data.unit}=      set variable    ${unit}
    [Return]    &{offer_data}

Send offer
    [Arguments]    ${candidate_name}    ${starting_pay_rate}    ${offer_name}       ${unit}=None
    Updated conversation status      ${candidate_name}       Offer   Send Offer
    #fill all fields required in offer
    IF      '${unit}'=='None'
        Fill all required fields in offer     ${starting_pay_rate}      per hour    ${offer_name}
    ELSE
        Fill all required fields in offer     ${starting_pay_rate}      ${unit}     ${offer_name}
    END
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}       Your offer has been sent
    capture page screenshot

Upload an offer
    [Arguments]     ${file_name}=cat-kute.jpg
    ${image_path} =    get_path_upload_image_path   ${file_name}
    Choose file     ${REVIEW_OFFER_INPUT_FILE_UPLOAD}       ${image_path}
    wait for page load successfully v1
    Check element not display on screen     Drag a file here or click to browse
    capture page screenshot
    [Return]    ${file_name}

Send external offer
    [Arguments]     ${candidate_name}
    Updated conversation status      ${candidate_name}       Offer   Send Offer
    Check element display on screen     Review Offer
    ${file_name}=   Upload an offer
    Click at    ${CONFIRM_OFFER_SEND_BUTTON}
    Check element display on screen     ${TOASTED_MESSAGE_CONTENT}       Your offer has been sent
    capture page screenshot
    [Return]    ${file_name}

#   ====END SECTION: REVIEW OFFER ====

Create a candidate and change status to Interview Pending
    [Arguments]    ${job_name}    ${location}    ${user_name}
    ${candidate_name}=    Add a Candidate     job_name=${job_name}     location_name=${location}
    Click on candidate name    ${candidate_name}
    Click at    ${STATUS_PROFILE_CANDIDATE}    Capture Complete
    Click at    ${STATUS_PROFILE_CANDIDATE_DROPDOWN}    Scheduling
    Click at    ${STATUS_OPTION_ITEM}    Invite to Interview
    Click at    ${UPDATE_STATUS_CONFIRM_BUTTON}
    Click at    ${INTERVIEW_BUTTON}
    Close pendo popup
    Click at    ${SCHEDULE_INTERVIEW_TYPE_DROPDOWN}      slow_down=1s
    Click at    ${IN_PERSON_TYPE}       slow_down=1s
    Input location when add/update interview    ${location}
    Input attendes when add/update interview    ${user_name}
    Click at    ${SCHEDULING_SCHEDULE_BUTTON}    slow_down=2s
    Click at    ${CLOSE_SCHEDULE_BUTTON}

Get all employee referred
    Go to referred-by page
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${TIME_FILTER_COMBOBOX}
    IF    '${is_existed}' == 'True'
        Click at    ${TIME_FILTER_COMBOBOX}
        Click at    All time
    END
    Scroll to bottom of table     ${EMPLOYEE_REFERRED_TABLE}      interval=3000
    ${list_employee_referred}=    Get elements and convert to list    ${EMPLOYEE_REFERRED_ALL_NAME}
    [Return]    ${list_employee_referred}

# ====SECTION: ABOUT ====

Verify candidate summary item
    [Arguments]    ${candidate_name}    ${email}=None    ${phone_number}=None
    Open a candidate Conversation    ${candidate_name}
    Run Keyword If    '${email}' != 'None'    Check element display on screen    ${CEM_CANDIDATE_SUMMARY_CONTENT}    ${email}
    Run Keyword If    '${phone_number}' != 'None'    Check element display on screen    ${CEM_CANDIDATE_SUMMARY_CONTENT}    ${phone_number}

# ====END SECTION: ABOUT ====
