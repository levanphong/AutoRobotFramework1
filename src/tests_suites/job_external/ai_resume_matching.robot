*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/conversation_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    dev    fedex    lowes    lts_stg    mchire    olivia    pepsi    regression    stg    uniliver    test

*** Variables ***
&{widget_dic}               job_search=UploadResumeWidget    hire_on=UploadResumeHireON    capture_convo=UploadResumeCaptureConvo
&{pdf_dic}                  full_info_file=sujata_abbott.pdf    full_info_file2=john_paul_full_inf.pdf    no_info_file=sujata_abbott_no_inf.pdf    invalid_info_file=sujata_abbott_invalid_inf.pdf
...                         suggest_jobs_file=sabrinadzouza_suggest_jobs.pdf    no_match_file=samiraheaton_no_match.pdf    wrong_format_file=wrong_format.pdf
${file_path}                resources/pdf_files
# Candidate's information are showed on Resume PDF
&{candidate_info}           name=SUJATA    fullname=SUJATA ABBOTT    email=hanh+resume@paradox.ai    city=San Jose    phone_number=(602) 902-6951
...                         experience=12 years    worked_position=Manager    worked_place=V.K Clean Machine Incorporated
&{candidate_info2}          name=Sabrina    fullname=Sabrina Dozuaza    email=sabrina242@gmail.com    city=Peoria    phone_number=none
...                         experience=5 years    worked_position=Technical Services Manager - Help Desk    worked_place=Make-A-Wish America
&{candidate_info3}          name=Samirah    fullname=Samirah Eaton    email=samira1143@gmail.com    city=Fort Lauderdale    phone_number=5557000971
...                         experience=3 months    worked_position=Walmart Stocker    worked_place=Walmart
&{candidate_info4}          name=John    fullname=John Paul    email=job_paul@paradox.ai    city=San Jose    phone_number=(602) 902-4546
...                         experience=8 years    worked_position=Manager    worked_place=V.K Clean Machine Incorporated

# Company: COMPANY_APPLICANT_FLOW
# More > Turn on AI Resume Matching
# Create a widget name:UploadResumeWidget, turn on job search > turn on AI Resume Matching
# Create a widget name:UploadResumeCaptureConvo, turn on job search, select convo:Multi Applicant Convo(name,email,phone,address) > turn on AI Resume Matching
# Company: Hire ON
# More > Turn on AI Resume Matching
# Security and compliance > Turn GDPR: global
# Create a widget name:UploadResumeHireON, turn on job search > turn on AI Resume Matching
*** Test Cases ***
Verify Resume is uploaded successfully and Olivia should pull jobs that are more related to the resume uploaded and show those correct jobs at the top of the list (OL-T28238, OL-T28239)
    [Tags]   skip
    #TODO: https://paradoxai.atlassian.net/browse/OL-78125
    Initial and go to widget site then upload resume    ${pdf_dic.full_info_file}    ${widget_dic.job_search}
    Verify css property as strings    cursor    pointer    ${SHADOW_DOM_UPLOADED_RESUME_VIEW_BUTTON}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_info.name}    ${candidate_info.experience}    ${candidate_info.worked_position}    ${candidate_info.worked_place}
    check message widget site response correct    ${candidate_info_msg} ${ONE_JOB_FOUND}
    Apply the first job on widget
    Input text for widget site    ${HI}
    #    move over questions which ask about name, phone, email, address, because they already are in Resume
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}    Widget Conversation
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Open a candidate Conversation    ${candidate_info.fullname}
    Verify candidate's information on CEM    ${AUTOMATION_TESTER_TITLE_071}    ${candidate_info.email}    ${candidate_info.city}    ${candidate_info.phone_number}
    

Verify job search conversation journey that set at apply to chat after uploading resume missing candidate's information (OL-T28240, OL-T28241, OL-T28242, OL-T28243, OL-T28244, OL-T28245)
    Initial and go to widget site then upload resume    ${pdf_dic.no_info_file}    ${widget_dic.job_search}
    Verify AI message when asking about name in    Widget Conversation
    ${candidate_name} =      Generate candidate name
    Input text for widget site    ${candidate_name.full_name}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_name.first_name}    ${candidate_info.experience}    ${candidate_info.worked_position}    ${candidate_info.worked_place}  
    check message widget site response correct    ${candidate_info_msg} ${ONE_JOB_FOUND}
    Apply the first job on widget
    Input text for widget site    ${HI}
    ${email} =   Candidate input neccessary information
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Open a candidate Conversation    ${candidate_name.full_name}
    Verify candidate's information on CEM    ${AUTOMATION_TESTER_TITLE_071}    ${email}    ${candidate_info.city}    ${CONST_PHONE_NUMBER}


Verify job search conversation journey that set at apply to chat after uploading resume have invalid candidate's information (OL-T28246, OL-T28247)
    Initial and go to widget site then upload resume    ${pdf_dic.invalid_info_file}    ${widget_dic.job_search}
    Verify AI message when asking about name in    Widget Conversation
    ${candidate_name} =      Generate candidate name
    Input text for widget site    ${candidate_name.full_name}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_name.first_name}    ${candidate_info.experience}    ${candidate_info.worked_position}    ${candidate_info.worked_place}  
    Verify AI latest message using regexp    ${candidate_info_msg} ${NO_JOB_FOUND}    site_type=Widget Conversation
    Input text for widget site    ${ANY_WHERE}
    Apply the first job on widget    total_job_search=3
    Input text for widget site    ${HI}
    ${email} =   Candidate input neccessary information
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Open a candidate Conversation    ${candidate_name.full_name}
    Verify candidate's information on CEM    ${AUTOMATION_TESTER_TITLE_071}    ${email}    ${candidate_info.city}    ${CONST_PHONE_NUMBER}


Check view candidate's resume After their upload resume (OL-T28256)
    Initial and go to widget site then upload resume    ${pdf_dic.no_match_file}    ${widget_dic.job_search}
    Wait for Olivia reply on widget
    Verify css property as strings    cursor    pointer    ${SHADOW_DOM_UPLOADED_RESUME_VIEW_BUTTON}
    Click at   ${SHADOW_DOM_UPLOADED_RESUME_VIEW_BUTTON}
    Wait with medium time
    Capture Page Screenshot
    ${window} =  Get Window Handles
    Switch window           ${window}[1]


Checking No Results Found when candidate's position that want to apply not match feeds in system (OL-T28248)
    Initial and go to widget site then upload resume    ${pdf_dic.no_match_file}    ${widget_dic.job_search}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_info3.name}    ${candidate_info3.experience}    ${candidate_info3.worked_position}    ${candidate_info3.worked_place} 
    Verify AI latest message using regexp    ${candidate_info_msg} ${NO_JOB_FOUND}    site_type=Widget Conversation


Checking suggest jobs when candidate's position that want to apply not match feeds in system (OL-T30690)
    Initial and go to widget site then upload resume    ${pdf_dic.suggest_jobs_file}    ${widget_dic.job_search}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_info2.name}    ${candidate_info2.experience}    ${candidate_info2.worked_position}    ${candidate_info2.worked_place} 
    check message widget site response correct    ${candidate_info_msg} ${GREAT_JOB_FOUND_BUT_NOT_INRANGE}


Verify job search conversation when turn ON GDPR / CCPA and Turn ON AI resume matching (OL-T28257)
    Setup test
    ${site_url} =   Get widget conversation link    ${widget_dic.hire_on}
    Go to widget site  ${site_url}
    #    To open convo box
    Click at   ${INPUT_WIDGET}
    Click at    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    Wait Until Element Is Not Visible    ${SHADOW_DOM_GDPR_ACCEPT_BUTTON}
    Wait for Olivia reply on widget
    ${absolute_path} =  Get Absolute Path    ${file_path}    ${pdf_dic.no_match_file}
    Upload resume on widget    ${absolute_path}    ${pdf_dic.no_match_file}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_info3.name}    ${candidate_info3.experience}    ${candidate_info3.worked_position}    ${candidate_info3.worked_place}   
    Verify AI latest message using regexp    ${candidate_info_msg} ${NO_JOB_FOUND}    site_type=Widget Conversation


Verify capture conversation journey that set at apply to chat after uploading resume successfully (OL-T28249)
    [Tags]    skip
    # TODO: https://paradoxai.atlassian.net/browse/OL-78128
    Initial and go to widget site then upload resume    ${pdf_dic.full_info_file2}    ${widget_dic.capture_convo}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_info4.name}    ${candidate_info4.experience}    ${candidate_info4.worked_position}    ${candidate_info4.worked_place}  
    check message widget site response correct    ${candidate_info_msg} ${ONE_JOB_FOUND}
    Apply the first job on widget
    Input text for widget site    ${HI}
    #    move over questions which ask about name, phone, email, address, because they already are in Resume
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}    Widget Conversation
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Open a candidate Conversation    ${candidate_info4.fullname}
    Verify candidate's information on CEM    ${AUTOMATION_TESTER_TITLE_071}    ${candidate_info.email}    ${candidate_info.city}    ${candidate_info.phone_number}


Verify capture conversation journey that set at apply to chat after uploading resume missing candidate's information (OL-T28252, OL-T28251, OL-T28253, OL-T28250)
    Initial and go to widget site then upload resume    ${pdf_dic.no_info_file}    ${widget_dic.capture_convo}
    Verify AI message when asking about name in    Widget Conversation
    ${candidate_name} =      Generate candidate name
    Input text for widget site    ${candidate_name.full_name}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_name.first_name}    ${candidate_info.experience}    ${candidate_info.worked_position}    ${candidate_info.worked_place}  
    check message widget site response correct    ${candidate_info_msg} ${ONE_JOB_FOUND}
    Apply the first job on widget
    Input text for widget site    ${HI}
    ${email} =   Candidate input neccessary information
    Login into system with company    Paradox admin role    ${COMPANY_APPLICANT_FLOW}
    Open a candidate Conversation    ${candidate_name.full_name}
    Verify candidate's information on CEM    ${AUTOMATION_TESTER_TITLE_071}    ${email}    ${candidate_info.city}    ${CONST_PHONE_NUMBER}


Verify capture conversation when turn on AI matching resume (OL-T28254)
    Setup test
    ${site_url} =   Get widget conversation link    ${widget_dic.capture_convo}
    Go to widget site  ${site_url}
    Verify AI message when asking about name in    Widget Conversation
    ${absolute_path} =  Get Absolute Path    ${file_path}    ${pdf_dic.no_info_file}
    Click at   ${INPUT_WIDGET}
    Upload resume on widget    ${absolute_path}    ${pdf_dic.no_info_file}
    Check element not display on screen    ${SHADOW_DOM_UPLOAD_RESUME_INPUT}


Check template doesn't match the format (OL-T28255)
    Initial and go to widget site then upload resume    ${pdf_dic.wrong_format_file}    ${widget_dic.capture_convo}
    Verify AI message when asking about name in    Widget Conversation
    ${candidate_name} =      Generate candidate name
    Input text for widget site    ${candidate_name.full_name}
    ${candidate_info_msg} =  Format String    ${DETECT_CANDIDATE_INFO}    ${candidate_name.first_name}    ${candidate_info.experience}    ${candidate_info.worked_position}    ${candidate_info.worked_place}  
    check message widget site response correct    ${candidate_info_msg} ${ONE_JOB_FOUND}


*** Keywords ***
Initial and go to widget site then upload resume
    [Arguments]    ${file_name}    ${widget_name}
    Setup test
    ${site_url} =   Get widget conversation link    ${widget_name}
    Go to widget site  ${site_url}
    #    To open convo box
    ${absolute_path} =  Get Absolute Path    ${file_path}    ${file_name}
    Click at   ${INPUT_WIDGET}
    Upload resume on widget    ${absolute_path}    ${file_name}

Candidate input neccessary information
    &{email_info} =    Get email for testing
    Verify AI message when asking about email in    Widget Conversation
    Input text for widget site    ${email_info.email}
    Verify AI message when asking about phonenumber in    Widget Conversation
    Input text for widget site    ${CONST_PHONE_NUMBER}
    Verify AI message when asking about location in    Widget Conversation
    Input text for widget site    ${AUTOMATION_JOB_FEEDS_PROD_LOCATION_2}
    Verify last message content should be  ${THANKS_MESSAGE}  ${COMPANY_APPLICANT_FLOW}    Widget Conversation
    [Return]    ${email_info.email}

Verify candidate's information on CEM
    [Arguments]    ${job_title}    ${email}    ${phone_number}    ${city}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${job_title}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${email}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${phone_number}
    Check element display on screen  ${PROFILE_CARD_INFORMATION}    ${city}
    Select Frame  ${CEM_CANDIDATE_PROFILE_RESUME_FILE}
