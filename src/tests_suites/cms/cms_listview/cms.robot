*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/cms_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          skip    test
# TODO: effect conversation

*** Variables ***
${company_name}     Company Name
${job_location}     Job Location
${job_title}        Job Title
${brand}            Brand

*** Test Cases ***
Verify The default fields of new condition page at List View tab (OL-T25220, OL-T25218, OL-T25219, OL-T25230)
    Login to Franchise on company and go to the List View Tab
    ${condition_title} =    Add new condition then select it
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_TITLE_FIELD_IS_LOCKED}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_LOCATOR}       ${job_location}
    Check element display on screen     ${JOB_SEARCH_RESULTS_LOCKED_ICON}
    Delete condition(s)     ${condition_title}


Verify adding 3 fields at List View tab (OL-T25221)
    Login to Franchise on company and go to the List View Tab
    Add field in Job Search Results     ${company_name}
    Check element not display on screen     ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}
    Check element display on screen     ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${company_name}


Verify deleting field at List View tab (OL-T25222)
    Login to Franchise on company and go to the List View Tab
    Add field in Job Search Results     ${company_name}
    Remove field(s)     ${job_location}
    Check element not display on screen     ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${job_location}
    Check element display on screen     ${JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON}


Verify editing field at List View tab (OL-T25223)
    Login to Franchise on company and go to the List View Tab
    Edit field in Job Search Results    ${job_location}     ${company_name}
    Check element display on screen     ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${company_name}
    Check element not display on screen     ${JOB_SEARCH_RESULTS_INCLUDED_FIELD}    ${job_location}


Verify Builder Previews of Default fields at List View tab (OL-T25225, OL-T25226, OL-T25227)
    Login to Franchise on company and go to the List View Tab
    Verify Builder Previews when adding field
    Remove field(s)     ${company_name}
    Check element not display on screen     ${PREVIEW_BUILDER_ITEM_TITLE}       ${company_name}


Verify Builder Previews when editing fields at List View tab (OL-T25228)
    Login to Franchise on company and go to the List View Tab
    Verify Builder Previews when adding field
    Edit field in Job Search Results    ${company_name}     ${brand}
    Check element not display on screen     ${PREVIEW_BUILDER_ITEM_TITLE}       ${company_name}
    Check element display on screen     ${PREVIEW_BUILDER_ITEM_TITLE}       ${brand}
    Remove field(s)     ${brand}
    Check element not display on screen     ${PREVIEW_BUILDER_ITEM_TITLE}       ${brand}


Verify saving new condition without filling in all fields at List View tab (OL-T25231)
    Login to Franchise on company and go to the List View Tab
    CLick at    ${JOB_SEARCH_RESULTS_CONDITION_DROPDOWN}
    Click at    ${JOB_SEARCH_RESULTS_ADD_CONDITION_BUTTON}
    wait for page load successfully v1
    Verify element is disable       ${CONDITION_CRITERIA_SAVE_BUTTON}


Verify adding multiple conditional statements per criteria in the builder (OL-T25232)
    Login to Franchise on company and go to the List View Tab
    ${condition_title} =    Add new multiple condition statements
    Delete condition(s)     ${condition_title}


Verify editing conditionat List View tab (OL-T25234)
    Login to Franchise on company and go to the List View Tab
    ${condition_title} =    Add new condition then select it
    ${new_condition} =      Edit condition and select it    ${condition_title}
    Delete condition(s)     ${new_condition}


Verify switching among conditions at List View tab (OL-T25236, OL-T25235, OL-T25233, OL-T25237)
    Login to Franchise on company and go to the List View Tab
    ${condition_title_1}=       Add new condition then select it
    wait for page load successfully v1
    ${condition_title_2} =      Add new condition then select it    check_condition     Job Title       Contains    Auto
    Adding field and check new condition    ${condition_title_2}
    Select condition on job search results      ${condition_title_1}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_TITLE_FIELD_IS_LOCKED}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_LOCATOR}       ${job_location}
    Check element display on screen     ${JOB_SEARCH_RESULTS_DELETE_ICON}
    Select condition on job search results      ${condition_title_2}
    Delete condition(s)     ${condition_title_1}
    Delete condition(s)     ${condition_title_2}


Verify adding custom fields at another condition page (OL-T25238)
    Login to Franchise on company and go to the List View Tab
    ${condition_title} =    Add new condition then select it
    Add field in Job Search Results     ${brand}
    Delete condition(s)     ${condition_title}

*** Keywords ***
Login to Franchise on company and go to the List View Tab
    Given Setup test
    When Login into system with company             ${PARADOX_ADMIN}             ${COMPANY_FRANCHISE_ON}
    Go to job search results builder page
    Check element display on screen     ${JOB_SEARCH_RESULTS_LISTVIEW_BUILDER_PAGE}
    Click at    ${JOB_SEARCH_RESULTS_LISTVIEW_BUTTON}

Verify Builder Previews when adding field
    Check element display on screen  ${JOB_SEARCH_RESULTS_PREVIEW_CONTAINER}
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}      ${job_title}
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}       ${job_location}
    Page Should Contain Element      ${PREVIEW_BUILDER_CONTAINER_JOB_ITEM_TITLE}     limit=3
    Add field in Job Search Results     ${company_name}
    Check element display on screen  ${PREVIEW_BUILDER_ITEM_TITLE}       ${company_name}

Adding field and check new condition
    [Arguments]  ${condition_title}
    Edit field in Job Search Results        ${job_location}         ${company_name}
    Add field in Job Search Results         ${brand}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_TITLE_FIELD_IS_LOCKED}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_LOCATOR}   ${company_name}
    Check element display on screen     ${JOB_SEARCH_RESULTS_JOB_LOCATOR}   ${brand}
    Check element display on screen     ${JOB_SEARCH_RESULTS_DELETE_ICON}
