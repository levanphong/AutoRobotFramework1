*** Settings ***
Resource    ../../drivers/driver_chrome.robot
Resource    ../../pages/base_page.robot
Resource    ../../pages/microlearning_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          test

*** Variables ***
${question_1}       How long is the course?
${question_2}       When does the course end?
${question_3}       What is this course about?
${question_4}       How many lessons are there?
${question_5}       What is my course progress?
${question_6}       When is my next lesson?
${question_7}       Nope
${question_8}       Yes, I have one.

*** Test Cases ***
Check the FAQ tab when a course is created (OL-T11172)
    Given Setup test
    When Login into system with company             ${PARADOX_ADMIN}             ${COMPANY_EVENT}
    go to microlearning page
    ${course_name} =        Add A Course            auto_course
    Check course is added                           ${course_name}
    Go to course detail                             ${course_name}
    Click at                                        ${DETAIL_COURSE_PAGE_TAB_HEADER}        FAQ
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_1}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_2}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_NOT_STATUS}      ${question_3}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_4}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_5}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_6}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_7}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question_8}
    Click and check element status       ${question_8}
    Click and check element status       ${question_7}
    Click and check element status       ${question_6}
    Click and check element status       ${question_5}
    Click and check element status       ${question_4}
    Click and check element status       ${question_2}
    Click and check element status       ${question_1}
    Click at                                        ${DETAIL_COURSE_QUESTION_ECLIPSE_ICON}      ${question_3}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_CHANGE_STATUS_BUTTON}     ${question_3}

Microlearning - Verify UI of answer page and default answer of each question (OL-T11177)
    Given Setup test
    When Login into system with company             ${PARADOX_ADMIN}             ${COMPANY_EVENT}
    go to microlearning page
    ${course_name} =        Add A Course            auto_course
    Check course is added                           ${course_name}
    Go to course detail                             ${course_name}
    Click at                                        ${DETAIL_COURSE_PAGE_TAB_HEADER}        FAQ
    Check elements question display on screen      ${course_name}      ${question_1}       Duration             Great question! #course-name is #course-lesson-total lessons long
    Check elements question display on screen      ${course_name}      ${question_2}       EndTime              \#course-name will end on #course-end-date
    Check elements question display on screen      ${course_name}      ${question_4}       LessonNumber         \#course-name has #course-lesson-total
    Check elements question display on screen      ${course_name}      ${question_5}       MyCourseProgress     Your next lesson is on #next-lesson-date keep up the great work!
    Check elements question display on screen      ${course_name}      ${question_6}       MyNextLesson         Your next lesson is coming up fast and will be on #next-lesson-date :)
    Check elements question display on screen      ${course_name}      ${question_7}       No                   Great, let me know if you have any additional questions
    Check elements question display on screen      ${course_name}      ${question_8}       Yes                  Great! How can I assist you?
    Check element What is this course about? question   ${course_name}

*** Keywords ***
Click and check element status
    [Arguments]     ${question}
    Click at                                        ${DETAIL_COURSE_QUESTION_ECLIPSE_ICON}      ${question}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_CHANGE_LIVE_STATUS_BUTTON}     ${question}

Check elements question display on screen
    [Arguments]   ${course_name}    ${question}     ${name}     ${texts}
    Click at                                        ${DETAIL_COURSE_RESPONSE_LIVE_STATUS}     ${question}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_TITLE}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_COURSE_NAME_TITLE}     ${course_name}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_COURSE_TITLE}          ${name}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_CONTENT}
    ${text} =    Get text    ${DETAIL_COURSE_RESPONSE_QUESTION_CONTENT}
    Should Be Equal As Strings       ${text}        ${texts}
    Click at                                        ${DETAIL_COURSE_RESPONSE_QUESTION_BACK_BUTTON}

Check element What is this course about? question
    [Arguments]   ${course_name}
    Click at                                        ${DETAIL_COURSE_RESPONSE_NOT_STATUS}       ${question_3}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_TITLE}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_COURSE_NAME_TITLE}     ${course_name}
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_COURSE_TITLE}          Introduction
    Check element display on screen                 ${DETAIL_COURSE_RESPONSE_QUESTION_CONTENT}
    ${text} =    Get text    ${DETAIL_COURSE_RESPONSE_QUESTION_CONTENT}
    Should Be Equal As Strings       ${text}        \
    Check token list displayed in question
    Click at                                        ${DETAIL_COURSE_RESPONSE_HASHTAG_TEXT}
    wait for page load successfully v1
    Click at                                        ${DETAIL_COURSE_RESPONSE_SAVE_BUTTON}
    Click at                                        ${DETAIL_COURSE_RESPONSE_QUESTION_BACK_BUTTON}
