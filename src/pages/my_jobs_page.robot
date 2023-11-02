*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/jobs_locators.py
Variables       ../locators/my_jobs_locators.py

*** Keywords ***
Search job by location and job name
    [Arguments]    ${job_name}      ${location_name}=None
    Go to My Jobs page
    IF  '${location_name}' != 'None'
        Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
        Input into     ${MY_JOB_ALL_LOCATION_SEARCH_FOR_LOCATION_TEXTBOX}   ${location_name}
        capture page screenshot
        Click at    ${MY_JOB_ALL_LOCATION_SEARCH_RESULT}    ${location_name}
        wait for page load successfully
    END
    Simulate input    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${job_name}
    #   Loading icon displays slowly, need to wait util it displays
    wait for page load successfully
    Check span display       ${job_name}
    Capture page screenshot

Select job filtering
    [Arguments]     ${status}
    Click at    ${MY_JOB_JOB_FILTERING_BUTTON}
    Click at    ${MY_JOB_JOB_FILTERING_JOB_STATUS_SPAN}
    Click at    ${MY_JOB_JOB_FILTERING_JOB_STATUS_OPTION}   ${status}

Unslect job filtering
    [Arguments]     ${status}
    Hover at    ${MY_JOB_JOB_FILTERING_BUTTON}
    Hover at    ${MY_JOB_JOB_FILTERING_JOB_STATUS_OPTION}   ${status}
    Click at    ${MY_JOB_JOB_FILTERING_JOB_STATUS_ICON_DELETE}

Turn on a Job
    [Arguments]     ${job_name}     ${location_name}=None
    Search job by location and job name     ${job_name}     ${location_name}
    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${job_name}
    Check span display       Are you sure you want to post this job?
    Check element display on screen     ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Post Job
    check element display on screen     ${MY_JOB_DETAIL_CANCEL_BUTTON}
    capture page screenshot
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Post Job
    Check element display on screen     ${job_name} has been posted!
    capture page screenshot

Turn off a Job
    [Arguments]     ${job_name}     ${location_name}=None
    Search job by location and job name     ${job_name}     ${location_name}
    Turn off     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}      ${job_name}
    Check element display on screen      Are you sure you want to close this job?
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Close Job
    check element display on screen     ${job_name} has been updated!
    capture page screenshot

Search job by location type
    [Arguments]     ${location_type}
    Reload page
    Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    Input into      ${MY_JOB_ALL_LOCATION_SEARCH_FOR_LOCATION_TEXTBOX}      ${location_type}
    Check span display      ${location_type}
    Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    capture page screenshot

Search job and get internal job link
    [Arguments]    ${job_name}      ${location_name}=None
    Search job by location and job name     ${job_name}     ${location_name}
    ${url}=     Get job apply link     ${job_name}
    [Return]    ${url}

Get job apply link
    [Arguments]     ${job_name}
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}   ${job_name}
    ${url}=     get element attribute       ${MY_JOB_DETAILS_COPY_JOB_APPLY_LINK}   url
    [Return]    ${CONFIG.site_url}${url}

Active a job
    [Arguments]     ${job_name}     ${location_name}=None
    Search job by location and job name     ${job_name}      ${location_name}
    ${status_job}=    run keyword and return status     Check toggle is off     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}    ${job_name}
    IF  '${status_job}' == 'True'
        ${cvo_modal}=   run keyword and return status       check span display      Set the number of candidates you need.
        IF  '${cvo_modal}' == 'True'
            Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
            Verify message after turn on/off job    ${job_name}
            wait for page load successfully
        ELSE
            Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}    ${job_name}
            Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
            Verify message after turn on/off job    ${job_name}
            wait for page load successfully
        END
    END

Deactivate a job
    [Arguments]     ${job_name}     ${location_name}=None
    Search job by location and job name     ${job_name}      ${location_name}
    ${status_job}=    run keyword and return status     Check toggle is on     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}    ${job_name}
    IF    '${status_job}' == 'True'
        Turn off   ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}    ${job_name}
        Click at   ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}   Close Job
        Verify message after turn on/off job    ${job_name}
        wait for page load successfully
    END

Turn on job and get internal job link
    [Arguments]     ${job_name}     ${location_name}=None
    Active a job    ${job_name}     ${location_name}
    ${url}=     Get job apply link      ${job_name}
    [Return]    ${url}

Verify message after turn on/off job
    [Arguments]     ${job_name}
    ${message}=     Format String   ${MY_JOB_TOAST_MESSAGE_UPDATE_JOB_MESSAGE}      ${job_name}     ${job_name}
    Element Should Be Visible     ${message}
    capture page screenshot

# --- OLD KEYWORDS SECTION ---
Get random job title
    ${random_number} =  Generate random number  10  70
    ${random_title} =  Set variable     Automation Tester 0${random_number}
    ${random_id} =  Set variable     PAT0${random_number}
    [Return]  ${random_title}   ${random_id}

Status of Job toggle at My Job is on
    [Arguments]    ${job_name}    ${location}
    search job in location    ${job_name}    ${location}
    ${job_status} =    Format String    ${JOB_FOR_ACTIVE_TOGGLE}    ${job_name}
    ${is_enable} =    Get toggle status    ${job_status}
    should be true    ${is_enable}

Status of Job toggle at My Job is off
    [Arguments]    ${job_name}    ${location}
    search job in location    ${job_name}    ${location}
    ${job_status} =    Format String    ${JOB_FOR_ACTIVE_TOGGLE}    ${job_name}
    ${is_disable} =    Get toggle status    ${job_status}
    Should not be true    ${is_disable}

Select job location
    [Arguments]    ${location}
    # wait a bit to get text
    wait with short time
    ${current_location} =   Get text and format text  ${JOB_LOCATION_TEXT}
    IF  '${current_location}' != '${location}'
        # Change location to correct location
        Click at    ${JOB_LOCATION_DROPDOWN}
        ${is_search_textbox_visible} =  Run keyword and return status   Check element display on screen  ${JOB_LOCATION_SEARCH_TEXT_BOX}  wait_time=2s
        Run keyword unless  ${is_search_textbox_visible}    Reload page
        Run keyword unless  ${is_search_textbox_visible}    Click at    ${JOB_LOCATION_DROPDOWN}
        Input into    ${JOB_LOCATION_SEARCH_TEXT_BOX}    ${location}
        Click at    ${JOB_LOCATION_VALUE}    ${location}
    END

search job in location
    [Arguments]    ${job_name}    ${location}
    Go to My Jobs page
    Select job location    ${location}
    ${current_location} =   Get text and format text  ${JOB_LOCATION_TEXT}
    IF  '${current_location}' != '${location}'
        Select job location    ${location}
    END
    Search expected job in location    ${job_name}
    Capture page screenshot
    ${number_of_job} =  Get Element Count   ${JOB_BLOCK}
    IF  '${number_of_job}' != '1'
        wait with short time
        wait_for_loading_icon_disappear
        Capture page screenshot
    END

Search expected job in location
    [Arguments]    ${job_name}
    Input into    ${MY_JOB_SEARCH_JOB_TEXTBOX}    ${job_name}
    wait_for_loading_icon_disappear

Search and select location of job
    [Arguments]    ${job_location}
    Click at    ${JOB_LOCATION_DROPDOWN}
    Input into    ${JOB_LOCATION_SEARCH_TEXT_BOX}    ${job_location}
    Click at    ${JOB_LOCATION_VALUE}    ${job_location}

Get all job
    Go to My Jobs page
    Scroll to bottom of table    ${MY_JOB_MAIN_SECTION}    ${LOADING_ICON_3}
    ${list_job}=    Get elements and convert to list    ${ALL_JOB_TITLE}
    [Return]    ${list_job}

Deactive job if active
    [Arguments]    ${job_name}
    ${is_on}=       run keyword and return status       Check element display on screen     ${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}       ${job_name}
    IF    '${is_on}' == 'True'
        Turn off a Job      ${job_name}
    END

Apply threshold for a job
    [Arguments]    ${job_name}    ${threshold}
    Search job by location and job name    ${job_name}
    Deactive job if active    ${job_name}
    Turn on    ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}    ${job_name}
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}    ${threshold}
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}    Post Job
    Verify display text     ${MY_JOB_DETAIL_CANDIDATE_NUMBER}       0 / ${threshold} Candidates       ${job_name}

Get job link from clipboard
    [Arguments]    ${job_name}
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}       ${job_name}
    Click at    ${MY_JOB_DETAILS_COPY_JOB_APPLY_LINK}
    ${public_link}=     Get clipboard text
    [Return]    ${public_link}
