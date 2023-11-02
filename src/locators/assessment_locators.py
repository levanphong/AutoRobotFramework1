ASSESSMENT_LET_GO_BUTTON = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[class*='el-button el-button--primary']")"""
ASSESSMENT_MODAL = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog']")"""
ASSESSMENT_STATUS = "//button[contains(@data-testid,'candidate_btn_journeys')]//span[contains(text(),'{}')]"
ASSESSMENT_CANDIDATE_NAME = "//span[contains(@data-testid,'candidateblock_lbl_name') and contains (text(), '{}')]"
ASSESSMENT_VIEW_RESULT = """dom:document.querySelector("apply-widget").shadowRoot.querySelectorAll("div[class*='el-card']")[4]"""
ASSESSMENT_VIEW_RESULT_HEADER = """dom:document.querySelector("apply-widget").shadowRoot.querySelectorAll("div[class*='el-card'] div[class*= 'el-card__header']")[1]"""
ASSESSMENT_VIEW_RESULT_CONTENT = """dom:document.querySelector("apply-widget").shadowRoot.querySelectorAll("div[class*='el-card'] div[class*= 'el-card__content'] span")"""
ASSESSMENT_VIEW_RESULT_BUTTON_VIEW_RESULT = """dom:document.querySelector("apply-widget").shadowRoot.querySelectorAll("button[class*='el-button el-button--primary']")[1]"""

# MODAL ASSESSMENT
ASSESSMENT_STATUS_COMPLETE = """dom:document.querySelector("apply-widget").shadowRoot.querySelectorAll("span[data-testid*='message_lbl_ours'] span span")[1]"""
ASSESSMENT_MODAL_HEADER = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__header']")"""
ASSESSMENT_MODAL_BODY_TEXT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='traitify--components-paradox-slide-deck-personality---caption']")"""
ASSESSMENT_MODAL_BUTTON_ME = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[class*='Me']")"""
ASSESSMENT_MODAL_BUTTON_NOTME = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[class*='notMe']")"""
ASSESSMENT_MODAL_ICON_CLOSE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("i[class*='el-icon-close']")"""

# MODAL CONFIRM
ASSESSMENT_MODAL_CONFIRM_HEADER = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__header']")"""
ASSESSMENT_MODAL_CONFIRM_BODY = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__body']")"""
ASSESSMENT_MODAL_CONFIRM_BUTTON_CANCEL = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[class*='el-button el-button--default']")"""
ASSESSMENT_MODAL_CONFIRM_BUTTON_EXIT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[class*='el-button el-button--danger']")"""
ASSESSMENT_MODAL_CONFIRM_ICON_CANCEL = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div [class*='ol-confirm'] button[class*='el-dialog__headerbtn'] i[class*='el-dialog__close el-icon el-icon-close']")"""
ASSESSMENT_MODAL_SUCCESS_TEXT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__body'] p")"""
ASSESSMENT_MODAL_MES_CLICK_FINISH = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__body'] span")"""
ASSESSMENT_MODAL_BUTTON_FINISH = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__body'] button[class*='el-button el-button--primary']")"""

# DIALOG RESULT
ASSESSMENT_DIALOG_VIEW_RESULT = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("div[class*='el-dialog__header']")"""
ASSESSMENT_DIALOG_VIEW_ICON_CLOSE = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("button[class*='el-dialog__headerbtn']")"""
ASSESSMENT_DIALOG_VIEW_ICON_DOWNLOAD = """dom:document.querySelector("apply-widget").shadowRoot.querySelector("i[class*='icon icon-download']")"""

# ASSESSMENT PAGE / LANGDING SITE / Chat
LANDING_SITE_ASSESSMENT_CARD_MODAL = "//div[contains(text(),'{}')]//ancestor::div[contains(@class,'el-card is-always-shadow')]"
LANDING_SITE_ASSESSMENT_TITLE_CARD_MODAL = "//div[contains(text(),'{}')]"
LANDING_SITE_ASSESSMENT_GO_BUTTON = "//div[contains(@class,'el-card__content')]//*[contains(@class,'el-button el-button--primary')]"
LANDING_SITE_ASSESSMENT_BUTTON_TEXT = "//div[contains(@class,'el-card__content')]//*[contains(@class,'el-button el-button--primary')]//span[contains(text(), '{}')]"
LANDING_SITE_ASSESSMENT_RESULT_CARD_MODAL = "//*[contains(text(),'View Your Results')]//ancestor::div[contains(@class,'el-card is-always-shadow')]"
LANDING_SITE_ASSESSMENT_VIEW_YOUR_RESULT_BUTTON = "//div[contains(@class,'el-card is-always-shadow')]//*[contains(text(),'View Your Results')]"
LANDING_SITE_ASSESSMENT_TITLE_YOUR_ASSESSMENT_RESULT_CARD = "//div[contains(@class,'el-dialog')]//div[contains(text(),'Your Assessment Results')]"
LANDING_SITE_ASSESSMENT_DOWNLOAD_ICON = "//*[contains(@class,'icon icon-download')]"

# ASSESSMENT PAGE /LANDING SITE / Traitify Assessment Card Modal
LANDING_SITE_ASSESSMENT_TITLE = "//div[contains(@class,'el-dialog__header')]//div[contains(text(),'Traitify Assessment')]"
LANDING_SITE_ASSESSMENT_BUTTON_ME = "//div[contains(@class,'el-dialog__body')]//button[contains(@class , 'traitify--components-paradox-slide-deck-personality---me')]"
LANDING_SITE_ASSESSMENT_BUTTON_NOT_ME = "//div[contains(@class,'el-dialog__body')]//button[contains(@class , 'traitify--components-paradox-slide-deck-personality---notMe')]"
LANDING_SITE_ASSESSMENT_CAPTION ="//div[contains(@class,'el-dialog__body')]//div[contains(@class,'traitify--components-paradox-slide-deck-personality---caption')]"
LANDING_SITE_ASSESSMENT_BUTTON_CLOSE = "//*[contains(text(),'{}')]//ancestor::div[contains(@class,'el-dialog__header')]//*[contains(@class,'el-dialog__headerbtn')]"
LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_CANCEL_BUTTON = "//div[contains(@class,'el-dialog__footer')]//button[contains(@class,'el-button el-button--default')]"
LANDING_SITE_ASSESSMENT_CONFIRM_MODAL_EXIT_BUTTON = "//div[contains(@class,'el-dialog__footer')]//button[contains(@class,'el-button el-button--danger')]"
LANDING_SITE_ASSESSMENT_CONFIRM_MODAL ="//*[contains(text(),'{}')]//ancestor::div[contains(@class,'ol-confirm')]"
LANDING_SITE_ASSESSMENT_BUTTON_FINISHED ="//div[contains(@class,'el-dialog__body')]//*[contains(@class,'el-button el-button--primary')]"

