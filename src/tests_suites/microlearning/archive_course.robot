*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/microlearning_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Test Cases ***
Check if user is able to click on Archive action of a course (OL-T10535)
    Given Setup test
    When Login into system with company             ${PARADOX_ADMIN}             ${COMPANY_EVENT}
    go to microlearning page
    ${course_name} =        Add A Course            auto_course
    Check course is added                           ${course_name}
    Open eclipse menu icon of course     ${course_name}
    Click at    ${COURSE_ECLIPSE_ARCHIVE_MENU_CANCEL_BUTTON}
    Check element not display on screen    ${COURSE_ARCHIVE_FORM}
    Open eclipse menu icon of course     ${course_name}
    Click at    ${COURSE_ECLIPSE_ARCHIVE_MENU_X_BUTTON}
    Check element not display on screen    ${COURSE_ARCHIVE_FORM}
    Open eclipse menu icon of course     ${course_name}
    Click at                ${COURSE_ECLIPSE_ARCHIVE_MENU_ARCHIVE_BUTTON}
    Check element not display on screen             ${COURSE_NAME_LABEL}
    Check Archive Course successfully               ${course_name}

Check if the cancellation message is sent when the course is archived (OL-T10555)
#   TODO: Can't check SMS cancellation message right now
    Given Setup test
    When Login into system with company             ${PARADOX_ADMIN}             ${COMPANY_EVENT}
    go to microlearning page
    ${course_name} =        Add A Course            auto_course
    Check course is added                           ${course_name}
    Archive A Course        ${course_name}
