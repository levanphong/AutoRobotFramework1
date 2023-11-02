*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/base_page.robot
Resource            ../../pages/talent_community_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/message_customize_page.robot
Resource            ../../pages/web_management_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
&{candidate_a}      first_name=Candidate    last_name=A For Interview
&{candidate_b}      first_name=Candidate    last_name=B For Interview

*** Test Cases ***
Add user with interview schedule
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go To Talent Community Page
    ${candidate_name_check}=    Catenate    ${candidate_b.first_name}       ${candidate_b.last_name}
    Run keyword and ignore error    Input Into      ${TALENT_CANDIDATE_PAGE_SEARCH}     ${candidate_name_check}
    ${is_existed} =     Run Keyword And Return Status       Check Element Display On Screen     ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name_check}
    IF  '${is_existed}' == 'False'
        &{candidate_name}=      Add a Candidate to Talent Community     candidate_name_random=&{candidate_b}
        ${candidate_name_b}=    Catenate    ${candidate_name.first_name}    ${candidate_name.last_name}
        Click At    ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name_b}
        Add New Media To Resume Of Candidate    Image/GIF       cat-kute
        Wait For Page Load Successfully V1
        Click At    ${TALENT_COMMUNITY_REMOVE_ADD_ICON}
    END
    Switch To User      ${EE_TEAM}
    ${candidate_name_check}=    Catenate    ${candidate_a.first_name}       ${candidate_a.last_name}
    Run keyword and ignore error    Input Into      ${TALENT_CANDIDATE_PAGE_SEARCH}     ${candidate_name_check}
    ${is_existed} =     Run Keyword And Return Status       Check Element Display On Screen     ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name_check}
    IF  '${is_existed}' == 'False'
        &{email_info} =     Get email for testing       False
        &{candidate_name} =     Add a Candidate to Talent Community     email=${email_info.email}       candidate_name_random=&{candidate_a}
        ${candidate_name_a}=    Catenate    ${candidate_name.first_name}    ${candidate_name.last_name}
        Click At    ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name_a}
        When Open schedule module
        Run Keyword And Ignore Error    Click at    ${INTERVIEW_BUTTON}
        select attendes when for sub interview      ${EE_TEAM}
        Send interview and click close button
        Input Into      ${TALENT_COMMUNITY_ADD_NOTE_INPUT}      MY NOTE TEST
        Click At    ${TALENT_COMMUNITY_ADD_NOTE_BUTTON}
        Click View more button in email     would like to schedule      ${candidate_name_a}     index_button=1
        Click by JS     ${SCHEDULE_SELECT_TIME_BUTTON}      slow_down=2s
        Wait with medium time
        Input text and send message     ${CONST_PHONE_NUMBER}
        Verify Olivia conversation message display      Thank you Candidate!
    END

Prepare Data To Filter Start Keyword
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_HIRE_ON}
    Go to Web Management
    Click at    ${ADD_NEW_WEB_BUTTON}
    Click at    ${WEB_SITE_TYPE}    Landing Site    1s
    Click at    ${NEXT_BUTTON_SELECT_SITE}
    Input into  ${SITE_NAME_WEB_WIDGET}    Site Name Test Filter For Start Keyword
    Turn on     ${CANDIDATE_CARE_SEARCH}
    Click at    ${CAPTURE_CONVERSATION}
    Click at    ${WIDGET_JOB_SEARCH_ITEM}      Candidate Care
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    ${url}=     Open landing site and get url   Site Name Test Filter For Start Keyword
    Go to    ${url}
    Input and send message for talent community     Candidateb Startkeyword
    Input and send message for talent community     Candidatea Startkeyword

*** Keywords ***
Input and send message for talent community
    [Arguments]  ${name_candidate}
    ${is_existed}=  Run Keyword And Return Status       Check Element Display On Screen    ${MESSAGE_CONVERSATION_BUTTON_POLICY}   Accept
    IF   '${is_existed}' == 'True'
         Click at    ${MESSAGE_CONVERSATION_BUTTON_POLICY}   Accept
    END
    ${is_existed}=  Run Keyword And Return Status       Check Element Display On Screen    ${MESSAGE_CONVERSATION_BUTTON_POLICY}   Accept
    IF   '${is_existed}' == 'False'
        Input text and send message    talent community
        Verify Olivia conversation message display  Are you interested in joining the ${COMPANY_HIRE_ON}
        Input text and send message   Yes
        Verify Olivia conversation message display   Thank you
        Input text and send message    ${name_candidate}
        Verify Olivia conversation message display   Thank you
        Input text and send message    new
    END

