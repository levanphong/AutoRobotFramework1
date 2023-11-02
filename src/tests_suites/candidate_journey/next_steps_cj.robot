*** Settings ***
Documentation       Run datatest for first time
...                 robot src/data_tests/candidate_journey/next_steps_cj_data_test.robot

Resource            ../../pages/base_page.robot
Resource            ../../pages/all_candidates_page.robot
Resource            ../../drivers/driver_chrome.robot
Variables           ../../constants/CandidateJourneyConst.py

Suite Teardown      Close All Browsers
Test Setup          Setup for every Test case
Test Teardown       Close Browser

Force Tags          regression    stg


*** Test Cases ***
CEM_Users will see status dropdown with next step buttons (OL-T7678, OL-T7679, OL-T7681, OL-T7684, OL-T7685, OL-T7686)
    [Documentation]
    ...    Precondition:
    ...    The next step description and the action buttons that were created in Candidate Journeys.
    ...    a button that has multiple statuses selected
    # when Login as User
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_NEXT_STEP}
    # when Click on the status dropdown
    Create Candidate with next steps and click status dropdown    ${JOB_HAS_TWO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    Capture Page Screenshot
    # Check Users will see the next step description and the action buttons that were created in Candidate Journeys
    # (OL-T7679)
    Check element display on screen
    ...    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_DES_ONE_ARG}
    ...    ${NEXT_STEP_DES}
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_INTERVIEW}
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_CUSTOM}
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_TWO_STAGE}
    # CEM_We will populate this UI to allow the end user the ability to select what status they would like to move that candidate to. (OL-T7681)
    # when Click on the button that has multiple statuses selected
    Click at    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_CUSTOM}
    Capture Page Screenshot
    # Check We will populate this UI to allow the end user the ability to select what
    Check element display on screen    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}    ${TO_CUSTOM_TITLE_1}
    Check element display on screen    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}    ${TO_CUSTOM_TITLE_2}
    # CEM_The [Confirm Status Update] popup shows when the button just added a status (OL-T7686)
    # Click on the status (except send offer/invite to interview)
    Click at    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}    ${TO_CUSTOM_TITLE_1}
    Capture Page Screenshot
    # Check users will have to confirm their decision before we move the candidate to
    Check element display on screen    ${NEXT_STEP_COMFIRM_TITLE}
    Click at    ${NEXT_STEP_COMFIRM_MODAL_BUTTON}    Cancel
    # CEM_The user back to the previous screen within the dropdown when clicking “Back” (OL-T7684)
    # when Click on "Back"
    Click at    ${NEXT_STEP_MULTIPLE_STATUS_BACK_BUTTON}
    Capture Page Screenshot
    # Check The user back to the previous screen within the dropdown
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_DES_ONE_ARG}    ${NEXT_STEP_DES}
    # CEM_We will view the [Offer] modal or the [Scheduling] modal when clicking the [Send Offer] status or the [Invite to interview] status (OL-T7685)
    # Click on the [Invite to interview] status
    Click at    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_INTERVIEW}
    Click at    ${NEXT_STEP_COMFIRM_MODAL_BUTTON}    Confirm
    Capture Page Screenshot
    # Check We will view the [Scheduling] modal
    Check element display on screen    ${NEXT_STEP_SCHEDULE_INTERVIEW_MODAL_TITLE}

CEM_Users don't view the status dropdown when no adding [Next Steps] (OL-T7680)
    [Documentation]
    ...    Precondition:
    ...    No add [Next Steps]
    # when Login as User
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_NEXT_STEP}
    # when Click on the status dropdown
    Create Candidate with next steps and click status dropdown    ${JOB_HAS_NO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    # Check Users don't view the status dropdown when no adding [Next Steps]
    Check element not display on screen
    ...    ${CEM_CANDIDATE_JOURNEY_NEXT_STATUS_DROPDOWN_TITLE}
    ...    ${STATUS_APPLY_NEXT_STEPS}

CEM_We should default the drawer open for the stage when only one stage is selected in the Candidate Journey (OL-T7682)
    [Documentation]
    ...    Precondition:
    ...    only one stage is selected in the Candidate Journey
    # when Login as User
    Login into system with company    ${EDIT_EVERYTHING}    ${COMPANY_NEXT_STEP}
    Create Candidate with next steps and click status dropdown    ${JOB_HAS_TWO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    # when Click on the status dropdown
    Click at    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_CUSTOM}
    #Check we should default to having the drawer open for that stage
    Check element display on screen    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}    ${TO_CUSTOM_TITLE_1}
    Check element display on screen    ${NEXT_STEP_MULTIPLE_STATUS_ITEM}    ${TO_CUSTOM_TITLE_2}

CEM_Company Admin users will have the ability to override the action buttons and move the candidate to any available status. (OL-T7687)
    [Documentation]
    ...    Precondition
    ...    Login as Paradox Admin
    ...    Go to [Client Setup] > Click on [Hire] tab > Enable Candidate Journey toggle & Next Steps toggle & Job toggle
    ...    Go to Candidate Journey > Click on any CJ (EX. CJ A) > Click on Capture stage > Click on [Capture Complete] status > Click on [Add button] > Enter [Button title] & Select a status (EX. custom status) > Apply > Save & Published
    ...    Go to job > Add job A tied CJ A > Save & published
    ...    Go to My job > Enable job A
    ...    Candidate A applied job A & the candidate's status is Capture Complete
    # login as Company Admin (This should include Franchise Owner and Franchise Office Staff as well as Company Admin.)
    Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_NEXT_STEP}
    #Click on the status dropdown
    Create Candidate with next steps and click status dropdown    ${JOB_HAS_TWO_NEXT_STEP}    ${JOB_NEXT_STEP_LOCATION}
    # Check Compnay Admin will view:
    # + The next steps description
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_DES_ONE_ARG}    ${NEXT_STEP_DES}
    # + The action button
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_INTERVIEW}
    Check element display on screen    ${CEM_CANDIDATE_JOURNEY_NEXT_STEP_BUTTON}    ${NEXT_BUTTON_TO_CUSTOM}
    # + The "More option"
    Check element display on screen    ${NEXT_STEP_MULTIPLE_STATUS_MORE_OPTIONS_BUTTON}
