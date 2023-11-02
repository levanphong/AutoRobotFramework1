*** Settings ***
Resource            ../../drivers/driver_chrome.robot
Resource            ../../pages/client_setup_page.robot
Resource            ../../pages/offers_page.robot
Resource            ../../pages/jobs_page.robot
Resource            ../../pages/my_jobs_page.robot
Resource            ../../pages/candidate_journeys_page.robot
Variables           ../../constants/CandidateJourneyConst.py
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Default Tags        advantage    aramark    birddoghr    darden    fedex    fedexstg    lowes    lowes_stg    lts_stg    mchire    olivia    regression    stg

Documentation       Run data test on /src/data_tests/offers/offer_data_tests.robot

*** Variables ***
${test_location_name}                   ${CONST_LOCATION}
${offer_location_lookup}                Broadway, New York, NY 10001
${offer_location_lookup_updated}        Vintners, DC, AK 10002
${add_field_mapping_1}                  Offer Created Date
${add_field_mapping_2}                  Offer Accepted Date
${destination_field}                    auto_destination_field
${store_att_as_location_field}          Location Name
${store_att_as_user_field}              User Name
${published_success_message}            Offer is published successfully!
${cj_name}                              CJ_Send Offer To Candidate
${wf_name}                              WF_Send Offer To Candidate
${offer_name}                           OF_Send Offer To Candidate
${job_name}                             Job for Send Offer To Candidate
${offer_name_with_location_lookup}      OF_Offer With Location Lookup
${offer_name_with_user_lookup}          OF_Offer With User Lookup
${job_name_with_location_lookup}        Job With Offer Have Location Lookup
${job_name_with_user_lookup}            Job With Offer Have User Lookup

*** Test Cases ***
Check that CAN add Location Lookup on Offer Builder (OL-T24986, OL-T24993)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    Check UI of Add Location Lookup modal
    ${location_lookup_name_1}=   Setting data for Add Location Lookup component
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name_1}
    capture page screenshot
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page  ${offer_name}
    # Check that CAN add many Location Lookup on Offer Builder (OL-T24993)
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name_2}=   Setting data for Add Location Lookup component     add_field_mapping=Offer Accepted Date
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page  ${offer_name}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name_1}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name_2}
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN add User Lookup on Offer Builder (OL-T24997, OL-T25004 )
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    Check UI of Add User Lookup modal
    ${user_lookup_name_1}=   Setting data for Add User Lookup component
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name_1}
    capture page screenshot
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page  ${offer_name}
    # Check that CAN add many User Lookup on Offer Builder (OL-T25004)
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name_2}=   Setting data for Add User Lookup component     add_field_mapping=Offer Accepted Date
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page  ${offer_name}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name_1}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name_2}
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN cancel add Location Lookup on Offer Builder (OL-T24987)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${component_name} =     Input offer component name
    Click at    ${NEW_OFFER_COMPONENT_CANCEL_BUTTON}
    Check element not display on screen     Location Lookup Label   wait_time=5s
    Check element not display on screen     ${component_name}       wait_time=1s
    capture page screenshot
    Click offer editor and add component      Add Location Lookup
    ${component_name} =     Input offer component name
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    Check element not display on screen     Location Lookup Label   wait_time=5s
    Check element not display on screen     ${component_name}       wait_time=1s
    capture page screenshot


Check that CAN cancel add User Lookup on Offer Builder (OL-T24998)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${component_name} =     Input offer component name
    Click at    ${NEW_OFFER_COMPONENT_CANCEL_BUTTON}
    Check element not display on screen     User Lookup Label   wait_time=5s
    Check element not display on screen     ${component_name}   wait_time=1s
    capture page screenshot
    Click offer editor and add component      Add User Lookup
    ${component_name} =     Input offer component name
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    Check element not display on screen     User Lookup Label   wait_time=5s
    Check element not display on screen     ${component_name}   wait_time=1s
    capture page screenshot


Check that CAN delete Location Lookup on Offer Builder (OL-T24992)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name_1}=   Setting data for Add Location Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    # Check not delete action
    Check action delete component of offer  ${offer_name}     ${location_lookup_name_1}
    # Delete offer after check
    Delete a offer      ${offer_name}


Check that CAN delete User Lookup on Offer Builder (OL-T25003)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name_1}=   Setting data for Add User Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    # Check not delete action
    Check action delete component of offer  ${offer_name}     ${user_lookup_name_1}
    # Delete offer after check
    Delete a offer      ${offer_name}


Check that CAN Duplicate Offer with Location Lookup (OL-T24995)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name}=   Setting data for Add Location Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Dupplicate Offer    ${offer_name}
    Check element display on screen     Copy - ${offer_name}
    Click at    Copy - ${offer_name}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name}
    capture page screenshot
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${add_field_mapping_1}
    capture page screenshot
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${store_att_as_location_field}
    capture page screenshot
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${destination_field}
    capture page screenshot
    # Delete offer after check
    Delete a offer      Copy - ${offer_name}
    Delete a offer      ${offer_name}


Check that CAN Duplicate Offer with User Lookup (OL-T25006)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name}=   Setting data for Add User Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Dupplicate Offer    ${offer_name}
    Check element display on screen     Copy - ${offer_name}
    Click at    Copy - ${offer_name}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name}
    capture page screenshot
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${add_field_mapping_1}
    capture page screenshot
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${store_att_as_user_field}
    capture page screenshot
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${destination_field}
    capture page screenshot
    # Delete offer after check
    Delete a offer      Copy - ${offer_name}
    Delete a offer      ${offer_name}


Check that CAN Preview Offer with Location Lookup (OL-T24996)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name}=   Setting data for Add Location Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Preview an Offer    ${offer_name}
    Check element display on screen     Preview Offer Letter
    Check label display     ${location_lookup_name}
    Check element display on screen     ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}
    capture page screenshot
    # Delete offer after check
    Delete a offer      ${offer_name}


Check that CAN Preview Offer with User Lookup (OL-T25007)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name}=   Setting data for Add User Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Preview an Offer    ${offer_name}
    Check element display on screen     Preview Offer Letter
    Check label display     ${user_lookup_name}
    Check element display on screen     ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}
    capture page screenshot
    # Delete offer after check
    Delete a offer      ${offer_name}


Check that CAN published Offer with Location Lookup (OL-T24994)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name_1}=   Setting data for Add Location Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    ${success_message} =    Get text and format text   ${PUBLISH_OFFER_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${published_success_message}
    Check span display   Published
    Go to Offers page
    Check element display on screen     ${offer_name}
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN published Offer with User Lookup (OL-T25005)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name_1}=   Setting data for Add User Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_STATUS}   slow_down=2s
    Click at    ${NEW_OFFER_PUBLISH_BUTTON}
    Click at    ${PUBLISH_OFFER_POPUP_PUBLISH_BUTTON}
    ${success_message} =    Get text and format text   ${PUBLISH_OFFER_SUCCESS_TOASTED}
    Should Contain    ${success_message}    ${published_success_message}
    Check span display   Published
    Go to Offers page
    Check element display on screen     ${offer_name}
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN remove Field Mapping for Location Lookup on Offer Builder (OL-T24991)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name}=   Setting data for Add Location Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page      ${offer_name}
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name}
    Click at    ${NEW_OFFER_REMOVE_FIELD_MAPPING}
    Click at    ${NEW_OFFER_COMPONENT_SAVE_BUTTON}
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page      ${offer_name}
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name}
    Check element not display on screen     ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}    wait_time=5s
    Check element not display on screen     ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}     wait_time=1s
    Check element not display on screen     ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}            wait_time=1s
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN remove Field Mapping for User Lookup on Offer Builder (OL-T25002)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name}=   Setting data for Add User Lookup component
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page      ${offer_name}
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name}
    Click at    ${NEW_OFFER_REMOVE_FIELD_MAPPING}
    Click at    ${NEW_OFFER_COMPONENT_SAVE_BUTTON}
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page      ${offer_name}
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name}
    Check element not display on screen     ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}    wait_time=5s
    Check element not display on screen     ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}     wait_time=1s
    Check element not display on screen     ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}            wait_time=1s
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN setting all info Field Mapping for Location Lookup on Offer Builder (OL-T24990, OL-T24989, OL-T24988)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name_1}=   Setting data for Add Location Lookup component
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name_2}=   Setting data for Add Location Lookup component   add_field_mapping=None    destination_field=None
    Click offer editor and add component      Add Location Lookup
    ${location_lookup_name_3}=   Setting data for Add Location Lookup component   add_field_mapping=${add_field_mapping_2}    destination_field=None   store_att_as_field=None
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page      ${offer_name}
    # Check that CAN setting all info Field Mapping for Location Lookup on Offer Builder (OL-T24990)
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name_1}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${add_field_mapping_1}
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${store_att_as_location_field}
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${destination_field}
    capture page screenshot
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    # Check that CAN setting on Store Attribute as Field Value for Location Lookup on Offer Builder (OL-T24989)
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name_2}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${EMPTY}
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${store_att_as_location_field}
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${EMPTY}
    capture page screenshot
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    # Check that CAN setting only System Attribute for Location Lookup on Offer Builder (OL-T24988)
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${location_lookup_name_3}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${add_field_mapping_2}
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${EMPTY}
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${EMPTY}
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN setting all info Field Mapping for User Lookup on Offer Builder (OL-T25001, OL-T25000, OL-T24999)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Go to Offers page
    Click at    Add offer
    ${offer_name}=  Input offer name
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name_1}=   Setting data for Add User Lookup component
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name_2}=   Setting data for Add User Lookup component   add_field_mapping=None    destination_field=None
    Click offer editor and add component      Add User Lookup
    ${user_lookup_name_3}=   Setting data for Add User Lookup component   add_field_mapping=${add_field_mapping_2}    destination_field=None   store_att_as_field=None
    Click at    ${NEW_OFFER_CREATE_BUTTON}   slow_down=2s
    Navigate to offer page      ${offer_name}
    # Check that CAN setting all info Field Mapping for User Lookup on Offer Builder (OL-T25001)
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name_1}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${add_field_mapping_1}
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${store_att_as_user_field}
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${destination_field}
    capture page screenshot
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    # Check that CAN setting on Store Attribute as Field Value for User Lookup on Offer Builder (OL-T25000)
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name_2}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${EMPTY}
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${store_att_as_user_field}
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${EMPTY}
    capture page screenshot
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    # Check that CAN setting only System Attribute for User Lookup on Offer Builder (OL-T24999)
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${user_lookup_name_3}
    ${actual_system_attribute_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_SYSTEM_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_system_attribute_value}    ${add_field_mapping_2}
    ${actual_store_att_as_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_STORE_ATTRIBUTE_DROPDOWN}
    should be equal as strings  ${actual_store_att_as_field_value}    ${EMPTY}
    ${actual_destination_field_value} =    Get value and format text    ${NEW_OFFER_COMPONENT_DESTINATION_FIELD}
    should be equal as strings  ${actual_destination_field_value}    ${EMPTY}
    capture page screenshot
    Delete a offer      ${offer_name}


Check that CAN select location on Location Lookup - field (OL-T25010)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create new offer with Location lookup compoment
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Change conversation status    ${candidate_name}    ${JOURNEY_OFFER_STATUS}    ${JOURNEY_SEND_OFFER_ACTION}
    Check element display on screen     ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}   10001
    Click at    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    ${actual_location_value} =    Get value and format text    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}
    should be equal as strings  ${actual_location_value}    ${offer_location_lookup}
    Check element display on screen    ${OFFER_ICON_CLOSE}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}


Check that CAN select User on User Lookup - field (OL-T25017)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create new offer with User lookup compoment
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Change conversation status    ${candidate_name}    ${JOURNEY_OFFER_STATUS}    ${JOURNEY_SEND_OFFER_ACTION}
    Check element display on screen     ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}   ${CA_TEAM}
    Click at    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    ${actual_user_value} =    Get value and format text    ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}
    should be equal as strings  ${actual_user_value}    ${CA_TEAM}
    Check element display on screen    ${OFFER_ICON_CLOSE}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}


Check that CAN edit on Location Lookup - on Hire Details screen (OL-T25011, OL-T25022, OL-T25023)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name_with_location_lookup}      is_spam_email=False
    # Check that CAN submit Offer with location on Custom Question task type that has answer type = Location Lookup (OL-T25011)
    Send Offer with Location lookup    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}      search_keyword=10001     location_lookup=${offer_location_lookup}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name_with_location_lookup}
    wait with short time
    ${actual_location_value} =    Get value and format text    ${CONFIRM_OFFER_SELECT_LOCATION_DROPDOWN}
    should be equal as strings  ${actual_location_value}    ${offer_location_lookup}
    # Check that CAN perform search on Location Lookup - on Hire Details screen (OL-T25022)
    Click at    ${OFFER_ICON_CLOSE}
    Simulate Input  ${CONFIRM_OFFER_SELECT_LOCATION_DROPDOWN}   10002
    Click at    ${CONFIRM_OFFER_SELECT_LOCATION_OPTION}  ${offer_location_lookup_updated}
    Click at    Update offer
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name_with_location_lookup}
    wait with short time
    ${actual_location_value} =    Get value and format text    ${CONFIRM_OFFER_SELECT_LOCATION_DROPDOWN}
    should be equal as strings  ${actual_location_value}    ${offer_location_lookup_updated}
    capture page screenshot


Check that CAN edit on User Lookup - on Hire Details screen (OL-T25018, OL-T25026, OL-T25027)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name_with_user_lookup}      is_spam_email=False
    # Check that CAN submit Offer with User on Custom Question task type that has answer type = User Lookup (OL-T25018)
    Send Offer with User lookup    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}      search_keyword=${CA_TEAM}     user_lookup=${CA_TEAM}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name_with_user_lookup}
    wait with short time
    ${actual_user_value} =    Get value and format text    ${CONFIRM_OFFER_SELECT_USER_DROPDOWN}
    should be equal as strings  ${actual_user_value}    ${CA_TEAM}
    # Check that CAN perform search on User Lookup - on Hire Details screen (OL-T25026)
    Click at    ${OFFER_ICON_CLOSE}
    Simulate Input  ${CONFIRM_OFFER_SELECT_USER_DROPDOWN}   ${EE_TEAM}
    Click at    ${CONFIRM_OFFER_SELECT_USER_OPTION}  ${EE_TEAM}
    Click at    Update offer
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name_with_user_lookup}
    wait with short time
    ${actual_user_value} =    Get value and format text    ${CONFIRM_OFFER_SELECT_USER_DROPDOWN}
    should be equal as strings  ${actual_user_value}    ${EE_TEAM}
    capture page screenshot


Check the validation of Location Lookup - field on Confirm Offer Details screen (OL-T25012)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name_with_location_lookup}      is_spam_email=True
    Change conversation status  ${candidate_name}    Offer    ${JOURNEY_SEND_OFFER_ACTION}
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer
    Check common text last display     The field is required
    capture page screenshot


Check the validation of User Lookup - field on Confirm Offer Details screen (OL-T25019)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name_with_user_lookup}      is_spam_email=True
    Change conversation status  ${candidate_name}    Offer    ${JOURNEY_SEND_OFFER_ACTION}
    Click at    ${CONFIRM_OFFER_START_DATE}
    Click at    ${CONFIRM_OFFER_START_DATA_TODAY_VALUE}
    Click at    ${CONFIRM_OFFER_START_PAY_RATE_TEXT_BOX}
    Press Keys    None    1
    Click at    Send offer
    Check common text last display     The field is required
    capture page screenshot


Check Users list display when performing search on User Lookup field with Full Name of User (OL-T25015, OL-T25016)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${email}    ${password} =    Get login email and password    ${CP_ADMIN}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name_with_user_lookup}      is_spam_email=True
    Change conversation status  ${candidate_name}    Offer    ${JOURNEY_SEND_OFFER_ACTION}
    Input into  ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}   CA
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    Click at    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    capture page screenshot
    clear element text with keys    ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}   Team
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    Click at    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    capture page screenshot
    clear element text with keys    ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}   ${CA_TEAM}
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    capture page screenshot
    Click at    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    capture page screenshot
    clear element text with keys    ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_USER_NAME_DROPDOWN}   ${email}
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_USER_DROPDOWN_VALUE}  ${CA_TEAM}
    capture page screenshot


Check Location list display when performing search on Location Lookup - field (OL-T25009)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name_with_location_lookup}      is_spam_email=True
    Change conversation status  ${candidate_name}    Offer    ${JOURNEY_SEND_OFFER_ACTION}
    Input into  ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}   Broadway
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    Click at    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    capture page screenshot
    clear element text with keys    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}   New York
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    Click at    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    capture page screenshot
    clear element text with keys    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}   NY
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    Click at    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    capture page screenshot
    clear element text with keys    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}
    Input into  ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN}   10001
    Check element display on screen    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    Click at    ${OFFER_PREVIEW_SEARCH_LOCATION_DROPDOWN_VALUE}  ${offer_location_lookup}
    capture page screenshot



Check the display on Candidate Attributes popup after submitting Offer that has Location Lookup - field is setting only System Attribute (OL-T25013)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create new offer with Location lookup compoment      add_field_mapping=City
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Send Offer with Location lookup    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}      search_keyword=10001     location_lookup=${offer_location_lookup}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  City
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   City    Broadway, New York, NY, 10001
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Check the display on Candidate Attributes popup after editing Location Lookup - single that setting System Attribute of Offer (OL-T25024 )
    Update location lookup and resend offer     ${offer_name}   ${candidate_name}   10002
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  City
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   City    Vintners, DC, AK, 10002
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}


Check the display on Candidate Attributes popup after submitting Offer that has Location Lookup - field is setting all infor on Field Mapping (OL-T25014)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create new offer with Location lookup compoment      add_field_mapping=City      destination_field=auto_destination_field    store_att_as_field=Location Name
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Send Offer with Location lookup    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}      search_keyword=10001     location_lookup=${offer_location_lookup}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  City
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   City    ${LOCATION_CITY_NEW_YORK}
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Check the display on Candidate Attributes popup after editing Location Lookup - single that setting all info Field Mapping of Offer (OL-T25025)
    Update location lookup and resend offer     ${offer_name}   ${candidate_name}   10002
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  City
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   City    ${LOCATION_NAME_VINTNERS_PLACE}
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}


Check the display on Candidate Attributes popup after submitting Offer that has User Lookup - field is setting only System Attribute (OL-T25020)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${offer_name} =    Create new offer with User lookup compoment      add_field_mapping=User Name
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Send Offer with User lookup    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}      search_keyword=${CA_TEAM}     user_lookup=${CA_TEAM}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Click at    Custom Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  User Name
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   User Name    ${CA_TEAM}
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Check the display on Candidate Attributes popup after editing User Lookup - single that setting System Attribute of Offer (OL-T25028)
    Update user lookup and resend offer     ${offer_name}   ${candidate_name}   ${EE_TEAM}
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Click at    Custom Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  User Name
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   User Name    ${EE_TEAM}
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}


Check the display on Candidate Attributes popup after submitting Offer that has User Lookup - field is setting all infor on Field Mapping (OL-T25021)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_FRANCHISE_ON}
    ${email}    ${password} =    Get login email and password    ${CP_ADMIN}
    ${email_updated}    ${password} =    Get login email and password    ${EDIT_EVERYTHING}
    ${offer_name} =    Create new offer with User lookup compoment      add_field_mapping=User Email      destination_field=auto_destination_field    store_att_as_field=User Email
    ${job_name} =    Create new job with Offer    ${job_family_name}    ${cj_name}    ${offer_name}
    Go to My Jobs page
    Active a job    ${job_name}
    Go to CEM page
    Switch to user    ${FULL_USER_AUTOMATION}
    ${candidate_name} =    Add a Candidate    None    ${test_location_name}    ${job_name}      is_spam_email=False
    Send Offer with User lookup    ${candidate_name}   ${JOURNEY_OFFER_STATUS}     ${COMPANY_FRANCHISE_ON}      search_keyword=${CA_TEAM}     user_lookup=${CA_TEAM}
    Click at  ${ACTION_IN_OFFER_ACCEPT_BUTTON}
    capture page screenshot
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Click at    Custom Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  User Email
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   User Email    ${email}
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Check the display on Candidate Attributes popup after editing User Lookup - single that setting all info Field Mapping of Offer (OL-T25029)
    Update user lookup and resend offer     ${offer_name}   ${candidate_name}   ${EE_TEAM}
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_CANDIDATE_MORE_BUTTON}
    Click at    ${CEM_CANDIDATE_MENU_ITEM}      Attributes
    Click at    Custom Attributes
    Input into  ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_SEARCH}  User Email
    ${ATTRIBUTE_VALUE_ITEM} =    format string   ${CEM_CANDIDATE_SHARE_CANDIDATE_ATTRIBUTES_VALUE}   User Email    ${email_updated}
    Check element display on screen     ${ATTRIBUTE_VALUE_ITEM}
    capture page screenshot
    # Delete data after check
    Delete job and offer data after check   ${job_name}    ${offer_name}

*** Keywords ***
Check UI of Add Location Lookup modal
    Check element display on screen     Add Location Lookup
    Check label display     Location Lookup Label
    Check span display      Please provide the details for this lookup field. The hiring team will be required to make a selection in this field before sending the offer to the candidate.
    Check element display on screen     ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Check common text last display  Additional Fields
    Check span display  Add validation and/or field mapping. These fields are optional.
    Check element display on screen     ${NEW_OFFER_COMPONENT_SEARCH_LOCATION_VALIDATION}
    Check span display  Add Field Mapping
    capture page screenshot

Check UI of Add User Lookup modal
    Check element display on screen     Add User Lookup
    Check label display     User Lookup Label
    Check span display      Please provide the details for this lookup field. The hiring team will be required to make a selection in this field before sending the offer to the candidate.
    Check element display on screen     ${NEW_OFFER_COMPONENT_NAME_INPUT}
    Check common text last display  Additional Fields
    Check span display  Add validation and/or field mapping. These fields are optional.
    Check element display on screen     ${NEW_OFFER_COMPONENT_SEARCH_NAME_VALIDATION}
    Check span display  Add Field Mapping
    capture page screenshot

Check UI of Delete component popup
    Check element display on screen     ${NEW_OFFER_REMOVE_COMPONENT_CONFIRM}
    Check element display on screen     ${NEW_OFFER_CANCEL_REMOVE_COMPONENT}
    Check element display on screen     ${NEW_OFFER_CLOSE_REMOVE_COMPONENT}
    capture page screenshot

Check action delete component of offer
    [Arguments]     ${offer_name}   ${component_name}
    # Check not delete location lookup when click Cancel
    Navigate to offer page  ${offer_name}
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}
    Click at    ${NEW_OFFER_COMPONENT_DELETE_BUTTON}
    Check UI of Delete component popup
    Click at    ${NEW_OFFER_CANCEL_REMOVE_COMPONENT}
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}
    capture page screenshot
    # Check not delete location lookup when click X icon
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}
    Click at    ${NEW_OFFER_COMPONENT_DELETE_BUTTON}
    Click at    ${NEW_OFFER_CLOSE_REMOVE_COMPONENT}
    Click at    ${NEW_OFFER_COMPONENT_CLOSE_ICON}
    Check element display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}
    capture page screenshot
    # Check delete location lookup when click Delete button
    Click at    ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}
    Click at    ${NEW_OFFER_COMPONENT_DELETE_BUTTON}
    Click at    ${NEW_OFFER_REMOVE_COMPONENT_CONFIRM}
    Check element not display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}   wait_time=5s
    capture page screenshot
    Click at    ${NEW_OFFER_CREATE_BUTTON}
    # Check location lookup will remove after delete
    Navigate to offer page  ${offer_name}
    Check element not display on screen     ${NEW_OFFER_COMPONENT_LABEL}    ${component_name}   wait_time=5s
    capture page screenshot

Update user lookup and resend offer
    [Arguments]     ${offer_name}   ${candidate_name}   ${user_name}
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name}
    wait with short time
    Click at    ${OFFER_ICON_CLOSE}
    Simulate Input  ${CONFIRM_OFFER_SELECT_USER_DROPDOWN}   ${user_name}
    Click at    ${CONFIRM_OFFER_SELECT_USER_OPTION}  ${user_name}
    Click at    Update offer

Update location lookup and resend offer
    [Arguments]     ${offer_name}   ${candidate_name}   ${location_name}
    Go to CEM page
    Search and click candidate on CEM   ${candidate_name}
    Click at    ${CEM_OFFERS_ITEM}  ${offer_name}
    wait with short time
    Click at    ${OFFER_ICON_CLOSE}
    Simulate Input  ${CONFIRM_OFFER_SELECT_LOCATION_DROPDOWN}   ${location_name}
    Click at    ${CONFIRM_OFFER_SELECT_LOCATION_OPTION}  ${location_name}
    Click at    Update offer
