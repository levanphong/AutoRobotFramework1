*** Settings ***
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/group_management_page.robot
Resource            ../../pages/location_management_page.robot
Resource            ../../pages/users_roles_permissions_page.robot
Resource            ../../pages/campaigns_page.robot
Variables           ../../constants/CEMFilterImprovement.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Setup for every Test case
Default Tags        test
Documentation       run datatest for first time:
...                 robot src/data_tests/cem/cem_filter_datatest.robot
...                 Manual:
...                 Create data test for Source filter: create 3 candidate via CA Team's Scheduling Site

*** Variables ***
${hover_background_color}       rgba(223, 226, 230, 1)
${message_right_side}           You can filter your candidates by what you know about them. Select an attribute on the left to get started.
${filter_modal_title}           What type of candidates do you want to see?
@{list_filter_type}             Location    Scheduling status    Last contacted date    Contacted by    Source    Start keyword    Status
@{scheduling_statuses}          Interview Request Pending    Interview Canceled    Interview Scheduled    Interview Complete    Interview Request Expired    Interview Request Canceled    No Availability
@{last_contacted_date_items}    Relative    Within the last    More than    Absolute    Never contacted    Before    After    Between    Exact date
@{source_types}=                Manually Added    Company Site    Conversation Widget    Embedded Conversation    Employee Referrals Site    Outbound    Personal Site    Scheduling Site    Text Messaging    Facebook    WeChat    WhatsApp

*** Test Cases ***
Filter icon is shown to the right of Sorting feature and Filter modal is shown after clicking on Filter (OL-T1208, OL-T1209)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to CEM page
    # Check the Filter icon in the right of Sorting feature
    Check element display on screen     ${FILTER_ICON}
    Hover at    ${FILTER_ICON}
    Capture Page Screenshot
    # Check The shadow is added when Filter is hover
    Element Should Be Visible       ${FILTER_TOOLTIP}
    # check The shadow is added when Filter is hover
    Check background color code displayed correctly     ${FILTER_ICON}      ${hover_background_color}
    # Filter modal is shown after clicking on Filter (OL-T1209)
    Open filter modal
    Capture Page Screenshot
    # Check "What type of candidates do you want to see?" is title of this modal
    Check span display      ${filter_modal_title}
    # Check No attribute selected
    # check "You can filter your candidates by what you know about them. Select an attribute on the left to get started." message is shown on the right side
    Verify display text     ${FILTER_RIGHT_SIDE_START_TEXT}     ${message_right_side}


Filter Attribute when Job ON (OL-T1210, OL-T1213, OL-T1214, OL-T1215)
    [Documentation]
    ...    Precondition:
    ...    Client setup -> Hire -> Olivia Hire ON
    ...    Client setup -> Turn ON Candidate Journey
    ...    Client setup -> Capture -> Turn ON Campaigns
    ...    Turn ON Job
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    # "Status" filtering attribute will be disappeared when Candidate journey is ON (OL-T1213)
    # Check "Status" attribute is added into the Filter modal
    Check element display on screen     ${FILTER_TYPE_STATUS}
    #"Reffered By" filtering attribute will be appeared when Employee Referrals is ON (OL-T1214)
    # check "Reffered By" attribute is added into the Filter modal
    Check element display on screen     ${FILTER_TYPE_PATTERN}      Referred by
    # "Campaign" filtering attribute will be appear when "Campaigns" is ON (OL-T1215)
    # check "Campaign" attribute is added into the Filter modal
    Check element display on screen     ${FILTER_TYPE_PATTERN}      Campaign


List all jobs that user has permission to view will be shown when click on "Job" and can search (OL-T1218, OL-T1219)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    #Check Show list all jobs that user has permission to view will be shown exclude draft job
    ${list_job}=    Get all job
    Open filter modal
    Click at    ${FILTER_TYPE_JOB}
    Check list item should display      ${list_job}
    # User can search for jobs to apply job filter
    Input into      ${JOB_FILTER_SEARCH_INPUT}      ${CEM_FILTER_JOB_NAME}
    Capture Page Screenshot
    # check Show list job that match with the inputted value
    Check element display on screen     ${JOB_FILTER_SEARCH_ITEM_NAME_PATTERN}      ${CEM_FILTER_JOB_NAME}


Filter by jobs successfully when click on "Apply" (OL-T1220)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    # Select jobs and click on "Apply" button
    Open filter modal
    Click at    ${FILTER_TYPE_JOB}
    wait for page load successfully v1
    Input into      ${JOB_FILTER_SEARCH_INPUT}      ${CEM_FILTER_JOB_NAME}
    Click at    ${JOB_FILTER_SEARCH_ITEM_NAME_PATTERN}      ${CEM_FILTER_JOB_NAME}      slow_down=2s
    Click at    ${FILTER_APPLY_BUTTON}
    # Inbox will show list candidates which have jobs match with job filter for current user
    Check display filtered candidate    ${CEM_FILTER_JOB_NAME}


Cancel applying filter by Job when click on "Cancel" (OL-T1221)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to CEM page
    ${len_before}=      Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    Open filter modal
    # Select jobs
    Click at    ${FILTER_TYPE_JOB}
    wait for page load successfully v1
    Input into      ${JOB_FILTER_SEARCH_INPUT}      ${CEM_FILTER_JOB_NAME}
    Click at    ${JOB_FILTER_SEARCH_ITEM_NAME_PATTERN}      ${CEM_FILTER_JOB_NAME}
    Click at    ${FILTER_CANCEL_BUTTON}
    wait for page load successfully v1
    # Close the modal and does not apply filter
    ${len_after}=       Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    Should Be Equal As Integers     ${len_before}       ${len_after}


List all the existing Candidate Journey Stages and Statuses will be shown when click on "Status" and Filter by Status successfully (OL-T1222, OL-T1223)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Click at    ${FILTER_TYPE_STATUS}
    # check Show list all the existing Candidate Journey Stages and status
    Check display all status of stage       Capture     ${CEM_FILTER_CAPTURE_STATUS}
    Check display all status of stage       Scheduling      ${CEM_FILTER_SCHEDULING_STATUS}
    #Filter by Status successfully (OL-T1223)
    ${capture_completed_locator}=       Format String       ${STATUS_FILTER_STATUS_CHECKBOX}    ${CEM_FILTER_JOURNEY_NAME}: Scheduling      Interview Pending
    Click at    ${capture_completed_locator}    slow_down=3s
    Click at    ${FILTER_APPLY_BUTTON}
    # check inbox will show list candidates which have status match with status filter
    Check display filtered candidate    Interview Pending       2


List all the Groups added into Group Management when click on "Group" and Filter by Group successfully (OL-T1224, OL-T1225)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    ${list_group}=      Get all group
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Group
    # check Show list all the added group added into Group Management
    Check list item should display      ${list_group}
    # Filter by Group successfully (OL-T1225)
    Click at    ${GROUP_FILTER_ITEM_LABEL}      ${CEM_FILTER_GROUP_NAME}    slow_down=3s
    Click at    ${FILTER_APPLY_BUTTON}
    # check Inbox will show list candidates which belong to Group match with group filter
    Check display filtered candidate    ${CEM_FILTER_GROUP_NAME}    0


List all the Locations added into Location Management that the user has permission to view when click on "Location" and Filter by Location successfully (OL-T1226, OL-T1227)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${list_location}=       Get all location name
    Open filter modal
    Click at    ${FILTER_TYPE_LOCATION}
    # Check Show list all the Locations added into Location Management that user has permission to view
    Check list item should display      ${list_location}    scroll=False    locator=${FILTER_PATTERN_LOCATION_LABEL}
    # Filter by Location successfully (OL-T1227)
    # Check Inbox will show list candidates which belong to Location match with location filter
    Click at    ${FILTER_PATTERN_LOCATION_CHECKBOX}     ${CEM_FILTER_LOCATION_NAME}     slow_down=3s
    Click at    ${FILTER_APPLY_BUTTON}
    Check display filtered candidate    ${CEM_FILTER_LOCATION_NAME}     1


List all the status of scheduling when click on "Scheduling status" and Filter by Scheduling Status successfully (OL-T1228, OL-T1229)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Scheduling status
    # Check Show list all the scheduling status
    Check list item should display      ${scheduling_statuses}
    # Filter by Scheduling Status successfully (OL-T1229)
    # Check Inbox will show list candidates which have status match with status filter
    Click at    Interview Request Pending
    Click at    ${FILTER_APPLY_BUTTON}
    Check display filtered candidate    Interview Pending       2       check_number=False


Contacted date options will be shown when click on "Last contacted date" and canlendar is shown when select filter option (OL-T1230, OL-T1233, OL-T1234, OL-T1235)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Last contacted date
    Check list last contacted date display
    # Calendar is shown when select "Before" (OL-T1233)
    Click at filter date option and check canlendar display     Before
    # Calendar is shown when select "After" (OL-T1234)
    Click at filter date option and check canlendar display     After
    # Calendar is shown when select "Exact date" (OL-T1235)
    Click at filter date option and check canlendar display     Exact date


List user who is currently active when click on "Contacted By" and Filter by "Contacted By" successfully (OL-T1242, OL-T1243)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${list_user_name}=      Get all user name with type
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Contacted by
    # Check Show list all user who is currently active not show basic user
    Check list item should display      ${list_user_name}
    # Filter by "Contacted By" successfully (OL-T1243)
    # Check Inbox will show the list candidate that have contacted by the selected user
    Click at    ${CONTACTED_BY_FILTER_USERNAME_TITLE}       ${CONTACTED_BY_FILTER_USER_NAME}
    Click at    ${FILTER_APPLY_BUTTON}
    ${number_of_candidate_after_filter}=    Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    Should Be Equal As Integers     ${number_of_candidate_after_filter}     ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}


List all the employee names that have submitted an employee referral when click on "Referred by" and Filter by "Referred by" successfully (OL-T1244, OL-T1245)
    [Tags]      skip
    # TODO (Reason: bug https://paradoxai.atlassian.net/browse/OL-76747)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${list_employee}=       Get all employee referred
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Referred by
    Capture Page Screenshot
    # Check Show the list employee name that have submitted an employee referral
    Search and check employee referred display      ${list_employee}
    # Check Show the list candidates that was reffered by employees match with reffered filter
    Input into      ${REFERRED_BY_FILTER_SEARCH_INPUT}      ${CEM_FILTER_REFERRED_BY_EMPLOYEE_FULLNAME}
    Click at    ${COMMON_STRONG_TEXT}       ${CEM_FILTER_REFERRED_BY_EMPLOYEE_FULLNAME}
    Click at    ${FILTER_APPLY_BUTTON}      slow_down=3s
    ${number_of_candidate_after_filter}=    Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    Should Be Equal As Integers     ${number_of_candidate_after_filter}     ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}


List all the campaigns added in Campaigns when click on "Campaign" (OL-T1246)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    ${list_campaign}=       Get all campaign for filter
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Campaign
    Check list item should display      ${list_campaign}

# TODO Filter by Campaign successfully OL-T1247 (reason: bug https://paradoxai.atlassian.net/browse/OL-76982)


List correct value when click on "Source" and Filter by Source successfully (OL-T1248, OL-T1249)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Source
    Check list item should display      ${source_types}     scroll=False
    # Filter by Source successfully
    # Check Show the list candidates that belong to Source match with Source filter
    Click at    Scheduling Site
    Click at    ${FILTER_APPLY_BUTTON}      slow_down=2s
    ${number_of_candidate_after_filter}=    Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    Should Be Equal As Integers     ${number_of_candidate_after_filter}     ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}


Display number of candidate match affter filter and display badge (OL-T1253, OL-T1255)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Click at    ${FILTER_TYPE_LOCATION}
    Click at    ${FILTER_PATTERN_LOCATION_CHECKBOX}     ${CEM_FILTER_LOCATION_NAME}
    Capture Page Screenshot
    # Check The count of candidates that meet the filter criteria will be displayed "{Number} candidates match" in the bottom corner when user adds more filter values (OL-T1255)
    Check element display on screen     ${FOOTER_NUMBER_CANDIDATES_MATCH}       ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
    Click at    ${FILTER_APPLY_BUTTON}
    # check The count of selected value is displayed beside the attribute
    Check element display on screen     ${FILTER_BADGE_SELECTED}    1


Has no candidate match affter filter (OL-T1256, OL-T1257, OL-T1258, OL-T1259)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to CEM page
    ${len_before}=      Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Source
    Click at    Facebook
    # check "No Candidate Count" message is displayed
    Capture Page Screenshot
    Check element display on screen     ${FOOTER_NUMBER_CANDIDATES_MATCH}       No
    Click at    ${FILTER_APPLY_BUTTON}
    Capture Page Screenshot
    # The Inbox will display a blank state with no candidates when the user applies the filters with no candidates found OL-T1257
    Verify display text     ${CANDIDATE_LIST_HEADER_TITLE}      0 Candidates
    Check span display      None match your filters
    # A “Clear Filters” button will display when the user applies the filters when there are no candidates found OL-T1258
    # check Button: "Clear Filters" display
    Check element display on screen     ${CLEAR_FILTERS_BUTTON}
    # Clear all applied filters and display all candidates again when click on "Clear Filters" button OL-T1259
    Click at    ${CLEAR_FILTERS_BUTTON}
    wait for page load successfully v1
    Capture Page Screenshot
    ${len_after_clear}=     Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    # check The Inbox displays all candidates like original
    Should be larger/equal as integer       ${len_after_clear}      ${len_before}
    # check Filter button is not highligted with no red icon for number of filters
    Check element not display on screen     ${FILTER_BADGE_SELECTED}    1


The count of selected values will continue to display next to the field name when more values are selected from different filter attributes (OL-T1260)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Count number of filter type selected when select all    Source      ${source_types}
    Count number of filter type selected when select all    Scheduling status       ${scheduling_statuses}


"Need ideas?" section is shown when no attribute selected (OL-T1267, OL-T1270, OL-T1274, OL-T1275)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    # check "Need ideas?" section is shown in the bottom corner
    Check span display      Need ideas?
    # check Three predefined filters are shown when the section is expanded OL-T1270
    Click at    Need ideas?
    Check p text display    People that you have contacted
    Check p text display    People with upcoming interviews
    Check p text display    People who engaged in the past week
    # Filter selection displays with an Olivia Blue “active region” outline with a check mark when one of the filters has been selected (OL-T1274)
    Click at    People with upcoming interviews
    # check "People with upcoming interviews" is Olivia Blue color and outline with a check mark
    Check element display on screen     ${NEED_IDEAS_SELECTED_ICON}     People with upcoming interviews
    # The filter values will be applied and display in the attributes list when one of the "Need ideas?" filters has been selected OL-T1275
    Click at    People that you have contacted
    Click at    People who engaged in the past week
    # check "Contacted By" attribute is selected, Check Count of value displays next to this field is "1"
    Scroll to element       ${FILTER_TYPE_PATTERN}      Contacted by
    Count number of filter type selected    Contacted by    1
    # check "Scheduling status" attribute is selected, Check Count of value displays next to this field is "1"
    Count number of filter type selected    Scheduling status       1
    # check "Contacted date" attribute is selected, Check Count of value displays next to this field is "1"
    Count number of filter type selected    Last contacted date     1
    # check "Contacted date" is selected with "Within the last 7 days"
    Click at    ${FILTER_TYPE_PATTERN}      Last contacted date
    Check element display on screen     ${WITHIN_LAST_WEEK_INPUT}


List all candidates which are contacted by current user when click on "People that you have contacted" (OL-T1271)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Go to CEM page
    Switch to user      ${CONTACTED_BY_FILTER_USER_NAME}
    Apply need ideas    People that you have contacted
    ${number_of_candidate_after_filter}=    Extract number from locator text    ${CANDIDATE_LIST_HEADER_TITLE}
    # check Show list all candidates which are contacted by current user. Should be viewer
    Capture Page Screenshot
    Should Be Equal As Integers     ${number_of_candidate_after_filter}     ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}


List all candidates which have Scheduling status is Interview Scheduled when click on "People with upcoming interviews" (OL-T1272)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Apply need ideas    People with upcoming interviews
    # check Show list all candidates which have Scheduling status is "Interview Scheduled"
    Check display filtered candidate    Interview Scheduled     2       check_number=False


Filter by multiple attributes successfully (OL-T1276)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Open filter modal
    Click at    ${FILTER_TYPE_PATTERN}      Contacted by
    Click at    ${CONTACTED_BY_FILTER_USERNAME_TITLE}       ${CONTACTED_BY_FILTER_USER_NAME}
    Click at    ${FILTER_TYPE_PATTERN}      Scheduling status
    Click at    Interview Request Pending
    Click at    ${FILTER_APPLY_BUTTON}      slow_down=3s
    # check Show list all the candidates which have match with the filter values
    Check display filtered candidate    Interview Pending       2
    # check Filter is Olivia Blue color with the red number of selected filter values
    Check element display on screen     ${FILTER_BADGE_SELECTED}    2


Value of "Job", "Start keyword", "Contacted by", "Location" are shown base on permission of each user (OL-T1278)
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_DATA_PACKAGE_OFF}
    Switch to user      ${CONTACTED_BY_FILTER_USER_NAME}
    # Check The jobs that current user has permission to view are displayed
    ${list_job}=    Get all job
    Open filter modal
    Click at    ${FILTER_TYPE_JOB}
    Check list item should display      ${list_job}
    # Check The Location that current user has permission to view are displayed
    Click at    ${FILTER_TYPE_LOCATION}
    Check element display on screen     ${FILTER_PATTERN_LOCATION_LABEL}    ${CEM_FILTER_TEAM_LOCATION}    

*** Keywords ***
Check display all status of stage
    [Arguments]    ${stage}    ${statuses}
    Check element display on screen     ${STATUS_FILTER_STAGE_TITLE}    ${CEM_FILTER_JOURNEY_NAME}: ${stage}
    FOR    ${status}    IN    @{statuses}
        ${locator}=     Format String       ${STATUS_FILTER_STATUS_TITLE}       ${CEM_FILTER_JOURNEY_NAME}: ${stage}       ${status}
        Check element display on screen     ${locator}
    END

Check display filtered candidate
    [Arguments]    ${value_to_compare}    ${attribute_index}=0    ${check_number}=True
    wait for page load successfully v1
    Capture Page Screenshot
    ${list_attribute}=       Get all candidate's attribute     ${CANDIDATE_LIST_ITEMS_DES}     ${attribute_index}
    IF    '${check_number}' == 'True'
        ${number_of_candidate_after_apply_filter_real}=     Get Length      ${list_attribute}
        Should Be Equal As Integers     ${number_of_candidate_after_apply_filter_real}      ${NUMBER_OF_CANDIDATE_AFTER_APPLY_FILTER_EXPECT}
    END
    FOR    ${attribute}    IN    @{list_attribute}
        Should Be Equal As Strings      ${attribute}     ${value_to_compare}
    END

Click at filter date option and check canlendar display
    [Arguments]    ${option}
    Click at    ${LAST_CONTACTED_DATE_ITEM}    ${option}
    Click at    ${LAST_CONTACTED_DATE_INPUT}
    Check element display on screen    ${LAST_CONTACTED_DATE_INPUT}

Check list filter type display
    Capture Page Screenshot
    # Check Default is Job
    Check element display on screen     ${FILTER_TYPE_JOB}
    # Check Attributes list: Job, Location, Scheduling Status, Last Contacted date, Contacted by, Source, Start keyword
    FOR    ${type}    IN    @{list_filter_type}
        Check element display on screen     ${FILTER_TYPE_PATTERN}      ${type}
    END

Check list item should display
    [Arguments]    ${list_items}    ${scroll}=True    ${locator}=${FILTER_ITEM_LABEL}
    IF    '${scroll}' == 'True'
        Wait for fully load filter item
    END
    Capture Page Screenshot
    FOR    ${items}    IN    @{list_items}
        Check element display on screen    ${locator}    ${items}
    END

Check list last contacted date display
    [Arguments]
    Capture Page Screenshot
    FOR    ${item}    IN    @{last_contacted_date_items}
        Check element display on screen     ${LAST_CONTACTED_DATE_ITEM}     ${item}
    END

Search and check employee referred display
    [Arguments]    ${list_employee}
    FOR    ${employee}    IN    @{list_employee}
        Input into    ${REFERRED_BY_FILTER_SEARCH_INPUT}    ${employee}
        Check strong text display    ${employee}
    END

Count number of filter type selected when select all
    [Arguments]    ${filter_tab}    ${list_type}
    Click at    ${FILTER_TYPE_PATTERN}      ${filter_tab}
    FOR    ${type}    IN    @{list_type}
        Click at    ${FILTER_ITEM_LABEL}    ${type}
    END
    ${number_selected}=    Get Length    ${list_type}
    ${locator}=    Format String    ${FILTER_TYPE_NUMBER_SELECTED}    ${filter_tab}    ${number_selected}
    Element Should Be Visible    ${locator}

Apply need ideas
    [Arguments]    ${idea}
    Open filter modal
    Click at    Need ideas?
    Click at    ${idea}    slow_down=3s
    Click at    ${FILTER_APPLY_BUTTON}
    Capture Page Screenshot

Count number of filter type selected
    [Arguments]    ${filter_tab}    ${number_selected}
    ${locator}=    Format String    ${FILTER_TYPE_NUMBER_SELECTED}    ${filter_tab}    ${number_selected}
    Element Should Be Visible    ${locator}
