*** Settings ***
Resource        ./base_page.robot
Variables       ../locators/employer_tax_information_locators.py

*** Variables ***
&{employer_tax_information}     employer_name=Paradox Inice New    person_name=Paradox Olivia    telephone_number=4809292842    street_address=3052 College Park Drive
...                             suite_room=110001    city=CONROE    state=Texas    zip_code=77384-8002    fei_number=32-1546574    state_tax=TEXAS    location=Florida
&{employer_tax_information_2}   employer_name=Paradox Inice New 2    person_name=Paradox Olivia    telephone_number=4809292842    street_address=3052 College Park Drive 2
...                             suite_room=110002    city=CONROE    state=Texas    zip_code=77384-8002    fei_number=32-1546574    state_tax=TEXAS    location=Remote

*** Keywords ***
Input valid information for Employer Information tab
    Click at        Employer Information
    ${employer_name}=       Generate candidate name
    Input into      ${EMPLOYER_TAX_INFO_EMPLOYER_NAME_TEXTBOX}      ${employer_name.full_name}
    Input into      ${EMPLOYER_TAX_INFO_FULL_NAME_TEXTBOX}      ${employer_name.full_name}
    Input into      ${EMPLOYER_TAX_INFO_PHONE_NUMBER_TEXTBOX}        4805695415
    Input into      ${EMPLOYER_TAX_INFO_STREET_ADDRESS_TEXTBOX}       Nguyen Huu Tho
    Input into      ${EMPLOYER_TAX_INFO_SUITE_ROOM_TEXTBOX}       460
    Input into      ${EMPLOYER_TAX_INFO_CITY_TEXTBOX}       Da Nang
    Select state dropdown and input zipcode     Alaska      98093
    Input into      ${EMPLOYER_TAX_INFO_FEI_NUMBER_TEXTBOX}      98-7654321
    Input into      ${EMPLOYER_TAX_INFO_STATE_TAX_TEXTBOX}       98-7654321
    [Return]        ${employer_name.full_name}

Select location for Assigned Location tab
    [Arguments]     ${location}
    Click at        Assigned Location
    Input into      ${EMPLOYER_TAX_INFO_SEARCH_FOR_LOCATION_TEXTBOX}    ${location}
    Click at        ${EMPLOYER_TAX_INFO_LOCATION_CHECKBOX}      ${location}
    Click at        ${ADD_EMPLOYER_MODAL_APPLY_BUTTON}

Select state dropdown and input zipcode
    [Arguments]     ${state}        ${zipcode}
    Click at        ${EMPLOYER_TAX_INFO_STATE_DROPDOWN}
    Select from list by label       ${EMPLOYER_TAX_INFO_STATE_DROPDOWN}     ${state}
    Input into      ${EMPLOYER_TAX_INFO_ZIPCODE_TEXTBOX}    ${zipcode}

Delete employer tax information
    [Arguments]     ${employer_name}
    Input into      ${EMPLOYER_TAX_INFO_SEARCH_EMPLOYER_TEXTBOX}    ${employer_name}
    wait for page load successfully v1
    Click at        ${EMPLOYER_TAX_INFO_MENU_ICON_BY_NAME}      ${employer_name}
    Click at        ${EMPLOYER_TAX_INFO_DELETE_ICON}
    Click at        ${EMPLOYER_TAX_INFO_CONFIRM_DELETE_BUTTON}
    Check element display on screen     ${EMPLOYER_TAX_INFO_SUCCESS_MESSAGE}    Employer has been deleted
    Wait for element disappear      ${EMPLOYER_TAX_INFO_SUCCESS_MESSAGE}    Employer has been deleted

Add new employer tax information
    [Arguments]     &{employer_tax_information}
    ${is_clicked}=     Run Keyword And Return Status    Check element display on screen  ${EMPLOYER_TAX_INFO_ADD_NEW_EMPLOYER_BUTTON}   wait_time=2s
    IF  '${is_clicked}' == 'True'
        Click at    ${EMPLOYER_TAX_INFO_ADD_NEW_EMPLOYER_BUTTON}
    ELSE
        Click at    Add New Employer
    END
    Input into      ${EMPLOYER_TAX_INFO_EMPLOYER_NAME_TEXTBOX}      ${employer_tax_information.employer_name}
    Input into      ${EMPLOYER_TAX_INFO_FULL_NAME_TEXTBOX}      ${employer_tax_information.person_name}
    Input into      ${EMPLOYER_TAX_INFO_PHONE_NUMBER_TEXTBOX}      ${employer_tax_information.telephone_number}
    Input into      ${EMPLOYER_TAX_INFO_STREET_ADDRESS_TEXTBOX}      ${employer_tax_information.street_address}
    Input into      ${EMPLOYER_TAX_INFO_SUITE_ROOM_TEXTBOX}      ${employer_tax_information.suite_room}
    Input into      ${EMPLOYER_TAX_INFO_CITY_TEXTBOX}      ${employer_tax_information.city}
    Select state dropdown and input zipcode     ${employer_tax_information.state}       ${employer_tax_information.zip_code}
    Input into      ${EMPLOYER_TAX_INFO_FEI_NUMBER_TEXTBOX}      ${employer_tax_information.fei_number}
    Input into      ${EMPLOYER_TAX_INFO_STATE_TAX_TEXTBOX}       ${employer_tax_information.state_tax}
    Click at    ${ADD_EMPLOYER_MODAL_ASSIGNED_LOCATION_TAB}
    Click at    ${EMPLOYER_TAX_INFO_ADD_LOCATION_BUTTON}
    Simulate Input      ${EMPLOYER_TAX_INFO_SEARCH_FOR_LOCATION_TEXTBOX}    ${employer_tax_information.location}
    Click at    ${EMPLOYER_TAX_INFO_LOCATION_CHECKBOX}      ${employer_tax_information.location}
    Click at    ${ADD_EMPLOYER_MODAL_APPLY_BUTTON}
    Click at    ${ADD_EMPLOYER_MODAL_SAVE_BUTTON}
    Click at    ${EMPLOYER_TAX_INFO_PUBLISH_BUTTON}
