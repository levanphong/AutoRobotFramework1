*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../data_tests/event/event_rating.robot
Resource            ../../pages/event_page.robot
Resource            ../../pages/ratings_page.robot
Resource            ../../pages/conversation_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          regression    dev2    stg   olivia  birddoghr   advatage  aramark     lts_stg    test

*** Variables ***
${event_user_rating_test}           event_user_rating_test
${event_candidate_rating_test}      event_candidate_rating_test
${event_candidate_rating_test_2}    event_candidate_rating_test_2
${event_rating_conversation}        event_rating_conversation

*** Test Cases ***
Check Add Rating Trigger in Candidates tab (OL-T5298)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates
    Verify display text    ${EVENT_RATINGS_CONFIGURED_NUMBER}    1 configured


Check Add Rating Trigger in Users tab (OL-T5299)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Users
    Verify display text    ${EVENT_RATINGS_CONFIGURED_NUMBER}    1 configured


Verify not displaying 'Event Interview Complete' Touchpoint on the 'Select Candidate Touchpoint' modal when creating Orientation (OL-T5296)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time
    Check element not display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Interview Complete


Verify showing Engagement Tool ‘Event Ratings’ in Event Builder when Ratings is toggled ON in client setup (OL-T5291)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${TOOLS_STEP_LABEL}
    Check element display on screen    Event Ratings


Verify taking user back to Engagement Tools when clicking on Cancel button in 'Event Ratings' (OL-T5294)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_CANCEL_BUTTON}
    Check element display on screen    Event Ratings


Verify the Rating (Delivery is not Immediately) that will be sent only can be edited if the trigger has not be matched yet (OL-T5338)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Go to    ${current_event_url}
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_TRIGGER_TITLE}    Start Time
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    24 Hours
    Click at    ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_SAVE_BUTTON}


Verify the Rating Trigger card is closed when the user clicks on Cancel button (OL-T5313)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_CANCEL_BUTTON}
    Check element not display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}


Verify the Save button is disabled until all required fields are filled when adding a Rating trigger (OL-T5309)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type    Orientation
    Set Overview step    Virtual    Single Event
    Set Schedule step
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Check Save button is disabled
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    48 Hours
    Check Save button is disabled
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${event_candidate_rating_test}
    Click at    ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_SAVE_BUTTON}


Verify the user can delete the Rating Trigger (OL-T5311)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates
    Set Tools step
    Wait with short time
    ${current_event_url} =    Get location
    Go to event register page
    Finish register the event    Candidate Test    ${CONST_PHONE_NUMBER}
    Go to    ${current_event_url}
    Click at    ${EVENT_DASHBOARD_SETTING_ICON}
    Click at    ${EDIT_EVENT}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_TRIGGER_TITLE}    Start Time
    Click at    ${EVENT_RATINGS_TRIGGER_DELETE_BUTTON}
    Click at    ${EVENT_RATINGS_CONFIRM_REMOVE_TRIGGER_POPUP_CONFIRM_BUTTON}
    Check element not display on screen    ${EVENT_RATINGS_TRIGGER_TITLE}    Start Time


Verify 'Delivery' dropdown after the user selects 'Event End Time ' as Candidate Touchpoint (OL-T5303)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen    1 Hour After
    Check element display on screen    24 Hours After
    Check element display on screen    48 Hours After


Verify 'Delivery' dropdown after the user selects 'Event End Time ' as User Touchpoint (OL-T5307)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Users
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen    1 Hour After
    Check element display on screen    24 Hours After
    Check element display on screen    48 Hours After


Verify 'Delivery' dropdown after the user selects 'Event Interview Complete' as Candidate Touchpoint (OL-T5305)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Event Interview Complete
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen    24 Hours After
    Check element display on screen    48 Hours After


Verify 'Delivery' dropdown after the user selects 'Event Start Time ' as Candidate Touchpoint (OL-T5302)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen    1 Hour Before
    Check element display on screen    24 Hours Before
    Check element display on screen    48 Hours Before


Verify 'Delivery' dropdown after the user selects 'Event Start Time ' as User Touchpoint (OL-T5306)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Users
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen    1 Hour Before
    Check element display on screen    24 Hours Before
    Check element display on screen    48 Hours Before


Verify displaying User Touchpoint on the 'Select User Touchpoint' modal when creating Event Rating (OL-T5297)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Users
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Check element display on screen    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    End Time


Verify Engagement Tool ‘Event Ratings’ is option when creating event (OL-T5292)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Set Tools step
    Wait with short time
    Check element display on screen  Dashboard


Verify only 1 card can be clicked into and open at the same time (OL-T5314)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates
    Add an Rating Trigger in Tools step    Candidates   End Time
    Click at    Event Ratings
    Click at  ${EVENT_RATINGS_TRIGGER_TITLE}  Start Time
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_COLLAPSE_ACTIVE}  Start Time
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_COLLAPSE_NOT_ACTIVE}  End Time
    Click at  ${EVENT_RATINGS_TRIGGER_TITLE}  End Time
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_COLLAPSE_ACTIVE}  End Time
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_COLLAPSE_NOT_ACTIVE}  Start Time


Verify Rating Trigger UI after it was created (OL-T5310)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Add an Rating Trigger in Tools step    Candidates
    Click at    Event Ratings
    Click at  ${EVENT_RATINGS_TRIGGER_TITLE}  Start Time
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_CANCEL_BUTTON}
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_DELETE_BUTTON}
    Check element display on screen  ${EVENT_RATINGS_VIEW_RATING_HYPERLINK}


Verify UI of Add Rating Trigger once a Toughpoint is selected (OL-T5301)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Check element display on screen  ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}


Verify users can view their selected Rating in Ratings Builder (OL-T5308)
    # TODO maintain later
    [Tags]  skip
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    Start Time
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    48 Hours
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${event_candidate_rating_test_2}
    Click by JS    ${EVENT_RATINGS_VIEW_RATING_HYPERLINK}
    Switch window   ${event_candidate_rating_test_2} | Candidate Experience Manager
    Check element display on screen  Ratings Builder


Veriy UI of Engagement Tool ‘Event Ratings’ (OL-T5293)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_EVENT}
    when Go to Events page
    Choose Event type and Event venue type    Hiring Event    Virtual
    ${event_name} =    Set Overview step    Virtual    Single Event
    Set Schedule step    Virtual Scheduled Interviews
    Set Registration step    conversation_name=${event_rating_conversation}
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Check element display on screen    ${EVENT_RATINGS_AUDIENCE_TAB}    Candidates
    Check element display on screen    ${EVENT_RATINGS_AUDIENCE_TAB}    Users
    Check element display on screen  ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Check element display on screen  ${EVENT_RATINGS_SAVE_BUTTON}
    Check element display on screen  ${EVENT_RATINGS_CANCEL_BUTTON}

*** Keywords ***
Add an Rating Trigger in Tools step
    [Arguments]    ${audience_tab}    ${touchpoint}=Start Time    ${delivery}=48 Hours
    # ${audience_tab} can be Users/Candidates
    IF    '${audience_tab}' == 'Users'
        ${rating_name} =    Set variable    ${event_user_rating_test}
    ELSE
        ${rating_name} =    Set variable    ${event_candidate_rating_test}
    END
    Click at    ${TOOLS_STEP_LABEL}
    Click at    Event Ratings
    Click at    ${EVENT_RATINGS_AUDIENCE_TAB}    ${audience_tab}
    Click at    ${EVENT_RATINGS_ADD_TRIGGER_TEXT}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_DROPDOWN}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_VALUE}    ${touchpoint}
    Click at    ${EVENT_RATINGS_TOUCHPOINT_SELECT_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_TRIGGER_DELIVERY_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${delivery}
    Click at    ${EVENT_RATINGS_TRIGGER_RATING_DROPDOWN}
    Click at    ${EVENT_RATINGS_TRIGGER_DROPDOWN_VALUE}    ${rating_name}
    Click at    ${EVENT_RATINGS_TRIGGER_SAVE_BUTTON}
    Click at    ${EVENT_RATINGS_SAVE_BUTTON}

Check Save button is Disabled
    ${is_disable} =    Run keyword and return status    Click at    ${EVENT_RATINGS_SAVE_BUTTON}
    Should be equal as Strings    ${is_disable}    True
