# BASE PAGE
OFFER_ADD_USER_BUTTON = "//i[@class='icon-plus']"
USER_NAME_IN_LIST = "//strong[@class='_lead_name' and contains(text(),'{}')]"
USERS_PAGE_SEARCH_USER_TEXT_BOX = "//input[@id='filter-input']"
USERS_PAGE_SEARCH_RESULT = "//div[@id='search-rs']/div"
LAST_USERS_NAME_IN_LIST = "//strong[@class='_lead_name']/em/following-sibling::em[contains(text(),'{}')]"
USER_NAME_STRONG_LOCATOR = "//strong[contains(@class,'_lead_name')]"
LIST_USER_NAME_STRONG_LOCATOR = "//strong[contains(@class,'_lead_name') and contains(text(),'{}')]"

# BASE PAGE / User Permissions section
EDIT_REQUISITIONS_BUTTON = "//button[@id='edit-requisitions' and contains(text(),'View Permissions')]"

# BASE PAGE / User Permissions section / Requisition Based Permissions Panel
REQUISITION_USER_NAME = "//div[@id='requisition-panel']//div[@class='panel-title']//h4"
REQUISITIONS_ASSIGNED_TEXT = "//div[@class='job-requisition-option']//h4"
REQUISITIONS_LIST_JOB = "//div[@class='job-requisition-table']"
REQUISITION_RESULT_NUMBER = "//div[@class='job-requisition-option']//span[@class='text-lighter']"
JOB_REQUISITIONS_SEARCH_TEXT_BOX = "//input[@placeholder='Search for job requisitions']"
JOB_REQUISITION_ID_TEXT = "//div[@id='job-requisition-table-scroll']//div[contains(@class,'cell-id')]"
JOB_REQUISITION_UNSELECTED_CHECKBOX = "//div[contains(@class,'cell-id')]//input[@type='checkbox' and @value='false']//following-sibling::span"
JOB_REQUISITION_SELECTED_CHECKBOX = "//div[contains(@class,'cell-id')]//input[@type='checkbox' and @value='true']//following-sibling::span"
JOB_REQUISITION_CHECKBOX = "//span[@class='shadow' and contains(text(),'{}')]//parent::div[contains(@class,'cell-id')]//input[@type='checkbox']//following-sibling::span"
JOB_REQUISITION_TITLE_TEXT = "//div[@id='job-requisition-table-scroll']//div[contains(@class,'cell-title')]"
JOB_CATEGORY_TEXT = "//div[@id='job-requisition-table-scroll']//div[contains(@class,'cell-category')]"
JOB_CITY_TEXT = "//div[@id='job-requisition-table-scroll']//div[contains(@class,'cell-city')]"
JOB_STATE_TEXT = "//div[@id='job-requisition-table-scroll']//div[contains(@class,'cell-state')]"
JOB_EMPLOYMENT_TYPE_TEXT = "//div[@id='job-requisition-table-scroll']//div[contains(@class,'cell-employment-type')]"
JOB_REQUISITION_ASSIGNED_DROPDOWN = "//div[@class='form-group m-0 p-relative']//span[@class='fa fa-angle-down']"
REQUISITIONS_SAVE_BUTTON = "//button[@class='btn btn-primary']"
REQUISITIONS_CANCEL_BUTTON = "//div[@class='detail-footer active']//button[@class='btn btn-default']"

# BASE PAGE / User type popup
USER_TYPE_VALUE = "//div[@class='modal-body']//strong[contains(text(),'{}')]"
CONFIRM_USER_TYPE_BUTTON = "//button[@id='select-package']"

# BASE PAGE / Input user info form
USER_ROLE_DROPDOWN = "//div[@id='div_id_role']//select[@class='ai-select selectpicker form-control']"
PRODUCT_ACCESS_DROPDOWN = "//*[contains(@class,'ai-input product-access')]"
PRODUCT_ACCESS_OPTION = "//input[contains(@data-name,'{}')]//ancestor::div[contains(@class,'custom-checkbox')]"
USER_FIRST_NAME_TEXT_BOX = "//input[@id='id_fname']"
USER_LAST_NAME_TEXT_BOX = "//input[@id='id_lname']"
USER_JOB_TEXT_BOX = "//input[@id='id_job_title']"
USER_PHONE_TEXT_BOX = "//input[@data-bv-field='phone_number']"
USER_EMAIL_TEXT_BOX = "//input[@data-bv-field='email']"
SAVE_NEW_USER_BUTTON = "//button[@class='btn btn-primary btn-save pull-right']"
DELETE_USER_BUTTON = "id:btnRemove"
OK_BUTTON_POPUP = "(//button[contains(@class,'ok-btn')])[last()]"
USER_TIMEZONE_DROPDOWN = "//select[@id='id_timezone']"
USER_INFO_LOCATOR = "//div[@id='contact_info']"

# BASE PAGE / Group and Location Permissions Widget
UNASSIGNED_LOCATION_OPTION = "//label[@class='icon unassigned dropup']"
SELECT_ALL_OPTION = "//div[@class='list-item all-checker']//div//label"
SELECT_ALL_OPTION_VALUE = "//div[@class='list-item all-checker']//div//label//input"
SAVE_VIEW_PERMISSIONS_BUTTON = "//div[@class='detail-footer active']//button[@class='btn btn-primary']"
EDIT_GROUP_TO_VIEW_ICON = "//span[@class='icon icon-edit']"
GROUP_LOCATION_PERMISSION_SEARCH_BUTTON = "//*[contains(@placeholder,'{}')]"
GROUP_LOCATION_PERMISSION_UNASSIGNED_LOCATION_CHECKBOX = "//*[contains(@aria-label,'Unassigned')]//*[contains(@class,'el-checkbox__inner')]"
GROUP_LOCATION_PERMISSION_SAVE_BUTTON = "//*[@data-testid='user_job_loc_btn_save_edit']"

#Users Interview Instructions
DEFAULT_INTERVIEW_INSTRUCTION_TAB = "//div[contains(@class,'interview_instructions ')]//span[contains(text(),'{}')]"
TEXT_INTERVIEW_INSTRUCTION_TEXTBOX = "(//div[contains(@class,'form-control ai-input instructions-text')])[{}]"

#OPEN TIME INTERVIEW
EDIT_AVAILABILITY_BUTTON = "//button[contains(@class,'btn-native-cal wrap-normal') and contains(text(),'Edit Availability')]"
CLEAR_ALL_AVAILABILITY_BUTTON = "//button[contains(@class,'btn-clear-all') and contains(text(),'Clear All')]"
CLEAR_ALL_BUTTON = "//div[contains(@class,'popover-footer')]//a[contains(@class,'btn-primary')]"
CANCEL_BUTTON = "//div[contains(@class,'popover-footer')]//a[contains(@class,'btn btn-default')]"
ICON_CLOSE_CLEAR_ALL_OIT_LOCATOR = "//div[contains(@class,'sidebar-cal-close-btn')]//i[contains(@class,'icon-remove')]"

