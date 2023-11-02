# BASE PAGE
ATTRIBUTE_LIST_RECORD_ECLIPSE_MENU = "//*[contains(@class,'data-list-container')]//*[contains(@class,'items')]//*[contains(@class,'icon-menu')]"
ATTRIBUTE_LIST_RECORD_DESCRIPTION_POPUP = """//*[contains(@class,'popup_container')]//*[contains(text(),"{}")]"""
ATTRIBUTE_LIST_HEADER_COLUMN = "//*[contains(@class,'header-col')]//parent::*//*[normalize-space(text())='{}']"

# BASE PAGE / Eclipse menu
SYSTEM_ATTRIBUTE_ECLIPSE_MENU_OPTION = "//*[contains(@class,'data-list-container')]//*[contains(@class,'menu')]//*[normalize-space(text())='{}']"

# BASE PAGE / Eclipse menu / Delete / Delete confirm popup
SYSTEM_ATTRIBUTE_DELETE_POPUP_BUTTON = "//*[contains(@class,'delete-confirm-modal')]//button[normalize-space(text())='{}']"

# BASE PAGE / Right Menu Navigator
NAV_ITEM_TEXT = "//div[@class='nav-item_text']//span[contains(text(),'{}')]"

# BASE PAGE / Locations / All Location Attributes
LOCATION_ATTRIBUTE_KEY_NAME_TEXT = "//div[@class='item-cell column-key-name v-center text']//span"

# BASE PAGE / Candidates / Custom Candidate Attributes
SEARCH_ATTRIBUTE_TEXT_BOX = "//input[@aria-label='Search attributes']"
REMOVE_SEARCH_CONTENT_ICON = "//i[@class='icon icon-remove']"
ATTRIBUTE_NAME_IN_COLUMN = "//div[@class='item-cell column-name font-semi-bold v-center text']//span[contains(text(),'{}')]"

# BASE PAGE / Candidates / Custom Candidate Attributes / Add Custom Candidate Attribute Widget
ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX = "//input[@id='id_attribute_name']"
ADD_CUSTOM_ATTRIBUTE_NAME_TEXT_BOX_COUNTER = "//input[@id='id_attribute_name']//following-sibling::*[contains(@class,'count')]"
ADD_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_DROPDOWN = "//*[contains(@class, 'custom-select-drop-down__select')]//*"
ADD_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_ITEM = "//*[contains(@class, 'custom-select-drop-down__items')]//*[contains(text(), '{}')]"
ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX = "//input[@id='id_attribute_key']"
ADD_CUSTOM_ATTRIBUTE_KEY_NAME_TEXT_BOX_COUNTER = "//input[@id='id_attribute_key']//following-sibling::*[contains(@class,'count')]"
ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX = "//input[@id='id_attribute_desc']"
ADD_CUSTOM_ATTRIBUTE_DESC_TEXT_BOX_COUNTER = "//input[@id='id_attribute_desc']//following-sibling::*[contains(@class,'count')]"
ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_DROPDOWN = "//*[contains(@class,'id_privacy_setting')]"
ADD_CUSTOM_ATTRIBUTE_PRIVACY_SETTING_VALUE = "//*[@id='privacy-dropdown']//div[contains(text(),'{}')]"
ADD_CUSTOM_ATTRIBUTE_PRIVACY_WARNING_MESSAGE = "//*[contains(@class,'warning')]"
ADD_CUSTOM_ATTRIBUTE_TO_REPORTS_TOGGLE = "//*[@for='id_add_to_report']"
ADD_CUSTOM_ATTRIBUTE_CREATE_BUTTON = "//div[contains(@class,'ca-footer')]//button[contains(@class,'btn-primary')]"
ADD_CUSTOM_ATTRIBUTE_CANCEL_BUTTON = "//div[contains(@class,'ca-footer')]//button[contains(@class,'btn-default')]"
ADD_CUSTOM_ATTRIBUTE_TOASTED_MESSAGE_ERROR = "//div[contains(@class, 'jq-icon-error')]"
ADD_CUSTOM_ATTRIBUTE_REQUIRED_MESSAGE_ERROR = "//*[contains(text(),'{}')]//ancestor::*[contains(@class,'form-group')]//*[contains(@class,'help-block')]"
