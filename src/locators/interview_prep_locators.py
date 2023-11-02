# BASE PAGE
NEW_INTERVIEW_PREP_BUTTON = "//*[contains(@class,'container-fluid')]//*[normalize-space(text())='New Interview Prep']"
INTERVIEW_PREP_PAGE_SEARCH_TEXT_BOX = "//input[@placeholder='Search for interview prep']"
INTERVIEW_PREP_PAGE_SEARCH_RESULT_ECLIPSE_ICON = "//*[contains(@class,'el-table__row')]//*[contains(@class,'icon-menu')]"

# BASE PAGE / Eclipse menu
INTERVIEW_PREP_PAGE_ECLIPSE_MENU_ITEM = "(//*[contains(@id,'dropdown-menu')])[last()]//*[contains(@class,'el-dropdown-menu__item')]//*[normalize-space(text())='{}']"

# BASE PAGE / Eclipse menu / Delete Interview prep popup confirm
INTERVIEW_PREP_DELETE_POPUP_DELETE_BUTTON = "(//*[@role='dialog'])[last()]//*[contains(@class,'delete-button')]"

# BASE PAGE / NEW INTERVIEW PREP PAGE
INTERVIEW_PREP_TITLE_TEXTBOX = "//*[normalize-space(text())='Interview Prep Title']//following-sibling::*//input"
AUDIENCE_DROPDOWN = "//*[normalize-space(text())='Select Audience']"
NEW_INTERVIEW_PREP_AUDIENCE_TYPE = "(//*[contains(@class,'el-dropdown-menu')])[last()]//*[contains(text(),'{}')]"
EXTERNAL_ID_TEXTBOX = "//*[normalize-space(text())='External ID']//following-sibling::*//input"
SAVE_NEXT_FINISH_BUTTON = "//button[contains(@class, 'el-button--primary')]//*[contains(text(),'{}')]"
INTERVIEW_PREP_TAB = "//*[contains(@class, 'el-main')]//*[contains(@class, 'el-button--default el-button--small')]//*[normalize-space()='{}']"
ESCAPE_PREP_BUTTON = "//*[contains(@class,'el-table__row')]//*[contains(@class,'icon-menu')]"
EDIT_PREP_BUTTON = "(//*[contains(@id,'dropdown-menu')])[last()]//*[contains(@class,'el-dropdown-menu__item')]//*[normalize-space(text())='Edit']"
INTERVIEW_PREP_UPLOAD_DOCUMENT_ICON = "//*[contains(@class, 'icon-upload')]"
