*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/microlearning_page.robot
Resource            ../../pages/client_setup_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test

*** Variables ***
${start_day_default}        mon
${message_content}          auto_test_new_message_content
${hashtag_token}            ai-name
${icon_grinning}            :grinning:
${add_message_option}       Add Message
${add_image_option}         Add Image
${add_question_option}      Add Question

*** Test Cases ***
Check if Employees section is available on Client Setup page when logging in as Super Admin users (OL-T5461)
    Given Setup test
    when Login into system with company             ${ViewOnly}             ${COMPANY_NEXT_STEP}
    Navigate to Option in client setup              More
    Then Check toggle is Off                        ${MICROLEANING_TOGGLE}


Check if user is able to turn on the Microlearning toggle (OL-T5463)
    Given Setup test
    when Login into system with company             ${ViewOnly}             ${COMPANY_FRANCHISE_ON}
    Navigate to Option in client setup              More
    Then Check toggle is On                         ${MICROLEANING_TOGGLE}
    Check Microlearning option is added in Menu


Check if user is able to create a course successfuly (OL-T10485)
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    Go to microlearning page
    Click at                ${ADD_NEW_COURSE_BUTTON}
    Check infomation in create new course modal     ${start_day_default}
    Click at                ${CANCEL_COURSE_BUTTON}
    Create a Course when Courses tab in empty state


Check if user is able to upload image with valid format: .JPG .PNG .GIF (OL-T10486)
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    Go to microlearning page
    Click at                ${ADD_NEW_COURSE_BUTTON}
    Add New Media to new Course                     Image/GIF               cat-kute


Check if user is able to add a message when creating a lesson (OL-T10490, OL-T10492)
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    go to microlearning page
    ${course_name} =        Add A Course            Course
    Go to course detail     ${course_name}
    Click at                ${DETAIL_COURSE_PAGE_TAB_HEADER}                Coursework
    Click at                ${LESSON_ADD_BUTTON}
    wait for page load successfully v1
    Hover on group option check add button be visible                       ${add_message_option}
    Hover on group option check add button be visible                       ${add_image_option}
    Hover on group option check add button be visible                       Add Question
    Add a new block on Create your Lesson section                           ${LESSON_BUILDER_GROUP_OPTION_ADD_BUTTON}       ${add_message_option}
    Check a message block                           ${message_content}      ${hashtag_token}        ${icon_grinning}
    Delete a block is added on Create your Lesson section
    Add a new block on Create your Lesson section                           ${LESSON_BUILDER_GROUP_OPTION_ADD_BUTTON}       ${add_image_option}
    Check a image block     Image/GIF               cat-kute
    Delete a block is added on Create your Lesson section
    go to microlearning page
    Archive A Course        ${course_name}


Check if user is able to add up to 4 answers per question (OL-T10496, OL-T10497, OL-T10498)
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    go to microlearning page
    ${course_name} =        Add A Course            Course
    Go to course detail     ${course_name}
    Click at                ${DETAIL_COURSE_PAGE_TAB_HEADER}                Coursework
    Click at                ${LESSON_ADD_BUTTON}
    wait for page load successfully v1
    Hover on group option check add button be visible                       ${add_question_option}
    Add a new question on Create your Lesson section                        ${LESSON_BUILDER_GROUP_OPTION_ADD_BUTTON}       ${add_question_option}
    wait for page load successfully v1
    Check a new answer for a question
    Check a reponse answer for a question
    Check more maximum number of answers for a question
    Click at                ${LESSON_BUILDER_ADD_QUESTION_MODAL_CANCEL_BUTTON}
    wait for page load successfully v1
    Click at                ${LESSON_BUILDER_DISCARD_QUESTION_DISCARD_BUTTON}
    go to microlearning page
    Archive A Course        ${course_name}


Check if user is able to save an answer successfully (OL-T10500)
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    go to microlearning page
    ${course_name} =        Add A Course            Course
    Go to course detail     ${course_name}
    Click at                ${DETAIL_COURSE_PAGE_TAB_HEADER}                Coursework
    Click at                ${LESSON_ADD_BUTTON}
    wait for page load successfully v1
    Hover on group option check add button be visible                       ${add_question_option}
    Add a new question on Create your Lesson section                        ${LESSON_BUILDER_GROUP_OPTION_ADD_BUTTON}       ${add_question_option}
    wait for page load successfully v1
    Create a new question
    Click at                ${LESSON_BUILDER_ADD_QUESTION_MODAL_SAVE_BUTTON}
    wait for page load successfully v1
    Click at                ${LESSON_BUILDER_ADD_MESSAGE_EDIT_BUTTON}
    wait for page load successfully v1
    Check element display on screen                 ${LESSON_BUILDER_EDIT_QUESTION_MODAL}
    Click at                ${LESSON_BUILDER_ADD_QUESTION_MODAL_CANCEL_BUTTON}
    Delete a block is added on Create your Lesson section
    go to microlearning page
    Archive A Course        ${course_name}
