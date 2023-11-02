# BASE PAGE
MESSAGE_CUSTOMIZE_TAB_ITEM = "//div[contains(@class,'item__title') and contains(text(),'{}')]"

# Event
EVENTS_TAB = "id:event"
CANDIDATE_TAB_ON_DIALOG = "//label[contains(text(),'Candidates')]"
HIRING_EVENTS_TITLE = "//div[contains(@class, 'message comm-type comm-type')]//div[contains(text(), 'Hiring Events')]"
VIRTUAL_CHAT_BOOTH_ONLY_TITLE = "//div[contains(@class, 'message comm-type comm-type')]//div[contains(text(), 'Hiring Events - Virtual Chat Booth Only')]"
USER_TAB = "//label[contains(@for, 'user_recipient')]"
CLOSE_MODAL_ICON = "//*[contains(@id,'custom-message-modal')]//em[contains(@class,'icon-remove')]"
EVENT_CONTENT_EMAIL_TEXTBOX_BY_INTERVIEW_TYPE = "//*[contains(text(), 'Interview Confirmed: {}')]//parent::div[contains(@class, 'type--email')]//div[contains(@class, 'email-content')]//div[@contenteditable='true']"
MESSAGE_CONTENT_BY_TITLE = "//*[text()='{}']//parent::div//div[@contenteditable='true']"

# Multiple Applicant
MESSAGE_BOX = "//div[contains(@class, 'mess-box')]//div[contains(@contenteditable, 'true')]"
TOKEN_MESSAGE = "//a[contains(text(), '{}')]"
HASH_TAG_LIST = "//ul[contains(@class, 'dropdown-menu textcomplete-dropdown')]//li//a"
SAVE_BUTTON_MESSAGE = "//button[contains(@class, 'btn btn-primary btn-save-msg')]"
CANCEL_BTN_MESS_CUSTOM = "//button[contains(@class, 'btn btn-default btn-cancel')]"
ADD_MORE_MESSAGE = "//div[contains(@class, 'order-number icon-plus')]"
REMOVE_BUTTON_MESSAGE_CUS = "//div[contains(@class, 'order-number active')]//span[contains(@class, 'remove')]"
MESS_ACTIVE_MESSAGE_CUS = "//div[contains(@class, 'order-number active')]//span[contains(@class, 'number')]"
MESS_ACTIVE_MESSAGE_CUS_DYNAMIC_TEXT = "//div[contains(@class, 'order-number')]//span[contains(@class, 'number') and contains(text(), '{}')]"

# ERP
SCHEDULE_IN_PERSON_TEXT = "//*[contains(text(),'I have great news. You meet our minimum qualifications and I would like to set up a 5 minute in-person ')]"

# GDPR
MESSAGE_SUB_TITLE = "//div[contains(@class, 'mess-sub-title')]"
CAPTURE_TITLE = "//div[contains(@class, 'title') and contains(text(), 'Capture')]"
CAPTURE_AFTER_START_CAPTURE_CON = "(//div[contains(@class, 'mess-box')]//div[contains(@contenteditable, 'true')])[{}]"

# jOB SEARCH
HEADER_JOB_SEARCH = "//*[contains(@id, 'jobsearch')]"

# Initial Request
SMS_MESSAGE_CONTENT = "//div//div[contains(text(), '{}')]//following-sibling::div//div[contains(@class, 'mess-box')]//div"
SMS_TAB = "//span[contains(text(), 'SMS')]"
EMAIL_TAB = "//span[contains(text(), 'Email')]"
WEB_TAB = "//span[contains(text(), 'Web')]"
EMAIL_MESSAGE_CONTENT = "//div//div[contains(text(), '{}')]//following-sibling::div//div[contains(@class, 'email-content')]//div[contains(@class, 'mess-box')]//div"
SAVE_BUTTON_ON_MODAL = "//div[contains(@id, 'custom-message-modal')]//span//button[contains(text(), 'Save')]"

# Job Search & Chat to Apply
MESSAGE_SMS = "//div[contains(@placeholder, 'To fast track your time')]"
MESSAGE_EMAIL = "//div[contains(@placeholder, 'Fast-track your experience')]"

# Select time interview
SCHEDULE_SELECT_TIME_BUTTON = "//span[contains(text(), 'Select')]"
SCHEDULE_SELECT_TIME_OPTIONS_LAST = "(//div[contains(@class, 'fc-timegrid-event-harness-inset')]//div[contains(@class, 'fc-time')])[last()]"
EDIT_BUTTON = "//li[contains(@data-testid, 'candidatemenu_btn_editinfo')]"
UPDATE_INTERVIEW = "//button[contains(@data-testid, 'interview_detail_btn_update')]"
CANCEL_INTERVIEW_BUTTON = "//span[contains(text(), 'Cancel Interview')]"
CONFIRM_CANCEL_INTERVIEW_BUTTON = "//button[contains(@data-testid,'scheduling_cancel_btn_confirm')]"
INPUT_ADVANCED_SETTINGS = "//button[contains(@data-testid, 'assistant_scheduling_btn_settings')]"
HAVE_ATTENDEE_SCHEDULE_TURN_ON = "//input[contains(@id, 'have_attendee_schedule')]//following-sibling::span"
INPUT_SELECT_ATTENDEE = "//input[contains(@placeholder, 'Select Interviewer')]"
ATTENDEE_NAME = "(//span[contains(text(), '{}')]//parent::div)[last()]"
INPUT_SEARCH_ATTENDEE = "//input[contains(@placeholder, 'Search for an attendee')]"
RESCHEDULE_BUTTON = "//button//span[contains(text(), 'Reschedule')]"
INPUT_TEXT_MESSAGE = "//textarea[contains(@class, 'msg-input')]"

# BASE PAGE / Event / Event Canceled
EVENT_STATE_ITEM = "//div[contains(@class,'state-item')]//div[@class='title' and contains(text(),'{}')]"
EVENT_CANCELED_MESS_BOX = "//div[@class='mess-title' and contains(text(),'{}')]//parent::div//div[@class='mess-box']//div"

#INTERVIEW SCHEDULING
INTERVIEW_SCHEDULING_TITLE = "//div[contains(@id , 'interview')]//div[contains(text(), 'Interview Scheduling')]"
INTERVIEW_SCHEDULING_OPTIONS = "//div[contains(@class, 'vb-visible')]//div[contains(text(), '{}')]"
INTERVIEW_SCHEDULING_EDIT_RECORDED_INTERVIEW_MESSAGE = "//div[contains(@class, 'mess-box')]//div[contains(@placeholder, 'Hi #candidate-firstname! Your 10 minute interview has been changed. Please complete this interview at your nearest convenience, this link will not expire. You will need access to a camera and microphone.')]"
INTERVIEW_SCHEDULING_CANCEL_RECORDED_INTERVIEW_MESSAGE = "//div[contains(@class, 'mess-box')]//div[contains(@placeholder, 'Hi #candidate-firstname. Due to unforeseen circumstances, your upcoming recorded interview has been cancelled. A recruiter will reach out to you with more details within 48 hours.')]"
INTERVIEW_SCHEDULING_MEDIA_TAG = "//div[contains(@class, 'comm-type__nav')]//span[contains(text(), '{}')]"

# EVENT / Candidate Initiates Reschedule
HIRING_EVENT_NO_AVAILABILITY_TO_SCHEDULE = "//div[contains(text(), 'Hiring Events')]//following-sibling::div[contains(text(), 'No Availability to Reschedule')]//following-sibling::div//div[contains(text(), '{}')]"
ORIENTATION_NO_AVAILABILITY_TO_SCHEDULE = "//div[contains(text(), 'Orientation Events')]//following-sibling::div[contains(text(), 'No Availability to Reschedule')]//following-sibling::div//div[contains(text(), '{}')]"
PENDING_ORIENTATION_REQUEST_EXPIRED = "//div[contains(text(), 'Orientation Events')]//following-sibling::div[contains(text(), 'Pending Orientation Request Expired')]//following-sibling::div//div[contains(@placeholder, '{}')]"
AI_EVENT_MESSAGING = "//div[contains(text(), '{}')]//following-sibling::div[contains(text(), '{}')]//following-sibling::div//div[contains(@placeholder, '{}')]"

# CLOSED PAGES
CLOSED_PAGES_TAG_ITEM = "//div[contains(@class, 'state-item')]//div[contains(@class, 'title') and contains(text(), '{}')]"
CLOSED_PAGES_BUTTON = "//span[contains(@class, 'action-btns')]//button[contains(text(), '{}')]"

# CLOSED PAGES / FORM CANCELED
CLOSED_PAGES_FORM_CANCELED_CONTENT = "//div[contains(@class, 'email-content')]//div[contains(@class, 'ai-editor')]"
