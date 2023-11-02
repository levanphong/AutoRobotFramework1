# BASE
APPLICANT_FLOWS_CREATE_NEW_BUTTON = "//*[contains(@data-testid, 'af_list_create_btn')]"
APPLICANT_FLOWS_CONFIGURE_DEFAULT_BUTTON = "//*[contains(@data-testid, 'af_list_configure_btn')]"
APPLICANT_FLOWS_SEARCH_AF = "//*[contains(@data-testid, 'af_list_search_btn')]//input"
APPLICANT_FLOWS_NAME = "//*[contains(@class,'cell')]//*[contains(@class,'text-overflow')]//*[contains(text(),'{}')]"

# BASE / CREATE NEW AF PAGE
APPLICANT_FLOWS_NEXT_STEP_BUTTON = "//*[contains(@data-testid, 'af_details_targeting_btn_next')]"
APPLICANT_FLOWS_NAME_TEXTBOX = "//*[contains(@data-testid, 'af_details_targeting_input_name')]"
APPLICANT_FLOWS_INPUT_TEXTBOX = "//*[contains(@data-testid, 'rule_input_value')]"
APPLICANT_FLOWS_INPUT_LAST_TEXTBOX = "(//*[contains(@data-testid, 'rule_input_value')])[last()]"
APPLICANT_FLOWS_EXTERNAL_AF_ID_TEXTBOX = "//*[contains(@data-testid, 'af_details_targeting_input_external_id')]"
APPLICANT_FLOWS_TARGETING_RULES_DROPDOWN = "(//input[contains(@placeholder,'Select')])[1]"
APPLICANT_FLOWS_TARGETING_RULES_ITEM = "(//*[contains(@role, 'tablist')]//*[normalize-space()='{}'])[last()]"
APPLICANT_FLOWS_MATCHES_DROPDOWN = "(//input[contains(@placeholder,'Select')])[2]"
APPLICANT_FLOWS_MATCHES_ITEM = "(//*[contains(@class, 'select-dropdown__list')]//*[normalize-space()='{}'])[last()]"
APPLICANT_FLOWS_AND_BUTTON = "//*[contains(@data-testid, 'add_rule_btn_0')]"
APPLICANT_FLOWS_OR_BUTTON = "//*[contains(@data-testid, 'add_rule_block_btn_0')]"
APPLICANT_FLOWS_SELECT_CANDIDATE_JOURNEY_BUTTON = "//*[contains(@data-testid, 'af_cj_select_btn')]"
APPLICANT_FLOWS_DROPDOWN_BY_INDEX = "(//input[contains(@placeholder,'Select')])[{}]"
APPLICANT_FLOWS_SAVE_FINISH_BUTTON = "//*[contains(@data-testid, 'af_cj_header_publish_btn')]"
APPLICANT_FLOWS_SET_CONVERSATION_BUTTON = "//*[contains(@data-testid, 'af_cj_right_stage_criteria_set_data_btn')]//*[normalize-space()='Set Conversation']"
APPLICANT_FLOWS_SET_INTERVIEW_BUTTON = "//*[contains(@data-testid, 'af_cj_right_stage_criteria_set_data_btn')]//*[normalize-space()='Set Interview']"
APPLICANT_FLOWS_SET_OFFER_BUTTON = "//*[contains(@data-testid, 'af_cj_right_stage_criteria_set_data_btn')]//*[normalize-space()='Select Offer']"
APPLICANT_FLOWS_CJ_TAB = "//*[contains(@data-testid, 'af_left_sidebar_tab_candidate_journey')]"
APPLICANT_FLOWS_ELIPSIS_BUTTON = "//div[contains(text(), '{}')]//ancestor::*[contains(@data-testid, 'af_cj_right_stage_card')]//button"
APPLICANT_FLOWS_SELECT_OFFER_TYPE = "//*[contains(@data-testid, 'af_candidate_journey_offer_selection')]"
APPLICANT_FLOWS_SELECT_OFFER = "//div[contains(text(), 'Select Offer(s)')]//ancestor::div[contains(@class, 'el-form')]//div[@data-testid='btn_show_menu']"
APPLICANT_FLOWS_SELECT_OFFER_NAME= "//label[contains(@class,'el-checkbox')]//child::span[contains(text(),'{}')]" #PARAMETER IS OFFER NAME
APPLICANT_FLOWS_SEARCH_OFFER = "//*[contains(@data-testid, 'af_candidate_journey_search_offer')]//input"
APPLICANT_FLOWS_EXTERNAL_OFFER_TEXT = "//*[contains(@class, 'color-lighter')]//span"
APPLICANT_FLOWS_STAGE = "//*[contains(@data-testid, 'af_cj_left_stage_number')]//following-sibling::span//span[contains(text(), '{}')]"
APPLICANT_FLOWS_EDIT_STAGE_BUTTON = "(//span[contains(text(), 'Edit')])[last()]"

# BASE / CREATE NEW AF PAGE / Select Candidate Journey drawer
SELECT_CANDIDATE_JOURNEY_SEARCH_TEXTBOX = "//*[contains(@data-testid, 'af_cj_modal_search_input')]//input"
SELECT_CANDIDATE_JOURNEY_APPLY_BUTTON = "//*[contains(@data-testid, 'af_cj_modal_apply_btn')]"
SELECT_CANDIDATE_JOURNEY_ITEM = "//*[contains(@data-testid, 'af_cj_modal_radio')]//*[normalize-space()='{}']"
SELECT_CANDIDATE_JOURNEY_MENU_ICON="//*[contains(@type,'button') and not(contains(@disabled,'disabled'))]//*[contains(@class,'icon-menu')]"

# BASE / CREATE NEW AF PAGE / Default Conversation
DEFAULT_CONVERSATION_SELECT_CONVERSATION_DROPDOWN = "(//*[contains(@placeholder,'Select')])[last()]"
DEFAULT_CONVERSATION_SELECT_CONVERSATION_ITEM = "//*[contains(@role, 'radiogroup')]//*[normalize-space()='{}']"
DEFAULT_CONVERSATION_SELECT_CONVERSATION_SEARCH_TEXTBOX = "(//*[contains(@data-testid, 'input_search')])[last()]//input"
DEFAULT_CONVERSATION_APPLY_BUTTON = "//button[normalize-space()='Apply']"
DEFAULT_CONVERSATION_SAVE_BUTTON = "//button[normalize-space()='Save']"

# BASE / CREATE NEW AF PAGE / Default Interview drawer
DEFAULT_INTERVIEW_SET_INTERVIEW_DETAILS_DROPDOWN = "//*[contains(@data-testid, 'job_itv_type')]"
DEFAULT_INTERVIEW_SET_INTERVIEW_DETAILS_ITEM = "//*[contains(@class, 'select-dropdown__list')]//*[normalize-space()='{}']"
DEFAULT_INTERVIEW_SAVE_BUTTON = "//button[normalize-space()='Save']"
DEFAULT_INTERVIEW_ATTENDEES_DROPDOWN = "//*[contains(@placeholder, 'Add an attendees')]"
DEFAULT_INTERVIEW_SEARCH_ATTENDEES_TEXTBOX = "//*[contains(@placeholder, 'Search for an attendee')]"

# BASE / CREATE NEW AF PAGE / Default Offer
DEFAULT_OFFER_EDIT_ICON = "//*[contains(@class,'icon-edit') and preceding::div[contains(text(),'Default Offer')]]"
