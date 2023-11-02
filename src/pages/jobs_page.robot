*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/my_jobs_page.robot
Variables       ../locators/jobs_locators.py
Variables       ../locators/conversation_builder_locators.py

*** Variables ***
${conversation_create_job}          conv_job_search_create_job
${landing_site_create_job}          landing_site_create_job
${job_description}                  Job Description
${basic_job_temp}                   Basic_template
${multi_job_temp}                   Multi_template
${standard_job_temp}                Standard_template
${job_type_basic_text}              Basic Multi-Location
${test_location_name}               ${LOCATION_NAME_2}
${job_family_name}                  Coffee family job
${cj_name}                          CJ Workflow
${cj_with_two_interview_stage}      Candidate_With_2nd_Interview

*** Keywords ***
get status template job exist
    [Arguments]    ${job_template_name}
    ${locator} =    format string    ${COMMON_INPUT_PLACEHOLDER}    Search Job Templates
    Input into    ${locator}    ${job_template_name}
    wait for page load successfully
    ${locator_job_tem} =    format string    ${COMMON_SPAN_TEXT}    ${job_template_name}
    ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${locator_job_tem}   wait_time=2s
    ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${locator_job_tem}   wait_time=5s
    [Return]    ${is_visible}

Create new job template
    [Arguments]    ${description_job}    ${job_template_name}    ${job_type}
    Go to Jobs page
    Click at    Job Templates
    ${locator_job_tem} =    format string    ${COMMON_SPAN_TEXT}    ${job_template_name}
    ${is_visible} =    get status template job exist    ${job_template_name}
    IF    '${is_visible}' == 'False'
        ${job_template_name} =    Create job template by name    ${description_job}    ${job_template_name}
        ...    ${job_type}
    END
    [Return]    ${job_template_name}

Create job template by name
    [Arguments]    ${description_job}    ${job_template_name}    ${job_type}
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_TEMPLATE_BUTTON}
    Click at    ${job_type}
    Click at    ${SAVE_JOB_TEMPLATE_ON_MODAL}
    Wait with medium time
    input into    ${ENTER_DESCRIPTION_QUESTION}    ${description_job}
    Click at    ${ICON_EDIT}
    input into    ${INPUT_JOB_NAME}    ${job_template_name}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${PUBLISH_JOB_BUTTON}
    Run keyword and ignore error    Click at    ${UNSAVED_CHANGES_CONFIRM_SAVE_BUTTON}      wait_time=5s
    wait until element is visible  ${STATUS_PUBLISHED}
    [Return]    ${job_template_name}

get status job exist
    [Arguments]     ${job_name}
    ${locator} =    format string    ${COMMON_INPUT_PLACEHOLDER}    Search Jobs
    Input into    ${locator}    ${job_name}
    # wait because nothing to wait when search jobs
    wait with short time
    ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${JOB_COUNT_SEARCH}
    [Return]    ${is_visible}

Create new job, publish and turn on my job
    [Arguments]    ${job_family_name}    ${job_name}    ${location_name}    ${user_name}   ${candidate_journey}=Default Candidate Journey   ${attendee}=None    ${outcome_type}=None    ${brand_name}=None
    Go to Jobs page
    ${job_existed} =    get status job exist    ${job_name}
    IF    '${job_existed}' == 'False'
        Click at    ${ICON_ARROW_DOWN}
        Click at    ${DROPDOWN_JOB_NEW}
        wait until element is visible  ${NEXT_BUTTON_ON_MODAL}
        wait with short time
        Click at    ${NEXT_BUTTON_ON_MODAL}
        Click at    ${INPUT_JOB_FAMILY}
        Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
        Click at    ${SAVE_JOB_ON_MODAL}
        input job name    ${job_name}
        Run Keyword If    '${brand_name}' != 'None'    Select brand name    ${brand_name}
        Add location for job    ${location_name}
        Add Hiring Team for job  ${user_name}
        wait for page load successfully
        Add Candidate Journey for job      ${candidate_journey}     attendee=${attendee}
        wait for page load successfully
        Add Screening Question for job
        IF  '${outcome_type}' != 'None'
            Add outcome for create job  ${outcome_type}
        END
        Publish job
    END

Create new job
    [Arguments]    ${job_name}      ${job_family_name}    ${job_template_name}=None    ${is_as_template}=True
    # Open add New Job dialog
    Click at    ${ICON_ARROW_DOWN}
    IF    '${is_as_template}' == 'True'
        Click at    ${NEW_JOB_BUTTON}
        Click at    Basic Multi-Location
        IF      '${job_template_name}' != 'None'
            Click by JS    ${JOBS_TEMPLATE_NAME_ON_MODAL}    ${job_template_name}
        ELSE
            Click at    ${NEXT_BUTTON_ON_MODAL}
        END
    ELSE
        Click at    ${DROPDOWN_JOB_NEW}
    END
    Click at    ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
    Click at    ${SAVE_JOB_ON_MODAL}
    # Enter Job name
    ${is_icon_edit_display} =   Run keyword and return status   Check element display on screen  ${ICON_EDIT}    wait_time=2s
    Run keyword if  ${is_icon_edit_display}     Click at    ${ICON_EDIT}
    IF      '${job_template_name}' != 'None'
        Press keys      None    CTRL+a+BACKSPACE
    END
    input into    ${INPUT_JOB_NAME}    ${job_name}
    [Return]    ${job_name}

Input Job name
    [Arguments]    ${job_name}
    ${is_visible} =    Run Keyword And Return Status    Check element display on screen    ${INPUT_ICON_JOB_NAME}
    IF    '${is_visible}' != 'True'
        Click at    ${EDIT_ICON_JOB_NAME}
    END
    Input into    ${INPUT_ICON_JOB_NAME}    ${job_name}
    Click at    ${SAVE_JOB_BUTTON}  slow_down=2s

Input content to publish job
    [Arguments]    ${location_name}    ${offer_name}=None    ${hiring_team_name}=None
    Add location for job    ${location_name}
    Add Hiring Team for job    ${hiring_team_name}
    Add Candidate Journey for job   Default Candidate Journey    offer_name=${offer_name}    attendee=${hiring_team_name}
    Add Screening Question for job

Publish job
    [Arguments]   ${is_job_template}=False
    wait with short time
    wait for page load successfully
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${PUBLISH_JOB_BUTTON}
    IF   ${is_job_template}
        Check element display on screen   Publishing job template...
        Check element display on screen   Job template has been published!
        Check element not display on screen   Job template has been published!
    ELSE
        Check element display on screen   Publishing job
        Check element not display on screen   Publishing job
    END
    wait element visible    ${STATUS_PUBLISHED}

Run the landing site/widget site for Job Search
    [Arguments]    ${conversation_name}    ${job_name}    ${job_template}
    ${site_name} =    Create landing site/widget site    Landing Site
    ${url} =    Assign the conversation to the landing site/widget site    ${conversation_name}    ${site_name}
    Go to    ${url}
    click accept button on gdpr dialog
    Input common on Web Management for test job    ${job_name}    ${job_template}

Input common on Web Management for test job
    [Arguments]    ${job_name}    ${job_template}
    sleep    2s
    #   TODO remove sleep, and set wait for conv msg
    Input into    ${CONVERSATION_INPUT_TEXTBOX}    ${job_template}
    Click at    ${CONVERSATION_SEND_BUTTON}
    sleep    5s
    Input into    ${CONVERSATION_INPUT_TEXTBOX}    anywhere
    Click at    ${CONVERSATION_SEND_BUTTON}
    sleep    5s
    Click at    See All
    ${job_on_model} =    Format string    ${JOB_ON_MODEL}    ${job_name}
    Click at    ${job_on_model}

Add location for job
#Add location for type job Basic Multi-Location/ Multi-Location
    [Arguments]    ${location_name}   ${remote}=False
    ${type} =   evaluate    type($location_name).__name__
    Click at    ${ADD_LOCATION_BUTTON}
    #   Turn on Remote toggle if needed
    Run keyword if   ${remote}   Click at   ${TOGGLE_REMOTE_LOCATION}
    #   Add location
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{location_name}
            Input Into  ${ADD_JOB_LOCATION_SEARCH_TEXT_BOX}     ${item}
            Click at    ${LOCATION_ON_ADD_LOCATION_POPUP}    ${item}
        END
    ELSE
        Input Into  ${ADD_JOB_LOCATION_SEARCH_TEXT_BOX}     ${location_name}
        Click at    ${LOCATION_ON_ADD_LOCATION_POPUP}    ${location_name}
    END
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully v1
    #   Check if adding location is successful
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{location_name}
            Check element display on screen    ${AVAILABLE_LOCATION_BY_NAME}   ${item}
        END
    ELSE
        Check element display on screen    ${AVAILABLE_LOCATION_BY_NAME}   ${location_name}
    END
    Run keyword if   ${remote}   Check element display on screen   ${AVAILABLE_LOCATION_BY_NAME}   Remote

Add area folder location for job
#Add area folder location for type job Basic Multi-Location/ Multi-Location
    [Arguments]    ${location_name}
    Click at    ${ADD_LOCATION_BUTTON}
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    Press Keys  ${ADD_JOB_LOCATION_SEARCH_TEXT_BOX}     ${location_name}
    Click at    ${AREA_FOLDER_ON_ADD_LOCATION_POPUP}    ${location_name}
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    wait for page load successfully
    Click at    ${SAVE_JOB_BUTTON}

Click edit and add location for job
#Edit location for type job Basic Multi-Location/ Multi-Location
    [Arguments]    ${location_name}
    Click at    ${EDIT_LOCATION_BUTTON}
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    input into      ${INPUT_SEARCH_LOCATIONS}       ${location_name}
    Click at    ${LOCATION_ON_ADD_LOCATION_POPUP}    ${location_name}
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    wait with short time
    Check element display on screen    ${location_name}

Add location for job Standard
#Add location for type job Standard
    [Arguments]    ${location_name}
    Click at    ${ADD_LOCATION_BUTTON}
    Click at    ${ADD_LOCATION_BUTTON_ON_MODAL}
    Input into      ${INPUT_SEARCH_LOCATIONS}   ${location_name}
    Click at    ${SINGLE_LOCATION_BY_NAME}   ${location_name}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    Check element display on screen    ${location_name}

Add Hiring Team for job
#Add role to hiring team type Basic Multi-Location
    [Arguments]    ${hiring_team_name}=None
    Click on span text    Hiring Team
    Click at    ${JOB_ADD_USER_BUTTON}
    IF    '${hiring_team_name}' != 'None'
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    ${hiring_team_name}
    ELSE
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    Company Admin
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    Supervisor
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    Recruiter
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    Hiring Manager
        # Add Full User - Edit Everything
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    Full User - Edit
        # Add Full User - Edit Nothing
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT_2}    Full User - Edit
        Click at    ${NEW_JOB_HIRING_TEAM_TEXT}    Reporting User
    END
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_JOB_BUTTON}
    Wait with short time

Add Hiring Team for job type Standard/Muti-Location
#    Add role to hiring team type Standard
    [Arguments]    ${user}      ${role}=None
    ${is_existed} =    Run Keyword And Return Status    check span display  Decide which users can manage
    IF    '${is_existed}' == 'False'
           Click at    Hiring Team
    END
    Click at    ${JOB_ADD_ROLE_BUTTON}
    IF  '${role}' != 'None'
        CLICK ON SPAN TEXT    ${role}
    ELSE
        CLICK ON SPAN TEXT    Hiring Manager
    END
    Click at    ${APPLY_BUTTON}
    Click at    ${JOB_ADD_USER_BUTTON}
    Click at    ${INPUT_SEARCH_USER}
    input text    ${INPUT_SEARCH_USER}    ${user}
    wait for page load successfully
#    Case role user
    IF    '${user}' == 'Hiring Manager'
        Click at    ${HIRING_TEAM_ROLE_USER}    ${user}
#    Case single user
    ELSE
        Scroll to element by JS    ${user}
        Click at    ${HIRING_TEAM_USER}    ${user}      1s
    END
    Click at    ${APPLY_BUTTON}
    wait with short time
    Click at    ${SAVE_JOB_BUTTON}
    check element display on screen  ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}

Add Hiring Team for job with user
    [Arguments]    ${user_name}
    Click at    Hiring Team
    Click at    ${JOB_ADD_USER_BUTTON}
    Click at    ${HIRING_TEAM_USER}    ${user_name}
    Click at    ${APPLY_BUTTON}
    wait with short time
    Click at    ${SAVE_JOB_BUTTON}

Add Candidate Journey for job
    [Arguments]     ${cj_name}      ${user_form}=None   ${candidate_form}=None    ${attendee}=None    ${offer_name}=None
    wait with short time
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${cj_name}
    Click on span text    ${cj_name}
    wait for page load successfully
    # SCHEDULING STEP
    ${interview_type}=  Get value and format text    ${CANDIDATE_JOURNEY_SELECT_INTERVIEW_TYPE_INPUT}
    IF  '${interview_type}' == 'Auto-Schedule'
        IF  '${attendee}' != 'None'
            Add attendee for interview    ${attendee}
        ELSE
            Add attendee for interview    ${HM}
        END
    END
    ${is_display_2nd_interview}=   Run keyword and return status   Check element display on screen  ${NEW_JOB_DROPDOWN_ATTENDEE_2ND}
    IF      '${is_display_2nd_interview}' == 'True'
        Add attendee for 2nd interview      ${HM}
    END
    # FORM SELECTION
    ${is_form_displayed}=   Run keyword and return status       Check element display on screen     ${CANDIDATE_JOURNEY_SEND_FORM_NEXT_STEPS}
    IF  '${is_form_displayed}' == 'True'
        Select user form for Candidate journey     ${user_form}
        Select candidate form for candidate journey     ${candidate_form}
    END
    # OFFER SELECTION
    ${is_offer_displayed}=   Run keyword and return status       Check element display on screen     Select Offer(s)    wait_time=2s
    IF  ${is_offer_displayed}
        Select a offer for job      ${offer_name}
    END
    # CONVERSATION SELECTION
    ${is_conversation_displayed}=   Run keyword and return status       Check element display on screen     Conversation to send    wait_time=2s
    IF  ${is_conversation_displayed}
        Click by JS    ${NEW_JOB_ADD_CONVERSATION_DROPDOWN}
        Click by JS    ${NEW_JOB_ADD_DATA_TEST_FIRST_DROPDOWN_VALUE}
    END
    # FORM SELECTION
    ${is_form_displayed}=   Run keyword and return status       Check element display on screen     ${NEW_JOB_ADD_FORM_DROPDOWN}    wait_time=2s
    IF  ${is_form_displayed}
        Click by JS    ${NEW_JOB_ADD_FORM_DROPDOWN}
        Click by JS    ${NEW_JOB_ADD_DATA_TEST_FIRST_DROPDOWN_VALUE}
    END
    # APPLICATION SELECTION
    ${is_application_displayed}=   Run keyword and return status       Check element display on screen     ${NEW_JOB_ADD_APPLICATION_DROPDOWN}    wait_time=2s
    IF  ${is_application_displayed}
        Click by JS    ${NEW_JOB_ADD_APPLICATION_DROPDOWN}
        Click by JS    ${NEW_JOB_ADD_DATA_TEST_FIRST_DROPDOWN_VALUE}
    END
    # ONBOARDING SELECTION
    ${is_onboarding_displayed}=   Run keyword and return status       Check element display on screen     ${NEW_JOB_ADD_ONBOARDING_DROPDOWN}    wait_time=2s
    IF  ${is_onboarding_displayed}
        Click by JS    ${NEW_JOB_ADD_ONBOARDING_DROPDOWN}
        Click by JS    ${NEW_JOB_ADD_DATA_TEST_FIRST_DROPDOWN_VALUE}
    END
    # ASSESSMENT SELECTION
    ${is_assessment_displayed}=   Run keyword and return status       Check element display on screen     ${NEW_JOB_ADD_ASSESSMENT_DROPDOWN}    wait_time=2s
    IF  ${is_assessment_displayed}
        Click by JS    ${NEW_JOB_ADD_ASSESSMENT_DROPDOWN}
        Click by JS    ${NEW_JOB_ADD_DATA_TEST_FIRST_DROPDOWN_VALUE}
    END
    # FINISH STEP
    Click at    ${SAVE_JOB_BUTTON}

Add Screening Question for job
    ${is_existed} =    Run Keyword And Return Status    check span display  Create the questions Olivia should ask this candidate   wait_time=5s
    IF    '${is_existed}' == 'False'
            Click at    Screening
    END
    Click at    Add Question
    add question free text
    Click at    ${SAVE_JOB_BUTTON}

add question free text
#add question type free text
    [Arguments]   ${question_name}=Age  ${question_content}=How old are you?
    input into    ${INPUT_QUESTION_NAME}    ${question_name}
    input into    ${INPUT_QUESTION_CONTENT}    ${question_content}
    Click at    ${JOB_SAVE_BUTTON_ON_MODAL}
    wait for page load successfully
    [Return]  ${question_name}

add question document upload
#add question type document upload
    Click at    Add Question
    input into    ${INPUT_QUESTION_NAME}    Resume
    input into    ${INPUT_QUESTION_CONTENT}    Could you upload your CV?
    Click at    ${REPLY_TYPE_QUESTION}
    Click at    Document Upload
    Click at    ${JOB_SAVE_BUTTON_ON_MODAL}

add question List select
#add question type List select
    [Arguments]   ${question_name}=Experience  ${question_content}=How many years of experience do you have?    ${list_select_item}=More than 3
    Click at    Add Question
    input into    ${INPUT_QUESTION_NAME}   ${question_name}
    input into    ${INPUT_QUESTION_CONTENT}    ${question_content}
    Click at    ${REPLY_TYPE_QUESTION}
    Click at    List select
    Click at    ${ADD_QUESTION_ADD_LIST_ITEM_BUTTON}
    input into    ${INPUT_LIST_SELECT_ITEM_1}    ${list_select_item}
    Click at    ${JOB_SAVE_BUTTON_ON_MODAL}
    [Return]  ${question_name}   ${list_select_item}

setup candidate journey and add screen question
#setup candidate journey and add screen question
    ${is_existed} =    Run Keyword And Return Status    check span display  Select a journey
    IF    '${is_existed}' == 'False'
           Click at    ${CANDIDATE_JOURNEY_TAB}
    END
    select candidate journey job    Default Candidate Journey
    wait element visible    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    wait with short time
    Add attendee for interview    ${HM}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully
    add screening question for job

Then suggest Location Attributes list match the key keyword is displayed
    Hover check location attributes list be visible    la-address
    Hover check location attributes list be visible    la-address_2

Then suggest Location Attributes list match the key keyword is displayed on Decscription Job
    Check location attributes list be visible    la-address
    Check location attributes list be visible    la-address_2

Then All suggest Location Attributes list is displayed
    Hover check location attributes list be visible    la-address
    Hover check location attributes list be visible    la-address_2
    Hover check location attributes list be visible    la-city
    Hover check location attributes list be visible    la-state
    Hover check location attributes list be visible    la-zipcode
    Hover check location attributes list be visible    la-country
    Hover check location attributes list be visible    la-province
    Hover check location attributes list be visible    la-location_id
    Hover check location attributes list be visible    la-location_name
    Hover check location attributes list be visible    la-location_email
    Hover check location attributes list be visible    la-location_phone

Then All suggest Location Attributes list is displayed on Decscription Job
    Check location attributes list be visible    la-address
    Check location attributes list be visible    la-address_2
    Check location attributes list be visible    la-city
    Check location attributes list be visible    la-state
    Check location attributes list be visible    la-zipcode
    Check location attributes list be visible    la-country
    Check location attributes list be visible    la-province
    Check location attributes list be visible    la-location_id
    Check location attributes list be visible    la-location_name
    Check location attributes list be visible    la-location_email
    Check location attributes list be visible    la-location_phone

Check location attributes list be visible
    [Arguments]    ${location_attribute_name}
    ${location_attribute_locator} =    Format string    ${SUGGEST_LOCATION_ATTRIBUTE_ON_DESCRIPTION}
    ...    ${location_attribute_name}
    Check element display on screen    ${location_attribute_locator}

Hover check location attributes list be visible
    [Arguments]    ${location_attribute_name}
    ${location_attribute_locator} =    Format string    ${SUGGEST_LOCATION_ATTRIBUTE}    ${location_attribute_name}
    Scroll to element       ${location_attribute_locator}
    Check element display on screen    ${location_attribute_locator}

Add Job Search Conversation
    [Arguments]    ${type}    ${conversation_name}=None
    Go to conversation builder
    Click at    Add Conversation
    Click at    Add New Conversation
    IF  '${conversation_name}' == 'None'
        ${conversation_id} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${conversation_name} =    Set variable    auto_${type}_${conversation_id}
    END
    Input into    ${CONVERSATION_NAME_TEXTBOX}    ${conversation_name}
    Click at    ${CONVERSATION_TEMPLATE}
    ${conversation_template} =    Format String    ${CONVERSATION_TEMPLATE_DROPDOWN}    ${type}
    Click by JS    ${conversation_template}
    Check element display on screen    ${QUESTION_BOX}
    Public the conversation
    [Return]    ${conversation_name}

Create new job with Offer
    [Arguments]     ${job_family_name}    ${cj_name}    ${offer_name}    ${job_type}=None   ${job_name}=None
    IF  '${job_name}' == 'None'
        ${job_name} =    Generate random name    auto_job
    END
    # Input/Choose common info for job
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_BUTTON}
    IF  '${job_type}' == 'None'
        Click at    Basic Multi-Location
    ELSE
        Click at   ${job_type}
    END
    Click at    ${NEXT_BUTTON_ON_MODAL}     slow_down=2s
    Click at    ${INPUT_JOB_FAMILY}     slow_down=2s
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}     5s
    Click at    ${SAVE_JOB_ON_MODAL}
    # Redirect to Create Job page
    # Overview step
    ${job_title_edit_icon} =    Run Keyword And Return Status    Check element display on screen    ${ICON_EDIT}
    IF    '${job_title_edit_icon}' == 'True'
        Click at    ${ICON_EDIT}
        input into    ${INPUT_JOB_NAME}    ${job_name}
    ELSE
        Press Keys    None    ${job_name}
    END
    Click at    Save
    wait for page load successfully v1
    Add location for job    ${test_location_name}
    # Hiring Team step
    Add Hiring Team for job
    # Candidate Journey step
    Click at    Candidate Journey   slow_down=2s
    Run keyword and ignore error    Click at    ${UNSAVED_CHANGES_CONFIRM_SAVE_BUTTON}  slow_down=2s
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${cj_name}
    Click on span text    ${cj_name}
    Add an attendee to job      Admin
    Select a offer for job        ${offer_name}
    Click on span text    Save
    Wait with medium time
    # Screening step
    Add Screening Question for job
    Click at    ${SAVE_JOB_BUTTON}
    # Publish Job
    Publish job
    [Return]    ${job_name}

Add an attendee to job
    [Arguments]     ${role}
    Click at    ${CANDIDATE_JOURNEY_SELECT_ATTENDEE}
    Input into    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_SEARCH_TEXT_BOX}     ${role}
    wait with short time
    Click by JS    ${SCHEDULE_AN_INTERVIEW_ATTENDEES_NAME}   ${role}

Select shift for job
    [Arguments]    ${shift}
    Click at    ${ADD_SHIFT_BUTTON}
    Click at    ${SHIFT_CHECKBOX_BY_NAME}    ${shift}
    Click at    ${SAVE_SHIFT_BUTTON}

select candidate journey job
    [Arguments]    ${cj_name}
    wait for page load successfully
    Click by JS    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${cj_name}
    Click on span text    ${cj_name}

Select a offer for job
    [Arguments]    ${offer_name}
    Click at    ${NEW_JOB_SELECT_OFFER_DROPDOWN}
    ${search_offer_text_box} =    Run Keyword And Return Status    Check element display on screen
    ...    ${NEW_JOB_SELECT_OFFER_SEARCH_TEXT_BOX}  wait_time=2s
    IF    '${search_offer_text_box}' == 'True'
        Input into    ${NEW_JOB_SELECT_OFFER_SEARCH_TEXT_BOX}    ${offer_name}
    END
    Click by JS    ${offer_name}
    Click by JS    ${NEW_JOB_OFFER_APPLY_BUTTON}    slow_down=2s

Add more offer for job
    [Arguments]    ${offer_name}
    Click at    Candidate Journey   slow_down=2s
    Click at    ${NEW_JOB_SELECT_OFFER_DROPDOWN}
    ${search_offer_text_box} =    Run Keyword And Return Status    Check element display on screen
    ...    ${NEW_JOB_SELECT_OFFER_SEARCH_TEXT_BOX}  wait_time=2s
    IF    '${search_offer_text_box}' == 'True'
        Input into    ${NEW_JOB_SELECT_OFFER_SEARCH_TEXT_BOX}    ${offer_name}
    END
    Click by JS    ${offer_name}
    Click by JS    ${NEW_JOB_OFFER_APPLY_BUTTON}    slow_down=2s
    Click on span text    Save
    Publish job

check and create job Basic Multi-Location
    [Arguments]    ${job_name}    ${job_family_name}    ${location_name}    ${brand}=None    ${shift}=Morning    ${description}=None
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    wait with short time
    ${job_locator} =    Format String    ${FAMILY_NAME}    ${job_family_name}
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${job_locator}
    IF    '${is_existed}' == 'False'
        create a job type Basic Multi-Location with default candidate journey    ${job_name}    ${job_family_name}
        ...    ${location_name}    ${brand}    ${shift}    ${description}
    END

create a job type Basic Multi-Location with default candidate journey
    [Arguments]    ${job_name}    ${job_family_name}    ${location_name}    ${brand}=None    ${shift}=Morning    ${description}=None
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    IF    '${description}' != 'None'
        Input into    ${INPUT_JOB_DESCRIPTION}    ${description}
    END
    IF    '${brand}' != 'None'
        Click at    ${JOB_BRAND_NAME_SELECT}
        Click at    ${JOB_BRAND_NAME_OPTION}    ${brand}
    END
    ${type} =   Evaluate    type($shift).__name__
    IF  '${type}' == 'list'
        FOR    ${s}    IN    @{shift}
            Select shift for job    ${s}
        END
    ELSE
        IF    '${shift}' != 'None'
            Select shift for job    ${shift}
        END
    END
    Add location for job    ${location_name}
    Add Hiring Team for job
    setup candidate journey and outcome send interview
    Publish job

create a job type Multi-Location with default candidate journey
    [Arguments]    ${job_name}    ${job_family_name}    ${location_name}
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${location_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    setup candidate journey and outcome send interview
    Publish job

create a job type Standard with default candidate journey
    [Arguments]    ${job_name}    ${job_family_name}    ${location_name}    ${hiring_user}=Hiring Manager
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    Add location for job Standard    ${location_name}
    Add Hiring Team for job type Standard/Muti-Location    ${hiring_user}
    setup candidate journey and outcome send interview
    Publish job

create a job template multi-location
    [Arguments]    ${job_template}
    go to jobs page
    Click at    Job Template
    #    check if job template already exist
    Input into    ${INPUT_SEARCH_JOB_TEMPLATE}    ${job_template}
    ${is_existed} =    Run Keyword And Return Status    Check element display on screen    ${job_template}   wait_time=5s
    IF    '${is_existed}' == 'False'
        Click at    ${ICON_ARROW_DOWN}
        Click at    ${NEW_JOB_TEMPLATE_BUTTON}
        Click at    ${TYPE_MULTI_LOCATION}
        wait for page load successfully
        Click at    ${BUTTON_SATE_SELECT_TEMPLATE}
        input job name    ${job_template}
        Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
        select candidate journey job    Default Candidate Journey
        Click at    ${SAVE_JOB_BUTTON}
        add screening question for job
        Publish job   is_job_template=True
    END

create a job using job data package
#CREATE A JOB USING DATA PACKAGE AND PUBLISH JOB
    [Arguments]    ${job_name}    ${job_package_name}
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_STANDARD_LOCATION}
    input job name    ${job_name}
    Add location for job Standard    ${test_location_name}
    Add detail job data package    ${job_package_name}
    Add Hiring Team for job type Standard/Muti-Location    Hiring Manager
    setup candidate journey and add screen question
    Publish job

Add detail job data package
#Click add details and select job data package
    [Arguments]    ${job_package_name}
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    select job data package on the modal add details    ${job_package_name}

select job data package on the modal add details
#search and select job data package on add details
    [Arguments]    ${job_package_name}
    click at    ${DROPDOWN_SELECT_JOB_DATA_PACKAGE_DETAILS}
    input text    ${SEARCH_DATA_PACKAGE_DETAILS}    ${job_package_name}
    click at    ${SELECT_JOB_DATA_NAME_DETAILS}  ${job_package_name}  slow_down=2s
    click at    ${BUTTON_SAVE_SELECT_DATA_PACKAGE}  slow_down=1s

setup candidate journey and outcome send interview
    select candidate journey job    Default Candidate Journey
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    Hiring Manager
    add screening question for job
    add outcome send interview

add attendee for interview
    [Arguments]    ${attendee}=None
    Scroll to element by JS    Add Instructions
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE}
    wait with medium time
    IF    '${attendee}' != 'None'
        search and select attendee    ${attendee}
    ELSE
        search and select attendee    Company Admin
    END
    Click at    ${SAVE_JOB_BUTTON}

add attendee for 2nd interview
    [Arguments]    ${attendee}=None
    Press Keys   None  	PAGE_DOWN
    Scroll to element   ${NEW_JOB_DROPDOWN_ATTENDEE_2ND}
    Click at    ${NEW_JOB_DROPDOWN_ATTENDEE_2ND}
    wait with medium time
    IF    '${attendee}' != 'None'
        search and select attendee    ${attendee}
    ELSE
        search and select attendee    Company Admin
    END
    Click at    ${SAVE_JOB_BUTTON}

search and select attendee
#Select attendee interview candidate journey
    [Arguments]    ${attendee}
    click by js    ${NEW_JOB_INPUT_SEARCH_ATTENDEE}
    input text    ${NEW_JOB_INPUT_SEARCH_ATTENDEE}    ${attendee}
    wait with large time
    ${locator} =    Format String    ${ATTENDEE_INTERVIEW}    ${attendee}
    click by js    ${locator}

add outcome send interview
    Click at    ${JOB_ADD_OUTCOME_BUTTON}
    Click at    ${JOB_ADD_OUTCOME_BUTTON_ON_MODAL}
    Click at    ${JOB_ADD_OUTCOME_NAME_INPUT_LABEL}
    input text    ${JOB_ADD_OUTCOME_NAME_INPUT}    send_interview
    Click at    ${SELECT_QUESTION}
    click on span text    Age
    Click at    ${SELECT_MATCH}
    click on span text    At least
    input text    ${INPUT_VALUE}    25
    input text    ${TEXT_AREA_MSG}    send interview
    Click at    ${MOVE_TO_STATUS}
    Click at    ${STATUS_INVITE_TO_INTERVIEW}
    Click at    ${SAVE_OUTCOME_BUTTON}
    Click at    ${SAVE_ALL_OUTCOME_BUTTON}
    Click at    ${SAVE_JOB_BUTTON}

Add outcome move to status
    [Arguments]    ${status}
    Click at    ${JOB_ADD_OUTCOME_BUTTON}
    Click at    ${JOB_ADD_OUTCOME_BUTTON_ON_MODAL}
    Click at    ${JOB_ADD_OUTCOME_NAME_INPUT_LABEL}
    input into    ${JOB_ADD_OUTCOME_NAME_INPUT}    send_form
    Click at    ${SELECT_QUESTION}
    click on span text    Age
    Click at    ${SELECT_MATCH}
    click on span text    At least
    input text    ${INPUT_VALUE}    22
    input text    ${TEXT_AREA_MSG}    ${status}
    Click at    ${MOVE_TO_STATUS}
    Click at    ${SELECT_STATUS_VALUE}    ${status}
    Click at    ${SAVE_OUTCOME_BUTTON}
    Click at    ${SAVE_ALL_OUTCOME_BUTTON}
    Click at    ${SAVE_JOB_BUTTON}

Add outcome for create job
    [Arguments]     ${outcome_type}
    Click at    ${JOB_ADD_OUTCOME_BUTTON}
    Click at    ${JOB_ADD_OUTCOME_BUTTON_ON_MODAL}
    Click at    ${JOB_ADD_OUTCOME_NAME_INPUT_LABEL}
    input into    ${JOB_ADD_OUTCOME_NAME_INPUT}    ${outcome_type}
    Click at    ${SELECT_QUESTION}
    click on span text    Age
    Click at    ${SELECT_MATCH}
    click on span text    At least
    input text    ${INPUT_VALUE}    22
    input text    ${TEXT_AREA_MSG}    send form
    Click at    ${MOVE_TO_STATUS}
    Click at    ${SELECT_STATUS_VALUE}    ${outcome_type}
    Click at    ${SAVE_OUTCOME_BUTTON}
    Click at    ${SAVE_ALL_OUTCOME_BUTTON}
    Click at    ${SAVE_JOB_BUTTON}

Delete a Job
    [Arguments]    ${job_name}    ${job_family_name}
    Go to Jobs page
    search job name  ${job_name}    ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}    ${job_name}
    click by js    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    Click at    ${COMMON_TEXT_LAST}     Delete
    check element display on screen  ${TOASTED_MESSAGE_SUCCESS}

check status job
    [Arguments]    ${job_name}    ${job_family_name}
    Wait with short time
    Go to Jobs page
    search job name   ${job_name}    ${job_family_name}
    check element display on screen    ${PUBLISHED_STATUS_ON_LIST_JOB_PAGE}    ${job_name}

Delete a Job template
    [Arguments]    ${job_template_name}
    Wait with short time
    Go to Jobs page
    Click at    ${JOB_TEMPLATES_TAB}
    Input into    ${SEARCH_JOB_TEMPLATE_TEXT_BOX}    ${job_template_name}
    Click at    ${JOB_TEMPLATE_ECLIPSE_ICON}    ${job_template_name}    2s
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    Click at    ${JOB_ECLIPSE_CONFIRM_POPUP_DELETE_BUTTON}

Delete job data after run test case
    [Arguments]    ${job_name}    ${job_template_name}    ${job_family_name}
    Delete a Job    ${job_name}    ${job_family_name}
    Delete a Job template    ${job_template_name}

Create new job without Job template
    [Arguments]    ${job_type}    ${cj_name}    ${hiring_team_name}=None   ${offer_name}=None   ${role}=None    ${job_random_name}=None  ${is_publish}=True     ${location}=None
    IF  '${job_random_name}' == 'None'
        ${job_random_name} =    Generate random name    auto_job
    END
    IF  '${location}' != 'None'
        ${test_location_name} =    Set Variable     ${location}
    END
    # Input/Choose common info for job
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_BUTTON}
    IF  '${job_type}' == 'Multi-Location'
        Click at    ${TYPE_MULTI_LOCATION}
    ELSE
        Click at    ${CREATE_NEW_JOB_TYPE_TEXT}    ${job_type}
    END
    Click at    ${NEXT_BUTTON_ON_MODAL}  slow_down=2s
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
    Click at    ${SAVE_JOB_ON_MODAL}
    # Redirect to Create Job page
    # Overview step
    ${job_title_edit_icon} =    Run Keyword And Return Status    Check element display on screen    ${ICON_EDIT}    wait_time=2s
    IF    '${job_title_edit_icon}' == 'True'
        Click at    ${ICON_EDIT}
        input into    ${INPUT_JOB_NAME}    ${job_random_name}
    ELSE
        Press Keys    None    ${job_random_name}
    END
    Click at    Save
    wait for page load successfully v1
    IF  '${job_type}' == 'Standard'
        Add location for job Standard       ${test_location_name}
    ELSE
        Add location for job    ${test_location_name}
    END
    # Hiring Team step
    IF  '${job_type}' == 'Basic Multi-Location'
        Add Hiring Team for job    ${hiring_team_name}
    ELSE
        Add Hiring Team for job type Standard/Muti-Location     ${hiring_team_name}     ${role}
    END
    # Candidate Journey step
    Click at    Candidate Journey
    Wait with short time
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${cj_name}
    Click on span text    ${cj_name}
    IF  '${offer_name}' != 'None'
            Select a offer for job      ${offer_name}
    END
    add attendee for interview    ${hiring_team_name}
    Wait with medium time
    Click on span text    Save
    # Screening step
    Add Screening Question for job
    # Publish Job
    IF  '${is_publish}' == 'True'
        Click at    ${ICON_CHEVRON_DOWN}
        Click at    ${NEW_JOB_PUBLISH_BUTTON}
    END
    [Return]    ${job_random_name}

Candidate finish Job Internal / Workday conversation
    [Arguments]    ${job_name}
    ${candidate_name} =    Generate candidate name
    &{email_info} =    Get email for testing
    Wait with medium time
    Verify Olivia conversation message display      ${WHAT_OPPORTUNITY}
    Candidate input to landing site     ${ANY_JOB_IN_US}
    Verify Olivia conversation message display     ${GREAT_TAKE_A_LOOK_AT_THE}
    Click at    See All
    Click by JS    ${job_name}
    Click at    ${CONVERSATION_APPLY_NOW_BUTTON}
    Verify Olivia conversation message display      ${ASK_FIRST_AND_LAST_NAME}
    Candidate input to landing site     ${candidate_name.full_name}
    Verify Olivia conversation message display      ${ASK_PHONE}
    Candidate input to landing site     ${CONST_PHONE_NUMBER}
    Verify Olivia conversation message display      ${ASK_EMAIL}
    &{email_info} =    Get email for testing
    Candidate input to landing site    ${email_info.email}
    Verify Olivia conversation message display     ${ASK_AGE}
    Candidate input to landing site    26
    Verify Olivia conversation message display     Please select one
    Click at    ${CONVERSATION_CHOICE_BUTTON}    Email Only
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    Verify Olivia conversation message display      ${DO_ANY_OF_THESE_TIMES_WORK}
    Candidate input to landing site    1
    Verify Olivia conversation message display      Thank you
    [Return]    ${candidate_name.full_name}

Candidate finish Job posting
    ${candidate_name} =    Generate candidate name
    wait with short time
    check message widget site response correct   ${I_CAN_HELP_YOU_TO_THE}
    Input text for widget site      ${candidate_name.full_name}
    check message widget site response correct       ${ASK_EMAIL}
    &{email_info} =    Get email for testing
    Input text for widget site    ${email_info.email}
    check message widget site response correct   ${ASK_AGE}
    Input text for widget site    26
    check message widget site response correct   ${DO_ANY_OF_THESE_TIMES_WORK}
    Input text for widget site    1
    [Return]    ${candidate_name}

Check olivia asked phone and candidate input phone
   check message widget site response correct   ${WHAT_BEST_NUMBER}
   Input text for widget site      ${CONST_PHONE_NUMBER}

Click on job name
    [Arguments]    ${job_name}
    ${job_name_locator} =    Format String    ${JOBS_NAME}    ${job_name}
    Simulate Input   ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   2s
    wait for page load successfully v1
    Click at    ${job_name_locator}

Click on job template name
    [Arguments]    ${job_template_name}
    ${job_template_name_locator} =    Format String    ${JOB_TEMPLATES_NAME}    ${job_template_name}
    Input into    ${SEARCH_JOB_TEMPLATE_TEXT_BOX}    ${job_template_name}
    Click at    ${JOB_TEMPLATE_ECLIPSE_ICON}    ${job_template_name}    2s
    Click at    ${job_template_name_locator}    slow_down=2s

Make a job has config location
    [Arguments]    ${job_family_name_var}    ${location_name}=${None}
    ${job_random} =    Generate Random String    4
    ${job_name_random} =    format string    ${job_name}{}    ${job_random}
    Create new job    ${job_family_name_var}    ${job_name_random}    False
    Input Job name    ${job_name_random}
    IF    '${location_name}' != '${None}'
        Add location for job    ${location_name}
    END
    [Return]    ${job_name_random}

navigate to data job package section
    Click add job data package and click select package type
    Click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_ITEM}

Get number location remain on job package data
    ${count} =    Get Element Count    ${NEW_JOB_LOCATION_ADDED}
    [Return]    ${count}

Job Data section is Showed
    ${attribute_age} =    format string    ${COMMON_DIV_TEXT}    Minimum Age
    check element display on screen    ${attribute_age}
    check element display on screen    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_CLOSE_ICON}
    check element display on screen    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_HEADER_LOCATION}
    Check element display on screen    Select job data package

click close job package and back to job page
    Click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_CLOSE_ICON}
    click back job

click back job
    click on span text    Back to Jobs

Job Data section is Hided
    ${add_detail_job_package} =    format string    ${COMMON_SPAN_TEXT}    Add Details
    check element not display on screen    ${add_detail_job_package}

Job Data show empty state
    Click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE}
    check element not display on screen    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_ITEM}

Add 1 Job Data Package
    ${data_random} =    Generate Random String    4
    ${job_datan_pk_random} =    format string    Test_job_data_package_unit_{}    ${data_random}
    click on span text    Create Package
    input into    ${NEW_JOB_DATA_PACKAGE_INPUT_SEARCH}    ${job_datan_pk_random}
    click on span text    Add Job Data
    Click at    ${NEW_JOB_DATA_PACKAGE_ATTRIBUTE_AGE}
    Click at    ${NEW_JOB_DATA_PACKAGE_BTN_APPLY}
    input into    ${NEW_JOB_DATA_PACKAGE_INPUT_ATTRIBUTE_DEAFUT_VALUE}    10
    Click at    ${NEW_JOB_DATA_PACKAGE_BTN_CREATE}
    [Return]    ${job_datan_pk_random}

The list will show that Job Data Package has just been added
    [Arguments]    ${job_data_name}
    ${item_job_data} =    format string    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_LIST_HAS_NAME}    ${job_data_name}
    check element display on screen    ${item_job_data}

select job data package and verify attribute
    [Arguments]    ${job_data_name}    ${attribute_name}
    ${item_job_data} =    format string    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE_LIST_HAS_NAME}    ${job_data_name}
    Click at    ${item_job_data}
    Verify display common text    ${attribute_name}

check attribute is displayed
    [Arguments]    ${attribute_name}
    Verify display common text    ${attribute_name}

Click add job data package and click select package type
    click on span text    Add Details
    Click at    ${NEW_JOB_SELECT_DATA_JOB_PACKAGE}

add job package and config location
    [Arguments]    ${location}
    Click at    ${NEW_JOB_DATA_PACKAGE_ADD_LOCATION}
    ${location_checkbo} =    format string    ${NEW_JOB_DATA_PACKAGE_LOCATION_CHECKBOX}    ${location}
    Click at    ${location_checkbo}
    Click at    ${NEW_JOB_DATA_PACKAGE_LOCATION_APPLY}
    Click at    ${NEW_JOB_DATA_PACKAGE_SAVE}

Create new job with type
    [Arguments]    ${job_family_name}    ${job_type}    ${job_template}=None
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${DROPDOWN_JOB_NEW}
    IF    "${job_type}" != "${TYPE_BASIC_MULTI_LOCATION}"
        Click at    ${job_type}
    END
    IF   '${job_template}' != 'None'
        Click at    ${CREATE_NEW_JOB_TYPE_TEXT}   ${job_template}
    END
    click by js   ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
    Click at    ${SAVE_JOB_ON_MODAL}  2
    wait with short time

Create new job with type and template
    [Arguments]    ${job_family_name}    ${job_type}    ${job_template}
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${DROPDOWN_JOB_NEW}
    Click at    ${job_type}
    Click at    ${JOB_TEMPLATES_NAME_IN_JOB}    ${job_template}
    Click at    ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
    Click at    ${SAVE_JOB_ON_MODAL}

Job builder page is organized with correctly tabs
    Check span display    Overview
    Check span display    Hiring Team
    Check span display    Candidate Journey
    Check span display    Screening
    Capture page screenshot

Overview tab is displayed with full components
    [Arguments]    ${is_not_job_template}=True    ${job_name}=None     ${edit_location_button}=None
    IF    '${job_name}' != 'None'
        check element display on screen    ${JOB_NAME_EDIT_ABLE_LABEL}    ${job_name}
    ELSE
        Check element display on screen    ${INPUT_JOB_NAME}
    END
    Check element display on screen    ${INPUT_JOB_DESCRIPTION}
    Check element display on screen    ${INPUT_JOB_CODE}
    IF  '${is_not_job_template}' == 'True'
        Check element display on screen    ${JOB_POSTING_DROPDOWN}
        Check span display    Locations
        IF  '${edit_location_button}' != 'None'
            Check element display on screen   Edit Locations
        ELSE
            Check element display on screen    ${ADD_LOCATION_BUTTON}
        END
    END
    Check span display    Shifts
    Check element display on screen    ${ADD_SHIFT_BUTTON}
    IF  '${is_not_job_template}' == 'True'
        Check span display    Additional Details
        Check element display on screen    ${ADD_DETAIL_BUTTON}
    END
    Capture page screenshot

Select Job Posting Type
    [Arguments]    ${job_posting_type}
    Click at    ${JOB_POSTING_DROPDOWN}
    Click on span text    ${job_posting_type}

Delete shift
    [Arguments]    ${shift}
    ${shift_ellipse} =    format string    ${SHIFT_ECLIPSE_BUTTON}    ${shift}
    Click at    ${shift_ellipse}
    Click at    ${DELETE_SHIFT_BUTTON}
    Click at    ${SAVE_SHIFT_BUTTON}

Add more shifts for job
    [Arguments]    ${shift}
    Click at    ${ADD_SHIFT_BUTTON}
    Click on span text      Add More Shifts
    Input into    ${SHIFT_NAME_TEXTBOX}    ${shift}
    Click at    ${SAVE_SHIFT_BUTTON}

select more shift for job
    [Arguments]    ${shift}
    Click at    ${EDIT_SHIFT_BUTTON}
    Click at    ${SHIFT_CHECKBOX_BY_NAME}    ${shift}
    Click at    ${SAVE_SHIFT_BUTTON}

Go to Job detail
    [Arguments]    ${job_name}    ${job_family_name}
    Go to Jobs page
    search job name    ${job_name}    ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}    ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    wait for page load successfully v1

search job name
    [Arguments]    ${job_name}    ${job_family_name}
    simulate input    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    wait with short time
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=3s
    wait for page load successfully

search and click job name
    [Arguments]    ${job_name}    ${job_family_name}
    search job name    ${job_name}    ${job_family_name}
    click on span text    ${job_name}

#OVERVIEW - ADD DETAILS (JOB DATA PACKAGE)

select location for job data package
    [Arguments]    ${location}
    Click at    ${NEW_JOB_DATA_PACKAGE_ADD_LOCATION}
    ${location_checkbox} =    format string    ${NEW_JOB_DATA_PACKAGE_LOCATION_CHECKBOX}    ${location}
    Click by js    ${location_checkbox}
    Click at    ${NEW_JOB_DATA_PACKAGE_LOCATION_APPLY}

Delete location on overview job tab
    click at    ${LOCATION_DELETE_ICON}
    click at    ${LOCATION_DELETE_BUTTON_ON_ALERT}
    Click at    ${SAVE_BUTTON_LOCATION}

Delete a job family
    [Arguments]    ${name}
    Go to Jobs page
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${name}
    Wait with short time
    Click at    ${JOB_FAMILY_ECLIPSE_ICON}    ${name}   slow_down=2s
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_FAMILY_TEXT}

Create new job family
    [Arguments]    ${name}
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    New Job Family
    input into    ${INPUT_JOB_FAMILY_ON_POPUP}    ${name}
    Click at    ${JOB_FAMILY_CREATE_BUTTON_POPUP}

Edit name job family
    [Arguments]    ${name}    ${edit_name}
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${name}
    wait with short time
    Click at    ${JOB_FAMILY_ECLIPSE_ICON}    ${name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_FAMILY_TEXT}
    Check element display on screen    ${CANCEL_EDIT_FAMILY_BUTTON_POPUP}
    Check element display on screen    ${TITLE_EDIT_FAMILY_TEXT_POPUP}
    Check element display on screen    ${LABEL_EDIT_FAMILY_POPUP}
    Clear element text with keys    ${INPUT_EDIT_FAMILY_POPUP}
    Input into    ${INPUT_EDIT_FAMILY_POPUP}    ${edit_name}
    Click at    ${CONFIRM_EDIT_FAMILY_BUTTON_POPUP}

Move job to another job family
    [Arguments]    ${new_job_family_name}    ${job_name}
    Click at    ${JOB_FAMILY_NAME_AT_MAIN}    ${job_family_name}
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=2s
    Click at    ${JOB_ECLIPSE_ICON}    ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_MOVE_JOB_BUTTON}
    Click at    ${INPUT_MOVE_JOB_POPUP}
    input into    ${INPUT_SEARCH_MOVE_JOB_POPUP}    ${new_job_family_name}
    Click at    ${RESULT_SEARCH_MOVE_JOB_POPUP}    ${new_job_family_name}
    Click at    ${CONFIRM_MOVE_JOB_BUTTON_POPUP}

Archive a job
    [Arguments]    ${job_name}
    Go to Jobs page
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=2s
    wait for page load successfully v1
    Click at    ${JOB_ECLIPSE_ICON}    ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    Check element display on screen    ${HEADER_ARCHIVE_JOB_TEXT_POPUP}
    Check element display on screen    Are you sure you want to archive this job?
    Check element display on screen
    ...    Archiving will remove this job from My Jobs but remain on Jobs page for users to re-publish at any time.
    Check element display on screen    Note: All Archived jobs will be moved to the bottom on the job family
    Click at    ${CONFIRM_ARCHIVE_JOB_BUTTON_POPUP}

Duplicate a job
    [Arguments]    ${job_name}
    Go to Jobs page
    Input into    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=2s
    wait for page load successfully v1
    Click at    ${JOB_ECLIPSE_ICON}    ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DUPLICATE_JOB_BUTTON}

Search a job template
    [Arguments]     ${job_template_name}
    Click at    ${JOB_TEMPLATES_TAB}
    Click at    ${JOB_TEMPLATES_TAB}
    Input into      ${SEARCH_JOB_TEMPLATE_TEXT_BOX}  ${job_template_name}

Search and click a job template
    [Arguments]     ${job_template_name}
    Search a job template   ${job_template_name}
    Click at    ${JOB_TEMPLATES_NAME}    ${job_template_name}

Open job and check attribue is disabled
    [Arguments]    ${job_name}     ${job_package_name}  ${test_location_name}
    go to jobs page
    search and click job name    ${job_name}    ${job_family_name}
    wait for page load successfully
    click at    ${BUTTON_EDIT_DETAILS}
    hover at    ${ICON_LOCKED_DETAILS}    ${test_location_name}
#    Verify text Unable to edit value
    Check element display on screen    Unable to edit value
    Check element display on screen    ${ICON_LOCKED}

Select candidate form for candidate journey
    [Arguments]     ${candidate_form}       ${stage}=None
    IF  '${stage}' == 'None'
        Click at        ${CANDIDATE_JOURNEY_SEND_FORM_STAGE}     Form
    ELSE
        Click at        ${CANDIDATE_JOURNEY_SEND_FORM_STAGE}     ${stage}
    END
    ${is_search_textbox} =       Run keyword and return status      Check element display on screen     ${CANDIDATE_JOURNEY_SEARCH_FORM_TEXTBOX}    wait_time=2s
    IF  ${is_search_textbox} == 'True'
         Input into      ${CANDIDATE_JOURNEY_SEARCH_FORM_TEXTBOX}    ${candidate_form}
    END
    Click by JS    ${CANDIDATE_JOURNEY_FORM_NAME_OPTION}    ${candidate_form}   1s

Select user form for Candidate journey
    [Arguments]     ${user_form}
    Click at    ${CANDIDATE_JOURNEY_SEND_FORM_NEXT_STEPS}
    Click by JS     ${CANDIDATE_JOURNEY_FORM_NAME_OPTION}     ${user_form}

create job data packgage and job basic multi location using job data package
    [Arguments]    ${job_package_name}    ${job_name}
    Go to job data packages page
    add new job package    ${job_package_name}    ${attribute_auto}
#    Create job using job data package, status publish
    ${location}=    set variable    ${LOCATION_NAME_2}
    go to jobs page
    Create new job with type    ${job_family_name}    ${TYPE_BASIC_MULTI_LOCATION}
    input job name    ${job_name}
    Add location for job    ${location}
    Add detail job data package    ${job_package_name}
    Add location on job data package modal    ${location}
    Click at    ${DONE_BTN_DETAILS}
    Add Hiring Team for job
    setup candidate journey and add screen question
    Publish job

add location on job data package modal
    [Arguments]    ${location}      ${area}=None
    click at    ${ADD_LOCATION_BTN_DETAILS}  2
    IF  '${area}' != 'None'
        Click on span text      ${area}
    END
    Click at    ${SELECT_LOCATION_BY_NAME_DETAILS}    ${location}
    Click at    ${APPLY_BTN_DETAILS}
    wait with short time
    Click at    ${NEW_JOB_DATA_PACKAGE_SAVE}
    wait for page load successfully

Create new job with CJ and Form
    [Arguments]    ${job_family_name}    ${user_form}    ${candidate_form}     ${job_type}=None     ${job_name}=None
    IF  '${job_name}' == 'None'
        ${job_name} =    Generate random name    auto_job
    END
    # Input/Choose common info for job
    Go to Jobs page
    simulate input    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    wait with short time
    ${is_job_created} =     Run keyword and Return Status   Check element display on screen     ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   wait_time=2s
    IF  '${is_job_created}' == 'False'
        Click at    ${ICON_ARROW_DOWN}
        Click at    ${NEW_JOB_BUTTON}
        IF  '${job_type}' == 'None'
            Click at    Basic Multi-Location
        ELSE
            Click at   ${job_type}
        END
        Click at    ${NEXT_BUTTON_ON_MODAL}
        Click at    ${INPUT_JOB_FAMILY}
        Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
        Click at    ${SAVE_JOB_ON_MODAL}
        # Redirect to Create Job page
        # Overview step
        input into    ${INPUT_JOB_NAME}    ${job_name}
        Click at    ${SAVE_JOB_BUTTON}
        wait for page load successfully v1
        Add location for job    ${location_user_form}
        Add Hiring Team for job
        # Candidate Journey step
        Add Candidate Journey for job    ${AUTO_CJ_SEND_FORM}     ${user_form}    ${candidate_form}
        # Screening step
        Add Screening Question for job
        Click at    ${SAVE_JOB_BUTTON}
        # Publish Job
        Click at    ${ICON_CHEVRON_DOWN}
        Click at    ${NEW_JOB_PUBLISH_BUTTON}
        Active a job    ${job_name}       ${location_user_form}
    END
    [Return]    ${job_name}

Create new job with Location and CJ and Form
    [Arguments]     ${job_family_name}    ${candidate_form}    ${job_name}    ${location_name}    ${cj_name}    ${status}=None   ${form_stage}=None
    IF  '${job_name}' == 'None'
        ${job_name} =    Generate random name    auto_job
    END
    # Input/Choose common info for job
    Go to Jobs page
    simulate input    ${SEARCH_JOB_TEXT_BOX}    ${job_name}
    wait with short time
    ${is_job_created} =     Run keyword and Return Status    Check element display on screen    ${JOB_FAMILY_NAME_AT_MAIN}    ${job_name}    wait_time=2s
    IF  '${is_job_created}' == 'False'
        Create new job    ${job_name}    ${job_family_name}    is_as_template=False
        Add location for job    ${location_name}
        Add Hiring Team for job    ${CP_ADMIN}
        select candidate journey job    ${cj_name}
        Select candidate form for candidate journey    ${candidate_form}    ${form_stage}
        add attendee for interview
        Add Screening Question for job
        IF  '${status}' != 'None'
            Add Outcome Move To Status    ${status}
        END
        # Publish Job
        Click at    ${ICON_CHEVRON_DOWN}
        Click at    ${NEW_JOB_PUBLISH_BUTTON}
        Active a job    ${job_name}    ${location_name}
    END
    [Return]    ${job_name}

Create a custom New Job and Publish
    [Arguments]     ${job_name}     ${job_family_name}      ${job_location}    ${offer_name}=None    ${hiring_team_name}=None
    # Search existed job
    Go to Jobs page
    Input into  ${SEARCH_JOB_TEXT_BOX}  ${job_name}
    # Check job existed in Job Family or not
    ${is_not_existed} =     Run keyword and return status   Check element not display on screen  ${JOB_FAMILY_SEARCH_RESULT}  wait_time=5s
    Run keyword unless    ${is_not_existed}    Click at    ${JOB_FAMILY_SEARCH_RESULT}
    ${is_not_existed} =     Run keyword and return status   Check element not display on screen  ${JOBS_NAME}    ${job_name}
    # Create new job if not existed
    IF  ${is_not_existed}
        Create new job    ${job_name}    ${job_family_name}     is_as_template=None
        Input content to publish job    ${job_location}    ${offer_name}    ${hiring_team_name}
        Publish job
    END

Create new job with CJ setting two interview stage
    [Arguments]    ${job_family_name}   ${job_type}=None    ${job_name}=None
    IF  '${job_name}' == 'None'
        ${job_name} =    Generate random name    auto_job
    END
    # Input/Choose common info for job
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_BUTTON}
    IF  '${job_type}' == 'None'
        Click at    Basic Multi-Location
    ELSE
        Click at   ${job_type}
    END
    Click at    ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
    Click at    ${SAVE_JOB_ON_MODAL}
    # Redirect to Create Job page
    # Overview step
    input job name    ${job_name}
    Add location for job    ${test_location_name}
    # Hiring Team step
    Add Hiring Team for job
    # Candidate Journey step
    Add Candidate Journey for job    ${cj_with_two_interview_stage}
    # Screening step
    Add Screening Question for job
    Click at    ${SAVE_JOB_BUTTON}
    # Publish Job
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${NEW_JOB_PUBLISH_BUTTON}
    [Return]    ${job_name}

Select candidate journey
    [Arguments]  ${attendee}=Hiring Manager    ${cj_name}=${DEFAULT_CANDIDATE_JOURNEY}
    Select candidate journey job    ${cj_name}
    Click at    ${NEW_JOB_SELECT_VIRTUAL_INTERVIEW}
    add attendee for interview    ${attendee}

Rename Job name
    [Arguments]   ${new_name}
    Click at    ${EDIT_ICON_JOB_NAME}
    Press keys      None    CTRL+a+BACKSPACE
    Input Job name  ${new_name}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully v1

Edit job name then publish
    [Arguments]   ${old_name}  ${new_name}  ${job_family_name}=${JF_COFFEE_FAMILY_JOB}
    Go to Jobs page
    search and click job name  ${old_name}    ${job_family_name}
    Rename Job name   ${new_name}
    Publish job

Go to job outcome section
    [Arguments]     ${job_name}       ${job_family_name}
    Go to Jobs page
    search and click job name  ${job_name}     ${job_family_name}
    Click at    ${EDIT_ICON_JOB_NAME}
    Click on span text      Screening

Add new Outcome for job
    [Arguments]     ${outcome_name}     ${question_name}    ${match_condition}      ${text_message}     ${status}    ${value}=None
    Click at    ${JOB_ADD_OUTCOME_BUTTON}
    Click at    ${JOB_ADD_OUTCOME_BUTTON_ON_MODAL}
    Click at    ${JOB_ADD_OUTCOME_NAME_INPUT_LABEL}
    Input into     ${JOB_ADD_OUTCOME_NAME_INPUT}      ${outcome_name}
    Click at    ${SELECT_QUESTION}
    Click on span text      ${question_name}
    Click at    ${SELECT_MATCH}
    Click on span text      ${match_condition}
    IF      ('${match_condition}'!='Yes') and ('${match_condition}'!='No') and ('${value}'!= 'None')
        Click at    ${INPUT_VALUE}
        input into      ${INPUT_VALUE}      ${value}
    END
    Click at    ${TEXT_AREA_MSG}
    Input into      ${TEXT_AREA_MSG}     ${text_message}
    Click at    ${MOVE_TO_STATUS}
    Click at    ${MOVE_TO_STATUS_VALUE}     ${status}
    Click at    ${JOB_SAVE_OUTCOME_BUTTON}
    Click at    ${JOB_SAVE_OUTCOME_BUTTON}
    wait for page load successfully
    Check element display on screen     ${outcome_name}

Create new job with CJ setting send form stage
    [Arguments]    ${candidate_journey_name}      ${job_family_name}    ${candidate_form}    ${location_name}   ${job_type}=None    ${job_name}=None
    IF  '${job_name}' == 'None'
        ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${job_name} =    Set variable    auto_job_${random}
    END
    # Input/Choose common info for job
    Go to Jobs page
    Click at    ${ICON_ARROW_DOWN}
    Click at    ${NEW_JOB_BUTTON}
    ${is_display}=      run keyword and return status       Check element display on screen     Basic Multi-Location
    IF      '${is_display}'=='True'
        run keyword if      '${job_type}' == 'None'         Click at    Basic Multi-Location
        Click at        ${job_type}
    END
    Click at    ${NEXT_BUTTON_ON_MODAL}
    Click at    ${INPUT_JOB_FAMILY}
    Click at    ${SELECT_JOBS_FAMILY}    ${job_family_name}
    Click at    ${SAVE_JOB_ON_MODAL}
    # Redirect to Create Job page
    # Overview step
    input job name    ${job_name}
    ${is_successs}=    run keyword and return status       Add location for job    ${location_name}
    IF      '${is_successs}'=='False'
        Click at    ${ADD_LOCATION_SEARCH_RESULT_BOX_ICON_CLOSE}
        Select first location in available location list
    END
    # Hiring Team step
    Add Hiring Team for job with user     ${CP_ADMIN}
    # Candidate Journey step
    Choose Candidate Journey for job    cj_name=${candidate_journey_name}       candidate_form=${candidate_form}
    # Screening step
    Add Screening Question for job
    Click at    ${SAVE_JOB_BUTTON}
    # Publish Job
    Click at    ${ICON_CHEVRON_DOWN}
    Click at    ${NEW_JOB_PUBLISH_BUTTON}
    [Return]    ${job_name}

Choose Candidate Journey for job
    [Arguments]     ${cj_name}      ${user_form}=None   ${candidate_form}=None    ${attendee}=None    ${offer_name}=None    ${interview_type}=None
    wait with short time
    Click at    ${CANDIDATE_JOURNEY_TAB}
    Click at    ${NEW_JOB_SELECT_JOURNEY_DROPDOWN}
    Input into    ${NEW_JOB_SELECT_JOURNEY_SEARCH_TEXT_BOX}    ${cj_name}
    Click on span text    ${cj_name}
    wait for page load successfully
    # Select form
    ${is_form_displayed}=   Run keyword and return status       Check text display     Form to send
    IF      '${is_form_displayed}'=='True'
        run keyword if      '${user_form}' != 'None'      Select user form for Candidate journey     ${user_form}
        run keyword if      '${candidate_form}' != 'None'       Select candidate form for candidate journey     ${candidate_form}
    END
    # Setting scheduling
    ${is_scheduling_displayed}=   Run keyword and return status       Check element display on screen     Select Interview Type    wait_time=2s
    IF      '${is_scheduling_displayed}'=='True'
        Click at    ${CANDIDATE_JOURNEY_SELECT_INTERVIEW_TYPE_INPUT}
        Click on span text      ${interview_type}
        IF  '${interview_type}' == 'Auto-Schedule'
            run keyword if      '${attendee}' == 'None'     Add attendee for interview    ${HM}
            Add attendee for interview    ${attendee}
        END
    END
    # Select offer
    ${is_offer_displayed}=   Run keyword and return status       Check element display on screen     Select Offer(s)    wait_time=2s
    IF  '${is_offer_displayed}'=='True'
        Select a offer for job      ${offer_name}
    END
    wait with short time
    Click at    ${SAVE_JOB_BUTTON}

Select first location in available location list
    # choose a location item
    Click at    ${ADD_LOCATION_FIRST_ITEM_ON_MODAL}
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully v1
    Check text display     Available Locations

Select brand name
    [Arguments]    ${brand_name}
    Click at    ${OVERVIEW_STEP_BRAND_NAME_DROPDOWN}
    Click at    ${OVERVIEW_STEP_PATTERN_BRAND_NAME_VALUE}    ${brand_name}

search job family name
    [Arguments]    ${job_family_name}
    simulate input    ${SEARCH_JOB_TEXT_BOX}    ${job_family_name}
    wait with short time
    Check text display      ${job_family_name}

Start a conversation apply job with internal link job
    [Arguments]     ${link_job}          ${candidate_last_name}=None       ${candidate_first_name}=None     ${is_spam_email}=False
    &{info} =    Create Dictionary
    IF      '${candidate_first_name}'=='None'
        ${info.candidate_first_name}=    Generate Random String    7    [LOWER]
    ELSE
        ${info.candidate_first_name}=    set variable       ${candidate_first_name}
    END
    IF      '${candidate_last_name}'=='None'
        ${info.candidate_last_name}=    set variable        Lname
    ELSE
        ${info.candidate_last_name}=    set variable        ${candidate_last_name}
    END
    &{email_info} =  Get email for testing    ${is_spam_email}
    Go to   ${link_job}
    Wait Until Element Is Not Visible    ${WIDGET_FIRST_LOADING_MESSAGE}
    Check Message Widget Site Response Correct    ${WELCOME_CANDIDATE_MESSAGE_5}
    # handle when GDPR popup display
    ${is_display}=      run keyword and return status       Check element display on screen     ${SHADOW_DOM_GDPR_MODAL_ACCEPT_BUTTON}
    IF    '${is_display}'=='True'
        Click at    ${SHADOW_DOM_GDPR_MODAL_ACCEPT_BUTTON}
        wait with short time
    END
    Check Message Widget Site Response Correct    ${ASK_FIRST_AND_LAST_NAME}
    ${candidate_name}=      set variable     ${info.candidate_first_name} ${info.candidate_last_name}
    Input candidate name twice for Shadow Root    ${candidate_name}
    Check Message Widget Site Response Correct    ${ASK_EMAIL}
    ${is_display}=      run keyword and return status       Check Message Widget Site Response Correct      What's the best mobile phone number to contact you?
    IF      '${is_display}'=='True'
        Input text for widget site      ${CONST_PHONE_NUMBER}
    END
    Check Message Widget Site Response Correct      ${REPROMPT_EMAIL_MESSAGE_6}
    Input text for widget site       ${email_info.email}
    ${info.email}=      set variable        ${email_info.email}
    [Return]     &{info}

Reply a screening question
    [Arguments]     ${question_content}     ${answer_input}
    Wait for Olivia reply on widget
    Check Message Widget Site Response Correct      ${question_content}
    Input text for widget site      ${answer_input}

Get link and Filling form
    [Arguments]      ${email}       ${candidate_first_name}       ${company_name}      ${work_experience}=None       ${is_submit}=True    ${is_required_phone}=True
    Check Message Widget Site Response Correct    Please complete your form
    Click at    ${SHADOW_DOM_CONVERSATION_LINK_FORM}
    wait with short time
    switch window       title:Complete Your Form for ${company_name}
    wait until page contains    Enter Verification Code
    # get verifition code to open form
    Enter code for verify code step     ${candidate_first_name}
    # fill personal information section
    Input all valid information into candidate form     is_spam_email=False    is_required_phone=${is_required_phone}
    Click at    ${FORM_NEXT_SECTION_BUTTON}
    ${is_display}=      run keyword and return status       Check text display      Work Experience
    IF      '${is_display}'=='True'
        # fill work experience section
        Fill work experience for form       Employment history 1      ${work_experience}
        Click at    ${FORM_NEXT_SECTION_BUTTON}
    END
    IF      '${is_submit}'=='True'
        Click at    ${FORM_SUBMIT_BUTTON}
        Check text display      Thank you!
    END

#EDIT ADDITIONAL DETAILS
Select frequency option at location
    [Arguments]     ${attribute_type}   ${index}
    ${locator}=     format string      ${ADDITIONAL_DETAILS_CURRENCY_AND_TIME_OPTION}      ${attribute_type}   ${index}
    Click at   ${locator}
    capture page screenshot

Select currency option by attribute type
    [Arguments]     ${currency_type}
    Input into    ${ADDITIONAL_DETAILS_SEARCH_CURRENCY_TEXTBOX}     ${currency_type}
    Click at    ${ADDITIONAL_DETAILS_CURRENCY_VALUE}    ${currency_type}
    Capture page screenshot

Check value currency and time display after select
    [Arguments]      ${attribute_type}    ${value_currency_and_time}     ${index}
    ${locator}=    Format string   ${ADDITIONAL_DETAILS_CURRENCY_AND_TIME_VALUE}   ${attribute_type}    ${value_currency_and_time}     ${index}
    Check element display on screen      ${locator}
    capture page screenshot

Check value time display by attribute type
    [Arguments]     ${attribute_type}   ${value}
    ${locator}=     Format string   ${ADDITIONAL_DETAILS_TIME_VALUE}    ${attribute_type}   ${value}
    Check element display on screen     ${locator}
    capture page screenshot

Check value base pay minimum and maximum of job data package display at edit additional details
    [Arguments]     ${attribute_type}   ${value}
    ${locator}=     Format string   ${ADDITIONAL_DETAILS_MINIMUM_AND_MAXIMUM_PAY_VALUE}     ${attribute_type}   ${value}
    Check element display on screen     ${locator}
    capture page screenshot
