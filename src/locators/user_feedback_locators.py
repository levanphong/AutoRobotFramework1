# BASE PAGE
USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_MIDDLE_BUTTON = "//a[contains(text(),'Create Campaign')]"
USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_HEADER_BUTTON = "//button[contains(text(),'Create Campaign')]"
USER_FEEDBACK_PAGE_ELLIPSIS_MENU = "(//div[contains(@class,'campaign-name') and contains(text(),'{}')]//following-sibling::div[contains(@class,'campaign-status') and contains(text(),'{}')]//span[contains(@data-toggle,'dropdown')])[last()]"
USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON = "(//div[contains(@class,'campaign-name') and contains(text(),'{}')]//following-sibling::div[contains(@class,'campaign-status') and contains(text(),'{}')]//a[contains(text(),'{}')]//parent::li)[last()]"
USER_FEEDBACK_PAGE_CAMPAIGN_NAME_TITLE = "(//div[contains(@class,'campaign-status') and contains(text(),'{}')]//preceding-sibling::div[contains(@class,'campaign-name') and contains(text(),'{}')])[last()]"
USER_FEEDBACK_PAGE_FILTER_CAMPAIGN_INPUT = "//input[@id='filter-input']"
USER_FEEDBACK_PAGE_CAMPAIGN_SEARCH = "//div[contains(@class,'campaign-search')]//span[contains(@class,'icon-search')]"
USER_FEEDBACK_PAGE_CAMPAIGN_DELETE_BUTTON = "//button[contains(text(),'Delete Campaign')]"

# BASE PAGE / Add New Campaign page
USER_FEEDBACK_CAMPAIGN_MENU_ITEM = "//div[@id='user-feedback-detail']//ul[contains(@class,'items')]//span[contains(@class,'ico-text')]"
USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON = "//button[contains(text(),'Next')]"
USER_FEEDBACK_CAMPAIGN_FINISH_BUTTON = "//button[contains(text(),'Finish and Save')]"
USER_FEEDBACK_CAMPAIGN_NUMBER_OF_STATUS = "//div[contains(@class,'campaign-list')]//div[contains(@class,'campaign-status') and contains(text(),'{}')]"

# BASE PAGE / Title and Audience page
USER_FEEDBACK_CAMPAIGN_SELECT_RULE_CHECKBOX = "//span[contains(text(),'{}')]//preceding-sibling::div[contains(@class, 'checkbox')]"
USER_FEEDBACK_CAMPAIGN_TITLE_INPUT = "//div[contains(@class,'title-audience')]//div[contains(@class,'controls')]//input[contains(@placeholder,'Enter title')]"
USER_FEEDBACK_CAMPAIGN_ADD_RULE_BUTTON = "//div[contains(@class,'title-audience')]//div[contains(@class,'controls')]//button[@id='dropdown-role']"

# BASE PAGE / Content page
USER_FEEDBACK_CAMPAIGN_RATING_SELECT = "//div[contains(@class,'controls')]//select[contains(@class,'ai-input')]"
USER_FEEDBACK_CAMPAIGN_RATING_OPTION = "//div[contains(@class,'controls')]//select//option[contains(text(),'{}')]"
USER_FEEDBACK_CAMPAIGN_CHANEL_EMAIL_SELECT = "//div[contains(@class,'list-channel')]//div[contains(text(),'Email')]//parent::div[contains(@class,'channel')]"
USER_FEEDBACK_CAMPAIGN_CHANEL_OLIVIA_ASSIST_SELECT = "//div[contains(@class,'list-channel')]//div[contains(text(),'Olivia Assist')]"
USER_FEEDBACK_CAMPAIGN_MESSAGE_OLIVIA_INPUT = "//div[contains(@class,'ai-editor')]"
USER_FEEDBACK_CAMPAIGN_EMAIL_INPUT = "//div[contains(@class,'email-rating') and (not(contains(@style,'display')))]//input"
USER_FEEDBACK_CAMPAIGN_EMAIL = "//div[contains(@class,'email-rating') and @style='']"

# BASE PAGE / Frequency page add Date and Time
USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_AND_DATE_BUTTON = "//span[contains(text(),'Add Date & Time')]//parent::button"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_DATE_BUTTON = "(//div[contains(@class,'date')]/label[contains(text(),'Date')]//following-sibling::input[contains(@class,'ai-input')])[last()]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_BUTTON = "(//div[contains(@class,'time-select')]/span[contains(@class,'select2')])[last()]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DATE_DROPDOWN = "//div[contains(@class,'arrowTop')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIME_DROPDOWN = "//ul[contains(@id,'select2-time')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIMEZONE_DROPDOWN = "//ul[@id='select2-timezone_start-results']"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_DROPDOWN = "//div[contains(@class,'controls')]//div[contains(@class,'list-frequency')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIMEZONE_BUTTON = "//div[contains(@class,'v-timezone-wrapper')]/span[contains(@class,'select2')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIMEZONE_SELECT = "//li[contains(@id,'select2-timezone') and contains(@id,'{}')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIME_SELECT = "//li[contains(@id,'select2-time') and contains(@id,'{}')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_SELECT = "//div[contains(@class,'list-frequency')]//a[contains(text(),'{}')]//parent::div"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_BUTTON = "//div[contains(@class,'frequency-type')]//div[contains(@class,'controls')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_OF_MONTHLY_SELECT = "//input[contains(@aria-label,'Select day')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_END_SELECT = "//div[contains(@class,'arrowBottom')]//span[normalize-space()='{}']"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_BEGIN_SELECT = "(//div[contains(@class,'arrowTop')]//span[normalize-space()='{}'])[last()]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_MONTHLY_ADD_BUTTON = "//div[contains(@class,'arrowTop') or contains(@class,'arrowBottom')]//button[contains(@class,'btn-confirm') and contains(text(),'Apply')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_DROPDOWN_LIST = "//div[contains(@class,'frequency-type')]//div[contains(@class,'list-frequency')]"
# BASE PAGE / Frequency page add Condition
USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_AND_CONDITION_BUTTON = "//span[contains(text(),'Add Condition')]//parent::button"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_SELECT_DROPDOWN = "//div[contains(@class,'condition')]//select[contains(@class,'ai-input')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_OPTION = "//div[contains(@class,'condition')]//select[contains(@class,'ai-input')]//option[contains(text(),'{}')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_TIME_INPUT = "//div[contains(@class,'time-condition')]//input[contains(@class,'ai-input')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_TIME_OPTION = "//div[contains(@class,'time-condition')]//select[contains(@class,'ai-input')]//option[contains(text(),'{}')]"
USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_CANDIDATE_JOURNEY_AND_STATUS_OPTION = "//div[contains(@class,'candidate-journey')]//option[contains(text(),'{}')]"

# BASE PAGE / Frequency page add Confirmation
USER_FEEDBACK_CAMPAIGN_CONFIRMATION_CHOOSE_STATUS_RADIO = "//input[@id='id_save_{}']//parent::div[contains(@class,'cusstom-radio')]"
USER_FEEDBACK_CAMPAIGN_CONFIRMATION_SAVE_CAMPAIGN_BUTTON = "//button[contains(text(),'Save Campaign')]"
USER_FEEDBACK_CAMPAIGN_CONFIRMATION_TITLE_TEXT = "//div[contains(@class,'modal-body')]//div[contains(@class,'title-text')]"
