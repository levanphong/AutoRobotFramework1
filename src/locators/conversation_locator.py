# Landing site and company site
JOB_SECTION = "(//*[contains(@data-testid,'job_detail_item_lbl_title') and contains(text(),'{}')])[last()]/following-sibling::div//span[contains(text(),'{}')]"

# Scheduling conversation
SCHEDULE_CONFIRM_BUTTON = "//button[contains(@class, 'button--primary')]//*[contains(text(), 'Confirm')]"
TIME_OPTIONS = "//a[contains(@class,'fc-event-future')]"
TIME_OPTIONS_LAST = "(//a[contains(@class,'fc-event-future')])[last()]"

# LANDING PAGE
CONVERSATION_HEADER_IMAGE = "//div[contains(@class, 'uMTCDoBw')]//img"
CONVERSATION_HEADER_TITLE = "//div[contains(@class, 'uMTCDoBw')]//span[contains(text(),'{}')]"
CONVERSATION_INPUT_TEXTBOX = "//textarea[contains(@data-testid,'widget_input_text')]"
CONVERSATION_SEND_BUTTON = "//button[contains(@class, 'button--primary')]//span[last()]"
CONVERSATION_ASSIST_BLOCK = "//*[contains(@class,'assist-block')]//*[contains(text(),'{}')]"
CONVERSATION_ASSIST_BLOCK_IMG = "//*[contains(@class,'assist-block')]//img"
CONVERSATION_ASSIST_BLOCK_VIDEO = "//*[contains(@class,'assist-block')]//video"
CONVERSATION_CHOICE_BUTTON = "//*[normalize-space(text())='{}']"
CONVERSATION_PREFERENCE_CHOICE_BUTTON = "//label[contains(@data-testid, 'select_list_cb_selection')]//span[contains(text(), '{}')]"
CONVERSATION_CONFIRM_CHOICE_BUTTON = "//button[contains(@data-testid,'select_list_btn_submit')]"
CONVERSATION_SKIP_EEO_BUTTON = "//span[contains(text(),'Skip')]"
CONVERSATION_PROCESSING_BUTTON = "//span[contains(text(),'Processing')]"
CONVERSATION_APPLY_NOW_BUTTON = "//*[contains(@data-testid,'job_detail_btn_apply')]"
CONVERSATION_APPLY_NOW_LOADING_ICON = "//*[contains(@data-testid,'job_detail_btn_apply')]//*[contains(@class, 'loading')]"
CONVERSATION_AI_LOADER_MESSAGE = "//*[contains(@data-testid,'loading-message')]"
CONVERSATION_CANDIDATE_NAME_CIRCLE = "//span[contains(@class,'avatar--circle')]//span"
CONVERSATION_UPLOAD_VIDEO_BUTTON = "//div[contains(@id, 'uplVideoRecorder')]//span"
CONVERSATION_INPUT_VIDEO = "//input[@type='file']"
CONVERSATION_ALERT_DIALOG_GDPR = "//*[contains(@class, 'terms-modal')]//*[contains(@class, 'dialog__body')]"
CONVERSATION_DETAILS_BUTTON = "//*[normalize-space()='{}']/..//*[normalize-space()='Details']"
CONVERSATION_LATEST_MESSAGE = "(//*[@data-testid='message_lbl_ours'])[last()]//*[contains(@class, 'msg-text')]//div"
CONVERSATION_MESSAGES_THEIRS = "(//*[@data-testid='message_lbl_theirs'])//*[contains(@class, 'msg-text')]//div"
CONVERSATION_SEE_ALL_BUTTON = "//button[normalize-space()='See All']"
CONVERSATION_LOCATION_TWENTY_JOB = "(//*[contains(@class, 'el-dialog')]//span[contains(@data-testid, 'job_detail_item_txt_location')])[{}]"
CONVERSATION_LOCATION_TITLE_TWENTY_JOB = "//*[contains(@data-testid, 'job_viewer_lbl_title')]//span[contains(text(), '20 Recommended Jobs')]"
CONVERSATION_HEBREW_SEND_BUTTON= "//button[contains(@class, 'button--primary')]//*[normalize-space()='שליחה')]"

# LANDING PAGE / Recommended Jobs
RECOMMENDED_JOB_ITEM = "//*[contains(@data-testid, 'job_viewer_lbl_title')]/following-sibling::*//*[contains(@class, 'job-item')]//*[contains(@data-testid, 'job_detail_item_lbl_title') and contains(text(), '{}')]"
RECOMMENDED_JOB_X_BUTTON = "//*[contains(@aria-label, 'Close')]"

# LANDING PAGE / Video player
CONVERSATION_VIDEO_PLAYER_PLAY_BUTTON = "//div[contains(@class,'plyr--video')]//div[contains(@class,'plyr__controls')]//button[@data-plyr='play']"
CONVERSATION_VIDEO_PLAYER_SOUND_BUTTON = "//div[contains(@class,'plyr--video')]//div[contains(@class,'plyr__controls')]//button[@data-plyr='mute']"
CONVERSATION_VIDEO_PLAYER_SOUND_VOLUME_BAR = "//div[contains(@class,'plyr--video')]//div[contains(@class,'plyr__controls')]//button[@data-plyr='mute']//following-sibling::input"
CONVERSATION_VIDEO_PLAYER_FULL_SCREEN_BUTTON = "//div[contains(@class,'plyr--video')]//div[contains(@class,'plyr__controls')]//button[@data-plyr='fullscreen']"
CONVERSATION_VIDEO_PLAYER_CURRENT_TIME_TEXT = "//div[contains(@class,'plyr--video')]//div[contains(@class,'plyr__controls')]//div[contains(@class,'time--current')]"
CONVERSATION_VIDEO_PLAYER_DURATION_TIME_TEXT = "//div[contains(@class,'plyr--video')]//div[contains(@class,'plyr__controls')]//div[contains(@class,'time--duration')]"
CONVERSATION_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON = "//div[contains(@class,'el-card__body')]//span[normalize-space()='Done']//parent::button"

# Widget shadow POSTING JOB
POSTING_JOB_URL_REQUIREMENT_ACCEPT_BUTTON = """dom:Array.from(document.querySelector("apply-widget").shadowRoot.querySelectorAll("button[class*='el-button el-button--primary']")).filter(e => e.innerText == "Accept")"""

# Widget shadow dom
SHADOW_DOM_EVENT_WIDGET_CONVERSATION_LAYOUT = "//*[contains(@class,'event-widget') and not(contains(@style,'display: none'))]"
MESSAGE_CONVERSATION = """dom:document.querySelector("apply-widget").shadowRoot.querySelectorAll("div[data-testid='widget_chatbox_popover']")"""
FIRST_MESSAGE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("span[data-testid*='message_lbl'] div[class*='msg-text'] > div")"""
LATEST_MESSAGE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("span[data-testid*='message_lbl']:last-child div[class*='msg-text'] > div")"""
LATEST_MESSAGE_FROM_OLIVIA = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("span[data-testid='message_lbl_ours']:last-child div[class*='msg-text'] > div")"""
LATEST_MESSAGE_FROM_CANDIDATE_1 = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("span[data-testid='message_lbl_theirs']:last-child div[class*='msg-text'] > div")"""
LATEST_MESSAGE_FROM_CANDIDATE_2 = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("span[data-testid='message_lbl_theirs']:nth-last-child(2) div[class*='msg-text'] > div")"""
INPUT_WIDGET = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='widget_input_text'")"""
SEND_BUTTON_CONV = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='messenger-composer'] button[class*='el-button']")"""
SHADOW_DOM_CONVERSATION_CHOICE_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[value='{}'] + span")"""
SHADOW_DOM_CONVERSATION_CHOICE_CONFIRM_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='select_list_btn_submit']")"""
WIDGET_FIRST_LOADING_MESSAGE = "//*[contains(@class,'apply-bubble-loader')]"
WIDGET_LOADING_MESSAGE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='loading-message'")"""
SHADOW_DOM_FIRST_JOB_ON_LIST_VIEW = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='message_lbl_job_results']:last-child [data-testid*='job_detail_item_lbl_title']")"""
SHADOW_DOM_JOB_SEARCH_RESULT_DETAILS_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='message_lbl_job_results']:last-child button")"""
SHADOW_DOM_LIST_VIEW_TABLE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid*='message_lbl_job_results']")"""
SHADOW_DOM_DETAILS_CONTENT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector(".el-card__content  span[aria-label]")"""
SHADOW_DOM_CANDIDATE_NAME_CIRCLE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[class*='avatar--circle'] span")"""
SHADOW_DOM_SEARCH_RESULT_JOB_TITLE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid*='message_lbl_job_results']:last-child span[tabindex]")"""

# Widget shadow dom / AI Matching Resume
SHADOW_DOM_UPLOAD_RESUME_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid*='messenger_lbl_file_upload_title']")"""
SHADOW_DOM_UPLOAD_RESUME_INPUT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[accept*='pdf'][type='file']")"""
SHADOW_DOM_UPLOADING_RESUME_ICON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[id='resumeMatchingUploader'] i[class*='icon']")"""
SHADOW_DOM_UPLOADED_RESUME_LABEL = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='message_lbl_file_uploaded'] [data-testid='messenger_lbl_system'] span:last-child")"""
SHADOW_DOM_UPLOADED_RESUME_VIEW_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid*='messenger_btn_system_action']")"""

# Widget shadow dom / SELECTED JOB
SHADOW_DOM_SELECTED_JOB_FIELD = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='job-detail__header']>[data-testid*='job_detail'][data-testid*='{}']")"""
SHADOW_DOM_SELECTED_JOB_APPLY_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid*='job_detail_btn_apply']")"""
SHADOW_DOM_SELECTED_JOB_APPLY_LOADING_ICON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid*='job_detail_btn_apply'] [class*=icon-loading]")"""
SHADOW_DOM_SELECTED_JOB =  """dom:document.querySelector("apply-widget").shadowRoot.querySelector(".el-dialog span > div .job-item")"""
SHADOW_DOM_SELECTED_SEE_ALL = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[data-testid='message_lbl_job_results'] button span")"""

# Widget shadow dom / GDPR
SHADOW_DOM_GDPR_ACCEPT_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[role='dialog'] button:last-child")"""

#LANDING PAGE / IMAGE
AGREE_BUTTON = "//*[contains(@data-testid, 'select_list_btn_submit')]//span"
UPDATE_LATER_SPAN = "//*[contains(@class, 'el-link--inner')]//span"
QUESTION_TYPE_CONTENT_TITLE = "//div[contains(@class, 'assist-block-body')]//*[contains(text(),'{}')]"
TYPE_A_MESSAGE_TEXTAREA = "//*[contains(@data-testid, 'widget_input_text')]"
SEND_A_MESSAGE_BUTTON = "//*[contains(@class, 'el-button--primary')]//span[contains(text(), 'Send')]"

# WIDGET PAGE / Sale demo
SHADOW_DOM_CHAT_WIDGET = "//div[@id='chat-widget']"
SHADOW_DOM_ASSIST_BLOCK = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='assist-block'] *[dir*=auto]")"""
SHADOW_DOM_ASSIST_BLOCK_IMG = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='assist-block'] > div img")"""
SHADOW_DOM_ASSIST_BLOCK_VIDEO = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='assist-block'] > div video")"""

# WIDGET PAGE / Video player
SHADOW_DOM_VIDEO_PLAYER_PLAY_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='plyr--video'] div[class*=plyr__controls] button[data-plyr='play']")"""
SHADOW_DOM_VIDEO_PLAYER_SOUND_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='plyr--video'] div[class*=plyr__controls] button[data-plyr='mute']")"""
SHADOW_DOM_VIDEO_PLAYER_SOUND_VOLUME_BAR = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='plyr--video'] div[class*=plyr__controls] button[data-plyr='mute'] + input")"""
SHADOW_DOM_VIDEO_PLAYER_FULL_SCREEN_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='plyr--video'] div[class*=plyr__controls] button[data-plyr='fullscreen']")"""
SHADOW_DOM_VIDEO_PLAYER_DURATION_TIME_TEXT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='plyr--video'] div[class*=plyr__controls] div[class*='time--duration']")"""
SHADOW_DOM_VIDEO_PLAYER_NOW_PLAYING_DONE_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*=el-card__body] button")"""

# LANDING PAGE / List view
CONVERSATION_LIST_VIEW_FIELD = "//*[contains(@data-testid,'job_detail_item_lbl_{}')]"
CONVERSATION_LIST_VIEW_TABLE = "(//*[contains(@data-testid,'job_results')])[last()]"
CONVERSATION_LIST_VIEW_FIRST_FIELD = "//*[contains(@class, 'job-item') and contains(@tabindex, '0')][1]"
CONVERSATION_LIST_VIEW_ITEM = "(//*[contains(@data-testid, 'message_lbl_job_results')])[last()]//*[contains(text(), '{}')]"

# LANDING PAGE / Selected job
CONVERSATION_SELECTED_JOB_FIELD = "//*[contains(@class, 'job-detail__header')]//*[contains(@data-testid,'job_detail') and contains(@data-testid, '{}')]"
CONVERSATION_SELECTED_JOB_APPLY_BUTTON = "//*[contains(@data-testid, 'job_detail_btn_apply')]"
CONVERSATION_SELECTED_JOB_X_BUTTON = "//*[contains(@class, 'dialog__headerbtn')]"

# JOB POSTING PAGE
CONVERSATION_JOB_POSTING_APPLY_NOW_BUTTON = "//button[contains(@class,'btn-apply')]"
CONVERSATION_JOB_POSTING_FIELD = "//*[contains(@data-testid,'job_posting_item_lbl_{}')]"
CONVERSATION_JOB_POSTING_JOB_TITLE = "//*[contains(@class,'job-name')]"

# LANDING PAGE & CHAT WITH OLIVIA
GDPR_MODAL = "//p[contains(text(),'• By agreeing to these terms')]"
GDPR_MODAL_DECLINE_BUTTON = "//div[contains(@class,'el-dialog__footer')]//span[contains(text(),'Decline')]"
GDPR_MODAL_ACCEPT_BUTTON = "//div[contains(@class,'el-dialog__footer')]//span[contains(text(),'Accept')]"
MESSAGE_CONVERSATION_IMAGE_MEDIA = "//div[contains(@class,'assist-block-body')]//img"
MESSAGE_CONVERSATION_VIDEO_MEDIA = "//div[contains(@class,'assist-block-body')]//video[contains(@controls,'controls')]"
MESSAGE_CONVERSATION_OLIVIA_REPLY = "//div[contains(@class,'msg-text')]//div[contains(text(),'{}')]"
MESSAGE_CONVERSATION_OLIVIA_STATUS = "//div[contains(@class, 'notification')]//*[contains(text(), '{}')]"
MESSAGE_CONVERSATION_CHOICE_SEND_INFORMATION = "//div[contains(@class,'el-card__content')]//*[contains(@class,'el-checkbox-button__inner') and contains(text(),'{}')]"

# SHADOW APPLY JOB
SHADOW_DOM_GDPR_MODAL_ACCEPT_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[role='dialog'] button:last-child")"""
SHADOW_DOM_CONVERSATION_SEND_BUTTON ="""dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[aria-label*='Send message button']")"""
SHADOW_DOM_CONVERSATION_INPUT_TEXTBOX = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("textarea[placeholder*='Type a message']")"""
SHADOW_DOM_CONVERSATION_LINK_FORM = """dom:Array.from(document.querySelector('apply-widget').shadowRoot.querySelectorAll("div[class*='msg-text']")).filter(e => e.innerText.includes('Please complete your form'))[0].querySelector("a")"""

# POPUP POLICY
MESSAGE_CONVERSATION_BUTTON_POLICY = "//*[contains(@class,'el-button el-button--primary')]//*[contains(text(),'{}')]"

# Normal element on WIDGET SITE
WIDGET_UPLOAD_RESUME_INPUT = "//*[@id='olivia_integration_candidate_id']"

# Widget shadow dom / TERM
SHADOW_DOM_TERM_ACCEPT_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[role='dialog'] button:last-child")"""
SHADOW_DOM_TERM_DECLINE_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[role='dialog'] button:first-child")"""
SHADOW_DOM_TERM_BODY_TEXT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("[role='dialog'] div[class*='el-dialog__body'] div")"""
SHADOW_DOM_TERM_ACCEPTED_TEXT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[data-testid*='messenger_lbl_system'] span")"""
