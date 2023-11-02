# BASE PAGE
NEW_JOURNEY_BUTTON = "//button[@class='btn btn-primary btn-create-journey']"
JOURNEY_TITLE = "//strong[@class='_lead_name' and contains(text(),'{}')]"
JOURNEY_ECLIPSE_ICON = "(//strong[contains(@class,'_lead_name') and contains(text(),'{}')]/ancestor::div[contains(@class, 'title')]/following-sibling::div//p[contains(@class, 'text-lighter _desc_1 desc-text ') and contains(text(), 'Used in 0')]/ancestor::div[contains(@class,'cem-row')]//span[@class='cursor-pt icon icon-menu'])"
JOURNEY_IN_ROW = "//div[contains(@class,'cem-row')]"
JOURNEY_BRIEFCASE_SETTING_USER_PERMISSION = "//*[contains(@class, 'icon-briefcase')]//ancestor::li//*[text()= '{}']"
JOURNEY_IC_PERSON_SETTING_USER_PERMISSION = "//*[contains(@class, 'icon-ic_person')]//ancestor::li//*[text()= '{}']"

# BASE PAGE / Eclipse popup
JOURNEY_ECLIPSE_POPUP_DUPLICATE_BUTTON = "(//strong[contains(@class,'_lead_name') and contains(text(),'{}')]//ancestor::div[contains(@class, 'title')]//following-sibling::div//p[contains(@class, 'text-lighter _desc_1 desc-text ') and contains(text(), 'Used in 0')]//ancestor::div[contains(@class,'cem-row')]//span[contains(text(),'Duplicate Journey')])"
JOURNEY_ECLIPSE_POPUP_DELETE_BUTTON = "(//strong[contains(@class,'_lead_name') and contains(text(),'{}')]//ancestor::div[contains(@class, 'title')]//following-sibling::div//p[contains(@class, 'text-lighter _desc_1 desc-text ') and contains(text(), 'Used in 0')]//ancestor::div[contains(@class,'cem-row')]//span[contains(text(),'Delete Journey')])"
JOURNEY_ECLIPSE_POPUP_CONFIRM_DELETE_BUTTON = "//div[@class='modal-content printable']//button[@class='btn btn-primary btn-sm ok-btn']"
STAGE_NAME_IN_JOURNEY = "//span[text()='{}']//ancestor::div[contains(@class, 'stage-item')]//i[contains(@class, 'icon-chevron-right')]"
ICON_SETTING_STAGE_IN_JOURNEY = "//*[contains(@class, 'candidate-journey-settings ')]//em[contains(@class, 'cursor-pt icon-settings')]"
SETTING_USER_PERMISSION_STAGE = "(//*[contains(@class, 'cj-permission-user')]//*[contains(text(), '{}')])[1]"
ECLIPSE_ICON_MENU_IN_STAGE = "//*[contains(text(), '{}')]//parent::div//following-sibling::span[contains(@class, 'icon-menu')]"
ICON_PLUS_ROUND_IN_STAGE = "//*[contains(@class, 'icon-plus-round')]"
USER_HIRING_TEAM_ROLES_IN_STAGE = "//*[text()='{}']//ancestor::li//*[contains(@class, 'custom-checkbox')]"
PERMISSION_PROVER_APPLY_BUTTON = "//*[contains(@class, 'permissions-popover active')]//*[text()='Apply']"
PERMISSION_PROVER_POPUP_SAVE_BUTTON = "//*[contains(@class, 'cj-permission-footer')]//button[text()='Save']"
PERMISSION_PROVER_POPUP_NAME_TAB = "//*[contains(@id, 'cj-stage-perm-modal')]//span[contains(text(), '{}')]"
JOURNEY_PROVER_POPUP_CLOSE_BUTTON = "//*[@id='cj-stage-perm-modal']//span[contains(@class, 'btn-close-perm-modal')]"

# BASE PAGE / Eclipse popup / Duplicate confirm popup
DUPLICATE_JOURNEY_CONFIRM_POPUP_YES_BUTTON = "(//div[@class='modal-dialog']//button[contains(@class,'ok-btn')])[last()]"

# BASE PAGE / Create New Candidate Journey Popup
NEW_JOURNEY_TYPE_POPUP_CANDIDATE_JOURNEY_TYPE = "//div[contains(@class,'candidate-journey')]//*"
NEW_JOURNEY_TYPE_POPUP_TALENT_COMMUNITY_JOURNEY_TYPE = "//div[contains(@class,'talent-community-journey')]//*"
NEW_JOURNEY_TYPE_POPUP_NEXT_BUTTON = "//button[contains(@class,'btn-select-journey-type')]"
NEW_JOURNEY_TYPE_POPUP_CANCEL_BUTTON = "//button[contains(@class,'btn-cancel-create-journey')]"
NEW_JOURNEY_TYPE_POPUP_REMOVE_ICON= "//span[contains(@class,'icon icon-remove')]"
NEW_JOURNEY_TYPE_POPUP = "//div[contains(@class,'modal-content printable')]//parent::div[contains(@class,'modal-dialog')]"
CANDIDATE_JOURNEY_NAME_TEXT_BOX = "//div[@class='journey-form']//input[@id='name']"
CREATE_NEW_JOURNEY_BUTTON = "//div[@class='journey-form']//button[@class='btn btn-primary btn-save-journey']"
TITLE_JOURNEY_FORM = "//div[contains(@class,'modal-dialog')]//div[contains(@class,'modal-title')]"

# CANDIDATE JOURNEY STAGES
NEW_STAGE_BUTTON = "//button[@class='btn btn-primary btn-create-stage']"
PUBLISH_STAGE_BUTTON = "//button[@class='btn btn-primary btn-publish-stage']"
JOURNEY_ICON_DELETE_STAGE = "//div[contains(@class, 'stage-item') and contains(., '{}')]//i[contains(@class,  'icon-delete2')]"
JOURNEY_ALL_STAGE_NAME = "//span[contains(@class,'title-edit')]/span"
JOURNEY_DELETE_STAGE_CONFIRM_YES_BUTTON = "(//div[@class='modal-dialog']//button[contains(@class,'ok-btn')])[last()]"
JOURNEY_ICON_EDIT_STAGE = "//div[contains(@class, 'stage-item') and contains(., '{}')]//i[contains(@class,  'icon-edit')]"
JOURNEY_ADD_NEXT_STEP_BUTTON = "//div[contains(@class, 'open-next-step-drawer') and contains(text(), 'Add Button')]"
JOURNEY_NEXT_STEP_NAME_BUTTON_INPUT = "//*[@id= 'next-step-drawer-content']//input[contains(@placeholder, 'Button Title')]"
JOURNEY_ADD_NEXT_STEP_DES_INPUT = "//div[@placeholder='Add Next Steps Description']"
JOURNEY_NEXT_STEP_DONE_BUTTON = "//div[contains(@class,'pull-right')]//button[text()='Done']"
JOURNEY_NEXT_STEP_NAME_STATUS_ITEM = "//div[contains(@class, 'status-item')]//div[contains(text(), '{}')]"
JOURNEY_NEXT_STEP_STATUS_ICON_ACCEPTED = "//div[contains(text(), '{}')]//ancestor::div[contains(@class, 'status-item')]//i[contains(@class, 'icon-accepted')]"
JOURNEY_NEXT_STEP_STATUS_ICON_ERASE = "//div[contains(text(), '{}')]//ancestor::div[contains(@class, 'status-item')]//i[contains(@class, 'icon-erase')]"
JOURNEY_NEXT_STEP_ADD_STATUS_ICON = "//div[contains(@class, 'add-status-btn')]//i[contains(@class, 'icon-chevron-down')]"
JOURNEY_NEXT_STEP_SEARCH_STATUS_INPUT = "//*[@id='add-statuses-modal']//input[contains(@placeholder, 'Search')]"
JOURNEY_NEXT_STEP_LIST_RESULT_SEARCH_LABEL = "//div[contains(@class, 'search-list')]//label[contains(text(), '{}')]"
JOURNEY_NEXT_STEP_RESULT_SEARCH_ICON_DROPDOWN = "//div[contains(@class, 'search-list')]//i[contains(@class, 'icon-chevron-down')]"
JOURNEY_NEXT_STEP_MODEL_ALLPY_BUTTON = "//*[@id='add-statuses-modal']//button[contains(text(), 'Apply')]"
JOURNEY_NEXT_STEP_MODEL_ALLPY_CANCEL = "//*[@id='add-statuses-modal']//button[contains(text(), 'Cancel')]"
JOURNEY_NEXT_STEP_SAVE_BUTTON = "//*[@id= 'next-step-drawer-content']//div[contains(@class, 'next__step__drawer__footer')]//button[contains(text(), 'Save')]"
JOURNEY_NEXT_STEP_CANCEL_BUTTON = "//*[@id= 'next-step-drawer-content']//div[contains(@class, 'next__step__drawer__footer')]//button[contains(text(), 'Cancel')]"
JOURNEY_NEXT_STEP_DELETE_STATUS_BUTTON = "//*[@id= 'next-step-drawer-content']//button[contains(text(), 'Delete')]"
JOURNEY_NEXT_STEP_SEND_USER_FORM_TOGGLE = "//div[normalize-space(text())='Send User Form']//parent::div//following-sibling::div//label"
JOURNEY_NEXT_STEP_TOTAL_NUMBER_STATUSES = "//div[(text()='{}')]//ancestor::div[contains(@class, 'statuses-items')]//*[contains(@class, 'bottom-title') and contains(text(), '{}') ]"
JOURNEY_NEXT_STEP_DESCRIPTION = "//div[contains(@placeholder, 'Add Next Steps Description') and contains(text(), '{}')]"
JOURNEY_NEXT_STEP_STATUS_SECTION = "//div[contains(@class, 'title') and (text()='{}')]"
JOURNEY_NEXT_STEP_STATUS_SECTION_CHECKBOX = "//div[contains(@class, 'title') and (text()='{}')]//ancestor::div[contains(@class, 'ddl-status-section')]//span"
JOURNEY_NEXT_STEP_STATUS_SECTION_OF_STAGE_LABEL = "//div[contains(@class, 'title') and (text()='{}')]//ancestor::div[contains(@class, 'ddl-status-section')]//div[contains(@class, 'content show-content')]//label[contains(text(), '{}')]"
JOURNEY_NEXT_STEP_MODEL_TITLE = "//*[contains(@class,'next-step-title')]//*[contains(text(), 'Next Step')]"
JOURNEY_NEXT_STEP_STATUS_NAME = "//div[contains(@class,'open-next-step-drawer')]//*[contains(text(),'{}')]"


# CANDIDATE JOURNEY STAGES / Add New Stage popup
STAGE_NAME_TEXT_BOX = "//div[@class='journey-form']//input[@id='name']"
STAGE_TYPE_DROPDOWN = "//div[@class='journey-form']//div[@data-toggle='dropdown']"
STAGE_TYPE_VALUE = "//div[@class='dropdown-menu stage-dropdown-menu']//div[@class='item-title' and text()='{}']"
SAVE_STAGE_BUTTON = "//div[@class='journey-form']//button[@class='btn btn-primary btn-save-stage']"
STAGE_NUMBER_ORDER = "//span[contains(text(), '{}')]/ancestor::div[contains(@class, 'info')]/preceding-sibling::div//div"
STAGE_ORDER_BY_NUMBER = "//div[contains(@class, 'order-number') and contains(text(), '{}')]/parent::div/following-sibling::div[contains(@class, 'action')]//i[contains(@class, 'icon icon-reorder')]"
STAGE_NEW_STATUS_BUTTON = "//div[@id='toolbar-action']//span[@class='menu menu-custom']//button[contains(@class,'btn-primary')]"

# CANDIDATE JOURNEYS PAGE / Check UI Default In Journey
CANDIDATE_JOURNEY_TEXT = "//strong[contains(text(),'{}')]//ancestor::div[contains(@class,'cem-row cursor-pt')]//descendant::p[contains(@class,'desc-text')]"
CANDIDATE_JOURNEY_ELLIPSIS_BUTTON = "//strong[contains(text(),'{}')]//ancestor::div[contains(@class,'cem-row cursor-pt')]//descendant::span[contains(@class,'cursor-pt icon icon-menu')]"

# CANDIDATE JOURNEYS PAGE / Check UI Stages
JOURNEY_STAGE_NUMBER_STATUSES_TEXT = "//span[contains(text(),'{}')]//ancestor::div[contains(@class,'info')]//div[contains(@class,'desc')]"

# CANDIDATE JOURNEYS PAGE / Check UI Status Of Stage Journey
JOURNEY_STAGE_STATUS_TITLES   = "//div[contains(@class,'status-inner')]/descendant::div[contains(@class,'title')][{}]"
JOURNEY_STAGE_STATUS_TITLE_BY_NAME   = "//div[contains(@class,'status-inner')]/descendant::div[contains(@class,'title') and contains(text(), '{}') ]"
JOURNEY_STAGE_STATUS_MOVE_ICON   = "//div[contains(text(),'{}')]//ancestor::div[contains(@class,'status-item')]//i[contains(@class,'icon icon-reorder')]"
JOURNEY_STAGE_STATUS_LOCK_ICON   = "//div[contains(text(),'{}')]//ancestor::div[contains(@class,'status-item lock')]"
JOURNEY_STAGE_NEW_STATUS_BUTTON = "//button[contains(@class,'btn btn-primary btn-create-status')]"

# CANDIDATE JOURNEYS PAGE / Check UI Next Step In All Statuses
JOURNEY_TOTAL_STAGES = "//div[contains(@class,'stage-item')]"
JOURNEY_STAGE_TOTAL_STATUSES ="//div[contains(@class,'status-item')]//div[contains(@class,'title')]"
JOURNEY_STAGE_NAME = "//div[contains(@class,'stage-item')][{}]"
JOURNEY_STAGE_STATUS_ACTION_NEEDED_LABEL = "//div[contains(@class,'next-step-container')]//div[contains(@class,'text-right')]//*[contains(@class,'toggle-btn large hide-text')]"

