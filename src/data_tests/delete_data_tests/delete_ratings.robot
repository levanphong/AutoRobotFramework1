*** Settings ***
Resource            ../../pages/base_page.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

*** Variable ***
${rating}           auto_rating
${loop_count}       100

*** Test Cases ***
Run delete spam candidate ratings
    Delete all spam ratings   Candidate Form


Run delete spam user ratings
    Delete all spam ratings   User Form

*** Keyword ***
Delete all spam ratings
    [Arguments]    ${rating_type}   ${company_name}=None
    Given Setup test
    IF  '${company_name}' == 'None'
        ${company_name} =   Set variable    ${COMPANY_FRANCHISE_ON}
    END
    when Login into system with company    ${PARADOX_ADMIN}     ${company_name}
    Go to Ratings Builder page
    IF      '${rating_type}' == 'User Form'
        Click at    ${RATINGS_PAGE_AUDIENCE_TAB}    User
    END
    FOR  ${index}  IN RANGE   ${loop_count}
        ${rating_locator} =    Format String    ${RATING_IN_ROW_TO_DELETE}    ${rating}
        ${is_rating_exist} =  Run Keyword And Return Status    Check element display on screen    ${rating_locator}    wait_time=1s
        IF  '${is_rating_exist}' == 'False'
            Reload page
            IF      '${rating_type}' == 'User Form'
                Click at    ${RATINGS_PAGE_AUDIENCE_TAB}    User
            END
            wait for page load successfully
            ${is_rating_exist} =  Run Keyword And Return Status    Check element display on screen    ${rating_locator}    wait_time=1s
            Exit For Loop If    '${is_rating_exist}' == 'False'
        END
        Click by JS    ${rating_locator}
        Click at    ${RATING_DELETE_ICON}
        Click at    ${RATING_DELETE_CONFIRM_BUTTON}
    END
