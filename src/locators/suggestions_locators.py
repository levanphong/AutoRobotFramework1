# BASE PAGE
SUGGESTION_NAME_IN_LIST = "//div[@id='suggestions']//div[contains(@class,'suggestion-name') and contains(text(),'{}')]"
SUGGESTION_NAME_TEXT = "//div[@id='suggestions']//div[contains(@class,'suggestion-name')]"
NEW_SUGGESTION_NAME_TEXT_BOX = "//input[@id='id_suggestion']"
NEW_SUGGESTION_ADD_BUTTON = "//button[@class='btn btn-primary']"

# EDIT SUGGESTION DIALOG
SUGGESTION_MESSAGE_TEXT_BOX = "//div[@class='form-control ai-input suggestion-text ai-editor']"
SUGGESTION_TEXT_COMPLETE_ITEM = "//ul[contains(@style,'display: block')]//li[@class='textcomplete-item']//a"
SUGGESTION_SAVE_BUTTON = "//button[contains(@class, 'btn-save') and contains(text(), 'Save')]"
SUGGESTION_REMOVE_BUTTON = "//button[contains(@class,'btn-remove') and contains(text(), 'Remove')]"

# EDIT SUGGESTION DIALOG / Confirm delete suggestion
SUGGESTION_REMOVE_CONFIRM_YES_BUTTON = "//button[contains(@class,'ok-btn') and contains(text() , 'Yes')]"
