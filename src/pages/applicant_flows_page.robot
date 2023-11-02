*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/applicant_flows_locators.py

*** Keywords ***
Set conversation in applicant flows
    [Arguments]   ${convo_title}
    Click at  ${APPLICANT_FLOWS_SET_CONVERSATION_BUTTON}
    Click at  ${DEFAULT_CONVERSATION_SELECT_CONVERSATION_DROPDOWN}
    Input into  ${DEFAULT_CONVERSATION_SELECT_CONVERSATION_SEARCH_TEXTBOX}  ${convo_title}
    Click at  ${DEFAULT_CONVERSATION_SELECT_CONVERSATION_ITEM}  ${convo_title}
    Click at  ${DEFAULT_CONVERSATION_APPLY_BUTTON}
    Click at  ${DEFAULT_CONVERSATION_SAVE_BUTTON}

Set interview in applicant flows
    [Arguments]  ${type}=Manually Schedule   ${attendee}=None
        Click at  ${APPLICANT_FLOWS_SET_INTERVIEW_BUTTON}
        Click at  ${DEFAULT_INTERVIEW_SET_INTERVIEW_DETAILS_DROPDOWN}
    IF  '${type}' == 'Manually Schedule'
        Click at  ${DEFAULT_INTERVIEW_SET_INTERVIEW_DETAILS_ITEM}  Manually Schedule
    ELSE
        Click at  ${DEFAULT_INTERVIEW_ATTENDEES_DROPDOWN}
        Input into  ${DEFAULT_INTERVIEW_SEARCH_ATTENDEES_TEXTBOX}  ${attendee}
        Click at  ${attendee}
    END
    Click at  ${DEFAULT_INTERVIEW_SAVE_BUTTON}

Select Candidate Journey in applicant flows
    [Arguments]  ${candidate_joruney_title}
    Click at  ${APPLICANT_FLOWS_SELECT_CANDIDATE_JOURNEY_BUTTON}
    Input into  ${SELECT_CANDIDATE_JOURNEY_SEARCH_TEXTBOX}  ${candidate_joruney_title}
    Click at  ${SELECT_CANDIDATE_JOURNEY_ITEM}  ${candidate_joruney_title}
    Click at  ${SELECT_CANDIDATE_JOURNEY_APPLY_BUTTON}

Set condition in applicant flows
    [Arguments]  ${condition_index}   ${input}   ${matches}=Contains   ${target_rule_attribute}=Job Requisition Attributes   ${target_rule_item}=Job Req ID
    ${target_rule_index} =  Evaluate  2*${condition_index} - 1
    ${matches_index} =  Evaluate  2*${condition_index}
    # Select Job Req ID at Targeting Rules
    Click at  ${APPLICANT_FLOWS_DROPDOWN_BY_INDEX}  ${target_rule_index}
    Click at  ${APPLICANT_FLOWS_TARGETING_RULES_ITEM}   ${target_rule_attribute}
    Click at  ${APPLICANT_FLOWS_TARGETING_RULES_ITEM}   ${target_rule_item}
    # Select Contains at Matches
    Click at  ${APPLICANT_FLOWS_DROPDOWN_BY_INDEX}  ${matches_index}
    Click at  ${APPLICANT_FLOWS_MATCHES_ITEM}   ${matches}
    Input into  ${APPLICANT_FLOWS_INPUT_LAST_TEXTBOX}  ${input}
    Capture page screenshot

Select Offer type in applicant flows
    [Arguments]     ${offer_type}   ${offer_name}=None
    Click at    ${APPLICANT_FLOWS_SET_OFFER_BUTTON}
    Click at    ${APPLICANT_FLOWS_SELECT_OFFER_TYPE}
    Click at    ${APPLICANT_FLOWS_MATCHES_ITEM}     ${offer_type}
    IF  '${offer_type}' == 'Paradox Offers'
        Click at    ${APPLICANT_FLOWS_SELECT_OFFER}
        Input into  ${APPLICANT_FLOWS_SEARCH_OFFER}     ${offer_name}
        Click on span text  ${offer_name}
        Click at        Apply
    END
    Click at    ${DEFAULT_INTERVIEW_SAVE_BUTTON}

Create new applicant flow
    [Arguments]     ${target_rule_attribute}    ${target_rule_item_name}     ${matches}    ${cj_name}      ${job_req_id}       ${conversation_name}    ${offer_type}   ${offer_name}        ${af_name}=None
    IF      '${af_name}'=='None'
        ${random} =    Generate Random String    7    [LETTERS][NUMBERS]
        ${af_name}=    Set variable    auto_af_${random}
    END
    Click at    ${APPLICANT_FLOWS_CREATE_NEW_BUTTON}
    Input into      ${APPLICANT_FLOWS_NAME_TEXTBOX}     ${af_name}
    # Setting target rule
    Click at    ${APPLICANT_FLOWS_TARGETING_RULES_DROPDOWN}
    Click at    ${APPLICANT_FLOWS_TARGETING_RULES_ITEM}     ${target_rule_attribute}
    Click on span text      ${target_rule_item_name}
    Click at        ${APPLICANT_FLOWS_MATCHES_DROPDOWN}
    Click at        ${APPLICANT_FLOWS_MATCHES_ITEM}     ${matches}
    Input into      ${APPLICANT_FLOWS_INPUT_TEXTBOX}        ${job_req_id}
    #   Next stage
    Click at  ${APPLICANT_FLOWS_NEXT_STEP_BUTTON}
    Select Candidate Journey in applicant flows     ${cj_name}
    Set conversation in applicant flows    ${conversation_name}
    Set interview in applicant flows
    Select Offer type in applicant flows        ${offer_type}   ${offer_name}
    Click at  ${APPLICANT_FLOWS_SAVE_FINISH_BUTTON}

Search and click application flows
    [Arguments]     ${af_name}      ${target_rule_attribute}    ${target_rule_item_name}     ${matches}     ${cj_name}      ${job_req_id}       ${conversation_name}    ${offer_type}   ${offer_name}
    Input into      ${APPLICANT_FLOWS_SEARCH_AF}    ${af_name}
    ${is_exist}=    run keyword and return status       Check element display on screen     ${APPLICANT_FLOWS_NAME}     ${af_name}
    IF      '${is_exist}'=='True'
        Click at        ${APPLICANT_FLOWS_NAME}     ${af_name}
    ELSE
        Create new applicant flow        ${target_rule_attribute}    ${target_rule_item_name}     ${cj_name}      ${job_req_id}       ${conversation_name}    ${offer_type}   ${offer_name}     ${af_name}
        Input into      ${APPLICANT_FLOWS_SEARCH_AF}    ${af_name}
        Click at        ${APPLICANT_FLOWS_NAME}     ${af_name}
    END
    wait for page load successfully v1

Change Offer in applicant flow
    [Arguments]     ${offer_name}
    Click at       Candidate Journey
    Click at        ${APPLICANT_FLOWS_STAGE}        Offer
    wait with short time  #wait for load to section offer
    Click at        ${SELECT_CANDIDATE_JOURNEY_MENU_ICON}
    Click at        ${DEFAULT_OFFER_EDIT_ICON}
    Click at    ${APPLICANT_FLOWS_SELECT_OFFER}
    Click at      ${APPLICANT_FLOWS_SELECT_OFFER_NAME}      Select all
    Input into  ${APPLICANT_FLOWS_SEARCH_OFFER}     ${offer_name}
    Click on span text      ${offer_name}
    Click at        Apply
    Click at    ${DEFAULT_INTERVIEW_SAVE_BUTTON}
    wait for page load successfully v1
    Click at        ${APPLICANT_FLOWS_SAVE_FINISH_BUTTON}
