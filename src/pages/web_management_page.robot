*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/web_management_locators.py

*** Variables ***
${Welcome_message}      Thank you for your interest. We are looking for great talent for many types of jobs.
${Interest_question}    What opportunity are you most interested in?
${Job_found_message}    recommended positions I found for you
${Job_ask_name}         To get started, can you please provide me with your first and last name?
${Job_ask_phone}        What's the best mobile phone number to contact you?
${Job_ask_email}        Can you please provide me with your email address as well?
${Contact_prefer}       How would you prefer we contact you moving forward?
${Thank_you}            We will review your information shortly and reach out to you within three business days.
${Age_question}         How old are you?

*** Keywords ***
Create landing site/widget site
    [Arguments]    ${site_type}     ${site_name}=None    ${conversation_name}=None    ${web_domain}=None    ${brand_name}=None
    Go to Web Management
    IF  '${site_name}'== 'None'
        ${site_id_random} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${site_name} =    Set variable    auto_web_${site_type}_${site_id_random}
    END
    Click at    ${ADD_NEW_WEB_BUTTON}
    Click at    ${WEB_SITE_TYPE}    ${site_type}    1s
    Click at    ${NEXT_BUTTON_SELECT_SITE}
    Check element display on screen  ${WEB_MANAGEMENT_WIDGET}
    Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
    IF  '${brand_name}' != 'None'
        Click at    ${BRANDING_DROPDOWN}
        Click at    ${BRANDING_DROPDOWN_VALUE}    ${brand_name}
        Click at    ${BRANDING_DROPDOWN}
        Check Element Display On Screen    ${BRANDING_DROPDOWN_VALUE}    ${brand_name}
    END
    IF  '${web_domain}' == 'None'
        ${web_domain} =     Evaluate    "${CONFIG.sale_demo_domain}".replace("https://", "")
    END
    IF    '${site_type}' == 'Widget Conversation'
        Input into    ${DOMAIN_SECURITY_WIDGET}    ${web_domain}
    END
    IF    '${conversation_name}' != 'None'
        Assign the conversation to the landing site/widget site     ${conversation_name}
    END
    Capture page screenshot
    Run keyword and ignore error    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Run keyword and ignore error    Check element display on screen  ${WEB_MANAGEMENT_PAGE_CENTER_MESSAGE}  wait_time=5s
    Capture page screenshot
    ${is_closed_widget} =    Run keyword and return Status    Check element not display on screen
    ...    ${WEB_MANAGEMENT_WIDGET}
    IF    '${is_closed_widget}' == 'False'
        Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
        IF    '${site_type}' == 'Widget Conversation'
            Input into    ${DOMAIN_SECURITY_WIDGET}    ${web_domain}
        END
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Capture page screenshot
    END
    [Return]    ${site_name}

Reset landing site setting
    [Arguments]    ${site_name}
    ${is_changed}=    Set Variable    False
    Click at    ${WEB_PAGE_NAME}    ${site_name}
    Scroll to element by JS    ${KNOWLEDGE_BASE_TOGGLE}
    ${is_on}=    run keyword and return status    Check toggle is On    ${KNOWLEDGE_BASE_TOGGLE}
    IF    '${is_on}'=='True'
        Click by JS    ${KNOWLEDGE_BASE_TOGGLE}
        ${is_changed}=    Set Variable    True
    END
    Scroll to element by JS    ${JOB_SEARCH_TOGGLE}
    ${is_on}=    run keyword and return status    Check toggle is On    ${JOB_SEARCH_TOGGLE}
    IF    '${is_on}'=='True'
        Click by JS    ${JOB_SEARCH_TOGGLE}
        ${is_changed}=    Set Variable    true
    END
    IF    '${is_changed}'=='True'
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    END

Check if existed reset else create new Landing site
    [Arguments]    ${site_name}
    Go to Web Management
    search site    ${site_name}
    ${is_existed_site} =    Run Keyword And Return Status    Check element display on screen    ${WEB_PAGE_NAME}    ${site_name}
    IF    '${is_existed_site}' == 'False'
        # create new
        Reload Page
        Create landing site/widget site    Landing Site    ${site_name}
    ELSE
        Reset landing site setting    ${site_name}
        Reload Page
    END

check and create landing site/widget site
    [Arguments]    ${site_type}    ${site_name}
    Go to Web Management
    search site    ${site_name}
    ${web_locator} =    Format string    ${WEB_PAGE_NAME}    ${site_name}
    ${is_existed_site} =    Run Keyword And Return Status    Check element display on screen    ${web_locator}
    IF    '${is_existed_site}' == 'False'
        Click at    ${ADD_NEW_WEB_BUTTON}
        ${new_site_type_locator} =    Format string    ${WEB_SITE_TYPE}    ${site_type}
        Click at    ${new_site_type_locator}
        Click at    ${NEXT_BUTTON_SELECT_SITE}
        IF    '${site_type}' == 'Upcoming Event Site'
            Input into    ${HEADER_TITLE_INPUT}    Auto_${site_name}
        ELSE
            Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
        END
        IF    '${site_type}' == 'Widget Conversation'
            Input into    ${DOMAIN_SECURITY_WIDGET}    ${CONFIG.sale_demo_domain}
        END
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Wait with medium time
        ${is_closed_widget} =    Run keyword and return Status    Check element not display on screen
        ...    ${WEB_MANAGEMENT_SAVE_BUTTON}
        IF    '${is_closed_widget}' == 'False'
            Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        END
        wait for page load successfully
    END

Assign the conversation to the Event Landing page site
    [Arguments]    ${conversation_name}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step with custom conversation    ${conversation_name}
    Set Tools step
    ${url} =    Go to event register page
    [Return]    ${url}

Assign the conversation to the landing site/widget site
    [Arguments]    ${conversation_name}    ${site_name}=None
    IF    '${site_name}' != 'None'
        search and click landing site    ${site_name}
        Wait with short time
    END
    Scroll to element    ${WEB_SHORT_URL}
    ${is_has_url} =     Run keyword and return status   Check element display on screen    ${WEB_SHORT_URL}
    ${url} =    Set variable    ${EMPTY}
    IF    '${is_has_url}' == 'True'
        ${url} =    Get value    ${WEB_SHORT_URL}
    END
    Click at    ${CONVERSATION_SELECTION}
    ${is_search_visible} =    Run Keyword And Return Status    Check element display on screen
    ...    ${CONVERSATION_NAME_SEARCH_BOX}
    IF    '${is_search_visible}' == 'True'
        Input into    ${CONVERSATION_NAME_SEARCH_BOX}    ${conversation_name}
    END
    Capture page screenshot
    ${conversation_name_locator} =    Format string    ${CONVERSATION_NAME_VALUE}    ${conversation_name}
    ${is_different_default_conversation} =    Run Keyword And Return Status    Check element display on screen    ${conversation_name_locator}
    IF    '${is_different_default_conversation}' == 'True'
        # Re-check for make sure Selected Conversation is correct
        Click at    ${conversation_name_locator}
        Click at    ${CONVERSATION_SELECTION}
        IF    '${is_search_visible}' == 'True'
            Input into    ${CONVERSATION_NAME_SEARCH_BOX}    ${conversation_name}
        END
        ${selected_conv_locator} =    Format string    ${CONVERSATION_SELECTED_NAME}    ${conversation_name}
        ${selected_conv_name} =    Get text and format text    ${selected_conv_locator}
        Should Be Equal As Strings    ${selected_conv_name}    ${conversation_name}
        Capture page screenshot
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        ${is_closed_widget} =   Run keyword and return status   Check element not display on screen    ${WEB_MANAGEMENT_WIDGET}
        Run keyword if  '${is_closed_widget}' == 'False'    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    END
    [Return]    ${url}

Open landing site and get url
    [Arguments]   ${site_name}    ${type_url}=Short
    search and click landing site    ${site_name}
    Scroll to element    ${WEB_SHORT_URL}
    ${is_has_url} =     Run keyword and return status   Check element display on screen    ${WEB_SHORT_URL}
    ${url} =    Set variable    ${EMPTY}
    IF    '${is_has_url}' == 'True'
        IF    '${type_url}' == 'Short'
            ${url} =    Get value    ${WEB_SHORT_URL}
        ELSE
            ${url} =    Get value    ${WEB_LONG_URL}
        END
    END
    Capture page screenshot
    [Return]    ${url}

Save site change
    Capture page screenshot
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Click at    ${CLOSE_ALERT_ICON}

Assign the Care to the site
    [Arguments]    ${care_type}   ${site_name}
    ${url} =    Open landing site and get url    ${site_name}    type_url=Long
    Turn on    ${KNOWLEDGE_BASE_TOGGLE}
    Click at    ${COMMON_LABEL_TEXT}    ${care_type} Care
    Select From List By Label    ${CAPTURE_CONVERSATION}    ${care_type} Care
    Save site change
    [Return]    ${url}

Assign the Job search to the site
    [Arguments]  ${site_name}
    ${url} =    Open landing site and get url    ${site_name}    type_url=Long
    Click by JS    ${JOB_SEARCH_TOGGLE}
    Select From List By Label    ${CAPTURE_CONVERSATION}    Job Search
    Save site change
    [Return]    ${url}

Assign the Candidate care and Job search to the site
    [Arguments]   ${site_name}
    ${url} =    Open landing site and get url    ${site_name}    type_url=Long
    Turn on    ${KNOWLEDGE_BASE_TOGGLE}
    Click at    ${COMMON_LABEL_TEXT}    Candidate Care
    Click by JS    ${JOB_SEARCH_TOGGLE}
    Select From List By Label    ${CAPTURE_CONVERSATION}    Candidate Care
    Save site change
    [Return]    ${url}

Assign the Candidate care and Conversation to the site
    [Arguments]   ${site_name}    ${conversation_name}
    ${url} =    Open landing site and get url    ${site_name}    type_url=Long
    Click at    ${CONVERSATION_SELECTION}
    ${is_search_visible} =    Run Keyword And Return Status    Check element display on screen
    ...    ${CONVERSATION_NAME_SEARCH_BOX}
    IF    '${is_search_visible}' == 'True'
        Input into    ${CONVERSATION_NAME_SEARCH_BOX}    ${conversation_name}
    END
    Capture page screenshot
    Click at    ${CONVERSATION_NAME_VALUE}    ${conversation_name}
    # select Candidate Care
    Turn on    ${KNOWLEDGE_BASE_TOGGLE}
    Click at    ${COMMON_LABEL_TEXT}    Candidate Care
    Save site change
    [Return]    ${url}

Assign the Conversation to the site
    [Arguments]   ${site_name}    ${conversation_name}
    ${url} =    Open landing site and get url    ${site_name}    type_url=Long
    Click at    ${CONVERSATION_SELECTION}
    ${is_search_visible} =    Run Keyword And Return Status    Check element display on screen
    ...    ${CONVERSATION_NAME_SEARCH_BOX}
    IF    '${is_search_visible}' == 'True'
        Input into    ${CONVERSATION_NAME_SEARCH_BOX}    ${conversation_name}
    END
    Capture page screenshot
    Click at    ${CONVERSATION_NAME_VALUE}    ${conversation_name}
    Save site change
    [Return]    ${url}

Get Landing Site shortened URL
    [Arguments]    ${site_name}
    search and click landing site    ${site_name}
    Scroll to element    ${WEB_SHORT_URL}
    ${url} =    Get value    ${WEB_SHORT_URL}
    [Return]    ${url}

Assign Conversation and Care to Widget
    [Arguments]    ${conversation_name}    ${site_name}    ${kb_type}
    ${web_locator} =    Format string    ${WEB_PAGE_NAME}    ${site_name}
    Click by JS    ${web_locator}
    Turn on    ${KNOWLEDGE_BASE_TOGGLE}
    Click at    ${KNOWLEDGE_BASE_TYPE}    ${kb_type}
    search conversation    ${conversation_name}
    ${conversation_name_locator} =    Format string    ${CONVERSATION_NAME_VALUE}    ${conversation_name}
    ${is_changed} =    Run Keyword And Return Status    wait until element is visible    ${conversation_name_locator}
    IF    '${is_changed}' == 'True'
        Click at    ${conversation_name_locator}
        search conversation    ${conversation_name}
        ${selected_conv_locator} =    Format string    ${CONVERSATION_SELECTED_NAME}    ${conversation_name}
        ${selected_conv_name} =    Get text and format text    ${selected_conv_locator}
        Should Be Equal As Strings    ${selected_conv_name}    ${conversation_name}
        ${is_save_btn_enble} =    Run Keyword And Return Status    element should be enabled
        ...    ${CONVERSATION_NAME_SEARCH_BOX}
        IF    '${is_save_btn_enble}' == 'true'
            Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
            wait until element is not visible    ${WEB_MANAGEMENT_SAVE_BUTTON}    20s
        ELSE IF    '${is_save_btn_enble}' == 'false'
            Click at    ${ICON_CLOSE_MODAL}
        END
    END

search conversation
    [Arguments]    ${conversation_name}
    Click at    ${CONVERSATION_SELECTION}
    ${is_have_search_conv} =    Run Keyword And Return Status    Check element display on screen
    ...    ${CONVERSATION_NAME_SEARCH_BOX}
    IF    '${is_have_search_conv}' == 'true'
        Input into    ${CONVERSATION_NAME_SEARCH_BOX}    ${conversation_name}
    END

search site
    [Arguments]    ${site_name}
    Wait with medium time
    ${is_search_visible} =    Run Keyword And Return Status    wait until element is visible    ${SEARCH_WEB_PAGE}
    IF    '${is_search_visible}' == 'True'
        Click by JS    ${SEARCH_WEB_PAGE}
        Simulate Input    ${SEARCH_WEB_PAGE}    ${site_name}
    END
    Wait with medium time

Search and click landing site
    [Arguments]    ${site_name}
    go to web management
    search site    ${site_name}
    ${web_locator} =    Format string    ${WEB_PAGE_NAME}    ${site_name}
    Double click at  ${WEB_PAGE_NAME}    ${site_name}
    Wait with medium time

Click on toggle Job search
    [Arguments]    ${site_type}
    IF    '${site_type}' == 'Landing Site'
        Scroll to element by JS    ${YOU_CAN_FIND_YOUR_SITE}
    ELSE IF    '${site_type}' == 'Widget Conversation'
        Scroll to element by JS    ${THE_WIDGET_ONLY_APPEAR_LABEL}
    END
    Click by JS    ${JOB_SEARCH_TOGGLE}
    wait for page load successfully v1

Turn on toggle Knowledge Base
    Scroll to element by JS    ${YOU_CAN_FIND_YOUR_SITE}
    Click by JS    ${KNOWLEDGE_BASE_TOGGLE}

Search and delete landing site
    [Arguments]    ${site_name}
    Wait with medium time
    Click by JS    ${SEARCH_WEB_PAGE}
    Input into    ${SEARCH_WEB_PAGE}    ${site_name}
    Click by JS     ${ECLIPSE_BUTTON_SITE}      slow_down=2s
    ${delete_locator} =    Format string    ${DELETE_BUTTON_BY_NAME_SITE}    ${site_name}
    Click by JS    ${delete_locator}
    Click by JS    ${ACTION_DELETE_SITE}
    ${yes_btn} =    Format string    ${COMMON_BUTTON}    Yes
    Click by JS    ${yes_btn}

Check visible of Job search parametter
    [Arguments]    ${is_display}
    ${job_search_parametter} =    Format String    ${COMMON_TEXT}    Job Search Parameters
    IF    '${is_display}' == 'True'
        Scroll to element by JS    ${YOU_CAN_FIND_YOUR_SITE}
        Check element display on screen    ${job_search_parametter}
    ELSE IF    '${is_display}' == 'False'
        Scroll to element by JS    ${YOU_CAN_FIND_YOUR_SITE}
        Check element not display on screen    ${job_search_parametter}
    END

Delete a landing site/widget site
    [Arguments]    ${site_name}
    Go to Web Management
    search and click landing site    ${site_name}
    Click at    ${WEB_MANAGEMENT_REMOVE_BUTTON}
    Click by JS    ${CONFIRM_DELETE_BUTTON_SITE}

select attribute by name
    [Arguments]    ${attribue}    ${index}
    ${locator} =    format string    ${ATTRIBUTE_DROPDOWN}    ${index}
    Click at    ${locator}
    Click at label    ${attribue}
    Click at    ${locator}

add 2 job search parameters turn on limit search
    Click at    ${ADD_ATTRIBUTE_BUTTON}
    Check element display on screen    Limit search to attribute values
    Check element display on screen    Use exact matches for the attribute values entered
    select attribute by name    Job Title    1
    ${attribute_1} =    format string    ${ATTRIBUTE_VALUE}    1
    input text    ${attribute_1}    Automation
    click on span text    Attribute
    Click at    ${ADD_ATTRIBUTE_BUTTON}
    ${attribute_2} =    Format String    ${ATTRIBUTE_VALUE}    2
    select attribute by name    Job City    2
    input text    ${attribute_2}    South Burlington
    turn on 2 toogle limit search

turn on 2 toogle limit search
    ${toggle_limit_1} =    format string    ${LIMIT_SEARCH_TOGGLE}    1
    Click at    ${toggle_limit_1}
    ${toggle_limit_2} =    format string    ${LIMIT_SEARCH_TOGGLE}    2
    Click at    ${toggle_limit_2}

add 2 job search parameters and not turn on limit search
    Click at    ${ADD_ATTRIBUTE_BUTTON}
    Check element display on screen    Limit search to attribute values
    Check element display on screen    Use exact matches for the attribute values entered
    select attribute by name    Job Title    1
    click on span text    Attribute
    ${attribute} =    format string    ${ATTRIBUTE_VALUE}    1
    input text    ${attribute}    Automation
    Click at    ${ADD_ATTRIBUTE_BUTTON}
    ${attribute} =    Format String    ${ATTRIBUTE_VALUE}    2
    select attribute by name    Job City    2
    input text    ${attribute}    South Burlington
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}

input first value attribute
    [Arguments]    ${attribute_name}
    ${attribute} =    format string    ${ATTRIBUTE_VALUE}    1
    input text    ${attribute}    ${attribute_name}

input second value attribute
    [Arguments]    ${attribute_name}
    ${attribute} =    format string    ${ATTRIBUTE_VALUE}    2
    input text    ${attribute}    ${attribute_name}

click add attribute button
    Click at    ${ADD_ATTRIBUTE_BUTTON}

Go to company site
    [Arguments]    ${company_name}
    ${url} =    Get Landing Site shortened URL    ${company_name}
    Go to    ${url}

Check and create event upcoming site
    [Arguments]    ${site_name}
    Go to Web Management
    search site    ${site_name}
    ${web_locator} =    Format string    ${WEB_PAGE_NAME}    ${site_name}
    ${is_existed_site} =    Run Keyword And Return Status    Check element display on screen    ${web_locator}
    IF    '${is_existed_site}' == 'False'
        Click at    ${ADD_NEW_WEB_BUTTON}
        Click at    ${WEB_SITE_TYPE}    Upcoming Event Site
        Click at    ${NEXT_BUTTON_SELECT_SITE}
        Input into    ${HEADER_TITLE_INPUT}    Auto_${site_name}
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Wait with medium time
        ${is_closed_widget} =    Run keyword and return Status    Check element not display on screen
        ...    ${WEB_MANAGEMENT_SAVE_BUTTON}
        IF    '${is_closed_widget}' == 'False'
            Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        END
        wait for page load successfully
    END

#   Create a landing site then turn on Job Search, change Capture Conversation to Job Search

Create job search landing site/widget
    [Arguments]    ${site_type}    ${site_name}=None    ${web_domain}=None
    Go to Web Management
    IF  '${site_name}'== 'None'
        ${site_id_random} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${site_name} =    Set variable    auto_web_${site_id_random}
    END
    Click at    ${ADD_NEW_WEB_BUTTON}
    Click at    ${WEB_SITE_TYPE}    ${site_type}    1s
    Click at    ${NEXT_BUTTON_SELECT_SITE}
    Check element display on screen  ${WEB_MANAGEMENT_WIDGET}
    Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
    Click on toggle Job search    ${site_type}
    IF    '${site_type}' == 'Widget Conversation'
        IF  '${web_domain}' == 'None'
            ${web_domain} =     Evaluate    "${CONFIG.sale_demo_domain}".replace("https://", "")
        END
        Input into    ${DOMAIN_SECURITY_WIDGET}    ${web_domain}
        Select dropdown item  ${CAPTURE_CONVERSATION}  ${WIDGET_JOB_SEARCH_ITEM}  dynamic_locator_item=Job Search
        Press keys  None  ESC
    ELSE IF  '${site_type}' == 'Landing Site'
        select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    END
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Run keyword and ignore error    Check element display on screen  ${WEB_MANAGEMENT_PAGE_CENTER_MESSAGE}  wait_time=5s
    Capture page screenshot
    ${is_closed_widget} =    Run keyword and return Status    Check element not display on screen
    ...    ${WEB_MANAGEMENT_WIDGET}
    IF    '${is_closed_widget}' == 'False'
        Input into    ${SITE_NAME_WEB_WIDGET}    ${site_name}
        IF    '${site_type}' == 'Widget Conversation'
            Input into    ${DOMAIN_SECURITY_WIDGET}    ${web_domain}
        END
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Capture page screenshot
    END
    [Return]    ${site_name}

Create job posting page
    [Arguments]    ${conversation_name}=None
    Go to Web Management
    Click at    ${ADD_NEW_WEB_BUTTON}
    ${is_display} =  Run keyword and return status   Click at    ${WEB_SITE_TYPE}    Job Posting    1s
    IF   ${is_display}
        Click at    ${NEXT_BUTTON_SELECT_SITE}
        Check element display on screen  ${WEB_MANAGEMENT_WIDGET}
        IF  '${conversation_name}' == 'None'
            Click At    ${CONVERSATION_SELECTION}
            Click At    ${CONVERSATION_TEMPLATE_NAME_SELECTION}     ${conversation_name}
        END
        Turn on   ${CANDIDATE_CARE_SEARCH}
        Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
        Capture page screenshot
    ELSE
        Click at    ${CANCEL_BUTTON_SELECT_SITE}
    END
