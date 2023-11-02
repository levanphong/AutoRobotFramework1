# BASE / CANDIDATE SUMMARY
CANDIDATE_SUMMARY_ADD_SECTION_BUTTON = "//button[contains(normalize-space(), 'Add Section')]"
CANDIDATE_SUMMARY_ADD_SECTION_ITEM = "//*[contains(@data-testid, 'candidate_summary_btn_add_section') and contains(normalize-space(), '{}')]"
CANDIDATE_SUMMARY_TITLE_TEXTBOX = "//*[contains(@data-testid, 'candidate_summary_lbl_section_name') and contains(normalize-space(), '{}') and contains(@class, 'editable-text')]"  #PARAMETER IS TITLE TEXT
CANDIDATE_SUMMARY_EDIT_TITLE_ICON = "//*[contains(@data-testid, 'candidate_summary_lbl_section_name') and contains(normalize-space(), '{}')]/following-sibling::span[contains(@class, 'icon-edit')]"  #PARAMETER IS TITLE TEXT
CANDIDATE_SUMMARY_DELETE_SECTION_BUTTON = "//*[contains(@id, 'candidate__section')][{}]//*[contains(@class, 'icon-edit')]"  #PARAMETER IS INDEX OF SECTION
CANDIDATE_SUMMARY_ADD_FIELD_BUTTON = "//*[contains(@id, 'candidate__section')][{}]//*[contains(@data-testid, 'candidate_summary_btn_add_field')]//*[text()='Add Field']"  #PARAMETER IS INDEX OF SECTION
CANDIDATE_SUMMARY_ADD_SECTION_BUTTON_1 = "//*[contains(@data-testid, 'candidate_summary_btn_add_section') and @role='button']" # add section button on menu tab
CANDIDATE_SUMMARY_ADD_SECTION_BUTTON_2 = "(//*[contains(@data-testid, 'candidate_summary_btn_add_section') and @role='button'])[last()]" # add section button at the bottom of sections tab
CANDIDATE_SUMMARY_ADD_SECTION_ITEM_2 = "(//*[contains(@data-testid, 'candidate_summary_btn_add_section') and contains(normalize-space(), '{}')])[last()]"
CANDIDATE_SUMMARY_PREVIEW_BUTTON = "//*[contains(@data-testid, 'candidate_summary_preview_btn')]"
CANDIDATE_SUMMARY_SAVE_BUTTON = "//*[contains(@data-testid, 'candidate_summary_save_btn')]"
CANDIDATE_SUMMARY_SUCCESS_TOASTED = "//*[contains(@class, 'toasted toasted-primary success')]"
CANDIDATE_SUMMARY_TAB = "//*[contains(@class, 'title') and contains(text(), 'Candidate Summary Builder')]/../following-sibling::*//*[contains(text(), 'Candidate Summary')]"
CANDIDATE_SUMMARY_TITLE = "//*[contains(@data-testid, 'candidate_summary_lbl_title')]"
CANDIDATE_SUMMARY_CHANGE_SAVE_BUTTON = "//*[contains(@aria-label, 'Save Changes')]//button[contains(normalize-space(), 'Save')]"
CANDIDATE_SUMMARY_FIELD_TITLE = "//*[contains(@data-testid, 'candidate_summary_lbl_field_name')]" 
CANDIDATE_SUMMARY_FIELD_ATTRIBUTE_VALUE = "//*[contains(@data-testid, 'candidate_summary_btn_edit_field')]//*[contains(text(), '{}')]"
CANDIDATE_SUMMARY_SECTION_EXPAND_ICON = "//*[contains(text(), '{}')]/following-sibling::*[contains(@data-testid, 'candidate_summary_btn_expand_section')]"
CANDIDATE_SUMMARY_SECTION_EXPAND_ITEM = "//*[contains(@data-testid, 'candidate_summary_lbl_section_field') and normalize-space()='{}']"
CANDIDATE_SUMMARY_DELETE_SECTION_BUTTON = "//*[contains(@id, 'candidate__section')][{}]//*[contains(@class, 'icon-delete')]" #PARAMETER IS INDEX OF SECTION
CANDIDATE_SUMMARY_CONFIRM_DELETE_BUTTON = "//*[contains(@class, 'confirm')]//*[normalize-space() = 'Delete']"
CANDIDATE_SUMMARY_DELETE_SECTION_ICON = "//*[contains(@id, 'candidate__section') and descendant::span[contains(text(),'{}')]]//i[contains(@class,'icon-delete') and parent::button[contains(@data-testid,'btn_detele_section')]]" #PARAMETER IS NAME OF SECTION
CANDIDATE_SUMMARY_CONFIRM_DELETE_SECTION_POPUP_BUTTON = "//*[contains(@class, 'el-message-box__btns')]//button[contains(@type,'button')]//child::span[contains(text(),'{}')]" #PARAMETER IS NAME OF BUTTON

# BASE / CANDIDATE SUMMARY / Add field dialog
ADD_FIELD_NAME_TEXTBOX = "//*[contains(@data-testid, 'candidate_summary_input_fieldname')]"
ADD_FIELD_DATA_DROPDOWN = "//*[contains(@data-testid, 'candidate_summary_select_keyname')]"
ADD_FIELD_DATA_SEARCH_TEXTBOX = "//*[contains(@placeholder, 'Search for Attribute')]"
ADD_FIELD_DATA_ITEM = "(//*[contains(@class, 'select-group')]//li[normalize-space()='{}'])[last()]"
ADD_FIELD_DATA_DISABLED_ITEM = "(//*[contains(@class, 'select-group')]//li[normalize-space()= '{}' and contains(@class, 'disabled')])[last()]"
ADD_FIELD_SAVE_BUTTON = "(//*[contains(@data-testid, 'candidate_summary_btn_save')])[last()]"
ADD_FIELD_CANCEL_BUTTON = "//*[contains(@data-testid, 'candidate_summary_btn_cancel')]"
