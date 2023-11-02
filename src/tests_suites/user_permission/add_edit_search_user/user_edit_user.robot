*** Settings ***
Resource            ../user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check editing shows user tab correctly (OL-T16908)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    Input into  ${SEARCH_USER_TEXT_BOX}  ${test_user_name}
    Hover at  ${test_user_name}
    Click at  ${USER_ECLIPSE_ICON}
    Check element display on screen  ${USER_ECLIPSE_MENU_DEACTIVATE_BUTTON}
    Check element display on screen  ${USER_ECLIPSE_MENU_EDIT_BUTTON}
    Click at  ${USER_ECLIPSE_MENU_EDIT_BUTTON}
    Check element display on screen  ${test_user_name}
    Capture page screenshot


Check edit First Name (OL-T16909, OL-T16910, OL-T16911, OL-T16912, OL-T16913, OL-T16914, OL-T16915, OL-T16916)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${user_fname}
    Click at  ${USER_ECLIPSE_ICON}
    Click at  ${USER_ECLIPSE_MENU_EDIT_BUTTON}
    # Edit user details to new value
    ${user_new_fname} =   Generate random name only text  fname
    ${user_new_lname} =   Generate random name only text  lname
    ${user_new_job} =   Generate random name only text  job
    ${user_new_email} =   Generate random name  email@paradox.ai
    ${user_new_employee_id} =   Generate random name only text  employee_id
    ${user_new_country} =   Set variable     Canada
    ${user_new_role} =   Set variable     Full User - Edit Everything
    Input into  ${USER_DETAIL_EDIT_FORM_FNAME_TEXT_BOX}  ${user_new_fname}
    Input into  ${USER_DETAIL_EDIT_FORM_LNAME_TEXT_BOX}  ${user_new_lname}
    Input into  ${USER_DETAIL_EDIT_FORM_JOB_TEXT_BOX}  ${user_new_job}
    Input into  ${USER_DETAIL_EDIT_FORM_EMAIL_TEXT_BOX}  ${user_new_email}
    Input into  ${USER_DETAIL_EDIT_FORM_EMPLOYEE_ID_TEXT_BOX}  ${user_new_employee_id}
    Click at  ${USER_DETAIL_EDIT_FORM_COUNTRY_DROPDOWN}
    Click by JS  ${ADD_NEW_USER_COUNTRY_DROPDOWN_VALUE}  ${user_new_country}
    Click at  ${USER_DETAIL_EDIT_FORM_USER_ROLE_DROPDOWN}
    Click by JS  ${ADD_NEW_USER_ROLE_DROPDOWN_VALUE}  ${user_new_role}
    Capture page screenshot
    Click at  ${USER_DETAIL_EDIT_FORM_SAVE_BUTTON}
    Click at  ${UPDATE_USER_DETAILS_POPUP_CONFIRM_BUTTON}
    # Check edited value
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_new_fname}
    Hover at  ${user_new_fname}
    Click at  ${USER_ECLIPSE_ICON}
    Click at  ${USER_ECLIPSE_MENU_EDIT_BUTTON}
    Verify display text with get text value  ${USER_DETAIL_EDIT_FORM_FNAME_TEXT_BOX}  ${user_new_fname}
    Verify display text with get text value  ${USER_DETAIL_EDIT_FORM_LNAME_TEXT_BOX}  ${user_new_lname}
    Verify display text with get text value  ${USER_DETAIL_EDIT_FORM_JOB_TEXT_BOX}  ${user_new_job}
    Verify display text with get text value  ${USER_DETAIL_EDIT_FORM_EMAIL_TEXT_BOX}  ${user_new_email}
    Verify display text with get text value  ${USER_DETAIL_EDIT_FORM_EMPLOYEE_ID_TEXT_BOX}  ${user_new_employee_id}
    Click at  ${USER_DETAIL_EDIT_FORM_COUNTRY_DROPDOWN}
    Verify display text  ${USER_DETAIL_EDIT_FORM_COUNTRY_DROPDOWN_VALUE_SELECTED}   ${user_new_country}
    Simulate Input  None  ESC
    Click at  ${USER_DETAIL_EDIT_FORM_USER_ROLE_DROPDOWN}
    Check element display on screen  ${ADD_NEW_USER_ROLE_DROPDOWN_VALUE}   ${user_new_role}
    Simulate Input  None  ESC
    Capture page screenshot
    Click at  ${USER_DETAIL_EDIT_FORM_CANCEL_BUTTON}
    Deactivate a User   ${user_new_fname}


Check Click Save button but select Cancel (OL-T16917, OL-T16918, OL-T16919)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${user_fname}
    Click at  ${USER_ECLIPSE_ICON}
    Click at  ${USER_ECLIPSE_MENU_EDIT_BUTTON}
    # Edit user details to new value
    ${user_new_role} =   Set variable     Full User - Edit Everything
    Click at  ${USER_DETAIL_EDIT_FORM_USER_ROLE_DROPDOWN}
    Click by JS  ${ADD_NEW_USER_ROLE_DROPDOWN_VALUE}  ${user_new_role}
    Capture page screenshot
    Click at  ${USER_DETAIL_EDIT_FORM_SAVE_BUTTON}
    Click at  ${UPDATE_USER_DETAILS_POPUP_CANCEL_BUTTON}
    Check element not display on screen  ${UPDATE_USER_DETAILS_POPUP_CANCEL_BUTTON}
    Capture page screenshot
    Click at  ${USER_DETAIL_EDIT_FORM_CANCEL_BUTTON}
    Click at  ${UNSAVED_CHANGES_POPUP_KEEP_BUTTON}
    Capture page screenshot
    Deactivate a User   ${user_fname}
