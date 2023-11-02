# BASE PAGE / User
USER_TEST_DELETE_LOCATOR = "//*[starts-with(normalize-space(text()), 'User')  and contains(text(),'Test')]//ancestor::tr"
USER_TEST_DELETE_LOCATOR_FIRST = "//*[starts-with(normalize-space(text()), 'Auto')  and contains(text(),'Test')]//ancestor::tr"
USER_TEST_DELETE_LOCATOR_LAST = "(//*[starts-with(normalize-space(text()), 'Auto')  and contains(text(),'Test')]//ancestor::tr)[last()]"
USER_TEST_DELETE_LOCATOR = "//*[starts-with(normalize-space(text()), 'User')  and contains(text(),'Test')]//ancestor::tr"
USER_CHANGES_SAVE_TOASTED_MESSAGE = "//*[contains(@class, 'toasted') and contains(normalize-space(), 'Your change has been saved.')]"

# BASE PAGE
USERS_LIST_TABLE = "//*[contains(@class,'el-table__body-wrapper')]"
ADD_NEW_USER_BUTTON = "//button[@data-testid='users_btn_create']"
SEARCH_USER_TEXT_BOX = "//div[@data-testid='users_input_search']//input"
USER_ECLIPSE_ICON = "//button[@data-testid='users_btn_dropdown_actions']//i"
USERS_NAVIGATION_ROLE = "//div[contains(@class,'nav-text') and contains(text(),'{}')]"
USER_LIST = "//div[contains(@class,'el-table el-table--fit')]"
USER_CELL_HEADER_VALUE = "//div[@class='cell' and contains(text(),'{}')]"
USER_CELL_VALUE = "//div[@class='cell']//*[contains(text(),'{}')]"
USER_LIST_EDIT_TABLE_BUTTON = "//div[@data-testid='users_btn_table_setting']//button"
USER_LIST_EXPORT_BUTTON = "//button[@data-testid='user_export_btn_download']//span"
USER_LIST_EDIT_GROUP_REQ_PERM = "//button[@data-testid='users_btn_edit_requisition_perm']//span"
USER_LIST_EDIT_AVAILABILITY_BUTTON = "//div[@data-testid='users_btn_edit_availability']"
USER_LIST_EDIT_BUTTON = "//p[contains(@class, 'text-overflow') and contains(text(), '{}')]/ancestor::tr/td[count(//thead/tr/th) -  count(//div[contains(text(),'{}')]/parent::th/following-sibling::th)]//button"
POPUP_FORM = "//h3[contains(text(), '{}')]/ancestor::div[contains(@class, 'el-drawer rtl')]"
ICON_EDIT_OIT_USER = "//tr[contains(@class, 'el-table__row')]//p[contains(text(), '{}')]//following::td//i[contains(@class, 'pointer')]"
EDIT_OIT_USER_BUTTON = "//div[contains(@data-testid, 'users_btn_edit_availability')]"
EMAIL_USER_NAME = "//div[contains(@class, 'text-overflow')]//p[contains(text(), '{}')]//following-sibling::p"
EMPTY_USER_TITLE = "//div[contains(@class,'empty-title')]"
ALL_USER_NAME = "//tr//div[contains(@class,'text-overflow')]//p[1]"

# BASE PAGE / Table Settings popup
USER_TABLE_SETTINGS_FOR_YOU_TAB = "//div[@id='tab-for_you']"
USER_TABLE_SETTINGS_FOR_ALL_TAB = "//div[@id='tab-for_all']"
USER_TABLE_SETTINGS_VISIBILITY_ICON = "//i[contains(@class,'icon-visibility')]"
USER_TABLE_SETTINGS_VISIBILITY_ICON_ACTION = "//div[@class='el-tabs__content']//div[contains(text(),'{}')]//i[contains(@class,'icon-visibility')]"
USER_TABLE_SETTINGS_SAVE_BUTTON = "(//button[contains(@class,'el-button el-button--primary')])[last()]"

# BASE PAGE / Table Settings popup / Confirm Changes popup
USER_TABLE_SETTINGS_CONFIRM_CHANGES_BUTTON = "//button[@class='el-button el-button--default el-button--primary']"

# BASE PAGE / Job and Location Permissions form
JOB_LOCATION_PERM_X_BUTTON = "(//button[@class='el-drawer__close-btn']//i)[last()]"
JOB_LOCATION_PERM_ADD_GROUP_BUTTON = "//button[@data-testid='add_new_group_btn']//span"
JOB_LOCATION_PERM_GROUP_SEARCH_TEXT_BOX = "//input[@placeholder='Find a location name or address']"
LOCATION_PERM_GROUPS_EDIT_BUTTON = "//*[@data-testid='user_job_loc_btn_toggle_edit']"
LOCATION_PERM_GROUPS_SELECT_ALL_CHECKBOX = "//*[@data-testid='user_job_loc_select_all_checkbox']//span"
LOCATION_PERM_GROUPS_SAVE_BUTTON = "//*[@data-testid='user_job_loc_btn_save_edit']"

# BASE PAGE / Export User List popup
EXPORT_USER_LIST_EXPORT_BUTTON = "//button[@data-testid='user_export_btn_submit']//span"

# BASE PAGE / User eclipse menu
USER_ECLIPSE_MENU_DEACTIVATE_BUTTON = "//*[@data-testid='users_btn_deactivate']//i"
USER_ECLIPSE_MENU_ACTIVATE_BUTTON = "//*[@data-testid='users_btn_activate']//i"
USER_ECLIPSE_MENU_EDIT_BUTTON = "//*[@data-testid='users_btn_edit_detail']//i"

# BASE PAGE / User eclipse menu / Activate User confirm popup
ACTIVATE_USER_ACTIVATE_BUTTON = "//*[contains(@class,'ol-confirm')]//*[contains(@class,'el-button--primary')]"

# BASE PAGE / User eclipse menu / Deactivate User confirm popup
DEACTIVATE_USER_DEACTIVATE_BUTTON = "//*[contains(@class,'ol-confirm')]//*[contains(@class,'button--danger')]"
DEACTIVATE_USER_CANCEL_BUTTON = "//*[contains(@class,'ol-confirm')]//*[contains(@class,'button--default')]//*[contains(text(),'Cancel')]"

# BASE PAGE / User eclipse menu / User details edit form
USER_DETAIL_EDIT_FORM_FNAME_TEXT_BOX = "//input[@data-testid='user_detail_input_user_fname']"
USER_DETAIL_EDIT_FORM_LNAME_TEXT_BOX = "//input[@data-testid='user_detail_input_user_lname']"
USER_DETAIL_EDIT_FORM_JOB_TEXT_BOX = "//input[@data-testid='user_detail_input_job_title']"
USER_DETAIL_EDIT_FORM_MOBILE_TEXT_BOX = "//div[@data-testid='user_detail_input_mobile_phone_number']//input"
USER_DETAIL_EDIT_FORM_EMAIL_TEXT_BOX = "//input[@data-testid='user_detail_input_user_email']"
USER_DETAIL_EDIT_FORM_EMPLOYEE_ID_TEXT_BOX = "//input[@data-testid='user_detail_input_employee_id']"
USER_DETAIL_EDIT_FORM_COUNTRY_DROPDOWN = "//div[@data-testid='user_detail_select_country_selection']"
USER_DETAIL_EDIT_FORM_COUNTRY_DROPDOWN_VALUE_SELECTED = "//li[contains(@class,'el-select-dropdown__item selected')]//span"
USER_DETAIL_EDIT_FORM_USER_ROLE_DROPDOWN = "//div[@data-testid='user_detail_select_role_selection']"
USER_DETAIL_EDIT_FORM_USER_ROLE_DROPDOWN_VALUE_SELECTED = "(//li[contains(@class,'el-select-dropdown__item selected')])[last()]"
USER_DETAIL_EDIT_FORM_SAVE_BUTTON = "//button[@data-testid='detail_user_btn_validate']//span[contains(text(),'Save')]"
USER_DETAIL_EDIT_FORM_CANCEL_BUTTON = "//button[@data-testid='detail_user_btn_validate']//span[contains(text(),'Cancel')]"
USER_DETAIL_EDIT_FORM_TIMEZONE_DROPDOWN = "//div[contains(@data-testid, 'user_detail_select_timezone')]//input"
USER_DETAIL_EDIT_FORM_TIMEZONE_DROPDOWN_OPTIONS = "//div[contains(@class, 'el-scrollbar__wrap')]/ul[contains(@class, 'el-select-dropdown__list')]//li[contains(text(), '{}')]"
USER_DETAIL_EDIT_FORM_TIMEZONE_SEARCH_TIMEZONE_TEXTBOX = "//input[contains(@placeholder, 'Search timezone')]"

# BASE PAGE / User eclipse menu / User detail edit form / Update user details popup
UPDATE_USER_DETAILS_POPUP_CONFIRM_BUTTON = "(//button[@data-testid='detail_user_btn_confirm'])[last()]"
UPDATE_USER_DETAILS_POPUP_CANCEL_BUTTON = "(//button[@data-testid='detail_user_btn_cancel'])[last()]"

# BASE PAGE / User eclipse menu / User detail edit form / Unsaved Changes popup
UNSAVED_CHANGES_POPUP_DISCARD_BUTTON = "(//button[@data-testid='submit_confirm_btn'])[last()]"
UNSAVED_CHANGES_POPUP_KEEP_BUTTON = "(//button[@data-testid='detail_user_btn_confirm'])[last()]"

# BASE PAGE / User eclipse menu / Edit OIT
CLEAR_ALL_AVAILABILITY_MODAL_CLEAR_BUTTON = "//button[contains(@data-testid, 'availability_btn_clear_all')]"
EDIT_OIT_PATTERN_BLOCK_OIT = "(//div[contains(@class,'fc-event-main')])[{}]"
EDIT_OIT_SCHEDULE_TYPE_BUTTON = "//div[contains(@class,'scheduleType')]"
EDIT_OIT_PATTERN_SCHEDULE_TYPE_RADIO = "//div[contains(@aria-label,'{}')]//span[contains(@class,'el-radio__input')]"

# BASE PAGE / Add new user form
ADD_NEW_USER_CROP_AVATAR = "//input[@type='file']"
ADD_NEW_USER_CROP_AVATAR_CONFIRM_BUTTON = "(//button[@class='el-button el-button--primary'])[last()]"
ADD_NEW_USER_FNAME_TEXT_BOX = "//input[@data-testid='user_detail_input_user_fname']"
ADD_NEW_USER_LNAME_TEXT_BOX = "//input[@data-testid='user_detail_input_user_lname']"
ADD_NEW_USER_JOB_TITLE_TEXT_BOX = "//input[@data-testid='user_detail_input_job_title']"
ADD_NEW_USER_PRE_PHONE_CODE_DROPDOWN = "//div[@data-testid='user_detail_input_mobile_phone_number']//div[@class='vti__dropdown']"
ADD_NEW_USER_PRE_PHONE_CODE_DROPDOWN_LIST = "//ul[@class='vti__dropdown-list below']"
ADD_NEW_USER_EMAIL_TEXT_BOX = "//input[@data-testid='user_detail_input_user_email']"
ADD_NEW_USER_COUNTRY_DROPDOWN = "//div[@data-testid='user_detail_select_country_selection']"
ADD_NEW_USER_COUNTRY_DROPDOWN_VALUE = "(//div[@class='el-scrollbar']//li//span[contains(text(),'{}')])[last()]"
ADD_NEW_USER_ROLE_DROPDOWN = "//div[@data-testid='user_detail_select_role_selection']"
ADD_NEW_USER_ROLE_DROPDOWN_VALUE = "(//div[@class='el-scrollbar']//li[normalize-space(text())='{}'])[last()]"
ADD_NEW_USER_ADD_BUTTON = "//button[@data-testid='detail_user_btn_validate']//span[contains(text(),'Add User')]"
ADD_NEW_USER_CANCEL_BUTTON = "//button[@data-testid='detail_user_btn_validate']//span[contains(text(),'Cancel')]"
ADD_NEW_USER_X_BUTTON = "(//button[@aria-label='close drawer'])[last()]"
ADD_NEW_USER_ROLE_INPUT = "//div[contains(@data-testid, 'user_detail_select_role_selection')]//input"

# BASE PAGE / Availability time select widget
AVAILABILITY_TIME_SELECT_EMPTY_TIME_GRID = "//td[contains(@class,'fc-timegrid-slot-lane')]"
AVAILABILITY_TIME_SELECT_EXISTED_TIME_GRID = "//div[contains(@class,'fc-event-main')]"
AVAILABILITY_TIME_SELECT_SAVE_BUTTON = "//button[@data-testid='availability_btn_save']"
AVAILABILITY_PATTERN_COLUMN = "//td[contains(@class,'fc-day')][{}]//div[contains(@class,'fc-timegrid-col-frame')]"

# BASE PAGE / Availability time select widget / Available time edit popup
AVAILABLE_TIME_POPUP_START_TIME = "(//div[contains(@data-testid,'user_available_time_select_time_from')])[last()]"
AVAILABLE_TIME_POPUP_END_TIME = "(//div[contains(@data-testid,'user_available_time_select_time_end')])[last()]"
AVAILABLE_TIME_POPUP_DELETE_TIME_BUTTON = "(//button[contains(@data-testid,'user_available_time_btn_delete_time')])[last()]"
AVAILABLE_TIME_POPUP_CLEAR_ALL_BUTTON = "//button[contains(@data-testid,'availability_btn_clear_all')]"
AVAILABLE_TIME_POPUP_X_BUTTON = "(//*[@id='el-drawer__title'])[last()]//button[contains(@class,'close-btn')]//i"
AVAILABLE_TIME_POPUP_TIME_VALUE = "(//*[contains(@class,'dropdown el-popper') and not(contains(@style,'display: none'))])//span[contains(text(),'{}')]"

# BASE PAGE / Availability time select widget / Clear All Availability popup
CLEAR_ALL_AVAILABILITY_POPUP_CLEAR_BUTTON = "//div[contains(@class,'ol-confirm')]//button[contains(@class,'el-button--primary')]"
CLEAR_ALL_AVAILABILITY_POPUP_CANCEL_BUTTON = "//div[contains(@class,'ol-confirm')]//button[contains(@class,'el-button--default')]"

# BASE PAGE / Availability time select widget / Confirm Changes popup
AVAILABILITY_CONFIRM_CHANGES_POPUP_YES_BUTTON = "//div[contains(@class,'ol-confirm')]//button[contains(@class,'el-button--primary')]"
AVAILABILITY_CONFIRM_CHANGES_POPUP_NO_BUTTON = "//div[contains(@class,'ol-confirm')]//button[contains(@class,'el-button--default')]"

# BASE PAGE / Roles and Permissions page
ROLES_AND_PERMISSION_LIST = "//main/div//div[2]"
ROLES_ECLIPSE_ICON = "//*[normalize-space(text())='{}']/parent::*/parent::*//button[contains(@data-testid, 'users_roles_btn_menu')]//i"
ADD_NEW_USER_ROLE_BUTTON = "//button[@data-testid='users_roles_btn_add_new_role']"
USER_ROLES_DEFAULT_LABEL = "//span[@data-testid='users_roles_popover_default_role']"
USER_ROLES_DEFAULT_TOOLTIP = "//div[contains(@role,'tooltip') and contains(@id,'el-popover')]/span"
USER_ROLES_NAME_LABEL = "//main[contains(@class,'el-main')]//*[contains(text(),'{}')]"
USER_ROLES_NAME_LIMITED_USER_LABEL = "//main[contains(@class, 'el-main')]//div[contains(text(), 'Limited User')]"
USER_ASSIGNED_LABEL = "//main[contains(@class, 'el-main')]//div[contains(text(),'{}')]/following-sibling::p"

# BASE PAGE / Roles and Permissions eclipse menu
ROLES_ECLIPSE_MENU_VIEW_BUTTON = "(//li[contains(@data-testid, 'users_roles_btn_view')])[last()]"
ROLES_ECLIPSE_MENU_EDIT_BUTTON = "(//li[contains(@data-testid, 'users_roles_btn_edit')])[last()]"
ROLES_ECLIPSE_MENU_DUPLICATE_BUTTON = "(//li[contains(@data-testid, 'users_roles_btn_duplicate')])[last()]"
ROLES_ECLIPSE_MENU_DELETE_BUTTON = "(//li[contains(@data-testid, 'users_roles_btn_delete')])[last()]"

# BASE PAGE / Edit roles and permission PAGE / System Access Parameters section
CEM_LOGIN_AND_INBOX_ACCESS_TOGGLE = "//*[@data-testid='user_role_cbx_system_access_param_cem_inbox_access_on']"

# BASE PAGE / Edit roles and permission page
USER_ROLE_ATTRIBUTE_PARENT_ATTR_PERMISSION_TEXT = "//div[normalize-space()='{}']"
USER_ROLE_ATTRIBUTE_CHILD_ATTR_PERMISSION_SELECTED_TEXT = "//div[normalize-space()='{}']//following-sibling::div//span[contains(@class,'checked')]//following-sibling::span[contains(@class,'label')]"
USER_ROLE_PERMISSION_SELECT = "//div[normalize-space()='{}']//following-sibling::*[contains(@data-testid,'user_role_select_perm')]"
FULL_ACCESS_OPTION = "(//div[contains(@class, 'dropdown__item-name')][normalize-space()='Full Access'])[last()]"
VIEW_ACCESS_OPTION = "(//div[contains(@class, 'dropdown__item-name')][normalize-space()='View Access'])[last()]"
NO_ACCESS_OPTION = "(//div[contains(@class, 'dropdown__item-name')][normalize-space()='No Access'])[last()]"
USER_ROLE_CANCEL_BUTTON = "//button[@data-testid='user_role_btn_cancel']"
USER_ROLE_SAVE_BUTTON = "//button[@data-testid='user_role_btn_save']"
SET_AS_DEFAULT_ROLE_CHECK_BOX = "//label[@data-testid='user_role_cbx_default_role']//span"
SET_AS_DEFAULT_ROLE_CONFIRM_BUTTON = "//button[@type='button']//span[contains(text(),'Set as Default Role')]"
SET_AS_DEFAULT_ROLE_CANCEL_BUTTON = "//div[contains(@aria-label, 'Set as Default Role')]//span[contains(text(), 'Cancel')]"
SET_AS_DEFAULT_ROLE_CONTENT_TEXT = "//div[contains(@class, 'el-message-box')]/p"
EDIT_USER_ROLE_PERMISSION_NAME_TEXTBOX = "//input[@data-testid='user_role_input_name']"
EDIT_USER_ROLE_PERMISSION_ICON_EDIT_NAME = "//i[@class='icon icon-edit']"
EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_DROPDOWN = "//div[@data-testid='user_role_select_legacy_role']"
EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_VALUE = "(//div[contains(@class, 'el-scrollbar')]//li//span[contains(text(),'{}')])[last()]"
EDIT_USER_ROLE_PERMISSION_LEGACY_ROLE_SELECTED_VALUE = "//span[contains(text(),'{}')]/parent::div/parent::li//i[contains(@class, 'icon-check')]"
EDIT_USER_ROLE_PERMISSION_EXTERNAL_ID_TEXT_BOX = "//input[@data-testid='user_role_input_external_id']"
PERMISSION_SELECTED_VALUE = "(//div[contains(text(),'{}')]/parent::div/parent::li//i[contains(@class, 'icon-check')])[last()]"
ICON_CARET_PARENT_FEATURE = "//div[contains(text(), '{}')]//i[contains(@class, 'icon-caret')]"
LIST_FULL_ACCESS_CHECKBOX = "//div[contains(text(), '{}')]//parent::div//parent::div//span[contains(text(), 'Full Access')]//parent::label//input"
LIST_VIEW_ACCESS_CHECKBOX = "//div[contains(text(), '{}')]//parent::div//parent::div//span[contains(text(), 'View Access')]//parent::label//input"
LIST_NO_ACCESS_CHECKBOX = "//div[contains(text(), '{}')]//parent::div//parent::div//span[contains(text(), 'No Access')]//parent::label//input"
EDIT_USER_ROLE_PERMISSION_ATTR_SELECTED_VALUE = "(//li[contains(@class,'dropdown') and contains(@class,'selected')])[last()]//div[contains(@class,'item-name')]"
USER_ROLE_FEATURE_TEXT = "//div[normalize-space()='Permission Summary']/following-sibling::div//div[normalize-space()='{}']"
EDIT_USER_ROLE_PERMISSION_STUDENT_EXPERIENCE_MANAGER_TOGGLE = "//div[contains(@data-testid, 'user_role_cbx_system_access_param_student_experience_manager_on')]//span"

# BASE PAGE / Add new user role modal
ADD_NEW_USER_ROLE_NAME_TEXT_BOX = "//input[@data-testid='user_role_input_name']"
ADD_NEW_USER_LEGACY_ROLE_DROPDOWN = "//div[@data-testid='user_role_select_legacy_role']"
ADD_NEW_USER_LEGACY_ROLE_VALUE = "(//div[contains(@class, 'el-scrollbar')]//li//span[contains(text(),'{}')])[last()]"
ADD_NEW_USER_LEGACY_ROLE_FIRST_VALUE = "(//*[contains(@class,'select-dropdown__list')])[last()]//*"
ADD_NEW_USER_ROLE_EXTERNAL_ID_TEXT_BOX = "//input[@data-testid='user_role_input_external_id']"
ADD_NEW_USER_ROLE_SAVE_BUTTON = "//button[@data-testid='create_user_role_btn_save']"
ADD_NEW_USER_ROLE_CANCEL_BUTTON = "//button[@data-testid='create_user_role_btn_cancel']"
ADD_NEW_USER_ROLE_INFO_TEXT = "//div[contains(.,'Create New User Role')]//i[@class='icon-info']/following-sibling::span"
ADD_NEW_USER_ROLE_ERROR_TEXT = "//div[contains(@class,'el-form-item__error')]//span"
ADD_NEW_USER_ROLE_USER_IMPERSONATION_TOGGLE = "//*[contains(@data-testid, 'user_role_cbx_system_access_param_user_impersonation_on')]//span"
ADD_NEW_USER_ROLE_USER_IMPERSONATION_DROPDOWN = "//*[contains(@data-testid, 'user_role_select_scope_of_param_user_impersonation_on')]//i[contains(@class, 'el-icon-arrow-up')]"
ADD_NEW_USER_ROLE_USER_IMPERSONATION_OPTIONS = "//li[contains(@class, 'el-select-dropdown__item')]//span[contains(text(), '{}')]"
ADD_NEW_USER_ROLE_USER_IMPERSONATION_INPUT = "//div[contains(@data-testid, 'user_role_select_scope_of_param_user_impersonation_on')]//input"

# BASE PAGE / Delete user role modal
ROLES_ECLIPSE_MENU_DELETE_CONFIRM_BUTTON = "//div[@aria-label='Delete User Role']//button//span[contains(text(),'Delete')]"
ROLES_ECLIPSE_MENU_DELETE_CANCEL_BUTTON = "//div[contains(@aria-label, 'Delete User Role')]//span[contains(text(), 'Cancel')]"
DELETE_USER_ROLE_CONTENT_TEXT = "//div[contains(@class, 'el-message-box')]//p"

# BASE PAGE / View roles and permission page
VIEW_PAGE_USER_ROLES_TITLE = "//header[@id='el-drawer__title']//span[contains(text(),'{}')]"
VIEW_PAGE_USER_ROLES_EXTERNAL_ID_VALUE = "//section[contains(@class, 'el-drawer__body')]//b[text()='External ID:']//parent::div"
VIEW_PAGE_USER_ROLES_ACCESS_ICON = "//*[contains(text(),'Permission Summary')]//following-sibling::*//div[contains(@class,'font-weight') and normalize-space()='{}']//following-sibling::div[{}]//i[contains(@class, 'icon-check-circle-outlined')]"  #first parameter for "product name", second parameter is index(full access=1, view access=2, no access=3)
VIEW_PAGE_USER_ROLES_X_BUTTON = "(//i[contains(@class,'el-icon-close')])[last()]"
VIEW_PAGE_USER_ROLES_ATTRIBUTE_NAME = "//div[contains(@class, 'el-card__body')]//div[normalize-space()='{}']"
VIEW_PAGE_USER_ROLES_BY_LABEL = "//div[contains(@class, 'font-weight-primary') and contains(text(), '{}')]/parent::div//span[contains(@data-testid, 'users_roles_popover_text_perm')]"
VIEW_PAGE_USER_ROLES_SYSTEM_ACCESS_PARAMETERS_ON = "//*[contains(text(),'{}')]//parent::*//i[contains(@class,'check')]"
VIEW_PAGE_USER_ROLES_SYSTEM_ACCESS_PARAMETERS_OFF = "//*[contains(text(),'{}')]//parent::*//i[contains(@class,'remove')]"

# BASE PAGE / Requisition Based Permissions form
REQ_BASED_PERM_X_BUTTON = "(//button[@class='el-drawer__close-btn']//i)[last()]"
REQ_BASED_PERM_SHOW_REQ_BUTTON = "//*[contains(@data-testid, 'requisition_perm_btn_select_requisition_type')]"
REQ_BASED_PERM_DIALOG = "//*[contains(@data-testid, 'requisition_permission')]"
REQ_BASED_PERM_ASSIGN_JOB_REQ_BUTTON = "//button[normalize-space() ='Assign job requisitions']"
REQ_BASED_PERM_SHOW_ALL_BUTTON = "//button[normalize-space() ='{}']"
REQ_BASED_PERM_JOB_SEARCH_MENU_BUTTON = "//span[normalize-space()='Job Search']/following::li[position()<=2]/span[normalize-space()='{}']/parent::li"
REQ_BASED_PERM_ATS_JOBS_MENU_BUTTON = "//span[normalize-space()='Job Search']/following::li[position()>=4]/span[normalize-space()='{}']/parent::li"
REQ_BASED_PERM_SAVE_BUTTON = "//*[contains(@data-testid, 'requisition_perm_btn_save')]"
REQ_BASED_PERM_CANCEL_BUTTON = "//*[contains(@data-testid, 'requisition_perm_btn_cancel')]"
REQ_BASED_PERM_CHECK_BOX = "//div[@class='el-table__fixed-body-wrapper']//span[contains(text(), '{}')]/ancestor::tr/td//span[contains(@class, 'el-checkbox__input')]"
REQ_BASED_PERM_CHECKED_BOX = "//div[@class='el-table__fixed-body-wrapper']//span[contains(text(), '{}')]/ancestor::tr/td//span[contains(@class, 'el-checkbox__input')]/span"
REQ_BASED_PERM_SEARCH_JOB_TEXT_BOX = "//input[contains(@placeholder, 'Search for job requisitions')]"
REQ_BASED_PERM_CHECK_BOX_BY_INDEX = "//div[@class='el-table__fixed-body-wrapper']//tr[{}]//span[contains(@class, 'el-checkbox__input')]"
REQ_BASED_PERM_TOTAL_CHECK_BOX = "//div[@class='el-table__fixed-body-wrapper']//tr//span[contains(@class, 'el-checkbox__input')]"
REQ_BASED_PERM_LINE_BY_INDEX = "//h3[normalize-space()='Requisition Based Permissions']/ancestor::header/following-sibling::section//div[contains(@class, 'el-table__body-wrapper')]//tr[{}]/td[2]"
REQ_BASED_PERM_JOBS_TABLE = "//*[@id='requisitions__table']//*[contains(@class, 'table__body-wrapper')]"
REQ_BASED_PERM_TOTAL_JOB = "//*[@data-testid ='requisition_perm_btn_select_requisition_type']/ancestor::*[contains(@class, 'drawer__body')]//span[contains(text(), 'of')]"
REQ_BASED_PERM_FIRST_JOB = "//*[contains(@data-testid, 'requisitions_modal_column_job_title_row')]"
REQ_BASED_PERM_SEARCH_TEXTBOX = "//*[contains(@data-testid, 'requisition_perm_input_modal_search')]//input"

# BASE PAGE / View roles and permission page / Analytics and Reporting page
VIEW_ANALYTICS_AND_REPORTING_CHECKED_SUB_FEATURES = "//div[@class= 'el-card__body']/div/div/div[normalize-space()= '{}']/parent::div/following-sibling::div/div/div/div[{}]//i[contains(@class,'icon-check2')]" #first parameter for "feature name", second parameter is index(full access=2, no access=3)
VIEW_ANALYTICS_AND_REPORTING_FEATURES = "//section[@class='el-drawer__body']/div/div/div[@class='el-card__body']/div[position()>1]"
VIEW_ANALYTICS_AND_REPORTING_CHECKED_FEATURES = "//section[@class='el-drawer__body']/div/div/div[@class='el-card__body']/div[position()>1]/div/div[{}]//i[contains(@class, 'icon-check-circle-outlined')]" # Parameter is index(full access=2, no access=3)
VIEW_ANALYTICS_AND_REPORTING_FALLBACK_BUTTON = "//button/i[contains(@class, 'icon-arrow-left')]"
VIEW_ANALYTICS_AND_REPORTING_FEATURE_NAME = "//div[contains(@class, 'el-card__body')]//div[normalize-space()='{}']"

# BASE PAGE / Edit roles and permission page / Analytics and Reporting page
EDIT_ANALYTICS_AND_REPORTING_CHECKED_FEATURES = "//div[@class= 'el-scrollbar__view']//span[contains(text(), '{}')]/parent::label/span[contains(@class , 'is-checked')]"
EDIT_ANALYTICS_AND_REPORTING_CHECKED_SUB_FEATURES = "//h4[normalize-space()='Permission Summary']/../following-sibling::div//div[normalize-space()='{}']/../following-sibling::div//span[contains(@class, 'is-checked')]/following-sibling::span[normalize-space()='{}']"
EDIT_ANALYTICS_AND_REPORTING_FEATURES = "//h4[normalize-space()='Permission Summary']/parent::div/following-sibling::div"
EDIT_ANALYTICS_AND_REPORTING_FEATURE_NAME = "//h4[normalize-space()='Permission Summary']/parent::div/following-sibling::div//div[contains(text(),'{}')]"
EDIT_ANALYTICS_AND_REPORTING_X_BUTTON = "(//i[contains(@class,'el-icon-close')])[last()]"
EDIT_ANALYTICS_AND_REPORTING_SEARCH_REPORT_TEXTBOX = "//div[contains(@data-testid, 'input_search_reports')]//input"
EDIT_ANALYTICS_AND_REPORTING_REPORT_NAME = "//div[contains(@class, 'el-scrollbar__view')]//div[contains(text(),'{}')]"