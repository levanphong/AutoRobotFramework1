# BASE PAGE / Location Tree
AREA_NAME_TEXT = "//label[@class='icon area fetched dropup']//span[contains(text(),'{}')]"
ADD_AREA_OR_LOCATION_ICON = "//div[@id='location_management']//span[contains(text(),'{}')]//following-sibling::i[@class='icon-plus add_item']"
ADD_MORE_ITEM_BUTTON = "//div[@class='popover add-item right in']//*[contains(text(),'{}')]"
INPUT_SEARCH_LOCATION = "id:filter-input"
LOCATION_NAME_TAB = "//div[contains(@class, 'ai-handle')]//span[contains(text(), '{}')]"
INPUT_USER_VIEW = "//form[contains(@id, 'location_form')]//label[contains(text(), 'These users can view')]/following-sibling::input"
USER_SUGGEST = "//div[contains(@class, 'OlivAC-suggestions mCustomScrollbar') and not(contains(@style,'display: none'))]//*[contains(text(),'{}')]"
LOCATION_SUGGEST_AFTER_SEARCH = "//span[text()='{}' and contains(@class,'text')]"
LOCATION_SEARCH_RESULT_BLOCK = "//div[contains(@class,'nested-sortable location-management')]"
ALL_LOCATION_NAME = "//label[contains(@class,'location')]//span[@data-jobloc-id]"
LOCATION_PATTERN_NAME = "//label[contains(@class, 'location')]//span[contains(text(), '{}')]"
# BASE PAGE/ BUTTON ACTIONS
LOCATION_PAGE_DELETE_BTN = "//form[contains(@id, 'location_form')]//button[contains(@id, 'btnRemove')]"

# BASE PAGE / Add new Location Form
ADD_NEW_LOCATION_NAME_TEXT_BOX = "//input[@id='id_name']"
ADD_NEW_AREA_NAME_TEXT_BOX = "(//input[@id='id_area_name'])[last()]"
LOCATION_ID_TEXTBOX = "//input[@id='id_job_loc_code']"
ADDRESS_1_TEXTBOX = "//input[@id='id_addr_1']"
ADDRESS_2_TEXTBOX = "//input[@id='id_addr_2']"
CITY_TEXTBOX = "//input[@id='id_city']"
STATE_SELECT_DROPDOWN = "//select[@name='admin1_code']"
STATE_OPTION_BY_NAME = "//option[contains(text(),'{}')]"
ZIPCODE_TEXTBOX = "//input[@id='id_zip_code']"
LOCATION_EMAIL_TEXTBOX = "//input[@id='id_location_email_address']"
LOCATION_PHONE_TEXTBOX = "//input[@id='id_location_phone_number']"
ADD_NEW_LOCATION_SAVE_BUTTON = "//div[@class='col-detail clearfix card-content ']//button[@class='btn btn-primary btn-save pull-right']"
LOCATION_ADD_USER_TEXTBOX = "(//input[@id='location_users'])[last()]"
LOCATION_USER_NAME_TEXT = "//div[contains(@class,'info')]//div[contains(@class,'title') and contains(text(),'{}')]"

# BASE PAGE / Location Attribute section
INPUT_SEARCH_ATTRIBUTE = "//input[contains(@placeholder,'Search for Attribute')]"
BOX_ATTRIBUTE = "//*[contains(@class,'box-attr')]"
LABEL_ATTRIBUTE = "//*[contains(@class,'label-attr') and contains(text(),'{}')]"
VALUE_ATTRIBUTE = "//*[contains(@class,'value-attr') and contains(text(),'{}')]"
EDIT_LOCATION_ATTRIBUTE_ICON = "//p[@class='label-attr' and contains(text(),'{}')]//following-sibling::span//i"

# BASE PAGE / Edit Location Form
LOCATION_FORM_SAVE_BUTTON = "//form[contains(@id, 'location_form')]//button[contains(text(), 'Save') and contains(@class, 'btn btn-primary btn-save pull-right')]"

# BASE PAGE / Edit Location Form / Edit Location Attribute Widget
ATTRIBUTE_NAME_TEXT_BOX = "//label[contains(text(),'Attribute Name')]/following-sibling::input"
ATTRIBUTE_KEY_TEXT_BOX = "//label[contains(text(),'Attribute Key')]/following-sibling::input"
ATTRIBUTE_DESCRIPTION_TEXT_BOX = "//label[contains(text(),'Attribute Description')]/following-sibling::input"
ATTRIBUTE_VALUE_TEXT_BOX = "//input[@placeholder='Enter attribute Value']"
EDIT_LOCATION_ATTRIBUTE_SAVE_BUTTON = "//div[contains(@id, 'location-attribute-drawer')]//button[contains(text(), 'Save')]"
EDIT_LOCATION_ATTRIBUTE_CANCEL_BUTTON = "//div[contains(@id, 'location-attribute-drawer')]//button[contains(text(), 'Cancel')]"
SHORTCODE_KEYWORD = "//span[contains(@class,'shortcode-keyword')]"

# Add room location
ROOM_NAME_TEXTBOX = "//input[@id='job-loc-room' and contains(@placeholder,'i.e. Main Conference Room')]"
SEATS_ROOM_TEXTBOX = "//input[@id='job-loc-seat' and contains(@placeholder,'i.e. 12')]"
ADD_ROOM_BUTTON = "//button[@id='btn-add-room']"
