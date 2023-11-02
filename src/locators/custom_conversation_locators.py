# ADD CUSTOM CONVERSATION PAGE
CUSTOM_CONVERSATION_NAME_TEXTBOX = "//input[@data-testid='customconvo_input_convo_name']"
PUBLIC_CUSTOM_BUTTON = "//button[contains(@class,'btn-publish')]"
DELETE_CUSTOM_CONVERSATION_BUTTON = "//*[contains(@class,'el-button')]//*[contains(@class,'icon-delete')]"
CONFIRM_DELETE_CUSTOM_CONVERSATION_BUTTON = "//button[contains(@class,'button--danger')]//*[contains(text(),'Deactivate')]"
FIRST_TITLE_QUESTION_TEXTBOX = "//*[contains(@data-testid,'customconvo_question_title') and contains(text(),'Name your question')]/parent::div[contains(@data-testid,'customconvo_question')]//*[contains(@data-testid,'customconvo_question_input_name')]"
QUESTION_TITLE = "//*[contains(@data-testid,'customconvo_question_title') and contains(text(), '{}')]"
QUESTION_TYPE_BY_TITLE_QUESTION_DROPDOWN ="//*[contains(@data-testid,'customconvo_question_title') and contains(text(),'{}')]/ancestor::div[contains(@data-testid,'customconvo_question')]//*[contains(@data-testid,'customconvo_question_type_select')]"
QUESTION_TYPE_BY_NAME = "(//*[contains(@data-testid,'customconvo_question_type_items')]//*[contains(text(),'{}')])[last()]"
APPLY_BUTTON = "(//button[contains(@data-testid,'customconvo_question_type_btn_apply')])[last()]"
QUESTION_DESCRIPTION_TEXTBOX = "//div[contains(@data-testid, 'customconvo_question_title') and contains(text(), '{}')]/following-sibling::div//div[contains(@data-testid, 'customconvo_question_content')]//div[contains(@contenteditable, 'true')]"
THREE_DOT_ICON_BY_QUESTION_NAME = "//*[contains(@data-testid,'customconvo_question_title') and contains(text(), '{}')]//following-sibling::*//*[contains(@data-testid,'customconvo_question_tool_dialog_three_dot')]"
CUSTOM_CONVERSATION_ADD_BUTTON = "//*[contains(@data-testid,'customconvo_question_title') and contains(text(), '{}')]//following-sibling::*//button[contains(@data-testid,'customconvo_tools_btn_add')]"
NEXT_QUESTION_BUTTON = "(//*[contains(@data-testid,'customconvo_tools_option') and contains(text(), 'Next Question')])[last()]"
ADD_CONDITION_BUTTON = "(//*[contains(@data-testid,'customconvo_tools_option') and contains(text(), 'Add Condition')])[last()]"
CUSTOM_CONVO_END_CONVERSATION_BUTTON = "(//*[contains(@data-testid,'customconvo_tools_option') and contains(text(), 'End Conversation')])[last()]"
MOVE_TO_CONVERSATION_BUTTON = "(//*[contains(@data-testid,'customconvo_tools_option') and contains(text(), 'Move To: Conversation')])[last()]"
MOVE_TO_QUESTION_BUTTON = "(//*[contains(@data-testid,'customconvo_tools_option') and contains(text(), 'Move To: Question')])[last()]"
DELETE_MEDIA_TYPE_BUTTON = "//button[contains(@class, 'el-button--danger')]//span[contains(text(), 'Delete') or contains(text(), 'Remove')]"
SUCCESSFULLY_MESSAGE_TOASTED = "//*[contains(@class, 'toasted')]"
PUBLISHING_CUSTOM_LABEL = "//*[contains(@class, 'publishing')]"
CUSTOM_CONVERSATION_CANDIDATE_JOURNEY_DROPDOWN_BUTTON = "//*[contains(@data-msgid, 'Candidate Journey')]/..//*[contains(@data-testid, 'btn_show_menu')]"
CUSTOM_CONVERSATION_QUESTION_MENU_RATING = "//span[contains(text(),'Select rating')]//ancestor::div[@data-testid='btn_show_menu']"
CUSTOM_CONVERSATION_QUESTION_RATING_SELECT = "//ul[@data-testid='customconvo_checkmark_select_items']//li[normalize-space()='{}']"

# SELECT LOCATION DIALOG
AVAILABLE_LOCATION_DROPDOWN = "//*[contains(@data-testid,'customconvo_location_selection_select')]"
SEARCH_LOCATION_TEXTBOX = "//input[contains(@placeholder,'Search for a location')]"
SAVE_LOCATION_BUTTON = "(//button[contains(@data-testid,'customconvo_question_type_dialog_btn_save')])[last()]"
LOCATION_CHECKBOX_BY_NAME = "//*[contains(text(),'{}')]//ancestor-or-self::div[@class='el-tree-node__content']//label//span[@class='el-checkbox__input']"

# ECLIPSE MENU OF QUESTION
CUSTOM_CONVERSATION_QUESTION_ECLIPSE_MENU_ITEM = "(//div[@role='tooltip'])[last()]//*[contains(text(),'{}')]"
CUSTOM_CONVERSATION_QUESTION_DELETE_MEDIA_BUTTON = "//*[@data-testid='customconvo_media_name_block' and normalize-space()='{}']/ancestor::*[@data-testid='customconvo_media_question_block']/i"
CUSTOM_CONVERSATION_QUESTION_MEDIA_BLOCK = "//*[@data-testid='customconvo_media_name_block' and normalize-space()='{}']"
CUSTOM_CONVERSATION_QUESTION_REQUIRED_CHECKBOX = "//*[@data-testid='customconvo_media_name_block' and normalize-space()='{}']/ancestor::div[contains(@class,'card')]/following-sibling::label/span"

# ECLIPSE MENU OF QUESTION / UPLOAD MEDIA / ADD MEDIA DIALOG
CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_NEW_MEDIA_BUTTON = "//div[@data-test-id='media-drawer']//button[@data-testid='customconvo_add_button_media']"
CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_ADD_BUTTON = "//button[@data-test-id='media-drawer-btn-add']"
CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_SEARCH_MEDIA_TEXTBOX = "//*[@data-testid='media_input_search']//input"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_MODAL = "//div[contains(@data-test-id, 'media-drawer')]//div[contains(@class, 'el-drawer rtl')]"
CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TAB = "//div[contains(@role,'tablist')]/*[contains(text(),'{}')]"
CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_TITLE = "//*[contains(@data-testid,'customconvo_radio_media')]/following-sibling::div/div[1]"
CUSTOM_CONVERSATION_ADD_MEDIA_DIALOG_MEDIA_CARD = "//*[normalize-space()='{}']/ancestor::*[contains(@class, 'card__body')]"

# ECLIPSE MENU OF QUESTION / UPLOAD MEDIA / ADD NEW MEDIA DIALOG
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DIALOG_TITLE = "//div[@data-test-id='media-drawer']//span[@class='title']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_TYPE = "//span[contains(@class,'radio__label') and normalize-space()='{}']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CHECKBOX = "//span[contains(@class,'radio__label') and normalize-space()='{}']/parent::*/span[contains(@class,'radio__input')]"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CONTENT_TITLE_TEXTBOX = "//input[@placeholder='Enter content title']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_TEXTBOX = "(//div[contains(@class,'media-box')])[last()]//input[@placeholder='https://']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_URL_OPTIONAL_TEXTBOX = "//input[@placeholder='https://']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_ALT_TEXTBOX = "//input[@placeholder='Enter alt text']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_FILE_UPLOAD_BUTTON = "//input[@type='file']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_REMOVE_FILE_UPLOADED_BUTTON = "//div[@class='upload-media']//i[@class='icon-remove']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_DRAG_FILE_BUTTON = "//div[contains(@class, 'upload-media-content')]"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_UPLOADING_MEDIA_FIELD = "//*[contains(@class, 'upload-media') and contains(@class, 'processing')]"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CREATE_BUTTON = "//button[@data-test-id='media-drawer-btn-create']//*[contains(text(), 'Create')]"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_INVALID_INPUT_MESSAGE = "//*[contains(@class, 'error') and contains(text(),'{}')]"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_BACK_BUTTON = "//*[@id='el-drawer__title']//i[contains(@class,'close-icon')]"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CANCEL_BUTTON = "//button[@data-test-id='media-drawer-btn-cancel']"
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_WARNING_MESSAGE = """//i[contains(@class, 'icon-warn')]/following-sibling::span[normalize-space()="{}"]"""
CUSTOM_CONVERSATION_VIDEO_OPTIONS_DEFAULT_SELECTED_TAG = "//div[contains(@class, 'is-active') and contains(text(), 'Video')]"

# ECLIPSE MENU OF QUESTION / UPLOAD MEDIA / ADD NEW MEDIA DIALOG / UPLOAD FILE / CROP THUMBNAIL IMAGE POPUP
CUSTOM_CONVERSATION_ADD_NEW_MEDIA_CROP_THUMBNAIL_CONFIRM_BUTTON = "(//div[@role='dialog'])[last()]//button[contains(@class,'primary')]"

# CONFIRM MODEL
CUSTOM_CONVERSATION_CONFIRM_MODEL_BUTTON = "//*[contains(@class, 'ol-confirm')]//*[normalize-space()='{}']"

# ECLIPSE MENU OF QUESTION / LIST SELECT MODEL
CUSTOM_CONVERSATION_LIST_SELECT_ITEM_NAME_TEXT_BOX = "(//div[normalize-space()='List Item'])[last()]/parent::div/following-sibling::div//input"
CUSTOM_CONVERSATION_LIST_SELECT_ADD_ITEM_BUTTON = "(//button[@data-testid='conversationbld_btn_add_item'])[last()]"
CUSTOM_CONVERSATION_LIST_SELECT_CANCEL_BUTTON = "(//button[@data-testid='customconvo_question_type_dialog_btn_cancel'])[last()]//*[contains(text(), 'Cancel')]"
EDIT_QUESTION_OPTION_DIALOG_SAVE_BUTTON = "(//button[@data-testid='customconvo_question_type_dialog_btn_save'])[last()]//*[contains(text(), 'Save')]"

# ECLIPSE MENU OF QUESTION / EDIT REPROMPT MESSAGE
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_X_BUTTON = "(//button[contains(@class, 'close-btn')])[last()]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TITLE = "(//span[contains(@class, 'title')])[last()]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TEXTBOX = "//label[normalize-space()='Validation Prompt']/..//*[@placeholder= 'Enter Message']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_TEXTBOX = "//label[normalize-space()='Message Prompt']/..//*[@placeholder= 'Enter Message']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TEXTBOX = "//div[contains(@data-testid, 'customconvo_reprompt_msg_question')]//div[@contenteditable='true']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MESSAGE_PROMPT_BUTTON = "//label[normalize-space()='Message Prompt']/../div/div[last()]/div[contains(text(), '{}')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TEXTBOX = "//label[normalize-space()='Media Prompt']/..//*[@placeholder= 'Enter Message']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_BUTTON = "//label[normalize-space()='Media Prompt']/../div/div[last()]/div[contains(text(), '{}')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_CANCEL_BUTTON = "//button[@data-testid = 'customconvo_reprompt_msg_btn_cancel']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_SAVE_BUTTON = "//button[@data-testid = 'customconvo_reprompt_msg_btn_save']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_PROMPT_TRASH_ICON = "//label[normalize-space()='Media Prompt']/../div/div[last()]/div[contains(text(), '{}')]/i"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TRASH_ICON = "//label[normalize-space()='Validation Prompt']//..//div//div[last()]//div[contains(text(), '{}')]//i"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MEDIA_DECRIPTION = "//*[contains(@class, 'drawer__body')]//*[normalize-space()= '{}']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_INVALID_MESSAGE = "//*[@data-testid='customconvo_reprompt_msg_ques_err']"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_TITLE = "//div[contains(@data-testid, 'customconvo_reprompt_msg_ctn')]//parent::div//*[contains(text(), 'Validation Prompt')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MESSGAE = '//div[contains(@data-testid, "customconvo_reprompt_msg_question")]//div[contains(@placeholder, "Enter Message") and contains(text(),"{}")]'
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_EMPTY_MESSGAE = "//div[contains(@data-testid, 'customconvo_reprompt_msg_question')]//div[contains(@placeholder, 'Enter Message')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_VALIDATION_PROMPT_MOVE_ICON = "//*[contains(@class, 'drawer__body')]//*[normalize-space()= '{}']//*[contains(@class, 'icon-delete2')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TEXT_COUNTER = "//div[contains(@data-testid, 'customconvo_reprompt_msg_question')]//*[contains(@class, 'text-counter__number')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_TOAST_MESSAGE = "//div[contains(@class, 'toasted toasted-primary success') and contains(text(), 'Changes saved successfully.')]"
CUSTOM_CONVERSATION_EDIT_REPROMPT_MESSAGE_MODAL = "//*[contains(@data-testid,'customconvo_reprompt_msg_drawer') and not(contains(@style,'display: none;'))]"

# BASE / Candidate Journey table
CANDIDATE_JOURNEY_SEARCH_TEXTBOX = "//*[contains(@data-testid, 'multidropdown_input_search')]//input"
CANDIDATE_JOURNEY_ITEM_CHECKBOX = "//*[contains(@title, '{}')]/../..//span[contains(@class, 'checkbox__inner')]"
CANDIDATE_JOURNEY_APPLY_BUTTON = "//*[contains(@data-testid, 'multidropdown_btn_apply')]"

# ECLIPSE MENU OF QUESTION / AREA OF INTEREST MODEl
CUSTOM_CONVERSATION_AREA_OF_INTEREST_TITLE = "//*[contains(@class, 'el-dialog__header')]//*[contains(text(), 'Area of Interest')]"
CUSTOM_CONVERSATION_AREA_OF_INTEREST_SELECT_GROUP_DROPDOWN_ICON = "//*[contains(@data-testid, 'customconvo_area_of_interest')]//*[contains(@class, 'icon-chevron-down')]"
CUSTOM_CONVERSATION_AREA_OF_INTEREST_SEARCH_GROUP_TEXTBOX = "//*[contains(@data-testid, 'input_search')]//input"
CUSTOM_CONVERSATION_AREA_OF_INTEREST_GROUP_OPTIONS_CHECKBOX = "//span[normalize-space(text())='{}']//parent::*[contains(@data-testid, 'checkbox_select_item')]//*[contains(@class, 'el-checkbox__inner')]"
CUSTOM_CONVERSATION_AREA_OF_INTEREST_APPLY_BUTTON = "//*[contains(@data-testid, 'btn_apply_dropdown_value')]"
CUSTOM_CONVERSATION_AREA_OF_INTEREST_CANCEL_BUTTON = "//*[contains(@data-testid, 'btn_cancel_dropdown_value')]"
CUSTOM_CONVERSATION_AREA_OF_INTEREST_SAVE_BUTTON = "//*[contains(@aria-label, 'Area of Interest')]//*[contains(@data-testid, 'customconvo_question_type_dialog_btn_save')]"

# ECIPLSE MENU OF QUESTION FOR ALL TEMPLATE
CUSTOM_CONVERSATION_ECLIPSE_MENU_OPTION = "//*[contains(text(), '{}')]//ancestor::div[contains(@data-testid, 'conversationbld_div_question_content')]//*[contains(@class, 'icon-horizontal-menu')]"
CUSTOM_CONVERSATION_ECLIPSE_OPTION = "//div[@role='tooltip' and not(contains(@style,'display: none'))]//li[contains(@data-testid, 'conversationbld_btn_tool')]//span[contains(text(), '{}')]"
CUSTOM_CONVERSATION_TOGGLE = "//span[contains(@data-testid, 'conversationbld_lbl_question_name') and contains(text(), '{}')]//ancestor::div[contains(@data-testid, 'conversationbld_div_question_content')]//*[contains(@class, 'el-switch__core')]"
