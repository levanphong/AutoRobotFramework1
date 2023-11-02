# BASE PAGE
NEW_WORKFLOW_BUTTON = "//span[@class='menu menu-custom']//button[@class='btn btn-primary']"
WORKFLOW_TITLE = "//strong[@class='_lead_name' and contains(text(),'{}')]"
WORKFLOW_URL = "//*[contains(text(), '{}')]/ancestor::*[contains(@data-url, '/settings/workflows/edit/')]"
WORKFLOW_ECLIPSE_ICON = "(//strong[@class='_lead_name' and contains(text(),'{}')]//ancestor::div[contains(@class,'cem-row')]//span[@class='cursor-pt icon icon-menu'])"

# BASE PAGE / Eclipse popup
WORKFLOW_ECLIPSE_POPUP_ACTIVATE_BUTTON = "//strong[@class='_lead_name' and contains(text(),'{}')]//ancestor::div[contains(@class,'cem-row')]//span[contains(text(),'Activate')]"
WORKFLOW_ECLIPSE_POPUP_DUPLICATE_BUTTON = "//strong[@class='_lead_name' and contains(text(),'{}')]//ancestor::div[contains(@class,'cem-row')]//span[contains(text(),'Duplicate')]"
WORKFLOW_ECLIPSE_POPUP_DELETE_BUTTON = "//strong[@class='_lead_name' and contains(text(),'{}')]//ancestor::div[contains(@class,'cem-row')]//div[contains(@style,'display: block')]//span[contains(text(),'Delete')]"
WORKFLOW_ECLIPSE_POPUP_UNPUBLISHED = "//*[@class='menu' and contains(@style,'display: block')]//*[contains(text(),'Never publish')]"
WORKFLOW_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON = "//div[@class='modal-content printable']//button[@class='btn btn-primary btn-sm ok-btn']"

# BASE PAGE / Workflow type popup
WORKFLOW_TYPE_VALUE = "//div[@id='step_workflow_type']//strong[contains(text(),'{}')]"

# WORKFLOW DETAIL PAGE
WORKFLOW_ACTIVE_TOGGLE = "//div[@class='workflow-status']//label[@class='toggle-btn large ml-20 hide-text']"
WORKFLOW_PUBLISHED_STATUS = "//div[@class='workflow-status']//div[contains(@class,'col-md-4 wf-status') and not(contains(@class,'hide'))]"

# CREATE WORKFLOW PAGE
WORKFLOW_NAME_TEXT_BOX = "//input[@id='workflow_name']"
AUDIENCE_DROPDOWN = "//input[@id='audience-text']"
AUDIENCE_TYPE_POPUP = "//div[@class='wf-audience-popover']"
AUDIENCE_TYPE_SEARCH_TEXT_BOX = "//input[@id='audience-search']"
AUDIENCE_TYPE_VALUE = "//div[@class='wf-audience-popover']//span[@class='audience-text' and contains(text(),'{}')]"
WF_AUDIENCE_USER_ROLES = "//span[contains(@class, 'audience-icon icon-ic_person')]//following-sibling::*[contains(text(), '{}')]"
WF_AUDIENCE_HIRING_TEAM_ROLES = "//span[contains(@class, 'audience-icon icon-job')]//following-sibling::*[contains(text(), '{}')]"
AUDIENCE_TYPE_POPUP_APPLY_BUTTON = "//div[@class='popover-footer']//*[contains(text(),'Apply')]"
AUDIENCE_TYPE_POPUP_CANCEL_BUTTON = "//div[@class='popover-footer']//*[contains(text(),'Cancel')]"
WORKFLOW_CANDIDATE_JOURNEY_DROPDOWN = "//input[@id='candidate_journey_id']//parent::div"
JOURNEY_SEARCH_TEXT_BOX = "//input[@placeholder='Search all journeys']"
WF_ADD_TASK_BUTTON = "//a[@class='btn-add-task']"
PUBLISH_WORKFLOW_BUTTON = "//button[@class='btn btn-primary btn-publish']"
WORKFLOW_PLATFORM_SELECTED_TEXT = "//select[@id='platform']//option"
WORKFLOW_LANGUAGES_DROPDOWN = "//div[@class='dropdown multilingual-language']"
WORKFLOW_MULTILINGUAL_LANGUAGE_TAB = "//div[@class='multilingual-language-tab']//li[contains(text(),'{}')]"
WORKFLOW_UPDATE_AUDIENCE_WARING_MESSAGE = "//*[@id='message-ctn']//div[contains(text(),'{}')]"
WORKFLOW_LOCATION_CONTACT_INPUT = "//*[contains(@id, 'workflow__location__contact')]//input[contains(@placeholder, 'Select Location')]"
WORKFLOW_SEARCH_LOCATION_INPUT = "//input[@placeholder='Search for location']"
WORKFLOW_LOCATION_NAME_CHECKBOX = "//*[contains(text(), '{}')]//ancestor::div[contains(@class, 'ai-handle ')]//input[contains(@class, 'cbx-input')]"
WORKFLOW_TRIGGER_ACTION_NAME = "//ul[contains(@class, 'workflow-dropdown action-dropdown')]//a[not (contains(@class, 'hide'))]"
WORKFLOW_ADD_CONDITION_LOCATION_INPUT = "//*[contains(@placeholder, 'Select') and contains(@class, 'custom-input')]"
WORKFLOW_ADD_CONDITION_GROUP_CHECKBOX = "//div[contains(text(), '{}')]//ancestor::div[contains(@class, 'custom-select')]//*[contains(@class, 'custom-checkbox')]//span"

# CREATE WORKFLOW PAGE / Language selected Please Note popup
LANGUAGE_PLEASE_NOTE_MESSAGE = "//div[@class='ai-modal modal fade modal-note modal-align-center alert-modal in']//div[@class='modal-body']"
LANGUAGE_PLEASE_NOTE_GOT_IT_BUTTON = "//div[@class='ai-modal modal fade modal-note modal-align-center alert-modal in']//button[@class='btn btn-primary btn-sm ok-btn']"

# CREATE WORKFLOW PAGE / Change audience popup
WORKFLOW_CHANGE_AUDIENCE_POPUP_MESSAGE = "//div[@class='ai-modal modal fade confirm-modal in']//div[@class='modal-body']"
WORKFLOW_CHANGE_AUDIENCE_CONFIRM_BUTTON = "//div[@class='ai-modal modal fade confirm-modal in']//button[@class='btn btn-primary btn-sm ok-btn']"
WORKFLOW_CHANGE_AUDIENCE_CANCEL_BUTTON = "//div[@class='ai-modal modal fade confirm-modal in']//button[@class='btn btn-default btn-sm cancel-btn']"

# CREATE WORKFLOW PAGE / Add Task
WF_TASK_NAME_TEXTBOX = "//input[@aria-label='Add task name']"
ADD_TASK_TRIGGER_BUTTON = "//a[@class='dropdown-toggle btn-add-trigger']"
CANDIDATE_STATUS_UPDATED_OPTION = "//li[text()='Add Trigger']//following-sibling::li//span[@class='item-icon icon icon-olivia status-inbox']"
STATUS_SELECTION = "//input[@id='status-selector']"
STATUS_SEARCH_TEXT_BOX = "//input[@aria-label='Find a status']"
STATUS_VALUE = "//div[@class='status-item' and contains(text(),'{}')]"
ADD_TRIGGER_BUTTON = "(//div[@class='btn-add-action dropdown-toggle'])"
SEND_CONVERSATION_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='9']"
SEND_COMMUNICATION_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='0']"
SEND_OFFER_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='8']"
ADD_CONDITION_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='13']"
REQUEST_RATING_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='1']"
DELAY_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='5']"
MOVE_TO_STATUS_ACTION = "//div[@class='add-action dropdown open']//a[@data-type='6']"
SAVE_TASK_BUTTON = "//button[@class='btn btn-primary btn-save-task']"
CANCEL_TASK_BUTTON = "//button[@class='btn btn-transparent btn-cancel-task']"
WF_SEND_FORM_ICON = "//*[contains(@class, 'action-dropdown')]//i[contains(@class, 'glyphicon-list-alt')]"
WF_ADD_TASK_TRIGGER_ITEM = "(//*[contains(@class, 'action-dropdown')]/li[normalize-space()='{}'])"

# CREATE WORKFLOW PAGE / Add Task / Start Point time trigger
START_POINT_TIMED_TOGGLE = "//label[contains(@class,'toggle') and contains(text(),'Immediately after trigger')]"
START_POINT_TIME_TEXT_BOX = "//input[@id='time_amount']"
START_POINT_TIME_UNIT_DROPDOWN = "//select[@name='time_unit']"
START_POINT_TIME_UNIT_VALUE = "//select[@name='time_unit']//option[contains(text(),'{}')]"
START_POINT_TIME_OF_DAY_HOUR_TEXT_BOX = "//input[@name='time_of_day_hour']"
START_POINT_TIME_OF_DAY_CLOCK_TEXT_BOX = "//select[@name='time_of_day_clock']"

# CREATE WORKFLOW PAGE / Add Task / Request rating
TASK_RATING_DROPDOWN = "//input[@placeholder='Select Rating']"
TASK_RATING_SEARCH_TEXT_BOX = "//input[@placeholder='Find a rating']"
TASK_RATING_EMAIL_SUBJECT = "(//div[@placeholder='Add subject line'])"

# CREATE WORKFLOW PAGE / Add Task / Send Communication
EMAIL_OLIVIA_EDITOR_CONTENT_TEXT_AREA = "//div[contains(@class,'ql-editor')]"
QL_MENTION_LIST_ITEM = "//li[contains(@class,'ql-mention-list-item')]"
QL_MENTION_LIST_ITEM_VALUE = "//li[contains(@class,'ql-mention-list-item') and contains(text(),'{}')]"
QL_MENTION_HIGHLIGHT_ITEM_VALUE = "//span[contains(@data-value,'{}')]"
SMS_OLIVIA_EDITOR_TAB = "//ul[@class='nav nav-tabs']//li[@data-type='sms']"
SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA = "//div[contains(@class,'ai-editor editor-sms')]"
TEXT_COMPLETE_ITEM_VALUE = "//ul[contains(@style,'display: block;')]//li[contains(@class,'textcomplete-item')]//a[contains(text(),'{}')]"
TEXT_COMPLETE_HIGHLIGHT_ITEM_VALUE = "//div[contains(@class,'ai-editor editor-sms')]//span[@class='highlight' and contains(text(),'{}')]"
EMAIL_OLIVIA_SUBJECT_TEXT_BOX = "//div[@data-type='email']//div[@class='ai-editor editor-subject']"
WF_EMAIL_OLIVIA_SUBJECT_TEXT_BOX_BY_INDEX = "(//div[@data-type='email']//div[@class='ai-editor editor-subject'])[{}]"
WF_EMAIL_OLIVIA_CONTENT_TEXT_BOX_BY_INDEX = "(//div[contains(@class,'ql-editor')])[{}]"
WF_SMS_OLIVIA_EDITOR_TAB_BY_INDEX = "(//ul[@class='nav nav-tabs']//li[@data-type='sms'])[{}]"
WF_SMS_OLIVIA_EDITOR_CONTENT_TEXT_AREA_BY_INDEX = "(//div[contains(@class,'ai-editor editor-sms')])[{}]"

# CREATE WORKFLOW PAGE / Add Task / Send Offer
EMAIL_OFFER_OLIVIA_EDITOR_CONTENT_TEXT_AREA = "//div[@class='ai-editor editor-message']"

# CREATE WORKFLOW PAGE / Add Task / Add Condition
TASK_ADD_CONDITION_BUTTON = "//button[@class='btn-sm btn-primary add-condition-blocks']"
TASK_CONDITION_NAME_TEXT_BOX = "//input[@placeholder='Name your condition']"
TASK_CONDITION_TARGET_RULE_DROPDOWN = "(//div[@id='conditional-criteria-sidebar']//div[@class='custom-select'])[1]//*[contains(@class, 'selected-item')]"
TASK_CONDITION_TARGET_RULE_VALUE = "//div[@class='custom-select__dropdown-menu']//*[contains(text(),'{}')]"
TASK_CONDITION_MATCHES_RULE_DROPDOWN = "(//div[@id='conditional-criteria-sidebar']//div[@class='custom-select'])[2]//*[contains(@class, 'selected-item')]"
TASK_CONDITION_INPUT_TEXT_BOX = "//input[@placeholder='Text Input']"
TASK_CONDITION_DISABLED_INPUT_TEXT_BOX = "//*[contains(@class, 'ai-input') and @disabled]"
TASK_CONDITION_SAVE_BUTTON = "//button[@class='btn btn-primary']"
TASK_CONDITION_CANCEL_BUTTON = "//*[contains(@class, 'conditional-criteria-header__buttons')]//*[text()='Cancel']"
TASK_CONDITION_APPLY_BUTTON = "//button[@class='btn btn-primary apply-condition-btn']"
ADD_CONDITION_ACTIONS_ICON = "(//div[contains(@id,'add-condition')]//i[@class='icon-plus1'])"
ADD_CONDITION_ACTION_VALUE = "//div[@class='c-actions']//div[@class='c-action']//span[contains(text(),'{}')]"
ADD_CONDITION_AND_CONDITION_BUTTON = "//*[contains(@class, 'add-condition')]"
ADD_CONDITION_OR_CONDITION_BUTTON = "//*[contains(@class, 'or-condition')]"
ADD_CONDITION_TITLE_COLUMN_VALUE = "//*[contains(@class, 'conditional-criteria-container__rule-block')]//*[normalize-space()='{}']"
ADD_CONDITION_NO_RESULT_FOUND = "//*[contains(@class,'custom-select__no-result')]"
ADD_CONDITION_TARGETING_SEARCH_TEXTBOX = "//*[contains(@aria-label,'Search all attributes')]"
ADD_CONDITION_SELECT_GROUP_INPUT = "//div[contains(@class, 'custom-select')]//span[contains(@class, 'custom-select__selected-item') and (contains(text(), 'Select'))]"
ADD_CONDITION_LOCATION_INPUT = "//*[contains(@placeholder, 'Select') and contains(@class, 'custom-input')]"
ADD_CONDITION_GROUP_CHECKBOX = "//div[contains(text(), '{}')]//ancestor::div[contains(@class, 'custom-select')]//*[contains(@class, 'custom-checkbox')]//span"
ADD_CONDITION_ITEM_CONDITION_ON_SLIDE_OUT = "//*[contains(@class, 'conditional-criteria-block minimize')]//*[contains(text(), '{}')]"
ADD_CONDITION_ERROR_MESSAGE = "//*[contains(@class, 'has-error')]//span[contains(text(), '{}')]"
ADD_CONDITION_ADD_ITEM_ACTION_BUTTON = "//*[contains(text(), '{}')]//ancestor::div[contains(@class, 'condition_item')]//*[contains(@class, 'c-item-add')]"


# CREATE WORKFLOW PAGE / Add Task / Delay
TASK_DELAY_TEXT_BOX = "//div[@class='exact-time-triggers-delay']//input[@aria-label='Delay value']"

# CREATE WORKFLOW PAGE / Add Task / Move to status
WF_MOVE_TO_STATUS_VALUE = "//div[contains(@class, 'form-group custom-form-group')]//*[contains(text(),' {} ')]"
