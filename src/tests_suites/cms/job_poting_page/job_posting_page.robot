*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/client_setup_page.robot
Resource            ../../../pages/cms_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          skip    test
# TODO: effect conversation

*** Variables ***
${job_location}                 Job Location
${company_name}                 Company Name
${job_title}                    Job Title
${job_posting_page}             Job Posting Page
${job_category}                 Job Category
${css_property}                 cursor
${expected_strings}             auto
@{list_fields_name_modal}       Job Location    Job Category    Pay Rate    Facility Name    Company Name    Brand    Account    Employment Status    Employment Type
@{list_targeting_rule}          Job Title    Job City    Job State    Job Country    Job Category
@{list_matches}                 Exactly matches    Does not exactly match    Contains    Does not contain    Starts with    Does not start with    Ends with    Does not end with

*** Test Cases ***
Verify The default fields of default page at Job posting page tab (OL-T25239, OL-T25240)
    ${condition_title} =    Login then create new condition at job posting page tab
    Check element display on screen     ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${job_title}
    Check element display on screen     ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${job_location}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_TITLE_FIELD_IS_LOCKED}
    check element display on screen     ${JOB_SEARCH_RESULTS_LOCKED_ICON}
    Delete condition(s)     ${condition_title}


Verify adding 6 fields at Job posting page tab (OL-T25241, OL-T25242)
    ${condition_title} =    Login then create new condition at job posting page tab
    @{fields_list} =    create list     Pay Rate    Job Category    Facility Name
    Click at    ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Check list fields modal for Job posting page builder
    Click at    ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Add field in Job Search Results     ${fields_list}      ${job_posting_page}
    Add field in Job Search Results     ${company_name}     ${job_posting_page}
    Check element not display on screen     ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Remove field(s)     ${fields_list}
    Remove field(s)     ${company_name}
    Check element display on screen     ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Delete condition(s)     ${condition_title}


Verify editing field at Job posting page tab (OL-T25243)
    ${condition_title} =    Login then create new condition at job posting page tab
    Click at    ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${job_location}
    Check list fields modal for Job posting page builder
    Check element display on screen     ${JOB_SEARCH_RESULTS_SELECT_FIELD_DROPDOWN_CHECK_ICON}      ${job_location}
    Check element display on screen     ${JOB_SEARCH_RESULTS_DISABLED_FIELD_ITEM}       ${job_title}
    Click at    ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${job_location}
    Edit field in Job Search Results    ${job_location}     ${company_name}
    Delete condition(s)     ${condition_title}


Verify Builder Previews of Default fields at Job posting page tab (OL-T25245, OL-T25246, OL-T25247, OL-T25248)
    ${condition_title} =    Login then create new condition at job posting page tab
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM}      ${job_title}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM}      ${job_location}
    Verify css property as strings      ${css_property}     ${expected_strings}     ${PREVIEW_BUILDER_ITEM_TITLE}       ${job_title}
    Verify css property as strings      ${css_property}     ${expected_strings}     ${PREVIEW_BUILDER_ITEM_TITLE}       ${job_location}
    Add field in Job Search Results     ${company_name}     ${job_posting_page}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM}      ${company_name}
    Remove field(s)     ${company_name}
    Check element not display on screen     ${JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM}      ${company_name}
    Edit field in Job Search Results    ${job_location}     ${job_category}
    Check element not display on screen     ${JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM}      ${job_location}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM}      ${job_category}
    Delete condition(s)     ${condition_title}


Verify adding new condition at Job posting page tab (OL-T25250, OL-T25251)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job search results builder page
    Click at    ${NAV_SUB_MENU_TEXT}    ${job_posting_page}
    CLick at    ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Click at    ${JOB_SEARCH_RESULTS_ADD_CONDITION_BUTTON}
    wait for page load successfully v1
    Check Condition Criteria modal
    Click at    ${CONDITION_CRITERIA_CLOSE_ICON}
    ${condition_title} =    Add new condition then select it
    Delete condition(s)     ${condition_title}


Verify adding multiple conditional statements per criteria in the builder (OL-T25252, OL-T25253)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to job search results builder page
    Click at    ${NAV_SUB_MENU_TEXT}    ${job_posting_page}
    ${condition_title} =    Add new multiple condition statements
    Delete condition(s)     ${condition_title}


Verify editing condition Job posting page tab (OL-T25254)
    ${condition_title} =    Login then create new condition at job posting page tab
    ${new_condition}=       Edit condition and select it    ${condition_title}
    Delete condition(s)     ${new_condition}


Verify adding multiple conditions at Job posting page tab (OL-T25255, OL-T25256, OL-T25257, OL-T25258)
    ${first_condition_title}=       Login then create new condition at job posting page tab
    ${second_condition_title}=      Add new condition then select it
    ${third_condition_title}=       Add new condition then select it
    Select condition on job search results      ${second_condition_title}
    Select condition on job search results      ${third_condition_title}
    Click at    ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Click at    ${JOB_SEARCH_RESULTS_CONDITION_SEARCH_ERASE_ICON}
    wait for page load successfully v1
    Check element display on screen     ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${first_condition_title}
    Check element display on screen     ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${second_condition_title}
    Check element display on screen     ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${third_condition_title}
    Click at    ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${second_condition_title}
    Click at    ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Check element display on screen     ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${first_condition_title}
    Check element display on screen     ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${second_condition_title}
    Check element display on screen     ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM}       ${third_condition_title}
    @{condition_list}=      Create list     ${first_condition_title}    ${second_condition_title}       ${third_condition_title}
    Delete condition(s)     ${condition_list}

*** Keywords ***
Login then create new condition at job posting page tab
    Given Setup test
    when Login into system with company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    Go to job search results builder page
    Click at                ${NAV_SUB_MENU_TEXT}    ${job_posting_page}
    ${condition_title} =    Add new condition then select it
    [Return]    ${condition_title}

Check list fields modal for Job posting page builder
    FOR     ${field_name}  IN  @{list_fields_name_modal}
        Check element display on screen                 ${JOB_SEARCH_RESULTS_FIELD_ITEM}                ${field_name}
    END

Check Condition Criteria modal
    Check element display on screen                 ${CONDITION_CRITERIA_NAME_TEXTBOX}
    Click at    ${CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN}
    FOR     ${field_name}  IN  @{list_targeting_rule}
        Check element display on screen                 ${CONDITION_CRITERIA_DROPDOWN_ITEM}                ${field_name}
    END
    Click at    ${CONDITION_CRITERIA_MATCHES_DROPDOWN}
    FOR     ${field_name}  IN  @{list_matches}
        Check element display on screen                 ${CONDITION_CRITERIA_DROPDOWN_ITEM}                ${field_name}
    END
    Check element display on screen         ${CONDITION_CRITERIA_INPUT_TEXTBOX}
    Element should be disabled              ${CONDITION_CRITERIA_SAVE_BUTTON}
