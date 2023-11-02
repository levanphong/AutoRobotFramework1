# BASE PAGE
LEFT_TAB_NAV_TEXT = "//div[contains(@class,'nav-text') and text()='{}']"

# BASE PAGE / Reports tabs
REPORT_TAB_NAV_BUTTON = "//div[contains(@class,'menu')]//*[contains(text(),'{}')]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE
CREATE_NEW_REPORT_NAV_BUTTON = "//div[@class='navigation-btn']//button[contains(text(),'{}')]"
CREATE_NEW_REPORT_BACK_TO_BUTTON = "//a[contains(@class,'ev-back-btn confirm-leave')]"
CREATE_NEW_REPORT_DISCARD_BUTTON = "//button[contains(text(),'Discard')]"

# BASE PAGE / Reports tabs / One-Time
REPORT_ONE_TIME_PATTERN_FILENAME = "//div[contains(text(),'{}')]//following-sibling::div"
REPORT_ONE_TIME_PATTERN_DOWNLOAD_BUTTON = "//div[contains(text(),'{}')]//ancestor::tr//button[contains(@data-testid,'analyreport_btn_download_report')]"
REPORT_ONE_TIME_PATTERN_ACTION_BUTTON = "//div[contains(@class,'is-scrolling-none')]//div[contains(text(),'{}')]//ancestor::tr//i[contains(@class,'icon-menu')]"
REPORT_ONE_TIME_DELETE_BUTTON = "//div[contains(@role,'tooltip') and contains(@aria-hidden,'false')]//div[contains(@data-testid,'analyreport_btn_Delete')]"
REPORT_ONE_TIME_DELETE_CONFIRM_YES_NO = "//div[contains(@role,'dialog')]//*[contains(text(),'{}')]"
REPORT_ONE_TIME_PATTERN_REPORT_NAME = "//tr[contains(@class,'el-table__row')]//div[contains(text(),'{}')]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Type step
CREATE_NEW_REPORT_CATEGORY_DROPDOWN = "//input[@id='id_category']//following-sibling::span"
CREATE_NEW_REPORT_CATEGORY_DROPDOWN_VALUE = "//*[@class='dropdown-item' and contains(text(),'{}')]"
CREATE_NEW_REPORT_REPORT_DROPDOWN = "//input[@id='id_report']//following-sibling::span"
CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE = "//div[contains(@class,'list-report')]//span[@class='report-title' and contains(text(),'{}')]"
CREATE_NEW_REPORT_NAME_DROPDOWN = "//label[text()='Name']//following-sibling::div//input"
CREATE_NEW_REPORT_NAME_DROPDOWN_VALUE = "//div[contains(@class,'ddl-report-children-section')]//span[contains(@class,'report-child-name') and contains(text(),'{}')]"
CREATE_NEW_REPORT_REPORT_DROPDOWN_TITLE_DESCRIPTION = "//div[contains(@class,'list-report')]//span[@class='report-title' and contains(text(),'{}')]//following-sibling::span[contains(text(),'{}')]"
CREATE_NEW_REPORT_FREQUENCY_DROPDOWN = "//*[contains(@class,'report__frequency')]//span[contains(@class,'fa-angle-down')]"
CREATE_NEW_REPORT_FREQUENCY_DROPDOWN_VALUE = "//*[@class='dropdown-item' and contains(text(),'{}')]"
CREATE_NEW_REPORT_DATE_RANGE_SELECT = "//input[@id='id_date_range']//following-sibling::input"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Field step
CREATE_NEW_REPORT_PATTERN_FIELD = "//div[@class='available-field-list']//div[contains(text(),'{}')]"
CREATE_NEW_REPORT_PATTERN_DELETE_FIELD_BUTTON = "//div[@class='available-field-list']//div[contains(text(),'{}')]//ancestor::div[contains(@class,'available-field-list__item')]//i[contains(@class,'icon-delete2')]"
CREATE_NEW_REPORT_SEARCH_AVAILABLE_INPUT = "//input[contains(@placeholder,'Search available fields')]"
CREATE_NEW_REPORT_PATTERN_AVAILABLE_RESULT = "//div[contains(@class,'available-field-search-result')]//*[contains(text(),'{}')]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Filter step
CREATE_NEW_REPORT_ADD_FILTER_BUTTON = "//button[contains(@class,'add-filter')]"
CREATE_NEW_REPORT_PATTERN_FILTER_TYPE_RESULT = "//div[contains(@class,'dropdown-item')]//span[contains(text(),'{}')]"
CREATE_NEW_REPORT_PATTERN_FILTER_CONDITION = "//div[contains(@class,'cusstom-radio')]//*[contains(text(),'{}')]"
CREATE_NEW_REPORT_PATTERN_FILTER_CONDITION_INPUT = "//div[contains(@class,'cusstom-radio')]//*[text()='is']//parent::div//following-sibling::div//input"
CREATE_NEW_REPORT_PATTERN_FILTER_APPLY_BUTTON = "//div[contains(@class,'open')]//button[contains(text(),'Apply')]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Delivery step
CREATE_NEW_REPORT_INPUT_NAME_REPORT = "//div[contains(@id,'delivery2')]//input[contains(@placeholder,'Enter Report Title')]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Summary step
CREATE_NEW_REPORT_FILE_NAME = "//label[contains(text(),'File name: ')]//following-sibling::span"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Success message
CREATE_NEW_REPORT_SUCCESS_MESSAGE = "//div[contains(text(),'We are processing your request. You will get report file sent to your email.')]"
CREATE_NEW_REPORT_SUCCESS_MESSAGE_OK_BUTTON = "//div[contains(text(),'We are processing your request. You will get report file sent to your email.')]//following-sibling::div//button[contains(text(),'Ok')]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Type step / Date range select
CREATE_NEW_REPORT_DATE_RANGE_VALUE = "//span[contains(@class,'flatpickr-day') and contains(text(),'{}')]"
CREATE_NEW_REPORT_DATE_RANGE_APPLY_BUTTON = "(//button[contains(@class,'btn-primary')])[last()]"

# BASE PAGE / Reports tabs / NEW REPORT PAGE / Fields step
CREATE_NEW_REPORT_FIELDS_NAV_BUTTON = "//li[contains(@class,'nav-item')]//*[contains(text(),'{}')]"
CREATE_NEW_REPORT_SORT_INPUT = "//input[contains(@placeholder,'Search for field')]"
CREATE_NEW_REPORT_SORT_DROPDOWN = "//div[@class='field-sorting-content__item']//*[contains(@class,'icon icon-chevron-down')]"
CREATE_NEW_REPORT_SORT_DROPDOWN_VALUE = "//ul[contains(@class,'field-sorting-dropdown')]//div[contains(text(),'{}')]"


# BASE PAGE / Reports tabs / NEW REPORT PAGE / Summary step / Report sent popup
CREATE_NEW_REPORT_REPORT_SENT_OK_BUTTON = "(//div[contains(@class,'modal-content')]//button)[last()]"

# BASE PAGE / Dashboard tabs / Dashboard type
DASH_BOARD_FILTER_DATE_DROPDOWN = "//div[contains(@class,'filter-date-range')]//i[contains(@class,'icon-triangle-down')]"
DASH_BOARD_CAPTURED_CANDIDATES_NUMBER = "//*[contains(text(),'Captured Candidates')]//following-sibling::span"
DASH_BOARD_ANALYTICS_CARD = "//div[contains(@class,'analytics-card')]"
DASH_BOARD_FILTER_DROPDOWN_SELECTED_VALUE = "(//i[contains(@class,'icon-check') and @style='']//parent::*//span)[last()]"

# BASE PAGE / Dashboard tabs / Scheduling type
SCHEDULING_ADD_FILTER_VALUE = "(//li[contains(@class,'el-dropdown-menu__item') and contains(text(),'{}')])[last()]"
SCHEDULING_INTERVIEW_OPEN_NUMBER = "//div[contains(@class,'itv-open')]//following-sibling::*[contains(@class,'analytics-card__count')]"

# BASE PAGE / Dashboard tabs / Scheduling type / Add filter popup
SCHEDULING_ADD_FILTER_APPLY_BUTTON = "//div[@role='tooltip']//button[contains(@class,'el-button--primary')]"
SCHEDULING_USER_ROUND_ROBIN_FILTER_ICON = "//*[@data-testid='btn_show_menu']//i[contains(@class,'ic_person')]"

# BASE PAGE / Dashboard tabs / Hire type
HIRE_TOTAL_INTERVIEWS_NUMBER = "//span[contains(text(),'Total interviews')]//parent::span//parent::div/div"
HIRE_DATE_RANGE_FILTER_DROPDOWN = "//div[contains(@class,'filter-date-range')]//i[contains(@class,'triangle-down')]"

# BASE PAGE / Dashboard tabs / Ratings type
RATINGS_AUDIENCE_FILTER_DROPDOWN = "//span[contains(@class,'filter-text') and contains(text(),'Audience Type:')]//following-sibling::i"
RATINGS_AUDIENCE_FILTER_DROPDOWN_VALUE = "//li[contains(@class,'dropdown-menu__item')]//span[contains(text(),'{}')]"
RATINGS_ANALYTICS_VALUE = "//div[contains(text(),'{}')]//parent::div[contains(@class,'analytics-card')]//*[contains(@class,'count')]"
