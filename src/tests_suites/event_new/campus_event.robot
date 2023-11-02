*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/school_management_page.robot
Resource            ../../pages/conversation_page.robot
Resource            ../../pages/event_templates_page.robot
Variables           ../../constants/ConversationConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome    ${2560}    ${1440}
Default Tags        advantage    aramark    birddoghr    lts_stg    olivia    regression    stg    test

*** Variables ***
${job_requisition_id_1}             PAT050
${text_welcome}                     I can help you submit your final expenses for this event.
${text_final_actual_expenses}       Are you sure that you want to submit the final actual expenses for this event?
${text_thank_you}                   Great, thank you! Your final expenses have been submitted for this event.
${planned_price}                    19
${planned_price_1}                  29
${planned_price_2}                  3
${actual_price}                     59
${actual_price_1}                   69
${total_planned_price}              $48
${total_actual_price}               $128
${event_template_group}             Hiring_event_template_group
${hiring_event_template}            Hiring_event
${school_name}                      Automation Test School

*** Test Cases ***
User adds item on Event Planning successfully (OL-T2063, OL-T2064)
    Login into system
    Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set Overview step       Virtual     Single Event
    Turn on campus and select school    ${school_name}
    Set Schedule step       Virtual Chat Booth
    Set Registration step       None    None
    Set Tools step
    Set event planning step
    Capture page screenshot


Actual currency is not added when creating event (OL-T2065, OL-T2066)
    Login into system
    when Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set Overview step       Virtual     Single Event
    Turn on campus and select school    ${school_name}
    Click at    ${EVENT_PLANING_LABEL}
    Click at    Add Item
    Click at    Advertising
    Check element display on screen     ${INPUT_PLANNED_PRICE}
    Check element display on screen     ${INPUT_ACTUAL_PRICE_DISABLED}
    Capture page screenshot
    Simulate Input      ${INPUT_PLANNED_PRICE}      ${planned_price}
    wait with short time
    Click at    Add Item
    Click at    ${BUDGET_TYPE_DROPDOWN_ADVERTISING}
    Simulate Input      ${INPUT_PLANNED_PRICE_1}    ${planned_price_1}
    Check element display on screen     ${total_planned_price}
    Capture page screenshot


User can move/delete an line item (OL-T2067)
    Login into system
    when Go to Events page
    Choose Event type and Event venue type      Hiring Event    Virtual
    Set Overview step       Virtual     Single Event
    Turn on campus and select school    ${school_name}
    Click at    ${EVENT_PLANING_LABEL}
    Input planned price     ${INPUT_PLANNED_PRICE}      2
    Input planned price     ${INPUT_PLANNED_PRICE_1}    6
    Drag And Drop       ${ICON_REORDER_LINE_ITEM_2}     ${ICON_REORDER_LINE_ITEM}
    Capture page screenshot


Verify Event Planning on an existing event before applying new design (OL-T2068)
    Login into system
    Create campus event planing     ${INPUT_PLANNED_PRICE}      ${planned_price}
    wait with short time
    Scroll to element       ${FINALIZE_EXPENSES_BUTTON}
    Check element display on screen     ${INCOMPLETE_FINALIZING_STATUS}
    Capture page screenshot


User can edit an event after creating the event with Approvals is OFF (OL-T2069)
    Login into system
    Create campus event planing     ${INPUT_PLANNED_PRICE}      2
    wait with short time
    Capture page screenshot
    Scroll to element       ${FINALIZE_EXPENSES_BUTTON}
#   Verify User can update planned/ actual currency
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_PLANNED_PRICE}      3
    Input price     ${INPUT_ACTUAL_PRICE}       5
#   Verify User can Add Item
    Input planned price     ${INPUT_PLANNED_PRICE_1}    6
    Input price     ${INPUT_ACTUAL_PRICE_1}     7
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       $12.00
    Check element display on screen     ${TOTAL_SUM_PLANNED_PRICE}      $9.00
    # Verify Delete an existing line item
    Capture page screenshot
    Click at    ${DELETE_ITEM_EXPENSES_VALUE}
    Click at    ${CONFIRM_DELETE_EXPENSES_VALUE}
    Capture page screenshot


User can edit an event after creating the event with Approval Status is Draft or Denied (OL-T2070)
    Login into system
    Create campus event planing     ${INPUT_PLANNED_PRICE}      ${planned_price}
    wait with short time
    Capture page screenshot
    Scroll to element       ${FINALIZE_EXPENSES_BUTTON}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Check element not display on screen     ${INPUT_LINE_ITEM_NAME}
    Check element display on screen     ${INPUT_PLANNED_PRICE}
    Check element display on screen     ${INPUT_ACTUAL_PRICE}
    Capture page screenshot
    Input planned price     ${INPUT_PLANNED_PRICE_1}    ${planned_price_1}
    simulate input      ${INPUT_ACTUAL_PRICE_1}     ${actual_price_1}
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${actual_price_1}
    Check element display on screen     ${TOTAL_SUM_PLANNED_PRICE}      ${total_planned_price}
    Delete budget item
    Click at    ${CLOSE_FINAL_EXPENSES_WIDGET_MODAL}
    Capture page screenshot
    Click at    ${SUBMIT_APPROVAL_BUTTON}
    Click at    Confirm and Send
    Switch to user    ${CA_TEAM}
    Click at    ${DENY_BUTTON}
    Click at    Deny and Send
    Capture page screenshot
    Scroll to element       ${FINALIZE_EXPENSES_BUTTON}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Check element display on screen     ${FINALIZE_EXPENSES_SUBMIT_DISABLED_BUTTON}
    Check element display on screen     ${INPUT_PLANNED_PRICE_DISABLED}
    Check element display on screen     ${INPUT_ACTUAL_PRICE_DISABLED}
    Capture page screenshot


User can edit campus event when Approval status is Pending or Approved (OL-T2071)
    Login into system
    Create campus event planing     ${INPUT_PLANNED_PRICE}      ${planned_price}
    Click at    ${SUBMIT_APPROVAL_BUTTON}
    Click at    Confirm and Send
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Check element not display on screen     ${INPUT_LINE_ITEM_NAME}
    Check element display on screen     ${INPUT_PLANNED_PRICE}
    Check element display on screen     ${INPUT_ACTUAL_PRICE}
    Capture page screenshot
    simulate input      ${INPUT_ACTUAL_PRICE}       ${actual_price}
    simulate input      ${INPUT_PLANNED_PRICE}       ${planned_price}
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${actual_price}
    Check element display on screen     ${TOTAL_SUM_PLANNED_PRICE}      ${planned_price}
    Capture page screenshot


User can submit final expenses successfully (OL-T2076, OL-T2072)
    Login into system
    when Go to Events page
    ${team_members}=    Create List     Full User Automation
    ${event_campus_name}=       Create campus active event      @{team_members}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Capture page screenshot
    Input planned price     ${INPUT_PLANNED_PRICE_1}    ${planned_price_1}
    Input price     ${INPUT_ACTUAL_PRICE_1}     ${actual_price_1}
    Check element display on screen     ${total_planned_price}
    Check element display on screen     ${total_actual_price}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Check element display on screen     ${text_final_actual_expenses}
    Capture page screenshot
    Click at    ${CONFIRM_BUDGET_NEVER_MIND_BUTTON}
    Check element not display on screen     ${text_final_actual_expenses}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Click at    ${CONFIRM_BUDGET_SUBMIT_BUTTON}
    Check element display on screen     ${text_thank_you}
    Capture page screenshot


Finalizing Event Expenses shows when clicking on Finalizing Expenses (OL-T2073)
    Login into system
    when Go to Events page
    ${team_members}=    Create List     ${EE_TEAM}
    Create campus active event      @{team_members}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Click at    ${INPUT_ACTUAL_PRICE}
    simulate input      ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Check element display on screen     ${text_welcome}
    Check element display on screen     ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${actual_price}
    Check element display on screen     ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    check element display on screen     Add Item
    check text display      Event Budget and Expenses
    Capture page screenshot


User can add/edit line item on Event Budget & Expenses if the final budget hasn't been submitted (OL-T2074)
    Login into system
    when Go to Events page
    ${team_members}=    Create List     Full User Automation
    ${event_campus_name}=       Create campus active event      @{team_members}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Capture page screenshot
    Click at    Add Item
    Click at    ${BUDGET_TYPE_DROPDOWN_ADVERTISING}
    Click at    ${INPUT_ACTUAL_PRICE_1}
    simulate input      ${INPUT_ACTUAL_PRICE_1}     ${actual_price_1}
    Capture page screenshot
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${total_actual_price}
    Capture page screenshot
    Click at    ${FINAL_EXPENSES_NEVER_MIND_BUTTON}
    Check element not display on screen     ${text_final_actual_expenses}
    Capture page screenshot


User can delete an existing newly added line item on Budget Expenses (OL-T2075)
    Login into system
    when Go to Events page
    ${team_members}=    Create List     Full User Automation
    ${event_campus_name}=       Create campus active event      @{team_members}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Click at    Add Item
    Click at    ${BUDGET_TYPE_DROPDOWN_ADVERTISING}
    Input price     ${INPUT_ACTUAL_PRICE_1}     ${actual_price_1}
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${total_actual_price}
    Capture page screenshot
    Click at    ${DELETE_ITEM_EXPENSES_VALUE}
    Click at    ${CONFIRM_DELETE_EXPENSES_VALUE}
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${actual_price}
    Capture page screenshot


Campus event saved when user clicks on Save for later (OL-T2077)
    Login into system
    when Go to Events page
    ${team_members}=    Create List     Full User Automation
    Create campus active event      @{team_members}
    wait with medium time
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Click at    ${INPUT_ACTUAL_PRICE}
    simulate input      ${INPUT_ACTUAL_PRICE}       ${actual_price}
    wait with short time
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${actual_price}
    Capture page screenshot
    Click at    Save for later
    Check element not display on screen     ${FINAL_EXPENSES_WIDGET_MODAL}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    input into      ${INPUT_PLANNED_PRICE}      ${planned_price_1}
    Click at    ${CLOSE_FINAL_EXPENSES_WIDGET_MODAL}
    Check element not display on screen     ${FINAL_EXPENSES_WIDGET_MODAL}
#   Verify data not change when click close button
    Check element display on screen     ${planned_price}
    Check element display on screen     ${actual_price}
    Capture page screenshot


Managers can submit final expenses successfully (OL-T2078, OL-T2082)
    Login into system
    when Go to Events page
    ${event_campus_name}=       Create campus active event
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Input planned price     ${INPUT_PLANNED_PRICE_1}    ${planned_price_1}
    Click at    ${INPUT_ACTUAL_PRICE_1}
    simulate input      ${INPUT_ACTUAL_PRICE_1}     ${actual_price_1}
    Check element display on screen     ${TOTAL_SUM_ACTUAL_PRICE}       ${total_actual_price}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Check element display on screen     ${text_final_actual_expenses}
    Capture page screenshot
    Click at    ${CONFIRM_BUDGET_NEVER_MIND_BUTTON}
    Check element not display on screen     ${text_final_actual_expenses}
    Capture page screenshot
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Click at    ${CONFIRM_BUDGET_SUBMIT_BUTTON}
    Check element display on screen     ${text_thank_you}
    Capture page screenshot
    when Go to Events page
    Click at    Campus Plan
    Simulate input      ${INPUT_SEARCH_CAMPUS_BUTTON}       ${event_campus_name}
    Check element display on screen     ${EXPENSES_VALUE}       ${total_planned_price}
    Check element display on screen     ${EXPENSES_VALUE}       ${total_actual_price}
    Capture page screenshot


User only views the campus event when its final expenses is submitted (OL-T2079)
    Login into system
    when Go to Events page
    ${team_members}=    Create List     Full User Automation
    ${event_campus_name}=       Create campus active event      @{team_members}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Input price     ${INPUT_ACTUAL_PRICE}       ${actual_price}
    Click at    ${FINALIZE_EXPENSES_SUBMIT_BUTTON}
    Click at    ${CONFIRM_BUDGET_SUBMIT_BUTTON}
    Check element display on screen     ${text_thank_you}
    Capture page screenshot
    Click at    ${CLOSE_FINAL_EXPENSES_WIDGET_MODAL}
    Click at    ${FINALIZE_EXPENSES_BUTTON}
    Check element display on screen     ${INPUT_PLANNED_PRICE_DISABLED}
    Check element display on screen     ${INPUT_ACTUAL_PRICE_DISABLED}
    Check element not display on screen     Add Item
    Capture page screenshot


Verify Event Template updates (OL-T2084)
    Login into system
    Go to Event Templates page
    Go to event template group      ${event_template_group}
    Click create event template with type       Hiring Event
    ${event_template_name} =    Generate random name    orientation_template
    Set overview step Hiring Event      ${hiring_event_template}    Automation Test School
    Click at    Event Planning
    Check element display on screen     ${EVENT_BUDGET_AND_EXPENSES_INPUT_DISABLE}      Line item
    Check element display on screen     ${EVENT_BUDGET_AND_EXPENSES_INPUT_DISABLE}      Planned
    Check element display on screen     ${EVENT_BUDGET_AND_EXPENSES_INPUT_DISABLE}      Actual
    Capture page screenshot

*** Keywords ***
Login into system
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
