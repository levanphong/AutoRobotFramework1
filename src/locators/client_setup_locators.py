# Define locator client setup
IN_PERSON_INTERACTION_TYPES = "//div[contains(@class, 'controls text-triangle event_venue_type_container event-dropdown-type')]"
VIRTUAL_EVENTS_INTERACTION_TYPES = "//div[contains(@class, 'controls text-triangle event_interaction_type_in_person_container event-dropdown-type')]"
VIRTUAL_HIRING_EVENTS = "//label[contains(text(), 'Virtual Hiring Events')]//span"
IN_PERSON_HIRING_EVENTS = "//label[contains(text(), 'Person Hiring Events')]//span"
VENUE_TYPES = "//div[contains(@class, 'event_venue_type_container event-dropdown-type')]"
VENUE_TYPES_VIRTUAL = "//div[contains(@class,'event_venue_type_container')]//input[2]"
VIRTUAL_EVENTS_INTERACTION_TYPES = "//strong[contains(text(), 'Virtual Events')]"
IN_PERSON_EVENTS_INTERACTION_TYPES = "//strong[contains(text(), 'In-Person Events')]"
IN_PERSON_EVENTS_INTERACTION_TYPES_DROPDOWN = "//div[contains(@class, 'event_interaction_type_in_person_container event-dropdown-type')]"
APPLY_BUTTON_VENUE_TYPES = "(//button[contains(@type,'button') and contains(text(), 'Apply')])[1]"
APPLY_BUTTON_VIRTUAL_VENUE_TYPES = "(//button[contains(@type,'button') and contains(text(), 'Apply')])[3]"
EVENT_SESSIONS = "//label[contains(text(), 'Event Sessions')]//span"
SCHEDULED_INTERVIEWS = "//label[contains(text(), 'Scheduled Interviews')]//span"
APPLY_BUTTON_INTERACTED_IN_PERSON_TYPE = "(//button[contains(@type,'button') and contains(text(), 'Apply')])[2]"
CLIENT_SETUP_SAVE_BUTTON = "(//*[contains(@class, 'el-button--primary')]//span[normalize-space()='Save'] | //*[contains(@class, 'btn-save') and normalize-space(text())='Save'])[last()]"
CLIENT_SETUP_YOUR_CHANGE_SAVED = "//*[@id='message-ctn' and contains(normalize-space(), 'Your changes have been saved.') and contains(@style, 'display: block;')]"
ENABLE_PARADOX_VIDEO_IN_ALL_INBOXES_TOGGLE = "//*[@id='enable_paradox_video_in_all_inboxes']//following-sibling::span"

#interacted type
VIRTUAL_CHAT_BOOTHS_CHECKBOX = "//label[contains(text(), 'Virtual Chat Booths')]//span"
LIVE_VIDEO_BROADCASTS_CHECKBOX = "//label[contains(text(), 'Live Video Broadcasts')]//span"
VIRTUAL_SCHEDULED_INTERVIEWS_CHECKBOX = "//label[contains(text(), 'Virtual Scheduled Interviews')]//span"
VIRTUAL_EVENTS_INTERACTION_TYPES_DROPDOWN = "//div[contains(@class, 'event_interaction_type_virtual_')]"

# RIGHT MENU LABEL
EVENTS_LABEL = "//aside[contains(@class, 'el-aside')]//strong[contains(text(), 'Events')]"
INTEGRATIONS_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Integrations')]"
CAPTURE_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Capture')]"
HIRE_LABEL = "//strong[contains(text(), 'Hire')]//parent::*//following-sibling::*[contains(@class,'icon-chevron-right')]"
JOB_SEARCH_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Job Search')]"
MORE_LABEL = "//strong[contains(text(), 'More')]//parent::*//following-sibling::*[contains(@class,'icon-chevron-right')]"
COMPLIANCE_AND_SECURITY_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Compliance and Security')]"
CARE_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Care')]"
MULTILINGUAL_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Multilingual')]"
SCHEDULING_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Scheduling')]"
ACCOUNT_OVERVIEW_LABEL = "//div[contains(@class,'el-scrollbar__view')]//span//strong[contains(text(),'Account Overview')]"

# INTEGRATIONS
ATS_TOGGLE = "//label[@for='ats_on']"
ATS_SYSTEM_SELECTION = "//select[@id='id_ats_system']"
ATS_SYSTEM_NAME = "//option[text()='{}']"
ATS_HOST = "//input[@id='id_meta_sfactors_host']"
ATS_COMPANY_ID = "//input[@id='id_meta_sfactors_company_id']"
ATS_USERNAME = "//input[@id='id_meta_sfactors_username']"
ATS_PASSWORD = "//input[@id='id_meta_sfactors_password']"

# CAPTURE
FOLLOW_UP_TOGGLE = "//label[@for='follow_on']"
OUTBOUND_TOGGLE = "//label[@for='outbound_on']"
SCREEN_AND_ACTION = "//label[@for='auto_schedule']"

# CAPTURE / Multi Application
MULTI_APPLICANTION_SELECT_DAYS_DROPDOWN = "//*[@id='multiapp_num_days']"
MULTI_APPLICANTION_SELECT_DAYS_ITEM = "//ul[contains(@class,'el-select-dropdown')]//span[text()='{}']"  # NUMBER OF DAY
MULTI_APPLICANTION_VERIFY_CODE_DROPDOWN = "//*[@id='multiapp_sending_type']"
MULTI_APPLICANTION_VERIFY_CODE_ITEM = "//ul[contains(@class,'el-select-dropdown')]//span[text()='{}']"

# HIRE
OLIVIA_HIRE_TOGGLE = "//label[@for='olivia_hire_on']"
CANDIDATE_JOURNEYS_TOGGLE = "//label[@for='id_candidate_journeys_on']"
JOBS_TOGGLE = "//label[@for='jobs_on']"
CLIENT_SETUP_FORM_TOGGLE = "//label[@for='job_app_on']"
JOB_DATA_PACKAGES_ON = "//label[@for='job_data_packages_on']"
OFFER_TOGGLE = "//label[@for='id_offer_on']"
FRANCHISE_TOGGLE = "//label[@for='id_franchise_on']"
POPOVER_CONTENT_TEXT =  "//*[contains(@class, 'popover-content') and contains(text(),'{}')]"
JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE = "//label[@for='job_candidate_volume_optimizer_on']"
JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_ICON_TOOLTIP = "//*[contains(@class,'margin-child')]//*[contains(@class,'icon-info')]"
JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_TOOLTIP = "//*[contains(@class,'popover-content')]"
ATS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE = "//label[@for='ats_candidate_volume_optimizer_on']"
ATS_JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_ICON_TOOLTIP = "//*[contains(@class,'ats-job-feed-manager')]//*[contains(@class,'icon-info')]"
ATS_JOBS_CANDIDATE_VOLUME_OPTIMIZER_TOGGLE_TOOLTIP = "//*[contains(@class,'popover-content')]"
HIRE_ATS_SAVING_STATUS = "//*[contains(@class,'ats-job-feed-manager__status')]//*[contains(@class, 'status__title') and contains(text(), '{}')]"
HIRE_ATS_JOB_FEED_MANAGER_TOGGLE = "//*[contains(@for,'id_ats_job_feed_on')]"
HIRE_APPLICANT_FLOW_TOGGLE = "//*[contains(@for,'id_applicant_flow_on')]"
HIRE_TAX_WITHHOLDING_TOGGLE = "//*[contains(@for,'id_tax_withholding_on')]"
HIRE_TAX_WITHHOLDING_PROVIDER_SYSTEM_SELECT = "//div[contains(@class, 'tax-withholding-provider')]//select[@name='provider_system']"
HIRE_I_9_PROVIDER_SYSTEM_SELECT = "//*[contains(text(), 'I-9 provider')]//ancestor::div[contains(@class, 'provider-system')]//select[contains(@name, 'provider_system')]"
HIRE_I_9_URL_CODE_INPUT = "//div[contains(@class, 'paradox-i9-credentials')]//input[contains(@name, 'urlCode')]"
HIRE_I_9_URL_CODE_VALIDATOR_LABEL = "//div[contains(@class, 'paradox-i9-credentials')]//*[contains(text(), '{}')]"

# HIRE / Available job types popup
AVAILABLE_JOB_SELECT_ALL_CHECKBOX = "//input[@class='select-all']//following-sibling::span"
AVAILABLE_JOB_APPLY_BUTTON = "//button[@class='btn btn-primary btn-sm ok-job-type-btn']"
AVAILABLE_JOB_CANCEL_BUTTON = "//button[@class='btn btn-primary btn-sm ok-job-type-btn']/preceding-sibling::button"
AVAILABLE_JOB_TYPES_DROPDOWN = "//input[@class='form-control ai-input job-types text-overflow']"
CLIENT_SETUP_JOB_TYPE= "//*[@data-name='{}']/parent::label//span"
WARNING_JOB_TYPE= "//*[contains(@class,'warning-job-type')]"
WARNING_COULD_NOT_DELETE_JOB_TYPE = "//*[contains(@class,'modal-title bold') and contains( text(),'Couldn’t Delete Job Type')]"
BUTTON_CANCEL_DELETE_HIRING_TEAM_ROLE = "//*[contains(text(),'Couldn’t Delete Hiring Team Role')]/ancestor::div[contains(@class,'modal-dialog')]//button[contains(text(),'Cancel')]"
ICON_TOOLTIP= "//*[contains(@class,'config-hiring-header')]//span"
INPUT_HIRING_ROLE_NAME = "(//*[contains(@class,'hiring-team-item-body')]//input[contains(@placeholder,'Enter Name')])[3]"
BUTTON_SAVE_ADD_HIRING_ROLE = "//span[contains(text(),'Add New Role')]/ancestor::div[contains(@class,'sidebar-cal-right--on')]//button[contains(text(),'Save')]"
ICON_DELETE_HIRING_ROLE = "//div[contains(text(),'{}')]/parent::div//span"
CONFIG_HIRING_TEAM_EDIT_BUTTON = "//button[contains(@class, 'btn-config-hiring-team') and contains(normalize-space(), 'Edit')]"

# HIRE / ATS Job Feed Manager
ATS_EDIT_BUTTON = "//button[contains(@class, 'config-ats-job-feed') and contains(normalize-space(), 'Edit')]"
ATS_CONFIGURE_BUTTON = "//button[contains(@class, 'config-ats-job-feed') and contains(normalize-space(), 'Configure')]"
ATS_SELECT_FEED_DROPDOWN = "//*[@id='ats-feed-companies-master-feed']"
ATS_SELECT_FEED_SEARCH_TEXTBOX = "//*[contains(@placeholder, 'Search feeds')]"
ATS_SELECT_FEED_ITEM = "//*[contains(@class, 'company-result')]//li[normalize-space()='{}']"
ATS_SELECT_FEED_APPLY_BUTTON = "//*[contains(@class,'ok-btn') and contains(text(), 'Apply')]"
ATS_SELECT_FEED_CANCEL_BUTTON = "//*[contains(@class,'cancel-btn') and contains(text(), 'Cancel')]"
ATS_SELECT_FEED_CONTINUE_BUTTON = "//*[contains(@class,'ok-btn') and contains(text(), 'Yes, continue')]"

# HIRE / ATS Job Feed Manager / Configure ATS Job Feeds Dialog
CONFIGURE_ATS_SELECT_FEED_DROPDOWN = "//*[@id='ats-feed-companies-my-job']"
CONFIGURE_ATS_SELECT_FEED_SEARCH_TEXTBOX = "//*[contains(@placeholder, 'Search for Job Feeds')]"
CONFIGURE_ATS_SELECT_FEED_ITEM = "(//*[contains(@class, 'company-result')]//li[normalize-space()='{}'])[last()]"
CONFIGURE_ATS_SELECT_FEED_APPLY_BUTTON = "(//*[contains(@class,'ok-btn') and contains(text(), 'Apply')])[last()]"
CONFIGURE_ATS_SELECT_FEED_CANCEL_BUTTON = "(//*[contains(@class,'cancel-btn') and contains(text(), 'Cancel')])[last()]"
CONFIGURE_ATS_SAVE_BUTTON = "//*[contains(@class,'modal-config-ats-job-feed')]//*[text()='Save']"
CONFIGURE_ATS_CANCEL_BUTTON = "//*[contains(@class,'modal-config-ats-job-feed')]//*[text()='Cancel']"
CONFIGURE_ATS_CONDITION_THEN_DROPDOWN = "//*[contains(@class,'condition__wrap-main-content')]//*[contains(@class, 'value-select')]"
CONFIGURE_ATS_CONDITION_THEN_ITEM = "//*[contains(@class,'custom-select__dropdown-item') and contains(normalize-space(), '{}')]"  # parameter is ON/OFF
CONFIGURE_ATS_CONDITION_SAVE_BUTTON = "//*[contains(@class,'condition')]//*[contains(text(), 'Save')]"

# HIRE / ATS Job Feed Manager / Configure ATS Job Feeds Dialog / Please confirm feeds Model
ATS_CONFIRM_FEED_CONTINUE_BUTTON = "//*[contains(@class,'ok-btn') and contains(text(), 'Continue')]"

# CANDIDATE JOURNEY
CLIENT_SETUP_CANDIDATE_JOURNEYS_TOGGLE = "//*[contains(@id, 'candidate_journey_on')]//following-sibling::*[contains(@class, 'el-switch__core')]"
CLIENT_SETUP_NEXT_STEPS_TOGGLE = "//*[contains(@id, 'next_steps_on')]//following-sibling::*[contains(@class, 'el-switch__core')]"
CLIENT_SETUP_CANDIDATE_RECEIVED_STATUS_TOGGLE = "//*[contains(@id, 'candidate_received_status_on')]//following-sibling::*[contains(@class, 'el-switch__core')]"

# EVENTS
EVENTS_TOGGLE = "(//label[contains(@for, 'event_on')])[1]"
HIRING_EVENTS_TOGGLE = "//label[contains(@for, 'event_general_hiring_on')]"
ORIENTATION_ON_TOGGLE = "//*[@id='event_orientation_on']//following-sibling::span"
EDIT_PAST_EVENTS_TOGGLE = "//label[contains(@for, 'edit_past_event_on')]"
CLIENT_SETUP_EVENT_CLOSE_CHECK_IN_TOGGLE = "//label[contains(@for, 'orientation_user_close_check_in_on')]"
CLIENT_SETUP_INPUT_DEFAULT_USER_GROUPS = "//*[@id= 'event_roster_default_user_groups']"
CLIENT_SETUP_USER_GROUPS_LIST = "//div[contains(@class, 'user-group-dropdown')]//div[contains(@class, 'dropdown-list')]"
CLIENT_SETUP_EVENT_ROSTER_HOUR_BEFORE_INPUT = "//*[@id= 'event_roster_sent_before_event_hour']"
CLIENT_SETUP_EVENT_ROSTER_LINK_EXPIRED_HOUR_INPUT = "//*[@id= 'event_roster_link_expired_hour']"
CLIENT_SETUP_EVENT_ROSTER_CHECK_IN_EXPIRED_HOUR_INPUT = "//*[@id= 'event_roster_check_in_expired_hour']"
CLIENT_SETUP_EVENT_ROSTER_HOUR_OPTION = "//*[@id= 'event_roster_sent_before_event_hour']"
EVENT_JOB_TRIGGER_ON = "//label[contains(@for, 'event_job_requisition_trigger_on')]"

# EVENTS / Jobs
EVENT_JOBS_TOGGLE = "//label[contains(@for, 'event_job_requisition_on')]"
JOBS_TRIGGER_TOGGLE = "//label[contains(@for, 'event_job_requisition_trigger_on')]"
CANDIDATE_STORE_AVAILABLE_LOCATION_TOGGLE = "//label[contains(@for, 'event_candidate_store_location_on')]"
MANUAL_SCHEDULING_ADVANCED_SETTING_TOGGLE = "//label[contains(@for, 'event_sched_settings_on')]"
CUSTOMIZE_SCHEDULING_TIME_LINE_TOGGLE = "//*[contains(@id, 'event_sched_timeline_on')]//following-sibling::span[contains(@class, 'el-switch__core')]"
INPUT_EVENT_ORIENT_TIME_LINE_MAX = "//select[contains(@id, 'id_event_orientation_timeline_max')]"

# EVENTS / Event Phone Number and Keyword association period
BEFORE_VALUE_SELECTION = "//select[@id='id_before_value']"
BEFORE_VALUE = "//select[@id='id_before_value']//option[text()='{}']"
BEFORE_UNIT_SELECTION = "//select[@id='id_before_unit']"
BEFORE_UNIT = "//select[@id='id_before_unit']//option[text()='{}']"
AFTER_VALUE_SELECTION = "//select[@id='id_after_value']"
AFTER_VALUE = "//select[@id='id_after_value']//option[text()='{}']"
AFTER_UNIT_SELECTION = "//select[@id='id_after_unit']"
AFTER_UNIT = "//select[@id='id_after_unit']//option[text()='{}']"

# JOB SEARCH
JS_JOB_SEARCH_TOGGLE = "//*[contains(@id, 'js_on')]/following-sibling::span"
JS_ENV_SELECTION = "//select[@id='id_job_search_env']"
JS_ENV_VALUE = "//select[@id='id_job_search_env']//option[text()='{}']"
JS_SEARCH_COMPANY_SELECTION = "//*[contains(@class, 'job-search-companies')]"
JS_SEARCH_COMPANY_SEARCH_TEXTBOX = "//*[contains(@class, 'search-company-pop')]//*[contains(@type, 'text')]"
JS_SEARCH_COMPANY_CHECKBOX = "//*[contains(@class, 'search-company-pop')]//*[normalize-space()='{}']//span"
JS_SEARCH_COMPANY_APPLY_BUTTON = "//*[contains(@class, 'search-company-pop')]//*[contains(@class, 'btn-apply')]"
JS_SEARCH_COMPANY_CANCEL_BUTTON = "//*[contains(@class, 'search-company-pop')]//*[contains(@class, 'cancel-btn')]"
JS_SEARCH_AN_ATS_TEXTBOX = "//*[contains(@id, 'filter-input')]"
JS_SEARCH_PARAMETERS_DROPDOWN = "//*[contains(@id, 'job_search_parameters_id')]"
JS_SEARCH_PARAMETERS_ITEM = "//*[contains(., '{}')]/preceding-sibling::span"
JS_SEARCH_PARAMETERS_SELECT_ALL_ITEM = "//*[contains(@id, 'job_search_parameters_id')]//*[normalize-space()='Select all']//span"
JS_INCLUDE_REMOTE_JOBS_TOGGLE = "//*[contains(@id, 'include_remote_jobs')]/following-sibling::span"
JS_PRIORITY_LOCATION_DURING_SEARCH_TOGGLE = "//*[contains(@id, 'job_search_prioritize_location')]/following-sibling::span"
JS_MULTIPLE_LOCATION_MATCHING_TOGGLE = "//*[contains(@id, 'job_search_multiple_location_matching')]/following-sibling::span"
JS_CHAT_TO_APPLY_TOGGLE = "//*[contains(@id, 'chat_to_apply')]/following-sibling::span"
JS_JOB_REQ_ID_SEARCH_TOGGLE = "//*[contains(@id, 'job_search_reqid_on')]/following-sibling::span"
JS_CANDIDATE_TYPE_TOGGLE = "//*[contains(@id, 'job_search_candidate_type_on')]/following-sibling::span"
JS_SET_DEFAULT_PARAMETER_TOGGLE = "//*[contains(@id, 'default_job_search_parameter_on')]/following-sibling::span"
JS_GEOGRAPHIC_TARGETING_TOGGLE = "//*[contains(@id, 'restrict_ip')]/following-sibling::span"

# JOB SEARCH / Geographic targeting
GEOGRAPHIC_TARGETING_SEARCH_TEXTBOX = "//*[contains(@id, 'geo_targeting')]"
GEOGRAPHIC_TARGETING_COUNTRY_ITEM = "//*[contains(@id, 'countries')]//*[contains(normalize-space(), '{}')]"

# JOB SEARCH / Chat to apply
CHAT_TO_APPLY_CATCH_ALL_CONVO_TOGGLE = "//*[contains(@for, 'catch_all_on')]"
CHAT_TO_APPLY_TITLE_TEXTBOX = "//*[contains(@id, 'id_job_target_rule_name')]"
CHAT_TO_APPLY_ADD_BUTTON = "//*[contains(@id, 'add_job_target_rule')]"
CHAT_TO_APPLY_SELECT_CHANNEL_DROPDOWN = "//*[contains(@id, 'id_chat_to_apply_channel')]"
CHAT_TO_APPLY_SELECT_CHANNEL_ITEM = "//*[contains(@id, 'id_chat_to_apply_channel')]//*[contains(text(),'{}')]"
CHAT_TO_APPLY_SELECT_CONVERSATION_DROPDOWN = "//*[contains(@title, 'Select conversation')]"
CHAT_TO_APPLY_SELECT_CONVERSATION_SEARCH_TEXTBOX = "//*[contains(@class, 'select2-search__field')]"
CHAT_TO_APPLY_SELECT_CONVERSATION_ITEM = "//li[contains(@class, 'select2-results__option') and contains(normalize-space(), '{}')]"
CHAT_TO_APPLY_ADD_CONDTION_BUTTON = "//*[contains(@class, 'add-condition')]"
CHAT_TO_APPLY_SAVE_BUTTON = "(//*[contains(@type, 'submit') and normalize-space()='Save'])[last()]"
CHAT_TO_APPLY_OPERATOR_DROPDOWN = "//*[contains(@class, 'and-condition-item')][{}]//*[contains(@name, 'label_operator')]"  #parameter is index of condition
CHAT_TO_APPLY_OPERATOR_LAST_DROPDOWN = "(//*[@id = 'conditions']//div[contains(@class, 'and-conditions')]//*[contains(@name, 'label_operator')])[last()]"
CHAT_TO_APPLY_OPERATOR_ITEM = "//*[contains(@class, 'operator__item') and contains(normalize-space(), '{}')]//label"
CHAT_TO_APPLY_TYPE_DROPDOWN = "//*[contains(@class, 'and-condition-item')][{}]//*[contains(@name, 'label_type')]"  #parameter is index of condition
CHAT_TO_APPLY_TYPE_LAST_DROPDOWN = "(//*[@id = 'conditions']//div[contains(@class, 'and-conditions')]//*[contains(@name, 'label_type')])[last()]"
CHAT_TO_APPLY_TYPE_ITEM = "//*[contains(@value, '{}')]/following-sibling::label"
CHAT_TO_APPLY_MATCH_VALUE_TEXTBOX = "//*[contains(@class, 'and-condition-item')][{}]//*[contains(@name, 'match_values')]/..//input"  #parameter is index of condition
CHAT_TO_APPLY_MATCH_LAST_VALUE_TEXTBOX = "//*[@class='condition-item'][2]//input[@type='text']"
CHAT_TO_APPLY_ADD_AND_BUTTON = "//*[contains(@class, 'add-and-condition')]"
CHAT_TO_APPLY_ADD_OR_BUTTON = "//*[contains(@class, 'add-or-condition')]"
CHAT_TO_APPLY_SELECT_CONVERSATION = "//*[contains(@id, 'conversations-container')]"
CHAT_TO_APPLY_SEARCH_CONVERSATION_TEXTBOX = "//*[contains(@class, 'search__field')]"
CHAT_TO_APPLY_SEARCH_CONVERSATION_ITEM = "//li[contains(@class, 'results__option') and contains(normalize-space(), '{}')]"

# JOB SEARCH / Job Requisition ID Search
JOB_REQ_ID_SEARCH_FIRST_PATTERN_DROPDOWN = "//*[contains(@class, 'el-row is-align-bottom')]//*[contains(@placeholder, 'Select')]"
JOB_REQ_ID_SEARCH_FIRST_VALUE_TEXTBOX = "//*[contains(@class, 'el-row is-align-bottom')]//*[contains(@placeholder, 'Add Value')]"
JOB_REQ_ID_SEARCH_LAST_PATTERN_DROPDOWN = "(//*[contains(@class, 'el-row is-align-bottom')]//*[contains(@placeholder, 'Select')])[last()]"
JOB_REQ_ID_SEARCH_LAST_VALUE_TEXTBOX = "(//*[contains(@class, 'el-row is-align-bottom')]//*[contains(@placeholder, 'Add Value')])[last()]"
JOB_REQ_ID_SEARCH_ADD_FIELD_BUTTON = "//span[normalize-space() =  'Add Field']"
JOB_REQ_ID_SEARCH_DATA_ITEM = "(//li[contains(@class, 'el-select-dropdown__item')]//span[normalize-space()='{}'])[last()]"
JOB_REQ_ID_SEARCH_REMOVE_LAST_PATTERN_BUTTON = "(//*[contains(@class, 'el-row is-align-bottom')]//*[contains(@class, 'icon-close')])[last()]"

# JOB SEARCH / Set Default Job Search Parameter
DEFAULT_PARAMETER_ATTRIBUTE_DROPDOWN = "//*[contains(@class, 'label-title') and contains(text(),'Attribute')]/following-sibling::div"
DEFAULT_PARAMETER_ATTRIBUTE_ITEM = "//*[contains(@value, '{}')]/parent::div"
DEFAULT_PARAMETER_VALUE_TEXTBOX = "//*[contains(@aria-label, 'Attribute Value')]"
DEFAULT_PARAMETER_VALUE_LABEL = "//*[contains(@class, ' label-info') and contains(normalize-space(), '{}')]"

# EVENTS / Manage Scheduling Timelines
EVENT_ORIENTATION_TIMELINE_MIN = "//*[text()='Minimum']//following-sibling::div[contains(@class, 'el-select')]"
EVENT_ORIENTATION_TIMELINE_MAX = "//*[text()='Maximum']//following-sibling::div[contains(@class, 'el-select')]"
EVENT_ORIENTATION_TIMELINE_MAX_OPTION = "(//*[contains(@class, 'el-select-dropdown__item')]//span[normalize-space()='{}'])[last()]"
EVENT_ORIENTATION_TIMELINE_MIN_OPTION = "(//*[contains(@class, 'el-select-dropdown')]//span[normalize-space()='{}'])[last()]"

# EVENTS / Limit Canceling and Rescheduling
EVENT_GENERAL_EVENT_SCHED_LABEL = "(//*[contains(@id, 'general_event_sched_reschedule')]//ancestor::div[contains(@class, 'el-row')]//preceding-sibling::div//*[contains(text(), 'Hiring Event')])[last()]"
EVENT_GENERAL_EVENT_SCHED_RESCHEDULE = "(//*[contains(@id, 'general_event_sched_reschedule')]//ancestor::div[contains(@class, 'el-select')])[1]"
EVENT_GENERAL_EVENT_SCHED_RESCHEDULE_OPTION = "//*[contains(@id, 'general_event_sched_reschedule')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"
EVENT_GENERAL_EVENT_SCHED_CANCEL = "//*[contains(@id, 'general_event_sched_cancel')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_GENERAL_EVENT_SCHED_CANCEL_OPTION = "//*[contains(@id, 'general_event_sched_cancel')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"
EVENT_ORIENTATION_EVENT_SCHED_LABEL = "(//*[contains(@id, 'orientation_event_sched_cancel')]//ancestor::div[contains(@class, 'el-row')]//preceding-sibling::div//*[contains(text(), 'Orientation')])[last()]"
EVENT_ORIENTATION_EVENT_SCHED_CANCEL = "//*[contains(@id, 'orientation_event_sched_cancel')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_ORIENTATION_EVENT_SCHED_CANCEL_OPTION = "//*[contains(@id, 'orientation_event_sched_cancel')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"
EVENT_ORIENTATION_EVENT_SCHED_RESCHEDULE = "//*[(@id = 'orientation_event_sched_reschedule')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_ORIENTATION_EVENT_SCHED_RESCHEDULE_OPTION = "//*[(@id = 'orientation_event_sched_reschedule')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"
EVENT_VIRTUAL_EVENT_SCHED_LABEL = "(//*[contains(@id, 'virtual_event_sched_cancel')]//ancestor::div[contains(@class, 'el-row')]//preceding-sibling::div//*[contains(text(), 'Virtual Chat Booth')])[last()]"
EVENT_VIRTUAL_EVENT_SCHED_CANCEL = "//*[contains(@id, 'virtual_event_sched_cancel')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_VIRTUAL_EVENT_SCHED_CANCEL_OPTION = "//*[contains(@id, 'virtual_event_sched_cancel')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"
EVENT_LIMIT_CANCEL_SCHEDULING_LABEL = "//div[@class='row limit-cancelling-scheduling']//label[(text()='{}')]"

# EVENTS / Registration & Interview Request Expiration
EVENT_REQUEST_EXPIRATION_CONTAINER = "//div[contains(@class, 'request-expiration')]"
EVENT_ITV_EXPIRED_REQUEST = "//select[@id='id_event_itv_expired_request']"
EVENT_SCHED_EXPIRED_REQUEST = "//*[contains(@id, 'event_sched_expired_request')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_SCHED_EXPIRED_REQUEST_OPTION = "//*[contains(@id, 'event_sched_expired_request')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"

# EVENTS / Rescheduling Candidate Allowances
EVENT_SCHED_RESCHEDULE_ALLOWANCE_ON = "//*[contains(@id, 'event_sched_reschedule_allowance_on')]//following-sibling::*[contains(@class, 'el-switch__core')]"
EVENT_ORIENTATION_SCHED_RESCHEDULE_ALLOWANCE_SELECT = "//*[contains(@id, 'orientation_event_sched_reschedule_allowance')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_ORIENTATION_SCHED_RESCHEDULE_ALLOWANCE_OPTION = "//*[contains(@id, 'orientation_event_sched_reschedule_allowance')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"
EVENT_GENERAL_SCHED_RESCHEDULE_ALLOWANCE_SELECT = "//*[contains(@id, 'general_event_sched_reschedule_allowance')]//ancestor::div[contains(@class, 'el-select')]"
EVENT_GENERAL_SCHED_RESCHEDULE_ALLOWANCE_OPTION = "//*[contains(@id, 'general_event_sched_reschedule_allowance')]//ancestor::div[contains(@class, 'el-select')]//*[contains(text(), '{}')]"

# MORE
WORKFLOWS_TOGGLE = "//label[contains(@for, 'workflow_on')]"
RATINGS_TOGGLE = "//label[contains(@for, 'rating_on')]"
TIMED_TRIGGERS_TOGGLE = "//label[contains(@for, 'timed_triggers_on')]"
REQUISITION_BASED_PERMISSIONS_TOGGLE = "//*[contains(@id, 'job_search_req_permissions_on')]//following-sibling::*"
REQUISITION_BASED_PERMISSIONS_CHECKED_TOGGLE = "//*[contains(@class,'is-checked')]//*[contains(@id, 'reports_and_dashboards_permission_on')]//following-sibling::*"
ADD_CANDIDATE_REQUISITION_TOGGLE = "//label[contains(@for, 'display_requisition_option_on')]"
USERS_ROLES_AND_PERMISSION_TOGGLE = "//label[contains(@for, 'users_roles_and_permissions_on')]"
ALLOW_USERS_MANAGE_RECEIVING_WORKFLOW_ALERTS_TOGGLE = "//label[contains(@for,'allow_users_to_manage_receiving_wl_alert_on')]"
EXPERIENCE_TOGGLE = "//label[contains(@for,'exp_on')]"
MICROLEANING_TOGGLE = "//label[contains(@for, 'learning_on')]"
CANDIDATE_PROFILE_OPTION_DROPDOWN = "//input[contains(@class, 'form-control ai-input')]//following-sibling::span[contains(@class, 'arrow-up-down-icon')]"
CANDIDATE_PROFILE_DROPDOWN_OPTION_SELECT = "//div[contains(@class, 'custom-checkbox')]//label[contains(@class, 'custom-select-box') and contains(., '{}')]//preceding-sibling::span"
CANDIDATE_PROFILE_DROPDOWN_OPTION_DISABLED = "//div[contains(@class, 'custom-checkbox')]//label[contains(@class, 'option disable') and contains(., '{}')]"
CANDIDATE_PROFILE_OPTION_DROPDOWN_APPLY_BUTTON = "//button[contains(@class, 'btn-sm btn-apply')]"
MORE_AI_RESUME_MATCHING_TOGGLE = "//*[contains(@for, 'ai_resume_on')]"

# COMPLIANCE AND SECURITY
TERMS_DISPLAY_AREA_DROPDOWN = "//input[@id='id_gdpr_ccpa_area']//following-sibling::input"
TERMS_DISPLAY_AREA_VALUE = "//div[@class='dropdown-menu dropdown-menu-right gdpr-area-select-wrap']//label[contains(text(),'{}')]//span"
TERMS_DISPLAY_AREA_APPLY_BUTTON = "//div[@class='dropdown-menu dropdown-menu-right gdpr-area-select-wrap']//button[@class='btn btn-primary btn-sm ok-btn' and not(contains(@disabled,'disabled'))]"

# CARE
CONTENT_MANAGEMENT_SYSTEM_TOGGLE = "//label[contains(@for, 'content_management_on')]"
CONTENT_MANAGEMENT_SYSTEM_TOGGLE_IS_ON = "//input[@id='content_management_on']//parent::div[contains(@class,'is-checked')]"
CANDIDATE_CARE_TOGGLE = "//label[contains(@for, 'kb_on')]"
EMPLOYEE_CARE_TOGGLE = "//label[contains(@for, 'ec_on')]"
KNOWLEDGE_BASE_TOGGLE = "//label[contains(@for, 'knowledge_base')]"
OLIVIA_ASSIST_TOOGLE = "//label[contains(@for,'id_olivia_assist_on')]"
CARE_LABEL = "//strong[contains(@class, '_lead_name') and contains(text(), 'Care')]"

# MULTILINGUAL
PLATFORM_LANGUAGE_TOGGLE = "//label[contains(@for, 'platform_language_on')]"
LANGUAGES_SUPPORTED_DROPDOWN = "//input[@class='form-control ai-input platform-search-languages text-overflow']"
SPANISH_ES_SUPPORTED_CHECKBOX = "//li[@data-id='es']//span"
MULTILINGUAL_CANDIDATE_DROPDOWN = "(//*[@id='candidate_language_codes'])[last()]"
MULTILINGUAL_CANDIDATE_LANGUAGE_DROPDOWN = "(//*[@data-testid='btn_show_menu']//*[contains(text(),'{}')])[last()]"
MULTILINGUAL_SELECT_LANGUAGE_OPTIONS = "//*[@id='candidate_language_codes']//*[contains(text(),'{}')]//preceding-sibling::span//span[contains(@class,'el-checkbox__inner')]"
MULTILINGUAL_SAVE_BUTTON = "//*[contains(@class,'el-button el-button--primary')]//*[contains(text(),'Save')]"
MULTILINGUAL_CANDIDATE_SEARCH_INPUT_BUTTON = "//*[@id='candidate_language_codes']//*[contains(@placeholder,'Search Languages')]"
MULTILINGUAL_CANDIDATE_SELECT_ALL_OPTION = "(//*[contains(@class,'el-checkbox__label') and contains(text(),'Select all')])[last()]"

# SCHEDULING
SCHEDULING_LABEL = "//strong[contains(text(),'Scheduling')]"
ADVANCED_SCHEDULING_SETTING = "//*[contains(@id, 'advanced_itv_settings_on')]//following-sibling::span"
NEW_SCHEDULING_UI_TOGGLE = "//label[contains(@for, 'new_scheduling_ui_on')]"
ADVANCED_INTERVIEW_TOGGLE = "//label[contains(@for, 'advanced_itv_settings_on')]"
ALLOW_FOR_PRIVATE_INTERVIEW_CALENDER_EVENT_TOOGLE = "//label[contains(@for,'private_itv_calendar_events_on')]"
PREP_TOGGLE = "//label[contains(@for, 'id_interview_prep_on')]"
ROOM_BOOKING_TOGGLE = "//label[contains(@for, 'id_room_booking_on')]"
LOCATION_CALENDAR_NAME = "//span[normalize-space()='Calendar Name:']//following-sibling::strong"
VIRTUAL_TECHNOLOGY_PROVIDER_DROPDOWN = "id:id_virtual_technology"
WEBEX_USER_NAME_TEXTBOX = "id:id_web_ex_user_name"
WEBEX_PASSWORD_TEXTBOX = "id:id_web_ex_password"
WEBEX_SITE_NAME_TEXTBOX = "id:id_web_ex_site_name"
INTERVIEW_TYPE_BUTTON = "//*[contains(@class, 'is-align-middle')]//*[contains(@data-testid, 'btn_show_menu')]//*[contains(@class, 'el-icon-arrow-down')]"
INTERVIEW_TYPE_SELECT_ALL_LOCATOR = "//*[contains(@class, 'el-popover el-popper popper-none-padding')]//span[normalize-space()='Select all']//preceding-sibling::span//span"
INTERVIEW_TYPE = "//*[contains(@title, '{}')]//parent::*//preceding-sibling::*//span[contains(@class, 'el-checkbox__inner')]"
OLIVIA_ASSIST_IMAGE_LOCATOR = "//div[@data-testid='assist_header_title']//img"
OLIVIA_ASSIST_TITLE_LOCATOR = "//div[@data-testid='assist_header_title']//span[contains(text(),'Olivia')]"
ALLOW_USER_CHOOSE_INTERVIEW_TIME_TOOGLE = "//input[contains(@id, 'user_can_pick_time')]//following-sibling::span"
ADD_TYPE_BUTTON = "//*[contains(@id, 'interview_types_custom')]"
MANAGE_COMPANY_WIDE_SCHEDULING_TIMLINES_TOOGLE = "//label[contains(@for,'sched_timeline_on')]"
CANDIDATE_TIMEZONE_METHOD_DROPDOWN = "//select[contains(@id,'id_candidate_timezone_method')]"
CANDIDATE_TIMEZONE_METHOD_DROPDOWN_OPTIONS = "//select[contains(@id,'id_candidate_timezone_method')]/option[contains(text(),'{}')]"
DO_NOT_UPDATE_SCHEDULING_TIMEZONE_BASED_ON_CANDIDATE_TOGGLE = "//label[contains(@for,'sched_not_detect_tz_via_ip')]"
ADD_LOCATION_CALENDAR_BUTTON = "//button[@id='add_location_calendar']"
CALENDAR_NAME_TEXTBOX = "//div[contains(@class,'content')]//label[contains(text(),'Calendar Name')]//following-sibling::input"
MESSAGING_TEXTBOX = "//div[contains(@class,'content')]//input[contains(@placeholder,'Enter Messaging Label')]"
CALENDAR_ID_TEXTBOX = "//div[contains(@class,'content')]//input[contains(@placeholder,'Enter Calendar ID')]"
INTERVIEW_PREP_TOGGLE = "//*[@id='interview_prep_on']//following-sibling::span"
OLIVIA_RECORDED_INTERVIEW_TOGGLE = "//label[contains(@for,'olivia_recorded_interviews_on')]"
OLIVIA_RECORDED_INTERVIEW_DROPDOWN = "//*[contains(@id , 'expire_recorded_itv_requests')]"
OLIVIA_RECORDED_INTERVIEW_DROPDOWN_OPTIONS = "//*[contains(@class, 'el-input--suffix is-focus')]//following-sibling::div//li[contains(@class, 'el-select-dropdown__item')]//span[normalize-space()='{}']"

# SCHEDULING / ADD INTERVIEW TYPE
ADD_INTERVIEW_TYPE_EDIT_ICON = "//span[normalize-space()='{}']//parent::div//parent::div//parent::div//child::i[contains(@class,'icon-edit')]"
ADD_INTERVIEW_TYPE_DELETE_BUTTON = "//button//span[contains(text(),'Delete')]"
ADD_INTERVIEW_TYPE_DELETE_CONFIRM_BUTTON = "//div[contains(@class,'ol-confirm')]//button[contains(@class,'--danger')]//*[contains(text(), 'Delete')]"

# ADD INTERVIEW TYPE FORM
INTERVIEW_NAME_TEXTBOX = "//*[contains(@placeholder, 'Enter Interview Name')]"
ADD_INTERVIEW_TYPE_DROPDOWN = "//*[contains(@placeholder, 'Select Interview Type')]"
INTERVIEW_TYPE_OPTION = "//*[contains(@class, 'el-popper no-arrow')]//li[contains(@class, 'el-select-dropdown__item')]//*[normalize-space()='{}']"
API_ID_TEXTBOX = "//*[contains(@placeholder, 'Enter API ID')]"
ADD_BUTTON = "//span[normalize-space()='Add Interview Type']//ancestor::div[contains(@role, 'dialog')]//button[contains(@class, 'el-button--primary')]"

# ACCOUNT OVERVIEW
BASIC_USER_ACCESS = "//*[contains(@id, 'basic_user_access')]"
BASIC_USER_ACCESS_TYPE_OPTION = "(//*[contains(@class,'dropdown__list')])[last()]//*[normalize-space(text())='{}']"
CLIENT_SETUP_CAMPUS_MULTI_BRANDING_TOGGLE = "//*[contains(@id,'multi_branding_on')]//following-sibling::span"

# CAMPUS
CLIENT_SETUP_CAMPUS_TAB = "//div[contains(@class, 'el-scrollbar')]//strong[contains(text(), 'Campus')]"
CLIENT_SETUP_CAMPUS_TOGGLE_ON_OFF = "//*[contains(@id, 'campus_on')]//following-sibling::span[contains(@class, 'el-switch__core')]"
CLIENT_SETUP_CAMPUS_SAVE_BUTTON = "//*[contains(@class, 'client-setting-form__footer')]//span[contains(text(), 'Save')]"
CLIENT_SETUP_CAMPUS_APPROVALS_TOGGLE_ON_OFF = "//*[contains(@id, 'campus_approval_on')]//following-sibling::span[contains(@class, 'el-switch__core')]"

# MENU
CLIENT_SETUP_MENU_SPAN = "//*[contains(@data-testid, 'toolbar_btn_back')]//span[contains(text(), 'Menu')]"
CLIENT_SETUP_SETTING_ICON = "//*[@data-testid='menu_btn_settings']"
