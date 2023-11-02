*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/jobs_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

Force Tags          lts_stg    regression

*** Variables ***
${fitler_location}                      Location
${fitler_job_title}                     Job Title
${fitler_data_packages}                 Job Data Packages
${fitler_job_status}                    Job Status
${filter_brand}                         Brand Name
${fitler_job_id}                        Job ID
${fitler_job_type}                      Job Type
&{job_status}                           published=Published    draft=Draft    archived=Archived    unpublished_changes=Unpublished Changes    active=Active
${rgba_color}                           rgba(238, 238, 238, 1)
${filter_title}                         What type of jobs do you want to see?
${no_location_found}                    No Locations Found
${job_data_package_test}                Test_job_data_package_base_pay
${job_data_packages_test}               Test_job_data_package_has_4_attributes
${job_type_legacy_multi_job}            Legacy Multi Location Job
${job_type_multi_job}                   Multi Location Job
${job_type_legacy_multi_job_card}       Basic Multi-Location Job
${job_title_artist_test}                artist
${job_title_auto_job_test}              auto job template_3hD8jmY
${job_id_test}                          PDX_TAHOC_2CCE5F4E-07E4-4892-8299-4A6724179A33
${job_id__data_test}                    PDX_TAHOC_8826F36D-F3CD-446E-A21E-2C369A2FFD32
${job_brand_test}                       New brand test
${job_brand_automation_hire_test}       Test Automation Hire On Company
&{job_location}                         remote=Remote    company=Nguyen Huu Tho

*** Test Cases ***
Verify UI of Filter dialog (OL-T29445, OL-T29446, OL-T29447, OL-T29448, OL-T29456)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Check displaying of [Filter] button on the jobs page(T29445)
    Verify value of element's attribute     class       icon-filter     ${JOB_PAGE_FILTER_BUTTON}
    # Verify UI of [Filter] popup (T29446)
    Open fitlering dialog
    Check element display on screen     ${filter_title}
    # Check filtering unsucessfully incase no selected value at all label (T29447)
    Verify element is disable       ${JOB_PAGE_FILTER_APPLY_BUTTON}
    # Check displaying of [Apply] button incase have at least a selected value into filter (T29448)
    Check the checkbox      ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      ${job_location.remote}
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
    # Check acting of [Apply] button (T29456)
    Check filter label after filtering      ${fitler_location}      ${job_location.remote}
    #    Check when filter already select at least one, Apply button is still disabled
    Open fitlering dialog
    Verify element is disable       ${JOB_PAGE_FILTER_APPLY_BUTTON}


Check acting of [Cancel] button (OL-T29455, OL-T29452, OL-T29458, OL-T29459, OL-T29457)
    Initial and open job filter dialog
    # Check displaying of selceted label (T29452)
    # Check displaying of [Job Status] label on filter popup (T29458)
    Open fitlering dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    Verify css property as strings      background-color    ${rgba_color}       ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    Verify attribute value equal    ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       placeholder     Search for a stage or status
    # Check acting of [Cancel] button (T29455)
    Check the checkbox      ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.published}
    Click at    ${JOB_PAGE_FILTER_CANCEL_BUTTON}
    ${filter_label_locator} =       Format String       ${JOBS_FILTERING_LABEL}     ${fitler_job_status}    ${job_status.published}
    Check element not display on screen     ${filter_label_locator}
    # Check acting of [Close popup] icon (T29457)
    Open fitlering dialog
    Click at    ${JOB_PAGE_FILTER_X_BUTTON}
    Check element not display on screen     ${filter_title}


Verify data loading correctly and sufficiently at [Job Status] checkbox (OL-T29459, OL-T29461, OL-T29463, OL-T29464, OL-T29465, OL-T29462, OL-T29467)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    # Check searching unsucessfully incase keywords isn't matching data at [Job Status] checkbox (T29465)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_status.active}
    Element Should Not Be Visible       ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${EMPTY}
    # Check displaying of [Job Status] label when searching (T29459)
    # Check searching sucessfully incase keywords matching data at [Job Status] checkbox (T29463)
    # Check searching sucessfully incase keywords includes uppercase and lowercase letters matching data at [Job Status] checkbox (T29464)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_status.draft}
    Element Should Not Be Visible       ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.archived}
    Element Should Not Be Visible       ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.unpublished_changes}
    Element Should Not Be Visible       ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.published}
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       DRAFT
    # Check displaying of [Job Status] label when searching (T29459)
    Check the checkbox      ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.draft}
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
    Verify all of displayed jobs are correctly      ${job_status.draft}     0


Check searching unsuccessfully incase input special character into Job Type textbox (OL-T29509, OL-T29494, OL-T29578, OL-T29495, OL-T29497, OL-T29501, OL-T29499, OL-T29500, OL-T29501, OL-T29505, OL-T29510, OL-T29502, OL-T29504, OL-T29506)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_type}
    Verify Element Is Disable       ${JOB_PAGE_FILTER_APPLY_BUTTON}
    # Check searching unsuccessfully incase input isn't matching data at [Job Type] checkbox (T29501,T29502)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      *@!%
    # Check searching unsucessfully incase input html_tag into [Search] textbox (T29504)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <div><div/>
    Check element not display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      <div><div/>
    # Check searching successfully no matter capitalize character to [Search] textbox (T29500)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_type_multi_job.lower()}
    Check element display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_type_multi_job}
    # Check searching successfully incase keywords matching data at [Job Type] checkbox (T29499)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_type_legacy_multi_job}
    Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_type_legacy_multi_job}
    #Check filtering successfully incase no selected value at [Job Type]checkbox but have selected value at other label (T29505)
    Confirm Apply Job Filter By Other Label     ${fitler_data_packages}
    Check filter label after filtering      ${fitler_job_type}      ${job_type_legacy_multi_job}  #(T29506)
    Verify all of displayed jobs are correctly      ${job_type_legacy_multi_job_card}       1


Check searching unsuccessfully incase input special character into Job Title textbox (OL-T29523, OL-T29526, OL-T29519, OL-T29517, OL-T29516, OL-T29518, OL-T29512, OL-T29522, OL-T29579,OL-T29511, OL-T29514, OL-T29521)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_title}
    # Check searching unsuccessfully incase input special character into [Search] textbox (T29519)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      *@!%
    # Check searching unsucessfully incase input html_tag into [Search] textbox (T29521)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <div><div/>
    Check element not display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      <div><div/>
    # Check searching successfully isn't matching data to [Search] textbox (T29518)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_type_legacy_multi_job}
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_type_legacy_multi_job}
    # Check searching successfully no matter capitalize character or not to [Search] textbox (T29517)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_title_artist_test.capitalize()}
    Check element display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_title_artist_test}
    #Check searching successfully incase keywords matching data at [Job Title] checkbox (T29516)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_title_artist_test}
    Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_title_artist_test}
    #Check filtering sucessfully incase no selected value at [Job Title] checkbox but have selected value at other label (T29522)
    Confirm Apply Job Filter By Other Label     ${fitler_job_id}
    Check filter label after filtering      ${fitler_job_title}     ${job_title_artist_test}
    Verify all of displayed jobs are correctly      ${job_title_artist_test}    0


Check job filter when using Brand filter textbox (OL-T29535, OL-T29537, OL-T29534, OL-T29533, OL-T29532, OL-T29528, OL-T29527, OL-T29539, OL-T29579, OL-T29538, OL-T29542, OL-T29530, OL-T29583)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${filter_brand}
    # Check searching unsuccessfully incase input special character into [Search] textbox (T29535)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      *@!%
    # Check searching unsucessfully incase input html_tag into [Search] textbox (T29537)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <div><div/>
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      <div><div/>
    # Check searching successfully isn't matching data to [Search] textbox (T29534)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_title_artist_test}
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_title_artist_test}
    # Check searching successfully no matter capitalize character or not to [Search] textbox (T29533)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_brand_test.lower()}
    Check element display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_brand_test}
    #Check searching successfully incase keywords matching data at [Brand] checkbox (T29532)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_brand_test}
    Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_brand_test}
    #Check filtering sucessfully incase no selected value at [Brand] checkbox but have selected value at other label (T29538)
    Confirm Apply Job Filter By Other Label     ${fitler_data_packages}
    Check filter label after filtering      ${filter_brand}     ${job_brand_test}
    Verify all of displayed jobs are correctly      ${job_brand_test}       1


Check filtering sucessfully incase add more parameters at checkbox into filter (OL-T29507, OL-T29524, OL-T29574, OL-T29540, OL-T29574, OL-T29488, OL-T29557)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    Open filter dialog then select and check verify label after filtering       ${fitler_job_type}      ${job_type_legacy_multi_job}    ${job_type_multi_job}
    Click at    ${JOB_FILTER_CLEAR_BUTTON}
    Open filter dialog then select and check verify label after filtering       ${fitler_job_title}     ${job_title_auto_job_test}      ${job_title_artist_test}
    Click at    ${JOB_FILTER_CLEAR_BUTTON}
    Open filter dialog then select and check verify label after filtering       ${fitler_job_id}    ${job_id_test}      ${job_id_data_test}
    Click at    ${JOB_FILTER_CLEAR_BUTTON}
    Open filter dialog then select and check verify label after filtering       ${filter_brand}     ${job_brand_test}       ${job_brand_automation_hire_test}
    Click at    ${JOB_FILTER_CLEAR_BUTTON}
    Open filter dialog then select and check verify label after filtering       ${fitler_location}      ${job_location.remote}      ${job_location.company}
    Click At    ${JOB_FILTER_CLEAR_BUTTON}
    Open filter dialog then select and check verify label after filtering       ${fitler_data_packages}     ${job_data_packages_test}       ${job_data_package_test}


Check job filter when using Job Data Packages textbox (OL-T295559, OL-T29544, OL-T29545, OL-T29556, OL-T29555, OL-T29550, OL-T29549, OL-T29554, OL-T29552, OL-T29551, OL-T29547)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_data_packages}
    # Check searching unsuccessfully incase input special character into [Search] textbox (T29552)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      *@!%
    # Check searching unsucessfully incase input html_tag into [Search] textbox (T29554)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <div><div/>
    Check element not display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      <div><div/>
    #Check searching successfully isn't matching data to [Search] textbox (T29551)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_type_legacy_multi_job}
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_type_legacy_multi_job}
    #Check searching successfully no matter capitalize character or not to [Search] textbox (T29550)
    Simulate Input      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_data_packages_test.lower()}
    Check element display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_data_packages_test}
    # Check searching successfully incase keywords matching data at [Job Data Packages] checkbox (T29549)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_data_packages_test}
    Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_data_packages_test}
    #Check filtering sucessfully incase no selected value at [Job Data Packages] checkbox but have selected value at other label (T29555)
    Confirm Apply Job Filter By Other Label     ${fitler_job_title}
    Check filter label after filtering      ${fitler_data_packages}     ${job_data_packages_test}


Check job filter when using Job ID textbox (OL-T29569, OL-T29571, OL-T29568, OL-T29576, OL-T29561, OL-T29562, OL-T29573, OL-T29567, OL-T29572, OL-T29566, OL-T29564, OL-T29565)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_id}
    # Check searching unsuccessfully incase input special character into [Search] textbox (T29569)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      *@!%
    # Check searching unsucessfully incase input html_tag into [Search] textbox (T29571)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <div><div/>
    Check element not display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      <div><div/>
    # Check searching successfully isn't matching data to [Search] textbox (T29568)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_type_legacy_multi_job_card}
    Check element not display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_type_legacy_multi_job_card}
    #Check searching successfully no matter capitalize character or not to [Search] textbox (T29550)
    Simulate Input      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_id_test.lower()}
    Check element display on screen     ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_id_test}
    # Check searching successfully incase keywords matching data at [Job ID] checkbox (T29505)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_id_test}
    Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${job_id_test}
    # Check filtering sucessfully incase no selected value at [Job ID] checkbox but have selected value at other label (T29572)
    Confirm Apply Job Filter By Other Label     ${fitler_job_type}
    Check filter label after filtering      ${fitler_job_id}    ${job_id_test[0:10]}


Check searching unsucessfully incase input speciel character into [Job status] textbox (OL-T29466, OL-T29468, OL-T29469, OL-T29475, OL-T29476, OL-T29478)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    # Check searching unsucessfully incase input speciel character into [Search] textbox (T29466)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%
    Check element not display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      *@!%
    # Check searching unsucessfully incase input html_tag into [Search] textbox (T29468)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <div><div/>
    Check element not display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      <div><div/>
    # Check filtering sucessfully incase no selected value at [Job Status] checkbox but have selected value at other label (T29469)
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_location}
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_location.remote}
    Check the checkbox      ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      ${job_location.remote}
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
    Check filter label after filtering      ${fitler_location}      ${job_location.remote}


Check searching unsucessfully incase input speciel character into [Location] textbox (OL-T29480, OL-T29483, OL-T29484, OL-T29485, OL-T29486, OL-T29491)
    Initial and open job filter dialog
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       *@!%&
    Verify text contain     ${JOB_PAGE_FILTER_NO_LOCATION_FOUND_LABEL}      ${no_location_found}
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       <span><span/>
    Verify text contain     ${JOB_PAGE_FILTER_NO_LOCATION_FOUND_LABEL}      ${no_location_found}
    # Check filtering sucessfully incase no selected value at [Location] checkbox but have selected value at other label (T29486)
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_status.archived}
    Check the checkbox      ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.archived}
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_location}
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
    Check filter label after filtering      ${fitler_job_status}    ${job_status.archived}


Check filtering sucessfully incase add a value at Job Status checkbox into filter (OL-T29470, OL-T29473)
    Initial and open job filter dialog
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${fitler_job_status}
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       ${job_status.published}
    Check the checkbox      ${JOB_PAGE_FILTER_AREA_VALUE_CHECKBOX}      ${job_status.published}
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
    # Check displaying applied values of [Job Status] on the filter (T29473)
    Check filter label after filtering      ${fitler_job_status}    ${job_status.published}
    Verify all of displayed jobs are correctly      ${job_status.published}     0


Check searching sucessfully incase keywords includes uppercase and lowercase letters matching data at [Location] checkbox (OL-T29481, OL-T29482)
    Initial and open job filter dialog
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       rEmOtE
    Check element display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      ${job_location.remote}
    # Check searching unsucessfully incase keywords isn't matching data at [Location] checkbox (T29482)
    Input into      ${JOB_PAGE_FILTER_SEARCH_TEXTBOX}       invalid location
    Check element display on screen     ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      invalid location
    Verify text contain     ${JOB_PAGE_FILTER_NO_LOCATION_FOUND_LABEL}      ${no_location_found}
    Check the checkbox      ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      ${job_location.remote}


Check counting of selected brand on the filter popup (OL-T29832, OL-T29827, OL-T29543)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Get total jobs of Default job family
    ${job_family_info} =    Get text and format text    ${JOB_FAMILY_INFO_AT_MAIN}      ${JF_COFFEE_FAMILY_JOB}
    ${total_jobs} =     extract_numbers     ${job_family_info}
    # Apply a filter
    Apply a filter for jobs     Brand Name      ${COMPANY_HIRE_ON}
    # Jobs selected can't be less than total jobs in Default job family
    ${selected_jobs} =      Get text and format text    ${JOB_FILTER_SELECTED_NUMBER}
    ${selected_jobs_number} =       extract_numbers     ${selected_jobs}
    ${assert} =     Evaluate    ${total_jobs}[0] <= ${selected_jobs_number}[0]
    Run Keyword Unless      ${assert}       Fail


Check counting selected Job Data Packages on the filter popup (OL-T29833)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Get total jobs of Default job family
    ${job_family_info} =    Get text and format text    ${JOB_FAMILY_INFO_AT_MAIN}      ${JF_COFFEE_FAMILY_JOB}
    ${total_jobs} =     extract_numbers     ${job_family_info}
    # Apply a filter
    Apply a filter for jobs     ${fitler_data_packages}     ${job_data_package_test}
    # Jobs selected must be less than total jobs in Default job family
    ${selected_jobs} =      Get text and format text    ${JOB_FILTER_SELECTED_NUMBER}
    ${selected_jobs_number} =       extract_numbers     ${selected_jobs}
    ${assert} =     Evaluate    ${total_jobs}[0] >= ${selected_jobs_number}[0]
    Run Keyword Unless      ${assert}       Fail


Check counting selected Job ID on the filter popup (OL-T29834)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Apply a filter
    Apply a filter for jobs     ${fitler_job_id}    ${EMPTY}
    # There is only 1 job selected by ID
    ${selected_jobs} =      Get text and format text    ${JOB_FILTER_SELECTED_NUMBER}
    ${selected_jobs_number} =       extract_numbers     ${selected_jobs}
    ${assert} =     Evaluate    ${selected_jobs_number}[0] == 1
    Run Keyword Unless      ${assert}       Fail


Check counting selected Job status on the filter popup (OL-T29835)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Apply a filter
    Apply a filter for jobs     ${fitler_job_status}    ${job_status.published}
    # There are no other status display
    Click at    ${JF_COFFEE_FAMILY_JOB}
    Job Should not has status       ${job_status.draft}
    Job Should not has status       ${job_status.archived}
    Job Should not has status       ${job_status.unpublished_changes}


Check counting selected job title on the filter popup (OL-T29831)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Apply a filter
    Apply a filter for jobs     ${fitler_job_title}     ${EMPTY}
    # There is only 1 job selected by Title
    ${selected_jobs} =      Get text and format text    ${JOB_FILTER_SELECTED_NUMBER}
    ${selected_jobs_number} =       extract_numbers     ${selected_jobs}
    ${assert} =     Evaluate    ${selected_jobs_number}[0] == 1
    Run Keyword Unless      ${assert}       Fail


Check counting selected job types on the filter popup (OL-T29830)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Get total jobs of Default job family
    ${job_family_info} =    Get text and format text    ${JOB_FAMILY_INFO_AT_MAIN}      ${JF_COFFEE_FAMILY_JOB}
    ${total_jobs} =     extract_numbers     ${job_family_info}
    # Apply a filter
    Apply a filter for jobs     ${fitler_job_type}      Legacy Multi Location Job
    # Jobs selected can't be less than total jobs in Default job family
    ${selected_jobs} =      Get text and format text    ${JOB_FILTER_SELECTED_NUMBER}
    ${selected_jobs_number} =       extract_numbers     ${selected_jobs}
    ${assert} =     Evaluate    ${total_jobs}[0] <= ${selected_jobs_number}[0]
    Run Keyword Unless      ${assert}       Fail


Check counting selected locations on the filter popup (OL-T29829)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Get total jobs of Default job family
    ${job_family_info} =    Get text and format text    ${JOB_FAMILY_INFO_AT_MAIN}      ${JF_COFFEE_FAMILY_JOB}
    ${total_jobs} =     extract_numbers     ${job_family_info}
    # Apply a filter
    Apply a filter for jobs     ${fitler_location}      ${LOCATION_STREET_TRUNG_NU_VUONG}
    # Jobs selected must be less than total jobs in Default job family
    ${selected_jobs} =      Get text and format text    ${JOB_FILTER_SELECTED_NUMBER}
    ${selected_jobs_number} =       extract_numbers     ${selected_jobs}
    ${assert} =     Evaluate    ${total_jobs}[0] >= ${selected_jobs_number}[0]
    Run Keyword Unless      ${assert}       Fail


Check deleting parameters at filter result incase only a parameters are selected at filte (OL-T29593)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Apply a filter
    Apply a filter for jobs     ${fitler_location}      ${LOCATION_STREET_TRUNG_NU_VUONG}
    Check element display on screen     ${JOB_FILTER_SELECTED_NUMBER}
    Capture Page Screenshot
    # Clear the filter
    Click at    ${JOB_FILTER_CLEAR_BUTTON}
    Check element not display on screen     ${JOB_FILTER_SELECTED_NUMBER}
    Capture Page Screenshot


Check deleting parameters at filter result incase multiple parameters are selected at filter (OL-T29592)
    Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    # Apply a filter
    Apply a filter for jobs     ${fitler_location}      ${LOCATION_STREET_TRUNG_NU_VUONG}
    Apply a filter for jobs     ${fitler_job_type}      Legacy Multi Location Job
    Check element display on screen     ${JOB_FILTER_SELECTED_NUMBER}
    Capture Page Screenshot
    # Clear 1 filter and check other filter still exist
    Click at    ${JOB_FILTER_CLEAR_BUTTON}
    Check element display on screen     ${JOB_FILTER_SELECTED_NUMBER}
    Capture Page Screenshot

*** Keywords ***
Check filter label after filtering
    [Arguments]    ${filter_field}    ${filter_value}
    ${filter_label_locator} =  Format String    ${JOBS_FILTERING_LABEL}    ${filter_field}    ${filter_value}
    Check element display on screen    ${filter_label_locator}

Initial and open job filter dialog
    Setup test
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Jobs page
    Open fitlering dialog

Open fitlering dialog
    Click at    ${JOB_PAGE_FILTER_BUTTON}
    #    To wait filtering dialog full loading
    Check element display on screen    ${JOB_PAGE_FILTER_LOADING_FILTER_LABEL}    wait_time=5s
    Run Keyword And Ignore Error    Check element not display on screen    ${JOB_PAGE_FILTER_LOADING_FILTER_LABEL}

Apply a filter for jobs
    [Arguments]    ${filter_type}    ${filter_value}
    Click at    ${JOB_PAGE_FILTER_BUTTON}
    Click at    ${filter_type}
    IF    "${filter_type}" == "${fitler_location}"
        Click at    ${JOB_PAGE_FILTER_ITEMS_LOCATION}    ${filter_value}
    ELSE
        Click at    ${JOB_PAGE_FILTER_VALUE_TEXTBOX}    ${filter_value}
    END
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
    Wait with short time    # Need to wait for apply new fitler. This is the only way
    Capture Page Screenshot

Job Should not has status
    [Arguments]    ${status}
    Check element not display on screen    ${JOB_BASIC_INFO_DISPLAY_AT_MAIN}    ${status}

Verify all of displayed jobs are correctly
    [Arguments]    ${status}  ${type}  ${job_family_name}=${JF_COFFEE_FAMILY_JOB}
    Wait For Page Load Successfully V1
    ${total_jobs} =  Extract number from locator text    ${JOBS_PAGE_TOTAL_JOBS_TEXT}    ${job_family_name}
    IF    ${total_jobs} != 0
        IF  ${type}==1
            ${first_job_locator} =  Format String    ${JOBS_PAGE_JOB_CHECK_BY_INDEX_DIV}    1    ${status}
        ELSE
            ${first_job_locator} =  Format String    ${JOBS_PAGE_JOB_CHECK_BY_INDEX_SPAN}    1    ${status}
        END
        Click at    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${JF_COFFEE_FAMILY_JOB}
        Wait For Loading Icon Disappear
        IF      ${total_jobs} >= 5
            Scroll To Bottom1        ${first_job_locator}    ${total_jobs}
        END
        FOR    ${index}    IN RANGE    1    ${total_jobs} + 1
            IF  ${type}==1
                ${job_locator} =   Format String    ${JOBS_PAGE_JOB_CHECK_BY_INDEX_DIV}     ${index}    ${status}
            ELSE
                ${job_locator} =   Format String    ${JOBS_PAGE_JOB_CHECK_BY_INDEX_SPAN}     ${index}    ${status}
            END
            Check element display on screen    ${job_locator}
        END
    ELSE
        Check element not display on screen    ${JOB_FAMILY_CHEVRON_DOWN_ICON}    ${job_family_name}
    END
    Capture Page Screenshot
    Wait with short time

Confirm Apply Job Filter By Other Label
    [Arguments]    ${filter_type}
    Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${filter_type}
    Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}

Scroll to bottom1
    [Arguments]     ${target_locator}   ${total_row}
    #   To focus into target tab or page
    Hover At       ${target_locator}
    #   Scroll down
    FOR    ${index}    IN RANGE    0    ${total_row}    20
        Press Keys   None  END
        wait for page load successfully v1
    END

Apply multi checkbox and verify label after filtering
	[Arguments]		${filter_field}		${first_filter}	 ${second_filter}
	IF  '${filter_field}' == '${fitler_location}'
		Check the checkbox      ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      ${first_filter}
		Check the checkbox      ${JOB_PAGE_FILTER_LOCATION_FIELD_CHECKBOX}      ${second_filter}
	ELSE
		Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${first_filter}
		Check the checkbox      ${JOB_PAGE_FILTER_TYPE_FIELD_CHECKBOX}      ${second_filter}
	END
	Click at    ${JOB_PAGE_FILTER_APPLY_BUTTON}
	${element_len}=  Get Length    ${first_filter}
	IF    ${element_len} >40
		${first_filter} =	Set Variable    	${first_filter[0:40]}
	END
	#First Element displays
	${filter_label_text}=	Catenate  	SEPARATOR=   ${first_filter}	, +1...
    ${filter_label_locator} =  Format String    ${JOBS_FILTERING_LABEL}    ${filter_field}    ${filter_label_text}
    Check element display on screen    ${filter_label_locator}

Open filter dialog then select and check verify label after filtering
	[Arguments]		${filter_field}		${first_filter}	 ${second_filter}
	Click at    ${JOB_PAGE_FILTER_BUTTON}
	Run Keyword And Ignore Error    Check element not display on screen    ${JOB_PAGE_FILTER_LOADING_FILTER_LABEL}
	Click at    ${JOB_PAGE_FILTER_ITEMS_LABEL}      ${filter_field}
    Apply Multi Checkbox And Verify Label After Filtering	 ${filter_field}		${first_filter}		${second_filter}
