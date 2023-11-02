# BASE PAGE
CANDIDATE_INBOX = "//*[contains(@data-testid, 'candidateprofile_lbl_name')]"
HOME_COMPANY_NAME = "//div[contains(@data-testid,'header_lbl_company_name')]"
COMPANY_INPUT = "//div[contains(@role,'tooltip') and contains(@x-placement, 'end') ]//input[@placeholder='Search']"
LIST_COMPANY_AVAILABLE = "//div[contains(@role, 'tooltip') and contains(@x-placement, 'end')]//div[contains(text(), '{}')]"
INBOX_ADD_CANDIDATE_BUTTON = "//button[@data-testid='header_btn_add-lead']"
SET_CANDIDATE_JOURNEYS_BUTTON = "(//*[@id='board-profile']//*[@data-testid='candidate_btn_journeys']//span)[last()]"
CEM_CANDIDATE_JOURNEYS_BUTTON = "//*[@id='board-profile']//*[@data-testid='candidate_btn_journeys']"
JOURNEY_TASK_OPTION = "//div[contains(text(),'{}')]//parent::div[contains(@id,'el-collapse-head')]"
JOURNEY_TASK_OPTION_ACTIVE = "//div[contains(text(),'{}')]//parent::div[contains(@id,'el-collapse-head') and contains(@class, 'active')]"
JOURNEY_TASK_STATUS_OPTION = "//div[@class='el-collapse-item__content']//li[contains(text(),'{}')]"
JOURNEY_TASK_OPTION_OPENED = "//div[contains(text(),'{}')]//parent::*[contains(@id,'el-collapse-head') and contains(@class,'is-active')]"
CANDIDATE_GROUP_NAME_OPTION = "//div[@data-testid='lbl_title' and contains(text(),'{}')]"
CEM_HASHTAG_CHAT_ICON = "//i[@class='icon-hashtag']"
CEM_RECRUITER_INPUT_TEXT_BOX = "//div[@data-testid='recruiter_composer_input' and @placeholder]"
CEM_CANDIDATE_NAME = "//*[contains(@data-testid,'candidateblock_lbl_name') and contains(text(),'{}')]"
CANDIDATE_ICON_CAL_UPCOMING = "//*[contains(@data-testid,'candidateblock_lbl_name') and contains(text(),'{}')]//parent::div//following-sibling::div//i[contains(@class, 'icon-cal-upcoming')]"
CONVERSATION_TEXT = "//*[contains(@data-testid,'messenger_lbl_ours')]//*[contains(text(),'{}')]"
LEFT_MENU_BUTTON = "//div[@data-testid='toolbar_btn_back']"
CEM_CANDIDATE_NAME_TEXT = "//span[@data-testid='candidateblock_lbl_name' and contains(text(),'{}')]"
CANDIDATE_JOURNEY_STATUS = "//*[contains(@data-testid,'candidate_btn_journeys')]//*[contains(text(),'{}')]"
CEM_CANDIDATE_PROFILE_BUTTON = "//button[@data-testid='candidateprofile_btn']//*[contains(@class, 'text-overflow')]"
CEM_CANDIDATE_PROFILE_NAME_TEXT = "//ul[@data-testid='candidateprofile_list']//*[contains(text(),'{}') or contains(text(),'No Job Assigned')]"
CEM_CANDIDATE_PROFILE_NAME_AND_INDEX = "//*[contains(@class, 'dropdown-menu__item') and position()={}]//*[contains(text(),'{}')]"
CEM_OPEN_CANDIDATE_CONV = "//a[@data-testid='candidate_list_item']"
SEARCH_COMPANY_LOADING_ICON = "//div[contains(@id, 'board-profile')]/following-sibling::section//div[contains(@data-testid,'loading_wrapper') and not(contains(@style, 'display'))]"
CEM_CANDIDATE_EMPTY_ICON = "//i[contains(@data-testid,'empty_icon')]"
SEND_FORM_BTN = "//ul[contains(@x-placement, '-end')]//li[contains(text(), 'Send Form')]"
FORM_BTN = "//ul[contains(@x-placement, '-end')]//div[contains(text(), 'Form')]"
SEND_FORM_LINK = "//div[contains(text(), 'excited to move you forward in our process. Please complete your form for')]//a"
LAST_SEND_FORM_LINK = "(//div[contains(text(), 'excited to move you forward in our process. Please complete your form for')])[last()]//a"
CANIDATE_LINK = "//*[contains(@data-testid,'candidateblock_lbl_name') and contains(text(), '{}')]/ancestor::a"
CEM_CANDIDATE_JOURNEY_ITEM_STATUS = "//*[text()='{}']"
CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_LOCK_STATUS = "//li[contains(text(), '{}')]//i[@class='icon icon-outline-lock']"
CEM_CANDIDATE_JOURNEY_ITEM_DETAIL_UNLOCK_STATUS = "//li[contains(text(), '{}')]//i[contains(@class, 'no-icon')]"
CEM_CANDIDATE_JOURNEY_STATUS_BUTTON = "//*[contains(@type, 'button')]//*[contains(text(),'{}')]" #PARAMETER IS STATUS NAME
SEARCH_ICON_CEM = "//button[contains(@data-testid,'header_btn_toolbar-search')]";
INPUT_SEARCH_CANDIDATE_CEM = "//div[contains(@class,'el-input__inner')]//input[contains(@placeholder,'Search')]";
NAME_ON_SEARCH_CANDIDATE_CEM = "(//a[contains(@data-testid,'search_result_candidate')]//span[contains(@data-testid,'candidateblock_lbl_name')] )[1]";
CANDIDATE_LIST_HEADER_TITLE = "//h4[contains(@data-testid, 'candidate_list_header_title')]"
OFFER_LINK = "(//div[contains(text(), 'excited to move you forward in our process. Please respond to your offer')]//a)[last()]"

# BASE PAGE / Candidates
CANDIDATE_SCROLLBAR = "//*[contains(@class, 'list-scroll')]//div[contains(@class,'el-scrollbar__wrap')]"
CANDIDATE_LIST_ITEMS = "//a[contains(@data-testid, 'candidate_list_item')]//span[normalize-space()='{}']"
CANDIDATE_LIST_ITEMS_DES = "//div[@data-testid='candidateblock_lbl_desc_line{}']//span"
CANDIDATE_LIST_ITEMS_JOB_NAME = "//span[contains(text(),'{}')]//ancestor::a[@data-testid='candidate_list_item']//div[@data-testid='candidateblock_lbl_desc_line0']//span[contains(text(),'{}')]"
CANDIDATE_LIST_LAST_CONTACTED = "//span[@data-testid='candidateblock_lbl_name']/following-sibling::span"
CEM_SEARCH_CANDIDATE_TEXT_ON_BODY_MODEL = "//div[contains(@class, 'el-scrollbar__view')]//div[contains(text(), '{}')]"
CEM_CANDIDATE_JOURNEY_FORM_STATUS = "//*[contains(@id, 'collapse-head')]//*[contains(text(), 'Form')]"
CEM_CANDIDATE_JOURNEY_APPLICATION_STATUS = "//*[contains(@id, 'collapse-head')]//*[contains(text(), 'Application')]"
CEM_CANDIDATE_JOURNEY_ONBOARDING_STATUS = "//*[contains(@id, 'collapse-head')]//*[contains(text(), 'Onboarding')]"
CEM_CANDIDATE_JOURNEY_HIRE_STATUS = "//*[contains(@id, 'collapse-head')]//*[contains(text(), 'Hire')]"
CEM_CANDIDATE_JOURNEY_CONVERSATION_STATUS = "//*[contains(@id, 'collapse-head')]//*[contains(text(), 'Conversation')]"
CEM_CANDIDATE_JOURNEY_NEXT_STEP_DESCRIPTION = "//span[contains(text(), '{}')]//ancestor::ul//*[contains(text(), '{}')]"
CEM_CANDIDATE_JOURNEY_NEXT_STATUS_DROPDOWN_TITLE = "//ul[contains(@class,'el-dropdown-menu')]//span[text()='{}']"
CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON = "//button[contains(@class,'el-button--default')]//span[contains(text(),'{}')]"
CEM_CANDIDATE_JOURNEY_NEXT_STEP_DES_ONE_ARG = "//ul[contains(@class,'el-dropdown-menu')]//p[contains(text(),'{}')]"
CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON_STATUS_UPDATE = "(//button[contains(@class,'el-button--default')]//span[contains(text(),'{}')])[last()]"
NEXT_STEP_MULTIPLE_STATUS_ITEM = "//li[contains(@class,'el-dropdown-menu__item') and contains(text(),'{}')]"
NEXT_STEP_MULTIPLE_STATUS_BACK_BUTTON = "//i[contains(@class,'icon-chevron-left')]//parent::div"
NEXT_STEP_MULTIPLE_STATUS_MORE_OPTIONS_BUTTON = "//i[contains(@class,'icon-chevron-right')]//parent::div"
NEXT_STEP_COMFIRM_TITLE = "//ul[contains(@class,'el-dropdown-menu')]//div[contains(text(),'Confirm Status Update')]"
NEXT_STEP_COMFIRM_MODAL_BUTTON = "//ul[contains(@class,'el-dropdown-menu')]//span[contains(text(),'{}')]"
NEXT_STEP_SCHEDULE_INTERVIEW_MODAL_TITLE = "//header[@id='el-drawer__title']//div[text()='Schedule an Interview']"
CEM_NOTIFICATION_ICON = "//*[contains(@class,'icon-notifications')]"
CEM_NOTE_TAB = "//div[contains(@id,'tab-notes')]"
CEM_INTERNAL_NOTE_TITLE = "//*[contains(@data-testid, 'cem_notes_lbl_title')]"
CEM_ADD_A_NOTE_TEXTBOX = "//*[contains(@data-testid, 'cem_input_note') and contains(@placeholder,'Add a note...')]"
CEM_ADD_NOTE_BUTTON = "//button[contains(@data-testid,'cem_btn_add_note')]"
CEM_ADD_NOTE_SUCCESS_MESSAGE = "//div[contains(@class,'toasted') and contains(text(),'This candidate has been shared')]"
CEM_NOTE_MENTION_USER_LIST = "//*[contains(@class,'popper')]//div[contains(@class, 'mention-item')]"
CEM_NOTE_MENTION_USER_ITEM = "//div[contains(@data-testid,'cem_lbl_mentioned_user_name')]"
CEM_NOTE_MENTION_USER_NAME = "//div[contains(@data-testid,'cem_lbl_mentioned_user_name') and contains(text(),'{}')]"
CEM_CANDIDATE_MORE_BUTTON = "//button[contains(@data-testid,'btn_candidate_more')]"
CEM_CANDIDATE_INTERNAL_NOTE_CONTENT = "//div[contains(@data-testid,'cem_notes_card_note_item')]//span[contains(text(),'{}')]"
CEM_CANDIDATE_HEADER_USER_AVATAR = "//span[contains(@class,'reference-wrapper')]//div[contains(@data-testid,'switch_user')]//span[contains(@class,'el-avatar--circle')]"
CEM_CANDIDATE_SEARCH_USERNAME_TEXTBOX= "//input[contains(@data-testid,'header_input_search_user')]"
CEM_CANDIDATE_SEARCH_RESULT_USERNAME_= "//div[contains(@data-testid,'user_item') and contains(text(),'{}')]"
CEM_CANDIDATE_INTERNAL_NOTE_MENU_ITEM = "//*[contains(text(),'{}')]//parent::div//preceding-sibling::div//descendant::i[contains(@class,'icon-menu')]"
CEM_CANDIDATE_INTERNAL_NOTE_MENU_MENTION_USER_ITEM = "//*[contains(text(),'{}')]/ancestor::div//preceding-sibling::div//i[contains(@class,'icon-menu')]"
CEM_CANDIDATE_PRIVATE_SHARE_MESSAGE = "(//span[contains(text(),'Admin shared candidate with {}')])[last()]"
CEM_ADD_NOTE_MODAL_MENTION_ICON = "//i[contains(@class,'icon-mention pointer')]"
CEM_MORE_OPTION_ITEMS = "//li[contains(@data-testid, 'candidatemenu_btn')]//div[contains(text(), '{}')]"

# BASE PAGE / NOTE INTERNAL / NOTE MODAL
CEM_CANDIDATE_NOTE_MODAL_ICON = "//div[contains(@aria-label,'Add Note')]//i[contains(@class,'icon-{}')]"
CEM_CANDIDATE_NOTE_MODAL_CONTENT = "//div[contains(@placeholder,'Enter note...')]"
CEM_CANDIDATE_NOTE_MODAL_MENTION_ITEM = "//div[contains(@class,'mention-item')]//div[contains(text(),'{}')]"
CEM_CANDIDATE_NOTE_MODAL_SAVE_CANCEL_BUTTON = "//*[contains(@class,'footer')]//button[contains(@type,'button')]//span[contains(text(),'{}')]"

# BASE PAGE / NOTE INTERNAL / NOTE MODAL / DELETE ICON
CEM_CANDIDATE_DELETE_CONFIRM_MODAL_TITLE = "//*[contains(@class,'el-message-box')]//span[contains(text(),'Delete this Note')]"
CEM_CANDIDATE_DELETE_CONFIRM_MODAL_BUTTON = "//*[contains(@class,'el-message-box')]//button[contains(@type,'button')]//span[contains(text(),'{}')]"

# BASE PAGE / MORE
CEM_CANDIDATE_MENU_ITEM = "//li[contains(@data-testid,'candidatemenu_btn')]//div[contains(text(),'{}')]"

# BASE PAGE / MORE / SHARE
CEM_CANDIDATE_SHARE_MODAL_TITLE= "//strong[contains(text(),'Share')]"
CEM_CANDIDATE_SHARE_MODAL_PEOPLE_BOX = "//input[contains(@class,'el-select__input')]"
CEM_CANDIDATE_SHARE_MODAL_SUGGESTION_USER = "//div[contains(@class,'name')]//span[contains(text(),'{}')]"
CEM_CANDIDATE_SHARE_MODAL_SUGGESTION_USER_PHONE_EMAIL = "//*[contains(@class,'el-select-dropdown__item')]//div[contains(@class,'color-lighter')]//span[contains(text(),'{}')]"
CEM_CANDIDATE_SHARE_MODAL_MESSAGE_BOX = "//textarea[contains(@placeholder,'Add a message')]"
CEM_CANDIDATE_SHARE_MODAL_SEND_CANCEL_BUTTON = "//div[contains(@class,'footer')]//button[contains(@type,'button')]//span[contains(text(),'{}')]"
CEM_CANDIDATE_SHARE_MODAL_OPTION = "//span[contains(@class,'el-radio')]/span[contains(text(),'{}')]"
CEM_CANDIDATE_SHARE_MODAL_NAME_TAG_X_ICON = "//*[contains(@class,'icon-close')]"
CEM_CANDIDATE_SHARE_MODAL_RADIO_OPTION_CHECKED = "//label[contains(@aria-checked,'true')]//span[contains(text(),'{}')]"
CEM_OFFERS_ITEM = "//div[contains(@class, 'hire-offer')]//div[contains(text(), '{}')]"
CEM_SEGMENT_TITLE = "//span[contains(@data-testid,'breadcrumb_lbl_current') and contains(text(),'{}')]"

# BASE PAGE / MORE / ATTRIBUTE
CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH = "//input[contains(@placeholder, 'Search attribute name')]"
CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE = "//strong[contains(text(), '{}')]//ancestor::div[contains(@class, 'el-scrollbar__view')]//span[contains(text(), '{}')]"

# CONVERSATION
CONVERSATION_LAST_SYSTEM_MESSAGE = "(//*[contains(@data-testid,'messenger_lbl_system')])[last()]/../i[contains(@class, 'icon')]"
CONVERSATION_FIRST_CANDIDATE_MESSAGE = "//*[contains(@data-testid,'messenger_lbl_theirs')]//*[contains(@class, 'msg-text')]/div"
CONVERSATION_LAST_CANDIDATE_MESSAGE = "(//*[contains(@data-testid,'messenger_lbl_theirs')]//*[contains(text(), '{}')])[last()]"
CONVERSATION_FIRST_OLIVIA_MESSAGE = "//*[contains(@data-testid,'messenger_lbl_ours')]//*[contains(@class, 'msg-text')]/div"
CONVERSATION_LAST_OLIVIA_MESSAGE = "(//*[contains(@data-testid,'messenger_lbl_ours')]//*[contains(text(), '{}')])[last()]"
CONVERSATION_OLIVIA_OPTION_TIME_WORKS_MESSAGE = "(//div[contains(text(),'Do any of these times work?')])[last()]"
CONVERSATION_LINK_OFFER = "//*[contains(@class,'msg-text')]//a[parent::div[contains(text(),'Please respond to your offer')]]"
CONVERSATION_OLIVIA_MESSAGE_CONTENT = "//*[contains(@class,'msg-text')]//*[contains(text(),'')]"
CONVERSATION_MILESTONE_STATUS_UPDATE = "//*[contains(@data-testid,'messenger_lbl_system')]//span[contains(text(),'updated status from') and child::strong[contains(text(),'{}')] and child::strong[contains(text(),'{}')]]" #PARAMETER IS CONVERSATION STATUS NAME

# CONVERSATION/ CLICK LINK OFFER
YOUR_OFFER_ACCEPT_BUTTON = "//*[contains(@id,'btn_accept')]"
YOUR_OFFER_DO_NOT_ACCEPT_BUTTON = "//*[contains(@id,'btn_declined')]"

# CONVERSATION/ CLICK A LINK OFFER AFTER CANCELED THIS OFFER
OFFER_ERROR_PAGE_HEADER_LOGO = "//*[contains(@id,'app-header')]//img[contains(@data-testid,'app_img_logo')]"
OFFER_ERROR_PAGE_FILE_ICON = "//*[contains(@class,'el-main')]//i[contains(@class,'icon-offer')]"

# BASE PAGE / Right menu
CEM_PAGE_RIGHT_MENU_TOOLBAR_BUTTON = "//*[@data-testid='toolbar_btn_back']"
CEM_PAGE_RIGHT_MENU_SETTING_ICON = "//*[@data-testid='menu_btn_settings']"
CEM_PAGE_RIGHT_MENU_EVENTS = "//*[@role='dialog']//*[contains(@class,'icon-events')]//following-sibling::*"
CEM_PAGE_RIGHT_MENU_INTERVIEWS = "//*[contains(@class,'icon-checkin')]"
CEM_PAGE_RIGHT_MENU_CAMPUS = "//*[contains(@class,'icon-school')]"
CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY = "//i[contains(@class,'icon-talent-community')]"
CEM_PAGE_RIGHT_MENU_TALENT_COMMUNITY_LABEL ="//div[contains(text(),'Talent Community')]"
CEM_PAGE_RIGHT_MENU_ITEM = "//div[contains(@data-testid,'menu_item')]//*[contains(text(),'{}')]"
CEM_PAGE_RIGHT_MENU_MICROLEARNING = "//*[contains(@class,'icon-learning')]"
LOGOUT_ICON = "//div[@class='item-content']//i[@class='icon icon-logout']/following-sibling::div[contains(text(),'Logout')]"

# BASE PAGE / Left menu
LEFT_MENU_MORE = "//div[contains(text(),'More')]//preceding-sibling::i[contains(@class,'icon-chevron-down')]//parent::div"
LEFT_MENU_INBOX = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-inbox')]//following-sibling::div[contains(text(),'Inbox')]"
LEFT_MENU_LIKED = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-liked')]//following-sibling::div[contains(text(),'Liked')]"
LEFT_MENU_ARCHIVED = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-archived')]//following-sibling::div[contains(text(),'Archived')]"
LEFT_MENU_INCOMPLETE = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-incomplete')]//following-sibling::div[contains(text(),'Incomplete')]"
LEFT_MENU_ALL_CANDIDATE = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-inbox')]//following-sibling::div[contains(text(),'All Candidates')]"
LEFT_MENU_VIEW_BY_STAGE = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-move-status')]//following-sibling::div[contains(text(),'View by Stage')]"
LEFT_MENU_VIEW_BY_LOCATION = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-location')]//following-sibling::div[contains(text(),'View by Location')]"
LEFT_MENU_VIEW_BY_JOB = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-job')]//following-sibling::div[contains(text(),'View by Job')]"
LEFT_MENU_PATTERN_SEGMENT = "//div[contains(@class,'item-content')]//i[contains(@class,'icon-segment')]//following-sibling::div[contains(text(),'{}')]//parent::div//parent::a"
LEFT_MENU_PATTERN_SEGMENT_BELOW_ALL_CANDIDATE = "//div[contains(@class,'item-content')]//child::i[contains(@class,'icon-inbox')]//following-sibling::div[contains(text(),'All')]//parent::div//parent::a//following-sibling::a//i[contains(@class,'icon-segment')]//following-sibling::div[contains(text(),'{}')][1]"
LEFT_MENU_PATTERN_SEGMENT_BELOW_ARCHIVED = "//a[contains(@class,'menu-item')]//i[contains(@class,'icon-archived')]//following-sibling::div[contains(text(),'Archived')]//parent::div//parent::a//following-sibling::a//i[contains(@class,'icon-segment')]//following-sibling::div[contains(text(),'{}')]"
LEFT_MENU_PATTERN_SEGMENT_IN_MORE_SECTION = "//div[contains(@data-testid,'menu_item_more')]//following::div//div[contains(@class,'item-content')]//i[contains(@class,'icon-segment')]//following-sibling::div[contains(text(),'{}')]//parent::div//parent::a"
LEFT_MENU_PATTERN_SEGMENT_TOOL_BUTTON = "//div[contains(@class,'item-content')]//i[contains(@class,'icon-segment')]//following-sibling::div[contains(text(),'{}')]//following-sibling::div//button"
LEFT_MENU_SEGMENT_TOOL_PATTERN = "//ul[contains(@class,'el-dropdown') and not(contains(@style,'display: none'))]//span[contains(text(),'{}')]"
LEFT_MENU_DELETE_SEGMENT_POPUP = "//*[contains(@role,'dialog')]//div[contains(@class,'el-message-box ol-confirm')]"
LEFT_MENU_DELETE_SEGMENT_POPUP_TITLE = "//*[contains(@role,'dialog')]//*[contains(text(),'Delete Segment')]"
LEFT_MENU_DELETE_SEGMENT_POPUP_MESSAGE = "//*[contains(@role,'dialog')]//*[contains(text(),'Are you sure you want to delete this segment')]"
LEFT_MENU_DELETE_CANCEL_SEGMENT_BUTTON = "//*[contains(@role,'dialog')]//button//span[contains(text(),'{}')]"

# BASE PAGE / Search company popup
ADD_COMPANY_BUTTON = "//div[@class='el-input el-input--prefix']//following-sibling::i[contains(@class,'icon-plus')]"
ADD_NEW_COMPANY_OPTION = "//div[@class='add-company-option']//i[@class='icon-plus']"
CONFIRM_COMPANY_OPTION_BUTTON = "//div[@class='el-dialog add-company-option-dialog' and @aria-label='Add a Company']//button[@class='el-button el-button--primary']"

# BASE PAGE / Company information popup
ACCOUNT_NAME_TEXT_BOX = "//label[text()='Account name']//following-sibling::div//input"
PUBLIC_ACCOUNT_NAME_TEXT_BOX = "//label[text()='Public company name']//following-sibling::div//input"
PHONE_NUMBER_TEXT_BOX = "//label[text()='Phone number']//following-sibling::div//input"
STREET_ADDRESS_TEXT_BOX = "//input[@placeholder='Street address']"
CITY_TEXT_BOX = "//input[@placeholder='City']"
STATE_TEXT_BOX = "//input[@placeholder='State']"
ZIP_CODE_TEXT_BOX = "//input[@placeholder='ZIP Code']"
ACCOUNT_STATUS_SELECTION = "//div[@data-testid='btn_show_menu']"
ACCOUNT_STATUS_TEST_OPTION = "//div[@class='account-status-item']//span[@class='el-radio__label' and contains(text(),'Test')]"
ACCOUNT_STATUS_APPLY_BUTTON = "//span[@class='dialog-footer account-status-dialog-footer']//button[@class='el-button el-button--primary']"

# BASE PAGE / Notifications popup
NOTIFICATIONS_RATED_LOW_TODAY = "//div[contains(@id,'section-0')]//descendant::div[contains(text(),'candidates rated their experience')]//parent::*"
NOTIFICATION_RATED_LOW_TEMPLATE = "//div[contains(@class,'notifi-text') and contains(text(),'{} rated their experience')]"

# BASE PAGE / Add New Candidate Form
CEM_INPUT_FIRST_NAME_TEXT_BOX = "//input[@data-testid='cem_input_firstname']"
CEM_INPUT_LAST_NAME_TEXT_BOX = "//input[@data-testid='cem_input_lastname']"
CEM_INPUT_PHONE_TEXT_BOX = "//input[@data-testid='cem_input_phone_number']"
CEM_INPUT_EMAIL_TEXT_BOX = "//input[@data-testid='cem_input_email']"
GROUP_SELECTION_DROPDOWN = "//div[@data-testid='btn_show_menu']"
GROUP_SEARCH_TEXT_BOX = "//div[@data-testid='cem_group_menu']//input"
CEM_LOCATION_DROPDOWN = "//div[@data-testid='cem_location_menu']"
CEM_LOCATION_SEARCH_TEXT_BOX = "//div[contains(@class, 'el-select-location')]//input[not(contains(@placeholder, 'Select'))]"
CEM_LOCATION_VALUE = "//div[contains(@class,'el-collapse-item is-active')]//em[contains(text(),'{}')]"
CEM_ADD_CANDIDATE_BUTTON = "//button[@data-testid='cem_btn_add_candidate']"
CEM_JOB_SEARCH_TEXT_BOX = "//input[@placeholder='Find a job']"
CEM_JOB_REQ_ID_TEXT_BOX = "//div[@class='el-form-item is-no-asterisk is-required']//input"
CEM_INPUT_PHONE_NUMBER_TEXT_BOX = "//input[contains(@class, 'vti__input')]"

# BASE PAGE / Add New Candidate Form / Confirm Status Update Popup
CONFIRM_STATUS_UPDATE_OK_BUTTON = "//*[contains(text(),'Confirm Status Update')]//ancestor::div//button[contains(@class,'primary')]"

# BASE PAGE / Confirm Offer Details widget
CONFIRM_OFFER_START_DATE = "//*[@id='old-start-date']//input[not(contains(@type,'hidden'))]"
CONFIRM_OFFER_START_DATA_TODAY_VALUE = "//span[@class='flatpickr-day today']"
CONFIRM_OFFER_START_DATA_NEXT_DATE_VALUE = "//span[contains(@class, 'flatpickr-day') and contains(@aria-label, '{}')]"
CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX = "//div[@class='el-input-group__prepend']//following-sibling::input"
CONFIRM_OFFER_SELECT_OFFER_DROPDOWN = "//label[contains(text(), 'Select Offer')]//following-sibling::div[contains(@class, 'el-select')]"
CONFIRM_OFFER_SELECT_OFFER_OPTION = "//div[contains(@class, 'el-select-dropdown')]//li[contains(text(), '{}')]"
CONFIRM_OFFER_SELECT_LOCATION_DROPDOWN = "//div[contains(@data-testid, 'location_form_search_location')]//input"
CONFIRM_OFFER_SELECT_USER_DROPDOWN = "//div[contains(@data-testid, 'user_form_search_user')]//input"
CONFIRM_OFFER_SELECT_LOCATION_OPTION = "//li[contains(@class, 'el-select-dropdown')]//span[contains(text(), '{}')]"
CONFIRM_OFFER_SELECT_USER_OPTION = "//li[contains(@class, 'el-select-dropdown')]//div[normalize-space()='{}']"
CONFIRM_OFFER_INPUT_FILE = "(//input[@type='file'])[last()]"
CONFIRM_OFFER_FILE_UPLOADED_NAME = "//i[contains(@class, 'icon icon-CloudIcon')]//following-sibling::div//span[contains(text(), '{}')]"
CONFIRM_OFFER_ACCEPT_ICON = "//div[contains(@class, 'status-accepted')]"
CONFIRM_OFFER_DECLINED_ICON = "//div[contains(@class, 'status-declined')]"
CONFIRM_OFFER_SELECT_PAY_RATE_DROPDOWN = "//div[contains(@class,'el-input')]//input[contains(@placeholder,'Select') and contains(@autocomplete,'off')]"
CONFIRM_OFFER_SELECT_PAY_RATE_VALUE = "//div[contains(@class,'el-scrollbar')]//span[contains(text(),'{}')]"
CONFIRM_OFFER_SEND_BUTTON = "//*[contains(@type,'button')]//*[contains(text(),'Send offer')]"
CONFIRM_OFFER_CANCEL_BUTTON = "//*[contains(@type,'button')]//*[contains(text(),'Cancel Offer')]"
CONFIRM_OFFER_SUCCESSFUL_TOASTED_MESSAGE = "//*[contains(@class, 'toasted') and contains(text(),'Your offer has been sent')]"
CONFIRM_OFFER_ERROR_TOASTED_MESSAGE= "//*[contains(@class,'toasted toasted-primary error') and contains(text(),'{}')]" #PARAMETER IS MESSAGE CONTENT
CONFIRM_OFFER_CLOSE_ICON= "//*[contains(@class,'icon-remove')]"

# BASE PAGE / Review Offer detail widget
REVIEW_OFFER_INPUT_FILE_UPLOAD= "//input[contains(@type,'file') and contains(@class,'hidden-input') and not(contains(@accept,'application/pdf'))]"

# BASE PAGE / Confirm Offer Details widget / Click Cancel offer
CEM_CANCEL_OFFER_POPUP_CONTENT_INPUT = "//*[contains(@data-testid, 'content_cancel_input_task_name') and contains(@contenteditable,'true')]"

# BASE PAGE / Hire Details/ Click at Offer name
REVIEW_OFFER_HISTORY_OFFER_ICON = "//*[contains(@role, 'document')]//*[contains(@class,'icon-history')]"
REVIEW_OFFER_STATUS_CANCELED_ICON = "//*[contains(@role, 'document')]//*[contains(@class,'icon icon-spam')]"
REVIEW_OFFER_CANCEL_DATE_TIMESTAMP = "//*[contains(@class,'status-canceled')]//descendant::*[contains(@class,'color-lighter')]"

# BASE PAGE / Hire Details
CEM_OFFER_STATUS_CANCELED = "//span[contains(@class,'status-canceled') and preceding::*[contains(text(),'{}')]]" #PARAMETER IS OFFER NAME
CEM_OFFER_STATUS_CANCELED_ICON = "//*[contains(@class,'icon-spam') and preceding::*[contains(text(),'{}')]]"
CEM_OFFER_STATUS_SENT = "//*[contains(@class,'status-sent') and preceding::*[contains(text(),'{}')]]"  #PARAMETER IS OFFER NAME
CEM_OFFER_STATUS_SENT_ICON = "//*[contains(@class,'status-sent icon') and preceding::*[contains(text(),'{}')]]"
CEM_OFFER_STATUS_EXPIRED = "//*[contains(@class,'status-expired') and preceding::*[contains(text(),'{}')]]"
CEM_OFFER_STATUS_EXPIRED_ICON = "//*[contains(@class,'icon-stop-watch') and preceding::*[contains(text(),'{}')]]"
CEM_OFFER_STATUS_UPDATED = "//*[contains(@class,'status-updated') and contains(text(),'Updated')and preceding::*[contains(text(),'{}')]]"

# BASE PAGE / Add New Candidate Form / Screening Popup
SCREENING_CONVERSATION_DROPDOWN = "//*[contains(@data-testid,'btn_show_menu')]"
SCREENING_SEARCH_CONVERSATION_TEXTBOX = "//*[contains(@data-testid,'input_search')]//input[contains(@placeholder,'Search')]"
SCREENING_CONVERSATION_OPTION_BY_NAME = "//*[contains(@data-testid,'lbl_title') and contains(text(),'{}')]"
SCREENING_SEND_BUTTON = "//button[contains(@class,'button--primary')]//*[text()='Send']"

# BASE PAGE / Filter
FILTER_ICON = "//div[contains(@data-testid, 'candidate_btn_filter')]"
FILTER_TOOLTIP = "//div[@role='tooltip' and text()='Filter this view']"
FILTER_BADGE_SELECTED = "//sup[contains(@class,'el-badge__content') and text()='{}']"
CLEAR_FILTERS_BUTTON = "//span[text()='Clear Filters']"

# BASE PAGE / Filter Modal
FILTER_RIGHT_SIDE_START_TEXT="//p[@data-testid='filter_group_empty_lbl_content']"
FILTER_APPLY_BUTTON = "//button[contains(@data-testid, 'cem_filter_btn_apply')]"
FILTER_CANCEL_BUTTON = "//button[contains(@data-testid, 'cem_filter_btn_cancel')]"
FILTER_TYPE_PATTERN = "//span[contains(@data-testid, '_lbl_title') and contains(text(),'{}')]"
FILTER_TYPE_NUMBER_SELECTED = "//span[contains(@data-testid, '_lbl_title') and contains(text(),'{}')]/following-sibling::span[contains(text(),'{}')]"
FILTER_TYPE_JOB = "//span[contains(@data-testid, 'cem_filter_job_lbl_title')]"
FILTER_TYPE_STATUS = "//span[contains(@data-testid, 'cem_filter_status_lbl_title')]"
FILTER_TYPE_LOCATION = "//span[contains(@data-testid, 'cem_filter_location_lbl_title')]"
FILTER_STATUS_CAPTURE_COMPLETE = "//span[contains(text(), 'Default Candidate Journey: Capture')]//parent::span//parent::div//following-sibling::div//span[contains(text(), 'Capture Complete')]//parent::span//preceding-sibling::label//descendant::span[contains(@class,'el-checkbox__inner')]"
FILTER_PATTERN_STATUS_CHECKBOX = "//span[contains(text(), 'Default Candidate Journey: Capture')]//parent::span//parent::div//following-sibling::div//span[contains(text(), '{}')]//parent::span//preceding-sibling::label//descendant::span[contains(@class,'el-checkbox__inner')]"
FILTER_PATTERN_LOCATION_CHECKBOX = "//span[contains(text(),'{}')]//parent::span//preceding-sibling::i//parent::div//preceding-sibling::label//descendant::span[contains(@class,'el-checkbox__inner')]"
FILTER_PATTERN_LOCATION_LABEL = "//div[contains(@class,'el-tree-node__content')]//span[contains(text(),'{}')]"
FILTER_SAVE_SEGMENT_BUTTON = "//*[contains(text(),'Save Segment')]//parent::span//parent::button"
FILTER_SCROLL_VIEW = "//div[@loaded-data]//div[contains(@class,'el-scrollbar__wrap')]"
STATUS_FILTER_STAGE_TITLE = "//div[contains(@class,'el-tree-node__content')]//span[contains(text(),'{}')]"
STATUS_FILTER_STATUS_TITLE = "//span[contains(text(),'{}')]//ancestor::div[@role='treeitem']//span[contains(text(),'{}')]"
STATUS_FILTER_STATUS_CHECKBOX = "//span[contains(text(),'{}')]//ancestor::div[@role='treeitem']//span[contains(text(),'{}')]//ancestor::div[contains(@class,'el-tree-node__content')]/label"
GROUP_FILTER_ITEM_LABEL = "//span[contains(@class,'el-checkbox__label')]//span[contains(text(),'{}')]"
SCHEDULING_FILTER_ITEM = "//div[contains(@class,'filter-scheduling-status')]//span[contains(text(),'{}')]"
LAST_CONTACTED_DATE_ITEM = "//div[@role='radiogroup']//span[text()='{}']"
LAST_CONTACTED_DATE_CALENDAR = "//div[contains(@class,'flatpickr-calendar animate open arrowBottom arrowLeft')]"
LAST_CONTACTED_DATE_INPUT = "//input[contains(@class,'el-input__inner form-control input')]"
CONTACTED_BY_FILTER_USERNAME_TITLE = "//div[contains(@class,'info-filter')]//span[contains(text(),'{}')]"
REFERRED_BY_FILTER_SEARCH_INPUT = "//input[@placeholder='Search for a referrer']"
FOOTER_NUMBER_CANDIDATES_MATCH = "//div[contains(@class,'el-dialog__footer')]//span[contains(text(),'{} candidates match')]"
NEED_IDEAS_SELECTED_ICON = "//p[text()='People with upcoming interviews']/preceding-sibling::i[contains(@class,'icon-check2')]"
WITHIN_LAST_WEEK_INPUT = "//input[@aria-valuenow='7']"
FILTER_ITEM_LABEL = "//span[contains(@class,'el-checkbox__label')]//span[contains(text(),'{}')]"

# BASE PAGE / Filter Modal / Job
JOB_FILTER_SEARCH_ITEM_NAME_PATTERN = "//strong[contains(@class,'text__highlight') and text()='{}']"
JOB_FILTER_SEARCH_INPUT = "//input[@placeholder='Search for a job']"

# BASE PAGE / Segment Model
SEGMENT_NEW_MODEL_POPUP = "//span[contains(text(),'New Segment')]//ancestor::div[contains(@role,'dialog')]"
SEGMENT_NEW_MODEL_TITLE = "//div[contains(@class,'el-dialog__body')]//preceding-sibling::div[contains(@class,'el-dialog__header')]//span[contains(text(),'New Segment')]"
SEGMENT_NEW_MODEL_SAVE_CANCEL_BUTTON = "//span[contains(text(),'New Segment')]//ancestor::div[contains(@role,'dialog')]//div[contains(@class,'el-dialog__footer')]//span[contains(text(),'{}')]"
SEGMENT_EDIT_MODEL_POPUP = "//span[contains(text(),'Edit Segment')]//ancestor::div[contains(@role,'dialog')]"
SEGMENT_EDIT_MODEL_TITLE = "//div[contains(@class,'el-dialog__body')]//preceding-sibling::div[contains(@class,'el-dialog__header')]//span[contains(text(),'Edit Segment')]"
SEGMENT_EDIT_MODEL_DELETE_SAVE_CANCEL_BUTTON = "//span[contains(text(),'Edit Segment')]//ancestor::div[contains(@role,'dialog')]//button//span[contains(text(),'{}')]"
SEGMENT_EDIT_MODEL_DESCRIPTION = "//span[contains(text(),'Any changes made will be updated')]//*[contains(text(),'for all users')]"
SEGMENT_MODEL_NAME_LABEL = "//label[contains(text(),'Segment name')]"
SEGMENT_MODEL_NAME_INPUT = "//input[contains(@placeholder,'Name your segment')]"
SEGMENT_MODEL_HELP_TEXT = "//span[contains(text(),'Future candidates matching these filters will be added automatically. This segment will be')]"
SEGMENT_MODEL_ASSIGN_SEGMENT_LABEL = "//label[contains(text(),'Assign Segment')]"
SEGMENT_MODEL_ASSIGN_SEGMENT_DROPDOWN = "//label[contains(text(),'Assign Segment')]//following-sibling::div[contains(@class,'el-dropdown')]"
SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_SELF = "//span[contains(text(),'{} (You)') and contains(@class,'el-radio__label')]//parent::label[contains(@role,'radio')]"
SEGMENT_MODEL_ASSIGN_SEGMENT_OPTION_ALL = "//span[contains(text(),'All Users') and contains(@class,'el-radio__label')]//parent::label[contains(@role,'radio')]"
SEGMENT_MODEL_ASSIGN_SEGMENT_APPLY_CANCEL = "//div[contains(@role,'radiogroup')]//following-sibling::div//span[contains(text(),'{}')]"
SEGMENT_EDIT_MODEL_ALREADY_EXITS_MESSAGE = "//i[contains(@class,'icon-noti-warning')]//parent::span[contains(text(),'Segment name already exits')]"
SEGMENT_EDIT_MODEL_DELETE_SEGMENT_DELETE_CANCEL = "//*[contains(@class,'el-message-box__btns')]//button//span[contains(text(),'{}')]"

# BASE PAGE / Segment Layout Setting Model
SEGMENT_LAYOUT_SETTING_TITLE = "//*[contains(text(),'Layout Setting')]"
SEGMENT_LAYOUT_SETTING_TAB_FOR_YOU_BUTTON = "//div[contains(@id,'tab-for_you') and contains(text(),'For You')]"
SEGMENT_LAYOUT_SETTING_TAB_FOR_ALL_BUTTON = "//div[contains(@id,'tab-for_all') and contains(text(),'For All')]"
SEGMENT_LAYOUT_SETTING_CANDIDATE_SECTION_TITLE = "//div[contains(@class,'el-tabs__content')]//div//span[contains(text(),'CANDIDATES')]"
SEGMENT_LAYOUT_SETTING_PATTERN_ITEM = "//div[contains(@class,'el-tabs__content')]//div//span[contains(@class,'text-overflow') and contains(text(),'{}')]"
SEGMENT_LAYOUT_SETTING_PATTERN_DROP_DRAG = "//div[contains(@class,'el-tabs__content')]//div//span[contains(@class,'text-overflow') and contains(text(),'{}')]//following-sibling::i[contains(@class,'icon-drag')]"
SEGMENT_LAYOUT_SETTING_DELETE_SAVE_CANCEL = "//div[contains(@class,'el-dialog__footer')]//button//*[contains(text(),'{}')]"

# confirm move status Profile
OK_BTN_CONFIRM_BOX = "//div[contains(@class, 'el-message-box ol-confirm')]//span[contains(text(), 'Ok')]"
MOVE_STATUS_PROFILE_BOX_VALUE = "//div[contains(@class, 'el-message-box__message')]//p"

# CONFIRM STATE UPDATE POPUP
CEM_CONFIRM_STATE_UPDATE_POPUP_TITLE = "//*[contains(text(),'Confirm Status Update')]"
CEM_CONFIRM_STATE_UPDATE_POPUP_CONFIRM_CANCEL_BUTTON = "//*[contains(text(),'Confirm Status Update')]//following::button//*[contains(text(),'{}')]" #PARAMETER IS BUTTON NAME

# CONFIRM CANCEL OFFER POPUP
CEM_CONFIRM_CANCEL_OFFER_POPUP_BUTTON = "//*[contains(@class,'el-message-box__btns')]//*[contains(@type,'button')]//*[contains(text(),'{}')]"
CEM_CONFIRM_CANCEL_OFFER_POPUP_CLOSE_ICON = "//*[contains(@aria-label,'Cancel Offer')]//*[contains(@aria-label,'Close')]"

# Base page / Candidate profile information
PROFILE_CARD_INFORMATION = "//*[contains(@data-testid,'candidate_inbox_profile_card_item') ]//*[contains(text(),'{}')]"
CEM_CANDIDATE_PROFILE_RESUME_FILE = "//iframe[not(contains(@style, 'display: none;'))]"

# Update action
CEM_UPDATE_INTERVIEW_REQUEST = "//a[contains(@class, 'el-link')]//span[contains(text(), 'Update')]"

# Hire details
CEM_CANDIDATE_FORM = "//div[contains(@class, 'hire-form')]//div[contains(text(), '{}')]"
CEM_CANDIDATE_FORM_TITLE = "//div[contains(text(), 'Personal Information')]//following-sibling::div//div[contains(text(), '{}')]"
CEM_CANDIDATE_FORM_TITLE_CUSTOM = "//div[contains(text(), 'Custom')]//following-sibling::div//div[contains(text(), '{}')]"
CEM_I9_FORM_TITLE = "//div[contains(text(), 'I9')]//following-sibling::div//div[contains(text(), '{}')]"
CEM_CANDIDATE_FORM_TITLE_SENSITIVE_INFORMATION = "//div[normalize-space()= '{}']//following-sibling::div//input[contains(@type, 'password')]"
CEM_CANDIDATE_FORM_ELLIPSE_ICON_BY_NAME = "//*[contains(text(),'{}')]//parent::div//i[contains(@class,'icon-horizontal-menu')]"
CEM_CANDIDATE_FORM_COPY_FIELD_VALUE_ICON = "(//i[contains(@class,'icon-copy')])[last()]"
CEM_CANDIDATE_FORM_EDIT_FIELD_ICON = "(//i[contains(@class,'icon-edit')])[last()]"
CEM_CANDIDATE_FORM_CLOSE_ICON = "(//i[contains(@class,'icon-remove')])[last()]"
CEM_CANDIDATE_FORM_ANSWER_TEXTBOX_BY_QUESTION_NAME = "//*[text()='{}']//parent::*//input"
CEM_CANDIDATE_FORM_SAVE_BUTTON = "(//button[contains(@class, 'button--primary')]//*[contains(text(), 'Save')])[last()]"
CEM_CANDIDATE_FORM_CONFIRM_BUTTON = "(//button[contains(@class, 'button--primary')]//*[contains(text(), 'Confirm')])[last()]"
CEM_CANDIDATE_FORM_VIEW_TAX_WITHHOLDING = "//section[contains(@class, 'el-drawer')]//*[contains(text(), '{}')]//following-sibling::*//span[contains(text(), 'View')]"
CEM_CANDIDATE_FORM_DATE_COMPLETED_FEDERAL_FORM = "//section[contains(@class, 'el-drawer')]//*[contains(text(), 'Federal tax forms')]//following-sibling::*//*[contains(text(), '{}')]"
CEM_CANDIDATE_FORM_DATE_COMPLETED_STATE_FORM = "//section[contains(@class, 'el-drawer')]//*[contains(text(), 'State tax forms')]//following-sibling::*//*[contains(text(), '{}')]"
CEM_CANDIDATE_FORM_MODAL = "//*[contains(@aria-modal, 'true')]//*[@id='el-drawer__title']//*[contains(text(), '{}')]"
CEM_HIRE_DETAILS_UPLOAD_FILE = "(//input[@type='file'])[last()]"
CEM_HIRE_DETAILS_ADD_FILE_BUTTON = "(//button[contains(@class, 'el-button') and not(contains(@class, 'is-disabled'))])[last()]"
CEM_HIRE_DETAILS_HIRE_ITEM = "//*[contains(text(), '{}')]//ancestor::div[contains(@class, 'hire-item')]"
CEM_HIRE_DETAILS_FORM_EDIT_ICON = "//div[contains(text(), '{}')]//following-sibling::div//span[contains(@class, 'el-dropdown-selfdefine')]"
CEM_HIRE_DETAILS_FORM_EDIT_BUTTON = "//ul[contains(@class, 'el-dropdown-menu')]//span[contains(text(), 'Edit Field')]"
CEM_HIRE_DETAILS_FORM_HIDE_INPUT = "//div[contains(text(), '{}')]//following-sibling::div//input"
CEM_HIRE_DETAILS_FORM_COPY_VALUE_BUTTON = "//ul[contains(@class, 'el-dropdown-menu')]//span[contains(text(), 'Copy Field Value')]"
CEM_HIRE_DETAILS_FORM_RADIO_OPTION_ICON = "//div[contains(text(), '{}')]//following-sibling::div//*[contains(@class, 'icon-chevron-down')]"
CEM_HIRE_DETAILS_FORM_APPLY_BUTTON = "//div[contains(@class, 'el-popper')]//span[contains(text(), 'Apply')]"
CEM_HIRE_DETAILS_NAME_USER_FORM_LABEL = "//*[contains(@data-testid, 'form_name_user_form_cem_lbl') and contains(text(), '')]"
CEM_HIRE_DETAILS_OFFER_NAME = "//div[contains(@class,'hire-offer')]//div[contains(text(),'{}')]" #PARAMETER IS OFFER NAME
CEM_HIRE_DETAILS_OFFER_EXPIRED = "//*[contains(@class,'status-expired')]"

# Message Notification
MESSAGE_SEGMENT_SET_AS_SUCCESS = "//*[contains(text(),'{} set as home')]"

# BASE PAGE / About / Candidate summary
CEM_CANDIDATE_SUMMARY_ICON_COMPANY = "//*[contains(@class,'icon-cc-company')]"
CEM_CANDIDATE_SUMMARY_WORK_EXPERIENCE_INFORMATION = "//*[contains(@data-testid,'candidate_inbox_section_work_experience_field')]//*[contains(@class,'msg-text')]/div"
CEM_CANDIDATE_SUMMARY_WORK_EXPERIENCE_INFORMATION_FIELD = "//*[contains(@data-testid,'candidate_inbox_section_work_experience_field')]//*[contains(@class,'msg-text')]/*[contains(text(),'{}')]"
CEM_CANDIDATE_SUMMARY_WORK_EXPERIENCE_ITEM = "//*[contains(@data-testid,'candidate_inbox_section_work_experience_field')]/*[contains(text(),'{}')]"
CEM_CANDIDATE_SUMMARY_PERSONAL_INFORMATION_ITEM = "//*[contains(@data-testid,'candidate_inbox_section_personal_information_field')]/*[contains(text(),'{}')]"
CEM_CANDIDATE_SUMMARY_PERSONAL_INFORMATION_FIELD = "//*[contains(@data-testid,'candidate_inbox_section_personal_information_field')]//div[contains(@class,'msg-text')]//child::*[contains(text(),'{}')]"
CEM_CANDIDATE_SUMMARY_CONTENT = "//*[contains(@data-testid,'candidate_inbox_profile')]//*[contains(@class,'msg-text')]//*[contains(text(),'{}')]"

# User send form in Japanese
CEM_SEND_USER_FORM_INPUT = "//div[contains(@class, 'form-experience-item') and contains(., '{}')]//input"
CEM_SEND_USER_FORM_COUNTRY_SELECT = "//*[contains(@data-testid, 'country_address_item_user_form_cem_select')]"
CEM_SEND_USER_FORM_APT_SUITE_FLOOR_INPUT = "//*[contains(@data-testid, 'apt_floor_suite_user_form_cem_input')]"
CEM_SEND_USER_FORM_ADDRESS_INPUT = "//*[contains(@data-testid, 'address_user_form_cem_input')]"
CEM_SEND_USER_FORM_COUNTRY_VALUE = "//*[contains(@data-testid, 'country_address_item_user_form_cem_select') and contains(., '{}')]"

# Candidate status
CEM_CANDIDATE_STATUS_DROPDOWN_TEXT = "//ul[contains(@class, 'el-dropdown-menu')]//span[contains(text(), '{}')]"
CEM_CANDIDATE_JOURNEY_STEP_BUTTON = "//*[contains(@id, 'collapse-head')]//*[contains(text(), '{}')]"
CEM_STATUS_TEXT = "//div[@id='board-profile']//span[contains(@class,'hidden-xs-only')]"

# Base page / Hire Details / Offers
CANCEL_OFFER_MODAL_HEADER = "//div[contains(@class, 'header')]//div[contains(@class, 'title')]//span[text()='Cancel Offer']"
CANCEL_OFFER_MODAL_TITLE = "//div[contains(@class, 'content')]//*[contains(text(), 'Cancellation message that {} will recieve')]"
CANCEL_OFFER_MODAL_CONTENT = "//div[contains(@class, 'content')]//div[contains(@class, 'el-input')]//div[contains(text(), 'Hi {}, unfortunately your offer at Test Automation Job on Data package off Site has been canceled')]"
CANCEL_OFFER_CONFIRM_BUTTON = "(//button[contains(@class, 'el-button--primary')]//span[contains(text(), 'Confirm')])[last()]"
CANCEL_OFFER_NEVERMIND_BUTTON = "//button[contains(@class, 'el-button--default')]//span[contains(text(), 'Nevermind')]"
CANCEL_OFFER_INPUT = "//div[contains(@class, 'el-input__inner') and contains(@data-testid, 'content_cancel_input')]"
HIRE_DETAILS_OFFER_STATUS = "//div[contains(@class, 'hire-item--status')]//span"
ICON_CANCEL_OFFER_HISTORY = "(//div[contains(@class, 'status-canceled')]//i[contains(@class, 'icon-spam')])[last()]"
DATE_TIMESTAMP_CANCELED_OFFER_HISTORY = "(//i[contains(@class, 'icon-spam')]//ancestor::div[contains(@class, 'status-canceled')])[last()]//child::div[contains(@class, 'color')]"

# Click offer link after cancel offer to open error offer page
ICON_ERROR_OFFER_PAGE = "//main[contains(@class, 'el-main')]//i"
TITLE_ERROR_OFFER_PAGE = "//main[contains(@class, 'el-main')]//span[contains(text(), 'Offer Canceled')]"
