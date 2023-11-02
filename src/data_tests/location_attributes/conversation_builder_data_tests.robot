*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/conversation_builder_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../pages/web_management_page.robot
Resource            ../../pages/custom_conversation_page.robot
Resource            ../../pages/location_management_page.robot
Variables           ../../constants/ConversationConst.py

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}

*** Variables ***
${la_location_name_single}      Location_LA_single
${la_location_email}            olivia.automation@paradox.ai
${la_location_phone_single}     +12025550159
${la_location_id_single}        123456
${la_address_single}            500 Nguyen Huu Tho Street
${la_state_single}              Alabama
${la_city_single}               New York
${la_country}                   US
${la_zipcode_single}            10005
${la_location_name_multi}       Location_LA_multiple
${la_location_phone_multi}      +12516315555
${la_location_id_multi}         56789
${la_address_multi}             460 Nguyen Huu Tho Street
${la_state_multi}               Alaska
${la_city_multi}                Washington
${la_zipcode_multi}             98093

*** Keywords ***
Prepare locations for conversation builder and outcome
    Prepare locations for conversation builder and outcome with company    ${COMPANY_FRANCHISE_ON}

Prepare locations for conversation builder and outcome with company
    [Arguments]    ${company}
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${company}
    Go to Location Management page
    ${is_existed} =    Run Keyword and Return Status    Check element display on screen    ${la_location_name_single}
    IF    '${is_existed}' == 'False'
        Hover at    ${AREA_NAME_TEXT}    ${company}
        Click at    ${ADD_AREA_OR_LOCATION_ICON}    ${company}
        Click at    ${ADD_MORE_ITEM_BUTTON}    Add a Location
        Input into    ${ADD_NEW_LOCATION_NAME_TEXT_BOX}    ${la_location_name_single}
        Input into    ${LOCATION_ID_TEXTBOX}    ${la_location_id_single}
        Input into    ${ADDRESS_1_TEXTBOX}    ${la_address_single}
        Input into    ${CITY_TEXTBOX}    ${la_city_single}
        Select state value    ${la_state_single}
        Input into    ${ZIPCODE_TEXTBOX}    ${la_zipcode_single}
        Input into    ${LOCATION_EMAIL_TEXTBOX}    ${la_location_email}
        Input into    ${LOCATION_PHONE_TEXTBOX}    ${la_location_phone_single}
        Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}
    END
    Assign user to location    ${la_location_name_single}    ${CA_TEAM}
    Go to Location Management page
    ${is_existed} =    Run Keyword and Return Status    Check element display on screen    ${la_location_name_multi}
    IF    '${is_existed}' == 'False'
        Hover at    ${AREA_NAME_TEXT}    ${company}
        Click at    ${ADD_AREA_OR_LOCATION_ICON}    ${company}
        Click at    ${ADD_MORE_ITEM_BUTTON}    Add a Location
        Input into    ${ADD_NEW_LOCATION_NAME_TEXT_BOX}    ${la_location_name_multi}
        Input into    ${LOCATION_ID_TEXTBOX}    ${la_location_id_multi}
        Input into    ${ADDRESS_1_TEXTBOX}    ${la_address_multi}
        Input into    ${CITY_TEXTBOX}    ${la_city_multi}
        Select state value    ${la_state_multi}
        Input into    ${ZIPCODE_TEXTBOX}    ${la_zipcode_multi}
        Input into    ${LOCATION_EMAIL_TEXTBOX}    ${la_location_email}
        Input into    ${LOCATION_PHONE_TEXTBOX}    ${la_location_phone_multi}
        Click at    ${ADD_NEW_LOCATION_SAVE_BUTTON}
    END
    Assign user to location   ${la_location_name_multi}     ${CA_TEAM}

*** Test Cases ***
Prepare locations data test for conversation builder and outcome for Suite
   Prepare locations for conversation builder and outcome
