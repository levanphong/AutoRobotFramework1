# Common Page locators
COMMON_STRONG_LEAD_NAME_XPATH = "//strong[@class='_lead_name']"
COMMON_SPAN_TEXT = "//span[contains(text(),\"{}\")]"
COMMON_SPAN_TEXT_V2 = "//span[text()='{}']"
COMMON_STRONG_TEXT = "//strong[contains(text(),\"{}\")]"
COMMON_LABEL_TEXT = "//label[contains(text(),'{}')]"
COMMON_BUTTON = "//button[contains(text(),'{}')]"
COMMON_TEXT = "//*[not(self::script) and contains(normalize-space(text()),\"{}\")]"
COMMON_DIV_TEXT = "//div[contains(text(),\"{}\")]"
COMMON_DIV_EXACT_TEXT = "//div[text()='{}']"
COMMON_P_TEXT = "//p[contains(text(),\"{}\")]"
COMMON_LINK_TEXT = "//a[contains(text(),'{}')]"
COMMON_INPUT_PLACEHOLDER = "//input[contains(@placeholder,'{}')]"
COMMON_PLACEHOLDER = "//*[contains(@placeholder,'{}')]"
COMMON_H4_TEXT = "//h4[contains(text(),\"{}\")]"
COMMON_TEXT_LAST = "(//*[contains(text(),'{}')])[last()]"
COMMON_OPTION_TEXT = "//option[contains(text(),'{}')]"
COMMON_BADGE = "//sup[text()='{}']"

# SWITCH USER
SWITCH_USER_BUTTON = "//*[@data-testid='header_btn_switch_user' or @class='user-picker desktop']"
SWITCH_USER_BUTTON_OLD_VERSION = "//*[@id='nav_user']"
USERS_FILTER_TEXT_BOX = "//input[@data-testid='header_input_search_user' or @aria-label='Search user']"
USERS_FILTER_TEXT_BOX_OLD_VERSION = "//input[@id='users_filter']"
VIEW_AS_USER_OPTION = "//*[(@data-testid='user_item_lbl_name' or @class='_user_name') and contains(text(),'{}')]"
VIEW_AS_USER_OPTION_OLD_VERSION = "//*[contains(@class,'user_name') and contains(text(),'{}')]"
CURRENT_USER_NAME_TEXT = "//*[@data-testid='user_item_icon_viewas']//parent::*//*[@data-testid='user_item_lbl_name']"
CURRENT_USER_NAME_TEXT_OLD_VERSION = "//*[contains(@class,'_login_as_item active')]//*[contains(@class,'_user_name')]"
SWITCH_USER_LIST_VIEW_AS_USER_EMPTY = "//*[contains(text(),'View as')]//following-sibling::*//*[@infinite-scroll-disabled='true']//ancestor::*[contains(@class,'el-scrollbar')]"

# SWITCH COMPANY
HEADER_COMPANY_NAME_V2 = "//div[@id='nav_stats']"
HEADER_SEARCH_COMPANY_NAME_TEXTBOX_V2 = "//input[@aria-label='Search company']"
HEADER_COMPANY_NAME_IN_LIST_V2 = "//div[@id='company-list']//*[normalize-space()='{}']"

# LOADING ICON
LOADING_ICON_1 = "//div[contains(@data-testid, 'loading_wrapper') and contains(@style, 'display: none')]"
LOADING_ICON_2 = "//*[contains(@class,'la-ball-scale-multiple la')]"
LOADING_ICON_3 = "//*[@data-testid='loading_wrapper']"
LOADING_ICON_4 = "(//*[@data-testid='loading_wrapper'])[last()]"

# MENU - SETTINGS ITEM
MENU_SPAN = "//div[contains(@data-testid, 'toolbar_btn_back')]//span[contains(text(), 'Menu')]"
SETTING_ICON = "//button[@data-testid='menu_btn_settings']"
MENU_SETTINGS_ITEM_LINK = "//*[contains(@data-testid, 'menu_item') and normalize-space()='{}']"

# TOASTED MESSAGE
TOASTED_MESSAGE_SUCCESS = "//div[contains(@class,'toasted-primary success')]"
TOASTED_MESSAGE_ERROR = "//div[contains(@class, 'toasted-primary error')]"
ICON_CLOSE_TOASTED_MESSAGE_SUCCESS = "//div[contains(@class,'toasted-primary success')]//a"
TOASTED_MESSAGE_CONTENT = "//*[contains(@class, 'toasted') and contains(text(),'{}')]" #PARAMETER IS CONTENT'S MESSAGE

# PENDO POPUP
CLOSE_PENDO_POPUP_BUTTON = "//button[contains(@id,'pendo-close-guide-')]"

# NOTIFICATION CENTER
NOTIFICATION_ICON = "//*[contains(@class,'icon-notifications')]"
JOB_REQUISITIONS_NOTIFICATION_ITEM = "//*[contains(@class,'notifications-wrapper')]//*[contains(text(),'Threshold')]"
NOTIFICATION_CHILD_ITEM = "//*[contains(@class,'icon-live')]//../../..//*[contains(text(),'{}')]"
