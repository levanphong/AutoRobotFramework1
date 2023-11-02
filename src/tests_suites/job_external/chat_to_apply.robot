*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          advantage    aramark    birddoghr    darden    dev    fedex    fedexstg    lowes    lts_stg    mchire    olivia    pepsi    regression    stg    uniliver    test    lowes_stg

Documentation       run data test: src/data_tests/job_external/chat_to_apply.robot

*** Variables ***
${job_site_name}        ChatToApplyLandingSite
${job_widget_name}      ChatToApplyWidget

*** Test Cases ***
# ==== SECTION: COMPANY_FRANCHISE_OFF_JOB_ON ====
Check Candidate apply to the Job when Chat to apply is OFF (OL-T28301)
    Given Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_FRANCHISE_OFF_JOB_ON   ${job_site_name}
    Go to  ${site_url}
    Wait for Olivia reply
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${WELCOME_CANDIDATE_MESSAGE_1}
    Candidate input to landing site  ${LOCATION_MAPPING_REQ_ID_020}
    Apply job on landing site   ${LOCATION_MAPPING_TITLE_020}
    #   Verify ATS url link
    Wait with short time
    @{recent_url} =  Get locations
    Should Be Equal As Strings  ${APPLY_URL}   ${recent_url}[1]

# ==== SECTION: COMPANY_FRANCHISE_ON ====
Check Candidate apply to the Job when Chat to apply toogle is ON, Candidate apply a job that match exactly targeting rule (OL-T28302, OL-T28305)
    Given Setup test
    Go to convo and check welcome message
    Candidate input to landing site  ${AUTOMATION_TESTER_REQ_ID_003}
    Apply job on landing site   ${AUTOMATION_TESTER_TITLE_003}
    Candidate inputs information for matching convo


Check Candidate apply to the Job when Candidate apply a job that don't match exactly targeting rule with setting Chat to apply toogle is ON and Turn on Catch-all Conversation toogle (OL-T28304)
    Given Setup test
    Go to convo and check welcome message
    Candidate input to landing site  ${AUTOMATION_TESTER_REQ_ID_004}
    Apply job on landing site   ${AUTOMATION_TESTER_TITLE_004}
    Candidate inputs information for default convo


Check Candidate apply to the Job when setting Chat to apply toogle is ON, Turn on Catch - all Conversation toogle and setting both " OR" condition in Chat-to-Apply (OL-T28306)
    Given Setup test
    Go to convo and check welcome message
    Candidate input to landing site  ${AUTOMATION_TESTER_REQ_ID_005}
    Apply job on landing site   ${AUTOMATION_TESTER_TITLE_005}
    Candidate inputs information for matching convo

# ==== SECTION: COMPANY_DATA_PACKAGE_OFF ====
Check Candidate apply to the Job when Chat to apply toogle is ON, Candidate apply a job that don't match exactly keywords, Catch all conversation OFF (OL-T28303)
    Given Setup test
    ${widget_url} =  Get widget conversation link    ${job_widget_name}
    Go to widget site  ${widget_url}
    ${first_message} =  Get text and format text  ${FIRST_MESSAGE}
    Should match regexp  ${first_message}   ${WELCOME_CANDIDATE_MESSAGE_1}
    #   Search job which dont match condition and apply
    Input text for widget site  ${LOCATION_MAPPING_REQ_ID_020}
    Click at  ${SHADOW_DOM_DETAILS_CONTENT}
    Click at  ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}
    Check element not display on screen  ${SHADOW_DOM_SELECTED_JOB_APPLY_LOADING_ICON}
    @{locations} =  Get locations
    Should Be Equal As Strings  ${APPLY_URL}   ${locations}[1]

*** Keywords ***
Go to convo and check welcome message
    ${site_url} =  Get landing site url by string concatenation  COMPANY_FRANCHISE_ON   ${job_site_name}
    Go to  ${site_url}
    Wait for Olivia reply
    ${welcome_message} =  Get latest message of Olivia in Landing site
    Should match regexp  ${welcome_message}  ${WELCOME_CANDIDATE_MESSAGE}

Candidate inputs information for matching convo
    [Arguments]  ${name}=None    ${email}=None
    Verify AI message when asking about name in   Landing Site
    IF     '${name}' == 'None'
        ${name} =    Generate candidate name
    END
    Input candidate name twice  ${name.full_name}
    IF     '${email}' == 'None'
        &{email_info} =    Get email for testing
        ${email} =  Set variable  ${email_info.email}
    END
    Verify AI message when asking about email in   Landing Site
    Candidate input to landing site  ${email}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_FRANCHISE_ON}
    [Return]  ${name}   ${email}

Candidate inputs information for default convo
    [Arguments]  ${name}=None    ${email}=None
    Verify AI message when asking about name in   Landing Site
    IF     '${name}' == 'None'
        ${name} =    Generate candidate name
    END
    Input candidate name twice  ${name.full_name}
    Candidate input to landing site  ${CONST_PHONE_NUMBER}
    IF     '${email}' == 'None'
        &{email_info} =    Get email for testing
        ${email} =  Set variable  ${email_info.email}
    END
    Verify AI message when asking about email in   Landing Site
    Candidate input to landing site  ${email}
    Verify last message content should be   ${REPROMPT_LOCATION_MESSAGE_2}
    Candidate input to landing site  1
    Verify last message content should be   ${EVENT_CONTACT_QUESTION}
    Click at   ${CONVERSATION_PREFERENCE_CHOICE_BUTTON}   Email Only
    Click at   ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Click at   ${CONVERSATION_SKIP_EEO_BUTTON}
    Verify last message content should be   ${THANKS_MESSAGE}  ${COMPANY_FRANCHISE_ON}
    [Return]  ${name}   ${email}
