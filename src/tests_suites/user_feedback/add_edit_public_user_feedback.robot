*** Settings ***
Resource            ../../pages/user_feedback_page.robot
Resource            ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    test

*** Variables ***
@{list_delivery_frequency}      Send once    Send daily    Send weekly    Send every 2 weeks    Send monthly
@{option_condition}             Time since user created    Time of user logins    Number of interviews scheduled    Candidate status updated
@{option_menu_active}           Deactivate campaign    Duplicated as inactive    View details
@{option_menu_inactive}         Activate campaign    Delete campaign    Duplicated as inactive    View details

*** Test Cases ***
UI when user creates a new campaign (OL-T1147)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    Click At                ${USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_HEADER_BUTTON}
    Check ui for new campaign page display
    Capture page screenshot


User is able to select a Rating builder and update template (OL-T1152)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    Click At                ${USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_HEADER_BUTTON}
    Add Title and Audience step
    when Select rating builder from the dropdown list
    then Element Should Be Visible                  ${USER_FEEDBACK_CAMPAIGN_CHANEL_OLIVIA_ASSIST_SELECT}
    when Click At           ${USER_FEEDBACK_CAMPAIGN_CHANEL_EMAIL_SELECT}
    Page Should Contain     Email Subject
    Check Element Display On Screen                 ${USER_FEEDBACK_CAMPAIGN_EMAIL_INPUT}
    then Check Email Subject field is required
    Capture page screenshot


User selects frequency is Add Date & Time (OL-T1154)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    Click At                ${USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_HEADER_BUTTON}
    Add Title And Audience Step
    Add Content Step
    Click At                ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_AND_DATE_BUTTON}
    Check UI for Frequency when select Add Date & Time
    Select Date, Time and Timezone in Begin or End delivery                 Begin
    FOR     ${delivery_frequence}   IN   @{list_delivery_frequency}
        Select Delivery Frequency                       ${delivery_frequence}
    END
    Capture page screenshot


User selects frequency is Add Condition (OL-T1155)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    Click At                ${USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_HEADER_BUTTON}
    Add Title And Audience Step
    Add Content Step
    Click At                ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_AND_CONDITION_BUTTON}
    Check UI for Frequency when select Add Condition
    Check UI show option when click With the Condition dropdown             @{option_condition}
    FOR     ${option}   IN   @{option_condition}
        Select With the Condition option                ${option}
    END
    Capture page screenshot


User is not able to publish more than 3 campaigns at the same time (OL-T1157)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    Create a new Campaign when already have 3 campaigns are active
    Capture page screenshot


Actions of an active campaign (OL-T1160)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    ${number_campaigns_active}=                     Check number of status of campaigns
    IF    ${number_campaigns_active} == 3
        Select ellipsis menu of an Active Campaign option                       option=Deactivate campaign                      campaign_name=${EMPTY}
    END
    ${campaign_name}=       Create a new Campain with Delivery is Add Date & Time
    Check UI show option when click Ellipsis menu of Campaign               @{option_menu_active}                           campaign_name=${campaign_name}
    FOR     ${option}   IN   @{option_menu_active}
        Select ellipsis menu of an Active Campaign option                       ${option}               campaign_name=${campaign_name}
        IF    '${option}' == 'Deactivate campaign'
            ${campaign_name}=       Create a new Campain with Delivery is Add Date & Time
        END
    END
    Capture page screenshot


Actions of an inactive campaign (OL-T1161)
    Given Setup test
    when Login Into System With Company             ${PARADOX_ADMIN}        ${COMPANY_FRANCHISE_ON}
    when Go To User Feedback Page
    ${number_campaigns_active}=                     Check number of status of campaigns
    IF    ${number_campaigns_active} == 3
        Select ellipsis menu of an Active Campaign option                       option=Deactivate campaign                      campaign_name=${EMPTY}
    END
    ${campaign_name}=       Create a new Campain with Delivery is Add Date & Time                   option=inactive
    Check UI show option when click Ellipsis menu of Campaign               @{option_menu_inactive}                         campaign_name=${campaign_name}                  status=Inactive
    FOR     ${option}   IN   @{option_menu_inactive}
        Select ellipsis menu of an Inactive Campaign option                     ${option}               campaign_name=${campaign_name}
        IF   '${option}' == 'Delete campaign'
            ${campaign_name}=       Create a new Campain with Delivery is Add Date & Time                   option=inactive
        END
    END
    Capture page screenshot
