# Login
GRYPHON_LOGIN_EMAIL_INPUT = "//input[contains(@id, 'Input_Email')]"
GRYPHON_LOGIN_PASSWORD_INPUT = "//input[contains(@id, 'Input_Password')]"
GRYPHON_LOGIN_BUTTON = "//button[contains(text(), 'Log in')]"

# Administration
GRYPHON_ADMINISTRATOR_MENU = "//*[contains(@id, 'mnuAdministration')]"

# Customer
GRYPHON_CUSTOMERS_MENU = "//*[contains(@id, 'mnuCustomers')]"
GRYPHON_CUSTOMERS_SEARCH_INPUT = "//input[contains(@class, 'input-sm') and contains(@type, 'search')]"
GRYPHON_CUSTOMERS_NAME_LABEL = "//table[contains(@id, 'jqCustomer')]//td[(text() = '{}')]"
GRYPHON_CUSTOMERS_INPUT_VALUE = "//input[contains(@value, '{}')]"
GRYPHON_CUSTOMERS_SUB_CUSTOMERS_LIST = "//ul//a[contains(@href, '#customerlist')]"

# Redirect button
GRYPHON_NEXT_BUTTON = "//*[contains(@href, '#next')]"
GRYPHON_CANCEL_BUTTON = "//*[contains(@href, '#cancel')]"
GRYPHON_FINISH_BUTTON = "//*[contains(@href, '#finish')]"

# Section 1
# Name and address
GRYPHON_SECTION1_LAST_NAME_TEXTBOX = "//input[contains(@id, 'Section1_LastName')]"
GRYPHON_SECTION1_FIRST_NAME_TEXTBOX = "//input[contains(@id, 'Section1_FirstName')]"
GRYPHON_SECTION1_MIDDLE_NAME_TEXTBOX = "//input[contains(@id, 'Section1_MiddleInitial')]"
GRYPHON_SECTION1_MAIDEN_NAME_TEXTBOX = "//input[contains(@id, 'Section1_MaidenName')]"
GRYPHON_SECTION1_APT_NUMBER_TEXTBOX = "//input[contains(@id, 'Section1_AptNumber')]"
GRYPHON_SECTION1_ADDRESS1_TEXTBOX = "//input[contains(@id, 'Section1_Address1')]"
GRYPHON_SECTION1_CITY_TEXTBOX = "//input[contains(@id, 'Section1_City')]"
GRYPHON_SECTION1_STATE_CODE_SELECT = "//select[contains(@id, 'S1_StateCode')]"
GRYPHON_SECTION1_ZIPCODE_TEXTBOX = "//input[contains(@id, 'Section1_ZipCode')]"

# SSN and Add'l Info
GRYPHON_SECTION1_SSN_TEXTBOX = "//input[contains(@id, 'Section1_SSN')]"
GRYPHON_SECTION1_CONFIRM_SSN_TEXTBOX = "//input[contains(@id, 'Section1_ConfirmSSN')]"
GRYPHON_SECTION1_BIRTHDATE_TEXTBOX = "//input[contains(@id, 'Section1_BirthDate')]"
GRYPHON_SECTION1_I9_EMAIL_ADDRESS_TEXTBOX = "//input[contains(@id, 'Section1_I9EmailAddress')]"
GRYPHON_SECTION1_I9_PHONE_NUMBER_TEXTBOX = "//input[contains(@id, 'Section1_I9PhoneNumber')]"

# Citizenship Info
GRYPHON_SECTION1_I9_CITIZENSHIP_INFO_OF_UNITED_STATES_BUTTON = "//label[contains(@for, 'cittype_1')]"

# Review and Attest
GRYPHON_SECTION1_GENERATE_SIGNATURE_BUTTON = "//div[contains(@class, 'signature')]//button[contains(text(), 'Generate')]"
