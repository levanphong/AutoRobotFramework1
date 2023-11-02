*** Settings ***
Resource            ../../../pages/jobs_page.robot
Resource            ../../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          test

Documentation
#   COMPANY_FRANCHISE_ON:   Create Job family with name 'Cake family job'

*** Variables ***
${auto_job_name}                auto_job
${delete_modal_title}           Cannot Delete This Job
${new_job_description}          New Job Description
${archived_status}              Archived
${draft_status}                 Draft
${auto_candidate_journey}       Default Candidate Journey
${auto_multi_location}          Basic Multi-Location
@{option_list}                  Edit Job    Duplicate Job    Move to another Family    Delete Job
${content_move_job_modal}       The {} job is currently in the {} family. Select where you would like to move it to.
${delete_job_title}             Are you sure you want to delete the {} job?
${job_family_name_1}            Cake family job

*** Test Cases ***
Check when navigating to the job section setting in published job (OL-T8213, OL-T8214, OL-T8216)
    ${job_name}=    Login then create job at jobs page
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Check element display on screen     ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    wait for page load successfully v1
    Input into      ${INPUT_JOB_DESCRIPTION}    ${new_job_description}
    Click at    Save
    wait for page load successfully v1
    Search job then check eclipse popup item displayed and delete it    ${job_name}     ${job_family_name}      ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}


Check when navigating to the job section setting in draft job (OL-T8215)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Jobs page
    # create job, but not published
    ${job_name} =       Create new job without Job template     ${auto_multi_location}      ${auto_candidate_journey}       is_publish=False
    Search job then check eclipse popup item not displayed and delete it    ${job_name}     ${job_family_name}      ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}


Check when clicking on Archive in the ellipses, but there is one locations ON for that job in My Jobs (OL-T8217, OL-T8219, OL-T8220, OL-T8223, OL-T8224, OL-T8225, OL-T8226)
    ${job_name}=    Login then create job at jobs page
    Turn on a Job       ${job_name}     ${test_location_name}
    Search job then check Cannot Archive modal      ${job_name}     ${test_location_name}
    Check option in Cannot Archive Job modal    ${job_name}
    Turn off a Job      ${job_name}     ${test_location_name}
    Search job then check Archive Job modal     ${job_name}     ${test_location_name}
    Check option in Archive Job modal       ${job_name}
    Search then Archive Job     ${job_name}     ${test_location_name}
    Delete a Job    ${job_name}     ${job_family_name}


Check when clicking on Archive in the ellipses, but there are some locations ON for that job in My Jobs (OL-T8218, OL-T8221, OL-T8222)
    ${job_name}=    Login then create job at jobs page
    ${location_name}=       Create list     New York    Amsterdam
    Add new location for job template       ${job_name}     ${job_family_name}      ${location_name}
    Publish job
    Append To List      ${location_name}    ${test_location_name}
    Turn on a Job at multiple location      ${job_name}     ${location_name}
    Search job then check Cannot Archive modal      ${job_name}     ${location_name}
    Check option in Cannot Archive Job modal    ${job_name}
    Check element display on screen     ${MY_JOB_ALL_LOCATIONS_DROPDOWN_OPTION}     ${test_location_name}
    Turn off a job at multiple location     ${job_name}     ${location_name}
    Delete a Job    ${job_name}     ${job_family_name}


Check ellipses option in achived jobs (OL-T8227, OL-T8229)
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Check option in the ellipses    ${option_list}
    Add new job description     ${job_name}     ${job_family_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Check element display on screen     ${JOB_STATUS_ON_JOB_PAGE}       ${archived_status}
    Delete a Job    ${job_name}     ${job_family_name}


Check Archived Jobs section when switching to another location (OL-T8228)
    ${job_name}=    Login then create job at jobs page
    ${location_name}=       Create list     New York    Amsterdam
    Add new location for job template       ${job_name}     ${job_family_name}      ${location_name}[0]
    Publish job
    Append To List      ${location_name}    ${test_location_name}
    # Archive job
    Search then Archive Job     ${job_name}     ${test_location_name}
    Go to Jobs page
    # check information job at location C
    Filter Job following location then search it    ${job_name}     ${location_name}[1]
    Check element not display on screen     ${JOB_FAMILY_CHEVRON_DOWN_ICON}     ${job_family_name}
    Check element not display on screen     ${JOB_STATUS_ON_JOB_PAGE}       ${archived_status}
    # Turn off filter about location
    Click at    ${JOB_PAGE_FILTER_CLOSE_BUTTON}     ${location_name}[1]
    wait for page load successfully v1
    Delete a Job    ${job_name}     ${job_family_name}


Check when duplicating a job with an ‘Archived’ status (OL-T8230)
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    Search then Duplicate Job       ${job_name}
    Search job name     Copy - ${job_name}      ${job_family_name}
    Check element display on screen     ${JOB_STATUS_ON_JOB_PAGE}       ${draft_status}
    Filter Job following status then search it      Copy - ${job_name}      ${draft_status}     ${job_family_name}
    # Turn off filter about status
    Click at    ${JOB_PAGE_FILTER_CLOSE_BUTTON}     ${draft_status}
    wait for page load successfully v1
    Delete a Job    ${job_name}     ${job_family_name}
    Delete a Job    Copy - ${job_name}      ${job_family_name}


Check when clicking on Move to Another Family in an Archived status (OL-T8231, OL-T8232, QL-T8234, QL-T8235)
    # The "Move Button" is disabled, not enabled.
    # TODO https://paradoxai.atlassian.net/browse/OL-75808
    [Tags]      skip
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    # open modal
    Open Move to Another Family modal       ${job_name}     ${job_family_name}
    Check Move to another Family modal      ${job_name}     ${job_family_name}
    # close dropdown
    Click at    ${MOVE_FAMILY_MODAL_FAMILY_DROPDOWN}
    # check cancel button
    Click at    ${CONFIRM_CANCEL_JOB_BUTTON_POPUP}
    Check element not display on screen     ${MOVE_FAMILY_MODAL_TITLE}
    # show modal
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_MOVE_JOB_BUTTON}
    wait for page load successfully v1
    # check close icon
    Click at    ${MOVE_FAMILY_MODAL_JOB_FAMILY_CLOSE_ICON}
    Check element not display on screen     ${MOVE_FAMILY_MODAL_TITLE}
    Delete a Job    ${job_name}     ${job_family_name}


Check when selecting another Job Family in Move to Another Family modal (OL-T8233)
    Given Setup test
    # create job and archived job
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    # search job and move to Job Family other
    Move Job to Another Family Job      ${job_name}     ${job_family_name}      ${job_family_name_1}
    # Check job in new job family
    Search job name     ${job_name}     ${job_family_name_1}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    # Check status in Jobs Page
    Check element display on screen     ${JOB_STATUS_ON_JOB_PAGE}       ${archived_status}
    Delete a Job    ${job_name}     ${job_family_name_1}


Check Move to Another Family modal of Job in Published/Unpublished changes/draft status (OL-T8236)
    Given Setup test
    ${job_name}=    Login then create job at jobs page
    Open Move to Another Family modal       ${job_name}     ${job_family_name}
    # check text in modal
    Check element display on screen     Note: All archived jobs will be moved to the bottom of the page.
    Click at    ${MOVE_FAMILY_MODAL_FAMILY_DROPDOWN}
    Check element display on screen     ${MOVE_FAMILY_MODAL_JOB_FAMILY_ITEMS_DISABLE_LABEL}     ${job_family_name}
    # Move to new job family
    Click at    ${MOVE_FAMILY_MODAL_JOB_FAMILY_ITEMS_ENABLE_LABEL}      ${job_family_name_1}
    Verify element is enable    ${CONFIRM_MOVE_JOB_BUTTON_POPUP}
    Click at    ${CONFIRM_MOVE_JOB_BUTTON_POPUP}
    Check Job is removed from current Job family    ${job_name}     ${job_family_name}
    # Check job in new job family
    Search job name     ${job_name}     ${job_family_name_1}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    # Check status in Jobs Page
    Check element not display on screen     ${JOB_STATUS_ON_JOB_PAGE}       ${archived_status}
    Delete a Job    ${job_name}     ${job_family_name_1}


Check when move all Archived jobs in 1 Job family (OL-T8237)
    ${job_name_1}=      Login then create job at jobs page
    ${job_name_2} =     Create new job without Job template     ${auto_multi_location}      ${auto_candidate_journey}
    wait element visible    ${STATUS_PUBLISHED}
    Search then Archive Job     ${job_name_1}       ${test_location_name}
    Search then Archive Job     ${job_name_2}       ${test_location_name}
    Move Job to Another Family Job      ${job_name_1}       ${job_family_name}      ${job_family_name_1}
    Move Job to Another Family Job      ${job_name_2}       ${job_family_name}      ${job_family_name_1}
    Search job name     ${job_name_1}       ${job_family_name_1}
    Search job name     ${job_name_2}       ${job_family_name_1}
    Delete a Job    ${job_name_1}       ${job_family_name_1}
    Delete a Job    ${job_name_2}       ${job_family_name_1}


Check when clicking on Delete in the eclipses of any job (Published/unpublished/draft), but there are one or more locations ON for that job in My Jobs (OL-T8238, OL-T8239, OL-T8240, OL-T8241)
    ${job_name}=    Login then create job at jobs page
    ${location_name}=       Create list     New York
    Add new location for job template       ${job_name}     ${job_family_name}      New York
    Publish job
    Append To List      ${location_name}    ${test_location_name}
    Turn on a Job at multiple location      ${job_name}     ${location_name}
    Open Delete modal in eclipse option     ${job_name}     ${job_family_name}
    Check Delete modal in eclipse option    ${location_name}
    Check option in Delete modal    ${job_name}
    Turn off a job at multiple location     ${job_name}     ${location_name}
    Delete a Job    ${job_name}     ${job_family_name}


Check when clicking on Delete in the ellipses of any job (Published/unpublished/draft), all locations to that job are turned off in my jobs (OL-T8242, OL-T8243, OL-T8244, OL-T8245)
    ${job_name}=    Login then create job at jobs page
    Open Delete modal in eclipse option     ${job_name}     ${job_family_name}
    ${content}=     Format String       ${delete_job_title}     ${job_name}
    ${message_content}=     Get text and format text    ${DELETE_JOB_MODAL_BOX_MESSAGE}
    should be equal as strings      ${content}      ${message_content}
    # check cancel button
    Click at    ${DELETE_JOB_MODAL_CANCEL_BUTTON}
    Check element not display on screen     ${DELETE_JOB_MODAL}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    # Check close button
    Click at    ${DELETE_JOB_MODAL_CLOSE_BUTTON}    Delete Job
    Check element not display on screen     ${DELETE_JOB_MODAL}
    # check delete button
    Delete a Job    ${job_name}     ${job_family_name}


Check when clicking on Delete in the ellipses of Archiveed jobs (OL-T8246)
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    Open Delete modal in eclipse option     ${job_name}     ${job_family_name}
    ${content}=     Format String       ${delete_job_title}     ${job_name}
    ${message_content}=     Get text and format text    ${DELETE_JOB_MODAL_BOX_MESSAGE}
    should be equal as strings      ${content}      ${message_content}
    Click at    ${DELETE_JOB_MODAL_CANCEL_BUTTON}
    Delete a Job    ${job_name}     ${job_family_name}


Check when delete all Archived jobs in 1 Job family (OL-T8247)
    ${job_name_1}=      Login then create job at jobs page
    ${job_name_2} =     Create new job without Job template     ${auto_multi_location}      ${auto_candidate_journey}
    wait element visible    ${STATUS_PUBLISHED}
    Search then Archive Job     ${job_name_1}       ${test_location_name}
    Search then Archive Job     ${job_name_2}       ${test_location_name}
    Delete a Job    ${job_name_1}       ${job_family_name}
    Delete a Job    ${job_name_2}       ${job_family_name}
    Check job does not exist in job filter status       ${job_name_1}       ${archived_status}      ${job_family_name}
    Click at    ${JOB_PAGE_FILTER_CLOSE_BUTTON}     ${archived_status}
    Check job does not exist in job filter status       ${job_name_2}       ${archived_status}      ${job_family_name}


Check when republishing Archived jobs (OL-T8248)
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    Open Edit Job in eclipse option     ${job_name}     ${job_family_name}
    Publish job
    Check job does not exist in job filter status       ${job_name}     ${archived_status}      ${job_family_name}
    # Check toggle in my jobs page
    Search job by location and job name     ${job_name}     ${test_location_name}
    Check element display on screen     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${job_name}
    Delete a Job    ${job_name}     ${job_family_name}


Check Content of published job include all saved edits made since job was archived (OL-T8249)
    ${job_name}=    Login then create job at jobs page
    Search then Archive Job     ${job_name}     ${test_location_name}
    Add new job description     ${job_name}     ${job_family_name}
    Publish job
    Reload page
    ${content}=     Get text and format text    ${INPUT_JOB_DESCRIPTION}
    should be equal as strings      ${content}      ${new_job_description}
    Delete a Job    ${job_name}     ${job_family_name}


Check when republishing all Archived jobs in 1 Job family (OL-T8250)
    ${job_name_1}=      Login then create job at jobs page
    ${job_name_2} =     Create new job without Job template     ${auto_multi_location}      ${auto_candidate_journey}
    wait element visible    ${STATUS_PUBLISHED}
    Search then Archive Job     ${job_name_1}       ${test_location_name}
    Search then Archive Job     ${job_name_2}       ${test_location_name}
    Open Edit Job in eclipse option     ${job_name_1}       ${job_family_name}
    Publish job
    Open Edit Job in eclipse option     ${job_name_2}       ${job_family_name}
    Publish job
    Go to Jobs page
    Check job does not exist in job filter status       ${job_name_1}       ${archived_status}      ${job_family_name}
    Click at    ${JOB_PAGE_FILTER_CLOSE_BUTTON}     ${archived_status}
    Check job does not exist in job filter status       ${job_name_2}       ${archived_status}      ${job_family_name}
    Click at    ${JOB_PAGE_FILTER_CLOSE_BUTTON}     ${archived_status}
    Delete a Job    ${job_name_2}       ${job_family_name}
    Delete a Job    ${job_name_1}       ${job_family_name}

*** Keywords ***
Login then create job at jobs page
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${job_name} =       Create new job without Job template     ${auto_multi_location}    ${auto_candidate_journey}
    wait element visible    ${STATUS_PUBLISHED}
    [Return]        ${job_name}

Check job does not exist in job filter status
    [Arguments]     ${job_name}     ${status}     ${job_family_name}
    ${is_existed} =     Run keyword and return status       Filter Job following status then search it      ${job_name}      ${status}     ${job_family_name}
    Should Be Equal As Strings    ${is_existed}    False

Check Move to another Family modal
    [Arguments]     ${job_name}     ${job_family_name}
    Check element display on screen      ${MOVE_FAMILY_MODAL_TITLE}
    ${modal_content}=   Format String    ${content_move_job_modal}      ${job_name}         ${job_family_name}
    ${content}=     Get text and format text    ${MOVE_FAMILY_MODAL_CONTENT}
    should be equal as strings    ${modal_content}    ${content}
    Check element display on screen      ${MOVE_FAMILY_MODAL_LABEL}     New Job Family
    Check element display on screen      Note: All archived jobs will be moved to the bottom of the page.
    Click at        ${MOVE_FAMILY_MODAL_FAMILY_DROPDOWN}
    Check element display on screen       ${MOVE_FAMILY_MODAL_JOB_FAMILY_ITEMS_DISABLE_LABEL}     ${job_family_name}
    Verify element is disable       ${CONFIRM_MOVE_JOB_BUTTON_POPUP}
    Verify element is enable        ${CONFIRM_CANCEL_JOB_BUTTON_POPUP}

Check Job is removed from current Job family
    [Arguments]     ${job_name}     ${job_family_name}
    ${is_has_job} =     Run keyword and return status         Search job name     ${job_name}     ${job_family_name}
    Should Be Equal As Strings    ${is_has_job}    False

Open Move to Another Family modal
    [Arguments]     ${job_name}     ${job_family_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_MOVE_JOB_BUTTON}
    wait for page load successfully v1

Open Edit Job in eclipse option
    [Arguments]     ${job_name}     ${job_family_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    wait for page load successfully v1

Open Delete modal in eclipse option
    [Arguments]     ${job_name}     ${job_family_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    wait for page load successfully v1

Check Delete modal in eclipse option
    [Arguments]     ${location_name}
    Check element display on screen      ${DELETE_JOB_MODAL_TITLE}     ${delete_modal_title}
    Check element display on screen      You must turn off all locations for this job in My Jobs before you can delete it.
    ${type} =   evaluate    type($location_name).__name__
    IF  '${type}' == 'list'
        Check element display on screen     The following locations are ON:
        FOR     ${item}     IN      @{location_name}
            Check element display on screen      ${item}
        END
    ELSE
        Check element display on screen     The following location is ON:
        Check element display on screen     ${location_name}
    END
    Check element display on screen        ${DELETE_JOB_MODAL_CLOSE_BUTTON}       ${delete_modal_title}
    Check element display on screen        ${DELETE_JOB_MODAL_GO_TO_MY_JOBS_BUTTON}
    Check element display on screen        ${DELETE_JOB_MODAL_CANCEL_BUTTON}

Check option in Delete modal
    [Arguments]     ${job_name}
    # Check close button
    Click at    ${DELETE_JOB_MODAL_CLOSE_BUTTON}       ${delete_modal_title}
    Check element not display on screen     ${CANNOT_DELETE_JOB_MODAL}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    # Check cancel button
    Click at    ${DELETE_JOB_MODAL_CANCEL_BUTTON}
    Check element not display on screen     ${CANNOT_DELETE_JOB_MODAL}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    # Check Go to My Jobs button
    Click at    ${DELETE_JOB_MODAL_GO_TO_MY_JOBS_BUTTON}
    wait for page load successfully v1
    Title Should Be     My Jobs | Candidate Experience Manager

Move Job to Another Family Job
    [Arguments]     ${job_name}     ${job_family_name}     ${new_job_family}
    Open Move to Another Family modal   ${job_name}     ${job_family_name}
    Click at    ${MOVE_FAMILY_MODAL_FAMILY_DROPDOWN}
    Check element display on screen     ${MOVE_FAMILY_MODAL_JOB_FAMILY_ITEMS_DISABLE_LABEL}     ${job_family_name}
    # Move to new job family
    Click at    ${MOVE_FAMILY_MODAL_JOB_FAMILY_ITEMS_ENABLE_LABEL}      ${new_job_family}
    Verify element is enable    ${CONFIRM_MOVE_JOB_BUTTON_POPUP}
    Click at    ${CONFIRM_MOVE_JOB_BUTTON_POPUP}
    Check Job is removed from current Job family        ${job_name}     ${job_family_name}

Search job then check eclipse popup item displayed and delete it
    [Arguments]     ${job_name}     ${job_family_name}      ${locator}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Check element display on screen     ${locator}
    Click by js     ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    Click at    ${COMMON_TEXT_LAST}     Delete
    Check element display on screen     ${TOASTED_MESSAGE_SUCCESS}

Search job then check eclipse popup item not displayed and delete it
    [Arguments]     ${job_name}     ${job_family_name}      ${locator}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Check element not display on screen     ${locator}
    Click by js     ${JOB_ECLIPSE_POPUP_DELETE_BUTTON}
    Click at    ${COMMON_TEXT_LAST}     Delete
    Check element display on screen     ${TOASTED_MESSAGE_SUCCESS}

Add new location for job template
    [Arguments]     ${job_name}     ${job_family_name}      ${new_location}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    wait for page load successfully v1
    Click at    ${EDIT_LOCATION_BUTTON}
    ${type} =   evaluate    type($new_location).__name__
    Click at    ${ADD_LOCATION_BUTTON}
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{new_location}
            Input Into  ${ADD_JOB_LOCATION_SEARCH_TEXT_BOX}     ${item}
            Click at    ${LOCATION_ON_ADD_LOCATION_POPUP}       ${item}
        END
    ELSE
        Input Into  ${ADD_JOB_LOCATION_SEARCH_TEXT_BOX}     ${new_location}
        Click at    ${LOCATION_ON_ADD_LOCATION_POPUP}       ${new_location}
    END
    Click at    ${APPLY_BUTTON}
    Click at    ${SAVE_BUTTON_LOCATION}
    Click at    ${SAVE_JOB_BUTTON}
    wait for page load successfully v1
    #   Check if adding location is successful
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{new_location}
            Check element display on screen    ${AVAILABLE_LOCATION_BY_NAME}   ${item}
        END
    ELSE
        Check element display on screen    ${AVAILABLE_LOCATION_BY_NAME}   ${new_location}
    END

Turn on a Job at multiple location
    [Arguments]     ${job_name}     ${location_name}
    ${type} =   evaluate    type($location_name).__name__
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{location_name}
            Turn on a Job    ${job_name}     ${item}
        END
    ELSE
        Turn on a Job    ${job_name}     ${location_name}
    END

Turn off a job at multiple location
    [Arguments]     ${job_name}     ${location_name}
    ${type} =   evaluate    type($location_name).__name__
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{location_name}
            Turn off a Job      ${job_name}      ${item}
        END
    ELSE
        Turn off a Job      ${job_name}      ${location_name}
    END

Search job then check Cannot Archive modal
    [Arguments]     ${job_name}     ${location_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    Check element display on screen     Cannot Archive This Job
    Check element display on screen     You must turn off all locations for this job in My Jobs before you can archive it
    ${type} =   evaluate    type($location_name).__name__
    IF  '${type}' == 'list'
        Check element display on screen     The following locations are ON:
        FOR     ${item}     IN      @{location_name}
            Check element display on screen      ${item}
        END
    ELSE
        Check element display on screen     ${location_name}
        Check element display on screen     The following location is ON:
    END

Check option in Cannot Archive Job modal
    [Arguments]     ${job_name}
    # Check close button
    Click at    ${ARCHIVE_JOB_MODAL_CLOSE_BUTTON}       Cannot Archive This Job
    Check element not display on screen     ${CANNOT_ARCHIVE_JOB_MODAL}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    # Check cancel button
    Click at    ${CANCEL_BUTTON_MODAL_MY_JOB}
    Check element not display on screen     ${CANNOT_ARCHIVE_JOB_MODAL}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    # Check Go to My Jobs button
    Click at    ${ARCHIVE_JOB_MODAL_GO_TO_MY_JOBS_BUTTON}
    wait for page load successfully v1
    Title Should Be     My Jobs | Candidate Experience Manager

Search job then check Archive Job modal
    [Arguments]     ${job_name}     ${location_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    Check element display on screen     ${ARCHIVE_JOB_MODAL_TITLE}
    Check element display on screen     Are you sure you want to archive this job?
    Check element display on screen     Archiving will remove this job from My Jobs but remain on Jobs page for users to re-publish at any time.
    Check element display on screen     Note: All Archived jobs will be moved to the bottom on the job family
    Check element display on screen     ${ARCHIVE_JOB_MODAL_CLOSE_BUTTON}       Archive Job
    Check element display on screen     ${ARCHIVE_JOB_MODAL_OPTION}     Cancel
    Check element display on screen     ${ARCHIVE_JOB_MODAL_OPTION}     Archive

Check option in Archive Job modal
    [Arguments]     ${job_name}
    # Check close button
    Click at    ${ARCHIVE_JOB_MODAL_CLOSE_BUTTON}       Archive Job
    Check element not display on screen     ${ARCHIVE_JOB_MODAL}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    # Check cancel button
    Click at    ${ARCHIVE_JOB_MODAL_OPTION}     Cancel
    Check element not display on screen     ${ARCHIVE_JOB_MODAL}

Search then Archive Job
    [Arguments]     ${job_name}     ${location_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_ARCHIVE_JOB_BUTTON}
    Click at    ${ARCHIVE_JOB_MODAL_OPTION}     Archive
    # Check status in Jobs Page
    Check element display on screen     ${JOB_STATUS_ON_JOB_PAGE}    ${archived_status}
    Filter Job following status then search it      ${job_name}       ${archived_status}    ${job_family_name}
    # Check status in My Jobs Page
    Go to My Jobs page
    ${is_existed} =    Run Keyword and Return Status     Search job by location and job name     ${job_name}     ${location_name}
    Should Be Equal As Strings    ${is_existed}    False

Search then Duplicate Job
    [Arguments]     ${job_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_DUPLICATE_JOB_BUTTON}
    wait for page load successfully v1

Filter Job following status then search it
    [Arguments]     ${job_name}       ${job_status}     ${job_family_name}
    Click at    ${JOB_PAGE_FILTER_BUTTON}
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      Job Status
    Click at    ${JOB_PAGE_FILTER_ITEMS_STATUS}     ${job_status}
    Click at    ${APPLY_BTN_DETAILS}
    wait for page load successfully v1
    simulate input    ${JOB_PAGE_FILTER_SEARCH_JOB_TEXTBOX}    ${job_name}
    wait for page load successfully v1
    Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}   slow_down=3s
    wait for page load successfully v1
    Check element display on screen     ${JOB_STATUS_ON_JOB_PAGE}    ${job_status}

Check option in the ellipses
    [Arguments]      ${option_list}
    ${type} =   evaluate    type($option_list).__name__
    IF  '${type}' == 'list'
        FOR     ${item}     IN      @{option_list}
            Check element display on screen      ${JOB_PAGE_ECLIPSE_OPTION}    ${item}
        END
    ELSE
        Check element display on screen      ${JOB_PAGE_ECLIPSE_OPTION}     ${option_list}
    END

Add new job description
    [Arguments]     ${job_name}     ${job_family_name}
    Go to Jobs page
    Search job name     ${job_name}     ${job_family_name}
    Click at    ${JOB_ECLIPSE_ICON}     ${job_name}
    Click at    ${JOB_ECLIPSE_POPUP_EDIT_BUTTON}
    wait for page load successfully v1
    Input into      ${INPUT_JOB_DESCRIPTION}    ${new_job_description}
    Click at    Save

Filter Job following location then search it
    [Arguments]     ${job_name}     ${location_name}
    Click at    ${JOB_PAGE_FILTER_BUTTON}
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      Location
    Click at    ${JOB_PAGE_FILTER_ITEMS_LOCATION}     ${location_name}
    Click at    ${APPLY_BTN_DETAILS}
    wait for page load successfully v1
    simulate input    ${JOB_PAGE_FILTER_SEARCH_JOB_TEXTBOX}    ${job_name}
    wait for page load successfully v1
