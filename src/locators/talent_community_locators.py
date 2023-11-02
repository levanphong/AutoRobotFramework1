# BASE PAGE
TALENT_COMMUNITY_PAGE_ADD_CANDIDATE_BUTTON = "//div[@id='content-header']//button[contains(@class,'primary')]"
TALENT_COMMUNITY_PAGE_SEARCH_CANDIDATE_TEXT_BOX = "(//input[@placeholder='Search'])[last()]"
TALENT_COMMUNITY_PAGE_TITLE = "//aside[contains(@class,'el-aside')]//div[contains(@class,'title')]"
TALENT_COMMUNITY_LEFT_PANEL_TITLES = "//div[contains(@class,'menu')]//div[contains(@class,'nav-text')]"
TALENT_COMMUNITY_LEFT_PANEL_COUNT_LIST = "//div[contains(@class,'menu')]//a[contains(text(), '')]//div//following-sibling::div[last()]"
TALENT_COMMUNITY_PAGE_COLUMN_TEXT = "//table[@class='el-table__header']//div[contains(text(), '')]"
TALENT_COMMUNITY_TABLE_ROW_NAME = "//table//span[@class='text-truncate']"
TALENT_COMMUNITY_PAGE_CANDIDATE_NUMBER = "//div[@id='content-header']//following::div//label[contains(@class, 'text')]"
TALENT_COMMUNITY_PAGE_FIRST_ROW_NAME = "(//tr[contains(@Class,'el-table__row')])[1]//span"
TALENT_COMMUNITY_PAGE_ICON_REMOVE = "//div[@id='candidate-detail-header']//child::div//span[@class='icon icon-remove']"
TALENT_COMMUNITY_PAGE_TABLE = "//div[contains(@class,'el-table__body-wrapper')]"
TALENT_COMMUNITY_PAGE_FILTER_ICON = "//div[@data-testid='candidate_btn_filter']"
TALENT_COMMUNITY_PAGE_COLUMN_NAME = "//tbody//tr[contains(@class,'el-table__row')]//td//span[contains(@class,'text-overflow') and text()='{}']"
TALENT_CANDIDATE_PAGE_TABLE_ROW = "//table[contains(@class,'el-table__body')]/tbody/tr"
TALENT_CANDIDATE_PAGE_REMOVE_SEARCH_ICON = "//div[contains(@class,'el-input el-input')]//span[contains(@class,'el-input__suffix')]"
TALENT_COMMUNITY_TABLE_ROW_CANDIDATE_NAME = "//span[contains(@class,'text-truncate') and contains(text(),'{}')]//ancestor::tr[contains(@class,'el-table__row')]"
TALENT_COMMUNITY_PAGE_TABLE_ROW = "//table[contains(@class,'el-table__body')]/tbody/tr"
TALENT_COMMUNITY_PAGE_NUMBER_CANDIDATE_HEADER_LABEL = "//div[@id='content-header']//following-sibling::div/label[contains(@class,'text')]"
TALENT_CANDIDATE_PAGE_SEARCH = "//div[@id='content-header']//following-sibling::div//input[@placeholder='Search']"

# BASE PAGE / Add New Candidate form
TALENT_CANDIDATE_FIRST_NAME_TEXT_BOX = "//input[@data-testid='cem_input_firstname']"
TALENT_CANDIDATE_LAST_NAME_TEXT_BOX = "//input[@data-testid='cem_input_lastname']"
TALENT_CANDIDATE_EMAIL_TEXT_BOX = "//input[@data-testid='cem_input_email']"
TALENT_CANDIDATE_ADD_CANDIDATE_BUTTON = "(//section[@class='el-drawer__body']//button[contains(@class,'el-button--primary')])[last()]"
TALENT_CANDIDATE_ADD_LOCATION_DROPDOWN = "//span[contains(@class,'el-popover')]//span[contains(@class,'el-input__suffix')]//span"
TALENT_CANDIDATE_ADD_GROUP_DROPDOWN = "//span[@class='el-popover__reference-wrapper']//div[@data-testid='btn_show_menu']//i"
TALENT_CANDIDATE_ADD_LOCATION_SEARCH = "//div[contains(@class,'el-select-location')]//div[contains(@class,'el-input el-input')]//input[@class='el-input__inner' and @placeholder='Search for Locations']"
TALENT_CANDIDATE_ADD_GROUP_SEARCH = "(//div[@data-testid='input_search']//input[@class='el-input__inner'])[last()]"
TALENT_CANDIDATE_SELECT_LOCATION = "//*[contains(@class,'has-check-icon')]//span[normalize-space()='{}']"
TALENT_CANDIDATE_SELECT_GROUP = "//div[@data-testid='lbl_title' and normalize-space()='{}']"
TALENT_COMMUNITY_ADD_RESUME_INPUT = "//input[contains(@type,'file') and contains(@class,'dz-hidden-input')]"
TALENT_COMMUNITY_ADD_NOTE_INPUT = "//div[(@data-testid='cem_input_note') and (@contenteditable='true')]"
TALENT_COMMUNITY_ADD_NOTE_BUTTON = "//button[@data-testid='cem_btn_add_note']"
TALENT_COMMUNITY_REMOVE_ADD_ICON = "//div[@id='candidate-detail-header']//span[contains(@class,'icon-remove')]"

# BASE PAGE / Candidate Profile
TALENT_CANDIDATE_PROFILE_MORE_BUTTON = "//button[@data-testid='btn_candidate_more']"
TALENT_CANDIDATE_PROFILE_MORE_MENU_ITEM = "(//ul[contains(@id,'dropdown-menu')])[last()]//div[@class='el-scrollbar']//div[@class='el-scrollbar__view']//div[2]//div[contains(text(),'{}')]"
TALENT_CANDIDATE_PROFILE_REMOVE = "//div[@id='candidate-detail-header']//span[@class='icon icon-remove']"
TALENT_CANDIDATE_PROFILE_STATUS_BUTTON = "//div[contains(@class,'el-dropdown')]//button[@data-testid='candidate_btn_journeys']"
TALENT_CANDIDATE_PROFILE_STAGE = "//div[contains(@id,'el-collapse-head')]//div[contains(text(),'{}')]"
TALENT_CANDIDATE_PROFILE_STATUS_NAME = "//div[contains(@id,'el-collapse-content')]//div[contains(@class,'el-collapse-item__content')]//li[contains(text(),'{}')]"
TALENT_CANDIDATE_CONFIRM_STATUS = "//div[@class='el-message-box__btns']//button[contains(@class,'el-button el-button--default el-button--primary')]"

#BASE PAGE/ FILTER YOUR TALENT COMMUNITY
TALENT_COMMUNITY_FILTER_CANDIDATE_BUTTON = "//div[@data-testid='candidate_btn_filter']"
TALENT_COMMUNITY_FILTER_APPLY_BUTTON = "//button[@data-testid='cem_filter_btn_apply']"
TALENT_COMMUNITY_FILTER_CLOSE_MODAL_ICON = "(//div[contains(@aria-label, 'dialog')]//i[contains(@class,'el-dialog__close el-icon')])[last()]"
TALENT_COMMUNITY_FILTER_CANCEL_BUTTON = "//button[@data-testid='cem_filter_btn_cancel']"
TALENT_COMMUNITY_FILTER_GROUP = "//*[@data-testid = 'cem_filter_group_lbl_title']"
TALENT_COMMUNITY_FILTER_GROUP_SELECT = "//span[contains(@class,'el-checkbox__label')]//ancestor::strong[contains(text(),'{}')]"
TALENT_CANDIDATE_SELECT_GROUP_NAME = "//div[contains(@class,'info-filter ')]//child::div//span[contains(text(),'{}')]//ancestor::span//preceding::span[1]//ancestor::span[@class='el-checkbox__input']"
TALENT_COMMUNITY_FILTER_LOCATION = "//*[@data-testid = 'cem_filter_location_lbl_title']"
TALENT_COMMUNITY_FILTER_LOCATION_NAME = "//div[contains(@class,'el-select-tree__item')]//*[contains(text(),'{}')]//ancestor::span//preceding::span[1]//ancestor::span[@class='el-checkbox__input']"
TALENT_COMMUNITY_FILTER_SOURCE = "//*[@data-testid='cem_filter_source_lbl_title']"
TALENT_COMMUNITY_FILTER_SOURCE_NAME = "//div[contains(@class,'filter-source')]//*[contains(text(),'{}')]//ancestor::span//preceding::span[1]//ancestor::span[@class='el-checkbox__input']"
TALENT_COMMUNITY_FILTER_CANDIDATE = "//div[contains(@class, 'footer')]//child::span[contains(text(),'match')]"
TALENT_COMMUNITY_FILTER_LOCATION_NAME_TEXT = "(//div[@class='el-select-tree__item']//child::span)[4]"
TALENT_COMMUNITY_FILTER_ADD_SEGMENT_BUTTON = "(//span[contains(text(),'Save Segment')]//ancestor::button[contains(@class,'el-button')])[last()]"
TALENT_COMMUNITY_FILTER_TALENT_COMMUNITY_STAGE = "//span[@data-testid='cem_filter_status_lbl_title']"
TALENT_COMMUNITY_FILTER_SEARCH = "//div[contains(@class,'el-input el-input')]//input[contains(@placeholder,'{}')]"
TALENT_COMMUNITY_FILTER_SEARCH_SATUS_NAME = "//div[contains(@class,'el-tree-node__content')]//span[contains(text(),'{}')]//ancestor::span//preceding::span[1]//ancestor::span[@class='el-checkbox__input']"
TALENT_COMMUNITY_FILTER_USER_SELECT = "//span[contains(@class,'el-checkbox__label')]//ancestor::strong[contains(text(),'{}')]"
TALENT_COMMUNITY_FILTER_COUNT_CANDIDATE = "//button[contains(@class,'el-button')]//preceding-sibling::span[contains(text(),'match') and contains(text(),'candidate')]"
TALENT_COMMUNITY_FILTER_SEARCH_USER_TEXT_BOX = "//div[contains(@class,'el-dialog__body')]//*[contains(@class,'el-input__inner')]"
TALENT_COMMUNITY_FILTER_SCHEDULED_STATUS_BY_TAB = "//*[@data-testid='cem_filter_schedulingstatus_lbl_title']//parent::div"
TALENT_COMMUNITY_FILTER_RESUME_BY_TAB = "//span[@data-testid='cem_filter_includeresume_lbl_title']//parent::div"
TALENT_COMMUNITY_FILTER_SCHEDULED_STATUS_SELECT = "//span[contains(@class,'el-checkbox__label')]//ancestor::span[contains(text(),'{}')]"
TALENT_COMMUNITY_FILTER_NOTE_BY_TAB = "//span[@data-testid='cem_filter_noteadded_by_lbl_title']//parent::div"

#BASE PAGE/ FILTER RESUME BY TAB
TALENT_COMMUNITY_FILTER_RESUME_CHECKBOX = "//span[contains(text(),'{}')]//ancestor::span[contains(@class,'el-checkbox__label')]//preceding-sibling::span[contains(@class,'el-checkbox__input')]"

#BASE PAGE/ FILTER ATTENDEE BY
TALENT_COMMUNITY_FILTER_SEARCH_USER_TEXT_BOX = "//div[contains(@class,'el-dialog__body')]//*[contains(@class,'el-input__inner')]"
TALENT_COMMUNITY_FILTER_ATTENDEE_BY = "//*[@data-testid='cem_filter_attendeename_lbl_title']//parent::div"
TALENT_COMMUNITY_FILTER_USER_CHECK_BOX="//div[contains(@class,'el-checkbox-group')]//*[contains(text(),'{}')]//ancestor::label//*[contains(@class,'el-checkbox__inner')]"

#BASE PAGE/ FILTER CONTACTED BY
TALENT_COMMUNITY_FILTER_CONTACTED_BY = "//*[@data-testid='cem_filter_contactby_lbl_title']//parent::div"

#BASE PAGE/ FILTER SCHEDULED BY
TALENT_COMMUNITY_FILTER_SCHEDULED_BY = "//*[@data-testid='cem_filter_scheduledby_lbl_title']//parent::div"

#BASE PAGE/ FILTER START KEYWORD
TALENT_COMMUNITY_FILTER_START_KEYWORD = "//*[@data-testid='cem_filter_startkeyword_lbl_title']//parent::div"

#BASE PAGE / SEGMENT
TALENT_COMMUNITY_SEGMENT_NAME_INPUT = "//div[contains(@class,'el-input')]/input[contains(@placeholder,'Name your segment')]"
TALENT_COMMUNITY_SEGMENT_SAVE_BUTTON = "(//button//child::span[contains(text(),'Save')])[last()]"
TALENT_COMMUNITY_SEGMENT_ASSIGN_INPUT = "//label[text()='Assign Segment']//following-sibling::div//input"
TALENT_COMMUNITY_SEGMENT_SELECT_OPTION_BUTTON = "//div[@parent-title='{}']//button[contains(@class,'el-button')]"
TALENT_COMMUNITY_SEGMENT_DELETE_SELECT = "(//*[contains(text(), 'Delete')])[last()]//ancestor::li[contains(@class,'menu')]"
TALENT_COMMUNITY_SEGMENT_DELETE_BUTTON = "(//span[contains(text(),'Delete')]//parent::button[contains(@class,'el-button')])[last()]"

