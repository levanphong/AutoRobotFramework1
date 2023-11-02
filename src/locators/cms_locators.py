# BASE PAGE / Right menu
NAV_SUB_MENU_TEXT = "//*[contains(@class, 'vertical-navigation')]//*[contains(text(),'{}')]"
TITLE_PAGE_LABEL = "//*[contains(@class, 'title-page')]"

# BASE PAGE / Candidate Care
CANDIDATE_CARE_GROUP_TITLE = "//div[@class='list-group-ctn']//span[@class='group-name' and contains(text(),'{}')]"
CMS_UNPUBLISHED_BUTTON = "//span[@class='status unpublished']"
CMS_PUBLISH_STATUS_BUTTON = "//button[@class='button-publish active']"
CMS_PUBLISH_BUTTON = "//button[@class='btn-publish']"
CMS_QUESTION_ECLIPSE_ICON = "//div[contains(text(),'{}')]//following-sibling::div[contains(@class,'menu')]//i[@class='icon icon-menu']"
CMS_QUESTION_CHANGE_TO_LIVE_OPTION = "//div[contains(text(),'{}')]//following-sibling::div[contains(@class,'menu')]//*[contains(text(),'Change to Live')]"
CMS_SEARCH_INPUT = "//div[contains(@class,'list-header-search')]//input[contains(@class, 'search-cms')]"
CMS_SAMPLE_QUESION = "//div[contains(@class,'sampling-question')]//mark[text()='Start']/parent::div"
CMS_QUESTION_CHANGE_TO_NOT_LIVE_OPTION = "//div[text()='{}']//following-sibling::div[contains(@class,'menu')]//*[text()='Change to Not Live']"
CMS_QUESTION_STATUS_LIVE = "//div[text()='{}']//following-sibling::div[contains(@class,'item')]//div[contains(@class,'status live')]"
CMS_QUESTION_STATUS_NOT_LIVE = "//div[text()='{}']//following-sibling::div[contains(@class,'item')]//div[contains(@class,'status not-live')]"
CMS_QUESTION_DELETE_OPTION = "//div[text()='{}']//following-sibling::div[contains(@class,'menu')]//*[text()='Delete']"

# BASE PAGE / Candidate Care / Benefits
CANDIDATE_CARE_SAMPLE_QUESTION_SAVE_BUTTON = "//div[@class='cms-header__buttons']//button[@class='btn btn-primary']"
CANDIDATE_CARE_SAMPLE_QUESTION_PREVIEW_TAB = "//i[@class='icon icon-preview']"
CANDIDATE_CARE_BACK_BUTTON = "//span[contains(@class,'icon-arrow-left')]"
ADDED_AUDIENCE_NAME = "//div[@class='info-audience']//span[contains(text(),'{}')]"
ADDED_AUDIENCE_DELETE_ICON = "//span[contains(text(),'{}')]//parent::div//following-sibling::div//i[@class='icon icon-delete2']"

# BASE PAGE / Candidate Care / Benefits / Right Menu
ADD_AUDIENCE_POPUP_SEARCH_TEXT_BOX = "//div[@class='cms-audience__dropdown-menu']//input[@placeholder='Search for audience']"
ADD_AUDIENCE_POPUP_CHECKBOX = "//ul[@class='audience-list']//label[contains(text(),'{}')]//parent::div//parent::div//div[@class='custom-checkbox']//span"
ADD_AUDIENCE_POPUP_APPLY_BUTTON = "//div[@class='cms-audience__dropdown-btn']//button[@class='btn btn-md btn-primary']"

# BASE PAGE / Candidate Care / Benefits / Answer Tab
OLIVIA_RESPONSE_HASHTAG_ICON = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//span[@class='icon-hashtag dropdown-toggle']"
OLIVIA_RESPONSE_HASHTAG_TEXT = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//li[contains(@class, 'textcomplete-item')]//a//span[not(contains(@class,'highlight'))]"
OLIVIA_RESPONSE_HASHTAG_TEXT_VALUE = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//li[contains(@class, 'textcomplete-item')]//a//span[not(contains(@class,'highlight')) and contains(text(),'{}')]"
OLIVIA_RESPONSE_TEXT_BOX = "//div[contains(@class,'emojionearea ai-editor editor-message')]//div[contains(@class,'emojionearea-editor')]"
OLIVIA_RESPONSE_SECOND_TEXT_BOX = "//div[contains(@class,'bubble-container')]//div[contains(@class,'emojionearea-editor')]"
OLIVIA_RESPONSE_HIGHLIGHT_TEXT = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//div[contains(@class,'emojionearea-editor')]//span[contains(@class,'highlight')]"
BENEFITS_SAMPLE_QUESTION_TEXT = "//div[contains(@class,'item width-40 sampling-question') and contains(text(),'{}')]"
OLIVIA_ANSWER_TOP_TAB = "//div[contains(@class,'answer-top-tabs')]//li[contains(text(),'{}')]"
ARROW_LEFT_BUTTON = "//span[contains(@class, 'icon-arrow-left')]"  # used for return back to the main page from care answer page

# BASE PAGE / Candidate Care / Benefits / Preview Tab
OLIVIA_PREVIEW_TOP_TAB = "//div[@class='preview__option text-center btn-group btn-group-justified']//button[contains(text(),'{}')]"

# BASE PAGE / Employee Care
EMPLOYEE_CARE_TITLE = "//div[@class='care-management']//div[contains(@class, 'header__title')]"
EMPLOYEE_CARE_GROUP_TITLE = "//div[@class='list-group-ctn']//span[@class='group-name' and text()='{}']"
EMPLOYEE_CARE_GEAR_SETTING_DROPDOWN_ITEM = "//div[@id='settings-dropdown']//span[text()='{}']"
EMPLOYEE_CARE_GEAR_SETTING_ICON = "//div[@id='settings-dropdown']"
EMPLOYEE_CARE_SEARCH_TEXT_BOX = "//div[@class='settings-menu']//input[@placeholder='Search by question, topic, or keyword']"
EMPLOYEE_CARE_SEARCH_QUESTION_RESULT = "//div[@class='detail-group search-box']//div[contains(@class,'sampling-question')]//*[text()='{}']"
EMPLOYEE_CARE_BENEFITS_GROUP_COLUMN_TITLE = "//span[text()='Benefits']/ancestor::div[contains(@class, 'content-item')]/following-sibling::div//div[contains(text(),'{}')]"

# BASE PAGE / Employee Care / Add Custom Topics
EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_TEXT_BOX = "//input[@placeholder='{}']"
EMPLOYEE_CARE_ADD_CUSTOM_TOPICS_BUTTON = "//div[contains(@class,'modal-footer')]//button[contains(text(),'{}')]"

# BASE PAGE / Employee Care / Benefits
EMPLOYEE_CARE_SAMPLE_QUESTION_BUTTON = "//div[@id='cms-care-system']//div[contains(@class,'cms-header__buttons')]//button[contains(text(),'{}')]"
EMPLOYEE_CARE_SAMPLE_QUESTION_MENU_ACTIVE_TAB = "//div[@class='cms-care-anwser-container__navigators']//li[contains(@class, 'active')]//span[contains(text(),'{}')]"
EMPLOYEE_CARE_SAMPLE_QUESTION_MENU_TAB = "//div[@class='cms-care-anwser-container__navigators']//li[contains(@class, 'nav-item')]//span[contains(text(),'{}')]"

# BASE PAGE / Employee Care / Benefits / Right Menu
MENU_ACTIVE = "//div[@class='cms-audience']//div[contains(@class,'active')]//span[contains(text(),'{}')]"
AUDIENCE_COUNTRY_TAB = "//div[contains(@class,'cms-audience__country')]//div[contains(@class,'info-audience')]//i[contains(@class,'icon-location')]/following-sibling::span[contains(text(),'{}')]"

# BASE PAGE / Employee Care / Benefits / Answer Tab
OLIVIA_RESPONSE_EMOJI_ICON = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//span[contains(@class,'icon-emoji emoji-placeholder')]"
OLIVIA_RESPONSE_EMOJI_ICON_BUTTON = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//div[contains(@class,'emojionearea-button-open')]"
OLIVIA_RESPONSE_EMOJI_ICON_VALUE = "//i[contains(@class,'emojibtn') and contains(@title,'{}')]"
OLIVIA_RESPONSE_EMOJI_ICON_CONTAIN_BOX = "//div[contains(@class,'emojionearea-button active')]/following-sibling::div[contains(@class,'emojionearea-picker')]"
OLIVIA_RESPONSE_BOLD_BUTTON = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//button[contains(@class,'tool-bold icon-bold')]"
OLIVIA_RESPONSE_BOLD_TEXT = "//div[contains(@class,'msg-training ours') and not(contains(@style,'display: none;'))]//div[contains(@class,'emojionearea-editor')]//b[contains(text(),'{}')]"
OLIVIA_RESPONSE_PLUS_BUTTON = "//div[contains(@class,'action-training-ctn')]//div[contains(@class,'icon-plus')]"
OLIVIA_RESPONSE_INDEX_MESSAGE = "//div[contains(@class,'action-training-ctn')]//div[contains(@class,'order-number') and not(contains(@class,'active'))]//span[contains(text(),'{}')]"
OLIVIA_RESPONSE_INDEX_MESSAGE_ACTIVE = "//div[contains(@class,'action-training-ctn')]//div[contains(@class,'order-number active')]//span[contains(text(),'{}')]"
OLIVIA_RESPONSE_TRASH_ICON = "//div[contains(@class,'order-number active')]//span[contains(@class,'remove')]"
OLIVIA_RESPONSE_ADD_MESSAGE_BUTTON = "//div[contains(@class, 'bubble-container')]//button[contains(@class, 'bubble-btn') and text()='Add a Message']"
OLIVIA_RESPONSE_MESSAGE_TRASH_ICON = "//div[contains(@class,'msg-training ours')]//i[contains(@class,'icon icon-delete')]"

# BASE PAGE / Employee Care / Benefits / Collection Tab
COLLECTION_TAB_ADD_CONTENT_BUTTON = "//i[contains(@class,'icon-plus')]/parent::button[contains(@class, 'header__add')]"
COLLECTION_TAB_CONTENT_COLLECTION = "//div[contains(@Class,'card-title') and text()='{}']/ancestor::div[contains(@Class, 'card')]"
COLLECTION_TAB_CONTENT_COLLECTION_TITLE = "//div[contains(@class,'card-title') and text()='{}']"

# BASE PAGE / Audience Builder
SEARCH_AUDIENCE_TEXT_BOX = "//input[@aria-label='Search audience']"
AUDIENCE_NAME_IN_COLUMN = "//div[@class='item-cell column-name font-semi-bold v-center']//span[contains(text(),'{}')]"
ADD_AUDIENCE_BUTTON = "//button[@class='btn-primary cms-builder-dashboard__add-new-btn']"
AUDIENCE_NAME_TEXT_BOX = "//div[@class='cms-builder-detail-wrapper']//div[@class='editable-text-field']//input"
AUDIENCE_NAME_TEXT_BOX_LABEL = "//div[contains(@class, 'cms-builder-detail-wrapper')]//div[contains(@class, 'editable-text-field')]//label"
AUDIENCE_TARGETING_RULES_DROPDOWN = "(//li[@class='custom-select__label'])[1]"
AUDIENCE_MATCHES_RULES_DROPDOWN = "(//li[@class='custom-select__label'])[2]"
AUDIENCE_RULES_OPTION = "//div[@class='custom-select__dropdown-item__label' and contains(text(),'{}')]"
AUDIENCE_BUILDER_CREATE_BUTTON = "//div[@class='cms-builder-header__buttons']//button[@class='btn btn-primary']"
AUDIENCE_BUILDER_CANCEL_BUTTON = "//div[contains(@class, 'cms-builder-header__buttons')]//button[contains(@class, 'btn btn-default')]"
AUDIENCE_INPUT_SELECT_DROPDOWN = "//span[(contains(@class, 'custom-select') or contains(@class, 'audience-builder-status')) and contains(text(), '{}')]"
AUDIENCE_BULDER_ELIPSIS_BUTTON = "//*[normalize-space()='{}']//ancestor::div[contains(@class, 'items')]//*[contains(@class,'icon-menu')]"
AUDIENCE_BUILDER_ELIPSIS_DELETE = "//*[normalize-space()='{}']//ancestor::div[contains(@class, 'items')]//*[contains(text(), 'Delete')]"
AUDIENCE_BUILDER_ELIPSIS_EDIT_DEACTIVATE_OPTIONS = "//*[normalize-space()='{}']//ancestor::div[contains(@class, 'items')]//*[contains(text(), '{}')]"
AUDIENCE_BUILDER_TEXT_INPUT = "//input[contains(@class,'ai-input')]"
AUDIENCE_BUILDER_TEAM_DROPDOWN = "//div[contains(@class,'selected-team-box')]"
AUDIENCE_BUILDER_TEAM_DROPDOWN_ITEM = "//div[contains(@class,'option-name') and contains(text(),'{}')]"
AUDIENCE_BUILDER_SUB_MENU_ICON = "//*[contains(@class,'sub-menu table-cell') and @id='sub-menu']"
AUDIENCE_BUILDER_CONFIRM_BUILDER = "//div[contains(@class, 'modal-content printable')]"
AUDIENCE_BUILDER_MODAL_DELETE_OR_DEACTIVATE_BUTTON = "//*[normalize-space()='{}']//ancestor::div[contains(@class, 'modal-dialog')]//button[contains(@class, 'ok-btn')]"
AUDIENCE_NAME_WITH_ITS_STATUS = "//*[normalize-space()='{}']//parent::div[contains(@class, 'item-cell')]//following-sibling::div[contains(@class, 'column-status')]//span[contains(text(), '{}')]"
AUDIENCE_TARGETING_RULES_DROPDOWN_OPTION = "(//*[contains(@class, 'custom-select')]//span[contains(text(), 'Select Rule')])"  # used for checking Add an audience with the combination of many targeting rules
AUDIENCE_MATCHES_RULES_DROPDOWN_OPTION = "(//*[contains(@class, 'custom-select')]//span[text()='Select'])"   # used for Add an audience with the combination of many targeting rules
AUDIENCE_RULES_OPTION_2ND = "(//*[contains(@class, 'custom-select__dropdown-item__label') and contains(text(),'{}')])[last()]"    # Add an audience with the combination of many targeting rules

# BASE PAGE / Audience Builder / Sub-menu icon
AUDIENCE_BUILDER_DELETE_BUTTON = "//div[contains(@class,'menu') and contains(@style,'display: block')]//span[contains(text(),'Delete')]"
AUDIENCE_BUILDER_AND_CONDITION_BUTTON = "//button[contains(@class, 'btn btn-default and-condition')]"

# BASE PAGE / Audience Builder / Assigned Location Input Rule
AUDIENCE_ASSIGNED_LOCATION_INPUT_DROPDOWN = "//span[@class='assign-location__selected-item']"
AUDIENCE_ASSIGNED_LOCATION_CHECKBOX = "//div[@class='location-tree__row']//div[@class='indeterminate-select']//span"
AUDIENCE_ASSIGNED_LOCATION_SEARCH_BOX = "//input[contains(@aria-label,'Search for location')]"
AUDIENCE_ASSIGNED_LOCATION_ITEM = "(//div[@class='location-tree__row']//div[@class='indeterminate-select']//span)[{}]"
AUDIENCE_ASSIGNED_LOCATION_APPLY_BUTTON = "//div[@class='assign-location__dropdown-btn']//button[@class='btn btn-sm btn-primary']"
AUDIENCE_ASSIGNED_LOCATION_CANCEL_BUTTON = "//div[contains(@class, 'assign-location__dropdown-btn')]//button[contains(@class, 'btn btn-sm btn-default')]"

# BASE PAGE / Audience Builder / Conversation State Input Rule
AUDIENCE_SELECT_STATE_INPUT_DROPDOWN = "//span[contains(@class,'custom-select__selected-item') and contains(text(),'Select State')]"
AUDIENCE_SELECT_STATE_INPUT_ITEM = "//li[contains(@class,'custom-select__dropdown-item')]//div[contains(text(),'{}')]"
AUDIENCE_SELECT_STATE_APPLY_BUTTON = "//div[contains(@class,'custom-select__dropdown-menu')]//button[contains(text(),'Apply')]"
AUDIENCE_SELECT_STATE_CANCEL_BUTTON = "//div[contains(@class,'custom-select')]//button[contains(@type,'button') and contains(text(),'Cancel')]"

# BASE PAGE / Audience Builder / Detected Location Input Rule
AUDIENCE_COUNTRY_SELECTION_TEXT_BOX = "//input[@id='search-detect-location']"
AUDIENCE_COUNTRY_SELECTION_X_ICON = "//div[contains(@class, 'detect-location__search-box--remove')]//i[contains(@class, 'icon icon-remove')]"
AUDIENCE_COUNTRY_SELECTION_DROPDOWN_ITEM = "//div[contains(@class,'detect-location__dropdown-item__label')]"

# BASE PAGE / Audience Builder / Group
AUDIENCE_RULES_GROUP_SELECT_DROPDOWN = "//li[contains(@class,'custom-select__label')]//span[contains(text(),'Select Group')]"
AUDIENCE_RULES_GROUP_SEARCH_BOX = "//input[contains(@aria-label,'Search Group')]"
AUDIENCE_RULES_GROUP_SEARCH_RESULT = "//div[contains(@class,'custom-select__dropdown-menu')]//div[contains(text(),'{}')]"

# BASE PAGE / Audience Builder / Group Input Rule
AUDIENCE_SELECT_GROUP_CANCEL_BUTTON = "//button[contains(@class, 'btn-sm btn-default') and contains(text(), 'Cancel')]"
AUDIENCE_SELECT_GROUP_APPLY_BUTTON = "//button[contains(@class, 'btn-sm btn-primary') and contains(text(), 'Apply')]"

# BASE PAGE / Audience Builder / Status Rule
AUDIENCE_BUILDER_SELECT_DROPDOWN_STATUS = "//div[contains(@class, 'audience-builder-status__dropdown-menu')]//li[contains(@class, 'audience-builder-status__status-type')]//div[contains(text(), '{}')]"
AUDIENCE_BUILDER_SELECT_DROPDOWN_STATUS_ITEM = "//ul[contains(@class, 'audience-builder-status__status-select--list')]//li[contains(@class, 'audience-builder-status__status-select--item')]//div[contains(text(), '{}')]"

# BASE PAGE / Media Library
MEDIA_LIBRARY_CHECK_ALL_CHECK_BOX = "//div[contains(@class, 'custom-checkbox')]//span"
MEDIA_LIBRARY_ITEM_CHECK_BOX = "//div[normalize-space()='{}']/ancestor::div[contains(@class, 'media-grid-item')]/div[contains(@class,'custom-checkbox')]//span"
MEDIA_LIBRARY_DELETE_BUTTON = "//*[contains(@class, 'delete-button')]//*[contains(text(), 'Delete')]"
SEARCH_MEDIA_SEARCH_BOX = "//input[@placeholder='Search media']"
MEDIA_LIBRARY_EDIT_BUTTON = "(//*[contains(@class, 'edit-button')]/*)[last()]"
MEDIA_LIBRARY_CONFIRM_DELETE_BUTTON = "//*[contains(@class, 'custom-delete-button')]"
MEDIA_LIBRARY_TOTAL_FILES_TEXT = "//*[contains(@class, 'number-media-files')]"

# BASE PAGE / Media Library / EDIT MEDIA DIALOG
MEDIA_LIBRARY_EDIT_MEDIA_CONTENT_TITLE_TEXTBOX = "//input[@placeholder='Enter content title']"
MEDIA_LIBRARY_EDIT_MEDIA_MEDIA_URL_TEXTBOX = "//input[@placeholder='https://']"
MEDIA_LIBRARY_EDIT_MEDIA_MEDIA_ALT_TEXTBOX = "//input[@placeholder='Enter alt text']"
MEDIA_LIBRARY_EDIT_MEDIA_MEDIA_FILE_UPLOAD_BUTTON = "//input[@type='file']"
MEDIA_LIBRARY_EDIT_MEDIA_MEDIA_INVALID_INPUT_MESSAGE = "//*[contains(@class, 'has-error') and normalize-space()='This field is required']"
MEDIA_LIBRARY_EDIT_MEDIA_MEDIA_X_BUTTON = "//i[contains(@class,'btn-close-add-modal')]"
MEDIA_LIBRARY_EDIT_MEDIA_MEDIA_WARNING_MESSAGE = "//i[contains(@class, 'icon-warn')]/following-sibling::span[normalize-space()='{}']"
MEDIA_LIBRARY_EDIT_MEDIA_SAVE_BUTTON = "//button[contains(text(),'Save')]"
MEDIA_LIBRARY_EDIT_MEDIA_CANCEL_BUTTON = "//button[contains(text(),'Cancel')]"

# BASE PAGE / Job Search Results Builder
JOB_SEARCH_RESULTS_ACTIVE_SUB_SECTION = "//*[contains(text(), '{}')]/../parent::*[contains(@class, 'active')]"
JOB_SEARCH_RESULTS_CONDITION_DROPDOWN = "//*[contains(@class, 'condition-dropdown-label')]"
JOB_SEARCH_RESULTS_EDIT_CONDITION_BUTTON = "//*[contains(@class, 'btn-edit-condition')]"
JOB_SEARCH_RESULTS_SAVE_BUTTON = "//*[contains(@class, 'btn-save')]//*[contains(text(), 'Save')]"
JOB_SEARCH_RESULTS_REORDER_BUTTON = "//*[contains(@class, 'btn-reorder')]"
JOB_SEARCH_RESULTS_ADD_FIELD_BUTTON = "//*[contains(@class, 'btn-add-field')]"
JOB_SEARCH_RESULTS_PREVIEW_CONTAINER = "//*[contains(@class, 'preview-list-view-container')]"
JOB_SEARCH_RESULTS_INCLUDED_FIELD = "//*[contains(@class, 'field-item-content')]//*[contains(text(), '{}')]"
JOB_SEARCH_RESULTS_JOB_TITLE_FIELD_IS_LOCKED = "//*[contains(text(), 'Job Title')]/ancestor::*[contains(@class, 'fields-item-content-locked')]"
JOB_SEARCH_RESULTS_TRASH_ICON = "//*[contains(@class, 'field-item-content')]//*[contains(text(), '{}')]/ancestor::*[contains(@class, 'included-field-item')]//i[contains(@class, 'icon-bin')]"
JOB_SEARCH_RESULTS_LOCKED_ICON = "//*[contains(@class, 'field-item-content')]/ancestor::*[contains(@class, 'included-field-item')]//i[contains(@class, 'icon-locked')]"
JOB_SEARCH_RESULTS_TOAST_MESSAGE = "//*[contains(@class, 'toast') and contains(@class, 'show')]"
JOB_SEARCH_RESULTS_FIELD_ITEM = "//ul[contains(@class, 'included-fields__dropdown-menu') and not(contains(@style,'display: none;'))]//*[contains(text(), '{}')]"
JOB_SEARCH_RESULTS_DISABLED_FIELD_ITEM = "(//*[contains(text(), '{}')]/ancestor::li[contains(@class, 'included-fields__dropdown-menu-item') and contains(@class, 'disable')])[last()]"
JOB_SEARCH_RESULTS_ADD_CONDITION_BUTTON = "//*[contains(@class, 'btn-add-condition')]"
JOB_SEARCH_RESULTS_CONDITION_SEARCH_BOX = "//*[contains(@class, 'condition-search-box')]//*[contains(@aria-label, 'Search conditions')]"
JOB_SEARCH_RESULTS_CONDITION_SEARCH_ERASE_ICON = "//*[contains(@class, 'condition-search-box')]//div[contains(@class, 'erase-icon')]//i[contains(@class, 'icon-remove')]"
JOB_SEARCH_RESULTS_CONDITION_DROPDOWN_ITEM = "//*[contains(@class, 'dropdown-menu__item')]//*[normalize-space()='{}']"
JOB_SEARCH_RESULTS_LISTVIEW_BUILDER_PAGE = "//*[contains(@class, 'header')]//*[contains(text(), 'List View Builder')]"
JOB_SEARCH_RESULTS_LISTVIEW_BUTTON = "//div[contains(@class,'nav-item_content--sub')]//span[contains(text(),'List View')]"
JOB_SEARCH_RESULTS_JOB_LOCATOR = "//div[contains(@class,'field-item-label')]//span[contains(text(),'{}')]"
JOB_SEARCH_RESULTS_JOB_LOCATOR_DROPDOWN = "//*[contains(@class, 'included-fields__dropdown-menu')]//span[contains(text(), 'Job Location')]"
JOB_SEARCH_RESULTS_JOB_PREVIEW_ITEM = "//div[contains(@class, 'preview-container')]//*[contains(text(), '{}')]"
JOB_SEARCH_RESULTS_JOB_PREVIEW_CONTAINER = "//div[contains(@class, 'preview-container')]"
JOB_SEARCH_RESULTS_DELETE_ICON = "//*[contains(@class, 'field-item-content')]/ancestor::*[contains(@class, 'included-field-item')]//i[contains(@class, 'icon-bin')]"
#BASE PAGE / JOB SEARCH RESULTS BUILDER_PUBLISH / JOB POSTING PAGE
JOB_SEARCH_RESULTS_SELECT_FIELD_DROPDOWN_CHECK_ICON = "//ul[contains(@class, 'included-fields__dropdown-menu') and not(contains(@style,'display: none;'))]//*[contains(text(), '{}')]/following-sibling::i[contains(@class, 'icon-check2')]"

# BASE PAGE / Job Search Results Builder / CONDITION CRITERIA
CONDITION_CRITERIA_NAME_TEXTBOX = "//*[contains(@class, 'custom-condition')]//*[contains(text(), 'Name your condition')]"
CONDITION_CRITERIA_NAME_TEXTBOX_VALUE = "//div[contains(@class, 'editable-text-field')]//label[contains(text(),'{}')]"
CONDITION_CRITERIA_CANCEL_BUTTON = "//*[contains(@class, 'button-cancel')]"
CONDITION_CRITERIA_CLOSE_ICON = "//*[contains(@class, 'conditional-builder-drawer-header')]//*[contains(@class, 'icon-remove2')]"
EDIT_CONDITION_CRITERIA_CANCEL_BUTTON = "//*[contains(@class, 'cancel-button')]"
CONDITION_CRITERIA_SAVE_BUTTON = "//*[contains(@class, 'button-save')]"
CONDITION_CRITERIA_APPLY_BUTTON = "//*[contains(@class, 'apply-button')]"
CONDITION_CRITERIA_ADD_CONDITION_BUTTON = "//*[contains(@class, 'add-condition-button')]//*[contains(text(), 'Add Condition')]"
CONDITION_CRITERIA_DROPDOWN_ITEM = "//*[contains(@class, 'dropdown-custom-condition__item-label') and contains(text(), '{}')]"
CONDITION_CRITERIA_DROPDOWN_ITEM_OPTION = "(//*[contains(@class, 'dropdown-custom-condition__item-label') and contains(text(), '{}')])[last()]"
CONDITION_CRITERIA_CONDITION_ITEM_TITLE = "//*[contains(@class, 'condition-item-content__title') and contains(text(), '{}')]"
CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN = "//*[contains(@class, 'form-custom-condition-item__title') and contains(text(), 'Targeting Rules')]/..//*[contains(@class, 'form-custom-condition-item__dropdown')]"
CONDITION_CRITERIA_TARGETING_RULES_DROPDOWN_OPTION = "(//*[contains(@class, 'form-custom-condition-item__title') and contains(text(), 'Targeting Rules')]/..//*[contains(@class, 'form-custom-condition-item__dropdown')])[last()]"
CONDITION_CRITERIA_MATCHES_DROPDOWN = "//*[contains(@class, 'form-custom-condition-item__title') and contains(text(), 'Match')]/..//*[contains(@class, 'form-custom-condition-item__dropdown')]"
CONDITION_CRITERIA_MATCHES_DROPDOWN_OPTION = "(//*[contains(@class, 'form-custom-condition-item__title') and contains(text(), 'Match')]/..//*[contains(@class, 'form-custom-condition-item__dropdown')])[last()]"
CONDITION_CRITERIA_INPUT_TEXTBOX = "//*[contains(@class, 'form-custom-condition-item__title') and contains(text(), 'Input')]/following-sibling::*/*[contains(@type, 'text')]"
CONDITION_CRITERIA_INPUT_TEXTBOX_OPTION = "(//*[contains(@class, 'form-custom-condition-item__title') and contains(text(), 'Input')]/following-sibling::*/*[contains(@type, 'text')])[last()]"
CONDITION_CRITERIA_AND_BUTTON = "//*[contains(@class, 'button-and-or')]//*[normalize-space()='AND']"
CONDITION_CRITERIA_OR_BUTTON = "//*[contains(@class, 'button-and-or')]//*[normalize-space()='OR']"
CONDITION_CRITERIA_TITLE = "//*[contains(@class, 'conditional-builder-drawer-header')]//*[normalize-space()= '{}']"
CONDITION_CRITERIA_X_BUTTON = "//*[contains(@class, 'conditional-builder-drawer-header')]//*[contains(@class, 'icon-remove')]"
CONDITION_CRITERIA_TRASH_ICON = "//*[contains(@class, 'condition-item-content__title') and contains(text(), '{}')]/..//following-sibling::div/*[contains(@class, 'icon-bin')]"
JOB_SEARCH_RESULTS_OR_CONDITION_BUTTON = "//div[contains(@class,'rule-group-button')]//span[contains(text(),'OR')]"

# BASE PAGE / Job Search Results Builder / REORDER FIELDS
REORDER_FIELDS_FIRST_ITEM = "//*[contains(@class, 'reorder-container')]//div[contains(@class, 'item') and position()=1]//*[contains(text(), '{}') and contains(@class, 'lock')]"
REORDER_FIELDS_SECOND_ITEM = "//*[contains(@class, 'reorder-container')]//div[contains(@class, 'item') and position()=2]//*[contains(text(), '{}')]"
REORDER_FIELDS_THIRD_ITEM = "//*[contains(@class, 'reorder-container')]//div[contains(@class, 'item') and position()=3]//*[contains(text(), '{}')]"
REORDER_FIELDS_CANCEL_BUTTON = "//*[contains(@class, 'reorder-container')]//*[contains(@class, 'btn-cancel')]"
REORDER_FIELDS_SAVE_BUTTON = "//*[contains(@class, 'reorder-container')]//*[contains(@class, 'btn-save')]"
REORDER_FIELDS_X_BUTTON = "//*[contains(@class, 'reorder-container')]//*[contains(@class, 'icon-remove2')]"
REORDER_FIELDS_TITLE = "//*[contains(@class, 'reorder-container')]//*[contains(text(), 'Reorder Fields')]"

# BASE PAGE / Job Search Results Builder / Preview Builder
PREVIEW_BUILDER_ITEM_TITLE = "//*[contains(@class, 'preview')]//*[contains(text(), '{}')]"
PREVIEW_BUILDER_CONTAINER_JOB_ITEM_TITLE = "//*[contains(@class, 'list-view-item-container')]"

# BASE PAGE / AI Assistants / Candidate Assistants | Employee Assistants / My Assistants
MY_ASSISTANTS_ADD_NEW_ASSISTANT_BUTTON = "//button[contains(text(),'Add New Assistant')]"
MY_ASSISTANTS_ASSISTANT_PRIORITY_SECTION = "//div[@class='assistant-priority']"
MY_ASSISTANTS_ITEM_TILE = "//div[contains(@class,'content__item')]//span[contains(text(),'{}')]"
MY_ASSISTANTS_ITEM_AVATAR = "//span[contains(text(),'{}')]/ancestor::div[contains(@class,'content__item')]//img"
MY_ASSISTANTS_ITEM_CELL = "//span[contains(text(),'{}')]/ancestor::div[contains(@class,'content__item')]//div[contains(text(),'{}')]"
MY_ASSISTANTS_ITEM_MENU_ICON = "//span[contains(text(),'{}')]/ancestor::div[contains(@class,'content__item')]//div[contains(@class,'menu')]"
MY_ASSISTANTS_ITEM_MENU_ICON_ELLIPSIS = "//span[contains(text(),'{}')]/ancestor::div[contains(@class,'content__item')]//i[contains(@class,'icon-menu')]"
MY_ASSISTANTS_MENU_MODAL_DELETE_BUTTON = "//i[contains(@class,'icon-delete2')]/parent::li"
MY_ASSISTANTS_MENU_MODAL_EDIT_BUTTON = "//i[contains(@class,'icon-edit')]/parent::li"
MY_ASSISTANTS_MENU_MODAL_MOVE_BUTTON = "//i[contains(@class,'icon-move-team')]/parent::li"
MY_ASSISTANTS_MENU_MODAL_REMOVE_CONFIRM_BUTTON = "//div[contains(@class,'assistant-removal-modal')]//button[contains(text(),'Remove')]"
MY_ASSISTANTS_MENU_MODAL_REMOVE_CANCEL_BUTTON = "//div[contains(@class,'assistant-removal-modal')]//button[contains(text(),'Cancel')]"

# BASE PAGE / AI Assistants / Candidate Assistants | Employee Assistants / My Assistants / Add New Assistant Form
MY_ASSISTANTS_NEW_ASSISTANT_MODAL = "//div[contains(@class,'assistant-modal')]"
MY_ASSISTANTS_NEW_ASSISTANT_OVERVIEW = "//form[@id='ai_assistant_form']/div[contains(text(),'Overview')]"
MY_ASSISTANTS_NEW_ASSISTANT_EMPTY_AVATAR = "//div[contains(@class,'icon-ic_person')]"
MY_ASSISTANTS_NEW_ASSISTANT_AVATAR_INPUT = "//input[@type='file'][last()]"
MY_ASSISTANTS_NEW_ASSISTANT_AVATAR_COMFIRM_BUTTON = "(//button[contains(@class,'croppie-save')])[last()]"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_NAME_INPUT = "//input[@id='id_assistant_name']"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_PROMPT_TEXT = "//div[@id='id_assist_chat_prompt_display']"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_WHERE_INPUT = "//input[@id='geo_targeting']"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_COUNTRY_INPUT = "//input[@id='geo_targeting']"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_COUNTRY_ITEM = "(//div[@data-id='{}'])[last()]"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_SAVE_BUTTON = "//div[contains(@class,'pull-right')]//button[contains(text(),'Save')]"
MY_ASSISTANTS_NEW_ASSISTANT_ASSISTANT_CANCEL_BUTTON = "//div[contains(@class,'pull-right')]//button[contains(text(),'Cancel')]"

# BASE PAGE / AI Assistants / Candidate Assistants | Employee Assistants / Assistant Teams
ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_BUTTON = "//div[contains(@class,'header-creating-btn')]//button"
ASSISTANT_TEAMS_NEW_ASSISTANT_BUTTON = "//div[contains(@class,'header__right-content')]//button[contains(@class,'btn-default')]"
ASSISTANT_TEAMS_NAME = "//div[contains(@class,'header__team-name')]//span[text()='{}']"
ASSISTANT_TEAMS_ITEM_TITLE = "//div[contains(@class,'assistant-team')]//span[contains(text(),'{}')]"
ASSISTANT_TEAMS_ITEM_ICON_EDIT = "//div[contains(@class,'assistant-team')]//span[contains(text(),'{}')]/following-sibling::i"
ASSISTANT_TEAMS_ITEM_ADD_ASSISTANT_BUTTON = "//div[contains(@class,'assistant-team')]//span[contains(text(),'{}')]/ancestor::div[contains(@class,'cursor-pt')]//button[contains(@class,'btn-default')]"
ASSISTANT_TEAMS_ITEM_DEFAULT_ASSISTANT_OLIVIA = "//div[contains(@class,'assistant-team')]//span[contains(text(),'{}')]/ancestor::div[contains(@class,'assistant-team')]//div[contains(@class,'assistant-default')]"
ASSISTANT_TEAMS_ITEM_DEFAULT_ASSISTANT_OLIVIA_DROP_RIGHT_ICON = "//div[contains(@class,'assistant-team')]//span[contains(text(),'{}')]/ancestor::div[contains(@class,'assistant-team')]//div[contains(@class,'assistant-default')]//i"
ASSISTANT_TEAMS_ITEM_NUMBER_OF_ASSISTANT = "//div[contains(@class,'assistant-team')]//span[contains(text(),'{}')]/parent::div/parent::div/following-sibling::div"
ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_MODAL = "//div[contains(@class,'assistant-team-creating-modal')]"
ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_MODAL_TEAM_NAME_INPUT = "//input[contains(@class,'team-name-input')]"
ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_MODAL_CREATE_BUTTON = "//button[contains(text(),'Create Assistant Team')]"
ASSISTANT_TEAMS_NEW_ASSISTANT_TEAM_MODAL_CANCEL_BUTTON = "//div[contains(@class,'assistant-team-creating-modal')]//button[contains(@class,'cancel-btn')]"

# BASE PAGE / Candidate Assistant Responses
CANDIDATE_ASSISTANT_RESPONSES_TAB = "//div[contains(@class,'nav-item_text')]//span[contains(text(),'Candidate Assistant Responses')]"
CANDIDATE_ASSISTANT_RESPONSES_DYNAMIC_CONTENT="//div[contains(@class,'nav-item_text')]//span[contains(text(),'Dynamic Content')]"
