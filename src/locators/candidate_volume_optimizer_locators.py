# BASE PAGE
CVO_NAV_STATUS_TAB = "//*[contains(@class,'menu-active')]//*[contains(@class,'nav-text') and contains(text(),'{}')]"
CVO_NAV_STATUS_COUNT_NUMBER = "//*[contains(@class,'menu-active')]//*[contains(@class,'nav-text') and contains(text(),'{}')]//following-sibling::div"
CVO_NEW_SEGMENT_BUTTON = "//*[@data-testid='cvo_list_create_btn']"
CVO_SEGMENT_SEARCH_TEXTBOX = "//*[@data-testid='cvo_list_search_btn']//input"
CVO_SEGMENT_LIST_CELL_VALUE = "//*[contains(@class,'cell el-tooltip')]//span[normalize-space(text())='{}']"
CVO_SEGMENT_INACTIVE_TOOLTIP = "//*[@role='tooltip' and not(contains(@style,'display: none'))]"

# BASE PAGE > Eclipse menu
CVO_SEGMENT_ECLIPSE_BUTTON = "//*[@data-testid='cvo_list_dropdown_actions']"
CVO_SEGMENT_ECLIPSE_MENU_DELETE_BUTTON = "//*[@data-testid='cvo_list_dropdown_item_actions']//*[normalize-space(text())='Delete']"
CVO_SEGMENT_ECLIPSE_MENU_CONFIRM_DELETE_BUTTON = "//*[contains(@class,'confirm-candidate-volume')]//*[normalize-space(text())='Delete']"
CVO_SEGMENT_ECLIPSE_MENU_DEACTIVATE_BUTTON = "//*[@data-testid='cvo_list_dropdown_item_actions']//*[normalize-space(text())='Deactivate']"
CVO_SEGMENT_ECLIPSE_MENU_CONFIRM_DEACTIVATE_BUTTON = "//*[contains(@class,'confirm-candidate-volume')]//*[normalize-space(text())='Confirm']"

# BASE PAGE > Add new Segment > Details & Targeting step
SEGMENT_DETAIL_NAME_TEXTBOX = "//*[@data-testid='cvo_details_targeting_name_input']"
SEGMENT_DETAIL_TARGETING_RULES_DROPDOWN = "//*[contains(@class,'el-input')]//input[@placeholder='Select']"
SEGMENT_DETAIL_MATCHES_DROPDOWN = "//*[@data-testid='match_operator_selection']//input"
SEGMENT_DETAIL_TARGETING_INPUT_TEXTBOX = "//*[@data-testid='rule_input_value']"
SEGMENT_DETAIL_CONDITIONAL_RULE_AND = "//*[@data-testid='add_rule_btn_0']"
SEGMENT_DETAIL_CONDITIONAL_RULE_OR = "//*[@data-testid='add_rule_block_btn_0']"
SEGMENT_DETAIL_NEXT_BUTTON = "//*[@data-testid='cvo_builder_next_btn']"

# BASE PAGE > Add new Segment > Details & Targeting step > Settings popup
SEGMENT_DETAIL_SETTINGS_BUTTON = "//*[@data-testid='cvo_header_setting_actions']"
SEGMENT_DETAIL_SETTINGS_DEACTIVATE_BUTTON = "//*[@data-testid='cvo_action_deactivate']"
SEGMENT_DETAIL_SETTINGS_DELETE_BUTTON = "//*[@data-testid='cvo_action_delete']"
SEGMENT_DETAIL_SETTINGS_ACTION_INFO = "//*[@data-testid='cvo_action_info']"

# BASE PAGE > Add new Segment > Status Thresholds
SEGMENT_THRESHOLDS_TAB_NAV = "//*[@data-testid='cvo_tab_status_thresholds']"
SEGMENT_THRESHOLDS_ADD_BUTTON = "//*[@data-testid='cvo_status_threshold_add_btn']"
SEGMENT_THRESHOLDS_DELETE_BUTTON = "//*[@data-testid='cvo_status_threshold_delete_btn']"
# BASE PAGE > Add new Segment > Status Thresholds > Add a Status Threshold widget
SEGMENT_THRESHOLDS_STATUS_DROPDOWN = "//*[@data-testid='cvo_status_threshold_drawer_status']//input"
SEGMENT_THRESHOLDS_NUMBER_TEXTBOX = "//*[@data-testid='cvo_status_threshold_drawer_threshold']"
SEGMENT_EDIT_THRESHOLDS_POPUP_TEXT = "//div[contains(@class,'confirm-candidate-volume')]//*[contains(@class,'box__message')]"
SEGMENT_THRESHOLDS_ACTION_DROPDOWN = "//*[@data-testid='cvo_status_threshold_drawer_action']"
SEGMENT_THRESHOLDS_SAVE_BUTTON = "//*[contains(@class,'config-drawer')]//*[contains(normalize-space(text()),'Save')]"
SEGMENT_THRESHOLDS_CONFIRM_EDIT_CHANGED_BUTTON = "//*[contains(@class,'confirm-candidate-volume')]//*[normalize-space(text())='Confirm']"
