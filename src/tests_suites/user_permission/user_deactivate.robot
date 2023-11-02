*** Settings ***
Resource            ./user_permission_common_keywords.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Test Cases ***
Check Deactivate user (OL-T16920, OL-T23938)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    &{email_info} =    Get email for testing
    ${email_address} =  Set variable    ${email_info.email}
    ${user_fname} =     Add a User  email_address=${email_address}
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Check element display on screen  ${user_fname}
    Capture page screenshot
    # Switch to other company and add same user
    Switch to Company v1  ${COMPANY_FRANCHISE_OFF}
    Add a User  fname=${user_fname}     email_address=${email_address}
    Check element display on screen  ${user_fname}
    Capture page screenshot
    # Deactivate User in Company 2
    Deactivate a User   ${user_fname}
    Click at  ${USERS_NAVIGATION_ROLE}  Inactive Users
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${user_fname}
    Capture page screenshot
    # Switch to the first company  and check is not deactivate in Company 1
    Switch to Company v1  ${COMPANY_HIRE_OFF}
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Check element not display on screen  ${user_fname}
    Capture page screenshot
    # Deactivate User
    Click at  ${USERS_NAVIGATION_ROLE}  All Active Users
    Deactivate a User   ${user_fname}


Check cancel Deactivate user (OL-T16921)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_HIRE_OFF}
    Go to Users, Roles, Permissions page
    ${user_fname} =     Add a User
    Click at  ${USERS_NAVIGATION_ROLE}  Active User
    Capture page screenshot
    Input into  ${SEARCH_USER_TEXT_BOX}  ${user_fname}
    Hover at  ${user_fname}
    ${is_clicked} =     Run keyword and return status    Click at  ${USER_ECLIPSE_ICON}
    IF  '${is_clicked}' == 'False'
        Hover at  ${user_fname}
        Click at  ${USER_ECLIPSE_ICON}
    END
    Click at  ${USER_ECLIPSE_MENU_DEACTIVATE_BUTTON}
    Click at  ${DEACTIVATE_USER_CANCEL_BUTTON}
    Check element display on screen  ${user_fname}
    Capture page screenshot
    Deactivate a User   ${user_fname}
