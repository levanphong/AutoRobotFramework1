*** Settings ***
Resource        ../pages/base_page.robot
Resource        ../pages/conversation_page.robot
Variables       ../locators/talent_community_locators.py
Resource        ../pages/message_customize_page.robot

*** Keywords ***
Add a Candidate to Talent Community
    [Arguments]     ${email}=None   ${candidate_name_random}=${EMPTY}
    Click at  ${TALENT_COMMUNITY_PAGE_ADD_CANDIDATE_BUTTON}
    ${length_candidate_name}=  Get Length    ${candidate_name_random}
    IF  '${length_candidate_name}' == '0'
        &{candidate_name_random}=  Generate candidate name
    END

    IF  '${email}' == 'None'
        ${email} =      Generate random name  ${CONST_EMAIL}
    END
    Input into    ${TALENT_CANDIDATE_FIRST_NAME_TEXT_BOX}   ${candidate_name_random.first_name}
    Input into    ${TALENT_CANDIDATE_LAST_NAME_TEXT_BOX}    ${candidate_name_random.last_name}
    Input into    ${TALENT_CANDIDATE_EMAIL_TEXT_BOX}    ${email}
    Click at    ${TALENT_CANDIDATE_ADD_CANDIDATE_BUTTON}
    [Return]    &{candidate_name_random}

Add a Candidate has location and group to Talent Community
    [Arguments]     ${email}=None   ${candidate_first_name_random}=None   ${candidate_last_name_random}=None    ${location}= None   ${group}=None
    Click at  ${TALENT_COMMUNITY_PAGE_ADD_CANDIDATE_BUTTON}
    IF  '${candidate_first_name_random}' == 'None'
        ${candidate_first_name_random} =    Generate random name only text    Fname
    END
    IF  '${candidate_last_name_random}' == 'None'
        ${candidate_last_name_random} =    Set Variable    Lname
    END
    Input into    ${TALENT_CANDIDATE_FIRST_NAME_TEXT_BOX}    ${candidate_first_name_random}
    Input into    ${TALENT_CANDIDATE_LAST_NAME_TEXT_BOX}    ${candidate_last_name_random}
    IF  '${email}' == 'None'
        ${email} =      Generate random name  ${CONST_EMAIL}
    END
    IF  '${location}' != 'None'
        Click at    ${TALENT_CANDIDATE_ADD_LOCATION_DROPDOWN }
        Input into  ${TALENT_CANDIDATE_ADD_LOCATION_SEARCH}     ${location}
        ${lacation_name}=   Format string    ${TALENT_CANDIDATE_SELECT_LOCATION}       ${location}
        Click at   ${lacation_name}
    END
    IF  '${group}' != 'None'
        Click at    ${TALENT_CANDIDATE_ADD_GROUP_DROPDOWN}
        Input into  ${TALENT_CANDIDATE_ADD_GROUP_SEARCH}    ${group}
        ${group_name}=    Format string  ${TALENT_CANDIDATE_SELECT_GROUP}   ${group}
        Click at    ${group_name}
    END
    Input into    ${TALENT_CANDIDATE_EMAIL_TEXT_BOX}    ${email}
    Click at    ${TALENT_CANDIDATE_ADD_CANDIDATE_BUTTON}
    [Return]    ${candidate_first_name_random}

Verify Left Panel Display Titles and Count Numbers
    [Arguments]    ${left_panel_titles}
    @{titles}=  Get WebElements    ${TALENT_COMMUNITY_LEFT_PANEL_TITLES}
    @{title_list}=  Create List
    FOR     ${title}   IN  @{titles}
        ${title_text}=     Get Text        ${title}
        Append To List  ${title_list}   ${title_text}
    END
    FOR     ${title_text}   IN  @{left_panel_titles}
        Check Element Existed In List    ${title_text}      ${title_list}
    END
    @{counter_list} =  Get WebElements    ${TALENT_COMMUNITY_LEFT_PANEL_COUNT_LIST}
    ${titles_length} =  Get Length    ${titles}
    ${counter_list_length} =  Get Length    ${counterlist}
    Should Be Equal As Integers    ${counter_list_length}   ${titles_length}

Verify Element Display on Left Panel
    [Arguments]    ${left_panel_titles}
    Verify Display Text    ${TALENT_COMMUNITY_PAGE_TITLE}  Talent Community
    Verify Left Panel Display Titles and Count Numbers    ${left_panel_titles}

Check column name displayed
    [Arguments]     @{column_value}
    ${columns} =    Get WebElements     ${TALENT_COMMUNITY_PAGE_COLUMN_TEXT}
    FOR    ${column}    IN    @{columns}
        Should Contain Match    ${column_value}      ${column.text}
    END

Verify Element Display on Right Panel
    [Arguments]    @{columns}
    Check Element Display On Screen    ${TALENT_COMMUNITY_PAGE_ADD_CANDIDATE_BUTTON}
    Check Element Display On Screen    ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX}
    Check Label Display     Candidates
    Check column name displayed   @{columns}

Check UI for All Candidates talent community is display
    [Arguments]     @{column_value}
    Click at    All Candidates
    Check column name displayed   @{column_value}
    Check label display      0 Candidates
    Check Element Display On Screen    ${TALENT_COMMUNITY_PAGE_ADD_CANDIDATE_BUTTON }
    Check Element Display On Screen    ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX }

Check canditate number is display
    ${candidate_list} =      Get WebElements    ${TALENT_COMMUNITY_TABLE_ROW_NAME}
    ${candidate_number} =   Get Length  ${candidate_list}
    ${candidate_number_title} =  Get Text     ${TALENT_COMMUNITY_PAGE_CANDIDATE_NUMBER}
    ${candidate_number_test} =    Convert To String   ${candidate_number}
    Should Contain  ${candidate_number_title}    ${candidate_number_test}
    Check label display      ${candidate_number} Candidates

Check load data successfully when scroll down
    ${candidate_number_title} =  Get Text     ${TALENT_COMMUNITY_PAGE_CANDIDATE_NUMBER}
    Scroll To Bottom Of Table    ${TALENT_COMMUNITY_PAGE_TABLE}     ${LOADING_ICON_3}
    wait for page load successfully
    Check canditate number is display
    Capture page screenshot

Check UI for All Candidates talent community is display when has data
    [Arguments]     @{column_value}
    Click at    All Candidates
    Check column name displayed   @{column_value}
    Check load data successfully when scroll down
    Check Element Display On Screen    ${TALENT_COMMUNITY_PAGE_ADD_CANDIDATE_BUTTON }
    Check Element Display On Screen    ${TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX }

Check show slide out Candidate Profile
    ${candidate_name} =     Get WebElement      ${TALENT_COMMUNITY_PAGE_FIRST_ROW_NAME}
    Click at    ${candidate_name.text}
    Check span display  Candidate Profile
    Capture page screenshot

Check Filter Your Talent Community Modal
    [Arguments]   @{list_filter_title}
    Click at    ${TALENT_COMMUNITY_PAGE_FILTER_ICON}
    FOR     ${filter_title}   IN      @{list_filter_title}
        Check span display  ${filter_title}
     END
    Check element display on screen     ${TALENT_COMMUNITY_FILTER_APPLY_BUTTON}
    Check element display on screen     ${TALENT_COMMUNITY_FILTER_CLOSE_MODAL_ICON}
    Check element display on screen     ${TALENT_COMMUNITY_FILTER_CANCEL_BUTTON}
    Capture page screenshot

Click on option by tab for Filter
    [Arguments]    ${option_by_tab}
    Click at           All Candidates
    Click At    ${TALENT_COMMUNITY_FILTER_CANDIDATE_BUTTON}
    Click At    ${option_by_tab}

Check page just show candidate match filter
    [Arguments]    ${candidate_name}     ${number_candidate}=1
    Check Label Display    ${number_candidate}
    ${number_candidate}=     Split String     ${number_candidate}  ${SPACE}
    Check number of element is correctly    ${TALENT_CANDIDATE_PAGE_TABLE_ROW}   ${number_candidate}[0]
    Run keyword and ignore error    Input Into      ${TALENT_CANDIDATE_PAGE_SEARCH}     ${candidate_name}
    Check Span Display    ${candidate_name}
    Capture page screenshot

Click on [Cancel] button and check close model Filter
	Click At     ${TALENT_COMMUNITY_FILTER_CANCEL_BUTTON}
	Check Element Not Display On Screen    Filter Your Talent Community
	Capture page screenshot

Add New Media to resume of Candidate
    [Arguments]     ${media_type}   ${file_name}
    IF  '${media_type}' == 'Image/GIF'
        ${image_path} =    get_path_upload_image_path   ${file_name}
        ${element} =    Get Webelement    ${TALENT_COMMUNITY_ADD_RESUME_INPUT}
        EXECUTE JAVASCRIPT
        ...    arguments[0].setAttribute('style','visibility: visible; position: absolute; bottom: 0px; left: 0px; height: 100px; width: 100px;');
        ...    ARGUMENTS    ${element}
        Input into    ${TALENT_COMMUNITY_ADD_RESUME_INPUT}    ${image_path}
        wait for page load successfully v1
    END

Add a Candidate to Talent Community and add resume
    ${candidate_name}=   Add A Candidate To Talent Community
    Click At    ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name}
    Add New Media To Resume Of Candidate       Image/GIF               cat-kute
    [Return]    ${candidate_name}

Click on [Apply] button and Get candidate number after filter
	${number_candidate}=     Get Text    ${TALENT_COMMUNITY_FILTER_COUNT_CANDIDATE}
	${number_candidate}=     Split String     ${number_candidate}  ${SPACE}
	IF  '${number_candidate}[0]' == 'No'
	    ${number_candidate}=     Set Variable       0 Candidates
	ELSE IF     '${number_candidate}[0]' == '1'
	     ${number_candidate}=    Set Variable    1 Candidate
	ELSE
	    ${number_candidate}=    Set Variable    ${number_candidate}[0] Candidates
	END
    Click At    ${TALENT_COMMUNITY_FILTER_APPLY_BUTTON}
	[Return]    ${number_candidate}

Check Display resume is available or Not available with status
    [Arguments]    ${status}    ${candidate_name}     ${number_candidate_resume}
    IF  '${status}' == 'Yes'
        Check page just show candidate match filter     ${candidate_name}   ${number_candidate_resume}
    ELSE IF    '${status}' =='No'
        Check Label Display    ${number_candidate_resume}
        Run keyword and ignore error    Input Into      ${TALENT_CANDIDATE_PAGE_SEARCH}     ${candidate_name}
        Check Element Not Display On Screen        ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name}    wait_time=5s
    END

Ckeck count of candidate when filtering
    [Arguments]     ${option_by_tab}       ${option_select}     ${option_select_name}
    Scroll To Bottom Of Table    ${TALENT_COMMUNITY_PAGE_TABLE}     ${LOADING_ICON_3}
    ${candidate_list} =    Format string    ${TALENT_COMMUNITY_PAGE_COLUMN_NAME}    ${option_select_name}
    ${candidate_number}=    Get WebElements     ${candidate_list}
    ${candidate}=   Get Length  ${candidate_number}
    ${str_count} =  Set Variable         ${candidate} candidate match
    Click on option by tab for Filter   ${option_by_tab}
    wait for page load successfully
    Check the Checkbox      ${option_select}    ${option_select_name}
    ${text} =   Get Text    ${TALENT_COMMUNITY_FILTER_CANDIDATE}
    wait for page load successfully
    Should be equal as strings   ${str_count}     ${text}
    Capture page screenshot

Check Display segment model
    Check Span Display    New Segment
    Check Label Display    Segment name
    Check Element Display On Screen    ${TALENT_COMMUNITY_SEGMENT_NAME_INPUT}
    Capture Page Screenshot

Create new segment
    [Arguments]    ${segment_name}
    Hover at    ${TALENT_COMMUNITY_FILTER_CANDIDATE_BUTTON}
    Click at    ${TALENT_COMMUNITY_FILTER_ADD_SEGMENT_BUTTON}
    ${segment_name}=    Generate Random Name    ${segment_name}
    Input Into  ${TALENT_COMMUNITY_SEGMENT_NAME_INPUT}  ${segment_name}
    Click At    ${TALENT_COMMUNITY_SEGMENT_SAVE_BUTTON}
    [Return]    ${segment_name}

Check the candidate number in page All Candidate
    ${candidate_elements}=    Get Webelements    ${TALENT_COMMUNITY_PAGE_TABLE_ROW}
    ${candidate_numbers}=   Get Length    ${candidate_elements}
    [Return]    ${candidate_numbers}

Delete Segment from talent community page
    [Arguments]    ${segment_name}
    Click At    ${TALENT_COMMUNITY_SEGMENT_SELECT_OPTION_BUTTON}    ${segment_name}
    Click At    ${TALENT_COMMUNITY_SEGMENT_DELETE_SELECT}
    Click At    ${TALENT_COMMUNITY_SEGMENT_DELETE_BUTTON}

check Diplay profile of candidate
    [Arguments]    @{candidate_names}
    FOR  ${candidate_name}   IN     @{candidate_names}
        Check Element Display On Screen     ${TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME}    ${candidate_name}
    END
    Capture Page Screenshot

Check page show all candidate
    Click at    All Candidates
    wait for page load successfully
    Check load data successfully when scroll down
    Capture page screenshot

Search And Select User for Filter
    [Arguments]     ${option_select}      ${option_select_name}
    ${is_existed}=  Run Keyword And Return Status       Check Element Display On Screen    ${TALENT_COMMUNITY_FILTER_SEARCH_USER_TEXT_BOX}
    IF   '${is_existed}' == 'True'
        Input Into  ${TALENT_COMMUNITY_FILTER_SEARCH_USER_TEXT_BOX}     ${option_select_name}
    END
    Check the Checkbox      ${option_select}    ${option_select_name}

Check the candidate number meets the Option By tab
    [Arguments]        ${option_by_tab}       ${option_select_filter}    ${option_select_name}      ${candidate_name}
    Ckeck count of candidate when filtering    ${option_by_tab}    ${option_select_filter}      ${option_select_name}
    Click on [Cancel] button and check close model Filter
    wait for page load successfully
    Ckeck count of candidate when filtering   ${option_by_tab}    ${option_select_filter}      ${option_select_name}
    Click at    ${TALENT_COMMUNITY_FILTER_APPLY_BUTTON }
    Check page just show candidate match filter       ${candidate_name}
    Capture page screenshot
    ${segment_name}=   Create new segment    segment_name=Segment_Note
    Check Element Display On Screen    ${segment_name}
    Check page just show candidate match filter       ${candidate_name}
    Check page show all candidate
    Delete Segment from talent community page   ${segment_name}

Check the candidate number meets the Option By tab no count
    [Arguments]     ${option_by_tab}       ${option_select_filter}    ${option_select_name}     @{candidate_names}
    Click at           All Candidates
    Wait For Page Load Successfully V1
    ${number_candidate_all}=   Get Text    ${TALENT_COMMUNITY_PAGE_NUMBER_CANDIDATE_HEADER_LABEL}
    Click on option by tab for Filter   ${option_by_tab}
    Search And Select User for Filter      ${option_select_filter}    ${option_select_name}
	Click on [Cancel] button and check close model Filter
    Click on option by tab for Filter   ${option_by_tab}
    Search And Select User for Filter      ${option_select_filter}    ${option_select_name}
    ${number_candidate}=     Click on [Apply] button and Get candidate number after filter
    ${candidate_name}=     Set Variable        ${candidate_names}[0]
    Check page just show candidate match filter       candidate_name=${candidate_name}    number_candidate=${number_candidate}
    ${segment_name}=    Create new segment     segment_name=Segment_Note
    Check Element Display On Screen    ${segment_name}
    Check page just show candidate match filter       ${candidate_name}    ${number_candidate}
    when Click at           All Candidates
    Wait For Page Load Successfully V1
    Scroll To Bottom Of Table    ${TALENT_COMMUNITY_PAGE_TABLE}     ${LOADING_ICON_3}
    check Diplay profile of candidate       @{candidate_names}
    Check page show all candidate
    Delete Segment from talent community page    ${segment_name}

