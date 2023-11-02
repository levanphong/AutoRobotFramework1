*** Settings ***
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
@{status}               Capture Complete    Capture Incomplete
@{OL_R991_Segment}      OL-R991 Segment_1    OL-R991 Segment_2    OL-R991 Segment_3

*** Test Cases ***
Prepare datatest for segment
    Given Setup test
    When Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    FOR    ${segment_name}    IN     ${OL_R991_Segment}
        Add a Candidate Segment     name=${segment_name}    status=${status}    is_admin=True
    END
