# BASE PAGE
RECORDED_INTERVIEW_PAGE_NEW_INTERVIEW_BUTTON = "//*[contains(@class, 'el-button--primary')]//span[contains(text(), 'New Interview')]"
RECORDED_INTERVIEW_PAGE_SEARCH_INTERVIEW_TEXT_BOX = "//*[contains(@placeholder, 'Search for interviews')]"
RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ICON = "//*[contains(@class,'icon-menu')]"
RECORDED_INTERVIEW_PAGE_LIST_ITEMS_ECLIPSE = "//tr[contains(@class, 'el-table__row') or contains(@class, 'item-row ')]//td[contains(@class, 'col-menu el-table__cell') or contains(@class, 'action-offer')]//*[contains(@class, 'icon-menu')]"
RECORDED_INTERVIEW_PAGE_LIST_ITEMS_ECLIPSE_INDEX = "(//tr[contains(@class, 'el-table__row')]//td[contains(@class, 'col-menu el-table__cell')]//i[contains(@class, 'icon-menu')])[{}]"

# BASE PAGE / Item Eclipse menu action
RECORDED_INTERVIEW_PAGE_ITEM_ECLIPSE_ACTION = "//ul[contains(@x-placement,'bottom-start')]//li[contains(@class, 'el-dropdown-menu__item')]//span[contains(text(), '{}')]"

# BASE PAGE / Item Eclipse menu action / Delete Recorded Interview confirm popup
RECORDED_INTERVIEW_PAGE_DELETE_INTERVIEW_CONFIRM_DELETE_BUTTON = "//*[contains(@class, 'el-button--danger')]//span"

# BASE PAGE / NEW INTERVIEW PAGE
NEW_RECORDED_INTERVIEW_NAME_TEXT_BOX = "//*[contains(@placeholder, 'Enter Name')]"
NEW_RECORDED_INTERVIEW_QUESTION_BUTTON = "//*[contains(text(), 'Add Question')]"
NEW_RECORDED_INTERVIEW_CLOSING_MESSAGE_TEXT_BOX = "//*[contains(@placeholder, 'Enter Closing Message')]"
NEW_RECORDED_INTERVIEW_SAVE_BUTTON = "//*[contains(@class, 'el-button--primary')]//span[contains(text(), 'Save')]"

# BASE PAGE / NEW INTERVIEW PAGE / Question input form
NEW_RECORDED_INTERVIEW_QUESTION_NAME_EDIT_BUTTON = "//*[contains(@class,'icon-edit')]"
NEW_RECORDED_INTERVIEW_QUESTION_NAME_TEXT_BOX = "//*[contains(@class, 'editable-label')]"
NEW_RECORDED_INTERVIEW_QUESTION_CONTENT_TEXT_BOX = "//div[@placeholder='Type question here...']"
NEW_RECORDED_INTERVIEW_QUESTION_SAVE_BUTTON = "//*[contains(@class, 'el-button--default')]//following-sibling::button//span[contains(text(), 'Save')]"
