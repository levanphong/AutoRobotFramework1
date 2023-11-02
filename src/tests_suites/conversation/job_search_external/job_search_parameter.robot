*** Settings ***
Resource            ../../../drivers/driver_chrome.robot
Resource            ../../../pages/base_page.robot
Resource            ../../../pages/web_management_page.robot
Resource            ../../../pages/phone_number_page.robot
Resource            ../../../pages/location_management_page.robot
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome

*** Variables ***
${landing_site_common}              LandingSiteCommonCheckJobSearchParameter
${widget_common}                    WidgetCommonCheckJobSearchParameter

*** Test Cases ***
Job search parametter will appear for landing site when Job search toggle is ON and start interaction by Capture (OL-T11614)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    Check visible of Job search parametter    True
    Search and delete landing site    ${site_name}


Job search parametter will appear for landing site when Job search toggle is ON and start interaction by CARE (OL-T11615)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    Turn on toggle Knowledge Base
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Check visible of Job search parametter    True
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Search and delete landing site    ${site_name}


Job search parametter will appear for landing site when Job search toggle is ON and start interaction by Job search (OL-T11616)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    Check visible of Job search parametter    True
    Search and delete landing site    ${site_name}


Job search parametter will disappear for landing site when Job search toggle is OFF (OL-T11617)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    go to web management
    Search and click landing site    ${site_name}
    Check visible of Job search parametter    False
    Search and delete landing site    ${site_name}


Job search parametter will appear for widget - catch all conversation when Job search toggle is ON and start interaction by Capture (OL-T11618,OL-T11621,OL-T11622)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Assign Conversation and Care to Widget    Multi Path Standard    ${site_name}    Candidate Care
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    Labels
    Check element display on screen    ${JOB_SEARCH_PARAMETER_LABEL_WIDGET}
    Scroll to element by JS    Here is your javascript snippet. Please place this
    click add attribute button
    input first value attribute    Engineering
    click add attribute button
    input second value attribute    Engineering
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Check element display on screen    select duplicate attribute.
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    Labels
    Check element not display on screen    ${JOB_SEARCH_PARAMETER_LABEL_WIDGET}
    Search and delete landing site    ${site_name}


Job search parametter will appear for widget - catch all conversation when Job search toggle is ON and start interaction by CARE (OL-T11619)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    ${THE_WIDGET_ONLY_APPEAR_LABEL}
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Scroll to element by JS    Labels
    Check element display on screen    ${JOB_SEARCH_PARAMETER_LABEL_WIDGET}
    Search and delete landing site    ${site_name}


Job search parametter will appear for widget - catch all conversation when Job search toggle is ON and start interaction by Job search (OL-T11620)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    check and create landing site/widget site    Widget Conversation    ${widget_common}
    Search and click landing site    ${widget_common}
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    ${THE_WIDGET_ONLY_APPEAR_LABEL}
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    Scroll to element by JS    Labels
    Check element display on screen    ${JOB_SEARCH_PARAMETER_LABEL_WIDGET}


Add a duplicate attributes for widget - catch all conversation when Job search toggle is ON (OL-T11622)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Assign Conversation and Care to Widget    Multi Path Standard    ${site_name}    Candidate Care
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    Labels
    Check element display on screen    ${JOB_SEARCH_PARAMETER_LABEL_WIDGET}
    Scroll to element by JS    Here is your javascript snippet. Please place this
    click add attribute button
    input first value attribute    Sale
    click add attribute button
    input second value attribute    Engineering
    Click at    ${WEB_MANAGEMENT_SAVE_BUTTON}
    Check element display on screen    select duplicate attribute.
    Search and delete landing site    ${site_name}


Job search parametter will appear for widget targeting rule when Job search toggle is ON and start interaction by Capture (OL-T11623)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    check and create landing site/widget site    Widget Conversation    ${widget_common}
    Search and click landing site    ${widget_common}
    Scroll to element by JS    conversation to visitors who
    Click at    ${INPUT_TARGETING_RULE}
    input text    ${INPUT_TARGETING_RULE}    Targeting 1
    Click at    ${BUTTON_ADD_TARGETING_RULE}
    Click at    ${JOB_SEARCH_TOGGLE_ON_MODAL}
    wait for page load successfully
    Check element display on screen    ${JOB_SEARCH_PARAMETER_ON_MODAL}


Job search parametter will appear for widget targeting rule when Job search toggle is ON and start interaction by CARE (OL-T11624)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    check and create landing site/widget site    Widget Conversation    ${widget_common}
    Search and click landing site    ${widget_common}
    Scroll to element by JS    conversation to visitors who
    Scroll to element by JS    conversation to visitors who
    Click at    ${INPUT_TARGETING_RULE}
    input text    ${INPUT_TARGETING_RULE}    Targeting 1
    Click at    ${BUTTON_ADD_TARGETING_RULE}
    Click at    ${JOB_SEARCH_TOGGLE_ON_MODAL}
    wait for page load successfully
    Turn on    ${KNOWLEDGE_BASE_ON_MODAL}
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Check element display on screen    ${JOB_SEARCH_PARAMETER_ON_MODAL}


Add a duplicate attributes for widget targeting rule when Job search toggle is ON (OL-T11625,OL-T11626,OL-T11627)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    check and create landing site/widget site    Widget Conversation    ${widget_common}
    Search and click landing site    ${widget_common}
    Scroll to element by JS    conversation to visitors who
    Click at    ${INPUT_TARGETING_RULE}
    input text    ${INPUT_TARGETING_RULE}    Targeting 1
    Click at    ${BUTTON_ADD_TARGETING_RULE}
    Click at    ${JOB_SEARCH_TOGGLE_ON_MODAL}
    wait for page load successfully
    select from list by label    ${CAPTURE_CONVERSATION_ON_MODAL}    Job Search
    Check element display on screen    ${JOB_SEARCH_PARAMETER_ON_MODAL}
    Click at    ${ADD_ATTRIBUTE_BUTTON_ON_MODAL}
    input first value attribute    Sale
    Click at    ${ADD_ATTRIBUTE_BUTTON_ON_MODAL}
    input second value attribute    Engineering
    Click at    ${SAVE_BUTTON_ON_MODAL}
    Check element display on screen    select duplicate attribute.
    Click at    ${JOB_SEARCH_TOGGLE_ON_MODAL}
    Scroll to element by JS    Labels
    Check element not display on screen    ${JOB_SEARCH_PARAMETER_LABEL_WIDGET}


Job search parametter will appear for phone number when Job search toggle is ON and start interaction by Capture (OL-T11628,OL-T11629,OL-T11630,OL-T11631,OL-T11643,OL-T11644)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Phone number page
    ${area_code} =    set variable    408
    check and generate new phone number    ${area_code}
    Click at    ${CURRENTLY_UNUSED}
    turn on job search toogle on modal phone AI
    attribute session is display
    Click at    ${KNOWLEDEGE_BASE_PHONE_AI}
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    attribute session is display
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    click add attribute button
    Check element display on screen    Limit search to attribute values
    Check element display on screen    Use exact matches for the attribute values entered
    attribute session is display
    turn on job search toogle on modal phone AI
    Check element not display on screen    ${ADD_ATTRIBUTE_PHONE_AI}


Job search parametter will appear for Shortcode Keywords by Location when Job search toggle is ON and start interaction by Capture (OL-T11632,OL-T11633,OL-T11634,OL-T11635)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Phone number page
    Click by JS    Shortcode Keywords
    Check element display on screen    Shortcode Keywords by Location
    turn on job search toogle shortcode
    Scroll to element by JS    Ratings
    Check element display on screen    ${ADD_ATTRIBUTE_PHONE_AI}
    click by js    ${KNOWLEDEGE_BASE_SHORTCODE}
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Check element display on screen    ${ADD_ATTRIBUTE_PHONE_AI}
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    Check element display on screen    ${ADD_ATTRIBUTE_PHONE_AI}
    Click by JS    ${JOB_SEARCH_TOGGLE_SHORTCODE}
    Check element not display on screen    ${ADD_ATTRIBUTE_PHONE_AI}


Limit search to attribute value is added to landing site when Job search toggle is ON (OL-T11636,OL-T11637)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    add 2 job search parameters turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via landing site when Limit search to attribute value is ON and start interaction by Capture conversation (OL-T11638)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Assign Conversation and Care to Widget    AF_widget_single_path    ${site_name}    Candidate Care
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    add 2 job search parameters turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via landing site when Limit search to attribute value is ON and start interaction by Care (OL-T11639)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Search and click landing site    ${landing_site_common}
    Click on toggle Job search    Landing Site
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    add 2 job search parameters turn on limit search


Candidate searches for the job via landing site when Limit search to attribute value is OFF and start interaction by Job search (OL-T11640)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    check and create landing site/widget site    Landing Site    ${landing_site_common}
    Search and click landing site    ${landing_site_common}
    Click on toggle Job search    Landing Site
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    add 2 job search parameters and not turn on limit search


Candidate searches for the job via landing site when Limit search to attribute value is OFF and start interaction by Capture (OL-T11641)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Assign Conversation and Care to Widget    AF_widget_single_path    ${site_name}    Candidate Care
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    add 2 job search parameters and not turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via landing site when Limit search to attribute value is OFF and start interaction by CARE (OL-T11642)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Landing Site
    Search and click landing site    ${site_name}
    Click on toggle Job search    Landing Site
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    add 2 job search parameters and not turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via phone number when Limit search to attribute value is ON and start interaction by Capture Conversation(OL-T11645)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Phone number page
    ${area_code} =    set variable    408
    check and generate new phone number    ${area_code}
    Click at    ${CURRENTLY_UNUSED}
    turn on job search toogle on modal phone AI
    attribute session is display
    Click at    ${KNOWLEDEGE_BASE_PHONE_AI}
    attribute session is display
    Click at    ${ADD_ATTRIBUTE_PHONE_AI}
    Check element display on screen    Limit search to attribute values
    Check element display on screen    Use exact matches for the attribute values entered
    attribute session is display
    turn on job search toogle on modal phone AI
    Check element not display on screen    ${ADD_ATTRIBUTE_PHONE_AI}


Candidate searches for the job via phone number when Limit search to attribute value is ON and start interaction by CARE (OL-T11646)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Phone number page
    ${area_code} =    set variable    408
    check and generate new phone number    ${area_code}
    Click at    ${CURRENTLY_UNUSED}
    turn on job search toogle on modal phone AI
    attribute session is display
    Click at    ${KNOWLEDEGE_BASE_PHONE_AI}
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Click at    ${ADD_ATTRIBUTE_PHONE_AI}
    select attribute by name    Job Description    1
    input first value attribute    Home Sales Inspector
    click add attribute button
    select attribute by name    Job City    2
    turn on 2 toogle limit search
    input second value attribute    South Burlington


Candidate searches for the job via phone number when Limit search to attribute value is OFF and start interaction by Job search (OL-T11647)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Phone number page
    ${area_code} =    set variable    408
    check and generate new phone number    ${area_code}
    Click at    ${CURRENTLY_UNUSED}
    turn on job search toogle on modal phone AI
    attribute session is display
    Click at    ${KNOWLEDEGE_BASE_PHONE_AI}
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    Click at    ${ADD_ATTRIBUTE_PHONE_AI}
    select attribute by name    Job Description    1
    input first value attribute    Home Sales Inspector


Candidate searches for the job via phone number when Limit search to attribute value is OFF and start interaction by Capture Conversation (OL-T11648,OL-T11649)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    Go to Phone number page
    ${area_code} =    set variable    408
    check and generate new phone number    ${area_code}
    Click at    ${CURRENTLY_UNUSED}
    turn on job search toogle on modal phone AI
    attribute session is display
    Click at    ${ADD_ATTRIBUTE_PHONE_AI}
    select attribute by name    Job Description    1
    input first value attribute    Home Sales Inspector
    Click at    ${KNOWLEDEGE_BASE_PHONE_AI}
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care


Limit search to attribute value is added to Shortcode Keywords by Location when Job search toggle is ON (OL-T11650,OL-T11652,OL-T11655)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${location_name} =    set variable    Location_SHORTCODE
    ${shortcode} =    Create a location and get value location SMS keyword    ${COMPANY_APPLICANT_FLOW}    ${location_name}
    Go to Phone number page
    Click at    Shortcode Keywords
    Check element display on screen    Shortcode Keywords by Location
    Check Location SMS keyword is display    ${shortcode}
    turn on job search toogle shortcode
    Scroll to element by JS    Ratings
    Click at    ${ADD_ATTRIBUTE_SHORTCODE}
    select attribute by name    Job Description    1
    ${attribute_1} =    Format String    ${ATTRIBUTE_VALUE}    1
    input text    ${attribute_1}    Home Sales Inspector
    Click at    ${ADD_ATTRIBUTE_SHORTCODE}
    select attribute by name    Job City    2
    turn on 2 toogle limit search
    ${attribute_2} =    format string    ${ATTRIBUTE_VALUE}    2
    input text    ${attribute_2}    South Burlington
    turn on 2 toogle limit search


Limit search to attribute value is added to widget when Job search toggle is ON (OL-T11657,OL-T11659)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    Labels
    add 2 job search parameters turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via widget when Limit search to attribute value is ON for catch-all conversation and start interaction by Job search (OL-T11658)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    Scroll to element by JS    Labels
    add 2 job search parameters turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via widget when Limit search to attribute value is ON for catch all conversation and start interaction by Care (OL-T11660)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Scroll to element by JS    Labels
    add 2 job search parameters turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via widget when Limit search to attribute value is OFF for catch-all conversation and start interaction by Job search (OL-T11661,OL-T11665,OL-T11668)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    select from list by label    ${CAPTURE_CONVERSATION}    Job Search
    Scroll to element by JS    Labels
    add 2 job search parameters and not turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via widget when Limit search to attribute value is OFF for catch-all conversation and start interaction by Capture (OL-T11662,OL-T11666,OL-T11669)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    Scroll to element by JS    Labels
    add 2 job search parameters and not turn on limit search
    Search and delete landing site    ${site_name}


Candidate searches for the job via widget when Limit search to attribute value is OFF and start interaction by CARE (OL-T11663,OL-T11664,OL-T11667,OL-T11670)
    Given Setup test
    when Login into system with company    ${PARADOX_ADMIN}    ${COMPANY_APPLICANT_FLOW}
    ${site_name} =    Create landing site/widget site    Widget Conversation
    Search and click landing site    ${site_name}
    Click on toggle Job search    Widget Conversation
    select from list by label    ${CAPTURE_CONVERSATION}    Candidate Care
    Scroll to element by JS    Labels
    add 2 job search parameters and not turn on limit search
    Search and delete landing site    ${site_name}
