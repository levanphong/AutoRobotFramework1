*** Settings ***
Resource            ../../pages/candidate_summary_builder_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Force Tags          lts_stg    regression

Documentation    COMPANY_LOCATION_MAPPING_OFF: go to Candidate Summary, add Custom Section, title:Street Address, name field: Street Address, data field: Street Address

*** Variables ***
${candidate_summary}                        Candidate Summary
${add_field_to_start_text}                  Add a field to this section to get started.
${screen_questions_for_candidate_text}      Screening Questions for each candidate will show on the summary here.
${description_text}                         This information will appear in the About tab of the Candidate Profile.
${custom_section}                           Custom Section
${insert_section_title}                     Insert section title
${street_address}                           Street Address
${street_address_2}                         Street Address 2
${city}                                     City
${personal_information}                     Personal Information

*** Test Cases ***
Check adding Custom section (OL-T11399)
    Intial and go to Candidate Sumary   ${COMPANY_FRANCHISE_ON}
    Click at   ${CANDIDATE_SUMMARY_ADD_SECTION_BUTTON}
    Click at   ${CANDIDATE_SUMMARY_ADD_SECTION_ITEM}    ${custom_section}
    Check UI when has only 1 custom section


Check All sections with fields (Personal Information & Custom sections) will have an arrow next to the title in the navigation. (OL-T11418)
    Intial and go to Candidate Sumary   ${COMPANY_FRANCHISE_ON}
    Add a section   ${personal_information}
    Check UI of persional information section


Check adding other section, edit title and delete section (OL-T11409, OL-T11411, OL-T11412)
    Intial and go to Candidate Sumary   ${COMPANY_FRANCHISE_ON}
    Add a section   ${personal_information}
    Add a section   ${custom_section}
    Delete a section    2
    Simulate Input  ${CANDIDATE_SUMMARY_TITLE_TEXTBOX}   New Name    ${personal_information}
    Save and confirm save
    Delete a section    1
    Save and confirm save


Check adding another field (OL-T11402)
    Intial and go to Candidate Sumary   ${COMPANY_LOCATION_MAPPING_OFF}
    Click at   ${CANDIDATE_SUMMARY_ADD_FIELD_BUTTON}    1
    Click at   ${ADD_FIELD_DATA_DROPDOWN}
    Input into   ${ADD_FIELD_DATA_SEARCH_TEXTBOX}  ${street_address}
    Check element display on screen   ${ADD_FIELD_DATA_DISABLED_ITEM}   ${street_address}
    Input into   ${ADD_FIELD_DATA_SEARCH_TEXTBOX}  ${city}
    Click at   ${ADD_FIELD_DATA_ITEM}   ${city}
    Click at   ${ADD_FIELD_SAVE_BUTTON}


Check editing field (OL-T11405)
    Intial and go to Candidate Sumary   ${COMPANY_LOCATION_MAPPING_OFF}
    Edit a field    ${street_address_2}     ${city}
    Verify text contain  ${CANDIDATE_SUMMARY_FIELD_TITLE}  ${street_address_2}
    Check element display on screen  ${CANDIDATE_SUMMARY_FIELD_ATTRIBUTE_VALUE}  city


Check able to select the attribute that has been already used in another section (OL-T11407)
    Intial and go to Candidate Sumary   ${COMPANY_LOCATION_MAPPING_OFF}
    Add a section   ${custom_section}
    Add a field   ${street_address_2}     ${street_address}   2

*** Keywords ***
Check UI when has only 1 custom section
    Check element display on screen  ${CANDIDATE_SUMMARY_TITLE}
    Check element display on screen  ${description_text}
    Check element display on screen  ${CANDIDATE_SUMMARY_PREVIEW_BUTTON}
    Check element display on screen  ${CANDIDATE_SUMMARY_SAVE_BUTTON}
    Check element display on screen  ${CANDIDATE_SUMMARY_ADD_SECTION_BUTTON_1}
    Check element display on screen  ${CANDIDATE_SUMMARY_ADD_SECTION_BUTTON_2}
    Check element display on screen  ${CANDIDATE_SUMMARY_TITLE_TEXTBOX}     ${insert_section_title}
    Check element display on screen  ${add_field_to_start_text}
    Check element display on screen  ${CANDIDATE_SUMMARY_ADD_FIELD_BUTTON}   1

Intial and go to Candidate Sumary
    [Arguments]   ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go to Candidate Summary

Check UI of persional information section
    Click at   ${CANDIDATE_SUMMARY_SECTION_EXPAND_ICON}     ${personal_information}
    # Check Items display
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   First Name
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Last Name
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Phone Number
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Email Address
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Street Address (Line 1)
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Street Address (Line 2)
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   City
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   State
    Check element display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   ZIP Code
    #   Check items are not clickable
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   First Name
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Last Name
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Phone Number
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Email Address
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Street Address (Line 1)
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Street Address (Line 2)
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   City
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   State
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    Click at  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   ZIP Code
    Check element not display on screen  ${ADD_FIELD_NAME_TEXTBOX}   wait_time=1s
    #   Close expand then check items disapear
    Click at   ${CANDIDATE_SUMMARY_SECTION_EXPAND_ICON}     ${personal_information}
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   First Name
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Last Name
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Phone Number
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Email Address
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Street Address (Line 1)
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   Street Address (Line 2)
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   City
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   State
    Check element not display on screen  ${CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM}   ZIP Code
