*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/candidate_summary_builder_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../commons/actions/get_actions.robot
Resource            ../../pages/forms_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test
Documentation       Run data test src/data_tests/cem_candidate_management/candidate_summary_personal_information_data_test.robot

*** Variable ***
&{information}                      phone_number=+14808945616    address=420 Nguyen Huu Tho    city=Da Nang    state=Arizona    zip_code=85043
${job_name}                         OL-T11528_Automation_Test
@{personal_information_fields}      First Name    Last Name    Phone Number    Email Address    Street Address (Line 1)    City    State    ZIP Code

*** Test Cases ***
Verify if Personal information seciton hasn't been configured at the builder (OL-T11527)
    # The persional information section hasn't been configured at the Candidate summary builder
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Candidate Summary
    ${is_display}=      run keyword and return status       Check element not display on screen     Personal Information
    IF      '${is_display}'=='False'
        Delete a section with name      Personal Information
    END
    capture page screenshot
    Go to CEM page
    Check element not display on screen     Personal Information
    capture page screenshot


Verify show data at the personal information section (OL-T11528)
    Given Setup test
    Login into system with company      ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    &{info}=    Get link to apply job and filling form
    @{window} =     get window handles
    switch window       ${window}[0]
    Go to CEM page
    Search and click candidate on CEM       ${info.candidate_first_name}
    ${fname}=       Convert To Title Case       ${info.candidate_first_name}
    Check text display      Personal Information
    capture page screenshot
    Click on span text      Personal Information
    Check UI of Personal Information section    ${fname}    Lname       ${info.email}

*** Keywords ***
Get link to apply job and filling form
    ${link_job}=        Search job and get internal job link    ${job_name}
    &{info}=     Start a conversation apply job with internal link job       ${link_job}
    Reply a screening question      ${REPROMPT_AGE_MESSAGE_1}       20
    ${is_display}=      run keyword and return status       Check Message Widget Site Response Correct      ${EVENT_CONTACT_QUESTION}
    IF      '${is_display}'=='True'
        Click on option in conversation    Email Only
        Wait Until Element Is Not Visible     ${SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON}
    END
    Get link and Filling form       ${info.email}       ${info.candidate_first_name}        ${COMPANY_FRANCHISE_ON}
    [Return]    &{info}

Check UI of Personal Information section
    [Arguments]     ${fname}    ${lname}    ${email}
    FOR     ${I}    IN      @{personal_information_fields}
        Check element display on screen     ${CEM_CANDIDATE_SUMMARY_PERSONAL_INFORMATION_ITEM}      ${I}
    END
    capture page screenshot
    @{personal_information_fields_value}=   create list     ${fname}   ${lname}      ${information.phone_number}    ${email}   ${information.address}     ${information.city}    ${information.state}   ${information.zip_code}
    FOR     ${I}    IN      @{personal_information_fields_value}
        Check element display on screen     ${CEM_CANDIDATE_SUMMARY_PERSONAL_INFORMATION_FIELD}      ${I}
    END
    capture page screenshot
