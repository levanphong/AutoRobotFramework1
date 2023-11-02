*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/cms_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/my_jobs_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          dev2    fedexstg    lts_stg    olivia    regression    test    stg    advantage    fedex    darden    aramark    unilever    lowes    lowes_stg    pepsi    birddoghr

Documentation       "src/data_tests/job_external/job_search_results.robot" run this data test for new instances

*** Variables ***
@{included_fields_list_by_locator}              title    location    account    branch    company_name    employment_status    employment_type    facility_name    category    payrate
@{included_fields_list_by_name}                 Title    Job Location    Account    Branch    Company Name    Employment Status    Employment Type    Facility Name    Job Category    Pay Rate
@{default_fields_list_by_locator}               title    location
@{default_fields_selected_job_by_locator}       title    location    company_name
@{4_selected_job_by_locator}                    title    location    company_name    category
${job_site_name}                                JobSearchSiteForTesting
${job_widget_name}                              JobSearchWidgetForTesting
${manual_condition_title}                       Manual

*** Test Cases ***
Verify that show tab as default page when navigate to 'Job Results UI builder' section (OL-T23870, OL-T23877, OL-T23887, OL-T23903, OL-T23913, OL-T23889, OL-T23915)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    Verify sub-section design   List View
    Verify sub-section design   Selected Job
    #   Check 'Job Location' field is disable on Selected Job Builder
    Click at    ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Check element display on screen  ${JOB_SEARCH_RESULTS_DISABLED_FIELD_ITEM}    Job Location
    Verify sub-section design   Job Posting Page
    #   Check 'Job Location' field is disable Job Posting Page Builder
    Click at    ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Check element display on screen  ${JOB_SEARCH_RESULTS_DISABLED_FIELD_ITEM}    Job Location


'Select Job tab_Dropdow list condition' Verify behavior when click into Add condition button (OL-T23879, OL-T23880, OL-T23881, OL-T23905, OL-T23907)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    Click at    ${NAV_SUB_MENU_TEXT}    Selected Job
    Select condition on job search results  Default
    Verify 'Condition Criteria' dialog design
    Verify Edit Condition dialog


'Select Job tab_Reorder button' Verify Reorder button on UI (OL-T23883, OL-T23882, OL-T23884, OL-T23886, OL-T23888, OL-T23890)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    Click at    ${NAV_SUB_MENU_TEXT}    Selected Job
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_038}    target_rules=Job City
    Remove field(s)   Company Name
    Verify element is disabled by checking class   ${JOB_SEARCH_RESULTS_REORDER_BUTTON}
    Add field in Job Search Results  Company Name  Selected Job
    Verify element is enable  ${JOB_SEARCH_RESULTS_REORDER_BUTTON}
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}  Company Name
    #   Open and check Reorder Fields dialog
    Verify 'Reorder Fields' dialog design   Company Name
    #   At more field to hide 'Add field' button
    @{fields_list} =  create list  Pay Rate  Job Category  Facility Name
    Add field in Job Search Results  ${fields_list}  Selected Job
    Check element not display on screen  ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}


Verify UI job search result when search job via Company Site/Landing Site (OL-T23897)
    Given Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${job_site_name}
    Go to conversation and show jobs    ${site_url}    ${AUTOMATION_TESTER_REQ_ID_002}
    CLick at  ${AUTOMATION_TESTER_TITLE_002}
    Check selected job displays correctly on job conversation  ${4_selected_job_by_locator}


Verify Select job in Job search result is show data correctly incase job match with condition - widget conversation (OL-T23891)
    Given Setup test
    ${site_url} =  Get widget conversation link   ${job_widget_name}
    Go to widget site    ${site_url}
    Input text for widget site  ${AUTOMATION_TESTER_REQ_ID_002}
    Input text for widget site  ${ANY_WHERE}
    CLick at  ${SHADOW_DOM_DETAILS_CONTENT}
    Check selected job displays correctly on widget conversation    ${default_fields_selected_job_by_locator}


Verify Select job in Job search result is show mapping default condition incase job not mapping with any condition (OL-T23892)
    Given Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${job_site_name}
    Go to conversation and show jobs    ${site_url}
    Select a job on list view
    Check selected job displays correctly on job conversation  ${default_fields_selected_job_by_locator}


Verify that job search result will be show mapping with update condition (OL-T23894)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_005}  input=${AUTOMATION_TESTER_TITLE_005}
    Add field in Job Search Results  Job Category  Selected Job
    ${site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${job_site_name}
    Go to conversation and show jobs    ${site_url}    ${AUTOMATION_TESTER_REQ_ID_005}
    Click at   ${AUTOMATION_TESTER_TITLE_005}
    Check selected job displays correctly on job conversation  ${4_selected_job_by_locator}
    #   Edit condition
    Go to job search results builder page
    CLick at    ${NAV_SUB_MENU_TEXT}    Selected Job
    Select condition on job search results  ${condition_title}
    Remove field(s)  Job Category
    Go to    ${site_url}
    Click at   ${AUTOMATION_TESTER_TITLE_005}
    Check selected job displays correctly on job conversation  ${default_fields_selected_job_by_locator}


Verify that job search result will be show default condition when delete match condition (OL-T23895, OL-T23868)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_012}  input=${AUTOMATION_TESTER_TITLE_012}
    Add field in Job Search Results  Job Category  Selected Job
    ${site_url} =  Get landing site url by string concatenation  COMPANY_APPLICANT_FLOW   ${job_site_name}
    Go to conversation and show jobs    ${site_url}    ${AUTOMATION_TESTER_REQ_ID_012}
    Click at   ${AUTOMATION_TESTER_TITLE_012}
    @{selected_job_list} =  Create list   title    location    company_name    category
    Check selected job displays correctly on job conversation  ${selected_job_list}
    Click at   ${CONVERSATION_SELECTED_JOB_X_BUTTON}
    #   Delete condition
    Go to job search results builder page
    Delete condition(s)  ${condition_title}
    Go to   ${site_url}
    Wait for Olivia reply
    Candidate input to landing site   ${NEW}
    Candidate input to landing site   ${AUTOMATION_TESTER_REQ_ID_012}
    Click at   ${AUTOMATION_TESTER_TITLE_012}
    Check selected job displays correctly on job conversation  ${default_fields_selected_job_by_locator}

#  ===SECTION: JOB POSTING PAGE===
'Job posting tab_Reorder button' Verify Reorder button on UI (OL-T23908, OL-T23909, OL-T23910, OL-T23912, OL-T23914)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    Click at    ${NAV_SUB_MENU_TEXT}    Job Posting Page
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_017}    target_rules=Job City
    Remove field(s)   Company Name
    Verify element is disabled by checking class   ${JOB_SEARCH_RESULTS_REORDER_BUTTON}
    Add field in Job Search Results  Company Name  Job Posting Page
    Verify element is enable  ${JOB_SEARCH_RESULTS_REORDER_BUTTON}
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}  Company Name
    #   Open and check Reorder Fields dialog
    Verify 'Reorder Fields' dialog design   Company Name
    #   At more field to hide 'Add field' button
    @{fields_list} =  create list  Pay Rate  Job Category  Facility Name
    Add field in Job Search Results  ${fields_list}  Job Posting Page
    Check element not display on screen  ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}


'Job posting tab_Preview builder'_Verify value Preview Builder when change fields on UI (OL-T23916, OL-T23917, OL-T23906)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    Click at    ${NAV_SUB_MENU_TEXT}    Job Posting Page
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_025}  input=${AUTOMATION_TESTER_TITLE_025}
    Add field in Job Search Results  Company Name  Job Posting Page
    ${job_url} =  Search job and get internal job link  ${AUTOMATION_TESTER_TITLE_025}
    Go to   ${job_url}
    @{fields_list} =  Create List   location    company_name
    Check job posting page displays correctly on job conversation  ${fields_list}


Verify Job posting page result is show mapping default condition incase job not mapping with any condition (OL-T23918)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    ${job_url} =  Search job and get internal job link  ${AUTOMATION_TESTER_TITLE_034}
    Go to   ${job_url}
    Check job posting page displays correctly on job conversation by default


Verify that Job Posting Page will be show mapping with update condition (OL-T23922)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_046}  input=${AUTOMATION_TESTER_TITLE_046}
    Add field in Job Search Results  Job Category  Job Posting Page
    ${site_url} =  Search job and get internal job link   ${AUTOMATION_TESTER_TITLE_046}
    Go to  ${site_url}
    @{fields_list} =  Create List   location    category
    Check job posting page displays correctly on job conversation  ${fields_list}
    #   Edit condition
    Go to job search results builder page
    CLick at    ${NAV_SUB_MENU_TEXT}    Job Posting Page
    Select condition on job search results  ${condition_title}
    Edit field in Job Search Results  Job Category   Account
    Go to  ${site_url}
    @{fields_list2} =  Create List   location   account
    Check job posting page displays correctly on job conversation  ${fields_list2}


Verify that Job Posting Page will be show default condition when delete match condition (OL-T23923)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Go to job search results builder page
    ${condition_title} =  Add new condition then select it   condition_title=${AUTOMATION_TESTER_TITLE_055}  input=${AUTOMATION_TESTER_TITLE_055}
    Add field in Job Search Results  Job Category  Job Posting Page
    ${site_url} =  Search job and get internal job link   ${AUTOMATION_TESTER_TITLE_055}
    Go to  ${site_url}
    @{fields_list} =  Create List   location    category
    Check job posting page displays correctly on job conversation  ${fields_list}
    #   Delete condition
    Go to job search results builder page
    Delete condition(s)  ${condition_title}
    Go to  ${site_url}
    Check job posting page displays correctly on job conversation by default

#  ===SECTION: CMS OFF BELOW===
Verify 'UI list view, selected job of job search result' will be get mapping newest default condition when turn ON job search toggle and turn OFF CMS toggle (OL-T23872, OL-T23874, OL-T23871, OL-T23873, OL-T23867)
    Given Setup test
    ${site_url} =  Get landing site url by string concatenation  COMPANY_LOCATION_MAPPING_OFF   ${job_site_name}
    Go to conversation and show jobs    ${site_url}
    #   Check field should be displayed on list view
    Check list view displays correctly on job conversation  ${default_fields_list_by_locator}
    #   Check field should be displayed on selected job
    Select a job on list view
    Check selected job displays correctly on job conversation  ${default_fields_selected_job_by_locator}


Verify 'UI job posting page result' will be get mapping default condition when turn ON job search toggle and turn OFF CMS toggle (OL-T23875)
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_LOCATION_MAPPING_OFF}
    ${site_url} =  Search job and get internal job link   ${AUTOMATION_TESTER_TITLE_050}
    Go to  ${site_url}
    Check job posting page displays correctly on job conversation by default

*** Keywords ***
Verify sub-section design
    [Arguments]    ${sub_section}=List View
    Click at    ${NAV_SUB_MENU_TEXT}    ${sub_section}
    Capture page screenshot
    #   '${sub_section}' is active
    Check element display on screen  ${JOB_SEARCH_RESULTS_ACTIVE_SUB_SECTION}  ${sub_section}
    #   Title page should be 'sub_section' Builder
    Run keyword if  '${sub_section}' == 'List View'  Verify text contain  ${TITLE_PAGE_LABEL}  List View Builder
    Run keyword if  '${sub_section}' == 'Selected Job'  Verify text contain  ${TITLE_PAGE_LABEL}  Selected Job Builder
    #   Condition dropdown button
    Check element display on screen  ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    #   Verify buttons are displayed
    Check element display on screen  ${JOB_SEARCH_RESULTS_SAVE_BUTTON}
    Check element display on screen  ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
    Check element display on screen  ${JOB_SEARCH_RESULTS_REORDER_BUTTON}
    Check element display on screen  ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    #   Verify 'Included Fields' display as default
    Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    Job Title
    Check element display on screen  ${JOB_SEARCH_RESULTS_LOCKED_ICON}       Job Title
    Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    Job Location
    Check element display on screen  ${JOB_SEARCH_RESULTS_TRASH_ICON}        Job Location
    Run keyword if  '${sub_section}' == 'Selected Job'  Check element display on screen  ${JOB_SEARCH_RESULTS_TRASH_ICON}        Company Name
    Run keyword if  '${sub_section}' == 'Selected Job'  Check element display on screen  ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}        Company Name
    #   Verify 'Job Title' field is locked as default
    Check element display on screen  ${JOB_SEARCH_RESULTS_JOB_TITLE_FIELD_IS_LOCKED}
    #   Verify preview container by default
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}    Job Title
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}    Job Location
    Run keyword if  '${sub_section}' == 'Selected Job'  Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}   Company Name

Check list view displays correctly on job conversation
    [Arguments]     ${fields_list}
    Check element display on screen  ${CONVERSATION_LIST_VIEW_TABLE}
    Capture page screenshot
    FOR     ${field}    IN      @{fields_list}
        Check element display on screen  ${CONVERSATION_LIST_VIEW_FIELD}     ${field}
    END
    #   other fields have these types
    @{remain_fields_list} =     get_symmetric_difference_list   ${included_fields_list_by_locator}   ${fields_list}
    #   To check the remained fields which should not be displayed
    FOR     ${field}    IN      @{remain_fields_list}
        Element should not be visible  ${CONVERSATION_LIST_VIEW_FIELD}     ${field}
    END

Check selected job displays correctly on job conversation
    [Arguments]     ${fields_list}
    Capture page screenshot
    FOR     ${field}    IN      @{fields_list}
        Check element display on screen  ${CONVERSATION_SELECTED_JOB_FIELD}     ${field}
    END
    #   other fields have these types
    @{remain_fields_list} =     get_symmetric_difference_list   ${included_fields_list_by_locator}   ${fields_list}
    #   To check the remained fields which should not be displayed
    FOR     ${field}    IN      @{remain_fields_list}
        Element should not be visible  ${CONVERSATION_SELECTED_JOB_FIELD}     ${field}
    END

Check job posting page displays correctly on job conversation
    [Arguments]     ${fields_list}
    Capture page screenshot
    Check element display on screen   ${CONVERSATION_JOB_POSTING_JOB_TITLE}
    FOR     ${field}    IN      @{fields_list}
        Check element display on screen  ${CONVERSATION_JOB_POSTING_FIELD}     ${field}
    END
    #   other fields have these types
    @{default_fields_list} =    Create List    location    account    branch    company_name    employment_status    employment_type    facility_name    category    payrate
    @{remain_fields_list} =     get_symmetric_difference_list   ${default_fields_list}   ${fields_list}
    #   To check the remained fields which should not be displayed
    FOR     ${field}    IN      @{remain_fields_list}
        Element should not be visible  ${CONVERSATION_JOB_POSTING_FIELD}     ${field}
    END

Check job posting page displays correctly on job conversation by default
    Capture page screenshot
    Check element display on screen   ${CONVERSATION_JOB_POSTING_JOB_TITLE}
    Check element display on screen   ${CONVERSATION_JOB_POSTING_FIELD}     location
    #   To check the remained fields which should not be displayed
    @{remain_fields_list} =    Create List    account    branch    company_name    employment_status    employment_type    facility_name    category    payrate
    FOR     ${field}    IN      @{remain_fields_list}
        Element should not be visible  ${CONVERSATION_JOB_POSTING_FIELD}     ${field}
    END

Verify 'Condition Criteria' dialog design
    Open 'Condition Criteria' dialog
    Check element display on screen  ${CONDITION_CRITERIA_TITLE}   Condition Criteria
    Check element display on screen  ${CONDITION_CRITERIA_NAME_TEXTBOX}
    Check element display on screen  ${CONDITION_CRITERIA_CANCEL_BUTTON}
    Verify element is disable        ${CONDITION_CRITERIA_SAVE_BUTTON}
    Check element display on screen  ${CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN}
    Check element display on screen  ${CONDITION_CRITERIA_MATCHES_DROPDOWN}
    Check element display on screen  ${CONDITION_CRITERIA_INPUT_TEXTBOX}
    Check element display on screen  ${CONDITION_CRITERIA_AND_BUTTON}
    Check element display on screen  ${CONDITION_CRITERIA_OR_BUTTON}
    Check element display on screen  ${CONDITION_CRITERIA_X_BUTTON}
    Click at   ${CONDITION_CRITERIA_X_BUTTON}

Verify 'Reorder Fields' dialog design
    [Arguments]    ${third_field_name}
    Click at   ${JOB_SEARCH_RESULTS_REORDER_BUTTON}
    Check element display on screen  ${REORDER_FIELDS_TITLE}
    #   Job title and Job Location are default
    Check element display on screen  ${REORDER_FIELDS_FIRST_ITEM}   Job Title
    Check element display on screen  ${REORDER_FIELDS_SECOND_ITEM}   Job Location
    Check element display on screen  ${REORDER_FIELDS_THIRD_ITEM}   ${third_field_name}
    #   Check buttons
    Check element display on screen  ${REORDER_FIELDS_CANCEL_BUTTON}
    Check element display on screen  ${REORDER_FIELDS_X_BUTTON}
    Verify element is disabled by checking class       ${REORDER_FIELDS_SAVE_BUTTON}
    Click at   ${REORDER_FIELDS_X_BUTTON}

Verify Edit Condition dialog
    Click at   ${JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON}
    Check element display on screen  ${CONDITION_CRITERIA_TITLE}    Condition Criteria
    Check element display on screen  ${CONDITION_CRITERIA_CONDITION_ITEM_TITLE}    Default
    Check element display on screen  ${CONDITION_CRITERIA_ADD_CONDITION_BUTTON}
    Check element display on screen  ${EDIT_CONDITION_CRITERIA_CANCEL_BUTTON}
    Check element display on screen  ${CONDITION_CRITERIA_APPLY_BUTTON}
    Check element display on screen  ${CONDITION_CRITERIA_X_BUTTON}
    Click at   ${CONDITION_CRITERIA_X_BUTTON}

Select first job on list view - widget
    Check element display on screen  ${SHADOW_DOM_LIST_VIEW_TABLE}
    CLick at  ${SHADOW_DOM_FIRST_JOB_ON_LIST_VIEW}
    Check element display on screen  ${SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON}

Check selected job displays correctly on widget conversation
    [Arguments]     ${fields_list}
    Capture page screenshot
    FOR     ${field}    IN      @{fields_list}
        Check element display on screen  ${SHADOW_DOM_SELECTED_JOB_FIELD}     ${field}
    END
    #   other fields have these types
    @{remain_fields_list} =     get_symmetric_difference_list   ${included_fields_list_by_locator}   ${fields_list}
    #   To check the remained fields which should not be displayed
    FOR     ${field}    IN      @{remain_fields_list}
        Element should not be visible  ${SHADOW_DOM_SELECTED_JOB_FIELD}     ${field}
    END
