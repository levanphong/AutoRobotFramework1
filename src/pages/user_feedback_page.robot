*** Settings ***
Resource        ../pages/base_page.robot
Variables       ../locators/user_feedback_locators.py

*** Variables ***
@{day_of_week}              sun    mon    tue    wed    thu    fri    sat
@{time_types}               Hours    Days    Weeks    Months
@{status_confirmation}      active    inactive

*** Keywords ***
Check ui for new campaign page display
    Check Span Display       User Feedback -
    Check Span Display    New Feedback Campaign
    @{column_value}=    Create List    Title and Audience    Content    Frequency    Confirmation
    ${columns}=     Get WebElements  ${USER_FEEDBACK_CAMPAIGN_MENU_ITEM}
     FOR    ${column}    IN    @{columns}
        Check Element Existed In List     ${column.text}    ${column_value}
    END
    Check element display on screen     ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    Capture page screenshot

Add Title and Audience step
    [Arguments]    ${campaign_title}=None   ${audience}=Basic User
    IF    '${campaign_title}' == 'None'
        ${campaign_title}=     Generate Random Name     auto_campaign
    END
    Input Into    ${USER_FEEDBACK_CAMPAIGN_TITLE_INPUT}     ${campaign_title}
    Click At    ${USER_FEEDBACK_CAMPAIGN_ADD_RULE_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_SELECT_RULE_CHECKBOX}   ${audience}
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    [Return]    ${campaign_title}

Select rating builder from the dropdown list
    [Arguments]    ${rating_name}=Rating_for_user_feedback
    Click At      ${USER_FEEDBACK_CAMPAIGN_RATING_SELECT}
    Click At   ${USER_FEEDBACK_CAMPAIGN_RATING_OPTION}      ${rating_name}

Check Email Subject field is required
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    ${class}=   Get Element Attribute    ${USER_FEEDBACK_CAMPAIGN_EMAIL}     class
    Should Contain  ${class}    has-error
    Capture page screenshot

Add Content step
    [Arguments]    ${rating_name}=Rating_for_user_feedback      ${input_message}=None   ${email_subject}=None
    Select rating builder from the dropdown list    ${rating_name}
    IF    '${input_message}' == 'None'
        ${input_message}=    Generate Random Text Only
    END
    IF    '${email_subject}' == 'None'
        ${email_subject}=    Get Email For Testing
    END
    Input Into    ${USER_FEEDBACK_CAMPAIGN_MESSAGE_OLIVIA_INPUT}    ${input_message}
    Click At      ${USER_FEEDBACK_CAMPAIGN_CHANEL_EMAIL_SELECT}
    Input Into    ${USER_FEEDBACK_CAMPAIGN_EMAIL_INPUT}     ${email_subject}
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}

Check UI for Frequency when select Add Date & Time
    Check Span Display    Begin delivery
    @{date_times}=    Create List    Date     Time    Timezone
    FOR    ${date_time}    IN      @{date_times}
        Check Element Display On Screen     ${date_time}
    END
    Check Span Display    Delivery frequency
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_DATE_BUTTON}
    Check Element Display On Screen    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DATE_DROPDOWN}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_BUTTON}
    Check Element Display On Screen    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIME_DROPDOWN}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIMEZONE_BUTTON}
    Check Element Display On Screen    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIMEZONE_DROPDOWN}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIMEZONE_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_BUTTON}
    Check Element Display On Screen    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_DROPDOWN}
    Capture page screenshot

Select Date, Time and Timezone in Begin or End delivery
    [Arguments]    ${status_delivery}     ${time_select}=07:00    ${timezone_select}=US/Mountain
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_DATE_BUTTON}
    IF  '${status_delivery}' == 'Begin'
        ${date}=    Get Future Day From Curent Date
        Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_BEGIN_SELECT}   ${date}
    ELSE IF  '${status_delivery}' == 'End'
        ${date}=    Get Future Day From Curent Date     5
        Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_END_SELECT}   ${date}
    END
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIME_SELECT}     ${time_select}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIMEZONE_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_TIMEZONE_SELECT}     ${timezone_select}

Select Delivery Frequency
    [Arguments]    ${delivery_frequency}    ${week_select}=None     ${day_of_month}=15
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_SELECT}     ${delivery_frequency}
    ${is_displayed} =     Run keyword and return status     Page Should Contain      ${delivery_frequency}
    IF    '${week_select}' == 'None'
        ${week_select}=     Evaluate    random.choice(@{day_of_week})
    END

    IF    '${is_displayed}' == 'True'
        IF    '${delivery_frequency}' == 'Send daily'
            Check Span Display  End delivery
            Select Date, Time and Timezone in Begin or End delivery   End
        ELSE IF    '${delivery_frequency}' == 'Send weekly'
            Click At Label    ${week_select}
            Select Date, Time and Timezone in Begin or End delivery   End
        ELSE IF    '${delivery_frequency}' == 'Send every 2 weeks'
            Click At Label    ${week_select}
            Select Date, Time and Timezone in Begin or End delivery   End
        ELSE IF    '${delivery_frequency}' == 'Send monthly'
            Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_OF_MONTHLY_SELECT}
            Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_BEGIN_SELECT}    ${day_of_month}
            Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DAY_MONTHLY_ADD_BUTTON}
            Select Date, Time and Timezone in Begin or End delivery   End
        END
    END

Check UI for Frequency when select Add Condition
    Check Span Display    Begin delivery
    Check Element Display On Screen     With the condition
    Check Element Display On Screen     ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_SELECT_DROPDOWN}
    Capture page screenshot

Check UI show option when click With the Condition dropdown
    [Arguments]    @{option_condition}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_SELECT_DROPDOWN}
    FOR     ${option}    IN    @{option_condition}
        Page Should Contain        ${option}
        Capture page screenshot
    END
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_SELECT_DROPDOWN}

Select Number Input and Time Type
    [Arguments]    ${time}=10      ${time_type}=None
    Input Into    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_TIME_INPUT}   ${time}
    IF    '${time_type}' == 'None'
        ${time_type}=     Evaluate    random.choice(@{time_types})
    END
    Capture page screenshot
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_TIME_OPTION}    ${time_type}

Select With the Condition option
    [Arguments]    ${option}    ${time}=10      ${time_type}=None   ${cadidate_journey}=Default Candidate Journey   ${status}=Capture Complete
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_SELECT_DROPDOWN}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_OPTION}    ${option}
    ${is_displayed} =     Run keyword and return status     Page Should Contain      ${option}
    IF    '${is_displayed}' == 'True'
        IF  '${option}' == 'Time since user created'
            Select Number Input and Time Type   ${time}     ${time_type}
        ELSE IF   '${option}' == 'Time of user logins' or '${option}' == 'Number of interviews scheduled'
            Input Into    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_TIME_INPUT}    ${time}
        ELSE IF    '${option}' == 'Candidate status updated'
            Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_CANDIDATE_JOURNEY_AND_STATUS_OPTION}   ${cadidate_journey}
            Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_CONDITION_CANDIDATE_JOURNEY_AND_STATUS_OPTION}   ${status}
        END
    END

Check number of status of campaigns
    [Arguments]    ${status}=Active
    ${USER_FEEDBACK_CAMPAIGN_NUMBER_OF_STATUS}=     Format String   ${USER_FEEDBACK_CAMPAIGN_NUMBER_OF_STATUS}   ${status}
    ${number_of_statuses}=    Get Element Count      ${USER_FEEDBACK_CAMPAIGN_NUMBER_OF_STATUS}
    [Return]      ${number_of_statuses}

Choose option on Confirmation tab when click Save Campaigns
    [Arguments]    ${option}=active
    ${status}=  Run keyword and return status   Check element exist on page    You currently have 3 of 3 active campaigns.
    IF  '${status}' == 'False'
        Click At    ${USER_FEEDBACK_CAMPAIGN_CONFIRMATION_CHOOSE_STATUS_RADIO}  ${option}
    ELSE
        FOR    ${status}    IN   @{status_confirmation}
            Check Element Not Display On Screen    ${USER_FEEDBACK_CAMPAIGN_CONFIRMATION_CHOOSE_STATUS_RADIO}   ${status}
            Capture page screenshot
        END
    END
    Click At    ${USER_FEEDBACK_CAMPAIGN_CONFIRMATION_SAVE_CAMPAIGN_BUTTON}

Create a new Campain with Delivery is Add Date & Time
    [Arguments]    ${campaign_title}=None   ${audience}=Basic User    ${rating_name}=Rating_for_user_feedback    ${input_message}=None   ${email_subject}=None   ${delivery_frequence}=Send once    ${option}=active
    Click At                ${USER_FEEDBACK_PAGE_CREATE_CAMPAIGN_HEADER_BUTTON}
    ${campaign_name}=  Add Title and Audience step     ${campaign_title}   ${audience}
    Add Content step    ${rating_name}   ${input_message}   ${email_subject}
    Click At                ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_AND_DATE_BUTTON}
    Select Date, Time and Timezone in Begin or End delivery                 Begin
    Select Delivery Frequency                       ${delivery_frequence}
    Click At                ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FINISH_BUTTON}
    Choose option on Confirmation tab when click Save Campaigns     ${option}
    [Return]    ${campaign_name}

Create a new Campaign when already have 3 campaigns are active
    ${number_campaigns_active}=     Check number of status of campaigns
    FOR   ${index}    IN RANGE  ${number_campaigns_active}  4
            Create a new Campain with Delivery is Add Date & Time
    END

Check UI show option when click Ellipsis menu of Campaign
    [Arguments]    @{option_menu}    ${campaign_name}   ${status}=Active
    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}=    Format String   ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}   ${campaign_name}  ${status}
    Click At    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}
    FOR     ${option}    IN    @{option_menu}
        Page Should Contain        ${option}
        Capture Page Screenshot
    END
    Click At    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}

Check Feedback Compaign not allowed edit any infomation when select View Details option
    Wait For Page Load Successfully
    Element Should Be Disabled       ${USER_FEEDBACK_CAMPAIGN_TITLE_INPUT}
    Element Should Be Disabled       ${USER_FEEDBACK_CAMPAIGN_ADD_RULE_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    Element Attribute Value Should Be    ${USER_FEEDBACK_CAMPAIGN_MESSAGE_OLIVIA_INPUT}     contenteditable     false
    Element Should Be Disabled    ${USER_FEEDBACK_CAMPAIGN_EMAIL_INPUT}
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    Element Should Be Disabled    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_DATE_BUTTON}
    Verify Element Is Disabled By Checking Class    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_BUTTON}
    Verify Element Is Disabled By Checking Class    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIMEZONE_BUTTON}
    Capture Page Screenshot
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_BUTTON}
    Check Element Not Display On Screen    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DROPDOWN_LIST}
    Capture Page Screenshot

Check Feedback Compaign should be able to edit information when select View Details option
    Wait For Page Load Successfully
    Element Should Be Enabled       ${USER_FEEDBACK_CAMPAIGN_TITLE_INPUT}
    Element Should Be Enabled       ${USER_FEEDBACK_CAMPAIGN_ADD_RULE_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    Element Attribute Value Should Be    ${USER_FEEDBACK_CAMPAIGN_MESSAGE_OLIVIA_INPUT}     contenteditable     true
    Element Should Be Enabled    ${USER_FEEDBACK_CAMPAIGN_EMAIL_INPUT}
    Click At    ${USER_FEEDBACK_CAMPAIGN_NEXT_BUTTON}
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_DATE_BUTTON}
    Check Element Display On Screen     ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DATE_DROPDOWN}
    Verify Element Is Enabled By Checking Class   ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIME_BUTTON}
    Verify Element Is Enabled By Checking Class    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_ADD_TIMEZONE_BUTTON}
    Capture Page Screenshot
    Click At    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DELIVERY_BUTTON}
    Check Element Display On Screen    ${USER_FEEDBACK_CAMPAIGN_FREQUENCY_DROPDOWN_LIST}
    Capture Page Screenshot

Select ellipsis menu of an Active Campaign option
    [Arguments]    ${option}    ${campaign_name}
    ${USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON}=   Format String    ${USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON}   ${campaign_name}    Active     ${option}
    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}=    Format String   ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}   ${campaign_name}  Active
    Click At    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}
    Click At    ${USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON}
    Reload Page
    IF  '${option}' == 'Deactivate campaign'
        ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}=  Format String   ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_TITLE}   Inactive     ${campaign_name}
        Check Element Display On Screen    ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}
    ELSE IF   '${option}' == 'Duplicated as inactive'
        ${campaign_name}=   Format String   {} {}  Copy of     ${campaign_name}
        ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}=  Format String   ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_TITLE}   Inactive   ${campaign_name}
        Check Element Display On Screen    ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}
    ELSE IF    '${option}' == 'View details'
        Check Feedback Compaign not allowed edit any infomation when select View Details option
    END
    Capture Page Screenshot

Select ellipsis menu of an Inactive Campaign option
    [Arguments]    ${option}    ${campaign_name}
    ${USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON}=   Format String    ${USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON}   ${campaign_name}   Inactive     ${option}
    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}=    Format String   ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}   ${campaign_name}   Inactive
    Click At    ${USER_FEEDBACK_PAGE_ELLIPSIS_MENU}
    Click At    ${USER_FEEDBACK_PAGE_OPTION_MENU_BUTTON}
    IF  '${option}' == 'Activate campaign'
        Reload Page
        ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_ACTIVE_TITLE}=  Format String   ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_TITLE}   Active     ${campaign_name}
        Check Element Display On Screen    ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_ACTIVE_TITLE}
        Select ellipsis menu of an Active Campaign option    option=Deactivate campaign    campaign_name=${campaign_name}
    ELSE IF   '${option}' == 'Duplicated as inactive'
        Reload Page
        ${campaign_name}=   Format String   {} {}  Copy of     ${campaign_name}
        ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}=  Format String   ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_TITLE}   Inactive   ${campaign_name}
        Check Element Display On Screen    ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}
    ELSE IF    '${option}' == 'View details'
        Reload Page
        Check Feedback Compaign should be able to edit information when select View Details option
    ELSE IF    '${option}' == 'Delete campaign'
        Click At    ${USER_FEEDBACK_PAGE_CAMPAIGN_DELETE_BUTTON}
        ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}=  Format String   ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_TITLE}   Inactive   ${campaign_name}
        Check Element Not Display On Screen    ${USER_FEEDBACK_PAGE_CAMPAIGN_NAME_INACTIVE_TITLE}
    END
    Capture Page Screenshot
