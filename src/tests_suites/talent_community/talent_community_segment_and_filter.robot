*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/talent_community_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        regression    test

Documentation       Run data test on src/data_tests/talent_community/add_group_and_location.robot, src/data_tests/talent_community/talent_community_segment_and_filter.robot file before run test

*** Variables ***
${user_name}            ${EE_TEAM}
@{status_incase}        Yes    No
@{candidate_names}      Candidate A For Interview    Candidate B For Interview

*** Test Cases ***
Check UI when click on Filter icon - Hire ON & Job OFF (OL-T10942)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Go to Talent Community page
    @{list_filter_title}=       Create list     Group       Location    Resume      Talent Community Stage      Scheduling status
    ...     Attendee Name       Scheduled by    Last contacted date     Contacted by    Recruiter phone number
    ...     Source      Start keyword
    Check Filter Your Talent Community Modal    @{list_filter_title}
    Capture page screenshot


Check UI when click on Filter icon - Hire OFF & Job OFF (OL-T10942)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Talent Community page
    @{list_filter_title}=       Create list     Group       Location    Resume      Talent Community Stage      Scheduling status       Attendee Name
    ...     Scheduled by    Last contacted date     Contacted by    Recruiter phone number      Referred by     Source      Start keyword
    Check Filter Your Talent Community Modal    @{list_filter_title}
    Capture page screenshot


Check UI when click on Filter icon - Hire ON & Job ON (OL-T10943)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    Go to Talent Community page
    @{list_filter_title}=       Create List     Job     Job Title       Req ID      Location    Resume      Talent Community Stage      Note Added By       Scheduling status
    ...     Attendee Name       Scheduled by    Last contacted date     Contacted by    Recruiter phone number      Referred by     Source      Start keyword
    Check Filter Your Talent Community Modal    @{list_filter_title}
    Capture page screenshot


Check the candidate number meets the filter (OL-T10946, OL-T10952, OL-T10992)
    Given Setup test
    When Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_OFF}
    Switch To User      ${EE_TEAM}
    Go to Talent Community page
    wait for page load successfully
    # Check the candidate number meets the Group (OL-T10946)
    Check the candidate number meets the Option By tab      ${TALENT_COMMUNITY_FILTER_GROUP}    ${TALENT_CANDIDATE_SELECT_GROUP_NAME}       Group A For talent      Candidate A For Gr_Location_Stt
    # Check the candidate number meets the Location (OL-T10952)
    Check the candidate number meets the Option By tab      ${TALENT_COMMUNITY_FILTER_LOCATION}     ${TALENT_COMMUNITY_FILTER_LOCATION_NAME}    Location A For talent       Candidate A For Gr_Location_Stt
    # Check the candidate number meets the Talent Community Journey Stage (OL-T10952)
    Check the candidate number meets the Option By tab      ${TALENT_COMMUNITY_FILTER_TALENT_COMMUNITY_STAGE}       ${TALENT_COMMUNITY_FILTER_SEARCH_SATUS_NAME}    Status A    Candidate A For Gr_Location_Stt
    # Check the User the data for the Talent Community Journey Stage (OL-T10961)
    wait for page load successfully
    Click on option by tab for Filter       ${TALENT_COMMUNITY_FILTER_TALENT_COMMUNITY_STAGE}
    @{stage_test}=      Create list     Capture     Scheduling      Rating      Custom
    FOR     ${stage_name}   IN   @{stage_test}
        Check span display      Default Talent Community Journey: ${stage_name}
    END
    capture page screenshot
    Click On [Cancel] Button And Check Close Model Filter


Check the candidate number meets the status incase select Yes or select No(OL-T10958 and OL-T10959)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    when Go To Talent Community Page
    Click at    All Candidates
    Wait For Page Load Successfully V1
    ${number_candidate_all}=    Get Text    ${TALENT_COMMUNITY_PAGE_NUMBER_CANDIDATE_HEADER_LABEL}
    # Check resume with status No and Yes
    FOR    ${status}     IN      @{status_incase}
        Click on option by tab for Filter       ${TALENT_COMMUNITY_FILTER_RESUME_BY_TAB}
        Check Text Display      Includes Resume
        Check Element Display On Screen     ${TALENT_COMMUNITY_FILTER_RESUME_CHECKBOX}      No
        Check Element Display On Screen     ${TALENT_COMMUNITY_FILTER_RESUME_CHECKBOX}      Yes
        Click At    ${TALENT_COMMUNITY_FILTER_RESUME_CHECKBOX}      ${status}
        Click On [Cancel] Button And Check Close Model Filter
        Click on option by tab for Filter       ${TALENT_COMMUNITY_FILTER_RESUME_BY_TAB}
        Click At    ${TALENT_COMMUNITY_FILTER_RESUME_CHECKBOX}      ${status}
        ${number_candidate_resume}=     Click on [Apply] button and Get candidate number after filter
        Check Display resume is available or Not available with status      ${status}       ${candidate_names}[1]       ${number_candidate_resume}
        ${segment_name}=    Create New Segment      segment_name=Segment_Resume
        Check Element Display On Screen     ${segment_name}
        Check Display resume is available or Not available with status      ${status}       ${candidate_names}[1]       ${number_candidate_resume}
        when Click at       All Candidates
        Wait For Page Load Successfully V1
        Check page show all candidate
        Delete Segment from talent community page       ${segment_name}
        Capture Page Screenshot
    END


Check the candidate number meets the Note Added By and Scheduling Status (OL-T10965 and OL-T10968)
    Given Setup test
    when Login Into System With Company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    # Check the candidate number meets the "Note Added By" (OL-T10965)
    when Go To Talent Community Page
    Check the candidate number meets the Option By tab no count     ${TALENT_COMMUNITY_FILTER_NOTE_BY_TAB}      ${TALENT_COMMUNITY_FILTER_USER_SELECT}      ${user_name}    @{candidate_names}
    Capture Page Screenshot
    # Check the candidate number meets the " Scheduling Status" (OL-T10968)
    when Go To Talent Community Page
    Check the candidate number meets the Option By tab no count     ${TALENT_COMMUNITY_FILTER_SCHEDULED_STATUS_BY_TAB}      ${TALENT_COMMUNITY_FILTER_SCHEDULED_STATUS_SELECT}      Interview Scheduled     @{candidate_names}
    Capture Page Screenshot


Check the candidate number meets the Attendee Name (OL-T10971, OL-T10974, OL-T10980)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    @{candidates}=      Create List     Candidate A For Interview       Candidate B For Interview
    Go to Talent Community page
    Check the candidate number meets the Option By tab no count     ${TALENT_COMMUNITY_FILTER_ATTENDEE_BY}      ${TALENT_COMMUNITY_FILTER_USER_CHECK_BOX}       ${EE_TEAM}      @{candidates}
    #   Check the candidate number meets the Scheduled by  (OL-T10974)
    Check the candidate number meets the Option By tab no count     ${TALENT_COMMUNITY_FILTER_SCHEDULED_BY}     ${TALENT_COMMUNITY_FILTER_USER_CHECK_BOX}       ${EE_TEAM}      @{candidates}
    #   Check the candidate number meets the Contacted By (OL-T10980)
    Check the candidate number meets the Option By tab no count     ${TALENT_COMMUNITY_FILTER_CONTACTED_BY}     ${TALENT_COMMUNITY_FILTER_USER_CHECK_BOX}       ${EE_TEAM}      @{candidates}


Check the candidate number meets the Start Keyword (OL-T10995)
    Given Setup test
    when Login into system with company     ${PARADOX_ADMIN}    ${COMPANY_HIRE_ON}
    @{candidates}=      Create List     Candidatea Startkeyword     Candidateb Startkeyword
    Go to Talent Community page
    Check the candidate number meets the Option By tab no count     ${TALENT_COMMUNITY_FILTER_START_KEYWORD}    ${TALENT_COMMUNITY_FILTER_USER_CHECK_BOX}       new     @{candidates}
    Click On [Cancel] Button And Check Close Model Filter
