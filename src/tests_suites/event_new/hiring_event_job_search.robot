*** Settings ***
Resource            ../../pages/message_customize_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../data_tests/event/hiring_event_job_search.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    lts_stg    olivia    regresstion    stg    test

*** Variables ***
${job_requisition_id_1}                 PAT050
${job_requisition_name_1}               Automation Tester 050
${job_requisition_location_1}           South Burlington - Vermont
${job_requisition_employment_type_1}    PART_TIME
${job_requisition_id_2}                 PAT049
${job_requisition_name_2}               Automation Tester 049
${job_requisition_id_3}                 PAT048
${job_requisition_name_3}               Automation Tester 048
# Regex get time with format hh:mmAM - hh:mmPM
${regex_get_time}                       ([0-9]{2}:[0-9]{2}(AM|PM))( - )([0-9]{2}:[0-9]{2}(AM|PM))
${event_time_zone}                      (UTC+07:00) Asia/Ho_Chi_Minh - ICT
${EVENT_APPLY_JOB_TITLE}                Let’s Apply for a Job!
${EVENT_APPLY_JOB_DESCRIPTION}          Fast-track your event experience and apply for one of the below jobs.
${start_time_schedule}                  11:00 AM
${end_time_schedule}                    11:30 AM
${interview_time_slots}                 2 Interview Time Slots
${interview_duration}                   30 min
${tram_company}                         tram company
${tram_requisition}                     Floor Tech
${tram_convo}                           tram convo vir

*** Test Cases ***
OL-39661 - Verify loading all messages when opening event landing page clicked from fast-track email & scheduling page (OL-T11310)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}     is_spam_email=False
    Click button in email    Fast-Track your Event Experience & Apply for a Job Now!    ${event_name}   FAST_TRACK_APPLY_EVENT_JOB
    Check element display on screen    ${EVENT_NAME_IN_CARD}    ${event_name}
    capture page screenshot


OL-39660 - Verify candidates show correctly on Event Candidates table list view (OL-T11311)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    ${current_event_url} =    Get location
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}     is_spam_email=False
    Go to   ${current_event_url}
    Click at    Candidates
    Click at    All Candidates
    Check element display on screen    ${candidate_info.full_name}
    Check element display on screen    ${CONST_PHONE_NUMBER}
    capture page screenshot


OL-37861 - Verify user manually adds candidate into an event interview (OL-T11312)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    Candidates
    Click at    All Candidates
    Add new candidate to schedule to event and check it works correctly
    capture page screenshot


Verify the ‘Add Open Job Requisitions’ slideout should appear once clicking on Add Jobs button (OL-T9720)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${EVENT_JOBS_MENU_LABEL}
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    Click at    ${EVENT_DASHBOARD_ADD_JOB_BUTTON}
    Check common text last display  Add Open Job Requisitions
    Select job requisitions show type   Show all requisitions
    Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   ${job_requisition_id_1}
    Check common text last display      Nothing to show right now
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify All job requisitions that are added to the hiring event will display at Job Section (OL-T9705)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Check element display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_1} - ${job_requisition_id_1}
    capture page screenshot


Verify the user can remove a job requisition by clicking on the trash can icon in Jobs section (OL-T9706)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Click at    ${EVENT_CREATOR_JOB_REMOVE_ICON}
    Check element display on screen    ${EVENT_CREATOR_JOB_REMOVE_POPUP}
    Check span display      Are you sure you want to remove the following job requisition from this event?
    Click at    ${EVENT_CREATOR_JOB_REMOVE_CANCEL_BUTTON}
    Check element display on screen    ${job_requisition_name_1}
    capture page screenshot
    Click at    ${EVENT_CREATOR_JOB_REMOVE_ICON}
    Click at    ${EVENT_CREATOR_JOB_REMOVE_CONFIRM_BUTTON}
    Check element display on screen    1 Job Requisition Removed from this Event.
    Check element not display on screen    ${job_requisition_name_1}
    capture page screenshot


Verify The user can remove/add jobs at any time (before and after candidates have applied to the job) (OL-T9723)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Wait with medium time
    ${current_event_url} =    Get location
    # Register event and applied to the job
    Go to event register page
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_EVENT}    ${event_name}   ${job_requisition_name_1}
    Wait with medium time
    # Remove jobs after candidates have applied to the job
    Go to    ${current_event_url}
    Click at    ${EVENT_JOBS_MENU_LABEL}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_1}
    Click at    Remove Jobs
    Click at    ${EVENT_DETAIL_JOB_REMOVE_POPUP_REMOVE_BUTTON}
    Check element not display on screen    ${job_requisition_name_1}
    capture page screenshot
    # Add jobs after candidates have applied to the job
    Click at    ${EVENT_DASHBOARD_ADD_JOB_BUTTON}
    Search and select Job Requisitions      ${job_requisition_name_2}
    Click at    ${CONFIRM_ADD_JOB_BUTTON}
    Check element display on screen    ${job_requisition_name_2}
    capture page screenshot


Verify the Remove Jobs button will appear when selecting jobs at Job tab (OL-T9721)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${EVENT_JOBS_MENU_LABEL}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_1}
    Check element display on screen    Remove Jobs
    Check element display on screen    1 Selected Job Requisition
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_2}
    Check element display on screen    Remove Jobs
    Check element display on screen    2 Selected Job Requisition
    capture page screenshot


Verify user can remove jobs at the Jobs tab (OL-T9722)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${EVENT_JOBS_MENU_LABEL}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_1}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_2}
    Check element display on screen    Remove Jobs
    Check element display on screen    2 Selected Job Requisition
    Click at    Remove Jobs
    Check element display on screen    ${EVENT_DETAIL_JOB_REMOVE_POPUP}
    Check element display on screen    ${EVENT_DETAIL_JOB_REMOVE_POPUP_INNER_TEXT}    ${job_requisition_name_1}
    Check element display on screen    ${EVENT_DETAIL_JOB_REMOVE_POPUP_INNER_TEXT}    ${job_requisition_name_2}
    Click at    ${EVENT_DETAIL_JOB_REMOVE_POPUP_CANCEL_BUTTON}
    Check element not display on screen    ${EVENT_DETAIL_JOB_REMOVE_POPUP}
    Click at    Remove Jobs
    Click at    ${EVENT_DETAIL_JOB_REMOVE_POPUP_REMOVE_BUTTON}
    Check element display on screen    2 Job Requisitions Removed from this Event.
    Check element not display on screen    ${job_requisition_name_1}
    Check element not display on screen    ${job_requisition_name_2}


Verify User can search job by keyword at Add Open Job Requisitions slide (OL-T9703)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${ADD_JOB_BUTTON}
    Search and select Job Requisitions  ${job_requisition_name_1}
    Check span display      1 Selected Requisition
    Check element display on screen    ${job_requisition_name_1}
    capture page screenshot


Candidate applies to the job in case Chat to apply is OFF after registering event (OL-T9674)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Turn on/off Chat to Apply of Event Job tab   On
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_COMMON}    ${event_name}   ${job_requisition_name_2}
    Check navigate to apply for requisition on the ATS job link
    # Cancel event
    Cancel event from event list   ${event_name}


Verify Event Jobs is not shown when Hire Jobs turned ON (OL-T9689)
    # Hire Jobs turn On
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Navigate to    Client Setup
    Click at    ${EVENTS_LABEL}
    Check element not display on screen     Jobs
    Check element not display on screen     Allow the user to add job requisitions to their hiring events
    Check element not display on screen     ${EVENT_JOBS_TOGGLE}
    Check element not display on screen     After the candidate is confirmed registered for the event, trigger Job Search & Chat to Apply
    Check element not display on screen     ${JOBS_TRIGGER_TOGGLE}
    capture page screenshot


Verify Event Jobs is shown when Hire Jobs turned OFF (OL-T9690, OL-T9691)
    # Hire Jobs turn Off, Event Jobs turn On
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Navigate to    Client Setup
    Click at    ${EVENTS_LABEL}
    # Verify Event Jobs is shown when Hire Jobs turned OFF (OL-T9690)
    Check strong text display     Jobs
    Check element display on screen     Allow the user to add job requisitions to their hiring events
    Check element display on screen     ${EVENT_JOBS_TOGGLE}
    Verify element is enable     ${EVENT_JOBS_TOGGLE}
    # Verify [trigger Job Search & Chat to Apply] toggle should be shown when turn ON Event Job (OL-T9691)
    Check element display on screen     After the candidate is confirmed registered for the event, trigger Job Search & Chat to Apply
    Check element display on screen     ${JOBS_TRIGGER_TOGGLE}
    Verify element is enable    ${JOBS_TRIGGER_TOGGLE}
    capture page screenshot


Verify Job Tab is not shown in Hiring Event Builder when Event Jobs turn OFF (OL-T9692)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Check element not display on screen     Jobs
    capture page screenshot


Verify Job Tab is shown in Hiring Event Builder when Event Jobs turn ON (OL-T9693)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Check span display     Jobs
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Click on span text      Jobs
    Check span display      Add Open Job Requisitions
    capture page screenshot


Verify Add Open Job Requisition button should be display when user create Hiring Event (OL-T9694)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    Check element display on screen     ${JOBS_STEP_LABEL}
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Check span display      Add Open Job Requisitions
    Verify display common text  No Open Job Requisitions
    Verify display common text  Have Been Added to This Event
    capture page screenshot


Verify job requisitions is not required to add to Hiring Event (OL-T9695)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Check span display      Add Open Job Requisitions
    Click at    ${NEXT_BUTTON_EVENT}
    Check element display on screen     ${TEAM_EVENT_MEMBER}
    capture page screenshot


Verify status of button Add Requisitions (OL-T9699, OL-T9700)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${ADD_JOB_BUTTON}
    # Verify button Add Requisitions is disable when there's no job requistions selected (OL-T9699)
    Verify element is disable   ${CONFIRM_ADD_JOB_BUTTON}
    capture page screenshot
    Search and select Job Requisitions     ${job_requisition_id_1}
    # Verify button Add Requisition is enable when having jobs selected (OL-T9700)
    Verify element is enable    ${CONFIRM_ADD_JOB_BUTTON}
    capture page screenshot


Verify the header display total count of selected jobs when User selected job requistions (OL-T9701)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${ADD_JOB_BUTTON}
    Search and select Job Requisitions     ${job_requisition_id_1}
    Check span display      1 Selected Requisition
    capture page screenshot


Verify the jobs has been added to Hiring Event is not displayed in Add Open Job Requisition Slide (OL-T9702)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Check element display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_1} - ${job_requisition_id_1}
    Click at    ${ADD_JOB_BUTTON}
    Select job requisitions show type   Show all requisitions
    Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   ${job_requisition_id_1}
    Check common text last display      Nothing to show right now
    capture page screenshot


Verify Job Slide display empty state when the search criteria added results in zero job requisitions (OL-T9704)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${ADD_JOB_BUTTON}
    Select job requisitions show type   Show all requisitions
    Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   PAT111
    Check common text last display      Nothing to show right now
    capture page screenshot


Verify a slideout with all job requisitions added to the event will appear once clicking Manage Added Job (OL-T9707)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Jobs Step   ${job_requisition_id_2}
    Check element display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_1} - ${job_requisition_id_1}
    Check element display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_2} - ${job_requisition_id_2}
    Click at    ${MANAGE_ADD_JOB_BUTTON}
    Check span display  2 Added Jobs
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_name_1}
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_name_2}
    capture page screenshot


Verify user can remove a job requisition (OL-T9708, OL-T9709)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Click at    ${MANAGE_ADD_JOB_BUTTON}
    Hover at    ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    # Verify a trash can icon will appear when hovering a job requisition at Manage Added Jobs slide (OL-T9708)
    Check element display on screen     ${ICON_DELETE_JOB_REQUISITION}  ${job_requisition_id_1}
    capture page screenshot
    # Verify user can remove a job requisition by clicking on trash icon at the Manage Added Jobs slide (OL-T9709)
    Click by JS   ${ICON_DELETE_JOB_REQUISITION}  ${job_requisition_name_1}
    Check element display on screen    1 Job Requisition was Removed from this Event.
    capture page screenshot
    Check element not display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    capture page screenshot
    Click on span text  Save
    Check element not display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_1} - ${job_requisition_id_1}
    capture page screenshot


Verify user can remove many jobs at the Manage Added Jobs slide (OL-T9710)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Jobs Step   ${job_requisition_id_2}
    Click at    ${MANAGE_ADD_JOB_BUTTON}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_1}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id_2}
    Click on span text      Remove Jobs
    Check element display on screen    2 Job Requisitions was Removed from this Event.
    capture page screenshot
    Check element not display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    Check element not display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_2}
    capture page screenshot
    Click on span text  Save
    Check element not display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_1} - ${job_requisition_id_1}
    Check element not display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_2} - ${job_requisition_id_2}
    capture page screenshot


Verify User who manage the Event can change job requisitions when editing the event (OL-T9711)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Go to edit event page from dashboard
    Edit job requisitions   ${job_requisition_id_2}
    Check element display on screen     ${COMMON_DIV_TEXT}      ${job_requisition_name_2} - ${job_requisition_id_2}
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify Job Tab is not shown in Even Home page when Event Jobs turn OFF (OL-T9716)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set tool step and create event
    Check element not display on screen  Jobs
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify Job Tab is shown in Event Home page when Event Jobs turn ON (OL-T9717)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Check element display on screen  Jobs
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify Jobs Tab shows empty stage when no having job requisitions added to Event (OL-T9718)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${EVENT_DASH_BOARD_JOBS_NAVIGATION}
    Check common text last display  No Jobs Have Been Added to This Event.
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify All job requisitions added to the Hiring Event will display within the Jobs tab (OL-T9719)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Jobs Step   ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${EVENT_DASH_BOARD_JOBS_NAVIGATION}
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify User can view job requisitions which user has access to the job via their req permissions (OL-T9698)
    Given Setup test
    when Login into system with company    ${CP_ADMIN}    ${COMPANY_EVENT}
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${ADD_JOB_BUTTON}
    Select job requisitions show type   Show all assigned
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_2}
    Check element display on screen     Job Requisition ID
    Check element display on screen     Job Requisition Title
    Check element display on screen     Job Category
    Check element display on screen     City
    Check element display on screen     State
    Check element display on screen     Employment Type
    capture page screenshot


Verify User can search added job requisitions by keyword at Jobs tab (OL-T9724, OL-T9725)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Click at    ${EVENT_JOBS_MENU_LABEL}
    Check element display on screen     2 Job Requisitions
    Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   ${job_requisition_id_1}
    Check element display on screen     1 Job Requisition
    Check element display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_1}
    Check element not display on screen     ${JOB_REQUISITION_ITEM}     ${job_requisition_id_2}
    capture page screenshot
    # Verify Jobs tab display empty state when the search criteria added results in zero job requisitions (OL-T9725)
    Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   PAT003
    Check element display on screen     0 Job Requisitions
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify UI of Candidates Tab displays correctly (OL-T9726, OL-T97287)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    ${current_event_url} =    Get location
    # Register event
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_EVENT}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${COMPANY_EVENT}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Go to    ${current_event_url}
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_MENU_LABEL}
    # Verify Job Title, Requisition ID display empty at the candidate’s event registration conversation (OL-T9727)
    Check element display on screen     Job Title
    ${value} =    Get text and format text   ${ALL_CANDIDATES_JOB_TITLE_VALUE}      ${candidate_info.full_name}
    Should Contain    ${value}    -
    Check element display on screen     Requisition ID
    ${value} =    Get text and format text   ${ALL_CANDIDATES_REQUISITION_ID_VALUE}     ${candidate_info.full_name}
    Should Contain    ${value}    -
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify 'Apply On' column display time that the candidate completed the Chat to Apply conversation (OL-T9728, OL-T9729)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    ${current_event_url} =    Get location
    # Register event
    Go to event register page
    ${event_register_url} =    Get location
    ${event_date} =     Get text and format text   ${UPCOMING_EVENT_DATE}
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_EVENT}    ${event_name}   ${job_requisition_name_1}
    Wait with medium time
    Go to    ${current_event_url}
    Navigate to job applied of candidate    ${candidate_info.full_name}
    Check element display on screen     Job Title
    ${value} =    Get text and format text   ${ALL_CANDIDATES_JOB_TITLE_NEXT_LINE_VALUE}      ${candidate_info.full_name}
    Should Contain    ${value}      ${job_requisition_name_1}
    Check element display on screen     Requisition ID
    ${value} =    Get text and format text   ${ALL_CANDIDATES_REQUISITION_ID_NEXT_LINE_VALUE}      ${candidate_info.full_name}
    Should Contain    ${value}      ${job_requisition_id_1}
    # Verify 'Apply On' column display empty at the candidate’s in-progress chat to apply conversation (OL-T9728)
    Check element display on screen     ${ALL_CANDIDATES_APPLY_ON_NEXT_LINE_VALUE}      ${candidate_info.full_name}
    ${value} =    Get text and format text   ${ALL_CANDIDATES_APPLY_ON_NEXT_LINE_VALUE}      ${candidate_info.full_name}
    Should Contain    ${value}      -
    # Complete process apply job
    Go to   ${event_register_url}
    wait element visible   ${SHADOW_DOM_EVENT_WIDGET_CONVERSATION_LAYOUT}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    Go to    ${current_event_url}
    Navigate to job applied of candidate    ${candidate_info.full_name}
    #Verify 'Apply On' column display time that the candidate completed the Chat to Apply conversation (OL-T9729)
    Check element display on screen     ${ALL_CANDIDATES_APPLY_ON_NEXT_LINE_VALUE}      ${candidate_info.full_name}
    ${value} =    Get text and format text   ${ALL_CANDIDATES_APPLY_ON_NEXT_LINE_VALUE}      ${candidate_info.full_name}
    Should Contain    ${value}      ${event_date}
    capture page screenshot
   # Cancel event
    Cancel event from event list   ${event_name}


Verify the Job section should not show when zero jobs are added to the event (OL-T9731)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register event
    Go to event register page
    Check element not display on screen     Jobs
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify the Job section should be displayed when having jobs are added to the event (OL-T9732)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register event
    Go to event register page
    Check element display on screen     Jobs
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify the Event data display correctly in the card on the left page when event venue is in-person (OL-T9733)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    ${event_info} =     Get information of event    ${event_name}
    # Register event
    Click at    ${event_name}
    Go to event register page
    # Check information of event
    Check element display on screen     ${event_name}
    ${actual_date_value} =      Get text and format text   ${LANDING_PAGE_EVENT_DATE}
    should contain  ${actual_date_value}    ${event_info.event_date}
    ${actual_time_value} =      Get text and format text   ${LANDING_PAGE_EVENT_TIME}
    should contain  ${actual_time_value}    ${event_info.event_time}
    ${actual_location_value} =      Get text and format text   ${LANDING_PAGE_EVENT_LOCATION}
    should contain  ${actual_location_value}    ${event_info.location_name}
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify the Event data display correctly in the card on the left page when event venue is virtual (OL-T9734)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    ${event_info} =     Get information of event    ${event_name}
    # Register event
    Click at    ${event_name}
    Go to event register page
    # Check information of event
    Check element display on screen     ${event_name}
    ${actual_date_value} =      Get text and format text   ${LANDING_PAGE_EVENT_DATE}
    should contain  ${actual_date_value}    ${event_info.event_date}
    ${actual_time_value} =      Get text and format text   ${LANDING_PAGE_EVENT_TIME}
    should contain  ${actual_time_value}    ${event_info.event_time}
    ${actual_location_value} =      Get text and format text   ${LANDING_PAGE_EVENT_LOCATION}
    should contain  ${actual_location_value}    Virtual
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify Event Schedule section displays all added event sessions (OL-T9738)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Click at    Event Schedule
    Check element display on screen     ${session_info.session_name}
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify all added jobs of hiring event will be listed at Jobs section (OL-T9739)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Click at    Jobs
    ${job_name} =      Get text and format text   ${JOB_CARD_TITLE}
    should contain  ${job_name}    ${job_requisition_name_1}
    ${job_location} =      Get text and format text   ${JOB_CARD_LOCATION}
    should contain  ${job_location}    ${job_requisition_location_1}
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify the middle card view more information about the selected job requisition when the candidate clicks on a job requisition (OL-T9740, OL-T9741, OL-T9742)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    Go to event register page
    Click at    Jobs
    Click at    ${job_requisition_name_1}
    ${job_name} =      Get text and format text   ${EVENT_JOB_DETAIL_NAME}
    should contain  ${job_name}    ${job_requisition_name_1}
    ${job_location} =      Get text and format text   ${EVENT_JOB_DETAIL_LOCATION}
    should contain  ${job_location}    ${job_requisition_location_1}
    ${job_employment_type} =      Get text and format text   ${EVENT_JOB_DETAIL_EMPLOYMENT_TYPE}
    should contain  ${job_employment_type}    ${job_requisition_employment_type_1}
    Check element display on screen     Description
    capture page screenshot
    # Verify message 'please first register for the event.' should be shown in a job details page when candidate has not registered for event (OL-T9741)
    Check element display on screen     To apply to this job, please first register for the event.
    capture page screenshot
    # Verify User can back to list Jobs once clicking on 'Back to Event' from Job detail page (OL-T9742)
    Click at    ${BACK_TO_EVENT_LANDING_PAGE}
    Check element display on screen     ${job_requisition_name_1}
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify display button Register for Event when the candidate has not registered to the event (OL-T9743, OL-T9744)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Check element display on screen     Register for Event
    Click at    ${REGISTER_EVENT}
    Wait with short time
    ${event_status_text} =    Get text and format text    ${EVENT_STATUS}
    Should be equal as Strings    ${event_status_text}    Registration In Progress
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify the left card hold on 'Registration In Progress' button when candidate has not completed to regester for event (OL-T9745)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Check element display on screen     Register for Event
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_EVENT}       ${event_name}
    ${event_status_text} =    Get text and format text    ${EVENT_STATUS}
    Should be equal as Strings    ${event_status_text}    Registration In Progress
    capture page screenshot
    # Cancel event
    Cancel event from event list    ${event_name}


Verify the button at left card will disappear when candidate can not register to Event (OL-T9746)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set timezone for event      ${event_time_zone}
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    # Edit default outcome to Do not register and Send closing message
    Go to edit outcome      Default Outcome
    Click at    ${ADD_OUTCOME_ACTION_DROPDOWN}
    Click at    Do Not Register & Send Closing Message
    Click at    ${SAVE_OUTCOME_BUTTON}
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_EVENT}       ${event_name}
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}   wait_time=60s
    Check element not display on screen     Registration In Progress
    capture page screenshot
    # Cancel event
    Cancel event from event list without candidate schedule   ${event_name}


Verify the button at left card will change to Registered when candidate pass action of conversation with outcome is Register for Event (OL-T9747)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - virtual
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Live Video Broadcast
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_EVENT}       ${event_name}
    Check element display on screen     Registered
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify the button at left card will change to Registered when candidate pass action of conversation with outcome is Register & Schedule to Event Interview (OL-T9748)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}
    Check element display on screen     Registered
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify not trigger jobs after candidate registered event IF Job Requisitions are not added to the hiring event (OL-T9749)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}
    Check element not display on screen     ${EVENT_APPLY_JOB_TITLE}
    Check element not display on screen     ${EVENT_APPLY_JOB_DESCRIPTION}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify trigger jobs list 3 seconds after candidate confirmed registered when Chat to Apply toggle is ON (OL-T9751, OL-T9752)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}
    Wait with short time
    Check element display on screen     ${EVENT_APPLY_JOB_TITLE}
    Check element display on screen     ${EVENT_APPLY_JOB_DESCRIPTION}
    Check element display on screen     ${job_requisition_name_1}
    capture page screenshot
    # Verify the middle card will transition to a similar child page with additional information about the job requisition when candidate clicks on a job (OL-T9752)
    Click at    ${job_requisition_name_1}
    Check element display on screen     Back to All Jobs
    Check element display on screen     Apply Now
    capture page screenshot
    Click at    ${BACK_TO_EVENT_LANDING_PAGE}
    Check element display on screen     ${job_requisition_name_1}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify button 'Apply Now' will be disabled when the event canceled (OL-T9753)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}
    # Cancel event
    Open new tab same browser
    ${handles}=     Get Window Handles
    Switch Window  ${handles}[1]
    Cancel event from event list   ${event_name}
    Switch Window  ${handles}[0]
    Wait with short time
    ${verify_message} =     Format String   ${EVENT_DECISION_CANCEL_MESSAGE}  first_name=${candidate_info.first_name}      event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Click at    ${job_requisition_name_1}
    wait with short time
    Check element not display on screen     Apply Now
    capture page screenshot


Verify UI of Event landing page after candidate registered for Event (OL-T9754, OL-T9755, OL-T9756, OL-T9757)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and apply job    ${COMPANY_EVENT}     ${event_name}    ${job_requisition_name_1}
    Click at    ${BACK_TO_EVENT_LANDING_PAGE}
    Check element display on screen     My Applications
    Check element display on screen     All Jobs
    capture page screenshot
    # Verify an ‘In-Progress’ pill will appear at the job card that the candidate is currently in progress of completing a chat to apply conversation (OL-T9755)
    Check element display on screen     ${EVENT_JOB_IN_PROGRESS_LABEL}  ${job_requisition_name_1}
    capture page screenshot
    # Complete process apply job
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    wait with short time
    # Verify The ‘In-Progress’ pill will disappear at the job card when the chat to apply conversation is complete. (OL-T9756)
    Check element not display on screen     ${EVENT_JOB_IN_PROGRESS_LABEL}  ${job_requisition_name_1}
    capture page screenshot
    # Verify all job requisitions added to the hiring event will be listed under All Jobs at Jobs tab (OL-T9757)
    Check element display on screen     ${EVENT_ITEM_JOB_MY_APPLICATION}  ${job_requisition_name_1}
    Check element display on screen     ${EVENT_ITEM_JOB_ALL_JOB}  ${job_requisition_name_1}
    Check element display on screen     ${EVENT_ITEM_JOB_ALL_JOB}  ${job_requisition_name_2}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify candidate can not apply for another jobs when the candidate is currently in-progress of completing chat to apply conversation (OL-T9758)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and apply job    ${COMPANY_EVENT}     ${event_name}    ${job_requisition_name_1}
    Click at    ${BACK_TO_EVENT_OVERVIEW_ICON}
    Click at    ${job_requisition_name_2}
    Check element display on screen    Please Complete Your Application for ${job_requisition_name_1}
    # Cancel event
    Cancel event from event list   ${event_name}


Verify the Job is triggered if RESCHEDULE interview by candidate right after he is scheduled. (OL-T9760, OL-T9762)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name}=  Set Overview step with future time    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    Set session schedule with interviewer   Scheduled Interviews    ${CA_TEAM}      None    2 Interview Time Slots
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}
    Wait with short time
    # Verify the Job is triggered once candidate scheduled event interview on Event has Interview session (OL-T9760)
    Check element display on screen     ${EVENT_APPLY_JOB_TITLE}
    Check element display on screen     ${EVENT_APPLY_JOB_DESCRIPTION}
    Check element display on screen     ${job_requisition_name_1}
    capture page screenshot
    # Verify the Job is triggered if RESCHEDULE interview by candidate right after he is scheduled. (OL-T9762)
    Candidate reschedule interview event    ${COMPANY_EVENT}    ${event_name}
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${COMPANY_EVENT}   ${event_name}
    Check message widget site response correct    ${verify_message}
    Wait with short time
    Check element display on screen     ${EVENT_APPLY_JOB_TITLE}
    Check element display on screen     ${EVENT_APPLY_JOB_DESCRIPTION}
    Check element display on screen     ${job_requisition_name_1}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify 'Apply for a Job' email will be sent to candidate via Email when the candidate’s communication preference is email (OL-T9767)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}     is_spam_email=False
    Click button in email    Fast-Track your Event Experience & Apply for a Job Now!    ${event_name}   FAST_TRACK_APPLY_EVENT_JOB
    Check element display on screen    ${EVENT_NAME_IN_CARD}    ${event_name}
    Click at    ${job_requisition_name_1}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    # Cancel event
    Cancel event from event list   ${event_name}


Candidate applies to the job that matches targeting rule by clicking on Apply for a Job now from Email after registering the event (OL-T9687)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}     is_spam_email=False
    Click button in email    Fast-Track your Event Experience & Apply for a Job Now!    ${event_name}   FAST_TRACK_APPLY_EVENT_JOB
    Check element display on screen    ${EVENT_NAME_IN_CARD}    ${event_name}
    Wait with short time
    Click at    ${job_requisition_name_1}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    Go to CEM page
    Open a candidate Conversation    ${candidate_info.full_name}
    Click at    ${CEM_CANDIDATE_PROFILE_BUTTON}
    Check element display on screen    ${CEM_CANDIDATE_PROFILE_NAME_TEXT}    ${job_requisition_name_1}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Candidate click to applies to the job that matches targeting rule after registering event (OL-T9672)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_EVENT}    ${event_name}   ${job_requisition_name_1}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    Go to CEM page
    Open a candidate Conversation    ${candidate_info.full_name}
    Click at    ${CEM_CANDIDATE_PROFILE_BUTTON}
    Check element display on screen    ${CEM_CANDIDATE_PROFILE_NAME_TEXT}    ${job_requisition_name_1}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Candidate finishes applying to the job and click to Apply Now on another job (OL-T9677, OL-T9678)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Jobs Step    ${job_requisition_id_3}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_EVENT}    ${event_name}   ${job_requisition_name_1}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    # Apply for another job
    Click at    ${BACK_TO_EVENT_LANDING_PAGE}
    Wait with short time
    Check element not display on screen     ${EVENT_JOB_IN_PROGRESS_LABEL}  ${job_requisition_name_1}
    Click at    ${job_requisition_name_3}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    Go to CEM page
    Open a candidate Conversation    ${candidate_info.full_name}
    Click at    ${CEM_CANDIDATE_PROFILE_BUTTON}
    Check element display on screen    ${CEM_CANDIDATE_PROFILE_NAME_TEXT}    ${job_requisition_name_1}
    Check element display on screen    ${CEM_CANDIDATE_PROFILE_NAME_TEXT}    ${job_requisition_name_3}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify My Interview card will be added to left page when candidate is scheduled for an interview during the event (OL-T9768, OL-T9769, OL-T9770)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Jobs Step    ${job_requisition_id_1}
    Set Team step   ${CA_TEAM}
    # Set interview session virtual
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VT_INTERVIEW_SCHEDULE}
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Scheduled Interviews
    Click at    ${SAVE_SESSION_NAME}
    # Set interview session Live Video Broadcast
    Set session schedule    Live Video Broadcast
    Click at    ${SAVE_SESSION_NAME}
    Set Registration step    None    None
    # Edit default outcome to Do not register and Send closing message
    Go to edit outcome      Default Outcome
    Click at    ${ADD_OUTCOME_ACTION_DROPDOWN}
    Click at    Register & Schedule to Event Interview
    Click at    ${SAVE_OUTCOME_BUTTON}
    Set Tools step
    # Register a candidate to event and schedule
    Go to event register page
    &{schedule_info}=   Get information of event schedule at landing site
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_EVENT}       ${event_name}    is_spam_email=False
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    Click button in email    Your registration for ${COMPANY_EVENT}'s ${event_name} is confirmed!    We are looking forward to meeting you!     REGISTERED_EVENT
    # Check information of schedule event (OL-T9768, OL-T9770)
    Check element display on screen     ${session_name}
    ${actual_schedule_time} =      Get text and format text   ${EVENT_MY_SCHEDULE_INTERVIEW_TIME}
    should contain  ${actual_schedule_time}    ${schedule_info.schedule_time}
    ${actual_schedule_time_left_card} =      Get text and format text   ${EVENT_MY_SCHEDULE_INTERVIEW_LEFT_CARD_TIME}
    should contain  ${actual_schedule_time_left_card}    ${schedule_info.schedule_time}
    ${actual_schedule_type} =      Get text and format text   ${EVENT_MY_SCHEDULE_INTERVIEW_TYPE}
    should contain  ${actual_schedule_type}    30 Minutes Virtual Interview
    ${actual_schedule_type_left_card} =      Get text and format text   ${EVENT_MY_SCHEDULE_INTERVIEW_LEFT_CARD_TYPE}
    should contain  ${actual_schedule_type_left_card}    30 Minutes Virtual Interview
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify the Event Schedule at header will display olivia-highlight when scrolling to Event Schedule section (OL-T9737)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Set Window Size     ${1200}    ${600}
    Scroll to element  ${COMMON_DIV_TEXT}     ${session_info.session_name}
    wait with short time
    ${class_attribute} =    Get attribute and format text     class     ${EVENT_SCHEDULE_TAB}
    Should contain     ${class_attribute}     is-active
    capture page screenshot


Verify the Message Customizaton - Event Messaging will be added Job Search & Chat to Apply section (OL-T9771)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Go to Message Customization page
    Click at    ${EVENTS_TAB}
    Click at    Job Search & Chat to Apply
    Click on span text    Web
    Check common text last display     ${MES_CUS_EVENT_INITIAL_JOB_SEARCH}
    Check common text last display     ${MES_CUS_EVENT_START_CHAT_TO_APPLY}
    capture page screenshot


Candidate applies to the job that does no match targeting rule after registering event (OL-T9673)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_EVENT}    ${event_name}   ${job_requisition_name_2}
    Check navigate to apply for requisition on the ATS job link
    # Cancel event
    Cancel event from event list   ${event_name}


Candidate applies to the job that does not match targeting rule by clicking on Apply for a Job now from Email after registering the event (OL-T9688)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${candidate_info} =  Candidate register event and schedule    ${COMPANY_EVENT}     ${event_name}     is_spam_email=False
    Click button in email    Fast-Track your Event Experience & Apply for a Job Now!    ${event_name}   FAST_TRACK_APPLY_EVENT_JOB
    Check element display on screen    ${EVENT_NAME_IN_CARD}    ${event_name}
    Click at    ${job_requisition_name_2}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    Check navigate to apply for requisition on the ATS job link
    # Cancel event
    Cancel event from event list   ${event_name}


Verify the rating trigger ‘Event Registration (Conversation Complete)’ will not available within the event creation when Chat to Apply toggle ON (OL-T9713)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_2}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Click at    ${TOOLS_STEP_LABEL}
    Check rating trigger Event Registration Conversation Complete will not available


Candidate finishes applying to the job and click to Apply Now on the old job in case number days of reapplies is 0 day and > 0 day (OL-T9675, OL-T9676)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    Select Multi Application type in client setup   30 days
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    In Person
    ${event_name} =    Set Overview step    In Person    Single Event
    Set Jobs Step    ${job_requisition_id_3}
    Set Team step   ${CA_TEAM}
    &{session_info}=    Set Schedule step    Scheduled Interviews
    Set Registration step    None    None
    Set Tools step
    # Register a candidate to event
    Go to event register page
    ${event_register_url} =    Get location
    ${candidate_info} =     Candidate register event and apply job      ${COMPANY_EVENT}    ${event_name}   ${job_requisition_name_3}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    # Apply for same job with number days of reapplies is 30 days
    Click at    ${BACK_TO_EVENT_LANDING_PAGE}
    Wait with short time
    Click at    ${job_requisition_name_3}
    Click by JS    ${EVENT_JOB_APPLY_BUTTON}   slow_down=10s
    @{window} =    get window handles
    switch window    ${window}[0]
    ${msg_cannot_apply_same_job} =  Format String  ${CANDIDATE_CANNOT_APPLY_SAME_JOB}   ${job_requisition_name_3}
    Check message widget site response correct     ${msg_cannot_apply_same_job}
    capture page screenshot
    # Apply for same job with number days of reapplies is 0 day
    Select Multi Application type in client setup   0 days
    Go to   ${event_register_url}
    Click at    ${EVENT_ITEM_JOB_ALL_JOB}  ${job_requisition_name_3}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    Check message widget site response correct      ${EVENT_EXPERIENCE_QUESTION}
    Input text for widget site    3 years
    ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${COMPANY_EVENT}
    Check message widget site response correct      ${verify_message}
    capture page screenshot
    # Cancel event
    Cancel event from event list   ${event_name}


Verify the rating trigger ‘Event Registration’ will not available within the event has edited to add jobs and has a trigger rating (OL-T9712, OL-T9714, OL-T9715, OL-T9772, OL-T9773)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_COMMON}
    Turn on/off Chat to Apply of Event Job tab   Off
    when Go to Events page
    # Create hiring event - in-person
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name}=  Set Overview step with future time    Virtual    Single Event
    Set Team step   ${CA_TEAM}
    # Set interview session virtual
    Click at    ${SCHEDULE_STEP_LABEL}
    Select Event session available time
    Click at    ${VT_INTERVIEW_SCHEDULE}
    ${session_name} =   Fill valid data into remain fields Interview Session    Virtual Scheduled Interviews
    Click at    ${SAVE_SESSION_NAME}
    Set Registration step    None    None
    # Verify the rating trigger ‘Event Registration’ will available (OL-T9712, OL-T9714)
    Set Event Rating Trigger in Tools step    Candidates    Event Registration (Conversation Complete)    Immediately   rating_event
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    # Verify Rating is triggered when Event has no Job (OL-T9772)
    Check message widget site response correct      ${EVENT_RATING_MESSAGE}     wait_time=120s
    Check message widget site response correct    auto_rating_question
    capture page screenshot
    # Add job to event
    when Go to Events page
    Go to edit event    ${event_name}
    Set Jobs Step    ${job_requisition_id_2}
    Click at    ${TOOLS_STEP_LABEL}
    Click create event button
    Go to event register page
    # Register a new candidate to event
    Click at    ${REGISTER_EVENT}
    Input text for widget site      new
    ${candidate_info} =     Input information for candidate in event conversation   ${COMPANY_COMMON}       ${event_name}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    # Verify Rating is not triggered when Event has Job (OL-T9773)
    element should not contain  ${MESSAGE_CONVERSATION}     ${EVENT_RATING_MESSAGE}
    element should not contain  ${MESSAGE_CONVERSATION}     auto_rating_question
    capture page screenshot
    # Turn on chat to apply at Event tab
    Turn on/off Chat to Apply of Event Job tab   On
    when Go to Events page
    Go to edit event    ${event_name}
    # Verify the rating trigger ‘Event Registration’ will not available (OL-T9715)
    Click at    ${TOOLS_STEP_LABEL}
    Check rating trigger Event Registration Conversation Complete will not available
    Close dropdown setting Event Ratings
    Click create event button
    # Cancel event
    Cancel event from event list   ${event_name}


Hiring Event Job - Event convo sometimes works incorrectly on Event landing page (cover bug OL-39849)
    [Tags]      olivia
    Given Setup test
    when Login into system    ${VIEW_ONLY}
    Go to       https://olivia.paradox.ai/candidates/all-candidates?selected=72036893256500
    # Create hiring event - virtual
    Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Jobs Step    ${tram_requisition}
    &{session_info}=    Set Schedule step    Virtual Chat Booth
    Set Registration step    None    None       conversation_name=${tram_convo}
    Set Tools step
    # Register a candidate to event
    Go to event register page
    Click at    ${REGISTER_EVENT}
    Check element display on screen    ${REGISTER_EVENT_IN_PROGRESS}
    FOR    ${index}    IN RANGE    10
        Check term dialog is displayed
        Click at        ${SHADOW_DOM_TERM_ACCEPT_BUTTON}
        wait with short time
        Check element display on screen      ${SHADOW_DOM_TERM_ACCEPTED_TEXT}
        Capture page screenshot
        ${verify_message} =     Format String   ${EVENT_NAME_QUESTION}  company_name=${tram_company}   event_name=${event_name}
        Check message widget site response correct   ${verify_message}
        Check message widget site response correct   ${TERM_ACCEPTED_MESSAGE}
        ${candidate_info} =      Generate candidate name
        Input text for widget site    ${candidate_info.full_name}
        ${verify_message} =     Format String   ${EVENT_MOBILE_QUESTION}  candidate_name=${candidate_info.first_name}
        Check message widget site response correct     ${verify_message}
        Input text for widget site    ${CONST_PHONE_NUMBER}
        ${verify_message} =     Format String   ${EVENT_EMAIL_QUESTION}  candidate_name=${candidate_info.first_name}
        Check message widget site response correct     ${verify_message}
        &{email_info} =    Get email for testing
        Input text for widget site    ${email_info.email}
        Check message widget site response correct    Areyou 18 year old?
        Input text for widget site    yes
        Check message widget site response correct    ${EVENT_CONTACT_QUESTION}
        Click on option in conversation    Email Only
        Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
        Click at        ${SHADOW_DOM_TERM_DECLINE_BUTTON}
        Check message widget site response correct      Congratulations
        Check message widget site response correct      ${LANDING_SITE_FAST_TRACK}
        # Apply job
        Click at    ${tram_requisition}     slow_down=2s
        Click by JS    ${EVENT_JOB_APPLY_BUTTON}   slow_down=2s
        Check message widget site response correct      Thank you for your Interest! I can help you apply to ${tram_requisition}
        Check message widget site response correct      Do you like flowers?
        Input text for widget site    no
        Check message widget site response correct    ${EVENT_CONTACT_QUESTION}
        Click on option in conversation    Email Only
        Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
        Check message widget site response correct      ${LOCATION_DISCOVERY}
        Check message widget site response correct      ${LANDING_SITE_SELECT_LOCATION}
        Input text for widget site    1
        ${verify_message} =     Format String   ${EVENT_THANK_YOU_MESSAGE}  company_name=${tram_company}
        Check message widget site response correct   ${verify_message}
        Check message widget site response correct   ${EVENT_DO_ANY_TIMES_WORK}
        Click at    ${BACK_TO_EVENT_OVERVIEW_ICON}
        Input text for widget site      new
    END
    Check term dialog is displayed
    Click at        ${SHADOW_DOM_TERM_ACCEPT_BUTTON}
    wait with short time
    Check element display on screen      ${SHADOW_DOM_TERM_ACCEPTED_TEXT}

*** Keywords ***
Apply a job in chat
    [Arguments]    ${job_name}
    Click at    ${job_name}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    Wait with medium time
    Input text for widget site    18
    Input text for widget site    anything
    Input text for widget site    nothing

Search and select Job Requisitions
    [Arguments]    ${job_requisition_id}
    Select job requisitions show type   Show all requisitions
    Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   ${job_requisition_id}
    Click at    ${EVENT_JOB_CHECKBOX}    ${job_requisition_id}

Edit job requisitions
    [Arguments]     ${job_req_id}
    Click at    ${JOBS_STEP_LABEL}
    Click at    ${EVENT_CREATOR_JOB_REMOVE_ICON}
    Click at    ${EVENT_CREATOR_JOB_REMOVE_CONFIRM_BUTTON}
    Click at    ${ADD_JOB_BUTTON}
    IF    '${job_req_id}' == 'None'
        Click at    ${FIRST_JOB_CHECKBOX}
    ELSE
        Select job requisitions show type   Show all requisitions
        Input into  ${EVENT_JOB_SEARCH_JOB_TEXTBOX}   ${job_req_id}
        Click at    ${EVENT_JOB_CHECKBOX}    ${job_req_id}
    END
    Click at    ${CONFIRM_ADD_JOB_BUTTON}

Navigate to job applied of candidate
    [Arguments]     ${candidate_name}
    Click at    ${CANDIDATE_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_MENU_LABEL}
    Click at    ${ALL_CANDIDATES_ICON_PROFILE}      ${candidate_name}

Candidate register event and apply job
    [Arguments]     ${company_name}     ${event_name}   ${job_requisition_name}
    ${candidate_info}=  Candidate register event and schedule    ${company_name}     ${event_name}
    wait until element is visible    ${JOB_DESC_TEXT}    30s
    Click at    ${job_requisition_name}
    Click at    ${EVENT_JOB_APPLY_BUTTON}
    Wait with medium time
    [Return]    ${candidate_info}

Get information of event
    [Arguments]     ${event_name}
    Go to Events page
    Search event    ${event_name}
    ${event_date} =     Get text and format text   ${UPCOMING_EVENT_DATE}
    ${time} =     Get text and format text   ${UPCOMING_EVENT_TIME}
    ${event_time_format} =      Get Regexp Matches    ${time}    ${regex_get_time}
    ${event_time} =    Get from list    ${event_time_format}    0
    ${location_name} =    Get text and format text   ${UPCOMING_EVENT_LOCATION}
    &{event_info} =    Create Dictionary
    ${event_info.event_date} =   Set variable    ${event_date}
    ${event_info.event_time} =   Set variable    ${event_time}
    ${event_info.location_name} =   Set variable    ${location_name}
    [Return]    &{event_info}

Candidate register event and schedule
    [Arguments]     ${company_name}     ${event_name}   ${is_spam_email}=True
    Click at    ${REGISTER_EVENT}
    ${candidate_info} =     Input information for candidate in event conversation   ${company_name}       ${event_name}     ${is_spam_email}
    ${verify_message} =     Format String   ${EVENT_THANKS_AND_REGISTER_SUCCESS}  first_name=${candidate_info.first_name}  event_name=${event_name}
    Check message widget site response correct    ${verify_message}
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1
    ${verify_message} =     Format String   ${EVENT_IN_PERSON_INTERVIEW_DETAIL_MESSAGE}  ${candidate_info.first_name}   ${company_name}   ${event_name}
    Check message widget site response correct    ${verify_message}
    [Return]    ${candidate_info}

Candidate reschedule interview event
    [Arguments]     ${company_name}     ${event_name}
    Input text for widget site    reschedule
    ${verify_message} =     Format String   ${EVENT_RESCHEDULE_INTERVIEW}   ${company_name}
    Check message widget site response correct    ${verify_message}
    Input text for widget site    yes
    Check message widget site response correct    ${EVENT_DO_ANY_TIMES_WORK}
    Input text for widget site    1

Get information of event schedule at landing site
    ${time} =     Get text and format text   ${EVENT_SCHEDULE_INTERVIEW_CARD_TIME}
    ${schedule_time_format} =      Get Regexp Matches    ${time}    ${regex_get_time}
    ${schedule_time} =    Get from list    ${schedule_time_format}    0
    &{schedule_info} =    Create Dictionary
    ${schedule_info.schedule_time} =   Set variable    ${schedule_time}
    [Return]    &{schedule_info}

Check navigate to apply for requisition on the ATS job link
    @{window} =    get window handles
    switch window    ${window}[1]
    ${ats_url} =    Get location
    # We using Google url for sample ATS url
    should contain      ${ats_url}      https://www.google.com/


Check rating trigger Event Registration Conversation Complete will not available
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Check element not display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Registration (Conversation Complete)
    capture page screenshot

Close dropdown setting Event Ratings
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_CANCEL_BUTTON}
    Click at    ${EVENT_RATINGS_CANCEL_BUTTON}
