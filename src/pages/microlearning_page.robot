*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/users_roles_permissions_locators.py
Variables       ../locators/microlearning_locator.py
Variables       ../locators/all_candidates_locators.py

*** Keywords ***
Check course is added
    [Arguments]     ${course_name}
    Search course in microlearning page     ${course_name}
    check element display on screen     ${COURSE_ITEM_NAME_VALUE}  ${course_name}
    capture page screenshot

Check course is not added
    [Arguments]     ${course_name}
    Search course in microlearning page     ${course_name}
    check element not display on screen     ${COURSE_ITEM_NAME_VALUE}  ${course_name}
    capture page screenshot

Add A Course
    [Arguments]    ${course_name_prefix}
    Click at    ${ADD_NEW_COURSE_BUTTON}
    ${course_dynamic_name} =    Generate Random Name     ${course_name_prefix}
    Input into    ${ADD_NEW_COURSE_NAME_TEXT_BOX}   ${course_dynamic_name}
    Click at     ${CREATE_COURSE_BUTTON}
    wait for page load successfully v1
    [Return]    ${course_dynamic_name}

Archive A Course
    [Arguments]     ${course_name}
    Search course in microlearning page     ${course_name}
    Click at    ${COURSE_ECLIPSE_ICON}    ${course_name}
    Click at    ${COURSE_ECLIPSE_MENU_ARCHIVE_BUTTON}    ${course_name}
    Click at    ${COURSE_ECLIPSE_ARCHIVE_MENU_ARCHIVE_BUTTON}
    Check element not display on screen    ${COURSE_NAME_LABEL}     ${course_name}
    capture page screenshot

Search course in microlearning page
    [Arguments]    ${course_name}
    Input into    ${COURSE_SEARCH_TEXT_BOX}    ${course_name}
    Wait for the element to fully load  ${COURSES_LIST}

Check Microlearning option is added in Menu
    Click at    ${MENU_BUTTON}
    Check element display on screen  ${CEM_PAGE_RIGHT_MENU_MICROLEARNING}
    Capture page screenshot

Check infomation in create new course modal
    [Arguments]    ${start_day}
    Check element display on screen      ${COURSE_PAGE_START_DAY_ACTIVE_INPUT}     ${start_day}
    ${start_time_default}=    Get value and format text       ${COURSE_PAGE_START_TIME_DEFAULT_INPUT}
    Should be equal as strings    ${start_time_default}    08:00
    Element should be disabled      ${CREATE_COURSE_BUTTON}

Create a Course when Courses tab in empty state
    ${is_existed_course} =     Run keyword and return status    Check element display on screen     ${COURSE_PAGE_LIST}       Courses
	IF  '${is_existed_course}' == 'False'
        ${course_name} =  Add A Course     Course
        Check course is added   ${course_name}
        Archive A Course      ${course_name}
    END

Add New Media to new Course
    [Arguments]     ${media_type}   ${file_name}
    IF  '${media_type}' == 'Image/GIF'
        ${image_path} =    get_path_upload_image_path   ${file_name}
        ${element} =    Get Webelement    ${COURSE_PAGE_UPLOAD_FILE_INPUT}
        EXECUTE JAVASCRIPT
        ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
        ...    ARGUMENTS    ${element}
        Input into    ${COURSE_PAGE_UPLOAD_FILE_INPUT}    ${image_path}
        wait for page load successfully v1
    END

Open eclipse menu icon of course
    [Arguments]   ${item_dropdown}
    Click at    ${COURSE_ECLIPSE_ICON}    ${item_dropdown}
    Click at    ${COURSE_ECLIPSE_MENU_ARCHIVE_BUTTON}  ${item_dropdown}

Check Archive Course successfully
    [Arguments]     ${course_name}
    Click at    ${ARCHIVE_COURSE_PAGE}
    Check course is added           ${course_name}

Hover on group option check add button be visible
    [Arguments]    ${location_attribute_name}
    Hover at    ${LESSON_BUILDER_GROUP_OPTION}    ${location_attribute_name}
    Check element display on screen    ${LESSON_BUILDER_GROUP_OPTION_ADD_BUTTON}    ${location_attribute_name}

Go to course detail
    [Arguments]     ${course_name}
    Search course in microlearning page     ${course_name}
    check element display on screen     ${COURSE_ITEM_NAME_VALUE}  ${course_name}
    Click at    ${COURSE_ITEM_NAME_VALUE}  ${course_name}
    wait for page load successfully v1

Add a new block on Create your Lesson section
    [Arguments]     ${add_button}       ${button_name}
    ${block_number}=    Get Element Count    ${LESSON_BUILDER_MESSAGE_BLOCK_NUMBER}
    Click at        ${add_button}      ${button_name}
    wait for page load successfully v1
    ${block_number_after_create}=    Get Element Count    ${LESSON_BUILDER_MESSAGE_BLOCK_NUMBER}
    Should be true    ${block_number} < ${block_number_after_create}

Check a message block
    [Arguments]     ${message_content}      ${hashtag_token}    ${icon_grinning}
    ${length}=    Get length    ${message_content}
    Input into      ${LESSON_BUILDER_ADD_MESSAGE_TEXT}      ${message_content}
    wait for page load successfully v1
    ${text}=    Get Text    ${LESSON_BUILDER_ADD_MESSAGE_COUNTER}
    ${charactor_number} =    Split String    ${text}    /
    ${number} =    get from list    ${charactor_number}    0
    Should be true          ${number}==${length}
    Click at    ${LESSON_BUILDER_ADD_MESSAGE_EMOJI_ICON}
    Check element display on screen     ${LESSON_BUILDER_ADD_MESSAGE_EMOJI_ICON_MENU}
    wait for page load successfully v1
    Click at    ${LESSON_BUILDER_ADD_MESSAGE_EMOJI_ICON_VALUE}      ${icon_grinning}
    wait for page load successfully v1
    Check element display on screen     ${LESSON_BUILDER_ADD_ICON_IN_MESSAGE_TEXT}
    Check hashtag list displayed in create your lesson
    Click at    ${LESSON_BUILDER_ADD_MESSAGE_HASHTAG_TEXT_VALUE}        ${hashtag_token}
    wait for page load successfully v1
    Verify display text    ${LESSON_BUILDER_ADD_MESSAGE_HIGHLIGHT_TEXT}    \#${hashtag_token}
    capture page screenshot

Check hashtag list displayed in create your lesson
    Click at    ${LESSON_BUILDER_ADD_MESSAGE_HASHTAG_ICON}
    wait for page load successfully v1
    ${hashtag_list} =    Get token list in create your lesson
    Check element existed in list    employee-firstname    ${hashtag_list}
    Check element existed in list    employee-fullname    ${hashtag_list}
    Check element existed in list    ai-name    ${hashtag_list}
    Check element existed in list    course-name    ${hashtag_list}
    Check element existed in list    company-name    ${hashtag_list}
    Check element existed in list    lesson-name    ${hashtag_list}
    Check element existed in list    brand-name    ${hashtag_list}
    Check element existed in list    course-start-date    ${hashtag_list}
    Check element existed in list    course-end-date    ${hashtag_list}
    Check element existed in list    course-length    ${hashtag_list}
    Check element existed in list    next-lesson    ${hashtag_list}
    Check element existed in list    next-lesson-date    ${hashtag_list}
    Check element existed in list    employee-location   ${hashtag_list}
    Check element existed in list    employee-timezone    ${hashtag_list}
    Capture page screenshot

Get token list in create your lesson
    ${hashtag_list} =    Create List
    ${hashtag_elements} =    Get WebElements    ${LESSON_BUILDER_ADD_MESSAGE_HASHTAG_TEXT}
    FOR    ${element}    IN    @{hashtag_elements}
        Append To List    ${hashtag_list}    ${element.get_attribute('innerHTML')}
    END
    [Return]    ${hashtag_list}

Check token list displayed in question
    Click at    ${DETAIL_COURSE_RESPONSE_HASHTAG_ICON}
    wait for page load successfully v1
    ${hashtag_list} =    Get token list in question
    Check element existed in list    course-name    ${hashtag_list}
    Check element existed in list    course-lesson-number    ${hashtag_list}
    Check element existed in list    course-end-date    ${hashtag_list}
    Check element existed in list    next-lesson-date    ${hashtag_list}
    Check element existed in list    current-lesson-progress   ${hashtag_list}
    Check element existed in list    course-lesson-total   ${hashtag_list}
    Capture page screenshot

Get token list in question
    ${hashtag_list} =    Create List
    ${hashtag_elements} =    Get WebElements    ${DETAIL_COURSE_RESPONSE_HASHTAG_TEXT}
    FOR    ${element}    IN    @{hashtag_elements}
        Append To List    ${hashtag_list}    ${element.get_attribute('innerHTML')}
    END
    [Return]    ${hashtag_list}

Delete a block is added on Create your Lesson section
    Hover at    ${LESSON_BUILDER_ADD_MESSAGE_TEXT_BOX}
    Click at    ${LESSON_BUILDER_ADD_MESSAGE_DELETE_BUTTON}
    wait for page load successfully v1
    Click at    ${LESSON_BUILDER_ADD_MESSAGE_DELETE_MODAL_BUTTON}
    wait for page load successfully v1

Check a image block
    [Arguments]     ${media_type}   ${file_name}
    IF  '${media_type}' == 'Image/GIF'
        ${image_path} =    get_path_upload_image_path   ${file_name}
        ${element} =    Get Webelement    ${LESSON_BUILDER_ADD_IMAGE_UPLOAD_FILE_INPUT}
        EXECUTE JAVASCRIPT
        ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px;');
        ...    ARGUMENTS    ${element}
        Input into    ${LESSON_BUILDER_ADD_IMAGE_UPLOAD_FILE_INPUT}    ${image_path}
        wait for page load successfully v1
        capture page screenshot
    END

Add a new question on Create your Lesson section
    [Arguments]     ${add_button}       ${button_name}
    ${block_number}=    Get Element Count    ${LESSON_BUILDER_MESSAGE_BLOCK_NUMBER}
    Click at        ${add_button}      ${button_name}
    wait for page load successfully v1
    Check element display on screen     ${LESSON_BUILDER_ADD_QUESTION_MODAL}

Check more maximum number of answers for a question
    @{answer_list} =    create list    A      B       C       D
    FOR    ${answer}    IN    @{answer_list}
        ${value_message}=   Get text     ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_NUMBER}
        Should be equal as strings      ${value_message}     ${answer}.
        Click at    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADD_OPTION}
        wait for page load successfully v1
    END
    Verify element is disable       ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADD_OPTION}

Check a new answer for a question
    Set Focus To Element    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CONTENT}
    Input Into    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CONTENT}         ${message_content}
    wait for page load successfully v1
    ${text} =    Get value    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CONTENT}
    Should be equal as strings      ${text}     ${message_content}
    Click at    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CONTENT}
    ${assistant_default}=        Get assistant default
    Mouse Over    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CHAT_ICON}
    Verify tooltip is display in lesson builder    Add a response from ${assistant_default} when this answer is selected by employees.
    Mouse Over    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_DELETE_ICON}
    Verify tooltip is display in lesson builder    Delete

Verify tooltip is display in lesson builder
    [Arguments]    ${tooltip}
    ${locator} =    Format String    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_TOOLTIP_MESSAGE}    ${tooltip}
    Element should be visible    ${locator}

Get assistant default
    [Documentation]
    ...    In this keyword, I want get name of default assistant for each instances
    ...    With TEST instance, name of default assistant is Olivia
    ${CONFIG} =    get_config    ${env}
    IF  '${env}' == 'TEST'
        ${assistant_default}=   Set Variable   Olivia
    END
    [Return]    ${assistant_default}

Check a reponse answer for a question
    ${assistant_default}=        Get assistant default
    Click at    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CONTENT}
    Click at    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CHAT_ICON}
    Check element display on screen     ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_AVATAR}
    Check element display on screen     ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_TEXTAREA}      Add a response from ${assistant_default}
    Check element display on screen     ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_CHAT_ICON_ACTIVE}
    Set Focus To Element    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_TEXTAREA_VALUE}
    Input Into    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_TEXTAREA_VALUE}         ${message_content}
    wait for page load successfully v1
    ${text} =    Get value    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_TEXTAREA_VALUE}
    Should be equal as strings      ${text}     ${message_content}

Create a new question
    Input Into    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_QUESTION_TEXTAREA}         ${message_content}
    wait for page load successfully v1
    ${text} =    Get value    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_QUESTION_TEXTAREA}
    Should be equal as strings      ${text}     ${message_content}
    @{answer_list} =    create list    A      B       C       D
    FOR    ${answer}    IN    @{answer_list}
        ${value_message}=   Get text     ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADDED_ANSWER_NUMBER}
        Should be equal as strings      ${value_message}     ${answer}.
        Check a new answer for a question
        Check a reponse answer for a question
        Click at    ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADD_OPTION}
        wait for page load successfully v1
    END
    Verify element is disable       ${LESSON_BUILDER_ADD_QUESTION_MODAL_ADD_OPTION}
