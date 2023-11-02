*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../location_attributes/customize_gdpr_tests.robot
Resource            ../job_external/client_jobs/cvo/my_jobs_page/cvo_flow.resource
Variables           ../../constants/MyJobConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Setup for every Test case
Force Tags          lts_stg    regression
Documentation       Run datatest for first time:
...                 Manual before:
...                 -Turn on CVO on hire on company
...                 -In company "Test Automation Hire On Company":
...                 + Create new brand name: "New brand test"
...                 + Create area: My job area
...                 + Create location: My job location (address: US,state: Hawaii, Cty: Hilo, location ID: myjoblocation)
...                 Then run auto:
...                 - robot src/data_tests/job_internal/my_job_redesign_datatest.robot
...                 Then manual:
...                 - Create landing site "My Job - job search landing site" and assign converation "My job converation"
...                 - Update job created in Data package off company and public
...                 - Update "My job has data package" add Detail "My job data package A" to "Idle location A", add Detail "My job data package B" to "Idle location B"
...                 - Create new location "Location not in data package" in "Data package area"
...                 - Create posting site and assign conversation "My job converation" in Hire on company

*** Variables ***
${job_location_1}                   ${LOCATION_NAME_1}
${job_location_2}                   ${LOCATION_NAME_2}
${job_location_3}                   ${LOCATION_NAME_3}
# CVO
${number_of_candidate}=             100
${threshold}=                       2
# data package
${package_must_assigned_error}=     The {} job must have a job data package assigned to the {} location before it can be turned on. You can assign this on the Jobs page.

*** Test Cases ***
Verify permission view my job at each location of user (OL-T30588)
    # Bug: https://paradoxai.atlassian.net/browse/OL-73360
    ${job_name_1} =     Generate random name    auto_job
    ${job_name_2} =     Generate random name    auto_job
    ${job_name_3} =     Generate random name    auto_job
    # Company has 3 locations
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Users, Roles, Permissions page
    ${user_name} =      Add a user      role=${HM}
    # User only has permission on Location 1
    Go to Location Management page
    Assign user to location     ${job_location_1}       ${user_name}
    # Create a job in Location 1, with user in Hiring Team
    Create a custom New Job and Publish     ${job_name_1}       ${job_family_name}      ${job_location_1}       hiring_team_name=${user_name}
    # Create a job in Location 2, with Hiring Manager Role in Hiring Team
    Create a custom New Job and Publish     ${job_name_2}       ${job_family_name}      ${job_location_2}       hiring_team_name=${HM}
    # Create a job in Location 3, without user or Hiring Manager Role in Hiring Team
    Create a custom New Job and Publish     ${job_name_3}       ${job_family_name}      ${job_location_3}       hiring_team_name=${CP_ADMIN}
    Go to My Jobs page
    # Check user only see Job 1 in Location 1, Job 2 and Job 3 are not display
    Search and select location of job       ${job_location_1}
    Search expected job in location     ${job_name_1}
    Check element display on screen     ${job_name_1}
    Capture Page Screenshot
    Search expected job in location     ${job_name_2}
    Check element not display on screen     ${job_name_2}
    Capture Page Screenshot
    Search expected job in location     ${job_name_3}
    Check element not display on screen     ${job_name_3}
    Capture Page Screenshot
    # Check user can see Job 1 and Job 2 in All Locations, and Job 3 must be not display
    Search and select location of job       All Locations
    Search expected job in location     ${job_name_1}
    Check element display on screen     ${job_name_1}
    Capture Page Screenshot
    Search expected job in location     ${job_name_2}
    Check element display on screen     ${job_name_2}
    Capture Page Screenshot
    Search expected job in location     ${job_name_2}
    Check element not display on screen     ${job_name_3}
    Capture Page Screenshot
    # Delete job after run test case
    Delete a Job    ${job_name_1}       ${job_family_name}
    Delete a Job    ${job_name_2}       ${job_family_name}
    Delete a Job    ${job_name_3}       ${job_family_name}


Paradox Job - Check My jobs with Empty state (OL-T28740)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs is ON
...    -No Job is published
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Switch to user      ${EMPTY_JOB_USER}
    Go to My Jobs page
    Check element display on screen     There are no jobs available currently.


Paradox Job - Check My jobs page is changed and show correctly (OL-T28741)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Client setup > Hire > Enable Internal and External Job Types is ON
...    -Client setup > Account Overview > Multi-Branding is ON
...    -Company Information > Brand Management: Add some brands
...    -Create some Jobs, assign with brand and select job type > Publish job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to My Jobs page
    Search expected job in location     ${MY_JOB_TEST_NAME}
    Check span display      ${MY_JOB_TEST_NAME}
    Check element display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_CITY}      ${MY_JOB_TEST_LOCATION}
    Check element display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_POSTING_TYPE}      ${JOB_POSTING_TYPE_EXTERNAL}
    Remove dot and check contains       ${MY_JOB_TEST_ID['${env}']}     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_JOB_ID}
    Check element display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_BRAND}     ${MY_JOB_TEST_BRAND}


Paradox Job - Check My jobs page If Enable Internal and External Job Types is OFF and Check My jobs page If Multi-branding is OFF (OL-T28742, OL-T28743)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Client setup > Hire > Enable Internal and External Job Types is OFF
...    Client setup > Account Overview > Multi-Branding is OFF
...    -Create some Jobs > Publish job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF_JOB_ON}
    Go to My Jobs page
    Search expected job in location     ${MY_JOB_TEST_NAME}
    Check element not display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_POSTING_TYPE}      ${EMPTY}
    # Paradox Job - Check My jobs page If Multi-branding is OFF OL-T28743
    Check element not display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_BRAND}


Paradox Job - Search function works correctly (OL-T28744)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Client setup > Hire > Enable Internal and External Job Types is ON
...    -Client setup > Account Overview > Multi-Branding is ON
...    -Company Information > Brand Management: Add some brands
...    -Create some Jobs, assign with brand and select job type > Publish job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to My Jobs page
    # Check Show correct result job which have title jobs include the text search
    Search by attribute     ${MY_JOB_TEST_NAME}
    # Check Show correct result job which have Requisition ID include the text search
    Search by attribute     ${MY_JOB_TEST_ID['${env}']}
    # check Show correct result job which have Job Posting Type include the text search
    Search by attribute     ${JOB_POSTING_TYPE_EXTERNAL}
    Check element not display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_POSTING_TYPE}      ${JOB_POSTING_TYPE_INTERNAL}
    Check element not display on screen     ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_POSTING_TYPE}      ${JOB_POSTING_TYPE_INTERNAL_AND_EXTERNAL}
    # check Show correct result job which have Location name include the text search
    Search by attribute     ${MY_JOB_TEST_LOCATION}
    # check Show correct result job which have Brand include the text search
    Search by attribute     ${MY_JOB_TEST_BRAND}


Paradox Job - Verify viewing Jobs by specific location (OL-T28745)
    [Tags]      skip
    # TODO bug https://paradoxai.atlassian.net/browse/OL-78350
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Client setup > Hire > Enable Internal and External Job Types is ON
...    -Client setup > Account Overview > Multi-Branding is ON
...    -Company Information > Brand Management: Add some brands
...    -Create some Jobs, assign with brand and select job type > Publish job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${locations}=       Get all location name
    Go to My Jobs page
    Click at    ${MY_JOB_ALL_LOCATIONS_DROPDOWN}
    # Check Show all Location corresponding area
    Check display all location      ${locations}
    Check display correct area and location
    # Check Show Area name match with text and locations under area
    Search and Check display correct area and location      ${MY_JOB_TEST_AREA}
    # Check Show Locations have name match with text
    Search and Check display correct area and location      ${MY_JOB_TEST_LOCATION}
    # check Show Locations have address match with text
    Search and Check display correct area and location      ${LOCATION_NAME_US}
    # check Show Locations have City match with text
    Search and Check display correct area and location      ${LOCATION_CITY_HILO}
    # Check Show Locations have State match with text
    Search and Check display correct area and location      ${LOCATION_STATE_HAWAII}
    # check Show Locations have ID match with text
    Search and Check display correct area and location      ${MY_JOB_TEST_LOCATION_ID}
    # Select a location (A)
    Click at    ${JOB_LOCATION_VALUE}       ${MY_JOB_TEST_LOCATION}
    # Check The location is selected, Show jobs in selected location, Placeholder is replaced by location name
    Check element display on screen     ${MY_JOB_ALL_LOCATIONS_DROPDOWN_PLACEHOLDER}    ${MY_JOB_TEST_LOCATION}
    Check span display      ${MY_JOB_TEST_NAME}


Paradox Job - Verify Filtering My Jobs List (OL-T28746)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Client setup > Hire > Enable Internal and External Job Types is ON
...    -Client setup > Account Overview > Multi-Branding is ON
...    -Company Information > Brand Management: Add some brands
...    -Create some Jobs, assign with brand and select job type > Publish job
...    -My job: ON some jobs
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to My Jobs page
    Get list job and check status       ON
    Get list job and check status       OFF


Paradox Job - Check Turning Job ON without Shift, without CVO (OL-T28747, OL-T28750)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create some Jobs, assign with brand and select job type > Publish job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Search job by location and job name     ${MY_JOB_TEST_NAME}
    Deactive job if active      ${MY_JOB_TEST_NAME}
    Turn on a Job       ${MY_JOB_TEST_NAME}


Paradox Job - Check Turning Job On with Shift (OL-T28748, OL-T28749)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create some Jobs, assign with brand and select job type > Publish job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Search job by location and job name     ${MY_JOB_HAS_SHIFT_NAME}
    Deactive job if active      ${MY_JOB_HAS_SHIFT_NAME}
    Turn on a Job with shift    ${MY_JOB_HAS_SHIFT_NAME}
    ${number_of_shift}=     Get Length      ${MY_JOB_HAS_LIST_SHIFT}
    Check element display on screen     ${MY_JOB_ITEM_TOOLTIP_NUMBER_OF_SHIFT}      ${number_of_shift}


Paradox Job - Check Turning Job ON and OFF with CVO (OL-T28751, OL-T28752)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create some Jobs, assign with brand and select job type > Publish job
...    -Create Job, Turn on at My Job    select some shifts
...    -Candidate Volume Optimizer:Add Targeting rule
...    +Details & Targeting: Job title contains Crew Manager
...    +Status Thresholds:Capture Complete > Action:Olivia will Turn the Job Off
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Search job by location and job name     ${MY_JOB_CVO_JOB_NAME}
    Deactive job if active      ${MY_JOB_CVO_JOB_NAME}
    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${MY_JOB_CVO_JOB_NAME}
    # Click on the Post job button without inputing the threshold value
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
    Check text display      ${MY_JOB_CVO_REQUIRE_MESSAGE}
    # input >1000
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      1001
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
    Check text display      ${MY_JOB_CVO_BETWEEN_MESSAGE}
    # input <1
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      0
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
    Check text display      ${MY_JOB_CVO_BETWEEN_MESSAGE}
    # 1 <= input <= 1000
    Input into      ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}      ${number_of_candidate}
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}       Post Job
    Verify display text     ${MY_JOB_DETAIL_CANDIDATE_NUMBER}       0 / ${number_of_candidate} Candidates       ${MY_JOB_CVO_JOB_NAME}
    # Paradox Job - Check Turning Job OFF with CVO OL-T28752
    Turn off a Job      ${MY_JOB_CVO_JOB_NAME}


Paradox Job - Check Job is turned off by CVO when candidates apply the job and match threshold (OL-T28753)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create some Jobs, assign with brand and select job type > Publish job
...    -Create Job, Turn on at My Job with threshold number
...    -Candidate Volume Optimizer:Add Targeting rule
...    +Details & Targeting: Job title contains Crew Manager
...    +Status Thresholds:Capture Complete > Action:Olivia will Turn the Job Off
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Apply threshold for a job       ${MY_JOB_REACH_THRESHOLD_JOB_NAME}      ${threshold}
    Go to CEM page
    Add a Candidate     job_name=${MY_JOB_REACH_THRESHOLD_JOB_NAME}     location_name=${LOCATION_NAME_1}
    Add a Candidate     job_name=${MY_JOB_REACH_THRESHOLD_JOB_NAME}     location_name=${LOCATION_NAME_1}
    Check Hiring Manager is turn off when met threshold     ${LOCATION_NAME_1}      ${MY_JOB_REACH_THRESHOLD_JOB_NAME}      ${CAPTURE_COMPLETE_STATUS}      candidate_number=2
    Search job by location and job name     ${MY_JOB_REACH_THRESHOLD_JOB_NAME}
    Click at    ${JOB_THRESHOLDS_CLOSE_ICON}
    Check element not display on screen     ${JOB_THRESHOLDS_NOTIFY}
    Reload Page
    Search job by location and job name     ${MY_JOB_REACH_THRESHOLD_JOB_NAME}
    Verify display text     ${JOB_THRESHOLDS_NOTIFY}    Job closed because ${threshold} candidates reached ${CAPTURE_COMPLETE_STATUS}.


Paradox Job - Check user is received a notification by CVO when candidates apply the job and match threshold (OL-T28754)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create some Jobs, assign with brand and select job type > Publish job
...    -Create Job, Turn on at My Job with threshold number
...    -Candidate Volume Optimizer:Add Targeting rule
...    +Details & Targeting: Job title contains Crew Manager
...    +Status Thresholds:Capture Complete > Action:Olivia Will Notify the Hiring Team
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Apply threshold for a job       ${MY_JOB_NOTIFY_JOB_NAME}       ${threshold}
    Go to CEM page
    Add a Candidate     job_name=${MY_JOB_NOTIFY_JOB_NAME}      location_name=${LOCATION_NAME_1}
    Add a Candidate     job_name=${MY_JOB_NOTIFY_JOB_NAME}      location_name=${LOCATION_NAME_1}
    Check Hiring Manager is noticed when matched threshold      ${LOCATION_NAME_1}      ${MY_JOB_NOTIFY_JOB_NAME}       ${CAPTURE_COMPLETE_STATUS}      candidate_number=2
    Search job by location and job name     ${MY_JOB_REACH_THRESHOLD_JOB_NAME}
    Click at    ${JOB_THRESHOLDS_CLOSE_ICON}
    Check element not display on screen     ${JOB_THRESHOLDS_NOTIFY}
    Reload Page
    Search job by location and job name     ${MY_JOB_REACH_THRESHOLD_JOB_NAME}
    Check element not display on screen     ${NOTIFICATION_CHILD_ITEM}      ${MY_JOB_REACH_THRESHOLD_JOB_NAME}: Threshold is reached, please turn the job off manually


Paradox Job - Check Job Settings Metadata Display on the My jobs (OL-T28757)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Client setup > Hire > Enable Internal and External Job Types is ON
...    -Client setup > Account Overview > Multi-Branding is ON
...    -Client setup > Hire > Candidate Volume Optimizer is ON
...    -Company Information > Brand Management: Add some brands
...    -Create some Crew member Jobs, assign with brand and select job type, select some shifts > publish
...    -Candidate Volume Optimizer:Add Targeting rule
...    +Details & Targeting: Job title contains Crew Manager
...    +Status Thresholds:Capture Complete >Threshold number=2> Action:Olivia will Turn the Job Off
...    -My Job: Turn On Crew member Job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Search job by location and job name     ${MY_JOB_HAS_CVO_AND_SHIFT_JOB_NAME}
    Hover at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_CITY}      ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check element display on screen     ${MY_JOB_TOOLTIP_META_DATA}     Job Location
    Hover at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_POSTING_TYPE}      ${JOB_POSTING_TYPE_EXTERNAL}
    Check element display on screen     ${MY_JOB_TOOLTIP_META_DATA}     Job Posting Type
    Hover at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_BRAND}
    Check element display on screen     ${MY_JOB_TOOLTIP_META_DATA}     Brand
    Hover at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_JOB_ID}
    Check element display on screen     ${MY_JOB_TOOLTIP_META_DATA}     Job ID
    Hover at    ${MY_JOB_DETAIL_CANDIDATE_NUMBER}       ${MY_JOB_HAS_CVO_AND_SHIFT_JOB_NAME}
    Check element display on screen     ${MY_JOB_TOOLTIP_META_DATA}     0 / ${threshold} Candidates reached Hiring Goal
    Hover at    ${MY_JOB_ITEM_TOOLTIP_NUMBER_OF_SHIFT}      2
    Check element display on screen     ${MY_JOB_TOOLTIP_META_DATA}     2 Open Shifts Selected
    # OL-T28768
    Click at    ${MY_JOB_HAS_CVO_AND_SHIFT_JOB_NAME}
    Check span display      Set the number of candidates you need.
    Click at    ${MY_JOB_CLOSE_MODAL_BUTTON}
    Click at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_CITY}      ${LOCATION_STREET_NGUYEN_HUU_THO}
    Check span display      Set the number of candidates you need.
    Click at    ${MY_JOB_CLOSE_MODAL_BUTTON}
    Click at    ${MY_JOB_ALL_LOCATION_EXPAND_LOCATION_BY_BRAND}
    Check span display      Set the number of candidates you need.
    Click at    ${MY_JOB_CLOSE_MODAL_BUTTON}


Paradox Job - Check Ellipsis Options on My Jobs in case Job ON and OFF (OL-T28758,OL-T28759, OL-T28760, OL-T28761, OL-T28762, OL-T28763, OL-T28764, OL-T28767)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create Job, select some shifts > publish
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Search job by location and job name     ${MY_JOB_MENU_TEST_JOB_NAME}
    Deactive job if active      ${MY_JOB_MENU_TEST_JOB_NAME}
    # OL-T28759
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}       ${MY_JOB_MENU_TEST_JOB_NAME}
    Capture Page Screenshot
    check span display      View Job Description
    Check span display      Edit Job
    check span display      Copy Private Posting Link
    # OL-T28764
    Click at    Copy Private Posting Link
    ${private_link}=    Get clipboard text
    Open link in new tab and check title    ${private_link}
    # OL-T28767
    Check turn on job when edit
    # OL-T28758
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}       ${MY_JOB_MENU_TEST_JOB_NAME}
    Capture Page Screenshot
    check span display      View Job Description
    Check span display      Edit Job
    check span display      Copy Job Apply Link
    # OL-T28760
    Click at    View Job Description
    Check p text display    ${MY_JOB_DESCRIPTION_TEXT}
    Click at    ${MY_JOB_CLOSE_MODAL_BUTTON}
    # OL-T28761, OL-T28762
    Verify update shift and CVO success
    # OL-T28763
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}       ${MY_JOB_MENU_TEST_JOB_NAME}
    Click at    Copy Job Apply Link
    ${public_link}=     Get clipboard text
    Open link in new tab and check title    ${public_link}


Paradox Job - Check Turning Job OFF when the job has locations aren't assigned to JDP (OL-T28766)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -Create Job J
...    +Location availables: assign all locations of a area to the Job
...    +Aditional details: Location A,B assign to JDP1, Location C,D assign to JDP2
...    -Location management: add location E to above area
...    -Job J:Location E is automatically assigned to Job J, but is not assigned to any JDP
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Search job by location and job name     ${MY_JOB_HAS_DATA_PACKAGE_JOB_NAME}     location_name=${MY_JOB_DATA_PACKAGE_LOCATION}
    Turn on     ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}      ${MY_JOB_HAS_DATA_PACKAGE_JOB_NAME}
    ${error_message}=       Format String       ${package_must_assigned_error}      ${MY_JOB_HAS_DATA_PACKAGE_JOB_NAME}     ${MY_JOB_DATA_PACKAGE_LOCATION}
    Verify text contain     ${MY_JOB_CLOSE_MODAL_BOX_MESSAGE}       ${error_message}


Paradox Job - Check candidate applied via Copy job posting link and applied via Invite URL link (OL-T28769, OL-T28770)
        [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Search job by location and job name     ${MY_JOB_APPLY_VIA_LINK}
    Deactive job if active      ${MY_JOB_APPLY_VIA_LINK}
    Verify candidate apply via link success     False
    Active a job    ${MY_JOB_APPLY_VIA_LINK}
    Verify candidate apply via link success     True


Paradox Job - Check candidate search and applied for a jobs (OL-T28771)
    [Documentation]    Precondidion:
...    -Client setup > Hire > Jobs toggle is ON
...    -My job: Job is ON
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    ${url}=     Open landing site and get url       ${MY_JOB_JOB_SEARCH_SITE}
    ${name}=    Search paradox job and apply    ${url}      ${MY_JOB_JOB_SEARCH_JOB_NAME}
    Go to CEM page
    ${job_name_locator}=    Format String       ${CANDIDATE_LIST_ITEMS_JOB_NAME}    ${name.full_name}       ${MY_JOB_JOB_SEARCH_JOB_NAME}
    Check element display on screen     ${job_name_locator}

*** Keywords ***
Remove dot and check contains
    [Arguments]    ${string_contains}    ${locator}
    ${value}=    Get text and format text    ${locator}
    ${value}=    Replace String    ${value}    .    ${EMPTY}
    ${result}=    Evaluate    '${value}' in '${string_contains}'
    Should Be True    ${result}

Search by attribute
    [Arguments]    ${search_text}
    Search expected job in location    ${search_text}
    wait for page load successfully v1
    Scroll to bottom of table    ${MY_JOB_MAIN_SECTION}    ${LOADING_ICON_3}
    Check span display    ${MY_JOB_TEST_NAME}

Check display all location
    [Arguments]    ${locations}
    Capture Page Screenshot
    FOR    ${location}    IN    @{locations}
        Check element display on screen    ${JOB_LOCATION_VALUE}    ${location}
    END

Search and Check display correct area and location
    [Arguments]    ${text_search}
    Input into    ${MY_JOB_ALL_LOCATION_SEARCH_FOR_LOCATION_TEXTBOX}    ${text_search}
    Check display correct area and location

Check display correct area and location
    Capture Page Screenshot
    Check element display on screen    ${JOB_LOCATION_AREA_NAME}    ${MY_JOB_TEST_AREA}
    Check element display on screen    ${JOB_LOCATION_VALUE}    ${MY_JOB_TEST_LOCATION}

Get list job and check status
    [Arguments]    ${status}
    Select job filtering    Job ${status}
    Check Badge display    1
    Scroll to bottom of table    ${MY_JOB_MAIN_SECTION}    ${LOADING_ICON_3}
    ${list_job}=    Get elements and convert to list    ${ALL_JOB_TITLE}
    ${locator}=    Evaluate    "${MY_JOB_DETAIL_STATUS_JOB_ON_TOGGLE}" if '${status}'=='ON' else "${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}"
    FOR    ${job}    IN    @{list_job}
        Check element display on screen    ${locator}    ${job}
    END
    Unslect job filtering    Status is ${status}

Turn on a Job with shift
    [Arguments]    ${job_name}    ${location_name}=None
    Search job by location and job name    ${job_name}    ${location_name}
    Turn on    ${MY_JOB_DETAIL_STATUS_JOB_OFF_TOGGLE}    ${job_name}
    # check Show confimation modal, shifts will all default ON
    Check element display on screen    ${MY_JOB_DETAIL_POST_JOB_SHIFT_ACTIVED}    ${MY_JOB_HAS_LIST_SHIFT[0]}
    Check element display on screen    ${MY_JOB_DETAIL_POST_JOB_SHIFT_ACTIVED}    ${MY_JOB_HAS_LIST_SHIFT[1]}
    # check Can't deselect the lastest shift, at leat one shift should be turned ON (OL-T28749)
    Click at    ${MY_JOB_DETAIL_POST_JOB_SHIFT_ACTIVED}    ${MY_JOB_HAS_LIST_SHIFT[0]}    slow_down=1s
    Click at    ${MY_JOB_DETAIL_POST_JOB_SHIFT_ACTIVED}    ${MY_JOB_HAS_LIST_SHIFT[1]}    slow_down=1s
    Capture Page Screenshot
    Check element display on screen    ${MY_JOB_DETAIL_POST_JOB_SHIFT_ACTIVED}    ${MY_JOB_HAS_LIST_SHIFT[1]}
    # reset state
    Click at    ${MY_JOB_DETAIL_POST_JOB_SHIFT_TOOGLE}    ${MY_JOB_HAS_LIST_SHIFT[0]}    slow_down=1s
    Check element display on screen    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}    Post Job
    Check element display on screen    ${MY_JOB_DETAIL_CANCEL_BUTTON}
    Capture Page Screenshot
    Click at    ${MY_JOB_DETAIL_POST_JOB_BUTTON_TYPE}    Post Job
    Check element display on screen    ${job_name} has been posted!
    Capture Page Screenshot

Verify update shift and CVO success
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}    ${MY_JOB_MENU_TEST_JOB_NAME}
    Click at    Edit Job
    Input into    ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}    3
    Click at    ${MY_JOB_DETAIL_POST_JOB_SHIFT_TOOGLE}    ${MY_JOB_HAS_LIST_SHIFT[0]}
    Capture Page Screenshot
    Click at    ${COMMON_SPAN_TEXT}    Update Job Posting    slow_down=1s
    Capture Page Screenshot
    ${number_after}=    Evaluate    len(${MY_JOB_HAS_LIST_SHIFT}) - 1
    Check element display on screen    ${MY_JOB_ITEM_TOOLTIP_NUMBER_OF_SHIFT}    ${number_after}
    Hover at    ${MY_JOB_ITEM_TOOLTIP_NUMBER_OF_SHIFT}    ${number_after}
    Check element display on screen    ${MY_JOB_TOOLTIP_META_DATA}    ${number_after} Open Shifts Selected
    # OL-T28762
    Verify display text    ${MY_JOB_DETAIL_CANDIDATE_NUMBER}    0 / 3 Candidates    ${MY_JOB_MENU_TEST_JOB_NAME}
    Hover at    ${MY_JOB_DETAIL_CANDIDATE_NUMBER}    ${MY_JOB_MENU_TEST_JOB_NAME}
    Check element display on screen    ${MY_JOB_TOOLTIP_META_DATA}    0 / 3 Candidates reached Hiring Goal

Open link in new tab and check title
    [Arguments]    ${link}
    Open new tab same browser
    @{window} =    get window handles
    Switch window    ${window}[-1]
    Go to    ${link}
    Title Should Be    ${MY_JOB_MENU_TEST_JOB_NAME} | ${COMPANY_HIRE_ON}
    Switch Window    ${window}[0]

Check turn on job when edit
    Click at    ${MY_JOB_DETAILS_ESCAPE_ICON}    ${MY_JOB_MENU_TEST_JOB_NAME}
    Click at    Edit Job
    FOR    ${shift}    IN    @{MY_JOB_HAS_LIST_SHIFT}
        ${shift_on}=    Run Keyword And Return Status    Check element display on screen    ${MY_JOB_DETAIL_POST_JOB_SHIFT_ACTIVED}    ${shift}
        Run Keyword If    '${shift_on}'=='False'
        ...    Click at    ${MY_JOB_DETAIL_POST_JOB_SHIFT_TOOGLE}    ${shift}
    END
    Input into    ${MY_JOB_THRESHOLD_NUMBER_TEXTBOX}    4
    Capture Page Screenshot
    Click at    ${COMMON_SPAN_TEXT}    Update Job Posting    slow_down=1s
    check element display on screen     ${MY_JOB_MENU_TEST_JOB_NAME} has been updated!
    Verify display text    ${MY_JOB_DETAIL_CANDIDATE_NUMBER}    0 / 4 Candidates    ${MY_JOB_MENU_TEST_JOB_NAME}
    ${number_of_shift}=    Get Length  ${MY_JOB_HAS_LIST_SHIFT}
    Check element display on screen     ${MY_JOB_ITEM_TOOLTIP_NUMBER_OF_SHIFT}      ${number_of_shift}

Verify candidate apply via link success
    [Arguments]    ${visited}
    ${job_link}=    Get job link from clipboard    ${MY_JOB_APPLY_VIA_LINK}
    Go to    ${job_link}
    Maximize Browser Window
    Title Should Be    ${MY_JOB_APPLY_VIA_LINK} | ${COMPANY_HIRE_ON}
    ${name}=    Start a conversation apply job with posting link job    ${job_link}    visited=${visited}
    Go to CEM page
    ${job_name_locator}=    Format String    ${CANDIDATE_LIST_ITEMS_JOB_NAME}    ${name.full_name}    ${MY_JOB_APPLY_VIA_LINK}
    Check element display on screen    ${job_name_locator}

Start a conversation apply job with posting link job
    [Arguments]     ${link_job}    ${visited}=False
    ${name}=    Generate candidate name
    &{email_info} =  Get email for testing
    Go to   ${link_job}
    IF    '${visited}' == 'True'
        Input text for widget site    new
    END
    Accept GDPR modal in widget site
    Check Message Widget Site Response Correct    ${ASK_FIRST_AND_LAST_NAME}
    Input text for widget site      ${name.full_name}
    Check Message Widget Site Response Correct    ${ASK_PHONE}
    Input text for widget site      ${CONST_PHONE_NUMBER_2}
    Check Message Widget Site Response Correct      ${REPROMPT_EMAIL_MESSAGE_6}
    Input text for widget site       ${email_info.email}
    Check Message Widget Site Response Correct    ${REPROMPT_AGE_MESSAGE_1}
    Input text for widget site    33
    Check Message Widget Site Response Correct    ${EVENT_CONTACT_QUESTION}
    Click on option in conversation    Email Only
    Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    [Return]    ${name}

Search paradox job and apply
    [Arguments]     ${url}    ${job_name}
    ${name}=    Generate candidate name
    &{email_info} =  Get email for testing
    Go to   ${url}
    Accept GDPR modal in landing site
    Check element display on screen    ${START_JOB_SEARCH_MESSAGE}
    Input text and send message      ${JF_COFFEE_FAMILY_JOB}
    Check element display on screen      ${REPROMPT_LOCATION_MESSAGE_1}
    Input text and send message      anywhere
    Check element display on screen      positions I found for you.
    Click at    ${CONVERSATION_SEE_ALL_BUTTON}
    Capture Page Screenshot
    Click at    ${job_name}
    click at    ${COMMON_SPAN_TEXT}    Apply Now
    Check element display on screen    ${ASK_FIRST_AND_LAST_NAME}
    Input text and send message      ${name.full_name}
    Check element display on screen      ${ASK_PHONE}
    Input text and send message      ${CONST_PHONE_NUMBER_2}
    Check element display on screen      ${REPROMPT_EMAIL_MESSAGE_6}
    Input text and send message       ${email_info.email}
    Check element display on screen    ${REPROMPT_AGE_MESSAGE_1}
    Input text and send message    33
    Check element display on screen    ${EVENT_CONTACT_QUESTION}
    Click at    ${COMMON_SPAN_TEXT}   Email Only
    Click at    ${CONVERSATION_CONFIRM_CHOICE_BUTTON}
    ${end_message}=    Format String    ${EVENT_THANK_YOU_MESSAGE}    company_name=${COMPANY_HIRE_ON}
    Check element display on screen    ${end_message}
    [Return]     ${name}
