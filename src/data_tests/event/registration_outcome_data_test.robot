*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${conversation_multi_path}                  Event_Convo_Multiple_Path
${conversation_single_path}                 Event_Convo_Single_Path
${conversation_multi_language}              Event_Convo_Multi_Language
${convo_event_single_path}                  event_single_path
${default_group}                            auto_event_group
@{language}                                 French  German  Italian     Japanese

*** Test Cases ***
Create conversation for Event - Registration Outcome
	Given Setup test
	Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
	# Create Event_Convo_Multiple_Path
	Go to conversation builder
	when Add new conversation with name and type    ${conversation_single_path}    Event Registration (Single Path)
	when Select multiple locations at Available locations   ${LOCATION_STREET_TRUNG_NU_VUONG}   ${LOCATION_STREET_NGUYEN_HUU_THO}
	Add Group to Conversation       ${default_group}
	Public the conversation
	# Create Event_Convo_Multiple_Path
	Go to conversation builder
	when Add new conversation with name and type    ${conversation_multi_path}    Event Registration (Multiple Path)
	when Select multiple locations at Available locations   ${LOCATION_STREET_TRUNG_NU_VUONG}   ${LOCATION_STREET_NGUYEN_HUU_THO}
	Click by JS    ${ADD_GROUP_1_QUESTION}
    Add question for Conversation  ${GROUP_QUESTION_CONTENT}  How old are you?  ${GROUP_1_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_GROUP_2_QUESTION}
    Add question for Conversation  ${GROUP_QUESTION_CONTENT}  Your like?  ${GROUP_2_QUESTION_1_LABEL}  Like
	Public the conversation
	# Create Event_Convo_Multi_Language
	Go to conversation builder
	when Add new conversation with name and type    ${conversation_multi_language}    Event Registration (Single Path)
	when Select multiple locations at Available locations   ${LOCATION_STREET_TRUNG_NU_VUONG}   ${LOCATION_STREET_NGUYEN_HUU_THO}
	Add language to Conversation    @{language}
	Public the conversation
	# Create event_single_path
	Go to conversation builder
	when Add new conversation with name and type    ${convo_event_single_path}    Event Registration (Single Path)
	when Select multiple locations at Available locations   ${LOCATION_STREET_TRUNG_NU_VUONG}   ${LOCATION_STREET_NGUYEN_HUU_THO}
	Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_1}  How old are you?  ${GLOBAL_SCREENING_QUESTION_1_LABEL}  Age
    Click by JS    ${ADD_GLOBAL_SCREENING_QUESTION}
    Add question for Conversation  ${GLOBAL_SCREENING_QUESTION_CONTENT_2}  Your like?  ${GLOBAL_SCREENING_QUESTION_2_LABEL}  Like
	Public the conversation
